WITH 

/*

[NAME]

- HANA_Global_RemoteSystemReplicationSiteReport_ActiveActive_2.00.040+

[DESCRIPTION]

- Collection of information of a remote system replication site

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- May result in crashes on SAP HANA 2.00.042 - 2.00.043 (bug 229039)
- Only works if system replication is operated in Active/Active (read-enabled) mode, otherwise an error is thrown, e.g.:

  [259]: invalid table name:  Could not find table/view M_SERVICE_THREADS in schema _SYS_SR_SITE_hec48v136157

- _SYS_SR_SITE_hec48v136157 needs to be globally replaced in this analysis command with the 
  SDA schema name of the remote system replication site
- SDA schemas are available in system replication environments starting with SAP HANA 1.00.110
- _SYS_SR_SITE_<site>.M_OUT_OF_MEMORY_EVENTS available with SAP HANA >= 1.00.120
- Schema name follows naming convention _SYS_SR_SITE_<remote_site>
- M_SERVICE_THREAD_SAMPLES and BLOCKING_PHASE_DURATION available with SAP HANA >= 2.00.000
- M_HOST_AGENT_METRICS available in system replication schema starting with SAP HANA >= 2.00.040
- Hint DEV_NO_UNIVERSAL_ITAB required as a workaround for bug 260990 ("internal error: Column Name Length is invalid")
- Existing system replication schemas can be determined via:

  SELECT SCHEMA_NAME FROM SCHEMAS WHERE SCHEMA_NAME LIKE '_SYS_SR_SITE%'

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2019/07/17:  1.0 (initial version)
- 2019/07/27:  1.1 (dedicated 2.00.040+ version including host agent information)
- 2020/10/23:  1.2 (dedicated ActiveActive version including monitoring views only available on in Active/Active (read-enabled) scenarios)
- 2021/01/14:  1.3 (hint DEV_NO_UNIVERSAL_ITAB added)

[INVOLVED TABLES]

- M_ACTIVE_STATEMENTS
- M_DELTA_MERGE_STATISTICS
- M_HEAP_MEMORY
- M_HOST_AGENT_METRICS
- M_HOST_RESOURCE_UTILIZATION
- M_INIFILE_CONTENTS
- M_NUMA_NODES
- M_OUT_OF_MEMORY_EVENTS
- M_SAVEPOINTS
- M_SERVICE_MEMORY
- M_SERVICE_THREADS
- M_SERVICE_THREAD_SAMPLES
- M_SQL_PLAN_CACHE_OVERVIEW
- M_VOLUME_IO_TOTAL_STATISTICS_RESET

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

- TOP_N_THREADS

  Maximum number of most recent thread samples to be displayed

  50              --> Display 50 most recent thread samples
  -1              --> No restriction related to number of thread samples

- TOP_N_SAVEPOINTS

  Maximum number of most recent savepoints to be displayed

  20              --> Display 20 most recent savepoints
  -1              --> No restriction related to number of savepoints

- TOP_N_TABLE_OPTIMIZATIONS

  Maximum number of most recent table optimizations to be displayed

  20              --> Display 20 most recent table optimizations
  -1              --> No restriction related to number of table optimizations

- EXCLUDE_PHANTOM_THREADS

  Possibility to exclude idle threads that are shown as "active" due to SAP HANA bugs

  'X'             --> Do not show idle threads that are shown as active threads
  ' '             --> No restriction of displayed threads

- MAX_COL_LEN

  Maximum length of output columns

  40              --> Limit the size of potentially long output columns to 40 characters
  -1              --> No restriction related to output column length

- LINE_LENGTH

  Maximum displayed line size

  50              --> Lines are truncated at 50 characters
  -1              --> No line truncation

[OUTPUT PARAMETERS]

- LINE: Remote system replication site report (use monospaced output for optimal display)

[EXAMPLE OUTPUT]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LINE                                                                                                                                                                                                                                                           |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|**************************************************                                                                                                                                                                                                             |
|* SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *                                                                                                                                                                                                             |
|**************************************************                                                                                                                                                                                                             |
|                                                                                                                                                                                                                                                               |
|Generated with:            SQL: "HANA_Global_RemoteSystemReplicationSiteReport_ActiveActive" (SAP Note 1969700)                                                                                                                                                |
|Analysis time:             2020/10/24 16:04:14                                                                                                                                                                                                                 |
|Database name:             C11                                                                                                                                                                                                                                 |
|Revision level:            2.00.048.01.1596718894                                                                                                                                                                                                              |
|System replication schema: _SYS_SR_SITE_hec48v136157                                                                                                                                                                                                                   |
|Host:                      all                                                                                                                                                                                                                                 |
|Port:                      all                                                                                                                                                                                                                                 |
|                                                                                                                                                                                                                                                               |
|******************                                                                                                                                                                                                                                             |
|* HOST RESOURCES *                                                                                                                                                                                                                                             |
|******************                                                                                                                                                                                                                                             |
|                                                                                                                                                                                                                                                               |
|HOST        PHYS_MEM_GB PHYS_USED_GB ALLOC_LIM_GB INST_ALLOC_GB INST_PEAK_USED_GB INST_USED_GB INST_SHARED_GB OPEN_FILES ACTIVE_ASYNC_IO_COUNT                                                                                                                 |
|=========== =========== ============ ============ ============= ================= ============ ============== ========== =====================                                                                                                                 |
|saphana2020     6047.51      2787.76      5859.80       3162.25           1919.24      1633.57          21.05       3168                  8704                                                                                                                 |
|                                                                                                                                                                                                                                                               |
|**********************                                                                                                                                                                                                                                         |
|* GARBAGE COLLECTION *                                                                                                                                                                                                                                         |
|**********************                                                                                                                                                                                                                                         |
|                                                                                                                                                                                                                                                               |
|HOST         PORT GLOBAL_LOCK_START    VERSIONS DATA_VERSIONS METADATA_VERSIONS                                                                                                                                                                                |
|=========== ===== =================== ========= ============= =================                                                                                                                                                                                |
|saphana2020 30203 2020/10/24 16:04:15       666           664                 2                                                                                                                                                                                |
|saphana2020 30204                             0             0                 0                                                                                                                                                                                |
|saphana2020 30207                             0             0                 0                                                                                                                                                                                |
|                                                                                                                                                                                                                                                               |
|*******************                                                                                                                                                                                                                                            |
|* THREAD ACTIVITY *                                                                                                                                                                                                                                            |
|*******************                                                                                                                                                                                                                                            |
|                                                                                                                                                                                                                                                               |
|SAMPLE_TIME         HOST         PORT    CONN_ID THREAD_ID DUR_S CPU_S THREAD_TYPE                    STATE          LOCK_NAME                   STATEMENT_HASH                          THREAD_METHOD   APP_US APP_NAME         A THREAD_DETAIL               |
|=================== =========== ===== ========== ========= ===== ===== ============================== ============== =========================== ======================================= =============== ====== ================ = =========================== |
|2020/10/24 16:04:14 saphana2020 30203     300445     36042     0     0 Request                        Running                                    812b0f1c8915a6b89f83c33f82b737ca        core/stat       C11adm SAP_SDA_ABAP:C11                               |
|2020/10/24 16:04:14 saphana2020 30203     300445    170215     0     0 SqlExecutor                    Semaphore Wait TrexThreads::Thread::Thread 812b0f1c8915a6b89f83c33f82b737ca        ExecutePrepared C11adm SAP_SDA_ABAP:C11   SELECT "M_SERVICE_THREADS". |
|2020/10/24 16:04:14 saphana2020 30203     300445    218924     0     0 RemoteService                  Network Poll                               812b0f1c8915a6b89f83c33f82b737ca                        C11adm SAP_SDA_ABAP:C11                               |
|2020/10/24 16:04:14 saphana2020 30204     300445    108202     0     0 Request                        Running                                    812b0f1c8915a6b89f83c33f82b737ca        core/stat       C11adm SAP_SDA_ABAP:C11                               |
|2020/10/24 16:04:14 saphana2020 30207     300445    108330     0     0 Request                        Running                                    812b0f1c8915a6b89f83c33f82b737ca        core/stat       C11adm SAP_SDA_ABAP:C11                               |
|2020/10/24 16:04:03 saphana2020 30207         -1    108087 34957  1155 JobexWatchdog                  Running        X                           no SQL (JobexWatchdog)                  X               X      X                X X                           |
|2020/10/24 16:04:02 saphana2020 30203         -1    113154 34949 34939 NetworkChannelCompletionThread Mutex Wait     X                           no SQL (NetworkChannelCompletionThread) X               X      X                X X                           |
|2020/10/24 16:04:02 saphana2020 30203         -1    140130 34873 10285 ContinuousPageFlusher          Running        X                           no SQL (flushing)                       flushing        X      X                X X                           |
|2020/10/24 16:04:02 saphana2020 30203         -1    140164 34873   119 LogRecoveryQueue33             Running        X                           no SQL (LogRecoveryQueue33)             X               X      X                X X                           |
|2020/10/24 16:04:02 saphana2020 30203         -1    140355 34873 19064 LogRecovery                    Running        X                           no SQL (LogRecovery)                    X               X      X                X X                           |
|                                                                                                                                                                                                                                                               |
|**********************                                                                                                                                                                                                                                         |
|* SQL CACHE OVERVIEW *                                                                                                                                                                                                                                         |
|**********************                                                                                                                                                                                                                                         |
|                                                                                                                                                                                                                                                               |
|HOST         PORT CONF_GB USED_GB   PLANS LOOKUPS_PER_H HITS_PER_H EVICTS_PER_H                                                                                                                                                                                |
|=========== ===== ======= ======= ======= ============= ========== ============                                                                                                                                                                                |
|saphana2020 30203    8.00    0.00      74            37         36            0                                                                                                                                                                                |
|saphana2020 30204    2.00    0.00       0             0          0            0                                                                                                                                                                                |
|saphana2020 30207    2.00    0.00       1             0          0            0                                                                                                                                                                                |
|                                                                                                                                                                                                                                                               |
|*********************                                                                                                                                                                                                                                          |
|* ACTIVE STATEMENTS *                                                                                                                                                                                                                                          |
|*********************                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                               |
|HOST         PORT START_TIME          DURATION_S    CONN_ID STATUS     MEM_MB STATEMENT_HASH                   APP_USER APPLICATION_SOURCE_AND_STATEMENT_STRING                                                                                                |
|=========== ===== =================== ========== ========== ========= ======= ================================ ======== ================================================================================                                                       |
|saphana2020 30203 2020/10/24 16:04:14          0     300445 SUSPENDED       0 106fde45c4a12b86801c1cbd1cd85770          SELECT "T"."UPDATE_TRANSACTION_ID", "C"."CONNECTION_ID", "C"."VALUE", UPPER("C".                                                       |
|                                                                                                                        "KEY") FROM ("SYS"."M_TRANSACTIONS" "T" INNER JOIN "SYS"."M_SESSION_CONTEXT"                                                           |
|                                                                                                                        "C" ON ("T"."HOST" = "C"."HOST" AND "T"."PORT" = "C"."PORT") )                                                                         |
|saphana2020 30203 2020/10/24 16:04:14          0     300445 SUSPENDED       0 106fde45c4a12b86801c1cbd1cd85770          SELECT "T"."UPDATE_TRANSACTION_ID", "C"."CONNECTION_ID", "C"."VALUE", UPPER("C".                                                       |
|                                                                                                                        "KEY") FROM ("SYS"."M_TRANSACTIONS" "T" INNER JOIN "SYS"."M_SESSION_CONTEXT"                                                           |
|                                                                                                                        "C" ON ("T"."HOST" = "C"."HOST" AND "T"."PORT" = "C"."PORT") )                                                                         |
|saphana2020 30203 2020/10/24 16:04:15          0     300445 SUSPENDED       0 106fde45c4a12b86801c1cbd1cd85770          SELECT "T"."UPDATE_TRANSACTION_ID", "C"."CONNECTION_ID", "C"."VALUE", UPPER("C".                                                       |
|                                                                                                                        "KEY") FROM ("SYS"."M_TRANSACTIONS" "T" INNER JOIN "SYS"."M_SESSION_CONTEXT"                                                           |
|                                                                                                                        "C" ON ("T"."HOST" = "C"."HOST" AND "T"."PORT" = "C"."PORT") )                                                                         |
|                                                                                                                                                                                                                                                               |
|******************                                                                                                                                                                                                                                             |
|* MEMORY DETAILS *                                                                                                                                                                                                                                             |
|******************                                                                                                                                                                                                                                             |
|                                                                                                                                                                                                                                                               |
|HOST         PORT SERVICE       EFF_ALLOC_LIM_GB MEM_USED_GB HEAP_ALLOC_GB HEAP_USED_GB SHARED_ALLOC_GB FREEABLE_GB FRAGMENT_GB ADDR_USED_GB                                                                                                                   |
|=========== ===== ============= ================ =========== ============= ============ =============== =========== =========== ============                                                                                                                   |
|saphana2020 30201 nameserver             4235.48        9.22         63.78         7.10            0.00        0.07        0.54        72.00                                                                                                                   |
|saphana2020 30202 preprocessor           4226.99        0.85         56.52         0.40            0.00        0.00        0.22        72.00                                                                                                                   |
|saphana2020 30203 indexserver            5826.10     1599.97       2790.46      1597.85            0.00     2468.98        6.05      2976.00                                                                                                                   |
|saphana2020 30204 scriptserver           4229.04        2.90         56.61         0.97            0.00        0.00        0.38        64.00                                                                                                                   |
|saphana2020 30206 webdispatcher          4228.21        2.08         56.52         0.64            0.00        0.00        0.22        64.00                                                                                                                   |
|saphana2020 30207 xsengine               4231.17        5.03         58.60         2.94            0.00        0.00        0.42        64.00                                                                                                                   |
|saphana2020 30210 compileserver          4226.78        0.65         56.51         0.39            0.00        0.00        0.22        64.00                                                                                                                   |
|                                                                                                                                                                                                                                                               |
|HOST         PORT HEAP_ALLOCATOR                                                        MEM_USED_GB COUNT COMPONENT                                                                                                                                            |
|=========== ===== ===================================================================== =========== ===== ========================================                                                                                                             |
|saphana2020 30203 Pool/ColumnStore/Main/Dictionary/RoDict                                    858.29     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/ColumnStore/Main/Index/Single                                         123.74     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/ColumnStore/Main/Uncompressed                                         116.01     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/ColumnStore/Main/Index/PageableSingle                                  83.96     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/ColumnStore/Main/Rowid                                                 79.67     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/ColumnStore/Main/Compressed/Indirect                                   62.95     1 Column Store Tables                                                                                                                                  |
|saphana2020 30203 Pool/PersistenceManager/PersistentSpace/DefaultLPA/DataPage                 61.41     1 System                                                                                                                                               |
|                                                                                                                                                                                                                                                               |
|***************                                                                                                                                                                                                                                                |
|* CPU DETAILS *                                                                                                                                                                                                                                                |
|***************                                                                                                                                                                                                                                                |
|                                                                                                                                                                                                                                                               |
|HOST        NUMA_NODE USER_PCT SYSTEM_PCT WAITIO_PCT BUSY_PCT IDLE_PCT                                                                                                                                                                                         |
|=========== ========= ======== ========== ========== ======== ========                                                                                                                                                                                         |
|saphana2020         0     0.17       0.10       0.00     0.28    99.72                                                                                                                                                                                         |
|saphana2020         1     0.48       0.24       0.00     0.72    99.27                                                                                                                                                                                         |
|saphana2020         2     0.24       0.18       0.00     0.42    99.57                                                                                                                                                                                         |
|saphana2020         3     0.11       0.07       0.00     0.18    99.81                                                                                                                                                                                         |
|                                                                                                                                                                                                                                                               |
|HOST        LOADAVG_1MIN LOADAVG_5MIN LOADAVG_15MIN STEAL_PC CTX_SWITCHES_PER_S INTERRUPTS_PER_S                                                                                                                                                               |
|=========== ============ ============ ============= ======== ================== ================                                                                                                                                                               |
|saphana2020         0.65         0.92          1.09     0.00              86324            12944                                                                                                                                                               |
|                                                                                                                                                                                                                                                               |
|**************                                                                                                                                                                                                                                                 |
|* SAVEPOINTS *                                                                                                                                                                                                                                                 |
|**************                                                                                                                                                                                                                                                 |
|                                                                                                                                                                                                                                                               |
|START_TIME          HOST         PORT PURPOSE                        DURATION_S WAITFORLOCK_S CRITICAL_S                                                                                                                                                       |
|=================== =========== ===== ============================== ========== ============= ==========                                                                                                                                                       |
|2020-10-23 10:01:23 saphana2020 30207 SNAPSHOT_FOR_REPLICATION             0.03          0.00       0.00                                                                                                                                                       |
|2020-10-23 09:52:33 saphana2020 30203 SNAPSHOT_FOR_REPLICATION             0.68          0.00       0.54                                                                                                                                                       |
|2020-10-23 09:45:23 saphana2020 30207 SNAPSHOT_FOR_REPLICATION             0.09          0.00       0.00                                                                                                                                                       |
|2020-10-23 09:37:33 saphana2020 30203 SNAPSHOT_FOR_REPLICATION             0.71          0.00       0.54                                                                                                                                                       |
|2020-10-23 09:30:23 saphana2020 30207 SNAPSHOT_FOR_REPLICATION             0.01          0.00       0.00                                                                                                                                                       |
|                                                                                                                                                                                                                                                               |
|***********************                                                                                                                                                                                                                                        |
|* TABLE OPTIMIZATIONS *                                                                                                                                                                                                                                        |
|***********************                                                                                                                                                                                                                                        |
|                                                                                                                                                                                                                                                               |
|START_TIME          HOST         PORT TYPE    MOTIVATION SCHEMA_NAME TABLE_NAME       DURATION_S RETURN_CODE                                                                                                                                                   |
|=================== =========== ===== ======= ========== =========== ================ ========== ========================================                                                                                                                      |
|2020-10-20 15:15:15 saphana2020 30203 MERGE   AUTO       SAPC11      /1CADMC/00001106       7.77 0                                                                                                                                                             |
|2020-10-20 15:15:15 saphana2020 30203 MERGE   AUTO       SAPC11      /1CADMC/00001130       8.45 0                                                                                                                                                             |
|2020-10-20 15:15:15 saphana2020 30203 MERGE   AUTO       SAPC11      /1CADMC/00001129       8.44 0                                                                                                                                                             |
|2020-10-20 15:15:15 saphana2020 30203 MERGE   AUTO       SAPC11      /1CADMC/00001742       0.05 0                                                                                                                                                             |
|2020-10-20 15:15:15 saphana2020 30203 MERGE   AUTO       SAPC11      /1CADMC/00001119       0.05 0                                                                                                                                                             |
|                                                                                                                                                                                                                                                               |
|****************                                                                                                                                                                                                                                               |
|* DISK DETAILS *                                                                                                                                                                                                                                               |
|****************                                                                                                                                                                                                                                               |
|                                                                                                                                                                                                                                                               |
|HOST         PORT TYPE                  READS AVG_READ_MS AVG_READ_KB       WRITES AVG_WRT_MS AVG_WRT_KB TRIG_READ_PCT TRIG_WRT_PCT                                                                                                                            |
|=========== ===== ============== ============ =========== =========== ============ ========== ========== ============= ============                                                                                                                            |
|saphana2020 30203 CATALOG_BACKUP            0        0.00        0.00            0       0.00       0.00          0.00         0.00                                                                                                                            |
|saphana2020 30203 DATA               12689148        1.80      356.88     29760307       0.11     185.53          0.00         0.00                                                                                                                            |
|saphana2020 30203 DATA_BACKUP               0        0.00        0.00            0       0.00       0.00          0.00         0.00                                                                                                                            |
|saphana2020 30203 LOG                    1152       50.94    47486.29     38067435       0.15      11.67          0.00         0.01                                                                                                                            |
|saphana2020 30203 LOG_BACKUP                0        0.00        0.00            0       0.00       0.00          0.00         0.00                                                                                                                            |
|saphana2020 30204 DATA                      0        0.00        0.00         3780       0.20      19.41          0.00         0.00                                                                                                                            |
|saphana2020 30204 LOG                       0        0.00        0.00         1515       4.19      13.84          0.00         0.00                                                                                                                            |
|                                                                                                                                                                                                                                                               |
|HOST        DISK                 QUEUE_SIZE SERVICE_MS WAIT_MS IO_PER_S THROUGHPUT_KBPS                                                                                                                                                                        |
|=========== ==================== ========== ========== ======= ======== ===============                                                                                                                                                                        |
|saphana2020 hana_log-hanalogC11           0       0.15    0.15    82.11          626.33                                                                                                                                                                        |
|saphana2020 sdax                          0       0.09    0.09    20.53          161.75                                                                                                                                                                        |
|saphana2020 sdca                          0       0.06    0.06    20.53          168.95                                                                                                                                                                        |
|saphana2020 sddd                          0       0.08    0.08    20.51          145.89                                                                                                                                                                        |
|saphana2020 sdu                           0       0.12    0.12    20.51          147.62                                                                                                                                                                        |
|                                                                                                                                                                                                                                                               |
|**********************                                                                                                                                                                                                                                         |
|* PARAMETER SETTINGS *                                                                                                                                                                                                                                         |
|**********************                                                                                                                                                                                                                                         |
|                                                                                                                                                                                                                                                               |
|FILE_NAME  SECTION       PARAMETER_NAME                      VALUE                                                                                                                                                                                             |
|========== ============= =================================== =====                                                                                                                                                                                             |
|global.ini execution     default_statement_concurrency_limit 56                                                                                                                                                                                                |
|global.ini execution     max_concurrency                     0                                                                                                                                                                                                 |
|global.ini execution     max_concurrency_hint                0                                                                                                                                                                                                 |
|global.ini memorymanager statement_memory_limit              500                                                                                                                                                                                               |
|                                                                                                                                                                                                                                                               |
|*********************************************************                                                                                                                                                                                                      |
|* END OF SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *                                                                                                                                                                                                      |
|*********************************************************                                                                                                                                                                                                      |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/  

BASIS_INFO AS
( SELECT                         /* Modification section */
    '%' HOST,
    '%' PORT,
    20 TOP_N_THREADS,
    20 TOP_N_SAVEPOINTS,
    20 TOP_N_TABLE_OPTIMIZATIONS,
    'X' EXCLUDE_PHANTOM_THREADS,
    200 MAX_COL_LEN,
    -1 LINE_LENGTH
  FROM
    DUMMY
),
THREADS AS
( SELECT
    SAMPLE_TIME,
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
    MAP(MAX_COL_LEN, -1, HOST_LEN, LEAST(MAX_COL_LEN, HOST_LEN)) HOST_LEN,
    MAP(MAX_COL_LEN, -1, STATEMENT_HASH_LEN, LEAST(MAX_COL_LEN, STATEMENT_HASH_LEN)) STATEMENT_HASH_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_TYPE_LEN, LEAST(MAX_COL_LEN, THREAD_TYPE_LEN)) THREAD_TYPE_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_STATE_LEN, LEAST(MAX_COL_LEN, THREAD_STATE_LEN)) THREAD_STATE_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_METHOD_LEN, LEAST(MAX_COL_LEN, THREAD_METHOD_LEN)) THREAD_METHOD_LEN,
    MAP(MAX_COL_LEN, -1, THREAD_DETAIL_LEN, LEAST(MAX_COL_LEN, THREAD_DETAIL_LEN)) THREAD_DETAIL_LEN,
    MAP(MAX_COL_LEN, -1, LOCK_NAME_LEN, LEAST(MAX_COL_LEN, LOCK_NAME_LEN)) LOCK_NAME_LEN,
    MAP(MAX_COL_LEN, -1, APP_USER_LEN, LEAST(MAX_COL_LEN, APP_USER_LEN)) APP_USER_LEN,
    MAP(MAX_COL_LEN, -1, APP_NAME_LEN, LEAST(MAX_COL_LEN, APP_NAME_LEN)) APP_NAME_LEN,
    MAP(MAX_COL_LEN, -1, APP_SOURCE_LEN, LEAST(MAX_COL_LEN, APP_SOURCE_LEN)) APP_SOURCE_LEN
  FROM
  ( SELECT
      TO_VARCHAR(TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') SAMPLE_TIME,
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
      MAX_COL_LEN,
      MAX(LENGTH(HOST)) OVER () HOST_LEN,
      MAX(LENGTH(STATEMENT_HASH)) OVER () STATEMENT_HASH_LEN,
      GREATEST(11, MAX(LENGTH(THREAD_TYPE)) OVER ()) THREAD_TYPE_LEN,
      MAX(LENGTH(THREAD_STATE)) OVER () THREAD_STATE_LEN,
      MAX(LENGTH(THREAD_METHOD)) OVER () THREAD_METHOD_LEN,
      MAX(LENGTH(THREAD_DETAIL)) OVER () THREAD_DETAIL_LEN,
      MAX(LENGTH(LOCK_NAME)) OVER () LOCK_NAME_LEN,
      MAX(LENGTH(APP_USER)) OVER () APP_USER_LEN,
      MAX(LENGTH(APP_NAME)) OVER () APP_NAME_LEN,
      MAX(LENGTH(APP_SOURCE)) OVER () APP_SOURCE_LEN
    FROM
    ( SELECT
        DATA_SOURCE,
        ROW_NUMBER () OVER (ORDER BY T.TIMESTAMP DESC, T.HOST, T.PORT, T.CONNECTION_ID, T.THREAD_ID ) ROWNO,
        T.TIMESTAMP,
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
        BI.MAX_COL_LEN,
        BI.TOP_N_THREADS
      FROM
        BASIS_INFO BI,
        ( SELECT
            'CURRENT' DATA_SOURCE,
            CURRENT_TIMESTAMP TIMESTAMP,
            HOST,
            PORT,
            CONNECTION_ID,
            THREAD_ID,
            STATEMENT_HASH,
            THREAD_METHOD,
            THREAD_TYPE,
            THREAD_DETAIL,
            THREAD_STATE,
            LOCK_WAIT_NAME,
            LOCK_WAIT_NAME LOCK_NAME,
            USER_NAME,
            APPLICATION_NAME,
            APPLICATION_USER_NAME,
            APPLICATION_SOURCE,
            DURATION,
            IS_ACTIVE,
            CPU_TIME_SELF
          FROM
            "_SYS_SR_SITE_hec48v136157".M_SERVICE_THREADS
          UNION ALL
          SELECT
            'SAMPLE' DATA_SOURCE,
            TIMESTAMP,
            HOST,
            PORT,
            CONNECTION_ID,
            THREAD_ID,
            STATEMENT_HASH,
            THREAD_METHOD,
            THREAD_TYPE,
            THREAD_DETAIL,
            THREAD_STATE,
            LOCK_WAIT_NAME,
            LOCK_WAIT_NAME LOCK_NAME,
            USER_NAME,
            APPLICATION_NAME,
            APPLICATION_USER_NAME,
            APPLICATION_SOURCE,
            DURATION,
            IS_ACTIVE,
            CPU_TIME_SELF
          FROM
            "_SYS_SR_SITE_hec48v136157".M_SERVICE_THREAD_SAMPLES
          WHERE
            TIMESTAMP < CURRENT_TIMESTAMP
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
    WHERE
    ( DATA_SOURCE = 'CURRENT' OR TOP_N_THREADS = -1 or ROWNO <= TOP_N_THREADS )
  )
),
HEAP_ALLOCATORS AS
( SELECT
    H.HOST,
    H.PORT,
    H.CATEGORY HEAP_ALLOCATOR,
    TO_DECIMAL(SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024, 10, 2) MEM_USED_GB,
    COUNT(*) COUNT,
    MAX(H.COMPONENT) COMPONENT,
    MAX(LENGTH(H.HOST)) OVER () HOST_LEN,
    MAX(LENGTH(H.CATEGORY)) OVER () HEAP_ALLOCATOR_LEN
  FROM
    BASIS_INFO BI,
    "_SYS_SR_SITE_hec48v136157".M_HEAP_MEMORY H
  WHERE
    H.HOST LIKE BI.HOST AND
    TO_VARCHAR(H.PORT) LIKE BI.PORT
  GROUP BY
    H.HOST,
    H.PORT,
    H.CATEGORY
  HAVING
    SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024 >= 1
),
OOM_EVENTS AS
( SELECT
    O.TIME TIMESTAMP,
    O.HOST,
    O.PORT,
    O.STATEMENT_HASH,
    O.EVENT_REASON,
    TO_DECIMAL(O.MEMORY_USED_SIZE / 1024 / 1024 / 1024, 10, 2) USED_GB,
    TO_DECIMAL(O.MEMORY_REQUEST_SIZE / 1024 / 1024 / 1024, 10, 2) REQUESTED_GB,
    MAX(LENGTH(O.HOST)) OVER () HOST_LEN
  FROM
    BASIS_INFO BI,
    "_SYS_SR_SITE_hec48v136157".M_OUT_OF_MEMORY_EVENTS O
  WHERE
    O.HOST LIKE BI.HOST AND
    TO_VARCHAR(O.PORT) LIKE BI.PORT
),
SAVEPOINTS AS
( SELECT
    S.*,
    MAX(LENGTH(S.HOST)) OVER () HOST_LEN
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY S.START_TIME, S.HOST, S.PORT) ROWNO,
      S.START_TIME,
      S.HOST,
      S.PORT,
      S.PURPOSE,
      TO_DECIMAL(S.DURATION / 1000 / 1000, 10, 2) DURATION_S,
      TO_DECIMAL((S.BLOCKING_PHASE_DURATION - S.CRITICAL_PHASE_DURATION) / 1000 / 1000, 10, 2) WAITFORLOCK_S,
      TO_DECIMAL(S.CRITICAL_PHASE_DURATION / 1000 / 1000, 10, 2) CRITICAL_S,
      BI.TOP_N_SAVEPOINTS
    FROM
      BASIS_INFO BI,
      "_SYS_SR_SITE_hec48v136157".M_SAVEPOINTS S
    WHERE
      S.HOST LIKE BI.HOST AND
      TO_VARCHAR(S.PORT) LIKE BI.PORT
  ) S
  WHERE
    ( TOP_N_SAVEPOINTS = -1 OR ROWNO <= TOP_N_SAVEPOINTS )
),
TABLE_OPTIMIZATIONS AS
( SELECT
    O.*,
    MAX(LENGTH(O.HOST)) OVER () HOST_LEN,
    GREATEST(11, MAX(LENGTH(O.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(O.TABLE_NAME)) OVER ()) TABLE_LEN
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY O.START_TIME DESC, O.HOST, O.PORT, O.SCHEMA_NAME, O.TABLE_NAME) ROWNO,
      O.START_TIME,
      O.HOST,
      O.PORT,
      O.TYPE,
      O.MOTIVATION,
      O.SCHEMA_NAME,
      O.TABLE_NAME || MAP(O.PART_ID, 0, '', CHAR(32) || '(' || O.PART_ID || ')') TABLE_NAME,
      TO_DECIMAL(O.EXECUTION_TIME / 1000, 10, 2) DURATION_S,
      MAP(LAST_ERROR, '0', '0', LAST_ERROR || CHAR(32) || ERROR_DESCRIPTION) ERROR,
      BI.TOP_N_TABLE_OPTIMIZATIONS
    FROM
      BASIS_INFO BI,
      "_SYS_SR_SITE_hec48v136157".M_DELTA_MERGE_STATISTICS O
    WHERE
      O.HOST LIKE BI.HOST AND
      TO_VARCHAR(O.PORT) LIKE BI.PORT
  ) O
  WHERE
    ( TOP_N_TABLE_OPTIMIZATIONS = -1 OR ROWNO <= TOP_N_TABLE_OPTIMIZATIONS )
),
DISK_IO AS
( SELECT
    I.HOST,
    I.PORT,
    I.TYPE,
    I.TOTAL_READS + I.TOTAL_TRIGGER_ASYNC_READS READS,
    TO_DECIMAL(I.TOTAL_READ_SIZE / 1024 / 1024 / 1024, 10, 2) READ_GB,
    I.TOTAL_READ_TIME / 1000000 READ_S,
    I.TRIGGER_READ_RATIO,
    I.TOTAL_WRITES + I.TOTAL_TRIGGER_ASYNC_WRITES WRITES,
    TO_DECIMAL(I.TOTAL_WRITE_SIZE / 1024 / 1024 / 1024, 10, 2) WRITE_GB,
    I.TOTAL_WRITE_TIME / 1000000 WRITE_S,
    I.TRIGGER_WRITE_RATIO,
    MAX(LENGTH(I.HOST)) OVER () HOST_LEN
  FROM
    BASIS_INFO BI,
    "_SYS_SR_SITE_hec48v136157".M_VOLUME_IO_TOTAL_STATISTICS_RESET I
  WHERE
    I.HOST LIKE BI.HOST AND
    TO_VARCHAR(I.PORT) LIKE BI.PORT
),
DISKS AS
( SELECT
    D.*,
    MAX(LENGTH(D.HOST)) OVER () HOST_LEN
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
      "_SYS_SR_SITE_hec48v136157".M_HOST_AGENT_METRICS
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
    C.HOST,
    N.NUMA_NODE,
    TO_DECIMAL(AVG(C.USER_PCT), 10, 2) USER_PCT,
    TO_DECIMAL(AVG(C.SYSTEM_PCT), 10, 2) SYSTEM_PCT,
    TO_DECIMAL(AVG(C.WAITIO_PCT), 10, 2) WAITIO_PCT,
    TO_DECIMAL(AVG(C.BUSY_PCT), 10, 2) BUSY_PCT,
    TO_DECIMAL(AVG(C.IDLE_PCT), 10, 2) IDLE_PCT,
    MAX(LENGTH(C.HOST)) OVER () HOST_LEN
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
      "_SYS_SR_SITE_hec48v136157".M_HOST_AGENT_METRICS
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
          NUMA_NODE_ID NUMA_NODE,
          ',' || LOGICAL_CORE_IDS || ',' LOGICAL_CORE_IDS
        FROM
          "_SYS_SR_SITE_hec48v136157".M_NUMA_NODES
      ) N
    )
    WHERE
      LOGICAL_CORE_IDS != ''
  ) N ON
    C.CORE BETWEEN N.MIN_CORE AND N.MAX_CORE
  WHERE
    C.HOST LIKE BI.HOST
  GROUP BY
    C.HOST,
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
    MAX(LENGTH(HOST)) OVER () HOST_LEN
  FROM
  ( SELECT
      C.HOST,
      MAX(MAP(C.CAPTION, 'Load Average 1 Minute', TO_NUMBER(C.VALUE), 0)) LOADAVG_1MIN,
      MAX(MAP(C.CAPTION, 'Load Average 5 Minutes', TO_NUMBER(C.VALUE), 0)) LOADAVG_5MIN,
      MAX(MAP(C.CAPTION, 'Load Average 15 Minutes', TO_NUMBER(C.VALUE), 0)) LOADAVG_15MIN,
      MAX(MAP(C.CAPTION, 'Steal Time', TO_NUMBER(C.VALUE), 0)) STEAL_PCT,
      MAX(MAP(C.CAPTION, 'Context Switch Rate', TO_NUMBER(C.VALUE), 0)) CTX_SWITCHES_PER_S,
      MAX(MAP(C.CAPTION, 'Interrupt Rate', TO_NUMBER(C.VALUE), 0)) INTERRUPTS_PER_S
    FROM
      BASIS_INFO BI,
      "_SYS_SR_SITE_hec48v136157".M_HOST_AGENT_METRICS C
    WHERE
      C.HOST LIKE BI.HOST AND
      C.MEASURED_ELEMENT_TYPE = 'OperatingSystem'
    GROUP BY
      C.HOST
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
    MAX(LENGTH(IFNULL(APP_USER, ''))) OVER () APP_USER_LEN,
    MAX(LENGTH(HOST)) OVER () HOST_LEN
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
      TO_DECIMAL(A.USED_MEMORY_SIZE / 1024 / 1024, 10, 0) MEM_MB,
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
        "_SYS_SR_SITE_hec48v136157".M_ACTIVE_STATEMENTS A 
    ) A 
    WHERE
      A.HOST LIKE BI.HOST AND
      TO_VARCHAR(A.PORT) LIKE BI.PORT 
  )
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
    IFNULL(MAX(LENGTH(BLOCKING_APP_SOURCE)) OVER (), 0) BLOCKING_APP_SOURCE_LEN,
    MAX(LENGTH(HOST)) OVER () HOST_LEN
  FROM
  ( SELECT
      B.HOST,
      B.PORT,
      B.BLOCKED_CONNECTION_ID BLOCKED_CONN_ID,
      B.LOCK_OWNER_CONNECTION_ID BLOCKING_CONN_ID,
      TO_DECIMAL(GREATEST(0, SECONDS_BETWEEN(B.BLOCKED_TIME, CURRENT_TIMESTAMP)), 10, 0) WAIT_S,
      B.WAITING_SCHEMA_NAME SCHEMA_NAME,
      B.WAITING_OBJECT_NAME TABLE_NAME,
      B.LOCK_TYPE,
      B.LOCK_MODE,
      ( SELECT MIN(C.VALUE) FROM "_SYS_SR_SITE_hec48v136157".M_TRANSACTIONS T, "_SYS_SR_SITE_hec48v136157".M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) LIKE '%APPLICATIONUSER' ) BLOCKING_APP_USER,
      ( SELECT MAX(C.VALUE) FROM "_SYS_SR_SITE_hec48v136157".M_TRANSACTIONS T, "_SYS_SR_SITE_hec48v136157".M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) = 'APPLICATION' ) BLOCKING_APP_NAME,
      ( SELECT MAX(C.VALUE) FROM "_SYS_SR_SITE_hec48v136157".M_TRANSACTIONS T, "_SYS_SR_SITE_hec48v136157".M_SESSION_CONTEXT C WHERE T.UPDATE_TRANSACTION_ID = B.LOCK_OWNER_UPDATE_TRANSACTION_ID AND 
        C.HOST = T.HOST AND C.PORT = T.PORT AND C.CONNECTION_ID = B.LOCK_OWNER_CONNECTION_ID AND UPPER(C.KEY) = 'APPLICATIONSOURCE' ) BLOCKING_APP_SOURCE
    FROM
      BASIS_INFO BI,
      "_SYS_SR_SITE_hec48v136157".M_BLOCKED_TRANSACTIONS B
    WHERE
      B.HOST LIKE BI.HOST AND
      TO_VARCHAR(B.PORT) LIKE BI.PORT
  )
),
HOST_RESOURCE_UTILIZATION AS
( SELECT
    R.HOST,
    TO_DECIMAL((R.FREE_PHYSICAL_MEMORY + R.USED_PHYSICAL_MEMORY) / 1024 / 1024 / 1024, 10, 2) PHYS_MEM_GB,
    TO_DECIMAL(R.USED_PHYSICAL_MEMORY / 1024 / 1024 / 1024, 10, 2) PHYS_USED_GB,
    TO_DECIMAL(R.ALLOCATION_LIMIT / 1024 / 1024 / 1024, 10, 2) ALLOC_LIM_GB,    
    TO_DECIMAL(R.INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE / 1024 / 1024 / 1024, 10, 2) INST_ALLOC_GB,    
    TO_DECIMAL(R.INSTANCE_TOTAL_MEMORY_PEAK_USED_SIZE / 1024 / 1024 / 1024, 10, 2) INST_PEAK_USED_GB,    
    TO_DECIMAL(R.INSTANCE_TOTAL_MEMORY_USED_SIZE / 1024 / 1024 / 1024, 10, 2) INST_USED_GB,
    TO_DECIMAL(R.INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE / 1024 / 1024 / 1024, 10, 2) INST_SHARED_GB,
    TO_DECIMAL(MAP(TOTAL_CPU, 0, 0, TOTAL_CPU_USER_TIME / TOTAL_CPU * 100), 10, 2) CPU_USER_PCT,
    TO_DECIMAL(MAP(TOTAL_CPU, 0, 0, TOTAL_CPU_SYSTEM_TIME / TOTAL_CPU * 100), 10, 2) CPU_SYS_PCT,
    TO_DECIMAL(MAP(TOTAL_CPU, 0, 0, TOTAL_CPU_WIO_TIME / TOTAL_CPU * 100), 10, 2) CPU_WIO_PCT,
    TO_DECIMAL(MAP(TOTAL_CPU, 0, 0, TOTAL_CPU_IDLE_TIME / TOTAL_CPU * 100), 10, 2) CPU_IDLE_PCT,
    OPEN_FILE_COUNT OPEN_FILES,
    ACTIVE_ASYNC_IO_COUNT,
    MAX(LENGTH(R.HOST)) OVER () HOST_LEN
  FROM
    BASIS_INFO BI,
    ( SELECT
        R.*,
        TOTAL_CPU_USER_TIME + TOTAL_CPU_SYSTEM_TIME + TOTAL_CPU_WIO_TIME + TOTAL_CPU_IDLE_TIME TOTAL_CPU
      FROM
        "_SYS_SR_SITE_hec48v136157".M_HOST_RESOURCE_UTILIZATION R
    ) R
  WHERE
    R.HOST LIKE BI.HOST
),
PARAMETERS AS
( SELECT
    FILE_NAME,
    SECTION,
    KEY,
    IFNULL(DATABASE_VALUE, IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, DEFAULT_VALUE))) VALUE,
    MAX(LENGTH(FILE_NAME)) OVER() FILE_LEN,
    MAX(LENGTH(SECTION)) OVER() SECTION_LEN,
    MAX(LENGTH(KEY)) OVER () KEY_LEN,
    MAX(LENGTH(IFNULL(DATABASE_VALUE, IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, DEFAULT_VALUE))))) OVER () VALUE_LEN
  FROM
  ( SELECT
      FILE_NAME,
      SECTION,
      KEY,
      MAX(MAP(LAYER_NAME, 'DEFAULT',  VALUE)) DEFAULT_VALUE,
      MAX(MAP(LAYER_NAME, 'HOST',     VALUE)) HOST_VALUE,
      MAX(MAP(LAYER_NAME, 'SYSTEM',   VALUE)) SYSTEM_VALUE,
      MAX(MAP(LAYER_NAME, 'DATABASE', VALUE)) DATABASE_VALUE
    FROM
      "_SYS_SR_SITE_hec48v136157".M_INIFILE_CONTENTS
    GROUP BY
      FILE_NAME,
      SECTION,
      KEY
  )
  WHERE
    KEY IN
    ( 'default_statement_concurrency_limit',
      'esx_level',
      'hex_enabled',
      'max_concurrency',
      'max_concurrency_hint',
      'num_cores',
      'qo_small_enough_exact_estimation',
      'qo_small_enough_rough_estimation',
      'singleindex_consider_for_compressed_columns',
      'statement_memory_limit'
    )
),
GARBAGE_COLLECTION AS
( SELECT
    L.HOST,
    L.PORT,
    IFNULL(TO_VARCHAR(MIN(MAP(L.LAYER, 'GLOBAL', L.START_TIME)), 'YYYY/MM/DD HH24:MI:SS'), '') GLOBAL_LOCK_START,
    IFNULL(TO_VARCHAR(SUM(MAP(L.LAYER, 'DATA_VERSIONS', L.VALUE))), '') DATA_VERSIONS,
    IFNULL(TO_VARCHAR(SUM(MAP(L.LAYER, 'METADATA_VERSIONS', L.VALUE))), '') METADATA_VERSIONS,
    MAX(LENGTH(L.HOST)) OVER () HOST_LEN
  FROM
    BASIS_INFO BI,
  ( SELECT
      'GLOBAL' LAYER,
      T.HOST,
      T.PORT,
      MIN(T.START_TIME) START_TIME,
      -1 VALUE
    FROM
      "_SYS_SR_SITE_hec48v136157".M_MVCC_OVERVIEW M,
      "_SYS_SR_SITE_hec48v136157".M_TRANSACTIONS T
    WHERE
      M.MIN_MVCC_SNAPSHOT_TIMESTAMP = T.MIN_MVCC_SNAPSHOT_TIMESTAMP AND
      M.HOST = T.HOST AND
      M.PORT = T.PORT
    GROUP BY
      T.HOST,
      T.PORT
    UNION ALL
    SELECT
      'DATA_VERSIONS' LAYER,
      HOST,
      PORT,
      CURRENT_TIMESTAMP,
      SUM(DATA_VERSION_COUNT) VALUE
    FROM
      "_SYS_SR_SITE_hec48v136157".M_MVCC_OVERVIEW
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
      "_SYS_SR_SITE_hec48v136157".M_MVCC_OVERVIEW
    GROUP BY
      HOST,
      PORT
  ) L
  WHERE
    L.HOST LIKE BI.HOST AND
    TO_VARCHAR(L.PORT) LIKE BI.PORT
  GROUP BY
    L.HOST,
    L.PORT
),
SERVICE_MEMORY AS
( SELECT
    SM.HOST,
    SM.PORT,
    SM.SERVICE_NAME,
    TO_DECIMAL(EFFECTIVE_ALLOCATION_LIMIT / 1024 / 1024 / 1024, 10, 2) EFF_ALLOC_LIM_GB,
    TO_DECIMAL(SM.TOTAL_MEMORY_USED_SIZE / 1024 / 1024 / 1024, 10, 2) MEM_USED_GB,
    TO_DECIMAL(SM.HEAP_MEMORY_ALLOCATED_SIZE / 1024 / 1024 / 1024, 10, 2) HEAP_ALLOC_GB,
    TO_DECIMAL(SM.HEAP_MEMORY_USED_SIZE / 1024 / 1024 / 1024, 10, 2) HEAP_USED_GB,
    TO_DECIMAL(SM.SHARED_MEMORY_ALLOCATED_SIZE / 1024 / 1024 / 1024, 10, 2) SHARED_ALLOC_GB,
    TO_DECIMAL(SM.COMPACTORS_FREEABLE_SIZE / 1024 / 1024 / 1024, 10, 2) FREEABLE_GB,
    TO_DECIMAL(SM.FRAGMENTED_MEMORY_SIZE / 1024 / 1024 / 1024, 10, 2) FRAGMENT_GB,
    TO_DECIMAL(SM.VIRTUAL_ADDRESS_SPACE_USED_SIZE / 1024 / 1024 / 1024, 10, 2) ADDR_USED_GB,
    MAX(LENGTH(SM.HOST)) OVER () HOST_LEN,
    MAX(LENGTH(SM.SERVICE_NAME)) OVER () SERVICE_LEN
  FROM
    BASIS_INFO BI,
    "_SYS_SR_SITE_hec48v136157".M_SERVICE_MEMORY SM
  WHERE
    SM.HOST LIKE BI.HOST AND
    TO_VARCHAR(SM.PORT) LIKE BI.PORT
),
SQL_CACHE_OVERVIEW AS
( SELECT
    HOST,
    PORT,
    TO_DECIMAL(CONF_GB, 10, 2) CONF_GB,
    TO_DECIMAL(USED_GB, 10, 2) USED_GB,
    PLANS,
    TO_DECIMAL(MAP(UPTIME_H, 0, 0, LOOKUPS / UPTIME_H), 10, 0) LOOKUPS_PER_H,
    TO_DECIMAL(MAP(UPTIME_H, 0, 0, HITS / UPTIME_H), 10, 0) HITS_PER_H,
    TO_DECIMAL(MAP(UPTIME_H, 0, 0, EVICTIONS / UPTIME_H), 10, 0) EVICTS_PER_H,
    MAX(LENGTH(HOST)) OVER () HOST_LEN
  FROM
  ( SELECT
      SC.HOST,
      SC.PORT,
      SC.PLAN_CACHE_CAPACITY / 1024 / 1024 / 1024 CONF_GB,
      SC.CACHED_PLAN_SIZE / 1024 / 1024 / 1024 USED_GB,
      SC.CACHED_PLAN_COUNT PLANS,
      SC.PLAN_CACHE_LOOKUP_COUNT LOOKUPS,
      SC.PLAN_CACHE_HIT_COUNT HITS,
      SC.EVICTED_PLAN_COUNT EVICTIONS,
      SECONDS_BETWEEN(SS.START_TIME, CURRENT_TIMESTAMP) / 3600 UPTIME_H
    FROM
      BASIS_INFO BI,
      "_SYS_SR_SITE_hec48v136157".M_SQL_PLAN_CACHE_OVERVIEW SC,
      "_SYS_SR_SITE_hec48v136157".M_SERVICE_STATISTICS SS
    WHERE
      SC.HOST LIKE BI.HOST AND
      TO_VARCHAR(SC.PORT) LIKE BI.PORT AND
      SC.HOST = SS.HOST AND
      SC.PORT = SS.PORT
  )
)
SELECT MAP(BI.LINE_LENGTH, -1, LINE, SUBSTR(LINE, 1, LINE_LENGTH)) LINE FROM BASIS_INFO BI, ( 
SELECT       5 LINE_NO, '**************************************************' LINE FROM DUMMY
UNION ALL SELECT    10, '* SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *' FROM DUMMY
UNION ALL SELECT    20, '**************************************************' FROM DUMMY
UNION ALL SELECT    30, '' FROM DUMMY
UNION ALL SELECT    90, RPAD('Generated with:',            27) || 'SQL: "HANA_Global_RemoteSystemReplicationSiteReport_ActiveActive" (SAP Note 1969700)' FROM DUMMY
UNION ALL SELECT   100, RPAD('Analysis time:',             27) || TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS')                                 FROM DUMMY
UNION ALL SELECT   125, RPAD('System ID / database name:', 27) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME                              FROM M_DATABASE
UNION ALL SELECT   127, RPAD('Revision level:',            27) || VERSION                                                                                FROM M_DATABASE
UNION ALL SELECT   128, RPAD('System replication schema:', 27) || '_SYS_SR_SITE_hec48v136157'                                                   FROM DUMMY
UNION ALL SELECT   130, RPAD('Host:',                      27) || MAP(HOST, '%', 'all', HOST)                                                            FROM BASIS_INFO
UNION ALL SELECT   140, RPAD('Port:',                      27) || MAP(PORT, '%', 'all', PORT)                                                            FROM BASIS_INFO
UNION ALL SELECT  1000, '' FROM DUMMY
UNION ALL SELECT  1010, '******************' FROM DUMMY
UNION ALL SELECT  1020, '* HOST RESOURCES *' FROM DUMMY
UNION ALL SELECT  1030, '******************' FROM DUMMY
UNION ALL SELECT  1040, '' FROM DUMMY
UNION ALL SELECT TOP 1 1050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PHYS_MEM_GB', 11) || CHAR(32) || LPAD('PHYS_USED_GB', 12) || CHAR(32) ||
  LPAD('ALLOC_LIM_GB', 12) || CHAR(32) || LPAD('INST_ALLOC_GB', 13) || CHAR(32) || LPAD('INST_PEAK_USED_GB', 17) || CHAR(32) ||
  LPAD('INST_USED_GB', 12) || CHAR(32) || LPAD('INST_SHARED_GB', 14) || CHAR(32) || LPAD('OPEN_FILES', 10) || CHAR(32) ||
  LPAD('ACTIVE_ASYNC_IO_COUNT', 21) FROM HOST_RESOURCE_UTILIZATION
UNION ALL SELECT TOP 1 1060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) ||
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) ||
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
  LPAD('=', 21, '=') FROM HOST_RESOURCE_UTILIZATION
