package com.hotel.operacloud.persistence.reservationspecialrequests;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "reservation_special_requests")
@Getter
@Setter
@NoArgsConstructor
public class ReservationSpecialRequestsEntity extends AuditEntity {

    @EmbeddedId
    private ReservationSpecialRequestsId id;

    private String comments;

    @Column(name = "dml_seq_no")
    private Long dmlSeqNo;

    @Column(name = "external_special_id")
    private String externalSpecialId;

    @Column(name = "insert_action_instance_id")
    private Long insertActionInstanceId;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "insert_user")
    private Long insertUser;

    @Column(name = "pre_arrival_dt")
    private String preArrivalDt;

    private String source;

    @Column(name = "update_date")
    private String updateDate;

    @Column(name = "update_user")
    private Long updateUser;
}
