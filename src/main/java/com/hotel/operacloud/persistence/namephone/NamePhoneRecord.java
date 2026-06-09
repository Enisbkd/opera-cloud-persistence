package com.hotel.operacloud.persistence.namephone;

import lombok.Data;

@Data
public class NamePhoneRecord {

    private String operation;
    private Long phoneId;
    private Long nameId;
    private String phoneType;
    private String phoneRole;
    private String phoneNumber;
    private String primaryYn;
    private String defaultConfirmationYn;
    private String emailFormat;
    private String indexPhone;
    private Long displaySeq;
    private String beginDate;
    private String endDate;
    private String inactiveDate;
    private String insertDate;
    private Long insertUser;
    private String updateDate;
    private Long updateUser;
    private Long addressId;
    private Long laptopChange;
}
