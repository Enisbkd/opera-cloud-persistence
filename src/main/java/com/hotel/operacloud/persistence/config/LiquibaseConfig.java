package com.hotel.operacloud.persistence.config;

import liquibase.integration.spring.SpringLiquibase;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class LiquibaseConfig {

    @Bean
    public SpringLiquibase liquibase(
            DataSource dataSource,
            @Value("${spring.liquibase.default-schema}") String defaultSchema) {
        SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setDataSource(dataSource);
        liquibase.setChangeLog("classpath:db/changelog/db.changelog-master.xml");
        liquibase.setDefaultSchema(defaultSchema);
        liquibase.setLiquibaseSchema(defaultSchema);
        liquibase.setShouldRun(true);
        liquibase.setAnalyticsEnabled(false);
        return liquibase;
    }
}
