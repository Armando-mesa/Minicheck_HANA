WITH 

/* 

[NAME]

- HANA_Global_DiffReport_2.00.060+

[DESCRIPTION]

- Comparison of historic SAP HANA load and performance figures for two time frames

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_LOAD_HISTORY_SERVICE not available before Rev. 1.00.90
- Delta values in HOST_SERVICE_REPLICATION available as of Rev. 1.00.110
- HOST and PORT filter only work for views that allow this breakdown, table sizes on disk
  can not be easily assigned to HOST or PORT, so they are global.
- Delta values in HOST_SERVICE_STATISTICS available as of Rev. 1.00.120
- Persistent memory information available with SAP HANA 2.0 >= SPS 03
- SITE_ID in table history tables available with SAP HANA >= 2.0 SPS 06

[VALID FOR]

- Revisions:              >= 2.00.060

[SQL COMMAND VERSION]

- 2016/04/12:  1.0 (initial version)
- 2016/06/25:  1.1 (top lists in terms of column store reads and writes added)
- 2016/09/15:  1.2 (MAX_KEY_FIGURE_LENGTH added)
- 2017/06/28:  1.3 (THREAD_METHOD section included)
- 2017/10/24:  1.4 (TIMEZONE included)
- 2017/11/01:  1.5 (HOST and PORT filter added)
- 2018/01/07:  1.6 (HOST_SERVICE_STATISTICS added)
- 2018/12/04:  1.7 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2020/12/23:  1.8 (dedicated 2.00.030+ version including persistent memory)
- 2021/09/12:  1.9 (PASSPORT_ACTION and PASSPORT_COMPONENT included)
- 2022/05/16:  2.0 (dedicated 2.00.060+ version including SITE_ID)

[INVOLVED TABLES]

- GLOBAL_ROWSTORE_TABLES_SIZE
- GLOBAL_TABLE_PERSISTENCE_STATISTICS
- HOST_COLUMN_TABLES_PART_SIZE
- HOST_DELTA_MERGE_STATISTICS
- HOST_HEAP_ALLOCATORS
- HOST_RESOURCE_UTILIZATION_STATISTICS
- HOST_SAVEPOINTS 
- HOST_SERVICE_REPLICATION
- HOST_SERVICE_STATISTICS
- HOST_SERVICE_THREAD_SAMPLES
- HOST_SQL_PLAN_CACHE
- HOST_VOLUME_IO_TOTAL_STATISTICS
- HOST_WORKLOAD
- M_CS_UNLOADS
- M_LOAD_HISTORY_SERVICE

[INPUT PARAMETERS]

- BEGIN_TIME_1 / BEGIN_TIME_2

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

- END_TIME_1 / END_TIME_2

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

- BEGIN_TIME_2

  Begin time of second time interval

  TO_TIMESTAMP('2014/06/05 14:05:00', 'YYYY/MM/DD HH24:MI:SS') --> Set begin time to 5th of June 2014, 14:05 
  ADD_DAYS(CURRENT_TIMESTAMP, -2)                              --> Set begin time to two days before current time 

- END_TIME_2

  End time of second time interval

  TO_TIMESTAMP('2014/06/08 14:05:00', 'YYYY/MM/DD HH24:MI:SS') --> Set end time to 8th of June 2014, 14:05 
  CURRENT_TIMESTAMP                                            --> Set end time to current time 

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

  'saphana01'     --> Specific host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- THREAD_HISTORY_INTERVAL_S

  Filtering interval of HOST_SERVICE_THREAD_SAMPLES 

  50              --> Filtering of every 50th timestamp (default)
  10              --> Filtering of every 1th timestamp (only adjust in case of deviation from the SAP standard)

- MAX_KEY_FIGURE_LENGTH

  Possibility to limit the length of the key figure in the output to a number of characters

  40              --> Truncate key figures to 40 characters
  -1              --> No limitation of key figure length

- TOP_N_DISK

  Number of top tables on disk to be displayed, top N is considered for both time intervals

  20              --> Display top 20 tables on disk for both time intervals

- TOP_N_CS_SIZE

  Number of top tables in terms of column store size, top N is considered for both time intervals

  10              --> Display top 10 tables in terms of column store size for both time intervals

- TOP_N_CS_READ

  Number of top tables in terms of column store reads, top N is considered for both time intervals

  10              --> Display top 10 tables in terms of column store reads for both time intervals

- TOP_N_CS_WRITE

  Number of top tables in terms of column store writes, top N is considered for both time intervals

  10              --> Display top 10 tables in terms of column store writes for both time intervals

- TOP_N_RS_SIZE

  Number of top tables in terms of row store size to be displayed, top N is considered for both time intervals

  10              --> Display top 10 tables in row store for both time intervals

- TOP_N_SQL_TIME

  Number of top statement hashes in SQL cache to be displayed in terms of time, top N is considered for both time intervals

  20              --> Display top 20 statement hashes in SQL cache in terms of time for both time intervals

- TOP_N_SQL_EXECUTIONS

  Number of top statement hashes in SQL cache to be displayed in terms of executions, top N is considered for both time intervals

  5               --> Display top 5 statement hashes in SQL cache in terms of executions for both time intervals

- TOP_N_SQL_RECORDS

  Number of top statement hashes in SQL cache to be displayed in terms of records, top N is considered for both time intervals

  5               --> Display top 5 statement hashes in SQL cache in terms of records for both time intervals

- TOP_N_THREAD_SQL

  Number of top thread statement hashes to be displayed, top N is considered for both time intervals

  5               --> Display top 5 thread statement hashes for both time intervals

- TOP_N_THREAD_TYPES

  Number of top thread types (type, state) to be displayed, top N is considered for both time intervals

  5               --> Display top 5 thread types for both time intervals

- TOP_N_THREAD_METHODS

  Number of top thread methods to be displayed, top N is considered for both time intervals

  5               --> Display top 5 thread methods for both time intervals

- TOP_N_THREAD_LOCKS

  Number of top thread locks to be displayed, top N is considered for both time intervals

  10              --> Display top 10 thread locks for both time intervals

- TOP_N_THREAD_DB_USERS

  Number of top thread database users to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread database users for both time intervals

- TOP_N_THREAD_APP_USERS

  Number of top thread application users to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread application users for both time intervals

- TOP_N_THREAD_APP_NAMES

  Number of top thread applications to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread applications for both time intervals

- TOP_N_THREAD_APP_SOURCES

  Number of top thread application sources to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread application sources for both time intervals

- TOP_N_THREAD_PASSPORT_COMPONENTS

  Number of top thread passport components to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread passport components for both time intervals

- TOP_N_THREAD_PASSPORT_ACTIONS

  Number of top thread passport actions to be displayed, top N is considered for both time intervals

  5              --> Display top 5 thread passport actions for both time intervals

- TOP_N_THREAD_HOST_PORTS

  Number of thread host / port combinations to be displayed

  5              --> Display top 5 thread host / port combination

- TOP_N_HEAP

  Number of top heap allocators (not overlapping with tables), top N is considered for both time intervals

  10              --> Display top 10 heap allocators for both time intervals

[OUTPUT PARAMETERS]

- DETAIL:   Object or key figure
- VALUE_1:  Value related to first time frame
- VALUE_2:  Value related to second time frame
- DIFF_VAL: Difference of VALUE_1 and VALUE_2
- DIFF_PCT: Difference of VALUE_2 related to VALUE_1 (%)

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------
|DETAIL                                                                 |VALUE_1     |VALUE_2     |DIFF_VAL    |DIFF_PCT|
-------------------------------------------------------------------------------------------------------------------------
|TIME FRAMES                                                            |            |            |            |        |
|***********                                                            |            |            |            |        |
|                                                                       |            |            |            |        |
|1: 2016/04/01 00:00:00-2016/04/02 00:00:00                             |            |            |            |        |
|2: 2016/04/08 00:00:00-2016/04/09 00:00:00                             |            |            |            |        |
|                                                                       |            |            |            |        |
|DISK                                                                   |            |            |            |        |
|****                                                                   |            |            |            |        |
|                                                                       |            |            |            |        |
|TABLE_NAME                                                             |SIZE_GB_1   |SIZE_GB_2   |DIFF_GB     |DIFF_PCT|
|                                                                       |            |            |            |        |
|TOTAL                                                                  |     2089.67|     2156.55|       66.88|    3.20|
|                                                                       |            |            |            |        |
|SAPSR3.SWWCNTP0                                                        |      149.92|      151.81|        1.88|    1.25|
|SAPSR3.ACDOCA                                                          |       65.57|       82.34|       16.77|   25.57|
|SAPSR3.CDPOS                                                           |       76.11|       77.52|        1.41|    1.85|
|SAPSR3.BALDAT                                                          |       62.29|       70.69|        8.39|   13.48|
|SAPSR3.ZZV_EO_D_LOG                                                    |       52.84|       53.11|        0.27|    0.52|
|SAPSR3.SRT_MMASTER                                                     |       52.57|       53.10|        0.53|    1.01|
|SAPSR3.ZFBCOEP                                                         |       48.32|       48.32|        0.00|    0.00|
|SAPSR3.BSEG                                                            |       39.00|       39.52|        0.51|    1.32|
|SAPSR3.EDID4                                                           |       33.34|       37.57|        4.23|   12.70|
|SAPSR3.PCL1                                                            |       34.00|       34.09|        0.09|    0.27|
|                                                                       |            |            |            |        |
|COLUMN STORE                                                           |            |            |            |        |
|************                                                           |            |            |            |        |
|                                                                       |            |            |            |        |
|TABLE_NAME                                                             |SIZE_GB_1   |SIZE_GB_2   |DIFF_GB     |DIFF_PCT|
|                                                                       |            |            |            |        |
|TOTAL                                                                  |     1495.35|     1566.89|       71.54|    4.78|
|                                                                       |            |            |            |        |
|SAPSR3.SWWCNTP0                                                        |      150.84|      159.24|        8.39|    5.56|
|SAPSR3.ACDOCA                                                          |       63.76|       83.67|       19.90|   31.21|
|SAPSR3.BALDAT                                                          |       62.95|       71.00|        8.04|   12.77|
|SAPSR3.CDPOS                                                           |       65.24|       66.43|        1.18|    1.81|
|SAPSR3.BSEG                                                            |       36.24|       37.62|        1.38|    3.81|
|SAPSR3.EDID4                                                           |       35.00|       36.39|        1.38|    3.95|
|SAPSR3.PCL1                                                            |       34.41|       34.50|        0.09|    0.27|
|SAPSR3.SWWLOGHIST                                                      |       30.63|       30.81|        0.17|    0.58|
|SAPSR3.KONV                                                            |       28.35|       26.71|       -1.63|   -5.77|
|SAPSR3.INDX                                                            |       22.09|       22.85|        0.76|    3.47|
...
-------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT
    CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(BEGIN_TIME_1, SECONDS_BETWEEN(CURRENT_UTCTIMESTAMP, CURRENT_TIMESTAMP)) ELSE BEGIN_TIME_1 END BEGIN_TIME_1,
    CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(END_TIME_1, SECONDS_BETWEEN(CURRENT_UTCTIMESTAMP, CURRENT_TIMESTAMP)) ELSE END_TIME_1 END END_TIME_1,
    CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(BEGIN_TIME_2, SECONDS_BETWEEN(CURRENT_UTCTIMESTAMP, CURRENT_TIMESTAMP)) ELSE BEGIN_TIME_2 END BEGIN_TIME_2,
    CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(END_TIME_2, SECONDS_BETWEEN(CURRENT_UTCTIMESTAMP, CURRENT_TIMESTAMP)) ELSE END_TIME_2 END END_TIME_2,
    BEGIN_TIME_1 BEGIN_TIME_1_ORIG,
    END_TIME_1 END_TIME_1_ORIG,
    BEGIN_TIME_2 BEGIN_TIME_2_ORIG,
    END_TIME_2 END_TIME_2_ORIG,
    SECONDS_BETWEEN(BEGIN_TIME_1, END_TIME_1) INTERVAL_S_1,
    SECONDS_BETWEEN(BEGIN_TIME_2, END_TIME_2) INTERVAL_S_2,
    SITE_ID,
    HOST,
    PORT,
    THREAD_HISTORY_INTERVAL_S,
    MAX_KEY_FIGURE_LENGTH,
    TOP_N_DISK,
    TOP_N_CS_SIZE,
    TOP_N_CS_READ,
    TOP_N_CS_WRITE,
    TOP_N_RS_SIZE,
    TOP_N_SQL_TIME,
    TOP_N_SQL_EXECUTIONS,
    TOP_N_SQL_RECORDS,
    TOP_N_THREAD_SQL,
    TOP_N_THREAD_TYPES,
    TOP_N_THREAD_METHODS,
    TOP_N_THREAD_LOCKS,
    TOP_N_THREAD_DB_USERS,
    TOP_N_THREAD_APP_USERS,
    TOP_N_THREAD_APP_NAMES,
    TOP_N_THREAD_APP_SOURCES,
    TOP_N_THREAD_HOST_PORTS,
    TOP_N_THREAD_PASSPORT_COMPONENTS,
    TOP_N_THREAD_PASSPORT_ACTIONS,
    TOP_N_HEAP
  FROM
  ( SELECT
      CASE
        WHEN BEGIN_TIME_1 =    'C'                             THEN CURRENT_TIMESTAMP
        WHEN BEGIN_TIME_1 LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_1, 'C-S'))
        WHEN BEGIN_TIME_1 LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_1, 'C-M') * 60)
        WHEN BEGIN_TIME_1 LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_1, 'C-H') * 3600)
        WHEN BEGIN_TIME_1 LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_1, 'C-D') * 86400)
        WHEN BEGIN_TIME_1 LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_1, 'C-W') * 86400 * 7)
        WHEN BEGIN_TIME_1 LIKE 'E-S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_1, 'E-S'))
        WHEN BEGIN_TIME_1 LIKE 'E-M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_1, 'E-M') * 60)
        WHEN BEGIN_TIME_1 LIKE 'E-H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_1, 'E-H') * 3600)
        WHEN BEGIN_TIME_1 LIKE 'E-D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_1, 'E-D') * 86400)
        WHEN BEGIN_TIME_1 LIKE 'E-W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_1, 'E-W') * 86400 * 7)
        WHEN BEGIN_TIME_1 =    'MIN'                           THEN TO_TIMESTAMP('1000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
        WHEN SUBSTR(BEGIN_TIME_1, 1, 1) NOT IN ('C', 'E', 'M') THEN TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS')
      END BEGIN_TIME_1,
      CASE
        WHEN END_TIME_1 =    'C'                             THEN CURRENT_TIMESTAMP
        WHEN END_TIME_1 LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_1, 'C-S'))
        WHEN END_TIME_1 LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_1, 'C-M') * 60)
        WHEN END_TIME_1 LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_1, 'C-H') * 3600)
        WHEN END_TIME_1 LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_1, 'C-D') * 86400)
        WHEN END_TIME_1 LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_1, 'C-W') * 86400 * 7)
        WHEN END_TIME_1 LIKE 'B+S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_1, 'B+S'))
        WHEN END_TIME_1 LIKE 'B+M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_1, 'B+M') * 60)
        WHEN END_TIME_1 LIKE 'B+H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_1, 'B+H') * 3600)
        WHEN END_TIME_1 LIKE 'B+D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_1, 'B+D') * 86400)
        WHEN END_TIME_1 LIKE 'B+W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_1, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_1, 'B+W') * 86400 * 7)
        WHEN END_TIME_1 =    'MAX'                           THEN TO_TIMESTAMP('9999/12/31 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
        WHEN SUBSTR(END_TIME_1, 1, 1) NOT IN ('C', 'B', 'M') THEN TO_TIMESTAMP(END_TIME_1, 'YYYY/MM/DD HH24:MI:SS')
      END END_TIME_1,
      CASE
        WHEN BEGIN_TIME_2 =    'C'                             THEN CURRENT_TIMESTAMP
        WHEN BEGIN_TIME_2 LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_2, 'C-S'))
        WHEN BEGIN_TIME_2 LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_2, 'C-M') * 60)
        WHEN BEGIN_TIME_2 LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_2, 'C-H') * 3600)
        WHEN BEGIN_TIME_2 LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_2, 'C-D') * 86400)
        WHEN BEGIN_TIME_2 LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(BEGIN_TIME_2, 'C-W') * 86400 * 7)
        WHEN BEGIN_TIME_2 LIKE 'E-S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_2, 'E-S'))
        WHEN BEGIN_TIME_2 LIKE 'E-M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_2, 'E-M') * 60)
        WHEN BEGIN_TIME_2 LIKE 'E-H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_2, 'E-H') * 3600)
        WHEN BEGIN_TIME_2 LIKE 'E-D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_2, 'E-D') * 86400)
        WHEN BEGIN_TIME_2 LIKE 'E-W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), -SUBSTR_AFTER(BEGIN_TIME_2, 'E-W') * 86400 * 7)
        WHEN BEGIN_TIME_2 =    'MIN'                           THEN TO_TIMESTAMP('1000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
        WHEN SUBSTR(BEGIN_TIME_2, 1, 1) NOT IN ('C', 'E', 'M') THEN TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS')
      END BEGIN_TIME_2,
      CASE
        WHEN END_TIME_2 =    'C'                             THEN CURRENT_TIMESTAMP
        WHEN END_TIME_2 LIKE 'C-S%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_2, 'C-S'))
        WHEN END_TIME_2 LIKE 'C-M%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_2, 'C-M') * 60)
        WHEN END_TIME_2 LIKE 'C-H%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_2, 'C-H') * 3600)
        WHEN END_TIME_2 LIKE 'C-D%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_2, 'C-D') * 86400)
        WHEN END_TIME_2 LIKE 'C-W%'                          THEN ADD_SECONDS(CURRENT_TIMESTAMP, -SUBSTR_AFTER(END_TIME_2, 'C-W') * 86400 * 7)
        WHEN END_TIME_2 LIKE 'B+S%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_2, 'B+S'))
        WHEN END_TIME_2 LIKE 'B+M%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_2, 'B+M') * 60)
        WHEN END_TIME_2 LIKE 'B+H%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_2, 'B+H') * 3600)
        WHEN END_TIME_2 LIKE 'B+D%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_2, 'B+D') * 86400)
        WHEN END_TIME_2 LIKE 'B+W%'                          THEN ADD_SECONDS(TO_TIMESTAMP(BEGIN_TIME_2, 'YYYY/MM/DD HH24:MI:SS'), SUBSTR_AFTER(END_TIME_2, 'B+W') * 86400 * 7)
        WHEN END_TIME_2 =    'MAX'                           THEN TO_TIMESTAMP('9999/12/31 00:00:00', 'YYYY/MM/DD HH24:MI:SS')
        WHEN SUBSTR(END_TIME_2, 1, 1) NOT IN ('C', 'B', 'M') THEN TO_TIMESTAMP(END_TIME_2, 'YYYY/MM/DD HH24:MI:SS')
      END END_TIME_2,
      TIMEZONE,
      SITE_ID,
      HOST,
      PORT,
      THREAD_HISTORY_INTERVAL_S,
      MAX_KEY_FIGURE_LENGTH,
      TOP_N_DISK,
      TOP_N_CS_SIZE,
      TOP_N_CS_READ,
      TOP_N_CS_WRITE,
      TOP_N_RS_SIZE,
      TOP_N_SQL_TIME,
      TOP_N_SQL_EXECUTIONS,
      TOP_N_SQL_RECORDS,
      TOP_N_THREAD_SQL,
      TOP_N_THREAD_TYPES,
      TOP_N_THREAD_METHODS,
      TOP_N_THREAD_LOCKS,
      TOP_N_THREAD_DB_USERS,
      TOP_N_THREAD_APP_USERS,
      TOP_N_THREAD_APP_NAMES,
      TOP_N_THREAD_APP_SOURCES,
      TOP_N_THREAD_PASSPORT_COMPONENTS,
      TOP_N_THREAD_PASSPORT_ACTIONS,
      TOP_N_THREAD_HOST_PORTS,
      TOP_N_HEAP
    FROM
    ( SELECT                         /* Modification section */
        'C-D2' BEGIN_TIME_1,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        'C-D1' END_TIME_1,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        'C-D1' BEGIN_TIME_2,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        'C' END_TIME_2,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        'SERVER' TIMEZONE,                              /* SERVER, UTC */
        -1 SITE_ID,
        '%' HOST,
        '%' PORT,
        50 THREAD_HISTORY_INTERVAL_S,
        64 MAX_KEY_FIGURE_LENGTH,
        20 TOP_N_DISK,
        20 TOP_N_CS_SIZE,
        10 TOP_N_CS_READ,
        10 TOP_N_CS_WRITE,
        10 TOP_N_RS_SIZE,
        20 TOP_N_SQL_TIME,
        5  TOP_N_SQL_EXECUTIONS,
        5  TOP_N_SQL_RECORDS,
        20 TOP_N_THREAD_SQL,
        10 TOP_N_THREAD_TYPES,
        10 TOP_N_THREAD_METHODS,
        10 TOP_N_THREAD_LOCKS,
        5  TOP_N_THREAD_DB_USERS,
        5  TOP_N_THREAD_APP_USERS,
        5  TOP_N_THREAD_APP_NAMES,
        5  TOP_N_THREAD_APP_SOURCES,
        5  TOP_N_THREAD_PASSPORT_COMPONENTS,
        5  TOP_N_THREAD_PASSPORT_ACTIONS,
        5  TOP_N_THREAD_HOST_PORTS,
        5  TOP_N_HEAP
      FROM
        DUMMY
    )
  )
),
PERSISTENCE_1 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(DISK_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(DISK_SIZE_GB) DISK_SIZE_GB
  FROM
  ( SELECT
      P.SCHEMA_NAME,
      P.TABLE_NAME,
      SUM(P.DISK_SIZE) / 1024 / 1024 / 1024 DISK_SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS P
    WHERE
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND P.SITE_ID IN (-1, 0) ) OR P.SITE_ID = BI.SITE_ID ) AND
      P.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1
    GROUP BY
       P.SCHEMA_NAME,
       P.TABLE_NAME,
       P.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
