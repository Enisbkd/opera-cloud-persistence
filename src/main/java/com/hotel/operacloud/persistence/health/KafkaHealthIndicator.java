package com.hotel.operacloud.persistence.health;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.admin.ListTopicsOptions;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Slf4j
@Component("kafka")
@RequiredArgsConstructor
public class KafkaHealthIndicator implements HealthIndicator {

    private final KafkaAdmin kafkaAdmin;

    @Override
    public Health health() {
        String brokers = String.valueOf(kafkaAdmin.getConfigurationProperties().get("bootstrap.servers"));
        try (AdminClient client = AdminClient.create(kafkaAdmin.getConfigurationProperties())) {
            client.listTopics(new ListTopicsOptions().timeoutMs(3000)).names().get(5, TimeUnit.SECONDS);
            return Health.up()
                    .withDetail("bootstrapServers", brokers)
                    .build();
        } catch (Exception e) {
            log.warn("Kafka health check failed: {}", e.getMessage());
            return Health.down()
                    .withDetail("bootstrapServers", brokers)
                    .withDetail("error", e.getMessage())
                    .build();
        }
    }
}