UNION ALL SELECT  1100 + ROW_NUMBER () OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PHYS_MEM_GB, 11) || CHAR(32) || LPAD(PHYS_USED_GB, 12) || CHAR(32) ||
  LPAD(ALLOC_LIM_GB, 12) || CHAR(32) || LPAD(INST_ALLOC_GB, 13) || CHAR(32) || LPAD(INST_PEAK_USED_GB, 17) || CHAR(32) ||
  LPAD(INST_USED_GB, 12) || CHAR(32) || LPAD(INST_SHARED_GB, 14) || CHAR(32) || LPAD(OPEN_FILES, 10) || CHAR(32) ||
  LPAD(ACTIVE_ASYNC_IO_COUNT, 21) FROM HOST_RESOURCE_UTILIZATION
UNION ALL SELECT  2000, '' FROM DUMMY
UNION ALL SELECT  2010, '**********************' FROM DUMMY
UNION ALL SELECT  2020, '* GARBAGE COLLECTION *' FROM DUMMY
UNION ALL SELECT  2030, '**********************' FROM DUMMY
UNION ALL SELECT  2040, '' FROM DUMMY
UNION ALL SELECT TOP 1 2050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || 
  RPAD('GLOBAL_LOCK_START', 19) || CHAR(32) || LPAD('VERSIONS', 9) || CHAR(32) || LPAD('DATA_VERSIONS', 13) || CHAR(32) || 
  LPAD('METADATA_VERSIONS', 17) FROM GARBAGE_COLLECTION
