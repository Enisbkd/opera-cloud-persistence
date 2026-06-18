select sum(round(nvl(GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(GUEST_ACCOUNT_CREDIT, 0), 2)) MTEXTRA
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '1' and
    RESORT = #RESORT

select sum(round(nvl(GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(GUEST_ACCOUNT_CREDIT, 0), 2)) MTEXTRA
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '5' and
    RESORT = #RESORT

select sum(round(nvl(GUEST_ACCOUNT_DEBIT, 0), 2)) SPE_MTDEBIT
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '1' and
    RESORT = #RESORT

select sum(round(nvl(GUEST_ACCOUNT_DEBIT, 0), 2)) SPE_MTDEBIT
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '5' and
    RESORT = #RESORT

select sum(round(nvl(GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(GUEST_ACCOUNT_CREDIT, 0), 2)) MTINVIT
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    TRX_CODE = '590090' and
    RESORT = #RESORT

select sum(round(nvl(GUEST_ACCOUNT_CREDIT, 0), 2)) MTCREDIT
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '5' and
    RESORT = #RESORT and
    TRX_CODE <> '590036' and
    TRX_CODE <> '590090' and
    TRX_CODE <> '590091'

select sum(round(nvl(GUEST_ACCOUNT_CREDIT, 0), 2)) MTCREDIT
from FINANCIAL_TRANSACTIONS
where
    RESV_NAME_ID = #RESV_NAME_ID and
    FOLIO_VIEW = '1' and
    RESORT = #RESORT and
    TRX_CODE <> '590036' and
    TRX_CODE <> '590090' and
    TRX_CODE <> '590091'

select count(1) SPE_NB
from MEMBERSHIPS
where
    NAME_ID = #NAME_ID and
    MEMBERSHIP_TYPE = 'MYMC' and
    trim(MEMBERSHIP_CARD_NO) = to_char(#NUCOMPTE) and
    INACTIVE_DATE is null

select oiPMS_PRFORM01.DOB(BIRTH_DATE_STR) SPE_DABIRTH
from NAME
where NAME_ID = #NAME_ID

select
    /*+ INDEX (SEARCH_NAME_IDX)*/ LAST NOCLI,
    FIRST PRECLI
from NAME
where NAME_ID = #NAME_ID

select CASH_BL_IND SPE_CASH_BL_IND
from NAME
where NAME_ID = #NAME_ID

select sum(nvl(a.TRX_AMOUNT, 0)) SPE_MTPAYE
from
    FINANCIAL_TRANSACTIONS a,
    RESERVATION_NAME b
where
    a.RESV_NAME_ID = b.RESV_NAME_ID and
    a.TRX_CODE <> '590036' and
    a.TRX_CODE <> '590090' and
    a.TRX_CODE <> '590091' and
    a.TRX_CODE <> '590031' and
    a.TRX_CODE like '5%' and
    a.GUEST_ACCOUNT_CREDIT is not null and
    a.GUEST_ACCOUNT_CREDIT <> 0 and
    (
        RESV_STATUS = 'CHECKED IN' OR
        RESV_STATUS = 'CHECKED OUT'
        ) and
    (
        b.NAME_ID in #NAME_ID
        ) and
    b.BEGIN_DATE - 1 <=  #SPE_DADEB and
    b.END_DATE >= #SPE_DAFIN

select
    RESV_NAME_ID SPE_RESV_NAME_ID,
    NAME_ID SPE_NAME_ID
from RESERVATION_NAME
where
    SGUEST_NAME like (#SPE_NOLST || '%') and
    TRUNC_BEGIN_DATE = #SPE_DADEB and
    RESORT = #SPE_RESORT

select
    c.ROOM SPE_ROOM,
    a.RESV_NAME_ID,
    a.UDFC16
from
    RESERVATION_NAME a,
    RESERVATION_DAILY_ELEMENT_NAME b,
    RESERVATION_DAILY_ELEMENTS c,
    NAME d
where
    a.RESV_STATUS = 'CHECKED IN' and
    a.RESORT = 'SH' and
    a.NAME_ID = #NAME_ID and
    a.RESORT = b.RESORT and
    a.RESV_NAME_ID = b.RESV_NAME_ID and
    b.RESERVATION_DATE = to_char(sysdate, 'DD/MM/YYYY') and
    a.NAME_ID = d.NAME_ID and
    d.NAME_TYPE = 'D' and
    c.ORIGIN_OF_BOOKING = 'IND' and
    b.RESV_DAILY_EL_SEQ = c.RESV_DAILY_EL_SEQ and
    c.RESORT = 'SH' and
    c.RESERVATION_DATE = to_char(sysdate, 'DD/MM/YYYY')

select NAME_ID SPE_NAME_ID
from RESERVATION_NAME
where
    RESV_NAME_ID = #RESV_NAME_ID and
    RESORT = #SPE_RESORT

select NAME_ID SPE_NAME_ID
from MEMBERSHIPS
where
    MEMBERSHIP_TYPE = 'JE' and
    INACTIVE_DATE is null and
    MEMBERSHIP_CARD_NO = #NUCLI

select
    min(BEGIN_DATE) SPE_BEGIN_DATE,
    max(END_DATE) SPE_END_DATE,
    max(RESV_NAME_ID) SPE_RESV_NAME_ID
from RESERVATION_NAME
where
    NAME_ID = #NAME_ID and
    RESV_STATUS = 'CHECKED IN' and
    RESORT = #RESORT

select
    RESORT,
    RESV_NAME_ID,
    NAME_ID,
    RESV_STATUS,
    TRUNC_BEGIN_DATE,
    TRUNC_END_DATE,
    SGUEST_NAME,
    MEMBERSHIP_ID,
    SGUEST_FIRSTNAME,
    GUEST_LAST_NAME,
    GUEST_FIRST_NAME,
    NAME_USAGE_TYPE,
    BEGIN_DATE,
    END_DATE
from RESERVATION_NAME
where
    RESV_NAME_ID = #RESV_NAME_ID and
    RESORT = #RESORT

select
    a.RESV_NAME_ID RESV_NAME_ID,
    nvl(a.UDFC16, '01') UDFC16
from
    RESERVATION_NAME a,
    RESERVATION_DAILY_ELEMENT_NAME b
where
    a.RESORT = 'SH' and
    b.RESORT = 'SH' and
    a.RESV_NAME_ID = b.RESV_NAME_ID and
    b.RESV_DAILY_EL_SEQ = (
        select max(RESV_DAILY_EL_SEQ)
        from RESERVATION_DAILY_ELEMENTS c
        where
            c.RESORT = 'SH' and
            c.ROOM = ltrim(#SPE_ROOM, '0') and
            RESV_STATUS = 'CHECKED IN' and
            ROOM_CLASS = 'VIP-CLUB'
    )

select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    '' NUCLI,
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE,
    a.TRUNC_END_DATE SPE_DACOMPTA,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    opera.oiPMS_PRFORM01.DOB(c.BIRTH_DATE_STR) SPE_DALST,
    substr(c.SNAME, 1, 30) SPE_NOLST,
    substr(c.SFIRST, 1, 30) SPE_PRLST,
    nvl(translate(upper(a.PARTY_CODE), '0123456789, ', '%%%%%%%%%%%%'), '0') PARTY_CODE,
    e.MEMBERSHIP_CARD_NO NUCOMPTE,
    (
        select max(RATE_CODE)
        from FINANCIAL_TRANSACTIONS f
        where
            f.RESV_NAME_ID = a.RESV_NAME_ID and
            f.RESORT = a.RESORT and
            ROUTING_INSTRN_ID is null
    ) RATE_CODE,
    to_number(null) MTOPMYP,
    to_number(null) MTOPINV,
    to_number(null) MTOPAVDI,
    to_number(null) MTPAYE,
    nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), nvl(substr(a.EXTERNAL_REFERENCE, 1, 8), '0')) SPE_NUCLIOP,
    nvl(a.FOLIO_CLOSE_DATE, '01/01/1960') FOLIO_CLOSE_DATE,
    'X' SPE_NUCLI,
    'RattrapDaily20' USRLOGIN,
    '' NUCLI_PAIE,
    0 MTAJOUT,
    '0' FLFACT,
    0 MTEXTRAPLAY,
    0 MTEXTRATOT,
    '' RESV_STATUS,
    to_date(null) SPE_DAIMPUT,
    '' SPE_DADEBRES,
    '' SPE_DAFINRES,
    'X' COBUDGET,
    'N' VALIDATION,
    'DY' || to_char(trunc(sysdate), 'ddMMyy') NULOT,
    '' LICLIENT,
    0 MTPEC,
    0 MTEXTRA,
    '' ROOM,
    0 MTTOTAL,
    0 MTPAYE,
    0 MTDEBOURS,
    0 MTDEB,
    ' ' SPE_BUDGET,
    ' ' ERREUR,
    ' ' DEJATRAITE,
    0 MTINV,
    0 MTFEN3,
    0 MTINVFAC,
    '01/01/1960' FOLIO_CLOSE_DATE,
    '0' SPE_NUCLIOP,
    0 MTAVG,
    0 MTJEUX
from
    RESERVATION_NAME a,
    NAME c,
    MEMBERSHIPS d,
    MEMBERSHIPS e
where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[SPE_RESORT]> and
    a.TRUNC_END_DATE <= <[SPE_DAFIN]>) and
    a.TRUNC_END_DATE >= <[SPE_DADEB]> and
    a.GUEST_FIRST_NAME is not null and
    c.SNAME like trim(<[SPE_NOLST]>) ||'%' and
    c.SFIRST like trim(<[SPE_PRLST]>) || '%' and
    a.FINANCIALLY_RESPONSIBLE_YN is null and
    (
select max(ROOM_CLASS)
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    FROM_RESV_ID is null
    ) <> 'PSEUDO' and
    d.MEMBERSHIP_TYPE(+) = 'JE' and
    d.INACTIVE_DATE(+) is null and
    c.NAME_ID = a.NAME_ID and
    a.NAME_ID = d.NAME_ID(+) and
    e.MEMBERSHIP_TYPE(+) = 'MYMC' and
    e.INACTIVE_DATE(+) is null and
    a.NAME_ID = e.NAME_ID(+) and
    (
select max(RATE_CODE)
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    ROUTING_INSTRN_ID is null
    ) = <[SPE_RATE]> and
    (
select sum(f.TRX_AMOUNT)
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    f.TRX_CODE = '590091'
    ) <> 0 and
    nvl((select sum(f.TRX_AMOUNT) from FINANCIAL_TRANSACTIONS f where f.RESV_NAME_ID = a.RESV_NAME_ID and f.RESORT = a.RESORT and f.TRX_CODE = '590036'), 0) = 0 and
    nvl((select sum(f.TRX_AMOUNT) from FINANCIAL_TRANSACTIONS f where f.RESV_NAME_ID = a.RESV_NAME_ID and f.RESORT = a.RESORT and f.TRX_CODE = '590090'), 0) = 0

select distinct
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590036'
    ) MTOPMYP,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590090'
    ) MTOPINV,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590091'
    ) MTOPAVDI,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE <> '590036' and
            a.TRX_CODE <> '590090' and
            a.TRX_CODE <> '590091' and
            a.TRX_CODE <> '590031' and
            a.TRX_CODE like '5%' and
            a.GUEST_ACCOUNT_CREDIT is not null and
            a.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = <[RESV_NAME_ID]> and
    f.RESORT = <[RESORT]>

select nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), '0') SPE_NUCLIOP
from MEMBERSHIPS d
where
    d.MEMBERSHIP_TYPE = 'JE' and
    d.INACTIVE_DATE is null and
    upper(d.NAME_ON_CARD) like <[PARTY_CODE]> || '%'

select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    '' NUCLI,
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE,
    a.TRUNC_END_DATE SPE_DACOMPTA,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    opera.oiPMS_PRFORM01.DOB(c.BIRTH_DATE_STR) SPE_DALST,
    substr(c.SNAME, 1, 30) SPE_NOLST,
    substr(c.SFIRST, 1, 30) SPE_PRLST,
    nvl(translate(upper(a.PARTY_CODE), '0123456789, ', '%%%%%%%%%%%%'), '0') PARTY_CODE,
    e.MEMBERSHIP_CARD_NO NUCOMPTE,
    (
        select max(RATE_CODE)
        from FINANCIAL_TRANSACTIONS f
        where
            f.RESV_NAME_ID = a.RESV_NAME_ID and
            f.RESORT = a.RESORT and
            ROUTING_INSTRN_ID is null
    ) RATE_CODE,
    to_number(null) MTOPMYP,
    to_number(null) MTOPINV,
    to_number(null) MTOPAVDI,
    to_number(null) MTPAYE,
    nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), nvl(substr(a.EXTERNAL_REFERENCE, 1, 8), '0')) SPE_NUCLIOP,
    nvl(a.FOLIO_CLOSE_DATE, '01/01/1960') FOLIO_CLOSE_DATE,
    '' SPE_NUCLI,
    'RattrapFaily20' USRLOGIN,
    '' NUCLI_PAIE,
    0 MTAJOUT,
    '0' FLFACT,
    0 MTEXTRAPLAY,
    0 MTEXTRATOT,
    '' RESV_STATUS,
    to_date(null) SPE_DAIMPUT,
    '' SPE_DADEBRES,
    '' SPE_DAFINRES,
    'X' COBUDGET,
    'N' VALIDATION,
    'FA' || to_char(a.TRUNC_END_DATE, 'ddMMyy') NULOT,
    '' LICLIENT,
    0 MTPEC,
    0 MTEXTRA,
    '' ROOM,
    0 MTTOTAL,
    0 MTPAYE,
    0 MTDEBOURS,
    0 MTDEB,
    ' ' SPE_BUDGET,
    ' ' ERREUR,
    ' ' DEJATRAITE,
    0 MTINV,
    0 MTFEN3,
    0 MTINVFAC,
    '01/01/1960' FOLIO_CLOSE_DATE,
    '0' SPE_NUCLIOP,
    0 MTAVG,
    0 MTJEUX
from
    RESERVATION_NAME a,
    NAME c,
    MEMBERSHIPS d,
    memberships e
where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[SPE_RESORT]> and
    a.TRUNC_END_DATE <= <[SPE_DAFIN]> and
    a.TRUNC_END_DATE >= <[SPE_DADEB]> and
    a.GUEST_FIRST_NAME is not null and
    c.SNAME like trim(<[SPE_NOLST]>) || '%' and
    c.SFIRST like trim(<[SPE_PRLST]>) || '%' and
    a.FINANCIALLY_RESPONSIBLE_YN is null and
    (
    select max(ROOM_CLASS)
    from FINANCIAL_TRANSACTIONS f
    where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    FROM_RESV_ID is null
    ) <> 'PSEUDO' and
    d.MEMBERSHIP_TYPE(+) = 'JE' and
    d.INACTIVE_DATE(+) is null and
    c.NAME_ID = a.NAME_ID and
    a.NAME_ID = d.NAME_ID(+) and
    e.MEMBERSHIP_TYPE(+) = 'MYMC' and
    e.INACTIVE_DATE(+) is null and
    a.NAME_ID = e.NAME_ID(+) and
    (
    select max(RATE_CODE)
    from FINANCIAL_TRANSACTIONS f
    where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    ROUTING_INSTRN_ID is null
    ) = <[SPE_RATE]> and
    (
    select sum(f.TRX_AMOUNT)
    from FINANCIAL_TRANSACTIONS f
    where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    f.TRX_CODE = '590091'
    ) <> 0 and
    nvl((select sum(f.TRX_AMOUNT) from FINANCIAL_TRANSACTIONS f where f.RESV_NAME_ID = a.RESV_NAME_ID and f.RESORT = a.RESORT and f.TRX_CODE = '590036'), 0) = 0 and
    nvl((select sum(f.TRX_AMOUNT) from FINANCIAL_TRANSACTIONS f where f.RESV_NAME_ID = a.RESV_NAME_ID and f.RESORT = a.RESORT and f.TRX_CODE = '590090'), 0) = 0

