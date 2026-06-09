package com.hotel.operacloud.persistence.reservationdailyelements;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDailyElementsId implements Serializable {

    @Column(name = "reservation_date", nullable = false)
    private LocalDate reservationDate;

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "resv_daily_el_seq", nullable = false)
    private Long resvDailyElSeq;
}
