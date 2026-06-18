package com.hotel.operacloud.persistence.trxcodes;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class TrxCodesRecord {

    private String operation;

    private String resort;
    private String trxCode;
    private String description;
    private String tcGroup;
    private String tcSubgroup;
    private String tcTransactionType;
    private BigDecimal taxCodeNo;
    private String trxCodeType;
    private String indRevenueGp;
    private LocalDateTime updateDate;
}
