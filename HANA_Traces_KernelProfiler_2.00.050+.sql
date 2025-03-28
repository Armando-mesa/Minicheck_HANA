SELECT

/* 

[NAME]

- HANA_Traces_KernelProfiler_2.00.050+

[DESCRIPTION]

- Information about activated kernel profilers

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- See SAP Note 2800030 for details about the kernel profiler
- Several columns in M_KERNEL_PROFILER only available with SAP HANA >= 2.0 SPS 05

[VALID FOR]

- Revisions:              >= 2.00.050

[SQL COMMAND VERSION]

- 2024/01/07:  1.0 (initial version)

[INVOLVED TABLES]

- M_KERNEL_PROFILER

[INPUT PARAMETERS]

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
  
[OUTPUT PARAMETERS]

- HOST:         Host name
- PORT:         Port
- START_TIME:   Start time
- END_TIME:     End time (if already stopped)
- DURATION_S:   Trace duration (s)
- STATUS:       Status
- SAMPLES:      Collected samples
- MEM_MB:       Used memory (MB)
- RESTRICTIONS: Configured trace restrictions (APP_USER, DB_USER, ROOT_STATEMENT_HASH, CONN_ID)
- MEM_LIM_MB:   Configured memory limit
- FILE_NAME:    Configured output file name identifier

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------
|HOST        |PORT |START_TIME         |END_TIME           |DURATION_S|STATUS |SAMPLES   |MEM_MB  |RESTRICTIONS      |MEM_LIM_MB|FILE_NAME|
-------------------------------------------------------------------------------------------------------------------------------------------
|saphananode1|30001|2024/01/07 16:24:29|                   |         9|STARTED|       109|    0.29|APP_USER: BATCHUSR|      0.00|         |
|saphananode1|30006|2024/01/07 15:40:04|                   |      2673|STARTED|       134|    0.22|                  |      0.00|         |
|saphananode1|30010|2024/01/07 16:00:52|2024/01/07 16:01:03|        11|STOPPED|        64|    0.27|                  |      0.00|         |
-------------------------------------------------------------------------------------------------------------------------------------------

*/

  P.HOST,
  LPAD(P.PORT, 5) PORT,
  IFNULL(TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(P.START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE P.START_TIME END, 'YYYY/MM/DD HH24:MI:SS'), '') START_TIME,
  IFNULL(TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(P.STOP_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE P.STOP_TIME END, 'YYYY/MM/DD HH24:MI:SS'), '') END_TIME,
  IFNULL(LPAD(SECONDS_BETWEEN(P.START_TIME, MAP(P.STOP_TIME, NULL, CURRENT_TIMESTAMP, P.STOP_TIME)), 10), '') DURATION_S,
  P.STATUS,
  LPAD(P.SAMPLE_COUNT, 10) SAMPLES,
  LPAD(TO_DECIMAL(P.MEMORY_SIZE / 1024 / 1024, 10, 2), 8) MEM_MB,
  RTRIM(MAP(P.APPLICATION_USER_NAME, '', '', 'APP_USER:' || CHAR(32) || P.APPLICATION_USER_NAME || ',' || CHAR(32)) ||
    MAP(P.USER_NAME, '', '', 'DB_USER:' || CHAR(32) || P.USER_NAME || ',' || CHAR(32)) ||
    MAP(P.CONNECTION_ID, -1, '', 'CONN_ID:' || CHAR(32) || P.CONNECTION_ID || ',' || CHAR(32)) ||
    MAP(P.ROOT_STATEMENT_HASH, '', '', 'ROOT_STATEMENT_HASH:' || CHAR(32) || P.ROOT_STATEMENT_HASH || ',' || CHAR(32)), ', ') RESTRICTIONS,
  LPAD(TO_DECIMAL(P.MEMORY_LIMIT / 1024 / 1024, 10, 2), 10) MEM_LIM_MB,
  P.TRACEPROFILE_NAME FILE_NAME
FROM
( SELECT                  /* Modification section */
    'SERVER' TIMEZONE,                              /* SERVER, UTC */
    '%' HOST,
    '%' PORT
  FROM
    DUMMY
) BI,
  M_KERNEL_PROFILER P
WHERE
  P.HOST LIKE BI.HOST AND
  TO_VARCHAR(P.PORT) LIKE BI.PORT
ORDER BY
  P.HOST,
  P.PORT
