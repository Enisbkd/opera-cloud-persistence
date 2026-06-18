package com.hotel.operacloud.persistence.nameaddress;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class NameAddressRecord {

    private String operation;
    private Long addressId;
    private Long nameId;
    private String addressType;
    private String address1;
    private String address2;
    private String address3;
    private String address4;
    private String city;
    private String cityExt;
    private String state;
    private String province;
    private String postalCode;
    private String countryCode;
    private String primaryYn;
    private String insertDate;
    private Long insertUser;
    private LocalDateTime updateDate;
    private Long updateUser;
    private String inactiveDate;
    private String lastUpdatedResort;
}