select distinct
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590036'
    ) MTOPMYP,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590090'
    ) MTOPINV,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590091'
    ) MTOPAVDI,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE <> '590036' and
            a.TRX_CODE <> '590090' and
            a.TRX_CODE <> '590091' and
            a.TRX_CODE <> '590031' and
            a.TRX_CODE like '5%' and
            a.GUEST_ACCOUNT_CREDIT is not null and
            a.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = <[RESV_NAME_ID]> and
    f.RESORT = <[RESORT]>

select nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), '0') SPE_NUCLIOP
from MEMBERSHIPS d
where
    d.MEMBERSHIP_TYPE = 'JE' and
    d.INACTIVE_DATE is null and
    upper(d.NAME_ON_CARD) like  <[PARTY_CODE]> || '%'

select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    a.BEGIN_DATE,
    a.END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select sum(b.GUEST_ACCOUNT_DEBIT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTDEBOURS,
    (
        select sum(b.GUEST_ACCOUNT_DEBIT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select sum(b.GUEST_ACCOUNT_DEBIT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1'
    ) MTEXTRA,
    (
        select sum(b.GUEST_ACCOUNT_DEBIT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '5'
    ) MTEXTRA5,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1' or
                b.FOLIO_VIEW = '2'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    a.RESV_NAME_ID > #RESV_NAME_ID
    a.RESORT = #SPE_RESORT and
  (
    (
      a.RESV_NAME_ID = #SPE_RESV_NAME_ID or
      a.CONFIRMATION_NO=#SPE_CONFIRMATION_NO
    ) or
    (
      (
        a.NAME_ID in #SPE_LISTCARDEX or
        a.NAME_ID in #SPE_LISTCARDEX1
      ) and
      a.BEGIN_DATE - 1 <= #SPE_DAFIN and
      a.END_DATE >= #SPE_DADEB and
      a.NAME_ID = #SPE_CARDEX and
      a.RESV_STATUS = #SPE_STATUS and
      (1 = 2)
    )
  )

select
    round(nvl(a.GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(a.GUEST_ACCOUNT_CREDIT, 0), 2) GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    (
        (
            GUEST_ACCOUNT_DEBIT is not null and
            GUEST_ACCOUNT_DEBIT <> 0
            ) or
        (
            GUEST_ACCOUNT_CREDIT is not null and
            GUEST_ACCOUNT_CREDIT <> 0
            )
        ) and
    FOLIO_VIEW = '1' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT
order by a.POSTING_DATE

select
    round(nvl(a.GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(a.GUEST_ACCOUNT_CREDIT, 0), 2) GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '5', 'S/Autre Payeur', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    (
        (
            GUEST_ACCOUNT_DEBIT is not null and
            GUEST_ACCOUNT_DEBIT <> 0
            ) or
        (
            GUEST_ACCOUNT_CREDIT is not null and
            GUEST_ACCOUNT_CREDIT <> 0
            )
        ) and
    FOLIO_VIEW = '5' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT
order by a.POSTING_DATE

select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    a.BEGIN_DATE,
    a.END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select sum(b.GROSS_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '1' or
                b.FOLIO_VIEW = '5'
                )
    ) MTEXTRA,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590036'
    ) MTPLAYERS,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590090'
    ) MTINV,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590091' and
            b.FOLIO_VIEW = '3'
    ) MTFEN3,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE <> '590036' and
            b.TRX_CODE <> '590090' and
            b.TRX_CODE <> '590091' and
            b.TRX_CODE <> '590031' and
            b.TRX_CODE like '5%' and
            b.GUEST_ACCOUNT_CREDIT is not null and
            b.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    (
        RESV_STATUS = 'CHECKED IN' or
        RESV_STATUS = 'CHECKED OUT'
        ) and
    (
        a.BEGIN_DATE < #BEGIN_DATE or
        (
            a.BEGIN_DATE = #BEGIN_DATE and
            a.END_DATE < #END_DATE
            )
        ) and
    a.RESV_NAME_ID = #RESV_NAME_ID and
    (
        a.NAME_ID in #NAME_ID or
    a.NAME_ID in #SPE_LISTCARDEX or
    a.NAME_ID in #SPE_LISTCARDEX1
        ) and
    a.BEGIN_DATE - 1 <= #END_DATE and
    a.END_DATE >= #BEGIN_DATE
union
select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    a.BEGIN_DATE,
    a.END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select sum(b.GROSS_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '1' or
                b.FOLIO_VIEW = '5'
                )
    ) MTEXTRA,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590036'
    ) MTPLAYERS,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590090'
    ) MTINV,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE = '590091' and
            b.FOLIO_VIEW = '3'
    ) MTFEN3,
    (
        select sum(b.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.TRX_CODE <> '590036' and
            b.TRX_CODE <> '590090' and
            b.TRX_CODE <> '590031' and
            b.TRX_CODE <> '590091' and
            b.TRX_CODE like '5%' and
            b.GUEST_ACCOUNT_CREDIT is not null and
            b.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    upper(a.PARTY_CODE) like '%' || #SPE_NOLST || '%' || #SPE_PRLST || '%' and
    a.BEGIN_DATE - 1 <= dbdate(#END_DATE) and
    a.END_DATE >= dbdate(#BEGIN_DATE) and
    (
        RESV_STATUS = 'CHECKED IN' or
        RESV_STATUS = 'CHECKED OUT'
        )
order by
    END_DATE desc,
    BEGIN_DATE desc

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '1' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux', '2', 'Folio 2') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE,
    REMARK
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '2' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux et Av.') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '3' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT
order by TRX_DATE desc

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '5' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT

select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    to_char(a.BEGIN_DATE, 'dd/mm/yyyy') BEGIN_DATE,
    to_char(a.END_DATE, 'dd/mm/yyyy') END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select trunc(sum(b.GROSS_AMOUNT))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1'
    ) MTEXTRA,
    (
        select trunc(sum(b.GROSS_AMOUNT)) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    (
        (
            RESV_STATUS = 'CHECKED IN' or
            RESV_STATUS = 'CHECKED OUT'
            ) and
        a.RESORT <> 'SH' and
        (
            a.NAME_ID in #SPE_LISTCARDEX or
      a.NAME_ID in #SPE_LISTCARDEX1 or
      a.NAME_ID = #SPE_CARDEX_MEMBERSHIP
            ) and
        a.BEGIN_DATE <= dbdate(#DAFIN) and
        a.END_DATE >= dbdate(#DADEB) and
        a.END_DATE - a.BEGIN_DATE <= 180 and
        a.RESORT = #COHOTEL
        ) or
    (1 = 2)
union
select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    to_char(a.BEGIN_DATE, 'dd/mm/yyyy') BEGIN_DATE,
    to_char(a.END_DATE, 'dd/mm/yyyy') END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select trunc(sum(b.GROSS_AMOUNT))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1') MTEXTRA,
    (
        select trunc(sum(b.GROSS_AMOUNT)) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID=a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    upper(a.PARTY_CODE) like '%' || #NOLST || '%' || #PRLST || '%' and
    a.BEGIN_DATE <= dbdate(#SPE_DAFINRES) and
    a.BEGIN_DATE <= dbdate(#DAFIN) and
    a.END_DATE >= #DADEB and
    a.END_DATE - a.BEGIN_DATE <= 180 and
    a.RESORT = #COHOTEL and
    (
        RESV_STATUS = 'CHECKED IN' or
        RESV_STATUS = 'CHECKED OUT'
        )
order by
    END_DATE desc,
    BEGIN_DATE desc

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '3' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID
order by TRX_DATE desc

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '1' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID

select
    a.GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux', '2', 'Folio 2') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE,
    REMARK
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    FOLIO_VIEW = '2' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID

select
    a.TRX_NO TRX_NO,
    a.TRX_AMOUNT TRX_AMOUNT,
    a.TRX_DATE TRX_DATE,
    decode(length(a.TRX_CODE), 1, a.TRX_CODE, 2, a.TRX_CODE, 3, a.TRX_CODE, 4, a.TRX_CODE, 5, a.TRX_CODE, 6, a.TRX_CODE, substr(a.TRX_CODE, 1, 4)) TRX_CODE,
    a.ROOM ROOM,
    a.FOLIO_VIEW FOLIO_VIEW,
    decode(a.FOLIO_VIEW, 3, '1', '0') WCOPEC,
    b.DESCRIPTION DESCRIPTION
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    a.RESV_NAME_ID = <[RESV_NAME_ID]> and
    a.RESORT = <[RESORT]> and
    (
    (
    a.GROSS_AMOUNT is not null and
    a.GROSS_AMOUNT <> 0
    ) or
    a.GUEST_ACCOUNT_CREDIT is not null and
    a.GUEST_ACCOUNT_CREDIT <> 0
    ) and
    a.TRX_CODE <> '590031' and
    a.RESORT = b.RESORT and
    a.TRX_CODE = b.TRX_CODE

select
    SGUEST_FIRSTNAME,
    GUEST_LAST_NAME,
    RESV_STATUS,
    TRUNC_BEGIN_DATE,
    TRUNC_END_DATE
from RESERVATION_NAME
where
    RESV_NAME_ID = <[RESV_NAME_ID]> and
    RESORT = <[RESORT]> and
    NAME_ID = <[NAME_ID]>

select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    to_char(a.BEGIN_DATE, 'dd/mm/yyyy') BEGIN_DATE,
    to_char(a.END_DATE, 'dd/mm/yyyy') END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1'
    ) MTEXTRA,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    (
        (
            (
                RESV_STATUS = 'CHECKED IN' or
                RESV_STATUS = 'CHECKED OUT'
                ) and
            a.RESORT <> 'SH'
            ) and
        (
            a.NAME_ID in #SPE_LISTCARDEX or
      a.NAME_ID in #SPE_LISTCARDEX1 or
      a.NAME_ID = #NAME_ID or
      a.NAME_ID = #SPE_CARDEX_MEMBERSHIP
            ) and
        a.BEGIN_DATE <= #END_DATE and
        a.END_DATE >= #BEGIN_DATE and
        a.END_DATE - a.BEGIN_DATE <= 180 and
        a.RESORT = #RESORT
        ) or
    (1 = 2)
union
select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    to_char(a.BEGIN_DATE, 'dd/mm/yyyy') BEGIN_DATE,
    to_char(a.END_DATE, 'dd/mm/yyyy') END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT ))
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1'
    ) MTEXTRA,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT)) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3'
    ) MTSJEUX,
    (
        select trunc(sum(b.GUEST_ACCOUNT_DEBIT)) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTFEN2,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    upper(a.PARTY_CODE) like '%' || #NOLST || '%' || #PRLST || '%' and
    a.BEGIN_DATE <= dbdate(#END_DATE) and
    a.END_DATE >= dbdate(#BEGIN_DATE) and
    a.END_DATE - a.BEGIN_DATE <= 180 and
    a.RESORT = #RESORT and
    (
        RESV_STATUS = 'CHECKED IN' or
        RESV_STATUS = 'CHECKED OUT'
        )
order by
    END_DATE desc,
    BEGIN_DATE desc

select
    a.guest_account_debit GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GUEST_ACCOUNT_DEBIT is not null and
    GUEST_ACCOUNT_DEBIT <> 0 and
    FOLIO_VIEW = '1' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID

select
    a.GUEST_ACCOUNT_DEBIT GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux', '2', 'Folio 2') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE,
    REMARK
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GUEST_ACCOUNT_DEBIT is not null and
    GUEST_ACCOUNT_DEBIT <> 0 and
    FOLIO_VIEW = '2' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID

select
    a.guest_account_debit GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    RESV_NAME_ID = #RESV_NAME_ID and
    GUEST_ACCOUNT_DEBIT is not null and
    GUEST_ACCOUNT_DEBIT <> 0 and
    FOLIO_VIEW = '3' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESV_NAME_ID >= #RESV_NAME_ID

select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    'X' NUCLI,
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    c.BIRTH_DATE DANAISS,
    substr(c.SNAME, 1, 30) NOLST,
    substr(c.SFIRST, 1, 30) PRLST,
    0 NUCOMPTE,
    ' ' NUMRESA,
    ' ' COSTACLI,
    sysdate DACRE,
        <[USERCRE]> USERCRE,
    ' ' COBUDGET
from
    RESERVATION_NAME a,
    NAME c
where
    RESV_STATUS in ('CHECKED IN', 'CHECKED OUT') and
    a.RESORT <> 'SH' and
    a.TRUNC_END_DATE = <[SPE_DAFIN]> and
    c.NAME_ID = a.NAME_ID and
    (
    a.RES_INSERT_SOURCE is null or
    a.RES_INSERT_SOURCE <> 'SBMC1'
    ) and
    (
    a.UDFC22 is null or
    a.UDFC22 <> 'MARKETING JEUX'
    ) and
    c.SNAME like trim(<[SPE_NOLST]>) || '%' and
    c.SFIRST like trim(<[SPE_PRLST]>) || '%' and
    a.RESORT like trim(<[RESORT]>) || '%'

select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    '' NUCLI,
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    opera.oiPMS_PRFORM01.DOB(c.BIRTH_DATE_STR) DANAISS,
    substr(c.SNAME, 1, 30) NOLST,
    substr(c.SFIRST, 1, 30) PRLST,
    a.PARTY_CODE,
    '' NUCOMPTE,
    (
        select nvl(max(RATE_CODE), 'NO RATE')
        from FINANCIAL_TRANSACTIONS f
        where
            f.RESV_NAME_ID = a.RESV_NAME_ID and
            f.RESORT = a.RESORT and
            ROUTING_INSTRN_ID is null and
            RATE_CODE <> 'NO RATE' and
            RATE_CODE <> 'NORATE'
    ) RATE_CODE,
    to_number(null) MTOPMYP,
    to_number(null) MTOPINV,
    to_number(null) MTOPAVDI,
    to_number(null) MTPAYE,
    to_number(null) MTCA,
    to_number(null) PTFID,
    to_number(null) MTRET,
    to_number(null) MTINV,
    '' NUCLI2G,
    '' INDICFID,
    nvl(opera.reservation_ref.get_name(dn.TRAVEL_AGENT_ID), opera.reservation_ref.get_name(dn.COMPANY_ID)) AGENT_NAME
from
    RESERVATION_NAME a,
    NAME c,
    RESERVATION_DAILY_ELEMENT_NAME dn
where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[SPE_RESORT]> and
    a.TRUNC_END_DATE = <[SPE_DAFIN]> and
    c.NAME_ID = a.NAME_ID and
    a.GUEST_FIRST_NAME is not null and
    dn.RESORT = a.RESORT and
    dn.RESV_NAME_ID = a.RESV_NAME_ID and
    c.SNAME like trim(<[SPE_NOLST]>) || '%' and
    c.SFIRST like trim(<[SPE_PRLST]>) || '%' and
    a.FINANCIALLY_RESPONSIBLE_YN is null and
    (
    select max(ROOM_CLASS)
    from FINANCIAL_TRANSACTIONS f
    where
    f.RESV_NAME_ID = a.RESV_NAME_ID and
    f.RESORT = a.RESORT and
    FROM_RESV_ID is null
    ) <> 'PSEUDO'

select distinct
    (
        select d.MEMBERSHIP_CARD_NO
        from MEMBERSHIPS d
        where
            d.NAME_ID = <[NAME_ID]> and
    d.MEMBERSHIP_TYPE = 'JE' and
    d.INACTIVE_DATE is null
    ) NUCLI,
    (
select e.MEMBERSHIP_CARD_NO
from MEMBERSHIPS e
where
    e.NAME_ID = <[NAME_ID]> and
    e.MEMBERSHIP_TYPE = 'MYMC' and
    e.INACTIVE_DATE is null
    ) NUCOMPTE
from NAME a
where a.NAME_ID = <[NAME_ID]>

select distinct
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590036'
    ) MTOPMYP,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590090'
    ) MTOPINV,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590091'
    ) MTOPAVDI,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE <> '590036' and
            a.TRX_CODE <> '590090' and
            a.TRX_CODE <> '590091' and
            a.TRX_CODE <> '590031' and
            a.TRX_CODE like '5%' and
            a.GUEST_ACCOUNT_CREDIT is not null and
            a.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = <[RESV_NAME_ID]> and
    f.RESORT = <[RESORT]>

select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID,
    a.RESV_STATUS,
    a.BEGIN_DATE,
    a.END_DATE,
    a.GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    (
        select sum(b.GROSS_AMOUNT)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '2'
    ) MTDEBOURS,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '3') MTSJEUX,
    (
        select sum(b.GROSS_AMOUNT) MTEXTRA
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            b.FOLIO_VIEW = '1') MTEXTRA,
    (
        select max(b.ROOM)
        from FINANCIAL_TRANSACTIONS b
        where
            b.RESV_NAME_ID = a.RESV_NAME_ID and
            (
                b.FOLIO_VIEW = '3' or
                b.FOLIO_VIEW = '1' or
                b.FOLIO_VIEW = '2'
                )
    ) CHROOM
from RESERVATION_NAME a
where
    a.RESV_NAME_ID > #RESV_NAME_ID and
    a.RESORT = #SPE_RESORT and
    (
        a.RESV_NAME_ID = #SPE_RESV_NAME_ID or
        (
            (
                a.NAME_ID in #SPE_LISTCARDEX or
        a.NAME_ID in #SPE_LISTCARDEX1
                ) and
            a.BEGIN_DATE - 1 <= #SPE_DAFIN and
            a.END_DATE >= #SPE_DADEB and
            a.NAME_ID = #SPE_CARDEX and
            a.RESV_STATUS = #SPE_STATUS and
            (1 = 2)
            )
        )
order by
    a.BEGIN_DATE desc,
    a.END_DATE desc

select
    round(nvl(a.GUEST_ACCOUNT_DEBIT, 0), 2) - round(nvl(a.GUEST_ACCOUNT_CREDIT, 0), 2) GROSS_AMOUNT,
    a.TRX_CODE,
    a.TRX_DATE,
    DESCRIPTION,
    decode(a.FOLIO_VIEW, '1', 'Extra', '3', 'S/Jeux') FOLIO_VIEW,
    CHEQUE_NUMBER,
    POSTING_DATE,
    a.ROOM
from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
where
    a.RESV_NAME_ID > #RESV_NAME_ID and
    (
        (
            GUEST_ACCOUNT_DEBIT is not null and
            GUEST_ACCOUNT_DEBIT <> 0
            ) or
        (
            GUEST_ACCOUNT_CREDIT is not null and
            GUEST_ACCOUNT_CREDIT <> 0
            )
        ) and
    FOLIO_VIEW = '1' and
    b.TRX_CODE = a.TRX_CODE and
    b.RESORT = a.RESORT and
    a.RESORT = #SPE_RESORT and
    (
        a.RESV_NAME_ID = #SPE_RESV_NAME_ID or
        (
            (
                a.NAME_ID in #SPE_LISTCARDEX or
        a.NAME_ID in #SPE_LISTCARDEX1
                ) and
            a.BEGIN_DATE - 1 <= #SPE_DAFIN and
            a.END_DATE >= #SPE_DADEB and
            a.NAME_ID = #SPE_CARDEX and
            a.RESV_STATUS = #SPE_STATUS and
            (1 = 2)
            )
        )
order by a.POSTING_DATE

select
    TRUNC_BEGIN_DATE DADEB,
    TRUNC_END_DATE DAFIN,
    NAME_ID,
    RESV_STATUS,
    GUEST_FIRST_NAME,
    GUEST_LAST_NAME,
    to_char(TRUNC_BEGIN_DATE, 'yyyyMMdd') DADEBC,
    to_char(TRUNC_END_DATE, 'yyyyMMdd') DAFINC,
    CONFIRMATION_NO
from RESERVATION_NAME
where
    RESV_NAME_ID = <[NUFACT]> and
    RESORT = <[RESORT]>

select distinct
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590036'
    ) MTOPMYP,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590090'
    ) MTOPINV,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590091'
    ) MTOPAVDI,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE <> '590036' and
            a.TRX_CODE <> '590090' and
            a.TRX_CODE <> '590091' and
            a.TRX_CODE <> '590031' and
            a.TRX_CODE like '5%' and
            a.GUEST_ACCOUNT_CREDIT is not null and
            a.GUEST_ACCOUNT_CREDIT <> 0
    ) MTPAYE
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = <[RESV_NAME_ID]> and
    f.RESORT = <[RESORT]>

