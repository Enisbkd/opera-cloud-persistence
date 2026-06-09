package com.hotel.operacloud.persistence.financial;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FinancialTransactionRepository extends JpaRepository<FinancialTransactionEntity, Long> {
}
