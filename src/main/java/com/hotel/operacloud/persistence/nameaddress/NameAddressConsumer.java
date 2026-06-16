package com.hotel.operacloud.persistence.nameaddress;

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
public class NameAddressConsumer {

    private final ObjectMapper objectMapper;
    private final NameAddressRepository repository;

    @KafkaListener(topics = "${kafka.name-address.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            NameAddressRecord record = objectMapper.readValue(message, NameAddressRecord.class);
            if (record.getAddressId() == null) {
                log.warn("NAME_ADDRESS skipping record with null addressId");
                return;
            }
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getAddressId());
                log.info("NAME_ADDRESS deleted addressId={}", record.getAddressId());
            } else {
                repository.save(toEntity(record));
                log.debug("NAME_ADDRESS upserted addressId={}", record.getAddressId());
            }
        } catch (Exception e) {
            log.error("NAME_ADDRESS consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("NAME_ADDRESS consumer failed", e);
        }
    }

    private NameAddressEntity toEntity(NameAddressRecord r) {
        NameAddressEntity e = new NameAddressEntity();
        e.setAddressId(r.getAddressId());
        e.setNameId(r.getNameId());
        e.setAddressType(r.getAddressType());
        e.setAddress1(r.getAddress1());
        e.setAddress2(r.getAddress2());
        e.setAddress3(r.getAddress3());
        e.setAddress4(r.getAddress4());
        e.setCity(r.getCity());
        e.setCityExt(r.getCityExt());
        e.setState(r.getState());
        e.setProvince(r.getProvince());
        e.setPostalCode(r.getPostalCode());
        e.setCountryCode(r.getCountryCode());
        e.setPrimaryYn(r.getPrimaryYn());
        e.setInsertDate(r.getInsertDate());
        e.setInsertUser(r.getInsertUser());
        e.setUpdateDate(r.getUpdateDate());
        e.setUpdateUser(r.getUpdateUser());
        e.setInactiveDate(r.getInactiveDate());
        e.setLastUpdatedResort(r.getLastUpdatedResort());
        return e;
    }
}
