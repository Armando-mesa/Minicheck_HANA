SELECT

/* 

[NAME]

- HANA_NSE_BufferCache_2.00.076+

[DESCRIPTION]

- Native storage extension (NSE) buffer cache details

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- See SAP Note 2799997 for more details related to NSE.
- M_BUFFER_CACHE_STATISTICS and M_BUFFER_CACHE_POOL_STATISTICS available with SAP HANA >= 2.00.040
- USED_SIZE with SAP HANA 2.0 SPS 04 is actually the allocated size. With SAP HANA 2.0 >= SPS 05 the 
  former USED_SIZE value is shown in the ALLOCATED_SIZE column and a new and correct USED_SIZE column
  is introduced.
- HOST_BUFFER_CACHE_STATISTICS and HOST_BUFFER_CACHE_POOL_STATISTICS available with SAP HANA >= 2.00.062
- M_BUFFER_CACHE_STATISTICS.IO_READ_SIZE available with SAP HANA >= 2.00.070
- Delta columns IO_READ_SIZE_DELTA, BUFFER_REUSE_COUNT_DELTA and MISS_COUNT_DELTA in HOST_BUFFER_CACHE_STATISTICS available with SAP HANA >= 2.00.076

[VALID FOR]

- Revisions:              >= 2.00.076

[SQL COMMAND VERSION]

- 2019/07/10:  1.0 (initial version)
- 2021/11/07:  1.1 (WARM_GB added)
- 2021/11/08:  1.2 (OUT_OF_BUFFER_COUNT added)
- 2023/04/22:  1.3 (dedicated 2.00.070+ version including IO_SIZE_GB)
- 2023/10/03:  1.4 (ALLOC_GB included)
- 2023/11/28:  1.5 (DATA_SOURCE = 'HISTORY' included, complete redesign)
- 2024/07/10:  1.6 (dedicated 2.00.076+ version considering IO_READ_SIZE_DELTA, BUFFER_REUSE_COUNT_DELTA and MISS_COUNT_DELTA)

[INVOLVED TABLES]

- HOST_BUFFER_CACHE_POOL_STATISTICS
- HOST_BUFFER_CACHE_STATISTICS
- M_BUFFER_CACHE_POOL_STATISTICS
- M_BUFFER_CACHE_STATISTICS

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

  'saphana01'     --> Specific host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- BUFFER_SIZE_KB

  Buffer page size (KB)

  '4'             --> Only display information for buffer pages with size 4 KB (4096 byte)
  '%'             --> No restriction related to buffer page size

- EXCLUDE_UNUSED

  Possibility to exclude "empty" buffers

  'X'             --> Only show buffers that are not empty
  ' '             --> Display all buffers

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

- SNAPSHOT_TIME:      Snapshot time
- ST:                 Site ID
- HOST:               Host
- PORT:               Port
- WARM_GB:            Amount of warm data (GB), current size, not historic
- MAX_SIZE_GB:        Maximum possible buffer size (GB), controlled by max_size / max_size_rel, typically 10 % of memory)
- ALLOC_GB:           Allocated buffer size (GB)
- USED_GB:            Used buffer size (GB)
- IO_SIZE_GB:         IO read size (GB)
- HIT_PCT:            Buffer cache hit ratio (%)
- BUFF_KB:            Page size class (KB)
- BUFF_TOT_GB:        Total page size (GB)
- BUFF_HOT_GB:        Hot page size (GB)
- BUFF_FREE_GB:       Free page size (GB)
- OOB:                Out-of-buffer count

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------------------------------------
|SNAPSHOT_TIME   |ST|HOST         |PORT |WARM_GB|MAX_SIZE_GB|ALLOC_GB|USED_GB|IO_SIZE_GB|HIT_PCT|BUFF_KB|BUFF_TOT_GB|BUFF_HOT_GB|BUFF_FREE_GB|OOB|
--------------------------------------------------------------------------------------------------------------------------------------------------
|2023/11/29 (WED)| 1|saphananode01|32003| 100.00|     461.66|  431.10| 402.55|   2958.49|  99.98|      4|       0.00|       0.00|        0.00|  0|
|2023/11/29 (WED)| 1|saphananode01|32003| 100.00|     461.66|  431.10| 402.55|   2958.49|  99.98|     16|       0.00|       0.00|        0.00|  0|
|2023/11/29 (WED)| 1|saphananode01|32003| 100.00|     461.66|  431.10| 402.55|   2958.49|  99.98|     64|       0.00|       0.00|        0.00|  0|
|2023/11/29 (WED)| 1|saphananode01|32003| 100.00|     461.66|  431.10| 402.55|   2958.49|  99.98|    256|     117.39|     114.66|        0.99|  0|
|2023/11/29 (WED)| 1|saphananode01|32003| 100.00|     461.66|  431.10| 402.55|   2958.49|  99.98|   1024|     313.09|     200.18|        9.25|  0|
|2023/11/28 (TUE)| 1|saphananode01|32003| 100.00|     461.66|  449.78| 424.54|   2500.06|  99.98|      4|       0.00|       0.00|        0.00|  0|
|2023/11/28 (TUE)| 1|saphananode01|32003| 100.00|     461.66|  449.78| 424.54|   2500.06|  99.98|     16|       0.00|       0.00|        0.00|  0|
|2023/11/28 (TUE)| 1|saphananode01|32003| 100.00|     461.66|  449.78| 424.54|   2500.06|  99.98|     64|       0.00|       0.00|        0.00|  0|
|2023/11/28 (TUE)| 1|saphananode01|32003| 100.00|     461.66|  449.78| 424.54|   2500.06|  99.98|    256|     113.90|     112.63|        0.73|  0|
|2023/11/28 (TUE)| 1|saphananode01|32003| 100.00|     461.66|  449.78| 424.54|   2500.06|  99.98|   1024|     335.24|     182.63|        6.90|  0|
|2023/11/27 (MON)| 1|saphananode01|32003| 100.00|     461.66|  439.52| 410.62|   1676.65|  99.98|      4|       0.00|       0.00|        0.00|  0|
|2023/11/27 (MON)| 1|saphananode01|32003| 100.00|     461.66|  439.52| 410.62|   1676.65|  99.98|     16|       0.00|       0.00|        0.00|  0|
|2023/11/27 (MON)| 1|saphananode01|32003| 100.00|     461.66|  439.52| 410.62|   1676.65|  99.98|     64|       0.00|       0.00|        0.00|  0|
|2023/11/27 (MON)| 1|saphananode01|32003| 100.00|     461.66|  439.52| 410.62|   1676.65|  99.98|    256|     117.54|     111.73|        4.06|  0|
|2023/11/27 (MON)| 1|saphananode01|32003| 100.00|     461.66|  439.52| 410.62|   1676.65|  99.98|   1024|     321.34|     141.80|        9.09|  0|
--------------------------------------------------------------------------------------------------------------------------------------------------

*/

  SNAPSHOT_TIME,
  IFNULL(LPAD(SITE_ID, 2), '') ST,
  HOST,
  PORT,
  LPAD(TO_DECIMAL(WARM_GB, 10, 2), 7) WARM_GB,
  LPAD(TO_DECIMAL(MAX_GB, 10, 2), 11) MAX_SIZE_GB,
  LPAD(TO_DECIMAL(ALLOC_GB, 10, 2), 8) ALLOC_GB,
  LPAD(TO_DECIMAL(USED_GB, 10, 2), 7) USED_GB,
  LPAD(TO_DECIMAL(IO_READ_GB, 10, 2), 10) IO_SIZE_GB,
  LPAD(TO_DECIMAL(HIT_RATIO, 10, 2), 7) HIT_PCT,
  LPAD(BUFF_KB, 7) BUFF_KB,
  LPAD(MAP(BUFF_KB, 'any', 'any', TO_VARCHAR(TO_DECIMAL(TOTAL_BUFFER_COUNT * BUFF_KB / 1024 / 1024, 10, 2))), 11) BUFF_TOT_GB,
  LPAD(MAP(BUFF_KB, 'any', 'any', TO_VARCHAR(TO_DECIMAL(HOT_BUFFER_COUNT * BUFF_KB / 1024 / 1024, 10, 2))), 11) BUFF_HOT_GB,
  LPAD(MAP(BUFF_KB, 'any', 'any', TO_VARCHAR(TO_DECIMAL(FREE_BUFFER_COUNT * BUFF_KB / 1024 / 1024, 10, 2))), 12) BUFF_FREE_GB,
  LPAD(OUT_OF_BUFFER_COUNT, 3) OOB