UNION ALL SELECT TOP 1 2060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || 
  LPAD('=', 17, '=') FROM GARBAGE_COLLECTION
UNION ALL
SELECT
  2100 + ROW_NUMBER () OVER (ORDER BY HOST, PORT),
  RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || 
  RPAD(GLOBAL_LOCK_START, 19) || CHAR(32) || LPAD(DATA_VERSIONS + METADATA_VERSIONS, 9) || CHAR(32) || LPAD(DATA_VERSIONS, 13) || CHAR(32) || 
  LPAD(METADATA_VERSIONS, 17)
FROM
  GARBAGE_COLLECTION
UNION ALL SELECT  8000, '' FROM DUMMY
UNION ALL SELECT  8010, '*******************' FROM DUMMY
UNION ALL SELECT  8020, '* THREAD ACTIVITY *' FROM DUMMY
UNION ALL SELECT  8030, '*******************' FROM DUMMY
UNION ALL SELECT  8040, '' FROM DUMMY
UNION ALL SELECT  8050, RPAD('SAMPLE_TIME', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) ||
  LPAD('CONN_ID', 10) || CHAR(32) || LPAD('THREAD_ID', 9) || CHAR(32) || LPAD('DUR_S', 5) || CHAR(32) || LPAD('CPU_S', 5) || CHAR(32) ||
  RPAD('THREAD_TYPE', THREAD_TYPE_LEN) || CHAR(32) || RPAD('STATE', THREAD_STATE_LEN ) || CHAR(32) || RPAD('LOCK_NAME', LOCK_NAME_LEN) || CHAR(32) || RPAD('STATEMENT_HASH', STATEMENT_HASH_LEN) || CHAR(32) ||
  RPAD('THREAD_METHOD', THREAD_METHOD_LEN) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || RPAD('APP_NAME', APP_NAME_LEN) || CHAR(32) || 
  RPAD('APP_SOURCE', APP_SOURCE_LEN) || CHAR(32) || RPAD('THREAD_DETAIL', THREAD_DETAIL_LEN)
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM THREADS )
UNION ALL SELECT  8060, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', THREAD_TYPE_LEN, '=') || CHAR(32) || RPAD('=', THREAD_STATE_LEN, '=') || CHAR(32) || RPAD('=', LOCK_NAME_LEN, '=') || CHAR(32) || RPAD('=', STATEMENT_HASH_LEN, '=') || CHAR(32) ||
  RPAD('=', THREAD_METHOD_LEN, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_NAME_LEN, '=') || CHAR(32) || 
  RPAD('=', APP_SOURCE_LEN, '=') || CHAR(32) || RPAD('=', THREAD_DETAIL_LEN, '=')
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM THREADS )
UNION ALL
SELECT
  8070 + ROW_NUMBER() OVER (ORDER BY SAMPLE_TIME DESC, HOST, PORT, CONN_ID, THREAD_ID),
  RPAD(SAMPLE_TIME, 19) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) ||
  LPAD(CONN_ID, 10) || CHAR(32) || LPAD(THREAD_ID, 9) || CHAR(32) || LPAD(DUR_S, 5) || CHAR(32) || LPAD(CPU_S, 5) || CHAR(32) ||
  RPAD(THREAD_TYPE, THREAD_TYPE_LEN) || CHAR(32) ||
  RPAD(THREAD_STATE, THREAD_STATE_LEN) || CHAR(32) ||
  RPAD(LOCK_NAME, LOCK_NAME_LEN) || CHAR(32) ||
  RPAD(STATEMENT_HASH, STATEMENT_HASH_LEN) || CHAR(32) ||
  RPAD(THREAD_METHOD, THREAD_METHOD_LEN) || CHAR(32) || 
  RPAD(APP_USER, APP_USER_LEN) || CHAR(32) ||
  RPAD(APP_NAME, APP_NAME_LEN) || CHAR(32) ||
  RPAD(APP_SOURCE, APP_SOURCE_LEN) || CHAR(32) ||
  RPAD(THREAD_DETAIL, THREAD_DETAIL_LEN)
