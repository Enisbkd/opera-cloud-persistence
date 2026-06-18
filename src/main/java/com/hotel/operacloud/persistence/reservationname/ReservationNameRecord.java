package com.hotel.operacloud.persistence.reservationname;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ReservationNameRecord {

    private String operation;
    private Long resvNameId;
    private String beginDate;
    private String confirmationNo;
    private String endDate;
    private String externalReference;
    private String financiallyResponsibleYn;
    private String folioCloseDate;
    private String guestFirstName;
    private String guestLastName;
    private String insertDate;
    private String updateDate;
    private Long membershipId;
    private Long nameId;
    private String nameUsageType;
    private String partyCode;
    private String postingAllowedYn;
    private String resort;
    private String resvStatus;
    private String resInsertSource;
    private String roomClass;
    private String sguestFirstname;
    private String sguestName;
    private LocalDate truncBeginDate;
    private LocalDate truncEndDate;
    private String udfc16;
    private String udfc22;
}
