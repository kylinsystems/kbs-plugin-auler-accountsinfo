-- View: adempiere.as1_balanceofaccounts_iw

-- DROP VIEW adempiere.as1_balanceofaccounts_iw;

CREATE OR REPLACE VIEW adempiere.as1_balanceofaccounts_iw AS 
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'N'::text AS sum,
    'N'::text AS onday,
    'N'::text AS onmonth,
    'N'::text AS onyear,
    'N'::text AS perday,
    ev.value,
    ev.name,
    fac.dateacct::date AS dateacct,
    COALESCE(fac.amtacctdr, 0::numeric) AS debit,
    COALESCE(fac.amtacctcr, 0::numeric) AS credit,
    COALESCE(fac.amtacctdr - fac.amtacctcr, 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fac ON fac.account_id = ev.c_elementvalue_id
UNION
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'Y'::text AS sum,
    'Y'::text AS onday,
    'N'::text AS onmonth,
    'N'::text AS onyear,
    'N'::text AS perday,
    ev.value,
    ev.name,
    adempiere.firstof(fa.dateacct::timestamp with time zone, 'DD'::character varying) AS dateacct,
    COALESCE(sum(fa.amtacctdr), 0::numeric) AS debit,
    COALESCE(sum(fa.amtacctcr), 0::numeric) AS credit,
    COALESCE(sum(fa.amtacctdr) - sum(fa.amtacctcr), 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fa ON fa.account_id = ev.c_elementvalue_id
  GROUP BY ev.value, ev.name, ev.c_elementvalue_id, ev.ad_client_id, ev.ad_org_id, ev.isactive, ev.created, ev.createdby, ev.updated, ev.updatedby, adempiere.firstof(fa.dateacct::timestamp with time zone, 'DD'::character varying)
UNION
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'Y'::text AS sum,
    'N'::text AS onday,
    'Y'::text AS onmonth,
    'N'::text AS onyear,
    'N'::text AS perday,
    ev.value,
    ev.name,
    (date_trunc('month'::text, adempiere.firstof(fa.dateacct::timestamp with time zone, 'MM'::character varying)::timestamp with time zone) + 1::double precision * '1 mon'::interval) OPERATOR(adempiere.-) 1::numeric AS dateacct,
    COALESCE(sum(fa.amtacctdr), 0::numeric) AS debit,
    COALESCE(sum(fa.amtacctcr), 0::numeric) AS credit,
    COALESCE(sum(fa.amtacctdr) - sum(fa.amtacctcr), 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fa ON fa.account_id = ev.c_elementvalue_id
  GROUP BY ev.value, ev.name, ev.c_elementvalue_id, ev.ad_client_id, ev.ad_org_id, ev.isactive, ev.created, ev.createdby, ev.updated, ev.updatedby, adempiere.firstof(fa.dateacct::timestamp with time zone, 'MM'::character varying)
UNION
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'Y'::text AS sum,
    'N'::text AS onday,
    'N'::text AS onmonth,
    'Y'::text AS onyear,
    'N'::text AS perday,
    ev.value,
    ev.name,
    (date_trunc('month'::text, adempiere.firstof(fa.dateacct::timestamp with time zone, 'YY'::character varying)::timestamp with time zone) + 12::double precision * '1 mon'::interval) OPERATOR(adempiere.-) 1::numeric AS dateacct,
    COALESCE(sum(fa.amtacctdr), 0::numeric) AS debit,
    COALESCE(sum(fa.amtacctcr), 0::numeric) AS credit,
    COALESCE(sum(fa.amtacctdr) - sum(fa.amtacctcr), 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fa ON fa.account_id = ev.c_elementvalue_id
  GROUP BY ev.value, ev.name, ev.c_elementvalue_id, ev.ad_client_id, ev.ad_org_id, ev.isactive, ev.created, ev.createdby, ev.updated, ev.updatedby, adempiere.firstof(fa.dateacct::timestamp with time zone, 'YY'::character varying)
UNION
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'Y'::text AS sum,
    'N'::text AS onday,
    'N'::text AS onmonth,
    'N'::text AS onyear,
    'N'::text AS perday,
    ev.value,
    ev.name,
    NULL::date AS dateacct,
    COALESCE(sum(fa.amtacctdr), 0::numeric) AS debit,
    COALESCE(sum(fa.amtacctcr), 0::numeric) AS credit,
    COALESCE(sum(fa.amtacctdr) - sum(fa.amtacctcr), 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fa ON fa.account_id = ev.c_elementvalue_id
  GROUP BY ev.value, ev.name, ev.c_elementvalue_id, ev.ad_client_id, ev.ad_org_id, ev.isactive, ev.created, ev.createdby, ev.updated, ev.updatedby
UNION
 SELECT ev.c_elementvalue_id AS as1_balanceofaccounts_iw_id,
    ev.ad_client_id,
    ev.ad_org_id,
    ev.isactive,
    ev.created,
    ev.createdby,
    ev.updated,
    ev.updatedby,
    'N'::text AS sum,
    'N'::text AS onday,
    'N'::text AS onmonth,
    'N'::text AS onyear,
    'Y'::text AS perday,
    ev.value,
    ev.name,
    fa.dateacct,
    COALESCE(( SELECT sum(fact_acct.amtacctdr) AS sum
           FROM adempiere.fact_acct
          WHERE fact_acct.dateacct <= fa.dateacct AND fact_acct.account_id = fa.account_id), 0::numeric) AS debit,
    COALESCE(( SELECT sum(fact_acct.amtacctcr) AS sum
           FROM adempiere.fact_acct
          WHERE fact_acct.dateacct <= fa.dateacct AND fact_acct.account_id = fa.account_id), 0::numeric) AS credit,
    COALESCE(COALESCE(( SELECT sum(fact_acct.amtacctdr) AS sum
           FROM adempiere.fact_acct
          WHERE fact_acct.dateacct <= fa.dateacct AND fact_acct.account_id = fa.account_id), 0::numeric) - COALESCE(( SELECT sum(fact_acct.amtacctcr) AS sum
           FROM adempiere.fact_acct
          WHERE fact_acct.dateacct <= fa.dateacct AND fact_acct.account_id = fa.account_id), 0::numeric), 0::numeric) AS balance
   FROM adempiere.c_elementvalue ev
     LEFT JOIN adempiere.fact_acct fa ON fa.account_id = ev.c_elementvalue_id
  GROUP BY ev.value, ev.name, ev.c_elementvalue_id, ev.ad_client_id, ev.ad_org_id, ev.isactive, ev.created, ev.createdby, ev.updated, ev.updatedby, fa.dateacct, fa.account_id
  ORDER BY 14, 16;

ALTER TABLE adempiere.as1_balanceofaccounts_iw
  OWNER TO adempiere;
