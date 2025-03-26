WITH 

/* 

[NAME]

- HANA_ABAP_MiniChecks_NGAP

[DESCRIPTION]

- ABAP mini checks in SAP HANA environments

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Needs to be run as ABAP schema owner as access to ABAP table data is required, otherwise an error like the following is reported:

  [259]: invalid table name:  Could not find table/view <table> in schema <schema>

- If access to ABAP objects is possible but you cannot log on as ABAP user, you can switch the default schema before executing the command:

  SET SCHEMA SAP<sid>

- Checks returned with VALUE = <manual> are part of the TPO service but need to 
  be checked manually because no simple SQL solution is available
- ABAP parameter checks (A05xx) are based on table PAHI that is only updated from time to time, so after parameter changes 
  you may have to wait for a day until the check recognizes the new parameter value.

- The following standard ABAP checks are not available in NGAP environments because the underlying tables, transactions or features do not exist:

  ( SELECT  500, 'RSDB_PREFER_JOIN_WITH_FDA',    'Parameter: rsdb/prefer_join_with_fda',            '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  501, 'DBS_HDB_PREFER_JOIN_WITH_FDA', 'Parameter: dbs/hdb/prefer_join_with_fda',         '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  502, 'RSDB_SUPPORTS_FDA_PROT',       'Parameter: rsdb/supports_fda_prot',               '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  503, 'DBS_HDB_SUPPORTS_FDA_PROT',    'Parameter: dbs/hdb/supports_fda_prot',            '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  600, 'MANUAL_CHECK',                 'Current CPU idle (%)',                            '',        '>=',       '20'             FROM DUMMY ) UNION ALL
  ( SELECT  602, 'MANUAL_CHECK',                 'Min. CPU idle (% per hour, short-term)',          '',        '>=',       '10'             FROM DUMMY ) UNION ALL
  ( SELECT  604, 'MANUAL_CHECK',                 'Min. CPU idle (% per day, long-term)',            '',        '>=',       '20'             FROM DUMMY ) UNION ALL
  ( SELECT  606, 'MANUAL_CHECK',                 'Existence of historic server statistics',         '1147334', '=',        'yes'            FROM DUMMY ) UNION ALL
  ( SELECT  900, 'SQLM_ACTIVE',                  'SQLM activated',                                  '1885926', '=',        'yes'            FROM DUMMY ) UNION ALL
  ( SELECT 1000, 'DATA_TARGETS_MANY_REQUESTS',   'BW data targets with many requests',              '1431315', '=',        '0'              FROM DUMMY ) UNION ALL
  ( SELECT 1005, 'HANA_OPTIMIZED_DSOS',          'Number of HANA-optimized DSOs',                   '1849497', '=',        '0'              FROM DUMMY ) UNION ALL
  ( SELECT 1210, 'BW_BOOKMARKS_OLD_USERS',       'RSWR_DATA bookmarks of old users (GB)',           '1419451', '<=',       '5.00'           FROM DUMMY ) UNION ALL
  ( SELECT 1300, 'MANUAL_CHECK',                 'Empty table in FOR ALL ENTRIES clause',           '',        '=',        '0'              FROM DUMMY ) UNION ALL
  ( SELECT 1310, 'MANUAL_CHECK',                 'Missing ORDER BY or SORT after SELECT',           '',        '=',        '0'              FROM DUMMY ) UNION ALL
  ( SELECT 1500, 'MANUAL_CHECK',                 'Max. network latency to database (ms)',           '2222200', '<=',       '1.00'           FROM DUMMY ) UNION ALL

[VALID FOR]

- Revisions:              all
- Client application:     Next generation ABAP (NGAP), e.g. BYD (Business by Design) / C4C (Cloud 4 Customer)

[SQL COMMAND VERSION]

- 2018/10/03:  1.0 (initial version)
- 2020/07/24:  1.1 (short-term, mid-term, long-term included)
- 2020/11/19:  1.2 ("Work processes busy requesting enqueue" included)
- 2021/03/18:  1.3 (dedicated BYD version)

[INVOLVED TABLES]

- various

[INPUT PARAMETERS]

- ONLY_POTENTIALLY_CRITICAL_RESULTS

  Possibility to restrict the output to potentially critical issues

  'X'             --> Output only contains issues that can potentially indicate a problem
  ' '             --> no output restriction

- EXCLUDE_MANUAL_CHECK

  Possibility to exclude / consider manual checks

  'X'             --> Only automatic check results are displayed
  ' '             --> Automatic check results are displayed and place hoder lines for manual checks are included

- MAX_VALUE_LENGTH

  Maximum length of VALUE output column

  48              --> Maximum length of 48 characters
  -1              --> no length limitation

- CHECK_ID

  Possibility to restrict the output to a specific check ID

  250             --> Restrict output to check ID 250
  -1              --> No restriction to a particular check ID

- CHECK_ID_PREFIX

  Prefix for CHID value

  'A'             --> Prefix check ID number with 'A' (e.g. 'A1234')
  ''              --> No prefix for check ID numbers

- SHORTTERM_DAYS

  Number of days for short-term checks (default: 1 day)

  1               --> Consider last day for short-term checks
  5               --> Consider last 5 days for short-term checks

- MIDTERM_DAYS

  Number of days for mid-term checks (default: 7 days)

  7               --> Consider last week for mid-term checks
  14              --> Consider last 14 days for mid-term checks

- LONGTERM_DAYS

  Number of days for long-term checks (default: 31 days)

  31              --> Consider last month for long-term checks
  42              --> Consider last 42 days for long-term checks

[OUTPUT PARAMETERS]

- CHID:           Check identifier (defined and used by this Mini Check command)
- DESCRIPTION:    Check description
- VALUE:          Check value found on the system
- EXPECTED_VALUE: Expected check values 
- C:              'X' if value found on the system is outside of the expected values (indication for potentially critical problem)
- SAP_NOTE:       Related SAP Note

[EXAMPLE OUTPUT]

------------------------------------------------------------------------------------------------------------------------
|CHID |DESCRIPTION                            |VALUE                                         |EXPECTED_VALUE|C|SAP_NOTE|
------------------------------------------------------------------------------------------------------------------------
|**** |SAP ABAP MINI CHECKS                   |                                              |              | |        |
|     |                                       |                                              |              | |        |
|A0009|ABAP mini check version                |1.0.4 (2019/01/07)                            |              | |        |
|A0010|Analysis date                          |2019/01/07 15:13:19 (CET)                     |              | |        |
|A0012|SAP HANA version                       |1.00.122.17.1526900527 (fa/hana1sp12)         |              | |        |
|     |                                       |                                              |              | |        |
|A0300|ABAP short dumps (last day)            |115                                           |<= 500        | |        |
|A0310|ABAP short dumps DB* (last day)        |9                                             |<= 5          |X| 2399990|
|A0500|Parameter: rsdb/prefer_join_with_fda   |okay (0)                                      |like 'okay%'  | | 2600030|
|A0501|Parameter: dbs/hdb/prefer_join_with_fda|okay (0)                                      |like 'okay%'  | | 2600030|
|A0502|Parameter: rsdb/supports_fda_prot      |okay (1)                                      |like 'okay%'  | | 2600030|
|A0503|Parameter: dbs/hdb/supports_fda_prot   |okay (not set)                                |like 'okay%'  | | 2600030|
|A0505|Parameter: rsdb/max_in_blocking_factor |okay (100)                                    |like 'okay%'  | | 2600030|
|A0507|Parameter: rsdb/max_blocking_factor    |wrong (5 instead of 50)                       |like 'okay%'  |X| 2600030|
|A0510|Parameter: dbs/hdb/cmd_buffersize      |wrong (1048576 instead of 2097152 to 10485760)|like 'okay%'  |X| 2600030|
|A0512|Parameter: dbs/hdb/stmt_cache_size     |okay (1000)                                   |like 'okay%'  | | 2600030|
|A0800|Update requests in status Cancelled    |1075                                          |<= 100        |X|        |
|A0805|Update requests in status Started      |0                                             |0             | |        |
|A0850|Cancelled batch jobs (last day)        |3                                             |<= 100        | |        |
|A0855|Longest running batch job (s)          |163002                                        |<= 86400      |X|        |
|A0900|SQLM activated                         |no                                            |yes           |X| 1885926|
|A1000|BW data targets with many requests     |0                                             |0             | | 1431315|
|A1005|Number of HANA-optimized DSOs          |0                                             |0             | | 1849497|
|A5000|Physical cluster tables                |none                                          |none          | | 1892354|
|A5001|Physical pool tables                   |none                                          |none          | | 1892354|
|     |                                       |                                              |              | |        |
|**** |END OF CHECK                           |                                              |              | |        |
------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT
    ONLY_POTENTIALLY_CRITICAL_RESULTS,
    EXCLUDE_MANUAL_CHECKS,
    MAX_VALUE_LENGTH,
    CHECK_ID,
    CHECK_ID_PREFIX,
    MAP(SHORTTERM_DAYS, -1, 99999, SHORTTERM_DAYS) SHORTTERM_DAYS,
    MAP(MIDTERM_DAYS, -1, 99999, MIDTERM_DAYS)  MIDTERM_DAYS,
    MAP(LONGTERM_DAYS, -1, 99999, LONGTERM_DAYS)  LONGTERM_DAYS
  FROM
  ( SELECT                                               /* Modification section */
      ' ' ONLY_POTENTIALLY_CRITICAL_RESULTS,
      ' ' EXCLUDE_MANUAL_CHECKS,
       60 MAX_VALUE_LENGTH,
       -1 CHECK_ID,
      'A' CHECK_ID_PREFIX,
        1 SHORTTERM_DAYS,
        7 MIDTERM_DAYS,
       31 LONGTERM_DAYS
    FROM
      DUMMY
  )
),
HANA_RELEASE AS
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
),
PARAMETER_SETTINGS AS
( SELECT
    IFNULL(IFNULL(IFNULL(IFNULL(DATABASE_VALUE, SYSTEM_VALUE), HOST_VALUE), DEFAULT_VALUE), 'n/a') COMPOSITE_STATISTICS_STRIPING
  FROM
  DUMMY LEFT OUTER JOIN
  ( SELECT
      MAX(MAP(LAYER_NAME, 'DEFAULT', VALUE)) DEFAULT_VALUE,
      MAX(MAP(LAYER_NAME, 'HOST', VALUE)) HOST_VALUE,
      MAX(MAP(LAYER_NAME, 'SYSTEM', VALUE)) SYSTEM_VALUE,
      MAX(MAP(LAYER_NAME, 'DATABASE', VALUE)) DATABASE_VALUE
    FROM
      M_INIFILE_CONTENTS
    WHERE
      KEY = 'composite_statistics_striping'
    GROUP BY
      KEY
  ) ON
    1 = 1
),
WORK_PROCESSES AS
( SELECT
    COUNT(DISTINCT(CLIENT_HOST || CLIENT_PID)) NUM_WPS
  FROM
    M_SESSION_CONTEXT SC,
    M_CONNECTIONS C
  WHERE
    SC.KEY = 'APPLICATION' AND
    ( SC.VALUE LIKE 'ABAP:%' OR SC.VALUE LIKE 'dw.sap%' ) AND
    SC.HOST = C.HOST AND
    SC.PORT = C.PORT AND
    SC.CONNECTION_ID = C.CONNECTION_ID
),
ABAP_CHECKS AS
( SELECT -1 CHECK_ID, '' NAME,                  '' DESCRIPTION,                                    '' SAP_NOTE, '' EXPECTED_OP, '' EXPECTED_VALUE FROM DUMMY WHERE 1 = 0 UNION ALL
  ( SELECT    1, 'INFO_LINE',                    'SAP ABAP MINI CHECKS',                            '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT    2, 'BLANK_LINE',                   '',                                                '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT    5, 'GENERATED_WITH',               'Generated with',                                  '1969700', 'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT    6, 'CHECK_VERSION',                'Check version',                                   '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT    7, 'SYSTEM_ID_DB_NAME',            'System ID / database name',                       '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT   10, 'ANALYSIS_DATE',                'Analysis date',                                   '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT   11, 'DATABASE_NAME',                'Database name',                                   '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT   12, 'REVISION_LEVEL',               'SAP HANA version',                                '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT   15, 'CONFIGURED_TIME_INTERVALS',    'Configured time intervals (days)',                '',        'any',      'any'            FROM DUMMY ) UNION ALL

  ( SELECT   99, 'BLANK_LINE',                   '',                                                '',        'any',      'any'            FROM DUMMY ) UNION ALL

  ( SELECT  100, 'MANUAL_CHECK',                 'Number of work processes currently in PRIV mode', '',        '<=',       '2'              FROM DUMMY ) UNION ALL
  ( SELECT  110, 'MANUAL_CHECK',                 'Extended memory used (%)',                        '',        '<=',       '80'             FROM DUMMY ) UNION ALL

  ( SELECT  200, 'MANUAL_CHECK',                 'ABAP table buffer hit ratio (%)',                 '',        '>=',       '99.00'          FROM DUMMY ) UNION ALL
  ( SELECT  210, 'MANUAL_CHECK',                 'ABAP table buffer swaps per day (mid-term)',      '',        '<=',       '100'            FROM DUMMY ) UNION ALL
  ( SELECT  220, 'MANUAL_CHECK',                 'Large tables in ABAP table buffer',               '',        '=',        'none'           FROM DUMMY ) UNION ALL
  ( SELECT  225, 'MANUAL_CHECK',                 'Tables with state Error in ABAP table buffer',    '703035',  '=',        'none'           FROM DUMMY ) UNION ALL
  ( SELECT  230, 'MANUAL_CHECK',                 'OTR buffer swaps per day (mid-term)',             '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL
  ( SELECT  235, 'MANUAL_CHECK',                 'Nametab buffer swaps per day (mid-term)',         '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL
  ( SELECT  240, 'MANUAL_CHECK',                 'Program buffer swaps per day (mid-term)',         '1918603', '<=',       '10000'          FROM DUMMY ) UNION ALL
  ( SELECT  245, 'MANUAL_CHECK',                 'CUA buffer swaps per day (mid-term)',             '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL
  ( SELECT  250, 'MANUAL_CHECK',                 'Screen buffer swaps per day (mid-term)',          '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL
  ( SELECT  255, 'MANUAL_CHECK',                 'Calendar buffer swaps per day (mid-term)',        '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL
  ( SELECT  260, 'MANUAL_CHECK',                 'Exp. / imp. buffer swaps per day (mid-term)',     '1918603', '<=',       '1000'           FROM DUMMY ) UNION ALL

  ( SELECT  300, 'SHORT_DUMPS_RECENT',           'ABAP short dumps per day (mid-term)',             '',        '<=',       '500'            FROM DUMMY ) UNION ALL
  ( SELECT  310, 'SHORT_DUMPS_RECENT_DB',        'ABAP short dumps DB* per day (mid-term)',         '2399990', '<=',       '5'              FROM DUMMY ) UNION ALL
  ( SELECT  320, 'SHORT_DUMPS_RECENT_AMDP',      'ABAP short dumps AMDP* per day (mid-term)',       '2399990', '<=',       '5'              FROM DUMMY ) UNION ALL

  ( SELECT  400, 'MANUAL_CHECK',                 'Outdated SQLDBC client version',                  '2941449', '=',        'no'             FROM DUMMY ) UNION ALL

  ( SELECT  504, 'RSDB_PREFER_UNION_ALL',        'Parameter: rsdb/prefer_union_all',                '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  505, 'RSDB_MAX_IN_BLOCKING_FACTOR',  'Parameter: rsdb/max_in_blocking_factor',          '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  507, 'RSDB_MAX_BLOCKING_FACTOR',     'Parameter: rsdb/max_blocking_factor',             '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  510, 'DBS_HDB_CMD_BUFFERSIZE',       'Parameter: dbs/hdb/cmd_buffersize',               '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  512, 'DBS_HDB_STMT_CACHE_SIZE',      'Parameter: dbs/hdb/stmt_cache_size',              '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  520, 'ABAP_TABLE_BUFFER_SIZE',       'Parameter: rsdb/tbi_buffer_area_MB',              '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL
  ( SELECT  521, 'ABAP_TABLE_BUFFER_SLOTS',      'Parameter: rsdb/tbi_dir_entries',                 '2600030', 'like',     'okay%'          FROM DUMMY ) UNION ALL

  ( SELECT  608, 'MANUAL_CHECK',                 'Existence of historic workload statistics',       '2369736', '=',        'yes'            FROM DUMMY ) UNION ALL

  ( SELECT  700, 'MANUAL_CHECK',                 'Free dialog work processes (%)',                  '',        '>=',       '25'             FROM DUMMY ) UNION ALL
  ( SELECT  710, 'MANUAL_CHECK',                 'Work processes busy requesting enqueue',          '2013043', '<=',       '5'              FROM DUMMY ) UNION ALL
  ( SELECT  730, 'MANUAL_CHECK',                 'Processing time / CPU time ratio (mid-term)',     '2444034', '<=',        '2.00'          FROM DUMMY ) UNION ALL
  ( SELECT  732, 'MANUAL_CHECK',                 'Average dialog response time (ms, mid-term)',     '',        '<=',        '1000'          FROM DUMMY ) UNION ALL   

  ( SELECT  800, 'UPDATES_CANCELLED',            'Update requests in status Cancelled',             '',        '<=',       '100'            FROM DUMMY ) UNION ALL
  ( SELECT  805, 'UPDATES_STARTED',              'Update requests in status Started',               '',        '=',        '0'              FROM DUMMY ) UNION ALL
  ( SELECT  807, 'MANUAL_CHECK',                 'Update deactivated',                              '51189',   '=',        'no'             FROM DUMMY ) UNION ALL
  ( SELECT  850, 'CANCELLED_BATCH_JOBS',         'Cancelled batch jobs per day (short-term)',       '',        '<=',       '100'            FROM DUMMY ) UNION ALL
  ( SELECT  855, 'LONGEST_RUNNING_BATCH_JOB',    'Longest running active batch job (s)',            '',        '<=',       '86400'          FROM DUMMY ) UNION ALL
  ( SELECT  860, 'SAP_END_OF_JOB_BATCH_JOBS',    'Old batch jobs waiting for END OF JOB event',     '2640389', '<=',       '2000'           FROM DUMMY ) UNION ALL

  ( SELECT 1100, 'MANUAL_CHECK',                 'Indexes missing on database level',               '2160391', '=',        '0'              FROM DUMMY ) UNION ALL

  ( SELECT 1200, 'ORPHAN_BALDAT_ENTRIES',        'Orphan records in BALDAT',                        '2057897', '<=',       '100000'         FROM DUMMY ) UNION ALL
  ( SELECT 1202, 'OLD_ARFC_RECORDS',             'Old asynchronous RFC records',                    '375566',  '<=',       '100000'         FROM DUMMY ) UNION ALL
  ( SELECT 1203, 'LONG_QRFC_OUTBOUND_QUEUES',    'Outbound qRFC queues with many entries',          '',        '=',        'none'           FROM DUMMY ) UNION ALL
  ( SELECT 1205, 'UNNECESSARY_DBTABLOG_ENTRIES', 'Unnecessary records in DBTABLOG',                 '2335014', '<=',       '200000'         FROM DUMMY ) UNION ALL
  ( SELECT 1290, 'OLD_D_CLUSTER_ENTRIES',        '/ISPCD/D_CLUSTER rows older than 15 months (%)',  '',        '<=',       '10.00'          FROM DUMMY ) UNION ALL

  ( SELECT 1400, 'MANUAL_CHECK',                 'Inconsistencies reported by RSDBTIME',            '101726',  '=',        'no'             FROM DUMMY ) UNION ALL
  ( SELECT 1410, 'MANUAL_CHECK',                 'Inconsistencies reported by SICK',                '',        '=',        'no'             FROM DUMMY ) UNION ALL

  ( SELECT 1600, 'MANUAL_CHECK',                 'Number ranges used significantly',                '2292041', '=',        '0'              FROM DUMMY ) UNION ALL

  ( SELECT 1800, 'MANUAL_CHECK',                 'OS OOM killer activities',                        '',        '=',        'no'             FROM DUMMY ) UNION ALL

  ( SELECT 1900, 'CORRESPONDENCE_LANGUAGES',     'Number of used correspondence languages',         '302063',  '=',        '0'              FROM DUMMY ) UNION ALL

  ( SELECT 5000, 'PHYSICAL_CLUSTER_TABLES',      'Physical cluster tables',                         '1892354', '=',        'none'           FROM DUMMY ) UNION ALL
  ( SELECT 5001, 'PHYSICAL_POOL_TABLES',         'Physical pool tables',                            '1892354', '=',        'none'           FROM DUMMY ) UNION ALL

  ( SELECT 9000, 'BLANK_LINE',                   '',                                                '',        'any',      'any'            FROM DUMMY ) UNION ALL
  ( SELECT 9001, 'INFO_LINE',                    'END OF CHECK',                                    '',        'any',      'any'            FROM DUMMY )
)
SELECT
  CASE 
    WHEN NAME = 'BLANK_LINE' THEN ''
    WHEN NAME = 'INFO_LINE' THEN '****'
    WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 THEN LPAD(MAP(CHECK_ID_PREFIX, '', CHECK_ID, CHECK_ID_PREFIX || LPAD(CHECK_ID, 4, 0)), 5) 
    ELSE '' 
  END CHID,
  CASE WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 THEN DESCRIPTION ELSE '' END DESCRIPTION,
  CASE
    WHEN NAME = 'MANUAL_CHECK' THEN '<manual>'
    ELSE MAP(VALUE, '999999', 'never', '999999.00', 'never', '-999999', 'never', '-999999.00', 'never', NULL, 'n/a', 
           CASE WHEN MAX_VALUE_LENGTH = -1 OR LENGTH(VALUE) <= MAX_VALUE_LENGTH THEN VALUE 
           ELSE SUBSTR(VALUE, 1, VALUE_FRAGMENT_LENGTH) || '...' || SUBSTR(VALUE, LENGTH(VALUE) - (VALUE_FRAGMENT_LENGTH - 1), VALUE_FRAGMENT_LENGTH) END) 
  END VALUE,
  CASE
    WHEN EXPECTED_OP = 'any'  THEN ''
    WHEN EXPECTED_OP = '='    THEN EXPECTED_VALUE
    WHEN EXPECTED_OP = 'like' THEN EXPECTED_OP || CHAR(32) || CHAR(39) || EXPECTED_VALUE || CHAR(39)
    ELSE EXPECTED_OP || CHAR(32) || EXPECTED_VALUE
  END EXPECTED_VALUE,
  MAP(NAME, 'MANUAL_CHECK', '', POTENTIALLY_CRITICAL) C,
  LPAD(SAP_NOTE, 8) SAP_NOTE
FROM
( SELECT
    CC.CHECK_ID,
    CC.NAME,
    CC.DESCRIPTION,
    C.VALUE,
    CC.SAP_NOTE,
    CC.EXPECTED_OP,
    CC.EXPECTED_VALUE,
    CASE
      WHEN C.VALUE IN ('999999', '999999.00', '-999999', '-999999.00')                                            THEN ' '
      WHEN CC.EXPECTED_OP = 'any' OR UPPER(C.VALUE) = 'NONE'                                                      THEN ' '
      WHEN CC.EXPECTED_OP = 'not'      AND LPAD(UPPER(C.VALUE), 100) =        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '='        AND LPAD(UPPER(C.VALUE), 100) !=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>='       AND LPAD(UPPER(C.VALUE), 100) <        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>'        AND LPAD(UPPER(C.VALUE), 100) <=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60) || '=' AND LPAD(UPPER(C.VALUE), 100) >   LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60)   AND LPAD(UPPER(C.VALUE), 100) >=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = 'like'     AND UPPER(C.VALUE)            NOT LIKE UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      WHEN CC.EXPECTED_OP = 'not like' AND UPPER(C.VALUE)            LIKE     UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      ELSE ''
    END POTENTIALLY_CRITICAL,
    BI.ONLY_POTENTIALLY_CRITICAL_RESULTS,
    BI.MAX_VALUE_LENGTH,
    FLOOR(BI.MAX_VALUE_LENGTH / 2 - 0.5) VALUE_FRAGMENT_LENGTH,
    BI.CHECK_ID_PREFIX,
    ROW_NUMBER () OVER ( PARTITION BY CC.DESCRIPTION ORDER BY C.VALUE ) ROW_NUM
  FROM
  BASIS_INFO BI,
  ABAP_CHECKS CC,
  ( ( SELECT
        'GENERATED_WITH' NAME,
        'SQL: "HANA_ABAP_MiniChecks_NGAP"' VALUE
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'CHECK_VERSION' NAME,
        '1.3.7 (2024/04/30)' VALUE
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'SYSTEM_ID_DB_NAME' NAME,
        SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME VALUE
      FROM
        M_DATABASE
    )
    UNION ALL
    ( SELECT
        'REVISION_LEVEL' NAME,
        VALUE
      FROM 
        M_SYSTEM_OVERVIEW
      WHERE 
        SECTION = 'System' AND 
        NAME = 'Version' 
    )
    UNION ALL
    ( SELECT
        'CONFIGURED_TIME_INTERVALS',
        'short-term: ' || SHORTTERM_DAYS || ', mid-term: ' || MIDTERM_DAYS || ', long-term: ' || LONGTERM_DAYS
      FROM
        BASIS_INFO
    )
    UNION ALL
    ( SELECT
        'BLANK_LINE',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'INFO_LINE',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'MANUAL_CHECK',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT TOP 1
        'ANALYSIS_DATE',
        TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') || CHAR(32) || '(' || VALUE || ')'
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'timezone_name'
    )
    UNION ALL
    ( SELECT
        'PHYSICAL_CLUSTER_TABLES',
        IFNULL(TABLE_NAME, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT 
            TABLE_NAME 
          FROM 
            M_TABLES
          WHERE
            TABLE_NAME IN (SELECT SQLTAB FROM DD02L WHERE TABCLASS = 'CLUSTER') AND
            TABLE_NAME NOT IN ('SVER', 'SVED', 'SVET', 'SVEP', 'CVEP11', 'CVEP12', 'CVER11', 'CVER12', 'TACOPA', 'TACOPAB', 'TACOPB', 'TACOPBA' ) AND        /* SAP Note 2839111 */
            RECORD_COUNT >= 1
        ) ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        'PHYSICAL_POOL_TABLES',
        IFNULL(TABLE_NAME, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT 
            TABLE_NAME 
          FROM 
            M_TABLES
          WHERE
            TABLE_NAME IN (SELECT TABNAME FROM DD02L WHERE TABCLASS = 'POOL') AND
            TABLE_NAME NOT IN ('SVER', 'SVED', 'SVET', 'SVEP', 'CVEP11', 'CVEP12', 'CVER11', 'CVER12', 'TACOPA', 'TACOPAB', 'TACOPB', 'TACOPBA' ) AND        /* SAP Note 2839111 */
            RECORD_COUNT >= 1
        ) ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        N.NAME,
        IFNULL(MAP(N.NAME, 
          'SHORT_DUMPS_RECENT', TO_VARCHAR(TO_DECIMAL(SUM(MAP(S.FLIST, NULL, 0, 1)) / N.MIDTERM_DAYS, 10, 0)), 
          'SHORT_DUMPS_RECENT_DB', TO_VARCHAR(TO_DECIMAL(SUM(MAP(SUBSTR(S.FLIST, 6, 2), 'DB', 1, 0)) / N.MIDTERM_DAYS, 10, 0)),
          'SHORT_DUMPS_RECENT_AMDP', TO_VARCHAR(TO_DECIMAL(SUM(MAP(SUBSTR(S.FLIST, 6, 4), 'AMDP', 1, 0)) / N.MIDTERM_DAYS, 10, 0))), '0')
      FROM
      ( SELECT 'SHORT_DUMPS_RECENT' NAME, MIDTERM_DAYS FROM BASIS_INFO UNION ALL
        SELECT 'SHORT_DUMPS_RECENT_DB',   MIDTERM_DAYS FROM BASIS_INFO UNION ALL
        SELECT 'SHORT_DUMPS_RECENT_AMDP', MIDTERM_DAYS FROM BASIS_INFO
      ) N LEFT OUTER JOIN
        SNAP S ON
          S.SEQNO = '000' AND
          SECONDS_BETWEEN(TO_TIMESTAMP(S.DATUM || S.UZEIT, 'YYYYMMDDHH24MISS'), CURRENT_TIMESTAMP) <= 86400 * N.MIDTERM_DAYS
      GROUP BY
        N.NAME,
        N.MIDTERM_DAYS
    )
    UNION ALL
    ( SELECT
        CHECK_NAME,
        CASE
          WHEN PARAMETER_NAME = 'rsdb/prefer_union_all'        AND VALUE != '0' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '0)'
          WHEN PARAMETER_NAME = 'rsdb/prefer_union_all'        AND VALUE = '0' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'rsdb/max_in_blocking_factor'  AND LPAD(VALUE, 100) BETWEEN LPAD('100', 100) AND LPAD('200', 100) THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'rsdb/max_in_blocking_factor'  AND LPAD(VALUE, 100) NOT BETWEEN LPAD('100', 100) AND LPAD('200', 100) THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '100 to 200)'
          WHEN PARAMETER_NAME = 'rsdb/max_blocking_factor'     AND VALUE = '50' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'rsdb/max_blocking_factor'     AND VALUE != '50' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '50)'
          WHEN PARAMETER_NAME = 'dbs/hdb/cmd_buffersize'       AND LPAD(VALUE, 100) BETWEEN LPAD('2097152', 100) AND LPAD('10485760', 100) THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/cmd_buffersize'       AND LPAD(VALUE, 100) NOT BETWEEN LPAD('2097152', 100) AND LPAD('10485760', 100) THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '2097152 to 10485760)'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND ( VERSION = 2 AND REVISION >= 40 OR VERSION >= 3 ) AND COMPOSITE_STATISTICS_STRIPING = 'numa' THEN 'okay' || CHAR(32) || '(' || VALUE || ', composite_statistics_striping = numa)'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS < 500 AND VALUE IN ('not set', '1000') THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS < 500 AND NOT VALUE IN ('not set', '1000') THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '1000 or not set),' || CHAR(32) || NUM_WPS || CHAR(32) || 'WPs'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 500 AND 999 AND VALUE = '500' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 500 AND 999 AND VALUE != '500' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '500),' || CHAR(32) || NUM_WPS || CHAR(32) || 'WPs'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 1000 AND 1999 AND VALUE = '300' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 1000 AND 1999 AND VALUE != '300' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '300),' || CHAR(32) || NUM_WPS || CHAR(32) || 'WPs'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 2000 AND 3999 AND VALUE = '200' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS BETWEEN 2000 AND 3999 AND VALUE != '200' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '200),' || CHAR(32) || NUM_WPS || CHAR(32) || 'WPs'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS >= 4000 AND VALUE = '100' THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'dbs/hdb/stmt_cache_size'      AND NUM_WPS >= 4000 AND VALUE != '100' THEN 'wrong' || CHAR(32) || '(' || VALUE || CHAR(32) || 'instead of' || CHAR(32) || '100),' || CHAR(32) || NUM_WPS || CHAR(32) || 'WPs'
          WHEN PARAMETER_NAME = 'rsdb/tbi_buffer_area_MB'      AND LPAD(VALUE, 100) >= LPAD('1000', 100) THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'rsdb/tbi_buffer_area_MB'      AND LPAD(VALUE, 100)  < LPAD('1000', 100) THEN 'wrong (' || VALUE || CHAR(32) || 'instead of >= 1000)'
          WHEN PARAMETER_NAME = 'rsdb/tbi_dir_entries'         AND LPAD(VALUE, 100) >= LPAD('20000', 100) THEN 'okay' || CHAR(32) || '(' || VALUE || ')'
          WHEN PARAMETER_NAME = 'rsdb/tbi_dir_entries'         AND LPAD(VALUE, 100)  < LPAD('20000', 100) THEN 'wrong (' || VALUE || CHAR(32) || 'instead of >= 20000)'
        END
      FROM
      ( SELECT COMPOSITE_STATISTICS_STRIPING FROM PARAMETER_SETTINGS ) P,
      ( SELECT
          R.VERSION,
          R.REVISION,
          WP.NUM_WPS,
          PN.CHECK_NAME,
          PN.PARAMETER_NAME,
          IFNULL(PH.VALUE, 'not set') VALUE
        FROM
          HANA_RELEASE R,
          WORK_PROCESSES WP,
        ( SELECT 'RSDB_PREFER_JOIN_WITH_FDA' CHECK_NAME, 'rsdb/prefer_join_with_fda' PARAMETER_NAME FROM DUMMY UNION ALL
          SELECT 'DBS_HDB_PREFER_JOIN_WITH_FDA',         'dbs/hdb/prefer_join_with_fda'             FROM DUMMY UNION ALL
          SELECT 'RSDB_SUPPORTS_FDA_PROT',               'rsdb/supports_fda_prot'                   FROM DUMMY UNION ALL
          SELECT 'DBS_HDB_SUPPORTS_FDA_PROT',            'dbs/hdb/supports_fda_prot'                FROM DUMMY UNION ALL
          SELECT 'RSDB_PREFER_UNION_ALL',                'rsdb/prefer_union_all'                    FROM DUMMY UNION ALL
          SELECT 'RSDB_MAX_IN_BLOCKING_FACTOR',          'rsdb/max_in_blocking_factor'              FROM DUMMY UNION ALL
          SELECT 'RSDB_MAX_BLOCKING_FACTOR',             'rsdb/max_blocking_factor'                 FROM DUMMY UNION ALL
          SELECT 'DBS_HDB_CMD_BUFFERSIZE',               'dbs/hdb/cmd_buffersize'                   FROM DUMMY UNION ALL
          SELECT 'DBS_HDB_STMT_CACHE_SIZE',              'dbs/hdb/stmt_cache_size'                  FROM DUMMY UNION ALL
          SELECT 'ABAP_TABLE_BUFFER_SIZE',               'rsdb/tbi_buffer_area_MB'                  FROM DUMMY UNION ALL
          SELECT 'ABAP_TABLE_BUFFER_SLOTS',              'rsdb/tbi_dir_entries'                     FROM DUMMY
        ) PN LEFT OUTER JOIN
        ( SELECT
            PARAMETER_NAME,
            VALUE
          FROM
          ( SELECT
              PARNAME PARAMETER_NAME,
              CASE
                WHEN PARSTATE = 'D' THEN 'not set'
                ELSE TO_VARCHAR(PARVALUE)
              END VALUE,
              ROW_NUMBER() OVER (PARTITION BY PARNAME ORDER BY PARDATE DESC, PARSTATE, LPAD(TO_VARCHAR(PARVALUE), 999, CHAR(32))) ROWNO
            FROM
              PAHI
            WHERE
              PARSTATE IN ( 'A', 'C', 'D' )
          )
          WHERE
            ROWNO = 1
        ) PH ON
          PH.PARAMETER_NAME = PN.PARAMETER_NAME
      )
    )
    UNION ALL
    ( SELECT
        'UPDATES_CANCELLED',
        TO_VARCHAR(COUNT(*))
      FROM
        VBHDR H,
        VBERROR E
      WHERE
        H.VBKEY = E.VBKEY AND
        SECONDS_BETWEEN(TO_TIMESTAMP(H.VBDATE, 'YYYYMMDDHH24MISS'), CURRENT_TIMESTAMP) >= 86400
    )
    UNION ALL
    ( SELECT
        'UPDATES_STARTED',
        TO_VARCHAR(COUNT(*))
      FROM
        VBHDR
      WHERE
        VBRC = 246 AND
        SECONDS_BETWEEN(TO_TIMESTAMP(VBDATE, 'YYYYMMDDHH24MISS'), CURRENT_TIMESTAMP) >= 86400
    )
    UNION ALL
    ( SELECT
        'CANCELLED_BATCH_JOBS',
        TO_VARCHAR(TO_DECIMAL(COUNT(*) / MAX(BI.SHORTTERM_DAYS), 10, 0))
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        TBTCO J ON
          STATUS = 'A' AND
          ( ENDDATE != '' AND SECONDS_BETWEEN(TO_TIMESTAMP(ENDDATE || ENDTIME, 'YYYYMMDDHH24MISS'), CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS OR
            STRTDATE != '' AND SECONDS_BETWEEN(TO_TIMESTAMP(STRTDATE || STRTTIME, 'YYYYMMDDHH24MISS'), CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
          )
    )
    UNION ALL
    ( SELECT
        'LONGEST_RUNNING_BATCH_JOB',
        IFNULL(TO_VARCHAR(MAX(DURATION_S)), '0')
      FROM
      ( SELECT
          MAP(STRTDATE, '', 0, SECONDS_BETWEEN(TO_TIMESTAMP(STRTDATE || STRTTIME, 'YYYYMMDDHH24MISS'), MAP(ENDDATE, '', CURRENT_TIMESTAMP, TO_TIMESTAMP(ENDDATE || ENDTIME, 'YYYYMMDDHH24MISS')))) DURATION_S
        FROM
        ( SELECT
            JOBNAME,
            STRTDATE,
            STRTTIME,
            ENDDATE,
            ENDTIME
          FROM
          ( SELECT
              JOBNAME,
              STRTDATE,
              STRTTIME,
              ENDDATE,
              ENDTIME,
              STATUS,
              ',' || STRING_AGG(PROGNAME, ',' ORDER BY PROGNAME) || ',' PROG_NAMES
            FROM
              V_OP
            GROUP BY
              JOBNAME,
              STRTDATE,
              STRTTIME,
              ENDDATE,
              ENDTIME,
              STATUS
          )
          WHERE
            STRTDATE != '00000000' AND
            STATUS = 'R' AND
            PROG_NAMES NOT LIKE '%,/SCWM/R_MFS_PERIODCHK_PREP,%'         /* runs in endless loop, so long job runtimes are normal and not critical */
        )
      )
    )
    UNION ALL
    ( SELECT
        'ORPHAN_BALDAT_ENTRIES',
        TO_VARCHAR(COUNT(*))
      FROM
        BALDAT
      WHERE
        RELID = 'AL' AND
        LOG_HANDLE NOT IN ( SELECT LOG_HANDLE FROM BALHDR )
    )
    UNION ALL
    ( SELECT
        'UNNECESSARY_DBTABLOG_ENTRIES',
        TO_VARCHAR(COUNT(*))
      FROM
        DBTABLOG
      WHERE
        TABNAME IN
        ( '/SAPAPO/TSTROBJR', '/VIRSA/ZFFCDHDR', '/VIRSA/ZFFTNSLOG', '/VIRSA/ZVIRFFLOG', 'ALPFASSIGN', 'BKK40', 'BKK42', 'BKK45', 'BKK46', 'BKK98', 'BKKSONT',
          'DB6TREORG', 'DB6IREORG', 'DFKKCOLL', 'DFKKCOLLH', 'EVER', 'FMSNRULE', 'FMSNRULEC', 'FMDECKHK', 'FMDECKRG', 'FMDECKRGT', 'FMDECKUNG', 'FMUDRULE', 'FMUDRULEC', 'IST_TDATA',
          'KONP', 'LOGIC_DEST', 'SKAT', 'SKAS', 'SKA1', 'SKB1', 'SWD_HEADER', 'T811F', 'T811K', 'T811C', 'T811S', 'T811L', 'T811G', 'T811C', 'TE107', 'TF260', 'TF261', 'TF270', 'TF271',
          'TRACT_POSCONTEXT', 'TRLT_DERIVFLOWS', 'TTSTR', 'T006', 'T006A', 'T006B', 'T006C', 'T006D', 'T006T', 'T006I', 'T006J', 'T009', 'T009B', 'T009C', 'T009Y', 'T009T', 
          'TCALS', 'TCURF', 'TCURR', 'TCURS', 'TCURT', 'TCURV', 'TCURW', 'TCURC', 'TCURX', 'TCURN', 'THOL', 'THOLU', 'THOLT', 'TFACD', 'TFACS', 'TFAIN', 'THOC', 'THOCD', 'THOCI', 
          'THOCS', 'THOCT', 'TFACT', 'TFAIT'
        ) OR
        TABNAME LIKE 'CRMM_PRP%'
    )
    UNION ALL
    ( SELECT
        'SAP_END_OF_JOB_BATCH_JOBS',
        TO_VARCHAR(COUNT(*))
      FROM
        TBTCO
      WHERE
        STATUS IN ('P', 'S') AND
        EVENTID = 'SAP_END_OF_JOB' AND
        SDLDATE NOT IN ('00000000', '') AND
        DAYS_BETWEEN(TO_TIMESTAMP(SDLDATE, 'YYYYMMDD'), CURRENT_TIMESTAMP) >= 100
    )
    UNION ALL
    ( SELECT
        'CORRESPONDENCE_LANGUAGES',
        TO_VARCHAR(COUNT(*))
      FROM
        T002C
      WHERE
        SPRAS IN ( '(', ')', ',', '.', CHAR(32), '/', ':', CHAR(59), '&' )
    )
    UNION ALL
    ( SELECT /* NGAP / BYD specific */
        'OLD_D_CLUSTER_ENTRIES',
        TO_VARCHAR(TO_DECIMAL(MAP(TOTAL_RECORDS, 0, 0, OLD_RECORDS / TOTAL_RECORDS * 100), 10, 2))
      FROM
      ( SELECT
          COUNT(*) TOTAL_RECORDS,
          SUM(CASE WHEN DAYS_BETWEEN(TO_DATE(SUBSTR(H.CHANGEDATETIME, 1, 8), 'YYYYMMDD'), CURRENT_TIMESTAMP) > 365 * 1.25 THEN 1 ELSE 0 END) OLD_RECORDS
        FROM
          "/ISPCD/D_HEADER" H,
          "/ISPCD/D_CLUSTER" C
        WHERE
          H.CLIENT = C.CLIENT AND
          H.CHANGEDOCUMENTID = C.SRTFD
      )
    )
    UNION ALL
    ( SELECT
        'OLD_ARFC_RECORDS',
        TO_VARCHAR(COUNT(*))
      FROM
        ARFCSSTATE S,
        ARFCSDATA D
      WHERE
        S.ARFCIPID = D.ARFCIPID AND
        S.ARFCPID = D.ARFCPID AND
        S.ARFCTIME = D.ARFCTIME AND
        S.ARFCTIDCNT = D.ARFCTIDCNT AND
        S.ARFCDEST = D.ARFCDEST AND
        S.ARFCLUWCNT = D.ARFCLUWCNT AND
        DAYS_BETWEEN(TO_DATE(S.ARFCDATUM, 'YYYYMMDD'), CURRENT_DATE) > 30
    )
    UNION ALL
    ( SELECT
        'LONG_QRFC_OUTBOUND_QUEUES',
        IFNULL(QNAME || CHAR(32) || '(' || RECORDS || CHAR(32) || 'records)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          QNAME,
          COUNT(*) RECORDS
        FROM
          TRFCQOUT
        GROUP BY
          QNAME
        HAVING
          COUNT(*) >= 100000
      ) ON
        1 = 1
    )
  ) C
  WHERE
    C.NAME = CC.NAME AND
    ( BI.CHECK_ID = -1 OR CC.CHECK_ID = BI.CHECK_ID ) AND
    ( BI.EXCLUDE_MANUAL_CHECKS = ' ' OR CC.NAME != 'MANUAL_CHECK' )
) M
WHERE
  ONLY_POTENTIALLY_CRITICAL_RESULTS = ' ' OR POTENTIALLY_CRITICAL = 'X' OR M.CHECK_ID <= 10 OR M.CHECK_ID >= 9000
ORDER BY
  M.CHECK_ID,
  M.VALUE
WITH HINT (IGNORE_PLAN_CACHE)