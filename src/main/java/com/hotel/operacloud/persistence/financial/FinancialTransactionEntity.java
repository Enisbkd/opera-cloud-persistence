package com.hotel.operacloud.persistence.financial;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "financial_transactions")
@Getter
@Setter
@NoArgsConstructor
public class FinancialTransactionEntity extends AuditEntity {

    @Id
    @Column(name = "trx_no", nullable = false)
    private Long trxNo;

    @Column(name = "ar_led_credit")
    private BigDecimal arLedCredit;

    @Column(name = "ar_led_debit")
    private BigDecimal arLedDebit;

    @Column(name = "ar_state")
    private String arState;

    @Column(name = "arrangement_id")
    private Long arrangementId;

    @Column(name = "bill_no")
    private Long billNo;

    @Column(name = "business_date")
    private LocalDate businessDate;

    @Column(name = "cashier_credit")
    private BigDecimal cashierCredit;

    @Column(name = "cashier_debit")
    private BigDecimal cashierDebit;

    @Column(name = "cashier_id")
    private Long cashierId;

    @Column(name = "cheque_number")
    private String chequeNumber;

    private String currency;

    @Column(name = "dep_led_credit")
    private BigDecimal depLedCredit;

    @Column(name = "dep_led_debit")
    private BigDecimal depLedDebit;

    @Column(name = "exchange_rate")
    private BigDecimal exchangeRate;

    @Column(name = "fin_dml_seq_no")
    private Long finDmlSeqNo;

    @Column(name = "folio_no")
    private Long folioNo;

    @Column(name = "folio_type")
    private String folioType;

    @Column(name = "folio_view")
    private Long folioView;

    @Column(name = "from_resv_id")
    private Long fromResvId;

    @Column(name = "ft_subtype")
    private String ftSubtype;

    @Column(name = "gross_amount")
    private BigDecimal grossAmount;

    @Column(name = "guest_account_credit")
    private BigDecimal guestAccountCredit;

    @Column(name = "guest_account_debit")
    private BigDecimal guestAccountDebit;

    @Column(name = "insert_date")
    private LocalDateTime insertDate;

    @Column(name = "insert_user")
    private Long insertUser;

    @Column(name = "invoice_close_date")
    private LocalDate invoiceCloseDate;

    @Column(name = "invoice_no")
    private Long invoiceNo;

    @Column(name = "invoice_type")
    private String invoiceType;

    @Column(name = "market_code")
    private String marketCode;

    @Column(name = "membership_id")
    private Long membershipId;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "net_amount")
    private BigDecimal netAmount;

    @Column(name = "number_dialed")
    private String numberDialed;

    @Column(name = "org_posted_amount")
    private BigDecimal orgPostedAmount;

    @Column(name = "original_resv_name_id")
    private Long originalResvNameId;

    @Column(name = "package_allowance")
    private BigDecimal packageAllowance;

    @Column(name = "package_arrangement_code")
    private String packageArrangementCode;

    @Column(name = "package_credit")
    private BigDecimal packageCredit;

    @Column(name = "package_debit")
    private BigDecimal packageDebit;

    @Column(name = "posted_amount")
    private BigDecimal postedAmount;

    @Column(name = "posting_date")
    private LocalDate postingDate;

    @Column(name = "posting_type")
    private String postingType;

    @Column(name = "price_per_unit")
    private BigDecimal pricePerUnit;

    private BigDecimal quantity;

    @Column(name = "rate_code")
    private String rateCode;

    @Column(name = "receipt_no")
    private Long receiptNo;

    @Column(name = "receipt_type")
    private String receiptType;

    private String reference;
    private String remark;
    private String resort;

    @Column(name = "resv_name_id")
    private Long resvNameId;

    @Column(name = "revenue_amt")
    private BigDecimal revenueAmt;

    private String room;

    @Column(name = "room_class")
    private String roomClass;

    @Column(name = "routing_instrn_id")
    private Long routingInstrnId;

    @Column(name = "source_code")
    private String sourceCode;

    @Column(name = "ta_commissionable_yn")
    private String taCommissionableYn;

    @Column(name = "target_resort")
    private String targetResort;

    @Column(name = "tax_generated_yn")
    private String taxGeneratedYn;

    @Column(name = "tax_inclusive_yn")
    private String taxInclusiveYn;

    @Column(name = "tc_group")
    private String tcGroup;

    @Column(name = "tc_subgroup")
    private String tcSubgroup;

    @Column(name = "tran_action_id")
    private Long tranActionId;

    @Column(name = "trx_amount")
    private BigDecimal trxAmount;

    @Column(name = "trx_code")
    private String trxCode;

    @Column(name = "trx_date")
    private LocalDate trxDate;

    @Column(name = "trx_no_added_by")
    private Long trxNoAddedBy;

    @Column(name = "trx_no_adjust")
    private Long trxNoAdjust;

    @Column(name = "trx_no_against_package")
    private Long trxNoAgainstPackage;

    @Column(name = "trx_no_split")
    private Long trxNoSplit;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @Column(name = "update_user")
    private Long updateUser;

    @Column(name = "cashier_opening_balance")
    private BigDecimal cashierOpeningBalance;

    @Column(name = "hotel_acct")
    private String hotelAcct;

    @Column(name = "original_room")
    private String originalRoom;

    @Column(name = "resv_deposit_id")
    private Long resvDepositId;

    @Column(name = "source_commission_net_yn")
    private String sourceCommissionNetYn;

    @Column(name = "to_resv_name_id")
    private Long toResvNameId;

    @Column(name = "trx_no_header")
    private Long trxNoHeader;

    @Column(name = "package_trx_type")
    private String packageTrxType;

    @Column(name = "ta_commission_net_yn")
    private String taCommissionNetYn;
}
