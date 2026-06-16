package com.hotel.operacloud.persistence.health;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.Status;
import org.springframework.boot.info.BuildProperties;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class StatusController {

    private final KafkaHealthIndicator kafkaHealthIndicator;
    private final JdbcTemplate jdbcTemplate;
    private final Optional<BuildProperties> buildProperties;

    @GetMapping("/status")
    public ResponseEntity<Map<String, Object>> status() {
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("service", "opera-cloud-persistence");
        response.put("timestamp", LocalDateTime.now().toString());
        buildProperties.ifPresent(bp -> response.put("version", bp.getVersion()));

        Map<String, Object> health = new LinkedHashMap<>();
        health.put("database", checkDatabase());
        health.put("kafka", checkKafka());
        response.put("health", health);

        boolean allUp = health.values().stream().allMatch("UP"::equals);
        response.put("status", allUp ? "UP" : "DEGRADED");

        return allUp ? ResponseEntity.ok(response) : ResponseEntity.status(503).body(response);
    }

    @GetMapping("/health/kafka")
    public ResponseEntity<Map<String, Object>> kafkaHealth() {
        Health health = kafkaHealthIndicator.health();
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("status", health.getStatus().getCode());
        response.putAll(health.getDetails());
        return health.getStatus() == Status.UP
                ? ResponseEntity.ok(response)
                : ResponseEntity.status(503).body(response);
    }

    @GetMapping("/health/database")
    public ResponseEntity<Map<String, Object>> databaseHealth() {
        Map<String, Object> response = new LinkedHashMap<>();
        String dbStatus = checkDatabase();
        response.put("status", dbStatus);
        return "UP".equals(dbStatus)
                ? ResponseEntity.ok(response)
                : ResponseEntity.status(503).body(response);
    }

    private String checkDatabase() {
        try {
            jdbcTemplate.queryForObject("SELECT 1 FROM DUAL", Integer.class);
            return "UP";
        } catch (Exception e) {
            return "DOWN";
        }
    }

    private String checkKafka() {
        try {
            Health health = kafkaHealthIndicator.health();
            return health.getStatus() == Status.UP ? "UP" : "DOWN";
        } catch (Exception e) {
            return "DOWN";
        }
    }
}