select distinct
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590036'
    ) MTOPMYP,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590090'
    ) MTOPINV,
    (
        select sum(a.TRX_AMOUNT)
        from FINANCIAL_TRANSACTIONS a
        where
            a.RESV_NAME_ID = f.RESV_NAME_ID and
            a.RESORT = f.RESORT and
            a.TRX_CODE = '590091'
    ) MTOPAVDI
from FINANCIAL_TRANSACTIONS f
where
    f.RESV_NAME_ID = <[RESV_NAME_ID]> and
    f.RESORT = <[RESORT]>

select DISTINCT
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    fin.TRX_CODE IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
        <[RESV_NAME_ID]> RESV_NAME_ID
from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx
where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]>
    ) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    (
    fin.trx_code = '152906' or
    fin.trx_code = '152912'
    )

select DISTINCT
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
        when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE,1,4)
        else fin.TRX_CODE
        end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
        <[RESV_NAME_ID]> RESV_NAME_ID,
    substr(b.RATE_CATEGORY, 1, 5) RATE_CATEGORY
from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    opera.RATE_HEADER b
where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]>
    ) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE
union
select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
        when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
        else fin.TRX_CODE
        end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
        <[RESV_NAME_ID]> RESV_NAME_ID,
    substr(b.RATE_CATEGORY, 1, 5) RATE_CATEGORY