FROM
  THREADS
UNION ALL SELECT TOP 1 9500, '' FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9510, '**********************' FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9520, '* SQL CACHE OVERVIEW *' FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9530, '**********************' FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9540, '' FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9550, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || LPAD('CONF_GB', 7) || CHAR(32) ||
  LPAD('USED_GB', 7) || CHAR(32) || LPAD('PLANS', 7) || CHAR(32) || LPAD('LOOKUPS_PER_H', 13) || CHAR(32) ||
  LPAD('HITS_PER_H', 10) || CHAR(32) || LPAD('EVICTS_PER_H', 12) FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 9560, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) ||
  LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT 9600 + ROW_NUMBER () OVER (ORDER BY HOST, PORT), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || LPAD(CONF_GB, 7) || CHAR(32) ||
  LPAD(USED_GB, 7) || CHAR(32) || LPAD(PLANS, 7) || CHAR(32) || LPAD(LOOKUPS_PER_H, 13) || CHAR(32) ||
  LPAD(HITS_PER_H, 10) || CHAR(32) || LPAD(EVICTS_PER_H, 12) FROM SQL_CACHE_OVERVIEW
UNION ALL SELECT TOP 1 10000, '' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 10010, '*********************' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 10020, '* ACTIVE STATEMENTS *' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 10030, '*********************' FROM ACTIVE_STATEMENTS
UNION ALL SELECT TOP 1 10040, '' FROM ACTIVE_STATEMENTS
UNION ALL SELECT 10050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || RPAD('START_TIME', 19) || CHAR(32) || LPAD('DURATION_S', 10) || CHAR(32) || LPAD('CONN_ID', 10) || CHAR(32) || RPAD('STATUS', 9) || CHAR(32) ||
  LPAD('MEM_MB', 7) || CHAR(32) || RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('APP_USER', GREATEST(8, A.APP_USER_LEN)) || CHAR(32) || RPAD('APPLICATION_SOURCE_AND_STATEMENT_STRING', 80) FROM BASIS_INFO, ( SELECT TOP 1 * FROM ACTIVE_STATEMENTS ) A
