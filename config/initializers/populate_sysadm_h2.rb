class PopulateSysadmH2 < ActiveRecord::Base
  include ClassLogger
  Rails.application.config.after_initialize do
    logger.warn("Initializing SYSADM")
    if Settings.edodb.adapter == "h2"
      logger.warn("Connecting to SYSADM")
      establish_connection :edodb
      sql = <<-SQL

      DROP SCHEMA IF EXISTS SYSADM;
      CREATE SCHEMA SYSADM;

      DROP ALIAS IF EXISTS TO_DATE;
      CREATE ALIAS TO_DATE AS $$
        java.util.Date to_date(String value, String format) throws java.text.ParseException {

        java.text.DateFormat dateFormat = new java.text.SimpleDateFormat(format);
          return dateFormat.parse(value);
        }
      $$;

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_FAT;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_FAT (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR),
        DESCR4                      VARCHAR2(30 CHAR),
        DESCR5                      VARCHAR2(30 CHAR),
        DESCR6                      VARCHAR2(30 CHAR),
        DESCRFORMAL                 VARCHAR2(50 CHAR),
        DESCR7                      VARCHAR2(30 CHAR),
        DESCR8                      VARCHAR2(30 CHAR),
        TITLE                       VARCHAR2(30 CHAR),
        MESSAGE_TEXT_LONG           CLOB
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2017','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Non Select','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2018','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Verified','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2019','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Verified','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_CAR;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_CAR (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_CAR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','Undergraduate');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_CAR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','Graduate');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_LVL;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_LVL (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','3rd Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','3rd Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','4th Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','4th Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','4th Year');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_ENR;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_ENR (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','7 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','16 Units','Enrolled');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_RES;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_RES (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR100                    VARCHAR2(100 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','Resident');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_ISR;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_ISR (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR),
        DESCR4                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) VALUES ('11667051','61889','UCB01','2017','Independent','$342',null,'1');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) VALUES ('11667051','61889','UCB01','2018','Independent','$425','$0','1');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) VALUES ('11667051','61889','UCB01','2019','Independent','$0',null,'2');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_AD_ADMITSIR;
      CREATE TABLE SYSADM.PS_UCC_AD_ADMITSIR (
        UC_ADMITTED_GEP VARCHAR2(1),
        UC_EXPIRE_DT_ADTL DATE,
        UC_EXPIRE_DT_TDTL DATE,
        UC_ATHLETE VARCHAR2(1),
        EMPLID VARCHAR2(11),
        ACAD_CAREER VARCHAR2(4),
        DESCR VARCHAR2(30),
        STDNT_CAR_NBR NUMBER(38),
        ADM_APPL_NBR VARCHAR2(8),
        APPL_PROG_NBR NUMBER(38),
        ADM_APPL_CTR VARCHAR2(4),
        ADMIT_TERM VARCHAR2(4),
        DESCR1 VARCHAR2(30),
        ADMIT_TYPE VARCHAR2(3),
        DESCR2 VARCHAR2(30),
        PROG_STATUS VARCHAR2(4),
        PROG_REASON VARCHAR2(4),
        XLATLONGNAME VARCHAR2(30),
        PROG_ACTION VARCHAR2(4),
        DESCR3 VARCHAR2(30),
        ACAD_PROG VARCHAR2(5),
        DESCR4 VARCHAR2(30),
        EVALUATION_CODE VARCHAR2(10),
        EVALUATION_NBR NUMBER(38),
        EVALUATOR_ID VARCHAR2(11),
        EVALUATOR_NAME VARCHAR2(50),
        EVALUATOR_EMAIL VARCHAR2(70)
      );
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-10-01', 'N', '11667051', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AC', '', 'Active in Program', 'MATR', 'Matriculation', 'UCCH', 'Undergrad Chemistry');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345678', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AD', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345679', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AD', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345680', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157690', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157691', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345681', 'LAW', 'Law', 0, '00157695', 0, 'LAW', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', 'LMAY', 'Active in Program', 'MATR', 'Matriculation', 'LPRFL', 'Law Professional Programs');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345682', 'LAW', 'Law', 0, '00157692', 0, 'LAW', '2185', '2018 Summer', 'FYR', 'First Year Student', 'PM', '', 'Prematriculant', 'DEIN', 'Intention to Matriculate', 'LPRFL', 'Law Professional Programs');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_SRC;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_SRC (
        EMPLID                   VARCHAR2(11 CHAR),
        CAMPUS_ID                VARCHAR2(16 CHAR),
        INSTITUTION              VARCHAR2(5 CHAR),
        AID_YEAR                 VARCHAR2(4 CHAR),
        ITEM_TYPE                VARCHAR2(48 CHAR),
        DESCR                    VARCHAR2(30 CHAR),
        DESCRLONG                CLOB,
        FIN_AID_TYPE             VARCHAR2(16 CHAR),
        UC_AWARD_TYPE            VARCHAR2(17 CHAR),
        UC_LEFT_COL_VAL          VARCHAR2(13 CHAR),
        UC_AWARD_AMOUNT          NUMBER,
        UC_RIGHT_COL_VAL         VARCHAR2(19 CHAR),
        UC_DISBURSE_AMOUNT       NUMBER,
        UC_DESCRLONG             CLOB
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','941401620000','Wier,Mary L. Scholarship','','S','giftaid','Accepted',2063,'Disbursed',2063,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','941501880000','Rodkey Scholarship','S','','giftaid','Accepted',500,'Disbursed',500,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','941502030000','Sternheim,R Scholarship','','S','giftaid','Accepted',4127,'Disbursed',4127,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','941502710000','Mccrossin,V. Scholarship','','S','giftaid','Accepted',10000,'Disbursed',10000,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','942105500000','Summer Fee Grant','','G','giftaid','Accepted',3285,'Disbursed',3285,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','942111600000','Health Ins Allowance Grant -Fl','','G','giftaid','Accepted',1497,'Disbursed',1497,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','942111700000','Health Ins Allowance Grant -Sp','','G','giftaid','Accepted',1497,'Disbursed',1497,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','946200100000','Federal Pell Grant','','G','giftaid','Accepted',6095,'Disbursed',6095,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','946200300000','Federal SEOG Grant','','G','giftaid','Accepted',400,'Disbursed',400,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','946200900000','Summer Federal Pell Grant 2','','G','giftaid','Accepted',3047,'Disbursed',3047,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','963320100000','Fed Dir Parent PLUS Loan Smr1','','L','plusloans','Accepted',5216,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','969900400000','Expired ParentPLUS Eligibility','','L','plusloans','Offered',750,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','961100100000','Federal Subsidized Loan 1','','L','subsidizedloans','Accepted',5500,'Disbursed',5442,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','962210100000','Federal Unsubsidized Loan Q1','','L','unsubsidizedloans','Accepted',2000,'Disbursed',1980,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2019','951100100000','FWS Undergraduate Eligibility','','W','workstudy','Accepted',750,'No Earnings',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','942102900000','Berkeley Grant','','G','giftaid','Accepted',15929,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','946200100000','Federal Pell Grant','','G','giftaid','Accepted',6195,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','946200300000','Federal SEOG Grant','','G','giftaid','Accepted',400,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','961100100000','Federal Subsidized Loan 1','','L','subsidizedloans','Accepted',2750,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','961100200000','Federal Subsidized Loan 2','','L','subsidizedloans','Offered',2750,'Not Disbursed',0,'');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_SRC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,DESCR,DESCRLONG,FIN_AID_TYPE,UC_AWARD_TYPE,UC_LEFT_COL_VAL,UC_AWARD_AMOUNT,UC_RIGHT_COL_VAL,UC_DISBURSE_AMOUNT, UC_DESCRLONG) VALUES ('11667051','61889','UCB01','2020','951100100000','FWS Undergraduate Eligibility','','W','workstudy','Accepted',4000,'No Earnings',0,'');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_DSB;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_DSB (
        EMPLID                  VARCHAR2(11 CHAR),
        CAMPUS_ID               VARCHAR2(16 CHAR),
        INSTITUTION             VARCHAR2(5 CHAR),
        AID_YEAR                VARCHAR2(4 CHAR),
        ITEM_TYPE               VARCHAR2(12 CHAR),
        ACAD_CAREER             VARCHAR2(4 CHAR),
        DISBURSEMENT_ID         VARCHAR2(2 CHAR),
        DESCR                   VARCHAR2(30 CHAR),
        OFFER_BALANCE           NUMBER(11,2),
        DISBURSED_BALANCE       NUMBER(11,2),
        DISBURSEMENT_DATE       DATE,
        DESCR1                  VARCHAR2(30 CHAR),
        MESSAGE_TEXT            VARCHAR2(100 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','951101500000','UGRD','01','Fall 2018',750,0,'2018-08-13','Fall ~ Aug 13, 2018','Enrollment Data Does Not Exist For This Student.');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','951101500000','UGRD','02','Spring 2019',750,0,'2019-01-14','Spring ~ Jan 14, 2019',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900100000','UGRD','01','Fall 2018',2750,0,'2018-10-01','Fall ~ Oct 01, 2018',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900100000','UGRD','03','Spring 2019',2750,0,'2019-01-14','Spring ~ Jan 14, 2019',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900200000','UGRD','01','Fall 2018',1000,0,'2019-10-01','Fall ~ Oct 01, 2018',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900200000','UGRD','03','Spring 2019',1000,0,'2019-01-14','Spring ~ Jan 14, 2019',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900400000','UGRD','01','Fall 2018',2953,0,'2018-10-01','Fall ~ Oct 01, 2018',null);
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_DSB (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE,ACAD_CAREER,DISBURSEMENT_ID,DESCR,OFFER_BALANCE,DISBURSED_BALANCE,DISBURSEMENT_DATE,DESCR1,MESSAGE_TEXT) VALUES ('26848871','1097452','UCB01','2019','969900400000','UGRD','03','Spring 2019',2953,0,'2019-01-14','Spring ~ Jan 14, 2019',null);

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_W2L;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_W2L (
        EMPLID                VARCHAR2(11 CHAR),
        CAMPUS_ID             VARCHAR2(16 CHAR),
        INSTITUTION           VARCHAR2(5 CHAR),
        AID_YEAR              VARCHAR2(4 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_W2L (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR) VALUES ('11667051','61889','UCB01','2020');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_L2W;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_L2W (
        EMPLID                VARCHAR2(11 CHAR),
        CAMPUS_ID             VARCHAR2(16 CHAR),
        INSTITUTION           VARCHAR2(5 CHAR),
        AID_YEAR              VARCHAR2(4 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_L2W (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR) VALUES ('11667051','61889','UCB01','2020');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_RDC;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_RDC (
        EMPLID                VARCHAR2(11 CHAR),
        CAMPUS_ID             VARCHAR2(16 CHAR),
        INSTITUTION           VARCHAR2(5 CHAR),
        AID_YEAR              VARCHAR2(4 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_RDC (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR) VALUES ('11667051','61889','UCB01','2020');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_LNS;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_LNS (
        EMPLID                VARCHAR2(11 CHAR),
        CAMPUS_ID             VARCHAR2(16 CHAR),
        INSTITUTION           VARCHAR2(5 CHAR),
        AID_YEAR              VARCHAR2(4 CHAR),
        ITEM_TYPE             VARCHAR2(12 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_LNS (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,ITEM_TYPE) VALUES ('11667051','61889','UCB01','2020','961100200000');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_AWRD_OUT;
      CREATE TABLE SYSADM.PS_UCC_FA_AWRD_OUT (
        INSTITUTION           VARCHAR2(5 CHAR),
        AID_YEAR              VARCHAR2(4 CHAR),
      );

      INSERT INTO SYSADM.PS_UCC_FA_AWRD_OUT (INSTITUTION,AID_YEAR) VALUES ('UCB01','2018');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_OUT (INSTITUTION,AID_YEAR) VALUES ('UCB01','2019');
      INSERT INTO SYSADM.PS_UCC_FA_AWRD_OUT (INSTITUTION,AID_YEAR) VALUES ('UCB01','2020');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_SR_LAPSE_DT;
      CREATE TABLE SYSADM.PS_UCC_SR_LAPSE_DT (
        INSTITUTION	VARCHAR2(5),
        STRM VARCHAR2(4),
        CLASS_NBR	NUMBER(38),
        LAPSE_DEADLINE DATE,
        EMPLID VARCHAR2(11),
        ACAD_CAREER	VARCHAR2(4)
      );
      INSERT INTO SYSADM.PS_UCC_SR_LAPSE_DT (INSTITUTION, STRM, CLASS_NBR, LAPSE_DEADLINE, EMPLID, ACAD_CAREER) VALUES('UCB01','2178','12392',PARSEDATETIME('2019-07-31', 'yyyy-mm-dd'),'11667051','UGRD');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_NOTENRL_RSN;
      CREATE TABLE SYSADM.PS_UCC_NOTENRL_RSN (
        EMPLID VARCHAR2(11),
        ACAD_CAREER	VARCHAR2(4),
        INSTITUTION	VARCHAR2(5),
        STRM VARCHAR2(4),
        CLASS_NBR	NUMBER(38),
        MESSAGE_NBR VARCHAR2(10),
        ERROR_MESSAGE_TXT VARCHAR2(255),
        UC_ENRL_LASTATTMPT DATE,
        UC_REASON_DESC VARCHAR2(255)
      );
      INSERT INTO SYSADM.PS_UCC_NOTENRL_RSN (EMPLID, ACAD_CAREER, INSTITUTION, STRM, CLASS_NBR, MESSAGE_NBR, ERROR_MESSAGE_TXT, UC_ENRL_LASTATTMPT, UC_REASON_DESC) VALUES('11667051','UGRD','UCB01','2178',12392,'213','Available seats are reserved.', PARSEDATETIME('2019-07-31', 'yyyy-mm-dd'),'Reserved Seats');

      SQL

      connection.execute sql
    end
  end
end