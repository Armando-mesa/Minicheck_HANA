WITH 
/* 

[NAME]

- HANA_Configuration_MiniChecks_2.00.059.01+

[DESCRIPTION]

- General SAP HANA checks

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]


- The OPTIMIZATION_LEVEL(RULE_BASED) hint can be helpful to shorten M_CONTEXT_MEMORY related scans.
- The following checks are deprecated and no longer considered:

    ( SELECT  230, 'MEMORY_USED_CURRENT',          'Current memory utilization (%)',                  '1999997', '<=',       '90',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  231, 'MEMORY_USED_HISTORY',          'Time since memory utilization > 95 % (h)',        '1999997', '>=',       '12.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  232, 'CRIT_HYPERTHREADING_ACTIVE',   'Hyperthreading active in critical context',       '2711650', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  240, 'SWAP_SPACE_USED_CURRENT',      'Current swap utilization (GB)',                   '1999997', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  241, 'SWAP_SPACE_USED_HISTORY',      'Time since swap utilization > 1 GB (h)',          '1999997', '>=',       '480',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  310, 'MIN_IO_READ_THROUGHPUT_DATA',  'I/O read throughput data min. (MB/s, last day)',  '1999930', '>=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  311, 'AVG_IO_READ_THROUGHPUT_DATA',  'I/O read throughput data avg. (MB/s, last day)',  '1999930', '>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  320, 'MIN_IO_READ_THROUGHPUT_LOG',   'I/O read throughput log min. (MB/s, last day)',   '1999930', '>=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  321, 'AVG_IO_READ_THROUGHPUT_LOG',   'I/O read throughput log avg. (MB/s, last day)',   '1999930', '>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  325, 'MIN_IO_WRITE_THROUGHPUT_LOG',  'I/O write throughput log min. (MB/s, last day)',  '1999930', '>=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  326, 'AVG_IO_WRITE_THROUGHPUT_LOG',  'I/O write throughput log avg. (MB/s, last day)',  '1999930', '>=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  328, 'AVG_4K_WRITE_DURATION_LOG',    '4 KB write duration log avg. (ms)',               '1999930', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  350, 'HIGH_CRIT_SAVEPOINT_PHASE',    'Blocking savepoint phases > 10 s (mid-term)',     '2100009', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  352, 'MAX_CRIT_SAVEPOINT_PHASE',     'Blocking savepoint phase max. (s, mid_term)',     '2100009', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  356, 'SAVEPOINT_CRIT_THROUGHPUT',    'Savepoint crit. phase write throughput (MB/s)',   '2100009', '>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  365, 'WRONG_IO_PARAMETER_SETTINGS',  'Wrong SAP HANA I/O parameter settings',           '1999930', '=',        'no',        122.04,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  431, 'LAST_UNLOAD',                  'Time since last low memory column unload (days)', '2127458', '>=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  453, 'CONCAT_ATTRIBUTES_SIZE',       'Size of non-unique concat attributes (GB)',       '1986747', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  460, 'CALCENGINE_CACHE_UTILIZATION', 'Calc engine cache utilization (%)',               '2000002', '<=',       '70',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  515, 'INVERTED_HASH_ON_PART_TABLE',  'Partitioned tables with inverted hash indexes',   '2436619', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  546, 'SMALL_TABLES_DELTA_SIZE',      'Delta size of small auto merge tables (GB)',      '2057046', '<=',       '3.00',          -1,    99 FROM DUMMY ) UNION ALL
    ( SELECT  555, 'TABLES_MOVED_LOGICALLY',       'Tables / partitions moved only logically',        '2066313', '=',        '0',             -1,    82 FROM DUMMY ) UNION ALL
    ( SELECT  566, 'TREX_UDIV_FRAGMENTATION',      'Tables with fragmented $trex_udiv$ column',       '2112604', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  567, 'LARGE_CS_MVCC_TIMESTAMPS',     'Tables with MVCC timestamps > 5 GB',              '2112604', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  614, 'SQL_TRACE',                    'SQL trace enabled',                               '2031647', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  616, 'INDEXSERVER_PYTHON_TRACE',     'Indexserver python trace enabled',                '1935113', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  617, 'EXECUTOR_PYTHON_TRACE',        'Executor python trace enabled',                   '2020877', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  618, 'CLIENT_NETWORK_TRACE',         'SQL client network trace enabled',                '2222200', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  620, 'EXPENSIVE_SQL_TRACE_THLD',     'Minimum expensive SQL trace threshold (ms)',      '2180165', '>=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  630, 'DATABASE_TRACE_SETTINGS',      'Existence of database trace settings',            '2380176', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  635, 'USER_TRACE_SETTINGS',          'Existence of user specific trace settings',       '2119087', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  637, 'END_TO_END_TRACE_SETTINGS',    'Existence of end-to-end trace settings',          '2119087', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  639, 'NUM_TRACE_ENTRIES_HOUR',       'Number of trace entries (last hour)',             '2380176', '<=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  646, 'NUM_COMP_OOM_TRACEFILES',      'Number of statement OOM trace files (short-term)','1999997', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  660, 'CPU_TIME_MEASUREMENT',         'CPU time measurement enabled',                    '2100040', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  747, 'HOST_SQL_PLAN_CACHE_ZERO',     'Number of zero entries in HOST_SQL_PLAN_CACHE',   '2084747', '<=',       '1000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  765, 'STAT_SERVER_LOG_SEGMENT_SIZE', 'Log segment size of statisticsserver (MB)',       '2019148', '>=',       '1024',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  840, 'ACTIVE_UPDATE_TID_RANGE',      'Active update transaction ID range',              '2169283', '<=',       '3000000',       -1, 99.99 FROM DUMMY ) UNION ALL
    ( SELECT  842, 'ACTIVE_UPDATE_TRANS_DAY',      'Max. active update trans. ID range (last day)',   '2169283', '<=',       '8000000',       -1, 99.99 FROM DUMMY ) UNION ALL
    ( SELECT  845, 'MAX_UPDATE_TRANS_ID',          'Maximum update transaction ID',                   '2001840', '<=',       '3000000000',    64, 69.04 FROM DUMMY ) UNION ALL
    ( SELECT  850, 'MAX_GC_HISTORY_COUNT',         'Persistence garbage collection history count',    '2169283', '<=',       '3000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  884, 'DEVIATING_MAX_CONCURRENCY',    'Deviating max_concurrency used internally',       '2222250', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  930, 'AUTO_LOG_BACKUP',              'Automatic log backup',                            '1645183', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  935, 'DATABASE_LOG_MODE',            'Database log mode',                               '1645183', '=',        'normal',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1021, 'LOCKED_THREADS_LAST_DAY',      'Maximum threads waiting for locks (last day)',    '1999998', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1030, 'CONC_BLOCK_TRANS_HOUR',        'Concurrently blocked transactions (last hour)',   '1999998', '<=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1050, 'INTERNAL_LOCKS_LAST_HOUR',     'Significant internal lock waits (last hour)',     '1999998', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1112, 'TOP_SQL_THREADSAMPLES_CURR',   'SQL using in average > 1 thread (last hour)',     '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1115, 'LONGEST_CURRENT_SQL',          'Longest running current SQL statement (h)',       '2000002', '<=',       '12.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1132, 'SQL_CACHE_PER_SQL_CONNECTION', 'SQL cache size per SQL connection (MB)',          '2124112', '>=',       '15.00',         -1, 89.99 FROM DUMMY ) UNION ALL
    ( SELECT 1181, 'FDA_WRITE',                    'Avg. FDA write sessions (short-term)',            '2000002', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1260, 'QIWKTAB_ACCESSES',             'QIWKTAB update rate (updates / h)',               '2000002', '<=',       '10000',         -1, 89.99 FROM DUMMY ) UNION ALL
    ( SELECT 1330, 'USER_EXPIRATION',              'Number of users with expiration date',            '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1335, 'SAP_USER_PASSWORD_EXPIRATION', 'Number of SAP users with password expiration',    '1702224', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1362, 'ACTIVE_DML_AUDIT_POLICIES',    'Active DML audit policies',                       '2159014', '<=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1610, 'XSENGINE_LOG_SEGMENT_SIZE',    'Log segment size of xsengine (MB)',               '2062080', '>=',       '64',            -1,    82 FROM DUMMY ) UNION ALL
    ( SELECT 1710, 'PING_TIME_HOUR',               'Avg. load history ping time (ms, last hour)',     '2222110', '<=',       '500.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1720, 'NAMESERVER_LOCKFILE_LOCATION', 'Supported nameserver lock file location',         '2100296', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1840, 'SYNC_LOG_SHIPPING_TIME_CURR',  'Avg. sync log shipping time (ms/req, last hour)', '1999880', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1910, 'MAX_OBJECT_OID',               'Maximum object ID',                               '2155663', '<=',       '1000000000',    -1, 85.03 FROM DUMMY ) UNION ALL
    ( SELECT 1910, 'MAX_OBJECT_OID',               'Maximum object ID',                               '2155663', '<=',       '1000000000',    90,    95 FROM DUMMY ) UNION ALL
    ( SELECT 1930, 'SYNONYM_TABLE_NAMES',          'Synonyms with names identical to table name',     '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2030, 'BW_SCALEOUT_TWO_NODES',        'BW scale-out installation on 2 nodes',            '1702409', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2044, 'OLD_TEMP_CALCSCENARIOS',       'Old temporary calculation scenarios',             '2593719', '<=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2112, 'LAST_STATSERVER_CTC_RUN',      'Last consistency check via stat. server (days)',  '2116157', '<=',       '32',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2120, 'CORRUPTION_RISK_LARGE_TABLES', 'Large tables with risk of index corruption',      '2264778', '=',        '0',             -1,102.03 FROM DUMMY ) UNION ALL
    ( SELECT 2120, 'CORRUPTION_RISK_LARGE_TABLES', 'Large tables with risk of index corruption',      '2264778', '=',        '0',            110,   110 FROM DUMMY ) UNION ALL
    ( SELECT 2320, 'LAST_HDBCONS_EXECUTION',       'Time since last hdbcons execution (h)',           '2222218', '>=',       '24',            -1,    -1 FROM DUMMY ) UNION ALL

[VALID FOR]

- Revisions:              >= 2.00.059.01

[SQL COMMAND VERSION]

- 2014/04/13:  1.0 (initial version)
- 2014/05/09:  1.1 (grouping of checks)
- 2014/11/14:  1.2 (dedicated command for ESS)
- 2015/01/29:  1.3 (dedicated command for ESS and Rev. 90 and higher)
- 2015/11/12:  1.4 (dedicated command for Rev. 100 and higher)
- 2016/01/19:  1.5 (dedicated command for Rev. 102.01 and higher)
- 2016/10/28:  1.6 (dedicated command for Rev. 1.00.120 and higher)
- 2016/12/02:  1.7 (dedicated command for SAP HANA 2.0)
- 2017/05/11:  1.8 (dedicated command for SAP HANA 2.00.010)
- 2017/06/22:  1.9 (CHECK_ID and CHECK_GROUP filtering included)
- 2017/11/13:  2.0 (materialization of specific views via WITH to avoid error "[463]: number of tables exceeds its maximum: 4095")
- 2018/02/19:  2.1 (CHECK_ID_PREFIX included)
- 2018/06/25:  2.2 (dedicated 2.00.030+ version)
- 2019/03/14:  2.3 (SKIP_LESS_RELEVANT_CHECKS_IN_SYSTEMDB included)
- 2019/03/20:  2.4 (dedicated 2.00.040+ version)
- 2020/03/01:  2.5 (short-term, mid-term, long-term included)
- 2020/12/04:  2.6 (dedicated 2.00.053+ version)
- 2021/11/08:  2.7 (dedicated 2.00.059.01+ version including table optimization lock time)
- 2023/12/01:  2.8 (SKIP_OVERLAPPING_CHECKS_IN_SYSTEMDB included)

[INVOLVED TABLES]

- various

[INPUT PARAMETERS]

- HOST

  Host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- ONLY_POTENTIALLY_CRITICAL_RESULTS

  Possibility to restrict the output to potentially critical issues

  'X'             --> Output only contains issues that can potentially indicate a problem
  ' '             --> no output restriction

- SKIP_LESS_RELEVANT_CHECKS_IN_SYSTEMDB

  Possibility to skip some checks that often result in false alerts in MDC system database (e.g. high statistics server share or missing statement hint implementation)

  'X'             --> Skip less relevant checks in system database
  ' '             --> Perform all checks in system database

- SKIP_OVERLAPPING_CHECKS_IN_SYSTEMDB

  Possibility to skip some checks that deliver the same results in tenant and system DB and are typically more related to tenant load (e.g. host CPU).

  'X'             --> Skip overlapping checks in system database
  ' '             --> Perform all checks in system database

- MAX_VALUE_LENGTH

  Maximum length of VALUE output column

  48              --> Maximum length of 48 characters
  -1              --> no length limitation

- CHECK_ID

  Possibility to restrict the output to a specific check ID

  250             --> Restrict output to check ID 250
  -1              --> No restriction to a particular check ID

- CHECK_GROUP

  Possibility to restrict output to a specific check group (i.e. checks below a check group heading)

  'DISKS'         --> Perform checks for check group DISKS
  '%'             --> No restriction related to check groups

- CHECK_ID_PREFIX

  Prefix for CHID value

  'M'             --> Prefix check ID number with 'M' (e.g. 'M1234')
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

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'HOST'          --> Sorting by host name
  'CHECK'         --> Sorting by check identifier (CHID column)
  
[OUTPUT PARAMETERS]

- CHID:           Check identifier (defined and used by this Mini Check command)
- DESCRIPTION:    Check description
- HOST:           Host name (empty if not host specific)
- VALUE:          Check value found on the system
- EXPECTED_VALUE: Expected check values 
- C:              'X' if value found on the system is outside of the expected values (indication for potentially critical problem)
- SAP_NOTE:       Related SAP Note

[EXAMPLE OUTPUT]

------------------------------------------------------------------------------------------------------------------------------------------------------
|CHID |DESCRIPTION                                    |HOST     |VALUE                                            |EXPECTED_VALUE |C|DETAILS         |
------------------------------------------------------------------------------------------------------------------------------------------------------
|**** |GENERAL                                        |         |                                                 |               | |                |
|     |                                               |         |                                                 |               | |                |
|   10|Analysis date                                  |         |2014/05/30 12:27:35                              |               | |                |
|   11|Database name                                  |         |HP1                                              |               | |                |
|   12|Revision level                                 |         |1.00.74.00.390550 (NewDB100_REL)                 |               | |                |
|  110|Everything started                             |         |yes                                              |yes            | |                |
|  111|Startup time variation (s)                     |         |1108                                             |<= 600         |X|                |
|  120|License usage (%)                              |         |72                                               |<= 95          | |                |
|  121|License expiration (days)                      |         |never                                            |>= 100         | |SAP Note 1644792|
|  130|Database log mode                              |         |normal                                           |normal         | |                |
|  140|Time since statistics server run (s)           |         |26                                               |<= 3600        | |                |
|     |                                               |         |                                                 |               | |                |
...
|**** |SQL                                            |         |                                                 |               | |                |
|     |                                               |         |                                                 |               | |                |
| 1110|SQL statement allocating > 1 session (last day)|         |6ea8ae87f49702463799a8a2a51d840c (1.10 sessions) |none           |X|                |
| 1115|Longest running current SQL statement (s)      |         |24                                               |<= 600         | |                |
| 1120|Exp. stmt. trace: SQL running > 1 h (last day) |         |0                                                |0              | |                |
| 1130|SQL cache evictions / h                        |saphana20|5829                                             |<= 1000        |X|                |
|     |                                               |         |                                                 |               | |                |
|**** |APPLICATION                                    |         |                                                 |               | |                |
|     |                                               |         |                                                 |               | |                |
| 1210|DDLOG sequence cache size                      |         |1                                                |>= 2           |X|SAP Note 1977214|
|     |                                               |         |                                                 |               | |                |
|**** |SECURITY                                       |         |                                                 |               | |                |
|     |                                               |         |                                                 |               | |                |
| 1310|Secure store (SSFS) status                     |saphana20|available                                        |available      | |                |
|     |                                               |saphana21|available                                        |available      | |                |
| 1320|Number of users with activated auditing        |         |0                                                |0              | |                |
------------------------------------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT
    HOST,
    ONLY_POTENTIALLY_CRITICAL_RESULTS,
    SKIP_LESS_RELEVANT_CHECKS_IN_SYSTEMDB,
    SKIP_OVERLAPPING_CHECKS_IN_SYSTEMDB,
    MAX_VALUE_LENGTH,
    CHECK_ID,
    CHECK_GROUP,
    CHECK_ID_PREFIX,
    MAP(SHORTTERM_DAYS, -1, 99999, SHORTTERM_DAYS) SHORTTERM_DAYS,
    MAP(MIDTERM_DAYS, -1, 99999, MIDTERM_DAYS)  MIDTERM_DAYS,
    MAP(LONGTERM_DAYS, -1, 99999, LONGTERM_DAYS)  LONGTERM_DAYS,
    ORDER_BY
  FROM
  ( SELECT                                               /* Modification section */
      '%' HOST,
      ' ' ONLY_POTENTIALLY_CRITICAL_RESULTS,
      'X' SKIP_LESS_RELEVANT_CHECKS_IN_SYSTEMDB,
      'X' SKIP_OVERLAPPING_CHECKS_IN_SYSTEMDB,
      60 MAX_VALUE_LENGTH,
      -1 CHECK_ID,
      '%' CHECK_GROUP,
      'M' CHECK_ID_PREFIX,
      1 SHORTTERM_DAYS,
      7 MIDTERM_DAYS,
      31 LONGTERM_DAYS,
      'CHECK' ORDER_BY                            /* HOST, CHECK */
    FROM
      DUMMY
  )
),
SQL_DATA_AREAS AS
( SELECT 'Pool/AttributeEngine/Transient' ALLOCATOR              FROM DUMMY UNION ALL
  SELECT 'Pool/AttributeEngine/Transient/updateContainerConcat'  FROM DUMMY UNION ALL
  SELECT 'Pool/CalculationEngine/ceQOExecutor'                   FROM DUMMY UNION ALL
  SELECT 'Pool/CalculationEngine/query/pops'                     FROM DUMMY UNION ALL
  SELECT 'Pool/ColumnStoreTables/Delta'                          FROM DUMMY UNION ALL
  SELECT 'Pool/ColumnStoreTables/Main/Rowid/build-reverse-index' FROM DUMMY UNION ALL
  SELECT 'Pool/CSPlanExecutor/PlanExecution'                     FROM DUMMY UNION ALL
  SELECT 'Pool/DocidValueArray'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/ESX'                                              FROM DUMMY UNION ALL
  SELECT 'Pool/ExecutorPlanExecution'                            FROM DUMMY UNION ALL
  SELECT 'Pool/Federation/UniversalITab'                         FROM DUMMY UNION ALL
  SELECT 'Pool/Filter'                                           FROM DUMMY UNION ALL
  SELECT 'Pool/itab'                                             FROM DUMMY UNION ALL
  SELECT 'Pool/itab/expr'                                        FROM DUMMY UNION ALL
  SELECT 'Pool/itab/FindBlocks2'                                 FROM DUMMY UNION ALL
  SELECT 'Pool/itab/VectorColumn'                                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator'                                    FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/DictsAndDocs'                       FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAggregate'                        FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAggregate/Results'                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAssembleResults'                  FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAssembleResults/Results'          FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate'                        FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate/TmpResults'             FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate/Results'                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECreateNTuple'                     FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEEvalPrecond'                      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEPlanData/deserialized'            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEPreAggregate'                     FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JERequestedAttributes/Results'      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEStep1'                            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEStep2'                            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/NTuple'                             FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/PlanDataAttrVals/Deserialized'      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/ValueList'                          FROM DUMMY UNION ALL
  SELECT 'Pool/LargeObjectPool'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/L/llang/Runtime/Global'                           FROM DUMMY UNION ALL
  SELECT 'Pool/L/llang/Runtime/Local'                            FROM DUMMY UNION ALL
  SELECT 'Pool/LOBStorage'                                       FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcengine.so'                       FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcengineapi.so'                    FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcenginepops.so'                   FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcs.so'                               FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcswrapper.so'                        FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbdistmetadata.so'                     FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbevaluator.so'                        FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbitab.so'                             FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbolap.so'                             FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbunivitab.so'                         FROM DUMMY UNION ALL
  SELECT 'Pool/mds'                                              FROM DUMMY UNION ALL
  SELECT 'Pool/MDS/CellStorage/CellStorageTupleIndexer'          FROM DUMMY UNION ALL
  SELECT 'Pool/mds/CubeAxis'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/aggregates'                              FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/align'                                   FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/compactcol'                              FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/ihm'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/pop'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_aggregates'                         FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_dimensions'                         FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_other'                              FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/LOB'                                    FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/MonitorView%'                           FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryCompilation'                       FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryExecution'                         FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryExecution/SearchAlloc'             FROM DUMMY UNION ALL
  SELECT 'Pool/SearchAPI'                                        FROM DUMMY UNION ALL
  SELECT 'Pool/SearchAPI/Itab Search'                            FROM DUMMY UNION ALL
  SELECT 'Pool/SQLScript/Execution'                              FROM DUMMY UNION ALL
  SELECT 'Pool/StringContainer'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/Text/TextAttribute'                               FROM DUMMY UNION ALL
  SELECT 'Pool/ValueArray'                                       FROM DUMMY UNION ALL
  SELECT 'Pool/ValueArrayColumnDeserialize'                      FROM DUMMY UNION ALL
  SELECT 'Pool/XDictData'                                        FROM DUMMY
),
PHANTOM_THREADS AS
( SELECT 'AgentPingThread' THREAD_TYPE, 'Semaphore Wait' THREAD_STATE, 'DPPeriodicThreadWaitSemaphore' LOCK_NAME, '%' THREAD_METHOD, '%' THREAD_DETAIL, '%' CONN_ID FROM DUMMY UNION ALL
  SELECT 'BackupMonitor_TransferThread', 'Sleeping', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'ChildIOThreads::ErrorStream', 'Running', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'ChildIOThreads::OutputStream', 'Running', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'DPDistributor%', 'Semaphore Wait', 'DPCommitTranPersistentDistributorQueueReaderAvailableSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'DPReceiverCleaner%', 'Semaphore Wait', 'DPPersistentTranDataCleanerDataAvailableSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'DPReceiverWriter%', 'ConditionalVar% Wait', 'DPReceiverInboundQueueEmptyCond', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'Generic', 'Running', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'IndexingQueue', 'Sleeping', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Semaphore Wait', 'DPReceiverDispatcherHouseKeepingTaskAvailableSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Semaphore Wait', 'DPReceiverHouseKeepingTaskAvailableSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Semaphore Wait', 'hex_WorkerJob_Sleep_Sem', '%', 'Waits for client to fetch or syncs with other workers', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Semaphore Wait', 'hex_WorkersManager_Sleep_Sem', '%', 'waits for client to fetch', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Semaphore Wait', 'LogBackupQueue', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Network Poll', '%', 'generic', '%', '-1' FROM DUMMY UNION ALL
  SELECT 'JobWorker', 'Network Poll', '%', 'Request prologue', '%', '-1' FROM DUMMY UNION ALL
  SELECT 'LogExceptionQueueThread', 'Semaphore Wait', 'AdapterServiceFixedQueueListSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'LogRecovery', 'Semaphore Wait', 'LogRecoveryPointInTimeQueue', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'MaintenanceThread', 'Semaphore Wait', 'DPPeriodicThreadWaitSemaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'Native', '%', '%', '%', '%sysv_open_semaphore%', '%' FROM DUMMY UNION ALL
  SELECT 'PostCommitExecutor', 'ConditionalVar% Wait', 'RegularTaskQueueCV', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'PreprocessorPool', 'Network Poll', '%', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'PriPostCommitExecutor', 'ConditionalVar% Wait', 'PrioritizedTaskQueueCV', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'StatsThread', 'ConditionalVar% Wait', 'DPStatsThreadCond', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'PushBufferIntoReplayThread', 'Semaphore Wait', 'system replication: push buffer into replay semaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'SecondarySlaveLogPositionSendThread', 'Semaphore Wait', 'system replication: slave log position send semaphore', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'SystemReplicationAsyncLogSender', 'Semaphore Wait', 'system replication: AsyncLogBufferHandlerQueueSem', '%', '%', '%' FROM DUMMY UNION ALL
  SELECT 'WebDispatcher-Main-Thread', 'Running', '%', '%', '%', '%' FROM DUMMY
),
TEMP_INDEXES AS
( SELECT
    *
  FROM
    INDEXES
),
TEMP_INDEX_COLUMNS AS
( SELECT
    *
  FROM
    INDEX_COLUMNS
),
TEMP_M_BACKUP_CATALOG AS
( SELECT
    *
  FROM
    M_BACKUP_CATALOG
),
TEMP_M_BACKUP_CATALOG_FILES AS
( SELECT
    *
  FROM
    M_BACKUP_CATALOG_FILES
),
TEMP_M_CONNECTIONS AS
( SELECT
    *
  FROM
    M_CONNECTIONS
),
TEMP_M_CS_ALL_COLUMNS AS
( SELECT
    *
  FROM
    M_CS_ALL_COLUMNS
),
TEMP_M_CS_ALL_COLUMN_STATISTICS AS
( SELECT
    *
  FROM
    M_CS_ALL_COLUMN_STATISTICS
),
TEMP_M_CS_COLUMNS_PERSISTENCE AS
( SELECT
    *
  FROM
    M_CS_COLUMNS_PERSISTENCE
),
TEMP_M_CS_TABLES AS
( SELECT
    *
  FROM
    M_CS_TABLES
),
TEMP_M_EXPENSIVE_STATEMENTS AS
( SELECT
    *
  FROM
    M_EXPENSIVE_STATEMENTS
),
TEMP_M_MVCC_TABLES AS
( SELECT
    *
  FROM
    M_MVCC_TABLES
),
TEMP_M_RS_INDEXES AS
( SELECT
    *
  FROM
    M_RS_INDEXES
),
TEMP_M_RS_MEMORY AS
( SELECT
    *
  FROM
    M_RS_MEMORY
),
TEMP_M_RS_TABLES AS
( SELECT
    *
  FROM
    M_RS_TABLES
),
TEMP_M_SERVICE_COMPONENT_MEMORY AS
( SELECT
    *
  FROM
    M_SERVICE_COMPONENT_MEMORY
),
TEMP_M_SERVICE_NETWORK_IO AS
( SELECT
    *
  FROM
    M_SERVICE_NETWORK_IO
), 
TEMP_M_SQL_PLAN_CACHE AS
( SELECT
    *
  FROM
    M_SQL_PLAN_CACHE
),
TEMP_M_SQL_PLAN_CACHE_OVERVIEW AS
( SELECT
    *
  FROM
    M_SQL_PLAN_CACHE_OVERVIEW
),
TEMP_M_TABLE_PERSISTENCE_STATISTICS AS
( SELECT
    *
  FROM
    M_TABLE_PERSISTENCE_STATISTICS
),
TEMP_M_TABLES AS
( SELECT
    *
  FROM
    M_TABLES
),
TEMP_M_TEMPORARY_TABLES AS
( SELECT
    *
  FROM
    M_TEMPORARY_TABLES
),
TEMP_M_TRANSACTIONS AS
( SELECT
    *
  FROM
    M_TRANSACTIONS
),
TEMP_M_VOLUME_FILES AS
( SELECT
    *
  FROM
    M_VOLUME_FILES
),
TEMP_TABLE_COLUMNS AS
( SELECT
    *
  FROM
    TABLE_COLUMNS
),
TEMP_TABLE_PARTITIONS AS
( SELECT
    *
  FROM
    TABLE_PARTITIONS
),
TEMP_TABLES AS
( SELECT
    *
  FROM
    TABLES
),
TEMP_M_TABLE_LOB_STATISTICS AS
( SELECT
    *
  FROM
    M_TABLE_LOB_STATISTICS
),
TEMP_OBJECT_DEPENDENCIES AS
( SELECT
    *
  FROM
    OBJECT_DEPENDENCIES
),
TEMP_OBJECTS AS
( SELECT
    *
  FROM
    OBJECTS
),
TEMP_PARTITIONED_TABLES AS
( SELECT
    *
  FROM
    PARTITIONED_TABLES
),
TEMP_HOST_LOG_PARTITIONS AS
( SELECT
    *
  FROM
  ( SELECT
      LP.HOST,
      LP.SERVER_TIMESTAMP,
      LP.MAX_COMMIT_IO_LATENCY,
      COMMIT_COUNT - LAG(COMMIT_COUNT) OVER (PARTITION BY HOST, PORT, PATH ORDER BY SERVER_TIMESTAMP) COMMIT_COUNT_DELTA,
      SUM_COMMIT_IO_LATENCY - LAG(SUM_COMMIT_IO_LATENCY) OVER (PARTITION BY HOST, PORT, PATH ORDER BY SERVER_TIMESTAMP) SUM_COMMIT_IO_LATENCY_DELTA,
      MAX_COMMIT_IO_LATENCY - LAG(MAX_COMMIT_IO_LATENCY) OVER (PARTITION BY HOST, PORT, PATH ORDER BY SERVER_TIMESTAMP) MAX_COMMIT_IO_LATENCY_DELTA
    FROM
      _SYS_STATISTICS.HOST_LOG_PARTITIONS LP
  )
  WHERE
    COMMIT_COUNT_DELTA >= 0 AND
    SUM_COMMIT_IO_LATENCY_DELTA >= 0
),
GENERAL_INFO AS
( SELECT
    ALLOC_LIM_GB + MAP(PMEM_USED, 'X', PMEM_SIZE_GB, 0) ALLOC_LIM_GB,
    TOTAL_ALLOC_LIM_GB + MAP(PMEM_USED, 'X', PMEM_SIZE_GB, 0) TOTAL_ALLOC_LIM_GB,
    COL_MEM_GB,
    DATA_DISK_GB,
    DB_TYPE,
    PMEM_USED,
    FRO_USED,
    REVISION,
    STARTUP_TIME,
    IFNULL(THREAD_SAMPLES_FILTER_FACTOR, 50) THREAD_SAMPLES_FILTER_FACTOR,
    UPTIME_S
  FROM
  ( SELECT
      IFNULL(TO_NUMBER(VALUE), 50) THREAD_SAMPLES_FILTER_FACTOR
    FROM
      DUMMY LEFT OUTER JOIN
      _SYS_STATISTICS.STATISTICS_PROPERTIES ON
        KEY = 'internal.thread.samples'
  ),
  ( SELECT
      MAX(LEAST(GLOBAL_ALLOC_LIM_GB, SERVICE_ALLOC_LIM_GB)) ALLOC_LIM_GB,
      SUM(LEAST(GLOBAL_ALLOC_LIM_GB, SERVICE_ALLOC_LIM_GB)) TOTAL_ALLOC_LIM_GB
    FROM
    ( SELECT
        S.HOST,
        MAX(H.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 GLOBAL_ALLOC_LIM_GB,
        MAX(S.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 SERVICE_ALLOC_LIM_GB
      FROM
        M_DATABASE D,
        M_HOST_RESOURCE_UTILIZATION H,
        M_SERVICE_MEMORY S
      WHERE
        H.HOST = S.HOST AND
        ( D.DATABASE_NAME = 'SYSTEMDB' AND S.SERVICE_NAME = 'nameserver' OR
          S.SERVICE_NAME = 'indexserver'
        ) 
      GROUP BY
        S.HOST
    )
  ),
  ( SELECT
      SUM(USED_SIZE) / 1024 / 1024 / 1024 DATA_DISK_GB
    FROM 
      M_VOLUME_FILES
    WHERE 
      FILE_TYPE = 'DATA'
  ),
  ( SELECT
      MAX(START_TIME) STARTUP_TIME,
      MIN(SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP)) UPTIME_S
    FROM
      M_DATABASE
  ),
  ( SELECT
      SUM(MEMORY_SIZE_IN_TOTAL + PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 COL_MEM_GB
    FROM
      TEMP_M_CS_TABLES
  ),
  ( SELECT
      CASE WHEN MAX(P.VALUE) = 'multidb' AND MAX(D.DATABASE_NAME) = 'SYSTEMDB' THEN 'SYSTEMDB' ELSE 'TENANT' END DB_TYPE
    FROM
      M_CONFIGURATION_PARAMETER_VALUES P,
      M_DATABASE D
    WHERE
      P.FILE_NAME = 'global.ini' AND
      P.SECTION = 'multidb' AND
      P.KEY = 'mode'
  ),
  ( SELECT
      TO_NUMBER(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) ||
      MAP(LOCATE(VALUE, '.', 1, 4), 0, '', '.' || SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 3) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) - 1 ))) REVISION 
    FROM 
      M_SYSTEM_OVERVIEW 
    WHERE 
      SECTION = 'System' AND 
      NAME = 'Version' 
  ),
  ( SELECT
      MAP(COUNT(*), 0, ' ', 'X') PMEM_USED,
      IFNULL(SUM(TOTAL_SIZE) / 1024 / 1024 / 1024, 0) PMEM_SIZE_GB
    FROM
    ( SELECT
        HOST,
        MAX(TOTAL_SIZE) TOTAL_SIZE
      FROM
      ( SELECT
          HOST,
          PORT,
          SUM(TOTAL_SIZE) TOTAL_SIZE
        FROM
          M_PERSISTENT_MEMORY_VOLUMES
        WHERE
          FILESYSTEM_TYPE != 'tmpfs'
        GROUP BY
          HOST,
          PORT
      )
      GROUP BY
        HOST
    )
  ),
  ( SELECT
      MAP(COUNT(*), 0, ' ', 'X') FRO_USED,
      IFNULL(SUM(TOTAL_SIZE) / 1024 / 1024 / 1024, 0) FRO_SIZE_GB
    FROM
    ( SELECT
        HOST,
        MAX(TOTAL_SIZE) TOTAL_SIZE
      FROM
      ( SELECT
          HOST,
          PORT,
          SUM(TOTAL_SIZE) TOTAL_SIZE
        FROM
          M_PERSISTENT_MEMORY_VOLUMES
        WHERE
          FILESYSTEM_TYPE = 'tmpfs'
        GROUP BY
          HOST,
          PORT
      )
      GROUP BY
        HOST
    )
  )
)
SELECT
  CASE 
    WHEN NAME = 'BLANK_LINE' THEN ''
    WHEN NAME = 'INFO_LINE' THEN '****' 
    WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 OR ORDER_BY = 'HOST' THEN LPAD(MAP(CHECK_ID_PREFIX, '', CHECK_ID, CHECK_ID_PREFIX || LPAD(CHECK_ID, 4, 0)), 5) 
    ELSE '' 
  END CHID,
  CASE WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 OR ORDER_BY = 'HOST' THEN DESCRIPTION ELSE '' END DESCRIPTION,
  IFNULL(HOST, '') HOST,
  MAP(VALUE, '999999', 'never', '999999.00', 'never', '-999999', 'never', '-999999.00', 'never', NULL, 'n/a', 
    CASE WHEN MAX_VALUE_LENGTH = -1 OR LENGTH(VALUE) <= MAX_VALUE_LENGTH THEN VALUE 
      ELSE SUBSTR(VALUE, 1, VALUE_FRAGMENT_LENGTH) || '...' || SUBSTR(VALUE, LENGTH(VALUE) - (VALUE_FRAGMENT_LENGTH - 1), VALUE_FRAGMENT_LENGTH) END) VALUE,
  CASE
    WHEN EXPECTED_OP = 'any'     THEN ''
    WHEN EXPECTED_OP = '='       THEN EXPECTED_VALUE
    WHEN EXPECTED_OP = 'like'    THEN EXPECTED_OP || CHAR(32) || CHAR(39) || EXPECTED_VALUE || CHAR(39)
    WHEN EXPECTED_OP = 'between' THEN SUBSTR(EXPECTED_VALUE, 1, LOCATE(EXPECTED_VALUE, '-') - 1) || CHAR(32) || 'to' || CHAR(32) || SUBSTR(EXPECTED_VALUE, LOCATE(EXPECTED_VALUE, '-') + 1)
    ELSE EXPECTED_OP || CHAR(32) || EXPECTED_VALUE
  END EXPECTED_VALUE,
  POTENTIALLY_CRITICAL C,
  LPAD(SAP_NOTE, 8) SAP_NOTE
FROM
( SELECT
    CC.CHECK_ID,
    CC.NAME,
    CC.DESCRIPTION,
    C.HOST,
    C.VALUE,
    CC.SAP_NOTE,
    CC.EXPECTED_OP,
    CC.EXPECTED_VALUE,
    CASE
      WHEN C.VALUE IN ('999999', '999999.00', '-999999', '-999999.00') AND CC.CHECK_ID IN (909, 2113)             THEN 'X'
      WHEN C.VALUE IN ('999999', '999999.00', '-999999', '-999999.00') AND CC.CHECK_ID NOT IN (909, 2113)         THEN ' '
      WHEN CC.EXPECTED_OP = 'any' OR UPPER(C.VALUE) = 'NONE' OR UPPER(C.VALUE) = 'N/A'                            THEN ' '
      WHEN CC.EXPECTED_OP = 'not'      AND LPAD(UPPER(C.VALUE), 100) =        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '='        AND LPAD(UPPER(C.VALUE), 100) !=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>='       AND LPAD(UPPER(C.VALUE), 100) <        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>'        AND LPAD(UPPER(C.VALUE), 100) <=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60) || '=' AND LPAD(UPPER(C.VALUE), 100) >   LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60)   AND LPAD(UPPER(C.VALUE), 100) >=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = 'between'  AND ( LPAD(UPPER(C.VALUE), 100) <      LPAD(UPPER(SUBSTR(CC.EXPECTED_VALUE, 1, LOCATE(CC.EXPECTED_VALUE, '-') - 1)), 100) OR
                                             LPAD(UPPER(C.VALUE), 100) >      LPAD(UPPER(SUBSTR(CC.EXPECTED_VALUE, LOCATE(CC.EXPECTED_VALUE, '-') + 1)), 100) ) THEN 'X'
      WHEN CC.EXPECTED_OP = 'like'     AND UPPER(C.VALUE)            NOT LIKE UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      WHEN CC.EXPECTED_OP = 'not like' AND UPPER(C.VALUE)            LIKE     UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      ELSE ''
    END POTENTIALLY_CRITICAL,
    BI.ONLY_POTENTIALLY_CRITICAL_RESULTS,
    BI.MAX_VALUE_LENGTH,
    FLOOR(BI.MAX_VALUE_LENGTH / 2 - 0.5) VALUE_FRAGMENT_LENGTH,
    BI.CHECK_ID_PREFIX,
    BI.ORDER_BY,
    ROW_NUMBER () OVER ( PARTITION BY CC.DESCRIPTION ORDER BY C.HOST, C.VALUE ) ROW_NUM
  FROM
/* TMC_GENERATION_START_1 */
  ( SELECT
      'REVISION_LEVEL' NAME,
      '' HOST,
      MAP(VALUE, '.00', '0.00', VALUE) VALUE
    FROM
    ( SELECT
        LTRIM(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 2) - 1), '0') VALUE
      FROM 
        M_SYSTEM_OVERVIEW 
      WHERE 
        SECTION = 'System' AND 
        NAME = 'Version' 
    )
    UNION ALL
    ( SELECT
        'CONFIGURED_TIME_INTERVALS',
        '',
        'short-term: ' || SHORTTERM_DAYS || ', mid-term: ' || MIDTERM_DAYS || ', long-term: ' || LONGTERM_DAYS
      FROM
        BASIS_INFO
    )
    UNION ALL
    ( SELECT
        'VERSION_LEVEL',
        '',
        SUBSTR(VALUE, 1, 3)
      FROM
        M_SYSTEM_OVERVIEW 
      WHERE 
        SECTION = 'System' AND 
        NAME = 'Version' 
    )
    UNION ALL
    ( SELECT
        'GENERATED_WITH',
        '',
        'SQL: "HANA_Configuration_MiniChecks"'
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'CHECK_VERSION',
        '',
        '2.00.059.01+ / 2.7.55 (2024/08/17)'
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'BLANK_LINE',
        '',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'INFO_LINE',
        '',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'EVERYTHING_STARTED',
        '',
        LOWER(VALUE)
      FROM
        M_SYSTEM_OVERVIEW
      WHERE
        SECTION = 'Services' AND
        NAME = 'All Started'
    )
    UNION ALL
    ( SELECT /* no longer relevant with RHEL >= 7.x and SLES 12.x where usually the intel_pstate driver is used */
        'SLOW_CPU',
        H1.HOST,
        H1.VALUE
      FROM
        M_LANDSCAPE_HOST_CONFIGURATION L,
        M_HOST_INFORMATION H1,
        M_HOST_INFORMATION H2
      WHERE
        L.HOST = H1.HOST AND
        H1.HOST = H2.HOST AND
        L.HOST_CONFIG_ROLES != 'STREAMING' AND
        H1.HOST = H2.HOST AND
        H1.KEY = 'cpu_clock' AND
        H2.KEY = 'os_name' AND
        ( H2.VALUE LIKE 'SUSE Linux Enterprise Server 11%' OR
          H2.VALUE LIKE 'Red Hat Enterprise Linux %6.%' OR
          H2.VALUE LIKE 'Linux 2.6.32%'
        )
    )
    UNION ALL
    ( SELECT  /* no longer relevant with RHEL >= 7.x and SLES 12.x where usually the intel_pstate driver is used */
        'VARYING_CPU',
        '',
        CASE WHEN MAX(H1.VALUE) IS NULL OR MAX(H1.VALUE) - MIN(H1.VALUE) < 100 THEN 'no' ELSE 'yes' END
      FROM
        M_LANDSCAPE_HOST_CONFIGURATION L,
        M_HOST_INFORMATION H1,
        M_HOST_INFORMATION H2
      WHERE
        L.HOST = H1.HOST AND
        H1.HOST = H2.HOST AND
        L.HOST_CONFIG_ROLES != 'STREAMING' AND
        H1.KEY = 'cpu_clock' AND
        H2.KEY = 'os_name' AND
        ( H2.VALUE LIKE 'SUSE Linux Enterprise Server 11%' OR
          H2.VALUE LIKE 'Red Hat Enterprise Linux %6.%' OR
          H2.VALUE LIKE 'Linux 2.6.32%'
        )
    )
    UNION ALL
    ( SELECT
        'HOST_START_TIME_VARIATION',
        '',
        TO_VARCHAR(MAX(SECONDS_BETWEEN(MIN_TIME, MAX_TIME)))
      FROM
      ( SELECT
          MIN(VALUE) MIN_TIME,
          MAX(VALUE) MAX_TIME
        FROM
          M_HOST_INFORMATION H,
          M_LANDSCAPE_HOST_CONFIGURATION L
        WHERE
          H.HOST = L.HOST AND
          H.KEY = 'start_time' AND
          L.HOST_CONFIG_ROLES != 'STREAMING'
      )
    )
    UNION ALL
    ( SELECT 
        'PERFORMANCE_TRACE',
        '',
        MAP(STATUS, 'STOPPED', 'no', 'yes') 
      FROM 
        M_PERFTRACE
    )
    UNION ALL
    ( SELECT 
        'FUNCTION_PROFILER',
        '',
        CASE WHEN STATUS != 'STOPPED' AND FUNCTION_PROFILER != 'FALSE' THEN 'yes' ELSE 'no' END
      FROM 
        M_PERFTRACE
    )
    UNION ALL
    ( SELECT
        'LOG_WAIT_RATIO',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(
          CASE
          WHEN SUM(SWITCH_NOWAIT_COUNT) + SUM(SWITCH_WAIT_COUNT) = 0 THEN 0
          ELSE SUM(SWITCH_WAIT_COUNT) / (SUM(SWITCH_NOWAIT_COUNT) + SUM(SWITCH_WAIT_COUNT)) * 100 END ), 10, 0 ) ) 
      FROM
        M_LOG_BUFFERS
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'LOG_RACE_RATIO',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(
          CASE
          WHEN SUM(SWITCH_NOWAIT_COUNT) + SUM(SWITCH_OPEN_COUNT) = 0 THEN 0
          ELSE SUM(SWITCH_OPEN_COUNT) / (SUM(SWITCH_NOWAIT_COUNT) + SUM(SWITCH_OPEN_COUNT)) * 100 END ), 10, 0 ) ) 
      FROM
        M_LOG_BUFFERS
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'OPEN_ALERTS_HIGH',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_CURRENT_ALERTS
      WHERE
        ALERT_RATING = 4
    )
    UNION ALL
    ( SELECT
        'OPEN_ALERTS_ERROR',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_CURRENT_ALERTS
      WHERE
        ALERT_RATING = 5
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_INTERNAL_ERRORS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.STATISTICS_ALERTS A
      WHERE
        A.ALERT_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS) AND
        A.ALERT_ID = 0
    )
    UNION ALL
    ( SELECT
        'CHECKS_NOT_RUNNING',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        STATUS != 'Inactive' AND
        SECONDS_BETWEEN(LATEST_START_SERVERTIME, CURRENT_TIMESTAMP) / 2 > INTERVALLENGTH
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_NO_WORKERS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICE_THREADS
      WHERE
        THREAD_TYPE LIKE 'WorkerThread%'
    )
    UNION ALL
    ( SELECT
        'OPEN_EVENTS',
        HOST,
        TO_VARCHAR(SUM(MAP(ACKNOWLEDGED, 'FALSE', 1, 0)))
      FROM
        DUMMY LEFT OUTER JOIN
        M_EVENTS ON
          ACKNOWLEDGED = 'FALSE' AND
          SECONDS_BETWEEN(CREATE_TIME, CURRENT_TIMESTAMP) >= 1800
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT 
        'OS_OPEN_FILES',
        HOST,
        MAP(LTRIM(MIN(LPAD(VALUE, 20))), '', 'n/a', LTRIM(MIN(LPAD(VALUE, 20))))
      FROM
        M_HOST_INFORMATION
      WHERE 
        KEY = 'os_rlimit_nofile'
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'ROW_STORE_CONTAINERS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_RS_TABLES
      WHERE
        CONTAINER_COUNT > 1
    )
    UNION ALL
    ( SELECT 
        'ROW_STORE_FRAGMENTATION',
        IFNULL(HOST, ''),
        IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND(MAP(ALLOCATED_SIZE, 0, NULL, FREE_SIZE / ALLOCATED_SIZE * 100)), 10, 0)), 'n/a')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          M.HOST,
          SUM(M.FREE_SIZE) FREE_SIZE,
          SUM(M.ALLOCATED_SIZE) ALLOCATED_SIZE
        FROM
          M_HOST_RESOURCE_UTILIZATION R,
          M_RS_MEMORY M
        WHERE
          R.HOST = M.HOST AND
          M.CATEGORY IN ( 'TABLE' , 'CATALOG' ) 
        GROUP BY
          M.HOST,
          R.ALLOCATION_LIMIT
        HAVING
          SUM(M.FREE_SIZE) >= 5368709120 AND
          SUM(M.FREE_SIZE) >= 0.02 * R.ALLOCATION_LIMIT
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT TOP 1
        'ROW_STORE_SIZE',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(SUM(ALLOCATED_SIZE) / 1024 / 1024 / 1024), 10, 0))
      FROM
        TEMP_M_RS_MEMORY
      GROUP BY
        HOST
      ORDER BY
        SUM(ALLOCATED_SIZE) DESC
    )      
    UNION ALL
    ( SELECT
        'VERSIONS_ROW_STORE_CURR',
        HOST,
        TO_VARCHAR(SUM(VERSION_COUNT))
      FROM
        M_MVCC_OVERVIEW
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'MVCC_REC_VERSIONS_ROW_STORE',
        HOST,
        TO_VARCHAR(MAX(TO_NUMBER(VALUE)))
      FROM
        TEMP_M_MVCC_TABLES
      WHERE
        NAME = 'MAX_VERSIONS_PER_RECORD'
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'MVCC_TAB_VERSIONS_ROW_STORE',
        '',
        TO_VARCHAR(TO_NUMBER(MAX(VERSION_COUNT)))
      FROM
        M_RS_TABLE_VERSION_STATISTICS
    )
    UNION ALL
    ( SELECT
        C.NAME,
        M.HOST,
        MAP(C.NAME,
          'ACTIVE_UPDATE_TID_RANGE', TO_VARCHAR(M.CUR_UPDATE_TID - M.MIN_UPDATE_TID),
          'ACTIVE_COMMIT_ID_RANGE', TO_VARCHAR(M.CUR_COMMIT_ID - M.MIN_COMMIT_ID))
      FROM
      ( SELECT 'ACTIVE_UPDATE_TID_RANGE' NAME FROM DUMMY UNION ALL
        SELECT 'ACTIVE_COMMIT_ID_RANGE' FROM DUMMY 
      ) C,         
      ( SELECT
          HOST,
          MIN(MAP(NAME, 'MIN_SNAPSHOT_TS',              TO_NUMBER(VALUE), 999999999999999999999)) MIN_COMMIT_ID,
          MAX(MAP(NAME, 'GLOBAL_TS',                    TO_NUMBER(VALUE), 0)) CUR_COMMIT_ID,
          MIN(MAP(NAME, 'MIN_WRITE_TID',                TO_NUMBER(VALUE), 999999999999999999999)) MIN_UPDATE_TID,
          MAX(MAP(NAME, 'NEXT_WRITE_TID',               TO_NUMBER(VALUE), 0)) CUR_UPDATE_TID
        FROM
          TEMP_M_MVCC_TABLES
        GROUP BY
          HOST
      ) M
    )
    UNION ALL
    ( SELECT
        'LICENSE_LIMIT',
        '',
        CASE WHEN PRODUCT_LIMIT = 0 THEN '0' ELSE TO_VARCHAR(TO_DECIMAL(ROUND(LEAST(ALLOC_LIM_GB, PRODUCT_USAGE) / PRODUCT_LIMIT * 100), 10, 0)) END
      FROM
        M_LICENSE,
        GENERAL_INFO
    )
    UNION ALL
    ( SELECT
        'LAST_TRAD_DATA_BACKUP',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(MAX(SYS_START_TIME), NULL, 999999, SECONDS_BETWEEN(MAX(SYS_START_TIME), CURRENT_TIMESTAMP) / 86400), 10, 2))
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_BACKUP_CATALOG ON
          1 = 1
      WHERE
        ENTRY_TYPE_NAME = 'complete data backup' AND
        STATE_NAME = 'successful'
    )
    UNION ALL
    ( SELECT
        'LAST_DATA_BACKUP',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(MAX(SYS_START_TIME), NULL, 999999, SECONDS_BETWEEN(MAX(SYS_START_TIME), CURRENT_TIMESTAMP) / 86400), 10, 2))
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_BACKUP_CATALOG ON
          1 = 1
      WHERE
        ENTRY_TYPE_NAME IN ( 'complete data backup', 'differential data backup', 'incremental data backup', 'data snapshot' ) AND
        STATE_NAME = 'successful'
    )
    UNION ALL
    ( SELECT
        'LAST_DATA_BACKUP_ERROR',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(SYS_START_TIME), CURRENT_TIMESTAMP) / 86400, 10, 2)), '999999') VALUE
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_BACKUP_CATALOG ON
          ENTRY_TYPE_NAME IN ( 'complete data backup', 'differential data backup', 'incremental data backup', 'data snapshot' ) AND
          STATE_NAME NOT IN ( 'successful', 'running' )
    )
    UNION ALL
    ( SELECT
        NAME,
        '',
        CASE
          WHEN NAME = 'MIN_DATA_BACKUP_THROUGHPUT' THEN TO_VARCHAR(TO_DECIMAL(MIN(MAP(BACKUP_DURATION_H, 0, 999999, BACKUP_SIZE_GB / BACKUP_DURATION_H)), 10, 2))
          WHEN NAME = 'AVG_DATA_BACKUP_THROUGHPUT' THEN TO_VARCHAR(TO_DECIMAL(AVG(MAP(BACKUP_DURATION_H, 0, 0,      BACKUP_SIZE_GB / BACKUP_DURATION_H)), 10, 2))
        END
      FROM
      ( SELECT
          C.NAME,
          SECONDS_BETWEEN(B.SYS_START_TIME, B.SYS_END_TIME) / 3600 BACKUP_DURATION_H,
          ( SELECT SUM(BACKUP_SIZE) / 1024 / 1024 / 1024 FROM TEMP_M_BACKUP_CATALOG_FILES BF WHERE BF.BACKUP_ID = B.BACKUP_ID ) BACKUP_SIZE_GB
        FROM
        ( SELECT 'MIN_DATA_BACKUP_THROUGHPUT' NAME FROM DUMMY UNION ALL
          SELECT 'AVG_DATA_BACKUP_THROUGHPUT' FROM DUMMY 
        ) C,
          BASIS_INFO BI,
          TEMP_M_BACKUP_CATALOG B
        WHERE
          B.ENTRY_TYPE_NAME IN ( 'complete data backup', 'data snapshot' ) AND
          B.STATE_NAME = 'successful' AND
          SECONDS_BETWEEN(B.SYS_START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.MIDTERM_DAYS
      )
      GROUP BY
        NAME
    )
    UNION ALL
    ( SELECT
        'LAST_LOG_BACKUP',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(MAX(SYS_START_TIME), NULL, 999999, GREATEST(0, SECONDS_BETWEEN(MAX(SYS_START_TIME), CURRENT_TIMESTAMP)) / 3600), 10, 2))
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_BACKUP_CATALOG ON
          1 = 1
      WHERE
        ENTRY_TYPE_NAME = 'log backup' AND
        STATE_NAME = 'successful'
    )
    UNION ALL
    ( SELECT
        'LAST_LOG_BACKUP_ERROR',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(SYS_START_TIME), CURRENT_TIMESTAMP) / 86400, 10, 2)), '999999') VALUE
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_BACKUP_CATALOG ON
          ENTRY_TYPE_NAME = 'log backup' AND
          STATE_NAME NOT IN ( 'successful', 'running' )
    )
    UNION ALL
    ( SELECT
        'LOG_BACKUP_ERRORS_LONGTERM',
        '',
        TO_VARCHAR(COUNT(*)) VALUE
      FROM
        BASIS_INFO BI,
        TEMP_M_BACKUP_CATALOG B
      WHERE
        B.ENTRY_TYPE_NAME = 'log backup' AND
        B.STATE_NAME NOT IN ( 'successful', 'running' ) AND
        SECONDS_BETWEEN(B.SYS_START_TIME, CURRENT_TIMESTAMP) < 86400 * BI.LONGTERM_DAYS
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        CASE I.NAME
          WHEN 'CURRENT_LARGE_HEAP_AREAS' THEN IFNULL(CATEGORY || ' (' || TO_DECIMAL(ROUND(MAX(EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024), 10, 0) || ' GB)', 'none')
          WHEN 'FREQUENT_ALLOCATORS' THEN IFNULL(CATEGORY || ' (' || MAX(NUM_INSTANTIATIONS) || ')', 'none')
        END
      FROM
      ( SELECT 'CURRENT_LARGE_HEAP_AREAS' NAME FROM DUMMY UNION ALL
        SELECT 'FREQUENT_ALLOCATORS' FROM DUMMY
      ) I LEFT OUTER JOIN
      ( SELECT
          ALLOC_LIM_GB,
          CATEGORY,
          SUM(EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
          COUNT(*) NUM_INSTANTIATIONS
        FROM
          GENERAL_INFO,
          M_HEAP_MEMORY
        GROUP BY
          ALLOC_LIM_GB,
          HOST,
          CATEGORY
      ) M ON
        ( I.NAME = 'CURRENT_LARGE_HEAP_AREAS' AND
          ( M.EXCLUSIVE_SIZE_IN_USE >= 53687091200 OR M.EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024 >= M.ALLOC_LIM_GB * 0.03 ) AND
          M.CATEGORY NOT LIKE 'Pool/AttributeEngine%' AND
          M.CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
          M.CATEGORY NOT IN
          ( 'Pool/CS/BufferPage',
            'Pool/CS/BufferCachePageProvider:DataPage',
            'Pool/LVCAllocator',
            'Pool/malloc/libhdbcstypes.so',
            'Pool/NameIdMapping/RoDict',
            'Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page',
            'Pool/PersistenceManager/PersistentSpace/DefaultLPA/Page',
            'Pool/PersistenceManager/PersistentSpace(0)/StaticLPA/Page',
            'Pool/PersistenceManager/PersistentSpace/StaticLPA/Page',
            'Pool/PersistenceManager/PersistentSpace/DefaultLPA/DataPage',
            'Pool/PersistenceManager/PersistentSpace/DefaultLPA/LOBPage',
            'Pool/PersistenceManager/PersistentSpace/LOBPage',
            'Pool/PersistenceManager/PersistentSpace/DefaultPageProvider:DataPage',
            'Pool/PersistenceManager/PersistentSpace/LOBPageProvider:DataPage',
            'Pool/PersistenceManager/UnifiedTableContainer',
            'Pool/RowEngine/CpbTree',
            'Pool/RowStoreTables/CpbTree',
            'StackAllocator'
          )
        ) OR
        ( I.NAME = 'FREQUENT_ALLOCATORS' AND
          M.NUM_INSTANTIATIONS >= 10000
        )
      GROUP BY
        I.NAME,
        M.CATEGORY
    )
    UNION ALL
    ( SELECT TOP 10
        'RECENT_LARGE_HEAP_AREAS',
        '',
        IFNULL(CATEGORY || ' (' || TO_DECIMAL(ROUND(MAX(EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024), 10, 0) || ' GB)', 'none')
      FROM
        GENERAL_INFO G LEFT OUTER JOIN
        ( SELECT
            H.CATEGORY,
            MAX(H.EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_HEAP_ALLOCATORS H
          WHERE
            SECONDS_BETWEEN(H.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
            H.CATEGORY NOT LIKE 'Pool/AttributeEngine%' AND
            H.CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
            H.CATEGORY NOT IN
            ( 'Pool/CS/BufferPage',
              'Pool/CS/BufferCachePageProvider:DataPage',
              'Pool/LVCAllocator',
              'Pool/malloc/libhdbcstypes.so',
              'Pool/NameIdMapping/RoDict',
              'Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/Page',
              'Pool/PersistenceManager/PersistentSpace(0)/StaticLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/StaticLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/DataPage',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/LOBPage',
              'Pool/PersistenceManager/PersistentSpace/LOBPage',
              'Pool/PersistenceManager/PersistentSpace/DefaultPageProvider:DataPage',
              'Pool/PersistenceManager/PersistentSpace/LOBPageProvider:DataPage',
              'Pool/PersistenceManager/PersistentSpace/LOBPage',
              'Pool/PersistenceManager/UnifiedTableContainer',
              'Pool/RowEngine/CpbTree',
              'Pool/RowStoreTables/CpbTree',
              'StackAllocator'
            )
          GROUP BY
            H.HOST,
            H.CATEGORY
        ) M ON
          ( M.EXCLUSIVE_SIZE_IN_USE >= 107374182400 OR M.EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024 >= G.ALLOC_LIM_GB * 0.05 )
      GROUP BY
        CATEGORY
      ORDER BY
        MAX(EXCLUSIVE_SIZE_IN_USE) DESC
    )
    UNION ALL
    ( SELECT TOP 10
        'HISTORIC_LARGE_HEAP_AREAS',
        '',
        IFNULL(CATEGORY || ' (' || TO_DECIMAL(ROUND(MAX(EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024), 10, 0) || ' GB)', 'none')
      FROM
        GENERAL_INFO G LEFT OUTER JOIN
        ( SELECT
            H.CATEGORY,
            MAX(H.EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_HEAP_ALLOCATORS H
          WHERE
            SECONDS_BETWEEN(H.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS AND
            CATEGORY NOT LIKE 'Pool/AttributeEngine%' AND
            CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
            CATEGORY NOT IN
            ( 'Pool/CS/BufferPage',
              'Pool/CS/BufferCachePageProvider:DataPage',
              'Pool/LVCAllocator',
              'Pool/malloc/libhdbcstypes.so',
              'Pool/NameIdMapping/RoDict',
              'Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/Page',
              'Pool/PersistenceManager/PersistentSpace(0)/StaticLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/StaticLPA/Page',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/DataPage',
              'Pool/PersistenceManager/PersistentSpace/DefaultLPA/LOBPage',
              'Pool/PersistenceManager/PersistentSpace/LOBPage',
              'Pool/PersistenceManager/PersistentSpace/DefaultPageProvider:DataPage',
              'Pool/PersistenceManager/PersistentSpace/LOBPageProvider:DataPage',
              'Pool/PersistenceManager/UnifiedTableContainer',
              'Pool/RowEngine/CpbTree',
              'Pool/RowStoreTables/CpbTree',
              'StackAllocator'
            )
          GROUP BY
            H.HOST,
            H.CATEGORY
        ) M ON
          ( M.EXCLUSIVE_SIZE_IN_USE >= 214748364800 OR M.EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024 >= G.ALLOC_LIM_GB * 0.10 )
      GROUP BY
        CATEGORY
      ORDER BY
        MAX(EXCLUSIVE_SIZE_IN_USE) DESC
    )
    UNION ALL
    ( SELECT
        'MANY_PARTITIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME
        FROM
          TEMP_M_CS_TABLES
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          COUNT(*) > 100
      )
    )
    UNION ALL
    ( SELECT
        'TABLES_MANY_COLUMNS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || NUM_COLUMNS || CHAR(32) || 'columns)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          COUNT(*) NUM_COLUMNS
        FROM
          TEMP_TABLE_COLUMNS
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          COUNT(*) >= 2000
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'ACTIVE_UPDATE_TRANS_CURR',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(MIN(START_TIME), CURRENT_TIMESTAMP) / 3600), 10, 2)), '0.00')
      FROM
        TEMP_M_TRANSACTIONS
      WHERE
         UPDATE_TRANSACTION_ID > 0 AND
         TRANSACTION_STATUS = 'ACTIVE'
    )
    UNION ALL
    ( SELECT
        'ACTIVE_UPDATE_TRANS_HIST',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(UW.TOTAL_TIME / 3600), 10, 2))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_UNCOMMITTED_WRITE_TRANSACTION UW
      WHERE
        UW.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
    )
    UNION ALL
    ( SELECT
        'ACTIVE_SQL_CURR',
        '',
        TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MIN(LAST_EXECUTED_TIME), CURRENT_TIMESTAMP) / 3600, 10, 2))
      FROM
        M_ACTIVE_STATEMENTS
      WHERE
        LAST_EXECUTED_TIME IS NOT NULL
    )
    UNION ALL
    ( SELECT
        'ACTIVE_SQL_HIST',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(RUNTIME_S) / 3600, 10, 2))
      FROM
      ( SELECT
          MAX(IC.IDLE_TIME) RUNTIME_S
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_LONG_IDLE_CURSOR IC
        WHERE
          IC.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
        UNION ALL
        SELECT
          MAX(LR.DURATION / 1000) RUNTIME_S
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_LONG_RUNNING_STATEMENTS LR
        WHERE
          LR.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
      )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        O.HOST,
        CASE
          WHEN C.NAME = 'CPU_BUSY_CURRENT' THEN
            TO_VARCHAR(TO_DECIMAL(ROUND(MAX(MAP(TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA + TOTAL_CPU_WIO_TIME_DELTA + TOTAL_CPU_IDLE_TIME_DELTA, 0, 0, 
              (TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA) / (TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA + TOTAL_CPU_WIO_TIME_DELTA + TOTAL_CPU_IDLE_TIME_DELTA)) * 100)), 10, 0))
          WHEN C.NAME = 'MEMORY_USED_CURRENT' THEN
            TO_VARCHAR(TO_DECIMAL(ROUND(MAX(MAP(FREE_PHYSICAL_MEMORY + USED_PHYSICAL_MEMORY, 0, 0, USED_PHYSICAL_MEMORY / (FREE_PHYSICAL_MEMORY + USED_PHYSICAL_MEMORY)) * 100)), 10, 0))
          WHEN C.NAME = 'SWAP_SPACE_USED_CURRENT' THEN
            TO_VARCHAR(TO_DECIMAL(ROUND(MAX(USED_SWAP_SPACE) / 1024 / 1024 / 1024), 10, 0))
        END
      FROM
      ( SELECT 'CPU_BUSY_CURRENT' NAME FROM DUMMY UNION ALL
        SELECT 'MEMORY_USED_CURRENT' FROM DUMMY UNION ALL
        SELECT 'SWAP_SPACE_USED_CURRENT' FROM DUMMY
      ) C,
      ( SELECT 
          * 
        FROM 
          _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS 
        WHERE 
        SECONDS_BETWEEN(SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 600 AND
        TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA + TOTAL_CPU_WIO_TIME_DELTA + TOTAL_CPU_IDLE_TIME_DELTA > 0
      ) O
      GROUP BY
        C.NAME,
        O.HOST
    )
    UNION ALL
    ( SELECT
        C.NAME,
        R.HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAX(CASE C.NAME
          WHEN 'CPU_BUSY_RECENT' THEN 
            (R.TOTAL_CPU_USER_TIME_DELTA + R.TOTAL_CPU_SYSTEM_TIME_DELTA) / 
            (R.TOTAL_CPU_USER_TIME_DELTA + R.TOTAL_CPU_SYSTEM_TIME_DELTA + R.TOTAL_CPU_WIO_TIME_DELTA + R.TOTAL_CPU_IDLE_TIME_DELTA) * 100
          WHEN 'CPU_BUSY_SYSTEM_RECENT' THEN
            R.TOTAL_CPU_SYSTEM_TIME_DELTA /
            (R.TOTAL_CPU_USER_TIME_DELTA + R.TOTAL_CPU_SYSTEM_TIME_DELTA + R.TOTAL_CPU_WIO_TIME_DELTA + R.TOTAL_CPU_IDLE_TIME_DELTA) * 100
        END)), 10, 0))
      FROM
      ( SELECT 'CPU_BUSY_RECENT' NAME FROM DUMMY UNION ALL
        SELECT 'CPU_BUSY_SYSTEM_RECENT' FROM DUMMY
      ) C,
      ( SELECT
          R.HOST,
          AVG(R.TOTAL_CPU_USER_TIME_DELTA) TOTAL_CPU_USER_TIME_DELTA,
          AVG(R.TOTAL_CPU_SYSTEM_TIME_DELTA) TOTAL_CPU_SYSTEM_TIME_DELTA,
          AVG(R.TOTAL_CPU_WIO_TIME_DELTA) TOTAL_CPU_WIO_TIME_DELTA,
          AVG(R.TOTAL_CPU_IDLE_TIME_DELTA) TOTAL_CPU_IDLE_TIME_DELTA
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS R
        WHERE
          SECONDS_BETWEEN(R.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          R.TOTAL_CPU_USER_TIME_DELTA + R.TOTAL_CPU_SYSTEM_TIME_DELTA + R.TOTAL_CPU_WIO_TIME_DELTA + R.TOTAL_CPU_IDLE_TIME_DELTA > 0
        GROUP BY
          R.HOST,
          FLOOR(SECONDS_BETWEEN(CURRENT_TIMESTAMP, R.SERVER_TIMESTAMP) / 120)
      ) R
      GROUP BY
        C.NAME,
        R.HOST 
    )
    UNION ALL
    ( SELECT
        'CPU_BUSY_HISTORY',
        HOST,
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(SERVER_TIMESTAMP, CURRENT_TIMESTAMP) / 3600, 10, 2)), '999999')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          MAX(SERVER_TIMESTAMP) SERVER_TIMESTAMP
        FROM
          _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS 
        WHERE
          MAP(TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA + TOTAL_CPU_WIO_TIME_DELTA + TOTAL_CPU_IDLE_TIME_DELTA, 0, 0,
            ( TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA ) / 
            ( TOTAL_CPU_USER_TIME_DELTA + TOTAL_CPU_SYSTEM_TIME_DELTA + TOTAL_CPU_WIO_TIME_DELTA + TOTAL_CPU_IDLE_TIME_DELTA ) * 100) > 95
        GROUP BY
          HOST
      ) ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        'CPU_BUSY_EXTERNAL',
        S.HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(GREATEST(0, H.CPU - S.CPU)), 10, 0))
      FROM
      ( SELECT
          HOST,
          SUM(CPU) CPU
        FROM
        ( SELECT
            L.HOST,
            L.PORT,
            AVG(L.CPU) CPU
          FROM
            BASIS_INFO BI,
            M_LOAD_HISTORY_SERVICE L
          WHERE
            L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS)
          GROUP BY
            L.HOST,
            L.PORT
        )
        GROUP BY
          HOST
      ) S,
      ( SELECT
          L.HOST,
          AVG(L.CPU) CPU
        FROM
          BASIS_INFO BI,
          M_LOAD_HISTORY_HOST L
        WHERE
          L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS)
        GROUP BY
          L.HOST
      ) H
      WHERE
        S.HOST = H.HOST
    )
    UNION ALL
    ( SELECT
        'DISTRIBUTED_EXECUTIONS',
        IFNULL(TAB_HOST, ''),
        TO_VARCHAR(IFNULL(COUNT, 0))
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          COUNT(*) COUNT,
          SUBSTR(TABLE_LOCATIONS, 2, LOCATE(TABLE_LOCATIONS, ':', 1, 1) - 2) TAB_HOST
        FROM
          TEMP_M_SQL_PLAN_CACHE S
        WHERE
          TABLE_LOCATIONS NOT LIKE '%), (%' AND
          TABLE_LOCATIONS != '' AND
          IS_DISTRIBUTED_EXECUTION = 'TRUE' AND
          IS_INTERNAL = 'FALSE' AND
          EXECUTION_COUNT > 0 AND
          SUBSTR(TABLE_LOCATIONS, 2) NOT LIKE HOST || '%' AND
          ACCESSED_TABLE_NAMES NOT LIKE '%SYS.%' AND
          IS_VALID = 'TRUE'
        GROUP BY
          SUBSTR(TABLE_LOCATIONS, 2, LOCATE(TABLE_LOCATIONS, ':', 1, 1) - 2)
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'INTERNAL_EXECUTION_SHARE',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(TOTAL, 0, 0, INTERNAL / TOTAL * 100), 10, 2))
      FROM
      ( SELECT
          COUNT(*) TOTAL,
          SUM(MAP(IS_INTERNAL, 'TRUE', 1, 0)) INTERNAL
        FROM
          TEMP_M_SQL_PLAN_CACHE
        WHERE
          SCHEMA_NAME != '_SYS_STATISTICS'
      )
    )
    UNION ALL
    ( SELECT
        'ABAP_ROW_STORE_WORKER_NODE',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT SCHEMA_NAME FROM TEMP_TABLES WHERE TABLE_NAME = 'T000' ) A,
        TEMP_M_RS_TABLES T,
        M_LANDSCAPE_HOST_CONFIGURATION L
      WHERE
        T.SCHEMA_NAME = A.SCHEMA_NAME AND
        L.HOST = T.HOST AND
        L.INDEXSERVER_ACTUAL_ROLE != 'MASTER'
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        CASE
          WHEN C.NAME = 'HIGH_CRIT_SAVEPOINT_PHASE'    THEN TO_VARCHAR(SUM(CASE WHEN (CRITICAL_PHASE_WAIT_TIME + CRITICAL_PHASE_DURATION) / 1000000 > 10 THEN 1 ELSE 0 END))
          WHEN C.NAME = 'AVG_CRIT_SAVEPOINT_PHASE'     THEN TO_VARCHAR(TO_DECIMAL(IFNULL(AVG((CRITICAL_PHASE_WAIT_TIME + CRITICAL_PHASE_DURATION) / 1000000), 0), 10, 2))
          WHEN C.NAME = 'MAX_CRIT_SAVEPOINT_PHASE'     THEN TO_VARCHAR(TO_DECIMAL(IFNULL(MAX((CRITICAL_PHASE_WAIT_TIME + CRITICAL_PHASE_DURATION) / 1000000), 0), 10, 2))
          WHEN C.NAME = 'WAITFORLOCK_SAVEPOINT_PHASE'  THEN TO_VARCHAR(SUM(CASE WHEN CRITICAL_PHASE_WAIT_TIME / 1000000 > 10 THEN 1 ELSE 0 END))
          WHEN C.NAME = 'CRIT_SAVEPOINT_PHASE'         THEN TO_VARCHAR(SUM(CASE WHEN CRITICAL_PHASE_DURATION / 1000000 > 10 AND (BLOCKING_PHASE_DURATION - CRITICAL_PHASE_DURATION) / 1000000 <= 10 THEN 1 ELSE 0 END))
          WHEN C.NAME = 'WAITFORFLUSH_SAVEPOINT_PHASE' THEN TO_VARCHAR(SUM(CASE WHEN (BLOCKING_PHASE_DURATION - CRITICAL_PHASE_DURATION - CRITICAL_PHASE_WAIT_TIME) / 1000000 > 10 THEN 1 ELSE 0 END))
        END
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        ( SELECT 'HIGH_CRIT_SAVEPOINT_PHASE' NAME FROM DUMMY UNION ALL
          SELECT 'AVG_CRIT_SAVEPOINT_PHASE'       FROM DUMMY UNION ALL
          SELECT 'MAX_CRIT_SAVEPOINT_PHASE'       FROM DUMMY UNION ALL
          SELECT 'WAITFORLOCK_SAVEPOINT_PHASE'    FROM DUMMY UNION ALL
          SELECT 'CRIT_SAVEPOINT_PHASE'           FROM DUMMY UNION ALL
          SELECT 'WAITFORFLUSH_SAVEPOINT_PHASE'   FROM DUMMY
        ) C ON
          1 = 1 LEFT OUTER JOIN
          _SYS_STATISTICS.HOST_SAVEPOINTS S ON
            S.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS) AND
            S.PREPARE_FLUSH_RETRY_COUNT > 0                 /* exclude secondary site information where no retries are done and critical phase starts immediately */
      GROUP BY
        C.NAME
    )
    UNION ALL
    ( SELECT
        'DISK_SIZE',
        MAP(HOST, CHAR(60) || 'all>', '', HOST),
        TO_VARCHAR(TO_DECIMAL(ROUND(MAX(MAP(TOTAL_SIZE, 0, 0, USED_SIZE / TOTAL_SIZE)) * 100), 10, 0))
      FROM
        M_DISKS 
      WHERE
        TOTAL_SIZE > 0
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'OLDEST_LOCK_WAIT',
        '',
        TO_VARCHAR(IFNULL(GREATEST(MAX(SECONDS_BETWEEN(BLOCKED_TIME, CURRENT_TIMESTAMP)), 0), 0))
      FROM
        M_BLOCKED_TRANSACTIONS 
    )
    UNION ALL
    ( SELECT
        'MVCC_TRANS_START_TIME',
        '', 
        IFNULL(TO_VARCHAR(GREATEST(0, SECONDS_BETWEEN(MIN(START_TIME), CURRENT_TIMESTAMP))), '0')
      FROM
        TEMP_M_TRANSACTIONS
      WHERE
        MIN_MVCC_SNAPSHOT_TIMESTAMP = ( SELECT MIN(VALUE) FROM TEMP_M_MVCC_TABLES WHERE NAME = 'MIN_SNAPSHOT_TS' )
    )
    UNION ALL
    ( SELECT
        'LONG_TABLE_MERGE_TIME',
        '',
        MAP(M.TABLE_NAME, NULL, 'none', M.TABLE_NAME || CHAR(32) || '(' || RUNTIME_H || CHAR(32) || 'h)')
      FROM
      ( SELECT 1 FROM DUMMY ) LEFT OUTER JOIN
      ( SELECT
          TABLE_NAME,
          TO_DECIMAL(SUM(EXECUTION_TIME) / 1000 / 3600, 10, 2) RUNTIME_H
        FROM
          BASIS_INFO BI,
          ( SELECT DISTINCT(HOST) HOST FROM M_HOST_INFORMATION ) H,
          ( SELECT DISTINCT HOST, START_TIME, EXECUTION_TIME, SCHEMA_NAME, TABLE_NAME, PART_ID FROM _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS ) M
        WHERE
          H.HOST = M.HOST AND
          SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        GROUP BY
          TABLE_NAME
        HAVING
          SUM(EXECUTION_TIME) > 7200000
      ) M ON
      1 = 1
    )
    UNION ALL
    ( SELECT TOP 5
        'LONG_DELTA_MERGES',
        '',
        IFNULL(M.TABLE_NAME || CHAR(32) || CASE WHEN M.PART_ID > 0 THEN '(' || M.PART_ID || ')' || CHAR(32) ELSE '' END || '(' || TO_DECIMAL(M.EXECUTION_TIME / 1000, 10, 0) || CHAR(32) || 's,' || CHAR(32) ||
          TO_VARCHAR(M.START_TIME, 'YYYY/MM/DD HH24:MI:SS') || ')', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT
            M.START_TIME,
            M.TABLE_NAME,
            M.PART_ID,
            M.EXECUTION_TIME
          FROM
            BASIS_INFO BI,
          ( SELECT DISTINCT(HOST) HOST FROM M_HOST_INFORMATION ) H,
          ( SELECT DISTINCT HOST, START_TIME, EXECUTION_TIME, TYPE, SCHEMA_NAME, TABLE_NAME, PART_ID FROM _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS ) M
          WHERE
            H.HOST = M.HOST AND
            SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.MIDTERM_DAYS AND
            M.TYPE = 'MERGE' AND
            M.EXECUTION_TIME > 900000
        ) M ON
          1 = 1
      ORDER BY
        M.EXECUTION_TIME DESC
    )
    UNION ALL
    ( SELECT TOP 5
        'LONG_OPTIMIZE_COMPRESSIONS',
        '',
        IFNULL(M.TABLE_NAME || CHAR(32) || CASE WHEN M.PART_ID > 0 THEN '(' || M.PART_ID || ')' || CHAR(32) ELSE '' END || '(' || TO_DECIMAL(M.EXECUTION_TIME / 1000, 10, 0) || CHAR(32) || 's,' || CHAR(32) ||
          TO_VARCHAR(M.START_TIME, 'YYYY/MM/DD HH24:MI:SS') || ')', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT
            M.START_TIME,
            M.TABLE_NAME,
            M.PART_ID,
            M.EXECUTION_TIME
          FROM
            BASIS_INFO BI,
          ( SELECT DISTINCT(HOST) HOST FROM M_HOST_INFORMATION ) H,
          ( SELECT DISTINCT HOST, START_TIME, EXECUTION_TIME, TYPE, SCHEMA_NAME, TABLE_NAME, PART_ID FROM _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS ) M
          WHERE
            H.HOST = M.HOST AND
            SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.MIDTERM_DAYS AND
            M.TYPE = 'SPARSE' AND
            M.EXECUTION_TIME > 3600000
        ) M ON
          1 = 1
      ORDER BY
        M.EXECUTION_TIME DESC
    )
    UNION ALL
    ( SELECT
        C.NAME,
        M.HOST,
        CASE 
          WHEN C.NAME = 'FAILING_DELTA_MERGES_INFO' THEN TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN 
            M.ERROR_DESCRIPTION LIKE '%2465%' OR
            M.ERROR_DESCRIPTION LIKE '%2480%' OR
            M.ERROR_DESCRIPTION LIKE '%2481%' OR
            M.ERROR_DESCRIPTION LIKE '%2482%' OR
            M.ERROR_DESCRIPTION LIKE '%2486%' THEN 1 ELSE 0 END ) / SECONDS_BETWEEN(MIN(M.START_TIME), CURRENT_TIMESTAMP) * 86400, 10, 0))
          WHEN C.NAME = 'FAILING_DELTA_MERGES_ERROR' THEN TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN
            M.LAST_ERROR != 0 AND
            ( M.ERROR_DESCRIPTION NOT LIKE '%2465%' AND
              M.ERROR_DESCRIPTION NOT LIKE '%2480%' AND
              M.ERROR_DESCRIPTION NOT LIKE '%2481%' AND
              M.ERROR_DESCRIPTION NOT LIKE '%2482%' AND
              M.ERROR_DESCRIPTION NOT LIKE '%2486%' 
            ) THEN 1 ELSE 0 END ) / SECONDS_BETWEEN(MIN(M.START_TIME), CURRENT_TIMESTAMP) * 86400, 10, 0))
        END
      FROM
        ( SELECT 'FAILING_DELTA_MERGES_INFO' NAME FROM DUMMY UNION ALL
          SELECT 'FAILING_DELTA_MERGES_ERROR' FROM DUMMY
        ) C,
        BASIS_INFO BI,
        M_DELTA_MERGE_STATISTICS M
      WHERE
        SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS 
      GROUP BY
        C.NAME,
        M.HOST
    )
    UNION ALL
    ( SELECT
        C.NAME,
        HOST,
        CASE
          WHEN C.NAME = 'NUM_TRACEFILES_TOTAL' THEN TO_VARCHAR(COUNT(*))
          WHEN C.NAME = 'SIZE_TRACEFILES_TOTAL' THEN TO_VARCHAR(TO_DECIMAL(SUM(FILE_SIZE) / 1024 / 1024 / 1024, 10, 2))
          WHEN C.NAME = 'LARGEST_TRACEFILE' THEN TO_VARCHAR(TO_DECIMAL(MAX(FILE_SIZE) / 1024 / 1024, 10, 2))
        END
      FROM
      ( SELECT 'NUM_TRACEFILES_TOTAL' NAME FROM DUMMY UNION ALL
        SELECT 'SIZE_TRACEFILES_TOTAL' FROM DUMMY UNION ALL
        SELECT 'LARGEST_TRACEFILE' FROM DUMMY
      ) C LEFT OUTER JOIN
        M_TRACEFILES T ON
          C.NAME != 'LARGEST_TRACEFILE' OR T.FILE_NAME != 'nameserver_history.trc'
      GROUP BY
        C.NAME,
        T.HOST
    )
    UNION ALL
    ( SELECT
        C.NAME,
        T.HOST,
        CASE
          WHEN C.NAME = 'NUM_TRACEFILES_SHORTTERM' THEN TO_VARCHAR(TO_DECIMAL(COUNT(*) / BI.SHORTTERM_DAYS, 10, 0))
          WHEN C.NAME = 'SIZE_TRACEFILES_SHORTTERM' THEN TO_VARCHAR(TO_DECIMAL(SUM(T.FILE_SIZE) / 1024 / 1024 / 1024 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN C.NAME = 'NUM_OOM_TRACEFILES' THEN TO_VARCHAR(SUM(CASE WHEN T.FILE_NAME LIKE '%rtedump%oom%.trc' AND FILE_NAME NOT LIKE '%compositelimit_oom%.trc' THEN 1 ELSE 0 END))
          WHEN C.NAME = 'NUM_COMP_OOM_TRACEFILES' THEN TO_VARCHAR(SUM(CASE WHEN T.FILE_NAME LIKE '%rtedump%%compositelimit_oom%.trc' THEN 1 ELSE 0 END))
          WHEN C.NAME = 'NUM_CRASHDUMP_TRACEFILES' THEN TO_VARCHAR(SUM(CASE WHEN T.FILE_NAME LIKE '%crashdump%.trc' THEN 1 ELSE 0 END))
          WHEN C.NAME = 'NUM_RTEDUMP_TRACEFILES' THEN TO_VARCHAR(SUM(CASE WHEN T.FILE_NAME LIKE '%rtedump%' AND FILE_NAME NOT LIKE '%rtedump%oom%.trc' AND T.FILE_NAME NOT LIKE '%rtedump%page%.trc' THEN 1 ELSE 0 END))
          WHEN C.NAME = 'NUM_PAGEDUMP_TRACEFILES' THEN TO_VARCHAR(SUM(CASE WHEN T.FILE_NAME LIKE '%rtedump%page%.trc' THEN 1 ELSE 0 END))
        END
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
      ( SELECT 'NUM_TRACEFILES_SHORTTERM' NAME FROM DUMMY UNION ALL
        SELECT 'SIZE_TRACEFILES_SHORTTERM' FROM DUMMY UNION ALL
        SELECT 'NUM_OOM_TRACEFILES' FROM DUMMY UNION ALL
        SELECT 'NUM_COMP_OOM_TRACEFILES' FROM DUMMY UNION ALL
        SELECT 'NUM_CRASHDUMP_TRACEFILES' FROM DUMMY UNION ALL
        SELECT 'NUM_RTEDUMP_TRACEFILES' FROM DUMMY UNION ALL
        SELECT 'NUM_PAGEDUMP_TRACEFILES' FROM DUMMY
      ) C ON
        1 = 1 LEFT OUTER JOIN
        M_TRACEFILES T ON
          1 = 1
      WHERE
        SECONDS_BETWEEN(T.FILE_MTIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
      GROUP BY
        BI.SHORTTERM_DAYS,
        C.NAME,
        T.HOST
    )
    UNION ALL
    ( SELECT
        'EXP_TRACE_LONG_RUNNING_SQL',
        '',
        TO_VARCHAR(IFNULL(STATEMENT_HASH || CHAR(32) || '(' || TO_DECIMAL(DURATION_MICROSEC / 1000000 / 3600, 10,2) || CHAR(32) || 'h)', 'none'))
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          E.STATEMENT_HASH,
          MAX(E.DURATION_MICROSEC) DURATION_MICROSEC
        FROM
          BASIS_INFO BI,
          TEMP_M_EXPENSIVE_STATEMENTS E
        WHERE
          SECONDS_BETWEEN(E.START_TIME, CURRENT_TIMESTAMP) + DURATION_MICROSEC / 1000000 <= 86400 * BI.SHORTTERM_DAYS AND
          E.DURATION_MICROSEC / 1000000 > 3600 AND
          UPPER(TO_VARCHAR(E.STATEMENT_STRING)) NOT LIKE 'BACKUP%' 
        GROUP BY
          E.STATEMENT_HASH
     ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'EXPENSIVE_SQL_RETENTION',
        HOST,
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MIN_START_TIME, CURRENT_TIMESTAMP) / 86400, 10, 2)), 'n/a')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          MAX(MIN_START_TIME) MIN_START_TIME
        FROM
        ( SELECT
            HOST,
            PORT,
            MIN(START_TIME) MIN_START_TIME,
            COUNT(*)
          FROM
            TEMP_M_EXPENSIVE_STATEMENTS
          WHERE
            TO_VARCHAR(START_TIME, 'YYYY') >= '2010'
          GROUP BY
            HOST,
            PORT
          HAVING
            COUNT(*) >= 1
        )
        GROUP BY
          HOST
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT TOP 1
        'ANALYSIS_DATE',
        '',
        TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') || MAP(VALUE, NULL, '', CHAR(32) || '(' || VALUE || ')')
      FROM
        DUMMY LEFT OUTER JOIN
        M_HOST_INFORMATION ON
          KEY = 'timezone_name'
    )
    UNION ALL
    ( SELECT
        'SYSTEM_ID_DB_NAME',
        '',
        SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME
      FROM
        M_DATABASE
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        MAP(TABLE_NAME, NULL, 'none', TABLE_NAME || MAP(PART_ID, 0, '', CHAR(32) || '(' || PART_ID || ')') || CHAR(32) || '(' || 
          MAP(C.NAME, 'LARGE_MEMORY_TABLES', TO_DECIMAL(ROUND(T.MEMORY_SIZE_IN_TOTAL / 1024 / 1024 / 1024), 10, 0) || CHAR(32) || 'GB)', 
            'LARGE_ALLOC_LIM_TABLES', TO_DECIMAL(ROUND(T.MEMORY_SIZE_IN_TOTAL / T.GLOBAL_ALLOCATION_LIMIT * 100), 10, 0) || CHAR(32) || '%)'))
      FROM
      ( SELECT 'LARGE_MEMORY_TABLES' NAME FROM DUMMY UNION ALL
        SELECT 'LARGE_ALLOC_LIM_TABLES'   FROM DUMMY
      ) C LEFT OUTER JOIN
      ( SELECT
          T.TABLE_NAME,
          T.PART_ID,
          T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL MEMORY_SIZE_IN_TOTAL,
          H.ALLOCATION_LIMIT + IFNULL(P.TOTAL_SIZE, 0) GLOBAL_ALLOCATION_LIMIT
        FROM
          TEMP_M_CS_TABLES T,
          M_HOST_RESOURCE_UTILIZATION H LEFT OUTER JOIN
          ( SELECT
              HOST,
              MAX(TOTAL_SIZE) TOTAL_SIZE
            FROM
            ( SELECT
                HOST,
                PORT,
                SUM(TOTAL_SIZE) TOTAL_SIZE
              FROM
                M_PERSISTENT_MEMORY_VOLUMES
              GROUP BY
                HOST,
                PORT
            )
            GROUP BY
              HOST
          ) P ON
            P.HOST = H.HOST
        WHERE
          T.HOST = H.HOST AND
          ( (T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 > 50 OR
            (T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL) > 0.1 * ( H.ALLOCATION_LIMIT + IFNULL(P.TOTAL_SIZE, 0))
          ) AND
          H.ALLOCATION_LIMIT > 0
      ) T ON
        C.NAME = 'LARGE_MEMORY_TABLES'    AND T.MEMORY_SIZE_IN_TOTAL / 1024 / 1024 / 1024 > 50 OR
        C.NAME = 'LARGE_ALLOC_LIM_TABLES' AND T.MEMORY_SIZE_IN_TOTAL > 0.05 * T.GLOBAL_ALLOCATION_LIMIT
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        CASE C.NAME
          WHEN 'LARGE_DELTA_STORAGE_AUTO'   THEN IFNULL(TABLE_NAME || ' (' || TO_DECIMAL(MEMORY_SIZE_IN_DELTA / 1024 / 1024 / 1024, 10, 2) || ' GB)', 'none')
          WHEN 'MANY_DELTA_RECORDS_AUTO'    THEN IFNULL(TABLE_NAME || ' (' || RAW_RECORD_COUNT_IN_DELTA || ' rows, ' || DELTA_PCT || ' %)', 'none')
          WHEN 'LARGE_DELTA_STORAGE_NOAUTO' THEN IFNULL(TABLE_NAME || ' (' || TO_DECIMAL(MEMORY_SIZE_IN_DELTA / 1024 / 1024 / 1024, 10, 2) || ' GB)', 'none')
          WHEN 'MANY_DELTA_RECORDS_NOAUTO'  THEN IFNULL(TABLE_NAME || ' (' || RAW_RECORD_COUNT_IN_DELTA || ' rows, ' || DELTA_PCT || ' %)', 'none')
        END
      FROM
      ( SELECT 'LARGE_DELTA_STORAGE_AUTO' NAME FROM DUMMY UNION ALL
        SELECT 'MANY_DELTA_RECORDS_AUTO'       FROM DUMMY UNION ALL
        SELECT 'LARGE_DELTA_STORAGE_NOAUTO'    FROM DUMMY UNION ALL
        SELECT 'MANY_DELTA_RECORDS_NOAUTO'     FROM DUMMY
      ) C LEFT OUTER JOIN
      ( SELECT
          CT.TABLE_NAME,
          T.AUTO_MERGE_ON,
          MAX(NUM_HOURS) NUM_HOURS,
          SUM(CT.MEMORY_SIZE_IN_TOTAL + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL) MEMORY_SIZE_IN_TOTAL,
          SUM(CT.MEMORY_SIZE_IN_DELTA) MEMORY_SIZE_IN_DELTA,
          SUM(CT.RAW_RECORD_COUNT_IN_MAIN) RAW_RECORD_COUNT_IN_MAIN,
          SUM(CT.RAW_RECORD_COUNT_IN_DELTA) RAW_RECORD_COUNT_IN_DELTA,
          TO_DECIMAL(ROUND(MAP(SUM(CT.RAW_RECORD_COUNT_IN_DELTA + CT.RAW_RECORD_COUNT_IN_MAIN), 0, 0, SUM(CT.RAW_RECORD_COUNT_IN_DELTA) / SUM(CT.RAW_RECORD_COUNT_IN_DELTA + CT.RAW_RECORD_COUNT_IN_MAIN) * 100)), 10, 0) DELTA_PCT,
          SUM(TH.MIN_RECENT_MEMORY_SIZE_IN_DELTA) MIN_RECENT_MEMORY_SIZE_IN_DELTA,
          SUM(TH.MIN_RECENT_RAW_RECORD_COUNT_IN_DELTA) MIN_RECENT_RAW_RECORD_COUNT_IN_DELTA
        FROM
          TEMP_M_CS_TABLES CT INNER JOIN
          TEMP_TABLES T ON
            CT.SCHEMA_NAME = T.SCHEMA_NAME AND
            CT.TABLE_NAME = T.TABLE_NAME LEFT OUTER JOIN
          ( SELECT
              SCHEMA_NAME,
              TABLE_NAME,
              COUNT(DISTINCT(TO_VARCHAR(SERVER_TIMESTAMP, 'HH24'))) NUM_HOURS,
              MIN(RAW_RECORD_COUNT_IN_DELTA) MIN_RECENT_RAW_RECORD_COUNT_IN_DELTA,
              MIN(MEMORY_SIZE_IN_DELTA) MIN_RECENT_MEMORY_SIZE_IN_DELTA
            FROM
              _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE
            WHERE
              SERVER_TIMESTAMP > ADD_SECONDS(CURRENT_TIMESTAMP, -86400)
            GROUP BY
              SCHEMA_NAME,
              TABLE_NAME
          ) TH ON
            TH.SCHEMA_NAME = T.SCHEMA_NAME AND
            TH.TABLE_NAME = T.TABLE_NAME
        GROUP BY
          CT.TABLE_NAME,
          T.AUTO_MERGE_ON
        HAVING
          SUM(CT.MEMORY_SIZE_IN_DELTA) > 5368709120 OR
          SUM(CT.RAW_RECORD_COUNT_IN_DELTA) >= GREATEST(9 * SUM(CT.RAW_RECORD_COUNT_IN_MAIN), 1000000)
      ) T ON
          C.NAME = 'LARGE_DELTA_STORAGE_AUTO' AND T.AUTO_MERGE_ON = 'TRUE' AND T.MEMORY_SIZE_IN_DELTA >= GREATEST(T.MEMORY_SIZE_IN_TOTAL / 10, 5368709120) OR
          C.NAME = 'MANY_DELTA_RECORDS_AUTO' AND T.AUTO_MERGE_ON = 'TRUE' AND T.RAW_RECORD_COUNT_IN_DELTA >= GREATEST(9 * T.RAW_RECORD_COUNT_IN_MAIN, 1000000) OR
          C.NAME = 'LARGE_DELTA_STORAGE_NOAUTO' AND T.AUTO_MERGE_ON = 'FALSE' AND T.MEMORY_SIZE_IN_DELTA >= GREATEST(T.MEMORY_SIZE_IN_TOTAL / 10, 5368709120) AND T.NUM_HOURS >= 20 AND
            ( T.MIN_RECENT_MEMORY_SIZE_IN_DELTA > 5368709120 OR T.MIN_RECENT_MEMORY_SIZE_IN_DELTA IS NULL ) OR
          C.NAME = 'MANY_DELTA_RECORDS_NOAUTO' AND T.AUTO_MERGE_ON = 'FALSE' AND T.RAW_RECORD_COUNT_IN_DELTA >= GREATEST(9 * T.RAW_RECORD_COUNT_IN_MAIN, 10000000) AND T.NUM_HOURS >= 20 AND
            ( T.MIN_RECENT_RAW_RECORD_COUNT_IN_DELTA IS NULL OR T.MIN_RECENT_RAW_RECORD_COUNT_IN_DELTA >= GREATEST(9 * T.RAW_RECORD_COUNT_IN_MAIN, 10000000) )
      ORDER BY
        T.MEMORY_SIZE_IN_DELTA DESC
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        TO_VARCHAR(SUM(MAP(U.REASON, NULL, 0, 1)))
      FROM
      ( SELECT 'CURRENT_UNLOADS' NAME,   'LOW MEMORY' REASON FROM DUMMY UNION ALL
        SELECT 'CURRENT_SHRINK_UNLOADS', 'SHRINK'            FROM DUMMY
      ) I LEFT OUTER JOIN
      ( SELECT
          U.HOST,
          U.REASON
        FROM
          BASIS_INFO BI,
          TEMP_TABLES T,
          M_CS_UNLOADS U
        WHERE
          T.SCHEMA_NAME = U.SCHEMA_NAME AND
          T.TABLE_NAME = U.TABLE_NAME AND
          T.UNLOAD_PRIORITY <= 5 AND
          U.UNLOAD_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS)
      ) U ON
        I.REASON = U.REASON
      GROUP BY
        I.NAME
    )
    UNION ALL
    ( SELECT
        'MEM_RECLAIM_PER_DAY',
        R.HOST,
        TO_VARCHAR(TO_DECIMAL(MAX(R.SUM_MEMORY_RECLAIM_DURATION / 1000 / SECONDS_BETWEEN(S.START_TIME, CURRENT_TIMESTAMP) * 86400), 10, 0))
      FROM
        M_MEMORY_RECLAIM_STATISTICS R,
        M_SERVICE_STATISTICS S
      WHERE
        S.HOST = R.HOST AND
        S.PORT = R.PORT
      GROUP BY
        R.HOST
    )
    UNION ALL
    ( SELECT
        'MEM_RECLAIM_MAX_DURATION',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAX(MAX_MEMORY_RECLAIM_DURATION / 1000), 10, 0))
      FROM
        M_MEMORY_RECLAIM_STATISTICS_RESET
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'COLUMN_UNLOAD_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(IFNULL(MAP(DAYS * COL_MEM_GB, 0, 0, TO_DECIMAL(UNLOAD_SIZE_GB / DAYS / COL_MEM_GB * 100)), 0), 10, 2))
      FROM
      ( SELECT
          IFNULL(SUM(MAP(U.COLUMN_NAME, '', CT.ESTIMATED_MAX_MEMORY_SIZE_IN_TOTAL, C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL)) / 1024 / 1024 / 1024, 0) UNLOAD_SIZE_GB,
          G.COL_MEM_GB,
          LEAST(DAYS_BETWEEN(MIN(U.UNLOAD_TIME), CURRENT_TIMESTAMP), BI.LONGTERM_DAYS) DAYS
        FROM
          GENERAL_INFO G,
          BASIS_INFO BI LEFT OUTER JOIN
          M_CS_UNLOADS U ON
            U.UNLOAD_TIME > ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS) AND
            U.REASON NOT IN ( 'CHECK', 'MERGE' ) LEFT OUTER JOIN
          TEMP_M_CS_ALL_COLUMNS C ON
            U.SCHEMA_NAME = C.SCHEMA_NAME AND
            U.TABLE_NAME = C.TABLE_NAME AND
            U.PART_ID = C.PART_ID AND
            U.COLUMN_NAME = C.COLUMN_NAME LEFT OUTER JOIN
          TEMP_M_CS_TABLES CT ON
            CT.SCHEMA_NAME = U.SCHEMA_NAME AND
            CT.TABLE_NAME = U.TABLE_NAME AND
            CT.PART_ID = U.PART_ID
        GROUP BY
          G.COL_MEM_GB,
          BI.LONGTERM_DAYS
      )
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_EVICTIONS_SHORTTERM',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(SUM(EVICT_PER_HOUR)), 10, 0))
      FROM
      ( SELECT
          S.HOST,
          ( GREATEST(0, S.EVICTED_PLAN_COUNT - LAG(S.EVICTED_PLAN_COUNT, 1) OVER ( PARTITION BY S.HOST, S.PORT ORDER BY S.SERVER_TIMESTAMP ) ) ) / 24 EVICT_PER_HOUR
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SQL_PLAN_CACHE_OVERVIEW S
        WHERE
          SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_EVICTIONS',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(SUM(EVICT_PER_HOUR)), 10, 0))
      FROM
      ( SELECT
          S.HOST,
          S.PORT,
          EVICTED_PLAN_COUNT / SECONDS_BETWEEN(SS.START_TIME, CURRENT_TIMESTAMP) * 3600 EVICT_PER_HOUR
        FROM
          TEMP_M_SQL_PLAN_CACHE_OVERVIEW S,
          M_SERVICE_STATISTICS SS
        WHERE
          S.HOST = SS.HOST AND
          S.PORT = SS.PORT
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'EXPENSIVE_SQL_TRACE_RECORDS',
        '',
        TO_VARCHAR(TO_DECIMAL(COUNT(*) / SECONDS_BETWEEN(MIN(E.START_TIME), CURRENT_TIMESTAMP) * 86400, 10, 0))
      FROM
        BASIS_INFO BI,
        TEMP_M_EXPENSIVE_STATEMENTS E
      WHERE
        SECONDS_BETWEEN(E.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
        E.OPERATION IN ('AGGREGATED_EXECUTION', 'CALL')
    )
    UNION ALL
    ( SELECT
        'TIME_SINCE_LAST_SAVEPOINT',
        HOST,
        TO_VARCHAR(GREATEST(0, SECONDS_BETWEEN(MAX(START_TIME), CURRENT_TIMESTAMP)))
      FROM
        M_SAVEPOINTS
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'LICENSE_EXPIRATION',
        '',
        TO_VARCHAR(MAP(EXPIRATION_DATE, NULL, '999999', DAYS_BETWEEN(CURRENT_DATE, EXPIRATION_DATE)))
      FROM 
        M_LICENSE
    )
    UNION ALL
    ( SELECT
        'SECURE_STORE_AVAILABLE',
        HOST,
        VALUE
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'secure_store'
    )
    UNION ALL
    ( SELECT
        'PERMANENT_LICENSE',
        '',
        MAP(PERMANENT, 'TRUE', 'yes', 'no')
      FROM
        M_LICENSE
    )
    UNION ALL
    ( SELECT
        'SERVICE_START_TIME_VARIATION',
        S.HOST,
        TO_VARCHAR(SECONDS_BETWEEN(MIN(S.START_TIME), MAX(S.START_TIME)))
      FROM
        M_SERVICE_STATISTICS S,
        M_LANDSCAPE_HOST_CONFIGURATION L
      WHERE
        S.HOST = L.HOST AND
        L.HOST_CONFIG_ROLES != 'STREAMING' AND
        S.SERVICE_NAME NOT IN ( 'diserver', 'webdispatcher', 'xscontroller', 'xsexecagent', 'xsuaaserver' )
      GROUP BY
        S.HOST
    )
    UNION ALL
    ( SELECT TOP 1
        'BACKUP_CATALOG_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(BF.BACKUP_SIZE / 1024 / 1024, 10, 2))
      FROM
        TEMP_M_BACKUP_CATALOG B,
        TEMP_M_BACKUP_CATALOG_FILES BF
      WHERE
        B.BACKUP_ID = BF.BACKUP_ID AND
        BF.SOURCE_TYPE_NAME = 'catalog' AND
        B.STATE_NAME = 'successful'
     ORDER BY
       B.SYS_START_TIME DESC
    )         
    UNION ALL
    ( SELECT
        'OLDEST_BACKUP_IN_CATALOG',
        '',
        TO_VARCHAR(DAYS_BETWEEN(MIN(SYS_START_TIME), CURRENT_TIMESTAMP))
      FROM
        TEMP_M_BACKUP_CATALOG
    )
    UNION ALL
    ( SELECT
        NAME,
        HOST,
        TO_VARCHAR(VALUE)
      FROM
      ( SELECT
          C.NAME,
          L.HOST,
          CASE C.NAME
            WHEN 'LOG_SEGMENTS_FREE'     THEN SUM(MAP(L.STATE, 'Free', 1, 0))
            WHEN 'LOG_SEGMENTS_NOT_FREE' THEN SUM(MAP(L.STATE, 'Free', 0, 'Preallocated', 0, 1))
          END VALUE
        FROM
        ( SELECT 'LOG_SEGMENTS_FREE' NAME FROM DUMMY UNION ALL
          SELECT 'LOG_SEGMENTS_NOT_FREE' FROM DUMMY
        ) C,
          M_LOG_SEGMENTS L
        GROUP BY
          C.NAME,
          L.HOST
      )
    )
    UNION ALL
    ( SELECT
        'GC_UNDO_FILE_COUNT',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_UNDO_CLEANUP_FILES
      WHERE
        TYPE != 'FREE'
    )
    UNION ALL
    ( SELECT
        'GC_UNDO_FILE_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(SUM(IFNULL(RAW_SIZE, 0)) / 1024 / 1024 / 1024, 10, 2))
      FROM
        M_UNDO_CLEANUP_FILES
      WHERE
        TYPE != 'FREE'
    )
    UNION ALL
    ( SELECT
        C.NAME,
        SN.HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAP(C.NAME, 
          'SERVICE_SEND_INTRANODE', CASE WHEN SUM(SN.SEND_SIZE_INTRA) / 1024 / 1024 / 1024 < 10 THEN 
             999999 ELSE MAP(SUM(SN.SEND_DURATION_INTRA), 0, 0, SUM(SN.SEND_SIZE_INTRA) / 1024 / 1024 / ( MAP(SUM(SN.SEND_DURATION_INTRA), 0, 0, SUM(SN.SEND_DURATION_INTRA) / 1000 / 1000 ))) END,
          'SERVICE_SEND_INTERNODE', CASE WHEN SUM(SN.SEND_SIZE_INTER) / 1024 / 1024 / 1024 < 10 THEN 
             999999 ELSE MAP(SUM(SN.SEND_DURATION_INTER), 0, 0, SUM(SN.SEND_SIZE_INTER) / 1024 / 1024 / ( MAP(SUM(SN.SEND_DURATION_INTER), 0, 0, SUM(SN.SEND_DURATION_INTER) / 1000 / 1000 ))) END,
          'NETWORK_VOLUME_INTRANODE', SUM(MAP(SN.SECONDS, 0, 0, (SN.SEND_SIZE_INTRA + SN.RECEIVE_SIZE_INTRA) / SN.SECONDS)) / 1024 / 1024,
          'NETWORK_VOLUME_INTERNODE', SUM(MAP(SN.SECONDS, 0, 0, (SN.SEND_SIZE_INTER + SN.RECEIVE_SIZE_INTER) / SN.SECONDS)) / 1024 / 1024
        )), 10, 0))
      FROM
      ( SELECT 'SERVICE_SEND_INTRANODE' NAME FROM DUMMY UNION ALL
        SELECT 'SERVICE_SEND_INTERNODE'      FROM DUMMY UNION ALL
        SELECT 'NETWORK_VOLUME_INTRANODE'    FROM DUMMY UNION ALL
        SELECT 'NETWORK_VOLUME_INTERNODE'    FROM DUMMY
      ) C LEFT OUTER JOIN
      ( SELECT
          SECONDS_BETWEEN(S.START_TIME, CURRENT_TIMESTAMP) SECONDS,
          SENDER_HOST HOST,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN SEND_SIZE        ELSE 0                END SEND_SIZE_INTRA,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN 0                ELSE SEND_SIZE        END SEND_SIZE_INTER,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN SEND_DURATION    ELSE 0                END SEND_DURATION_INTRA,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN 0                ELSE SEND_DURATION    END SEND_DURATION_INTER,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN RECEIVE_SIZE     ELSE 0                END RECEIVE_SIZE_INTRA,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN 0                ELSE RECEIVE_SIZE     END RECEIVE_SIZE_INTER,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN RECEIVE_DURATION ELSE 0                END RECEIVE_DURATION_INTRA,
          CASE WHEN SENDER_HOST = RECEIVER_HOST THEN 0                ELSE RECEIVE_DURATION END RECEIVE_DURATION_INTER
        FROM
          TEMP_M_SERVICE_NETWORK_IO N,
          M_SERVICE_STATISTICS S
        WHERE
          S.HOST = N.SENDER_HOST AND
          S.PORT = N.SENDER_PORT
      ) SN ON
        1 = 1
      GROUP BY
        C.NAME,
        SN.HOST
    )
    UNION ALL
    ( SELECT
        'ST_POINT_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_TABLES T,
        TEMP_TABLE_COLUMNS C
      WHERE
        T.SCHEMA_NAME = C.SCHEMA_NAME AND
        T.TABLE_NAME = C.TABLE_NAME AND
        C.DATA_TYPE_NAME = 'ST_POINT' AND
        T.TABLE_TYPE = 'ROW' AND
        T.IS_USER_DEFINED_TYPE != 'TRUE'
    )
    UNION ALL
    ( SELECT
        MAP(ID, 5034, 'THREAD_SAMPLES_INTERVAL', 'THREAD_CALLSTACKS_INTERVAL'),
        '',
        TO_VARCHAR(INTERVALLENGTH)
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        ID IN ( 5034, 5057 )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        CASE C.NAME
          WHEN 'STAT_SERVER_TABLE_SIZE'  THEN TO_VARCHAR(TO_DECIMAL(SUM(TABLE_SIZE) / 1024 / 1024 / 1024, 10, 2))
          WHEN 'STAT_SERVER_TABLE_SHARE' THEN TO_VARCHAR(TO_DECIMAL(MAP(G.ALLOC_LIM_GB, 0, 0, SUM(TABLE_SIZE / 1024 / 1024 / 1024) / AVG(G.ALLOC_LIM_GB) * 100), 10, 2))
        END
      FROM
      ( SELECT 'STAT_SERVER_TABLE_SIZE' NAME FROM DUMMY UNION ALL
        SELECT 'STAT_SERVER_TABLE_SHARE'    FROM DUMMY
      ) C,
        GENERAL_INFO G,
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE TABLE_SIZE
        FROM
          TEMP_M_RS_TABLES 
        WHERE
          SCHEMA_NAME = '_SYS_STATISTICS'
        UNION ALL
        SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          INDEX_SIZE TABLE_SIZE
        FROM
          TEMP_M_RS_INDEXES
        WHERE
          SCHEMA_NAME = '_SYS_STATISTICS'
        UNION ALL
        SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          MEMORY_SIZE_IN_TOTAL + PERSISTENT_MEMORY_SIZE_IN_TOTAL SIZE_BYTE
        FROM
          TEMP_M_CS_TABLES 	
        WHERE
          SCHEMA_NAME = '_SYS_STATISTICS'
      )
      GROUP BY
        G.ALLOC_LIM_GB,
        C.NAME
    )
    UNION ALL
    ( SELECT
        'VARYING_MEMORY',
        '',
        CASE WHEN (MAX(H.VALUE) - MIN(H.VALUE)) / 1024 / 1024 / 1024 <= 1 THEN 'no' ELSE 'yes' END
      FROM
        M_HOST_INFORMATION H,
        M_LANDSCAPE_HOST_CONFIGURATION L
      WHERE
        H.HOST = L.HOST AND
        L.WORKER_ACTUAL_GROUPS NOT LIKE '%worker_dt%' AND          /* extension nodes can have different amount of memory */
        H.KEY = 'mem_phys'
    )
    UNION ALL
    ( SELECT
        N.NAME,
        '',
        TO_VARCHAR(SUM(MAP(T.TABLE_NAME, NULL, 0, 1)))
      FROM
      ( SELECT 'QCM_TABLES' NAME, 'QCM%' PATTERN FROM DUMMY UNION ALL
        SELECT 'BPC_TABLES',      '$BPC$HC$%'    FROM DUMMY UNION ALL
        SELECT 'BPC_TABLES',      '$BPC$TMP%'    FROM DUMMY UNION ALL
        SELECT 'ZBICZ_TABLES',    'ZBICZ%'       FROM DUMMY
      ) N LEFT OUTER JOIN
        TEMP_TABLES T ON
          T.TABLE_NAME LIKE N.PATTERN AND
          T.IS_TEMPORARY = 'FALSE'
      GROUP BY
        N.NAME
    )
    UNION ALL
    ( SELECT
        'TOPOLOGY_SHARED_MEMORY',
        HOST,
        TO_VARCHAR(MAX(TO_DECIMAL(ROUND(MAP(ALLOCATED_SIZE, 0, 0, USED_SIZE / ALLOCATED_SIZE * 100)), 10, 0)))
      FROM
        M_SHARED_MEMORY
      WHERE
        CATEGORY = 'TOPOLOGY'
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'DISK_DATA_FRAGMENTATION',
        IFNULL(HOST, ''),
        IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND((1 - MAP(SUM(F.TOTAL_SIZE), 0, 0, SUM(F.USED_SIZE) / SUM(F.TOTAL_SIZE))) * 100), 10, 0)), '999999')
      FROM
        DUMMY D LEFT OUTER JOIN
        TEMP_M_VOLUME_FILES F ON
          1 = 1
      WHERE
        F.FILE_TYPE = 'DATA'
      GROUP BY
        F.HOST
      HAVING
        SUM(F.USED_SIZE) / 1024 / 1024 / 1024 >= 5
    )
    UNION ALL
    ( SELECT
        'EMBEDDED_STAT_SERVER_USED',
        '',
        MAP(LOWER(MAX(VALUE)), 'true', 'yes', 'false', 'no', 'yes')     
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE 
        FILE_NAME IN ('indexserver.ini', 'nameserver.ini') AND
        SECTION = 'statisticsserver' AND
        KEY = 'active'
    )
    UNION ALL
    ( SELECT
        'CATALOG_READ_GRANTED',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        EFFECTIVE_PRIVILEGES
      WHERE
        USER_NAME = CURRENT_USER AND
        PRIVILEGE = 'CATALOG READ'
    )
    UNION ALL
    ( SELECT
        NAME,
        '',
        CASE NAME
          WHEN 'TABLES_AUTOMERGE_DISABLED' THEN TO_VARCHAR(SUM(MAP(AUTO_MERGE_ON, 'FALSE', 1, 0)))
          WHEN 'TABLES_AUTOCOMP_DISABLED'  THEN TO_VARCHAR(SUM(MAP(AUTO_OPTIMIZE_COMPRESSION_ON, 'FALSE', 1, 0)))
        END
      FROM
      ( SELECT 'TABLES_AUTOMERGE_DISABLED' NAME FROM DUMMY UNION ALL
        SELECT 'TABLES_AUTOCOMP_DISABLED' NAME FROM DUMMY
      ) BI,
        TEMP_TABLES T
      WHERE
        ( T.TABLE_NAME LIKE '/BA1/%' OR
          ( T.TABLE_NAME NOT LIKE 'RSPM%' AND 
            T.TABLE_NAME NOT LIKE 'ZBICZ%' AND
            T.TABLE_NAME NOT LIKE '0BW:BIA%' AND
            T.TABLE_NAME NOT LIKE '$BPC$HC$%' AND
            T.TABLE_NAME NOT LIKE '$BPC$TMP%' AND
            T.TABLE_NAME NOT LIKE '/B%/%' AND
            T.TABLE_NAME NOT LIKE '/1B0/%' AND
            T.TABLE_NAME NOT LIKE '/1DD/%' AND
            SUBSTR(T.TABLE_NAME, 1, 3) != 'TR_' 
          ) 
        ) AND
        IS_COLUMN_TABLE = 'TRUE' AND
        IS_TEMPORARY = 'FALSE'
      GROUP BY
        NAME
    )
    UNION ALL
    ( SELECT
        'TABLES_PERSMERGE_DISABLED',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_TABLES
      WHERE
        PERSISTENT_MERGE = 'FALSE' 
    )
    UNION ALL
    ( SELECT
        L.NAME,
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MIN(S.TIMESTAMP), CURRENT_TIMESTAMP) / MAP(L.NAME, 'OLDEST_REPLICATION_SNAPSHOT', 3600, 86400), 10, 2)), 'n/a')
      FROM
      ( SELECT 'OLDEST_REPLICATION_SNAPSHOT' NAME FROM DUMMY UNION ALL
        SELECT 'OLDEST_BACKUP_SNAPSHOT' FROM DUMMY UNION ALL
        SELECT 'OLDEST_FALLBACK_SNAPSHOT' FROM DUMMY
      ) L LEFT OUTER JOIN
        M_SNAPSHOTS S ON
        ( L.NAME = 'OLDEST_BACKUP_SNAPSHOT' AND S.FOR_BACKUP = 'TRUE' OR
          L.NAME = 'OLDEST_REPLICATION_SNAPSHOT' AND S.FOR_BACKUP = 'FALSE' AND S.PURPOSE = 'SNAPSHOT_FOR_REPLICATION' OR
          L.NAME = 'OLDEST_FALLBACK_SNAPSHOT' AND S.FOR_BACKUP = 'FALSE' AND S.PURPOSE = 'SNAPSHOT'
        )
      GROUP BY
        L.NAME
    )
    UNION ALL
    ( SELECT
        D.NAME,
        HOST,      
          CASE NAME
            WHEN 'SAVEPOINT_THROUGHPUT'      THEN TO_VARCHAR(TO_DECIMAL(ROUND(MAP(SUM(NANO100_BETWEEN(START_TIME, CRITICAL_PHASE_START_TIME) / 10 + CRITICAL_PHASE_DURATION ), 0, NULL,
                                                  SUM(TOTAL_SIZE)) / SUM(NANO100_BETWEEN(START_TIME, CRITICAL_PHASE_START_TIME) / 10 + CRITICAL_PHASE_DURATION ) / 1024 / 1024 * 1000 * 1000), 10, 0))
            WHEN 'SAVEPOINT_CRIT_THROUGHPUT' THEN
            CASE
              WHEN SUM(FLUSHED_SIZE_IN_CRITICAL_PHASE) = 0 THEN 'n/a'
              ELSE                                TO_VARCHAR(TO_DECIMAL(ROUND(MAP(SUM(CRITICAL_PHASE_DURATION - MIN_CRITICAL_PHASE_DURATION), 0, NULL,
                                                  SUM(FLUSHED_SIZE_IN_CRITICAL_PHASE) / SUM(CRITICAL_PHASE_DURATION - MIN_CRITICAL_PHASE_DURATION)) / 1024 / 1024 * 1000 * 1000), 10, 0))
            END
          END
      FROM
      ( SELECT 'SAVEPOINT_THROUGHPUT' NAME FROM DUMMY UNION ALL
        SELECT 'SAVEPOINT_CRIT_THROUGHPUT' FROM DUMMY
      ) D,
      ( SELECT /* Critical phase has some runtime overhead irrespective of I/O, so the minimum duration per HOST / PORT needs to be subtracted */
          MIN(S.CRITICAL_PHASE_DURATION) OVER (PARTITION BY S.HOST, S.PORT ORDER BY S.CRITICAL_PHASE_DURATION) MIN_CRITICAL_PHASE_DURATION,
          S.*
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SAVEPOINTS S
        WHERE
          S.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS)
      ) S
      GROUP BY
        D.NAME,
        S.HOST
    )
    UNION ALL
    ( SELECT
        'LONG_RUNNING_SAVEPOINTS',
        IFNULL(HOST, '') HOST,
        TO_VARCHAR(IFNULL(LONG_SAVEPOINTS, 0))
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          S.HOST,
          COUNT(*) LONG_SAVEPOINTS
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SAVEPOINTS S
        WHERE
          SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          S.DURATION > 900000000
        GROUP BY
          S.HOST
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'LARGE_TABLES_NOT_COMPRESSED',
        '',
        TO_VARCHAR(COUNT(DISTINCT(CT.SCHEMA_NAME || CT.TABLE_NAME)))
      FROM
        TEMP_TABLES T,
        TEMP_M_CS_TABLES CT
      WHERE
        T.SCHEMA_NAME = CT.SCHEMA_NAME AND
        T.TABLE_NAME = CT.TABLE_NAME AND
        T.IS_TEMPORARY = 'FALSE' AND
        CT.LAST_COMPRESSED_RECORD_COUNT = 0 AND
        CT.RAW_RECORD_COUNT_IN_MAIN > 10000000
    )
    UNION ALL
    ( SELECT
        'TABLE_ALLOCATION_LIMIT_RATIO',
        T.HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAP(G.ALLOC_LIM_GB, 0, 0, T.TABLE_MEMORY_BYTES / 1024 / 1024 / 1024 / G.ALLOC_LIM_GB) * 100), 10, 0))
      FROM
        GENERAL_INFO G,
      ( SELECT
          HOST,
          SUM(TABLE_MEMORY_BYTES) TABLE_MEMORY_BYTES
        FROM
        ( SELECT 
            HOST,
            SUM(USED_MEMORY_SIZE) TABLE_MEMORY_BYTES
          FROM
            TEMP_M_SERVICE_COMPONENT_MEMORY
          WHERE
            UPPER(COMPONENT) IN 
            ( 'ROW STORE TABLES',
              'ROW STORE TABLES + INDEXES'
            )
          GROUP BY
            HOST
          UNION ALL
          SELECT
            T.HOST,
            SUM(T.MEMORY_SIZE_IN_TOTAL + MAP(G.PMEM_USED, ' ', T.PERSISTENT_MEMORY_SIZE_IN_TOTAL, 0)) TABLE_MEMORY_BYTES
          FROM
            GENERAL_INFO G,
            TEMP_M_CS_TABLES T
          GROUP BY
            T.HOST
          UNION ALL
          SELECT
            HOST,
            SUM(EXCLUSIVE_SIZE_IN_USE) TABLE_MEMORY_BYTES
          FROM
            M_HEAP_MEMORY
          WHERE
            CATEGORY LIKE 'Pool/LVCAllocator/LVCContainerDir%'
          GROUP BY
            HOST
        )
        GROUP BY
          HOST
      ) T
    )
    UNION ALL
    ( SELECT
        'HOST_OBJ_LOCK_UNKNOWN',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.HOST_OBJECT_LOCK_STATISTICS_BASE
      WHERE
        OBJECT_NAME = '(unknown)'
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        CASE I.NAME
          WHEN 'ABAP_BUFFER_LOADING' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE '%/* Buffer Loading */%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'ABAP_COMPAT_VIEW' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE '%/* Redirected table:%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'ABAP_MULTI_CONCAT' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN LOCATE(STATEMENT_STRING, CHAR(32) || ') OR (' || CHAR(32), 1, 19 ) != 0 THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'FDA_WRITE' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE '%' || CHAR(63) || ' AS "t_00"%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'DPSERVER_SOURCE_SELECTS' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE 'SELECT HADP%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'STAT_SERVER_MANUAL' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE 'CALL _SYS_STATISTICS.STATISTICS_SCHEDULABLEWRAPPER (_Manual_,%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
          WHEN 'SLT_LOGGING_SESSIONS' THEN
            TO_VARCHAR(TO_DECIMAL(SUM(CASE WHEN STATEMENT_STRING LIKE '%/1CADMC/%' THEN TOTAL_EXECUTION_TIME ELSE 0 END) / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2))
        END
      FROM
      ( SELECT 'ABAP_BUFFER_LOADING' NAME FROM DUMMY UNION ALL
        SELECT 'ABAP_MULTI_CONCAT'        FROM DUMMY UNION ALL
        SELECT 'FDA_WRITE'                FROM DUMMY UNION ALL
        SELECT 'DPSERVER_SOURCE_SELECTS'  FROM DUMMY UNION ALL
        SELECT 'ABAP_COMPAT_VIEW'         FROM DUMMY UNION ALL
        SELECT 'STAT_SERVER_MANUAL'       FROM DUMMY UNION ALL
        SELECT 'SLT_LOGGING_SESSIONS'     FROM DUMMY
      ) I,
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
      WHERE
        SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS)
      GROUP BY
        I.NAME,
        BI.SHORTTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'CPBTREE_LEAK',
        '',
        TO_VARCHAR(TO_DECIMAL(GREATEST(0, HEAP_SIZE_GB - INDEX_SIZE_GB), 10, 2))
      FROM
      ( SELECT
          ( SELECT IFNULL(SUM(INDEX_SIZE) / 1024 / 1024 / 1024, 0) FROM TEMP_M_RS_INDEXES ) INDEX_SIZE_GB,
          ( SELECT IFNULL(SUM(EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024, 0) FROM M_HEAP_MEMORY WHERE CATEGORY like 'Pool/Row%/CpbTree' ) HEAP_SIZE_GB
        FROM
          DUMMY
      ) 
    )
    UNION ALL
    ( SELECT
        'ROW_STORE_TABLE_LEAK',
        '',
        TO_VARCHAR ( TO_DECIMAL ( GREATEST ( 0, ( GLOBAL_USED - SUM_INDIVIDUAL_USED ) / 1024 / 1024 / 1024 ), 10, 2 ) )
      FROM
      ( SELECT SUM(USED_SIZE) GLOBAL_USED FROM TEMP_M_RS_MEMORY WHERE CATEGORY = 'TABLE' ),
      ( SELECT SUM(ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE) SUM_INDIVIDUAL_USED FROM TEMP_M_RS_TABLES )
    )
    UNION ALL
    ( SELECT
        'SQL_PREPARATION_SHARE',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(ELAPSED_TIME, 0, 0, PREP_TIME / ELAPSED_TIME * 100), 10, 2))  
      FROM
      ( SELECT
          HOST,
          SUM(TOTAL_EXECUTION_TIME) + SUM(TOTAL_PREPARATION_TIME) ELAPSED_TIME,
          SUM(TOTAL_PREPARATION_TIME) PREP_TIME
        FROM
          M_SQL_PLAN_STATISTICS
        GROUP BY
          HOST
      )
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_USED_BY_TABLE',
        HOST,
        TO_VARCHAR(MAP(HOST, NULL, 'none', ACCESSED_TABLE_NAMES || CHAR(32) || '(' || SIZE_PCT || CHAR(32) || '%)'))
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          TO_VARCHAR(ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
          TO_DECIMAL(MAP(TOTAL_PLAN_MEMORY_SIZE, 0, 0, SUM(PLAN_MEMORY_SIZE) / TOTAL_PLAN_MEMORY_SIZE * 100), 10, 0) SIZE_PCT
        FROM
        ( SELECT
            SUM(PLAN_MEMORY_SIZE) OVER (PARTITION BY HOST) TOTAL_PLAN_MEMORY_SIZE,
            *
          FROM
            TEMP_M_SQL_PLAN_CACHE
        )
        GROUP BY
          HOST,
          TO_VARCHAR(ACCESSED_TABLE_NAMES),
          TOTAL_PLAN_MEMORY_SIZE
        HAVING
          SUM(PLAN_MEMORY_SIZE) > 0.1 * TOTAL_PLAN_MEMORY_SIZE
      ) ON
        ACCESSED_TABLE_NAMES != ''
      GROUP BY
        HOST,
        ACCESSED_TABLE_NAMES,
        SIZE_PCT
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_USED_BY_APP_SOURCE',
        HOST,
        TO_VARCHAR(MAP(HOST, NULL, 'none', APPLICATION_SOURCE || CHAR(32) || '(' || SIZE_PCT || CHAR(32) || '%)'))
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          APPLICATION_SOURCE,
          TO_DECIMAL(MAP(TOTAL_PLAN_MEMORY_SIZE, 0, 0, SUM(PLAN_MEMORY_SIZE) / TOTAL_PLAN_MEMORY_SIZE * 100), 10, 0) SIZE_PCT
        FROM
        ( SELECT
            SUM(PLAN_MEMORY_SIZE) OVER (PARTITION BY HOST) TOTAL_PLAN_MEMORY_SIZE,
            *
          FROM
            TEMP_M_SQL_PLAN_CACHE
        )
        GROUP BY
          HOST,
          APPLICATION_SOURCE,
          TOTAL_PLAN_MEMORY_SIZE
        HAVING
          SUM(PLAN_MEMORY_SIZE) > 0.1 * TOTAL_PLAN_MEMORY_SIZE AND
          SUM(PLAN_MEMORY_SIZE) / 1024 / 1024 / 1024 > 1
      ) ON
        APPLICATION_SOURCE != ''
      GROUP BY
        HOST,
        APPLICATION_SOURCE,
        SIZE_PCT
    )
    UNION ALL
    ( SELECT
        'AVG_DB_REQUEST_TIME',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(SUM(EXECUTION_COUNT), 0, 0, SUM(TOTAL_EXECUTION_TIME) / SUM(EXECUTION_COUNT)) / 1000, 10, 2))
      FROM
        TEMP_M_SQL_PLAN_CACHE
    )
    UNION ALL
    ( SELECT
        'REPLICATION_ERROR',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICE_REPLICATION
      WHERE
        REPLICATION_STATUS = 'ERROR'
    )
    UNION ALL
    ( SELECT
        'REPLICATION_UNKNOWN',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICES S,
        M_SERVICE_REPLICATION SR
      WHERE
        S.HOST = SR.HOST AND
        S.PORT = SR.PORT AND
        S.COORDINATOR_TYPE != 'STANDBY' AND
        SR.REPLICATION_STATUS = 'UNKNOWN'
    )
    UNION ALL
    ( SELECT
        'OLD_LOG_POSITION',
        '',
        TO_VARCHAR(TO_DECIMAL(ROUND(MAX(LOG_POS_DIFF)), 10, 0))
      FROM
      ( SELECT
          L.HOST,
          L.PORT,
          GREATEST(0, (MAX(L.MAX_POSITION) - MAX(R.LAST_LOG_POSITION)) / 1024 / 16) LOG_POS_DIFF
        FROM
          M_LOG_SEGMENTS L,
          M_SERVICE_REPLICATION R
        WHERE
          L.HOST = R.HOST AND
          L.PORT = R.PORT
        GROUP BY
          L.HOST,
          L.PORT
      )
    )
    UNION ALL
    ( SELECT
        'LOG_SHIPPING_DELAY',
        '',
        IFNULL(TO_VARCHAR(MAX(SECONDS_BETWEEN(SHIPPED_LOG_POSITION_TIME, LAST_LOG_POSITION_TIME))), '0')
      FROM
        DUMMY LEFT OUTER JOIN
        M_SERVICE_REPLICATION ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        'LOG_SHIPPING_ASYNC_BUFF_FILL',
        R.HOST,
        IFNULL(TO_VARCHAR(TO_DECIMAL((GREATEST(0, MAP(P.BUFFER_SIZE, 0, 0, R.BUFFER_FILLED / P.BUFFER_SIZE * 100))), 10, 0)), 'n/a')
      FROM
      ( SELECT
          TO_BIGINT(MAX(VALUE)) BUFFER_SIZE
        FROM
          M_CONFIGURATION_PARAMETER_VALUES
        WHERE 
          SECTION = 'system_replication' AND
          KEY = 'logshipping_async_buffer_size'
      ) P LEFT OUTER JOIN
      ( SELECT
          HOST,
          MAX( LAST_LOG_POSITION - SHIPPED_LOG_POSITION ) * 64 BUFFER_FILLED
        FROM
          M_SERVICE_REPLICATION
        WHERE
          REPLICATION_MODE = 'ASYNC'
        GROUP BY
          HOST
      ) R ON
        1 = 1
      GROUP BY
        R.HOST,
        P.BUFFER_SIZE,
        R.BUFFER_FILLED
    )
    UNION ALL
    ( SELECT
        NAME,
        IFNULL(HOST, '') HOST,
        IFNULL(CASE NAME
          WHEN 'SYNC_LOG_SHIPPING_TIME_HIST' THEN TO_VARCHAR(TO_DECIMAL(MAX_LOG_SHIP_MS_PER_REQ, 10, 2))
          ELSE MAP(LOG_SHIP_CNT, 0, 'n/a', TO_VARCHAR(TO_DECIMAL(IFNULL(MAP(LOG_SHIP_CNT, 0, 0, LOG_SHIP_MS / LOG_SHIP_CNT), 0), 10, 2))) END, 'n/a')
      FROM
      ( SELECT
          C.NAME,
          R.HOST,
          SUM(CASE WHEN SECONDS_BETWEEN(R.SERVER_TIMESTAMP, M.SERVER_TIMESTAMP) <= C.SECONDS THEN R.LOG_SHIP_CNT ELSE 0 END) LOG_SHIP_CNT,
          SUM(CASE WHEN SECONDS_BETWEEN(R.SERVER_TIMESTAMP, M.SERVER_TIMESTAMP) <= C.SECONDS THEN R.LOG_SHIP_MS ELSE 0 END) LOG_SHIP_MS,
          MAX(MAP(LOG_SHIP_CNT, 0, 0, LOG_SHIP_MS / LOG_SHIP_CNT)) MAX_LOG_SHIP_MS_PER_REQ
        FROM
        ( SELECT 'SYNC_LOG_SHIPPING_TIME_REC' NAME,  86400 * SHORTTERM_DAYS SECONDS FROM BASIS_INFO UNION ALL
          SELECT 'SYNC_LOG_SHIPPING_TIME_HIST',      86400 * LONGTERM_DAYS          FROM BASIS_INFO
        ) C LEFT OUTER JOIN
        ( SELECT
            MAX(SERVER_TIMESTAMP) SERVER_TIMESTAMP,
            HOST
          FROM
            _SYS_STATISTICS.HOST_SERVICE_REPLICATION
          WHERE
            REPLICATION_MODE LIKE 'SYNC%'
          GROUP
            BY HOST
        ) M ON
          1 = 1 LEFT OUTER JOIN
        ( SELECT
            SERVER_TIMESTAMP,
            HOST,
            LOG_SHIP_CNT,
            LOG_SHIP_MS
          FROM
          ( SELECT
              SERVER_TIMESTAMP,
              HOST,
              ( SUM(SHIPPED_LOG_BUFFERS_COUNT)      - LAG(SUM(SHIPPED_LOG_BUFFERS_COUNT), 1)      OVER (PARTITION BY HOST ORDER BY SERVER_TIMESTAMP))        LOG_SHIP_CNT,
              ( SUM(SHIPPED_LOG_BUFFERS_DURATION)   - LAG(SUM(SHIPPED_LOG_BUFFERS_DURATION), 1)   OVER (PARTITION BY HOST ORDER BY SERVER_TIMESTAMP)) / 1000 LOG_SHIP_MS
            FROM
              _SYS_STATISTICS.HOST_SERVICE_REPLICATION
            WHERE
              REPLICATION_MODE LIKE 'SYNC%'
            GROUP BY
              SERVER_TIMESTAMP,
              HOST
          )
          WHERE
            LOG_SHIP_CNT >= 0
        ) R ON
          R.HOST = M.HOST AND
          M.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -C.SECONDS - 7200 ) 
        GROUP BY
          C.NAME,
          R.HOST
      )
    )
    UNION ALL
    ( SELECT
        'ASYNC_BUFFER_FULL_SHORTTERM',
        R.HOST,
        TO_VARCHAR(BUFF_FULL)
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          SUM(BUFF_FULL) BUFF_FULL,
          HOST
        FROM
        ( SELECT
            R.SERVER_TIMESTAMP,
            R.HOST,
            R.ASYNC_BUFFER_FULL_COUNT - LAG(R.ASYNC_BUFFER_FULL_COUNT, 1) OVER (PARTITION BY R.HOST, R.SECONDARY_HOST, R.PORT ORDER BY R.SERVER_TIMESTAMP) BUFF_FULL
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_SERVICE_REPLICATION R
          WHERE
            SECONDS_BETWEEN(R.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        )
        WHERE
          BUFF_FULL >= 0
        GROUP BY
          HOST
      ) R ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'LAST_SPECIAL_DUMP',
        '',
        TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(FILE_MTIME), CURRENT_TIMESTAMP) / 86400, 10, 2))
      FROM
        M_TRACEFILES
      WHERE
        ( FILE_NAME LIKE '%.crashdump.%.trc' OR
          FILE_NAME LIKE '%.emergencydump.%.trc' OR
          FILE_NAME LIKE '%.rtedump.%.trc' 
        ) AND
        FILE_NAME NOT LIKE '%rtedump%oom%.trc'
    )
    UNION ALL
    ( SELECT
       NAME,
       '',
       TO_VARCHAR(TO_DECIMAL(MAP(TOTAL_SIZE, 0, 0, PLAN_SIZE / TOTAL_SIZE * 100), 10, 2))
      FROM
      ( SELECT
          L.NAME,
          SUM(S.PLAN_MEMORY_SIZE) PLAN_SIZE
        FROM
        ( SELECT 'SQL_CACHE_LONG_INLIST' NAME FROM DUMMY UNION ALL
          SELECT 'SQL_CACHE_LONG_CONCAT' FROM DUMMY
        ) L,
          TEMP_M_SQL_PLAN_CACHE S
        WHERE
        ( L.NAME = 'SQL_CACHE_LONG_INLIST' AND
          ( STATEMENT_STRING LIKE '%' || RPAD('', 396, CHAR(63) || CHAR(32) || ',' || CHAR(32)) || '%' OR
            LOCATE(TO_VARCHAR(STATEMENT_STRING), '(' || CHAR(63) || ',' || CHAR(32) || CHAR(63), 1, 100) != 0
          ) 
        ) OR
        ( L.NAME = 'SQL_CACHE_LONG_CONCAT' AND
          ( LOCATE(STATEMENT_STRING, CHAR(32) || ') OR (' || CHAR(32), 1,  5) != 0 OR
            STATEMENT_STRING LIKE '%' || RPAD('', 20, CHAR(32) || 'OR' || CHAR(32) || '%')
          ) 
        )
        GROUP BY
          L.NAME
      ),
      ( SELECT SUM(CACHED_PLAN_SIZE) TOTAL_SIZE FROM TEMP_M_SQL_PLAN_CACHE_OVERVIEW )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        SC.HOST,
        CASE C.NAME
          WHEN 'SQL_CACHE_DUPLICATE_HASHES' THEN 
            TO_VARCHAR(TO_DECIMAL(MAP(SC.TOTAL_ENTRIES, 0, 0, 100 - SC.DISTINCT_HASHES / SC.TOTAL_ENTRIES * 100), 10, 2)) 
          WHEN 'SQL_CACHE_SESSION_LOCAL' THEN 
            TO_VARCHAR(TO_DECIMAL(MAP(SC.TOTAL_ENTRIES, 0, 0, SC.SESSION_LOCAL_ENTRIES / SC.TOTAL_ENTRIES * 100), 10, 2))
          WHEN 'SQL_CACHE_REFERENCED' THEN
            TO_VARCHAR(TO_DECIMAL(MAP(SC.TOTAL_PLAN_SIZE, 0, 0, SC.REFERENCED_PLAN_SIZE / SC.TOTAL_PLAN_SIZE * 100), 10, 2))
        END
      FROM
      ( SELECT 'SQL_CACHE_DUPLICATE_HASHES' NAME FROM DUMMY UNION ALL
        SELECT 'SQL_CACHE_SESSION_LOCAL' FROM DUMMY UNION ALL
        SELECT 'SQL_CACHE_REFERENCED' FROM DUMMY
      ) C,
      ( SELECT
          HOST,
          COUNT(*) TOTAL_ENTRIES,
          COUNT(DISTINCT(STATEMENT_HASH)) DISTINCT_HASHES,
          SUM(MAP(PLAN_SHARING_TYPE, 'SESSION LOCAL', 1, 0)) SESSION_LOCAL_ENTRIES,
          SUM(PLAN_MEMORY_SIZE) TOTAL_PLAN_SIZE,
          SUM(MAP(REFERENCE_COUNT, 0, 0, PLAN_MEMORY_SIZE)) REFERENCED_PLAN_SIZE
        FROM
          TEMP_M_SQL_PLAN_CACHE
        GROUP BY
          HOST
      ) SC
    )
    UNION ALL
    ( SELECT
        'DELIVERED_STATEMENT_HINTS',
        '',
        CASE WHEN COUNT(*) >= 100 THEN 'yes' ELSE 'no' END
      FROM
        STATEMENT_HINTS
      WHERE
        COMMENTS LIKE 'SAP Note 2700051%' AND COMMENTS >= 'SAP Note 2700051,' || CHAR(32) || TO_VARCHAR(ADD_DAYS(CURRENT_TIMESTAMP, -365), 'YYYY/MM/DD')
    )
    UNION ALL
    ( SELECT
        'TOTAL_STATEMENT_HINTS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        STATEMENT_HINTS
    )
    UNION ALL
    ( SELECT
        'UDIV_OVERHEAD',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT
          SUM(MAX_UDIV) MAX_UDIV,
          SUM(RAW_RECORD_COUNT_IN_MAIN + RAW_RECORD_COUNT_IN_DELTA) RAW_RECORDS
        FROM
          TEMP_M_CS_TABLES
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
      )
      WHERE
        MAX_UDIV >= 10000000 AND
        MAX_UDIV >= RAW_RECORDS * 2
    )
    UNION ALL
    ( SELECT
        'REP_PARAMETER_DEVIATION',
        '',
        TO_VARCHAR(COUNT(DISTINCT(SUBSTR_AFTER(ALERT_DETAILS, 'parameter mismatch'))))
      FROM
        _SYS_STATISTICS.STATISTICS_ALERTS
      WHERE
        ALERT_ID IN ( 21, 79 ) AND
        SECONDS_BETWEEN(ALERT_TIMESTAMP, CURRENT_TIMESTAMP) <= 7200 AND
        ALERT_DETAILS LIKE '%parameter mismatch%'
    )
    UNION ALL
    ( SELECT
        'SDI_SUBSCRIPTION_EXCEPTIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        REMOTE_SUBSCRIPTION_EXCEPTIONS R
      WHERE
        SECONDS_BETWEEN(R.EXCEPTION_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'SDI_APPLY_DELAY',
        '',
        TO_VARCHAR(IFNULL(MAX(SECONDS_BETWEEN(LAST_MESSAGE_APPLIED, LAST_MESSAGE_RECEIVED)), 0))
      FROM
        DUMMY LEFT OUTER JOIN
        M_REMOTE_SUBSCRIPTION_STATISTICS ON
          LAST_MESSAGE_RECEIVED IS NOT NULL AND
          LAST_MESSAGE_APPLIED IS NOT NULL AND
          LAST_MESSAGE_APPLIED <= LAST_MESSAGE_RECEIVED
    )
    UNION ALL
    ( SELECT
        'EMPTY_TABLE_PLACEMENT',
        '',
        CASE WHEN B.IS_BW_USED = 'Yes' AND P.NUM_ENTRIES = 0 THEN 'yes' ELSE 'no' END
      FROM
        ( SELECT
            COUNT(*) NUM_ENTRIES 
          FROM 
            TABLE_PLACEMENT
          WHERE
            GROUP_TYPE LIKE 'sap.bw.%'
        ) P,
        ( SELECT
            CASE WHEN IFNULL(SUM(RECORD_COUNT), 0) <= 10 THEN 'No' ELSE 'Yes' END IS_BW_USED
          FROM
            TEMP_M_CS_TABLES
          WHERE
            TABLE_NAME = '/BI0/SREQUID'
        ) B
    )
    UNION ALL
    ( SELECT /* Starting with SAP HANA Rev. 1.00.122.03 only PREFIXED is critical, SPARSE will no longer be reported */
        'INDEXES_ON_SPARSE_PREFIXED',
        '',
        TO_CHAR(COUNT(DISTINCT(IC.SCHEMA_NAME || IC.TABLE_NAME || IC.INDEX_NAME)))
      FROM
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          INDEX_NAME,
          COLUMN_NAME
        FROM
        ( SELECT
            SCHEMA_NAME,
            TABLE_NAME,
            INDEX_NAME,
            COLUMN_NAME,
            CONSTRAINT,
            COUNT(*) OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME, INDEX_NAME) NUM_COLUMNS
          FROM
            TEMP_INDEX_COLUMNS
        )
        WHERE
          NUM_COLUMNS = 1 OR ( CONSTRAINT IN ('PRIMARY KEY', 'UNIQUE', 'NOT NULL UNIQUE' ) )
      ) IC,
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          COLUMN_NAME
        FROM
          TEMP_M_CS_ALL_COLUMNS,
        ( SELECT
            SUBSTR(VALUE, 1, LOCATE(VALUE, '.', 1, 2) - 1) VERSION,
            TO_NUMBER(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) ||
            MAP(LOCATE(VALUE, '.', 1, 4), 0, '', '.' || SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 3) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) - 1 ))) REVISION 
          FROM 
            M_SYSTEM_OVERVIEW 
          WHERE 
            SECTION = 'System' AND 
            NAME = 'Version' 
        )
        WHERE
          COUNT > 1000000 AND
          ( COMPRESSION_TYPE = 'PREFIXED' OR
            COMPRESSION_TYPE = 'SPARSE' AND VERSION = '1.00' AND TO_NUMBER(REVISION) <= 122.02
          )
      ) C
      WHERE
        IC.SCHEMA_NAME = C.SCHEMA_NAME AND
        IC.TABLE_NAME = C.TABLE_NAME AND
        IC.COLUMN_NAME = C.COLUMN_NAME AND NOT EXISTS
        ( SELECT
            *
          FROM
            INDEXES IR,
            TEMP_INDEX_COLUMNS ICR
          WHERE
            IR.SCHEMA_NAME = ICR.SCHEMA_NAME AND
            IR.TABLE_NAME = ICR.TABLE_NAME AND
            IR.INDEX_NAME = ICR.INDEX_NAME AND
            IR.INDEX_TYPE = 'FULLTEXT' AND
            C.SCHEMA_NAME = ICR.SCHEMA_NAME AND
            C.TABLE_NAME = ICR.TABLE_NAME AND
            C.COLUMN_NAME = ICR.COLUMN_NAME
        )
    )
    UNION ALL
    ( SELECT
        'MISSING_INVERTED_INDEXES',
        '',
        TO_VARCHAR(COUNT(DISTINCT(C.SCHEMA_NAME || C.TABLE_NAME || C.COLUMN_NAME)))
      FROM
        TEMP_M_CS_ALL_COLUMNS C,
        ( SELECT IC.*, COUNT(*) OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME, INDEX_NAME) NUM_COLUMNS FROM TEMP_INDEX_COLUMNS IC ) IC
      WHERE
        C.SCHEMA_NAME = IC.SCHEMA_NAME AND
        C.TABLE_NAME = IC.TABLE_NAME AND
        C.COLUMN_NAME = IC.COLUMN_NAME AND
        C.LOADED = 'TRUE' AND
        C.INDEX_TYPE = 'NONE' AND
        C.COUNT > 100000 AND
        ( IC.CONSTRAINT IN ('PRIMARY KEY', 'UNIQUE', 'NOT NULL UNIQUE' ) OR
          IC.NUM_COLUMNS = 1
        ) AND NOT EXISTS
        ( SELECT
            *
          FROM
            TEMP_INDEXES IR,
            TEMP_INDEX_COLUMNS ICR
          WHERE
            IR.SCHEMA_NAME = ICR.SCHEMA_NAME AND
            IR.TABLE_NAME = ICR.TABLE_NAME AND
            IR.INDEX_NAME = ICR.INDEX_NAME AND
            IR.INDEX_TYPE LIKE 'FULLTEXT%' AND
            C.SCHEMA_NAME = ICR.SCHEMA_NAME AND
            C.TABLE_NAME = ICR.TABLE_NAME AND
            C.COLUMN_NAME = ICR.COLUMN_NAME
        )
    )
    UNION ALL
    ( SELECT
        'LARGE_COLUMNS_NOT_COMPRESSED',
        '',
        TO_VARCHAR(COUNT(DISTINCT(C.SCHEMA_NAME || C.TABLE_NAME || C.COLUMN_NAME)))
      FROM
        TEMP_M_CS_ALL_COLUMNS C,
        TEMP_TABLE_COLUMNS TC
      WHERE
        C.SCHEMA_NAME = TC.SCHEMA_NAME AND
        C.TABLE_NAME = TC.TABLE_NAME AND
        C.COLUMN_NAME = TC.COLUMN_NAME AND
        C.COUNT > 10000000 AND
        C.DISTINCT_COUNT <= COUNT * 0.02 AND
        C.COMPRESSION_TYPE = 'DEFAULT' AND
        TC.GENERATION_TYPE IS NULL AND
        C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL >= 500 * 1024 * 1024
    )
    UNION ALL
    ( SELECT
        'MAX_CURR_SERV_ALL_LIMIT_USED',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAX(MAP(EFFECTIVE_ALLOCATION_LIMIT, 0, 0, -1, 0, TOTAL_MEMORY_USED_SIZE / EFFECTIVE_ALLOCATION_LIMIT * 100))), 10, 0))
      FROM
        M_SERVICE_MEMORY
      WHERE
        SERVICE_NAME = 'indexserver'           /* wrong TOTAL_MEMORY_USED_SIZE values with persistent memory possible */
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'MAX_HIST_SERV_ALL_LIMIT_USED',
        IFNULL(HOST, ''),
        IFNULL(TO_VARCHAR(HOURS), '999999')
      FROM
        DUMMY BI LEFT OUTER JOIN
      ( SELECT
          HOST,
          TO_DECIMAL(ROUND(MIN(SECONDS_BETWEEN(SERVER_TIMESTAMP, CURRENT_TIMESTAMP) / 3600)), 10, 0) HOURS
        FROM
          _SYS_STATISTICS.HOST_SERVICE_MEMORY
        WHERE
          EFFECTIVE_ALLOCATION_LIMIT > 0 AND
          TOTAL_MEMORY_USED_SIZE > EFFECTIVE_ALLOCATION_LIMIT * 0.8
        GROUP BY
          HOST
      ) R ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'AUDIT_LOG_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(SUM(DISK_SIZE) / 1024 / 1024 / 1024, 10, 2))
      FROM
        TEMP_M_TABLE_PERSISTENCE_STATISTICS
      WHERE
        SCHEMA_NAME = '_SYS_AUDIT' AND
        TABLE_NAME = 'CS_AUDIT_LOG_'
    )
    UNION ALL
    ( SELECT
        'SWAP_OUT_MEDIUMTERM',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(DAYS, 0, 0, SWAP_OUT_GB / DAYS), 10, 2))
      FROM
      ( SELECT
          L.HOST,
          SUM(L.SWAP_OUT) / 1024 / 1024 / 1024 SWAP_OUT_GB,
          LEAST(DAYS_BETWEEN(MIN(L.TIME), CURRENT_TIMESTAMP), BI.MIDTERM_DAYS) DAYS
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_LOAD_HISTORY_HOST L
        WHERE
          L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS)
        GROUP BY
          L.HOST,
          BI.MIDTERM_DAYS
      )
    )
    UNION ALL
    ( SELECT
        'LARGE_SWAP_SPACE',
        HOST,
        TO_VARCHAR(TO_DECIMAL(VALUE / 1024 / 1024 / 1024, 10, 2))
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'mem_swap' 
    )
    UNION ALL
    ( SELECT
        'TEMPORARY_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_TEMPORARY_TABLES 
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        IFNULL(T.TABLE_NAME || MAP(T.PART_ID, 0, '', CHAR(32) || '(' || T.PART_ID || ')') || CHAR(32) || '(' || 
          TO_DECIMAL(MAP(C.NAME, 'MANY_RECORDS_HISTORY', T.RAW_RECORD_COUNT_IN_HISTORY_MAIN + T.RAW_RECORD_COUNT_IN_HISTORY_DELTA,
              'MANY_RECORDS_UDIV', T.MAX_UDIV, T.RECORD_COUNT) / 1000000000, 10, 2) || CHAR(32) || 'billion)', 'none')
      FROM
      ( SELECT 'MANY_RECORDS' NAME            FROM DUMMY UNION ALL
        SELECT 'SID_TABLES_WITH_MANY_RECORDS' FROM DUMMY UNION ALL
        SELECT 'MANY_RECORDS_HISTORY'         FROM DUMMY UNION ALL
        SELECT 'MANY_RECORDS_UDIV'            FROM DUMMY
      ) C LEFT OUTER JOIN
        TEMP_M_CS_TABLES T ON
        ( C.NAME = 'MANY_RECORDS' AND T.RECORD_COUNT > 1500000000 AND T.TABLE_NAME NOT LIKE '/B%/S%' ) OR
        ( C.NAME = 'SID_TABLES_WITH_MANY_RECORDS' AND T.RECORD_COUNT > 1500000000 AND T.TABLE_NAME LIKE '/B%/S%' ) OR
        ( C.NAME = 'MANY_RECORDS_HISTORY' AND T.RAW_RECORD_COUNT_IN_HISTORY_MAIN + T.RAW_RECORD_COUNT_IN_HISTORY_DELTA > 1500000000 ) OR
        ( C.NAME = 'MANY_RECORDS_UDIV' AND T.MAX_UDIV > 1500000000 AND T.RECORD_COUNT < 1500000000 )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        TO_VARCHAR(MAP(MAX(T.TABLE_NAME), NULL, 0, COUNT(*)))
      FROM
      ( SELECT 'NUM_PARTITIONED_SID_TABLES' NAME FROM DUMMY UNION ALL
        SELECT 'NUM_PART_SPECIAL_TABLES'         FROM DUMMY
      ) C LEFT OUTER JOIN
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          SUM(RECORD_COUNT) RECORD_COUNT
        FROM
          TEMP_M_CS_TABLES
        WHERE
          TABLE_NAME LIKE '/B%/%'
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          COUNT(*) > 1
      ) T ON
      ( C.NAME = 'NUM_PARTITIONED_SID_TABLES' AND T.TABLE_NAME LIKE '/B%/S%' ) OR
      ( C.NAME = 'NUM_PART_SPECIAL_TABLES' AND T.RECORD_COUNT <= 1500000000 AND T.TABLE_NAME NOT LIKE '/BA1/%' AND
        ( TABLE_NAME LIKE '/B%/H%' OR TABLE_NAME LIKE '/B%/I%' OR TABLE_NAME LIKE '/B%/J%' OR
          TABLE_NAME LIKE '/B%/K%' OR TABLE_NAME LIKE '/B%/P%' OR TABLE_NAME LIKE '/B%/Q%' OR
          TABLE_NAME LIKE '/B%/T%' OR TABLE_NAME LIKE '/B%/X%' OR TABLE_NAME LIKE '/B%/Y%' 
        )
      )
      GROUP BY
        C.NAME
    )
    UNION ALL
    ( SELECT
        'TABLES_WRONG_SERVICE',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_TABLES T,
        M_SERVICES S,
      ( SELECT
          MAP(COUNT(*), 0, 'No', 'Yes') IS_SYSTEMDB
        FROM
          M_DATABASE D1,
          M_DATABASES D2
        WHERE
          D1.DATABASE_NAME = D2.DATABASE_NAME AND
          D2.DESCRIPTION LIKE 'SystemDB%'
      ) M
      WHERE
        S.PORT = T.PORT AND
        S.HOST = T.HOST AND
        ( M.IS_SYSTEMDB = 'No' AND S.SERVICE_NAME != 'indexserver' OR
          M.IS_SYSTEMDB = 'Yes' AND S.SERVICE_NAME NOT IN ( 'indexserver', 'nameserver')
        )
    )
    UNION ALL
    ( SELECT
        'TABLES_WITH_EMPTY_LOCATION',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TABLE_LOCATIONS
      WHERE
        LOCATION IS NULL OR LOCATION = ''
    )
    UNION ALL
    ( SELECT
        'UNKNOWN_HARDWARE',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY IN ( 'hw_model', 'hw_manufacturer' ) AND
        UPPER(VALUE) = '<UNKNOWN>'
    )
    UNION ALL
    ( SELECT
        'OS_RELEASE',
        HOST,
        CASE
          WHEN OS_PPMS_NAME LIKE 'LINUX_PPC64%' THEN
            CASE 
              WHEN OS_NAME = 'SLES 11.4' AND VERSION = 1.00 AND REVISION >= 110                                                                            THEN 'yes' 
              WHEN OS_NAME = 'SLES 12.1' AND VERSION = 2.00 AND REVISION BETWEEN  0 AND 39                                                                 THEN 'yes' 
              WHEN OS_NAME = 'SLES 12.2' AND VERSION = 2.00 AND REVISION BETWEEN 10 AND 39                                                                 THEN 'yes' 
              WHEN OS_NAME = 'SLES 12.3' AND VERSION = 2.00 AND REVISION >= 23                                                                             THEN 'yes' 
              WHEN OS_NAME = 'SLES 12.4' AND VERSION = 2.00 AND REVISION BETWEEN 35 AND 59.99                                                              THEN 'yes' 
              WHEN OS_NAME = 'SLES 12.5' AND VERSION = 2.00 AND REVISION BETWEEN 45 AND 69.99                                                              THEN 'yes' 
              WHEN OS_NAME = 'SLES 15'   AND VERSION = 2.00 AND REVISION >= 34                                                                             THEN 'yes' 
              WHEN OS_NAME = 'SLES 15.0' AND VERSION = 2.00 AND REVISION BETWEEN 34 AND 59.99                                                              THEN 'yes' 
              WHEN OS_NAME = 'SLES 15.1' AND VERSION = 2.00 AND REVISION BETWEEN 44 AND 69.99                                                              THEN 'yes' 
              WHEN OS_NAME = 'SLES 15.2' AND VERSION = 2.00 AND REVISION BETWEEN 48.01 AND 69.99                                                           THEN 'yes' 
              WHEN OS_NAME = 'SLES 15.3' AND VERSION = 2.00 AND REVISION >= 55                                                                             THEN 'yes'
              WHEN OS_NAME = 'SLES 15.4' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.02 AND 59.99 OR REVISION >= 63 )                                     THEN 'yes'
              WHEN OS_NAME = 'SLES 15.5' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.08 AND 59.99 OR REVISION >= 67.01 )                                  THEN 'yes'
              WHEN OS_NAME = 'SLES 15.6' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.3'  AND ( VERSION = 1.00 AND REVISION >= 120 OR VERSION = 2.00 AND REVISION >= 21 )                                   THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.4'  AND ( VERSION = 1.00 AND REVISION >= 122.14 OR VERSION = 2.00 AND REVISION BETWEEN 23 AND 49 )                    THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.5'  AND ( VERSION = 1.00 AND REVISION >= 122.19 OR VERSION = 2.00 AND REVISION BETWEEN 32 AND 39 )                    THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.6'  AND ( VERSION = 1.00 AND REVISION >= 122.23 OR VERSION = 2.00 AND REVISION BETWEEN 36 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.7'  AND ( VERSION = 1.00 AND REVISION >= 122.30 OR VERSION = 2.00 AND REVISION BETWEEN 48 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.9'  AND VERSION = 2.00 AND REVISION BETWEEN 54 AND 59.99                                                              THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.0'  AND VERSION = 2.00 AND REVISION BETWEEN 45 AND 49                                                                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.1'  AND VERSION = 2.00 AND REVISION BETWEEN 45 AND 69.99                                                              THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.2'  AND VERSION = 2.00 AND ( REVISION BETWEEN 48.02 AND 49.99 OR REVISION BETWEEN 52 AND 69.99 )                      THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.4'  AND VERSION = 2.00 AND REVISION >= 55                                                                             THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.6'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.02 AND 59.99 OR REVISION >= 63 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.8'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.08 AND 59.99 OR REVISION >= 67.01 )                                  THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.10' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.0'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.08 AND 59.99 OR REVISION BETWEEN 67.01 AND 69.99 )                   THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.2'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.09 AND 59.99 OR REVISION BETWEEN 67.02 AND 69.99 OR REVISION >= 72 ) THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.4'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
            END
          ELSE
            CASE 
              WHEN OS_NAME = 'SLES 11.1' AND VERSION = 1.00 AND REVISION <  110                                                                            THEN 'yes'
              WHEN OS_NAME = 'SLES 11.2' AND VERSION = 1.00 AND REVISION <  120                                                                            THEN 'yes'
              WHEN OS_NAME = 'SLES 11.3' AND VERSION = 1.00                                                                                                THEN 'yes'
              WHEN OS_NAME = 'SLES 11.4' AND VERSION = 1.00 AND REVISION >= 100                                                                            THEN 'yes'
              WHEN OS_NAME = 'SLES 12.0' AND VERSION = 1.00 AND REVISION >= 100                                                                            THEN 'yes'
              WHEN OS_NAME = 'SLES 12.1' AND ( VERSION = 1.00 AND REVISION >= 120 OR VERSION = 2.00 AND REVISION BETWEEN  0 AND 39 )                       THEN 'yes'
              WHEN OS_NAME = 'SLES 12.2' AND ( VERSION = 1.00 AND REVISION >= 120 OR VERSION = 2.00 AND REVISION BETWEEN 10 AND 39 )                       THEN 'yes'
              WHEN OS_NAME = 'SLES 12.3' AND ( VERSION = 1.00 AND REVISION >= 122.15 OR VERSION = 2.00 AND REVISION BETWEEN 23 AND 49 )                    THEN 'yes'
              WHEN OS_NAME = 'SLES 12.4' AND ( VERSION = 1.00 AND REVISION >= 122.22 OR VERSION = 2.00 AND REVISION BETWEEN 35 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'SLES 12.5' AND ( VERSION = 1.00 AND REVISION >= 122.29 OR VERSION = 2.00 AND REVISION BETWEEN 45 AND 69.99 )                 THEN 'yes'
              WHEN OS_NAME = 'SLES 15'   AND ( VERSION = 1.00 AND REVISION >= 122.23 OR VERSION = 2.00 AND REVISION >= 34 )                                THEN 'yes'
              WHEN OS_NAME = 'SLES 15.0' AND ( VERSION = 1.00 AND REVISION >= 122.23 OR VERSION = 2.00 AND REVISION BETWEEN 34 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'SLES 15.1' AND ( VERSION = 1.00 AND REVISION >= 122.27 OR VERSION = 2.00 AND REVISION BETWEEN 44 AND 69.99 )                 THEN 'yes'
              WHEN OS_NAME = 'SLES 15.2' AND ( VERSION = 1.00 AND REVISION >= 122.31 OR VERSION = 2.00 AND REVISION BETWEEN 48.01 AND 69.99 )              THEN 'yes'
              WHEN OS_NAME = 'SLES 15.3' AND VERSION = 2.00 AND REVISION >= 55                                                                             THEN 'yes'
              WHEN OS_NAME = 'SLES 15.4' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.02 AND 59.99 OR REVISION >= 63 )                                     THEN 'yes'
              WHEN OS_NAME = 'SLES 15.5' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.08 AND 59.99 OR REVISION >= 67.01 )                                  THEN 'yes'
              WHEN OS_NAME = 'SLES 15.6' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 6.5'  AND VERSION = 1.00 AND REVISION <  120                                                                            THEN 'yes'
              WHEN OS_NAME = 'RHEL 6.6'  AND VERSION = 1.00 AND REVISION <  120                                                                            THEN 'yes'
              WHEN OS_NAME = 'RHEL 6.7'  AND VERSION = 1.00 AND REVISION >= 110                                                                            THEN 'yes'
              WHEN OS_NAME = 'RHEL 6.10' AND VERSION = 1.00 AND REVISION >= 122.23                                                                         THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.2'  AND ( VERSION = 1.00 AND REVISION >= 120 OR VERSION = 2.00 AND REVISION BETWEEN  0 AND 39 )                       THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.3'  AND ( VERSION = 1.00 AND REVISION >= 120 OR VERSION = 2.00 AND REVISION BETWEEN 21 AND 39 )                       THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.4'  AND ( VERSION = 1.00 AND REVISION >= 122.14 OR VERSION = 2.00 AND REVISION BETWEEN 23 AND 49 )                    THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.5'  AND ( VERSION = 1.00 AND REVISION >= 122.19 OR VERSION = 2.00 AND REVISION BETWEEN 32 AND 39 )                    THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.6'  AND ( VERSION = 1.00 AND REVISION >= 122.23 OR VERSION = 2.00 AND REVISION BETWEEN 36 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.7'  AND ( VERSION = 1.00 AND REVISION >= 122.30 OR VERSION = 2.00 AND REVISION BETWEEN 48 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 7.9'  AND ( VERSION = 1.00 AND REVISION >= 122.33 OR VERSION = 2.00 AND REVISION BETWEEN 54 AND 59.99 )                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.0'  AND VERSION = 2.00 AND REVISION BETWEEN 40 AND 49                                                                 THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.1'  AND VERSION = 2.00 AND REVISION BETWEEN 45 AND 69.99                                                              THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.2'  AND VERSION = 2.00 AND ( REVISION BETWEEN 48.02 AND 49.99 OR REVISION BETWEEN 52 AND 69.99 )                      THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.4'  AND VERSION = 2.00 AND REVISION >= 55                                                                             THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.6'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.02 AND 59.99 OR REVISION >= 63 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.8'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.08 AND 59.99 OR REVISION >= 67.01 )                                  THEN 'yes'
              WHEN OS_NAME = 'RHEL 8.10' AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.0'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.04 AND 59.99 OR REVISION >= 63 )                                     THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.2'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.09 AND 59.99 OR REVISION BETWEEN 67.02 AND 69.99 OR REVISION >= 72 ) THEN 'yes'
              WHEN OS_NAME = 'RHEL 9.4'  AND VERSION = 2.00 AND ( REVISION BETWEEN 59.12 AND 59.99 OR REVISION >= 77 )                                     THEN 'yes'
              ELSE 'no (' || OS_NAME || ')'
            END
        END
      FROM
      ( SELECT
          HOST,
          RTRIM(OS_TYPE || CHAR(32) || OS_VERSION || '.' || OS_SERVICE_PACK, '.') OS_NAME,
          /* RTRIM required because ServicePackVersion sometimes empty because it is already part of Version */
          OS_PPMS_NAME
        FROM
        ( SELECT
            HOST,
            MAX(MAP(PROPERTY_NAME, 'PPMSRelease',        SUBSTR(PROPERTY_VALUE, 1, 4), '')) OS_TYPE,
            MAX(MAP(PROPERTY_NAME, 'Version',            PROPERTY_VALUE,               '')) OS_VERSION,
            MAX(MAP(PROPERTY_NAME, 'ServicePackVersion', PROPERTY_VALUE,               '')) OS_SERVICE_PACK,
            MAX(MAP(PROPERTY_NAME, 'PPMSName',           PROPERTY_VALUE,               '')) OS_PPMS_NAME
          FROM
            M_HOST_AGENT_INFORMATION
          WHERE
            CLASS_NAME = 'SAP_ITSAMOperatingSystem'
          GROUP BY
            HOST
        )
      ),
/* previous approach based on os_cpe_name
      ( SELECT
          HOST,
          UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(MAX(MAP(KEY, 'os_cpe_name', VALUE, '')), 'cpe:/o:', ''), 'suse', ''), 
            ':sp', '.'), 'redhat:enterprise_linux', 'RHEL '), 'sles', 'sles '), '_sap:', ''), ':GA', ''), 'server', ''), ':', '')) OS_NAME,
          MAX(MAP(KEY, 'os_ppms_name', VALUE)) OS_PPMS_NAME
        FROM
          M_HOST_INFORMATION
        GROUP BY
          HOST
      ),
*/
      ( SELECT
          TO_NUMBER(SUBSTR(VALUE, 1, 4)) VERSION,
          TO_NUMBER(LTRIM(CASE
            WHEN LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) = 3 THEN
              SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 2) - 1)
            ELSE 
              SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) || '.00'
          END, '0')) REVISION
        FROM 
          M_SYSTEM_OVERVIEW 
        WHERE 
          SECTION = 'System' AND 
          NAME = 'Version' 
      )
    )
    UNION ALL
    ( SELECT
        'OS_KERNEL_BIGMEM',
        IFNULL(HOST, ''),
        MAP(HOST, NULL, 'no', 'yes')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          HOST
        FROM
        ( SELECT
            HOST,
            MAX(MAP(KEY, 'os_name', VALUE)) OS_NAME,
            MAX(MAP(KEY, 'os_ppms_name', VALUE)) OS_PPMS_NAME,
            MAX(MAP(KEY, 'os_kernel_version', VALUE)) OS_KERNEL_VERSION
          FROM
            M_HOST_INFORMATION
          GROUP BY
            HOST
        )
        WHERE
          OS_NAME LIKE 'SUSE Linux Enterprise Server%11%' AND
          OS_PPMS_NAME LIKE 'LINUX_PPC64%' AND
          OS_KERNEL_VERSION NOT LIKE '%bigmem%'
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT /* Needs to be able to extract the first up to three numbers after the first "-" (e.g. 0, 47, 71) from versions like 
                3.0.101-0.47.71.7930.0.PTF-default, 3.0.101-0.47-bigsmp or 3.0.101-0.47.71-default or 
                3.0.101-63-default / 3.0.101-65.1.9526.1.PTF-default (SLES 11.4, 12.1) / 3.12.62-60.62-default,
                3.10.0-327.el7.x86_64, 3.10.0-327.44.2.el7.x86_64 (same also with "el6")
                ".1" is usually redundant, so 88.1 is identical to 88  */
        'OS_KERNEL_VERSION',
        HOST,
        CASE 
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%11%2' AND NFS_USED = 'X' AND ( KV_2 < 7   OR KV_2 = 7   AND KV_3 < 23 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 0.7.23)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%11%3' AND NFS_USED = 'X' AND ( KV_2 < 40 )                                                                       THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 0.40)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%11%3' AND XFS_USED = 'X' AND ( KV_2 < 47  OR KV_2 = 47  AND KV_3 < 71 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 0.47.71)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%11%4'                    AND ( KV_1 < 108 OR KV_1 = 108 AND KV_2 < 7  )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 0.108.7)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%11%4'                    AND ( KV_1 = 108 AND KV_2 = 95 AND KV_3 = 2 )                                           THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12'                      AND ( KV_1 < 52  OR KV_1 = 52  AND KV_2 < 72 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 52.72)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%1'                    AND ( KV_1 < 60  OR KV_1 = 60  AND KV_2 < 64 OR KV_1 = 60 AND KV_2 = 64 AND KV_3 < 40 ) THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 60.64.40)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%1'                    AND ( KV_1 = 60 AND KV_2 = 64 AND KV_3 = 115 )                                          THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%2'                    AND ( KV_1 < 92  OR KV_1 = 92  AND KV_2 < 70 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 92.70)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%2'                    AND ( KV_1 = 92  AND KV_2 = 114 )                                                       THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%3'                    AND ( KV_1 < 94  OR KV_1 = 94  AND KV_2 < 17 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 94.17)'
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%3'                    AND ( KV_1 = 94  AND KV_2 = 97 AND KV_3 = 1 )                                           THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%4'                    AND ( KV_1 = 95  AND KV_2 = 19 AND KV_3 = 1 )                                           THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%12%5'                    AND ( KV_1 = 122  AND KV_2 = 212 )                                                      THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2116157 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%15'                      AND ( KV_1 = 150 AND KV_2 = 22 AND KV_3 = 1 )                                           THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%15%1'                    AND ( KV_1 = 197 AND KV_2 = 4  AND KV_3 = 1 )                                           THEN 'no' || CHAR(32) || '(' || KV || ')' /* SAP Note 2812427 */
          WHEN OS_NAME LIKE 'SUSE Linux Enterprise Server%15%2'                    AND ( KV_1 < 24  OR KV_1 = 24  AND KV_2 < 24 )                                          THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 24.24.1)'
          WHEN OS_NAME LIKE 'Red Hat Enterprise Linux %6.10%'                      AND ( KV_1 < 754  OR KV_1 = 754 AND KV_2 < 3 OR KV_1 = 754 AND KV_2 = 3 AND KV_3 < 5 )  THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 754.3.5)'
          WHEN OS_NAME LIKE 'Red Hat Enterprise Linux %7.6%'                       AND ( KV_1 < 957  OR KV_1 = 957 AND KV_2 < 1 OR KV_1 = 957 AND KV_2 = 1 AND KV_3 < 3 )  THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 754.3.5)'
          WHEN OS_NAME LIKE 'Red Hat Enterprise Linux %8.2%'                       AND ( KV_1 < 193  OR KV_1 = 193 AND KV_2 < 40 )                                         THEN 'no' || CHAR(32) || '(' || KV || ' instead of >= 193.40.1)'
          ELSE 'yes'
        END 
      FROM
      ( SELECT
          HOST,
          OS_NAME,
          OS_PPMS_NAME,
          TO_NUMBER(CASE 
            WHEN LOCATE(KV, '.', 1, 1) = 0 THEN KV 
            ELSE SUBSTR(KV, 1, LOCATE(KV, '.', 1, 1) - 1)
          END )  KV_1,
          TO_NUMBER(CASE 
            WHEN LOCATE(KV, '.', 1, 1) = 0 THEN 1 
            WHEN LOCATE(KV, '.', 1, 2) = 0 THEN SUBSTR(KV, LOCATE(KV, '.', 1, 1) + 1)
            ELSE SUBSTR(KV, LOCATE(KV, '.', 1, 1) + 1, LOCATE(KV, '.', 1, 2) - LOCATE(KV, '.', 1, 1) - 1)
          END ) KV_2,
          TO_NUMBER(CASE 
            WHEN LOCATE(KV, '.', 1, 2) = 0 THEN 1 
            WHEN LOCATE(KV, '.', 1, 3) = 0 THEN SUBSTR(KV, LOCATE(KV, '.', 1, 2) + 1)
            ELSE SUBSTR(KV, LOCATE(KV, '.', 1, 2) + 1, LOCATE(KV, '.', 1, 3) - LOCATE(KV, '.', 1, 2) - 1)
          END ) KV_3,
          KV_ORIG KV,
          NFS_USED,
          XFS_USED
        FROM
        ( SELECT
            O.HOST,
            O.OS_NAME,
            O.OS_PPMS_NAME,
            CASE
              WHEN KV LIKE '%.el_.%' THEN
                SUBSTR(KV, LOCATE(KV, '-', 1, 1) + 1, LEAST(LOCATE(KV, '.el', 1, 1), MAP(LOCATE(KV, '.', 1, 5), 0, 999, LOCATE(KV, '.', 1, 5))) - LOCATE(KV, '-', 1, 1) - 1)
              ELSE
                SUBSTR(KV, LOCATE(KV, '-', 1, 1) + 1, LEAST(MAP(LOCATE(KV, '-', 1, 2), 0, 9999, LOCATE(KV, '-', 1, 2)), MAP(LOCATE(KV, '.', 1, 5), 0, 999, LOCATE(KV, '.', 1, 5))) - LOCATE(KV, '-', 1, 1) - 1)
            END KV,
            O.KV KV_ORIG,
            D.NFS_USED,
            D.XFS_USED
          FROM
          ( SELECT
              HOST,
              MAX(MAP(KEY, 'os_name', VALUE)) OS_NAME,
              MAX(MAP(KEY, 'os_ppms_name', VALUE)) OS_PPMS_NAME,
              MAX(MAP(KEY, 'os_kernel_version', VALUE)) KV
            FROM
              M_HOST_INFORMATION
            GROUP BY
              HOST
          ) O,
          ( SELECT 
              CASE SUM(MAP(FILESYSTEM_TYPE, 'nfs', 1, 0)) WHEN 0 THEN ' ' ELSE 'X' END NFS_USED,
              CASE SUM(MAP(FILESYSTEM_TYPE, 'xfs', 1, 0)) WHEN 0 THEN ' ' ELSE 'X' END XFS_USED 
            FROM 
              M_DISKS 
          ) D
        )
      )
    )
    UNION ALL
    ( SELECT
        'INCONSISTENT_SECURE_STORE',
        '',
        TO_VARCHAR(MAP(COUNT(*), 0, 'no', 'yes'))
      FROM
        M_SECURESTORE
      WHERE
        IS_CONSISTENT != 'TRUE'
    )
    UNION ALL
    ( SELECT
        'SERVICE_LOG_BACKUPS',
        '',
        TO_VARCHAR(MAX(TO_DECIMAL(LOG_BACKUPS_PER_DAY, 10, 0)))
      FROM
      ( SELECT
          CF.HOST,
          CF.SERVICE_TYPE_NAME,
          COUNT(*) / BI.SHORTTERM_DAYS LOG_BACKUPS_PER_DAY
        FROM
          BASIS_INFO BI,
          TEMP_M_BACKUP_CATALOG C,
          TEMP_M_BACKUP_CATALOG_FILES CF
        WHERE
          C.BACKUP_ID = CF.BACKUP_ID AND
          C.ENTRY_TYPE_NAME = 'log backup' AND
          C.STATE_NAME = 'successful' AND
          C.SYS_START_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS) AND
          CF.SOURCE_TYPE_NAME = 'volume'
        GROUP BY
          CF.HOST,
          CF.SERVICE_TYPE_NAME,
          BI.SHORTTERM_DAYS
      )
    )
    UNION ALL
    ( SELECT
        'OPEN_CONNECTIONS',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(MAX_CONNECTIONS, 0, 0, NUM_CONNECTIONS / MAX_CONNECTIONS * 100), 10, 2))
      FROM
      ( SELECT
          C.HOST,
          C.NUM_CONNECTIONS,
          IFNULL(P.VALUE, 65536) MAX_CONNECTIONS
        FROM
        ( SELECT
            HOST,
            COUNT(*) NUM_CONNECTIONS
          FROM
            TEMP_M_CONNECTIONS
          WHERE
            CONNECTION_TYPE IN ('Local', 'Remote')
          GROUP BY
            HOST
        ) C LEFT OUTER JOIN
        ( SELECT 
            HOST,
            MAX(VALUE) VALUE
          FROM
            M_CONFIGURATION_PARAMETER_VALUES
          WHERE 
            FILE_NAME = 'indexserver.ini' AND
            SECTION = 'session' AND
            KEY = 'maximum_connections'
          GROUP BY
            HOST
        ) P ON
          C.HOST = P.HOST
      )
    )
    UNION ALL
    ( SELECT
        'OPEN_TRANSACTIONS',
        '',
        TO_VARCHAR(MAX(NUM_TRANSACTIONS))
      FROM
      ( SELECT
          COUNT(*) NUM_TRANSACTIONS
        FROM
          TEMP_M_TRANSACTIONS
        GROUP BY
          HOST,
          PORT
      )
    )
    UNION ALL
    ( SELECT
        'SERVER_TIME_VARIATION',
        '',
        TO_VARCHAR(SECONDS_BETWEEN(MIN(SYS_TIMESTAMP), MAX(SYS_TIMESTAMP)))
      FROM
        M_HOST_RESOURCE_UTILIZATION
    )
    UNION ALL
    ( SELECT TOP 10
        'SQL_CACHE_FREQUENT_HASH',
        HOST,
        IFNULL(STATEMENT_HASH || CHAR(32) || '(' || CNT || CHAR(32) || 'entries)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          STATEMENT_HASH,
          COUNT(*) CNT
        FROM
          TEMP_M_SQL_PLAN_CACHE
        WHERE
        ( STATEMENT_HASH IS NOT NULL AND STATEMENT_HASH != '' )
        GROUP BY
          HOST,
          STATEMENT_HASH
        HAVING
          COUNT(*) > 1000
      ) ON
        1 = 1
      ORDER BY
        CNT DESC
    )
    UNION ALL
    ( SELECT
        'INVALID_PROCEDURES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        PROCEDURES
      WHERE
        IS_VALID = 'FALSE'
    )
    UNION ALL
    ( SELECT
        'PARKED_JOBWORKERS',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(MAP(TOTAL_WORKER_COUNT, 0, 0, PARKED_WORKER_COUNT / TOTAL_WORKER_COUNT)), 10, 2))
      FROM
        M_JOBEXECUTORS
    )
    UNION ALL
    ( SELECT
        'QUEUED_JOBS',
        '',
        TO_VARCHAR(MAX(QUEUED_JOBS))
      FROM
      ( SELECT
          SUM(QUEUED_WAITING_JOB_COUNT) QUEUED_JOBS
        FROM
          M_JOBEXECUTORS
        GROUP BY
         HOST
      )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        CASE C.NAME
          WHEN 'TRANSACTIONS_LARGE_UNDO' THEN TO_VARCHAR(TO_DECIMAL(MAX(UNDO_LOG_AMOUNT / 1024 / 1024), 10, 2))
          WHEN 'TRANSACTIONS_LARGE_REDO' THEN TO_VARCHAR(TO_DECIMAL(MAX(REDO_LOG_AMOUNT / 1024 / 1024), 10, 2))
        END
      FROM
      ( SELECT 'TRANSACTIONS_LARGE_UNDO' NAME FROM DUMMY UNION ALL
        SELECT 'TRANSACTIONS_LARGE_REDO' FROM DUMMY
      ) C,
        TEMP_M_TRANSACTIONS T
      GROUP BY
        C.NAME
    )
    UNION ALL
    ( SELECT
        'LONG_RUNNING_JOB',
        '',
        TO_VARCHAR(IFNULL(MAX(GREATEST( 0, SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP))), 0))
      FROM
        M_JOB_PROGRESS
    )
    UNION ALL
    ( SELECT
        'TOPOLOGY_DAEMON_INCONSISTENT',
        S.HOST,
        TO_VARCHAR(SUM(MAP(S.ACTIVE_STATUS, 'NO', 1, 0)))
      FROM
        M_SERVICES D,
        M_SERVICES S
      WHERE
        D.SERVICE_NAME = 'daemon' AND
        D.ACTIVE_STATUS = 'YES' AND
        S.HOST = D.HOST
      GROUP BY
        S.HOST
    )
    UNION ALL
    ( SELECT
        'TOPOLOGY_ROLES_INCONSISTENT',
        '',
        MAP(C.CONF_WORKERS, A.ACT_WORKERS, 'no', 'yes')
      FROM
      ( SELECT COUNT(*) CONF_WORKERS FROM M_LANDSCAPE_HOST_CONFIGURATION WHERE INDEXSERVER_CONFIG_ROLE = 'WORKER' ) C,
      ( SELECT COUNT(*) ACT_WORKERS  FROM M_LANDSCAPE_HOST_CONFIGURATION WHERE INDEXSERVER_ACTUAL_ROLE IN ( 'COORDINATOR', 'MASTER', 'SLAVE', 'WORKER' ) ) A
    )
    UNION ALL
    ( SELECT
        'NOLOGGING_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_TABLES
      WHERE
        IS_LOGGED = 'FALSE'
    )
    UNION ALL
    ( SELECT
        'NO_DELTA_LOG_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_TABLES
      WHERE
        IS_LOG_DELTA = 'FALSE'
    )
    UNION ALL
    ( SELECT
        'NO_DELTA_LOG_TABLES_HIST',
        '',
        TO_VARCHAR(COUNT(DISTINCT(SCHEMA_NAME || TABLE_NAME)))
      FROM
        _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE
      WHERE
        IS_LOG_DELTA = 'FALSE'
    )
    UNION ALL
    ( SELECT
        'ABAP_POOL_CLUSTER_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_TABLES
      WHERE
        TABLE_NAME IN ('CDCLS', 'DOKCLU', 'EDI40', 'KAPOL', 'KOCLU', 'RFBLG' ) AND
        RECORD_COUNT > 0
    )
    UNION ALL
    ( SELECT
        'SR_LOGREPLAY',
        '',
        CASE WHEN R.SR_USED = 'Yes' AND S.OPERATION_MODE = 'delta_datashipping' THEN 'no' ELSE 'yes' END       
      FROM
      ( SELECT
          MAP(COUNT(*), 0, 'No', 'Yes') SR_USED
        FROM
          M_SERVICE_REPLICATION
        WHERE
          REPLICATION_MODE != '' 
      ) R,
      ( SELECT MAX(OPERATION_MODE) OPERATION_MODE FROM M_SYSTEM_REPLICATION ) S
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        TO_VARCHAR(SUM(CASE I.NAME
          WHEN 'TRANS_LOCKS_GLOBAL' THEN 1
          WHEN 'OLD_TRANS_LOCKS'    THEN CASE WHEN R.ACQUIRED_TIME != '' AND SECONDS_BETWEEN(R.ACQUIRED_TIME, CURRENT_TIMESTAMP) >= 86400 THEN 1 ELSE 0 END
        END))
      FROM
      ( SELECT 'TRANS_LOCKS_GLOBAL' NAME FROM DUMMY UNION ALL
        SELECT 'OLD_TRANS_LOCKS' FROM DUMMY
      ) I LEFT OUTER JOIN
      ( SELECT ACQUIRED_TIME FROM M_OBJECT_LOCKS UNION ALL
        SELECT ACQUIRED_TIME FROM M_RECORD_LOCKS WHERE TABLE_NAME LIKE '%'
      ) R ON
        1 = 1
      GROUP BY
        I.NAME
    )
    UNION ALL
    ( SELECT
        'MULTI_COLUMN_HASH_PART',
        '',
        TO_VARCHAR(IFNULL(SUM(MAP(LOCATE(HASH_SPEC, ','), 0, 0, 1)), 0))
      FROM
      ( SELECT 
          TABLE_NAME,
          LEVEL_1_EXPRESSION HASH_SPEC
        FROM 
          TEMP_PARTITIONED_TABLES 
        WHERE 
          LEVEL_1_TYPE = 'HASH' AND
          LEVEL_1_EXPRESSION LIKE '%,%' AND
          ( TABLE_NAME LIKE '/BA1/%' OR
            ( TABLE_NAME NOT LIKE 'RSPM%' AND 
              TABLE_NAME NOT LIKE 'ZBICZ%' AND
              TABLE_NAME NOT LIKE '0BW:BIA%' AND
              TABLE_NAME NOT LIKE '$BPC$HC$%' AND
              TABLE_NAME NOT LIKE '$BPC$TMP%' AND
              TABLE_NAME NOT LIKE '/B%/%' AND
              TABLE_NAME NOT LIKE '/DMF/%' AND
              TABLE_NAME NOT LIKE '/POSDW/%' AND
              TABLE_NAME NOT LIKE '/1B0/%' AND
              TABLE_NAME NOT LIKE '/1DD/%' AND
              SUBSTR(TABLE_NAME, 1, 3) != 'TR_'
            ) 
          )
      )
    )
    UNION ALL
    ( SELECT
        'CONNECTIONS_' || S.STATUS,
        '',
        TO_VARCHAR(SUM(MAP(C.CONNECTION_STATUS, NULL, 0, 1)))
      FROM
      ( SELECT 'CANCEL_REQUESTED' STATUS FROM DUMMY UNION ALL
        SELECT 'QUEUEING' FROM DUMMY UNION ALL
        SELECT 'RECEIVING' FROM DUMMY UNION ALL
        SELECT 'SENDING' FROM DUMMY
      ) S LEFT OUTER JOIN
        TEMP_M_CONNECTIONS C ON
          C.CONNECTION_STATUS LIKE S.STATUS || '%' AND
          C.CREATED_BY != 'Dynamic Range Partitioning'
      GROUP BY
        S.STATUS
    )
    UNION ALL
    ( SELECT
        'TWO_COLUMN_MANDT_INDEXES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT
          IC.SCHEMA_NAME,
          IC.INDEX_NAME,
          SUM(MAP(IC.COLUMN_NAME, 'MANDT', 1, 'MANDANT', 1, 'CLIENT', 1, 'DCLIENT', 1, 0)) NUM_CLIENT_COLUMNS,
          COUNT(*) NUM_COLUMNS
        FROM
          TEMP_INDEX_COLUMNS IC,
          TEMP_M_TABLES T
        WHERE
          IC.SCHEMA_NAME = T.SCHEMA_NAME AND
          IC.TABLE_NAME = T.TABLE_NAME AND
          T.TABLE_TYPE = 'COLUMN' AND
          IFNULL(CONSTRAINT, '') NOT LIKE '%UNIQUE%' AND IFNULL(CONSTRAINT, '') NOT LIKE '%PRIMARY KEY%'
        GROUP BY
          IC.SCHEMA_NAME,
          IC.INDEX_NAME
        HAVING
          MAX(T.RECORD_COUNT) > 1000000
      )
      WHERE
        NUM_CLIENT_COLUMNS > 0 AND
        NUM_COLUMNS = 2
    )
    UNION ALL
    ( SELECT
        'UNSUPPORTED_FILESYSTEMS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_DISKS
      WHERE
        FILESYSTEM_TYPE LIKE 'UNSUPPORTED%'
    )
    UNION ALL
    ( SELECT
        'DPSERVER_ON_WORKER_NODES',
        '', 
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT DISTINCT HOST FROM M_SERVICES WHERE SERVICE_NAME = 'dpserver' ) S1 LEFT OUTER JOIN
      ( SELECT DISTINCT HOST FROM M_SERVICES WHERE SERVICE_NAME = 'indexserver' AND COORDINATOR_TYPE = 'MASTER' ) S2 ON
        S1.HOST = S2.HOST
      WHERE
        S2.HOST IS NULL
    )
    UNION ALL
    ( SELECT
        'TEMPORARY_BW_TABLES_CLASSIC',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_TABLES
      WHERE
        TABLE_NAME LIKE '/BI0/0%'
    )
    UNION ALL
    ( SELECT
        'AGGREGATE_BW_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_TABLES
      WHERE
        ( TABLE_NAME LIKE '/B%/E1%' OR TABLE_NAME LIKE '/B%/F1%' ) AND
        TABLE_NAME NOT LIKE '/BA1/%' AND
        RECORD_COUNT > 1000000
    )
    UNION ALL
    ( SELECT
        'HDBSTUDIO_CONNECTIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SESSION_CONTEXT
      WHERE
        KEY = 'APPLICATION' AND
        VALUE = 'HDBStudio'
    )
    UNION ALL
    ( SELECT
        'OUTDATED_HDBSTUDIO_VERSION',
        '',
        IFNULL(TO_VARCHAR(SUM( CASE
          WHEN D.VERSION = '2' AND D.SUBVERSION = '06' AND SC2.VALUE < '2.3.62' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '05' AND SC2.VALUE < '2.3.53' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '04' AND SC2.VALUE < '2.3.43' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '03' AND SC2.VALUE < '2.3.35' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '02' AND SC2.VALUE < '2.3.27' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '01' AND SC2.VALUE < '2.3.21' THEN 1
          WHEN D.VERSION = '2' AND D.SUBVERSION = '00' AND SC2.VALUE < '2.3.13' THEN 1
          WHEN D.VERSION = '1' AND D.SUBVERSION = '12' AND SC2.VALUE < '2.3'    THEN 1
          WHEN D.VERSION = '1' AND D.SUBVERSION = '11' AND SC2.VALUE < '2.2'    THEN 1
          WHEN D.VERSION = '1' AND D.SUBVERSION = '10' AND SC2.VALUE < '2.1'    THEN 1
          WHEN D.VERSION = '1' AND D.SUBVERSION = '90' AND SC2.VALUE < '2.0'    THEN 1
          ELSE 0 END )), '0')
      FROM
        ( SELECT SUBSTR(VERSION, 1, 1) VERSION, SUBSTR(VERSION, 6, 2) SUBVERSION FROM M_DATABASE ) D,
        M_SESSION_CONTEXT SC1,
        M_SESSION_CONTEXT SC2
      WHERE
        SC1.HOST = SC2.HOST AND
        SC1.PORT = SC2.PORT AND
        SC1.CONNECTION_ID = SC2.CONNECTION_ID AND
        SC1.KEY = 'APPLICATION' AND
        SC1.VALUE = 'HDBStudio' AND
        SC2.KEY = 'APPLICATIONVERSION' 
    )
    UNION ALL
    ( SELECT
        'SHADOW_PAGE_SIZE',
        HOST, 
        TO_VARCHAR(TO_DECIMAL(MAX(SIZE_GB), 10, 2))
      FROM
      ( SELECT
          D.HOST,
          SUM(D.PAGE_SIZE * D.SHADOW_BLOCK_COUNT) / 1024 / 1024 / 1024 SIZE_GB
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_DATA_VOLUME_PAGE_STATISTICS D
        WHERE
          SECONDS_BETWEEN(D.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        GROUP BY
          D.HOST,
          D.SERVER_TIMESTAMP
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'DATASHIPPING_LOGRETENTION',
        '',
        CASE WHEN OPERATION_MODE = 'delta_datashipping' AND LOG_RETENTION = 'on' THEN 'yes' ELSE 'no' END
      FROM
      ( SELECT MAX(OPERATION_MODE) OPERATION_MODE FROM M_SYSTEM_REPLICATION ) R,
      ( SELECT
          MAX(MAP(KEY, 'enable_log_retention', VALUE)) LOG_RETENTION
        FROM
        ( SELECT
            KEY,
            MAX(VALUE) VALUE
          FROM
            M_CONFIGURATION_PARAMETER_VALUES
          WHERE 
            FILE_NAME = 'global.ini' AND
            SECTION = 'system_replication' AND
            KEY = 'enable_log_retention'
          GROUP BY
            KEY
        )
      )
    )
    UNION ALL
    ( SELECT
        'REPLICATION_SAVEPOINT_DELAY',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(SECONDS_BETWEEN(R.SHIPPED_SAVEPOINT_START_TIME, CURRENT_TIMESTAMP) / 3600), 10, 2))
      FROM
        M_SERVICE_REPLICATION R,
        M_SYSTEM_REPLICATION S
      WHERE
        R.SITE_ID = S.SITE_ID AND
        S.OPERATION_MODE = 'delta_datashipping'
    )
    UNION ALL
    ( SELECT
        'HOST_NAME_RESOLUTION',
        '',
        TO_CHAR(COUNT(*))
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE
        SECTION = 'internal_hostname_resolution' AND
        KEY NOT LIKE '%.%.%.%' AND
        KEY != ''
    )
    UNION ALL
    ( SELECT /* Intel: V3 - Haswell, V4 - Broadwell, V5 / Platinum / Gold / Silver - Skylake, V6 - Kaby Lake */
        'WRONG_CPU_TYPE',
        '',
        TO_VARCHAR(SUM(CASE
          WHEN HW_MODEL LIKE '%GOOGLE%' THEN 0
          WHEN OS_PPMS_NAME = 'LINUX_X86_64' AND CPU_MODEL NOT LIKE '% V3 @%' AND CPU_MODEL NOT LIKE '%HASWELL%' AND CPU_MODEL NOT LIKE '%BROADWELL%' AND
            CPU_MODEL NOT LIKE '% V4 @%' AND CPU_MODEL NOT LIKE '%PLATINUM%' AND CPU_MODEL NOT LIKE '%GOLD%' AND CPU_MODEL NOT LIKE '%SILVER%' AND 
            CPU_MODEL NOT LIKE '%SKY%LAKE%' AND CPU_MODEL NOT LIKE '% V5 @%' AND CPU_MODEL NOT LIKE '% V6 @%' AND CPU_MODEL NOT LIKE '%CASCADE%LAKE%' AND 
            CPU_MODEL NOT LIKE '%ICELAKE%' THEN 1
          WHEN OS_PPMS_NAME LIKE 'LINUX_PPC64%' AND CPU_MODEL NOT LIKE 'POWER8%' AND CPU_MODEL NOT LIKE 'POWER9%' AND CPU_MODEL NOT LIKE 'POWER10%' THEN 1
          ELSE 0
        END))
      FROM
      ( SELECT
          HOST,
          MAX(MAP(KEY, 'cpu_model', UPPER(VALUE))) CPU_MODEL,
          MAX(MAP(KEY, 'os_ppms_name', UPPER(VALUE))) OS_PPMS_NAME,
          MAX(MAP(KEY, 'hw_model', UPPER(VALUE))) HW_MODEL
        FROM
          M_HOST_INFORMATION
        GROUP BY
          HOST
      )
    )
    UNION ALL
    ( SELECT
        'INVERTED_HASH_ON_BW_TABLE',
        '',
        TO_VARCHAR(COUNT(DISTINCT(TABLE_NAME)))
      FROM
        TEMP_INDEXES
      WHERE
        INDEX_TYPE = 'INVERTED HASH' AND
        TABLE_NAME LIKE '/B%/%'
    )
    UNION ALL
    ( SELECT
        'INVERTED_HASH_INDEXES',
        '',
        TO_VARCHAR(COUNT(DISTINCT(SCHEMA_NAME || INDEX_NAME)))
      FROM
        TEMP_INDEXES
      WHERE
        INDEX_TYPE = 'INVERTED HASH' AND
        SCHEMA_NAME NOT IN ('SYS', 'SYSTEM', 'SYS_STREAMING', '_SYS_STATISTICS')
    )
    UNION ALL
    ( SELECT
        'INVERTED_HASH_NONUNIQUE',
        '',
        TO_VARCHAR(COUNT(DISTINCT(SCHEMA_NAME || INDEX_NAME)))
      FROM
        TEMP_INDEXES
      WHERE
        INDEX_TYPE = 'INVERTED HASH' AND
        ( CONSTRAINT IS NULL OR CONSTRAINT NOT IN ('NOT NULL UNIQUE', 'PRIMARY KEY', 'UNIQUE' ) )
    )
    UNION ALL
    ( SELECT
        'MAX_LOAD_HISTORY_GAP_MIDTERM',
        HOST,
        TO_VARCHAR(MAX(SECONDS_BETWEEN(LAST_TIME, TIME)))
      FROM
      ( SELECT
          L.HOST,
          L.TIME,
          LAG(L.TIME, 1) OVER (PARTITION BY L.HOST, L.PORT ORDER BY L.TIME) LAST_TIME
        FROM
          BASIS_INFO BI,
          GENERAL_INFO G,
          _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
        WHERE
          L.TIME >= GREATEST(G.STARTUP_TIME, ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS))
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'NETWORK_' || L.NAME || '_SHARE',
        '',
        TO_VARCHAR(CASE L.NAME
          WHEN 'POLL'  THEN MAP(TOTAL, 0, 0, TO_DECIMAL(T.POLL / TOTAL * 100, 10, 2))
          WHEN 'READ'  THEN MAP(TOTAL, 0, 0, TO_DECIMAL(T.READ / TOTAL * 100, 10, 2))
          WHEN 'WRITE' THEN MAP(TOTAL, 0, 0, TO_DECIMAL(T.WRITE / TOTAL * 100, 10, 2))
        END)
      FROM
      ( SELECT 'POLL' NAME FROM DUMMY UNION ALL
        SELECT 'READ' FROM DUMMY UNION ALL
        SELECT 'WRITE' FROM DUMMY
      ) L,
      ( SELECT
          COUNT(*) TOTAL,
          SUM(MAP(T.THREAD_STATE, 'Network Poll', 1, 0)) POLL,
          SUM(MAP(T.THREAD_STATE, 'Network Read', 1, 0)) READ,
          SUM(MAP(T.THREAD_STATE, 'Network Write', 1, 0)) WRITE
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND NOT EXISTS
          ( SELECT 
              1 
            FROM 
              PHANTOM_THREADS PT
            WHERE
              T.THREAD_TYPE LIKE PT.THREAD_TYPE AND
              T.THREAD_STATE LIKE PT.THREAD_STATE AND
              T.LOCK_WAIT_NAME LIKE PT.LOCK_NAME AND
              T.THREAD_METHOD LIKE PT.THREAD_METHOD AND
              T.THREAD_DETAIL LIKE PT.THREAD_DETAIL AND
              TO_VARCHAR(T.CONNECTION_ID) LIKE PT.CONN_ID
          )
      ) T
    )
    UNION ALL
    ( SELECT
        'LAST_CTC_RUN',
        '',
        IFNULL(TO_VARCHAR(MIN(DAYS_BETWEEN(C.LAST_START_TIME, CURRENT_TIMESTAMP))), '999999')
      FROM
        DUMMY LEFT OUTER JOIN
        M_CONSISTENCY_CHECK_HISTORY C ON
          C.CHECK_ACTION = 'CHECK' AND
          C.CHECK_PROCEDURE_NAME = 'CHECK_TABLE_CONSISTENCY' AND
          ( C.SCHEMA_NAME = '' OR C.SCHEMA_NAME LIKE 'SAP%' ) AND
          C.OBJECT_NAME = '' AND
          C.OBJECT_TYPE = '' AND
          C.ERROR_CODE = 0
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_SQL_CACHE_SHARE',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(TOTAL_USED_BYTE, 0, 0, STAT_SERVER_USED_BYTE / TOTAL_USED_BYTE * 100), 10, 2))
      FROM
      ( SELECT
          HOST,
          SUM(PLAN_MEMORY_SIZE) TOTAL_USED_BYTE,
          SUM(MAP(USER_NAME, '_SYS_STATISTICS', PLAN_MEMORY_SIZE, 0)) STAT_SERVER_USED_BYTE
        FROM
          TEMP_M_SQL_PLAN_CACHE
        GROUP BY
          HOST
      )
    )
    UNION ALL
    ( SELECT
        'ADDRESS_SPACE_UTILIZATION',
        HOST,
        MAP(MAX(VIRTUAL_ADDRESS_SPACE_TOTAL_SIZE), 0, 'n/a', TO_VARCHAR(TO_DECIMAL(SUM(VIRTUAL_ADDRESS_SPACE_USED_SIZE) / MAX(VIRTUAL_ADDRESS_SPACE_TOTAL_SIZE) * 100, 10, 0)))
      FROM
        M_SERVICE_MEMORY
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'METADATA_DEP_INCONSISTENT',
        '',
        TO_VARCHAR(COUNT(*))
      FROM 
      ( SELECT
          1
        FROM
          TEMP_OBJECT_DEPENDENCIES D
        WHERE
          D.BASE_DATABASE_NAME = D.DEPENDENT_DATABASE_NAME AND
          NOT EXISTS
          ( SELECT
              *
            FROM
              TEMP_OBJECTS O
            WHERE
              IFNULL(O.SCHEMA_NAME, '') = IFNULL(D.BASE_SCHEMA_NAME, '') AND
              O.OBJECT_NAME = D.BASE_OBJECT_NAME AND
              O.OBJECT_TYPE = D.BASE_OBJECT_TYPE
          ) 
        UNION ALL
        SELECT
          1
        FROM
          TEMP_OBJECT_DEPENDENCIES D
        WHERE
          D.BASE_DATABASE_NAME = D.DEPENDENT_DATABASE_NAME AND
          NOT EXISTS
          ( SELECT
              *
            FROM
              TEMP_OBJECTS O
            WHERE
              IFNULL(O.SCHEMA_NAME, '') = IFNULL(D.DEPENDENT_SCHEMA_NAME, '') AND
              O.OBJECT_NAME = D.DEPENDENT_OBJECT_NAME AND
              O.OBJECT_TYPE = D.DEPENDENT_OBJECT_TYPE
          )
      )
    )
    UNION ALL
    ( SELECT
        'CONNECTION_USER_EXPIRATION',
        '',
        IFNULL(U.USER_NAME, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          U.USER_NAME
        FROM
          SYS.USERS U,
        ( SELECT
            USER_NAME
          FROM
            TEMP_M_CONNECTIONS
          WHERE
            CONNECTION_ID > 0
          GROUP BY
            USER_NAME
          HAVING
            COUNT(*) >= 20
        ) C
        WHERE
          U.USER_NAME = C.USER_NAME AND
          U.USER_NAME != 'SYSTEM' AND
          ( U.VALID_UNTIL IS NOT NULL OR
            U.IS_PASSWORD_LIFETIME_CHECK_ENABLED = 'TRUE' )
      ) U ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'LAST_TRACEFILE_MODIFICATION',
        T.HOST,
        TO_VARCHAR(GREATEST(0, SECONDS_BETWEEN(MAX(FILE_MTIME), CURRENT_TIMESTAMP)))
      FROM
        M_TRACEFILES T,
        M_SERVICES S
      WHERE
        T.HOST = S.HOST AND
        FILE_NAME LIKE '%.trc' AND
        S.COORDINATOR_TYPE != 'STANDBY' AND
        S.SERVICE_NAME IN ('nameserver', 'indexserver')
      GROUP BY
        T.HOST
    )
    UNION ALL
    ( SELECT
        'SUSPENDED_SQL',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_ACTIVE_STATEMENTS
      WHERE
        STATEMENT_STATUS = 'SUSPENDED'
    )
    UNION ALL
    ( SELECT
        'SNAP_GROWTH_SHORTTERM',
        '',
        MAP(TH.DISK_SIZE, NULL, 'n/a', TO_VARCHAR(TO_DECIMAL(GREATEST(0, (TC.DISK_SIZE - TH.DISK_SIZE) / 1024 / 1024 / 1024), 10, 2)))
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          MAX(DISK_SIZE) DISK_SIZE
        FROM
          TEMP_M_TABLE_PERSISTENCE_STATISTICS TC
        WHERE
          TABLE_NAME = 'SNAP'
      ) TC ON
        1 = 1 LEFT OUTER JOIN
      ( SELECT TOP 1
          MAX(TA.DISK_SIZE) DISK_SIZE
        FROM
          _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS TA,
        ( SELECT
            MAX(P.SERVER_TIMESTAMP) SERVER_TIMESTAMP
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS P
          WHERE
            P.TABLE_NAME = 'SNAP' AND
            SECONDS_BETWEEN(P.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) > 86400 * BI.SHORTTERM_DAYS
        ) TI
        WHERE
          TA.TABLE_NAME = 'SNAP' AND
          TA.SERVER_TIMESTAMP = TI.SERVER_TIMESTAMP
      ) TH ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'CUR_HIGH_DURATION_THREADS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICE_THREADS
      WHERE
        IS_ACTIVE = 'TRUE' AND
        THREAD_TYPE = 'SqlExecutor' AND
        DURATION / 1000 > 60 AND
        CONNECTION_ID != -1
    )
    UNION ALL
    ( SELECT
        'CUR_APP_USER_THREADS',
        '',
        IFNULL(T.APPLICATION_USER_NAME || CHAR(32) || '(' || T.NUM_THREADS || CHAR(32) || 'threads)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          APPLICATION_USER_NAME,
          COUNT(*) NUM_THREADS
        FROM
          M_SERVICE_THREADS
        WHERE
          IS_ACTIVE = 'TRUE' AND
          CONNECTION_ID != CURRENT_CONNECTION AND
          APPLICATION_USER_NAME != ''
        GROUP BY
          APPLICATION_USER_NAME
        HAVING
          COUNT(*) > 30
      ) T ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'REC_POPULAR_THREAD_METHODS',
        '',
        IFNULL(T.THREAD_METHOD || CHAR(32) || '(' || TO_DECIMAL(T.ACTIVE_THREADS, 10, 2) || CHAR(32) || 'threads)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT TOP 5
          THREAD_METHOD,
          COUNT(*) / BI.SHORTTERM_DAYS / 86400 * G.THREAD_SAMPLES_FILTER_FACTOR ACTIVE_THREADS
        FROM
         GENERAL_INFO G,
         BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          T.THREAD_METHOD NOT IN 
          ( 'ExecQidItab', 'ExecutePrepared', 'generic', 'HEX WorkerJob', 'PlanExecutor calc', 'PlanExecutor comm', 
            'planexecution', 'Request prologue', 'WorkerJob', 'hex::WorkersManager', CHAR(63)
          ) AND
          ( T.THREAD_METHOD, T.LOCK_WAIT_NAME) NOT IN ( ('LogBackupJob', 'LogBackupQueue') )
        GROUP BY
          T.THREAD_METHOD,
          BI.SHORTTERM_DAYS,
          G.THREAD_SAMPLES_FILTER_FACTOR
        HAVING
          ( COUNT(*) > 3 * 86400 * MAP(T.THREAD_METHOD, 'NoAction', 2, 1) * BI.SHORTTERM_DAYS / G.THREAD_SAMPLES_FILTER_FACTOR )
        ORDER BY
          COUNT(*) DESC
      ) T ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'HIST_POPULAR_THREAD_METHODS',
        '',
        IFNULL(T.THREAD_METHOD || CHAR(32) || '(' || TO_DECIMAL(T.ACTIVE_THREADS, 10, 2) || CHAR(32) || 'threads)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT TOP 5
          T.THREAD_METHOD,
          COUNT(*) / BI.LONGTERM_DAYS / 86400 * G.THREAD_SAMPLES_FILTER_FACTOR ACTIVE_THREADS
        FROM
         GENERAL_INFO G,
         BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS AND
          T.THREAD_METHOD NOT IN 
          ( 'ExecQidItab', 'ExecutePrepared', 'generic', 'HEX WorkerJob', 'PlanExecutor calc', 'PlanExecutor comm', 
            'planexecution', 'Request prologue', 'WorkerJob', 'hex::WorkersManager', CHAR(63)
          ) AND
          ( T.THREAD_METHOD, T.LOCK_WAIT_NAME) NOT IN ( ('LogBackupJob', 'LogBackupQueue') )
        GROUP BY
          T.THREAD_METHOD,
          BI.LONGTERM_DAYS,
          G.THREAD_SAMPLES_FILTER_FACTOR
        HAVING
          ( COUNT(*) > 3 * 86400 * MAP(T.THREAD_METHOD, 'NoAction', 2, 1) * BI.LONGTERM_DAYS / G.THREAD_SAMPLES_FILTER_FACTOR )
        ORDER BY
          COUNT(*) DESC
      ) T ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'DEPRECATED_FEATURES_USED',
        '',
        IFNULL(COMPONENT_NAME || CHAR(32) || '-' || CHAR(32) || FEATURE_NAME, 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        M_FEATURE_USAGE FU ON
          IS_DEPRECATED = 'TRUE' AND
          CALL_COUNT > 0 AND
          SECONDS_BETWEEN(LAST_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS AND
          ( ( FU.COMPONENT_NAME, FU.FEATURE_NAME ) NOT IN
            ( ( 'EXPORT', 'SCRAMBLE' ) , ( 'EXPORT', 'STRIP' ), ( 'HIERARCHY', 'HIERARCHY VIEW' ), ( 'HIGH AVAILABILITY', 'HOST AUTO FAILOVER' ), 
              ( 'HIGH AVAILABILITY', 'STORAGE CONNECTOR' ), ( 'IMPORT FROM', 'NO TYPE CHECK' ), ( 'IMPORT FROM', 'SCHEMA FLEXIBILITY' ), ( 'IMPORT FROM', 'TABLE LOCK' ),
              ( 'LOB', 'ST_MEMORY_LOB' ), ( 'SECURITY', 'CONFIGURATION PARAMETER: MAXIMUM_UNUSED_INITAL_PASSWORD_LIFETIME' ), ( 'SECURITY', 'DATA ADMIN' ),
              ( 'SECURITY', 'SAPLOGON AUTHENTICATION' ), ( 'SECURITY', 'X509INTERNAL AUTHENTICATION' ), ( 'SPATIAL', 'GEOCODE INDEXES' ), ( 'SYSTEM', 'ALTER SYSTEM LOGGING OFF' ),
              ( 'TABLE TYPE', 'FLEXIBLE' ), ( 'TABLE TYPE', 'HISTORY' ), ( 'TABLE TYPE', 'NO LOGGING RETENTION' ) 
            ) AND
            FU.COMPONENT_NAME != 'SQL UNQUOTED IDENTIFIER'
          )
    )
    UNION ALL
    ( SELECT
        'TIMEZONE_TABLE_SETUP',
        '',
        MAP(NUM_TABLES, 0, 'no', 'yes')
      FROM
      ( SELECT
          COUNT(*) NUM_TABLES
        FROM
          TEMP_M_TABLES T,
        ( SELECT TOP 1
            VALUE
          FROM
            M_CONFIGURATION_PARAMETER_VALUES
          WHERE
            SECTION = 'global' AND
            KEY = 'timezone_default_data_schema_name' AND
            FILE_NAME IN ('indexserver.ini', 'nameserver.ini', 'xsengine.ini', 'global.ini')
          ORDER BY
            MAP(LAYER_NAME, 'DEFAULT', 1, 0)
        ) P
        WHERE
          T.SCHEMA_NAME = P.VALUE AND
          T.TABLE_NAME = 'TTZZ' AND
          T.RECORD_COUNT >= 10
      )
    )
    UNION ALL
    ( SELECT
        'MANY_TEXT_TOKENS',
        '',
        MAP(TABLE_NAME, NULL, 'none', TABLE_NAME || '.' || SUBSTR(COLUMN_NAME, 14, LENGTH(COLUMN_NAME) - 14) || CHAR(32) || '(' || DISTINCT_COUNT || ')')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          TABLE_NAME,
          COLUMN_NAME,
          DISTINCT_COUNT
        FROM
          TEMP_M_CS_ALL_COLUMNS
        WHERE
          COLUMN_NAME LIKE '$_SYS_SHADOW%' AND
          DISTINCT_COUNT >= 1000000000
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'MEMORY_LEAK_HEAP_AREAS',
        '',
        MAP(CATEGORY, NULL, 'none', CATEGORY || CHAR(32) || '(' || TO_DECIMAL(ROUND(SIZE_1 / 1024 / 1024 / 1024), 10, 0) || '->' || TO_DECIMAL(ROUND(SIZE_7 / 1024 / 1024 / 1024), 10, 0) || CHAR(32) || 'GB)')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          CATEGORY,
          SUM(MAP(NTILE, 1, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_1,
          SUM(MAP(NTILE, 2, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_2,
          SUM(MAP(NTILE, 3, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_3,
          SUM(MAP(NTILE, 4, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_4,
          SUM(MAP(NTILE, 5, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_5,
          SUM(MAP(NTILE, 6, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_6,
          SUM(MAP(NTILE, 7, EXCLUSIVE_SIZE_IN_USE, 0)) SIZE_7
        FROM
        ( SELECT
            NTILE,
            CATEGORY,
            AVG(EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE
          FROM
          ( SELECT
              NTILE(7) OVER (ORDER BY H.SERVER_TIMESTAMP) NTILE,
              H.SERVER_TIMESTAMP,
              SUM(H.EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
              H.CATEGORY
            FROM
              M_DATABASE D,
              _SYS_STATISTICS.HOST_HEAP_ALLOCATORS H,
              ( SELECT CATEGORY, SUM(EXCLUSIVE_SIZE_IN_USE) FROM M_HEAP_MEMORY GROUP BY CATEGORY HAVING SUM(EXCLUSIVE_SIZE_IN_USE) >= 10 * 1024 * 1024 * 1024 ) HC
            WHERE
              H.SERVER_TIMESTAMP >= D.START_TIME AND
              HC.CATEGORY = H.CATEGORY AND
              ( H.CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
                H.CATEGORY NOT LIKE 'AllocateOnlyAllocator-unlimited%' AND
                H.CATEGORY NOT IN
                ( 'Pool/ChannelUtils/SynchronousPoolCopyHandler',
                  'Pool/CS/BufferPage',
                  'Pool/JoinEvaluator/TranslationTable',
                  'Pool/L/jit/CodeCache',
                  'Pool/L/jit/MetaData',
                  'Pool/L/llang/Code',
                  'Pool/L/llang/CodeCache',
                  'Pool/L/llang/Debuggee',
                  'Pool/L/llang/Interfaces',
                  'Pool/PersistenceManager/PersistentSpace/DefaultLPA',
                  'Pool/PersistenceManager/PersistentSpace/DefaultLPA/Page',
                  'Pool/PersistenceManager/PersistentSpace/DefaultLPA/DataPage',
                  'Pool/PersistenceManager/PersistentSpace/DefaultLPA/LOBPage',
                  'Pool/PersistenceManager/PersistentSpace/DefaultLPA/LOBPageControlblock',
                  'Pool/PersistenceManager/PersistentSpace/LOBPage',
                  'Pool/PersistenceManager/PersistentSpace/DefaultPageProvider:DataPage',
                  'Pool/PersistenceManager/LOBContainerDirectory',
                  'Pool/PersistenceManager/PersistentSpace/LOBPageProvider:DataPage',
                  'Pool/PersistenceManager/UnifiedTableContainer',
                  'Pool/PersistenceManager/VarSizeEntryFreeSpaceInformation',
                  'Pool/ResourceContainer',
                  'Pool/ResourceContainer/ResourceHeader',
                  'Pool/RowEngine/SQLPlan',
                  'Pool/RowEngine/SQLPlanStatistics',
                  'Pool/RowStoreTables/CpbTree',
                  'Pool/Statistics/Allocators/Limits/CoreStripedLimits',
                  'Pool/Statistics/Allocators/CoreStripedSubStats'
                )
              )
            GROUP BY
              H.SERVER_TIMESTAMP,
              H.CATEGORY
          )
          GROUP BY
            NTILE,
            CATEGORY
          HAVING
            COUNT(*) >= 3
        )
        GROUP BY
          CATEGORY
      ) ON
        SIZE_2 >= SIZE_1 AND SIZE_3 >= SIZE_2 AND SIZE_4 >= SIZE_3 AND SIZE_5 >= SIZE_4 AND SIZE_6 >= SIZE_5 AND SIZE_7 >= SIZE_6 AND 
        SIZE_7 >= 1.2 * SIZE_1 AND SIZE_7 >= 10737418240
    )
    UNION ALL
    ( SELECT
        'TIMEZONE_ALERTS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICES S,
        M_TIMEZONE_ALERTS TA
      WHERE
        S.SERVICE_NAME IN ( 'indexserver', 'nameserver', 'xsengine' ) AND
        S.HOST = TA.HOST AND
        S.PORT = TA.PORT AND
        TA.MISMATCH_END IS NULL
    )
    UNION ALL
    ( SELECT
        'INITIAL_DATA_SHIPPING_TIME',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(IDS_TIME_S / 3600), 10, 2))
      FROM
      ( SELECT
          MAX(SHIPPED_FULL_REPLICA_DURATION / 1000000) IDS_TIME_S
        FROM
          M_SERVICE_REPLICATION
        UNION ALL
        SELECT
          MAX(SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP)) IDS_TIME_S
        FROM
          M_JOB_PROGRESS
        WHERE
          JOB_NAME = 'System Replication Data Transfer'
      )
    )
    UNION ALL
    ( SELECT
        'NO_CACHE_SEQUENCES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SEQUENCES
      WHERE
        SCHEMA_NAME NOT IN ('SAP_BI_DISCOVER', 'SAP_BI_LAUNCHPAD', 'SAP_HANA_DBCC', 'SAP_HANA_DEMO', 'SAP_HDM', 'SAP_HDM_DDO', 'SAP_HDM_DLM', 'SAP_REST_API', 'SAP_XS_LM', 'SYS', 'SYSTEM') AND
        SEQUENCE_NAME != 'SHDB_PFW_INSTANCE_SEQUENCE' AND
        SUBSTR(SCHEMA_NAME, 1, 4) != '_SYS' AND
        SUBSTR(SEQUENCE_NAME, 1, 4) != '_SYS' AND
        CACHE_SIZE = 1
    )
    UNION ALL
    ( SELECT
        'CROSS_NODE_TRIGGERS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT
          MIN(T.HOST) HOST_1,
          MAX(T.HOST) HOST_2,
          OD.DEPENDENT_SCHEMA_NAME TRIGGER_SCHEMA,
          OD.DEPENDENT_OBJECT_NAME TRIGGER_NAME
        FROM
          TEMP_OBJECT_DEPENDENCIES OD,
          TEMP_M_CS_TABLES T
        WHERE
          OD.DEPENDENT_OBJECT_TYPE = 'TRIGGER' AND
          OD.BASE_OBJECT_TYPE = 'TABLE' AND
          T.SCHEMA_NAME = OD.BASE_SCHEMA_NAME AND
          T.TABLE_NAME = OD.BASE_OBJECT_NAME AND
          NOT EXISTS (SELECT 1 FROM TABLE_REPLICAS R WHERE R.SCHEMA_NAME = T.SCHEMA_NAME AND R.SOURCE_TABLE_NAME = T.TABLE_NAME )
        GROUP BY
          DEPENDENT_SCHEMA_NAME,
          DEPENDENT_OBJECT_NAME
      )
      WHERE
        HOST_1 != HOST_2
    )
    UNION ALL
    ( SELECT
        'INTERNAL_LOCKS_SPIKES',
        '',
        MAP(LOCK_WAIT_NAME, NULL, 'none', LOCK_WAIT_NAME || CHAR(32) || '(' || WAIT_TIMES || CHAR(32) || 'x' || CHAR(32) || TO_DECIMAL(ROUND(AVG_WAITERS), 10, 0) || ')')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          LOCK_WAIT_NAME,
          COUNT(*) WAIT_TIMES,
          AVG(NUM_WAITERS) AVG_WAITERS
        FROM
        ( SELECT
            CASE
              WHEN LOCATE(LOCK_WAIT_NAME, '[') > 0 THEN SUBSTR(LOCK_WAIT_NAME, LOCATE(LOCK_WAIT_NAME, ':', 1, 2) + 2)
              ELSE LOCK_WAIT_NAME
            END LOCK_WAIT_NAME,
            COUNT(*) NUM_WAITERS
          FROM
            GENERAL_INFO G,
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
          WHERE
            SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS AND
            T.THREAD_STATE != 'Job Exec Waiting' AND
            T.LOCK_WAIT_NAME NOT IN ('', CHAR(63), 'capacityReached', 'ChannelUtilsSynchronousCopyHandler', 'CSPlanExecutorLock', 'CSPlanExecutorWaitForResult', 
              'hex_WorkerJob_Sleep_Sem', 'hex_WorkersManager_Sleep_Sem', 'JoinEvaluator_JEPlanData_Lock', 'RecordLockWaitCondStat', 'SaveMergedAttributeJobSemaphore', 
              'TableLockWaitCondStat', 'TransactionLockWaitCondStat', 'TransactionLockWaitSmpStat') AND
            T.LOCK_WAIT_NAME NOT LIKE '%TRexAPI::Mergedog::checkAutomerge%' AND NOT EXISTS
            ( SELECT 
                1 
              FROM 
                PHANTOM_THREADS PT
              WHERE
                T.THREAD_TYPE LIKE PT.THREAD_TYPE AND
                T.THREAD_STATE LIKE PT.THREAD_STATE AND
                T.LOCK_WAIT_NAME LIKE PT.LOCK_NAME AND
                T.THREAD_METHOD LIKE PT.THREAD_METHOD AND
                T.THREAD_DETAIL LIKE PT.THREAD_DETAIL
            )
          GROUP BY
            TIMESTAMP,
            LOCK_WAIT_NAME
          HAVING COUNT(*) >= 20
        )
        WHERE
          LENGTH(LOCK_WAIT_NAME) >= 2 
        GROUP BY
          LOCK_WAIT_NAME
        HAVING
          SUM(NUM_WAITERS) > 1000
      ) ON
      1 = 1
    )
    UNION ALL
    ( SELECT
        'ORPHAN_SLT_SEQUENCES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SEQUENCES S
      WHERE
        S.SEQUENCE_NAME LIKE 'SEQ_/1CADMC%' AND
        NOT EXISTS
        ( SELECT
            1
          FROM
            TEMP_TABLES T
          WHERE
            T.TABLE_NAME = SUBSTR(S.SEQUENCE_NAME, 5)
        )
    )
    UNION ALL
    ( SELECT
        'OS_OPEN_FILES_PCT_CURRENT',
        '',
        TO_VARCHAR(MAX(MAP(L.LIMIT_VALUE, 0, 0, TO_DECIMAL(C.CURRENT_VALUE / L.LIMIT_VALUE * 100, 10, 2))))
      FROM
      ( SELECT
          HOST,
          VALUE LIMIT_VALUE
        FROM
          M_HOST_INFORMATION
        WHERE 
          KEY = 'os_rlimit_nofile'
      ) L,
      ( SELECT
          HOST,
          SUM(OPEN_FILE_COUNT) CURRENT_VALUE
        FROM
          M_SERVICE_STATISTICS
        GROUP BY
          HOST
      ) C
      WHERE
        L.HOST = C.HOST
    )
    UNION ALL
    ( SELECT
        'OS_OPEN_FILES_PCT_HISTORY',
        '',
        TO_VARCHAR(MAX(MAP(L.LIMIT_VALUE, 0, 0, TO_DECIMAL(C.HISTORY_VALUE / L.LIMIT_VALUE * 100, 10, 2))))
      FROM
      ( SELECT
          HOST,
          VALUE LIMIT_VALUE
        FROM
          M_HOST_INFORMATION
        WHERE 
          KEY = 'os_rlimit_nofile'
      ) L,
      ( SELECT
          L.HOST,
          MAX(L.HANDLE_COUNT) HISTORY_VALUE
        FROM
          BASIS_INFO BI,
          M_LOAD_HISTORY_SERVICE L
        WHERE
          L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -BI.LONGTERM_DAYS * 86400)  /* issue number 261128 */
        GROUP BY
          L.HOST
      ) C
      WHERE
        L.HOST = C.HOST
    )
    UNION ALL
    ( SELECT
        'FULLTEXT_INDEX_ERRORS',
        '',
        MAP(T.TABLE_NAME, NULL, 'none', T.TABLE_NAME || '.' || T.COLUMN_NAME || CHAR(32) || '(' || ERROR_PCT || CHAR(32) || '%)')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          TABLE_NAME,
          COLUMN_NAME,
          TOTAL_DOCUMENT_COUNT,
          TO_DECIMAL(ROUND(ERROR_DOCUMENT_COUNT / TOTAL_DOCUMENT_COUNT * 100), 10, 0) ERROR_PCT
        FROM
          M_FULLTEXT_QUEUES
        WHERE
          TOTAL_DOCUMENT_COUNT >= 10000 AND
          ERROR_DOCUMENT_COUNT >= TOTAL_DOCUMENT_COUNT / 100
      ) T ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'FULLTEXT_INDEX_QUEUED',
        '',
        TO_VARCHAR(SUM(QUEUE_DOCUMENT_COUNT))
      FROM
        M_FULLTEXT_QUEUES
    )
    UNION ALL
    ( SELECT
        'CURRENT_UTID',
        '',
        TO_VARCHAR(MAX(NEXT_WRITE_TRANSACTION_ID))
      FROM
        M_MVCC_OVERVIEW
    )
    UNION ALL
    ( SELECT
        L.NAME,
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(L.NAME, 'REDO_GENERATION_ABS', BACKUP_TB,
                                          'REDO_GENERATION_REL', MAP(DATA_DISK_GB, 0, 0, BACKUP_TB / DATA_DISK_GB * 1024 * 100)), 10, 2))
      FROM
      ( SELECT 'REDO_GENERATION_ABS' NAME FROM DUMMY UNION ALL
        SELECT 'REDO_GENERATION_REL' FROM DUMMY
      ) L,
      ( SELECT
          D.DATA_DISK_GB,
          B.BACKUP_TB
        FROM
          GENERAL_INFO D,
        ( SELECT
            SUM(CF.BACKUP_SIZE) / 1024 / 1024 / 1024 / 1024 / MAX(BI.MIDTERM_DAYS) BACKUP_TB
          FROM
            BASIS_INFO BI,
            TEMP_M_BACKUP_CATALOG C,
            TEMP_M_BACKUP_CATALOG_FILES CF
          WHERE
            C.ENTRY_TYPE_NAME = 'log backup' AND
            C.STATE_NAME = 'successful' AND
            C.SYS_START_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS) AND
            C.BACKUP_ID = CF.BACKUP_ID AND
            CF.SOURCE_TYPE_NAME = 'volume'
        ) B
      )
    )
    UNION ALL
    ( SELECT
        'IMPLICIT_MEMORY_BOOKING',
        '',
        TO_VARCHAR(TO_DECIMAL(ROUND(MAP(IMP_SIZE, 0, 0, IMP_SIZE / MEM_SIZE * 100)), 10, 0))
      FROM
      ( SELECT
          10737418240 + SUM(EXCLUSIVE_SIZE_IN_USE) MEM_SIZE
        FROM
          M_HEAP_MEMORY
        WHERE
          EXISTS ( SELECT ALLOCATOR FROM SQL_DATA_AREAS S WHERE CATEGORY LIKE S.ALLOCATOR )
      ) M,
      ( SELECT
          SUM(EXCLUSIVE_SIZE_IN_USE) IMP_SIZE
        FROM
          M_CONTEXT_MEMORY
        WHERE
          CATEGORY LIKE '%IMPLICIT' AND
          EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024 >= 5
      )
    )
    UNION ALL
    ( SELECT
        'ABAP_UPDATE_ERRORS',
        '',
        TO_VARCHAR(MAX(RECORD_COUNT))
      FROM
        TEMP_M_TABLES
      WHERE
        SCHEMA_NAME LIKE 'SAP%' AND
        TABLE_NAME = 'VBERROR'
    )
    UNION ALL
    ( SELECT
        'SAVEPOINT_VOLUME_REL',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(G.DATA_DISK_GB, 0, 0, S.FLUSHED_GB / DAYS / G.DATA_DISK_GB * 100), 10, 2))
      FROM
        GENERAL_INFO G,
      ( SELECT
          SUM(S.FLUSHED_SIZE) / 1024 / 1024 / 1024 FLUSHED_GB,
          SECONDS_BETWEEN(MIN(S.SERVER_TIMESTAMP), CURRENT_TIMESTAMP) / 86400 DAYS
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SAVEPOINTS S
        WHERE
          S.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS)
        GROUP BY
          BI.MIDTERM_DAYS
      ) S
    )
    UNION ALL
    ( SELECT
        L.NAME,
        '',
        MAP(L.NAME, 'SAVEPOINT_FLUSH_RETRIES_MAX', TO_VARCHAR(MAX_RETRIES),
                    'SAVEPOINT_FLUSH_RETRIES_AVG', TO_VARCHAR(TO_DECIMAL(AVG_RETRIES, 10, 2)))
      FROM
      ( SELECT 'SAVEPOINT_FLUSH_RETRIES_MAX' NAME FROM DUMMY UNION ALL
        SELECT 'SAVEPOINT_FLUSH_RETRIES_AVG' FROM DUMMY
      ) L,
      ( SELECT
          MAX(MAX_RETRIES) MAX_RETRIES,
          MAX(AVG_RETRIES) AVG_RETRIES
        FROM
        ( SELECT
            MAX(S.PREPARE_FLUSH_RETRY_COUNT) MAX_RETRIES,
            AVG(S.PREPARE_FLUSH_RETRY_COUNT) AVG_RETRIES
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_SAVEPOINTS S
          WHERE
            SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
            S.PURPOSE != 'SNAPSHOT_FOR_BACKUP'          /* global snapshots use retries for service synchronization */
          GROUP BY
            S.HOST,
            S.PORT
        )
      ) S
    )
    UNION ALL
    ( SELECT DISTINCT
        'PARAMETERS_HOST_LEVEL',
        IFNULL(HOST, ''),
        IFNULL(KEY || CHAR(32) || '=' || CHAR(32) || VALUE || CHAR(32) || '(' || HOST || ')', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        M_CONFIGURATION_PARAMETER_VALUES ON
          LAYER_NAME = 'HOST' AND
          FILE_NAME NOT IN ('daemon.ini', 'webdispatcher.ini', 'webdispatcher...') AND
          KEY NOT IN ( 'affinity', 'basepath_persistent_memory_volumes' )
    )
    UNION ALL
    ( SELECT
        'OPEN_SQL_PER_CONNECTION',
        '',
        TO_VARCHAR(MAX(CNT))
      FROM
      ( SELECT
          COUNT(*) CNT
        FROM
        ( SELECT DISTINCT
            HOST,
            PORT,
            SUBSTR(CATEGORY, 12, MAP(LOCATE(CATEGORY, '/', 1, 2), 0, 999, LOCATE(CATEGORY, '/', 1, 2) - 12)) CONN_ID,
            SUBSTR(CATEGORY, LOCATE(CATEGORY, '/Statement/') + 11, MAP(LOCATE(CATEGORY, '/', 1, 4), 0, 999, LOCATE(CATEGORY, '/', 1, 4) - LOCATE(CATEGORY, '/Statement/') - 11 )) STATEMENT_ID
          FROM
            M_CONTEXT_MEMORY
          WHERE
            CATEGORY LIKE 'Connection/%/Statement%'
        )
        GROUP BY
          HOST,
          PORT,
          CONN_ID
      )
    )
    UNION ALL
    ( SELECT 
        'TRIGGER_READ_RATIO',
        HOST,
        IFNULL(TO_VARCHAR(TO_DECIMAL(MAX(TRIGGER_READ_RATIO), 5, 2)), '999999')
      FROM
        DUMMY LEFT OUTER JOIN
        M_VOLUME_IO_TOTAL_STATISTICS
      ON
        TYPE = 'DATA' AND
        TOTAL_READ_SIZE / 1024 / 1024 / 1024 > 1
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT 
        'TRIGGER_WRITE_RATIO',
        HOST,
        IFNULL(TO_VARCHAR(TO_DECIMAL(MAX(TRIGGER_WRITE_RATIO), 5, 2)), '999999')
      FROM
        DUMMY LEFT OUTER JOIN
        M_VOLUME_IO_TOTAL_STATISTICS
      ON
        TYPE IN ( 'DATA', 'LOG' ) AND
        TOTAL_WRITE_SIZE / 1024 / 1024 / 1024 > 1
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        C.NAME,
        I.HOST,
        CASE
          WHEN C.NAME = 'FAILED_IO_READS' THEN TO_VARCHAR(SUM(TOTAL_FAILED_READS))
          WHEN C.NAME = 'FAILED_IO_WRITES' THEN TO_VARCHAR(SUM(TOTAL_FAILED_WRITES))
        END
      FROM
      ( SELECT 'FAILED_IO_READS' NAME FROM DUMMY UNION ALL
        SELECT 'FAILED_IO_WRITES' FROM DUMMY 
      ) C,
        M_VOLUME_IO_TOTAL_STATISTICS_RESET I
      GROUP BY
        C.NAME,
        I.HOST
    )
    UNION ALL
    ( SELECT
        C.NAME || '_' || I.TYPE,
        I.HOST,
        CASE
          WHEN C.NAME = 'MIN_IO_READ_THROUGHPUT'   THEN TO_VARCHAR(TO_DECIMAL(ROUND(MIN(CASE WHEN I.TOTAL_READ_SIZE / 1000000000 < 3 AND I.TOTAL_READ_TIME < 60000000 THEN 999999 ELSE I.TOTAL_READ_SIZE / I.TOTAL_READ_TIME END )), 10, 0))
          WHEN C.NAME = 'AVG_IO_READ_THROUGHPUT'   THEN TO_VARCHAR(TO_DECIMAL(ROUND(CASE WHEN SUM(I.TOTAL_READ_SIZE) / 1000000000 < 10 AND SUM(I.TOTAL_READ_TIME) < 200000000 THEN 999999 ELSE SUM(I.TOTAL_READ_SIZE) / SUM(I.TOTAL_READ_TIME) END), 10, 0 ))
          WHEN C.NAME = 'MIN_IO_WRITE_THROUGHPUT'  THEN TO_VARCHAR(TO_DECIMAL(ROUND(MIN(CASE WHEN I.TOTAL_WRITE_SIZE / 1000000000 < 3 AND I.TOTAL_WRITE_TIME < 60000000 THEN 999999 ELSE I.TOTAL_WRITE_SIZE / I.TOTAL_WRITE_TIME END )), 10, 0))
          WHEN C.NAME = 'AVG_IO_WRITE_THROUGHPUT'  THEN TO_VARCHAR(TO_DECIMAL(ROUND(CASE WHEN SUM(I.TOTAL_WRITE_SIZE) / 1000000000 < 10 AND SUM(I.TOTAL_WRITE_TIME) < 200000000 THEN 999999 ELSE SUM(I.TOTAL_WRITE_SIZE) / SUM(I.TOTAL_WRITE_TIME) END), 10, 0 ))
          WHEN C.NAME = 'MAX_IO_READ_LATENCY'      THEN TO_VARCHAR(MAX(CASE WHEN I.TOTAL_READ_TIME < 60000000 OR I.TOTAL_READ_SIZE / GREATEST(1, I.TOTAL_READS) > 20000000 THEN -999999 ELSE TO_DECIMAL(I.TOTAL_READ_TIME / I.TOTAL_READS / 1000, 10, 2) END))
          WHEN C.NAME = 'AVG_IO_READ_LATENCY'      THEN TO_VARCHAR(CASE WHEN SUM(I.TOTAL_READ_TIME) < 200000000 OR SUM(I.TOTAL_READ_SIZE) / GREATEST(1, SUM(I.TOTAL_READS)) > 20000000 THEN 999999 ELSE TO_DECIMAL(SUM(I.TOTAL_READ_TIME) / SUM(I.TOTAL_READS) / 1000, 10, 2) END)
          WHEN C.NAME = 'MAX_IO_WRITE_LATENCY'     THEN TO_VARCHAR(MAX(CASE WHEN I.TOTAL_WRITE_TIME < 60000000 THEN -999999 ELSE TO_DECIMAL(I.TOTAL_WRITE_TIME / I.TOTAL_WRITES / 1000, 10, 2) END))
          WHEN C.NAME = 'AVG_IO_WRITE_LATENCY'     THEN TO_VARCHAR(CASE WHEN SUM(I.TOTAL_WRITE_TIME) < 200000000 THEN 999999 ELSE TO_DECIMAL(SUM(I.TOTAL_WRITE_TIME) / SUM(I.TOTAL_WRITES) / 1000, 10, 2) END)
          WHEN C.NAME = 'AVG_IO_READ_ACT_PCT'      THEN TO_VARCHAR(TO_DECIMAL(SUM(I.TOTAL_READ_TIME) / 86400 / SHORTTERM_DAYS / 10000, 10, 2))
          WHEN C.NAME = 'AVG_IO_WRITE_ACT_PCT'     THEN TO_VARCHAR(TO_DECIMAL(SUM(I.TOTAL_WRITE_TIME) / 86400 / SHORTTERM_DAYS / 10000, 10, 2))
        END VALUE
      FROM
      ( SELECT 'MIN_IO_READ_THROUGHPUT' NAME FROM DUMMY UNION ALL
        SELECT 'AVG_IO_READ_THROUGHPUT' FROM DUMMY UNION ALL
        SELECT 'MAX_IO_READ_LATENCY' FROM DUMMY UNION ALL
        SELECT 'AVG_IO_READ_LATENCY' FROM DUMMY UNION ALL
        SELECT 'MIN_IO_WRITE_THROUGHPUT' FROM DUMMY UNION ALL
        SELECT 'AVG_IO_WRITE_THROUGHPUT' FROM DUMMY UNION ALL
        SELECT 'MAX_IO_WRITE_LATENCY' FROM DUMMY UNION ALL
        SELECT 'AVG_IO_WRITE_LATENCY' FROM DUMMY UNION ALL
        SELECT 'AVG_IO_READ_ACT_PCT' FROM DUMMY UNION ALL
        SELECT 'AVG_IO_WRITE_ACT_PCT' FROM DUMMY
      ) C,
      ( SELECT
          HOST,
          TYPE,
          SUM(TOTAL_READS) TOTAL_READS,
          SUM(TOTAL_READ_SIZE) TOTAL_READ_SIZE,
          SUM(TOTAL_READ_TIME) TOTAL_READ_TIME,
          SUM(TOTAL_WRITES) TOTAL_WRITES,
          SUM(TOTAL_WRITE_SIZE) TOTAL_WRITE_SIZE,
          SUM(TOTAL_WRITE_TIME) TOTAL_WRITE_TIME,
          SHORTTERM_DAYS
        FROM
        ( SELECT
            I.HOST,
            I.TYPE,
            I.SERVER_TIMESTAMP,
            I.TOTAL_READS + I.TOTAL_TRIGGER_ASYNC_READS - LEAD(I.TOTAL_READS + I.TOTAL_TRIGGER_ASYNC_READS, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_READS,
            I.TOTAL_READ_SIZE - LEAD(I.TOTAL_READ_SIZE, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_READ_SIZE,
            I.TOTAL_READ_TIME - LEAD(I.TOTAL_READ_TIME, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_READ_TIME,
            I.TOTAL_WRITES + I.TOTAL_TRIGGER_ASYNC_WRITES - LEAD(I.TOTAL_WRITES + I.TOTAL_TRIGGER_ASYNC_WRITES, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_WRITES,
            I.TOTAL_WRITE_SIZE - LEAD(I.TOTAL_WRITE_SIZE, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_WRITE_SIZE,
            I.TOTAL_WRITE_TIME - LEAD(I.TOTAL_WRITE_TIME, 1) OVER (PARTITION BY I.HOST, I.PORT, I.TYPE, I.PATH ORDER BY I.SERVER_TIMESTAMP DESC) + 0.01 TOTAL_WRITE_TIME,
            BI.SHORTTERM_DAYS
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS I
          WHERE
            SECONDS_BETWEEN(I.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
            I.TYPE IN ('LOG', 'DATA')
        )
        WHERE
          TOTAL_WRITES >= 0 AND
          TOTAL_READ_SIZE >= 0 AND
          TOTAL_READ_TIME >= 0 AND
          TOTAL_WRITE_SIZE >= 0 AND
          TOTAL_WRITE_TIME >= 0
        GROUP BY
          HOST,
          TYPE,
          TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD HH24'),
          SHORTTERM_DAYS
      ) I
      GROUP BY
        C.NAME,
        I.HOST,
        I.TYPE,
        I.SHORTTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'IO_READ_BANDWIDTH_STARTUP',
        HOST,
        MAP(READ_TIME_S, 0, NULL, NULL, NULL, TO_VARCHAR(TO_DECIMAL(READ_SIZE_MB / READ_TIME_S, 10, 2))) 
      FROM
      ( SELECT
          H.HOST,
          SUM(GREATEST(I.TOTAL_READ_SIZE_DELTA, 0)) / 1024 / 1024 READ_SIZE_MB,
          SUM(GREATEST(I.TOTAL_READ_TIME_DELTA, 0)) / 1000000 READ_TIME_S
        FROM
          M_HOST_INFORMATION H LEFT OUTER JOIN
          _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS I ON
            I.HOST = H.HOST AND
            I.SERVER_TIMESTAMP BETWEEN TO_TIMESTAMP(H.VALUE) AND ADD_SECONDS(TO_TIMESTAMP(H.VALUE), 14400) AND
            I.TYPE = 'DATA' AND
            I.TOTAL_READ_SIZE_DELTA / 1024 / 1024 / 1024 >= 3 
        WHERE
          H.KEY = 'start_time'
        GROUP BY
          H.HOST
      )
    )
    UNION ALL
    ( SELECT
        'CURR_ALLOCATION_LIMIT_USED',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAP(ALLOCATION_LIMIT, 0, 0, INSTANCE_TOTAL_MEMORY_USED_SIZE / ALLOCATION_LIMIT * 100)), 10, 0))
      FROM
        M_HOST_RESOURCE_UTILIZATION
    )
    UNION ALL
    ( SELECT
        'HIST_ALLOCATION_LIMIT_USED',
        IFNULL(HOST, ''),
        IFNULL(TO_VARCHAR(HOURS), '999999')
      FROM
        DUMMY BI LEFT OUTER JOIN
      ( SELECT
          HOST,
          TO_DECIMAL(ROUND(MIN(SECONDS_BETWEEN(SERVER_TIMESTAMP, CURRENT_TIMESTAMP)) / 3600), 10, 0) HOURS
        FROM
          _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS
        WHERE
          INSTANCE_TOTAL_MEMORY_USED_SIZE > ALLOCATION_LIMIT * 0.8
        GROUP BY
          HOST
      ) R ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'DDLOG_SEQUENCE_CACHING',
        '',
        TO_VARCHAR(MIN(CACHE_SIZE))
      FROM
        SEQUENCES
      WHERE
        SEQUENCE_NAME = 'DDLOG_SEQ'
    )
    UNION ALL
    ( SELECT
        'LONG_LOCK_WAITS',
        '',
        TO_VARCHAR(COUNT(DISTINCT(B.BLOCKED_TIME || B.BLOCKED_CONNECTION_ID)))
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_BLOCKED_TRANSACTIONS B ON
          1 = 1
      WHERE
        SECONDS_BETWEEN(B.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
        SECONDS_BETWEEN(B.BLOCKED_TIME, B.SERVER_TIMESTAMP) > 600
    )
    UNION ALL
    ( SELECT
        'LOCKED_THREADS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_SERVICE_THREADS T
      WHERE
        T.THREAD_STATE IN 
        ( 'BarrierSemaphore Wait', 'Barrier Wait', 'ConditionalVar Wait', 'ConditionalVariable Wait', 'ExclusiveLock Enter', 'IntentLock Enter', 'Mutex Wait', 
          'Semaphore Wait', 'SharedLock Enter', 'Speculative Lock Retry backoff', 'Speculative Lock Wait for fallback', 'Speculative RetryBkf', 'Speculative WaitFlbk'  ) AND
        ( T.CALLING IS NULL OR T.CALLING = '' ) AND
        T.CONNECTION_ID != CURRENT_CONNECTION AND NOT EXISTS
        ( SELECT 
            1 
          FROM 
            PHANTOM_THREADS PT
          WHERE
            T.THREAD_TYPE LIKE PT.THREAD_TYPE AND
            T.THREAD_STATE LIKE PT.THREAD_STATE AND
            T.LOCK_WAIT_NAME LIKE PT.LOCK_NAME AND
            T.THREAD_METHOD LIKE PT.THREAD_METHOD AND
            T.THREAD_DETAIL LIKE PT.THREAD_DETAIL
        )
    )
    UNION ALL
    ( SELECT
        'TOP_SQL_SQLCACHE',
        '',
        IFNULL(STATEMENT_HASH || ' (' || TO_DECIMAL(TOTAL_EXECUTION_TIME / 1000000 / 86400 / BI.SHORTTERM_DAYS, 10, 2) || ' connections)', 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
      ( SELECT
          S.STATEMENT_HASH,
          SUM(S.TOTAL_EXECUTION_TIME) TOTAL_EXECUTION_TIME
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
        WHERE
          SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        GROUP BY
          S.STATEMENT_HASH
        HAVING
          SUM(S.TOTAL_EXECUTION_TIME) / 1000000 > 86400
      ) ON
        1 = 1
      ORDER BY
        TOTAL_EXECUTION_TIME DESC
    ) 
    UNION ALL
    ( SELECT
        'HIGH_SELFWATCHDOG_ACTIVITY',
        TS.HOST,
        TO_VARCHAR(TO_DECIMAL(COUNT(*) / 86400 / BI.SHORTTERM_DAYS * G.THREAD_SAMPLES_FILTER_FACTOR * 100, 10, 2))
      FROM
        GENERAL_INFO G,
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES TS ON 
          SECONDS_BETWEEN(TS.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          TS.THREAD_TYPE = 'SelfWatchDog'
      GROUP BY
        TS.HOST,
        BI.SHORTTERM_DAYS,
        G.THREAD_SAMPLES_FILTER_FACTOR
    )
    UNION ALL
    ( SELECT
        'PROACTIVE_MEMORY_RECLAIMS',
        TS.HOST,
        TO_VARCHAR(TO_DECIMAL(COUNT(*) / 86400 / BI.SHORTTERM_DAYS * G.THREAD_SAMPLES_FILTER_FACTOR * 100, 10, 2))
      FROM
        GENERAL_INFO G,
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES TS ON 
          SECONDS_BETWEEN(TS.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          TS.THREAD_METHOD = 'TimerCallback_ProactiveCompaction'
      GROUP BY
        TS.HOST,
        BI.SHORTTERM_DAYS,
        G.THREAD_SAMPLES_FILTER_FACTOR
    )
    UNION ALL
    ( SELECT
        'MAX_LOG_BACKUP_DURATION',
        '',
        TO_VARCHAR(MAX(SECONDS_BETWEEN(B.SYS_START_TIME, B.SYS_END_TIME)))
      FROM
        BASIS_INFO BI,
        TEMP_M_BACKUP_CATALOG B
      WHERE
        B.ENTRY_TYPE_NAME = 'log backup' AND
        SECONDS_BETWEEN(B.SYS_START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'CATALOG_BACKUP_SIZE_SHARE',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(TOTAL_SIZE, 0, 0, CATALOG_SIZE / TOTAL_SIZE * 100), 10, 2))
      FROM
      ( SELECT
          SUM(CF.BACKUP_SIZE) TOTAL_SIZE,
          SUM(CASE WHEN CF.SOURCE_TYPE_NAME = 'catalog' THEN CF.BACKUP_SIZE ELSE 0 END) CATALOG_SIZE
        FROM
          BASIS_INFO BI,
          TEMP_M_BACKUP_CATALOG C,
          TEMP_M_BACKUP_CATALOG_FILES CF
        WHERE
          C.BACKUP_ID = CF.BACKUP_ID AND
          SECONDS_BETWEEN(C.SYS_END_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
      )
    )
    UNION ALL
    ( SELECT
        'RTEDUMP_TABREP_DEACTIVATED',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(FILE_MTIME), CURRENT_TIMESTAMP) / 86400, 10, 2)), '999999')
      FROM
        DUMMY LEFT OUTER JOIN
        M_TRACEFILES ON
          FILE_NAME LIKE '%.rtedump%table_replication_turn_off%.trc'
    )
    UNION ALL
    ( SELECT
        'LARGE_OVERFLOW_PARTITION',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || OVERFLOW_RECORDS || CHAR(32) || 'records)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          P.SCHEMA_NAME,
          P.TABLE_NAME,
          SUM(CT.RECORD_COUNT) TOTAL_RECORDS,
          SUM(CASE WHEN P.LEVEL_1_RANGE_MIN_VALUE = '' AND P.LEVEL_2_RANGE_MIN_VALUE = '' THEN CT.RECORD_COUNT ELSE 0 END) OVERFLOW_RECORDS
        FROM
          TEMP_PARTITIONED_TABLES T,
          TEMP_M_CS_TABLES CT,
          TEMP_TABLE_PARTITIONS P
        WHERE
          T.SCHEMA_NAME = CT.SCHEMA_NAME AND
          T.TABLE_NAME = CT.TABLE_NAME AND
          CT.SCHEMA_NAME = P.SCHEMA_NAME AND
          CT.TABLE_NAME = P.TABLE_NAME AND
          CT.PART_ID = P.PART_ID AND
          T.LEVEL_1_TYPE = 'RANGE' AND
          T.PARTITION_DEFINITION NOT LIKE '%PARTITION OTHERS DYNAMIC%' AND
          T.TABLE_NAME NOT LIKE '/B%/%'
        GROUP BY
          P.SCHEMA_NAME,
          P.TABLE_NAME
      ) ON
        ( OVERFLOW_RECORDS > 20000000 AND
          MAP(TOTAL_RECORDS, 0, 0, OVERFLOW_RECORDS / TOTAL_RECORDS * 100) > 30 
        ) OR
        OVERFLOW_RECORDS > 200000000
    )
    UNION ALL
    ( SELECT
        'LARGE_CACHES',
        IFNULL(HOST, '') HOST,
        MAP(SIZE_GB, NULL, 'none', CACHE_ID || CHAR(32) || '(' || SIZE_GB || CHAR(32) || 'GB)')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          HOST,
          CACHE_ID,
          TO_DECIMAL(ROUND(SUM(USED_SIZE / 1024 / 1024 / 1024)), 10, 0) SIZE_GB
        FROM
          M_CACHES
        GROUP BY
          HOST,
          CACHE_ID
        HAVING
          SUM(USED_SIZE) / 1024 / 1024 / 1024 >= 50
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        L.NAME,
        '',
        CASE L.NAME
          WHEN 'COMMIT_EXECUTION_RATIO' THEN TO_VARCHAR(TO_DECIMAL(MAP(EXECUTIONS, 0, 0, COMMITS / EXECUTIONS * 100), 10, 2))
          WHEN 'PREPARE_EXECUTION_RATIO' THEN TO_VARCHAR(TO_DECIMAL(MAP(EXECUTIONS, 0, 0, PREPARES / EXECUTIONS * 100), 10, 2))
        END
      FROM
      ( SELECT 'COMMIT_EXECUTION_RATIO' NAME FROM DUMMY UNION ALL
        SELECT 'PREPARE_EXECUTION_RATIO' FROM DUMMY ) L LEFT OUTER JOIN
      ( SELECT
          SUM(EXECUTIONS) EXECUTIONS,
          SUM(COMMITS) COMMITS,
          SUM(PREPARES) PREPARES
        FROM
        ( SELECT
            W.HOST,
            W.PORT,
            AVG(W.CURRENT_EXECUTION_RATE) / 60 EXECUTIONS,
            AVG(W.CURRENT_COMMIT_RATE) / 60 COMMITS,
            AVG(W.CURRENT_COMPILATION_RATE ) / 60 PREPARES
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_WORKLOAD W
          WHERE
            W.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS)
          GROUP BY
            W.HOST,
            W.PORT
        )
      ) W ON
        COMMITS >= 10 AND
        PREPARES >= 10
    )
    UNION ALL
    ( SELECT
        'ROLLBACK_RATE',
        '',
        TO_VARCHAR(TO_DECIMAL(ROLLBACKS, 10, 2))
      FROM
      ( SELECT
          SUM(ROLLBACKS) ROLLBACKS
        FROM
        ( SELECT
            W.HOST,
            W.PORT,
            AVG(W.CURRENT_ROLLBACK_RATE) / 60 ROLLBACKS
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_WORKLOAD W
          WHERE
            W.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.MIDTERM_DAYS)
          GROUP BY
            W.HOST,
            W.PORT
        )
      )
    )  
    UNION ALL
    ( SELECT
        'HIGH_PARTNO_VALUE',
        '',
        MAP(TABLE_NAME, NULL, 'none', TABLE_NAME || CHAR(32) || '(' || RANGE || ')')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          T.TABLE_NAME,
          LTRIM(MAX(LPAD(P.LEVEL_1_RANGE_MIN_VALUE, 10))) RANGE
        FROM
          TEMP_PARTITIONED_TABLES T,
          TEMP_TABLE_PARTITIONS P
        WHERE
          P.SCHEMA_NAME = T.SCHEMA_NAME AND
          P.TABLE_NAME = T.TABLE_NAME AND
          LPAD(P.LEVEL_1_RANGE_MIN_VALUE, 10) >= LPAD('5000', 10) AND
          ( T.LEVEL_1_TYPE = 'RANGE' AND T.LEVEL_1_EXPRESSION = '"PARTNO"' OR
            T.LEVEL_2_TYPE = 'RANGE' AND T.LEVEL_2_EXPRESSION = '"PARTNO"' )
        GROUP BY
          T.TABLE_NAME
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        C.NAME,
        LP.HOST,
        CASE
          WHEN C.NAME = 'AVG_COMMIT_IO_TIME' THEN TO_VARCHAR(TO_DECIMAL(MAP(SUM(LP.COMMIT_COUNT_DELTA), 0, 0, SUM(LP.SUM_COMMIT_IO_LATENCY_DELTA) / SUM(LP.COMMIT_COUNT_DELTA) / 1000), 10, 2))
          WHEN C.NAME = 'MAX_COMMIT_IO_TIME' AND MAX(LP.MAX_COMMIT_IO_LATENCY) <= 1000000000000 THEN TO_VARCHAR(TO_DECIMAL(MAX(LP.MAX_COMMIT_IO_LATENCY) / 1000000, 10, 2))
          ELSE 'n/a'
        END
      FROM
      ( SELECT 'AVG_COMMIT_IO_TIME' NAME FROM DUMMY UNION ALL
        SELECT 'MAX_COMMIT_IO_TIME' FROM DUMMY
      ) C LEFT OUTER JOIN
        BASIS_INFO BI ON
          1 = 1 LEFT OUTER JOIN
        TEMP_HOST_LOG_PARTITIONS LP ON
          SECONDS_BETWEEN(LP.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= BI.LONGTERM_DAYS * 86400 AND
          ( C.NAME = 'AVG_COMMIT_IO_TIME' OR LP.MAX_COMMIT_IO_LATENCY_DELTA > 0 )
      GROUP BY
        C.NAME,
        LP.HOST
    )
    UNION ALL
    ( SELECT
        'LARGE_MEMORY_LOBS',
        '',
        TO_VARCHAR(COUNT(DISTINCT(T.SCHEMA_NAME || T.TABLE_NAME)))
      FROM
        TEMP_M_TABLES T,
        TEMP_TABLE_COLUMNS C
      WHERE
        T.SCHEMA_NAME = C.SCHEMA_NAME AND
        T.TABLE_NAME = C.TABLE_NAME AND
        ( C.CS_DATA_TYPE_NAME = 'ST_MEMORY_LOB' OR C.CS_DATA_TYPE_NAME = 'LOB' AND C.MEMORY_THRESHOLD IS NULL ) AND
        T.TABLE_NAME NOT IN ( 'CE_SCENARIOS_', 'MERGED_TRACES_FOR_COCKPIT' ) AND
        T.TABLE_SIZE / 1024 / 1024 / 1024 >= 2
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        IFNULL(CASE C.NAME
          WHEN 'CONCAT_ATTRIBUTES_SIZE'  THEN TO_VARCHAR(TO_DECIMAL(SUM(IFNULL(AC.SIZE_GB, 0)), 10, 2))
          WHEN 'CONCAT_ATTRIBUTES_PCT'   THEN TO_VARCHAR(TO_DECIMAL(MAP(AVG(G.TOTAL_ALLOC_LIM_GB), 0, 0, SUM(IFNULL(AC.SIZE_GB, 0)) / AVG(G.TOTAL_ALLOC_LIM_GB) * 100), 10, 2))
          WHEN 'UNIQUE_INDEXES_PCT'      THEN TO_VARCHAR(TO_DECIMAL(MAP(AVG(G.TOTAL_ALLOC_LIM_GB), 0, 0, SUM(IFNULL(AC.SIZE_GB, 0)) / AVG(G.TOTAL_ALLOC_LIM_GB) * 100), 10, 2))
        END, '0')
      FROM
        GENERAL_INFO G,
      ( SELECT 'CONCAT_ATTRIBUTES_SIZE' NAME FROM DUMMY UNION ALL
        SELECT 'CONCAT_ATTRIBUTES_PCT'       FROM DUMMY UNION ALL
        SELECT 'UNIQUE_INDEXES_PCT'          FROM DUMMY
      ) C LEFT OUTER JOIN
      ( SELECT
          C.TABLE_NAME,
          C.COLUMN_NAME,
          C.INTERNAL_ATTRIBUTE_TYPE,
          ( C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL ) / 1024 / 1024 / 1024 SIZE_GB
        FROM
          TEMP_M_CS_ALL_COLUMNS C LEFT OUTER JOIN
          TEMP_TABLE_COLUMNS TC ON
            TC.SCHEMA_NAME = C.SCHEMA_NAME AND
            TC.TABLE_NAME = C.TABLE_NAME AND
            TC.COLUMN_NAME = C.COLUMN_NAME
      ) AC ON
        ( C.NAME LIKE 'CONCAT_ATTRIBUTES%' AND AC.INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE' AND AC.COLUMN_NAME NOT LIKE '$uc%' OR
          C.NAME = 'UNIQUE_INDEXES_PCT' AND ( AC.INTERNAL_ATTRIBUTE_TYPE = 'TREX_EXTERNAL_KEY' OR AC.INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE' AND AC.COLUMN_NAME LIKE '$uc%' )
        )
      GROUP BY
        C.NAME
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_HIT_RATIO',
        HOST,
        TO_VARCHAR(TO_DECIMAL(PLAN_CACHE_HIT_RATIO * 100, 10, 2))
      FROM
        TEMP_M_SQL_PLAN_CACHE_OVERVIEW
      WHERE
        CACHED_PLAN_SIZE >= 100000000
    )
    UNION ALL
    ( SELECT
        'KERNEL_PROFILER',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_KERNEL_PROFILER
      WHERE
        STATUS != 'STOPPED' OR
        STATUS = 'STOPPED' AND SECONDS_BETWEEN(STOP_TIME, CURRENT_TIMESTAMP) <= 3600
    )
    UNION ALL
    ( SELECT
        'HEAP_ALLOCATOR_STACK_ENABLED',
        IFNULL(HOST, ''),
        IFNULL(CATEGORY, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          HOST,
          CATEGORY
        FROM
          M_HEAP_MEMORY
        WHERE
          FLAGS LIKE '%astrace%'
      ) ON
      1 = 1
    )
    UNION ALL
    ( SELECT
        'HEAP_OTHER_TRACES_ENABLED',
        '',
        TO_VARCHAR(COUNT(DISTINCT(CATEGORY)))
      FROM
        M_HEAP_MEMORY
      WHERE
        FLAGS NOT LIKE '%astrace%' and FLAGS NOT IN ( '(none)', 'preventcheck', 'nonemptyok' )
    )
    UNION ALL
    ( SELECT
        'HEAP_TRACES_ENABLED_HIST',
        '',
        TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) / 86400, 10, 2))
      FROM
        DUMMY LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_HEAP_ALLOCATORS ON
          FLAGS NOT IN ( '(none)', 'preventcheck', 'nonemptyok' )
    )
    UNION ALL
    ( SELECT
        'SMALL_RETENTION_TABLES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_TABLES
      WHERE
        UNUSED_RETENTION_PERIOD BETWEEN 1 AND 3599
    )
    UNION ALL
    ( SELECT
        'TABLE_MVCC_SNAPSHOT_RANGE',
        '',
        IFNULL(TO_VARCHAR(CUR_COMMIT_ID - MIN_TS_ID), '0')
      FROM
      ( SELECT
          (MIN(MIN_MVCC_SNAPSHOT_TIMESTAMP)) MIN_TS_ID
        FROM
          M_TABLE_SNAPSHOTS
      ),
      ( SELECT
          MAX(GLOBAL_MVCC_TIMESTAMP) CUR_COMMIT_ID
        FROM
          M_MVCC_OVERVIEW
      )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        L.HOST,
        CASE C.NAME
          WHEN 'CONC_BLOCK_TRANS_SHORTTERM'   THEN TO_VARCHAR(MAX(GREATEST(0, L.BLOCKED_TRANSACTION_COUNT)))
          WHEN 'VERSIONS_ROW_STORE_SHORTTERM' THEN TO_VARCHAR(MAX(GREATEST(0, L.MVCC_VERSION_COUNT)))
          WHEN 'COMMIT_ID_RANGE_SHORTTERM'    THEN TO_VARCHAR(MAX(GREATEST(0, L.COMMIT_ID_RANGE)))
          WHEN 'WRONG_SYSTEM_CPU'             THEN CASE WHEN SUM(CPU) < 10 THEN NULL ELSE MAP(SUM(CPU), SUM(SYSTEM_CPU), 'yes', 'no') END
        END
      FROM
      ( SELECT 'CONC_BLOCK_TRANS_SHORTTERM' NAME FROM DUMMY UNION ALL
        SELECT 'VERSIONS_ROW_STORE_SHORTTERM'    FROM DUMMY UNION ALL
        SELECT 'COMMIT_ID_RANGE_SHORTTERM'       FROM DUMMY UNION ALL
        SELECT 'WRONG_SYSTEM_CPU'                FROM DUMMY
      ) C,
        BASIS_INFO BI,
        M_LOAD_HISTORY_SERVICE L
      WHERE
        SECONDS_BETWEEN(L.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
      GROUP BY
        C.NAME,
        L.HOST
    )
    UNION ALL
    ( SELECT
        'PING_TIME_SHORTTERM',
        HOST,
        TO_VARCHAR(MAX(TO_DECIMAL(AVG_PING_TIME_MS, 10, 2)))
      FROM
      ( SELECT
          L.HOST,
          L.PORT,
          AVG(L.PING_TIME) AVG_PING_TIME_MS
        FROM
          BASIS_INFO BI,
          M_LOAD_HISTORY_SERVICE L
        WHERE
          SECONDS_BETWEEN(L.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        GROUP BY
          L.HOST,
          L.PORT
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'HOT_NUMA_NODES',
        IFNULL(HOST, ''),
        IFNULL(NUMA_NODE || CHAR(32) || '(' || TO_DECIMAL(100 - IDLE_PCT, 10, 2) || CHAR(32) || '%)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          C.HOST,
          N.NUMA_NODE,
          AVG(C.IDLE_PCT) IDLE_PCT
        FROM
        ( SELECT
            HOST,
            MEASURED_ELEMENT_NAME CORE,
            AVG(TO_NUMBER(VALUE)) IDLE_PCT
          FROM
            M_HOST_AGENT_METRICS
          WHERE
            MEASURED_ELEMENT_TYPE = 'Processor' AND
            CAPTION = 'Idle Time'
          GROUP BY
            HOST,
            MEASURED_ELEMENT_NAME
        ) C LEFT OUTER JOIN
        ( SELECT
            NUMA_NODE,
            CASE WHEN LOCATE(LOGICAL_CORE_IDS, '-') = 0 THEN TO_NUMBER(LOGICAL_CORE_IDS) ELSE TO_NUMBER(SUBSTR(LOGICAL_CORE_IDS, 1, LOCATE(LOGICAL_CORE_IDS, '-') - 1)) END MIN_CORE,
            CASE WHEN LOCATE(LOGICAL_CORE_IDS, '-') = 0 THEN TO_NUMBER(LOGICAL_CORE_IDS) ELSE TO_NUMBER(SUBSTR(LOGICAL_CORE_IDS, LOCATE(LOGICAL_CORE_IDS, '-') + 1)) END MAX_CORE
          FROM
          ( SELECT
              N.NUMA_NODE,
              SUBSTR(N.LOGICAL_CORE_IDS, LOCATE(N.LOGICAL_CORE_IDS, ',', L.LNO) + 1, LOCATE(N.LOGICAL_CORE_IDS, ',', L.LNO + 1) - LOCATE(N.LOGICAL_CORE_IDS, ',', L.LNO) - 1) LOGICAL_CORE_IDS
            FROM
            ( SELECT TOP 1000 ROW_NUMBER() OVER () LNO FROM TEMP_OBJECTS ) L,
            ( SELECT DISTINCT
                NUMA_NODE_ID NUMA_NODE,
                ',' || LOGICAL_CORE_IDS || ',' LOGICAL_CORE_IDS
              FROM
                M_NUMA_NODES
            ) N
          )
          WHERE
            LOGICAL_CORE_IDS != ''
        ) N ON
          C.CORE BETWEEN N.MIN_CORE AND N.MAX_CORE
        GROUP BY
          C.HOST,
          N.NUMA_NODE
        HAVING
          AVG(C.IDLE_PCT) <= 20
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'PENDING_SESSIONS_CURRENT',
        '',
        TO_VARCHAR(GREATEST(0, SUM(PENDING_SESSION_COUNT)))
      FROM
        M_LOAD_HISTORY_SERVICE
      WHERE
        TIME = ( SELECT MAX(TIME) FROM M_LOAD_HISTORY_SERVICE )
    )
    UNION ALL
    ( SELECT
        'PENDING_SESSIONS_RECENT',
        '',
        TO_VARCHAR(TO_DECIMAL(GREATEST(0, AVG(PENDING_SESSION_COUNT)), 10, 2))
      FROM
      ( SELECT
          SUM(L.PENDING_SESSION_COUNT) PENDING_SESSION_COUNT
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
        WHERE
          SECONDS_BETWEEN(L.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        GROUP BY
          L.TIME
      )
    )
    UNION ALL
    ( SELECT
        'INTERNAL_LOCKS_SHORTTERM',
        '',
        IFNULL(T.LOCK_WAIT_NAME || ' (' || TO_DECIMAL(T.ELAPSED_S / 86400 / BI.SHORTTERM_DAYS, 10, 2) || ' threads)', 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
      ( SELECT TOP 5
          CASE WHEN LOCATE(T.LOCK_WAIT_NAME, '[') > 0 THEN SUBSTR(T.LOCK_WAIT_NAME, LOCATE(T.LOCK_WAIT_NAME, ':', 1, 2) + 2) ELSE T.LOCK_WAIT_NAME END LOCK_WAIT_NAME,
          COUNT(*) * G.THREAD_SAMPLES_FILTER_FACTOR ELAPSED_S
        FROM
          GENERAL_INFO G,
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          THREAD_STATE != 'Job Exec Waiting' AND
          LOCK_WAIT_NAME NOT IN ('', CHAR(63), 'capacityReached', 'ChannelUtilsSynchronousCopyHandler', 'CSPlanExecutorLock', 'CSPlanExecutorWaitForResult', 
            'hex_WorkerJob_Sleep_Sem', 'hex_WorkersManager_Sleep_Sem', 'JoinEvaluator_JEPlanData_Lock', 'MasterQS_hasJobs', 'RecordLockWaitCondStat', 
            'SaveMergedAttributeJobSemaphore', 'TableLockWaitCondStat', 'TransactionLockWaitCondStat', 'TransactionLockWaitSmpStat') AND
          LOCK_WAIT_NAME NOT LIKE '%TRexAPI::Mergedog::checkAutomerge%' AND NOT EXISTS
          ( SELECT 
              1 
            FROM 
              PHANTOM_THREADS PT
            WHERE
              T.THREAD_TYPE LIKE PT.THREAD_TYPE AND
              T.THREAD_STATE LIKE PT.THREAD_STATE AND
              T.LOCK_WAIT_NAME LIKE PT.LOCK_NAME AND
              T.THREAD_METHOD LIKE PT.THREAD_METHOD AND
              T.THREAD_DETAIL LIKE PT.THREAD_DETAIL
          )
        GROUP BY
          T.LOCK_WAIT_NAME,
          BI.SHORTTERM_DAYS,
          G.THREAD_SAMPLES_FILTER_FACTOR
        HAVING
          COUNT(*) > 86400 * BI.SHORTTERM_DAYS / G.THREAD_SAMPLES_FILTER_FACTOR
        ORDER BY
          COUNT(*) DESC
       ) T ON
         1 = 1
    )
    UNION ALL
    ( SELECT
        'TOP_SQL_THREADSAMPLES_HIST',
        '',
        IFNULL(T.STATEMENT_HASH || ' (' || TO_DECIMAL(T.ELAPSED_S / 86400 / BI.SHORTTERM_DAYS, 10, 2) || ' threads)', 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
      ( SELECT TOP 5
          T.STATEMENT_HASH,
          COUNT(*) * G.THREAD_SAMPLES_FILTER_FACTOR ELAPSED_S
        FROM
          GENERAL_INFO G,
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
          T.STATEMENT_HASH != CHAR(63)
        GROUP BY
          T.STATEMENT_HASH,
          G.THREAD_SAMPLES_FILTER_FACTOR,
          BI.SHORTTERM_DAYS
        HAVING
          COUNT(*) > 86400 * BI.SHORTTERM_DAYS / G.THREAD_SAMPLES_FILTER_FACTOR
        ORDER BY
          COUNT(*) DESC
      ) T ON
        1 = 1
      ORDER BY
        ELAPSED_S DESC
    )
    UNION ALL
    ( SELECT
        'OLD_PENDING_ALERT_EMAILS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_EMAIL_PROCESSING 
      WHERE
        SECONDS_BETWEEN(SNAPSHOT_ID, CURRENT_TIMESTAMP) > 3 * 24 * 3600
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_DISABLED_CHECKS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        STATUS = 'Disabled'
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_UNKNOWN_STATES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
       STATUS NOT IN ( 'Disabled', 'Idle', 'Inactive', 'Manual', 'Scheduled' )
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_INACTIVE_CHECKS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        "_SYS_STATISTICS"."STATISTICS_SCHEDULE" 
      WHERE
       STATUS = 'Inactive' AND
       ID NOT IN (1, 20, 41, 58, 73, 74, 77, 83, 95, 96, 98, 117, 127, 5008, 5024, 5025, 5033, 5035, 5047, 5059)
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_WRONG_HOST',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TABLE_LOCATIONS
      WHERE
        SCHEMA_NAME = '_SYS_STATISTICS' AND
        LOCATION !=
        ( SELECT 
            HOST || ':' || PORT
          FROM
            M_SERVICES
          WHERE
            SERVICE_NAME = 'indexserver' AND
            DETAIL = 'master'
        )
    )
    UNION ALL
    ( SELECT
        'ESS_MIGRATION_SUCCESSFUL',
        '',
        LOWER(SUBSTR(VALUE, 1, LOCATE(VALUE, ')')))
      FROM
        DUMMY LEFT OUTER JOIN
        _SYS_STATISTICS.STATISTICS_PROPERTIES 
      ON
        KEY = 'internal.installation.state'
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_LAST_ACTIVE',
        '',
        TO_VARCHAR(SECONDS_BETWEEN(MAX(LATEST_START_SERVERTIME), CURRENT_TIMESTAMP))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_RETENTION',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE SS,
        _SYS_STATISTICS.STATISTICS_OBJECTS SO
      WHERE
        SS.ID = SO.ID AND
        SO.TYPE = 'Collector' AND
        SS.ID NOT IN ( 5008, 5024, 5025, 5026, 5033, 5035, 5600, 5601, 5602, 5603, 5604 ) AND
        IFNULL(SS.RETENTION_DAYS_CURRENT, SS.RETENTION_DAYS_DEFAULT) < 42
    )
    UNION ALL
    ( SELECT
        MAP(ID, 5033, 'HOST_RECORD_LOCKS_ACTIVE', 'HOST_CS_UNLOADS_ACTIVE'),
        '',
        MAP(STATUS, 'Inactive', 'no', 'yes')
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        ID IN ( 5033, 5035 )
    )
    UNION ALL
    ( SELECT
        'REP_CONNECTION_CLOSED',
        '',
        MAP(IFNULL(RECONNECTS, 0), 0, 'no', 'yes')
      FROM
      ( SELECT
          SUM(GREATEST(RECONNECTS, 0)) RECONNECTS
        FROM
        ( SELECT
            R.SECONDARY_RECONNECT_COUNT - IFNULL(LAG(R.SECONDARY_RECONNECT_COUNT, 1) OVER (PARTITION BY R.HOST, R.PORT, R.SECONDARY_HOST ORDER BY R.SERVER_TIMESTAMP), R.SECONDARY_RECONNECT_COUNT) RECONNECTS
          FROM
            BASIS_INFO BI,
            _SYS_STATISTICS.HOST_SERVICE_REPLICATION R
          WHERE
            SECONDS_BETWEEN(R.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
        )
      )
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_OLD_ALERTS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        _SYS_STATISTICS.STATISTICS_ALERTS_BASE
      WHERE
        ALERT_TIMESTAMP < ADD_DAYS(CURRENT_TIMESTAMP, -44)
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_FREQUENT_ALERTS',
        '',
        TO_VARCHAR(SUM(CASE WHEN NUM_ALERTS > 1000000 THEN 1 ELSE 0 END ))
      FROM
      ( SELECT
          ALERT_ID,
          COUNT(*) NUM_ALERTS
        FROM
          DUMMY LEFT OUTER JOIN
          _SYS_STATISTICS.STATISTICS_ALERTS_BASE
        ON
          1 = 1
        GROUP BY
          ALERT_ID
      )
    )
    UNION ALL
    ( SELECT
        'CTC_ERRORS_LONGTERM',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        M_CONSISTENCY_CHECK_HISTORY C,
        M_CONSISTENCY_CHECK_HISTORY_ERRORS CE
      WHERE
        C.CHECK_EXECUTION_ID = CE.CHECK_EXECUTION_ID AND
        C.LAST_START_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS) AND
        CE.SEVERITY != 'INFO' AND
        CE.ERROR_CODE NOT IN (0, 8, 5084, 5089, 5096, 5097, 5098, 5099 )
    )
    UNION ALL
    ( SELECT
        C.NAME,
        '',
        CASE C.NAME
          WHEN 'TCP_RETRANSMITTED_SEGMENTS' THEN
            TO_VARCHAR(MAX(TO_DECIMAL(MAP(N.TCP_SEGMENTS_SENT_OUT, 0, 0, N.TCP_SEGMENTS_RETRANSMITTED * 100 / N.TCP_SEGMENTS_SENT_OUT), 9, 5)))
          WHEN 'TCP_BAD_SEGMENTS' THEN
            TO_VARCHAR(MAX(TO_DECIMAL(MAP(N.TCP_SEGMENTS_RECEIVED, 0, 0, N.TCP_BAD_SEGMENTS_RECEIVED * 100 / N.TCP_SEGMENTS_RECEIVED), 9, 5)))
        END 
      FROM
      ( SELECT 'TCP_RETRANSMITTED_SEGMENTS' NAME FROM DUMMY UNION ALL
        SELECT 'TCP_BAD_SEGMENTS' FROM DUMMY
      ) C,
        M_HOST_NETWORK_STATISTICS N
      GROUP BY
        C.NAME
    )
    UNION ALL
    ( SELECT 
        'AVG_COMMIT_TIME',
        HOST,
        MAP(SUM(COMMIT_COUNT), 0, 'n/a', TO_VARCHAR(TO_DECIMAL(SUM(COMMIT_TOTAL_EXECUTION_TIME) / 1000 / SUM(COMMIT_COUNT), 10, 2)))
      FROM
        M_CONNECTION_STATISTICS
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'OOM_EVENTS_SHORTTERM',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.GLOBAL_OUT_OF_MEMORY_EVENTS O
      WHERE
        SECONDS_BETWEEN(O.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'OOM_EVENTS_PER_DAY_MIDTERM',
        '',
        TO_VARCHAR(TO_DECIMAL(IFNULL(COUNT(*) / MAX(BI.MIDTERM_DAYS), 0), 10, 2))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.GLOBAL_OUT_OF_MEMORY_EVENTS O
      WHERE
        SECONDS_BETWEEN(O.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.MIDTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'OOM_EVENTS_GAL_PAL_LONGTERM',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.GLOBAL_OUT_OF_MEMORY_EVENTS O
      WHERE
        SECONDS_BETWEEN(O.TIME, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS AND
        O.EVENT_REASON IN ( 'GLOBAL_ALLOCATION_LIMIT', 'PROCESS_ALLOCATION_LIMIT' )
    )
    UNION ALL
    ( SELECT
        'INACTIVE_TABLE_REPLICAS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TABLE_REPLICAS
      WHERE
        REPLICATION_STATUS NOT IN ( 'ENABLED', 'ENABLING' ) AND NOT
        ( REPLICATION_STATUS = 'DISABLED' AND LAST_ERROR_CODE = 0 )
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        IFNULL(TO_VARCHAR(MAP(I.NAME, 'SR_LOGREPLAY_BACKLOG_CURR', R.BACKLOG_GB, R.DELAY_S)), '0')
      FROM
      ( SELECT 'SR_LOGREPLAY_BACKLOG_CURR' NAME FROM DUMMY UNION ALL
        SELECT 'SR_LOGREPLAY_DELAY_CURR'        FROM DUMMY
      ) I LEFT OUTER JOIN
      ( SELECT
          TO_DECIMAL(MAX(MAP(R.REPLAYED_LOG_POSITION, 0, 0, R.SHIPPED_LOG_POSITION - R.REPLAYED_LOG_POSITION)) * 64 / 1024 / 1024 / 1024, 10, 0) BACKLOG_GB,
          TO_DECIMAL(MAX(SECONDS_BETWEEN(R.REPLAYED_LOG_POSITION_TIME, R.SHIPPED_LOG_POSITION_TIME)), 10, 0) DELAY_S
        FROM
          M_SYSTEM_REPLICATION S,
          M_SERVICE_REPLICATION R
        WHERE
          S.SITE_ID = R.SITE_ID AND
          S.OPERATION_MODE = 'logreplay'
      ) R ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        I.NAME,
        '',
        IFNULL(TO_VARCHAR(MAP(I.NAME, 'SR_LOGREPLAY_BACKLOG_HIST', R.BACKLOG_GB, R.DELAY_S)), '0')
      FROM
      ( SELECT 'SR_LOGREPLAY_BACKLOG_HIST' NAME FROM DUMMY UNION ALL
        SELECT 'SR_LOGREPLAY_DELAY_HIST'        FROM DUMMY
      ) I LEFT OUTER JOIN
      ( SELECT
          TO_DECIMAL(MAX(MAP(R.REPLAYED_LOG_POSITION, 0, 0, R.SHIPPED_LOG_POSITION - R.REPLAYED_LOG_POSITION)) * 64 / 1024 / 1024 / 1024, 10, 0) BACKLOG_GB,
          TO_DECIMAL(MAX(SECONDS_BETWEEN(R.REPLAYED_LOG_POSITION_TIME, R.SHIPPED_LOG_POSITION_TIME)), 10, 0) DELAY_S
        FROM
          BASIS_INFO BI,
          M_SYSTEM_REPLICATION S,
          _SYS_STATISTICS.HOST_SERVICE_REPLICATION R
        WHERE
          S.SITE_ID = R.SITE_ID AND
          S.OPERATION_MODE = 'logreplay' AND
          R.SHIPPED_LOG_BUFFERS_COUNT_DELTA >= 0 AND
          SECONDS_BETWEEN(R.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS
      ) R ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'SDA_TABLES_WITHOUT_STATS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        VIRTUAL_TABLES T
      WHERE
        SCHEMA_NAME NOT LIKE '_SYS_SR_SITE%' AND
        NOT EXISTS ( SELECT 1 FROM DATA_STATISTICS S WHERE S.DATA_SOURCE_SCHEMA_NAME = T.SCHEMA_NAME AND S.DATA_SOURCE_OBJECT_NAME = T.TABLE_NAME )
    )
    UNION ALL
    ( SELECT
        'CRIT_HYPERTHREADING_ACTIVE',
        '',
        CASE
          WHEN UPPER(MANUFACTURER) LIKE '%INTEL%' AND SOCKETS >= 9 AND CPU_THREADS != CPU_CORES THEN 'yes' ELSE 'no' END
      FROM
      ( SELECT
          MAX(MAP(KEY, 'cpu_sockets', VALUE)) SOCKETS,
          MAX(MAP(KEY, 'cpu_manufacturer', VALUE)) MANUFACTURER,
          MAX(MAP(KEY, 'cpu_cores', VALUE)) CPU_CORES,
          MAX(MAP(KEY, 'cpu_threads', VALUE)) CPU_THREADS
        FROM
          M_HOST_INFORMATION
      )
    )
    UNION ALL
    ( SELECT
        'CPU_STEAL_SHARE',
        '',
        TO_VARCHAR(TO_DECIMAL(MAX(VALUE), 10, 2))
      FROM
        M_HOST_AGENT_METRICS
      WHERE
        MEASURED_ELEMENT_TYPE = 'OperatingSystem' AND
        CAPTION = 'Steal Time'
    )
    UNION ALL
    ( SELECT
        NAME,
        '',
        CASE NAME
          WHEN 'COLLISION_SHARE_CURR'     THEN TO_VARCHAR(TO_DECIMAL(MAX(MAP(TRANS_PACK_PER_S + RECV_PACK_PER_S, 0, 0, COLL_PER_S / (TRANS_PACK_PER_S + RECV_PACK_PER_S) * 100)), 10, 2))
          WHEN 'SEND_ERROR_SHARE_CURR'    THEN TO_VARCHAR(TO_DECIMAL(MAX(MAP(TRANS_PACK_PER_S, 0, 0, TRANS_ERR_PER_S / TRANS_PACK_PER_S * 100)), 10, 2))
          WHEN 'RECEIVE_ERROR_SHARE_CURR' THEN TO_VARCHAR(TO_DECIMAL(MAX(MAP(RECV_PACK_PER_S, 0, 0, RECV_ERR_PER_S / RECV_PACK_PER_S * 100)), 10, 2))
        END
      FROM
      ( SELECT
          *
        FROM
        ( SELECT 'COLLISION_SHARE_CURR' NAME FROM DUMMY UNION ALL
          SELECT 'SEND_ERROR_SHARE_CURR'     FROM DUMMY UNION ALL
          SELECT 'RECEIVE_ERROR_SHARE_CURR'  FROM DUMMY
        ) L,
        ( SELECT
            HOST,
            MEASURED_ELEMENT_NAME INTERFACE,
            MAX(MAP(CAPTION, 'Collision Rate', TO_NUMBER(VALUE))) COLL_PER_S,
            MAX(MAP(CAPTION, 'Packet Receive Rate', TO_NUMBER(VALUE), 0)) RECV_PACK_PER_S,
            MAX(MAP(CAPTION, 'Packet Transmit Rate', TO_NUMBER(VALUE), 0)) TRANS_PACK_PER_S,
            MAX(MAP(CAPTION, 'Receive Error Rate', TO_NUMBER(VALUE), 0)) RECV_ERR_PER_S,
            MAX(MAP(CAPTION, 'Transmit Error Rate', TO_NUMBER(VALUE), 0)) TRANS_ERR_PER_S
          FROM
            M_HOST_AGENT_METRICS
          WHERE
            MEASURED_ELEMENT_TYPE = 'NetworkPort'
          GROUP BY
            HOST,
            MEASURED_ELEMENT_NAME
        ) N
        WHERE
          RECV_PACK_PER_S >= 10 AND
          TRANS_PACK_PER_S >= 10
      )
      GROUP BY
        NAME
    )
    UNION ALL
    ( SELECT
        'ADMCTRL_EVENTS_RECENT',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        M_ADMISSION_CONTROL_EVENTS A
      WHERE
        A.EVENT_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.SHORTTERM_DAYS)
    )
    UNION ALL
    ( SELECT
        'ADMCTRL_REJECTS',
        '',
        TO_VARCHAR(SUM(GREATEST(L.ADMISSION_CONTROL_REJECT_COUNT, 0)))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
      WHERE
        L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
    )
    UNION ALL
    ( SELECT
        'ADMCTRL_TIMEOUT_REJECTS',
        '',
        TO_VARCHAR(SUM(TOTAL_TIMEOUT_COUNT))
      FROM
        M_ADMISSION_CONTROL_STATISTICS
    )
    UNION ALL
    ( SELECT
        'ADMCTRL_MAX_QUEUE_SIZE',
        '',
        TO_VARCHAR(MAX(GREATEST(ADMISSION_CONTROL_QUEUE_SIZE, 0)))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
      WHERE
        L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
    )
    UNION ALL
    ( SELECT
        'CS_TABLES_OLD_CTC',
        '',
        TO_VARCHAR(COUNT(DISTINCT(CT.SCHEMA_NAME || CT.TABLE_NAME)))
      FROM
        TEMP_TABLES T,
        TEMP_M_CS_TABLES CT
      WHERE
        ( T.TEMPORARY_TABLE_TYPE = 'NO LOGGING' OR T.IS_TEMPORARY != 'TRUE' ) AND
        CT.SCHEMA_NAME = T.SCHEMA_NAME AND
        CT.TABLE_NAME = T.TABLE_NAME AND
        DAYS_BETWEEN(CT.CREATE_TIME, CURRENT_TIMESTAMP) > 31 AND
        ( CT.LAST_TRUNCATION_TIME        IS NULL OR DAYS_BETWEEN(CT.LAST_TRUNCATION_TIME,        CURRENT_TIMESTAMP) > 31 ) AND
        ( CT.LAST_CONSISTENCY_CHECK_TIME IS NULL OR DAYS_BETWEEN(CT.LAST_CONSISTENCY_CHECK_TIME, CURRENT_TIMESTAMP) > 31 )
    )
    UNION ALL
    ( SELECT
        'CS_TABLES_CTC_ERRORS',
        '',
        TO_VARCHAR(COUNT(DISTINCT(CT.SCHEMA_NAME || CT.TABLE_NAME)))
      FROM
        TEMP_TABLES T,
        TEMP_M_CS_TABLES CT
      WHERE
        ( T.TEMPORARY_TABLE_TYPE = 'NO LOGGING' OR T.IS_TEMPORARY != 'TRUE' ) AND
        CT.SCHEMA_NAME = T.SCHEMA_NAME AND
        CT.TABLE_NAME = T.TABLE_NAME AND
        CT.LAST_CONSISTENCY_CHECK_ERROR_COUNT > 0
    )
    UNION ALL
    ( SELECT
        'ORPHAN_LOBS',
        '',
        TO_VARCHAR(IFNULL(SUM(L.LOB_COUNT - T.RECORD_COUNT), 0))
      FROM
        M_HOST_RESOURCE_UTILIZATION H LEFT OUTER JOIN
        TEMP_M_TABLE_LOB_STATISTICS L ON
          H.HOST = L.HOST INNER JOIN
        TEMP_M_TABLES T ON
          T.SCHEMA_NAME = L.SCHEMA_NAME AND
          T.TABLE_NAME = L.TABLE_NAME
      WHERE
        L.LOB_COUNT > T.RECORD_COUNT
    )
    UNION ALL
    ( SELECT
        L.LOB_TYPE || '_LOB_FRAGMENTATION',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(G.DATA_DISK_GB, 0, 0, L.FRAG_GB / G.DATA_DISK_GB * 100), 10, 2))
      FROM
        GENERAL_INFO G,
      ( SELECT
          T.LOB_TYPE,
          (SUM(DISK_SIZE) - SUM(BINARY_SIZE)) / 1024 / 1024 / 1024 FRAG_GB
        FROM
        ( SELECT 'FILE' LOB_TYPE FROM DUMMY UNION ALL
          SELECT 'PACKED'        FROM DUMMY
        ) T,
          TEMP_M_TABLE_LOB_STATISTICS L
        WHERE
          L.LOB_STORAGE_TYPE = T.LOB_TYPE
        GROUP BY
          T.LOB_TYPE
      ) L
    )
    UNION ALL
    ( SELECT
        'SMALL_DISK_LOBS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(ROUND(LOB_COUNT / 1000000), 10, 0) || CHAR(32) || 'Mio.)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          SUM(LOB_COUNT) LOB_COUNT
        FROM
          TEMP_M_TABLE_LOB_STATISTICS
        WHERE
          LOB_STORAGE_TYPE = 'FILE'
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          SUM(LOB_COUNT) > 10000000 AND
          MAP(SUM(LOB_COUNT), 0, 0, SUM(BINARY_SIZE) / SUM(LOB_COUNT) / 1024) < 4
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'MANY_DISK_LOBS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(ROUND(LOB_COUNT / 1000000), 10, 0) || CHAR(32) || 'Mio.)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          SUM(LOB_COUNT) LOB_COUNT
        FROM
          TEMP_M_TABLE_LOB_STATISTICS
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          SUM(LOB_COUNT) > 50000000
      ) ON
        1 = 1
    )
/* Available as of SAP HANA 2.00.030 */
    UNION ALL
    ( SELECT
        'COLUMNS_MANY_SCANNED_ROWS',
        '',
        IFNULL(TABLE_NAME || '.' || COLUMN_NAME || CHAR(32) || '(' || TO_DECIMAL(MAP(UPTIME_S, 0, 0, SCANNED_RECORDS / UPTIME_S / 1000000), 10, 0) || CHAR(32) || 'million/s)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT TOP 10
          CS.SCHEMA_NAME,
          CS.TABLE_NAME,
          CS.COLUMN_NAME,
          SUM(CS.SCANNED_RECORD_COUNT) SCANNED_RECORDS,
       /* MAX(SECONDS_BETWEEN(IFNULL(AC.LAST_LOAD_TIME, SS.START_TIME), CURRENT_TIMESTAMP)) UPTIME_S */
          MAX(SECONDS_BETWEEN(SS.START_TIME, CURRENT_TIMESTAMP)) UPTIME_S
        FROM
          TEMP_M_CS_ALL_COLUMN_STATISTICS CS,
          TEMP_M_CS_ALL_COLUMNS AC,
          M_SERVICE_STATISTICS SS
        WHERE
          CS.HOST = SS.HOST AND
          CS.PORT = SS.PORT AND
          AC.SCHEMA_NAME = CS.SCHEMA_NAME AND
          AC.TABLE_NAME = CS.TABLE_NAME AND
          AC.PART_ID = CS.PART_ID AND
          AC.COLUMN_NAME = CS.COLUMN_NAME AND
          AC.DISTINCT_COUNT >= 1000 AND
          ( AC.COMPRESSION_TYPE != 'DEFAULT' OR AC.INDEX_TYPE != 'FULL' ) /* exclude unjustified and wrong high values in some scenarios */
        GROUP BY
          CS.SCHEMA_NAME,
          CS.TABLE_NAME,
          CS.COLUMN_NAME
        ORDER BY
          SUM(CS.SCANNED_RECORD_COUNT) DESC
      ) ON
        MAP(UPTIME_S, 0, 0, SCANNED_RECORDS / UPTIME_S) >= 10000000
    )
    UNION ALL
    ( SELECT
        'CONCAT_ATTRIBUTES_UNUSED',
        '',
        IFNULL(TABLE_NAME || '.' || COLUMN_NAME || CHAR(32) || '(' || TO_DECIMAL(MEMORY_SIZE_IN_TOTAL / 1024 / 1024, 10, 0) || 'MB)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT TOP 10
          CS.TABLE_NAME,
          CS.COLUMN_NAME,
          SUM(C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL) MEMORY_SIZE_IN_TOTAL
        FROM
          TEMP_M_CS_ALL_COLUMN_STATISTICS CS,
          TEMP_M_CS_ALL_COLUMNS C
        WHERE
          CS.HOST = C.HOST AND
          CS.PORT = C.PORT AND
          CS.SCHEMA_NAME = C.SCHEMA_NAME AND
          CS.TABLE_NAME = C.TABLE_NAME AND
          CS.COLUMN_NAME = C.COLUMN_NAME AND
          CS.PART_ID = C.PART_ID AND
          C.INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE' AND C.COLUMN_NAME NOT LIKE '$uc%' AND
          CS.INDEX_LOOKUP_COUNT = 0
        GROUP BY
          CS.TABLE_NAME,
          CS.COLUMN_NAME
        HAVING
          SUM(C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL) > 1000 * 1024 * 1024
        ORDER BY
          3 DESC
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'CONNECTIONS_WITHOUT_APP_INFO',
        '',
        CASE
          WHEN CONNECTIONS <= 50 THEN 'n/a'
          ELSE TO_VARCHAR(TO_DECIMAL(MAP(CONNECTIONS, 0, 0, (CONNECTIONS - CONNECTIONS_WITH_APP_INFO) / CONNECTIONS * 100), 10, 2))
        END
      FROM
      ( SELECT
          COUNT(DISTINCT(C.HOST || C.CONNECTION_ID)) CONNECTIONS,
          SUM(MAP(SC.KEY, NULL, 0, 1)) CONNECTIONS_WITH_APP_INFO
        FROM
          M_CONNECTIONS C LEFT OUTER JOIN
          M_SESSION_CONTEXT SC ON
            SC.HOST = C.HOST AND
            SC.CONNECTION_ID = C.CONNECTION_ID AND
            SC.KEY = 'APPLICATION' AND
            SC.VALUE != ''
        WHERE
          C.CREATED_BY = 'Session' AND           /* exclude connections from more internal sources like 'DataProvisioning' */
          C.CONNECTION_ID > 0
      )
    )
    UNION ALL
    ( SELECT DISTINCT
        'PARAMETERS_REQUIRING_RESTART',
        '',
        IFNULL(P.KEY, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        M_CONFIGURATION_PARAMETER_VALUES P ON
          P.RESTART_REQUIRED = 'TRUE' AND
          P.KEY NOT IN ( 'gc_unused_memory_threshold_rel', 'max_gc_parallelity', 'tables_preloaded_in_parallel' )
    )
    UNION ALL
    ( SELECT DISTINCT
        'PARAMETERS_WRONG_VALUES',
        '',
        IFNULL(P.KEY || CHAR(32) || '=' || CHAR(32) || P.RAW_VALUE, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        M_CONFIGURATION_PARAMETER_VALUES P ON
          P.VIOLATED_RESTRICTIONS != '' AND
          P.KEY NOT IN ( 'environment', 'basepath_persistent_memory_volumes' )      /* can be set on SYSTEM level even if restriction only mentions HOST */
    )
    UNION ALL
    ( SELECT
        'OS_' || UPPER(REPLACE(L.KEY_FIGURE, '.', '_')),
        '',
        LTRIM(MIN(LPAD(VALUE, 30)))
      FROM
      ( SELECT 'async_io_limit' KEY_FIGURE    FROM DUMMY UNION ALL
        SELECT 'memory_map_area_limit'        FROM DUMMY UNION ALL
        SELECT 'net.core.somaxconn'           FROM DUMMY UNION ALL
        SELECT 'net.ipv4.tcp_max_syn_backlog' FROM DUMMY UNION ALL
        SELECT 'net_port_ephemeral_max_count' FROM DUMMY UNION ALL
        SELECT 'open_file_limit'              FROM DUMMY ) L,
        M_HOST_INFORMATION H
      WHERE
        H.KEY = L.KEY_FIGURE
      GROUP BY
        L.KEY_FIGURE
    )
    UNION ALL
    ( SELECT DISTINCT
        'EXPIRING_CERTIFICATES',
        '',
        IFNULL(PSE_NAME || CHAR(32) || '(' || DAYS_BETWEEN(CURRENT_TIMESTAMP, VALID_UNTIL) || CHAR(32) || 'days)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          PC.PSE_NAME,
          PC.VALID_UNTIL
        FROM
          PSE_CERTIFICATES PC,
          PSES P
        WHERE
          PC.PSE_NAME = P.NAME AND
          P.PURPOSE IS NOT NULL AND
          P.PURPOSE != 'NULL' AND
          PC.CERTIFICATE_USAGE IN ('CHAIN', 'OWN', 'TRUST') AND
          DAYS_BETWEEN(CURRENT_TIMESTAMP, PC.VALID_UNTIL) <= 30
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'ORPHAN_ALERT_32_ENTRY',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        _SYS_STATISTICS.STATISTICS_ALERT_INFORMATION
      WHERE
        ALERT_ID = 32
    )
    UNION ALL
    ( SELECT
        'ORPHAN_CALC_ESH_COLUMNS',
        '',
        TO_VARCHAR(COUNT(DISTINCT(SCHEMA_NAME || TABLE_NAME || COLUMN_NAME)))
      FROM
        TEMP_M_CS_ALL_COLUMNS
      WHERE
        COLUMN_NAME LIKE '$esh:ca%'
    )
    UNION ALL
    ( SELECT
        'MISSING_BACKUP_LOG',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TRACEFILES 
      WHERE 
        FILE_NAME LIKE 'backup%.log'
    )
    UNION ALL
    ( SELECT
        'CS_LOB_GARBAGE_COLLECTION',
        '',
        TO_VARCHAR(TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(MIN(START_TIME), CURRENT_TIMESTAMP)) / 86400, 10, 2))
      FROM
      ( SELECT
          LR.HOST,
          LR.PORT,
          MAX(START_TIME) START_TIME
        FROM
          M_SERVICES S,
          M_CS_LOB_SPACE_RECLAIMS LR
        WHERE
          LR.HOST = S.HOST AND
          LR.PORT = S.PORT
        GROUP BY
          LR.HOST, 
          LR.PORT
      )
    )
    UNION ALL
    ( SELECT
        'DATASHIPPING_LOGREPLAY',
        '',
        CASE WHEN NUM_LOGREPLAY >= 1 AND NUM_DATASHIPPING >= 1 THEN 'yes' ELSE 'no' END
      FROM
      ( SELECT
          SUM(CASE WHEN OPERATION_MODE LIKE 'logreplay%' THEN 1 ELSE 0 END) NUM_LOGREPLAY,
          SUM(CASE WHEN OPERATION_MODE = 'delta_datashipping' THEN 1 ELSE 0 END) NUM_DATASHIPPING
        FROM
          M_SYSTEM_REPLICATION
      )
    )
    UNION ALL
    ( SELECT
        'ROWTAB_MANY_SCANNED_ROWS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(MAP(UPTIME_S, 0, 0, SCANNED_RECORDS / UPTIME_S), 10, 0) || '/s)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          RS.SCHEMA_NAME,
          RS.TABLE_NAME,
          RS.SCAN_COUNT * RS.RECORD_COUNT SCANNED_RECORDS,
          SECONDS_BETWEEN(SS.START_TIME, CURRENT_TIMESTAMP) UPTIME_S
        FROM
          TEMP_M_RS_TABLES RS,
          M_SERVICE_STATISTICS SS
        WHERE
          RS.HOST = SS.HOST AND
          RS.PORT = SS.PORT
      ) ON
        MAP(UPTIME_S, 0, 0, SCANNED_RECORDS / UPTIME_S) >= 20000
    )
    UNION ALL
    ( SELECT
        'ROW_INDEXES_UNUSED',
        '',
        IFNULL(INDEX_NAME || CHAR(32) || '(' || TO_DECIMAL(INDEX_SIZE / 1024 / 1024, 10, 0) || CHAR(32) || 'MB)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        TEMP_M_RS_INDEXES ON
          INDEX_SIZE / 1024 / 1024 / 1024 >= 1 AND
          SEARCH_COUNT = 0 AND
          IS_UNIQUE != 'TRUE'
    )
    UNION ALL
    ( SELECT
        'MAX_HOURLY_COMMIT_TIME',
        HOST,
        TO_VARCHAR(MAX(AVG_DURATION_MS))
      FROM
      ( SELECT
          LP.HOST,
          TO_DECIMAL(MAP(SUM(LP.COMMIT_COUNT_DELTA), 0, 0, SUM(LP.SUM_COMMIT_IO_LATENCY_DELTA) / 1000 / SUM(LP.COMMIT_COUNT_DELTA)), 10, 2) AVG_DURATION_MS
        FROM
          BASIS_INFO BI,
          TEMP_HOST_LOG_PARTITIONS LP
        WHERE
          LP.SERVER_TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -86400 * BI.LONGTERM_DAYS)
        GROUP BY
          LP.HOST,
          TO_VARCHAR(LP.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'TRANS_TABLE_PERCENT',
        '',
        TO_VARCHAR(TO_DECIMAL(MAP(P.TRANSLATION_TABLE_MAX, 0, 0, J.TRANSLATION_TABLE_COUNT / P.TRANSLATION_TABLE_MAX * 100), 10, 2))
      FROM
        ( SELECT
            MAX(TRANSLATION_TABLE_COUNT) TRANSLATION_TABLE_COUNT
          FROM
            M_JOINENGINE_STATISTICS
        ) J,
        ( SELECT TOP 1
            VALUE TRANSLATION_TABLE_MAX
          FROM
            M_CONFIGURATION_PARAMETER_VALUES
          WHERE
            SECTION = 'joins' AND
            KEY = 'translator_cache_size'
          ORDER BY
            LPAD(VALUE, 20) DESC
        ) P
    )
    UNION ALL
    ( SELECT
        'HIGH_PLE_MEMORY_SHARE',
        H.HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(ALLOC_LIM_MB, 0, 0, PLE_MEM_MB / ALLOC_LIM_MB * 100), 10, 2))
      FROM
      ( SELECT
          IFNULL(HOST, '') HOST,
          IFNULL(SUM(MEMORY_SIZE / 1024 / 1024), 0) PLE_MEM_MB
        FROM
          DUMMY LEFT OUTER JOIN
          M_PLE_RUNTIME_OBJECTS ON
            1 = 1
        GROUP BY
          HOST
      ) M,
      ( SELECT
          HOST,
          ALLOCATION_LIMIT / 1024 / 1024 ALLOC_LIM_MB
        FROM
          M_HOST_RESOURCE_UTILIZATION
      ) H
      WHERE
        M.HOST = '' OR M.HOST = H.HOST
    )
    UNION ALL
    ( SELECT
        'DPAGENT_MEMORY_CONSUMPTION',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(MEM_PCT, 10, 2)), 'n/a')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT MAX(MAP(USED_PHYSICAL_MEMORY + FREE_PHYSICAL_MEMORY, 0, 0, USED_PHYSICAL_MEMORY / (USED_PHYSICAL_MEMORY + FREE_PHYSICAL_MEMORY) * 100)) MEM_PCT FROM M_AGENTS ) ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        'CALCULATION_SCENARIOS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_CE_CALCSCENARIOS_OVERVIEW
    )
    UNION ALL
    ( SELECT
        'TEMPORARY_VIEWS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TEMPORARY_VIEWS
    )
    UNION ALL
    ( SELECT
        'BACKUP_HISTORY_BROKEN',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(SECONDS_BETWEEN(MAX(SYS_TIME), CURRENT_TIMESTAMP) / 86400, 10, 2)), 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        M_BACKUP_HISTORY_BROKEN ON
          1 = 1
    )
    UNION ALL
    ( SELECT
        'JOB_QUEUEING_SHARE',
        '',
        TO_VARCHAR(TO_DECIMAL(SUM(MAP(T.CALLING, '', 1, 0)) / COUNT(*) * 100, 10, 2))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
      WHERE
        SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
        T.THREAD_STATE = 'Job Exec Waiting' AND
        T.THREAD_TYPE IN ('SqlExecutor', 'Request', 'WorkerThread (StatisticsServer)') AND
        T.THREAD_METHOD != 'WaitForBackupJobNode' AND
        T.STATEMENT_HASH NOT IN ('3192c20f2745437fda2c6325e0aa2dd3', '3b408dee6191595541ebbd7800f10c9b', '68590abdd6f75850b24472eaa7cb31a1', 'cb96ffe3c3e2b15c1a199f9a3e63dd16')     /* CHECK_TABLE_CONSISTENCY */
    )
    UNION ALL
    ( SELECT
        'MEMORY_PROFILER',
        '',
        MAP(IFNULL(STARTED, ''), 'X', 'yes', 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        ( SELECT TOP 1 'X' STARTED FROM M_MEMORY_PROFILER WHERE STATUS = 'STARTED' ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'MISSING_CONCATS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
      ( SELECT
          I.SCHEMA_NAME,
          I.TABLE_NAME,
          SUBSTR('$' || STRING_AGG(IC.COLUMN_NAME, '$' ORDER BY IC.POSITION) || '$', 1, 256)
        FROM
          TEMP_INDEXES I,
          TEMP_INDEX_COLUMNS IC
        WHERE
          I.SCHEMA_NAME = IC.SCHEMA_NAME AND 
          I.TABLE_NAME = IC.TABLE_NAME AND
          I.INDEX_NAME = IC.INDEX_NAME AND
          I.INDEX_TYPE IN ('INVERTED VALUE', 'INVERTED HASH') AND
          IC.CONSTRAINT IS NULL
        GROUP BY
          I.SCHEMA_NAME,
          I.TABLE_NAME,
          I.INDEX_NAME
        HAVING
          COUNT(*) >= 2
        MINUS
        SELECT
          C.SCHEMA_NAME,
          C.TABLE_NAME,
          SUBSTR(C.COLUMN_NAME, 1, 256)
        FROM
          TEMP_M_CS_ALL_COLUMNS C
        WHERE
          C.INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE'
      )
    )
    UNION ALL
    ( SELECT
        'OS_THP_ACTIVE',
        '',
        MAP(SUM(CNT), 0, 'no', 'yes')
      FROM
      ( SELECT
          COUNT(*) CNT
        FROM
          _SYS_STATISTICS.STATISTICS_ALERTS
        WHERE
          ALERT_ID = 116 AND
          ALERT_TIMESTAMP >= ADD_DAYS(CURRENT_TIMESTAMP, -1) AND
          ALERT_DETAILS LIKE 'Transparent Huge Pages (THP) are activated%'
        UNION ALL
        SELECT
          COUNT(*) CNT
        FROM
          M_HOST_INFORMATION
        WHERE
          KEY = 'kernel.transparent_hugepage.enabled' AND
          VALUE != 'always madvise [never]'
      )
    )
    UNION ALL
    ( SELECT
        'CTC_TAB_CONTAINER_LOAD',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        _SYS_STATISTICS.STATISTICS_PROPERTIES
      WHERE
        KEY = 'internal.table_consistency.check_actions' AND
        VALUE LIKE '%check_table_container%' AND
        VALUE NOT LIKE '%check_table_container_no_load%'
    )
    UNION ALL
    ( SELECT
        'DDLOG_SEQUENCE_USAGE',
        '',
        CASE WHEN MAX(D.DATA_TYPE) = 'BIGINT' AND MIN(S.MAX_VALUE) >= 9000000000000000000 THEN 'n/a' ELSE TO_VARCHAR(TO_DECIMAL(GREATEST(0, MAX(MS.CURRENT_VALUE) / 2147483648 * 100), 10, 2)) END                          
      FROM
      ( SELECT MAX(DATA_TYPE_NAME) DATA_TYPE FROM TABLE_COLUMNS WHERE TABLE_NAME = 'DDLOG' AND COLUMN_NAME = 'SEQNUMBER' ) D LEFT OUTER JOIN
        M_SEQUENCES MS ON
          MS.SEQUENCE_NAME = 'DDLOG_SEQ' LEFT OUTER JOIN
        SEQUENCES S ON
          S.SEQUENCE_NAME = 'DDLOG_SEQ'
    )
    UNION ALL
    ( SELECT
        'SLT_TRIGGER_SUBSTRING',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TRIGGERS
      WHERE
        UPPER(DEFINITION) LIKE '%SUBSTRING ( HASH_SHA256 ( TO_BINARY (%'
    )
    UNION ALL
    ( SELECT
        'NULL_STATEMENT_HINTS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        STATEMENT_HINTS
      WHERE
        HINT_STRING IS NULL OR HINT_STRING = 'null'
    )
    UNION ALL
    ( SELECT
        'STAT_SERVER_DDL_STATEMENTS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        BASIS_INFO BI,
        M_EXECUTED_STATEMENTS ES
      WHERE
        SECONDS_BETWEEN(ES.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS AND
        ES.DB_USER = '_SYS_STATISTICS'
    )
    UNION ALL
    ( SELECT
        'INCONSISTENT_NUMA_NODES',
        '',
        CASE
          WHEN SUM(MAP(H.NODES, N.NODES, 0, 1)) = 0           THEN 'no'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%GOOGLE%'         THEN 'n/a'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%HVM%'            THEN 'n/a'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%HYPERV%'         THEN 'n/a'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%KVM%'            THEN 'n/a'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%VMWARE%'         THEN 'n/a'
          WHEN UPPER(MAX(M.HW_MODEL)) LIKE '%XEN%'            THEN 'n/a'
          WHEN UPPER(MAX(O.OS_PPMS_NAME)) LIKE 'LINUX_PPC64%' THEN 'n/a'
          ELSE                                                     'yes'
        END
      FROM
      ( SELECT HOST, VALUE HW_MODEL FROM M_HOST_INFORMATION WHERE KEY = 'hw_model' ) M,
      ( SELECT HOST, VALUE NODES FROM M_HOST_INFORMATION WHERE KEY = 'cpu_sockets' ) H,
      ( SELECT HOST, VALUE OS_PPMS_NAME FROM M_HOST_INFORMATION WHERE KEY = 'os_ppms_name' ) O,
      ( SELECT HOST, MAX(NODES) NODES FROM ( SELECT HOST, PORT, COUNT(*) NODES FROM M_NUMA_NODES WHERE ACTIVE_LOGICAL_CORE_COUNT > 0 OR MEMORY_SIZE > 0 GROUP BY HOST, PORT ) GROUP BY HOST ) N
      WHERE
        M.HOST = H.HOST AND
        H.HOST = N.HOST
    )
    UNION ALL
    ( SELECT
        'VARYING_NUMA_NODES',
        HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(MIN(LOGICAL_CORES), 0, 999, ( MAX(LOGICAL_CORES) / MIN(LOGICAL_CORES) - 1 ) * 100), 10, 0))
      FROM
      ( SELECT
          HOST,
          NUMA_NODE_ID,
          MAX(LOGICAL_CORES) LOGICAL_CORES
        FROM
        ( SELECT
            HOST,
            PORT,
            NUMA_NODE_ID,
            SUM(ACTIVE_LOGICAL_CORE_COUNT) LOGICAL_CORES
          FROM
            M_NUMA_NODES
          WHERE
            ACTIVE_LOGICAL_CORE_COUNT > 0 OR MEMORY_SIZE > 0
          GROUP BY
            HOST,
            PORT,
            NUMA_NODE_ID
        )
        GROUP BY
          HOST,
          NUMA_NODE_ID
      )
      GROUP BY
        HOST
    )
    UNION ALL
    ( SELECT
        'HARD_FORCED_MERGES',
        '',
        TO_VARCHAR(TO_DECIMAL(IFNULL(SUM(M.EXECUTION_TIME), 0) / 1000 / BI.MIDTERM_DAYS, 10, 0))
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS M ON
          SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= 86400 * BI.MIDTERM_DAYS AND
          M.MOTIVATION IN ('HARD', 'FORCED') AND
          M.TYPE IN ('MERGE', 'SPARSE')
      GROUP BY
        BI.MIDTERM_DAYS
    )
    UNION ALL
    ( SELECT
        'PAGED_COLUMNS_WITH_OLD_PERS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_ALL_COLUMNS C,
        TEMP_M_CS_COLUMNS_PERSISTENCE CP
      WHERE
        C.SCHEMA_NAME = CP.SCHEMA_NAME AND
        C.TABLE_NAME = CP.TABLE_NAME AND
        C.PART_ID = CP.PART_ID AND
        C.COLUMN_NAME = CP.COLUMN_NAME AND
        C.LOAD_UNIT = 'PAGE' AND
        CP.PERSISTENCE_TYPE IN ( 'VIRTUAL_PAGED', 'VIRTUAL_FILE' )
    )
    UNION ALL
    ( SELECT
        'ORPHAN_UNIQUE_CONCATS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_M_CS_ALL_COLUMNS AC
      WHERE
        AC.INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE' AND
        AC.COLUMN_NAME LIKE '$uc%$' AND
        NOT EXISTS
        ( SELECT 1 FROM CONSTRAINTS C WHERE '$uc_' || C.CONSTRAINT_NAME|| '$' = AC.COLUMN_NAME )
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_INVALIDATION',
        '',
        CASE
          WHEN TOTAL_PLAN_SIZE <= 1024 * 1024 *1024 THEN 'n/a'
          ELSE MAP(LAST_INVALIDATION_REASON, NULL, 'none', LAST_INVALIDATION_REASON || CHAR(32) || '(' || TO_DECIMAL(PLAN_PCT, 10, 2) || CHAR(32) || '%)')
        END
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          TOTAL_PLAN_SIZE,
          LAST_INVALIDATION_REASON,
          MAP(TOTAL_PLAN_SIZE, 0, 0, SUM(PLAN_MEMORY_SIZE) / TOTAL_PLAN_SIZE * 100) PLAN_PCT
        FROM
        ( SELECT
            CASE 
              WHEN LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH'
              WHEN LAST_INVALIDATION_REASON LIKE 'NON-USER-OID NOT FOUND%'  THEN 'NON-USER-OID NOT FOUND'
              ELSE LAST_INVALIDATION_REASON
            END LAST_INVALIDATION_REASON,
            PLAN_MEMORY_SIZE,
            IS_VALID,
            SUM(PLAN_MEMORY_SIZE) OVER () TOTAL_PLAN_SIZE
          FROM
            TEMP_M_SQL_PLAN_CACHE
        )
        WHERE
          IS_VALID = 'FALSE'
        GROUP BY
          LAST_INVALIDATION_REASON,
          TOTAL_PLAN_SIZE
      ) ON
        PLAN_PCT >= 10
    )
    UNION ALL
    ( SELECT
        'BACKUP_CANCEL_PENDING',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_BACKUP_PROGRESS
      WHERE
        STATE_NAME = 'cancel pending'
    )
    UNION ALL
    ( SELECT
        'WORKLOAD_CLASS_THREAD_LIMIT',
        '',
        CASE WHEN THREAD_LIMIT IS NULL OR THREAD_LIMIT <= MAX_CONCURRENCY THEN 'no' ELSE 'yes' || CHAR(32) || '(' || THREAD_LIMIT || CHAR(32) || '>' || CHAR(32) || MAX_CONCURRENCY || ')' END
      FROM
      ( SELECT MAX(MAX_CONCURRENCY_CONFIG) MAX_CONCURRENCY FROM M_JOBEXECUTORS ) J LEFT OUTER JOIN
      ( SELECT GREATEST(MAX(STATEMENT_THREAD_LIMIT), MAX(TOTAL_STATEMENT_THREAD_LIMIT)) THREAD_LIMIT FROM WORKLOAD_CLASSES ) C ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'LARGE_ALLOCATION_SHARE',
        '',
        IFNULL(CATEGORY || CHAR(32) || '(' || TO_DECIMAL(MAP(TOTAL_ALLOCATED_SIZE, 0, 0, ALLOCATED_SIZE / TOTAL_ALLOCATED_SIZE * 100), 10, 0) || CHAR(32) || '%)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          CATEGORY,
          SUM(EXCLUSIVE_ALLOCATED_SIZE) ALLOCATED_SIZE,
          SUM(SUM(EXCLUSIVE_ALLOCATED_SIZE)) OVER () TOTAL_ALLOCATED_SIZE
        FROM
          M_HEAP_MEMORY
        GROUP BY
          CATEGORY
      ) ON
        ( ALLOCATED_SIZE >= TOTAL_ALLOCATED_SIZE * 0.6 OR
          CATEGORY != 'Pool/RowEngine/Session' AND ALLOCATED_SIZE >= TOTAL_ALLOCATED_SIZE * 0.3 )
    )
    UNION ALL
    ( SELECT
        'OUTDATED_CLIENT_VERSION',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        ( SELECT LPAD(FLOOR(REVISION / 10), 2, '0') SPS FROM GENERAL_INFO ) G,
        M_SESSION_CONTEXT SC
      WHERE
        SC.KEY = 'DRIVERVERSION' AND
        SC.VALUE LIKE '_.%.%' AND
         G.SPS > LPAD(SUBSTR(SC.VALUE, 3, LOCATE(SC.VALUE, '.', 1, 2) - 3), 2, '0')
    )
    UNION ALL
    ( SELECT
        'PAGED_LOB_COLUMNS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TEMP_TABLE_COLUMNS
      WHERE
        DATA_TYPE_NAME IN ( 'BLOB', 'CLOB', 'NCLOB', 'TEXT' ) AND
        LOAD_UNIT = 'PAGE'
    )
    UNION ALL
    ( SELECT
        'LOW_DYNAMIC_CONCURRENCY',
        J.HOST,
        CASE
          WHEN MIN(J.MAX_CONCURRENCY / J.MAX_CONCURRENCY_CONFIG) < 0.3 THEN 
            'yes (dynamic reduction to' || CHAR(32) || TO_DECIMAL(MIN(J.MAX_CONCURRENCY / J.MAX_CONCURRENCY_CONFIG) * 100, 10, 0) || CHAR(32) || '%)'
          WHEN MIN(J.MAX_CONCURRENCY / J.MAX_CONCURRENCY_CONFIG) < 0.8 AND MAX(J.MAX_CONCURRENCY_CONFIG - J.MAX_CONCURRENCY) > 1.5 * MAX(CONC_REDUCTION) THEN
            'yes (dynamic reduction by factor' || CHAR(32) || TO_DECIMAL(MAX(J.MAX_CONCURRENCY_CONFIG - J.MAX_CONCURRENCY) / MAX(CONC_REDUCTION), 10, 2) || CHAR(32) || 'too high)'
          ELSE 'no'
        END
      FROM
      ( SELECT
          HOST,
          SUM(MAP(THREAD_STATE, 'Running', 1, 0.4)) CONC_REDUCTION
        FROM
          M_SERVICE_THREADS
        WHERE
          (THREAD_TYPE, THREAD_STATE) NOT IN (('JobWorker', 'Running')) AND
          THREAD_STATE != 'Job Exec Waiting' AND
          IS_ACTIVE = 'TRUE'
        GROUP BY
          HOST
       ) T,
         M_JOBEXECUTORS J
       WHERE
         J.HOST = T.HOST
       GROUP BY
         J.HOST
    )
    UNION ALL
    ( SELECT
        'CONVERTER_PAGE_NUMBER',
        '',
        TO_VARCHAR(MAX(MAX_PAGENUMBER))
      FROM
        M_CONVERTER_STATISTICS
      WHERE
        TYPE = 'DefaultConverter'
    )
    UNION ALL
    ( SELECT
        'OS_OPEN_FILES_PEAK',
        '',
        TO_VARCHAR(MAX(HANDLE_COUNT))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
      WHERE
        SECONDS_BETWEEN(L.TIME, CURRENT_TIMESTAMP) <= BI.MIDTERM_DAYS * 86400
    )
    UNION ALL
    ( SELECT
        'CPU_DISCREPANCY',
        '',
        MAX(MAP(HI.CPU_THREADS, HA.CPU_THREADS, 'no', 'yes (' || HI.CPU_THREADS || CHAR(32) || 'vs.' || CHAR(32) || HA.CPU_THREADS || ')'))
      FROM
      ( SELECT HOST, VALUE CPU_THREADS FROM M_HOST_INFORMATION WHERE KEY = 'cpu_threads' ) HI,
      ( SELECT HOST, VALUE CPU_THREADS FROM M_HOST_AGENT_METRICS WHERE DEFINITION_ID = 'OS.CPUCount' ) HA
      WHERE
        HI.HOST = HA.HOST
    )
    UNION ALL
    ( SELECT
        'TRACE_COMPONENTS_PER_SERVICE',
        '',
        TO_VARCHAR(MAX(CNT))
      FROM
      ( SELECT
          COUNT(*) CNT
        FROM
          M_SERVICE_TRACES
        GROUP BY
          SERVICE_NAME
      )
    )
    UNION ALL
    ( SELECT
        'TABLES_MANY_EMPTY_PARTITIONS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || ZERO_PARTS || '/' || TOTAL_PARTS || ')', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          SUM(MAP(RECORD_COUNT, 0, 1, 0)) ZERO_PARTS,
          COUNT(*) TOTAL_PARTS
        FROM
          TEMP_M_CS_TABLES
        WHERE
          ( TABLE_NAME NOT LIKE '/B%/%' OR TABLE_NAME LIKE '/BA1/%' ) AND
          TABLE_NAME NOT LIKE '_SYS_OMR%'
        GROUP BY
          SCHEMA_NAME,
          TABLE_NAME
        HAVING
          SUM(RECORD_COUNT) > 1000000 AND
          COUNT(*) >= 9
      ) ON
        ZERO_PARTS >= 0.3 * TOTAL_PARTS
    )
    UNION ALL
    ( SELECT
        'SDI_QUEUED_SUBSCRIPTIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_REMOTE_SUBSCRIPTIONS
      WHERE
        STATE NOT IN ('CREATED', 'APPLY_CHANGE_DATA') AND
        BEGIN_MARKER_TIME <= ADD_SECONDS(CURRENT_TIMESTAMP, -86400) AND
        END_MARKER_TIME IS NULL
    )
    UNION ALL
    ( SELECT
        'DPSERVER_DISK_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(SUM(V.USED_SIZE / 1024 / 1024 / 1024), 10, 2))
      FROM
        DUMMY LEFT OUTER JOIN
        M_SERVICES S ON
          S.SERVICE_NAME = 'dpserver' INNER JOIN
        M_VOLUME_FILES V ON
          S.PORT = V.PORT AND
          V.FILE_TYPE = 'DATA'
    )
    UNION ALL
    ( SELECT
        'HOT_NUMA_NODES_RECENT',
        IFNULL(D.HOST, ''),
        IFNULL(D.NUMA_NODE_INDEX || CHAR(32) || '(' || UTILIZATION_PCT || CHAR(32) || '%)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          N.HOST,
          N.NUMA_NODE_INDEX,
          TO_DECIMAL(MAP(N.LOGICAL_CORES, 0, 0, T.AVG_ACT_THREADS / N.LOGICAL_CORES * 100), 10, 2) UTILIZATION_PCT
        FROM
        ( SELECT
            HOST,
            NUMA_NODE_INDEX,
            MAX(ACTIVE_LOGICAL_CORE_COUNT) LOGICAL_CORES
          FROM
            M_NUMA_NODES
          GROUP BY
            HOST,
            NUMA_NODE_INDEX
        ) N,
        ( SELECT
            T.HOST,
            T.NUMA_NODE_INDEX,
            COUNT(*) * GI.THREAD_SAMPLES_FILTER_FACTOR / BI.SHORTTERM_DAYS / 86400 AVG_ACT_THREADS
          FROM
            BASIS_INFO BI,
            GENERAL_INFO GI,
            _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
          WHERE
            T.THREAD_STATE = 'Running' AND
            SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
          GROUP BY
            T.HOST,
            T.NUMA_NODE_INDEX,
            GI.THREAD_SAMPLES_FILTER_FACTOR,
            BI.SHORTTERM_DAYS
        ) T
        WHERE
          N.HOST = T.HOST AND
          N.NUMA_NODE_INDEX = T.NUMA_NODE_INDEX AND
          T.AVG_ACT_THREADS >= 0.5 * N.LOGICAL_CORES
      ) D ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'ESS_WORKLOAD_CLASS_USED',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        WORKLOAD_MAPPINGS
      WHERE
        USER_NAME = '_SYS_STATISTICS'
    )
    UNION ALL
    ( SELECT
       'BW_COLUMN_VIEWS_PER_OBJECT',
        '',
        IFNULL(BW_OBJECT_NAME || CHAR(32) || '(' || VIEWS || CHAR(32) || 'views)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT 
          SUBSTR_REGEXPR('[^:]+' IN "VIEW_NAME" OCCURRENCE CASE WHEN VIEW_NAME LIKE '%:%:___:%' THEN 4 ELSE 3 END ) BW_OBJECT_NAME,
          COUNT(*) VIEWS
        FROM
          VIEWS
        WHERE
          VIEW_NAME LIKE '0BW:BIA%' AND
          VIEW_NAME NOT LIKE '%:%:%:%:%'
        GROUP BY
          SUBSTR_REGEXPR('[^:]+' IN "VIEW_NAME" OCCURRENCE CASE WHEN VIEW_NAME LIKE '%:%:___:%' THEN 4 ELSE 3 END )
        HAVING
          COUNT(*) >= 100
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'SERIALIZABLE_TRANSACTIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TRANSACTIONS T,
        M_CONNECTIONS C
      WHERE
        C.HOST = T.HOST AND
        C.PORT = T.PORT AND
        C.CONNECTION_ID = T.CONNECTION_ID AND
        T.ISOLATION_LEVEL = 'SERIALIZABLE' AND
        C.CREATED_BY != 'Repository'          /* repository uses serializable transactions */
    )
    UNION ALL
    ( SELECT
        'SQLSCRIPT_PLAN_PROFILER',
        '',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_SQLSCRIPT_PLAN_PROFILERS
    )
    UNION ALL
    ( SELECT
        'ORPHAN_DPSERVER_SERVICE',
        '',
        CASE WHEN NUM_DPSERVERS > 0 AND NUM_AGENTS = 0 THEN 'yes' ELSE 'no' END
      FROM
      ( SELECT COUNT(*) NUM_DPSERVERS FROM M_SERVICES WHERE SERVICE_NAME = 'dpserver' ) D,
      ( SELECT COUNT(*) NUM_AGENTS FROM M_AGENTS )
    )
    UNION ALL
    ( SELECT
        'ORPHAN_DOCSTORE_SERVICE',
        '',
        CASE WHEN NUM_DOCSTORE_SERVICES > 0 AND NUM_COLLECTIONS = 0 THEN 'yes' ELSE 'no' END
      FROM
      ( SELECT COUNT(*) NUM_DOCSTORE_SERVICES FROM M_SERVICES WHERE SERVICE_NAME = 'docstore' ) D,
      ( SELECT COUNT(*) NUM_COLLECTIONS FROM M_COLLECTION_TABLES )
    )
    UNION ALL
    ( SELECT
        'NSE_BUFFER_RATIO',
        W.HOST,
        TO_VARCHAR(TO_DECIMAL(W.WARM_GB / B.BUFFER_GB, 10, 2))
      FROM
      ( SELECT HOST, SUM(MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE) / 1024 / 1024 / 1024 WARM_GB FROM TEMP_M_CS_COLUMNS_PERSISTENCE GROUP BY HOST ) W,
      ( SELECT HOST, MAX(MAX_SIZE) / 1024 / 1024 / 1024 BUFFER_GB FROM M_BUFFER_CACHE_STATISTICS GROUP BY HOST HAVING MAX(MAX_SIZE) > 0 ) B
      WHERE
        B.HOST = W.HOST
    )
    UNION ALL
    ( SELECT TOP 5
        'LONG_OPTIMIZATION_LOCKS',
        '',
        IFNULL(M.TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL((M.PHASE_1_LOCK_TIME + M.PHASE_2_LOCK_TIME) / 1000, 10, 0) || CHAR(32) || 's, ' || 
          TO_VARCHAR(M.START_TIME, 'YYYY/MM/DD HH24:MI:SS') || ')', 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS M ON
          SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= BI.MIDTERM_DAYS * 86400 AND
          ( M.PHASE_1_LOCK_TIME >= 60000 OR M.PHASE_2_LOCK_TIME >= 60000 )
      ORDER BY
        M.PHASE_1_LOCK_TIME + M.PHASE_2_LOCK_TIME DESC
    )
    UNION ALL
    ( SELECT
        'NSE_OUT_OF_BUFFER_COUNT',
        '',
        TO_VARCHAR(SUM(OUT_OF_BUFFER_COUNT))
      FROM
        M_BUFFER_CACHE_POOL_STATISTICS_RESET
    )
    UNION ALL
    ( SELECT
        'SLT_TEMP_TRIGGERS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TRIGGERS
      WHERE
        TRIGGER_NAME LIKE '/1LT/%TM_' OR TRIGGER_NAME LIKE '/1LT/%TM__'
    )
    UNION ALL
    ( SELECT
        'TEMPORARY_BW_TABLES_HANA',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TEMPORARY_TABLES
      WHERE
        TABLE_NAME LIKE '0BW:BIA%'
    )
    UNION ALL
    ( SELECT
        'SQL_CACHE_RETENTION',
        '',
        TO_VARCHAR(TO_DECIMAL(MIN(EVICTED_PLAN_AVG_CACHE_TIME / 3600 / 1000000), 10, 2))
      FROM
        M_SERVICES S,
        M_SQL_PLAN_CACHE_OVERVIEW SP
      WHERE
        S.HOST = SP.HOST AND
        S.PORT = SP.PORT AND
        SP.EVICTED_PLAN_COUNT > 10000
    )
    UNION ALL
    ( SELECT
        'OLDEST_CURRENT_SAVEPOINT', 
        '',
        TO_VARCHAR(IFNULL(GREATEST(0, MAX(SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP))), 0))
      FROM
        DUMMY LEFT OUTER JOIN
        M_SAVEPOINTS ON
          STATE != 'DONE'
    )
    UNION ALL
    ( SELECT
        'TEMP_TABLE_SIZE_SHARE',
        '',
        TO_VARCHAR(TO_DECIMAL(IFNULL(SUM(TT.TABLE_SIZE) / 1024 / 1024 / 1024, 0) / MAX(GI.ALLOC_LIM_GB) * 100, 10, 2))
      FROM
        GENERAL_INFO GI,
        M_TEMPORARY_TABLES TT
    )
    UNION ALL
    ( SELECT TOP 10
        'TEMP_TABLE_RECORDS',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(RECORD_COUNT / 1000000, 10, 2) || CHAR(32) || 'Mio.)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        M_TEMPORARY_TABLES ON
          RECORD_COUNT > 2000000 AND
          SUBSTR(TABLE_NAME, 1, 9) != '#_SYS_QO_'
      ORDER BY
        RECORD_COUNT DESC
    )
    UNION ALL
    ( SELECT
        'SPECIAL_UNLOAD_PRIORITY',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        TABLES
      WHERE
        IS_COLUMN_TABLE = 'TRUE' AND
        IS_TEMPORARY = 'FALSE' AND
        SUBSTR(SCHEMA_NAME, 1, 5) != '_SYS_' AND
        SUBSTR(SCHEMA_NAME, 1, 6) != 'SAP_XS' AND
        SCHEMA_NAME NOT IN ( 'SYS' , 'SYSTEM' ) AND
        ( UNLOAD_PRIORITY != 5 AND
          ( TABLE_NAME LIKE '/BA1/%' OR
            ( TABLE_NAME NOT LIKE 'RSPM%' AND 
              TABLE_NAME NOT LIKE 'ZBICZ%' AND
              TABLE_NAME NOT LIKE '0BW:BIA%' AND
              TABLE_NAME NOT LIKE '$BPC$HC$%' AND
              TABLE_NAME NOT LIKE '$BPC$TMP%' AND
              TABLE_NAME NOT LIKE '/B%/%' AND
              TABLE_NAME NOT LIKE '/1B0/%' AND
              TABLE_NAME NOT LIKE '/1DD/%' AND
              SUBSTR(TABLE_NAME, 1, 3) != 'TR_'
            )
          ) OR
          UNLOAD_PRIORITY NOT IN (5, 7) AND
          ( TABLE_NAME NOT LIKE '/BA1/%' AND
            ( TABLE_NAME LIKE 'RSPM%' OR 
              TABLE_NAME LIKE 'ZBICZ%' OR
              TABLE_NAME LIKE '0BW:BIA%' OR
              TABLE_NAME LIKE '$BPC$HC$%' OR
              TABLE_NAME LIKE '$BPC$TMP%' OR
              TABLE_NAME LIKE '/B%/%' OR
              TABLE_NAME LIKE '/1B0/%' OR
              TABLE_NAME LIKE '/1DD/%' OR
              SUBSTR(TABLE_NAME, 1, 3) = 'TR_'
            )
          )
        )
    )
    UNION ALL
    ( SELECT TOP 10
        'MANY_DEPENDENT_OBJECTS',
        '',
        IFNULL(BASE_OBJECT_NAME || CHAR(32) || '(' || CNT || CHAR(32) || 'dep.)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          BASE_OBJECT_NAME,
          COUNT(*) CNT
        FROM
          TEMP_OBJECT_DEPENDENCIES
        GROUP BY
          BASE_OBJECT_NAME
        HAVING
          COUNT(*) >= 50000
      ) OD ON
        1 = 1
      ORDER BY
        CNT DESC
    )
    UNION ALL
    ( SELECT
        'CALLSTACK_HISTORY_INACTIVE',
        '',
        MAP(STATUS, 'Inactive', 'yes', 'no')
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        ID = 5057
    )
    UNION ALL
    ( SELECT
        'SDA_CONNECTIONS',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_REMOTE_CONNECTIONS
    )
    UNION ALL
    ( SELECT
        'CONNECTION_REQUEST_RATE',
        '',
        TO_VARCHAR(TO_DECIMAL(COUNT(*) / 1800, 10, 2))
      FROM
        TEMP_M_CONNECTIONS
      WHERE
        START_TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -1800) AND
        CONNECTION_TYPE LIKE '%Remote%'
    )
    UNION ALL
    ( SELECT
        'LARGE_VARBINARY_COLUMNS',
        '',
        IFNULL(TABLE_NAME || '.' || COLUMN_NAME || CHAR(32) || '('  || SIZE_GB || CHAR(32) || 'GB)', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          TC.TABLE_NAME,
          TC.COLUMN_NAME,
          TO_DECIMAL(ROUND(SUM(AC.MEMORY_SIZE_IN_TOTAL + AC.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024)) SIZE_GB
        FROM
          TEMP_TABLE_COLUMNS TC,
          TEMP_M_CS_ALL_COLUMNS AC
        WHERE
          TC.DATA_TYPE_NAME = 'VARBINARY' AND
          TC.SCHEMA_NAME = AC.SCHEMA_NAME AND
          TC.TABLE_NAME = AC.TABLE_NAME AND
          TC.COLUMN_NAME = AC.COLUMN_NAME
        GROUP BY
          TC.SCHEMA_NAME,
          TC.TABLE_NAME,
          TC.COLUMN_NAME
        HAVING
          SUM(AC.MEMORY_SIZE_IN_TOTAL + AC.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 >= 50 AND
          SUM(AC.MEMORY_SIZE_IN_TOTAL + AC.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 > SUM(AC.COUNT)
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'SDA_SAFE_MODE',
        '',
        CASE 
          WHEN S.SDA_SOURCES = 0 THEN 'n/a'
          WHEN S.SDA_SOURCES > 0 AND SAFE_MODE_ACTIVE = 0 THEN 'yes'
          ELSE 'no'
        END
      FROM
      ( SELECT 
          COUNT(*) SDA_SOURCES 
        FROM 
          REMOTE_SOURCES 
        WHERE
          LOCATION IN ( 'indexserver', 'scriptserver' ) AND
          REMOTE_SOURCE_NAME NOT LIKE '_SYS_SR_SITE%' AND
          ADAPTER_NAME NOT IN ( 'hanaodbc', 'iqodbc' ) AND
          ( ADAPTER_NAME LIKE '%odbc%' OR
            LOWER(ADAPTER_NAME) LIKE '%oracle%' OR
            LOWER(ADAPTER_NAME) LIKE '%mssql%' OR
            LOWER(ADAPTER_NAME) LIKE '%db2%'
          )
      ) S,
      ( SELECT 
          COUNT(*) SAFE_MODE_ACTIVE 
        FROM 
          M_CONFIGURATION_PARAMETER_VALUES 
        WHERE 
          FILE_NAME = 'indexserver.ini' AND 
          SECTION = 'smart_data_access' AND
          KEY = 'odbc_adapters_in_scriptserver' AND
          UPPER(VALUE) = 'ALL'
      )
    )
    UNION ALL
    ( SELECT
        'TABLE_SIZE_RETENTION',
        '',
        TO_VARCHAR(MIN(IFNULL(RETENTION_DAYS_CURRENT, RETENTION_DAYS_DEFAULT)))
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE
      WHERE
        ID = 5010
    )
    UNION ALL
    ( SELECT
        'HIGH_THREADS_CONC_LIMIT',
        '',
        CASE
          WHEN TS.STL_MAX <= J.MAX_CONCURRENCY / 2 THEN 'no'
          ELSE 'yes (' || STL_MAX || ' of ' || MAX_CONCURRENCY || ')'
        END
      FROM
      ( SELECT
          MAX(STATEMENT_THREAD_LIMIT) STL_MAX
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES TS
        WHERE
          SECONDS_BETWEEN(TS.TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.SHORTTERM_DAYS
      ) TS,
      ( SELECT MAX(MAX_CONCURRENCY_CONFIG) MAX_CONCURRENCY FROM M_JOBEXECUTORS ) J
    )
    UNION ALL
    ( SELECT
        'SDI_PERSISTENCE_SIZE',
        '',
        TO_VARCHAR(TO_DECIMAL(IFNULL(SUM(SIZE), 0) / 1024 / 1024 / 1024, 10, 2))
      FROM
        REMOTE_SUBSCRIPTION_DATA_CONTAINERS
    )
    UNION ALL
    ( SELECT
        'SQL_ENGINE_REGRESSIONS',
        '',
        IFNULL(DETAILS, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT TOP 5
          IFNULL(STATEMENT_HASH || CHAR(32) || '(' || 
            MAX_ENGINES || CHAR(32) || CASE WHEN MAX_TIME_PER_EXEC_MS >= 1000 THEN ROUND(TO_DECIMAL(MAX_TIME_PER_EXEC_MS / 1000)) ELSE ROUND(TO_DECIMAL(MAX_TIME_PER_EXEC_MS)) END || CHAR(32) ||
            CASE WHEN MAX_TIME_PER_EXEC_MS >= 1000 THEN 's' ELSE 'ms' END || 
            CHAR(32) || 'vs.' || CHAR(32) ||
            MIN_ENGINES || CHAR(32) || CASE WHEN MIN_TIME_PER_EXEC_MS >= 1000 THEN ROUND(TO_DECIMAL(MIN_TIME_PER_EXEC_MS / 1000)) ELSE ROUND(TO_DECIMAL(MIN_TIME_PER_EXEC_MS)) END || CHAR(32) || 
            CASE WHEN MIN_TIME_PER_EXEC_MS >= 1000 THEN 's' ELSE 'ms' END || 
            ')', 'none') DETAILS
        FROM
        ( SELECT DISTINCT
            STATEMENT_HASH,
            FIRST_VALUE(ENGINES) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS) MIN_ENGINES,
            FIRST_VALUE(ENGINES) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS DESC) MAX_ENGINES,
            MIN(TIME_PER_EXEC_MS) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS) MIN_TIME_PER_EXEC_MS,
            MAX(TIME_PER_EXEC_MS) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS DESC) MAX_TIME_PER_EXEC_MS,
            FIRST_VALUE(ROWS_PER_EXEC) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS) MIN_ROWS_PER_EXEC,
            FIRST_VALUE(ROWS_PER_EXEC) OVER (PARTITION BY STATEMENT_HASH ORDER BY TIME_PER_EXEC_MS DESC) MAX_ROWS_PER_EXEC,
            SUM(TOTAL_TIME_MS) OVER (PARTITION BY STATEMENT_HASH) TOTAL_TIME_MS
          FROM
          ( SELECT
              STATEMENT_HASH,
              CASE WHEN EXECUTION_ENGINE LIKE '%COLUMN%' THEN 'C' ELSE '' END || 
                CASE WHEN EXECUTION_ENGINE LIKE '%ESX%' THEN 'E' ELSE '' END ||
                CASE WHEN EXECUTION_ENGINE LIKE '%HEX%' THEN 'H' ELSE '' END || 
                CASE WHEN EXECUTION_ENGINE LIKE '%OLAP%' THEN 'O' ELSE '' END ||
                CASE WHEN EXECUTION_ENGINE LIKE '%ROW%' THEN 'R' ELSE '' END ENGINES,
              SUM(TOTAL_EXECUTION_TIME) / SUM(EXECUTION_COUNT) / 1000 TIME_PER_EXEC_MS,
              SUM(TOTAL_RESULT_RECORD_COUNT) / SUM(EXECUTION_COUNT) ROWS_PER_EXEC,
              SUM(TOTAL_EXECUTION_TIME) / 1000 TOTAL_TIME_MS
            FROM
              BASIS_INFO BI,
              _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
            WHERE
              SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS
            GROUP BY
              STATEMENT_HASH,
              EXECUTION_ENGINE
            HAVING
              SUM(EXECUTION_COUNT) > 0 AND
              SUM(TOTAL_EXECUTION_TIME) >= 1800 * 1000 * 1000
          )
        )
        WHERE
          MAX_TIME_PER_EXEC_MS / MIN_TIME_PER_EXEC_MS > 5 AND
          ( MAX_ROWS_PER_EXEC <= 10 OR MAX_ROWS_PER_EXEC <= MIN_ROWS_PER_EXEC * 10 )
        ORDER BY
          TOTAL_TIME_MS DESC
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'HIGH_USER_MEMORY_LIMIT',
        '',
        IFNULL(USER_NAME || CHAR(32) || '(' || VALUE || CHAR(32) || 'GB)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        USER_PARAMETERS ON
          PARAMETER = 'STATEMENT MEMORY LIMIT' AND
          LPAD(VALUE, 15) >= LPAD('500', 15)
    )
    UNION ALL
    ( SELECT
        'HIGH_USER_THREAD_LIMIT',
        '',
        IFNULL(USER_NAME || CHAR(32) || '(' || VALUE || CHAR(32) || 'threads)', 'none')
      FROM
      ( SELECT MAX(VALUE) SOCKETS FROM M_HOST_INFORMATION WHERE KEY = 'cpu_sockets' ) LEFT OUTER JOIN
        USER_PARAMETERS ON
          PARAMETER = 'STATEMENT THREAD LIMIT' AND
          LPAD(VALUE, 15) >= LPAD(ROUND(SOCKETS / 2), 15)
    )
    UNION ALL
    ( SELECT
        'HOST_MEM_OVERALLOCATION',
        HOST,
        TO_VARCHAR(TO_DECIMAL(GREATEST(0, MEMORY_ALLOCATION_LIMIT + MEMORY_TOTAL_RESIDENT - MEMORY_RESIDENT - MEMORY_SIZE ) / 1024 / 1024 / 1024, 10, 2))
      FROM
      ( SELECT
          *
        FROM
          M_LOAD_HISTORY_HOST
        WHERE
          TIME = ( SELECT MAX(TIME) FROM M_LOAD_HISTORY_HOST ) 
      )
    )
    UNION ALL
    ( SELECT
        'LOAD_HIST_USED_MEMORY_RATIO',
        '',
        IFNULL(TO_VARCHAR(TO_DECIMAL(MAX(LOAD_HISTORY_MEMORY_USED / SERVICE_MEMORY_USED), 10, 2)), 'n/a')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          L.HOST,
          L.PORT,
          L.LOAD_HISTORY_MEMORY_USED,
          S.SERVICE_MEMORY_USED
        FROM
        ( SELECT
            HOST,
            PORT,
            AVG(MEMORY_USED) LOAD_HISTORY_MEMORY_USED
          FROM
            M_LOAD_HISTORY_SERVICE LH1
          WHERE
            TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -60) AND
            MEMORY_USED >= 20 * 1024 * 1024 * 1024
          GROUP BY
            HOST,
            PORT
        ) L,
        ( SELECT
            HOST,
            PORT,
            TOTAL_MEMORY_USED_SIZE + FAST_RESTART_MEMORY_MAPPED_SIZE + PERSISTENT_MEMORY_MAPPED_SIZE SERVICE_MEMORY_USED
          FROM
            M_SERVICE_MEMORY
          WHERE
            TOTAL_MEMORY_USED_SIZE > 0
        ) S
        WHERE
          L.HOST = S.HOST AND
          L.PORT = S.PORT
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'RETENTION_TABLE_RESOURCES',
        '',
        TO_VARCHAR(IFNULL(SUM(OBJECT_COUNT), 0))
      FROM
        M_MEMORY_OBJECTS
      WHERE
        TYPE = 'RetentionTable'
    )
    UNION ALL
    ( SELECT
        'COLLECTION_OBJECT_ID',
        '',
        TO_VARCHAR(GREATEST(TABLE_OID, COLLECTION_ID))
      FROM
      ( SELECT
          IFNULL(MAX(TABLE_OID), 0) TABLE_OID
        FROM
          TABLES
      ),
      ( SELECT
          IFNULL(MAX(COLLECTION_ID), 0) COLLECTION_ID
        FROM
          M_COLLECTION_TABLES
      )
    )
    UNION ALL
    ( SELECT
        'TRACE_COMPRESSOR_ACTIVITY',
        '',
        CASE WHEN DURATION_S < 30 THEN 'none' ELSE DURATION_S || CHAR(32) || 's' || CHAR(32) || '(' || TO_VARCHAR(TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') || ')' END
      FROM
      ( SELECT TOP 1
          TO_DECIMAL(TT.DURATION / 1000, 10, 2) DURATION_S,
          TT.TIMESTAMP
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES TT
        WHERE
          TT.THREAD_TYPE = 'TraceSegmentCompressor' AND
          TT.DURATION <= 1000000 AND
          TT.THREAD_METHOD = 'Search for trace files to compress' AND
          SECONDS_BETWEEN(TT.TIMESTAMP, CURRENT_TIMESTAMP) <= BI.LONGTERM_DAYS * 86400
        ORDER BY
          TT.DURATION DESC
      )
    )
    UNION ALL
    ( SELECT
        'SWAPPABLE_OVERESTIMATION',
        '',
        MAP(FRO_USED, 'X', 'n/a', TO_VARCHAR(TO_DECIMAL(GREATEST(0, MAP(CS_REAL_SIZE, 0, 0, CS_SWAPPABLE_SIZE / CS_REAL_SIZE * 100 - 100)), 10, 2)))
      FROM
      ( SELECT FRO_USED FROM GENERAL_INFO ),
      ( SELECT SUM(SWAPPABLE_SIZE) CS_SWAPPABLE_SIZE FROM M_MEMORY_OBJECTS WHERE TYPE = 'AttributeEngine' ),
      ( SELECT SUM(INCLUSIVE_SIZE_IN_USE) CS_REAL_SIZE FROM M_HEAP_MEMORY WHERE CATEGORY = 'Pool/ColumnStore' )
    )
    UNION ALL
    ( SELECT
        'TOPOLOGY_INCONSISTENCY',
        '',
        TO_VARCHAR(MAP(COUNT(*), 0, 'no', 'yes'))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.STATISTICS_ALERTS SA
      WHERE
        SA.ALERT_ID = 145 AND
        SECONDS_BETWEEN(SA.ALERT_TIMESTAMP, CURRENT_TIMESTAMP) <= BI.SHORTTERM_DAYS * 86400
    )
    UNION ALL
    ( SELECT TOP 5
        'MANY_THREADS_FOR_REQUEST',
        '',
        MAP(TIMESTAMP, NULL, 'none', CNT || CHAR(32) || '(' || TIMESTAMP || ',' || CHAR(32) || STATEMENT_EXECUTION_ID || ')')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          TO_VARCHAR(MAX(T.TIMESTAMP), 'YYYY/MM/DD HH24:MI:SS') TIMESTAMP,
          STATEMENT_EXECUTION_ID,
          COUNT(*) CNT,
          ROW_NUMBER () OVER (PARTITION BY STATEMENT_EXECUTION_ID ORDER BY COUNT(*) DESC) ROWNO
        FROM
          BASIS_INFO BI,
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
        WHERE
          SECONDS_BETWEEN(T.TIMESTAMP, CURRENT_TIMESTAMP) <= BI.LONGTERM_DAYS * 86400 AND
          STATEMENT_EXECUTION_ID != -1
        GROUP BY
          T.TIMESTAMP,
          T.STATEMENT_EXECUTION_ID
        HAVING COUNT(*) >= 500
      ) ON
          ROWNO = 1
      ORDER BY
        CNT DESC
    )
    UNION ALL
    ( SELECT
        'PLUGIN_FAILURES',
        '',
        TO_VARCHAR(COUNT(*))
      FROM
        M_PLUGIN_STATUS
      WHERE
        AREA_STATUS LIKE '%FAILED%' OR 
        PACKAGE_STATUS LIKE '%FAILED%' OR 
        ERROR_TEXT != CHAR(32)
    )
    UNION ALL
    ( SELECT TOP 10
        'LONG_RESOURCE_WAIT_TIME',
        '',
        IFNULL(M.TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL((M.RESOURCE_WAIT_TIME) / 1000, 10, 0) || CHAR(32) || 's, ' || 
          TO_VARCHAR(M.START_TIME, 'YYYY/MM/DD HH24:MI:SS') || ')', 'none')
      FROM
        BASIS_INFO BI LEFT OUTER JOIN
        _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS M ON
          SECONDS_BETWEEN(M.START_TIME, CURRENT_TIMESTAMP) <= BI.MIDTERM_DAYS * 86400 AND
          M.RESOURCE_WAIT_TIME >= 900000
      ORDER BY
        M.RESOURCE_WAIT_TIME DESC
    )
    UNION ALL
    ( SELECT
        'NSE_BUFFER_FRAGMENTATION',
        '',
        CASE WHEN SUM(ALLOCATED_SIZE) <= 10 * 1024 * 1024 * 1024 THEN 'n/a' ELSE TO_VARCHAR(TO_DECIMAL(MAP(SUM(ALLOCATED_SIZE), 0, 0, 100 - SUM(USED_SIZE) / SUM(ALLOCATED_SIZE) * 100), 10, 0)) END
      FROM
        M_BUFFER_CACHE_STATISTICS
    )
    UNION ALL
    ( SELECT
        'ADMCTRL_WAIT_TIME',
        '',
        TO_VARCHAR(TO_DECIMAL(SUM(L.ADMISSION_CONTROL_WAIT_TIME) / 1000000 / BI.MIDTERM_DAYS / 86400, 10, 2))
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
      WHERE
        SECONDS_BETWEEN(L.TIME, CURRENT_TIMESTAMP) <= BI.MIDTERM_DAYS * 86400
      GROUP BY
        BI.MIDTERM_DAYS
    )
    UNION ALL
    ( SELECT TOP 10
        'NSE_LARGE_COLUMNS',
        IFNULL(B.HOST, ''),
        IFNULL(B.COLUMN_NAME, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          C.HOST,
          B.MAX_SIZE,
          C.MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE,
          C.TABLE_NAME || MAP(C.PART_ID, 0, '', CHAR(32) || '(' || C.PART_ID || ')') || '.' || C.COLUMN_NAME || CHAR(32) || '(' || 
            TO_DECIMAL(ROUND(MAP(B.MAX_SIZE, 0, 0, C.MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE / B.MAX_SIZE * 100)), 10, 0) || CHAR(32) || '%)' COLUMN_NAME
        FROM
          M_BUFFER_CACHE_STATISTICS B,
          TEMP_M_CS_COLUMNS_PERSISTENCE C
        WHERE
          C.HOST = B.HOST AND
          C.PORT = B.PORT AND
          C.MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE >= B.MAX_SIZE * 0.3
      ) B ON
        1 = 1
      ORDER BY
        MAP(B.MAX_SIZE, 0, 0, B.MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE / B.MAX_SIZE * 100) DESC
    )
    UNION ALL
    ( SELECT
        'CURRENT_PLAN_ID_REGRESSION',
        '',
        IFNULL(STATEMENT_HASH || CHAR(32) || '(' || TO_DECIMAL(TIME_PER_EXEC_CURR_MS, 10, 2) || CHAR(32) || 'ms vs.' || CHAR(32) || TO_DECIMAL(TIME_PER_EXEC_HIST_MS, 10, 2) || CHAR(32) || 'ms)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          SC.STATEMENT_HASH,
          SC.PLAN_ID,
          SC.TIME_PER_EXEC_MS TIME_PER_EXEC_CURR_MS,
          MAP(SUM(SH.EXECUTION_COUNT), 0, 0, SUM(SH.TOTAL_EXECUTION_TIME) / SUM(SH.EXECUTION_COUNT) / 1000) TIME_PER_EXEC_HIST_MS
        FROM
        ( SELECT
            STATEMENT_HASH,
            PLAN_ID,
            TIME_PER_EXEC_MS
          FROM
          ( SELECT
              S.STATEMENT_HASH,
              S.PLAN_ID,
              MAP(SUM(S.EXECUTION_COUNT), 0, 0, SUM(S.TOTAL_EXECUTION_TIME - S.TOTAL_LOCK_WAIT_DURATION) / SUM(S.EXECUTION_COUNT) / 1000) TIME_PER_EXEC_MS,
              SUM(S.TOTAL_EXECUTION_TIME - S.TOTAL_LOCK_WAIT_DURATION) TOTAL_EXECUTION_TIME,
              SUM(SUM(S.TOTAL_EXECUTION_TIME - S.TOTAL_LOCK_WAIT_DURATION)) OVER () OVERALL_TOTAL_EXECUTION_TIME
            FROM
            ( SELECT MAX(SERVER_TIMESTAMP) MAX_SERVER_TIMESTAMP FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE ) M,
              _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
            WHERE
              S.SERVER_TIMESTAMP = M.MAX_SERVER_TIMESTAMP
            GROUP BY
              S.STATEMENT_HASH,
              S.PLAN_ID
          )
          WHERE
            TOTAL_EXECUTION_TIME >= 0.005 * OVERALL_TOTAL_EXECUTION_TIME
        ) SC,
        ( SELECT
            S.STATEMENT_HASH,
            S.PLAN_ID,
            SUM(S.EXECUTION_COUNT) EXECUTION_COUNT,
            SUM(S.TOTAL_EXECUTION_TIME) TOTAL_EXECUTION_TIME
          FROM
          ( SELECT MAX(SERVER_TIMESTAMP) MAX_SERVER_TIMESTAMP FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE ) M,
            _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
          WHERE
            S.SERVER_TIMESTAMP < M.MAX_SERVER_TIMESTAMP
          GROUP BY
            S.STATEMENT_HASH,
            S.PLAN_ID
        ) SH
        WHERE
          SC.STATEMENT_HASH = SH.STATEMENT_HASH AND
          SC.PLAN_ID != SH.PLAN_ID 
        GROUP BY
          SC.STATEMENT_HASH,
          SC.PLAN_ID,
          SC.TIME_PER_EXEC_MS
      ) ON
        TIME_PER_EXEC_CURR_MS >= 5 * TIME_PER_EXEC_HIST_MS
    )
    UNION ALL
    ( SELECT
        'LONG_CS_LOB_GC',
        '',
        TO_VARCHAR(MAX(TO_DECIMAL(NANO100_BETWEEN(START_TIME, CASE END_TIME WHEN '' THEN CURRENT_TIMESTAMP ELSE END_TIME END) / 10000000, 10, 0)))
      FROM
        M_CS_LOB_SPACE_RECLAIMS
    )
    UNION ALL
    ( SELECT TOP 10
        'LONG_CURSOR_DURATION',
        '',
        IFNULL(STATEMENT_HASH || CHAR(32) || '(' || TO_DECIMAL(MAX_CURSOR_DURATION / 1000000, 10, 0) || CHAR(32) || 's)', 'none')
      FROM
      ( SELECT
          S.STATEMENT_HASH,
          MAX(S.MAX_CURSOR_DURATION) MAX_CURSOR_DURATION
        FROM
          BASIS_INFO BI LEFT OUTER JOIN
          _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S ON
            SECONDS_BETWEEN(S.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) <= 86400 * BI.LONGTERM_DAYS
        GROUP BY
          S.STATEMENT_HASH
        HAVING
          MAX(S.MAX_CURSOR_DURATION) >= 86400000000
      )
      ORDER BY
        MAX_CURSOR_DURATION DESC
    )
    UNION ALL
    ( SELECT
        'IPMM_DEVIATIONS',
        H.HOST,
        TO_VARCHAR(LEAST(100, TO_DECIMAL(H.INSTANCE_TOTAL_MEMORY_USED_SIZE / S.TOTAL_MEMORY_USED_SIZE * 100, 10, 0)))
      FROM
      ( SELECT HOST, SUM(TOTAL_MEMORY_USED_SIZE) TOTAL_MEMORY_USED_SIZE FROM M_SERVICE_MEMORY GROUP BY HOST ) S,
        M_HOST_RESOURCE_UTILIZATION H
      WHERE
        S.HOST = H.HOST
    )
    UNION ALL
    ( SELECT
        'ORPHAN_PACKED_LOB_MAPPINGS',
        '',
        TO_VARCHAR(GREATEST(0, ALL_MAPPINGS - VALID_MAPPINGS)) 
       FROM
       ( SELECT SUM(EXCLUSIVE_COUNT_IN_USE) ALL_MAPPINGS FROM M_HEAP_MEMORY WHERE CATEGORY = 'Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map' ),
       ( SELECT SUM(LOB_COUNT) VALID_MAPPINGS FROM TEMP_M_TABLE_LOB_STATISTICS WHERE LOB_STORAGE_TYPE = 'PACKED' )
    )
    UNION ALL
    ( SELECT
        'SQLSCRIPT_SQL_CACHE_SHARE',
        SP.HOST,
        TO_VARCHAR(TO_DECIMAL(MAP(SQL_CACHE_SQLSCRIPT, 0, 0, SQL_CACHE_SQLSCRIPT / SQL_CACHE_TOTAL * 100), 10, 2))
      FROM
      ( SELECT HOST, MAX(PLAN_CACHE_CAPACITY) SQL_CACHE_TOTAL FROM M_SQL_PLAN_CACHE_OVERVIEW GROUP BY HOST ) SP,
      ( SELECT HOST, MAX(EXCLUSIVE_SIZE_IN_USE) SQL_CACHE_SQLSCRIPT FROM M_HEAP_MEMORY WHERE CATEGORY = 'Pool/RowEngine/SQLPlan/ScriptCodeAlloc' GROUP BY HOST ) SC
      WHERE
        SP.HOST = SC.HOST
    )
    UNION ALL
    ( SELECT
        'PARAMETERS_MANY_CHANGES',
        '',
        IFNULL(KEY || CHAR(32) || '(' || CNT || CHAR(32) || '/ month)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          KEY,
          COUNT(*) CNT
        FROM
          M_INIFILE_CONTENT_HISTORY
        WHERE
          DAYS_BETWEEN(TIME, CURRENT_TIMESTAMP) <= 31 AND
          KEY NOT IN ( 'arguments', 'environment', 'executable', 'instanceIds', 'instanceIdsInactive', 'instances', 'name', 'runlevel', 'startdir', 'stderr', 'stdout' ) AND
          KEY NOT LIKE 'failovergroup%' AND
          KEY NOT LIKE 'roles%' AND
          KEY NOT LIKE 'workergroupgs%'
        GROUP BY
          KEY
        HAVING COUNT(*) >= 10
      ) ON 1 = 1
    )
    UNION ALL
    ( SELECT
        'CURR_ALLOCATION_LIMIT_ALLOC',
        HOST,
        TO_VARCHAR(TO_DECIMAL(ROUND(MAP(ALLOCATION_LIMIT, 0, 0, INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE / ALLOCATION_LIMIT * 100)), 10, 0))
      FROM
        M_HOST_RESOURCE_UTILIZATION
    )
    UNION ALL
    ( SELECT
        'SLT_LOGGING_TABLE_SIZE',
        '',
        IFNULL(TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(RECORD_COUNT / 1000000, 10, 0) || CHAR(32) || 'Mio.)', 'none')
      FROM
        DUMMY LEFT OUTER JOIN
      ( SELECT
          TABLE_NAME,
          SUM(RECORD_COUNT) RECORD_COUNT
        FROM
          TEMP_M_CS_TABLES
        WHERE
          TABLE_NAME LIKE '/1CADMC/%' OR
          TABLE_NAME LIKE '/1DH/ML%' OR
          TABLE_NAME LIKE '/1DH/SL%'
        GROUP BY
          TABLE_NAME
        HAVING
          SUM(RECORD_COUNT) > 5000000
      ) ON
        1 = 1
    )
/* TMC_GENERATION_END_1 */
  ) C,
    BASIS_INFO BI,
  ( SELECT -1 CHECK_ID, '' NAME,                  '' DESCRIPTION,                                    '' SAP_NOTE, '' EXPECTED_OP, '' EXPECTED_VALUE, -1 MIN_REV, -1 MAX_REV FROM DUMMY WHERE 1 = 0 UNION ALL
/* TMC_GENERATION_START_2 */
    ( SELECT    1, 'INFO_LINE',                    'SAP HANA MINI CHECKS',                            '1999993', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    2, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    5, 'GENERATED_WITH',               'Generated with',                                  '1969700', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    6, 'CHECK_VERSION',                'Check version',                                   '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    8, 'SYSTEM_ID_DB_NAME',            'System ID / database name',                       '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    9, 'CONFIGURED_TIME_INTERVALS',    'Configured time intervals (days)',                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT   10, 'ANALYSIS_DATE',                'Analysis date',                                   '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT   12, 'REVISION_LEVEL',               'Revision level',                                  '2378962', '>=',       '53.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT   13, 'VERSION_LEVEL',                'Version',                                         '2378962', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  110, 'EVERYTHING_STARTED',           'Everything started',                              '2177064', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  111, 'HOST_START_TIME_VARIATION',    'Host startup time variation (s)',                 '2177064', '<=',       '600',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  115, 'SERVICE_START_TIME_VARIATION', 'Service startup time variation (s)',              '2177064', '<=',       '600',           -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  200, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  201, 'INFO_LINE',                    'OPERATING SYSTEM',                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  202, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  207, 'OS_KERNEL_BIGMEM',             'Recommended bigmem kernel flavor not used',       '2240716', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  208, 'OS_RELEASE',                   'Supported operating system',                      '2235581', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  209, 'OS_KERNEL_VERSION',            'Recommended operating system kernel version',     '2235581', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  210, 'SLOW_CPU',                     'Minimum CPU rate (MHz)',                          '2235581', '>=',       '1950',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  211, 'VARYING_CPU',                  'Hosts with varying CPU rates',                    '2235581', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  212, 'CPU_DISCREPANCY',              'CPU discrepancy host info vs. host agent',        '2100040', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  215, 'WRONG_CPU_TYPE',               'Hosts with outdated CPU type',                    '2399995', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  220, 'CPU_BUSY_CURRENT',             'Current CPU utilization (%)',                     '2100040', '<=',       '80',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  221, 'CPU_BUSY_RECENT',              'Peak CPU utilization (%, short-term)',            '2100040', '<=',       '80',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  222, 'CPU_BUSY_HISTORY',             'Time since CPU utilization > 95 % (h)',           '2100040', '>=',       '12.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  226, 'CPU_BUSY_SYSTEM_RECENT',       'Peak system CPU utilization (%, short-term)',     '2100040', '<=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  227, 'CPU_BUSY_EXTERNAL',            'External CPU utilization (%, short-term)',        '2100040', '<=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  228, 'WRONG_SYSTEM_CPU',             'Erroneous system CPU calculation',                '2222110', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  229, 'INCONSISTENT_NUMA_NODES',      'Discrepancy between NUMA nodes and sockets',      '2470289', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  233, 'HOT_NUMA_NODES',               'NUMA nodes with high CPU utilization (current)',  '2470289', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  234, 'CPU_STEAL_SHARE',              'CPU steal share (%)',                             '2100040', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  235, 'VARYING_MEMORY',               'Hosts with varying physical memory size',         '1999997', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  236, 'VARYING_NUMA_NODES',           'CPU threads per NUMA node variation (%)',         '2470289', '<=',       '50',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  237, 'HOT_NUMA_NODES_RECENT',        'NUMA nodes with high thread load (short-term)',   '2470289', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  242, 'SWAP_OUT_MEDIUMTERM',          'Swap out (GB / day, mid-term)',                   '1999997', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  245, 'LARGE_SWAP_SPACE',             'Swap space size (GB)',                            '1999997', '<=',       '35.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  250, 'DISK_SIZE',                    'Max. used disk size (%)',                         '1870858', '<=',       '90',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  259, 'OS_OPEN_FILES_PEAK',           'Max. open files (mid-term)',                      '2222200', '<=',       '10000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  260, 'OS_OPEN_FILES',                'Open files limit configured',                     '2600030', '>=',       '1048576',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  261, 'OS_OPEN_FILES_PCT_CURRENT',    'Open files limit used (%, current)',              '2600030', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  262, 'OS_OPEN_FILES_PCT_HISTORY',    'Max. open files limit used (%, long-term)',       '2600030', '<=',       '60.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  263, 'OS_ASYNC_IO_LIMIT',            'Asynchronous I/O queue size limit',               '1868829', '=', '18446744073709551615', -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  264, 'OS_MEMORY_MAP_AREA_LIMIT',     'Virtual memory map count limit',                  '2600030', '=',        '2147483647',    -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  265, 'OS_NET_CORE_SOMAXCONN',        'Network socket backlog limit',                    '2382421', '>=',       '4096',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  266, 'OS_NET_IPV4_TCP_MAX_SYN_BACKLOG', 'Non-acknowledged requests limit',              '2382421', '>=',       '8192',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  267, 'OS_NET_PORT_EPHEMERAL_MAX_COUNT', 'Ephemeral port limit',                         '2382421', '>=',       '30000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  268, 'OS_OPEN_FILE_LIMIT',           'Open file limit',                                 '2600030', '>=',       '20000000',      -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  269, 'OS_THP_ACTIVE',                'Transparent huge pages active',                   '2131662', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  270, 'UNKNOWN_HARDWARE',             'Unknown hardware components',                     '1828631', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  280, 'SERVER_TIME_VARIATION',        'Maximum time variation between hosts (s)',        '',        '<=',       '5',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  300, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  301, 'INFO_LINE',                    'DISKS',                                           '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  302, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  312, 'MAX_IO_READ_LATENCY_DATA',     'I/O read latency data max. (ms, short-term)',     '1999930', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  313, 'AVG_IO_READ_LATENCY_DATA',     'I/O read latency data avg. (ms, short-term)',     '1999930', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  314, 'IO_READ_BANDWIDTH_STARTUP',    'I/O read reload throughput avg. (MB/s)',          '1999930', '>=',       '200.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  315, 'MIN_IO_WRITE_THROUGHPUT_DATA', 'I/O write throughput data min. (MB/s, short-term)','1999930','>=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  316, 'AVG_IO_WRITE_THROUGHPUT_DATA', 'I/O write throughput data avg. (MB/s, short-term)','1999930','>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  317, 'AVG_IO_READ_ACT_PCT_DATA',     'I/O read activity data avg. (%, short-term)',     '1999930', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  318, 'AVG_IO_WRITE_ACT_PCT_DATA',    'I/O write activity data avg. (%, short-term)',    '1999930', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  324, 'AVG_IO_WRITE_ACT_PCT_LOG',     'I/O write activity log avg. (%, short-term)',     '1999930', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  327, 'MAX_IO_WRITE_LATENCY_LOG',     'I/O write latency log max. (ms, short-term)',     '1999930', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  329, 'AVG_IO_WRITE_LATENCY_LOG',     'I/O write latency log avg. (ms, short-term)',     '1999930', '<=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  330, 'TRIGGER_READ_RATIO',           'Max. trigger read ratio (data)',                  '1930979', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  331, 'TRIGGER_WRITE_RATIO',          'Max. trigger write ratio (data, log)',            '1930979', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  340, 'LOG_WAIT_RATIO',               'Log switch wait count ratio (%)',                 '2215131', '<=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  341, 'LOG_RACE_RATIO',               'Log switch race count ratio (%)',                 '2215131', '<=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  342, 'CONVERTER_PAGE_NUMBER',        'Maximum converter page number',                   '2963601', '<=',       '3500000000',    -1,    52 FROM DUMMY ) UNION ALL
    ( SELECT  346, 'WAITFORLOCK_SAVEPOINT_PHASE',  'Long waitForLock savepoint phases (mid-term)',    '2100009', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  347, 'WAITFORFLUSH_SAVEPOINT_PHASE', 'Long waitForFlush savepoint phases (mid-term)',   '2100009', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  348, 'CRIT_SAVEPOINT_PHASE',         'Long critical savepoint phases (mid-term)',       '2100009', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  351, 'AVG_CRIT_SAVEPOINT_PHASE',     'Blocking savepoint phase avg. (s, mid-term)',     '2100009', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  355, 'TIME_SINCE_LAST_SAVEPOINT',    'Time since last savepoint (s)',                   '2100009', '<=',       '900',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  357, 'SAVEPOINT_THROUGHPUT',         'Savepoint write throughput (MB/s, mid-term)',     '2100009', '>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  358, 'LONG_RUNNING_SAVEPOINTS',      'Savepoints taking longer than 900 s (short-term)','2100009', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  359, 'OLDEST_CURRENT_SAVEPOINT',     'Maximum current savepoint runtime (s)',           '2100009', '<=',       '1200',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  360, 'FAILED_IO_READS',              'Number of failed I/O reads',                      '1999930', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  361, 'FAILED_IO_WRITES',             'Number of failed I/O writes',                     '1999930', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  363, 'REDO_GENERATION_ABS',          'Redo log generation (TB / day, mid-term)',        '1999930', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  364, 'REDO_GENERATION_REL',          'Redo log per day vs. data (%, mid-term)',         '1999930', '<=',       '35.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  367, 'UNSUPPORTED_FILESYSTEMS',      'Filesystems with unsupported types',              '1999930', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  370, 'DISK_DATA_FRAGMENTATION',      'Unused space in data files (%)',                  '1870858', '<=',       '50',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  371, 'PACKED_LOB_FRAGMENTATION',     'Unused space in packed LOBs vs. data (%)',        '2220627', '<=',       '7.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  372, 'FILE_LOB_FRAGMENTATION',       'Unused space in file LOBs vs. data (%)',          '2220627', '<=',       '7.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  373, 'SMALL_DISK_LOBS',              'Tables with many small file LOBs',                '2220627', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  374, 'MANY_DISK_LOBS',               'Tables with many disk LOBs',                      '2220627', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  380, 'OLDEST_BACKUP_SNAPSHOT',       'Age of oldest backup snapshot (days)',            '2100009', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  381, 'OLDEST_FALLBACK_SNAPSHOT',     'Age of oldest fallback snapshot (days)',          '2100009', '<=',       '28.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  383, 'SHADOW_PAGE_SIZE',             'Max. size of shadow pages (GB, short-term)',      '2100009', '<=',       '200.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  385, 'SAVEPOINT_VOLUME_REL',         'Savepoint vol. per day vs. data (%, mid-term)',   '2100009', '<=',       '150.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  386, 'SAVEPOINT_FLUSH_RETRIES_MAX',  'Max. savepoint prepare flush retries (short-term)','2100009','<=',       '500',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  387, 'SAVEPOINT_FLUSH_RETRIES_AVG',  'Avg. savepoint prepare flush retries (short-term)','2100009','<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  400, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  401, 'INFO_LINE',                    'MEMORY',                                          '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  402, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  409, 'CURR_ALLOCATION_LIMIT_ALLOC',  'Current allocation limit allocated (%)',          '1999997', '<=',       '95',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  410, 'CURR_ALLOCATION_LIMIT_USED',   'Current allocation limit used (%)',               '1999997', '<=',       '80',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  411, 'TABLE_ALLOCATION_LIMIT_RATIO', 'Current service alloc. limit used by tables (%)', '1999997', 'between',  '20-50',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  413, 'HIST_ALLOCATION_LIMIT_USED',   'Time since allocation limit used > 80 % (h)',     '1999997', '>=',       '24',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  415, 'MAX_CURR_SERV_ALL_LIMIT_USED', 'Curr. max. service allocation limit used (%)',    '1999997', '<=',       '80',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  417, 'MAX_HIST_SERV_ALL_LIMIT_USED', 'Time since service alloc. limit used > 80 % (h)', '1999997', '>=',       '24',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  418, 'HOST_MEM_OVERALLOCATION',      'Host memory overallocation (GB)',                 '1999997', '=',        '0.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  419, 'SWAPPABLE_OVERESTIMATION',     'Swappable column store size overestimation (%)',  '1999997', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  420, 'CURRENT_LARGE_HEAP_AREAS',     'Large heap allocators (current)',                 '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  421, 'RECENT_LARGE_HEAP_AREAS',      'Large heap allocators (short-term)',              '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  422, 'HISTORIC_LARGE_HEAP_AREAS',    'Large heap allocators (long-term)',               '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  423, 'MEMORY_LEAK_HEAP_AREAS',       'Heap areas with potential memory leak',           '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  425, 'CPBTREE_LEAK',                 'Pool/RowEngine/CpbTree leak size (GB)',           '1999997', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  426, 'ROW_STORE_TABLE_LEAK',         'Row store table leak size (GB)',                  '2362759', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  430, 'CURRENT_UNLOADS',              'Number of low memory unloads (short-term)',       '2127458', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  435, 'CURRENT_SHRINK_UNLOADS',       'Number of shrink unloads (short-term)',           '2127458', '<=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  437, 'COLUMN_UNLOAD_SIZE',           'Size of unloaded columns (% / day, long-term)',   '2127458', '<=',       '3.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  438, 'MEM_RECLAIM_PER_DAY',          'Memory reclaim activity (s / day)',               '1999997', '<=',       '1200',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  439, 'MEM_RECLAIM_MAX_DURATION',     'Memory reclaim maximum duration (s)',             '1999997', '<=',       '60',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  440, 'TOPOLOGY_SHARED_MEMORY',       'Topology shared memory utilization (%)',          '1977101', '<=',       '70',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  445, 'OOM_EVENTS_SHORTTERM',         'Number of OOM events (short-term)',               '1999997', '<=',       '3',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  446, 'OOM_EVENTS_PER_DAY_MIDTERM',   'Number of OOM events per day (mid-term)',         '1999997', '<=',       '3.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  447, 'OOM_EVENTS_GAL_PAL_LONGTERM',  'Number of alloc. limit OOM events (long-term)',   '1999997', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  450, 'LARGE_MEMORY_LOBS',            'Tables with memory LOBs > 2 GB',                  '1994962', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  452, 'UNIQUE_INDEXES_PCT',           'Size of unique indexes (%)',                      '2160391', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  454, 'CONCAT_ATTRIBUTES_PCT',        'Size of non-unique concat attributes (%)',        '1986747', '<=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  455, 'CONCAT_ATTRIBUTES_UNUSED',     'Unused large non-unique concat attributes',       '1986747', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  456, 'ROW_INDEXES_UNUSED',           'Unused large non-unique row store indexes',       '2160391', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  462, 'LARGE_CACHES',                 'Caches with large size',                          '2502256', '=',        'none',          -1, 59.99 FROM DUMMY ) UNION ALL /* bug 289445 */
    ( SELECT  462, 'LARGE_CACHES',                 'Caches with large size',                          '2502256', '=',        'none',          64,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  463, 'HIGH_PLE_MEMORY_SHARE',        'Planning engine runtime objects mem. share (%)',  '1999997', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  470, 'FREQUENT_ALLOCATORS',          'Heap allocators with many instantiations',        '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  471, 'IPMM_DEVIATIONS',              'IPMM memory vs. actually used memory (%)',        '1999997', '>=',       '75',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  472, 'IMPLICIT_MEMORY_BOOKING',      'Booked vs. used memory (%)',                      '1999997', '<=',       '200',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  473, 'LOAD_HIST_USED_MEMORY_RATIO',  'Load history used memory ratio (%)',              '2222110', '<=',       '1.15',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  474, 'LARGE_ALLOCATION_SHARE',       'Heap allocators with large allocation share',     '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  476, 'HIGH_USER_MEMORY_LIMIT',       'Users with high memory limit',                    '2222250', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  480, 'ADDRESS_SPACE_UTILIZATION',    'Address space utilization (%)',                   '1999997', '<=',       '40',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  481, 'PROACTIVE_MEMORY_RECLAIMS',    'Proactive memory reclaims (%, short-term)',       '1999997', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  500, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  501, 'INFO_LINE',                    'TABLES',                                          '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  502, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  510, 'MANY_PARTITIONS',              'Tables with > 100 partitions',                    '2044468', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  511, 'TABLES_MANY_COLUMNS',          'Tables with many columns',                        '1999997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  512, 'MULTI_COLUMN_HASH_PART',       'Hash partitioning on multiple columns',           '2044468', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  513, 'TABLES_MANY_EMPTY_PARTITIONS', 'Tables with many empty partitions',               '2044468', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  516, 'INVERTED_HASH_INDEXES',        'Existing inverted hash indexes',                  '2109355', '=',        '0',             -1,    47 FROM DUMMY ) UNION ALL
    ( SELECT  517, 'INVERTED_HASH_NONUNIQUE',      'Existing non-unique inverted hash indexes',       '3119950', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  519, 'LARGE_OVERFLOW_PARTITION',     'Tables with large overflow partition',            '2044468', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  520, 'MANY_RECORDS',                 'Tables / partitions with many rows',              '1921694', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  521, 'MANY_RECORDS_HISTORY',         'Table histories with many rows',                  '1921694', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  522, 'MANY_RECORDS_UDIV',            'Tables / partitions with many UDIV rows',         '2112604', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  523, 'MANY_TEXT_TOKENS',             'Columns with many distinct text tokens',          '2154870', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  524, 'LARGE_VARBINARY_COLUMNS',      'Large columns of VARBINARY type',                 '2375917', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  525, 'LARGE_MEMORY_TABLES',          'Tables / partitions with large memory size',      '2044468', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  526, 'LARGE_ALLOC_LIM_TABLES',       'Tables / partitions with large memory share',     '2044468', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  530, 'ROW_STORE_SIZE',               'Row store size (GB)',                             '2050579', '<=',       '300',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  533, 'ROW_STORE_CONTAINERS',         'Row store tables with more than 1 container',     '2000002', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  535, 'ROW_STORE_FRAGMENTATION',      'Row store fragmentation (%)',                     '1813245', '<=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  536, 'LONG_OPTIMIZATION_LOCKS',      'Long table optimization lock times (mid-term)',   '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  537, 'LONG_TABLE_MERGE_TIME',        'Tables with long total merge time (short-term)',  '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  538, 'LONG_DELTA_MERGES',            'Long running delta merges (mid-term)',            '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  539, 'LONG_OPTIMIZE_COMPRESSIONS',   'Long running optimize compressions (mid-term)',   '2112604', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  540, 'FAILING_DELTA_MERGES_INFO',    'Failing delta merges (infos / day, short-term)',  '2057046', '<=',       '5000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  541, 'FAILING_DELTA_MERGES_ERROR',   'Failing delta merges (errors / day, short-term)', '2057046', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  542, 'LARGE_DELTA_STORAGE_AUTO',     'Auto merge tables with delta storage > 5 GB',     '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  543, 'MANY_DELTA_RECORDS_AUTO',      'Auto merge tables with many delta records',       '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  544, 'LARGE_DELTA_STORAGE_NOAUTO',   'Non-auto merge tables with delta storage > 5 GB', '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  545, 'MANY_DELTA_RECORDS_NOAUTO',    'Non-auto merge tables with many delta records',   '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  547, 'TABLES_AUTOMERGE_DISABLED',    'Non BW tables with disabled auto merge',          '2057046', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  548, 'TABLES_PERSMERGE_DISABLED',    'Tables with disabled persistent merge',           '2057046', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  549, 'TABLES_AUTOCOMP_DISABLED',     'Non BW tables with disabled auto compression',    '2112604', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  550, 'ST_POINT_TABLES',              'Row store tables with ST_POINT columns',          '2038897', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  551, 'TIMEZONE_TABLE_SETUP',         'Proper setup of timezone table TTZZ',             '1791342', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  552, 'TIMEZONE_ALERTS',              'Number of current timezone alerts',               '1791342', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  553, 'HARD_FORCED_MERGES',           'Hard / forced merge duration / day (s, mid-term)','2057046', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  554, 'LONG_RESOURCE_WAIT_TIME',      'Tables with long resource wait times (mid-term)', '2057046', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  559, 'PAGED_COLUMNS_WITH_OLD_PERS',  'Paged columns with old persistence format',       '2771956', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  560, 'LARGE_TABLES_NOT_COMPRESSED',  'Tables > 10 Mio. rows not compressed',            '2105761', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  561, 'LARGE_COLUMNS_NOT_COMPRESSED', 'Columns > 10 Mio. rows not compressed',           '2112604', '<=',       '50',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  562, 'MISSING_INVERTED_INDEXES',     'Columns with missing inverted indexes',           '2160391', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  563, 'INDEXES_ON_SPARSE_PREFIXED',   'Indexes on large SPARSE / PREFIXED columns',      '2112604', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  564, 'ORPHAN_UNIQUE_CONCATS',        'Orphan unique concat attributes',                 '2160391', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  565, 'UDIV_OVERHEAD',                'Tables > 10 Mio. rows and > 200 % UDIV rows',     '2112604', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  568, 'RETENTION_TABLE_RESOURCES',    'Number of no logging retention table resources',  '2800007', '<=',       '100000',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  569, 'TEMP_TABLE_RECORDS',           'Temporary tables with many records',              '2800007', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  570, 'TEMPORARY_TABLES',             'Number of temporary tables',                      '2800007', '<=',       '100000',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  571, 'TEMP_TABLE_SIZE_SHARE',        'Memory used by temporary tables (%)',             '2800007', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  572, 'NOLOGGING_TABLES',             'Number of no logging tables',                     '2800007', '<=',       '7000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  573, 'TRANS_TABLE_PERCENT',          'Translation table cache utilization (%)',         '1998599', '<=',       '80.00',         -1, 59.99 FROM DUMMY ) UNION ALL
    ( SELECT  574, 'SMALL_RETENTION_TABLES',       'Tables with small unused retention period',       '2127458', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  575, 'NO_DELTA_LOG_TABLES',          'Tables with disabled delta logging (current)',    '1999930', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  576, 'NO_DELTA_LOG_TABLES_HIST',     'Tables with disabled delta logging (long-term)',  '1999930', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  577, 'SPECIAL_UNLOAD_PRIORITY',      'Tables with special unload priority',             '2127458', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  580, 'TABLES_WRONG_SERVICE',         'Tables assigned to wrong service',                '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  582, 'TABLES_WITH_EMPTY_LOCATION',   'Tables with empty table location',                '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  600, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  601, 'INFO_LINE',                    'TRACES, DUMPS AND LOGS',                          '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  602, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  609, 'SQLSCRIPT_PLAN_PROFILER',      'SQLScript plan profiler configured',              '2119087', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  610, 'KERNEL_PROFILER',              'Kernel profiler configured',                      '2800030', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  611, 'MEMORY_PROFILER',              'Memory profiler active',                          '1999997', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  612, 'PERFORMANCE_TRACE',            'Performance trace enabled',                       '1787489', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  613, 'FUNCTION_PROFILER',            'Function profiler enabled',                       '1787489', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  623, 'EXPENSIVE_SQL_TRACE_RECORDS',  'Traced expensive statements / day (short-term)',  '2180165', '<=',       '8000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  624, 'EXPENSIVE_SQL_RETENTION',      'Expensive statements trace retention (days)',     '2180165', '>=',       '3.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  638, 'MISSING_BACKUP_LOG',           'Number of backup log files',                      '2797078', '>=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  640, 'NUM_TRACEFILES_TOTAL',         'Number of trace files (total)',                   '2119087', '<=',       '200',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  641, 'NUM_TRACEFILES_SHORTTERM',     'Number of trace files / day (short-term)',        '2119087', '<=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  642, 'SIZE_TRACEFILES_TOTAL',        'Size of trace files (GB, total)',                 '2119087', '<=',       '6.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  643, 'SIZE_TRACEFILES_SHORTTERM',    'Size of trace files / day (GB, short-term)',      '2119087', '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  644, 'LARGEST_TRACEFILE',            'Size of largest trace file (MB)',                 '2119087', '<=',       '70.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  645, 'NUM_OOM_TRACEFILES',           'Number of OOM trace files (short-term)',          '1999997', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  650, 'NUM_CRASHDUMP_TRACEFILES',     'Number of crash dumps (short-term)',              '2177064', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  652, 'NUM_PAGEDUMP_TRACEFILES',      'Number of page dumps (short-term)',               '1977242', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  655, 'NUM_RTEDUMP_TRACEFILES',       'Number of RTE dumps (short-term)',                '2119087', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  658, 'LAST_SPECIAL_DUMP',            'Time since last dump (days)',                     '2119087', '>=',       '7.00',          -1,    -1 FROM DUMMY ) UNION ALL 
    ( SELECT  661, 'HEAP_ALLOCATOR_STACK_ENABLED', 'Heap allocators with allocation stack trace',     '2222218', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  662, 'HEAP_OTHER_TRACES_ENABLED',    'Heap allocators with other memory traces',        '2222218', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  663, 'HEAP_TRACES_ENABLED_HIST',     'Time since activated memory trace (days)',        '2222218', '>=',       '7.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  665, 'TRACE_COMPONENTS_PER_SERVICE', 'Max. trace components per service',               '2380176', '<=',       '1700',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  670, 'LAST_TRACEFILE_MODIFICATION',  'Time since last trace file modification (s)',     '2119087', '<=',       '600',           -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  700, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  701, 'INFO_LINE',                    'STATISTICS SERVER',                               '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  702, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  710, 'OPEN_ALERTS_HIGH',             'Open alerts (high priority)',                     '2445867', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  711, 'OPEN_ALERTS_ERROR',            'Open alerts (error state)',                       '2445867', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  712, 'STAT_SERVER_INTERNAL_ERRORS',  'Internal statistics server errors (short-term)',  '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  715, 'CHECKS_NOT_RUNNING',           'Number of actions not executed as expected',      '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  716, 'STAT_SERVER_NO_WORKERS',       'Number of statistics server worker threads',      '2147247', '>=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  717, 'STAT_SERVER_DISABLED_CHECKS',  'Number of disabled actions',                      '2113228', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  718, 'STAT_SERVER_INACTIVE_CHECKS',  'Number of relevant inactive actions',             '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  719, 'STAT_SERVER_UNKNOWN_STATES',   'Number of actions with unknown state',            '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  720, 'OPEN_EVENTS',                  'Events not acknowledged since >= 1800 s',         '2126236', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  721, 'CALLSTACK_HISTORY_INACTIVE',   'Thread call stack collector inactive',            '2147247', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  730, 'OLD_PENDING_ALERT_EMAILS',     'Pending e-mails older than 3 days',               '2133799', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  735, 'STAT_SERVER_OLD_ALERTS',       'Alerts older than 42 days',                       '2170779', '<=',       '10000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  736, 'STAT_SERVER_FREQUENT_ALERTS',  'Alerts reported frequently',                      '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  740, 'STAT_SERVER_LAST_ACTIVE',      'Time since statistics server run (s)',            '2147247', '<=',       '3600',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  744, 'STAT_SERVER_SQL_CACHE_SHARE',  'Total SQL cache share of statistics server (%)',  '2124112', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  745, 'STAT_SERVER_TABLE_SIZE',       'Total size of statistics server tables (GB)',     '2147247', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  746, 'STAT_SERVER_TABLE_SHARE',      'Total memory share of statistics server (%)',     '2147247', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  748, 'HOST_CS_UNLOADS_ACTIVE',       'History of M_CS_UNLOADS collected',               '2147247', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  749, 'HOST_RECORD_LOCKS_ACTIVE',     'History of M_RECORD_LOCKS collected',             '2147247', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  750, 'STAT_SERVER_RETENTION',        'Stat. server tables with retention < 42 days',    '2147247', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  751, 'THREAD_SAMPLES_INTERVAL',      'Historic thread samples save interval (s)',       '2147247', '<=',       '600',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  752, 'THREAD_CALLSTACKS_INTERVAL',   'Historic thread call stacks interval (s)',        '2147247', '=',        '299',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  753, 'TABLE_SIZE_RETENTION',         'Retention time of table disk sizes (days)',       '2147247', '>=',       '365',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  755, 'EMBEDDED_STAT_SERVER_USED',    'Embedded statistics server used',                 '2092033', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  760, 'ESS_MIGRATION_SUCCESSFUL',     'Status of statistics server installation',        '2092033', '=',        'done (okay)',   -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  762, 'STAT_SERVER_DDL_STATEMENTS',   'Stat. server DDL statements (short-term)',        '2883644', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  764, 'STAT_SERVER_MANUAL',           'Avg. manual stat. server sessions (short-term)',  '2000002', '=',        '0.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  766, 'ESS_WORKLOAD_CLASS_USED',      'Workload class for statistics server in place',   '2970921', '=',        'yes',           54,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  770, 'STAT_SERVER_WRONG_HOST',       'Statistics server tables not on coordinator',     '2091256', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  780, 'HOST_OBJ_LOCK_UNKNOWN',        'Unknown entries in HOST_OBJECT_LOCK_STATISTICS',  '2147247', '<=',       '1000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  781, 'ORPHAN_ALERT_32_ENTRY',        'Orphan entry for alert 32',                       '2803904', '=',        'no',            40,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  800, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  801, 'INFO_LINE',                    'TRANSACTIONS AND THREADS',                        '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  802, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  810, 'VERSIONS_ROW_STORE_CURR',      'MVCC versions in row store',                      '2169283', '<=',       '5000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  811, 'VERSIONS_ROW_STORE_SHORTTERM', 'Max. MVCC versions in row store (short-term)',    '2169283', '<=',       '10000000',      -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  812, 'MVCC_REC_VERSIONS_ROW_STORE',  'Max. versions per record in row store',           '2169283', '<=',       '30000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  813, 'MVCC_TAB_VERSIONS_ROW_STORE',  'Max. versions per table in row store',            '2169283', '<=',       '1000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  815, 'MVCC_TRANS_START_TIME',        'Age of transaction blocking row store MVCC (s)',  '2169283', '<=',       '10800',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  830, 'ACTIVE_COMMIT_ID_RANGE',       'Active commit ID range',                          '2169283', '<=',       '3000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  832, 'COMMIT_ID_RANGE_SHORTTERM',    'Max. active commit ID range (short-term)',        '2169283', '<=',       '8000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  841, 'ACTIVE_UPDATE_TRANS_CURR',     'Oldest active update transaction current (h)',    '2169283', '<=',       '8.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  842, 'ACTIVE_UPDATE_TRANS_HIST',     'Oldest active update transaction (h, long-term)', '2169283', '<=',       '24.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  843, 'ACTIVE_SQL_CURR',              'Longest running statement current (h)',           '2169283', '<=',       '12.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  844, 'ACTIVE_SQL_HIST',              'Longest running statement (h, long-term)',        '2169283', '<=',       '24.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  846, 'TABLE_MVCC_SNAPSHOT_RANGE',    'Table MVCC snapshot range',                       '2169283', '<=',       '8000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  847, 'ORPHAN_PACKED_LOB_MAPPINGS',   'Orphan packed LOB mappings',                      '2220627', '<=',       '15000000',   59.08,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  848, 'CURRENT_UTID',                 'Current update transaction ID',                   '2633077', '<=',       '3000000000',    -1, 24.01 FROM DUMMY ) UNION ALL
    ( SELECT  848, 'CURRENT_UTID',                 'Current update transaction ID',                   '2633077', '<=',       '3000000000',    30,    30 FROM DUMMY ) UNION ALL
    ( SELECT  849, 'ORPHAN_LOBS',                  'Orphan disk LOBs',                                '2220627', '<=',       '15000000',      -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  851, 'CS_LOB_GARBAGE_COLLECTION',    'Time since last CS LOB garb. coll. (days)',       '2220627', '<=',       '1.20',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  852, 'GC_UNDO_FILE_COUNT',           'Undo and cleanup files',                          '2169283', '<=',       '3000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  853, 'LONG_CS_LOB_GC',               'Max. duration of CS LOB garbage collection (s)',  '2169283', '<=',       '7200',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  854, 'GC_UNDO_FILE_SIZE',            'Undo and cleanup file size (GB)',                 '2169283', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  856, 'TRANSACTIONS_LARGE_UNDO',      'Max. undo size of current transaction (MB)',      '2169283', '<=',       '500.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  857, 'TRANSACTIONS_LARGE_REDO',      'Max. redo size of current transaction (MB)',      '2169283', '<=',       '1000.00',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  858, 'ROLLBACK_RATE',                'Rollbacks per second (mid-term)',                 '2169283', '<=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  860, 'PENDING_SESSIONS_CURRENT',     'Current pending sessions',                        '',        '<=',       '5',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  862, 'ADMCTRL_WAIT_TIME',            'Admission control wait time (s per s, mid-term)', '2222250', '<=',       '0.10',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  863, 'PENDING_SESSIONS_RECENT',      'Avg. pending sessions (short-term)',              '',        '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  864, 'ADMCTRL_EVENTS_RECENT',        'Admission control events (short-term)',           '2222250', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  865, 'ADMCTRL_REJECTS',              'Admission control rejections (long-term)',        '2222250', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  866, 'ADMCTRL_MAX_QUEUE_SIZE',       'Admission control max. queue size (long-term)',   '2222250', '<=',       '200',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  867, 'ADMCTRL_TIMEOUT_REJECTS',      'Admission control queue timeout rejections',      '2222250', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  868, 'CONNECTIONS_QUEUEING',         'Currently queueing connections',                  '2222250', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  869, 'TRACE_COMPRESSOR_ACTIVITY',    'Long trace compressor activities (long-term)',    '2114710', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  870, 'HIGH_SELFWATCHDOG_ACTIVITY',   'SelfWatchDog activity time (%, short-term)',      '1999998', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  871, 'MAX_LOAD_HISTORY_GAP_MIDTERM', 'Max. load history gap (s, mid-term)',             '2222110', '<=',       '60',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  877, 'CONNECTION_REQUEST_RATE',      'New remote connections / s (current)',            '',        '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  878, 'CONNECTIONS_CANCEL_REQUESTED', 'Connections in CANCEL REQUESTED state',           '2169283', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  879, 'SERIALIZABLE_TRANSACTIONS',    'Transactions with isolation level SERIALIZABLE',  '2399990', '=',        '0',             -1,    -1 FrOM DUMMY ) UNION ALL
    ( SELECT  880, 'OPEN_CONNECTIONS',             'Open connections (%)',                            '1910159', '<=',       '90.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  881, 'OPEN_TRANSACTIONS',            'Number of open transactions',                     '2154870', '<=',       '20000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  882, 'PARKED_JOBWORKERS',            'Max. parked JobWorker ratio',                     '2256719', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  883, 'QUEUED_JOBS',                  'Queued jobs',                                     '2222250', '<=',       '200',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  885, 'CUR_HIGH_DURATION_THREADS',    'SqlExecutor threads with significant duration',   '2114710', '<=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  886, 'LOW_DYNAMIC_CONCURRENCY',      'Dynamic JobWorker concurrency too low',           '2222250', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  887, 'CUR_APP_USER_THREADS',         'Application users with significant threads',      '2114710', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  888, 'JOB_QUEUEING_SHARE',           'Job queueing share (%, short-term)',              '2222250', '<=',       '25.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  889, 'WORKLOAD_CLASS_THREAD_LIMIT',  'Workload class thread limit > max_concurrency',   '2222250', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  890, 'REC_POPULAR_THREAD_METHODS',   'Unusual frequent thread methods (short-term)',    '2114710', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  892, 'HIST_POPULAR_THREAD_METHODS',  'Unusual frequent thread methods (long-term)',     '2114710', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  893, 'HIGH_USER_THREAD_LIMIT',       'Users with high thread limit',                    '2222250', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  894, 'HIGH_THREADS_CONC_LIMIT',      'Threads with high concurrency limit (short-term)','2114710', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  895, 'MANY_THREADS_FOR_REQUEST',     'Database requests with many threads (long-term)', '2114710', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  900, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  901, 'INFO_LINE',                    'BACKUP',                                          '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  902, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  909, 'LAST_TRAD_DATA_BACKUP',        'Age of last traditional data backup (days)',      '2039883', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  910, 'LAST_DATA_BACKUP',             'Age of last data backup (days)',                  '1642148', '<=',       '1.20',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  911, 'LAST_DATA_BACKUP_ERROR',       'Age of last data backup error (days)',            '1642148', '>=',       '7.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  913, 'BACKUP_CANCEL_PENDING',        'Backups in cancel pending state',                 '1642148', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  915, 'MIN_DATA_BACKUP_THROUGHPUT',   'Min. data backup throughput (GB/h, mid-term)',    '1999930', '>=',       '200.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  916, 'AVG_DATA_BACKUP_THROUGHPUT',   'Avg. data backup throughput (GB/h, mid-term)',    '1999930', '>=',       '300.00',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  920, 'LAST_LOG_BACKUP',              'Age of last log backup (hours)',                  '1642148', '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  921, 'LAST_LOG_BACKUP_ERROR',        'Age of last log backup error (days)',             '1642148', '>=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  922, 'MAX_LOG_BACKUP_DURATION',      'Maximum log backup duration (s, short-term)',     '2063454', '<=',       '900',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  923, 'LOG_BACKUP_ERRORS_LONGTERM',   'Log backup errors (long-term)',                   '1642148', '<=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  940, 'BACKUP_CATALOG_SIZE',          'Size of backup catalog (MB)',                     '2505218', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  942, 'CATALOG_BACKUP_SIZE_SHARE',    'Catalog size share (%, short-term)',              '2505218', '<=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  945, 'OLDEST_BACKUP_IN_CATALOG',     'Age of oldest backup in catalog (days)',          '2505218', 'between',  '28-150',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  950, 'LOG_SEGMENTS_NOT_FREE',        'Log segments not free for reuse',                 '2083715', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  952, 'LOG_SEGMENTS_FREE',            'Log segments free for reuse',                     '2083715', '<=',       '250',           -1, 59.99 FROM DUMMY ) UNION ALL
    ( SELECT  955, 'SERVICE_LOG_BACKUPS',          'Max. log backups / service / day (short-term)',   '2083715', '<=',       '300',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  960, 'BACKUP_HISTORY_BROKEN',        'Days since backup history broken',                '1642148', '>=',       '31.00',         -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1000, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1001, 'INFO_LINE',                    'LOCKS',                                           '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1002, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1010, 'OLDEST_LOCK_WAIT',             'Age of oldest active trans. lock wait (s)',       '1999998', '<=',       '60',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1011, 'LONG_LOCK_WAITS',              'Trans. lock wait durations > 600 s (short-term)', '1999998', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1020, 'LOCKED_THREADS',               'Threads currently waiting for locks',             '1999998', '<=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1031, 'CONC_BLOCK_TRANS_SHORTTERM',   'Concurrently blocked transactions (short-term)',  '1999998', '<=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1040, 'TRANS_LOCKS_GLOBAL',           'Total current transactional locks',               '1999998', '<=',       '10000000',      -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1045, 'OLD_TRANS_LOCKS',              'Transactional locks older than 1 day',            '1999998', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1052, 'INTERNAL_LOCKS_SHORTTERM',     'Significant internal lock waits (short-term)',    '1999998', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1055, 'INTERNAL_LOCKS_SPIKES',        'Locks with repeated wait spikes (long-term)',     '1999998', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1100, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1101, 'INFO_LINE',                    'SQL',                                             '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1102, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1108, 'LONG_CURSOR_DURATION',         'SQL with long open cursor duration (long-term)',  '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1110, 'TOP_SQL_SQLCACHE',             'SQL using in average > 1 connection (short-term)','2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1113, 'TOP_SQL_THREADSAMPLES_HIST',   'SQL using in average > 1 thread (short-term)',    '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1114, 'SQL_ENGINE_REGRESSIONS',       'SQL with engine performance impact (long-term)',  '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1116, 'CURRENT_PLAN_ID_REGRESSION',   'SQL with current plan ID performance regression', '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1118, 'LONG_RUNNING_JOB',             'Longest running current job (s)',                 '2000002', '<=',       '3600',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1120, 'EXP_TRACE_LONG_RUNNING_SQL',   'Exp. stmt. trace: SQL running > 1 h (short-term)','2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1125, 'COLUMNS_MANY_SCANNED_ROWS',    'Columns with many scanned records',               '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1126, 'ROWTAB_MANY_SCANNED_ROWS',     'Row store tables with many scanned records',      '2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1128, 'SQL_CACHE_RETENTION',          'SQL cache retention time (h)',                    '2124112', '>=',       '24.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1129, 'SQL_CACHE_EVICTIONS_SHORTTERM','SQL cache evictions / h (short-term)',            '2124112', '<=',       '3000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1130, 'SQL_CACHE_EVICTIONS',          'SQL cache evictions / h',                         '2124112', '<=',       '3000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1131, 'SQL_CACHE_HIT_RATIO',          'SQL cache hit ratio (%)',                         '2124112', '>=',       '90.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1138, 'SQLSCRIPT_SQL_CACHE_SHARE',    'SQL cache share consumed by SQLScript (%)',       '2124112', '<=',       '70.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1140, 'SQL_PREPARATION_SHARE',        'SQL preparation runtime share (%)',               '2124112', '<=',       '5.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1142, 'SQL_CACHE_USED_BY_TABLE',      'Tables with high SQL cache utilization',          '2124112', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1143, 'SQL_CACHE_USED_BY_APP_SOURCE', 'App. sources with high SQL cache utilization',    '2124112', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1144, 'SQL_CACHE_INVALIDATION',       'High SQL cache usage by invalid statements (%)',  '2124112', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1145, 'SQL_CACHE_LONG_INLIST',        'SQL cache used by IN lists >= 100 elements (%)',  '2124112', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1146, 'SQL_CACHE_LONG_CONCAT',        'SQL cache used by multiple OR concats (%)',       '2124112', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1147, 'SQL_CACHE_DUPLICATE_HASHES',   'Duplicate statement hashes in SQL cache (%)',     '2124112', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1148, 'SQL_CACHE_FREQUENT_HASH',      'Statements with many SQL cache instantiations',   '2124112', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1149, 'SQL_CACHE_SESSION_LOCAL',      'Statements with SESSION LOCAL sharing type (%)',  '2124112', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1150, 'SQL_CACHE_REFERENCED',         'Referenced statements in SQL cache (%)',          '2124112', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1151, 'PREPARE_EXECUTION_RATIO',      'Prepare vs. execution ratio (%, mid-term)',       '2124112', '<=',       '15.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1152, 'OPEN_SQL_PER_CONNECTION',      'Max. SQL contexts per connection',                '2000002', '<=',       '5000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1155, 'SUSPENDED_SQL',                'Number of SQL statements in SUSPENDED state',     '2169283', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1159, 'MAX_HOURLY_COMMIT_TIME',       'Hourly max. commit I/O time avg. (ms, long-term)','2000000', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1160, 'AVG_COMMIT_TIME',              'Average commit time (ms)',                        '2000000', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1161, 'MAX_COMMIT_IO_TIME',           'Maximum commit I/O time (s, long-term)',          '2000000', '<=',       '30.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1162, 'AVG_COMMIT_IO_TIME',           'Average commit I/O time (ms, long-term)',         '2000000', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1163, 'COMMIT_EXECUTION_RATIO',       'Commit vs. execution ratio (%, mid-term)',        '2000000', '<=',       '15.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1164, 'DISTRIBUTED_EXECUTIONS',       'Unexpected distributed executions',               '2000002', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1165, 'INTERNAL_EXECUTION_SHARE',     'Internal executions (%)',                         '2000002', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1167, 'NULL_STATEMENT_HINTS',         'Statement hints with hint string being NULL',     '2913308', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1168, 'DELIVERED_STATEMENT_HINTS',    'Delivered statement hints implemented',           '2700051', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1169, 'TOTAL_STATEMENT_HINTS',        'Total number of implemented statement hints',     '2400006', '<=',       '150',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1170, 'AVG_DB_REQUEST_TIME',          'Average database request time (ms)',              '2000002', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1180, 'ABAP_BUFFER_LOADING',          'Avg. ABAP buffer loading sessions (short-term)',  '2000002', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1182, 'ABAP_COMPAT_VIEW',             'Avg. compatibility view sessions (short-term)',   '2000002', '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1183, 'ABAP_MULTI_CONCAT',            'Avg. long multi concat sessions (short-term)',    '2000002', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1200, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1201, 'INFO_LINE',                    'APPLICATION',                                     '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1202, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1210, 'DDLOG_SEQUENCE_CACHING',       'DDLOG sequence cache size',                       '2000002', '>=',       '2',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1211, 'DDLOG_SEQUENCE_USAGE',         'DDLOG sequence number range usage (%)',           '1312102', '<=',       '80.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1220, 'QCM_TABLES',                   'QCM conversion tables',                           '9385',    '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1221, 'ZBICZ_TABLES',                 'BW shadow tables',                                '2155151', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1222, 'BW_COLUMN_VIEWS_PER_OBJECT',   'BW objects with many column views',               '3059536', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1230, 'ABAP_ROW_STORE_WORKER_NODE',   'ABAP row store tables on worker node',            '2222277', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1240, 'CONNECTIONS_WITHOUT_APP_INFO', 'Connections without application information (%)', '',        '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1250, 'BPC_TABLES',                   'Physical BPC tables',                             '2445363', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1252, 'ABAP_POOL_CLUSTER_TABLES',     'Physical ABAP pool and cluster tables',           '1892354', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1255, 'OUTDATED_CLIENT_VERSION',      'Connections with outdated client version',        '2393013', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1257, 'PLUGIN_FAILURES',              'Plugin registration failures',                    '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1270, 'TWO_COLUMN_MANDT_INDEXES',     'Two-column indexes including client column',      '2160391', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1280, 'SNAP_GROWTH_SHORTTERM',        'Growth of short dump table SNAP (GB, short-term)','2399990', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1285, 'ABAP_UPDATE_ERRORS',           'Number of update records in error state',         '',        '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1300, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1301, 'INFO_LINE',                    'SECURITY',                                        '2159014', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1302, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1310, 'SECURE_STORE_AVAILABLE',       'Secure store (SSFS) status',                      '1977221', '=',        'available',     -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1312, 'INCONSISTENT_SECURE_STORE',    'Inconsistent secure store',                       '2097613', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1331, 'CONNECTION_USER_EXPIRATION',   'Connection user with (password) expiration',      '2159014', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1333, 'EXPIRING_CERTIFICATES',        'Certificates with previous or upcoming expiry',   '2159014', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1340, 'CATALOG_READ_GRANTED',         'CATALOG READ privilege granted to current user',  '1640741', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1360, 'AUDIT_LOG_SIZE',               'Size of audit log table (GB)',                    '2388483', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1400, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1401, 'INFO_LINE',                    'LICENSE',                                         '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1402, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1410, 'LICENSE_LIMIT',                'License usage (%)',                               '1704499', '<=',       '95',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1415, 'LICENSE_EXPIRATION',           'License expiration (days)',                       '1644792', '>=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1420, 'PERMANENT_LICENSE',            'Permanent license',                               '1644792', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1500, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1501, 'INFO_LINE',                    'NETWORK',                                         '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1502, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1510, 'SERVICE_SEND_INTRANODE',       'Avg. intra node send throughput (MB/s)',          '2222200', '>=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1512, 'SERVICE_SEND_INTERNODE',       'Avg. inter node send throughput (MB/s)',          '2222200', '>=',       '16',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1520, 'TCP_RETRANSMITTED_SEGMENTS',   'Retransmitted TCP segments (%)',                  '2222200', '<=',       '1.00000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1522, 'TCP_BAD_SEGMENTS',             'Bad TCP segments (%)',                            '2222200', '<=',       '0.10000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1524, 'COLLISION_SHARE_CURR',         'Current network collision share (%)',             '2222200', '<=',       '1.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1525, 'SEND_ERROR_SHARE_CURR',        'Current send error share (%)',                    '2222200', '<=',       '0.10',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1526, 'RECEIVE_ERROR_SHARE_CURR',     'Current receive error share (%)',                 '2222200', '<=',       '0.10',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1530, 'NETWORK_VOLUME_INTRANODE',     'Avg. intra node communication volume (MB/s)',     '2222200', '<=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1532, 'NETWORK_VOLUME_INTERNODE',     'Avg. inter node communication volume (MB/s)',     '2222200', '<=',       '20',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1540, 'HOST_NAME_RESOLUTION',         'Host name resolution for non IP addresses',       '2222200', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1550, 'NETWORK_POLL_SHARE',           'Network Poll thread state share (%, short-term)', '2222200', '<=',       '20.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1551, 'NETWORK_READ_SHARE',           'Network Read thread state share (%, short-term)', '2222200', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1552, 'NETWORK_WRITE_SHARE',          'Network Write thread state share (%, short-term)','2222200', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1554, 'CONNECTIONS_RECEIVING',        'Connections with status RECEIVING',               '2222200', '<=',       '5',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1555, 'CONNECTIONS_SENDING',          'Connections with status SENDING',                 '2222200', '<=',       '5',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1700, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1701, 'INFO_LINE',                    'NAMESERVER',                                      '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1702, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1712, 'PING_TIME_SHORTTERM',          'Avg. load history ping time (ms, short-term)',    '2222110', '<=',       '400.00',        -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1800, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1801, 'INFO_LINE',                    'SYSTEM REPLICATION',                              '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1802, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1810, 'REPLICATION_ERROR',            'Services with replication error',                 '1999880', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1811, 'REPLICATION_UNKNOWN',          'Services with unknown replication state',         '1999880', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1813, 'REP_CONNECTION_CLOSED',        'Replication connection closed (short-term)',      '1999880', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1814, 'OLD_LOG_POSITION',             'Log position gap (MB)',                           '2436931', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1815, 'LOG_SHIPPING_DELAY',           'Current log shipping delay (s)',                  '1999880', '<=',       '60',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1816, 'LOG_SHIPPING_ASYNC_BUFF_FILL', 'Filling level of async shipping buffer (%)',      '1999880', '<=',       '50',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1818, 'ASYNC_BUFFER_FULL_SHORTTERM',  'Async log shipping buffer full (short-term)',     '1999880', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1820, 'REP_PARAMETER_DEVIATION',      'Parameter deviations primary vs. secondary site', '1999880', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1830, 'OLDEST_REPLICATION_SNAPSHOT',  'Age of oldest replication snapshot (h)',          '1999880', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1835, 'INITIAL_DATA_SHIPPING_TIME',   'Max. initial data shipping time (h)',             '1999880', '<=',       '24.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1843, 'SYNC_LOG_SHIPPING_TIME_REC',   'Avg. sync log shipping time (ms, short-term)',    '1999880', '<=',       '2.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1846, 'SYNC_LOG_SHIPPING_TIME_HIST',  'Max. sync log shipping time (ms, long-term)',     '1999880', '<=',       '10.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1850, 'SR_LOGREPLAY',                 'System replication op. mode logreplay used',      '1999880', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1852, 'SR_LOGREPLAY_BACKLOG_CURR',    'Current log replay backlog (GB)',                 '2661878', '<=',       '10',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1853, 'SR_LOGREPLAY_DELAY_CURR',      'Current log replay delay (s)',                    '2661878', '<=',       '600',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1854, 'SR_LOGREPLAY_BACKLOG_HIST',    'Max. log replay backlog (GB, long-term)',         '2661878', '<=',       '30',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1855, 'SR_LOGREPLAY_DELAY_HIST',      'Max. log replay delay (s, long-term)',            '2661878', '<=',       '1800',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1860, 'DATASHIPPING_LOGRETENTION',    'Datashipping combined with log retention',        '1999880', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1861, 'DATASHIPPING_LOGREPLAY',       'Both delta_datashipping and logreplay used',      '1999880', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1865, 'REPLICATION_SAVEPOINT_DELAY',  'System replication savepoint delay (h)',          '1999880', '<=',       '4.00',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1900, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1901, 'INFO_LINE',                    'OBJECTS',                                         '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1902, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1920, 'INVALID_PROCEDURES',           'Number of invalid procedures',                    '2935599', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1940, 'NO_CACHE_SEQUENCES',           'Sequences with insufficient caching',             '2600095', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1945, 'CROSS_NODE_TRIGGERS',          'Cross node triggers',                             '2800020', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1950, 'FULLTEXT_INDEX_ERRORS',        'Columns with significant text indexing errors',   '2800008', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1952, 'FULLTEXT_INDEX_QUEUED',        'Documents queued for fulltext indexing',          '2800008', '<=',       '1000000',       -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1960, 'CALCULATION_SCENARIOS',        'Number of calculation scenarios',                 '',        '<=',       '200000',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1962, 'TEMPORARY_VIEWS',              'Number of temporary views',                       '',        '<=',       '200000',        -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1970, 'MANY_DEPENDENT_OBJECTS',       'Objects with many direct dependencies',           '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2000, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2001, 'INFO_LINE',                    'BW',                                              '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2002, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2010, 'EMPTY_TABLE_PLACEMENT',        'Empty TABLE_PLACEMENT table in BW',               '1908075', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2020, 'NUM_PARTITIONED_SID_TABLES',   'Partitioned SID tables',                          '2044468', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2022, 'SID_TABLES_WITH_MANY_RECORDS', 'SID tables > 1.5 billion rows',                   '1331403', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2025, 'NUM_PART_SPECIAL_TABLES',      'Partitioned special BW tables < 1.5 bill. rows',  '2044468', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2027, 'HIGH_PARTNO_VALUE',            'Tables with high sub-partition PARTNO',           '2002607', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2040, 'TEMPORARY_BW_TABLES_CLASSIC',  'Temporary BW tables (/BI0/0)',                    '2388483', '<=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2041, 'TEMPORARY_BW_TABLES_HANA',     'Temporary BW tables (0BW)',                       '2800007', '<=',       '10000',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2042, 'AGGREGATE_BW_TABLES',          'BW aggregate tables',                             '2388483', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2050, 'INVERTED_HASH_ON_BW_TABLE',    'BW tables with inverted hash indexes',            '2109355', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2100, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2101, 'INFO_LINE',                    'CONSISTENCY',                                     '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2102, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2110, 'CTC_ERRORS_LONGTERM',          'CHECK_TABLE_CONSISTENCY errors (long-term)',      '1977584', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2113, 'LAST_CTC_RUN',                 'Last global table consistency check (days)',      '2116157', '<=',       '32',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2115, 'CS_TABLES_OLD_CTC',            'Tables without recent consistency check',         '2116157', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2116, 'CS_TABLES_CTC_ERRORS',         'Tables with consistency check errors',            '2116157', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2118, 'CTC_TAB_CONTAINER_LOAD',       'Table container check with load configured',      '2116157', '=',        'no',            33,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2130, 'TOPOLOGY_DAEMON_INCONSISTENT', 'Inconsistencies between topology and daemon',     '2222249', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2132, 'TOPOLOGY_INCONSISTENCY',       'Topology inconsistency alert raised (short-term)','1977584', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2135, 'TOPOLOGY_ROLES_INCONSISTENT',  'Inconsistent node role definition in topology',   '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2140, 'METADATA_DEP_INCONSISTENT',    'Inconsistencies of metadata and dependencies',    '2498587', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2150, 'MISSING_CONCATS',              'Missing index concat attributes',                 '2160391', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2200, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2201, 'INFO_LINE',                    'SMART DATA ACCESS / SMART DATA INTEGRATION',      '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2202, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2210, 'SDA_TABLES_WITHOUT_STATS',     'SDA tables without statistics',                   '2180119', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2212, 'SDA_CONNECTIONS',              'Number of existing remote connections',           '3157460', '<=',       '1000',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2214, 'SDA_SAFE_MODE',                'SDA active but safe mode not configured',         '2602761', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2220, 'SDI_SUBSCRIPTION_EXCEPTIONS',  'SDI remote subscription exceptions (short-term)', '2400022', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2222, 'SDI_APPLY_DELAY',              'SDI max. remote subscription apply delay (s)',    '2400022', '<=',       '300',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2224, 'SDI_QUEUED_SUBSCRIPTIONS',     'SDI remote subscriptions in queueing state',      '2400022', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2226, 'SDI_PERSISTENCE_SIZE',         'SDI persistence size (GB)',                       '2400022', '<=',       '3.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2230, 'DPSERVER_ON_WORKER_NODES',     'Worker nodes with dpserver processes',            '2391341', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2240, 'DPSERVER_SOURCE_SELECTS',      'Avg. SDI source select sessions (short-term)',    '2400022', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2250, 'DPAGENT_MEMORY_CONSUMPTION',   'Max. dpagent phys. memory consumption (%)',       '2400022', '<=',       '80.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2252, 'DPSERVER_DISK_SIZE',           'Current dpserver data disk size (GB)',            '2400022', '<=',       '50.00',         -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2260, 'ORPHAN_DPSERVER_SERVICE',      'Orphan dpserver service',                         '3014471', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2300, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2301, 'INFO_LINE',                    'ADMINISTRATION',                                  '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2302, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2310, 'HDBSTUDIO_CONNECTIONS',        'SAP HANA Studio connections',                     '2073112', '<=',       '100',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2315, 'OUTDATED_HDBSTUDIO_VERSION',   'Connections with old SAP HANA Studio versions',   '2073112', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2330, 'PARAMETERS_HOST_LEVEL',        'Parameters set on host level',                    '2186744', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2332, 'PARAMETERS_REQUIRING_RESTART', 'Parameter changes requiring a SAP HANA restart',  '2186744', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2334, 'PARAMETERS_WRONG_VALUES',      'Unsupported parameter settings',                  '2186744', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2336, 'PARAMETERS_MANY_CHANGES',      'Parameters with many changes',                    '2186744', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2340, 'DEPRECATED_FEATURES_USED',     'Deprecated features used (long-term)',            '2425002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2400, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2401, 'INFO_LINE',                    'TABLE REPLICATION',                               '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2402, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2410, 'INACTIVE_TABLE_REPLICAS',      'Inactive table replicas',                         '2340450', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2415, 'RTEDUMP_TABREP_DEACTIVATED',   'Last table replication deactivation dump (days)', '2400007', '>=',       '7.00',       24.01,    -1 FROM DUMMY ) UNION ALL   

    ( SELECT 2500, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2501, 'INFO_LINE',                    'SLT',                                             '2014562', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2502, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2510, 'ORPHAN_SLT_SEQUENCES',         'Orphan SLT sequences',                            '2600095', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2520, 'SLT_TRIGGER_SUBSTRING',        'Triggers with outdated substring calculation',    '2399990', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2522, 'SLT_TEMP_TRIGGERS',            'Existing temporary SLT triggers',                 '2800020', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2530, 'SLT_LOGGING_SESSIONS',         'Avg. SLT logging sessions (short-term)',          '2000002', '<=',       '0.50',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2540, 'SLT_LOGGING_TABLE_SIZE',       'SLT logging tables with significant record count','2000002', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2600, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2601, 'INFO_LINE',                    'ENTERPRISE SEARCH',                               '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2602, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2610, 'ORPHAN_CALC_ESH_COLUMNS',      'Orphan calculated ESH columns',                   '2685716', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2700, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2701, 'INFO_LINE',                    'NSE / DATA AGING / DATA TIERING',                 '2799997', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2702, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2710, 'PAGED_LOB_COLUMNS',            'Paging active for LOB columns',                   '2994330', '=',        '0',             -1,    54 FROM DUMMY ) UNION ALL
    ( SELECT 2715, 'NSE_BUFFER_RATIO',             'Warm data vs. NSE buffer cache ratio',            '2799997', '<=',       '8.00',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2720, 'NSE_OUT_OF_BUFFER_COUNT',      'NSE out-of-buffer count',                         '2799997', '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2725, 'NSE_BUFFER_FRAGMENTATION',     'NSE buffer fragmentation (%)',                    '2799997', '<=',       '50',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2730, 'NSE_LARGE_COLUMNS',            'Columns with significant NSE buffer size share',  '2799997', '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 2800, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2801, 'INFO_LINE',                    'DOCUMENT STORE',                                  '2477204', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2802, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2810, 'ORPHAN_DOCSTORE_SERVICE',      'Orphan docstore service',                         '3014471', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 2820, 'COLLECTION_OBJECT_ID',         'Maximum collection ID',                           '3280896', '<=',       '1500000000',    -1, 59.06 FROM DUMMY ) UNION ALL
    ( SELECT 2820, 'COLLECTION_OBJECT_ID',         'Maximum collection ID',                           '3280896', '<=',       '1500000000',    60,    65 FROM DUMMY ) UNION ALL
 
    ( SELECT 9000, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 9001, 'INFO_LINE',                    'END OF CHECK',                                    '',        'any',      'any',           -1,    -1 FROM DUMMY )

/* TMC_GENERATION_END_2 */
  ) CC,
    GENERAL_INFO GI
  WHERE
    C.NAME = CC.NAME AND
    ( IFNULL(C.HOST, '') = '' OR C.HOST LIKE BI.HOST ) AND	
    GI.REVISION BETWEEN CC.MIN_REV AND MAP(CC.MAX_REV, -1, 99999, CC.MAX_REV) AND
    ( BI.CHECK_ID = -1 OR CC.CHECK_ID = BI.CHECK_ID ) AND
    ( BI.CHECK_GROUP = '%' OR
      BI.CHECK_GROUP = 'GENERAL'                                    AND CC.CHECK_ID BETWEEN    0 AND  199 OR
      BI.CHECK_GROUP = 'OPERATING SYSTEM'                           AND CC.CHECK_ID BETWEEN  200 AND  299 OR
      BI.CHECK_GROUP = 'DISKS'                                      AND CC.CHECK_ID BETWEEN  300 AND  399 OR
      BI.CHECK_GROUP = 'MEMORY'                                     AND CC.CHECK_ID BETWEEN  400 AND  499 OR
      BI.CHECK_GROUP = 'TABLES'                                     AND CC.CHECK_ID BETWEEN  500 AND  599 OR
      BI.CHECK_GROUP = 'TRACES, DUMPS AND LOGS'                     AND CC.CHECK_ID BETWEEN  600 AND  699 OR
      BI.CHECK_GROUP = 'STATISTICS SERVER'                          AND CC.CHECK_ID BETWEEN  700 AND  799 OR
      BI.CHECK_GROUP = 'TRANSACTIONS AND THREADS'                   AND CC.CHECK_ID BETWEEN  800 AND  899 OR
      BI.CHECK_GROUP = 'BACKUP'                                     AND CC.CHECK_ID BETWEEN  900 AND  999 OR
      BI.CHECK_GROUP = 'LOCKS'                                      AND CC.CHECK_ID BETWEEN 1000 AND 1099 OR
      BI.CHECK_GROUP = 'SQL'                                        AND CC.CHECK_ID BETWEEN 1100 AND 1199 OR
      BI.CHECK_GROUP = 'APPLICATION'                                AND CC.CHECK_ID BETWEEN 1200 AND 1299 OR
      BI.CHECK_GROUP = 'SECURITY'                                   AND CC.CHECK_ID BETWEEN 1300 AND 1399 OR
      BI.CHECK_GROUP = 'LICENSE'                                    AND CC.CHECK_ID BETWEEN 1400 AND 1499 OR
      BI.CHECK_GROUP = 'NETWORK'                                    AND CC.CHECK_ID BETWEEN 1500 AND 1599 OR
      BI.CHECK_GROUP = 'XS ENGINE'                                  AND CC.CHECK_ID BETWEEN 1600 AND 1699 OR
      BI.CHECK_GROUP = 'NAMESERVER'                                 AND CC.CHECK_ID BETWEEN 1700 AND 1799 OR
      BI.CHECK_GROUP = 'SYSTEM REPLICATION'                         AND CC.CHECK_ID BETWEEN 1800 AND 1899 OR
      BI.CHECK_GROUP = 'OBJECTS'                                    AND CC.CHECK_ID BETWEEN 1900 AND 1999 OR
      BI.CHECK_GROUP = 'BW'                                         AND CC.CHECK_ID BETWEEN 2000 AND 2099 OR
      BI.CHECK_GROUP = 'CONSISTENCY'                                AND CC.CHECK_ID BETWEEN 2100 AND 2199 OR
      BI.CHECK_GROUP = 'SMART DATA ACCESS / SMART DATA INTEGRATION' AND CC.CHECK_ID BETWEEN 2200 AND 2299 OR
      BI.CHECK_GROUP = 'ADMINISTRATION'                             AND CC.CHECK_ID BETWEEN 2300 AND 2399 OR
      BI.CHECK_GROUP = 'TABLE REPLICATION'                          AND CC.CHECK_ID BETWEEN 2400 AND 2499 OR
      BI.CHECK_GROUP = 'SLT'                                        AND CC.CHECK_ID BETWEEN 2500 AND 2599 OR
      BI.CHECK_GROUP = 'ENTERPRISE SEARCH'                          AND CC.CHECK_ID BETWEEN 2600 AND 2699 OR
      BI.CHECK_GROUP = 'NSE / DATA AGING / DATA TIERING'            AND CC.CHECK_ID BETWEEN 2700 AND 2799 OR
      BI.CHECK_GROUP = 'DOCUMENT STORE'                             AND CC.CHECK_ID BETWEEN 2800 AND 2899
    ) AND
    ( GI.DB_TYPE = 'TENANT' OR 
      BI.SKIP_LESS_RELEVANT_CHECKS_IN_SYSTEMDB = ' ' OR
      CC.CHECK_ID NOT IN (314, 364, 371, 385, 411, 474, 551, 552, 718, 744, 750, 751, 753, 915, 916, 942, 1031, 1128, 1142, 1165, 1168, 1170, 1550, 2113, 2115, 2118)
    ) AND
    ( GI.DB_TYPE = 'TENANT' OR
      BI.SKIP_OVERLAPPING_CHECKS_IN_SYSTEMDB = ' ' OR
      CC.CHECK_ID NOT IN (12, 208, 221, 222, 236, 245, 250, 409, 410, 413, 811, 862, 866, 1031, 1410)
    )
) M
WHERE
  ONLY_POTENTIALLY_CRITICAL_RESULTS = ' ' OR POTENTIALLY_CRITICAL = 'X' OR M.CHECK_ID <= 11 OR M.CHECK_ID >= 9000
ORDER BY
  MAP(M.ORDER_BY, 'CHECK', M.CHECK_ID),
  M.HOST,
  M.VALUE
WITH HINT (IGNORE_PLAN_CACHE, OPTIMIZATION_LEVEL(RULE_BASED))
