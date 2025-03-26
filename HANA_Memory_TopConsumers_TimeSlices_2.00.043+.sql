WITH

/* 

[NAME]

- HANA_Memory_TopConsumers_TimeSlices_2.00.043+

[DESCRIPTION]

- Areas in history with highest memory requirements (tables, heap, ...)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_HEAP_ALLOCATORS only contains allocators with INCLUSIVE_SIZE_IN_USE > 1 GB, so the sum of used
  memory displayed can be smaller than expected
- HOST_RS_INDEXES only available with Rev. 90 and higher and ESS
- M_HEAP_MEMORY.COMPONENT available starting with SAP HANA 1.0 SPS 10
- KEY_FIGURE = 'ALLOCATED' reports the memory allocated over time and not the currently allocated memory
- "Row Store (Ext. Fragmentation)" considers the free space in row store that can be reused
- "Row Store (Ext. Frag. Garb.)" considers a special kind of typically garbage related fragmentation that is determined
  based on the difference of allocation in HOST_RS_MEMORY and GLOBAL_ROWSTORE_TABLES_SIZE, for technical join reasons the
  finest granularity is per hour.
- HOST_COLUMN_TABLES_PART_SIZE.PERSISTENT_MEMORY_SIZE_IN_TOTAL available with SAP HANA >= 2.00.043
- M_SERVICE_MEMORY.FRAGMENTED_MEMORY_SIZE available with SAP HANA >= 2.00.040

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2014/03/06:  1.0 (initial version)
- 2015/04/27:  1.1 (ONLY_SQL_DATA_AREAS included)
- 2015/09/10:  1.2 (dedicated statement for Rev. >= 90 and ESS)
- 2016/06/15:  1.3 (Top 5 -> Top 10)
- 2016/12/31:  1.4 (TIME_AGGREGATE_BY = 'TS<seconds>' included)
- 2017/03/09:  1.5 (EXCLUDE_SQL_DATA_AREAS included)
- 2017/03/13:  1.6 (SUBAREA included)
- 2017/10/25:  1.7 (TIMEZONE included)
- 2018/07/10:  1.8 (SUBAREA 'System - liveCache' included)
- 2018/09/02:  1.9 ("Row Store (Ext. Frag. Garb.)" included)
- 2018/12/05:  2.0 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2019/06/07:  2.1 (dedicated 2.00.040+ version including FRAGMENTED_MEMORY_SIZE)
- 2020/08/15:  2.2 (dedicated 2.00.043+ version including HOST_COLUMN_TABLES_PART_SIZE.PERSISTENT_MEMORY_SIZE_IN_TOTAL)
- 2023/12/21:  2.3 (EXCLUDE_HEAP_FRAGMENTATION included)

[INVOLVED TABLES]

- HOST_HEAP_ALLOCATORS
- HOST_COLUMN_TABLES_PART_SIZE
- GLOBAL_ROWSTORE_TABLES_SIZE
- HOST_RS_INDEXES
- HOST_RS_MEMORY
- HOST_SERVICE_MEMORY

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

- MIN_TOTAL_SIZE_GB

  Lower limit for total I/O size (GB)

  5               --> Only consider sizes of at least 5 GB
  -1              --> No restriction related to size

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'DETAIL'        --> Aggregation by detail
  'HOST, SERVICE' --> Aggregation by host and service (if multiple choices are possible)

- KEY_FIGURE

  Memory key figure (allocated memory, used memory, main memory, delta memory, ...)

  'USED'          --> Used memory
  'ALLOCATED'     --> Amount of memory allocated (and potentially deallocated) in the considered time frame, i.e. more a throughput than a size value
  'MAIN'          --> Main memory
  'DELTA'         --> Delta memory
  'MERGES'        --> Number of delta merges
  'ROWS'          --> Number of table records

- OBJECT_LEVEL

  Controls display of partitions

  'PARTITION'     --> Result is shown on partition level
  'TABLE'         --> Result is shown on table level

- INCLUDE_OVERLAPPING_HEAP_AREAS

  Controls the display of heap areas that are already covered differently (e.g. as part of column store, row store or stack)

  'X'             --> Overlapping heap areas are included (memory can be accounted twice)
  ' '             --> Overlapping heap areas are excluded
  
- TIME_AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HOUR'          --> Aggregation by hour
  'YYYY/WW'       --> Aggregation by calendar week
  'TS<seconds>'   --> Time slice aggregation based on <seconds> seconds
  'NONE'          --> No aggregation

[OUTPUT PARAMETERS]

- SNAPSHOT_TIME: Timestamp
- KEY_FIGURE:    Memory key figure
- VALUE_TOTAL:   Total value of memory key figure
- DETAIL_<n>:    Top <n> detail area related to memory key figure
- VALUE_<n>:     Memory key figure value of top <n> detail area
- PCT_<n>:       Fraction of overall value occupied by top <n> detail area (%)

[EXAMPLE OUTPUT]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|SAMPLE_TIME     |KEY_FIGURE     |VALUE_TOTAL    |DETAIL_1                                                  |VALUE_1     |PCT_1|DETAIL_2                                                  |VALUE_2     |PCT_2|DETAIL_3                     |VALUE_3     |PCT_3|DETAIL_4                                                               |VALUE_4     |PCT_4|DETAIL_5                                                               |VALUE_5     |PCT_5|
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|2014/04/22 (TUE)|Space used (GB)|         408.55|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|       85.94|   21|Pool/RowEngine/QueryExecution                             |       79.43|   19|Pool/Statistics              |       57.76|   14|Pool/JoinEvaluator/TranslationTable                                    |       25.15|    6|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       17.11|    4|
|2014/04/21 (MON)|Space used (GB)|         382.82|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|       90.44|   24|Pool/RowEngine/QueryExecution                             |       77.66|   20|Pool/Statistics              |       56.62|   15|Pool/RowEngine/SQLPlan                                                 |       18.71|    5|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       15.83|    4|
|2014/04/20 (SUN)|Space used (GB)|         437.76|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      126.20|   29|Pool/RowEngine/QueryExecution                             |       73.89|   17|Pool/Statistics              |       52.28|   12|Pool/AttributeEngine/idattribute/build-reverse-index                   |       24.48|    6|Pool/RowEngine/SQLPlan                                                 |       18.71|    4|
|2014/04/19 (SAT)|Space used (GB)|         513.70|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      133.29|   26|Pool/RowEngine/QueryExecution                             |      103.12|   20|Pool/Statistics              |       76.53|   15|Pool/AttributeEngine-IndexVector-Sp-Prefix                             |       20.07|    4|Pool/RowEngine/SQLPlan                                                 |       19.83|    4|
|2014/04/18 (FRI)|Space used (GB)|         445.53|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      112.35|   25|Pool/RowEngine/QueryExecution                             |       77.60|   17|Pool/Statistics              |       58.36|   13|Pool/RowEngine/SQLPlan                                                 |       18.99|    4|Pool/AttributeEngine/idattribute/build-reverse-index                   |       17.70|    4|
|2014/04/17 (THU)|Space used (GB)|         363.30|Pool/RowEngine/QueryExecution                             |       72.54|   20|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|       62.99|   17|Pool/Statistics              |       57.10|   16|Pool/UdivListMgr/UdivListContainer                                     |       20.37|    6|Pool/RowEngine/SQLPlan                                                 |       20.01|    6|
|2014/04/16 (WED)|Space used (GB)|         487.59|Pool/RowEngine/QueryExecution                             |      104.39|   21|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|       90.74|   19|Pool/Statistics              |       59.10|   12|Pool/JoinEvaluator/TranslationTable                                    |       38.21|    8|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       38.12|    8|
|2014/04/15 (TUE)|Space used (GB)|         588.56|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      168.21|   29|Pool/RowEngine/QueryExecution                             |       93.88|   16|Pool/Statistics              |       59.70|   10|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       38.12|    6|Pool/JoinEvaluator/TranslationTable                                    |       35.30|    6|
|2014/04/14 (MON)|Space used (GB)|        3484.97|Pool/JoinEvaluator/JERequestedAttributes/Results          |     2795.20|   80|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      234.23|    7|Pool/RowEngine/QueryExecution|       99.01|    3|Pool/Statistics                                                        |       59.21|    2|Pool/JoinEvaluator/JECreateNTuple                                      |       49.98|    1|
|2014/04/13 (SUN)|Space used (GB)|         572.90|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      175.60|   31|Pool/RowEngine/QueryExecution                             |      104.96|   18|Pool/Statistics              |       58.86|   10|Pool/AttributeEngine/idattribute/build-reverse-index                   |       27.80|    5|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       20.87|    4|
|2014/04/12 (SAT)|Space used (GB)|         477.98|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      111.76|   23|Pool/RowEngine/QueryExecution                             |       99.14|   21|Pool/Statistics              |       59.17|   12|Pool/JoinEvaluator/TranslationTable                                    |       24.37|    5|Pool/AttributeEngine/idattribute/build-reverse-index                   |       22.95|    5|
|2014/04/11 (FRI)|Space used (GB)|         491.72|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      119.74|   24|Pool/RowEngine/QueryExecution                             |       92.28|   19|Pool/Statistics              |       59.29|   12|Pool/JoinEvaluator/TranslationTable                                    |       24.10|    5|AllocateOnlyAllocator-unlimited/FLA-UL<3145728,1>/MemoryMapLevel2Blocks|       19.98|    4|
|2014/04/10 (THU)|Space used (GB)|         463.47|Pool/PersistenceManager/PersistentSpace(0)/DefaultLPA/Page|      100.82|   22|Pool/RowEngine/QueryExecution                             |       94.05|   20|Pool/Statistics              |       59.17|   13|Pool/AttributeEngine/idattribute/build-reverse-index                   |       23.64|    5|Pool/JoinEvaluator/TranslationTable                                    |       21.33|    5|
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    MIN_TOTAL_SIZE_GB,
    AGGREGATE_BY,
    KEY_FIGURE,
    OBJECT_LEVEL,
    MAP(TIME_AGGREGATE_BY,
      'NONE',        'YYYY/MM/DD HH24:MI:SS',
      'HOUR',        'YYYY/MM/DD HH24',
      'DAY',         'YYYY/MM/DD (DY)',
      'HOUR_OF_DAY', 'HH24',
      TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
    INCLUDE_OVERLAPPING_HEAP_AREAS
  FROM
  ( SELECT                                                      /* Modification section */
      '1000/10/18 07:58:00' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      '9999/10/18 08:05:00' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' HOST,
      '%' PORT,
      '%' SCHEMA_NAME,
      '%' AREA,                     /* ROW, COLUMN, TABLES, HEAP, % */
      '%' SUBAREA,                  /* 'Row Store (Tables)', 'Row Store (Indexes)', 'Row Store (Int. Fragmentation)', 'Row Store (Ext. Fragmentation)', 'Column Store (Main)', 'Column Store (Delta)', 'Column Store (Others)' or 'Heap (<component>)' */
      '%' DETAIL,                   /* Name of table or heap area */
      ' ' ONLY_SQL_DATA_AREAS,
      ' ' EXCLUDE_SQL_DATA_AREAS,
      'X' EXCLUDE_HEAP_FRAGMENTATION,
      -1 MIN_TOTAL_SIZE_GB,
      'USED' KEY_FIGURE,            /* ALLOCATED, USED */ 
      'TABLE' OBJECT_LEVEL,         /* TABLE, PARTITION */
      ' ' INCLUDE_OVERLAPPING_HEAP_AREAS,
      'DETAIL' AGGREGATE_BY,        /* SCHEMA, DETAIL, HOST, PORT, MAINAREA, SUBAREA */
      'TS3600' TIME_AGGREGATE_BY     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
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
  SAMPLE_TIME SNAPSHOT_TIME,
  KEY_FIGURE,
  VALUE_TOTAL,
  DETAIL_1,
  VALUE_1,
  PCT_1,
  DETAIL_2,
  VALUE_2,
  PCT_2,
  DETAIL_3,
  VALUE_3,
  PCT_3,
  DETAIL_4,
  VALUE_4,
  PCT_4,
  DETAIL_5,
  VALUE_5,
  PCT_5,
  DETAIL_6,
  VALUE_6,
  PCT_6,
  DETAIL_7,
  VALUE_7,
  PCT_7,
  DETAIL_8,
  VALUE_8,
  PCT_8,
  DETAIL_9,
  VALUE_9,
  PCT_9,
  DETAIL10,
  VALUE10,
  PCT10
