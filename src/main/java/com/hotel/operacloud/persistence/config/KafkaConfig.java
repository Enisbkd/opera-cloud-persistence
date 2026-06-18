package com.hotel.operacloud.persistence.config;

import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Timer;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.admin.AdminClientConfig;
import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaConsumerFactory;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.kafka.listener.DefaultErrorHandler;
import org.springframework.kafka.listener.RecordInterceptor;
import org.springframework.util.backoff.ExponentialBackOff;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Configuration
public class KafkaConfig {

    @Bean
    public KafkaAdmin kafkaAdmin(@Value("${spring.kafka.bootstrap-servers}") String bootstrapServers) {
        Map<String, Object> configs = new HashMap<>();
        configs.put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        configs.put(AdminClientConfig.REQUEST_TIMEOUT_MS_CONFIG, "5000");
        configs.put(AdminClientConfig.DEFAULT_API_TIMEOUT_MS_CONFIG, "5000");
        return new KafkaAdmin(configs);
    }

    @Bean
    public ConsumerFactory<String, String> consumerFactory(
            @Value("${spring.kafka.bootstrap-servers}") String bootstrapServers,
            @Value("${spring.kafka.consumer.group-id}") String groupId,
            @Value("${spring.kafka.consumer.auto-offset-reset:earliest}") String autoOffsetReset) {
        Map<String, Object> props = new HashMap<>();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(ConsumerConfig.GROUP_ID_CONFIG, groupId);
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, autoOffsetReset);
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, false);
        return new DefaultKafkaConsumerFactory<>(props, new StringDeserializer(), new StringDeserializer());
    }

    @Bean
    public RecordInterceptor<String, String> persistenceMetricsInterceptor(MeterRegistry meterRegistry) {
        Map<ConsumerRecord<String, String>, Timer.Sample> samples = new ConcurrentHashMap<>();
        return new RecordInterceptor<>() {
            @Override
            public ConsumerRecord<String, String> intercept(ConsumerRecord<String, String> record,
                                                            Consumer<String, String> consumer) {
                meterRegistry.counter("opera.persistence.records.consumed",
                        "topic", record.topic()).increment();
                samples.put(record, Timer.start(meterRegistry));
                return record;
            }

            @Override
            public void success(ConsumerRecord<String, String> record, Consumer<String, String> consumer) {
                meterRegistry.counter("opera.persistence.records.success",
                        "topic", record.topic()).increment();
                Timer.Sample sample = samples.remove(record);
                if (sample != null) {
                    sample.stop(Timer.builder("opera.persistence.records.processing_time")
                            .tag("topic", record.topic())
                            .register(meterRegistry));
                }
            }

            @Override
            public void failure(ConsumerRecord<String, String> record, Exception exception,
                                Consumer<String, String> consumer) {
                meterRegistry.counter("opera.persistence.records.errors",
                        "topic", record.topic()).increment();
                samples.remove(record);
                log.error("Record processing failed: topic={} partition={} offset={}: {}",
                        record.topic(), record.partition(), record.offset(), exception.getMessage());
            }
        };
    }

    @Bean
    public DefaultErrorHandler kafkaErrorHandler() {
        ExponentialBackOff backOff = new ExponentialBackOff(1_000L, 2.0);
        backOff.setMaxAttempts(3);
        return new DefaultErrorHandler(
                (record, exception) -> log.error(
                        "Skipping message after retries exhausted: topic={} partition={} offset={}: {}",
                        record.topic(), record.partition(), record.offset(), exception.getMessage()),
                backOff);
    }

    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, String> kafkaListenerContainerFactory(
            ConsumerFactory<String, String> consumerFactory,
            DefaultErrorHandler kafkaErrorHandler,
            RecordInterceptor<String, String> persistenceMetricsInterceptor) {
        ConcurrentKafkaListenerContainerFactory<String, String> factory =
                new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory);
        factory.setCommonErrorHandler(kafkaErrorHandler);
        factory.setRecordInterceptor(persistenceMetricsInterceptor);
        factory.getContainerProperties().setMissingTopicsFatal(false);
        return factory;
    }
}
