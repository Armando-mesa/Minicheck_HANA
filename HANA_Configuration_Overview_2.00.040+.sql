SELECT
/* 

[NAME]

- HANA_Configuration_Overview_2.00.040+

[DESCRIPTION]

- General information

[DETAILS AND RESTRICTIONS]

- WORKLOAD_CLASSES and WORKLOAD_MAPPINGS only available as of Revision 1.00.100
- M_RESULT_CACHE only available as of Rev. 1.00.110
- STATEMENT_HINTS available as of Rev. 1.00.122.02
- M_ENCRYPTION_OVERVIEW available starting with 2.00.000
- M_DYNAMIC_RESULT_CACHE available starting with 2.00.020
- M_MULTIDIMENSIONAL_STATEMENT_STATISTICS available with SAP HANA >= 2.00.024.01
- M_CS_TABLES.PERSISTENT_MEMORY and M_PERSISTENT_MEMORY_VOLUMES available with SAP HANA >= 2.00.030
- TABLES.LOAD_UNIT (NSE) available with SAP HANA >= 2.00.040

[SOURCE]

- SAP Note 1969700

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2014/03/31:  1.0 (initial version)
- 2014/05/30:  1.1 (moved parts to other commands like HANA_Configuration_MiniChecks or HANA_Hosts*)
- 2014/09/05:  1.2 (several feature checks added)
- 2014/09/27:  1.3 (SAP_NOTES added)
- 2015/05/20:  1.4 (dedicated Rev90+ version created)
- 2016/02/19:  1.5 (dedicated Rev100+ version created)
- 2016/06/29:  1.6 (dedicated Rev110+ version created)
- 2017/04/04:  1.7 (dedicated 1.00.122.02+ version created)
- 2017/07/20:  1.8 (dedicated 2.00.020+ version created)
- 2018/04/09:  1.9 (M_ENCRYPTION_OVERVIEW considered)
- 2018/11/03:  2.0 (dedicated 2.00.024.01+ version)
- 2018/12/01:  2.1 (section "INSTALLED PRODUCTS:" added)
- 2019/03/16:  2.2 (dedicated 2.00.030+ version)
- 2019/07/02:  2.3 (dedicated 2.00.040+ version)
- 2019/11/03:  2.4 (ABAP kernel version added)
- 2020/05/05:  2.5 (fuzzy search indexes added)
- 2020/05/06:  2.6 (data volume partitioning added)
- 2021/05/10:  2.7 (extension node added)
- 2022/08/17:  2.8 (data statistics added)

[INVOLVED TABLES]

- various

[INPUT PARAMETERS]

[OUTPUT PARAMETERS]

- NAME:      Name of information and check
- VALUE:     Related value
- SAP_NOTES: Related SAP Note numbers

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------------------------
|NAME                                     |VALUE                                        |SAP_NOTES                         |
----------------------------------------------------------------------------------------------------------------------------
|GENERAL INFORMATION:                     |                                             |                                  |
|                                         |                                             |                                  |
|Database type                            |SAP HANA                                     |2000003                           |
|Evaluation time                          |2014/09/27 12:18:27                          |                                  |
|Evaluation user                          |SAPPRD                                       |                                  |
|OS user                                  |prdadm (80384) (8 hosts)                     |                                  |
|SAP database users                       |SAPHANA01                                    |                                  |
|                                         |SAPPRD                                       |                                  |
|SAP database schemas                     |SAPHANA01                                    |                                  |
|                                         |SAPPRD                                       |                                  |
|                                         |SAP_HANA_ADMIN                               |                                  |
|                                         |SAP_XS_LM                                    |                                  |
|Startup time                             |2014/09/13 13:00:14                          |                                  |
|                                         |2014/09/13 13:00:25 (saphana0032)            |                                  |
|                                         |2014/09/13 13:00:16 (saphana0033)            |                                  |
|                                         |2014/09/13 13:00:15 (saphana0034)            |                                  |
|                                         |2014/09/13 13:00:15 (saphana0035)            |                                  |
|                                         |2014/09/13 13:00:15 (saphana0041)            |                                  |
|                                         |2014/09/13 13:00:14 (saphana0042)            |                                  |
|                                         |2014/09/13 13:00:14 (saphana0043)            |                                  |
|                                         |2014/09/13 13:00:14 (saphana0044)            |                                  |
|Database name                            |P06                                          |                                  |
|Instance name                            |P06                                          |                                  |
|Instance number                          |00                                           |                                  |
|Distributed system                       |yes (8 hosts)                                |                                  |
|Everything started                       |yes                                          |                                  |
|Version                                  |1.00.74.02.392316 (NewDB100_REL)             |                                  |
|Support package stack                    |SPS 07                                       |                                  |
|Number of hosts                          |8                                            |                                  |
|Host role                                |MASTER   (saphana0032)                       |                                  |
|                                         |SLAVE    (saphana0033)                       |                                  |
|                                         |SLAVE    (saphana0034)                       |                                  |
|                                         |SLAVE    (saphana0041)                       |                                  |
|                                         |SLAVE    (saphana0042)                       |                                  |
|                                         |SLAVE    (saphana0043)                       |                                  |
|                                         |SLAVE    (saphana0044)                       |                                  |
|                                         |STANDBY  (saphana0035)                       |                                  |
|Host directory                           |/usr/sap/P06/HDB00/saphana0032/ (saphana0032)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0033/ (saphana0033)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0034/ (saphana0034)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0035/ (saphana0035)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0041/ (saphana0041)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0042/ (saphana0042)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0043/ (saphana0043)|                                  |
|                                         |/usr/sap/P06/HDB00/saphana0044/ (saphana0044)|                                  |
|Timezone                                 |CEST (8 hosts)                               |                                  |
|                                         |                                             |                                  |
|PATCH HISTORY:                           |                                             |                                  |
|                                         |                                             |                                  |
|2014/08/09 11:33:12                      |1.00.74.02.392316                            |                                  |
|2014/03/15 09:11:31                      |1.00.72.00.388670                            |                                  |
|2014/02/15 12:58:30                      |1.00.69.385196                               |                                  |
|                                         |                                             |                                  |
|FEATURE AND CONFIGURATION INFORMATION:   |                                             |                                  |
|                                         |                                             |                                  |
|Database log mode                        |normal      (default)                        |1642148                           |
|Automatic log backup                     |yes         (default)                        |1642148                           |
|Query result cache                       |no          (default)                        |2014148                           |
|Global auditing state                    |false       (default)                        |1991634                           |
|Self-signed certificates                 |false       (default)                        |1891055                           |
|Hostname resolution for default route    |ip          (default)                        |1906381                           |
|Mountpoint usage for data and log volumes|yes         (default)                        |1809453, 1820553                  |
|Client distribution mode                 |statement   (default)                        |1743225, 1745057, 1774187, 1785171|
|Parallel mode                            |Auto        (default)                        |2036111                           |
|Parallelism of table preload             |5           (default)                        |2036111                           |
|Table preload during startup             |true        (default)                        |1889081                           |
|Embedded statistics server active        |false       (default)                        |1917938                           |
|Standalone statistics server active      |true        (default)                        |2036111                           |
|Listen interface                         |.global                                      |1999797                           |
|                                         |                                             |                                  |
|SPACE INFORMATION:                       |                                             |                                  |
|                                         |                                             |                                  |
|Database size on disk (GB)               |      1746.19                                |                                  |
|Data backup size (GB)                    |      1726.41                                |                                  |
|Row store size total (GB)                |       212.10 (saphana0032)                  |                                  |
|Column store size total (GB)             |      1213.39                                |                                  |
|Row store tables                         |      2488 (SAP schema:   2246)              |                                  |
|Column store tables                      |     70566 (SAP schema:  70400)              |                                  |
----------------------------------------------------------------------------------------------------------------------------

*/

  NAME,
  VALUE,
  SAP_NOTES
