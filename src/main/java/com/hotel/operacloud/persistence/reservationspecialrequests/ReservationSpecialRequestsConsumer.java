package com.hotel.operacloud.persistence.reservationspecialrequests;

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
public class ReservationSpecialRequestsConsumer {

    private final ObjectMapper objectMapper;
    private final ReservationSpecialRequestsRepository repository;

    @KafkaListener(topics = "${kafka.reservation-special-requests.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            ReservationSpecialRequestsRecord record =
                    objectMapper.readValue(message, ReservationSpecialRequestsRecord.class);
            if (record.getSpecialRequestId() == null || record.getResvNameId() == null || record.getResort() == null) {
                log.warn("RESERVATION_SPECIAL_REQUESTS skipping record with null key fields (resort/resvNameId/specialRequestId)");
                return;
            }
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteByResvNameId(record.getResvNameId());
                log.info("RESERVATION_SPECIAL_REQUESTS deleted resvNameId={}", record.getResvNameId());
            } else {
                repository.save(toEntity(record));
                log.debug("RESERVATION_SPECIAL_REQUESTS upserted resort={} resvNameId={} specialRequestId={}",
                        record.getResort(), record.getResvNameId(), record.getSpecialRequestId());
            }
        } catch (Exception e) {
            log.error("RESERVATION_SPECIAL_REQUESTS consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("RESERVATION_SPECIAL_REQUESTS consumer failed", e);
        }
    }

    private ReservationSpecialRequestsEntity toEntity(ReservationSpecialRequestsRecord r) {
        ReservationSpecialRequestsEntity e = new ReservationSpecialRequestsEntity();
        e.setId(new ReservationSpecialRequestsId(r.getResort(), r.getResvNameId(), r.getSpecialRequestId()));

        e.setComments(r.getComments());
        e.setDmlSeqNo(r.getDmlSeqNo());
        e.setExternalSpecialId(r.getExternalSpecialId());
        e.setInsertActionInstanceId(r.getInsertActionInstanceId());
        e.setInsertDate(r.getInsertDate());
        e.setInsertUser(r.getInsertUser());
        e.setPreArrivalDt(r.getPreArrivalDt());
        e.setSource(r.getSource());
        e.setUpdateDate(r.getUpdateDate());
        e.setUpdateUser(r.getUpdateUser());
        return e;
    }
}
