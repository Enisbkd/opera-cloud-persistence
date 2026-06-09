package com.hotel.operacloud.persistence.namephone;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NamePhoneRepository extends JpaRepository<NamePhoneEntity, Long> {
}
