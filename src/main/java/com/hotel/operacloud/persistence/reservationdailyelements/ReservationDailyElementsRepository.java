package com.hotel.operacloud.persistence.reservationdailyelements;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationDailyElementsRepository
        extends JpaRepository<ReservationDailyElementsEntity, ReservationDailyElementsId> {

    @Modifying
    @Query("DELETE FROM ReservationDailyElementsEntity e WHERE e.resvNameId = :resvNameId")
    void deleteByResvNameId(@Param("resvNameId") Long resvNameId);
}
