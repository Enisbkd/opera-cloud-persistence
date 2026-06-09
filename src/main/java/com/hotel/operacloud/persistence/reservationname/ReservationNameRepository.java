package com.hotel.operacloud.persistence.reservationname;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationNameRepository extends JpaRepository<ReservationNameEntity, Long> {
}
