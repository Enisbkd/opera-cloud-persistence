package com.hotel.operacloud.persistence.namephone;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "name_phone")
@Getter
@Setter
@NoArgsConstructor
public class NamePhoneEntity extends AuditEntity {

    @Id
    @Column(name = "phone_id", nullable = false)
    private Long phoneId;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "phone_type")
    private String phoneType;

    @Column(name = "phone_role")
    private String phoneRole;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "primary_yn")
    private String primaryYn;

    @Column(name = "default_confirmation_yn")
    private String defaultConfirmationYn;

    @Column(name = "email_format")
    private String emailFormat;

    @Column(name = "index_phone")
    private String indexPhone;

    @Column(name = "display_seq")
    private Long displaySeq;

    @Column(name = "begin_date")
    private String beginDate;

    @Column(name = "end_date")
    private String endDate;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "insert_user")
    private Long insertUser;

    @Column(name = "update_date")
    private String updateDate;

    @Column(name = "update_user")
    private Long updateUser;

    @Column(name = "address_id")
    private Long addressId;

    @Column(name = "laptop_change")
    private Long laptopChange;
}