FROM
( SELECT
    SNAPSHOT_TIME,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(SITE_ID) ELSE MAP(BI_SITE_ID,   -1, 'any', TO_VARCHAR(BI_SITE_ID)) END SITE_ID,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')    != 0 THEN HOST                ELSE MAP(BI_HOST,     '%', 'any', BI_HOST)                END HOST,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(PORT)    ELSE MAP(BI_PORT,     '%', 'any', BI_PORT)                END PORT,
    BUFF_KB,
    SUM(WARM_GB) / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END WARM_GB,
    SUM(MAX_GB)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END MAX_GB,
    SUM(ALLOC_GB)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END ALLOC_GB,
    SUM(USED_GB)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END USED_GB,
    SUM(PINNED_GB)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END PINNED_GB,
    SUM(IO_READ_GB)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END IO_READ_GB,
    SUM(BUFF_REUSE_COUNT)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END BUFF_REUSE_COUNT,
    SUM(MISS_COUNT)  / CASE WHEN BUFF_KB = 'any' THEN BUFFER_SIZES ELSE 1 END MISS_COUNT,
    SUM(TOTAL_BUFFER_COUNT) TOTAL_BUFFER_COUNT,
    SUM(HOT_BUFFER_COUNT) HOT_BUFFER_COUNT,
    SUM(FREE_BUFFER_COUNT) FREE_BUFFER_COUNT,
    SUM(OUT_OF_BUFFER_COUNT) OUT_OF_BUFFER_COUNT,
    AVG(HIT_RATIO) HIT_RATIO
  FROM
  ( SELECT
      CASE 
        WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE C.SNAPSHOT_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE C.SNAPSHOT_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END SNAPSHOT_TIME,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SIZE') != 0 THEN C.BUFF_KB ELSE MAP(BI.BUFFER_SIZE_KB, '%', 'any', BI.BUFFER_SIZE_KB) END BUFF_KB,
      C.SITE_ID,
      C.HOST,
      C.PORT,
      AVG(W.WARM_GB) WARM_GB,
      MAX(C.MAX_GB) MAX_GB,
      AVG(C.ALLOC_GB) ALLOC_GB,
      AVG(C.USED_GB) USED_GB,
      AVG(C.PINNED_GB) PINNED_GB,
      SUM(C.IO_READ_GB) IO_READ_GB,
      SUM(C.BUFF_REUSE_COUNT) BUFF_REUSE_COUNT,
      SUM(C.MISS_COUNT) MISS_COUNT,
      AVG(C.TOTAL_BUFFER_COUNT) TOTAL_BUFFER_COUNT,
      AVG(C.HOT_BUFFER_COUNT) HOT_BUFFER_COUNT,
      AVG(C.FREE_BUFFER_COUNT) FREE_BUFFER_COUNT,
      SUM(C.OUT_OF_BUFFER_COUNT) OUT_OF_BUFFER_COUNT,
      AVG(C.HIT_RATIO) HIT_RATIO,
      COUNT(DISTINCT(C.BUFF_KB)) OVER (PARTITION BY C.HOST, C.PORT, C.SITE_ID) BUFFER_SIZES,
      BI.AGGREGATE_BY,
      BI.SITE_ID BI_SITE_ID,
      BI.HOST BI_HOST,
      BI.PORT BI_PORT
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
        BUFFER_SIZE_KB,
        EXCLUDE_UNUSED,
        DATA_SOURCE,
        AGGREGATE_BY,
        MAP(TIME_AGGREGATE_BY,
          'NONE',        'YYYY/MM/DD HH24:MI:SS',
          'HOUR',        'YYYY/MM/DD HH24',
          'DAY',         'YYYY/MM/DD (DY)',
          'HOUR_OF_DAY', 'HH24',
          TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY
      FROM
      ( SELECT                       /* Modification section */
          '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
          '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
          'SERVER' TIMEZONE,                              /* SERVER, UTC */
          -1 SITE_ID,
          '%' HOST,
          '%' PORT,
          '%' BUFFER_SIZE_KB,
          'X' EXCLUDE_UNUSED,
          'CURRENT' DATA_SOURCE,                        /* CURRENT, HISTORY */
          'NONE' AGGREGATE_BY,          /* TIME, SITE_ID, HOST, PORT, SIZE or comma separated combinations, NONE for no aggregation */
          'NONE' TIME_AGGREGATE_BY     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
        FROM
          DUMMY
      )
    ) BI,
    ( SELECT HOST, PORT, SUM(MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE) / 1024 / 1024 / 1024 WARM_GB FROM M_CS_COLUMNS_PERSISTENCE GROUP BY HOST, PORT ) W,
    ( SELECT
        'CURRENT' DATA_SOURCE,
        CURRENT_TIMESTAMP SNAPSHOT_TIME,
        CURRENT_SITE_ID() SITE_ID,
        C.HOST,
        C.PORT,
        C.MAX_SIZE / 1024 / 1024 / 1024 MAX_GB,
        C.ALLOCATED_SIZE / 1024 / 1024 / 1024 ALLOC_GB,
        C.USED_SIZE / 1024 / 1024 /1024 USED_GB,
        C.PINNED_SIZE / 1024 / 1024 / 1024 PINNED_GB,
        C.IO_READ_SIZE / 1024 / 1024 / 1024 IO_READ_GB,
        C.BUFFER_REUSE_COUNT BUFF_REUSE_COUNT,
        C.MISS_COUNT,
        C.HIT_RATIO,
        TO_VARCHAR(TO_DECIMAL(CP.BUFFER_SIZE / 1024, 10, 0)) BUFF_KB,
        CP.TOTAL_BUFFER_COUNT,
        CP.HOT_BUFFER_COUNT,
        CP.FREE_BUFFER_COUNT,
        CP.OUT_OF_BUFFER_COUNT
      FROM
        M_BUFFER_CACHE_STATISTICS C,
        M_BUFFER_CACHE_POOL_STATISTICS CP
      WHERE
        CP.HOST = C.HOST AND
        CP.PORT = C.PORT AND
        CP.CACHE_NAME = C.CACHE_NAME
      UNION ALL
      SELECT
        'HISTORY' DATA_SOURCE,
        C.SERVER_TIMESTAMP SNAPSHOT_TIME,
        C.SITE_ID,
        C.HOST,
        C.PORT,
        C.MAX_SIZE / 1024 / 1024 / 1024 MAX_GB,
        C.ALLOCATED_SIZE / 1024 / 1024 / 1024 ALLOC_GB,
        C.USED_SIZE / 1024 / 1024 /1024 USED_GB,
        C.PINNED_SIZE / 1024 / 1024 / 1024 PINNED_GB,
        C.IO_READ_SIZE_DELTA / 1024 / 1024 / 1024 IO_READ_GB,
        C.BUFFER_REUSE_COUNT_DELTA BUFF_REUSE_COUNT,
        C.MISS_COUNT_DELTA MISS_COUNT,
        C.HIT_RATIO,
        TO_VARCHAR(TO_DECIMAL(CP.BUFFER_SIZE / 1024, 10, 0)) BUFF_KB,
        CP.TOTAL_BUFFER_COUNT,
        CP.HOT_BUFFER_COUNT,
        CP.FREE_BUFFER_COUNT,
        CP.OUT_OF_BUFFER_COUNT
      FROM
        _SYS_STATISTICS.HOST_BUFFER_CACHE_STATISTICS C,
        _SYS_STATISTICS.HOST_BUFFER_CACHE_POOL_STATISTICS CP
      WHERE
        SECONDS_BETWEEN(C.SERVER_TIMESTAMP, CP.SERVER_TIMESTAMP) BETWEEN -10 AND 10 AND
        CP.SITE_ID = C.SITE_ID AND
        CP.HOST = C.HOST AND
        CP.PORT = C.PORT AND
        CP.CACHE_NAME = C.CACHE_NAME
    ) C
    WHERE
      ( BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND C.SITE_ID IN (-1, 0) ) OR C.SITE_ID = BI.SITE_ID ) AND
      C.HOST LIKE BI.HOST AND
      TO_VARCHAR(C.PORT) LIKE BI.PORT AND
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE C.SNAPSHOT_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
      C.BUFF_KB LIKE BI.BUFFER_SIZE_KB AND
      ( BI.EXCLUDE_UNUSED = ' ' OR C.TOTAL_BUFFER_COUNT > 0 ) AND
      C.DATA_SOURCE = BI.DATA_SOURCE AND
      W.HOST = C.HOST AND
      W.PORT = C.PORT
    GROUP BY
      CASE 
        WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE C.SNAPSHOT_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE C.SNAPSHOT_TIME END, BI.TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SIZE') != 0 THEN C.BUFF_KB ELSE MAP(BI.BUFFER_SIZE_KB, '%', 'any', BI.BUFFER_SIZE_KB) END,
      C.SITE_ID,
      C.HOST,
      C.PORT,
      C.BUFF_KB,
      BI.AGGREGATE_BY,
      BI.SITE_ID,
      BI.HOST,
      BI.PORT,
      BI.BUFFER_SIZE_KB
  )
  GROUP BY
    SNAPSHOT_TIME,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(SITE_ID) ELSE MAP(BI_SITE_ID,   -1, 'any', TO_VARCHAR(BI_SITE_ID)) END,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')    != 0 THEN HOST                ELSE MAP(BI_HOST,     '%', 'any', BI_HOST)                END,
    CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(PORT)    ELSE MAP(BI_PORT,     '%', 'any', BI_PORT)                END,
    BUFF_KB,
    BUFFER_SIZES
)
ORDER BY
  SNAPSHOT_TIME DESC,
  SITE_ID,
  HOST,
  PORT,
  BUFF_KB