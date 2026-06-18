package com.hotel.operacloud.persistence.reservationdailyelementname;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ReservationDailyElementNameRecord {

    private String operation;
    private String resort;
    private Long resvNameId;
    private LocalDate reservationDate;
    private Long adults;
    private Long children;
    private Long companyId;
    private String rateCode;
    private Long resvContactId;
    private String sourceId;
    private Long travelAgentId;
    private Long resvDailyElSeq;
    private BigDecimal shareAmountOriginal;
    private String tcGroup;
    private String tcSubgroup;
    private String trxCode;
    private String updateDate;
}
