package com.hotel.operacloud.persistence.trxcodes;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class TrxCodesConsumer {

    private final ObjectMapper objectMapper;
    private final TrxCodesRepository repository;

    @KafkaListener(topics = "${kafka.trx-codes.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            TrxCodesRecord record = objectMapper.readValue(message, TrxCodesRecord.class);
            TrxCodesId id = new TrxCodesId(record.getResort(), record.getTrxCode());

            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(id);
                log.info("TRX_CODES deleted resort={} trxCode={}", record.getResort(), record.getTrxCode());
            } else {
                Optional<TrxCodesEntity> existing = repository.findById(id);
                if (existing.isPresent() && existing.get().getUpdateDate() != null && record.getUpdateDate() != null
                        && record.getUpdateDate().isBefore(existing.get().getUpdateDate())) {
                    log.warn("TRX_CODES skipping stale record resort={} trxCode={}: incoming={} < existing={}",
                            record.getResort(), record.getTrxCode(),
                            record.getUpdateDate(), existing.get().getUpdateDate());
                    return;
                }
                repository.save(toEntity(record, id));
                log.debug("TRX_CODES upserted resort={} trxCode={}", record.getResort(), record.getTrxCode());
            }
        } catch (Exception e) {
            log.error("TRX_CODES consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("TRX_CODES consumer failed", e);
        }
    }

    private TrxCodesEntity toEntity(TrxCodesRecord r, TrxCodesId id) {
        TrxCodesEntity e = new TrxCodesEntity();
        e.setId(id);
        e.setDescription(r.getDescription());
        e.setTcGroup(r.getTcGroup());
        e.setTcSubgroup(r.getTcSubgroup());
        e.setTcTransactionType(r.getTcTransactionType());
        e.setTaxCodeNo(r.getTaxCodeNo());
        e.setTrxCodeType(r.getTrxCodeType());
        e.setIndRevenueGp(r.getIndRevenueGp());
        e.setUpdateDate(r.getUpdateDate());
        return e;
    }
}
