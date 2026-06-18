package com.hotel.operacloud.persistence.reservationdailyelements;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "reservation_daily_elements")
@Getter
@Setter
@NoArgsConstructor
public class ReservationDailyElementsEntity extends AuditEntity {

    @EmbeddedId
    private ReservationDailyElementsId id;

    @Column(name = "resv_name_id")
    private Long resvNameId;

    @Column(name = "allotment_header_id")
    private Long allotmentHeaderId;

    @Column(name = "booked_room_category")
    private String bookedRoomCategory;

    @Column(name = "due_out_yn")
    private String dueOutYn;

    @Column(name = "market_code")
    private String marketCode;

    @Column(name = "origin_of_booking")
    private String originOfBooking;

    @Column(name = "reservation_status")
    private String reservationStatus;

    private String room;

    @Column(name = "room_category")
    private String roomCategory;

    @Column(name = "room_class")
    private String roomClass;

    @Column(name = "original_start_date")
    private LocalDate originalStartDate;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    private BigDecimal percentage;

    @Column(name = "trx_code")
    private String trxCode;
}
