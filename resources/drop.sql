ALTER TABLE USERS DROP CONSTRAINT FK_USERS_BRANCHID
ALTER TABLE COASETUP DROP CONSTRAINT FK_COASETUP_BRANCHID
ALTER TABLE COASETUP DROP CONSTRAINT COASETUP_DEPARTMENTID
ALTER TABLE COASETUP DROP CONSTRAINT FK_COASETUP_CURRENCYID
ALTER TABLE COASETUP DROP CONSTRAINT FK_COASETUP_CCOAID
ALTER TABLE CCOA DROP CONSTRAINT FK_CCOA_BRANCHID
ALTER TABLE CCOA DROP CONSTRAINT FK_CCOA_CURRENCYID
ALTER TABLE CCOA DROP CONSTRAINT FK_CCOA_COAID
ALTER TABLE CCOA DROP CONSTRAINT FK_CCOA_DEPARTMENTID
ALTER TABLE PREV_CCOA DROP CONSTRAINT FK_PREV_CCOA_COAID
ALTER TABLE PREV_CCOA DROP CONSTRAINT PREV_CCOA_DEPARTMENTID
ALTER TABLE PREV_CCOA DROP CONSTRAINT PREV_CCOA_CURRENCYID
ALTER TABLE PREV_CCOA DROP CONSTRAINT FK_PREV_CCOA_BRANCHID
ALTER TABLE RATEINFO DROP CONSTRAINT FK_RATEINFO_CUR
ALTER TABLE RATEINFO DROP CONSTRAINT FK_RATEINFO_TOCUR
ALTER TABLE ALLOCATE_CODE DROP CONSTRAINT FK_ALLOCATE_CODE_COAID
ALTER TABLE ALLOCATE_CODE DROP CONSTRAINT LLOCATECODEDPARTMENTID
ALTER TABLE TLF DROP CONSTRAINT FK_TLF_DEPARTMENTID
ALTER TABLE TLF DROP CONSTRAINT FK_TLF_CURRENCYID
ALTER TABLE TLF DROP CONSTRAINT FK_TLF_TRANTYPEID
ALTER TABLE TLF DROP CONSTRAINT FK_TLF_CCOAID
ALTER TABLE TLF DROP CONSTRAINT FK_TLF_BRANCHID
ALTER TABLE TLF_HIST DROP CONSTRAINT FK_TLF_HIST_BRANCHID
ALTER TABLE TLF_HIST DROP CONSTRAINT FK_TLF_HIST_CURRENCYID
ALTER TABLE TLF_HIST DROP CONSTRAINT TLF_HIST_DEPARTMENTID
ALTER TABLE TLF_HIST DROP CONSTRAINT FK_TLF_HIST_TRANTYPEID
ALTER TABLE TLF_HIST DROP CONSTRAINT FK_TLF_HIST_CCOAID
ALTER TABLE FORMATFILE DROP CONSTRAINT FK_FORMATFILE_DEPTID
ALTER TABLE FORMATFILE DROP CONSTRAINT FK_FORMATFILE_COAID
ALTER TABLE CUSTOM_ID_GEN DROP CONSTRAINT CUSTOM_ID_GEN_BRANCHID
ALTER TABLE VW_CCOA DROP CONSTRAINT FK_VW_CCOA_BRANCHID
ALTER TABLE VW_CCOA DROP CONSTRAINT FK_VW_CCOA_CURRENCYID
ALTER TABLE VW_CCOA DROP CONSTRAINT VW_CCOA_DEPARTMENTID
ALTER TABLE VW_CCOA DROP CONSTRAINT FK_VW_CCOA_COAID
ALTER TABLE VW_TLF DROP CONSTRAINT FK_VW_TLF_CURID
ALTER TABLE VW_TLF DROP CONSTRAINT FK_VW_TLF_CCOAID
ALTER TABLE VW_TLF DROP CONSTRAINT FK_VW_TLF_BRANCHID
ALTER TABLE VW_BANKCASH DROP CONSTRAINT VW_BANKCASH_BRANCHID
ALTER TABLE VW_BANKCASH DROP CONSTRAINT FK_VW_BANKCASH_CURID
ALTER TABLE USER_ROLE DROP CONSTRAINT FK_USER_ROLE_ROLE_ID
ALTER TABLE USER_ROLE DROP CONSTRAINT FK_USER_ROLE_USER_ID
ALTER TABLE ROLE_WEBPAGE DROP CONSTRAINT ROLEWEBPAGEWEBPAGES_ID
ALTER TABLE ROLE_WEBPAGE DROP CONSTRAINT ROLE_WEBPAGE_ROLE_ID
DROP INDEX USERSFK_USERS_BRANCHID
DROP TABLE USERS
DROP TABLE ROLE
DROP TABLE WEBPAGE
DROP TABLE COA
DROP INDEX CSTUPFKCASETUPBRANCHID
DROP INDEX CSTUPCSTUPDEPARTMENTID
DROP INDEX CSTPFKCSETUPCURRENCYID
DROP INDEX CSETUPFKCOASETUPCCOAID
DROP TABLE COASETUP
DROP INDEX CCOA_FK_CCOA_BRANCHID
DROP INDEX CCOAFK_CCOA_CURRENCYID
DROP INDEX IX_CCOA_FK_CCOA_COAID
DROP INDEX CCOAFKCCOADEPARTMENTID
DROP TABLE CCOA
DROP INDEX PRVCCOAFKPREVCCOACOAID
DROP INDEX PRVCCPRVCCDEPARTMENTID
DROP INDEX PRVCCAPRVCCACURRENCYID
DROP INDEX PRVCCFKPRVCCOABRANCHID
DROP TABLE PREV_CCOA
DROP TABLE BRANCH
DROP TABLE CUR
DROP INDEX RATEINFOFKRATEINFO_CUR
DROP INDEX RTEINFOFKRATEINFOTOCUR
DROP TABLE RATEINFO
DROP TABLE DEPTCODE
DROP TABLE TRANTYPE
DROP INDEX LLCTCDEFKLLCTCODECOAID
DROP INDEX LLCTCDLLCTCDDPRTMENTID
DROP TABLE ALLOCATE_CODE
DROP INDEX TLFFK_TLF_DEPARTMENTID
DROP INDEX TLF_FK_TLF_CURRENCYID
DROP INDEX TLF_FK_TLF_TRANTYPEID
DROP INDEX IX_TLF_FK_TLF_CCOAID
DROP INDEX IX_TLF_FK_TLF_BRANCHID
DROP TABLE TLF
DROP INDEX TLFHSTFKTLFHSTBRANCHID
DROP INDEX TLFHSTFKTLFHSTCRRNCYID
DROP INDEX TLFHSTTLFHSTDPRTMENTID
DROP INDEX TLFHSTFKTLFHSTTRNTYPID
DROP INDEX TLFHISTFKTLFHISTCCOAID
DROP TABLE TLF_HIST
DROP INDEX FRMTFLFKFRMTFILEDEPTID
DROP INDEX FRMTFLEFKFRMTFILECOAID
DROP TABLE FORMATFILE
DROP INDEX CSTMDGNCSTMDGNBRANCHID
DROP TABLE CUSTOM_ID_GEN
DROP TABLE SYSPOST
DROP TABLE SETUP
DROP TABLE VW_CASHBOOK
DROP INDEX VWCCOAFKVWCCOABRANCHID
DROP INDEX VWCCFKVWCCOACURRENCYID
DROP INDEX VWCCAVWCCADEPARTMENTID
DROP INDEX VWCCOAFK_VW_CCOA_COAID
DROP TABLE VW_CCOA
DROP INDEX VW_TLF_FK_VW_TLF_CURID
DROP INDEX VW_TLFFK_VW_TLF_CCOAID
DROP INDEX VWTLFFKVW_TLF_BRANCHID
DROP TABLE VW_TLF
DROP INDEX VWBNKCSHVWBNKCSHBRNCHD
DROP INDEX VWBNKCSHFKVWBNKCSHCRID
DROP TABLE VW_BANKCASH
DROP INDEX SRROLEFKUSERROLEROLEID
DROP INDEX SRROLEFKUSERROLEUSERID
DROP TABLE USER_ROLE
DROP INDEX RLWBPGRLWBPGWEBPAGESID
DROP INDEX RLWBPAGERLWBPAGEROLEID
DROP TABLE ROLE_WEBPAGE
DELETE FROM ID_GEN WHERE GEN_NAME = 'FORMATFILE_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'USER_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'WEBPAGE_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'COA_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'DEPARTMENT_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'BRANCH_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'CCOA_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'RATEINFO_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'TLF_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'ROLE_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'COASETUP_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'SETUP_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'CCOA_HISTORY_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'TRANTYPE_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'ALLOCATECODE_GEN'
DELETE FROM ID_GEN WHERE GEN_NAME = 'CURRENCY_GEN'
