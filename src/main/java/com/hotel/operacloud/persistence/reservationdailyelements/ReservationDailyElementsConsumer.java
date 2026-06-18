package com.hotel.operacloud.persistence.reservationdailyelements;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class ReservationDailyElementsConsumer {

    private final ObjectMapper objectMapper;
    private final ReservationDailyElementsRepository repository;

    @KafkaListener(topics = "${kafka.reservation-daily-elements.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            ReservationDailyElementsRecord record = objectMapper.readValue(message, ReservationDailyElementsRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteByResvNameId(record.getResvNameId());
                log.info("RESERVATION_DAILY_ELEMENTS deleted resvNameId={}", record.getResvNameId());
            } else {
                ReservationDailyElementsId id = new ReservationDailyElementsId(
                        record.getReservationDate(), record.getResort(), record.getResvDailyElSeq());
                Optional<ReservationDailyElementsEntity> existing = repository.findById(id);
                if (existing.isPresent() && existing.get().getUpdateDate() != null && record.getUpdateDate() != null
                        && record.getUpdateDate().isBefore(existing.get().getUpdateDate())) {
                    log.warn("RESERVATION_DAILY_ELEMENTS skipping stale record resort={} date={} seq={}: incoming={} < existing={}",
                            record.getResort(), record.getReservationDate(), record.getResvDailyElSeq(),
                            record.getUpdateDate(), existing.get().getUpdateDate());
                    return;
                }
                repository.save(toEntity(record));
                log.debug("RESERVATION_DAILY_ELEMENTS upserted resort={} date={} seq={}",
                        record.getResort(), record.getReservationDate(), record.getResvDailyElSeq());
            }
        } catch (Exception e) {
            log.error("RESERVATION_DAILY_ELEMENTS consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("RESERVATION_DAILY_ELEMENTS consumer failed", e);
        }
    }

    private ReservationDailyElementsEntity toEntity(ReservationDailyElementsRecord r) {
        ReservationDailyElementsEntity e = new ReservationDailyElementsEntity();
        e.setId(new ReservationDailyElementsId(r.getReservationDate(), r.getResort(), r.getResvDailyElSeq()));
        e.setResvNameId(r.getResvNameId());
        e.setAllotmentHeaderId(r.getAllotmentHeaderId());
        e.setBookedRoomCategory(r.getBookedRoomCategory());
        e.setDueOutYn(r.getDueOutYn());
        e.setMarketCode(r.getMarketCode());
        e.setOriginOfBooking(r.getOriginOfBooking());
        e.setReservationStatus(r.getReservationStatus());
        e.setRoom(r.getRoom());
        e.setRoomCategory(r.getRoomCategory());
        e.setRoomClass(r.getRoomClass());
        e.setOriginalStartDate(r.getOriginalStartDate());
        e.setUpdateDate(r.getUpdateDate());
        e.setPercentage(r.getPercentage());
        e.setTrxCode(r.getTrxCode());
        return e;
    }
}
