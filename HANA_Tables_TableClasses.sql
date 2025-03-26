WITH 

/* 

[NAME]

- HANA_Tables_TableClasses

[DESCRIPTION]

- Disk or memory size for tables grouped by table classes

[SOURCE]

- SAP Note 1969700
[DETAILS AND RESTRICTIONS]

- Tables < 5 MB are not considered to avoid high name mapping overhead
- Prefixes ("/.../") of table names (namespaces) are listed in transaction SE03 -> Objects -> "Namespace Information System" or
  table TRNSPACETT
- Special comparison details: "#" is used LIKE escape character, leading {SC} indicates schema instead of table name, leading {LR} indicates LIKE_REGEXPR instead of LIKE

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2014/03/07: 1.0 (initial version)
- 2015/10/19: 1.1 (CPMB tables included)
- 2015/11/20: 1.2 (further table classes added)
- 2016/03/02: 1.3 (CURMEM, MAXMEM and DISK added)
- 2017/07/25: 1.4 (S/4HANA / ERP table classes added)
- 2017/09/02: 1.5 (Enterprise Threat Detection / ETD class added)
- 2018/06/20: 1.6 (BDS, CRM_MID, ABAP_WU, PPF added)
- 2018/06/29: 1.7 (various further refinements)
- 2018/07/05: 1.8 (TABLE_1, TABLE_2 and TABLE_3 included)
- 2018/07/21: 1.9 (DBACOCKPIT and advanced DSO classes added)
- 2018/10/23: 2.0 (structure change from comparisons to join to avoid high parsing time, high number of generated expressions and high SQL cache utilization)
- 2021/06/14: 2.1 (removal of comma concatenation around table list to minimize memory requirements)
- 2024/01/07: 2.2 (top list extended from 3 to 10 tables)

[INVOLVED TABLES]

- M_CS_TABLES
- M_RS_TABLES
- M_RS_INDEXES
- M_TABLE_PERSISTENCE_STATISTICS

[INPUT PARAMETERS]

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3' --> specific schema SAPSR3
  'SAP%'   --> all schemata starting with 'SAP'
  '%'      --> all schemata

- SPACE_LAYER

  Layer of space allocation to be used

  'DISK'   --> Disk space allocation
  'CURMEM' --> Current memory allocation
  'MAXMEM' --> Maximum memory allocation

- MIN_SIZE_MB

  Minimum total size in MB

  10 --> Minimum total size of 10 MB
  -1 --> No minimum total size limitation

[OUTPUT PARAMETERS]

- SPACE_LAYER:        Space layer (CURMEM -> current memory allocation, MAXMEM -> maximum memory allocation, DISK -> disk space utilization)
- CLASS:              Table class
- DESCRIPTION:        Description of table class
- SIZE_GB:            Size of table (+ indexes and LOBs)
- SIZE_PCT:           Percentage of size compared to overall size
- TABLE_<n>:          Top <n> largest table in class (incl. size)

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LAYER|TABLE_CLASS|DESCRIPTION                                                             |SIZE_GB |SIZE_PCT|TABLE_1                                    |TABLE_2                           |TABLE_3                                 |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|DISK |/B%/A      |BW: DSO / ODS tables (various)                                          | 3855.25|   53.72|/BIC/AZSD09571 (470.86 GB)                 |/BIC/AZWD09762 (161.33 GB)        |/BIC/AZWDPT222 (104.84 GB)              |
|DISK |/B%/B      |BW: PSA / Standard DSO (change log)                                     | 2087.54|   29.08|/BIC/B0082011000 (172.97 GB)               |/BIC/B0082012000 (160.70 GB)      |/BIC/B0082010000 (159.44 GB)            |
|DISK |/B%/A_00   |BW: Standard DSO (active data) / Write-optimized DSO / Direct-update DSO|  834.35|   11.62|/BIC/AZSD00542 (193.40 GB)                 |/BIC/AZSD00942 (108.37 GB)        |/BIC/AZSD00532 (84.54 GB)               |
|DISK |/B%/S      |BW: SID tables                                                          |   70.18|    0.97|/BIC/SZGICW929 (9.45 GB)                   |/BIC/SZGICWZ28 (5.35 GB)          |/BIC/SZGICWE20 (5.30 GB)                |
|DISK |Z          |Customer tables                                                         |   58.67|    0.81|Y8891010000815 (4.70 GB)                   |Y8891010000525 (4.63 GB)          |Y8891010000516 (2.55 GB)                |
|DISK |RS         |BW: Technical tables                                                    |   52.82|    0.73|RSBATCHDATA (24.65 GB)                     |RSBERRORLOG (5.27 GB)             |RSBMREQ_DTP (3.77 GB)                   |
|DISK |/B%/P      |BW: Time independent attributes                                         |   51.51|    0.71|/BIC/PZGICWZ28 (6.11 GB)                   |/BIC/PZGICWE20 (5.78 GB)          |/BIC/PZGICW929 (5.44 GB)                |
|DISK |/B%/A%40   |BW: Standard DSO (activation queue)                                     |   31.77|    0.44|/BIC/AZSD04032 (10.97 GB)                  |/BIC/AZWDPT402 (9.68 GB)          |/BIC/AZSD09402 (2.74 GB)                |
|DISK |BC_SBAL    |Application log                                                         |   23.25|    0.32|BALDAT (20.56 GB)                          |BALDAT (1.57 GB)                  |BALHDR (1.02 GB)                        |
|DISK |ABAP       |ABAP and basis                                                          |   21.31|    0.29|REPOLOAD (5.31 GB)                         |REPOLOAD (4.72 GB)                |REPOSRC (3.17 GB)                       |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LAYER|TABLE_CLASS|DESCRIPTION                         |SIZE_GB |SIZE_PCT|TABLE_1                                    |TABLE_2                           |TABLE_3                                 |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|DISK |/PM0/      |Financial services policy management| 3147.39|   84.55|/PM0/ABDAPOXML (2337.30 GB)                |/PM0/ABDTCLUST (361.93 GB)        |/PM0/ABDNNOCASH (121.04 GB)             |
|DISK |BC_SBAL    |Application log                     |  284.01|    7.63|BALDAT (277.41 GB)                         |BALHDR (6.59 GB)                  |                                        |
|DISK |Z          |Customer tables                     |   72.08|    1.93|ZDM_ICM_OBJ (24.10 GB)                     |ZDM_ICM_ACT (10.41 GB)            |ZDM_ICM_INV (10.02 GB)                  |
|DISK |RFC        |Remote function calls (RFC)         |   40.62|    1.09|ARFCSDATA (38.52 GB)                       |ARFCSSTATE (2.04 GB)              |TRFCQOUT (0.05 GB)                      |
|DISK |/SSF/      |Service software framework          |   26.11|    0.70|/SSF/ATAB (26.07 GB)                       |/SSF/BTAB (0.03 GB)               |/SSF/PTAB (0.00 GB)                     |
|DISK |SPOOL      |Spool / TemSe                       |   26.08|    0.70|TST03 (26.06 GB)                           |TST01 (0.02 GB)                   |TSPEVJOB (0.00 GB)                      |
|DISK |/DFI/      |Development factory insurance       |   24.87|    0.66|/DFI/ABDNNOCASH (20.01 GB)                 |/DFI/ALDFGNLSAMT (4.07 GB)        |/DFI/ABDAOPR (0.54 GB)                  |
|DISK |SXMS       |XI integration server               |   19.20|    0.51|SXMSCLUP (13.03 GB)                        |SXMSCLUR (5.02 GB)                |SXMSPFRAWD (0.65 GB)                    |
|DISK |AUDIT      |SAP HANA auditing                   |   12.17|    0.32|CS_AUDIT_LOG_ (12.17 GB)                   |                                  |                                        |
|DISK |ABAP       |ABAP and basis                      |   11.69|    0.31|REPOLOAD (5.24 GB)                         |REPOSRC (2.96 GB)                 |D010TAB (1.45 GB)                       |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

TABLE_CLASS_MAPPING AS
( SELECT
    PRIORITY,
    CLASS,
    DESCRIPTION,
    '%' SCHEMA_NAME,
    SCHEMA_TABLE_NAME TABLE_NAME
/*   CASE WHEN LOCATE(SCHEMA_TABLE_NAME, '.') = 0 THEN '%'               ELSE SUBSTR(SCHEMA_TABLE_NAME, 1, LOCATE(SCHEMA_TABLE_NAME, '.') - 1) END SCHEMA_NAME,
    CASE WHEN LOCATE(SCHEMA_TABLE_NAME, '.') = 0 THEN SCHEMA_TABLE_NAME ELSE SUBSTR(SCHEMA_TABLE_NAME, LOCATE(SCHEMA_TABLE_NAME, '.') + 1) END TABLE_NAME
*/
  FROM
  ( SELECT
      B.PRIORITY,
      B.CLASS,
      B.DESCRIPTION,
      SUBSTR(B.TABLES, LOCATE(B.TABLES, ',', 1, O.ROWNO) + 1, LOCATE(B.TABLES, ',', 1, O.ROWNO + 1) - LOCATE(B.TABLES, ',', 1, O.ROWNO) - 1) SCHEMA_TABLE_NAME
    FROM
    ( SELECT TOP 1000 ROW_NUMBER() OVER () ROWNO FROM OBJECTS ) O,
    ( SELECT
        PRIORITY,
        CLASS,
        DESCRIPTION,
        TABLES TABLES
      FROM
      ( SELECT 100 PRIORITY, 'A' CLASS,    'Pricing Conditions' DESCRIPTION,
                             ',{LR}^A[0-9][0-9][0-9]$,A9__,' TABLES                                                                                                                           FROM DUMMY UNION ALL
        SELECT 110, 'ABAP',       'ABAP and Basis',
                             ',ABTREE,ATAB,BUFF#_PRELOAD,COV#_GENDATA,CSL#_UBR,D010%,D021T,D342L,DYNP%,DEMO#_INDX#_TABLE,DOKCLU,DOKTL,DWTREE,EUFUNC,FPM#_T#_ATTACHMENT,FUNCT,GEOLOC,' ||
                             'GEOOBJR,HRIADATANR,IACTU#_C1,ILM#_NOTIF#_CONT,I18NSRHRES,NWBC#_NAV#_TREE,O2PAGCON,PKRT#_LOAD,PKRT#_LOAD#_DEP,REPO%,SLIN#_CACHE#_%,TCURR,' ||
                             'RSMPTEXTS,RTMDATA,SATC#_%,SATR#_TAB,SCAPPT%,SCGENAPPT,SCMG%,SCPARTICIP,SCPRVALS,SCR#_ABAP%,' ||
                             'SEOCOMPODF,SEOCOMPOTX,SEOSUBCO,SEOSUBCODF,SEOSUBCOTX,SLIN#_CACHE#_02,SMODISRC,SNAP,SRCICREL,SRGBINREL,SRGBTBREL,SROBLBREL,SROBLROL%,SSCOOKIE,' ||
                             'SSPRTPROVREPORT1,SUSG#_DATA,SUSG#_SUB,SUSG#_ODATA,SUSG#_PROC,SYCM#_CUST#_REFS,TILM#_STOR%,TPFET,TTSTRCOMP,UPGTDELTA,VARI,VARIT,WWWDATA,'                        FROM DUMMY UNION ALL
        SELECT 100, 'ACC_DOC',    'AC Interface',
                             ',ACCTCR,ACCTHD,ACCTIT,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'ADR',        'Addresses',
                             ',ADC%,ADR%,SADR%,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'ANA',        'Analytics Framework',
                             ',ANA#_D#_OBJECT#_USAGE,'                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'APPLOG',     'BYD: Application Log',
                             ',APPLOG#_%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'APQ',        'Batch Input',
                             ',APQ%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'AQ',         'SAP Query',
                             ',AQGDB,AQGTQ,AQLDB,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'APXR',       'BYD: XRepository',
                             ',APXR#_%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'ASAP',       'Accelerated SAP',
                             ',SASACONT1,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'ATP',        'Available to Promise (ATP)',
                             ',ATP#_%,PAOBJ#_TMESERS,PAQTYASSGMT,'                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'B0SD',       'Installation and System Data',
                             ',B0SD%,STC#_SESSION,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'BAL',        'Application Log',
                             ',BAL_INDX,BALDAT,BALHDR,CIFBALSEL,'                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'BCA',        'Account Management',
                             ',BCA%,BKK92#_SUMS,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'BCS',        'Business Communication Service',
                             ',BCS%,SBCMCONT1,SBCMLOIO,SBCMPHIO,SBCMPHF,SRBCSBREL,'                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'BCT',        'BYD: Business Configuration Tools',
                             ',BCT#_%,BCTD#_%,'                                                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'BDCP',       'Application Link Enabling (ALE)',
                             ',BDAUDQUEUE,BDCP%,TERRD,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'BDS',        'Business Document Service',
                             ',BDS%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'BDST',       'BYD: Studio',          /* AP-RC-BDS */
                             ',SDI#_PROJECT#_HEADER,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'BK',         'Bank',
                             ',SEPA_MANDATE_USE,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'BP',         'Business Partners',
                             ',BUT%,CVP#_SORT,KNA1,KNVP,UDMBPSEGMENTS,'                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'BPM',        'Business Process Management',
                             ',BC#_BPEM#_BL#_ENTRY,BC#_BPEM#_BL#_INDEX,BC#_BPEM#_BL#_TRANS,BC#_BPEM#_CTX#_DATA,BC#_BPEM#_CTX#_ITEM,BC#_BPEM#_CTX#_I#_ATTR,' ||
                             'BC#_BPEM#_CTX#_TAG,BC#_BPEM#_CTX#_TAGCIA,BC#_BPEM#_CTX#_TAGMAP,BC#_BPEM#_CTX#_TYPE,BC#_BPEM#_EL#_ENTRY,BC#_BPEM#_MAIL#_BL#_AT,' ||
                             'BC#_BPEM#_TM#_DCREF,BC#_BPEM#_TM#_TASKREF,BPEM#_AUTH#_M,BPEM#_IDX#_OBJ,BPEM#_IDX#_REL,BPEM#_IDX#_ROLES,BPEM#_IDX#_TASK,BPEM#_IDX#_TEXTID,' ||
                             'GLX#_C#_ASYNCQ,GLX#_C#_ASYNCQ#_ERR,GLX#_C#_JOBS,GLX#_C#_JOIN#_REFS,GLX#_C#_JOIN#_STATE,GLX#_C#_LOST#_NODES,GLX#_C#_MONITOR,GLX#_C#_OBJECTS,' ||
                             'GLX#_C#_SEPARATIONS,GLX#_C#_CONTAINER,GLX#_CONT#_DO#_REF,GLX#_RRH#_TEXT#_CACHE,SBTM%,SLPE#_%,'                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'BR',         'Business Rules',
                             ',FDT#_%,SFOBUEV001,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'BTC',        'ABAP Jobs',
                             ',BTCEVTHISTORY,BTCJOBEPP,BTCJSTAT,TBTCCNTXT,TBTCJOBLOG%,TBTCO,TBTCP,TBTCS,TBTC#_TASK,TBTC#_SPOOLID,'                                                            FROM DUMMY UNION ALL
        SELECT 100, 'BYD',        'Business ByDesign / Cloud for Customer',          /* LOD */
                             ',ACCESS#_CONTROL#_LIST2#_ENTRY,ACP#_D#_BTM#_NOTIF,ADSD%,APBMV#_D#_ERROR#_LOG#_ITEM,APBOUMTL#_SCRIPT,' ||
                             'APCRMD#_CPG#_OUTBOUND,APUI#_DEVICE#_CLIENT#_TRAKING,APXR%,BPCH%,BPEXT#_D#_ROOT,BUPA%,BUSINESS#_ACTIVITY#_%,BYD#_CLIENT#_INTERACTS#_ROOT,CDAD#_DATES,' ||
                             'DEMAND#_ROOT,EMP#_%,EXT#_PRICE#_DOC#_%,FOP#_CDT#_ROOT,MDRS#_%,OFFLINE#_BUPA#_LINK#_ROOT,OIM#_D#_ROOT,PDM#_IPRD#_D#_DESC,QUOTE#_%,' ||
                             'SAVE#_POST#_PROCESSING#_ROOT,SBOI%,SERVICE#_REQUEST#_%,WKF#_%,WORKFLOW#_NOTIF#_WKF#_LOG,WSMV%,'                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'BW',         'BW: General Tables',
                             ',BWSD_DATA%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'CA',         'Contract Accounting',
                             ',DFKCRPO,DFKK%,FKK%,DPAYH,DPAYP,'                                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'CATALOG',    'SAP HANA Catalog',
                             ',{SC}SYS,{SC}SYSTEM,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'CATT',       'Computer Aided Test Tool',
                             ',CATN,ECLOG#_CALL,ECLOG#_DATA,ECLOG#_EXEC,ECLOG#_EXT,ECLOG#_HEAD,ECLOG#_RESTAB,ECLOG#_SCNT,' ||
                             'ECLOG#_SCR,ECLOG#_SEL,ECLOG#_XDAT,ECSCR#_XML_STR,ECTD#_DATA,ECTD#_XML#_STR,'                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'CC',         'Payment Cards',
                             ',CCSEC_ENC,CCSEC_LOG,'                                                                                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'CCP',        'Client Copy',
                             ',CCEXITLOG,CCQUEUE,CCQUEUESLICE,CCTABCONTSLDATA,'                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'CD',         'Change Documents',
                             ',CDCLS,CDHDR,CDPOS,CDPOS#_STR,CDPOS#_UID,PCDPOS,'                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'CE',         'Profit Center',
                             ',/FIN3/PCA_U_MARC,CE1%,CE2%,CE3%,CE4%,CE9%,CEALE01,COVA,'                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'CEC',        'Customer Engagement and Commerce',
                             ',CUAND#_%,CUAN#_%,HPA#_D#_%,'                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'CFG',        'Application Platform Product Configurator',
                             ',COMM#_CFG%,IBINST#_OBJ,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'CFIN',       'Central Finance',
                             ',CFIN%,FINS_CFIN_MIG_LG,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'CHG',        'Change Management',
                             ',CWBCIDATAOBJ,CWBNTCONT,E070%,E071%,FINS_MIG%,OCS%,SCTS#_TRACK#_MAIN,TLANINDX,TLANSUPTA,TPALOG,VRSMODISRC,VRSX%,/TMWFLOW/%,'                                    FROM DUMMY UNION ALL
        SELECT 100, 'CHRIVER',    'Chrome River',
                             ',/CHRIVER/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'CLASS',      'Classes',
                             ',CLBUF,CLF#_HDR,CLF#_OBJKEY#_MPPNG,KSSK,'                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'CM',         'Case Management',
                             ',SCMGCONT01,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'CMS',        'Business Objects Central Management Server',
                             ',CMS_INFOOBJECTS7,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'COD',        'Customer on Demand',
                             ',COD#_%,CODD#_TM#_D#_PARAME,'                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'COUNT',      'Fiori Counting',
                             ',COUNT#_CA#_%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'COV',        'Coverage Analyzer',
                             ',COV_METADATA,COVRES,COVRES0,'                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'CPED',       'Commodity Pricing Engine',
                             ',CPED#_%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 110, 'CRM',        'Customer Relationship Management',
                             ',BDOC#_TRACK,CCO#_INFDTL,CDAD#_LINK,CDBD#_%,CMSD#_%,COMM#_IL#_BOMITM,COMM#_IL#_BOMITM#_H,' ||
                             'COMM#_PR#_FRG#_ROD,CRM%,FRG0080#_CD,IBPART,LOYD#_%,SMO8%,SMOAPPOINT,SMODBL%,SMOHJOBQ,SMOKNA1SHT,SMOVB%,SMW0REL,SMW3#_%,SMWMBSTAT,SMWT#_TRC,SMZB#_BINREL,'       FROM DUMMY UNION ALL
        SELECT 100, 'CS',      'Customer Service',
                             ',CCMLOG,CCMLOGD,CCMOBJKEYS,CCMOBJLST,'                                                                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'CTAC',    'Ctac',
                             ',/ACTION/%,/CTAC/%,/XVRETAIL/%,'                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'CTE',        'Concur Expense Integration with Financials',
                             ',CTE#_D#_%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'DBACPT',     'DBACOCKPIT',
                             ',DB2DB02%,DB#_SIZE#_HISTORY#_FOR#_COCKPIT,GVD%,MERGED#_TRACES#_FOR#_COCKPIT,HDB#_TABLE#_SIZES,ORA#_SNAPSHOT,ORA#_SQLC#_DATA,'                                   FROM DUMMY UNION ALL
        SELECT 100, 'DBTAB',      'Table Logging',
                             ',DBTAB%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'DD',         'ABAP DDIC',
                             ',DD%,T100,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'DH',         'Data Hub',
                             ',CanItemPubStatus,CanonicalItem,DataLoadingAction,,'                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'DM',         'Document Management',
                             ',DMS%,DRAD#_LAST#_CHANGE,DRAO,DRAP,DRAT,DRAW,DRAW#_LAST#_CHANGE,SDOKCONT1,SDOKDIDJOB,SKWG#_BREL,'                                                               FROM DUMMY UNION ALL
        SELECT 100, 'DMC',        'Data Mapping and Conversion',
                             ',DMC#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'DRF',        'Data Replication Framework',
                             ',DRFD#_%,MDGD%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'DSIM',       'Demand Signal Management',
                             ',/1DD/%,/DDF/%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'DSN',        'Dassian',
                             ',/DSN/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'DTMT',       'Data Transport and Migration Tool',
                             ',DTMT_FW_T_UMDL,'                                                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'EC',         'Enterprise Controlling',
                             ',ECMCA,MCDX2,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'EDI',        'IDocs',
                             ',EDI40,EDID4,EDIDC,EDIDS,IDOCREL,SRRELROLES,XI#_IDOC#_IN#_MSG,'                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'EDO',        'eDocuments',
                             ',EDOAIFMSG,EDOCLDTE,EDOCUMENT%,EDOESSII#_SDOC,EDOINADDINFO,EDOINEINV,EDOINEWB,EDOININV,EDOMSG%,EDOMXPAYMENT,EDORELSRC,EDOSRCFILE,'                              FROM DUMMY UNION ALL
        SELECT 100, 'EDX',        'Electronic Data Exchange',
                             ',EDX_PARK,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'EHS',        'Environment, Health and Safety',
                             ',CCDUT%,CCGLT#_PRTREQ#_PAR,CCRCT#_EHS#_COMP,CVDDH,CVDDP,DGTM%,EHFNDD#_%,EHPRCD#_%,EHSBC#_BUF#_PROT,' ||
                             'ESTALE,ESTAUSP,EST#_CHANGE#_DOCS,ESTDF,ESTDR,ESTDS,ESTDU,ESTLS%,ESTRI,ESTVA,ESTVH,ESTVP,ESTWL,TCGC1,T7EHS00#_RESPCRIT,T7EHS00#_RESQUEST,VBEPDG,'                FROM DUMMY UNION ALL
        SELECT 100, 'EIM',        'Enterprise Information Management',
                             ',AL#_RF#_INFO,AL_ROLLFORWARD,DHCDC#_RTSTORE,'                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'EIS',        'Executive Information Management',
                             ',CF___,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'ENH',        'Enhancement Tools',
                             ',ENH%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'EPM',        'Energy Portfolio Management',
                             ',SNWD#_GI#_HEAD,SNWD#_GI#_I,SNWD#_SO,SNWD#_SO#_I,SNWD#_SO#_INV#_HEAD,SNWD#_SO#_INV#_ITEM,SNWD#_SO#_SL,SNWD#_TEXT#_KEY,SNWD#_TEXTS,'                             FROM DUMMY UNION ALL
        SELECT 100, 'ES',         'Enterprise Search',
                             ',ESH%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'ESI',        'Enterprise Service Infrastructure',
                             ',BSA#_LOAD,MPSD#_LOGHDR,SPROXMSGREL,'                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'ETD',        'Enterprise Threat Detection',
                             ',sap.secmon.db::%,SECM#_CACHE,'                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'EWM',        'Extended Warehouse Management',
                             ',/SCDL/%,/SCWM/%,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'FC',         'Financial Consolidation',
                             ',CT#_%,ECMCT,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'FCC',        'Financial Closing Cockpit',
                             ',FCC#_INST#_ALL#_OR,FCC#_INST#_FILE,'                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'FICO',       'Financials / Controlling',
                             ',{LR}^K[0-9][0-9][0-9][0-9][0-9][0-9]$,ACCT#_SRF#_REP#_ITM,ACDOC%,ACRELATION,AFWGO#_CNTL#_EP1,AGKO,ANEA,ANEK,ANEP,' ||
                             'ANLA,ANLB,ANLBZA,ANLC,ANLH,ANLP,ANLZ,AUA_,AUFK,AVIP,BCONT,BFIT_A,BFIT_A0,' ||
                             'BFO_A_RA,BFOD_A,BFOD_AB,BFOK#_A,BFOK_AB,BKORM,BKPF,BPBK,BPCT%,BPDJ,BPEG,BPEJ,BPEP,BPGE,BPIJ,BPJA,BPTR,BSAD,BSAD#_BCK,BSAK,BSAK#_BCK,BSAS,' ||
                             'BSAS_BCK,BSBW,BSBW#_VAL,BSE#_CLR%,BSE#_OIH,BSEC,BSED,BSEG,BSEG_ADD,BSEGC,BSET,BSID,BSID#_BCK,BSIK,BSIK#_BCK,BSIM,BSIM#_BCK,BSIP,BSIS,BSIS#_BCK,' ||
                             'BSPL,BVOR,BWFI%_AEDAT%,BWPOS,CBPR,CEJMEDA,CEZP,CF5%,CKHS,CKHT,CKIS,CKIT,CMFK,CMFP,COBK,COBRA,COBRB,COEJ,COEJL,COEJR,COEJT,COINT#_INDX,COIX#_DATA%,' ||
                             'COEP,COEPB,COEPD,COEPL,COEPR,COES,COIX,COKA,COKEY,COKL,COKP,COKS,COOI,COSB,COSBD,COSL,COSLD,COSP,COSP#_BAK,COSPD,COSR,COSS,COSSD,' ||
                             'COSS#_BAK,COST,CPZP,CSSL,CSPC#_TOKEN,DEBPPEVENTLOG,DEFTAX#_ITEM,DFPAYHT,DFPM#_NUMB,DKOKP,DSKOP,DUVMSEG#_EXTRACT,EDI#_FIN#_INV#_02#_I,EMMA#_%,ETXDCH,' ||
                             'ETXDCI,ETXDCF,ETXDCJ,ETXJCD,FAAT#_%,FAGL%,FBICRC%,FCLM#_BSEG#_DELTA,FCLM#_FB2#_STRTIM,FCLM#_FI#_STAGING,FCLM#_MM#_DELTA,FCML#_CCS#_REP,FCML#_REP,' ||
                             'FDFIEP,FDM1,FDM#_BW#_INV#_DELTA,FDM#_COLL#_LASTPAY,FDM#_COLL#_TROBJ,FDM#_DCOBJ,FDM#_DCPROC,FDM#_INVOICE#_MEM,FDS2,FEBCL,FEBEP,FEBEP#_POST#_HIST,FEBRE,' ||
                             'FERC#___,FIEUD%,FIGLDOC,FIN#_AA#_CORR#_ISS,FIN#_CORR#_ISSUE,FINCS#_%,FINS#_%,FINST#_%,' ||
                             'FIPLD#_FIDOC#__,FMIA,FMIFI__,FMIO,FMIOI,FMIT,FML#_MIG#_MD,FMSU,FMZUOB,FOBJ#_OBJ#_W#_POST,FQM#_FLOW,' ||
                             'GLE#_MCA#_FDOCREF,GLFUNCA,GLFUNCT,GLIDXA,GLIDXB,GLPCA,GLPCP,GLPCT,GLSP,GLT0#_BCK,GLT0#_DIF,GLT3,' ||
                             'GREP,GRIX,GRRT,HRRP#_NODE%,IAOM#_CRMSRV#_EXAT,IAOM#_EXT#_OBJ#_INF,' ||
                             'ICA#_ASSIGN,ICA#_ASSIGN#_ITEM,ICADOCM,IHC#_DB#_PN,INTITIT,J#_3RKKRS,KALAMATCON2,KALM,KANZ,KAPS,KBLE,KBLESUM,KBLEW,' ||
                             'KBLP,KEKO,KNB1,KNC1,KNC1#_BCK,KNC3,KNC3#_BCK,KNCX#_DIF,KNKK,KNKKF1,KNVD,LFC1,' ||
                             'LFC1#_BCK,LFC3,LFC3#_BCK,LFCX#_DIF,MHND,MHNEX,MHNK,PAYR,PAYRQ,PAYRQT,PYORDP,RDBRA#_TBG,REGUH,REGUHM,REGUP,REGUPW,RF048,' ||
                             'RFBLG,RFDT,SETHEADERT,SETLEAF,SETNODE,SIPT#_%,SKAT,SLPB,SMCOPC,SRF#_REP#_RUN#_DATA,T179T,T800HISTP,T811%,TFC#_INST#_USR,THXT#_HDOC#_DMS,TKENC4,' ||
                             'TKETD#_RUN#_DOCNR,TKETD#_RUN#_TASK,TKETRPROT,TKETRPROTD,TLRT#_TARO#_DMS,TRGT#_USER#_DATA,TRPT#_LOG,TTXI,TTXY,TXS#_TRACE,TXW#_%,' ||
                             'UAIDETAILDATA,UAINVREVALI,UDM#_WL#_ITEM,UGMDTRANS,UKM#_EXT#_GUID,UKM#_ITEM,UKM#_ITEM#_SEQIN,UKM#_TRANSFER#_AR,UKMBP#_CMS#_SGM,' ||
                             'VBSEGS,VBSEGD,VBSEGK,VDBEPI,VDBEPP,VDCHARACDOC,VDCHGPTR,VTBLII,VZZKOPO,WITH#_ITEM,'                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'FICOT',      'Financial Conditions',
                             ',FICOT%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'FL',         'File Loader',
                             ',{SC}SAP_INA_FILELOADER,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'FP',         'Forms',
                             ',FPLAYOUT%,FPCONTEXT,SSFXSFBMP,'                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'FRA',        'Fraud Management',
                             ',FRA#_D#_DOC,FRA#_D#_DOC#_VER,'                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'FRE',        'Forecasting and Replenishment',
                             ',/FRE/%,FRE#_%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'FRUN',       'FRUN',
                             ',AEM#_METRIC#_STORE,AGSSISE#_CHART,AGSSISE#_GS,AGSSISE#_LOG,CCDB#_DATA#_%,COF#_EX,COF#_EXS#_H,COF#_IQ,' ||
                             'COVA#_VAL#_ITEM,EWA#_CF#_DATA,EWA#_CF#_DATA#_HDR,FCUP#_USAGE#_DATA,LMDB#_DS#_TRACE,OCM#_MON#_RAW,RCA#_HANA#_TAB#_SIZ,SAM#_AP,SRSM#_CONFIG#_FILE,STATDB%,'       FROM DUMMY UNION ALL
        SELECT 100, 'FS',         'Financial Services',
                             ',BANK#_PACKMAN%,BANK#_PP#_THREAD,BANK#_PROCFL%,BANK#_WORKL#_PACK,BP001,BPTIME%,FEH#_MESS#_PERS,FSBP%,VTBLID,'                                                   FROM DUMMY UNION ALL
        SELECT 100, 'FT',         'Foreign Trade',
                             ',MMPREF_PRO%,EIPO,FEIAV,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'GPC',        'GPC Europe GmbH',
                             ',J#_4F#_%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'GTF',        'General Application Functions',
                             ',AENV,AEPLST,APOC#_D#_OR#_%,CGPL%,CNS#_%,CNVCLU,CNV#_%,CUEX,CUKN,CUOB,CURSCOD,CUVTAB#_VALC,' ||
                             'CUVTAB#_VALN,CUXREF,DAC#_D#_%,DCTHDBPARAM,GTB#_CD#_DATA,RMPSAPDIR#_T#_CLNT,RMPSAPREL#_T#_CLNT,RPSCONT03,SMPARAM,'                                               FROM DUMMY UNION ALL
        SELECT 100, 'GRC',        'Governance, Risk Management and Compliance',
                             ',GRAC%,GRFNMWRTDATLGD,GRFNMWRTMSGLG,GRPCCONT1,SIAG#_TRANS#_CNT,SIAG#_TRANS#_LOG,'                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'GRIR',       'Goods Receipt / Invoice Receipt Processing',
                             ',sap.hba.apps.grircm.db::GRIRCMSTATUS,sap.hba.apps.grircm.db::GRIRCMSTATUS#_HISTORY,'                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'GW',         'Gateway',
                             ',/IWBEP/%,/IWFND/%,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'HR',         'Human Resources',
                             ',ASSHR,CC1ERP,CC1ERM,DSYS#_PHFILE#_ECD2,HRDCT#_TPY#_RGDIR,HRHAP#_%,HRP%,HRT%,LSHR,' ||
                             'P01A1#_RAWDATA,P05T#_IV#_AANGIFTE,P2B2#_%,P2BR#_%,P2RU#_%,P2RX#_%,PA0015,PA0532,' ||
                             'PA20__,PA9___,PB2ADATSTR,PB2ADATXSTR,PCALAC,PCL%,PPARFC,PPDIT,PPDIX,PPDMSG,PPMIX,PPOIX,' ||
                             'PPOPX,PTDW#_PWS#_DB,PTDW#_TIMES#_DB,PTEX2000,PTEX2010,PTEXDIR,PTIMEOV%,PTQUODED,PTREQ#_%,PYC#_D#_PY#_MSG,T5ASRCONT01,T5ASRCONT02,' ||
                             'T5FDSN#_GEN#_SECTN,T5F99CONT1,T528T,T552A,T5EL5,T7BR#_DOCUMENTS,T7BREFD#_%,T7KWPHPR,T7KW#_SDOKCONT1,TEVEN,TEVEN#_MORE,'                                         FROM DUMMY UNION ALL
        SELECT 100, 'HY',         'Hybris Commerce',
                             ',ADDRESSES,BACKINSTOCKALERT,CARTS,CATEGORIES,CAT2CATREL,CAT2PRINCREL,CONSIGNMENTS,CONSIGNMENTENTRIES,' ||
                             'CRMTASKCONTEXTITEM,CRMTASKLOGS,CXUSERTOSEGMENT,DATAFEEDENTRY,DISTRIBUTEDBATCHES,' ||
                             'DOCTOCATREL,EMAILADDRESS,EMAILMESSAGE,EMAILMSG2TOADDRREL,EXPORTS,FILEMEDIA,FRAUDREPORTS,' ||
                             'FRAUDSYMPTOMSCORING,ITEMVERSIONMARKERS,ITEMSYNCTIMESTAMPS,LASTVISITEDPRODUCTS,' ||
                             'LOYALTYMSHIP,LOYALTYMSHIPCARD,LOYALTYTIER,MEDIAS,NEWSLETTERACTION,NEWSLETTERSUBSCRIPTION,OAUTHACCESSTOKEN,ORDERENTRIES,ORDERENTRYCONSUMED,' ||
                             'ORDERS,ORDERENTRYPROPS,ORDERSTATUSTRANSITION,OSLORDER,OSLORDERENTRY,PAYMENTINFOS,PAYMENTTRANSACTIONS,' ||
                             'PAYMNTTRNSCTENTRIES,PGRELS,PRICEROWS,PROCESSES,PROCESSPARAMETERS,PRODBASESTOREASSIGNMENT,' ||
                             'PRODUCTS,PRODUCTSLP,PROPS,PROMOTIONACTION,PROMOTIONRESULT,PROMOTIONRESULTLP,' ||
                             'RBFDELMOD2DELMMOD,RELATTRIBUTES,SAPBWENTRY,SAVEDVALUEENTRY,SAVEDVALUES,SOLRINDEXOPERATION,' ||
                             'STOREDHTTPSESSIONS,TASKCONDITIONS,TASKLOGS,TASKS,UNIQUECOUPONCODE,USERAUDIT,USERS,WEBSERVICEPAYLOAD,WISHLIST2,WISHLIST2ENTRY,'                                  FROM DUMMY UNION ALL
        SELECT 100, 'IB',         'IBase',
                             ',IBEXTINST,IBIB,IBIN,IBINOBS,IBINOWN,IBINTX,IBINVALUES,IBSP,IBST,IBSTREF,IBSYMBOL,'                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'IBPDD',      'Integrated Business Planning (Time Series)',
                             ',IBPDD#_TIMESERIES#_%,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'ICF',        'Internet Communication Framework',
                             ',ICFRECORDER,UCONRFMCALLERATT,'                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'ICM',        'Incentive and Commission Management',
                             ',PFO#_G%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'IL',         'Inkasso Link',
                             ',J#_5DT#_PROTHIS,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'IM',         'Investment Management',
                             ',ANLE,ANLK,COEPBR,IMCKF,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'INDX',       'Export / Import',
                             ',DMC_INDXCL,INDX,INDX_HIER,TABADRX,'                                                                                                                            FROM DUMMY UNION ALL
        SELECT 110, 'INS',        'Insurance',
                             ',VVSC%,DIMA%,ICL%,ICS%,IMP#_OBJECTS,IMP#_PARAMETERS%,IMP#_TRIGGERS,VVKK%,'                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'ISA',        'Industry Solution Automotive',
                             ',ISAUTOEKLWES,PPC#_CONF#_ACT,PPC#_CONF#_MAT,PPC#_CONF#_MAT#_VAR,PPC#_HEAD,PPC#_ORD#_INF,RLACPOHD,RLACPOIT,VLCGISSUE,VLCGRECEIPT,VLCHISTORY,VLCVEHICLE,'         FROM DUMMY UNION ALL
        SELECT 100, 'ISB',        'Industry Solution Banking',
                             ',BKKC02,BKKIT,BKKNT,VTBLIE,'                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'ISH',        'Industry Solution Hospitals',
                             ',N1%,N2%,NADR,NAPHF,NAPP,NBEW,NC0_,NC301_,NCI0,NCIR,NDIA,NDOC,NFAL,NFAM,NFOR,NFPZ,NKAV,NKSK,NKSP,NLCO,' ||
                             'NLDBC#_%,NLEI,NLEM,NLKZ,NLLZ,NLVERP,NMATP,NMATV,NNL#_%,NNLZ,NSHIFT_ID,NTMN,NWAT#_%,NWCHEXTREF,'                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'ISM',        'Industry Solution Media',
                             ',JFFS,JFREVACC,JFREVPER,JKACCAMOPROT,JKAK,JKAMOPLAN,JKAP,JKEP,JKPA,JKSDDEMAND,JKSDDEMANDFLOW,' ||
                             'JKSDORDERAD,JKSDORDERADMIXPL,JKSDORDERINDEX,JKSDORDERQ,JKSDPROTOCOL,JVTLFZUO,'                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'ISPS',       'Industry Solution Public Sector',
                             ',DFACTS,DFMCA#_RETURN,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'ISR',        'Industry Solution Recycling Administration',
                             ',J#_7LV1P,WRF6,WRS6,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'IST',        'Industry Solution Telecommunications',
                             ',IST#_TDATA,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'ISU',        'Industry Solution Utilities',
                             ',DBER%,EABL%,EABP,EADZ,EANL%,EAST%,EAUS%,EBISIM,EBP#_ADDR#_SERVICE,EDEXTASK%,EDISCACT,' ||
                             'EDISCDOC,EDISCOBJH,EDISCPOS,EE07,EEDM%,EEIN%,EGERH,EGERR,EIDESWTMSGDATA,EITERDK,EPROF%,ERCH%,' ||
                             'ERDB,ERDK,ERDTS,ERPL,ETDZ,ETTIFN,EUIHEAD,EUIINSTLN,EVBS,EVBST,EVER,EVERH,EZUZ,TEAMI#_LOG#_DATA,' ||
                             'TEAMI#_EM#_EVTATTR,TEAMI#_LOG#_MSG,TEMKSV,TEMSTATISTIK%,TEPYPM,TE418,TINV#_INV#_LOG%,'                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'ISOIL',      'Industry Solution Oil and Gas',
                             ',LIPSO_,MATDOCOIL,MATDOCOILEXTRACT,MSEGO_,OIB03,OIB#_DEFAULTS,OICINT#_MASTER,OICQ9,OIGS%,OII#_DIP#_PARAM,' ||
                             'OIISLVCPO,OIJ#_EL#_DOC#_M#_MOT,OIJ#_EL#_TKT#_I#_O2,OIJNOMI,OIJNOMST,OIJPEG,OIR0D%,OIRADTLT,OIRC#_GMMH,OIURV%,'                                                  FROM DUMMY UNION ALL
        SELECT 100, 'ITV',        'SQLScript (Internal Table Type)',
                             ',#_SYS#_SS2#_ITV#_%,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'IUUC',       'Incremental Upgrade and Unicode Conversion',
                             ',IUUC,IUUC#_%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'J2EE',       'Java 2 Platform Enterprise Edition',
                             ',J2EE%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'J_1',        'Localization',
                             ',EIV#_GTD#_ITM,EIV#_GTD#_MAP,FIPLD#_SDINV#_I,J#_1%,J#_2%,J#_3%,J1B#_ERROR#_DDA,T77WWW#_CLTRAN#_BU,TXI#_ITM,'                                                    FROM DUMMY UNION ALL
        SELECT 100, 'J_[68]',     'CrefoSprint Creditreform',
                             ',J#_6%,J#_8%,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'JSM',        'Java Session Management',
                             ',T#_CHUNK,T#_SESSION,'                                                                                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'JV',         'Joint Venture und Production Sharing Accounting',
                             ',JVOO1,JVSO1,JVTO1,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'KMC',        'Knowledge Management and Collaboration',
                             ',KMC#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'LIST',       'List Viewer',
                             ',LTDX,LTEX,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'LM',         'Lifecycle Management',
                             ',BLD#_DCI#_DETAIL,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'LMD',        'Last Mile Distribution',
                             ',LMD#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'LO',         'Logistics',
                             ',POC_DB%,{LR}^SER0[0-9]$,ARUN#_%,AUBSI,AUFG,AUFI,AULW,AUPO,AUSB,AUVW,AUVZ,BOSF#_GTS#_C2CLOLD,CIAP#_D#_KEY#_VALUE,' ||
                             'CMPB#_ASGN,CMPB#_MAP,CVI#_CUST#_%,DMF#_D#_ART#_SITE,DMUPOB,DMUTMX#_META,DRVLOG#_%,' ||
                             'EBEW,EBEWH,FRET,FSH#_%,HUINV#_HDR,HUINV#_ITEM,HUMSEG,HUSSTAT,HUSTOBJ,KDST,KNB5,KNVK,KNVV,LEDSPD_FLOW,LFA1,LIKP,LIPS,LIPSDG,LIPSPO,LIPSRF,' ||
                             'MABW,MAKT,MALG,MAMT,MAPE,MARA,MARC,MARCH,MARD,MARDH,MARI,MARM,MAST,MAW1,MCH1,MCHA,' ||
                             'MCHB,MCHBH,MEAN,MERRDAT#_TMP,MKOL,MKOLH,MOFF,MSKA,MSKAH,MSKU,MSKUH,MSLBH,MSPR,' ||
                             'MSPRH,MSSA,MSSAH,MSSQH,MSTA,MVKE,ORIG#_PR#_MBEW,PNWTYH,PNWTYV,PRWTY,PVWTY,QBEW,QBEWH,RPO#_D#_ITEM#_BUF,SER0_,RPO#_D#_MAP#_MERGE,' ||
                             'SGT#_MADKA,SHP_IDX#_%,STAS,STKO,STPO,STPU,STZU,TSEGE,TSEGEADR,' ||
                             'TSEGH,TSEGR,USEG,TVPOD,VBFS,VCH#_KBD#_TREE,VEKP,VEPO,VEVW,VFKK,VFKN,VFKONV,VFKONX,VFKP,VFPA,' ||
                             'VFSCAH,VFSCAR2,VFSI,VFZP,VKDFS,VLBL,VTDST,VTFA,VTPA,VTRDI,VTRKH,VTRKP,VTTK,VTTP,VTTS,WAGU,WAKH,WAKHIND,WAKP,WAKT,WALE,' ||
                             'WAPPTV,WB2#_D#_BVDETAIL,WB2#_D#_SHD#_ITEM,WBBH,WBBL,WBBP,WBB#_SAVE1,WBGT,WBPA,WBRF,WBRFN,WBRK,WBRP,WCOCOF,' ||
                             'WDLS,WDLSO,WDLSP,WESD#_%,WGDS#_ATTR#_VALUES,WGDS#_TI#_ATTRIBUT,WKPK,WKBP,WLK1,WLK2,WMATSITEQTYTIME,WRF#_%,' ||
                             'WRPL,WRPT,WSOF,WSOP,WSOT,WSTI#_MKPF#_INDEX,WSTI#_POS#_EVENT,WTADAB,WTYV#_IMRG,WTY#_PARTNER#_TAB,WYT3,'                                                          FROM DUMMY UNION ALL
        SELECT 100, 'LTVF',       'Landscape Transformation',
                             ',CNV%LTVF%,LTR#_CLUSTER,LTR#_DELIM#_RLT#_T,'                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'MD',         'Application Platform Master Data',
                             ',COMM#_IL#_PRDBP,COMM#_IL#_PRDBP#_H,COMM#_IL#_PROREF,COMM#_IL#_PROREF#_H,COMM#_PR#_FRG#_REL,' ||
                             ',COMM#_PRODUCT,COMM#_PRODUCT#_IDX,COMM#_PRPRDCATR,COMM#_PRSHTEXT,COMM#_PRSHTEXTH,'                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'MDC',        'Master Data Consolidation',
                             ',KNVP#_PRC,MDC#_LOADFEED,MDC#_LOADXML,MDC#_MODIFIED#_H,MDC#_NOTATION,MDC#_STXH,'                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'MDG',        'Master Data Governance',
                             ',MARA#_DQ#_RES,MARC#_DQ#_RES,MDG#_BS#_BP#_MSG#_ST,MDG#_BS#_PROC#_STAT,MDG#_UKMLOG#_ITM,MDG#_MLT#_ASSGMNT,MDMCHP,MDMFDBID,UKMDB#_%,USMD%,/1MD/%,/SMD/%,'         FROM DUMMY UNION ALL
        SELECT 100, 'MDM',        'Master Data Management',
                             ',MDMFDBPR,MDMFDBEVENT,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'ME',         'Manufacturing Execution',
                             ',ACTIVITY#_OPTION,EXTENSION,ITEM,OPERATION,SFC#_ROUTER,STATUS#_DESCRIPTION,STATUS#_MEANING,'                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'MIME',       'MIME Repository',
                             ',SMIM%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'ML',         'Material Ledger',
                             ',CKM%,ML%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'MM',         'Material Management',
                             ',ESRUO,IKPF,ISEG,MAPR,MATDOC,MATDOC#_EXTRACT,MATDOC#_SKEY#_VALD,MATERIALID,MBEW%,MEPO#_BADI#_EXAMPL,MIGO#_BADI#_HOLD,MKPF,MKPF#_ARIDX,' ||
                             'MMIM#_PRED,MRMRBBW#_ERR#_EXTR,MSEG,MSG#_HIGH,MVER,MYABK,MYMFT,MYMP,MYMP1,MYSEG#_EXTRACT,' ||
                             'NSDM#_MIG#_V#_MK_M,PROP,RBCO,RBEX,RBKP,RBKP#_BLOCKED,RBTX,RBVS,RBWS,RKPF,RKWA,RSEG,RSEG#_TM,TEMPLATE#_DATA,WIND,WRPE,'                                          FROM DUMMY UNION ALL
        SELECT 100, 'MMW',        'Mobile Middleware',
                             ',RR00000000%,SMMW#_MSG#_BODY,SMMW#_SESS#_MSGS,'                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'MONI',       'Monitoring',
                             ',ALALERT%,ALPERFDB,ALPFREP#_DAT,ARDB#_STAT1,ARDB#_STAT2,MONI,PTC#_DIRECTORY,SALRT,SALRTCNT,' ||
                             'SALRTEXTRC,SALRTRECPT,SAPWLMONI,SCMON#_DATA,SWNCM%,TAAN#_DATA,TXMILOGRAW,'                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'MSR',        'Advanced Return Management',
                             ',MSR%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'MT',         'Musing Tools',
                             ',KFM#_KF#_CACHE,POWL#_RESULT,POWL#_SELCRIT,'                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'NR',         'Number Ranges',
                             ',NRIV%,ONR%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'OD',         'OData Framework',
                             ',ODATA#_%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'ODP',        'Operational Data Provisioning',
                             ',RODPS#_HANA#_ADMIN,RODPS#_REPL#_RID,'                                                                                                                          FROM DUMMY UNION ALL
        SELECT  90, 'OLD',        'ABAP Upgrade Conversion',
                             ',%~~OLD,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'OM',         'Output Management',
                             ',SFORM#_A#_STORAGE,SKPRO#_OMU#_PHIO,'                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'OMR',        'SAP HANA Online Mode Replicas',
                             ',#_SYS#_OMR%,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'OPU',        'Occasional Platform User',
                             ',SALV#_EX#_STORAGE%,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'OT',         'Open Text',
                             ',/IXOS/%,/OPT/%,/ORS/%,/OTX/%,DAUDITNEWCORE,DBROWSEANCESTORSCORE,DFACETCACHE,'                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'OUT',        'Output Management',              /* AP-RC-OUT */
                             ',FPC#_FC#_CACH%,'                                                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, 'PAF',        'Process Agent Framework',	
                             ',SPAF#_%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'PI',         'XI/PI Adapter Framework',
                             ',BC#_MSG,BC#_MSG#_AUDIT,BC#_MSG#_DUP#_CHECK,BC#_MSG#_LOG,BC#_MSG#_VERSION,CKLTEX,XI#_AF#_MSG,XI#_AF#_MSG#_AUDIT,XI#_AF#_PROF#_PERF#_AC,XI#_AF#_PROF#_PERF#_CA,' FROM DUMMY UNION ALL
        SELECT 100, 'PLM',        'Product Lifecycle Management',	
                             ',CDESK#_BBOX,CFF#_%,PVFRMM,PVFRMS,'                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'PM',         'Plant Maintenance',
                             ',AFIH,AUFM,BGMKOBJ,EAM#_OSTOBJSTS,EQKT,EQUI,EQUZ,HIKO,HIVG,IFLOS,IFLOT,IFLOTX,IHPA,IHSG,ILOA,IMRG,IMPTT,' ||
                             'MCIPMIS,MHIO,MHIS,OBJK,OPROL,PMCO,PMCOQT,PMPL,PMSDO,QMEL,QMFE,QMIH,QMMA,QMSM,S061,S063'                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'POC',        'Process Orchestration',
                             ',POC#_D#_%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'PP',         'Production Planning',
                             ',AFFT,AFFH,AFFL,AFFV,AFFWPRO,AFKO,AFPO,AFRH,AFRP4,AFRU,AFRV,AFVC,AFVC#_TEXT,AFVV,AFVU,AFWD,AFWI,AFWIS,AUSP,BEREIT,BLPK,BLPP,' ||
                             'CMX#_XS#_DB#_%,COFT,COFV,COFVP,COMD,COME,COMER,COMH,COMHR,COWB220PAR,COWBSUBOBJ,CPC#_CMX#_DB#_LOG,' ||
                             'DBVL,DBVM,DRAD,DRAD#_PORDER,FUNREQ,HUM#_KOMMI,KBED,KBKO,KBVL,KDVL,KEPH,MCAFPOV,MCAFVGV,MCKALKW,MDKPDB,MDMA,INOB,ISTBED,' ||
                             'MAPL,MD03,MDKP,MDSM,MDTB,MDTC,MKAL,MKAL#_AEND,PBHI,PDERR,PGAN,PGMI,PGZU,PLAF,PLAS,PLFL,PLKO,PLKZ,PLMZ,PLPO,PLPO#_TEXT,PLZU,' ||
                             'PPH#_DBVM%,PPH#_PFE#_CHANGE,PPHMRPPPLOG,PPHMRPLOGITEM,PROH,PROW,RMRP,RSDB,STPF,T439I,TC5__,'                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'PPE',        'Product and Process Engineering',
                             ',CUCU,PALTID,PALTTX,PVSDEX,'                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'PPF',        'Post Processing Framework',
                             ',PPF%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'PPM',        'Project Portfolio Management',
                             ',DPR#_APPROVAL,DPR#_CONF#_LI,DPR#_ENTITY#_LINK,EVE#_XML#_PERS#_DB,'                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'PS',         'Project System',
                             ',AD01%,AFAB,CNDB,CNLDST_SHORTTX,COFP,COSPP,PLAB,PRPS,PSGUID,PSHLP#_DRAFT#_DB,PSSTXH#_KEYS,RPSCO,RPSQT,RSADD,RSPSP,TXPDAT,' ||
                             'VMPA,VSAFAB#_CN,VSAFVC#_CN,VSAFVV#_CN,VSAFVU#_CN,VSRESB#_CN,VSRSADD#_CN,VSSTEU,'                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'PSM',        'Public Sector Management',
                             ',FMBASIDX,FMAVCP,FMBASOBJNR,FMBDP,'                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'PTRV',       'Travel and Expense',
                             ',FTPT#_LOG#_GDS,ODTD#_ER#_ATT#_BIN,PTRV%,'                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'PUR',        'Purchasing',
                             ',EBAN,EBAN#_TECH,EBKN,EINA,EINE,EIPA,EKAB,EKBE,EKBE_MA,EKBE#_SC,EKBE_SRV#_SUM,EKBEH,EKBEH#_MA,EKBO,EKBZ,EKBZ_MA,EKBZH,' ||
                             'EKBZH_MA,EKEH,EKEHH,EKEK,EKEKH,EKES,EKET,EKETH,EKKI,EKKN,EKKO,EKPA,EKPO,EKPV,EKRS,EKUB,' ||
                             'EORD,EREV,ESKL,ESKN,ESLH,ESLL,ESSR,ESUC,ESUH,FPLT,MLBE,MLBECR,MLWERE,MMPUR%,POEXT,RESB,'                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'QCM',        'ABAP Conversion Tables',
                             ',QCM%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'QIE',        'Quality Inspection Engine',
                             ',QIE#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'QLIK',       'Qlik',
                             ',ACCT#_PROD#_ELIGIBILITY#_PDS,attrep#_cdc#_changes,attrep#_cdc#_log,'                                                                                           FROM DUMMY UNION ALL
        SELECT 100, 'QM',         'Quality Management',
                             ',PLMK,QA%,QMAT,QMELLTEXT,QMHU,QPRS,QTASKLTEXT,'                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'RBAM',       'BYD: Role-based Access Management',
                             ',RBAM%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'RC',         'Readiness Check',
                             ',GSS#_RC#_%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'RE',         'Real Estate Management',
                             ',VICARANGE,VICARGDONE,VICDCFOBJ,VICDCFPAY,VICECFRULE,VIRADOC,VIRADOCITEM,'                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'RFC',        'Remote Function Call',
                             ',ARFC%,BGRFC#_I#_RUNNABLE,BGRFC#_IUNIT#_HIST,BGRFC#_0#_RUNNABLE,BGRFC#_SRV#_STATE,LDQ#_DATA,LDQ#_STATE,QRFC%,RFCCBWHITELIST#_A#_CLIENT,TRFC%,'                  FROM DUMMY UNION ALL
        SELECT 100, 'RM',         'Records Management',
                             ',SRMCONT%,SRMDOC%,SRM#_INDX1,SRM#_INTEGRATION#_BROKER,SRMLOPR%,SRMPH%,SRMPROTOCOL,SRMWFPATH,SRMWFPATHT,SRMWFPTHPS,SRMWFPTREL,'                                  FROM DUMMY UNION ALL
        SELECT 120, 'RS',         'BW: Technical Tables',
                             ',BPMWITSTP,BWCONTMAST,BWCONTTMPL,BW4#_STAT#_SLICE#_P,ODQDATA%,ODQTASKDATA,ODQTASKQUEUE,ODQTSNLOG,RS%,TESTDATRNR%,RORQSTPRMS,'                                   FROM DUMMY UNION ALL
        SELECT 110, 'S',          'Logistics Information Warehouse',
                             ',{LR}^S[0-9][0-9][0-9],MC%SETUP,MCEX%,MCSI,MCSLOG,VKMI,'                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'SCM',        'Supply Chain Management',
                             ',APODELTA,BNK#_BATCH#_ITEM,BNK#_BTCH#_STREF,BNK#_XSTAT#_TX,CIF#_IM%,CIFERRLOG,CIFPOMAP,CIF#_UPDCNT,PFM#_OPTLOG,TCM#_D#_SALES#_DATA,/SAPAPO/%,'                  FROM DUMMY UNION ALL
        SELECT 100, 'SCR',        'ABAP Code Inspector',
                             ',SCR#_ABAP#_%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'SD',         'Sales and Distribution',
                             ',CND#_MAP#_KNUMH,CVP#_SD#_%,DGMSD,EIKP,EIUV,FARRIC#_D#_CP#_ACC,FPLA,FPLT,FPLTC,KAPOL,KNMT,KNVH,KNVI,KONAIND,KONBBYPRQ,KOND3,KONDD,KONDIND,KONDN,' ||
                             'KONH,KONM,KONP,KONV,KOT%,MCVSRFP,NAST,PRCD#_%,PRICAT#_%,PVINX,QTVB,SALESDOC#_CNT,' ||
                             'SCECLACOM,SCECLSDOM,SCEDEPCOM,SCEDEPSRC,SCEVALSYM,SCEVALTX,SCEVARVAL,SER02,VAKGU,VAKPA,VAPMA,VBAK,VBAP,VBBE,' ||
                             'VBEH,VBEP,VBEX,VBFA,VBFA#_STATUS,VBKA,VBKD,VBKOF,VBKPA,VBKPF,VBLB,VBOX,VBPA,VBPA2,VBPA3,VBREVE,VBRK,VBRL,VBRP,VBSK,VBSN,VBSS,VBUK,VBUP,' ||
                             'VBUV,VEDA,VEIAV,VEPVG,VLKPA,VLPKM,VLPMA,VRKPA,VRPMA,VTSP,VZLOG,/WOM/%,WPLST,WPOSN#_CSGMT,WPTST,'                                                                FROM DUMMY UNION ALL
        SELECT 100, 'SDI',        'SAP HANA Smart Data Integration',
                             ',{SC}_SYS_TASK,HADP%,%HADP%SHADOW%,REMOTE_SOURCE%,sap.hana.im.dp.monitor.ds%,%TRIGGER#_QUEUE,'                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'SE16',       'SE16 Change Log',
                             ',PC03#_SE16N#_CD#_DA,SE16N#_CD#_DATA,SE16N#_CD#_KEY,UASE16N#_CD#_DATA,UASE16N#_CD#_KEY,'                                                                        FROM DUMMY UNION ALL
        SELECT  90, 'SEC',        'Security and License',
                             ',/ADHOC/%,ACCESS#_CONTROL#_LIST2#_ROOT,ACM#_DTLOG,ACO#_ROLE,AGR#_%,BERCHECK,BEROBJ%,BERUSER,BKY#_REQU,BMAC_RESULTS,' ||
                             'BOSDLKEY,CS#_AUDIT#_LOG#_,OA2#_SR#_CTX%,PLMM#_QUEST#_RES,RSAU#_BUF#_DATA,RSAU#_LOG,RSECACTBCD,RSECTABCD,SAML2#_USED#_ASSRT,' ||
                             'SEC#_CONTEXT#_BLKD,SIGNDO,SIGNS,SPERS#_OBJ,SRAL#_ELOG,SRAL#_EXP%,SRAL#_LOG,SUAUTHVALTRC,' ||
                             'SUID#_PR#_USR#_RSTR,SUIM#_CHG#_IDX,TC71D,TUCNTNM#_RAW,TUL#_ACRES,TUL#_ENG#_PROT,USARC#_CDRED,' ||
                             'USERINFO#_STORAGE,USH__,USH04_ARC_TMP,USOB#_AUTHVALTRC,USRBF2,USR__,UST__,UST__S,'                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'SEM',        'Strategic Enterprise Management',
                             ',UCST001,UCL2040,UMB#_MC109,UPC#_STATISTIC%,'                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'SFI',        'SuccessFactors Integration',
                             ',SFIOM#_%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 105, 'SF-BIZX',    'SuccessFactors BizX',
                             ',ACT#_GE#_BYTEARRAY,ACT#_HI%,ALERT#_ENTRY,ASSIGNMENT,ATTACH#_AUDIT,ATTACH#_CONTENT%,ATTACHMENT#_IMAGE%,' ||
                             'AUDITTRAIL,AUDIT#_TXN#_LOG,BE#_DRS#_PERSON#_LOG,BE#_EC#_IC#_MAPPING,BE#_EF#_EMAIL#_ADDRESS,' ||
                             'BE#_LOB,BE#_TLM#_EMP#_TIME%,BE#_TLM#_TIME#_ACC#_DET,BIP#_BATCH#_RESULTS,COMP#_BUDGET,COMP#_ENTRY%,' ||
                             'COMP#_EXT,COMP#_PLAN,COMP#_RATING%,COMP#_VARPAY#_STATEMENT,DASHBOARD#_RESULT,DRM#_REQUEST,' ||
                             'EC#_IMPORT#_JOB#_BATCH#_STATUS,EL#_EVENT%,EMAIL#_RESPONSE,EL#_MONITORED#_PROCESS,' ||
                             'EMP#_%,EXT#_PROFILE#_INF,FB#_EXT,FEEDBACK,FM2#_%,FOLDER#_MAP,' ||
                             'FORM#_CONTENT,FORM#_DATA%,FORM#_DRAFT,FORM#_FEEDBACK,FORM#_RATING%,FORM#_TEMPLATE#_HISTORY,GENERIC#_OBJECT%,' ||
                             'GENERIC#_RELATIONSHIP%,GEOMAPINFO,GO#_LABEL#_ID#_MAPPING,HRSFI#_D#_COMP#_EX2,JOB#_INSTANCE%,JOB#_REQUEST,JOB#_RESPONSE,' ||
                             'LABEL#_DEPRECATED,LEARNING%,MESSAGE#_%,L#_AND_R#_MAP,OBJ#_AUDITTRAIL,OBJECTIVE,OBJ#_%,OBJPLAN#_MAPPING,ODATA#_API%,' ||
                             'PERMISSION#_MULTI,PHOTO,PHOTO#_DATA#_EXPRESSIVE,PM#_FEEDBACK#_RESP,RBP#_CACHE#_TG#_POPULATION,' ||
                             'RBP#_PERM#_RULE#_AF#_A,RBP#_RULE#_AGUSR#_MAP#_AF#_A,REPORT#_%,' ||
                             'RCM#_%,REV#_ENT,ROUTE#_%,RPT#_ELEMENT#_ATTR,SAVED#_REPORT,SEB#_EVENT,SF#_ALERT#_PAYLOAD,SF#_JOB#_DETAIL,' ||
                             'SF#_SYSAUDIT,SFAPI#_%,SM#_BACKGROUND%,SM#_TEMPLATE#_AUDIT,SM#_USER#_INFO#_AF#_A,SUBTOPIC,SYS#_CONFIG%,TEMPLATE#_AUDIT,TODO#_ENTRY,TR#_UPLOADED#_IMAGES,' ||
                             'USER#_REL%,USERS#_GROUP#_%,USERS#_INFO%,USERS#_SYSINFO%,USRGRP#_MAP,WAS#_EMPLOYEE#_AVAILABILITY,YOUCALC#_APPLICATION,'                                          FROM DUMMY UNION ALL
        SELECT 100, 'SF-LMS',     'SuccessFactors Learning Management System',
                             ',PA#_ATTACHMENT,PA#_AP%,PA#_BLOB%,PA#_CATALOG%,PA#_CBT%,PA#_CONN%,PA#_CPNT%,PA#_CLTRL%,PA#_DOMAIN%,PA#_ENROLL%,PA#_EVENT%,' ||
                             'PA#_EQB%,PA#_FIN%,PA#_IMPORT%,PA#_I18N%,PA#_LEARNING%,PA#_LOGIN%,PA#_MAIL%,PA#_MASTER%,PA#_NOTIFICATION%,PA#_OCN%,PA#_QUAL%,PA#_RECURRING%,' ||
                             'PA#_REPORT%,PA#_SAVED%,PA#_SCHED%,PA#_SHOPPING%,PA#_STUD%,PA#_SURVEY%,PA#_TAP%,PA#_TEMP%,PA#_UPLOAD%,PA#_USAGE%,' ||
                             'PA#_USER%,PB#_CPNT%,PB#_REPORT%,PH#_AP%,PH#_CATALOG%,PH#_CBT%,PH#_CPNT%,PH#_CPTY%,PH#_ENROLL%,PH#_FIN%,' ||
                             'PH#_I18N%,PH#_QUAL%,PH#_STUD%,PH#_TAP%,PS#_CLUSTER%,PS#_FOUNDATION%,PS#_I18N%,PV#_STUD%,$TA#_IXFTS%,PX#_STUDENT%,PX#_TEMP%,'                                    FROM DUMMY UNION ALL
        SELECT 100, 'SGO',        'Generic Object Services',
                             ',SGOSHIST,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'SLD',        'System Landscape Directory',
                             ',BC_SLD_CHANGELOG,BC_SLD_INST,'                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'SLO',        'System Landscape Optimization',
                             ',/SLO/%,/SLOAP/%,CNVCLU#_2E,CNV_#_SCNG#_OBJ_,MCT#_CHECK#_FIRS%,MCT#_SELECTOR#_SET,MCT#_STORAGE%,'                                                               FROM DUMMY UNION ALL
        SELECT 100, 'SLT',        'SAP HANA LT Replication Server',
                             ',/1CADMC/%,/1DH/%,/1LT/%,RS#_STATUS,RS#_ORDER,'                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'SM',         'Schedule Manager',
                             ',SMBATCH,SMEXT,SMMAIN,SMMESSAGE,SMRL,SMSELKRIT,SMSPOOL,'                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'SMD',        'Solution Manager Diagnostics',
                             ',SMD%,DIAGST#_TROW#_ELEM,EEM#_STEP#_EXEC,'                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'SNP',        'SNP AG',
                             ',/SNP/%,/THE/%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'SOA',        'Service Oriented Architecture',
                             ',BSSOA#_%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'SOFF',       'SAP Office',
                             ',SOC3,SOC3N,SOCS,SOFFCONT1,SOFFLOIO,SOFFPHF,SOFFPHIO,SOES,SOFM,SOMG,SOOD,SOOS,SOST,'                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'SOLMAN',     'Solution Manager',
                             ',/SALM/%,ACCOLLPARAMSDIR,ACRULETYPESDIR,AGS#_CC#_SCMONSTAT,AGS#_GRAPH#_BDS,AGS#_REP#_SECTION,AGS#_SUPHUB#_INBX,' ||
                             'AGS#_SUPHUB#_LOGS,AGS#_SUPHUB#_OUTBX,AGS#_TBOM#_BASE,AGS#_TBOM#_BASEIDX,' ||
                             'BDLDATCOL,BDLDTOC,CLC#_PERFORMA#_TSK,CUP#_USAGE#_DATA,DCTBW#_%,DIAGST#_TPL,DMDATTRIBBIN,DMDATTRIBUTE,DSVAS%,DSWPDOWNLOADADM,' ||
                             'E2EA#_NODEAGG#_XCF,EXM#_COLL#_CTXT,LMDB#_P#_%,MAI#_UDM#_PATHS,MAI#_UDM#_STORE,MES#_DB%,SACONT01,SISELMDB#_NOT#_ARC,'                                            FROM DUMMY UNION ALL
        SELECT 100, 'SOPDD',      'Integrated Business Planning (Staging)',
                             ',SOPDD#_STAGING#_%,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, 'SPOOL',      'Spool',
                             ',EPRINTACT,J#_2GLPLEGDOC,J#_2GLPOTF,TSPADS,TSPEVJOB,TST0%,'                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'SQLM',       'SQL Monitor',
                             ',SQLM%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'SRT',        'SOAP Runtime',
                             ',SRT%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'STATUS',     'Status Management',
                             ',DJEST,JCDO,JCDS,JEST,JSTO,ONR00,ONRVB,'                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'STX',        'SAPScript',
                             ',STX%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'SUR',        'Web Survey',
                             ',TUWS#_%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'SW',         'Workflow',
                             ',SWDA%,SWDILOG,SWJ#_CONT,SWJPCNT,SWJPCTXT,SWN#_NOTIF,SWN#_SENDLOG,SWP#_HEADER,SWP#_JOIN,SWP#_NODEWI,SWPNODE,SWPNODELOG,SWPSTEPLOG,SWT#_LOGCAT,SWUOCONT1,' ||
                             'SWW#_CONT,SWW#_CONTOB,SWWCNTP0,SWWEI,SWWFLEXPROC,SWWLOGHIST,SWWLOGPARA,SWW#_WI2OBJ,' ||
                             'SWWORGTASK,SWWOUTBOX,SWW#_PROPERTIES,SWW#_SYREGISTER,SWW#_USRATT,SWW#_WIREGISTER,SWWUSERWI,SWWWIAGENT,SWWWIDEADL,SWWWIHEAD,SWWWIRET,SWWWITEXT,'                 FROM DUMMY UNION ALL
        SELECT 100, 'SWE',        'Workflow Events',
                             ',SWE%,SWF%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'TA',         'SAP HANA Text Analysis',
                             ',$TA#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'TABREP',     'SAP HANA Table Replication',
                             ',#_SYS#_REP%,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'TDMS',       'Test Data Migration Server',
                             ',CNVTDMS%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'TLM',        'Tenant Lifecycle Management',
                             ',TLM_VAR_DUMP_ARC_VAL,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'TM',         'SAP HANA Text Mining',
                             ',$TM#_%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'TMBW',       'TM -> BW Upload',
                             ',TOR#_%,TRQ#_%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'TR',         'BW: DTP Error Stacks',
                             ',TR#_,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'TREX',       'TREX',
                             ',COM#_SE#_CPOINTER,COM#_SE#_CPOINTER2,'                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'TRM',        'Task and Resource Management',
                             ',LGPRI,LGRQA,LGTKL,LGTKS,LLGRH,LLGRI,LLGRN,LLGRT,LLGTM,LPLTM,'                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, 'TRS',        'Treasury',
                             ',FLQITEM%,IHC#_DB#_PN#_%,TCORFT#_%,TEXT#_RAWEXPOS,TEXT#_REXP#_ITEM,TEXT#_REXP#_SUBIT,THAHRT#_%,TRDT#_%,TRLT#_%,'                                                FROM DUMMY UNION ALL
        SELECT 100, 'TS',         'Time Sheet',
                             ',CATSCO,CATSCOSUM,CATSDB,CATSMM,CATSPM,CATSPS,CATS#_ARCH#_IDX,'                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, 'TTE',        'Transaction Tax Engine',
                             ',TTEPDT#_DOCCL,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'TUDF',       'SQLScript (TUDF)',
                             ',#_SYS#_SS#_TBL%,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, 'UDM',        'Dispute Management',
                             ',UDM%,'                                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, 'UI',         'BYD: User Interface',
                             ',APUI#_I#_SHM#_BCKUP,OFFLINE#_CLIENT#_STATE,OFFLINE#_DOWNLOAD#_CACHE,'                                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'UJ',         'BPC: Static Tables',
                             ',UJ%,'                                                                                                                                                          FROM DUMMY UNION ALL
        SELECT 100, 'USAGE',      'Usage Logging',
                             ',SUSAGEMANAGEMENT,SUSAGE2,'                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'VB',         'Update Tables',
                             ',VBDATA,VBERROR,VBHDR,VBLOG,VBMOD,'                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, 'VISTEX',     'Vistex',
                             ',/IRM/%,/VGM/%,/VTA/%,VTABDO~%,'                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, 'WD',         'Web Dynpro',
                             ',WDG#_MIMES,WDR#_USAGE#_LOG,WDY#_CONF#_USER,'                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, 'WM',         'Warehouse Management',
                             ',LAGP,LINK,LINP,LINV,LTAK,LTAP,LTBK,LTBP,LUBU,LVVRO,MGEF,T311A,T337B,T311L,'                                                                                    FROM DUMMY UNION ALL
        SELECT 100, 'WSRM',       'Web Services Reliable Messaging',
                             ',WSRMB#_%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, 'WU',         'Where-Used List',
                             ',CHVW%,CROSS,D010TAB,WBCROSSGT,WBCROSSI,'                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, 'WUI',        'WebClient UI',
                             ',BSPC#_%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, 'XI',         'XI Integration Server',
                             ',SXMS%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'XSA',        'XS Advanced',
                             ',{SC}HDI_BROKER_CONTROLLER,{SC}sap_sb,{SC}SYS_XS_HANA_BROKER,{SC}SYS_XS_RUNTIME,{SC}SYS_XS_SBSS,{SC}SYS_XS_UAA%,{SC}_SYS_DI%,{SC}XSA_ADMIN,'                    FROM DUMMY UNION ALL
        SELECT 200, 'ZBI_Z',      'BW: Shadow Tables',
                             ',ZBI_Z%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 200, 'Z',          'Customer Tables (ABAP)',
                             ',Y%,Z%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, 'ZARIX',      'Archiving',
                             ',ADMI#_VARIA,ARCH#_IDX,ARCH#_IDX#_S,ARIX#_%,BCGEN00#_XMLA%,BC_XMLA#_RES,TOAAT,TOACB,TOAHR,TOALOG,TOA0%,ZARIX%,'                                                 FROM DUMMY UNION ALL
        SELECT 100, 'ZBICZ',      'BW Shadow Tables',
                             ',ZBICZ%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '_SYS_BI',    'SAP HANA Models Metadata',
                             ',{SC}_SYS_BI,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, '_SYS_BIC',   'SAP HANA Models',
                             ',{SC}_SYS_BIC,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '_SYS_PLAN_STABILITY', 'SAP HANA Plan Stability',
                             ',{SC}_SYS_PLAN_STABILITY,'                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '_SYS_REPO', 'SAP HANA Repository',
                             ',{SC}_SYS_REPO,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, '_SYS_STATISTICS', 'SAP HANA Statistics Server',
                             ',{SC}_SYS_STATISTICS,'                                                                                                                                          FROM DUMMY UNION ALL
        SELECT 100, '_SYS_XS',    'Lumira',
                             ',{SC}_SYS_XS,'                                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, '_SYS_WORKLOAD_REPLAY', 'SAP HANA Capture and Replay',
                             ',{SC}_SYS_WORKLOAD_REPLAY,'                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/AAR/',      'Aareal Bank',
                             ',/AAR/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ABCCAT/',   'AmerisourceBergen',
                             ',/ABCCAT/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/ABEX/',     'ABEX',
                             ',/ABEX/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ABPSCM/',   'SCM: Attribute Based Planning',
                             ',/ABPSCM/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/ACCCPT/',   'Accrual Cockpit',
                             ',/ACCCPT/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/ACNAAES/',   'ABAP Building Blocks',
                             ',/ACNAAES/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/ADD/',      'AddTAX',
                             ',/ADD/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/AEB/',      'AEB',
                             ',/AEB/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/AFI/',      'AFI Solutions',
                            ',/AFI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/AIF/',      'Application Interface Framework',
                            ',/AIF/%,/AIFECC/%,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, '/ALLTECH/',  'AllTech Consulting',
                             ',/ALLTECH/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/ALPJR2S/',   'Alpein Software (JIRA2SAP)',
                             ',/ALPJR2S/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/AMR/',      'Allocation Management for Retail',
                            ',/AMR/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/AMS/',      'Nestl  AMS',
                            ',/AMS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/AOL/',      'Atos Label Print Cockpit',
                            ',/AOL/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/APICON/',   'APICON GmbH',
                            ',/APICON/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/ARBA/',     'Ariba',
                            ',/ARBA/%,ARBCIG#_CHANGEDOC,ARBCIG#_DOCCHANGE,'                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/ARTEC/',     'ARTEC IT Solutions AG',
                            ',/ARTEC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ASADEV/',    'Asapio GmbH',
                            ',/ASADEV/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/ASEM/',     'Asem Group AG (Inkasso)',
                            ',/ASEM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ATEC/',     'Implico (Avalara Connector)',
                            ',/ATEC/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ATSP/',     'AT Solution Partner GmbH',
                            ',/ATSP/%,/ZATSP/%,'                                                                                                                                              FROM DUMMY UNION ALL
        SELECT 100, '/AUDI/',     'Audi',
                            ',/AUDI/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/AUDIC/',     'Audicon GmbH',
                            ',/AUDIC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/AXO/',      'oxando Mobile Connector',
                            ',/AXO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/A1SSPC/',   'BYD: Service Provider Cockpit',
                            ',/A1SSPC/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/BA1/',      'Bank Analyzer: Source Data Layer (SDL)',
                            ',/BA1/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BASF/',     'BASF',
                            ',/BASF/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BAY_/',     'Bayer',
                            ',/BAY_/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BBC/',      'Serrala (Soplex)',
                            ',/BBC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BDL/',      'SAP Solution Tools Plug-In (ST-PI): Service Data Download',
                            ',/BDL/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BE2/',      'Blue Eagle (Aareon)',
                            ',/BE2/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BEV1/',     'Beverage',
                            ',/BEV1/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BIT/',      'Beck IT GmbH',
                            ',/BIT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BNWVS/',    'PowerConnect for Splunk',
                            ',/BNWVS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/BPICS/',    'EBS Processing Framework',
                            ',/BPICS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/BOBF/',     'Business Objects Processing Framework',
                            ',/BOBF/%,/1MKT/%,'                                                                                                                                               FROM DUMMY UNION ALL
        SELECT 100, '/BSAR/',     'Balance Sheet Account Reconciliation',
                            ',/BSAR/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BSHBW/',    'BSH BW',
                            ',/BSHBW/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/BSHE/',     'BSH EWM',
                            ',/BSHE/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BSHK/',     'BSH MARS CRM',
                            ',/BSHB/%,/BSHG/%,/BSHK/%,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/BSNAGT/',   'Multi Bank Connectivity',
                             ',/BSNAGT/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/BTCMAN/',   'HONICO Systems GmbH',
                            ',/BTCMAN/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/BTI/',      'Basis Technologies International',
                            ',/BTI/%,/BTR/%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/BUP/',      'Brandt & Partner GmbH',
                            ',/BUP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/BVCCSAP/',  'Bundesamt für Informatik und Telekommunikation (BIT)',
                            ',/BVCCSAP/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/B05/',      'Bosch BW Content Generation',
                            ',/B05/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/B28/',      'BW: BPC BI objects',
                            ',/B28/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%' || '00',   'BW: DSO (Std. Act. Data, Write Opt., Direct Update)',              /* % and 0 need to be separated to bypass SQL console issue */
                            ',/B%/A%' || '00,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%40',   'BW: Standard DSO (Activation Queue)',
                            ',/B%/A%40,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%50',   'BW: Standard DSO (BW 3.5: Change Log)',
                            ',/B%/A%50,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%1',    'BW: Advanced DSO (Inbound Queue)',
                            ',/B%/A%1,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%2',    'BW: Advanced DSO (Active Data)',
                            ',/B%/A%2,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%3',    'BW: Advanced DSO (Change Log)',
                            ',/B%/A%3,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%4',    'BW: Advanced DSO (Validity Table)',
                            ',/B%/A%4,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/A%5',    'BW: Advanced DSO (Reference Points)',
                            ',/B%/A%5,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 210, '/B%/B',      'BW: PSA / Standard DSO (Change Log)',
                            ',/B%/B%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/BD',     'BW: Data Transfer Intermediate Storage',
                            ',/B%/BD%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/C',      'BW: XXL Attributes',
                            ',/B%/C%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/D',      'BW: Dimension Tables',
                            ',/B%/D%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/E',      'BW: E Fact Tables',
                            ',/B%/E%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/F',      'BW: F Fact Tables',
                            ',/B%/F%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/H',      'BW: Hierarchical Tables',
                            ',/B%/H%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/I',      'BW: Hierarchical SID Structure Tables',
                            ',/B%/I%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/J',      'BW: Hierarchical Intervals',
                            ',/B%/J%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/K',      'BW: Hierarchical SID Tables',
                            ',/B%/K%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/L',      'BW: NCUM Validity Tables',
                            ',/B%/L%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/O',      'BW: Var: Arch Openhub Broadcast',
                            ',/B%/O%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/P',      'BW: Time Independent Attributes',
                            ',/B%/P%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/Q',      'BW: Time Dependent Attributes',
                            ',/B%/Q%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/S',      'BW: SID Tables',
                            ',/B%/S%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/T',      'BW: Texts for Master Data',
                            ',/B%/T%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/UW',     'BPC: Work Status Locks',
                            ',/B%/UW%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 110, '/B%/X',      'BW: Time Independent Navigation Attributes',
                            ',/B%/X%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/Y',      'BW: Time Dependent Navigation Attributes',
                            ',/B%/Y%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/Z',      'BW: Remodeling Shadow Tables',
                            ',/B%/Z%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/000APR', 'BW: Analysis Process Designer',
                            ',/B%/000APR%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 110, '/B%/0',      'BW: Temporary Tables',
                            ',/B%/0%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/1',      'BW: Migration to HANA-optimized Cubes Shadow Tables',
                            ',/B%/1%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/4',      'BW: Repartitioning Shadow Tables (temp.)',
                            ',/B%/4%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 110, '/B%/9',      'BW: SCM',
                            ',/B%/9%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CBA/',      'Commonwealth Bank of Australia',
                            ',/CBA/%,'                                                                                                                                                        FROM DUMMY UNION ALL                            
        SELECT 100, '/CBR/',      'BYD: Managed Cloud Analytics',
                            ',/CBR/%,'                                                                                                                                                        FROM DUMMY UNION ALL                            
        SELECT 100, '/CBSGMBH/',  'Corporate Business Solutions GmbH',
                            ',/CBSGMBH/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/CCFRW/',    'Uniserv (Caution & Compliance Framework)',
                            ',/CCFRW/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/CCPM/',     'Critical Chain Project Management',
                            ',/CCPM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/CDLG/',     'CODiLOG',
                            ',/CDLG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/CDX/',      'Cross-/flowDOCS GmbH',
                            ',/CDX/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CEETMCZ/',  'Localization for CEE Countries',
                            ',/ATL/%,/CEETMCZ/%,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, '/CERAUT/',  'Cerner',
                            ',/CERAUT/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/CGS%/',     'Cormeta (CGsprint)',
                            ',/CGS%/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/CHPDPE/',  'Pre-determined Pricing Engine',
                            ',/CHPDPE/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/CLR/',      'Defmacro Software (Clear Compliance Add-on)',
                            ',/CLR/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CLS/',      'Camelot Lean Suite',
                            ',/CLS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CMD/',      'Cormeta AG',
                            ',/CMD/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CNM/',      'Aigner GmbH & Co.KG (smart PLM)',
                            ',/CNM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/COCKPIT/',  'Ebydos (Invoice Cockpit)',
                            ',/COCKPIT/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/COG/',      'Compugroup Holding AG',
                            ',/COG/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CONSOLUT/',      'consolut.gmbh',
                            ',/CONSOLUT/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/CPD/',      'Commercial Project Management',
                            ',/CPD/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CPS/',      'Consulting People GmbH',
                            ',/CPS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CQSE/',     'Continuous Quality in Software Engineering GmbH',
                            ',/CQSE/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/CRC/',      'Soplex (Creditreform Connect)',
                            ',/CRC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CRMGWS/',   'Desktop Connection for SAP CRM',
                            ',/CRMGWS/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/CS75/',     'Convista Treasury Adapter',
                            ',/CS75/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/CTCOL/',    'EnCo',
                            ',/CTCOL/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/CTDSX/',    'DSX',
                            ',/CTDSX/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/CUM/',      'Compatible Units Management',
                            ',/CUM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CWL/',      'Cormeta (Worklist)',
                            ',/CWL/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/CWM/',      'Catch Weight Management',
                            ',/CWM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DA3/',      'Duplicate Analyzer',
                            ',/DA3/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DBE/',      'Proaxia (Dealer Business Management)',
                            ',/DBE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DBF/',      'Daimler-Benz (OneERP)',
                            ',/DBF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DBM/',      'Dealer Business Management',
                            ',/DBM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DEERE/',    'Deere (Common Development)',
                            ',/DEERE/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/DEEREAG/',  'Deere (WWAG Development Objects)',
                            ',/DEEREAG/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/DEEREMES/', 'Deere (WWAG MES Development Objects)',
                            ',/DEEREMES/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/DEMATIC/', 'Dematic GmbH',
                            ',/DEMATIC/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/DFI/',      'Deployment Factory Insurance',
                            ',/DFI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DFS/',      'Docflow',
                            ',/DFS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DMF/',      'Demand Management Foundation',
                            ',/DMF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DIGIGST/', 'DigiGST (EY)',
                            ',/DIGIGST/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/DOC/',      'BYD: Document-centric Application Services',
                            ',/DOC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DOL/',      'Serrala (Archive Migration Toolkit)',
                            ',/DOL/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DPM/',      'Daimler SPM',
                            ',/DPM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DSCSAG/',   'DSC Software AG',
                            ',/DSCSAG/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/DSD/',      'Direct Store Delivery',
                            ',/DSD/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DSRT/',      'Dansk Supermarked Retail',
                            ',/DSRT/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/DTBOM/',     'Daimler Trucks TruckBoM',
                            ',/DTBOM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/DT0/',      'Daimler TruckSupply',
                            ',/DT0/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/DVD/',      'DataVard',
                            ',/DV1/%,/DVD/%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/DYNAM/',     'Snow Optimizer',
                            ',/DYNAM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/EBY/',      'Process Director ReadSoft Ebydos',
                            ',/EBY/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/ECRS/',     'Intrastat',
                            ',/ECRS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/EDC/',      'Esprit',
                            ',/EDC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EDGE/',     'Techedge',
                            ',/EDGE/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/EHR/',      'Accenture (Pecaso)',
                            ',/EHR/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EIC/',      'Employee Interaction Center',
                            ',/EIC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EMSIS/',    'Electronic Media Solution in SAP',
                            ',/EMSIS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/EON/',      'E.ON AG (S/4 Core Developments)',
                            ',/EON/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EONIS/',      'E.ON AG (EXTRANET)',
                            ',/EONIS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/EPO1/',     'XML Connector (EPO Consulting)',
                            ',/EPO1/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ERPIS/',    'ERP Integrated Solutions',
                            ',/ERPIS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ERPS01/',   'smahrt consulting AG',
                            ',/ERPS01/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/ETN/',      'E.ON AG (S/4 Grid Developments)',
                            ',/ETN/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EUR/',      'Nestl  EUR',
                            ',/EUR/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EXAOTP/',   'EXA AG (Operational Transfer Pricing)',
                            ',/EXAOTP/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/EXT/',      'Extensibility Services',
                            ',/EXT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/EZO/',      'E.ON AG (S/4 Operational Developments)',
                            ',/EZO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/FARSIDE/',  'Farside',
                            ',/FARSIDE/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/FCMS/',      'File Content Management System',
                            ',/FCMS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/FDSHSB01/',  'HSBC Real Time Reporting Backend',
                            ',/FDSHSB01/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/FFIS/',      'Forecasting for Fresh Items',
                            ',/FFIS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/FHEFO/',   'FH e-FDocs - Electronic Fiscal Documents - Outbound',
                            ',/FHEFO/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/FHG/',      'FH Guepardo',
                            ',/FHG/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/FIS/',      'FIS GmbH',
                            ',/FIS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/FISMPM/',   'FIS (Master Data and Price Management)',
                            ',/FISMPM/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/FISXEE/',   'FIS GmbH (FIS/xee)',
                            ',/FISXEE/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/FIN3/',     'Financial Supply Chain Management Service Offering',
                            ',/FIN3/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/FINLYNC/',  'Finlync',
                            ',/FINLYNC/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/FIT/',      'Freudenberg IT',
                            ',/FIT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/FITE/',     'e-Archive',
                            ',/FITE/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/FLDQ/',     'Business Objects EIM',
                            ',/FLDQ/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/FORIBA/',   'Foriba',
                            ',/FORIBA/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/GBTINT/',   'Global Batch Traceability',
                            ',/GBTINT/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/GDS/',      'GDS Engineered Services',
                             ',/GDS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/GECI/',     'El Corte Ingles',
                            ',/GECI/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/GHTKUE/',   'General Health Template K che / Verpflegungsmanagement (VPM)',
                            ',/GHTKUE/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/GIB/',      'GIB Addons',
                            ',/GIB/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/GICOM/',    'Gicom GmbH',
                            ',/GICOM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/GKV/',      'GKV Add-On (AOK Systems)',
                            ',/GKV/%,/GKVS/%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, '/GOOG/',     'Google',
                            ',/GOOG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HACA/',     'Highradius Advanced Correspondence Automation',
                            ',/HACA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HARF/',     'Highradius A/R Framework',
                            ',/HARF/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HCDA/',     'HighRadius Credit Decision Accelerator',
                            ',/HCDA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HCR/',      'Hicron',
                            ',/HCR/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/HCX/',      'Xantas AG (Business Content Extended)',
                            ',/ATX/%,/HCX/%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/HECLM/',    'HANA Enterprise Cloud Lifecycle Management',
                            ',/HECLM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/HFW/',      'Workflow Framework',
                            ',/HFW/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/HOAG/',     'Serrala (Hanse Orga)',
                            ',/HOAG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HRCI/',     'SHAPEiN',
                            ',/HRCI/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/HSUD/',     'Hamburg S d',
                            ',/HSUD/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/IBASE/',    'iBase Engine',
                            ',/IBASE/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/IBBJ/',     'Informatikb ro Bernd Jaumann',
                            ',/IBBJ/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/IBD2/',      'Iberdrola',
                            ',/IBD2/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/IBMMON/',   'IBM Monitoring Products',
                            ',/IBMMON/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/IBP/',      'Integrated Business Planning',
                            ',/IBP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IBS/',      'Innovative Banking Solutions AG',
                            ',/IBS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IBSPROD/',  'Invenio Business Solutions Prometheus',
                            ',/IBSPROD/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/ICO/',      'Industry Solution Oil and Gas (Secondary Distribution)',
                            ',/ICO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/ICSG/',   'ICON Integration - RF Framework',
                            ',/ICFG/,/ICSG/%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, '/IDE/',      'eHesApp',
                            ',/IDE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IDT/',      'ONESOURCE Indirect Tax',
                            ',/IDT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IDXGC/',    'IDEX Global Common Layer',
                            ',/IDXGC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/IDXPF/',    'Intercompany Data Exchange Process Framework',
                            ',/IDXPF/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/IGZ/',      'IGZ Logistics + IT GmbH',
                            ',/IGZ/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IIT/',      'CubeServ',
                            ',/IIT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/ILC/',      'ILC GmbH',
                            ',/ILC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/IMA/',      'FRUN (Advanced Integration Monitoring)',
                            ',/IMA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/ISPCD/',    'BYD: Platform Change Documents',
                            ',/ISPCD/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ITESOFT/',  'Itesoft',
                            ',/ITESOFT/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/ITMCS/',    'ITMCS GmbH',
                            ',/ITMCS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ITPOS/',    'itPOS',
                            ',/ITPOS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ITSAM/',    'ITSAM',
                            ',/ITSAM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/ITSC/',    'A1S ITSAM Content',
                            ',/ITSC/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ITTR/',     'Itelligence (POS Solution)',
                            ',/ITTR/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/IWNGW/',    'Notification Gateway',
                            ',/IWNGW/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/IX2/',      'it.x-press',
                            ',/IX2/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/JA41/',     'All for One Steeb (EDI Exakt)',
                            ',/JA41/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/KAGES/',    'KAGes',
                            ',/KAGES/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/KGS1/',     'KGS Software',
                            ',/KGS1/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/KAGES/',    'KNAPP IT Solutions',
                            ',/KNAPP/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/KUO/',      'Grupo Kuo',
                            ',/KUO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/LGC/',      'Linde (Core)',
                            ',/LGC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/LGDISH1/',  'speaKING (MediaInterface)',
                            ',/LGDISH1/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/LIG/',      'Linde Gas',
                            ',/LIG/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/LIME/',     'Logistics Inventory Management Engine',
                            ',/LIME/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/LKMT/',     'LKM Tecnologia',
                            ',/LKMT/%,/LKMCGER/%,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, '/LOGWIN/',   'UI Logging',
                            ',/LOGWIN/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/LOT/',      'Ortec (Logiplan Optimizer Tools)',
                            ',/LOT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/LUCANET/',  'LucaNet',
                            ',/LUCANET/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/LUNCAR/',   'Lunar GmbH (CAR)',
                            ',/LUNCAR/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/LUNDT/',    'Lunar GmbH (POS DTA)',
                            ',/LUNDT/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/LUNDW/',    'Lunar GmbH (Digitale Warenwirtschaft)',
                            ',/LUNDW/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/LUP/',      'Lupus Consulting',
                            ',/LUP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/MAHLE/',      'Mahle GmbH',
                            ',/MAHLE/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/MDPES/',      'MDP Group',
                            ',/MDPES/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/MDS/',      'Itelligence (it.mds)',
                            ',/MDS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/MERP/',      'Mobile Application Integration',
                            ',/MERP/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/MERVAT/',   'Meridian VAT Add-On',
                            ',/MERVAT/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/MFND/',     'Mobile Add-On Integration Foundation',
                            ',/MFND/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/MIC/',      'MIC Datenverarbeitung GmbH',
                            ',/MIC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/MOBISYS/',  'Mobisys GmbH',
                            ',/MOBISYS/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/MOVI/',     'Movilizer',
                            ',/MOVI/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/MRG/',      'Munich Re Gloria FS-RI AddOn',
                            ',/MRG/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/MSAFX/',     'Mastersaf',
                            ',/MSAFX/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/MSB5/',     'Mobisys GmbH (MSB Five)',
                            ',/MSB5/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/MRSS/',     'Multi Resource Scheduling',
                            ',/MRSS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/MSG/',      'msg systems',
                            ',/MPR/%,/MSG/%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/MVN/',      'MavenTax',
                            ',/MVN/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/NEPTUNE/',  'Neptune Software',
                            ',/NEPTUNE/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/NESGLB/',   'Nestle GLOBE',
                            ',/AOA/%,/GLB/%,/NESGLB/%,'                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/NFM/',      'Non-Ferrous Metals',
                            ',/NFM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/NOP/',      'Maxpost',
                            ',/NOP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/NXI/',      'Profitability and Performance Management',
                            ',/NXI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/OAA/',      'Omnichannel Article Availability',
                            ',/OAA/%,OAA#_%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/OAP/',      'okadis Consulting (Accounting Platform)',
                            ',/OAP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/OBIZ/',     'OptiGST',
                            ',/OBIZ/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/OKA/',      'okadis Consulting (standard namespace)',
                            ',/OKA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/OMES/',     'Orbis Manufacturing Execution System',
                            ',/OMES/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/ORSOFT/',   'ORSOFT GmbH',
                            ',/ORSOFT/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/OSA/',      'On-Shelf Availability',
                            ',/OSA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/OSCOL/',    'Osco GmbH (Logistics)',
                            ',/OSCOL/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/OSP/',      'Office Suite Program',
                            ',/OSP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/OTDP/',     'Open Text Document Presentment',
                            ',/OTDP/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/O4H/',      'Ortec (S/4HANA)',
                            ',/O4H/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PACG/',     'Proaxia Consulting Group (FSM Cloud Connector)',
                            ',/PACG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PARCON/',   'ParCon GmbH',
                            ',/PARCON/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/PARICON/',  'Paricon AG',
                            ',/PARICON/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/PAT/',      'Industry Solution Oil and Gas (Process Automation Toolset)',
                            ',/PAT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PAYMETRC/', 'Paymetric / Worldpay B2B Payments',
                            ',/PAYMETRC/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/PBK/',      'PBK',
                            ',/PBK/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PBS/',      'PBS Software GmbH',
                            ',/PBS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PCIS*/',    'PCIS Planet',
                            ',/PCIS%/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/PCM2/',     'Farside (Picking Control Monitor)',
                            ',/PCM2/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PDO/',      'ProData Wien',
                            ',/PDO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PE1/',      'Payment Engine',
                            ',/PE1/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PEC/',      'Pecaso',
                            ',/PEC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PERSONAS/', 'SAP Screen Personas',
                            ',/PERSONAS/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/PF1/',      'Payment Factory',
                            ',/PF1/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PGP/',      'Prometheus Group',
                            ',/PGP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PGT*/',     'Pelissari Gestão e Tecnologia',
                            ',/PGTPA/%,/PGTUTIL/%,/PGTXP/%,'                                                                                                                                  FROM DUMMY UNION ALL
        SELECT 100, '/PHO/',      'eCl@ss',
                            ',/PHO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PLMA/',     'CIDEON Software GmbH',
                            ',/PLMA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PLMB/',     'Product Lifecycle Management Core',
                            ',/PLMB/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PLMI/',     'Product Lifecycle Management Core ERP Integration',
                            ',/PLMI/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PLVAT/',    'Poland: Standard Audit Tax File',
                            ',/PLVAT/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/PM0/',      'Financial Services Policy Management',
                            ',/PM0/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/POSDW/',    'Point of Sale',
                            ',/POSDW/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/PRA/',      'Production and Revenue Accounting',
                            ',/PRA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PREPAY/', 'IS-U Prepay',
                            ',/PREPAY/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/PRM/',      'Promotions',
                            ',/PRM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PROMENTA/', 'Promenta',
                            ',/PROMENTA/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/PROQ/',     'Daimler (New Procurement System)',
                            ',/PROQ/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/PSI/',      'Psinova AG',
                            ',/PSI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PSIIC/',    'Psinova AG (Invoice Center)',
                            ',/PSIIC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/PSINDS/',   'Psinova AG (Invoice Center)',
                            ',/PSINDS/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/PSYNG/',    'Security Weaver',
                            ',/PSYNG/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/PWEAVER/',  'ProcessWeaver',
                            ',/PWEAVER/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/PWS/',      'PWS',
                            ',/PWS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/PXY/',      'Proxyon',
                            ',/PXY/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/QTQVC/',    'Qlik Connectors',
                            ',/QTQVC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/RAP/',      'Retail Applications for Planning',
                            ',/RAP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/RB05/',     'Bosch BW Content',
                            ',/RB05/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/REM/',      'Remedyne',
                            ',/REM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/RIT/',      'rit edv-consulting GmbH',
                            ',/RIT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/RPM/',      'xApp Resource and Portfolio Management',
                            ',/RPM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/RSC/',      'Revelation Software Concepts',
                            ',/RSC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/RTEF/',     'RTeasy Framework (Sopra Steria GmbH)',
                            ',/RTEF/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/RUM/',      'FRUN (Real User Monitoring)',
                            ',/RUM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SAI/',      'Simplified Accounting Integration',
                            ',/SAI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SAPCND/',   'Customer Relationship Management Conditions',
                            ',/SAPCND/%,CNCCRMPRCUS%,CND#_MAPM#_CNV#_REC,'                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/SAPFCX/',   'Freight Cost Extension',
                            ',/SAPFCX/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SAPLOM/',   'Logistics Monitors',
                            ',/SAPLOM/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SAPPO/',    'Post Processing Office',
                            ',/SAPPO/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SAPSLL/',   'Legal and Logistics Services',
                            ',/SAPSLL/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SAPSRM/',   'Supplier Relationship Management',
                            ',/SAPSRM/%,BBPCONT,BBP#_PD%,BBPD#_PD%,BBP#_TRANSXSTRING,'                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SAPTRX/',   'Event Management',
                            ',/SAPTRX/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SAST/',     'System Audit und Security Toolkit (Akquinet AG)',
                            ',/SAST/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SAXAG/',    'SAX AG',
                            ',/SAXAG/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SCA/',      'Supply Network Collaboration',
                            ',/SCA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SCC/',      'scc EDV-Beratung AG',
                            ',/SCC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SCMB/',     'Supply Chain Management Basis',
                            ',/SCMB/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SCMTMS/',   'Transportation Management',
                            ',/SCMTMS/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SCTECH/',   'SCT Software',
                            ',/SCTECH/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SDF/',      'SAP Solution Tools Plug-In (ST-PI)',
                            ',/SDF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SEAL/',     'SEAL Systems AG',
                            ',/SEAL/%,/DVSREPRO/%,'                                                                                                                                           FROM DUMMY UNION ALL
        SELECT 100, '/SECUDESD/', 'Secure Halocore Client for NetWeaver',
                            ',/SECUDESD/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/SECUDEH1/', 'Secure Halocore DSI',
                            ',/SECUDEH1/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/SEEAG/',    'Seeburger AG',
                            ',/SEEAG/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SER/',      'SER Group',
                            ',/SER/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SERKEM/',   'SERKEM GmbH',
                            ',/SERKEM/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SFN/',      'SIGGA Foundation on NetWeaver',
                            ',/SFN/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SFTCMX/',   'Pacote Softway',
                            ',/SFTCMX/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SHN/',      'Siemens Netherlands',
                            ',/SHN/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SIAM/',     'SiAM',
                            ',/SIAM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SICONS/',   'SI-Consulting',
                            ',/SICONS/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SIE/',      'Siemens',
                            ',/SIE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SKY/',      'Skytech ECS',
                            ',/SKY/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SLV/',      'eInvoice',
                            ',/SLV/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SMCRM/',    'Agentry SAP Framework - CRM AddOn',
                            ',/SMCRM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SMEP/',     'ITeanova (msg)',
                            ',/SMEP/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SMERP/',    'Agentry SAP Framework - ERP AddOn',
                            ',/SMERP/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SMES/',     'Salt Solutions',
                            ',/SMES/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SMB/',      'Implementation Framework Infrastructure',
                            ',/SMB/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SMFND/',    'Work Manager',
                            ',/SMFND/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SNO/',      'SAP Notes',
                            ',/SNO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SOMO/',     'Solution Tools Plugin: Monitor',
                            ',/SOMO/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SOP/',      'Soplex Consult GmbH',
                            ',/SOP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SPRING/',  'Evry A/S (now: TietoEvry)',
                            ',/SPRING/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SPROGNF/',  'SPRO IT Solutions',
                            ',/SPROGNF/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/SNAP/',     'Snap Consulting',
                            ',/SNAP/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SNI/',      'SNI Consulting',
                            ',/SNI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SPDGS/',    'softproviding AG',
                            ',/SPDGS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SPE/',      'Service Parts Enterprise Development',
                            ',/SPE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SPMEAT/',   'softproviding AG (myMEAT)',
                            ',/SPMEAT/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SRCORE/',   'Superuser Privilege Management (SPM)',
                            ',/SRCORE/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SRMNXP/',   'Supplier Relationship Management UI Addon',
                            ',/SRMNXP/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SSC/',      'tangro software components GmbH',
                            ',/SSC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SSF/',      'Service Software Framework',
                            ',/SSF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/STARC/',    'Starcons GmbH',
                            ',/STARC/%,/STARS/%,'                                                                                                                                             FROM DUMMY UNION ALL
        SELECT 100, '/STCSC/',    'Support Tech. Cloud Services',
                            ',/STCSC/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/STMC/',     'Technical Monitoring Cockpit',
                            ',/STMC/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/STRCM/',    'Stratesys (PYXIS)',
                            ',/STRCM/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/STTP/',     'Advanced Track and Trace for Pharmaceuticals',
                            ',/STTP/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SUP/',      'inconso AG',
                            ',/SUP/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SVT/',      'Service and Support Infrastructure',
                            ',/SVT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SVX/',      'DBS Support Infrastructure',
                            ',/SVX/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SWAG/',     'SAPWare AG',
                            ',/SWAG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/SXS/',      'smahrt consulting XS-BPM',
                            ',/SXS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/SYCLO/',    'Syclo LLC',
                            ',/SYCLO/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SYCLOU/',    'Syclo LLC (Update Fields)',
                            ',/SYCLOU/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/SYSKO/',    'Syskoplan AG',
                            ',/SYSKO/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/SYSTEMA/',  'CompoGroup Medical',
                            ',/SYSTEMA/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/TAULIA/',   'Taulia',
                            ',/TAULIA/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/TCON/',     'T.CON GmbH & Co. KG',
                            ',/TCON/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TDAG/',     'TechniDATA AG (Addon Developments)',
                            ',/TDAG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TECSYS/',   'Tecsys Consulting',
                            ',/TECSYS/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/TERADATA/',  'CompoGroup Medical',
                            ',/TERADATA/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/TFCD/',     'Customer developments (top flow GmbH)',
                            ',/TFCD/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TISA/',     'Top Image Systems (eFlow Account Payable Automation)',
                            ',/TISA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TJC/',      'TJC Group',
                            ',/TJC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/TKAG/',     'ThyssenKrupp AG',
                            ',/TKAG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TM1/',      'TrendMind IT Dienstleistung GmbH',
                            ',/TM1/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/TMF/',      'Tax Management Framework Brazil',
                            ',/TMF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/TMCMA/',    'CMA (Transportation Management)',
                            ',/TMCMA/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/TOPFLOW/', 'top flow GmbH',
                            ',/TOPFLOW/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/TRILLIUM/', 'Trillium Software',
                            ',/TRILLIUM/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/TRL/',      'TerraLink',
                            ',/TRL/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/TRP/',      'Transportation Resource Planning',
                            ',/TRP/%,{SC}SAP_TM_TRP,'                                                                                                                                         FROM DUMMY UNION ALL
        SELECT 100, '/TSAO/',     'T-Systems Add On',
                            ',/TSAO/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/TWH/',      'Teamwork HR Solutions',
                            ',/TWH/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/TWSOL/',    'Teamwork Solutions',
                            ',/TWSOL/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/TWSPA/',    'Teamwork Solution Packages',
                            ',/TWSPA/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/TYED/',     'Tyrolit (Extended Development)',
                            ',/TYED/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/UIM/',      'Field Level Security', 
                            ',/UIM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/UISM/',      'UI Data Protection Masking',
                            ',/UISM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/UI2/',      'UI Backend Enablement', 
                            ',/UI2/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/UI5/',      'UI5',
                            ',/UI5/%,/UIF/%,'                                                                                                                                                 FROM DUMMY UNION ALL
        SELECT 100, '/USE/',      'EPI-USE Labs GmbH',
                            ',/USE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/USI/',      'USI',
                            ',/USI/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/UZAUTO/',   'UzAuto Motors',
                            ',/UZAUTO/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/VCMG/',   'Verbella CMG',
                            ',/VCMG/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/VERTEX/',   'Vertex',
                            ',/VERTEX/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/VIRSA/',    'Virsa System Developments',
                            ',/VIRSA/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/VFORGE/',   'Virtual Forge',
                            ',/VFORGE/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/VRT/',      'Virtusa',
                            ',/VRT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/VUS/',      'Cormeta (VUsprint)',
                            ',/VUS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/VWK/',      'Volkswagen AG',
                            ',/VWK/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/WECO/',     'WECO Software GmbH',
                            ',/WECO/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/WINSHTLQ/', 'Winshuttle',
                            ',/WINSHTLQ/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/WMD/',      'WMD Group',
                            ',/WMD/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/WORKSOFT/', 'Worksoft',
                            ',/WORKSOFT/%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/WINSHTLQ/QREPRC/', 'Winshuttle',
                            ',/WINSHTLQ/QREPRC/%,'                                                                                                                                            FROM DUMMY UNION ALL
        SELECT 100, '/WSCGMBH/',  'WSC GmbH',
                            ',/WSCGMBH/%,'                                                                                                                                                    FROM DUMMY UNION ALL
        SELECT 100, '/XEGR/',      'E-IT (E-GR - Automation of Inbound)',
                            ',/XEGR/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/XEIT/',      'E-IT (Core Components and Cockpit)',
                            ',/XEIT/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/XFT/',      'XFT GmbH',
                            ',/XFT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/XITING/',   'Xiting AG',
                            ',/XITING/%,'                                                                                                                                                     FROM DUMMY UNION ALL
        SELECT 100, '/XNFE/',      'Nota Fiscal Eletronica',
                            ',/XNFE/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/XPLM/',     'XPLM',
                            ',/XPLM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/YAMBS/',    'Software4Professionals GmbH',
                            ',/YAMBS/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/YTC/',      'YTecnologia',
                            ',/YTC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/ZCO/',      'zetVisions AG',
                            ',/ZCO/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1ACC/',     'e-Accounting: Generated Objects',
                            ',/1ACC/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1APO/',     'BW: Test Generation',
                            ',/1APO/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1B0/A%1',   'BPC: ADSO Inbound Tables',
                            ',/1B0/%1,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1B0/A%2',   'BPC: ADSO Active Data Tables',
                            ',/1B0/%2,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1B0/A%3',   'BPC: ADSO Change Log Tables',
                            ',/1B0/%3,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1BA/',      'Bank Analyzer: Result Data Layer (RDL)',
                            ',/1BA/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1BEA/',     'CRM: Billing',
                            ',/1BEA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1CN/',      'Generation Namespace',
                            ',/1CN/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1CPMB/',    'BPC: Dynamic Tables',
                            ',/1CPMB/%,'                                                                                                                                                      FROM DUMMY UNION ALL
        SELECT 100, '/1CRR/',     'SAP Upgrade Manager (SUM)',
                            ',/1CRR/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1DF/',      'Document Flow',
                            ',/1DF/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1FC/',      'FI-CA Generated Objects',
                            ',/1FC/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1FE/',      'FI-CA EDR Management: Generated Objects',
                            ',/1FE/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1FS/',      'BYD: Fast Search',
                            ',/1FS/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1OM/',      'Order Data Management (Current Data)',
                            ',/1OM/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1OT/',      'Order Data Management (Historic Data)',
                            ',/1OT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT 100, '/1RA/',      'Revenue Accounting',
                            ',/1RA/%,FARR#_%,'                                                                                                                                                FROM DUMMY UNION ALL
        SELECT 100, '/1SAP1/IDP', 'SOAP Idempotents',
                            ',/1SAP1/IDP%,'                                                                                                                                                   FROM DUMMY UNION ALL
        SELECT 100, '/1SCA/',     'Inventory Collaboration Hub',
                            ',/1SCA/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1SEM/',     'Strategic Enterprise Management',
                            ',/1SEM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1SGS/',     'Bank Analyzer: Segmentation Service',
                            ',/1SGS/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1UKM/',     'Unified Key Mapping',
                            ',/1UKM/%,'                                                                                                                                                       FROM DUMMY UNION ALL
        SELECT 100, '/1XT/',      'Extensibility',
                            ',/1XT/%,'                                                                                                                                                        FROM DUMMY UNION ALL
        SELECT  90, '~',          'ABAP Shadow Instance',
                             ',%~,'                                                                                                                                                           FROM DUMMY
      )
    ) B
  )
  WHERE
    SCHEMA_TABLE_NAME != ''
)
SELECT
  SPACE_LAYER LAYER,
  CLASS,
  DESCRIPTION,
  LPAD(TO_DECIMAL(SIZE_GB, 10, 2), 8) SIZE_GB,
  LPAD(TO_DECIMAL(MAP(TOTAL_GB, 0, 0, SIZE_GB / TOTAL_GB * 100), 10, 2), 8) SIZE_PCT,
  IFNULL(TABLE_1 || CHAR(32) || '(' || TO_DECIMAL(BYTE_1 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_1,
  IFNULL(TABLE_2 || CHAR(32) || '(' || TO_DECIMAL(BYTE_2 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_2,
  IFNULL(TABLE_3 || CHAR(32) || '(' || TO_DECIMAL(BYTE_3 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_3,
  IFNULL(TABLE_4 || CHAR(32) || '(' || TO_DECIMAL(BYTE_4 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_4,
  IFNULL(TABLE_5 || CHAR(32) || '(' || TO_DECIMAL(BYTE_5 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_5,
  IFNULL(TABLE_6 || CHAR(32) || '(' || TO_DECIMAL(BYTE_6 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_6,
  IFNULL(TABLE_7 || CHAR(32) || '(' || TO_DECIMAL(BYTE_7 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_7,
  IFNULL(TABLE_8 || CHAR(32) || '(' || TO_DECIMAL(BYTE_8 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_8,
  IFNULL(TABLE_9 || CHAR(32) || '(' || TO_DECIMAL(BYTE_9 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_9,
  IFNULL(TABLE_10 || CHAR(32) || '(' || TO_DECIMAL(BYTE_10 / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', '') TABLE_10
FROM
( SELECT
    SPACE_LAYER,
    CLASS,
    DESCRIPTION,
    SUM(SIZE_GB) SIZE_GB,
    TOTAL_GB,
    SUBSTR(MAX(TABLE_1), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_1)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_1,
    MAX(BYTE_1) BYTE_1,
    SUBSTR(MAX(TABLE_2), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_2)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_2,
    MAX(BYTE_2) BYTE_2,
    SUBSTR(MAX(TABLE_3), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_3)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_3,
    MAX(BYTE_3) BYTE_3,
    SUBSTR(MAX(TABLE_4), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_4)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_4,
    MAX(BYTE_4) BYTE_4,
    SUBSTR(MAX(TABLE_5), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_5)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_5,
    MAX(BYTE_5) BYTE_5,
    SUBSTR(MAX(TABLE_6), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_6)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_6,
    MAX(BYTE_6) BYTE_6,
    SUBSTR(MAX(TABLE_7), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_7)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_7,
    MAX(BYTE_7) BYTE_7,
    SUBSTR(MAX(TABLE_8), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_8)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_8,
    MAX(BYTE_8) BYTE_8,
    SUBSTR(MAX(TABLE_9), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_9)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_9,
    MAX(BYTE_9) BYTE_9,
    SUBSTR(MAX(TABLE_10), 1, MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH)) || 
      CASE WHEN LENGTH(MAX(TABLE_10)) > MAP(MAX_TABLE_NAME_LENGTH, -1, 999, MAX_TABLE_NAME_LENGTH) THEN '...' ELSE '' END TABLE_10,
    MAX(BYTE_10) BYTE_10,
    MIN_SIZE_MB
  FROM
  ( SELECT
      SPACE_LAYER,
      CLASS,
      DESCRIPTION,
      BYTES / 1024 / 1024 / 1024 SIZE_GB,
      SUM(BYTES) OVER () / 1024 / 1024 / 1024 TOTAL_GB,
      NTH_VALUE(TABLE_NAME, 1) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_1,
      NTH_VALUE(BYTES, 1) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_1,
      NTH_VALUE(TABLE_NAME, 2) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_2,
      NTH_VALUE(BYTES, 2) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_2,
      NTH_VALUE(TABLE_NAME, 3) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_3,
      NTH_VALUE(BYTES, 3) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_3,
      NTH_VALUE(TABLE_NAME, 4) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_4,
      NTH_VALUE(BYTES, 4) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_4,
      NTH_VALUE(TABLE_NAME, 5) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_5,
      NTH_VALUE(BYTES, 5) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_5,
      NTH_VALUE(TABLE_NAME, 6) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_6,
      NTH_VALUE(BYTES, 6) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_6,
      NTH_VALUE(TABLE_NAME, 7) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_7,
      NTH_VALUE(BYTES, 7) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_7,
      NTH_VALUE(TABLE_NAME, 8) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_8,
      NTH_VALUE(BYTES, 8) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_8,
      NTH_VALUE(TABLE_NAME, 9) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_9,
      NTH_VALUE(BYTES, 9) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_9,
      NTH_VALUE(TABLE_NAME, 10) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) TABLE_10,
      NTH_VALUE(BYTES, 10) OVER (PARTITION BY SPACE_LAYER, CLASS, DESCRIPTION, MIN_SIZE_MB ORDER BY BYTES DESC) BYTE_10,
      MAX_TABLE_NAME_LENGTH,
      MIN_SIZE_MB
    FROM
    ( SELECT
        SPACE_LAYER,
        TABLE_NAME,
        IFNULL(CLASS, 'OTHER') CLASS,
        CASE
          WHEN DESCRIPTION IS NULL AND ( SCHEMA_NAME NOT LIKE 'SAP%' AND SCHEMA_NAME != 'HANADB' ) THEN 'Unclassified schema (' || SCHEMA_NAME || ')'
          WHEN DESCRIPTION IS NULL AND TABLE_NAME LIKE '/%/%'      THEN 'Unclassified namespace (' || SUBSTR(TABLE_NAME, 1, LOCATE(TABLE_NAME, '/', 1, 2)) || ')'
          WHEN DESCRIPTION IS NULL AND TABLE_NAME NOT LIKE '/%/%'  THEN 'Unclassified table (' || SCHEMA_NAME || '.' || TABLE_NAME || ')'
          ELSE DESCRIPTION
        END DESCRIPTION,
        BYTES,
        MAX_TABLE_NAME_LENGTH,
        MIN_SIZE_MB
      FROM
      ( SELECT
          ROW_NUMBER() OVER (PARTITION BY T.SCHEMA_NAME, T.TABLE_NAME ORDER BY TC.PRIORITY) ROWNO,
          T.SPACE_LAYER,
          T.SCHEMA_NAME,
          T.TABLE_NAME,
          TC.CLASS,
          TC.DESCRIPTION,
          T.SIZE_BYTE BYTES,
          T.MAX_TABLE_NAME_LENGTH,
          T.MIN_SIZE_MB
        FROM
        ( SELECT
            T.SCHEMA_NAME,
            T.TABLE_NAME,
            T.SIZE_BYTE,
            BI.SPACE_LAYER,
            BI.MAX_TABLE_NAME_LENGTH,
            BI.MIN_SIZE_MB
          FROM
          ( SELECT                           /* Modification section */
              '%' SCHEMA_NAME,
              25 MAX_TABLE_NAME_LENGTH,
              'DISK' SPACE_LAYER,        /* CURMEM, MAXMEM, DISK */
              1024 MIN_SIZE_MB
            FROM
              DUMMY
          ) BI,
          ( SELECT
              'ALL' SPACE_LAYER,
              SCHEMA_NAME,
              TABLE_NAME,
              SUM(TABLE_SIZE) SIZE_BYTE
            FROM
            ( SELECT
                SCHEMA_NAME,
                TABLE_NAME,
                ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE TABLE_SIZE
              FROM
                M_RS_TABLES
              UNION ALL
              ( SELECT
                  SCHEMA_NAME,
                  TABLE_NAME,
                  INDEX_SIZE TABLE_SIZE
                FROM
                  M_RS_INDEXES
              )
            )  
            GROUP BY
              SCHEMA_NAME,
              TABLE_NAME
            HAVING 
              SUM(TABLE_SIZE) >= 1024 * 1024 * 5
            UNION ALL
            ( SELECT
                K.SPACE_LAYER,
                T.SCHEMA_NAME,
                T.TABLE_NAME,
                MAP(K.SPACE_LAYER, 'CURMEM', SUM(T.MEMORY_SIZE_IN_TOTAL), SUM(T.ESTIMATED_MAX_MEMORY_SIZE_IN_TOTAL)) SIZE_BYTE
              FROM
              ( SELECT 'CURMEM' SPACE_LAYER FROM DUMMY UNION ALL
                SELECT 'MAXMEM'            FROM DUMMY ) K,
                M_CS_TABLES T	
              GROUP BY
                K.SPACE_LAYER,
                T.SCHEMA_NAME,
                T.TABLE_NAME
              HAVING
                SUM(T.MEMORY_SIZE_IN_TOTAL) >= 1024 * 1024 * 5
            )
            UNION ALL
           ( SELECT
                'DISK',
                 SCHEMA_NAME,
                 TABLE_NAME,
                 SUM(DISK_SIZE) SIZE_BYTE
              FROM
                M_TABLE_PERSISTENCE_STATISTICS
              GROUP BY
                SCHEMA_NAME,
                TABLE_NAME
              HAVING
                SUM(DISK_SIZE) >= 1024 * 1024 * 5
            )   
          ) T
          WHERE
            T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
            T.SPACE_LAYER = BI.SPACE_LAYER
        ) T LEFT OUTER JOIN
        TABLE_CLASS_MAPPING TC ON
          T.SCHEMA_NAME LIKE TC.SCHEMA_NAME ESCAPE '#' AND
          ( TC.TABLE_NAME LIKE '{LR}%' AND T.TABLE_NAME LIKE_REGEXPR SUBSTR(TC.TABLE_NAME, 5) OR
            TC.TABLE_NAME LIKE '{SC}%' AND T.SCHEMA_NAME LIKE SUBSTR(TC.TABLE_NAME, 5) OR
            TC.TABLE_NAME NOT LIKE '{__}%' AND T.TABLE_NAME LIKE TC.TABLE_NAME ESCAPE '#'
          )
      )
      WHERE
        ROWNO = 1 
    )
  )
  GROUP BY
    SPACE_LAYER,
    CLASS,
    DESCRIPTION,
    TOTAL_GB,
    MAX_TABLE_NAME_LENGTH,
    MIN_SIZE_MB
)
WHERE
  SIZE_GB >= MIN_SIZE_MB / 1024
ORDER BY
  SIZE_GB DESC
WITH HINT (IGNORE_PLAN_CACHE)

