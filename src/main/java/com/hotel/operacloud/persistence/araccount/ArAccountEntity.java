package com.hotel.operacloud.persistence.araccount;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "ar_account")
@Getter
@Setter
@NoArgsConstructor
public class ArAccountEntity extends AuditEntity {

    @EmbeddedId
    private ArAccountId id;

    @Column(name = "account_no")
    private String accountNo;

    @Column(name = "account_type_id")
    private Long accountTypeId;

    @Column(name = "account_name")
    private String accountName;

    @Column(name = "account_status")
    private String accountStatus;

    @Column(name = "account_status_msg")
    private String accountStatusMsg;

    @Column(name = "address1")
    private String address1;

    @Column(name = "address2")
    private String address2;

    @Column(name = "address3")
    private String address3;

    @Column(name = "address_id")
    private Long addressId;

    @Column(name = "batch_stmt_yn")
    private String batchStmtYn;

    @Column(name = "balance")
    private BigDecimal balance;

    @Column(name = "city")
    private String city;

    @Column(name = "contact")
    private String contact;

    @Column(name = "country")
    private String country;

    @Column(name = "credit_limit")
    private BigDecimal creditLimit;

    @Column(name = "email_address")
    private String emailAddress;

    @Column(name = "email_id")
    private Long emailId;

    @Column(name = "fax")
    private String fax;

    @Column(name = "fax_id")
    private Long faxId;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "last_activity_date")
    private String lastActivityDate;

    @Column(name = "lst_rem_sent")
    private String lstRemSent;

    @Column(name = "lst_rem_text")
    private String lstRemText;

    @Column(name = "lst_stmt_sent")
    private String lstStmtSent;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "perm_acct_yn")
    private String permAcctYn;

    @Column(name = "phone")
    private String phone;

    @Column(name = "phone_id")
    private Long phoneId;

    @Column(name = "primary_yn")
    private String primaryYn;

    @Column(name = "remarks")
    private String remarks;

    @Column(name = "state")
    private String state;

    @Column(name = "sum_cur_code")
    private String sumCurCode;

    @Column(name = "update_date")
    private String updateDate;

    @Column(name = "zip")
    private String zip;
}
