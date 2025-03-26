WITH 

/* 

[NAME]

- HANA_Memory_TopConsumers_2.00.043+

[DESCRIPTION]

- Current and historic areas with highest memory requirements (tables, heap, ...)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_HEAP_ALLOCATORS only contains allocators with INCLUSIVE_SIZE_IN_USE > 1 GB, so the sum of used
  memory displayed can be smaller than expected
- M_HEAP_MEMORY.COMPONENT available starting with SAP HANA 1.0 SPS 10
- HOST_RS_INDEXES only available with Rev. 1.00.90 and higher and ESS
- "Row Store (Ext. Fragmentation)" considers the free space in row store that can be reused
- "Row Store (Ext. Frag. Garb.)" considers a special kind of typically garbage related fragmentation that is determined
  based on the difference of allocation in HOST_RS_MEMORY and GLOBAL_ROWSTORE_TABLES_SIZE, for technical join reasons the
  finest granularity is per hour.
- M_PERSISTENT_MEMORY_VOLUME_STATISTICS available starting with SAP HANA 2.00.030
- M_SERVICE_MEMORY.FRAGMENTED_MEMORY_SIZE available with SAP HANA >= 2.00.040
- HOST_COLUMN_TABLES_PART_SIZE.PERSISTENT_MEMORY_SIZE_IN_TOTAL available with SAP HANA >= 2.00.043

[VALID FOR]

- Revisions:              >= 2.00.043

[SQL COMMAND VERSION]

- 2014/03/06:  1.0 (initial version)
- 2015/04/27:  1.1 (ONLY_SQL_DATA_AREAS included)
- 2015/09/10:  1.2 (dedicated statement for Rev. >= 90 and ESS)
- 2016/06/15:  1.3 (Top 5 -> Top 10)
- 2016/08/14:  1.4 (dedicated vertical output variant)
- 2016/12/31:  1.5 (TIME_AGGREGATE_BY = 'TS<seconds>' included)
- 2017/03/09:  1.6 (EXCLUDE_SQL_DATA_AREAS included)
- 2017/10/25:  1.7 (TIMEZONE included)
- 2018/07/10:  1.8 (SUBAREA 'System - liveCache' included)
- 2018/09/02:  1.9 ("Row Store (Ext. Frag. Garb.)" included)
- 2018/11/20:  2.0 (consolidation of current and historic memory analysis)
- 2018/12/03:  2.1 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/03/16:  2.2 (ONLY_PERSISTENT_MEMORY_AREAS included)
- 2019/06/04:  2.3 (persistent memory details included)
- 2019/06/07:  2.4 (dedicated 2.00.040+ version including FRAGMENTED_MEMORY_SIZE)
- 2020/08/15:  2.5 (dedicated 2.00.043+ version including HOST_COLUMN_TABLES_PART_SIZE.PERSISTENT_MEMORY_SIZE_IN_TOTAL)
- 2023/12/21:  2.6 (EXCLUDE_HEAP_FRAGMENTATION included)

[INVOLVED TABLES]

- GLOBAL_ROWSTORE_TABLES_SIZE
- HOST_COLUMN_TABLES_PART_SIZE
- HOST_HEAP_ALLOCATORS
- HOST_RS_INDEXES
- HOST_RS_MEMORY
- HOST_SERVICE_MEMORY
- M_CS_TABLES
- M_HEAP_MEMORY
- M_PERSISTENT_MEMORY_VOLUME_STATISTICS
- M_RS_INDEXES
- M_RS_TABLES
- M_SERVICE_MEMORY

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

- AREA

  Memory area

  'ROW'           --> Row store
  'COLUMN'        --> Column store
  'HEAP'          --> Heap area
  '%'             --> No memory area restriction

- SUBAREA

  Memory sub-area

  'Row Store (Tables)' --> Only show row store tables
  'Heap (System)'      --> Only show memory areas related to heap component 'System'
  '%'                  --> No restriction related to memory sub area

- DETAIL

  Memory area detail (e.g. table name, heap area)

  'KONV'          --> Information related to detail KONV (table name on column store)
  '%'             --> No restriction to memory area details

- ONLY_SQL_DATA_AREAS

  Possibility to restrict results to heap areas linked to SQL statement data processing

  'X'             --> Only display heap areas linked to SQL statement data processing
  ' '             --> No restriction related to SQL statement data processing areas

- EXCLUDE_SQL_DATA_AREAS

  Possibility to restrict results to heap areas not linked to SQL statement data processing

  'X'             --> Only display heap areas not linked to SQL statement data processing
  ' '             --> No restriction related to SQL statement data processing areas

- EXCLUDE_HEAP_FRAGMENTATION

  Possiblity to exclude heap fragmentation (can be useful because snapshot interval for heap
  is different from other heap related histories and this can have an unexpected influence on
  the displayed results)

  'X'             --> Exclude heap fragmentation
  ' '             --> Also consider heap fragmentation

- MIN_TOTAL_USED_GB

  Lower limit for total memory size (GB)

  5               --> Only consider total sizes of at least 5 GB
  -1              --> No restriction related to size

- MIN_INDIVIDUAL_USED_GB

  Lower limit for individual memory size (GB)

  5               --> Only consider individual sizes of at least 5 GB
  -1              --> No restriction related to size

- OBJECT_LEVEL

  Controls display of partitions

  'PARTITION'     --> Result is shown on partition level
  'TABLE'         --> Result is shown on table level

- INCLUDE_OVERLAPPING_AREAS

  Controls the display of areas that are already covered differently (e.g. as part of column store, row store or stack)

  'X'             --> Overlapping areas are included (memory can be accounted twice)
  ' '             --> Overlapping areas are excluded

- ONLY_PERSISTENT_MEMORY_AREAS

  Possibility to restrict result to memory areas that can be moved to persistent memory (SAP Note 2700084, main storage)

  'X'             --> Only display memory areas that can be moved to persistent memory
  ' '             --> No restriction related to persistent memory
  
- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'DETAIL'        --> Aggregation by detail
  'HOST, PORT'    --> Aggregation by host and port

- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'SIZE'          --> Sorting by size 
  'COUNT'         --> Sorting by number of objects

[OUTPUT PARAMETERS]

- START_TIME:  Start time
- HOST:        Host name
- PORT:        Port
- AREA:        Area (HEAP for heap allocators, ROW for row store, COLUMN for column store, ...)
- SUBAREA:     Sub-area (e.g. heap component)
- DETAIL:      Detail (e.g. table name or heap allocator)
- USED_GB:     Used memory (GB)
- COUNT:       Number of objects
- SCHEMA_NAME: Schema name (in case of tables)

[EXAMPLE OUTPUT]

-----------------------------------------------------------------------------------------------------------------
|SNAPSHOT_TIME|KEY_FIGURE     |VALUE_TOTAL_GB|DETAIL                                           |VALUE_GB|PERCENT|
-----------------------------------------------------------------------------------------------------------------
|2018/01/15 20|Space used (GB)|      17371.30|Column Store (Main)                              |15850.98|  91.24|
|2018/01/15 20|Space used (GB)|      17371.30|Heap (System)                                    |  853.26|   4.91|
|2018/01/15 20|Space used (GB)|      17371.30|Heap (Column Store Tables)                       |  192.12|   1.10|
|2018/01/15 20|Space used (GB)|      17371.30|Row Store (Tables)                               |  118.40|   0.68|
|2018/01/15 20|Space used (GB)|      17371.30|Heap (System - Page Cache)                       |  110.96|   0.63|
|2018/01/15 20|Space used (GB)|      17371.30|Column Store (Delta)                             |   78.97|   0.45|
|2018/01/15 20|Space used (GB)|      17371.30|Heap (Monitoring & Statistical Data)             |   58.73|   0.33|
|2018/01/15 20|Space used (GB)|      17371.30|Heap (Statement Execution & Intermediate Results)|   37.07|   0.21|
|2018/01/15 20|Space used (GB)|      17371.30|Row Store (Indexes)                              |   17.56|   0.10|
|2018/01/15 20|Space used (GB)|      17371.30|Row Store (Ext. Fragmentation)                   |   14.59|   0.08|
|2018/01/15 20|Space used (GB)|      17371.30|Row Store (Int. Fragmentation)                   |   14.11|   0.08|
|2018/01/15 20|Space used (GB)|      17371.30|Stack                                            |   13.39|   0.07|
|2018/01/15 20|Space used (GB)|      17371.30|Code                                             |    9.52|   0.05|
|2018/01/15 20|Space used (GB)|      17371.30|-- Others --                                     |    1.58|   0.00|
|2018/01/15 19|Space used (GB)|      17206.97|Column Store (Main)                              |15836.35|  92.03|
|2018/01/15 19|Space used (GB)|      17206.97|Heap (System)                                    |  801.21|   4.65|
|2018/01/15 19|Space used (GB)|      17206.97|Heap (Column Store Tables)                       |  169.98|   0.98|
|2018/01/15 19|Space used (GB)|      17206.97|Row Store (Tables)                               |  118.40|   0.68|
|2018/01/15 19|Space used (GB)|      17206.97|Heap (System - Page Cache)                       |   94.73|   0.55|
|2018/01/15 19|Space used (GB)|      17206.97|Column Store (Delta)                             |   58.57|   0.34|
|2018/01/15 19|Space used (GB)|      17206.97|Heap (Statement Execution & Intermediate Results)|   36.88|   0.21|
|2018/01/15 19|Space used (GB)|      17206.97|Heap (Monitoring & Statistical Data)             |   21.14|   0.12|
|2018/01/15 19|Space used (GB)|      17206.97|Row Store (Indexes)                              |   17.56|   0.10|
|2018/01/15 19|Space used (GB)|      17206.97|Row Store (Ext. Fragmentation)                   |   14.59|   0.08|
|2018/01/15 19|Space used (GB)|      17206.97|Row Store (Int. Fragmentation)                   |   14.11|   0.08|
|2018/01/15 19|Space used (GB)|      17206.97|Stack                                            |   12.31|   0.07|
|2018/01/15 19|Space used (GB)|      17206.97|Code                                             |    9.52|   0.05|
|2018/01/15 19|Space used (GB)|      17206.97|-- Others --                                     |    1.54|   0.00|
-----------------------------------------------------------------------------------------------------------------

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
    SCHEMA_NAME,
    DETAIL,
    HOST,
    PORT,
    AREA,
    SUBAREA,
    ONLY_SQL_DATA_AREAS,
    EXCLUDE_SQL_DATA_AREAS,
    EXCLUDE_HEAP_FRAGMENTATION,
    MIN_TOTAL_USED_GB,
    MIN_INDIVIDUAL_USED_GB,
    OBJECT_LEVEL,
    INCLUDE_OVERLAPPING_AREAS,
    ONLY_PERSISTENT_MEMORY_AREAS,
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
  ( SELECT                                                      /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' HOST,
      '%' PORT,
      '%' SCHEMA_NAME,
      '%' AREA,                     /* ROW, COLUMN, TABLES, HEAP, PERSMEM, % */
      '%' SUBAREA,                  /* 'Row Store (Tables)', 'Row store (Indexes)', 'Row Store (Int. Fragmentation)', 'Row Store (Ext. Fragmentation)', 'Column Store (Main)', 'Column Store (Delta)', 'Column Store (Others)', 'Heap (Fragmentation)' or 'Heap (<component>)' */
      '%'  DETAIL,                   /* Name of table or heap area */
      ' ' ONLY_SQL_DATA_AREAS,
      ' ' EXCLUDE_SQL_DATA_AREAS,
      'X' EXCLUDE_HEAP_FRAGMENTATION,
      1 MIN_TOTAL_USED_GB,
      1 MIN_INDIVIDUAL_USED_GB,
      'TABLE' OBJECT_LEVEL,         /* TABLE, PARTITION */
      ' ' INCLUDE_OVERLAPPING_AREAS,
      ' ' ONLY_PERSISTENT_MEMORY_AREAS,
      'HISTORY' DATA_SOURCE,
      'DETAIL' AGGREGATE_BY,        /* TIME, SCHEMA, DETAIL, HOST, PORT, MAINAREA, SUBAREA or comma separated combinations, NONE for no aggregation */
      'NONE' TIME_AGGREGATE_BY,       /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
      'SIZE' ORDER_BY                /* SIZE, COUNT */
    FROM
      DUMMY
  ) 
),
SQL_DATA_AREAS AS
( SELECT 'Pool/AttributeEngine/Transient' ALLOCATOR              FROM DUMMY UNION ALL
  SELECT 'Pool/AttributeEngine/Transient/updateContainerConcat'  FROM DUMMY UNION ALL
  SELECT 'Pool/CalculationEngine/ceQOExecutor'                   FROM DUMMY UNION ALL
  SELECT 'Pool/CalculationEngine/query/pops'                     FROM DUMMY UNION ALL
  SELECT 'Pool/ColumnStoreTables/Delta'                          FROM DUMMY UNION ALL
  SELECT 'Pool/ColumnStoreTables/Main/Rowid/build-reverse-index' FROM DUMMY UNION ALL
  SELECT 'Pool/CSPlanExecutor/PlanExecution'                     FROM DUMMY UNION ALL
  SELECT 'Pool/DocidValueArray'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/ESX'                                              FROM DUMMY UNION ALL
  SELECT 'Pool/ExecutorPlanExecution'                            FROM DUMMY UNION ALL
  SELECT 'Pool/Federation/UniversalITab'                         FROM DUMMY UNION ALL
  SELECT 'Pool/Filter'                                           FROM DUMMY UNION ALL
  SELECT 'Pool/itab'                                             FROM DUMMY UNION ALL
  SELECT 'Pool/itab/expr'                                        FROM DUMMY UNION ALL
  SELECT 'Pool/itab/FindBlocks2'                                 FROM DUMMY UNION ALL
  SELECT 'Pool/itab/VectorColumn'                                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator'                                    FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/DictsAndDocs'                       FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAggregate'                        FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAggregate/Results'                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAssembleResults'                  FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEAssembleResults/Results'          FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate'                        FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate/TmpResults'             FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECalculate/Results'                FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JECreateNTuple'                     FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEEvalPrecond'                      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEPlanData/deserialized'            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEPreAggregate'                     FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JERequestedAttributes/Results'      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEStep1'                            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/JEStep2'                            FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/NTuple'                             FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/PlanDataAttrVals/Deserialized'      FROM DUMMY UNION ALL
  SELECT 'Pool/JoinEvaluator/ValueList'                          FROM DUMMY UNION ALL
  SELECT 'Pool/LargeObjectPool'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/L/llang/Runtime/Global'                           FROM DUMMY UNION ALL
  SELECT 'Pool/L/llang/Runtime/Local'                            FROM DUMMY UNION ALL
  SELECT 'Pool/LOBStorage'                                       FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcengine.so'                       FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcengineapi.so'                    FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcalcenginepops.so'                   FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcs.so'                               FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbcswrapper.so'                        FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbdistmetadata.so'                     FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbevaluator.so'                        FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbitab.so'                             FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbolap.so'                             FROM DUMMY UNION ALL
  SELECT 'Pool/malloc/libhdbunivitab.so'                         FROM DUMMY UNION ALL
  SELECT 'Pool/mds'                                              FROM DUMMY UNION ALL
  SELECT 'Pool/MDS/CellStorage/CellStorageTupleIndexer'          FROM DUMMY UNION ALL
  SELECT 'Pool/mds/CubeAxis'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/aggregates'                              FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/align'                                   FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/compactcol'                              FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/ihm'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/pop'                                     FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_aggregates'                         FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_dimensions'                         FROM DUMMY UNION ALL
  SELECT 'Pool/parallel/temp_other'                              FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/LOB'                                    FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/MonitorView%'                           FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryCompilation'                       FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryExecution'                         FROM DUMMY UNION ALL
  SELECT 'Pool/RowEngine/QueryExecution/SearchAlloc'             FROM DUMMY UNION ALL
  SELECT 'Pool/SearchAPI'                                        FROM DUMMY UNION ALL
  SELECT 'Pool/SearchAPI/Itab Search'                            FROM DUMMY UNION ALL
  SELECT 'Pool/SQLScript/Execution'                              FROM DUMMY UNION ALL
  SELECT 'Pool/StringContainer'                                  FROM DUMMY UNION ALL
  SELECT 'Pool/Text/TextAttribute'                               FROM DUMMY UNION ALL
  SELECT 'Pool/ValueArray'                                       FROM DUMMY UNION ALL
  SELECT 'Pool/ValueArrayColumnDeserialize'                      FROM DUMMY UNION ALL
  SELECT 'Pool/XDictData'                                        FROM DUMMY
)
SELECT
  START_TIME,
  HOST,
  LPAD(PORT, 5) PORT,
  AREA,
  SUBAREA,
  DETAIL,
  LPAD(TO_DECIMAL(USED_GB, 10, 2), 8) USED_GB,
  LPAD(TO_DECIMAL(ROUND(COUNT), 10, 0), 6) COUNT,
  SCHEMA_NAME
