package com.hotel.operacloud.persistence.reservationdailyelementname;

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
public class ReservationDailyElementNameConsumer {

    private final ObjectMapper objectMapper;
    private final ReservationDailyElementNameRepository repository;

    @KafkaListener(topics = "${kafka.reservation-daily-element-name.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            ReservationDailyElementNameRecord record =
                    objectMapper.readValue(message, ReservationDailyElementNameRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteByResvNameId(record.getResvNameId());
                log.info("RESERVATION_DAILY_ELEMENT_NAME deleted resvNameId={}", record.getResvNameId());
            } else {
                repository.save(toEntity(record));
                log.debug("RESERVATION_DAILY_ELEMENT_NAME upserted resort={} resvNameId={} date={}",
                        record.getResort(), record.getResvNameId(), record.getReservationDate());
            }
        } catch (Exception e) {
            log.error("RESERVATION_DAILY_ELEMENT_NAME consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("RESERVATION_DAILY_ELEMENT_NAME consumer failed", e);
        }
    }

    private ReservationDailyElementNameEntity toEntity(ReservationDailyElementNameRecord r) {
        ReservationDailyElementNameEntity e = new ReservationDailyElementNameEntity();
        e.setId(new ReservationDailyElementNameId(r.getResort(), r.getResvNameId(), r.getReservationDate()));
        e.setAdults(r.getAdults());
        e.setChildren(r.getChildren());
        e.setCompanyId(r.getCompanyId());
        e.setRateCode(r.getRateCode());
        e.setResvContactId(r.getResvContactId());
        e.setSourceId(r.getSourceId());
        e.setTravelAgentId(r.getTravelAgentId());
        e.setResvDailyElSeq(r.getResvDailyElSeq());
        e.setShareAmountOriginal(r.getShareAmountOriginal());
        e.setTcGroup(r.getTcGroup());
        e.setTcSubgroup(r.getTcSubgroup());
        e.setTrxCode(r.getTrxCode());
        e.setUpdateDate(r.getUpdateDate());
        return e;
    }
}
