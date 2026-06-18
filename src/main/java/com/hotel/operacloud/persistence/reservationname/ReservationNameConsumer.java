package com.hotel.operacloud.persistence.reservationname;

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
public class ReservationNameConsumer {

    private final ObjectMapper objectMapper;
    private final ReservationNameRepository repository;

    @KafkaListener(topics = "${kafka.reservation-name.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            ReservationNameRecord record = objectMapper.readValue(message, ReservationNameRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getResvNameId());
                log.info("RESERVATION_NAME deleted resvNameId={}", record.getResvNameId());
            } else {
                Optional<ReservationNameEntity> existing = repository.findById(record.getResvNameId());
                if (existing.isPresent() && existing.get().getUpdateDate() != null && record.getUpdateDate() != null
                        && record.getUpdateDate().isBefore(existing.get().getUpdateDate())) {
                    log.warn("RESERVATION_NAME skipping stale record resvNameId={}: incoming={} < existing={}",
                            record.getResvNameId(), record.getUpdateDate(), existing.get().getUpdateDate());
                    return;
                }
                repository.save(toEntity(record));
                log.debug("RESERVATION_NAME upserted resvNameId={}", record.getResvNameId());
            }
        } catch (Exception e) {
            log.error("RESERVATION_NAME consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("RESERVATION_NAME consumer failed", e);
        }
    }

    private ReservationNameEntity toEntity(ReservationNameRecord r) {
        ReservationNameEntity e = new ReservationNameEntity();
        e.setResvNameId(r.getResvNameId());
        e.setBeginDate(r.getBeginDate());
        e.setConfirmationNo(r.getConfirmationNo());
        e.setEndDate(r.getEndDate());
        e.setExternalReference(r.getExternalReference());
        e.setFinanciallyResponsibleYn(r.getFinanciallyResponsibleYn());
        e.setFolioCloseDate(r.getFolioCloseDate());
        e.setGuestFirstName(r.getGuestFirstName());
        e.setGuestLastName(r.getGuestLastName());
        e.setInsertDate(r.getInsertDate());
        e.setUpdateDate(r.getUpdateDate());
        e.setMembershipId(r.getMembershipId());
        e.setNameId(r.getNameId());
        e.setNameUsageType(r.getNameUsageType());
        e.setPartyCode(r.getPartyCode());
        e.setPostingAllowedYn(r.getPostingAllowedYn());
        e.setResort(r.getResort());
        e.setResvStatus(r.getResvStatus());
        e.setResInsertSource(r.getResInsertSource());
        e.setRoomClass(r.getRoomClass());
        e.setSguestFirstname(r.getSguestFirstname());
        e.setSguestName(r.getSguestName());
        e.setTruncBeginDate(r.getTruncBeginDate());
        e.setTruncEndDate(r.getTruncEndDate());
        e.setUdfc16(r.getUdfc16());
        e.setUdfc22(r.getUdfc22());
        return e;
    }
}
