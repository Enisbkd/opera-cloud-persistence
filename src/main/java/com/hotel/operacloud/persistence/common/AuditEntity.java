package com.hotel.operacloud.persistence.common;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@MappedSuperclass
@Getter
@Setter
public abstract class AuditEntity {

    @Column(name = "tech_created_date", nullable = false, updatable = false)
    private LocalDateTime techCreatedDate;

    @Column(name = "tech_updated_date", nullable = false)
    private LocalDateTime techUpdatedDate;

    @PrePersist
    protected void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        techCreatedDate = now;
        techUpdatedDate = now;
    }

    @PreUpdate
    protected void onUpdate() {
        techUpdatedDate = LocalDateTime.now();
    }
}
