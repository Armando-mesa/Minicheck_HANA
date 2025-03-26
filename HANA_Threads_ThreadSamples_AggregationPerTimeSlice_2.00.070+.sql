SELECT
/* 

[NAME]

- HANA_Threads_ThreadSamples_AggregationPerTimeSlice_2.00.070+

[DESCRIPTION]

- Aggregation of thread samples on time slice basis (1 row with top areas per time interval)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- DURATION not available before SAP HANA 1.0 SPS 08
- M_SERVICE_THREAD_SAMPLES.STATEMENT_EXECUTION_ID available as of Rev. 1.00.120
- HOST_SERVICE_THREAD_SAMPLES.STATEMENT_EXECUTION_ID available with 1.00.122.05 and 2.00.001
- NUMA_NODE_INDEX and ROOT_STATEMENT_HASH available starting with SAP HANA 2.00.040
- SITE_ID in history tables available with SAP HANA >= 2.0 SPS 06
- APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE available with SAP HANA >= 2.00.070

[VALID FOR]

- Revisions:              >= 2.00.070

[SQL COMMAND VERSION]

- 2014/03/13:  1.0 (initial version)
- 2014/12/22:  1.1 (HOST_SERVICE_THREAD_SAMPLES included)
- 2015/03/25:  1.2 (filter and aggregation for LOCK_TYPE and LOCK_NAME included)
- 2015/04/29:  1.2 (CLIENT_IP and DB_USER included)
- 2016/02/14:  1.3 (STATEMENT_ID included)
- 2016/06/15:  1.4 (Top 5 -> Top 10)
- 2017/02/03:  1.5 (EXCLUDE_PHANTOM_THREADS included)
- 2017/10/27:  1.6 (TIMEZONE included)
- 2017/10/30:  1.7 (RESULT_ROWS added)
- 2018/02/06:  1.8 (dedicated 1.00.122.05+ version including STATEMENT_EXECUTION_ID aggregation)
- 2018/02/07:  1.9 (EXCLUDE_EMPTY_STATEMENT_IDS and EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS included)
- 2018/12/04:  2.0 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/01/08:  2.1 (MIN_SAMPLES_TOTAL included)
- 2019/05/14:  2.2 (dedicated 2.00.040+ version including NUMA_NODE)
- 2019/07/13:  2.3 (ROOT_STATEMENT_HASH included)
- 2020/07/02:  2.4 (STATEMENT_THREAD_LIMIT added)
- 2020/07/16:  2.5 (JOB_QUEUEING / Q added)
- 2020/11/19:  2.6 (ONLY_DELTA_STORAGE_WAITS added)
- 2021/09/11:  2.7 (PASSPORT related information included)
- 2022/05/26:  2.8 (dedicated 2.00.060+ version including SITE_ID for data source HISTORY)
- 2023/10/29:  2.9 (dedicated 2.00.070+ version including APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE)
- 2024/01/08:  3.0 (WORKLOAD_CLASS included)

[INVOLVED TABLES]

- M_SERVICE_THREAD_SAMPLES
- HOST_SERVICE_THREAD_SAMPLES

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

- SITE_ID

  System replication site ID (may only work for DATA_SOURCE = 'HISTORY')

  -1             --> No restriction related to site ID
  1              --> Site id 1

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

- THREAD_ID

  Thread identifier

  4567            --> Thread 4567
  -1              --> No thread identifier restriction

- THREAD_TYPE

  Type of thread (e.g. 'SqlExecutor', 'JobWorker' or 'MergedogMonitor')

  'SqlExecutor'   --> Threads with type 'SqlExecutor'
  '%'             --> No thread type restriction

- THREAD_STATE 

  State of thread (e.g. e.g. 'Running', 'Network Read' or 'Semaphore Wait')

  'Running'       --> Threads with state 'Running'
  '%'             --> No thread state restriction

- STATEMENT_HASH
 
  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction

- ROOT_STATEMENT_HASH
 
  Root statement hash (e.g. hash of procedure responsible for statement execution)

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> Root statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No root statement hash restriction

- STATEMENT_THREAD_LIMIT

  Statement thread limit

  24                --> List threads belonging to a workload class with a limitation to 24 threads
  -1                --> No restriction related to statement thread limit

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

- LOCK_TYPE

  Lock type / component

  'Basis System'  --> Display samples with lock type 'Basis System'
  '%'             --> No restriction related to lock type  

- LOCK_NAME

  Lock name

  'transLock'     --> Display threads waiting for transLock
  '%'             --> No restriction related to lock waits

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
  -1              --> No connection ID restriction

- PASSPORT_COMPONENT

  Passport component

  'P24/sapabap01_P24_27' --> Passport component P24/sapabap01_P24_27
  '%'                    --> No restriction related to passport component

- PASSPORT_ACTION

  Passport action

  'SAPMSSY1'      --> Passport action SAPMSSY1
  '%'             --> No restriction related to passport action 

- WORKLOAD_CLASS

  Workload class name

  'MY_WKLD'       --> Workload class MY_WKLD
  '%'             --> No restriction related to workload class name

- JOB_QUEUEING

  Job queueing state

  'X'             --> Thread currently waits for assignment of JobWorker (THREAD_STATE = 'Job Exec Waiting', CALLING = '')
  ' '             --> Thread does not wait for JobWorker assignment

- MIN_SAMPLES_TOTAL

  Minimum threshold for total samples

  10              --> Only display time slices with at least 10 total samples
  -1              --> No restriction related to total samples

- TIME_SLICE_S

  Time intervals for aggregation

  10              --> Aggregation on a 10 seconds basis
  900             --> Aggregation on a 15 minutes basis

- ONLY_DELTA_STORAGE_WAITS

  Possibility to restrict results to delta storage related states / locks (e.g. "BTree GuardContainer")

  'X'             --> Only display samples with methods linked to delta storage waits
  ' '             --> No restriction related to delta storage waits

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

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)
  '%'             --> All data sources

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOST'          --> Aggregation by HOST

- RESULT_ROWS

  Number of records to be returned by the query

  100             --> Return a maximum number of 100 records
  -1              --> Return all records

[OUTPUT PARAMETERS]

- SNAPSHOT_TIME:    Begin time of considered time interval
- KEY_FIGURE:       Key figure for which the top areas are determined
- SAMPLES_TOTAL:    Total number of samples in considered time interval
- ACT_THREADS:      Average number of total active threads
- DETAIL_<n>:       Top <n> area
- SAMPLES_<n>:      Number of thread samples for top <n> area
- PCT_<n>:          Percentage of top <n> area compared to overall value

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|BEGIN_TIME         |KEY_FIGURE  |SAMPLES_TOTAL|ACT_THREADS|DETAIL_1|SAMPLES_1|PCT_1|DETAIL_2        |SAMPLES_2|PCT_2|DETAIL_3        |SAMPLES_3|PCT_3|DETAIL_4                |SAMPLES_4|PCT_4|DETAIL_5        |SAMPLES_5|PCT_5|
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|2014/03/13 11:40:00|THREAD_STATE|         4451|       7.41|Running |     4422|   99|Job Exec Waiting|       18|    0|Network Read    |        9|    0|Network Write           |        1|    0|Semaphore Wait  |        1|    0|
|2014/03/13 11:30:00|THREAD_STATE|         4995|       8.32|Running |     4761|   95|Job Exec Waiting|      115|    2|Network Read    |       84|    2|Sleeping                |       14|    0|Network Write   |        9|    0|
|2014/03/13 11:20:00|THREAD_STATE|         4461|       7.43|Running |     4428|   99|Network Read    |       18|    0|Job Exec Waiting|       14|    0|Network Write           |        1|    0|                |         |    0|
|2014/03/13 11:10:00|THREAD_STATE|         4407|       7.34|Running |     4399|  100|Network Read    |        3|    0|Job Exec Waiting|        2|    0|Semaphore Wait          |        2|    0|Sleeping        |        1|    0|
|2014/03/13 11:00:00|THREAD_STATE|         4533|       7.55|Running |     4499|   99|Job Exec Waiting|       24|    1|Network Read    |        7|    0|Mutex Wait              |        3|    0|                |         |    0|
|2014/03/13 10:50:00|THREAD_STATE|         4544|       7.57|Running |     4503|   99|Job Exec Waiting|       29|    1|Network Read    |        8|    0|Mutex Wait              |        4|    0|                |         |    0|
|2014/03/13 10:40:00|THREAD_STATE|         4476|       7.46|Running |     4447|   99|Job Exec Waiting|       12|    0|Network Read    |       10|    0|Sleeping                |        2|    0|Semaphore Wait  |        2|    0|
|2014/03/13 10:30:00|THREAD_STATE|         5061|       8.43|Running |     4831|   95|Job Exec Waiting|      108|    2|Network Read    |       88|    2|Network Write           |       14|    0|Sleeping        |       12|    0|
|2014/03/13 10:20:00|THREAD_STATE|         4474|       7.45|Running |     4444|   99|Network Read    |       14|    0|Job Exec Waiting|       13|    0|Semaphore Wait          |        2|    0|Sleeping        |        1|    0|
|2014/03/13 10:10:00|THREAD_STATE|         4410|       7.35|Running |     4393|  100|Network Read    |        7|    0|Job Exec Waiting|        4|    0|Semaphore Wait          |        4|    0|Sleeping        |        1|    0|
|2014/03/13 10:00:00|THREAD_STATE|         4475|       7.45|Running |     4444|   99|Job Exec Waiting|       21|    0|Network Read    |        6|    0|Semaphore Wait          |        3|    0|Network Write   |        1|    0|
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  SNAPSHOT_TIME,
  KEY_FIGURE,
  SAMPLES_TOTAL,
  ACT_THREADS,
  DETAIL_1,
  SAMPLES_1,
  PCT_1,
  DETAIL_2,
  SAMPLES_2,
  PCT_2,
  DETAIL_3,
  SAMPLES_3,
  PCT_3,
  DETAIL_4,
  SAMPLES_4,
  PCT_4,
  DETAIL_5,
  SAMPLES_5,
  PCT_5,
  DETAIL_6,
  SAMPLES_6,
  PCT_6,
  DETAIL_7,
  SAMPLES_7,
  PCT_7,
  DETAIL_8,
  SAMPLES_8,
  PCT_8,
  DETAIL_9,
  SAMPLES_9,
  PCT_9,
  DETAIL10,
  SAMPLES10,
  PCT10
FROM
( SELECT
    DISTINCT
    BEGIN_TIME SNAPSHOT_TIME,
    KEY_FIGURE,
    SAMPLES_TOTAL,
    ACT_THREADS,
    IFNULL(TO_VARCHAR(MAX(DETAIL_1)), '') DETAIL_1,
    IFNULL(LPAD(MAX(SAMPLES_1), 9), '') SAMPLES_1,
    IFNULL(LPAD(MAX(PCT_1), 5), '') PCT_1,
    IFNULL(TO_VARCHAR(MAX(DETAIL_2)), '') DETAIL_2,
    IFNULL(LPAD(MAX(SAMPLES_2), 9), '') SAMPLES_2,
    IFNULL(LPAD(MAX(PCT_2), 5), '') PCT_2,
    IFNULL(TO_VARCHAR(MAX(DETAIL_3)), '') DETAIL_3,
    IFNULL(LPAD(MAX(SAMPLES_3), 9), '') SAMPLES_3,
    IFNULL(LPAD(MAX(PCT_3), 5), '') PCT_3,
    IFNULL(TO_VARCHAR(MAX(DETAIL_4)), '') DETAIL_4,
    IFNULL(LPAD(MAX(SAMPLES_4), 9), '') SAMPLES_4,
    IFNULL(LPAD(MAX(PCT_4), 5), '') PCT_4,
    IFNULL(TO_VARCHAR(MAX(DETAIL_5)), '') DETAIL_5,
    IFNULL(LPAD(MAX(SAMPLES_5), 9), '') SAMPLES_5,
    IFNULL(LPAD(MAX(PCT_5), 5), '') PCT_5,
    IFNULL(TO_VARCHAR(MAX(DETAIL_6)), '') DETAIL_6,
    IFNULL(LPAD(MAX(SAMPLES_6), 9), '') SAMPLES_6,
    IFNULL(LPAD(MAX(PCT_6), 5), '') PCT_6,
    IFNULL(TO_VARCHAR(MAX(DETAIL_7)), '') DETAIL_7,
    IFNULL(LPAD(MAX(SAMPLES_7), 9), '') SAMPLES_7,
    IFNULL(LPAD(MAX(PCT_7), 5), '') PCT_7,
    IFNULL(TO_VARCHAR(MAX(DETAIL_8)), '') DETAIL_8,
    IFNULL(LPAD(MAX(SAMPLES_8), 9), '') SAMPLES_8,
    IFNULL(LPAD(MAX(PCT_8), 5), '') PCT_8,
    IFNULL(TO_VARCHAR(MAX(DETAIL_9)), '') DETAIL_9,
    IFNULL(LPAD(MAX(SAMPLES_9), 9), '') SAMPLES_9,
    IFNULL(LPAD(MAX(PCT_9), 5), '') PCT_9,
    IFNULL(TO_VARCHAR(MAX(DETAIL_10)), '') DETAIL10,
    IFNULL(LPAD(MAX(SAMPLES_10), 9), '') SAMPLES10,
    IFNULL(LPAD(MAX(PCT_10), 5), '') PCT10,
    ROW_NUMBER () OVER (ORDER BY BEGIN_TIME DESC) ROWNO,
    RESULT_ROWS,
    MIN_SAMPLES_TOTAL
  FROM
  ( SELECT DISTINCT
      TO_VARCHAR(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS') BEGIN_TIME,
      AGGREGATE_BY KEY_FIGURE,
      LPAD(SUM(NUM_SAMPLES) OVER (PARTITION BY BEGIN_TIME), 13) SAMPLES_TOTAL,
      LPAD(TO_DECIMAL(SUM(ACT_THREADS) OVER (PARTITION BY BEGIN_TIME), 10, 2), 11) ACT_THREADS,
      NTH_VALUE(VALUE, 1) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_1,
      NTH_VALUE(NUM_SAMPLES, 1) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_1,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 1) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_1,
      NTH_VALUE(VALUE, 2) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_2,
      NTH_VALUE(NUM_SAMPLES, 2) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_2,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 2) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_2,
      NTH_VALUE(VALUE, 3) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_3,
      NTH_VALUE(NUM_SAMPLES, 3) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_3,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 3) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_3,
      NTH_VALUE(VALUE, 4) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_4,
      NTH_VALUE(NUM_SAMPLES, 4) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_4,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 4) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_4,
      NTH_VALUE(VALUE, 5) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_5,
      NTH_VALUE(NUM_SAMPLES, 5) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_5,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 5) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_5,
      NTH_VALUE(VALUE, 6) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_6,
      NTH_VALUE(NUM_SAMPLES, 6) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_6,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 6) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_6,
      NTH_VALUE(VALUE, 7) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_7,
      NTH_VALUE(NUM_SAMPLES, 7) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_7,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 7) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_7,
      NTH_VALUE(VALUE, 8) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_8,
      NTH_VALUE(NUM_SAMPLES, 8) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_8,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 8) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_8,
      NTH_VALUE(VALUE, 9) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_9,
      NTH_VALUE(NUM_SAMPLES, 9) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_9,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 9) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_9,
      NTH_VALUE(VALUE, 10) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) DETAIL_10,
      NTH_VALUE(NUM_SAMPLES, 10) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC) SAMPLES_10,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 10) OVER (PARTITION BY BEGIN_TIME ORDER BY NUM_SAMPLES DESC)), 10, 0) PCT_10,
      RESULT_ROWS,
      MIN_SAMPLES_TOTAL
    FROM
    ( SELECT
        BEGIN_TIME,
        AGGREGATE_BY,
        RESULT_ROWS,
        VALUE,
        COUNT(*) NUM_SAMPLES,
        COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY BEGIN_TIME) * 100 PERCENT,
        COUNT(*) * LEAST(SAMPLE_INTERVAL, TIME_SLICE_S)  / TIME_SLICE_S ACT_THREADS,
        MIN_SAMPLES_TOTAL
      FROM
      ( SELECT
          ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), 
            FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END) / BI.TIME_SLICE_S) * BI.TIME_SLICE_S) BEGIN_TIME,
          MAP(BI.AGGREGATE_BY,
            'HOST',               T.HOST,
            'PORT',               TO_VARCHAR(T.PORT),
            'THREAD_ID',          TO_VARCHAR(T.THREAD_ID),
            'THREAD_TYPE',        T.THREAD_TYPE,
            'THREAD_METHOD',      T.THREAD_METHOD,
            'THREAD_DETAIL',      T.THREAD_DETAIL,
            'THREAD_STATE',       T.THREAD_STATE,
            'STATE_LOCK',         T.THREAD_STATE || 
               CASE
                 WHEN T.LOCK_NAME IS NULL OR T.LOCK_NAME = '' OR T.LOCK_NAME = CHAR(63) THEN ''
                 WHEN T.THREAD_STATE = 'Job Exec Waiting' AND T.LOCK_NAME LIKE '%calculateX2%' THEN ' (calculateX2)'
                 ELSE ' (' || T.LOCK_NAME || ')'
               END,
            'HASH',               T.STATEMENT_HASH,
            'SITE_ID',            TO_VARCHAR(T.SITE_ID),
            'ROOT',               T.ROOT_STATEMENT_HASH,
            'STMT_THR_LMT',       TO_VARCHAR(T.STATEMENT_THREAD_LIMIT),
            'STATEMENT_ID',       T.STATEMENT_ID,
            'STAT_EXEC_ID',       T.STATEMENT_EXECUTION_ID,
            'DB_USER',            T.DB_USER,
            'APP_NAME',           T.APP_NAME,
            'APP_USER',           T.APP_USER,
            'APP_SOURCE',         T.APP_SOURCE,
            'APP_COMP_NAME',      T.APP_COMP_NAME,
            'APP_COMP_TYPE',      T.APP_COMP_TYPE,
            'CLIENT_IP',          T.CLIENT_IP,
            'CLIENT_PID',         TO_VARCHAR(T.CLIENT_PID),
            'CONN_ID',            TO_VARCHAR(T.CONN_ID),
            'LOCK_TYPE',          T.LOCK_COMPONENT,
            'LOCK_NAME',          T.LOCK_NAME,
            'NUMA_NODE',          T.NUMA_NODE,
            'QUEUEING',           T.JOB_QUEUEING,
            'PASSPORT_COMPONENT', T.PASSPORT_COMPONENT,
            'PASSPORT_ACTION',    T.PASSPORT_ACTION,
            'WORKLOAD_CLASS',     T.WORKLOAD_CLASS_NAME
          ) VALUE,
          BI.AGGREGATE_BY,
          BI.RESULT_ROWS,
          BI.MIN_SAMPLES_TOTAL,
          BI.TIME_SLICE_S,
          BI.EXCLUDE_SERVICE_THREAD_SAMPLER,
          MAP(BI.DATA_SOURCE, 'CURRENT', IFNULL(I.SAMPLE_INTERVAL, 1), IFNULL(I.SAMPLE_INTERVAL, 1) * 50) SAMPLE_INTERVAL
        FROM
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
            SITE_ID,
            HOST,
            PORT,
            THREAD_ID,
            THREAD_TYPE,
            THREAD_STATE,
            THREAD_METHOD,
            THREAD_DETAIL,
            STATEMENT_HASH,
            ROOT_STATEMENT_HASH,
            STATEMENT_THREAD_LIMIT,
            STATEMENT_ID,
            STATEMENT_EXECUTION_ID,
            DB_USER,
            APP_NAME,
            APP_USER,
            APP_SOURCE,
            APP_COMP_NAME,
            APP_COMP_TYPE,
            LOCK_TYPE,
            LOCK_NAME,
            NUMA_NODE,
            CLIENT_IP,
            CLIENT_PID,
            CONN_ID,
            PASSPORT_COMPONENT,
            PASSPORT_ACTION,
            WORKLOAD_CLASS,
            JOB_QUEUEING,
            MIN_SAMPLES_TOTAL,
            TIME_SLICE_S,
            ONLY_DELTA_STORAGE_WAITS,
            EXCLUDE_SERVICE_THREAD_SAMPLER,
            EXCLUDE_NEGATIVE_THREAD_IDS,
            EXCLUDE_PHANTOM_THREADS,
            EXCLUDE_EMPTY_STATEMENT_IDS,
            EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS,
            DATA_SOURCE,
            AGGREGATE_BY,
            RESULT_ROWS
          FROM
          ( SELECT                                                      /* Modification section */
              '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
              '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
              'SERVER' TIMEZONE,                              /* SERVER, UTC */
              CURRENT_SITE_ID() SITE_ID,
              '%' HOST,
              '%' PORT,
              -1  THREAD_ID,
              '%' THREAD_TYPE,                /* e.g. 'SqlExecutor', 'JobWorker' or 'MergedogMonitor' */
              '%' THREAD_STATE,               /* e.g. 'Running', 'Network Read' or 'Semaphore Wait' */
              '%' THREAD_METHOD,
              '%' THREAD_DETAIL,
              '%' STATEMENT_HASH,
              '%' ROOT_STATEMENT_HASH,
              -1 STATEMENT_THREAD_LIMIT,
              '%' STATEMENT_ID,
              '%' STATEMENT_EXECUTION_ID,
              '%' DB_USER,
              '%' APP_NAME,
              '%' APP_USER,
              '%' APP_SOURCE,
              '%' APP_COMP_NAME,
              '%' APP_COMP_TYPE,
              '%' LOCK_TYPE,
              '%' LOCK_NAME,
              -1  NUMA_NODE,
              '%' CLIENT_IP,
              -1  CLIENT_PID,
              -1  CONN_ID,
              '%' PASSPORT_COMPONENT,
              '%' PASSPORT_ACTION,
              '%' WORKLOAD_CLASS,
              '%' JOB_QUEUEING,
              -1  MIN_SAMPLES_TOTAL,
              600 TIME_SLICE_S,
              ' ' ONLY_DELTA_STORAGE_WAITS,
              'X' EXCLUDE_SERVICE_THREAD_SAMPLER,
              'X' EXCLUDE_NEGATIVE_THREAD_IDS,
              'X' EXCLUDE_PHANTOM_THREADS,
              ' ' EXCLUDE_EMPTY_STATEMENT_IDS,
              ' ' EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS,
              'HISTORY' DATA_SOURCE,
              'PASSPORT_ACTION' AGGREGATE_BY,     /* SAMPLE_TIME, SITE_ID, HOST, PORT, THREAD_ID, THREAD_TYPE, THREAD_METHOD, THREAD_DETAIL, THREAD_STATE, STATE_LOCK, HASH, ROOT, DB_USER, APP_NAME, 
                                                     APP_USER, APP_SOURCE, APP_COMP_NAME, APP_COMP_TYPE, CLIENT_IP, CLIENT_PID, CONN_ID, LOCK_TYPE, LOCK_NAME, STATEMENT_ID, STAT_EXEC_ID, NUMA_NODE, 
                                                     STMT_THR_LMT, QUEUEING, PASSPORT_COMPONENT, PASSPORT_ACTION, WORKLOAD_CLASS */
              -1 RESULT_ROWS
            FROM
              DUMMY
          )
        ) BI,
        ( SELECT
            DATA_SOURCE,
            SITE_ID,
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
              WHEN STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE, THREAD_METHOD) || ')'
              ELSE STATEMENT_HASH
            END STATEMENT_HASH,
            CASE
              WHEN ROOT_STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(THREAD_METHOD, CHAR(63), THREAD_TYPE, THREAD_METHOD) || ')'
              ELSE ROOT_STATEMENT_HASH
            END ROOT_STATEMENT_HASH,
            STATEMENT_THREAD_LIMIT,
            STATEMENT_ID,
            STATEMENT_EXECUTION_ID,
            CONN_ID,
            DB_USER,
            MAP(APP_NAME, CHAR(63), MAP(THREAD_TYPE, CHAR(63), THREAD_METHOD, THREAD_TYPE), APP_NAME) APP_NAME,
            APP_USER,
            MAP(APP_SOURCE, CHAR(63), MAP(THREAD_TYPE, CHAR(63), THREAD_METHOD, THREAD_STATE), APP_SOURCE) APP_SOURCE,
            APP_COMP_NAME,
            APP_COMP_TYPE,
            CLIENT_IP,
            CLIENT_PID,
            LOCK_COMPONENT,
            LOCK_NAME,
            BLOCKING_THREAD,
            NUMA_NODE,
            JOB_QUEUEING,
            PASSPORT_COMPONENT,
            PASSPORT_ACTION,
            WORKLOAD_CLASS_NAME
          FROM
          ( SELECT
              'CURRENT' DATA_SOURCE,
              CURRENT_SITE_ID() SITE_ID,
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
              THREAD_DETAIL,
              THREAD_STATE,
              DURATION / 1000 DURATION_MS,
              STATEMENT_HASH,
              ROOT_STATEMENT_HASH,
              STATEMENT_THREAD_LIMIT,
              STATEMENT_ID,
              STATEMENT_EXECUTION_ID,
              CONNECTION_ID CONN_ID,
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
              IFNULL(NUMA_NODE_INDEX, -2) NUMA_NODE,
              CASE WHEN THREAD_STATE = 'Job Exec Waiting' AND LOCK_WAIT_NAME != 'envCondStat' AND CALLING = '' THEN 'X' ELSE '' END JOB_QUEUEING,
              IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
              IFNULL(PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT,
              IFNULL(WORKLOAD_CLASS_NAME, '') WORKLOAD_CLASS_NAME
            FROM
              M_SERVICE_THREAD_SAMPLES
            UNION ALL
            SELECT
              'HISTORY' DATA_SOURCE,
              SITE_ID,
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
              THREAD_DETAIL,
              THREAD_STATE,
              DURATION / 1000 DURATION_MS,
              STATEMENT_HASH,
              ROOT_STATEMENT_HASH,
              STATEMENT_THREAD_LIMIT,
              STATEMENT_ID,
              STATEMENT_EXECUTION_ID,
              CONNECTION_ID CONN_ID,
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
              IFNULL(NUMA_NODE_INDEX, -2) NUMA_NODE,
              CASE WHEN THREAD_STATE = 'Job Exec Waiting' AND LOCK_WAIT_NAME != 'envCondStat' AND CALLING = '' THEN 'X' ELSE '' END JOB_QUEUEING,
              IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
              IFNULL(PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT,
              IFNULL(WORKLOAD_CLASS_NAME, '') WORKLOAD_CLASS_NAME
            FROM
              _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES
          )
        ) T,
        ( SELECT DISTINCT
            MAX(VALUE) SAMPLE_INTERVAL
          FROM
            M_CONFIGURATION_PARAMETER_VALUES
          WHERE
            FILE_NAME = 'global.ini' AND
            SECTION = 'resource_tracking' AND
            KEY = 'service_thread_sampling_monitor_sample_interval'
        ) I
        WHERE
          ( BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND T.SITE_ID IN (-1, 0) ) OR T.SITE_ID = BI.SITE_ID ) AND
          T.HOST LIKE BI.HOST AND
          TO_VARCHAR(T.PORT) LIKE BI.PORT AND
          CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SAMPLE_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SAMPLE_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
          ( BI.THREAD_ID = -1 OR T.THREAD_ID = BI.THREAD_ID ) AND 
          IFNULL(T.THREAD_TYPE, '') LIKE BI.THREAD_TYPE AND
          IFNULL(T.THREAD_METHOD, '') LIKE BI.THREAD_METHOD AND
          UPPER(IFNULL(T.THREAD_DETAIL, '')) LIKE UPPER(BI.THREAD_DETAIL) AND
          IFNULL(T.THREAD_STATE, '') LIKE BI.THREAD_STATE AND
          T.JOB_QUEUEING LIKE BI.JOB_QUEUEING AND
          T.DATA_SOURCE LIKE BI.DATA_SOURCE AND
          SUBSTR(T.STATEMENT_HASH, 1, 31) LIKE SUBSTR(BI.STATEMENT_HASH, 1, 31) AND         /* sometimes only 31 out of 32 bytes were stored in thread samples */
          T.ROOT_STATEMENT_HASH LIKE BI.ROOT_STATEMENT_HASH AND
          ( BI.STATEMENT_THREAD_LIMIT = -1 OR T.STATEMENT_THREAD_LIMIT = BI.STATEMENT_THREAD_LIMIT ) AND
          T.STATEMENT_ID LIKE BI.STATEMENT_ID AND
          T.STATEMENT_EXECUTION_ID LIKE BI.STATEMENT_EXECUTION_ID AND
          T.DB_USER LIKE BI.DB_USER AND
          IFNULL(T.APP_NAME, '') LIKE BI.APP_NAME AND
          IFNULL(T.APP_USER, '') LIKE BI.APP_USER AND
          IFNULL(T.APP_SOURCE, '') LIKE BI.APP_SOURCE AND
          IFNULL(T.APP_COMP_NAME, '') LIKE BI.APP_COMP_NAME AND
          IFNULL(T.APP_COMP_TYPE, '') LIKE BI.APP_COMP_TYPE AND
          ( BI.CONN_ID = -1 OR T.CONN_ID = BI.CONN_ID ) AND
          ( T.PASSPORT_ACTION LIKE BI.PASSPORT_ACTION ) AND
          ( T.PASSPORT_COMPONENT LIKE BI.PASSPORT_COMPONENT ) AND
          ( T.WORKLOAD_CLASS_NAME LIKE BI.WORKLOAD_CLASS ) AND
          ( BI.ONLY_DELTA_STORAGE_WAITS = ' ' OR
            ( T.STATEMENT_HASH NOT LIKE 'no SQL%' AND
              ( T.THREAD_STATE = 'Sleeping' OR
                T.LOCK_NAME IN ('BTree GuardContainer', 'Sleep Semaphore')
              )
            )
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
          IFNULL(T.CLIENT_IP, '') LIKE BI.CLIENT_IP AND
          ( BI.CLIENT_PID = -1 OR T.CLIENT_PID = BI.CLIENT_PID ) AND
          T.LOCK_COMPONENT LIKE BI.LOCK_TYPE AND
          T.LOCK_NAME LIKE BI.LOCK_NAME AND
          ( BI.EXCLUDE_EMPTY_STATEMENT_IDS = ' ' OR T.STATEMENT_ID != CHAR(63) ) AND
          ( BI.EXCLUDE_EMPTY_STATEMENT_EXECUTION_IDS = ' ' OR T.STATEMENT_EXECUTION_ID != TO_BIGINT(-1) ) AND
          ( BI.NUMA_NODE = -1 OR T.NUMA_NODE = BI.NUMA_NODE )
        )
      GROUP BY
        BEGIN_TIME,
        VALUE,
        AGGREGATE_BY,
        RESULT_ROWS,
        SAMPLE_INTERVAL,
        MIN_SAMPLES_TOTAL,
        TIME_SLICE_S
    )
  )
  GROUP BY
    BEGIN_TIME,
    KEY_FIGURE,
    SAMPLES_TOTAL,
    ACT_THREADS,
    MIN_SAMPLES_TOTAL,
    RESULT_ROWS
)
WHERE
  ( MIN_SAMPLES_TOTAL = -1 OR SAMPLES_TOTAL >= MIN_SAMPLES_TOTAL ) AND
  ( RESULT_ROWS = -1 OR ROWNO <= RESULT_ROWS )
ORDER BY
  SNAPSHOT_TIME DESC
