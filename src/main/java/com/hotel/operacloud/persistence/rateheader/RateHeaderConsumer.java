package com.hotel.operacloud.persistence.rateheader;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Component
@RequiredArgsConstructor
public class RateHeaderConsumer {

    private final ObjectMapper objectMapper;
    private final RateHeaderRepository repository;

    @KafkaListener(topics = "${kafka.rate-header.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        if (message == null) {
            log.warn("RATE_HEADER received null message, skipping");
            return;
        }
        try {
            RateHeaderRecord record = objectMapper.readValue(message, RateHeaderRecord.class);
            RateHeaderId id = new RateHeaderId(record.getResort(), record.getRateCode());

            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(id);
                log.info("RATE_HEADER deleted resort={} rateCode={}", record.getResort(), record.getRateCode());
            } else {
                repository.save(toEntity(record, id));
                log.debug("RATE_HEADER upserted resort={} rateCode={}", record.getResort(), record.getRateCode());
            }
        } catch (Exception e) {
            log.error("RATE_HEADER consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("RATE_HEADER consumer failed", e);
        }
    }

    private RateHeaderEntity toEntity(RateHeaderRecord r, RateHeaderId id) {
        RateHeaderEntity e = new RateHeaderEntity();
        e.setId(id);
        e.setRateCategory(r.getRateCategory());
        e.setDescription(r.getDescription());
        e.setBeginBookingDate(r.getBeginBookingDate());
        e.setEndBookingDate(r.getEndBookingDate());
        e.setYieldableYn(r.getYieldableYn());
        e.setPackageYn(r.getPackageYn());
        e.setFolioText(r.getFolioText());
        e.setInactiveDate(r.getInactiveDate());
        e.setInsertDate(r.getInsertDate());
        e.setUpdateDate(r.getUpdateDate());
        e.setTrxCode(r.getTrxCode());
        return e;
    }
}
