WITH 

/* 

[NAME]

- HANA_Threads_CurrentThreads_2.00.070+

[DESCRIPTION]

- Thread information

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- LOCK_OWNER_THREAD_ID available as of Rev. 1.00.70
- STATEMENT_HASH available as of Rev. 1.00.100
- LOCKS_OWNED available starting with Rev. 1.00.120
- NUMA_NODE_INDEX and ROOT_STATEMENT_HASH available starting with Rev. 2.00.040
- Memory size is always accounted to the SqlExecutor / Request thread and not to the related JobWorkers (to avoid double counting)
- M_SERVICE_THREADS.WORKLOAD_CLASS_NAME available with SAP HANA >= 2.00.060
- APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE available with SAP HANA >= 2.00.070
- M_CS_TABLE_HANDLES available with SAP HANA >= 2.00.070

[VALID FOR]

- Revisions:              >= 2.00.070

[SQL COMMAND VERSION]

- 2014/03/06:  1.0 (initial version)
- 2015/05/14:  1.1 (THREAD_METHOD, THREAD_DETAIL, CALLER, CALLING and LOCK_WAIT_NAME added)
- 2016/02/26:  1.2 (dedicated Rev100+ version)
- 2016/07/02:  1.3 (LOG_CONN_ID included)
- 2016/09/13:  1.4 (APP_USER filter included)
- 2016/11/08:  1.5 (PAR_CONN_ID included)
- 2017/01/04:  1.6 (THREAD_TYPE, THREAD_HASH filter included, SQL_TEXT output included)
- 2017/01/27:  1.7 (dedicated 1.00.120+ version)
- 2017/02/03:  1.8 (EXCLUDE_PHANTOM_THREADS included)
- 2017/05/01:  1.9 (CLIENT_PID included)
- 2017/10/05:  2.0 (THREAD_DETAIL input parameter included)
- 2017/10/14:  2.1 (USED_MEMORY_SIZE included)
- 2018/03/04:  2.2 (DB_USER included)
- 2019/04/09:  2.3 (LOCK_NAME filter included)
- 2019/05/14:  2.4 (dedicated 2.00.040+ version including NUMA_NODE)
- 2019/05/31:  2.5 (indents in THREAD_TYPE column to symbolize call hierarchy)
- 2020/09/24:  2.6 (JOB_QUEUEING / Q added)
- 2021/01/04:  2.7 (TRANS_ID added)
- 2021/01/29:  2.8 (USED_MEMORY_SIZE replaced with identical ALLOCATED_MEMORY_SIZE to be SHC compatible)
- 2021/01/31:  2.9 (EXCLUDE_CURRENT_CONN_ID included)
- 2021/09/12:  3.0 (PASSPORT_COMPONENT and PASSPORT_ACTION added)
- 2022/08/11:  3.1 (STATEMENT_THREAD_LIMIT and STATEMENT_MEMORY_LIMIT included)
- 2022/10/22:  3.2 (dedicated 2.00.060+ version including WORKLOAD_CLASS)
- 2023/07/17:  3.3 (INCLUDE_INACTIVE_CALLERS included)
- 2023/08/03:  3.4 (ONLY_EXTERNAL_CONNECTIONS included and CONN_ID semantics for -1 changed)
- 2023/10/29:  3.5 (dedicated 2.00.070+ version including APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE)
- 2023/11/16:  3.6 (redesign of TABLE_NAME(S) output column including TOP_TABLE_COUNT and MIN_TOP_TABLE_SIZE_MB filters)
- 2024/03/14:  3.7 (inclusion of other characteristics in TABLE_NAMES like backup or procedure calls)
- 2024/03/27:  3.8 (M_CS_TABLE_HANDLES included)

[INVOLVED TABLES]

- GLOBAL_TABLE_PERSISTENCE_STATISTICS
- HOST_SQL_PLAN_CACHE
- M_ACTIVE_STATEMENTS
- M_CONNECTIONS
- M_CS_TABLE_HANDLES
- M_SERVICE_THREADS
- M_SQL_PLAN_CACHE
- M_TABLE_PERSISTENCE_STATISTICS

[INPUT PARAMETERS]

- HOST

  Host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- SERVICE_NAME

  Service name

  'indexserver'   --> Specific service indexserver
  '%server'       --> All services ending with 'server'
  '%'             --> All services  

- ONLY_ACTIVE_THREADS

  Possibility to restrict output to active threads

  'X'            --> Only show threads that are currently active
  ' '            --> Show all threads

- INCLUDE_INACTIVE_CALLERS

  Possibility to include inactive caller threads

  'X'            --> Also consider inactive caller threads
  ' '            --> Do not display inactive caller threads (unless ONLY_ACTIVE_THREADS = ' ' is configured)

- CONN_ID

  Connection ID

  330655          --> Connection ID 330655
  -2              --> No connection ID restriction
  -1              --> Internal connections (having CONN_ID = -1)

- ONLY_EXTERNAL_CONNECTIONS

  Possibility to restrict result to external connections (with CONN_ID > 0)

  'X'             --> Only display external connections
  ' '             --> Consider both external and internal connections

- LOG_CONN_ID:

  Logical connection ID

  330655          --> Logical connection ID 330655
  -1              --> No logical connection ID restriction

- PAR_CONN_ID

  Parent connection ID

  330655          --> Parent connection ID 330655
  -1              --> No parent connection ID restriction

- JOB_QUEUEING

  Job queueing state

  'X'             --> Thread currently waits for assignment of JobWorker (THREAD_STATE = 'Job Exec Waiting', CALLING = '')
  ' '             --> Thread does not wait for JobWorker assignment

- CLIENT_IP

  IP address of client

  '172.23.4.12'   --> IP address 172.23.4.12 
  '%'             --> No restriction related to IP address

- CLIENT_PID

  Client process ID

  10264           --> Client process ID 10264
  -1              --> No client process ID restriction

- DB_USER

  Database user

  'SYSTEM'        --> Database user 'SYSTEM'
  '%'             --> No database user restriction

- APP_NAME

  Name of application

  'ABAP:C11'      --> Application name 'ABAP:C11'
  '%'             --> No application name restriction

- APP_USER

  Application user

  'SAPSYS'        --> Application user 'SAPSYS'
  '%'             --> No application user restriction

- APP_SOURCE

  Application source

  'SAPL2:437'     --> Application source 'SAPL2:437'
  'SAPMSSY2%'     --> Application sources starting with SAPMSSY2
  '%'             --> No application source restriction

- APP_COMP_NAME

  Application component name

  'ARFC_DEST_SHIP' --> Application component name ARFC_DEST_SHIP
  'ARFC%'          --> All application components with names starting with 'ARFC'
  '%'              --> No restriction related to application component name

- APP_COMP_TYPE

  Application component type

  'B'             --> Application component type B
  '%'             --> No restriction related to application component type 

- THREAD_ID

  Thread identifier

  4567            --> Thread 4567
  -1              --> No thread identifier restriction

- TRANS_ID

  Transaction ID

  123             --> Transaction ID 123
  -1              --> No restriction related to transaction ID

- THREAD_TYPE

  Type of thread (e.g. 'SqlExecutor', 'JobWorker' or 'MergedogMonitor')

  'SqlExecutor'   --> Threads with type 'SqlExecutor'
  '%'             --> No thread type restriction

- THREAD_STATE

  State of thread (e.g. e.g. 'Running', 'Network Read' or 'Semaphore Wait')

  'Running'       --> Threads with state 'Running'
  '%'             --> No thread state restriction

- THREAD_METHOD

  Thread method

  'SearchPartJob' --> Thread method SearchPartJob
  '%'             --> No restriction related to thread method

- THREAD_DETAIL

  Thread detail

  '%MARC%'        --> List threads with thread detail containing 'MARC'
  '%'             --> No restriction related to thread detail

- LOCK_NAME

  Lock name

  'transLock'     --> Display threads waiting for transLock
  '%'             --> No restriction related to lock waits

- NUMA_NODE

  Numa node

  5               --> Display threads running on NUMA node 5
  -1              --> No restriction related to NUMA node

- STATEMENT_HASH      
 
  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction

- ROOT_STATEMENT_HASH
 
  Root statement hash (e.g. hash of procedure responsible for statement execution)

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> Root statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No root statement hash restriction

- PASSPORT_COMPONENT

  Passport component

  'P24/sapabap01_P24_27' --> Passport component P24/sapabap01_P24_27
  '%'                    --> No restriction related to passport component

- PASSPORT_ACTION

  Passport action

  'SAPMSSY1'      --> Passport action SAPMSSY1
  '%'             --> No restriction related to passport action

- STATEMENT_THREAD_LIMIT

  Statement thread limit

  8               --> Display threads with a statement thread limit of 8
  -1              --> No restriction related to statement thread limit

- STATEMENT_MEMORY_LIMIT

  Statement memory limit

  100             --> Display threads with a statement memory limit of 100
  -1              --> No restriction related to statement memory limit

- WORKLOAD_CLASS

  Workload class name

  'WLC_100'       --> Display threads running in the context of workload class WLC_100
  '%'             --> No restriction related to workload class

- TABLE_NAMES

  Accessed table names (depends on TOP_TABLE_COUNT, MIN_TOP_TABLE_SIZE_MB and removal of 1 = 0 restrictions) or
  other specifics like "-- BACKUP --" or "-- CHECK_TABLE_CONSISTENCY --"

  '%ACDOCA%'      --> Only display threads with 'ACDOCA' being part of the top table list
  '%'             --> No restriction related to access table

- TOP_TABLE_COUNT

  Number of top involved tables (in terms of size) to be displayed (only works when 1 = 0 conditions are removed)

  3               --> Display top 3 tables in terms of size
  -1              --> Display all involved tables

- MIN_TOP_TABLE_SIZE_MB

  Minimum table size to be displayed in TABLE_NAMES output column (only works when 1 = 0 conditions are removed)

  10              --> Consider only tables with a size of at least 10 MB
  -1              --> No restriction in terms of table size

- EXCLUDE_PHANTOM_THREADS

  Possibility to exclude idle threads that are shown as "active" due to SAP HANA bugs

  'X'             --> Do not show idle threads that are shown as active threads
  ' '             --> No restriction of displayed threads

- EXCLUDE_CURRENT_CONN_ID

  Possibility to exclude threads related to the execution of this analysis command

  'X'             --> Suppress the display of threads belonging to the execution of this analysis command
  ' '             --> No exclusion of threads related to this analysis command

- AGGREGATION_TYPE

  Type of aggregation (e.g. average, sum, maximum)

  'AVG'           --> Average value
  'SUM'           --> Total value
  'MAX'           --> Maximum value

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'THREAD_ID'     --> Aggregation by thread ID
  'HOST, PORT'    --> Aggregation by host and port
  'NONE'          --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'THREADS'       --> Sorting by number of threads (useful when aggregating)
  'CONNECTION'    --> Sorting by connection ID

[OUTPUT PARAMETERS]

- HOST:                Host name
- PORT:                Port
- NM:                  NUMA node (-2 in case of NULL)
- WORKLOAD_CLASS:      Workload class name
- STL:                 Statement thread limit (-1 can be related to cross-database requests that can't use concurrency parameters)
- SML:                 Statement memory limit (-1 can be related to cross-database requests that can't use concurrency parameters)
- ACTIVE_MS:           Database request duration (ms)
- MEM_GB:              Used memory (GB)
- CONN_ID:             Connection ID
- THREAD_ID:           Thread ID
- TABLE_NAMES:         Name and size of accessed tables (if available) other other specific activities, expensive operation, so deactivated per default 
                       (remove "AND 1 = 0" at three locations below to include this information)
- THREAD_TYPE:         Thread type
- THREAD_METHOD:       Thread meathod
- THREAD_STATE:        Thread state
- Q:                   'X' in case thread waits for availability of JobWorker (THREAD_STATE = 'Job Exec Waiting', CALLING = '')
- LOCK_NAME:           Lock name
- STATEMENT_HASH:      Statement hash
- THREAD_DETAIL:       Thread detail
- DB_USER:             Database user
- APP_NAME:            Application name
- APP_USER:            Application user name
- APP_SOURCE:          Application source
- APP_COMP_NAME:       Application component name
- APP_COMP_TYPE:       Application component type
- PASSPORT_COMPONENT:  Passport component
- PASSPORT_ACTION:     Passport action
- CLIENT_IP:           Client IP address
- CLIENT_PID:          Client process ID
- BLK_THREAD:          Blocking thread
- LOCKS_OWNED:         Internal locks held by the thread
- CALLER:              Caller thread (i.e. thread that has triggered the current thread)
- CALLING:             Called thread (i.e. thread that is triggered by current thread)
- ACTIVE:              'TRUE' if thread is active, otherwise false
- CPU_TIME_S:          Thread CPU consumption (s)
- ROOT_STATEMENT_HASH: Root statement hash
- TRANS_ID:            Transaction ID
- CNT:                 Number of threads (1 if no aggregation is done)

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------
|HOST     |SERVICE_NAME    |NUM  |CONN_ID   |THREAD_ID|THREAD_TYPE        |THREAD_STATE|ACTIVE|APP_USER   |DURATION_S|CPU_TIME_S|
---------------------------------------------------------------------------------------------------------------------------------
|saphana20|preprocessor    |    1|    338803|    24424|Request            |any         |TRUE  |ZSAP_10    |      0.00|      0.00|
|saphana20|indexserver     |    1|    338803|    24449|Request            |any         |TRUE  |ZSAP_10    |      0.00|      0.00|
|saphana20|nameserver      |    1|    338803|    28364|Request            |any         |TRUE  |ZSAP_10    |      0.00|      0.00|
|saphana21|indexserver     |    1|    338803|    52999|SqlExecutor        |any         |TRUE  |ZSAP_10    |      0.03|      0.00|
|saphana21|indexserver     |    1|    300257|    53005|SqlExecutor        |any         |TRUE  |RT_VENTES  |      0.00|      0.00|
|saphana21|indexserver     |    1|    301432|    53011|SqlExecutor        |any         |TRUE  |RT_LOG     |      0.00|      0.00|
|saphana21|indexserver     |    1|    301551|    53024|SqlExecutor        |any         |TRUE  |RT_VENTES  |      0.00|      0.00|
|saphana21|indexserver     |    1|    300290|    53508|SqlExecutor        |any         |TRUE  |RT_PUSHW045|      0.00|      0.00|
|saphana21|indexserver     |    1|    300776|    65701|SqlExecutor        |any         |TRUE  |RT_PUSHW045|      0.00|      0.00|
|saphana20|compileserver   |    1|    338803|    93615|Request            |any         |TRUE  |ZSAP_10    |      0.00|      0.00|
|saphana21|nameserver      |    1|    338803|   102512|Request            |any         |TRUE  |ZSAP_10    |      0.00|      0.00|
---------------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT                                      /* Modification section */
    '%' HOST,
    '%' PORT,
    '%' SERVICE_NAME,
    -2 CONN_ID,
    ' ' ONLY_EXTERNAL_CONNECTIONS,
    -1 LOG_CONN_ID,
    -1 PAR_CONN_ID,
    '%' JOB_QUEUEING,
    '%' CLIENT_IP,
    -1 CLIENT_PID,
    '%' DB_USER,
    '%' APP_NAME,
    '%' APP_USER,
    '%' APP_SOURCE,
    '%' APP_COMP_NAME,
    '%' APP_COMP_TYPE,
    -1 THREAD_ID,
    -1 TRANS_ID,
    '%' THREAD_TYPE,
    '%' THREAD_STATE,
    '%' THREAD_METHOD,
    '%' THREAD_DETAIL,
    '%' LOCK_NAME,
    -1  NUMA_NODE,
    '%' STATEMENT_HASH,
    '%' ROOT_STATEMENT_HASH,
    '%' PASSPORT_COMPONENT,
    '%' PASSPORT_ACTION,
    -1 STATEMENT_THREAD_LIMIT,
    -1 STATEMENT_MEMORY_LIMIT,
    '%' WORKLOAD_CLASS,
    '%' TABLE_NAMES,                      /* make sure that you remove "1 = 0" three times below, otherwise no table names are provided */
     2 TOP_TABLE_COUNT,
    -1 MIN_TOP_TABLE_SIZE_MB,
    'X' ONLY_ACTIVE_THREADS,
    ' ' INCLUDE_INACTIVE_CALLERS,
    'X' EXCLUDE_PHANTOM_THREADS,
    'X' EXCLUDE_CURRENT_CONN_ID,
    'SUM' AGGREGATION_TYPE,       /* MAX, AVG, SUM */
    'NONE' AGGREGATE_BY,          /* HOST, PORT, SERVICE, CONN_ID, LOG_CONN, PAR_CONN, CLIENT_PID, HASH, DB_USER, APP_NAME, APP_USER, APP_SOURCE, APP_COMP_NAME, APP_COMP_TYPE,
                                     THREAD_TYPE, THREAD_STATE, THREAD_METHOD, THREAD_DETAIL, THREAD_ID, CALLER, CALLING, LOCK_NAME, LOCKS_OWNED, NUMA_NODE, QUEUEING, TRANS_ID, 
                                     PASSPORT_COMPONENT, PASSPORT_ACTION, WORKLOAD_CLASS and comma separated combinations, NONE for no aggregation */
    'CONNECTION' ORDER_BY         /* THREAD_ID, CONNECTION, THREADS, MEMORY, DURATION */
  FROM
    DUMMY
),
THREADS_HELPER AS
( SELECT
    HOST,
    TO_VARCHAR(PORT) PORT,
    CONNECTION_ID CONN_ID,
    STATEMENT_HASH,
    ROOT_STATEMENT_HASH,
    STATEMENT_ID,
    THREAD_ID,
    THREAD_TYPE,
    THREAD_STATE,
    THREAD_METHOD,
    TO_VARCHAR(SUBSTR(THREAD_DETAIL, 1, 5000)) THREAD_DETAIL,
    CLIENT_IP,
    CLIENT_PID,
    CALLER,
    CASE 
      WHEN CALLER LIKE '%@%:%' THEN SUBSTR(CALLER, 1, LOCATE(CALLER, '@') - 1)
      WHEN CALLER LIKE '%:%' THEN '-99'
      ELSE MAP(CALLER, '', '-99', CALLER) 
    END CALLER_THREAD,
    CASE WHEN CALLER LIKE '%:%' THEN SUBSTR(CALLER, LOCATE(CALLER, '@') + 1, LOCATE(CALLER, ':') - LOCATE(CALLER, '@') - 1) ELSE HOST                           END CALLER_HOST,
    CASE WHEN CALLER LIKE '%:%' THEN SUBSTR(CALLER, LOCATE(CALLER, ':') + 1)                                                ELSE TO_VARCHAR(PORT)               END CALLER_PORT,
    CALLING,
    IS_ACTIVE ACTIVE,
    USER_NAME DB_USER,
    APPLICATION_NAME APP_NAME,
    APPLICATION_USER_NAME APP_USER,
    APPLICATION_SOURCE APP_SOURCE,
    APPLICATION_COMPONENT_NAME APP_COMP_NAME,
    CASE APPLICATION_COMPONENT_TYPE
      WHEN 'B' THEN 'ABAP: Batch Job'
      WHEN 'C' THEN 'ABAP: RFC'
      WHEN 'I' THEN 'ABAP: Unknown'
      WHEN 'O' THEN 'ABAP: OData V2'
      WHEN 'S' THEN 'ABAP: Submit Report'
      WHEN 'T' THEN 'ABAP: Transaction'
      WHEN 'U' THEN 'ABAP: URL'
      WHEN 'V' THEN 'ABAP: Update Task'
      WHEN '4' THEN 'ABAP: OData V4'
      ELSE APPLICATION_COMPONENT_TYPE
    END APP_COMP_TYPE,
    DURATION DURATION_MS,
    CPU_TIME_SELF CPU_TIME_US,
    LOCK_OWNER_THREAD_ID BLK_THREAD,
    LOCK_WAIT_NAME LOCK_NAME,
    IFNULL(( SELECT 
        MAX('Index handle (' || TABLE_NAME || ',' || CHAR(32) || CURRENT_STATE || ')' )
      FROM 
        M_CS_TABLE_HANDLES H 
      WHERE 
        H.HOST = T.HOST AND 
        H.PORT = T.PORT AND 
        H.THREAD_ID = T.THREAD_ID AND
        SECONDS_BETWEEN(ACQUIRE_TIME, CURRENT_TIMESTAMP) > 1
    ) || CHAR(32) || LOCKS_OWNED, '') LOCKS_OWNED,
    IFNULL(NUMA_NODE_INDEX, -2) NUMA_NODE,
    TRANSACTION_ID TRANS_ID,
    IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
    IFNULL(PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT,
    STATEMENT_THREAD_LIMIT,
    STATEMENT_MEMORY_LIMIT,
    WORKLOAD_CLASS_NAME
  FROM
    M_SERVICE_THREADS T
),
THREADS AS
( SELECT
    T1.HOST,
    T1.PORT,
    CASE WHEN T1.CONN_ID = -1 AND T2.CONN_ID IS NOT NULL THEN T2.CONN_ID ELSE T1.CONN_ID END CONN_ID,
    T1.STATEMENT_HASH,
    T1.ROOT_STATEMENT_HASH,
    T1.STATEMENT_ID,
    T1.THREAD_ID,
    T1.THREAD_TYPE,
    T1.THREAD_STATE,
    T1.THREAD_METHOD,
    T1.THREAD_DETAIL,
    T1.CLIENT_IP,
    T1.CLIENT_PID,
    T1.CALLER,
    T1.CALLING,
    T1.ACTIVE,
    T1.DB_USER,
    T1.APP_NAME,
    T1.APP_USER,
    T1.APP_SOURCE,
    T1.APP_COMP_NAME,
    T1.APP_COMP_TYPE,
    T1.DURATION_MS,
    T1.CPU_TIME_US,
    T1.BLK_THREAD,
    T1.LOCK_NAME,
    T1.LOCKS_OWNED,
    T1.NUMA_NODE,
    T1.TRANS_ID,
    T1.PASSPORT_ACTION,
    T1.PASSPORT_COMPONENT,
    T1.STATEMENT_THREAD_LIMIT,
    T1.STATEMENT_MEMORY_LIMIT,
    T1.WORKLOAD_CLASS_NAME,
    CASE WHEN T1.THREAD_STATE = 'Job Exec Waiting' AND T1.CALLING = '' THEN 'X' ELSE '' END JOB_QUEUEING,
    CASE
      WHEN T1.CALLER = ''       THEN 0
      WHEN T3.THREAD_ID IS NULL THEN 1
      WHEN T4.THREAD_ID IS NULL THEN 2
      ELSE 3
    END LVL,
    CASE
      WHEN T1.CALLER = ''       THEN LPAD(IFNULL(T1.THREAD_ID, 0), 15, '-') || LPAD('-', 45, '-')
      WHEN T3.THREAD_ID IS NULL THEN LPAD(IFNULL(T2.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T1.THREAD_ID, 0), 15, '-') || LPAD('-', 30, '-')
      WHEN T4.THREAD_ID IS NULL THEN LPAD(IFNULL(T3.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T2.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T1.THREAD_ID, 0), 15, '-') || LPAD('-', 15, '-')
      ELSE                           LPAD(IFNULL(T4.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T3.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T2.THREAD_ID, 0), 15, '-') || LPAD(IFNULL(T1.THREAD_ID, 0), 15, '-')
    END CONN_HIERARCHY
  FROM
    BASIS_INFO BI,
    THREADS_HELPER T1 LEFT OUTER JOIN
    THREADS_HELPER T2 ON
      T2.THREAD_ID = T1.CALLER_THREAD AND
      T2.HOST = T1.CALLER_HOST AND
      T2.PORT = T1.CALLER_PORT LEFT OUTER JOIN
    THREADS_HELPER T3 ON
      T3.THREAD_ID = T2.CALLER_THREAD AND
      T3.HOST = T2.CALLER_HOST AND
      T3.PORT = T2.CALLER_PORT LEFT OUTER JOIN
    THREADS_HELPER T4 ON
      T4.THREAD_ID = T3.CALLER_THREAD AND
      T4.HOST = T3.CALLER_HOST AND
      T4.PORT = T3.CALLER_PORT
  WHERE
    ( BI.ONLY_ACTIVE_THREADS = ' ' OR T1.ACTIVE = 'TRUE' OR
      ( BI.INCLUDE_INACTIVE_CALLERS = 'X' AND (T1.THREAD_ID, T1.HOST, T1.PORT ) IN ( SELECT CT.CALLER_THREAD, CT.CALLER_HOST, CT.CALLER_PORT FROM 
        THREADS_HELPER CT WHERE CT.CALLER_THREAD = T1.THREAD_ID AND CT.CALLER_HOST = T1.HOST AND CT.CALLER_PORT = T1.PORT AND CT.ACTIVE = 'TRUE' ) 
      )
    )
),
HASH_TABLE_MAPPING AS
( SELECT
    T.STATEMENT_HASH,
    CASE
      WHEN STRING_AGG(T.TABLE_NAME) LIKE 'BACKUP' THEN '-- BACKUP --'
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%CHECK_TABLE_CONSISTENCY%' THEN '-- CHECK_TABLE_CONSISTENCY --'
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%CREATE TABLE%' THEN '-- CREATE TABLE --'
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%DSO_ACTIVATE_PERSISTED%' THEN '-- DSO_ACTIVATE_PERSISTED -- '
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%STATISTICS_SCHEDULABLEWRAPPER%' THEN '-- STATISTICS_SCHEDULABLEWRAPPER --'
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%TREXVIADBSL%' THEN '-- TREXVIADBSL --'
      ELSE STRING_AGG(T.TABLE_NAME || CHAR(32) || '(' || TO_DECIMAL(T.DISK_BYTE / 1024 / 1024 / 1024, 10, 2) || CHAR(32) || 'GB)', ', ' ORDER BY T.SIZE_POS) 
    END TABLE_NAMES
  FROM
    BASIS_INFO BI,
 ( SELECT
      STATEMENT_HASH,
      TABLE_NAME,
      DISK_BYTE,
      ROW_NUMBER () OVER (PARTITION BY STATEMENT_HASH ORDER BY DISK_BYTE DESC, TABLE_NAME) SIZE_POS
    FROM
    ( SELECT DISTINCT
        S.STATEMENT_HASH,
        S.SCHEMA_NAME,
        S.TABLE_NAME,
        MAX(T.TABLE_SIZE) DISK_BYTE
      FROM
      ( SELECT
          STATEMENT_HASH,
          SUBSTR(SCHEMA_OBJECT, 1, LOCATE(SCHEMA_OBJECT, '.') - 1) SCHEMA_NAME,
          SUBSTR(SCHEMA_OBJECT, LOCATE(SCHEMA_OBJECT, '.') + 1) TABLE_NAME
        FROM
        ( SELECT DISTINCT
            STATEMENT_HASH,
            CNT, 
            SUBSTR(AON, MAP(CNT, 1, 1, LOCATE(AON, ',', 1, CNT-1) + 2), LOCATE(AON, '(', 1, CNT) - MAP(CNT, 1, 1, LOCATE(AON, ',', 1, CNT-1) + 2)) SCHEMA_OBJECT,
            AON
          FROM
          ( SELECT TOP 200 ROW_NUMBER() OVER () CNT FROM OBJECTS ) C,
          ( SELECT DISTINCT
              STATEMENT_HASH,
              TO_VARCHAR(ACCESSED_OBJECT_NAMES) AON
            FROM
              M_SQL_PLAN_CACHE
            WHERE
              TO_VARCHAR(ACCESSED_OBJECT_NAMES) != ''                                                                             AND 1 = 0
            UNION
            SELECT DISTINCT
              STATEMENT_HASH,
              TO_VARCHAR(ACCESSED_OBJECT_NAMES) AON
            FROM
              _SYS_STATISTICS.HOST_SQL_PLAN_CACHE
            WHERE
              TO_VARCHAR(ACCESSED_OBJECT_NAMES) != ''                                                                             AND 1 = 0
            UNION
            SELECT DISTINCT
              STATEMENT_HASH,
              '<dummy>.' ||
              CASE 
                WHEN UPPER(TO_VARCHAR(STATEMENT_STRING)) LIKE 'BACKUP%' THEN 'BACKUP'
                WHEN OPERATION = 'CREATE_TABLE' THEN 'CREATE TABLE'
                ELSE TO_VARCHAR(OBJECT_NAME) END || '()' AON
            FROM
              M_EXPENSIVE_STATEMENTS
            WHERE
            ( TO_VARCHAR(OBJECT_NAME) != '' OR UPPER(TO_VARCHAR(STATEMENT_STRING)) LIKE 'BACKUP%' OR OPERATION = 'CREATE_TABLE' ) AND 1 = 0
          ) S
        )
        WHERE
          SCHEMA_OBJECT LIKE '%.%'
      ) S LEFT OUTER JOIN
      ( SELECT
          T.SCHEMA_NAME,
          T.TABLE_NAME,
          T.DISK_SIZE TABLE_SIZE
        FROM
          M_TABLE_PERSISTENCE_STATISTICS T
      ) T ON
        S.SCHEMA_NAME = T.SCHEMA_NAME AND
        S.TABLE_NAME = T.TABLE_NAME
      GROUP BY
        S.STATEMENT_HASH,
        S.SCHEMA_NAME,
        S.TABLE_NAME
    )
  ) T
  WHERE
  ( DISK_BYTE IS NOT NULL AND
    ( BI.TOP_TABLE_COUNT = -1 OR SIZE_POS <= BI.TOP_TABLE_COUNT ) AND
    ( BI.MIN_TOP_TABLE_SIZE_MB = -1 OR T.DISK_BYTE / 1024 / 1024 >= BI.MIN_TOP_TABLE_SIZE_MB )
  ) OR
  TABLE_NAME LIKE '%BACKUP%' OR
  TABLE_NAME LIKE '%CHECK_TABLE_CONSISTENCY%' OR 
  TABLE_NAME LIKE '%CREATE TABLE%' OR
  TABLE_NAME LIKE '%DSO_ACTIVATE_PERSISTED%' OR 
  TABLE_NAME LIKE '%STATISTICS_SCHEDULABLEWRAPPER%' OR 
  TABLE_NAME LIKE '%TREXVIADBSL%'
  GROUP BY
    T.STATEMENT_HASH
)
SELECT
  HOST,
  LPAD(PORT, 5) PORT,
  LPAD(NUMA_NODE, 2) NM,
  WORKLOAD_CLASS,
  LPAD(STATEMENT_THREAD_LIMIT, 3) STL,
  LPAD(STATEMENT_MEMORY_LIMIT, 4) SML,
  LPAD(TO_DECIMAL(DURATION_MS, 10, 0), 9) ACTIVE_MS,
  LPAD(TO_DECIMAL(MEM_USED_GB, 10, 2), 6) MEM_GB,
  LPAD(CONN_ID, 7) CONN_ID,
  LPAD(THREAD_ID, 9) THREAD_ID,
  TABLE_NAMES,
  LPAD(CHAR(32), LVL * 2) || THREAD_TYPE THREAD_TYPE,
  THREAD_METHOD,
  THREAD_STATE,
  JOB_QUEUEING Q,
  LOCK_NAME,
  STATEMENT_HASH,
  REPLACE(REPLACE(REPLACE(THREAD_DETAIL, CHAR(9), ' '), CHAR(10), ' '), CHAR(13), ' ') THREAD_DETAIL,
  DB_USER,
  APP_NAME,
  APP_USER,
  APP_SOURCE,
  APP_COMP_NAME,
  APP_COMP_TYPE,
  PASSPORT_COMPONENT,
  PASSPORT_ACTION,
  CLIENT_IP,
  LPAD(CLIENT_PID, 10) CLIENT_PID,
  LPAD(MAP(BLK_THREAD, '0', '', BLK_THREAD), 10) BLK_THREAD,
  LOCKS_OWNED,
  CALLER,
  CALLING,
  ACTIVE,
  LPAD(TO_DECIMAL(CPU_TIME_S, 10, 2), 10) CPU_TIME_S,
  ROOT_STATEMENT_HASH,
  LPAD(TRANS_ID, 8) TRANS_ID,
  LPAD(NUM, 3) CNT
  /* SERVICE_NAME SERVICE, IFNULL(LPAD(LOG_CONN_ID, 11), '') LOG_CONN_ID, IFNULL(LPAD(PAR_CONN_ID, 11), '') PAR_CONN_ID,
  REPLACE(REPLACE(REPLACE(IFNULL(SQL_TEXT, ''), CHAR(10), CHAR(32)), CHAR(13), CHAR(32)), CHAR(9), CHAR(32)) SQL_TEXT */
FROM
( SELECT
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')               != 0 THEN T.HOST                               ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                               END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')               != 0 THEN TO_VARCHAR(T.PORT)                   ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                               END PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')            != 0 THEN S.SERVICE_NAME                       ELSE MAP(BI.SERVICE_NAME, '%', 'any', BI.SERVICE_NAME)               END SERVICE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')            != 0 THEN TO_VARCHAR(T.CONN_ID)                ELSE MAP(BI.CONN_ID, -1, 'any', TO_VARCHAR(BI.CONN_ID))              END CONN_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOG_CONN')           != 0 THEN TO_VARCHAR(C.LOGICAL_CONNECTION_ID)  ELSE MAP(BI.LOG_CONN_ID, -1, 'any', TO_VARCHAR(BI.LOG_CONN_ID))      END LOG_CONN_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PAR_CONN')           != 0 THEN TO_VARCHAR(C.PARENT_CONNECTION_ID)   ELSE MAP(BI.PAR_CONN_ID, -1, 'any', TO_VARCHAR(BI.PAR_CONN_ID))      END PAR_CONN_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'QUEUEING')           != 0 THEN TO_VARCHAR(T.JOB_QUEUEING)           ELSE MAP(BI.JOB_QUEUEING, '%', 'any', BI.JOB_QUEUEING)   END JOB_QUEUEING,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN T.STATEMENT_HASH                     ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)           END STATEMENT_HASH,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ROOT')               != 0 THEN T.ROOT_STATEMENT_HASH                ELSE MAP(BI.ROOT_STATEMENT_HASH, '%', 'any', BI.ROOT_STATEMENT_HASH) END ROOT_STATEMENT_HASH,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN SUBSTR(ST.STATEMENT_STRING, 1, 4000) ELSE 'any'                                                           END SQL_TEXT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')            != 0 THEN T.DB_USER                            ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                         END DB_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')           != 0 THEN T.APP_NAME                           ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                       END APP_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')           != 0 THEN T.APP_USER                           ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                       END APP_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')         != 0 THEN T.APP_SOURCE                         ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                   END APP_SOURCE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_COMP_NAME')      != 0 THEN T.APP_COMP_NAME                      ELSE MAP(BI.APP_COMP_NAME, '%', 'any', BI.APP_COMP_NAME)             END APP_COMP_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_COMP_TYPE')      != 0 THEN T.APP_COMP_TYPE                      ELSE MAP(BI.APP_COMP_TYPE, '%', 'any', BI.APP_COMP_TYPE)             END APP_COMP_TYPE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')        != 0 THEN T.THREAD_TYPE                        ELSE 'any'                                                           END THREAD_TYPE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')       != 0 THEN T.THREAD_STATE                       ELSE 'any'                                                           END THREAD_STATE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD')      != 0 THEN T.THREAD_METHOD                      ELSE 'any'                                                           END THREAD_METHOD,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL')      != 0 THEN T.THREAD_DETAIL                      ELSE 'any'                                                           END THREAD_DETAIL,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')          != 0 THEN TO_VARCHAR(T.THREAD_ID)              ELSE 'any'                                                           END THREAD_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TRANS_ID')           != 0 THEN TO_VARCHAR(T.TRANS_ID)               ELSE MAP(BI.TRANS_ID, -1, 'any', TO_VARCHAR(BI.TRANS_ID))            END TRANS_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_IP')          != 0 THEN T.CLIENT_IP                          ELSE MAP(BI.CLIENT_IP, '%', 'any', BI.CLIENT_IP)                     END CLIENT_IP,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_PID')         != 0 THEN TO_VARCHAR(T.CLIENT_PID)             ELSE MAP(BI.CLIENT_PID, -1, 'any', TO_VARCHAR(BI.CLIENT_PID))        END CLIENT_PID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLER')             != 0 THEN T.CALLER                             ELSE 'any'                                                           END CALLER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLING')            != 0 THEN T.CALLING                            ELSE 'any'                                                           END CALLING,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')          != 0 THEN T.LOCK_NAME                          ELSE 'any'                                                           END LOCK_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCKS_OWNED')        != 0 THEN T.LOCKS_OWNED                        ELSE 'any'                                                           END LOCKS_OWNED,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NUMA_NODE')          != 0 THEN TO_VARCHAR(T.NUMA_NODE)              ELSE MAP(BI.NUMA_NODE, -1, 'any', TO_VARCHAR(BI.NUMA_NODE))          END NUMA_NODE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION')    != 0 THEN T.PASSPORT_ACTION                    ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)         END PASSPORT_ACTION,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMPONENT') != 0 THEN T.PASSPORT_COMPONENT                 ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)   END PASSPORT_COMPONENT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_THREAD_LIMIT')  != 0 THEN TO_VARCHAR(T.STATEMENT_THREAD_LIMIT) ELSE MAP(BI.STATEMENT_THREAD_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_THREAD_LIMIT)) END STATEMENT_THREAD_LIMIT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_MEMORY_LIMIT')  != 0 THEN TO_VARCHAR(T.STATEMENT_MEMORY_LIMIT) ELSE MAP(BI.STATEMENT_MEMORY_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_MEMORY_LIMIT)) END STATEMENT_MEMORY_LIMIT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'WORKLOAD_CLASS')     != 0 THEN T.WORKLOAD_CLASS_NAME                ELSE MAP(BI.WORKLOAD_CLASS, '%', 'any', BI.WORKLOAD_CLASS)           END WORKLOAD_CLASS,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')              != 0 OR INSTR(BI.AGGREGATE_BY, 'HASH') != 0
                                                                                            THEN IFNULL(HTM.TABLE_NAMES, '')          ELSE MAP(BI.TABLE_NAMES, '%', 'any', BI.TABLE_NAMES)                 END TABLE_NAMES,
    COUNT(*) NUM,
    MAP(MIN(T.ACTIVE), MAX(T.ACTIVE), MAX(T.ACTIVE), 'any') ACTIVE,
    MAP(BI.AGGREGATION_TYPE, 'AVG', AVG(T.DURATION_MS), 'MAX', MAX(T.DURATION_MS), 'SUM', SUM(T.DURATION_MS)) DURATION_MS,
    MAP(BI.AGGREGATION_TYPE, 'AVG', AVG(T.CPU_TIME_US), 'MAX', MAX(T.CPU_TIME_US), 'SUM', SUM(T.CPU_TIME_US)) / 1000 / 1000 CPU_TIME_S,
    IFNULL(MAP(BI.AGGREGATION_TYPE, 
      'AVG', AVG(MAP(T.THREAD_TYPE, 'SqlExecutor', ST.ALLOCATED_MEMORY_SIZE, 'Request', ST.ALLOCATED_MEMORY_SIZE, 0)), 
      'MAX', MAX(MAP(T.THREAD_TYPE, 'SqlExecutor', ST.ALLOCATED_MEMORY_SIZE, 'Request', ST.ALLOCATED_MEMORY_SIZE, 0)),
      'SUM', SUM(MAP(T.THREAD_TYPE, 'SqlExecutor', ST.ALLOCATED_MEMORY_SIZE, 'Request', ST.ALLOCATED_MEMORY_SIZE, 0))
    ) / 1024 / 1024 / 1024, 0) MEM_USED_GB,
    MAP(MIN(T.BLK_THREAD), TO_VARCHAR(MAX(T.BLK_THREAD)), TO_VARCHAR(MAX(T.BLK_THREAD)), 'various') BLK_THREAD,
    MIN(T.LVL) LVL,
    MIN(T.CONN_HIERARCHY) CONN_HIERARCHY,
    BI.ORDER_BY
  FROM
    BASIS_INFO BI,
    M_SERVICES S,
    THREADS T LEFT OUTER JOIN
    M_CONNECTIONS C ON
      C.HOST = T.HOST AND
      C.PORT = T.PORT AND
      C.CONNECTION_ID = T.CONN_ID LEFT OUTER JOIN
  ( SELECT
      HOST,
      PORT,
      CONNECTION_ID,
      STATEMENT_ID,
      STATEMENT_STRING,
      STATEMENT_STATUS,
      GREATEST(0, IFNULL(ALLOCATED_MEMORY_SIZE, 0)) ALLOCATED_MEMORY_SIZE
    FROM
      M_ACTIVE_STATEMENTS
  ) ST ON
      C.HOST = ST.HOST AND
      C.PORT = ST.PORT AND
      C.CONNECTION_ID = ST.CONNECTION_ID AND
      T.STATEMENT_ID = ST.STATEMENT_ID AND
      ST.STATEMENT_STATUS = 'ACTIVE' LEFT OUTER JOIN
    HASH_TABLE_MAPPING HTM ON
      HTM.STATEMENT_HASH = T.STATEMENT_HASH
  WHERE
    S.HOST LIKE BI.HOST AND
    TO_VARCHAR(S.PORT) LIKE BI.PORT AND
    S.SERVICE_NAME LIKE BI.SERVICE_NAME AND
    T.HOST = S.HOST AND
    T.PORT = S.PORT AND
    IFNULL(T.DB_USER, '') LIKE BI.DB_USER AND
    IFNULL(T.APP_NAME, '') LIKE BI.APP_NAME AND
    IFNULL(T.APP_USER, '') LIKE BI.APP_USER AND
    IFNULL(T.APP_SOURCE, '') LIKE BI.APP_SOURCE AND
    IFNULL(T.APP_COMP_NAME, '') LIKE BI.APP_COMP_NAME AND
    IFNULL(T.APP_COMP_TYPE, '') LIKE BI.APP_COMP_TYPE AND
    ( BI.CONN_ID = -2 OR T.CONN_ID = BI.CONN_ID ) AND
    ( BI.ONLY_EXTERNAL_CONNECTIONS = ' ' OR T.CONN_ID > 0 ) AND
    ( BI.LOG_CONN_ID = -1 OR C.LOGICAL_CONNECTION_ID = BI.LOG_CONN_ID ) AND
    ( BI.THREAD_ID = -1 OR T.THREAD_ID = BI.THREAD_ID ) AND
    ( BI.TRANS_ID = -1 OR T.TRANS_ID = BI.TRANS_ID ) AND
    T.CLIENT_IP LIKE BI.CLIENT_IP AND
    ( BI.CLIENT_PID = -1 OR T.CLIENT_PID = BI.CLIENT_PID ) AND
    T.THREAD_TYPE LIKE BI.THREAD_TYPE AND
    T.THREAD_STATE LIKE BI.THREAD_STATE AND
    IFNULL(T.THREAD_METHOD, '') LIKE BI.THREAD_METHOD AND
    IFNULL(T.THREAD_DETAIL, '') LIKE BI.THREAD_DETAIL AND
    IFNULL(T.LOCK_NAME, '') LIKE BI.LOCK_NAME AND
    ( BI.NUMA_NODE = -1 OR T.NUMA_NODE = BI.NUMA_NODE ) AND
    T.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
    T.ROOT_STATEMENT_HASH LIKE BI.ROOT_STATEMENT_HASH AND
    ( T.PASSPORT_ACTION LIKE BI.PASSPORT_ACTION ) AND
    ( T.PASSPORT_COMPONENT LIKE BI.PASSPORT_COMPONENT ) AND
    ( BI.STATEMENT_THREAD_LIMIT = -1 OR T.STATEMENT_THREAD_LIMIT = BI.STATEMENT_THREAD_LIMIT ) AND
    ( BI.STATEMENT_MEMORY_LIMIT = -1 OR T.STATEMENT_MEMORY_LIMIT = BI.STATEMENT_MEMORY_LIMIT ) AND
    IFNULL(T.WORKLOAD_CLASS_NAME, '') LIKE BI.WORKLOAD_CLASS AND
    IFNULL(HTM.TABLE_NAMES, '') LIKE BI.TABLE_NAMES AND
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
        T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Network Poll'              AND T.CONN_ID = -1 AND           T.THREAD_METHOD = 'generic'                       OR
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
    ) AND
    ( BI.EXCLUDE_CURRENT_CONN_ID = ' ' OR T.CONN_ID != CURRENT_CONNECTION )
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')               != 0 THEN T.HOST                               ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                               END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')               != 0 THEN TO_VARCHAR(T.PORT)                   ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                               END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')            != 0 THEN S.SERVICE_NAME                       ELSE MAP(BI.SERVICE_NAME, '%', 'any', BI.SERVICE_NAME)               END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')            != 0 THEN TO_VARCHAR(T.CONN_ID)                ELSE MAP(BI.CONN_ID, -1, 'any', TO_VARCHAR(BI.CONN_ID))              END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOG_CONN')           != 0 THEN TO_VARCHAR(C.LOGICAL_CONNECTION_ID)  ELSE MAP(BI.LOG_CONN_ID, -1, 'any', TO_VARCHAR(BI.LOG_CONN_ID))      END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PAR_CONN')           != 0 THEN TO_VARCHAR(C.PARENT_CONNECTION_ID)   ELSE MAP(BI.PAR_CONN_ID, -1, 'any', TO_VARCHAR(BI.PAR_CONN_ID))      END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'QUEUEING')           != 0 THEN TO_VARCHAR(T.JOB_QUEUEING)           ELSE MAP(BI.JOB_QUEUEING, '%', 'any', BI.JOB_QUEUEING)               END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN T.STATEMENT_HASH                     ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ROOT')               != 0 THEN T.ROOT_STATEMENT_HASH                ELSE MAP(BI.ROOT_STATEMENT_HASH, '%', 'any', BI.ROOT_STATEMENT_HASH) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN SUBSTR(ST.STATEMENT_STRING, 1, 4000) ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')            != 0 THEN T.DB_USER                            ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                         END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')           != 0 THEN T.APP_NAME                           ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                       END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')           != 0 THEN T.APP_USER                           ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                       END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')         != 0 THEN T.APP_SOURCE                         ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_COMP_NAME')      != 0 THEN T.APP_COMP_NAME                      ELSE MAP(BI.APP_COMP_NAME, '%', 'any', BI.APP_COMP_NAME)             END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_COMP_TYPE')      != 0 THEN T.APP_COMP_TYPE                      ELSE MAP(BI.APP_COMP_TYPE, '%', 'any', BI.APP_COMP_TYPE)             END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')        != 0 THEN T.THREAD_TYPE                        ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')       != 0 THEN T.THREAD_STATE                       ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD')      != 0 THEN T.THREAD_METHOD                      ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL')      != 0 THEN T.THREAD_DETAIL                      ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')          != 0 THEN TO_VARCHAR(T.THREAD_ID)              ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TRANS_ID')           != 0 THEN TO_VARCHAR(T.TRANS_ID)               ELSE MAP(BI.TRANS_ID, -1, 'any', TO_VARCHAR(BI.TRANS_ID))            END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_IP')          != 0 THEN T.CLIENT_IP                          ELSE MAP(BI.CLIENT_IP, '%', 'any', BI.CLIENT_IP)                     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_PID')         != 0 THEN TO_VARCHAR(T.CLIENT_PID)             ELSE MAP(BI.CLIENT_PID, -1, 'any', TO_VARCHAR(BI.CLIENT_PID))        END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLER')             != 0 THEN T.CALLER                             ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLING')            != 0 THEN T.CALLING                            ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')          != 0 THEN T.LOCK_NAME                          ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCKS_OWNED')        != 0 THEN T.LOCKS_OWNED                        ELSE 'any'                                                           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NUMA_NODE')          != 0 THEN TO_VARCHAR(T.NUMA_NODE)              ELSE MAP(BI.NUMA_NODE, -1, 'any', TO_VARCHAR(BI.NUMA_NODE))          END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION')    != 0 THEN T.PASSPORT_ACTION                    ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)         END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMPONENT') != 0 THEN T.PASSPORT_COMPONENT                 ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_THREAD_LIMIT')  != 0 THEN TO_VARCHAR(T.STATEMENT_THREAD_LIMIT) ELSE MAP(BI.STATEMENT_THREAD_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_THREAD_LIMIT)) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_MEMORY_LIMIT')  != 0 THEN TO_VARCHAR(T.STATEMENT_MEMORY_LIMIT) ELSE MAP(BI.STATEMENT_MEMORY_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_MEMORY_LIMIT)) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'WORKLOAD_CLASS')     != 0 THEN T.WORKLOAD_CLASS_NAME                ELSE MAP(BI.WORKLOAD_CLASS, '%', 'any', BI.WORKLOAD_CLASS)           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')              != 0 OR INSTR(BI.AGGREGATE_BY, 'HASH') != 0
                                                                                            THEN IFNULL(HTM.TABLE_NAMES, '')          ELSE MAP(BI.TABLE_NAMES, '%', 'any', BI.TABLE_NAMES)                 END,
    BI.ORDER_BY,
    BI.AGGREGATION_TYPE
)
ORDER BY
  ACTIVE DESC,
  MAP(ORDER_BY, 'THREAD_ID',   THREAD_ID),
  MAP(ORDER_BY, 'CONNECTION', HOST || CONN_ID || CONN_HIERARCHY),
  MAP(ORDER_BY, 'THREADS', NUM, 'MEMORY', MEM_USED_GB, 'DURATION', DURATION_MS) DESC,
  THREAD_ID,
  LOG_CONN_ID,
  PAR_CONN_ID,
  CONN_ID

