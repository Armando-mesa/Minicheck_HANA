SELECT

/* 

[NAME]

- HANA_Locks_Internal_IndexHandle_2.00.070+

[DESCRIPTION]

- Index handle lock details

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Useful for index handle analysis (SAP Note 1999998, "Acquire Index Access")
- M_CS_TABLE_HANDLES and HOST_CS_TABLE_HANDLES available with SAP HANA >= 2.00.070

[VALID FOR]

- Revisions:              >= 2.00.070

[SQL COMMAND VERSION]

- 2024/03/27:  1.0 (initial version)

[INVOLVED TABLES]

- M_CS_TABLE_HANDLES
- HOST_CS_TABLE_HANDLES

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

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- TABLE_NAME           

  Table name or pattern

  'T000'          --> Specific table T000
  'T%'            --> All tables starting with 'T'
  '%'             --> All tables

- PART_ID

  Partition number

  2               --> Only show information for partition number 2
  -1              --> No restriction related to partition number

- INT_PART_ID

  Internal partition number

  2               --> Only show information for internal partition number 2
  -1              --> No restriction related to internal partition number

- THREAD_ID

  Thread identifier

  4567            --> Thread 4567
  -1              --> No thread identifier restriction

- CURRENT_STATE

  Current index handle state

  'merge_delta'   --> Show information for merge_delta activities
  '%'             --> No restriction related to index handle state

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

  'TIME'          --> Sorting by evaluation time
  'DURATION'      --> Sorting by index handle duration

[OUTPUT PARAMETERS]

- EVALUATION_TIME: Evaluation time
- ST:              System replication site ID
- HOST:            Host
- PORT:            Port
- CNT:             Number of index handle holders
- DURATION_S:      Index handle duration (s)
- SCHEMA_NAME:     Schema name
- TABLE_NAME:      Table name
- THREAD_ID:       Thread ID
- CURRENT_STATE:   Current index handle state (e.g. search_delta, write_delta, merge_delta, delete, free, finish_delta_merge, read_config)

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------------
|EVALUATION_TIME    |ST|DURATION_S |SCHEMA_NAME|TABLE_NAME                                       |THREAD_ID|CURRENT_STATE|
--------------------------------------------------------------------------------------------------------------------------
|2024/03/27 15:37:42| 1|       9.78|SAPABAP1   |#_SYS_QO_COL_L:8785_76c254d0af40:401800000e771e43|   155692|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |KNA1                                             |   142345|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |VBPA (2 / 2)                                     |   262270|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |VXSITDU                                          |   163166|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |ZBC00DT_GSF_XYZ                                  |   419855|write_delta  |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |BUT000                                           |   163731|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |USR02                                            |   306984|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |BUT000                                           |   163730|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |MAKT                                             |   262279|search_delta |
|2024/03/27 15:37:42| 1|       0.00|SAPABAP1   |KNA1                                             |   160469|search_delta |
--------------------------------------------------------------------------------------------------------------------------

*/

  EVALUATION_TIME,
  IFNULL(LPAD(SITE_ID, 2), '') ST,
  HOST,
  LPAD(PORT, 5) PORT,
  LPAD(CNT, 5) CNT,
  LPAD(TO_DECIMAL(DURATION_S, 10, 2), 11) DURATION_S,
  SCHEMA_NAME,
  TABLE_NAME,
  LPAD(THREAD_ID, 9) THREAD_ID,
  CURRENT_STATE