FROM
( SELECT
    SAMPLE_TIME, /* With window frame "ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING" for NTH_VALUE this last aggregation would not be required */
    KEY_FIGURE_DESCRIPTION KEY_FIGURE,
    MAX(VALUE_TOTAL) VALUE_TOTAL,
    MAX(VALUE_TOTAL_NUMBER) VALUE_TOTAL_NUMBER,
    IFNULL(TO_VARCHAR(MAX(DETAIL_1)), ' ') DETAIL_1,
    IFNULL(TO_VARCHAR(MAX(VALUE_1)), ' ') VALUE_1,
    IFNULL(LPAD(MAX(PCT_1), 5), ' ') PCT_1,
    IFNULL(TO_VARCHAR(MAX(DETAIL_2)), ' ') DETAIL_2,
    IFNULL(TO_VARCHAR(MAX(VALUE_2)), ' ') VALUE_2,
    IFNULL(LPAD(MAX(PCT_2), 5), ' ') PCT_2,
    IFNULL(TO_VARCHAR(MAX(DETAIL_3)), ' ') DETAIL_3,
    IFNULL(TO_VARCHAR(MAX(VALUE_3)), ' ') VALUE_3,
    IFNULL(LPAD(MAX(PCT_3), 5), ' ') PCT_3,
    IFNULL(TO_VARCHAR(MAX(DETAIL_4)), ' ') DETAIL_4,
    IFNULL(TO_VARCHAR(MAX(VALUE_4)), ' ') VALUE_4,
    IFNULL(LPAD(MAX(PCT_4), 5), ' ') PCT_4,
    IFNULL(TO_VARCHAR(MAX(DETAIL_5)), ' ') DETAIL_5,
    IFNULL(TO_VARCHAR(MAX(VALUE_5)), ' ') VALUE_5,
    IFNULL(LPAD(MAX(PCT_5), 5), ' ') PCT_5,
    IFNULL(TO_VARCHAR(MAX(DETAIL_6)), ' ') DETAIL_6,
    IFNULL(TO_VARCHAR(MAX(VALUE_6)), ' ') VALUE_6,
    IFNULL(LPAD(MAX(PCT_6), 5), ' ') PCT_6,
    IFNULL(TO_VARCHAR(MAX(DETAIL_7)), ' ') DETAIL_7,
    IFNULL(TO_VARCHAR(MAX(VALUE_7)), ' ') VALUE_7,
    IFNULL(LPAD(MAX(PCT_7), 5), ' ') PCT_7,
    IFNULL(TO_VARCHAR(MAX(DETAIL_8)), ' ') DETAIL_8,
    IFNULL(TO_VARCHAR(MAX(VALUE_8)), ' ') VALUE_8,
    IFNULL(LPAD(MAX(PCT_8), 5), ' ') PCT_8,
    IFNULL(TO_VARCHAR(MAX(DETAIL_9)), ' ') DETAIL_9,
    IFNULL(TO_VARCHAR(MAX(VALUE_9)), ' ') VALUE_9,
    IFNULL(LPAD(MAX(PCT_9), 5), ' ') PCT_9,
    IFNULL(TO_VARCHAR(MAX(DETAIL_10)), ' ') DETAIL10,
    IFNULL(TO_VARCHAR(MAX(VALUE_10)), ' ') VALUE10,
    IFNULL(LPAD(MAX(PCT_10), 5), ' ') PCT10,
    MIN_TOTAL_SIZE_GB
  FROM
  ( SELECT DISTINCT
      SAMPLE_TIME,
      KEY_FIGURE_DESCRIPTION,
      LPAD(TO_DECIMAL(SUM(KEY_FIGURE) OVER (PARTITION BY SAMPLE_TIME), 12, 2), 15) VALUE_TOTAL,
      TO_DECIMAL(SUM(KEY_FIGURE) OVER (PARTITION BY SAMPLE_TIME), 12, 2) VALUE_TOTAL_NUMBER,
      NTH_VALUE(DETAIL, 1) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_1,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 1) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_1,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 1) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_1,
      NTH_VALUE(DETAIL, 2) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_2,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 2) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_2,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 2) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_2,
      NTH_VALUE(DETAIL, 3) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_3,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 3) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_3,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 3) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_3,
      NTH_VALUE(DETAIL, 4) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_4,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 4) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_4,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 4) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_4,
      NTH_VALUE(DETAIL, 5) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_5,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 5) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_5,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 5) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_5,
      NTH_VALUE(DETAIL, 6) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_6,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 6) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_6,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 6) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_6,
      NTH_VALUE(DETAIL, 7) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_7,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 7) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_7,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 7) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_7,
      NTH_VALUE(DETAIL, 8) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_8,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 8) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_8,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 8) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_8,
      NTH_VALUE(DETAIL, 9) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_9,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 9) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_9,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 9) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_9,
      NTH_VALUE(DETAIL, 10) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC) DETAIL_10,
      LPAD(TO_DECIMAL(NTH_VALUE(KEY_FIGURE, 10) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC), 10, 2), 12) VALUE_10,
      TO_DECIMAL(ROUND(NTH_VALUE(PERCENT, 10) OVER (PARTITION BY SAMPLE_TIME ORDER BY KEY_FIGURE DESC)), 10, 0) PCT_10,
      MIN_TOTAL_SIZE_GB
    FROM
    ( SELECT
        SAMPLE_TIME,
        DETAIL,
        KEY_FIGURE_DESCRIPTION,
        SUM(KEY_FIGURE) KEY_FIGURE,
        MAP(SUM(KEY_FIGURE), 0, 0, SUM(KEY_FIGURE) / SUM(SUM(KEY_FIGURE)) OVER (PARTITION BY SAMPLE_TIME) * 100) PERCENT,
        MIN_TOTAL_SIZE_GB
      FROM
      ( SELECT
          CASE 
            WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), SERVER_TIMESTAMP) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(SERVER_TIMESTAMP, TIME_AGGREGATE_BY)
          END SAMPLE_TIME,
          DETAIL,
          KEY_FIGURE_DESCRIPTION,
          MAP(BI_KEY_FIGURE, 'ALLOCATED', SUM(KEY_FIGURE), AVG(KEY_FIGURE)) KEY_FIGURE,
          MIN_TOTAL_SIZE_GB
        FROM
        ( SELECT
            SERVER_TIMESTAMP,
            AREA,
            SUBAREA,
            DETAIL,
            KEY_FIGURE_DESCRIPTION,
            TIME_AGGREGATE_BY,
            MIN_TOTAL_SIZE_GB,
            SUM(KEY_FIGURE) KEY_FIGURE,
            BI_KEY_FIGURE
          FROM
          ( SELECT
              CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(D.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE D.SERVER_TIMESTAMP END SERVER_TIMESTAMP,
              D.AREA,
              D.SUBAREA,
              MAP(BI.AGGREGATE_BY, 'SCHEMA', D.SCHEMA_NAME, 'HOST', D.HOST, 'PORT', TO_VARCHAR(D.PORT), 'MAINAREA', D.AREA, 'SUBAREA', D.SUBAREA, 'DETAIL',
                MAP(BI.OBJECT_LEVEL, 'TABLE', D.DETAIL,
                  D.DETAIL || MAP(D.PART_ID, -1, '', 0, '', ' (P' || D.PART_ID || ')'))) DETAIL,
              MAP(BI.KEY_FIGURE,
                'ALLOCATED', 'Space allocated (GB)',
                'USED',      'Space used (GB)') KEY_FIGURE_DESCRIPTION,
              MAP(BI.KEY_FIGURE, 
                'ALLOCATED', D.ALLOC_BYTE / 1024 / 1024 / 1024,
                'USED',      D.USED_BYTE / 1024 / 1024 / 1024) KEY_FIGURE,
              BI.TIME_AGGREGATE_BY,
              BI.MIN_TOTAL_SIZE_GB,
              BI.KEY_FIGURE BI_KEY_FIGURE
            FROM
              BASIS_INFO BI,
              ( SELECT
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
                ( SELECT
                    *
                  FROM
                    _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE
                ) CT
                UNION ALL
                ( SELECT
                    'ROW' AREA,
                    'Row Store (Tables)' SUBAREA,
                    RT.SERVER_TIMESTAMP,
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
                    'ROW' AREA,
                    'Row Store (Int. Fragmentation)' SUBAREA,
                    RT.SERVER_TIMESTAMP,
                    ' ',
                    'Row Store (Int. Fragmentation)',
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
                    'ROW' AREA,
                    'Row Store (Indexes)' SUBAREA,
                    RT.SERVER_TIMESTAMP,
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
                    'ROW' AREA,
                    'Row Store (Ext. Fragmentation)' SUBAREA,
                    SERVER_TIMESTAMP,
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
                    'HEAP' AREA,
                    'Heap (Fragmentation)' SUBAREA,
                    SM.SERVER_TIMESTAMP,
                    ' ' SCHEMA_NAME,
                    'Heap (Fragmentation)' CATEGORY,
                    0 PART_ID,
                    SM.HOST,
                    SM.PORT,
                    0 NUM_ROWS,
                    0,
                    SM.FRAGMENTED_MEMORY_SIZE
                  FROM
                    _SYS_STATISTICS.HOST_SERVICE_MEMORY SM
                )
                UNION ALL
                ( SELECT
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
              ) D      
            WHERE
              D.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
              D.DETAIL LIKE BI.DETAIL AND
              D.HOST LIKE BI.HOST AND
              TO_VARCHAR(D.PORT) LIKE BI.PORT AND
              CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(D.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE D.SERVER_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
              ( BI.AREA = 'TABLES' AND D.AREA IN ('ROW', 'COLUMN') OR
                D.AREA LIKE BI.AREA ) AND
              UPPER(D.SUBAREA) LIKE UPPER(BI.SUBAREA) AND
              ( BI.INCLUDE_OVERLAPPING_HEAP_AREAS = 'X' OR
                D.AREA != 'HEAP' OR
                D.DETAIL LIKE 'Pool/ColumnStore%/Delta' OR
                D.DETAIL LIKE 'Pool/ColumnStore%/System' OR
                D.DETAIL LIKE 'Pool/ColumnStore%/Main/Rowid/build-reverse-index' OR
                ( D.DETAIL NOT LIKE 'Pool/AttributeEngine%' AND
                  D.DETAIL NOT LIKE 'Pool/ColumnStore%' AND
                  D.DETAIL != 'Pool/CS/BufferPage' AND
                  D.DETAIL NOT LIKE 'Pool/Text/AEText%' AND
                  D.DETAIL NOT IN
                  ( 'Pool/FuzzySearch',
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
              ( BI.ONLY_SQL_DATA_AREAS    = ' ' OR     EXISTS ( SELECT ALLOCATOR FROM SQL_DATA_AREAS S WHERE D.DETAIL LIKE S.ALLOCATOR ) ) AND
              ( BI.EXCLUDE_SQL_DATA_AREAS = ' ' OR NOT EXISTS ( SELECT ALLOCATOR FROM SQL_DATA_AREAS S WHERE D.DETAIL LIKE S.ALLOCATOR ) ) AND
              ( BI.EXCLUDE_HEAP_FRAGMENTATION = ' ' OR D.SUBAREA != 'Heap (Fragmentation)' )
          )
          WHERE
            KEY_FIGURE > 0
          GROUP BY
            SERVER_TIMESTAMP,
            AREA,
            SUBAREA,
            DETAIL,
            KEY_FIGURE_DESCRIPTION,
            TIME_AGGREGATE_BY,
            MIN_TOTAL_SIZE_GB,
            BI_KEY_FIGURE
        )
        GROUP BY
          CASE 
            WHEN TIME_AGGREGATE_BY LIKE 'TS%' THEN
              TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
              'YYYY/MM/DD HH24:MI:SS'), SERVER_TIMESTAMP) / SUBSTR(TIME_AGGREGATE_BY, 3)) * SUBSTR(TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
            ELSE TO_VARCHAR(SERVER_TIMESTAMP, TIME_AGGREGATE_BY)
          END,
          AREA,
          SUBAREA,
          DETAIL,
          KEY_FIGURE_DESCRIPTION,
          MIN_TOTAL_SIZE_GB,
          BI_KEY_FIGURE
      )
      GROUP BY
        SAMPLE_TIME,
        DETAIL,
        KEY_FIGURE_DESCRIPTION,
        MIN_TOTAL_SIZE_GB
    )
  )
  GROUP BY
    SAMPLE_TIME,
    KEY_FIGURE_DESCRIPTION,
    MIN_TOTAL_SIZE_GB 
)
WHERE
( MIN_TOTAL_SIZE_GB = -1 OR VALUE_TOTAL_NUMBER >= MIN_TOTAL_SIZE_GB )
ORDER BY
  SAMPLE_TIME DESC
WITH HINT (IGNORE_PLAN_CACHE)