PERSISTENCE_2 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(DISK_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(DISK_SIZE_GB) DISK_SIZE_GB
  FROM
  ( SELECT
      P.SCHEMA_NAME,
      P.TABLE_NAME,
      SUM(P.DISK_SIZE) / 1024 / 1024 / 1024 DISK_SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS P
    WHERE
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND P.SITE_ID IN (-1, 0) ) OR P.SITE_ID = BI.SITE_ID ) AND
      P.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2
    GROUP BY
       P.SCHEMA_NAME,
       P.TABLE_NAME,
       P.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
COLUMN_STORE_1 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(CS_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(CS_SIZE_GB) CS_SIZE_GB,
    SUM(READ_COUNT) READ_COUNT,
    SUM(WRITE_COUNT) WRITE_COUNT
  FROM
  ( SELECT
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      SUM(C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 CS_SIZE_GB,
      SUM(GREATEST(0, C.READ_COUNT_SDELTA)) READ_COUNT,
      SUM(GREATEST(0, C.WRITE_COUNT_SDELTA)) WRITE_COUNT
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE C
    WHERE
      C.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND C.SITE_ID IN (-1, 0) ) OR C.SITE_ID = BI.SITE_ID ) AND
      C.HOST LIKE BI.HOST AND
      TO_VARCHAR(C.PORT) LIKE BI.PORT
    GROUP BY
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      C.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
COLUMN_STORE_2 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(CS_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(CS_SIZE_GB) CS_SIZE_GB,
    SUM(READ_COUNT) READ_COUNT,
    SUM(WRITE_COUNT) WRITE_COUNT
  FROM
  ( SELECT
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      SUM(C.MEMORY_SIZE_IN_TOTAL + C.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 CS_SIZE_GB,
      SUM(GREATEST(0, C.READ_COUNT_SDELTA)) READ_COUNT,
      SUM(GREATEST(0, C.WRITE_COUNT_SDELTA)) WRITE_COUNT
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE C
    WHERE
      C.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND C.SITE_ID IN (-1, 0) ) OR C.SITE_ID = BI.SITE_ID ) AND
      C.HOST LIKE BI.HOST AND
      TO_VARCHAR(C.PORT) LIKE BI.PORT
    GROUP BY
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      C.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
ROW_STORE_1 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(RS_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(RS_SIZE_GB) RS_SIZE_GB
  FROM
  ( SELECT
      R.SCHEMA_NAME,
      R.TABLE_NAME,
      SUM(R.ALLOCATED_FIXED_PART_SIZE + R.ALLOCATED_VARIABLE_PART_SIZE) / 1024 / 1024 / 1024 RS_SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE R
    WHERE
      R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
      R.HOST LIKE BI.HOST AND
      TO_VARCHAR(R.PORT) LIKE BI.PORT
    GROUP BY
      R.SCHEMA_NAME,
      R.TABLE_NAME,
      R.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
ROW_STORE_2 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY AVG(RS_SIZE_GB) DESC) ROW_NUM,
    SCHEMA_NAME,
    TABLE_NAME,
    AVG(RS_SIZE_GB) RS_SIZE_GB
  FROM
  ( SELECT
      R.SCHEMA_NAME,
      R.TABLE_NAME,
      SUM(R.ALLOCATED_FIXED_PART_SIZE + R.ALLOCATED_VARIABLE_PART_SIZE) / 1024 / 1024 / 1024 RS_SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE R
    WHERE
      R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
      R.HOST LIKE BI.HOST AND
      TO_VARCHAR(R.PORT) LIKE BI.PORT
    GROUP BY
      R.SCHEMA_NAME,
      R.TABLE_NAME,
      R.SERVER_TIMESTAMP
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME
),
HEAP_1 AS
( SELECT
    ROW_NUMBER() OVER (ORDER BY AVG(SIZE_GB) DESC) ROW_NUM,
    ALLOCATOR,
    MAX(SIZE_GB) SIZE_GB
  FROM
  ( SELECT
      H.CATEGORY ALLOCATOR,
      SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024 SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_HEAP_ALLOCATORS H
    WHERE
      H.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND H.SITE_ID IN (-1, 0) ) OR H.SITE_ID = BI.SITE_ID ) AND
      H.HOST LIKE BI.HOST AND
      TO_VARCHAR(H.PORT) LIKE BI.PORT AND
      ( H.CATEGORY NOT LIKE 'Pool/AttributeEngine%' AND
        H.CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
        H.CATEGORY NOT IN 
        ( 'Pool/FuzzySearch',
          'Pool/NameIdMapping/RoDict',
          'Pool/RowEngine/CpbTree',
          'Pool/RowStoreTables/CpbTree',
          'Pool/SerializedObject',
          'StackAllocator'
        )
      )
    GROUP BY
      H.CATEGORY,
      H.SERVER_TIMESTAMP
  )
  GROUP BY
    ALLOCATOR
),
HEAP_2 AS
( SELECT
    ROW_NUMBER() OVER (ORDER BY AVG(SIZE_GB) DESC) ROW_NUM,
    ALLOCATOR,
    MAX(SIZE_GB) SIZE_GB
  FROM
  ( SELECT
      H.CATEGORY ALLOCATOR,
      SUM(H.EXCLUSIVE_SIZE_IN_USE) / 1024 / 1024 / 1024 SIZE_GB
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_HEAP_ALLOCATORS H
    WHERE
      H.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND H.SITE_ID IN (-1, 0) ) OR H.SITE_ID = BI.SITE_ID ) AND
      H.HOST LIKE BI.HOST AND
      TO_VARCHAR(H.PORT) LIKE BI.PORT AND
      ( H.CATEGORY NOT LIKE 'Pool/AttributeEngine%' AND
        H.CATEGORY NOT LIKE 'Pool/ColumnStore%' AND
        H.CATEGORY NOT IN 
        ( 'Pool/NameIdMapping/RoDict',
          'Pool/RowEngine/CpbTree',
          'Pool/RowStoreTables/CpbTree',
          'Pool/SerializedObject',
          'StackAllocator'
        )
      )
    GROUP BY
      H.CATEGORY,
      H.SERVER_TIMESTAMP
  )
  GROUP BY
    ALLOCATOR
),
SQL_1 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY SUM(ELAPSED_H) DESC) ROW_NUM_TIME,
    ROW_NUMBER () OVER (ORDER BY SUM(EXECUTIONS) DESC) ROW_NUM_EXECUTIONS,
    ROW_NUMBER () OVER (ORDER BY SUM(RECORDS) DESC) ROW_NUM_RECORDS,
    STATEMENT_HASH,
    CASE
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER INDEX%'       THEN 'AI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER SYSTEM%'      THEN 'AS'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER TABLE%'       THEN 'AT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER%'             THEN 'AL'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CALL%'              THEN 'CA'
      WHEN STATEMENT_STRING_CLEANED LIKE 'COMMIT%'            THEN 'CO'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE INDEX%'      THEN 'CI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE TABLE%'      THEN 'CT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE%'            THEN 'CR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DELETE%'            THEN 'DE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP INDEX%'        THEN 'DI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP TABLE%'        THEN 'DT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP%'              THEN 'DR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'EXECUTE%'           THEN 'EX'
      WHEN STATEMENT_STRING_CLEANED LIKE 'INSERT%'            THEN 'IN'
      WHEN STATEMENT_STRING_CLEANED LIKE 'REPLACE%'           THEN 'RE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ROLLBACK%'          THEN 'RO'
      WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%FOR UPDATE%' THEN 'SU'
      WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%'            THEN 'SE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'TRUNCATE%'          THEN 'TR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'UPDATE%'            THEN 'UP'
      WHEN STATEMENT_STRING_CLEANED LIKE 'UPSERT%'            THEN 'US'
      WHEN STATEMENT_STRING_CLEANED LIKE 'WITH%'              THEN 'WI'
      ELSE 'unknown'
    END SQL_TYPE,
    SUM(ELAPSED_H) ELAPSED_H,
    SUM(EXECUTIONS) EXECUTIONS,
    SUM(RECORDS) RECORDS
  FROM
  ( SELECT
      S.STATEMENT_HASH,
      REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), '') STATEMENT_STRING_CLEANED,
      MAX(S.TOTAL_EXECUTION_TIME + S.TOTAL_PREPARATION_TIME) / 1000000 / 3600 ELAPSED_H,
      MAX(S.EXECUTION_COUNT) EXECUTIONS,
      MAX(S.TOTAL_RESULT_RECORD_COUNT) RECORDS
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
    WHERE
      S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      S.HOST LIKE BI.HOST AND
      TO_VARCHAR(S.PORT) LIKE BI.PORT
    GROUP BY
      S.SNAPSHOT_ID,
      S.HOST,
      S.PORT,
      S.STATEMENT_HASH,
      TO_VARCHAR(S.STATEMENT_STRING),
      S.PLAN_ID
  )
  GROUP BY
    STATEMENT_HASH,
    STATEMENT_STRING_CLEANED
),
SQL_2 AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY SUM(ELAPSED_H) DESC) ROW_NUM_TIME,
    ROW_NUMBER () OVER (ORDER BY SUM(EXECUTIONS) DESC) ROW_NUM_EXECUTIONS,
    ROW_NUMBER () OVER (ORDER BY SUM(RECORDS) DESC) ROW_NUM_RECORDS,
    STATEMENT_HASH,
    CASE
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER INDEX%'       THEN 'AI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER SYSTEM%'      THEN 'AS'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER TABLE%'       THEN 'AT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER%'             THEN 'AL'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CALL%'              THEN 'CA'
      WHEN STATEMENT_STRING_CLEANED LIKE 'COMMIT%'            THEN 'CO'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE INDEX%'      THEN 'CI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE TABLE%'      THEN 'CT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE%'            THEN 'CR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DELETE%'            THEN 'DE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP INDEX%'        THEN 'DI'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP TABLE%'        THEN 'DT'
      WHEN STATEMENT_STRING_CLEANED LIKE 'DROP%'              THEN 'DR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'EXECUTE%'           THEN 'EX'
      WHEN STATEMENT_STRING_CLEANED LIKE 'INSERT%'            THEN 'IN'
      WHEN STATEMENT_STRING_CLEANED LIKE 'REPLACE%'           THEN 'RE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'ROLLBACK%'          THEN 'RO'
      WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%FOR UPDATE%' THEN 'SU'
      WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%'            THEN 'SE'
      WHEN STATEMENT_STRING_CLEANED LIKE 'TRUNCATE%'          THEN 'TR'
      WHEN STATEMENT_STRING_CLEANED LIKE 'UPDATE%'            THEN 'UP'
      WHEN STATEMENT_STRING_CLEANED LIKE 'UPSERT%'            THEN 'US'
      WHEN STATEMENT_STRING_CLEANED LIKE 'WITH%'              THEN 'WI'
      ELSE 'unknown'
    END SQL_TYPE,
    SUM(ELAPSED_H) ELAPSED_H,
    SUM(EXECUTIONS) EXECUTIONS,
    SUM(RECORDS) RECORDS
  FROM
  ( SELECT
      S.STATEMENT_HASH,
      REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), '') STATEMENT_STRING_CLEANED,
      MAX(S.TOTAL_EXECUTION_TIME + S.TOTAL_PREPARATION_TIME) / 1000000 / 3600 ELAPSED_H,
      MAX(S.EXECUTION_COUNT) EXECUTIONS,
      MAX(S.TOTAL_RESULT_RECORD_COUNT) RECORDS
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SQL_PLAN_CACHE S
    WHERE
      S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      S.HOST LIKE BI.HOST AND
      TO_VARCHAR(S.PORT) LIKE BI.PORT
    GROUP BY
      S.SNAPSHOT_ID,
      S.HOST,
      S.PORT,
      S.STATEMENT_HASH,
      TO_VARCHAR(S.STATEMENT_STRING),
      S.PLAN_ID
  )
  GROUP BY
    STATEMENT_HASH,
    STATEMENT_STRING_CLEANED
),
THREADS_1 AS
( SELECT
    T.HOST,
    T.PORT,
    CASE
      WHEN T.THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
      ELSE T.THREAD_TYPE
    END THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    CASE
      WHEN T.STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(T.THREAD_METHOD, CHAR(63), T.THREAD_TYPE, T.THREAD_METHOD) || ')'
      ELSE T.STATEMENT_HASH
    END STATEMENT_HASH,
    SUBSTR(T.LOCK_WAIT_NAME, MAP(INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)), 0, 1, INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)) + 2)) LOCK_NAME,
    T.USER_NAME DATABASE_USER_NAME,
    T.APPLICATION_USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.PASSPORT_COMPONENT_NAME PASSPORT_COMPONENT,
    T.PASSPORT_ACTION,
    COUNT(*) * BI.THREAD_HISTORY_INTERVAL_S / 3600 ELAPSED_H
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
  WHERE
    T.TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND T.SITE_ID IN (-1, 0) ) OR T.SITE_ID = BI.SITE_ID ) AND
    T.HOST LIKE BI.HOST AND
    TO_VARCHAR(T.PORT) LIKE BI.PORT
  GROUP BY
    T.HOST,
    T.PORT,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    CASE
      WHEN T.STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(T.THREAD_METHOD, CHAR(63), T.THREAD_TYPE, T.THREAD_METHOD) || ')'
      ELSE T.STATEMENT_HASH
    END,
    SUBSTR(T.LOCK_WAIT_NAME, MAP(INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)), 0, 1, INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)) + 2)),
    T.USER_NAME,
    T.APPLICATION_USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.PASSPORT_COMPONENT_NAME,
    T.PASSPORT_ACTION,
    BI.THREAD_HISTORY_INTERVAL_S
),
THREADS_2 AS
( SELECT
    T.HOST,
    T.PORT,
    CASE
      WHEN T.THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
      ELSE T.THREAD_TYPE
    END THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    CASE
      WHEN T.STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(T.THREAD_METHOD, CHAR(63), T.THREAD_TYPE, T.THREAD_METHOD) || ')'
      ELSE T.STATEMENT_HASH
    END STATEMENT_HASH,
    SUBSTR(T.LOCK_WAIT_NAME, MAP(INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)), 0, 1, INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)) + 2)) LOCK_NAME,
    T.USER_NAME DATABASE_USER_NAME,
    T.APPLICATION_USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.PASSPORT_COMPONENT_NAME PASSPORT_COMPONENT,
    T.PASSPORT_ACTION,
    COUNT(*) * BI.THREAD_HISTORY_INTERVAL_S / 3600 ELAPSED_H
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
  WHERE
    T.TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND T.SITE_ID IN (-1, 0) ) OR T.SITE_ID = BI.SITE_ID ) AND
    T.HOST LIKE BI.HOST AND
    TO_VARCHAR(T.PORT) LIKE BI.PORT
  GROUP BY
    T.USER_NAME,
    T.HOST,
    T.PORT,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    CASE
      WHEN T.STATEMENT_HASH = CHAR(63) THEN 'no SQL (' || MAP(T.THREAD_METHOD, CHAR(63), T.THREAD_TYPE, T.THREAD_METHOD) || ')'
      ELSE T.STATEMENT_HASH
    END,
    SUBSTR(T.LOCK_WAIT_NAME, MAP(INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)), 0, 1, INSTR(T.LOCK_WAIT_NAME, ':' || CHAR(32)) + 2)),
    T.APPLICATION_USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.PASSPORT_COMPONENT_NAME,
    T.PASSPORT_ACTION,
    BI.THREAD_HISTORY_INTERVAL_S
),
WORKLOAD_1 AS
( SELECT
    AVG(CURRENT_EXECUTION_RATE) / 60 EXEC_PER_S,
    AVG(CURRENT_COMPILATION_RATE) / 60 PREP_PER_S,
    AVG(CURRENT_TRANSACTION_RATE) / 60 TRANS_PER_S,
    AVG(CURRENT_UPDATE_TRANSACTION_RATE) / 60 UPD_TRANS_PER_S,
    AVG(CURRENT_COMMIT_RATE) / 60 COMMIT_PER_S,
    AVG(CURRENT_ROLLBACK_RATE) / 60 ROLLBACK_PER_S 
  FROM
  ( SELECT
      SUM(GREATEST(W.CURRENT_EXECUTION_RATE, 0)) CURRENT_EXECUTION_RATE,
      SUM(GREATEST(W.CURRENT_COMPILATION_RATE, 0)) CURRENT_COMPILATION_RATE,
      SUM(GREATEST(W.CURRENT_TRANSACTION_RATE, 0)) CURRENT_TRANSACTION_RATE,
      SUM(GREATEST(W.CURRENT_UPDATE_TRANSACTION_RATE, 0)) CURRENT_UPDATE_TRANSACTION_RATE,
      SUM(GREATEST(W.CURRENT_COMMIT_RATE, 0)) CURRENT_COMMIT_RATE,
      SUM(GREATEST(W.CURRENT_ROLLBACK_RATE, 0)) CURRENT_ROLLBACK_RATE
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_WORKLOAD W
    WHERE
      W.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND W.SITE_ID IN (-1, 0) ) OR W.SITE_ID = BI.SITE_ID ) AND
      W.HOST LIKE BI.HOST AND
      TO_VARCHAR(W.PORT) LIKE BI.PORT
    GROUP BY
      W.SNAPSHOT_ID
  )
),
WORKLOAD_2 AS
( SELECT
    AVG(CURRENT_EXECUTION_RATE) / 60 EXEC_PER_S,
    AVG(CURRENT_COMPILATION_RATE) / 60 PREP_PER_S,
    AVG(CURRENT_TRANSACTION_RATE) / 60 TRANS_PER_S,
    AVG(CURRENT_UPDATE_TRANSACTION_RATE) / 60 UPD_TRANS_PER_S,
    AVG(CURRENT_COMMIT_RATE) / 60 COMMIT_PER_S,
    AVG(CURRENT_ROLLBACK_RATE) / 60 ROLLBACK_PER_S 
  FROM
  ( SELECT
      SUM(GREATEST(W.CURRENT_EXECUTION_RATE, 0)) CURRENT_EXECUTION_RATE,
      SUM(GREATEST(W.CURRENT_COMPILATION_RATE, 0)) CURRENT_COMPILATION_RATE,
      SUM(GREATEST(W.CURRENT_TRANSACTION_RATE, 0)) CURRENT_TRANSACTION_RATE,
      SUM(GREATEST(W.CURRENT_UPDATE_TRANSACTION_RATE, 0)) CURRENT_UPDATE_TRANSACTION_RATE,
      SUM(GREATEST(W.CURRENT_COMMIT_RATE, 0)) CURRENT_COMMIT_RATE,
      SUM(GREATEST(W.CURRENT_ROLLBACK_RATE, 0)) CURRENT_ROLLBACK_RATE
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_WORKLOAD W
    WHERE
      W.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND W.SITE_ID IN (-1, 0) ) OR W.SITE_ID = BI.SITE_ID ) AND
      W.HOST LIKE BI.HOST AND
      TO_VARCHAR(W.PORT) LIKE BI.PORT
    GROUP BY
      W.SNAPSHOT_ID
  )
),
SERVICE_STATISTICS_1 AS
( SELECT
    SUM(SECONDS) SECONDS,
    SUM(CPU_MS) CPU_MS,
    AVG(ACTIVE_THREADS) ACTIVE_THREADS,
    AVG(THREADS) THREADS,
    AVG(MEM_GB) MEM_GB,
    AVG(OPEN_FILES) OPEN_FILES
  FROM
  ( SELECT
      AVG(GREATEST(SS.SNAPSHOT_DELTA, 0)) SECONDS,
      SUM(GREATEST(SS.PROCESS_CPU_TIME_DELTA, 0)) CPU_MS,
      SUM(GREATEST(SS.ACTIVE_THREAD_COUNT, 0)) ACTIVE_THREADS,
      SUM(GREATEST(SS.THREAD_COUNT, 0)) THREADS,
      SUM(GREATEST(SS.PROCESS_MEMORY, 0)) / 1024 / 1024 / 1024 MEM_GB,
      SUM(GREATEST(SS.OPEN_FILE_COUNT, 0)) OPEN_FILES
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SERVICE_STATISTICS SS
    WHERE
      SS.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND SS.SITE_ID IN (-1, 0) ) OR SS.SITE_ID = BI.SITE_ID ) AND
      SS.HOST LIKE BI.HOST AND
      TO_VARCHAR(SS.PORT) LIKE BI.PORT
    GROUP BY
      SS.SNAPSHOT_ID
  )
),
SERVICE_STATISTICS_2 AS
( SELECT
    SUM(SECONDS) SECONDS,
    SUM(CPU_MS) CPU_MS,
    AVG(ACTIVE_THREADS) ACTIVE_THREADS,
    AVG(THREADS) THREADS,
    AVG(MEM_GB) MEM_GB,
    AVG(OPEN_FILES) OPEN_FILES
  FROM
  ( SELECT
      AVG(GREATEST(SS.SNAPSHOT_DELTA, 0)) SECONDS,
      SUM(GREATEST(SS.PROCESS_CPU_TIME_DELTA, 0)) CPU_MS,
      SUM(GREATEST(SS.ACTIVE_THREAD_COUNT, 0)) ACTIVE_THREADS,
      SUM(GREATEST(SS.THREAD_COUNT, 0)) THREADS,
      SUM(GREATEST(SS.PROCESS_MEMORY, 0)) / 1024 / 1024 / 1024 MEM_GB,
      SUM(GREATEST(SS.OPEN_FILE_COUNT, 0)) OPEN_FILES
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SERVICE_STATISTICS SS
    WHERE
      SS.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
      (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND SS.SITE_ID IN (-1, 0) ) OR SS.SITE_ID = BI.SITE_ID ) AND
      SS.HOST LIKE BI.HOST AND
      TO_VARCHAR(SS.PORT) LIKE BI.PORT
    GROUP BY
      SS.SNAPSHOT_ID
  )
),
LOAD_HISTORY_1 AS
( SELECT
    AVG(L.CPU) AVG_CPU_PCT,
    MAX(L.CPU) MAX_CPU_PCT,
    AVG(L.SYSTEM_CPU) AVG_SYS_CPU_PCT,
    MAX(L.SYSTEM_CPU) MAX_SYS_CPU_PCT,
    AVG(L.PING_TIME) AVG_PING_MS,
    MAX(L.PING_TIME) MAX_PING_MS,
    AVG(L.CONNECTION_COUNT) AVG_CONNECTIONS,
    MAX(L.CONNECTION_COUNT) MAX_CONNECTIONS,
    AVG(L.TRANSACTION_COUNT) AVG_TRANSACTIONS,
    MAX(L.TRANSACTION_COUNT) MAX_TRANSACTIONS,
    AVG(L.BLOCKED_TRANSACTION_COUNT) AVG_BLOCKED_TRANSACTIONS,
    MAX(L.BLOCKED_TRANSACTION_COUNT) MAX_BLOCKED_TRANSACTIONS,
    AVG(L.COMMIT_ID_RANGE) AVG_COMMIT_ID_RANGE,
    MAX(L.COMMIT_ID_RANGE) MAX_COMMIT_ID_RANGE,
    AVG(L.PENDING_SESSION_COUNT) AVG_PENDING_SESSIONS,
    MAX(L.PENDING_SESSION_COUNT) MAX_PENDING_SESSIONS,
    AVG(L.MVCC_VERSION_COUNT) AVG_VERSIONS,
    MAX(L.MVCC_VERSION_COUNT) MAX_VERSIONS
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
  WHERE
    L.TIME BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND L.SITE_ID IN (-1, 0) ) OR L.SITE_ID = BI.SITE_ID ) AND
    L.HOST LIKE BI.HOST AND
    TO_VARCHAR(L.PORT) LIKE BI.PORT
),
LOAD_HISTORY_2 AS
( SELECT
    AVG(L.CPU) AVG_CPU_PCT,
    MAX(L.CPU) MAX_CPU_PCT,
    AVG(L.SYSTEM_CPU) AVG_SYS_CPU_PCT,
    MAX(L.SYSTEM_CPU) MAX_SYS_CPU_PCT,
    AVG(L.PING_TIME) AVG_PING_MS,
    MAX(L.PING_TIME) MAX_PING_MS,
    AVG(L.CONNECTION_COUNT) AVG_CONNECTIONS,
    MAX(L.CONNECTION_COUNT) MAX_CONNECTIONS,
    AVG(L.TRANSACTION_COUNT) AVG_TRANSACTIONS,
    MAX(L.TRANSACTION_COUNT) MAX_TRANSACTIONS,
    AVG(L.BLOCKED_TRANSACTION_COUNT) AVG_BLOCKED_TRANSACTIONS,
    MAX(L.BLOCKED_TRANSACTION_COUNT) MAX_BLOCKED_TRANSACTIONS,
    AVG(L.COMMIT_ID_RANGE) AVG_COMMIT_ID_RANGE,
    MAX(L.COMMIT_ID_RANGE) MAX_COMMIT_ID_RANGE,
    AVG(L.PENDING_SESSION_COUNT) AVG_PENDING_SESSIONS,
    MAX(L.PENDING_SESSION_COUNT) MAX_PENDING_SESSIONS,
    AVG(L.MVCC_VERSION_COUNT) AVG_VERSIONS,
    MAX(L.MVCC_VERSION_COUNT) MAX_VERSIONS
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE L
  WHERE
    L.TIME BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND L.SITE_ID IN (-1, 0) ) OR L.SITE_ID = BI.SITE_ID ) AND
    L.HOST LIKE BI.HOST AND
    TO_VARCHAR(L.PORT) LIKE BI.PORT
),
RESOURCES_1 AS
( SELECT
    R.HOST,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_USER_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_USER,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_USER_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_USER,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_SYSTEM_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_SYS,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_SYSTEM_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_SYS,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_WIO_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_WIO,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_WIO_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_WIO,
    AVG(R.USED_PHYSICAL_MEMORY) / 1024 / 1024 / 1024 AVG_PHYS_USED_GB,
    MAX(R.USED_PHYSICAL_MEMORY) / 1024 / 1024 / 1024 MAX_PHYS_USED_GB,
    AVG(R.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 AVG_ALLOC_LIMIT_GB,
    MAX(R.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 MAX_ALLOC_LIMIT_GB,
    AVG(R.INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 AVG_ALLOC_GB,
    MAX(R.INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 MAX_ALLOC_GB,
    AVG(R.INSTANCE_TOTAL_MEMORY_USED_SIZE) / 1024 / 1024 / 1024 AVG_USED_GB,
    MAX(R.INSTANCE_TOTAL_MEMORY_USED_SIZE) / 1024 / 1024 / 1024 MAX_USED_GB,
    AVG(R.INSTANCE_CODE_SIZE) / 1024 / 1024 / 1024 AVG_CODE_GB,
    MAX(R.INSTANCE_CODE_SIZE) / 1024 / 1024 / 1024 MAX_CODE_GB,
    AVG(R.INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 AVG_SHARED_GB,
    MAX(R.INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 MAX_SHARED_GB
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS R
  WHERE
    R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
    R.HOST LIKE BI.HOST
  GROUP BY
    R.HOST
),
RESOURCES_2 AS
( SELECT
    R.HOST,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_USER_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_USER,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_USER_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_USER,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_SYSTEM_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_SYS,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_SYSTEM_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_SYS,
    MAP(SUM(R.SNAPSHOT_DELTA), 0, 0, SUM(R.TOTAL_CPU_WIO_TIME_DELTA) / SUM(R.SNAPSHOT_DELTA)) AVG_CPU_WIO,
    MAX(MAP(R.SNAPSHOT_DELTA, 0, 0, R.TOTAL_CPU_WIO_TIME_DELTA / R.SNAPSHOT_DELTA)) MAX_CPU_WIO,
    AVG(R.USED_PHYSICAL_MEMORY) / 1024 / 1024 / 1024 AVG_PHYS_USED_GB,
    MAX(R.USED_PHYSICAL_MEMORY) / 1024 / 1024 / 1024 MAX_PHYS_USED_GB,
    AVG(R.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 AVG_ALLOC_LIMIT_GB,
    MAX(R.ALLOCATION_LIMIT) / 1024 / 1024 / 1024 MAX_ALLOC_LIMIT_GB,
    AVG(R.INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 AVG_ALLOC_GB,
    MAX(R.INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 MAX_ALLOC_GB,
    AVG(R.INSTANCE_TOTAL_MEMORY_USED_SIZE) / 1024 / 1024 / 1024 AVG_USED_GB,
    MAX(R.INSTANCE_TOTAL_MEMORY_USED_SIZE) / 1024 / 1024 / 1024 MAX_USED_GB,
    AVG(R.INSTANCE_CODE_SIZE) / 1024 / 1024 / 1024 AVG_CODE_GB,
    MAX(R.INSTANCE_CODE_SIZE) / 1024 / 1024 / 1024 MAX_CODE_GB,
    AVG(R.INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 AVG_SHARED_GB,
    MAX(R.INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE) / 1024 / 1024 / 1024 MAX_SHARED_GB
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS R
  WHERE
    R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
    R.HOST LIKE BI.HOST
  GROUP BY
    R.HOST
),
IO_1 AS
( SELECT
    I.HOST,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_READ_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 DATA_READ_GB,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_READ_TIME_DELTA, 0)) / 1000000 DATA_READ_S,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_WRITE_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 DATA_WRITE_GB,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_WRITE_TIME_DELTA, 0)) / 1000000 DATA_WRITE_S,
    SUM(MAP(I.TYPE, 'LOG', I.TOTAL_WRITE_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 LOG_WRITE_GB,
    SUM(MAP(I.TYPE, 'LOG', I.TOTAL_WRITE_TIME_DELTA, 0)) / 1000000 LOG_WRITE_S   
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS I
  WHERE
    I.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND I.SITE_ID IN (-1, 0) ) OR I.SITE_ID = BI.SITE_ID ) AND
    I.HOST LIKE BI.HOST AND
    TO_VARCHAR(I.PORT) LIKE BI.PORT
  GROUP BY
    I.HOST
),
IO_2 AS
( SELECT
    I.HOST,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_READ_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 DATA_READ_GB,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_READ_TIME_DELTA, 0)) / 1000000 DATA_READ_S,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_WRITE_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 DATA_WRITE_GB,
    SUM(MAP(I.TYPE, 'DATA', I.TOTAL_WRITE_TIME_DELTA, 0)) / 1000000 DATA_WRITE_S,
    SUM(MAP(I.TYPE, 'LOG', I.TOTAL_WRITE_SIZE_DELTA, 0)) / 1024 / 1024 / 1024 LOG_WRITE_GB,
    SUM(MAP(I.TYPE, 'LOG', I.TOTAL_WRITE_TIME_DELTA, 0)) / 1000000 LOG_WRITE_S   
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS I
  WHERE
    I.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND I.SITE_ID IN (-1, 0) ) OR I.SITE_ID = BI.SITE_ID ) AND
    I.HOST LIKE BI.HOST AND
    TO_VARCHAR(I.PORT) LIKE BI.PORT
  GROUP BY
    I.HOST
),
REPLICATION_1 AS
( SELECT
    R.HOST,
    SUM(R.SHIPPED_LOG_BUFFERS_SIZE_DELTA) / 1024 / 1024 / 1024 LOG_SIZE_GB,
    SUM(R.SHIPPED_LOG_BUFFERS_DURATION_DELTA) / 1000000 LOG_TIME_S,
    SUM(R.SHIPPED_FULL_REPLICA_SIZE_DELTA) / 1024 / 1024 / 1024 FULL_SIZE_GB,
    SUM(R.SHIPPED_FULL_REPLICA_DURATION_DELTA) / 1000000 FULL_TIME_S,
    SUM(R.SHIPPED_DELTA_REPLICA_SIZE_DELTA) / 1024 / 1024 / 1024 DELTA_SIZE_GB,
    SUM(R.SHIPPED_DELTA_REPLICA_DURATION_DELTA) / 1000000 DELTA_TIME_S
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_REPLICATION R
  WHERE
    R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
    R.HOST LIKE BI.HOST AND
    TO_VARCHAR(R.PORT) LIKE BI.PORT
  GROUP BY
    R.HOST
),
REPLICATION_2 AS
( SELECT
    R.HOST,
    SUM(R.SHIPPED_LOG_BUFFERS_SIZE_DELTA) / 1024 / 1024 / 1024 LOG_SIZE_GB,
    SUM(R.SHIPPED_LOG_BUFFERS_DURATION_DELTA) / 1000000 LOG_TIME_S,
    SUM(R.SHIPPED_FULL_REPLICA_SIZE_DELTA) / 1024 / 1024 / 1024 FULL_SIZE_GB,
    SUM(R.SHIPPED_FULL_REPLICA_DURATION_DELTA) / 1000000 FULL_TIME_S,
    SUM(R.SHIPPED_DELTA_REPLICA_SIZE_DELTA) / 1024 / 1024 / 1024 DELTA_SIZE_GB,
    SUM(R.SHIPPED_DELTA_REPLICA_DURATION_DELTA) / 1000000 DELTA_TIME_S
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_REPLICATION R
  WHERE
    R.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND
    (BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND R.SITE_ID IN (-1, 0) ) OR R.SITE_ID = BI.SITE_ID ) AND
    R.HOST LIKE BI.HOST AND
    TO_VARCHAR(R.PORT) LIKE BI.PORT
  GROUP BY
    R.HOST
)
SELECT
  CASE WHEN BI.MAX_KEY_FIGURE_LENGTH = -1 THEN DETAIL ELSE SUBSTR(DETAIL, 1, BI.MAX_KEY_FIGURE_LENGTH) END DETAIL,
  VALUE_1,
  VALUE_2,
  VALUE_3 DIFF_VAL,
  VALUE_4 DIFF_PCT
FROM
  BASIS_INFO BI,
(
SELECT
  LINE_NO,
  DETAIL,
  LPAD(TO_DECIMAL(VALUE_1, 10, 2), 13) VALUE_1,
  LPAD(TO_DECIMAL(VALUE_2, 10, 2), 13) VALUE_2,
  LPAD(TO_DECIMAL(VALUE_2 - VALUE_1, 10, 2), 12) VALUE_3,
  LPAD(LEAST(9999.99, TO_DECIMAL(MAP(VALUE_1, 0, MAP(VALUE_2, 0, 0, 9999.99), (VALUE_2 / VALUE_1 * 100) - 100), 10, 2)), 8) VALUE_4
FROM
( SELECT 
    10300 LINE_NO, 'TOTAL' DETAIL, DISK_SIZE_GB_1 VALUE_1, DISK_SIZE_GB_2 VALUE_2
  FROM
  ( SELECT SUM(DISK_SIZE_GB) DISK_SIZE_GB_1 FROM PERSISTENCE_1 ) P1,
  ( SELECT SUM(DISK_SIZE_GB) DISK_SIZE_GB_2 FROM PERSISTENCE_2 ) P2
  UNION ALL
  SELECT
    10500 + ROW_NUM, TABLE_NAME, DISK_SIZE_GB_1, DISK_SIZE_GB_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY P2.DISK_SIZE_GB DESC, P1.DISK_SIZE_GB DESC) ROW_NUM,
      IFNULL(P2.SCHEMA_NAME, P1.SCHEMA_NAME) || '.' || IFNULL(P2.TABLE_NAME, P1.TABLE_NAME) TABLE_NAME,
      IFNULL(P1.DISK_SIZE_GB, 0) DISK_SIZE_GB_1,
      IFNULL(P2.DISK_SIZE_GB, 0) DISK_SIZE_GB_2,
      P1.ROW_NUM ROW_NUM_1,
      P2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_DISK
    FROM
      BASIS_INFO BI,
      PERSISTENCE_2 P2 FULL OUTER JOIN
      PERSISTENCE_1 P1 ON
        P1.SCHEMA_NAME = P2.SCHEMA_NAME AND
        P1.TABLE_NAME = P2.TABLE_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_DISK OR ROW_NUM_2 <= TOP_N_DISK )
  UNION ALL
  SELECT 
    20600, 'TOTAL', CS_SIZE_GB_1, CS_SIZE_GB_2
  FROM
  ( SELECT SUM(CS_SIZE_GB) CS_SIZE_GB_1 FROM COLUMN_STORE_1 ) C1,
  ( SELECT SUM(CS_SIZE_GB) CS_SIZE_GB_2 FROM COLUMN_STORE_2 ) C2
  UNION ALL
  SELECT
    20800 + ROW_NUM / 100, TABLE_NAME, CS_SIZE_GB_1, CS_SIZE_GB_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY C2.CS_SIZE_GB DESC, C1.CS_SIZE_GB DESC) ROW_NUM,
      IFNULL(C2.SCHEMA_NAME, C1.SCHEMA_NAME) || '.' || IFNULL(C2.TABLE_NAME, C1.TABLE_NAME) TABLE_NAME,
      IFNULL(C1.CS_SIZE_GB, 0) CS_SIZE_GB_1,
      IFNULL(C2.CS_SIZE_GB, 0) CS_SIZE_GB_2,
      C1.ROW_NUM ROW_NUM_1,
      C2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_CS_SIZE
    FROM
      BASIS_INFO BI,
      COLUMN_STORE_2 C2 FULL OUTER JOIN
      COLUMN_STORE_1 C1 ON
        C1.SCHEMA_NAME = C2.SCHEMA_NAME AND
        C1.TABLE_NAME = C2.TABLE_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_CS_SIZE OR ROW_NUM_2 <= TOP_N_CS_SIZE )
  UNION ALL
  SELECT 
    22600, 'TOTAL', CS_READS_1, CS_READS_2
  FROM
  ( SELECT SUM(READ_COUNT) CS_READS_1 FROM COLUMN_STORE_1 ) C1,
  ( SELECT SUM(READ_COUNT) CS_READS_2 FROM COLUMN_STORE_2 ) C2
  UNION ALL
  SELECT
    22800 + ROW_NUM / 100, TABLE_NAME, READS_1, READS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY C2.READ_COUNT DESC, C1.READ_COUNT DESC) ROW_NUM,
      IFNULL(C2.SCHEMA_NAME, C1.SCHEMA_NAME) || '.' || IFNULL(C2.TABLE_NAME, C1.TABLE_NAME) TABLE_NAME,
      IFNULL(C1.READ_COUNT, 0) READS_1,
      IFNULL(C2.READ_COUNT, 0) READS_2,
      C1.ROW_NUM ROW_NUM_1,
      C2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_CS_READ
    FROM
      BASIS_INFO BI,
      COLUMN_STORE_2 C2 FULL OUTER JOIN
      COLUMN_STORE_1 C1 ON
        C1.SCHEMA_NAME = C2.SCHEMA_NAME AND
        C1.TABLE_NAME = C2.TABLE_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_CS_READ OR ROW_NUM_2 <= TOP_N_CS_READ )
  UNION ALL
  SELECT 
    24600, 'TOTAL', CS_WRITES_1, CS_WRITES_2
  FROM
  ( SELECT SUM(WRITE_COUNT) CS_WRITES_1 FROM COLUMN_STORE_1 ) C1,
  ( SELECT SUM(WRITE_COUNT) CS_WRITES_2 FROM COLUMN_STORE_2 ) C2
  UNION ALL
  SELECT
    24800 + ROW_NUM / 1000, TABLE_NAME, WRITES_1, WRITES_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY C2.WRITE_COUNT DESC, C1.WRITE_COUNT DESC) ROW_NUM,
      IFNULL(C2.SCHEMA_NAME, C1.SCHEMA_NAME) || '.' || IFNULL(C2.TABLE_NAME, C1.TABLE_NAME) TABLE_NAME,
      IFNULL(C1.WRITE_COUNT, 0) WRITES_1,
      IFNULL(C2.WRITE_COUNT, 0) WRITES_2,
      C1.ROW_NUM ROW_NUM_1,
      C2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_CS_WRITE
    FROM
      BASIS_INFO BI,
      COLUMN_STORE_2 C2 FULL OUTER JOIN
      COLUMN_STORE_1 C1 ON
        C1.SCHEMA_NAME = C2.SCHEMA_NAME AND
        C1.TABLE_NAME = C2.TABLE_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_CS_WRITE OR ROW_NUM_2 <= TOP_N_CS_WRITE )
  UNION ALL
  SELECT 
    30600, 'TOTAL', RS_SIZE_GB_1, RS_SIZE_GB_2
  FROM
  ( SELECT SUM(RS_SIZE_GB) RS_SIZE_GB_1 FROM ROW_STORE_1 ) R1,
  ( SELECT SUM(RS_SIZE_GB) RS_SIZE_GB_2 FROM ROW_STORE_2 ) R2
  UNION ALL
  SELECT
    30800 + ROW_NUM / 100, TABLE_NAME, RS_SIZE_GB_1, RS_SIZE_GB_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY R2.RS_SIZE_GB DESC, R1.RS_SIZE_GB DESC) ROW_NUM,
      IFNULL(R2.SCHEMA_NAME, R1.SCHEMA_NAME) || '.' || IFNULL(R2.TABLE_NAME, R1.TABLE_NAME) TABLE_NAME,
      IFNULL(R1.RS_SIZE_GB, 0) RS_SIZE_GB_1,
      IFNULL(R2.RS_SIZE_GB, 0) RS_SIZE_GB_2,
      R1.ROW_NUM ROW_NUM_1,
      R2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_RS_SIZE
    FROM
      BASIS_INFO BI,
      ROW_STORE_2 R2 FULL OUTER JOIN
      ROW_STORE_1 R1 ON
        R1.SCHEMA_NAME = R2.SCHEMA_NAME AND
        R1.TABLE_NAME = R2.TABLE_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_RS_SIZE OR ROW_NUM_2 <= TOP_N_RS_SIZE )
  UNION ALL
  SELECT
    40800 + ROW_NUM / 100, ALLOCATOR, SIZE_GB_1, SIZE_GB_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY H2.SIZE_GB DESC, H1.SIZE_GB DESC) ROW_NUM,
      IFNULL(H2.ALLOCATOR, H1.ALLOCATOR) ALLOCATOR,
      IFNULL(H1.SIZE_GB, 0) SIZE_GB_1,
      IFNULL(H2.SIZE_GB, 0) SIZE_GB_2,
      H1.ROW_NUM ROW_NUM_1,
      H2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_HEAP
    FROM
      BASIS_INFO BI,
      HEAP_2 H2 FULL OUTER JOIN
      HEAP_1 H1 ON
        H1.ALLOCATOR = H2.ALLOCATOR
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_HEAP OR ROW_NUM_2 <= TOP_N_HEAP )
  UNION ALL
  SELECT 
    50600, 'TOTAL', STATEMENTS_1, STATEMENTS_2 
  FROM
  ( SELECT MAP(MAX(INTERVAL_S_1), 0, 0, SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1)) STATEMENTS_1 FROM BASIS_INFO, SQL_1 ) S1,
  ( SELECT MAP(MAX(INTERVAL_S_2), 0, 0, SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2)) STATEMENTS_2 FROM BASIS_INFO, SQL_2 ) S2
  UNION ALL
  SELECT
    50700 + ROW_NUM / 10000000,
    STATEMENT_HASH || CHAR(32) || '(' || SQL_TYPE || ')', STATEMENTS_1, STATEMENTS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY S2.ELAPSED_H DESC, S1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(S2.STATEMENT_HASH, S1.STATEMENT_HASH) STATEMENT_HASH,
      IFNULL(S2.SQL_TYPE, S1.SQL_TYPE) SQL_TYPE,
      IFNULL(S1.ELAPSED_H, 0) * 3600 / BI.INTERVAL_S_1 STATEMENTS_1,
      IFNULL(S2.ELAPSED_H, 0) * 3600 / BI.INTERVAL_S_2 STATEMENTS_2,
      S1.ROW_NUM_TIME ROW_NUM_1,
      S2.ROW_NUM_TIME ROW_NUM_2,
      BI.TOP_N_SQL_TIME
    FROM
      BASIS_INFO BI,
      SQL_2 S2 FULL OUTER JOIN
      SQL_1 S1 ON
        S1.STATEMENT_HASH = S2.STATEMENT_HASH
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_SQL_TIME OR ROW_NUM_2 <= TOP_N_SQL_TIME )
  UNION ALL
  SELECT 
    50798, 'TOTAL', RECORDS_1, RECORDS_2 
  FROM
  ( SELECT MAP(MAX(INTERVAL_S_1), 0, 0, SUM(RECORDS) / MAX(INTERVAL_S_1)) RECORDS_1 FROM BASIS_INFO, SQL_1 ) S1,
  ( SELECT MAP(MAX(INTERVAL_S_2), 0, 0, SUM(RECORDS) / MAX(INTERVAL_S_2)) RECORDS_2 FROM BASIS_INFO, SQL_2 ) S2
  UNION ALL
  SELECT
    50800 + ROW_NUM / 10000000,
    STATEMENT_HASH || CHAR(32) || '(' || SQL_TYPE || ')', RECORDS_1, RECORDS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY S2.RECORDS DESC, S1.RECORDS DESC) ROW_NUM,
      IFNULL(S2.STATEMENT_HASH, S1.STATEMENT_HASH) STATEMENT_HASH,
      IFNULL(S2.SQL_TYPE, S1.SQL_TYPE) SQL_TYPE,
      IFNULL(S1.RECORDS, 0) / BI.INTERVAL_S_1 RECORDS_1,
      IFNULL(S2.RECORDS, 0) / BI.INTERVAL_S_2 RECORDS_2,
      S1.ROW_NUM_RECORDS ROW_NUM_1,
      S2.ROW_NUM_RECORDS ROW_NUM_2,
      BI.TOP_N_SQL_RECORDS
    FROM
      BASIS_INFO BI,
      SQL_2 S2 FULL OUTER JOIN
      SQL_1 S1 ON
        S1.STATEMENT_HASH = S2.STATEMENT_HASH
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_SQL_RECORDS OR ROW_NUM_2 <= TOP_N_SQL_RECORDS )
  UNION ALL
  SELECT 
    50898, 'TOTAL', EXECUTIONS_1, EXECUTIONS_2 
  FROM
  ( SELECT SUM(EXECUTIONS) / MAX(INTERVAL_S_1) EXECUTIONS_1 FROM BASIS_INFO, SQL_1 ) S1,
  ( SELECT SUM(EXECUTIONS) / MAX(INTERVAL_S_2) EXECUTIONS_2 FROM BASIS_INFO, SQL_2 ) S2
  UNION ALL
  SELECT
    50900 + ROW_NUM / 10000000,
    STATEMENT_HASH || CHAR(32) || '(' || SQL_TYPE || ')', EXECUTIONS_1, EXECUTIONS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY S2.EXECUTIONS DESC, S1.EXECUTIONS DESC) ROW_NUM,
      IFNULL(S2.STATEMENT_HASH, S1.STATEMENT_HASH) STATEMENT_HASH,
      IFNULL(S2.SQL_TYPE, S1.SQL_TYPE) SQL_TYPE,
      IFNULL(S1.EXECUTIONS, 0) / BI.INTERVAL_S_1 EXECUTIONS_1,
      IFNULL(S2.EXECUTIONS, 0) / BI.INTERVAL_S_2 EXECUTIONS_2,
      S1.ROW_NUM_EXECUTIONS ROW_NUM_1,
      S2.ROW_NUM_EXECUTIONS ROW_NUM_2,
      BI.TOP_N_SQL_EXECUTIONS
    FROM
      BASIS_INFO BI,
      SQL_2 S2 FULL OUTER JOIN
      SQL_1 S1 ON
        S1.STATEMENT_HASH = S2.STATEMENT_HASH
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_SQL_EXECUTIONS OR ROW_NUM_2 <= TOP_N_SQL_EXECUTIONS )
  UNION ALL
  SELECT 
    60600 + I.LINE_NO, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT 0 LINE_NO FROM DUMMY UNION SELECT 10000 FROM DUMMY UNION SELECT 19585 FROM DUMMY UNION SELECT 30000 FROM DUMMY ) I,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT
    60800 + ROW_NUM / 1000000, STATEMENT_HASH, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.STATEMENT_HASH, T1.STATEMENT_HASH) STATEMENT_HASH,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_SQL
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, STATEMENT_HASH, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY STATEMENT_HASH ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, STATEMENT_HASH, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY STATEMENT_HASH ) T1 ON
        T1.STATEMENT_HASH = T2.STATEMENT_HASH
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_SQL OR ROW_NUM_2 <= TOP_N_THREAD_SQL )
  UNION ALL
  SELECT
    70800 + ROW_NUM / 1000000, THREAD_ACTIVITY, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.THREAD_TYPE, T1.THREAD_TYPE) || CHAR(32) || '(' || IFNULL(T2.THREAD_STATE, T1.THREAD_STATE) || ')' THREAD_ACTIVITY,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_TYPES
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, THREAD_TYPE, THREAD_STATE, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY THREAD_TYPE, THREAD_STATE ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, THREAD_TYPE, THREAD_STATE, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY THREAD_TYPE, THREAD_STATE ) T1 ON
        T1.THREAD_TYPE = T2.THREAD_TYPE AND
        T1.THREAD_STATE = T2.THREAD_STATE
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_TYPES OR ROW_NUM_2 <= TOP_N_THREAD_TYPES )
  UNION ALL
  SELECT
    80200 + ROW_NUM / 1000, THREAD_ACTIVITY, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.THREAD_METHOD, T1.THREAD_METHOD) THREAD_ACTIVITY,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_METHODS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, THREAD_METHOD, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY THREAD_METHOD ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, THREAD_METHOD, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY THREAD_METHOD ) T1 ON
        T1.THREAD_METHOD = T2.THREAD_METHOD
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_METHODS OR ROW_NUM_2 <= TOP_N_THREAD_METHODS )
  UNION ALL
  SELECT 
    80600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 WHERE LOCK_NAME != CHAR(63) ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 WHERE LOCK_NAME != CHAR(63) ) T2
  UNION ALL
  SELECT
    80800 + ROW_NUM / 1000000, LOCK_NAME, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.LOCK_NAME, T1.LOCK_NAME) LOCK_NAME,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_LOCKS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, LOCK_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 WHERE LOCK_NAME != CHAR(63) GROUP BY LOCK_NAME ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, LOCK_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 WHERE LOCK_NAME != CHAR(63) GROUP BY LOCK_NAME ) T1 ON
        T1.LOCK_NAME = T2.LOCK_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_LOCKS OR ROW_NUM_2 <= TOP_N_THREAD_LOCKS )
  UNION ALL
  SELECT
    90800 + ROW_NUM / 10000, APPLICATION_USER_NAME, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.APPLICATION_USER_NAME, T1.APPLICATION_USER_NAME) APPLICATION_USER_NAME,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_APP_USERS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_USER_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY APPLICATION_USER_NAME ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_USER_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY APPLICATION_USER_NAME ) T1 ON
        T1.APPLICATION_USER_NAME = T2.APPLICATION_USER_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_APP_USERS OR ROW_NUM_2 <= TOP_N_THREAD_APP_USERS )
  UNION ALL
  SELECT 
    90352, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT
    90354 + ROW_NUM / 100000, DATABASE_USER_NAME, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.DATABASE_USER_NAME, T1.DATABASE_USER_NAME) DATABASE_USER_NAME,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_DB_USERS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, DATABASE_USER_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY DATABASE_USER_NAME ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, DATABASE_USER_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY DATABASE_USER_NAME ) T1 ON
        T1.DATABASE_USER_NAME = T2.DATABASE_USER_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_DB_USERS OR ROW_NUM_2 <= TOP_N_THREAD_DB_USERS )
  UNION ALL
  SELECT 
    100600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT
    100800 + ROW_NUM / 1000000, APPLICATION_NAME, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.APPLICATION_NAME, T1.APPLICATION_NAME) APPLICATION_NAME,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_APP_NAMES
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY APPLICATION_NAME ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_NAME, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY APPLICATION_NAME ) T1 ON
        T1.APPLICATION_NAME = T2.APPLICATION_NAME
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_APP_NAMES OR ROW_NUM_2 <= TOP_N_THREAD_APP_NAMES )
  UNION ALL
  SELECT 
    110600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT
    110800 + ROW_NUM / 10000, APPLICATION_SOURCE, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.APPLICATION_SOURCE, T1.APPLICATION_SOURCE) APPLICATION_SOURCE,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_APP_SOURCES
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_SOURCE, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY APPLICATION_SOURCE ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, APPLICATION_SOURCE, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY APPLICATION_SOURCE ) T1 ON
        T1.APPLICATION_SOURCE = T2.APPLICATION_SOURCE
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_APP_SOURCES OR ROW_NUM_2 <= TOP_N_THREAD_APP_SOURCES )
  UNION ALL
  SELECT 
    120600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT 
    130600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT 
    140600, 'TOTAL', THREADS_1, THREADS_2
  FROM
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_1) THREADS_1 FROM BASIS_INFO, THREADS_1 ) T1,
  ( SELECT SUM(ELAPSED_H) * 3600 / MAX(INTERVAL_S_2) THREADS_2 FROM BASIS_INFO, THREADS_2 ) T2
  UNION ALL
  SELECT
    120800 + ROW_NUM / 10000, PASSPORT_COMPONENT, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.PASSPORT_COMPONENT, T1.PASSPORT_COMPONENT) PASSPORT_COMPONENT,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_PASSPORT_COMPONENTS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, PASSPORT_COMPONENT, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY PASSPORT_COMPONENT ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, PASSPORT_COMPONENT, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY PASSPORT_COMPONENT ) T1 ON
        T1.PASSPORT_COMPONENT = T2.PASSPORT_COMPONENT
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_PASSPORT_COMPONENTS OR ROW_NUM_2 <= TOP_N_THREAD_PASSPORT_COMPONENTS )
  UNION ALL
  SELECT
    130800 + ROW_NUM / 10000, PASSPORT_ACTION, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.PASSPORT_ACTION, T1.PASSPORT_ACTION) PASSPORT_ACTION,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_PASSPORT_ACTIONS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, PASSPORT_ACTION, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY PASSPORT_ACTION ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, PASSPORT_ACTION, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY PASSPORT_ACTION ) T1 ON
        T1.PASSPORT_ACTION = T2.PASSPORT_ACTION
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_PASSPORT_ACTIONS OR ROW_NUM_2 <= TOP_N_THREAD_PASSPORT_ACTIONS )
  UNION ALL
  SELECT
    140800 + ROW_NUM / 1000000, HOST_PORT, THREADS_1, THREADS_2
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY T2.ELAPSED_H DESC, T1.ELAPSED_H DESC) ROW_NUM,
      IFNULL(T2.HOST, T1.HOST) || ':' || IFNULL(T2.PORT, T1.PORT) HOST_PORT,
      IFNULL(T1.ELAPSED_H, 0) * 3600 / INTERVAL_S_1 THREADS_1,
      IFNULL(T2.ELAPSED_H, 0) * 3600 / INTERVAL_S_2 THREADS_2,
      T1.ROW_NUM ROW_NUM_1,
      T2.ROW_NUM ROW_NUM_2,
      BI.TOP_N_THREAD_HOST_PORTS
    FROM
      BASIS_INFO BI,
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, HOST, PORT, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_2 GROUP BY HOST, PORT ) T2 FULL OUTER JOIN
      ( SELECT ROW_NUMBER () OVER ( ORDER BY SUM(ELAPSED_H) DESC ) ROW_NUM, HOST, PORT, SUM(ELAPSED_H) ELAPSED_H FROM THREADS_1 GROUP BY HOST, PORT ) T1 ON
        T1.HOST = T2.HOST AND
        T1.PORT = T2.PORT
  )
  WHERE
  ( ROW_NUM_1 <= TOP_N_THREAD_HOST_PORTS OR ROW_NUM_2 <= TOP_N_THREAD_HOST_PORTS )
  UNION ALL
  SELECT
    190600 + LINE_NO, DESCRIPTION, RATE_PER_S_1, RATE_PER_S_2
  FROM
  ( SELECT
      L.LINE_NO,
      L.DESCRIPTION,
      CASE L.DESCRIPTION
        WHEN 'Executions'          THEN W1.EXEC_PER_S
        WHEN 'Preparations'        THEN W1.PREP_PER_S
        WHEN 'Transactions'        THEN W1.TRANS_PER_S
        WHEN 'Update transactions' THEN W1.UPD_TRANS_PER_S
        WHEN 'Commits'             THEN W1.COMMIT_PER_S
        WHEN 'Rollbacks'           THEN W1.ROLLBACK_PER_S
      END RATE_PER_S_1,
      CASE L.DESCRIPTION
        WHEN 'Executions'          THEN W2.EXEC_PER_S
        WHEN 'Preparations'        THEN W2.PREP_PER_S
        WHEN 'Transactions'        THEN W2.TRANS_PER_S
        WHEN 'Update transactions' THEN W2.UPD_TRANS_PER_S
        WHEN 'Commits'             THEN W2.COMMIT_PER_S
        WHEN 'Rollbacks'           THEN W2.ROLLBACK_PER_S
      END RATE_PER_S_2
    FROM
    ( SELECT 10 LINE_NO, 'Executions' DESCRIPTION FROM DUMMY UNION ALL
      SELECT 20, 'Preparations' FROM DUMMY UNION ALL
      SELECT 30, 'Transactions' FROM DUMMY UNION ALL
      SELECT 40, 'Update transactions' FROM DUMMY UNION ALL
      SELECT 50, 'Commits' FROM DUMMY UNION ALL
      SELECT 60, 'Rollbacks' FROM DUMMY
    ) L,
      WORKLOAD_1 W1,
      WORKLOAD_2 W2
  )
  UNION ALL
  SELECT
    195600 + LINE_NO, DESCRIPTION, RATE_PER_S_1, RATE_PER_S_2
  FROM
  ( SELECT
      L.LINE_NO,
      L.DESCRIPTION,
      CASE L.DESCRIPTION
        WHEN 'Total threads'         THEN SS1.THREADS
        WHEN 'Active threads'        THEN SS1.ACTIVE_THREADS
        WHEN 'Active CPUs'           THEN SS1.CPU_MS / 1000 / SS1.SECONDS
        WHEN 'Allocated memory (GB)' THEN SS1.MEM_GB
        WHEN 'Open files'            THEN SS1.OPEN_FILES
      END RATE_PER_S_1,
      CASE L.DESCRIPTION
        WHEN 'Total threads'         THEN SS2.THREADS
        WHEN 'Active threads'        THEN SS2.ACTIVE_THREADS
        WHEN 'Active CPUs'           THEN SS2.CPU_MS / 1000 / SS1.SECONDS
        WHEN 'Allocated memory (GB)' THEN SS2.MEM_GB
        WHEN 'Open files'            THEN SS2.OPEN_FILES
      END RATE_PER_S_2
    FROM
    ( SELECT 10 LINE_NO, 'Total threads' DESCRIPTION FROM DUMMY UNION ALL
      SELECT 20, 'Active threads'        FROM DUMMY UNION ALL
      SELECT 30, 'Active CPUs'           FROM DUMMY UNION ALL
      SELECT 40, 'Allocated memory (GB)' FROM DUMMY UNION ALL
      SELECT 50, 'Open files'            FROM DUMMY 
    ) L,
      SERVICE_STATISTICS_1 SS1,
      SERVICE_STATISTICS_2 SS2
  )
  UNION ALL
  SELECT
    200600 + LINE_NO, DESCRIPTION, VALUE_1, VALUE_2
  FROM
  ( SELECT
      L.LINE_NO,
      L.DESCRIPTION,
      CASE L.DESCRIPTION
        WHEN 'CPU utilization avg. (%)'        THEN W1.AVG_CPU_PCT
        WHEN 'CPU utilization max. (%)'        THEN W1.MAX_CPU_PCT
        WHEN 'System CPU utilization avg. (%)' THEN W1.AVG_SYS_CPU_PCT
        WHEN 'System CPU utilization max. (%)' THEN W1.MAX_SYS_CPU_PCT
        WHEN 'Ping time avg. (ms)'             THEN W1.AVG_PING_MS
        WHEN 'Ping time max. (ms)'             THEN W1.MAX_PING_MS
        WHEN 'Connections avg.'                THEN W1.AVG_CONNECTIONS
        WHEN 'Connections max.'                THEN W1.MAX_CONNECTIONS
        WHEN 'Transactions avg.'               THEN W1.AVG_TRANSACTIONS
        WHEN 'Transactions max.'               THEN W1.MAX_TRANSACTIONS
        WHEN 'Blocked transactions avg.'       THEN W1.AVG_BLOCKED_TRANSACTIONS
        WHEN 'Blocked transactions max.'       THEN W1.MAX_BLOCKED_TRANSACTIONS
        WHEN 'Commit ID range avg.'            THEN W1.AVG_COMMIT_ID_RANGE
        WHEN 'Commit ID range max.'            THEN W1.MAX_COMMIT_ID_RANGE
        WHEN 'Row store versions avg.'         THEN W1.AVG_VERSIONS
        WHEN 'Row store versions max.'         THEN W1.MAX_VERSIONS
        WHEN 'Pending sessions avg.'           THEN W1.AVG_PENDING_SESSIONS
        WHEN 'Pending sessions max.'           THEN W1.MAX_PENDING_SESSIONS
      END VALUE_1,
      CASE L.DESCRIPTION
        WHEN 'CPU utilization avg. (%)'        THEN W2.AVG_CPU_PCT
        WHEN 'CPU utilization max. (%)'        THEN W2.MAX_CPU_PCT
        WHEN 'System CPU utilization avg. (%)' THEN W2.AVG_SYS_CPU_PCT
        WHEN 'System CPU utilization max. (%)' THEN W2.MAX_SYS_CPU_PCT
        WHEN 'Ping time avg. (ms)'             THEN W2.AVG_PING_MS
        WHEN 'Ping time max. (ms)'             THEN W2.MAX_PING_MS
        WHEN 'Connections avg.'                THEN W2.AVG_CONNECTIONS
        WHEN 'Connections max.'                THEN W2.MAX_CONNECTIONS
        WHEN 'Transactions avg.'               THEN W2.AVG_TRANSACTIONS
        WHEN 'Transactions max.'               THEN W2.MAX_TRANSACTIONS
        WHEN 'Blocked transactions avg.'       THEN W2.AVG_BLOCKED_TRANSACTIONS
        WHEN 'Blocked transactions max.'       THEN W2.MAX_BLOCKED_TRANSACTIONS
        WHEN 'Commit ID range avg.'            THEN W2.AVG_COMMIT_ID_RANGE
        WHEN 'Commit ID range max.'            THEN W2.MAX_COMMIT_ID_RANGE
        WHEN 'Row store versions avg.'         THEN W2.AVG_VERSIONS
        WHEN 'Row store versions max.'         THEN W2.MAX_VERSIONS
        WHEN 'Pending sessions avg.'           THEN W2.AVG_PENDING_SESSIONS
        WHEN 'Pending sessions max.'           THEN W2.MAX_PENDING_SESSIONS
      END VALUE_2
    FROM
    ( SELECT  10 LINE_NO, 'CPU utilization avg. (%)' DESCRIPTION FROM DUMMY UNION ALL
      SELECT  20, 'CPU utilization max. (%)'        FROM DUMMY UNION ALL
      SELECT  30, 'System CPU utilization avg. (%)' FROM DUMMY UNION ALL
      SELECT  40, 'System CPU utilization max. (%)' FROM DUMMY UNION ALL
      SELECT  50, 'Ping time avg. (ms)'             FROM DUMMY UNION ALL
      SELECT  60, 'Ping time max. (ms)'             FROM DUMMY UNION ALL
      SELECT  70, 'Connections avg.'                FROM DUMMY UNION ALL
      SELECT  80, 'Connections max.'                FROM DUMMY UNION ALL
      SELECT  90, 'Transactions avg.'               FROM DUMMY UNION ALL
      SELECT 100, 'Transactions max.'               FROM DUMMY UNION ALL
      SELECT 110, 'Blocked transactions avg.'       FROM DUMMY UNION ALL
      SELECT 120, 'Blocked transactions max.'       FROM DUMMY UNION ALL
      SELECT 130, 'Commit ID range avg.'            FROM DUMMY UNION ALL
      SELECT 140, 'Commit ID range max.'            FROM DUMMY UNION ALL 
      SELECT 150, 'Row store versions avg.'         FROM DUMMY UNION ALL
      SELECT 160, 'Row store versions max.'         FROM DUMMY UNION ALL
      SELECT 170, 'Pending sessions avg.'           FROM DUMMY UNION ALL
      SELECT 180, 'Pending sessions max.'           FROM DUMMY
    ) L,
      LOAD_HISTORY_1 W1,
      LOAD_HISTORY_2 W2
  )
  UNION ALL
  SELECT
    210600, 'Unloads', UNLOADS_1, UNLOADS_2
  FROM
  ( SELECT
      IFNULL(SUM(CASE WHEN U.UNLOAD_TIME BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 THEN 1 ELSE 0 END), 0) UNLOADS_1,
      IFNULL(SUM(CASE WHEN U.UNLOAD_TIME BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 THEN 1 ELSE 0 END), 0) UNLOADS_2
    FROM
      BASIS_INFO BI,
      M_CS_UNLOADS U
    WHERE
      U.HOST LIKE BI.HOST AND
      TO_VARCHAR(U.PORT) LIKE BI.PORT AND
      U.REASON = 'LOW MEMORY'
  )
  UNION ALL
  SELECT
    210700 + I.LINE_NO, I.DESCRIPTION,
    CASE I.LINE_NO
      WHEN 1 THEN M.MERGES_1
      WHEN 2 THEN M.MERGE_TIME_S_1
      WHEN 3 THEN M.MERGE_RECORDS_1
      WHEN 4 THEN M.COMPRESSIONS_1
      WHEN 5 THEN M.COMPRESSION_TIME_S_1
      WHEN 6 THEN M.COMPRESSION_RECORDS_1
    END,
    CASE I.LINE_NO
      WHEN 1 THEN M.MERGES_2
      WHEN 2 THEN M.MERGE_TIME_S_2
      WHEN 3 THEN M.MERGE_RECORDS_2
      WHEN 4 THEN M.COMPRESSIONS_2
      WHEN 5 THEN M.COMPRESSION_TIME_S_2
      WHEN 6 THEN M.COMPRESSION_RECORDS_2
    END
  FROM
  ( SELECT 1 LINE_NO, 'Delta merges ' DESCRIPTION FROM DUMMY UNION ALL
    SELECT 2, 'Delta merge time (s)' FROM DUMMY UNION ALL
    SELECT 3, 'Delta merge records'  FROM DUMMY UNION ALL
    SELECT 4, 'Compressions'         FROM DUMMY UNION ALL
    SELECT 5, 'Compression time (s)' FROM DUMMY 
  ) I,
  ( SELECT
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE != 'SPARSE' THEN 1 ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) MERGES_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE != 'SPARSE' THEN 1 ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) MERGES_2,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE != 'SPARSE' THEN M.EXECUTION_TIME ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) / 1000 MERGE_TIME_S_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE != 'SPARSE' THEN M.EXECUTION_TIME ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) / 1000 MERGE_TIME_S_2,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE != 'SPARSE' THEN M.MERGED_DELTA_RECORDS ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) MERGE_RECORDS_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE != 'SPARSE' THEN M.MERGED_DELTA_RECORDS ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) MERGE_RECORDS_2,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE = 'SPARSE' THEN 1 ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) COMPRESSIONS_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE = 'SPARSE' THEN 1 ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) COMPRESSIONS_2,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE = 'SPARSE' THEN M.EXECUTION_TIME ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) / 1000 COMPRESSION_TIME_S_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE = 'SPARSE' THEN M.EXECUTION_TIME ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) / 1000 COMPRESSION_TIME_S_2,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 AND M.TYPE = 'SPARSE' THEN M.MERGED_DELTA_RECORDS ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) COMPRESSION_RECORDS_1,
      IFNULL(SUM(CASE WHEN M.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 AND M.TYPE = 'SPARSE' THEN M.MERGED_DELTA_RECORDS ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) COMPRESSION_RECORDS_2
   FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS M
   WHERE
     M.HOST LIKE BI.HOST AND
     TO_VARCHAR(M.PORT) LIKE BI.PORT
  ) M
  UNION ALL
  SELECT
    210800 + I.LINE_NO,
    I.DESCRIPTION,
    CASE I.LINE_NO
      WHEN 1 THEN S.SAVEPOINTS_1
      WHEN 2 THEN S.SP_DURATION_S_1
      WHEN 3 THEN S.SP_BLK_TIME_S_1
      WHEN 4 THEN S.SP_SIZE_GB_1
    END,
    CASE I.LINE_NO
      WHEN 1 THEN S.SAVEPOINTS_2
      WHEN 2 THEN S.SP_DURATION_S_2
      WHEN 3 THEN S.SP_BLK_TIME_S_2
      WHEN 4 THEN S.SP_SIZE_GB_2
    END
  FROM
  ( SELECT 1 LINE_NO, 'Savepoints' DESCRIPTION    FROM DUMMY UNION ALL
    SELECT 2, 'Savepoint time (s)'                FROM DUMMY UNION ALL
    SELECT 3, 'Savepoint blocking phase time (s)' FROM DUMMY UNION ALL
    SELECT 4, 'Savepoint size (GB)'               FROM DUMMY
  ) I,
  ( SELECT
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 THEN 1 ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) SAVEPOINTS_1,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 THEN 1 ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) SAVEPOINTS_2,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 THEN DURATION ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) / 1000000 SP_DURATION_S_1,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 THEN DURATION ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) / 1000000 SP_DURATION_S_2,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 THEN CRITICAL_PHASE_WAIT_TIME + CRITICAL_PHASE_DURATION ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) / 1000000 SP_BLK_TIME_S_1,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 THEN CRITICAL_PHASE_WAIT_TIME + CRITICAL_PHASE_DURATION ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) / 1000000 SP_BLK_TIME_S_2,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_1 AND BI.END_TIME_1 THEN TOTAL_SIZE ELSE 0 END / BI.INTERVAL_S_1 * 3600), 0) / 1024 / 1024 / 1024 SP_SIZE_GB_1,
      IFNULL(SUM(CASE WHEN S.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME_2 AND BI.END_TIME_2 THEN TOTAL_SIZE ELSE 0 END / BI.INTERVAL_S_2 * 3600), 0) / 1024 / 1024 / 1024 SP_SIZE_GB_2
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SAVEPOINTS S
    WHERE
     S.HOST LIKE BI.HOST AND
     TO_VARCHAR(S.PORT) LIKE BI.PORT
  ) S
  UNION ALL
  SELECT
    220800 + I.LINE_NO * 32 + ROW_NUMBER () OVER (PARTITION BY I.LINE_NO ORDER BY R1.HOST) / 1000,
    I.DESCRIPTION || CHAR(32) || '(' || R1.HOST || ')',
    CASE I.LINE_NO
      WHEN  1 THEN R1.AVG_CPU_USER
      WHEN  2 THEN R1.MAX_CPU_USER
      WHEN  3 THEN R1.AVG_CPU_SYS
      WHEN  4 THEN R1.MAX_CPU_SYS
      WHEN  5 THEN R1.AVG_CPU_WIO
      WHEN  6 THEN R1.MAX_CPU_WIO
      WHEN 11 THEN R1.AVG_PHYS_USED_GB
      WHEN 12 THEN R1.MAX_PHYS_USED_GB
      WHEN 13 THEN R1.AVG_ALLOC_LIMIT_GB
      WHEN 14 THEN R1.MAX_ALLOC_LIMIT_GB
      WHEN 15 THEN R1.AVG_ALLOC_GB
      WHEN 16 THEN R1.MAX_ALLOC_GB
      WHEN 17 THEN R1.AVG_USED_GB
      WHEN 18 THEN R1.MAX_USED_GB
      WHEN 19 THEN R1.AVG_CODE_GB
      WHEN 20 THEN R1.MAX_CODE_GB
      WHEN 21 THEN R1.AVG_SHARED_GB
      WHEN 22 THEN R1.MAX_SHARED_GB
    END,
    CASE I.LINE_NO
      WHEN  1 THEN R2.AVG_CPU_USER
      WHEN  2 THEN R2.MAX_CPU_USER
      WHEN  3 THEN R2.AVG_CPU_SYS
      WHEN  4 THEN R2.MAX_CPU_SYS
      WHEN  5 THEN R2.AVG_CPU_WIO
      WHEN  6 THEN R2.MAX_CPU_WIO
      WHEN 11 THEN R2.AVG_PHYS_USED_GB
      WHEN 12 THEN R2.MAX_PHYS_USED_GB
      WHEN 13 THEN R2.AVG_ALLOC_LIMIT_GB
      WHEN 14 THEN R2.MAX_ALLOC_LIMIT_GB
      WHEN 15 THEN R2.AVG_ALLOC_GB
      WHEN 16 THEN R2.MAX_ALLOC_GB
      WHEN 17 THEN R2.AVG_USED_GB
      WHEN 18 THEN R2.MAX_USED_GB
      WHEN 19 THEN R2.AVG_CODE_GB
      WHEN 20 THEN R2.MAX_CODE_GB
      WHEN 21 THEN R2.AVG_SHARED_GB
      WHEN 22 THEN R2.MAX_SHARED_GB
    END
  FROM
  ( SELECT  1 LINE_NO, 'CPUs in user mode avg.' DESCRIPTION FROM DUMMY UNION ALL
    SELECT  2, 'CPUs in user mode max.'              FROM DUMMY UNION ALL
    SELECT  3, 'CPUs in system mode avg.'            FROM DUMMY UNION ALL
    SELECT  4, 'CPUs in system mode max.'            FROM DUMMY UNION ALL
    SELECT  5, 'CPUs in wait I/O mode avg.'          FROM DUMMY UNION ALL
    SELECT  6, 'CPUs in wait I/O mode max.'          FROM DUMMY UNION ALL
    SELECT 11, 'Physical memory used avg. (GB)'      FROM DUMMY UNION ALL
    SELECT 12, 'Physical memory used max. (GB)'      FROM DUMMY UNION ALL
    SELECT 13, 'Global allocation limit avg. (GB)'   FROM DUMMY UNION ALL
    SELECT 14, 'Global allocation limit max. (GB)'   FROM DUMMY UNION ALL
    SELECT 15, 'Instance memory allocated avg. (GB)' FROM DUMMY UNION ALL
    SELECT 16, 'Instance memory allocated max. (GB)' FROM DUMMY UNION ALL
    SELECT 17, 'Instance memory used avg. (GB)'      FROM DUMMY UNION ALL
    SELECT 18, 'Instance memory used max. (GB)'      FROM DUMMY UNION ALL
    SELECT 19, 'Code size avg. (GB)'                 FROM DUMMY UNION ALL
    SELECT 20, 'Code size max. (GB)'                 FROM DUMMY UNION ALL
    SELECT 21, 'Shared memory avg. (GB)'             FROM DUMMY UNION ALL
    SELECT 22, 'Shared memory max. (GB)'             FROM DUMMY
  ) I,
    RESOURCES_1 R1,
    RESOURCES_2 R2
  WHERE
    R1.HOST = R2.HOST
  UNION ALL
  SELECT
    230800 + I.LINE_NO * 32 + ROW_NUMBER () OVER (PARTITION BY I.LINE_NO ORDER BY I1.HOST) / 1000,
    I.DESCRIPTION || CHAR(32) || '(' || I1.HOST || ')',
    CASE I.LINE_NO
      WHEN 1 THEN I1.DATA_READ_GB / BI.INTERVAL_S_1 * 3600
      WHEN 2 THEN I1.DATA_READ_S / BI.INTERVAL_S_1 * 3600
      WHEN 3 THEN MAP(I1.DATA_READ_S, 0, 0, I1.DATA_READ_GB * 1024 / I1.DATA_READ_S)
      WHEN 4 THEN I1.DATA_WRITE_GB / BI.INTERVAL_S_1 * 3600
      WHEN 5 THEN I1.DATA_WRITE_S / BI.INTERVAL_S_1 * 3600
      WHEN 6 THEN MAP(I1.DATA_WRITE_S, 0, 0, I1.DATA_WRITE_GB * 1024 / I1.DATA_WRITE_S)
      WHEN 7 THEN I1.LOG_WRITE_GB / BI.INTERVAL_S_1 * 3600
      WHEN 8 THEN I1.LOG_WRITE_S / BI.INTERVAL_S_1 * 3600
      WHEN 9 THEN MAP(I1.LOG_WRITE_S, 0, 0, I1.LOG_WRITE_GB * 1024 / I1.LOG_WRITE_S)
    END,
    CASE I.LINE_NO
      WHEN 1 THEN I2.DATA_READ_GB / BI.INTERVAL_S_2 * 3600
      WHEN 2 THEN I2.DATA_READ_S / BI.INTERVAL_S_2 * 3600
      WHEN 3 THEN MAP(I2.DATA_READ_S, 0, 0, I2.DATA_READ_GB * 1024 / I2.DATA_READ_S)
      WHEN 4 THEN I2.DATA_WRITE_GB / BI.INTERVAL_S_2 * 3600
      WHEN 5 THEN I2.DATA_WRITE_S / BI.INTERVAL_S_2 * 3600
      WHEN 6 THEN MAP(I2.DATA_WRITE_S, 0, 0, I2.DATA_WRITE_GB * 1024 / I2.DATA_WRITE_S)
      WHEN 7 THEN I2.LOG_WRITE_GB / BI.INTERVAL_S_2 * 3600
      WHEN 8 THEN I2.LOG_WRITE_S / BI.INTERVAL_S_2 * 3600
      WHEN 9 THEN MAP(I2.LOG_WRITE_S, 0, 0, I2.LOG_WRITE_GB * 1024 / I2.LOG_WRITE_S)
    END
  FROM
  ( SELECT 1 LINE_NO, 'Data read size per hour (GB)' DESCRIPTION FROM DUMMY UNION ALL
    SELECT 2, 'Data read time per hour (s)'   FROM DUMMY UNION ALL
    SELECT 3, 'Data read throughput (MB/s)'   FROM DUMMY UNION ALL
    SELECT 4, 'Data write size per hour (GB)' FROM DUMMY UNION ALL
    SELECT 5, 'Data write time per hour (s)'  FROM DUMMY UNION ALL
    SELECT 6, 'Data write throughput (MB/s)'  FROM DUMMY UNION ALL
    SELECT 7, 'Log write size per hour (GB)'  FROM DUMMY UNION ALL
    SELECT 8, 'Log write time per hour (s)'   FROM DUMMY UNION ALL
    SELECT 9, 'Log write throughput (MB/s)'   FROM DUMMY
  ) I,
    BASIS_INFO BI,
    IO_1 I1,
    IO_2 I2
  WHERE
    I1.HOST = I2.HOST
  UNION ALL
  SELECT
    240800 + I.LINE_NO * 32 + ROW_NUMBER () OVER (PARTITION BY I.LINE_NO ORDER BY R1.HOST) / 1000,
    I.DESCRIPTION || CHAR(32) || '(' || R1.HOST || ')',
    CASE I.LINE_NO
      WHEN 1 THEN R1.LOG_SIZE_GB / BI.INTERVAL_S_1 * 3600
      WHEN 2 THEN R1.LOG_TIME_S / BI.INTERVAL_S_1 * 3600
      WHEN 3 THEN MAP(R1.LOG_TIME_S, 0, 0, R1.LOG_SIZE_GB * 1024 / R1.LOG_TIME_S)
      WHEN 4 THEN R1.FULL_SIZE_GB / BI.INTERVAL_S_1 * 3600
      WHEN 5 THEN R1.FULL_TIME_S / BI.INTERVAL_S_1 * 3600
      WHEN 6 THEN MAP(R1.FULL_TIME_S, 0, 0, R1.FULL_SIZE_GB * 1024 / R1.FULL_TIME_S)
      WHEN 7 THEN R1.DELTA_SIZE_GB / BI.INTERVAL_S_1 * 3600
      WHEN 8 THEN R1.DELTA_TIME_S / BI.INTERVAL_S_1 * 3600
      WHEN 9 THEN MAP(R1.DELTA_TIME_S, 0, 0, R1.DELTA_SIZE_GB * 1024 / R1.DELTA_TIME_S)
    END,
    CASE I.LINE_NO
      WHEN 1 THEN R2.LOG_SIZE_GB / BI.INTERVAL_S_2 * 3600
      WHEN 2 THEN R2.LOG_TIME_S / BI.INTERVAL_S_2 * 3600
      WHEN 3 THEN MAP(R2.LOG_TIME_S, 0, 0, R2.LOG_SIZE_GB * 1024 / R2.LOG_TIME_S)
      WHEN 4 THEN R2.FULL_SIZE_GB / BI.INTERVAL_S_2 * 3600
      WHEN 5 THEN R2.FULL_TIME_S / BI.INTERVAL_S_2 * 3600
      WHEN 6 THEN MAP(R2.FULL_TIME_S, 0, 0, R2.FULL_SIZE_GB * 1024 / R2.FULL_TIME_S)
      WHEN 7 THEN R2.DELTA_SIZE_GB / BI.INTERVAL_S_2 * 3600
      WHEN 8 THEN R2.DELTA_TIME_S / BI.INTERVAL_S_2 * 3600
      WHEN 9 THEN MAP(R2.DELTA_TIME_S, 0, 0, R2.DELTA_SIZE_GB * 1024 / R2.DELTA_TIME_S)
    END
  FROM
  ( SELECT 1 LINE_NO, 'Log shipping size per hour (GB)' DESCRIPTION FROM DUMMY UNION ALL
    SELECT 2, 'Log shipping time per hour (s)'   FROM DUMMY UNION ALL
    SELECT 3, 'Log shipping throughput (MB/s)'   FROM DUMMY UNION ALL
    SELECT 4, 'Full replica size per hour (GB)'  FROM DUMMY UNION ALL
    SELECT 5, 'Full replica time per hour (s)'   FROM DUMMY UNION ALL
    SELECT 6, 'Full replica throughput (MB/s)'   FROM DUMMY UNION ALL
    SELECT 7, 'Delta replica size per hour (GB)' FROM DUMMY UNION ALL
    SELECT 8, 'Delta replica time per hour (s)'  FROM DUMMY UNION ALL
    SELECT 9, 'Delta replica throughput (MB/s)'  FROM DUMMY
  ) I,
    BASIS_INFO BI,
    REPLICATION_1 R1,
    REPLICATION_2 R2
  WHERE
    R1.HOST = R2.HOST
)
UNION ALL
SELECT
  LINE_NO,
  DETAIL,
  VALUE_1,
  VALUE_2,
  VALUE_3,
  VALUE_4
