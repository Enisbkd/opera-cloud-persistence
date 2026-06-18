package com.hotel.operacloud.persistence.name;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "name")
@Getter
@Setter
@NoArgsConstructor
public class NameEntity extends AuditEntity {

    @Id
    @Column(name = "name_id", nullable = false)
    private Long nameId;

    private String last;
    private String sname;
    private String first;
    private String sfirst;
    private String middle;
    private String title;
    private String salutation;
    private String gender;
    private String nationality;
    private String language;

    @Column(name = "birth_country")
    private String birthCountry;

    @Column(name = "birth_place")
    private String birthPlace;

    @Column(name = "name_type")
    private String nameType;

    @Column(name = "name_code")
    private String nameCode;

    private String profession;

    @Column(name = "vip_status")
    private String vipStatus;

    @Column(name = "active_yn")
    private String activeYn;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "anonymization_status")
    private String anonymizationStatus;

    @Column(name = "anonymization_date")
    private String anonymizationDate;

    @Column(name = "bl_msg")
    private String blMsg;

    @Column(name = "cash_bl_ind")
    private String cashBlInd;

    @Column(name = "email_yn")
    private String emailYn;

    @Column(name = "mail_yn")
    private String mailYn;

    @Column(name = "mail_list")
    private String mailList;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "insert_user")
    private Long insertUser;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @Column(name = "update_user")
    private Long updateUser;

    @Column(name = "account_type")
    private String accountType;

    private String accountsource;

    @Column(name = "business_title")
    private String businessTitle;

    private String company;

    @Column(name = "competition_code")
    private String competitionCode;

    @Column(name = "contact_yn")
    private String contactYn;

    private String department;

    @Column(name = "industry_code")
    private String industryCode;

    private String influence;
    private String markets;
    private String priority;

    @Column(name = "rooms_potential")
    private String roomsPotential;

    private String territory;
    private String tracecode;
    private String scope;

    @Column(name = "scope_city")
    private String scopeCity;

    @Column(name = "chain_code")
    private String chainCode;

    @Column(name = "resort_registered")
    private String resortRegistered;

    @Column(name = "last_updated_resort")
    private String lastUpdatedResort;

    @Column(name = "action_code")
    private String actionCode;
}
