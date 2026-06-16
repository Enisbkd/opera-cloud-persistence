package com.hotel.operacloud.persistence.foliotax;

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
public class FolioTaxConsumer {

    private final ObjectMapper objectMapper;
    private final FolioTaxRepository repository;

    @KafkaListener(topics = "${kafka.folio-tax.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            FolioTaxRecord record = objectMapper.readValue(message, FolioTaxRecord.class);

            if (record.getResort() == null || record.getResvNameId() == null) {
                log.warn("FOLIO_TAX skipping record with null resort or resvNameId");
                return;
            }

            FolioTaxId id = new FolioTaxId(record.getResort(), record.getResvNameId(), record.getFolioView());

            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(id);
                log.info("FOLIO_TAX deleted resort={} resvNameId={} folioView={}",
                        record.getResort(), record.getResvNameId(), record.getFolioView());
            } else {
                repository.save(toEntity(record, id));
                log.debug("FOLIO_TAX upserted resort={} resvNameId={} folioView={}",
                        record.getResort(), record.getResvNameId(), record.getFolioView());
            }
        } catch (Exception e) {
            log.error("FOLIO_TAX consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("FOLIO_TAX consumer failed", e);
        }
    }

    private FolioTaxEntity toEntity(FolioTaxRecord r, FolioTaxId id) {
        FolioTaxEntity e = new FolioTaxEntity();
        e.setId(id);
        e.setPayeeNameId(r.getPayeeNameId());
        return e;
    }
}
