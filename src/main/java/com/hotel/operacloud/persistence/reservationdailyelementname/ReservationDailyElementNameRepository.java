package com.hotel.operacloud.persistence.reservationdailyelementname;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationDailyElementNameRepository
        extends JpaRepository<ReservationDailyElementNameEntity, ReservationDailyElementNameId> {

    @Modifying
    @Query("DELETE FROM ReservationDailyElementNameEntity e WHERE e.id.resvNameId = :resvNameId")
    void deleteByResvNameId(@Param("resvNameId") Long resvNameId);
}
