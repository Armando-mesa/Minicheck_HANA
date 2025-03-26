WITH 

/*

[NAME]

- HANA_Global_CurrentStateReport_2.00.053+

[DESCRIPTION]

- Collection of current load and performance information

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- APPLICATION_SOURCE and APPLICATION_NAME in M_SQL_PLAN_CACHE available starting with Rev. 1.00.122.15 (and 2.00.012.04 / 2.00.024.00)
- M_HOST_AGENT_METRICS available with SAP HANA >= 2.00.020
- NUMA_NODE_INDEX available starting with SAP HANA 2.00.040
- M_HOST_RESOURCE_UTILIZATION.ACTIVE_ASYNC_IO_COUNT available starting with SAP HANA 2.00.040
- M_JOBEXECUTORS.MAX_CONCURRENCY_CONFIG available with SAP HANA >= 2.00.042
- EXECUTION_ENGINE available with SAP HANA >= 2.00.053
- With SAP HANA 2.00.060 - 2.00.063 the implicit M_CACHES access can result in indexserver crashes (bug 289445). In order to avoid this risk you can
  remove the M_CACHES section from the command before running it.

[VALID FOR]

- Revisions:              >= 2.00.053

[SQL COMMAND VERSION]

- 2019/05/02:  1.0 (initial version)
- 2019/05/14:  1.1 (dedicated 2.00.040+ version)
- 2019/07/13:  1.2 (ACTIVE_ASYNC_IO_COUNT included)
- 2019/11/23:  1.3 (PARAMETER SETTINGS and LOG_SHIP_MS added)
- 2019/12/14:  1.4 ("I/O key figures" and metadata versions added)
- 2019/12/17:  1.5 (CACHES and TEMPORARY TABLES added)
- 2020/04/15:  1.6 (dedicated 2.00.042+ version including MAX_CONCURRENCY_CONFIG)
- 2020/04/16:  1.7 (M_JOIN_TRANSLATION_TABLES included)
- 2020/08/04:  1.8 (M_SQL_PLAN_CACHE_OVERVIEW added)
- 2020/09/24:  1.9 (Q column for job queueing in threads overview added)
- 2020/09/26:  2.0 ("CALCULATION SCENARIOS" and SECONDARY_ACTIVE_STATUS added)
- 2021/01/25:  2.1 ("TRANSACTIONAL LOCKS" added)
- 2021/08/17:  2.2 (dedicated 2.00.053+ version including EXECUTION_ENGINE)
- 2021/12/18:  2.3 (LOCK_OWNER_THREAD_ID and EXCLUDE_TRANSLATION_TABLES included)
- 2022/01/29:  2.4 (ACTIVE_PROCEDURES included)

[INVOLVED TABLES]

- HOST_SERVICE_REPLICATION
- HOST_SQL_PLAN_CACHE_OVERVIEW
- HOST_VOLUME_IO_TOTAL_STATISTICS
- M_ACTIVE_PROCEDURES
- M_ACTIVE_STATEMENTS
- M_CACHES
- M_CE_CALCSCENARIOS_OVERVIEW
- M_GARBAGE_COLLECTION_STATISTICS
- M_HOST_AGENT_METRICS
- M_HOST_INFORMATION
- M_HOST_RESOURCE_UTILIZATION
- M_JOBEXECUTORS
- M_JOIN_TRANSLATION_TABLES
- M_LOAD_HISTORY_SERVICE
- M_MVCC_OVERVIEW
- M_RECORD_LOCKS
- M_SERVICE_THREAD_CALLSTACKS
- M_SERVICE_THREADS
- M_SQL_PLAN_CACHE
- M_SQL_PLAN_CACHE_OVERVIEW
- M_TABLE_SNAPSHOTS
- M_TEMPORARY_TABLES
- M_TRANSACTIONS
- M_WORKLOAD

[INPUT PARAMETERS]

- HOST

  Host name

  'saphana01'     --> Specific host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- EXCLUDE_PHANTOM_THREADS

  Possibility to exclude idle threads that are shown as "active" due to SAP HANA bugs

  'X'             --> Do not show idle threads that are shown as active threads
  ' '             --> No restriction of displayed threads

- EXCLUDE_TRANSLATION_TABLES

  Possibility to exclude translation tables section (can be quite time consuming for limited benefit)

  'X'             --> Exclude translation tables section
  ' '             --> Include translation tables section

- EXCLUDE_CALLSTACKS

  Possibility to exclude the callstack section in the output

  'X'             --> Do not list thread callstacks
  ' '             --> List thread callstacks

- MAX_COL_LEN

  Maximum length of output columns

  40              --> Limit the size of potentially long output columns to 40 characters
  -1              --> No restriction related to output column length

- LINE_LENGTH

  Maximum displayed line size

  50              --> Lines are truncated at 50 characters
  -1              --> No line truncation

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOST'          --> Aggregation by host
  'HOST, PORT'    --> Aggregation by host and port
  'NONE'          --> No aggregation

[OUTPUT PARAMETERS]

- LINE: Timeframe report (use monospaced output for optimal display)

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LINE                                                                                                                                                                         |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|*********************************                                                                                                                                            |
|* SAP HANA CURRENT STATE REPORT *                                                                                                                                            |
|*********************************                                                                                                                                            |
|                                                                                                                                                                             |
|Generated with:     SQL: "HANA_Global_CurrentStateReport" (SAP Note 1969700)                                                                                                 |
|Analysis time:      2019/05/02 12:32:33                                                                                                                                      |
|Database name:      C11                                                                                                                                                      |
|Revision level:     2.00.036.00.1547699771                                                                                                                                   |
|Configuration:      Host: all, port: all, aggregation: ALL                                                                                                                   |
|                                                                                                                                                                             |
|***************************                                                                                                                                                  |
|* LOAD AND STATE OVERVIEW *                                                                                                                                                  |
|***************************                                                                                                                                                  |
|                                                                                                                                                                             |
|CPU,       | CPU_CORES CPU_THREADS CPU_PCT SYS_PCT PING_MS MEM_PHYS_GB ALLOC_LIM_GB MEM_USED_GB UNLOADS                                                                      |
|memory     | ========= =========== ======= ======= ======= =========== ============ =========== =======                                                                      |
|           |       112         224       0       0      62        3022         1259         816       0                                                                      |
|                                                                                                                                                                             |
|Sessions,  | STMTS_PER_S PEND_SESSIONS   CONNS BUSY_CONNS TRANSACTIONS BLOCKED_TRANS THREADS ACT_THREADS WAIT_THREADS TOT_SQL ACT_SQL WAIT_SQL                               |
|threads,   | =========== ============= ======= ========== ============ ============= ======= =========== ============ ======= ======= ========                               |
|statements |           8             0     119          0           37             0     833           1            0     447       0        0                               |
|                                                                                                                                                                             |
|Disk I/O   | DATA_READ_MBPS DATA_READ_ACT_PCT DATA_WRT_MBPS DATA_WRT_ACT_PCT LOG_READ_MBPS LOG_READ_ACT_PCT LOG_WRT_MBPS LOG_WRT_ACT_PCT                                     |
|           | ============== ================= ============= ================ ============= ================ ============ ===============                                     |
|           |              0                 0             0                0             0                0            0               0                                     |
|                                                                                                                                                                             |
|MVCC,      | LOCAL_LOCK_START    GLOBAL_LOCK_START   HIST_FILES  VERSIONS COMM_ID_RANGE                                                                                      |
|garbage    | =================== =================== ========== ========= =============                                                                                      |
|collection |                     2019/05/02 12:32:32          0         0             0                                                                                      |
|                                                                                                                                                                             |
|Workload   | EXEC_PER_S COMP_PER_S TRANS_PER_S UPD_TRANS_PER_S COMMITS_PER_S ROLLBACKS_PER_S MEM_MB_PER_S                                                                    |
|           | ========== ========== =========== =============== ============= =============== ============                                                                    |
|           |         25          3           1               1             1               0            0                                                                    |
|                                                                                                                                                                             |
|******************                                                                                                                                                           |
|* MEMORY DETAILS *                                                                                                                                                           |
|******************                                                                                                                                                           |
|                                                                                                                                                                             |
|HEAP_ALLOCATOR                                                       MEM_USED_GB COUNT COMPONENT                                                                             |
|==================================================================== =========== ===== ========================================                                              |
|Pool/ColumnStore/Main/Dictionary/RoDict                                   346.07     1 Column Store Tables                                                                   |
|Pool/ColumnStore/Main/Index/Single                                        114.08     1 Column Store Tables                                                                   |
|Pool/ColumnStore/Main/Uncompressed                                         82.86     1 Column Store Tables                                                                   |
|Pool/ColumnStore/Main/Rowid                                                76.10     1 Column Store Tables                                                                   |
|Pool/ColumnStore/Main/Compressed/Indirect                                  38.16     1 Column Store Tables                                                                   |
|Pool/ColumnStore/Main/Compressed/Sparse                                    13.91     1 Column Store Tables                                                                   |
|Pool/PersistenceManager/UnifiedTableContainer                              13.65     1 Column Store Tables                                                                   |
|Pool/PersistenceManager/PersistentSpace/DefaultLPA/Page                    11.80     1 System                                                                                |
|                                                                                                                                                                             |
|*******************                                                                                                                                                          |
|* THREAD ACTIVITY *                                                                                                                                                          |
|*******************                                                                                                                                                          |
|                                                                                                                                                                             |
|   CONN_ID THREAD_ID DUR_S CPU_S THRE STATE    STATEMENT_HASH                                                                                                                |
|========== ========= ===== ===== ==== =======  ================================                                                                                              |
|        -1         0 26859   142 Main Running                                                                                                                                |
|                                                                                                                                                                             |
|**************                                                                                                                                                               |
|* CALLSTACKS *                                                                                                                                                               |
|**************                                                                                                                                                               |
|                                                                                                                                                                             |
|   CONN_ID THREAD_ID LVL MODULE_NAME                                                                                                                                         |
|========== ========= === ================================================================================                                                                    |
|        -1         0   1 __GI_epoll_pwait+0x80 (libc.so.6)                                                                                                                   |
|                       2 System::UX::epoll_pwait(int, epoll_event*, int, int, __sigset_t const*)+0x50 at SystemCallsUNIX.cpp:142 (libhdbbasis.so)                            |
|                       3 Stream::CompletionSet::epollImpl(int)+0x40 at CompletionSet.cpp:112 (libhdbbasis.so)                                                                |
|                       4 Stream::CompletionSet::poll(int)+0xc0 at CompletionSet.cpp:501 (libhdbbasis.so)                                                                     |
|                       5 comm::select(void*, int)+0x50 at commlibImpl.cpp:2518 (libhdbbasement.so)                                                                           |
|                       6 TrexNet::Responder::getNext()+0x266 at Responder.cpp:983 (libhdbbasement.so)                                                                        |
|                       7 nlsui_main+0x19bb at TrexService.cpp:690 (hdbxsengine)                                                                                              |
|                       8 System::mainWrapper(int, char**, char**)+0x72 at IsInMain.cpp:332 (libhdbbasis.so)                                                                  |
|                       9 __libc_start_main+0xf1 (libc.so.6)                                                                                                                  |
|                                                                                                                                                                             |
|****************************************                                                                                                                                     |
|* END OF SAP HANA CURRENT STATE REPORT *                                                                                                                                     |
|****************************************                                                                                                                                     |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/  

BASIS_INFO AS
( SELECT
    HOST,
    PORT,
    EXCLUDE_PHANTOM_THREADS,
    EXCLUDE_TRANSLATION_TABLES,
    EXCLUDE_CALLSTACKS,
    MAX_COL_LEN,
    LINE_LENGTH,
    AGGREGATE_BY,
    HOST_LEN,
    CASE WHEN AGGREGATE_BY LIKE '%HOST%' OR AGGREGATE_BY = 'NONE' THEN RPAD('HOST', HOST_LEN + 1) ELSE '' END || CASE WHEN AGGREGATE_BY LIKE '%PORT%' OR AGGREGATE_BY = 'NONE' THEN RPAD('PORT', 6) ELSE '' END H1_PREFIX,
    CASE WHEN AGGREGATE_BY LIKE '%HOST%' OR AGGREGATE_BY = 'NONE' THEN RPAD('HOST', HOST_LEN + 1) ELSE '' END H1_NO_PORT_PREFIX,
    CASE WHEN AGGREGATE_BY LIKE '%HOST%' OR AGGREGATE_BY = 'NONE' THEN RPAD('=', HOST_LEN, '=') || CHAR(32) ELSE '' END || CASE WHEN AGGREGATE_BY LIKE '%PORT%' OR AGGREGATE_BY = 'NONE' THEN RPAD('=', 5, '=') || CHAR(32) ELSE '' END H2_PREFIX,
    CASE WHEN AGGREGATE_BY LIKE '%HOST%' OR AGGREGATE_BY = 'NONE' THEN RPAD('=', HOST_LEN, '=') || CHAR(32) ELSE '' END H2_NO_PORT_PREFIX
  FROM
  ( SELECT                                   /* Modification section */
      '%' HOST,
      '%' PORT,
      'X' EXCLUDE_PHANTOM_THREADS,
      'X' EXCLUDE_TRANSLATION_TABLES,
      ' ' EXCLUDE_CALLSTACKS,
      50 MAX_COL_LEN,
      -1 LINE_LENGTH,
      'ALL' AGGREGATE_BY              /* HOST, PORT or comma separated combinations, NONE for no aggregation, ALL for complete aggregation */
    FROM
      DUMMY
  ),
  ( SELECT MAX(LENGTH(HOST)) HOST_LEN FROM
    ( SELECT DISTINCT(HOST) HOST FROM M_HOST_INFORMATION UNION ALL
      SELECT DISTINCT(HOST) HOST FROM M_SERVICE_REPLICATION )
  )
),
LOAD AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN L.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(L.PORT) ELSE 'any' END PORT,
    TO_DECIMAL(MAX(L.CPU), 10, 0) CPU,
    TO_DECIMAL(MAX(L.SYSTEM_CPU), 10, 0) SYSTEM_CPU,
    TO_DECIMAL(MAX(L.MEMORY_USED / 1024 / 1024 / 1024), 10, 0) MEM_USED_GB,
    TO_DECIMAL(MAX(L.MEMORY_ALLOCATION_LIMIT / 1024 / 1024 / 1024), 10, 0) ALLOC_LIM_GB,
    TO_DECIMAL(MAX(L.PING_TIME), 10, 0) PING_MS,
    TO_DECIMAL(GREATEST(0, SUM(L.CONNECTION_COUNT)), 10, 0) CONNECTION_COUNT,
    TO_DECIMAL(GREATEST(0, SUM(L.IDLE_CONNECTION_COUNT)), 10, 0) IDLE_CONNECTION_COUNT,
    TO_DECIMAL(GREATEST(0, SUM(L.TRANSACTION_COUNT)), 10, 0) TRANSACTION_COUNT,
    TO_DECIMAL(GREATEST(0, SUM(L.BLOCKED_TRANSACTION_COUNT)), 10, 0) BLOCKED_TRANSACTION_COUNT,
    TO_DECIMAL(GREATEST(0, SUM(L.STATEMENT_COUNT) / MAX(L.INTERVAL_S)), 10, 0) STMTS_PER_S,
    TO_DECIMAL(GREATEST(0, MAX(L.COMMIT_ID_RANGE)), 10, 0) COMMIT_ID_RANGE,
    TO_DECIMAL(GREATEST(0, SUM(L.MVCC_VERSION_COUNT)), 10, 0) VERSIONS,
    TO_DECIMAL(GREATEST(0, SUM(L.PENDING_SESSION_COUNT)), 10, 0) PENDING_SESSIONS,
    TO_DECIMAL(GREATEST(0, SUM(L.CS_UNLOAD_COUNT)), 10, 0) UNLOADS,
    TO_DECIMAL(GREATEST(0, SUM(L.ACTIVE_THREAD_COUNT)), 10, 0) ACT_THREADS,
    TO_DECIMAL(GREATEST(0, SUM(L.WAITING_THREAD_COUNT)), 10, 0) WAIT_THREADS,
    TO_DECIMAL(GREATEST(0, SUM(L.TOTAL_THREAD_COUNT)), 10, 0) TOT_THREADS,
    TO_DECIMAL(GREATEST(0, SUM(L.ACTIVE_SQL_EXECUTOR_COUNT)), 10, 0) ACT_SQL,
    TO_DECIMAL(GREATEST(0, SUM(L.WAITING_SQL_EXECUTOR_COUNT)), 10, 0) WAIT_SQL,
    TO_DECIMAL(GREATEST(0, SUM(L.TOTAL_SQL_EXECUTOR_COUNT)), 10, 0) TOT_SQL,
    TO_DECIMAL(SUM(L.DATA_READ_SIZE) / 1024 / 1024 / MAX(L.INTERVAL_S), 10, 2) DATA_READ_VOL_MBPS,
    TO_DECIMAL(LEAST(100, MAX(L.DATA_READ_TIME) / 1000000 / MAX(L.INTERVAL_S) * 100), 10, 2) DATA_READ_ACT_PCT,
    TO_DECIMAL(SUM(L.DATA_WRITE_SIZE) / 1024 / 1024 / MAX(L.INTERVAL_S), 10, 2) DATA_WRT_VOL_MBPS,
    TO_DECIMAL(LEAST(100, MAX(L.DATA_WRITE_TIME) / 1000000 / MAX(L.INTERVAL_S) * 100), 10, 2) DATA_WRT_ACT_PCT,
    TO_DECIMAL(SUM(L.LOG_READ_SIZE) / 1024 / 1024 / MAX(L.INTERVAL_S), 10, 2) LOG_READ_VOL_MBPS,
    TO_DECIMAL(LEAST(100, MAX(L.LOG_READ_TIME) / 1000000 / MAX(L.INTERVAL_S) * 100), 10, 2) LOG_READ_ACT_PCT,
    TO_DECIMAL(SUM(L.LOG_WRITE_SIZE) / 1024 / 1024 / MAX(L.INTERVAL_S), 10, 2) LOG_WRT_VOL_MBPS,
    TO_DECIMAL(LEAST(100, MAX(L.LOG_WRITE_TIME) / 1000000 / MAX(L.INTERVAL_S) * 100), 10, 2) LOG_WRT_ACT_PCT,
    MAX(CPU_CORES) CPU_CORES,
    MAX(CPU_THREADS) CPU_THREADS,
    MAX(MEM_PHYS_GB) MEM_PHYS_GB,
    MAX(HOST_CPU) HOST_CPU,
    MAX(ASYNC_REQ) ASYNC_REQ,
    MAX(PMEM_USED_GB) PMEM_USED_GB,
    MAX(PMEM_TYPE) PMEM_TYPE
  FROM
    BASIS_INFO BI,
  ( SELECT
      L.*,
      H.CPU_CORES,
      H.CPU_THREADS,
      H.MEM_PHYS_GB,
      LH.HOST_CPU,
      R.ASYNC_REQ,
      IFNULL(PMS.PMEM_USED_GB, 0) PMEM_USED_GB,
      IFNULL(PM.PMEM_TYPE, '') PMEM_TYPE,
      NANO100_BETWEEN(LEAD(L.TIME, 1) OVER (PARTITION BY L.HOST, L.PORT ORDER BY L.TIME DESC), L.TIME) / 10000000 INTERVAL_S,
      ROW_NUMBER() OVER (PARTITION BY L.HOST, L.PORT ORDER BY L.TIME DESC) ROW_NO
    FROM
    ( SELECT
        HOST,
        MAX(MAP(KEY, 'cpu_cores', VALUE)) CPU_CORES,
        MAX(MAP(KEY, 'cpu_threads', VALUE)) CPU_THREADS,
        TO_DECIMAL(MAX(MAP(KEY, 'mem_phys', VALUE)) / 1024 / 1024 / 1024, 10, 0) MEM_PHYS_GB
      FROM
        M_HOST_INFORMATION
      GROUP BY
        HOST
    ) H INNER JOIN
    ( SELECT
        HOST,
        FIRST_VALUE(CPU ORDER BY TIME DESC) HOST_CPU
      FROM
        M_LOAD_HISTORY_HOST
      GROUP BY
        HOST
    ) LH ON
        LH.HOST = H.HOST INNER JOIN
    ( SELECT
        HOST,
        ACTIVE_ASYNC_IO_COUNT ASYNC_REQ
      FROM
        M_HOST_RESOURCE_UTILIZATION
    ) R ON
        R.HOST = LH.HOST INNER JOIN
      M_LOAD_HISTORY_SERVICE L ON
        L.HOST = R.HOST LEFT OUTER JOIN
    ( SELECT
        HOST,
        PORT,
        IFNULL(LTRIM(RTRIM(MAP(SUM(MAP(FILESYSTEM_TYPE, 'tmpfs', 1, 0)), 0, '', 'TMPFS') || CHAR(32) || MAP(SUM(MAP(FILESYSTEM_TYPE, 'tmpfs', 0, 1)), 0, '', 'PMEM'))), '') PMEM_TYPE
      FROM
        M_PERSISTENT_MEMORY_VOLUMES
      GROUP BY
        HOST,
        PORT
    ) PM ON
      PM.HOST = L.HOST AND
      PM.PORT = L.PORT LEFT OUTER JOIN
    ( SELECT
        HOST,
        PORT,
        IFNULL(TO_DECIMAL(SUM(TOTAL_ACTIVE_SIZE / 1024 / 1024 / 1024), 10, 0), 0) PMEM_USED_GB
      FROM
        M_PERSISTENT_MEMORY_VOLUME_STATISTICS
      GROUP BY
        HOST,
        PORT
    ) PMS ON
      PMS.HOST = PM.HOST AND
      PMS.PORT = PM.PORT
    WHERE
      L.TIME >= ADD_SECONDS(CURRENT_TIMESTAMP, -3600)
  ) L
  WHERE
    L.HOST LIKE BI.HOST AND
    TO_VARCHAR(L.PORT) LIKE BI.PORT AND
    ROW_NO = 1
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN L.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(L.PORT) ELSE 'any' END
),
WORKLOAD AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST') != 0 THEN W.HOST             ELSE MAP(BI.HOST, '%', 'any', BI.HOST) END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT') != 0 THEN TO_VARCHAR(W.PORT) ELSE MAP(BI.PORT, '%', 'any', BI.PORT) END PORT,
    TO_DECIMAL(SUM(W.CURRENT_EXECUTION_RATE) / 60, 10, 0) EXEC_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_COMPILATION_RATE) / 60, 10, 0) COMP_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_TRANSACTION_RATE) / 60, 10, 0) TRANS_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_UPDATE_TRANSACTION_RATE) / 60, 10, 0) UPD_TRANS_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_COMMIT_RATE) / 60, 10, 0) COMMITS_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_ROLLBACK_RATE) / 60, 10, 0) ROLLBACKS_PER_S,
    TO_DECIMAL(SUM(W.CURRENT_MEMORY_USAGE_RATE) / 1024 / 1024 / 60, 10, 0) MEM_MB_PER_S
  FROM
    BASIS_INFO BI,
    M_WORKLOAD W
  WHERE
    W.HOST LIKE BI.HOST AND
    TO_VARCHAR(W.PORT) LIKE BI.PORT
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST') != 0 THEN W.HOST             ELSE MAP(BI.HOST, '%', 'any', BI.HOST) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT') != 0 THEN TO_VARCHAR(W.PORT) ELSE MAP(BI.PORT, '%', 'any', BI.PORT) END
),
THREADS AS
( SELECT
    HOST,
    PORT,
    CONN_ID,
    THREAD_ID,
    STATEMENT_HASH,
    THREAD_TYPE,
    THREAD_METHOD,
    THREAD_DETAIL,
    THREAD_STATE,
    LOCK_NAME,
    DB_USER,
    APP_USER,
    APP_NAME,
    APP_SOURCE,
    DUR_S,
    CPU_S,
    NUMA_NODE,
    BLOCKING_THREAD BLK_THR,
    CASE WHEN THREAD_STATE = 'Job Exec Waiting' AND CALLING = '' THEN 'X' ELSE '' END Q,
    MAP(MAX_COL_LEN, -1, THREAD_TYPE_LEN, LEAST(MAX_COL_LEN, THREAD_TYPE_LEN)) THREAD_TYPE_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_STATE_LEN, LEAST(MAX_COL_LEN, THREAD_STATE_LEN)) THREAD_STATE_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_METHOD_LEN, LEAST(MAX_COL_LEN, THREAD_METHOD_LEN)) THREAD_METHOD_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_DETAIL_LEN, LEAST(MAX_COL_LEN, THREAD_DETAIL_LEN)) THREAD_DETAIL_LEN,
    MAP(MAX_COL_LEN, -1, LOCK_NAME_LEN, LEAST(MAX_COL_LEN, LOCK_NAME_LEN)) LOCK_NAME_LEN,
    MAP(MAX_COL_LEN, -1, APP_USER_LEN, LEAST(MAX_COL_LEN, APP_USER_LEN)) APP_USER_LEN,
    MAP(MAX_COL_LEN, -1, APP_NAME_LEN, LEAST(MAX_COL_LEN, APP_NAME_LEN)) APP_NAME_LEN,
    MAP(MAX_COL_LEN, -1, APP_SOURCE_LEN, LEAST(MAX_COL_LEN, APP_SOURCE_LEN)) APP_SOURCE_LEN,
    MAP(MAX_COL_LEN, -1, BLOCKING_THREAD_LEN, LEAST(MAX_COL_LEN, BLOCKING_THREAD_LEN)) BLK_THR_LEN
  FROM
  ( SELECT
      HOST,
      PORT,
      CONN_ID,
      THREAD_ID,
      STATEMENT_HASH,
      THREAD_TYPE,
      THREAD_METHOD,
      THREAD_DETAIL,
      THREAD_STATE,
      LOCK_NAME,
      DB_USER,
      APP_USER,
      APP_NAME,
      APP_SOURCE,
      DUR_S,
      CPU_S,
      NUMA_NODE,
      CALLING,
      BLOCKING_THREAD,
      MAX_COL_LEN,
      MAX(LENGTH(THREAD_TYPE)) OVER () THREAD_TYPE_LEN,
      MAX(LENGTH(THREAD_STATE)) OVER () THREAD_STATE_LEN,
      MAX(LENGTH(THREAD_METHOD)) OVER () THREAD_METHOD_LEN,
      MAX(LENGTH(THREAD_DETAIL)) OVER () THREAD_DETAIL_LEN,
      MAX(LENGTH(LOCK_NAME)) OVER () LOCK_NAME_LEN,
      MAX(LENGTH(APP_USER)) OVER () APP_USER_LEN,
      MAX(LENGTH(APP_NAME)) OVER () APP_NAME_LEN,
      MAX(LENGTH(APP_SOURCE)) OVER () APP_SOURCE_LEN,
      MAX(LENGTH(BLOCKING_THREAD)) OVER () BLOCKING_THREAD_LEN
    FROM
    ( SELECT
        T.HOST,
        TO_VARCHAR(T.PORT) PORT,
        T.CONNECTION_ID CONN_ID,
        T.THREAD_ID,
        CASE
          WHEN T.STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(T.THREAD_METHOD, CHAR(63), T.THREAD_TYPE, T.THREAD_METHOD) || ')'
          ELSE T.STATEMENT_HASH
        END STATEMENT_HASH,
        CASE
          WHEN T.THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
          ELSE T.THREAD_TYPE
        END THREAD_TYPE,
        T.THREAD_METHOD,
        T.THREAD_DETAIL,
        T.THREAD_STATE,
        SUBSTR(T.LOCK_WAIT_NAME, MAP(INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)), 0, 1, INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)) + 2)) LOCK_NAME,
        T.USER_NAME DB_USER,
        T.APPLICATION_USER_NAME APP_USER,
        T.APPLICATION_NAME APP_NAME,
        T.APPLICATION_SOURCE APP_SOURCE,
        TO_DECIMAL(ROUND(T.DURATION / 1000), 10, 0) DUR_S,
        TO_DECIMAL(ROUND(T.CPU_TIME_SELF / 1000000), 10, 0) CPU_S,
        IFNULL(T.NUMA_NODE_INDEX, -2) NUMA_NODE,
        T.CALLING,
        T.LOCK_OWNER_THREAD_ID BLOCKING_THREAD,
        BI.MAX_COL_LEN
      FROM
        BASIS_INFO BI,
        ( SELECT
            T.*,
            T.LOCK_WAIT_NAME LOCK_NAME
          FROM
            M_SERVICE_THREADS T
        ) T
      WHERE
        T.HOST LIKE BI.HOST AND
        TO_VARCHAR(T.PORT) LIKE BI.PORT AND
        T.IS_ACTIVE = 'TRUE' AND
        T.CONNECTION_ID != CURRENT_CONNECTION AND
        ( BI.EXCLUDE_PHANTOM_THREADS = ' ' OR NOT
          ( T.THREAD_TYPE = 'AgentPingThread'                     AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPeriodicThreadWaitSemaphore'                                  OR
            T.THREAD_TYPE = 'BackupMonitor_TransferThread'        AND T.THREAD_STATE = 'Sleeping'                                                                                                     OR
            T.THREAD_TYPE = 'ChildIOThreads::ErrorStream'         AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE = 'ChildIOThreads::OutputStream'        AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE LIKE 'DPDistributor%'                   AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPCommitTranPersistentDistributorQueueReaderAvailableSemaphore' OR
            T.THREAD_TYPE LIKE 'DPReceiverCleaner%'               AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPersistentTranDataCleanerDataAvailableSemaphore'              OR
            T.THREAD_TYPE LIKE 'DPReceiverWriter%'                AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'DPReceiverInboundQueueEmptyCond'                                OR
            T.THREAD_TYPE = 'Generic'                             AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE = 'IndexingQueue'                       AND T.THREAD_STATE = 'Sleeping'                                                                                                     OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Network Poll'              AND T.CONNECTION_ID = -1 AND     T.THREAD_METHOD = 'generic'                       OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Network Poll'              AND T.THREAD_METHOD = 'Request prologue'                                           OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Running'                   AND T.THREAD_METHOD = 'TimerCallback_OdmContextCleanup'                            OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPReceiverDispatcherHouseKeepingTaskAvailableSemaphore'         OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPReceiverHouseKeepingTaskAvailableSemaphore'                   OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'MasterQS_hasJobs'                                               OR
            T.THREAD_TYPE = 'JobWorker' AND T.THREAD_STATE = 'Semaphore Wait' AND T.LOCK_NAME = 'hex_WorkerJob_Sleep_Sem' AND T.THREAD_DETAIL LIKE 'Waits for client to fetch or syncs with other workers' OR
            T.THREAD_TYPE = 'JobWorker' AND T.THREAD_STATE = 'Semaphore Wait' AND T.LOCK_NAME = 'hex_WorkersManager_Sleep_Sem' AND T.THREAD_DETAIL LIKE 'waits for client to fetch'                   OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'LogBackupQueue'                                                 OR
            T.THREAD_TYPE = 'LogExceptionQueueThread'             AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'AdapterServiceFixedQueueListSemaphore'                          OR
            T.THREAD_TYPE = 'LogRecovery'                         AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'LogRecoveryPointInTimeQueue'                                    OR
            T.THREAD_TYPE = 'MaintenanceThread'                   AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPeriodicThreadWaitSemaphore'                                  OR
            T.THREAD_TYPE = 'Native'                              AND T.THREAD_DETAIL LIKE '%sysv_open_semaphore%'                                                                                    OR
            T.THREAD_TYPE = 'PostCommitExecutor'                  AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'RegularTaskQueueCV'                                             OR
            T.THREAD_TYPE = 'PreprocessorPool'                    AND T.THREAD_STATE = 'Network Poll'                                                                                                 OR
            T.THREAD_TYPE = 'PriPostCommitExecutor'               AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'PrioritizedTaskQueueCV'                                         OR
            T.THREAD_TYPE = 'StatsThread'                         AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'DPStatsThreadCond'                                              OR
            T.THREAD_TYPE = 'PushBufferIntoReplayThread'          AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: push buffer into replay semaphore'          OR
            T.THREAD_TYPE = 'SecondarySlaveLogPositionSendThread' AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: slave log position send semaphore'          OR
            T.THREAD_TYPE = 'SystemReplicationAsyncLogSender'     AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: AsyncLogBufferHandlerQueueSem'              OR
            T.THREAD_TYPE = 'WebDispatcher-Main-Thread'           AND T.THREAD_STATE = 'Running'
          )
        )
      )
  )
),
ACTIVE_STATEMENTS AS
( SELECT
    HOST,
    PORT,
    CONNECTION_ID,
    STATEMENT_ID,
    STATEMENT_STATUS,
    MAP(APPLICATION_SOURCE, '', '', NULL, '', APPLICATION_SOURCE || ':' || CHAR(32)) || STATEMENT_STRING STATEMENT_STRING,
    LAST_EXECUTED_TIME,
    START_TIME,
    DURATION_S,
    IDLE_S,
    MEM_MB,
    START_MVCC_TIMESTAMP,
    STATEMENT_HASH,
    IFNULL(APP_USER, '') APP_USER,
    MAX(LENGTH(IFNULL(APP_USER, ''))) OVER () APP_USER_LEN
  FROM
  ( SELECT DISTINCT
      A.HOST,
      A.PORT,
      A.CONNECTION_ID,
      A.STATEMENT_ID,
      A.STATEMENT_STATUS,
      REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TO_VARCHAR(SUBSTR(A.STATEMENT_STRING, 1, 5000)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32)), CHAR(9), CHAR(32)), 
        CHAR(32) || CHAR(32), CHAR(32)), CHAR(32) || CHAR(32), CHAR(32)), CHAR(32) || CHAR(32), CHAR(32)) STATEMENT_STRING,
      A.LAST_EXEC_TIME LAST_EXECUTED_TIME,
      TO_VARCHAR(A.LAST_EXEC_TIME, 'YYYY/MM/DD HH24:MI:SS') START_TIME,
      TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(A.LAST_EXEC_TIME, CURRENT_TIMESTAMP)), 10, 0) DURATION_S,
      TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(A.LAST_ACTION_TIME, CURRENT_TIMESTAMP)), 10, 0) IDLE_S,
      TO_DECIMAL(A.ALLOCATED_MEMORY_SIZE / 1024 / 1024, 10, 0) MEM_MB,
      A.START_MVCC_TIMESTAMP,
      A.STATEMENT_HASH,
      A.APPLICATION_SOURCE,
      ( SELECT MIN(VALUE) FROM M_SESSION_CONTEXT C WHERE C.CONNECTION_ID = A.CONNECTION_ID AND C.KEY LIKE '%APPLICATIONUSER' ) APP_USER
    FROM
      BASIS_INFO BI,
    ( SELECT
        IFNULL(LAST_EXECUTED_TIME, LAST_ACTION_TIME) LAST_EXEC_TIME,
        A.*
      FROM
        M_ACTIVE_STATEMENTS A 
    ) A
    WHERE
      A.HOST LIKE BI.HOST AND
      TO_VARCHAR(A.PORT) LIKE BI.PORT AND
      ( TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(A.LAST_EXECUTED_TIME, CURRENT_TIMESTAMP)), 10, 0) > 0 OR
        ( SELECT COUNT(*) FROM THREADS T WHERE T.STATEMENT_HASH = A.STATEMENT_HASH ) >= 3
      )
  )
),
SQL_CACHE AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END PORT,
    C.STATEMENT_HASH,
    SUM(C.EXECUTION_COUNT) EXECUTIONS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT) / SUM(C.EXECUTION_COUNT)), 10, 2) AVG_RECORDS,
    TO_DECIMAL(SUM(C.TOTAL_CURSOR_DURATION) / 1000000, 10, 2) TOT_CURS_S,
    TO_DECIMAL(SUM(C.TOTAL_EXECUTION_TIME) / 1000000, 10, 2) TOT_EXEC_S,
    TO_DECIMAL(SUM(C.AVG_CURSOR_DURATION) / 1000, 10, 2) AVG_CURS_MS,
    TO_DECIMAL(SUM(C.AVG_EXECUTION_TIME) / 1000, 10, 2) AVG_EXEC_MS,
    TO_DECIMAL(SUM(C.AVG_EXECUTION_MEMORY_SIZE) / 1024 / 1024, 10, 0) AVG_MEM_MB,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_LOCK_MS,
    TO_DECIMAL(SUM(C.AVG_PREPARATION_TIME) / 1000, 10, 2) AVG_PREP_MS,
    MAX(C.APPLICATION_NAME) APP_NAME,
    MAX(C.APPLICATION_SOURCE) APP_SOURCE,
    MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%COLUMN%' THEN 'C' ELSE '' END) || MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%ESX%' THEN 'E' ELSE '' END) ||
      MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%HEX%' THEN 'H' ELSE '' END) || MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%OLAP%' THEN 'O' ELSE '' END) ||
      MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%EXTERNAL%' THEN 'X' ELSE '' END) || MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%SQLSCRIPT%' THEN 'S' ELSE '' END) ||
      MAX(CASE WHEN C.EXECUTION_ENGINE LIKE '%ROW%' THEN 'R' ELSE '' END) ENG,
    MAX(LENGTH(MAX(C.APPLICATION_NAME))) OVER () APP_NAME_LEN
  FROM
    BASIS_INFO BI,
    ( SELECT DISTINCT STATEMENT_HASH FROM ( SELECT STATEMENT_HASH FROM ACTIVE_STATEMENTS UNION SELECT STATEMENT_HASH FROM THREADS ) ) A,
    M_SQL_PLAN_CACHE C
  WHERE
    C.HOST LIKE BI.HOST AND
    TO_VARCHAR(C.PORT) LIKE BI.PORT AND
    A.STATEMENT_HASH = C.STATEMENT_HASH
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END,
    C.STATEMENT_HASH
),
JOB_PROGRESS AS
( SELECT
    J.HOST,
    J.PORT,
    J.JOB_NAME,
    J.CURRENT_PROGRESS || CHAR(32) || 'of' || CHAR(32) || J.MAX_PROGRESS PROGRESS,
    TO_VARCHAR(J.START_TIME, 'YYYY/MM/DD HH24:MI:SS') START_TIME,
    TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(J.START_TIME, CURRENT_TIMESTAMP)), 10, 0) DURATION_S,
    J.SCHEMA_NAME,
    J.OBJECT_NAME,
    J.PROGRESS_DETAIL,
    GREATEST(11, MAX(LENGTH(J.SCHEMA_NAME)) OVER ()) SCHEMA_NAME_LEN,
    GREATEST(11, MAX(LENGTH(J.OBJECT_NAME)) OVER ()) OBJECT_NAME_LEN,
    GREATEST(15, MAX(LENGTH(J.PROGRESS_DETAIL)) OVER ()) PROGRESS_DETAIL_LEN
  FROM
    BASIS_INFO BI,
    M_JOB_PROGRESS J
  WHERE
    J.HOST LIKE BI.HOST AND
    TO_VARCHAR(J.PORT) LIKE BI.PORT
),
HEAP_ALLOCATORS AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN H.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(H.PORT) ELSE 'any' END PORT,
    H.CATEGORY HEAP_ALLOCATOR,
    TO_DECIMAL(SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024, 10, 2) MEM_USED_GB,
    COUNT(*) COUNT,
    MAX(H.COMPONENT) COMPONENT,
    MAX(LENGTH(H.CATEGORY)) OVER () HEAP_ALLOCATOR_LEN
  FROM
    BASIS_INFO BI,
    M_HEAP_MEMORY H,
    ( SELECT MAX(ALLOC_LIM_GB) ALLOC_LIM_GB FROM LOAD ) L
  WHERE
    H.HOST LIKE BI.HOST AND
    TO_VARCHAR(H.PORT) LIKE BI.PORT AND
    H.EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024 >= L.ALLOC_LIM_GB / 500
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN H.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(H.PORT) ELSE 'any' END,
    H.CATEGORY
  HAVING
    TO_DECIMAL(SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024) >= 0.5
),
GARBAGE_COLLECTION AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN L.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(L.PORT) ELSE 'any' END PORT,
    IFNULL(TO_VARCHAR(MIN(MAP(L.LAYER, 'GLOBAL', L.START_TIME)), 'YYYY/MM/DD HH24:MI:SS'), '') GLOBAL_LOCK_TIME,
    IFNULL(TO_VARCHAR(MIN(MAP(L.LAYER, 'LOCAL', L.START_TIME)), 'YYYY/MM/DD HH24:MI:SS'), '') LOCAL_LOCK_TIME,
    IFNULL(TO_VARCHAR(SUM(MAP(L.LAYER, 'HISTORY_COUNT', L.VALUE))), '') HISTORY_FILES,
    IFNULL(TO_VARCHAR(SUM(MAP(L.LAYER, 'DATA_VERSIONS', L.VALUE))), '') DATA_VERSIONS,
    IFNULL(TO_VARCHAR(SUM(MAP(L.LAYER, 'METADATA_VERSIONS', L.VALUE))), '') METADATA_VERSIONS
  FROM
    BASIS_INFO BI,
  ( SELECT
      'GLOBAL' LAYER,
      T.HOST,
      T.PORT,
      MIN(T.START_TIME) START_TIME,
      -1 VALUE
    FROM
      M_MVCC_OVERVIEW M,
      M_TRANSACTIONS T
    WHERE
      M.MIN_MVCC_SNAPSHOT_TIMESTAMP = T.MIN_MVCC_SNAPSHOT_TIMESTAMP AND
      M.HOST = T.HOST AND
      M.PORT = T.PORT
    GROUP BY
      T.HOST,
      T.PORT
    UNION ALL
    SELECT
      'LOCAL' LAYER,
      A.HOST,
      A.PORT,
      MIN(A.LAST_EXECUTED_TIME) START_TIME,
      -1 VALUE
    FROM
      M_TABLE_SNAPSHOTS S,
      ACTIVE_STATEMENTS A
    WHERE
      S.MIN_MVCC_SNAPSHOT_TIMESTAMP = A.START_MVCC_TIMESTAMP AND
      S.HOST = A.HOST AND
      S.PORT = A.PORT
    GROUP BY
      A.HOST,
      A.PORT
    UNION ALL
    SELECT
      'HISTORY_COUNT' LAYER,
      HOST,
      PORT,
      CURRENT_TIMESTAMP,
      SUM(HISTORY_COUNT) VALUE
    FROM
      M_GARBAGE_COLLECTION_STATISTICS
    GROUP BY
      HOST,
      PORT
    UNION ALL
    SELECT
      'DATA_VERSIONS' LAYER,
      HOST,
      PORT,
      CURRENT_TIMESTAMP,
      SUM(DATA_VERSION_COUNT) VALUE
    FROM
      M_MVCC_OVERVIEW
    GROUP BY
      HOST,
      PORT
    UNION ALL
    SELECT
      'METADATA_VERSIONS' LAYER,
      HOST,
      PORT,
      CURRENT_TIMESTAMP,
      SUM(METADATA_VERSION_COUNT) VALUE
    FROM
      M_MVCC_OVERVIEW
    GROUP BY
      HOST,
      PORT
  ) L
  WHERE
    L.HOST LIKE BI.HOST AND
    TO_VARCHAR(L.PORT) LIKE BI.PORT
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN L.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(L.PORT) ELSE 'any' END
),
CALLSTACKS AS
( SELECT DISTINCT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END PORT,
    T.CONN_ID,
    C.THREAD_ID,
    C.FRAME_LEVEL,
    C.FRAME_NAME
  FROM
    BASIS_INFO BI,
    M_SERVICE_THREAD_CALLSTACKS C,
    THREADS T
  WHERE
    BI.EXCLUDE_CALLSTACKS = ' ' AND
    C.HOST LIKE BI.HOST AND
    TO_VARCHAR(C.PORT) LIKE BI.PORT AND
    C.HOST = T.HOST AND
    C.PORT = T.PORT AND
    C.THREAD_ID = T.THREAD_ID AND
    C.IS_ACTIVE = 'TRUE'
),
DISKS AS
( SELECT
    D.*,
    GREATEST(4, MAX(LENGTH(DISK)) OVER ()) DISK_LEN
  FROM
    BASIS_INFO BI,
  ( SELECT
      HOST,
      MEASURED_ELEMENT_NAME DISK,
      MAX(MAP(CAPTION, 'Queue Length',TO_DECIMAL(VALUE, 10, 0), 0)) QUEUE,
      MAX(MAP(CAPTION, 'Service Time', TO_DECIMAL(VALUE, 10, 2), 0)) SRV_MS,
      MAX(MAP(CAPTION, 'Wait Time', TO_DECIMAL(VALUE, 10, 2), 0)) WAIT_MS,
      MAX(MAP(CAPTION, 'I/O Rate', TO_DECIMAL(VALUE, 10, 2), 0)) IO_PER_S,
      MAX(MAP(CAPTION, 'Total Throughput', TO_DECIMAL(VALUE, 10, 2), 0)) TP_KBPS
    FROM
      M_HOST_AGENT_METRICS
    WHERE
      MEASURED_ELEMENT_TYPE = 'Disk'
    GROUP BY
      HOST,
      MEASURED_ELEMENT_NAME
  ) D
  WHERE 
    D.HOST LIKE BI.HOST AND
    ( D.QUEUE > 0 OR
      D.QUEUE = 0 AND D.IO_PER_S >= 10
    )
),
CPUS AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST ELSE 'any' END HOST,
    N.NUMA_NODE,
    COUNT(*) CPU_THREADS,
    TO_DECIMAL(AVG(USER_PCT), 10, 2) USER_PCT,
    TO_DECIMAL(AVG(SYSTEM_PCT), 10, 2) SYSTEM_PCT,
    TO_DECIMAL(AVG(WAITIO_PCT), 10, 2) WAITIO_PCT,
    TO_DECIMAL(AVG(BUSY_PCT), 10, 2) BUSY_PCT,
    TO_DECIMAL(AVG(IDLE_PCT), 10, 2) IDLE_PCT
  FROM
    BASIS_INFO BI,
  ( SELECT
      MAX(TIMESTAMP) TIMESTAMP,
      HOST,
      MEASURED_ELEMENT_NAME CORE,
      SUM(MAP(CAPTION, 'User Time', TO_NUMBER(VALUE), 0)) USER_PCT,
      SUM(MAP(CAPTION, 'System Time', TO_NUMBER(VALUE), 0)) SYSTEM_PCT,
      SUM(MAP(CAPTION, 'Wait Time', TO_NUMBER(VALUE), 0)) WAITIO_PCT,
      SUM(MAP(CAPTION, 'Idle Time', 0, TO_NUMBER(VALUE))) BUSY_PCT,
      SUM(MAP(CAPTION, 'Idle Time', TO_NUMBER(VALUE), 0)) IDLE_PCT
    FROM
      M_HOST_AGENT_METRICS
    WHERE
      MEASURED_ELEMENT_TYPE = 'Processor'
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
      ( SELECT TOP 1000 ROW_NUMBER() OVER () LNO FROM OBJECTS ) L,
      ( SELECT DISTINCT
          NUMA_NODE_INDEX NUMA_NODE,
          ',' || LOGICAL_CORE_IDS || ',' LOGICAL_CORE_IDS
        FROM
          M_NUMA_NODES
      ) N
    )
    WHERE
      LOGICAL_CORE_IDS != ''
  ) N ON
    C.CORE BETWEEN N.MIN_CORE AND N.MAX_CORE
  WHERE
    C.HOST LIKE BI.HOST
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST ELSE 'any' END,
    N.NUMA_NODE
),
CPUS_2 AS
( SELECT
    HOST,
    TO_DECIMAL(LOADAVG_1MIN, 10, 2) LOADAVG_1MIN,
    TO_DECIMAL(LOADAVG_5MIN, 10, 2) LOADAVG_5MIN,
    TO_DECIMAL(LOADAVG_15MIN, 10, 2) LOADAVG_15MIN,
    TO_DECIMAL(STEAL_PCT, 10, 2) STEAL_PCT,
    TO_DECIMAL(CTX_SWITCHES_PER_S, 10, 0) CTX_SWITCHES_PER_S,
    TO_DECIMAL(INTERRUPTS_PER_S, 10, 0) INTERRUPTS_PER_S,
    TO_DECIMAL(LOGICAL_CPUS, 10, 0) LOGICAL_CPUS
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST ELSE 'any' END HOST,
      MAX(MAP(C.CAPTION, 'Load Average 1 Minute', TO_NUMBER(C.VALUE), 0)) LOADAVG_1MIN,
      MAX(MAP(C.CAPTION, 'Load Average 5 Minutes', TO_NUMBER(C.VALUE), 0)) LOADAVG_5MIN,
      MAX(MAP(C.CAPTION, 'Load Average 15 Minutes', TO_NUMBER(C.VALUE), 0)) LOADAVG_15MIN,
      MAX(MAP(C.CAPTION, 'Steal Time', TO_NUMBER(C.VALUE), 0)) STEAL_PCT,
      MAX(MAP(C.CAPTION, 'Context Switch Rate', TO_NUMBER(C.VALUE), 0)) CTX_SWITCHES_PER_S,
      MAX(MAP(C.CAPTION, 'Interrupt Rate', TO_NUMBER(C.VALUE), 0)) INTERRUPTS_PER_S,
      MAX(MAP(C.DEFINITION_ID, 'OS.CPUCount', TO_NUMBER(C.VALUE), 0)) LOGICAL_CPUS
    FROM
      BASIS_INFO BI,
      M_HOST_AGENT_METRICS C
    WHERE
      C.HOST LIKE BI.HOST AND
      C.MEASURED_ELEMENT_TYPE = 'OperatingSystem'
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST ELSE 'any' END
  )
),
JOBEXECUTORS AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN J.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(J.PORT) ELSE 'any' END PORT,
    MAX(MAX_CONCURRENCY_CONFIG) MAX_CONCURRENCY_CONFIG,
    MIN(MAX_CONCURRENCY) MAX_CONCURRENCY,
    MAX(TOTAL_WORKER_COUNT) TOTAL_WORKERS,
    MAX(QUEUED_WAITING_JOB_COUNT) QUEUED_WORKERS
  FROM
    BASIS_INFO BI,
    M_JOBEXECUTORS J
  WHERE
    J.HOST LIKE BI.HOST AND
    TO_VARCHAR(J.PORT) LIKE BI.PORT
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN J.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(J.PORT) ELSE 'any' END
),
TRANSACTIONAL_LOCK_WAITS AS
( SELECT
    HOST,
    PORT,
    BLOCKED_CONN_ID,
    BLOCKING_CONN_ID,
    WAIT_S,
    IFNULL(SCHEMA_NAME, '') SCHEMA_NAME,
    IFNULL(TABLE_NAME, '') TABLE_NAME,
    LOCK_TYPE,
    LOCK_MODE,
    IFNULL(BLOCKING_APP_USER, '') BLOCKING_APP_USER,
    IFNULL(BLOCKING_APP_NAME, '') BLOCKING_APP_NAME,
    IFNULL(BLOCKING_APP_SOURCE, '') BLOCKING_APP_SOURCE,
    IFNULL(MAX(LENGTH(SCHEMA_NAME)) OVER (), 0) SCHEMA_NAME_LEN,
    IFNULL(MAX(LENGTH(TABLE_NAME)) OVER (), 0) TABLE_NAME_LEN,
    IFNULL(MAX(LENGTH(BLOCKING_APP_USER)) OVER (), 0) BLOCKING_APP_USER_LEN,
    IFNULL(MAX(LENGTH(BLOCKING_APP_NAME)) OVER (), 0) BLOCKING_APP_NAME_LEN,
    IFNULL(MAX(LENGTH(BLOCKING_APP_SOURCE)) OVER (), 0) BLOCKING_APP_SOURCE_LEN
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN B.HOST             ELSE 'any' END HOST,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(B.PORT) ELSE 'any' END PORT,
      B.BLOCKED_CONNECTION_ID BLOCKED_CONN_ID,
      B.LOCK_OWNER_CONNECTION_ID BLOCKING_CONN_ID,
      TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(B.BLOCKED_TIME, CURRENT_TIMESTAMP)), 10, 0) WAIT_S,
      B.WAITING_SCHEMA_NAME SCHEMA_NAME,
      B.WAITING_OBJECT_NAME TABLE_NAME,
      B.LOCK_TYPE,
      B.LOCK_MODE,
      ( SELECT MIN(C.VALUE) FROM M_TRANSACTIONS T, M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) LIKE '%APPLICATIONUSER' ) BLOCKING_APP_USER,
      ( SELECT MAX(C.VALUE) FROM M_TRANSACTIONS T, M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) = 'APPLICATION' ) BLOCKING_APP_NAME,
      ( SELECT MAX(C.VALUE) FROM M_TRANSACTIONS T, M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) = 'APPLICATIONSOURCE' ) BLOCKING_APP_SOURCE
    FROM
      BASIS_INFO BI,
      M_BLOCKED_TRANSACTIONS B
    WHERE
      B.HOST LIKE BI.HOST AND
      TO_VARCHAR(B.PORT) LIKE BI.PORT
  )
),
IO_KEY_FIGURES AS
( SELECT
    HOST,
    PORT,
    TYPE,
    TO_DECIMAL(TOTAL_READ_SIZE / 1024 / 1024 / SECONDS, 10, 2) READ_VOL_MBPS,
    TO_DECIMAL(MAP(TOTAL_READ_TIME, 0, 0, TOTAL_READ_SIZE / 1024 / 1024 / TOTAL_READ_TIME * 1000000), 10, 2) READ_TP_MBPS,
    TO_DECIMAL(TOTAL_READ_TIME / 1000000 / SECONDS * 100, 10, 2) READ_ACT_PCT,
    TO_DECIMAL(MAP(TOTAL_READS, 0, 0, TOTAL_READ_SIZE / TOTAL_READS / 1024), 10, 2) AVG_READ_KB,
    TO_DECIMAL(MAP(TOTAL_READS, 0, 0, TOTAL_READ_TIME / TOTAL_READS / 1000), 10, 2) AVG_READ_MS,
    TO_DECIMAL(TOTAL_WRITE_SIZE / 1024 / 1024 / SECONDS, 10, 2) WRT_VOL_MBPS,
    TO_DECIMAL(MAP(TOTAL_WRITE_TIME, 0, 0, TOTAL_WRITE_SIZE / 1024 / 1024 / TOTAL_WRITE_TIME * 1000000), 10, 2) WRT_TP_MBPS,
    TO_DECIMAL(TOTAL_WRITE_TIME / 1000000 / SECONDS * 100, 10, 2) WRT_ACT_PCT,
    TO_DECIMAL(MAP(TOTAL_WRITES, 0, 0, TOTAL_WRITE_SIZE / TOTAL_WRITES / 1024), 10, 2) AVG_WRT_KB,
    TO_DECIMAL(MAP(TOTAL_WRITES, 0, 0, TOTAL_WRITE_TIME / TOTAL_WRITES / 1000), 10, 2) AVG_WRT_MS    
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN I.HOST             ELSE 'any' END HOST,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(I.PORT) ELSE 'any' END PORT,
      I.TYPE,
      GREATEST(1, MIN(SECONDS_BETWEEN(I2.SERVER_TIMESTAMP, CURRENT_TIMESTAMP))) SECONDS,
      SUM(I.TOTAL_READS + I.TOTAL_TRIGGER_ASYNC_READS - I2.TOTAL_READS - I2.TOTAL_TRIGGER_ASYNC_READS) TOTAL_READS,
      SUM(I.TOTAL_READ_SIZE - I2.TOTAL_READ_SIZE) TOTAL_READ_SIZE,
      SUM(I.TOTAL_READ_TIME - I2.TOTAL_READ_TIME) TOTAL_READ_TIME,
      SUM(I.TOTAL_WRITES + I.TOTAL_TRIGGER_ASYNC_WRITES - I2.TOTAL_WRITES - I2.TOTAL_TRIGGER_ASYNC_WRITES) TOTAL_WRITES,
      SUM(I.TOTAL_WRITE_SIZE - I2.TOTAL_WRITE_SIZE) TOTAL_WRITE_SIZE,
      SUM(I.TOTAL_WRITE_TIME - I2.TOTAL_WRITE_TIME) TOTAL_WRITE_TIME
    FROM
      BASIS_INFO BI,
    ( SELECT
        HOST,
        PORT,
        TYPE,
        SUM(TOTAL_READS) TOTAL_READS,
        SUM(TOTAL_TRIGGER_ASYNC_READS) TOTAL_TRIGGER_ASYNC_READS,
        SUM(TOTAL_READ_SIZE) TOTAL_READ_SIZE,
        SUM(TOTAL_READ_TIME) TOTAL_READ_TIME,
        SUM(TOTAL_WRITES) TOTAL_WRITES,
        SUM(TOTAL_TRIGGER_ASYNC_WRITES) TOTAL_TRIGGER_ASYNC_WRITES,
        SUM(TOTAL_WRITE_SIZE) TOTAL_WRITE_SIZE,
        SUM(TOTAL_WRITE_TIME) TOTAL_WRITE_TIME
      FROM
        M_VOLUME_IO_TOTAL_STATISTICS
      GROUP BY
        HOST,
        PORT,
        TYPE
    ) I,
    ( SELECT
        SERVER_TIMESTAMP,
        HOST,
        PORT,
        TYPE,
        TOTAL_READS,
        TOTAL_TRIGGER_ASYNC_READS,
        TOTAL_READ_SIZE,
        TOTAL_READ_TIME,
        TOTAL_WRITES,
        TOTAL_TRIGGER_ASYNC_WRITES,
        TOTAL_WRITE_SIZE,
        TOTAL_WRITE_TIME
      FROM
      ( SELECT
          ROW_NUMBER() OVER (PARTITION BY HOST, PORT, TYPE ORDER BY SERVER_TIMESTAMP DESC) ROWNO,
          I2.*
        FROM
        ( SELECT
            SERVER_TIMESTAMP,
            HOST,
            PORT,
            TYPE,
            SUM(TOTAL_READS) TOTAL_READS,
            SUM(TOTAL_TRIGGER_ASYNC_READS) TOTAL_TRIGGER_ASYNC_READS,
            SUM(TOTAL_READ_SIZE) TOTAL_READ_SIZE,
            SUM(TOTAL_READ_TIME) TOTAL_READ_TIME,
            SUM(TOTAL_WRITES) TOTAL_WRITES,
            SUM(TOTAL_TRIGGER_ASYNC_WRITES) TOTAL_TRIGGER_ASYNC_WRITES,
            SUM(TOTAL_WRITE_SIZE) TOTAL_WRITE_SIZE,
            SUM(TOTAL_WRITE_TIME) TOTAL_WRITE_TIME
          FROM
            _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS
          GROUP BY
            SERVER_TIMESTAMP,
            HOST,
            PORT,
            TYPE
        ) I2
        WHERE
          SECONDS_BETWEEN(SERVER_TIMESTAMP, CURRENT_TIMESTAMP) BETWEEN 300 AND 86400 AND
          I2.TYPE IN ( 'DATA', 'LOG' )
      )
      WHERE
        ROWNO = 1
    ) I2
    WHERE
      I.HOST LIKE BI.HOST AND
      TO_VARCHAR(I.PORT) LIKE BI.PORT AND
      I.HOST = I2.HOST AND
      I.PORT = I2.PORT AND
      I.TYPE = I2.TYPE
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN I.HOST             ELSE 'any' END,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(I.PORT) ELSE 'any' END,
      I.TYPE
  )
),
SYSTEM_REPLICATION AS
( SELECT
    HOST,
    PORT,
    SECONDARY_HOST,
    REPLICATION_MODE,
    OPERATION_MODE,
    FULL_SYNC,
    REPLICATION_STATUS,
    SHP_BL_MB,
    SHP_DL_S,
    REP_BL_MB,
    REP_DL_S,
    LOG_SHIP_MS,
    REPLICATION_STATUS_DETAILS,
    SECONDARY_ACTIVE_STATUS,
    MAX(LENGTH(SECONDARY_HOST)) OVER () SECONDARY_HOST_LEN
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN R.HOST             ELSE 'any' END HOST,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(R.PORT) ELSE 'any' END PORT,
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN R.SECONDARY_HOST   ELSE 'any' END SECONDARY_HOST,
      MAX(R.REPLICATION_MODE) REPLICATION_MODE,
      MAX(R2.OPERATION_MODE) OPERATION_MODE,
      MAX(R.REPLICATION_STATUS) REPLICATION_STATUS,
      MAX(R.FULL_SYNC) FULL_SYNC,
      TO_DECIMAL(SUM(R.BACKLOG_SIZE) / 1024 / 1024, 10, 2) SHP_BL_MB,
      TO_DECIMAL(MAX(R.BACKLOG_TIME) / 1000000, 10, 2) SHP_DL_S,
      TO_DECIMAL(MAX(R.REPLAY_BACKLOG_SIZE) / 1024 / 1024, 10, 0) REP_BL_MB,
      TO_DECIMAL(MAX(R.REPLAY_BACKLOG_TIME) / 1000000, 10, 0) REP_DL_S,
      TO_DECIMAL(MAP(SUM(R3.SHIPPED_LOG_BUFFERS_COUNT), 0, 0, (SUM(R3.SHIPPED_LOG_BUFFERS_DURATION) / 1000 / SUM(R3.SHIPPED_LOG_BUFFERS_COUNT))), 10, 2) LOG_SHIP_MS,
      MAX(R.REPLICATION_STATUS_DETAILS) REPLICATION_STATUS_DETAILS,
      MAX(R.SECONDARY_ACTIVE_STATUS) SECONDARY_ACTIVE_STATUS
    FROM
      BASIS_INFO BI,
      M_SERVICE_REPLICATION R,
      M_SYSTEM_REPLICATION R2,
    ( SELECT
        HOST,
        PORT,
        MAX(SHIPPED_LOG_BUFFERS_COUNT) - MIN(SHIPPED_LOG_BUFFERS_COUNT) SHIPPED_LOG_BUFFERS_COUNT,
        MAX(SHIPPED_LOG_BUFFERS_DURATION) - MIN(SHIPPED_LOG_BUFFERS_DURATION) SHIPPED_LOG_BUFFERS_DURATION
      FROM
      ( SELECT
          HOST,
          PORT,
          SUM(SHIPPED_LOG_BUFFERS_COUNT) SHIPPED_LOG_BUFFERS_COUNT,
          SUM(SHIPPED_LOG_BUFFERS_DURATION) SHIPPED_LOG_BUFFERS_DURATION
        FROM
          M_SERVICE_REPLICATION
        GROUP BY
          HOST,
          PORT
        UNION ALL
        SELECT
          SR.HOST,
          SR.PORT,
          SUM(SR.SHIPPED_LOG_BUFFERS_COUNT) SHIPPED_LOG_BUFFERS_COUNT,
          SUM(SR.SHIPPED_LOG_BUFFERS_DURATION) SHIPPED_LOG_BUFFERS_DURATION
        FROM
        ( SELECT TOP 1 DISTINCT SERVER_TIMESTAMP FROM _SYS_STATISTICS.HOST_SERVICE_REPLICATION ORDER BY SERVER_TIMESTAMP DESC ) TS,
          _SYS_STATISTICS.HOST_SERVICE_REPLICATION SR
        WHERE
          SR.SERVER_TIMESTAMP = TS.SERVER_TIMESTAMP
        GROUP BY
          SR.SERVER_TIMESTAMP,
          SR.HOST,
          SR.PORT
      )
      GROUP BY
        HOST,
        PORT
    ) R3
    WHERE
      R.HOST LIKE BI.HOST AND
      TO_VARCHAR(R.PORT) LIKE BI.PORT AND
      R2.SITE_ID = R.SITE_ID AND
      R2.SECONDARY_SITE_ID = R.SECONDARY_SITE_ID AND
      R.HOST = R3.HOST AND
      R.PORT = R3.PORT
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN R.HOST             ELSE 'any' END,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(R.PORT) ELSE 'any' END,
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN R.SECONDARY_HOST   ELSE 'any' END
  )
),
SQL_CACHE_OVERVIEW AS
( SELECT
    HOST,
    PORT,
    TO_DECIMAL(CONF_GB, 10, 2) CONF_GB,
    TO_DECIMAL(USED_GB, 10, 2) USED_GB,
    PLANS,
    TO_DECIMAL(AVG_SIZE_KB, 10, 2) AVG_SIZE_KB,
    TO_DECIMAL(EVICT_PER_H, 10, 0) EVICT_PER_H,
    TO_DECIMAL(HIT_PCT, 10, 2) HIT_PCT
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END HOST,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END PORT,
      MAX(C.CONF_GB) CONF_GB,
      MAX(C.USED_GB) USED_GB,
      MAX(C.PLANS) PLANS,
      MAP(MAX(C.PLANS), 0, 0, MAX(C.USED_GB) / MAX(C.PLANS) * 1024 * 1024) AVG_SIZE_KB,
      MAP(MAX(C.SECONDS), 0, 0, MAX(C.EVICTIONS) / MAX(C.SECONDS) * 3600) EVICT_PER_H,
      MAP(SUM(C.LOOKUPS), 0, 0, SUM(C.HITS) / SUM(C.LOOKUPS) * 100) HIT_PCT
    FROM
      BASIS_INFO BI,
    ( SELECT
        SECONDS_BETWEEN(H.SERVER_TIMESTAMP, CURRENT_TIMESTAMP) SECONDS,
        C.HOST,
        C.PORT,
        C.CONF_GB,
        C.USED_GB,
        C.PLANS,
        C.LOOKUPS - H.LOOKUPS LOOKUPS,
        C.HITS - H.HITS HITS,
        C.EVICTIONS - H.EVICTIONS EVICTIONS
      FROM
      ( SELECT
          HOST,
          PORT,
          PLAN_CACHE_CAPACITY / 1024 / 1024 / 1024 CONF_GB,
          CACHED_PLAN_SIZE / 1024 / 1024 / 1024 USED_GB,
          CACHED_PLAN_COUNT PLANS,
          PLAN_CACHE_LOOKUP_COUNT LOOKUPS,
          PLAN_CACHE_HIT_COUNT HITS,
          EVICTED_PLAN_COUNT EVICTIONS
        FROM
          M_SQL_PLAN_CACHE_OVERVIEW
      ) C,
      ( SELECT
          SO.SERVER_TIMESTAMP,
          SO.HOST,
          SO.PORT,
          SUM(SO.PLAN_CACHE_LOOKUP_COUNT) LOOKUPS,
          SUM(SO.PLAN_CACHE_HIT_COUNT) HITS,
          SUM(SO.EVICTED_PLAN_COUNT) EVICTIONS
        FROM
        ( SELECT TOP 1 DISTINCT SERVER_TIMESTAMP FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE_OVERVIEW ORDER BY SERVER_TIMESTAMP DESC ) TS,
          _SYS_STATISTICS.HOST_SQL_PLAN_CACHE_OVERVIEW SO
        WHERE
          SO.SERVER_TIMESTAMP = TS.SERVER_TIMESTAMP
        GROUP BY
          SO.SERVER_TIMESTAMP,
          SO.HOST,
          SO.PORT
      ) H
      WHERE
        C.HOST = H.HOST AND
        C.PORT = H.PORT
    ) C
    WHERE
      C.HOST LIKE BI.HOST AND
      TO_VARCHAR(C.PORT) LIKE BI.PORT
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END
  )
),
PARAMETERS AS
( SELECT
    FILE_NAME,
    SECTION,
    KEY,
    VALUE,
    MAX(LENGTH(FILE_NAME)) OVER() FILE_LEN,
    MAX(LENGTH(SECTION)) OVER() SECTION_LEN,
    MAX(LENGTH(KEY)) OVER () KEY_LEN,
    MAX(LENGTH(VALUE)) OVER () VALUE_LEN
  FROM
  ( SELECT
      FILE_NAME,
      SECTION,
      KEY,
      MAX(VALUE) VALUE
    FROM
      M_CONFIGURATION_PARAMETER_VALUES
    WHERE
      LAYER_NAME != 'DEFAULT'
    GROUP BY
      FILE_NAME,
      SECTION,
      KEY
  )
),
TEMPORARY_TABLES AS
( SELECT
    SCHEMA_NAME,
    TABLE_CLASS,
    TABLE_TYPE,
    TABLES,
    RECORD_COUNT,
    TABLE_SIZE_GB,
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_NAME_LEN,
    GREATEST(11, MAX(LENGTH(TABLE_CLASS)) OVER ()) TABLE_CLASS_LEN
  FROM
  ( SELECT TOP 10
      SCHEMA_NAME,
      TABLE_CLASS,
      TABLE_TYPE,
      COUNT(*) TABLES,
      SUM(RECORD_COUNT) RECORD_COUNT,
      TO_DECIMAL(SUM(TABLE_SIZE_BYTE / 1024 / 1024 / 1024), 10, 2) TABLE_SIZE_GB
    FROM
    ( SELECT
        T.SCHEMA_NAME,
        CASE
          WHEN T.TABLE_NAME LIKE '_SYS_CE_MDS_QE_INLIST%'                       THEN 'MDS'
          WHEN T.TABLE_NAME LIKE '#_SYS_QO_COL%'                                THEN 'Query optimizer (COL)'
          WHEN T.TABLE_NAME LIKE '#_SYS_QO_FDA%'                                THEN 'Query optimizer (FDA)'
          WHEN T.TABLE_NAME LIKE '#_SYS_QO_ROW%'                                THEN 'Query optimizer (ROW)'
          WHEN T.TABLE_NAME LIKE '#_SYS_QO_TMP%'                                THEN 'Query optimizer (TMP)'
          WHEN T.TABLE_NAME LIKE '$BPC$TMP%'                                    THEN 'BPC (TMP)'
          WHEN T.TABLE_NAME LIKE '$BPC$HC%'                                     THEN 'BPC (HC)'
          WHEN T.TABLE_NAME LIKE '_SYS_PARAM_ITAB_%'                            THEN 'ABAP (FDA)'
          WHEN T.TABLE_NAME LIKE '_SYS_PLE:%'                                   THEN 'Planning engine'
          WHEN T.TABLE_NAME LIKE '_SYS_SS2_TMP_TABLE%'                          THEN 'SQLScript (intermediate tables)'
          WHEN T.TABLE_NAME LIKE '_SQLSC_TRANSFER_TABLE%'                       THEN 'SQLScript (transfer table)'
          WHEN T.TABLE_NAME LIKE '0BW:BIA%BI0_0Q%'                              THEN 'BW (0Q, planning / F4)'
          WHEN T.TABLE_NAME LIKE '0BW:BIA%BI0_08%'                              THEN 'BW (08, hierarchies)'
          WHEN T.TABLE_NAME LIKE '0BW:BIA%'                                     THEN 'BW (other temporary data)'
          WHEN T.TABLE_NAME LIKE '0BW:CRM%'                                     THEN 'BW (CRM segmentation)'
          WHEN T.TABLE_NAME LIKE '%.%.%' AND LENGTH(SUBSTR(T.TABLE_NAME, LOCATE(T.TABLE_NAME, '.', 1, 2) + 1)) = 32 THEN 'BW (TREX_EXT_AGGREGATE)'
          WHEN T.TABLE_NAME LIKE '%#tft#%'                                      THEN 'S/4 (table function)'
          WHEN T.TABLE_NAME = LOWER(T.TABLE_NAME) AND LENGTH(T.TABLE_NAME) = 40 THEN 'BW (hash table)'
          WHEN T.TABLE_NAME LIKE 'RSADSO_LOG_%'                                 THEN 'BW (DSO activation)'
          WHEN T.TABLE_NAME LIKE 'RSODSO_DATAPAK_%'                             THEN 'BW (DSO activation)'
          WHEN T.TABLE_NAME LIKE 'U____________'                                THEN 'BusinessObjects (Financial Consolidation)'
          ELSE                                                                       'OTHER'
        END TABLE_CLASS,
        T.TEMPORARY_TABLE_TYPE TABLE_TYPE,
        IFNULL(T.RECORD_COUNT, 0) RECORD_COUNT,
        IFNULL(T.TABLE_SIZE, 0) TABLE_SIZE_BYTE
      FROM
        M_TEMPORARY_TABLES T
    )
    GROUP BY
      SCHEMA_NAME,
      TABLE_CLASS,
      TABLE_TYPE
    HAVING
      COUNT(*) >= 10
    ORDER BY
      COUNT(*) DESC 
  )
),
CALCULATION_SCENARIOS AS
( SELECT
    SCHEMA_NAME,
    SCENARIO_CLASS,
    COMPONENT,
    IS_PERSISTENT,
    SCENARIOS,
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_NAME_LEN,
    GREATEST(18, MAX(LENGTH(SCENARIO_CLASS)) OVER ()) SCENARIO_CLASS_LEN,
    GREATEST(13, MAX(LENGTH(COMPONENT)) OVER ()) COMPONENT_LEN
  FROM
  ( SELECT TOP 10
      SCHEMA_NAME,
      SCENARIO_CLASS,
      COMPONENT,
      IS_PERSISTENT,
      COUNT(*) SCENARIOS
    FROM
    ( SELECT
        *,
        CASE
          WHEN SCENARIO_NAME LIKE '0BW:BIA%'      THEN            '0BW:BIA* - BW (hierarchy)'
          WHEN SCENARIO_NAME LIKE '0BW:CRM%'      THEN            '0BW:CRM* - BW (CRM segmentation)'
          WHEN SCENARIO_NAME LIKE '0BW:NCUM%'     THEN            '0BW:NCUM* - BW (non-cumulative queries)'
          WHEN SCENARIO_NAME LIKE '/1BCAMDP/0BW%' THEN            '/1BCAMDP/0BW* - BW (AMDP)'
          WHEN SCENARIO_NAME LIKE '_SYS_CE_U1%'   THEN            '_SYS_CE_U1* - BW (HANA composite providers)'
          WHEN SCENARIO_NAME LIKE '_SYS_SS_CE%'   THEN            '_SYS_SS_CE* - SQLScript'
          WHEN SCENARIO_NAME LIKE 'system-local.bw.bw2hana%' THEN 'system-local.bw.bw2hana* - BW (external HANA views)'
          WHEN COMPONENT != 'UNKNOWN'             THEN            'OTHER -' || CHAR(32) || COMPONENT
          ELSE                                                    'OTHER'
        END SCENARIO_CLASS
      FROM
      ( SELECT
          SUBSTR(SCENARIO_NAME, 1, LOCATE(SCENARIO_NAME, ':', 1) - 1) SCHEMA_NAME,
          SUBSTR(SCENARIO_NAME, LOCATE(SCENARIO_NAME, ':', 1) + 1) SCENARIO_NAME,
          IS_PERSISTENT,
          COMPONENT
        FROM
          M_CE_CALCSCENARIOS_OVERVIEW
      )
    )
    GROUP BY
      SCHEMA_NAME,
      SCENARIO_CLASS,
      COMPONENT,
      IS_PERSISTENT
    HAVING
      COUNT(*) >= 10
    ORDER BY
      COUNT(*) DESC
  )
),
CACHES AS
( SELECT
    HOST,
    PORT,
    CACHE_ID,
    TO_DECIMAL(SIZE_GB, 10, 2) SIZE_GB,
    ENTRIES,
    INSERTS,
    INVALIDATIONS,
    HITS,
    MISSES,
    TO_DECIMAL(HIT_PCT, 10, 2) HIT_PCT,
    GREATEST(8, MAX(LENGTH(CACHE_ID)) OVER ()) CACHE_ID_LEN
  FROM
  ( SELECT
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END HOST,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END PORT,
      C.CACHE_ID,
      SUM(C.USED_SIZE) / 1024 / 1024 / 1024 SIZE_GB,
      SUM(C.ENTRY_COUNT) ENTRIES,
      SUM(C.INSERT_COUNT) INSERTS,
      SUM(C.INVALIDATE_COUNT) INVALIDATIONS,
      SUM(C.HIT_COUNT) HITS,
      SUM(C.MISS_COUNT) MISSES,
      MAP(SUM(C.MISS_COUNT) + SUM(C.HIT_COUNT), 0, 0, SUM(C.HIT_COUNT) / (SUM(C.MISS_COUNT) + SUM(C.HIT_COUNT)) * 100) HIT_PCT
    FROM
      BASIS_INFO BI,
      M_CACHES C
    WHERE
      C.HOST LIKE BI.HOST AND
      TO_VARCHAR(C.PORT) LIKE BI.PORT
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN C.HOST             ELSE 'any' END,
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(C.PORT) ELSE 'any' END,
      C.CACHE_ID
  )
  WHERE
    SIZE_GB >= 1 OR ENTRIES >= 1000
),
TRANSLATION_TABLES_HELPER AS
( SELECT
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN TT.HOST             ELSE 'any' END HOST,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(TT.PORT) ELSE 'any' END PORT,
    TT.SCHEMA_NAME1 SCHEMA_NAME_1,
    TT.TABLE_NAME1 TABLE_NAME_1, 
    TT.COLUMN_NAME1 COLUMN_NAME_1,
    TT.SCHEMA_NAME2 SCHEMA_NAME_2,
    TT.TABLE_NAME2 TABLE_NAME_2,
    TT.COLUMN_NAME2 COLUMN_NAME_2,
    COUNT(*) NUM_TTS,
    SUM(TT.TRANSLATION_TABLE_MEMORY_SIZE / 1024 / 1024) TT_SIZE_MB
  FROM
    BASIS_INFO BI,
    M_JOIN_TRANSLATION_TABLES TT
  WHERE 
    BI.EXCLUDE_TRANSLATION_TABLES = ' ' AND
    TT.HOST LIKE BI.HOST AND
    TO_VARCHAR(TT.PORT) LIKE BI.PORT
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN TT.HOST             ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN TO_VARCHAR(TT.PORT) ELSE 'any' END,
    TT.SCHEMA_NAME1,
    TT.TABLE_NAME1,
    TT.COLUMN_NAME1,
    TT.SCHEMA_NAME2,
    TT.TABLE_NAME2,
    TT.COLUMN_NAME2
),
TRANSLATION_TABLES AS
( SELECT
    HOST,
    PORT,
    SCHEMA_NAME_1,
    TABLE_NAME_1, 
    COLUMN_NAME_1,
    SCHEMA_NAME_2,
    TABLE_NAME_2,
    COLUMN_NAME_2,
    NUM_TTS,
    TO_DECIMAL(TT_SIZE_MB, 10, 2) TT_SIZE_MB,
    GREATEST(13, MAX(LENGTH(SCHEMA_NAME_1)) OVER ()) SCHEMA_1_LEN,
    GREATEST(12, MAX(LENGTH(TABLE_NAME_1)) OVER ()) TABLE_1_LEN,
    GREATEST(13, MAX(LENGTH(COLUMN_NAME_1)) OVER ()) COLUMN_1_LEN,
    GREATEST(13, MAX(LENGTH(SCHEMA_NAME_2)) OVER ()) SCHEMA_2_LEN,
    GREATEST(12, MAX(LENGTH(TABLE_NAME_2)) OVER ()) TABLE_2_LEN,
    GREATEST(13, MAX(LENGTH(COLUMN_NAME_2)) OVER ()) COLUMN_2_LEN
  FROM
  ( SELECT
      *
    FROM
    ( SELECT TOP 10
        *
      FROM
        TRANSLATION_TABLES_HELPER
      ORDER BY
        NUM_TTS DESC
    )
    UNION
    SELECT
      *
    FROM
    ( SELECT TOP 10
        *
      FROM
        TRANSLATION_TABLES_HELPER
      ORDER BY
        TT_SIZE_MB DESC
    )
    UNION
    SELECT
      HOST,
      PORT,
      'TOTAL', '', '', '', '', '',
      SUM(NUM_TTS) NUM_TTS,
      SUM(TT_SIZE_MB) TT_SIZE_MB
    FROM
      TRANSLATION_TABLES_HELPER
    GROUP BY
      HOST,
      PORT
  )
),
TRANSACTIONAL_LOCKS AS
( SELECT
    SCHEMA_NAME,
    TABLE_NAME,
    LOCK_MODE,
    LOCK_COUNT,
    TO_VARCHAR(ACQUIRED_TIME, 'YYYY/MM/DD HH24:MI:SS') ACQUIRED_TIME,
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(TABLE_NAME)) OVER ()) TABLE_LEN
  FROM
  ( SELECT
      ROW_NUMBER () OVER (ORDER BY COUNT(*) DESC) ROWNO,
      SCHEMA_NAME,
      TABLE_NAME,
      LOCK_MODE,
      COUNT(*) LOCK_COUNT,
      MIN(ACQUIRED_TIME) ACQUIRED_TIME
    FROM
      M_RECORD_LOCKS
    GROUP BY
      SCHEMA_NAME,
      TABLE_NAME,
      LOCK_MODE
  )
  WHERE
    SECONDS_BETWEEN(ACQUIRED_TIME, CURRENT_TIMESTAMP) >= 3600 OR
    ROWNO <= 10
),
ACTIVE_PROCEDURES AS
( SELECT
    PROCEDURE_HOST HOST,
    PROCEDURE_PORT PORT,
    PROCEDURE_CONNECTION_ID CONN_ID,
    TO_VARCHAR(STATEMENT_START_TIME, 'YYYY/MM/DD HH24:MI:SS') START_TIME,
    PROCEDURE_NAME,
    STATEMENT_EXECUTION_COUNT EXECUTIONS,
    TO_DECIMAL(STATEMENT_EXECUTION_TIME / 1000, 10, 2) EXEC_TIME_MS,
    STATEMENT_STATUS STATUS,
    TO_VARCHAR(STATEMENT_STRING) STATEMENT_STRING,
    GREATEST(14, MAX(LENGTH(PROCEDURE_NAME)) OVER ()) PROCEDURE_LEN
  FROM
    M_ACTIVE_PROCEDURES
  WHERE
    STATEMENT_STATUS = 'EXECUTING'
)
SELECT MAP(BI.LINE_LENGTH, -1, LINE, SUBSTR(D.LINE, 1, BI.LINE_LENGTH)) LINE FROM BASIS_INFO BI, ( 
SELECT 5 LINE_NO, '' HOST, '' PORT, '*********************************' LINE FROM DUMMY
UNION ALL SELECT    10, '', '',     '* SAP HANA CURRENT STATE REPORT *' FROM DUMMY
UNION ALL SELECT    20, '', '',     '*********************************' FROM DUMMY
UNION ALL SELECT    30, '', '', '' FROM DUMMY
UNION ALL SELECT    90, '', '', RPAD('Generated with:', 27)            || 'SQL: "HANA_Global_CurrentStateReport" (SAP Note 1969700)' FROM DUMMY
UNION ALL SELECT   100, '', '', RPAD('Analysis time:',  27)            || TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS')     FROM DUMMY
UNION ALL SELECT   125, '', '', RPAD('System ID / database name:', 27) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME  FROM M_DATABASE
UNION ALL SELECT   127, '', '', RPAD('Revision level:', 27)            || VERSION                                                    FROM M_DATABASE
UNION ALL SELECT   130, '', '', RPAD('Configuration:',  27)            || 'Host:' || CHAR(32) || MAP(HOST, '%', 'all', HOST) || ', port:' || CHAR(32) || MAP(PORT, '%', 'all', PORT) ||
                                ', aggregation:' || CHAR(32) || AGGREGATE_BY FROM BASIS_INFO
UNION ALL SELECT 10000, '', '', '' FROM DUMMY
UNION ALL SELECT 10010, '', '', '***************************' FROM DUMMY
UNION ALL SELECT 10020, '', '', '* LOAD AND STATE OVERVIEW *' FROM DUMMY
UNION ALL SELECT 10030, '', '', '***************************' FROM DUMMY
UNION ALL SELECT 10040, '', '', '' FROM DUMMY
UNION ALL SELECT 10050, '', '', RPAD('CPU,', 11) || '|' || CHAR(32) || H1_PREFIX || LPAD('CPU_CORES', 9) || CHAR(32) || LPAD('CPU_THREADS', 11) || CHAR(32) ||
  LPAD('CPU_PCT', 7) || CHAR(32) || LPAD('SYS_PCT', 7) || CHAR(32) || LPAD('HOST_CPU_PCT', 12) || CHAR(32) || LPAD('PING_MS', 7) || CHAR(32) || 
  LPAD('MEM_PHYS_GB', 11) || CHAR(32) || LPAD('ALLOC_LIM_GB', 12) || CHAR(32) || LPAD('MEM_USED_GB', 11) || CHAR(32) || LPAD('UNLOADS', 7) || CHAR(32) ||
  LPAD('PMEM_USED_GB', 12) || CHAR(32) || RPAD('PMEM_TYPE', 9) FROM BASIS_INFO
UNION ALL SELECT 10060, '', '', RPAD('memory', 11) || '|' || CHAR(32) || H2_PREFIX || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || 
  LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) ||
  LPAD('=', 12, '=') || CHAR(32) || RPAD('=', 9, '=') FROM BASIS_INFO
