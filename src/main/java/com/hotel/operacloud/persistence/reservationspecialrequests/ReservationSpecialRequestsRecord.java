package com.hotel.operacloud.persistence.reservationspecialrequests;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReservationSpecialRequestsRecord {

    private String operation;
    private String resort;
    private Long resvNameId;
    private String specialRequestId;
    private String comments;
    private Long dmlSeqNo;
    private String externalSpecialId;
    private Long insertActionInstanceId;
    private String insertDate;
    private Long insertUser;
    private String preArrivalDt;
    private String source;
    private LocalDateTime updateDate;
    private Long updateUser;
}
