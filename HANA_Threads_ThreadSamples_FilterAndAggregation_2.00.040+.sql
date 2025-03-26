WITH

/*
[NAME]

HANA_Threads_ThreadSamples_FilterAndAggregation_2.00.040+

[DESCRIPTION]

- Filtering and aggregation of thread sample histories

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_SERVICE_THREAD_SAMPLES included
- HOST_SERVICE_THREAD_SAMPLES.DURATION only available as of Rev. 1.00.80
- Columns CALLER and CALLING of HOST_SERVICE_THREAD_SAMPLES available as of Rev. 1.00.100
- M_SERVICE_THREAD_SAMPLES.STATEMENT_EXECUTION_ID available as of Rev. 1.00.120
- HOST_SERVICE_THREAD_SAMPLES.STATEMENT_EXECUTION_ID available with 1.00.122.05 and 2.00.001
- LOCKS_OWNED available with 1.00.122.08 and 2.00.002
- NUMA_NODE_INDEX and ROOT_STATEMENT_HASH available starting with SAP HANA 2.00.040

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2014/03/11:  1.0 (initial version)
- 2014/09/24:  1.1 (THREAD_DETAIL included)
- 2015/04/29:  1.2 (CLIENT_IP and DB_USER included)
- 2015/10/20:  1.3 (dedicated Rev100+ version, CALLER and CALLING included)
- 2016/01/14:  1.4 (STATEMENT_ID included)
- 2017/02/03:  1.5 (EXCLUDE_PHANTOM_THREADS included)
- 2017/03/09:  1.6 (dedicated Rev. 1.00.120+ version)
- 2017/05/23:  1.7 (more flexible aggregation options)
- 2017/07/01:  1.8 (dedicated Rev. 1.00.122.08+ version)
- 2017/10/27:  1.9 (TIMEZONE included)
- 2017/10/30:  2.0 (RESULT_ROWS added)
- 2018/02/06:  2.1 (MIN_SAMPLES included)
- 2018/02/07:  2.2 (EXCLUDE_EMPTY_STATEMENT_IDS and EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS included)
- 2018/11/06:  2.3 (ONLY_FULL_SCAN_METHODS added)
- 2018/12/02:  2.4 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2018/12/07:  2.5 (RESULT_ROWS removed, OTHERS_MAX_PCT added)
- 2019/05/14:  2.6 (dedicated 2.00.040+ version including NUMA_NODE)
- 2019/07/13:  2.7 (ROOT_STATEMENT_HASH included)
- 2020/07/02:  2.8 (STATEMENT_THREAD_LIMIT added)
- 2020/07/16:  2.9 (JOB_QUEUEING / Q added)
- 2021/01/04:  3.0 (TRANS_ID added)
- 2021/05/04:  3.1 (ONLY_TABLE_OPTIMIZATIONS included)
- 2021/06/10:  3.2 (output column R included to mark statements with recommendations in SAP Note 2000002)
- 2021/09/11:  3.3 (PASSPORT related information included)
- 2022/01/30:  3.4 (TABLE_NAME included)
- 2022/10/23:  3.5 (STATEMENT_MEMORY_LIMIT included included)
- 2023/08/03:  3.6 (ONLY_EXTERNAL_CONNECTIONS included and CONN_ID semantics for -1 changed)
- 2023/11/15:  3.7 (redesign of TABLE_NAME(S) output column including TOP_TABLE_COUNT and MIN_TOP_TABLE_SIZE_MB filters)
- 2024/03/14:  3.8 (inclusion of other characteristics in TABLE_NAMES like backup or procedure calls)

[INVOLVED TABLES]

- GLOBAL_TABLE_PERSISTENCE_STATISTICS
- HOST_SERVICE_THREAD_SAMPLES
- HOST_SQL_PLAN_CACHE
- M_EXPENSIVE_STATEMENTS
- M_SERVICE_THREAD_SAMPLES
- M_SQL_PLAN_CACHE
- M_TABLE_PERSISTENCE_STATISTICS

[INPUT PARAMETERS]

- BEGIN_TIME

  Begin time

  '2018/12/05 14:05:00' --> Set begin time to 5th of December 2018, 14:05
  'C'                   --> Set begin time to current time
  'C-S900'              --> Set begin time to current time minus 900 seconds
  'C-M15'               --> Set begin time to current time minus 15 minutes
  'C-H5'                --> Set begin time to current time minus 5 hours
  'C-D1'                --> Set begin time to current time minus 1 day
  'C-W4'                --> Set begin time to current time minus 4 weeks
  'E-S900'              --> Set begin time to end time minus 900 seconds
  'E-M15'               --> Set begin time to end time minus 15 minutes
  'E-H5'                --> Set begin time to end time minus 5 hours
  'E-D1'                --> Set begin time to end time minus 1 day
  'E-W4'                --> Set begin time to end time minus 4 weeks
  'MIN'                 --> Set begin time to minimum (1000/01/01 00:00:00)

- END_TIME

  End time

  '2018/12/08 14:05:00' --> Set end time to 8th of December 2018, 14:05
  'C'                   --> Set end time to current time
  'C-S900'              --> Set end time to current time minus 900 seconds
  'C-M15'               --> Set end time to current time minus 15 minutes
  'C-H5'                --> Set end time to current time minus 5 hours
  'C-D1'                --> Set end time to current time minus 1 day
  'C-W4'                --> Set end time to current time minus 4 weeks
  'B+S900'              --> Set end time to begin time plus 900 seconds
  'B+M15'               --> Set end time to begin time plus 15 minutes
  'B+H5'                --> Set end time to begin time plus 5 hours
  'B+D1'                --> Set end time to begin time plus 1 day
  'B+W4'                --> Set end time to begin time plus 4 weeks
  'MAX'                 --> Set end time to maximum (9999/12/31 23:59:59)

- TIMEZONE

  Used timezone (both for input and output parameters)

  'SERVER'       --> Display times in SAP HANA server time
  'UTC'          --> Display times in UTC time

- HOST

  Host name

  'saphana01'    --> Specific host saphana01
  'saphana%'     --> All hosts starting with saphana
  '%'            --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

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

- THREAD_DETAIL

  Thread detail information (e.g. SQL text)

  '%insert%'      --> Only thread details containing 'insert'
  '%'             --> No thread detail restriction

- STATEMENT_HASH

  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction (only possible if hash is not mandatory)

- ROOT_STATEMENT_HASH

  Root statement hash (e.g. hash of procedure responsible for statement execution)

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> Root statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No root statement hash restriction

- STATEMENT_THREAD_LIMIT

  Statement thread limit

  24                --> List threads belonging to a workload class with a limitation to 24 threads
  -1                --> No restriction related to statement thread limit

- STATEMENT_MEMORY_LIMIT

  Statement memory limit

  100               --> List threads with a limitation to 100 GB of memory
  -1                --> No restriction related to statement memory limit

- STATEMENT_ID

  Statement ID (identical for same statement on same connection, otherwise different)

  '859110927564988' --> Only display samples with statement ID 859110927564988
  '%'               --> No restriction related to statement ID

- STATEMENT_EXECUTION_ID

  Statement execution ID (generally varies for different executions of same statement hash)

  '562958564492543' --> Only display samples with statement execution ID 562958564492543
  '%'               --> No restriction related to statement ID

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

- LOCK_NAME

  Lock name

  'transLock'     --> Display threads waiting for transLock
  '%'             --> No restriction related to lock waits

- LOCKS_OWNED

  Locks held by the thread

  'transLock'     --> Display threads holding the transLock
  '%'             --> No restriction related to locks held

- NUMA_NODE

  Numa node

  5               --> Display threads running on NUMA node 5
  -1              --> No restriction related to NUMA node

- CLIENT_IP

  IP address of client

  '172.23.4.12'   --> IP address 172.23.4.12
  '%'             --> No restriction related to IP address

- CLIENT_PID

  Client process ID

  10264           --> Client process ID 10264
  -1              --> No client process ID restriction

- CONN_ID

  Connection ID

  330655          --> Connection ID 330655
  -2              --> No connection ID restriction
  -1              --> Internal connections (having CONN_ID = -1)

- ONLY_EXTERNAL_CONNECTIONS

  Possibility to restrict result to external connections (with CONN_ID > 0)

  'X'             --> Only display external connections
  ' '             --> Consider both external and internal connections

- PASSPORT_COMPONENT

  Passport component

  'P24/sapabap01_P24_27' --> Passport component P24/sapabap01_P24_27
  '%'                    --> No restriction related to passport component

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

- PASSPORT_ACTION

  Passport action

  'SAPMSSY1'      --> Passport action SAPMSSY1
  '%'             --> No restriction related to passport action

- JOB_QUEUEING

  Job queueing state

  'X'             --> Thread currently waits for assignment of JobWorker (THREAD_STATE = 'Job Exec Waiting', CALLING = '')
  ' '             --> Thread does not wait for JobWorker assignment

- MIN_DURATION_MS

  Minimum duration time in milli seconds

  100             --> Minimum duration time of 100 ms
  -1              --> No restriction of minimum duration time

- OTHERS_MAX_PCT

  Maximum threshold for "-- Others --" summary (i.e. entries with smaller percentage for related timestamp are summarized under "-- Others --"

  5               --> Summarize all results with <= 5 % of samples for timestamp under "-- Others --"
  -1              --> No summarization under "-- Others --"

- MIN_SAMPLES

  Minimum number of samples to be displayed in the result

  5               --> Only show lines represented by at least 5 samples
  -1              --> No restriction based on number of samples

- SQL_TEXT_LENGTH

  Maximum displayed size of SQL statement text

  50              --> SQL text is truncated to 50 characters
  -1              --> No SQL text size limitation

- ONLY_DELTA_STORAGE_WAITS

  Possibility to restrict results to delta storage related states / locks (e.g. "BTree GuardContainer")

  'X'             --> Only display samples with methods linked to delta storage waits
  ' '             --> No restriction related to delta storage waits

- ONLY_FULL_SCAN_METHODS

  Possibility to restrict results to full (column or table) scan activities

  'X'             --> Only display samples with methods linked to full scans
  ' '             --> No restriction related to full scans

- ONLY_TABLE_OPTIMIZATIONS

  Possibility to restrict the output to threads involved in table optimizations (delta merges, optimize compression)

  'X'             --> Only display samples related to table optimizations
  ' '             --> No restriction related to table optimizations

- EXCLUDE_SERVICE_THREAD_SAMPLER

  Possibility to ignore samples related to service thread sampling

  'X'             --> Samples related to service thread sampling are not shown
  ' '             --> All samples are displayed

- EXCLUDE_NEGATIVE_THREAD_IDS

  Possibility to ignore samples related to negative thread IDs

  'X'             --> Samples related to negative thread IDs are ignored
  ' '             --> All samples are displayed

- EXCLUDE_PHANTOM_THREADS

  Possibility to exclude idle threads that are shown as "active" due to SAP HANA bugs

  'X'             --> Do not show idle threads that are shown as active threads
  ' '             --> No restriction of displayed threads

- EXCLUDE_EMPTY_STATEMENT_IDS

  Possibility to skip all samples with an empty STATEMENT_ID

  'X'             --> Only consider samples with a populated STATEMENT_ID
  ' '             --> Show all samples regardless of STATEMENT_ID

- EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS

  Possibility to skip all samples with an empty STATEMENT_EXECUTION_ID

  'X'             --> Only consider samples with a populated STATEMENT_EXECUTION_ID
  ' '             --> Show all samples regardless of STATEMENT_EXECUTION_ID

- DURATION_AGGREGATION_TYPE

  Type of aggregation (e.g. MAX, AVG, SUM)

  'AVG'           --> Determination of average values
  'MAX'           --> Determination of maximum values
  'SUM'           --> Determination of total values

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'TIME'          --> Aggregation by sample time
  'HOST, PORT'    --> Aggregation by host and port
  '%'             --> No aggregation, pure filtering

- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'TIME'          --> Sorting by time

[OUTPUT PARAMETERS]

- SAMPLE_TIME:         Sample timestamp
- SAMPLES:             Number of samples
- PCT:                 Percent of samples (per SAMPLE_TIME)
- ACTIVE_S:            Thread duration (s), value is aggregated based on DURATION_AGGREGATION_TYPE
- ST:                  System replication site ID
- HOST:                Host name
- PORT:                Port
- NM:                  NUMA node (-2 in case of NULL)
- STL:                 Statement thread limit
- SML:                 Statement memory limit
- CONN_ID:             Connection identifier
- THREAD_ID:           Thread identifier
- TABLE_NAMES:         Name and size of accessed tables (if available) other other specific activities, expensive operation, so deactivated per default 
                       (remove "AND 1 = 0" at three locations below to include this information)
- R:                   'X' if a recommendation for the statement hash or involved table / procedure is available in SAP Note 2000002, otherwise ' '
- THREAD_TYPE:         Thread type
- THREAD_METHOD:       Thread method
- THREAD_STATE:        Thread state
- Q:                   'X' in case thread waits for availability of JobWorker (THREAD_STATE = 'Job Exec Waiting', CALLING = '')
- LOCK_NAME:           Lock name
- STATEMENT_HASH:      Statement hash
- THREAD_DETAIL:       Thread detail
- DB_USER:             Database user
- APP_NAME:            Application name
- APP_USER:            Application user
- APP_SOURCE:          Application source
- PASSPORT_COMPONENT:  Passport component
- PASSPORT_ACTION:     Passport action
- CLIENT_IP:           IP address of client
- CLIENT_PID:          Client process ID
- STAT_EXEC_ID:        Statement execution ID
- BLK_THREAD:          Blocking thread
- LOCKS_OWNED:         Locks owned by the thread
- CALLER:              Caller thread (i.e. thread that has triggered the current thread)
- CALLING:             Called thread (i.e. threads that are triggered by current thread)
- STATEMENT_ID:        Statement ID
- ROOT_STATEMENT_HASH: Root statement hash (e.g. procedure call)
- TRANS_ID:            Transaction ID
- SQL_TEXT:            SQL statement text (currently disabled)
- YEAR:                Sample year
- MONTH:               Sample month
- DAY:                 Sample day
- HOUR:                Sample hour
- DURATION_H:          Duration (h)
- DURATION_MIN:        Duration (minutes)
- DURATION_MS:         Duration (ms)

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
|NM|STL|SML |ACTIVE_S|CONN_ID|THREAD_ID|TABLE_NAME      |R|THREAD_TYPE    |THREAD_METHOD        |THREAD_STATE    |Q|LOCK_NAME                    |STATEMENT_HASH                  |THREAD_DETAIL
|DB_USER|APP_NAME       |APP_USER    |APP_SOURCE                            |PASSPORT_COMPONENT |PASSPORT_ACTION                 |CALLER|CALLING               |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
| 1|  0|   0|     208|     -1|   139068|                | |MergedogMerger |merging              |Job Exec Waiting| |JobBarrier Wait for Jobs     |no SQL (merging)                |61 of 63 table(s): SAPC11:_SYS_SPLIT_EDID4~11
|#      |MergedogMerger |#           |MergedogMerger                        |                   |                                |415443|207480                |
| 2|  0|   0|     208|     -1|   139099|                | |MergedogMerger |merging              |Job Exec Waiting| |JobBarrier Wait for Jobs     |no SQL (merging)                |63 of 63 table(s): SAPC11:_SYS_SPLIT_EDID4~8
|#      |MergedogMerger |#           |MergedogMerger                        |                   |                                |415443|205137                |
| 1|  0|   0|     384|     -1|   196901|                | |JobWorker      |GCJob                |Running         | |#                            |no SQL (GCJob)                  |GCJob[0x26076d000a1618dc-EID, CleanupFileExecutedByGC, TS= 130561839540,
compareTS= 0, TID= 93089815805, transIndex= 2087651, CleanupStrategy_MVCC, pagecnt=1, rawsize=4096]@0x00007f554d3c7400                                                                |#      |JobWorker      |#           |JobWorker
|                   |                                |30563 |                      |
| 7|  0|   0|     204|     -1|   198441|                | |JobWorker      |prepareDeltaMergeSave|Running         | |#                            |no SQL (prepareDeltaMergeSave)  |IndexName: SAPC11:_SYS_SPLIT_EDID4~14 Attribute: 210/$trexexternalkey$
|#      |JobWorker      |#           |JobWorker                             |                   |                                |415436|                      |
| 1|  0|   0|     197|     -1|   205137|                | |JobWorker      |prepareDeltaMergeSave|Running         | |#                            |no SQL (prepareDeltaMergeSave)  |IndexName: SAPC11:_SYS_SPLIT_EDID4~8 Attribute: 210/$trexexternalkey$
|#      |JobWorker      |#           |JobWorker                             |                   |                                |139099|                      |
| 4|  0|   0|     204|     -1|   207480|                | |JobWorker      |prepareDeltaMergeSave|Running         | |#                            |no SQL (prepareDeltaMergeSave)  |IndexName: SAPC11:_SYS_SPLIT_EDID4~11 Attribute: 210/$trexexternalkey$
|#      |JobWorker      |#           |JobWorker                             |                   |                                |139068|                      |
| 1|  0|   0|     172|     -1|   208837|                | |JobWorker      |JobWorker            |Running         | |#                            |no SQL (JobWorker)              |JobWorker
|#      |JobWorker      |#           |JobWorker                             |                   |                                |      |                      |
| 4|  0|   0|     208|     -1|   415436|                | |MergedogMerger |merging              |Job Exec Waiting| |JobBarrier Wait for Jobs     |no SQL (merging)                |62 of 63 table(s): SAPC11:_SYS_SPLIT_EDID4~14
|#      |MergedogMerger |#           |MergedogMerger                        |                   |                                |415443|198441                |
| 7|  0|   0|   52238|     -1|   415443|                | |MergedogMonitor|joining              |Semaphore Wait  | |MergedogMerger CompletionWait|no SQL (joining)                |waiting for merge threads to complete
|#      |MergedogMonitor|#           |MergedogMonitor                       |                   |                                |      |415436, 139099, 139068|
| 1|  0|   0|     248|     -1|   419011|                | |SqlExecutor    |NoAction             |Running         | |#                            |no SQL (NoAction)               |NoAction
|#      |SqlExecutor    |#           |SqlExecutor                           |C11/saphana3_C11_33|FARR_CONTR0700112210232#00006   |      |                      |
| 4| 56| 300|       0| 300048|   139251|/1RA/0SD034CO   | |SqlExecutor    |ExecutePrepared      |Running         | |#                            |9feecb4e4e438fcedc164517a32e3e33|SELECT DISTINCT  "MANDT" , "KEYPP" , "SRCDOC_COMP" , "SRCDOC_LOGSYS" ,
"SRCDOC_TYPE" , "SRCDOC_ID" , "CONDITION_TYPE" , "TIMESTAMP_UTC" , "PL_ACCOUNT" , "GL_ACCOUNT" , "BETRW" , "WAERS" , "BETRH" , "HWAER" , "BETR2" , "HWAE2" , "BETR3" , "HWAE3" , "PERCEN|SAPC11 |ABAP:C11       |BWP_BW
|CL_FARR_RAI_SELECTION=========CP:10187|C11/saphana3_C11_33|BIREQU_9S1FJ2VXPBUAKXJUXBOCF5F6V|      |                      |
| 1|  0|   0|       0| 307823|   139272|                | |SqlExecutor    |ExecutePrepared      |Running         | |#                            |no SQL (ExecutePrepared)        |SELECT TOP 1 "MANDT" , "NAME" , "TYPE" , "USERNAME" , "HASH" , "OBJECT" ,
"FORUSER" , "RC" , "REASON" , "REASON2" , "REASON3" , "REASON4" , "REASON5" , "CDS" , "FIELD1" , "FIELD2" , "FIELD3" , "FIELD4" , "FIELD5" , "FIELD6" , "FIELD7" , "FIELD8" , "FIELD9|SAPC11 |ABAP:C11       |HCS_REMOTE  |/1LT/SAPLHCS001000000149717:0
|C12/hanaci_C12_15  |/1LT/IUC_LOAD_MT_049_003        |      |                      |
| 1| 56| 300|       0| 308429|   139241|FARR_ATTAHLORIPR| |SqlExecutor    |ExecutePrepared      |Running         | |#                            |3377dcc12da344f9e1a3fa96c59dc60d|SELECT DISTINCT  "PROP_NAME" , "OBJECT_ID" FROM "FARR_ATTAHLORIPR" WHERE
"PROP_NAME" = # AND "IO_CLASS" = # AND "PROP_SECI" = # AND "PROP_VALUE" = #  WITH RANGE_RESTRICTION('CURRENT')                                                                        |SAPC11 |ABAP:C11       |WF_BATCH_BGR|SAPLSDCL:70286
|C11/saphana1_ISP_33|FARR_CONTR0700112210232#00004   |      |                      |
| 6| 56| 300|       0| 308602|   139267|ZZV_X_SA_SISKODR| |SqlExecutor    |ExecutePrepared      |Running         | |#                            |3c5466cc9d6d6e463e6e763fa8731e8a|SELECT "MANDT" , "GUID" , "COUNTER" , "REF_GUID" , "USID" , "TID" ,
"MSG_GUID" , "FILENAME" FROM "ZZV_D_SA_SISKODR" WHERE "MANDT" = # AND "GUID" = # LIMIT 1  WITH RANGE_RESTRICTION('CURRENT')                                                                |SAPC11 |ABAP:C11
|ZV_ARIBA_O2C|ZCL_ZV_SA_PROC_PACK_MANAGER===CP:589  |C11/saphana1_C11_33|Z1SA20221023AR_08_00001         |      |                      |
| 1| 36| 200|       0| 308755|   139458|NAST            | |SqlExecutor    |ExecQidItab          |Job Exec Waiting|X|JobBarrier Wait for Jobs     |e1e746510efab6b3c433909529143774|SELECT "MANDT" , "KAPPL" , "OBJKY" , "KSCHL" , "SPRAS" , "PARNR" , "PARVW" ,
"ERDAT" , "ERUHR" , "ADRNR" , "NACHA" , "ANZAL" , "VSZTP" , "VSDAT" , "VSURA" , "VSURB" , "MANUE" , "DATVR" , "UHRVR" , "DATRE" , "USNAM" , "VSTAT" , "AKTIV"                     |SAPC11 |ABAP:C11       |SD_BATCH    |SAPFV45P:7989
|C11/saphana8_C11_33|0213_QDU_ZC_UPD_SO_RR_EMEAMEEAG1|      |                      |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT
    CASE
      WHEN BEGIN_TIME =    'C'                             THEN CURRENT_TIMESTAMP
      WHEN BEGIN_TIME LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME, 'C-S'))
      WHEN BEGIN_TIME LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME, 'C-M') * 60)
      WHEN BEGIN_TIME LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME, 'C-H') * 3600)
      WHEN BEGIN_TIME LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME, 'C-D') * 86400)
      WHEN BEGIN_TIME LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME, 'C-W') * 86400 * 7)
      WHEN BEGIN_TIME LIKE 'E-S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME, 'E-S'))
      WHEN BEGIN_TIME LIKE 'E-M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME, 'E-M') * 60)
      WHEN BEGIN_TIME LIKE 'E-H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME, 'E-H') * 3600)
      WHEN BEGIN_TIME LIKE 'E-D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME, 'E-D') * 86400)
      WHEN BEGIN_TIME LIKE 'E-W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME, 'E-W') * 86400 * 7)
      WHEN BEGIN_TIME =    'MIN'                           THEN TO_TIMESTAMP('1000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
      WHEN SUBSTR(BEGIN_TIME, 1, 1) NOT IN ('C', 'E', 'M') THEN TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS')
    END BEGIN_TIME,
    CASE
      WHEN END_TIME =    'C'                             THEN CURRENT_TIMESTAMP
      WHEN END_TIME LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME, 'C-S'))
      WHEN END_TIME LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME, 'C-M') * 60)
      WHEN END_TIME LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME, 'C-H') * 3600)
      WHEN END_TIME LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME, 'C-D') * 86400)
      WHEN END_TIME LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME, 'C-W') * 86400 * 7)
      WHEN END_TIME LIKE 'B+S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME, 'B+S'))
      WHEN END_TIME LIKE 'B+M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME, 'B+M') * 60)
      WHEN END_TIME LIKE 'B+H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME, 'B+H') * 3600)
      WHEN END_TIME LIKE 'B+D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME, 'B+D') * 86400)
      WHEN END_TIME LIKE 'B+W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME, 'B+W') * 86400 * 7)
      WHEN END_TIME =    'MAX'                           THEN TO_TIMESTAMP('9999/12/31 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
      WHEN SUBSTR(END_TIME, 1, 1) NOT IN ('C', 'B', 'M') THEN TO_TIMESTAMP(END_TIME, 'YYYY/MM/DD HH24:MI:SS')
    END END_TIME,
    TIMEZONE,
    HOST,
    PORT,
    THREAD_ID,
    TRANS_ID,
    THREAD_STATE,
    THREAD_TYPE,
    THREAD_METHOD,
    THREAD_DETAIL,
    STATEMENT_HASH,
    ROOT_STATEMENT_HASH,
    STATEMENT_THREAD_LIMIT,
    STATEMENT_MEMORY_LIMIT,
    STATEMENT_ID,
    STATEMENT_EXECUTION_ID,
    DB_USER,
    APP_NAME,
    APP_USER,
    APP_SOURCE,
    LOCK_NAME,
    NUMA_NODE,
    LOCKS_OWNED,
    CLIENT_IP,
    CLIENT_PID,
    CONN_ID,
    ONLY_EXTERNAL_CONNECTIONS,
    PASSPORT_COMPONENT,
    PASSPORT_ACTION,
    JOB_QUEUEING,
    TABLE_NAMES,
    TOP_TABLE_COUNT,
    MIN_TOP_TABLE_SIZE_MB,
    MIN_DURATION_MS,
    OTHERS_MAX_PCT,
    MIN_SAMPLES,
    SQL_TEXT_LENGTH,
    ONLY_FULL_SCAN_METHODS,
    ONLY_DELTA_STORAGE_WAITS,
    ONLY_TABLE_OPTIMIZATIONS,
    EXCLUDE_SERVICE_THREAD_SAMPLER,
    EXCLUDE_NEGATIVE_THREAD_IDS,
    EXCLUDE_PHANTOM_THREADS,
    EXCLUDE_EMPTY_STATEMENT_IDS,
    EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS,
    DURATION_AGGREGATION_TYPE,
    DATA_SOURCE,
    AGGREGATE_BY,
    MAP(TIME_AGGREGATE_BY,
      'NONE',        'YYYY/MM/DD HH24:MI:SS.FF3',
      'HOUR',        'YYYY/MM/DD HH24',
      'DAY',         'YYYY/MM/DD (DY)',
      'HOUR_OF_DAY', 'HH24',
      TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
    ORDER_BY
  FROM
  ( SELECT                                                      /* Modification section */
      'C-D31' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      'C' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' HOST,
      '%' PORT,
      -1  THREAD_ID,
      -1  TRANS_ID,
      '%' THREAD_STATE,               /* e.g. 'Running', 'Network Read' or 'Semaphore Wait' */
      '%' THREAD_TYPE,                /* e.g. 'SqlExecutor', 'JobWorker' or 'MergedogMonitor' */
      '%' THREAD_METHOD,
      '%' THREAD_DETAIL,
      '%' STATEMENT_HASH,
      '%' ROOT_STATEMENT_HASH,
      -1  STATEMENT_THREAD_LIMIT,
      -1  STATEMENT_MEMORY_LIMIT,
      '%' STATEMENT_ID,
      '%' STATEMENT_EXECUTION_ID,
      '%' DB_USER,
      '%' APP_NAME,
      '%' APP_USER,
      '%' APP_SOURCE,
      '%' LOCK_NAME,
      '%' LOCKS_OWNED,
      -1  NUMA_NODE,
      '%' CLIENT_IP,
      -1  CLIENT_PID,
      -2  CONN_ID,
      ' ' ONLY_EXTERNAL_CONNECTIONS,
      '%' PASSPORT_COMPONENT,
      '%' PASSPORT_ACTION,
      '%' JOB_QUEUEING,
      '%' TABLE_NAMES,                 /* make sure that you remove "1 = 0" three times below, otherwise no table names are provided */
      2  TOP_TABLE_COUNT,
      -1 MIN_TOP_TABLE_SIZE_MB,
      -1  MIN_DURATION_MS,
      -1  OTHERS_MAX_PCT,
      -1  MIN_SAMPLES,
      80  SQL_TEXT_LENGTH,
      ' ' ONLY_FULL_SCAN_METHODS,
      ' ' ONLY_DELTA_STORAGE_WAITS,
      ' ' ONLY_TABLE_OPTIMIZATIONS,
      'X' EXCLUDE_SERVICE_THREAD_SAMPLER,
      'X' EXCLUDE_NEGATIVE_THREAD_IDS,
      'X' EXCLUDE_PHANTOM_THREADS,
      ' ' EXCLUDE_EMPTY_STATEMENT_IDS,
      ' ' EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS,
      'MAX' DURATION_AGGREGATION_TYPE,       /* MAX, AVG, SUM */
      'HISTORY' DATA_SOURCE,           /* CURRENT, HISTORY */
      'NONE' AGGREGATE_BY,                /* TIME, HOST, PORT, THREAD_ID, THREAD_TYPE, THREAD_METHOD, THREAD_STATE, THREAD_DETAIL, HASH, ROOT, STATEMENT_ID, STAT_EXEC_ID, DB_USER, APP_NAME, APP_USER,
                                          APP_SOURCE, CLIENT_IP, CLIENT_PID, CONN_ID, LOCK_NAME, LOCKS_OWNED, BLK_THREAD, CALLER, CALLING, NUMA_NODE, STMT_MEM_LMT, STMT_THR_LMT, QUEUEING, TRANS_ID,
                                          PASSPORT_ACTION, PASSPORT_COMPONENT or comma separated combinations, NONE for no aggregation */
      'NONE' TIME_AGGREGATE_BY,     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
      'TIME' ORDER_BY               /* COUNT, TIME, CONN_ID */
    FROM
      DUMMY
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
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%STATISTICS_SCHEDULABLEWRAPPER%' THEN '-- STATISTICS_SCHEDULABLE_WRAPPER --'
      WHEN STRING_AGG(T.TABLE_NAME) LIKE '%TREXVIADBSL%' THEN '-- TREXVIADBSL --'
      WHEN T.STATEMENT_HASH = '2aebdbfdf69d7dbecbd54e76fe716e5e' THEN '-- ESH_SEARCH --'
      WHEN T.STATEMENT_HASH = '2f0edf3918c670f03f0d0a7865be4b11' THEN '-- SDA_EXECUTION_DEV --'
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
      ( SELECT DISTINCT
          STATEMENT_HASH,
          CNT, LOCATE(AON, '.', 1, CNT), LOCATE(AON, '(', 1, CNT), LOCATE(AON, ', ', 1, CNT),
          CASE CNT
            WHEN 1 THEN SUBSTR(AON, 1, LOCATE(AON, '.', 1, CNT) - 1)
            ELSE SUBSTR(AON, LOCATE(AON, ', ', 1, CNT - 1) + 2, LOCATE(AON, '.', 1, CNT) - LOCATE(AON, ', ', 1, CNT - 1) - 2)
          END SCHEMA_NAME,
          SUBSTR(AON, LOCATE(AON, '.', 1, CNT) + 1, LOCATE(AON, '(', 1, CNT) - LOCATE(AON, '.', 1, CNT) - 1) TABLE_NAME,
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
            CASE 
              WHEN UPPER(TO_VARCHAR(STATEMENT_STRING)) LIKE 'BACKUP%' THEN 'BACKUP()'
              WHEN OPERATION = 'CREATE_TABLE' THEN 'CREATE TABLE()'
              ELSE TO_VARCHAR(OBJECT_NAME) || '()' END AON
          FROM
            M_EXPENSIVE_STATEMENTS
          WHERE
          ( TO_VARCHAR(OBJECT_NAME) != '' OR UPPER(TO_VARCHAR(STATEMENT_STRING)) LIKE 'BACKUP%' OR OPERATION = 'CREATE_TABLE' ) AND 1 = 0
        ) S
        WHERE
          SUBSTR(AON, LOCATE(AON, '.', 1, CNT) + 1, LOCATE(AON, '(', 1, CNT) - LOCATE(AON, '.', 1, CNT) - 1) != ''
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
    T.TABLE_NAME LIKE '%BACKUP%' OR
    T.TABLE_NAME LIKE '%CHECK_TABLE_CONSISTENCY%' OR 
    T.TABLE_NAME LIKE '%CREATE TABLE%' OR
    T.TABLE_NAME LIKE '%DSO_ACTIVATE_PERSISTED%' OR 
    T.TABLE_NAME LIKE '%ESH_SEARCH%' OR
    T.TABLE_NAME LIKE '%STATISTICS_SCHEDULABLEWRAPPER%' OR 
    T.TABLE_NAME LIKE '%TREXVIADBSL%' OR
    T.TABLE_NAME LIKE '%SDA_EXECUTION_DEV%'
  GROUP BY
    T.STATEMENT_HASH
)
SELECT
  SAMPLE_TIME,
  LPAD(SUM(NUM_SAMPLES), 7) SAMPLES,
  LPAD(TO_DECIMAL(SUM(PERCENT), 10, 2), 6) PCT,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(HOST,                'any', 'any', '-- Others --') ELSE HOST                END HOST,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(PORT),         'any', 'any', '-- Others --') ELSE PORT                END PORT,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(NUMA_NODE),    'any', 'any', '-- Others --') ELSE NUMA_NODE           END NM,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STL,                 'any', 'any', '-- Others --') ELSE STL                 END STL,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(SML,                 'any', 'any', '-- Others --') ELSE SML                 END SML,
  LPAD(TO_DECIMAL(SUM(DURATION_MS) / 1000, 10, 2), 8) ACTIVE_S,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CONN_ID),      'any', 'any', '-- Others --') ELSE CONN_ID             END CONN_ID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(THREAD_ID),    'any', 'any', '-- Others --') ELSE THREAD_ID           END THREAD_ID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(TABLE_NAMES,         'any', 'any', '-- Others --') ELSE TABLE_NAMES         END TABLE_NAMES,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_HASH,      'any', 'any', '-- Others --') ELSE R                   END R,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_TYPE,         'any', 'any', '-- Others --') ELSE THREAD_TYPE         END THREAD_TYPE,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_METHOD,       'any', 'any', '-- Others --') ELSE THREAD_METHOD       END THREAD_METHOD,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_STATE,        'any', 'any', '-- Others --') ELSE THREAD_STATE        END THREAD_STATE,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(JOB_QUEUEING,        'any', 'any', '-- Others --') ELSE JOB_QUEUEING        END Q,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LOCK_NAME,           'any', 'any', '-- Others --') ELSE LOCK_NAME           END LOCK_NAME,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_HASH,      'any', 'any', '-- Others --') ELSE STATEMENT_HASH      END STATEMENT_HASH,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_DETAIL,       'any', 'any', '-- Others --') ELSE THREAD_DETAIL       END THREAD_DETAIL,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(DB_USER,             'any', 'any', '-- Others --') ELSE DB_USER             END DB_USER,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_NAME,            'any', 'any', '-- Others --') ELSE APP_NAME            END APP_NAME,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_USER,            'any', 'any', '-- Others --') ELSE APP_USER            END APP_USER,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_SOURCE,          'any', 'any', '-- Others --') ELSE APP_SOURCE          END APP_SOURCE,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(PASSPORT_COMPONENT,  'any', 'any', '-- Others --') ELSE PASSPORT_COMPONENT  END PASSPORT_COMPONENT,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(PASSPORT_ACTION,     'any', 'any', '-- Others --') ELSE PASSPORT_ACTION     END PASSPORT_ACTION,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CLIENT_IP,           'any', 'any', '-- Others --') ELSE CLIENT_IP           END CLIENT_IP,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CLIENT_PID),   'any', 'any', '-- Others --') ELSE CLIENT_PID          END CLIENT_PID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(STAT_EXEC_ID), 'any', 'any', '-- Others --') ELSE STAT_EXEC_ID        END STAT_EXEC_ID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(BLOCKING_THREAD,     'any', 'any', '-- Others --') ELSE BLOCKING_THREAD     END BLK_THREAD,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LOCKS_OWNED,         'any', 'any', '-- Others --') ELSE LOCKS_OWNED         END LOCKS_OWNED,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CALLER,              'any', 'any', '-- Others --') ELSE CALLER              END CALLER,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CALLING,             'any', 'any', '-- Others --') ELSE CALLING             END CALLING,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_ID,        'any', 'any', '-- Others --') ELSE STATEMENT_ID        END STATEMENT_ID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(ROOT_STATEMENT_HASH, 'any', 'any', '-- Others --') ELSE ROOT_STATEMENT_HASH END ROOT_STATEMENT_HASH,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(TRANS_ID),     'any', 'any', '-- Others --') ELSE TRANS_ID            END TRANS_ID,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(SQL_TEXT,            'any', 'any', '-- Others --') ELSE SQL_TEXT            END SQL_TEXT,
  CASE WHEN SAMPLE_TIME LIKE '____/__/__ __%' THEN SUBSTR(SAMPLE_TIME,  1, 4) ELSE 'any' END YEAR,
  CASE WHEN SAMPLE_TIME LIKE '____/__/__ __%' THEN SUBSTR(SAMPLE_TIME,  6, 2) ELSE 'any' END MONTH,
  CASE WHEN SAMPLE_TIME LIKE '____/__/__ __%' THEN SUBSTR(SAMPLE_TIME,  9, 2) ELSE 'any' END DAY,
  CASE WHEN SAMPLE_TIME LIKE '____/__/__ __%' THEN SUBSTR(SAMPLE_TIME, 12, 2) ELSE 'any' END HOUR,
  LPAD(TO_DECIMAL(SUM(DURATION_MS) / 1000 / 3600, 10, 0), 10) DURATION_H,
  LPAD(TO_DECIMAL(SUM(DURATION_MS) / 1000 / 60, 10, 0), 12) DURATION_MIN,
  LPAD(TO_DECIMAL(SUM(DURATION_MS), 10, 0), 11) DURATION_MS