UNION ALL
SELECT
  10100,
  L.HOST,
  L.PORT,
  RPAD('', 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.PORT, 6) ELSE '' END ||
  LPAD(L.CPU_CORES, 9) || CHAR(32) || LPAD(L.CPU_THREADS, 11) || CHAR(32) ||
  LPAD(L.CPU, 7) || CHAR(32) || LPAD(L.SYSTEM_CPU, 7) || CHAR(32) || LPAD(L.HOST_CPU, 12) || CHAR(32) || LPAD(L.PING_MS, 7) || CHAR(32) || 
  LPAD(L.MEM_PHYS_GB, 11) || CHAR(32) || LPAD(L.ALLOC_LIM_GB, 12) || CHAR(32) || LPAD(L.MEM_USED_GB, 11) || CHAR(32) || LPAD(L.UNLOADS, 7) || CHAR(32) || 
  LPAD(L.PMEM_USED_GB, 12) || CHAR(32) || RPAD(L.PMEM_TYPE, 9)
FROM
  BASIS_INFO BI,
  LOAD L
UNION ALL SELECT 11040, '', '', '' FROM DUMMY
UNION ALL SELECT 11050, '', '', RPAD('Sessions,', 11) || '|' || CHAR(32) || H1_PREFIX || LPAD('STMTS_PER_S', 11) || CHAR(32) || 
  LPAD('PEND_SESSIONS', 13) || CHAR(32) || LPAD('CONNS', 7) || CHAR(32) || LPAD('BUSY_CONNS', 10) || CHAR(32) || 
  LPAD('TRANSACTIONS', 12) || CHAR(32) || LPAD('BLOCKED_TRANS', 13) || CHAR(32) ||
  LPAD('THREADS', 7) || CHAR(32) || LPAD('ACT_THREADS', 11) || CHAR(32) || LPAD('WAIT_THREADS', 12) || CHAR(32) ||
  LPAD('TOT_SQL', 7) || CHAR(32) || LPAD('ACT_SQL', 7) || CHAR(32) || LPAD('WAIT_SQL', 8) FROM BASIS_INFO
