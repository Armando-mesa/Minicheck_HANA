WITH

/*

[NAME]

- HANA_Tables_DataCollector_2.00.043+

[DESCRIPTION]

- Collection of details for a specific table

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_CS_LOADS.STATEMENT_HASH and ROOT_STATEMENT_HASH available starting with SAP HANA 2.00.040
- HOST_COLUMN_TABLES_PART_SIZE.PERSISTENT_MEMORY_SIZE_IN_TOTAL available with SAP HANA >= 2.00.043

[VALID FOR]

- Revisions:              >= 2.00.043

[SQL COMMAND VERSION]

- 2020/05/12:  1.0 (initial version)
- 2020/06/02:  1.1 (AUTO_MERGE / AUTO_OPTIMIZE_COMPRESSION included)
- 2021/01/25:  1.2 ("TRANSACTIONAL LOCK" included)
- 2021/02/02:  1.3 (M_CS_ALL_COLUMN_STATISTICS.SCANNED_RECORD_COUNT and M_RS_TABLES.SCAN_COUNT added)
- 2021/02/09:  1.4 (deprecated M_CS_PARTITIONS replaced with PARTITIONED_TABLES and TABLE_PARTITIONS, deprecated DATA_STATISTICS replaced with M_DATA_STATISTICS)
- 2022/08/21:  1.5 (M_EXECUTED_STATEMENTS included)
- 2023/11/25:  1.6 (LOAD_UNIT information included)

[INVOLVED TABLES]

- GLOBAL_TABLE_PERSISTENCE_STATISTICS
- HOST_COLUMN_TABLES_PART_SIZE
- HOST_DELTA_MERGE_STATISTICS
- HOST_SERVICE_THREAD_SAMPLES
- HOST_SQL_PLAN_CACHE
- INDEX_COLUMNS
- INDEXES
- M_CE_CALCSCENARIO_HINTS
- M_CE_CALCSCENARIOS_OVERVIEW
- M_CE_CALCVIEW_DEPENDENCIES
- M_CS_ALL_COLUMNS
- M_CS_LOADS
- M_CS_TABLES
- M_CS_UNLOADS
- M_DATA_STATISTICS
- M_EXECUTED_STATEMENTS
- M_JOIN_TRANSLATION_TABLES
- M_RECORD_LOCKS
- M_SQL_PLAN_CACHE
- M_TABLE_LOB_STATISTICS
- M_TABLE_REPLICAS
- M_TABLE_STATISTICS
- PARTITIONED_TABLES
- REFERENTIAL_CONSTRAINTS
- TABLE_COLUMNS
- TABLE_PARTITIONS
- TABLES
- TRIGGERS
- VIEWS
- VIRTUAL_TABLES 

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

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- TABLE_NAME           

  Table name (no pattern)

  'T000'          --> Specific table T000

- MAX_RESULT_LINES

  Maximum number of result lines for history sections

  20             --> Return a maximum of 20 lines in the output
  -1             --> No restriction related to result lines

- LINE_LENGTH

  Maximum length of output lines

  200            --> Limit output lines to a length of 200 characters
  -1             --> No limitation related to output line length

- SHOW_COMPLETE_BIND_VALUE_LIST

  Possibility to display the complete list of bind values

  'X'            --> Show all captured bind values
  ' '            --> Only show the first MAX_RESULT_LINES bind values

[OUTPUT PARAMETERS]

- LINE: Output information

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LINE                                                                                                                                                                                                    |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|*********************************                                                                                                                                                                       |
|* SAP HANA TABLE DATA COLLECTOR *                                                                                                                                                                       |
|*********************************                                                                                                                                                                       |
|                                                                                                                                                                                                        |
|Analysis time:  2020/05/14 12:44:38                                                                                                                                                                     |
|Generated with: SQL: "HANA_Tables_DataCollector" (SAP Note 1969700)                                                                                                                                     |
|Database name:  C11                                                                                                                                                                                     |
|Revision level: 2.00.046.00.1581325702                                                                                                                                                                  |
|Schema name:    SAPSR3                                                                                                                                                                                  |
|Table name:     /DMF/PRODT                                                                                                                                                                              |
|                                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
|*********************                                                                                                                                                                                   |
|* TABLE INFORMATION *                                                                                                                                                                                   |
|*********************                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
|SCHEMA_NAME TABLE_NAME        TYPE    PARTS     RECORDS MEM_TOTAL_GB MEM_DELTA_GB CURR_DISK_GB MIN_DISK_GB MAX_DISK_GB HOST                                                                             |
|=========== ================= ====== ====== =========== ============ ============ ============ =========== =========== ============                                                                     |
|SAPSR3      /DMF/PRODT        COLUMN      1     2634424         0.45         0.00         0.48        0.48        0.49 saphanahost1                                                                     |
|                                                                                                                                                                                                        |
|SCHEMA_NAME TABLE_NAME        INS_PER_S DEL_PER_S UPD_PER_S REP_PER_S MRG_PER_S SEL_PER_S LAST_MODIFY_TIME    LAST_SELECT_TIME                                                                          |
|=========== ================= ========= ========= ========= ========= ========= ========= =================== ===================                                                                       |
|SAPSR3      /DMF/PRODT             0.01      0.00      0.00      0.00      0.00      0.00 2020/05/14 12:37:14                                                                                           |
|                                                                                                                                                                                                        |
|*****************************                                                                                                                                                                           |
|* TABLE PERSISTENCE HISTORY *                                                                                                                                                                           |
|*****************************                                                                                                                                                                           |
|                                                                                                                                                                                                        |
|DAY        SCHEMA_NAME TABLE_NAME         DISK_GB    READ_MB   WRITE_MB TRUNCATES                                                                                                                       |
|========== =========== ================= ======== ========== ========== =========                                                                                                                       |
|2020/05/14 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/05/13 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/12 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/11 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/10 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/09 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/08 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/07 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/06 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/05 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/04 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/05/03 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/05/02 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/05/01 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/04/30 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/04/29 SAPSR3      /DMF/PRODT            0.49       0.00       0.00         0                                                                                                                       |
|2020/04/28 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/04/27 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/04/26 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|2020/04/25 SAPSR3      /DMF/PRODT            0.48       0.00       0.00         0                                                                                                                       |
|                                                                                                                                                                                                        |
|*********************                                                                                                                                                                                   |
|* INDEX INFORMATION *                                                                                                                                                                                   |
|*********************                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
|SCHEMA_NAME TABLE_NAME        INDEX_NAME                  COLUMN_NAME INDEX_TYPE             CONSTRAINT_NAME                                                                                            |
|=========== ================= =========================== =========== ====================== ===================                                                                                        |
|SAPSR3      /DMF/PRODT        DMF_PRODT_PROD_NAME_IDX     PROD_NAME   FULLTEXT TEXT ANALYSIS                                                                                                            |
|SAPSR3      /DMF/PRODT        _SYS_TREE_CS_#543036_#0_#P0 MANDT       INVERTED VALUE UNIQUE  PRIMARY KEY                                                                                                |
|                                                          LANGU                                                                                                                                         |
|                                                          PROD_ID                                                                                                                                       |
|                                                                                                                                                                                                        |
|SCHEMA_NAME TABLE_NAME        INDEX_NAME COLUMN_NAME INDEX_TYPE                                                                                                                                         |
|=========== ================= ========== =========== ======================                                                                                                                             |
|SAPSR3      /DMF/PRODT        implicit   LANGU       INVERTED VALUE (BLOCK)                                                                                                                             |
|                              implicit   MANDT       INVERTED VALUE (BLOCK)                                                                                                                             |
|                              implicit   PROD_ID     INVERTED VALUE (BLOCK)                                                                                                                             |
|                                                                                                                                                                                                        |
...
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    SCHEMA_NAME,
    TABLE_NAME,
    MAX_RESULT_LINES,
    LINE_LENGTH,
    HOST_LEN
  FROM
  ( SELECT                /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      '%' SCHEMA_NAME,
      'STATISTICS_PROPERTIES' TABLE_NAME,
      20 MAX_RESULT_LINES,
      200 LINE_LENGTH
    FROM
      DUMMY
  ),
  ( SELECT MAX(LENGTH(HOST)) HOST_LEN FROM M_HOST_INFORMATION )
),
ROW_COUNTER AS
( SELECT
    ROW_NUMBER () OVER () LINE_NO
  FROM
    OBJECTS
),
ACCESSED_TABLES AS
( SELECT TOP 1
    T.SCHEMA_NAME,
    T.TABLE_NAME,
    T.TABLE_TYPE,
    T.AUTO_OPTIMIZE_COMPRESSION_ON,
    T.LOAD_UNIT,
    T.AUTO_MERGE_ON,
    GREATEST(11, LENGTH(T.SCHEMA_NAME)) SCHEMA_LEN,
    GREATEST(10, LENGTH(T.TABLE_NAME) + 7) TABLE_LEN
  FROM
    BASIS_INFO BI,
    TABLES T
  WHERE
    T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    T.TABLE_NAME = BI.TABLE_NAME
),
ACCESSED_TABLE_STATISTICS AS
( SELECT
    AC.SCHEMA_LEN,
    AC.TABLE_LEN,
    TS.SCHEMA_NAME,
    TS.TABLE_NAME,
    TO_DECIMAL(TS.INSERT_COUNT / S.UPTIME_S, 10, 2) INS_PER_S,
    TO_DECIMAL(TS.DELETE_COUNT / S.UPTIME_S, 10, 2) DEL_PER_S,
    TO_DECIMAL(TS.UPDATE_COUNT / S.UPTIME_S, 10, 2) UPD_PER_S,
    TO_DECIMAL(TS.REPLACE_COUNT / S.UPTIME_S, 10, 2) REP_PER_S,
    TO_DECIMAL(TS.MERGE_COUNT / S.UPTIME_S, 10, 2) MRG_PER_S,
    TO_DECIMAL(TS.SELECT_COUNT / S.UPTIME_S, 10, 2) SEL_PER_S,
    IFNULL(TO_VARCHAR(LAST_MODIFY_TIME, 'yyyy/mm/dd hh24:mi:ss'), '') LAST_MODIFY_TIME,
    IFNULL(TO_VARCHAR(LAST_SELECT_TIME, 'yyyy/mm/dd hh24:mi.ss'), '') LAST_SELECT_TIME
  FROM
    ACCESSED_TABLES AC,
    M_TABLE_STATISTICS TS,
    ( SELECT GREATEST(1, SECONDS_BETWEEN(MIN(START_TIME), CURRENT_TIMESTAMP)) UPTIME_S FROM M_SERVICE_STATISTICS WHERE SERVICE_NAME IN ('indexserver', 'nameserver') ) S
  WHERE
    TS.SCHEMA_NAME = AC.SCHEMA_NAME AND
    TS.TABLE_NAME = AC.TABLE_NAME
),
ACCESSED_TABLE_SIZE_HISTORY AS
( SELECT
    P.DAY,
    P.SCHEMA_NAME,
    P.TABLE_NAME,
    P.SCHEMA_LEN,
    P.TABLE_LEN,
    P.DISK_GB,
    P.READ_MB,
    P.WRITE_MB,
    P.TRUNCATES,
    IFNULL(M.RECORDS, '') RECORDS,
    IFNULL(M.MEM_TOTAL_GB, '') MEM_TOTAL_GB,
    IFNULL(M.MEM_MAIN_GB, '') MEM_MAIN_GB,
    IFNULL(M.MEM_DELTA_GB, '') MEM_DELTA_GB,
    IFNULL(M.MEM_PERS_GB, '') MEM_PERS_GB
  FROM
  ( SELECT
      TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD') DAY,
      SCHEMA_NAME,
      TABLE_NAME,
      SCHEMA_LEN,
      TABLE_LEN,
      TO_DECIMAL(MAX(DISK_GB), 10, 2) DISK_GB,
      TO_DECIMAL(SUM(READ_MB), 10, 2) READ_MB,
      TO_DECIMAL(SUM(WRITE_MB), 10, 2) WRITE_MB,
      TO_DECIMAL(SUM(TRUNCATES), 10, 0) TRUNCATES
    FROM
    ( SELECT
        P.SERVER_TIMESTAMP,
        P.SCHEMA_NAME,
        P.TABLE_NAME,
        SUM(GREATEST(0, P.DISK_SIZE)) / 1024 / 1024 / 1024 DISK_GB,
        SUM(GREATEST(0, P.BYTES_READ_DELTA)) / 1024 / 1024 READ_MB,
        SUM(GREATEST(0, P.BYTES_WRITTEN_DELTA)) / 1024 / 1024 WRITE_MB,
        SUM(GREATEST(0, P.TRUNCATE_COUNT_DELTA)) / 1024 / 1024 TRUNCATES,
        AC.SCHEMA_LEN,
        AC.TABLE_LEN
      FROM
        BASIS_INFO BI,
        ACCESSED_TABLES AC,
        _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS P
      WHERE
        P.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
        P.SCHEMA_NAME = AC.SCHEMA_NAME AND
        P.TABLE_NAME = AC.TABLE_NAME
      GROUP BY
        P.SERVER_TIMESTAMP,
        P.SCHEMA_NAME,
        P.TABLE_NAME,
        AC.SCHEMA_LEN,
        AC.TABLE_LEN
    )
    GROUP BY
      TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD'),
      SCHEMA_NAME,
      TABLE_NAME,
      SCHEMA_LEN,
      TABLE_LEN
  ) P LEFT OUTER JOIN
  ( SELECT
      TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD') DAY,
      SCHEMA_NAME,
      TABLE_NAME,
      TO_VARCHAR(TO_DECIMAL(MAX(RECORDS), 10, 0)) RECORDS,
      TO_VARCHAR(TO_DECIMAL(MAX(MEM_TOTAL_GB), 10, 2)) MEM_TOTAL_GB,
      TO_VARCHAR(TO_DECIMAL(MAX(MEM_MAIN_GB), 10, 2)) MEM_MAIN_GB,
      TO_VARCHAR(TO_DECIMAL(MAX(MEM_DELTA_GB), 10, 2)) MEM_DELTA_GB,
      TO_VARCHAR(TO_DECIMAL(MAX(MEM_PERS_GB), 10, 2)) MEM_PERS_GB
    FROM
    ( SELECT
        M.SERVER_TIMESTAMP,
        M.SCHEMA_NAME,
        M.TABLE_NAME,
        SUM(GREATEST(0, M.RECORD_COUNT)) RECORDS,
        SUM(GREATEST(0, M.MEMORY_SIZE_IN_TOTAL + IFNULL(M.PERSISTENT_MEMORY_SIZE_IN_TOTAL, 0))) / 1024 / 1024 / 1024 MEM_TOTAL_GB,
        SUM(GREATEST(0, M.MEMORY_SIZE_IN_MAIN)) / 1024 / 1024 / 1024 MEM_MAIN_GB,
        SUM(GREATEST(0, M.MEMORY_SIZE_IN_DELTA)) / 1024 / 1024 / 1024 MEM_DELTA_GB,
        SUM(GREATEST(0, IFNULL(M.PERSISTENT_MEMORY_SIZE_IN_TOTAL, 0))) / 1024 / 1024 / 1024 MEM_PERS_GB
      FROM
        ACCESSED_TABLES AC,
        _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE M
      WHERE
        M.SCHEMA_NAME = AC.SCHEMA_NAME AND
        M.TABLE_NAME = AC.TABLE_NAME
      GROUP BY
        M.SERVER_TIMESTAMP,
        M.SCHEMA_NAME,
        M.TABLE_NAME
    )
    GROUP BY
      TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD'),
      SCHEMA_NAME,
      TABLE_NAME
  ) M ON
    P.DAY = M.DAY AND
    P.SCHEMA_NAME = M.SCHEMA_NAME AND
    P.TABLE_NAME = M.TABLE_NAME
),
ACCESSED_TRANSLATION_TABLES AS
( SELECT
    TT.SCHEMA_NAME1 SCHEMA_NAME_1,
    TT.TABLE_NAME1 TABLE_NAME_1,
    TT.COLUMN_NAME1 COLUMN_NAME_1,
    TT.SCHEMA_NAME2 SCHEMA_NAME_2,
    TT.TABLE_NAME2 TABLE_NAME_2,
    TT.COLUMN_NAME2 COLUMN_NAME_2,
    COUNT(*) NUM_TTS,
    TO_DECIMAL(SUM(TT.TRANSLATION_TABLE_MEMORY_SIZE) / 1024 / 1024, 10, 2) SIZE_MB,
    GREATEST(13, MAX(LENGTH(TT.SCHEMA_NAME1)) OVER ()) SCHEMA_NAME_1_LEN,
    GREATEST(12, MAX(LENGTH(TT.TABLE_NAME1)) OVER ()) TABLE_NAME_1_LEN,
    GREATEST(13, MAX(LENGTH(TT.COLUMN_NAME1)) OVER ()) COLUMN_NAME_1_LEN,
    GREATEST(13, MAX(LENGTH(TT.SCHEMA_NAME2)) OVER ()) SCHEMA_NAME_2_LEN,
    GREATEST(12, MAX(LENGTH(TT.TABLE_NAME2)) OVER ()) TABLE_NAME_2_LEN,
    GREATEST(13, MAX(LENGTH(TT.COLUMN_NAME2)) OVER ()) COLUMN_NAME_2_LEN
  FROM
    M_JOIN_TRANSLATION_TABLES TT
  WHERE
    ( TT.SCHEMA_NAME1, TT.TABLE_NAME1) IN ( SELECT SCHEMA_NAME, TABLE_NAME FROM ACCESSED_TABLES ) AND
    ( TT.SCHEMA_NAME2, TT.TABLE_NAME2) IN ( SELECT SCHEMA_NAME, TABLE_NAME FROM ACCESSED_TABLES )
  GROUP BY
    TT.SCHEMA_NAME1,
    TT.TABLE_NAME1,
    TT.COLUMN_NAME1,
    TT.SCHEMA_NAME2,
    TT.TABLE_NAME2,
    TT.COLUMN_NAME2
),
ACCESSED_VIRTUAL_TABLES AS
( SELECT TOP 1
    V.SCHEMA_NAME,
    V.TABLE_NAME,
    V.REMOTE_SOURCE_NAME,
    V.REMOTE_OBJECT_NAME,
    GREATEST(11, LENGTH(V.SCHEMA_NAME)) SCHEMA_LEN,
    GREATEST(10, LENGTH(V.TABLE_NAME)) TABLE_LEN,
    GREATEST(18, LENGTH(V.REMOTE_OBJECT_NAME)) REMOTE_OBJECT_LEN
  FROM
    BASIS_INFO BI,
    VIRTUAL_TABLES V
  WHERE
    V.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    V.TABLE_NAME = BI.TABLE_NAME
),
ACCESSED_LOBS AS
( SELECT
    L.SCHEMA_NAME,
    L.TABLE_NAME || MAP(L.PART_ID, 0, '', CHAR(32) || '(' || L.PART_ID || ')') TABLE_NAME,
    L.COLUMN_NAME,
    L.LOB_STORAGE_TYPE LOB_TYPE,
    TO_DECIMAL(SUM(L.DISK_SIZE) / 1024 / 1024 / 1024, 10, 2) DISK_GB,
    TO_DECIMAL(SUM(L.BINARY_SIZE) / 1024 / 1024 / 1024, 10, 2)  BINARY_GB,
    SUM(L.LOB_COUNT) LOB_COUNT,
    T.SCHEMA_LEN,
    T.TABLE_LEN
  FROM
    ACCESSED_TABLES T,
    M_TABLE_LOB_STATISTICS L
  WHERE
    T.SCHEMA_NAME = L.SCHEMA_NAME AND
    T.TABLE_NAME = L.TABLE_NAME
  GROUP BY
    L.SCHEMA_NAME,
    L.TABLE_NAME || MAP(L.PART_ID, 0, '', CHAR(32) || '(' || L.PART_ID || ')'),
    L.COLUMN_NAME,
    L.LOB_STORAGE_TYPE,
    T.SCHEMA_LEN,
    T.TABLE_LEN
),
ACCESSED_PARTITIONS AS
( SELECT
    P.*,
    GREATEST(11, MAX(LENGTH(P.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(P.TABLE_NAME) + LENGTH(P.PART_ID) + 3) OVER ()) TABLE_LEN,
    GREATEST(20, MAX(LENGTH(P.LEVEL_1_PARTITIONING)) OVER ()) L1_LEN,
    GREATEST(20, MAX(LENGTH(P.LEVEL_2_PARTITIONING)) OVER ()) L2_LEN
  FROM
  ( SELECT
      TP.SCHEMA_NAME,
      TP.TABLE_NAME,
      TP.PART_ID,
      CASE PT.LEVEL_1_TYPE
        WHEN 'RANGE' THEN 'RANGE (' || PT.LEVEL_1_EXPRESSION || ')' || CHAR(32) || TP.LEVEL_1_RANGE_MIN_VALUE || MAP(TP.LEVEL_1_RANGE_MAX_VALUE, '', '', TP.LEVEL_1_RANGE_MIN_VALUE, '', '-' || TP.LEVEL_1_RANGE_MAX_VALUE)
        ELSE PT.LEVEL_1_TYPE || CHAR(32) || PT.LEVEL_1_COUNT || CHAR(32) || '(' || PT.LEVEL_1_EXPRESSION || ')'
      END LEVEL_1_PARTITIONING,
      CASE PT.LEVEL_2_TYPE
        WHEN '' THEN ''
        WHEN 'RANGE' THEN 'RANGE (' || PT.LEVEL_2_EXPRESSION || ')' || CHAR(32) || TP.LEVEL_2_RANGE_MIN_VALUE || MAP(TP.LEVEL_2_RANGE_MAX_VALUE, '', '', TP.LEVEL_2_RANGE_MIN_VALUE, '', '-' || TP.LEVEL_2_RANGE_MAX_VALUE)
        ELSE PT.LEVEL_2_TYPE || CHAR(32) || PT.LEVEL_2_COUNT || CHAR(32) || '(' || PT.LEVEL_2_EXPRESSION || ')'
      END LEVEL_2_PARTITIONING,
      GREATEST(CT.MEMORY_SIZE_IN_TOTAL + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL, CT.ESTIMATED_MAX_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024 MEM_SIZE_GB,
      CT.RECORD_COUNT RECORDS,
      TP.LOAD_UNIT
    FROM
      ACCESSED_TABLES AC,
      PARTITIONED_TABLES PT,
      TABLE_PARTITIONS TP,
      M_CS_TABLES CT
    WHERE
      AC.SCHEMA_NAME = PT.SCHEMA_NAME AND
      AC.TABLE_NAME = PT.TABLE_NAME AND
      PT.SCHEMA_NAME = TP.SCHEMA_NAME AND
      PT.TABLE_NAME = TP.TABLE_NAME AND
      TP.SCHEMA_NAME = CT.SCHEMA_NAME AND
      TP.TABLE_NAME = CT.TABLE_NAME AND
      TP.PART_ID = CT.PART_ID
  ) P
),
ACCESSED_VIEWS AS
( SELECT TOP 1
    V.*,
    GREATEST(11, LENGTH(V.SCHEMA_NAME)) SCHEMA_LEN,
    GREATEST(9, LENGTH(V.VIEW_NAME)) VIEW_LEN
  FROM
    BASIS_INFO BI,
    VIEWS V
  WHERE
    V.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    V.VIEW_NAME = BI.TABLE_NAME
),
ACCESSED_CALCVIEWS AS
( SELECT
    C.HOST,
    C.PORT,
    C.SCHEMA_NAME,
    C.VIEW_NAME,
    C.CALCNODE_NAME,
    MAX(LENGTH(C.SCHEMA_NAME)) OVER () SCHEMA_LEN,
    MAX(LENGTH(C.VIEW_NAME)) OVER () VIEW_LEN,
    SUBSTR(SCENARIO_NAME, 1, LOCATE(SCENARIO_NAME, ':', 1) - 1) SCENARIO_SCHEMA_NAME,
    SUBSTR(SCENARIO_NAME, LOCATE(SCENARIO_NAME, ':', 1) + 1) SCENARIO_NAME
  FROM
    ACCESSED_VIEWS V,
    M_CE_CALCVIEW_DEPENDENCIES C
  WHERE
    V.VIEW_TYPE = 'CALC' AND
    C.VIEW_NAME = V.VIEW_NAME
),
ACCESSED_CALCSCENARIOS AS
( SELECT
    CS.*,
    C.SCHEMA_LEN,
    GREATEST(13, MAX(LENGTH(CS.SCENARIO_NAME)) OVER ()) SCENARIO_LEN,
    IFNULL(CH.SCENARIO_HINTS, '') SCENARIO_HINTS
  FROM
    ACCESSED_CALCVIEWS C,
  ( SELECT
      HOST,
      PORT,
      SUBSTR(SCENARIO_NAME, 1, LOCATE(SCENARIO_NAME, ':', 1) - 1) SCHEMA_NAME,
      SUBSTR(SCENARIO_NAME, LOCATE(SCENARIO_NAME, ':', 1) + 1) SCENARIO_NAME,
      IS_PERSISTENT,
      CREATE_TIME,
      MEMORY_SIZE,
      COMPONENT
    FROM
      M_CE_CALCSCENARIOS_OVERVIEW
  ) CS LEFT OUTER JOIN
  ( SELECT
      SCHEMA_NAME,
      SCENARIO_NAME,
      STRING_AGG(HINT_TYPE || '=' || HINT_VALUE, ', ' ORDER BY HINT_TYPE, HINT_VALUE) SCENARIO_HINTS
    FROM
      M_CE_CALCSCENARIO_HINTS
    GROUP BY
      SCHEMA_NAME, 
      SCENARIO_NAME
  ) CH ON
    CH.SCHEMA_NAME = CS.SCHEMA_NAME AND
    CH.SCENARIO_NAME = CS.SCENARIO_NAME
  WHERE
    CS.SCHEMA_NAME = C.SCENARIO_SCHEMA_NAME AND
    CS.SCENARIO_NAME = C.SCENARIO_NAME
),
ACCESSED_INDEXES AS
( SELECT
    IC.SCHEMA_NAME,
    IC.TABLE_NAME,
    IC.INDEX_NAME,
    STRING_AGG(IC.COLUMN_NAME, ', ' ORDER BY IC.POSITION) COLUMN_LIST,
    GREATEST(10, MAX(LENGTH(IC.INDEX_NAME)) OVER ()) INDEX_LEN,
    AC.SCHEMA_LEN,
    AC.TABLE_LEN
  FROM
    ACCESSED_TABLES AC,
    INDEX_COLUMNS IC
  WHERE
    AC.SCHEMA_NAME = IC.SCHEMA_NAME AND
    AC.TABLE_NAME = IC.TABLE_NAME
  GROUP BY
    IC.SCHEMA_NAME,
    IC.TABLE_NAME,
    IC.INDEX_NAME,
    AC.SCHEMA_LEN,
    AC.TABLE_LEN
),
ACCESSED_COLUMNS AS
( SELECT
    SCHEMA_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    NUM_DISTINCT,
    SIZE_MB,
    LENGTH,
    DATA_TYPE,
    COMPRESSION,
    INDEX_TYPE,
    SCANNED_RECS_PER_S,
    INTERNAL_ATTRIBUTE_TYPE,
    LOAD_UNIT,
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(TABLE_NAME)) OVER ()) TABLE_LEN,
    MAX(LENGTH(COLUMN_NAME)) OVER () COLUMN_LEN
  FROM
  ( SELECT
      CC.SCHEMA_NAME,
      CC.TABLE_NAME,
      CC.COLUMN_NAME,
      TO_VARCHAR(MAX(CC.DISTINCT_COUNT)) NUM_DISTINCT,
      TO_VARCHAR(TO_DECIMAL(SUM(CC.MEMORY_SIZE_IN_TOTAL + CC.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024, 10, 2)) SIZE_MB,
      MAP(MAX(TC.LENGTH), NULL, '', TO_VARCHAR(MAX(TC.LENGTH))) LENGTH,
      IFNULL(MAX(TC.DATA_TYPE_NAME), 'internal') DATA_TYPE,
      MAP(MIN(CC.COMPRESSION_TYPE), MAX(CC.COMPRESSION_TYPE), MIN(CC.COMPRESSION_TYPE), 'various') COMPRESSION,
      MAP(MIN(CC.INDEX_TYPE), MAX(CC.INDEX_TYPE), MIN(CC.INDEX_TYPE), 'various') INDEX_TYPE,
      MAP(MIN(CC.INTERNAL_ATTRIBUTE_TYPE), MAX(CC.INTERNAL_ATTRIBUTE_TYPE), MIN(CC.INTERNAL_ATTRIBUTE_TYPE), 'various') INTERNAL_ATTRIBUTE_TYPE,
      IFNULL(TO_DECIMAL(SUM(CS.SCANNED_RECORD_COUNT) / S.TIMEFRAME_S, 18, 0), 0) SCANNED_RECS_PER_S,
      IFNULL(MAX(CC.LOAD_UNIT), 'n/a') LOAD_UNIT
    FROM
      ( SELECT MAX(SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP)) TIMEFRAME_S FROM M_SERVICE_STATISTICS ) S,
      ACCESSED_TABLES AC,
      M_CS_ALL_COLUMNS CC LEFT OUTER JOIN
      M_CS_ALL_COLUMN_STATISTICS CS ON
        CS.SCHEMA_NAME = CC.SCHEMA_NAME AND
        CS.TABLE_NAME = CC.TABLE_NAME AND
        CS.COLUMN_NAME = CC.COLUMN_NAME AND
        CS.PART_ID = CC.PART_ID LEFT OUTER JOIN
      TABLE_COLUMNS TC ON
        TC.SCHEMA_NAME = CC.SCHEMA_NAME AND
        TC.TABLE_NAME = CC.TABLE_NAME AND
        TC.COLUMN_NAME = CC.COLUMN_NAME
    WHERE
      CC.SCHEMA_NAME = AC.SCHEMA_NAME AND
      CC.TABLE_NAME = AC.TABLE_NAME
    GROUP BY
      S.TIMEFRAME_S,
      CC.SCHEMA_NAME,
      CC.TABLE_NAME,
      CC.COLUMN_NAME
    UNION ALL
    SELECT
      TC.SCHEMA_NAME,
      TC.TABLE_NAME,
      TC.COLUMN_NAME,
      '' NUM_DISTINCT,
      '' SIZE_MB,
      TO_VARCHAR(TC.LENGTH) LENGTH,
      TC.DATA_TYPE_NAME DATA_TYPE,
      '' COMPRESSION,
      'NONE' INDEX_TYPE,
      '' INTERNAL_ATTRIBUTE_TYPE,
      -1 SCANNED_RECS_PER_S,
      'COLUMN' LOAD_UNIT
    FROM
      ACCESSED_TABLES AC,
      TABLE_COLUMNS TC
    WHERE
      TC.SCHEMA_NAME = AC.SCHEMA_NAME AND
      TC.TABLE_NAME = AC.TABLE_NAME AND
      AC.TABLE_TYPE = 'ROW'
  )
),
ACCESSED_INDEX_COLUMNS AS
( SELECT
    SCHEMA_NAME,
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    POSITION,
    INDEX_TYPE,
    CONSTRAINT,
    GREATEST(11, MAX(LENGTH(COLUMN_NAME)) OVER ()) COLUMN_LEN,
    MAX(LENGTH(INDEX_NAME)) OVER () INDEX_LEN,
    MAX(LENGTH(INDEX_TYPE)) OVER () INDEX_TYPE_LEN,
    SCHEMA_LEN,
    TABLE_LEN
  FROM
  ( SELECT
      IC.SCHEMA_NAME,
      IC.TABLE_NAME,
      IC.INDEX_NAME,
      IC.COLUMN_NAME,
      IC.POSITION,
      I.INDEX_TYPE,
      IC.CONSTRAINT,
      AC.SCHEMA_LEN,
      AC.TABLE_LEN
    FROM
      ACCESSED_TABLES AC,
      INDEX_COLUMNS IC,
      INDEXES I
    WHERE
      AC.SCHEMA_NAME = IC.SCHEMA_NAME AND
      AC.TABLE_NAME = IC.TABLE_NAME AND
      I.SCHEMA_NAME = IC.SCHEMA_NAME AND
      I.INDEX_NAME = IC.INDEX_NAME
    UNION ALL
    SELECT
      SCHEMA_NAME,
      TABLE_NAME,
      INDEX_NAME,
      COLUMN_NAME,
      POSITION,
      'CONCAT ATTRIBUTE' INDEX_TYPE,
      '' CONSTRAINT,
      AC.SCHEMA_LEN,
      AC.TABLE_LEN
    FROM
    ( SELECT SCHEMA_LEN, TABLE_LEN FROM ACCESSED_TABLES ) AC,
    ( SELECT DISTINCT
        C.SCHEMA_NAME,
        C.TABLE_NAME,
        C.COLUMN_NAME INDEX_NAME,
        P.POSITION,
        SUBSTR(C.COLUMN_NAME, LOCATE(C.COLUMN_NAME, '$', 1, P.POSITION) + 1, LOCATE(C.COLUMN_NAME, '$', 1, P.POSITION + 1) - LOCATE(C.COLUMN_NAME, '$', 1, P.POSITION) - 1 ) COLUMN_NAME
      FROM
        ( SELECT TOP 50 ROW_NUMBER() OVER () POSITION FROM OBJECTS ) P,
        ACCESSED_COLUMNS C
      WHERE
        INTERNAL_ATTRIBUTE_TYPE = 'CONCAT_ATTRIBUTE' AND
        COLUMN_NAME NOT LIKE '$uc%'
    ) C
    WHERE
      C.COLUMN_NAME != '' AND
      NOT EXISTS
      ( SELECT
          1
        FROM
        ( SELECT
            '$' || STRING_AGG(IC.COLUMN_NAME, '$' ORDER BY IC.POSITION) || '$' INDEX_NAME
          FROM
            INDEX_COLUMNS IC
          WHERE
            IC.SCHEMA_NAME = C.SCHEMA_NAME AND
            IC.TABLE_NAME = C.TABLE_NAME
          GROUP BY
            IC.INDEX_NAME
        ) IC
        WHERE
          IC.INDEX_NAME = C.INDEX_NAME
      )
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    POSITION,
    INDEX_TYPE,
    CONSTRAINT,
    SCHEMA_LEN,
    TABLE_LEN
),
ACCESSED_INDEX_COLUMNS_2 AS
( SELECT
    ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME) ROW_NUM,
    ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY COLUMN_NAME) ROW_NUM_PER_TAB,
    SCHEMA_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    INDEX_TYPE,
    SCHEMA_LEN,
    TABLE_LEN,
    GREATEST(11, MAX(LENGTH(COLUMN_NAME)) OVER ()) COLUMN_LEN,
    MAX(LENGTH(INDEX_TYPE)) OVER () INDEX_TYPE_LEN
  FROM
  ( SELECT
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      C.COLUMN_NAME,
      'INVERTED VALUE (' || C.INDEX_TYPE || ')' INDEX_TYPE,
      AC.SCHEMA_LEN,
      AC.TABLE_LEN
    FROM
      ACCESSED_TABLES AC,
      ACCESSED_COLUMNS C
    WHERE
      AC.SCHEMA_NAME = C.SCHEMA_NAME AND
      AC.TABLE_NAME = C.TABLE_NAME AND
      C.INDEX_TYPE != 'NONE' AND
      C.COLUMN_NAME NOT LIKE '$%' AND
      NOT EXISTS
      ( SELECT
          1
        FROM
          ACCESSED_INDEXES IC
        WHERE
          AC.SCHEMA_NAME = IC.SCHEMA_NAME AND
          AC.TABLE_NAME = IC.TABLE_NAME AND
          C.COLUMN_NAME = IC.COLUMN_LIST
      )
  )
  GROUP BY
    SCHEMA_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    INDEX_TYPE,
    SCHEMA_LEN,
    TABLE_LEN
),
ACCESSED_REFERENTIAL_CONSTRAINTS AS
( SELECT
    C.*,
    MAX(LENGTH(C.COLUMN_NAME)) OVER () COLUMN_LEN,
    GREATEST(10, MAX(LENGTH(C.REFERENCED_TABLE_NAME)) OVER ()) REF_TABLE_LEN,
    GREATEST(11, MAX(LENGTH(C.REFERENCED_COLUMN_NAME)) OVER ()) REF_COLUMN_LEN,
    AC.SCHEMA_LEN,
    AC.TABLE_LEN
  FROM
    ACCESSED_TABLES AC,
    REFERENTIAL_CONSTRAINTS C
  WHERE
    ( C.SCHEMA_NAME = AC.SCHEMA_NAME AND C.TABLE_NAME = AC.TABLE_NAME ) OR
    ( C.REFERENCED_SCHEMA_NAME = AC.SCHEMA_NAME AND C.REFERENCED_TABLE_NAME = AC.TABLE_NAME )
),
ACCESSED_REPLICAS AS
( SELECT
    R.*,
    GREATEST(17, MAX(LENGTH(R.SOURCE_SCHEMA_NAME)) OVER ()) SRC_SCHEMA_LEN,
    GREATEST(16, MAX(LENGTH(R.SOURCE_TABLE_NAME)) OVER ()) SRC_TABLE_LEN,
    GREATEST(10, MAX(LENGTH(R.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(9, MAX(LENGTH(R.TABLE_NAME)) OVER ()) TABLE_LEN
  FROM
    ACCESSED_TABLES AC,
    M_TABLE_REPLICAS R
  WHERE
  ( R.SOURCE_SCHEMA_NAME = AC.SCHEMA_NAME AND R.SOURCE_TABLE_NAME = AC.TABLE_NAME ) OR
  ( R.SCHEMA_NAME = AC.SCHEMA_NAME AND R.TABLE_NAME = AC.TABLE_NAME )
),
ACCESSED_TRIGGERS AS
( SELECT
    T.*,
    GREATEST(12, MAX(LENGTH(T.TRIGGER_NAME)) OVER ()) TRIGGER_LEN
  FROM
    ACCESSED_TABLES AC,
    TRIGGERS T
  WHERE
    T.SUBJECT_TABLE_SCHEMA = AC.SCHEMA_NAME AND
    T.SUBJECT_TABLE_NAME = AC.TABLE_NAME
),
TABLE_OPTIMIZATIONS AS
( SELECT
    M.START_TIME,
    ROW_NUMBER() OVER (ORDER BY M.START_TIME DESC, M.SCHEMA_NAME, M.TABLE_NAME) LINE_NO,
    M.SCHEMA_NAME,
    M.TABLE_NAME || MAP(M.PART_ID, 0, '', CHAR(32) || '(' || M.PART_ID || ')') TABLE_NAME,
    M.HOST,
    M.TYPE,
    M.MOTIVATION,
    M.MERGED_DELTA_RECORDS MERGED_ROWS,
    TO_DECIMAL(M.EXECUTION_TIME / 1000, 10, 2) RUNTIME_S,
    MAP(M.LAST_ERROR, '0', '0', M.LAST_ERROR || CHAR(32) || M.ERROR_DESCRIPTION) LAST_ERROR,
    AC.SCHEMA_LEN,
    AC.TABLE_LEN,
    BI.MAX_RESULT_LINES
  FROM
    BASIS_INFO BI,
    ACCESSED_TABLES AC,
  ( SELECT DISTINCT
      START_TIME,
      SCHEMA_NAME,
      TABLE_NAME,
      PART_ID,
      HOST,
      TYPE,
      MOTIVATION,
      MERGED_DELTA_RECORDS,
      EXECUTION_TIME,
      LAST_ERROR,
      ERROR_DESCRIPTION
    FROM
      _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS
  ) M
  WHERE
    M.START_TIME BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    AC.SCHEMA_NAME = M.SCHEMA_NAME AND
    AC.TABLE_NAME = M.TABLE_NAME
),
UNLOADS_AND_LOADS AS
( SELECT
    L.TYPE,
    L.ACTION_TIME,
    ROW_NUMBER() OVER (ORDER BY L.ACTION_TIME DESC, L.SCHEMA_NAME, L.TABLE_NAME) LINE_NO,
    L.SCHEMA_NAME,
    L.TABLE_NAME,
    L.COLUMN_NAME,
    L.HOST,
    L.DURATION_MS,
    L.REASON_OR_HASH,
    L.ERROR,
    GREATEST(11, MAX(LENGTH(L.COLUMN_NAME)) OVER ()) COLUMN_LEN,
    BI.MAX_RESULT_LINES,
    SCHEMA_LEN,
    TABLE_LEN
  FROM
    BASIS_INFO BI,
  ( SELECT
      'UNLOAD' TYPE,
      U.UNLOAD_TIME ACTION_TIME,
      U.SCHEMA_NAME,
      U.TABLE_NAME || MAP(U.PART_ID, 0, '', CHAR(32) || '(' || U.PART_ID || ')') TABLE_NAME,
      U.COLUMN_NAME,
      U.HOST,
      -1 DURATION_MS,
      U.REASON REASON_OR_HASH,
      'n/a' ERROR,
      AC.SCHEMA_LEN,
      AC.TABLE_LEN
    FROM
      ACCESSED_TABLES AC,
      M_CS_UNLOADS U
    WHERE
      AC.SCHEMA_NAME = U.SCHEMA_NAME AND
      AC.TABLE_NAME = U.TABLE_NAME
    UNION ALL
    SELECT
      'LOAD' TYPE,
      L.LOAD_TIME ACTION_TIME,
      L.SCHEMA_NAME,
      L.TABLE_NAME || MAP(L.PART_ID, 0, '', CHAR(32) || '(' || L.PART_ID || ')') TABLE_NAME,
      L.COLUMN_NAME,
      L.HOST,
      L.LOAD_DURATION DURATION_MS,
      L.STATEMENT_HASH REASON_OR_HASH,
      MAP(L.ERROR_CODE, '0', '0', L.ERROR_CODE || CHAR(32) || L.ERROR_TEXT) ERROR,
      AC.SCHEMA_LEN,
      AC.TABLE_LEN
    FROM
      ACCESSED_TABLES AC,
      M_CS_LOADS L
    WHERE
      AC.SCHEMA_NAME = L.SCHEMA_NAME AND
      AC.TABLE_NAME = L.TABLE_NAME
  ) L
  WHERE
    L.ACTION_TIME BETWEEN BI.BEGIN_TIME AND BI.END_TIME
),
DATA_STATS AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY S.DATA_SOURCE_SCHEMA_NAME, S.OBJECT_NAME, S.DATA_SOURCE_COLUMN_NAMES) LINE_NO,
    S.DATA_SOURCE_SCHEMA_NAME,
    S.OBJECT_NAME,
    S.DATA_SOURCE_COLUMN_NAMES,
    S.DATA_STATISTICS_TYPE,
    IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.COUNT'), '') COUNT,
    IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.DISTINCT COUNT'), '') DISTINCT_COUNT,
    IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.NULL COUNT'), '') NULL_COUNT,
    IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.MINVALUE STRING'), '') MINVALUE_STRING,
    IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.MAXVALUE STRING'), '') MAXVALUE_STRING,
    GREATEST(11, MAX(LENGTH(S.DATA_SOURCE_SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(11, MAX(LENGTH(S.OBJECT_NAME)) OVER ()) OBJECT_LEN,
    GREATEST(12, MAX(LENGTH(S.DATA_SOURCE_COLUMN_NAMES)) OVER ()) COLUMN_LEN,
    GREATEST(9, MAX(LENGTH(IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.MINVALUE_STRING'), ''))) OVER ()) MIN_VALUE_LEN,
    GREATEST(9, MAX(LENGTH(IFNULL(JSON_VALUE(DATA_STATISTICS_CONTENT, '$.LastRefreshProperties.MAXVALUE_STRING'), ''))) OVER ()) MAX_VALUE_LEN,
    GREATEST(4, MAX(LENGTH(S.DATA_STATISTICS_TYPE)) OVER ()) TYPE_LEN,
    BI.MAX_RESULT_LINES
  FROM
    BASIS_INFO BI,
    ACCESSED_TABLES T,
    ( SELECT
        S.*,
        S.DATA_SOURCE_OBJECT_NAME || MAP(S.DATA_SOURCE_PART_ID, 0, '', CHAR(32) || '(' || S.DATA_SOURCE_PART_ID || ')') OBJECT_NAME
      FROM
        M_DATA_STATISTICS S
    ) S
  WHERE
    S.DATA_SOURCE_SCHEMA_NAME = T.SCHEMA_NAME AND
    S.DATA_SOURCE_OBJECT_NAME  = T.TABLE_NAME
),
SQL_CACHE_CURRENT AS
( SELECT
    CURRENT_TIMESTAMP SERVER_TIMESTAMP,
    C.HOST,
    C.STATEMENT_HASH,
    TO_VARCHAR(C.STATEMENT_STRING) STATEMENT_STRING,
    C.PLAN_ID,
    C.USER_NAME,
    C.TABLE_TYPES,
    C.LAST_PREPARATION_TIMESTAMP,
    C.LAST_EXECUTION_TIMESTAMP,
    C.LAST_CONNECTION_ID,
    C.EXECUTION_COUNT,
    C.TOTAL_RESULT_RECORD_COUNT,
    C.PREPARATION_COUNT,
    C.TOTAL_CURSOR_DURATION,
    C.TOTAL_EXECUTION_TIME + C.TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    C.TOTAL_EXECUTION_TIME,
    C.TOTAL_PREPARATION_TIME,
    C.TOTAL_LOCK_WAIT_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    C.TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    C.TOTAL_CALLED_THREAD_COUNT,
    C.TOTAL_EXECUTION_MEMORY_SIZE,
    C.IS_DISTRIBUTED_EXECUTION,
    TO_VARCHAR(C.ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    TO_VARCHAR(C.ACCESSED_OBJECT_NAMES) ACCESSED_OBJECT_NAMES,
    TO_VARCHAR(SUBSTR(C.STATEMENT_STRING, 1, 4000)) SQL_TEXT,
    C.APPLICATION_NAME,
    C.APPLICATION_SOURCE,
    CASE WHEN C.LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH' ELSE C.LAST_INVALIDATION_REASON END LAST_INVALIDATION_REASON,
    1 LINE_NO
  FROM
    BASIS_INFO BI,
    ACCESSED_TABLES AC,
    M_SQL_PLAN_CACHE C
  WHERE
    C.ACCESSED_TABLE_NAMES LIKE '%' || AC.SCHEMA_NAME || '.' || AC.TABLE_NAME || '(' || '%'
),
SQL_CACHE_HISTORY AS
( SELECT
    C.SERVER_TIMESTAMP,
    C.HOST,
    C.STATEMENT_HASH,
    TO_VARCHAR(C.STATEMENT_STRING) STATEMENT_STRING,
    C.PLAN_ID,
    C.USER_NAME,
    C.TABLE_TYPES,
    C.LAST_PREPARATION_TIMESTAMP,
    C.LAST_EXECUTION_TIMESTAMP,
    C.LAST_CONNECTION_ID,
    C.EXECUTION_COUNT,
    C.TOTAL_RESULT_RECORD_COUNT,
    C.PREPARATION_COUNT,
    C.TOTAL_CURSOR_DURATION,
    C.TOTAL_EXECUTION_TIME + C.TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    C.TOTAL_EXECUTION_TIME,
    C.TOTAL_PREPARATION_TIME,
    C.TOTAL_LOCK_WAIT_DURATION,
    0 TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    0 TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    0 TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    0 TOTAL_CALLED_THREAD_COUNT,
    0 TOTAL_EXECUTION_MEMORY_SIZE,
    C.IS_DISTRIBUTED_EXECUTION,
    TO_VARCHAR(C.ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    TO_VARCHAR(C.ACCESSED_OBJECT_NAMES) ACCESSED_OBJECT_NAMES,
    TO_VARCHAR(SUBSTR(C.STATEMENT_STRING, 1, 4000)) SQL_TEXT,
    C.APPLICATION_NAME,
    C.APPLICATION_SOURCE,
    CASE WHEN C.LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH' ELSE C.LAST_INVALIDATION_REASON END LAST_INVALIDATION_REASON,
    ROW_NUMBER () OVER (ORDER BY C.SERVER_TIMESTAMP DESC, C.PLAN_ID) LINE_NO
  FROM
    BASIS_INFO BI,
    ACCESSED_TABLES AC,
    _SYS_STATISTICS.HOST_SQL_PLAN_CACHE C
  WHERE
    C.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    C.ACCESSED_TABLE_NAMES LIKE '%' || AC.SCHEMA_NAME || '.' || AC.TABLE_NAME || '(' || '%'
),
SQL_CACHE AS
( SELECT
    C.HOST,
    C.STATEMENT_HASH,
    SUM(C.EXECUTION_COUNT) EXECUTIONS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT) / SUM(C.EXECUTION_COUNT)), 10, 2) AVG_RECORDS,
    TO_DECIMAL(SUM(C.TOTAL_CURSOR_DURATION) / 1000000, 10, 2) TOT_CURS_S,
    TO_DECIMAL(SUM(C.TOTAL_EXECUTION_TIME) / 1000000, 10, 2) TOT_EXEC_S,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_CURSOR_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_CURS_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_TIME) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_EXEC_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_MEMORY_SIZE) / SUM(C.EXECUTION_COUNT)) / 1024 / 1024, 10, 2) AVG_MEM_MB,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_LOCK_MS,
    TO_DECIMAL(MAP(SUM(C.PREPARATION_COUNT), 0, 0, SUM(C.TOTAL_PREPARATION_TIME) / SUM(C.PREPARATION_COUNT)) / 1000, 10, 2) AVG_PREP_MS,
    IFNULL(MAX(C.APPLICATION_NAME), '') APP_NAME,
    IFNULL(MAX(C.APPLICATION_SOURCE), '') APP_SOURCE,
    MAX(LENGTH(MAX(C.APPLICATION_NAME))) OVER () APP_NAME_LEN
  FROM
  ( SELECT
      *
    FROM
      SQL_CACHE_HISTORY
    UNION
    SELECT
      *
    FROM
      SQL_CACHE_CURRENT
  ) C
  GROUP BY
    C.HOST,
    C.STATEMENT_HASH
),
SQL_CACHE_HIST_HOUR AS
( SELECT
    TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24') HOUR,
    SUM(C.EXECUTION_COUNT) EXECUTIONS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT) / SUM(C.EXECUTION_COUNT)), 10, 2) AVG_RECORDS,
    TO_DECIMAL(SUM(C.TOTAL_CURSOR_DURATION) / 1000000, 10, 2) TOT_CURS_S,
    TO_DECIMAL(SUM(C.TOTAL_EXECUTION_TIME) / 1000000, 10, 2) TOT_EXEC_S,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_CURSOR_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_CURS_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_TIME) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_EXEC_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_MEMORY_SIZE) / SUM(C.EXECUTION_COUNT)) / 1024 / 1024, 10, 2) AVG_MEM_MB,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_LOCK_MS,
    TO_DECIMAL(MAP(SUM(C.PREPARATION_COUNT), 0, 0, SUM(C.TOTAL_PREPARATION_TIME) / SUM(C.PREPARATION_COUNT)) / 1000, 10, 2) AVG_PREP_MS
  FROM
    SQL_CACHE_HISTORY C
  GROUP BY
    TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')
),
SQL_CACHE_HIST_DAY AS
( SELECT
    TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD') DAY,
    SUM(C.EXECUTION_COUNT) EXECUTIONS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT) / SUM(C.EXECUTION_COUNT)), 10, 2) AVG_RECORDS,
    TO_DECIMAL(SUM(C.TOTAL_CURSOR_DURATION) / 1000000, 10, 2) TOT_CURS_S,
    TO_DECIMAL(SUM(C.TOTAL_EXECUTION_TIME) / 1000000, 10, 2) TOT_EXEC_S,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_CURSOR_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_CURS_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_TIME) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_EXEC_MS,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_MEMORY_SIZE) / SUM(C.EXECUTION_COUNT)) / 1024 / 1024, 10, 2) AVG_MEM_MB,
    TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION) / SUM(C.EXECUTION_COUNT)) / 1000, 10, 2) AVG_LOCK_MS,
    TO_DECIMAL(MAP(SUM(C.PREPARATION_COUNT), 0, 0, SUM(C.TOTAL_PREPARATION_TIME) / SUM(C.PREPARATION_COUNT)) / 1000, 10, 2) AVG_PREP_MS
  FROM
    SQL_CACHE_HISTORY C
  GROUP BY
    TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD')
),
THREAD_SAMPLES AS
( SELECT
    T.TIMESTAMP,
    T.HOST,
    T.PORT,
    T.STATEMENT_HASH,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    T.THREAD_DETAIL,
    T.LOCK_WAIT_NAME LOCK_NAME,
    T.USER_NAME DB_USER,
    T.APPLICATION_NAME APP_NAME,
    T.APPLICATION_SOURCE APP_SOURCE,
    T.APPLICATION_USER_NAME APP_USER,
    T.CLIENT_IP,
    T.CLIENT_PID,
    T.CONNECTION_ID,
    IFNULL(T.ROOT_STATEMENT_HASH, '') ROOT_STATEMENT_HASH,
    GREATEST(11, MAX(LENGTH(T.THREAD_TYPE)) OVER ()) TYPE_LEN,
    MAX(LENGTH(T.THREAD_STATE)) OVER () STATE_LEN,
    MAX(LENGTH(T.THREAD_METHOD)) OVER () METHOD_LEN,
    MAX(LENGTH(T.LOCK_WAIT_NAME)) OVER () LOCK_LEN,
    GREATEST(7, MAX(LENGTH(T.USER_NAME)) OVER ()) DB_USER_LEN,
    GREATEST(8, MAX(LENGTH(T.APPLICATION_NAME)) OVER ()) APP_NAME_LEN,
    GREATEST(10, MAX(LENGTH(T.APPLICATION_SOURCE)) OVER ()) APP_SOURCE_LEN,
    GREATEST(8, MAX(LENGTH(T.APPLICATION_USER_NAME)) OVER ()) APP_USER_LEN,
    COUNT(*) SAMPLES,
    SUM(COUNT(*)) OVER () TOTAL_SAMPLES
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
  WHERE
    T.TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    T.STATEMENT_HASH IN ( SELECT STATEMENT_HASH FROM SQL_CACHE )
  GROUP BY
    T.TIMESTAMP,
    T.HOST,
    T.PORT,
    T.STATEMENT_HASH,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    T.THREAD_DETAIL,
    T.LOCK_WAIT_NAME,
    T.USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.APPLICATION_USER_NAME,
    T.CLIENT_IP,	
    T.CLIENT_PID,
    T.CONNECTION_ID,
    T.ROOT_STATEMENT_HASH
),
TRANSACTIONAL_LOCKS AS
( SELECT
    R.SCHEMA_NAME,
    R.TABLE_NAME,
    R.HOST,
    R.LOCK_MODE,
    R.LOCK_OWNER_UPDATE_TRANSACTION_ID,
    COUNT(*) LOCK_COUNT,
    MIN(R.ACQUIRED_TIME) ACQUIRED_TIME,
    GREATEST(11, MAX(LENGTH(R.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(R.TABLE_NAME)) OVER()) TABLE_LEN
  FROM
    BASIS_INFO BI,
    M_RECORD_LOCKS R
  WHERE
    R.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    R.TABLE_NAME LIKE BI.TABLE_NAME
  GROUP BY
    R.SCHEMA_NAME,
    R.TABLE_NAME,
    R.HOST,
    R.LOCK_MODE,
    R.LOCK_OWNER_UPDATE_TRANSACTION_ID
),
EXECUTED_STATEMENTS AS
( SELECT
    LINE_NO,
    START_TIME,
    DURATION_MICROSEC,
    ERROR_CODE,
    APP_USER,
    APPLICATION_SOURCE,
    STATEMENT_HASH,
    STATEMENT_STRING,
    GREATEST(8, MAX(LENGTH(APP_USER)) OVER ()) APP_USER_LEN,
    MAX(LENGTH(APPLICATION_SOURCE)) OVER () APP_SOURCE_LEN
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY ES.START_TIME DESC) LINE_NO,
      ES.START_TIME,
      ES.DURATION_MICROSEC,
      ES.ERROR_CODE,
      ES.APP_USER,
      ES.APPLICATION_SOURCE,
      ES.STATEMENT_HASH,
      SUBSTR(ES.STATEMENT_STRING, 1, 5000) STATEMENT_STRING,
      BI.MAX_RESULT_LINES
    FROM
      BASIS_INFO BI,
      M_EXECUTED_STATEMENTS ES
    WHERE
    ES.START_TIME BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    ',' || ES.OBJECT_NAME || ',' LIKE '%,' || BI.SCHEMA_NAME || '.' || BI.TABLE_NAME || ',%'
  )
  WHERE
    MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES
)
SELECT
  MAP(BI.LINE_LENGTH, -1, L.LINE, SUBSTR(L.LINE, 1, BI.LINE_LENGTH)) LINE
FROM
  BASIS_INFO BI,
( SELECT   10 LINE_NO, '*********************************' LINE                                                               FROM DUMMY UNION ALL
  SELECT   20,         '* SAP HANA TABLE DATA COLLECTOR *'                                                                    FROM DUMMY UNION ALL
  SELECT   30,         '*********************************'                                                                    FROM DUMMY UNION ALL
  SELECT   40,         ''                                                                                                     FROM DUMMY UNION ALL
  SELECT   82, RPAD('Generated with:',             27, CHAR(32)) || 'SQL: "HANA_Tables_DataCollector" (SAP Note 1969700)'     FROM DUMMY UNION ALL
  SELECT   85, RPAD('Start time:',                 27, CHAR(32)) || TO_VARCHAR(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS')           FROM BASIS_INFO WHERE TO_VARCHAR(BEGIN_TIME, 'YYYY') >= '2000' UNION ALL
  SELECT   86, RPAD('End time:',                   27, CHAR(32)) || TO_VARCHAR(LEAST(CURRENT_TIMESTAMP, END_TIME), 'YYYY/MM/DD HH24:MI:SS') FROM BASIS_INFO UNION ALL
  SELECT   92, RPAD('System ID / database name:',  27, CHAR(32)) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME FROM M_DATABASE UNION ALL
  SELECT   94, RPAD('Revision level:',             27, CHAR(32)) || VERSION                                                   FROM M_DATABASE UNION ALL
  SELECT   98, RPAD('Schema name:',                27, CHAR(32)) || SCHEMA_NAME                                               FROM ACCESSED_TABLES UNION ALL
  SELECT  100, RPAD('Table name:',                 27, CHAR(32)) || TABLE_NAME                                                FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 3490, ''                     FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3491, '********************' FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3492, '* VIEW INFORMATION *' FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3493, '********************' FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3494, ''                     FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3495, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('VIEW_NAME', VIEW_LEN) || CHAR(32) || RPAD('VIEW_TYPE', 10) || CHAR(32) || RPAD('DEPENDENT_OBJECTS', 79) FROM ACCESSED_VIEWS UNION ALL
  SELECT TOP 1 3496, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', VIEW_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 79, '=') FROM ACCESSED_VIEWS UNION ALL
  SELECT 3500 + ROW_NUMBER() OVER (ORDER BY V.SCHEMA_NAME, V.VIEW_NAME) / 1000, RPAD(V.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(V.VIEW_NAME, VIEW_LEN) || CHAR(32) || RPAD(V.VIEW_TYPE, 10) ||
    CHAR(32) || STRING_AGG(D.BASE_OBJECT_NAME, ', ' ORDER BY D.BASE_OBJECT_NAME)
  FROM
    ACCESSED_VIEWS V,
    OBJECT_DEPENDENCIES D
  WHERE
    V.SCHEMA_NAME = D.DEPENDENT_SCHEMA_NAME AND
    V.VIEW_NAME = D.DEPENDENT_OBJECT_NAME
  GROUP BY
    V.SCHEMA_NAME,
    V.VIEW_NAME,
    V.VIEW_TYPE,
    V.VIEW_LEN,
    V.SCHEMA_LEN
  UNION ALL
  SELECT TOP 1 3700, ''                                 FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3701, '********************************' FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3702, '* CALCULATION VIEW INFORMATION *' FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3703, '********************************' FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3704, ''                                 FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3708, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('CALCVIEW_NAME', VIEW_LEN) || CHAR(32) || RPAD('CALCNODE_NAME', 29) || CHAR(32) || 'SCENARIO_NAME' FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT TOP 1 3709, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', VIEW_LEN, '=') || CHAR(32) || RPAD('=', 29, '=') || CHAR(32) || RPAD('=', 59, '=') FROM ACCESSED_CALCVIEWS UNION ALL
  SELECT 3710 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, VIEW_NAME) / 100, RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(VIEW_NAME, VIEW_LEN) || CHAR(32) || RPAD(CALCNODE_NAME, 29) || CHAR(32) || SCENARIO_NAME
  FROM
    ACCESSED_CALCVIEWS
  UNION ALL
  SELECT TOP 1 3800, ''                                     FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3801, '************************************' FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3802, '* CALCULATION SCENARIO INFORMATION *' FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3803, '************************************' FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3804, ''                                     FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3808, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('SCENARIO_NAME', SCENARIO_LEN) || CHAR(32) || RPAD('PERSISTENT', 10) || CHAR(32) || 
    RPAD('CREATE_TIME', 19) || CHAR(32) || LPAD('MEM_SIZE_KB', 11) || CHAR(32) || RPAD('SCENARIO_HINTS', 40) || CHAR(32) || 'COMPONENT' FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT TOP 1 3809, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', SCENARIO_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || 
    RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || RPAD('=', 40, '=') || CHAR(32) || RPAD('=', 59, '=') FROM ACCESSED_CALCSCENARIOS UNION ALL
  SELECT 3810 + ROW_NUMBER() OVER (ORDER BY SCENARIO_NAME) / 1000, RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(SCENARIO_NAME, SCENARIO_LEN) || CHAR(32) || RPAD(IS_PERSISTENT, 10) || CHAR(32) || 
    RPAD(CREATE_TIME, 19) || CHAR(32) || LPAD(TO_DECIMAL(MEMORY_SIZE / 1024, 10, 2), 11) || CHAR(32) || RPAD(SCENARIO_HINTS, 40) || CHAR(32) || COMPONENT
  FROM
    ACCESSED_CALCSCENARIOS
  UNION ALL
  SELECT TOP 1 3990, ''                      FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4000, '*********************' FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4001, '* TABLE INFORMATION *' FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4002, '*********************' FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4003, ''                      FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4009, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('TYPE', 6) || CHAR(32) ||
    LPAD('PARTS', 6) || CHAR(32) || LPAD('RECORDS', 11) || CHAR(32) || LPAD('MEM_TOTAL_GB', 12) || CHAR(32) || LPAD('MEM_DELTA_GB', 12) || LPAD('CURR_DISK_GB', 13) ||
    LPAD('MIN_DISK_GB', 12) || LPAD('MAX_DISK_GB', 12) || CHAR(32) || 
    RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('TABLE_SCANS_PER_S', 17) FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4010, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) ||
    LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || 
    RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 17, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ACCESSED_TABLES UNION ALL
  SELECT 4010 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME), RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(TABLE_TYPE, 6) || CHAR(32) || LPAD(PARTITIONS, 6) ||
    LPAD(RECORDS, 12) || LPAD(IFNULL(MEM_TOTAL_GB, 0.00), 13) || LPAD(IFNULL(MEM_DELTA_GB, 0.00), 13)  || LPAD(IFNULL(CURR_DISK_GB, 0.00), 13) ||
    LPAD(IFNULL(TO_VARCHAR(MIN_DISK_GB), 'n/a'), 12) || LPAD(IFNULL(TO_VARCHAR(MAX_DISK_GB), 'n/a'), 12) || CHAR(32) || 
    RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(TABLE_SCANS_PER_S, 17)
  FROM
  ( SELECT SCHEMA_LEN, TABLE_LEN FROM ACCESSED_TABLES ),
  ( SELECT HOST_LEN FROM BASIS_INFO ),
  ( SELECT
      T.SCHEMA_NAME,
      T.TABLE_NAME,
      T.HOST,
      T.TABLE_TYPE,
      T.PARTITIONS,
      T.RECORDS,
      T.MEM_TOTAL_GB,
      T.MEM_DELTA_GB,
      T.TABLE_SCANS_PER_S,
      ( SELECT TO_DECIMAL(SUM(D.DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM M_TABLE_PERSISTENCE_STATISTICS D WHERE D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME ) CURR_DISK_GB,
      ( SELECT TO_DECIMAL(MIN(DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM ( SELECT SUM(D.DISK_SIZE) DISK_SIZE FROM 
          _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS D WHERE D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME GROUP BY D.SNAPSHOT_ID ) ) MIN_DISK_GB,
      ( SELECT TO_DECIMAL(MAX(DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM ( SELECT SUM(D.DISK_SIZE) DISK_SIZE FROM 
          _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS D WHERE D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME GROUP BY D.SNAPSHOT_ID ) ) MAX_DISK_GB
    FROM
    ( SELECT
        T.SCHEMA_NAME,
        T.TABLE_NAME,
        MAP(MIN(T.HOST), MAX(T.HOST), MIN(T.HOST), 'various') HOST,
        'COLUMN' TABLE_TYPE,
        COUNT(*) PARTITIONS,
        SUM(T.RECORD_COUNT) RECORDS,
        TO_DECIMAL(SUM(T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024, 10, 2) MEM_TOTAL_GB,
        TO_DECIMAL(SUM(T.MEMORY_SIZE_IN_DELTA / 1024 / 1024 / 1024), 10, 2) MEM_DELTA_GB,
        0 TABLE_SCANS_PER_S
      FROM
        ACCESSED_TABLES AC,
        M_CS_TABLES T
      WHERE
        AC.SCHEMA_NAME = T.SCHEMA_NAME AND
        AC.TABLE_NAME = T.TABLE_NAME
      GROUP BY
        T.SCHEMA_NAME,
        T.TABLE_NAME
      UNION ALL
      SELECT
        T.SCHEMA_NAME,
        T.TABLE_NAME,
        MAP(MIN(T.HOST), MAX(T.HOST), MIN(T.HOST), 'various') HOST,
        'ROW' TABLE_TYPE,
        1 PARTITIONS,
        SUM(T.RECORD_COUNT) RECORDS,
        TO_DECIMAL(SUM((T.ALLOCATED_FIXED_PART_SIZE + T.ALLOCATED_VARIABLE_PART_SIZE) / 1024 / 1024 / 1024), 10, 2) MEM_TOTAL_GB,
        0 MEM_DELTA_GB,
        TO_DECIMAL(SUM(T.SCAN_COUNT) / S.TIMEFRAME_S, 10, 2) TABLE_SCANS_PER_S
      FROM
      ( SELECT MAX(SECONDS_BETWEEN(START_TIME, CURRENT_TIMESTAMP)) TIMEFRAME_S FROM M_SERVICE_STATISTICS ) S,
        ACCESSED_TABLES AC,
        M_RS_TABLES T
      WHERE
        AC.SCHEMA_NAME = T.SCHEMA_NAME AND
        AC.TABLE_NAME = T.TABLE_NAME
      GROUP BY
        S.TIMEFRAME_S,
        T.SCHEMA_NAME,
        T.TABLE_NAME
    ) T
  ) UNION ALL
  SELECT TOP 1 4103, ''                      FROM ACCESSED_TABLES WHERE TABLE_TYPE = 'COLUMN' UNION ALL
  SELECT TOP 1 4108, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('AUTO_MERGE', 10) || CHAR(32) ||
    RPAD('AUTO_COMPRESSION', 16) || CHAR(32) || RPAD('LOAD_UNIT', 9) FROM ACCESSED_TABLES WHERE TABLE_TYPE = 'COLUMN' UNION ALL
  SELECT TOP 1 4109, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', 16, '=') || CHAR(32) || RPAD('=', 9, '=') FROM ACCESSED_TABLES WHERE TABLE_TYPE = 'COLUMN' UNION ALL
  SELECT 4110 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME), RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(AUTO_MERGE_ON, 10) || CHAR(32) ||
    RPAD(AUTO_OPTIMIZE_COMPRESSION_ON, 16) || CHAR(32) || RPAD(LOAD_UNIT, 9) FROM ACCESSED_TABLES WHERE TABLE_TYPE = 'COLUMN'
  UNION ALL
  SELECT TOP 1 4230, ''                      FROM ACCESSED_TABLE_STATISTICS UNION ALL
  SELECT TOP 1 4280, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || LPAD('INS_PER_S', 9) || CHAR(32) ||
    LPAD('DEL_PER_S', 9) || CHAR(32) || LPAD('UPD_PER_S', 9) || CHAR(32) || LPAD('REP_PER_S', 9) || CHAR(32) || LPAD('MRG_PER_S', 9) || CHAR(32) || LPAD('SEL_PER_S', 9) || CHAR(32) ||
    RPAD('LAST_MODIFY_TIME', 19) || CHAR(32) || RPAD('LAST_SELECT_TIME', 19) FROM ACCESSED_TABLE_STATISTICS UNION ALL
  SELECT TOP 1 4290, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) ||
    LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || 
    RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 19, '=') FROM ACCESSED_TABLE_STATISTICS UNION ALL
  SELECT 4300 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME), RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || LPAD(INS_PER_S, 9) || CHAR(32) ||
    LPAD(DEL_PER_S, 9) || CHAR(32) || LPAD(UPD_PER_S, 9) || CHAR(32) || LPAD(REP_PER_S, 9) || CHAR(32) || LPAD(MRG_PER_S, 9) || CHAR(32) || LPAD(SEL_PER_S, 9) || CHAR(32) ||
    RPAD(LAST_MODIFY_TIME, 19) || CHAR(32) || RPAD(LAST_SELECT_TIME, 19)
  FROM
    ACCESSED_TABLE_STATISTICS
  UNION ALL
  SELECT TOP 1 4490, ''                       FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4500, '**********************' FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4510, '* TABLE SIZE HISTORY *' FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4520, '**********************' FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4530, ''                       FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4580, RPAD('DAY', 10) || CHAR(32) || RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || 
    LPAD('RECORDS', 12) || CHAR(32) || LPAD('MEM_TOTAL_GB', 12) || CHAR(32) || LPAD('MEM_MAIN_GB', 11) || CHAR(32) || LPAD('MEM_DELTA_GB', 12) || CHAR(32) || LPAD('MEM_PERS_GB', 11) || CHAR(32) ||
    LPAD('DISK_GB', 8) || CHAR(32) || LPAD('READ_MB', 10) || CHAR(32) || LPAD('WRITE_MB', 10) || CHAR(32) || LPAD('TRUNCATES', 9) FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT TOP 1 4590, RPAD('=', 10, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) ||
    LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') FROM ACCESSED_TABLE_SIZE_HISTORY UNION ALL
  SELECT 4600 + ROWNO, RPAD(DAY, 10) || CHAR(32) || RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || 
    LPAD(RECORDS, 12) || CHAR(32) || LPAD(MEM_TOTAL_GB, 12) || CHAR(32) || LPAD(MEM_MAIN_GB, 11) || CHAR(32) || LPAD(MEM_DELTA_GB, 12) || CHAR(32) || LPAD(MEM_PERS_GB, 11) || CHAR(32) ||
    LPAD(DISK_GB, 8) || CHAR(32) || LPAD(READ_MB, 10) || CHAR(32) || LPAD(WRITE_MB, 10) || CHAR(32) || LPAD(TRUNCATES, 9) FROM
  ( SELECT MAX_RESULT_LINES FROM BASIS_INFO ) BI,
  ( SELECT
      P.*,
      ROW_NUMBER () OVER (ORDER BY P.DAY DESC) ROWNO
    FROM
      ACCESSED_TABLE_SIZE_HISTORY P
  )
  WHERE
    BI.MAX_RESULT_LINES = -1 OR ROWNO <= BI.MAX_RESULT_LINES
  UNION ALL
  SELECT TOP 1 4790, ''                              FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4700, '*****************************' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4710, '* VIRTUAL TABLE INFORMATION *' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4720, '*****************************' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4730, ''                              FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4780, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('REMOTE_SOURCE_NAME', 18) || CHAR(32) ||
    RPAD('REMOTE_OBJECT_NAME', REMOTE_OBJECT_LEN) FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4790, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 18, '=') || CHAR(32) ||
    RPAD('=', REMOTE_OBJECT_LEN, '=') FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT 4800 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME), RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(REMOTE_SOURCE_NAME, 18) || CHAR(32) || 
    RPAD(REMOTE_OBJECT_NAME, REMOTE_OBJECT_LEN) FROM ACCESSED_VIRTUAL_TABLES
  UNION ALL
  SELECT TOP 1 4990, ''                      FROM ( SELECT 1 FROM ACCESSED_INDEX_COLUMNS UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 5000, '*********************' FROM ( SELECT 1 FROM ACCESSED_INDEX_COLUMNS UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 5010, '* INDEX INFORMATION *' FROM ( SELECT 1 FROM ACCESSED_INDEX_COLUMNS UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 5020, '*********************' FROM ( SELECT 1 FROM ACCESSED_INDEX_COLUMNS UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 5030, ''                      FROM ( SELECT 1 FROM ACCESSED_INDEX_COLUMNS UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 5080, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('INDEX_NAME', INDEX_LEN) || CHAR(32) ||
    RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || RPAD('INDEX_TYPE', INDEX_TYPE_LEN) || CHAR(32) || RPAD('CONSTRAINT_NAME', 19) FROM ACCESSED_INDEX_COLUMNS UNION ALL
  SELECT TOP 1 5090, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', INDEX_LEN, '=') || CHAR(32) ||
    RPAD('=', COLUMN_LEN, '=') || CHAR(32) || RPAD('=', INDEX_TYPE_LEN, '=') || CHAR(32) || RPAD('=', 19, '=') FROM ACCESSED_INDEX_COLUMNS UNION ALL
  SELECT 5100 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, INDEX_NAME, POSITION) / 100, RPAD(MAP(POSITION, 1, SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) ||
    RPAD(MAP(POSITION, 1, TABLE_NAME, ''), TABLE_LEN) || CHAR(32) || RPAD(MAP(POSITION, 1, INDEX_NAME, ''), INDEX_LEN) || CHAR(32) ||
    RPAD(COLUMN_NAME, COLUMN_LEN) || CHAR(32) || RPAD(MAP(POSITION, 1, INDEX_TYPE, ''), INDEX_TYPE_LEN) || CHAR(32) || RPAD(MAP(POSITION, 1, IFNULL(CONSTRAINT, ''), ''), 20)
  FROM
    ACCESSED_INDEX_COLUMNS UNION ALL
  SELECT TOP 1 5490, '' FROM ACCESSED_INDEX_COLUMNS_2 UNION ALL
  SELECT TOP 1 5580, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('INDEX_NAME', 10) || CHAR(32) ||
    RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || RPAD('INDEX_TYPE', INDEX_TYPE_LEN) FROM ACCESSED_INDEX_COLUMNS_2 UNION ALL
  SELECT TOP 1 5590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', COLUMN_LEN, '=') || CHAR(32) || RPAD('=', INDEX_TYPE_LEN, '=') FROM ACCESSED_INDEX_COLUMNS_2 UNION ALL
  SELECT 5600 + ROW_NUM / 100, RPAD(MAP(ROW_NUM_PER_TAB, 1, SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) || 
    RPAD(MAP(ROW_NUM_PER_TAB, 1, TABLE_NAME, ''), TABLE_LEN) || CHAR(32) || RPAD('implicit', 10) || CHAR(32) ||
    RPAD(COLUMN_NAME, COLUMN_LEN) || CHAR(32) || INDEX_TYPE
  FROM
    ACCESSED_INDEX_COLUMNS_2
  UNION ALL
  SELECT TOP 1 5990, ''                       FROM DUMMY UNION ALL
  SELECT TOP 1 6000, '**********************' FROM DUMMY UNION ALL
  SELECT TOP 1 6010, '* COLUMN INFORMATION *' FROM DUMMY UNION ALL
  SELECT TOP 1 6020, '**********************' FROM DUMMY UNION ALL
  SELECT TOP 1 6030, ''                       FROM DUMMY UNION ALL
  SELECT TOP 1 6080, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || LPAD('NUM_DISTINCT', 12) ||
    CHAR(32) || LPAD('SIZE_MB', 12) || CHAR(32) || LPAD('LENGTH', 7) || CHAR(32) || RPAD('DATA_TYPE', 14) || CHAR(32) || RPAD('COMPRESSION', 11) || CHAR(32) || RPAD('INDEX_TYPE', 10) || CHAR(32) ||
    RPAD('LOAD_UNIT', 9) || CHAR(32) || LPAD('SCANNED_RECS_PER_S', 18) FROM ACCESSED_COLUMNS UNION ALL
  SELECT TOP 1 6090, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_LEN, '=') || CHAR(32) || LPAD('=', 12, '=') ||
    CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', 9, '=') || CHAR(32) || LPAD('=', 18, '=') FROM ACCESSED_COLUMNS UNION ALL
  SELECT 6100 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME) / 100,
    RPAD(MAP(ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME), 1, SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) ||
    RPAD(MAP(ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME), 1, TABLE_NAME, ''), TABLE_LEN) || CHAR(32) || 
    RPAD(COLUMN_NAME, COLUMN_LEN) || CHAR(32) || LPAD(NUM_DISTINCT, 12) || CHAR(32) ||
    LPAD(SIZE_MB, 12) || CHAR(32) || LPAD(LENGTH, 7) || CHAR(32) || RPAD(DATA_TYPE, 14) || CHAR(32) || RPAD(COMPRESSION, 11) || CHAR(32) || RPAD(INDEX_TYPE, 10) || CHAR(32) ||
    RPAD(LOAD_UNIT, 9) || CHAR(32) || LPAD(MAP(SCANNED_RECS_PER_S, -1, 'n/a', TO_VARCHAR(SCANNED_RECS_PER_S)), 18)
  FROM
    ACCESSED_COLUMNS
  UNION ALL
  SELECT TOP 1 6290, ''                    FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6300, '*******************' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6310, '* LOB INFORMATION *' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6320, '*******************' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6330, ''                    FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6380, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('COLUMN_NAME', 30) || CHAR(32) || RPAD('LOB_TYPE', 8) || 
    CHAR(32) || LPAD('DISK_GB', 10) || CHAR(32) || LPAD('BINARY_GB', 10) || CHAR(32) || LPAD('LOB_COUNT', 10) FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6390, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 30, '=') || CHAR(32) || RPAD('=', 8, '=') || CHAR(32) ||
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') FROM ACCESSED_LOBS UNION ALL
  SELECT 6400 + ROW_NUMBER() OVER (ORDER BY L.SCHEMA_NAME, L.TABLE_NAME, L.COLUMN_NAME) / 100, 
    RPAD(L.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(L.TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(L.COLUMN_NAME, 30) || CHAR(32) || RPAD(L.LOB_TYPE, 8) || 
    CHAR(32) || LPAD(L.DISK_GB, 10) || CHAR(32) || LPAD(L.BINARY_GB, 10) || CHAR(32) || LPAD(L.LOB_COUNT, 10)
  FROM
    ACCESSED_LOBS L UNION ALL
  SELECT TOP 1 6490, ''                          FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6500, '*************************' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6510, '* PARTITION INFORMATION *' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6520, '*************************' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6530, ''                          FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6580, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || LPAD('MEM_SIZE_GB', 11) || CHAR(32) || 
    LPAD('RECORDS', 12) || CHAR(32) || RPAD('LOAD_UNIT', 9) || CHAR(32) || RPAD('LEVEL_1_PARTITIONING', L1_LEN) || CHAR(32) || RPAD('LEVEL_2_PARTITIONING', L2_LEN) FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || 
    LPAD('=', 12, '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) || RPAD('=', L1_LEN, '=') || CHAR(32) || RPAD('=', L2_LEN, '=') FROM ACCESSED_PARTITIONS UNION ALL
  SELECT 6600 + ROW_NUMBER() OVER (ORDER BY TP.SCHEMA_NAME, TP.TABLE_NAME, TP.PART_ID) / 100, 
    RPAD(MAP(TP.PART_ID, 1, TP.SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) || RPAD(TP.TABLE_NAME || CHAR(32) || '(' || TP.PART_ID || ')', TABLE_LEN) || CHAR(32) || LPAD(TO_DECIMAL(TP.MEM_SIZE_GB, 10, 2), 11) || CHAR(32) || 
    LPAD(TP.RECORDS, 12) || CHAR(32) || RPAD(TP.LOAD_UNIT, 9) || CHAR(32) || RPAD(TP.LEVEL_1_PARTITIONING, L1_LEN) || CHAR(32) || RPAD(TP.LEVEL_2_PARTITIONING, L2_LEN)
  FROM ACCESSED_PARTITIONS TP, BASIS_INFO BI 
  WHERE MAX_RESULT_LINES = -1 OR PART_ID <= MAX_RESULT_LINES
  UNION ALL
  SELECT TOP 1 6690, ''                            FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6691, '***************************' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6692, '* REFERENTIAL CONSTRAINTS *' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6693, '***************************' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6694, ''                            FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6695, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || LPAD('POS', 3) || CHAR(32) ||
    RPAD('REF_SCHEMA_NAME', 19) || CHAR(32) || RPAD('REF_TABLE_NAME', REF_TABLE_LEN) || CHAR(32) || RPAD('REF_COLUMN_NAME', REF_COLUMN_LEN) FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6696, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || LPAD('=', COLUMN_LEN, '=') || CHAR(32) || LPAD('=', 3, '=') || CHAR(32) ||
    RPAD('=', 19, '=') || CHAR(32) || RPAD('=', REF_TABLE_LEN, '=') || CHAR(32) || LPAD('=', REF_COLUMN_LEN, '=') FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT 6700 + ROW_NUMBER() OVER (ORDER BY AC.SCHEMA_NAME, AC.TABLE_NAME, AC.POSITION) / 100, RPAD(AC.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(AC.TABLE_NAME, TABLE_LEN) || CHAR(32) ||
    RPAD(AC.COLUMN_NAME, COLUMN_LEN) || CHAR(32) || LPAD(AC.POSITION, 3) || CHAR(32) || RPAD(AC.REFERENCED_SCHEMA_NAME, 20) || 
    RPAD(AC.REFERENCED_TABLE_NAME, REF_TABLE_LEN) || CHAR(32) || RPAD(AC.REFERENCED_COLUMN_NAME, REF_COLUMN_LEN)
  FROM
    ACCESSED_REFERENTIAL_CONSTRAINTS AC UNION ALL
  SELECT TOP 1 6790, ''             FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6791, '************' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6792, '* TRIGGERS *' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6793, '************' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6794, ''             FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6795, RPAD('TRIGGER_NAME', TRIGGER_LEN) || CHAR(32) || RPAD('ACTION_TIME', 11) || CHAR(32) || RPAD('EVENT', 6) || CHAR(32) || 
    RPAD('ACTION_LEVEL', 12) || CHAR(32) || RPAD('IS_VALID', 8) || CHAR(32) || RPAD('IS_ENABLED', 10) || CHAR(32) || RPAD('CREATE_TIME', 19) FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6796, RPAD('=', TRIGGER_LEN, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) || 
    RPAD('=', 12, '=') || CHAR(32) || RPAD('=', 8, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 19, '=') FROM ACCESSED_TRIGGERS UNION ALL
  SELECT 6800 + ROW_NUMBER() OVER (ORDER BY TRIGGER_NAME) / 100, RPAD(TRIGGER_NAME, TRIGGER_LEN) || CHAR(32) || RPAD(TRIGGER_ACTION_TIME, 11) || CHAR(32) || RPAD(TRIGGER_EVENT, 6) || CHAR(32) ||
    RPAD(TRIGGERED_ACTION_LEVEL, 12) || CHAR(32) || RPAD(IS_VALID, 8) || CHAR(32) || RPAD(IS_ENABLED, 10) || CHAR(32) || RPAD(CREATE_TIME, 19)
  FROM
    ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6990, ''                   FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7000, '******************' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7010, '* TABLE REPLICAS *' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7020, '******************' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7030, ''                   FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7080, RPAD('HOST', 29) || CHAR(32) || RPAD('SOURCE_SCHEMA_NAME', SRC_SCHEMA_LEN) || CHAR(32) || RPAD('SOURCE_TABLE_NAME', SRC_TABLE_LEN) || CHAR(32) || LPAD('PART_ID', 7) ||
    CHAR(32) || RPAD('REPLICA_TYPE', 13) || CHAR(32) || 'REPLICA_NAME' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7090, RPAD('=', 29, '=') || CHAR(32) || RPAD('=', SRC_SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', SRC_TABLE_LEN, '=') || CHAR(32) || LPAD('=', 7, '=') ||
    CHAR(32) || RPAD('=', 13, '=') || CHAR(32) || RPAD('=', 50, '=') FROM ACCESSED_REPLICAS UNION ALL
  SELECT 7100 + ROW_NUMBER() OVER (ORDER BY R.SOURCE_SCHEMA_NAME, R.SOURCE_TABLE_NAME, R.PART_ID, R.HOST) / 1000, RPAD(R.HOST, 30) || RPAD(R.SOURCE_SCHEMA_NAME, SRC_SCHEMA_LEN) || CHAR(32) ||
    RPAD(R.SOURCE_TABLE_NAME, SRC_TABLE_LEN) || CHAR(32) || LPAD(R.PART_ID, 7) || CHAR(32) || RPAD(R.REPLICA_TYPE, 13) || CHAR(32) || R.TABLE_NAME
  FROM
    ACCESSED_REPLICAS R UNION ALL
  SELECT TOP 1 7190, ''                       FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7200, '**********************' FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7210, '* TRANSLATION TABLES *' FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7220, '**********************' FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7230, ''                       FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7280, RPAD('SCHEMA_NAME_1', SCHEMA_NAME_1_LEN) || CHAR(32) || RPAD('TABLE_NAME_1', TABLE_NAME_1_LEN) || CHAR(32) || RPAD('COLUMN_NAME_1', COLUMN_NAME_1_LEN) || CHAR(32) ||
    RPAD('SCHEMA_NAME_2', SCHEMA_NAME_2_LEN) || CHAR(32) || RPAD('TABLE_NAME_2', TABLE_NAME_2_LEN) || CHAR(32) || RPAD('COLUMN_NAME_2', COLUMN_NAME_2_LEN) || CHAR(32) ||
    LPAD('NUM_TTS', 7) || CHAR(32) || LPAD('SIZE_MB', 9) FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7290, RPAD('=', SCHEMA_NAME_1_LEN, '=') || CHAR(32) || RPAD('=', TABLE_NAME_1_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_NAME_1_LEN, '=') || CHAR(32) ||
    RPAD('=', SCHEMA_NAME_2_LEN, '=') || CHAR(32) || RPAD('=', TABLE_NAME_2_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_NAME_2_LEN, '=') || CHAR(32) ||
    LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 9, '=') FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT 7300 + ROW_NUMBER() OVER (ORDER BY NUM_TTS DESC, SIZE_MB DESC) / 100, RPAD(SCHEMA_NAME_1, SCHEMA_NAME_1_LEN) || CHAR(32) || RPAD(TABLE_NAME_1, TABLE_NAME_1_LEN) || CHAR(32) || RPAD(COLUMN_NAME_1, COLUMN_NAME_1_LEN) || CHAR(32) ||
    RPAD(SCHEMA_NAME_2, SCHEMA_NAME_2_LEN) || CHAR(32) || RPAD(TABLE_NAME_2, TABLE_NAME_2_LEN) || CHAR(32) || RPAD(COLUMN_NAME_2, COLUMN_NAME_2_LEN) || CHAR(32) ||
    LPAD(NUM_TTS, 7) || CHAR(32) || LPAD(SIZE_MB, 9) FROM ACCESSED_TRANSLATION_TABLES UNION ALL
  SELECT TOP 1 7490, ''                        FROM TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7500, '***********************' FROM TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7510, '* TABLE OPTIMIZATIONS *' FROM TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7520, '***********************' FROM TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7530, ''                        FROM TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7580, RPAD('OPTIMIZATION_TIME', 20) || RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) ||
    RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('TYPE', 14) || CHAR(32) || RPAD('MOTIVATION', 10) || LPAD('MERGED_ROWS', 12) || 
    LPAD('RUNTIME_S', 10) || CHAR(32) || 'LAST_ERROR' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7590, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') ||
    CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || LPAD('=', 11, '=') ||
    CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || RPAD('=', 70, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), TABLE_OPTIMIZATIONS UNION ALL
  SELECT 7600 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC, SCHEMA_NAME, TABLE_NAME) / 1000, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || 
    RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) ||
    RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(TYPE, 14) || CHAR(32) || RPAD(MOTIVATION, 10) || LPAD(MERGED_ROWS, 12) || LPAD(RUNTIME_S, 10) || CHAR(32) || LAST_ERROR
  FROM
    ( SELECT HOST_LEN FROM BASIS_INFO ), 
    TABLE_OPTIMIZATIONS
  WHERE
  ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 7690, ''                      FROM UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7700, '*********************' FROM UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7710, '* UNLOADS AND LOADS *' FROM UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7720, '*********************' FROM UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7730, ''                      FROM UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7780, RPAD('ACTION_TIME', 20) || RPAD('TYPE', 7) || RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) ||
    RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) ||
    LPAD('DURATION_MS', 11) || CHAR(32) || RPAD('REASON_OR_HASH', 33) || 'ERROR' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), UNLOADS_AND_LOADS UNION ALL
  SELECT TOP 1 7790, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') ||
    CHAR(32) || RPAD('=', COLUMN_LEN, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || RPAD('=', 32, '=') ||
    CHAR(32) || RPAD('=', 60, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), UNLOADS_AND_LOADS UNION ALL
  SELECT 7800 + ROW_NUMBER() OVER (ORDER BY ACTION_TIME DESC, SCHEMA_NAME, TABLE_NAME) / 1000, RPAD(TO_VARCHAR(ACTION_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(TYPE, 7) ||
    RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(COLUMN_NAME, COLUMN_LEN) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(MAP(DURATION_MS, -1, 'n/a', 
    TO_VARCHAR(DURATION_MS)), 11) || CHAR(32) || RPAD(REASON_OR_HASH, 33) || ERROR
  FROM
    ( SELECT HOST_LEN FROM BASIS_INFO ),
     UNLOADS_AND_LOADS
  WHERE
  ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 8690, ''                              FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8700, '*****************************' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8710, '* EXECUTED STATEMENTS TRACE *' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8720, '*****************************' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8730, ''                              FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8780, RPAD('START_TIME', 19) || CHAR(32) || LPAD('DURATION_S', 11) ||  CHAR(32) || LPAD('ERROR', 5) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || 
    RPAD('APP_SOURCE', APP_SOURCE_LEN) || CHAR(32) || RPAD('STATEMENT_STRING', 80) FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8790, RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || 
    RPAD('=', APP_SOURCE_LEN, '=') || CHAR(32) || RPAD('=', 80, '=') FROM EXECUTED_STATEMENTS UNION ALL
  SELECT 8800 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC) / 100, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) ||
    LPAD(TO_VARCHAR(TO_DECIMAL(DURATION_MICROSEC / 1000000, 10, 2)), 11) || LPAD(ERROR_CODE, 6) || CHAR(32) || RPAD(APP_USER, APP_USER_LEN) || CHAR(32) || 
    RPAD(APPLICATION_SOURCE, APP_SOURCE_LEN) || CHAR(32) || SUBSTR(STATEMENT_STRING, 1, 100) 
  FROM
    EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 22490, ''                                      FROM DATA_STATS UNION ALL
  SELECT TOP 1 22500, '*************************************' FROM DATA_STATS UNION ALL
  SELECT TOP 1 22510, '* USER-DEFINED OPTIMIZER STATISTICS *' FROM DATA_STATS UNION ALL
  SELECT TOP 1 22520, '*************************************' FROM DATA_STATS UNION ALL
  SELECT TOP 1 22530, ''                                      FROM DATA_STATS UNION ALL
  SELECT TOP 1 22580, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('OBJECT_NAME', OBJECT_LEN) || CHAR(32) || RPAD('COLUMN_NAMES', COLUMN_LEN) || CHAR(32) ||
    RPAD('TYPE', TYPE_LEN) || CHAR(32) || LPAD('COUNT', 12) || CHAR(32) || LPAD('NUM_DISTINCT', 12) || CHAR(32) || LPAD('NUM_NULLS', 10) || CHAR(32) ||
    RPAD('MIN_VALUE', MIN_VALUE_LEN) || CHAR(32) || RPAD('MAX_VALUE', MAX_VALUE_LEN) FROM DATA_STATS UNION ALL
  SELECT TOP 1 22590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', OBJECT_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_LEN, '=') || CHAR(32) ||
    RPAD('=', TYPE_LEN, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', MIN_VALUE_LEN, '=') || CHAR(32) || RPAD('=', MAX_VALUE_LEN, '=') FROM DATA_STATS UNION ALL
  SELECT 22600 + ROW_NUMBER() OVER (ORDER BY DATA_SOURCE_SCHEMA_NAME, OBJECT_NAME, DATA_SOURCE_COLUMN_NAMES), 
    RPAD(DATA_SOURCE_SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(OBJECT_NAME, OBJECT_LEN) || CHAR(32) || RPAD(DATA_SOURCE_COLUMN_NAMES, COLUMN_LEN) || CHAR(32) ||
    RPAD(DATA_STATISTICS_TYPE, TYPE_LEN) || CHAR(32) || LPAD(COUNT, 12) || CHAR(32) || LPAD(DISTINCT_COUNT, 12) || CHAR(32) || LPAD(NULL_COUNT, 10) || CHAR(32) ||
    RPAD(IFNULL(MINVALUE_STRING, ''), MIN_VALUE_LEN) || CHAR(32) || RPAD(IFNULL(MAXVALUE_STRING, ''), MAX_VALUE_LEN) FROM DATA_STATS
  WHERE
  ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES )
UNION ALL SELECT TOP 1 30000, '' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 30010, '***********************' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 30020, '* TRANSACTIONAL LOCKS *' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 30030, '***********************' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 30040, '' FROM TRANSACTIONAL_LOCKS
UNION ALL SELECT TOP 1 30050, RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || 
    RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('LOCK_MODE', 16) || CHAR(32) || 
    LPAD('LOCK_COUNT', 10) || CHAR(32) || RPAD('ACQUIRED_TIME', 19) FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCKS ) C
UNION ALL SELECT 30060, RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || 
    RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 16, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 19, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM TRANSACTIONAL_LOCKS ) C
UNION ALL
SELECT
  30100 + ROW_NUMBER () OVER (ORDER BY TL.LOCK_COUNT DESC, TL.HOST, TL.SCHEMA_NAME, TL.TABLE_NAME) / 100,
  RPAD(HOST, BI.HOST_LEN) || CHAR(32) || RPAD(TL.SCHEMA_NAME, TL.SCHEMA_LEN) || CHAR(32) || 
    RPAD(TL.TABLE_NAME, TL.TABLE_LEN) || CHAR(32) || RPAD(TL.LOCK_MODE, 16) || CHAR(32) || 
    LPAD(TL.LOCK_COUNT, 10) || CHAR(32) || RPAD(TL.ACQUIRED_TIME, 19)
FROM
  BASIS_INFO BI,
  ( SELECT
      TL.*,
      ROW_NUMBER () OVER (ORDER BY TL.LOCK_COUNT DESC, TL.HOST, TL.SCHEMA_NAME, TL.TABLE_NAME) ROWNO
    FROM
      TRANSACTIONAL_LOCKS TL
  ) TL
WHERE
  BI.MAX_RESULT_LINES = -1 OR TL.ROWNO <= BI.MAX_RESULT_LINES
UNION ALL SELECT TOP 1 60000, '' FROM SQL_CACHE
UNION ALL SELECT TOP 1 60010, '*************' FROM SQL_CACHE
UNION ALL SELECT TOP 1 60020, '* SQL CACHE *' FROM SQL_CACHE
UNION ALL SELECT TOP 1 60030, '*************' FROM SQL_CACHE
UNION ALL SELECT TOP 1 60040, '' FROM SQL_CACHE
UNION ALL SELECT TOP 1 60050, RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('STATEMENT_HASH', 32) || CHAR(32) || 
    LPAD('EXECUTIONS', 10) || CHAR(32) || LPAD('TOTAL_CURS_S', 12) || CHAR(32) || 
    LPAD('AVG_CURS_MS', 11) || CHAR(32) || LPAD('TOTAL_EXEC_S', 12) || CHAR(32) || LPAD('AVG_EXEC_MS', 11) || CHAR(32) || LPAD('AVG_RECORDS', 11) || CHAR(32) ||
    LPAD('AVG_LOCK_MS', 11) || CHAR(32) || LPAD('AVG_PREP_MS', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) || CHAR(32) ||
    RPAD('APP_NAME', C.APP_NAME_LEN) || CHAR(32) || RPAD('APP_SOURCE', 50) FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE ) C
UNION ALL SELECT 60060, RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', C.APP_NAME_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE ) C
UNION ALL
SELECT
  60100 + ROWNO / 100,
  RPAD(C.HOST, BI.HOST_LEN) || CHAR(32) || RPAD(C.STATEMENT_HASH, 32) || CHAR(32) || LPAD(C.EXECUTIONS, 10) || CHAR(32) || LPAD(C.TOT_CURS_S, 12) || CHAR(32) || 
    LPAD(C.AVG_CURS_MS, 11) || CHAR(32) || LPAD(C.TOT_EXEC_S, 12) || CHAR(32) || LPAD(C.AVG_EXEC_MS, 11) || CHAR(32) || LPAD(C.AVG_RECORDS, 11) || CHAR(32) ||
    LPAD(C.AVG_LOCK_MS, 11) || CHAR(32) || LPAD(C.AVG_PREP_MS, 11) || CHAR(32) || LPAD(C.AVG_MEM_MB, 10) || CHAR(32) ||
    RPAD(C.APP_NAME, C.APP_NAME_LEN) || CHAR(32) || C.APP_SOURCE
FROM
  BASIS_INFO BI,
  ( SELECT
      C.*,
      ROW_NUMBER () OVER (ORDER BY C.TOT_EXEC_S DESC) ROWNO
    FROM
      SQL_CACHE C
  ) C
WHERE
  BI.MAX_RESULT_LINES = -1 OR C.ROWNO <= BI.MAX_RESULT_LINES
UNION ALL SELECT TOP 1 60240, '' FROM SQL_CACHE_HIST_HOUR
UNION ALL SELECT TOP 1 60250, RPAD('HOUR', 19) || CHAR(32) || LPAD('EXECUTIONS', 10) || CHAR(32) || LPAD('TOTAL_CURS_S', 12) || CHAR(32) || 
    LPAD('AVG_CURS_MS', 11) || CHAR(32) || LPAD('TOTAL_EXEC_S', 12) || CHAR(32) || LPAD('AVG_EXEC_MS', 11) || CHAR(32) || LPAD('AVG_RECORDS', 11) || CHAR(32) ||
    LPAD('AVG_LOCK_MS', 11) || CHAR(32) || LPAD('AVG_PREP_MS', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE_HIST_HOUR ) C
UNION ALL SELECT 60260, RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE_HIST_HOUR ) C
UNION ALL
SELECT
  60300 + ROWNO / 100,
  RPAD(C.HOUR, 19) || CHAR(32) || LPAD(C.EXECUTIONS, 10) || CHAR(32) || LPAD(C.TOT_CURS_S, 12) || CHAR(32) || 
    LPAD(C.AVG_CURS_MS, 11) || CHAR(32) || LPAD(C.TOT_EXEC_S, 12) || CHAR(32) || LPAD(C.AVG_EXEC_MS, 11) || CHAR(32) || LPAD(C.AVG_RECORDS, 11) || CHAR(32) ||
    LPAD(C.AVG_LOCK_MS, 11) || CHAR(32) || LPAD(C.AVG_PREP_MS, 11) || CHAR(32) || LPAD(C.AVG_MEM_MB, 10)
FROM
  BASIS_INFO BI,
  ( SELECT
      C.*,
      ROW_NUMBER () OVER (ORDER BY C.HOUR DESC) ROWNO
    FROM
      SQL_CACHE_HIST_HOUR C
  ) C
WHERE
  BI.MAX_RESULT_LINES = -1 OR C.ROWNO <= BI.MAX_RESULT_LINES
UNION ALL SELECT TOP 1 60440, '' FROM SQL_CACHE_HIST_DAY
UNION ALL SELECT TOP 1 60450, RPAD('DAY', 19) || CHAR(32) || LPAD('EXECUTIONS', 10) || CHAR(32) || LPAD('TOTAL_CURS_S', 12) || CHAR(32) || 
    LPAD('AVG_CURS_MS', 11) || CHAR(32) || LPAD('TOTAL_EXEC_S', 12) || CHAR(32) || LPAD('AVG_EXEC_MS', 11) || CHAR(32) || LPAD('AVG_RECORDS', 11) || CHAR(32) ||
    LPAD('AVG_LOCK_MS', 11) || CHAR(32) || LPAD('AVG_PREP_MS', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE_HIST_DAY ) C
UNION ALL SELECT 60460, RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) ||
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') FROM BASIS_INFO, ( SELECT TOP 1 * FROM SQL_CACHE_HIST_DAY ) C
UNION ALL
SELECT
  60500 + ROWNO / 100,
  RPAD(C.DAY, 19) || CHAR(32) || LPAD(C.EXECUTIONS, 10) || CHAR(32) || LPAD(C.TOT_CURS_S, 12) || CHAR(32) || 
    LPAD(C.AVG_CURS_MS, 11) || CHAR(32) || LPAD(C.TOT_EXEC_S, 12) || CHAR(32) || LPAD(C.AVG_EXEC_MS, 11) || CHAR(32) || LPAD(C.AVG_RECORDS, 11) || CHAR(32) ||
    LPAD(C.AVG_LOCK_MS, 11) || CHAR(32) || LPAD(C.AVG_PREP_MS, 11) || CHAR(32) || LPAD(C.AVG_MEM_MB, 10)
FROM
  BASIS_INFO BI,
  ( SELECT
      C.*,
      ROW_NUMBER () OVER (ORDER BY C.DAY DESC) ROWNO
    FROM
      SQL_CACHE_HIST_DAY C
  ) C
WHERE
  BI.MAX_RESULT_LINES = -1 OR C.ROWNO <= BI.MAX_RESULT_LINES
  UNION ALL
  SELECT TOP 1 64990, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65000, '******************' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65010, '* THREAD SAMPLES *' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65020, '******************' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('STATEMENT_HASH', 32) || CHAR(32) || 
    RPAD('ROOT_STATEMENT_HASH', 32) || CHAR(32) || 'STATEMENT_STRING' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 65090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || 
    RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 65100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(STATEMENT_HASH, 32) || CHAR(32) ||
    RPAD(ROOT_STATEMENT_HASH, 32) || CHAR(32) || IFNULL(STATEMENT_STRING, '')
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      STATEMENT_HASH,
      ROOT_STATEMENT_HASH,
      ( SELECT MAX(SUBSTR(STATEMENT_STRING, 1, 1000)) FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE SP WHERE SP.STATEMENT_HASH = T.ROOT_STATEMENT_HASH ) STATEMENT_STRING,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, ROOT_STATEMENT_HASH) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.STATEMENT_HASH,
        TS.ROOT_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.STATEMENT_HASH,
        TS.ROOT_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
    ) T
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 67030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 67080, RPAD('HOUR', 19) || CHAR(32) || LPAD('SAMPLES', 7) || CHAR(32) || 
    LPAD('RUN_ST_PCT', 10) || CHAR(32) || LPAD('NET_ST_PCT', 10) || CHAR(32) || LPAD('OTH_ST_PCT', 10) || CHAR(32) ||
    LPAD('SQL_TP_PCT', 10) || CHAR(32) || LPAD('JOB_TP_PCT', 10) || CHAR(32) || LPAD('OTH_TP_PCT', 10) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 67090, LPAD('=', 19, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 67100 + ROW_NUM / 100, RPAD(HOUR, 19) || CHAR(32) || LPAD(SAMPLES, 7) || CHAR(32) || 
    LPAD(RUN_ST_PCT, 10) || CHAR(32) || LPAD(NET_ST_PCT, 10) || CHAR(32) || LPAD(OTH_ST_PCT, 10) || CHAR(32) ||
    LPAD(SQL_TP_PCT, 10) || CHAR(32) || LPAD(JOB_TP_PCT, 10) || CHAR(32) || LPAD(OTH_TP_PCT, 10) 
  FROM
  ( SELECT
      HOUR,
      SAMPLES,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(RUNNING / SAMPLES * 100, 10, 2)) RUN_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(NETWORK / SAMPLES * 100, 10, 2)) NET_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL((SAMPLES - RUNNING - NETWORK) / SAMPLES * 100, 10, 2)) OTH_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(SQLEXECUTORS / SAMPLES * 100, 10, 2)) SQL_TP_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(JOBWORKERS / SAMPLES * 100, 10, 2)) JOB_TP_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL((SAMPLES - SQLEXECUTORS - JOBWORKERS) / SAMPLES * 100, 10, 2)) OTH_TP_PCT,
      ROW_NUMBER () OVER (ORDER BY HOUR DESC) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        TO_VARCHAR(TS.TIMESTAMP, 'YYYY/MM/DD HH24') HOUR,
        SUM(TS.SAMPLES) SAMPLES,
        SUM(MAP(TS.THREAD_STATE, 'Running', TS.SAMPLES, 0)) RUNNING,
        SUM(MAP(SUBSTR(TS.THREAD_STATE, 1, 7), 'Network', TS.SAMPLES, 0)) NETWORK,
        SUM(MAP(TS.THREAD_TYPE, 'SqlExecutor', TS.SAMPLES, 0)) SQLEXECUTORS,
        SUM(MAP(TS.THREAD_TYPE, 'JobWorker', TS.SAMPLES, 0)) JOBWORKERS,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TO_VARCHAR(TS.TIMESTAMP, 'YYYY/MM/DD HH24'),
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 69030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 69080, RPAD('DAY', 19) || CHAR(32) || LPAD('SAMPLES', 7) || CHAR(32) || 
    LPAD('RUN_ST_PCT', 10) || CHAR(32) || LPAD('NET_ST_PCT', 10) || CHAR(32) || LPAD('OTH_ST_PCT', 10) || CHAR(32) ||
    LPAD('SQL_TP_PCT', 10) || CHAR(32) || LPAD('JOB_TP_PCT', 10) || CHAR(32) || LPAD('OTH_TP_PCT', 10) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 69090, LPAD('=', 19, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || 
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 69100 + ROW_NUM / 100, RPAD(DAY, 19) || CHAR(32) || LPAD(SAMPLES, 7) || CHAR(32) || 
    LPAD(RUN_ST_PCT, 10) || CHAR(32) || LPAD(NET_ST_PCT, 10) || CHAR(32) || LPAD(OTH_ST_PCT, 10) || CHAR(32) ||
    LPAD(SQL_TP_PCT, 10) || CHAR(32) || LPAD(JOB_TP_PCT, 10) || CHAR(32) || LPAD(OTH_TP_PCT, 10) 
  FROM
  ( SELECT
      DAY,
      SAMPLES,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(RUNNING / SAMPLES * 100, 10, 2)) RUN_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(NETWORK / SAMPLES * 100, 10, 2)) NET_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL((SAMPLES - RUNNING - NETWORK) / SAMPLES * 100, 10, 2)) OTH_ST_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(SQLEXECUTORS / SAMPLES * 100, 10, 2)) SQL_TP_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL(JOBWORKERS / SAMPLES * 100, 10, 2)) JOB_TP_PCT,
      MAP(SAMPLES, 0, 0, TO_DECIMAL((SAMPLES - SQLEXECUTORS - JOBWORKERS) / SAMPLES * 100, 10, 2)) OTH_TP_PCT,
      ROW_NUMBER () OVER (ORDER BY DAY DESC) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        TO_VARCHAR(TS.TIMESTAMP, 'YYYY/MM/DD') DAY,
        SUM(TS.SAMPLES) SAMPLES,
        SUM(MAP(TS.THREAD_STATE, 'Running', TS.SAMPLES, 0)) RUNNING,
        SUM(MAP(SUBSTR(TS.THREAD_STATE, 1, 7), 'Network', TS.SAMPLES, 0)) NETWORK,
        SUM(MAP(TS.THREAD_TYPE, 'SqlExecutor', TS.SAMPLES, 0)) SQLEXECUTORS,
        SUM(MAP(TS.THREAD_TYPE, 'JobWorker', TS.SAMPLES, 0)) JOBWORKERS,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TO_VARCHAR(TS.TIMESTAMP, 'YYYY/MM/DD'),
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 70270, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70280, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('PORT', 5) || CHAR(32) || 'THREAD_TYPE' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70290, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 5, '=') || CHAR(32) || RPAD('=', 30, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), THREAD_SAMPLES UNION ALL
  SELECT 70300 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(PORT, 5) || CHAR(32) || THREAD_TYPE
  FROM
  ( SELECT HOST_LEN FROM BASIS_INFO ), 
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      HOST,
      PORT,
      THREAD_TYPE,
      MAX_RESULT_LINES,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, HOST, PORT, THREAD_TYPE) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.HOST,
        TS.PORT,
        TS.THREAD_TYPE,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.HOST,
        TS.PORT,
        TS.THREAD_TYPE,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 70470, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70480, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_STATE', STATE_LEN) || CHAR(32) || RPAD('LOCK_NAME', 70) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70490, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', STATE_LEN, '=') || CHAR(32) || RPAD('=', 70, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 70500 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_STATE, STATE_LEN) || CHAR(32) || LOCK_NAME
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      THREAD_STATE,
      LOCK_NAME,
      MAX_RESULT_LINES,
      MAX(LENGTH(THREAD_STATE)) OVER () STATE_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, THREAD_STATE, LOCK_NAME) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.THREAD_STATE,
        TS.LOCK_NAME,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.THREAD_STATE,
        TS.LOCK_NAME,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 70730, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70780, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_TYPE', TYPE_LEN) || CHAR(32) || RPAD('THREAD_METHOD', 50) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 70790, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', TYPE_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 70800 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_TYPE, TYPE_LEN) || CHAR(32) || THREAD_METHOD
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      THREAD_TYPE,
      THREAD_METHOD,
      TYPE_LEN,
      MAX_RESULT_LINES,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, THREAD_TYPE, THREAD_METHOD) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.THREAD_TYPE,
        TS.THREAD_METHOD,
        TS.TYPE_LEN,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.THREAD_TYPE,
        TS.THREAD_METHOD,
        TS.TYPE_LEN,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 71030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 71080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_TYPE', TYPE_LEN) || CHAR(32) || RPAD('THREAD_METHOD', METHOD_LEN) || CHAR(32) || 
    RPAD('THREAD_DETAIL', 80) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 71090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', TYPE_LEN, '=') || CHAR(32) || RPAD('=', METHOD_LEN, '=') || CHAR(32) || 
    RPAD('=', 80, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 71100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_TYPE, TYPE_LEN) || CHAR(32) || RPAD(THREAD_METHOD, METHOD_LEN) || CHAR(32) || THREAD_DETAIL
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      THREAD_TYPE,
      THREAD_METHOD,
      THREAD_DETAIL,
      MAX_RESULT_LINES,
      TYPE_LEN,
      METHOD_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, THREAD_TYPE, THREAD_METHOD, THREAD_DETAIL) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.THREAD_TYPE,
        TS.THREAD_METHOD,
        TS.THREAD_DETAIL,
        TS.TYPE_LEN,
        TS.METHOD_LEN,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.THREAD_TYPE,
        TS.THREAD_METHOD,
        TS.THREAD_DETAIL,
        TS.TYPE_LEN,
        TS.METHOD_LEN,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 72030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 72080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('DB_USER', DB_USER_LEN) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || 
    RPAD('APP_NAME', APP_NAME_LEN) || CHAR(32) || RPAD('APP_SOURCE', 50) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 72090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', DB_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || 
    RPAD('=', APP_NAME_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 72100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(DB_USER, DB_USER_LEN) || CHAR(32) || RPAD(APP_USER, APP_USER_LEN) || CHAR(32) ||
    RPAD(APP_NAME, APP_NAME_LEN) || CHAR(32) || APP_SOURCE
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      DB_USER,
      APP_USER,
      APP_NAME,
      APP_SOURCE,
      MAX_RESULT_LINES,
      DB_USER_LEN,
      APP_USER_LEN,
      APP_NAME_LEN,
      APP_SOURCE_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, DB_USER, APP_USER, APP_NAME, APP_SOURCE) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.DB_USER,
        TS.APP_USER,
        TS.APP_NAME,
        TS.APP_SOURCE,
        TS.DB_USER_LEN,
        TS.APP_USER_LEN,
        TS.APP_NAME_LEN,
        TS.APP_SOURCE_LEN,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.DB_USER,
        TS.APP_USER,
        TS.APP_NAME,
        TS.APP_SOURCE,
        TS.DB_USER_LEN,
        TS.APP_USER_LEN,
        TS.APP_NAME_LEN,
        TS.APP_SOURCE_LEN,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 72330, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 72380, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('CLIENT_IP', 15) || CHAR(32) || LPAD('CLIENT_PID', 10) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 72390, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || RPAD('=', 10, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 72400 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(CLIENT_IP, 15) || CHAR(32) || LPAD(CLIENT_PID, 10)
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      CLIENT_IP,
      CLIENT_PID,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, CLIENT_IP, CLIENT_PID) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.CLIENT_IP,
        TS.CLIENT_PID,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.CLIENT_IP,
        TS.CLIENT_PID,
        BI.MAX_RESULT_LINES
    ) T
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 73030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 73080, LPAD('AVG_PARALLELISM', 15) || CHAR(32) || LPAD('MAX_PARALLELISM', 15) || CHAR(32) || LPAD('MAX_TOTAL_THREADS', 30) || CHAR(32) || LPAD('MAX_TOTAL_RUNNING_THREADS', 30) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 73090, LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 30, '=') || CHAR(32) || LPAD('=', 30, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 73100, LPAD(TO_DECIMAL(AVG_PARALLELISM, 10, 2), 15) || CHAR(32) || LPAD(MAX_PARALLELISM, 15) || CHAR(32) || LPAD(MAX_THREADS, 30) || CHAR(32) || LPAD(MAX_RUNNING_THREADS, 30) FROM
  ( SELECT
      IFNULL(AVG(NUM), 0) AVG_PARALLELISM,
      IFNULL(MAX(NUM), 0) MAX_PARALLELISM
    FROM
    ( SELECT
        SUM(SAMPLES) NUM
      FROM
        THREAD_SAMPLES
      WHERE
        THREAD_TYPE = 'JobWorker'
      GROUP BY
        TIMESTAMP,
        CONNECTION_ID
    )
  ),
  ( SELECT
      IFNULL(MAX(NUM), 0) MAX_THREADS,
      IFNULL(MAX(NUM_RUNNING), 0) MAX_RUNNING_THREADS
    FROM
    ( SELECT
        SUM(SAMPLES) NUM,
        SUM(MAP(THREAD_STATE, 'Running', SAMPLES, 0)) NUM_RUNNING
      FROM
        THREAD_SAMPLES
      GROUP BY
        TIMESTAMP
    )
  )
  WHERE
    MAX_THREADS > 0 
  UNION ALL SELECT 1000000, '' FROM DUMMY
  UNION ALL SELECT 1000010, '****************************************' FROM DUMMY
  UNION ALL SELECT 1000020, '* END OF SAP HANA TABLE DATA COLLECTOR *' FROM DUMMY
  UNION ALL SELECT 1000030, '****************************************' FROM DUMMY
) L
ORDER BY
  LINE_NO
WITH HINT (IGNORE_PLAN_CACHE)