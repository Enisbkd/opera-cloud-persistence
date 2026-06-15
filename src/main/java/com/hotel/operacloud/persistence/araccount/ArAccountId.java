package com.hotel.operacloud.persistence.araccount;

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
public class ArAccountId implements Serializable {

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "account_code", nullable = false)
    private Long accountCode;
}
