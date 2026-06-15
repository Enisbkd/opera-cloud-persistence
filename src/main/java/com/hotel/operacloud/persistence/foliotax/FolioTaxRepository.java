package com.hotel.operacloud.persistence.foliotax;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FolioTaxRepository extends JpaRepository<FolioTaxEntity, FolioTaxId> {
}