UNION ALL SELECT 11060, '', '', RPAD('threads,', 11) || '|' || CHAR(32) || H2_PREFIX || LPAD('=', 11, '=') || CHAR(32) || 
  LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || 
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) FROM BASIS_INFO
UNION ALL
SELECT
  11100,
  L.HOST,
  L.PORT,
  RPAD(MAP(ROW_NUMBER() OVER (ORDER BY L.HOST, L.PORT), 1, 'statements', ' '), 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.PORT, 6) ELSE '' END ||
  LPAD(L.STMTS_PER_S, 11) || CHAR(32) || LPAD(L.PENDING_SESSIONS, 13) || CHAR(32) || LPAD(L.CONNECTION_COUNT, 7) || CHAR(32) || 
  LPAD(L.CONNECTION_COUNT - L.IDLE_CONNECTION_COUNT, 10) || CHAR(32) ||
  LPAD(L.TRANSACTION_COUNT, 12) || CHAR(32) || LPAD(L.BLOCKED_TRANSACTION_COUNT, 13) || CHAR(32) ||
  LPAD(L.TOT_THREADS, 7) || CHAR(32) || LPAD(L.ACT_THREADS, 11) || CHAR(32) || LPAD(L.WAIT_THREADS, 12) || CHAR(32) ||
  LPAD(L.TOT_SQL, 7) || CHAR(32) || LPAD(L.ACT_SQL, 7) || CHAR(32) || LPAD(L.WAIT_SQL, 8) || CHAR(32)
