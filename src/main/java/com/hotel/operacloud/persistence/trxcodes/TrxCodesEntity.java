package com.hotel.operacloud.persistence.trxcodes;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "trx_codes")
@Getter
@Setter
@NoArgsConstructor
public class TrxCodesEntity extends AuditEntity {

    @EmbeddedId
    private TrxCodesId id;

    @Column(name = "description")
    private String description;

    @Column(name = "tc_group")
    private String tcGroup;

    @Column(name = "tc_subgroup")
    private String tcSubgroup;

    @Column(name = "tc_transaction_type")
    private String tcTransactionType;

    @Column(name = "tax_code_no")
    private BigDecimal taxCodeNo;

    @Column(name = "trx_code_type")
    private String trxCodeType;

    @Column(name = "ind_revenue_gp")
    private String indRevenueGp;

    @Column(name = "update_date")
    private LocalDateTime updateDate;
}
