package com.hotel.operacloud.persistence.nameaddress;

import com.hotel.operacloud.persistence.common.AuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "name_address")
@Getter
@Setter
@NoArgsConstructor
public class NameAddressEntity extends AuditEntity {

    @Id
    @Column(name = "address_id", nullable = false)
    private Long addressId;

    @Column(name = "name_id")
    private Long nameId;

    @Column(name = "address_type")
    private String addressType;

    @Column(name = "address1")
    private String address1;

    @Column(name = "address2")
    private String address2;

    @Column(name = "address3")
    private String address3;

    @Column(name = "address4")
    private String address4;

    private String city;

    @Column(name = "city_ext")
    private String cityExt;

    private String state;
    private String province;

    @Column(name = "postal_code")
    private String postalCode;

    @Column(name = "country")
    private String country;

    @Column(name = "primary_yn")
    private String primaryYn;

    @Column(name = "insert_date")
    private String insertDate;

    @Column(name = "insert_user")
    private Long insertUser;

    @Column(name = "update_date")
    private LocalDateTime updateDate;

    @Column(name = "update_user")
    private Long updateUser;

    @Column(name = "inactive_date")
    private String inactiveDate;

    @Column(name = "last_updated_resort")
    private String lastUpdatedResort;
}
