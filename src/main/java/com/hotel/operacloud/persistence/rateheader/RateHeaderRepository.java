package com.hotel.operacloud.persistence.rateheader;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RateHeaderRepository extends JpaRepository<RateHeaderEntity, RateHeaderId> {
}
