package com.hotel.operacloud.persistence.name;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class NameConsumer {

    private final ObjectMapper objectMapper;
    private final NameRepository repository;

    @KafkaListener(topics = "${kafka.name.input-topic}")
    @Transactional
    public void consume(@Payload String message) {
        try {
            NameRecord record = objectMapper.readValue(message, NameRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getNameId());
                log.info("NAME deleted nameId={}", record.getNameId());
            } else {
                Optional<NameEntity> existing = repository.findById(record.getNameId());
                if (existing.isPresent() && existing.get().getUpdateDate() != null && record.getUpdateDate() != null
                        && record.getUpdateDate().isBefore(existing.get().getUpdateDate())) {
                    log.warn("NAME skipping stale record nameId={}: incoming={} < existing={}",
                            record.getNameId(), record.getUpdateDate(), existing.get().getUpdateDate());
                    return;
                }
                repository.save(toEntity(record));
                log.debug("NAME upserted nameId={}", record.getNameId());
            }
        } catch (Exception e) {
            log.error("NAME consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("NAME consumer failed", e);
        }
    }

    private NameEntity toEntity(NameRecord r) {
        NameEntity e = new NameEntity();
        e.setNameId(r.getNameId());
        e.setLast(r.getLast());
        e.setSname(r.getSname());
        e.setFirst(r.getFirst());
        e.setSfirst(r.getSfirst());
        e.setMiddle(r.getMiddle());
        e.setTitle(r.getTitle());
        e.setSalutation(r.getSalutation());
        e.setGender(r.getGender());
        e.setNationality(r.getNationality());
        e.setLanguage(r.getLanguage());
        e.setBirthCountry(r.getBirthCountry());
        e.setBirthPlace(r.getBirthPlace());
        e.setBirthDateStr(r.getBirthDateStr());
        e.setBirthDate(r.getBirthDate());
        e.setNameType(r.getNameType());
        e.setNameCode(r.getNameCode());
        e.setProfession(r.getProfession());
        e.setVipStatus(r.getVipStatus());
        e.setActiveYn(r.getActiveYn());
        e.setInactiveDate(r.getInactiveDate());
        e.setAnonymizationStatus(r.getAnonymizationStatus());
        e.setAnonymizationDate(r.getAnonymizationDate());
        e.setBlMsg(r.getBlMsg());
        e.setCashBlInd(r.getCashBlInd());
        e.setEmailYn(r.getEmailYn());
        e.setMailYn(r.getMailYn());
        e.setMailList(r.getMailList());
        e.setInsertDate(r.getInsertDate());
        e.setInsertUser(r.getInsertUser());
        e.setUpdateDate(r.getUpdateDate());
        e.setUpdateUser(r.getUpdateUser());
        e.setAccountType(r.getAccountType());
        e.setAccountsource(r.getAccountsource());
        e.setBusinessTitle(r.getBusinessTitle());
        e.setCompany(r.getCompany());
        e.setCompetitionCode(r.getCompetitionCode());
        e.setContactYn(r.getContactYn());
        e.setDepartment(r.getDepartment());
        e.setIndustryCode(r.getIndustryCode());
        e.setInfluence(r.getInfluence());
        e.setMarkets(r.getMarkets());
        e.setPriority(r.getPriority());
        e.setRoomsPotential(r.getRoomsPotential());
        e.setTerritory(r.getTerritory());
        e.setTracecode(r.getTracecode());
        e.setScope(r.getScope());
        e.setScopeCity(r.getScopeCity());
        e.setProductInterest(r.getProductInterest());
        e.setRegion(r.getRegion());
        e.setChainCode(r.getChainCode());
        e.setResortRegistered(r.getResortRegistered());
        e.setLastUpdatedResort(r.getLastUpdatedResort());
        e.setActionCode(r.getActionCode());
        return e;
    }
}
