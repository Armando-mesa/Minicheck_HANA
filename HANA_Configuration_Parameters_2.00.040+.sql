WITH

/* 

[NAME]

- HANA_Configuration_Parameters_2.00.040+

[DESCRIPTION]

- SAP HANA parameter check

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Not valid for SAP HANA Express
- For SAP HANA Cloud environments no recommendations are provided, but parameters are reported that are set although there is no general recommendation
- Detailed check criteria are described in SAP Note 2600030
- WITH clause does not work with older DBACOCKPIT transactions before SAP BASIS 7.02 SP16 / 7.30 SP12 / 7.31 SP12 / SAP_BASIS 7.40 SP07 (empty result returned) 
- M_CONFIGURATION_PARAMETER_VALUES available with SAP HANA >= 2.00.040

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2014/03/31:  1.0 (initial version)
- 2014/05/13:  1.1 (EXCLUDE_ADMINISTRATIVE_MODIFICATIONS included)
- 2014/09/04:  1.2 (included possibility to check against two disjunct recommended value ranges)
- 2015/06/29:  2.0 (complete redesign)
- 2015/09/14:  2.1 (MDCSYS included)
- 2015/10/12:  2.2 (SDA and IQ included)
- 2016/02/16:  2.3 (PROD included)
- 2016/02/18:  2.4 (ABAP included)
- 2016/03/10:  2.5 (MDCTEN included)
- 2016/05/02:  2.6 (CPU_THREADS and ALLOC_LIM_MB included)
- 2016/08/13:  2.7 (IMPLEMENTATION_COMMAND and UNDO_COMMAND included)
- 2016/12/02:  2.8 (NUM_WORKERS included)
- 2018/05/10:  2.9 (priority P included)
- 2018/06/23:  3.0 (reporting of invalid number values like '10.00', '40 to 80' or '4G')
- 2018/10/01:  3.1 (audit policies - AUD added)
- 2018/10/17:  3.2 (LOG_VOL_GB added)
- 2018/11/28:  3.3 (dedicated 1.00.90+ version including LIKE_REGEXPR)
- 2021/01/20:  3.4 (dedicated 2.00.040+ version based on M_CONFIGURATION_PARAMETER_VALUES instead of M_INIFILE_CONTENTS)
- 2021/01/24:  3.5 (EXCLUDE_XSA added, suggested values in case of ranges added)
- 2022/03/03:  3.6 (MDS included)
- 2024/03/27:  3.7 (PMEM_GB included)

[INVOLVED TABLES]

- M_CONFIGURATION_PARAMETER_VALUES

[INPUT PARAMETERS]

- FILE_NAME

  File name

  'alert.trc'     --> File with name alert.trc
  '%oom%'         --> File with name containing 'oom'
  '%'             --> All files

- SECTION

  Parameter file section

  'joins'         --> Specific parameter file section 'joins'
  'stat%'         --> All parameter file sections starting with 'stat'
  '%'             --> All parameter file sections

- PARAMETER_NAME

  Parameter name

  'enable'        --> Parameters with name 'enable'
  'unload%'       --> Parameters starting with 'unload'
  '%'             --> All parameters

- REVISION

  Revision level to be checked against

  80              --> Check parameters against Revision 80 recommendations
  37.01           --> Check parameters against Revision 37.01 recommendations
  -1              --> Check parameters against currently implemented revision

- VERSION

  Version level to be checked against

  2               --> Check parameters against SAP HANA version 2
  -1              --> Check parameters against currently implemented version

- CPU_THREADS

  Number of CPU threads to be taken into account for some parameter recommendations

  120             --> Consider 120 CPU threads for related parameter recommendations
  -1              --> Check parameters against CPU threads in current system

- NUMA_NODES

  Number of NUMA nodes (typically sockets) to be taken into account for some parameter recommendations

  16              --> Consider 16 NUMA nodes
  -1              --> Check parameters against NUMA nodes in current system

- LOG_VOL_GB

  Size of LOG volume (GB)

  2048            --> Use LOG volume size of 2048 GB
  -1              --> Use actual total volume size of LOG volume in system

- PMEM_GB

  Size of used persistent memory (GB), only real persistent memory, not fast restart option

  3000            --> Used persistent memory of 3000 GB
  -1              --> Use actual persistent memory usage

- ALLOC_LIM_GB

  Service allocation limit (GB) to be taken into account for some parameter recommendations

  512             --> Consider service allocation limit of 512 GB for related parameter recommendations
  -1              --> Check parameters against service allocation limit in current system

- ENVIRONMENT

  Comma-separated list of environmental information:
  - ABAP:     ABAP stack
  - AUD:      Existence of audit policies
  - BPC:      Business objects planning and consolidation (standard, not embedded)
  - BW:       Business warehouse
  - CRM:      Customer relationship management
  - ERP:      Enterprise resource planning (incl. SoH, S/4HANA)
  - ESS:      Embedded statistics server
  - EWM:      Extended warehouse management
  - FRA:      Fraud management
  - IQ:       Smart data access (Sybase IQ remote source)
  - LCACHE:   Integrated liveCache
  - MDCSYS:   Multitenant (system DB)
  - MDCTEN:   Multitenant (tenant DB)
  - MDS:      Multi-dimensional services (MDS)
  - MULTI:    Scale-out / multi node
  - STDBY:    Single node with standby node
  - PORTAL:   Enterprise Portal
  - PROD:     Production system
  - S4:       S/4HANA
  - SCM:      Supply chain management
  - SDA:      Smart data access
  - SF:       SuccessFactors
  - SINGLE:   Single node
  - SRM:      Supplier relationship management
  - SSS:      Standalone statistics server
  - SYSREP:   System replication
  - XFS:      XFS file system

  'ERP'          --> Provide recommendations for ERP environments
  'BW,MULTI'     --> Provide recommendations for BW scale-out environments
  'AUTO'         --> Automatic determination of system environment

- EXCLUDE_DEFAULT_MODIFICATIONS

  Controls the exclusion of parameters that are usually modified by the system per default

  'X'             --> Exclude parameters that are often modified by the system per default
  ' '             --> No restriction

- EXCLUDE_ADMINISTRATIVE_MODIFICATIONS

  Controls the exclusion of parameters that are usually modified for administrative reasons 
  (e.g. backup parameter file, table placement details)

  'X'             --> Exclude parameters that are often modified for administrative reasons
  ' '             --> No restriction

- EXCLUDE_SECURITY_MODIFICATIONS

  Controls the exclusion of parameters that are usually modified for security reasons 
  (e.g. password policites)

  'X'             --> Exclude parameters related to security
  ' '             --> No restriction

- EXCLUDE_WEBDISPATCHER

  Possibility to exclude webdispatcher related recommendations

  'X'             --> Exclude webdispatcher related recommendations (webdispatcher.ini)
  ' '             --> No exclusion of webdispatcher related recommendations

- EXCLUDE_XSA

  Possibility to exclude XSA related recommendations

  'X'             --> Exclude XSA related recommendations (xscontroller.ini, xsexecagent.ini, xsuaaserver.ini)
  ' '             --> No exclusion of XSA related recommendations

- MAX_VALUE_LENGTH

  Maximum length of parameter values

  40              --> Truncate parameter values after 40 characters
  -1              --> No truncation

[OUTPUT PARAMETERS]

- FILE_NAME:              Parameter file name
- SECTION:                Parameter file section
- PARAMETER_NAME:         Parameter name
- P:                      Priority (1 -> Very high, 2 -> High, 3 -> Medium, 4 -> Low), only shown for explicit value recommendations
- CONFIGURED_VALUE:       Parameter value explicitly configured
- RECOMMENDED_VALUE:      Parameter value recommendation, in case of a range also a suggested value is specified (e.g. "16 to 64 [40]" means that the
                          parameter should be set between 16 and 64 and as a starting point 40 is suggested)
- SAP_NOTE:               SAP Note with further details for parameter
- CONFIG_LAYER:           Layer of explicitly configured parameter
- IMPLEMENTATION_COMMAND: Command to implement the recommended parameter changes (needs to be adjusted in case of ranges, individual requirements or TENANT related settings)
- UNDO_COMMAND:           Command to undo the recommended parameter changes (needs to be adjusted in case of individual requirements or TENANT related settings)

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|FILE_NAME       |SECTION               |PARAMETER_NAME                  |DEFAULT_VALUE                           |CONFIGURED_VALUE                        |RECOMMENDED_VALUE      |SAP_NOTE|CONFIGURED_HOST|
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|EVALUATION TIME:|2015/06/28 16:31:29   |                                |                                        |                                        |                       |        |               |
|REVISION:       |96                    |                                |                                        |                                        |                       |        |               |
|ENVIRONMENT:    |BW,ESS,MULTI          |                                |                                        |                                        |                       |        |               |
|                |                      |                                |                                        |                                        |                       |        |               |
|global.ini      |auditing configuration|global_auditing_state           |-- HANA internal --                     |-- not set --                           |true                   |  863362|-- not set --  |
|global.ini      |cryptography          |ssfs_key_file_path              |                                        |-- not set --                           |-- individual value -- | 2183624|-- not set --  |
|global.ini      |memorymanager         |statement_memory_limit          |                                        |300                                     |-- individual value -- | 1999997|               |
|indexserver.ini |sqlscript             |enable_select_into_scalar_udf   |-- HANA internal --                     |TRUE                                    |true                   | 2160814|               |
|indexserver.ini |transaction           |transaction_history_record_limit|1000000                                 |-- not set --                           |-- individual value -- | 1910610|-- not set --  |
|indexserver.ini |transaction           |transaction_history_size_limit  |10240                                   |-- not set --                           |-- individual value -- | 1910610|-- not set --  |
|xsengine.ini    |persistence           |log_segment_size_mb             |8                                       |-- not set --                           |64 to 1024             | 2062080|-- not set --  |
|global.ini      |table_placement       |bw_schema                       |-- HANA internal --                     |SAPSR3,SAPSR3SHD                        |-- no recommendation --| 2178461|               |
|global.ini      |table_placement       |prefix                          |-- HANA internal --                     |/                                       |-- no recommendation --| 2178461|               |
|indexserver.ini |mergedog              |auto_merge_decision_func        |(((DMS>PAL/2000 or DCC>100) and DRC > MR|(((DRC*TMD>3600*(MRC+0.0001) or DMS>PAL/|-- no recommendation --| 2057046|               |
|indexserver.ini |row_engine            |consistency_check_at_startup    |-- HANA internal --                     |page, index                             |-- no recommendation --|        |saphanahost    |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

TEMP_CS_TABLES AS
( SELECT
    *
  FROM
    M_CS_TABLES
),
TEMP_TABLES AS
( SELECT
    *
  FROM
    TABLES
),
BASIS_INFO AS
( SELECT
    BI.FILE_NAME,
    BI.SECTION,
    BI.PARAMETER_NAME,
    BI.REVISION BI_REVISION,
    BI.VERSION BI_VERSION,
    BI.CPU_THREADS BI_CPU_THREADS,
    BI.CPU_FREQUENCY_MHZ BI_CPU_FREQUENCY_MHZ,
    BI.NUMA_NODES BI_NUMA_NODES,
    BI.ALLOC_LIM_GB BI_ALLOC_LIM_GB,
    BI.NUM_WORKERS BI_NUM_WORKERS,
    BI.LOG_VOL_GB BI_LOG_VOL_GB,
    BI.PMEM_GB BI_PMEM_GB,
    MAP(BI.CPU_THREADS, -1, C.CPU_THREADS, BI.CPU_THREADS) CPU_THREADS,
    MAP(BI.CPU_FREQUENCY_MHZ, -1, C.CPU_FREQUENCY_MHZ, BI.CPU_FREQUENCY_MHZ) CPU_FREQUENCY_MHZ,
    MAP(BI.NUMA_NODES, -1, N.NUMA_NODES, BI.NUMA_NODES) NUMA_NODES,
    MAP(BI.ALLOC_LIM_GB, -1, M.ALLOC_LIM_GB, BI.ALLOC_LIM_GB) ALLOC_LIM_GB,
    MAP(BI.NUM_WORKERS, -1, S.NUM_WORKERS, BI.NUM_WORKERS) NUM_WORKERS,
    MAP(BI.LOG_VOL_GB, -1, L.LOG_VOL_GB, BI.LOG_VOL_GB) LOG_VOL_GB,
    MAP(BI.PMEM_GB, -1, PM.PMEM_GB, BI.PMEM_GB) PMEM_GB,
    MAP(BI.REVISION, -1, P.REVISION, BI.REVISION) CHECK_REVISION,
    MAP(BI.VERSION, -1, P.VERSION, BI.VERSION) CHECK_VERSION,
    MAX_VALUE_LENGTH,
    MAP(BI.ENVIRONMENT, 'AUTO', F.ENVIRONMENT, BI.ENVIRONMENT) ENV,
    EXCLUDE_DEFAULT_MODIFICATIONS,
    EXCLUDE_ADMINISTRATIVE_MODIFICATIONS,
    EXCLUDE_SECURITY_MODIFICATIONS,
    EXCLUDE_WEBDISPATCHER,
    EXCLUDE_XSA
  FROM
  ( SELECT                     /* Modification section */
      '%' FILE_NAME,
      '%' SECTION,
      '%' PARAMETER_NAME,
      -1 REVISION,             /* revision level to be checked, -1 for current revision */
      -1 VERSION,              /* main version level to be checked, -1 for current version */
      -1 CPU_THREADS,          /* number of CPU threads per SAP HANA node, -1 for CPU threads in existing system */
      -1 CPU_FREQUENCY_MHZ,    /* CPU frequency in MHz */
      -1 NUMA_NODES,           /* number of NUMA nodes (typically sockets) per SAP HANA node, -1 for NUMA nodes in existing system */
      -1 ALLOC_LIM_GB,         /* service allocation limit per SAP HANA node (GB), -1 for service allocation limit in existing system */
      -1 NUM_WORKERS,          /* number of worker nodes, -1 for number of worker nodes in existing system */
      -1 LOG_VOL_GB,          /* Total disk size of LOG volume (GB) */
      -1 PMEM_GB,             /* Used size of (real) persistent memory (GB) */
      'AUTO' ENVIRONMENT,      /* AUTO for automatic determination based on current environment,
                                  ABAP, AUD, BPC, BW, CRM, ERP, ESS, EWM, FRA, IQ, LCACHE, MDCSYS, MDCTEN, MDS, MULTI, PORTAL, PROD, S4, SCM, SDA, SF, SINGLE, SRM, SSS, SYSREP, XFS and comma separated combinations */
      'X' EXCLUDE_DEFAULT_MODIFICATIONS,                   /* Exclusion of parameters that are usually modified by the system per default */
      'X' EXCLUDE_ADMINISTRATIVE_MODIFICATIONS,            /* Exclusion of parameters that are modified for administrative reasons, e.g. backup parameter file location */
      'X' EXCLUDE_SECURITY_MODIFICATIONS,                  /* Exclusion of parameters related to security, e.g. password policies */
      'X' EXCLUDE_WEBDISPATCHER,
      'X' EXCLUDE_XSA,
      -1  MAX_VALUE_LENGTH
    FROM
      DUMMY
  ) BI,
  ( SELECT
      RTRIM(MAP(ABAP, 'Yes', 'ABAP,', '') || MAP(BPC, 'Yes', 'BPC,', '') || MAP(BW, 'Yes', 'BW,', '') || MAP(CRM, 'Yes', 'CRM,', '') || MAP(ERP, 'Yes', 'ERP,', '') || 
        MAP(ESS, 'Yes', 'ESS,', '') || MAP(EWM, 'Yes', 'EWM,', '') || MAP(S4, 'Yes', 'S/4,', '') || MAP(FRA, 'Yes', 'FRA,', '') || 
        MAP(IQ, 'Yes', 'IQ,', '') || MAP(LCACHE, 'Yes', 'LCACHE,', '') || MAP(MDCSYS, 'Yes', 'MDCSYS,', '') || MAP(MDCTEN, 'Yes', 'MDCTEN,', '') || MAP(MDS, 'Yes', 'MDS,', '') || 
        MAP(MULTI, 'Yes', 'MULTI,', '') || MAP(PORTAL, 'Yes', 'PORTAL,', '') || MAP(PROD, 'Yes', 'PROD,', '') || MAP(SCM, 'Yes', 'SCM,', '') || 
        MAP(SDA, 'Yes', 'SDA,', '') || MAP(SF, 'Yes', 'SF,', '') ||
        MAP(SINGLE, 'Yes', 'SINGLE,', '') || MAP(SRM, 'Yes', 'SRM,', '') || MAP(SSS, 'Yes', 'SSS,', '') || MAP(STDBY, 'Yes', 'STDBY,', '') ||
        MAP(SYSREP, 'Yes', 'SYSREP,', '') || MAP(AUD, 'Yes', 'AUD,', '') ||
        MAP(XFS, 'Yes', 'XFS,', ''), ',') ENVIRONMENT
    FROM
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') ABAP
      FROM
        TEMP_TABLES
      WHERE
        TABLE_NAME = 'T000'
    ),
    ( SELECT 
        MAP(COUNT(*), 0, 'No', 'Yes') BPC
      FROM
        M_TABLES
      WHERE
        TABLE_NAME = 'UJA_APPL' AND
        RECORD_COUNT > 0
    ),
    ( SELECT
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 100 THEN 'No' ELSE 'Yes' END BW
      FROM
        TEMP_CS_TABLES
      WHERE
        TABLE_NAME IN ( '/BI0/SREQUID', 'RSPMREQUEST' )
    ),
    ( SELECT
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 10000 THEN 'No' ELSE 'Yes' END CRM
      FROM
        TEMP_CS_TABLES
      WHERE
        TABLE_NAME = 'CRMD_ORDERADM_H'
    ),
    ( SELECT
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 10000 THEN 'No' ELSE 'Yes' END ERP
      FROM
        TEMP_CS_TABLES
      WHERE
        TABLE_NAME IN ('MARA', 'BSEG', 'ACDOCA', 'PPOIX')
    ),
    ( SELECT
        MAP(MAX(VALUE), 'TRUE', 'Yes', NULL, 'Yes', 'No') ESS
      FROM
        DUMMY LEFT OUTER JOIN
        M_CONFIGURATION_PARAMETER_VALUES ON
          FILE_NAME IN ('indexserver.ini', 'nameserver.ini' ) AND
          SECTION = 'statisticsserver' AND
          KEY = 'active'
    ),
    ( SELECT 
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 10 THEN 'No' ELSE 'Yes' END EWM
      FROM
        TEMP_CS_TABLES 
      WHERE
        TABLE_NAME = '/SCWM/ORDIM_C'
    ),
    ( SELECT 
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 10 THEN 'No' ELSE 'Yes' END S4
      FROM
        TEMP_CS_TABLES 
      WHERE
        TABLE_NAME = 'MATDOC'
    ),
    ( SELECT 
        MAP(COUNT(*), 0, 'No', 'Yes') FRA
      FROM
        TEMP_TABLES 
      WHERE
       TABLE_NAME IN ( 'FRA_D_ALERT_ROOT', 'FRA_D_STRAT_ROOT' )
    ),
    ( SELECT
        CASE WHEN COUNT(*) > 0 THEN 'Yes' ELSE 'No' END IQ
      FROM
        REMOTE_SOURCES
      WHERE
        ADAPTER_NAME = 'iqodbc'
    ),
    ( SELECT
        CASE WHEN COUNT(*) > 0 THEN 'Yes' ELSE 'No' END LCACHE
      FROM
        M_LIVECACHE_CONTAINER_STATISTICS
    ),
    ( SELECT
        CASE WHEN P.DB_TYPE = 'multidb' AND D.DATABASE_NAME != 'SYSTEMDB' THEN 'Yes' ELSE 'No' END MDCTEN
      FROM
      ( SELECT
          MAX(VALUE) DB_TYPE
        FROM
          M_CONFIGURATION_PARAMETER_VALUES
          WHERE
        FILE_NAME = 'global.ini' AND
        SECTION = 'multidb' AND
        KEY = 'mode'
      ) P,
        M_DATABASE D
    ),
    ( SELECT
        CASE WHEN P.DB_TYPE = 'multidb' AND D.DATABASE_NAME = 'SYSTEMDB' THEN 'Yes' ELSE 'No' END MDCSYS
      FROM
      ( SELECT
          MAX(VALUE) DB_TYPE
        FROM
          M_CONFIGURATION_PARAMETER_VALUES
          WHERE
        FILE_NAME = 'global.ini' AND
        SECTION = 'multidb' AND
        KEY = 'mode'
      ) P,
        M_DATABASE D
    ),
    ( SELECT
        MAP(COUNT(*), 1, 'No', 'Yes') MULTI
      FROM
        M_LANDSCAPE_HOST_CONFIGURATION
      WHERE
        HOST_ACTUAL_ROLES != 'STANDBY'
    ),
    ( SELECT
        CASE WHEN TOTAL = 2 AND STANDBY = 1 THEN 'Yes' ELSE 'No' END STDBY
      FROM
      ( SELECT
          COUNT(*) TOTAL,
          SUM(MAP(HOST_ACTUAL_ROLES, 'STANDBY', 1, 0)) STANDBY
        FROM
          M_LANDSCAPE_HOST_CONFIGURATION
      )
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') PORTAL
      FROM
        TEMP_TABLES
      WHERE
        TABLE_NAME IN ( 'EP_ATTR_VALUES3', 'KMC_DBRM_CONTENT' )
    ),
    ( SELECT
        MAP(UPPER(USAGE), 'PRODUCTION', 'Yes', 'No') PROD
      FROM
        M_DATABASE
    ),
    ( SELECT 
        MAP(COUNT(*), 0, 'No', 'Yes') SCM
      FROM
        TEMP_TABLES 
      WHERE
        TABLE_NAME = '/SAPAPO/APO01'
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') SDA
      FROM
        REMOTE_SOURCES
    ),
    ( SELECT
        MAP(RTRIM(SUBSTR(VALUE, 1, 3)), 'No', 'Yes', 'No') SINGLE
      FROM
        M_SYSTEM_OVERVIEW
      WHERE
        SECTION = 'System' AND
        NAME = 'Distributed'
    ),
    ( SELECT
        CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 1000 THEN 'No' ELSE 'Yes' END SRM
      FROM
        TEMP_CS_TABLES
      WHERE
        TABLE_NAME IN ('BBP_PDORG', 'BBP_PDIGP')
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') SSS
      FROM
        M_SERVICES
      WHERE
        SERVICE_NAME = 'statisticsserver'
    ),
    ( SELECT
        CASE SUM(MAP(FILESYSTEM_TYPE, 'xfs', 1, 0)) WHEN 0 THEN 'No' ELSE 'Yes' END XFS 
      FROM 
        M_DISKS 
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') SYSREP
      FROM
        M_SERVICE_REPLICATION
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') AUD
      FROM
        AUDIT_POLICIES
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') SF
      FROM
        TABLES
      WHERE 
        TABLE_NAME IN ('PH_QUAL_CPNT', 'PA_MAIL_ATTMT_ARCHIVE', 'ATTACH_CONTENT', 'COMP_PLAN')
    ),
    ( SELECT
        MAP(COUNT(*), 0, 'No', 'Yes') MDS
      FROM
        M_MULTIDIMENSIONAL_STATEMENT_STATISTICS
    )
  ) F,
  ( SELECT
      VERSION,
      REVISION
    FROM
    ( SELECT
        TO_NUMBER(SUBSTR(VALUE, 1, 1)) VERSION,
        TO_DECIMAL(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) ||
        MAP(LOCATE(VALUE, '.', 1, 4), 0, '', '.' || SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 3) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) - 1 )), 10, 2) REVISION 
      FROM 
        M_SYSTEM_OVERVIEW 
      WHERE 
        SECTION = 'System' AND 
        NAME = 'Version' 
    )
  ) P,
  ( SELECT
      MAX(MAP(KEY, 'cpu_cores', VALUE, 0)) CPU_CORES,
      MAX(MAP(KEY, 'cpu_threads', VALUE, 0)) CPU_THREADS,
      MAX(MAP(KEY, 'cpu_clock', VALUE, 0)) CPU_FREQUENCY_MHZ
    FROM
      M_HOST_INFORMATION
    WHERE
      VALUE != ''
  ) C,
  ( SELECT
      MAX(NUMA_NODES) NUMA_NODES
    FROM
    ( SELECT
        COUNT(DISTINCT(STATISTICS_NAME)) NUMA_NODES
      FROM
        M_SEMAPHORES
      WHERE
        STATISTICS_NAME LIKE 'jx-free%'
      GROUP BY
        HOST
    )
  ) N,
  ( SELECT
      TO_DECIMAL(ROUND(MIN(ALLOC_LIMIT) / 1024 / 1024 / 1024), 10, 0) ALLOC_LIM_GB
    FROM
    ( ( SELECT TOP 1
          ALLOCATION_LIMIT ALLOC_LIMIT
        FROM
          M_SERVICE_MEMORY
        ORDER BY
          MAP(SERVICE_NAME, 'indexserver', '3', 'nameserver', '2', '1') || LPAD(ALLOCATION_LIMIT, 20) DESC
      )
      UNION ALL
      SELECT
        ALLOCATION_LIMIT ALLOC_LIMIT
      FROM
        M_HOST_RESOURCE_UTILIZATION R,
        M_LANDSCAPE_HOST_CONFIGURATION L
      WHERE
        R.HOST = L.HOST AND
        L.HOST_STATUS IN ('OK','WARNING','INFO') AND 
        ( L.INDEXSERVER_ACTUAL_ROLE IN ('MASTER', 'SLAVE') OR
          L.NAMESERVER_ACTUAL_ROLE = 'MASTER'
        )
    )
  ) M,
  ( SELECT 
      COUNT(*) NUM_WORKERS
    FROM 
      M_LANDSCAPE_HOST_CONFIGURATION 
    WHERE 
      HOST_STATUS IN ('OK','WARNING','INFO') AND 
      INDEXSERVER_ACTUAL_ROLE='SLAVE'
  ) S,
  ( SELECT
      MIN(TOTAL_SIZE / 1024 / 1024 / 1024) LOG_VOL_GB
    FROM
      M_DISKS
    WHERE
      USAGE_TYPE = 'LOG'
  ) L,
  ( SELECT
      IFNULL(MAX(PMEM_GB), 0) PMEM_GB
    FROM
    ( SELECT TOP 1 * FROM M_PERSISTENT_MEMORY_VOLUMES WHERE FILESYSTEM_TYPE != 'tmpfs' ) PU,
    ( SELECT HOST, SUM(TOTAL_ACTIVE_SIZE) / 1024 / 1024 / 1024 PMEM_GB FROM M_PERSISTENT_MEMORY_VOLUME_STATISTICS GROUP BY HOST ) PM
  ) PM
),
PARAMETER_INFOS_HELPER AS
( SELECT
    P.ENV,
    P.FILE_NAME,
    P.P,
    P.SECTION,
    P.PARAMETER_NAME,
    P.NOT_1,
    P.MIN_VALUE_1 MIN_VALUE_1_ORIG,
    CASE
      WHEN P.PARAMETER_NAME = 'plan_cache_eager_eviction_mode' THEN MIN_VALUE_1
      WHEN UPPER(MIN_VALUE_1) IN ('TRUE', 'ON', 'YES') THEN 'true'
      WHEN UPPER(MIN_VALUE_1) IN ('FALSE', 'OFF', 'NO') THEN 'false'
      ELSE MIN_VALUE_1
    END MIN_VALUE_1,
    P.MAX_VALUE_1,
    P.MIN_VALUE_2,
    P.MAX_VALUE_2,
    P.MIN_REV,
    P.MAX_REV,
    P.MIN_VERS,
    P.MAX_VERS,
    P.SAP_NOTE,
    P.AREA,
    P.TYPE
  FROM
  ( SELECT 0 P, 'ALL' ENV,     ' ' FILE_NAME,          ' ' SECTION,                ' ' PARAMETER_NAME,                          ' ' NOT_1, ' ' MIN_VALUE_1,      ' ' MAX_VALUE_1,         ' ' MIN_VALUE_2,           ' ' MAX_VALUE_2,           -1 MIN_REV, -1 MAX_REV, -1 MIN_VERS, -1 MAX_VERS, '' SAP_NOTE, ' ' AREA, ' 'TYPE FROM DUMMY WHERE 1 = 0 UNION ALL
    SELECT 0, 'ALL',         '%',                    'authentication',           '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'communication',            'default_read_timeout',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      '%',                    '%',                        'listenport',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'jwt_identity_provider',    'issuer',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'load_trace',               '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'numa',                     'table_location_salt',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2470289', 'memory',         'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'password policy',          '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'password policy',          'password_lock_for_system_user',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2216869', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'password policy',          'detailed_error_on_connect',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2216869', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'persistence',              'log_segment_size_mb',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2083715', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'performance_analyzer',     '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'pythontrace',              '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'repository',               'enable_repository',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'row_engine',               'lock_table_array_size',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'row_engine',               'startup_consistency_check_timeout',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'row_engine',               'transient_containers',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'runtimedump',              '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'session',                  'enable_session_recovery',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'session',                  'max_number_of_sessions_per_partition',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'sqltrace',                 '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      '%',                    'system_replication',       'logshipping_async_buffer_size',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2086024', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      '%',                    'system_replication',       'logshipping_replay_logbuffer_cache_size',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2661878', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      '%',                    'system_replication', 'logshipping_replay_push_persistent_segment_count',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2661878', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'task_framework',           'task_data_retention_period',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'task_framework',           'task_data_retention_period_check_interval', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'topology',                 'shared',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'trace',                    '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'traceprofile%',            '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'unload_trace',             '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'attributes.ini',       'global',                   'inverted_index_compression',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2177064', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'attributes.ini',       'global',                   'inverted_index_verification_after_load',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'attributes.ini',       'global',                   'runtime_structure_persistence',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160391', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'attributes.ini',       'idattribute',              'check_duplicates_on_merge',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1919034', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           '%',                        'affinity',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100040', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           '%',                        'instances',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           '%',                        'instancids',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2200202', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           '%',                        'startup_error_restart_retries',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2733483', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           '%',                        'startup_error_shutdown_instance',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2733483', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'diserver.%',               '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'docstore.%',               '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'dpserver.%',               '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'scriptserver.%',           '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'xsengine.%',               '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 2, 'MDCSYS',      'daemon.ini',           'daemon',                   'environment',                               ' ', 'HDB_MEMORY_CACHE=d',       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 30,    49,  2,  2, '2857553', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'daemon',                   'forcedterminationtimeout',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2177064', 'shutdown',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'daemon',                   'terminationtimeout',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2177064', 'shutdown',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'esserver',                 'arguments',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2560038', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'daemon.ini',           'limits',                   'core',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2899522', 'OS',             ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCSYS',      'daemon.ini',           'nameserver',               'environment',     ' ', 'PYTHONDONTWRITEBYTECODE=1,HDB_SINGLE_THREAD_GROUP=1','-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    76,  2,  2, '3435077', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'diserver.ini',         'make',                     'allow_sys_prefix',                          ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 41,    41,  2,  2, '2810639', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'agentsslusage',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2675102', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'decluster_max_cluster_process_alloc',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2690572', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'maxagentpingfailures',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'communication',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'messagetimeout',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'communication',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'pingmessagetimeout',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'communication',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'prefetchmessagetimeout',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2985150', 'cancel issue',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'prefetchtimeout',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2363544', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'uselobbatching',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2575290', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'useparallelpings',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2363544', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'useprefetch',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2363544', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'usestreaming',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2643641', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'select_queue_size',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3311765', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'framework',                'active',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2240059', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'persistence',              'committedchange_callback_interval',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2749005', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'persistence',              'distributor_commit_interval_sec',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2710286', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'persistence',              'receiver_commit_interval_sec',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2710286', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'persistence',              'receiver_data_store_max_store_size',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3065904', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'persistence',              'receiver_max_pal_usage_percent',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3307153', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'remote_source_statistics', 'dp_ui_stats_proc_schema_name',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2952296', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'remote_source_statistics', 'dp_ui_stats_proc_name',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2952296', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'dpserver.ini',         'smart_data_integration',   'force_reset_remote_subscription',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2475366', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'database',                 'es_log_backup_interval',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2547514', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'database',                 'es_log_backup_timeout',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2184754', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'row_engine',               'enable_relocation_cache',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2777465', 'dyn. tiering',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'row_engine',               'enable_session_variables',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2742437', 'dyn. tiering',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'startup',                  'load_memory_mb',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2096805', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'startup',                  'max_concurrent_connections',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2560038', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'esserver.ini',         'startup',                  'max_concurrent_queries',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2560038', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'executor.ini',         'global',                   'use_statement_memory_tracking',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2207501', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'executor.ini',         'inactivity',               'local_time',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2584706', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'executor.ini',         'inactivity',               'remote_time',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2584706', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'abstract_sql_plan',        'capture_thread_count',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'abstract_sql_plan',        'evict_query',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'abstract_sql_plan',        'max_count',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'abstract_sql_plan',        'max_size',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing configuration',   'alert_audit_trail_type',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing configuration',   'critical_audit_trail_type',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing configuration',   'default_audit_trail_path',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 4, 'ALL',         'global.ini',           'auditing configuration',   'default_audit_trail_type',                  'X', 'CSVTEXTFILE',              '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing configuration',   'emergency_audit_trail_type',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 2, 'AUD',         'global.ini',           'auditing configuration',   'global_auditing_state',                     ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing configuration',   'minimal_retention_period',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing_csvtextfile',     'max_files',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2313619', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'auditing_csvtextfile',     'max_file_size',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2313619', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'authentication',           'session_cookie_validity_time',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'authorization','enable_insufficient_privilege_error_details_procedure', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'authorization', 'insufficient_privilege_error_details_retain_duration', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'authorization',  'insufficient_privilege_error_details_retain_records', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backint',                  '%_backup_parameter_file',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   '%_backup_parameter_file',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'backint_pipe_capacity',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3417100', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'backint_protocol_version',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'backint_response_timeout',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'catalog_backup_using_backint',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2707320', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'data_backup_buffer_size',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2458043', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'data_backup_compression_level',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3312135', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'data_backup_max_chunk_size',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'data_backup_savepoint_lock_timeout',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'enable_accumulated_catalog_backup',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'enable_parallel_backup_encryption',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'include_configuration_backup',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_backup_backint_fallback',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1642148', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_backup_buffer_size',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2618564', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_backup_compression_level',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3312135', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_backup_interval_mode',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_backup_using_backint',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'log_recovery_resume_point_interval',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_recovery_backint_channels',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2168842', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_recoveryfile_age',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975225', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_log_backup_group_size',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_log_backup_size',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2592954', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_trace_file_size',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2797078', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'max_trace_files',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2797078', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                   'parallel_data_backup_backint_channels',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2360533', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'backup',                 'parallel_data_backup_backint_size_threshold', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'backup',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI',       'global.ini',           'communication',            'internal_network',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2242514', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 2, 'MULTI',       'global.ini',           'communication',            'listeninterface',                           ' ', '.internal',                '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    -1,  1, -1, '2183363', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 2, 'STDBY',       'global.ini',           'communication',            'listeninterface',                           ' ', '.internal',                '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    -1,  1, -1, '2183363', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'communication',            'ssl',                                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'communication',            'sslsessioncachemode',                       ' ', 'off',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 47, 59.99,  2,  2, '2960895', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'communication',            'sslvalidatecertificate',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159014', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'communication',            'tcp_backlog',                               ' ', '2048',                     '8192',                    '-- no recommendation --', '-- no recommendation --',100,    53,  1,  2, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'communication',            'tcp_keepalive_count',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2696099', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'communication',            'tcp_keepalive_idle',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2696099', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'communication',            'tcp_keepalive_interval',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2696099', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'configuration',            'unsupported_configuration_change',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'configuration',  'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'configuration',            'write_log',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2990106', 'configuration',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'cross_database_access',    'enabled',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3048024', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'cross_database_access',    'targets_for%',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3048024', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'cryptography',             'ccl_fips_enabled',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180024', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'cryptography',             'ssfs_key_file_path',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2183624', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'cryptography',             'ssfs_key_file_path',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2183624', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'customizable_functionalities', '%',                                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2666303', 'configuration',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'csaccessor',               'allow_caching_of_redo_dml_context',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3462484', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'csaccessor',               'reduce_blocking_of_create_index',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160391', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'csaccessor',               'use_dml_executor_dataredo',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2449857', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',        'database_initial_encryption', 'backup_encryption',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3271747', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',        'database_initial_encryption', 'log_encryption',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3271747', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',        'database_initial_encryption', 'persistence_encryption',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3271747', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'enable_ddl',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'enable_sess_ctrl',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'enable_sys_ctrl',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'maxfiles',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'maxfilesize',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'trace_flush_interval',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'executed_statement',       'use_in_memory_tracing',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2366291', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'global.ini',           'execution',                'default_statement_concurrency_limit',       ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --',102.03, -1,  1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'default_statement_concurrency_max_limit',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'execution',                'load_factor_job_wait_pct',                  ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    66,  2,  2, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'execution',                'load_factor_sys_wait_pct',                  ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    66,  2,  2, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'global.ini',           'execution',                'max_concurrency',                           ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'max_concurrency_dyn_min_pct',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'max_concurrency_hint',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'max_concurrency_hint_dyn_min_pct',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'numa_features',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2470289', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'other_threads_act_weight',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'other_worker_worker_weight_ratio',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'execution',                'stealing_policy',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2470289', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'application',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'application_user',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'expensive_statement',      'enable',                                    ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'in_memory_tracing_records',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'maxfiles',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'maxfilesize',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'object',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'passport_tracelevel',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'threshold_cpu_time',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'expensive_statement',      'threshold_duration',                        ' ', '1000000',                  '100000000',               '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'threshold_memory',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'trace_flush_interval',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'trace_parameter_values',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'use_in_memory_tracing',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2112732', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'expensive_statement',      'user',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'async_read_submit%',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'async_write_submit_active%',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'async_write_submit_blocks%',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'max_parallel_io_requests%',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'max_submit_batch_size%',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'max_read_throughput%',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'max_throughput%',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'max_write_throughput%',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'min_submit_batch_size%',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'num_completion_queues%',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'num_submit_queues%',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'fileio',                   'size_kernel_io_queue%',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'disk I/O',       ' ' FROM DUMMY UNION ALL      
    SELECT 0, 'ALL',         'global.ini',           'ha_dr_provider%',          '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'high availab.',  'A' FROM DUMMY UNION ALL      
    SELECT 0, 'MDCSYS',      'global.ini',           'indexserver.%',            '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2101244', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'inifile_checker',          'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1984641', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'inifile_checker',          'exclusion_%',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100052', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'inifile_checker',          'interval',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'configuration',  'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'inifile_checker',          'replicate',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'configuration',  'A' FROM DUMMY UNION ALL
    SELECT 0, 'SINGLE',      'global.ini',           'internal_hostname_resolution', '%',                                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ldap',                     'session_pool_limit',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ldap',                     'sslciphersuites',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2438641', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ldap',                     'sslmaxprotocolversion',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2438641', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ldap',                     'sslminprotocolversion',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2438641', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ldap',                     'timeout',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2929927', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ltracer',                  'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'trace',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'ltracer',                  'tr',                                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCTEN',      'global.ini',           'memorymanager',            'allocationlimit',                           ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'async_free_target',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'async_free_threshold',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'check_cancel_at_allocation',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2092196', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'composite_oom_dump_info',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'composite_statistics_striping',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'disabled_parallel_tasks',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'emergency_release',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'enable_sharing_allocator_for_implicit',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2628153', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'final_memory_release_crash',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3405297', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'final_memory_release_shutdown',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3405297', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'memorymanager',            'gc_unused_memory_threshold_abs',            ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'memorymanager',            'gc_unused_memory_threshold_rel',            ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'global_allocation_limit',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'heap_preparation_interval',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2652487', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'huge_alignment_early_commit',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'memorymanager',            'impli_enable_reset',                        ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 48.03, 49,  2,  2, '1999997', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'memorymanager',            'impli_enable_reset',                        ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 52, 59.99,  2,  2, '1999997', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'keep_memory_max_size',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2810988', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'max_out_of_memory_events',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'min_segment_size',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'oom_dump_time_delta',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'persistent_memory_global_allocation_limit', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'memorymanager',            'small_block_gc',                            ' ', '100',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1, 59.04,  2,  2, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'memorymanager',            'small_block_gc',                            ' ', '100',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60,    63,  2,  2, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'global.ini',           'memorymanager',            'statement_memory_limit',                    ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'statement_memory_limit_rel',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'statement_memory_limit_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'statistics_type',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100040', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'total_statement_memory_limit',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memorymanager',            'use_huge_block_pool',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3324804', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'default_lower_limit_ratio',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'disposition_paged_attribute',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'disposition_weight_early_unload',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'disposition_weight_long_term',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'disposition_weight_mid_term',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'disposition_weight_short_term',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'enable_hierarchical_limits',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2955319', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'global_cache_lower_limit_abs',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'global_cache_lower_limit_rel',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'global_cache_upper_limit_abs',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'global_cache_upper_limit_rel',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'page_loadable_columns_limit',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'page_loadable_columns_limit_rel',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'page_loadable_columns_min_size',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'page_loadable_columns_min_size_rel',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unload_lower_bound',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1993128', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unload_lower_bound_rel',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unload_upper_bound',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2301382', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unload_upper_bound_rel',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unused_retention_period',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'memoryobjects',            'unused_retention_period_check_interval',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'database_isolation',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2269429', 'MDC',            'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'enforce_ssl_database_replication',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2733483', 'replication',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'mode',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2101244', 'MDC',            'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'reserved_instance_numbers',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2101244', 'MDC',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'singletenant',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2101244', 'MDC',            'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'multidb',                  'systemdb_reserved_memory',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'MDC',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'nameserver',               'max_disk_jobs',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3434285', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'nameserver',               'max_disk_job_duration',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3434285', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'parallel',                 'num_cores',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'performance_analyzer',     'plan_trace_enable',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2453348', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'enable_logmirror',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3459601', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'basepath_logmirror',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2080991', 'disk',           'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'basepath%',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'block_materialize_crossdb',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2742882', 'disk',           ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'checksum_algorithm',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'continuous_flush_interval_s',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2370160', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'continuous_flush_threshold_s',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'data_encryption',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'datavolume_striping',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'datavolume_striping_size_gb',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'enable_auto_log_backup',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1642148', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'enable_logmirror',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3459601', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'internal_caching_for_main',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2403124', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'lob_fileid_eid_mapping_stripe_factor',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'lob_page_cache_max_size',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'lob_page_cache_reclaim_target_size',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'lob_page_cache_reclaim_threshold_size',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',           'log_backup_history_broken_emergency_shutdown', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2628775', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'persistence',              'log_backup_timeout_s',                      ' ', '300',                      '3600',                    '-- no recommendation --', '-- no recommendation --', 13,    -1,  1, -1, '1645183', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'persistence',              'log_buffer_count',                          ' ', '8',                        '64',                      '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2215131', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'persistence',              'log_buffer_size_kb',                        ' ', '1024',                     '16384',                   '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2215131', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'persistence',              'log_disk_usage_limit',                      ' ', '95',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60, 69.99,  2,  2, '3142505', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'log_disk_usage_reclaim_retention_threshold',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3147346', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'log_disk_usage_reclaim_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3147346', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'log_mode',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1900267', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'log_replay_detailed_statistics',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'log_replay_step_size',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2016634', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'SYSREP',      'global.ini',           'persistence',              'logreplay_savepoint_interval_s',            ' ', '900',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    49, -1,  2, '2409671', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'persistence',              'max_gc_parallelity',                        ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'merge_during_crash_recovery',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3013617', 'merge',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'merge_during_logreplay',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'merge',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'non_trans_cch_block_size',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'optimize_compression_type_during_logreplay',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3006289', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',         'optimized_resource_container_lookup_for_backup', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3009465', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'optimized_superblock_read_for_backup',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2930882', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'private_log_buffer_size_kb',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2183246', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'persistence',              'savepoint_interval_s',                      ' ', '10',                       '7200',                    '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1898505', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'persistence',              'stop_async_gc_in_shutdown',                 ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    74,  2,  2, '3388674', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'recovery_max_load_parallelity',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3514957', 'recovery',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'recovery_queue_count',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1964645', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'reencryption_chunk_size_absolute',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'I/O',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'reencryption_chunk_size_percent',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'I/O',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'runtimedump_corrupt_pages',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'corruption',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'savepoint_max_pre_critical_flush_duration', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'savepoint_pre_critical_flush_retry_threshold',' ','-- no recommendation --', '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2538561', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'tablepreload_write_interval',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'XFS',         'global.ini',           'persistence',              'use_helper_threads_for_flush',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2655238', 'disk I/O',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistence',              'use_mountpoints',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1820553', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'allow_tmpfs_block_deletion_for_shrink',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'enable_compaction',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'force_provider_lock_for_savepoint_cleanup', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3466826', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'out_of_persistent_memory_mode',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'sr_allow_tmpfs_block_deletion_for_shrink',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'table_default',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'table_unload_action',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'unused_retention_period_unload_action',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'persistent_memory',        'volume_quote_rel',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'pitrestart',               'replay_step_size',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2409671', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'public_hostname_resolution', '%',                                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking',        'cpu_time_measurement_mode',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100040', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'global.ini',           'resource_tracking',        'enable_tracking',                           ' ', 'on',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 80, 59.99,  1,  2, '1999997', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking',        'host_job_history_granularity',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2529478', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'global.ini',           'resource_tracking',        'load_monitor_granularity',                  ' ', '1000',                     '60000',                   '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222110', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking',        'load_monitor_max_samples',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222110', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'global.ini',           'resource_tracking',        'memory_tracking',                           ' ', 'on',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 80, 59.99,  1,  2, '1999997', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking',        'service_network_method_io_enabled',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'resource_tracking',        'service_thread_sampling_monitor_enabled',   ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 10,    54,  2,  2, '2114710', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking','service_thread_sampling_monitor_max_sample_lifetime',' ','-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking','service_thread_sampling_monitor_max_samples',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking','service_thread_sampling_monitor_sample_interval',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'resource_tracking','service_thread_sampling_monitor_thread_detail_enabled',' ','-- no recommendation --','-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'row_engine',               'max_persistent_container_block',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'row_engine',               'max_transient_container_block',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'row_engine',               'segment_prealloc_data_segment_threshold',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2857744', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'row_engine',               'segment_prealloc_free_page_threshold',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2857744', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'session',                  'busy_executor_threshold',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2320604', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'global.ini',           'sql',                      'hex_enable_distributed_query_processing',   ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    76,  2,  2, '3430537', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'sql',               'hex_enable_distributed_query_processing_cross_db', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'sql',                      'max_sql_executors',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'sql',                      'sql_executors',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'statement_hint',           'normalization',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400006', 'statement hint', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'storage',                  'ha_provider%',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'storage',                  'partition_%',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_information',       'license_usage',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2779499', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_information',       'usage',                                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_information',       'xsa_sizing',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2509043', 'sizing',         'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_landscape_hostname_resolution', '%',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'SLD',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_landscape_hostname_virtualization', 'sldsystemhome',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'system_landscape_hostname_virtualization', 'sldvirtdbhome',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'actual_mode',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'check_active_persistence_for_delta_sync',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2757723', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'check_secondary_active_status',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'connection_changed_asynchronous',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3220088', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'datashipping_logsize_threshold',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'datashipping_min_time_interval',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'datashipping_parallel_channels',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'datashipping_snapshot_max_retention_time',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_cache_pages_for_preload',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700084', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',    'enable_cache_pages_for_preload_version_check', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2587465', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_data_compression',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_full_sync',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_log_compression',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_log_retention',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_send_ack_in_async_mode',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2312539', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'enable_sync_via_log',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2434562', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'ensure_backup_history',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2135107', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'full_replica_on_failed_delta_sync_check',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2135107', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'ha_dr_provider_block_on_connection_change', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3301633', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'hint_based_routing_site_name',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2881489', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'keep_old_style_alert',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      '%',                    'system_replication',       'logshipping_async_buffer_size',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2086024', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_async_wait_on_buffer_full',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 3, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_max_retention_size',            ' ', '0',                        '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_replay_logbuffer_cache_size',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2405763', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_replay_push_callback_count',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2381431', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_secondary_timeout',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_snapshot_logsize_threshold',    ' ', '3221225472000',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_snapshot_min_time_interval',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2332284', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_replay_timeout',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'logshipping_timeout',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'mode',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'operation_mode',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'preload_column_tables',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'propagate_log_retention',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'reconnect_time_interval',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'register_secondaries_on_takeover',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2968930', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'replication_port_offset',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2477204', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'runtimedump_for_logshipping_timeout',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'site_id',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'site_name',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'spcoordinator_timeout',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2902020', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'runtimedump_for_table_preload_timeout',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication','runtimedump_for_table_preload_in_takeover_timeout',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'table_preload_tracing_interval',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'timetravel_call_takeover_hooks',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'timetravel_logreplay_mode',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'timetravel_max_retention_time',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication',       'timetravel_snapshot_creation_interval',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication_hostname_resolution', '%',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2183363', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication_communication', 'allowed_sender',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2356851', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication_communication', 'enable_ssl',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2230230', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'SYSREP',      'global.ini',           'system_replication_communication', 'enable_ssl[%]',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2230230', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 3, 'SYSREP',      'global.ini',           'system_replication_communication', 'listeninterface',                   ' ', '.global',                  '-- no recommendation --', '.internal',               '-- no recommendation --', -1,    -1, -1, -1, '2183363', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',    'table_partition_operation_trace', 'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',    'table_partition_operation_trace', 'maxfiles',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',    'table_partition_operation_trace', 'maxfilesize',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',    'table_partition_operation_trace', 'trace_flush_interval',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',    'table_partition_operation_trace', 'use_in_memory_tracing',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'bw_schema',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1715048', 'configuration',  'D' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'initial_partitions',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'initial_partitions_bw_cube',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'initial_partitions_bw_dso',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'initial_partitions_bw_psa',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'BW',          'global.ini',           'table_placement',          'max_partitions',                            ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --',120,    -1,  1, -1, '1908075, 2334091', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'BW',          'global.ini',           'table_placement',          'max_partitions_limited_by_locations',       ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --',120,    -1,  1, -1, '1908075, 2334091', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'BW',          'global.ini',           'table_placement',          'max_rows_per_partition',                    ' ', '1500000000',               '-- no recommendation --', '-- no recommendation --', '-- no recommendation --',100,    -1,  1, -1, '1908075, 2334091', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'table_placement',          'method',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1908075', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partitioning_threshold',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partitioning_threshold_bw_cube',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partitioning_threshold_bw_dso',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partitioning_threshold_bw_psa',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partition_row_count_threshold',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partition_row_count_threshold_bw_cube',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partition_row_count_threshold_bw_dso',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'partition_row_count_threshold_bw_psa',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1819123', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI,BW',    'global.ini',           'table_placement',          'prefix',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1715048', 'configuration',  'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'table_placement',          'same_num_partitions',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1908075', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCSYS',      'global.ini',           'threads',                  'async_request',                             ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60, 67.02,  2,  2, '3343278', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCSYS',      'global.ini',           'threads',                  'async_request',                             ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    72,  2,  2, '3343278', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCTEN',      'global.ini',           'threads',                  'async_request',                             ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60, 67.02,  2,  2, '3343278', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MDCTEN',      'global.ini',           'threads',                  'async_request',                             ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    72,  2,  2, '3343278', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'trace_cleaner',            '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'traces',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'transaction',              'auto_reclaim_version_space_enabled',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2857744', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'workload_replay',          'disable_delta_log',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'workload_replay',          'loading_thread',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2766800', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'workload_replay',          'replay_stmt_wait_timeout',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'workload_replay',          'runtimedump_at_stmt_wait_timeout',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'workload_replay',          'table_partition_size',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2766800', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'trace',                    'ha_dr%',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'trace',                    'ha_fc%',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'global.ini',           'trace',                    'ha_fujitsu%',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'averaging_factor',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'averaging_factor_cpu',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'averaging_factor_memory',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'dequeue_interval',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'dequeue_size',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'max_queue_size',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'queue_cpu_threshold',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'indexserver.ini',      'admission_control',        'queue_memory_threshold',                    ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    53,  2,  2, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'queue_timeout',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'queue_timeout_check_interval',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'reject_cpu_threshold',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'reject_memory_threshold',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control',        'statistics_collection_interval',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'admission_control_events', 'record_limit',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'data volume',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'attributes',               'check_main_column_consistency_after_load',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authentication',           'last_successful_connect_update_interval',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2460123', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authentication',           'saml_service_provider_name',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127582', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authentication',           'saplogonticketenabledfornewusers',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1927949', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authentication',           'saplogontickettruststore',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1927949', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authorization',            'internal_support_user_limit',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2081857', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'authorization',            'ldap_authorization_role_reuse_duration',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2438641', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'buffer_cache_cs',          'async_prealloc_in_chunks_enabled',          ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 59.05,59.10,2,  2, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'buffer_cache_cs',          'enabled',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'buffer_cache_cs',          'max_size',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'buffer_cache_cs',          'max_size_rel',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2799997', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'buffer_cache_cs',          'unload_threshold',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'businessdb',               'cache',                                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'businessdb',               'cache_erp_currency_query_base_rates',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'businessdb',               'cache_erp_currency_query_rates',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'businessdb',               'parallel_threshold',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2041874', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'bwfftc',                   'batch_processing_threshold',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3341144', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'cache',         'cs_statistics_cache_invalidation_by_shrinking_tables', ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 73, 79.99,  2,  2, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',            'cs_statistics_cache_invalidation_threshold_factor', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL', 'indexserver.ini', 'cache', 'cs_statistics_cache_invalidation_threshold_factor_for_sqlscript_temp_table',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'datastatistics_adviser',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'datastatisticsadvisercache_enabled',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'enable_single_value_caching',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1980765', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'hierarchies_transactional_cache_enabled',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'reclaim_interval',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'resultcache_enabled',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'resultcache_clear_reconfig',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'resultcache_local_lookup_only',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1833049', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'resultcache_maximum_value_size_in_bytes',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',     'resultcache_minimum_query_execution_time_in_milliseconds', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                  'resultcache_request_timeout_in_milliseconds', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cache',                    'resultcache_white_list',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2014148', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_disable_unfolding',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2142945', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_enable_boundary_op',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2517443', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_enable_scripted_calc_view_unfolding', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2737221', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_enable_sql_op_conversion',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3088635', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_for_nested_views_with_sql_execution', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2401093', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ce2qo_for_unit_conversion',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2142945', '',               ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'cejoin_active',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2878279', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'cejoin_maxthreads',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999993', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'cejoin_stringkeysize',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2376420', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ceqo_derived_parameter_unfolding_mode',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2823670', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ceqo_unfold_with_select_pushdown_mode',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2844568', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'ceqo_use_dyn_plan_conditions_for_dyn_ap',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2908857', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'cer_disable_workload_balance',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2548264', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'disabled_patterns',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100040', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'distributed_cache_timeout_milliseconds',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'enable_deprecated_component_flags',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789289', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'enable_star_join_ceqo',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2142945', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'enforce_bigint_counters',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2648134', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'gc_cleanup_retention_sec',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2474345', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'max_cache_size_kb',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'performance',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_cardinality',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2140610', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',           'optimize_combine_filter_multiple_consumer_new', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114021', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_convex_hull_fems_filter_new',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2064439', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_convex_hull_fems_filter_threshold',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2751390', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 2, 'BW',          'indexserver.ini',      'calcengine',               'optimize_convex_hull_through_mp',           ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 75,    76,  2,  2, '3434517', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_filter_remove_attributes',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1980763', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_mp_merge_with_const_delta_query',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2451991', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',           'optimize_filter_remove_attributes_through_mp',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2845831', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'optimize_simplify_filter_enabled',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2476216', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'tracemodels',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2894967', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'use_calcnode_cache',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2923129', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'calcengine',               'use_distributed_cache',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'catalog_watchdog',         'max_nologging_table_count_limit',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2214569', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cds',                      'internal',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2034208', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'acceptqueuelen',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2373231', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'default_connect_timeout',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2736804', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'handles',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'maxchannels',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'maxendpoints',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'maxidleage',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222200', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'signal_recv_timeout',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2427296', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'signal_send_timeout',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2427296', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'sock_read_tmout_search',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2848919', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'ssl%',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'communication',            'tcp_backlog',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2373231', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_access_statistics',     'collection_enabled',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2785533', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_access_statistics',     'min_row_count',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2970271', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_nse_advisor',           'cold_object_threshold_rel',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2785533', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_nse_advisor',           'enable_lob_pageloadable',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3125483', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_nse_advisor',           'hot_object_threshold_rel',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2785533', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'cs_nse_advisor',           'min_object_size',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2785533', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'csaccessor',               'disable_table_consistency_checks',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2603049', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dataprovisioning',         'appliermaxrowsstagingtable',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2882880', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dataprovisoning',    'applierretryuniqueconstraintviolationwithupsert', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2752372', 'SDI',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'datastatistics',           'datastatistics_from_csmetadata',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dbapi',                    'total_hlob_size_mb',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'ddl',                      'max_number_of_data_jobs',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'ddl',                      'use_olap_engine_for_unique_check',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'btree_cache_aggressiveness',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2338166', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'btree_cache_heavy_hitters',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2226707', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'cch_reopening_enabled',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2214279', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'default_rowid_deltacontainer_type',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2730136', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'delta_scan_block_size',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'delta_scan_stealing',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'insert_max_threads',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'readindex_fallback_threshold',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2318281', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'track_upper_lower',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3248936', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'use_asynchronous_valueid_mapper',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2926700', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'use_massupdates',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2632716', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'delta',                    'use_speculative_rwlock',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2999065', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dictstore',                'check_main_dictionary_after_load',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dictstore',                'check_main_dictionary_after_load_repair',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'distribution',             'client_distribution_mode',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2200772', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'distribution',             'implicit_xa_session',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2691896', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'distribution',             'split_batch_commands',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1912332', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'distribution',             'systemreplication_protocol_version',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2766061', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                      'activation_columnset_size',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2385658', 'inconsistency',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                      'activation_row_count_limit',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2338069', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                  'calculate_active_data_from_detailed_changelog', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2285173', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                      'check_unique_constraints',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                      'force_detailed_changelog',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2285173', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW',          'indexserver.ini',      'dso',                      'search_realization',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2613469', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dynamic_result_cache',     'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2506811', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dynamic_result_cache',     'enable_implicit_match',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2506811', 'memory',         'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dynamic_result_cache',     'max_cache_entry_size',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2506811', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dynamic_result_cache',     'total_size',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2506811', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'dynamic_result_cache',     'version_garbage_collection_blocking_period',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2506811', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'eapi',                     'max_statement_retry_count',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'epm',                      'enable_legacy_plan_operations',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'evaluator_redirect',       'match_rows_main',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'execution',                'asynchronous_compilation',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'execution',                'compilation_strategy',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'execution',                'max_concurrency',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'CPU',            ' ' FROM DUMMY UNION ALL /* required because parameter is 'D' -> default for nameserver.ini in system DB */
    SELECT 0, 'ALL',         'indexserver.ini',      'execution',                'recompile_table_size_increase',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'global',                   'activate_old_trexviadbsl_functions',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1600929', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'global',                   'timezone_default_data_schema_name',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1791342', 'performance',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         '%',                    'global',                   'timezone_default_data_client_name',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1791342', 'performance',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'global',                   'load_table_numa_aware',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222217', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'global',                   'create_index_optimize_bulksize',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000000', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'global',                   'pa_count_distinct_threshold',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2632776', 'I/O',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'compilation_strategy',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'enable_asynchronous_compilation',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'enable_dqp_pruning_check',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'hex',                      'enable_interpreter_cache',                  ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 43,    49,  2,  2, '2808956', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'enable_tasks_for_introsort',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2875578', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'enforce_materialization_in_open',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2965050', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'max_block_size_introsort',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2875578', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'max_concurrency_task_limit_factor',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'max_lines_generated_code',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2955319', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'min_table_increase_factor_to_recompile',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hex',                      'planex_table_lock_acquire_timeout',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2901568', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'hex',                      'threshold_limit_for_normal_table_scan',     ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    72,  2,  2, '3411550', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hierarchy',                'hierarchy_sqlfunction_cache_enabled',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502556', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hierarchy',                'hierarchy_sqlfunction_cache_max_size',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502556', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hierarchy',                'hierarchy_view_cache_enabled',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hint_result_lag_hana_long','sr_default_lag_time',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2732012', 'system rep.',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',     'hint_result_lag_hana_short','sr_default_lag_time',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2732012', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'hint_result_lag_hana_sr',  'sr_default_lag_time',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999880', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'csv_import_path_filter',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2109565', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'enable_convert_es_to_row_tables',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2178461', 'dyn. tiering',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'enable_csv_import_path_filter',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2109565', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'file_security',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2252941', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'max_csv_import_memory_size',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3026242', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'import_export',            'use_parallel_export',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'max_chunk_size_for_delete',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975448', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'max_chunk_size_for_insert',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975448', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'max_chunk_size_for_update',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1974570', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'max_rowpos_asym_table_rep',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'migrate_vf_to_ut_in_deltamerge',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2487855', 'corruptions',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'parallel_merge_part_threads',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'indexing',                 'parallel_merge_threads',                    ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'parallel_write_threshold',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'use_batch_like_upsert_select',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2852908', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'use_sparsity_check',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2112604', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 1, 'MULTI',       'indexserver.ini',      'indexing',                 'use_db_serialization',                      ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    41,  2,  2, '2817369', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexing',                 'use_tu_query_cache',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2877010', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexmgr',                 'dump_again_seconds',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexmgr',                 'dump_wait_seconds',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'indexmgr',                 'stripe_count',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'itab',                     'trace_leaks',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'itab',                     'trace_leakcallstacks',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'cache_temp_translation_tables',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2217936', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'column_view_accept_lob_join',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222219', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'disable_aggregate_simplification',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2092196', 'stuck',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'disable_itab_runtime_pruning',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2553487', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'disable_join_collocation',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2308421', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'disable_plan_simplification',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1991414', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'enable_join_predicate_runtime_pruning',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3247177', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'fail_on_unconnected_outputs',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3087670', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'lucene_sql_param_inlist_threshold',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2870468', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'map_threshold_factor_uns_mapping',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2599767', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'max_retry_on_syncpoint_error',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2112848', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'optimize_metamodel',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1986747', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'plan_cache_size',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'joins',                    'parallel_reducer_application_threshold',    ' ', '-1',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 59.09,59.09, 2, 2, '3363560', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'joins',                    'parallel_reducer_application_threshold',    ' ', '-1',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 67.02,67.02, 2, 2, '3363560', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'joins',                    'parallel_reducer_application_threshold',    ' ', '-1',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    72,  2,  2, '3363560', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'prune_cached_plans',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2387680', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'joins',               'single_thread_execution_for_partitioned_tables', ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',          'sqlscript_temp_table_size_change_triggers_recompile', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'statistics_method',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3002933', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'translator_cache_size',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1998599', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'translator_hashmap_max_size',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036494', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'translator_hashmap_min_size',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036494', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'tt_complete_fill_factor',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'tt_complete_fill_threshold',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2313619', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'virtual_vids_bitvector_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2642704', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'joins',                    'use_single_part_plan_optimization',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2338565', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'joins',                    'use_top_postcondition_optimization',        ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1, 59.06,  2,  2, '3262334', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'joins',                    'use_top_postcondition_optimization',        ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60,    66,  2,  2, '3262334', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'jsvm',                     'max_runtime_bytes',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2996070', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'max_early_garbage_collection_jobs',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'max_version_retention_time',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'min_version_retention_time',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2593571', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'early_garbage_collection_interval',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'early_garbage_collection_threshold',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'livecache',                'version_threshold',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'liveCache',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'lobhandling',              'garbage_collect_daily_schedule_s',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'lobhandling',              'garbage_collect_interval_s',                ' ', '43200',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 20,    53,  2,  2, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'lobhandling',              'garbage_collect_interval_s',                ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 59.08,59.11,2,  2, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'lobhandling',              'garbage_collect_interval_s',                ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 67.00, 75,  2,  2, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'locale_mapping',           'ignore_country_code',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2360741', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'main',                     'enable_inverted_index_sort',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3019467', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 4, 'MDS',         'indexserver.ini',      'mds',                      'cache_max_memory_bytes',                    ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3203745', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 4, 'MDS',         'indexserver.ini',      'mds',                      'cache_session_ttl',                         ' ', '43200',                    '172800',                  '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3203745', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'cube_cache_max_memory_bytes',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3203745', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'cell_size_max_default',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2770570', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'cell_size_max_limit',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2770570', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'cube_parallel_processing_11_job_size',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2321714', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'disable_statistics',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'enable_cube_cache',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'enable_execution_on_secondary',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2983761', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'enhance_view_formulas',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2774760', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'flush_cache',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2465129', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'max_statistics_entry_count',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_distributed_cache_timeout_ms',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2598662', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_enable_plan_result_limit',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3077986', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_enable_user_specific_metadata_cache',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_hierarchy_preferred_engine',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3139372', 'MDS',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_host_and_port',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3149235', 'MDS',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_plan_use_ce_new_for_geo',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2896962', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_routing_view',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3149235', 'MDS',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'mds_use_mdp',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3419344', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'metadata_sql_optimization_level',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2967256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'parallel_processing',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3380919', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'parallel_processing_load_limit',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2773755', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'per_request_memory_usage_estimation',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2670064', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'request_queue_enable',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2773755', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'request_queue_load_balancing',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2773755', 'resources',      'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'request_queue_size',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2773755', 'resources',      'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'result_set_size_max_default',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2770570', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mds',                      'result_set_size_max_limit',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2770570', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'MDS',         'indexserver.ini',      'mds',                      'use_sql_procedure_for_analytics',           ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1, 69.99, -1,  2, '2180165', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'cache_check_interval',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3091429', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'cache_entry_timeout',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'cache_entry_timeout_action',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'cache_insert_retries',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2825510', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'mds_check_view_formula_nesting_and_ea',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3151992', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'mdx_calc_cluster',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3136063', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mdx',                      'treat_null_as_zero',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2262591', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'memorymanager',            'huge_alignment_cache_target',               ' ', '1024',                     '102400',                  '-- no recommendation --', '-- no recommendation --', 30,    54,  2,  2, '2953186', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'memorymanager',            'huge_alignment_gc',                         ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 30,    54,  2,  2, '2953186', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'memorymanager',            'proactive_gc_interval',                     ' ', '10',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 30,    58,  2,  2, '2953186', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'memoryobjects',            'page_loadable_columns_limit',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'memoryobjects',            'page_loadable_columns_min_size',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2111649', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'memoryobjects',            'unload_lower_bound',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1993128', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',   'memoryobjects_properties', 'hex_dist_plan_fragment_cache/upper_limit_abs', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3430537', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',   'memoryobjects_properties', 'hex_dist_plan_fragment_cache/upper_limit_rel', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3430537', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',   'memoryobjects_properties', 'join_translation_table_cache/upper_limit_abs', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1998599', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',   'memoryobjects_properties', 'join_translation_table_cache/upper_limit_rel', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1998599', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'active',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'add_mem_for_optimization',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'auto_merge_decision_func',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'auto_merge_priority_func',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'check_compression_no_automerge',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1955508', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'check_interval',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'critical_merge_decision_func',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'delta_merge_statistics_record_limit',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'hard_merge_priority_func',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'load_balancing_func',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'max_cpuload_for_merge',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'mergedog',                 'max_cpuload_for_parallel_merge',            ' ', '80',                       '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'max_lock_retry_period',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2780767', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'mergedog',                 'max_lock_wait_time',                        ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    40,  2,  2, '2780767', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'memory_statistics_refresh_interval',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'num_merge_threads',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'reclaim_delta_decision_func',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'mergedog',                 'smart_merge_decision_func', ' ', '(DMS>1000 or DRC>0.1*MRC or DMR>0.1*MRC)', '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'smart_merge_enabled',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'smart_merge_priority_func',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'token_per_table',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'mergedog',                 'unload_check_interval',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 3, 'BW',          'indexserver.ini',      'mergedog',                 'unload_decision_func',                      ' ', 'TPL=0 and TLT > 86400 and if(TURP > 0, TLD > TURP, TLD > 259200 and TLD > MMS * 100)', '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    46,  2,  2, '2127458', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'enable_drop_global_temp_row_in_use',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2503043', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'enable_metadata_separation',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2372809', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'enable_secondary_alone_authentication',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2955563', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'force_turning_on_metadata_separation',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2082119', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'ignore_exception_during_auto_migration',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2535589', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'max_num_recompile_threads',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2664814', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'mem_usage_for_active',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800007', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'serialize_online_ddls',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2873607', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'metadata',                 'startup_consistency_check',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'numa',                     'enforce_single_instance',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2307882', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'olap',                     'compress_serialized_plandata_golomb_only',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2354107', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'olap',                     'optimize_value_id_search',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975223', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'olap_parallel_result',     'use_compact_column',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1983888', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'active',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'auto_decision_func',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2105761', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'change_compression_threads',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'critical_decision_func',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2057046', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'enable_locklesser_behaviour',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'estimate_compression_threads',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'get_candidates_threads',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'migrate_vf_to_ut',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2487855', 'corruptions',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'min_hours_since_last_merge_of_part',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2105761', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'numa_awareness_no_steal_jobs',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100040', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'optimize_threshold_factor',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160391', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'prepare_threads',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'optimize_compression',     'row_order_optimizer_threads',               ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', 30,    -1,  2, -1, '2112604', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',   'singleindex_consider_for_compressed_columns', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2516807', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'optimize_compression',     'smart_decision_func',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2105761', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'parallel',                 'use_append_dict',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2363632', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'parallel',                 'max_lock_retry',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2535656', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'parallel',                 'mode',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'parallel',                 'should_stop_time',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2403088', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'parallel',                 'tables_preloaded_in_parallel',              ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'allow_dynamic_range_partitioning',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2081135', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'bulk_load_size',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'bulk_load_threads',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'dynamic_range_check_time_interval_sec',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'dynamic_range_default_threshold',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'enable_check_range_length_for_spec',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222219', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'enable_pruning_statistics',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'partition_statistics_select_enabled',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'split_history_parallel',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'partitioning',             'split_threads',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'partitioning',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'password policy',          'force_first_password_change',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'password policy',          'maximum_unused_inital_password_lifetime',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'password policy',          'minimal_password_length',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'password policy',          'password_expire_warning_time',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2082406', 'security',       'S' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'performance_analyzer',     'planviz_enable',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789386', 'crash',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'continuous_reclaim_enabled',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'continuous_reclaim_max_touch_snapshot_size',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'continuous_reclaim_start_threshold',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'continuous_reclaim_step_max_touch_size',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'continuous_reclaim_stop_threshold',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400005', 'persistence',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'disable_midsizelobs_for_tables',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'LOBs',           ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'disposition_lob_read',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'disposition_lob_read_small',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'disposition_lob_write',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'disposition_lob_write_small',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'fileid_mapping_lob_owner_stripe_factor',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3258000', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',           'force_check_for_delta_log_entries_at_startup', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2666367', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',       'lob_fileid_mapping_remove_all_mapping_chunk_size', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'lob_page_trigger_cleanup_threshold',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'log_preformat_segment_count',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'midsizelob_threshold',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'LOBs',           ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'poc_import_chunk_size',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',            'prevent_log_replay_at_restart_for_savepoint', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3508952', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'runtimedump_for_blocked_savepoint_period',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'trace',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'runtimedump_for_blocked_savepoint_period_s',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'trace',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'runtimedump_for_blocked_savepoint_timeout', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'trace',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',            'runtimedump_for_blocked_savepoint_timeout_ms',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100009', 'trace',          'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'tracefile',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, ' ',       'performance',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'undo_file_cache_size',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2547543', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'persistence',              'vsec_num_prefetched_pages_for_allocation',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999930', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'pitrestart',               'replay_step_size',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2661878', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'allow_fox_table_type',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2200331', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'allow_non_readonly_sqlscript',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1979401', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'disable_string_length_checks',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2285769', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'formula_parallel_limit',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2607741', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'num_parallel_fox',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2837840', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'time_to_wait_for_semaphore',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'planningengine',           'use_fox_loop_caching',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2065893', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'plan_stabilizer',          'enable_plan_stabilizer',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400006', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'plan_stabilizer',          'enable_stored_hints',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400006', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'queueserver',              'inactive_at_service_start',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2140653', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'cache_enable',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2555376', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'filtertransport_enable',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2535996', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'local_group_bys_max_table_sets_per_host',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'local_group_bys_optimization_level',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2553642', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'outward_ratio',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2857383', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'tracefile',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, ' ',       'performance',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'use_concurrent_plan_generation',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'use_dynamic_pruning',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2044468', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'query_mediator',           'use_precise_filtertransport_estimations',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2785840', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'repository',               'content_vendor',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2275523', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'repository',               'differ',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2113745', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'repository',               'sqlscript_mode',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3091143', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'result_cache',             'before_analytic_privilege',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2336344', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'result_cache',             'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2336344', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'result_cache',             'pre_refresh_threshold',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2336344', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'result_cache',             'total_size',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2336344', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'async_index_load_at_startup',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3135043', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'automatic_reorg_deep_reorg_interval',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789255', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'automatic_reorg_enabled',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789255', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'automatic_reorg_interval',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789255', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'automatic_reorg_threshold',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2789255', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'bulk_delete_threshold',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'DML',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'bulk_deletion_enabled',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2647906', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'collect_leaked_pages_at_startup',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2101640', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'consistency_check_at_startup',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'dynamic_parallel_insert_max_workers',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'garbage_lob_file_handler_enabled',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'LOB',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'garbage_lob_file_handler_interval',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'LOB',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'keep_shared_memory_over_restart',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159435', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'keep_shared_memory_over_restart_timeout',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159435', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'max_retrial_in_slot_creation',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3135063', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'multi_container_enabled',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2287439', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'num_of_freepage_distributors',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'num_parallel_monitor_thread',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'online_reorg_max_concurrency',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',           'online_rs_reorg_parallel_record_move_max_jobs', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'page_compaction_enable',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1813245', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'page_compaction_max_pages',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1813245', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'parallel_query_execution',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000792', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'reuse_shared_memory_for_restart',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159435', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'reuse_shared_memory_for_restart_timeout',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159435', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'show_primary_key_in_consistency_check',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'show_record_in_consistency_check',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'version_space_partitions',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'use_jobex_index_rebuild',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2005478', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'use_rs_lob_gc_migration',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2880702', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'row_engine',               'use_shared_memory',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'add_assertionconsumer_url',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'add_key_info',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'assertion_timeout',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2476310', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'default_application_path',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'defaultrole',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2620766', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'enable_idp_mapping_for_implicit_users',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'hash',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'organisation_display_name',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'organisation_name',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'organisation_url',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'saml',                     'sign_authn_request',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127658', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'collect_top_documents_count',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2611281', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'freestyle_combine_score_for_or',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2968214', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'late_materialization_threshold',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975448', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'late_materialization_threshold_for_insert', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1975448', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'search',                   'non_eq_itab_enabled',                       ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 30,    50,  2,  2, '2600030', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_extensive_checks',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3262641', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_mcsj_fullkey_limit_delta',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2844050', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_optimize_valuevec_limit',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2042749', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_small_enough_exact_estimation',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2756967', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_small_enough_rough_estimation',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2756967', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_top_1_optimization',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2238679', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'qo_use_bitvector_limit',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2994900', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'search',                   'sql_like_pushdown',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'series',                   'abap_itab_parameter',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2399993', 'FDA',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'series',                   'series_column_lrle_compression_enabled',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2549632', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'compression_disabled',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3104321', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'connection_establish_statistics_threshold', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000000', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'connection_history_lifetime',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'connection_history_maximum_size',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'data_format_version',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2638379', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'enable_connection_establish_statistics',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000000', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'enable_deferred_prepare',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2756673', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'enable_eapi_fact_compression',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2381733', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'enable_plan_cache_decoupling',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2519670', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'fda_enabled',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2399993', 'FDA',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'idle_connection_timeout',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2035443', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'idle_connection_timeout_application_%',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'initial_receive_timeout',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2385992', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'session',                  'itab_initial_buffer_size',                  ' ', '1126400',                  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'maximum_connections',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1910159', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'maximum_external_connections',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1910159', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'maximum_fetch_size',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3047815', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'maximum_lob_prefetch_size',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2408032', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'max_statements_per_connection',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'socket_keepalive',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1836774', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'statement_timeout',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'limitation',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'tcp_keepalive_intvl',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1836774', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'tcp_keepalive_probes',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1836774', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'session',                  'tcp_keepalive_time',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1836774', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',   'session_workload_management', 'allow_more_resources_by_hint',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'resources',      ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'default_connections_pool_max_size',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180119', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_binary_transfer',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2472882', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_remote_cache',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_rid_for_join_relocation',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3105417', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_subqueries_gen',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2609173', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_universal_itab',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3017103', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'enable_universal_itab_hana_sda',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3049597', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW,IQ,SDA',   'indexserver.ini',      'smart_data_access',        'join_relocation',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100962', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'max_output_batch_rows',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2180119', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'max_remote_scan_queries',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'odbc_adapters_in_scriptserver',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2602761', 'garbage coll.',  'A' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'remote_cache_validity',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'remote_conn_idle_timeout',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2836212', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'remote_objects_tree_max_size',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2184030', 'limitation',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'rewrite_simple_stat_query',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2965586', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW,SDA',      'indexserver.ini',      'smart_data_access',        'semi_join_virtual_table_threshold',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100962', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SDA',         'indexserver.ini',      'smart_data_access',        'virtual_table_default_cardinality',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100962', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW,SDA',      'indexserver.ini',      'smart_data_access',        'virtual_table_format',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2100962', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'allow_duplicates_in_merge_into',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3038452', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'allow_incomplete_results_for_contains',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2224909', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                  'block_access_to_subject_table_view_on_trigger', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2752553', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'calculation_view_unfolding',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2177965', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'calc_view_with_dyn_ap_unfold',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2441054', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'ce2qo_transient_plan_for_data_var',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2441054', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'compile_time_sampling_partitions',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                   'conservative_cs_anti_join_estimation_enabled', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                 'cs_composite_primary_key_constraint_index_type', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160391', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'cs_composite_unique_constraint_index_type', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160391', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                    'cs_equi_cond_update_optimization_batch_size', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3063161', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'cs_scalar_udf_containing_select_enabled',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2906598', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'default_lob_storage_type',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'LOBs',           ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'default_table_type',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222277', 'configuration',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'dev_topk_sampling_with_evaluation',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3207580', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'disj_filter_into_union_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2228370', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'disjunctive_hash_join_enabled',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2856586', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'display_sql_statement_parameters_in_dump',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2288661', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                     'enable_general_like_predicate_cv_unfolding', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'enable_old_update_from_behavior',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2241598', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'enable_parameterized_sql_view_sharing',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3483974', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'enable_with_parameters_locale_for_rs_esx',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3501346', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'esx_level',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2599949', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'evicted_plan_statistics_size',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'expr_segment_size',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'sql',                      'fail_on_invalid_hint',                      ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700051', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_between_lists_enabled',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2793751', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_check_multiple_consumers',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3019121', 'garb. coll.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_disable_prefix_concat_search',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enabled',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2663190', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_for_all_entries_predicates',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',            'hex_enable_for_all_entries_predicates_without_index', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2114710', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_like',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_parameter_itab',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_prefix_concat_search',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MULTI',       'indexserver.ini',      'sql',                      'hex_enable_remote_table_access',            ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 41, 59.99,  2,  2, '2570371', 'garb. coll.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_replica_on_partitioned_table',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_replicas',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_row_index_join',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3405833', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_runtime_pruning',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2940363', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'MULTI',       'indexserver.ini',      'sql',                      'hex_enable_skip_exec_plan_gen',             ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 45,    46,  2,  2, '2890607', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_enable_with_parameters_locale',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3501346', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',              'hex_input_to_output_ratio_to_trigger_vid_grouping', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2920919', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'hex_limit_conjunctions_in_disjunction ',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'sql',                      'hex_min_key_parts',                         ' ', '5',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 41,    50,  2,  2, '2570371', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'interuser_plan_sharing_shortcut_enabled',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'inverse_function_optimization',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2392856', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'large_predicate_sampling_threshold',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'limit_join_sampling_result_size',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'lob_memory_threshold',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2220627', 'LOBs',           ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'loop_join_materialization_enabled',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2865990', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'max_join_depth',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'max_number_predicate_term_sampling',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'max_parse_tree_depth',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'sql',                      'max_table_count_in_statement',              ' ', '0',                        '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40, 59.99,  2,  2, '1969700', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 1, 'ALL',         'indexserver.ini',      'sql',                      'multistore_feature_toggle', ' ',   '(multistore_operator,column,all,false)', '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    40,  2,  2, '2816502', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'native_mixed_join_enabled',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'nested_trigger_check_in_ddl_time',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2977828', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'nested_trigger_limit',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2130431', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'no_mat_existing_column',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2771757', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                     'olap_count_distinct_over_huge_table_enabled',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2396894', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                   'plan_cache_auto_recompilation_check_threshold',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                  'plan_cache_auto_recompilation_compare_constant',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_auto_recompilation_enabled',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_auto_recompilation_rate',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_eager_eviction_mode',            ' ', 'off',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    47,  2,  2, '2124112', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                     'plan_cache_eager_eviction_score_based_rate', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',              'plan_cache_eager_eviction_score_based_scan_period', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',            'plan_cache_eager_eviction_time_based_retention_time', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',               'plan_cache_eager_eviction_time_based_scan_period', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_enabled',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_parameter_enabled',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_parameter_for_lob_enabled',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_parameter_sum_threshold',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_parameter_threshold',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_size',                           ' ', '2147483648',               '999999999999',            '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_statistics_enabled',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_trexviadbsl_enabled',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_trexviadbsl_for_join_engine',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_cache_trexviadbsl_for_olap_engine',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'plan_statistics_enabled',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'prefer_cs_itab_in_subquery_for_param_itab', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3235014', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'prefer_multi_column_in_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2165232', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'preferred_routing_cost_threshold',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2518407', 'replication',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'recompile_with_param',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'reload_tables',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127458', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'replica_aware_partition_spec',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3041557', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'reserved_connections',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'reserve_object_name_prefix',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2091256', 'stat. server',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'search_vid_count',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'sql_executors',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'CPU',            ' ' FROM DUMMY UNION ALL /* required because parameter is 'D' -> default for nameserver.ini in system DB */
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'sql_for_dml_partition_as_external_disabled',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2784715', 'partitioning',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'subplan_sharing',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2275220', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'table_size_check',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1969700', 'terminations',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'table_statistics_enabled',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2343579', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'table_statistics_modify_enabled',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'table_statistics_select_enabled',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'trex_update_cache_size',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_cfl_for_esx_expression',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2660294', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_esx_project',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2599949', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_interuser_plan_sharing',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2124112', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_new_placement_scheme_for_replicas',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2381080', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_old_locate_function',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2304091', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql',                      'use_startup_timezone',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1932132', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable_explain_plan',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable_hex_rejection_reason',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable_non_parameterized_query',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable_parameter_values',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'enable_statement_string',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'maxfiles',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',    'sql_plan_decision_recorder', 'maxfilesize',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql_client_network_io',    'enabled',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sql_client_network_io',    'buffer_size',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2119087', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'abapvarcharmode',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2766341', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'allow_nested_call_in_auto_tx_dev',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222219', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'clustering_threshold',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3091143', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'disable_procedure_flattening',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2557912', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'disable_sqlscript_rule_based_checker',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3070374', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'dynamic_sql_ddl_error_level',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2660239', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',    'enable_builtin_procedure_get_objects_in_ddl_statement', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1899222', '',               'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_parallel_block_checker',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3203617', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_procedure_result_cache',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_se_distribution',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2867194', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'MULTI',       'indexserver.ini',      'sqlscript',                'enable_se_distribution_dev',                ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    46,  2,  2, '2893783', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_se_execution_with_gtti_dev',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2527648', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_se_itab_early_release',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3068923', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_se_reuse_preparedstatement',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2949395', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ABAP',        'indexserver.ini',      'sqlscript',                'enable_select_into_scalar_udf',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160814', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_sequential_se_generation',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2721278', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_sql_type_conversion_column',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2824081', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_sudf_result_cache_debug',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',   'enable_strict_type_check_on_sql_type_conversion_column', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2620378', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_trigger_on_v3',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2881485', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_tudf_unfold_input_length_check',     ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 43,    44,  2,  2, '2858499', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_tudf_unfold_output_length_check',    ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 43,    44,  2,  2, '2858499', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'enable_v3_llang_catalog_object',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3232114', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'execution_monitoring_level',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'execution_monitoring_limit',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'ignore_inline_sql_hint',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2923205', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'ignore_length_constraint_check_on_cursor',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'kernel_mode',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2902534', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'monitoring_level',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2088971', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'number_of_calls_to_retain_after_execution', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'procedure result_cache_gc_interval',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'retention_period_for_sqlscript_context',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000002', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'set_rowcount_with_select_statement',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2701826', 'wrong results',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini', 'sqlscript', 'skip_revalidation_and_accept_invalid_procedures_after_startup', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2323112', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI',       'indexserver.ini',      'sqlscript',                'translate_ce_datasource_to_select_stmt',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2174236', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI',       'indexserver.ini',      'sqlscript',                'typecheck_procedure_input_param',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'use_llang_import_for_sudf_on_v3',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3232114', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'sqlscript',                'use_querychecker_for_sqlscript_plan',       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3070374', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'statisticsserver',         'enable_automatic_workload_management',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127247', 'stat. server',   'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'statisticsserver',         'initial_profile',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2127247', 'stat. server',   'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'statisticsserver',         'threadpool',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222250', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'check_data_length_parallel_threshold',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2766786', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'check_max_concurrency',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'check_max_concurrency_percent',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'CPU',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'check_repartitioning_consistency',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    'A' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'table_consistency_check',  'columncheck_parallel_threshold',            ' ', '4000000000',               '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40, 59.04,  2,  2, '2116157', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'table_consistency_check',  'columncheck_parallel_threshold',            ' ', '4000000000',               '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 60,    63,  2,  2, '2116157', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'enable_automatic_unload',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'memory',         'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'enable_full_automatic_unload',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'enable_table_consistency_check_trace',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'internal_check_max_concurrency',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'keypositions_maxsize',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2266533', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'large_job_threshold',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_duration',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_num_large_jobs',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_num_runtimeinfos',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_result_entry',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_result_entry_per_entity',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_trace_file_num',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_trace_file_size',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'max_values_per_result',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'min_errorseverity',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'min_runtime_for_runtimeinfos',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'min_runtime_for_runtimeinfos',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'remote_check_timeout',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_consistency_check',  'rowidpositions_maxsize',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',      'indexserver.ini','table_consistency_check','sparse_suboptimal_compression_ratio_check_consistency',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2116157', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MULTI',       'indexserver.ini',      'table_redist',             'all_moves_physical',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2081591', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'BW,MULTI',    'indexserver.ini',      'table_redist',             'balance_by_execution_count',                ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 40,    -1,  2,  2, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_execution_count_weight',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1899817', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_execution_time',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_execution_time_weight',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1899817', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_memuse',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_part_id',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_partnum',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_rows',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_table_classification',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_table_size_hosted',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'balance_by_table_subclassification',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'debug_export_detail',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2210025', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'enable_2phase_move',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2313619', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 1, 'MULTI',       'indexserver.ini',      'table_redist',             'enable_enhanced_partition_move',            ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 67.01,67.03,2,  2, '3406328', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 1, 'MULTI',       'indexserver.ini',      'table_redist',             'enable_enhanced_partition_move',            ' ', 'false',                    '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 70,    74,  2,  2, '3406328', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'enable_merge',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'enable_repartitioning_with_gcd',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1958216', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'force_partnum_to_splitrule',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2081591', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_redist',             'num_exec_threads',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2081591', 'redistribution', ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'enable_create_runtimedump',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'optimize_replica_for_online_ddl',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2874176', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',   'optimize_replica_for_online_ddl_in_log_replay',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2874176', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'record_count_for_parallel_replay',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3009522', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'replace_legacy_str_by_ostr',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2641642', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'turn_on_request_read_timeout_',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3383819', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'table_replication',        'update_log_table_status',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2673956', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'text',                     'create_ta_with_inverted_individual',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800008', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'text',                     'id_cleanup_thresh',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'threads',                  'async_request_3rd_party',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3202643', 'termination',    ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'threads',                  'default_stack_size_kb',                     ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'threads',                  'poolsize',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'threads',                  'worker_stack_size_kb',                      ' ', '-- SPECIAL --',            '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999997', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'trace',                    'tablereload',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2222217', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'abort_retry_timeout',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2700008', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'transaction',              'aggressive_gc_interval',                    ' ', '300',                      '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'async_rep_sync_with_bitvector',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2966375', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'check_global_trans_consistency',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3508952', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'check_slave_on_master_restart',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3508952', 'consistency',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'ddl_ac_off_partial_abort',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2724087', 'commit',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'enable_runtime_dump_on_deadlock',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'monitoring',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'excessive_version_count_check_interval',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'epoch_manager_interval_in_ms',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2767548', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'gc_interval',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'group_2pc_master_first_prepare_thread',     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2914403', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'hsr_max_idle_interval',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'system rep.',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'idle_cursor_lifetime',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'idle_cursor_alert_timeout',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 3, 'ALL',         'indexserver.ini',      'transaction',              'lock_wait_timeout',                         ' ', '100000',                   '7200000',                 '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1999998', 'performance',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',             'long_running_slave_activity_check_interval', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',            'long_running_slave_activity_rtedump_timeout', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'startup',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'excessive_version_count_check_interval',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',           'long_running_suspended_cursor_check_interval', ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'long_running_tx_activity_rtedump_timeout',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'long_running_tx_check_interval',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2815963', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'max_tid_vector_size',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2355498', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'max_tid_vector_size_for_tid_buffer',        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2355498', 'crash',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'max_versions_per_record_alert_threshold',   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'max_versions_per_table_alert_threshold',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'mincid_table_truncation_interval',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1991599', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'mvcc_aged_checker_timeout',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'num_of_async_rep_queue',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2340450', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'number_versions_alert_threshold',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'orphaned_application_lock_check_interval',  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'parallel_batch_insert_threshold',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'DML',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'replication_log_check_timeout',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'table rep.',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'runtime_dump_on_deadlock_period',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'serializable_transaction_lifetime',         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'suspended_cursor_lifetime',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'table_wise_gc_blocker_lifetime',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'transaction_history_record_limit',          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1910610', 'consistency',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'transaction_history_size_limit',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1910610', 'consistency',    'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'transaction_number_limit',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2154870', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',             'uncommitted_replication_transaction_timeout',' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800055', 'table rep.',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'uncommitted_ostr_transaction_timeout',      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2340450', 'table rep.',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'uncommitted_write_transaction_alert_timeout',' ','-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'uncommitted_write_transaction_lifetime',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2169283', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'transaction',              'write_transaction_lifetime',                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000003', 'garbage coll.',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'indexserver.ini',      'unifiedtable',             'enable_cs_mvcc_bitmap_cache_statistics',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2502256', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'unifiedtable',             'ut_delta_rollover_switch_values',           ' ', '3'                      ,  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', 45,    53,  2,  2, '2940750', 'locks',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'localclient.ini',      'daemon',                   'default_connect_timeout',                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2881668', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'localclient.ini',      'daemon',                   'default_read_timeout',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2881668', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'localclient.ini',      'daemon',                   'default_send_timeout',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2881668', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'multidb.ini',          'readonly_parameters',      '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2036111', 'multitenant',    ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'auditing configuration',   'default_audit_trail_type',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'auditing configuration',   'global_auditing_state',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,  '863362', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'distributed_watchdog',     'interval',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'execution',                'max_concurrency',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'failover',                 'cross_failover_group',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2777234', 'dyn. tiering',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'httpserver',               'embedded',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'httpserver',               'maxthreads',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'httpserver',               'workerpoolsize',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'host_agent_views',         'get_saposcol_hw_conf_data',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2889118', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'host_agent_views',         'get_saposcol_metrics',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2889118', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'host_agent_views',         'get_saposcol_versions',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2889118', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'host_agent_views',         'timeout',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1969700', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'landscape',                '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'local_watchdog',           'interval',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2380176', 'network',        ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'configpath',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'enable',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2430523', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'enable_virtdbhome',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2667806', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'force_interval',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2303938', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'interval',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2303938', ' ',              ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'lmstructurepath',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'profilepath',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3212094', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'sld',                      'xmlpath',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'sql',                      'sql_executors',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2186744', 'multitenant',    'D' FROM DUMMY UNION ALL
    SELECT 2, 'ALL',         'indexserver.ini',      'statisticsserver',         'active',                                    ' ', 'true',                     '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2147247', 'monitoring',     ' ' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'timeout',                  'automatic_rte_dump_delay',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'nameserver',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'timeout',                  'automatic_rte_dump_interval',               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'nameserver',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'MDCSYS',      'nameserver.ini',       'timeout',                  'automatic_rte_dump_marker_file_timeout',    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2400007', 'nameserver',     'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'nameserver.ini',       'topology',                 'size',                                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1977101', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 3, 'MDCSYS',      'preprocessor.ini',     'jobqueue',                 'num_cores',                                 ' ', '-- SPECIAL --',            '-- SPECIAL --',           '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800008', 'CPU',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'preprocessor.ini',     'lexicon',                  'max_annotations',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2800008', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'adapter_framework',        'dq_reference_data_path',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2713209', 'terminations',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'adapter_operation_cache',  'enable_adapter_operation_cache',            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2347571', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'adapter_operation_cache',  'geocode',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2713209', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'adapter_operation_cache',  'geocode_rt',                                ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2713209', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'communication',            'maxchannels',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'communication',            'maxendpoints',                              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2382421', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'scriptserver.ini',     'transaction',              'num_parallel_postcommit_threads',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2746759', '',               ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', '%',                        '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2147247', 'stat. server',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'memorymanager',            'allocationlimit',                           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1929538', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'persistence',              'log_segment_size_mb',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2019148', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'row_engine',               'parallel_query_execution',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000792', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'row_engine',               'parallel_query_execution',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000792', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'sql',                      'use_startup_timezone',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1932132', 'terminations',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ESS',         'statisticsserver.ini', 'statisticsserver_general', 'active',                                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2147247', 'monitoring',     'D' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'statisticsserver_general', 'editing',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2084747', 'stat. server',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'statisticsserver_intervals','interval_purgehistory',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1929538', 'stat. server',   ' ' FROM DUMMY UNION ALL
    SELECT 0, 'SSS',         'statisticsserver.ini', 'statisticsserver_view%',   '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2084747', 'stat. server',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    '%',                        '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1990354', 'configuration',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'icm/http/logging_n',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2201212', 'trace',          ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'icm/http/mod%',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2176128', 'security',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'icm/http/support_http2',                    ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3086998', 'communication',  ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'wdisp/enable_admin_ui_for_sid',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2107899', ' ',              'D' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'wdisp/filter_xs_internal_uri',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1855097', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'wdisp/system_auto_configuration',           ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2360874', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'profile',                  'wdisp/system%',                             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'communication',            'sslkeystore',                               ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2134259', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'webdispatcher.ini',    'communication',            '﻿sslminprotocolversion',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3086998', 'security',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xscontroller.ini',     'communication',            'api_url',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xscontroller.ini',     'communication',            'default_domain',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2245631', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xscontroller.ini',     'communication',            'jdbc_ssl',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2300943', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xscontroller.ini',     'communication',            'jdbc_ssl_validate_certificate',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2300943', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xscontroller.ini',     'communication',            'jdbc_ssl_certificate_hostname',             ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2300943', ' ',              'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'application_container',    'application_list',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2134259', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'communication',            'client_ciphersuites',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2173384', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'communication',            'client_sni_enabled',                        ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2173384', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'communication',            'max_open_sockets_per_request',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2866337', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'customer_usage',           '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2201212', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'debugger',                 'enabled',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2328680', 'terminations',   'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'httpserver',               'developer_mode',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3030464', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'httpserver',               'embedded',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1849775', 'xsengine',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'httpserver',               'enable_ict_eyecatcher',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2398507', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'httpserver',               'max_request_runtime',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159899', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'httpserver',               'sessiontimeout',                            ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159899', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'jsvm',                     'disable_access_check',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1940436', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'jsvm',                     'max_runtime_bytes',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159899', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'jsvm',                     'max_runtime_follow_up',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2159899', 'xsengine',       ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'mds',                      'mds_host_and_port',                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3149235', 'MDS',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'mds',                      'mds_routing_view',                          ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '3149235', 'MDS',            ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'persistence',              'log_segment_size_mb',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2062080', 'backup',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'public_urls',              'http_url',                                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2378150', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'public_urls',              'https_url',                                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2378150', 'network',        'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'row_engine',               'parallel_query_execution',                  ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2000792', 'memory',         ' ' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'scheduler',                'enabled',                                   ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2160230', 'xsengine',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'smtp',                     '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'xsengine',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsengine.ini',         'sql',                      'use_startup_timezone',                      ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '1932132', 'terminations',   ' ' FROM DUMMY UNION ALL 
    SELECT 0, 'ALL',         'xsengine.ini',         'user_self_service',        '%',                                         ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'xsengine',       'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsuaaserver.ini',      'configuration',            'uaa.oidc.enableoidc',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1, '2774359', 'XSA',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsuaaserver.ini',      'configuration',            'uaa.oidc.enablex509',                       ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'XSA',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsuaaserver.ini',      'configuration',            'uaa.oidc.providerdescription',              ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'XSA',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsuaaserver.ini',      'configuration',            'uaa.oidc.providerlinktext',                 ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'XSA',            'A' FROM DUMMY UNION ALL
    SELECT 0, 'ALL',         'xsuaaserver.ini',      'configuration',            'uaa.oidc.providername',                     ' ', '-- no recommendation --',  '-- no recommendation --', '-- no recommendation --', '-- no recommendation --', -1,    -1, -1, -1,        '', 'XSA',            'A' FROM DUMMY
  ) P
),
PARAMETER_INFOS AS
( SELECT
    *
  FROM
    PARAMETER_INFOS_HELPER
  UNION ALL
  SELECT
    P.ENV,
    'nameserver.ini' FILE_NAME,
    P.P,
    P.SECTION,
    P.PARAMETER_NAME,
    P.NOT_1,
    P.MIN_VALUE_1_ORIG,
    P.MIN_VALUE_1,
    P.MAX_VALUE_1,
    P.MIN_VALUE_2,
    P.MAX_VALUE_2,
    P.MIN_REV,
    P.MAX_REV,
    P.MIN_VERS,
    P.MAX_VERS,
    P.SAP_NOTE,
    P.AREA,
    P.TYPE
  FROM
    BASIS_INFO BI,
    PARAMETER_INFOS_HELPER P
  WHERE
    BI.ENV LIKE '%MDCSYS%' AND
    P.FILE_NAME = 'indexserver.ini' AND
    NOT EXISTS ( SELECT * FROM PARAMETER_INFOS_HELPER P2 WHERE P2.FILE_NAME = 'nameserver.ini' AND P2.SECTION = P.SECTION AND P2.PARAMETER_NAME = P.PARAMETER_NAME )
),
PARAMETER_SETTINGS AS
( SELECT 
    HOST,
    FILE_NAME,
    SECTION,
    KEY PARAMETER_NAME,
    CASE
      WHEN KEY = 'plan_cache_eager_eviction_mode' THEN VALUE                 /* parameter has "off" as potential values although not being a Boolean parameter */
      WHEN UPPER(VALUE) IN ('TRUE', 'ON', 'YES') THEN 'true'
      WHEN UPPER(VALUE) IN ('FALSE', 'OFF', 'NO') THEN 'false'
      ELSE VALUE
    END CONFIG_VALUE,
    LAYER_NAME || MAP(LAYER_NAME, 'HOST', CHAR(32) || '(' || HOST || ')', '') CONFIG_LAYER
  FROM 
    M_CONFIGURATION_PARAMETER_VALUES
  UNION
  ( SELECT TOP 1
      HOST,
      FILE_NAME,
      SECTION,
      KEY PARAMETER_NAME,
      CASE
        WHEN UPPER(VALUE) IN ('TRUE', 'ON', 'YES') THEN 'true'
        WHEN UPPER(VALUE) IN ('FALSE', 'OFF', 'NO') THEN 'false'
        ELSE VALUE
      END CONFIG_VALUE,
      LAYER_NAME || MAP(LAYER_NAME, 'HOST', CHAR(32) || '(' || HOST || ')', '') CONFIG_LAYER
    FROM
      M_INIFILE_CONTENTS
    WHERE
      FILE_NAME = 'global.ini' AND
      SECTION = 'resource_tracking' AND
      KEY = 'service_thread_sampling_monitor_enabled'
    ORDER BY
      LAYER_NAME DESC
  )
),
PARAMETERS AS
( SELECT
    HOST,
    FILE_NAME,
    SECTION,
    PARAMETER_NAME,
    PRIORITY,
    CONFIG_VALUE,
    CONFIG_LAYER,
    ENV,
    NOT_1,
    MIN_VALUE_1_ORIG,
    CASE MIN_VALUE_1
      WHEN '-- SPECIAL --' THEN
        CASE PARAMETER_NAME
          WHEN 'allocationlimit'                              THEN CASE WHEN BI.BI_ALLOC_LIM_GB != -1 THEN TO_VARCHAR(TO_DECIMAL(ROUND(TO_BIGINT(BI_ALLOC_LIM_GB) * 1024), 10, 0)) ELSE '-- no recommendation --' END
          WHEN 'cache_max_memory_bytes'                       THEN TO_VARCHAR(TO_DECIMAL(ROUND(BI.ALLOC_LIM_GB * 0.10 * 1024 * 1024 * 1024), 10, 0))
          WHEN 'default_stack_size_kb'                        THEN CASE WHEN BI.ALLOC_LIM_GB > 235 THEN '2048' ELSE '-- no recommendation --' END
          WHEN 'default_statement_concurrency_limit'          THEN TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(8, GREATEST(4, BI.CPU_THREADS * 0.10))), 10, 0))
          WHEN 'gc_unused_memory_threshold_abs'               THEN CASE WHEN BI.ALLOC_LIM_GB > 235 THEN '1' ELSE '-- no recommendation --' END
          WHEN 'gc_unused_memory_threshold_rel'               THEN CASE WHEN BI.ALLOC_LIM_GB > 235 THEN '25' ELSE '-- no recommendation --' END
          WHEN 'max_concurrency' THEN                         
            CASE 
              WHEN CHECK_VERSION = 1 OR CHECK_VERSION = 2 AND CHECK_REVISION <= 29 THEN 
                TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 0.33)), 10, 0))
              WHEN ( CHECK_VERSION >= 3 OR CHECK_VERSION = 2 AND CHECK_REVISION >= 30 ) AND BI_CPU_THREADS != -1 THEN 
                TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS)), 10, 0))
              ELSE '-- no recommendation --'
            END
          WHEN 'max_gc_parallelity'                           THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(2, LEAST(72, BI.CPU_THREADS * 0.50))), 10, 0))
          WHEN 'max_partitions'                               THEN CASE WHEN BI.ALLOC_LIM_GB > 2048 THEN TO_VARCHAR(MAP(BI.NUM_WORKERS, 0, 4, 1, 8, 12)) ELSE '-- no recommendation --' END
          WHEN 'max_partitions_limited_by_locations'          THEN CASE WHEN BI.ALLOC_LIM_GB > 2048 THEN 'false' ELSE '-- no recommendation --' END
          WHEN 'num_cores'                                    THEN
            CASE 
              WHEN SECTION = 'jobqueue' THEN TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(8, GREATEST(4, BI.CPU_THREADS * 0.10))), 10, 0))
              ELSE TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(8, GREATEST(4, BI.CPU_THREADS * 0.10))), 10, 0)) 
            END                 
          WHEN 'parallel_merge_threads'                       THEN CASE WHEN BI.CPU_THREADS >= 50 THEN '5' ELSE '-- no recommendation --' END
          WHEN 'row_order_optimizer_threads'                  THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 0.10)), 10, 0))
          WHEN 'tables_preloaded_in_parallel'                 THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(5, BI.CPU_THREADS * 0.05)), 10, 0))
          WHEN 'statement_memory_limit'                       THEN 
            CASE 
              WHEN CHECK_REVISION >= 60 AND BI.ALLOC_LIM_GB <= 2048 AND CONFIG_VALUE = '-1' THEN '-- no recommendation --' 
              ELSE TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(30, BI.ALLOC_LIM_GB * 0.10)), 10, 0))
            END
          WHEN 'worker_stack_size_kb'                         THEN CASE WHEN BI.ALLOC_LIM_GB > 235 THEN '2048' ELSE '-- no recommendation --' END
          ELSE '-- no recommendation --'
        END
      ELSE
        MIN_VALUE_1
    END MIN_VALUE_1,
    CASE MAX_VALUE_1
      WHEN '-- SPECIAL --' THEN
        CASE PARAMETER_NAME
          WHEN 'cache_max_memory_bytes'                       THEN TO_VARCHAR(TO_DECIMAL(ROUND(BI.ALLOC_LIM_GB * 0.30 * 1024 * 1024 * 1024), 10, 0))
          WHEN 'default_statement_concurrency_limit' THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 0.50)), 10, 0))
          WHEN 'logshipping_max_retention_size' THEN TO_VARCHAR(TO_DECIMAL(BI.LOG_VOL_GB * 0.80 * 1024, 10, 0))
          WHEN 'gc_unused_memory_threshold_abs'               THEN CASE WHEN BI.ALLOC_LIM_GB > 235 THEN TO_VARCHAR(TO_DECIMAL(ROUND(( BI.ALLOC_LIM_GB + BI.PMEM_GB ) * 0.25 * 1024), 10, 0)) ELSE '-- no recommendation --' END
          WHEN 'max_concurrency' THEN
            CASE
              WHEN CHECK_VERSION = 1 OR CHECK_VERSION = 2 AND CHECK_REVISION <= 29 THEN 
                TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 1.00)), 10, 0))
              ELSE '-- no recommendation --'
            END
          WHEN 'max_gc_parallelity'                  THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(2, BI.CPU_THREADS * 0.50)), 10, 0))
          WHEN 'num_cores'                           THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 0.50)), 10, 0))
          WHEN 'parallel_merge_threads'              THEN CASE WHEN BI.CPU_THREADS >= 50 THEN '10' ELSE '-- no recommendation --' END
          WHEN 'row_order_optimizer_threads'         THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(4, BI.CPU_THREADS * 0.25)), 10, 0))
          WHEN 'tables_preloaded_in_parallel'        THEN TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(5, BI.CPU_THREADS * 0.10)), 10, 0))
          WHEN 'statement_memory_limit'                       THEN 
            CASE 
              WHEN BI.ALLOC_LIM_GB <= 2048 AND CHECK_REVISION >= 60 AND CONFIG_VALUE = '-1' THEN '-- no recommendation --' 
              ELSE TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(500, BI.ALLOC_LIM_GB * 0.30)), 10, 0))
            END
        END
      ELSE
        MAX_VALUE_1
    END MAX_VALUE_1,
    MIN_VALUE_2,
    MAX_VALUE_2,
    MIN_VERS,
    MAX_VERS,
    MIN_REV,
    MAX_REV,
    IFNULL(IFNULL(MAP(SAP_NOTE, '', NULL, SAP_NOTE), MAP(SAP_NOTE_FALLBACK, '', NULL, SAP_NOTE_FALLBACK)), ' ') SAP_NOTE,
    IFNULL(IFNULL(AREA, AREA_FALLBACK), ' ') AREA,
    IFNULL(IFNULL(TYPE, TYPE_FALLBACK), ' ') TYPE
  FROM
  ( SELECT
      IFNULL(PS.FILE_NAME, PI.FILE_NAME) FILE_NAME,
      IFNULL(PS.SECTION, PI.SECTION) SECTION,
      IFNULL(PS.PARAMETER_NAME, PI.PARAMETER_NAME) PARAMETER_NAME,
      IFNULL(PS.CONFIG_VALUE, '-- not set --') CONFIG_VALUE,
      IFNULL(PS.CONFIG_LAYER, '-- not set --') CONFIG_LAYER,
      IFNULL(PI.P, 0) PRIORITY,
      IFNULL(PI.ENV, 'ALL') ENV,
      IFNULL(PI.NOT_1, ' ') NOT_1,
      MIN_VALUE_1_ORIG,
      IFNULL(PI.MIN_VALUE_1, '-- no recommendation --') MIN_VALUE_1,
      IFNULL(PI.MAX_VALUE_1, '-- no recommendation --') MAX_VALUE_1,
      IFNULL(PI.MIN_VALUE_2, '-- no recommendation --') MIN_VALUE_2,
      IFNULL(PI.MAX_VALUE_2, '-- no recommendation --') MAX_VALUE_2,
      IFNULL(PI.MIN_VERS, -1) MIN_VERS,
      IFNULL(PI.MAX_VERS, -1) MAX_VERS,
      IFNULL(PI.MIN_REV, -1) MIN_REV,
      IFNULL(PI.MAX_REV, -1) MAX_REV,
      PS.HOST,
      PI.SAP_NOTE,
      PI.AREA,
      PI.TYPE,
      BI.ENV BI_ENV,
      ( SELECT MAX(SAP_NOTE) FROM PARAMETER_INFOS PI2 WHERE ( PI2.SECTION != '%' OR PI2.PARAMETER_NAME != '%' ) AND PS.SECTION LIKE PI2.SECTION AND PS.PARAMETER_NAME LIKE PI2.PARAMETER_NAME ) SAP_NOTE_FALLBACK,
      ( SELECT MAX(AREA)     FROM PARAMETER_INFOS PI2 WHERE ( PI2.SECTION != '%' OR PI2.PARAMETER_NAME != '%' ) AND PS.SECTION LIKE PI2.SECTION AND PS.PARAMETER_NAME LIKE PI2.PARAMETER_NAME ) AREA_FALLBACK,
      ( SELECT MAX(TYPE)     FROM PARAMETER_INFOS PI2 WHERE ( PI2.SECTION != '%' OR PI2.PARAMETER_NAME != '%' ) AND PS.SECTION LIKE PI2.SECTION AND PS.PARAMETER_NAME LIKE PI2.PARAMETER_NAME ) TYPE_FALLBACK
    FROM
      BASIS_INFO BI,
      PARAMETER_INFOS PI FULL OUTER JOIN
      PARAMETER_SETTINGS PS ON
        PS.FILE_NAME = PI.FILE_NAME AND
        PS.SECTION = PI.SECTION AND
        PS.PARAMETER_NAME = PI.PARAMETER_NAME
  ),
  ( SELECT CHECK_VERSION, CHECK_REVISION, BI_CPU_THREADS, ALLOC_LIM_GB, BI_ALLOC_LIM_GB, CPU_FREQUENCY_MHZ, CPU_THREADS, NUM_WORKERS, LOG_VOL_GB, PMEM_GB FROM BASIS_INFO ) BI
),
PARAMETER_RECOMMENDATIONS AS
( SELECT
    P.HOST,
    P.FILE_NAME,
    P.SECTION,
    P.PARAMETER_NAME,
    P.PRIORITY,
    P.MIN_VALUE_1_ORIG,
    P.MIN_VALUE_1,
    P.MAX_VALUE_1,
    P.CONFIG_VALUE,
    CASE WHEN NOT_1 = 'X' THEN 'do not set to' || CHAR(32) ELSE '' END ||
      P.MIN_VALUE_1 || MAP(P.MAX_VALUE_1, '-- no recommendation --', '', P.MIN_VALUE_1, '', '999999999999', ' or higher', ' to ' || P.MAX_VALUE_1) ||
      CASE WHEN P.MIN_VALUE_2 != '-- no recommendation --' OR P.MAX_VALUE_2 != '-- no recommendation --' THEN
        ' or' || CHAR(32) || P.MIN_VALUE_2 || MAP(P.MAX_VALUE_2, '-- no recommendation --', '', P.MIN_VALUE_2, '', '999999999999', ' or higher', ' to ' || P.MAX_VALUE_2) ELSE ''
      END RECOMMENDED_VALUE,
    P.SAP_NOTE,
    P.AREA,
    P.CONFIG_LAYER,
    CASE WHEN
    ( ( P.MIN_VALUE_1 = '-- no recommendation --' AND
        P.MAX_VALUE_1 = '-- no recommendation --' 
      ) OR
      ( P.MIN_VALUE_1 = '-- individual value --' AND 
        P.CONFIG_VALUE != '-- not set --' 
      ) OR
      ( P.MIN_VALUE_1 != '-- individual value --' AND 
        P.PARAMETER_NAME NOT IN ( 'auto_merge_decision_func', 'critical_merge_decision_func' ) AND
        ( ( NOT_1 = ' ' AND
            ( P.MAX_VALUE_1 = '-- no recommendation --' AND LPAD(P.CONFIG_VALUE, 1000) = LPAD(P.MIN_VALUE_1, 1000) OR
              P.MAX_VALUE_1 != '-- no recommendation --' AND LPAD(P.CONFIG_VALUE, 1000) BETWEEN LPAD(P.MIN_VALUE_1, 1000) AND LPAD(P.MAX_VALUE_1, 1000)
            )
          ) OR
          ( NOT_1 = 'X' AND
            ( P.MAX_VALUE_1 = '-- no recommendation --' AND LPAD(P.CONFIG_VALUE, 1000) != LPAD(P.MIN_VALUE_1, 1000) OR
              P.MAX_VALUE_1 != '-- no recommendation --' AND LPAD(P.CONFIG_VALUE, 1000) NOT BETWEEN LPAD(P.MIN_VALUE_1, 1000) AND LPAD(P.MAX_VALUE_1, 1000)
            )
          )
        )
      ) OR
      ( P.MAX_VALUE_2 = '-- no recommendation --' AND 
        LPAD(P.CONFIG_VALUE, 1000) = LPAD(P.MIN_VALUE_2, 1000)
      ) OR
      ( P.MAX_VALUE_2 != '-- no recommendation --' AND 
        LPAD(P.CONFIG_VALUE, 1000) BETWEEN LPAD(P.MIN_VALUE_2, 1000) AND LPAD(P.MAX_VALUE_2, 1000)
      )
    ) AND NOT        /* Make sure that columns with integer recommendations only have integer values and nothing else like '21 GB', '40 to 80' or '12,00' */
    ( ( P.MIN_VALUE_1 LIKE_REGEXPR '^[0-9]+$' OR P.MIN_VALUE_1 = '-- SPECIAL --' ) AND
        P.CONFIG_VALUE NOT LIKE_REGEXPR '^[0-9]+$'
    )
    THEN 'X' ELSE ' ' END SET_CORRECTLY
  FROM
    BASIS_INFO BI,
    PARAMETERS P
  WHERE
  NOT ( BI.ENV LIKE '%MDCSYS%' AND      /* avoid recommendations in system DB, but mention wrong existing settings */
        ( P.CONFIG_VALUE = '-- not set --' OR P.CONFIG_LAYER = 'DEFAULT' ) AND
        ( P.FILE_NAME NOT IN ( 'daemon.ini', 'global.ini', 'nameserver.ini', 'preprocessor.ini' ) OR
          P.PARAMETER_NAME NOT IN ( 'active', 'async_request', 'default_statement_concurrency_limit', 'enable_tracking', 'environment', 'hex_enable_distributed_query_processing', 
                                    'max_table_count_in_statement', 'memory_tracking',  'num_cores', 'plan_cache_eager_eviction_mode', 'service_thread_sampling_monitor_enabled', 
                                    'sslsessioncachemode', 'statement_memory_limit', 'stop_async_gc_in_shutdown', 'tcp_backlog' )
        )
      ) AND
  NOT ( BI.ENV LIKE '%MDCTEN%' AND P.FILE_NAME IN ('preprocessor.ini', 'nameserver.ini') AND P.CONFIG_VALUE = '-- not set --' ) AND     /* avoid nameserver and preprocessor recommendations in tenant DB, but mention wrong existing settings */
  ( ( P.ENV = 'ALL' OR
      ( ( LOCATE(P.ENV, 'ABAP')   > 0 AND LOCATE(BI.ENV, 'ABAP')   > 0 ) OR
        ( LOCATE(P.ENV, 'AUD')    > 0 AND LOCATE(BI.ENV, 'AUD')    > 0 ) OR
        ( LOCATE(P.ENV, 'BPC')    > 0 AND LOCATE(BI.ENV, 'BPC')    > 0 ) OR
        ( LOCATE(P.ENV, 'BW')     > 0 AND LOCATE(BI.ENV, 'BW')     > 0 ) OR
        ( LOCATE(P.ENV, 'CRM')    > 0 AND LOCATE(BI.ENV, 'CRM')    > 0 ) OR
        ( LOCATE(P.ENV, 'ERP')    > 0 AND LOCATE(BI.ENV, 'ERP')    > 0 AND ( P.SECTION != 'table_placement' OR LOCATE(BI.ENV, 'BW') = 0 ) ) OR      /* table_placement precedence for BW over ERP */
        ( LOCATE(P.ENV, 'ESS')    > 0 AND LOCATE(BI.ENV, 'ESS')    > 0 ) OR
        ( LOCATE(P.ENV, 'EWM')    > 0 AND LOCATE(BI.ENV, 'EWM')    > 0 ) OR
        ( LOCATE(P.ENV, 'FRA')    > 0 AND LOCATE(BI.ENV, 'FRA')    > 0 ) OR
        ( LOCATE(P.ENV, 'IQ')     > 0 AND LOCATE(BI.ENV, 'IQ')     > 0 ) OR
        ( LOCATE(P.ENV, 'LCACHE') > 0 AND LOCATE(BI.ENV, 'LCACHE') > 0 ) OR
        ( LOCATE(P.ENV, 'MDCSYS') > 0 AND LOCATE(BI.ENV, 'MDCSYS') > 0 ) OR
        ( LOCATE(P.ENV, 'MDCTEN') > 0 AND LOCATE(BI.ENV, 'MDCTEN') > 0 ) OR
        ( LOCATE(P.ENV, 'MDS')    > 0 AND LOCATE(BI.ENV, 'MDS')    > 0 ) OR
        ( LOCATE(P.ENV, 'MULTI')  > 0 AND LOCATE(BI.ENV, 'MULTI')  > 0 ) OR
        ( LOCATE(P.ENV, 'PORTAL') > 0 AND LOCATE(BI.ENV, 'PORTAL') > 0 ) OR
        ( LOCATE(P.ENV, 'PROD')   > 0 AND LOCATE(BI.ENV, 'PROD')   > 0 ) OR
        ( LOCATE(P.ENV, 'S4')     > 0 AND LOCATE(BI.ENV, 'S4')     > 0 ) OR
        ( LOCATE(P.ENV, 'SCM')    > 0 AND LOCATE(BI.ENV, 'SCM')    > 0 ) OR
        ( LOCATE(P.ENV, 'SDA')    > 0 AND LOCATE(BI.ENV, 'SDA')    > 0 ) OR
        ( LOCATE(P.ENV, 'SF')     > 0 AND LOCATE(BI.ENV, 'SF')     > 0 ) OR
        ( LOCATE(P.ENV, 'SINGLE') > 0 AND LOCATE(BI.ENV, 'SINGLE') > 0 ) OR
        ( LOCATE(P.ENV, 'SRM')    > 0 AND LOCATE(BI.ENV, 'SRM')    > 0 ) OR
        ( LOCATE(P.ENV, 'SSS')    > 0 AND LOCATE(BI.ENV, 'SSS')    > 0 ) OR
        ( LOCATE(P.ENV, 'STDBY')  > 0 AND LOCATE(BI.ENV, 'STDBY')  > 0 ) OR
        ( LOCATE(P.ENV, 'SYSREP') > 0 AND LOCATE(BI.ENV, 'SYSREP') > 0 ) OR
        ( LOCATE(P.ENV, 'XFS')    > 0 AND LOCATE(BI.ENV, 'XFS')    > 0 )
      ) AND NOT
      ( ( LOCATE(P.ENV, 'ABAP')   > 0 AND LOCATE(BI.ENV, 'ABAP')   = 0 ) OR
        ( LOCATE(P.ENV, 'AUD')    > 0 AND LOCATE(BI.ENV, 'AUD')    = 0 ) OR
        ( LOCATE(P.ENV, 'BPC')    > 0 AND LOCATE(BI.ENV, 'BPC')    = 0 ) OR
        ( LOCATE(P.ENV, 'BW')     > 0 AND LOCATE(BI.ENV, 'BW')     = 0 ) OR
        ( LOCATE(P.ENV, 'CRM')    > 0 AND LOCATE(BI.ENV, 'CRM')    = 0 ) OR
        ( LOCATE(P.ENV, 'ERP')    > 0 AND LOCATE(BI.ENV, 'ERP')    = 0 ) OR
        ( LOCATE(P.ENV, 'ESS')    > 0 AND LOCATE(BI.ENV, 'ESS')    = 0 ) OR
        ( LOCATE(P.ENV, 'EWM')    > 0 AND LOCATE(BI.ENV, 'EWM')    = 0 ) OR
        ( LOCATE(P.ENV, 'FRA')    > 0 AND LOCATE(BI.ENV, 'FRA')    = 0 ) OR
        ( LOCATE(P.ENV, 'IQ')     > 0 AND LOCATE(BI.ENV, 'IQ')     = 0 ) OR
        ( LOCATE(P.ENV, 'LCACHE') > 0 AND LOCATE(BI.ENV, 'LCACHE') = 0 ) OR
        ( LOCATE(P.ENV, 'MDCSYS') > 0 AND LOCATE(BI.ENV, 'MDCSYS') = 0 ) OR
        ( LOCATE(P.ENV, 'MDCTEN') > 0 AND LOCATE(BI.ENV, 'MDCTEN') = 0 ) OR
        ( LOCATE(P.ENV, 'MDS')    > 0 AND LOCATE(BI.ENV, 'MDS')    = 0 ) OR
        ( LOCATE(P.ENV, 'MULTI')  > 0 AND LOCATE(BI.ENV, 'MULTI')  = 0 ) OR
        ( LOCATE(P.ENV, 'PORTAL') > 0 AND LOCATE(BI.ENV, 'PORTAL') = 0 ) OR
        ( LOCATE(P.ENV, 'PROD')   > 0 AND LOCATE(BI.ENV, 'PROD')   = 0 ) OR
        ( LOCATE(P.ENV, 'S4')     > 0 AND LOCATE(BI.ENV, 'S4')     > 0 ) OR
        ( LOCATE(P.ENV, 'SCM')    > 0 AND LOCATE(BI.ENV, 'SCM')    = 0 ) OR
        ( LOCATE(P.ENV, 'SDA')    > 0 AND LOCATE(BI.ENV, 'SDA')    = 0 ) OR
        ( LOCATE(P.ENV, 'SF')     > 0 AND LOCATE(BI.ENV, 'SF')     > 0 ) OR
        ( LOCATE(P.ENV, 'SINGLE') > 0 AND LOCATE(BI.ENV, 'SINGLE') = 0 ) OR
        ( LOCATE(P.ENV, 'SRM')    > 0 AND LOCATE(BI.ENV, 'SRM')    = 0 ) OR
        ( LOCATE(P.ENV, 'SSS')    > 0 AND LOCATE(BI.ENV, 'SSS')    = 0 ) OR
        ( LOCATE(P.ENV, 'STDBY')  > 0 AND LOCATE(BI.ENV, 'STDBY')  = 0 ) OR
        ( LOCATE(P.ENV, 'SYSREP') > 0 AND LOCATE(BI.ENV, 'SYSREP') = 0 ) OR
        ( LOCATE(P.ENV, 'XFS')    > 0 AND LOCATE(BI.ENV, 'XFS')    = 0 )
      ) 
    ) AND
    LPAD(TO_DECIMAL(BI.CHECK_VERSION, 10, 2), 10, '0') || LPAD(TO_DECIMAL(BI.CHECK_REVISION, 10, 2), 10, '0') BETWEEN
      LPAD(TO_DECIMAL(MAP(P.MIN_VERS, -1, 0, P.MIN_VERS), 10, 2), 10, '0') || LPAD(TO_DECIMAL(MAP(P.MIN_REV, -1, 0, P.MIN_REV), 10, 2), 10, '0') AND
      LPAD(TO_DECIMAL(MAP(P.MAX_VERS, -1, 99999, P.MAX_VERS), 10, 2), 10, '0') || LPAD(TO_DECIMAL(MAP(P.MAX_REV, -1, 99999, P.MAX_REV), 10, 2), 10, '0') AND
    P.MIN_VALUE_1 != '-- no recommendation --'
  )
)
SELECT
  FILE_NAME,
  SECTION,
  PARAMETER_NAME,
  P,
  CONFIG_VALUE CONFIGURED_VALUE,
  RECOMMENDED_VALUE,
  MAX(SAP_NOTE) SAP_NOTE,
  CONFIG_LAYER,
  IMPLEMENTATION_COMMAND,
  UNDO_COMMAND
