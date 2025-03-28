SELECT

/* 

[NAME]

- HANA_ABAP_Texts

[DESCRIPTION]

- ABAP texts (SAPscript and others)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Tables STXH and STXL only available in SAP ABAP environments
- You have to be connected to the SAP<sid> schema otherwise the following error is issued:

  [259]: invalid table name: Could not find table/view STXH in schema

- If access to ABAP objects is possible but you cannot log on as ABAP user, you can switch the default schema before executing the command:

  SET SCHEMA SAP<sid>

[VALID FOR]

- Revisions:              all
- Client application:     ABAP

[SQL COMMAND VERSION]

- 2023/12/03:  1.0 (initial version)

[INVOLVED TABLES]

- STXH
- STXL

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

- MANDT

  ABAP client

  '100'          --> Client 100
  '%'            --> No restriction related to client

- TDOBJECT

  Application object

  'VBPP'         --> Application object VBPP
  '%'            --> No restriction related to application object

- TDNAME

  Detailed object name

  '0052893648000010' --> Detailed object name 0052893648000010
  '%'                --> No restriction related to detailed object name

- TDID

  Text ID

  '9000'         --> Text ID 9000
  '%'            --> No restriction related to text ID

- TDSPRAS

  Language key

  'E'            --> Language key 'E' (English)
  '%'            --> No restriction related to language key

- USER

  Last change user

  'WF-BATCH'     --> Last change user WF-BATCH
  '%'            --> No restriction related to last change user

- MIN_TOTAL_SIZE_GB

  Minimum threshold for total size (GB)

  5              --> Only display result lines with at CLUSTD_GB >= 5 GB
  -1             --> No restriction related to total size

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'TIME'            --> Aggregation by time
  'MANDT, TDOBJECT' --> Aggregation by MANDT and TDOBJECT
  'NONE'            --> No aggregation

- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'SIZE'          --> Sorting by size 
  'TIME'          --> Sorting by time

[OUTPUT PARAMETERS]

- CHANGE_TIME:   Change time
- MANDT:         Client
- TDOBJECT:      Application object
- TDNAME:        Detailed object name
- TDID:          Text ID
- TDSPRAS:       Language key
- USER:          Last change user name
- COUNT:         Number of records
- CLUSTD_GB:     Total siez of CLUSTD column (GB)
- AVG_CLUSTD_KB: Average size of CLUSTD column (KB)

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|START_TIME      |HOST     |SERVICE_NAME|SAVEPOINTS|SUM_DURATION_S|MAX_DURATION_S|AVG_DURATION_S|MAX_CRITICAL_PHASE_S|AVG_CRITICAL_PHASE_S|SUM_SIZE_MB|AVG_SIZE_MB|RS_SIZE_PCT|
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|2014/05/26 (MON)|saphana20|indexserver |        45|       5918.08|        626.11|        131.51|                3.93|                2.01|     861705|      19149|       6.86|
|2014/05/25 (SUN)|saphana20|indexserver |       230|      21724.41|       2595.69|         94.45|                4.69|                2.34|    2835199|      12327|       7.28|
|2014/05/24 (SAT)|saphana20|indexserver |       186|      20134.43|       1643.51|        108.24|                3.85|                2.25|    2838311|      15260|       6.89|
|2014/05/23 (FRI)|saphana20|indexserver |       111|      17556.60|       2613.64|        158.16|                7.32|                2.36|    2406131|      21677|       9.55|
|2014/05/22 (THU)|saphana20|indexserver |       318|      19547.89|       3164.87|         61.47|                7.44|                3.58|    2122936|       6676|       8.37|
|2014/05/21 (WED)|saphana20|indexserver |       290|      31459.90|      10009.32|        108.48|                8.40|                4.31|    3318363|      11443|       8.94|
|2014/05/20 (TUE)|saphana20|indexserver |       313|      26608.99|       3240.07|         85.01|                9.15|                4.25|    2630053|       8403|       8.11|
|2014/05/19 (MON)|saphana20|indexserver |       303|      29189.67|      10650.05|         96.33|                8.26|                4.51|    3445940|      11373|       7.24|
|2014/05/18 (SUN)|saphana20|indexserver |        25|        924.44|        131.38|         36.97|                2.90|                2.32|      94909|       3796|       6.00|
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  CHANGE_TIME,
  MANDT,
  TDOBJECT,
  TDNAME,
  TDID,
  TDSPRAS,
  USER,
  LPAD(CNT, 9) "COUNT",
  LPAD(TO_DECIMAL(CLUSTD_GB, 10, 2), 9) CLUSTD_GB,
  LPAD(TO_DECIMAL(CLUSTD_GB / CNT * 1024 * 1024, 10, 2), 13) AVG_CLUSTD_KB
FROM
( SELECT
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), H.CHANGE_TIME) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(H.CHANGE_TIME, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END CHANGE_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MANDT')    != 0 THEN H.MANDT    ELSE MAP(BI.MANDT,    '%', 'any', BI.MANDT)    END MANDT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDOBJECT') != 0 THEN H.TDOBJECT ELSE MAP(BI.TDOBJECT, '%', 'any', BI.TDOBJECT) END TDOBJECT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDNAME')   != 0 THEN H.TDNAME   ELSE MAP(BI.TDNAME,   '%', 'any', BI.TDNAME)   END TDNAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDID')     != 0 THEN H.TDID     ELSE MAP(BI.TDID,     '%', 'any', BI.TDID)     END TDID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDSPRAS')  != 0 THEN H.TDSPRAS  ELSE MAP(BI.TDSPRAS,  '%', 'any', BI.TDSPRAS)  END TDSPRAS,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'USER')     != 0 THEN H.TDLUSER  ELSE MAP(BI.USER,     '%', 'any', BI.USER)     END USER,
    COUNT(*) CNT,
    SUM(LENGTH(L.CLUSTD) / 1024 / 1024 / 1024) CLUSTD_GB,
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
      MANDT,
      TDOBJECT,
      TDNAME,
      TDID,
      TDSPRAS,
      USER,
      MIN_TOTAL_SIZE_GB,
      AGGREGATE_BY,
      MAP(TIME_AGGREGATE_BY,
        'NONE',        'YYYY/MM/DD HH24:MI:SS',
        'HOUR',        'YYYY/MM/DD HH24',
        'DAY',         'YYYY/MM/DD (DY)',
        'HOUR_OF_DAY', 'HH24',
        TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
      ORDER_BY
    FROM
    ( SELECT                /* Modification section */
        '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        '%' MANDT,
        '%' TDOBJECT,
        '%' TDNAME,
        '%' TDID,
        '%' TDSPRAS,
        '%' USER,
        1 MIN_TOTAL_SIZE_GB,
        'MANDT, TDOBJECT, TDSPRAS, USER' AGGREGATE_BY,         /* TIME, MANDT, TDOBJECT, TDNAME, TDID, TDSPRAS, USER or comma separated combinations, NONE for no aggregation */
        'NONE' TIME_AGGREGATE_BY,     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
        'TIME' ORDER_BY             /* TIME, COUNT, SIZE, NAME */
      FROM
        DUMMY
    )
  ) BI,
  ( SELECT
      TO_TIMESTAMP(GREATEST(TDLDATE, '19000101') || TDLTIME, 'YYYYMMDDHH24MISS') CHANGE_TIME,
      *
    FROM
      STXH 
  ) H,
    STXL L
  WHERE
    H.MANDT LIKE BI.MANDT AND
    H.TDOBJECT LIKE BI.TDOBJECT AND
    H.TDNAME LIKE BI.TDNAME AND
    H.TDID LIKE BI.TDID AND
    H.TDSPRAS LIKE BI.TDSPRAS AND
    H.CHANGE_TIME BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    H.MANDT = L.MANDT AND
    H.TDOBJECT = L.TDOBJECT AND
    H.TDNAME = L.TDNAME AND
    H.TDID = L.TDID AND
    H.TDSPRAS = L.TDSPRAS
  GROUP BY
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), H.CHANGE_TIME) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(H.CHANGE_TIME, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MANDT')    != 0 THEN H.MANDT    ELSE MAP(BI.MANDT,    '%', 'any', BI.MANDT)    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDOBJECT') != 0 THEN H.TDOBJECT ELSE MAP(BI.TDOBJECT, '%', 'any', BI.TDOBJECT) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDNAME')   != 0 THEN H.TDNAME   ELSE MAP(BI.TDNAME,   '%', 'any', BI.TDNAME)   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDID')     != 0 THEN H.TDID     ELSE MAP(BI.TDID,     '%', 'any', BI.TDID)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TDSPRAS')  != 0 THEN H.TDSPRAS  ELSE MAP(BI.TDSPRAS,  '%', 'any', BI.TDSPRAS)  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'USER')     != 0 THEN H.TDLUSER  ELSE MAP(BI.USER,     '%', 'any', BI.USER)     END,
    BI.ORDER_BY,
    BI.MIN_TOTAL_SIZE_GB
  HAVING
  ( BI.MIN_TOTAL_SIZE_GB = -1 OR SUM(LENGTH(L.CLUSTD) / 1024 / 1024 / 1024) >= BI.MIN_TOTAL_SIZE_GB )
)
ORDER BY
  MAP(ORDER_BY, 'TIME', CHANGE_TIME) DESC,
  MAP(ORDER_BY, 'COUNT', CNT, 'SIZE', CLUSTD_GB) DESC,
  MAP(ORDER_BY, 'NAME', MANDT || TDOBJECT || TDNAME)
