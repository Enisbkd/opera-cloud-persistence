package com.hotel.operacloud.persistence.araccount;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.math.BigDecimal;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ArAccountRecord {

    private String operation;

    private String resort;
    private Long accountCode;
    private String accountNo;
    private Long accountTypeId;
    private String accountName;
    private String accountStatus;
    private String accountStatusMsg;
    private String address1;
    private String address2;
    private String address3;
    private Long addressId;
    private String batchStmtYn;
    private BigDecimal balance;
    private String city;
    private String contact;
    private String country;
    private BigDecimal creditLimit;
    private String emailAddress;
    private Long emailId;
    private String fax;
    private Long faxId;
    private String inactiveDate;
    private String insertDate;
    private String lastActivityDate;
    private String lstRemSent;
    private String lstRemText;
    private String lstStmtSent;
    private Long nameId;
    private String permAcctYn;
    private String phone;
    private Long phoneId;
    private String primaryYn;
    private String remarks;
    private String state;
    private String sumCurCode;
    private String updateDate;
    private String zip;
}
