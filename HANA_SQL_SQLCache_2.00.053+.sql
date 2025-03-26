WITH 

/* 

[NAME]

- HANA_SQL_SQLCache_2.00.053+

[DESCRIPTION]

- List of top SQL statements (e.g. based on elapsed time, executions or records)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Thread and network information available in M_SQL_PLAN_CACHE as of Rev. 1.00.102.01
- More network and memory information available in M_SQL_PLAN_CACHE as of 1.00.120
- APPLICATION_SOURCE and APPLICATION_NAME in M_SQL_PLAN_CACHE available starting with Rev. 1.00.122.15 (and 2.00.012.04 / 2.00.024.00)
- LAST_INVALIDATION_REASON available starting with Rev. 1.00.122.17 (and 2.00.020)
- APPLICATION_SOURCE and APPLICATION_NAME in HOST_SQL_PLAN_CACHE available starting with Rev. 1.00.122.21 (and 2.00.024.06 / 2.00.034)
- M_SQL_PLAN_STATISTICS available with SAP HANA >= 2.00.000
- M_SQL_PLAN_STATISTICS.LAST_INVALIDATION_REASON available with SAP HANA >= 2.00.040
- WITH clause does not work with older DBACOCKPIT transactions before SAP BASIS 7.02 SP16 / 7.30 SP12 / 7.31 SP12 / SAP_BASIS 7.40 SP07 (empty result returned)
- Sort order can be wrong due to SAP HANA bug 170573 (<= 1.00.122.30, <= 2.00.046)
- EXECUTION_ENGINE available with SAP HANA >= 2.00.053
- DISPLAY_STATEMENT_TEXT = ' ' can improve statement runtime, but columns TP and STATEMENT_STRING will not be populated
- RESET can be performed via:

  ALTER SYSTEM RESET MONITORING VIEW M_SQL_PLAN_CACHE_RESET

[VALID FOR]

- Revisions:              >= 2.00.053

[SQL COMMAND VERSION]

- 2014/03/17:  1.0 (initial version)
- 2014/07/21:  1.1 (consolidated command for evaluating current and historic SQL plan cache)
- 2014/11/25:  1.2 (included preparation and load times in elapsed time)
- 2014/12/22:  1.3 (IS_DISTRIBUTED_EXECUTION and TIME_AGGREGATE_BY included)
- 2015/01/30:  1.4 (Preparation times included)
- 2015/02/27:  1.5 (SCHEMA_NAME included)
- 2015/03/23:  1.6 (TABLE_NAME included)
- 2015/05/02:  1.7 (M_SQL_PLAN_CACHE_RESET included)
- 2015/12/03:  1.8 (PLAN_SHARING_TYPE included)
- 2015/12/07:  1.9 (REFERENCE_COUNT included)
- 2016/01/19:  2.0 (dedicated Rev102.01+ version)
- 2016/06/06:  2.1 (ELA_PER_REC_MS included)
- 2016/07/01:  2.2 (TABLE_LOCATION included)
- 2016/09/12:  2.3 (IS_INTERNAL included)
- 2016/09/23:  2.4 (STORE, DB_USER included)
- 2016/10/09:  2.5 (ACCESSED_TABLE_NAMES included)
- 2016/12/11:  2.6 (dedicated Rev. 1.00.120+ version with extended network and memory information)
- 2016/12/31:  2.7 (TIME_AGGREGATE_BY = 'TS<seconds>' included)
- 2017/02/22:  2.8 (TABLE_GROUP included)
- 2017/05/22:  2.9 (ONLY_CROSS_NODE_JOINS included)
- 2017/10/26:  3.0 (TIMEZONE included)
- 2018/01/18:  3.1 (NO_SUBPLAN_SHARING hint added)
- 2018/02/16:  3.2 (SQL_TYPE added)
- 2018/05/08:  3.3 (SQL type included)
- 2018/05/11:  3.4 (dedicated 1.00.122.15+ version with APPLICATION_SOURCE)
- 2018/05/12:  3.5 (DISPLAY_STATEMENT_TEXT included)
- 2018/06/25:  3.6 (APPLICATION_NAME included)
- 2018/10/02:  3.7 (dedicated 1.00.122.17+ version with LAST_INVALIDATION_REASON)
- 2018/11/07:  3.8 (EXCLUDE_CURRENT_RANGE_RESTRICTION included)
- 2018/12/04:  3.9 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/01/28:  4.0 (dedicated 1.00.122.21+ version with APPLICATION_SOURCE in HOST_SQL_PLAN_CACHE)
- 2019/11/03:  4.1 (table groups removed)
- 2020/03/09:  4.2 (dedicated 2.00.040+ version including M_SQL_PLAN_STATISTICS)
- 2020/08/03:  4.3 (IS_PINNED_PLAN included)
- 2020/12/23:  4.4 (dedicated 2.00.053+ version including EXECUTION_ENGINE)
- 2021/12/01:  4.5 (EXCLUDE_INTERNAL replaced by IS_INTERNAL, MIN_PLAN_SIZE_KB, PLAN_MEMORY_SIZE included)

[INVOLVED TABLES]

- M_SQL_PLAN_CACHE
- M_SQL_PLAN_CACHE_RESET
- HOST_SQL_PLAN_CACHE

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

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- TABLE_LOCATION

  Location(s) of table(s)

  '%saphana01%'   --> Tables with location containing 'saphana01'
  '%'             --> No limitation related to table locations

- STATEMENT_HASH      
 
  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction (only possible if hash is not mandatory)

- TABLE_NAME

  Table name

  'KONV'          --> Only statements accessing table KONV (no search pattern or table list allowed)
  '%'             --> No restriction related to table name (same effect also for search patterns)

- SQL_PATTERN

  Pattern for SQL text (case insensitive)

  'INSERT%'       --> SQL statements starting with INSERT
  '%DBTABLOG%'    --> SQL statements containing DBTABLOG
  '%'             --> All SQL statements

- SQL_TYPE

  SQL type

  'AI'            --> ALTER INDEX
  'AS'            --> ALTER SYSTEM
  'AT'            --> ALTER TABLE
  'AL'            --> ALTER
  'CA'            --> CALL
  'CO'            --> COMMIT
  'CI'            --> CREATE INDEX
  'CT'            --> CREATE TABLE
  'CR'            --> CREATE
  'DE'            --> DELETE
  'DI'            --> DROP INDEX
  'DM'            --> Data modification commands (INSERT, UPDATE, DELETE, UPSERT, SELECT FOR UPDATE)
  'DT'            --> DROP TABLE
  'DR'            --> DROP
  'EX'            --> EXECUTE
  'IN'            --> INSERT
  'RE'            --> REPLACE
  'RO'            --> ROLLBACK
  'SU'            --> SELECT FOR UPDATE
  'SE'            --> SELECT
  'TR'            --> TRUNCATE
  'UP'            --> UPDATE
  'US'            --> UPSERT
  'WI'            --> WITH
  '%'             --> No restriction related to SQL type

- DB_USER

  Database user

  'SYSTEM'        --> Database user 'SYSTEM'
  '%'             --> No database user restriction

- APP_NAME

  Application name

  'HANACockpit'   --> Application name HANACockpit
  '%'             --> No application name restriction

- APP_SOURCE

  Application source

  'SAPL2:437'     --> Application source 'SAPL2:437'
  'SAPMSSY2%'     --> Application sources starting with SAPMSSY2
  '%'             --> No application source restriction

- INV_REASON

  Invalidation reason

  'FALLBACK COMPILE OPTION' --> Display only statements with invalidation reason "FALLBACK COMPILE OPTION"
  '%'                       --> No restriction related to invalidation reason

- IS_DISTRIBUTED_EXECUTION

  Possibility to restrict result to distributed executions

  'TRUE'          --> Only show distributed executions (accessing multiple scale-out nodes)
  'FALSE'         --> Only show local executions (accessing only a single SAP HANA node)
  '%'             --> No restriction related to distributed executions

- IS_PINNED_PLAN

  Possibility to restrict result to pinned plans / statement hints

  'TRUE'          --> Only show pinned execution plans (e.g. due to statement hints)
  'FALSE'         --> Only show execution plans that are not pinned
  '%'             --> No restriction related to pinned execution plans

- ONLY_CROSS_NODE_JOIN

  Possibility to restrict the result to cross-node joins

  'X'             --> Only consider requests accessing more than a single SAP HANA node
  ' '             --> No restriction related to cross-node joins

- SHARING_TYPE

  Plan sharing type filter

  'SESSION LOCAL' --> Display SQL statements with 'SESSION LOCAL' plan sharing type
  '%'             --> No restriction related to plan sharing type

- STORE

  Table store

  'ROW'           --> Only display accesses where all tables are located in row store
  '%COLUMN%'      --> Only display accesses where at least one table is located in column store
  '%'             --> No restriction related to table store

- ENGINES

  Execution engines

  'HEX'           --> Display SQL statements using (only) HEX engine
  '%OLAP%'        --> Display SQL statements using OLAP engine (and potentially others)
  '%'             --> No restriction related to used execution engines

- MIN_PLAN_SIZE_KB

  Minimum threshold for plan memory size (KB)

  1024            --> Only display database requests with a plan memory size of at least 1024 KB
  -1              --> No restriction related to plan memory size

- EXCLUDE_CURRENT_RANGE_RESTRICTION

  Possibility to exclude SQL statements ending with "WITH RANGE_RESTRICTION('CURRENT')" (i.e. accesses to hot data aging partitions)

  'X'             --> Skip accesses to hot partitions in case of data aging tables
  ' '             --> No restriction to current range restriction

- IS_INTERNAL

  Internal / external statements

  'X'             --> Only display internal statements
  ' '             --> Only display external statements
  '%'             --> No restriction related to internal / external statements

- DISPLAY_STATEMENT_TEXT

  Possibility to enable / disable display of statement text (activation can significantly slow down the query)

  'X'             --> Display statement text
  ' '             --> Do not evaluate statement text

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_* tables)
  'HISTORY'       --> Data from persisted history information (HOST_* tables)
  'RESET'         --> Data from reset memory information (M_*_RESET tables)
  'STATISTICS'    --> Data from current and evicted SQL cache (M_SQL_PLAN_STATISTICS)

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HASH'          --> Aggregation by statement hash
  'HOST, PLAN_ID' --> Aggregation by host and SQL plan ID
  'NONE'          --> No aggregation

- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

- ORDER_BY

  Sort order (available values are provided in comment)

  'ELAPSED'       --> Sorting by elapsed time
  'EXECUTIONS'    --> Sorting by number of executions

- RESULT_ROWS

  Number of records to be returned by the query

  100             --> Return a maximum number of 100 records
  -1              --> Return all records

[OUTPUT PARAMETERS]

- SNAPSHOT_TIME:     Begin time
- NUM:               Number of SQL cache entries
- HOST:              Host of statement execution ('various' if several hosts executed the command)
- PORT:              Port
- SCHEMA_NAME:       Schema name
- LOCATION:          Table locations
- STATEMENT_HASH:    Hash value of SQL statement
- TP:                SQL type (SE -> SELECT, IN -> INSERT, DE -> DELETE, UP -> UPDATE, ...), not filled in case of DISPLAY_STATEMENT_TEXT = ' '
- PLAN_ID:           Execution plan ID
- STORE:             ROW for row store tables, COLUMN for column store tables
- ENGINES:           Execution engines
- DIST:              TRUE in case of distributed request (accessing more than 1 node), FALSE in case of single node request 
- I:                 'X' in case of internal statement, otherwise ' '
- P:                 'X' in case of pinned plan or statement hint, otherwise ' '
- PST:               Plan sharing type (G -> GLOBAL, SEG -> SESSION EXCLUSIVE GLOBAL, SGL -> LOGICAL SESSION GLOBAL, SL -> SESSION LOCAL)
- TP:                SQL type (SE -> SELECT, IN -> INSERT, DE -> DELETE, UP -> UPDATE, ...)
- RC:                Reference count
- INV_REASON:        Invalidation reason
- EXECUTIONS:        Number of executions
- RECORDS:           Number of records
- REC_PER_EXEC:      Number of records per execution (ms)
- ELAPSED_MS:        Elapsed time (ms)
- ELA_PER_EXEC_MS:   Elapsed time (preparation time + execution time) per execution (ms)
- ELA_PER_REC_MS:    Elapsed time (preparation time + execution time) per record (ms), if less than 1 row is returned per execution, the elapsed time per execution is displayed
- EXEC_PER_EXEC_MS:  Execution time per execution (ms) 
- PREPS:             Preparations
- PREP_MS:           Preparation time (ms)
- LOCK_WAIT_MS:      Lock wait time (ms)
- LOCK_PER_EXEC_MS:  Lock wait time per execution (ms)
- CURSOR_MS:         Cursor execution time (ms), includes network and client activities
- CUR_PER_EXEC_MS:   Cursor execution time per execution (ms)
- OPEN_MS:           Open time (ms), often contains the actual data collection
- OPEN_PER_EXEC_MS:  Open time per execution (ms)
- FETCH_MS:          Fetch time (ms), can sometimes contain times related to the actual data collection (row store, late materialization)
- FETCH_PER_EXEC_MS: Fetch time per execution (ms)
- NETWORK_REQ:       Total service network requests
- NW_REQ_PER_EXEC:   Service network requests per execution
- NW_SIZE_GB:        Size of service network requests (GB)
- NW_PER_EXEC_MB:    Size of service network requests per execution (MB)
- NETWORK_MS:        Service network request time (ms)
- NW_PER_EXEC_MS:    Service network request time per execution (ms)
- MEMORY_GB:         Total memory allocation (GB)
- MEM_PER_EXEC_MB:   Memory allocation per execution (MB)
- PLAN_MB:           Plan memory size (MB)
- THREADS:           Total job worker threads used
- THR_PER_EXEC:      Job worker threads used per execution
- APP_NAME:          Application name
- APP_SOURCE:        Application source
- STATEMENT_STRING:  SQL statement text

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|STATEMENT_HASH                  |HOST   |TABLE_TYPES|EXECUTIONS|RECORDS   |REC_PER_EXEC|CURSOR_MS |CUR_PER_EXEC_MS|ELAPSED_MS|ELA_PER_EXEC_MS|OPEN_MS   |OPEN_PER_EXEC_MS|FETCH_MS  |FETCH_PER_EXEC_MS|LOCK_WAIT_MS|LOCK_PER_EXEC_MS|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|905dbaa93a672b087c6f226bc283431d|saphana|ROW        |      5756|         0|        0.00|  46781804|        8127.48|  46781499|        8127.43|       182|          182.17|  46781098|          8127.36|           0|            0.00|
|73fd22e11d2a116696a0976d447725ed|saphana|NULL       |      2878|      2878|        1.00|  23432993|        8142.11|  23432849|        8142.06|  23432779|     23432779.48|        30|             0.01|           0|            0.00|
|67300b9fa874852496035d12131e8eda|saphana|COLUMN     |      2878|         0|        0.00|  23372620|        8121.13|  23372431|        8121.06|  23372163|     23372163.42|        21|             0.00|           0|            0.00|
|ff8603d773911e231aa87ecf956338e4|various|COLUMN     |     22896|  82376093|     3597.83|  15282643|         667.48|  15119139|         660.33|  14935143|     14935142.96|    169555|             7.40|           0|            0.00|
|b887b4d7ec612fbaf942cb664cb44a94|saphana|ROW        |       720|       720|        1.00|  13055876|       18133.16|  13055822|       18133.08|  13055779|     13055779.04|        21|             0.02|           0|            0.00|
|71991dbf589bc4bccb542e45e0843140|saphana|ROW        |       720|     55440|       77.00|  12810819|       17792.80|  12810320|       17792.11|  12809656|     12809655.66|       153|             0.21|           0|            0.00|
|d4353cc2f1efbad813ad7106cecfc9bf|saphana|ROW        |       720|      1440|        2.00|  12324677|       17117.60|  12324631|       17117.54|  12324437|     12324437.47|        15|             0.02|           0|            0.00|
|51fbc84c81236491c0e30ec6394a54c0|saphana|ROW, COLUMN|       720|  26106405|    36258.89|  12830797|       17820.55|  12317890|       17108.18|  12145193|     12145193.26|    172434|           239.49|           0|            0.00|
|f6d34a3b244677718557cbc092794bf7|saphana|ROW        |       720|    215974|      299.96|  11455868|       15910.92|  11454956|       15909.66|  11454119|     11454118.82|       444|             0.61|           0|            0.00|
|062a118a73583797125c01e2871f7d4c|saphana|ROW        |      2878|     23024|        8.00|  10323850|        3587.16|  10323578|        3587.06|   9987578|      9987577.69|    208825|            72.55|           0|            0.00|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    TIMESTAMP_TYPE,
    HOST,
    PORT,
    SCHEMA_NAME,
    TABLE_LOCATION,
    STATEMENT_HASH,
    TABLE_NAME,
    SQL_PATTERN,
    SQL_TYPE,
    DB_USER,
    APP_NAME,
    APP_SOURCE,
    INV_REASON,
    IS_DISTRIBUTED_EXECUTION,
    IS_PINNED_PLAN,
    STORE,
    ENGINES,
    MIN_PLAN_SIZE_KB,
    ONLY_CROSS_NODE_JOINS,
    SHARING_TYPE,
    EXCLUDE_CURRENT_RANGE_RESTRICTION,
    IS_INTERNAL,
    DISPLAY_STATEMENT_TEXT,
    DATA_SOURCE,
    AGGREGATE_BY,
    MAP(TIME_AGGREGATE_BY,
      'NONE',        'YYYY/MM/DD HH24:MI:SS',
      'HOUR',        'YYYY/MM/DD HH24',
      'DAY',         'YYYY/MM/DD (DY)',
      'HOUR_OF_DAY', 'HH24',
      TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
    ORDER_BY,
    RESULT_ROWS
  FROM
  ( SELECT                                                      /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      'EXEC' TIMESTAMP_TYPE,                       /* SERVER, EXEC, PREP */
      '%' HOST,
      '%' PORT,
      '%' SCHEMA_NAME,
      '%' TABLE_LOCATION,
      '%' STATEMENT_HASH,
      '%' TABLE_NAME,
      '%' SQL_PATTERN,                             /* only works when DISPLAY_STATEMENT_TEXT = 'X' is set */
      '%' SQL_TYPE,                                /* only works when DISPLAY_STATEMENT_TEXT = 'X' is set */
      '%' DB_USER,
      '%' APP_NAME,
      '%' APP_SOURCE,
      '%' INV_REASON,
      '%' IS_DISTRIBUTED_EXECUTION,                    /* TRUE, FALSE, % */
      '%' IS_PINNED_PLAN,
      '%' IS_INTERNAL,
      ' ' ONLY_CROSS_NODE_JOINS,
      '%' SHARING_TYPE,
      '%' STORE,
      '%' ENGINES,
      -1 MIN_PLAN_SIZE_KB,
      ' ' EXCLUDE_CURRENT_RANGE_RESTRICTION,      /* only works when DISPLAY_STATEMENT_TEXT = 'X' is set */
      'X' DISPLAY_STATEMENT_TEXT,
      'HISTORY' DATA_SOURCE,     /* CURRENT, HISTORY, RESET, STATISTICS */
      'TIME' AGGREGATE_BY,       /* TIME, HOST, PORT, HASH, SQL_TYPE, PLAN_ID, STORE, INV_REASON, SHARING_TYPE, DIST, SCHEMA, LOCATION, INTERNAL, TABLES, APP_NAME, APP_SOURCE, PINNED, ENGINES or comma separated list, NONE for no aggregation */
      'DAY' TIME_AGGREGATE_BY,   /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
      'EXEC' ORDER_BY,        /* ELAPSED, EXEC, PREP, CURSOR, OPEN, FETCH, LOCK, EXECUTIONS, RECORDS, NETWORK_COUNT, NETWORK_SIZE, NETWORK_TIME, MEMORY, MEM_PER_EXEC, PLAN_MEM, THREAD */
      -1 RESULT_ROWS
    FROM
      DUMMY
  ) BI
),
SQL_CACHE AS
( SELECT
    'CURRENT' DATA_SOURCE,
    HOST,
    PORT,
    NULL SNAPSHOT_ID,
    SCHEMA_NAME,
    STATEMENT_HASH,
    PLAN_ID,
    USER_NAME,
    TO_VARCHAR(ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', TO_VARCHAR(STATEMENT_STRING), '') STATEMENT_STRING,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), ''), '') STATEMENT_STRING_CLEANED,
    TABLE_TYPES STORE,
    EXECUTION_ENGINE ENGINES,
    PLAN_SHARING_TYPE SHARING_TYPE,
    REFERENCE_COUNT,
    CURRENT_TIMESTAMP SERVER_TIMESTAMP,
    IS_DISTRIBUTED_EXECUTION,
    CASE WHEN COMPILATION_OPTIONS = 'STATEMENT HINT' OR IS_PINNED_PLAN = 'TRUE' THEN 'TRUE' ELSE FALSE END IS_PINNED_PLAN,
    IS_INTERNAL,
    EXECUTION_COUNT,
    TOTAL_RESULT_RECORD_COUNT,
    TOTAL_CURSOR_DURATION,
    TOTAL_EXECUTION_TIME + TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    TOTAL_EXECUTION_TIME,
    TOTAL_EXECUTION_OPEN_TIME,
    TOTAL_EXECUTION_FETCH_TIME,
    TOTAL_PREPARATION_TIME,
    PREPARATION_COUNT,
    TOTAL_LOCK_WAIT_DURATION,
    LAST_PREPARATION_TIMESTAMP,
    LAST_EXECUTION_TIMESTAMP,
    TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    TOTAL_CALLED_THREAD_COUNT,
    TOTAL_EXECUTION_MEMORY_SIZE,
    TABLE_LOCATIONS TABLE_LOCATION,
    APPLICATION_SOURCE,
    APPLICATION_NAME,
    CASE 
      WHEN LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH'
      WHEN LAST_INVALIDATION_REASON LIKE 'NON-USER-OID NOT FOUND%'  THEN 'NON-USER-OID NOT FOUND'
      ELSE LAST_INVALIDATION_REASON 
    END LAST_INVALIDATION_REASON,
    PLAN_MEMORY_SIZE
  FROM
    ( SELECT DISPLAY_STATEMENT_TEXT FROM BASIS_INFO ) BI,
    M_SQL_PLAN_CACHE
  UNION ALL
  SELECT
    'STATISTICS' DATA_SOURCE,
    HOST,
    PORT,
    NULL SNAPSHOT_ID,
    SCHEMA_NAME,
    STATEMENT_HASH,
    PLAN_ID,
    USER_NAME,
    TO_VARCHAR(ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', TO_VARCHAR(STATEMENT_STRING), '') STATEMENT_STRING,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), ''), '') STATEMENT_STRING_CLEANED,
    TABLE_TYPES STORE,
    EXECUTION_ENGINE ENGINES,
    PLAN_SHARING_TYPE SHARING_TYPE,
    REFERENCE_COUNT,
    CURRENT_TIMESTAMP SERVER_TIMESTAMP,
    IS_DISTRIBUTED_EXECUTION,
    CASE WHEN COMPILATION_OPTIONS = 'STATEMENT HINT' OR IS_PINNED_PLAN = 'TRUE' THEN 'TRUE' ELSE FALSE END IS_PINNED_PLAN,
    IS_INTERNAL,
    EXECUTION_COUNT,
    TOTAL_RESULT_RECORD_COUNT,
    TOTAL_CURSOR_DURATION,
    TOTAL_EXECUTION_TIME + TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    TOTAL_EXECUTION_TIME,
    TOTAL_EXECUTION_OPEN_TIME,
    TOTAL_EXECUTION_FETCH_TIME,
    TOTAL_PREPARATION_TIME,
    PREPARATION_COUNT,
    TOTAL_LOCK_WAIT_DURATION,
    LAST_PREPARATION_TIMESTAMP,
    LAST_EXECUTION_TIMESTAMP,
    TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    TOTAL_CALLED_THREAD_COUNT,
    TOTAL_EXECUTION_MEMORY_SIZE,
    TABLE_LOCATIONS TABLE_LOCATION,
    APPLICATION_SOURCE,
    APPLICATION_NAME,
    CASE 
      WHEN LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH'
      WHEN LAST_INVALIDATION_REASON LIKE 'NON-USER-OID NOT FOUND%'  THEN 'NON-USER-OID NOT FOUND'
      ELSE LAST_INVALIDATION_REASON 
    END LAST_INVALIDATION_REASON,
    PLAN_MEMORY_SIZE
  FROM
    ( SELECT DISPLAY_STATEMENT_TEXT FROM BASIS_INFO ) BI,
    M_SQL_PLAN_STATISTICS
  UNION ALL
  SELECT
    'RESET' DATA_SOURCE,
    HOST,
    PORT,
    NULL SNAPSHOT_ID,
    SCHEMA_NAME,
    STATEMENT_HASH,
    PLAN_ID,
    USER_NAME,
    TO_VARCHAR(ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', TO_VARCHAR(STATEMENT_STRING), '') STATEMENT_STRING,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), ''), '') STATEMENT_STRING_CLEANED,
    TABLE_TYPES STORE,
    EXECUTION_ENGINE ENGINES,
    PLAN_SHARING_TYPE SHARING_TYPE,
    REFERENCE_COUNT,
    CURRENT_TIMESTAMP SERVER_TIMESTAMP,
    IS_DISTRIBUTED_EXECUTION,
    CASE WHEN COMPILATION_OPTIONS = 'STATEMENT HINT' OR IS_PINNED_PLAN = 'TRUE' THEN 'TRUE' ELSE FALSE END IS_PINNED_PLAN,
    IS_INTERNAL,
    EXECUTION_COUNT,
    TOTAL_RESULT_RECORD_COUNT,
    TOTAL_CURSOR_DURATION,
    TOTAL_EXECUTION_TIME + TOTAL_PREPARATION_TIME TOTAL_ELAPSED_TIME,
    TOTAL_EXECUTION_TIME,
    TOTAL_EXECUTION_OPEN_TIME,
    TOTAL_EXECUTION_FETCH_TIME,
    TOTAL_PREPARATION_TIME,
    PREPARATION_COUNT,
    TOTAL_LOCK_WAIT_DURATION,
    LAST_PREPARATION_TIMESTAMP,
    LAST_EXECUTION_TIMESTAMP,
    TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    TOTAL_CALLED_THREAD_COUNT,
    TOTAL_EXECUTION_MEMORY_SIZE,
    TABLE_LOCATIONS TABLE_LOCATION,
    APPLICATION_SOURCE,
    APPLICATION_NAME,
    CASE 
      WHEN LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH'
      WHEN LAST_INVALIDATION_REASON LIKE 'NON-USER-OID NOT FOUND%'  THEN 'NON-USER-OID NOT FOUND'
      ELSE LAST_INVALIDATION_REASON 
    END LAST_INVALIDATION_REASON,
    PLAN_MEMORY_SIZE
  FROM
    ( SELECT DISPLAY_STATEMENT_TEXT FROM BASIS_INFO ) BI,
    M_SQL_PLAN_CACHE_RESET
  UNION ALL
  SELECT
    'HISTORY' DATA_SOURCE,
    HOST,
    PORT,
    SNAPSHOT_ID,
    SCHEMA_NAME,
    STATEMENT_HASH,
    PLAN_ID,
    USER_NAME,
    TO_VARCHAR(ACCESSED_TABLE_NAMES) ACCESSED_TABLE_NAMES,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', TO_VARCHAR(STATEMENT_STRING), '') STATEMENT_STRING,
    MAP(BI.DISPLAY_STATEMENT_TEXT, 'X', REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), ''), '') STATEMENT_STRING_CLEANED,
    TABLE_TYPES STORE,
    EXECUTION_ENGINE ENGINES,
    PLAN_SHARING_TYPE SHARING_TYPE,
    REFERENCE_COUNT,
    SERVER_TIMESTAMP,
    IS_DISTRIBUTED_EXECUTION,
    CASE WHEN COMPILATION_OPTIONS = 'STATEMENT HINT' OR IS_PINNED_PLAN = 'TRUE' THEN 'TRUE' ELSE FALSE END IS_PINNED_PLAN,
    IS_INTERNAL,
    MAX(EXECUTION_COUNT) EXECUTION_COUNT,
    MAX(TOTAL_RESULT_RECORD_COUNT) TOTAL_RESULT_RECORD_COUNT,
    MAX(TOTAL_CURSOR_DURATION) TOTAL_CURSOR_DURATION,
    MAX(TOTAL_EXECUTION_TIME + TOTAL_PREPARATION_TIME) TOTAL_ELAPSED_TIME,
    MAX(TOTAL_EXECUTION_TIME) TOTAL_EXECUTION_TIME,
    MAX(TOTAL_EXECUTION_OPEN_TIME) TOTAL_EXECUTION_OPEN_TIME,
    MAX(TOTAL_EXECUTION_FETCH_TIME) TOTAL_EXECUTION_FETCH_TIME,
    MAX(TOTAL_PREPARATION_TIME) TOTAL_PREPARATION_TIME,
    MAX(PREPARATION_COUNT) PREPARATION_COUNT,
    MAX(TOTAL_LOCK_WAIT_DURATION) TOTAL_LOCK_WAIT_DURATION,
    MAX(LAST_PREPARATION_TIMESTAMP) LAST_PREPARATION_TIMESTAMP,
    MAX(LAST_EXECUTION_TIMESTAMP) LAST_EXECUTION_TIMESTAMP,
    MAX(TOTAL_SERVICE_NETWORK_REQUEST_COUNT) TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
    MAX(TOTAL_SERVICE_NETWORK_REQUEST_DURATION) TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
    MAX(TOTAL_SERVICE_NETWORK_REQUEST_SIZE) TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
    MAX(TOTAL_CALLED_THREAD_COUNT) TOTAL_CALLED_THREAD_COUNT,
    MAX(TOTAL_EXECUTION_MEMORY_SIZE) TOTAL_EXECUTION_MEMORY_SIZE,
    TABLE_LOCATIONS TABLE_LOCATION,
    APPLICATION_SOURCE,
    APPLICATION_NAME,
    CASE 
      WHEN LAST_INVALIDATION_REASON LIKE 'NON-USER-OID NOT FOUND%' THEN 'NON-USER-OID NOT FOUND' 
      WHEN LAST_INVALIDATION_REASON LIKE 'OBJECT VERSION MISMATCH%' THEN 'OBJECT VERSION MISMATCH' 
      ELSE LAST_INVALIDATION_REASON 
    END LAST_INVALIDATION_REASON,
    MAX(PLAN_MEMORY_SIZE) PLAN_MEMORY_SIZE
  FROM
    ( SELECT DISPLAY_STATEMENT_TEXT FROM BASIS_INFO ) BI,
    _SYS_STATISTICS.HOST_SQL_PLAN_CACHE C 
  GROUP BY
    HOST,
    PORT,
    SNAPSHOT_ID,
    SCHEMA_NAME,
    TABLE_LOCATIONS,
    STATEMENT_HASH,
    PLAN_ID,
    USER_NAME,
    TO_VARCHAR(ACCESSED_TABLE_NAMES),
    TO_VARCHAR(STATEMENT_STRING),
    TABLE_TYPES,
    EXECUTION_ENGINE,
    PLAN_SHARING_TYPE,
    REFERENCE_COUNT,
    SERVER_TIMESTAMP,
    IS_DISTRIBUTED_EXECUTION,
    CASE WHEN COMPILATION_OPTIONS = 'STATEMENT HINT' OR IS_PINNED_PLAN = 'TRUE' THEN 'TRUE' ELSE FALSE END,
    IS_INTERNAL,
    APPLICATION_NAME,
    APPLICATION_SOURCE,
    LAST_INVALIDATION_REASON,
    BI.DISPLAY_STATEMENT_TEXT
)
SELECT
  BEGIN_TIME SNAPSHOT_TIME,
  LPAD(NUM, 7) NUM,
  HOST,
  PORT,
  SCHEMA_NAME,
  LOCATION,
  TABLES,
  STATEMENT_HASH,
  PLAN_ID,
  STORE,
  ENGINES,
  DB_USER,
  DISTRIBUTED DIST,
  MAP(IS_PINNED, 'TRUE', 'X', 'any', 'any', ' ') P,
  MAP(IS_INTERNAL, 'TRUE', 'X', ' ') I,
  MAP(SHARING_TYPE, 'GLOBAL', 'G', 'SESSION EXCLUSIVE GLOBAL', 'SEG', 'SESSION LOCAL', 'SL', 'LOGICAL SESSION GLOBAL', 'LSG', 'any', 'any', SHARING_TYPE) PST,
  SQL_TYPE TP,
  LPAD(REFERENCE_COUNT, 3) RC,
  INV_REASON,
  LPAD(EXECUTIONS, 12) EXECUTIONS,
  LPAD(RECORDS, 13) RECORDS,
  LPAD(TO_DECIMAL(REC_PER_EXEC, 10, 2), 12) REC_PER_EXEC,
  LPAD(TO_DECIMAL(ROUND(ELAPSED_MS), 12, 0), 12) ELAPSED_MS,
  LPAD(TO_DECIMAL(ELA_PER_EXEC_MS, 10, 2), 15) ELA_PER_EXEC_MS,
  LPAD(TO_DECIMAL(ELA_PER_REC_MS, 10, 2), 14) ELA_PER_REC_MS,
  LPAD(TO_DECIMAL(EXEC_PER_EXEC_MS, 10, 2), 16) EXEC_PER_EXEC_MS,
  LPAD(PREPARATIONS, 8) PREPS,
  LPAD(TO_DECIMAL(ROUND(PREP_MS), 10, 0), 10) PREP_MS,
  LPAD(TO_DECIMAL(ROUND(LOCK_WAIT_MS), 10, 0), 12) LOCK_WAIT_MS,
  LPAD(TO_DECIMAL(LOCK_PER_EXEC_MS, 10, 2), 16) LOCK_PER_EXEC_MS,
  LPAD(TO_DECIMAL(ROUND(CURSOR_MS), 10, 0), 10) CURSOR_MS,
  LPAD(TO_DECIMAL(CUR_PER_EXEC_MS, 10, 2), 15) CUR_PER_EXEC_MS,
  LPAD(TO_DECIMAL(ROUND(OPEN_MS), 10, 0), 10) OPEN_MS,
  LPAD(TO_DECIMAL(OPEN_PER_EXEC_MS, 10, 2), 16) OPEN_PER_EXEC_MS,
  LPAD(TO_DECIMAL(ROUND(FETCH_MS), 10, 0), 10) FETCH_MS,
  LPAD(TO_DECIMAL(FETCH_PER_EXEC_MS, 10, 2), 17) FETCH_PER_EXEC_MS,
  LPAD(NETWORK_REQ, 11) NETWORK_REQ,
  LPAD(TO_DECIMAL(NW_REQ_PER_EXEC, 10, 2), 15) NW_REQ_PER_EXEC,
  LPAD(TO_DECIMAL(NW_SIZE_MB / 1024, 10, 2), 10) NW_SIZE_GB,
  LPAD(TO_DECIMAL(NW_PER_EXEC_MB, 10, 2), 14) NW_PER_EXEC_MB,
  LPAD(TO_DECIMAL(ROUND(NETWORK_MS), 10, 0), 10) NETWORK_MS,
  LPAD(TO_DECIMAL(NW_PER_EXEC_MS, 10, 2), 14) NW_PER_EXEC_MS,
  LPAD(TO_DECIMAL(MEMORY_MB / 1024, 10, 2), 10) MEMORY_GB,
  LPAD(TO_DECIMAL(MEM_PER_EXEC_MB, 10, 2), 15) MEM_PER_EXEC_MB,
  LPAD(TO_DECIMAL(PLAN_MB, 10, 2), 10) PLAN_MB,
  LPAD(THREADS, 10) THREADS,
  LPAD(TO_DECIMAL(THR_PER_EXEC, 10, 2), 12) THR_PER_EXEC,
  APP_NAME,
  APP_SOURCE,
  REPLACE(REPLACE(REPLACE(STATEMENT_STRING, CHAR(9), CHAR(32)), CHAR(10), CHAR(32)), CHAR(13), CHAR(32)) STATEMENT_STRING
FROM
( SELECT
    BEGIN_TIME,
    NUM,
    HOST,
    PORT,
    SCHEMA_NAME,
    LOCATION,
    TABLES,
    DB_USER,
    STATEMENT_HASH,
    PLAN_ID,
    STORE,
    ENGINES,
    SHARING_TYPE,
    SQL_TYPE,
    INV_REASON,
    REFERENCE_COUNT,
    EXECUTIONS,
    RECORDS,
    REC_PER_EXEC,
    CURSOR_MS,
    CUR_PER_EXEC_MS,
    ELAPSED_MS,
    ELA_PER_EXEC_MS,
    ELA_PER_REC_MS,
    EXEC_MS,
    EXEC_PER_EXEC_MS,
    PREPARATIONS,
    PREP_MS,
    OPEN_MS,
    OPEN_PER_EXEC_MS,
    FETCH_MS,
    FETCH_PER_EXEC_MS,
    LOCK_WAIT_MS,
    LOCK_PER_EXEC_MS,
    NETWORK_REQ,
    NW_REQ_PER_EXEC,
    NW_SIZE_MB,
    NW_PER_EXEC_MB,
    NETWORK_MS,
    NW_PER_EXEC_MS,
    MEMORY_MB,
    MEM_PER_EXEC_MB,
    PLAN_KB / 1024 PLAN_MB,
    THREADS,
    THR_PER_EXEC,
    APP_NAME,
    APP_SOURCE,
    STATEMENT_STRING,
    DISTRIBUTED,
    IS_PINNED,
    IS_INTERNAL,
    RESULT_ROWS,
    ROW_NUMBER () OVER (ORDER BY BEGIN_TIME DESC, ORDER_VALUE DESC) ROW_NUM
  FROM
  ( SELECT
      CASE 
        WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), BEGIN_TIME) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(BEGIN_TIME, TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END BEGIN_TIME,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')         != 0 THEN HOST                ELSE MAP(BI_HOST, '%', 'any', BI_HOST)                          END HOST,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')         != 0 THEN TO_VARCHAR(PORT)    ELSE MAP(BI_PORT, '%', 'any', BI_PORT)                          END PORT,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SCHEMA')       != 0 THEN SCHEMA_NAME         ELSE MAP(BI_SCHEMA_NAME, '%', 'any', BI_SCHEMA_NAME)            END SCHEMA_NAME,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'LOCATION')     != 0 THEN TABLE_LOCATION      ELSE MAP(BI_TABLE_LOCATION, '%', 'any', BI_TABLE_LOCATION)      END LOCATION,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TABLES')       != 0 THEN TABLE_NAMES         ELSE 'any'                                                      END TABLES,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'DB_USER')      != 0 THEN USER_NAME           ELSE MAP(BI_DB_USER, '%', 'any', BI_DB_USER)                    END DB_USER,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')         != 0 THEN STATEMENT_HASH      ELSE MAP(BI_STATEMENT_HASH, '%', 'any', BI_STATEMENT_HASH)      END STATEMENT_HASH,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PLAN_ID')      != 0 THEN TO_VARCHAR(PLAN_ID) ELSE 'any'                                                      END PLAN_ID,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'STORE')        != 0 THEN STORE               ELSE MAP(BI_STORE, '%', 'any', BI_STORE)                        END STORE,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'ENGINES')      != 0 THEN ENGINES             ELSE MAP(BI_ENGINES, '%', 'any', BI_ENGINES)                    END ENGINES,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SHARING_TYPE') != 0 THEN SHARING_TYPE        ELSE MAP(BI_SHARING_TYPE, '%', 'any', BI_SHARING_TYPE)          END SHARING_TYPE,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')         != 0 THEN STATEMENT_STRING    ELSE 'any'                                                      END STATEMENT_STRING,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SQL_TYPE')     != 0 THEN SQL_TYPE            ELSE MAP(BI_SQL_TYPE, '%', 'any', 'DM', SQL_TYPE, BI_SQL_TYPE)  END SQL_TYPE,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'DIST')         != 0 THEN DISTRIBUTED         ELSE MAP(BI_IS_DIST, '%', 'any', BI_IS_DIST)                    END DISTRIBUTED,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PINNED')       != 0 THEN IS_PINNED           ELSE MAP(BI_IS_PINNED, '%', 'any', BI_IS_PINNED)                END IS_PINNED,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'INTERNAL')     != 0 THEN IS_INTERNAL         ELSE 'any'                                                      END IS_INTERNAL,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'APP_SOURCE')   != 0 THEN APPLICATION_SOURCE  ELSE MAP(BI_APP_SOURCE, '%', 'any', BI_APP_SOURCE)              END APP_SOURCE,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'APP_NAME')     != 0 THEN APPLICATION_NAME    ELSE MAP(BI_APP_NAME, '%', 'any', BI_APP_NAME)                  END APP_NAME,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'INV_REASON')   != 0 THEN INVALIDATION_REASON ELSE MAP(BI_INV_REASON, '%', 'any', BI_INV_REASON)              END INV_REASON,
      COUNT(*) NUM,
      SUM(REFERENCE_COUNT) REFERENCE_COUNT,
      SUM(EXECUTIONS) EXECUTIONS,
      SUM(RECORDS) RECORDS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(RECORDS) / SUM(EXECUTIONS)) REC_PER_EXEC,
      SUM(CURSOR_MS) CURSOR_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(CURSOR_MS) / SUM(EXECUTIONS)) CUR_PER_EXEC_MS,
      SUM(ELAPSED_MS) ELAPSED_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(ELAPSED_MS) / SUM(EXECUTIONS)) ELA_PER_EXEC_MS,
      MAP(GREATEST(SUM(EXECUTIONS), SUM(RECORDS)), 0, 0, SUM(ELAPSED_MS) / GREATEST(SUM(EXECUTIONS), SUM(RECORDS))) ELA_PER_REC_MS,
      SUM(EXEC_MS) EXEC_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(EXEC_MS) / SUM(EXECUTIONS)) EXEC_PER_EXEC_MS,
      SUM(PREPARATIONS) PREPARATIONS,
      SUM(PREP_MS) PREP_MS,
      SUM(OPEN_MS) OPEN_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(OPEN_MS) / SUM(EXECUTIONS)) OPEN_PER_EXEC_MS,
      SUM(FETCH_MS) FETCH_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(FETCH_MS) / SUM(EXECUTIONS)) FETCH_PER_EXEC_MS,
      SUM(LOCK_WAIT_MS) LOCK_WAIT_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(LOCK_WAIT_MS) / SUM(EXECUTIONS)) LOCK_PER_EXEC_MS,
      SUM(NETWORK_REQ) NETWORK_REQ,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(NETWORK_REQ) / SUM(EXECUTIONS)) NW_REQ_PER_EXEC,
      SUM(NETWORK_MB) NW_SIZE_MB,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(NETWORK_MB) / SUM(EXECUTIONS)) NW_PER_EXEC_MB,
      SUM(NETWORK_MS) NETWORK_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(NETWORK_MS) / SUM(EXECUTIONS)) NW_PER_EXEC_MS,
      SUM(MEMORY_MB) MEMORY_MB,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(MEMORY_MB) / SUM(EXECUTIONS)) MEM_PER_EXEC_MB,
      SUM(PLAN_KB) PLAN_KB,
      SUM(THREADS) THREADS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(THREADS) / SUM(EXECUTIONS)) THR_PER_EXEC,
      ORDER_BY,
      RESULT_ROWS,
      CASE ORDER_BY
        WHEN 'ELAPSED'       THEN SUM(ELAPSED_MS)
        WHEN 'EXEC'          THEN SUM(EXEC_MS)
        WHEN 'PREP'          THEN SUM(PREP_MS)
        WHEN 'CURSOR'        THEN SUM(CURSOR_MS)
        WHEN 'OPEN'          THEN SUM(OPEN_MS)
        WHEN 'FETCH'         THEN SUM(FETCH_MS)
        WHEN 'LOCK'          THEN SUM(LOCK_WAIT_MS)
        WHEN 'EXECUTIONS'    THEN SUM(EXECUTIONS)
        WHEN 'RECORDS'       THEN SUM(RECORDS)
        WHEN 'NETWORK_COUNT' THEN SUM(NETWORK_REQ)
        WHEN 'NETWORK_SIZE'  THEN SUM(NETWORK_MB)
        WHEN 'NETWORK_TIME'  THEN SUM(NETWORK_MS)
        WHEN 'MEMORY'        THEN SUM(MEMORY_MB)
        WHEN 'MEM_PER_EXEC'  THEN MAP(SUM(EXECUTIONS), 0, 0, SUM(MEMORY_MB) / SUM(EXECUTIONS))
        WHEN 'PLAN_MEM'      THEN SUM(PLAN_KB)
        WHEN 'THREAD'        THEN SUM(THREADS)
      END ORDER_VALUE
    FROM
    ( SELECT
        BEGIN_TIME,
        HOST,
        PORT,
        SCHEMA_NAME,
        TABLE_LOCATION,
        ACCESSED_TABLE_NAMES TABLE_NAMES,
        STATEMENT_HASH,
        SQL_TYPE,
        PLAN_ID,
        USER_NAME,
        STORE,
        ENGINES,
        SHARING_TYPE,
        REFERENCE_COUNT,
        IS_DISTRIBUTED_EXECUTION DISTRIBUTED,
        IS_PINNED_PLAN IS_PINNED,
        IS_INTERNAL,
        EXECUTION_COUNT EXECUTIONS,
        TOTAL_RESULT_RECORD_COUNT RECORDS,
        TOTAL_CURSOR_DURATION / 1000 CURSOR_MS,
        TOTAL_ELAPSED_TIME / 1000 ELAPSED_MS,
        TOTAL_PREPARATION_TIME / 1000 PREP_MS,
        PREPARATION_COUNT PREPARATIONS,
        TOTAL_EXECUTION_TIME / 1000 EXEC_MS,
        TOTAL_EXECUTION_OPEN_TIME / 1000 OPEN_MS,
        TOTAL_EXECUTION_FETCH_TIME / 1000 FETCH_MS,
        TOTAL_LOCK_WAIT_DURATION / 1000 LOCK_WAIT_MS,
        TOTAL_SERVICE_NETWORK_REQUEST_COUNT NETWORK_REQ,
        TOTAL_SERVICE_NETWORK_REQUEST_SIZE / 1024 / 1024 NETWORK_MB,
        TOTAL_SERVICE_NETWORK_REQUEST_DURATION / 1000 NETWORK_MS,
        TOTAL_EXECUTION_MEMORY_SIZE / 1024 / 1024 MEMORY_MB,
        PLAN_MEMORY_SIZE / 1024 PLAN_KB,
        TOTAL_CALLED_THREAD_COUNT THREADS,
        APPLICATION_SOURCE,
        APPLICATION_NAME,
        LAST_INVALIDATION_REASON INVALIDATION_REASON,
        STATEMENT_STRING,
        REPLACE(UPPER(LTRIM(MAP(SUBSTR(TO_VARCHAR(STATEMENT_STRING), 1, 2), '/*', SUBSTR(TO_VARCHAR(STATEMENT_STRING), LOCATE(TO_VARCHAR(STATEMENT_STRING), '*/') + 2), TO_VARCHAR(STATEMENT_STRING)), ' ({')), CHAR(10), '') STATEMENT_STRING_CLEANED,
        AGGREGATE_BY,
        TIME_AGGREGATE_BY,
        ORDER_BY,
        RESULT_ROWS,
        BI_HOST,
        BI_PORT,
        BI_SCHEMA_NAME,
        BI_TABLE_LOCATION,
        BI_DB_USER,
        BI_APP_NAME,
        BI_APP_SOURCE,
        BI_INV_REASON,
        BI_IS_PINNED,
        BI_STATEMENT_HASH,
        BI_SQL_TYPE,
        BI_IS_DIST,
        BI_SHARING_TYPE,
        BI_STORE,
        BI_ENGINES
      FROM
      ( SELECT
          C.*,
          MAP(BI.TIMESTAMP_TYPE, 
            'SERVER', CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE 
              C.SERVER_TIMESTAMP END, 
            'EXEC', CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.LAST_EXECUTION_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) 
              ELSE C.LAST_EXECUTION_TIMESTAMP END, 
            'PREP', CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.LAST_PREPARATION_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) 
              ELSE C.LAST_PREPARATION_TIMESTAMP END) BEGIN_TIME,
          BI.AGGREGATE_BY,
          BI.TIME_AGGREGATE_BY,
          BI.ORDER_BY,
          BI.RESULT_ROWS,
          BI.HOST BI_HOST,
          BI.PORT BI_PORT,
          BI.SCHEMA_NAME BI_SCHEMA_NAME,
          BI.TABLE_LOCATION BI_TABLE_LOCATION,
          BI.DB_USER BI_DB_USER,
          BI.APP_NAME BI_APP_NAME,
          BI.APP_SOURCE BI_APP_SOURCE,
          BI.INV_REASON BI_INV_REASON,
          BI.STATEMENT_HASH BI_STATEMENT_HASH,
          BI.SQL_TYPE BI_SQL_TYPE,
          BI.IS_DISTRIBUTED_EXECUTION BI_IS_DIST,
          BI.IS_PINNED_PLAN BI_IS_PINNED,
          BI.SHARING_TYPE BI_SHARING_TYPE,
          BI.STORE BI_STORE,
          BI.ENGINES BI_ENGINES
        FROM
          BASIS_INFO BI,
        ( SELECT
            DATA_SOURCE,
            HOST,
            PORT,
            SNAPSHOT_ID,
            SCHEMA_NAME,
            STATEMENT_HASH,
            PLAN_ID,
            USER_NAME,
            ACCESSED_TABLE_NAMES,
            STATEMENT_STRING,
            CASE
              WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER INDEX%'       THEN 'AI'
              WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER SYSTEM%'      THEN 'AS'
              WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER TABLE%'       THEN 'AT'
              WHEN STATEMENT_STRING_CLEANED LIKE 'ALTER%'             THEN 'AL'
              WHEN STATEMENT_STRING_CLEANED LIKE 'CALL%'              THEN 'CA'
              WHEN STATEMENT_STRING_CLEANED LIKE 'COMMIT%'            THEN 'CO'
              WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE INDEX%'      THEN 'CI'
              WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE TABLE%'      THEN 'CT'
              WHEN STATEMENT_STRING_CLEANED LIKE 'CREATE%'            THEN 'CR'
              WHEN STATEMENT_STRING_CLEANED LIKE 'DELETE%'            THEN 'DE'
              WHEN STATEMENT_STRING_CLEANED LIKE 'DROP INDEX%'        THEN 'DI'
              WHEN STATEMENT_STRING_CLEANED LIKE 'DROP TABLE%'        THEN 'DT'
              WHEN STATEMENT_STRING_CLEANED LIKE 'DROP%'              THEN 'DR'
              WHEN STATEMENT_STRING_CLEANED LIKE 'EXECUTE%'           THEN 'EX'
              WHEN STATEMENT_STRING_CLEANED LIKE 'INSERT%'            THEN 'IN'
              WHEN STATEMENT_STRING_CLEANED LIKE 'REPLACE%'           THEN 'RE'
              WHEN STATEMENT_STRING_CLEANED LIKE 'ROLLBACK%'          THEN 'RO'
              WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%FOR UPDATE%' THEN 'SU'
              WHEN STATEMENT_STRING_CLEANED LIKE 'SELECT%'            THEN 'SE'
              WHEN STATEMENT_STRING_CLEANED LIKE 'TRUNCATE%'          THEN 'TR'
              WHEN STATEMENT_STRING_CLEANED LIKE 'UPDATE%'            THEN 'UP'
              WHEN STATEMENT_STRING_CLEANED LIKE 'UPSERT%'            THEN 'US'
              WHEN STATEMENT_STRING_CLEANED LIKE 'WITH%'              THEN 'WI'
              ELSE 'unknown'
            END SQL_TYPE,
            STORE,
            ENGINES,
            SHARING_TYPE,
            MAX(REFERENCE_COUNT) REFERENCE_COUNT,
            SERVER_TIMESTAMP,
            IS_DISTRIBUTED_EXECUTION,
            IS_PINNED_PLAN,
            IS_INTERNAL,
            MAX(EXECUTION_COUNT) EXECUTION_COUNT,
            MAX(TOTAL_RESULT_RECORD_COUNT) TOTAL_RESULT_RECORD_COUNT,
            MAX(TOTAL_CURSOR_DURATION) TOTAL_CURSOR_DURATION,
            MAX(TOTAL_EXECUTION_TIME + TOTAL_PREPARATION_TIME) TOTAL_ELAPSED_TIME,
            MAX(TOTAL_EXECUTION_TIME) TOTAL_EXECUTION_TIME,
            MAX(TOTAL_EXECUTION_OPEN_TIME) TOTAL_EXECUTION_OPEN_TIME,
            MAX(TOTAL_EXECUTION_FETCH_TIME) TOTAL_EXECUTION_FETCH_TIME,
            MAX(TOTAL_PREPARATION_TIME) TOTAL_PREPARATION_TIME,
            MAX(PREPARATION_COUNT) PREPARATION_COUNT,
            MAX(TOTAL_LOCK_WAIT_DURATION) TOTAL_LOCK_WAIT_DURATION,
            MAX(LAST_PREPARATION_TIMESTAMP) LAST_PREPARATION_TIMESTAMP,
            MAX(LAST_EXECUTION_TIMESTAMP) LAST_EXECUTION_TIMESTAMP,
            MAX(TOTAL_SERVICE_NETWORK_REQUEST_COUNT) TOTAL_SERVICE_NETWORK_REQUEST_COUNT,
            MAX(TOTAL_SERVICE_NETWORK_REQUEST_DURATION) TOTAL_SERVICE_NETWORK_REQUEST_DURATION,
            MAX(TOTAL_SERVICE_NETWORK_REQUEST_SIZE) TOTAL_SERVICE_NETWORK_REQUEST_SIZE,
            MAX(TOTAL_CALLED_THREAD_COUNT) TOTAL_CALLED_THREAD_COUNT,
            MAX(TOTAL_EXECUTION_MEMORY_SIZE) TOTAL_EXECUTION_MEMORY_SIZE,
            TABLE_LOCATION,
            MAX(APPLICATION_SOURCE) APPLICATION_SOURCE,
            MAX(APPLICATION_NAME) APPLICATION_NAME,
            MAX(LAST_INVALIDATION_REASON) LAST_INVALIDATION_REASON,
            MAX(PLAN_MEMORY_SIZE) PLAN_MEMORY_SIZE
          FROM
            SQL_CACHE C
          GROUP BY
            DATA_SOURCE,
            HOST,
            PORT,
            SNAPSHOT_ID,
            SCHEMA_NAME,
            TABLE_LOCATION,
            STATEMENT_HASH,
            PLAN_ID,
            USER_NAME,
            ACCESSED_TABLE_NAMES,
            STATEMENT_STRING,
            STATEMENT_STRING_CLEANED,
            STORE,
            ENGINES,
            SHARING_TYPE,
            SERVER_TIMESTAMP,
            IS_DISTRIBUTED_EXECUTION,
            IS_PINNED_PLAN,
            IS_INTERNAL
        ) C
        WHERE
          C.HOST LIKE BI.HOST AND
          TO_VARCHAR(C.PORT) LIKE BI.PORT AND
          C.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
          C.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
          ( BI.TIMESTAMP_TYPE = 'SERVER' AND IFNULL(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) 
              ELSE C.SERVER_TIMESTAMP END, TO_TIMESTAMP('2000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')) BETWEEN BI.BEGIN_TIME AND BI.END_TIME OR
            BI.TIMESTAMP_TYPE = 'EXEC'   AND IFNULL(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.LAST_EXECUTION_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) 
              ELSE C.LAST_EXECUTION_TIMESTAMP END, TO_TIMESTAMP('2000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')) BETWEEN BI.BEGIN_TIME AND BI.END_TIME OR
            BI.TIMESTAMP_TYPE = 'PREP'   AND IFNULL(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(C.LAST_PREPARATION_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) 
              ELSE C.LAST_PREPARATION_TIMESTAMP END, TO_TIMESTAMP('2000/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS')) BETWEEN BI.BEGIN_TIME AND BI.END_TIME ) AND
          ( BI.TABLE_NAME = '%' OR C.ACCESSED_TABLE_NAMES LIKE '%.' || BI.TABLE_NAME || '(%' ) AND
          C.SHARING_TYPE LIKE BI.SHARING_TYPE AND
          UPPER(C.STATEMENT_STRING) LIKE UPPER(BI.SQL_PATTERN) AND
          ( BI.SQL_TYPE = 'DM' AND C.SQL_TYPE IN ('IN', 'UP', 'DE', 'SU', 'US' ) OR
            C.SQL_TYPE LIKE BI.SQL_TYPE
          ) AND
          IFNULL(C.USER_NAME, '') LIKE BI.DB_USER AND
          IFNULL(C.APPLICATION_SOURCE, '') LIKE BI.APP_SOURCE AND
          IFNULL(C.APPLICATION_NAME, '') LIKE BI.APP_NAME AND
          IFNULL(C.LAST_INVALIDATION_REASON, '') LIKE BI.INV_REASON AND
          C.DATA_SOURCE = BI.DATA_SOURCE AND
          C.IS_DISTRIBUTED_EXECUTION LIKE BI.IS_DISTRIBUTED_EXECUTION AND
          C.IS_PINNED_PLAN LIKE BI.IS_PINNED_PLAN AND
          ( BI.EXCLUDE_CURRENT_RANGE_RESTRICTION = ' ' OR UPPER(C.STATEMENT_STRING) NOT LIKE '%WITH RANGE_RESTRICTION(_CURRENT_)' ) AND
          ( BI.IS_INTERNAL = '%' OR BI.IS_INTERNAL = 'X' AND C.IS_INTERNAL = 'TRUE' OR BI.IS_INTERNAL = ' ' AND C.IS_INTERNAL = 'FALSE' ) AND
          IFNULL(C.STORE, '') LIKE BI.STORE AND
          IFNULL(C.ENGINES, '') LIKE BI.ENGINES AND
          ( BI.MIN_PLAN_SIZE_KB = -1 OR C.PLAN_MEMORY_SIZE / 1024 >= BI.MIN_PLAN_SIZE_KB ) AND
          C.TABLE_LOCATION LIKE BI.TABLE_LOCATION AND
          ( BI.ONLY_CROSS_NODE_JOINS = ' ' OR C.TABLE_LOCATION LIKE '%),%' )
      )
    )
    GROUP BY
      CASE 
        WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
          CASE 
            WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), BEGIN_TIME) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(BEGIN_TIME, TIME_AGGREGATE_BY)
          END
        ELSE 'any' 
      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')         != 0 THEN HOST                ELSE MAP(BI_HOST, '%', 'any', BI_HOST)                          END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')         != 0 THEN TO_VARCHAR(PORT)    ELSE MAP(BI_PORT, '%', 'any', BI_PORT)                          END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SCHEMA')       != 0 THEN SCHEMA_NAME         ELSE MAP(BI_SCHEMA_NAME, '%', 'any', BI_SCHEMA_NAME)            END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'LOCATION')     != 0 THEN TABLE_LOCATION      ELSE MAP(BI_TABLE_LOCATION, '%', 'any', BI_TABLE_LOCATION)      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TABLES')       != 0 THEN TABLE_NAMES         ELSE 'any'                                                      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'DB_USER')      != 0 THEN USER_NAME           ELSE MAP(BI_DB_USER, '%', 'any', BI_DB_USER)                    END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')         != 0 THEN STATEMENT_HASH      ELSE MAP(BI_STATEMENT_HASH, '%', 'any', BI_STATEMENT_HASH)      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PLAN_ID')      != 0 THEN TO_VARCHAR(PLAN_ID) ELSE 'any'                                                      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'STORE')        != 0 THEN STORE               ELSE MAP(BI_STORE, '%', 'any', BI_STORE)                        END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'ENGINES')      != 0 THEN ENGINES             ELSE MAP(BI_ENGINES, '%', 'any', BI_ENGINES)                    END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SHARING_TYPE') != 0 THEN SHARING_TYPE        ELSE MAP(BI_SHARING_TYPE, '%', 'any', BI_SHARING_TYPE)          END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')         != 0 THEN STATEMENT_STRING    ELSE 'any'                                                      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'SQL_TYPE')     != 0 THEN SQL_TYPE            ELSE MAP(BI_SQL_TYPE, '%', 'any', 'DM', SQL_TYPE, BI_SQL_TYPE)  END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'DIST')         != 0 THEN DISTRIBUTED         ELSE MAP(BI_IS_DIST, '%', 'any', BI_IS_DIST)                    END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PINNED')       != 0 THEN IS_PINNED           ELSE MAP(BI_IS_PINNED, '%', 'any', BI_IS_PINNED)                END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'INTERNAL')     != 0 THEN IS_INTERNAL         ELSE 'any'                                                      END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'APP_SOURCE')   != 0 THEN APPLICATION_SOURCE  ELSE MAP(BI_APP_SOURCE, '%', 'any', BI_APP_SOURCE)              END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'APP_NAME')     != 0 THEN APPLICATION_NAME    ELSE MAP(BI_APP_NAME, '%', 'any', BI_APP_NAME)                  END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'INV_REASON')   != 0 THEN INVALIDATION_REASON ELSE MAP(BI_INV_REASON, '%', 'any', BI_INV_REASON)              END,
      ORDER_BY,
      RESULT_ROWS
  )
)
WHERE
  ( RESULT_ROWS = -1 OR ROW_NUM <= RESULT_ROWS )
ORDER BY
  ROW_NUM
WITH HINT (IGNORE_PLAN_CACHE)
