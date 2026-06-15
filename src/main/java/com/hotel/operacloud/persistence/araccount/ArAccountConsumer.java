package com.hotel.operacloud.persistence.araccount;

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
public class ArAccountConsumer {

    private final ObjectMapper objectMapper;
    private final ArAccountRepository repository;

    @KafkaListener(topics = "${kafka.ar-account.input-topic}", groupId = "opera-cloud-persistence")
    @Transactional
    public void consume(@Payload String message) {
        try {
            ArAccountRecord record = objectMapper.readValue(message, ArAccountRecord.class);
            ArAccountId id = new ArAccountId(record.getResort(), record.getAccountCode());

            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(id);
                log.debug("AR_ACCOUNT deleted resort={} accountCode={}", record.getResort(), record.getAccountCode());
            } else {
                repository.save(toEntity(record, id));
                log.debug("AR_ACCOUNT upserted resort={} accountCode={}", record.getResort(), record.getAccountCode());
            }
        } catch (Exception e) {
            log.error("AR_ACCOUNT consumer failed: {}", e.getMessage(), e);
            throw new RuntimeException("AR_ACCOUNT consumer failed", e);
        }
    }

    private ArAccountEntity toEntity(ArAccountRecord r, ArAccountId id) {
        ArAccountEntity e = new ArAccountEntity();
        e.setId(id);
        e.setAccountNo(r.getAccountNo());
        e.setAccountTypeId(r.getAccountTypeId());
        e.setAccountName(r.getAccountName());
        e.setAccountStatus(r.getAccountStatus());
        e.setAccountStatusMsg(r.getAccountStatusMsg());
        e.setAddress1(r.getAddress1());
        e.setAddress2(r.getAddress2());
        e.setAddress3(r.getAddress3());
        e.setAddressId(r.getAddressId());
        e.setBatchStmtYn(r.getBatchStmtYn());
        e.setBalance(r.getBalance());
        e.setCity(r.getCity());
        e.setContact(r.getContact());
        e.setCountry(r.getCountry());
        e.setCreditLimit(r.getCreditLimit());
        e.setEmailAddress(r.getEmailAddress());
        e.setEmailId(r.getEmailId());
        e.setFax(r.getFax());
        e.setFaxId(r.getFaxId());
        e.setInactiveDate(r.getInactiveDate());
        e.setInsertDate(r.getInsertDate());
        e.setLastActivityDate(r.getLastActivityDate());
        e.setLstRemSent(r.getLstRemSent());
        e.setLstRemText(r.getLstRemText());
        e.setLstStmtSent(r.getLstStmtSent());
        e.setNameId(r.getNameId());
        e.setPermAcctYn(r.getPermAcctYn());
        e.setPhone(r.getPhone());
        e.setPhoneId(r.getPhoneId());
        e.setPrimaryYn(r.getPrimaryYn());
        e.setRemarks(r.getRemarks());
        e.setState(r.getState());
        e.setSumCurCode(r.getSumCurCode());
        e.setUpdateDate(r.getUpdateDate());
        e.setZip(r.getZip());
        return e;
    }
}