FROM
( SELECT
    CASE 
      WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE START_TIME END) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE START_TIME END, TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END START_TIME,
    HOST,
    PORT,
    AREA,
    SUBAREA,
    DETAIL,
    SCHEMA_NAME,
    AVG(USED_GB) USED_GB,
    SUM(ALLOC_GB) ALLOC_GB,
    AVG(COUNT) COUNT,
    MIN_TOTAL_USED_GB,
    ORDER_BY
  FROM
  ( SELECT
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(D.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP))        ELSE D.SERVER_TIMESTAMP                              END START_TIME,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')       != 0 THEN D.HOST                                       ELSE MAP(BI.HOST,        '%', 'any', BI.HOST)        END HOST,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')       != 0 THEN TO_VARCHAR(D.PORT)                           ELSE MAP(BI.PORT,        '%', 'any', BI.PORT)        END PORT,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MAINAREA')   != 0 THEN D.AREA                                       ELSE MAP(BI.AREA,        '%', 'any', BI.AREA)        END AREA,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SUBAREA')    != 0 THEN D.SUBAREA                                    ELSE MAP(BI.SUBAREA,     '%', 'any', BI.SUBAREA)     END SUBAREA,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DETAIL')     != 0 THEN MAP(BI.OBJECT_LEVEL, 'TABLE', D.DETAIL,
                                        D.DETAIL || MAP(D.PART_ID, -1, '', 0, '', ' (P' || D.PART_ID || ')'))                           ELSE MAP(BI.DETAIL,      '%', 'any', BI.DETAIL)      END DETAIL,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SCHEMA')     != 0 THEN D.SCHEMA_NAME                                ELSE MAP(BI.SCHEMA_NAME, '%', 'any', BI.SCHEMA_NAME) END SCHEMA_NAME,
      SUM(D.USED_BYTE) / 1024 / 1024 / 1024 USED_GB,
      SUM(D.ALLOC_BYTE) / 1024 / 1024 / 1024 ALLOC_GB,
      COUNT(*) COUNT,
      BI.TIMEZONE,
      BI.AGGREGATE_BY,
      BI.TIME_AGGREGATE_BY,
      BI.MIN_TOTAL_USED_GB,
      BI.ORDER_BY
    FROM
      BASIS_INFO BI,
    ( SELECT
        'HISTORY' DATA_SOURCE,
        'COLUMN' AREA,
        L.SUBAREA,
        CT.SERVER_TIMESTAMP,
        CT.SCHEMA_NAME,
        CT.TABLE_NAME DETAIL,
        CT.PART_ID,
        CT.HOST,
        CT.PORT,
        CT.RECORD_COUNT NUM_ROWS,
        CASE L.SUBAREA
          WHEN 'Column Store (Others)' THEN CT.MEMORY_SIZE_IN_TOTAL - CT.MEMORY_SIZE_IN_MAIN - CT.MEMORY_SIZE_IN_DELTA
          WHEN 'Column Store (Main)'   THEN CT.MEMORY_SIZE_IN_MAIN + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL
          WHEN 'Column Store (Delta)'  THEN CT.MEMORY_SIZE_IN_DELTA
        END ALLOC_BYTE,
        CASE L.SUBAREA
          WHEN 'Column Store (Others)' THEN CT.MEMORY_SIZE_IN_TOTAL - CT.MEMORY_SIZE_IN_MAIN - CT.MEMORY_SIZE_IN_DELTA
          WHEN 'Column Store (Main)'   THEN CT.MEMORY_SIZE_IN_MAIN + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL
          WHEN 'Column Store (Delta)'  THEN CT.MEMORY_SIZE_IN_DELTA
        END USED_BYTE
      FROM
      ( SELECT 'Column Store (Others)' SUBAREA FROM DUMMY UNION ALL
        SELECT 'Column Store (Main)'           FROM DUMMY UNION ALL
        SELECT 'Column Store (Delta)'          FROM DUMMY
      ) L,
        _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE CT
      UNION ALL
      SELECT
        'CURRENT' DATA_SOURCE,
        'COLUMN' AREA,
        L.SUBAREA,
        CURRENT_TIMESTAMP SERVER_TIMESTAMP,
        CT.SCHEMA_NAME,
        CT.TABLE_NAME DETAIL,
        CT.PART_ID,
        CT.HOST,
        CT.PORT,
        CT.RECORD_COUNT NUM_ROWS,
        CASE L.SUBAREA
          WHEN 'Column Store (Others)' THEN CT.MEMORY_SIZE_IN_TOTAL - CT.MEMORY_SIZE_IN_MAIN - CT.MEMORY_SIZE_IN_DELTA
          WHEN 'Column Store (Main)'   THEN CT.MEMORY_SIZE_IN_MAIN + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL
          WHEN 'Column Store (Delta)'  THEN CT.MEMORY_SIZE_IN_DELTA
        END ALLOC_BYTE,
        CASE L.SUBAREA
          WHEN 'Column Store (Others)' THEN CT.MEMORY_SIZE_IN_TOTAL - CT.MEMORY_SIZE_IN_MAIN - CT.MEMORY_SIZE_IN_DELTA
          WHEN 'Column Store (Main)'   THEN CT.MEMORY_SIZE_IN_MAIN + CT.PERSISTENT_MEMORY_SIZE_IN_TOTAL
          WHEN 'Column Store (Delta)'  THEN CT.MEMORY_SIZE_IN_DELTA
        END USED_BYTE
      FROM
      ( SELECT 'Column Store (Others)' SUBAREA FROM DUMMY UNION ALL
        SELECT 'Column Store (Main)'           FROM DUMMY UNION ALL
        SELECT 'Column Store (Delta)'          FROM DUMMY
      ) L,
        M_CS_TABLES CT
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Tables)' SUBAREA,
          TO_TIMESTAMP(TO_VARCHAR(RT.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')) SERVER_TIMESTAMP,
          RT.SCHEMA_NAME,
          RT.TABLE_NAME DETAIL,
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          RT.RECORD_COUNT NUM_ROWS,
          RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE ALLOC_BYTE,
          RT.USED_FIXED_PART_SIZE + RT.USED_VARIABLE_PART_SIZE USED_BYTE
        FROM
          _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE RT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Tables)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          RT.SCHEMA_NAME,
          RT.TABLE_NAME DETAIL,
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          RT.RECORD_COUNT NUM_ROWS,
          RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE ALLOC_BYTE,
          RT.USED_FIXED_PART_SIZE + RT.USED_VARIABLE_PART_SIZE USED_BYTE
        FROM
          M_RS_TABLES RT
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Int. Fragmentation)' SUBAREA,
          TO_TIMESTAMP(TO_VARCHAR(RT.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')) SERVER_TIMESTAMP,
          ' ',
          'Row store (Int. Fragmentation)',
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          0 NUM_ROWS,
          SUM(RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE - RT.USED_FIXED_PART_SIZE - RT.USED_VARIABLE_PART_SIZE ) ALLOC_BYTE,
          SUM(RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE - RT.USED_FIXED_PART_SIZE - RT.USED_VARIABLE_PART_SIZE ) USED_BYTE
        FROM
          _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE RT
        GROUP BY
          SERVER_TIMESTAMP,
          HOST,
          PORT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Int. Fragmentation)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ',
          'Row store (Int. Fragmentation)',
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          0 NUM_ROWS,
          SUM(RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE - RT.USED_FIXED_PART_SIZE - RT.USED_VARIABLE_PART_SIZE ) ALLOC_BYTE,
          SUM(RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE - RT.USED_FIXED_PART_SIZE - RT.USED_VARIABLE_PART_SIZE ) USED_BYTE
        FROM
          M_RS_TABLES RT
        GROUP BY
          CURRENT_TIMESTAMP,
          HOST,
          PORT
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Indexes)' SUBAREA,
          TO_TIMESTAMP(TO_VARCHAR(RT.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')) SERVER_TIMESTAMP,
          RT.SCHEMA_NAME,
          RT.TABLE_NAME DETAIL,
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          0 NUM_ROWS,
          RT.INDEX_SIZE ALLOC_BYTE,
          RT.INDEX_SIZE USED_BYTE
        FROM
          _SYS_STATISTICS.HOST_RS_INDEXES RT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Indexes)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          RT.SCHEMA_NAME,
          RT.TABLE_NAME DETAIL,
          0 PART_ID,
          RT.HOST,
          RT.PORT,
          0 NUM_ROWS,
          RT.INDEX_SIZE ALLOC_BYTE,
          RT.INDEX_SIZE USED_BYTE
        FROM
          M_RS_INDEXES RT
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'HEAP',
          'Heap' || CHAR(32) || '(' || COMPONENT || 
            CASE 
              WHEN CATEGORY LIKE 'Pool/CS/BufferPage'                                                                            THEN CHAR(32) || '-' || CHAR(32) || 'Column Store Tables'
              WHEN CATEGORY LIKE 'Pool/PersistenceManager/PersistentSpace%/Default%Page'                                         THEN CHAR(32) || '-' || CHAR(32) || 'Page Cache'
              WHEN CATEGORY LIKE 'Pool/LVCAllocator%' OR CATEGORY LIKE 'Pool/PersistenceManager/PersistentSpace%/StaticLPA/Page' THEN CHAR(32) || '-' || CHAR(32) || 'liveCache'
              ELSE '' 
            END || ')' SUBAREA,
          HA.SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          HA.CATEGORY,
          0 PART_ID,
          HA.HOST,
          HA.PORT,
          HA.EXCLUSIVE_ALLOCATED_COUNT NUM_ROWS,
          HA.EXCLUSIVE_ALLOCATED_SIZE - LEAD(HA.EXCLUSIVE_ALLOCATED_SIZE, 1) OVER (PARTITION BY CATEGORY, HOST, PORT ORDER BY SERVER_TIMESTAMP DESC),
          HA.EXCLUSIVE_SIZE_IN_USE
        FROM
          _SYS_STATISTICS.HOST_HEAP_ALLOCATORS HA
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'HEAP',
          'Heap' || CHAR(32) || '(' || COMPONENT || 
            CASE 
              WHEN CATEGORY LIKE 'Pool/PersistenceManager/PersistentSpace%/Default%Page'                                         THEN CHAR(32) || '-' || CHAR(32) || 'Page Cache'
              WHEN CATEGORY LIKE 'Pool/LVCAllocator%' OR CATEGORY LIKE 'Pool/PersistenceManager/PersistentSpace%/StaticLPA/Page' THEN CHAR(32) || '-' || CHAR(32) || 'liveCache'
              ELSE '' 
            END || ')' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          HA.CATEGORY,
          0 PART_ID,
          HA.HOST,
          HA.PORT,
          HA.EXCLUSIVE_ALLOCATED_COUNT NUM_ROWS,
          HA.EXCLUSIVE_ALLOCATED_SIZE,
          HA.EXCLUSIVE_SIZE_IN_USE
        FROM
          M_HEAP_MEMORY HA
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'PERSMEM' AREA,
          'Persistent Memory' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ',
          'Persistent Memory',
          0,
          HOST,
          PORT,
          0,
          SUM(TOTAL_ACTIVE_SIZE),
          SUM(TOTAL_ACTIVE_SIZE)
        FROM
          M_PERSISTENT_MEMORY_VOLUME_STATISTICS
        GROUP BY
          HOST,
          PORT
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Ext. Fragmentation)' SUBAREA,
          TO_TIMESTAMP(TO_VARCHAR(SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')) SERVER_TIMESTAMP,
          ' ',
          'Row Store (Ext. Fragmentation)',
          0,
          HOST,
          PORT,
          0,
          SUM(FREE_SIZE),
          SUM(FREE_SIZE)
        FROM
          _SYS_STATISTICS.HOST_RS_MEMORY
        WHERE
          CATEGORY IN ('CATALOG', 'TABLE')
        GROUP BY
          SERVER_TIMESTAMP,
          HOST,
          PORT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Ext. Fragmentation)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ',
          'Row Store (Ext. Fragmentation)',
          0,
          HOST,
          PORT,
          0,
          SUM(FREE_SIZE),
          SUM(FREE_SIZE)
        FROM
          M_RS_MEMORY
        WHERE
          CATEGORY IN ('CATALOG', 'TABLE')
        GROUP BY
          HOST,
          PORT
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Ext. Frag. Garb.)' SUBAREA,
          TO_TIMESTAMP(TO_VARCHAR(M.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24'), 'YYYY/MM/DD HH24') SERVER_TIMESTAMP,
          ' ',
          'Row Store (Ext. Frag. Garb.)',
          0,
          M.HOST,
          M.PORT,
          0,
          GREATEST(AVG(M.GROSS_ALLOC) - AVG(T.NET_ALLOC), 0),
          GREATEST(AVG(M.GROSS_ALLOC) - AVG(T.NET_ALLOC), 0)
        FROM
        ( SELECT
            HOST,
            PORT,
            SERVER_TIMESTAMP,
            SUM(ALLOCATED_SIZE - FREE_SIZE) GROSS_ALLOC
          FROM
            _SYS_STATISTICS.HOST_RS_MEMORY
          WHERE
            CATEGORY = 'TABLE'
          GROUP BY
            HOST,
            PORT,
            SERVER_TIMESTAMP
        ) M,
        ( SELECT
            HOST,
            PORT,
            SERVER_TIMESTAMP,
            SUM(ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE) NET_ALLOC
          FROM
            _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE
          GROUP BY
            HOST,
            PORT,
            SERVER_TIMESTAMP
        ) T
        WHERE
          M.HOST = T.HOST AND
          M.PORT = T.PORT AND
          TO_VARCHAR(M.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24') = TO_VARCHAR(T.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24')
        GROUP BY
          TO_VARCHAR(M.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24'),
          M.HOST,
          M.PORT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'ROW' AREA,
          'Row Store (Ext. Frag. Garb.)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ',
          'Row Store (Ext. Frag. Garb.)',
          0,
          M.HOST,
          M.PORT,
          0,
          GREATEST(AVG(M.GROSS_ALLOC) - AVG(T.NET_ALLOC), 0),
          GREATEST(AVG(M.GROSS_ALLOC) - AVG(T.NET_ALLOC), 0)
        FROM
        ( SELECT
            HOST,
            PORT,
            SUM(ALLOCATED_SIZE - FREE_SIZE) GROSS_ALLOC
          FROM
            M_RS_MEMORY
          WHERE
            CATEGORY = 'TABLE'
          GROUP BY
            HOST,
            PORT
        ) M,
        ( SELECT
            HOST,
            PORT,
            SUM(ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE) NET_ALLOC
          FROM
            M_RS_TABLES
          GROUP BY
            HOST,
            PORT
        ) T
        WHERE
          M.HOST = T.HOST AND
          M.PORT = T.PORT
        GROUP BY
          M.HOST,
          M.PORT
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'HEAP' AREA,
          'Heap (Fragmentation)' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'Heap (Fragmentation)' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          SM.FRAGMENTED_MEMORY_SIZE,
          SM.FRAGMENTED_MEMORY_SIZE
        FROM
          M_SERVICE_MEMORY SM
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'HEAP' AREA,
          'Heap (Fragmentation)' SUBAREA,
          SM.SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'Heap (Fragmentation)' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          SM.FRAGMENTED_MEMORY_SIZE,
          SM.FRAGMENTED_MEMORY_SIZE
        FROM
          _SYS_STATISTICS.HOST_SERVICE_MEMORY SM
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'CODE' AREA,
          'Code' SUBAREA,
          SM.SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'CODE' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          AVG(SM.CODE_SIZE) OVER (PARTITION BY SM.HOST, SM.SERVER_TIMESTAMP) / COUNT(*) OVER (PARTITION BY SM.HOST, SM.SERVER_TIMESTAMP),
          AVG(SM.CODE_SIZE) OVER (PARTITION BY SM.HOST, SM.SERVER_TIMESTAMP) / COUNT(*) OVER (PARTITION BY SM.HOST, SM.SERVER_TIMESTAMP)
        FROM
          _SYS_STATISTICS.HOST_SERVICE_MEMORY SM
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'CODE' AREA,
          'Code' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'CODE' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          AVG(SM.CODE_SIZE) OVER (PARTITION BY SM.HOST) / COUNT(*) OVER (PARTITION BY SM.HOST),
          AVG(SM.CODE_SIZE) OVER (PARTITION BY SM.HOST) / COUNT(*) OVER (PARTITION BY SM.HOST)
        FROM
          M_SERVICE_MEMORY SM
      )
      UNION ALL
      ( SELECT
          'HISTORY' DATA_SOURCE,
          'STACK' AREA,
          'Stack' SUBAREA,
          SM.SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'STACK' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          SM.STACK_SIZE,
          SM.STACK_SIZE
        FROM
          _SYS_STATISTICS.HOST_SERVICE_MEMORY SM
      )
      UNION ALL
      ( SELECT
          'CURRENT' DATA_SOURCE,
          'STACK' AREA,
          'Stack' SUBAREA,
          CURRENT_TIMESTAMP SERVER_TIMESTAMP,
          ' ' SCHEMA_NAME,
          'STACK' CATEGORY,
          0 PART_ID,
          SM.HOST,
          SM.PORT,
          0 NUM_ROWS,
          SM.STACK_SIZE,
          SM.STACK_SIZE
        FROM
          M_SERVICE_MEMORY SM
      )
    ) D      
  WHERE
    D.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    D.DETAIL LIKE BI.DETAIL AND
    D.HOST LIKE BI.HOST AND
    TO_VARCHAR(D.PORT) LIKE BI.PORT AND
    ( BI.DATA_SOURCE = 'CURRENT' OR
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(D.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE D.SERVER_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME
    ) AND
    ( BI.AREA = 'TABLES' AND D.AREA IN ('ROW', 'COLUMN') OR
      D.AREA LIKE BI.AREA ) AND
    UPPER(D.SUBAREA) LIKE UPPER(BI.SUBAREA) AND
    D.DATA_SOURCE LIKE BI.DATA_SOURCE AND
    ( BI.MIN_INDIVIDUAL_USED_GB = -1 OR D.USED_BYTE / 1024 / 1024 / 1024 >= BI.MIN_INDIVIDUAL_USED_GB ) AND
    ( BI.INCLUDE_OVERLAPPING_AREAS = 'X' OR
      D.AREA NOT IN ( 'HEAP', 'PERSMEM' ) OR
      D.DETAIL LIKE 'Pool/ColumnStore%/Delta' OR
      D.DETAIL LIKE 'Pool/ColumnStore%/System' OR
      D.DETAIL LIKE 'Pool/ColumnStore%/Main/Rowid/build-reverse-index' OR
      ( D.DETAIL NOT LIKE 'Pool/AttributeEngine%' AND
        D.DETAIL NOT LIKE 'Pool/ColumnStore%' AND
        D.DETAIL != 'Pool/CS/BufferPage' AND
        D.DETAIL NOT LIKE 'Pool/Text/AEText%' AND
        D.DETAIL NOT IN
        ( 'Persistent Memory',
          'Pool/FuzzySearch',
          'Pool/malloc/libhdbcstypes.so',
          'Pool/NameIdMapping/RoDict',
          'Pool/PersistenceManager/PersistentSpace/RowStoreLPA/RowStoreSegment',
          'Pool/RowEngine/CpbTree',
          'Pool/RowStoreTables/CpbTree',
          'Pool/SerializedObject',
          'StackAllocator'
        )
      ) 
    ) AND
    ( BI.ONLY_SQL_DATA_AREAS    = ' '     OR     EXISTS ( SELECT ALLOCATOR FROM SQL_DATA_AREAS S WHERE D.DETAIL LIKE S.ALLOCATOR ) ) AND
    ( BI.EXCLUDE_SQL_DATA_AREAS = ' '     OR NOT EXISTS ( SELECT ALLOCATOR FROM SQL_DATA_AREAS S WHERE D.DETAIL LIKE S.ALLOCATOR ) ) AND
    ( BI.EXCLUDE_HEAP_FRAGMENTATION = ' ' OR D.SUBAREA != 'Heap (Fragmentation)' ) AND
    ( BI.ONLY_PERSISTENT_MEMORY_AREAS = ' ' OR
      D.DETAIL LIKE 'Pool/ColumnStore%/Main%' OR
      D.DETAIL IN ('Persistent Memory', 'Pool/Text/AEText/termset_container', 'Pool/SerializedObject')
    )
    GROUP BY
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(D.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP))        ELSE D.SERVER_TIMESTAMP                              END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')       != 0 THEN D.HOST                                       ELSE MAP(BI.HOST,        '%', 'any', BI.HOST)        END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')       != 0 THEN TO_VARCHAR(D.PORT)                           ELSE MAP(BI.PORT,        '%', 'any', BI.PORT)        END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MAINAREA')   != 0 THEN D.AREA                                       ELSE MAP(BI.AREA,        '%', 'any', BI.AREA)        END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SUBAREA')    != 0 THEN D.SUBAREA                                    ELSE MAP(BI.SUBAREA,     '%', 'any', BI.SUBAREA)     END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'DETAIL')     != 0 THEN MAP(BI.OBJECT_LEVEL, 'TABLE', D.DETAIL,
                                        D.DETAIL || MAP(D.PART_ID, -1, '', 0, '', ' (P' || D.PART_ID || ')'))                           ELSE MAP(BI.DETAIL,      '%', 'any', BI.DETAIL)      END,
      CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SCHEMA')     != 0 THEN D.SCHEMA_NAME                                ELSE MAP(BI.SCHEMA_NAME, '%', 'any', BI.SCHEMA_NAME) END,
      BI.TIMEZONE,
      BI.AGGREGATE_BY,
      BI.TIME_AGGREGATE_BY,
      BI.MIN_TOTAL_USED_GB,
      BI.ORDER_BY
  )
  GROUP BY
    CASE 
      WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE START_TIME END) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE START_TIME END, TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    HOST,
    PORT,
    AREA,
    SUBAREA,
    DETAIL,
    SCHEMA_NAME,
    MIN_TOTAL_USED_GB,
    ORDER_BY
)
WHERE
  ( MIN_TOTAL_USED_GB = -1 OR USED_GB >= MIN_TOTAL_USED_GB )
ORDER BY
  START_TIME DESC,
  MAP(ORDER_BY, 'SIZE', USED_GB, 'COUNT', COUNT) DESC

