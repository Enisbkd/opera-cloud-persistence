package com.hotel.operacloud.persistence.membership;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "membership")
@Getter
@Setter
@NoArgsConstructor
public class MembershipEntity extends AuditEntity {

    @Id
    @Column(name = "membership_id", nullable = false)
    private Long membershipId;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "membership_type")
    private String membershipType;

    @Column(name = "membership_card_no")
    private String membershipCardNo;

    @Column(name = "membership_level")
    private String membershipLevel;

    @Column(name = "name_on_card")
    private String nameOnCard;

    @Column(name = "chain_code")
    private String chainCode;

    @Column(name = "joined_date")
    private String joinedDate;

    @Column(name = "expiration_date")
    private String expirationDate;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "update_date")
    private String updateDate;

    @Column(name = "order_by")
    private Long orderBy;
}
