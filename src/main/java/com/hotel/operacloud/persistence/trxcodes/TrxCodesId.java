package com.hotel.operacloud.persistence.trxcodes;

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
public class TrxCodesId implements Serializable {

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "trx_code", nullable = false)
    private String trxCode;
}
