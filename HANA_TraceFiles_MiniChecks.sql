WITH 

/* 

[NAME]

- HANA_TraceFiles_MiniChecks

[DESCRIPTION]

- Trace file mini checks

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Reports trace files entries that may indicate an issue
- See SAP Note 2380176 for details
- Only the service trace files are covered (no alert files, OOM or RTE dumps)
- Per default only 10 * 10 MB of traces are retained per service, there is no guaranteed retention, so in some cases traces are overwritten rather early
- Runtime and memory consumption can be significant in case of many and large trace files (bug 248022), so try to limit the selection as much as possible
  (e.g. with proper BEGIN_TIME / END_TIME specification), make sure that statement_memory_limit is properly set to rule out system instabilities in
  case of high memory consumption, improvements are expected with SAP HANA 2.0 SPS 06)
- NO_JOIN_REMOVAL hint required as workaround for bug 110097 (Rev. 1.00.112.02, "Execution flow must not reach here", "scalar subquery is not allowed")

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2018/02/05:  1.0 (initial version)
- 2018/09/27:  1.1 (ulimit checks T8001 - T8020 added)
- 2018/12/04:  1.2 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/04/25:  1.3 (CHECK_AREA filter included)
- 2020/10/15:  1.4 (improved memory consumption and runtime by eliminating '%' || <trace_text> || '%' concatenations)

[INVOLVED TABLES]

- M_MERGED_TRACES

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

- CHECK_AREA

  Check area (based on AREA output column)

  'Communication' --> Only check for trace entries related to Communication area
  '%'             --> No restriction to a specific check area

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

- SERVICE_NAME

  Service name

  'indexserver'   --> Specific service indexserver
  '%server'       --> All services ending with 'server'
  '%'             --> All services

[OUTPUT PARAMETERS]

- CHID:            Trace file check ID (T<id>)
- AREA:            Problem area (e.g. 'Runtime error', 'Communication' or 'Corruption')
- DESCRIPTION:     Description of problem situation indicated by trace entry
- HOST:            Host name
- PORT:            Port
- COUNT:           Number of trace entries
- LAST_OCCURRENCE: Last time when trace entry was written
- SAP_NOTE:        SAP Note
- TRACE_TEXT:      Trace text

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|CHID |AREA             |DESCRIPTION                                 |HOST    |PORT |COUNT|LAST_OCCURRENCE    |SAP_NOTE|TRACE_TEXT                                                                                                                                                                                                                                                    |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|     |TIME FRAME:      |2018/02/04 11:41:08 - 2018/02/05 11:41:08   |        |     |     |                   |        |                                                                                                                                                                                                                                                              |
|     |                 |                                            |        |     |     |                   |        |                                                                                                                                                                                                                                                              |
|T1000|Statistics server|Exception creating missing volume file alert|dchana03|31040|  288|2018/02/05 11:38:26| 2570661|Error <exception 71000287: ptime::PtimeException
> in execution of internal statement: REPLACE "_SYS_STATISTICS"."HELPER_ALERT_MISSING_VOLUME_FILE_AGE" VALUES (__typed_BigInt__(X)) WHERE  ( __typed_BigInt__(X) IS  NOT NULL  AND "ID" >  ( SELECT MAX("ID" |
|T2000|Runtime error    |Overflow in numeric calculation             |dchana03|31040|   72|2018/02/05 11:30:12| 2380176|pop1, 23:18:12.781  +0.005, cpu 18258532896, RowPlanOperator, rc 314, search table error:  [6944] AttributeEngine: overflow in numeric calculation                                                                                                            |
|T8770|Internal tasks   |Problems with timezone configuration        |dchana03|31040|    1|2018/02/05 09:26:51| 1932132|Time zone validity checker could not find database tables with timezone data. Aborting validity check. Please make sure that you have up-to-date timezone data tables. (see SAP Note 1932132)                                                                 |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    TIMEZONE,
    CHECK_AREA,
    HOST,
    PORT,
    SERVICE_NAME
  FROM
  ( SELECT                  /* Modification section */
      'C-D1' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      'C' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' CHECK_AREA,
      '%' HOST,
      '%' PORT,
      '%' SERVICE_NAME
    FROM
      DUMMY
  )
),
TRACE_FILE_ENTRIES_PER_HOUR AS
( SELECT
    T.HOST,
    T.PORT,
    TO_VARCHAR(MAX(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END), 'YYYY/MM/DD HH24') || ':00:00' HOUR,
    COUNT(*) COUNT
  FROM
    BASIS_INFO BI,
    M_MERGED_TRACES T
  WHERE
    CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    T.HOST LIKE BI.HOST AND
    TO_VARCHAR(T.PORT) LIKE BI.PORT AND
    T.SERVICE_NAME LIKE BI.SERVICE_NAME AND
    TRACE_FILE_NAME NOT LIKE 'nameserver%' || '0000.%'  /* separation because SAP HANA Cockpit seems to struggle with '%' followed directly by '0' */
  GROUP BY
    TO_VARCHAR(T.TIMESTAMP, 'YYYY/MM/DD HH24'),
    T.HOST,
    T.PORT
)
SELECT
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN CASE WHEN CHECK_ID >= 100 THEN 'T' || LPAD(CHECK_ID, 4, '0') ELSE '' END ELSE '' END CHID,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN AREA ELSE '' END AREA,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN DESCRIPTION ELSE '' END DESCRIPTION,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID, HOST ORDER BY PORT) = 1 THEN HOST ELSE '' END HOST,
  CASE WHEN PORT >= 0 THEN LPAD(PORT, 5) ELSE '' END PORT,
  CASE WHEN COUNT >= 0 THEN LPAD(COUNT, 6) ELSE '' END COUNT,
  LAST_OCCURRENCE,
  CASE WHEN SAP_NOTE >= 0 THEN LPAD(SAP_NOTE, 8) ELSE '' END SAP_NOTE,
  DETAILS
