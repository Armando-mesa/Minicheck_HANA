WITH

/*

[NAME]

- HANA_SQL_StatementHash_DataCollector_2.00.070+

[DESCRIPTION]

- Collection of details for a specific SQL statement

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_TABLE_REPLICAS available starting with 1.00.120
- M_ADMISSION_CONTROL_EVENTS available starting with 2.00.010
- M_MULTIDIMENSIONAL_STATEMENT_STATISTICS available starting with 1.00.122.16 and 2.00.024.01
- Running this command with SAP HANA 2.0 Revisions before 2.00.024.01 will fail with:

  Could not find table/view M_MULTIDIMENSIONAL_STATEMENT_STATISTICS

- M_CE_CALCSCENARIO_HINTS available starting with 2.00.030
- HOST_SQL_PLAN_CACHE.APPLICATION_SOURCE available starting with 1.00.122.21, 2.00.024.06 and 2.00.034
- M_CS_LOADS.STATEMENT_HASH and ROOT_STATEMENT_HASH available starting with SAP HANA 2.00.040
- EXECUTION_ENGINE in M_SQL_PLAN_CACHE and HOST_SQL_PLAN_CACHE available with SAP HANA >= 2.00.053
- Columns RESOURCE_WAIT_TIME, PHASE_1_HESITANT_LOCK_WAIT_TIME, PHASE_1_BLOCKING_LOCK_WAIT_TIME, 
  PHASE_1_LOCK_TIME, PHASE_2_HESITANT_LOCK_WAIT_TIME, PHASE_2_BLOCKING_LOCK_WAIT_TIME and PHASE_2_LOCK_TIME
  of HOST_DELTA_MERGE_STATISTICS available with SAP HANA >= 2.00.059.01.
- SITE_ID in history tables available with SAP HANA >= 2.0 SPS 06, only primary site is evaluated
- Thread information APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE available with SAP HANA >= 2.00.070
- AVG_BUFFER_CACHE_IO_READ_SIZE and MAX_BUFFER_CACHE_IO_READ_SIZE in SQL cache available with SAP HANA >= 2.00.070

[VALID FOR]

- Revisions:              >= 2.00.070

[SQL COMMAND VERSION]

- 2017/05/29:  1.0 (initial version)
- 2017/09/21:  1.1 (display of implicit single column indexes, PLAN_ID added to SQL cache overview)
- 2017/10/20:  1.2 (HOST information and CONCAT ATTRIBUTE indexes added)
- 2018/01/08:  1.3 ("PARAMETER SETTINGS" section added)
- 2018/04/11:  1.4 ("CALCULATION VIEWS" and "CALCULATION SCENARIOS" sections added, supression of empty sections)
- 2018/06/04:  1.5 ("TABLE REPLICAS" added, PERCENT added to "THREAD SAMPLES" section)
- 2018/06/05:  1.6 ("TRACE ENTRIES" section added)
- 2018/07/18:  1.7 (current, maximum and minimum disk size added to "TABLE INFORMATION")
- 2018/11/03:  1.8 (dedicated 1.00.122.16+ version including MDS)
- 2018/11/12:  1.9 (dedicated 2.00.030+ version including M_CE_CALCSCENARIO_HINTS)
- 2018/12/04:  2.0 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2018/12/15:  2.1 (M_ADMISSION_CONTROL_EVENTS included)
- 2019/01/30:  2.2 (dedicated 2.00.034+ version including HOST_SQL_PLAN_CACHE.APPLICATION_SOURCE)
- 2019/02/19:  2.3 (REFERENTIAL_CONSTRAINTS included)
- 2019/03/13:  2.4 (PROCEDURES AND ACTIVE PROCEDURES sections included)
- 2019/06/03:  2.5 (dynamic column widths)
- 2019/09/06:  2.6 (annotations added)
- 2019/09/29:  2.7 (DATA_STATISTICS added)
- 2019/12/05:  2.8 (virtual tables added)
- 2019/12/17:  2.9 (translation tables added)
- 2020/02/20:  3.0 (ROOT_STATEMENT_HASH added)
- 2020/03/04:  3.1 (CLIENT_IP / CLIENT_PID added)
- 2020/04/06:  3.2 (LAST_INVALIDATION_REASON added)
- 2020/06/15:  3.3 (M_FEATURE_USAGE added)
- 2020/09/24:  3.4 (CHILD_STATEMENT_HASH overview added)
- 2020/12/23:  3.5 (dedicated 2.00.053+ version including EXECUTION_ENGINE)
- 2021/02/02:  3.6 (M_CS_ALL_COLUMN_STATISTICS.SCANNED_RECORD_COUNT and M_RS_TABLES.SCAN_COUNT added)
- 2021/09/12:  3.7 (PASSPORT_COMPONENT and PASSPORT_ACTION included)
- 2021/10/21:  3.8 (additional PASSPORT_ACTION without PASSPORT_COMPONENT section included)
- 2022/04/24:  3.9 (TRIGGER section included)
- 2022/05/26:  4.0 (dedicated 2.00.060+ version including SITE_ID for data source HISTORY)
- 2022/06/19:  4.1 (DB_USER filter added)
- 2022/07/21:  4.2 (DATABASE VERSION HISTORY section added)
- 2022/08/14:  4.3 (SCHEMA_NAME filter added)
- 2023/10/29:  4.4 (dedicated 2.00.070+ version including APPLICATION_COMPONENT_NAME and APPLICATION_COMPONENT_TYPE)
- 2024/05/24:  4.5 (lock and wait times for table optimizations included)
- 2024/07/11:  4.6 (FUNCTIONS added)

[INVOLVED TABLES]

- ANNOTATIONS
- FUNCTIONS
- HOST_DELTA_MERGE_STATISTICS
- HOST_SERVICE_THREAD_SAMPLES
- HOST_SQL_PLAN_CACHE
- INDEX_COLUMNS
- M_ACTIVE_PROCEDURES
- M_ACTIVE_STATEMENTS
- M_CE_CALCSCENARIO_HINTS
- M_CE_CALCSCENARIOS_OVERVIEW
- M_CE_CALCVIEW_DEPENDENCIES
- M_CONFIGURATION_PARAMETER_VALUES
- M_CS_ALL_COLUMNS
- M_CS_TABLES
- M_DATABASE_HISTORY
- M_DATA_STATISTICS
- M_EXPENSIVE_STATEMENTS
- M_FEATURE_USAGE
- M_INIFILE_CONTENT_HISTORY
- M_JOIN_TRANSLATION_TABLES
- M_MULTIDIMENSIONAL_STATEMENT_STATITICS
- M_RS_TABLES
- M_SERVICE_THREAD_CALLSTACKS
- M_SQL_PLAN_CACHE
- M_SQL_PLAN_CACHE_PARAMETERS
- M_TABLE_REPLICAS
- OBJECT_DEPENDENCIES
- OBJECTS
- PARTITIONED_TABLES
- PINNED_SQL_PLANS
- PROCEDURES
- STATEMENT_HINTS
- TABLE_COLUMNS
- TRIGGERS
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

- STATEMENT_HASH

  Hash of SQL statement to be analyzed (mandatory)

- PLAN_ID

  SQL plan identifier

  12345678       --> SQL plan identifier 12345678
  -1             --> No restriction based on SQL plan identifier

- DB_USER

  Database user, column value may contain a list of several users, so putting '%' around user name can be useful

  'SYSTEM'        --> Database user 'SYSTEM'
  '%'             --> No database user restriction

- SCHEMA_NAME

  Schema name or pattern (be aware that some views cannot be restricted by schema)

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- MAX_RESULT_LINES

  Maximum number of result lines for history sections

  20             --> Return a maximum of 20 lines in the output
  -1             --> No restriction related to result lines

- TRACE_HISTORY_S

  Time frame for checking SAP HANA trace files for statement hash occurrences (s)

  86400          --> Check last 86400 s (1 day) for trace file entries
  -1             --> No trace file check limitation (attention: Can be very expensive)

- LINE_LENGTH

  Maximum length of output lines

  200            --> Limit output lines to a length of 200 characters
  -1             --> No limitation related to output line length

- SHOW_COMPLETE_BIND_VALUE_LIST

  Possibility to display the complete list of bind values

  'X'            --> Show all captured bind values
  ' '            --> Only show the first MAX_RESULT_LINES bind values

- TIME_UNIT

  Unit of total times in the output

  'MS' --> milli seconds
  'S'  --> seconds
  'M'  --> minutes
  'H'  --> hours
  'D'  --> days

[OUTPUT PARAMETERS]

- LINE: Output information

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|LINE                                                                                                                                                                                                    |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|*******************************************                                                                                                                                                             |
|* SAP HANA STATEMENT HASH DATA COLLECTION *                                                                                                                                                             |
|*******************************************                                                                                                                                                             |
|                                                                                                                                                                                                        |
|Analysis time:      2017/05/29 14:47:37                                                                                                                                                                 |
|Generated with:     SQL: "HANA_SQL_StatementHash_DataCollector" (SAP Note 1969700)                                                                                                                      |
|Statement hash:     d589b47003b8db3caf9425ebfaf5b72e                                                                                                                                                    |
|                                                                                                                                                                                                        |
|***************                                                                                                                                                                                         |
|* KEY FIGURES *                                                                                                                                                                                         |
|***************                                                                                                                                                                                         |
|                                                                                                                                                                                                        |
|STAT_NAME                VALUE                             VALUE_PER_EXEC  VALUE_PER_ROW                                                                                                                |
|======================== ================================ =============== ==============                                                                                                                |
|Statement Hash           d589b47003b8db3caf9425ebfaf5b72e                                                                                                                                               |
|Plan ID                  40772250004                                                                                                                                                                    |
|Table type / dist.       COLUMN / local                                                                                                                                                                 |
|Database user name       SAPERP                                                                                                                                                                         |
|Last connection ID       455766                                                                                                                                                                         |
|                                                                                                                                                                                                        |
|Executions                                              3                                                                                                                                               |
|Records                                                 0            0.00                                                                                                                               |
|Preparations                                            0            0.00                                                                                                                               |
|                                                                                                                                                                                                        |
|Elapsed time                                       8.39 h  10077261.05 ms        0.00 ms                                                                                                                |
|Execution time                                     8.39 h  10077261.05 ms        0.00 ms                                                                                                                |
|Preparation time                                   0.00 h         0.00 ms        0.00 ms                                                                                                                |
|Lock wait time                                     0.00 h         0.00 ms        0.00 ms                                                                                                                |
|                                                                                                                                                                                                        |
|******************                                                                                                                                                                                      |
|* STATEMENT TEXT *                                                                                                                                                                                      |
|******************                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
|SELECT / FDA WRITE / DISTINCT  "V_MLHD" . "BELNR" , "V_MLHD" . "KJAHR" , "V_MLHD"                                                                                                                       |
|. "VGART" , "V_MLHD" . "CPUDT" , "V_MLHD" . "CPUTM" , "V_MLHD" . "GLVOR" , "V_MLHD"                                                                                                                     |
|. "STORNO" , "V_MLHD" . "AWREF" , "V_MLHD" . "AWORG" , "V_MLHD" . "AWTYP"                                                                                                                               |
|, "V_MLHD" . "TCODE" FROM / Redirected table: MLHD / "V_MLHD" , X AS "t_00"                                                                                                                             |
|(C_0 NVARCHAR(10), C_1 NVARCHAR(4)) WHERE "V_MLHD" . "MANDT" = X AND "V_MLHD" .                                                                                                                         |
|"BELNR" = "t_00" . "C_0" AND "V_MLHD" . "KJAHR" = "t_00" . "C_1"  WITH RANGE_RESTRICTION('CURRENT')                                                                                                     |
|                                                                                                                                                                                                        |
|***************                                                                                                                                                                                         |
|* BIND VALUES *                                                                                                                                                                                         |
|***************                                                                                                                                                                                         |
|                                                                                                                                                                                                        |
|EXECUTION_TIME      DATA_TYPE       POS BIND_VALUE                                                                                                                                                      |
|=================== ============== ==== ==================================================                                                                                                              |
|                                                                                                                                                                                                        |
|*************                                                                                                                                                                                           |
|* SQL CACHE *                                                                                                                                                                                           |
|*************                                                                                                                                                                                           |
|                                                                                                                                                                                                        |
|CURRENT                  EXECUTIONS        RECORDS   REC_PER_EXEC          ELAPSED_MS   ELA_PER_EXEC_MS    PREPARES     PREPARE_MS        LOCK_MS                                                       |
|==================== ============== ============== ============== =================== ================= =========== ============== ==============                                                       |
|CURRENT                           0              0           0.00                1073              0.00           2           1073              0                                                       |
|2017/05/26 18:42:23               2              0           0.00            29729395    14864697565.50           0              0              0                                                       |
|2017/05/24 12:00:51               1              0           0.00              502388      502388022.00           0              0              0                                                       |
|                                                                                                                                                                                                        |
|*********************                                                                                                                                                                                   |
|* TABLE INFORMATION *                                                                                                                                                                                   |
|*********************                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
|SCHEMA_NAME         TABLE_NAME                              TYPE    PARTS     RECORDS MEM_TOTAL_GB MEM_DELTA_GB                                                                                         |
|=================== ======================================= ====== ====== =========== ============ ============                                                                                         |
|SAPERP              ACDOCA                                  COLUMN      8  5363293802       316.78         5.44                                                                                         |
|SAPERP              BKPF                                    COLUMN      1   488298937        30.51         0.82                                                                                         |
|SAPERP              FINSC_LEDGER                            COLUMN      1           6         0.00         0.00                                                                                         |
|SAPERP              FINS_MIG_STATUS                         COLUMN      1           1         0.00         0.00                                                                                         |
|SAPERP              MLHD                                    COLUMN      1   164711605         6.84         0.23                                                                                         |
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
    STATEMENT_HASH,
    DB_USER,
    SCHEMA_NAME,
    PLAN_ID,
    MAX_RESULT_LINES,
    TRACE_HISTORY_S,
    LINE_LENGTH,
    SHOW_COMPLETE_BIND_VALUE_LIST,
    LOWER(TIME_UNIT) TIME_UNIT,
    MAP(TIME_UNIT, 'MS', 1, 'S', 1000, 'M', 60000, 'H', 3600000, 'D', 86400000) TIME_FACTOR,
    HOST_LEN
  FROM
  ( SELECT                /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      '55ec9af1031fb9d8d90aaa9909430f2b' STATEMENT_HASH,
      -1 PLAN_ID,
      '%' DB_USER,
      '%' SCHEMA_NAME,
      50 MAX_RESULT_LINES,
      86400 TRACE_HISTORY_S,
      200 LINE_LENGTH,
      ' ' SHOW_COMPLETE_BIND_VALUE_LIST,
      'H' TIME_UNIT                    /* MS, S, M, H, D */
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
SQL_CACHE_CURRENT AS
( SELECT
    CURRENT_TIMESTAMP SERVER_TIMESTAMP,
    C.HOST,
    C.STATEMENT_HASH,
    TO_VARCHAR(C.STATEMENT_STRING) STATEMENT_STRING,
    C.PLAN_ID,
    C.USER_NAME,
    C.TABLE_TYPES,
    C.EXECUTION_ENGINE ENGINES,
    C.LAST_PREPARATION_TIMESTAMP,
    C.LAST_EXECUTION_TIMESTAMP,
    C.LAST_CONNECTION_ID,
    C.EXECUTION_COUNT,
    C.TOTAL_RESULT_RECORD_COUNT,
    C.PREPARATION_COUNT,
    C.TOTAL_EXECUTION_TIME + C.TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    C.TOTAL_EXECUTION_TIME,
    C.TOTAL_PREPARATION_TIME,
    C.TOTAL_LOCK_WAIT_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    C.TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    C.TOTAL_CALLED_THREAD_COUNT,
    C.IS_DISTRIBUTED_EXECUTION,
    MAP(C.COMPILATION_OPTIONS, 'STATEMENT HINT', 'X', ' ') HINT,
    TO_VARCHAR(C.ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    TO_VARCHAR(C.ACCESSED_OBJECT_NAMES) ACCESSED_OBJECT_NAMES,
    TO_VARCHAR(SUBSTR(C.STATEMENT_STRING, 1, 4000)) SQL_TEXT,
    C.APPLICATION_SOURCE,
    CASE WHEN C.LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH' ELSE C.LAST_INVALIDATION_REASON END LAST_INVALIDATION_REASON,
    C.PLAN_MEMORY_SIZE,
    C.AVG_EXECUTION_MEMORY_SIZE,
    C.MAX_EXECUTION_MEMORY_SIZE,
    C.AVG_BUFFER_CACHE_PINNED_MEMORY_SIZE,
    C.MAX_BUFFER_CACHE_PINNED_MEMORY_SIZE,
    C.AVG_BUFFER_CACHE_IO_READ_SIZE,
    C.MAX_BUFFER_CACHE_IO_READ_SIZE,
    1 LINE_NO
  FROM
    BASIS_INFO BI,
    M_SQL_PLAN_CACHE C
  WHERE
    C.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
    ( BI.PLAN_ID = -1 OR C.PLAN_ID = BI.PLAN_ID ) AND
    C.USER_NAME LIKE BI.DB_USER AND
    C.SCHEMA_NAME LIKE BI.SCHEMA_NAME
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
    C.EXECUTION_ENGINE ENGINES,
    C.LAST_PREPARATION_TIMESTAMP,
    C.LAST_EXECUTION_TIMESTAMP,
    C.LAST_CONNECTION_ID,
    C.EXECUTION_COUNT,
    C.TOTAL_RESULT_RECORD_COUNT,
    C.PREPARATION_COUNT,
    C.TOTAL_EXECUTION_TIME + C.TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    C.TOTAL_EXECUTION_TIME,
    C.TOTAL_PREPARATION_TIME,
    C.TOTAL_LOCK_WAIT_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    C.TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    C.TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    C.TOTAL_CALLED_THREAD_COUNT,
    C.IS_DISTRIBUTED_EXECUTION,
    MAP(C.COMPILATION_OPTIONS, 'STATEMENT HINT', 'X', ' ') HINT,
    TO_VARCHAR(C.ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    TO_VARCHAR(C.ACCESSED_OBJECT_NAMES) ACCESSED_OBJECT_NAMES,
    TO_VARCHAR(SUBSTR(C.STATEMENT_STRING, 1, 4000)) SQL_TEXT,
    C.APPLICATION_SOURCE,
    CASE WHEN C.LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH' ELSE C.LAST_INVALIDATION_REASON END LAST_INVALIDATION_REASON,
    C.PLAN_MEMORY_SIZE,
    C.AVG_EXECUTION_MEMORY_SIZE,
    C.MAX_EXECUTION_MEMORY_SIZE,
    C.AVG_BUFFER_CACHE_PINNED_MEMORY_SIZE,
    C.MAX_BUFFER_CACHE_PINNED_MEMORY_SIZE,
    C.AVG_BUFFER_CACHE_IO_READ_SIZE,
    C.MAX_BUFFER_CACHE_IO_READ_SIZE,
    ROW_NUMBER () OVER (ORDER BY C.SERVER_TIMESTAMP DESC, C.PLAN_ID) LINE_NO
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SQL_PLAN_CACHE C
  WHERE
    C.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    C.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
    ( BI.PLAN_ID = -1 OR C.PLAN_ID = BI.PLAN_ID ) AND
    C.USER_NAME LIKE BI.DB_USER AND
    C.SCHEMA_NAME LIKE BI.SCHEMA_NAME
),
BIND_VALUES AS
( SELECT
    ROW_NUMBER () OVER (ORDER BY B.EXECUTION_TIMESTAMP DESC, B.POSITION) LINE_NO,
    B.EXECUTION_TIMESTAMP,
    B.DATA_TYPE_NAME,
    B.POSITION,
    B.PARAMETER_VALUE,
    BI.MAX_RESULT_LINES,
    BI.SHOW_COMPLETE_BIND_VALUE_LIST
  FROM
    BASIS_INFO BI,
    SQL_CACHE_CURRENT S,
    M_SQL_PLAN_CACHE_PARAMETERS B
  WHERE
    S.PLAN_ID = B.PLAN_ID
),
THREAD_SAMPLES AS
( SELECT
    T.TIMESTAMP,
    T.HOST,
    T.PORT,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    T.THREAD_DETAIL,
    T.LOCK_WAIT_NAME LOCK_NAME,
    T.USER_NAME DB_USER,
    T.APPLICATION_NAME APP_NAME,
    /* T.APPLICATION_SOURCE */ 'not reliable' APP_SOURCE,
    T.APPLICATION_USER_NAME APP_USER,
    IFNULL(T.APPLICATION_COMPONENT_NAME, '') APP_COMP_NAME,
    IFNULL(T.PASSPORT_COMPONENT_NAME, '') PASSPORT_COMPONENT,
    IFNULL(T.PASSPORT_ACTION, '') PASSPORT_ACTION,
    T.CLIENT_IP,
    T.CLIENT_PID,
    T.CONNECTION_ID,
    IFNULL(T.ROOT_STATEMENT_HASH, '') ROOT_STATEMENT_HASH,
    GREATEST(11, MAX(LENGTH(T.THREAD_TYPE)) OVER ()) TYPE_LEN,
    GREATEST(12, MAX(LENGTH(T.THREAD_STATE)) OVER ()) STATE_LEN,
    MAX(LENGTH(T.THREAD_METHOD)) OVER () METHOD_LEN,
    MAX(LENGTH(T.LOCK_WAIT_NAME)) OVER () LOCK_LEN,
    GREATEST(7, MAX(LENGTH(T.USER_NAME)) OVER ()) DB_USER_LEN,
    GREATEST(8, MAX(LENGTH(T.APPLICATION_NAME)) OVER ()) APP_NAME_LEN,
    GREATEST(10, MAX(LENGTH(T.APPLICATION_SOURCE)) OVER ()) APP_SOURCE_LEN,
    GREATEST(8, MAX(LENGTH(T.APPLICATION_USER_NAME)) OVER ()) APP_USER_LEN,
    GREATEST(13, MAX(LENGTH(IFNULL(T.APPLICATION_COMPONENT_NAME, ''))) OVER ()) APP_COMP_NAME_LEN,
    GREATEST(18, MAX(LENGTH(IFNULL(T.PASSPORT_COMPONENT_NAME, ''))) OVER ()) PASSPORT_COMPONENT_LEN,
    GREATEST(15, MAX(LENGTH(IFNULL(T.PASSPORT_ACTION, ''))) OVER ()) PASSPORT_ACTION_LEN,
    CASE WHEN T.THREAD_STATE = 'Job Exec Waiting' AND T.LOCK_WAIT_NAME != 'envCondStat' AND T.CALLING = '' THEN 'X' ELSE '' END Q,
    COUNT(*) SAMPLES,
    SUM(COUNT(*)) OVER () TOTAL_SAMPLES
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
  WHERE
    T.SITE_ID IN (-1, 0, CURRENT_SITE_ID()) AND
    SUBSTR(T.STATEMENT_HASH, 1, 31) = SUBSTR(BI.STATEMENT_HASH, 1, 31) AND          /* thread samples partially only stored 31 out of 32 characters */
    T.TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    T.USER_NAME LIKE BI.DB_USER
  GROUP BY
    T.TIMESTAMP,
    T.HOST,
    T.PORT,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.THREAD_METHOD,
    T.THREAD_DETAIL,
    T.LOCK_WAIT_NAME,
    T.USER_NAME,
    T.APPLICATION_NAME,
    T.APPLICATION_SOURCE,
    T.APPLICATION_USER_NAME,
    IFNULL(T.APPLICATION_COMPONENT_NAME, ''),
    IFNULL(T.PASSPORT_COMPONENT_NAME, ''),
    IFNULL(T.PASSPORT_ACTION, ''),
    T.CLIENT_IP,
    T.CLIENT_PID,
    T.CONNECTION_ID,
    T.ROOT_STATEMENT_HASH,
    CASE WHEN T.THREAD_STATE = 'Job Exec Waiting' AND T.LOCK_WAIT_NAME != 'envCondStat' AND T.CALLING = '' THEN 'X' ELSE '' END
),
THREAD_SAMPLES_ROOT_HASH AS
( SELECT
    T.STATEMENT_HASH CHILD_STATEMENT_HASH,
    T.ROOT_STATEMENT_HASH STATEMENT_HASH,
    COUNT(*) SAMPLES,
    SUM(COUNT(*)) OVER () TOTAL_SAMPLES
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES T
  WHERE
    T.SITE_ID IN (-1, 0, CURRENT_SITE_ID()) AND
    SUBSTR(T.ROOT_STATEMENT_HASH, 1, 31) = SUBSTR(BI.STATEMENT_HASH, 1, 31) AND          /* thread samples partially only stored 31 out of 32 characters */
    T.TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    T.USER_NAME LIKE BI.DB_USER
  GROUP BY
    T.STATEMENT_HASH,
    T.ROOT_STATEMENT_HASH
),
ACCESSED_OBJECTS AS
( SELECT
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    *
  FROM
  ( SELECT
      CASE
        WHEN OBJECT_STRING LIKE '%.%' THEN SUBSTR(OBJECT_STRING, 1, LOCATE(OBJECT_STRING, '.', 1) - 1)
        ELSE OBJECT_STRING
      END SCHEMA_NAME,
      CASE
        WHEN OBJECT_STRING LIKE '%.%' THEN SUBSTR(OBJECT_STRING, LOCATE(OBJECT_STRING, '.', 1) + 1)
        ELSE ''
      END OBJECT_NAME
    FROM
    ( SELECT
        CASE 
          WHEN R.LINE_NO = 1 THEN SUBSTR(T.ACCESSED_OBJECTS, 1, LOCATE(T.ACCESSED_OBJECTS, '(', 1, 1) - 1)
          ELSE SUBSTR(T.ACCESSED_OBJECTS, LOCATE(T.ACCESSED_OBJECTS, ', ', 1, R.LINE_NO - 1) + 2, LOCATE(T.ACCESSED_OBJECTS, '(', 1, R.LINE_NO) - LOCATE(T.ACCESSED_OBJECTS, ', ', 1, R.LINE_NO - 1) - 2)
        END OBJECT_STRING
      FROM
        ROW_COUNTER R,
      ( SELECT
          MIN(ACCESSED_OBJECT_NAMES) ACCESSED_OBJECTS,
          LENGTH(MAX(ACCESSED_OBJECT_NAMES)) - LENGTH(REPLACE(MAX(ACCESSED_OBJECT_NAMES), ',', '')) + 1 NUM_OBJECTS
        FROM
        ( SELECT 
            CASE /* remove schema if stored as first object */
              WHEN LOCATE(ACCESSED_OBJECT_NAMES, '.') < LOCATE(ACCESSED_OBJECT_NAMES, '(') THEN ACCESSED_OBJECT_NAMES
              ELSE SUBSTR(ACCESSED_OBJECT_NAMES, LOCATE(ACCESSED_OBJECT_NAMES, CHAR(32), 1) + 1)
            END ACCESSED_OBJECT_NAMES
          FROM 
            SQL_CACHE_CURRENT 
          UNION
          SELECT 
            CASE 
              WHEN LOCATE(ACCESSED_OBJECT_NAMES, '.') < LOCATE(ACCESSED_OBJECT_NAMES, '(') THEN ACCESSED_OBJECT_NAMES
              ELSE SUBSTR(ACCESSED_OBJECT_NAMES, LOCATE(ACCESSED_OBJECT_NAMES, CHAR(32), 1) + 1)
            END ACCESSED_OBJECT_NAMES
          FROM 
            SQL_CACHE_HISTORY
        )
      ) T
      WHERE
        R.LINE_NO <= T.NUM_OBJECTS
    )
  )
),
ACCESSED_PROCEDURES AS
( SELECT
    P.SCHEMA_NAME,
    P.PROCEDURE_NAME,
    P.INPUT_PARAMETER_COUNT,
    P.OUTPUT_PARAMETER_COUNT,
    P.INOUT_PARAMETER_COUNT,
    P.RESULT_SET_COUNT,
    P.PROCEDURE_TYPE,
    P.READ_ONLY,
    P.IS_VALID,
    GREATEST(11, MAX(LENGTH(P.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    MAX(LENGTH(P.PROCEDURE_NAME)) OVER () PROCEDURE_LEN
  FROM
    ACCESSED_OBJECTS O,
    PROCEDURES P
  WHERE
    O.SCHEMA_NAME = P.SCHEMA_NAME AND
    O.OBJECT_NAME = P.PROCEDURE_NAME
),
ACCESSED_FUNCTIONS AS
( SELECT
    F.SCHEMA_NAME,
    F.FUNCTION_NAME,
    F.SQL_SECURITY,
    F.INPUT_PARAMETER_COUNT,
    F.RETURN_VALUE_COUNT,
    F.FUNCTION_TYPE,
    F.FUNCTION_USAGE_TYPE USAGE_TYPE,
    F.IS_VALID,
    GREATEST(11, MAX(LENGTH(F.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    MAX(LENGTH(F.FUNCTION_NAME)) OVER () FUNCTION_LEN
  FROM
    ACCESSED_OBJECTS O,
    FUNCTIONS F
  WHERE
    O.SCHEMA_NAME = F.SCHEMA_NAME AND
    O.OBJECT_NAME = F.FUNCTION_NAME
),
ACCESSED_TABLES AS
( SELECT
    O.SCHEMA_NAME,
    O.OBJECT_NAME TABLE_NAME,
    T.TABLE_TYPE,
    T.LOAD_UNIT,
    T.IS_TEMPORARY,
    GREATEST(11, MAX(LENGTH(O.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(O.OBJECT_NAME)) OVER ()) TABLE_LEN
  FROM
    ACCESSED_OBJECTS O,
    TABLES T
  WHERE
    O.SCHEMA_NAME = T.SCHEMA_NAME AND
    O.OBJECT_NAME = T.TABLE_NAME
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
( SELECT
    V.SCHEMA_NAME,
    V.TABLE_NAME,
    V.REMOTE_SOURCE_NAME,
    V.REMOTE_OBJECT_NAME,
    GREATEST(11, MAX(LENGTH(V.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(V.TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(18, MAX(LENGTH(V.REMOTE_OBJECT_NAME)) OVER ()) REMOTE_OBJECT_LEN
  FROM
    ACCESSED_OBJECTS O,
    VIRTUAL_TABLES V
  WHERE
    O.SCHEMA_NAME = V.SCHEMA_NAME AND
    O.OBJECT_NAME = V.TABLE_NAME
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
    GREATEST(11, MAX(LENGTH(L.SCHEMA_NAME)) OVER ()) SCHEMA_LEN
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
    L.LOB_STORAGE_TYPE 
),
ACCESSED_PARTITIONS AS
( SELECT
    P.*,
    GREATEST(11, MAX(LENGTH(P.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(P.TABLE_NAME) + LENGTH(P.PART_ID) + 3) OVER ()) TABLE_LEN,
    GREATEST(20, MAX(LENGTH(P.LEVEL_1_PARTITIONING)) OVER ()) L1_LEN,
    GREATEST(20, MAX(LENGTH(P.LEVEL_2_PARTITIONING)) OVER ()) L2_LEN,
    GREATEST(4, MAX(LENGTH(P.HOST)) OVER ()) HOST_LEN
  FROM
  ( SELECT
      CT.HOST,
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
( SELECT
    V.*,
    MAX(LENGTH(VIEW_NAME)) OVER () VIEW_LEN,
    GREATEST(11, MAX(LENGTH(V.SCHEMA_NAME)) OVER ()) SCHEMA_LEN
  FROM
    ACCESSED_OBJECTS O,
    VIEWS V
  WHERE
    V.SCHEMA_NAME = O.SCHEMA_NAME AND
    V.VIEW_NAME = O.OBJECT_NAME
),
ACCESSED_CALCVIEWS AS
( SELECT
    C.HOST,
    C.PORT,
    C.SCHEMA_NAME,
    C.VIEW_NAME,
    C.CALCNODE_NAME,
    MAX(LENGTH(C.VIEW_NAME)) OVER () VIEW_LEN,
    SUBSTR(SCENARIO_NAME, 1, LOCATE(SCENARIO_NAME, ':', 1) - 1) SCENARIO_SCHEMA_NAME,
    SUBSTR(SCENARIO_NAME, LOCATE(SCENARIO_NAME, ':', 1) + 1) SCENARIO_NAME,
    GREATEST(11, MAX(LENGTH(C.SCHEMA_NAME)) OVER ()) SCHEMA_LEN
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
    GREATEST(11, MAX(LENGTH(CS.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
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
    INDEX_LOOKUPS_PER_H,
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
      IFNULL(TO_DECIMAL(SUM(CS.INDEX_LOOKUP_COUNT) / S.TIMEFRAME_S * 3600, 18, 0), 0) INDEX_LOOKUPS_PER_H,
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
      CC.TABLE_NAME = AC.TABLE_NAME AND
      AC.IS_TEMPORARY = 'FALSE'
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
      -1 INDEX_LOOKUPS,
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
ACCESSED_INDEXES AS
( SELECT
    I.SCHEMA_NAME,
    I.TABLE_NAME,
    I.INDEX_NAME || MAP(I.PART_ID, 0, '', CHAR(32) || '(' || I.PART_ID || ')') INDEX_NAME,
    CASE 
      WHEN I.INDEX_TYPE LIKE 'INVERTED VALUE%' THEN 'IV' 
      WHEN I.INDEX_TYPE LIKE 'INVERTED INDIVIDUAL%' THEN 'II'
      WHEN I.INDEX_TYPE LIKE 'INVERTED HASH%' THEN 'IH' 
      ELSE I.INDEX_TYPE 
    END TY,
    TO_DECIMAL(I.MEMORY_SIZE_IN_TOTAL / 1024 / 1024, 10, 2) MEM_TOT_MB,
    TO_DECIMAL(I.MEMORY_SIZE_IN_CONCAT / 1024 / 1024, 10, 2) MEM_CONC_MB,
    I.INVERTED_INDIVIDUAL_COST INDIV_COSTS,
    I.MOST_SELECTIVE_COLUMN_NAME INDIV_COLUMN,
    I.INDEX_NAME INDEX_NAME_NO_PART,
    I.PART_ID,
    GREATEST(11, MAX(LENGTH(I.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(I.TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(10, MAX(LENGTH(I.INDEX_NAME || MAP(I.PART_ID, 0, '', CHAR(32) || '(' || I.PART_ID || ')'))) OVER ()) INDEX_LEN,
    GREATEST(12, MAX(LENGTH(I.MOST_SELECTIVE_COLUMN_NAME)) OVER ()) INDIV_COL_LEN
  FROM
    ACCESSED_TABLES T,
    M_CS_INDEXES I
  WHERE
    I.SCHEMA_NAME = T.SCHEMA_NAME AND
    I.TABLE_NAME = T.TABLE_NAME
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
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(11, MAX(LENGTH(COLUMN_NAME)) OVER ()) COLUMN_LEN,
    GREATEST(10, MAX(LENGTH(INDEX_NAME)) OVER ()) INDEX_LEN,
    MAX(LENGTH(INDEX_TYPE)) OVER () INDEX_TYPE_LEN
  FROM
  ( SELECT
      IC.SCHEMA_NAME,
      IC.TABLE_NAME,
      IC.INDEX_NAME,
      IC.COLUMN_NAME,
      IC.POSITION,
      I.INDEX_TYPE,
      IC.CONSTRAINT
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
      '' CONSTRAINT
    FROM
    ( SELECT TABLE_LEN FROM ACCESSED_TABLES ) AC,
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
    CONSTRAINT
),
ACCESSED_INDEXES_2 AS
( SELECT
    IC.SCHEMA_NAME,
    IC.TABLE_NAME,
    IC.INDEX_NAME,
    STRING_AGG(IC.COLUMN_NAME, ', ' ORDER BY IC.POSITION) COLUMN_LIST,
    AC.TABLE_LEN,
    GREATEST(11, MAX(LENGTH(IC.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    MAX(LENGTH(IC.INDEX_NAME)) OVER () INDEX_LEN
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
    AC.TABLE_LEN
),
ACCESSED_INDEX_COLUMNS_2 AS
( SELECT
    ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME) ROW_NUM,
    ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY COLUMN_NAME) ROW_NUM_PER_TAB,
    SCHEMA_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    INDEX_TYPE,
    GREATEST(11, MAX(LENGTH(SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(11, MAX(LENGTH(COLUMN_NAME)) OVER ()) COLUMN_LEN,
    MAX(LENGTH(INDEX_TYPE)) OVER () INDEX_TYPE_LEN
  FROM
  ( SELECT
      C.SCHEMA_NAME,
      C.TABLE_NAME,
      C.COLUMN_NAME,
      'INVERTED VALUE (' || C.INDEX_TYPE || ')' INDEX_TYPE
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
          ACCESSED_INDEXES_2 IC
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
    INDEX_TYPE
),
ACCESSED_REFERENTIAL_CONSTRAINTS AS
( SELECT
    C.*,
    GREATEST(11, MAX(LENGTH(C.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(C.TABLE_NAME)) OVER ()) TABLE_LEN,
    MAX(LENGTH(C.COLUMN_NAME)) OVER () COLUMN_LEN,
    GREATEST(10, MAX(LENGTH(C.REFERENCED_TABLE_NAME)) OVER ()) REF_TABLE_LEN,
    MAX(LENGTH(C.REFERENCED_COLUMN_NAME)) OVER () REF_COLUMN_LEN
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
    GREATEST(11, MAX(LENGTH(R.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(R.TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(10, MAX(LENGTH(R.SOURCE_TABLE_NAME)) OVER ()) SRC_TABLE_LEN
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
    GREATEST(11, MAX(LENGTH(T.SUBJECT_TABLE_SCHEMA)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(T.SUBJECT_TABLE_NAME)) OVER ()) TABLE_LEN,
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
    TO_DECIMAL(IFNULL(GREATEST(0, RESOURCE_WAIT_TIME), 0) / 1000, 10, 0) RW_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_1_HESITANT_LOCK_WAIT_TIME), 0) / 1000, 10, 0) P1_HLW_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_1_BLOCKING_LOCK_WAIT_TIME), 0) / 1000, 10, 0) P1_BLW_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_1_LOCK_TIME), 0) / 1000, 10, 0) P1_L_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_2_HESITANT_LOCK_WAIT_TIME), 0) / 1000, 10, 0) P2_HLW_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_2_BLOCKING_LOCK_WAIT_TIME), 0) / 1000, 10, 0) P2_BLW_S,
    TO_DECIMAL(IFNULL(GREATEST(0, PHASE_2_LOCK_TIME), 0) / 1000, 10, 0) P2_L_S,
    MAP(M.LAST_ERROR, '0', '0', M.LAST_ERROR || CHAR(32) || M.ERROR_DESCRIPTION) LAST_ERROR,
    GREATEST(11, MAX(LENGTH(M.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(M.TABLE_NAME || MAP(M.PART_ID, 0, '', CHAR(32) || '(' || M.PART_ID || ')'))) OVER ()) TABLE_LEN,
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
      ERROR_DESCRIPTION,
      RESOURCE_WAIT_TIME,
      PHASE_1_HESITANT_LOCK_WAIT_TIME,
      PHASE_1_BLOCKING_LOCK_WAIT_TIME,
      PHASE_1_LOCK_TIME,
      PHASE_2_HESITANT_LOCK_WAIT_TIME,
      PHASE_2_BLOCKING_LOCK_WAIT_TIME,
      PHASE_2_LOCK_TIME
    FROM
      _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS
    WHERE
      SITE_ID IN (-1, 0, CURRENT_SITE_ID())
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
    GREATEST(11, MAX(LENGTH(L.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(10, MAX(LENGTH(L.TABLE_NAME)) OVER ()) TABLE_LEN,
    GREATEST(11, MAX(LENGTH(L.COLUMN_NAME)) OVER ()) COLUMN_LEN,
    BI.MAX_RESULT_LINES
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
      'n/a' ERROR
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
      MAP(L.ERROR_CODE, '0', '0', L.ERROR_CODE || CHAR(32) || L.ERROR_TEXT) ERROR
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
EXPENSIVE_STATEMENTS AS
( SELECT
    LINE_NO,
    START_TIME,
    OPERATION,
    DURATION_MICROSEC,
    CPU_TIME,
    RECORDS,
    MEMORY_SIZE,
    ERROR_CODE,
    ERROR_TEXT,
    APP_USER,
    APPLICATION_SOURCE,
    PARAMETERS,
    STATEMENT_HASH,
    WORKLOAD_CLASS,
    STATEMENT_STRING,
    GREATEST(14, MAX(LENGTH(WORKLOAD_CLASS)) OVER ()) WLC_LEN,
    GREATEST(9, MAX(LENGTH(OPERATION)) OVER ()) OPERATION_LEN,
    GREATEST(8, MAX(LENGTH(APP_USER)) OVER ()) APP_USER_LEN,
    MAX(LENGTH(APPLICATION_SOURCE)) OVER () APP_SOURCE_LEN
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY ES.START_TIME DESC, ES.OPERATION) LINE_NO,
      ES.START_TIME,
      ES.OPERATION,
      ES.DURATION_MICROSEC,
      ES.CPU_TIME,
      ES.RECORDS,
      ES.MEMORY_SIZE,
      ES.ERROR_CODE,
      LTRIM(REPLACE(ES.ERROR_TEXT, 'column store error: search table error:', '')) ERROR_TEXT,
      ES.APP_USER,
      ES.APPLICATION_SOURCE,
      ES.PARAMETERS,
      ES.STATEMENT_HASH,
      ES.WORKLOAD_CLASS_NAME WORKLOAD_CLASS,
      SUBSTR(ES.STATEMENT_STRING, 1, 5000) STATEMENT_STRING,
      BI.MAX_RESULT_LINES
    FROM
      BASIS_INFO BI,
      M_EXPENSIVE_STATEMENTS ES
    WHERE
      ES.STATEMENT_HASH = BI.STATEMENT_HASH AND
      ES.DB_USER LIKE BI.DB_USER
  )
  WHERE
    MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES
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
      ES.STATEMENT_HASH = BI.STATEMENT_HASH AND
      ES.DB_USER LIKE BI.DB_USER
  )
  WHERE
    MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES
),
MULTIDIMENSIONAL_STATEMENT_STATISTICS AS
( SELECT
    MS.HOST,
    MS.PORT,
    MS.STATEMENT_HASH,
    SUBSTR(MS.STATEMENT_STRING, 1, 5000) STATEMENT_STRING,
    MS.USER_NAME,
    MS.APPLICATION_USER_NAME,
    MS.APPLICATION_NAME,
    MS.STATEMENT_TYPE,
    MS.EXECUTION_COUNT,
    MS.TOTAL_EXECUTION_TIME,
    MS.MAX_EXECUTION_MEMORY_SIZE
  FROM
    BASIS_INFO BI,
    M_MULTIDIMENSIONAL_STATEMENT_STATISTICS MS
  WHERE
    MS.STATEMENT_HASH = BI.STATEMENT_HASH AND
    MS.USER_NAME LIKE BI.DB_USER
),
TRANSACTIONAL_LOCKS AS
( SELECT
    B.SERVER_TIMESTAMP,
    IFNULL(B.BLOCKED_STATEMENT_HASH, '') BLOCKED_STATEMENT_HASH,
    IFNULL(B.LOCK_OWNER_STATEMENT_HASH, '') LOCK_OWNER_STATEMENT_HASH,
    TO_DECIMAL(ROUND(GREATEST(0, IFNULL(B.WAITING_MINUTES, 0) * 60)), 10, 0) WAIT_S,
    B.LOCK_TYPE,
    B.LOCK_MODE,
    B.WAITING_SCHEMA_NAME || '.' || B.WAITING_OBJECT_NAME OBJECT_NAME,
    ROW_NUMBER () OVER (ORDER BY B.SERVER_TIMESTAMP DESC) ROW_NUM,
    MAX(LENGTH(B.LOCK_TYPE)) OVER () TYPE_LEN,
    MAX(LENGTH(B.LOCK_MODE)) OVER () MODE_LEN,
    BI.MAX_RESULT_LINES
  FROM
    BASIS_INFO BI,
    _SYS_STATISTICS.HOST_BLOCKED_TRANSACTIONS B
  WHERE
    B.SITE_ID IN (-1, 0, CURRENT_SITE_ID()) AND
    BI.STATEMENT_HASH IN ( B.BLOCKED_STATEMENT_HASH, B.LOCK_OWNER_STATEMENT_HASH ) AND
    B.WAITING_SCHEMA_NAME LIKE BI.DB_USER
),
ACTIVE_STATEMENTS AS
( SELECT
    A.*
  FROM
    M_ACTIVE_STATEMENTS A,
  ( SELECT PLAN_ID FROM SQL_CACHE_CURRENT UNION SELECT PLAN_ID FROM SQL_CACHE_HISTORY ) C
  WHERE
    A.PLAN_ID = C.PLAN_ID
),
ACTIVE_PROCEDURES AS
( SELECT
    *
  FROM
  ( SELECT
      P.*,
      AP.SCHEMA_LEN,
      AP.PROCEDURE_LEN,
      BI.MAX_RESULT_LINES,
      ROW_NUMBER() OVER (ORDER BY STATEMENT_COMPILE_TIME DESC) LINE_NO
    FROM
      BASIS_INFO BI,
      ACCESSED_PROCEDURES AP,
      M_ACTIVE_PROCEDURES P
    WHERE
      AP.SCHEMA_NAME = P.PROCEDURE_SCHEMA_NAME AND
      AP.PROCEDURE_NAME = P.PROCEDURE_NAME
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES )
),
CALLSTACKS AS
( SELECT
    TC.*,
    T.THREAD_TYPE,
    T.THREAD_STATE,
    T.LOCK_WAIT_NAME
  FROM
    BASIS_INFO BI,
    M_SERVICE_THREADS T,
    M_SERVICE_THREAD_CALLSTACKS TC
  WHERE
    T.STATEMENT_HASH = BI.STATEMENT_HASH AND
    T.THREAD_ID = TC.THREAD_ID AND
    T.USER_NAME LIKE BI.DB_USER
),
OOM_EVENTS AS
( SELECT
    O.TIME,
    O.HEAP_MEMORY_CATEGORY HEAP_ALLOCATOR,
    TO_DECIMAL(O.MEMORY_USED_SIZE / 1024 / 1024 / 1024, 10, 2) MEM_USED_GB,
    O.EVENT_REASON,
    BI.MAX_RESULT_LINES,
    ROW_NUMBER () OVER (ORDER BY TIME DESC) ROW_NUM
  FROM
    BASIS_INFO BI,
    M_OUT_OF_MEMORY_EVENTS O
  WHERE
    O.STATEMENT_HASH = BI.STATEMENT_HASH
),
ADMISSION_CONTROL_EVENTS AS
( SELECT
    A.HOST,
    A.PORT,
    A.EVENT_TIME,
    A.EVENT_REASON,
    A.QUEUE_WAIT_TIME,
    A.CPU_USAGE_RATIO,
    A.MEMORY_RATIO,
    BI.MAX_RESULT_LINES,
    ROW_NUMBER () OVER (ORDER BY A.EVENT_TIME DESC) ROW_NUM
  FROM
    BASIS_INFO BI,
    M_ADMISSION_CONTROL_EVENTS A
  WHERE
    A.STATEMENT_HASH = BI.STATEMENT_HASH
),
PINNED_PLANS AS
( SELECT
    P.*
  FROM
    BASIS_INFO BI,
    PINNED_SQL_PLANS P
  WHERE
    P.STATEMENT_HASH = BI.STATEMENT_HASH
),
STMT_HINTS AS
( SELECT
    S.*
  FROM
    BASIS_INFO BI,
    STATEMENT_HINTS S
  WHERE
    S.STATEMENT_HASH = BI.STATEMENT_HASH
),
ANNOTS AS
( SELECT DISTINCT
    S.*,
    GREATEST(11, MAX(LENGTH(S.SCHEMA_NAME)) OVER ()) SCHEMA_LEN,
    GREATEST(11, MAX(LENGTH(S.OBJECT_NAME)) OVER ()) OBJECT_LEN
  FROM
    ANNOTATIONS S,
    ACCESSED_VIEWS V
  WHERE
    S.SCHEMA_NAME = V.SCHEMA_NAME AND
    S.OBJECT_NAME = V.VIEW_NAME
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
PARAMETERS AS
( SELECT
    FILE_NAME,
    SECTION,
    KEY,
    VALUE,
    MAX(LENGTH(FILE_NAME)) OVER() FILE_LEN,
    MAX(LENGTH(SECTION)) OVER() SECTION_LEN,
    MAX(LENGTH(KEY)) OVER () KEY_LEN,
    MAX(LENGTH(VALUE)) OVER () VALUE_LEN
  FROM
  ( SELECT
      FILE_NAME,
      SECTION,
      KEY,
      MAX(VALUE) VALUE
    FROM
      M_CONFIGURATION_PARAMETER_VALUES
    GROUP BY
      FILE_NAME,
      SECTION,
      KEY
  )
  WHERE
    KEY IN
    ( 'default_statement_concurrency_limit',
      'esx_level',
      'garbage_collect_interval_s',
      'hex_enabled',
      'hex_enable_remote_table_access',
      'max_concurrency',
      'max_concurrency_hint',
      'multistore_feature_toggle',
      'num_cores',
      'qo_small_enough_exact_estimation',
      'qo_small_enough_rough_estimation',
      'singleindex_consider_for_compressed_columns',
      'single_thread_execution_for_partitioned_tables',
      'statement_memory_limit',
      'ut_delta_rollover_switch_values'
    )
),
PARAMETER_CHANGES AS
( SELECT
    PC.*,
    IFNULL(MAX(LENGTH(FILE_NAME)) OVER (), 0) FILE_LEN,
    IFNULL(MAX(LENGTH(SECTION)) OVER (), 0) SECTION_LEN,
    GREATEST(14, IFNULL(MAX(LENGTH(KEY)) OVER (), 0)) KEY_LEN,
    GREATEST(5, IFNULL(MAX(LENGTH(VALUE)) OVER (), 0)) VALUE_LEN,
    GREATEST(10, IFNULL(MAX(LENGTH(PREV_VALUE)) OVER (), 0)) PREV_VALUE_LEN
  FROM
  ( SELECT
      PH.*,
      BI.MAX_RESULT_LINES,
      ROW_NUMBER () OVER (ORDER BY PH.TIME DESC, PH.FILE_NAME, PH.SECTION, PH.KEY) LINE_NO
    FROM
      BASIS_INFO BI,
      M_INIFILE_CONTENT_HISTORY PH
    WHERE
      TIME >= ADD_DAYS(CURRENT_TIMESTAMP, -42) AND
      SECTION IS NOT NULL
  ) PC
  WHERE
    ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES )
),
TRACE_ENTRIES AS
( SELECT
    ROW_NUMBER() OVER (ORDER BY T.TIMESTAMP DESC) LINE_NO,
    MAP(L.LINE_NO, 1, T.TIMESTAMP, T.TIMESTAMP_SUCC) TIMESTAMP,
    MAP(L.LINE_NO, 1, T.COMPONENT, T.COMPONENT_SUCC) COMPONENT,
    MAP(L.LINE_NO, 1, T.TRACE_TEXT, T.TRACE_TEXT_SUCC) TRACE_TEXT,
    T.MAX_RESULT_LINES
  FROM
  ( SELECT 1 LINE_NO FROM DUMMY UNION ALL
    SELECT 2 LINE_NO FROM DUMMY
  ) L,
  ( SELECT
      BI.STATEMENT_HASH,
      BI.MAX_RESULT_LINES,
      T.TIMESTAMP,
      LAG(T.TIMESTAMP) OVER (PARTITION BY T.HOST, T.PORT, T.THREAD_ID ORDER BY T.TIMESTAMP) TIMESTAMP_SUCC,
      T.COMPONENT,
      LAG(T.COMPONENT) OVER (PARTITION BY T.HOST, T.PORT, T.THREAD_ID ORDER BY T.TIMESTAMP) COMPONENT_SUCC,
      T.TRACE_TEXT,
      LAG(TO_VARCHAR(T.TRACE_TEXT)) OVER (PARTITION BY T.HOST, T.PORT, T.THREAD_ID ORDER BY T.TIMESTAMP) TRACE_TEXT_SUCC
    FROM
      BASIS_INFO BI,
      M_MERGED_TRACES T
    WHERE
    ( BI.TRACE_HISTORY_S = -1 OR T.TIMESTAMP >= ADD_SECONDS(CURRENT_TIMESTAMP, -BI.TRACE_HISTORY_S) )
  ) T
  WHERE
    TO_VARCHAR(T.TRACE_TEXT) LIKE '%' || T.STATEMENT_HASH || '%'
),
FEATURE_USAGE AS
( SELECT
    U.*,
    GREATEST(14, MAX(LENGTH(COMPONENT_NAME)) OVER ()) COMPONENT_LEN,
    GREATEST(12, MAX(LENGTH(FEATURE_NAME)) OVER ()) FEATURE_LEN
  FROM
    BASIS_INFO BI,
    M_FEATURE_USAGE U
  WHERE
    U.LAST_STATEMENT_HASH = BI.STATEMENT_HASH
)
SELECT
  MAP(BI.LINE_LENGTH, -1, L.LINE, SUBSTR(L.LINE, 1, BI.LINE_LENGTH)) LINE
FROM
  BASIS_INFO BI,
( SELECT   10 LINE_NO, '*******************************************' LINE                                                            FROM DUMMY UNION ALL
  SELECT   20,         '* SAP HANA STATEMENT HASH DATA COLLECTION *'                                                                 FROM DUMMY UNION ALL
  SELECT   30,         '*******************************************'                                                                 FROM DUMMY UNION ALL
  SELECT   40,         ''                                                                                                            FROM DUMMY UNION ALL
  SELECT   82, RPAD('Generated with:',             27, CHAR(32)) || 'SQL: "HANA_SQL_StatementHash_DataCollector" (SAP Note 1969700)' FROM DUMMY UNION ALL
  SELECT   85, RPAD('Start time:',                 27, CHAR(32)) || TO_VARCHAR(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS')                  FROM BASIS_INFO WHERE TO_VARCHAR(BEGIN_TIME, 'YYYY') >= '2000' UNION ALL
  SELECT   86, RPAD('End time:',                   27, CHAR(32)) || TO_VARCHAR(LEAST(CURRENT_TIMESTAMP, END_TIME), 'YYYY/MM/DD HH24:MI:SS') FROM BASIS_INFO UNION ALL
  SELECT   92, RPAD('System ID / database name:',  27, CHAR(32)) || SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME        FROM M_DATABASE UNION ALL
  SELECT   94, RPAD('Revision level:',             27, CHAR(32)) || VERSION                                                          FROM M_DATABASE UNION ALL
  SELECT  100, RPAD('Statement hash:',             27, CHAR(32)) || STATEMENT_HASH                                                   FROM BASIS_INFO UNION ALL
  SELECT  110, RPAD('Plan ID:',                    27, CHAR(32)) || TO_VARCHAR(PLAN_ID)                                              FROM BASIS_INFO WHERE PLAN_ID != -1 UNION ALL
  SELECT  120, ''                                                                                                                    FROM DUMMY UNION ALL
  SELECT 1000, '***************' FROM DUMMY UNION ALL
  SELECT 1010, '* KEY FIGURES *' FROM DUMMY UNION ALL
  SELECT 1020, '***************' FROM DUMMY UNION ALL
  SELECT 1030, ''                FROM DUMMY UNION ALL
  SELECT 1070, RPAD('STAT_NAME', 25) || RPAD('VALUE', 33) || LPAD('VALUE_PER_EXEC', 15) || LPAD('VALUE_PER_ROW', 15) FROM DUMMY UNION ALL
  SELECT 1080, RPAD('=', 24, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 14, '=') FROM DUMMY UNION ALL
  SELECT
    1100 + L.LINE_NO * 10,
    RPAD(L.STAT_NAME, 25) ||
    RPAD(CASE
      WHEN L.LINE_NO =  1 THEN C.STATEMENT_HASH
      WHEN L.LINE_NO =  2 THEN MAP(MIN(C.PLAN_ID), MAX(C.PLAN_ID), TO_VARCHAR(MIN(C.PLAN_ID)), 'various (' || COUNT(DISTINCT(C.PLAN_ID)) || ')')
      WHEN L.LINE_NO =  3 THEN SUBSTR(MAX(C.TABLE_TYPES) || CHAR(32) || '/' || CHAR(32) || MAP(MAX(C.IS_DISTRIBUTED_EXECUTION), 'TRUE', 'dist.', 'local'), 1, 32)
      WHEN L.LINE_NO =  6 THEN MAX(C.APPLICATION_SOURCE)
      WHEN L.LINE_NO =  7 THEN MAX(C.USER_NAME)
      WHEN L.LINE_NO =  8 THEN TO_VARCHAR(MAX(C.LAST_CONNECTION_ID))
      WHEN L.LINE_NO = 10 THEN LPAD(SUM(C.EXECUTION_COUNT), 32)
      WHEN L.LINE_NO = 11 THEN LPAD(SUM(C.TOTAL_RESULT_RECORD_COUNT), 32)
      WHEN L.LINE_NO = 12 THEN LPAD(SUM(C.PREPARATION_COUNT), 32)
      WHEN L.LINE_NO = 21 THEN LPAD(TO_DECIMAL(SUM(C.TOTAL_ELAPSED_TIME)                        / 1000 / BI.TIME_FACTOR, 10, 2) || CHAR(32) || BI.TIME_UNIT, 32)
      WHEN L.LINE_NO = 22 THEN LPAD(TO_DECIMAL(SUM(C.TOTAL_EXECUTION_TIME)                      / 1000 / BI.TIME_FACTOR, 10, 2) || CHAR(32) || BI.TIME_UNIT, 32)
      WHEN L.LINE_NO = 24 THEN LPAD(TO_DECIMAL(SUM(C.TOTAL_PREPARATION_TIME)                    / 1000 / BI.TIME_FACTOR, 10, 2) || CHAR(32) || BI.TIME_UNIT, 32)
      WHEN L.LINE_NO = 28 THEN LPAD(TO_DECIMAL(SUM(C.TOTAL_LOCK_WAIT_DURATION)                  / 1000 / BI.TIME_FACTOR, 10, 2) || CHAR(32) || BI.TIME_UNIT, 32)
      ELSE ' ' END, MAP(L.LINE_NO, 6, 100, 32)) ||
    LPAD(CASE
      WHEN L.LINE_NO =  3 THEN SUBSTR(MAX(C.TABLE_TYPES) || CHAR(32) || '/' || CHAR(32) || MAP(MAX(C.IS_DISTRIBUTED_EXECUTION), 'TRUE', 'dist.', 'local'), 33)
      WHEN L.LINE_NO = 11 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT)                       / SUM(C.EXECUTION_COUNT)), 12, 2), 14)
      WHEN L.LINE_NO = 12 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.PREPARATION_COUNT)                               / SUM(C.EXECUTION_COUNT)), 12, 2), 14)
      WHEN L.LINE_NO = 21 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_ELAPSED_TIME)                       / 1000 / SUM(C.EXECUTION_COUNT)), 12, 2) || ' ms', 14)
      WHEN L.LINE_NO = 22 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_TIME)                     / 1000 / SUM(C.EXECUTION_COUNT)), 12, 2) || ' ms', 14)
      WHEN L.LINE_NO = 24 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_PREPARATION_TIME)                   / 1000 / SUM(C.EXECUTION_COUNT)), 12, 2) || ' ms', 14)
      WHEN L.LINE_NO = 28 THEN LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION)                 / 1000 / SUM(C.EXECUTION_COUNT)), 12, 2) || ' ms', 14)
      ELSE ' ' END, 16) ||
    LPAD(CASE
      WHEN L.LINE_NO = 21 THEN LPAD(TO_DECIMAL(MAP(SUM(C.TOTAL_RESULT_RECORD_COUNT), 0, 0, SUM(C.TOTAL_ELAPSED_TIME)                       / 1000 / SUM(C.TOTAL_RESULT_RECORD_COUNT)), 12, 2) || ' ms', 13)
      WHEN L.LINE_NO = 22 THEN LPAD(TO_DECIMAL(MAP(SUM(C.TOTAL_RESULT_RECORD_COUNT), 0, 0, SUM(C.TOTAL_EXECUTION_TIME)                     / 1000 / SUM(C.TOTAL_RESULT_RECORD_COUNT)), 12, 2) || ' ms', 13)
      WHEN L.LINE_NO = 24 THEN LPAD(TO_DECIMAL(MAP(SUM(C.TOTAL_RESULT_RECORD_COUNT), 0, 0, SUM(C.TOTAL_PREPARATION_TIME)                   / 1000 / SUM(C.TOTAL_RESULT_RECORD_COUNT)), 12, 2) || ' ms', 13)
      WHEN L.LINE_NO = 28 THEN LPAD(TO_DECIMAL(MAP(SUM(C.TOTAL_RESULT_RECORD_COUNT), 0, 0, SUM(C.TOTAL_LOCK_WAIT_DURATION)                 / 1000 / SUM(C.TOTAL_RESULT_RECORD_COUNT)), 12, 2) || ' ms', 13)
      ELSE ' ' END, 15)
  FROM
    BASIS_INFO BI,
    ( SELECT
        *
      FROM
        SQL_CACHE_HISTORY
      UNION ALL
      SELECT
        * 
      FROM
        SQL_CACHE_CURRENT
      WHERE
        NOT EXISTS ( SELECT * FROM SQL_CACHE_HISTORY )
    ) C,
    ( SELECT  1 LINE_NO, 'Statement hash' STAT_NAME FROM DUMMY UNION ALL
      SELECT  2, 'Plan ID'                          FROM DUMMY UNION ALL
      SELECT  3, 'Table type / dist.'               FROM DUMMY UNION ALL
      SELECT  6, 'Application source'               FROM DUMMY UNION ALL
      SELECT  7, 'Database user name'               FROM DUMMY UNION ALL
      SELECT  8, 'Last connection ID'               FROM DUMMY UNION ALL
      SELECT  9, ''                                 FROM DUMMY UNION ALL
      SELECT 10, 'Executions'                       FROM DUMMY UNION ALL
      SELECT 11, 'Records'                          FROM DUMMY UNION ALL
      SELECT 12, 'Preparations'                     FROM DUMMY UNION ALL
      SELECT 19, ''                                 FROM DUMMY UNION ALL
      SELECT 21, 'Elapsed time'                     FROM DUMMY UNION ALL
      SELECT 22, 'Execution time'                   FROM DUMMY UNION ALL
      SELECT 24, 'Preparation time'                 FROM DUMMY UNION ALL
      SELECT 28, 'Lock wait time'                   FROM DUMMY
    ) L
  GROUP BY
    C.STATEMENT_HASH,
    L.LINE_NO,
    L.STAT_NAME,
    BI.BEGIN_TIME,
    BI.END_TIME,
    BI.TIME_FACTOR,
    BI.TIME_UNIT
  UNION ALL
  SELECT 1990, ''                   FROM DUMMY UNION ALL
  SELECT 2000, '******************' FROM DUMMY UNION ALL
  SELECT 2010, '* STATEMENT TEXT *' FROM DUMMY UNION ALL
  SELECT 2020, '******************' FROM DUMMY UNION ALL
  SELECT 2030, ''                   FROM DUMMY UNION ALL
  SELECT 2100 + LINE_NO / 1000, SUBSTR(SQL_TEXT, START_POS, END_POS - START_POS - 1)
  FROM
  ( SELECT
      SQL_TEXT,
      SQL_TEXT_LENGTH,
      LINE_NO,
      LAST_LINE_NO,
      MAP(LINE_NO, 1, 0, ( 80 * ( LINE_NO - 1) ) + START_POS) START_POS,
      MAP(END_POS, 0, SQL_TEXT_LENGTH + 2, ( 80 * LINE_NO ) + END_POS) END_POS
    FROM
    ( SELECT
        SQL_TEXT,
        SQL_TEXT_LENGTH,
        LINE_NO,
        CEIL(SQL_TEXT_LENGTH / 80) LAST_LINE_NO,
        CASE
          WHEN NUM_BLANKS >= NUM_COMMAS THEN LOCATE(SUBSTR(SQL_TEXT, ( LINE_NO - 1) * 80), CHAR(32))
          WHEN NUM_COMMAS >  NUM_BLANKS THEN LOCATE(SUBSTR(SQL_TEXT, ( LINE_NO - 1) * 80), ',') 
        END START_POS,
        CASE
          WHEN NUM_BLANKS >= NUM_COMMAS THEN LOCATE(SUBSTR(SQL_TEXT, LINE_NO        * 80), CHAR(32))
          WHEN NUM_COMMAS >  NUM_BLANKS THEN LOCATE(SUBSTR(SQL_TEXT, LINE_NO        * 80), ',')
        END END_POS
      FROM
      ( SELECT
          O.LINE_NO,
          S.SQL_TEXT_LENGTH,
          S.SQL_TEXT,
          LENGTH(S.SQL_TEXT) - LENGTH(REPLACE(S.SQL_TEXT, ',', '')) NUM_COMMAS,
          LENGTH(S.SQL_TEXT) - LENGTH(REPLACE(S.SQL_TEXT, CHAR(32), '')) NUM_BLANKS
        FROM
          BASIS_INFO BI,
        ( SELECT TOP 1
            *
          FROM
          ( SELECT TOP 1
              STATEMENT_HASH,
              STATEMENT_STRING SQL_TEXT,
              LENGTH(STATEMENT_STRING) SQL_TEXT_LENGTH
            FROM
              SQL_CACHE_CURRENT
            UNION
            SELECT TOP 1
              STATEMENT_HASH,
              STATEMENT_STRING SQL_TEXT,
              LENGTH(STATEMENT_STRING) SQL_TEXT_LENGTH
            FROM
              SQL_CACHE_HISTORY
            UNION
            SELECT TOP 1
              STATEMENT_HASH,
              STATEMENT_STRING SQL_TEXT,
              LENGTH(STATEMENT_STRING) SQL_TEXT_LENGTH
            FROM
              EXPENSIVE_STATEMENTS
            UNION
            SELECT TOP 1
              STATEMENT_HASH,
              STATEMENT_STRING SQL_TEXT,
              LENGTH(STATEMENT_STRING) SQL_TEXT_LENGTH
            FROM
              EXECUTED_STATEMENTS
            UNION
            SELECT TOP 1
              STATEMENT_HASH,
              STATEMENT_STRING SQL_TEXT,
              LENGTH(STATEMENT_STRING) SQL_TEXT_LENGTH
            FROM
              MULTIDIMENSIONAL_STATEMENT_STATISTICS
          )
        ) S,
        ( SELECT TOP 1000
            ROW_NUMBER () OVER () LINE_NO
          FROM
            OBJECTS
        ) O
        WHERE
          BI.STATEMENT_HASH = S.STATEMENT_HASH AND
          O.LINE_NO <= CEIL(S.SQL_TEXT_LENGTH / 80)
      )
    )
    WHERE
      START_POS != 0
  ) UNION ALL
  SELECT TOP 1 2490, ''                FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2500, '***************' FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2510, '* BIND VALUES *' FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2520, '***************' FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2530, ''                FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2680, RPAD('EXECUTION_TIME', 19) || CHAR(32) || RPAD('DATA_TYPE', 14) || CHAR(32) || LPAD('POS', 4) || CHAR(32) || RPAD('BIND_VALUE', 50) FROM BIND_VALUES UNION ALL
  SELECT TOP 1 2690, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || LPAD('=', 4, '=') || CHAR(32) || RPAD('=', 50, '=') FROM BIND_VALUES UNION ALL
  SELECT 2700 + LINE_NO / 1000,
    RPAD(IFNULL(TO_VARCHAR(EXECUTION_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'), ''), 20) || RPAD(DATA_TYPE_NAME, 15) || LPAD(POSITION, 4) || CHAR(32) || RPAD(PARAMETER_VALUE, 80)
  FROM
    BIND_VALUES
  WHERE
  ( MAX_RESULT_LINES = -1 OR SHOW_COMPLETE_BIND_VALUE_LIST = 'X' OR LINE_NO <= MAX_RESULT_LINES ) UNION ALL
  SELECT 2990, ''              FROM DUMMY UNION ALL
  SELECT 3000, '*************' FROM DUMMY UNION ALL
  SELECT 3010, '* SQL CACHE *' FROM DUMMY UNION ALL
  SELECT 3020, '*************' FROM DUMMY UNION ALL
  SELECT 3030, ''              FROM DUMMY UNION ALL
  SELECT 3080, RPAD('SNAPSHOT_TIME', 20) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PLAN_ID', 13) || CHAR(32) || RPAD('ENG', 4) || CHAR(32) || LPAD('EXECUTIONS', 14) || CHAR(32) || 
    LPAD('RECORDS', 14) || CHAR(32) || LPAD('REC_PER_EXEC', 14) || CHAR(32) || LPAD('ELAPSED_MS', 17) || CHAR(32) || LPAD('ELA_PER_EXEC_MS', 15) || CHAR(32) || LPAD('ELA_PER_REC_MS', 14) || CHAR(32) || 
    LPAD('PREPARES', 11) || CHAR(32) || LPAD('PREPARE_MS', 14) || CHAR(32) || LPAD('LOCK_MS', 14) || CHAR(32) || RPAD('HINT', 4) FROM BASIS_INFO UNION ALL
  SELECT 3090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || RPAD('=', 4, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || 
    LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || RPAD('=', 4, '=') FROM BASIS_INFO UNION ALL
  SELECT 3100, RPAD('CURRENT', 20) ||
    RPAD(HOST, HOST_LEN) || CHAR(32) ||
    LPAD(PLAN_ID, 13) || CHAR(32) ||
    RPAD(CASE WHEN ENGINES LIKE '%COLUMN%' THEN 'C' ELSE '' END || CASE WHEN ENGINES LIKE '%ESX%' THEN 'E' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%HEX%' THEN 'H' ELSE '' END || CASE WHEN ENGINES LIKE '%OLAP%' THEN 'O' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%EXTERNAL%' THEN 'X' ELSE '' END || CASE WHEN ENGINES LIKE '%SQLSCRIPT%' THEN 'S' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%ROW%' THEN 'R' ELSE '' END, 4) || CHAR(32) ||
    LPAD(EXECUTION_COUNT, 14) || CHAR(32) ||
    LPAD(TOTAL_RESULT_RECORD_COUNT, 14) || CHAR(32) ||
    LPAD(TO_DECIMAL(MAP(EXECUTION_COUNT, 0, 0, TOTAL_RESULT_RECORD_COUNT / EXECUTION_COUNT), 10, 2), 14) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(TOTAL_ELAPSED_TIME / 1000), 20, 0), 17) || CHAR(32) ||
    LPAD(TO_DECIMAL(MAP(EXECUTION_COUNT, 0, 0, TOTAL_ELAPSED_TIME / EXECUTION_COUNT / 1000), 10, 2), 15) || CHAR(32) ||
    LPAD(TO_DECIMAL(MAP(TOTAL_RESULT_RECORD_COUNT, 0, 0, TOTAL_ELAPSED_TIME / TOTAL_RESULT_RECORD_COUNT / 1000), 10, 2), 14) || CHAR(32) ||
    LPAD(PREPARATION_COUNT, 11) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(TOTAL_PREPARATION_TIME / 1000), 14, 0), 14) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(TOTAL_LOCK_WAIT_DURATION / 1000), 14, 0), 14) || CHAR(32) ||
    RPAD(HINT, 4)
  FROM
  ( SELECT HOST_LEN FROM BASIS_INFO ),
    SQL_CACHE_CURRENT
  UNION ALL
  SELECT 3200 + C.LINE_NO / 100, RPAD(TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'), 20) ||
    RPAD(C.HOST, BI.HOST_LEN) || CHAR(32) ||
    LPAD(C.PLAN_ID, 13) || CHAR(32) ||
    RPAD(CASE WHEN ENGINES LIKE '%COLUMN%' THEN 'C' ELSE '' END || CASE WHEN ENGINES LIKE '%ESX%' THEN 'E' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%HEX%' THEN 'H' ELSE '' END || CASE WHEN ENGINES LIKE '%OLAP%' THEN 'O' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%EXTERNAL%' THEN 'X' ELSE '' END || CASE WHEN ENGINES LIKE '%SQLSCRIPT%' THEN 'S' ELSE '' END ||
      CASE WHEN ENGINES LIKE '%ROW%' THEN 'R' ELSE '' END, 4) ||
    LPAD(C.EXECUTION_COUNT, 15) ||
    LPAD(C.TOTAL_RESULT_RECORD_COUNT, 15) ||
    LPAD(TO_DECIMAL(MAP(C.EXECUTION_COUNT, 0, 0, C.TOTAL_RESULT_RECORD_COUNT / C.EXECUTION_COUNT), 10, 2), 15) ||
    LPAD(TO_DECIMAL(ROUND(C.TOTAL_ELAPSED_TIME / 1000), 20, 0), 18) ||
    LPAD(TO_DECIMAL(MAP(C.EXECUTION_COUNT, 0, 0, C.TOTAL_ELAPSED_TIME / C.EXECUTION_COUNT / 1000), 10, 2), 16) ||
    LPAD(TO_DECIMAL(MAP(TOTAL_RESULT_RECORD_COUNT, 0, 0, TOTAL_ELAPSED_TIME / TOTAL_RESULT_RECORD_COUNT / 1000), 10, 2), 15) ||
    LPAD(C.PREPARATION_COUNT, 12) ||
    LPAD(TO_DECIMAL(ROUND(C.TOTAL_PREPARATION_TIME / 1000), 15, 0), 15) ||
    LPAD(TO_DECIMAL(ROUND(C.TOTAL_LOCK_WAIT_DURATION / 1000), 15, 0), 15) || CHAR(32) ||
    RPAD(HINT, 4)
  FROM
    BASIS_INFO BI,
    SQL_CACHE_HISTORY C
  WHERE
  ( BI.MAX_RESULT_LINES = -1 OR C.LINE_NO <= BI.MAX_RESULT_LINES ) UNION ALL
  SELECT 3300, ''              FROM DUMMY UNION ALL
  SELECT 3310, RPAD('SNP_TIME', 10) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('PLAN_ID', 13) || CHAR(32) || RPAD('ENG', 4) || CHAR(32) || LPAD('EXECUTIONS', 14) || CHAR(32) || 
    LPAD('RECORDS', 14) || CHAR(32) || LPAD('REC_PER_EXEC', 14) || CHAR(32) || LPAD('ELAPSED_MS', 17) || CHAR(32) || LPAD('ELA_PER_EXEC_MS', 15) || CHAR(32) || LPAD('ELA_PER_REC_MS', 14) || CHAR(32) || 
    LPAD('PREPARES', 11) || CHAR(32) || LPAD('PREPARE_MS', 14) || CHAR(32) || LPAD('LOCK_MS', 14) FROM ( SELECT HOST_LEN FROM BASIS_INFO ) UNION ALL
  SELECT 3320, RPAD('=', 10, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 13, '=')  || CHAR(32) || RPAD('=', 4, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || 
    LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 14, '=') || CHAR(32) || LPAD('=', 14, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ) UNION ALL
  SELECT
    LINE_NO,
    LINE
  FROM
  ( SELECT BI.MAX_RESULT_LINES, ROW_NUMBER () OVER (ORDER BY TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD') DESC) ROWNO, 3330 + MIN(C.LINE_NO) / 1000 LINE_NO, RPAD(TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD'), 10) || CHAR(32) ||
      RPAD(C.HOST, BI.HOST_LEN) || CHAR(32) ||
      LPAD(C.PLAN_ID, 13) || CHAR(32) ||
      RPAD(MAX(CASE WHEN ENGINES LIKE '%COLUMN%' THEN 'C' ELSE '' END) || MAX(CASE WHEN ENGINES LIKE '%ESX%' THEN 'E' ELSE '' END) ||
        MAX(CASE WHEN ENGINES LIKE '%HEX%' THEN 'H' ELSE '' END) || MAX(CASE WHEN ENGINES LIKE '%OLAP%' THEN 'O' ELSE '' END) ||
        MAX(CASE WHEN ENGINES LIKE '%EXTERNAL%' THEN 'X' ELSE '' END) || MAX(CASE WHEN ENGINES LIKE '%SQLSCRIPT%' THEN 'S' ELSE '' END) ||
        MAX(CASE WHEN ENGINES LIKE '%ROW%' THEN 'R' ELSE '' END), 4) || CHAR(32) ||
      LPAD(SUM(C.EXECUTION_COUNT), 14) || CHAR(32) ||
      LPAD(SUM(C.TOTAL_RESULT_RECORD_COUNT), 14) || CHAR(32) ||
      LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_RESULT_RECORD_COUNT) / SUM(C.EXECUTION_COUNT)), 10, 2), 14) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(SUM(C.TOTAL_ELAPSED_TIME) / 1000), 20, 0), 17) || CHAR(32) ||
      LPAD(TO_DECIMAL(MAP(SUM(C.EXECUTION_COUNT), 0, 0, SUM(C.TOTAL_ELAPSED_TIME) / SUM(C.EXECUTION_COUNT) / 1000), 10, 2), 15) || CHAR(32) ||
      LPAD(TO_DECIMAL(MAP(SUM(C.TOTAL_RESULT_RECORD_COUNT), 0, 0, SUM(C.TOTAL_ELAPSED_TIME) / SUM(C.TOTAL_RESULT_RECORD_COUNT) / 1000), 10, 2), 14) || CHAR(32) ||
      LPAD(SUM(C.PREPARATION_COUNT), 11) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(SUM(C.TOTAL_PREPARATION_TIME) / 1000), 15, 0), 14) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(SUM(C.TOTAL_LOCK_WAIT_DURATION) / 1000), 15, 0), 14) LINE
    FROM
      BASIS_INFO BI,
      SQL_CACHE_HISTORY C
    GROUP BY
      BI.MAX_RESULT_LINES,
      BI.HOST_LEN,
      TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD'),
      C.PLAN_ID,
      C.HOST
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROWNO <= GREATEST(42, MAX_RESULT_LINES) )
  UNION ALL
  SELECT 3340, ''              FROM DUMMY UNION ALL
  SELECT 3341, RPAD('SNAPSHOT_TIME', 19) || CHAR(32) || LPAD('PLAN_MEM_KB', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) || CHAR(32) || RPAD('MAX_MEM_MB', 10) || CHAR(32) || 
    LPAD('AVG_NSE_PINNED_MB', 17) || CHAR(32) || LPAD('MAX_NSE_PINNED_MB', 17) || CHAR(32) || LPAD('AVG_NSE_IO_MB', 13) || CHAR(32) || LPAD('MAX_NSE_IO_MB', 13) || CHAR(32) || 
    RPAD('LAST_INVALIDATION_REASON', 50) FROM BASIS_INFO UNION ALL
  SELECT 3342, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || 
    LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || 
    RPAD('=', 50, '=') FROM BASIS_INFO UNION ALL
  SELECT 3343, RPAD('CURRENT', 19) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(PLAN_MEMORY_SIZE / 1024)), 11) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(AVG_EXECUTION_MEMORY_SIZE / 1024 / 1024)), 10) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(MAX_EXECUTION_MEMORY_SIZE / 1024 / 1024)), 10) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(AVG_BUFFER_CACHE_PINNED_MEMORY_SIZE / 1024 / 1024)), 17) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(MAX_BUFFER_CACHE_PINNED_MEMORY_SIZE / 1024 / 1024)), 17) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(AVG_BUFFER_CACHE_IO_READ_SIZE / 1024 / 1024)), 13) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(MAX_BUFFER_CACHE_IO_READ_SIZE / 1024 / 1024)), 13) || CHAR(32) ||
    LAST_INVALIDATION_REASON
  FROM
  ( SELECT HOST_LEN FROM BASIS_INFO ),
    SQL_CACHE_CURRENT
  UNION ALL
  SELECT 3345 + C.LINE_NO / 100, RPAD(TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'), 20) ||
    LPAD(TO_DECIMAL(ROUND(C.PLAN_MEMORY_SIZE / 1024)), 11) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(C.AVG_EXECUTION_MEMORY_SIZE / 1024 / 1024)), 10) || CHAR(32) ||
    LPAD(TO_DECIMAL(ROUND(C.MAX_EXECUTION_MEMORY_SIZE / 1024 / 1024)), 10) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND(C.AVG_BUFFER_CACHE_PINNED_MEMORY_SIZE / 1024 / 1024))), 'n/a'), 17) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND(C.MAX_BUFFER_CACHE_PINNED_MEMORY_SIZE / 1024 / 1024))), 'n/a'), 17) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND(C.AVG_BUFFER_CACHE_IO_READ_SIZE / 1024 / 1024))), 'n/a'), 13) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(TO_DECIMAL(ROUND(C.MAX_BUFFER_CACHE_IO_READ_SIZE / 1024 / 1024))), 'n/a'), 13) || CHAR(32) ||
    C.LAST_INVALIDATION_REASON
  FROM
    BASIS_INFO BI,
    SQL_CACHE_HISTORY C
  WHERE
  ( BI.MAX_RESULT_LINES = -1 OR C.LINE_NO <= BI.MAX_RESULT_LINES ) 
  UNION ALL
  SELECT 3350, ''              FROM DUMMY UNION ALL
  SELECT 3351, RPAD('SNP_TIME', 10) || CHAR(32) || LPAD('PLAN_MEM_KB', 11) || CHAR(32) || LPAD('AVG_MEM_MB', 10) || CHAR(32) || RPAD('MAX_MEM_MB', 10) || CHAR(32) || 
    LPAD('AVG_NSE_PINNED_MB', 17) || CHAR(32) || LPAD('MAX_NSE_PINNED_MB', 17) || CHAR(32) || LPAD('AVG_NSE_IO_MB', 13) || CHAR(32) || LPAD('MAX_NSE_IO_MB', 13) || CHAR(32) || 
    RPAD('LAST_INVALIDATION_REASON', 50) FROM BASIS_INFO UNION ALL
  SELECT 3352, RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || 
    LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 17, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || LPAD('=', 13, '=') || CHAR(32) || 
    RPAD('=', 50, '=') FROM BASIS_INFO UNION ALL
  SELECT
    LINE_NO,
    LINE
  FROM
  ( SELECT BI.MAX_RESULT_LINES, ROW_NUMBER () OVER (ORDER BY TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD') DESC) ROWNO, 3355 + MIN(C.LINE_NO) / 1000 LINE_NO, RPAD(TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD'), 10) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(MAX(C.PLAN_MEMORY_SIZE) / 1024)), 11) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(AVG(C.AVG_EXECUTION_MEMORY_SIZE) / 1024 / 1024)), 10) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(MAX(C.MAX_EXECUTION_MEMORY_SIZE) / 1024 / 1024)), 10) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(AVG(C.AVG_BUFFER_CACHE_PINNED_MEMORY_SIZE) / 1024 / 1024)), 17) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(MAX(C.MAX_BUFFER_CACHE_PINNED_MEMORY_SIZE) / 1024 / 1024)), 17) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(AVG(C.AVG_BUFFER_CACHE_IO_READ_SIZE) / 1024 / 1024)), 13) || CHAR(32) ||
      LPAD(TO_DECIMAL(ROUND(MAX(C.MAX_BUFFER_CACHE_IO_READ_SIZE) / 1024 / 1024)), 13) || CHAR(32) ||
      MAP(MIN(C.LAST_INVALIDATION_REASON), MAX(C.LAST_INVALIDATION_REASON), MIN(C.LAST_INVALIDATION_REASON), 'various') LINE
    FROM
      BASIS_INFO BI,
      SQL_CACHE_HISTORY C
    GROUP BY
      BI.MAX_RESULT_LINES,
      BI.HOST_LEN,
      TO_VARCHAR(C.SERVER_TIMESTAMP, 'YYYY/MM/DD'),
      C.PLAN_ID,
      C.HOST
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROWNO <= GREATEST(42, MAX_RESULT_LINES) ) 
  UNION ALL
  SELECT 3390, ''                             FROM MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3400, '****************************' FROM MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3401, '* MDS STATEMENT STATISTICS *' FROM MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3402, '****************************' FROM MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3403, ''                             FROM MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3410, RPAD('HOST', HOST_LEN) || CHAR(32) ||  'EXECUTIONS TOT_TIME_S AVG_TIME_S MAX_MEM_MB TYPE      APPLICATION_NAME              DB_USER                       APPLICATION_USER             ' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3420, RPAD('=', HOST_LEN, '=') || CHAR(32) || '========== ========== ========== ========== ========= ============================= ============================= =============================' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), MULTIDIMENSIONAL_STATEMENT_STATISTICS UNION ALL
  SELECT 3430, RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(EXECUTION_COUNT, 10) || LPAD(TO_DECIMAL(TOTAL_EXECUTION_TIME / 1000, 10, 2), 11) || 
    LPAD(TO_DECIMAL(MAP(EXECUTION_COUNT, 0, 0, TOTAL_EXECUTION_TIME / EXECUTION_COUNT), 10, 2), 11) || LPAD(TO_DECIMAL(MAX_EXECUTION_MEMORY_SIZE / 1024 / 1024, 10, 2), 11) || CHAR(32) ||
    RPAD(STATEMENT_TYPE, 10) || RPAD(APPLICATION_NAME, 30) || RPAD(USER_NAME, 30) || RPAD(APPLICATION_USER_NAME, 30)
  FROM
    ( SELECT HOST_LEN FROM BASIS_INFO ), 
    MULTIDIMENSIONAL_STATEMENT_STATISTICS
  UNION ALL
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
  SELECT TOP 1 3590, ''                          FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3591, '*************************' FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3592, '* PROCEDURE INFORMATION *' FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3593, '*************************' FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3594, ''                          FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3595, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('PROCEDURE_NAME', PROCEDURE_LEN) || CHAR(32) || RPAD('PROC_TYPE', 10) || CHAR(32) || RPAD('DEPENDENT_OBJECTS', 79) FROM ACCESSED_PROCEDURES UNION ALL
  SELECT TOP 1 3596, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', PROCEDURE_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 79, '=') FROM ACCESSED_PROCEDURES UNION ALL
  SELECT 3600 + ROW_NUMBER() OVER (ORDER BY P.SCHEMA_NAME, P.PROCEDURE_NAME), RPAD(P.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(P.PROCEDURE_NAME, PROCEDURE_LEN) || CHAR(32) || RPAD(P.PROCEDURE_TYPE, 10) ||
    CHAR(32) || IFNULL(STRING_AGG(D.BASE_OBJECT_NAME, ', ' ORDER BY D.BASE_OBJECT_NAME), '')
  FROM
    ACCESSED_PROCEDURES P LEFT OUTER JOIN
    OBJECT_DEPENDENCIES D ON
      P.SCHEMA_NAME = D.DEPENDENT_SCHEMA_NAME AND
      P.PROCEDURE_NAME = D.DEPENDENT_OBJECT_NAME
  GROUP BY
    P.SCHEMA_NAME,
    P.PROCEDURE_NAME,
    P.PROCEDURE_TYPE,
    P.PROCEDURE_LEN,
    P.SCHEMA_LEN
  UNION ALL
  SELECT TOP 1 3650, ''                         FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3651, '************************' FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3652, '* FUNCTION INFORMATION *' FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3653, '************************' FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3654, ''                         FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3655, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('FUNCTION_NAME', FUNCTION_LEN) || CHAR(32) || RPAD('FUNC_TYPE', 10) || CHAR(32) || 
    RPAD('USAGE_TYPE', 10) || CHAR(32) || RPAD('DEPENDENT_OBJECTS', 79) FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT TOP 1 3656, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', FUNCTION_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || 
    RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 79, '=') FROM ACCESSED_FUNCTIONS UNION ALL
  SELECT 3660 + ROW_NUMBER() OVER (ORDER BY F.SCHEMA_NAME, F.FUNCTION_NAME) / 100, RPAD(F.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(F.FUNCTION_NAME, FUNCTION_LEN) || CHAR(32) || RPAD(F.FUNCTION_TYPE, 10) || CHAR(32) ||
    RPAD(F.USAGE_TYPE, 10) || CHAR(32) ||IFNULL(STRING_AGG(D.BASE_OBJECT_NAME, ', ' ORDER BY D.BASE_OBJECT_NAME), '')
  FROM
    ACCESSED_FUNCTIONS F LEFT OUTER JOIN
    OBJECT_DEPENDENCIES D ON
      F.SCHEMA_NAME = D.DEPENDENT_SCHEMA_NAME AND
      F.FUNCTION_NAME = D.DEPENDENT_OBJECT_NAME
  GROUP BY
    F.SCHEMA_NAME,
    F.FUNCTION_NAME,
    F.FUNCTION_TYPE,
    F.USAGE_TYPE,
    F.FUNCTION_LEN,
    F.SCHEMA_LEN
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
  SELECT TOP 1 4010, '* TABLE INFORMATION *' FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4020, '*********************' FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4030, ''                      FROM ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4080, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('TYPE', 6) || CHAR(32) ||
    LPAD('PARTS', 6) || CHAR(32) || LPAD('RECORDS', 11) || CHAR(32) || LPAD('MEM_TOTAL_GB', 12) || CHAR(32) || LPAD('MEM_DELTA_GB', 12) || CHAR(32) || LPAD('CURR_DISK_GB', 12) || CHAR(32) ||
    LPAD('MIN_DISK_GB', 11) || CHAR(32) || LPAD('MAX_DISK_GB', 11) || CHAR(32) || RPAD('LOAD_UNIT', 9) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || 
    LPAD('TABLE_SCANS_PER_S', 17) FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ACCESSED_TABLES UNION ALL
  SELECT TOP 1 4090, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) ||
    LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || 
    LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) ||
    LPAD('=', 17, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ACCESSED_TABLES UNION ALL
  SELECT 4100 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME), RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(TABLE_TYPE, 6) || CHAR(32) || 
    LPAD(PARTITIONS, 6) || CHAR(32) || LPAD(RECORDS, 11) || CHAR(32) || LPAD(IFNULL(MEM_TOTAL_GB, 0.00), 12) || CHAR(32) || LPAD(IFNULL(MEM_DELTA_GB, 0.00), 12) || CHAR(32) || LPAD(IFNULL(CURR_DISK_GB, 0.00), 12) || CHAR(32) ||
    LPAD(IFNULL(TO_VARCHAR(MIN_DISK_GB), 'n/a'), 11) || CHAR(32) || LPAD(IFNULL(TO_VARCHAR(MAX_DISK_GB), 'n/a'), 11) || CHAR(32) || RPAD(LOAD_UNIT, 9) || CHAR(32) ||
    RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(TABLE_SCANS_PER_S, 17)
  FROM
  ( SELECT HOST_LEN FROM BASIS_INFO ),
  ( SELECT TOP 1 TABLE_LEN FROM ACCESSED_TABLES ),
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
      T.SCHEMA_LEN,
      T.LOAD_UNIT,
      ( SELECT TO_DECIMAL(SUM(D.DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM M_TABLE_PERSISTENCE_STATISTICS D WHERE D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME ) CURR_DISK_GB,
      ( SELECT TO_DECIMAL(MIN(DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM ( SELECT SUM(D.DISK_SIZE) DISK_SIZE FROM 
          _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS D WHERE D.SITE_ID IN (-1, 0, CURRENT_SITE_ID()) AND D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME GROUP BY D.SNAPSHOT_ID ) ) MIN_DISK_GB,
      ( SELECT TO_DECIMAL(MAX(DISK_SIZE / 1024 / 1024 / 1024), 10, 2) FROM ( SELECT SUM(D.DISK_SIZE) DISK_SIZE FROM 
          _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS D WHERE D.SITE_ID IN (-1, 0, CURRENT_SITE_ID()) AND D.SCHEMA_NAME = T.SCHEMA_NAME AND D.TABLE_NAME = T.TABLE_NAME GROUP BY D.SNAPSHOT_ID ) ) MAX_DISK_GB
    FROM
    ( SELECT
        T.SCHEMA_NAME,
        T.TABLE_NAME,
        MAP(MIN(T.HOST), MAX(T.HOST), MIN(T.HOST), 'various') HOST,
        'COLUMN' TABLE_TYPE,
        COUNT(*) PARTITIONS,
        SUM(T.RECORD_COUNT) RECORDS,
        TO_DECIMAL(SUM((T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 / 1024), 10, 2) MEM_TOTAL_GB,
        TO_DECIMAL(SUM(T.MEMORY_SIZE_IN_DELTA / 1024 / 1024 / 1024), 10, 2) MEM_DELTA_GB,
        0 TABLE_SCANS_PER_S,
        MAX(AC.LOAD_UNIT) LOAD_UNIT,
        AC.SCHEMA_LEN
      FROM
        ACCESSED_TABLES AC,
        M_CS_TABLES T
      WHERE
        AC.SCHEMA_NAME = T.SCHEMA_NAME AND
        AC.TABLE_NAME = T.TABLE_NAME
      GROUP BY
        T.SCHEMA_NAME,
        T.TABLE_NAME,
        AC.SCHEMA_LEN
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
        TO_DECIMAL(SUM(T.SCAN_COUNT) / S.TIMEFRAME_S, 10, 2) TABLE_SCANS_PER_S,
        'COLUMN' LOAD_UNIT,
        AC.SCHEMA_LEN
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
        T.TABLE_NAME,
        AC.SCHEMA_LEN
    ) T
  ) UNION ALL
  SELECT TOP 1 4490, ''                              FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4500, '*****************************' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4510, '* VIRTUAL TABLE INFORMATION *' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4520, '*****************************' FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4530, ''                              FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4580, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('REMOTE_SOURCE_NAME', 18) || CHAR(32) ||
    RPAD('REMOTE_OBJECT_NAME', REMOTE_OBJECT_LEN) FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT TOP 1 4590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', 18, '=') || CHAR(32) ||
    RPAD('=', REMOTE_OBJECT_LEN, '=') FROM ACCESSED_VIRTUAL_TABLES UNION ALL
  SELECT 4600 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME) / 100, RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(REMOTE_SOURCE_NAME, 18) || CHAR(32) || 
    RPAD(REMOTE_OBJECT_NAME, REMOTE_OBJECT_LEN) FROM ACCESSED_VIRTUAL_TABLES
  UNION ALL
  SELECT TOP 1 4890, ''                      FROM ( SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 4900, '*********************' FROM ( SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 4910, '* INDEX INFORMATION *' FROM ( SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 4920, '*********************' FROM ( SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 4930, ''                      FROM ( SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEXES UNION ALL SELECT 1 FROM ACCESSED_INDEX_COLUMNS_2 ) UNION ALL
  SELECT TOP 1 4980, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('INDEX_NAME', INDEX_LEN) || CHAR(32) ||
    RPAD('TY', 2) || CHAR(32) || LPAD('MEM_TOT_MB', 10) || CHAR(32) || LPAD('MEM_CONC_MB', 11) || CHAR(32) || LPAD('INDIV_COSTS', 11) || CHAR(32) || RPAD('INDIV_COLUMN', INDIV_COL_LEN) FROM ACCESSED_INDEXES UNION ALL
  SELECT TOP 1 4990, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', INDEX_LEN, '=') || CHAR(32) ||
    RPAD('=', 2, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', INDIV_COL_LEN, '=') FROM ACCESSED_INDEXES UNION ALL
  SELECT 5000 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, INDEX_NAME_NO_PART, PART_ID) / 100, RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) || RPAD(INDEX_NAME, INDEX_LEN) || CHAR(32) ||
    RPAD(TY, 2) || CHAR(32) || LPAD(MEM_TOT_MB, 10) || CHAR(32) || LPAD(MEM_CONC_MB, 11) || CHAR(32) || MAP(INDIV_COSTS, -1, LPAD('', 11), LPAD(INDIV_COSTS, 11)) || CHAR(32) || RPAD(INDIV_COLUMN, INDIV_COL_LEN)
  FROM
    ACCESSED_INDEXES UNION ALL
  SELECT TOP 1 5070, ''                       FROM DUMMY UNION ALL
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
    RPAD('LOAD_UNIT', 9) || CHAR(32) || LPAD('SCANNED_RECS_PER_S', 18) || CHAR(32) || LPAD('INDEX_LOOKUPS_PER_H', 19) FROM ACCESSED_COLUMNS UNION ALL
  SELECT TOP 1 6090, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || RPAD('=', COLUMN_LEN, '=') || CHAR(32) || LPAD('=', 12, '=') ||
    CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) ||
    RPAD('=', 9, '=') || CHAR(32) || LPAD('=', 18, '=') || CHAR(32) || LPAD('=', 19, '=') FROM ACCESSED_COLUMNS UNION ALL
  SELECT 6100 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME) / 100,
    RPAD(MAP(ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME), 1, SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) ||
    RPAD(MAP(ROW_NUMBER() OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY SCHEMA_NAME, TABLE_NAME, COLUMN_NAME), 1, TABLE_NAME, ''), TABLE_LEN) || CHAR(32) || 
    RPAD(COLUMN_NAME, COLUMN_LEN) || CHAR(32) || LPAD(NUM_DISTINCT, 12) || CHAR(32) ||
    LPAD(SIZE_MB, 12) || CHAR(32) || LPAD(LENGTH, 7) || CHAR(32) || RPAD(DATA_TYPE, 14) || CHAR(32) || RPAD(COMPRESSION, 11) || CHAR(32) || RPAD(INDEX_TYPE, 10) || CHAR(32) ||
    RPAD(LOAD_UNIT, 9) || CHAR(32) || LPAD(MAP(SCANNED_RECS_PER_S, -1, 'n/a', TO_VARCHAR(SCANNED_RECS_PER_S)), 18) || CHAR(32) || LPAD(MAP(INDEX_LOOKUPS_PER_H, -1, 'n/a', TO_VARCHAR(INDEX_LOOKUPS_PER_H)), 19)
  FROM
    ACCESSED_COLUMNS
  UNION ALL
  SELECT TOP 1 6290, ''                    FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6300, '*******************' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6310, '* LOB INFORMATION *' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6320, '*******************' FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6330, ''                    FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6380, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', 40) || CHAR(32) || RPAD('COLUMN_NAME', 30) || CHAR(32) || RPAD('LOB_TYPE', 8) || 
    CHAR(32) || LPAD('DISK_GB', 10) || CHAR(32) || LPAD('BINARY_GB', 10) || CHAR(32) || LPAD('LOB_COUNT', 10) FROM ACCESSED_LOBS UNION ALL
  SELECT TOP 1 6390, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', 40, '=') || CHAR(32) || RPAD('=', 30, '=') || CHAR(32) || RPAD('=', 8, '=') || CHAR(32) ||
    LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 10, '=') FROM ACCESSED_LOBS UNION ALL
  SELECT 6400 + ROW_NUMBER() OVER (ORDER BY L.SCHEMA_NAME, L.TABLE_NAME, L.COLUMN_NAME) / 100, 
    RPAD(L.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(L.TABLE_NAME, 40) || CHAR(32) || RPAD(L.COLUMN_NAME, 30) || CHAR(32) || RPAD(L.LOB_TYPE, 8) || 
    CHAR(32) || LPAD(L.DISK_GB, 10) || CHAR(32) || LPAD(L.BINARY_GB, 10) || CHAR(32) || LPAD(L.LOB_COUNT, 10)
  FROM
    ACCESSED_LOBS L UNION ALL
  SELECT TOP 1 6490, ''                          FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6500, '*************************' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6510, '* PARTITION INFORMATION *' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6520, '*************************' FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6530, ''                          FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6580, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || 
    RPAD('HOST', HOST_LEN) || CHAR(32) || LPAD('MEM_SIZE_GB', 11) || CHAR(32) || 
    LPAD('RECORDS', 12) || CHAR(32) || RPAD('LOAD_UNIT', 9) || CHAR(32) || RPAD('LEVEL_1_PARTITIONING', L1_LEN) || CHAR(32) || RPAD('LEVEL_2_PARTITIONING', L2_LEN) FROM ACCESSED_PARTITIONS UNION ALL
  SELECT TOP 1 6590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || 
    RPAD('=', HOST_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || 
    LPAD('=', 12, '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) || RPAD('=', L1_LEN, '=') || CHAR(32) || RPAD('=', L2_LEN, '=') FROM ACCESSED_PARTITIONS UNION ALL
  SELECT 6600 + ROW_NUMBER() OVER (ORDER BY TP.SCHEMA_NAME, TP.TABLE_NAME, TP.PART_ID) / 100, 
    RPAD(MAP(TP.PART_ID, 0, TP.SCHEMA_NAME, 1, TP.SCHEMA_NAME, ''), SCHEMA_LEN) || CHAR(32) || RPAD(TP.TABLE_NAME || CHAR(32) || '(' || TP.PART_ID || ')', TP.TABLE_LEN) || CHAR(32) || 
    RPAD(TP.HOST, TP.HOST_LEN) || CHAR(32) || LPAD(TO_DECIMAL(TP.MEM_SIZE_GB, 10, 2), 11) || CHAR(32) || 
    LPAD(TP.RECORDS, 12) || CHAR(32) || RPAD(TP.LOAD_UNIT, 9) || CHAR(32) || RPAD(TP.LEVEL_1_PARTITIONING, L1_LEN) || CHAR(32) || RPAD(TP.LEVEL_2_PARTITIONING, L2_LEN)
  FROM
    ACCESSED_PARTITIONS TP UNION ALL
  SELECT TOP 1 6690, ''                            FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6700, '***************************' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6710, '* REFERENTIAL CONSTRAINTS *' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6720, '***************************' FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6730, ''                            FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6780, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) || RPAD('COLUMN_NAME', COLUMN_LEN) || CHAR(32) || LPAD('POS', 3) || CHAR(32) ||
    RPAD('REF_SCHEMA_NAME', 19) || CHAR(32) || RPAD('REF_TABLE_NAME', REF_TABLE_LEN) || CHAR(32) || RPAD('REF_COLUMN_NAME', REF_COLUMN_LEN) FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT TOP 1 6790, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) || LPAD('=', COLUMN_LEN, '=') || CHAR(32) || LPAD('=', 3, '=') || CHAR(32) ||
    RPAD('=', 19, '=') || CHAR(32) || RPAD('=', REF_TABLE_LEN, '=') || CHAR(32) || LPAD('=', REF_COLUMN_LEN, '=') FROM ACCESSED_REFERENTIAL_CONSTRAINTS UNION ALL
  SELECT 6800 + ROW_NUMBER() OVER (ORDER BY AC.SCHEMA_NAME, AC.TABLE_NAME, AC.COLUMN_NAME) / 100, RPAD(AC.SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(AC.TABLE_NAME, TABLE_LEN) || CHAR(32) ||
    RPAD(AC.COLUMN_NAME, COLUMN_LEN) || CHAR(32) || LPAD(AC.POSITION, 3) || CHAR(32) || RPAD(AC.REFERENCED_SCHEMA_NAME, 20) || 
    RPAD(AC.REFERENCED_TABLE_NAME, REF_TABLE_LEN) || CHAR(32) || RPAD(AC.REFERENCED_COLUMN_NAME, REF_COLUMN_LEN)
  FROM
    ACCESSED_REFERENTIAL_CONSTRAINTS AC UNION ALL
  SELECT TOP 1 6890, ''             FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6891, '************' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6892, '* TRIGGERS *' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6893, '************' FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6894, ''             FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6895, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('TABLE_NAME', TABLE_LEN) || CHAR(32) ||
    RPAD('TRIGGER_NAME', TRIGGER_LEN) || CHAR(32) || RPAD('ACTION_TIME', 11) || CHAR(32) || RPAD('EVENT', 6) || CHAR(32) || 
    RPAD('ACTION_LEVEL', 12) || CHAR(32) || RPAD('IS_VALID', 8) || CHAR(32) || RPAD('IS_ENABLED', 10) || CHAR(32) || RPAD('CREATE_TIME', 19) FROM ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6896, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') || CHAR(32) ||
    RPAD('=', TRIGGER_LEN, '=') || CHAR(32) || RPAD('=', 11, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) || 
    RPAD('=', 12, '=') || CHAR(32) || RPAD('=', 8, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 19, '=') FROM ACCESSED_TRIGGERS UNION ALL
  SELECT 6900 + ROW_NUMBER() OVER (ORDER BY TRIGGER_NAME) / 100, RPAD(SUBJECT_TABLE_SCHEMA, SCHEMA_LEN) || CHAR(32) || RPAD(SUBJECT_TABLE_NAME, TABLE_LEN) || CHAR(32) || 
    RPAD(TRIGGER_NAME, TRIGGER_LEN) || CHAR(32) || RPAD(TRIGGER_ACTION_TIME, 11) || CHAR(32) || RPAD(TRIGGER_EVENT, 6) || CHAR(32) ||
    RPAD(TRIGGERED_ACTION_LEVEL, 12) || CHAR(32) || RPAD(IS_VALID, 8) || CHAR(32) || RPAD(IS_ENABLED, 10) || CHAR(32) || RPAD(CREATE_TIME, 19)
  FROM
    ACCESSED_TRIGGERS UNION ALL
  SELECT TOP 1 6990, ''                   FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7000, '******************' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7010, '* TABLE REPLICAS *' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7020, '******************' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7030, ''                   FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7080, RPAD('HOST', 29) || CHAR(32) || RPAD('SOURCE_SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('SOURCE_TABLE_NAME', SRC_TABLE_LEN) || CHAR(32) || LPAD('PART_ID', 7) ||
    CHAR(32) || RPAD('REPLICA_TYPE', 13) || CHAR(32) || 'REPLICA_NAME' FROM ACCESSED_REPLICAS UNION ALL
  SELECT TOP 1 7090, RPAD('=', 29, '=') || CHAR(32) || RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', SRC_TABLE_LEN, '=') || CHAR(32) || LPAD('=', 7, '=') ||
    CHAR(32) || RPAD('=', 13, '=') || CHAR(32) || RPAD('=', 50, '=') FROM ACCESSED_REPLICAS UNION ALL
  SELECT 7100 + ROW_NUMBER() OVER (ORDER BY R.SOURCE_SCHEMA_NAME, R.SOURCE_TABLE_NAME, R.PART_ID, R.HOST) / 1000, RPAD(R.HOST, 30) || RPAD(R.SOURCE_SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) ||
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
    LPAD('RUNTIME_S', 10) || CHAR(32) || LPAD('RW_S', 5) || CHAR(32) || LPAD('P1_HLW_S', 8) || CHAR(32) || LPAD('P1_BLW_S', 8) || CHAR(32) ||
    LPAD('P1_L_S', 6) || CHAR(32) || LPAD('P2_HLW_S', 8) || CHAR(32) || LPAD('P2_BLW_S', 8) || CHAR(32) ||
    LPAD('P2_L_S', 6) || CHAR(32) || 'LAST_ERROR' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), TABLE_OPTIMIZATIONS UNION ALL
  SELECT TOP 1 7590, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') ||
    CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 14, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || LPAD('=', 11, '=') ||
    CHAR(32) || LPAD('=', 9, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) ||
    LPAD('=', 6, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) ||
    LPAD('=', 6, '=') || CHAR(32) || RPAD('=', 70, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), TABLE_OPTIMIZATIONS UNION ALL
  SELECT 7600 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC, SCHEMA_NAME, TABLE_NAME) / 1000, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || 
    RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(TABLE_NAME, TABLE_LEN) || CHAR(32) ||
    RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(TYPE, 14) || CHAR(32) || RPAD(MOTIVATION, 10) || LPAD(MERGED_ROWS, 12) || 
    LPAD(RUNTIME_S, 10) || CHAR(32) || LPAD(RW_S, 5) || CHAR(32) || LPAD(P1_HLW_S, 8) || CHAR(32) || LPAD(P1_BLW_S, 8) || CHAR(32) ||
    LPAD(P1_L_S, 6) || CHAR(32) || LPAD(P2_HLW_S, 8) || CHAR(32) || LPAD(P2_BLW_S, 8) || CHAR(32) ||
    LPAD(P2_L_S, 6) || CHAR(32) || LAST_ERROR
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
  SELECT TOP 1 7790, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', 6, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || RPAD('=', TABLE_LEN, '=') ||
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
  SELECT TOP 1 7990, ''                               FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8000, '******************************' FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8010, '* EXPENSIVE STATEMENTS TRACE *' FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8020, '******************************' FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8030, ''                               FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8080, RPAD('START_TIME', 19) || CHAR(32) || RPAD('OPERATION', OPERATION_LEN) || CHAR(32) || LPAD('DURATION_S', 11) || CHAR(32) || LPAD('CPU_S', 10) || CHAR(32) || LPAD('RECORDS', 9) ||
    CHAR(32) || LPAD('MEM_MB', 8) ||  CHAR(32) || RPAD('WORKLOAD_CLASS', WLC_LEN) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || RPAD('APP_SOURCE', APP_SOURCE_LEN) || CHAR(32) || 'ERROR' FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', OPERATION_LEN, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 10, '=') || CHAR(32) || LPAD('=', 9, '=') || CHAR(32) ||
    LPAD('=', 8, '=') || CHAR(32) || RPAD('=', WLC_LEN, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_SOURCE_LEN, '=') || CHAR(32) || LPAD('=', 50, '=') FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT 8100 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC, OPERATION) / 100, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(OPERATION, OPERATION_LEN) || CHAR(32) ||
    LPAD(TO_VARCHAR(TO_DECIMAL(DURATION_MICROSEC / 1000000, 10, 2)), 11) || LPAD(TO_VARCHAR(TO_DECIMAL(CPU_TIME / 1000000, 10, 2)), 11) || LPAD(RECORDS, 10) ||
    LPAD(TO_DECIMAL(ROUND(MEMORY_SIZE / 1024 / 1024), 10, 0), 9) || CHAR(32) || RPAD(WORKLOAD_CLASS, WLC_LEN) || CHAR(32) || RPAD(APP_USER, APP_USER_LEN) || CHAR(32) || RPAD(APPLICATION_SOURCE, APP_SOURCE_LEN) || CHAR(32) || 
    ERROR_CODE || MAP(ERROR_TEXT, '', '', ':' || CHAR(32) || ERROR_TEXT)
  FROM
    EXPENSIVE_STATEMENTS
  UNION ALL
  SELECT TOP 1 8570, '' FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8580, RPAD('START_TIME', 19) || CHAR(32) || RPAD('BIND_VALUES', 100) FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT TOP 1 8590, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 100, '=') FROM EXPENSIVE_STATEMENTS UNION ALL
  SELECT 8600 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC) / 100, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(PARAMETERS, 180)
  FROM
  ( SELECT
      ROW_NUMBER() OVER (ORDER BY ES.START_TIME DESC) LINE_NO,
      ES.START_TIME,
      ES.PARAMETERS,
      BI.MAX_RESULT_LINES
    FROM
      BASIS_INFO BI,
      EXPENSIVE_STATEMENTS ES
    WHERE
      ES.STATEMENT_HASH = BI.STATEMENT_HASH AND
      ES.PARAMETERS != ''
  )
  UNION ALL
  SELECT TOP 1 8690, ''                              FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8700, '*****************************' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8710, '* EXECUTED STATEMENTS TRACE *' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8720, '*****************************' FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8730, ''                              FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8780, RPAD('START_TIME', 19) || CHAR(32) || LPAD('DURATION_S', 11) ||  CHAR(32) || LPAD('ERROR', 5) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || 
    RPAD('APP_SOURCE', APP_SOURCE_LEN) FROM EXECUTED_STATEMENTS UNION ALL
  SELECT TOP 1 8790, RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 11, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || 
    RPAD('=', APP_SOURCE_LEN, '=') FROM EXECUTED_STATEMENTS UNION ALL
  SELECT 8800 + ROW_NUMBER() OVER (ORDER BY START_TIME DESC) / 100, RPAD(TO_VARCHAR(START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) ||
    LPAD(TO_VARCHAR(TO_DECIMAL(DURATION_MICROSEC / 1000000, 10, 2)), 11) || LPAD(ERROR_CODE, 6) || CHAR(32) || RPAD(APP_USER, APP_USER_LEN) || CHAR(32) || RPAD(APPLICATION_SOURCE, APP_SOURCE_LEN)
  FROM
    EXECUTED_STATEMENTS
  UNION ALL
  SELECT TOP 1 8990, ''                        FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9000, '***********************' FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9010, '* TRANSACTIONAL LOCKS *' FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9020, '***********************' FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9030, ''                        FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9100, RPAD('LOCK_TIME', 19) || CHAR(32) || RPAD('BLOCKED_STATEMENT_HASH', 32) || CHAR(32) || RPAD('BLOCKING_STATEMENT_HASH', 32) || CHAR(32) || LPAD('WAIT_S', 8) || CHAR(32) ||
    RPAD('LOCK_TYPE', TYPE_LEN) || CHAR(32) || RPAD('LOCK_MODE', MODE_LEN) || CHAR(32) || RPAD('OBJECT_NAME', 40) FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT TOP 1 9110, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || LPAD('=', 8, '=') || CHAR(32) ||
    RPAD('=', TYPE_LEN, '=') || CHAR(32) || RPAD('=', MODE_LEN, '=') || CHAR(32) || RPAD('=', 40, '=') FROM TRANSACTIONAL_LOCKS UNION ALL
  SELECT 9120 + ROW_NUMBER() OVER (ORDER BY SERVER_TIMESTAMP DESC), RPAD(SERVER_TIMESTAMP, 19) || CHAR(32) || RPAD(BLOCKED_STATEMENT_HASH, 32) || CHAR(32) ||
    RPAD(LOCK_OWNER_STATEMENT_HASH, 32) || CHAR(32) || LPAD(WAIT_S, 8) || CHAR(32) ||
    RPAD(LOCK_TYPE, TYPE_LEN) || CHAR(32) || RPAD(LOCK_MODE, MODE_LEN) || CHAR(32) || OBJECT_NAME
  FROM
    TRANSACTIONAL_LOCKS
  WHERE
    MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES UNION ALL
  SELECT TOP 1  9990, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10000, '******************' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10010, '* THREAD SAMPLES *' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10020, '******************' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || RPAD('PORT', 5) || CHAR(32) || 'THREAD_TYPE' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) || RPAD('=', 5, '=') || CHAR(32) || RPAD('=', 30, '=') FROM ( SELECT HOST_LEN FROM BASIS_INFO ), THREAD_SAMPLES UNION ALL
  SELECT 10100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(PORT, 5) || CHAR(32) || THREAD_TYPE
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
  SELECT TOP 1 10470, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10480, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_TYPE', TYPE_LEN) || CHAR(32) || 
    RPAD('THREAD_STATE', STATE_LEN) || CHAR(32) || RPAD('Q', 1) || CHAR(32) || RPAD('LOCK_NAME', 70) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10490, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', TYPE_LEN, '=') || CHAR(32) || 
    RPAD('=', STATE_LEN, '=') || CHAR(32) || RPAD('=', 1, '=') || CHAR(32) || RPAD('=', 70, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 10500 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_TYPE, TYPE_LEN) || CHAR(32) || 
    RPAD(THREAD_STATE, STATE_LEN) || CHAR(32) || RPAD(Q, 1) || CHAR(32) || LOCK_NAME
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      THREAD_STATE,
      THREAD_TYPE,
      LOCK_NAME,
      Q,
      MAX_RESULT_LINES,
      GREATEST(12, MAX(LENGTH(THREAD_STATE)) OVER ()) STATE_LEN,
      MAX(LENGTH(THREAD_TYPE)) OVER () TYPE_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, THREAD_STATE, LOCK_NAME) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.THREAD_STATE,
        TS.THREAD_TYPE,
        TS.LOCK_NAME,
        TS.Q,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.THREAD_STATE,
        TS.THREAD_TYPE,
        TS.LOCK_NAME,
        TS.Q,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 10730, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10780, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_TYPE', TYPE_LEN) || CHAR(32) || RPAD('THREAD_METHOD', 50) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 10790, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', TYPE_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 10800 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_TYPE, TYPE_LEN) || CHAR(32) || THREAD_METHOD
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
  SELECT TOP 1 11030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 11080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('THREAD_TYPE', TYPE_LEN) || CHAR(32) || RPAD('THREAD_METHOD', METHOD_LEN) || CHAR(32) || 
    RPAD('THREAD_DETAIL', 80) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 11090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', TYPE_LEN, '=') || CHAR(32) || RPAD('=', METHOD_LEN, '=') || CHAR(32) || 
    RPAD('=', 80, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 11100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(THREAD_TYPE, TYPE_LEN) || CHAR(32) || RPAD(THREAD_METHOD, METHOD_LEN) || CHAR(32) || THREAD_DETAIL
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
  SELECT TOP 1 12030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12080, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('DB_USER', DB_USER_LEN) || CHAR(32) || RPAD('APP_USER', APP_USER_LEN) || CHAR(32) || 
    RPAD('APP_NAME', APP_NAME_LEN) || CHAR(32) || RPAD('APP_SOURCE', 50) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12090, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', DB_USER_LEN, '=') || CHAR(32) || RPAD('=', APP_USER_LEN, '=') || CHAR(32) || 
    RPAD('=', APP_NAME_LEN, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 12100 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(DB_USER, DB_USER_LEN) || CHAR(32) || RPAD(APP_USER, APP_USER_LEN) || CHAR(32) ||
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
  SELECT TOP 1 12130, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12180, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('PASSPORT_COMPONENT', PASSPORT_COMPONENT_LEN) || CHAR(32) || 
    RPAD('PASSPORT_ACTION', PASSPORT_ACTION_LEN) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12190, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', PASSPORT_COMPONENT_LEN, '=') || CHAR(32) || 
    RPAD('=', PASSPORT_ACTION_LEN, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 12200 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(PASSPORT_COMPONENT, PASSPORT_COMPONENT_LEN) || CHAR(32) ||
    RPAD(PASSPORT_ACTION, PASSPORT_ACTION_LEN)
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      PASSPORT_ACTION,
      PASSPORT_COMPONENT,
      MAX_RESULT_LINES,
      PASSPORT_ACTION_LEN,
      PASSPORT_COMPONENT_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, PASSPORT_COMPONENT, PASSPORT_ACTION) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.PASSPORT_ACTION,
        TS.PASSPORT_COMPONENT,
        TS.DB_USER_LEN,
        TS.PASSPORT_ACTION_LEN,
        TS.PASSPORT_COMPONENT_LEN,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.PASSPORT_ACTION,
        TS.PASSPORT_COMPONENT,
        TS.DB_USER_LEN,
        TS.PASSPORT_ACTION_LEN,
        TS.PASSPORT_COMPONENT_LEN,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 12230, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12280, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || 
    RPAD('PASSPORT_ACTION', PASSPORT_ACTION_LEN) || CHAR(32) || RPAD('APP_COMP_NAME', APP_COMP_NAME_LEN) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12290, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) ||
    RPAD('=', PASSPORT_ACTION_LEN, '=') || CHAR(32) || RPAD('=', APP_COMP_NAME_LEN, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 12300 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) ||
    RPAD(PASSPORT_ACTION, PASSPORT_ACTION_LEN) || CHAR(32) || RPAD(APP_COMP_NAME, APP_COMP_NAME_LEN)
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      PASSPORT_ACTION,
      APP_COMP_NAME,
      MAX_RESULT_LINES,
      PASSPORT_ACTION_LEN,
      APP_COMP_NAME_LEN,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, PASSPORT_ACTION, APP_COMP_NAME) ROW_NUM
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.PASSPORT_ACTION,
        TS.APP_COMP_NAME,
        TS.DB_USER_LEN,
        TS.PASSPORT_ACTION_LEN,
        TS.APP_COMP_NAME_LEN,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.PASSPORT_ACTION,
        TS.APP_COMP_NAME,
        TS.DB_USER_LEN,
        TS.PASSPORT_ACTION_LEN,
        TS.APP_COMP_NAME_LEN,
        BI.MAX_RESULT_LINES
    )
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 12330, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12380, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('CLIENT_IP', 15) || CHAR(32) || LPAD('CLIENT_PID', 10) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12390, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || RPAD('=', 10, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 12400 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(CLIENT_IP, 15) || CHAR(32) || LPAD(CLIENT_PID, 10)
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
  SELECT TOP 1 12530, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12580, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('ROOT_STATEMENT_HASH', 32) || CHAR(32) || 'STATEMENT_STRING' FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 12590, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 12600 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(ROOT_STATEMENT_HASH, 32) || CHAR(32) || IFNULL(STATEMENT_STRING, '')
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      ROOT_STATEMENT_HASH,
      ( SELECT MAX(SUBSTR(STATEMENT_STRING, 1, 1000)) FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE SP WHERE SP.STATEMENT_HASH = T.ROOT_STATEMENT_HASH ) STATEMENT_STRING,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, ROOT_STATEMENT_HASH) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.ROOT_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.ROOT_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
    ) T
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 12730, ''                   FROM THREAD_SAMPLES_ROOT_HASH UNION ALL
  SELECT TOP 1 12780, LPAD('SAMPLES', 7) || CHAR(32) || LPAD('PERCENT', 7) || CHAR(32) || RPAD('CHILD_STATEMENT_HASH', 32) || CHAR(32) || 'STATEMENT_STRING' FROM THREAD_SAMPLES_ROOT_HASH UNION ALL
  SELECT TOP 1 12790, LPAD('=', 7, '=') || CHAR(32) || LPAD('=', 7, '=') || CHAR(32) || RPAD('=', 32, '=') || CHAR(32) || RPAD('=', 50, '=') FROM THREAD_SAMPLES_ROOT_HASH UNION ALL
  SELECT 12800 + ROW_NUM / 100, LPAD(SAMPLES, 7) || CHAR(32) || LPAD(PERCENT, 7) || CHAR(32) || RPAD(CHILD_STATEMENT_HASH, 32) || CHAR(32) || IFNULL(STATEMENT_STRING, '')
  FROM
  ( SELECT
      SAMPLES,
      TO_DECIMAL(SAMPLES / TOTAL_SAMPLES * 100, 10, 2) PERCENT,
      CHILD_STATEMENT_HASH,
      ( SELECT MAX(SUBSTR(STATEMENT_STRING, 1, 1000)) FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE SP WHERE SP.STATEMENT_HASH = T.CHILD_STATEMENT_HASH ) STATEMENT_STRING,
      ROW_NUMBER () OVER (ORDER BY SAMPLES DESC, CHILD_STATEMENT_HASH) ROW_NUM,
      MAX_RESULT_LINES
    FROM
    ( SELECT
        SUM(TS.SAMPLES) SAMPLES,
        TS.TOTAL_SAMPLES,
        TS.CHILD_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
      FROM
        BASIS_INFO BI,
        THREAD_SAMPLES_ROOT_HASH TS
      GROUP BY
        TS.TOTAL_SAMPLES,
        TS.CHILD_STATEMENT_HASH,
        BI.MAX_RESULT_LINES
    ) T
  )
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) UNION ALL
  SELECT TOP 1 13030, ''                   FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 13080, LPAD('AVG_PARALLELISM', 15) || CHAR(32) || LPAD('MAX_PARALLELISM', 15) || CHAR(32) || LPAD('MAX_TOTAL_THREADS', 30) || CHAR(32) || LPAD('MAX_TOTAL_RUNNING_THREADS', 30) FROM THREAD_SAMPLES UNION ALL
  SELECT TOP 1 13090, LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 15, '=') || CHAR(32) || LPAD('=', 30, '=') || CHAR(32) || LPAD('=', 30, '=') FROM THREAD_SAMPLES UNION ALL
  SELECT 13100, LPAD(TO_DECIMAL(AVG_PARALLELISM, 10, 2), 15) || CHAR(32) || LPAD(MAX_PARALLELISM, 15) || CHAR(32) || LPAD(MAX_THREADS, 30) || CHAR(32) || LPAD(MAX_RUNNING_THREADS, 30) FROM
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
  UNION ALL
  SELECT TOP 1 14990, ''                      FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15000, '*********************' FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15010, '* ACTIVE STATEMENTS *' FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15020, '*********************' FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15030, ''                      FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15080, RPAD('START_TIME', 19) || CHAR(32) || LPAD('EXEC_TIME_MS', 15) || CHAR(32) || LPAD('LAST_ACT_MS', 15) || CHAR(32) || LPAD('CONN_ID', 12) || CHAR(32) || RPAD('STATUS', 19) || CHAR(32) || LPAD('MEM_GB', 10) FROM ACTIVE_STATEMENTS UNION ALL
  SELECT TOP 1 15090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || LPAD('=', 12, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 10, '=') FROM ACTIVE_STATEMENTS UNION ALL
  SELECT 15100 + ROW_NUMBER () OVER (ORDER BY A.LAST_EXECUTED_TIME), RPAD(TO_VARCHAR(A.LAST_EXECUTED_TIME, 'YYYY/MM/DD HH24:MI:SS'), 19) || CHAR(32) ||
    LPAD(TO_DECIMAL(GREATEST(NANO100_BETWEEN(A.LAST_EXECUTED_TIME, CURRENT_TIMESTAMP) / 10000, 0), 10, 2), 15) || CHAR(32) ||
    LPAD(TO_DECIMAL(GREATEST(NANO100_BETWEEN(A.LAST_ACTION_TIME, CURRENT_TIMESTAMP) / 10000, 0), 10, 2), 15) || CHAR(32) ||
    LPAD(A.CONNECTION_ID, 12) || CHAR(32) ||
    RPAD(A.STATEMENT_STATUS, 19) || CHAR(32) || LPAD(TO_DECIMAL(A.ALLOCATED_MEMORY_SIZE / 1024 / 1024 / 1024, 10, 2), 10)
  FROM
    ACTIVE_STATEMENTS A
  UNION ALL
  SELECT TOP 1 15490, ''                      FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15500, '*********************' FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15510, '* ACTIVE PROCEDURES *' FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15520, '*********************' FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15530, ''                      FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15580, RPAD('START_TIME', 19) || CHAR(32) || LPAD('EXEC_TIME_MS', 15) || CHAR(32) || LPAD('COMPILE_TIME_MS', 15) || CHAR(32) || 
    LPAD('CONN_ID', 12) || CHAR(32) || RPAD('STATUS', 19) || CHAR(32) || LPAD('EXECS', 5) || CHAR(32) || LPAD('DEPTH', 5) || CHAR(32) || RPAD('PROCEDURE_NAME', PROCEDURE_LEN) FROM ACTIVE_PROCEDURES UNION ALL
  SELECT TOP 1 15590, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || RPAD('=', 15, '=') || CHAR(32) || 
    LPAD('=', 12, '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || LPAD('=', 5, '=') || CHAR(32) || RPAD('=', PROCEDURE_LEN, '=') FROM ACTIVE_PROCEDURES UNION ALL
  SELECT 15600 + ROW_NUMBER () OVER (ORDER BY P.STATEMENT_START_TIME), RPAD(TO_VARCHAR(P.STATEMENT_START_TIME, 'YYYY/MM/DD HH24:MI:SS'), 19) || CHAR(32) ||
    LPAD(TO_DECIMAL(P.STATEMENT_EXECUTION_TIME / 1000000, 10, 2), 15) || CHAR(32) ||
    LPAD(TO_DECIMAL(P.STATEMENT_COMPILE_TIME / 1000000, 10, 2), 15) || CHAR(32) ||
    LPAD(P.STATEMENT_CONNECTION_ID, 12) || CHAR(32) ||
    RPAD(P.STATEMENT_STATUS, 19) || CHAR(32) ||
    LPAD(P.STATEMENT_EXECUTION_COUNT, 5) || CHAR(32) ||
    LPAD(P.STATEMENT_DEPTH, 5) || CHAR(32) ||
    RPAD(P.PROCEDURE_NAME, PROCEDURE_LEN)
  FROM
    ACTIVE_PROCEDURES P
  UNION ALL
  SELECT TOP 1 15990, ''                FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16000, '***************' FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16010, '* CALL STACKS *' FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16020, '***************' FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16030, ''                FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16080, LPAD('THREAD_ID', 10) || CHAR(32) || RPAD('THREAD_TYPE', 29) || CHAR(32) || RPAD('THREAD_STATE', 35) || CHAR(32) || RPAD('LOCK_NAME', 29) || CHAR(32) || RPAD('CALL_STACK', 100) FROM CALLSTACKS UNION ALL
  SELECT TOP 1 16090, LPAD('=', 10, '=') || CHAR(32) || RPAD('=', 29, '=') || CHAR(32) || RPAD('=', 35, '=') || CHAR(32) || RPAD('=', 29, '=') || CHAR(32) || RPAD('=', 100, '=') FROM CALLSTACKS UNION ALL
  SELECT 16100 + ROW_NUMBER () OVER (ORDER BY TC.THREAD_ID, TC.FRAME_LEVEL) / 100, LPAD(MAP(TC.FRAME_LEVEL, 1, TO_VARCHAR(TC.THREAD_ID), ''), 10) || CHAR(32) ||
    RPAD(MAP(TC.FRAME_LEVEL, 1, TC.THREAD_TYPE, ''), 29) || CHAR(32) || RPAD(MAP(TC.FRAME_LEVEL, 1, TC.THREAD_STATE, ''), 35) || CHAR(32) ||
    RPAD(MAP(TC.FRAME_LEVEL, 1, TC.LOCK_WAIT_NAME, ''), 29) || CHAR(32) || MAP(INSTR(TC.FRAME_NAME, '('), 0, TC.FRAME_NAME, SUBSTR_BEFORE(TC.FRAME_NAME, '('))
  FROM
    CALLSTACKS TC
  UNION ALL
  SELECT TOP 1 19990, ''               FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20000, '**************' FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20010, '* OOM EVENTS *' FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20020, '**************' FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20030, ''               FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20080, RPAD('OOM_TIME', 19) || CHAR(32) || RPAD('HEAP_AREA', 50) || CHAR(32) || RPAD('REASON', 41) || CHAR(32) || LPAD('MEM_USED_GB', 12) FROM OOM_EVENTS UNION ALL
  SELECT TOP 1 20090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 50, '=') || CHAR(32) || RPAD('=', 41, '=') || CHAR(32) || LPAD('=', 12, '=') FROM OOM_EVENTS UNION ALL
  SELECT 20100 + ROW_NUM, RPAD(TO_VARCHAR(TIME, 'YYYY/MM/DD HH24:MI:SS'), 19) || CHAR(32) || RPAD(HEAP_ALLOCATOR, 50) || CHAR(32) || RPAD(EVENT_REASON, 41) || CHAR(32) || LPAD(MEM_USED_GB, 12) FROM
    OOM_EVENTS
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) 
  UNION ALL
  SELECT TOP 1 20490, ''                             FROM ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20500, '****************************' FROM ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20510, '* ADMISSION CONTROL EVENTS *' FROM ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20520, '****************************' FROM ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20530, ''                             FROM ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20580, RPAD('EVENT_TIME', 19) || CHAR(32) || RPAD('HOST', HOST_LEN) || CHAR(32) || 'WAIT_TIME_S CPU_PCT MEM_PCT EVENT_REASON' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT TOP 1 20590, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', HOST_LEN, '=') || CHAR(32) ||   '=========== ======= ======= ==================================================' FROM ( SELECT HOST_LEN FROM BASIS_INFO ), ADMISSION_CONTROL_EVENTS UNION ALL
  SELECT 20600 + ROW_NUM, RPAD(TO_VARCHAR(EVENT_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(TO_DECIMAL(QUEUE_WAIT_TIME / 1000000, 10, 2), 11) ||
    LPAD(CPU_USAGE_RATIO, 8) || LPAD(MEMORY_RATIO, 8) || CHAR(32) || EVENT_REASON FROM 
    ( SELECT HOST_LEN FROM BASIS_INFO ), 
    ADMISSION_CONTROL_EVENTS
  WHERE
  ( MAX_RESULT_LINES = -1 OR ROW_NUM <= MAX_RESULT_LINES ) 
  UNION ALL
  SELECT TOP 1 20990, ''                     FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21000, '********************' FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21010, '* PINNED SQL PLANS *' FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21020, '********************' FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21030, ''                     FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21080, RPAD('PIN_TIME', 19) || CHAR(32) || RPAD('MODIFY_TIME', 19) || CHAR(32) || RPAD('HINT_STRING', 50) FROM PINNED_PLANS UNION ALL
  SELECT TOP 1 21090, RPAD('=', 19 , '=') || CHAR(32) || RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 50, '=') FROM PINNED_PLANS UNION ALL
  SELECT 21100 + ROW_NUMBER() OVER (ORDER BY PIN_TIME DESC), RPAD(TO_VARCHAR(PIN_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(TO_VARCHAR(LAST_MODIFY_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || HINT_STRING FROM
    PINNED_PLANS
  UNION ALL
  SELECT TOP 1 21990, ''                    FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22000, '*******************' FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22010, '* STATEMENT HINTS *' FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22020, '*******************' FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22030, ''                    FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22080, RPAD('ENABLE_TIME', 19) || CHAR(32) || RPAD('ENABLED', 9) || CHAR(32) || RPAD('HINT_STRING', 50) FROM STMT_HINTS UNION ALL
  SELECT TOP 1 22090, RPAD('=', 19 , '=') || CHAR(32) || RPAD('=', 9, '=') || CHAR(32) || RPAD('=', 50, '=') FROM STMT_HINTS UNION ALL
  SELECT 22100 + ROW_NUMBER() OVER (ORDER BY LAST_ENABLE_TIME DESC), RPAD(TO_VARCHAR(LAST_ENABLE_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(IS_ENABLED, 10) || HINT_STRING FROM
    STMT_HINTS
  UNION ALL
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
  UNION ALL
  SELECT TOP 1 22790, ''                FROM ANNOTS UNION ALL
  SELECT TOP 1 22800, '***************' FROM ANNOTS UNION ALL
  SELECT TOP 1 22810, '* ANNOTATIONS *' FROM ANNOTS UNION ALL
  SELECT TOP 1 22820, '***************' FROM ANNOTS UNION ALL
  SELECT TOP 1 22830, ''                FROM ANNOTS UNION ALL
  SELECT TOP 1 22880, RPAD('SCHEMA_NAME', SCHEMA_LEN) || CHAR(32) || RPAD('OBJECT_NAME', OBJECT_LEN) || CHAR(32) || RPAD('OBJECT_TYPE', 20) || CHAR(32) || RPAD('KEY', 20) || CHAR(32) || 'VALUE' FROM ANNOTS UNION ALL
  SELECT TOP 1 22890, RPAD('=', SCHEMA_LEN, '=') || CHAR(32) || RPAD('=', OBJECT_LEN, '=') || CHAR(32) || RPAD('=', 20, '=') || CHAR(32) || RPAD('=', 20, '=') || CHAR(32) || RPAD('=', 20, '=') FROM ANNOTS UNION ALL
  SELECT 22900 + ROW_NUMBER() OVER (ORDER BY SCHEMA_NAME, OBJECT_NAME) / 100, RPAD(SCHEMA_NAME, SCHEMA_LEN) || CHAR(32) || RPAD(OBJECT_NAME, OBJECT_LEN) || CHAR(32) || RPAD(OBJECT_TYPE, 20) || CHAR(32) || 
    RPAD(KEY, 20) || CHAR(32) || VALUE FROM
    ANNOTS
  UNION ALL
  SELECT TOP 1 22990, ''                  FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23000, '*****************' FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23010, '* TRACE ENTRIES *' FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23020, '*****************' FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23030, ''                  FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23080, RPAD('TIMESTAMP', 19) || CHAR(32) || RPAD('COMPONENT', 16) || CHAR(32) || RPAD('TRACE_ENTRIES', 50) FROM TRACE_ENTRIES UNION ALL
  SELECT TOP 1 23090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 16, '=') || CHAR(32) || RPAD('=', 50, '=') FROM TRACE_ENTRIES UNION ALL
  SELECT 23100 + ROW_NUMBER() OVER (ORDER BY TIMESTAMP DESC), RPAD(TO_VARCHAR(TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'), 19) || CHAR(32) || RPAD(COMPONENT, 16) || CHAR(32) || TRACE_TEXT
  FROM
    TRACE_ENTRIES
  WHERE
  ( MAX_RESULT_LINES = -1 OR LINE_NO <= MAX_RESULT_LINES )
  UNION ALL
  SELECT TOP 1 23990, ''                  FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24000, '*****************' FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24010, '* USED FEATURES *' FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24020, '*****************' FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24030, ''                  FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24080, RPAD('COMPONENT_NAME', COMPONENT_LEN) || CHAR(32) || RPAD('FEATURE_NAME', FEATURE_LEN) || CHAR(32) || RPAD('DEPRECATED', 10) || CHAR(32) || RPAD('LAST_EXECUTION_TIME', 19) FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24090, RPAD('=', COMPONENT_LEN, '=') || CHAR(32) || RPAD('=', FEATURE_LEN, '=') || CHAR(32) || RPAD('=', 10, '=') || CHAR(32) || RPAD('=', 19, '=') FROM FEATURE_USAGE UNION ALL
  SELECT TOP 1 24100 + ROW_NUMBER () OVER (ORDER BY COMPONENT_NAME, FEATURE_NAME), RPAD(COMPONENT_NAME, COMPONENT_LEN) || CHAR(32) || RPAD(FEATURE_NAME, FEATURE_LEN) || CHAR(32) || RPAD(IS_DEPRECATED, 10) || CHAR(32) || RPAD(LAST_TIMESTAMP, 19) FROM FEATURE_USAGE
  UNION ALL
  SELECT TOP 1 91990, ''                       FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92000, '****************************' FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92010, '* DATABASE VERSION HISTORY *' FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92020, '****************************' FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92030, ''                       FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92080, RPAD('INSTALL_TIME', 19) || CHAR(32) || RPAD('VERSION', 22) FROM M_DATABASE_HISTORY UNION ALL
  SELECT TOP 1 92090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', 22, '=') FROM M_DATABASE_HISTORY UNION ALL
  SELECT 92100 + ROW_NUMBER () OVER (ORDER BY INSTALL_TIME DESC), RPAD(TO_VARCHAR(INSTALL_TIME, 'YYYY/MM/DD HH24:MI:SS'), 19) || CHAR(32) || VERSION FROM M_DATABASE_HISTORY
  UNION ALL
  SELECT TOP 1 93990, ''                       FROM PARAMETERS UNION ALL
  SELECT TOP 1 94000, '**********************' FROM PARAMETERS UNION ALL
  SELECT TOP 1 94010, '* PARAMETER SETTINGS *' FROM PARAMETERS UNION ALL
  SELECT TOP 1 94020, '**********************' FROM PARAMETERS UNION ALL
  SELECT TOP 1 94030, ''                       FROM PARAMETERS UNION ALL
  SELECT TOP 1 94080, RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME' , KEY_LEN) || CHAR(32) || 'VALUE' FROM PARAMETERS UNION ALL
  SELECT TOP 1 94090, RPAD('=', FILE_LEN, '=') || CHAR(32) || RPAD('=', SECTION_LEN, '=') || CHAR(32) || RPAD('=' , KEY_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(5, VALUE_LEN), '=') FROM PARAMETERS UNION ALL
  SELECT 94100 + ROW_NUMBER () OVER (ORDER BY FILE_NAME, SECTION, KEY), RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) || VALUE FROM
    PARAMETERS
  UNION ALL
  SELECT TOP 1 94990, ''                      FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95000, '*********************' FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95010, '* PARAMETER CHANGES *' FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95020, '*********************' FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95030, ''                      FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95080, RPAD('TIMESTAMP', 19) || CHAR(32) || RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME', KEY_LEN) || CHAR(32) ||
    RPAD('VALUE', VALUE_LEN) || CHAR(32) || 'PREV_VALUE' FROM PARAMETER_CHANGES UNION ALL
  SELECT TOP 1 95090, RPAD('=', 19, '=') || CHAR(32) || RPAD('=', FILE_LEN, '=') || CHAR(32) || RPAD('=', SECTION_LEN, '=') || CHAR(32) || RPAD('=', KEY_LEN, '=') || CHAR(32) ||
    RPAD('=', VALUE_LEN, '=') || CHAR(32) || RPAD('=', GREATEST(10, PREV_VALUE_LEN), '=') FROM PARAMETER_CHANGES UNION ALL
  SELECT 
    95100 + ROW_NUMBER () OVER (ORDER BY TIME DESC, FILE_NAME, SECTION, KEY), 
    RPAD(TO_VARCHAR(TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) ||
    RPAD(IFNULL(FILE_NAME, ''), FILE_LEN) || CHAR(32) ||
    RPAD(IFNULL(SECTION, ''), SECTION_LEN) || CHAR(32) ||
    RPAD(IFNULL(KEY, ''), KEY_LEN) || CHAR(32) ||
    RPAD(IFNULL(VALUE, ''), VALUE_LEN) || CHAR(32) ||
    RPAD(IFNULL(PREV_VALUE, ''), PREV_VALUE_LEN)
  FROM
    PARAMETER_CHANGES
) L
ORDER BY
  LINE_NO
WITH HINT (IGNORE_PLAN_CACHE)