package com.hotel.operacloud.persistence;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.annotation.EnableKafka;

@SpringBootApplication
@EnableKafka
public class OperaCloudPersistenceApplication {

    public static void main(String[] args) {
        SpringApplication.run(OperaCloudPersistenceApplication.class, args);
    }
}