FROM
  BASIS_INFO BI,
  LOAD L
UNION ALL SELECT 12040, '', '', '' FROM DUMMY
UNION ALL SELECT 12050, '', '', RPAD('Disk I/O', 11) || '|' || CHAR(32) || H1_PREFIX || 
  LPAD('DATA_READ_VOL_MBPS', 18) || CHAR(32) || LPAD('DATA_READ_ACT_PCT', 17) || CHAR(32) || LPAD('DATA_WRT_VOL_MBPS', 17) || CHAR(32) || LPAD('DATA_WRT_ACT_PCT', 16) || CHAR(32) ||
  LPAD('LOG_READ_VOL_MBPS', 17) || CHAR(32) || LPAD('LOG_READ_ACT_PCT', 16) || CHAR(32) || LPAD('LOG_WRT_VOL_MBPS', 16) || CHAR(32) || LPAD('LOG_WRT_ACT_PCT', 15)  || CHAR(32) ||
  LPAD('ASYNC_REQ', 9)
FROM BASIS_INFO
UNION ALL SELECT 12060, '', '', RPAD('metrics', 11) || '|' || CHAR(32) || H2_PREFIX || 
  LPAD('=', 18, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 16, '=') || CHAR(32) ||
  LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 16, '=') || CHAR(32) || LPAD('=', 16, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) ||
  LPAD('=', 9, '=') 
