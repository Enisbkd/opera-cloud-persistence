package com.hotel.operacloud.persistence.namephone;

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
public class NamePhoneConsumer {

    private final ObjectMapper objectMapper;
    private final NamePhoneRepository repository;

    @KafkaListener(topics = "${kafka.name-phone.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            NamePhoneRecord record = objectMapper.readValue(message, NamePhoneRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getPhoneId());
                log.info("NAME_PHONE deleted phoneId={}", record.getPhoneId());
            } else {
                repository.save(toEntity(record));
                log.debug("NAME_PHONE upserted phoneId={}", record.getPhoneId());
            }
        } catch (Exception e) {
            log.error("NAME_PHONE consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("NAME_PHONE consumer failed", e);
        }
    }

    private NamePhoneEntity toEntity(NamePhoneRecord r) {
        NamePhoneEntity e = new NamePhoneEntity();
        e.setPhoneId(r.getPhoneId());
        e.setNameId(r.getNameId());
        e.setPhoneType(r.getPhoneType());
        e.setPhoneRole(r.getPhoneRole());
        e.setPhoneNumber(r.getPhoneNumber());
        e.setPrimaryYn(r.getPrimaryYn());
        e.setDefaultConfirmationYn(r.getDefaultConfirmationYn());
        e.setEmailFormat(r.getEmailFormat());
        e.setIndexPhone(r.getIndexPhone());
        e.setDisplaySeq(r.getDisplaySeq());
        e.setBeginDate(r.getBeginDate());
        e.setEndDate(r.getEndDate());
        e.setInactiveDate(r.getInactiveDate());
        e.setInsertDate(r.getInsertDate());
        e.setInsertUser(r.getInsertUser());
        e.setUpdateDate(r.getUpdateDate());
        e.setUpdateUser(r.getUpdateUser());
        e.setAddressId(r.getAddressId());
        e.setLaptopChange(r.getLaptopChange());
        return e;
    }
}
