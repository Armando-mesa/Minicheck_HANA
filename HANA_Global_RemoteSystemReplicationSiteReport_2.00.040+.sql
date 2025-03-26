WITH 

/*

[NAME]

- HANA_Global_RemoteSystemReplicationSiteReport_2.00.040+

[DESCRIPTION]

- Collection of information of a remote system replication site

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- May result in crashes on SAP HANA 2.00.042 - 2.00.043 (bug 229039)
- <replace_with_remote_site_schema> needs to be globally replaced in this analysis command with the 
  proxy schema name of the remote system replication site
- Proxy schemas are available in system replication environments starting with SAP HANA 1.00.110
- _SYS_SR_SITE_<site>.M_OUT_OF_MEMORY_EVENTS available with SAP HANA >= 1.00.120
- Schema name follows naming convention _SYS_SR_SITE_<remote_site>
- M_SERVICE_THREAD_SAMPLES and BLOCKING_PHASE_DURATION available with SAP HANA >= 2.00.000
- M_HOST_AGENT_METRICS available in proxy schema starting with SAP HANA >= 2.00.040
- Existing proxy schemas can be determined via:

  SELECT SCHEMA_NAME FROM SCHEMAS WHERE SCHEMA_NAME LIKE '_SYS_SR_SITE%'

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2019/07/17:  1.0 (initial version)
- 2019/07/27:  1.1 (dedicated 2.00.040+ version including host agent information)

[INVOLVED TABLES]

- M_DELTA_MERGE_STATISTICS
- M_HEAP_MEMORY
- M_HOST_AGENT_METRICS
- M_NUMA_NODES
- M_OUT_OF_MEMORY_EVENTS
- M_SAVEPOINTS
- M_SERVICE_THREAD_SAMPLES
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
|******************************                                                                                                                                                                                                                                 |
|* SAP HANA TIME FRAME REPORT *                                                                                                                                                                                                                                 |
|******************************                                                                                                                                                                                                                                 |
|                                                                                                                                                                                                                                                               |
|Generated with:     SQL: "HANA_Global_RemoteSystemReplicationSiteReport" (SAP Note 1969700)                                                                                                                                                                    |
|Analysis time:      2019/07/17 10:56:44                                                                                                                                                                                                                        |
|Database name:      BGP                                                                                                                                                                                                                                        |
|Revision level:     2.00.035.00.1545187853                                                                                                                                                                                                                     |
|Proxy schema:       <replace_with_remote_site_schema>                                                                                                                                                                                                          |
|Host:               all                                                                                                                                                                                                                                        |
|Port:               all                                                                                                                                                                                                                                        |
|                                                                                                                                                                                                                                                               |
|******************                                                                                                                                                                                                                                             |
|* THREAD SAMPLES *                                                                                                                                                                                                                                             |
|******************                                                                                                                                                                                                                                             |
|                                                                                                                                                                                                                                                               |
|SAMPLE_TIME         HOST        PORT    CONN_ID THREAD_ID DUR_S CPU_S THREAD_TYPE           STATE          LOCK_NAME                      STATEMENT_HASH                                   THREAD_METHOD                           A A A THREAD_DETAIL         |
|=================== ========== ===== ========== ========= ===== ===== ===================== ============== ============================== ================================================ ======================================= = = = ===================== |
|2019/07/17 10:56:43 saphana001 32403         -1     22098   359     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:42 saphana001 32403         -1     22098   358     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:41 saphana001 32403         -1     22098   357     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:40 saphana001 32403         -1     22098   356     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:39 saphana001 32403         -1     22098   355     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:38 saphana001 32403         -1     22098   354     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:37 saphana001 32403         -1     22098   353     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:36 saphana001 32403         -1     21161 16767 10244 ContinuousPageFlusher Running        #                              no SQL (flushing)                                flushing                                # # # #                     |
|2019/07/17 10:56:36 saphana001 32403         -1     22098   352     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:35 saphana001 32403         -1     21161 16767 10243 ContinuousPageFlusher Running        #                              no SQL (flushing)                                flushing                                # # # #                     |
|2019/07/17 10:56:35 saphana001 32403         -1     22098   351     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:34 saphana001 32403         -1     21161 16766 10242 ContinuousPageFlusher Running        #                              no SQL (flushing)                                flushing                                # # # #                     |
|2019/07/17 10:56:34 saphana001 32403         -1     22098   350     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:33 saphana001 32403         -1     21161 16766 10241 ContinuousPageFlusher Running        #                              no SQL (flushing)                                flushing                                # # # #                     |
|2019/07/17 10:56:33 saphana001 32403         -1     22098   349     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:32 saphana001 32403         -1     21161 16766 10240 ContinuousPageFlusher Running        #                              no SQL (flushing)                                flushing                                # # # #                     |
|2019/07/17 10:56:32 saphana001 32403         -1     22098   348     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:31 saphana001 32403         -1     22098   347     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:30 saphana001 32403         -1     22098   346     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
|2019/07/17 10:56:29 saphana001 32403         -1     22098   345     0 JobWorker             Semaphore Wait StartSecondExclusiveMergePhase no SQL (MergeDuringRecoveryJob_DeltaToMainMerge) MergeDuringRecoveryJob_DeltaToMainMerge # # # Table: BGP::SAPBGP:TM |
...
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
            T.*,
            T.LOCK_WAIT_NAME LOCK_NAME
          FROM
            "<replace_with_remote_site_schema>".M_SERVICE_THREAD_SAMPLES T
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
    ( TOP_N_THREADS = -1 or ROWNO <= TOP_N_THREADS )
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
    "<replace_with_remote_site_schema>".M_HEAP_MEMORY H
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
    "<replace_with_remote_site_schema>".M_OUT_OF_MEMORY_EVENTS O
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
      "<replace_with_remote_site_schema>".M_SAVEPOINTS S
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
      ROW_NUMBER() OVER (ORDER BY O.START_TIME, O.HOST, O.PORT, O.SCHEMA_NAME, O.TABLE_NAME) ROWNO,
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
      "<replace_with_remote_site_schema>".M_DELTA_MERGE_STATISTICS O
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
    "<replace_with_remote_site_schema>".M_VOLUME_IO_TOTAL_STATISTICS_RESET I
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
      "<replace_with_remote_site_schema>".M_HOST_AGENT_METRICS
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
      "<replace_with_remote_site_schema>".M_HOST_AGENT_METRICS
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
          "<replace_with_remote_site_schema>".M_NUMA_NODES
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
      "<replace_with_remote_site_schema>".M_HOST_AGENT_METRICS C
    WHERE
      C.HOST LIKE BI.HOST AND
      C.MEASURED_ELEMENT_TYPE = 'OperatingSystem'
    GROUP BY
      C.HOST
  )
)
SELECT MAP(BI.LINE_LENGTH, -1, LINE, SUBSTR(LINE, 1, LINE_LENGTH)) LINE FROM BASIS_INFO BI, ( 
SELECT       5 LINE_NO, '**************************************************' LINE FROM DUMMY
UNION ALL SELECT    10, '* SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *' FROM DUMMY
UNION ALL SELECT    20, '**************************************************' FROM DUMMY
UNION ALL SELECT    30, '' FROM DUMMY
UNION ALL SELECT    90, RPAD('Generated with:', 27) || 'SQL: "HANA_Global_RemoteSystemReplicationSiteReport" (SAP Note 1969700)' FROM DUMMY
UNION ALL SELECT   100, RPAD('Analysis time:',  27) || TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS')                    FROM DUMMY
UNION ALL SELECT   125, RPAD('System ID / database name:', 27) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME      FROM M_DATABASE
UNION ALL SELECT   127, RPAD('Revision level:', 27) || VERSION                                                                   FROM M_DATABASE
UNION ALL SELECT   128, RPAD('Proxy schema:',   27) || '<replace_with_remote_site_schema>'                                       FROM DUMMY
UNION ALL SELECT   130, RPAD('Host:',           27) || MAP(HOST, '%', 'all', HOST)                                               FROM BASIS_INFO
UNION ALL SELECT   140, RPAD('Port:',           27) || MAP(PORT, '%', 'all', PORT)                                               FROM BASIS_INFO
UNION ALL SELECT  1000, '' FROM DUMMY
UNION ALL SELECT  1010, '******************' FROM DUMMY
UNION ALL SELECT  1020, '* THREAD SAMPLES *' FROM DUMMY
UNION ALL SELECT  1030, '******************' FROM DUMMY
UNION ALL SELECT  1040, '' FROM DUMMY
UNION ALL SELECT  1050, RPAD('SAMPLE_TIME', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) ||
  LPAD('CONN_ID', 10) || CHAR(32) || LPAD('THREAD_ID', 9) || CHAR(32) || LPAD('DUR_S', 5) || CHAR(32) || LPAD('CPU_S', 5) || CHAR(32) ||
  RPAD('THREAD_TYPE', THREAD_TYPE_LEN) || CHAR(32) || RPAD('STATE', THREAD_STATE_LEN ) || CHAR(32) || RPAD('LOCK_NAME', LOCK_NAME_LEN) || CHAR(32) || RPAD('STATEMENT_HASH', STATEMENT_HASH_LEN) || CHAR(32) ||
  RPAD('THREAD_METHOD', THREAD_METHOD_LEN) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || RPAD('APP_NAME', APP_NAME_LEN) || CHAR(32) || 
  RPAD('APP_SOURCE', APP_SOURCE_LEN) || CHAR(32) || RPAD('THREAD_DETAIL', THREAD_DETAIL_LEN)
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM THREADS )
UNION ALL SELECT  1060, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', THREAD_TYPE_LEN, '=') || CHAR(32) || RPAD('=', THREAD_STATE_LEN, '=') || CHAR(32) || RPAD('=', LOCK_NAME_LEN, '=') || CHAR(32) || RPAD('=', STATEMENT_HASH_LEN, '=') || CHAR(32) ||
  RPAD('=', THREAD_METHOD_LEN, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_NAME_LEN, '=') || CHAR(32) || 
  RPAD('=', APP_SOURCE_LEN, '=') || CHAR(32) || RPAD('=', THREAD_DETAIL_LEN, '=')
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM THREADS )
UNION ALL
SELECT
  1070 + ROW_NUMBER() OVER (ORDER BY SAMPLE_TIME DESC, HOST, PORT, CONN_ID, THREAD_ID),
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
UNION ALL SELECT 20000, '' FROM DUMMY
UNION ALL SELECT 20010, '******************' FROM DUMMY
UNION ALL SELECT 20020, '* MEMORY DETAILS *' FROM DUMMY
UNION ALL SELECT 20030, '******************' FROM DUMMY
UNION ALL SELECT 20040, '' FROM DUMMY
UNION ALL SELECT 20050, RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) || RPAD('HEAP_ALLOCATOR', H.HEAP_ALLOCATOR_LEN) || CHAR(32) ||
  LPAD('MEM_USED_GB', 11) || CHAR(32) || LPAD('COUNT', 5) || CHAR(32) ||
  RPAD('COMPONENT', 40) FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL SELECT 20060, RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  RPAD('=', H.HEAP_ALLOCATOR_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) ||
  RPAD('=', 40, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM HEAP_ALLOCATORS ) H
UNION ALL
SELECT
  20100 + ROW_NUMBER () OVER (ORDER BY H.HOST, H.PORT, H.MEM_USED_GB DESC),
  RPAD(H.HOST, HOST_LEN) || CHAR(32) || LPAD(H.PORT, 5) || CHAR(32) ||
  RPAD(H.HEAP_ALLOCATOR, H.HEAP_ALLOCATOR_LEN) || CHAR(32) || LPAD(H.MEM_USED_GB, 11) || CHAR(32) || LPAD(H.COUNT, 5) || CHAR(32) ||
  H.COMPONENT
FROM
  BASIS_INFO BI,
  HEAP_ALLOCATORS H
UNION ALL SELECT 20500, '' FROM DUMMY
UNION ALL SELECT 20550, RPAD('TIMESTAMP', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PORT', 5) || CHAR(32) ||
  RPAD('STATEMENT_HASH', 32) || CHAR(32) || RPAD('EVENT_REASON', 32) || CHAR(32) || LPAD('USED_GB', 10) || CHAR(32) || LPAD('REQUESTED_GB', 12)
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM OOM_EVENTS ) O
UNION ALL SELECT 20560, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || 
  RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=')
  FROM BASIS_INFO, ( SELECT TOP 1 * FROM OOM_EVENTS ) O
UNION ALL
SELECT
  20600 + ROW_NUMBER () OVER (ORDER BY O.TIMESTAMP, O.HOST, O.PORT),
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
UNION ALL SELECT 1000000, '' FROM DUMMY
UNION ALL SELECT 1000010, '*********************************************************' FROM DUMMY
UNION ALL SELECT 1000020, '* END OF SAP HANA REMOTE SYSTEM REPLICATION SITE REPORT *' FROM DUMMY
UNION ALL SELECT 1000030, '*********************************************************' FROM DUMMY
)
ORDER BY
  LINE_NO