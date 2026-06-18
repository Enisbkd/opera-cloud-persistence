package com.hotel.operacloud.persistence.rateheader;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class RateHeaderRecord {
    private String operation;
    private String resort;
    private String rateCode;
    private String rateCategory;
    private String description;
    private String beginBookingDate;
    private String endBookingDate;
    private String yieldableYn;
    private String packageYn;
    private String folioText;
    private String inactiveDate;
    private String insertDate;
    private LocalDateTime updateDate;
    private String trxCode;
}
