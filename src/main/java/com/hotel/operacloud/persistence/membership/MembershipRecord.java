package com.hotel.operacloud.persistence.membership;

import lombok.Data;

@Data
public class MembershipRecord {

    private String operation;
    private Long membershipId;
    private Long nameId;
    private String membershipType;
    private String membershipCardNo;
    private String membershipLevel;
    private String nameOnCard;
    private String chainCode;
    private String joinedDate;
    private String expirationDate;
    private String inactiveDate;
    private String insertDate;
    private String updateDate;
    private Long orderBy;
}
