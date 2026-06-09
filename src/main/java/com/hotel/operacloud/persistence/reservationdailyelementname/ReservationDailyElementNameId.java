package com.hotel.operacloud.persistence.reservationdailyelementname;

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
public class ReservationDailyElementNameId implements Serializable {

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "resv_name_id", nullable = false)
    private Long resvNameId;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate reservationDate;
}
