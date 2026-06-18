package com.hotel.operacloud.persistence.foliotax;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class FolioTaxRecord {

    private String operation;

    private String resort;
    private Long resvNameId;
    private Long folioView;
    private Long payeeNameId;
    private String updateDate;
}
