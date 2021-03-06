--sp_helptext 'sp_udpate_snapshot_proper_status'

--USE BDESime
USE BDEsime
GO
/* 
Date created:	20160302 Susan Delaney 
Description:	Gets all database tables with wildcard query string:
*/ 
--select top 3 *  from original_loan where [NEW LOAN SETUP DATE] > '10/1/2016'
SELECT [schema] = SCHEMA_NAME(schema_id) 
,[table] = t.name 
,[column] = c.name 
FROM sys.tables AS t
INNER JOIN sys.columns c
ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%fc stop%'
--and t.name like 'loan%'
ORDER BY t.name, c.name

/*
select * from bde_data.dbo.datadictionary163 where [field level / name] like 'ar_%'--[business element name] like '%arm%' and length > 9

SELECT distinct obj.Name SPName--, sc.TEXT SPText
FROM sys.syscomments sc
INNER JOIN sys.objects obj ON sc.Id = obj.OBJECT_ID
WHERE sc.TEXT LIKE '%pool%'
AND TYPE IN ('P','f','u')

-- EXEC [dbo].[sp_ExportEverbankTradeData]

select [loan number], [FNMA POOL NUMBER],[GNMA POOL NUMBER] from loan where [fNMA POOL NUMBER] is null and [gNMA POOL NUMBER] is not null

sp_helptext 'dbo.sp_portfolio_pull_rpt' 

select report_date, amount = sum(amount) 
from msp.p4CF 
where report_date = '2017-06-12 00:00:00.000' 
and [tran] in (710,711,712,713,714,745,766)
group by report_date

select [loan number], [tax disbursement amount], [tax disbursement due date] from tax where [loan number] = '0000987560'
select distinct ln_no, es_city_tax_am, es_county_tax_am,es_tax_tran_dt FROM bde_data.dbo.escrow where [ln_no] = '0000987560' 

select top 100 [loan number], [gnma pool number] from loan where  [gnma pool number] is not null and [loan number] in ('0002202042','002408599')
select distinct [POOL NUMBER] from investor_category  where [POOL NUMBER] = '00AR1365cd'

select top 10 * from [Foreclosure]
select * from payment_tran
select count(*) from servicing_fee where [loan number] = '0014131718' --	4010858713'

Select * from bde_data.[dbo].[datadictionary] where description like '%c%rp%' --tablename like '%property%'
select top 100 bkr_filing_dt,bkr_removal_dt, * from bankruptcy
select * from foreclosure

select top 100 [Loan Number],[IMMINENT DEFAULT FICO DATE], [IMMINENT DEFAULT FICO SCORE] from bdesime.dbo.delinquency where [IMMINENT DEFAULT FICO DATE] is not null and convert(date,[IMMINENT DEFAULT FICO DATE]) > '7/1/2016'
select * from tbl_fico_bands
select co_im_dflt_fico_dt, co_im_dflt_fico_xx from delinquency where co_im_dflt_fico_dt is not null and convert(date,co_im_dflt_fico_dt) > '7/1/2016'
select top 100 [ln], fico from bdesime.sime.five9_results where convert(date,date_added) > '7/1/2016'
select top 100 ficoScore from sime.advantageCreditImport
select ln_no, usr_6_pos1_xx, load_date from user_defined where usr_6_pos1_xx = 'evb001'

SELECT * FROM sys.sysobjects where xtype ='p' order by name -- alpha listing of stored procs in the active db
 
select * from loan where ln_1st_prin_ba > 0 and ln_no = '0012028262'

select * from promise_to_pay

select distinct disposition from bde_data.dbo.five9_activity

RPC - External Online Pmt
RPC - Loan Brought Current
RPC - No Promise to Pay
RPC - One Time Draft Obtained
RPC - Promise to Pay
RPC - Promise to Pay - Other Than One Time Draft
RPC - PTP Bill Pay
RPC - PTP CCN Pmt
RPC - PTP Mailed Pmt
RPC - PTP Phone Pmt

*/

/*
use BDEsime

SELECT o.name, o.id, c.text, o.type 
from sysobjects o 
right join syscomments c 
on o.id = c.id 
where c.text like '%office%code%'

select top 10 * from bdesime.dbo.payee where [ca hist transaction date] = '2016-07-19 00:00:00.000'
SELEct top 100 * from property

*/


---- @parm   1 = include REO's , 0 = exclude REO's
--declare @parm int = 1
--select distinct proper_status 
--from bdesime.dbo.delinquency_snapshot
--WHERE proper_status LIKE 
--		CASE WHEN @parm = 0 THEN '[^reo]%'
--		ELSE '%' 
--		END

--declare @parm char(3) = 'REO'
--select top 3 * from bdesime.dbo.delinquency_snapshot
--WHERE proper_status LIKE '%' + @parm  + '%'

/*
	-- 3/17/2017  SDelaney Added business day logic
	 DECLARE @LocalClient	varchar(max) = 'tms000,evb001'
	 DECLARE @localEndDate	date	= '4/10/2017'
	 
	 -- logic to exclude weekends
	 IF  ( DATENAME(weekday,getDATE()) = 'Monday' ) BEGIN SET @localEndDate = CAST(GETDATE()-3 as date) END
	 IF  ( DATENAME(weekday,getDATE()) = 'Sunday' ) BEGIN SET @localEndDate = CAST(GETDATE()-2 as date) END
     IF  ( DATENAME(weekday,getDATE()) IN ('Tuesday','Wednesday','Thursday','Friday','Saturday')) BEGIN SET @localEndDate = CAST(GETDATE()-1 as date) END

	 SELECT top 10 l.[Loan Number], ic.Client, ic.Investor, ic.Inv_id, ic.inv_cat, l.[gnma pool number]
	-- INTO #ClientLoans
	 FROM bdesime.dbo.loan l
		inner join bde_data.dbo.investor_client ic on ic.inv_id = l.[investor id] and ic.inv_cat = l.[category code]
		and ic.client in (select b.item from BDESime.dbo.fnMultiValueSplit(@LocalClient, ',') b) 
		where l.[gnma pool number] is not null
*/