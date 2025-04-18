SELECT 

/* 

[NAME]

- HANA_Memory_Heap_Counts

[DESCRIPTION]

- Heap 

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2024/02/28:  1.0 (initial version)

[INVOLVED TABLES]

- HOST_HEAP_ALLOCATORS
- M_HEAP_MEMORY

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

  'saphana01'     --> Specific host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- ALLOCATOR_NAME

  Heap allocator name

  'Pool/itab'     --> Heap allocator Pool/itab
  '%Version%'     --> Heap allocators containing 'Version' in name
  '%'             --> No restriction for heap allocator name

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

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'TIME'          --> Sorting by time
  'SIZE'          --> Sorting by allocated memory size

[OUTPUT PARAMETERS]

- SNAPSHOT_TIME:  Snapshot time
- HOST:           Host name
- PORT:           Port
- ALLOCATOR_NAME: Heap allocator name
- COUNT:          Entry count
- SIZE_GB:        Total size (GB)
- AVG_SIZE_KB:    Average entry size (KB)

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------
|SNAPSHOT_TIME   |PORT |ALLOCATOR_NAME                                              |COUNT     |SIZE_GB|AVG_SIZE_KB|
--------------------------------------------------------------------------------------------------------------------
|2024/02/28 (WED)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1848620122| 227.05|       0.12|
|2024/02/27 (TUE)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|2127707273| 254.08|       0.12|
|2024/02/26 (MON)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|2824565100| 321.58|       0.11|
|2024/02/25 (SUN)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|3154480788| 344.32|       0.11|
|2024/02/24 (SAT)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|2204816452| 237.55|       0.11|
|2024/02/23 (FRI)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1677666307| 186.49|       0.11|
|2024/02/22 (THU)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1673314473| 186.07|       0.11|
|2024/02/21 (WED)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1669351895| 185.69|       0.11|
|2024/02/20 (TUE)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1665389887| 185.30|       0.11|
|2024/02/19 (MON)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1661552960| 184.93|       0.11|
|2024/02/18 (SUN)|30040|Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map|1657760747| 184.56|       0.11|
--------------------------------------------------------------------------------------------------------------------

*/

  SNAPSHOT_TIME,
  HOST,
  LPAD(PORT, 5) PORT,
  ALLOCATOR_NAME,
  LPAD(TO_DECIMAL(EXCLUSIVE_COUNT_IN_USE, 10, 0), 10) COUNT,
  LPAD(TO_DECIMAL(EXCLUSIVE_SIZE_IN_USE / 1024 / 1024 / 1024, 10, 2), 7) SIZE_GB,
  LPAD(TO_DECIMAL(MAP(EXCLUSIVE_COUNT_IN_USE, 0, 0, EXCLUSIVE_SIZE_IN_USE / 1024 / EXCLUSIVE_COUNT_IN_USE), 11, 2), 11) AVG_SIZE_KB
