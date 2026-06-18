package com.hotel.operacloud.persistence.foliotax;

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
@Table(name = "folio_tax")
@Getter
@Setter
@NoArgsConstructor
public class FolioTaxEntity extends AuditEntity {

    @EmbeddedId
    private FolioTaxId id;

    @Column(name = "payee_name_id")
    private Long payeeNameId;

    @Column(name = "update_date")
    private LocalDateTime updateDate;
}
