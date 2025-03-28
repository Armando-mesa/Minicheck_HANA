SELECT

/* 

[NAME]

- HANA_NSE_BufferCache_Tables_2.00.080+

[DESCRIPTION]

- Tables currently located in native storage extension (NSE) buffer cache

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- See SAP Note 2799997 for more details related to NSE.
- Lists also tables with paged attributes configured for data aging.
- M_BUFFER_CACHE_STATISTICS and M_BUFFER_CACHE_POOL_STATISTICS available with SAP HANA >= 2.00.040
- USED_SIZE with SAP HANA 2.0 SPS 04 is actually the allocated size. With SAP HANA 2.0 >= SPS 05 the 
  former USED_SIZE value is shown in the ALLOCATED_SIZE column and a new and correct USED_SIZE column
  is introduced.
- M_CS_COLUMNS_PERSISTENCE.PERSISTENCE_TYPE = 'PAGED' changed to LOAD_UNIT = 'PAGE' with SAP HANA >= 2.00.080

[VALID FOR]

- Revisions:              >= 2.00.080

[SQL COMMAND VERSION]

- 2021/11/07:  1.0 (initial version)
- 2024/07/26:  1.1 (dedicated 2.00.080+ version including adjusted M_CS_COLUMNS_PERSISTENCE behavior)
- 2024/09/13:  1.2 (USED_PCT included)

[INVOLVED TABLES]

- M_BUFFER_CACHE_STATISTICS
- M_CS_COLUMNS_PERSISTENCE
- M_CS_TABLES

[INPUT PARAMETERS]

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

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- TABLE_NAME           

  Table name

  'T000'          --> Specific table T000
  'T%'            --> All tables starting with 'T'
  '%'             --> All tables

- PART_ID

  Partition number

  2               --> Only show information for partition number 2
  -1              --> No restriction related to partition number

- ONLY_TABLES_CURRENTLY_IN_BUFFER

  Possibility to restrict output to currently buffered tables

  'X'             --> Only display tables that currently occupy space in the NSE table buffer
  ' '             --> No restriction related to current table buffering state

- OBJECT_LEVEL

  Controls display of partitions

  'PARTITION'     --> Result is shown on partition level
  'TABLE'         --> Result is shown on table level

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'SIZE'          --> Sorting by size 
  'TABLE'         --> Sorting by table name

[OUTPUT PARAMETERS]

- HOST:        Host
- PORT:        Port
- TOT_BUFF_GB: Total NSE buffer size (GB)
- SCHEMA_NAME: Schema name
- TABLE_NAME:  Table name
- PAGED_GB:    Paged size (GB)
- BUFF_GB:     Buffered paged size (GB)
- BUFF_PCT:    Part of paged size that is currently in buffer (%)
- USED_PCT:    Part of available buffer used by the table (%)

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------
|HOST         |PORT |TOT_BUFF_GB|SCHEMA_NAME|TABLE_NAME|PAGED_GB|BUFF_GB|BUFF_PCT|
----------------------------------------------------------------------------------
|saphananode01|30240|      39.06|SAPERP     |GLPCA     |   88.62|  20.10|   22.68|
|saphananode01|30240|      39.06|SAPERP     |INDX      |  183.44|   5.02|    2.74|
|saphananode01|30240|      39.06|SAPERP     |BALDAT    |   67.46|   0.68|    1.01|
----------------------------------------------------------------------------------

*/

  HOST,
  LPAD(PORT, 5) PORT,
  LPAD(TO_DECIMAL(TOT_BUFF_GB, 10, 2), 11) TOT_BUFF_GB,
  SCHEMA_NAME,
  TABLE_NAME,
  LPAD(TO_DECIMAL(PAGED_GB, 10, 2), 8) PAGED_GB,
  LPAD(TO_DECIMAL(BUFF_GB, 10, 2), 7) BUFF_GB,
  LPAD(TO_DECIMAL(MAP(PAGED_GB, 0, 0, BUFF_GB / PAGED_GB * 100), 10, 2), 8) BUFF_PCT,
  LPAD(TO_DECIMAL(MAP(PAGED_GB, 0, 0, BUFF_GB / TOT_BUFF_GB * 100), 10, 2), 8) USED_PCT
FROM
( SELECT
    C.HOST,
    C.PORT,
    T.SCHEMA_NAME,
    T.TABLE_NAME || CASE WHEN BI.OBJECT_LEVEL = 'PARTITION' AND T.PART_ID != 0 THEN ' (' || T.PART_ID || ')' ELSE '' END TABLE_NAME,
    C.MAX_SIZE / 1024 / 1024 / 1024 TOT_BUFF_GB,
    SUM(MEMORY_SIZE_IN_PAGE_LOADABLE_MAIN) / 1024 / 1024 / 1024 BUFF_GB,
    SUM(MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE) / 1024 / 1024 / 1024 PAGED_GB,
    BI.ORDER_BY
  FROM
  ( SELECT                       /* Modification section */
      '%' HOST,
      '%' PORT,
      '%' SCHEMA_NAME,
      '%' TABLE_NAME,
      -1 PART_ID,
      'X' ONLY_TABLES_CURRENTLY_IN_BUFFER,
      'TABLE' OBJECT_LEVEL,
      'BUFF_SIZE' ORDER_BY                 /* BUFF_SIZE, PAGED_SIZE, TABLE */
    FROM
      DUMMY
  ) BI,
    M_BUFFER_CACHE_STATISTICS C,
    M_CS_TABLES T,
  ( SELECT 
      SCHEMA_NAME, 
      TABLE_NAME, 
      PART_ID, 
      SUM(MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE) MAIN_PHYSICAL_SIZE_IN_PAGE_LOADABLE 
    FROM 
      M_CS_COLUMNS_PERSISTENCE
    WHERE
      LOAD_UNIT = 'PAGE'
    GROUP BY 
      SCHEMA_NAME, TABLE_NAME, PART_ID 
  ) CP
  WHERE
    C.HOST LIKE BI.HOST AND
    TO_VARCHAR(C.PORT) LIKE BI.PORT AND
    T.HOST = C.HOST AND
    T.PORT = C.PORT AND
    T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
    T.TABLE_NAME LIKE BI.TABLE_NAME AND
    ( BI.PART_ID = -1 OR T.PART_ID = BI.PART_ID ) AND
    CP.SCHEMA_NAME = T.SCHEMA_NAME AND
    CP.TABLE_NAME = T.TABLE_NAME AND
    CP.PART_ID = T.PART_ID AND
    ( BI.ONLY_TABLES_CURRENTLY_IN_BUFFER = ' ' OR T.MEMORY_SIZE_IN_PAGE_LOADABLE_MAIN > 0 )
  GROUP BY
    C.HOST,
    C.PORT,
    T.SCHEMA_NAME,
    C.MAX_SIZE,
    T.TABLE_NAME || CASE WHEN BI.OBJECT_LEVEL = 'PARTITION' AND T.PART_ID != 0 THEN ' (' || T.PART_ID || ')' ELSE '' END,
    BI.ORDER_BY
) T
ORDER BY  
  MAP(ORDER_BY, 'BUFF_SIZE', T.BUFF_GB, 'PAGED_SIZE', T.PAGED_GB) DESC,
  SCHEMA_NAME || TABLE_NAME