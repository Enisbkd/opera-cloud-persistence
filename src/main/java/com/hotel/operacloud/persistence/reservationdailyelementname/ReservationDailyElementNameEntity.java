package com.hotel.operacloud.persistence.reservationdailyelementname;

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
@Table(name = "reservation_daily_element_name")
@Getter
@Setter
@NoArgsConstructor
public class ReservationDailyElementNameEntity extends AuditEntity {

    @EmbeddedId
    private ReservationDailyElementNameId id;

    private Long adults;
    private Long children;

    @Column(name = "company_id")
    private Long companyId;

    @Column(name = "rate_code")
    private String rateCode;

    @Column(name = "resv_contact_id")
    private Long resvContactId;

    @Column(name = "source_id")
    private String sourceId;

    @Column(name = "travel_agent_id")
    private Long travelAgentId;

    @Column(name = "resv_daily_el_seq")
    private Long resvDailyElSeq;

    @Column(name = "share_amount_original")
    private BigDecimal shareAmountOriginal;

    @Column(name = "tc_group")
    private String tcGroup;

    @Column(name = "tc_subgroup")
    private String tcSubgroup;

    @Column(name = "trx_code")
    private String trxCode;

    @Column(name = "update_date")
    private LocalDateTime updateDate;
}
