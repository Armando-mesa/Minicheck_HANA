SELECT
/* 

[NAME]

- HANA_Jobs_Executors_2.00.070+

[DESCRIPTION]

- Job Executor overview

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Can be used for monitoring remote system replication sites, see SAP Note 1999880 
  ("Is it possible to monitor remote system replication sites on the primary system") for details.
- M_JOBEXECUTORS.MAX_CONCURRENCY_CONFIG available with SAP HANA >= 2.00.043
- M_JOBEXECUTOR_WORKER_GROUPS available with SAP HANA >= 2.00.059.02
- HOST_JOBEXECUTOR_WORKER_GROUPS available with SAP HANA >= 2.00.060
- SUSPENDED_WAITING_JOB_WORKER_COUNT available with SAP HANA >= 2.00.070
- SUSPENDED_WAITING_JOB_WORKER_COUNT does not exist in HOST_JOBEXECUTOR_WORKER_GROUPS (bug 315443) 
  with SAP HANA <= 2.00.074, so QUEUED is only filled for DATA_SOURCE = 'CURRENT'

[VALID FOR]

- Revisions:              >= 2.00.070

[SQL COMMAND VERSION]

- 2014/07/09:  1.0 (initial version)
- 2017/01/04:  1.1 (QUEUED included)
- 2019/10/12:  1.2 (dedicated 2.00.043+ version including MAX_CONCURRENCY_CONFIG)
- 2021/01/01:  1.3 (CONC_ESTD included)
- 2022/05/23:  1.4 (dedicated 2.00.059.02+ version using M_JOBEXECUTOR_WORKER_GROUPS instead of M_JOBEXECUTORS)
- 2023/10/29:  1.5 (dedicated 2.00.060+ version including HOST_JOBEXECUTOR_WORKER_GROUPS)
- 2023/10/30:  1.6 (dedicated 2.00.070+ version including SUSPENDED_WAITING_JOB_WORKER_COUNT)

[INVOLVED TABLES]

- HOST_JOBEXECUTOR_WORKER_GROUPS
- M_JOBEXECUTOR_WORKER_GROUPS

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

  System replication site ID

  -1             --> No restriction related to site ID
  1              --> Site id 1

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

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)
  '%'             --> All data sources

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'TIME'          --> Aggregation by time
  'HOST, PORT'    --> Aggregation by host and port
  'NONE'          --> No aggregation

- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

[OUTPUT PARAMETERS]

- SNAPSHOT_TIME: Snapshot time
- ST:            System replication site ID
- HOST:          Host name
- PORT:          Port
- GROUP:         Worker group
- CONC_CONFIG:   Configured max_concurrency value
- CONC_CURR:     Currently used max_concurrency value (can be smaller than configured one in case of dynamic reductions)
- TOTAL:         Total number of JobWorkers
- BUSY:          Running JobWorkers
- QUEUED:        Queued JobWorkers
- PARKED:        JobWorkers parked for future uwe
- FREE:          Idle JobWorkers
- SYSWAIT:       JobWorkers waiting for synchronization
- JOBWAIT:       JobWorkers waiting for other JobWorkers
- IMM_MS:        Average time an immediate job waits in some queue
- SHORT_MS:      Average time a short running job waits in some queue
- NORMAL_MS:     Average time a normal job waits in some queue
- SQL_BUSY:      Running SqlWorker and SqlExecutor threads
- OTH_BUSY:      Running threads different from SqlWorker, SqlExecutor and JobWorker
- SUPP:          Suppressed JobWorkers (waiting with no replacement active)

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------
|SNAPSHOT_TIME   |CONC_CONFIG|CONC_CURR|TOTAL|BUSY|QUEUED|PARKED|FREE|SYSWAIT|JOBWAIT|IMM_MS|SHORT_MS|NORMAL_MS|SQL_BUSY|OTH_BUSY|SUPP|
---------------------------------------------------------------------------------------------------------------------------------------
|2023/10/29 (SUN)|        169|      169|  266|   2|     0|   157| 103|      3|      1|  0.00|    0.00|     0.12|       1|       1|   0|
|2023/10/28 (SAT)|        169|      168|  324|   2|     0|   176| 142|      3|      1|  0.00|    0.00|     0.10|       1|       1|   0|
|2023/10/27 (FRI)|        169|      168|  323|   4|     0|   175| 137|      6|      1|  0.00|    0.02|     0.24|       2|       2|   0|
|2023/10/26 (THU)|        169|      168|  313|   4|     0|   168| 133|      6|      1|  0.00|    0.03|     0.25|       2|       2|   0|
|2023/10/25 (WED)|        169|      168|  299|   4|     0|   162| 126|      6|      1|  0.00|    0.02|     0.18|       2|       2|   0|
|2023/10/24 (TUE)|        169|      168|  291|   5|     0|   161| 118|      6|      2|  0.00|    0.02|     0.19|       3|       2|   0|
|2023/10/23 (MON)|        169|      167|  272|   4|     0|   157| 105|      5|      1|  0.00|    0.02|     0.16|       3|       1|   0|
|2023/10/22 (SUN)|        169|      169|  319|   2|     0|   178| 135|      4|      1|  0.00|    0.00|     0.10|       1|       1|   0|
|2023/10/21 (SAT)|        169|      168|  337|   2|     0|   187| 145|      3|      1|  0.00|    0.00|     0.08|       1|       1|   0|
|2023/10/20 (FRI)|        169|      167|  336|   4|     0|   186| 140|      5|      1|  0.00|    0.02|     0.15|       3|       2|   0|
|2023/10/19 (THU)|        169|      168|  334|   5|     0|   185| 139|      4|      1|  0.00|    0.01|     0.11|       2|       1|   0|
---------------------------------------------------------------------------------------------------------------------------------------

*/

  SNAPSHOT_TIME,
  SITE_ID ST,
  HOST,
  LPAD(PORT, 5) PORT,
  LPAD(WORKER_GROUP, 5) "GROUP",
  LPAD(TO_DECIMAL(ROUND(MAX_CONCURRENCY_CONFIG), 10, 0), 11) CONC_CONFIG,
  LPAD(TO_DECIMAL(ROUND(MAX_CONCURRENCY), 10, 0), 9) CONC_CURR,
  LPAD(TO_DECIMAL(ROUND(TOTAL_WORKER_COUNT), 10, 0), 5) TOTAL,
  LPAD(TO_DECIMAL(ROUND(WORKING_JOB_WORKER_COUNT), 10, 0), 4) BUSY,
  LPAD(TO_DECIMAL(ROUND(SUSPENDED_WAITING_JOB_WORKER_COUNT), 10, 0), 6) QUEUED,
  LPAD(TO_DECIMAL(ROUND(PARKED_JOB_WORKER_COUNT), 10, 0), 6) PARKED,
  LPAD(TO_DECIMAL(ROUND(FREE_JOB_WORKER_COUNT), 10, 0), 4) FREE,
  LPAD(TO_DECIMAL(ROUND(SYS_WAITING_JOB_WORKER_COUNT), 10, 0), 7) SYSWAIT,
  LPAD(TO_DECIMAL(ROUND(JOB_WAITING_JOB_WORKER_COUNT), 10, 0), 7) JOBWAIT,
  LPAD(TO_DECIMAL(AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE / 1000, 10, 2), 6) IMM_MS,
  LPAD(TO_DECIMAL(AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING / 1000, 10, 2), 8) SHORT_MS,
  LPAD(TO_DECIMAL(AVG_WAIT_IN_QUEUE_TIME_NORMAL / 1000, 10, 2), 9) NORMAL_MS,
  LPAD(TO_DECIMAL(ROUND(WORKING_SQL_WORKER_COUNT + OTHER_THREAD_RUNNING_COUNT), 10, 0), 8) SQL_BUSY,
  LPAD(TO_DECIMAL(ROUND(UNASSIGNED_THREAD_RUNNING_COUNT), 10, 0), 8) OTH_BUSY,
  LPAD(TO_DECIMAL(ROUND(SUPPRESSED_WAITING_JOB_WORKER_COUNT), 10, 0), 4) SUPP