FROM
( SELECT
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.EVALUATION_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.EVALUATION_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.EVALUATION_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.EVALUATION_TIME END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END EVALUATION_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(H.SITE_ID)   ELSE MAP(BI.SITE_ID,        -1, 'any', TO_VARCHAR(BI.SITE_ID))   END SITE_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')    != 0 THEN H.HOST                  ELSE MAP(BI.HOST,          '%', 'any', BI.HOST)                  END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(H.PORT)      ELSE MAP(BI.PORT,          '%', 'any', BI.PORT)                  END PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SCHEMA')  != 0 THEN H.SCHEMA_NAME           ELSE MAP(BI.SCHEMA_NAME,   '%', 'any', BI.SCHEMA_NAME)           END SCHEMA_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')   != 0 THEN H.TABLE_NAME || MAP(H.PART_ID, 0, '', CHAR(32) || '(' || H.PART_ID || CHAR(32) || '/' || CHAR(32) || H.INT_PART_ID || ')')
                                                                                                              ELSE MAP(BI.TABLE_NAME,    '%', 'any', BI.TABLE_NAME)            END TABLE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD')  != 0 THEN TO_VARCHAR(H.THREAD_ID) ELSE MAP(BI.THREAD_ID,      -1, 'any', TO_VARCHAR(BI.THREAD_ID)) END THREAD_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATE')   != 0 THEN H.CURRENT_STATE         ELSE MAP(BI.CURRENT_STATE, '%', 'any', BI.CURRENT_STATE)         END CURRENT_STATE,
    COUNT(*) CNT,
    MAX(H.DURATION_S) DURATION_S,
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
      SITE_ID,
      HOST,
      PORT,
      SCHEMA_NAME,
      TABLE_NAME,
      PART_ID,
      INT_PART_ID, 
      THREAD_ID,
      CURRENT_STATE,
      MIN_DURATION_S,
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
    ( SELECT                  /* Modification section */
        '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        'SERVER' TIMEZONE,                              /* SERVER, UTC */
        -1 SITE_ID,
        '%' HOST,
        '%' PORT,
        '%' SCHEMA_NAME,
        '%' TABLE_NAME,
         -1 PART_ID,
         -1 INT_PART_ID,
         -1 THREAD_ID,
        '%' CURRENT_STATE,
        20 MIN_DURATION_S,
        'HISTORY' DATA_SOURCE,                        /* CURRENT, HISTORY */
        'NONE' AGGREGATE_BY,          /* TIME, SITE_ID, HOST, PORT, SCHEMA, TABLE, THREAD, STATE or comma separated combinations, NONE for no aggregation */
        'NONE' TIME_AGGREGATE_BY,     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
        'DURATION' ORDER_BY           /* TIME, DURATION, TABLE */
      FROM
        DUMMY
    )
  ) BI,
  ( SELECT
      'CURRENT' DATA_SOURCE,
      CURRENT_TIMESTAMP EVALUATION_TIME,
      ACQUIRE_TIME,
      GREATEST(0, NANO100_BETWEEN(ACQUIRE_TIME, CURRENT_TIMESTAMP)) / 10000000 DURATION_S,
      HOST,
      PORT,
      CURRENT_SITE_ID() SITE_ID,
      SCHEMA_NAME,
      TABLE_NAME,
      PART_ID,
      INTERNAL_PART_ID INT_PART_ID,
      THREAD_ID,
      CURRENT_STATE
    FROM
      M_CS_TABLE_HANDLES
    UNION
    SELECT
      'HISTORY' DATA_SOURCE,
      SERVER_TIMESTAMP EVALUATION_TIME,
      ACQUIRE_TIME,
      GREATEST(0, NANO100_BETWEEN(ACQUIRE_TIME, SERVER_TIMESTAMP)) / 10000000 DURATION_S,
      HOST,
      PORT,
      CURRENT_SITE_ID() SITE_ID,
      SCHEMA_NAME,
      TABLE_NAME,
      PART_ID,
      INTERNAL_PART_ID INT_PART_ID,
      THREAD_ID,
      CURRENT_STATE
    FROM
      _SYS_STATISTICS.HOST_CS_TABLE_HANDLES
  ) H
  WHERE
    ( BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND H.SITE_ID IN (-1, 0) ) OR H.SITE_ID = BI.SITE_ID ) AND
    H.HOST LIKE BI.HOST AND  
    TO_VARCHAR(H.PORT) LIKE BI.PORT AND
    CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.EVALUATION_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.EVALUATION_TIME END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    H.DATA_SOURCE = BI.DATA_SOURCE AND
    H.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    H.TABLE_NAME LIKE BI.TABLE_NAME AND
    ( BI.PART_ID = -1 OR H.PART_ID = BI.PART_ID ) AND
    ( BI.INT_PART_ID = -1 OR H.INT_PART_ID = BI.INT_PART_ID ) AND
    H.CURRENT_STATE LIKE BI.CURRENT_STATE AND
    ( BI.MIN_DURATION_S = -1 OR H.DURATION_S >= BI.MIN_DURATION_S )
  GROUP BY
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.EVALUATION_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.EVALUATION_TIME END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(H.EVALUATION_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE H.EVALUATION_TIME END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID') != 0 THEN TO_VARCHAR(H.SITE_ID)   ELSE MAP(BI.SITE_ID,        -1, 'any', TO_VARCHAR(BI.SITE_ID))   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')    != 0 THEN H.HOST                  ELSE MAP(BI.HOST,          '%', 'any', BI.HOST)                  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')    != 0 THEN TO_VARCHAR(H.PORT)      ELSE MAP(BI.PORT,          '%', 'any', BI.PORT)                  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SCHEMA')  != 0 THEN H.SCHEMA_NAME           ELSE MAP(BI.SCHEMA_NAME,   '%', 'any', BI.SCHEMA_NAME)           END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TABLE')   != 0 THEN H.TABLE_NAME || MAP(H.PART_ID, 0, '', CHAR(32) || '(' || H.PART_ID || CHAR(32) || '/' || CHAR(32) || H.INT_PART_ID || ')') 
                                                                                                              ELSE MAP(BI.TABLE_NAME,    '%', 'any', BI.TABLE_NAME)            END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD')  != 0 THEN TO_VARCHAR(H.THREAD_ID) ELSE MAP(BI.THREAD_ID,      -1, 'any', TO_VARCHAR(BI.THREAD_ID)) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'STATE')   != 0 THEN H.CURRENT_STATE         ELSE MAP(BI.CURRENT_STATE, '%', 'any', BI.CURRENT_STATE)         END,
    BI.ORDER_BY
)
ORDER BY
  MAP(ORDER_BY, 'DURATION', DURATION_S, 'TIME', EVALUATION_TIME) DESC,
  MAP(ORDER_BY, 'NAME', SCHEMA_NAME || TABLE_NAME),
  EVALUATION_TIME DESC,
  DURATION_S DESC