UNION ALL SELECT 10060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) ||
  LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', GREATEST(8, A.APP_USER_LEN), '=') || CHAR(32) || RPAD('=', 80, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM ACTIVE_STATEMENTS ) A
UNION ALL
SELECT
  10100 + A.TOTAL_LINE_NO,
  CASE WHEN A.LINE_NO = 1 THEN
    RPAD(A.HOST, HOST_LEN) || CHAR(32) || LPAD(A.PORT, 5) || CHAR(32) || 
    RPAD(IFNULL(A.START_TIME, ''), 19) || CHAR(32) || LPAD(IFNULL(A.DURATION_S, 0), 10) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(A.CONNECTION_ID), ''), 10) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_STATUS, ''), 9) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(A.MEM_MB), ''), 7) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_HASH, ''), 32) || CHAR(32) || RPAD(IFNULL(A.APP_USER, ''), GREATEST(8, IFNULL(A.APP_USER_LEN, 0))) || CHAR(32) 
  ELSE
    LPAD('', LENGTH(RPAD(A.HOST, HOST_LEN) || CHAR(32) || LPAD(A.PORT, 5) || CHAR(32) || 
    RPAD(IFNULL(A.START_TIME, ''), 19) || CHAR(32) || LPAD(IFNULL(A.DURATION_S, 0), 10) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(A.CONNECTION_ID), ''), 10) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_STATUS, ''), 9) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(A.MEM_MB), ''), 7) || CHAR(32) || RPAD(IFNULL(A.STATEMENT_HASH, ''), 32) || CHAR(32) || RPAD(IFNULL(A.APP_USER, ''), GREATEST(8, IFNULL(A.APP_USER_LEN, 0))) || CHAR(32)))
  END ||
  SUBSTR(IFNULL(A.STATEMENT_STRING, ''), POS_1 + 1, POS_2 - POS_1)
