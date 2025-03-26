WITH 

/*

[NAME]

- HANA_TraceFiles_Content

[DESCRIPTION]

- Trace file contents

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Only the service trace files are covered (no alert files, OOM or RTE dumps)
- Per default only 10 * 10 MB of traces are retained per service, there is no guaranteed retention, so in some cases traces are overwritten rather early
- Runtime and memory consumption can be significant in case of many and large trace files (bug 248022), so try to limit the selection as much as possible
  (e.g. with proper BEGIN_TIME / END_TIME specification), make sure that statement_memory_limit is properly set to rule out system instabilities in
  case of high memory consumption, improvements are expected with SAP HANA 2.0 SPS 06)

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2014/04/22:  1.0 (initial version)
- 2014/05/06:  1.1 (TRACE_TEXT filter included)
- 2014/10/06:  1.2 (predefined list of error texts included)
- 2016/06/18:  1.3 (AGGREGATE_BY and TIME_AGGREGATE_BY included)
- 2016/10/20:  1.4 (COMPONENT_EXCLUSION_LIST inc0luded)
- 2016/12/31:  1.5 (TIME_AGGREGATE_BY = 'TS<seconds>' included)
- 2017/01/06:  1.6 (SUBSTRING_TRACE_TEXT included)
- 2017/10/27:  1.7 (TIMEZONE included)
- 2018/01/09:  1.8 (CONN_ID added)
- 2018/05/15:  1.9 (TRACE_TEXT_LENGTH and SUBSTRING_TRACE_TEXT_LENGTH added)
- 2018/12/04:  2.0 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/03/19:  2.1 (THREAD_ID, EXCLUDE_INTERNAL_CONNECTIONS and sorting by CONN_ID / THREAD_ID included)
- 2019/04/02:  2.2 (ONLY_STARTUP_PHASES included)
- 2019/06/24:  2.3 (EXCLUDE_STANDARD_MESSAGES included)
- 2019/10/13:  2.4 (TRACE_LEVEL refined, interface and interfacefull included)
- 2020/10/15:  2.5 (improved memory consumption and runtime by eliminating '%' || <trace_text> || '%' concatenations)
- 2021/01/05:  2.6 (SOURCE_FILE_LINE included)
- 2022/04/07:  2.7 (STATEMENT_HASH, DB_USER, APP_USER, APP_SOURCE, APP_NAME, PASSPORT_COMPONENT and PASSPORT_ACTION included)
- 2022/06/24:  2.8 (UTID included)
- 2023/10/26:  2.9 (AVG_LEN_KB and SUM_LEN_MB included)

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

- CONN_ID

  Connection ID

  330655          --> Connection ID 330655
  -1              --> No connection ID restriction

- THREAD_ID

  Thread identifier

  4567            --> Thread 4567
  -1              --> No thread identifier restriction

- STATEMENT_HASH      
 
  SQL statement hash

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction

- DB_USER

  Database user

  'SYSTEM'        --> Database user 'SYSTEM'
  '%'             --> No database user restriction

- APP_NAME

  Name of application

  'ABAP:C11'      --> Application name 'ABAP:C11'
  '%'             --> No application name restriction

- APP_USER

  Application user

  'SAPSYS'        --> Application user 'SAPSYS'
  '%'             --> No application user restriction

- APP_SOURCE

  Application source

  'SAPL2:437'     --> Application source 'SAPL2:437'
  'SAPMSSY2%'     --> Application sources starting with SAPMSSY2
  '%'             --> No application source restriction

- PASSPORT_COMPONENT

  Passport component

  'P24/sapabap01_P24_27' --> Passport component P24/sapabap01_P24_27
  '%'                    --> No restriction related to passport component

- PASSPORT_ACTION

  Passport action

  'SAPMSSY1'      --> Passport action SAPMSSY1
  '%'             --> No restriction related to passport action 

- UTID

  Update transaction identifier (used for DML operations)

  123456          --> Update transaction identifier 123456
  -1              --> No restriction to specific update transaction identifier

- TRACE_TEXT

  Trace text

  'UserName='     --> All trace enties with text UserName=
  'TrexUpdate%'   --> All trace entries starting with 'TrexUpdate'
  '%'             --> No trace text restriction

- TRACE_TEXT_LENGTH

  Length of trace text column

  50              --> Truncate trace text after 50 characters
  -1              --> No truncation of trace text

- SUBSTRING_TRACE_TEXT

  Substring trace text (i.e. text to be used as starting point for SUBSTRING_TRACE_TEXT output column)

  'UserName='     --> All trace enties with text UserName=
  'TrexUpdate'    --> All trace entries starting with 'TrexUpdate'
  ''              --> No trace text restriction

- SUBSTRING_TRACE_TEXT_LENGTH

  Length of substring trace text column

  50              --> Truncate substring trace text after 50 characters
  -1              --> No truncation of substring trace text

- COMPONENT

  Component responsible for trace entry

  Be aware that the length of the COMPONENT column is defined with a maximum length of 16, so you may have to truncate longer components (e.g. 'PersistenceManager' -> 'PersistenceManag')

  'BASIS'         --> Trace entries related to BASIS
  '%'             --> No trace entry restriction

- TRACE_FILE_NAME

  Trace file name

  'alert.trc'     --> File with name alert.trc
  'indexserver%'  --> File with name starting with 'indexserver'
  '%'             --> All files

- SOURCE_FILE_NAME

  Source file issuing the trace record

  'AllocatorImpl.cpp' --> Entries related to source file AllocatorImpl.cpp
  '%stat%'            --> Entries related to source files containing 'stat'
  '%'                 --> No restriction related to source file

- SOURCE_FILE_LINE

  Line number in source file

  123             --> Only display messages originating from line 123 of a source file
  -1              --> No restriction related to source file line

- EXCLUDE_STANDARD_MESSAGES

  Possibility to exclude frequent standard messages (e.g. related to savepoints, system replication, trace context or daemon calls) from the output

  'X'             --> Only display lines that are not classified as frequent standard message
  ' '             --> Display all lines

- ONLY_STARTUP_PHASES

  Possibility to restrict output to lines that belong to important SAP HANA startup phases

  'X'             --> Only display lines that belong to important SAP HANA startup phases
  ' '             --> No restriction in terms of SAP HANA startup phase

- COMPONENT_EXCLUSION_LIST

  Possibility to exclude certain components from output

  'TraceContext'  --> Exclude entries related to TraceContext component from output
  'Logger,Resman' --> Exclude entries related to Logger and Resman from output
  ''              --> No exclusion of components

- EXCLUDE_INTERNAL_CONNECTIONS

  Possibility to exclude trace entries related to internal activities (CONN_ID = -1)

  'X'             --> Only display trace entries related to external transactions
  ' '             --> No restriction related to connections

- SAP_NOTE

  Possibility to restrict output to lines related to a specific SAP Note (configured in ERROR_SECTION of this SQL command)

  '2075771'       --> Only show errors related to SAP Note 2075771
  '%'             --> No restriction related to SAP Note

- MIN_TRACE_LEVEL

  Minimum trace level

  'INFO'          --> Display everything
  'WARNING'       --> Display warnings and errors
  'ERROR'         --> Display errors

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

  'COUNT'         --> Sorting by number of trace file entries
  'TIME'          --> Sorting by time of trace entry

[OUTPUT PARAMETERS]

- TRACE_TIME:           Trace timestamp
- HOST:                 Host name
- PORT:                 Port
- SERVICE:              Service name
- CONN_ID:              Connection ID
- THREAD_ID:            Thread ID
- CNT:                  Number of related trace file entries
- AVG_LEN_KB:           Average length of trace file entries (KB)
- SUM_LEN_KB:           Total length of trace file entries (MB)
- L:                    Trace level ('F' -> fatal, 'E' -> error, 'W' -> warning, 'I' -> info, 'a' -> interface, 'd' -> debug, 'A' -> interfacefull, 'D' -> fulldebug)
- COMPONENT:            Trace component
- SOURCE_FILE:          Name of source file
- SRC_LINE:             Line in source file
- TRACE_FILE_NAME:      Trace file name
- TRACE_TEXT:           Trace text
- STATEMENT_HASH:       Statement hash
- DB_USER:              Database user
- APP_USER:             Application user
- APP_SOURCE:           Application source
- APP_NAME:             Application name
- PASSPORT_ACTION:      Passport action
- PASSPORT_COMPONENT:   Passport component
- UTID:                 Update transaction ID
- SUBSTRING_TRACE_TEXT: Trace text starting at first occurrence of specified substring

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
|TRACE_TIME         |HOST     |   PORT|L|COMPONENT    |TRACE_FILE_NAME                         |TRACE_TEXT
|SOURCE_FILE                  |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
|2014/04/22 10:58:48|saphana21|30.105 |I|Logger       |statisticsserver_saphana21.30105.004.trc|Snapshot 59527->59528, snapsp=59527
|SavepointImpl.cpp (2410)     |
|2014/04/22 11:00:43|saphana20|30.103 |E|Row_Engine   |indexserver_saphana20.30103.595.trc     |Error: no transaction availabe yet for measuring BW schemas (at ptime/common/monitor/LicenseMonitor.cc:316 )
|msglog.cc (82)               |
|2014/04/22 11:00:43|saphana20|30.103 |E|SrvInternal  |indexserver_saphana20.30103.595.trc     |caught ltt exception in method __INT__LICENSE_MEASUREMENT: exception  1: no.71000002  (ptime/common/monitor/LicenseMonitor.cc:317)
    Error: no transaction availabe yet for measuring BW schemas
NO exception throw location recorded. Stack generation supp   |TrexService.cpp (1444)       |
|2014/04/22 11:02:20|saphana21|30.101 |W|sr_nameserver|nameserver_saphana21.30101.064.trc      |inifile mismatch for site 2: global.ini/SYSTEM/[auditing configuration]/default_audit_trail_path = /usr/sap/HP1/HDB01/saphana20/trace
|WatchDog.cpp (692)           |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

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
    HOST,
    PORT,
    SERVICE_NAME,
    CONN_ID,
    THREAD_ID,
    STATEMENT_HASH,
    DB_USER,
    APP_USER,
    APP_SOURCE,
    APP_NAME,
    PASSPORT_ACTION,
    PASSPORT_COMPONENT,
    UTID,
    TRACE_TEXT,
    TRACE_TEXT_LENGTH,
    SUBSTRING_TRACE_TEXT,
    SUBSTRING_TRACE_TEXT_LENGTH,
    COMPONENT,
    TRACE_FILE_NAME,
    SOURCE_FILE_NAME,
    SOURCE_FILE_LINE,
    EXCLUDE_STANDARD_MESSAGES,
    ONLY_STARTUP_PHASES,
    COMPONENT_EXCLUSION_LIST,
    EXCLUDE_INTERNAL_CONNECTIONS,
    SAP_NOTE,
    MIN_TRACE_LEVEL,
    AGGREGATE_BY,
    MAP(TIME_AGGREGATE_BY,
      'NONE',        'YYYY/MM/DD HH24:MI:SS.FF7',
      'HOUR',        'YYYY/MM/DD HH24',
      'DAY',         'YYYY/MM/DD (DY)',
      'HOUR_OF_DAY', 'HH24',
      TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
    ORDER_BY
  FROM
  ( SELECT                            /* Modification section */
      'C-H1' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      'C' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' HOST,
      '%' PORT,
      '%' SERVICE_NAME,
      -1 CONN_ID,
      -1 THREAD_ID,
      '%' STATEMENT_HASH,
      '%' DB_USER,
      '%' APP_USER,
      '%' APP_SOURCE,
      '%' APP_NAME,
      '%' PASSPORT_ACTION,
      '%' PASSPORT_COMPONENT,
      -1 UTID,
      '%' TRACE_TEXT,
      4000 TRACE_TEXT_LENGTH,
      'OBJECT_NAME' SUBSTRING_TRACE_TEXT,
      90 SUBSTRING_TRACE_TEXT_LENGTH,
      '%' COMPONENT,                      /* e.g. BASIS, MEMORY */
      '%' TRACE_FILE_NAME,
      '%' SOURCE_FILE_NAME,
      -1 SOURCE_FILE_LINE,
      'X' EXCLUDE_STANDARD_MESSAGES,
      ' ' ONLY_STARTUP_PHASES,
      '' COMPONENT_EXCLUSION_LIST,
      ' ' EXCLUDE_INTERNAL_CONNECTIONS,
       -1  SAP_NOTE,
      'INFO' MIN_TRACE_LEVEL,             /* INFO, WARNING, ERROR */
      'NONE' AGGREGATE_BY,                /* TIME, HOST, PORT, SERVICE, CONN_ID, THREAD_ID, HASH, DB_USER, APP_USER, APP_SOURCE, APP_NAME, PASSPORT_COMP, PASSPORT_ACTION, UTID,
                                             LEVEL, COMPONENT, FILE, NOTE, TEXT, SOURCE or comma separated combinations, NONE for no aggregation */
      'NONE' TIME_AGGREGATE_BY,           /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
      'TIME' ORDER_BY                     /* TIME, FILE, COUNT, CONN_ID, THREAD_ID, AVG_LEN, SUM_LEN */
    FROM
      DUMMY
  )
),
MERGED_TRACES AS
( SELECT
    M.*
  FROM
    BASIS_INFO BI,
    M_MERGED_TRACES M
  WHERE
    CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(M.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE M.TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    M.HOST LIKE BI.HOST AND
    TO_VARCHAR(M.PORT) LIKE BI.PORT AND
    M.SERVICE_NAME LIKE BI.SERVICE_NAME AND
    ( BI.CONN_ID = -1 OR M.CONNECTION_ID = BI.CONN_ID ) AND
    ( BI.THREAD_ID = -1 OR M.THREAD_ID = BI.THREAD_ID ) AND
    M.USER_NAME LIKE BI.DB_USER AND
    M.APPLICATION_USER_NAME LIKE BI.APP_USER AND
    M.APPLICATION_SOURCE LIKE BI.APP_SOURCE AND
    M.APPLICATION_NAME LIKE BI.APP_NAME AND
    M.PASSPORT_COMPONENT_NAME LIKE BI.PASSPORT_COMPONENT AND
    M.PASSPORT_ACTION LIKE BI.PASSPORT_ACTION AND
    ( BI.UTID = -1 OR M.UPDATE_TRANSACTION_ID = BI.UTID ) AND
    UPPER(TO_VARCHAR(M.TRACE_TEXT)) LIKE UPPER(BI.TRACE_TEXT) AND
    LENGTH(M.TRACE_TEXT) >= 1 AND
    UPPER(M.COMPONENT) LIKE UPPER(BI.COMPONENT) AND
    UPPER(M.TRACE_FILE_NAME) LIKE UPPER(BI.TRACE_FILE_NAME) AND
    ( BI.COMPONENT_EXCLUSION_LIST = '' OR LOCATE(UPPER(BI.COMPONENT_EXCLUSION_LIST), UPPER(M.COMPONENT)) = 0 ) AND
    UPPER(M.SOURCE_FILE_NAME) LIKE UPPER(BI.SOURCE_FILE_NAME) AND
    ( BI.SOURCE_FILE_LINE = -1 OR BI.SOURCE_FILE_LINE = M.SOURCE_FILE_LINE ) AND
    ( BI.MIN_TRACE_LEVEL = 'INFO' OR
      BI.MIN_TRACE_LEVEL = 'WARNING' AND SUBSTR(M.TRACE_LEVEL, 1, 1) IN ('W', 'E') OR
      BI.MIN_TRACE_LEVEL = 'ERROR' AND SUBSTR(M.TRACE_LEVEL, 1, 1) = 'E'
    ) AND
    ( BI.EXCLUDE_STANDARD_MESSAGES = ' ' OR 
      ( M.TRACE_TEXT NOT LIKE '~BackupExe_BackintHandlerImpl: %backint terminat%' AND
        M.TRACE_TEXT NOT LIKE 'Backint % requested by process%' AND
        M.TRACE_TEXT NOT LIKE 'Backint process % is alive' AND
        M.TRACE_TEXT NOT LIKE 'Backint process % not found in process list!' AND
        M.TRACE_TEXT NOT LIKE 'BackupChannel: create backup%' AND
        M.TRACE_TEXT NOT LIKE 'BackupDest_Destination::cleanup -> done' AND
        M.TRACE_TEXT NOT LIKE 'Backup executable image % is link to%' AND
        M.TRACE_TEXT NOT LIKE 'backup source % will not be encrypted' AND
        M.TRACE_TEXT NOT LIKE 'cancel requested:, globalSessionId=%' AND
        M.TRACE_TEXT NOT LIKE 'Changing environment %set%' AND
        M.TRACE_TEXT NOT LIKE 'Child process deletes daemon port' AND
        M.TRACE_TEXT NOT LIKE 'Child process %exited%' AND
        M.TRACE_TEXT NOT LIKE 'Clearing backup Snapshot Restart page number from the Anchor page' AND
        M.TRACE_TEXT NOT LIKE 'Closing connection%channel%' AND
        M.TRACE_TEXT NOT LIKE 'Connection from%' AND
        M.TRACE_TEXT NOT LIKE 'Create snapshot for replication%' AND
        M.TRACE_TEXT NOT LIKE '%[DBT] received%' AND
        M.TRACE_TEXT NOT LIKE 'Daemon client network connection unprotected%' AND
        M.TRACE_TEXT NOT LIKE 'Daemon state "running", runlevels%' AND
        M.TRACE_TEXT NOT LIKE 'DataVolumeTouchPagesJob: ____ step%' AND
        M.TRACE_TEXT NOT LIKE 'Deleting pipe%' AND
        M.TRACE_TEXT NOT LIKE 'Delta Replica:%' AND
        M.TRACE_TEXT NOT LIKE 'Finishing connection channel%' AND
        M.TRACE_TEXT NOT LIKE 'Instance count%' AND
        M.TRACE_TEXT NOT LIKE 'Leaving wait state with return code%' AND
        M.TRACE_TEXT NOT LIKE 'LogSegment::markFree LogSegment%' AND
        M.TRACE_TEXT NOT LIKE 'Message "%' AND
        M.TRACE_TEXT NOT LIKE 'New connection accepted%' AND
        M.TRACE_TEXT NOT LIKE 'Process %, pid % is alive' AND
        M.TRACE_TEXT NOT LIKE 'Process % exited normally with status 0' AND
        M.TRACE_TEXT NOT LIKE 'Replication Snapshot dropped%' AND
        M.TRACE_TEXT NOT LIKE ':::: BACKUP % ::::' AND
        M.TRACE_TEXT NOT LIKE ':::: SAVE % ::::' AND
        M.TRACE_TEXT NOT LIKE 'Savepoint current savepoint version:%' AND
        M.TRACE_TEXT NOT LIKE 'session control command is performed by %ALTER SYSTEM CANCEL SESSION%' AND
        M.TRACE_TEXT NOT LIKE 'Shared memory updated, no daemon state change' AND
        M.TRACE_TEXT NOT LIKE 'SNAPSHOT finished successfully' AND
        M.TRACE_TEXT NOT LIKE 'SNAPSHOT started' AND
        M.TRACE_TEXT NOT LIKE 'Snapshot current savepoint version:%' AND
        M.TRACE_TEXT NOT LIKE 'Starting data transfer with source size%' AND
        M.TRACE_TEXT NOT LIKE 'Starting serial %backup in % chunks%' AND
        M.TRACE_TEXT NOT LIKE '%Stop listening for connections on%' AND
        M.TRACE_TEXT NOT LIKE 'The executable % is symlink to %' AND
        M.TRACE_TEXT NOT LIKE 'Timeouts for%' AND
        M.TRACE_TEXT NOT LIKE 'Transfer to secondary statistics%' AND
        M.TRACE_TEXT NOT LIKE 'UserName=%' AND
        M.TRACE_TEXT NOT LIKE 'Wait for backint%' AND
        M.COMPONENT != 'TraceContext' AND
        M.SOURCE_FILE_NAME != 'RequestStatistics.cpp' AND
        M.PORT != 0
      )
    ) AND
    ( BI.EXCLUDE_INTERNAL_CONNECTIONS = ' ' OR M.CONNECTION_ID != -1 ) AND
    ( BI.ONLY_STARTUP_PHASES = ' ' OR
      M.PORT != 0 AND
      ( M.TRACE_TEXT LIKE '%All Index rebuilding time%' OR
        M.TRACE_TEXT LIKE 'allocate % segments requested to load and collect information about superblocks to read%' OR
        M.TRACE_TEXT LIKE '%assign to volume % finished' OR
        M.TRACE_TEXT LIKE '%Checking rowstore consistency%' OR
        M.TRACE_TEXT LIKE 'collecting information done in%' OR
        M.TRACE_TEXT LIKE '%Consistency check time:%' OR
        M.TRACE_TEXT LIKE '%ContainerNameDirectory loaded%' OR
        M.TRACE_TEXT LIKE '%file ID mappings finished in %' OR
        M.TRACE_TEXT LIKE '%Finished table reloading%' OR
        M.TRACE_TEXT LIKE '%Garbage collection of history files%' OR
        M.TRACE_TEXT LIKE '%Initialize LOB owner statistics from%' OR
        M.TRACE_TEXT LIKE '%Initialize% transient structures%' OR
        M.TRACE_TEXT LIKE '%Initialize VirtualFile statistics%' OR
        M.TRACE_TEXT LIKE '%Load ContainerNameDirectory%' OR
        M.TRACE_TEXT LIKE '%Loading % open session(s) and % history cleanup file(s) finished%' OR
        M.TRACE_TEXT LIKE '%Loading RowStore segments from Persistency%' OR
        M.TRACE_TEXT LIKE '%LOB owner statistics initialized from VirtualFile%' OR
        M.TRACE_TEXT LIKE '%Now reloading % tables (loading up to % tables in parallel)%' OR
        M.TRACE_TEXT LIKE '%PersistenceManager::setState(InRestart)%' OR
        M.TRACE_TEXT LIKE '%Pre-/Re-Loading of column store tables finished%' OR
        M.TRACE_TEXT LIKE 'Process % exited normally with status 0' OR
        M.TRACE_TEXT LIKE '%Reattaching RS shared memory%' OR
        M.TRACE_TEXT LIKE 'Replayed % of log in % seconds% max known TID=%' OR
        M.TRACE_TEXT LIKE '%RS segments loaded from Persistency%' OR
        M.TRACE_TEXT LIKE '%RS segments loaded in % reuse ratio:%' OR
        M.TRACE_TEXT LIKE '%RS uncommitted version construction finished%' OR
        M.TRACE_TEXT LIKE '%start rsutil: --start  --port%' OR
        M.TRACE_TEXT LIKE '%hdbrsutil seems to be hanging%' OR
        M.TRACE_TEXT LIKE '%==== Starting hdb%' OR
        M.TRACE_TEXT LIKE '%Starting reloading column store tables based on previous load information%' OR
        M.TRACE_TEXT LIKE '%Start loading open sessions and history cleanup files%' OR
        M.TRACE_TEXT LIKE '%Termination of indoubt transactions%' OR
        M.TRACE_TEXT LIKE '%Termination of rollback(s) open in restart/backup savepoint%' OR
        M.TRACE_TEXT LIKE '%Triggering log recovery up to position%' OR
        M.TRACE_TEXT LIKE '%VirtualFile statistics initialized%'
      )
    )
),
TRACE_CONTEXTS AS
( SELECT
    TIMESTAMP,
    HOST,
    PORT,
    CONNECTION_ID,
    IFNULL(MAP(LOCATE(APP_NAME, ', '), 0, APP_NAME, SUBSTR(APP_NAME, 1, LOCATE(APP_NAME, ', ') - 1)), '') APP_NAME,
    IFNULL(MAP(LOCATE(APP_SOURCE, ', '), 0, APP_SOURCE, SUBSTR(APP_SOURCE, 1, LOCATE(APP_SOURCE, ', ') - 1)), '') APP_SOURCE,
    IFNULL(MAP(LOCATE(APP_USER, ', '), 0, APP_USER, SUBSTR(APP_USER, 1, LOCATE(APP_USER, ', ') - 1)), '') APP_USER,
    IFNULL(MAP(LOCATE(CLIENT, ', '), 0, CLIENT, SUBSTR(CLIENT, 1, LOCATE(CLIENT, ', ') - 1)), '') CLIENT,
    IFNULL(MAP(LOCATE(PASSPORT_ACTION, ', '), 0, PASSPORT_ACTION, SUBSTR(PASSPORT_ACTION, 1, LOCATE(PASSPORT_ACTION, ', ') - 1)), '') PASSPORT_ACTION,
    IFNULL(MAP(LOCATE(PASSPORT_COMPONENT_NAME, ', '), 0, PASSPORT_COMPONENT_NAME, SUBSTR(PASSPORT_COMPONENT_NAME, 1, LOCATE(PASSPORT_COMPONENT_NAME, ', ') - 1)), '') PASSPORT_COMPONENT_NAME,
    IFNULL(MAP(LOCATE(PASSPORT_CONNECTION_COUNTER, ', '), 0, PASSPORT_CONNECTION_COUNTER, SUBSTR(PASSPORT_CONNECTION_COUNTER, 1, LOCATE(PASSPORT_CONNECTION_COUNTER, ', ') - 1)), '') PASSPORT_CONNECTION_COUNTER,
    IFNULL(MAP(LOCATE(PASSPORT_CONNECTION_ID, ', '), 0, PASSPORT_CONNECTION_ID, SUBSTR(PASSPORT_CONNECTION_ID, 1, LOCATE(PASSPORT_CONNECTION_ID, ', ') - 1)), '') PASSPORT_CONNECTION_ID,
    IFNULL(MAP(LOCATE(PASSPORT_ROOT_CONTEXT_ID, ', '), 0, PASSPORT_ROOT_CONTEXT_ID, SUBSTR(PASSPORT_ROOT_CONTEXT_ID, 1, LOCATE(PASSPORT_ROOT_CONTEXT_ID, ', ') - 1)), '') PASSPORT_ROOT_CONTEXT_ID,
    IFNULL(MAP(LOCATE(PASSPORT_TRANSACTION_ID, ', '), 0, PASSPORT_TRANSACTION_ID, SUBSTR(PASSPORT_TRANSACTION_ID, 1, LOCATE(PASSPORT_TRANSACTION_ID, ', ') - 1)), '') PASSPORT_TRANSACTION_ID,
    IFNULL(MAP(LOCATE(STATEMENT_HASH, ', '), 0, STATEMENT_HASH, SUBSTR(STATEMENT_HASH, 1, LOCATE(STATEMENT_HASH, ', ') - 1)), '') STATEMENT_HASH,
    IFNULL(MAP(LOCATE(STAT_EXEC_ID, ', '), 0, STAT_EXEC_ID, SUBSTR(STAT_EXEC_ID, 1, LOCATE(STAT_EXEC_ID, ', ') - 1)), '') STAT_EXEC_ID,
    IFNULL(MAP(LOCATE(DB_USER, ', '), 0, DB_USER, SUBSTR(DB_USER, 1, LOCATE(DB_USER, ', ') - 1)), '') DB_USER
  FROM
  ( SELECT
      MAP(LOCATE(M.TRACE_TEXT, 'ApplicationName='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'ApplicationName=') + 16)) APP_NAME,
      MAP(LOCATE(M.TRACE_TEXT, 'ApplicationSource='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'ApplicationSource=') + 18)) APP_SOURCE,
      MAP(LOCATE(M.TRACE_TEXT, 'ApplicationUserName='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'ApplicationUserName=') + 20)) APP_USER,
      MAP(LOCATE(M.TRACE_TEXT, 'Client='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'Client=') + 7)) CLIENT,
      MAP(LOCATE(M.TRACE_TEXT, 'EppAction='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppAction=') + 10)) PASSPORT_ACTION,
      MAP(LOCATE(M.TRACE_TEXT, 'EppComponentName='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppComponentName=') + 17)) PASSPORT_COMPONENT_NAME,
      MAP(LOCATE(M.TRACE_TEXT, 'EppConnectionCounter='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppConnectionCounter=') + 21)) PASSPORT_CONNECTION_COUNTER,
      MAP(LOCATE(M.TRACE_TEXT, 'EppConnectionID='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppConnectionId=') + 16)) PASSPORT_CONNECTION_ID,
      MAP(LOCATE(M.TRACE_TEXT, 'EppRootContextId='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppRootContextId=') + 17)) PASSPORT_ROOT_CONTEXT_ID,
      MAP(LOCATE(M.TRACE_TEXT, 'EppTransactionId='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'EppTransactionId=') + 17)) PASSPORT_TRANSACTION_ID,
      MAP(LOCATE(M.TRACE_TEXT, 'StatementHash='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'StatementHash=') + 14)) STATEMENT_HASH,
      MAP(LOCATE(M.TRACE_TEXT, 'StatementExecutionID='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'StatementExecutionID=') + 21)) STAT_EXEC_ID,
      MAP(LOCATE(M.TRACE_TEXT, 'UserName='), 0, '', SUBSTR(M.TRACE_TEXT, LOCATE(M.TRACE_TEXT, 'UserName=') + 9)) DB_USER,
      M.TIMESTAMP,
      M.TRACE_TEXT,
      M.HOST,
      M.PORT,
      M.CONNECTION_ID
    FROM
      BASIS_INFO BI,
      M_MERGED_TRACES M
    WHERE
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(M.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE M.TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
      M.COMPONENT = 'TraceContext' AND
      M.SOURCE_FILE_NAME = 'TraceContext.cpp'
  )
),
MERGED_TRACES_ENRICHED AS
( SELECT
    M.HOST,
    M.PORT,
    MAP(M.USER_NAME, '', T.DB_USER, M.USER_NAME) USER_NAME,
    MAP(M.APPLICATION_USER_NAME, '', T.APP_USER, M.APPLICATION_USER_NAME) APPLICATION_USER_NAME,
    M.SERVICE_NAME,
    M.CONNECTION_ID,
    M.TRANSACTION_ID,
    M.UPDATE_TRANSACTION_ID,
    M.STATEMENT_ID,
    M.THREAD_ID,
    M.TIMESTAMP,
    M.TRACE_LEVEL,
    M.COMPONENT,
    M.SOURCE_FILE_NAME,
    M.SOURCE_FILE_LINE,
    M.TRACE_TEXT,
    M.TRACE_FILE_NAME,
    M.TRACE_FILE_LINE,
    MAP(M.APPLICATION_NAME, '', T.APP_NAME, M.APPLICATION_NAME) APPLICATION_NAME,
    MAP(M.APPLICATION_SOURCE, '', T.APP_SOURCE, M.APPLICATION_SOURCE) APPLICATION_SOURCE,
    MAP(M.PASSPORT_ROOT_CONTEXT_ID, '', T.PASSPORT_ROOT_CONTEXT_ID, M.PASSPORT_ROOT_CONTEXT_ID) PASSPORT_ROOT_CONTEXT_ID,
    MAP(M.PASSPORT_TRANSACTION_ID, '', T.PASSPORT_TRANSACTION_ID, M.PASSPORT_TRANSACTION_ID) PASSPORT_TRANSACTION_ID,
    MAP(M.PASSPORT_CONNECTION_ID, '', T.PASSPORT_CONNECTION_ID, M.PASSPORT_CONNECTION_ID) PASSPORT_CONNECTION_ID,
    MAP(M.PASSPORT_COMPONENT_NAME, '', T.PASSPORT_COMPONENT_NAME, M.PASSPORT_COMPONENT_NAME) PASSPORT_COMPONENT_NAME,
    MAP(M.PASSPORT_ACTION, '', T.PASSPORT_ACTION, M.PASSPORT_ACTION) PASSPORT_ACTION,
    M.TC_TIMESTAMP,
    T.STATEMENT_HASH
  FROM
    BASIS_INFO BI,
  ( SELECT
      M.*,
      ( SELECT MAX(T.TIMESTAMP) FROM TRACE_CONTEXTS T WHERE T.HOST = M.HOST AND T.PORT = M.PORT AND T.CONNECTION_ID = M.CONNECTION_ID AND M.CONNECTION_ID != -1 AND T.TIMESTAMP <= ADD_SECONDS(M.TIMESTAMP, 0.010)) TC_TIMESTAMP
    FROM
      MERGED_TRACES M
  ) M LEFT OUTER JOIN
    TRACE_CONTEXTS T ON
      T.HOST = M.HOST AND
      T.PORT = M.PORT AND
      T.CONNECTION_ID = M.CONNECTION_ID AND
      T.TIMESTAMP = TC_TIMESTAMP
  WHERE
    IFNULL(T.STATEMENT_HASH, '') LIKE BI.STATEMENT_HASH
)
SELECT
  BEGIN_TIME TRACE_TIME,
  HOST,
  LPAD(PORT, 5) PORT,
  SERVICE_NAME SERVICE,
  LPAD(CONN_ID, 7) CONN_ID,
  LPAD(THREAD_ID, 9) THREAD_ID,
  LPAD(MAX(COUNT), 7) CNT,
  LPAD(TO_DECIMAL(AVG_LEN_KB, 10, 2), 10) AVG_LEN_KB,
  LPAD(TO_DECIMAL(AVG_LEN_KB * MAX(COUNT) / 1024, 10, 2), 10) SUM_LEN_MB,
  MAP(TRACE_LEVEL, 'FullDebug', 'D', 'InterfaceFull', 'A', 'Debug', 'd', 'Interface', 'a', 'Info', 'I', 'Warning', 'W', 'Error', 'E', 'Fatal', 'F', TRACE_LEVEL) L,
  COMPONENT,
  SOURCE_FILE_NAME SOURCE_FILE,
  LPAD(SOURCE_FILE_LINE, 8) SRC_LINE,
  TRACE_FILE_NAME,
  STRING_AGG(SAP_NOTE, ', ' ORDER BY SAP_NOTE) SAP_NOTE,
  SUBSTR(LTRIM(REPLACE(REPLACE(REPLACE(TRACE_TEXT, CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32))), 1, MAP(TRACE_TEXT_LENGTH, -1, 999999, TRACE_TEXT_LENGTH)) TRACE_TEXT,
  IFNULL(STATEMENT_HASH, '') STATEMENT_HASH,
  IFNULL(DB_USER, '') DB_USER,
  IFNULL(APP_USER, '') APP_USER,
  IFNULL(APP_SOURCE, '') APP_SOURCE,
  IFNULL(APP_NAME, '') APP_NAME,
  IFNULL(PASSPORT_ACTION, '') PASSPORT_ACTION,
  IFNULL(PASSPORT_COMPONENT, '') PASSPORT_COMPONENT,
  UTID,
  SUBSTR(LTRIM(REPLACE(REPLACE(REPLACE(SUBSTR(TRACE_TEXT, LOCATE(TRACE_TEXT, SUBSTRING_TRACE_TEXT)), CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32))), 1, MAP(SUBSTRING_TRACE_TEXT_LENGTH, -1, 999999, SUBSTRING_TRACE_TEXT_LENGTH)) SUBSTRING_TRACE_TEXT
FROM
( SELECT
    CASE
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN
        CASE
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00',
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)),
'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any'
    END BEGIN_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')            != 0 THEN T.HOST                              ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                                    END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')            != 0 THEN TO_VARCHAR(T.PORT)                  ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                                    END PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')         != 0 THEN T.SERVICE_NAME                      ELSE MAP(BI.SERVICE_NAME, '%', 'any', BI.SERVICE_NAME)                    END SERVICE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')         != 0 THEN TO_VARCHAR(T.CONNECTION_ID)         ELSE MAP(BI.CONN_ID, -1, 'any', TO_VARCHAR(BI.CONN_ID))                   END CONN_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')       != 0 THEN TO_VARCHAR(T.THREAD_ID)             ELSE MAP(BI.THREAD_ID, -1, 'any', TO_VARCHAR(BI.THREAD_ID))               END THREAD_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')            != 0 THEN T.STATEMENT_HASH                    ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)                END STATEMENT_HASH,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')         != 0 THEN T.USER_NAME                         ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                              END DB_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')        != 0 THEN T.APPLICATION_USER_NAME             ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                            END APP_USER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')      != 0 THEN T.APPLICATION_SOURCE                ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                        END APP_SOURCE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')        != 0 THEN T.APPLICATION_NAME                  ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                            END APP_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION') != 0 THEN T.PASSPORT_ACTION                   ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)              END PASSPORT_ACTION,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMP')   != 0 THEN T.PASSPORT_COMPONENT_NAME           ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)        END PASSPORT_COMPONENT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'UTID')            != 0 THEN TO_VARCHAR(T.UPDATE_TRANSACTION_ID) ELSE MAP(BI.UTID, -1, 'any', TO_VARCHAR(BI.UTID))                         END UTID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LEVEL')           != 0 THEN T.TRACE_LEVEL                       ELSE 'any'                                                                END TRACE_LEVEL,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'COMPONENT')       != 0 THEN T.COMPONENT                         ELSE MAP(BI.COMPONENT, '%', 'any', BI.COMPONENT)                          END COMPONENT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'FILE')            != 0 THEN T.TRACE_FILE_NAME                   ELSE MAP(BI.TRACE_FILE_NAME, '%', 'any', BI.TRACE_FILE_NAME)              END TRACE_FILE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NOTE')            != 0 THEN IFNULL(TO_VARCHAR(E.SAP_NOTE), '')  ELSE MAP(BI.SAP_NOTE, -1, 'any', TO_VARCHAR(BI.SAP_NOTE))                 END SAP_NOTE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TEXT')            != 0 THEN TO_VARCHAR(T.TRACE_TEXT)            ELSE MAP(BI.TRACE_TEXT, '%', 'any', BI.TRACE_TEXT)                        END TRACE_TEXT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SOURCE')          != 0 THEN T.SOURCE_FILE_NAME                  ELSE MAP(BI.SOURCE_FILE_NAME, '%', 'any', BI.SOURCE_FILE_NAME)            END SOURCE_FILE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SOURCE')          != 0 THEN TO_VARCHAR(T.SOURCE_FILE_LINE)      ELSE MAP(BI.SOURCE_FILE_LINE, -1, 'any', TO_VARCHAR(BI.SOURCE_FILE_LINE)) END SOURCE_FILE_LINE,
    COUNT(DISTINCT(T.TIMESTAMP || T.TRACE_TEXT)) COUNT,
    AVG(LENGTH(T.TRACE_TEXT)) / 1024 AVG_LEN_KB,
    BI.SUBSTRING_TRACE_TEXT,
    BI.ORDER_BY,
    BI.TRACE_TEXT_LENGTH,
    BI.SUBSTRING_TRACE_TEXT_LENGTH
  FROM
    BASIS_INFO BI,
    MERGED_TRACES_ENRICHED T LEFT OUTER JOIN
  ( SELECT
      *
    FROM
    ( SELECT '%ShmSystem::create % - No space left on device' ERROR_TEXT,                               941735 SAP_NOTE FROM DUMMY UNION ALL
      SELECT '%Clock skew too great%',                                                                  1283986 FROM DUMMY UNION ALL
      SELECT '%:::: % ::::%',                                                                           1642148 FROM DUMMY UNION ALL
      SELECT '%BackupChannel: create backup%',                                                          1642148 FROM DUMMY UNION ALL
      SELECT '%~BackupExe_BackintHandlerImpl: %backint terminat%',                                      1642148 FROM DUMMY UNION ALL
      SELECT '%Activating log backup, since initial data backup is about to start%',                    1642148 FROM DUMMY UNION ALL
      SELECT '%BACKINT did not return result for%',                                                     1642148 FROM DUMMY UNION ALL
      SELECT '%Backint "%", requested by process % started with pid%',                                  1642148 FROM DUMMY UNION ALL
      SELECT '%Backint process % is alive%',                                                            1642148 FROM DUMMY UNION ALL
      SELECT '%backup could not be completed%',                                                         1642148 FROM DUMMY UNION ALL
      SELECT '%Backup % is not usable because of takeover on standby%',                                 1642148 FROM DUMMY UNION ALL
      SELECT '%backup delete job finished%',                                                            1642148 FROM DUMMY UNION ALL
      SELECT '%BackupDest_Destination::cleanup -> done%',                                               1642148 FROM DUMMY UNION ALL
      SELECT '%Backup error: Backint reported%',                                                        1642148 FROM DUMMY UNION ALL
      SELECT 'Backup executable image % is link to%',                                                   1642148 FROM DUMMY UNION ALL
      SELECT '%BackupMgrSrc_ProgressEntry::writeToView: deleting previous entry with backup id%',       1642148 FROM DUMMY UNION ALL
      SELECT '%Backup Retention: Deleted backups according to schedule%',                               1642148 FROM DUMMY UNION ALL
      SELECT '%backup source % will not be encrypted%',                                                 1642148 FROM DUMMY UNION ALL
      SELECT '%BackupStrategy_Catalog::addEntry: DataBackup%Entry without matching start entry%',       1642148 FROM DUMMY UNION ALL
      SELECT '%Cancel backup % of %%',                                                                  1642148 FROM DUMMY UNION ALL
      SELECT '%Cannot untrack entry for backup id%',                                                    1642148 FROM DUMMY UNION ALL
      SELECT '%Changing log backup interval mode from%',                                                1642148 FROM DUMMY UNION ALL
      SELECT '%[DBT] received BackupCatalog%Entry for%',                                                1642148 FROM DUMMY UNION ALL
      SELECT '%Deleting pipe%%',                                                                        1642148 FROM DUMMY UNION ALL
      SELECT '%Deleting % unfinished entries%',                                                         1642148 FROM DUMMY UNION ALL
      SELECT '%timeout while%waiting for channel event%',                                               1642148 FROM DUMMY UNION ALL
      SELECT '%Entry % already tracked!%',                                                              1642148 FROM DUMMY UNION ALL
      SELECT '%Exception while executing catalog backup%',                                              1642148 FROM DUMMY UNION ALL
      SELECT '%Failed to send signal % to backint process with pid%',                                   1642148 FROM DUMMY UNION ALL
      SELECT '%finished backup from % with error: exception %1: no.110203%',                            1642148 FROM DUMMY UNION ALL
      SELECT '%Got process state 2 from daemon for backint pid%',                                       1642148 FROM DUMMY UNION ALL
      SELECT '%Handover destination BackupDestination%',                                                1642148 FROM DUMMY UNION ALL
      SELECT '%HISTORY LOST at log position%',                                                          1642148 FROM DUMMY UNION ALL
      SELECT '%loadSnapshotInfo: destination file % doesn_t exist%',                                    1642148 FROM DUMMY UNION ALL
      SELECT '%Log backup did not fit to recovery entry%',                                              1642148 FROM DUMMY UNION ALL
      SELECT '%LogSegment::markFree LogSegment%',                                                       1642148 FROM DUMMY UNION ALL
      SELECT '%Missing _LogSegment_ file: % this might be fatal for future restarts.%',                 1642148 FROM DUMMY UNION ALL
      SELECT '%multistream, writeBackupToSecondary: copy incomplete%',                                  1642148 FROM DUMMY UNION ALL
      SELECT '%No valid snapshot has been found%',                                                      1642148 FROM DUMMY UNION ALL
      SELECT '%primaryBackupFinished%',                                                                 1642148 FROM DUMMY UNION ALL
      SELECT '%Redo done up to position%',                                                              1642148 FROM DUMMY UNION ALL
      SELECT '%Redo-logging turned on%',                                                                1642148 FROM DUMMY UNION ALL
      SELECT '%Removing % unfinished entries%',                                                         1642148 FROM DUMMY UNION ALL
      SELECT '%Removing unused log segment%',                                                           1642148 FROM DUMMY UNION ALL
      SELECT '%Report backup failure%',                                                                 1642148 FROM DUMMY UNION ALL
      SELECT '%Requested volume 1024 not found in backup tracker.%',                                    1642148 FROM DUMMY UNION ALL
      SELECT '%SAVE DATA finished%',                                                                    1642148 FROM DUMMY UNION ALL
      SELECT '%SAVE DATA started%',                                                                     1642148 FROM DUMMY UNION ALL
      SELECT '%Server not accepting new save sessions%',                                                1642148 FROM DUMMY UNION ALL
      SELECT '%Setting log segment backup timeout to %',                                                1642148 FROM DUMMY UNION ALL
      SELECT '%Setting log segment timeout to 0, because of log backup interval mode service%',         1642148 FROM DUMMY UNION ALL
      SELECT '%SNAPSHOT finished successfully%',                                                        1642148 FROM DUMMY UNION ALL
      SELECT '%SNAPSHOT started%',                                                                      1642148 FROM DUMMY UNION ALL
      SELECT '%Starting data transfer with source size%',                                               1642148 FROM DUMMY UNION ALL
      SELECT '%Starting initial BACKUP DATA, recoverability of the database will be ensured%',          1642148 FROM DUMMY UNION ALL
      SELECT '%starting physical backup delete job%',                                                   1642148 FROM DUMMY UNION ALL
      SELECT '%Starting % backup in % chunks%',                                                         1642148 FROM DUMMY UNION ALL
      SELECT '%storage snapshot cannot be prepared because another storage snapshot has been already%', 1642148 FROM DUMMY UNION ALL
      SELECT 'streamError in state%',                                                                   1642148 FROM DUMMY UNION ALL
      SELECT '%Unable to untrack catalog entry %! Entry not found!%',                                   1642148 FROM DUMMY UNION ALL
      SELECT '%updateTransferStats premature channel close%',                                           1642148 FROM DUMMY UNION ALL
      SELECT '%Wait for backint pid % returned %, status: %',                                           1642148 FROM DUMMY UNION ALL
      SELECT '%attempt to store%',                                                                      1704499 FROM DUMMY UNION ALL
      SELECT '%Licensing::LicenseEAPIUtils%',                                                           1704499 FROM DUMMY UNION ALL
      SELECT '%Licensing::LicensePluginRegistry%',                                                      1704499 FROM DUMMY UNION ALL
      SELECT '%Storing HANA measurement result%',                                                       1704499 FROM DUMMY UNION ALL
      SELECT '%Error: Profiler %Time:%',                                                                1804811 FROM DUMMY UNION ALL
      SELECT '%[RSReorg]%',                                                                             1813245 FROM DUMMY UNION ALL
      SELECT '%column store error: merge delta index error:  [6924] Attribute save failed%',            1860493 FROM DUMMY UNION ALL
      SELECT '%olap: merging multi value dicts is not implemented%',                                    1866135 FROM DUMMY UNION ALL
      SELECT '[DISKFULL]%',                                                                             1870858 FROM DUMMY UNION ALL
      SELECT 'Event _DiskFullEvent%',                                                                   1870858 FROM DUMMY UNION ALL
      SELECT '%Logger notified of% DiskFull%',                                                          1870858 FROM DUMMY UNION ALL
      SELECT '%One segment in status % has been %',                                                     1870858 FROM DUMMY UNION ALL
      SELECT '%Trying to RECLAIM one log segment because of _disk full_ situation%',                    1870858 FROM DUMMY UNION ALL
      SELECT '%Error timezone string%',                                                                 1932132 FROM DUMMY UNION ALL
      SELECT '%Falling back to using UTC as local timezone%',                                           1932132 FROM DUMMY UNION ALL
      SELECT '%Unexpected end encountered when parsing POSIX timezone string%',                         1932132 FROM DUMMY UNION ALL
      SELECT '%Time zone validity checker could not find database tables with timezone data%',          1932132 FROM DUMMY UNION ALL
      SELECT '%Querying monitoring view failed with exception%',                                        1969700 FROM DUMMY UNION ALL
      SELECT '%initializeConnection: Couldn_t establish connection to Host Agent on localhost%',        1969700 FROM DUMMY UNION ALL
      SELECT '%Received invalid message from Host Agent%',                                              1969700 FROM DUMMY UNION ALL
      SELECT '%server side has unexpectedly stopped sending data%',                                     1969700 FROM DUMMY UNION ALL
      SELECT '%TableUpdate internal error: Inconsistent lateMat pageSizes%',                            1975448 FROM DUMMY UNION ALL
      SELECT '%Application for this process will only work with%',                                      1999880 FROM DUMMY UNION ALL
      SELECT '%Asynchronous replication buffer full%',                                                  1999880 FROM DUMMY UNION ALL
      SELECT '%Asynchronous Replication Buffer is Overloaded%',                                         1999880 FROM DUMMY UNION ALL
      SELECT '%AutoEventHandlerCallback::initial%',                                                     1999880 FROM DUMMY UNION ALL
      SELECT '%AutoEventHandlerCallback::reconfigure%',                                                 1999880 FROM DUMMY UNION ALL
      SELECT '%Buffer received: BufferHeader%',                                                         1999880 FROM DUMMY UNION ALL
      SELECT '%called by user % with UID: %%',                                                          1999880 FROM DUMMY UNION ALL
      SELECT '%called drUnregisterDatacenter%',                                                         1999880 FROM DUMMY UNION ALL
      SELECT '%Changing Log Retention: retentionMode%',                                                 1999880 FROM DUMMY UNION ALL
      SELECT '%check failed, guid not found in history%',                                               1999880 FROM DUMMY UNION ALL
      SELECT '%checking persistence with guid history%',                                                1999880 FROM DUMMY UNION ALL
      SELECT '%Closing connection to siteID%LogShipping was waiting for%',                              1999880 FROM DUMMY UNION ALL
      SELECT '%command: %hdbnsutil%',                                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%Configure System Replication Primary in Persistence Manager%',                           1999880 FROM DUMMY UNION ALL
      SELECT '%Connection to primary established%',                                                     1999880 FROM DUMMY UNION ALL
      SELECT '%Could not reach any host of site%',                                                      1999880 FROM DUMMY UNION ALL
      SELECT '% Replica: % (%/% _B)%',                                                                  1999880 FROM DUMMY UNION ALL
      SELECT 'Data compatibility check with primary failed%',                                           1999880 FROM DUMMY UNION ALL
      SELECT '%Disable System Replication Primary in Persistence Manager%',                             1999880 FROM DUMMY UNION ALL
      SELECT 'done.',                                                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%drConnectionChanged:%isInSync=%',                                                        1999880 FROM DUMMY UNION ALL
      SELECT '%drUnregisterDatacenter: unregistering site%',                                            1999880 FROM DUMMY UNION ALL
      SELECT '%error when sending request%',                                                            1999880 FROM DUMMY UNION ALL
      SELECT '%Error retrieving used memory size with query%',                                          1999880 FROM DUMMY UNION ALL
      SELECT '%Exception caught when creating translator%',                                             1999880 FROM DUMMY UNION ALL
      SELECT '%Exception while trying to preload table -> unloading table%',                            1999880 FROM DUMMY UNION ALL
      SELECT '%found start segment : LogSegment%',                                                      1999880 FROM DUMMY UNION ALL
      SELECT '%Free segment kept for replication%',                                                     1999880 FROM DUMMY UNION ALL
      SELECT '%Gap in the log buffer sequence detected%',                                               1999880 FROM DUMMY UNION ALL
      SELECT '%getMissingLogInfo: restartLogPos%',                                                      1999880 FROM DUMMY UNION ALL
      SELECT '%handleEvents%',                                                                          1999880 FROM DUMMY UNION ALL
      SELECT '%invalid message type%',                                                                  1999880 FROM DUMMY UNION ALL
      SELECT '%log buffer takes more than % to process and write%',                                     1999880 FROM DUMMY UNION ALL
      SELECT '%Missing Log:%',                                                                          1999880 FROM DUMMY UNION ALL
      SELECT '%New event reported:%%',                                                                  1999880 FROM DUMMY UNION ALL
      SELECT '%New Replication Connection registered for%',                                             1999880 FROM DUMMY UNION ALL
      SELECT '%No more callbacks available% wait for callbacks to be released%',                        1999880 FROM DUMMY UNION ALL
      SELECT '%parent process command line%',                                                           1999880 FROM DUMMY UNION ALL
      SELECT '%parent process executable%',                                                             1999880 FROM DUMMY UNION ALL
      SELECT '%Prepare takeover finished%',                                                             1999880 FROM DUMMY UNION ALL
      SELECT '%Prepare takeover started%',                                                              1999880 FROM DUMMY UNION ALL
      SELECT '%primary disable finished%',                                                              1999880 FROM DUMMY UNION ALL
      SELECT '%: set ACTIVE for site%',                                                                 1999880 FROM DUMMY UNION ALL
      SELECT '%Processing % request%',                                                                  1999880 FROM DUMMY UNION ALL
      SELECT '%Read phase % from takeover file%',                                                       1999880 FROM DUMMY UNION ALL
      SELECT '%Reassign transTable%',                                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%Received no inifile entries from site id%',                                              1999880 FROM DUMMY UNION ALL
      SELECT '%Reconnecting is continued now every 30 seconds in the background%',                      1999880 FROM DUMMY UNION ALL
      SELECT '%Remove following ini file entry on site%',                                               1999880 FROM DUMMY UNION ALL
      SELECT '%Replicate following ini file entry to site%',                                            1999880 FROM DUMMY UNION ALL
      SELECT '%Replication session closed%',                                                            1999880 FROM DUMMY UNION ALL
      SELECT '%reportEvent: ReplicationEvent%',                                                         1999880 FROM DUMMY UNION ALL
      SELECT '%Request redo logs from primary for takeover-ability%',                                   1999880 FROM DUMMY UNION ALL
      SELECT '%resolveHost % not found in global.ini/[system_replication_hostname_resolution]%',        1999880 FROM DUMMY UNION ALL
      SELECT '%resources % datashipping property%',                                                     1999880 FROM DUMMY UNION ALL
      SELECT '%Secondary with siteId=%registered%',                                                     1999880 FROM DUMMY UNION ALL
      SELECT '%sending log initialized for session%',                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%Start listen to specific interface%',                                                    1999880 FROM DUMMY UNION ALL
      SELECT 'storeShippedSegment:%',                                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%SystemReplicationEvent%',                                                                1999880 FROM DUMMY UNION ALL
      SELECT '%he hostname could not be resolved',                                                      1999880 FROM DUMMY UNION ALL
      SELECT '%This trace is intended to clarify frequent "logshipping timeout" situation%',            1999880 FROM DUMMY UNION ALL
      SELECT '%Timer implementation will use RDTSCP%',                                                  1999880 FROM DUMMY UNION ALL
      SELECT 'Transfer % statistics%minReceiveThroughput%',                                             1999880 FROM DUMMY UNION ALL
      SELECT '%Try to free RETAINED_FREE segment as logshipping_max_retention_size reached%',           1999880 FROM DUMMY UNION ALL
      SELECT '%Trying to reconnect to primary%',                                                        1999880 FROM DUMMY UNION ALL
      SELECT '%Unable to create socket for name: hdbnsutil%',                                           1999880 FROM DUMMY UNION ALL
      SELECT 'updatePersistenceGUIDsforReplication:%',                                                  1999880 FROM DUMMY UNION ALL
      SELECT '%Using % to determine %CPU ID%',                                                          1999880 FROM DUMMY UNION ALL
      SELECT '%Using RDTSC for HR timer%',                                                              1999880 FROM DUMMY UNION ALL
      SELECT '%volume % successfully initialized for system replication%',                              1999880 FROM DUMMY UNION ALL
      SELECT '%waiting for system replication jobs%',                                                   1999880 FROM DUMMY UNION ALL
      SELECT '%CompletionQueueConfiguration::initial%',                                                 1999930 FROM DUMMY UNION ALL
      SELECT '%Could not create file%17 (File exists)%',                                                1999930 FROM DUMMY UNION ALL
      SELECT '%DeltaThroughputStatistics: Tracking new ThroughputStatistics%',                          1999930 FROM DUMMY UNION ALL
      SELECT '%ERROR in async. file transfer: exception%',                                              1999930 FROM DUMMY UNION ALL
      SELECT '%No such file or directory%',                                                             1999930 FROM DUMMY UNION ALL
      SELECT '%FileFactoryConfiguration::initial%',                                                     1999930 FROM DUMMY UNION ALL
      SELECT '%error code: 13 (Permission denied)%',                                                    1999930 FROM DUMMY UNION ALL
      SELECT '%rc=13%Permission denied%',                                                               1999930 FROM DUMMY UNION ALL
      SELECT '%rc=28: No space left on device%',                                                        1999930 FROM DUMMY UNION ALL
      SELECT '%RETRY after error in async. file transfer%',                                             1999930 FROM DUMMY UNION ALL
      SELECT '%SubmitQueueConfiguration::initial%',                                                     1999930 FROM DUMMY UNION ALL
      SELECT '%llocation failed%',                                                                      1999997 FROM DUMMY UNION ALL
      SELECT 'Allocation failure type:%',                                                               1999997 FROM DUMMY UNION ALL
      SELECT '%Allocators activated%',                                                                  1999997 FROM DUMMY UNION ALL
      SELECT '%Also printing top _Connection_ allocators and top _WorkloadCtx_ allocators...%',         1999997 FROM DUMMY UNION ALL
      SELECT '%bad alloc during prepare%',                                                              1999997 FROM DUMMY UNION ALL
      SELECT '%bad alloc in avc->open%',                                                                1999997 FROM DUMMY UNION ALL
      SELECT '%annot allocate %memory%',                                                                1999997 FROM DUMMY UNION ALL
      SELECT '%Cannot allocate stack of % for thread%',                                                 1999997 FROM DUMMY UNION ALL
      SELECT '%Column Store Tables: UnifiedTableComposite%',                                            1999997 FROM DUMMY UNION ALL
      SELECT '%omposite limit violation%',                                                              1999997 FROM DUMMY UNION ALL
      SELECT 'Composite limit=%b (%b)%',                                                                1999997 FROM DUMMY UNION ALL
      SELECT 'Current callstack:%',                                                                     1999997 FROM DUMMY UNION ALL
      SELECT '%error = 6952%',                                                                          1999997 FROM DUMMY UNION ALL
      SELECT '%exception 71000004%',                                                                    1999997 FROM DUMMY UNION ALL
      SELECT 'Executable: %',                                                                           1999997 FROM DUMMY UNION ALL
      SELECT '%ailed to allocate%',                                                                     1999997 FROM DUMMY UNION ALL
      SELECT '%failed to open attribute%6952%',                                                         1999997 FROM DUMMY UNION ALL
      SELECT '%Finished writing oom runtime dump!%',                                                    1999997 FROM DUMMY UNION ALL
      SELECT '%flag transferred%',                                                                      1999997 FROM DUMMY UNION ALL
      SELECT 'GLOBAL_ALLOCATION_LIMIT (GAL) =%',                                                        1999997 FROM DUMMY UNION ALL
      SELECT 'Heap memory fragmentation:%',                                                             1999997 FROM DUMMY UNION ALL
      SELECT 'Host: %',                                                                                 1999997 FROM DUMMY UNION ALL
      SELECT '%Information about shrink%',                                                              1999997 FROM DUMMY UNION ALL
      SELECT '%Limit correction value (additionally considered as%',                                    1999997 FROM DUMMY UNION ALL
      SELECT '%memAllocSystemPages failed%',                                                            1999997 FROM DUMMY UNION ALL
      SELECT 'Memory consumption information of last failing ProvideMemory%',                           1999997 FROM DUMMY UNION ALL
      SELECT 'MemoryType:%',                                                                            1999997 FROM DUMMY UNION ALL
      SELECT '%Number of memory pools used%',                                                           1999997 FROM DUMMY UNION ALL
      SELECT '%oom exception%',                                                                         1999997 FROM DUMMY UNION ALL
      SELECT '%out of memory error returned%',                                                          1999997 FROM DUMMY UNION ALL
      SELECT '%Out of memory for%',                                                                     1999997 FROM DUMMY UNION ALL
      SELECT '%Out of memory on%',                                                                      1999997 FROM DUMMY UNION ALL
      SELECT 'OUT OF MEMORY occurred.%',                                                                1999997 FROM DUMMY UNION ALL
      SELECT '%Out of memory occurred. More information in oom runtime dump!%',                         1999997 FROM DUMMY UNION ALL
      SELECT '%Per core memory pools%',                                                                 1999997 FROM DUMMY UNION ALL
      SELECT 'PID: %',                                                                                  1999997 FROM DUMMY UNION ALL
      SELECT '%PoolAllocators used%',                                                                   1999997 FROM DUMMY UNION ALL
      SELECT '%ProActiveGarbageCollectionCallback::timeoutReached%',                                    1999997 FROM DUMMY UNION ALL
      SELECT '%ProtectionKeys disabled%',                                                               1999997 FROM DUMMY UNION ALL
      SELECT '%rc 4,%',                                                                                 1999997 FROM DUMMY UNION ALL
      SELECT '%rollback transaction because rc=6952 is set%',                                           1999997 FROM DUMMY UNION ALL
      SELECT 'Root allocator name=%',                                                                   1999997 FROM DUMMY UNION ALL
      SELECT 'ShmSystem::attach % - Invalid argument%',                                                 1999997 FROM DUMMY UNION ALL
      SELECT 'ShmSystem: retry attach%',                                                                1999997 FROM DUMMY UNION ALL
      SELECT '%Stack allocation error: cannot allocate%',                                               1999997 FROM DUMMY UNION ALL
      SELECT '%Statement Execution & Intermediate Results:%',                                           1999997 FROM DUMMY UNION ALL
      SELECT 'Sum AB %',                                                                                1999997 FROM DUMMY UNION ALL
      SELECT 'Sum Used %',                                                                              1999997 FROM DUMMY UNION ALL
      SELECT '%: System:%',                                                                             1999997 FROM DUMMY UNION ALL
      SELECT '%Top "limited composite allocator" allocators%',                                          1999997 FROM DUMMY UNION ALL
      SELECT 'Top "M_%_MEMORY" allocators (component, name, size).%',                                   1999997 FROM DUMMY UNION ALL
      SELECT '%Top %UnifiedTable% allocators%',                                                         1999997 FROM DUMMY UNION ALL
      SELECT '%TraceContextSerializer::%: oom flag %serialized%',                                       1999997 FROM DUMMY UNION ALL
      SELECT '%udivLookup failed: AttributeEngine: not enough memory(6952)%',                           1999997 FROM DUMMY UNION ALL
      SELECT '%Using big block segment size%',                                                          1999997 FROM DUMMY UNION ALL
      SELECT '%(4), %',                                                                                 1999997 FROM DUMMY UNION ALL
      SELECT '%An orphaned application lock is detected%',                                              1999998 FROM DUMMY UNION ALL
      SELECT '%DAT" cannot be opened in mode "rb": Permission denied (errno = 13)%',                    1999998 FROM DUMMY UNION ALL
      SELECT '%eadlock detected%',                                                                      1999998 FROM DUMMY UNION ALL
      SELECT '%Error occurred during connect to primary%',                                              1999998 FROM DUMMY UNION ALL
      SELECT '%Failed to get table location during table lock%',                                        1999998 FROM DUMMY UNION ALL
      SELECT '%lock_table_globally failed: cannot find table object%',                                  1999998 FROM DUMMY UNION ALL
      SELECT '%Lock timeout occurs while waiting%',                                                     1999998 FROM DUMMY UNION ALL
      SELECT '%Lock-wait time out exceeded%',                                                           1999998 FROM DUMMY UNION ALL
      SELECT '%Missing root key hash%',                                                                 1999998 FROM DUMMY UNION ALL
      SELECT '%MAX_QUEUE_WAITER_COUNT 1023 for rowlock exceeded%',                                      1999998 FROM DUMMY UNION ALL
      SELECT '%Resource busy and NOWAIT specified%',                                                    1999998 FROM DUMMY UNION ALL
      SELECT '%SharedLock overflow on context%',                                                        1999998 FROM DUMMY UNION ALL
      SELECT '%There are too many lock items on this system%',                                          1999998 FROM DUMMY UNION ALL
      SELECT '%transaction rolled back by lock wait timeout%',                                          1999998 FROM DUMMY UNION ALL
      SELECT '%Unsupported file system%',                                                               1999998 FROM DUMMY UNION ALL
      SELECT '%waitForFailedRowLocks caught exception for table%',                                      1999998 FROM DUMMY UNION ALL
      SELECT 'CONNECTION ESTABLISHMENT:%',                                                              2000000 FROM DUMMY UNION ALL
      SELECT '%esource temporarily unavailable%',                                                       2000000 FROM DUMMY UNION ALL
      SELECT '%snapshot timestamp synchronization failed%',                                             2000000 FROM DUMMY UNION ALL
      SELECT '%User reset monitor%',                                                                    2000000 FROM DUMMY UNION ALL
      SELECT '%CalcEngine Exception: exception % Variable is marked as required but not set%',          2000002 FROM DUMMY UNION ALL
      SELECT '%Caught exception in pop%',                                                               2000002 FROM DUMMY UNION ALL
      SELECT '%Repository activation lock timeout. Another activation is still running%',               2000002 FROM DUMMY UNION ALL
      SELECT '%failed to request idle connection time%',                                                2000003 FROM DUMMY UNION ALL
      SELECT '%Remove file % of size % to fulfill the trace quota%',                                    2000003 FROM DUMMY UNION ALL
      SELECT '%The execution of the script has exceeded the maximum request runtime.%',                 2000003 FROM DUMMY UNION ALL
      SELECT '%unexpected exception %type=Retrieve Idle Time of Routed Connection%',                    2000003 FROM DUMMY UNION ALL
      SELECT '%-- end executor returns%',                                                               2020877 FROM DUMMY UNION ALL
      SELECT '%-- returns for plan%',                                                                   2020877 FROM DUMMY UNION ALL
      SELECT '%Could not allocate value%The table has no OTHERS part. Create a new partition%',         2044468 FROM DUMMY UNION ALL
      SELECT '%Could not evaluate date value%',                                                         2044468 FROM DUMMY UNION ALL
      SELECT '%is smaller than lower bound of new range%',                                              2044468 FROM DUMMY UNION ALL
      SELECT '%is smaller than the least possible lower bound for a new range%',                        2044468 FROM DUMMY UNION ALL
      SELECT '%Table % is not dynamic range partitioned.%',                                             2044468 FROM DUMMY UNION ALL
      SELECT '%Transaction canceled during persistence operation%',                                     2057046 FROM DUMMY UNION ALL
      SELECT '%Caught exception merging attributes%',                                                   2057046 FROM DUMMY UNION ALL
      SELECT '%do rollbackDeltaMerge merge%',                                                           2057046 FROM DUMMY UNION ALL
      SELECT '%exception in smart merge thread run%',                                                   2057046 FROM DUMMY UNION ALL
      SELECT '%Invalid auto merge decision function%',                                                  2057046 FROM DUMMY UNION ALL
      SELECT '%merge state for failed fusion: DFU TO NEW DELTA%',                                       2057046 FROM DUMMY UNION ALL
      SELECT '%not enough merge tokens for delta merge%',                                               2057046 FROM DUMMY UNION ALL
      SELECT '%parse error Evaluator: syntax error in expression string%',                              2057046 FROM DUMMY UNION ALL
      SELECT '%Smartmerge failed for optimize compression%table does not exist%',                       2057046 FROM DUMMY UNION ALL
      SELECT '%table optimization was not possible due to open metadata changes%',                      2057046 FROM DUMMY UNION ALL
      SELECT '%maximum number of log segments in log partition%',                                       2072410 FROM DUMMY UNION ALL
      SELECT '%RepositoryAccessor::getCalculationScenario%for scenario%failed%',                        2081505 FROM DUMMY UNION ALL
      SELECT '%expect non-empty top-k info for non-empty column%',                                      2089847 FROM DUMMY UNION ALL
      SELECT '%[42002] Transaction cancelled%',                                                         2092196 FROM DUMMY UNION ALL
      SELECT '%591%internal error%',                                                                    2092196 FROM DUMMY UNION ALL
      SELECT '%abort%(23051)%',                                                                         2092196 FROM DUMMY UNION ALL
      SELECT '%CANCEL_FLAG%',                                                                           2092196 FROM DUMMY UNION ALL
      SELECT '%canceled % still not finished (cancel%ation might be still on-going)%',                  2092196 FROM DUMMY UNION ALL
      SELECT '%cancel requested%',                                                                      2092196 FROM DUMMY UNION ALL
      SELECT '%Cancel was requested while reading LOB. The current transaction is aborted%',            2092196 FROM DUMMY UNION ALL
      SELECT '%cannot execute plan, query:%',                                                           2092196 FROM DUMMY UNION ALL
      SELECT '%Cleanup SQL query executed and found following task execution%',                         2092196 FROM DUMMY UNION ALL
      SELECT '%current operation cancel%ed by request%',                                                2092196 FROM DUMMY UNION ALL
      SELECT '%Error during trace file parse%',                                                         2092196 FROM DUMMY UNION ALL
      SELECT '%exception %0139%',                                                                       2092196 FROM DUMMY UNION ALL
      SELECT '%exception %23051%',                                                                      2092196 FROM DUMMY UNION ALL
      SELECT '%exception %2625%',                                                                       2092196 FROM DUMMY UNION ALL
      SELECT '%exception %6865%',                                                                       2092196 FROM DUMMY UNION ALL
      SELECT '%exception %6892%',                                                                       2092196 FROM DUMMY UNION ALL
      SELECT '%executed statement:%called from%',                                                       2092196 FROM DUMMY UNION ALL
      SELECT '%ExecutionCanceled exception%',                                                           2092196 FROM DUMMY UNION ALL
      SELECT 'failed plan: SequentialPlan%',                                                            2092196 FROM DUMMY UNION ALL
      SELECT '%failed replay delta log for table%',                                                     2092196 FROM DUMMY UNION ALL
      SELECT '%failed to handle disconnect related connections request: session context error%',        2092196 FROM DUMMY UNION ALL
      SELECT '%failed to prepare external transaction%',                                                2092196 FROM DUMMY UNION ALL
      SELECT '%(get channel) different gcid%',                                                          2092196 FROM DUMMY UNION ALL
      SELECT '%invalidate_external_inuse_count is not finished%',                                       2092196 FROM DUMMY UNION ALL
      SELECT '%Operation cancelled%',                                                                   2092196 FROM DUMMY UNION ALL
      SELECT '%no.2040026%',                                                                            2092196 FROM DUMMY UNION ALL
      SELECT '%no activated external transaction%',                                                     2092196 FROM DUMMY UNION ALL
      SELECT '%no such session context%',                                                               2092196 FROM DUMMY UNION ALL
      SELECT '%plan aborted%',                                                                          2092196 FROM DUMMY UNION ALL
      SELECT '%plan aborted_ $function$=recurse_ $message$=abort plan%',                                2092196 FROM DUMMY UNION ALL
      SELECT '%Ptime exception thrown: 139 from ptimeOp%',                                              2092196 FROM DUMMY UNION ALL
      SELECT '%Query Canceled(139)%',                                                                   2092196 FROM DUMMY UNION ALL
      SELECT '%rc 139, %Canceled%',                                                                     2092196 FROM DUMMY UNION ALL
      SELECT '%rc%=%2040026%',                                                                          2092196 FROM DUMMY UNION ALL
      SELECT '%rc %23051%',                                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%rc%=%2458%',                                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%rc%=%2625%',                                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%rc%=%6865%',                                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%rc%=%6892%',                                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%Redirected cancel request % received error: 71000729: unknown global session id%',       2092196 FROM DUMMY UNION ALL
      SELECT '%(remote scan history) failed to add statistics%',                                        2092196 FROM DUMMY UNION ALL
      SELECT '%removing plan from cache%',                                                              2092196 FROM DUMMY UNION ALL
      SELECT '%return code 2458%',                                                                      2092196 FROM DUMMY UNION ALL
      SELECT '%return code 6892%',                                                                      2092196 FROM DUMMY UNION ALL
      SELECT '%session control command is performed by%',                                               2092196 FROM DUMMY UNION ALL
      SELECT '%[session request handler] unhandled exception: session context error%',                  2092196 FROM DUMMY UNION ALL
      SELECT '%Total: %:%:%.% to %:%:%.% +%.%',                                                         2092196 FROM DUMMY UNION ALL
      SELECT 'trace_basics called from%',                                                               2092196 FROM DUMMY UNION ALL
      SELECT 'trace_trans: TransactionId%',                                                             2092196 FROM DUMMY UNION ALL
      SELECT '%ransaction% canceled%',                                                                  2092196 FROM DUMMY UNION ALL
      SELECT '%Transaction cancel triggered -102%',                                                     2092196 FROM DUMMY UNION ALL
      SELECT '%tx canceled during validation%',                                                         2092196 FROM DUMMY UNION ALL
      SELECT '%validation failure of context id%',                                                      2092196 FROM DUMMY UNION ALL
      SELECT '%was closed because consecutive requests detected%',                                      2092196 FROM DUMMY UNION ALL
      SELECT '%SSFS-3600%',                                                                             2097613 FROM DUMMY UNION ALL
      SELECT '%Callback %::%() took %ms.%',                                                             2100009 FROM DUMMY UNION ALL
      SELECT '%Changing savepoint frequency to%',                                                       2100009 FROM DUMMY UNION ALL
      SELECT '%Clearing backup Snapshot Restart page number from the Anchor page%',                     2100009 FROM DUMMY UNION ALL
      SELECT '%Create snapshot for replication snapshotId%',                                            2100009 FROM DUMMY UNION ALL
      SELECT '%Disabling periodic savepoint%',                                                          2100009 FROM DUMMY UNION ALL
      SELECT 'Drop and create snapshots for secondary%',                                                2100009 FROM DUMMY UNION ALL
      SELECT '%NOTE: BACKUP DATA needed to ensure recoverability of the database%',                     2100009 FROM DUMMY UNION ALL
      SELECT '%Persistency was created with version%',                                                  2100009 FROM DUMMY UNION ALL
      SELECT '%Persistency was last savepointed with version%',                                         2100009 FROM DUMMY UNION ALL
      SELECT '%Replication Snapshot dropped%',                                                          2100009 FROM DUMMY UNION ALL
      SELECT '%Savepoint % waiting for critical phase%',                                                2100009 FROM DUMMY UNION ALL
      SELECT '%Savepoint current savepoint version%',                                                   2100009 FROM DUMMY UNION ALL
      SELECT '%set restart redo log position%',                                                         2100009 FROM DUMMY UNION ALL
      SELECT '%Snapshot current savepoint version%',                                                    2100009 FROM DUMMY UNION ALL
      SELECT 'triggerSavepointDuringLogReplay%',                                                        2100009 FROM DUMMY UNION ALL
      SELECT '%Fallback to system call for HR timer%',                                                  2100040 FROM DUMMY UNION ALL
      SELECT '%Usage of system timer is forced because%',                                               2100040 FROM DUMMY UNION ALL
      SELECT '%Disabling container having leaked pages%',                                               2101640 FROM DUMMY UNION ALL
      SELECT '%Found leaked page%',                                                                     2101640 FROM DUMMY UNION ALL
      SELECT '%Concurrent optimize compression failed%',                                                2112604 FROM DUMMY UNION ALL
      SELECT '%OptimizeCompressionData: cannot get data server%',                                       2112604 FROM DUMMY UNION ALL
      SELECT '%getDataServer() failed%%',                                                               2112604 FROM DUMMY UNION ALL
      SELECT '%ndex syncpoint mismatch%',                                                               2112848 FROM DUMMY UNION ALL
      SELECT '%[2576][INVALID SLOT]%',                                                                  2116157 FROM DUMMY UNION ALL
      SELECT '%An invalid encoded character detected%',                                                 2116157 FROM DUMMY UNION ALL
      SELECT '%AttributeEngine: error reading file%',                                                   2116157 FROM DUMMY UNION ALL
      SELECT '%Attribute engine index not found%',                                                      2116157 FROM DUMMY UNION ALL
      SELECT '%BackupChannel received page with invalid checksum%',                                     2116157 FROM DUMMY UNION ALL
      SELECT '%Catalog consistency check failed%',                                                      2116157 FROM DUMMY UNION ALL
      SELECT '%ColumnStoreConsistencyChecker found errors%',                                            2116157 FROM DUMMY UNION ALL
      SELECT '%duplicate records found during index rebuild%',                                          2116157 FROM DUMMY UNION ALL
      SELECT '%external reference in v-slot corrupted%',                                                2116157 FROM DUMMY UNION ALL
      SELECT '%found invalid reference in indexvector%',                                                2116157 FROM DUMMY UNION ALL
      SELECT '%getColumnValue: Column has NULL values%',                                                2116157 FROM DUMMY UNION ALL
      SELECT '%getColumnValue: Unable to retrieve value from column%',                                  2116157 FROM DUMMY UNION ALL
      SELECT '%indexId=% is not found in indexMap%',                                                    2116157 FROM DUMMY UNION ALL
      SELECT '%IndexMgr: index not found%',                                                             2116157 FROM DUMMY UNION ALL
      SELECT '%Invalid checksum algorithm%',                                                            2116157 FROM DUMMY UNION ALL
      SELECT '%Invalid page type%',                                                                     2116157 FROM DUMMY UNION ALL
      SELECT '%Invalid savepoint version%',                                                             2116157 FROM DUMMY UNION ALL
      SELECT '%Invalid size class%',                                                                    2116157 FROM DUMMY UNION ALL
      SELECT '%invalid v-slot pointer%',                                                                2116157 FROM DUMMY UNION ALL
      SELECT '%rows were not correctly assigned in part%',                                              2116157 FROM DUMMY UNION ALL
      SELECT '%RS Segment ID % is not valid%',                                                          2116157 FROM DUMMY UNION ALL
      SELECT '%Savepoint version must be newer%',                                                       2116157 FROM DUMMY UNION ALL
      SELECT '%Savepoint version must be older%',                                                       2116157 FROM DUMMY UNION ALL
      SELECT '%slot sanity check failure%',                                                             2116157 FROM DUMMY UNION ALL
      SELECT '%table content corruption identified during RS index build%',                             2116157 FROM DUMMY UNION ALL
      SELECT '%trace_columnbase, called from%',                                                         2116157 FROM DUMMY UNION ALL
      SELECT '%Unexpected exception in CP key generation%',                                             2116157 FROM DUMMY UNION ALL
      SELECT '%unexpected external reference in v-slot%',                                               2116157 FROM DUMMY UNION ALL
      SELECT '%unexpected table content identified during RS index build%',                             2116157 FROM DUMMY UNION ALL
      SELECT '%Vid from Index Vector: % is bigger than MaxVid from dictionary%',                        2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong checksum%',                                                                        2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong converter type%',                                                                  2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong next page number%',                                                                2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong owner%',                                                                           2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong page number%',                                                                     2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong size class%',                                                                      2116157 FROM DUMMY UNION ALL
      SELECT '%Wrong savepoint version%',                                                               2116157 FROM DUMMY UNION ALL
      SELECT '%Could not clean up the scope as the scope holder was not found%',                        2119087 FROM DUMMY UNION ALL
      SELECT '%no _sql_user_ defined in inifile section%',                                              2119087 FROM DUMMY UNION ALL
      SELECT '%exception in check_and_create_stat_entry%',                                              2124112 FROM DUMMY UNION ALL
      SELECT '%plan cache control command is performed%',                                               2124112 FROM DUMMY UNION ALL
      SELECT '%statement recompile required%',                                                          2124112 FROM DUMMY UNION ALL
      SELECT '%::writeTablePreloadInfo e%',                                                             2127458 FROM DUMMY UNION ALL
      SELECT '%ttribute load failed%',                                                                  2127458 FROM DUMMY UNION ALL
      SELECT '%Column Load Failed%',                                                                    2127458 FROM DUMMY UNION ALL
      SELECT '%Could not load UT table%',                                                               2127458 FROM DUMMY UNION ALL
      SELECT '%getOpenIndex(% failed%',                                                                 2127458 FROM DUMMY UNION ALL
      SELECT '%handling%useJsonFile%forLogReplay%unloadOnlyInvalid%allowCancelAttributeLoad%',          2127458 FROM DUMMY UNION ALL
      SELECT '%loading % (t %attributeid %version%',                                                    2127458 FROM DUMMY UNION ALL
      SELECT '%Pre-/Re-Loading of column store tables finished%',                                       2127458 FROM DUMMY UNION ALL
      SELECT '%rc=6923%',                                                                               2127458 FROM DUMMY UNION ALL
      SELECT '%reloading due to changed config file version%',                                          2127458 FROM DUMMY UNION ALL
      SELECT '%tables are open%',                                                                       2127458 FROM DUMMY UNION ALL
      SELECT 'table preload finished, print statistics%',                                               2127458 FROM DUMMY UNION ALL
      SELECT '%Unloading all resources with release time%',                                             2127458 FROM DUMMY UNION ALL
      SELECT '%301%unique constraint violated%_SYS_STATISTICS%',                                        2147247 FROM DUMMY UNION ALL
      SELECT '%Binary semaphore timed out during wait%',                                                2147247 FROM DUMMY UNION ALL
      SELECT '%callback streamError called%',                                                           2147247 FROM DUMMY UNION ALL
      SELECT '%call _SYS_STATISTICS.Shared%',                                                           2147247 FROM DUMMY UNION ALL
      SELECT 'delay time:%',                                                                            2147247 FROM DUMMY UNION ALL
      SELECT '%Error <exception 71000%in execution of internal statement:%_SYS_STATISTICS%',            2147247 FROM DUMMY UNION ALL
      SELECT '%error sending email [SMTPMail:%',                                                        2147247 FROM DUMMY UNION ALL
      SELECT '%exception sending email Alert%',                                                         2147247 FROM DUMMY UNION ALL
      SELECT 'initial profile:%',                                                                       2147247 FROM DUMMY UNION ALL
      SELECT 'installing...',                                                                           2147247 FROM DUMMY UNION ALL
      SELECT '%making sure old StatisticsServer is inactive%',                                          2147247 FROM DUMMY UNION ALL
      SELECT '%no old StatisticsServer in topology%',                                                   2147247 FROM DUMMY UNION ALL
      SELECT '%Remote endpoint closed unexpectedly%',                                                   2147247 FROM DUMMY UNION ALL
      SELECT '%retry installation of the Embedded Statistics Server%',                                  2147247 FROM DUMMY UNION ALL
      SELECT 'start installation',                                                                      2147247 FROM DUMMY UNION ALL
      SELECT '%Can_t create result with more than > 2^31 rows. Size:%',                                 2154870 FROM DUMMY UNION ALL
      SELECT '%Caught ptime exception general error: file % of size % exceeds max size of 8589934592%', 2154870 FROM DUMMY UNION ALL
      SELECT '%CellSizeMax was exceeded%',                                                              2154870 FROM DUMMY UNION ALL
      SELECT '%column search intermediate result exceeds 2 billion rows limitation%',                   2154870 FROM DUMMY UNION ALL
      SELECT '%exceeded the maximum number of session variables%',                                      2154870 FROM DUMMY UNION ALL
      SELECT '%exceed maximum number of prepared statements%',                                          2154870 FROM DUMMY UNION ALL
      SELECT '%exceed maximum number of transactions%',                                                 2154870 FROM DUMMY UNION ALL
      SELECT '%Execution of search failed: max_result_size reached%',                                   2154870 FROM DUMMY UNION ALL
      SELECT '%failed to add comm event%',                                                              2154870 FROM DUMMY UNION ALL
      SELECT '%following assertion failed: !(units[rhs.beginOffset % should be the same%',              2154870 FROM DUMMY UNION ALL
      SELECT '%maximum number of external connections%exceeded%',                                       2154870 FROM DUMMY UNION ALL
      SELECT '%Maximum number of rows per partition reached%',                                          2154870 FROM DUMMY UNION ALL
      SELECT '%max restart limit exceeded%',                                                            2154870 FROM DUMMY UNION ALL
      SELECT '%Max row count exceeded%',                                                                2154870 FROM DUMMY UNION ALL
      SELECT '%MM: exceed max number (%) of containers%',                                               2154870 FROM DUMMY UNION ALL
      SELECT '%Number of intermediate results exceeds supported limit%',                                2154870 FROM DUMMY UNION ALL
      SELECT '%Olap temporary data size exceeded 31/32 bit limit%',                                     2154870 FROM DUMMY UNION ALL
      SELECT '%reached max RS SHM segments%',                                                           2154870 FROM DUMMY UNION ALL
      SELECT '%search result has too many rows%',                                                       2154870 FROM DUMMY UNION ALL
      SELECT '%result size limit exceeded%',                                                            2154870 FROM DUMMY UNION ALL
      SELECT '%the number of prepared statements per connection cannot exceed%',                        2154870 FROM DUMMY UNION ALL
      SELECT '%Too many waiting transactions%',                                                         2154870 FROM DUMMY UNION ALL
      SELECT '%total size larger than signed 32bit%',                                                   2154870 FROM DUMMY UNION ALL
      SELECT '%Potential performance problem:%',                                                        2158927 FROM DUMMY UNION ALL
      SELECT '%activateObjectsInternalFast2: ActivationID%',                                            2159014 FROM DUMMY UNION ALL
      SELECT '%Activation failed for at least one object%',                                             2159014 FROM DUMMY UNION ALL
      SELECT '%Activator::checkAndHandleRollback, activation ID%',                                      2159014 FROM DUMMY UNION ALL
      SELECT '%alter password required for user%',                                                      2159014 FROM DUMMY UNION ALL
      SELECT '%authentication failed%',                                                                 2159014 FROM DUMMY UNION ALL
      SELECT '%AuthorizationCheckHandler::collectPrivilegesForTableDataSource % Table % not found%',    2159014 FROM DUMMY UNION ALL
      SELECT '%Authorization checks needed to select failed%',                                          2159014 FROM DUMMY UNION ALL
      SELECT '%Authorization error%',                                                                   2159014 FROM DUMMY UNION ALL
      SELECT '%Authorization failed in Calculation Engine.%',                                           2159014 FROM DUMMY UNION ALL
      SELECT '%Commit or rollback in Runtime::generate detected%',                                      2159014 FROM DUMMY UNION ALL
      SELECT '%connect attempt outside user_s validity period%',                                        2159014 FROM DUMMY UNION ALL
      SELECT '%Errors were reported by runtime%runtime %',                                              2159014 FROM DUMMY UNION ALL
      SELECT '%Failed to verify record MAC%',                                                           2159014 FROM DUMMY UNION ALL
      SELECT '%Failed to retrieve PERSISTENCE root key%',                                               2159014 FROM DUMMY UNION ALL
      SELECT '%insufficient privilege%',                                                                2159014 FROM DUMMY UNION ALL
      SELECT '%invalid objectId returned from ObjectManager%',                                          2159014 FROM DUMMY UNION ALL
      SELECT '%Keep authorization error: User%',                                                        2159014 FROM DUMMY UNION ALL
      SELECT '%non recognized substring during parse of authentication methods%',                       2159014 FROM DUMMY UNION ALL
      SELECT '%ot authorized%',                                                                         2159014 FROM DUMMY UNION ALL
      SELECT '%No UserPasswordInfo found for user%',                                                    2159014 FROM DUMMY UNION ALL
      SELECT '%package not known%',                                                                     2159014 FROM DUMMY UNION ALL
      SELECT '%Received an SSL/TLS record of unknown or unexpected type%',                              2159014 FROM DUMMY UNION ALL
      SELECT '%Renegotiation support is not enabled.%',                                                 2159014 FROM DUMMY UNION ALL
      SELECT '%[40109] role % is unknown%',                                                             2159014 FROM DUMMY UNION ALL
      SELECT '%SAML Provider configuration not established%',                                           2159014 FROM DUMMY UNION ALL
      SELECT '%ssl: internal error%',                                                                   2159014 FROM DUMMY UNION ALL
      SELECT '%user % is locked forever%',                                                              2159014 FROM DUMMY UNION ALL
      SELECT '%ser % is missing % privilege%',                                                          2159014 FROM DUMMY UNION ALL
      SELECT '%User % tried to execute%',                                                               2159014 FROM DUMMY UNION ALL
      SELECT '%View, cube, hierarchy view or table cannot be audited since no OID%',                    2159014 FROM DUMMY UNION ALL
      SELECT '%fast recovery:%',                                                                        2159435 FROM DUMMY UNION ALL
      SELECT '%Reattaching RS shared memory%',                                                          2159435 FROM DUMMY UNION ALL
      SELECT '%RS segments loaded in % sec (%MB/s)%',                                                   2159435 FROM DUMMY UNION ALL
      SELECT '%unique constraint violated%',                                                            2160391 FROM DUMMY UNION ALL
      SELECT '[UNIQUENESS VIOLATION]%',                                                                 2160391 FROM DUMMY UNION ALL
      SELECT 'Exeception while removing version from version contextVersion doesn%',                    2169283 FROM DUMMY UNION ALL
      SELECT '%Garbage collection of history files%',                                                   2169283 FROM DUMMY UNION ALL
      SELECT '%Killed long-lived suspended cursor%',                                                    2169283 FROM DUMMY UNION ALL
      SELECT '%Killed long-running idle cursor%',                                                       2169283 FROM DUMMY UNION ALL
      SELECT '%LOB garbage collection time interval is zero%',                                          2169283 FROM DUMMY UNION ALL
      SELECT '%long running cursor detected%',                                                          2169283 FROM DUMMY UNION ALL
      SELECT '%long running external transaction detected%',                                            2169283 FROM DUMMY UNION ALL
      SELECT '%Long running transaction activities detected%',                                          2169283 FROM DUMMY UNION ALL
      SELECT '%long running uncommitted write transaction detected%',                                   2169283 FROM DUMMY UNION ALL
      SELECT '%Maximum garbage collection parallelity set to%',                                         2169283 FROM DUMMY UNION ALL
      SELECT '%MVCC Info HOST =%NUM_VERSIONS =%',                                                       2169283 FROM DUMMY UNION ALL
      SELECT '%Start garbage collection of history files%',                                             2169283 FROM DUMMY UNION ALL
      SELECT '%The Connection%is disconnected forcefully%garbage collection for too long period%',      2169283 FROM DUMMY UNION ALL
      SELECT '%The cursor blocks the garbage collection of the table%',                                 2169283 FROM DUMMY UNION ALL
      SELECT '%The transaction blocks the garbage collection of the table%',                            2169283 FROM DUMMY UNION ALL
      SELECT '%There are too many un-collected versions%',                                              2169283 FROM DUMMY UNION ALL
      SELECT '%Found the following errors:%TypeError:%is undefined%',                                   2169923 FROM DUMMY UNION ALL
      SELECT '%MaxOpenFiles:%',                                                                         2177064 FROM DUMMY UNION ALL
      SELECT '%Preparing for shutting service down%',                                                   2177064 FROM DUMMY UNION ALL
      SELECT '%Server Mode:%',                                                                          2177064 FROM DUMMY UNION ALL
      SELECT '%SIGNAL%(%)%caught%',                                                                     2177064 FROM DUMMY UNION ALL
      SELECT '%Starting hdb%',                                                                          2177064 FROM DUMMY UNION ALL
      SELECT '%Configuration file:% could not be opened.%',                                             2180119 FROM DUMMY UNION ALL
      SELECT '%Exception while getting remote column temp table distinct count%',                       2180119 FROM DUMMY UNION ALL
      SELECT '%invalid remote object name%',                                                            2180119 FROM DUMMY UNION ALL
      SELECT '%ODBC column attr not implemented: 1013%',                                                2180119 FROM DUMMY UNION ALL
      SELECT '%SQLDisconnect() failed %ORA-03113%',                                                     2180119 FROM DUMMY UNION ALL
      SELECT '%Could not create trace records in memory%1000013: error in DATE/TIME conversion%',       2180165 FROM DUMMY UNION ALL
      SELECT '%Did not read [ as first non-whitespace character%',                                      2186744 FROM DUMMY UNION ALL
      SELECT '%force stop detected%',                                                                   2186744 FROM DUMMY UNION ALL
      SELECT '%INI configuration is changed by%',                                                       2186744 FROM DUMMY UNION ALL
      SELECT '%Invalid configuration value%',                                                           2186744 FROM DUMMY UNION ALL
      SELECT '%Parameter parsing error%',                                                               2186744 FROM DUMMY UNION ALL
      SELECT '%%Parameter % contains illegal characters%',                                              2186744 FROM DUMMY UNION ALL
      SELECT '%unknown trace level string%',                                                            2186744 FROM DUMMY UNION ALL
      SELECT '%failed routed execution: failed to prepare external transaction%',                       2200772 FROM DUMMY UNION ALL
      SELECT '%Using log segment size %MB not possible due to buffer size constraint%',                 2215131 FROM DUMMY UNION ALL
      SELECT '%Could not create mid size LOB container%',                                               2220627 FROM DUMMY UNION ALL
      SELECT '%LOB type % is not allowed to be defined in SORT table%',                                 2220627 FROM DUMMY UNION ALL
      SELECT '%Total hybrid LOB size exceeds the limit of%',                                            2220627 FROM DUMMY UNION ALL
      SELECT '%Request ___nsWatchdog_ hit timeout%',                                                    2222110 FROM DUMMY UNION ALL
      SELECT '%A communication error occurred, with the HDB TcpIp Server%',                             2222200 FROM DUMMY UNION ALL
      SELECT '%active channel%',                                                                        2222200 FROM DUMMY UNION ALL
      SELECT '%active SSL channel%',                                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%Address already in use%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%a timeout occured while reading from the channel%',                                      2222200 FROM DUMMY UNION ALL
      SELECT '%an error occured while opening the channel%',                                            2222200 FROM DUMMY UNION ALL
      SELECT '%an error occured while reading from the channel%',                                       2222200 FROM DUMMY UNION ALL
      SELECT '%Bad file descriptor%',                                                                   2222200 FROM DUMMY UNION ALL
      SELECT '%roken pipe%',                                                                            2222200 FROM DUMMY UNION ALL
      SELECT '%buffer still contains % bytes on release of idle SSL channel%',                          2222200 FROM DUMMY UNION ALL
      SELECT '%Cannot assign requested address%',                                                       2222200 FROM DUMMY UNION ALL
      SELECT '%close channel while sending reply message%',                                             2222200 FROM DUMMY UNION ALL
      SELECT '%losing connection finished channel%',                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%losing connection channel, state%',                                                      2222200 FROM DUMMY UNION ALL
      SELECT '%onnection broken%',                                                                      2222200 FROM DUMMY UNION ALL
      SELECT '%onnection from % socket % message%',                                                     2222200 FROM DUMMY UNION ALL
      SELECT '%onnection refused%',                                                                     2222200 FROM DUMMY UNION ALL
      SELECT '%onnection reset by peer%',                                                               2222200 FROM DUMMY UNION ALL
      SELECT '%onnection timed out%',                                                                   2222200 FROM DUMMY UNION ALL
      SELECT '%details: Internal Error. getaddrinfo failed%',                                           2222200 FROM DUMMY UNION ALL
      SELECT '%dump of TrexNet buffer: size%',                                                          2222200 FROM DUMMY UNION ALL
      SELECT '%erroneous channel%',                                                                     2222200 FROM DUMMY UNION ALL
      SELECT '%erroneous SSL channel%',                                                                 2222200 FROM DUMMY UNION ALL
      SELECT '%Error during group-precommit: error code=% timeout=%',                                   2222200 FROM DUMMY UNION ALL
      SELECT '%error in named method (or its remote caller)%',                                          2222200 FROM DUMMY UNION ALL
      SELECT '%error occurred during group%',                                                           2222200 FROM DUMMY UNION ALL
      SELECT '%error occurred during rollback%',                                                        2222200 FROM DUMMY UNION ALL
      SELECT '%exception: peer might have terminated%',                                                 2222200 FROM DUMMY UNION ALL
      SELECT '%exception % TID: % Connection Info: active channel%',                                    2222200 FROM DUMMY UNION ALL
      SELECT '%Error during communication in sending of plan data%',                                    2222200 FROM DUMMY UNION ALL
      SELECT '%Exception caught while trying to close destination%',                                    2222200 FROM DUMMY UNION ALL
      SELECT '%exception in TNSInfo::processRequest%',                                                  2222200 FROM DUMMY UNION ALL
      SELECT '%executor: communication problem%',                                                       2222200 FROM DUMMY UNION ALL
      SELECT '%failed remote communication%',                                                           2222200 FROM DUMMY UNION ALL
      SELECT '%Failed to handle Request%due to timeout%',                                               2222200 FROM DUMMY UNION ALL
      SELECT '%failed to open channel%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%failed to read % bytes%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%failed to resolve %. reason: (internal error)%',                                         2222200 FROM DUMMY UNION ALL
      SELECT '%failed to send % bytes%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%Failed to send cancel request%',                                                         2222200 FROM DUMMY UNION ALL
      SELECT '%failed with NetException%',                                                              2222200 FROM DUMMY UNION ALL
      SELECT '%inishing connection channel%',                                                           2222200 FROM DUMMY UNION ALL
      SELECT '%invalid address%',                                                                       2222200 FROM DUMMY UNION ALL
      SELECT '%invalid forwarding to datacenter%',                                                      2222200 FROM DUMMY UNION ALL
      SELECT '%KeepAlive parameters: TCP_KEEPIDLE=% TCP_KEEPCNT=% TCP_KEEPINTVL=%',                     2222200 FROM DUMMY UNION ALL
      SELECT '%thod % with latency=% and previous method=% has been closed by peer with pid%',          2222200 FROM DUMMY UNION ALL
      SELECT '%Name or service not known%',                                                             2222200 FROM DUMMY UNION ALL
      SELECT '%NetworkChannel::connectBlocking refused%',                                               2222200 FROM DUMMY UNION ALL
      SELECT '%NetworkChannel::receiveRawImp timeout % millisecond/s reached%',                         2222200 FROM DUMMY UNION ALL
      SELECT '%New connection accepted from%',                                                          2222200 FROM DUMMY UNION ALL
      SELECT '%new Request with no or invalid request begin identifier%',                               2222200 FROM DUMMY UNION ALL
      SELECT '%no connection could be made because the target machine actively refused it%',            2222200 FROM DUMMY UNION ALL
      SELECT '%no reachable host left%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%:% not responding.%',                                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%no route to host%',                                                                      2222200 FROM DUMMY UNION ALL
      SELECT '%pingNameServer% takes % seconds. Communication problem or interval % too short%',        2222200 FROM DUMMY UNION ALL
      SELECT '%read from channel failed%',                                                              2222200 FROM DUMMY UNION ALL
      SELECT '%reading failed with timeout error%',                                                     2222200 FROM DUMMY UNION ALL
      SELECT '%Received invalid SSL Record Header%',                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%received unknown protocol identifier % on active channel%',                              2222200 FROM DUMMY UNION ALL
      SELECT '%resetting buffer (timeout occured)%',                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%Socket state not valid%',                                                                2222200 FROM DUMMY UNION ALL
      SELECT '%ssl handshake failed on active SSL channel%',                                            2222200 FROM DUMMY UNION ALL
      SELECT '%SSL initialization or handshake error: Poll timed out%',                                 2222200 FROM DUMMY UNION ALL
      SELECT '%stream: send error%',                                                                    2222200 FROM DUMMY UNION ALL
      SELECT '%emporary failure in name resolution%',                                                   2222200 FROM DUMMY UNION ALL
      SELECT '%TimerThread::TimerCallback for % took longer than expected%',                            2222200 FROM DUMMY UNION ALL
      SELECT '%timed out (Deadline reached)%',                                                          2222200 FROM DUMMY UNION ALL
      SELECT '%Transaction:% rollback failed because volume%',                                          2222200 FROM DUMMY UNION ALL
      SELECT '%Unexpected end of backup, expected amount of data is%',                                  2222200 FROM DUMMY UNION ALL
      SELECT '%unexpected error with unknown peer name%',                                               2222200 FROM DUMMY UNION ALL
      SELECT '%Unexpected stream close%',                                                               2222200 FROM DUMMY UNION ALL
      SELECT '%unknown host%',                                                                          2222200 FROM DUMMY UNION ALL
      SELECT '%was closed because of invalid packet length%',                                           2222200 FROM DUMMY UNION ALL
      SELECT '%write failed (peer dead% invalidating channel%',                                         2222200 FROM DUMMY UNION ALL
      SELECT '%writing failed with rc=8 (internal error)%',                                             2222200 FROM DUMMY UNION ALL
      SELECT '%wrong type unsupported found in channel while cleaning up%',                             2222200 FROM DUMMY UNION ALL
      SELECT '%All Index rebuilding time%',                                                             2222217 FROM DUMMY UNION ALL
      SELECT '%allocate % segments requested to load and collect information about superblocks%',       2222217 FROM DUMMY UNION ALL
      SELECT '%Checking rowstore consistency.%',                                                        2222217 FROM DUMMY UNION ALL
      SELECT '%collecting information done in%',                                                        2222217 FROM DUMMY UNION ALL
      SELECT '%Consistency check time:%',                                                               2222217 FROM DUMMY UNION ALL
      SELECT '%ContainerNameDirectory loaded%',                                                         2222217 FROM DUMMY UNION ALL
      SELECT '%Finished table reloading%',                                                              2222217 FROM DUMMY UNION ALL
      SELECT '%Initialize LOB owner statistics from%',                                                  2222217 FROM DUMMY UNION ALL
      SELECT '%Initialize% transient structures%',                                                      2222217 FROM DUMMY UNION ALL
      SELECT '%Initialize VirtualFile statistics%',                                                     2222217 FROM DUMMY UNION ALL
      SELECT '%Load ContainerNameDirectory%',                                                           2222217 FROM DUMMY UNION ALL
      SELECT '%Loading % file ID mappings finished in%',                                                2222217 FROM DUMMY UNION ALL
      SELECT '%Loading % open session(s) and % history cleanup file(s) finished in%',                   2222217 FROM DUMMY UNION ALL
      SELECT '%Loading RowStore segments from Persistency%',                                            2222217 FROM DUMMY UNION ALL
      SELECT '%LOB owner statistics initialized from%',                                                 2222217 FROM DUMMY UNION ALL
      SELECT '%Now reloading%',                                                                         2222217 FROM DUMMY UNION ALL
      SELECT '%Performing size-based table reordering during table reloading%',                         2222217 FROM DUMMY UNION ALL
      SELECT '%PersistenceManager::setState(InRestart)%',                                               2222217 FROM DUMMY UNION ALL
      SELECT '%Reattaching RS shared memory%',                                                          2222217 FROM DUMMY UNION ALL
      SELECT '%Replayed % of log in % seconds% max known TID=%',                                        2222217 FROM DUMMY UNION ALL
      SELECT '%RS segments loaded%',                                                                    2222217 FROM DUMMY UNION ALL
      SELECT '%RS uncommitted version construction finished%',                                          2222217 FROM DUMMY UNION ALL
      SELECT '%Size-based table reordering done%',                                                      2222217 FROM DUMMY UNION ALL
      SELECT '%Starting reloading column store tables based on previous load information%',             2222217 FROM DUMMY UNION ALL
      SELECT '%Start loading open sessions and history cleanup files%',                                 2222217 FROM DUMMY UNION ALL
      SELECT '%start the SQL listening port%',                                                          2222217 FROM DUMMY UNION ALL
      SELECT '%Termination of indoubt transactions%',                                                   2222217 FROM DUMMY UNION ALL
      SELECT '%Termination of rollback(s) open in restart/backup savepoint%',                           2222217 FROM DUMMY UNION ALL
      SELECT '%Triggering log recovery up to position%',                                                2222217 FROM DUMMY UNION ALL
      SELECT '%VirtualFile LOB statistics initialized%',                                                2222217 FROM DUMMY UNION ALL
      SELECT '%VirtualFile statistics initialized%',                                                    2222217 FROM DUMMY UNION ALL
      SELECT '%start rsutil: --start  --port%',                                                         2222217 FROM DUMMY UNION ALL
      SELECT '%Execute hdbcons command%',                                                               2222218 FROM DUMMY UNION ALL
      SELECT '%Application for this process will only work with%hdbcons%%',                             2222218 FROM DUMMY UNION ALL
      SELECT '%(% external command)%%',                                                                 2222218 FROM DUMMY UNION ALL
      SELECT '%Unable to create socket for name%',                                                      2222218 FROM DUMMY UNION ALL
      SELECT '%AdmissionControl: error in collecting stat%',                                            2222250 FROM DUMMY UNION ALL
      SELECT '%statistics collection is not finished%',                                                 2222250 FROM DUMMY UNION ALL
      SELECT '%[WorkloadClassCache %] ignore mapping 5. cannot find workload class%',                   2222250 FROM DUMMY UNION ALL
      SELECT '%error in PtimeException construction%',                                                  2222277 FROM DUMMY UNION ALL
      SELECT '%Giving up to collect stat of CPB+-tree index%',                                          2222277 FROM DUMMY UNION ALL
      SELECT '%importBinaryRawForColumnTable has failed%',                                              2222277 FROM DUMMY UNION ALL
      SELECT '%Import has failed during checking its feasibility%',                                     2222277 FROM DUMMY UNION ALL
      SELECT '%Invalid column store version match%',                                                    2222277 FROM DUMMY UNION ALL
      SELECT '%failed in insert custom plan%',                                                          2222321 FROM DUMMY UNION ALL
      SELECT '%6934: not enough or too many operands for attribute search operator%',                   2276838 FROM DUMMY UNION ALL
      SELECT '%failed to retrieve local session context%',                                              2287190 FROM DUMMY UNION ALL
      SELECT '%no connection on volume%',                                                               2287190 FROM DUMMY UNION ALL
      SELECT '%Backint did not respond for%',                                                           2290067 FROM DUMMY UNION ALL
      SELECT '%Error while reading from SAP Logon TrustStore%',                                         2311047 FROM DUMMY UNION ALL
      SELECT '%SSL handshake failed%',                                                                  2312071 FROM DUMMY UNION ALL
      SELECT '%%[thr=%]: % at%',                                                                        2313619 FROM DUMMY UNION ALL
      SELECT '%exception throw location:%',                                                             2313619 FROM DUMMY UNION ALL
      SELECT '%exception type information:%',                                                           2313619 FROM DUMMY UNION ALL
      SELECT '%- 0: public ltt::exception@%',                                                           2313619 FROM DUMMY UNION ALL
      SELECT '%: 0x% in %%',                                                                            2313619 FROM DUMMY UNION ALL
      SELECT '%NO exception throw location recorded. Stack generation suppressed.%',                    2313619 FROM DUMMY UNION ALL
      SELECT '%Using _x64_64 ABI unwind_ for stack tracing%',                                           2313619 FROM DUMMY UNION ALL
      SELECT '%Repository: Package not found%',                                                         2317677 FROM DUMMY UNION ALL
      SELECT '%Could not resolve replica node from the given turn off request%',                        2340450 FROM DUMMY UNION ALL
      SELECT 'Replica Synchronizer:%',                                                                  2340450 FROM DUMMY UNION ALL
      SELECT '%[Send RepLog] exception thrown: internal error%',                                        2340450 FROM DUMMY UNION ALL
      SELECT '%TURN_OFF_REPLICATION%EXCEPTION%',                                                        2340450 FROM DUMMY UNION ALL
      SELECT '%turnOffAsyncReplication%EXCEPTION%',                                                     2340450 FROM DUMMY UNION ALL
      SELECT '%turnOnAsyncReplication is%',                                                             2340450 FROM DUMMY UNION ALL
      SELECT '%turn on auto reactivation%',                                                             2340450 FROM DUMMY UNION ALL
      SELECT '%ESH_SEARCH error:%',                                                                     2347563 FROM DUMMY UNION ALL
      SELECT '%failed to remove RS lob garbage file%',                                                  2351467 FROM DUMMY UNION ALL
      SELECT '%Child process deletes daemon port%',                                                     2358255 FROM DUMMY UNION ALL
      SELECT '%Changing environment %set%',                                                             2358255 FROM DUMMY UNION ALL
      SELECT '%rc=6931%',                                                                               2361364 FROM DUMMY UNION ALL
      SELECT '%attribute value is not a date or wrong syntax%',                                         2361364 FROM DUMMY UNION ALL
      SELECT '%due to too old persistence format%',                                                     2372809 FROM DUMMY UNION ALL
      SELECT '%Delta log migration failed, for further details please refer%',                          2372809 FROM DUMMY UNION ALL
      SELECT '- dump:%0x%',                                                                             2380176 FROM DUMMY UNION ALL
      SELECT '1:n check failed%',                                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%1299%no data found%',                                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%===== END OF SESSION DUMP =====%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%===== START OF SESSION DUMP =====%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%(newdb codec, tx flags) action type:%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%ACTION       :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%CHANNEL      :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%CLIENT       :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%DISTRIBUTION :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%PROTOCOL     :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%ROUTING      :%',                                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%42208%Can%t read the view%',                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%42474%The view doesn%t contain the measure%',                                            2380176 FROM DUMMY UNION ALL
      SELECT '%42535%The member is already defined%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%42567%Error during formula evaluation%',                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%A connection with the same anchor connection id already exists%',                        2380176 FROM DUMMY UNION ALL
      SELECT '%add participant failed: tid%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Adjusting column byte length % for multi bytes string column for type%',                 2380176 FROM DUMMY UNION ALL
      SELECT '%All errors were written to _SYS_TASK.CREATE_TASK_MESSAGES%',                             2380176 FROM DUMMY UNION ALL
      SELECT '%All response attributes require a 1:1 relation%',                                        2380176 FROM DUMMY UNION ALL
      SELECT 'All services are fully operational',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%anchor conn id mismatch between session%',                                               2380176 FROM DUMMY UNION ALL
      SELECT '%anchor to connection relation already exists%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%An unsupported mechanism was requested%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%are special character in SQL LIKE%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Assertion failed: %Result size changed in read part%',                                   2380176 FROM DUMMY UNION ALL
      SELECT '%assertion failure at %, condition=part.isValid()%',                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Assigned value for parameter or variable % exceeds maximum length%',                     2380176 FROM DUMMY UNION ALL
      SELECT '%assign to volume % finished%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Attribute engine failed%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%attribute value is not a number%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%AvcLifecycleConfig:%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%bind values:%',                                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%calcToQo: expression conversion failed%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%CalcEngine Exception: exception 306002: An internal error occurred%',                    2380176 FROM DUMMY UNION ALL
      SELECT '%CalcEngine Exception: exception 306105: Invalid query%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Calc scenario % not found%',                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%calculateSingleThreaded plan % failed with rc%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Calculation scenario % not valid%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Calc view % could not be resolved or does not exist on this server%',                    2380176 FROM DUMMY UNION ALL
      SELECT '%Cannot access UT container for container ID%',                                           2380176 FROM DUMMY UNION ALL
      SELECT '%cannot convert % to the type % for column%',                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Cannot establish JDBC connection%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Cannot lock invalidated session%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Cannot resolve data input variable%',                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%can_t get field for idx%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%Can_t serialize response%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT '%cannot insert NULL or update to NULL%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Can not insert TempTable%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT '%catalog lookup failed%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Child process %exited%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%ChunkWise Insert-subSelect error: internal error%',                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Column view not found%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%command % with result [%] in PLE session % failed%',                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Condition % failed. expecting an entry in the command queue%',                           2380176 FROM DUMMY UNION ALL
      SELECT '%CONNECTION_ID = % HOST = % TRANSACTION_ID = % IS_SYNC_REP_TRANS =%',                     2380176 FROM DUMMY UNION ALL
      SELECT '%content of planData%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%context % already waiting for %, can not be waiting for%',                               2380176 FROM DUMMY UNION ALL
      SELECT '%convert queryEntry to FreestyleQuery%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Could not create value statistic for attribute%',                                        2380176 FROM DUMMY UNION ALL
      SELECT '%Could not find attribute% in calculation scenario%',                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Could not find function or procedure%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%could not find %in indexInfoMap%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Could not find referenced scenario: Scenario name is empty%',                            2380176 FROM DUMMY UNION ALL
      SELECT '%Could not resolve scenario name from calculation view%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Create Scenario: failed, printing XML%',                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%CSDDLWrapperImpl::getCalcScenarioForCalcView: not calc index%',                          2380176 FROM DUMMY UNION ALL
      SELECT '%current indexInfoMap content%',                                                          2380176 FROM DUMMY UNION ALL
      SELECT 'Daemon client network connection unprotected%',                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Daemon state "running", runlevels%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Database Mismatch: Got token with invalid database%',                                    2380176 FROM DUMMY UNION ALL
      SELECT '%data stream invalid, could not find valid leading eyecatcher%',                          2380176 FROM DUMMY UNION ALL
      SELECT '%deleteCurrentToidByName: not found toid.%',                                              2380176 FROM DUMMY UNION ALL
      SELECT '%Deploy Calculation View: failed%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%DI received notification with malformed location string%',                               2380176 FROM DUMMY UNION ALL 
      SELECT '%docIdSearch failed for % index with%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Dumping current session before closing automatically%',                                  2380176 FROM DUMMY UNION ALL
      SELECT 'dumping metadata for%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%ERROR: assertion failed % replay failed%',                                               2380176 FROM DUMMY UNION ALL
      SELECT '%error = 6944%',                                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Error during converting SqlAPs to Query entries%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Error during Plan execution of model%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Error during sql statement compilation for sql operation node%',                         2380176 FROM DUMMY UNION ALL
      SELECT '%Error executing "sldreg%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%error getting expression results%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Error: has no element at given xpath%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%error in creating join index%',                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%error reading file%',                                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%Error storing license measurement%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Error validating the calculation scenario sources%',                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Error when trying to fetch scalar value from Calculation Scenario%',                     2380176 FROM DUMMY UNION ALL
      SELECT '%Error while obtaining memory usage for services with query%',                            2380176 FROM DUMMY UNION ALL
      SELECT '%error with message:%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Error(s) parsing the Task Plan XML%',                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%ESHException in serialize%',                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%ESH_SEARCH URI:%',                                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%estimateParallel failed rc=%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '--event not handled:%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Exception in PtimeInfo%not supported function%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Exception raised at ptime/query/plan_executor/trex_wrapper%',                            2380176 FROM DUMMY UNION ALL
      SELECT '%exception %6944%',                                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%exception 9620355: 1:n detected%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%exec estimation failed%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%execution flow must not reach here%',                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%Expression may not be converted to query entries%',                                      2380176 FROM DUMMY UNION ALL
      SELECT '%External Command Listener is disabled.%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Failed sync point with respect to last historization.%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Fail to absorb c2c converter because child phys op is inappropriate%',                   2380176 FROM DUMMY UNION ALL
      SELECT '%Fail to absorb r2c converter because constant false filter exists%',                     2380176 FROM DUMMY UNION ALL
      SELECT '%failed to assign partition%',                                                            2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to buildNode%',                                                                   2380176 FROM DUMMY UNION ALL	
      SELECT '%failed to build QE lookup table for fems number%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to cleanup side-effect task data - exception%',                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to close $.db.Connection%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%failed to encode cursor: error while parsing protocol%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to execute stmt=%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to find temp table%',                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%failed to find term location for predicate query entry%',                                2380176 FROM DUMMY UNION ALL
      SELECT '%ailed to get %CalcIndex%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%failed to open index % 6906%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to recompile procedure%',                                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to retrieve connection%',                                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Failed to serialize search result%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%failed with error 7 for base64 encoded passport%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%failed with return code 6930%',                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%failed with return code 6931%',                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%fatal error in a nested statement%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%feature not supported%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Finished processing Slave_GetMasterLogPos%',                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Found realtime inconsistency during initial calibration of the node%',                   2380176 FROM DUMMY UNION ALL
      SELECT '%Found runtime object % for designtime object%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Function sequence error%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%general error%1999%',                                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%getColumnsStats: unknown table metadata%',                                               2380176 FROM DUMMY UNION ALL
      SELECT '%gnav requested but no gnav attributes specified%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%HANA timer adjusts time speed%',                                                         2380176 FROM DUMMY UNION ALL
      SELECT '%HANDLE: DISPATCH - Processing of % document(s) failed, last failed document key%',       2380176 FROM DUMMY UNION ALL
      SELECT '--handleEvent:%',                                                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Have invalid table for%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Inconsistent calculation model%',                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%Index Id: %, replay of log failed%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Initial poll for INCREMENT_TIMESTAMP request succeeded from previous state unset%',      2380176 FROM DUMMY UNION ALL
      SELECT '%Inputs of failed pop%',                                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Input table type doesn_t match exactly%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%inserted value too large for column%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Invalidate the session % due to an exception%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Invalid call to drop index_ location of index unknown%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%invalid DATE, TIME or TIMESTAMP value%',                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%invalid hexadecimal data detected in query table on column%',                            2380176 FROM DUMMY UNION ALL
      SELECT '%invalid name of function or procedure%',                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%invalid number: not a valid number string %Could not derive table type for variable%',   2380176 FROM DUMMY UNION ALL
      SELECT '%invalid oabapstream pointer%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%invalid object name%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%invalid query name:%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%invalid table name%',                                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%nvalid transaction state%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT '%jobex watchdog hasn_t run for more than%',                                               2380176 FROM DUMMY UNION ALL
      SELECT '%LDAP search failed, error code:%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Leaving wait state with return code%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%lhs: 6944%',                                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Llang Runtime Error: Exception::InternalNonFatal%',                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Message "%". Daemon pid %. Child pid%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Message "%". Received % bytes%',                                                         2380176 FROM DUMMY UNION ALL
      SELECT 'Metamodel for%',                                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%MGetEstimations failed for query%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%misses key propert% and will not be reported%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Model instantiation failed during the instantiation of node%',                           2380176 FROM DUMMY UNION ALL
      SELECT '%more columns selected than referenced in itab%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%No encryption config control setting, return default value%',                            2380176 FROM DUMMY UNION ALL
      SELECT '%normalizeFilter: unexpected stack size%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Not allowed path is given for%',                                                         2380176 FROM DUMMY UNION ALL
      SELECT '%Not a valid hierarchy as at least one IndexAliasOperation is incorrect%',                2380176 FROM DUMMY UNION ALL
      SELECT '%not found in input table%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT '%No transaction extension found for markCrossDBUse call.%',                               2380176 FROM DUMMY UNION ALL
      SELECT '%numeric overflow%',                                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%object_s export location % exists. Force flag not set, so abort!%',                      2380176 FROM DUMMY UNION ALL
      SELECT '%ODBC error: %connected:%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%OmsTerminate%',                                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Opening new log segment%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%Optimizer::extendQueryEntriesWithConstantEvaluation: %call returned with exception',     2380176 FROM DUMMY UNION ALL
      SELECT '%utput source%was not found in the catalog%',                                             2380176 FROM DUMMY UNION ALL
      SELECT '%overflow in numeric calculation%',                                                       2380176 FROM DUMMY UNION ALL
      SELECT 'param%:end',                                                                              2380176 FROM DUMMY UNION ALL
      SELECT 'paramSetNo: %',                                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Parsing object id failed for object%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%partitioned execution scopes detected in view%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%planData %: JEPlanData%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%plan operation failed%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Please check enable_ssl parameter settings on all sites%',                               2380176 FROM DUMMY UNION ALL
      SELECT '%prepare: Invalid calculation scenario handle%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%process(): Error in Document, theProcessResult was set to%',                             2380176 FROM DUMMY UNION ALL
      SELECT '%Process % exited normally with status 0%',                                               2380176 FROM DUMMY UNION ALL
      SELECT '%Process % should be alive, but does not respond%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%Processing Slave_GetMasterLogPos for volume%',                                           2380176 FROM DUMMY UNION ALL
      SELECT 'Process % was not found%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Protocol/unsupported/request begin identifier is invalid%',                              2380176 FROM DUMMY UNION ALL
      SELECT '%QueryMediator failed executing query, % Invalid result estimation%',                     2380176 FROM DUMMY UNION ALL
      SELECT '%rc = 2626, executor timeout%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%rc_6900%',                                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%rc_6930%',                                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%rc_6944%',                                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%error = 6946%',                                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%rc_6946%',                                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%Read initial topology, active logical cores are%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%) received msg:%',                                                                       2380176 FROM DUMMY UNION ALL
      SELECT '%recommended number of segment >= (total memory/64MB)*2%',                                2380176 FROM DUMMY UNION ALL
      SELECT '%Reference cannot be calculated: wrong reference format%',                                2380176 FROM DUMMY UNION ALL
      SELECT '%registerTable failed: unknown table tableId%',                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Reinitialized timezone / timezone offset from % to %',                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Remote export failed: export size exceeds%',                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Removing files failed with%',                                                            2380176 FROM DUMMY UNION ALL
      SELECT '%Repository: delivery unit not found%',                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Repository: Encountered an unexpected exception%',                                       2380176 FROM DUMMY UNION ALL
      SELECT '%retry failed because stmt is not retriable%',                                            2380176 FROM DUMMY UNION ALL
      SELECT '%return code 6944%',                                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Root qo_project col count is different as expected%',                                    2380176 FROM DUMMY UNION ALL
      SELECT '%rowid lookup failed%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%Running with non-serializable transaction mode%',                                        2380176 FROM DUMMY UNION ALL
      SELECT '%runPopTask(): plan data for input is null while trying to call setIsShared()%',          2380176 FROM DUMMY UNION ALL
      SELECT '%SAP_IdenticalDatabaseSystem relation with identical sldvirtdbhome and sldsystemhome%',   2380176 FROM DUMMY UNION ALL
      SELECT '%SAP_IdenticalDatabaseSystem relation without % logical database hostname%',              2380176 FROM DUMMY UNION ALL
      SELECT 'Scenario%onsistencyCheck:%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT 'Scenario%cyclicDependencyCheck:%',                                                        2380176 FROM DUMMY UNION ALL
      SELECT '%Scenario % not loaded%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%search_table_search returned rc=%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Search with QueryId % failed%',                                                          2380176 FROM DUMMY UNION ALL
      SELECT '%Serializing instructions for microtimer turned off%',                                    2380176 FROM DUMMY UNION ALL
      SELECT '%session will be closed due to the unexpected exception: error while parsing protocol%',  2380176 FROM DUMMY UNION ALL
      SELECT '%Set Schema DDL statement: set schema%',                                                  2380176 FROM DUMMY UNION ALL
      SELECT '%Shared memory updated, no daemon state change%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%simple result calculation with docids failed%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%single-row query returns more than one row%',                                            2380176 FROM DUMMY UNION ALL
      SELECT '%snippet/highlighed attribute % is neither of type TEXT nor has a fulltext index%',       2380176 FROM DUMMY UNION ALL
      SELECT '%Specified trace level None for trace topic%',                                            2380176 FROM DUMMY UNION ALL
      SELECT '%SQL error with unexpected statement status%',                                            2380176 FROM DUMMY UNION ALL
      SELECT '%SSL setting mismatch between local and peer site%',                                      2380176 FROM DUMMY UNION ALL
      SELECT '%sql syntax error%',                                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%Stop listening for connections on%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Successfully sending encrypted request%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Temporarily resolve the mismatch by upgrading the connection to use SSL%',               2380176 FROM DUMMY UNION ALL
      SELECT '%Please check enable_ssl parameter settings on all sites%',                               2380176 FROM DUMMY UNION ALL
      SELECT '%Text analysis error%',                                                                   2380176 FROM DUMMY UNION ALL
      SELECT '%The calibration is too imprecise, will try again later%',                                2380176 FROM DUMMY UNION ALL
      SELECT '%The executable % is symlink%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%this operation is not implemented for this attribute type%',                             2380176 FROM DUMMY UNION ALL
      SELECT 'Timeouts for%',                                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%Topology change detected%',                                                              2380176 FROM DUMMY UNION ALL
      SELECT '%Transaction << % is now being% used by thread%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%transaction order error%',                                                               2380176 FROM DUMMY UNION ALL
      SELECT '%transaction rolled back by an internal error%',                                          2380176 FROM DUMMY UNION ALL
      SELECT '%transaction serialization failure%',                                                     2380176 FROM DUMMY UNION ALL
      SELECT '%138%serialization failure%',                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%TRex exception thrown: % from ptimeOp%',                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Trying to remove non-existing dependency ObjectId%',                                     2380176 FROM DUMMY UNION ALL
      SELECT '%type of variable % not specified%',                                                      2380176 FROM DUMMY UNION ALL
      SELECT '%unable to get idle connection time from anchor_connid%',                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Unable to stop our plan % after % attempts. First error was %. Giving up...%',           2380176 FROM DUMMY UNION ALL
      SELECT '%unable to update idle connection time due to invalid%',                                  2380176 FROM DUMMY UNION ALL
      SELECT '%unbound parameter : % of %, % out of % batches%',                                        2380176 FROM DUMMY UNION ALL
      SELECT '%unhandled ltt exception was caught: % error=%%',                                         2380176 FROM DUMMY UNION ALL
      SELECT '%uniqueIdInserted.second%Correlation id is%',                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Unknown DML restriction state detected%',                                                2380176 FROM DUMMY UNION ALL
      SELECT '%unknown lastDocid for value%',                                                           2380176 FROM DUMMY UNION ALL
      SELECT '%unknown padding value%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%unknown reserved value%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%unknown statement id (%',                                                                2380176 FROM DUMMY UNION ALL
      SELECT '%Unsupported language:%',                                                                 2380176 FROM DUMMY UNION ALL
      SELECT '%Unsupported or missing view for data source%',                                           2380176 FROM DUMMY UNION ALL
      SELECT '%UserName=%',                                                                             2380176 FROM DUMMY UNION ALL
      SELECT '%Using only dynamic symbol table for symbols of ELF file%',                               2380176 FROM DUMMY UNION ALL
      SELECT '%VariableUtils::fetchProcedureVariableData: SQL Statement:%',                             2380176 FROM DUMMY UNION ALL
      SELECT '%view attribute already exists with attribute name%',                                     2380176 FROM DUMMY UNION ALL
      SELECT '%Write to IO failed%',                                                                    2380176 FROM DUMMY UNION ALL
      SELECT '%A downward catalog migration from%is not supported%',                                    2380652 FROM DUMMY UNION ALL
      SELECT '%cannot close a stream socket: associated object=%',                                      2385992 FROM DUMMY UNION ALL
      SELECT '%cannot establish session because the initial communication timeout was reached%',        2385992 FROM DUMMY UNION ALL
      SELECT '%liveCache DbpError -28514%',                                                             2392715 FROM DUMMY UNION ALL
      SELECT '%OmsVersion max_version_retention time reached%',                                         2392715 FROM DUMMY UNION ALL
      SELECT '%expressionToQueryEntries failed to convert%',                                            2394478 FROM DUMMY UNION ALL
      SELECT '%Evaluator: syntax error in expression string_expected%',                                 2394478 FROM DUMMY UNION ALL
      SELECT '%transaction distribution work failure%',                                                 2399990 FROM DUMMY UNION ALL
      SELECT 'DataVolumeTouchPagesJob: %',                                                              2400005 FROM DUMMY UNION ALL
      SELECT 'DVolPart::%',                                                                             2400005 FROM DUMMY UNION ALL
      SELECT '%loadContainerDirectories%',                                                              2400005 FROM DUMMY UNION ALL
      SELECT '%More than one DataVolume Partition path found%',                                         2400005 FROM DUMMY UNION ALL
      SELECT '%prefetchContainerPages: do nothing, no valid ContainerID provided!%',                    2400005 FROM DUMMY UNION ALL
      SELECT 'Reclaim[%',                                                                               2400005 FROM DUMMY UNION ALL
      SELECT 'Reclaiming datavolume partition % can result in heavy IO load and long running time!',    2400005 FROM DUMMY UNION ALL
      SELECT 'Shrink DataVolume to % of payload size',                                                  2400005 FROM DUMMY UNION ALL
      SELECT '%triggerTouchJob: skipping this and % next runs%',                                        2400005 FROM DUMMY UNION ALL
      SELECT '%Execute a runtime dump for _og%hipping%imeout%',                                         2400007 FROM DUMMY UNION ALL
      SELECT '%Runtimedump is skipped because last runtimedump was written%',                           2400007 FROM DUMMY UNION ALL
      SELECT '%Adapter validation failed%',                                                             2400022 FROM DUMMY UNION ALL
      SELECT '%Clear message events for session%',                                                      2400022 FROM DUMMY UNION ALL
      SELECT '%Could not find any active agent for the agent group%',                                   2400022 FROM DUMMY UNION ALL
      SELECT '%DPAdapterAccess::createSessionId: failed with error: Request timed out.%',               2400022 FROM DUMMY UNION ALL
      SELECT '%Error occurred when getting next row from ResultSet%',                                   2400022 FROM DUMMY UNION ALL
      SELECT '%exception%155001%',                                                                      2400022 FROM DUMMY UNION ALL
      SELECT '%exception%151044%Agent "%" is not available.%',                                          2400022 FROM DUMMY UNION ALL
      SELECT '%Exception in getting data for M_REMOTE_SUBSCRIPTIONS%Failed to get runtime meta data%',  2400022 FROM DUMMY UNION ALL
      SELECT '%Exceptions exist for remote source%',                                                    2400022 FROM DUMMY UNION ALL
      SELECT '%Failed to find an agent to fail over from%',                                             2400022 FROM DUMMY UNION ALL
      SELECT '%Failed to start subscription%',                                                          2400022 FROM DUMMY UNION ALL
      SELECT '%failed with error: Prefetch timed out.%',                                                2400022 FROM DUMMY UNION ALL
      SELECT '%Meta data not found for remote source ID =%',                                            2400022 FROM DUMMY UNION ALL
      SELECT '%Network Adapter could not establish the connection%',                                    2400022 FROM DUMMY UNION ALL
      SELECT '%Operation Failed: Data provisioning server is busy. Please wait.%',                      2400022 FROM DUMMY UNION ALL
      SELECT '%Prefetch(%): Idle for too long, halting prefetch.%',                                     2400022 FROM DUMMY UNION ALL
      SELECT '%Remote source is down!%',                                                                2400022 FROM DUMMY UNION ALL
      SELECT '%Replication subsystem is initializing for remote source%',                               2400022 FROM DUMMY UNION ALL
      SELECT '%Replication task activation error with SQLException%',                                   2400022 FROM DUMMY UNION ALL
      SELECT '%Runtime data is not accessible under LogReplayReadAccess operation mode.%',              2400022 FROM DUMMY UNION ALL
      SELECT '%::sendMessage: Prefetch timed out.%',                                                    2400022 FROM DUMMY UNION ALL
      SELECT '%::sendMessage: Request timed out.%',                                                     2400022 FROM DUMMY UNION ALL
      SELECT '%::sendMessage: Session ID has expired%',                                                 2400022 FROM DUMMY UNION ALL
      SELECT '%Shutting down agent %, too many failed pings.%',                                         2400022 FROM DUMMY UNION ALL
      SELECT '%Test connect failed with errorCode%',                                                    2400022 FROM DUMMY UNION ALL
      SELECT '%The conversion of the nvarchar value % overflowed an int column%',                       2400022 FROM DUMMY UNION ALL
      SELECT '%Everything is removed from persistence for the remote source%',                          2400022 FROM DUMMY UNION ALL
      SELECT '%find% column%in input itab%',                                                            2413040 FROM DUMMY UNION ALL
      SELECT '%Assertion failed: %All join types must be the same%',                                    2413854 FROM DUMMY UNION ALL
      SELECT '%BadParam//channel not in list%',                                                         2427296 FROM DUMMY UNION ALL
      SELECT '%No plugin found for license product%',                                                   2445080 FROM DUMMY UNION ALL
      SELECT '%No valid measurement could be obtained for HANA after retry%',                           2445080 FROM DUMMY UNION ALL
      SELECT '%string is too long exception%',                                                          2457876 FROM DUMMY UNION ALL
      SELECT '%Could not obtain all relevant analytical privileges%Invalid SQL AP definition%',         2462871 FROM DUMMY UNION ALL
      SELECT '%Failed to obtain analytical privilege definition%Invalid SQL AP definition%',            2462871 FROM DUMMY UNION ALL
      SELECT '%libnuma: Error: mbind: Invalid argument%',                                               2470289 FROM DUMMY UNION ALL
      SELECT '%No output exp found from input to output mapfinalAggregation%',                          2471313 FROM DUMMY UNION ALL
      SELECT '%dubious configuration detected, switching to single numa node mode%',                    2472783 FROM DUMMY UNION ALL
      SELECT '%Cannot resolve data input variable%',                                                    2474668 FROM DUMMY UNION ALL
      SELECT '%Uncollected exec stats%',                                                                2475609 FROM DUMMY UNION ALL
      SELECT '%Cannot PROCESS REMOTE SUBSCRIPTION EXCEPTION%',                                          2476155 FROM DUMMY UNION ALL
      SELECT '%Instance count %. Searching for terminated processes%',                                  2477204 FROM DUMMY UNION ALL
      SELECT '%Process %, pid % is alive%',                                                             2477204 FROM DUMMY UNION ALL
      SELECT '%invalid character encoding%',                                                            2478767 FROM DUMMY UNION ALL
      SELECT '%Not all data could be written%',                                                         2484702 FROM DUMMY UNION ALL
      SELECT '%drGetServers: incompatible version%',                                                    2485391 FROM DUMMY UNION ALL
      SELECT '%Inconsistency found between Metadata and Object Dependency Table%',                      2498587 FROM DUMMY UNION ALL
      SELECT '%entitycache insert unsuccessful%',                                                       2502256 FROM DUMMY UNION ALL
      SELECT '%Backint process % not found in process list!%',                                          2506137 FROM DUMMY UNION ALL
      SELECT '%user-defined error exception%',                                                          2508932 FROM DUMMY UNION ALL
      SELECT '%There is neither a default value nor a data input mapping%2525644%',                     2525644 FROM DUMMY UNION ALL
      SELECT '%Assertion authentication for user%',                                                     2528123 FROM DUMMY UNION ALL
      SELECT '%SldReg config file missing%',                                                            2533657 FROM DUMMY UNION ALL
      SELECT '%invalid schema name%',                                                                   2535951 FROM DUMMY UNION ALL
      SELECT '%failed to send listPlan request%',                                                       2546137 FROM DUMMY UNION ALL
      SELECT '%no internal interface found%',                                                           2555969 FROM DUMMY UNION ALL
      SELECT '%CompileServerNotFoundException%',                                                        2570371 FROM DUMMY UNION ALL
      SELECT '%Failed to open distributed plan%',                                                       2570371 FROM DUMMY UNION ALL
      SELECT '%Failed to open plan fragment%',                                                          2570371 FROM DUMMY UNION ALL
      SELECT '%Send failure message to%',                                                               2570371 FROM DUMMY UNION ALL
      SELECT '%Insert into column[%] failed%Num fetch thread%M_SERVICE_THREAD_SAMPLES%',                2570661 FROM DUMMY UNION ALL
      SELECT '%[allocator contains%blocks, in total%]%',                                                2580435 FROM DUMMY UNION ALL
      SELECT '%Block list (including suballocators)%',                                                  2580435 FROM DUMMY UNION ALL
      SELECT '%Destroying allocator %Connection/%/Pool/RowEngine/Session%',                             2580435 FROM DUMMY UNION ALL
      SELECT '%In-use block%alloc Pool/RowEngine/Session%',                                             2580435 FROM DUMMY UNION ALL
      SELECT '%Could not get template scenario % from ceManager%',                                      2580778 FROM DUMMY UNION ALL
      SELECT '%to access metadata of an invalid address%',                                              2581110 FROM DUMMY UNION ALL
      SELECT '%plan terminated internally after being inactive for too long%',                          2584706 FROM DUMMY UNION ALL
      SELECT '%failed to open attribute%6915%',                                                         2588119 FROM DUMMY UNION ALL
      SELECT '%[600] failed routed execution%',                                                         2591281 FROM DUMMY UNION ALL
      SELECT '%outed connection is opened at the same node with anchor%',                               2591281 FROM DUMMY UNION ALL
      SELECT '%abap communication failure was detected%',                                               2593571 FROM DUMMY UNION ALL
      SELECT '%assertion failed when receiving abap stream%',                                           2593571 FROM DUMMY UNION ALL
      SELECT '%Bad Allocation exception%',                                                              2593571 FROM DUMMY UNION ALL
      SELECT '%BAD_ALLOCATION error in%',                                                               2593571 FROM DUMMY UNION ALL
      SELECT '%DbpError% -28000%',                                                                      2593571 FROM DUMMY UNION ALL
      SELECT '%DbpError exception occurred without SessionGlobals registered%',                         2593571 FROM DUMMY UNION ALL
      SELECT '%ERROR -1028000%',                                                                        2593571 FROM DUMMY UNION ALL
      SELECT '%liveCache ERROR 16901%',                                                                 2593571 FROM DUMMY UNION ALL
      SELECT '%OmsHandle::omsTerminate %in method%',                                                    2593571 FROM DUMMY UNION ALL
      SELECT '%omsTerminate will be triggered%',                                                        2593571 FROM DUMMY UNION ALL
      SELECT '%OmsVersion canceled by ResourceManager as min_version_retention time reached%',          2593571 FROM DUMMY UNION ALL
      SELECT '%unexpected exception: function_name=%',                                                  2593571 FROM DUMMY UNION ALL
      SELECT '%Too many open files%',                                                                   2600030 FROM DUMMY UNION ALL
      SELECT '%Report backup failure: Object%',                                                         2601881 FROM DUMMY UNION ALL
      SELECT '%AuthorizationCheck::isAuthorizedToSearch: % is not valid%',                              2609984 FROM DUMMY UNION ALL
      SELECT '%Usage of subprocess/popen2 not allowed%',                                                2615046 FROM DUMMY UNION ALL
      SELECT '%session was forcibly closed by the remote host%',                                        2621115 FROM DUMMY UNION ALL
      SELECT '%backup history broken, trigger savepoint and mark segment%',                             2628775 FROM DUMMY UNION ALL
      SELECT '%Error during log segment backup%Buffer checksum%invalid%',                               2628775 FROM DUMMY UNION ALL
      SELECT '%cannot proceed with tracing%filesize_limit%exceeded%',                                   2629103 FROM DUMMY UNION ALL
      SELECT '%can not find code for node%',                                                            2637433 FROM DUMMY UNION ALL
      SELECT '%constant children: code generation failed%',                                             2637433 FROM DUMMY UNION ALL
      SELECT '%28: Connection to % lost while reading response%',                                       2641269 FROM DUMMY UNION ALL
      SELECT '%disable Embedded Statistics Server%',                                                    2658611 FROM DUMMY UNION ALL
      SELECT '%Skipping required ImportOrUpdateContent due to inactive / failing statistics server%',   2658611 FROM DUMMY UNION ALL
      SELECT '%Kerberos: Using empty Service Principal Name!%',                                         2660806 FROM DUMMY UNION ALL
      SELECT '%feature % disabled. (See M_CUSTOMIZABLE_FUNCTIONALITIES)%',                              2666303 FROM DUMMY UNION ALL
      SELECT '%SSL handshake failed: Channel closed during handshake%',                                 2666338 FROM DUMMY UNION ALL
      SELECT '%downward catalog migration % not supported%',                                            2668556 FROM DUMMY UNION ALL
      SELECT '%detected by TC replay anomaly detector which implies%',                                  2669621 FROM DUMMY UNION ALL
      SELECT '%Detected possible deadlock with TC replay dependency%',                                  2669621 FROM DUMMY UNION ALL
      SELECT '%Unable to wait for the dependency%',                                                     2669621 FROM DUMMY UNION ALL
      SELECT '%Cannot cancel processing of instanceId % invalid connection handle%',                    2670064 FROM DUMMY UNION ALL
      SELECT '%Error during execution of scenario:%',                                                   2670064 FROM DUMMY UNION ALL
      SELECT '%Error happened during callback execution to get EPM QUERY SOURCE metadata%',             2670064 FROM DUMMY UNION ALL
      SELECT '%error while executing scenario%',                                                        2670064 FROM DUMMY UNION ALL
      SELECT '%invalid calculation entity for MemberTuple%',                                            2670064 FROM DUMMY UNION ALL
      SELECT '%The cube cache key generator was not initialized%',                                      2670064 FROM DUMMY UNION ALL
      SELECT '%uncompressed scenario:%',                                                                2670064 FROM DUMMY UNION ALL
      SELECT 'Wait timed out',                                                                          2670064 FROM DUMMY UNION ALL
      SELECT '%Error while resolving groupname%',                                                       2670327 FROM DUMMY UNION ALL
      SELECT '%Collecting replication log is disabled due that replication log space is full%',         2673956 FROM DUMMY UNION ALL
      SELECT '%Hierarchy source data: Multiple parents not allowed%',                                   2681072 FROM DUMMY UNION ALL
      SELECT '%cannot execute hierarchy plan%',                                                         2681072 FROM DUMMY UNION ALL
      SELECT '%TRexApiSearch::searchHierarchy: searchHierarchyExpression rc=6990%',                     2681072 FROM DUMMY UNION ALL
      SELECT '%ColDicVal (%) not found%',                                                               2681828 FROM DUMMY UNION ALL
      SELECT '%failed to join XA session due to active user%',                                          2691896 FROM DUMMY UNION ALL
      SELECT '%Watermark mismatch: system_wm%',                                                         2689722 FROM DUMMY UNION ALL
      SELECT '%Could not get some memory usage statistics from Cgroup%',                                2694985 FROM DUMMY UNION ALL
      SELECT '%fast restart:%',                                                                         2700084 FROM DUMMY UNION ALL
      SELECT 'NVM:%Could not create %, error code: 28 (No space left on device)%',                      2700084 FROM DUMMY UNION ALL
      SELECT '%Table replication will be turned off %waiting synchronous commit%',                      2711518 FROM DUMMY UNION ALL
      SELECT '%Failed to create or initialize HanaTransform object%',                                   2713209 FROM DUMMY UNION ALL
      SELECT '%JWT mapping found%',                                                                     2728898 FROM DUMMY UNION ALL
      SELECT '%Error while parsing XML file landscapeDescription.xml%',                                 2739643 FROM DUMMY UNION ALL
      SELECT '%Load Landscape Description failed%',                                                     2739643 FROM DUMMY UNION ALL
      SELECT '%[Microsoft][ODBC Driver % for SQL Server]Login timeout expired%',                        2741672 FROM DUMMY UNION ALL
      SELECT '%could not create db connection%selfService is deactivated%',                             2747657 FROM DUMMY UNION ALL
      SELECT '%lock time for user % is % minutes% user is locked until%',                               2749450 FROM DUMMY UNION ALL
      SELECT '%Unknown log mode specified, value not changed%',                                         2765887 FROM DUMMY UNION ALL
      SELECT '%rc % 23052%',                                                                            2767841 FROM DUMMY UNION ALL
      SELECT '%deserialization of InheritableLocalStorage from active channel%',                        2767844 FROM DUMMY UNION ALL
      SELECT '%Too old snapshot timestamp%',                                                            2767844 FROM DUMMY UNION ALL
      SELECT '%Result itab%does not contain same number of columns%',                                   2770145 FROM DUMMY UNION ALL
      SELECT '%The select% returned more records than the limit in MaxResultRecords%',                  2770570 FROM DUMMY UNION ALL
      SELECT '%Column does not fit to attribute%',                                                      2771757 FROM DUMMY UNION ALL
      SELECT '%udiv mgr lookup failed for table%',                                                      2787837 FROM DUMMY UNION ALL
      SELECT '%indexhandle shared lock failed%',                                                        2789669 FROM DUMMY UNION ALL
      SELECT '%hdbrsutil seems to be hanging%',                                                         2792318 FROM DUMMY UNION ALL
      SELECT '%not permitted cross database communication is occurred%',                                2793857 FROM DUMMY UNION ALL
      SELECT '%Buffer cache has run out of buffers%',                                                   2799997 FROM DUMMY UNION ALL
      SELECT '%CS cannot provide requested memory as % limit of % MByte is exceeded%',                  2799997 FROM DUMMY UNION ALL
      SELECT '%Error while initializing Plan Stability Manager: invalid column name%',                  2799997 FROM DUMMY UNION ALL
      SELECT '%failed to initialize manager_ Cannot load plan map.%',                                   2799997 FROM DUMMY UNION ALL
      SELECT '%For buffer_cache_cs, max_%size%',                                                        2799997 FROM DUMMY UNION ALL
      SELECT '%Event_OutOfBuffersEvent%',                                                               2799997 FROM DUMMY UNION ALL
      SELECT '%NSEFeatureUsage is not supported on worker node%',                                       2799997 FROM DUMMY UNION ALL
      SELECT 'PageSizeClass%WSQ%',                                                                      2799997 FROM DUMMY UNION ALL
      SELECT '%cannot find temp index metadata with parameter value%',                                  2800007 FROM DUMMY UNION ALL
      SELECT '%Could not delete temp index: general configuration error(2030)%',                        2800008 FROM DUMMY UNION ALL
      SELECT '%error while clearing index%',                                                            2800008 FROM DUMMY UNION ALL
      SELECT '%freestyle attribute list is empty!%',                                                    2800008 FROM DUMMY UNION ALL
      SELECT '%Incorrect NEAR statement - missing parameters%',                                         2800008 FROM DUMMY UNION ALL
      SELECT '%Negated terms in combination with OR are not supported%',                                2800008 FROM DUMMY UNION ALL
      SELECT '%Processing of document%aborted%',                                                        2800008 FROM DUMMY UNION ALL
      SELECT '%returning PREPROCESSOR_ACTIVITY_ERROR%',                                                 2800008 FROM DUMMY UNION ALL
      SELECT '%Failed to execute trigger%',                                                             2800020 FROM DUMMY UNION ALL
      SELECT '%dsGetDataStatisticsHandle() return false, itsDataStats is not valid, error:%',           2800028 FROM DUMMY UNION ALL
      SELECT '%dsHashDataStatisticsNoLock(): handle is invalid for%',                                   2800028 FROM DUMMY UNION ALL
      SELECT '%type conflict: can not find code for node%',                                             2800044 FROM DUMMY UNION ALL
      SELECT '%type error in expression evaluator%',                                                    2800044 FROM DUMMY UNION ALL
      SELECT 'TREXviaDBSL was canceled by user%',                                                       2800048 FROM DUMMY UNION ALL
      SELECT '%Unknown exception caught in TREXviaDBSL%',                                               2800048 FROM DUMMY UNION ALL
      SELECT '%unknown view attribute in query%',                                                       2806646 FROM DUMMY UNION ALL
      SELECT '%New time value % is significantly less%',                                                2819632 FROM DUMMY UNION ALL
      SELECT '%::sendMessage: Invalid session id%',                                                     2827947 FROM DUMMY UNION ALL
      SELECT '%collection partition info% [18] A received argument has an invalid value%',              2839048 FROM DUMMY UNION ALL
      SELECT '%QueryEntryConstantResolver::enableSubtree: unsupported operator found at index%',        2845831 FROM DUMMY UNION ALL
      SELECT '%exception  1: no.1000003: Index % out of range%',                                        2876091 FROM DUMMY UNION ALL
      SELECT '%UpdateInfoWrapper is invalid%',                                                          2877010 FROM DUMMY UNION ALL
      SELECT '%Internal error during join: invalid input%',                                             2886632 FROM DUMMY UNION ALL
      SELECT '%New time value % is far in future compared to the last calibration time%',               2907637 FROM DUMMY UNION ALL
      SELECT '%incorrect number of inputs! reduction via Ntupel requires%',                             2913105 FROM DUMMY UNION ALL
      SELECT 'Check process status failed for%',                                                        2914594 FROM DUMMY UNION ALL
      SELECT '%qo_Exp for attribute % for RuntimeInput % not found%',                                   2917877 FROM DUMMY UNION ALL
      SELECT '%Failed to build plan for node%',                                                         2919604 FROM DUMMY UNION ALL
      SELECT '%Assertion failed: % pair.second%',                                                       2920919 FROM DUMMY UNION ALL
      SELECT '%statement needs to be restarted%',                                                       2924769 FROM DUMMY UNION ALL
      SELECT '%execute parellel re-validation by concurrent update%',                                   2925103 FROM DUMMY UNION ALL
      SELECT '%the transaction is already closed externally%',                                          2925229 FROM DUMMY UNION ALL
      SELECT '%invalidated procedure%',                                                                 2935599 FROM DUMMY UNION ALL
      SELECT '%QueryMediator failed executing query, % View attribute % was not found in schema%',      2936770 FROM DUMMY UNION ALL
      SELECT '%Unsupported DAF migration from version%',                                                2940494 FROM DUMMY UNION ALL
      SELECT '%Container 0x% not found%',                                                               2948535 FROM DUMMY UNION ALL
      SELECT '%JobConcatAttrCalculator %error=attribute value is not a number(6930)%',                  2952980 FROM DUMMY UNION ALL
      SELECT '%Replication Log Replayer % has retried a DML log%',                                      2966375 FROM DUMMY UNION ALL
      SELECT '%Stop marking and moving due to intensive parallel workload%',                            2973560 FROM DUMMY UNION ALL
      SELECT 'Database node:%databases%',                                                               2990106 FROM DUMMY UNION ALL
      SELECT 'Master not found for%',                                                                   2990106 FROM DUMMY UNION ALL
      SELECT 'Volumes node:%volumes%',                                                                  2990106 FROM DUMMY UNION ALL
      SELECT '%Can_t find Relevance with queryId%',                                                     3009615 FROM DUMMY UNION ALL
      SELECT '%589 - too many parameters are set: number of parameters % exceeds maximum number%',      3040627 FROM DUMMY UNION ALL
      SELECT '%IndexID: %: convertToPostfix failed, invalid query rc=2029%',                            3064971 FROM DUMMY UNION ALL
      SELECT '%parseInfix(): Syntactical description of query containing an error:%',                   3064971 FROM DUMMY UNION ALL
      SELECT '%Column % has unexpected type % that is not compatible to type%',                         3078297 FROM DUMMY UNION ALL
      SELECT '%Condition _lSavedOk_ failed.%',                                                          3092403 FROM DUMMY UNION ALL
      SELECT '%Error: Type check failed: expected%',                                                    3092403 FROM DUMMY UNION ALL
      SELECT '%Internal error during pre-instantiation%',                                               3092403 FROM DUMMY UNION ALL
      SELECT '%newValues.dict.blocks.block % not contained in data%',                                   3112893 FROM DUMMY UNION ALL
      SELECT 'c%not get attribute info for%',                                                           3119296 FROM DUMMY UNION ALL
      SELECT '%failure in acquiring index handle%',                                                     3125519 FROM DUMMY UNION ALL
      SELECT '%is not local',                                                                           3125519 FROM DUMMY UNION ALL
      SELECT '%failed to acquire a row lock during slot updated%',                                      3135063 FROM DUMMY UNION ALL
      SELECT '%no.1000091 % Not yet implemented % TRexAPI::TableUpdate::hasToSendDataToEveryParts%',    3139337 FROM DUMMY UNION ALL
      SELECT '%The following assertion failed: m_hWorkloadCtx%',                                        3142383 FROM DUMMY UNION ALL
      SELECT '%Delta fusion failed for Container%',                                                     3148864 FROM DUMMY UNION ALL
      SELECT '%failed to fuse deltas for TableName%',                                                   3148864 FROM DUMMY UNION ALL
      SELECT '%merge state for failed fusion%',                                                         3148864 FROM DUMMY UNION ALL
      SELECT '%unable to fuse deltas for table%',                                                       3148864 FROM DUMMY UNION ALL
      SELECT '%Map index out of bounds: resize%',                                                       3169817 FROM DUMMY UNION ALL
      SELECT '%assertion failed: !rowIdCol->isReadOnly%',                                               3166743 FROM DUMMY UNION ALL
      SELECT '%Error in the generated plan. DicVal% not found%',                                        3198590 FROM DUMMY UNION ALL
      SELECT 'qo_ColDic contents :%',                                                                   3198590 FROM DUMMY UNION ALL
      SELECT '%RootKeyManager serves keys for database%',                                               3202176 FROM DUMMY UNION ALL
      SELECT '%Force all NUMA nodes to recalibrate timer%',                                             3214098 FROM DUMMY UNION ALL
      SELECT '%Real time jump was detected%',                                                           3214098 FROM DUMMY UNION ALL
      SELECT '%Free stack is less than required!%',                                                     3215563 FROM DUMMY UNION ALL
      SELECT '%Path already registered or NUMA information not available%',                             3217234 FROM DUMMY UNION ALL
      SELECT '%insufficient row segment space for next row%',                                           3221279 FROM DUMMY UNION ALL
      SELECT '%Lockdown of product % due to expired validity%',                                         3245846 FROM DUMMY UNION ALL
      SELECT '%sorted and not contain duplicates%violating docids%',                                    3248936 FROM DUMMY UNION ALL
      SELECT '%Could not map query entry to part provider: No mapping found for attribute%',            3267320 FROM DUMMY UNION ALL
      SELECT '%Inactive object to be activated does not exist in repository%',                          3280628 FROM DUMMY UNION ALL
      SELECT '%New time value % is less than the previous one % Forward real time jump is supposed.%',  3295563 FROM DUMMY UNION ALL
      SELECT '%Failed to decrypt with DPAPI root key%',                                                 3300818 FROM DUMMY UNION ALL
      SELECT '%getUsedRootKeyHashes: failed to decrypt app key%',                                       3300818 FROM DUMMY UNION ALL
      SELECT '%[89013] Socket closed by peer%',                                                         3304246 FROM DUMMY UNION ALL
      SELECT 'OOM!%ReceiverHouseKeepingThread%',                                                        3307153 FROM DUMMY UNION ALL
      SELECT '%Mget decision result is missing%',                                                       3312617 FROM DUMMY UNION ALL
      SELECT '%Rel ID of target table docid%',                                                          3312617 FROM DUMMY UNION ALL
      SELECT '%[opId:%] Operator:%',                                                                    3312617 FROM DUMMY UNION ALL
      SELECT '%query recompilation is required%: exception 7400009: Retry with fallback%',              3326981 FROM DUMMY UNION ALL
      SELECT '%[200110] Invalid connect reply%',                                                        3341184 FROM DUMMY UNION ALL
      SELECT '%Detected a full rollback situation during statement rollback.%',                         3349076 FROM DUMMY UNION ALL
      SELECT '%partial abort failed in retry exception handler%',                                       3349076 FROM DUMMY UNION ALL
      SELECT '%statement rollback of DDL transactions disallowed%',                                     3349076 FROM DUMMY UNION ALL
      SELECT '%Failed: munmap MM % error 12%',                                                          3352604 FROM DUMMY UNION ALL	
      SELECT '%Unknown log backup interval mode normal specified, value not changed%',                  3353169 FROM DUMMY UNION ALL
      SELECT '%table size increase exceeds recompilation threshold factor%',                            3367230 FROM DUMMY UNION ALL
      SELECT '%only count function is supported in projection%',                                        3382857 FROM DUMMY UNION ALL
      SELECT '%Listener cannot be started, because port 400% is already in use!%',                      3381915 FROM DUMMY UNION ALL
      SELECT '%A system replication primary uses replication ports in the range%',                      3381915 FROM DUMMY UNION ALL
      SELECT '%Please check, that there is no other system on this machine using instancenr%',          3381915 FROM DUMMY UNION ALL
      SELECT '%In general the port range 40000-40099 must not be used by any other process%',           3381915 FROM DUMMY UNION ALL
      SELECT '%Joining from int to string not supported by OLAP engine%',                               3403995 FROM DUMMY UNION ALL
      SELECT '%info: high cpu load, this job should run each%',                                         3435077 FROM DUMMY UNION ALL
      SELECT '%Disabling read access to secondary system!%',                                            3491030 FROM DUMMY UNION ALL
      SELECT '%secondary version=% higher than primary version=%',                                      3491030 FROM DUMMY UNION ALL
      SELECT '%Lockdown as mem usage % higher than licensed/allowed%',                                  3499683 FROM DUMMY UNION ALL
      SELECT '%invalid license%',                                                                       3499683 FROM DUMMY
    ) ERROR_SECTION
  ) E ON
      T.TRACE_TEXT LIKE E.ERROR_TEXT
  WHERE
    ( BI.SAP_NOTE = -1 OR IFNULL(E.SAP_NOTE, -1) = BI.SAP_NOTE )
  GROUP BY
    CASE
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN
        CASE
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00',
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)),
'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.TIMESTAMP END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any'
    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')            != 0 THEN T.HOST                              ELSE MAP(BI.HOST, '%', 'any', BI.HOST)                                    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')            != 0 THEN TO_VARCHAR(T.PORT)                  ELSE MAP(BI.PORT, '%', 'any', BI.PORT)                                    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')         != 0 THEN T.SERVICE_NAME                      ELSE MAP(BI.SERVICE_NAME, '%', 'any', BI.SERVICE_NAME)                    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')         != 0 THEN TO_VARCHAR(T.CONNECTION_ID)         ELSE MAP(BI.CONN_ID, -1, 'any', TO_VARCHAR(BI.CONN_ID))                   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')       != 0 THEN TO_VARCHAR(T.THREAD_ID)             ELSE MAP(BI.THREAD_ID, -1, 'any', TO_VARCHAR(BI.THREAD_ID))               END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')            != 0 THEN T.STATEMENT_HASH                    ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)                END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DB_USER')         != 0 THEN T.USER_NAME                         ELSE MAP(BI.DB_USER, '%', 'any', BI.DB_USER)                              END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_USER')        != 0 THEN T.APPLICATION_USER_NAME             ELSE MAP(BI.APP_USER, '%', 'any', BI.APP_USER)                            END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_SOURCE')      != 0 THEN T.APPLICATION_SOURCE                ELSE MAP(BI.APP_SOURCE, '%', 'any', BI.APP_SOURCE)                        END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'APP_NAME')        != 0 THEN T.APPLICATION_NAME                  ELSE MAP(BI.APP_NAME, '%', 'any', BI.APP_NAME)                            END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_ACTION') != 0 THEN T.PASSPORT_ACTION                   ELSE MAP(BI.PASSPORT_ACTION, '%', 'any', BI.PASSPORT_ACTION)              END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PASSPORT_COMP')   != 0 THEN T.PASSPORT_COMPONENT_NAME           ELSE MAP(BI.PASSPORT_COMPONENT, '%', 'any', BI.PASSPORT_COMPONENT)        END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'UTID')            != 0 THEN TO_VARCHAR(T.UPDATE_TRANSACTION_ID) ELSE MAP(BI.UTID, -1, 'any', TO_VARCHAR(BI.UTID))                         END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LEVEL')           != 0 THEN T.TRACE_LEVEL                       ELSE 'any'                                                                END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'COMPONENT')       != 0 THEN T.COMPONENT                         ELSE MAP(BI.COMPONENT, '%', 'any', BI.COMPONENT)                          END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'FILE')            != 0 THEN T.TRACE_FILE_NAME                   ELSE MAP(BI.TRACE_FILE_NAME, '%', 'any', BI.TRACE_FILE_NAME)              END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'NOTE')            != 0 THEN IFNULL(TO_VARCHAR(E.SAP_NOTE), '')  ELSE MAP(BI.SAP_NOTE, -1, 'any', TO_VARCHAR(BI.SAP_NOTE))                 END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TEXT')            != 0 THEN TO_VARCHAR(T.TRACE_TEXT)            ELSE MAP(BI.TRACE_TEXT, '%', 'any', BI.TRACE_TEXT)                        END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SOURCE')          != 0 THEN T.SOURCE_FILE_NAME                  ELSE MAP(BI.SOURCE_FILE_NAME, '%', 'any', BI.SOURCE_FILE_NAME)            END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SOURCE')          != 0 THEN TO_VARCHAR(T.SOURCE_FILE_LINE)      ELSE MAP(BI.SOURCE_FILE_LINE, -1, 'any', TO_VARCHAR(BI.SOURCE_FILE_LINE)) END,
    BI.SUBSTRING_TRACE_TEXT,
    BI.ORDER_BY,
    BI.TRACE_TEXT_LENGTH,
    BI.SUBSTRING_TRACE_TEXT_LENGTH
) E
GROUP BY
  BEGIN_TIME,
  HOST,
  PORT,
  SERVICE_NAME,
  CONN_ID,
  AVG_LEN_KB,
  THREAD_ID,
  MAP(TRACE_LEVEL, 'FullDebug', 'D', 'InterfaceFull', 'A', 'Debug', 'd', 'Interface', 'a', 'Info', 'I', 'Warning', 'W', 'Error', 'E', 'Fatal', 'F', TRACE_LEVEL),
  COMPONENT,
  SOURCE_FILE_NAME,
  SOURCE_FILE_LINE,
  TRACE_FILE_NAME,
  LTRIM(REPLACE(TRACE_TEXT, CHAR(9), CHAR(32))),
  SUBSTR(LTRIM(REPLACE(REPLACE(REPLACE(TRACE_TEXT, CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32))), 1, MAP(TRACE_TEXT_LENGTH, -1, 999999, TRACE_TEXT_LENGTH)),
  SUBSTR(LTRIM(REPLACE(REPLACE(REPLACE(SUBSTR(TRACE_TEXT, LOCATE(TRACE_TEXT, SUBSTRING_TRACE_TEXT)), CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32))), 1, MAP(SUBSTRING_TRACE_TEXT_LENGTH, -1, 999999, SUBSTRING_TRACE_TEXT_LENGTH)),
  STATEMENT_HASH,
  DB_USER,
  APP_USER,
  APP_SOURCE,
  APP_NAME,
  PASSPORT_ACTION,
  PASSPORT_COMPONENT,
  UTID,
  TRACE_TEXT_LENGTH,
  SUBSTRING_TRACE_TEXT_LENGTH,
  ORDER_BY
ORDER BY
  MAP(ORDER_BY, 'COUNT', MAX(COUNT), 'AVG_LEN', AVG_LEN_KB, 'SUM_LEN', AVG_LEN_KB * MAX(COUNT)) DESC,
  MAP(ORDER_BY, 'FILE', TRACE_FILE_NAME),
  MAP(ORDER_BY, 'CONN_ID', HOST || PORT || CONN_ID || THREAD_ID, 'THREAD_ID', HOST || PORT || THREAD_ID),
  BEGIN_TIME DESC,
  CNT DESC
WITH HINT (IGNORE_PLAN_CACHE)