FROM
( SELECT
    10 LINE_NO,
    'Evaluation time:' FILE_NAME,
    TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') SECTION,
    '' PARAMETER_NAME,
    '' P,
    '' CONFIG_VALUE,
    '' RECOMMENDED_VALUE,
    '' SAP_NOTE,
    '' CONFIG_LAYER,
    '' IMPLEMENTATION_COMMAND,
    '' UNDO_COMMAND
  FROM
    DUMMY
  UNION ALL 
  ( SELECT 
      14, 
      'Statement version:',
      '2.00.040+ / 4.0.56 (2024/06/17)',
      '', '', '', '', '', '', '', ''
    FROM
      DUMMY
  )    
  UNION ALL 
  ( SELECT 
      15, 
      'SAP Note:',
      '2600030',
      '', '', '', '', '', '', '', ''
    FROM
      DUMMY
  )    
  UNION ALL
  ( SELECT
      20,
      'Revision:',
      TO_VARCHAR(CHECK_VERSION) || '.00.' || LPAD(ROUND(TO_DECIMAL(CHECK_REVISION, 5, 0)), 3, '0') || MAP(CHECK_REVISION, FLOOR(CHECK_REVISION), '', '.' || LPAD((CHECK_REVISION - FLOOR(CHECK_REVISION)) * 100, 2, '0'))  || 
        CASE WHEN BI_VERSION = -1 AND BI_REVISION = -1 THEN '' ELSE CHAR(32) || '(manual)' END,
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO
  )
  UNION ALL
  ( SELECT
      25,
      'SID / database / host:',
      SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME || CHAR(32) || '/' || CHAR(32) || HOST,
      '', '', '', '', '', '', '', ''
    FROM
      M_DATABASE
  )
  UNION ALL
  ( SELECT
      30, 
      'Environment:',
      ENV,
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      31,
      'CPU threads:',
      TO_VARCHAR(CPU_THREADS) || MAP(BI_CPU_THREADS, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      31.2,
      'CPU frequency (MHz):',
      TO_VARCHAR(CPU_FREQUENCY_MHZ) || MAP(BI_CPU_FREQUENCY_MHZ, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      31.5,
      'NUMA nodes:',
      TO_VARCHAR(NUMA_NODES) || MAP(BI_NUMA_NODES, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO
  )
  UNION ALL
  ( SELECT
      32,
      'Alloc. lim. (GB):',
      TO_VARCHAR(ALLOC_LIM_GB) || MAP(BI_ALLOC_LIM_GB, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      33,
      'Worker nodes:',
      TO_VARCHAR(NUM_WORKERS) || MAP(BI_NUM_WORKERS, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      34,
      'Log volume size (GB):',
      TO_VARCHAR(TO_DECIMAL(ROUND(LOG_VOL_GB), 10, 0)) || MAP(BI_LOG_VOL_GB, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO  
  )
  UNION ALL
  ( SELECT
      35,
      'Used PMEM size (GB):',
      TO_VARCHAR(TO_DECIMAL(ROUND(PMEM_GB), 10, 0)) || MAP(BI_PMEM_GB, -1, '', CHAR(32) || '(manual)'),
      '', '', '', '', '', '', '', ''
    FROM
      BASIS_INFO
  )
  UNION ALL
  ( SELECT 40, '', '', '', '', '', '', '', '', '', '' FROM DUMMY )
  UNION ALL
  ( SELECT DISTINCT
      MAX(LINE_NO) LINE_NO,
      FILE_NAME,
      SECTION,
      PARAMETER_NAME,
      MAP(RECOMMENDED_VALUE, '-- check why set --', '', MAP(PRIORITY, 0, '', TO_VARCHAR(PRIORITY))) P,
      CONFIG_VALUE CONFIGURED_VALUE,
      CASE WHEN RECOMMENDED_VALUE IN ('true', 'false') AND MIN_VALUE_1_ORIG != '-- SPECIAL --' THEN MIN_VALUE_1_ORIG ELSE RECOMMENDED_VALUE END RECOMMENDED_VALUE,
      MAX(SAP_NOTE) SAP_NOTE,
      CONFIG_LAYER,
      IMPLEMENTATION_COMMAND,
      UNDO_COMMAND
    FROM
    ( SELECT
        ROW_NUMBER () OVER (ORDER BY MAP(RECOMMENDED_VALUE, '-- check why set --', 1, 0), FILE_NAME, SECTION, PARAMETER_NAME) + 100 LINE_NO,
        FILE_NAME,
        SECTION,
        PARAMETER_NAME,
        PRIORITY,
        CONFIG_VALUE,
        MIN_VALUE_1_ORIG,
        RECOMMENDED_VALUE,
        SAP_NOTE,
        CONFIG_LAYER,
        IMPLEMENTATION_COMMAND,
        UNDO_COMMAND
      FROM
      ( SELECT DISTINCT
          FILE_NAME,
          SECTION,
          PARAMETER_NAME,
          PRIORITY,
          MAP(MAX_VALUE_LENGTH, -1, CONFIG_VALUE, SUBSTR(CONFIG_VALUE, 1, MAX_VALUE_LENGTH)) CONFIG_VALUE,
          MIN_VALUE_1_ORIG,
          MAP(MAX_VALUE_LENGTH, -1, MAP(RECOMMENDED_VALUE, '-- no recommendation --', '-- check why set --', RECOMMENDED_VALUE), SUBSTR(MAP(RECOMMENDED_VALUE, '-- no recommendation --', '-- check why set --', RECOMMENDED_VALUE), 1, MAX_VALUE_LENGTH)) ||
            MAP(SUGGESTED_VALUE, '', '', CHAR(32) || '[' || SUGGESTED_VALUE || ']') RECOMMENDED_VALUE,
          SAP_NOTE,
          CONFIG_LAYER,
          'ALTER SYSTEM ALTER CONFIGURATION (' || CHAR(39) || FILE_NAME || CHAR(39) || ',' || CHAR(32) || CHAR(39) || 
            CASE
              WHEN SECTION = 'daemon' AND PARAMETER_NAME = 'environment' AND RECOMMENDED_VALUE = 'HDB_MEMORY_CACHE=d' THEN CHAR(32) || '''HOST'', ''<host>'') SET (''daemon'', ''environment'') = ''HDB_MEMORY_CACHE=d'' WITH RECONFIGURE' || CHAR(59)
              WHEN SECTION = 'daemon' AND PARAMETER_NAME = 'environment' AND CONFIG_VALUE = 'HDB_MEMORY_CACHE=d' AND RECOMMENDED_VALUE = '-- no recommendation --' THEN CHAR(32) || '''HOST'', ''<host>'') UNSET (''daemon'', ''environment'') WITH RECONFIGURE' || CHAR(59)
              ELSE
                MAP(CONFIG_LAYER, 
                  'DEFAULT', 'SYSTEM', 
                  'DATABASE', 'DATABASE',
                  'SYSTEM', 'SYSTEM', 
                  '', 'SYSTEM', 
                  '-- not set --', 'SYSTEM', 
                  'HOST' || CHAR(39) || ',' || CHAR(32) || CHAR(39) || HOST) || 
                CHAR(39) || ')' || CHAR(32) ||
                MAP(RECOMMENDED_VALUE, '-- no recommendation --', 'UN', '') || 'SET (' || CHAR(39) || SECTION || CHAR(39) || ',' || CHAR(32) ||
                CHAR(39) || PARAMETER_NAME || CHAR(39) || ')' ||
                MAP(RECOMMENDED_VALUE, '-- no recommendation --', '', CHAR(32) || '=' || CHAR(32) || CHAR(39) || 
                CASE
                  WHEN SUGGESTED_VALUE != '' THEN SUGGESTED_VALUE
                  WHEN RECOMMENDED_VALUE IN ('true', 'false') AND MIN_VALUE_1_ORIG != '-- SPECIAL --' THEN MIN_VALUE_1_ORIG
                  WHEN PARAMETER_NAME = 'smart_merge_decision_func' THEN RECOMMENDED_VALUE
                  WHEN RECOMMENDED_VALUE LIKE '% to %' THEN SUBSTR(RECOMMENDED_VALUE, 1, LOCATE(RECOMMENDED_VALUE, ' to ') - 1) 
                  WHEN RECOMMENDED_VALUE LIKE '% or %' THEN SUBSTR(RECOMMENDED_VALUE, 1, LOCATE(RECOMMENDED_VALUE, ' or ') - 1) 
                  ELSE RECOMMENDED_VALUE 
                END || 
                CHAR(39)) || ' WITH RECONFIGURE COMMENT' || CHAR(32) || CHAR(39) || 'SAP Note 2600030.' || CHAR(32) ||
                MAP(RECOMMENDED_VALUE, '-- no recommendation --', 'Unset unless required.', 'Revert when pre-conditions are no longer fulfilled.') || CHAR(39) || CHAR(59)
            END IMPLEMENTATION_COMMAND,
          'ALTER SYSTEM ALTER CONFIGURATION (' || CHAR(39) || FILE_NAME || CHAR(39) || ',' || CHAR(32) || CHAR(39) || 
            CASE
              WHEN SECTION = 'daemon' AND PARAMETER_NAME = 'environment' AND CONFIG_VALUE = 'HDB_MEMORY_CACHE=d' AND RECOMMENDED_VALUE = '-- no recommendation --'  THEN CHAR(32) || '''HOST'', ''<host>'') SET (''daemon'', ''environment'') = ''HDB_MEMORY_CACHE=d'' WITH RECONFIGURE' || CHAR(59)
              WHEN SECTION = 'daemon' AND PARAMETER_NAME = 'environment' AND RECOMMENDED_VALUE = 'HDB_MEMORY_CACHE=d' THEN CHAR(32) || '''HOST'', ''<host>'') UNSET (''daemon'', ''environment'') WITH RECONFIGURE' || CHAR(59)
              ELSE
                MAP(CONFIG_LAYER, 
                  'DEFAULT', 'SYSTEM', 
                  'DATABASE', 'DATABASE',
                  'SYSTEM', 'SYSTEM', 
                  '', 'SYSTEM', 
                  '-- not set --', 'SYSTEM', 
                  'HOST' || CHAR(39) || ',' || CHAR(32) || CHAR(39) || HOST) || 
                CHAR(39) || ')' || CHAR(32) ||
                MAP(RECOMMENDED_VALUE, '-- no recommendation --', '', 'UN') || 'SET (' || CHAR(39) || SECTION || CHAR(39) || ',' || CHAR(32) ||
                CHAR(39) || PARAMETER_NAME || CHAR(39) || ')' ||
                MAP(RECOMMENDED_VALUE, '-- no recommendation --', CHAR(32) || '=' || CHAR(32) || CHAR(39) || CONFIG_VALUE || CHAR(39), '') || ' WITH RECONFIGURE' || CHAR(59) 
            END UNDO_COMMAND
        FROM
        ( SELECT /* Parameters deviating from existing recommendation */
            PR.HOST,
            PR.FILE_NAME,
            PR.SECTION,
            PR.PARAMETER_NAME,
            PR.MIN_VALUE_1_ORIG,
            PR.CONFIG_VALUE,
            PR.RECOMMENDED_VALUE,
            CASE
              WHEN PR.MIN_VALUE_1    = PR.MAX_VALUE_1                   THEN ''
              WHEN PR.PARAMETER_NAME = 'gc_unused_memory_threshold_abs' THEN PR.MAX_VALUE_1
              WHEN PR.PARAMETER_NAME = 'huge_alignment_cache_target'    THEN '10240'
              WHEN PR.PARAMETER_NAME = 'load_monitor_granularity'       THEN '10000'
              WHEN PR.PARAMETER_NAME = 'lock_wait_timeout'              THEN '3600000'
              WHEN PR.PARAMETER_NAME = 'log_backup_timeout'             THEN '900'
              WHEN PR.PARAMETER_NAME = 'log_buffer_count'               THEN '16'
              WHEN PR.PARAMETER_NAME = 'log_buffer_size_kb'             THEN '2048'
              WHEN PR.PARAMETER_NAME = 'logshipping_max_retention_size' THEN PR.MAX_VALUE_1
              WHEN PR.PARAMETER_NAME = 'parallel_merge_threads'         THEN PR.MIN_VALUE_1
              WHEN PR.PARAMETER_NAME = 'plan_cache_size'                THEN PR.MIN_VALUE_1
              WHEN PR.PARAMETER_NAME = 'row_order_optimizer_threads'    THEN PR.MIN_VALUE_1
              WHEN PR.PARAMETER_NAME = 'savepoint_interval_s'           THEN '900'
              WHEN PR.PARAMETER_NAME = 'tables_preloaded_in_parallel'   THEN PR.MIN_VALUE_1
              WHEN PR.PARAMETER_NAME = 'threshold_duration'             THEN '5000000'
              WHEN PR.PARAMETER_NAME = 'tcp_backlog'                    THEN '4096'
              WHEN PR.PARAMETER_NAME = 'statement_memory_limit' THEN
                CASE
                  WHEN LOCATE(BI.ENV, 'SF') > 0 THEN PR.MIN_VALUE_1                                                    /* SFSF: minimum */
                  WHEN ( LOCATE(BI.ENV, 'ERP') > 0 OR LOCATE(BI.ENV, 'EWM') > 0 OR LOCATE(BI.ENV, 'MDCSYS') > 0 OR LOCATE(BI.ENV, 'S4') > 0 OR LOCATE(BI.ENV, 'SCM') > 0 OR 
                       LOCATE(BI.ENV, 'SF') > 0 OR LOCATE(BI.ENV, 'SRM') > 0 ) THEN 
                         TO_VARCHAR(TO_DECIMAL(( PR.MIN_VALUE_1 * 2 + PR.MAX_VALUE_1) / 3 , 10, 0))                    /* OLTP: towards minimum */             
                  WHEN LOCATE(BI.ENV, 'BW') > 0 THEN PR.MAX_VALUE_1                                                    /* OLAP: maximum */
                  ELSE TO_VARCHAR(TO_DECIMAL(( PR.MIN_VALUE_1 + PR.MAX_VALUE_1 ) / 2, 10, 0))                          /* else: average */
                END
              WHEN PR.PARAMETER_NAME IN ( 'default_statement_concurrency_limit', 'num_cores' ) THEN
                CASE
                  WHEN ( LOCATE(BI.ENV, 'ERP') > 0 OR LOCATE(BI.ENV, 'EWM') > 0 OR LOCATE(BI.ENV, 'MDCSYS') > 0 OR LOCATE(BI.ENV, 'S4') > 0 OR LOCATE(BI.ENV, 'SCM') > 0 OR 
                       LOCATE(BI.ENV, 'SF') > 0 OR LOCATE(BI.ENV, 'SRM') > 0 ) THEN PR.MIN_VALUE_1                     /* OLTP: minimum */
                  WHEN LOCATE(BI.ENV, 'BW') > 0 THEN PR.MAX_VALUE_1                                                    /* OLAP: maximum */
                  ELSE TO_VARCHAR(TO_DECIMAL(( PR.MIN_VALUE_1 + PR.MAX_VALUE_1 ) / 2, 10, 0))                          /* else: average */
                END
              ELSE ''
            END SUGGESTED_VALUE,
            PR.PRIORITY,
            PR.SAP_NOTE,
            PR.AREA,
            PR.CONFIG_LAYER,
            BI.MAX_VALUE_LENGTH
          FROM
            BASIS_INFO BI,
            PARAMETER_RECOMMENDATIONS PR
          WHERE
            BI.CHECK_VERSION < '4' AND             /* no explicit set recommendations for SAP HANA Cloud */
            PR.FILE_NAME LIKE BI.FILE_NAME AND
            PR.SECTION LIKE BI.SECTION AND
            PR.PARAMETER_NAME LIKE BI.PARAMETER_NAME AND
            PR.SET_CORRECTLY = ' ' AND
            NOT ( BI.ENV LIKE '%MDCSYS%' AND PR.FILE_NAME = 'indexserver.ini' AND PR.PARAMETER_NAME = 'max_table_count_in_statement' )
          UNION ALL
          SELECT /* Parameters being set although there is no general recommendation */
            P.HOST,
            P.FILE_NAME,
            P.SECTION,
            P.PARAMETER_NAME,
            P.MIN_VALUE_1_ORIG,
            P.CONFIG_VALUE,
            '-- no recommendation --' RECOMMENDED_VALUE,
            '' SUGGESTED_VALUE,
            P.PRIORITY,
            P.SAP_NOTE,
            P.AREA,
            P.CONFIG_LAYER,
            BI.MAX_VALUE_LENGTH
          FROM
            BASIS_INFO BI,
            PARAMETERS P
          WHERE
            P.FILE_NAME LIKE BI.FILE_NAME AND
            P.SECTION LIKE BI.SECTION AND
            P.PARAMETER_NAME LIKE BI.PARAMETER_NAME AND 
            P.CONFIG_VALUE != '-- not set --' AND
            P.CONFIG_LAYER != 'DEFAULT' AND
            ( BI.EXCLUDE_DEFAULT_MODIFICATIONS = ' ' OR 
              P.TYPE != 'D'
            ) AND
            ( BI.EXCLUDE_ADMINISTRATIVE_MODIFICATIONS = ' ' OR 
              P.TYPE != 'A' 
            ) AND
            ( BI.EXCLUDE_SECURITY_MODIFICATIONS = ' ' OR
              P.TYPE != 'S'
            ) AND
            ( BI.EXCLUDE_WEBDISPATCHER = ' ' OR
              P.FILE_NAME NOT IN ('webdispatcher.ini', 'webdispatcher...')
            ) AND
            ( BI.EXCLUDE_XSA = ' ' OR
              P.FILE_NAME NOT IN ( 'xscontroller.ini', 'xsexecagent.ini', 'xsuaaserver.ini' )
            ) AND
            NOT ( BI.ENV LIKE '%MDCSYS%' AND P.FILE_NAME = 'nameserver.ini' AND P.PARAMETER_NAME = 'poolsize' ) AND
            NOT EXISTS ( SELECT 1 FROM PARAMETER_RECOMMENDATIONS PR WHERE PR.FILE_NAME = P.FILE_NAME AND PR.SECTION = P.SECTION AND PR.PARAMETER_NAME = P.PARAMETER_NAME )
        )
      )
    )
    GROUP BY
      FILE_NAME,
      SECTION,
      PARAMETER_NAME,
      PRIORITY,
      MIN_VALUE_1_ORIG,
      CONFIG_VALUE,
      RECOMMENDED_VALUE,
      CONFIG_LAYER,
      IMPLEMENTATION_COMMAND,
      UNDO_COMMAND
  )
)
GROUP BY
  FILE_NAME,
  SECTION,
  PARAMETER_NAME,
  P,
  CONFIG_VALUE,
  RECOMMENDED_VALUE,
  CONFIG_LAYER,
  IMPLEMENTATION_COMMAND,
  UNDO_COMMAND
ORDER BY
  MIN(LINE_NO)
WITH HINT (IGNORE_PLAN_CACHE, OPTIMIZATION_LEVEL(RULE_BASED), NO_HEURISTIC_REORDERING)