FROM
( SELECT
    SAMPLE_TIME,
    NUM_SAMPLES,
    MAP(SUM(NUM_SAMPLES) OVER (), 0, 0, NUM_SAMPLES / SUM(NUM_SAMPLES) OVER (PARTITION BY SAMPLE_TIME) * 100) PERCENT,
    HOST,
    PORT,
    LPAD(CONN_ID, 7) CONN_ID,
    LPAD(THREAD_ID, 9) THREAD_ID,
    BLOCKING_THREAD,
    THREAD_TYPE,
    THREAD_STATE,
    LOCK_NAME,
    LOCKS_OWNED,
    LPAD(NUMA_NODE, 2) NUMA_NODE,
    THREAD_METHOD,
    THREAD_DETAIL,
    STATEMENT_HASH,
    CASE WHEN STATEMENT_HASH IN
    ( '4e498f19bb992a89791e1e96d9c2e1c8', '6d0bbcc90f4fddebe3cd16b07b6e3519', 'd4e254ec9866d451822a78b791c36e16', '6413f16e8a2709f7cd094042db84e2a5', '2e9d6d1d68ac89c78a3dba5e532ca308',
      '48482a15fb005f2ef288ef198c0b1275', '9aaf8105bdad5308ab706eea28078d28', 'a35caae16f2fa43033c8c4f278483d0c', 'e5332b10f3a1a4215728857efc0f8eda', 'f9468e4f53d23d0dd90230463b544c3c',
      '4ba302a20772e66ff21abe681f4b0861', '430c496e0fe15c0353c80de1c72caab1', 'c0f43e5dbdfc438b86964acb0a22c05f', '3ba27a32c12ccbed76fe54c8c0ad1a4d', '8813754d5ca388b8481e90e877751d43',
      'ae3891f8898465b9c844d36f806d1c78', '57dec217b2c81ec47bd0577131c8196b', '45c9b4c77bb6b1ae3f659f02ab8bbc7f', '614e2621fbfd45dc43a6dbc88c829ae5', '03b1b6d7c3138557fd26c9553fe7baae',
      '614e2621fbfd45dc43a6dbc88c829ae5', '791faba8d46ced32bc70d4bdde880d1e', 'da8163439880168ca7aca60b2ce64d25', 'e1df1b69227985b845d4f3f8135c6688', '11817dbccc82f2828b600e8c841ef1d7',
      '4790a816f7f326f7c78567171817a8a5', 'a2c02d737ce003965d65321ab8900124', '917733c889f0eeec874ca783ea8a3b40', 'db4ff98c75591e934351e781a474d6e1', 'e13c4740f87f9ef697b8e2b01c53f388',
      'e76c89783d652cedeb0183d83e3d82bc', '6687e2d2480061466bcffabfacc012b9', '4526e0c42114570e4b45d0f61c083cd1', '04fc8ad42cfad780a2a301cffea66201', '3beb58c03468bc7cd64ab764a3caf0b2',
      'eb82038136e28e802bd6913b38a7848c', '68f35c58ff746e0fe131a22792ccc1b5', 'd39ab69a66a6a9f15ec60253966f0c9f', '2551f72c1b7b5fbc36eb82b31782df26', '6b45f4dc17d1fd081cbc958d8291cfba',
      '783ed7080a18c2f0684a1765c95354e6', '889628dbc36e0bcb9c8ea187259ab2f9', 'a9f17b62f2c85a2bbacdcbc81ec68545', 'ae3ca933e5445e92dcb4f617a7838c09', '43e7c0eac5e582316a7a17334389b0d7',
      '611684d486918a356f1bbb14b790c17a', '8d4657eeeaa526d9a34aa8a53b63f2a3', 'a7b7221b320c2cf6d25fd5842bf89ec4', 'e6c9e30929d7a58fd740be11b9d63204', '3192c20f2745437fda2c6325e0aa2dd3',
      '3b408dee6191595541ebbd7800f10c9b', '68590abdd6f75850b24472eaa7cb31a1', 'cb96ffe3c3e2b15c1a199f9a3e63dd16', '95370f008f8577a7267981df483e1b86', '5a9012b2349c8e356c328bd696bbe9e9',
      '270c660725af264b11bf387002abcd00', 'bf1f07c495eea3b1ca3ad794e806467c', 'b7c8dccd902d983736a4cae8ee8efd47', 'bb892077dc4654e79b3cacf3ad85b405', '0c2d40de2702bc576de87a9aec2cef30',
      'f45e2eaba236b6655804f6585d631923', 'cac55626bf3476dec8f39bcb30322f09', '651d11661829c37bf3aa668f83da0950', '42bf4a47fbf7eabb5e5b887dffd53c7c', '88f3a62bd06cbae2ec4ac184df7e0a3a',
      'ac52398f58a752bed7843aac8d829464', 'e9f2feac54a048984928f3fcbcfacedd', '2d40db6145e579aa5c23e42337750ee8', '5157ba1bc92d3166d7eab858566f9ea1', '8324ebd3d1cf16908d778f7dceb5eee5',
      '26e1ca7b731a467f2db818753d80118f', '0e483b3074906106fd7c321a30fdea85', '55c0d811e887fa4a08bba2b4c94a46ff', '9ce7b872af35b7c992a3b5d8f463ccdc', 'd07382ba4b6dc49c8594fe66b128571b',
      'c6e61129d85ccb14ca14b58ca5b188d4', 'b03a016fa9a79e6973cee05f693c88cc', 'a9c2427d8a5fee49ef90da48ce8ebe04', 'afb54cf91cd5d51ac7f360f82e67d5dd', 'de4f2fe75cf84e95ec75ffbaf9825c8a',
      'f85c4cdbc90cd417ef4f941d949abb7a', '4073a6b50a8441fa93f10d2acb68da4d', '91d7aff2b6fb6c513293d9359bf559a6', 'fa34afc37fd96494f3d37a3aab95f17a', '2b88d45d4e1246c74d27ac1f9689c289',
      'b8d1861e452621f0c6642ed24a50099e', '2cafcd6301acc5cf9e5c80de57553052', '857c5b8d64f949f1beb9736dec9ef069', 'a1652d017b9f415f4411fd8974f3caf4', '7df11e8ddef118e147bcd96dd848a06b',
      '554c18cc7e6018abd21c69429b273f0b', 'a8a84c81280a0c2bc035cff4729e904e', '2cf6dfab2c7a730bc56b40fc3d64734c', 'c38678b42400ea7b7252e3409ad6db3f', '5ec05e8ced6066fbe5a94cb1ef5c130a',
      '5fa89dc1471bdeddba67e0088dd52b96', '690cf05502836d8ed30d809eadc360ec', '7c541b915a48ae457956cda4e9702780', '83ac4bf74da990133f1c525d05f43714', 'db2a5d8b668a837677bb6946de2a8d76',
      'e7aa79c355895c079e00ef03ffdfcc47', 'fc1e3ccb2049891578e6dcb4deaa71e0', '3824c73a54b350c95c843aed2aa8c70f', 'fb8b1663df25927cbd8041043a715541', 'f816711c913d152181a1e2d3d3d1dc43',
      '19d5723835e910684f6df4334659e652', '1c413a671a05e2fb627f278474dcea61', 'ce499972ced797474c71d21bae6b4cf9', '13a2bac734add8e6c33e837b146cef62', 'c027840449c9bf6bffff7b7ff813feaf',
      '969667ed5f022a232f710b5a5af51dff', '2bae02d679a579d736bf92d660282c2f', '76f246be96028db1e4ac3997b6a07373', 'b8b6f286b1ed1ef2e003a26c3e8e3c73', 'cf2e9b374514550f2b2e522df9f619ec',
      'e04936562f4402c22dda54cb98807a5d', '16970b5f1021649f4b79dde9017812c2', '2afa9311f17e325d6d1418b3dd3eb388', '2c7032c1db3d02465b5b025642d609e0', '5ec9ba31bee68e09adb2eca981c03d43',
      '5f42d3d4c911e0b34a7c60e3de8a70d2', 'bb45c65f7cc79e50dbdf6bbb3c1bf67e', 'b0f95b51bcece71350ba40ce18832179', '8b0c1d926307b660a1797c05d46162b8', 'fcdf8f8383886aaf02c3a45e27fbd5f2',
      'abf60afa26d3529bb3b2ce9599187a3b', '3c4d665564c85a6e1fbaf3d149934e5a', '4a5b6efc4e44ff925434b049d502f878', '6c734feb16ab862202c7221de63131d0', '4268da3d3e23cf17374d2d849e34927c',
      '7fec4d6bc9b347a461c3edfc739184af', 'fea41d9c262ad1d7413b1dfe33c61ff1', '344262f32bb29df38139b498a712987e', '2986820e47db8abf2a2a8341e9b81af4', 'fa0d29c997bcd593669b75226fcff4ff',
      '0ff809b4d4c723a6d1b3d8835d77d89a', '1d612f19e240183a67f0434bba4dbdd7', '8946ba4387f1fe2dbcda9433fe5c42ef', '2fed6e6d601555b4330f6bbe02a985aa', 'd19f00cc8330e8de6ae4d78498229642',
      'de32c5c30fab83809bdc8baeec360c63', '8bde35673a45c0b2984b24cf199dc175', 'b00125455f78c4d794fba903eea620aa', 'd952da8472c0d4350559843cbfd48d0e', '09214fa9f6a8b5322d329b156c86313b',
      '28996bd0243d3b4649fcb713f43a45d7', '7439e3c53e84b9f849c61d672da8cf79', '84e1f3afbcb91b8e02b80546ee57c537', '9ce26ae22be3174ceaffcfeee3fdd9b7', 'f32de4a673809ad96393ac60dfc41347',
      '3795b564b0c728737e695b1021ac3582', 'a0adfca9b52ccf6778f8d5d0e1efb0cb', '4db908d3710d6c3639b2a9e48322d10a', '9a2ce762f4885e347f4567f9ee27c35d', '0b7761c6b9ffcda1debae659cfd7a53e',
      '0ad1a4c1c1a5844d01595f5b3cdc2977', '4592fda53cacd47ac7263ae58c4f585d', '376071168f97a75c7ada05cda1a612ec', '002a7edbc17efff01430ea0c727b7458', '11df5737a4a42ed26e0121151c778785',
      '165a0f6e267af880a21e667e84dfb311', '4476d72f3fd4f3fba01fd14ff1f92be4', '5e852025fa9822ebada6b23500c87d8e', '62ccf74416521350984e10a991cf71a3', '6b1d10732401fe82992d93fa91f4ae86',
      '6e8a0d4379e7da3618e69fa4c72d3312', '7e2f1e1dda7eaa7f552f8cce75614838', '89aef8e08979481bdcfb712dd1796e49', '9968071caf7c6402f1b89e85b3d1439d', 'b3687e541a32eab7c40f1dd2c4af6f4d',
      'c3d7d15bec5e66ec6ab15e86527bcca5', 'ed36d9e0501d5392cbde83889ed2ff54', 'afd1b7b7694d54bca2fc84117792ffbf', '60c366c73e378be600fe0a0621cb36a8', '0e35685e8bbd908e025f3eca1f063085',
      '17629effd42806185aec18c7d090a7db', '7c1c0248cd1601fee27aa2ab8f244d8d', '9c560d67815987d3a20359ecc2251b6b', 'b29bb65fa699a56349dfa9436f523eb6', '953dc8254b96ed3f0af9fbcdbc2513ed',
      'e245088da460600132029e0bcfb9775e', 'b5bb116f425f16a50d63c3ea9fd8a4ae', '3a8b3213ddae57ed4f037c19a66d067b', '11c7cb3e6ab61c8e9dc01ffe3d673f03', '720bb6c662543b066728ee98c6e129ad',
      '6ac093ce5b7210ce431f81f7fd798a18', 'cf4b4a85ebe1be6ffe754d6f7fa08e86', '3ba12256f9f2a2b79e75095cd817ad9f', 'a227ea3fecf3c34a4d3fdff1488ad005', '32139366d69f10543bc7abfc605b37a2',
      '5468e2292c2d169ac5d318f9f08f287a', '4670a96d6abf4b048d40d28fbf1f466a', '2dcac2da4115847242aed4c2e1d9cb38', 'a77c6081dd733bd4641d4f42205f6c84', '3359a412c4e756a428bcafedd78471d9',
      '5f74d263c5c217551d4afc30848c1791', '15f8c397054d817883a13955fe18855f', 'ce0d9cedb9b4a0194dd551c7f06c22ad', 'd339f40ed4667a80eef50d8d130e5dec', '33f3b2704fa52cb1b85b047a5def4f01',
      'bbe68180a2e6fcaec3edc6007985f932', 'b28dca04ced6f8b3495e3970c0ef36a7', 'ef04ace2ae2ff448ef0b19ca999a6d37', '806953dd0df65b4f67c0de0c33d28da7', 'efd74759c6dc35f70ccd3529b62588f3',
      '7551257378ec73e2ba93b5e5117b6c8f', '1d2893314f809f3e491e5628f6683ea5', '3ff7bab8b9778b77b821816c3a147f81', '6662b470dc055adfdd4c70952de9d239', '93db9a151f16022e99d6c1c7694a83b0',
      'c706c6fb087b78f6d07b5ae0848179a3', 'ccbffaf1607aab010cbd4512626e10fd', 'd740f122ae4c4ae3664a09482c249947', 'df4382e56e6c6b193dac9ac7ab4d7897', '07a4169722d9848d8150f53037f3a6fe',
      '915d86cf95219e5c3c51a5aad207e19d', '0e30f2cd9cda54594a8c72afbb69d8fd', 'a115fd6e8a4da78f0813cfe35ffc6d42', '00218f32b03b44529da647b530bf4e6d', '8a8ec2baa7873e835da66583aa0caba2',
      'b51046ad3685e1d45034c4ba78293fd8', 'ec91f8ecc5030996f1e15374f16749a8', 'f0a4785a6ada81a04e600dc2b06f0e49', '02400fb6f17140aba360cc2753c975d3', 'ceaedf22c0a0de014a6191520d723b81',
      '52063e6acb3492518389d230490492f7', 'a3df1aa41b220869d74683a8fe9b1f98', 'c3a9a6620824cd0c931ae3a0e88942c6', '8d87d6a303389d8a3f2c72639910da49', '78cfbe0776760c57376389aa595672ff',
      '4fe60bbfbfa2979b89e8da75f5b2aac7', 'ca8758b296bd2321306f4fee7335cce5', '2aeb4f7ffd47da8917a03f15a57f411a', 'fb1a593e493a9443415b1b5207054e68', '912e1379e9ebf67109eb00df87dd2d76',
      'e345f4b3df20ddfbcd37ee4494fd0430', '94bc362b8f70a9460f583ac71e08b9d0', '9321a96c237894be2e9c80cb6a021f43', '7973b84c289fb68dc3d480eb83aad0ee', '7c71e94c46f7f62b679b83b2d67746c9',
      'ee341ad92f3a9d4b359b3e7fa7a44cec', 'da78d5abc901ba7166721c78d78697db', '1aab02cdb52e14600b7fd7e1b666ad33', '2b8bd3d2501cfe61cd64e2ec30a7f83a', '5a9fa03bb31bec877a0b0d00c761a252',
      '4522b390b39c745346e4b2c20ca0e730', 'ac1948f2a0ef6b22ad39e762da017d6c', '8437943036a2a9fd82b290b2c6eafce7', 'a12aff7f7db3b89f04df28429f4725b4', 'a7df7509a22f5e64c6f50e2234415f5e',
      '03d58c448c321ae8e78c00563bea0e95', '1c340b120554c65c8352b06b8ec16650', '286595fe6035f3aefbd0b9d0be0f814e', '054ca4ad7d229638928813856d0720b5', 'b5b6bd4bb2f842133c9a1f07ea1a48b4',
      '673800ad653f8d62d3769a06181c6f8e', '7b54142eca356166c71929d03c462dc6', '2fe987d90027ee74e82001499bae57bf', '4e100847ee8a76ccfd8630d23dad66ba', 'b52d2cc6afb4f07f8f9c2064e87abd93',
      '9dac2f34cd80ff538bbb4773f8aed514', 'b7944c0c3ee72f83c747db881a2eba05', 'c5d8831b456379da4d9f6432881d47e8', '29058a5de1089af9471b1009f7d09855', '7f46508f349433ef9716a782bb5c3d7e',
      '9f75f289f8b19fd36da01a861555ec85', 'a5fe878e070d043417c1a5174a792aab', '5f13497ba22f20ebd629da493e395f8d', '753769700d4435edcbc8cd8ecaa2a6fc', '806b77333ee56cb908c119e2cc9ade7c',
      'dc6ac3aa4b5dcf34b926da4f7adc9088', '7488ecfdc727226c7bad7e99ebe21b25', 'e5332b10f3a1a4215728857efc0f8eda', '9a79d31c5bcd65e129cddf4e67057c49', '2510974b53d11210cfe465e5223a572d',
      'a7fc8bc85b7b95dddb6d73a12dd00c0c', 'ee83408659f7c61a023c27ab5d784994', '5ef81b3843efbe961b19fdd79c2bd86b', 'a3bbe3e5447bc42eb3f0ece820585294', '8343a81d8e7025d91e72be8d530bc095',
      'ac08e80aa8512f9669eaf56dedc02202', 'c6c59150977220ea4fdea412cac7d1ce', '0800928edd9d43764935a4e02abbfa15', '16c226e204b54efc280091df267152fd', '2b7fee2d2b95e792d3890051cbb97ec9',
      '55bb62c4b9ff3f0b32de3a4df248e18c', 'd6fd6678833f9a2e25e7b53239c50e9a', '0f54bb2482e75ab61657973d9195bbb4', '10cec71e46696dbe20a2143a3158dfd4', '1716655062c017719efc84121e3ea753',
      '1bf11f8fd6c108e2194bc162032b10a9', '383b3cb02f8f692ed9a28c9249a54c66', '3bf0fcaebd43f16dc504b9beb0005d29', '45e3ba47a0368068d71abb143f26d1d0', '673d5512da8404303acbe65a3baaf01a',
      '6801336f2e5de891edc0b806c6048c03', '74ab46ff2c01649253edf88abed9a870', '869b2445401fa3cb696e631dc39a5f0a', '9d334c558cffb2f66af0648598ceebf8', 'a2210deae1b210ac98a194a57c5ce4bf',
      'a562281167397c8e00fe95677fa332a2', 'aa220713a00ada128ae424d62b5a5868', 'aa4ab1034dff6b5c016c3db0be67d8cb', 'ba1ee014dd96eb9a21fdae5abbb1f94c', 'd617c529ab701a44b2c40cbafa9a314b',
      'd8091e1a6717e82567d58a6c9434a9a1', 'd9232f67ad8896b521b6a22234fee91f', 'dc571bf5eb7cad9c313c20de904ab709', 'e02eb8dc390a1db7e1e8779ace4f3ce2', 'e54cd3f2d069e395bf5bc9414d6369a3',
      'e60fb426874c22c32b92f3b6d1e52372', 'ec25d42a14422d8e899a7932ab213410', 'f019d40ff3e156a7fbcd78c5f364b286', 'f609c887b08bb14c9a218a9756ed64df', 'f978e725069449cf440f5c6b9185e4d5',
      'fa2bdf3047b4de33242305aef6b593e9', 'fbf6ff256ba159a53893d7bf4bc6d277', '05795bf8c58150579e539ad4c762a411', '6d112675aaec6e4e853052145f0c0d23', '1626b0156893dab5438186b6160139b7',
      '6edaa7fd2e3585b77132c650493b58c3', '2723663c7576a23c860ba55ab91c513a', '36723585726e7f185d6a855af6cff433', '87f18bf0f023ccfc0993cba21c1e26ce', '9d5690b9382a98abbf80ab837540c75d',
      'a97c6b2c11324d68599a578211625c19', 'ab45c2515763669bd81f1bf0b3e842d6', 'bbcf8c3d170a3473855932dd2de67f19', 'deefdc73509bee2c6e78103e6ba5a44c', '6805026a381879e9e5469be3f09cc654',
      '1f19127a9f6efcb0aa7b7da8b6e0f31d', 'b11500ff88187cd8f06a308fc8e568f0', 'efbf8ae66edaab4e26ba700d7f7ffac6', 'a609f96b4ec877d38c9881fb9b8810b0', '0d9248912d550b8fb9f50699904a2309',
      '0a60a633e2e1f038aacfadd17a772003', 'bba5b88bebf8051e8ac3dcc70d7ef589', 'c7aa02f6ae8919061f5708ad63e56d33', '25a6171ba41bdf171e818c986177f37e', '97171744726a50e248699f758de23444',
      'ba8161b6133633e2984828ce38aa669a', '7f55e72c22694541b531e83d8bab8557', 'd24d8b8d00dd8b8df3e13dd9fb17b5f9', '2b459e0d42037fe4d6880b238018a6f7', '70efe3b4e470438543e6ecec418e4f02',
      '905dbaa93a672b087c6f226bc283431d', '2d57b02cadda185883f5b21f278fc9ec', '4bcb3c3b073c1c0b3ec8c6189452c3ca', 'f9fe5a1f2bbfe7be197f89f4813dee95', 'bfa3071482fd3d80f268bb48cd312095',
      '371d616387247f2101fde31ed537dec0', 'aaff34b83d10188d08109cb52a0069ae', '3f96e3762412e8d4cf4c670f2993aa8a', '51bffaafaddd0ec825ecb9f5bf1b5615', '5d0b4a21b0c17c08a536bec04f2825cd',
      'a3f19325031503e9e4088a8e57515cd3', '1cbbe08ef2bf075daecb9e383ae74deb', 'a5539c73611c1d0ba9e4a5df719329b8', 'a382ffaeafac914c422752ab9c2f9eab', '81d83c08828b792684d4fd4d2580038e',
      '1ce978ccb4cfed10e1ef12dc554c2273', '54c8e15427f41b9074b4f324fdb07ee9', 'da7ef0fee69db516f1e048217bca39e7', 'c197df197e4530b3eb0dcc1367e5ba4b', '75a374cc7d49afa729f4379608270db4',
      '6079a94e9b06f8fb6cde8b4f96fcc3f3', '56f3adf67e6975e26436563177651f21', '35e994d35949a8e6aad9836a756f5152', 'acdedb945a5b0083ecc662acac88af75', 'c94fc486be0b78a9b6e7d1f84882631d',
      'e1cdd703df87fc61ce8163fa107162a9', 'ee6a8a43d1165fe8cc2dd5b0c6b43799', '23b55b68c5131a580959ec19dc986441', '2d5f7b7a147b7c23dfc28d19591d3b85', '2f28892b2843a8b159ae89a1571e3e1a',
      '59b3a1d01421e944a0c7949f483f0e8c', 'b2bb2d97fb55b064dcc303d88954ad2e', 'e63a0e779cdc70b9053276a455b99c5b', '1cbc1b492e2fcebad473cfc5eec8cba0', '0a67253485f849f94eac4d7acd74f71d',
      'c6ce4430af8001676f1860ac129b4ad5', '4696934057f8212f8dc5ef82c0c0380b', '74644c4d6d4426a4aeb5f4f3bb6b49a3', '49ba27b9fc819c9a4589eeda7e787c7a', '65541ea9ff3ca589ab3785a2d247270f',
      'ab60f50ee7fb8b2f7303561db045e5df', 'cdc85b0be8f104d0b6390f84fdc9f918', 'bf5cee7981f70de69deeba55c59c3d1f', '9e514d0f1ca916769b36d52aec4ae1e9', '09b3d2f0452e0e63a59bfcc5d7e3a99f',
      '3e3b8e11cad214e9a7a5cec6193ad270', '8b46525ae5c6cb03474ce50b0665d2ca', 'edbc92bf95fdb9ed1e0746be18ae4e55', '5fe2acb9cfd7b372f100e8133e502cf2', '939eaa61a3d9dfd4a8d610e607a8c8f6',
      'cbf7228b6601e0485769afbfc5077b5a', 'aa9c7d24619a3fa5c9159c352f4dcb05', '6cc478091b517a1329060e2397101774', 'ba1c044211c8520ba553a12654cf2747', '6066d80ea76a9efa5c6b80d7b3bbe198',
      'b74b5839acb3869a79b889c325e94070', '97edbffda3d971680763d1653a73fe7c', 'b10c4869dce505ffda821289f9876d33', '4275f64f1da015109fbb7cb187a17534', '847e7f7f2dbfcbeee615e1ace375963f',
      '7499c13d54ad95db232f03e8d7f95e78', 'b59c3c5005309a050d5e035155133b85', '81788f9c7ecf4c6253e8099f7ca9eea0', '3371f7da0b57dbf46f4c056921376b2b', 'b59c3c5005309a050d5e035155133b85',
      '8637ffebfcc65ab0d613d10c42a86f3f', '11b1c4b452b55b7fea973c5c3e7547df', '75698fbb304e406dca77e4b87fe3946c', '31140725b1f4a46369aab247c0b7e097', '5d110ba33c2e0314ff186019c37be2c7',
      '683b80896e3550eea06ade4a3a855917', '8fa09e6dfa200434333e3728dfac986e', 'c3a6938605f1d3c5a10f58b30be2014d', '2f8e5433683b98b4fe6b8257d9bd4195', '12eeafbd3aae528306a8158ec8606fe9',
      'f306ecaa6d72a7f56d0620259f8181a1', '3fa9f17cac39444f386b6f8a4638ffff', '26a7201696025450bb99f1fb1d203708', '1f989f4acd844d502ccd445f69f5ea02', '38a8e11286f7309f2715c07c270a473b',
      '430c496e0fe15c0353c80de1c72caab1', 'ba81a383d98a296d2e44e04278ccb770', 'c6edbab2e426f7e83b156ed06ccdf6bb', 'd3759ce6047b78f61d5fc3be392d0336', '203f26e3c3018684b236ce8bcae9c2df',
      '6414ea1875d5ff8deeb62a9b5f094762', '4f765870d762c351b57c4217e6093f9f', 'a4ba84c9f41719decfd7bf1472c79227', 'f0a0081a03e2d6275d3849853ddb9125', 'baed6a80eae9d5e505c41cd07d125624',
      '42566e1f2491b6b9820bd20d467af93b', 'ad5ab291e053d2c9c6c18af69c0b6493', '235200fb753637c5f9d6ebe9e4acca20', '1964c8ab878cde5f306d9f605e3b94ed', '219c467bfaff3e2ce2f9d66dc2e1e290',
      'e4ee5310d59f1a949294663ec9901639', 'c67e0ff151ad6c6de696a4b15f9d0c64', '0c0de3325053aed2e2a1260163974c8b', '0e7c0ef5261f68e200db6db6070e2979', '1ee164315208046bb05ca070a2bfa3d9',
      '3539d0edfd130e2a95708c7ef7a4f326', '38f7c968a229dfb7ee2e8688888619b0', '3a0a3b53f8aa937d796c7f45a9f94628', '76e9d6bafebb0e8ee65c294eb589b295', '7edde48cace745d72cfaa18f8c38cd23',
      '917a5ce67e2e9ae6049a542756a75374', '96e55a4f0622c3c6646ef03470701962', '9ee1c7a5b0d1e6c4093f54b64c25189a', 'ddcf8f3f2322f37456fbdfa7d7d431fb', 'e62051ca906a3a694d8b2345d0dcb942',
      'fc938671ce5893de9dbb99b81ca18698', 'fd11181f9b4580948ce5b658163a1c12', '973e198ee37f31f2cbc2b7b3252eacc3', '4dff04027f025c711d7009bd3ce90be2', 'b5535cbcb7f4ae77f92875b556536c7c',
      '73393b77ed7d09afce44478e34879786', 'e8e01d06eac7f4a9e077c82b1841c00e', 'f1b7014a4be2d66f7ce29de385f2313c', '05a6382b4675387c44e3008c8a6fb32a', 'f1b12a80a3eb489df86f5e25097725db',
      '9b2eec360ac068a98bd0e7f2bd12f8aa', 'a505eb1288614d619b31f160eb1b0e5b', '891cf32d4e5f766efcac3070b576597f', '9546a29b93480cab55902d36b3aaefc2', '833302af6e1fc2619d9a37be35ec4c16',
      '1e4dcf71cd91a988edcdcabfac5ff3c8', 'aa01412bfb912d422e4cc07e401ca70f', '3dcc171fdeed9f122a8e21a8772f764c', 'e291174cbc7ab2c68740114ac34bfd3e', '616d53e49560d76d919176535b4bc185',
      'fb8b46b90b80619b1b97af549e3a5772', '878c325b36eaae5309594f17e0f7bc3f', 'f0721df5b7ae4971a8d68a7f5e4959be', 'e9c4f7f727f746f54c1e36a87205eae8', '26daef039f35e5df24eceb94ccdfb462',
      '09ebcf4d5dc0954389551c4b23c05d9a', '7c99e482e615c0beba986c58e91c0c97', '099952519dab17d505c8e3cb3d245196', 'bafec15d2b8d4cdb478fb1f50d6d2b16', '3554924da9a9ef871625c35f7127da58',
      '17bd0e4181db35ada2fdb4c682f6eb0b', 'be96367bc1dbd364a00584477fe2261a', 'b735b0cdfe3c8c595aa76166901f68c2', '2b637fd280f55baf313331486ac35723', 'fc00dc4612028ce1ce686bd10ecc1761',
      '1db5c91fffcadec8f6551bdca82adf44', '80aed209c3c3691b535d4d9a82c5a993', '0555162ef70915eb8eb672670bd6c6b3', '540f5a0b90c3dde6badaf758b4f999ca', '4871402a099e866795707c31bc5aaea1',
      '68eee9077938d4c8223ef0149ecb0d51', '7b84bc319e14ca9371cf0f500e884582', 'db4ff98c75591e934351e781a474d6e1', '4fe08f000cb95d6d03a8c279ef74c2d1', '5cf54ecb10867fe6c9057d085049d7c4',
      '3732125d72c6d25d5e0eeb8026c1b789', '070f0383a839f783d1bc3a2ae66c21ae', 'f33871dd9732011b2597ac24f5ab8f4d', '58071fe07364fd7c23f7e28880150128', 'cc351578e364bf59a48edd537191829c',
      'ee9876a198c6c67a81649487adc9c837', '0fe0c8111a52cf95def4b55893464ca1', '717514f88a91cadb97ef879f6608e29c', '9063ecdcca002cb5368be439b5ee8f39', 'c3389e9753cb46da85cd640da8ed3caa',
      '6e40b2c493f0fffbe39d79ff66bc1af8', 'ea4958c3e5667e0038894be6674ab4aa', 'bf12292cbd91dfd4d56053f397224271', 'faf34398b15a9f96958d83a267b99ab4', 'c47f784b695a3f686bd010b765419faf',
      'cdd18181642050527b4a1a95d00e3f3e', '32b53f05a6d99d8e55f349cc1d9580e5', '58b942966bd98138845ccca5e5513ea9', '02a1e492e2f681959509afca5b3a20b3', '8f3a3253cd1fc89d43ea42d7532b1015',
      '2a4f9ce41e671c3043ca01ee2f53c482', '066d8841facca43e927ef61253ccd2d1', '4c93c09e31313c80e1e5c427d174d86a', '946e87a9511070edf1bbd6177b4b0150', 'b1e4e649916da9724d0ff114258ac53d',
      '3d2724778ca7cd61bcd36fa4924a59c0', '346fa3f331c1986006ada8918aee1d90', '7d80c6be4848f2f9fe778fbe81427fb4', '46c5fe2884f11257abb74793abf18c9f', 'd138cc6eaaf2a9050cd51844dfb187f5',
      '113dc3a08e050b79cf423deadc46c16b', '486ac42ad0dd8db9e857e6116e835d93', 'e137a8162443fec5dd94150565acf3c6', 'efaeaf6c8787b2f8e75f496034323482', '602ec558aa3143901eb98fcb8cc33f16',
      'c0aa71d9f784996b626e589b74544c38', '35c3ed2d193b5930001b02832ead9245', '6335cad129f59838e2077de33f61e599', '6eccd14a84dec8a1e868706655ca1020', '145850f44fb63705f273858dcc3257df',
      '80cd171d058d64da0c342ed85fb1c6a6', '3d408762388035d1c8534ad62e157c8b', 'a70c4031ece0e895dfaaf4c4e9acd690', 'f33b8660de1e3bc467d79366be1d7258', '4cc734c0928b50441befd3782e52ca71',
      'cd2266401b89265e8b51686955960c63', '1c4fc4ab7e637405c3383d4140db89ef', '447875bbafe59901254cf1fb7e846fe2', '0f156f5e07b2865a9f1fed5837a036c3', '3596bfa8e0055ff715ef52570ff66128',
      '281f191a6b9fd65216df0d9945735113', 'dc2bcf2b5aa0f22aec2ea1fc62a49418', '7343a8b8c43d641e21e9e28339c23a89', '74bfbf32537e5ed95a04dc60817ce3fe', '6fc02f44c1b21c0a4e288b48d4c5ee61',
      '76423bbac93cdca6dec17fed34496465', 'e7ad51351b6725e665885fd80adedac1', '130dfe8491e99e9960690f9fce983a0a', '47b3bd84eec1cce26c1ba82cde2ee2a0', 'c1f08adead4051c58289f552b4a6d71a',
      '3dd71780f165ebfa059ba8b96890aa77', '4580f3059c884ee10de1eeb1fb98ac06', '4d7a6a4047decb99f4893347093ca434', '6cc91e12c9ed812c4ad3b55a2cd10cfa', '78b9774c4797097346cc18f858006c2b',
      '8d7cfa00098e214b537eb4ed54131cb1', 'c411c649778b2163fb9b5c7a92926e89', 'c6923a33de2de74d7cd9753432edee12', '44efafa3b4d42376ddd05ae489eb02a2', '6aef2dd2693056867b6aeef7d08d94d4',
      'dbff6e35c53899c2c47e38e671f47386', '30cc2a2936e36a3caa732accea1fa711', 'ead5ced088741f49bd27a5f860766ecd', '6cf1986b54b8cf7df708083bc07af1a4', '079e5109d4bf0ce8d47f8d84704c071c',
      'e314592f5bce71690d6ae05d088a1d41', '0fb83778bdf2ed44eefbe48c92aebca4', 'c4fd3b8fd975a4cda303590e7b2a707a', '5fbd592536c53068deb5b4a67272d7a0', 'f12b30f24a33fde01082983778ef35dd',
      'a34890b38a9b16fb44327f36a618efc9', '35c76a107e1aeab12355e3ffb4389ba9', '6db0e37f140e3b529ad82ab0cdbc0c2b', '7b94dc29b0ff584f3a0e1be2955bfc64', 'c50d944ceb16cb5aacd20be3c9e811c1',
      'e48c904c5fbc4e8dd8dd4ce4b4497dca', '6ea085309583e2436162a48b8cc62cb4', 'fa4b1ed668d15956ce86d56f3632a4d9', 'f053abebad183def228db1b506d49307', '7d45827e7d5b5ce271baa827730985ba',
      'ee8c70fd188e0b92eba9b72e484abc90', '66342c6548a87008636bb0cda6db8872', '66e2c312f4556658bbb191a63ec4eb32', '100b6ebd38bbbc84c20e887f4c51339e', 'ef7d4dc44f62c30868abd8bcdaaacd57',
      '48227050702b6788417bcdd09e6c6760', '80e3134b8b8ca5b6f0f652c5d538f94f', '0f32e3f24f81f94a6812c093511a851f', '04889f506b60827138e56436d3474786', 'fe7ebefcad7f33418ea1d43558ea6bfe',
      'aaf99cc61499b23eea6881439945544a', 'c387fc1ba5614b32f26f46c8762b4d07', '32c31293c1bc36f7d5bc880684000d40', '3d6233854ca57d2bea43e2a8ea593b70', '92280dc954620c61741b9648e020311d',
      'b7f626060290b24f84e777d5b56a2527', 'b5f9056a7ee1022042e20306c0b48e59', 'f792b66c21e64442bac2276b94155a4a', 'e4460b851e3d9dea92825cf65aec3bf7', '28e4bfc6c342971f9ab54c7abdf6250e',
      'a33e7292527107bc7ff6cfa2531b0a21', '6cc8ae0345f0cd530f6f3754fcd55688', '972175e7136b1569ca4979b2cf8e754c', 'a5744848b279e912379e1d2501f4ad0b', '1716815ae5051c3afbc19c2c5902cc5b',
      '4543c836acce6ef174c42a61e443134e', 'c3c626adae60fcf3f8f662ac75477d41', '72175743393a7015e247647acc1bb7b5', 'b80f8bd3c59c1bab3c692c55e4d5b3f9', 'b3f8f9ee4e70c32358aa9fdfda447ef8',
      '12b4ef1b19369b76831360dc02d074d2', '98153cbbd47009f99b0a24e0b1121d9f', '00497cb80638494864725be90bbf2eb6', 'feb6b7a1c1f054ab4e42a50c2a24feb3', '7b0b3c36174db29a794b82eebb0d9fc1',
      '5a0a91f1b589d2cb7d0f55be856be0b2', '022a0656e4b70c0e2124497d9cb56075', 'cc5a32805a0924dc52d1e8a236711e8c', '060a6bf7aa804dae3c55a08136dbe38e', 'ef9d983128f4be754244d5be4aeea34c',
      '884514c4f1ae4cd7aebe63d3bc816167', '2c578e3d400023f7f367f0860f8b55a0', 'c513a46e8923e772c4e5343a0cac82ff', '000f40538b11e751f072794c5d86dfa7', 'b19b5145b99c58559e1678a39b4211c4',
      '46f7ed701af8e271a94a592944aeeda5', '7a00a013b367f505d7840506e237169e', '470c9174c550352f622b5c476a622589', '2f0edf3918c670f03f0d0a7865be4b11', '769d7b44a80f1756ed4da215f9744a72',
      '027a69b3097e6c6c93176c6fec540d53', '26ce5e2bc2f400c047631aabe411a6f4', '8e2be385cf6cfba7e80a7c3fc4be81a6', '76c77bd3d063cfebb63a03c7e7c4d001', '759c32107c725e2629f1e9dc08a1c9fa',
      '9dd0bb3115913df9208c3388f7f5f461', '8032cffe801f81ca835dddd255c50d68', '155f2514ffbd97cd62c013758286ea76', 'a541d8b887b900b3d2f1073eaadf00c2', '75ea317896b0f3b001e0bbdd462edc67',
      '8574088c0e4e86fee180b6de980ab0b2', '3ef368dc1b2ce64e1e8ae065f846e84f', 'd956e5bcd4f2756c19a28a92778e1177', 'c335135bcf1af4323675498fea42d5f9', '15e6cd042a447e36f789794d947270ee',
      'a99311b79cb2fb8706e979cda20edb44', '8a70aa0437cd9bf03d7e1f51e4a722bb', '53f12e37eda8e9a6f4cade65138ec110', 'bed65ee7ee721e1472fda712236e7445', '00f5990f5e2b048815271736eb06971e',
      'abf87f501874ae38a04bce633f869019', 'bedaa3a75085247a6e1f0370c380c3c6', '31de26d87576ab66558ee13c54a3e3ed', '3631d2eb9948ce2ac6f1dac057d99bb0', '9f3a4785ad9ff7ee4f1342618a37e8e5',
      '0a931335817155c25ddeae3183b7ad53', '85cb05c86e4031d22ea077b66bfe02b9', '3147c8d956a600ad16ca8ee074444078', '84cb85a3eba68fe6ae4fbcf29ad26a14', '0bb645d182f850aa5beee23f9704f48b',
      'f246ac9c3b1ce532d4b51caf6fd70691', '6a822f11564fc5b1779be273e2782077', 'ae7f94b9a7e4c902dba96571db19dffb', 'effbb7b7b04458296ec46e9858d10451', 'c3f9f2134143eb8da4f860c193024caa',
      '6422b644e862ef07e4636d32a7254632', '0ec0b76746585dbcdc308e168dd9a353', '266fb9202f35945f4ee016214e2a67a1', '2820eb46f5c1af6dbfc7e1a890f605a2', '1d0ba376e273b9d622641124d8c59264',
      '64cd1a531cdab0abd980f4a515b83c87', 'd21cf1dc3fe2111bc1e53d58cacc29b9', '0132d9eeaf22c1d38d4c5a8f4d6a36af', 'a058f013fb0ec2f4c1141e5b396588e8', '9344fd6a680c25d0e28bd66c55b14e32',
      '9d3480ff01bd8fc51759b4e9c8341e0d', '5331b867628b64a02706379d271bef5b', '36490273789aeb5c4a5070e6307fe782', '86a04561a02aa97dd40f05e2e5f41524', 'f3612366d53e8fcbf465da8dcc8f2473',
      'fe769268583b8b8715593ac10f0c1fd8', '8559ff443a3816983aeac38377e37d8d', 'b93124fe6aa7d2d45e6fad54345b9672', 'ca5feffa109ed4f58a92e5508232cc13', '8009724b392f39ef358c8fcd399b9f72',
      'fe4e46ff323a57316de435ced0e1c941', '9f0a8508e0543774562406e080a258d2', '8001561cb4947fe18fd7e967e9a1931e', '57dec217b2c81ec47bd0577131c8196b', '03adbc8704374d289ecce4bd8f1a3150', 
      '52273b2666beb1a8ee46f069e7759b3b', '439daf39eb6987ab5ef620bd4756ef3b', '20b2fd8aeb4db6a26931cc61f6db4cd3', 'ec765107843434d8097b6c796e493a61', '2efdc94d660cf4b20c235059ab369898', 
      '481f650b89dbedae171995ea9a645d97', '565f8588bcbf95fdd964510fd4e8ad27', 'b473d796296125065b1857e239924b11', 'e3868db606001d6780f58b56c85b977a', 'c004e3e7d510a429896b839c9a0b9e0b',
      'bc671ed9c3058b43c12aafbab573e891', '4a9b3e1d38e9c962d7a3cfc0aac6e2c2', 'a464569c7abe55d26c35a07034a99a2f', '8cd8929305df59e136926a31cf6ba797', '8a1bcc8b73f1a2a21b194779ed603b80', 
      'b10e09354238da886f63b2f2de09f4ee', 'd909d52390ed83bb90f01dd467a0a2f6', '57461b5a5d2adb64e80ebbeebe3a329d', '11ccb7ff8be1cd39d058c4616ebc1e46', '4de83928f69e078ebd8b68f65fe3ae30',
      'f97424065815221c9b36d27cb671c329', '40e6646599fe5c5a04f7441ef1e579d0', 'fb0fef08b6e0f1d46cde07d8835545dd', 'c291030bf5bbccfbcb3d7c6b85328cd2', '46780875139519ef1423e34efe1a9582',
      'eb54f7641ea40eddf456604ecc100f46', '5b9df4f9bb94ffd6ef445e2a7d8d3ad2', '1045d8b4e76ac8d4d37303bab4242be0', '9cf5e32514053d9c617baff34d032952', 'be788bf5f4482e70db907fbf7c73d857',
      '3124bc8c7b10028d6797d19db8992d58', '94927f293e398e2e45d82d96a19a96a6', 'b4a0dfe6daab873b41ce5e0a5f5b8716', '4891a82d8e0e77ab4de398c35208bc20', 'c8f682aa3be41b442f4aa42395c5a099',
      '2d1ea9a365efd64d1504ba5dc255b0db', '653f2b3365d2270a09dbc867f0caf09f', 'b0101e8a31307c6f509cbc726e348f21', '455a6193f1440e44490f0e8d5ee87d0a', '8cdf6af3445a91a4f3a9125cb1dbb341',
      'cc8716b21968abdd86f26faea08ceaa3', 'cc8c76c98e842c0db137e2a03895f2bc', 'ebd30763da6cf827578153bb37f3ed6e', '28e20ad7406347dfd5a0cb6a8cd8f68d', 'b1e72ff44bc0eea0b572fc89cfa7674b',
      '8394dec3bca547c12e1728a859ab3952', '87f6d1130f139af11559242490feca24', '8fb5daf0fd892470558d780f305b3e43', '18edc88026d0439404488c7c0daf824b', 'ea75eeb3e7c6fa58daabd157360cc5bd',
      '064bc772039ccbfe53c34b0d6bbd0aa9', 'b470824aed0867d8e2dfd756e0d703eb', '635ecd1151236f1e994ce172c9920050', 'e1e746510efab6b3c433909529143774', '2277027b8cfeb569dd927370923742c1', 
      '1b7ab75efce9b7faa1cfe76055cdf27a', '94c404d4671dc6a2a1a3edb43ebf3408', 'f07de1b462bdff69190fc9667d279dde', '3e14b5fed3f9fbeffddb469170e07ca1', 'feb81cb341207491e87484809ca84c32',
      '0734bb8360ee430834fd79e47c6c8ded', '69c9dd739e14da09645891b9d241fb5f', '54ae92f6372acb27af2b6b4de3ed7f41', 'a412091705b83f996acc04b745e2b120', 'b8ad6ffc101923496954f7de03380382',
      '0b1e2b1c549a5c36ae973c6cd3fb85c6', '38e915516cf4f9bfef7cab8f2289f328', '49406d1f7e2b051b799aa12440a3d43a', '9af92d27da7def573ec1d519b3c65c97', 'e17fb11651ec4b410b5f36e86718ea5d',
      'd7c4094d96b057c5127a4e2c0c54fcc4', 'db757bc405842a7a278838467ede540b', 'de4d08b0863b6076896dc1334e2592f4', '74d3229c25a96f60303335a58bd537de', 'ae7aae037f999685d55908000713b22d',
      '43c49425b6f6613c18efa5a050b1dcd8', '53f9ff6100ff8c14703a536156787fa7', 'b2924e84d11a5971280e52dff638613d', 'd1cd7ff86a6fa4b87010b2f00758e94c', 'f7fc0b6e05007188355fd8a4e55ace37',
      '1129bbd742e83f67d3593926744e7c69', '1db0f6ae9516a07651706615bda15d9b', 'caf46e6637f132a29fccfae159f1b1ae', 'd8fc952923d1e879d7350e61ae04d4ce', '1597073bbcf6406954b6a9928d9c353d',
      'e094153a06fbbe726d8ea7ba55e87d0c', 'be7fc33b798435d8d7e14007fc7125af', 'b9222b17dda947f29917acf4743f6f91', 'd0fa7c2e180e845e806068f4dca2a926', 'def6f6daced09645fa35497dc348ffe9',
      '8468aec357c3ddda63c0c852c0736e23', 'c07285806fb3cbbc785c54a78deb44f3', '1b0c5dd7d91a5b09dd77dea7ea661b65', 'f08c07ad0f068ff850e1d734b6a1cc94', 'e7e2b348b9a2b59422d481f753320baa',
      'bf877ef00892a87b4e6cdd72f13c710b', '3d12378e0bb47cad454a0a992533afa6', '4c0e6df6273996ccdd9783c348a3da89', '46657f53f01423f6764a3064cc43a0cf', '84d768b33354f0bcf82d25b8ceb9abe0',
      '8077c04a1ea6703b0c26c05f29bf3482', '54a156ae830b695e5b9d3df5093948ba', 'bdb6de442e6e0f19385ee67e226fb831', '46c2d08f694e349382de1f56c27a7793', '0536f3e797bf197ef74742b38213f7cd',
      'c78c8ae851ff89d63816309dfed3f02f', '90da0c0c94022c89a288aa895287d36b', '426e348da3b70020882d3881b7adc081', 'cba6a447f8e13058c0a2007c2da631e4', 'c9418a6333cb3ee55259cc30e9305dbc',
      'dae1ca689083de83b6e2bf3d10e9d90b', '00364c15bee4eda3b700114e6eac5b64', 'fe3c0dc3965e58c839f99efd034178eb', '16aeba53544d60ed5830381d18d01c72', 'cf7670e9527c4fc1ea412f843e79ec1b',
      'f587ec125bf2c2d90d9066afe1de6d2f', '3d4802a04f79a09957595d31036f8b4b', '773a580662140171d0d8756c1d133592', '84ce82d311c7c39f4b4275fdabdd8340', '29fe87c0c75c1d644db4e3a67b5736de',
      '10773e93773c6572b858d40d02efdaa9', '87eaa701d54dcfa4bc027c08cfd8bee1', '07235a83815cd5866e4beda29243da0a', '6bb5f8afea31ef3e1e7bb3344b08009b', '4e1bb5a5602c3927cc2c07ac48e2bbe5',
      'cab1c3ab82bdd1897bf03edd69e2f4ea', '3b5a222efb5a2016506f9753203ea551', 'e34239b1e8a3868c789aa16036bafd70', '36832958d1a5ad76b9835525dd186570', 'a8a39bd2dbd03f6299f851a8d5e4a075',
      '56bee5bb255280c3927eb691ecd26740', '8724996697944d25738636b2382ac5a9', 'e878769dccc550af78a11bbb19634b42', 'fc10ecb7472575d4d42a3712199e49a8', 'd3d8d694df5da4b18db8c4f199306d5f',
      '027eda7086e8eab6c0f3e23138a3d1dd', 'c57ea3ddfd0ce5810b0e4b2a616571f9', 'f84cbe45c88327c3efa7ef99f419ea15', '4de84833031e8b221ac5957c9b8767bd', 'ecfca5a26b8a5959c1b5825e800fcfea',
      'ae0be434c10c14870930b787707ff413', '160512ee66cee6ff5f4bd0394008ce88', 'b124eba8255584b6f6149b99886224c3', '729ee1d736aeec45e956fb661df82ecb', 'b987c268ee78c3b25e7390a46433d93e', 
      '6425c3456f550064e9831cbd479abe32', '3b9fd71de9695ead62b08fa990106e04', '9fb114381d4932bd068275d5a964f2ab', 'd2245dad2c0de4c5eb013392c5eddc32', 'f4cf86ae7e2edbf0a32802e0a58c22ad',
      '4307a6026c11673d8137fb240393637c', 'fe99dc1eebd9634d67d52edbeba15af8', '22835ac37c9fbb1e0ee1dba2819bf2e9', 'b2d58abfa55b95b98e4632f0111ce077', '88e1daba605c7d1d5a54e04f00e12495',
      '33b1df83771b03f119ea13ddaf472069', 'dc94aabe7e8ddb62a9f687aef9e41d7d', '07dad4af60cb74158ca4fbae0b37c16f', '2aebdbfdf69d7dbecbd54e76fe716e5e', '7b8d8724cdab39a6dfb1a7f63411af17',
      '075632af64e3bb1134f241462d822d71', '4d64f616ce7a5a3c68a1b8514926cb93', 'fa9643cf99d05fea1a6ba64c14e9208f', '24869fd1d16d27501ce93874c6e5070b', '6cfb2be313962fe8bde8b1135c96de6d',
      '0ac4ae3446af6c7c202036363b9ec67e', 'c2ba78991cf102d23895f37013f414c0', 'e472acb667ca8bcc421c1eef917252ec', '9807a4101b41a305ae7e32d3604a3062', 'c81bfaaa2120b5efd4686b9a1d0d5180'
    ) OR TABLE_NAMES = '-- TREXVIADBSL --' THEN 'X' ELSE ' ' END R,
    ROOT_STATEMENT_HASH,
    LPAD(STATEMENT_THREAD_LIMIT, 3) STL,
    LPAD(STATEMENT_MEMORY_LIMIT, 4) SML,
    CALLER,
    CALLING,
    DB_USER,
    APP_NAME,
    APP_USER,
    APP_SOURCE,
    PASSPORT_COMPONENT,
    PASSPORT_ACTION,
    CLIENT_IP,
    LPAD(CLIENT_PID, 10) CLIENT_PID,
    STATEMENT_ID,
    LPAD(STATEMENT_EXECUTION_ID, 18) STAT_EXEC_ID,
    DURATION_MS,
    JOB_QUEUEING,
    TABLE_NAMES,
    LPAD(TRANS_ID, 8) TRANS_ID,
/*    ( SELECT
        MIN(STATEMENT_STRING)
      FROM
      ( SELECT
          MAP(T.SQL_TEXT_LENGTH, -1, STATEMENT_STRING, SUBSTR(STATEMENT_STRING, 1, T.SQL_TEXT_LENGTH)) STATEMENT_STRING
        FROM
        ( SELECT
            CASE
              WHEN FROM_POS <= 15 THEN
                STATEMENT_STRING
              ELSE
                SUBSTR(STATEMENT_STRING, 1, LOCATE(STATEMENT_STRING, CHAR(32))) || '...' || SUBSTR(STATEMENT_STRING, FROM_POS - 1)
            END STATEMENT_STRING
          FROM
          ( SELECT TO_VARCHAR(STATEMENT_STRING) STATEMENT_STRING, LOCATE(UPPER(TO_VARCHAR(STATEMENT_STRING)), ' FROM') FROM_POS
              FROM M_SQL_PLAN_CACHE P WHERE T.STATEMENT_HASH != CHAR(63) AND P.STATEMENT_HASH = T.STATEMENT_HASH UNION
            SELECT TO_VARCHAR(STATEMENT_STRING) STATEMENT_STRING, LOCATE(UPPER(TO_VARCHAR(STATEMENT_STRING)), ' FROM') FROM_POS
              FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE P WHERE T.STATEMENT_HASH != CHAR(63) AND P.STATEMENT_HASH = T.STATEMENT_HASH
          )
        )
      )
    ) */ '' SQL_TEXT,
    OTHERS_MAX_PCT,
    ORDER_BY
  FROM
  ( SELECT
      MIN(SAMPLE_TIME) MIN_SAMPLE_TIME,
      MAX(SAMPLE_TIME) MAX_SAMPLE_TIME,
      SECONDS_BETWEEN(MIN(MIN(SAMPLE_TIME)) OVER (), MAX(MAX(SAMPLE_TIME)) OVER ()) SECONDS,
      COUNT(*) NUM_SAMPLES,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME')          != 0
        THEN
          CASE
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00',
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)),
'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any'
      END SAMPLE_TIME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')               != 0 THEN T.HOST                        ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                                     END HOST,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')               != 0 THEN TO_VARCHAR(T.PORT)            ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                                     END PORT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')          != 0 THEN TO_VARCHAR(T.THREAD_ID)       ELSE MAP(BI.THREAD_ID, -1, 'any', TO_VARCHAR(BI.THREAD_ID))                END THREAD_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TRANS_ID')           != 0 THEN TO_VARCHAR(T.TRANS_ID)        ELSE MAP(BI.TRANS_ID, -1, 'any', TO_VARCHAR(BI.TRANS_ID))                  END TRANS_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')        != 0 THEN T.THREAD_TYPE                 ELSE MAP(BI.THREAD_TYPE, '%', 'any', BI.THREAD_TYPE)                       END THREAD_TYPE,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD')      != 0 THEN T.THREAD_METHOD               ELSE MAP(BI.THREAD_METHOD, '%', 'any', BI.THREAD_METHOD)                   END THREAD_METHOD,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')       != 0 THEN T.THREAD_STATE                ELSE MAP(BI.THREAD_STATE, '%', 'any', BI.THREAD_STATE)                     END THREAD_STATE,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL')      != 0 THEN T.THREAD_DETAIL               ELSE MAP(BI.THREAD_DETAIL, '%', 'any', BI.THREAD_DETAIL)                   END THREAD_DETAIL,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN T.STATEMENT_HASH              ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)                 END STATEMENT_HASH,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ROOT')               != 0 THEN T.ROOT_STATEMENT_HASH         ELSE MAP(BI.ROOT_STATEMENT_HASH, '%', 'any', BI.ROOT_STATEMENT_HASH)       END ROOT_STATEMENT_HASH,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_THR_LMT')       != 0 THEN TO_VARCHAR(T.STATEMENT_THREAD_LIMIT) ELSE MAP(BI.STATEMENT_THREAD_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_THREAD_LIMIT)) END STATEMENT_THREAD_LIMIT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_MEM_LMT')       != 0 THEN TO_VARCHAR(T.STATEMENT_MEMORY_LIMIT) ELSE MAP(BI.STATEMENT_MEMORY_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_MEMORY_LIMIT)) END STATEMENT_MEMORY_LIMIT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATEMENT_ID')       != 0 THEN T.STATEMENT_ID                ELSE MAP(BI.STATEMENT_ID, '%', 'any', BI.STATEMENT_ID)                     END STATEMENT_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STAT_EXEC_ID')       != 0 THEN TO_VARCHAR(T.STATEMENT_EXECUTION_ID) ELSE MAP(BI.STATEMENT_EXECUTION_ID, '%', 'any', BI.STATEMENT_EXECUTION_ID) END STATEMENT_EXECUTION_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')            != 0 THEN TO_VARCHAR(T.CONN_ID)         ELSE MAP(BI.CONN_ID, -2, 'any', TO_VARCHAR(BI.CONN_ID))                    END CONN_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')            != 0 THEN T.DB_USER                     ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                               END DB_USER,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')           != 0 THEN T.APP_NAME                    ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                             END APP_NAME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')           != 0 THEN T.APP_USER                    ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                             END APP_USER,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')         != 0 THEN T.APP_SOURCE                  ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                         END APP_SOURCE,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_IP')          != 0 THEN TO_VARCHAR(T.CLIENT_IP)       ELSE MAP(BI.CLIENT_IP, '%', 'any', BI.CLIENT_IP)                           END CLIENT_IP,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_PID')         != 0 THEN TO_VARCHAR(T.CLIENT_PID)      ELSE MAP(BI.CLIENT_PID, -1, 'any', TO_VARCHAR(BI.CLIENT_PID))              END CLIENT_PID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NUMA_NODE')          != 0 THEN TO_VARCHAR(T.NUMA_NODE)       ELSE MAP(BI.NUMA_NODE, -1, 'any', TO_VARCHAR(BI.NUMA_NODE))                END NUMA_NODE,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')          != 0 THEN T.LOCK_NAME                   ELSE MAP(BI.LOCK_NAME, '%', 'any', BI.LOCK_NAME)                           END LOCK_NAME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCKS_OWNED')        != 0 THEN T.LOCKS_OWNED                 ELSE 'any'                                                                 END LOCKS_OWNED,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'BLK_THREAD')         != 0 THEN TO_VARCHAR(T.BLOCKING_THREAD) ELSE 'any'                                                                 END BLOCKING_THREAD,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLER')             != 0 THEN T.CALLER                      ELSE 'any'                                                                 END CALLER,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLING')            != 0 THEN T.CALLING                     ELSE 'any'                                                                 END CALLING,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'QUEUEING')           != 0 THEN T.JOB_QUEUEING                ELSE MAP(BI.JOB_QUEUEING, '%', 'any', BI.JOB_QUEUEING)                     END JOB_QUEUEING,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION')    != 0 THEN T.PASSPORT_ACTION             ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)               END PASSPORT_ACTION,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMPONENT') != 0 THEN T.PASSPORT_COMPONENT          ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)         END PASSPORT_COMPONENT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')              != 0 OR INSTR(BI.AGGREGATE_BY, 'HASH') != 0
                                                                                            THEN IFNULL(HTM.TABLE_NAMES, IFNULL(HTM2.TABLE_NAMES, '')) ELSE MAP(BI.TABLE_NAMES, '%', 'any', BI.TABLE_NAMES) END TABLE_NAMES,
      MAP(BI.DURATION_AGGREGATION_TYPE, 'MAX', MAX(DURATION_MS), 'AVG', AVG(DURATION_MS), 'SUM', SUM(DURATION_MS)) DURATION_MS,
      BI.OTHERS_MAX_PCT,
      BI.SQL_TEXT_LENGTH,
      BI.MIN_SAMPLES,
      BI.ORDER_BY,
      MAP(BI.DATA_SOURCE, 'CURRENT', I.SAMPLE_INTERVAL, I.SAMPLE_INTERVAL * 50) SAMPLE_INTERVAL
    FROM
      BASIS_INFO BI,
    ( SELECT
        MAX(VALUE) SAMPLE_INTERVAL
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE
        FILE_NAME = 'global.ini' AND
        SECTION = 'resource_tracking' AND
        KEY = 'service_thread_sampling_monitor_sample_interval'
    ) I,
    ( SELECT
        DATA_SOURCE,
        HOST,
        PORT,
        SAMPLE_TIME,
        THREAD_ID,
        MAP(THREAD_TYPE, CHAR(63), THREAD_METHOD, THREAD_TYPE) THREAD_TYPE,
        MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE, THREAD_METHOD) THREAD_METHOD,
        MAP(THREAD_DETAIL, CHAR(63), MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE,   THREAD_METHOD), THREAD_DETAIL) THREAD_DETAIL,
        THREAD_STATE,
        DURATION_MS,
        CASE
          WHEN STATEMENT_HASH = CHAR(63) AND UPPER(THREAD_DETAIL) LIKE 'MDX%' THEN 'no SQL (MDX)'
          WHEN STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE, THREAD_METHOD) || ')'
          ELSE STATEMENT_HASH
        END STATEMENT_HASH,
        CASE
          WHEN ROOT_STATEMENT_HASH = CHAR(63) AND UPPER(THREAD_DETAIL) LIKE 'MDX%' THEN 'no SQL (MDX)'
          WHEN ROOT_STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE, THREAD_METHOD) || ')'
          ELSE ROOT_STATEMENT_HASH
        END ROOT_STATEMENT_HASH,
        STATEMENT_THREAD_LIMIT,
        STATEMENT_MEMORY_LIMIT,
        STATEMENT_ID,
        STATEMENT_EXECUTION_ID,
        CONN_ID,
        DB_USER,
        MAP(APP_NAME, CHAR(63), MAP(THREAD_TYPE, CHAR(63), THREAD_METHOD, THREAD_TYPE), APP_NAME) APP_NAME,
        APP_USER,
        MAP(APP_SOURCE, CHAR(63), MAP(THREAD_TYPE, CHAR(63), THREAD_METHOD, THREAD_TYPE), APP_SOURCE) APP_SOURCE,
        CLIENT_IP,
        CLIENT_PID,
        LOCK_COMPONENT,
        LOCK_NAME,
        LOCKS_OWNED,
        BLOCKING_THREAD,
        CALLER,
        CALLING,
        NUMA_NODE,
        JOB_QUEUEING,
        TRANS_ID,
        PASSPORT_ACTION,
        PASSPORT_COMPONENT
      FROM
      ( SELECT
          'CURRENT' DATA_SOURCE,
          HOST,
          PORT,
          TIMESTAMP SAMPLE_TIME,
          THREAD_ID,
          CASE
            WHEN THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
            ELSE THREAD_TYPE
          END THREAD_TYPE,
          CASE
            WHEN THREAD_METHOD LIKE 'GCJob%' THEN 'GCJob'
            ELSE THREAD_METHOD
          END THREAD_METHOD,
          THREAD_STATE,
          THREAD_DETAIL,
          DURATION DURATION_MS,
          STATEMENT_HASH,
          ROOT_STATEMENT_HASH,
          STATEMENT_THREAD_LIMIT,
          STATEMENT_MEMORY_LIMIT,
          STATEMENT_ID,
          TO_VARCHAR(STATEMENT_EXECUTION_ID) STATEMENT_EXECUTION_ID,
          CONNECTION_ID CONN_ID,
          USER_NAME DB_USER,
          APPLICATION_NAME APP_NAME,
          APPLICATION_USER_NAME APP_USER,
          APPLICATION_SOURCE APP_SOURCE,
          CLIENT_IP,
          CLIENT_PID,
          LOCK_WAIT_COMPONENT LOCK_COMPONENT,
          CASE
            WHEN LOCK_WAIT_NAME LIKE '%[%:%]@%:%' THEN
              SUBSTR(LOCK_WAIT_NAME, LOCATE(LOCK_WAIT_NAME, '[') + 1, LOCATE(LOCK_WAIT_NAME, ':') - LOCATE(LOCK_WAIT_NAME, '[')) ||
              SUBSTR(LOCK_WAIT_NAME, LOCATE(LOCK_WAIT_NAME, ':' || CHAR(32)) + 1)
            ELSE
              LOCK_WAIT_NAME
          END LOCK_NAME,
          LOCK_OWNER_THREAD_ID BLOCKING_THREAD,
          LOCKS_OWNED,
          CALLER,
          CALLING,
          IFNULL(NUMA_NODE_INDEX, -2) NUMA_NODE,
          CASE WHEN THREAD_STATE = 'Job Exec Waiting' AND LOCK_WAIT_NAME != 'envCondStat' AND CALLING = '' THEN 'X' ELSE '' END JOB_QUEUEING,
          TRANSACTION_ID TRANS_ID,
          IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
          IFNULL(PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT
        FROM
          M_SERVICE_THREAD_SAMPLES
        UNION ALL
        ( SELECT
          'HISTORY' DATA_SOURCE,
          HOST,
          PORT,
          TIMESTAMP SAMPLE_TIME,
          THREAD_ID,
          CASE
            WHEN THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
            ELSE THREAD_TYPE
          END THREAD_TYPE,
          CASE
            WHEN THREAD_METHOD LIKE 'GCJob%' THEN 'GCJob'
            ELSE THREAD_METHOD
          END THREAD_METHOD,
          THREAD_STATE,
          IFNULL(THREAD_DETAIL, '') THREAD_DETAIL,
          DURATION DURATION_MS,
          IFNULL(STATEMENT_HASH, '') STATEMENT_HASH,
          IFNULL(ROOT_STATEMENT_HASH, '') ROOT_STATEMENT_HASH,
          STATEMENT_THREAD_LIMIT,
          STATEMENT_MEMORY_LIMIT,
          IFNULL(STATEMENT_ID, '') STATEMENT_ID,
          TO_VARCHAR(STATEMENT_EXECUTION_ID) STATEMENT_EXECUTION_ID,
          CONNECTION_ID CONN_ID,
          IFNULL(USER_NAME, '') DB_USER,
          IFNULL(APPLICATION_NAME, '') APP_NAME,
          IFNULL(APPLICATION_USER_NAME, '') APP_USER,
          IFNULL(APPLICATION_SOURCE, '') APP_SOURCE,
          CLIENT_IP,
          CLIENT_PID,
          LOCK_WAIT_COMPONENT LOCK_COMPONENT,
          CASE
            WHEN LOCK_WAIT_NAME LIKE '%[%:%]@%:%' THEN
              SUBSTR(LOCK_WAIT_NAME, LOCATE(LOCK_WAIT_NAME, '[') + 1, LOCATE(LOCK_WAIT_NAME, ':') - LOCATE(LOCK_WAIT_NAME, '[')) ||
              SUBSTR(LOCK_WAIT_NAME, LOCATE(LOCK_WAIT_NAME, ':' || CHAR(32)) + 1)
            ELSE
              LOCK_WAIT_NAME
          END LOCK_NAME,
          LOCK_OWNER_THREAD_ID BLOCKING_THREAD,
          LOCKS_OWNED,
          CALLER,
          CALLING,
          IFNULL(NUMA_NODE_INDEX, -2) NUMA_NODE,
          CASE WHEN THREAD_STATE = 'Job Exec Waiting' AND LOCK_WAIT_NAME != 'envCondStat' AND CALLING = '' THEN 'X' ELSE '' END JOB_QUEUEING,
          TRANSACTION_ID TRANS_ID,
          IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
          IFNULL(PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT
        FROM
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES
        )
      )
    ) T LEFT OUTER JOIN
      HASH_TABLE_MAPPING HTM ON
        HTM.STATEMENT_HASH = T.STATEMENT_HASH LEFT OUTER JOIN
      HASH_TABLE_MAPPING HTM2 ON
        HTM.STATEMENT_HASH = T.ROOT_STATEMENT_HASH
    WHERE
      T.HOST LIKE BI.HOST AND
      TO_VARCHAR(T.PORT) LIKE BI.PORT AND
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
      ( BI.THREAD_ID = -1 OR T.THREAD_ID = BI.THREAD_ID ) AND
      ( BI.TRANS_ID = -1 OR T.TRANS_ID = BI.TRANS_ID ) AND
      T.THREAD_TYPE LIKE BI.THREAD_TYPE AND
      T.THREAD_STATE LIKE BI.THREAD_STATE AND
      T.JOB_QUEUEING LIKE BI.JOB_QUEUEING AND
      UPPER(IFNULL(T.THREAD_DETAIL, '')) LIKE UPPER(BI.THREAD_DETAIL) AND
      UPPER(IFNULL(T.THREAD_METHOD, '')) LIKE UPPER(BI.THREAD_METHOD) AND
      SUBSTR(T.STATEMENT_HASH, 1, 31) LIKE SUBSTR(BI.STATEMENT_HASH, 1, 31) AND         /* sometimes only 31 out of 32 bytes were stored in thread samples */
      T.ROOT_STATEMENT_HASH LIKE BI.ROOT_STATEMENT_HASH AND
      ( BI.STATEMENT_THREAD_LIMIT = -1 OR T.STATEMENT_THREAD_LIMIT = BI.STATEMENT_THREAD_LIMIT ) AND
      ( BI.STATEMENT_MEMORY_LIMIT = -1 OR T.STATEMENT_MEMORY_LIMIT = BI.STATEMENT_MEMORY_LIMIT ) AND
      T.STATEMENT_ID LIKE BI.STATEMENT_ID AND
      T.STATEMENT_EXECUTION_ID LIKE BI.STATEMENT_EXECUTION_ID AND
      T.DB_USER LIKE BI.DB_USER AND
      T.APP_USER LIKE BI.APP_USER AND
      T.APP_NAME LIKE BI.APP_NAME AND
      T.APP_SOURCE LIKE BI.APP_SOURCE AND
      T.LOCK_NAME LIKE BI.LOCK_NAME AND
      T.LOCKS_OWNED LIKE BI.LOCKS_OWNED AND
      ( BI.NUMA_NODE = -1 OR T.NUMA_NODE = BI.NUMA_NODE ) AND
      IFNULL(T.CLIENT_IP, '') LIKE BI.CLIENT_IP AND
      ( BI.CLIENT_PID = -1 OR T.CLIENT_PID = BI.CLIENT_PID ) AND
      ( BI.CONN_ID = -2 OR T.CONN_ID = BI.CONN_ID ) AND
      ( BI.ONLY_EXTERNAL_CONNECTIONS = ' ' OR T.CONN_ID > 0 ) AND
      ( T.PASSPORT_ACTION LIKE BI.PASSPORT_ACTION ) AND
      ( T.PASSPORT_COMPONENT LIKE BI.PASSPORT_COMPONENT ) AND
      IFNULL(HTM.TABLE_NAMES, '') LIKE BI.TABLE_NAMES AND
      ( BI.MIN_DURATION_MS = -1 OR T.DURATION_MS >= BI.MIN_DURATION_MS ) AND
      ( BI.ONLY_FULL_SCAN_METHODS = ' ' OR
        ( T.THREAD_METHOD LIKE '%Scan%Job%' AND NOT T.THREAD_METHOD IN ( 'DictScanJob', 'ItabScanJob', 'ScanJob' ) ) OR
        UPPER(T.THREAD_METHOD) LIKE '%MGETSEARCH%' OR
        T.THREAD_METHOD IN ( 'HEX job running hex::cs::TableScanScheduleOp', 'HEX job running hex::operators::TableScanScheduleOp',
                             'JEJobReadIndexChunked', 'scanWithoutIndex', 'searchDocumentsIterateDocidsParallel', 'sparseSearch' )
      ) AND
      ( BI.ONLY_DELTA_STORAGE_WAITS = ' ' OR
        ( T.STATEMENT_HASH NOT LIKE 'no SQL%' AND
          ( T.THREAD_STATE = 'Sleeping' OR
            T.LOCK_NAME IN ('BTree GuardContainer', 'Sleep Semaphore')
          )
        )
      ) AND
      ( BI.ONLY_TABLE_OPTIMIZATIONS = ' ' OR
        T.THREAD_TYPE IN
        ( 'MergeAttributeThread', 'Merge Delta Index', 'MergedogMerger', 'MergedogMonitor', 'SaveMergedAttributeThread', 'SmartMerger'
        ) OR
        T.THREAD_METHOD IN
        ( 'admin/mergeDeltaIndex', 'admin/mergeDeltaIndexForParts', 'changeCompression', 'ChangeCompressionJob', 'changeRowOrder', 'csddl/OptimizeCompressionData',
          'delta merge move rows', 'estimateCompression', 'EstimateCompressionJob', 'getMostFrequentValueInfos',
          'GetOptimizerCandidateJob', 'merge', 'merge delta', 'MergeDuringRecoveryJob_DeltaToMainMerge',
          'MergeDuringRecoveryJob_OptimizeCompression', 'optimize compression', 'OptimizeCompressionData', 'postProcessScanVecResult',
          'prepareDeltaMerge', 'prepareDeltaMergeSave', 'PrepareOptimizationsJob', 'PrepareRenumberJob',
          'sortBlocksByRowID', 'SortByRowIdJob', 'sortRestRanges', 'SortRestRangeJob', 'UpdateMostFrequentValueCountJob'
        ) OR
        UPPER(T.THREAD_DETAIL) LIKE '%MERGE DELTA OF%' OR
        UPPER(T.THREAD_DETAIL) LIKE '%UPDATE%WITH PARAMETERS%OPTIMIZE_COMPRESSION%'
      ) AND
      ( BI.EXCLUDE_SERVICE_THREAD_SAMPLER = ' ' OR T.THREAD_TYPE != 'service thread sampler' ) AND
      ( BI.EXCLUDE_NEGATIVE_THREAD_IDS = ' ' OR T.THREAD_ID >= 0 ) AND
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
      ( BI.EXCLUDE_EMPTY_STATEMENT_IDS = ' ' OR T.STATEMENT_ID != CHAR(63) ) AND
      ( BI.EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS = ' ' OR T.STATEMENT_EXECUTION_ID != TO_BIGINT(-1) ) AND
      BI.DATA_SOURCE = T.DATA_SOURCE
    GROUP BY
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME')          != 0
        THEN
          CASE
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00',
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)),
'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any'
      END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')               != 0 THEN T.HOST                        ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                                     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')               != 0 THEN TO_VARCHAR(T.PORT)            ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                                     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')          != 0 THEN TO_VARCHAR(T.THREAD_ID)       ELSE MAP(BI.THREAD_ID, -1, 'any', TO_VARCHAR(BI.THREAD_ID))                END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TRANS_ID')           != 0 THEN TO_VARCHAR(T.TRANS_ID)        ELSE MAP(BI.TRANS_ID, -1, 'any', TO_VARCHAR(BI.TRANS_ID))                  END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')        != 0 THEN T.THREAD_TYPE                 ELSE MAP(BI.THREAD_TYPE, '%', 'any', BI.THREAD_TYPE)                       END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD')      != 0 THEN T.THREAD_METHOD               ELSE MAP(BI.THREAD_METHOD, '%', 'any', BI.THREAD_METHOD)                   END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')       != 0 THEN T.THREAD_STATE                ELSE MAP(BI.THREAD_STATE, '%', 'any', BI.THREAD_STATE)                     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL')      != 0 THEN T.THREAD_DETAIL               ELSE MAP(BI.THREAD_DETAIL, '%', 'any', BI.THREAD_DETAIL)                   END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')               != 0 THEN T.STATEMENT_HASH              ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)                 END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ROOT')               != 0 THEN T.ROOT_STATEMENT_HASH         ELSE MAP(BI.ROOT_STATEMENT_HASH, '%', 'any', BI.ROOT_STATEMENT_HASH)       END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_THR_LMT')       != 0 THEN TO_VARCHAR(T.STATEMENT_THREAD_LIMIT) ELSE MAP(BI.STATEMENT_THREAD_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_THREAD_LIMIT)) END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STMT_MEM_LMT')       != 0 THEN TO_VARCHAR(T.STATEMENT_MEMORY_LIMIT) ELSE MAP(BI.STATEMENT_MEMORY_LIMIT, -1, 'any', TO_VARCHAR(BI.STATEMENT_MEMORY_LIMIT)) END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATEMENT_ID')       != 0 THEN T.STATEMENT_ID                ELSE MAP(BI.STATEMENT_ID, '%', 'any', BI.STATEMENT_ID)                     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STAT_EXEC_ID')       != 0 THEN TO_VARCHAR(T.STATEMENT_EXECUTION_ID) ELSE MAP(BI.STATEMENT_EXECUTION_ID, '%', 'any', BI.STATEMENT_EXECUTION_ID) END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')            != 0 THEN TO_VARCHAR(T.CONN_ID)         ELSE MAP(BI.CONN_ID, -2, 'any', TO_VARCHAR(BI.CONN_ID))                    END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')            != 0 THEN T.DB_USER                     ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                               END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')           != 0 THEN T.APP_NAME                    ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                             END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')           != 0 THEN T.APP_USER                    ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                             END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')         != 0 THEN T.APP_SOURCE                  ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                         END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_IP')          != 0 THEN TO_VARCHAR(T.CLIENT_IP)       ELSE MAP(BI.CLIENT_IP, '%', 'any', BI.CLIENT_IP)                           END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CLIENT_PID')         != 0 THEN TO_VARCHAR(T.CLIENT_PID)      ELSE MAP(BI.CLIENT_PID, -1, 'any', TO_VARCHAR(BI.CLIENT_PID))              END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NUMA_NODE')          != 0 THEN TO_VARCHAR(T.NUMA_NODE)       ELSE MAP(BI.NUMA_NODE, -1, 'any', TO_VARCHAR(BI.NUMA_NODE))                END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')          != 0 THEN T.LOCK_NAME                   ELSE MAP(BI.LOCK_NAME, '%', 'any', BI.LOCK_NAME)                           END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCKS_OWNED')        != 0 THEN T.LOCKS_OWNED                 ELSE 'any'                                                                 END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'BLK_THREAD')         != 0 THEN TO_VARCHAR(T.BLOCKING_THREAD) ELSE 'any'                                                                 END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLER')             != 0 THEN T.CALLER                      ELSE 'any'                                                                 END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLING')            != 0 THEN T.CALLING                     ELSE 'any'                                                                 END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'QUEUEING')           != 0 THEN T.JOB_QUEUEING                ELSE MAP(BI.JOB_QUEUEING, '%', 'any', BI.JOB_QUEUEING)                     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION')    != 0 THEN T.PASSPORT_ACTION             ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)               END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMPONENT') != 0 THEN T.PASSPORT_COMPONENT          ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)         END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')              != 0 OR INSTR(BI.AGGREGATE_BY, 'HASH') != 0
                                                                                            THEN IFNULL(HTM.TABLE_NAMES, IFNULL(HTM2.TABLE_NAMES, '')) ELSE MAP(BI.TABLE_NAMES, '%', 'any', BI.TABLE_NAMES) END,
      BI.DURATION_AGGREGATION_TYPE,
      BI.OTHERS_MAX_PCT,
      BI.SQL_TEXT_LENGTH,
      BI.MIN_SAMPLES,
      BI.DATA_SOURCE,
      BI.ORDER_BY,
      I.SAMPLE_INTERVAL
  ) T
  WHERE
    ( MIN_SAMPLES = -1 OR NUM_SAMPLES >= MIN_SAMPLES )
)
GROUP BY
  SAMPLE_TIME,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(HOST,                'any', 'any', '-- Others --') ELSE HOST                END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(PORT),         'any', 'any', '-- Others --') ELSE PORT                END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(NUMA_NODE),    'any', 'any', '-- Others --') ELSE NUMA_NODE           END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STL,                 'any', 'any', '-- Others --') ELSE STL                 END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(SML,                 'any', 'any', '-- Others --') ELSE SML                 END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CONN_ID),      'any', 'any', '-- Others --') ELSE CONN_ID             END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(THREAD_ID),    'any', 'any', '-- Others --') ELSE THREAD_ID           END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(TABLE_NAMES,         'any', 'any', '-- Others --') ELSE TABLE_NAMES         END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_HASH,      'any', 'any', '-- Others --') ELSE R                   END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_TYPE,         'any', 'any', '-- Others --') ELSE THREAD_TYPE         END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_METHOD,       'any', 'any', '-- Others --') ELSE THREAD_METHOD       END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_STATE,        'any', 'any', '-- Others --') ELSE THREAD_STATE        END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(JOB_QUEUEING,        'any', 'any', '-- Others --') ELSE JOB_QUEUEING        END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LOCK_NAME,           'any', 'any', '-- Others --') ELSE LOCK_NAME           END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_HASH,      'any', 'any', '-- Others --') ELSE STATEMENT_HASH      END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(THREAD_DETAIL,       'any', 'any', '-- Others --') ELSE THREAD_DETAIL       END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(DB_USER,             'any', 'any', '-- Others --') ELSE DB_USER             END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_NAME,            'any', 'any', '-- Others --') ELSE APP_NAME            END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_USER,            'any', 'any', '-- Others --') ELSE APP_USER            END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(APP_SOURCE,          'any', 'any', '-- Others --') ELSE APP_SOURCE          END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(PASSPORT_COMPONENT,  'any', 'any', '-- Others --') ELSE PASSPORT_COMPONENT  END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(PASSPORT_ACTION,     'any', 'any', '-- Others --') ELSE PASSPORT_ACTION     END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CLIENT_IP,           'any', 'any', '-- Others --') ELSE CLIENT_IP           END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CLIENT_PID),   'any', 'any', '-- Others --') ELSE CLIENT_PID          END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(STAT_EXEC_ID), 'any', 'any', '-- Others --') ELSE STAT_EXEC_ID        END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(BLOCKING_THREAD,     'any', 'any', '-- Others --') ELSE BLOCKING_THREAD     END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LOCKS_OWNED,         'any', 'any', '-- Others --') ELSE LOCKS_OWNED         END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CALLER,              'any', 'any', '-- Others --') ELSE CALLER              END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(CALLING,             'any', 'any', '-- Others --') ELSE CALLING             END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(STATEMENT_ID,        'any', 'any', '-- Others --') ELSE STATEMENT_ID        END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(ROOT_STATEMENT_HASH, 'any', 'any', '-- Others --') ELSE ROOT_STATEMENT_HASH END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(TRANS_ID),     'any', 'any', '-- Others --') ELSE TRANS_ID            END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(SQL_TEXT,            'any', 'any', '-- Others --') ELSE SQL_TEXT            END,
  ORDER_BY
ORDER BY
  MAP(ORDER_BY, 'COUNT', SUM(NUM_SAMPLES)) DESC,
  MAP(ORDER_BY, 'TIME', SAMPLE_TIME) DESC,
  MAP(ORDER_BY, 'CONN_ID', CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CONN_ID), 'any', 'any', '-- Others --') ELSE CONN_ID END),
  SUM(NUM_SAMPLES) DESC,
  SAMPLE_TIME DESC,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(CONN_ID), 'any', 'any', '-- Others --') ELSE CONN_ID || TRANS_ID END,
  CASE WHEN PERCENT <= OTHERS_MAX_PCT THEN MAP(LTRIM(THREAD_ID), 'any', 'any', '-- Others --') ELSE THREAD_ID END
WITH HINT (IGNORE_PLAN_CACHE)
