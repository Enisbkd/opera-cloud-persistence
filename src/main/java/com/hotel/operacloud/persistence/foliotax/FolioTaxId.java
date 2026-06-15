package com.hotel.operacloud.persistence.foliotax;

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
public class FolioTaxId implements Serializable {

    @Column(name = "resort", nullable = false)
    private String resort;

    @Column(name = "resv_name_id", nullable = false)
    private Long resvNameId;

    @Column(name = "folio_view", nullable = false)
    private Long folioView;
}
