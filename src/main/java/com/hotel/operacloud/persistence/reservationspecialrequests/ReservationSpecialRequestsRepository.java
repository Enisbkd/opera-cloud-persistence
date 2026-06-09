package com.hotel.operacloud.persistence.reservationspecialrequests;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationSpecialRequestsRepository
        extends JpaRepository<ReservationSpecialRequestsEntity, ReservationSpecialRequestsId> {

    @Modifying
    @Query("DELETE FROM ReservationSpecialRequestsEntity e WHERE e.id.resvNameId = :resvNameId")
    void deleteByResvNameId(@Param("resvNameId") Long resvNameId);
}
