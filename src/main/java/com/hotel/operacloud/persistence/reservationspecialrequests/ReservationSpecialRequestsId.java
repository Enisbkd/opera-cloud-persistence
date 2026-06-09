package com.hotel.operacloud.persistence.reservationspecialrequests;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationSpecialRequestsId implements Serializable {

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "resv_name_id", nullable = false)
    private Long resvNameId;

    @Column(name = "special_request_id", nullable = false)
    private String specialRequestId;
}