FROM
( SELECT
    SNAPSHOT_TIME,
    SITE_ID,
    HOST,
    PORT,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'GROUP') != 0 THEN TO_VARCHAR(WORKER_GROUP) ELSE MAP(BI_WORKER_GROUP, -1, 'any', TO_VARCHAR(BI_WORKER_GROUP)) END WORKER_GROUP,
    SUM(MAX_CONCURRENCY_CONFIG) MAX_CONCURRENCY_CONFIG,
    SUM(MAX_CONCURRENCY) MAX_CONCURRENCY,
    SUM(TOTAL_WORKER_COUNT) TOTAL_WORKER_COUNT,
    SUM(WORKING_JOB_WORKER_COUNT) WORKING_JOB_WORKER_COUNT,
    SUM(PARKED_JOB_WORKER_COUNT) PARKED_JOB_WORKER_COUNT,
    SUM(FREE_JOB_WORKER_COUNT) FREE_JOB_WORKER_COUNT,
    SUM(SYS_WAITING_JOB_WORKER_COUNT) SYS_WAITING_JOB_WORKER_COUNT,
    SUM(JOB_WAITING_JOB_WORKER_COUNT) JOB_WAITING_JOB_WORKER_COUNT,
    SUM(AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE) AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE,
    SUM(AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING) AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING,
    SUM(AVG_WAIT_IN_QUEUE_TIME_NORMAL) AVG_WAIT_IN_QUEUE_TIME_NORMAL,
    SUM(WORKING_SQL_WORKER_COUNT) WORKING_SQL_WORKER_COUNT,
    SUM(OTHER_THREAD_RUNNING_COUNT) OTHER_THREAD_RUNNING_COUNT,
    SUM(UNASSIGNED_THREAD_RUNNING_COUNT) UNASSIGNED_THREAD_RUNNING_COUNT,
    SUM(SUPPRESSED_WAITING_JOB_WORKER_COUNT) SUPPRESSED_WAITING_JOB_WORKER_COUNT,
    SUM(SUSPENDED_WAITING_JOB_WORKER_COUNT) SUSPENDED_WAITING_JOB_WORKER_COUNT
  FROM
  ( SELECT
      CASE 
        WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(J.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE J.SNAPSHOT_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(J.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE J.SNAPSHOT_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END SNAPSHOT_TIME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(J.SITE_ID) ELSE MAP(BI.SITE_ID, -1, 'any', TO_VARCHAR(BI.SITE_ID)) END SITE_ID,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')    != 0 THEN J.HOST                ELSE MAP(BI.HOST,    '%', 'any', BI.HOST)               END HOST,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(J.PORT)    ELSE MAP(BI.PORT,    '%', 'any', BI.PORT)               END PORT,
      J.WORKER_GROUP,
      AVG(J.MAX_CONCURRENCY_CONFIG) MAX_CONCURRENCY_CONFIG,
      AVG(J.MAX_CONCURRENCY) MAX_CONCURRENCY,
      AVG(J.TOTAL_WORKER_COUNT) TOTAL_WORKER_COUNT,
      AVG(J.WORKING_JOB_WORKER_COUNT) WORKING_JOB_WORKER_COUNT,
      AVG(J.PARKED_JOB_WORKER_COUNT) PARKED_JOB_WORKER_COUNT,
      AVG(J.FREE_JOB_WORKER_COUNT) FREE_JOB_WORKER_COUNT,
      AVG(J.SYS_WAITING_JOB_WORKER_COUNT) SYS_WAITING_JOB_WORKER_COUNT,
      AVG(J.JOB_WAITING_JOB_WORKER_COUNT) JOB_WAITING_JOB_WORKER_COUNT,
      AVG(J.AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE) AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE,
      AVG(J.AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING) AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING,
      AVG(J.AVG_WAIT_IN_QUEUE_TIME_NORMAL) AVG_WAIT_IN_QUEUE_TIME_NORMAL,
      AVG(J.WORKING_SQL_WORKER_COUNT) WORKING_SQL_WORKER_COUNT,
      AVG(J.OTHER_THREAD_RUNNING_COUNT) OTHER_THREAD_RUNNING_COUNT,
      AVG(J.UNASSIGNED_THREAD_RUNNING_COUNT) UNASSIGNED_THREAD_RUNNING_COUNT,
      AVG(J.SUPPRESSED_WAITING_JOB_WORKER_COUNT) SUPPRESSED_WAITING_JOB_WORKER_COUNT,
      AVG(J.SUSPENDED_WAITING_JOB_WORKER_COUNT) SUSPENDED_WAITING_JOB_WORKER_COUNT,
      BI.AGGREGATE_BY,
      BI.WORKER_GROUP BI_WORKER_GROUP
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
        WORKER_GROUP,
        DATA_SOURCE,
        AGGREGATE_BY,
        MAP(TIME_AGGREGATE_BY,
          'NONE',        'YYYY/MM/DD HH24:MI:SS',
          'HOUR',        'YYYY/MM/DD HH24',
          'DAY',         'YYYY/MM/DD (DY)',
          'HOUR_OF_DAY', 'HH24',
          TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY
      FROM
      ( SELECT                        /* Modification section */
          'C-H1' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
          '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
          'SERVER' TIMEZONE,                              /* SERVER, UTC */
          CURRENT_SITE_ID() SITE_ID,
          '%' HOST,
          '%' PORT,
          -1 WORKER_GROUP,
          'HISTORY' DATA_SOURCE,                        /* CURRENT, HISTORY */
          'NONE' AGGREGATE_BY,         /* TIME, SITE_ID, HOST, PORT, GROUP or comma separated combinations, NONE for no aggregation */
          'NONE' TIME_AGGREGATE_BY     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
        FROM
          DUMMY
      )
    ) BI,
    ( SELECT
        'CURRENT' DATA_SOURCE,
        CURRENT_TIMESTAMP SNAPSHOT_TIME,
        CURRENT_SITE_ID() SITE_ID,
        HOST,
        PORT,
        WORKER_GROUP,
        MAX_CONCURRENCY_CONFIG,
        MAX_CONCURRENCY,
        TOTAL_WORKER_COUNT,
        WORKING_JOB_WORKER_COUNT,
        PARKED_JOB_WORKER_COUNT,
        FREE_JOB_WORKER_COUNT,
        SYS_WAITING_JOB_WORKER_COUNT,
        JOB_WAITING_JOB_WORKER_COUNT,
        AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE,
        AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING,
        AVG_WAIT_IN_QUEUE_TIME_NORMAL,
        WORKING_SQL_WORKER_COUNT,
        OTHER_THREAD_RUNNING_COUNT,
        UNASSIGNED_THREAD_RUNNING_COUNT,
        SUPPRESSED_WAITING_JOB_WORKER_COUNT,
        SUSPENDED_WAITING_JOB_WORKER_COUNT
      FROM
        M_JOBEXECUTOR_WORKER_GROUPS
      UNION ALL
      SELECT
        'HISTORY' DATA_SOURCE,
        SERVER_TIMESTAMP SNAPSHOT_TIME,
        SITE_ID,
        HOST,
        PORT,
        WORKER_GROUP,
        MAX_CONCURRENCY_CONFIG,
        MAX_CONCURRENCY,
        TOTAL_WORKER_COUNT,
        WORKING_JOB_WORKER_COUNT,
        PARKED_JOB_WORKER_COUNT,
        FREE_JOB_WORKER_COUNT,
        SYS_WAITING_JOB_WORKER_COUNT,
        JOB_WAITING_JOB_WORKER_COUNT,
        AVG_WAIT_IN_QUEUE_TIME_IMMEDIATE,
        AVG_WAIT_IN_QUEUE_TIME_SHORTRUNNING,
        AVG_WAIT_IN_QUEUE_TIME_NORMAL,
        WORKING_SQL_WORKER_COUNT,
        OTHER_THREAD_RUNNING_COUNT,
        UNASSIGNED_THREAD_RUNNING_COUNT,
        SUPPRESSED_WAITING_JOB_WORKER_COUNT,
        0 SUSPENDED_WAITING_JOB_WORKER_COUNT
      FROM
        _SYS_STATISTICS.HOST_JOBEXECUTOR_WORKER_GROUPS
    ) J
    WHERE
      ( BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND J.SITE_ID IN (-1, 0) ) OR J.SITE_ID = BI.SITE_ID ) AND
      J.HOST LIKE BI.HOST AND  
      TO_VARCHAR(J.PORT) LIKE BI.PORT AND
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(J.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE J.SNAPSHOT_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
      ( BI.WORKER_GROUP = -1 OR J.WORKER_GROUP = BI.WORKER_GROUP ) AND
      J.DATA_SOURCE = BI.DATA_SOURCE
    GROUP BY
      CASE 
        WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(J.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE J.SNAPSHOT_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(J.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE J.SNAPSHOT_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(J.SITE_ID) ELSE MAP(BI.SITE_ID, -1, 'any', TO_VARCHAR(BI.SITE_ID)) END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')    != 0 THEN J.HOST                ELSE MAP(BI.HOST,    '%', 'any', BI.HOST)               END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(J.PORT)    ELSE MAP(BI.PORT,    '%', 'any', BI.PORT)               END,
      J.WORKER_GROUP,
      BI.AGGREGATE_BY,
      BI.WORKER_GROUP
   )
  GROUP BY
    SNAPSHOT_TIME,
    SITE_ID,
    HOST,
    PORT,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'GROUP') != 0 THEN TO_VARCHAR(WORKER_GROUP) ELSE MAP(BI_WORKER_GROUP, -1, 'any', TO_VARCHAR(BI_WORKER_GROUP)) END
)
ORDER BY
  SNAPSHOT_TIME DESC,
  HOST,
  PORT,
  LPAD(WORKER_GROUP, 10)