SELECT

/* 

[NAME]

- HANA_Startup_StepDurations_2.00.060+

[DESCRIPTION]

- Durations of steps during service startup (and maintenance / shutdown)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_SERVICE_COMPONENT_DETAILS and M_SERVICE_COMPONENT_HISTORY available with SAP HANA >= 2.00.060

[VALID FOR]

- Revisions:              >= 2.00.060

[SQL COMMAND VERSION]

- 2023/07/08:  1.0 (initial version)
- 2023/10/28:  1.1 (SERVICE_NAME included)

[INVOLVED TABLES]

- M_SERVICE_COMPONENT_DETAILS
- M_SERVICE_COMPONENT_HISTORY

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

- SERVICE_NAME

  Service name

  'indexserver'   --> Specific service indexserver
  '%server'       --> All services ending with 'server'
  '%'             --> All services  

- PHASE

  Lifecycle phase

  'ASSIGN'        --> Lifecycle phase ASSIGN
  'STOP%'         --> Lifecycle phases starting with STOP
  '%'             --> No restriction related to lifecycle phase

- COMPONENT

  Service component

  'Row Store'     --> Service component "Row Store"
  'Data Access'   --> Service component "Data Access"
  '%'             --> No restriction related to service component

- ACTION

  Service component action

  'loadFileIDMapping' --> Service component action loadFileIDMapping
  'load%'             --> Service component action starting with load
  '%'                 --> No restriction related to service component action

- MIN_DURATION_S

  Lower limit for action duration (s)

  10              --> Only display actions taking at least 10 seconds
  -1              --> No restriction related to duration of action

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)
  '%'             --> All data sources

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'TIME'          --> Sorting by start time
  'DURATION'      --> Sorting by action duration

[OUTPUT PARAMETERS]

- START_TIME:   Start time 
- DURATION_S:   Step duration
- HOST:         Host
- PORT:         Port
- SERVICE_NAME: Service name
- PHASE:        Lifecycle phase
- COMPONENT:    Service component
- ACTION:       Service component action

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------
|START_TIME            |DURATION_S|HOST     |PORT |PHASE|COMPONENT  |ACTION                              |
----------------------------------------------------------------------------------------------------------
|2023/06/25 19:32:36.21|      0.00|saphana01|30003|     |Crypto     |ClientPKI: Cleanup Host certificates|
|2023/06/25 17:01:04.45|      0.01|saphana01|30003|     |Data Access|startConverters                     |
|2023/06/25 17:00:57.25|      0.00|saphana01|30003|     |Row Store  |RS uncommitted version construction |
|2023/06/25 17:00:55.40|      0.00|saphana01|30003|     |Row Store  |RS Undo log collection              |
|2023/06/25 16:59:57.67|      1.76|saphana01|30003|     |Data Access|loadRestartSessionList              |
|2023/06/25 16:59:35.34|      0.20|saphana01|30003|     |Data Access|initVirtualFileStatistics           |
|2023/06/25 16:59:35.34|     22.29|saphana01|30003|     |Data Access|initVirtualFileLOBStatistics        |
|2023/06/25 16:59:35.33|      0.01|saphana01|30003|     |Data Access|initMidSizeLOBStatistics            |
|2023/06/25 16:59:35.33|     11.84|saphana01|30003|     |Data Access|loadContainerNameDirectory          |
|2023/06/25 16:59:02.44|     31.38|saphana01|30003|     |Data Access|loadLOBFileIDMapping                |
|2023/06/25 16:58:57.26|      5.17|saphana01|30003|     |Data Access|loadFileIDMapping                   |
|2023/06/25 16:58:52.47|     42.85|saphana01|30003|     |Data Access|loadMappings                        |
|2023/06/25 16:58:52.30|     43.02|saphana01|30003|     |Data Access|loadContainerDirectories            |
|2023/06/25 16:58:35.85|      0.00|saphana01|30003|     |Data Access|loadStaticConverter                 |
|2023/06/25 16:58:35.85|      0.69|saphana01|30003|     |Data Access|loadAbsConverter                    |
|2023/06/25 16:58:35.85|      0.00|saphana01|30003|     |Data Access|loadDiskRowStoreConverter           |
|2023/06/25 16:58:35.85|     16.45|saphana01|30003|     |Data Access|loadDefaultConverter                |
|2023/06/25 16:58:35.84|     16.46|saphana01|30003|     |Data Access|loadConverters                      |
|2023/06/25 16:58:35.84|      0.00|saphana01|30003|     |Data Access|markSnapshotFBM                     |
----------------------------------------------------------------------------------------------------------

*/

  TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(S.START_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE S.START_TIMESTAMP END, 'YYYY/MM/DD HH24:MI:SS.FF2') START_TIME,
  LPAD(TO_DECIMAL(S.DURATION_S, 10, 2), 10) DURATION_S,
  S.HOST,
  LPAD(S.PORT, 5) PORT,
  S.SERVICE_NAME,
  S.PHASE,
  S.COMPONENT,
  S.ACTION
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
    SERVICE_NAME,
    PHASE,
    COMPONENT,
    ACTION,
    MIN_DURATION_S,
    DATA_SOURCE,
    ORDER_BY
  FROM
  ( SELECT            /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' HOST,
      '%' PORT,
      '%' SERVICE_NAME,
      '%' PHASE,
      '%' COMPONENT,
      '%' ACTION,
      -1 MIN_DURATION_S,
      'CURRENT' DATA_SOURCE,            /* CURRENT, HISTORY */
      'TIME' ORDER_BY              /* TIME, DURATION */
    FROM
      DUMMY
  ) 
) BI,
( SELECT
    'CURRENT' DATA_SOURCE,
    START_TIMESTAMP,
    HOST,
    TO_VARCHAR(PORT) PORT,
    SERVICE_NAME,
    '' PHASE,
    SERVICE_COMPONENT COMPONENT,
    SERVICE_COMPONENT_ACTION ACTION,
    PROGRESS_DETAILS,
    DURATION / 1000000 DURATION_S
  FROM
    M_SERVICE_COMPONENT_DETAILS
  UNION
  SELECT
    'HISTORY' DATA_SOURCE,
    START_TIMESTAMP,
    HOST,
    TO_VARCHAR(PORT) PORT,
    SERVICE_NAME,
    LIFECYCLE_PHASE PHASE,
    SERVICE_COMPONENT COMPONENT,
    SERVICE_COMPONENT_ACTION ACTION,
    PROGRESS_DETAILS,
    DURATION / 1000000 DURATION_S
  FROM
    M_SERVICE_COMPONENT_HISTORY
) S
WHERE
  CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(S.START_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE S.START_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
  S.HOST LIKE BI.HOST AND
  S.PORT LIKE BI.PORT AND
  S.SERVICE_NAME LIKE BI.SERVICE_NAME AND
  S.DATA_SOURCE LIKE BI.DATA_SOURCE AND
  S.PHASE LIKE BI.PHASE AND
  S.COMPONENT LIKE BI.COMPONENT AND
  S.ACTION LIKE BI.ACTION AND
  ( BI.MIN_DURATION_S = -1 OR S.DURATION_S >= BI.MIN_DURATION_S )
ORDER BY
  MAP(BI.ORDER_BY, 'TIME', S.START_TIMESTAMP) DESC,
  MAP(BI.ORDER_BY, 'DURATION', S.DURATION_S) DESC,
  S.START_TIMESTAMP DESC,
  S.DURATION_S DESC,
  S.HOST,
  S.PORT