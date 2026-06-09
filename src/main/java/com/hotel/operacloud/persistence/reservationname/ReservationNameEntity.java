package com.hotel.operacloud.persistence.reservationname;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "reservation_name")
@Getter
@Setter
@NoArgsConstructor
public class ReservationNameEntity extends AuditEntity {

    @Id
    @Column(name = "resv_name_id", nullable = false)
    private Long resvNameId;

    @Column(name = "begin_date")
    private String beginDate;

    @Column(name = "confirmation_no")
    private String confirmationNo;

    @Column(name = "end_date")
    private String endDate;

    @Column(name = "external_reference")
    private String externalReference;

    @Column(name = "financially_responsible_yn")
    private String financiallyResponsibleYn;

    @Column(name = "folio_close_date")
    private String folioCloseDate;

    @Column(name = "guest_first_name")
    private String guestFirstName;

    @Column(name = "guest_last_name")
    private String guestLastName;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "membership_id")
    private Long membershipId;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "name_usage_type")
    private String nameUsageType;

    @Column(name = "party_code")
    private String partyCode;

    @Column(name = "posting_allowed_yn")
    private String postingAllowedYn;

    private String resort;

    @Column(name = "resv_status")
    private String resvStatus;

    @Column(name = "res_insert_source")
    private String resInsertSource;

    @Column(name = "room_class")
    private String roomClass;

    @Column(name = "sguest_firstname")
    private String sguestFirstname;

    @Column(name = "sguest_name")
    private String sguestName;

    @Column(name = "trunc_begin_date")
    private LocalDate truncBeginDate;

    @Column(name = "trunc_end_date")
    private LocalDate truncEndDate;

    private String udfc16;
    private String udfc22;
}