FROM
( SELECT
    1 CHECK_ID,
    'Generated with:' AREA,
    'SQL: "HANA_TraceFiles_MiniChecks"' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    1969700 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    2 CHECK_ID,
    'Check version:' AREA,
    '1.3.139 (2024/09/10)' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    3 CHECK_ID,
    'SAP Note:' AREA,
    '2380176' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    4 CHECK_ID,
    'SID / DB name:' AREA,
    SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    M_DATABASE
  UNION ALL
  SELECT
    5 CHECK_ID,
    'Time frame:' AREA,
    TO_VARCHAR(BEGIN_TIME, 'YYYY/MM/DD HH24:MI:SS') || CHAR(32) || '-' || CHAR(32) || TO_VARCHAR(LEAST(END_TIME, CURRENT_TIMESTAMP), 'YYYY/MM/DD HH24:MI:SS') DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    BASIS_INFO
  UNION ALL
  SELECT 30, '', '', '', -1, -1, '', -1, '' FROM DUMMY
  UNION ALL
  SELECT
    C.CHECK_ID,
    C.AREA,
    C.DESCRIPTION,
    T.HOST,
    T.PORT,
    COUNT(*) COUNT,
    TO_VARCHAR(MAX(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END), 'YYYY/MM/DD HH24:MI:SS') LAST_OCCURRENCE,
    C.SAP_NOTE,
    MAX(SUBSTR(LTRIM(REPLACE(REPLACE(REPLACE(T.TRACE_TEXT, CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32))), 1, 5000)) DETAILS
  FROM
    BASIS_INFO BI,
    M_MERGED_TRACES T,
    ( SELECT  100 CHECK_ID, 'Statistics server' AREA, 'Exception creating missing volume file alert' DESCRIPTION, 'exception 71000287%HELPER_ALERT_MISSING_VOLUME_FILE_AGE' TRACE_TEXT, 2570661 SAP_NOTE FROM DUMMY UNION ALL
      SELECT  101, 'Statistics server', 'Unique constraint violation',                       '%unique constraint violated%_SYS_STATISTICS%',          2147247 FROM DUMMY UNION ALL
      SELECT  110, 'Statistics server', 'Insert into HOST_SERVICE_THREAD_SAMPLES failed',    '%Insert into column%HOST_SERVICE_THREAD_SAMPLES%',      2570661 FROM DUMMY UNION ALL
      SELECT  112, 'Statistics server', 'Error sending e-mail',                              '%error sending email [SMTPMail:%',                      2147247 FROM DUMMY UNION ALL
      SELECT  114, 'Statistics server', 'Connection close by remote SMTP endpoint',          '%Remote endpoint closed unexpectedly%',                 2147247 FROM DUMMY UNION ALL
      SELECT  200, 'Runtime error',     'Overflow in numeric calculation',                   '%overflow in numeric calculation%',                     2380176 FROM DUMMY UNION ALL
      SELECT  201, 'Runtime error',     'Numeric overflow',                                  '%numeric overflow%',                                    2380176 FROM DUMMY UNION ALL
      SELECT  201, 'Runtime error',     'Numeric overflow',                                  '%return code 6944%',                                    2380176 FROM DUMMY UNION ALL
      SELECT  201, 'Runtime error',     'Numeric overflow',                                  '%error = 6944%',                                        2380176 FROM DUMMY UNION ALL
      SELECT  202, 'Runtime error',     'Error 6195 opening attribute',                      '%failed to open attribute%6915%',                       2588119 FROM DUMMY UNION ALL
      SELECT  203, 'Runtime error',     'Wrong model to table reference format',             '%cannot be calculated: wrong reference format%',        2380176 FROM DUMMY UNION ALL
      SELECT  204, 'Runtime error',     'Not enough or too many operands',                   '%not enough or too many operands % search operator%',   2276838 FROM DUMMY UNION ALL
      SELECT  205, 'Runtime error',     'Unified table container not accessible',            '%Cannot access UT container for container ID%',         2380176 FROM DUMMY UNION ALL
      SELECT  206, 'Runtime error',     'Syntax error in expression string',                 '%Evaluator: syntax error in expression string%',        2394478 FROM DUMMY UNION ALL
      SELECT  207, 'Runtime error',     'View attribute not found by query mediator',        '%View attribute % was not found in schema%',            2936770 FROM DUMMY UNION ALL
      SELECT  208, 'Runtime error',     'Plan termination due to inactivity',                '%plan terminated%after being inactive for too long%',   2584706 FROM DUMMY UNION ALL
      SELECT  209, 'Runtime error',     'Invalid query found during calc engine processing', '%exception 306105: Invalid query%',                     2380176 FROM DUMMY UNION ALL
      SELECT  210, 'Runtime error',     'Invalid character encoding',                        '%invalid character encoding%',                          2478767 FROM DUMMY UNION ALL
      SELECT  211, 'Runtime error',     'Error creating packed LOB',                         '%Could not create mid size LOB container%',             2220627 FROM DUMMY UNION ALL
      SELECT  212, 'Runtime error',     'Error merging multi value dicts',                   '%olap: merging multi value dicts is not implemented%',  1866135 FROM DUMMY UNION ALL
      SELECT  213, 'Runtime error',     'Failure during expression conversion',              '%error with message: Convert error%',                   2380176 FROM DUMMY UNION ALL
      SELECT  214, 'Runtime error',     'Failure during expression conversion',              '%Expression conversion is failed in%',                  2380176 FROM DUMMY UNION ALL
      SELECT  215, 'Runtime error',     'Join engine failure evaluating fuzzy relevance',    '%Can_t find Relevance with queryId%',                   3009615 FROM DUMMY UNION ALL
      SELECT  216, 'Runtime error',     'Empty freestyle attribute list',                    '%freestyle attribute list is empty%',                   2380176 FROM DUMMY UNION ALL
      SELECT  217, 'Runtime error',     'Expression type conflict',                          '%type conflict: can not find code for node%',           2800044 FROM DUMMY UNION ALL
      SELECT  218, 'Runtime error',     'Use of unsupported feature',                        '%feature not supported%',                               1969700 FROM DUMMY UNION ALL
      SELECT  219, 'Runtime error',     'Unconnected join engine plan outputs',              '%Found unconnected outputs in plan%',                   3087670 FROM DUMMY UNION ALL
      SELECT  220, 'Runtime error',     'Crash (signal 11)',                                 '%SIGNAL 11 (SIGSEGV) caught%',                          2177064 FROM DUMMY UNION ALL
      SELECT  221, 'Runtime error',     'Invalid name of function or procedure',             '%invalid name of function or procedure%',               2380176 FROM DUMMY UNION ALL
      SELECT  222, 'Runtime error',     'Mandatory variable without default or mapping',     '%default value%input mapping%mandatory variable%',      2525644 FROM DUMMY UNION ALL
      SELECT  223, 'Runtime error',     'Column data type mismatch',                         '%TypeMismatch exception: Column%',                      3078297 FROM DUMMY UNION ALL
      SELECT  224, 'Runtime error',     'Required variable not specified',                   '%Variable%marked as required%not set in the query%',    2000002 FROM DUMMY UNION ALL
      SELECT  225, 'Runtime error',     'General configuration error dropping temp index',   '%Could not delete temp index: general configuration%',  2800007 FROM DUMMY UNION ALL
      SELECT  226, 'Runtime error',     'Inconsistent calculation model',                    '%Inconsistent calculation model (34011)%',              2380176 FROM DUMMY UNION ALL
      SELECT  227, 'Runtime error',     'Transaction being used by a different thread',      '%Transaction << % is now being% used by thread%',       2380176 FROM DUMMY UNION ALL
      SELECT  228, 'Runtime error',     'Error accessing calculation scenario',              '%RepositoryAccessor::getCalculationScenario%',          2081505 FROM DUMMY UNION ALL
      SELECT  229, 'Runtime error',     'Invalid oabapstream pointer',                       '%invalid oabapstream pointer%',                         2380176 FROM DUMMY UNION ALL
      SELECT  230, 'Runtime error',     'Error accessing template scenario',                 '%Could not get template scenario%',                     2580778 FROM DUMMY UNION ALL
      SELECT  231, 'Runtime error',     'Failure finding term location for predicate query', '%failed to find term location for predicate query%',    2380176 FROM DUMMY UNION ALL
      SELECT  232, 'Runtime error',     'Error accessing source column in input itab',       '%find% column%in input itab%',                          3286115 FROM DUMMY UNION ALL
      SELECT  233, 'Runtime error',     'Invalid query result estimation',                   '%Could not estimate query: Invalid result estimation%', 2380176 FROM DUMMY UNION ALL
      SELECT  234, 'Runtime error',     'Table update feature not implemented',              '%Not yet implemented %hasToSendDataToEveryParts%',      3139337 FROM DUMMY UNION ALL
      SELECT  235, 'Runtime error',     'Wrong date format',                                 '%attribute value is not a date or wrong syntax%',       2361364 FROM DUMMY UNION ALL
      SELECT  236, 'Runtime error',     'Termination of single threaded plan execution',     '%calculateSingleThreaded plan % failed with rc%',       2380176 FROM DUMMY UNION ALL
      SELECT  237, 'Runtime error',     'Invalid hexadecimal column value detected',         '%invalid hexadecimal data detected in query table%',    2380176 FROM DUMMY UNION ALL
      SELECT  238, 'Runtime error',     'Function or procedure not found',                   '%Could not find function or procedure%',                2380176 FROM DUMMY UNION ALL
      SELECT  239, 'Runtime error',     'Guided navigation attribute not specified',         '%gnav requested but no gnav attributes specified%',     2380176 FROM DUMMY UNION ALL
      SELECT  240, 'Runtime error',     'Internal HEX engine error',                         '%Internal error in hex engine%',                        2570371 FROM DUMMY UNION ALL
      SELECT  241, 'Runtime error',     'Failure during routed execution',                   '%[600] failed routed execution%',                       2380176 FROM DUMMY UNION ALL
      SELECT  242, 'Runtime error',     'Failed to find temp table',                         '%Failed to find temp table%',                           2380176 FROM DUMMY UNION ALL
      SELECT  243, 'Runtime error',     'Invalid table',                                     '%Have invalid table for%',                              2380176 FROM DUMMY UNION ALL
      SELECT  244, 'Runtime error',     'Non-existing temp index',                           '%temp index not exists%',                               2380176 FROM DUMMY UNION ALL
      SELECT  245, 'Runtime error',     'Executor timeout',                                  '%rc = 2626, executor timeout%',                         2380176 FROM DUMMY UNION ALL
      SELECT  246, 'Runtime error',     'ColDicVal not found',                               '%ColDicVal (%,%) not found%',                           2681828 FROM DUMMY UNION ALL
      SELECT  247, 'Runtime error',     'Unique constraint violation',                       '%unique constraint violated%',                          2160391 FROM DUMMY UNION ALL
      SELECT  248, 'Runtime error',     'Unsupported type conversion',                       '%not supported type conversion%',                       2147247 FROM DUMMY UNION ALL
      SELECT  249, 'Runtime error',     'Rowid lookup failed',                               '%rowid lookup failed%',                                 2800008 FROM DUMMY UNION ALL
      SELECT  250, 'Runtime error',     'NOT NULL constraint violation',                     '%cannot insert NULL or update to NULL%',                2380176 FROM DUMMY UNION ALL
      SELECT  251, 'Runtime error',     'Unknown last docid',                                '%unknown lastDocid for value%',                         2800008 FROM DUMMY UNION ALL
      SELECT  252, 'Runtime error',     'Join engine failure',                               '%rc % 23052%',                                          2767841 FROM DUMMY UNION ALL
      SELECT  253, 'Runtime error',     'Execution flow must not reach here',                '%execution flow must not reach here%',                  2380176 FROM DUMMY UNION ALL
      SELECT  254, 'Runtime error',     'Error creating value statistics for column',        '%Could not create value statistic for attribute%',      2380176 FROM DUMMY UNION ALL
      SELECT  255, 'Runtime error',     'Snapshot timestamp too old',                        '%Too old snapshot timestamp%',                          2767844 FROM DUMMY UNION ALL
      SELECT  256, 'Runtime error',     'Deserialization of inheritable storage failed',     '%deserialization of InheritableLocalStorage % failed%', 2767844 FROM DUMMY UNION ALL
      SELECT  257, 'Runtime error',     'Shared index handle lock failed',                   '%indexhandle shared lock failed%',                      2789669 FROM DUMMY UNION ALL
      SELECT  258, 'Runtime error',     'Watermark mismatch',                                '%Watermark mismatch: system_wm%',                       2689722 FROM DUMMY UNION ALL
      SELECT  259, 'Runtime error',     'Same anchor connection ID already exists',          '%same anchor connection id already exists%',            2380176 FROM DUMMY UNION ALL
      SELECT  260, 'Runtime error',     'Type error in expression evaluator',                '%type error in expression evaluator%',                  2800044 FROM DUMMY UNION ALL
      SELECT  261, 'Runtime error',     'Unbound SQL parameter',                             '%unbound parameter : % of %, % out of % batches%',      2380176 FROM DUMMY UNION ALL
      SELECT  262, 'Runtime error',     'Numeric value out of range',                        '%numeric value out of range%',                          2380176 FROM DUMMY UNION ALL
      SELECT  263, 'Runtime error',     'No element at XML path found',                      '%Error: has no element at given xpath%',                2380176 FROM DUMMY UNION ALL
      SELECT  264, 'Runtime error',     'Wrong column number in result itab',                '%Result itab%does not contain same number%',            2770145 FROM DUMMY UNION ALL
      SELECT  265, 'Runtime error',     'Inserting in temporary table not possible',         '%Can not insert TempTable%',                            2380176 FROM DUMMY UNION ALL
      SELECT  266, 'Runtime error',     'Invalid schema name',                               '%invalid schema name%',                                 2535951 FROM DUMMY UNION ALL
      SELECT  267, 'Runtime error',     '1:n instead of 1:1 relation for attribute',         '%All response attributes require a 1:1 relation%',      2380176 FROM DUMMY UNION ALL
      SELECT  268, 'Runtime error',     'Parsing error due to wrong reply packet handling',  '%assertion failure at %, condition=part.isValid()%',    2380176 FROM DUMMY UNION ALL
      SELECT  269, 'Runtime error',     'Value too large for column',                        '%inserted value too large for column%',                 2380176 FROM DUMMY UNION ALL
      SELECT  270, 'Runtime error',     'Attribute engine failure',                          '%rc_6900%',                                             2380176 FROM DUMMY UNION ALL
      SELECT  270, 'Runtime error',     'Attribute engine failure',                          '%Attribute engine failed%',                             2380176 FROM DUMMY UNION ALL
      SELECT  271, 'Runtime error',     'Error reading file',                                '%rc_6946%',                                             2380176 FROM DUMMY UNION ALL
      SELECT  271, 'Runtime error',     'Error reading file',                                '%error reading file%',                                  2380176 FROM DUMMY UNION ALL
      SELECT  272, 'Runtime error',     'Error contacting Host Agent',                       '%Received invalid message from Host Agent%',            1969700 FROM DUMMY UNION ALL
      SELECT  273, 'Runtime error',     'Failure building FEMS lookup table',                '%failed to build QE lookup table for fems number%',     2380176 FROM DUMMY UNION ALL
      SELECT  274, 'Runtime error',     'Compileserver not found',                           '%CompileServerNotFoundException%',                      2570371 FROM DUMMY UNION ALL
      SELECT  275, 'Runtime error',     'General internal error',                            '%general error%1999%',                                  2380176 FROM DUMMY UNION ALL
      SELECT  276, 'Runtime error',     'Invalid object name',                               '%invalid object name%',                                 2380176 FROM DUMMY UNION ALL
      SELECT  277, 'Runtime error',     'Index out of range',                                '%1000003%Index % out of range%',                        2876091 FROM DUMMY UNION ALL
      SELECT  278, 'Runtime error',     'Transaction serialization failure',                 '%transaction serialization failure%',                   2380176 FROM DUMMY UNION ALL
      SELECT  278, 'Runtime error',     'Transaction serialization failure',                 '%138%serialization failure%',                           2380176 FROM DUMMY UNION ALL
      SELECT  279, 'Runtime error',     'Invalid update info wrapper',                       '%UpdateInfoWrapper is invalid%',                        2877010 FROM DUMMY UNION ALL
      SELECT  280, 'Runtime error',     'Mismatch between column and attribute',             '%Column does not fit to attribute%',                    2771757 FROM DUMMY UNION ALL
      SELECT  281, 'Runtime error',     'Customized functionality disabled',                 '%disabled%M_CUSTOMIZABLE_FUNCTIONALITIES%',             2666303 FROM DUMMY UNION ALL
      SELECT  282, 'Runtime error',     'Invalid input for join',                            '%Internal error during join: invalid input%',           2886632 FROM DUMMY UNION ALL
      SELECT  283, 'Runtime error',     'Transaction already closed externally',             '%the transaction is already closed externally%',        2925229 FROM DUMMY UNION ALL
      SELECT  284, 'Runtime error',     'HEX failure when accessing table container',        '%failed to open index % 6906%',                         2380176 FROM DUMMY UNION ALL
      SELECT  285, 'Runtime error',     'Invalid number of join engine inputs',              '%incorrect number of inputs! reduction via Ntupel%',    2913105 FROM DUMMY UNION ALL 
      SELECT  286, 'Runtime error',     'Inconsistent join engine execution plan',           '%inconsistent execution plan%',                         2913105 FROM DUMMY UNION ALL
      SELECT  287, 'Runtime error',     'Assertion failure during GROUP BY with HEX',        '%Assertion failed: % pair.second%',                     2920919 FROM DUMMY UNION ALL
      SELECT  288, 'Runtime error',     'Multi provider runtime data not found',             '%qo_Exp for attribute % not found%',                    2917877 FROM DUMMY UNION ALL
      SELECT  289, 'Runtime error',     'Failure building plan for calculation engine node', '%Failed to build plan for node%',                       2919604 FROM DUMMY UNION ALL
      SELECT  290, 'Runtime error',     'Error during communication when sending plan data', '%Error during communication in sending of plan data%',  2222200 FROM DUMMY UNION ALL
      SELECT  291, 'Runtime error',     'Error retrieving idle connection time',             '%unable to get idle connection time from%',             2380176 FROM DUMMY UNION ALL
      SELECT  292, 'Runtime error',     'Statement restart required',                        '%statement needs to be restarted%',                     2924769 FROM DUMMY UNION ALL
      SELECT  293, 'Runtime error',     'Error converting value to column type',             '%cannot convert % to the type % for column%',           2380176 FROM DUMMY UNION ALL
      SELECT  294, 'Runtime error',     'Unknown exception during TREXviaDBSL call',         '%Unknown exception caught in TREXviaDBSL%',             2800048 FROM DUMMY UNION ALL
      SELECT  295, 'Runtime error',     'Unsupported operator during constant resolution',   '%enableSubtree: unsupported operator found at index%',  2845831 FROM DUMMY UNION ALL
      SELECT  296, 'Runtime error',     'Multiple parents for hierarchy not allowed',        '%Hierarchy source data: Multiple parents not allowed%', 2681072 FROM DUMMY UNION ALL
      SELECT  297, 'Runtime error',     'Unknown table in transactional cache',              '%registerTable failed: unknown table tableId%',         2380176 FROM DUMMY UNION ALL
      SELECT  298, 'Runtime error',     'Single-row query returns more than one row',        '%single-row query returns more than one row%',          2380176 FROM DUMMY UNION ALL
      SELECT  299, 'Runtime error',     'Invalid DATE, TIME or TIMESTAMP value',             '%invalid DATE, TIME or TIMESTAMP value%',               2380176 FROM DUMMY UNION ALL
      SELECT  300, 'Resources',         'Memory allocation failed',                          '%Allocation failed%',                                   1999997 FROM DUMMY UNION ALL
      SELECT  302, 'Resources',         'Out of memory (OOM)',                               '%Out of memory for%',                                   1999997 FROM DUMMY UNION ALL
      SELECT  302, 'Resources',         'Out of memory (OOM)',                               '%cannot allocate enough memory%',                       1999997 FROM DUMMY UNION ALL
      SELECT  304, 'Resources',         'Out of memory (OOM) exception',                     '%oom exception%',                                       1999997 FROM DUMMY UNION ALL
      SELECT  306, 'Resources',         'Operating system cannot allocate memory',           '%Cannot allocate memory%',                              1999997 FROM DUMMY UNION ALL
      SELECT  307, 'Resources',         'Emergency release of memory',                       '%Emergency release. % oom_memory_release%',             1999997 FROM DUMMY UNION ALL
      SELECT  308, 'Resources',         'Statement memory limit reached',                    '%Composite limit violation (OUT OF MEMORY) occurred%',  1999997 FROM DUMMY UNION ALL
      SELECT  309, 'Resources',         'Failure during memory unmapping',                   '%Failed: munmap MM %, error%',                          3352604 FROM DUMMY UNION ALL
      SELECT  310, 'Resources',         'Resource container shrink',                         '%Information about shrink%',                            1999997 FROM DUMMY UNION ALL
      SELECT  312, 'Resources',         'Leaking allocator destroyed',                       '%Destroying allocator%blocks and%still allocated%',     2580435 FROM DUMMY UNION ALL
      SELECT  313, 'Resources',         'Failure allocating system memory pages',            '%memAllocSystemPages failed%',                          1999997 FROM DUMMY UNION ALL
      SELECT  317, 'Resources',         'Invalid argument when attaching to shared memory',  '%ShmSystem::attach % - Invalid argument%',              1999997 FROM DUMMY UNION ALL
      SELECT  318, 'Resources',         'Resource temporarily unavailable',                  '%Resource temporarily unavailable%',                    2600030 FROM DUMMY UNION ALL
      SELECT  319, 'Resources',         'Shared memory: No space left on device',            '%ShmSystem::create % - No space left on device%',       1999997 FROM DUMMY UNION ALL
      SELECT  320, 'Resources',         'Dubious NUMA configuration',                        '%dubious configuration detected%',                      2472783 FROM DUMMY UNION ALL
      SELECT  321, 'Resources',         'Erroneous NUMA configuration',                      '%libnuma: Error: mbind: Invalid argument%',             2470289 FROM DUMMY UNION ALL
      SELECT  330, 'Resources',         'Resource tracking statistics not finished',         '%statistics collection is not finished%',               2222250 FROM DUMMY UNION ALL
      SELECT  400, 'Corruption',        'Attribute engine index not found',                  '%Attribute engine index not found%',                    2116157 FROM DUMMY UNION ALL
      SELECT  402, 'Corruption',        'Invalid checksum algorithm',                        '%Invalid checksum algorithm%',                          2116157 FROM DUMMY UNION ALL
      SELECT  404, 'Corruption',        'Invalid page type',                                 '%Invalid page type%',                                   2116157 FROM DUMMY UNION ALL
      SELECT  406, 'Corruption',        'Invalid savepoint version',                         '%Invalid savepoint version%',                           2116157 FROM DUMMY UNION ALL
      SELECT  408, 'Corruption',        'Invalid size class',                                '%Invalid size class%',                                  2116157 FROM DUMMY UNION ALL
      SELECT  410, 'Corruption',        'Savepoint version must be newer',                   '%Savepoint version must be newer%',                     2116157 FROM DUMMY UNION ALL
      SELECT  411, 'Corruption',        'Savepoint version must be older',                   '%Savepoint version must be older%',                     2116157 FROM DUMMY UNION ALL
      SELECT  412, 'Corruption',        'Wrong checksum',                                    '%Wrong checksum%',                                      2116157 FROM DUMMY UNION ALL
      SELECT  414, 'Corruption',        'Wrong converter type',                              '%Wrong converter type%',                                2116157 FROM DUMMY UNION ALL
      SELECT  416, 'Corruption',        'Wrong next page number',                            '%Wrong next page number%',                              2116157 FROM DUMMY UNION ALL
      SELECT  418, 'Corruption',        'Wrong owner',                                       '%Page % has wrong owner%',                              2116157 FROM DUMMY UNION ALL
      SELECT  420, 'Corruption',        'Wrong page number',                                 '%Wrong page number%',                                   2116157 FROM DUMMY UNION ALL
      SELECT  422, 'Corruption',        'Wrong size class',                                  '%Wrong size class%',                                    2116157 FROM DUMMY UNION ALL
      SELECT  424, 'Corruption',        'Wrong savepoint version',                           '%Wrong savepoint version%',                             2116157 FROM DUMMY UNION ALL
      SELECT  425, 'Corruption',        'Log backup checksum error',                         '%log segment backup%Buffer checksum%invalid%',          2628775 FROM DUMMY UNION ALL
      SELECT  426, 'Corruption',        'Error 6946 reading file',                           '%error reading file_ failed with rc 6946%',             2116157 FROM DUMMY UNION ALL
      SELECT  427, 'Corruption',        'Backup channel page with invalid checksum',         '%BackupChannel received page with invalid checksum%',   2116157 FROM DUMMY UNION ALL
      SELECT  430, 'Corruption',        'Table not yet visible in separate transaction',     '%Cannot create delta%visible%separate transaction%',    2399993 FROM DUMMY UNION ALL
      SELECT  440, 'Corruption',        'Inconsistency in column store table reported',      '%ColumnStoreConsistencyChecker found errors%',          2116157 FROM DUMMY UNION ALL
      SELECT  441, 'Corruption',        'Corruption reported by row store index build',      '%corruption identified during RS index build%',         2116157 FROM DUMMY UNION ALL
      SELECT  442, 'Corruption',        'Row store slot sanity check failure',               '%slot sanity check failure%',                           2116157 FROM DUMMY UNION ALL
      SELECT  443, 'Corruption',        'Invalid character encoding',                        '%An invalid encoded character detected%',               2116157 FROM DUMMY UNION ALL
      SELECT  444, 'Corruption',        'Row store inconsistencies found',                   '%Found%inconsistencies from consistency check%',        2116157 FROM DUMMY UNION ALL
      SELECT  445, 'Corruption',        'Duplicate records in unique row store index',       '%duplicate records found during index rebuild%',        2116157 FROM DUMMY UNION ALL
      SELECT  446, 'Corruption',        'UDIV manager lookup failure',                       '%udiv mgr lookup failed for table%',                    2787837 FROM DUMMY UNION ALL    
      SELECT  447, 'Corruption',        'Rows incorrectly assigned to partitions',           '%rows were not correctly assigned in part%',            2116157 FROM DUMMY UNION ALL
      SELECT  448, 'Corruption',        'Invalid reference in column store delta storage',   '%found invalid reference in indexvector%',              2116157 FROM DUMMY UNION ALL
      SELECT  449, 'Corruption',        'Index vector / dictionary VID inconsistency',       '%Vid from Index Vector%bigger than MaxVid%',            2116157 FROM DUMMY UNION ALL
      SELECT  450, 'Corruption',        'Outdated metadata format for NO LOGGING RETENTION', '%collection partition info% [18] A received argument%', 2839048 FROM DUMMY UNION ALL
      SELECT  451, 'Corruption',        'Column store index corruption',                     '%Index corrupt (should never happen)%',                 2116157 FROM DUMMY UNION ALL
      SELECT  452, 'Corruption',        'Invalid row store segment',                         '%RS Segment ID % is not valid%',                        2116157 FROM DUMMY UNION ALL
      SELECT  453, 'Corruption',        'LOB container not found',                           '%Container 0x% not found%',                             2948535 FROM DUMMY UNION ALL
      SELECT  454, 'Corruption',        'Table not found by IndexMgr',                       '%IndexMgr: index not found%',                           2116157 FROM DUMMY UNION ALL
      SELECT  455, 'Corruption',        'Non-existing dependency object cannot be removed',  '%Trying to remove non-existing dependency ObjectId%',   2380176 FROM DUMMY UNION ALL
      SELECT  456, 'Corruption',        'Object not found on persistence level',             '%Storage object does not exist%',                       2116157 FROM DUMMY UNION ALL
      SELECT  457, 'Corruption',        'Processing of base64 encoded passport failed',      '%failed with error 7 for base64 encoded passport%',     2380176 FROM DUMMY UNION ALL
      SELECT  458, 'Corruption',        'No valid passport eye catcher',                     '%could not find valid leading eyecatcher%',             2380176 FROM DUMMY UNION ALL
      SELECT  459, 'Corruption',        'Unexpected NULL values found in NOT NULL column',   '%getColumnValue: Column has NULL values%',              2116157 FROM DUMMY UNION ALL
      SELECT  460, 'Corruption',        'IndexID not found in IndexMap',                     '%indexId=% is not found in indexMap%',                  2116157 FROM DUMMY UNION ALL
      SELECT  461, 'Corruption',        'NVM mapping information broken',                    '%newValues.dict.blocks.block % not contained in data%', 3112893 FROM DUMMY UNION ALL
      SELECT  470, 'Corruption',        'Catalog consistency check failures',                '%Catalog consistency check failed.%',                   2116157 FROM DUMMY UNION ALL
      SELECT  471, 'Corruption',        'Catalog consistency check failed (invalid slot)',   '%[2576][INVALID SLOT]%',                                2116157 FROM DUMMY UNION ALL
      SELECT  490, 'Corruption',        'Outdated SAP HANA 1.0 table format',                '%due to too old persistence format%',                   2372809 FROM DUMMY UNION ALL
      SELECT  500, 'Communication',     'Communication error occurred',                      '%communication error occurred%',                        2222200 FROM DUMMY UNION ALL
      SELECT  501, 'Communication',     'Error reading from channel',                        '%an error occured while reading from the channel%',     2222200 FROM DUMMY UNION ALL
      SELECT  502, 'Communication',     'Timeout reading from channel',                      '%timeout occured while reading from the channel%',      2222200 FROM DUMMY UNION ALL
      SELECT  503, 'Communication',     'Error opening channel',                             '%an error occured while opening the channel%',          2222200 FROM DUMMY UNION ALL
      SELECT  504, 'Communication',     'Bad file descriptor',                               '%Bad file descriptor%',                                 2222200 FROM DUMMY UNION ALL
      SELECT  505, 'Communication',     'Blocking send timeout reached',                     '%receiveRawImp timeout % millisecond/s reached%',       2222200 FROM DUMMY UNION ALL
      SELECT  506, 'Communication',     'Broken pipe',                                       '%roken pipe%',                                          2222200 FROM DUMMY UNION ALL
      SELECT  507, 'Communication',     'Cannot assign requested address',                   '%Cannot assign requested address%',                     2222200 FROM DUMMY UNION ALL
      SELECT  508, 'Communication',     'Close channel while sending reply message',         '%close channel while sending reply message%',           2222200 FROM DUMMY UNION ALL
      SELECT  509, 'Communication',     'Erroneous communication channel',                   '%erroneous channel%',                                   2222200 FROM DUMMY UNION ALL
      SELECT  510, 'Communication',     'Erroneous SSL communication channel',               '%erroneous SSL channel%',                               2222200 FROM DUMMY UNION ALL
      SELECT  511, 'Communication',     'SSL channel readable while sending data',           '% is readable while sending data%',                     2222200 FROM DUMMY UNION ALL
      SELECT  512, 'Communication',     'Connection broken',                                 '%onnection broken%',                                    2222200 FROM DUMMY UNION ALL
      SELECT  513, 'Communication',     'Invalid SSL record header received',                '%Received invalid SSL Record Header%',                  2222200 FROM DUMMY UNION ALL
      SELECT  514, 'Communication',     'Connection refused',                                '%onnection refused%',                                   2222200 FROM DUMMY UNION ALL
      SELECT  515, 'Communication',     'Invalid request begin identifier',                  '%new Request with no or invalid request begin%',        2222200 FROM DUMMY UNION ALL
      SELECT  516, 'Communication',     'Connection reset by peer',                          '%onnection reset by peer%',                             2222200 FROM DUMMY UNION ALL
      SELECT  517, 'Communication',     'Error during group multicast',                      '%error occurred during group multicast%',               2222200 FROM DUMMY UNION ALL
      SELECT  518, 'Communication',     'Connection timed out',                              '%onnection timed out%',                                 2222200 FROM DUMMY UNION ALL
      SELECT  519, 'Communication',     'Error during group prepare commit',                 '%error occurred during group prepare commit%',          2222200 FROM DUMMY UNION ALL
      SELECT  520, 'Communication',     'Executor: communication problem',                   '%executor: communication problem%',                     2222200 FROM DUMMY UNION ALL
      SELECT  521, 'Communication',     'Multicast request handling failed due to timeout',  '%Failed to handle Request%due to timeout%',             2222200 FROM DUMMY UNION ALL
      SELECT  522, 'Communication',     'Failed to send cancel request',                     '%Failed to send cancel request%',                       2222200 FROM DUMMY UNION ALL
      SELECT  523, 'Communication',     'Error during rollback',                             '%error occurred during rollback%',                      2222200 FROM DUMMY UNION ALL
      SELECT  524, 'Communication',     'Failed with NetException',                          '%failed with NetException%',                            2222200 FROM DUMMY UNION ALL
      SELECT  525, 'Communication',     'Invalid address',                                   '%invalid address%',                                     2222200 FROM DUMMY UNION ALL
      SELECT  526, 'Communication',     'NetworkChannel::connectBlocking refused',           '%NetworkChannel::connectBlocking refused%',             2222200 FROM DUMMY UNION ALL
      SELECT  527, 'Communication',     'Failing rollback due to no volume response',        '%rollback failed because volume%',                      2222200 FROM DUMMY UNION ALL
      SELECT  528, 'Communication',     'Error during group precommit',                      '%Error during group-precommit%timeout%',                2222200 FROM DUMMY UNION ALL
      SELECT  529, 'Communication',     'Connection forcibly closed by peer',                '%connection was forcibly closed by a peer%',            2222200 FROM DUMMY UNION ALL
      SELECT  530, 'Communication',     'No reachable host left',                            '%no reachable host left%',                              2222200 FROM DUMMY UNION ALL
      SELECT  531, 'Communication',     'Failure establishing JDBC connection',              '%Cannot establish JDBC connection%',                    2222200 FROM DUMMY UNION ALL
      SELECT  532, 'Communication',     'No route to host',                                  '%no route to host%',                                    2222200 FROM DUMMY UNION ALL
      SELECT  533, 'Communication',     'ODBC function sequence error',                      '%Function sequence error%',                             2222200 FROM DUMMY UNION ALL
      SELECT  534, 'Communication',     'Communication problem or interval too short',       '%Communication problem or interval % too short%',       2222200 FROM DUMMY UNION ALL
      SELECT  535, 'Communication',     'Long runtime of connection establishment',          'CONNECTION ESTABLISHMENT: ESTABLISHED OPEN_TS%',        2000000 FROM DUMMY UNION ALL
      SELECT  536, 'Communication',     'Read from channel failed',                          '%read from channel failed%',                            2222200 FROM DUMMY UNION ALL
      SELECT  537, 'Communication',     'Communication partner stopped sending data',        '%server side has unexpectedly stopped sending data%',   1969700 FROM DUMMY UNION ALL
      SELECT  538, 'Communication',     'Reading failed with timeout error',                 '%reading failed with timeout error%',                   2222200 FROM DUMMY UNION ALL
      SELECT  539, 'Communication',     'Communication partner might have terminated',       '%exception: peer might have terminated%',               2222200 FROM DUMMY UNION ALL
      SELECT  540, 'Communication',     'Buffer reset due to timeout',                       '%resetting buffer (timeout occured)%',                  2222200 FROM DUMMY UNION ALL
      SELECT  541, 'Communication',     'Buffer contains data after SSL channel release',    '%contains % bytes on release of idle SSL channel%',     2222200 FROM DUMMY UNION ALL 
      SELECT  542, 'Communication',     'Remote host closed session forcibly',               '%session was forcibly closed by the remote host%',      2222200 FROM DUMMY UNION ALL
      SELECT  544, 'Communication',     'Stream send error',                                 '%stream: send error%',                                  2222200 FROM DUMMY UNION ALL
      SELECT  546, 'Communication',     'Temporary failure in name resolution',              '%emporary failure in name resolution%',                 2222200 FROM DUMMY UNION ALL
      SELECT  547, 'Communication',     'Timeout because deadline was reached',              '%timed out (Deadline reached)%',                        2222200 FROM DUMMY UNION ALL
      SELECT  548, 'Communication',     'Unexpected error with unknown peer name',           '%unexpected error with unknown peer name%',             2222200 FROM DUMMY UNION ALL
      SELECT  550, 'Communication',     'Stream closed unexpectedly',                        '%Unexpected stream close%',                             2222200 FROM DUMMY UNION ALL
      SELECT  552, 'Communication',     'Unknown host',                                      '%unknown host%',                                        2222200 FROM DUMMY UNION ALL
      SELECT  554, 'Communication',     'Connection timeout',                                '%initial communication timeout was reached%',           2385992 FROM DUMMY UNION ALL
      SELECT  556, 'Communication',     'Failure sending listPlan',                          '%failed to send listPlan request to%',                  2546137 FROM DUMMY UNION ALL
      SELECT  558, 'Communication',     'Transaction distribution work failure',             '%transaction distribution work failure%',               2222200 FROM DUMMY UNION ALL
      SELECT  560, 'Communication',     'Error closing stream socket',                       '%cannot close a stream socket%',                        2222200 FROM DUMMY UNION ALL
      SELECT  561, 'Communication',     'No response from service',                          '%Process % should be alive, but does not respond',      2380176 FROM DUMMY UNION ALL
      SELECT  562, 'Communication',     'Service not responding',                            '%:% not responding.%',                                  2222200 FROM DUMMY UNION ALL
      SELECT  563, 'Communication',     'Service was not found',                             '%Process % was not found',                              2380176 FROM DUMMY UNION ALL
      SELECT  564, 'Communication',     'Invalid forwarding to data center',                 '%Invalid forwarding to datacenter%',                    2222200 FROM DUMMY UNION ALL
      SELECT  565, 'Communication',     'Failure during session partition assignment',       '%failed to assign partition%',                          2380176 FROM DUMMY UNION ALL
      SELECT  566, 'Communication',     'Slow nameserver response',                          '%pingNameServer(%) takes % seconds%',                   2222200 FROM DUMMY UNION ALL
      SELECT  567, 'Communication',     'Unpermitted cross database communication',          '%not permitted cross database % is occurred%',          2793857 FROM DUMMY UNION ALL
      SELECT  568, 'Communication',     'Connection lost while reading response',            '%28: Connection to % lost while reading response%',     2641269 FROM DUMMY UNION ALL
      SELECT  569, 'Communication',     'TRex exception 12027 thrown',                       '%TRex exception thrown: 12027 from ptimeOp%',           2380176 FROM DUMMY UNION ALL
      SELECT  570, 'Communication',     'Address already in use',                            '%Address already in use%',                              2222200 FROM DUMMY UNION ALL
      SELECT  571, 'Communication',     'Channel failure due to internal error',             '%failed to open channel%internal error%',               2222200 FROM DUMMY UNION ALL
      SELECT  572, 'Communication',     'Unknown preamble padding value',                    '%unknown padding value%',                               2380176 FROM DUMMY UNION ALL
      SELECT  573, 'Communication',     'Unknown getaddrinfo details',                       '%Name or service not known%',                           2222200 FROM DUMMY UNION ALL
      SELECT  574, 'Communication',     'Long runtime of timer callback',                    '%TimerThread::TimerCallback % longer than expected%',   2380176 FROM DUMMY UNION ALL
      SELECT  575, 'Communication',     'Stream connection timeout reached',                 '%Connect timed out after%',                             2380176 FROM DUMMY UNION ALL
      SELECT  576, 'Communication',     'Exception in TNS request processing',               '%exception in TNSInfo::processRequest%',                2380176 FROM DUMMY UNION ALL
      SELECT  577, 'Communication',     'Invalid socket state',                              '%Socket state not valid%',                              2222200 FROM DUMMY UNION ALL
      SELECT  578, 'Communication',     'Timeout for load history ping',                     '%Request % hit timeout%',                               2222200 FROM DUMMY UNION ALL
      SELECT  579, 'Communication',     'Error in named communication method',               '%error in named method (or its remote caller)%',        2222200 FROM DUMMY UNION ALL
      SELECT  580, 'Communication',     'Failure reading data from buffer',                  '%failed to read % bytes%',                              2222200 FROM DUMMY UNION ALL
      SELECT  581, 'Communication',     'Failure writing data to buffer',                    '%failed to write % bytes%',                             2222200 FROM DUMMY UNION ALL
      SELECT  582, 'Communication',     'Channel invalidation due to failed write',          '%write failed (peer dead% invalidating channel%',       2222200 FROM DUMMY UNION ALL
      SELECT  583, 'Communication',     'Failed write due to internal error',                '%writing failed with rc=8 (internal error)%',           2222200 FROM DUMMY UNION ALL
      SELECT  584, 'Communication',     'TRex exception 12001 thrown',                       '%TRex exception thrown: 12001 from ptimeOp%',           1969700 FROM DUMMY UNION ALL
      SELECT  585, 'Communication',     'Adding distributed transaction participant failed', '%add participant failed: tid%',                         2380176 FROM DUMMY UNION ALL
      SELECT  586, 'Communication',     'Poll timeout during SSL communication',             '%SSL initialization or handshake error: Poll timed%',   2222200 FROM DUMMY UNION ALL
      SELECT  587, 'Communication',     'SSL/TLS record of unknown type received',           '%Received an SSL/TLS record of unknown%',               2159014 FROM DUMMY UNION ALL
      SELECT  588, 'Communication',     'SSL/TLS record MAC cannot be verified',             '%Failed to verify record MAC%',                         2159014 FROM DUMMY UNION ALL
      SELECT  589, 'Communication',     'SSL renegotiation attempt refused',                 '%Renegotiation support is not enabled.%',               2159014 FROM DUMMY UNION ALL
      SELECT  590, 'Communication',     'Failed remote communication',                       '%failed remote communication%',                         2222200 FROM DUMMY UNION ALL
      SELECT  591, 'Communication',     'Wrong unsupported type during channel cleanup',     '%wrong type unsupported found in channel while%',       2222200 FROM DUMMY UNION ALL
      SELECT  592, 'Communication',     'Token with invalid database received',              '%Database Mismatch: Got token with invalid database%',  2380176 FROM DUMMY UNION ALL
      SELECT  593, 'Communication',     'TRex exception 12019 thrown',                       '%TRex exception thrown: 12019 from ptimeOp%',           1969700 FROM DUMMY UNION ALL
      SELECT  594, 'Communication',     'Unknown reserved value',                            '%unknown reserved value%',                              2380176 FROM DUMMY UNION ALL
      SELECT  595, 'Communication',     'Unknown protocol identifier received',              '%received unknown protocol identifier%',                2380176 FROM DUMMY UNION ALL
      SELECT  596, 'Communication',     'Invalid begin identifier received',                 '%unsupported/request begin identifier is invalid%',     2380176 FROM DUMMY UNION ALL
      SELECT  597, 'Communication',     'Socket closed by peer',                             '%[89013] Socket closed by peer%',                       3304246 FROM DUMMY UNION ALL
      SELECT  598, 'Communication',     'Invalid connect reply',                             '%[200110] Invalid connect reply%',                      3341184 FROM DUMMY UNION ALL
      SELECT  600, 'I/O',               'No space left on device',                           '%No space left on device%',                             1999930 FROM DUMMY UNION ALL
      SELECT  601, 'I/O',               'Disk quota exceeded',                               '%Disk quota exceeded%',                                 2864223 FROM DUMMY UNION ALL
      SELECT  602, 'I/O',               'Disk full event',                                   '[DISKFULL] (% request)%',                               1870858 FROM DUMMY UNION ALL
      SELECT  610, 'I/O',               'Permission denied',                                 '%rc=13%Permission denied%',                             1999930 FROM DUMMY UNION ALL
      SELECT  610, 'I/O',               'Permission denied',                                 '%error code: 13 (Permission denied)%',                  1999930 FROM DUMMY UNION ALL
      SELECT  610, 'I/O',               'Permission denied',                                 '%Permission denied (errno = 13)%',                      1999930 FROM DUMMY UNION ALL
      SELECT  611, 'I/O',               'File or directory not found',                       '%No such file or directory%',                           1999930 FROM DUMMY UNION ALL
      SELECT  620, 'I/O',               'Unsupported file system',                           '%Unsupported file system%',                             1999930 FROM DUMMY UNION ALL
      SELECT  630, 'I/O',               'Volume cannot be accessed',                         '%no connection on volume%',                             2287190 FROM DUMMY UNION ALL
      SELECT  632, 'I/O',               'Retry after asynchronous I/O error',                '%RETRY after error in async. file transfer%',           1999930 FROM DUMMY UNION ALL
      SELECT  633, 'I/O',               'Asynchronous I/O error',                            '%ERROR in async. file transfer: exception%',            1999930 FROM DUMMY UNION ALL
      SELECT  640, 'I/O',               'Persistent memory path already registered',         '%Path already registered or NUMA information%',         3217234 FROM DUMMY UNION ALL
      SELECT  642, 'I/O',               'Persistent memory file system overflow',            '%NVM:%error code: 28 (No space left on device)%',       3332366 FROM DUMMY UNION ALL
      SELECT  700, 'Locks',             'Lock wait timeout reached',                         '%transaction rolled back by lock wait timeout%',        1999998 FROM DUMMY UNION ALL
      SELECT  700, 'Locks',             'Lock wait timeout reached',                         '%Lock-wait time out exceeded%',                         1999998 FROM DUMMY UNION ALL
      SELECT  702, 'Locks',             'Record lock wait timeout reached',                  '%Lock timeout occurs while waiting RECORD_LOCK%',       1999998 FROM DUMMY UNION ALL
      SELECT  704, 'Locks',             'Object lock wait timeout reached',                  '%Lock timeout occurs while waiting OBJECT_LOCK%',       1999998 FROM DUMMY UNION ALL
      SELECT  705, 'Locks',             'Timeout acquiring slot lock',                       '%failed to acquire a row lock during slot updated%',    3135063 FROM DUMMY UNION ALL
      SELECT  706, 'Locks',             'Deadlock detected',                                 '%eadlock detected%',                                    1999998 FROM DUMMY UNION ALL
      SELECT  707, 'Locks',             'Too many transactions waiting for record lock',     '%Too many waiting transactions%',                       2154870 FROM DUMMY UNION ALL
      SELECT  708, 'Locks',             'Many transactional locks',                          '%There are too many lock items on this system%',        1999998 FROM DUMMY UNION ALL
      SELECT  709, 'Locks',             'MAX_QUEUE_WAITER_COUNT for row locks exceeded',     '%MAX_QUEUE_WAITER_COUNT 1023 for rowlock exceeded%',    1999998 FROM DUMMY UNION ALL
      SELECT  710, 'Locks',             'Table location for table lock not available',       '%Failed to get table location during table lock%',      1999998 FROM DUMMY UNION ALL
      SELECT  711, 'Locks',             'Exception waiting for row locks',                   '%waitForFailedRowLocks caught exception for table%',    1999998 FROM DUMMY UNION ALL
      SELECT  712, 'Locks',             'Long waitForLock savepoint phase',                  '%waiting for critical phase for%',                      2100009 FROM DUMMY UNION ALL
      SELECT  714, 'Locks',             'NOWAIT lock request fails',                         '%Resource busy and NOWAIT specified%',                  1999998 FROM DUMMY UNION ALL
      SELECT  716, 'Locks',             'Index handle issue accessing remote table',         '%is not local',                                         3125519 FROM DUMMY UNION ALL
      SELECT  720, 'Locks',             'Orphan application lock found',                     '%An orphaned application lock is detected%',            1999998 FROM DUMMY UNION ALL
      SELECT  800, 'Internal tasks',    'Column load failed',                                '%ttribute load failed%',                                2127458 FROM DUMMY UNION ALL
      SELECT  800, 'Internal tasks',    'Column load failed',                                '%rc=6923%',                                             2127458 FROM DUMMY UNION ALL
      SELECT  800, 'Internal tasks',    'Column load failed',                                '%Column Load Failed%',                                  2127458 FROM DUMMY UNION ALL
      SELECT  801, 'Internal tasks',    'Loading UT table failed',                           '%Could not load UT table%',                             2127458 FROM DUMMY UNION ALL
      SELECT  802, 'Internal tasks',    'Real time inconsistency during timer calibration',  '%realtime inconsistency during initial calibration%',   3214098 FROM DUMMY UNION ALL
      SELECT  803, 'Internal tasks',    'Real time jump detected',                           '%Real time jump was detected%',                         2380176 FROM DUMMY UNION ALL
      SELECT  804, 'Internal tasks',    'Error collecting admission control statistics',     '%AdmissionControl: error in collecting stat%',          2222250 FROM DUMMY UNION ALL
      SELECT  805, 'Internal tasks',    'Multiple services started concurrently',            '%Unable to create socket for name%',                    2477204 FROM DUMMY UNION ALL
      SELECT  806, 'Internal tasks',    'Job executor watchdog delay',                       '%jobex watchdog hasn_t run for more than%',             2380176 FROM DUMMY UNION ALL
      SELECT  807, 'Internal tasks',    'Imprecise timer calibration',                       '%The calibration is too imprecise, will try again%',    2380176 FROM DUMMY UNION ALL
      SELECT  808, 'Internal tasks',    'Error while initializing Plan Stability Manager',   '%Error while initializing Plan Stability Manager%',     2799997 FROM DUMMY UNION ALL
      SELECT  810, 'Internal tasks',    'Fallback to dynamic symbol table',                  '%Using%dynamic symbol table for symbols of ELF file%',  2313619 FROM DUMMY UNION ALL
      SELECT  814, 'Internal tasks',    'Concurrent optimize compression failed',            '%Concurrent optimize compression failed%',              2112604 FROM DUMMY UNION ALL
      SELECT  815, 'Internal tasks',    'Termination of attribute merge',                    '%Caught exception merging attributes%',                 2057046 FROM DUMMY UNION ALL
      SELECT  816, 'Internal tasks',    'Rollback of delta merge',                           '%do rollbackDeltaMerge merge%',                         2057046 FROM DUMMY UNION ALL
      SELECT  817, 'Internal tasks',    'Delta merge termination due to a lack of tokens',   '%not enough merge tokens for delta merge%',             2057046 FROM DUMMY UNION ALL
      SELECT  818, 'Internal tasks',    'Delta fusion failure',                              '%Delta fusion failed for Container%',                   3148864 FROM DUMMY UNION ALL
      SELECT  819, 'Internal tasks',    'Open metadata changes during table optimization',   '%table optimization % open metadata changes%',          2057046 FROM DUMMY UNION ALL
      SELECT  820, 'Internal tasks',    'Invalid auto merge decision function',              '%Invalid auto merge decision function%',                2057046 FROM DUMMY UNION ALL
      SELECT  825, 'Internal tasks',    'Smart merge fails due to missing table',            '%Smartmerge failed%table does not exist%',              2057046 FROM DUMMY UNION ALL
      SELECT  826, 'Internal tasks',    'Nameserver not providing node for smart merge',     '%nameserver did not return server%',                    2057046 FROM DUMMY UNION ALL
      SELECT  830, 'Internal tasks',    'Delta merge failure due to OOM',                    '%mergeDeltaIndex failed for%rc=2450%',                  2057046 FROM DUMMY UNION ALL
      SELECT  834, 'Internal tasks',    'Preprocessor activity error',                       '%returning PREPROCESSOR_ACTIVITY_ERROR%',               2800008 FROM DUMMY UNION ALL
      SELECT  835, 'Internal tasks',    'Error during text indexing',                        '%Text analysis error%',                                 2800008 FROM DUMMY UNION ALL
      SELECT  836, 'Internal tasks',    'Exception during row store index creation',         '%Unexpected exception in CP key generation%',           2116157 FROM DUMMY UNION ALL
      SELECT  840, 'Internal tasks',    'Failing metadata access during garbage collection', '%attempt to access metadata of an invalid address%',    2581110 FROM DUMMY UNION ALL
      SELECT  841, 'Internal tasks',    'Failure while removing row store LOB garbage file', '%failed to remove RS lob garbage file%',                2351467 FROM DUMMY UNION ALL
      SELECT  842, 'Internal tasks',    'Deactivation of CS LOB garbage collection',         '%LOB garbage collection is now paused%',                2220627 FROM DUMMY UNION ALL
      SELECT  843, 'Internal tasks',    'Many uncollected row store versions',               '%There are too many un-collected versions%',            2169283 FROM DUMMY UNION ALL
      SELECT  844, 'Internal tasks',    'Termination of suspended statement / idle cursor',  '%Killed long-running idle cursor%',                     2169283 FROM DUMMY UNION ALL
      SELECT  845, 'Internal tasks',    'Long nameserver ping duration',                     '%pingNameServer%takes%seconds%',                        2222110 FROM DUMMY UNION ALL
      SELECT  846, 'Internal tasks',    'Table-wise LOB garbage collection inactive',        '%LOB garbage collection time interval is zero%',        2169283 FROM DUMMY UNION ALL
      SELECT  847, 'Internal tasks',    'Termination of suspended cursor',                   '%Killed long-lived suspended cursor%',                  2169283 FROM DUMMY UNION ALL
      SELECT  850, 'Internal tasks',    'Cancellation still ongoing',                        '%canceled%still not finished%',                         2092196 FROM DUMMY UNION ALL
      SELECT  855, 'Internal tasks',    'Error during late materialization',                 '%Inconsistent lateMat pageSizes%',                      1975448 FROM DUMMY UNION ALL
      SELECT  860, 'Internal tasks',    'Error during trigger execution',                    '%Failed to execute trigger%',                           2800020 FROM DUMMY UNION ALL
      SELECT  865, 'Internal tasks',    'Problems with timezone configuration',              '%Time zone validity checker could not find%',           1932132 FROM DUMMY UNION ALL
      SELECT  866, 'Internal tasks',    'Wrong timezone string',                             '%Error timezone string%',                               1932132 FROM DUMMY UNION ALL
      SELECT  867, 'Internal tasks',    'invalidate_external_inuse_count got stuck',         '%invalidate_external_inuse_count is not finished%',     2092196 FROM DUMMY UNION ALL
      SELECT  868, 'Internal tasks',    'Fallback to system call for high resolution timer', '%Fallback to system call for HR timer%',                2100040 FROM DUMMY UNION ALL
      SELECT  868, 'Internal tasks',    'Fallback to system call for high resolution timer', '%system timer is forced because the clocksource file%', 2100040 FROM DUMMY UNION ALL
      SELECT  869, 'Internal tasks',    'Long runtime of savepoint callback',                '%Callback %::%() took %ms.%',                           2100009 FROM DUMMY UNION ALL
      SELECT  870, 'Internal tasks',    'Significant system time change',                    '%New time value % is significantly less%',              2819632 FROM DUMMY UNION ALL
      SELECT  871, 'Internal tasks',    'Log replay failed',                                 '%ERROR: assertion failed % replay failed%',             2380176 FROM DUMMY UNION ALL
      SELECT  871, 'Internal tasks',    'Log replay failed',                                 '%Index Id: %, replay of log failed%',                   2380176 FROM DUMMY UNION ALL
      SELECT  872, 'Internal tasks',    'Error storing license measurement',                 '%Error storing license measurement%',                   2380176 FROM DUMMY UNION ALL
      SELECT  873, 'Internal tasks',    'Inactive nameserver detected',                      '%detected inactive nameserver%',                        2380176 FROM DUMMY UNION ALL
      SELECT  874, 'Internal tasks',    'No standby hosts configured',                       '%no standby hosts configured%',                         2057595 FROM DUMMY UNION ALL
      SELECT  875, 'Internal tasks',    'Time value far in the future of last calibration',  '%New time value % is far in future compared%',          2907637 FROM DUMMY UNION ALL
      SELECT  876, 'Internal tasks',    'Unknown table metadata accessing column stats',     '%getColumnsStats: unknown table metadata%',             2800028 FROM DUMMY UNION ALL
      SELECT  877, 'Internal tasks',    'Call preparation failed due to invalid query name', '%failed to prepare a new call: invalid query name%',    2380176 FROM DUMMY UNION ALL
      SELECT  878, 'Internal tasks',    'Error while clearing temp index',                   '%error while clearing index%',                          2800007 FROM DUMMY UNION ALL
      SELECT  879, 'Internal tasks',    'Column load failure due to invalid value',          '%JobConcatAttrCalculator%attribute value%6930%',        2952980 FROM DUMMY UNION ALL
      SELECT  880, 'Internal tasks',    'Failure during task data cleanup',                  '%Failed to cleanup side-effect task data%',             2380176 FROM DUMMY UNION ALL
      SELECT  881, 'Internal tasks',    'Error creating join index',                         '%error in creating join index%',                        2380176 FROM DUMMY UNION ALL
      SELECT  882, 'Internal tasks',    'Parallel revalidation failed',                      '%execute parellel re-validation by concurrent update%', 2925103 FROM DUMMY UNION ALL
      SELECT  883, 'Internal tasks',    'Checking of process status failed',                 '%Check process status failed for%',                     2914594 FROM DUMMY UNION ALL
      SELECT  884, 'Internal tasks',    'Exception during row store version removal',        'Exeception while removing version%',                    2169283 FROM DUMMY UNION ALL
      SELECT  885, 'Internal tasks',    'Index manager context wait issues',                 '%context % already waiting for %, can not be waiting%', 2380176 FROM DUMMY UNION ALL
      SELECT  886, 'Internal tasks',    'Error retrieving memory size for license check',    '%Error retrieving used memory size with query%',        1999880 FROM DUMMY UNION ALL
      SELECT  887, 'Internal tasks',    'Optimizer decision result for mget missing',        '%Mget decision result is missing%',                     3364390 FROM DUMMY UNION ALL
      SELECT  888, 'Internal tasks',    'Invalid data statistics',                           '%itsDataStats is not valid%',                           2800028 FROM DUMMY UNION ALL
      SELECT  889, 'Internal tasks',    'Increased clock monitor execution interval',        '%info: high cpu load, this job should run each %',      3435077 FROM DUMMY UNION ALL
      SELECT  900, 'Security',          'Error reading from SAP Logon TrustStore',           '%Error while reading from SAP Logon TrustStore%',       2311047 FROM DUMMY UNION ALL
      SELECT  905, 'Security',          'Error obtaining analytic privileges',               '%Failed to obtain analytical privilege definition%',    2462871 FROM DUMMY UNION ALL
      SELECT  910, 'Security',          'Error obtaining analytic privileges',               '%obtain all%analytical%Invalid SQL AP definition%',     2462871 FROM DUMMY UNION ALL
      SELECT  913, 'Security',          'Connection attempt outside of validity period',     '%connect attempt outside user_s validity period%',      2159014 FROM DUMMY UNION ALL
      SELECT  914, 'Security',          'Missing privilege',                                 '%ser % is missing % privilege%',                        2159014 FROM DUMMY UNION ALL
      SELECT  915, 'Security',          'Insufficient privileges',                           '%insufficient privileges%',                             2159014 FROM DUMMY UNION ALL
      SELECT  916, 'Security',          'Authorization error',                               '%Authorization error%',                                 2159014 FROM DUMMY UNION ALL
      SELECT  917, 'Security',          'No authorization',                                  '%Not authorized%',                                      2159014 FROM DUMMY UNION ALL
      SELECT  918, 'Security',          'User temporarily locked',                           '%lock time for user % is % minutes%',                   2749450 FROM DUMMY UNION ALL
      SELECT  919, 'Security',          'Authentication failure',                            '%authentication failed%',                               2159014 FROM DUMMY UNION ALL
      SELECT  920, 'Security',          'Problem with XS engine authentication',             '%Assertion authentication for user failed%',            2528123 FROM DUMMY UNION ALL
      SELECT  921, 'Security',          'Invalid object found during authorization check',   '%invalid objectId returned from ObjectManager%',        2159014 FROM DUMMY UNION ALL
      SELECT  922, 'Security',          'Password change required for user',                 '%alter password required for user%',                    2159014 FROM DUMMY UNION ALL
      SELECT  923, 'Security',          'Authorization failure in calculation engine',       '%Authorization failed in Calculation Engine.%',         2159014 FROM DUMMY UNION ALL
      SELECT  925, 'Security',          'Inconsistent secure store (SSFS)',                  '%SSFS-3600%',                                           2097613 FROM DUMMY UNION ALL
      SELECT  926, 'Security',          'Inaccessible secure store (SSFS)',                  '%SSFS-1400%permission denied%',                         1999998 FROM DUMMY UNION ALL
      SELECT  927, 'Security',          'Root key hash missing in secure store (SSFS)',      '%Missing root key hash%',                               1999998 FROM DUMMY UNION ALL
      SELECT  930, 'Security',          'Authentication error due to clock skew',            '%Clock skew too great%',                                1283986 FROM DUMMY UNION ALL
      SELECT  931, 'Security',          'Authentication error due to unsupported mechanism', '%An unsupported mechanism was requested%',              2380176 FROM DUMMY UNION ALL
      SELECT  932, 'Security',          'Authentication method not recognized',              '%non recognized % during parse of authentication%',     2159014 FROM DUMMY UNION ALL
      SELECT  935, 'Security',          'Inconsistent SSL configuration',                    '%SSL setting mismatch between local and peer site%',    2380176 FROM DUMMY UNION ALL
      SELECT  936, 'Security',          'SSL handshake failed',                              '%SSL handshake failed%',                                2312071 FROM DUMMY UNION ALL
      SELECT  937, 'Security',          'Authorization check failure due to invalid view',   '%AuthorizationCheck::isAuthorizedToSearch: View%',      2609984 FROM DUMMY UNION ALL
      SELECT  938, 'Security',          'Internal SSL error',                                '%ssl: internal error%',                                 2159014 FROM DUMMY UNION ALL
      SELECT  939, 'Security',          'Empty Kerberos service principal name',             '%Kerberos: Using empty Service Principal Name!%',       2660806 FROM DUMMY UNION ALL
      SELECT  940, 'Security',          'Failure during LDAP search',                        '%LDAP search failed, error code:%',                     2380176 FROM DUMMY UNION ALL
      SELECT  941, 'Security',          'SAML provider configuration not established',       '%SAML Provider configuration not established%',         2159014 FROM DUMMY UNION ALL
      SELECT  942, 'Security',          'Auditing not possible due to missing OID',          '%cannot be audited since no OID could be determined%',  2159014 FROM DUMMY UNION ALL
      SELECT  943, 'Security',          'User permanently locked',                           '%user % is locked forever%',                            2159014 FROM DUMMY UNION ALL
      SELECT  944, 'Security',          'Invalid condition in static filter',                '%Invalid (empty) condition in static filter%',          3135824 FROM DUMMY UNION ALL
      SELECT  945, 'Security',          'User not authorized to access object',              '%Keep authorization error: User%',                      2159014 FROM DUMMY UNION ALL
      SELECT  946, 'Security',          'SSL handshake failed on active SSL channel',        '%ssl handshake failed on active SSL channel%',          2222200 FROM DUMMY UNION ALL
      SELECT 1000, 'Backup',            'Backint response timeout',                          '%Backint did not respond for%',                         2472144 FROM DUMMY UNION ALL
      SELECT 1001, 'Backup',            'Sending signal to backint process failed',          '%Failed to send signal % to backint process with pid%', 1642148 FROM DUMMY UNION ALL
      SELECT 1002, 'Backup',            'Backup session request refused by backint',         '%Server not accepting new save sessions%',              1642148 FROM DUMMY UNION ALL
      SELECT 1003, 'Backup',            'No response from indexserver',                      '%Indexserver not answering. Keeping transfer queue%',   1642148 FROM DUMMY UNION ALL
      SELECT 1004, 'Backup',            'Backup terminated due to backint error',            '%Backup error: Backint exited with exit code%',         1642148 FROM DUMMY UNION ALL
      SELECT 1005, 'Backup',            'Error closing backup destination',                  '%Exception caught while trying to close destination%',  2222200 FROM DUMMY UNION ALL
      SELECT 1006, 'Backup',            'Error returned by backint',                         '%Backup error: Backint reported%',                      1642148 FROM DUMMY UNION ALL
      SELECT 1007, 'Backup',            'Premature data write termination',                  '%Not all data could be written%',                       2484702 FROM DUMMY UNION ALL
      SELECT 1008, 'Backup',            'Data backup error',                                 '%SAVE DATA finished with error%',                       1642148 FROM DUMMY UNION ALL
      SELECT 1010, 'Backup',            'Log backup error',                                  '%Error during log segment backup%',                     1642148 FROM DUMMY UNION ALL
      SELECT 1013, 'Backup',            'Exception while executing catalog backup',          '%Exception while executing catalog backup%',            1642148 FROM DUMMY UNION ALL
      SELECT 1015, 'Backup',            'Data backup for recoverability needed',             '%BACKUP DATA needed to ensure recoverability%',         1642148 FROM DUMMY UNION ALL
      SELECT 1017, 'Backup',            'Unknown log_backup_interval_mode specified',        '%Unknown log backup interval mode%',                    3353169 FROM DUMMY UNION ALL
      SELECT 1018, 'Backup',            'Unknown log_mode specified',                        '%Unknown log mode specified, value not changed%',       2765887 FROM DUMMY UNION ALL
      SELECT 1020, 'Backup',            'Log backup stopped (object does not exist)',        '%Report backup failure: Object % does not exist%',      2601881 FROM DUMMY UNION ALL
      SELECT 1021, 'Backup',            'Log history lost',                                  '%HISTORY LOST at log position%',                        1642148 FROM DUMMY UNION ALL
      SELECT 1022, 'Backup',            'Timeout waiting for channel event',                 '%timeout while%waiting for channel event%',             2380176 FROM DUMMY UNION ALL
      SELECT 1023, 'Backup',            'Incomplete multistream backup to secondary',        '%multistream, writeBackupToSecondary: copy incomp%',    1642148 FROM DUMMY UNION ALL
      SELECT 1024, 'Backup',            'Concurrent storage snapshot or data backup run',    '%storage snapshot cannot be prepared%already%',         1642148 FROM DUMMY UNION ALL
      SELECT 1025, 'Backup',            'No valid snapshot backup found',                    '%No valid snapshot has been found%',                    1642148 FROM DUMMY UNION ALL
      SELECT 1026, 'Backup',            'No backint result found in file',                   '%BACKINT did not return result for%',                   1642148 FROM DUMMY UNION ALL
      SELECT 1028, 'Backup',            'Backup could not be completed',                     '%backup could not be completed%',                       1642148 FROM DUMMY UNION ALL
      SELECT 1030, 'Backup',            'Missing redo log file',                             '%Missing _LogSegment_ file%',                           1642148 FROM DUMMY UNION ALL
      SELECT 1100, 'Application',       'Inadequate BW partitioning',                        '%Potential performance problem: Table%',                2158927 FROM DUMMY UNION ALL
      SELECT 1110, 'Application',       'Error during DSO uniqueness check',                 '%uniqueIdInserted.second%Correlation id is%',           2380176 FROM DUMMY UNION ALL
      SELECT 1200, 'System rep.',       'Communication channel closed',                      '%Communication channel closed%',                        1999880 FROM DUMMY UNION ALL
      SELECT 1203, 'System rep.',       'No host on other system replication site reached',  '%Could not reach any host of site%',                    1999880 FROM DUMMY UNION ALL
      SELECT 1204, 'System rep.',       'No parameter details received from remote site',    '%Received no inifile entries from site id%',            1999880 FROM DUMMY UNION ALL
      SELECT 1205, 'System rep.',       'Log shipping timeout',                              '%Closing connection%LogShipping was waiting%',          1999880 FROM DUMMY UNION ALL
      SELECT 1206, 'System rep.',       'Log shipping timeout on secondary',                 '%log buffer takes more than % to process and write%',   1999880 FROM DUMMY UNION ALL
      SELECT 1210, 'System rep.',       'Asynchronous log shipping buffer full',             '%Asynchronous Replication Buffer is Overloaded%',       1999880 FROM DUMMY UNION ALL
      SELECT 1210, 'System rep.',       'Asynchronous log shipping buffer full',             '%Asynchronous replication buffer full%',                1999880 FROM DUMMY UNION ALL
      SELECT 1215, 'System rep.',       'Host name not found in SR host name resolution',    '%resolveHost%not found%system_replication_hostname%',   1999880 FROM DUMMY UNION ALL
      SELECT 1216, 'System rep.',       'Host name resolution problem',                      '%he hostname could not be resolved%',                   1999880 FROM DUMMY UNION ALL
      SELECT 1220, 'System rep.',       'Incompatible release version',                      '%drGetServers: incompatible version%',                  2485391 FROM DUMMY UNION ALL
      SELECT 1222, 'System rep.',       'Fallback for sending encrypted request',            '%Successfully sending encrypted request%',              2380176 FROM DUMMY UNION ALL
      SELECT 1224, 'System rep.',       'Invalid message type',                              '%invalid message type%',                                1999880 FROM DUMMY UNION ALL
      SELECT 1226, 'System rep.',       'Listener port already in use',                      '%Listener cannot be started, because port%',            3381915 FROM DUMMY UNION ALL
      SELECT 1228, 'System rep.',       'No more log replay callbacks available',            '%No more callbacks available% wait for callbacks%',     1999880 FROM DUMMY UNION ALL
      SELECT 1230, 'System rep.',       'Read access to secondary site disabled',            '%Disabling read access to secondary system!%',          3491030 FROM DUMMY UNION ALL
      SELECT 1300, 'Export / import',   'Failing binary raw import',                         '%importBinaryRawForColumnTable has failed%',            2222277 FROM DUMMY UNION ALL
      SELECT 1310, 'Export / import',   'Failing import',                                    '%Import has failed during checking its feasibility%',   2222277 FROM DUMMY UNION ALL
      SELECT 1315, 'Export / import',   'Import fails due to column store version mismatch', '%Invalid column store version match%',                  2222277 FROM DUMMY UNION ALL
      SELECT 1400, 'liveCache',         'liveCache procedure termination',                   '%Execute of % failed with OmsTerminate%',               2593571 FROM DUMMY UNION ALL
      SELECT 1400, 'liveCache',         'liveCache procedure termination',                   '%OmsHandle::omsTerminate in method%',                   2593571 FROM DUMMY UNION ALL
      SELECT 1401, 'liveCache',         'Unexpected exception executing procedure',          '%unexpected exception: function_name=%',                2593571 FROM DUMMY UNION ALL
      SELECT 1410, 'liveCache',         'Max. OMS version retention time reached',           '%OmsVersion max_version_retention time reached%',       2392715 FROM DUMMY UNION ALL
      SELECT 1410, 'liveCache',         'Max. OMS version retention time reached',           '%liveCache DbpError -28514%',                           2392715 FROM DUMMY UNION ALL
      SELECT 1411, 'liveCache',         'Versions dropped after min. retention time',        '%OmsVersion canceled by ResourceManager%',              2593571 FROM DUMMY UNION ALL
      SELECT 1412, 'liveCache',         'Terminations with general assertion error (16901)', '%liveCache ERROR 16901%',                               2593571 FROM DUMMY UNION ALL
      SELECT 1413, 'liveCache',         'ABAP communication failure',                        '%abap communication failure was detected%',             2593571 FROM DUMMY UNION ALL
      SELECT 1414, 'liveCache',         'ABAP stream assertion failure',                     '%assertion failed when receiving abap stream%',         2593571 FROM DUMMY UNION ALL
      SELECT 1420, 'liveCache',         'Bad allocation termination',                        '%Bad Allocation exception%',                            2593571 FROM DUMMY UNION ALL
      SELECT 1500, 'SQL',               'Error pinning SQL plan',                            '%failed in insert custom plan%',                        2222321 FROM DUMMY UNION ALL
      SELECT 1510, 'SQL',               'Statement recompilation required due to exception', '%statement recompile required%',                        2124112 FROM DUMMY UNION ALL
      SELECT 1511, 'SQL',               'Error during SQL statement compilation',            '%Error during sql statement compilation%',              2380176 FROM DUMMY UNION ALL
      SELECT 1512, 'SQL',               'Statement retry failed',                            '%retry failed because stmt is not retriable%',          2380176 FROM DUMMY UNION ALL
      SELECT 1600, 'SLD',               'Error executing sldreg',                            '%Error executing "sldreg%',                             2380176 FROM DUMMY UNION ALL
      SELECT 1605, 'SLD',               'Config file for sldreg missing',                    '%SldReg config file missing%',                          2533657 FROM DUMMY UNION ALL
      SELECT 1606, 'SLD',               'Failure loading landscape description',             '%Load Landscape Description failed%',                   2739643 FROM DUMMY UNION ALL
      SELECT 1607, 'SLD',               'Error parsing landscapeDescription.xml file',       '%Error while parsing XML file landscapeDescription%',   2739643 FROM DUMMY UNION ALL
      SELECT 1610, 'SLD',               'Product with missing key property',                 '%misses key propert% and will not be reported%',        2380176 FROM DUMMY UNION ALL
      SELECT 1615, 'SLD',               'Inadequate logical database name configuration',    '%SAP_IdenticalDatabaseSystem % hostname configured%',   2380176 FROM DUMMY UNION ALL
      SELECT 1616, 'SLD',               'Identical logical database name configuration',     '%SAP_IdenticalDatabaseSystem % identical%',             2380176 FROM DUMMY UNION ALL
      SELECT 1700, 'XS engine',         'Terminations due to HTTP request timeout',          '%script has exceeded the maximum request runtime%',     2000003 FROM DUMMY UNION ALL
      SELECT 1702, 'XS engine',         'Write I/O failure',                                 'Write to IO failed, rc=%',                              2380176 FROM DUMMY UNION ALL
      SELECT 1800, 'Repository',        'Error during repository activation',                '%Repository: Activation failed%',                       2159014 FROM DUMMY UNION ALL
      SELECT 1805, 'Repository',        'Delivery unit not found',                           '%Repository: delivery unit not found%',                 2380176 FROM DUMMY UNION ALL
      SELECT 1810, 'Repository',        'Inactive object to be activated does not exist',    '%Inactive object to be activated does not exist%',      3280628 FROM DUMMY UNION ALL
      SELECT 1811, 'Repository',        'Unexpected exception in repository',                '%Repository: Encountered an unexpected exception%',     2380176 FROM DUMMY UNION ALL
      SELECT 1812, 'Repository',        'Lock timeout during repository activation',         '%Repository activation lock timeout%',                  2380176 FROM DUMMY UNION ALL
      SELECT 1900, 'Python',            'Use of disallowed subprocess / popen2 calls',       '%Usage of subprocess/popen2 not allowed%',              2615046 FROM DUMMY UNION ALL
      SELECT 1902, 'Python',            'Python trace file size limit reached',              '%cannot proceed with tracing% filesize_limit for%',     2629103 FROM DUMMY UNION ALL
      SELECT 2000, 'Limitations',       'Result size limit exceeded',                        '%result size limit exceeded%',                          2154870 FROM DUMMY UNION ALL
      SELECT 2001, 'Limitations',       'Column search result limit reached',                '%column search intermediate result exceeds%',           2154870 FROM DUMMY UNION ALL
      SELECT 2002, 'Limitations',       'OLAP temporary data size exceeded 31/32 bit limit', '%Olap temporary data size exceeded 31/32 bit limit%',   2154870 FROM DUMMY UNION ALL
      SELECT 2003, 'Limitations',       'Intermediate result set exceeds signed 32 bit',     '%total size larger than signed 32bit%',                 2154870 FROM DUMMY UNION ALL
      SELECT 2004, 'Limitations',       'Intermediate result set exceeds supported limit',   '%intermediate results exceeds supported limit%',        2154870 FROM DUMMY UNION ALL
      SELECT 2005, 'Limitations',       'MDS intermediate result size exceeds limit',        '%more records than the limit in MaxResultRecords%',     2770570 FROM DUMMY UNION ALL
      SELECT 2006, 'Limitations',       'Legacy engine result size exceeds 4 billion',       '%search result has too many rows%',                     2154870 FROM DUMMY UNION ALL
      SELECT 2006, 'Limitations',       'Legacy engine result size exceeds 4 billion',       '%Execution of search failed: max_result_size reached%', 2154870 FROM DUMMY UNION ALL
      SELECT 2007, 'Limitations',       'Join engine assembly result exceeds 2 billion',     '%Can_t create result with more than > 2^31 rows.%',     2154870 FROM DUMMY UNION ALL
      SELECT 2008, 'Limitations',       'Maximum number of session variables reached',       '%exceeded the maximum number of session variables%',    2154870 FROM DUMMY UNION ALL
      SELECT 2009, 'Limitations',       'Connections reaching session partition limit',      '%number of connections are exceeded%',                  2154870 FROM DUMMY UNION ALL
      SELECT 2010, 'Limitations',       'Connections reaching limit',                        '%exceed 90% of max connection limit%',                  2154870 FROM DUMMY UNION ALL
      SELECT 2011, 'Limitations',       'Maximum number of external connections reached',    '%maximum number of external connections%exceeded%',     2154870 FROM DUMMY UNION ALL
      SELECT 2012, 'Limitations',       'Maximum number of row store containers reached',    '%MM: exceed max number (%) of containers%',             2154870 FROM DUMMY UNION ALL
      SELECT 2013, 'Limitations',       'Maximum number of transactions reached',            '%exceed maximum number of transactions%',               2154870 FROM DUMMY UNION ALL
      SELECT 2014, 'Limitations',       'Maximum number of prepared statements reached',     '%exceed maximum number of prepared statements%',        2154870 FROM DUMMY UNION ALL
      SELECT 2014, 'Limitations',       'Maximum number of prepared statements reached',     '%prepared statements per connection cannot exceed%',    2154870 FROM DUMMY UNION ALL
      SELECT 2015, 'Limitations',       'Maximum number of XSC bind values exceeded',        '%too many parameters are set%',                         3040627 FROM DUMMY UNION ALL
      SELECT 2016, 'Limitations',       'Maximum number of rows per modification exceeded',  '%following assertion failed: !(units[rhs.beginOffset',  2154870 FROM DUMMY UNION ALL
      SELECT 2020, 'Limitations',       'Maximum number of rows per partition reached',      '%Maximum number of rows per partition reached%',        2154870 FROM DUMMY UNION ALL
      SELECT 2021, 'Limitations',       'Maximum column store row count exceeded',           '%Max row count exceeded%',                              2154870 FROM DUMMY UNION ALL
      SELECT 2030, 'Limitations',       'Maximum number of log segments reached',            '%maximum number of log segments in log partition%',     2072410 FROM DUMMY UNION ALL
      SELECT 2040, 'Limitations',       'Row store size limit reached',                      '%reached max RS SHM segments%',                         2154870 FROM DUMMY UNION ALL
      SELECT 2042, 'Limitations',       'Maximum statement retry limit reached',             '%max restart limit exceeded%',                          2154870 FROM DUMMY UNION ALL
      SELECT 2045, 'Limitations',       'Size of SDI persistent data store reached limit',   '%Data store reached configured max capacity%',          3065904 FROM DUMMY UNION ALL
      SELECT 2048, 'Limitations',       'Stack limit reached',                               '%Free stack is less than required!%',                   3215563 FROM DUMMY UNION ALL
      SELECT 2050, 'Limitations',       'Maximum LOB size for $.hdb XSC connection reached', '%Total hybrid LOB size exceeds the limit of%',          2220627 FROM DUMMY UNION ALL
      SELECT 2052, 'Limitations',       'File size limitation of tar format export reached', '%general error: file % of size % exceeds max size%',    2154870 FROM DUMMY UNION ALL
      SELECT 2060, 'Limitations',       'Number of open files limit reached',                '%Too many open files%',                                 2600030 FROM DUMMY UNION ALL
      SELECT 2100, 'Table rep.',        'Replication log space full',                        '%replication log % replication log space is full%',     2673956 FROM DUMMY UNION ALL
      SELECT 2102, 'Table rep.',        'Asynchronous replica disabled due to exception',    '%turnOffAsyncReplication% EXCEPTION%',                  2340450 FROM DUMMY UNION ALL
      SELECT 2104, 'Table rep.',        'Error during activation of table replication',      '%Exception % ReplicationTurnOnWorker%',                 2340450 FROM DUMMY UNION ALL
      SELECT 2104, 'Table rep.',        'Error during activation of table replication',      '%Exception % turnOnAsyncReplicationReplicaImpl%',       2340450 FROM DUMMY UNION ALL
      SELECT 2106, 'Table rep.',        'Failure enforcing dummy commit',                    '%Failed to enforce dummy commit%',                      2340450 FROM DUMMY UNION ALL
      SELECT 2110, 'Table rep.',        'Uncommitted transaction timeout',                   '%replicated tables are waiting synchronous commit%',    2711518 FROM DUMMY UNION ALL
      SELECT 2115, 'Table rep.',        'Unsuccessful replication log replay retries',       '%Replication Log Replayer % has retried a DML log%',    2966375 FROM DUMMY UNION ALL
      SELECT 2120, 'Table rep.',        'Internal error sending replication log',            '%[Send RepLog] exception thrown: internal error%',      2340450 FROM DUMMY UNION ALL
      SELECT 2200, 'SDA / SDI / SDQ',   'Failure initializing HanaTransform object',         '%Failed to create or initialize HanaTransform object%', 2713209 FROM DUMMY UNION ALL
      SELECT 2201, 'SDA / SDI / SDQ',   'Error accessing remote source',                     '%exception%155001%',                                    2380176 FROM DUMMY UNION ALL
      SELECT 2202, 'SDA / SDI / SDQ',   'Unavailability of agent',                           '%exception%151044%Agent "%" is not available.%',        2380176 FROM DUMMY UNION ALL
      SELECT 2203, 'SDA / SDI / SDQ',   'Remote source test connection failed',              '%Test connect failed with errorCode%',                  2400022 FROM DUMMY UNION ALL
      SELECT 2204, 'SDA / SDI / SDQ',   'Remote source is down',                             '%Remote source is down!%',                              2400022 FROM DUMMY UNION ALL
      SELECT 2205, 'SDA / SDI / SDQ',   'Agent shutdown due to failed pings',                '%Shutting down agent %, too many failed pings.%',       2400022 FROM DUMMY UNION ALL
      SELECT 2206, 'SDA / SDI / SDQ',   'Access failure due to initializing remote source',  '%Replication subsystem is initializing for remote%',    2400022 FROM DUMMY UNION ALL
      SELECT 2207, 'SDA / SDI / SDQ',   'No agent for failover found',                       '%Failed to find an agent to fail over from%',           2400022 FROM DUMMY UNION ALL
      SELECT 2208, 'SDA / SDI / SDQ',   'No active agent found in agent group',              '%Could not find any active agent for the agent group%', 2400022 FROM DUMMY UNION ALL
      SELECT 2210, 'SDA / SDI / SDQ',   'ODBC errors',                                       '%ODBC error: %connected%',                              2180119 FROM DUMMY UNION ALL
      SELECT 2211, 'SDA / SDI / SDQ',   'ODBC configuration file cannot be opened',          '%Configuration file:% could not be opened.%',           2180119 FROM DUMMY UNION ALL
      SELECT 2214, 'SDA / SDI / SDQ',   'Expired SDI session ID',                            '%::sendMessage: Session ID has expired%',               2400022 FROM DUMMY UNION ALL
      SELECT 2215, 'SDA / SDI / SDQ',   'Invalid SDI session ID',                            '%::sendMessage: Invalid session id%',                   2827947 FROM DUMMY UNION ALL
      SELECT 2216, 'SDA / SDI / SDQ',   'Timeout sending message',                           '%::sendMessage: Request timed out.%',                   2400022 FROM DUMMY UNION ALL
      SELECT 2217, 'SDA / SDI / SDQ',   'Network adapter cannot establish connection',       '%Network Adapter could not establish the connection%',  2400022 FROM DUMMY UNION ALL
      SELECT 2218, 'SDA / SDI / SDQ',   'Error retrieving next row from result set',         '%Error occurred when getting next row from ResultSet%', 2400022 FROM DUMMY UNION ALL
      SELECT 2219, 'SDA / SDI / SDQ',   'Adapter validation failed',                         '%Adapter validation failed%',                           2400022 FROM DUMMY UNION ALL
      SELECT 2220, 'SDA / SDI / SDQ',   'Overflow converting character to integer',          '%conversion of the nvarchar value %overflowed an int%', 2400022 FROM DUMMY UNION ALL
      SELECT 2221, 'SDA / SDI / SDQ',   'Failure starting subscription',                     '%Failed to start subscription%',                        2400022 FROM DUMMY UNION ALL
      SELECT 2222, 'SDA / SDI / SDQ',   'Failure processing remote subscription exception',  '%Cannot PROCESS REMOTE SUBSCRIPTION EXCEPTION%',        2476155 FROM DUMMY UNION ALL
      SELECT 2223, 'SDA / SDI / SDQ',   'Remote source exception',                           '%Exceptions exist for remote source%',                  2400022 FROM DUMMY UNION ALL
      SELECT 2225, 'SDA / SDI / SDQ',   'Create session request timeout',                    '%DPAdapter%failed with error: Request timed out.%',     2400022 FROM DUMMY UNION ALL
      SELECT 2230, 'SDA / SDI / SDQ',   'Idle time of prefetch too long',                    '%Idle for too long, halting prefetch%',                 2400022 FROM DUMMY UNION ALL
      SELECT 2231, 'SDA / SDI / SDQ',   'Prefetch timeout',                                  '%failed with error: Prefetch timed out.%',              2400022 FROM DUMMY UNION ALL
      SELECT 2232, 'SDA / SDI / SDQ',   'Send message prefetch timeout',                     '%::sendMessage: Prefetch timed out.%',                  2400022 FROM DUMMY UNION ALL
      SELECT 2235, 'SDA / SDI / SDQ',   'High memory usage reported by housekeeping thread', '%OOM!%ReceiverHouseKeepingThread%',                     3307153 FROM DUMMY UNION ALL
      SELECT 2240, 'SDA / SDI / SDQ',   'Runtime data not accessible',                       '%Runtime data is not accessible% LogReplayReadAccess%', 2400022 FROM DUMMY UNION ALL
      SELECT 2241, 'SDA / SDI / SDQ',   'Meta data not found for remote source',             '%Meta data not found for remote source ID%',            2400022 FROM DUMMY UNION ALL
      SELECT 2242, 'SDA / SDI / SDQ',   'M_REMOTE_SUBSCRIPTIONS meta data failure',          '%M_REMOTE_SUBSCRIPTIONS%Failed to get runtime meta%',   2400022 FROM DUMMY UNION ALL
      SELECT 2243, 'SDA / SDI / SDQ',   'Error retrieving remote metadata',                  '%invalid remote object name%',                          2180119 FROM DUMMY UNION ALL
      SELECT 2244, 'SDA / SDI / SQQ',   'ODBC column attribute not implemented',             '%ODBC column attr not implemented: 1013%',              2180119 FROM DUMMY UNION ALL
      SELECT 2245, 'SDA / SDI / SDQ',   'Non-count functions not supported by adapter',      '%only count function is supported in projection%',      3382857 FROM DUMMY UNION ALL
      SELECT 2246, 'SDA / SDI / SDQ',   'Exception during SDI replication task activation',  '%Replication task activation error with SQLException%', 2400022 FROM DUMMY UNION ALL
      SELECT 2247, 'SDA / SDI / SDQ',   'MSSQL remote login timeout',                        '%[ODBC Driver % for SQL Server]Login timeout expired%', 2741672 FROM DUMMY UNION ALL
      SELECT 2248, 'SDA / SDI / SDQ',   'Data provisioning server busy',                     '%Operation Failed: Data provisioning server is busy.%', 2400022 FROM DUMMY UNION ALL
      SELECT 2249, 'SDA / SDI / SDQ',   'Connectivity to remote Oracle database lost',       '%SQLDisconnect() failed %ORA-03113%',                   2380176 FROM DUMMY UNION ALL
      SELECT 2300, 'Administration',    'Transactions terminated with hdbcons',              '%(transaction external command) Successfully cancel%',  2222218 FROM DUMMY UNION ALL
      SELECT 2301, 'Administration',    'Connections terminated with hdbcons',               '%(connection external command) Successfully%',          2222218 FROM DUMMY UNION ALL
      SELECT 2309, 'Administration',    'Performance analyzer scope holder not found',       '%scope as the scope holder was not found%',             2119087 FROM DUMMY UNION ALL
      SELECT 2310, 'Administration',    'Unknown trace level configured',                    '%unknown trace level string:%',                         2380176 FROM DUMMY UNION ALL
      SELECT 2311, 'Administration',    'Trace level "none" configured',                     '%Specified trace level None for trace topic%',          2380176 FROM DUMMY UNION ALL
      SELECT 2312, 'Administration',    'Parameter file not starting with [ character',      '%Did not read [ as first non-whitespace character%',    2186744 FROM DUMMY UNION ALL
      SELECT 2313, 'Administration',    'Parameter with illegal characters',                 '%Parameter % contains illegal characters%',             2186744 FROM DUMMY UNION ALL
      SELECT 2314, 'Administration',    'Wrong parameter value',                             '%Invalid configuration value%',                         2186744 FROM DUMMY UNION ALL
      SELECT 2315, 'Administration',    'Parameter parsing error',                           '%Parameter parsing error%',                             2186744 FROM DUMMY UNION ALL
      SELECT 2316, 'Administration',    'No internal interface configuration found',         '%no internal interface found%',                         2555969 FROM DUMMY UNION ALL
      SELECT 2320, 'Administration',    'Date / time error in M_EXPENSIVE_STATEMENTS',       '%error in DATE/TIME conversion%',                       2180165 FROM DUMMY UNION ALL
      SELECT 2325, 'Administration',    'Premature termination of data volume reclaim',      '%Stop marking and moving due to intensive parallel%',   2973560 FROM DUMMY UNION ALL
      SELECT 2326, 'Administration',    'Data volume reclaim with low percentage',           '%Reclaiming %result in heavy IO load and long%',        2400005 FROM DUMMY UNION ALL
      SELECT 2330, 'Administration',    'OS parameter shmmni configured too small',          '%number of segment >= (total memory/64MB)*2%',          2600030 FROM DUMMY UNION ALL
      SELECT 2340, 'Administration',    'Log volume full situation',                         '%event not handled: DiskFullEvent%',                    1679938 FROM DUMMY UNION ALL
      SELECT 2400, 'MDX / MDS',         'Failure reading calculation engine metadata',       '%CalculationEngine read from metadata failed%',         2670064 FROM DUMMY UNION ALL
      SELECT 2402, 'MDX / MDS',         'Column not found in dimension itab',                '%Column not found in dimension itab:%',                 2670064 FROM DUMMY UNION ALL
      SELECT 2410, 'MDX / MDS',         'Error during execution of scenario',                '%Error during execution of scenario%',                  2670064 FROM DUMMY UNION ALL
      SELECT 2420, 'MDX / MDS',         'Unsuccessful insert into MDX entity cache',         '%entitycache insert unsuccessful%',                     2502256 FROM DUMMY UNION ALL
      SELECT 2430, 'MDX / MDS',         'Timeout waiting for internal table storage',        'Wait timed out',                                        2670064 FROM DUMMY UNION ALL
      SELECT 2500, 'SQLScript',         'Error recompiling procedure',                       '%Failed to recompile procedure%',                       2380176 FROM DUMMY UNION ALL
      SELECT 2505, 'SQLScript',         'Invalid table type number string',                  '%not a valid number string%derive table type%',         2380176 FROM DUMMY UNION ALL
      SELECT 2600, 'NSE',               'NSE buffer cache ran out of buffers',               '%Buffer cache has run out of buffers%',                 2799997 FROM DUMMY UNION ALL
      SELECT 2602, 'NSE',               'NSE buffer cache out-of-buffer termination',        '%CS cannot provide requested memory as%',               2799997 FROM DUMMY UNION ALL
      SELECT 2604, 'NSE',               'NSE out-of-buffer event reported',                  '%Event_OutOfBuffersEvent%',                             2799997 FROM DUMMY UNION ALL
      SELECT 2610, 'NSE',               'Index handle issue accessing M_CS_NSE_ADVISOR',     '%M_CS_NSE_ADVISOR%failure in acquiring index handle%',  3125519 FROM DUMMY UNION ALL
      SELECT 2700, 'Planning engine',   'Planning engine session invalidation',              '%Invalidate the session % due to an exception%',        2380176 FROM DUMMY UNION ALL
      SELECT 2702, 'Planning engine',   'Internal error during pre-instantiation',           '%Internal error during pre-instantiation%',             3092260 FROM DUMMY UNION ALL
      SELECT 2704, 'Planning engine',   'Planning engine save failed',                       '%Condition _lSavedOk_ failed.%',                        3092260 FROM DUMMY UNION ALL
      SELECT 2706, 'Planning engine',   'Planning engine type check failed',                 '%Error: Type check failed: expected%',                  3092260 FROM DUMMY UNION ALL
      SELECT 2800, 'Statistics server', 'Re-installation of statistics server',              'retry installation of the Embedded Statistics Server',  2147247 FROM DUMMY UNION ALL
      SELECT 2805, 'Statistics server', 'Statistics server disabled',                        'disable Embedded Statistics Server',                    2658611 FROM DUMMY UNION ALL
      SELECT 2806, 'Statistics server', 'Update failure due to disabled statistics server',  '%ImportOrUpdateContent due to inactive / failing%',     2658611 FROM DUMMY UNION ALL
      SELECT 2900, 'Enterprise search', 'Error during enterprise search',                    '%ESH_SEARCH error:%',                                   2380176 FROM DUMMY UNION ALL
      SELECT 2901, 'Enterprise search', 'Exception during ESH serialize',                    '%ESHException in serialize%',                           2380176 FROM DUMMY UNION ALL
      SELECT 2902, 'Enterprise search', 'Conversion to freestyle query failed',              '%convert queryEntry to FreestyleQuery%',                2380176 FROM DUMMY UNION ALL
      SELECT 2910, 'Enterprise search', 'Failure during 1:n check',                          '1:n check failed%',                                     2380176 FROM DUMMY UNION ALL
      SELECT 3000, 'Deployment inf.',   'Malformed location string received',                '%DI received notification with malformed location%',    2380176 FROM DUMMY UNION ALL
      SELECT 3200, 'Runtime error',     'Workload context assertion failed',                 '%The following assertion failed: m_hWorkloadCtx%',      3142383 FROM DUMMY UNION ALL
      SELECT 3201, 'Runtime error',     'Read-only assertion failed',                        '%assertion failed: !rowIdCol->isReadOnly%',             3166743 FROM DUMMY UNION ALL
      SELECT 3202, 'Runtime error',     'Failure during postfix conversion',                 '%convertToPostfix failed, invalid query rc=2029%',      3064971 FROM DUMMY UNION ALL
      SELECT 3203, 'Runtime error',     'Syntax error during infix parsing',                 '%parseInfix(): Syntactical description of query%',      3064971 FROM DUMMY UNION ALL
      SELECT 3204, 'Runtime error',     'Error establishing host agent connection',          'initializeConnection: % Host Agent%',                   1969700 FROM DUMMY UNION ALL
      SELECT 3205, 'Runtime error',     'Error retrieving column information',               'c%not get attribute info for%',                         3119296 FROM DUMMY UNION ALL
      SELECT 3206, 'Runtime error',     'Insufficient row segment space for next row',       '%insufficient row segment space for next row%',         3221279 FROM DUMMY UNION ALL
      SELECT 3207, 'Runtime error',     'Violated DocID restriction',                        '%sorted and not contain duplicates%violating docids%',  3248936 FROM DUMMY UNION ALL
      SELECT 3208, 'Runtime error',     'DicVal not found',                                  '%Error in the generated plan. DicVal%not found%',       3198590 FROM DUMMY UNION ALL
      SELECT 3209, 'Runtime error',     'Unknown view column in query',                      '%unknown view attribute in query%',                     2806646 FROM DUMMY UNION ALL
      SELECT 3210, 'Runtime error',     'Instantiation of model node not successful',        '%Model instantiation failed during the instantiation%', 2380176 FROM DUMMY UNION ALL
      SELECT 3211, 'Runtime error',     'Error during join engine estimation',               '%estimateParallel failed rc=%',                         2380176 FROM DUMMY UNION ALL
      SELECT 3212, 'Runtime error',     'Plan cannot be stopped',                            '%Unable to stop our plan % after % attempts.%',         2380176 FROM DUMMY UNION ALL
      SELECT 3213, 'Runtime error',     'Invalid hierarchy due to IndexAliasOperation',      '%at least one IndexAliasOperation is incorrect%',       2380176 FROM DUMMY UNION ALL
      SELECT 3214, 'Runtime error',     'Attribute / part provider mapping not found',       '%No mapping found for attribute%part provider%',        3267320 FROM DUMMY UNION ALL
      SELECT 3215, 'Runtime error',     'Code generation for constant children failed',      '%constant children: code generation failed%',           2637433 FROM DUMMY UNION ALL
      SELECT 3216, 'Runtime error',     'Join engine result calculation with docids failed', '%simple result calculation with docids failed%',        2380176 FROM DUMMY UNION ALL
      SELECT 3217, 'Runtime error',     'Index syncpoint mismatch',                          '%ndex syncpoint mismatch%',                             2380176 FROM DUMMY UNION ALL
      SELECT 3218, 'Runtime error',     'Exception when creating SQL cache statistics',      '%exception in check_and_create_stat_entry%',            2124112 FROM DUMMY UNION ALL
      SELECT 3219, 'Runtime error',     'Transaction rollback',                              'Trans rollback: tx_oid=%',                              3290385 FROM DUMMY UNION ALL
      SELECT 3220, 'Runtime error',     'Internal error during chunk-wise insert',           '%ChunkWise Insert-subSelect error: internal error%',    2380176 FROM DUMMY UNION ALL
      SELECT 3221, 'Runtime error',     'Invalidated procedure',                             '%invalidated procedure%',                               2935599 FROM DUMMY UNION ALL
      SELECT 3222, 'Runtime error',     'Value exceeds maximum variable length',             '%Assigned value for parameter % exceeds maximum%',      2380176 FROM DUMMY UNION ALL
      SELECT 3223, 'Runtime error',     'Calculation view not found',                        '%Calc view % could not be resolved or does not exist%', 2380176 FROM DUMMY UNION ALL
      SELECT 3224, 'Runtime error',     'Failed history table sync point',                   '%Failed sync point with respect to last historization%',2380176 FROM DUMMY UNION ALL
      SELECT 3225, 'Runtime error',     'Error while creating translator cache',             '%Exception caught when creating translator%',           2092196 FROM DUMMY UNION ALL
      SELECT 3226, 'Runtime error',     'Statement rollback of DDL operation not allowed',   '%statement rollback of DDL transactions disallowed%',   3349076 FROM DUMMY UNION ALL
      SELECT 3227, 'Runtime error',     'Full rollback scenario during statement rollback',  '%full rollback situation during statement rollback%',   3349076 FROM DUMMY UNION ALL
      SELECT 3228, 'Runtime error',     'Failure during partial abort',                      '%partial abort failed in retry exception handler%',     3349076 FROM DUMMY UNION ALL
      SELECT 3229, 'Runtime error',     'LOB type not allowed in SORT table',                '%LOB type % not allowed to be defined in SORT table%',  2220627 FROM DUMMY UNION ALL
      SELECT 3230, 'Runtime error',     'Unhandled ltt exception',                           '%unhandled ltt exception was caught%',                  2380176 FROM DUMMY UNION ALL
      SELECT 3231, 'Runtime error',     'Element not found in IndexInfoMap',                 '%could not find %in indexInfoMap%',                     2380176 FROM DUMMY UNION ALL
      SELECT 3232, 'Runtime error',     'Highlighted text neither TEXT nor fulltext index',  '%attribute % neither of type TEXT nor has a fulltext%', 2380176 FROM DUMMY UNION ALL
      SELECT 3233, 'Runtime error',     'Empty scenario name',                               '%find referenced scenario: Scenario name is empty%',    2380176 FROM DUMMY UNION ALL
      SELECT 3234, 'Runtime error',     'Unsupported use of negation + OR freestyle search', '%Negated terms in combination with OR are not supp%',   2800008 FROM DUMMY UNION ALL
      SELECT 3235, 'Runtime error',     'Invalid transaction state',                         '%nvalid transaction state%',                            2380176 FROM DUMMY UNION ALL
      SELECT 3236, 'Runtime error',     'Metadata for temp index not found',                 '%cannot find temp index metadata with parameter%',      2800007 FROM DUMMY UNION ALL
      SELECT 3237, 'Runtime error',     'INT / string join not supported by OLAP engine',    '%Joining from int to string not supported by OLAP%',    3403995 FROM DUMMY UNION ALL
      SELECT 3238, 'Runtime error',     'Invalid table name',                                '%invalid table name%',                                  2380176 FROM DUMMY UNION ALL
      SELECT 3239, 'Runtime error',     'Error validating calculation scenario sources',     '%Error validating the calculation scenario sources%',   2380176 FROM DUMMY UNION ALL
      SELECT 3240, 'Runtime error',     'Unsupported DAF migration',                         '%Unsupported DAF migration from version%',              2940494 FROM DUMMY UNION ALL
      SELECT 3241, 'Runtime error',     'Inserted value too large for column',               '%inserted value too large for column%',                 2380176 FROM DUMMY UNION ALL
      SELECT 3242, 'Runtime error',     'Exception while querying monitoring view',          '%Querying monitoring view failed with exception%',      1969700 FROM DUMMY UNION ALL
      SELECT 3243, 'Runtime error',     'No data found in context of L and calc engine',     '%Llang Runtime Error: %1299: no data found%',           2380176 FROM DUMMY UNION ALL
      SELECT 3300, 'Capture / replay',  'Timeout waiting for dependency',                    '%Unable to wait for the dependency%',                   2669621 FROM DUMMY UNION ALL
      SELECT 3310, 'Capture / replay',  'Deadlock detected during workload replay',          '%Detected possible deadlock with TC replay%',           2669621 FROM DUMMY UNION ALL
      SELECT 3400, 'Administration',    'Date interpretation of value not possible',         '%Could not evaluate date value%',                       2044468 FROM DUMMY UNION ALL
      SELECT 3405, 'Administration',    'No partition available for specific value',         '%Could not allocate value%no OTHERS part%',             2044468 FROM DUMMY UNION ALL
      SELECT 3410, 'Administration',    'Too low value in dynamic range partition',          '%is smaller than lower bound of new range%',            2044468 FROM DUMMY UNION ALL
      SELECT 3415, 'Administration',    'No dynamic range partitioning in place',            '%Table % is not dynamic range partitioned.%',           2044468 FROM DUMMY UNION ALL
      SELECT 3420, 'Administration',    'Lockdown because licensed memory is exceeded',      '%Lockdown as mem usage % higher than licensed%',        3499683 FROM DUMMY UNION ALL
      SELECT 3421, 'Administration',    'Invalid license',                                   '%invalid license%',                                     3499683 FROM DUMMY
    ) C
  WHERE
    CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    T.HOST LIKE BI.HOST AND
    TO_VARCHAR(T.PORT) LIKE BI.PORT AND
    T.SERVICE_NAME LIKE BI.SERVICE_NAME AND
    C.AREA LIKE BI.CHECK_AREA AND
    T.TRACE_TEXT LIKE C.TRACE_TEXT AND
    T.TRACE_TEXT NOT LIKE '%SQL: "HANA_SQL_StatementHash_DataCollector"%' AND
    T.TRACE_TEXT NOT LIKE '%$failure_type$=CANCEL_FLAG%'
  GROUP BY
    C.CHECK_ID,
    C.AREA,
    C.DESCRIPTION,
    C.SAP_NOTE,
    T.HOST,
    T.PORT
  UNION ALL
  SELECT
    8000 + D.LINE_NO,
    'User limits',
    D.ISSUE,
    D.HOST,
    -1,
    1,
    TO_VARCHAR(D.TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS'),
    2600030,
    D.DETAILS
  FROM
    BASIS_INFO BI,
  ( SELECT
      I.LINE_NO,
      L.TIMESTAMP,
      L.HOST,
      L.PARAMETER,
      L.SOFT,
      L.HARD,
      CASE WHEN I.TYPE = 'SOFT' AND L.SOFT < I.MIN THEN I.NAME || CHAR(32) || 'soft limit (' || I.PARAMETER || ') too low'
           WHEN I.TYPE = 'SOFT' AND L.SOFT > I.MAX THEN I.NAME || CHAR(32) || 'soft limit (' || I.PARAMETER || ') too high'
           WHEN I.TYPE = 'HARD' AND L.HARD < I.MIN THEN I.NAME || CHAR(32) || 'hard limit (' || I.PARAMETER || ') too low'
           WHEN I.TYPE = 'HARD' AND L.HARD > I.MAX THEN I.NAME || CHAR(32) || 'hard limit (' || I.PARAMETER || ') too high'
           ELSE ''
      END ISSUE,
      CASE WHEN I.TYPE = 'SOFT' AND L.SOFT < I.MIN THEN L.SOFT || ' (configured) <' || CHAR(32) || MAP(I.MIN, 999999999999, 'unlimited', TO_VARCHAR(I.MIN)) || ' (min. recommended)'
           WHEN I.TYPE = 'SOFT' AND L.SOFT > I.MAX THEN L.SOFT || ' (configured) >' || CHAR(32) || MAP(I.MAX, 999999999999, 'unlimited', TO_VARCHAR(I.MAX)) || ' (max. recommended)'
           WHEN I.TYPE = 'HARD' AND L.HARD < I.MIN THEN L.HARD || ' (configured) <' || CHAR(32) || MAP(I.MIN, 999999999999, 'unlimited', TO_VARCHAR(I.MIN)) || ' (min. recommended)'
           WHEN I.TYPE = 'HARD' AND L.HARD > I.MAX THEN L.HARD || ' (configured) >' || CHAR(32) || MAP(I.MAX, 999999999999, 'unlimited', TO_VARCHAR(I.MAX)) || ' (max. recommended)'
           ELSE ''
      END DETAILS
    FROM
    ( SELECT  1 LINE_NO, 'Address space' NAME, 'as' PARAMETER, 'SOFT' TYPE, 999999999999 MIN, 999999999999 MAX FROM DUMMY UNION ALL
      SELECT  2 LINE_NO, 'Address space',      'as',           'HARD',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT  3 LINE_NO, 'Core file',          'core',         'SOFT',      0,                999999999999     FROM DUMMY UNION ALL
      SELECT  4 LINE_NO, 'Core file',          'core',         'HARD',      0,                999999999999     FROM DUMMY UNION ALL
      SELECT  5 LINE_NO, 'CPU',                'cpu',          'SOFT',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT  6 LINE_NO, 'CPU',                'cpu',          'HARD',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT  7 LINE_NO, 'Data',               'data',         'SOFT',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT  8 LINE_NO, 'Data',               'data',         'HARD',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT  9 LINE_NO, 'File size',          'fsize',        'SOFT',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT 10 LINE_NO, 'File size',          'fsize',        'HARD',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT 11 LINE_NO, 'Memory lock',        'memlock',      'SOFT',      65536,            999999999999     FROM DUMMY UNION ALL
      SELECT 12 LINE_NO, 'Memory lock',        'memlock',      'HARD',      65536,            999999999999     FROM DUMMY UNION ALL
      SELECT 13 LINE_NO, 'Open files',         'nofile',       'SOFT',      100000,           999999999999     FROM DUMMY UNION ALL
      SELECT 14 LINE_NO, 'Open files',         'nofile',       'HARD',      100000,           999999999999     FROM DUMMY UNION ALL
      SELECT 15 LINE_NO, 'Processes',          'nproc',        'SOFT',      1000000,          999999999999     FROM DUMMY UNION ALL
      SELECT 16 LINE_NO, 'Processes',          'nproc',        'HARD',      1000000,          999999999999     FROM DUMMY UNION ALL
      SELECT 17 LINE_NO, 'Resident size',      'rss',          'SOFT',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT 18 LINE_NO, 'Resident size',      'rss',          'HARD',      999999999999,     999999999999     FROM DUMMY UNION ALL
      SELECT 19 LINE_NO, 'Stack',              'stack',        'SOFT',      8388608,          67108864         FROM DUMMY UNION ALL
      SELECT 20 LINE_NO, 'Stack',              'stack',        'HARD',      8388608,          999999999999     FROM DUMMY
    ) I,
    ( SELECT
        TIMESTAMP,
        HOST,
        ROW_NUMBER () OVER (PARTITION BY HOST, SUBSTR(TRACE_TEXT, PARAM_START, PARAM_END - PARAM_START + 1) ORDER BY TIMESTAMP DESC) ROWNO,
        TRACE_TEXT,
        SUBSTR(TRACE_TEXT, PARAM_START, PARAM_END - PARAM_START + 1) PARAMETER,
        MAP(SUBSTR(TRACE_TEXT, SOFT_START, SOFT_END - SOFT_START + 1), 'unlimited', 999999999999, TO_NUMBER(SUBSTR(TRACE_TEXT, SOFT_START, SOFT_END - SOFT_START + 1))) SOFT,
        MAP(SUBSTR(TRACE_TEXT, HARD_START, HARD_END - HARD_START + 1), 'unlimited', 999999999999, TO_NUMBER(SUBSTR(TRACE_TEXT, HARD_START, HARD_END - HARD_START + 1))) HARD
      FROM
      ( SELECT
          TIMESTAMP,
          HOST,
          TO_VARCHAR(SUBSTR(TRACE_TEXT, 1, 5000)) TRACE_TEXT,
          LOCATE(TRACE_TEXT, '(', 1, 1) + 1 PARAM_START,
          LOCATE(TRACE_TEXT, ')', 1, 1) - 1 PARAM_END,
          LOCATE(TRACE_TEXT, CHAR(32), -1, 1) + 1 SOFT_START,
          LOCATE(TRACE_TEXT, '/', -1, 1) - 1 SOFT_END,
          LOCATE(TRACE_TEXT, '/', -1, 1) + 1 HARD_START,
          LENGTH(TRACE_TEXT) HARD_END
        FROM
          M_MERGED_TRACES
        WHERE
          SERVICE_NAME = 'daemon' AND
          SOURCE_FILE_NAME IN ( 'DaemonReconfigure.cpp', 'TrexDaemon.cpp' ) AND
          TRACE_TEXT LIKE '%urrent soft/hard limit%'
      )
    ) L
    WHERE
      I.PARAMETER = L.PARAMETER AND
      ROWNO = 1
    ORDER BY
      PARAMETER
  ) D
  WHERE
    'User limits' LIKE BI.CHECK_AREA AND
    D.ISSUE != ''
  UNION ALL
  SELECT
    9000 CHECK_ID,
    'General' AREA,
    'Max. trace lines per hour' DESCRIPTION,
    D.HOST,
    D.PORT,
    TO_DECIMAL(D.MAX_COUNT, 10, 0) COUNT,
    D.HOUR LAST_OCCURRENCE,
    2380176 SAP_NOTE,
    '' DETAILS
  FROM
    BASIS_INFO BI,
  ( SELECT
      HOST,
      PORT,
      MAX(COUNT) MAX_COUNT,
      ( SELECT MAX(HOUR) FROM TRACE_FILE_ENTRIES_PER_HOUR T2 WHERE T1.HOST = T2.HOST AND T1.PORT = T2.PORT AND MAX(T1.COUNT) = T2.COUNT ) HOUR
    FROM
      TRACE_FILE_ENTRIES_PER_HOUR T1
    GROUP BY
      HOST,
      PORT
  ) D
  WHERE
    'General' LIKE BI.CHECK_AREA AND
    D.MAX_COUNT > 2000
  UNION ALL
  SELECT
    9010 CHECK_ID,
    'General' AREA,
    'Avg. trace lines per hour' DESCRIPTION,
    D.HOST,
    D.PORT,
    TO_DECIMAL(ROUND(AVG(D.COUNT)), 10, 0) COUNT,
    '' LAST_OCCURRENCE,
    2380176 SAP_NOTE,
    '' DETAILS
  FROM
    BASIS_INFO BI,
    TRACE_FILE_ENTRIES_PER_HOUR D
  WHERE
    'General' LIKE BI.CHECK_AREA
  GROUP BY
    D.HOST,
    D.PORT
  HAVING
    AVG(D.COUNT) > 400
) T
WHERE
  COUNT IS NOT NULL
ORDER BY
  T.CHECK_ID,
  T.HOST,
  T.PORT
WITH HINT (IGNORE_PLAN_CACHE)