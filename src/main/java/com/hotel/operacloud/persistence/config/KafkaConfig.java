package com.hotel.operacloud.persistence.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.listener.DefaultErrorHandler;
import org.springframework.util.backoff.ExponentialBackOff;

@Slf4j
@Configuration
public class KafkaConfig {

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
            DefaultErrorHandler kafkaErrorHandler) {
        ConcurrentKafkaListenerContainerFactory<String, String> factory =
                new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory);
        factory.setCommonErrorHandler(kafkaErrorHandler);
        return factory;
    }
}