FROM BASIS_INFO
UNION ALL
SELECT
  12100,
  L.HOST,
  L.PORT,
  RPAD('', 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.PORT, 6) ELSE '' END ||
  LPAD(L.DATA_READ_VOL_MBPS, 18) || CHAR(32) || LPAD(L.DATA_READ_ACT_PCT, 17) || CHAR(32) ||
  LPAD(L.DATA_WRT_VOL_MBPS, 17) || CHAR(32) || LPAD(L.DATA_WRT_ACT_PCT, 16) || CHAR(32) ||
  LPAD(L.LOG_READ_VOL_MBPS, 17) || CHAR(32) || LPAD(L.LOG_READ_ACT_PCT, 16) || CHAR(32) ||
  LPAD(L.LOG_WRT_VOL_MBPS, 16) || CHAR(32) || LPAD(L.LOG_WRT_ACT_PCT, 15) || CHAR(32) ||
  LPAD(L.ASYNC_REQ, 9)
FROM
  BASIS_INFO BI,
  LOAD L
UNION ALL SELECT TOP 1 12340, '', '', '' FROM IO_KEY_FIGURES
UNION ALL SELECT TOP 1 12350, '', '', RPAD('Disk I/O', 11) || '|' || CHAR(32) || H1_PREFIX || 
  RPAD('TYPE', 4) || CHAR(32) || LPAD('READ_VOL_MBPS', 13) || CHAR(32) || LPAD('READ_TP_MBPS', 12) || CHAR(32) || LPAD('READ_ACT_PCT', 12) || CHAR(32) || LPAD('AVG_READ_KB', 11) || CHAR(32) || LPAD('AVG_READ_MS', 11) || CHAR(32) ||
  LPAD('WRT_VOL_MBPS', 13) || CHAR(32) || LPAD('WRT_TP_MBPS', 12) || CHAR(32) || LPAD('WRT_ACT_PCT', 11) || CHAR(32) || LPAD('AVG_WRT_KB', 10) || CHAR(32) || LPAD('AVG_WRT_MS', 10)
  FROM BASIS_INFO, IO_KEY_FIGURES
