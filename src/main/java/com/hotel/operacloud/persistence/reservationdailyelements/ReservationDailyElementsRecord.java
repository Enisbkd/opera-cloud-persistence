package com.hotel.operacloud.persistence.reservationdailyelements;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ReservationDailyElementsRecord {

    private String operation;
    private LocalDate reservationDate;
    private String resort;
    private Long resvDailyElSeq;
    private Long resvNameId;
    private Long allotmentHeaderId;
    private String bookedRoomCategory;
    private String dueOutYn;
    private String marketCode;
    private String originOfBooking;
    private String reservationStatus;
    private String room;
    private String roomCategory;
    private String roomClass;
    private LocalDate originalStartDate;
    private String updateDate;
    private BigDecimal percentage;
    private String trxCode;
}