FROM
  BASIS_INFO BI,
  ( SELECT
      A.*,
      ROW_NUMBER () OVER (ORDER BY LPAD(999999999 - A.DURATION_S, 10) || A.CONNECTION_ID || A.STATEMENT_ID DESC, A.LINE_NO) TOTAL_LINE_NO,
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
UNION ALL SELECT 20000, '' FROM DUMMY
UNION ALL SELECT 20010, '******************' FROM DUMMY
UNION ALL SELECT 20020, '* MEMORY DETAILS *' FROM DUMMY
UNION ALL SELECT 20030, '******************' FROM DUMMY
UNION ALL SELECT 20040, '' FROM DUMMY
UNION ALL SELECT TOP 1 20100, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || RPAD('SERVICE', SERVICE_LEN) || CHAR(32) ||
  LPAD('EFF_ALLOC_LIM_GB', 16) || CHAR(32) || LPAD('MEM_USED_GB', 11) || CHAR(32) || LPAD('HEAP_ALLOC_GB', 13) || CHAR(32) ||
  LPAD('HEAP_USED_GB', 12) || CHAR(32) || LPAD('SHARED_ALLOC_GB', 15) || CHAR(32) || LPAD('FREEABLE_GB', 11) || CHAR(32) ||
  LPAD('FRAGMENT_GB', 11) || CHAR(32) || LPAD('ADDR_USED_GB', 12) FROM SERVICE_MEMORY
UNION ALL SELECT TOP 1 20110, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', SERVICE_LEN, '=') || CHAR(32) ||
  LPAD('=', 16, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) ||
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
  LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') FROM SERVICE_MEMORY
UNION ALL SELECT 20120 + ROW_NUMBER () OVER (ORDER BY HOST, PORT), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || RPAD(SERVICE_NAME, SERVICE_LEN) || CHAR(32) ||
  LPAD(EFF_ALLOC_LIM_GB, 16) || CHAR(32) || LPAD(MEM_USED_GB, 11) || CHAR(32) || LPAD(HEAP_ALLOC_GB, 13) || CHAR(32) ||
  LPAD(HEAP_USED_GB, 12) || CHAR(32) || LPAD(SHARED_ALLOC_GB, 15) || CHAR(32) || LPAD(FREEABLE_GB, 11) || CHAR(32) ||
  LPAD(FRAGMENT_GB, 11) || CHAR(32) || LPAD(ADDR_USED_GB, 12) FROM SERVICE_MEMORY
UNION ALL SELECT 20500, '' FROM DUMMY
UNION ALL SELECT 20550, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || RPAD('HEAP_ALLOCATOR', H.HEAP_ALLOCATOR_LEN) || CHAR(32) ||
  LPAD('MEM_USED_GB', 11) || CHAR(32) || LPAD('COUNT', 5) || CHAR(32) ||
  RPAD('COMPONENT', 40) FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL SELECT 20560, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  RPAD('=', H.HEAP_ALLOCATOR_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', 40, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL
SELECT
  20600 + ROW_NUMBER () OVER (ORDER BY H.HOST, H.PORT, H.MEM_USED_GB DESC),
  RPAD(H.HOST, HOST_LEN) || CHAR(32) || LPAD(H.PORT, 5) || CHAR(32) ||
  RPAD(H.HEAP_ALLOCATOR, H.HEAP_ALLOCATOR_LEN) || CHAR(32) || LPAD(H.MEM_USED_GB, 11) || CHAR(32) || LPAD(H.COUNT, 5) || CHAR(32) ||
  H.COMPONENT
FROM
  BASIS_INFO BI,
  HEAP_ALLOCATORS H
UNION ALL SELECT TOP 1 20800, '' FROM OOM_EVENTS
UNION ALL SELECT 20850, RPAD('TIMESTAMP', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) ||
  RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('EVENT_REASON', 32) || CHAR(32) || LPAD('USED_GB', 10) || CHAR(32) || LPAD('REQUESTED_GB', 12)
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM OOM_EVENTS ) O
UNION ALL SELECT 20860, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=')
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM OOM_EVENTS ) O
UNION ALL
SELECT
  20900 + ROW_NUMBER () OVER (ORDER BY O.TIMESTAMP DESC, O.HOST, O.PORT) / 10,
  RPAD(O.TIMESTAMP, 19) || CHAR(32) || RPAD(O.HOST, O.HOST_LEN) || CHAR(32) || LPAD(O.PORT, 5) || CHAR(32) ||
  RPAD(O.STATEMENT_HASH, 32) || CHAR(32) || RPAD(O.EVENT_REASON, 32) || CHAR(32) || LPAD(O.USED_GB, 10) || CHAR(32) || LPAD(O.REQUESTED_GB, 12)