FROM
( SELECT 100 LINE_NO, 'SAP HANA DIFF REPORT' DETAIL, '' VALUE_1, '' VALUE_2, '' VALUE_3, '' VALUE_4 FROM DUMMY
  UNION ALL
  SELECT 200, '********************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 310, RPAD('Generated with:', 16) || 'SQL: "HANA_Global_DiffReport" (SAP Note 1969700)', '', '', '', ''                                FROM DUMMY
  UNION ALL SELECT   320, RPAD('System ID / database name:', 27) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME, '', '', '', ''  FROM M_DATABASE
  UNION ALL SELECT   330, RPAD('Revision level:', 16)            || VERSION, '', '', '', ''                                                    FROM M_DATABASE
  UNION ALL
  SELECT 400, RPAD('Time frame 1:', 16, CHAR(32)) || TO_VARCHAR(BEGIN_TIME_1_ORIG, 'YYYY/MM/DD HH24:MI:SS') || '-' || TO_VARCHAR(END_TIME_1_ORIG, 'YYYY/MM/DD HH24:MI:SS'), '', '', '', '' FROM BASIS_INFO
  UNION ALL
  SELECT 500, RPAD('Time frame 2:', 16, CHAR(32)) || TO_VARCHAR(BEGIN_TIME_2_ORIG, 'YYYY/MM/DD HH24:MI:SS') || '-' || TO_VARCHAR(END_TIME_2_ORIG, 'YYYY/MM/DD HH24:MI:SS'), '', '', '', '' FROM BASIS_INFO
  UNION ALL
  SELECT 510, RPAD('Host:', 16, CHAR(32)) || HOST, '', '', '', '' FROM BASIS_INFO WHERE HOST != '%'
  UNION ALL
  SELECT 520, RPAD('Port:', 16, CHAR(32)) || PORT, '', '', '', '' FROM BASIS_INFO WHERE PORT != '%'
  UNION ALL
  SELECT 600, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 700, 'DISK', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 800, '****', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 10000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 10100, 'TABLE_NAME', 'SIZE_GB_1', 'SIZE_GB_2', 'DIFF_GB', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 10200, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 10400, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20100, 'COLUMN STORE', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20200, '************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20400, 'TABLE_NAME', 'SIZE_GB_1', 'SIZE_GB_2', 'DIFF_GB', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 20500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 20700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 22300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 22400, 'TABLE_NAME', 'READS_1', 'READS_2', 'DIFF_READS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 22500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 22700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 24300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 24400, 'TABLE_NAME', 'WRITES_1', 'WRITES_2', 'DIFF_WRITES', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 24500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 24700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30100, 'ROW STORE', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30200, '*********', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30400, 'TABLE_NAME', 'SIZE_GB_1', 'SIZE_GB_2', 'DIFF_GB', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 30500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 30700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 40000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 40100, 'HEAP MEMORY', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 40200, '***********', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 40300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 40400, 'ALLOCATOR', 'PEAK_GB_1', 'PEAK_GB_2', 'DIFF_GB', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 40700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50100, 'SQL', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50200, '***', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50400, 'STATEMENT_HASH', 'STATEMENTS_1', 'STATEMENTS_2', 'DIFF_STMTS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 50500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50601, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50796, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50797, 'STATEMENT_HASH', 'REC_PER_S_1', 'REC_PER_S_2', 'DIFF_RECORDS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 50797.5, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50799, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50896, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50897, 'STATEMENT_HASH', 'EXEC_PER_S_1', 'EXEC_PER_S_2', 'DIFF_EXECS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 50897.5, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 50899, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60100, 'THREADS', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60200, '*******', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60400, 'STATEMENT_HASH', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 60500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 60700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 70300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 70400, 'THREAD_TYPE / THREAD_STATE', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 70500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 70700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80170, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80180, 'THREAD_METHOD', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 80183, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80190, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80400, 'LOCK_NAME', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 80500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 80700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90350, 'DB_USER', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 90351, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90353, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90355, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90400, 'APPLICATION_USER', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 90500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 90700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 100300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 100400, 'APPLICATION_NAME', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 100500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 100700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 110300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 110400, 'APPLICATION_SOURCE', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 110500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 110700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 120300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 120400, 'PASSPORT_COMPONENT', 'COMPONENT_1', 'COMPONENT_2', 'DIFF_COMP', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 120500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 120700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 130300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 130400, 'PASSPORT_ACTION', 'ACTION_1', 'ACTION_2', 'DIFF_ACTION', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 130500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 130700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 140300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 140400, 'HOST / PORT', 'THREADS_1', 'THREADS_2', 'DIFF_THREADS', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 140500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 140700, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 190000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 190100, 'WORKLOAD', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 190200, '********', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 190300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 190400, 'WORKLOAD_TYPE', 'RATE_PER_S_1', 'RATE_PER_S_2', 'DIFF_RATE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 190500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 195000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 195100, 'SERVICE STATISTICS', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 195200, '******************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 195300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 195400, 'SERVICE_STATISTIC', 'VALUE_1', 'VALUE_2', 'DIFF_VALUE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 195500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 200000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 200100, 'LOAD HISTORY', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 200200, '************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 200300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 200400, 'WORKLOAD_TYPE', 'VALUE_1', 'VALUE_2', 'DIFF_VALUE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 200500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 210000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 210100, 'INTERNAL TASKS', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 210200, '**************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 210300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 210400, 'KEY FIGURE', 'VAL_PER_H_1', 'VAL_PER_H_2', 'DIFF_VALUE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 210500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 220000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 220100, 'RESOURCES', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 220200, '*********', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 220300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 220400, 'KEY FIGURE', 'VALUE_1', 'VALUE_2', 'DIFF_VALUE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 220500, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 240000, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 240100, 'SYSTEM REPLICATION', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 240200, '******************', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 240300, '', '', '', '', '' FROM DUMMY
  UNION ALL
  SELECT 240400, 'KEY FIGURE', 'VALUE_1', 'VALUE_2', 'DIFF_VALUE', 'DIFF_PCT' FROM DUMMY
  UNION ALL
  SELECT 240500, '', '', '', '', '' FROM DUMMY
))
ORDER BY
  LINE_NO
WITH HINT (IGNORE_PLAN_CACHE)