from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    opera.RATE_HEADER b
where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID in (
    select FROM_RESV_ID
    from FINANCIAL_TRANSACTIONS fin
    where
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]> and
    FROM_RESV_ID is not null
    ) and
    fin.RESORT = <[RESORT]>) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE

select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    'CHECKED INLG' RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
from
    RESERVATION_NAME a,
    NAME c
where
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
from
    RESERVATION_NAME a,
    NAME c
where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESV_NAME_ID RESV_NAME_ID,
    fin.RESORT RESORT,
    fin.NAME_ID NAME_ID,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    SNAME || ' ' || SFIRST LICOMMENT,
    '0' FLAG,
    case
        when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
        else fin.TRX_CODE
        end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    case
        when substr(fin.TRX_CODE, 1, 1) = '5' then 8
        when fin.TRX_CODE = '530021' then 7
        when fin.FOLIO_VIEW = 5 then 1
        else fin.FOLIO_VIEW
        end FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    sysdate DACRE,
        <[SPE_USER]> USERCRE,
    sysdate DAMAJ,
        <[SPE_USER]> USERMAJ,
    substr(b.RATE_CATEGORY, 1, 5) MATRICULE,
    null LIRESP,
    '0' FLMASQ,
    null FLFACT,
    '' NULOT,
    null FLPAIPLAY,
    null MTECRDPLAY,
        <[SPE_DACOMPTA]> DACOMPTA
from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    FOLIO$_TAX a,
    NAME c,
    opera.RATE_HEADER b
where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]> and
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE and
    a.RESV_NAME_ID(+) = fin.RESV_NAME_ID and
    a.RESORT(+) = fin.RESORT and
    a.FOLIO_VIEW(+) = fin.FOLIO_VIEW and
    c.NAME_ID(+) = A.PAYEE_NAME_ID and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE
union
select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    to_number(<[RESV_NAME_ID]>) RESV_NAME_ID,
    fin.RESORT RESORT,
    fin.NAME_ID NAME_ID,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    SNAME || ' ' || SFIRST LICOMMENT,
    '0' FLAG,
    case
        when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
        else fin.TRX_CODE
        end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    case
        when substr(fin.TRX_CODE, 1, 1) = '5' then 8
        when fin.TRX_CODE = '530021' then 7
        when fin.FOLIO_VIEW = 5 then 1
        else fin.FOLIO_VIEW
        end FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    sysdate DACRE,
        <[SPE_USER]> USERCRE,
    sysdate DAMAJ,
        <[SPE_USER]> USERMAJ,
    substr(b.RATE_CATEGORY, 1, 5) MATRICULE,
    null LIRESP,
    '0' FLMASQ,
    null FLFACT,
    '' NULOT,
    null FLPAIPLAY,
    null MTECRDPLAY,
        <[SPE_DACOMPTA]> DACOMPTA