FROM
  OOM_EVENTS O
UNION ALL SELECT 21000, '' FROM DUMMY
UNION ALL SELECT 21010, '***************' FROM DUMMY
UNION ALL SELECT 21020, '* CPU DETAILS *' FROM DUMMY
UNION ALL SELECT 21030, '***************' FROM DUMMY
UNION ALL SELECT 21040, '' FROM DUMMY
UNION ALL SELECT 21050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('NUMA_NODE', 9) || CHAR(32) || LPAD('USER_PCT', 8) || CHAR(32) || LPAD('SYSTEM_PCT', 10) || CHAR(32) ||
    LPAD('WAITIO_PCT', 10) || CHAR(32) || LPAD('BUSY_PCT', 8) || CHAR(32) || LPAD('IDLE_PCT', 8) FROM BASIS_INFO, ( SELECT TOP 1 * FROM CPUS )
UNION ALL SELECT 21060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 8, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM CPUS )
UNION ALL
SELECT
  21100 + ROW_NUMBER() OVER (ORDER BY HOST, NUMA_NODE),
  RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(NUMA_NODE, 9) || CHAR(32) || LPAD(USER_PCT, 8) || CHAR(32) || LPAD(SYSTEM_PCT, 10) || CHAR(32) ||
    LPAD(WAITIO_PCT, 10) || CHAR(32) || LPAD(BUSY_PCT, 8) || CHAR(32) || LPAD(IDLE_PCT, 8)
FROM
  CPUS
UNION ALL SELECT 21200, '' FROM DUMMY
UNION ALL SELECT 21250, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('LOADAVG_1MIN', 12) || CHAR(32) || LPAD('LOADAVG_5MIN', 12) || CHAR(32) || LPAD('LOADAVG_15MIN', 13) || CHAR(32) ||
    LPAD('STEAL_PCT', 8) || CHAR(32) || LPAD('CTX_SWITCHES_PER_S', 18) || CHAR(32) || LPAD('INTERRUPTS_PER_S', 16)
 FROM BASIS_INFO, ( SELECT TOP 1 * FROM CPUS_2 )
UNION ALL SELECT 21260, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 18, '=') || CHAR(32) || LPAD('=', 16, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM CPUS_2 )
UNION ALL
SELECT
  21300,
  RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(LOADAVG_1MIN, 12) || CHAR(32) || LPAD(LOADAVG_5MIN, 12) || CHAR(32) || LPAD(LOADAVG_15MIN, 13) || CHAR(32) ||
    LPAD(STEAL_PCT, 8) || CHAR(32) || LPAD(CTX_SWITCHES_PER_S, 18) || CHAR(32) || LPAD(INTERRUPTS_PER_S, 16)
FROM
  CPUS_2
UNION ALL SELECT 30000, '' FROM DUMMY
UNION ALL SELECT 30010, '**************' FROM DUMMY
UNION ALL SELECT 30020, '* SAVEPOINTS *' FROM DUMMY
UNION ALL SELECT 30030, '**************' FROM DUMMY
UNION ALL SELECT 30040, '' FROM DUMMY
UNION ALL SELECT 30050, RPAD('START_TIME', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || 
  RPAD('PURPOSE', 30) || CHAR(32) || LPAD('DURATION_S', 10) || CHAR(32) || LPAD('WAITFORLOCK_S', 13) || CHAR(32) || LPAD('CRITICAL_S', 10)
  FROM BASIS_INFO, (SELECT TOP 1 * FROM SAVEPOINTS ) S
UNION ALL SELECT 30060, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', 30, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 10, '=')
  FROM BASIS_INFO, (SELECT TOP 1 * FROM SAVEPOINTS ) S
UNION ALL
SELECT
  30100 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC, HOST, PORT),
  RPAD(START_TIME, 19) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || 
  RPAD(PURPOSE, 30) || CHAR(32) || LPAD(DURATION_S, 10) || CHAR(32) || LPAD(WAITFORLOCK_S, 13) || CHAR(32) || LPAD(CRITICAL_S, 10)
  FROM SAVEPOINTS