FROM
( SELECT
    100 LINE_NO,
    'GENERAL INFORMATION:' NAME,
    ' ' VALUE,
    ' ' SAP_NOTES
  FROM
    DUMMY
  UNION ALL
  SELECT
    190,
    ' ',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT TOP 1
    192,
    'Attention:',
    'Connected to secondary system replication site!',
    '1999880'
  FROM
    M_CONFIGURATION_PARAMETER_VALUES
  WHERE
    SECTION = 'system_replication' AND
    KEY = 'actual_mode' AND
    VALUE != 'primary'
  UNION ALL
  SELECT TOP 1
    193,
    '',
    '',
    ''
  FROM
    M_CONFIGURATION_PARAMETER_VALUES
  WHERE
    SECTION = 'system_replication' AND
    KEY = 'actual_mode' AND
    VALUE != 'primary'
  UNION ALL
  SELECT
    200,
    'Database type',
    'SAP HANA',
    '2000003'
  FROM
    DUMMY
  UNION ALL
  SELECT
    250,
    'Version',
    SUBSTR(VALUE, 1, 3),
    '2115815'
  FROM
    M_SYSTEM_OVERVIEW
  WHERE
    SECTION = 'System' AND
    NAME = 'Version'
  UNION ALL
  SELECT
    300,
    'Support package stack',
    'SPS' || CHAR(32) || LPAD(CASE
      WHEN VERSION LIKE '1%' AND REVISION BETWEEN  45 AND  59 THEN 5
      WHEN VERSION LIKE '1%' AND REVISION BETWEEN  28 AND  44 THEN 4
      WHEN VERSION LIKE '1%' AND REVISION BETWEEN  20 AND  27 THEN 3
      WHEN VERSION LIKE '1%' AND REVISION BETWEEN  12 AND  19 THEN 2
      WHEN VERSION LIKE '1%' AND REVISION BETWEEN   1 AND  11 THEN 1
      ELSE FLOOR(REVISION / 10)
    END, 2, '0'),
    '2115815'
  FROM
  ( SELECT
      SUBSTR(VALUE, 1, 4) VERSION,
      SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) REVISION 
    FROM 
      M_SYSTEM_OVERVIEW 
    WHERE 
      SECTION = 'System' AND 
      NAME = 'Version' 
   )
  UNION ALL
  SELECT
    400,
    'Revision',
    VALUE,
    '2115815'
  FROM
    M_SYSTEM_OVERVIEW
  WHERE
    SECTION = 'System' AND
    NAME = 'Version'
  UNION ALL
  SELECT
    450 + ROWNO,
    MAP(ROWNO, 1, 'ABAP kernel version', ''),
    ABAP_KERNEL || CHAR(32) || '(' || NUM_CONNECTIONS || CHAR(32) || 'connection' || MAP(NUM_CONNECTIONS, 1, '', 's') || ')',
    '19466'
  FROM
  ( SELECT
      VALUE ABAP_KERNEL,
      COUNT(*) NUM_CONNECTIONS,
      ROW_NUMBER () OVER (ORDER BY VALUE) ROWNO
    FROM
      M_SESSION_CONTEXT
    WHERE
      KEY = 'APPLICATIONVERSION' AND
      VALUE LIKE '___ PL %'
    GROUP BY
      VALUE
  )
  UNION ALL
  SELECT
    500,
    'System ID',
    SYSTEM_ID,
    ''
  FROM
    M_DATABASE
  UNION ALL
  SELECT
    600,
    'Database name',
    DATABASE_NAME,
    ' '
  FROM
    M_DATABASE
  UNION ALL
  SELECT
    700,
    'Instance number',
    VALUE,
    ' '
  FROM
    M_SYSTEM_OVERVIEW
  WHERE
    SECTION = 'System' AND
    NAME = 'Instance Number'
  UNION ALL
  SELECT
    750,
    'System usage',
    USAGE,
    ' '
  FROM
    M_DATABASE
  UNION ALL
  SELECT
    800,
    'Evaluation time',
    TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'),
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    900,
    'Evaluation user',
    CURRENT_USER,
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    1000 + ROW_NUMBER () OVER (ORDER BY VALUE),
    'OS user',
    VALUE || ' (' || COUNT(*) || ' host' || CASE WHEN COUNT(*) = 1 THEN '' ELSE 's' END || ')',
    ' '
  FROM
    M_HOST_INFORMATION
  WHERE
    KEY = 'os_user'
  GROUP BY
    VALUE
  UNION ALL
  SELECT
    1100 + ROW_NUMBER () OVER (ORDER BY NUM_TABLES DESC) / 1000,
    MAP(ROW_NUMBER () OVER (ORDER BY NUM_TABLES DESC), 1, 'Database schemas with >= 1 GB', ' '),
    IFNULL(SCHEMA_NAME || CHAR(32) || '(' || TO_DECIMAL(ROUND(DISK_GB), 10, 0) || CHAR(32) || 'GB,' || CHAR(32) || NUM_TABLES || CHAR(32) || 'tables)', 'none'),
    ' '
  FROM
    DUMMY LEFT OUTER JOIN
  ( SELECT
      SCHEMA_NAME,
      COUNT(*) NUM_TABLES,
      SUM(DISK_SIZE) / 1024 / 1024 / 1024 DISK_GB
    FROM
      M_TABLE_PERSISTENCE_STATISTICS
    GROUP BY
      SCHEMA_NAME
    HAVING
      SUM(DISK_SIZE) >= 1073741824
  ) ON
  1 = 1
  UNION ALL
  SELECT
    1200,
    'Startup time',
    TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'),
    '2177064'
  FROM
    M_DATABASE
  UNION ALL
  SELECT
    1300 + ROW_NUMBER () OVER (ORDER BY HOST),
    ' ',
    TO_VARCHAR(TO_TIMESTAMP(SUBSTR(VALUE, 1, 19), 'YYYY-MM-DD HH24:MI:SS'), 'YYYY/MM/DD HH24:MI:SS') || ' (' || HOST || ')',
    '2177064'
  FROM
    M_HOST_INFORMATION
  WHERE
    KEY = 'start_time'
  UNION ALL
  SELECT
    1400,
    'Distributed system',
    LOWER(VALUE),
    ' '
  FROM
    M_SYSTEM_OVERVIEW
  WHERE
    SECTION = 'System' AND
    NAME = 'Distributed'
  UNION ALL
  SELECT
    1500,
    'Multitenant',
    CASE P.DB_TYPE
      WHEN 'singledb' THEN 'no'
      WHEN 'multidb' THEN MAP(D.DATABASE_NAME, 'SYSTEMDB', 'yes (SystemDB)', 'yes (TenantDB)')
    END,
    '2101244'
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
  UNION ALL
  SELECT
    1600,
    'Everything started',
    LOWER(VALUE),
    ' '
  FROM
    M_SYSTEM_OVERVIEW
  WHERE
    SECTION = 'Services' AND
    NAME = 'All Started'
  UNION ALL
  SELECT
    1700,
    'Number of hosts with active DB services',
    TO_VARCHAR(COUNT (DISTINCT HOST)),
    ' '
  FROM
    M_SERVICES
  UNION ALL
  SELECT
    1800 + ROW_NUMBER () OVER (ORDER BY INDEXSERVER_ACTUAL_ROLE, HOST),
    MAP(ROW_NUMBER () OVER (ORDER BY INDEXSERVER_ACTUAL_ROLE, HOST), 1, 'Indexserver role', ' '),
    RPAD(INDEXSERVER_ACTUAL_ROLE, 8) || ' (' || HOST || ')',
    ' '
  FROM
    M_LANDSCAPE_HOST_CONFIGURATION
  UNION ALL
  SELECT
    1850 + ROW_NUMBER () OVER (ORDER BY HOST_ACTUAL_ROLES, HOST),
    MAP(ROW_NUMBER () OVER (ORDER BY HOST_ACTUAL_ROLES, HOST), 1, 'Host role', ' '),
    RPAD(HOST_ACTUAL_ROLES, GREATEST(8, LENGTH(HOST_ACTUAL_ROLES))) || ' (' || HOST || ')',
    ' '
  FROM
    M_LANDSCAPE_HOST_CONFIGURATION
  UNION ALL
  SELECT
    1900 + ROW_NUMBER () OVER (ORDER BY HOST),
    MAP(ROW_NUMBER () OVER (ORDER BY HOST), 1, 'Host directory', ' '),
    VALUE || ' (' || HOST || ')',
    ' '
  FROM
    M_HOST_INFORMATION
  WHERE
    KEY = 'sap_retrieval_path'
  UNION ALL
  SELECT
    2000 + ROW_NUMBER () OVER (ORDER BY VALUE),
    'Timezone',
    VALUE || ' (' || COUNT(*) || ' host' || CASE WHEN COUNT(*) = 1 THEN '' ELSE 's' END || ')',
    ' '
  FROM
    M_HOST_INFORMATION
  WHERE
    KEY = 'timezone_name'
  GROUP BY
    VALUE
  UNION ALL
  SELECT
    2100,
    'NUMA nodes',
    TO_VARCHAR(MAX(NUM)),
    '2100040'
  FROM
  ( SELECT
      COUNT(DISTINCT(NUMA_NODE_ID)) NUM
    FROM
      M_NUMA_NODES
    GROUP BY
      HOST,
      PORT
  )
  UNION ALL
  SELECT
    2110,
    ' ',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2115,
    'INSTALLED PRODUCTS:',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2120,
    ' ',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2125 + ROW_NUMBER () OVER (ORDER BY PRODUCT_NAME, PRODUCT_VERSION),
    PRODUCT_NAME,
    LTRIM(PRODUCT_VERSION),
    ' '
  FROM
  ( SELECT /* Execution of "/hana/shared/<SID>/hdblcm/hdblcm -action=update_component_list" may be required for up-to-date information */
      COMPONENT_NAME PRODUCT_NAME,
      VERSION || MAP(VERSION_SP, '', '', '.' || VERSION_SP || MAP(VERSION_PATCH, '', '', '.' || VERSION_PATCH)) PRODUCT_VERSION 
    FROM
      LCM_SOFTWARE_COMPONENTS
    WHERE
      COMPONENT_NAME != 'HDB'
    UNION
    SELECT
      PRODUCT_NAME,
      VERSION || MAP(SP_STACK_DESCRIPTION, '', '', CHAR(32) || SP_STACK_DESCRIPTION) PRODUCT_VERSION
    FROM
      LCM_PRODUCTS
    WHERE
      PRODUCT_NAME != 'SAP NEWDB'
    UNION
    SELECT
      MAP(PLUGIN_NAME, 'LCAPPS', 'LCAPPS_TECH', PLUGIN_NAME),
      VALUE
    FROM
      M_PLUGIN_MANIFESTS
    WHERE
    ( PLUGIN_NAME = 'LCAPPS' AND KEY = 'LCAPPS technical version' OR
      PLUGIN_NAME NOT IN ( 'LCAPPS', 'AFL' ) AND KEY = 'fullversion'
    )
  )
  UNION ALL
  SELECT
    2170,
    ' ',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2180,
    'PATCH HISTORY:',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2190,
    ' ',
    ' ',
    ' '
  FROM
    DUMMY
  UNION ALL
  SELECT
    2200 + ROW_NUMBER () OVER (ORDER BY INSTALL_TIME DESC),
    TO_VARCHAR(INSTALL_TIME, 'YYYY/MM/DD HH24:MI:SS'),
    VERSION,
    ' '
  FROM
    M_DATABASE_HISTORY
  UNION ALL
  SELECT
    2270,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    2280,
    'FEATURE AND CONFIGURATION INFORMATION:',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
   2290,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    2300 + ROW_NUMBER () OVER (ORDER BY REPLICATION_PATH DESC),
    MAP(ROW_NUMBER () OVER (ORDER BY REPLICATION_PATH DESC), 1, 'System replication', ' '),
    IFNULL(REPLICATION_PATH, 'no'),
    '1999880'
  FROM
  ( SELECT DISTINCT
      REPLICATION_MODE || ' (' || SITE_NAME || ' -> ' || SECONDARY_SITE_NAME || ')' REPLICATION_PATH
    FROM
      DUMMY LEFT OUTER JOIN
      M_SYSTEM_REPLICATION ON
        1 = 1
  )
  UNION ALL
  ( SELECT
      2350,
      'Operation mode',
      STRING_AGG(OPERATION_MODE, ', ' ORDER BY OPERATION_MODE),
      '1999880'
    FROM
    ( SELECT DISTINCT
        OPERATION_MODE
      FROM
        M_SYSTEM_REPLICATION
    )
  )
  UNION ALL
  ( SELECT
      2355,
      'Extension nodes',
      TO_VARCHAR(COUNT(*)),
      '2415279'
    FROM
      M_LANDSCAPE_HOST_CONFIGURATION
    WHERE
      WORKER_ACTUAL_GROUPS LIKE '%worker_dt%'
  )
  UNION ALL
  ( SELECT
      2360 + ROW_NUMBER() OVER (ORDER BY PROVIDER_NAME, PROVIDER_COMPANY),
      MAP(ROW_NUMBER() OVER (ORDER BY PROVIDER_NAME, PROVIDER_COMPANY), 1, 'HA/DR providers', ''),
      IFNULL(PROVIDER_NAME || CHAR(32) || '(' || PROVIDER_COMPANY || ')', 'no'),
      ''
    FROM
      DUMMY LEFT OUTER JOIN
      M_HA_DR_PROVIDERS ON
        1 = 1
  )
  UNION ALL
  SELECT
    2400,
    'liveCache',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2593571'
  FROM
    M_LIVECACHE_CONTAINER_STATISTICS
  UNION ALL
  SELECT
    2500,
    'Activated audit policies',
    TO_VARCHAR(COUNT(*)),
    '2159014'
  FROM
    AUDIT_POLICIES
  WHERE
    IS_AUDIT_POLICY_ACTIVE = 'TRUE'
  UNION ALL
  SELECT
    2600,
    'Users with individual statement memory limit',
    TO_VARCHAR(COUNT(*)),
    '1999997'
  FROM
    USER_PARAMETERS
  WHERE
    PARAMETER = 'STATEMENT MEMORY LIMIT'
  UNION ALL
  SELECT
    2700,
    'Sequences',
    TO_VARCHAR(TOTAL_SEQUENCES) || MAP(TOTAL_SEQUENCES, 0, '', MAP(SLT_SEQUENCES, 0, '',
      ' (SLT:' || CHAR(32) || SLT_SEQUENCES || ')')) VALUE,
    '2600095'
  FROM
  ( SELECT
      COUNT(*) TOTAL_SEQUENCES,
      SUM(MAP(SUBSTR(SEQUENCE_NAME, 1, 12), 'SEQ_/1CADMC/', 1, 0)) SLT_SEQUENCES
    FROM
      SEQUENCES
    WHERE
      SCHEMA_NAME NOT IN ('SYS', 'SYSTEM')
  )
  UNION ALL
  SELECT
    2800,
    'Triggers',
    TO_VARCHAR(TOTAL_TRIGGERS) || MAP(TOTAL_TRIGGERS, 0, '', MAP(INTERNAL_TRIGGERS, 0, '',
      CHAR(32) || '(' || INTERNAL_TRIGGERS || CHAR(32) || 'internal)')) VALUE,
    '2800020'
  FROM
  ( SELECT
      COUNT(*) TOTAL_TRIGGERS,
      SUM(CASE WHEN OWNER_NAME IN ('_SYS_STATISTICS', '_SYS_SECURITY') THEN 1 ELSE 0 END) INTERNAL_TRIGGERS
    FROM
      TRIGGERS
    WHERE
      OWNER_NAME NOT IN ('SYS', 'SYSTEM')
  )
  UNION ALL
  SELECT
    2850,
    'Referential constraints',
    TO_VARCHAR(TOTAL_REF_CONSTRAINTS) || MAP(INTERNAL_REF_CONSTRAINTS, 0, '', CHAR(32) || '(' || INTERNAL_REF_CONSTRAINTS || CHAR(32) || 'internal)'),
    ''
  FROM
  ( SELECT
      COUNT(DISTINCT(CONSTRAINT_NAME)) TOTAL_REF_CONSTRAINTS
    FROM
      REFERENTIAL_CONSTRAINTS
  ),
  ( SELECT
      COUNT(DISTINCT(CONSTRAINT_NAME)) INTERNAL_REF_CONSTRAINTS
    FROM
      REFERENTIAL_CONSTRAINTS
    WHERE
      SCHEMA_NAME IN ('SYS', 'SYSTEM', '_SYS_STATISTICS')
  )
  UNION ALL
  SELECT
    2900,
    'Fulltext indexes',
    TO_VARCHAR(COUNT(*)),
    '2800008'
  FROM
    FULLTEXT_INDEXES
  WHERE
    SCHEMA_NAME != '_SYS_REPO'
  UNION ALL
  SELECT
    2902,
    'Fuzzy search indexes',
    TO_VARCHAR(COUNT(*)),
    '2800008'
  FROM
    M_FUZZY_SEARCH_INDEXES
  WHERE
    SCHEMA_NAME != '_SYS_REPO'
  UNION ALL
  SELECT
    2908,
    'Document store collections',
    TO_VARCHAR(COUNT(*)),
    '2477204'
  FROM
    TABLES
  WHERE
    TABLE_TYPE = 'COLLECTION'
  UNION ALL
  SELECT
    2910,
    'Text analysis tables',
    TO_VARCHAR(COUNT(*)),
    '2800008'
  FROM
    TABLES
  WHERE
    SUBSTR(TABLE_NAME, 1, 4) = '$TA_'
  UNION ALL
  SELECT
    2911,
    'Text mining tables',
    TO_VARCHAR(COUNT(*)),
    '2800008'
  FROM
    TABLES
  WHERE
    SUBSTR(TABLE_NAME, 1, 4) = '$TM_'
  UNION ALL
  SELECT
    2915,
    'Persistent memory (PMEM) configured',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2700084'
  FROM
    M_PERSISTENT_MEMORY_VOLUMES
  WHERE
    FILESYSTEM_TYPE != 'tmpfs'
  UNION ALL
  SELECT
    2916,
    'Fast restart option (FRO) configured',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2700084'
  FROM
    M_PERSISTENT_MEMORY_VOLUMES
  WHERE
    FILESYSTEM_TYPE = 'tmpfs'
  UNION ALL
  SELECT
    2920,
    'Tables / partitions using PMEM or FRO',
    TO_VARCHAR(COUNT(*)),
    '2700084'
  FROM
    M_CS_TABLES
  WHERE
    PERSISTENT_MEMORY = 'TRUE'
  UNION ALL
  SELECT
    3000,
    'Inverted hash indexes',
    TO_VARCHAR(NUM_INDEXES) || MAP(NUM_INTERNAL, 0, '', CHAR(32) || '(' || NUM_INTERNAL || CHAR(32) || 'internal)'),
    '2109355'
  FROM
  ( SELECT
      COUNT(*) NUM_INDEXES,
      IFNULL(SUM(CASE WHEN SCHEMA_NAME IN ('SYS', 'SYSTEM') OR SUBSTR(SCHEMA_NAME, 1, 5) = '_SYS_' THEN 1 ELSE 0 END), 0) NUM_INTERNAL
    FROM
      INDEXES
    WHERE
      INDEX_TYPE LIKE 'INVERTED HASH%'
  )
  UNION ALL
  SELECT
    3010,
    'Inverted individual indexes',
    TO_VARCHAR(NUM_INDEXES) || MAP(NUM_INTERNAL, 0, '', CHAR(32) || '(' || NUM_INTERNAL || CHAR(32) || 'internal)'),
    '2600076'
  FROM
  ( SELECT
      COUNT(*) NUM_INDEXES,
      IFNULL(SUM(CASE WHEN SCHEMA_NAME IN ('SYS', 'SYSTEM') OR SUBSTR(SCHEMA_NAME, 1, 5) = '_SYS_' THEN 1 ELSE 0 END), 0) NUM_INTERNAL
    FROM
      INDEXES
    WHERE
      INDEX_TYPE LIKE 'INVERTED INDIVIDUAL%'
  )
  UNION ALL
  SELECT
    3100,
    'Columns with explicit preload flag',
    TO_VARCHAR(COUNT(*)),
    '2127458'
  FROM
    TABLE_COLUMNS
  WHERE
    PRELOAD = 'TRUE'
  UNION ALL
  SELECT
    3210,
    'Tables with explicit unused retention period',
    TO_VARCHAR(COUNT(DISTINCT(SCHEMA_NAME || TABLE_NAME))),
    '2127458'
  FROM
    M_CS_TABLES
  WHERE
    UNUSED_RETENTION_PERIOD > 0
  UNION ALL
  SELECT
    3300,
    'History tables',
    TO_VARCHAR(COUNT(*)),
    '1910610'
  FROM
    TABLES
  WHERE
    SESSION_TYPE = 'HISTORY'
  UNION ALL
  SELECT
    3310,
    'System-versioned tables',
    TO_VARCHAR(COUNT(*)),
    '3055510'
  FROM
    TEMPORAL_TABLES
  WHERE
    PERIOD_NAME = 'SYSTEM_TIME'
  UNION ALL
  SELECT
    3320,
    'Application-time period tables',
    TO_VARCHAR(COUNT(*)),
    ''
  FROM
    TEMPORAL_TABLES
  WHERE
    PERIOD_NAME = 'APPLICATION_TIME'
  UNION ALL
  SELECT
    3400,
    'Virtual tables',
    TO_VARCHAR(COUNT(*)),
    '2180119'
  FROM
    TABLES
  WHERE
    TABLE_TYPE = 'VIRTUAL'
  UNION ALL
  SELECT
    3410,
    'Series tables',
    TO_VARCHAR(COUNT(*)),
    ''
  FROM
    SERIES_TABLES
  UNION ALL
  SELECT
    3500,
    'Packed LOBs',
    TO_VARCHAR(IFNULL(SUM(L.LOB_COUNT), 0)),
    '2220627'
  FROM
    M_HOST_RESOURCE_UTILIZATION H,
    M_TABLE_LOB_STATISTICS L
  WHERE
    H.HOST = L.HOST AND
    L.CONTAINER_ID IS NOT NULL
  UNION ALL
  SELECT
    3600,
    'Smart Data Access (SDA)',
    MAP(TOTAL, 0, 'no', TOTAL || CHAR(32) || 'source' || MAP(TOTAL, 1, '', 's') || MAP(SR, 0, '', CHAR(32) || '(' || SR || CHAR(32) || 'system replication)')),
    '2180119'
  FROM
  ( SELECT
      COUNT(*) TOTAL,
      SUM(MAP(SUBSTR(REMOTE_SOURCE_NAME, 1, 13), '_SYS_SR_SITE_', 1, 0)) SR
    FROM
      REMOTE_SOURCES
  )
  UNION ALL
  SELECT
    3700,
    'Smart Data Integration (SDI)',
    MAP(NUM_DPSERVERS, 0, 'no', 'yes' || CHAR(32) || '(' || NUM_AGENTS || CHAR(32) || 'agent' || MAP(NUM_AGENTS, 1, '', 's') || ')'),
    '2400022'
  FROM
  ( SELECT COUNT(*) NUM_DPSERVERS FROM M_SERVICES WHERE SERVICE_NAME = 'dpserver' ),
  ( SELECT COUNT(*) NUM_AGENTS FROM M_AGENTS )
  UNION ALL
  SELECT
    3800,
    'Smart Data Streaming (SDS)',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2367236'
  FROM
    M_STREAMING_SERVICES
  UNION ALL
  SELECT
    3900,
    'Dynamic Tiering',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2140959'
  FROM
    M_SERVICES
  WHERE
    SERVICE_NAME = 'esserver'
  UNION ALL
  SELECT
    3905,
    'Multi-dimensional Expressions (MDX)',
    MAP(COUNT(*), 0, 'no', 'yes'),
    ''
  FROM
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES
  WHERE
    UPPER(THREAD_DETAIL) LIKE 'MDX%'
  UNION ALL
  SELECT
    3910,
    'Multi-dimensional Services (MDS)',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2670064'
  FROM
    M_MULTIDIMENSIONAL_STATEMENT_STATISTICS
  UNION ALL
  SELECT
    3950,
    'Data volume partitioning',
    CASE WHEN MAX(PARTITION_COUNT) = 1 THEN 'no' ELSE 'yes (' || MAX(PARTITION_COUNT) || CHAR(32) || 'partitions)' END,
    '2400005'
  FROM
    M_DATA_VOLUME_STATISTICS
  UNION ALL
  SELECT
    3980,
    'Data aging',
    MAP(COUNT, 0, 'no', 'yes' || CHAR(32) || '(' || COUNT || CHAR(32) || 'tables)'),
    '2416490'
  FROM
  ( SELECT
      COUNT(DISTINCT(SCHEMA_NAME || TABLE_NAME)) COUNT
    FROM
    ( SELECT
        T.SCHEMA_NAME,
        T.TABLE_NAME
      FROM
        TABLES T LEFT OUTER JOIN
        PARTITIONED_TABLES PT ON
          T.SCHEMA_NAME = PT.SCHEMA_NAME AND
          T.TABLE_NAME = PT.TABLE_NAME
      WHERE
        T.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION, '') LIKE '%DATAAGING%'
      UNION
      SELECT
        P.SCHEMA_NAME,
        P.TABLE_NAME
      FROM
        TABLES T,
        PARTITIONED_TABLES PT,
        TABLE_PARTITIONS P
      WHERE
        T.SCHEMA_NAME = PT.SCHEMA_NAME AND
        T.TABLE_NAME = PT.TABLE_NAME AND
        T.SCHEMA_NAME = P.SCHEMA_NAME AND
        T.TABLE_NAME = P.TABLE_NAME AND
        P.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION,'') LIKE '%DATAAGING%'
      UNION
      SELECT
        TC.SCHEMA_NAME,
        TC.TABLE_NAME
      FROM
        TABLES T,
        TABLE_COLUMNS TC LEFT OUTER JOIN
        PARTITIONED_TABLES PT ON
          TC.SCHEMA_NAME = PT.SCHEMA_NAME AND
          TC.TABLE_NAME = PT.TABLE_NAME
      WHERE
        T.SCHEMA_NAME = TC.SCHEMA_NAME AND
        T.TABLE_NAME = TC.TABLE_NAME AND
        TC.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION, '') LIKE '%DATAAGING%'
    )
  )
  UNION ALL
  SELECT
    3981,
    'Native storage extension (NSE)',
    MAP(COUNT, 0, 'no', 'yes' || CHAR(32) || '(' || COUNT || CHAR(32) || 'tables)'),
    '2799997'
  FROM
  ( SELECT
      COUNT(DISTINCT(SCHEMA_NAME || TABLE_NAME)) COUNT
    FROM
    ( SELECT
        T.SCHEMA_NAME,
        T.TABLE_NAME
      FROM
        TABLES T LEFT OUTER JOIN
        PARTITIONED_TABLES PT ON
          T.SCHEMA_NAME = PT.SCHEMA_NAME AND
          T.TABLE_NAME = PT.TABLE_NAME
      WHERE
        T.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION, '') NOT LIKE '%DATAAGING%'
      UNION
      SELECT
        P.SCHEMA_NAME,
        P.TABLE_NAME
      FROM
        TABLES T,
        PARTITIONED_TABLES PT,
        TABLE_PARTITIONS P
      WHERE
        T.SCHEMA_NAME = PT.SCHEMA_NAME AND
        T.TABLE_NAME = PT.TABLE_NAME AND
        T.SCHEMA_NAME = P.SCHEMA_NAME AND
        T.TABLE_NAME = P.TABLE_NAME AND
        P.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION, '') NOT LIKE '%DATAAGING%'
      UNION
      SELECT
        TC.SCHEMA_NAME,
        TC.TABLE_NAME
      FROM
        TABLES T,
        TABLE_COLUMNS TC LEFT OUTER JOIN
        PARTITIONED_TABLES PT ON
          TC.SCHEMA_NAME = PT.SCHEMA_NAME AND
          TC.TABLE_NAME = PT.TABLE_NAME
      WHERE
        T.SCHEMA_NAME = TC.SCHEMA_NAME AND
        T.TABLE_NAME = TC.TABLE_NAME AND
        TC.LOAD_UNIT = 'PAGE' AND
        IFNULL(PT.PARTITION_DEFINITION, '') NOT LIKE '%DATAAGING%'
    )
  )
  UNION ALL
  SELECT
    3985,
    'Max. NSE buffer cache size (GB)',
    TO_VARCHAR(TO_DECIMAL(SUM(B.MAX_SIZE) / 1024 / 1024 / 1024, 10, 2)),
    '2799997'
  FROM
    M_SERVICES S,
    M_BUFFER_CACHE_STATISTICS B
  WHERE
    S.SERVICE_NAME IN ( 'nameserver', 'indexserver' ) AND
    S.HOST = B.HOST AND
    S.PORT = B.PORT
  UNION ALL
  SELECT
    3988,
    'Paged objects disk size (GB)',
    TO_VARCHAR(TO_DECIMAL(IFNULL(SUM(MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE / 1024 / 1024 / 1024), 0), 10, 2)),
    '1871386'
  FROM
    M_CS_COLUMNS_PERSISTENCE
  WHERE
    PERSISTENCE_TYPE = 'PAGED'
  UNION ALL
  SELECT
    3990,
    'Paged objects memory size (GB)',
    TO_VARCHAR(TO_DECIMAL(SUM(PAGE_LOADABLE_COLUMNS_OBJECT_SIZE) / 1024 / 1024 / 1024, 10, 2)),
    '1871386'
  FROM
    M_MEMORY_OBJECT_DISPOSITIONS
  UNION ALL
  SELECT
    4100,
    'Tables with dynamic range partitioning',
    IFNULL(TO_VARCHAR(COUNT(*)) || CHAR(32) || '(' || TO_VARCHAR(SUM(CASE WHEN TABLE_NAME LIKE '/B%/%' OR TABLE_NAME LIKE 'RSPM%' THEN 1 ELSE 0 END)) || CHAR(32) || 'BW)', '0'),
    '2044468'
  FROM
    PARTITIONED_TABLES
  WHERE
    DYNAMIC_RANGE_THRESHOLD > 0
  UNION ALL
  SELECT
    4200,
    'Table replicas',
    TO_VARCHAR(COUNT(*)) || MAP(COUNT(*), 0, '', CHAR(32) || '(' || SUM(MAP(REPLICA_TYPE, 'ASYNCHRONOUS', 1, 0)) || CHAR(32) || 'ATR,' || CHAR(32) ||
      SUM(MAP(REPLICA_TYPE, 'SYNCHRONOUS', 1, 0)) || CHAR(32) || 'OSTR)'),
    '2340450'
  FROM
    M_TABLE_REPLICAS
  UNION ALL
  SELECT
    4300,
    'Volume encryption',
    MAP(COUNT(*), 0, 'no', 'yes' || CHAR(32) || '(' || STRING_AGG(SCOPE, ',' || CHAR(32)) || ')'),
    '2159014'
  FROM
    M_ENCRYPTION_OVERVIEW
  WHERE
    IS_ENCRYPTION_ACTIVE = 'TRUE'
  UNION ALL
  SELECT
    4400,
    'Embedded statistics server active',
    MAP(LOWER(MAX(VALUE)), 'true', 'yes', 'false', 'no', 'unknown'),
    '2147247'
  FROM
      M_CONFIGURATION_PARAMETER_VALUES
  WHERE 
    FILE_NAME IN ('indexserver.ini', 'nameserver.ini') AND
    SECTION = 'statisticsserver' AND
    KEY = 'active'
  UNION ALL
  SELECT
    4500,
    'Standalone statistics server active',
    MAP(COUNT(*), 0, 'no', 'yes'),
    '2147247'
  FROM
    M_SERVICES
  WHERE
    SERVICE_NAME = 'statisticsserver'
  UNION ALL
  SELECT
    4600,
    'Pinned SQL plans',
    TO_VARCHAR(COUNT(*)),
    '2222321'
  FROM
    PINNED_SQL_PLANS
  UNION ALL
  SELECT
    4605,
    'Hint annotations',
    TO_VARCHAR(COUNT(*)) || CHAR(32) || '(' || TO_VARCHAR(SUM(MAP(SCHEMA_NAME, '_SYS_BI', 1, 0))) || CHAR(32) || 'for _SYS_BI user)',
    '2142945'
  FROM
    ANNOTATIONS
  WHERE
    KEY = 'HINT'
  UNION ALL
  SELECT
    4700,
    'Statement hints',
    IFNULL(TO_VARCHAR(COUNT(*)) || CHAR(32) || '(' || TO_VARCHAR(SUM(MAP(LAST_ENABLE_USER, 'SYS', 1, 0))) || CHAR(32) || 'default)', '0'),
    '2400006'
  FROM
    STATEMENT_HINTS
  UNION ALL
  SELECT
    4710,
    'Abstract SQL plans',
    TO_VARCHAR(COUNT(*)),
    '2799998'
  FROM
    ABSTRACT_SQL_PLANS
  UNION ALL
  SELECT
    4720,
    'Data statistics',
    TO_VARCHAR(COUNT(*) || MAP(SUM(SDA), 0, '', NULL, '', CHAR(32) || '(' || SUM(SDA) || CHAR(32) || 'SDA)')),
    '2800028'
  FROM
  ( SELECT DISTINCT
      SCHEMA_NAME,
      TABLE_NAME,
      MAP(T.TABLE_TYPE, 'VIRTUAL', 1, 0) SDA
    FROM
      TABLES T,
      M_DATA_STATISTICS S
    WHERE
      T.SCHEMA_NAME = S.DATA_SOURCE_SCHEMA_NAME AND
      T.TABLE_NAME = S.DATA_SOURCE_OBJECT_NAME
  )
  UNION ALL
  SELECT
    4800,
    'Workload classes',
    TO_VARCHAR(COUNT(*)),
    '2222250'
  FROM
    WORKLOAD_CLASSES
  UNION ALL
  SELECT
    4900,
    'Workload mappings',
    TO_VARCHAR(COUNT(*)),
    '2222250'
  FROM
    WORKLOAD_MAPPINGS
  UNION ALL
  SELECT
    5000,
    'Static result cache entries',
    TO_VARCHAR(COUNT(*)),
    '2336344'
  FROM
    M_RESULT_CACHE
  UNION ALL
  SELECT
    5100,
    'Dynamic result cache entries',
    TO_VARCHAR(COUNT(*)),
    '2506811'
  FROM
    M_DYNAMIC_RESULT_CACHE
  UNION ALL
  SELECT
    5100,
    'Transactions with disabled logging',
    TO_VARCHAR(COUNT(*)),
    '1999930'
  FROM
    M_TRANSACTIONS
  WHERE
    LOGGING_ENABLED = 'FALSE'
  UNION ALL
  SELECT
    5110,
    'Tables with disabled logging',
    TO_VARCHAR(COUNT(*)),
    '1999930'
  FROM
    M_CS_TABLES
  WHERE
    IS_LOG_DELTA = 'FALSE'
  UNION ALL
  SELECT DISTINCT
    5120,
    'I/O throttling',
    MAP(KEY, NULL, 'no', 'yes'),
    '1999930'
  FROM
    DUMMY LEFT OUTER JOIN
    M_CONFIGURATION_PARAMETER_VALUES ON
      SECTION = 'fileio' AND
      KEY LIKE 'max%throughput%' AND
      LAYER_NAME != 'DEFAULT'
  UNION ALL
  SELECT
    5200,
    N.DESCRIPTION,
    TO_VARCHAR(MAP(SUM(MAP(C.ENTRY_TYPE_NAME, N.NAME, 1, 0)), 0, 'no', 'yes')),
    '1642148'
  FROM
  ( SELECT 'data snapshot' NAME,       'Data snapshot backups' DESCRIPTION FROM DUMMY UNION ALL
    SELECT 'differential data backup', 'Differential data backups'         FROM DUMMY UNION ALL
    SELECT 'incremental data backup',  'Incremental data backups'          FROM DUMMY
  ) N LEFT OUTER JOIN
    M_BACKUP_CATALOG C ON
      C.ENTRY_TYPE_NAME = N.NAME
  GROUP BY
    N.DESCRIPTION
  UNION ALL
  SELECT
    5300 + LINE_NO / 1000,
    DESCRIPTION,
    RPAD(IFNULL(MAP(VALUE, 'TRUE', 'true', 'FALSE', 'false', VALUE), ''), 12) || MAP(LAYER, 'DEFAULT', '(default)', ''),
    SAP_NOTES
  FROM
  ( SELECT
      P.LINE_NO,
      P.DESCRIPTION,
      P.SAP_NOTES,
      MAX(I.LAYER_NAME) LAYER,
      MAX(I.VALUE) VALUE
    FROM 
    ( SELECT  10 LINE_NO, 'Database log mode' DESCRIPTION,             'persistence' SECTION,        'log_mode' KEY,                   '' DEFAULT_VALUE, '1642148' SAP_NOTES  FROM DUMMY UNION ALL
      SELECT  20 LINE_NO, 'Automatic log backup',                      'persistence',                'enable_auto_log_backup',         '',               '1642148'            FROM DUMMY UNION ALL
      SELECT  30 LINE_NO, 'Query result cache',                        'cache',                      'resultcache_enabled',            '',               '2014148'            FROM DUMMY UNION ALL
      SELECT  40 LINE_NO, 'Global auditing state',                     'auditing configuration',     'global_auditing_state',          '',               '1991634'            FROM DUMMY UNION ALL
      SELECT  50 LINE_NO, 'Self-signed certificates',                  'communication',              'sslcreateselfsignedcertificate', 'false',          '1891055'            FROM DUMMY UNION ALL
      SELECT  60 LINE_NO, 'Hostname resolution for default route',     'public_hostname_resolution', 'use_default_route',              '',               '1906381'            FROM DUMMY UNION ALL
      SELECT  70 LINE_NO, 'Mountpoint usage for data and log volumes', 'persistence',                'use_mountpoints',                '',               '1809453, 1820553'   FROM DUMMY UNION ALL
      SELECT  80 LINE_NO, 'Client distribution mode',                  'distribution',               'client_distribution_mode',       '',               '2200772'            FROM DUMMY UNION ALL
      SELECT 100 LINE_NO, 'Parallelism of table preload',              'parallel',                   'tables_preloaded_in_parallel',   '',               '2127458'            FROM DUMMY UNION ALL
      SELECT 110 LINE_NO, 'Table preload during startup',              'sql',                        'reload_tables',                  '',               '2127458'            FROM DUMMY UNION ALL
      SELECT 140 LINE_NO, 'Listen interface',                          'communication',              'listeninterface',                '',               '1999797'            FROM DUMMY UNION ALL
      SELECT 150 LINE_NO, 'Multitenant isolation level',               'multidb',                    'database_isolation',             '',               '2101244'            FROM DUMMY UNION ALL
      SELECT 160 LINE_NO, 'License usage',                             'system_information',         'license_usage',                  '',               '2779499'            FROM DUMMY UNION ALL
      SELECT 170 LINE_NO, 'System replication full-sync',              'system_replication',         'enable_full_sync',               '',               '1999880'            FROM DUMMY
    ) P LEFT OUTER JOIN
      M_CONFIGURATION_PARAMETER_VALUES I ON
        I.SECTION = P.SECTION AND
        I.KEY = P.KEY AND
        I.FILE_NAME IN ('global.ini', 'indexserver.ini', 'nameserver.ini') LEFT OUTER JOIN
      CONFIGURATION_PARAMETER_PROPERTIES PP ON
        PP.SECTION = P.SECTION AND
        PP.KEY = P.KEY
    GROUP BY
      P.LINE_NO,
      P.DESCRIPTION,
      P.SAP_NOTES,
      P.DEFAULT_VALUE,
      PP.DEFAULT_VALUE
  )
  UNION ALL
  SELECT
    5370,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    5380,
    'CLIENT APPLICATION LOAD:',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    5390,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    5400 + ROW_NUMBER () OVER (ORDER BY SAMPLES DESC),
    APPLICATION_NAME,
    TO_VARCHAR(LPAD(TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2), 6)) || CHAR(32) || '%',
    MAP(APPLICATION_NAME, 'HANACockpit', '2800006', 'HDBStudio', '2073112', 'SAP_SDA_', '2180119', 'Embedded Statistics Server', '2147247', '2114710')
  FROM
  ( SELECT
      MAP(APPLICATION_NAME, CHAR(63), '<internal / undefined>', APPLICATION_NAME) APPLICATION_NAME,
      COUNT(*) SAMPLES,
      SUM(COUNT(*)) OVER () TOTAL_SAMPLES
    FROM
      _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
    WHERE
      TIMESTAMP >= ADD_DAYS(CURRENT_TIMESTAMP, -31) AND
      THREAD_STATE = 'Running' AND
      THREAD_TYPE NOT IN ( 'ChildIOThreads::ErrorStream', 'ChildIOThreads::OutputStream', 'Generic', 'WebDispatcher-Main-Thread' ) AND
      THREAD_METHOD NOT IN ( 'TimerCallback_OdmContextCleanup' )
    GROUP BY
      APPLICATION_NAME
  )
  WHERE
    SAMPLES / TOTAL_SAMPLES * 100 >= 1
  UNION ALL
  SELECT
    6370,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    6380,
    'SPACE INFORMATION:',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    6390,
    ' ',
    ' ',
    ' '
  FROM 
    DUMMY
  UNION ALL
  SELECT
    D.LINE_NO,
    D.DESCRIPTION,
    MAP(D.DESCRIPTION, 'Data disk size allocated (GB)',                LPAD(TO_DECIMAL(V.ALLOC_GB,            12, 2), 13),
                       'Data disk size used (GB)',                     LPAD(TO_DECIMAL(V.USED_GB,             12, 2), 13),
                       'Data disk size used by tables (GB)',           LPAD(TO_DECIMAL(T.TABLE_GB,            12, 2), 13),
                       'Data disk size used by tables excl. LOB (GB)', LPAD(TO_DECIMAL(T.TABLE_GB - L.LOB_GB, 12, 2), 13)),
    '2400005'
  FROM
  ( SELECT 6400 LINE_NO, 'Data disk size allocated (GB)' DESCRIPTION FROM DUMMY UNION ALL
    SELECT 6500, 'Data disk size used (GB)'                          FROM DUMMY UNION ALL
    SELECT 6550, 'Data disk size used by tables (GB)'                FROM DUMMY UNION ALL
    SELECT 6600, 'Data disk size used by tables excl. LOB (GB)'      FROM DUMMY
  ) D,
  ( SELECT SUM(TOTAL_SIZE) / 1024 / 1024 / 1024 ALLOC_GB, SUM(USED_SIZE) / 1024 / 1024 / 1024 USED_GB FROM M_VOLUME_FILES WHERE FILE_TYPE = 'DATA' ) V,
  ( SELECT SUM(DISK_SIZE) / 1024 / 1024 / 1024 LOB_GB FROM M_TABLE_LOB_STATISTICS ) L,
  ( SELECT SUM(DISK_SIZE) / 1024 / 1024 / 1024 TABLE_GB FROM M_TABLE_PERSISTENCE_STATISTICS ) T
  UNION ALL
  SELECT
    6700,
    'Converter disk size (GB)',
    LPAD(TO_DECIMAL(SUM(ALLOCATED_PAGE_SIZE) / 1024 / 1024 / 1024, 10, 2), 13),
    ' '
  FROM
    M_CONVERTER_STATISTICS
  UNION ALL
  SELECT  /* value may be wrong for data snapshots with <= 1.00.122.26, <= 2.00.037.02 and <= 2.00.041 */
    6800,
    'Data backup size (GB)',
    IFNULL(LPAD(TO_DECIMAL(SUM(BACKUP_SIZE) / 1024 / 1024 / 1024, 12, 2), 13), 'n/a'),
    ' '
  FROM
  ( SELECT TOP 1
      BACKUP_ID
    FROM
      M_BACKUP_CATALOG
    WHERE
      ENTRY_TYPE_NAME IN ( 'complete data backup', 'data snapshot' ) AND 
      STATE_NAME = 'successful'
    ORDER BY
      UTC_START_TIME DESC
  ) MB,
    M_BACKUP_CATALOG_FILES B
  WHERE
    B.BACKUP_ID = MB.BACKUP_ID
  UNION ALL
  SELECT
    6900 + ROW_NUMBER () OVER (ORDER BY HOST),
    MAP(ROW_NUMBER () OVER (ORDER BY HOST), 1, 'Row store memory size total (GB)', ' '),
    LPAD(TO_DECIMAL(SUM(ALLOCATED_SIZE) / 1024 / 1024 / 1024, 12, 2), 13) || ' (' || HOST || ')',
    ' '
  FROM
    M_RS_MEMORY
  GROUP BY
    HOST
  HAVING
    SUM(ALLOCATED_SIZE) / 1024 / 1024 / 1024 > 3
  UNION ALL
  SELECT
    7000,
    'Column store memory size total (GB)',
    LPAD(TO_DECIMAL(SUM(MEMORY_SIZE_IN_TOTAL + PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024, 12, 2), 13),
    ' '
  FROM
    M_CS_TABLES
  UNION ALL
  SELECT
    7100,
    'Row store tables',
    LPAD(COUNT(*), 10) || '    (SAP schema: ' || LPAD(SUM(MAP(SUBSTR(SCHEMA_NAME, 1, 3), 'SAP', 1, 0)), 6) || ')',
    ' '
  FROM
    TABLES
  WHERE 
    TABLE_TYPE = 'ROW'
  UNION ALL
  SELECT
    7200,
    'Column store tables',
    LPAD(COUNT(*), 10) || '    (SAP schema: ' || LPAD(SUM(MAP(SUBSTR(SCHEMA_NAME, 1, 3), 'SAP', 1, 0)), 6) || ')',
    ' '
  FROM
    TABLES
  WHERE 
    TABLE_TYPE = 'COLUMN'
)
ORDER BY
  LINE_NO
WITH HINT ( IGNORE_PLAN_CACHE )