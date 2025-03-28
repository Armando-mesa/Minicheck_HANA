SELECT

/* 

[NAME]

- HANA_MDS_StatementStatistics_1.00.122.16+

[DESCRIPTION]

- Overview of MDS database requests

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- See SAP Note 2670064 for more details related to multi-dimensional services (MDS).
- M_MULTIDIMENSIONAL_STATEMENT_STATISTICS available with SAP HANA >= 1.00.122.16 and >= 2.00.024.01
- In order to collect memory information the following parameter needs to be set:

  indexserver.ini -> [mds] -> per_request_memory_usage_estimation = true

- Running this command with SAP HANA 2.0 Revisions before 2.00.024.01 will fail with:

  Could not find table/view M_MULTIDIMENSIONAL_STATEMENT_STATISTICS

- CALCVIEW_NAME is not properly considered in case of BATCH requests with several data sources
- BEGIN_TIME and END_TIME are used for the LAST_EXECUTION_TIMESTAMP, so it is not a normal time history.
- Accessing M_MULTIDIMENSIONAL_STATEMENT_STATISTICS can result in MDS requests being blocked by the 
  mds_StatisticsOwnerLock mutex (bug 318816).

[VALID FOR]

- Revisions:              >= 1.00.122.16

[SQL COMMAND VERSION]

- 2018/11/03:  1.0 (initial version)
- 2020/08/15:  1.1 (CALCVIEW_NAME added)
- 2024/01/07:  1.2 (LAST_EXECUTION_TIMESTAMP and LAST_EXECUTION_STATUS added)
- 2024/01/08:  1.3 (MIN_EXECUTIONS, MIN_TOT_TIME_S, MIN_AVG_TIME_MS, MIN_MAX_THREADS and MIN_MAX_MEM_MB filters added)

[INVOLVED TABLES]

- M_MULTIDIMENSIONAL_STATEMENT_STATISTICS

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

- STATEMENT_STRING

  Statement string text

  '%SupportsEncodedResultSet%' --> Statement strings including "SupportsEncodedResultSet"
  '%'                          --> No restriction related to statement string

- STATEMENT_HASH      
 
  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction

- DB_USER

  Database user

  'SYSTEM'        --> Database user 'SYSTEM'
  '%'             --> No database user restriction

- APP_USER

  Application user

  'SAPSYS'        --> Application user 'SAPSYS'
  '%'             --> No application user restriction

- APP_NAME

  Name of application

  'ABAP:C11'      --> Application name 'ABAP:C11'
  '%'             --> No application name restriction

- STATEMENT_TYPE

  'INA'           --> Statements with type INA
  '%'             --> No restriction related to statement type

- CALCIEW_NAME

  Name of underlying calculation view

  '%FIN%'         --> Calculation views with names containing 'FIN'
  '%'             --> No restriction related to calculation view name

- STATUS

  Status of last execution

  'RUNNING'       --> Only display entries with last execution status RUNNING
  'FINISHED'      --> Only display entries with last execution status FINISHED
  '%'             --> No restriction related to last execution status

- MIN_EXECUTIONS

  Minimum execution threshold

  20              --> Only display statements with at least 20 executions
  -1              --> No restriction related to the number of executions

- MIN_TOT_TIME_S

  Minimum threshold for total execution time (s)

  800             --> Only display statements with a total execution time of at least 800 seconds
  -1              --> No restriction related to the total execution time

- MIN_AVG_TIME_MS

  Minimum threshold for average execution time (ms)

  100             --> Only display statements with an average execution time of at least 100 ms
  -1              --> No restriction related to the average execution time

- MIN_MAX_THREADS

  Minimum threshold for maximum threads

  20              --> Only display statements with a maximum threads number of at least 20
  -1              --> No restriction related to maximum thread number

- MIN_MAX_MEM_MB

  Minimum threshold for maximum memory consumption (MB)

  50              --> Only display statements with a maximum memory consumption of 50 MB
  -1              --> No restriction related to maximum memory consumption

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'CALCVIEW'      --> Aggregation by calculation view
  'HOST, PORT'    --> Aggregation by host and port
  'NONE'          --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'TIME'          --> Sorting by time
  'DURATION'      --> Sorting by duration of execution
  
[OUTPUT PARAMETERS]

- HOST:                Host name
- PORT:                Port
- LAST_EXECUTION_TIME: Timestamp of last execution
- STATUS:              Last execution status
- STATEMENT_HASH:      Statement hash
- EXECUTIONS:          Number of executions
- TOT_TIME_S:          Total execution time (s)
- AVG_TIME_MS:         Average execution time (ms)
- METADATA_HITS:       Metadata cache hits
- DATA_HITS:           Data cache hits
- MAX_THREADS:         Maximum number of threads called
- MAX_MEM_MB:          Maximum amount of memory used (MB)
- CALCVIEW_NAME:       Name of underlying calculation view
- DB_USER:             Database user name
- APP_USER:            Application user name
- APP_NAME:            Application name
- TYPE:                Statement type
- STATEMENT_STRING:    Statement text

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|HOST     |PORT |STATEMENT_HASH                  |EXECUTIONS|TOT_TIME_S|AVG_TIME_MS|METADATA_HITS|DATA_HITS|MAX_THREADS|MAX_MEM_MB|DB_USER |APP_USER|APP_NAME             |STATEMENT_TYPE|STATEMENT_STRING                                                                                                                                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|saphana01|30003|ef003965cbe4bc4642fc192f8efdd6c8|         2|     51.04|   25521.50|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|edbd630dbdc19d0c871ae01dcc342ebb|         1|     36.26|   36260.00|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|d6c2cf75aa203ed288d91945d91f7088|         1|     35.67|   35676.00|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|5259f70b537b51663555481c4c76f843|         1|     33.21|   33212.00|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|e72f7c0d9b7d61819b1cde0a7b6cd821|         2|     25.83|   12917.50|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|a8bd31ad453a30a8f226492692ab3fdc|         1|     25.46|   25467.00|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","SupportsEncodedResultSet2","ReturnResultSetSizeWhenResultSetExceeded","SupportsSetOperand","ResultSetCellMeasure","HierarchyNavigationDeltaMode","ResultSetHiera...|
|saphana01|30003|7c6e03d1c9de2daf739da47d0eb07d90|        28|     18.44|     658.75|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","UniqueAttributeNames","HierarchyDataAndExcludingFilters","HierarchyTrapezoidFilter"],"DataSource":{"InstanceId":"A8EBBB28B46EE94CBC0DE40C82B7738A","ObjectName":...|
|saphana01|30003|097add2a6f5b2fa92f36307009cdb64b|        12|     18.11|    1509.25|            0|        0|          0|      0.00|SAPMDS01|SAPMDS01|sap.bc.ina.service.v2|INA           |{"Analytics":{"Capabilities":["SP9","UniqueAttributeNames","HierarchyDataAndExcludingFilters","HierarchyTrapezoidFilter"],"DataSource":{"InstanceId":"2851FD5F3125CA449E43457FB256D8A7","ObjectName":...|
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  HOST,
  LPAD(PORT, 5) PORT,
  LAST_EXECUTION_TIME,
  STATUS,
  STATEMENT_HASH,
  LPAD(EXECUTIONS, 10) EXECUTIONS,
  LPAD(TO_DECIMAL(TOT_TIME_S, 10, 2), 10) TOT_TIME_S,
  LPAD(TO_DECIMAL(AVG_TIME_MS, 10, 2), 11) AVG_TIME_MS,
  LPAD(METADATA_HITS, 13) METADATA_HITS,
  LPAD(DATA_HITS, 9) DATA_HITS,
  LPAD(MAX_THREADS, 11) MAX_THREADS,
  LPAD(TO_DECIMAL(MAX_MEM_MB, 10, 2), 10) MAX_MEM_MB,
  CALCVIEW_NAME,
  DB_USER,
  APP_USER,
  APP_NAME,
  STATEMENT_TYPE TYPE,
  STATEMENT_STRING
FROM
( SELECT
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME')     != 0 THEN TO_VARCHAR(MS.LAST_EXECUTION_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') ELSE 'any'                    END LAST_EXECUTION_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')     != 0 THEN MS.HOST                         ELSE MAP(BI.HOST,             '%', 'any', BI.HOST)             END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')     != 0 THEN TO_VARCHAR(MS.PORT)             ELSE MAP(BI.PORT,             '%', 'any', BI.PORT)             END PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')     != 0 THEN TO_VARCHAR(MS.STATEMENT_STRING) ELSE MAP(BI.STATEMENT_STRING, '%', 'any', BI.STATEMENT_STRING) END STATEMENT_STRING,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')     != 0 THEN MS.STATEMENT_HASH               ELSE MAP(BI.STATEMENT_HASH,   '%', 'any', BI.STATEMENT_HASH)   END STATEMENT_HASH,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')  != 0 THEN MS.USER_NAME                    ELSE MAP(BI.DB_USER,          '%', 'any', BI.DB_USER)          END DB_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER') != 0 THEN MS.APPLICATION_USER_NAME        ELSE MAP(BI.APP_USER,         '%', 'any', BI.APP_USER)         END APP_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME') != 0 THEN MS.APPLICATION_NAME             ELSE MAP(BI.APP_NAME,         '%', 'any', BI.APP_NAME)         END APP_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TYPE')     != 0 THEN MS.STATEMENT_TYPE               ELSE MAP(BI.STATEMENT_TYPE,   '%', 'any', BI.STATEMENT_TYPE)   END STATEMENT_TYPE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALCVIEW') != 0 THEN MS.CALCVIEW_NAME                ELSE MAP(BI.CALCVIEW_NAME,    '%', 'any', BI.CALCVIEW_NAME)    END CALCVIEW_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATUS')   != 0 THEN MS.LAST_EXECUTION_STATUS        ELSE MAP(BI.STATUS,           '%', 'any', BI.STATUS)           END STATUS,
    SUM(MS.EXECUTION_COUNT) EXECUTIONS,
    SUM(MS.TOTAL_EXECUTION_TIME) / 1000 TOT_TIME_S,
    MAP(SUM(MS.EXECUTION_COUNT), 0, 0, SUM(MS.TOTAL_EXECUTION_TIME) / SUM(MS.EXECUTION_COUNT)) AVG_TIME_MS,
    SUM(MS.TOTAL_METADATA_CACHE_HIT_COUNT) METADATA_HITS,
    SUM(MS.TOTAL_DATA_CACHE_HIT_COUNT) DATA_HITS,
    MAX(MS.MAX_CALLED_THREAD_COUNT) MAX_THREADS,
    MAX(MS.MAX_EXECUTION_MEMORY_SIZE) / 1024 / 1024 MAX_MEM_MB,
    BI.MIN_EXECUTIONS,
    BI.MIN_TOT_TIME_S,
    BI.MIN_AVG_TIME_MS,
    BI.MIN_MAX_THREADS,
    BI.MIN_MAX_MEM_MB,
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
      STATEMENT_STRING,
      STATEMENT_HASH,
      DB_USER,
      APP_USER,
      APP_NAME,
      STATEMENT_TYPE,
      CALCVIEW_NAME,
      STATUS,
      MIN_EXECUTIONS,
      MIN_TOT_TIME_S,
      MIN_AVG_TIME_MS,
      MIN_MAX_THREADS,
      MIN_MAX_MEM_MB,
      AGGREGATE_BY,
      ORDER_BY
    FROM
    ( SELECT                /* Modification section */
        'C-D1' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        'C'  END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        'SERVER' TIMEZONE,                              /* SERVER, UTC */
        '%' HOST,
        '%' PORT,
        '%' STATEMENT_STRING,
        '%' STATEMENT_HASH,
        '%' DB_USER,
        '%' APP_USER,
        '%' APP_NAME,
        '%' STATEMENT_TYPE,
        '%' CALCVIEW_NAME,
        '%' STATUS,
        -1 MIN_EXECUTIONS,
        -1 MIN_TOT_TIME_S,
        -1 MIN_AVG_TIME_MS,
        -1 MIN_MAX_THREADS,
        -1 MIN_MAX_MEM_MB,
        'NONE' AGGREGATE_BY,               /* HOST, PORT, HASH, DB_USER, APP_USER, APP_NAME, TYPE, CALCVIEW, STATUS, TIME or comma separated combinations, NONE for no aggregation */
        'DURATION' ORDER_BY                    /* EXECUTIONS, DURATION, THREADS, MEMORY, TIME */
      FROM
        DUMMY
    )
  ) BI,
  ( SELECT
      *,
      IFNULL(CASE
        WHEN JSON_VALUE(STATEMENT_STRING, '$.*.DataSource.ObjectName') LIKE '%::%' THEN JSON_VALUE(STATEMENT_STRING, '$.*.DataSource.ObjectName')
        ELSE JSON_VALUE(STATEMENT_STRING, '$.*.DataSource.PackageName') || '/' || JSON_VALUE(STATEMENT_STRING, '$.*.DataSource.ObjectName')
      END, '') CALCVIEW_NAME
    FROM
      M_MULTIDIMENSIONAL_STATEMENT_STATISTICS
  ) MS
  WHERE
    MS.HOST LIKE BI.HOST AND
    TO_VARCHAR(MS.PORT) LIKE BI.PORT AND
    CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(MS.LAST_EXECUTION_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE MS.LAST_EXECUTION_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    TO_VARCHAR(MS.STATEMENT_STRING) LIKE BI.STATEMENT_STRING AND
    MS.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
    MS.USER_NAME LIKE BI.DB_USER AND
    MS.APPLICATION_NAME LIKE BI.APP_NAME AND
    MS.STATEMENT_TYPE LIKE BI.STATEMENT_TYPE AND
    MS.APPLICATION_USER_NAME LIKE BI.APP_USER AND
    MS.CALCVIEW_NAME LIKE BI.CALCVIEW_NAME AND
    MS.LAST_EXECUTION_STATUS LIKE BI.STATUS
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME')     != 0 THEN TO_VARCHAR(MS.LAST_EXECUTION_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') ELSE 'any'                    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')     != 0 THEN MS.HOST                         ELSE MAP(BI.HOST,             '%', 'any', BI.HOST)             END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')     != 0 THEN TO_VARCHAR(MS.PORT)             ELSE MAP(BI.PORT,             '%', 'any', BI.PORT)             END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')     != 0 THEN TO_VARCHAR(MS.STATEMENT_STRING) ELSE MAP(BI.STATEMENT_STRING, '%', 'any', BI.STATEMENT_STRING) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')     != 0 THEN MS.STATEMENT_HASH               ELSE MAP(BI.STATEMENT_HASH,   '%', 'any', BI.STATEMENT_HASH)   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')  != 0 THEN MS.USER_NAME                    ELSE MAP(BI.DB_USER,          '%', 'any', BI.DB_USER)          END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER') != 0 THEN MS.APPLICATION_USER_NAME        ELSE MAP(BI.APP_USER,         '%', 'any', BI.APP_USER)         END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME') != 0 THEN MS.APPLICATION_NAME             ELSE MAP(BI.APP_NAME,         '%', 'any', BI.APP_NAME)         END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TYPE')     != 0 THEN MS.STATEMENT_TYPE               ELSE MAP(BI.STATEMENT_TYPE,   '%', 'any', BI.STATEMENT_TYPE)   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALCVIEW') != 0 THEN MS.CALCVIEW_NAME                ELSE MAP(BI.CALCVIEW_NAME,    '%', 'any', BI.CALCVIEW_NAME)    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATUS')   != 0 THEN MS.LAST_EXECUTION_STATUS        ELSE MAP(BI.STATUS,           '%', 'any', BI.STATUS)           END,
    BI.MIN_EXECUTIONS,
    BI.MIN_TOT_TIME_S,
    BI.MIN_AVG_TIME_MS,
    BI.MIN_MAX_THREADS,
    BI.MIN_MAX_MEM_MB,
    BI.ORDER_BY
)
WHERE
  ( MIN_EXECUTIONS = -1 OR EXECUTIONS >= MIN_EXECUTIONS ) AND
  ( MIN_TOT_TIME_S = -1 OR TOT_TIME_S >= MIN_TOT_TIME_S ) AND
  ( MIN_AVG_TIME_MS = -1 OR AVG_TIME_MS >= MIN_AVG_TIME_MS ) AND
  ( MIN_MAX_THREADS = -1 OR MAX_THREADS >= MIN_MAX_THREADS ) AND
  ( MIN_MAX_MEM_MB = -1 OR MAX_MEM_MB >= MIN_MAX_MEM_MB )  
ORDER BY
  MAP(ORDER_BY, 'EXECUTIONS', EXECUTIONS, 'DURATION', TOT_TIME_S, 'TIME', LAST_EXECUTION_TIME, 'THREADS', MAX_THREADS, 'MEMORY', MAX_MEM_MB) DESC