FROM
( SELECT
    CASE 
      WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE SNAPSHOT_TIME END) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE SNAPSHOT_TIME END, TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END SNAPSHOT_TIME,
    HOST,
    PORT,
    ALLOCATOR_NAME,
    AVG(EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
    AVG(EXCLUSIVE_COUNT_IN_USE) EXCLUSIVE_COUNT_IN_USE,
    ORDER_BY
  FROM
  ( SELECT
      H.SNAPSHOT_TIME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')      != 0 THEN H.HOST             ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)           END HOST,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')      != 0 THEN TO_VARCHAR(H.PORT) ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)           END PORT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALLOCATOR') != 0 THEN H.ALLOCATOR_NAME   ELSE MAP(BI.ALLOCATOR_NAME, '%', 'any', BI.ALLOCATOR_NAME) END ALLOCATOR_NAME,
      SUM(H.EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
      SUM(H.EXCLUSIVE_COUNT_IN_USE) EXCLUSIVE_COUNT_IN_USE,
      BI.AGGREGATE_BY,
      BI.TIME_AGGREGATE_BY,
      BI.TIMEZONE,
      BI.ORDER_BY
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
        HOST,
        PORT,
        ALLOCATOR_NAME,
        DATA_SOURCE,
        AGGREGATE_BY,
        MAP(TIME_AGGREGATE_BY,
          'NONE',        'YYYY/MM/DD HH24:MI:SS',
          'HOUR',        'YYYY/MM/DD HH24',
          'DAY',         'YYYY/MM/DD (DY)',
          'HOUR_OF_DAY', 'HH24',
          TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
        ORDER_BY
      FROM
      ( SELECT                                                      /* Modification section */
          'MIN' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
          'MAX' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
          'SERVER' TIMEZONE,                              /* SERVER, UTC */
          '%' HOST,
          '%40' PORT,
          'Pool/PersistenceManager/MidSizeLOBContainerFileIDMapping/Map' ALLOCATOR_NAME,                   /* Name of table or heap area */
          'HISTORY' DATA_SOURCE,
          'NONE' AGGREGATE_BY,        /* TIME, HOST, PORT, ALLOCATOR or comma separated combinations, NONE for no aggregation */
          'DAY' TIME_AGGREGATE_BY,       /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
          'TIME' ORDER_BY                /* TIME, ALLOCATOR, TOTAL_SIZE, AVERAGE_SIZE, COUNT */
        FROM
          DUMMY
      )
    ) BI,
    ( SELECT
        'CURRENT' DATA_SOURCE,
        CURRENT_TIMESTAMP SNAPSHOT_TIME,
        HOST,
        PORT,
        CATEGORY ALLOCATOR_NAME,
        SUM(EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
        SUM(EXCLUSIVE_COUNT_IN_USE) EXCLUSIVE_COUNT_IN_USE
      FROM
        M_HEAP_MEMORY
      GROUP BY
        HOST,
        PORT,
        CATEGORY
      UNION ALL
      SELECT
        'HISTORY' DATA_SOURCE,
        SERVER_TIMESTAMP SNAPSHOT_TIME,
        HOST,
        PORT,
        CATEGORY ALLOCATOR_NAME,
        SUM(EXCLUSIVE_SIZE_IN_USE) EXCLUSIVE_SIZE_IN_USE,
        SUM(EXCLUSIVE_COUNT_IN_USE) EXCLUSIVE_COUNT_IN_USE
      FROM
        _SYS_STATISTICS.HOST_HEAP_ALLOCATORS
      GROUP BY
        SERVER_TIMESTAMP,
        HOST,
        PORT,
        CATEGORY
    ) H
    WHERE
      H.DATA_SOURCE = BI.DATA_SOURCE AND
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.SNAPSHOT_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
      H.HOST LIKE BI.HOST AND
      TO_VARCHAR(H.PORT) LIKE BI.PORT AND
      H.ALLOCATOR_NAME LIKE BI.ALLOCATOR_NAME
    GROUP BY
      SNAPSHOT_TIME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')      != 0 THEN H.HOST             ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)           END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')      != 0 THEN TO_VARCHAR(H.PORT) ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)           END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALLOCATOR') != 0 THEN H.ALLOCATOR_NAME   ELSE MAP(BI.ALLOCATOR_NAME, '%', 'any', BI.ALLOCATOR_NAME) END,
      BI.AGGREGATE_BY,
      BI.TIME_AGGREGATE_BY,
      BI.TIMEZONE,
      BI.ORDER_BY
  )
  GROUP BY
    CASE 
      WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE SNAPSHOT_TIME END) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(SNAPSHOT_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE SNAPSHOT_TIME END, TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    HOST,
    PORT,
    ALLOCATOR_NAME,
    ORDER_BY
)
ORDER BY
  MAP(ORDER_BY, 'TIME', SNAPSHOT_TIME) DESC,
  MAP(ORDER_BY, 'ALLOCATOR', ALLOCATOR_NAME || HOST || PORT ),
  MAP(ORDER_BY, 'TOTAL_SIZE', EXCLUSIVE_SIZE_IN_USE, 'AVERAGE_SIZE', MAP(EXCLUSIVE_COUNT_IN_USE, 0, 0, EXCLUSIVE_SIZE_IN_USE / EXCLUSIVE_COUNT_IN_USE), 'COUNT', EXCLUSIVE_COUNT_IN_USE) DESC,
  SNAPSHOT_TIME DESC

