package com.hotel.operacloud.persistence.membership;

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
public class MembershipConsumer {

    private final ObjectMapper objectMapper;
    private final MembershipRepository repository;

    @KafkaListener(topics = "${kafka.membership.input-topic}", groupId = "opera-cloud-persistence")
    @Transactional
    public void consume(@Payload String message) {
        try {
            MembershipRecord record = objectMapper.readValue(message, MembershipRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getMembershipId());
                log.debug("MEMBERSHIP deleted membershipId={}", record.getMembershipId());
            } else {
                repository.save(toEntity(record));
                log.debug("MEMBERSHIP upserted membershipId={}", record.getMembershipId());
            }
        } catch (Exception e) {
            log.error("MEMBERSHIP consumer failed: {}", e.getMessage(), e);
            throw new RuntimeException("MEMBERSHIP consumer failed", e);
        }
    }

    private MembershipEntity toEntity(MembershipRecord r) {
        MembershipEntity e = new MembershipEntity();
        e.setMembershipId(r.getMembershipId());
        e.setNameId(r.getNameId());
        e.setMembershipType(r.getMembershipType());
        e.setMembershipCardNo(r.getMembershipCardNo());
        e.setMembershipLevel(r.getMembershipLevel());
        e.setNameOnCard(r.getNameOnCard());
        e.setChainCode(r.getChainCode());
        e.setJoinedDate(r.getJoinedDate());
        e.setExpirationDate(r.getExpirationDate());
        e.setInactiveDate(r.getInactiveDate());
        e.setInsertDate(r.getInsertDate());
        e.setUpdateDate(r.getUpdateDate());
        e.setOrderBy(r.getOrderBy());
        return e;
    }
}