UNION ALL SELECT TOP 1 12360, '', '', RPAD('key figures', 11) || '|' || CHAR(32) || H2_PREFIX ||
  RPAD('=', 4, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
  LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=')
  FROM BASIS_INFO, IO_KEY_FIGURES
UNION ALL
SELECT
  12400,
  I.HOST,
  I.PORT || I.TYPE,
  RPAD('', 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(I.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(I.PORT, 6) ELSE '' END ||
  RPAD(I.TYPE, 4) || CHAR(32) || LPAD(I.READ_VOL_MBPS, 13) || CHAR(32) || LPAD(I.READ_TP_MBPS, 12) || CHAR(32) || LPAD(I.READ_ACT_PCT, 12) || CHAR(32) || LPAD(I.AVG_READ_KB, 11) || CHAR(32) || LPAD(I.AVG_READ_MS, 11) || CHAR(32) ||
  LPAD(I.WRT_VOL_MBPS, 13) || CHAR(32) || LPAD(I.WRT_TP_MBPS, 12) || CHAR(32) || LPAD(I.WRT_ACT_PCT, 11) || CHAR(32) || LPAD(I.AVG_WRT_KB, 10) || CHAR(32) || LPAD(I.AVG_WRT_MS, 10)
FROM
  BASIS_INFO BI,
  IO_KEY_FIGURES I
UNION ALL SELECT 13040, '', '', '' FROM DUMMY
UNION ALL SELECT 13050, '', '', RPAD('MVCC,', 11) || '|' || CHAR(32) || H1_PREFIX || 
  RPAD('LOCAL_LOCK_START', 19) || CHAR(32) || RPAD('GLOBAL_LOCK_START', 19) || CHAR(32) || LPAD('HIST_FILES', 10) || CHAR(32) || LPAD('VERSIONS', 9) || CHAR(32) || LPAD('DATA_VERSIONS', 13) || CHAR(32) || 
  LPAD('METADATA_VERSIONS', 17) || CHAR(32) || LPAD('COMM_ID_RANGE', 13) FROM BASIS_INFO
UNION ALL SELECT 13060, '', '', RPAD('garbage', 11) || '|' || CHAR(32) || H2_PREFIX || 
  RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || 
  LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 13, '=') FROM BASIS_INFO
UNION ALL
SELECT
  13100,
  L.HOST ,
  L.PORT,
  RPAD(MAP(ROW_NUMBER() OVER (ORDER BY L.HOST, L.PORT), 1, 'collection', ' '), 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.PORT, 6) ELSE '' END ||
  RPAD(IFNULL(G.LOCAL_LOCK_TIME, ''), 19) || CHAR(32) || RPAD(IFNULL(G.GLOBAL_LOCK_TIME, ''), 19) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(G.HISTORY_FILES), ''), 10) || CHAR(32) || 
    LPAD(IFNULL(TO_VARCHAR(L.VERSIONS), ''), 9) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(G.DATA_VERSIONS), ''), 13) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(G.METADATA_VERSIONS), ''), 17) || CHAR(32) || 
    LPAD(IFNULL(TO_VARCHAR(L.COMMIT_ID_RANGE), ''), 13)
FROM
  BASIS_INFO BI,
  LOAD L LEFT OUTER JOIN
  GARBAGE_COLLECTION G ON
    G.HOST = L.HOST AND
    G.PORT = L.PORT
UNION ALL SELECT 14000, '', '', '' FROM DUMMY
UNION ALL SELECT 14050, '', '', RPAD('Workload', 11) || '|' || CHAR(32) || H1_PREFIX || LPAD('EXEC_PER_S', 10) || CHAR(32) || LPAD('PREP_PER_S', 10) || CHAR(32) || LPAD('TRANS_PER_S', 11) || CHAR(32) || LPAD('UPD_TRANS_PER_S', 15) || CHAR(32) ||
   LPAD('COMMITS_PER_S', 13) || CHAR(32) || LPAD('ROLLBACKS_PER_S', 15) || CHAR(32) || LPAD('MEM_MB_PER_S', 12) FROM BASIS_INFO
UNION ALL SELECT 14060, '', '', RPAD('', 11) || '|' || CHAR(32) || H2_PREFIX || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) ||
   LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 12, '=') FROM BASIS_INFO
