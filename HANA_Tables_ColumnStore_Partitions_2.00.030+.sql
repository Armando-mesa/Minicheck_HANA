SELECT
/* 

[NAME]

- HANA_Tables_ColumnStore_Partitions_2.00.030+

[DESCRIPTION]

- Table partition information

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Partitions only available in column store
- Tables with naming convention TR_<id> or TR_<id>_SIMULATION are DTP error stack tables
- TABLE_PARTITIONS and PARTITIONED_TABLES available with SAP HANA >= 2.00.000

[VALID FOR]

- Revisions:              >= 2.00.030

[SQL COMMAND VERSION]

- 2014/03/06:  1.0 (initial version)
- 2014/07/10:  1.1 (EXCLUDE_BW_TABLES included)
- 2015/02/05:  1.2 (LOADED included)
- 2017/12/06:  1.3 (SUBPART_RANGE included)
- 2018/03/09:  1.4 (MAX_PARTITION_SPEC_LENGTH added)
- 2018/06/26:  1.5 (SPEC and RANGE columns to DEF column merged)
- 2018/09/25:  1.6 (RSPM* and TR_* tables as BW tables included)
- 2020/05/18:  1.7 (PART_ID and SUBPART_ID filters included)
- 2020/05/29:  1.8 (ONLY_OVERFLOW_PARTITIONS and MIN_RECORD_COUNT filters included)
- 2020/12/05:  1.9 (dedicated 2.00.030+ version including persistent memory and NSE size)
- 2021/02/09:  2.0 (deprecated M_CS_PARTITIONS replaced with TABLE_PARTITIONS and PARTITIONED_TABLES)

[INVOLVED TABLES]

- M_CS_TABLES
- M_TABLE_PERSISTENCE_STATISTICS
- PARTITIONED_TABLES
- TABLE_PARTITIONS

[INPUT PARAMETERS]

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

- MIN_RECORD_COUNT

  Minimum number of records

  100000          --> Only display results with at least 100,000 records
  -1              --> No restriction related to record count

- EXCLUDE_BW_TABLES

  Possibility to exclude BW tables from analysis (following naming convention /B%/%)

  'X'             --> Only display non BW tables
  ' '             --> Display all tables

- ONLY_OVERFLOW_PARTITIONS

  Possibility to restrict the output to overflow partitions (for all records that do not fit to any existing range partition)

  'X'             --> Only display overflow partitions
  ' '             --> No restriction related to overflow partitions

- MAX_PARTITION_SPEC_LENGTH

  Maximum length of partition specification

  60              --> Truncate partition specification to 60 characters
  -1              --> No limit of partition specification length

[OUTPUT PARAMETERS]

- SCHEMA_NAME:          Schema name
- TABLE_NAME:           Table name
- SIZE_DISK_MB:         Size on disk (MB)
- PART:                 Partition number
- LEVEL_1_PARTITIONING: Level 1 partition details
- LEVEL_2_PARTITIONING: Level 2 partition details (in case table is sub-partitioned)
- SUBPART_DEF:          Sub partition definition
- HOST:                 Host name
- MEM_MB:               Size in memory (MB)
- PAGED_MB:             Paged attribute / NSE buffer cache memory (MB)
- PERSMEM_MB:           Persistent memory (MB)
- RECORDS:              Number of records

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|SCHEMA_NAME|TABLE_NAME|SIZE_DISK_MB|PART|LEVEL_1_PARTITIONING                 |LEVEL_2_PARTITIONING          |LOADED   |MEM_MB     |PAGED_MB   |PERSMEM_MB |RECORDS    |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|SAPERP     |ACDOCA    |   774633.90|   1|RANGE ("FISCYEARPER") 0000000-2015000|                              |PARTIALLY|   17545.66|       0.00|   16842.19|  378041375|
|           |          |            |   2|RANGE ("FISCYEARPER") 2015000-2018000|HASH HETEROGENEOUS 2 ("BELNR")|PARTIALLY|   26402.15|       0.00|   25560.06|  495088652|
|           |          |            |   3|RANGE ("FISCYEARPER") 2015000-2018000|HASH HETEROGENEOUS 2 ("BELNR")|PARTIALLY|   28024.04|       0.00|   27067.50|  520498091|
|           |          |            |   4|RANGE ("FISCYEARPER") 2018002-2019000|HASH HETEROGENEOUS 4 ("BELNR")|PARTIALLY|   16006.14|       0.00|   15446.35|  305424173|
|           |          |            |   5|RANGE ("FISCYEARPER") 2018002-2019000|HASH HETEROGENEOUS 4 ("BELNR")|PARTIALLY|   15950.04|       0.00|   15415.65|  302804865|
|           |          |            |   6|RANGE ("FISCYEARPER") 2018002-2019000|HASH HETEROGENEOUS 4 ("BELNR")|PARTIALLY|   15996.34|       0.00|   15449.96|  303678330|
|           |          |            |   7|RANGE ("FISCYEARPER") 2018002-2019000|HASH HETEROGENEOUS 4 ("BELNR")|PARTIALLY|   16179.18|       0.00|   15632.80|  296792088|
...
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  MAP(ROW_NUMBER () OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY PART_ID), 1, SCHEMA_NAME, ' ') SCHEMA_NAME,
  MAP(ROW_NUMBER () OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY PART_ID), 1, TABLE_NAME, ' ') TABLE_NAME,
  MAP(ROW_NUMBER () OVER (PARTITION BY SCHEMA_NAME, TABLE_NAME ORDER BY PART_ID), 1, LPAD(TO_DECIMAL(SIZE_DISK_MB, 10, 2), 12), ' ') SIZE_DISK_MB,
  LPAD(PART_ID, 4) PART,
  LEVEL_1_PARTITIONING,
  LEVEL_2_PARTITIONING,
  HOST,
  LOADED,
  LPAD(TO_DECIMAL(MEM_MB, 10, 2), 11) MEM_MB,
  LPAD(TO_DECIMAL(PAGED_MB, 10, 2), 11) PAGED_MB,
  LPAD(TO_DECIMAL(PERSMEM_MB, 10, 2), 11) PERSMEM_MB,
  LPAD(TO_DECIMAL(ROUND(NUM_ROWS), 11, 0), 11) RECORDS
FROM
( SELECT
    T.SCHEMA_NAME,
    T.TABLE_NAME,
    TP.PART_ID,
    CASE PT.LEVEL_1_TYPE
      WHEN 'RANGE' THEN 'RANGE (' || PT.LEVEL_1_EXPRESSION || ')' || CHAR(32) || TP.LEVEL_1_RANGE_MIN_VALUE || MAP(TP.LEVEL_1_RANGE_MAX_VALUE, '', '', TP.LEVEL_1_RANGE_MIN_VALUE, '', '-' || TP.LEVEL_1_RANGE_MAX_VALUE)
      ELSE PT.LEVEL_1_TYPE || CHAR(32) || PT.LEVEL_1_COUNT || CHAR(32) || '(' || PT.LEVEL_1_EXPRESSION || ')'
    END LEVEL_1_PARTITIONING,
    CASE 
      WHEN PT.LEVEL_2_TYPE = '' OR TP.L1_SUBPARTITIONS = 0 THEN ''
      WHEN PT.LEVEL_2_TYPE = 'RANGE' THEN 'RANGE (' || PT.LEVEL_2_EXPRESSION || ')' || CHAR(32) || TP.LEVEL_2_RANGE_MIN_VALUE || MAP(TP.LEVEL_2_RANGE_MAX_VALUE, '', '', TP.LEVEL_2_RANGE_MIN_VALUE, '', '-' || TP.LEVEL_2_RANGE_MAX_VALUE)
      ELSE PT.LEVEL_2_TYPE || CHAR(32) || LEAST(PT.LEVEL_2_COUNT, TP.L1_SUBPARTITIONS) || CHAR(32) || '(' || PT.LEVEL_2_EXPRESSION || ')'
    END LEVEL_2_PARTITIONING,
    T.HOST,
    T.LOADED,
    (T.MEMORY_SIZE_IN_TOTAL + T.PERSISTENT_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 MEM_MB,
    T.MEMORY_SIZE_IN_PAGE_LOADABLE_MAIN / 1024 / 1024 PAGED_MB,
    T.PERSISTENT_MEMORY_SIZE_IN_TOTAL / 1024 / 1024 PERSMEM_MB,
    T.RECORD_COUNT NUM_ROWS,
    TPS.DISK_SIZE / 1024 / 1024 SIZE_DISK_MB
  FROM
  ( SELECT                                                       /* Modification section */
      '%' SCHEMA_NAME,
      'ACDOCA' TABLE_NAME,
      -1 PART_ID,
      -1 MIN_RECORD_COUNT,
      'X' EXCLUDE_BW_TABLES,
      ' ' ONLY_OVERFLOW_PARTITIONS,
      -1 MAX_PARTITION_SPEC_LENGTH
    FROM
      DUMMY
  ) BI,
    M_CS_TABLES T,
    PARTITIONED_TABLES PT,
  ( SELECT
      ( SELECT COUNT(*) FROM TABLE_PARTITIONS TP2 
        WHERE TP1.SCHEMA_NAME = TP2.SCHEMA_NAME AND TP1.TABLE_NAME = TP2.TABLE_NAME AND TP1.LEVEL_1_PARTITION = TP2.LEVEL_1_PARTITION AND TP2.LEVEL_2_PARTITION > 0
      ) L1_SUBPARTITIONS,
      *
    FROM
      TABLE_PARTITIONS TP1
  ) TP,
    M_TABLE_PERSISTENCE_STATISTICS TPS
  WHERE
    T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    T.TABLE_NAME LIKE BI.TABLE_NAME AND
    ( BI.PART_ID = -1 OR T.PART_ID = BI.PART_ID ) AND
    PT.SCHEMA_NAME = T.SCHEMA_NAME AND
    PT.TABLE_NAME = T.TABLE_NAME AND
    TP.SCHEMA_NAME = T.SCHEMA_NAME AND
    TP.TABLE_NAME = T.TABLE_NAME AND
    TP.PART_ID = T.PART_ID AND
    TPS.SCHEMA_NAME = TP.SCHEMA_NAME AND
    TPS.TABLE_NAME = TP.TABLE_NAME AND
    ( BI.EXCLUDE_BW_TABLES = ' ' OR 
      T.TABLE_NAME LIKE '/BA1/%' OR 
      ( T.TABLE_NAME NOT LIKE 'RSPM%' AND 
        T.TABLE_NAME NOT LIKE 'ZBICZ%' AND
        T.TABLE_NAME NOT LIKE '0BW:BIA%' AND
        T.TABLE_NAME NOT LIKE '$BPC$HC$%' AND
        T.TABLE_NAME NOT LIKE '$BPC$TMP%' AND
        T.TABLE_NAME NOT LIKE '/B%/%' AND
        T.TABLE_NAME NOT LIKE '/1B0/%' AND
        T.TABLE_NAME NOT LIKE '/1DD/%' AND
        SUBSTR(T.TABLE_NAME, 1, 3) != 'TR_' 
      ) 
    ) AND
    ( BI.ONLY_OVERFLOW_PARTITIONS = ' ' OR
      PT.LEVEL_1_TYPE = 'RANGE' AND TP.LEVEL_1_RANGE_MIN_VALUE = '' OR
      PT.LEVEL_2_TYPE = 'RANGE' AND TP.LEVEL_2_RANGE_MIN_VALUE = ''
    ) AND
    ( BI.MIN_RECORD_COUNT = -1 OR T.RECORD_COUNT >= BI.MIN_RECORD_COUNT )
) TP
ORDER BY
  TP.SCHEMA_NAME,
  TP.TABLE_NAME,
  TP.PART_ID
