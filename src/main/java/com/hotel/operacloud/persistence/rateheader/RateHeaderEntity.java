package com.hotel.operacloud.persistence.rateheader;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "rate_header")
@Getter
@Setter
@NoArgsConstructor
public class RateHeaderEntity extends AuditEntity {

    @EmbeddedId
    private RateHeaderId id;

    @Column(name = "rate_category")
    private String rateCategory;

    @Column(name = "description")
    private String description;

    @Column(name = "begin_booking_date")
    private String beginBookingDate;

    @Column(name = "end_booking_date")
    private String endBookingDate;

    @Column(name = "yieldable_yn")
    private String yieldableYn;

    @Column(name = "package_yn")
    private String packageYn;

    @Column(name = "folio_text")
    private String folioText;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @Column(name = "trx_code")
    private String trxCode;
}