UNION ALL
SELECT
  14100,
  W.HOST,
  W.PORT,
  RPAD('', 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(W.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(W.PORT, 6) ELSE '' END ||
  LPAD(W.EXEC_PER_S, 10) || CHAR(32) || LPAD(W.COMP_PER_S, 10) || CHAR(32) || LPAD(W.TRANS_PER_S, 11) || CHAR(32) || LPAD(W.UPD_TRANS_PER_S, 15) || CHAR(32) ||
   LPAD(W.COMMITS_PER_S, 13) || CHAR(32) || LPAD(W.ROLLBACKS_PER_S, 15) || CHAR(32) || LPAD(W.MEM_MB_PER_S, 12)
FROM
  BASIS_INFO BI,
  WORKLOAD W
UNION ALL SELECT TOP 1 15000, '', '', '' FROM SYSTEM_REPLICATION
UNION ALL SELECT 15050, '', '', RPAD('System', 11) || '|' || CHAR(32) || H1_PREFIX || MAP(R.SECONDARY_HOST, 'any', '', RPAD('SECONDARY_HOST', GREATEST(14, R.SECONDARY_HOST_LEN)) || CHAR(32)) || 
  RPAD('REPLICATION_MODE', 16) || CHAR(32) || RPAD('OPERATION_MODE', 20) || CHAR(32) || 
  RPAD('FULL_SYNC', 9) || CHAR(32) || RPAD('REPLICATION_STATUS', 18) || CHAR(32) || LPAD('LOG_SHIP_MS', 11) || CHAR(32) || LPAD('SHP_BL_MB', 10) || CHAR(32) || LPAD('SHP_DL_S', 9) || CHAR(32) || 
  LPAD('REP_BL_MB', 10) || CHAR(32) || LPAD('REP_DL_S', 9) || CHAR(32) || RPAD('SECONDARY_ACTIVE_STATUS', 23) || CHAR(32) ||
  'REPLICATION_STATUS_DETAILS' FROM BASIS_INFO, ( SELECT TOP 1 * FROM SYSTEM_REPLICATION ) R
UNION ALL SELECT 15060, '', '', RPAD('replication', 11) || '|' || CHAR(32) || H2_PREFIX || MAP(R.SECONDARY_HOST, 'any', '', RPAD('=', GREATEST(14, R.SECONDARY_HOST_LEN), '=') || CHAR(32)) || 
  RPAD('=', 16, '=') || CHAR(32) || RPAD('=', 20, '=') || CHAR(32) || 
  RPAD('=', 9, '=') || CHAR(32) || RPAD('=', 18, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) ||
  LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || RPAD('=', 23, '=') || CHAR(32) || 
  LPAD('=', 26, '=') FROM BASIS_INFO, (SELECT TOP 1 * FROM SYSTEM_REPLICATION ) R
UNION ALL
SELECT
  15100,
  R.HOST,
  R.PORT,
  RPAD('', 11) || '|' || CHAR(32) || CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(R.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(R.PORT, 6) ELSE '' END ||
  MAP(R.SECONDARY_HOST, 'any', '', RPAD(R.SECONDARY_HOST, GREATEST(14, R.SECONDARY_HOST_LEN)) || CHAR(32)) || RPAD(R.REPLICATION_MODE, 16) || CHAR(32) || RPAD(R.OPERATION_MODE, 20) || CHAR(32) || 
  RPAD(R.FULL_SYNC, 9) || CHAR(32) || RPAD(R.REPLICATION_STATUS, 18) || CHAR(32) || LPAD(R.LOG_SHIP_MS, 11) || CHAR(32) || LPAD(R.SHP_BL_MB, 10) || CHAR(32) || LPAD(R.SHP_DL_S, 9) || CHAR(32) || 
  LPAD(R.REP_BL_MB, 10) || CHAR(32) || LPAD(R.REP_DL_S, 9) || CHAR(32) || RPAD(R.SECONDARY_ACTIVE_STATUS, 23) || CHAR(32) || R.REPLICATION_STATUS_DETAILS
FROM
  BASIS_INFO BI,
  SYSTEM_REPLICATION R
UNION ALL SELECT 20000, '', '', '' FROM DUMMY
UNION ALL SELECT 20010, '', '', '******************' FROM DUMMY
UNION ALL SELECT 20020, '', '', '* MEMORY DETAILS *' FROM DUMMY
UNION ALL SELECT 20030, '', '', '******************' FROM DUMMY
UNION ALL SELECT 20040, '', '', '' FROM DUMMY
UNION ALL SELECT 20050, '', '', H1_PREFIX || RPAD('HEAP_ALLOCATOR', H.HEAP_ALLOCATOR_LEN) || CHAR(32) || LPAD('MEM_USED_GB', 11) || CHAR(32) || LPAD('COUNT', 5) || CHAR(32) ||
  RPAD('COMPONENT', 40) FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL SELECT 20060, '', '', H2_PREFIX || RPAD('=', H.HEAP_ALLOCATOR_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', 40, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL
SELECT
  20100,
  LPAD(99999 - H.MEM_USED_GB, 10),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(H.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(H.PORT, 6) ELSE '' END ||
  RPAD(H.HEAP_ALLOCATOR, H.HEAP_ALLOCATOR_LEN) || CHAR(32) || LPAD(H.MEM_USED_GB, 11) || CHAR(32) || LPAD(H.COUNT, 5) || CHAR(32) ||
  H.COMPONENT
FROM
  BASIS_INFO BI,
  HEAP_ALLOCATORS H
UNION ALL SELECT TOP 1 20105, '', '', '' FROM TRANSLATION_TABLES
UNION ALL SELECT TOP 1 20110, '', '', '**********************' FROM TRANSLATION_TABLES
UNION ALL SELECT TOP 1 20120, '', '', '* TRANSLATION TABLES *' FROM TRANSLATION_TABLES
UNION ALL SELECT TOP 1 20130, '', '', '**********************' FROM TRANSLATION_TABLES
UNION ALL SELECT TOP 1 20140, '', '', '' FROM TRANSLATION_TABLES
UNION ALL SELECT TOP 1 20150, '', '', H1_PREFIX || RPAD('SCHEMA_NAME_1', SCHEMA_1_LEN) || CHAR(32) || RPAD('TABLE_NAME_1', TABLE_1_LEN) || CHAR(32) || RPAD('COLUMN_NAME_1', COLUMN_1_LEN) || CHAR(32) ||
  RPAD('SCHEMA_NAME_2', SCHEMA_2_LEN) || CHAR(32) || RPAD('TABLE_NAME_2', TABLE_2_LEN) || CHAR(32) || RPAD('COLUMN_NAME_2', COLUMN_2_LEN) || CHAR(32) || 
  LPAD('NUM_TTS', 7) || CHAR(32) || LPAD('TT_SIZE_MB', 10) FROM TRANSLATION_TABLES, BASIS_INFO
UNION ALL SELECT TOP 1 20160, '', '', H2_PREFIX || RPAD('=', SCHEMA_1_LEN, '=') || CHAR(32) || RPAD('=', TABLE_1_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_1_LEN, '=') || CHAR(32) ||
  RPAD('=', SCHEMA_2_LEN, '=') || CHAR(32) || RPAD('=', TABLE_2_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_2_LEN, '=') || CHAR(32) || 
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 10, '=') FROM TRANSLATION_TABLES, BASIS_INFO
UNION ALL
SELECT
  20170, 
  LPAD(999999999 - TT_SIZE_MB * 100, 10),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(TT.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(TT.PORT, 6) ELSE '' END ||
  RPAD(TT.SCHEMA_NAME_1, SCHEMA_1_LEN) || CHAR(32) || RPAD(TT.TABLE_NAME_1, TABLE_1_LEN) || CHAR(32) || RPAD(TT.COLUMN_NAME_1, COLUMN_1_LEN) || CHAR(32) ||
  RPAD(TT.SCHEMA_NAME_2, SCHEMA_2_LEN) || CHAR(32) || RPAD(TT.TABLE_NAME_2, TABLE_2_LEN) || CHAR(32) || RPAD(TT.COLUMN_NAME_2, COLUMN_2_LEN) || CHAR(32) || 
  LPAD(TT.NUM_TTS, 7) || CHAR(32) || LPAD(TT.TT_SIZE_MB, 10)
FROM
  BASIS_INFO BI,
  TRANSLATION_TABLES TT
UNION ALL SELECT 20200, '', '', '' FROM DUMMY
UNION ALL SELECT 20210, '', '', '********************' FROM DUMMY
UNION ALL SELECT 20220, '', '', '* TEMPORARY TABLES *' FROM DUMMY
UNION ALL SELECT 20230, '', '', '********************' FROM DUMMY
UNION ALL SELECT 20240, '', '', '' FROM DUMMY
UNION ALL SELECT TOP 1 20250, '', '', RPAD('SCHEMA_NAME', SCHEMA_NAME_LEN) || CHAR(32) || RPAD('TABLE_CLASS', TABLE_CLASS_LEN) || CHAR(32) || RPAD('TABLE_TYPE', 10) || CHAR(32) ||
  LPAD('TABLES', 7) || CHAR(32) || LPAD('RECORDS', 12) || CHAR(32) || LPAD('SIZE_GB', 10) FROM TEMPORARY_TABLES
UNION ALL SELECT TOP 1 20260, '', '', RPAD('=', SCHEMA_NAME_LEN, '=') || CHAR(32) || RPAD('=', TABLE_CLASS_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 10, '=') FROM TEMPORARY_TABLES
UNION ALL SELECT 
  20300, 
  LPAD(999999999 - TABLES, 10),
  '',
  RPAD(SCHEMA_NAME, SCHEMA_NAME_LEN) || CHAR(32) || RPAD(TABLE_CLASS, TABLE_CLASS_LEN) || CHAR(32) || RPAD(TABLE_TYPE, 10) || CHAR(32) ||
  LPAD(TABLES, 7) || CHAR(32) || LPAD(RECORD_COUNT, 12) || CHAR(32) || LPAD(TABLE_SIZE_GB, 10)
FROM 
  TEMPORARY_TABLES
UNION ALL SELECT TOP 1 20400, '', '', '' FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20410, '', '', '*************************' FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20420, '', '', '* CALCULATION SCENARIOS *' FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20430, '', '', '*************************' FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20440, '', '', '' FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20450, '', '', RPAD('SCHEMA_NAME', SCHEMA_NAME_LEN) || CHAR(32) || RPAD('SCENARIO_CLASS', SCENARIO_CLASS_LEN) || CHAR(32) || RPAD('COMPONENT', COMPONENT_LEN) || CHAR(32) ||
  RPAD('IS_PERSISTENT', 13) || CHAR(32) || LPAD('SCENARIOS', 9) FROM CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20460, '', '', RPAD('=', SCHEMA_NAME_LEN, '=') || CHAR(32) || RPAD('=', SCENARIO_CLASS_LEN, '=') || CHAR(32) || RPAD('=', COMPONENT_LEN, '=') || CHAR(32) ||
  RPAD('=', 13, '=') || CHAR(32) || LPAD('=', 9, '=') FROM CALCULATION_SCENARIOS
UNION ALL SELECT 
  20500, 
  LPAD(999999999 - SCENARIOS, 10),
  '',
  RPAD(SCHEMA_NAME, SCHEMA_NAME_LEN) || CHAR(32) || RPAD(SCENARIO_CLASS, SCENARIO_CLASS_LEN) || CHAR(32) || RPAD(COMPONENT, COMPONENT_LEN) || CHAR(32) ||
  RPAD(IS_PERSISTENT, 13) || CHAR(32) || LPAD(SCENARIOS, 9)
FROM 
  CALCULATION_SCENARIOS
UNION ALL SELECT TOP 1 20600, '', '', '' FROM CACHES
UNION ALL SELECT TOP 1 20610, '', '', '**********' FROM CACHES
UNION ALL SELECT TOP 1 20620, '', '', '* CACHES *' FROM CACHES
UNION ALL SELECT TOP 1 20630, '', '', '**********' FROM CACHES
UNION ALL SELECT TOP 1 20640, '', '', '' FROM CACHES
UNION ALL SELECT TOP 1 20650, '', '', H1_PREFIX || RPAD('CACHE_ID', CACHE_ID_LEN) || CHAR(32) || LPAD('SIZE_GB', 7) || CHAR(32) || LPAD('ENTRIES', 8) || CHAR(32) || 
  LPAD('INSERTS', 10) || CHAR(32) || LPAD('INVALIDATIONS', 13) || CHAR(32) || LPAD('HITS', 10) || CHAR(32) || LPAD('MISSES', 10) || CHAR(32) || LPAD('HIT_PCT', 7) FROM CACHES, BASIS_INFO
UNION ALL SELECT TOP 1 20660, '', '', H2_PREFIX || RPAD('=', CACHE_ID_LEN, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || 
  LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 7, '=') FROM CACHES, BASIS_INFO
UNION ALL
SELECT
  20700,
  C.HOST,
  LPAD(99999 - C.SIZE_GB, 10),
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.PORT, 6) ELSE '' END ||
  RPAD(C.CACHE_ID, C.CACHE_ID_LEN) || CHAR(32) || LPAD(C.SIZE_GB, 7) || CHAR(32) || LPAD(C.ENTRIES, 8) || CHAR(32) || 
  LPAD(C.INSERTS, 10) || CHAR(32) || LPAD(C.INVALIDATIONS, 13) || CHAR(32) || LPAD(C.HITS, 10) || CHAR(32) || LPAD(C.MISSES, 10) || CHAR(32) || LPAD(C.HIT_PCT, 7)
FROM
  BASIS_INFO BI,
  CACHES C
UNION ALL SELECT 21000, '', '', '' FROM DUMMY
UNION ALL SELECT 21010, '', '', '***************' FROM DUMMY
UNION ALL SELECT 21020, '', '', '* CPU DETAILS *' FROM DUMMY
UNION ALL SELECT 21030, '', '', '***************' FROM DUMMY
UNION ALL SELECT 21040, '', '', '' FROM DUMMY
UNION ALL SELECT 21050, '', '', H1_NO_PORT_PREFIX || LPAD('NUMA_NODE', 9) || CHAR(32) || LPAD('CPU_THREADS', 11) || CHAR(32) ||
    LPAD('USER_PCT', 8) || CHAR(32) || LPAD('SYSTEM_PCT', 10) || CHAR(32) ||
    LPAD('WAITIO_PCT', 10) || CHAR(32) || LPAD('BUSY_PCT', 8) || CHAR(32) || LPAD('IDLE_PCT', 8) FROM BASIS_INFO
UNION ALL SELECT 21060, '', '', H2_NO_PORT_PREFIX || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 8, '=') FROM BASIS_INFO
UNION ALL
SELECT
  21100,
  C.HOST,
  LPAD(C.NUMA_NODE, 10),
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  LPAD(C.NUMA_NODE, 9) || CHAR(32) || LPAD(C.CPU_THREADS, 11) || CHAR(32) ||
    LPAD(C.USER_PCT, 8) || CHAR(32) || LPAD(C.SYSTEM_PCT, 10) || CHAR(32) ||
    LPAD(C.WAITIO_PCT, 10) || CHAR(32) || LPAD(C.BUSY_PCT, 8) || CHAR(32) || LPAD(C.IDLE_PCT, 8)
FROM
  BASIS_INFO BI,
  CPUS C
UNION ALL SELECT 21200, '', '', '' FROM DUMMY
UNION ALL SELECT 21250, '', '', H1_NO_PORT_PREFIX || LPAD('CPU_THREADS', 11) || CHAR(32) || LPAD('LOADAVG_1MIN', 12) || CHAR(32) || LPAD('LOADAVG_5MIN', 12) || CHAR(32) || LPAD('LOADAVG_15MIN', 13) || CHAR(32) ||
    LPAD('STEAL_PCT', 9) || CHAR(32) || LPAD('CTX_SWITCHES_PER_S', 18) || CHAR(32) || LPAD('INTERRUPTS_PER_S', 16)
 FROM BASIS_INFO
UNION ALL SELECT 21260, '', '', H2_NO_PORT_PREFIX || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) ||
    LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 18, '=') || CHAR(32) || LPAD('=', 16, '=') FROM BASIS_INFO
UNION ALL
SELECT
  21300,
  C.HOST,
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END || LPAD(C.LOGICAL_CPUS, 11) || CHAR(32) ||
  LPAD(C.LOADAVG_1MIN, 12) || CHAR(32) || LPAD(C.LOADAVG_5MIN, 12) || CHAR(32) || LPAD(C.LOADAVG_15MIN, 13) || CHAR(32) ||
    LPAD(C.STEAL_PCT, 9) || CHAR(32) || LPAD(C.CTX_SWITCHES_PER_S, 18) || CHAR(32) || LPAD(C.INTERRUPTS_PER_S, 16)
FROM
  BASIS_INFO BI,
  CPUS_2 C
UNION ALL SELECT 22000, '', '', '' FROM DUMMY
UNION ALL SELECT 22010, '', '', '****************' FROM DUMMY
UNION ALL SELECT 22020, '', '', '* DISK DETAILS *' FROM DUMMY
UNION ALL SELECT 22030, '', '', '****************' FROM DUMMY
UNION ALL SELECT 22040, '', '', '' FROM DUMMY
UNION ALL SELECT TOP 1 22050, '', '', H1_NO_PORT_PREFIX || RPAD('DISK', DISK_LEN) || CHAR(32) || LPAD('QUEUE_SIZE', 10) || CHAR(32) || LPAD('SERVICE_MS', 10) || CHAR(32) || LPAD('WAIT_MS', 7) || CHAR(32) ||
    LPAD('IO_PER_S', 8) || CHAR(32) || LPAD('THROUGHPUT_KBPS', 15) FROM DISKS, BASIS_INFO
UNION ALL SELECT TOP 1 22060, '', '', H2_NO_PORT_PREFIX || RPAD('=', DISK_LEN, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 15, '=') FROM DISKS, BASIS_INFO
UNION ALL
SELECT
  22100,
  D.HOST,
  D.DISK,
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(D.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  RPAD(D.DISK, DISK_LEN) || CHAR(32) || LPAD(D.QUEUE, 10) || CHAR(32) || LPAD(D.SRV_MS, 10) || CHAR(32) || LPAD(D.WAIT_MS, 7) || CHAR(32) ||
    LPAD(IO_PER_S, 8) || CHAR(32) || LPAD(D.TP_KBPS, 15)
FROM
  BASIS_INFO BI,
  DISKS D
UNION ALL SELECT 30000, '', '', '' FROM DUMMY
UNION ALL SELECT 30010, '', '', '*******************' FROM DUMMY
UNION ALL SELECT 30020, '', '', '* THREAD ACTIVITY *' FROM DUMMY
UNION ALL SELECT 30030, '', '', '*******************' FROM DUMMY
UNION ALL SELECT 30040, '', '', '' FROM DUMMY
UNION ALL SELECT 30050, '', '', H1_PREFIX || LPAD('NM', 2) || CHAR(32) || LPAD('CONNID', 6) || CHAR(32) || LPAD('THREAD', 6) || CHAR(32) || MAP(BLK_THR_LEN, 1, '', LPAD('BLK_THR', BLK_THR_LEN) || CHAR(32)) ||
  LPAD('DUR_S', 6) || CHAR(32) || LPAD('CPU_S', 5) || CHAR(32) || RPAD('THREAD_TYPE', THREAD_TYPE_LEN) || CHAR(32) || RPAD('STATE', THREAD_STATE_LEN ) || CHAR(32) || 
  'Q' || CHAR(32) || RPAD('LOCK_NAME', LOCK_NAME_LEN) || CHAR(32) || RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('THREAD_METHOD', THREAD_METHOD_LEN) || CHAR(32) || 
  RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || RPAD('APP_NAME', APP_NAME_LEN) || CHAR(32) || RPAD('APP_SOURCE', APP_SOURCE_LEN) || CHAR(32) || 
  RPAD('THREAD_DETAIL', THREAD_DETAIL_LEN) FROM BASIS_INFO, ( SELECT TOP 1 * FROM THREADS )
UNION ALL SELECT 30060, '', '', H2_PREFIX || LPAD('=', 2, '=') || CHAR(32) || LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 6, '=') || CHAR(32) || MAP(BLK_THR_LEN, 1, '', LPAD('=', BLK_THR_LEN, '=') || CHAR(32)) ||
  LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', THREAD_TYPE_LEN, '=') || CHAR(32) || RPAD('=', THREAD_STATE_LEN, '=') || CHAR(32) || 
  '=' || CHAR(32) || RPAD('=', LOCK_NAME_LEN, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', THREAD_METHOD_LEN, '=') || CHAR(32) || 
  RPAD('=', APP_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_NAME_LEN, '=') || CHAR(32) || RPAD('=', APP_SOURCE_LEN, '=') || CHAR(32) || 
  RPAD('=', THREAD_DETAIL_LEN, '=') FROM BASIS_INFO, (SELECT TOP 1 * FROM THREADS )
UNION ALL
SELECT
  30100,
  T.HOST,
  T.PORT || T.CONN_ID || LPAD(999999999 - DUR_S, 15) || T.THREAD_ID,
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(T.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(T.PORT, 6) ELSE '' END ||
  LPAD(T.NUMA_NODE, 2) || CHAR(32) || 
  LPAD(T.CONN_ID, 6) || CHAR(32) || 
  LPAD(T.THREAD_ID, 6) || CHAR(32) ||
  MAP(T.BLK_THR_LEN, 1, '', LPAD(T.BLK_THR, T.BLK_THR_LEN) || CHAR(32)) ||
  LPAD(T.DUR_S, 6) || CHAR(32) || 
  LPAD(T.CPU_S, 5) || CHAR(32) ||
  RPAD(T.THREAD_TYPE, T.THREAD_TYPE_LEN) || CHAR(32) ||
  RPAD(T.THREAD_STATE, T.THREAD_STATE_LEN) || CHAR(32) ||
  RPAD(T.Q, 1) || CHAR(32) ||
  RPAD(T.LOCK_NAME, T.LOCK_NAME_LEN) || CHAR(32) ||
  RPAD(T.STATEMENT_HASH, 32) || CHAR(32) ||
  RPAD(T.THREAD_METHOD, T.THREAD_METHOD_LEN) || CHAR(32) || 
  RPAD(T.APP_USER, T.APP_USER_LEN) || CHAR(32) ||
  RPAD(T.APP_NAME, T.APP_NAME_LEN) || CHAR(32) ||
  RPAD(T.APP_SOURCE, T.APP_SOURCE_LEN) || CHAR(32) ||
  RPAD(T.THREAD_DETAIL, T.THREAD_DETAIL_LEN)
FROM
  BASIS_INFO BI,
  THREADS T
UNION ALL SELECT TOP 1 40000, '', '', '' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 40010, '', '', '*********************' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 40020, '', '', '* ACTIVE STATEMENTS *' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 40030, '', '', '*********************' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 40040, '', '', '' FROM ACTIVE_STATEMENTS
UNION ALL SELECT 40050, '', '', H1_PREFIX || RPAD('START_TIME', 19) || CHAR(32) || LPAD('DURATION_S', 10) || CHAR(32) || LPAD('CONN_ID', 10) || CHAR(32) || RPAD('STATUS', 9) || CHAR(32) ||
  LPAD('MEM_MB', 7) || CHAR(32) || RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('APP_USER', GREATEST(8, A.APP_USER_LEN)) || CHAR(32) || RPAD('APPLICATION_SOURCE_AND_STATEMENT_STRING', 80) FROM BASIS_INFO, ( SELECT TOP 1 * FROM ACTIVE_STATEMENTS ) A
UNION ALL SELECT 40060, '', '', H2_PREFIX || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', GREATEST(8, A.APP_USER_LEN), '=') || CHAR(32) || RPAD('=', 80, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM ACTIVE_STATEMENTS ) A
UNION ALL
SELECT
  40100,
  LPAD(999999999 - A.DURATION_S, 10) || A.CONNECTION_ID || A.STATEMENT_ID,
  LPAD(A.LINE_NO, 10),
  CASE
    WHEN A.LINE_NO = 1 THEN CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(A.HOST, BI.HOST_LEN + 1) ELSE '' END ||
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(A.PORT, 6) ELSE '' END ||
      RPAD(IFNULL(A.START_TIME, ''), 19) || CHAR(32) || LPAD(IFNULL(A.DURATION_S, 0), 10) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(A.CONNECTION_ID), ''), 10) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_STATUS, ''), 9) || CHAR(32) ||
      LPAD(IFNULL(TO_VARCHAR(A.MEM_MB), ''), 7) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_HASH, ''), 32) || CHAR(32) || RPAD(IFNULL(A.APP_USER, ''), GREATEST(8, IFNULL(A.APP_USER_LEN, 0))) || CHAR(32)
    ELSE LPAD('', LENGTH(CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(A.HOST, BI.HOST_LEN + 1) ELSE '' END ||
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(A.PORT, 6) ELSE '' END ||
      RPAD(IFNULL(A.START_TIME, ''), 19) || CHAR(32) || LPAD(IFNULL(A.DURATION_S, 0), 10) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(A.CONNECTION_ID), ''), 10) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_STATUS, ''), 9) || CHAR(32) ||
      LPAD(IFNULL(TO_VARCHAR(IFNULL(A.MEM_MB, 0)), ''), 7) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_HASH, ''), 32) || CHAR(32) || RPAD(IFNULL(A.APP_USER, ''), GREATEST(8, IFNULL(A.APP_USER_LEN, 0))) || CHAR(32)))
  END ||
  SUBSTR(IFNULL(A.STATEMENT_STRING, ''), POS_1 + 1, POS_2 - POS_1)
FROM
  BASIS_INFO BI,
  ( SELECT
      A.*,
      MAP(LINE_NO, 1, 0, LAG(POS, 1) OVER (PARTITION BY HOST, PORT, CONNECTION_ID, STATEMENT_ID ORDER BY LINE_NO)) POS_1,
      MAP(LINE_NO, MAX_LINE_NO, LENGTH(STATEMENT_STRING), POS) POS_2
    FROM
    ( SELECT
        L.LINE_NO,
        MAX(L.LINE_NO) OVER (PARTITION BY HOST, PORT, CONNECTION_ID, STATEMENT_ID) MAX_LINE_NO,
        A.*,
        (L.LINE_NO - 1) * 80 + GREATEST(LOCATE(SUBSTR(A.STATEMENT_STRING, L.LINE_NO * 80 - 79, 80), CHAR(32), -1), 
                                        LOCATE(SUBSTR(A.STATEMENT_STRING, L.LINE_NO * 80 - 79, 80), '.',      -1), 
                                        LOCATE(SUBSTR(A.STATEMENT_STRING, L.LINE_NO * 80 - 79, 80), '|',      -1), 
                                        LOCATE(SUBSTR(A.STATEMENT_STRING, L.LINE_NO * 80 - 79, 80), ',',      -1)) POS
      FROM
      ( SELECT TOP 80 ROW_NUMBER () OVER () LINE_NO FROM OBJECTS ) L,
      ( SELECT * FROM ACTIVE_STATEMENTS WHERE STATEMENT_STATUS != 'SUSPENDED' UNION ALL
        SELECT TOP 20 * FROM ACTIVE_STATEMENTS WHERE STATEMENT_STATUS = 'SUSPENDED' ORDER BY START_TIME ) A
      WHERE
       L.LINE_NO <= ( LENGTH(A.STATEMENT_STRING) - 1 ) / 80 + 1
    ) A
  ) A
UNION ALL SELECT TOP 1 55000, '', '', '' FROM ACTIVE_PROCEDURES
UNION ALL SELECT TOP 1 55010, '', '', '*********************' FROM ACTIVE_PROCEDURES
UNION ALL SELECT TOP 1 55020, '', '', '* ACTIVE PROCEDURES *' FROM ACTIVE_PROCEDURES
UNION ALL SELECT TOP 1 55030, '', '', '*********************' FROM ACTIVE_PROCEDURES
UNION ALL SELECT TOP 1 55040, '', '', '' FROM ACTIVE_PROCEDURES
UNION ALL SELECT 55050, '', '', H1_PREFIX || RPAD('START_TIME', 19) || CHAR(32) || LPAD('CONN_ID', 7) || CHAR(32) || LPAD('EXECUTIONS', 10) || CHAR(32) || LPAD('EXEC_TIME_MS', 12) || CHAR(32) || 
  RPAD('PROCEDURE_NAME', AP.PROCEDURE_LEN) || CHAR(32) || STATEMENT_STRING FROM BASIS_INFO, (SELECT TOP 1 * FROM ACTIVE_PROCEDURES) AP
