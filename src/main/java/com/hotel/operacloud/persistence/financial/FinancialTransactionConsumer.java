package com.hotel.operacloud.persistence.financial;

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
public class FinancialTransactionConsumer {

    private final ObjectMapper objectMapper;
    private final FinancialTransactionRepository repository;

    @KafkaListener(topics = "${kafka.financial.input-topic}", concurrency = "12")
    @Transactional
    public void consume(@Payload String message) {
        try {
            FinancialTransactionRecord record =
                    objectMapper.readValue(message, FinancialTransactionRecord.class);
            if ("DELETE".equalsIgnoreCase(record.getOperation())) {
                repository.deleteById(record.getTrxNo());
                log.info("FINANCIAL_TRANSACTIONS deleted trxNo={}", record.getTrxNo());
            } else {
                Optional<FinancialTransactionEntity> existing = repository.findById(record.getTrxNo());
                if (existing.isPresent() && existing.get().getUpdateDate() != null && record.getUpdateDate() != null
                        && record.getUpdateDate().isBefore(existing.get().getUpdateDate())) {
                    log.warn("FINANCIAL_TRANSACTIONS skipping stale record trxNo={}: incoming={} < existing={}",
                            record.getTrxNo(), record.getUpdateDate(), existing.get().getUpdateDate());
                    return;
                }
                repository.save(toEntity(record));
                log.debug("FINANCIAL_TRANSACTIONS upserted trxNo={}", record.getTrxNo());
            }
        } catch (Exception e) {
            log.error("FINANCIAL_TRANSACTIONS consumer failed. Payload=[{}]: {}", message, e.getMessage(), e);
            throw new RuntimeException("FINANCIAL_TRANSACTIONS consumer failed", e);
        }
    }

    private FinancialTransactionEntity toEntity(FinancialTransactionRecord r) {
        FinancialTransactionEntity e = new FinancialTransactionEntity();
        e.setTrxNo(r.getTrxNo());
        e.setArLedCredit(r.getArLedCredit());
        e.setArLedDebit(r.getArLedDebit());
        e.setArState(r.getArState());
        e.setArrangementId(r.getArrangementId());
        e.setBillNo(r.getBillNo());
        e.setBusinessDate(r.getBusinessDate());
        e.setCashierCredit(r.getCashierCredit());
        e.setCashierDebit(r.getCashierDebit());
        e.setCashierId(r.getCashierId());
        e.setChequeNumber(r.getChequeNumber());
        e.setCurrency(r.getCurrency());
        e.setDepLedCredit(r.getDepLedCredit());
        e.setDepLedDebit(r.getDepLedDebit());
        e.setExchangeRate(r.getExchangeRate());
        e.setFinDmlSeqNo(r.getFinDmlSeqNo());
        e.setFolioNo(r.getFolioNo());
        e.setFolioType(r.getFolioType());
        e.setFolioView(r.getFolioView());
        e.setFromResvId(r.getFromResvId());
        e.setFtSubtype(r.getFtSubtype());
        e.setGrossAmount(r.getGrossAmount());
        e.setGuestAccountCredit(r.getGuestAccountCredit());
        e.setGuestAccountDebit(r.getGuestAccountDebit());
        e.setInsertDate(r.getInsertDate());
        e.setInsertUser(r.getInsertUser());
        e.setInvoiceCloseDate(r.getInvoiceCloseDate());
        e.setInvoiceNo(r.getInvoiceNo());
        e.setInvoiceType(r.getInvoiceType());
        e.setMarketCode(r.getMarketCode());
        e.setMembershipId(r.getMembershipId());
        e.setNameId(r.getNameId());
        e.setNetAmount(r.getNetAmount());
        e.setNumberDialed(r.getNumberDialed());
        e.setOrgPostedAmount(r.getOrgPostedAmount());
        e.setOriginalResvNameId(r.getOriginalResvNameId());
        e.setPackageAllowance(r.getPackageAllowance());
        e.setPackageArrangementCode(r.getPackageArrangementCode());
        e.setPackageCredit(r.getPackageCredit());
        e.setPackageDebit(r.getPackageDebit());
        e.setPostedAmount(r.getPostedAmount());
        e.setPostingDate(r.getPostingDate());
        e.setPostingType(r.getPostingType());
        e.setPricePerUnit(r.getPricePerUnit());
        e.setQuantity(r.getQuantity());
        e.setRateCode(r.getRateCode());
        e.setReceiptNo(r.getReceiptNo());
        e.setReceiptType(r.getReceiptType());
        e.setReference(r.getReference());
        e.setRemark(r.getRemark());
        e.setResort(r.getResort());
        e.setResvNameId(r.getResvNameId());
        e.setRevenueAmt(r.getRevenueAmt());
        e.setRoom(r.getRoom());
        e.setRoomClass(r.getRoomClass());
        e.setRoutingInstrnId(r.getRoutingInstrnId());
        e.setSourceCode(r.getSourceCode());
        e.setTaCommissionableYn(r.getTaCommissionableYn());
        e.setTargetResort(r.getTargetResort());
        e.setTaxGeneratedYn(r.getTaxGeneratedYn());
        e.setTaxInclusiveYn(r.getTaxInclusiveYn());
        e.setTcGroup(r.getTcGroup());
        e.setTcSubgroup(r.getTcSubgroup());
        e.setTranActionId(r.getTranActionId());
        e.setTrxAmount(r.getTrxAmount());
        e.setTrxCode(r.getTrxCode());
        e.setTrxDate(r.getTrxDate());
        e.setTrxNoAddedBy(r.getTrxNoAddedBy());
        e.setTrxNoAdjust(r.getTrxNoAdjust());
        e.setTrxNoAgainstPackage(r.getTrxNoAgainstPackage());
        e.setTrxNoSplit(r.getTrxNoSplit());
        e.setUpdateDate(r.getUpdateDate());
        e.setUpdateUser(r.getUpdateUser());
        e.setCashierOpeningBalance(r.getCashierOpeningBalance());
        e.setHotelAcct(r.getHotelAcct());
        e.setOriginalRoom(r.getOriginalRoom());
        e.setResvDepositId(r.getResvDepositId());
        e.setSourceCommissionNetYn(r.getSourceCommissionNetYn());
        e.setToResvNameId(r.getToResvNameId());
        e.setTrxNoHeader(r.getTrxNoHeader());
        e.setPackageTrxType(r.getPackageTrxType());
        e.setTaCommissionNetYn(r.getTaCommissionNetYn());
        return e;
    }
}