from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    FOLIO$_TAX a,
    NAME c,
    opera.RATE_HEADER b
where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID in (
    select FROM_RESV_ID
    from FINANCIAL_TRANSACTIONS fin
    where
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT=<[RESORT]> and
    FROM_RESV_ID is not null
    ) and
    fin.RESORT = <[RESORT]> and
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE and
    a.RESV_NAME_ID(+) = fin.RESV_NAME_ID and
    a.RESORT(+) = fin.RESORT and
    a.FOLIO_VIEW(+) = fin.FOLIO_VIEW and
    c.NAME_ID(+) = A.PAYEE_NAME_ID and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE

    select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
    from
    RESERVATION_NAME a,
    NAME c
    where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

    select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
    from
    RESERVATION_NAME a,
    NAME c
    where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

    select DISTINCT
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    fin.TRX_CODE IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
    <[RESV_NAME_ID]> RESV_NAME_ID
    from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]>
    ) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    (
    fin.trx_code = '152906' or
    fin.trx_code = '152912'
    )

    select DISTINCT
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
    when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE,1,4)
    else fin.TRX_CODE
    end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
    <[RESV_NAME_ID]> RESV_NAME_ID,
    substr(b.RATE_CATEGORY, 1, 5) RATE_CATEGORY
    from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    opera.RATE_HEADER b
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]>
    ) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE
    union
    select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
    when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
    else fin.TRX_CODE
    end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    decode(substr(fin.TRX_CODE, 1, 1), '5', 8, decode(fin.FOLIO_VIEW, 3, 3, 1)) FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
    <[RESV_NAME_ID]> RESV_NAME_ID,
    substr(b.RATE_CATEGORY, 1, 5) RATE_CATEGORY
    from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx,
    opera.RATE_HEADER b
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.RESV_NAME_ID in (
    select FROM_RESV_ID
    from FINANCIAL_TRANSACTIONS fin
    where
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]> and
    FROM_RESV_ID is not null
    ) and
    fin.RESORT = <[RESORT]>) and
    fin.TRX_DATE >= <[SPE_DADEB]> and
    fin.TRX_DATE <= <[SPE_DAFIN]> and
    (
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE
    ) and
    b.RESORT(+) = fin.RESORT and
    b.RATE_CODE(+) = fin.RATE_CODE and
    b.TRX_CODE(+) = fin.TRX_CODE

    select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    'CHECKED INLG' RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
    from
    RESERVATION_NAME a,
    NAME c
    where
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

    select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
    from
    RESERVATION_NAME a,
    NAME c
    where
    RESV_STATUS = 'CHECKED OUT' and
    a.RESORT = <[RESORT]> and
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]>

    select sum(b.GROSS_AMOUNT)
    from
    RESERVATION_NAME a,
    FINANCIAL_TRANSACTIONS b
    where
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    RESV_STATUS = 'CHECKED IN' and
    (
    a.NAME_ID in #SPE_NAME_ID or
    a.NAME_ID in #SPE_LISTCARDEX or
    a.NAME_ID in #SPE_LISTCARDEX1
    ) and
    a.BEGIN_DATE <= dbdate(#SPE_DAFIN) and
    a.END_DATE >= dbdate(#SPE_DADEB) and
    b.FT_SUBTYPE <> 'FC' and
    (
    b.FOLIO_VIEW = '1' or
    b.FOLIO_VIEW = '3'
    ) and
    b.GROSS_AMOUNT <> 0 and
    b.GROSS_AMOUNT is not null

    select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
    when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
    else fin.TRX_CODE
    end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    fin.FOLIO_VIEW FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
    fin.RESV_NAME_ID RESV_NAME_ID,
    '' CODE,
    null FLFACT
    from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.MARKET_CODE = 'JEU' or
    fin.MARKET_CODE = 'JEP' or
    fin.SOURCE_CODE = 'JEU'
    ) and
    fin.BUSINESS_DATE = <[SPE_DACOMPTA]> and
    fin.RESORT <> 'SH' and
    fin.TRX_CODE <> '590031' and
    fin.TRX_CODE not like '192%' and
    fin.TRX_CODE not like '200%' and
    fin.TRX_CODE <> '82102' and
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]> and
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE and
    fin.NAME_ID = <[NAME_ID]>
    union
    select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    fin.RESORT RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
    when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
    else fin.TRX_CODE
    end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    fin.FOLIO_VIEW FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    fin.NAME_ID NAME_ID,
    fin.RESV_NAME_ID RESV_NAME_ID,
    '' CODE,
    null FLFACT
    from
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.MARKET_CODE = 'JEU' or
    fin.MARKET_CODE = 'JEP' or
    fin.SOURCE_CODE = 'JEU'
    ) and
    trunc(fin.UPDATE_DATE) = <[SPE_DACOMPTA]> and
    fin.RESORT <> 'SH' and
    fin.TRX_CODE <> '590031' and
    fin.BUSINESS_DATE <= <[SPE_DACOMPTA]> and
    fin.BUSINESS_DATE >= <[SPE_DABORNINF]> and
    fin.RESV_NAME_ID = <[RESV_NAME_ID]> and
    fin.RESORT = <[RESORT]> and
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE and
    fin.NAME_ID = <[NAME_ID]>

    select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), substr(a.EXTERNAL_REFERENCE, 1, 8)) NUCLI,
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME,
    c.BIRTH_DATE DANAISS,
    substr(c.SNAME, 1, 30) NOLST,
    substr(c.SFIRST, 1, 30) PRLST,
    '' CODE,
    null FLFACT,
    null COBUDGET,
    null NUMRESA
    from
    RESERVATION_NAME a,
    NAME c,
    FINANCIAL_TRANSACTIONS b,
    MEMBERSHIPS d
    where
    RESV_STATUS = 'CHECKED IN' and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    (
    b.MARKET_CODE = 'JEU' or
    b.MARKET_CODE = 'JEP' or
    b.SOURCE_CODE = 'JEU'
    ) and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    b.BUSINESS_DATE = <[SPE_DACOMPTA]> and
    d.MEMBERSHIP_TYPE(+) = 'JE' and
    d.INACTIVE_DATE(+) is null and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    b.RESORT = a.RESORT and
    b.RESORT <> 'SH' and
    c.NAME_ID = a.NAME_ID and
    a.NAME_ID = <[CARDEXIN]> and
    a.NAME_ID = d.NAME_ID(+)

    select
    SGUEST_FIRSTNAME,
    GUEST_LAST_NAME,
    RESV_STATUS,
    TRUNC_BEGIN_DATE,
    TRUNC_END_DATE,
    NAME_ID,
    PARTY_CODE
    from RESERVATION_NAME
    where
    RESV_NAME_ID = <[RESV_NAME_ID]> and
    RESORT = <[RESORT]>

    select c.SPECIAL_REQUEST
    from
    RESERVATION_SPECIAL_REQUESTS b,
    OPERA.SPECIAL_REQUESTS c
    where
    b.resort(+) = <[RESORT]> and
    b.resv_name_id(+) = <[RESV_NAME_ID]> and
    c.SPECIAL_REQUEST_ID(+) = b.SPECIAL_REQUEST_ID and
    c.SPECIAL_REQUEST like 'S%'

    select
    a.TRX_NO TRX_NO,
    a.TRX_AMOUNT TRX_AMOUNT,
    a.TRX_DATE TRX_DATE,
    decode(length(a.TRX_CODE), 1, a.TRX_CODE, 2, a.TRX_CODE, 3, a.TRX_CODE, 4, a.TRX_CODE, 5, a.TRX_CODE, 6, a.TRX_CODE, substr(a.TRX_CODE, 1, 4)) TRX_CODE,
    a.ROOM ROOM,
    decode(a.FOLIO_VIEW, 5, 1, a.FOLIO_VIEW) FOLIO_VIEW,
    decode(a.FOLIO_VIEW, 3, decode(a.TRX_CODE, '590091', '0', '1'), '0') WCOPEC,
    b.DESCRIPTION DESCRIPTION,
    'X' ANCRESA
    from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
    where
    a.RESV_NAME_ID = <[RESV_NAME_ID]> and
    a.RESORT=<[RESORT]> and
    (
    (
    a.GROSS_AMOUNT is not null and
    a.GROSS_AMOUNT <> 0
    ) or
    (
    a.GUEST_ACCOUNT_CREDIT is not null and
    a.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    a.TRX_CODE <> '590031' and
    a.TRX_CODE not like '192%' and
    a.TRX_CODE not like '200%' and
    a.TRX_CODE <> '82102' and
    a.RESORT = b.RESORT and
    a.TRX_CODE = b.TRX_CODE

    select
    SGUEST_FIRSTNAME,
    GUEST_LAST_NAME,
    RESV_STATUS,
    TRUNC_BEGIN_DATE,
    TRUNC_END_DATE,
    NAME_ID
    from RESERVATION_NAME
    where
    RESV_NAME_ID = <[RESV_NAME_ID]> and
    RESORT = <[RESORT]>

    select
    a.TRX_NO TRX_NO,
    a.TRX_AMOUNT TRX_AMOUNT,
    a.TRX_DATE TRX_DATE,
    decode(length(a.TRX_CODE), 1, a.TRX_CODE, 2, a.TRX_CODE, 3, a.TRX_CODE, 4, a.TRX_CODE, 5, a.TRX_CODE, 6, a.TRX_CODE, substr(a.TRX_CODE, 1, 4)) TRX_CODE,
    a.ROOM ROOM,
    a.FOLIO_VIEW FOLIO_VIEW,
    decode(a.FOLIO_VIEW, 3, '1', '0') WCOPEC,
    b.DESCRIPTION DESCRIPTION,
    'X' ANCRESA
    from
    FINANCIAL_TRANSACTIONS a,
    TRX$_CODES b
    where
    a.RESV_NAME_ID = <[RESV_NAME_ID]> and
    a.RESORT = <[RESORT]> and
    (
    (
    a.GROSS_AMOUNT is not null and
    a.GROSS_AMOUNT <> 0
    ) or
    a.GUEST_ACCOUNT_CREDIT is not null and
    a.GUEST_ACCOUNT_CREDIT <> 0
    ) and
    a.TRX_CODE <> '590031' and
    a.TRX_CODE not like '192%' and
    a.TRX_CODE not like '200%' and
    a.TRX_CODE <> '82102' and
    FOLIO_VIEW <> '4' and
    a.RESORT = b.RESORT and
    a.TRX_CODE = b.TRX_CODE and
    a.TRX_DATE >= <[SPE_DADEB]> and
    a.TRX_DATE <= <[SPE_DAFIN]>

    select
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    'CHECKED OUT' RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME
    from
    RESERVATION_NAME a,
    NAME c
    where
    c.NAME_ID = a.NAME_ID and
    a.RESV_NAME_ID = <[RESV_NAME_ID]> and
    a.RESORT = <[COETAB]>

    select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    'AlimFAHO' USRLOGIN,
    nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), substr(a.EXTERNAL_REFERENCE, 1, 8)) SPE_NUCLI,
    a.NAME_ID,
    oiPMS_PRFORM01.DOB(BIRTH_DATE_STR) SPE_DALST,
    substr(c.SNAME, 1, 30) SPE_NOLST,
    substr(c.SFIRST, 1, 30) SPE_PRLST,
    translate(upper(a.PARTY_CODE), '0123456789, ', '%%%%%%%%%%%%') PARTY_CODE,
    'X' TRAITE
    from
    RESERVATION_NAME a,
    FINANCIAL_TRANSACTIONS b,
    NAME c,
    MEMBERSHIPS d
    where
    RESV_STATUS = 'CHECKED OUT' and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    (
    b.MARKET_CODE = 'JEU' or
    b.MARKET_CODE = 'JEP' or
    b.MARKET_CODE = 'ROL' or
    b.SOURCE_CODE = 'JEU'
    ) and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    a.TRUNC_END_DATE = <[SPE_DACOMPTA]> and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    b.RESORT=a.RESORT and
    b.RESORT<>'SH' and
    d.MEMBERSHIP_TYPE(+) = 'JE' and
    d.INACTIVE_DATE(+) is null and
    c.NAME_ID = a.NAME_ID and
    a.NAME_ID = d.NAME_ID(+)

    select sum(b.GROSS_AMOUNT)
    from
    RESERVATION_NAME a,
    FINANCIAL_TRANSACTIONS b
    where
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    RESV_STATUS = 'CHECKED IN' and
    (
    a.NAME_ID in #SPE_NAME_ID or
    a.NAME_ID in #SPE_LISTCARDEX or
    a.NAME_ID in #SPE_LISTCARDEX1
    ) and
    a.BEGIN_DATE <= dbdate(#SPE_DAFIN) and
    a.END_DATE >= dbdate(#SPE_DADEB) and
    b.FT_SUBTYPE <> 'FC' and
    (
    b.FOLIO_VIEW = '1' or
    b.FOLIO_VIEW = '3'
    ) and
    b.GROSS_AMOUNT <> 0 and
    b.GROSS_AMOUNT is not null

    select sum(b.GROSS_AMOUNT)
    from
    RESERVATION_NAME a,
    FINANCIAL_TRANSACTIONS b
    where
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    RESV_STATUS = 'CHECKED IN' and
    (
    a.NAME_ID in #SPE_NAME_ID or
    a.NAME_ID in #SPE_LISTCARDEX or
    a.NAME_ID in #SPE_LISTCARDEX1
    ) and
    a.BEGIN_DATE <= dbdate(#SPE_DAFIN) and
    a.END_DATE >= dbdate(#SPE_DADEB) and
    b.FT_SUBTYPE <> 'FC' and
    (
    b.FOLIO_VIEW = '1' or
    b.FOLIO_VIEW = '3'
    ) and
    b.GROSS_AMOUNT <> 0 and
    b.GROSS_AMOUNT is not null

    SELECT
    SUM(trx_amount)
    FROM
    opera.financial_transactions
    WHERE
    trx_code IN (
    '1932',
    '215003',
    '2151'
    )
  AND trx_date between '01/01/22' and '04/03/22'

    select
    decode(trx.RESORT, 'SH', 'EV' || substr(trx.TRX_CODE, 1, 6), trx.RESORT || substr(trx.TRX_CODE, 1, 6)) CLPROD,
    '06' TYPROD,
    trx.TRX_CODE IDPROD,
    trx.DESCRIPTION LIPROD,
    'SBM' COMARQ,
    'A' COUTIL
    from TRX$_CODES trx
    where
    (1 = 1) and
    trx.RESORT in ('SH', 'HH', 'HP', 'MC', 'BH', 'BB') and
    trx.TC_TRANSACTION_TYPE = 'C' and
    length(trx.TRX_CODE) <= 6

    select distinct
    a.RESV_NAME_ID,
    'EV' RESORT,
    nvl(substr(d.MEMBERSHIP_CARD_NO, 1, 8), substr(a.EXTERNAL_REFERENCE, 1, 8)) NUCLI,
    a.TRUNC_BEGIN_DATE DADEB,
    a.TRUNC_END_DATE DAFIN,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME,
    a.GUEST_LAST_NAME,
    c.BIRTH_DATE DANAISS,
    substr(c.SNAME, 1, 30) NOLST,
    substr(c.SFIRST, 1, 30) PRLST,
    '' CODE,
    null FLFACT,
    b.ROOM ROOM
    from
    RESERVATION_NAME a,
    NAME c,
    FINANCIAL_TRANSACTIONS b,
    MEMBERSHIPS d
    where
    (
    RESV_STATUS = 'CHECKED IN' or
    RESV_STATUS = 'CHECKED OUT'
    ) and
    GROSS_AMOUNT is not null and
    GROSS_AMOUNT <> 0 and
    (
    b.MARKET_CODE = 'JEU' or
    b.MARKET_CODE = 'JEP' or
    b.SOURCE_CODE = 'JEU'
    ) and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    (
    b.BUSINESS_DATE = <[SPE_DACOMPTA]> or
    a.TRUNC_END_DATE = <[SPE_DACOMPTA]>
    ) and
    d.MEMBERSHIP_TYPE(+) = 'JE' and
    d.INACTIVE_DATE(+) is null and
    b.RESV_NAME_ID = a.RESV_NAME_ID and
    b.RESORT = a.RESORT and
    b.RESORT = 'SH' and
    c.NAME_ID = a.NAME_ID and
    (
    substr(b.ROOM, 1, 2) = '16' or
    substr(b.ROOM, 1, 2) = '17'
    ) and
    b.ROOM not between '1600' and '1610' and
    b.ROOM not between '1780' and '1789' and
    a.NAME_ID = d.NAME_ID(+)

    select distinct
    to_char(fin.TRX_NO) CLEFAHO,
    'EV' RESORT,
    fin.TRX_AMOUNT MTECRD,
    fin.TRX_DATE DAMVT,
    case
    when (length(fin.TRX_CODE) >= 7) then substr(fin.TRX_CODE, 1, 4)
    else fin.TRX_CODE
    end IDPROD,
    trx.DESCRIPTION LIPROD,
    fin.ROOM NUSSCPTC,
    fin.FOLIO_VIEW FOLIO_VIEW,
    decode(fin.FOLIO_VIEW, 3, '1', '0') COPEC,
    nam.NAME_ID NAME_ID,
    nam.RESV_NAME_ID RESV_NAME_ID,
    '' CODE,
    null FLFACT
    from
    RESERVATION_NAME nam,
    FINANCIAL_TRANSACTIONS fin,
    TRX$_CODES trx
    where
    (1 = 1) and
    (
    (
    fin.GROSS_AMOUNT is not null and
    fin.GROSS_AMOUNT <> 0
    ) or
    (
    fin.GUEST_ACCOUNT_CREDIT is not null and
    fin.GUEST_ACCOUNT_CREDIT <> 0
    )
    ) and
    (
    fin.MARKET_CODE = 'JEU' or
    fin.MARKET_CODE = 'JEP' or
    fin.SOURCE_CODE = 'JEU'
    ) and
    fin.BUSINESS_DATE = <[SPE_DACOMPTA]> and
    (
    substr(fin.ROOM, 1, 2) = '16' or
    substr(fin.ROOM, 1, 2) = '17'
    ) and
    fin.RESORT = 'SH' and
    fin.TRX_CODE <> '590031' and
    fin.ROOM not between '1600' and '1610' and
    fin.ROOM not between '1780' and '1789' and
    nam.RESV_NAME_ID = fin.RESV_NAME_ID and
    nam.RESORT = fin.RESORT and
    fin.RESORT = trx.RESORT and
    fin.TRX_CODE = trx.TRX_CODE

    select
    LAST NOMOPE,
    FIRST PRENOMOPE,
    oiPMS_PRFORM01.DOB(BIRTH_DATE_STR) DANAISOPE,
    case
    when CASH_BL_IND ='R' then 'Oui'
    end RESTREINT
    from NAME a
    where name_id = <[NAME_ID]>

    select distinct
    a.RESV_NAME_ID,
    a.RESORT,
    '' NUCLI,
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE,
    a.NAME_ID,
    a.RESV_STATUS,
    a.SGUEST_FIRSTNAME GUEST_FIRST_NAME,
    a.GUEST_LAST_NAME,
    opera.oiPMS_PRFORM01.DOB(c.BIRTH_DATE_STR) DANAISS,
    substr(c.SNAME, 1, 30) NOLST,
    substr(c.SFIRST, 1, 30) PRLST,
    a.PARTY_CODE,
    '' NUCOMPTE,
    a.CONFIRMATION_NO,
    '' NUCLI2G,
    '' INDICFID,
    '' STATUT,
    '' CHGSTATUT,
    '' IMPRIMECARTE,
    '' COSTACLI,
    0 NBCARTE,
    dn.RATE_CODE
    from
    RESERVATION_NAME a,
    NAME c,
    RESERVATION_DAILY_ELEMENT_NAME dn
    where
    RESV_STATUS <> 'CHECKED OUT' and
    RESV_STATUS <> 'CANCELLED' and
    a.RESORT = <[SPE_RESORT]> and
    a.TRUNC_BEGIN_DATE = <[SPE_DADEB]> and
    c.NAME_ID = a.NAME_ID and
    a.GUEST_FIRST_NAME is not null and
    c.SNAME like trim(<[SPE_NOLST]>) || '%' and
    c.SFIRST like trim(<[SPE_PRLST]>) || '%' and
    a.FINANCIALLY_RESPONSIBLE_YN is null and
    dn.RESORT = a.RESORT and
    dn.RESV_NAME_ID = a.RESV_NAME_ID and
    (
    dn.ADULTS <> 0 or
    dn.CHILDREN <> 0
    )
    order by NOLST

    select distinct
    (
    select d.MEMBERSHIP_CARD_NO
    from MEMBERSHIPS d
    where
    d.NAME_ID = <[NAME_ID]> and
    d.MEMBERSHIP_TYPE = 'JE' and
    d.INACTIVE_DATE is null
    ) NUCLI,
    (
    select e.MEMBERSHIP_CARD_NO
    from MEMBERSHIPS e
    where
    e.NAME_ID = <[NAME_ID]> and
    e.MEMBERSHIP_TYPE = 'MYMC' and
    e.INACTIVE_DATE is null
    ) NUCOMPTE
    from NAME a
    where a.NAME_ID = <[NAME_ID]>

    select
    a.NAME_ID,
    LAST,
    FIRST,
    BIRTH_DATE_STR,
    SNAME,SFIRST,
    a.INSERT_DATE,
    opera.oiPMS_PRFORM01.DOB(BIRTH_DATE_STR) DNAISS,
    NATIONALITY,
    '' ADDRESS1,
    '' ADDRESS2,
    '' ADDRESS3,
    '' CITY,
    '' COUNTRY,
    null BEGIN_DATE,
    null END_DATE
    from NAME a
    where
    (
    SNAME like <[SPE_NOM]> or
    SNAME like <[SPE_NOME]>
    ) and
    SFIRST like <[SPE_PRENOM]> and
    NAME_TYPE <> 'E' and
    INACTIVE_DATE is null
    order by
    LAST,
    FIRST,
    NAME_ID desc

    select
    ADDRESS1,
    ADDRESS2,
    ADDRESS3,
    CITY,
    COUNTRY
    from NAME_ADDRESS b
    where
    NAME_ID = <[NAME_ID]> and
    ADDRESS1 is not null

    select
    a.TRUNC_BEGIN_DATE BEGIN_DATE,
    a.TRUNC_END_DATE END_DATE
    from RESERVATION_NAME a
    where
    RESV_STATUS in ('CHECKED IN', 'CHECKED OUT') and
    NAME_ID = <[NAME_ID]> and
    INSERT_DATE = (
    select max(INSERT_DATE)
    from RESERVATION_NAME b
    where
    RESV_STATUS in ('CHECKED IN', 'CHECKED OUT') and
    b.NAME_ID = a.NAME_ID
    )

    select a.NAME_ID
    from NAME a
    where a.NAME_ID > #NAME_ID
    order by a.NAME_ID

    select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID
    from RESERVATION_NAME a
    where
    a.RESORT = #RESORT and
    a.RESV_NAME_ID = #RESV_NAME_ID
    order by
    a.RESORT,
    a.RESV_NAME_ID

    select
    a.RESORT,
    a.RESV_NAME_ID,
    a.NAME_ID
    from RESERVATION_NAME a
    where
    a.RESV_NAME_ID > #RESV_NAME_ID and
    a.RESORT = #SPE_RESORT and
    a.RESV_NAME_ID = #SPE_RESV_NAME_ID and
    (1 = 2)
    order by
    a.RESORT,
    a.RESV_NAME_ID