UNION ALL SELECT 55060, '', '', H2_PREFIX || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
  RPAD('=', AP.PROCEDURE_LEN, '=') || CHAR(32) || RPAD('=', 80, '=') FROM BASIS_INFO, (SELECT TOP 1 * FROM ACTIVE_PROCEDURES) AP
UNION ALL
SELECT
  55100,
  TO_VARCHAR(AP.START_TIME, 'YYYY/MM/DD HH24:MI:SS'),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(AP.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(AP.PORT, 6) ELSE '' END ||
  RPAD(AP.START_TIME, 19) || CHAR(32) ||
  LPAD(AP.CONN_ID, 7) || CHAR(32) ||
  LPAD(AP.EXECUTIONS, 10) || CHAR(32) ||
  LPAD(AP.EXEC_TIME_MS, 12) || CHAR(32) ||
  RPAD(AP.PROCEDURE_NAME, AP.PROCEDURE_LEN) || CHAR(32) ||
  STATEMENT_STRING
FROM
  BASIS_INFO BI,
  ACTIVE_PROCEDURES AP
UNION ALL SELECT TOP 1 50000, '', '', '' FROM JOB_PROGRESS
UNION ALL SELECT TOP 1 50010, '', '', '***************' FROM JOB_PROGRESS
UNION ALL SELECT TOP 1 50020, '', '', '* ACTIVE JOBS *' FROM JOB_PROGRESS
UNION ALL SELECT TOP 1 50030, '', '', '***************' FROM JOB_PROGRESS
UNION ALL SELECT TOP 1 50040, '', '', '' FROM JOB_PROGRESS
UNION ALL SELECT 50050, '', '', H1_PREFIX || RPAD('START_TIME', 19) || CHAR(32) || LPAD('DURATION_S', 10) || CHAR(32) || RPAD('JOB_NAME', 33) || CHAR(32) || RPAD('PROGRESS', 18) || CHAR(32) ||
  RPAD('PROGRESS_DETAIL', J.PROGRESS_DETAIL_LEN) || CHAR(32) || RPAD('SCHEMA_NAME', J.SCHEMA_NAME_LEN) || CHAR(32) || RPAD('OBJECT_NAME', J.OBJECT_NAME_LEN) FROM BASIS_INFO, (SELECT TOP 1 * FROM JOB_PROGRESS) J
UNION ALL SELECT 50060, '', '', H2_PREFIX || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 33, '=') || CHAR(32) || RPAD('=', 18, '=') || CHAR(32) || 
  RPAD('=', J.PROGRESS_DETAIL_LEN, '=') || CHAR(32) || RPAD('=', J.SCHEMA_NAME_LEN, '=') || CHAR(32) || RPAD('=', J.OBJECT_NAME_LEN, '=') FROM BASIS_INFO, (SELECT TOP 1 * FROM JOB_PROGRESS) J
UNION ALL
SELECT
  50100,
  TO_VARCHAR(J.START_TIME, 'YYYY/MM/DD HH24:MI:SS'),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(J.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(J.PORT, 6) ELSE '' END ||
  RPAD(J.START_TIME, 19) || CHAR(32) || 
  LPAD(J.DURATION_S, 10) || CHAR(32) ||
  RPAD(J.JOB_NAME, 33) || CHAR(32) ||
  RPAD(J.PROGRESS, 18) || CHAR(32) ||
  RPAD(IFNULL(J.PROGRESS_DETAIL, ''), J.PROGRESS_DETAIL_LEN) || CHAR(32) ||
  RPAD(IFNULL(J.SCHEMA_NAME, ''), J.SCHEMA_NAME_LEN) || CHAR(32) ||
  RPAD(IFNULL(J.OBJECT_NAME, ''), J.OBJECT_NAME_LEN)
FROM
  BASIS_INFO BI,
  JOB_PROGRESS J
UNION ALL SELECT 58000, '', '', '' FROM DUMMY
UNION ALL SELECT 58010, '', '', '**********************' FROM DUMMY
UNION ALL SELECT 58020, '', '', '* SQL CACHE OVERVIEW *' FROM DUMMY
UNION ALL SELECT 58030, '', '', '**********************' FROM DUMMY
UNION ALL SELECT 58040, '', '', '' FROM DUMMY
UNION ALL SELECT 58050, '', '', H1_PREFIX || LPAD('CONF_GB', 7) || CHAR(32) || LPAD('USED_GB', 7) || CHAR(32) || LPAD('CACHED_SQLS', 11) || CHAR(32) ||
    LPAD('AVG_SIZE_KB', 11) || CHAR(32) || LPAD('EVICT_PER_H', 11) || CHAR(32) || LPAD('HIT_PCT', 7) FROM BASIS_INFO
UNION ALL SELECT 58060, '', '', H2_PREFIX || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 7, '=') FROM BASIS_INFO
UNION ALL
SELECT
  58100,
  C.HOST || C.PORT,
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.PORT, 6) ELSE '' END ||
  LPAD(C.CONF_GB, 7) || CHAR(32) || LPAD(C.USED_GB, 7) || CHAR(32) || LPAD(C.PLANS, 11) || CHAR(32) ||
    LPAD(C.AVG_SIZE_KB, 11) || CHAR(32) || LPAD(C.EVICT_PER_H, 11) || CHAR(32) || LPAD(C.HIT_PCT, 7)
FROM
  BASIS_INFO BI,
  SQL_CACHE_OVERVIEW C
UNION ALL SELECT 60000, '', '', '' FROM DUMMY
UNION ALL SELECT 60010, '', '', '*************' FROM DUMMY
UNION ALL SELECT 60020, '', '', '* SQL CACHE *' FROM DUMMY
UNION ALL SELECT 60030, '', '', '*************' FROM DUMMY
UNION ALL SELECT 60040, '', '', '' FROM DUMMY
UNION ALL SELECT 60050, '', '', H1_PREFIX || RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('ENG', 4) || CHAR(32) || LPAD('EXECUTIONS', 10) || CHAR(32) || LPAD('TOTAL_CURS_S', 12) || CHAR(32) || 
    LPAD('AVG_CURS_MS', 11) || CHAR(32) || LPAD('TOTAL_EXEC_S', 12) || CHAR(32) || LPAD('AVG_EXEC_MS', 11) || CHAR(32) || LPAD('AVG_RECORDS', 11) || CHAR(32) ||
    LPAD('AVG_LOCK_MS', 11) || CHAR(32) || LPAD('AVG_PREP_MS', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) || CHAR(32) ||
    RPAD('APP_NAME', C.APP_NAME_LEN) || CHAR(32) || RPAD('APP_SOURCE', 50) FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE ) C
UNION ALL SELECT 60060, '', '', H2_PREFIX || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 4, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', C.APP_NAME_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE ) C
UNION ALL
SELECT
  60100,
  LPAD(999999999 - C.TOT_EXEC_S, 9),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.PORT, 6) ELSE '' END ||
  RPAD(C.STATEMENT_HASH, 32) || CHAR(32) || RPAD(C.ENG, 4) || CHAR(32) || LPAD(C.EXECUTIONS, 10) || CHAR(32) || LPAD(C.TOT_CURS_S, 12) || CHAR(32) || 
    LPAD(C.AVG_CURS_MS, 11) || CHAR(32) || LPAD(C.TOT_EXEC_S, 12) || CHAR(32) || LPAD(C.AVG_EXEC_MS, 11) || CHAR(32) || LPAD(C.AVG_RECORDS, 11) || CHAR(32) ||
    LPAD(C.AVG_LOCK_MS, 11) || CHAR(32) || LPAD(C.AVG_PREP_MS, 11) || CHAR(32) || LPAD(C.AVG_MEM_MB, 10) || CHAR(32) ||
    RPAD(C.APP_NAME, C.APP_NAME_LEN) || CHAR(32) || C.APP_SOURCE
FROM
  BASIS_INFO BI,
  SQL_CACHE C
UNION ALL SELECT 70000, '', '', '' FROM DUMMY
UNION ALL SELECT 70010, '', '', '*****************' FROM DUMMY
UNION ALL SELECT 70020, '', '', '* JOB EXECUTORS *' FROM DUMMY
UNION ALL SELECT 70030, '', '', '*****************' FROM DUMMY
UNION ALL SELECT 70040, '', '', '' FROM DUMMY
UNION ALL SELECT 70050, '', '', H1_PREFIX || LPAD('MAX_CONCURRENCY_CONFIG', 22) || CHAR(32) || LPAD('MAX_CONCURRENCY_CURRENT', 23) || CHAR(32) || LPAD('TOTAL_WORKERS', 13) || CHAR(32) || LPAD('QUEUED_WORKERS', 14) FROM BASIS_INFO
UNION ALL SELECT 70060, '', '', H2_PREFIX || RPAD('=', 22, '=') || CHAR(32) || RPAD('=', 23, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 14, '=') FROM BASIS_INFO
UNION ALL
SELECT
  70100,
  J.HOST,
  J.PORT,
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(J.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(J.PORT, 6) ELSE '' END ||
  LPAD(J.MAX_CONCURRENCY_CONFIG, 22) || CHAR(32) || LPAD(J.MAX_CONCURRENCY, 23) || CHAR(32) || LPAD(J.TOTAL_WORKERS, 13) || CHAR(32) || LPAD(J.QUEUED_WORKERS, 14)
FROM
  BASIS_INFO BI,
  JOBEXECUTORS J
UNION ALL SELECT TOP 1 80000, '', '', '' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80010, '', '', '****************************' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80020, '', '', '* TRANSACTIONAL LOCK WAITS *' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80030, '', '', '****************************' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80040, '', '', '' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT 80050, '', '', H1_PREFIX || LPAD('WAIT_S', 6) || CHAR(32) || LPAD('BLOCKED_CONN_ID', 15) || CHAR(32) || LPAD('BLOCKING_CONN_ID', 16) || CHAR(32) || 
  RPAD('SCHEMA_NAME', L.SCHEMA_NAME_LEN) || CHAR(32) || RPAD('TABLE_NAME', GREATEST(10, L.TABLE_NAME_LEN)) || CHAR(32) ||
  RPAD('LOCK_TYPE', 13) || CHAR(32) || RPAD('LOCK_MODE', 21) || CHAR(32) ||
  RPAD('BLOCKING_APP_NAME', GREATEST(17, L.BLOCKING_APP_NAME_LEN)) || CHAR(32) ||
  RPAD('BLOCKING_APP_USER', GREATEST(17, L.BLOCKING_APP_USER_LEN)) || CHAR(32) || 
  RPAD('BLOCKING_APP_SOURCE', GREATEST(19, L.BLOCKING_APP_SOURCE_LEN)) FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCK_WAITS ) L
UNION ALL SELECT 80060, '', '', H2_PREFIX || LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 16, '=') || CHAR(32) || 
  RPAD('=', L.SCHEMA_NAME_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(10, L.TABLE_NAME_LEN), '=') || CHAR(32) ||
  RPAD('=', 13, '=') || CHAR(32) || RPAD('=', 21, '=') || CHAR(32) ||
  RPAD('=', GREATEST(17, L.BLOCKING_APP_NAME_LEN), '=') || CHAR(32) ||
  RPAD('=', GREATEST(17, L.BLOCKING_APP_USER_LEN), '=') || CHAR(32) || 
  RPAD('=', GREATEST(19, L.BLOCKING_APP_SOURCE_LEN), '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCK_WAITS ) L
UNION ALL
SELECT
  80100,
  LPAD(99999999 - WAIT_S, 9),
  '',
  CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.HOST, BI.HOST_LEN + 1) ELSE '' END ||
  CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(L.PORT, 6) ELSE '' END ||
  LPAD(L.WAIT_S, 6) || CHAR(32) || LPAD(L.BLOCKED_CONN_ID, 15) || CHAR(32) || LPAD(L.BLOCKING_CONN_ID, 16) || CHAR(32) || 
  RPAD(L.SCHEMA_NAME, L.SCHEMA_NAME_LEN) || CHAR(32) || RPAD(L.TABLE_NAME, GREATEST(10, L.TABLE_NAME_LEN)) || CHAR(32) ||
  RPAD(L.LOCK_TYPE, 13) || CHAR(32) || RPAD(L.LOCK_MODE, 21) || CHAR(32) ||
  RPAD(L.BLOCKING_APP_NAME, GREATEST(17, L.BLOCKING_APP_NAME_LEN)) || CHAR(32) ||
  RPAD(L.BLOCKING_APP_USER, GREATEST(17, L.BLOCKING_APP_USER_LEN)) || CHAR(32) || 
  RPAD(L.BLOCKING_APP_SOURCE, GREATEST(19, L.BLOCKING_APP_SOURCE_LEN))
FROM
  BASIS_INFO BI,
  TRANSACTIONAL_LOCK_WAITS L
UNION ALL SELECT TOP 1 85000, '', '', '' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85010, '', '', '***********************' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85020, '', '', '* TRANSACTIONAL LOCKS *' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85030, '', '', '***********************' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85040, '', '', '' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85050, '', '', RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('LOCK_MODE', 16) || CHAR(32) || 
  LPAD('LOCK_COUNT', 10) || CHAR(32) || RPAD('ACQUIRED_TIME', 19)  FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 85060, '', '', RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 16, '=') || CHAR(32) || 
  LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 19, '=') FROM TRANSACTIONAL_LOCKS
UNION ALL
SELECT
  85100,
  LPAD(9999999999 - LOCK_COUNT, 10),
  '',
  RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(LOCK_MODE, 16) || CHAR(32) || 
  LPAD(LOCK_COUNT, 10) || CHAR(32) || RPAD(ACQUIRED_TIME, 19)
FROM
  TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 90000, '', '', ''                       FROM PARAMETERS
UNION ALL SELECT TOP 1 90010, '', '', '**********************' FROM PARAMETERS
UNION ALL SELECT TOP 1 90020, '', '', '* PARAMETER SETTINGS *' FROM PARAMETERS
UNION ALL SELECT TOP 1 90030, '', '', '**********************' FROM PARAMETERS
UNION ALL SELECT TOP 1 90040, '', '', ''                       FROM PARAMETERS
UNION ALL SELECT 90050, '', '', RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME' , KEY_LEN) || CHAR(32) || 'VALUE' 
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM PARAMETERS )
UNION ALL SELECT 90060, '', '', RPAD('=', FILE_LEN, '=') || CHAR(32) || RPAD('=', SECTION_LEN, '=') || CHAR(32) || RPAD('=' , KEY_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(5, VALUE_LEN), '=') 
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM PARAMETERS )
UNION ALL SELECT 90100 + ROW_NUMBER () OVER (ORDER BY FILE_NAME, SECTION, KEY), '', '', RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) || VALUE FROM PARAMETERS
UNION ALL SELECT TOP 1 500000, '', '', '' FROM CALLSTACKS
UNION ALL SELECT TOP 1 500010, '', '', '***************' FROM CALLSTACKS
UNION ALL SELECT TOP 1 500020, '', '', '* CALL STACKS *' FROM CALLSTACKS
UNION ALL SELECT TOP 1 500030, '', '', '***************' FROM CALLSTACKS
UNION ALL SELECT TOP 1 500040, '', '', '' FROM CALLSTACKS
UNION ALL SELECT 500050, '', '', H1_PREFIX || LPAD('CONN_ID', 10) || CHAR(32) || LPAD('THREAD_ID', 9) || CHAR(32) || LPAD('LVL', 3) || CHAR(32) || RPAD('MODULE_NAME', 80) FROM BASIS_INFO, ( SELECT TOP 1 * FROM CALLSTACKS )
UNION ALL SELECT 500060, '', '', H2_PREFIX || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 3, '=') || CHAR(32) || RPAD('=', 80, '=')  FROM BASIS_INFO, ( SELECT TOP 1 * FROM CALLSTACKS )
UNION ALL
SELECT
  500100,
  C.HOST,
  C.PORT || LPAD(C.CONN_ID, 10) || LPAD(C.THREAD_ID, 9) || LPAD(C.FRAME_LEVEL, 9),
  CASE 
    WHEN C.FRAME_LEVEL = 1 THEN
      CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.PORT, 6) ELSE '' END ||
      LPAD(C.CONN_ID, 10) || CHAR(32) || LPAD(C.THREAD_ID, 9) || CHAR(32)
    ELSE
      RPAD(CHAR(32), LENGTH(CASE WHEN BI.AGGREGATE_BY LIKE '%HOST%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.HOST, BI.HOST_LEN + 1) ELSE '' END ||
      CASE WHEN BI.AGGREGATE_BY LIKE '%PORT%' OR BI.AGGREGATE_BY = 'NONE' THEN RPAD(C.PORT, 6) ELSE '' END ||
      LPAD(C.CONN_ID, 10) || CHAR(32) || LPAD(C.THREAD_ID, 9) || CHAR(32) ) )
  END || 
  LPAD(C.FRAME_LEVEL, 3) || CHAR(32) || C.FRAME_NAME
FROM
  BASIS_INFO BI,
  CALLSTACKS C
UNION ALL SELECT 1000000, '', '', '' FROM DUMMY
UNION ALL SELECT 1000010, '', '', '****************************************' FROM DUMMY
UNION ALL SELECT 1000020, '', '', '* END OF SAP HANA CURRENT STATE REPORT *' FROM DUMMY
UNION ALL SELECT 1000030, '', '', '****************************************' FROM DUMMY
) D
ORDER BY
  D.LINE_NO,
  D.HOST,
  D.PORT,
  D.LINE
WITH HINT (IGNORE_PLAN_CACHE)