UNION ALL SELECT 40000, '' FROM DUMMY
UNION ALL SELECT 40010, '***********************' FROM DUMMY
UNION ALL SELECT 40020, '* TABLE OPTIMIZATIONS *' FROM DUMMY
UNION ALL SELECT 40030, '***********************' FROM DUMMY
UNION ALL SELECT 40040, '' FROM DUMMY
UNION ALL SELECT 40050, RPAD('START_TIME', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || 
  RPAD('TYPE', 7) || CHAR(32) || RPAD('MOTIVATION', 10) || CHAR(32) || RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) ||
  LPAD('DURATION_S', 10) || CHAR(32) || 'RETURN_CODE'
  FROM BASIS_INFO, (SELECT TOP 1 * FROM TABLE_OPTIMIZATIONS ) O
UNION ALL SELECT 40060, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', 7, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) ||
  LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 40, '=')
  FROM BASIS_INFO, (SELECT TOP 1 * FROM TABLE_OPTIMIZATIONS ) S
UNION ALL
SELECT
  40100 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC, HOST, PORT),
  RPAD(START_TIME, 19) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || 
  RPAD(TYPE, 7) || CHAR(32) || RPAD(MOTIVATION, 10) || CHAR(32) || RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) ||
  LPAD(DURATION_S, 10) || CHAR(32) || ERROR
  FROM TABLE_OPTIMIZATIONS
UNION ALL SELECT 50000, '' FROM DUMMY
UNION ALL SELECT 50010, '****************' FROM DUMMY
UNION ALL SELECT 50020, '* DISK DETAILS *' FROM DUMMY
UNION ALL SELECT 50030, '****************' FROM DUMMY
UNION ALL SELECT 50040, '' FROM DUMMY
UNION ALL SELECT 50050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || RPAD('TYPE', 14) || CHAR(32) || 
  LPAD('READS', 12) || CHAR(32) || LPAD('AVG_READ_MS', 11) || CHAR(32) || LPAD('AVG_READ_KB', 11) || CHAR(32) ||
  LPAD('WRITES', 12) || CHAR(32) || LPAD('AVG_WRT_MS', 10) || CHAR(32) || LPAD('AVG_WRT_KB', 10) || CHAR(32) ||
  LPAD('TRIG_READ_PCT', 13) || CHAR(32) || LPAD('TRIG_WRT_PCT', 12)
  FROM BASIS_INFO, (SELECT TOP 1 * FROM DISK_IO ) I
UNION ALL SELECT 50060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || 
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
  LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
  LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 12, '=')
  FROM BASIS_INFO, (SELECT TOP 1 * FROM DISK_IO ) I
UNION ALL
SELECT
  50100 + ROW_NUMBER() OVER (ORDER BY HOST, PORT, TYPE),
  RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(PORT, 5) || CHAR(32) || RPAD(TYPE, 14) || CHAR(32) || 
  LPAD(READS, 12) || CHAR(32) || LPAD(TO_DECIMAL(MAP(READS, 0, 0, READ_S / READS * 1000), 10, 2) , 11) || CHAR(32) || LPAD(TO_DECIMAL(MAP(READS, 0, 0, READ_GB / READS * 1024 * 1024), 10, 2), 11) || CHAR(32) ||
  LPAD(WRITES, 12) || CHAR(32) || LPAD(TO_DECIMAL(MAP(WRITES, 0, 0, WRITE_S / WRITES * 1000), 10, 2) , 10) || CHAR(32) || LPAD(TO_DECIMAL(MAP(WRITES, 0, 0, WRITE_GB / WRITES * 1024 * 1024), 10, 2), 10) || CHAR(32) ||
  LPAD(TO_DECIMAL(TRIGGER_READ_RATIO, 10, 2), 13) || CHAR(32) || LPAD(TO_DECIMAL(TRIGGER_WRITE_RATIO, 10, 2), 12)
  FROM DISK_IO
UNION ALL SELECT 51040, '' FROM DUMMY
UNION ALL SELECT 51050, RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('DISK', 20) || CHAR(32) || LPAD('QUEUE_SIZE', 10) || CHAR(32) || LPAD('SERVICE_MS', 10) || CHAR(32) || LPAD('WAIT_MS', 7) || CHAR(32) ||
    LPAD('IO_PER_S', 8) || CHAR(32) || LPAD('THROUGHPUT_KBPS', 15) FROM BASIS_INFO, (SELECT TOP 1 * FROM DISKS ) I
UNION ALL SELECT 51060, RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 20, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 15, '=') FROM BASIS_INFO, (SELECT TOP 1 * FROM DISKS ) I
UNION ALL
SELECT
  51100 + ROW_NUMBER() OVER (ORDER BY HOST, DISK),
  RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(DISK, 20) || CHAR(32) || LPAD(QUEUE, 10) || CHAR(32) || LPAD(SRV_MS, 10) || CHAR(32) || LPAD(WAIT_MS, 7) || CHAR(32) ||
    LPAD(IO_PER_S, 8) || CHAR(32) || LPAD(TP_KBPS, 15)
FROM
  DISKS
UNION ALL SELECT TOP 1 80000, '' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80010, '****************************' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80020, '* TRANSACTIONAL LOCK WAITS *' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80030, '****************************' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT TOP 1 80040, '' FROM TRANSACTIONAL_LOCK_WAITS
UNION ALL SELECT 80050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || LPAD('WAIT_S', 6) || CHAR(32) || LPAD('BLOCKED_CONN_ID', 15) || CHAR(32) || LPAD('BLOCKING_CONN_ID', 16) || CHAR(32) || 
  RPAD('SCHEMA_NAME', L.SCHEMA_NAME_LEN) || CHAR(32) || RPAD('TABLE_NAME', GREATEST(10, L.TABLE_NAME_LEN)) || CHAR(32) ||
  RPAD('LOCK_TYPE', 13) || CHAR(32) || RPAD('LOCK_MODE', 21) || CHAR(32) ||
  RPAD('BLOCKING_APP_NAME', GREATEST(17, L.BLOCKING_APP_NAME_LEN)) || CHAR(32) ||
  RPAD('BLOCKING_APP_USER', GREATEST(17, L.BLOCKING_APP_USER_LEN)) || CHAR(32) || 
  RPAD('BLOCKING_APP_SOURCE', GREATEST(19, L.BLOCKING_APP_SOURCE_LEN)) FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCK_WAITS ) L
UNION ALL SELECT 80060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 16, '=') || CHAR(32) || 
  RPAD('=', L.SCHEMA_NAME_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(10, L.TABLE_NAME_LEN), '=') || CHAR(32) ||
  RPAD('=', 13, '=') || CHAR(32) || RPAD('=', 21, '=') || CHAR(32) ||
  RPAD('=', GREATEST(17, L.BLOCKING_APP_NAME_LEN), '=') || CHAR(32) ||
  RPAD('=', GREATEST(17, L.BLOCKING_APP_USER_LEN), '=') || CHAR(32) || 
  RPAD('=', GREATEST(19, L.BLOCKING_APP_SOURCE_LEN), '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCK_WAITS ) L
UNION ALL
SELECT
  80100 + (99999999 - WAIT_S) / 99999999,
  RPAD(L.HOST, HOST_LEN) || CHAR(32) || LPAD(L.PORT, 5) || CHAR(32) || 
  LPAD(L.WAIT_S, 6) || CHAR(32) || LPAD(L.BLOCKED_CONN_ID, 15) || CHAR(32) || LPAD(L.BLOCKING_CONN_ID, 16) || CHAR(32) || 
  RPAD(L.SCHEMA_NAME, L.SCHEMA_NAME_LEN) || CHAR(32) || RPAD(L.TABLE_NAME, GREATEST(10, L.TABLE_NAME_LEN)) || CHAR(32) ||
  RPAD(L.LOCK_TYPE, 13) || CHAR(32) || RPAD(L.LOCK_MODE, 21) || CHAR(32) ||
  RPAD(L.BLOCKING_APP_NAME, GREATEST(17, L.BLOCKING_APP_NAME_LEN)) || CHAR(32) ||
  RPAD(L.BLOCKING_APP_USER, GREATEST(17, L.BLOCKING_APP_USER_LEN)) || CHAR(32) || 
  RPAD(L.BLOCKING_APP_SOURCE, GREATEST(19, L.BLOCKING_APP_SOURCE_LEN))
FROM
  BASIS_INFO BI,
  TRANSACTIONAL_LOCK_WAITS L
UNION ALL SELECT TOP 1 90000, ''                       FROM PARAMETERS
UNION ALL SELECT TOP 1 90010, '**********************' FROM PARAMETERS
UNION ALL SELECT TOP 1 90020, '* PARAMETER SETTINGS *' FROM PARAMETERS
UNION ALL SELECT TOP 1 90030, '**********************' FROM PARAMETERS
UNION ALL SELECT TOP 1 90040, ''                       FROM PARAMETERS
UNION ALL SELECT 90050, RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME' , KEY_LEN) || CHAR(32) || 'VALUE' 
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM PARAMETERS )
UNION ALL SELECT 90060, RPAD('=', FILE_LEN, '=') || CHAR(32) || RPAD('=', SECTION_LEN, '=') || CHAR(32) || RPAD('=' , KEY_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(5, VALUE_LEN), '=') 
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM PARAMETERS )
UNION ALL SELECT 90100 + ROW_NUMBER () OVER (ORDER BY FILE_NAME, SECTION, KEY), RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) || VALUE FROM PARAMETERS
UNION ALL SELECT 1000000, '' FROM DUMMY
UNION ALL SELECT 1000010, '*********************************************************' FROM DUMMY
UNION ALL SELECT 1000020, '* END OF SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *' FROM DUMMY
UNION ALL SELECT 1000030, '*********************************************************' FROM DUMMY
)
ORDER BY
  LINE_NO
WITH HINT (DEV_NO_UNIVERSAL_ITAB)