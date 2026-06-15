package com.hotel.operacloud.persistence.araccount;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArAccountRepository extends JpaRepository<ArAccountEntity, ArAccountId> {
}
