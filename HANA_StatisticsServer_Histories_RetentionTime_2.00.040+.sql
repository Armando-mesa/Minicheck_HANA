SELECT
/* 

[NAME]

- HANA_StatisticsServer_Histories_RetentionTime_2.00.040+

[DESCRIPTION]

- Retention times for statistics server history tables

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_SESSION_CONTEXT and HOST_WORKLOAD do not exist on revisions below 70 
- Adjusted to work with ESS table layout
- New histories with SAP HANA 1.0 SPS 09:

  - HOST_LIVECACHE_CONTAINER_STATISTICS
  - HOST_LIVECACHE_OMS_VERSIONS
  - HOST_LIVECACHE_PROCEDURE_STATISTICS
  - HOST_LIVECACHE_SCHEMA_STATISTICS
  - HOST_MVCC_OVERVIEW
  - HOST_RS_INDEXES
  - HOST_SERVICE_REPLICATION

- New histories with SAP HANA 1.0 SPS 10:

  - GLOBAL_TABLE_CONSISTENCY
  - STREAMING_PROJECTS_STATISTICS
  - STREAMING_PROJECT_STREAMS_STATISTICS
  - STREAMING_STREAMS_STATISTICS
  - STREAMING_SUBSCRIBERS_STATISTICS
  - STREAMING_PROJECT_CONNECTIONS_STATISTICS

- New histories with SAP HANA 1.0 SPS 12:

  - HOST_JOB_HISTORY
  - HOST_LOAD_HISTORY_HOST
  - HOST_LOAD_HISTORY_SERVICE
  - HOST_SERVICE_THREAD_SAMPLES_STATEMENTS

- New histories with SAP HANA 2.0 SPS 00 - SPS 03:

  - GLOBAL_OUT_OF_MEMORY_EVENTS
  - HOST_CS_LOB_SPACE_RECLAIMS
  - HOST_SERVICE_NETWORK_IO
  - TEL_DISK_USAGE
  - TEL_FEATURE_USAGE
  - TEL_HOST_INFORMATION
  - TEL_INIFILE_CONTENTS
  - TEL_LICENSES
  - TEL_OUT_OF_MEMORY_EVENTS
  - TEL_SYSTEM_OVERVIEW

- New histories with SAP HANA 2.0 SPS 04:

  - GLOBAL_CATALOG_CONSISTENCY
  - HOST_CS_INDEXES
  - HOST_DISK_USAGE
  - HOST_LOG_PARTITIONS
  - HOST_SERVICE_THREAD_CALLSTACKS
  - TEL_LICENSE
  - TEL_LOG_BUFFERS
  - TEL_LOG_SEGMENTS

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2014/12/15:  1.0 (initial version)
- 2015/03/23:  1.1 (STATUS and RECORDS included)
- 2015/10/08:  1.2 (ID included)
- 2016/01/06:  1.3 (dedicated Rev100+ version)
- 2016/05/10:  1.4 (ONLY_SMALL_RETENTION_TIMES included)
- 2016/07/19:  1.5 (dedicated Rev120+ version)
- 2018/06/21:  1.6 (dedicated 2.00.030+ version)
- 2021/02/08:  1.7 (dedicated 2.00.040+ version)

[INVOLVED TABLES]

- M_INIFILE_CONTENTS
- M_RS_TABLES
- M_RS_INDEXES
- M_CS_TABLES
- history tables

[INPUT PARAMETERS]

- TABLE_NAME           

  Table name or pattern

  'T000'          --> Specific table T000
  'T%'            --> All tables starting with 'T'
  '%'             --> All tables

- ONLY_MODIFIED_SETTINGS

  Allows to display only modified settings

  'X'             --> Only modified settings are displayed
  ' '             --> All settings are displayed

- ONLY_SMALL_RETENTION_TIMES

  Possibility to restrict output to histories with a retention time less than the standard recommendation

  'X'             --> Only display histories with a retention time less than the standard recommendation
  ' '             --> No restriction related to retention time

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'SIZE'          --> Sorting by size 
  'NAME'          --> Sorting by table name
  'RETENTION'     --> Sorting by history retention
 
[OUTPUT PARAMETERS]

- ID:               Statistics server collector ID
- TABLE_NAME:       Table name
- STATUS:           Collector status
- DEF_RET_DAYS:     Default number of retention days
- CUR_RET_DAYS:     Retention days specified explicitly
- OLDEST_DATA_DAYS: Oldest data in table (days)
- SIZE_MB:          Table size (MB)
- RECORDS:          Number of records in table

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------
|TABLE_NAME                            |DEF_RETENTION_DAYS|USER_RETENTION_DAYS|OLDEST_DATA_DAYS|SIZE_MB |
---------------------------------------------------------------------------------------------------------
|HOST_SQL_PLAN_CACHE                   |                30|                 10|              10|10600.32|
|HOST_SESSION_CONTEXT                  |                30|                 10|              10| 6736.11|
|HOST_CS_UNLOADS                       |                 1|                  1|               1|  486.97|
|HOST_COLUMN_TABLES_PART_SIZE          |                30|                 10|              10|  437.42|
|HOST_VOLUME_IO_DETAILED_STATISTICS    |                30|                 10|              10|  385.20|
|HOST_VOLUME_IO_RETRY_STATISTICS       |                30|                 10|              10|  361.32|
|HOST_DELTA_MERGE_STATISTICS           |                30|                 10|              10|  304.12|
|HOST_CONNECTION_STATISTICS            |                30|                 10|              10|  216.46|
|HOST_SERVICE_STATISTICS               |                30|                 10|              10|  160.50|
|HOST_SERVICE_MEMORY                   |                30|                 10|              10|  154.83|
|HOST_HEAP_ALLOCATORS                  |                30|                 10|              10|  134.03|
|HOST_VOLUME_FILES                     |                30|                 10|              10|  130.96|
|HOST_CONNECTIONS                      |                30|                 10|              10|  129.25|
|HOST_OBJECT_LOCKS                     |                 7|                  7|               7|   89.47|
|HOST_VOLUME_IO_STATISTICS             |                30|                 10|              10|   67.37|
|HOST_VOLUME_IO_TOTAL_STATISTICS       |                30|                 10|              10|   53.63|
|HOST_DATA_VOLUME_PAGE_STATISTICS      |                30|                 10|              10|   43.77|
|HOST_RESOURCE_UTILIZATION_STATISTICS  |                30|                 10|              10|   37.66|
|GLOBAL_TABLE_PERSISTENCE_STATISTICS   |                30|                 10|              10|   36.40|
|HOST_WORKLOAD                         |                30|                 10|              10|   27.95|
|HOST_OBJECT_LOCK_STATISTICS           |                30|                 10|              10|    9.28|
|HOST_SAVEPOINTS                       |                 7|                  7|               7|    9.14|
|GLOBAL_ROWSTORE_TABLES_SIZE           |                30|                 10|              10|    8.96|
|GLOBAL_DISKS                          |                30|                 10|              10|    7.45|
|HOST_LONG_IDLE_CURSOR                 |                30|                 10|              10|    7.11|
|HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS|                30|                 10|              10|    6.08|
|HOST_SERVICE_COMPONENT_MEMORY         |                30|                 10|              10|    4.53|
|HOST_UNCOMMITTED_WRITE_TRANSACTION    |                30|                 10|              10|    4.17|
|HOST_BLOCKED_TRANSACTIONS             |                 7|                  7|               7|    3.58|
|GLOBAL_PERSISTENCE_STATISTICS         |                30|                 10|              10|    1.19|
|HOST_LONG_RUNNING_STATEMENTS          |                 7|                  7|               4|    0.97|
|HOST_ONE_DAY_FILE_COUNT               |                30|                 10|              10|    0.51|
|HOST_LONG_SERIALIZABLE_TRANSACTION    |                30|                 10|                |    0.19|
|GLOBAL_INTERNAL_EVENTS                |                30|                 10|                |    0.11|
|GLOBAL_INTERNAL_DISKFULL_EVENTS       |                30|                 10|                |    0.11|
|HOST_RECORD_LOCKS                     |                 7|                  7|                |    0.11|
|GLOBAL_DEC_EXTRACTOR_STATUS           |-- HANA internal -|                  7|                |    0.05|
|GLOBAL_DEC_EXTRACTORS                 |                 7|      -- not set --|                |n/a     |
---------------------------------------------------------------------------------------------------------

*/

  LPAD(ID, 4) ID,
  TABLE_NAME,
  STATUS,
  LPAD(DEFAULT_RETENTION, 12) DEF_RET_DAYS,
  LPAD(EFFECTIVE_RETENTION, 12) CUR_RET_DAYS,
  IFNULL(LPAD(MAP(TABLE_NAME,
    'GLOBAL_CATALOG_CONSISTENCY',               GLOBAL_CATALOG_CONSISTENCY_DAYS,
    'GLOBAL_DEC_EXTRACTOR_STATUS',              GLOBAL_DEC_EXTRACTOR_STATUS_DAYS,
    'GLOBAL_DISKS',                             GLOBAL_DISKS_DAYS,
    'GLOBAL_INTERNAL_EVENTS',                   GLOBAL_INTERNAL_EVENTS_DAYS,
    'GLOBAL_OUT_OF_MEMORY_EVENTS',              GLOBAL_OUT_OF_MEMORY_EVENTS_DAYS,
    'GLOBAL_PERSISTENCE_STATISTICS',            GLOBAL_PERSISTENCE_STATISTICS_DAYS,
    'GLOBAL_ROWSTORE_TABLES_SIZE',              GLOBAL_ROWSTORE_TABLES_SIZE_DAYS,
    'GLOBAL_TABLE_CONSISTENCY',                 GLOBAL_TABLE_CONSISTENCY_DAYS,
    'GLOBAL_TABLE_PERSISTENCE_STATISTICS',      GLOBAL_TABLE_PERSISTENCE_STATISTICS_DAYS,
    'HOST_BLOCKED_TRANSACTIONS',                HOST_BLOCKED_TRANSACTIONS_DAYS,
    'HOST_COLUMN_TABLES_PART_SIZE',             HOST_COLUMN_TABLES_PART_SIZE_DAYS,
    'HOST_CONNECTION_STATISTICS',               HOST_CONNECTION_STATISTICS_DAYS,
    'HOST_CONNECTIONS',                         HOST_CONNECTIONS_DAYS,
    'HOST_CS_INDEXES',                          HOST_CS_INDEXES_DAYS,
    'HOST_CS_LOB_SPACE_RECLAIMS',               HOST_CS_LOB_SPACE_RECLAIMS_DAYS,
    'HOST_CS_UNLOADS',                          HOST_CS_UNLOADS_DAYS,
    'HOST_DATA_VOLUME_PAGE_STATISTICS',         HOST_DATA_VOLUME_PAGE_STATISTICS_DAYS,
    'HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS',   HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS_DAYS,
    'HOST_DELTA_MERGE_STATISTICS',              HOST_DELTA_MERGE_STATISTICS_DAYS,
    'HOST_DISK_USAGE',                          HOST_DISK_USAGE_DAYS,
    'HOST_HEAP_ALLOCATORS',                     HOST_HEAP_ALLOCATORS_DAYS,
    'HOST_JOB_HISTORY',                         HOST_JOB_HISTORY_DAYS,
    'HOST_LIVECACHE_CONTAINER_STATISTICS',      HOST_LIVECACHE_CONTAINER_STATISTICS_DAYS,
    'HOST_LIVECACHE_OMS_VERSIONS',              HOST_LIVECACHE_OMS_VERSIONS_DAYS,
    'HOST_LIVECACHE_PROCEDURE_STATISTICS',      HOST_LIVECACHE_PROCEDURE_STATISTICS_DAYS,
    'HOST_LIVECACHE_SCHEMA_STATISTICS',         HOST_LIVECACHE_SCHEMA_STATISTICS_DAYS,
    'HOST_LOAD_HISTORY_HOST',                   HOST_LOAD_HISTORY_HOST_DAYS,
    'HOST_LOAD_HISTORY_SERVICE',                HOST_LOAD_HISTORY_SERVICE_DAYS,
    'HOST_LOG_PARTITIONS',                      HOST_LOG_PARTITIONS_DAYS,
    'HOST_LONG_IDLE_CURSOR',                    HOST_LONG_IDLE_CURSOR_DAYS,
    'HOST_LONG_RUNNING_STATEMENTS',             HOST_LONG_RUNNING_STATEMENTS_DAYS,
    'HOST_LONG_SERIALIZABLE_TRANSACTION',       HOST_LONG_SERIALIZABLE_TRANSACTION_DAYS,
    'HOST_MVCC_OVERVIEW',                       HOST_MVCC_OVERVIEW_DAYS,
    'HOST_OBJECT_LOCK_STATISTICS',              HOST_OBJECT_LOCK_STATISTICS_DAYS,
    'HOST_OBJECT_LOCKS',                        HOST_OBJECT_LOCKS_DAYS,
    'HOST_ONE_DAY_FILE_COUNT',                  HOST_ONE_DAY_FILE_COUNT_DAYS,
    'HOST_RECORD_LOCKS',                        HOST_RECORD_LOCKS_DAYS,
    'HOST_RESOURCE_UTILIZATION_STATISTICS',     HOST_RESOURCE_UTILIZATION_STATISTICS_DAYS,
    'HOST_RS_INDEXES',                          HOST_RS_INDEXES_DAYS,
    'HOST_RS_MEMORY',                           HOST_RS_MEMORY_DAYS,
    'HOST_SAVEPOINTS',                          HOST_SAVEPOINTS_DAYS,
    'HOST_SERVICE_COMPONENT_MEMORY',            HOST_SERVICE_COMPONENT_MEMORY_DAYS,
    'HOST_SERVICE_MEMORY',                      HOST_SERVICE_MEMORY_DAYS,
    'HOST_SERVICE_NETWORK_IO',                  HOST_SERVICE_NETWORK_IO_DAYS,
    'HOST_SERVICE_REPLICATION',                 HOST_SERVICE_REPLICATION_DAYS,
    'HOST_SERVICE_THREAD_CALLSTACKS',           HOST_SERVICE_THREAD_CALLSTACKS_DAYS,
    'HOST_SERVICE_THREAD_SAMPLES',              HOST_SERVICE_THREAD_SAMPLES_DAYS,
    'HOST_SERVICE_THREAD_SAMPLES_STATEMENTS',   HOST_SERVICE_THREAD_SAMPLES_STATEMENTS_DAYS,
    'HOST_SERVICE_STATISTICS',                  HOST_SERVICE_STATISTICS_DAYS,
    'HOST_SQL_PLAN_CACHE',                      HOST_SQL_PLAN_CACHE_DAYS,
    'HOST_SQL_PLAN_CACHE_OVERVIEW',             HOST_SQL_PLAN_CACHE_OVERVIEW_DAYS,
    'HOST_UNCOMMITTED_WRITE_TRANSACTION',       HOST_UNCOMMITTED_WRITE_TRANSACTION_DAYS,
    'HOST_VOLUME_FILES',                        HOST_VOLUME_FILES_DAYS,
    'HOST_VOLUME_IO_DETAILED_STATISTICS',       HOST_VOLUME_IO_DETAILED_STATISTICS_DAYS,
    'HOST_VOLUME_IO_RETRY_STATISTICS',          HOST_VOLUME_IO_RETRY_STATISTICS_DAYS,
    'HOST_VOLUME_IO_TOTAL_STATISTICS',          HOST_VOLUME_IO_TOTAL_STATISTICS_DAYS,
    'HOST_WORKLOAD',                            HOST_WORKLOAD_DAYS,
    'STREAMING_PROJECTS_STATISTICS',            STREAMING_PROJECTS_STATISTICS_DAYS,
    'STREAMING_PROJECT_CONNECTIONS_STATISTICS', STREAMING_PROJECT_CONNECTIONS_STATISTICS_DAYS,
    'STREAMING_PROJECT_STREAMS_STATISTICS',     STREAMING_PROJECT_STREAMS_STATISTICS_DAYS,
    'STREAMING_PUBLISHERS_STATISTICS',          STREAMING_PUBLISHERS_STATISTICS_DAYS,
    'STREAMING_SUBSCRIBERS_STATISTICS',         STREAMING_SUBSCRIBERS_STATISTICS_DAYS,
    'TEL_DISK_USAGE',                           TEL_DISK_USAGE_DAYS,
    'TEL_FEATURE_USAGE',                        TEL_FEATURE_USAGE_DAYS,
    'TEL_HOST_INFORMATION',                     TEL_HOST_INFORMATION_DAYS,
    'TEL_INIFILE_CONTENTS',                     TEL_INIFILE_CONTENTS_DAYS,
    'TEL_LICENSE',                              TEL_LICENSE_DAYS,
    'TEL_LICENSES',                             TEL_LICENSES_DAYS,
    'TEL_LOG_BUFFERS',                          TEL_LOG_BUFFERS_DAYS,
    'TEL_LOG_SEGMENTS',                         TEL_LOG_SEGMENTS_DAYS,
    'TEL_OUT_OF_MEMORY_EVENTS',                 TEL_OUT_OF_MEMORY_EVENTS_DAYS,
    'TEL_SYSTEM_OVERVIEW',                      TEL_SYSTEM_OVERVIEW_DAYS
    ), 16), '') OLDEST_DATA_DAYS,
  IFNULL(LPAD(TO_DECIMAL(SIZE_BYTE / 1024 / 1024, 10, 2), 8), 'n/a') SIZE_MB,
  LPAD(RECORDS, 10) RECORDS
FROM
( SELECT
    ID,
    TABLE_NAME,
    DEFAULT_RETENTION,
    EFFECTIVE_RETENTION,
    STATUS,
    SIZE_BYTE,
    RECORDS,
    ONLY_MODIFIED_SETTINGS,
    ONLY_SMALL_RETENTION_TIMES,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_CATALOG_CONSISTENCY )              GLOBAL_CATALOG_CONSISTENCY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_DEC_EXTRACTOR_STATUS )             GLOBAL_DEC_EXTRACTOR_STATUS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_DISKS )                            GLOBAL_DISKS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_INTERNAL_EVENTS )                  GLOBAL_INTERNAL_EVENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_OUT_OF_MEMORY_EVENTS )             GLOBAL_OUT_OF_MEMORY_EVENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_PERSISTENCE_STATISTICS )           GLOBAL_PERSISTENCE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE )             GLOBAL_ROWSTORE_TABLES_SIZE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_TABLE_CONSISTENCY )                GLOBAL_TABLE_CONSISTENCY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.GLOBAL_TABLE_PERSISTENCE_STATISTICS )     GLOBAL_TABLE_PERSISTENCE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_BLOCKED_TRANSACTIONS )               HOST_BLOCKED_TRANSACTIONS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE )            HOST_COLUMN_TABLES_PART_SIZE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_CONNECTION_STATISTICS )              HOST_CONNECTION_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_CONNECTIONS )                        HOST_CONNECTIONS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_CS_INDEXES )                         HOST_CS_INDEXES_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_CS_LOB_SPACE_RECLAIMS )              HOST_CS_LOB_SPACE_RECLAIMS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_CS_UNLOADS )                         HOST_CS_UNLOADS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_DATA_VOLUME_PAGE_STATISTICS )        HOST_DATA_VOLUME_PAGE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS )  HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_DELTA_MERGE_STATISTICS )             HOST_DELTA_MERGE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_DISK_USAGE )                         HOST_DISK_USAGE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_HEAP_ALLOCATORS )                    HOST_HEAP_ALLOCATORS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_JOB_HISTORY )                        HOST_JOB_HISTORY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LIVECACHE_CONTAINER_STATISTICS )     HOST_LIVECACHE_CONTAINER_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LIVECACHE_OMS_VERSIONS )             HOST_LIVECACHE_OMS_VERSIONS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LIVECACHE_PROCEDURE_STATISTICS )     HOST_LIVECACHE_PROCEDURE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LIVECACHE_SCHEMA_STATISTICS )        HOST_LIVECACHE_SCHEMA_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LOAD_HISTORY_HOST )                  HOST_LOAD_HISTORY_HOST_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LOAD_HISTORY_SERVICE )               HOST_LOAD_HISTORY_SERVICE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LOG_PARTITIONS )                     HOST_LOG_PARTITIONS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LONG_IDLE_CURSOR )                   HOST_LONG_IDLE_CURSOR_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LONG_RUNNING_STATEMENTS )            HOST_LONG_RUNNING_STATEMENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_LONG_SERIALIZABLE_TRANSACTION )      HOST_LONG_SERIALIZABLE_TRANSACTION_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_MVCC_OVERVIEW )                      HOST_MVCC_OVERVIEW_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_OBJECT_LOCK_STATISTICS )             HOST_OBJECT_LOCK_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_OBJECT_LOCKS )                       HOST_OBJECT_LOCKS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_ONE_DAY_FILE_COUNT )                 HOST_ONE_DAY_FILE_COUNT_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_RECORD_LOCKS )                       HOST_RECORD_LOCKS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_RESOURCE_UTILIZATION_STATISTICS )    HOST_RESOURCE_UTILIZATION_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_RS_INDEXES )                         HOST_RS_INDEXES_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_RS_MEMORY )                          HOST_RS_MEMORY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SAVEPOINTS )                         HOST_SAVEPOINTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_COMPONENT_MEMORY )           HOST_SERVICE_COMPONENT_MEMORY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_MEMORY )                     HOST_SERVICE_MEMORY_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_NETWORK_IO )                 HOST_SERVICE_NETWORK_IO_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_REPLICATION )                HOST_SERVICE_REPLICATION_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_STATISTICS )                 HOST_SERVICE_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_THREAD_CALLSTACKS )          HOST_SERVICE_THREAD_CALLSTACKS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES )             HOST_SERVICE_THREAD_SAMPLES_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES_STATEMENTS )  HOST_SERVICE_THREAD_SAMPLES_STATEMENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE )                     HOST_SQL_PLAN_CACHE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_SQL_PLAN_CACHE_OVERVIEW )            HOST_SQL_PLAN_CACHE_OVERVIEW_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.STREAMING_PROJECTS_STATISTICS )           STREAMING_PROJECTS_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.STREAMING_PROJECT_CONNECTIONS_STATISTICS) STREAMING_PROJECT_CONNECTIONS_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.STREAMING_PROJECT_STREAMS_STATISTICS )    STREAMING_PROJECT_STREAMS_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.STREAMING_PUBLISHERS_STATISTICS )         STREAMING_PUBLISHERS_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.STREAMING_SUBSCRIBERS_STATISTICS )        STREAMING_SUBSCRIBERS_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_UNCOMMITTED_WRITE_TRANSACTION )      HOST_UNCOMMITTED_WRITE_TRANSACTION_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_VOLUME_FILES )                       HOST_VOLUME_FILES_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_VOLUME_IO_DETAILED_STATISTICS )      HOST_VOLUME_IO_DETAILED_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_VOLUME_IO_RETRY_STATISTICS )         HOST_VOLUME_IO_RETRY_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_VOLUME_IO_TOTAL_STATISTICS )         HOST_VOLUME_IO_TOTAL_STATISTICS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.HOST_WORKLOAD )                           HOST_WORKLOAD_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_DISK_USAGE )                          TEL_DISK_USAGE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_FEATURE_USAGE )                       TEL_FEATURE_USAGE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_HOST_INFORMATION )                    TEL_HOST_INFORMATION_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_INIFILE_CONTENTS )                    TEL_INIFILE_CONTENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_LICENSE )                             TEL_LICENSE_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_LICENSES )                            TEL_LICENSES_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_LOG_BUFFERS )                         TEL_LOG_BUFFERS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_LOG_SEGMENTS )                        TEL_LOG_SEGMENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_OUT_OF_MEMORY_EVENTS )                TEL_OUT_OF_MEMORY_EVENTS_DAYS,
    ( SELECT DAYS_BETWEEN(MIN(SERVER_TIMESTAMP), CURRENT_TIMESTAMP) FROM _SYS_STATISTICS.TEL_SYSTEM_OVERVIEW )                     TEL_SYSTEM_OVERVIEW_DAYS,
    ORDER_BY
  FROM
  ( SELECT
      R.ID,
      R.TABLE_NAME,
      R.STATUS,
      R.DEFAULT_RETENTION,
      R.EFFECTIVE_RETENTION,
      T.SIZE_BYTE,
      T.RECORDS,
      BI.ONLY_MODIFIED_SETTINGS,
      BI.ONLY_SMALL_RETENTION_TIMES,
      BI.ORDER_BY
    FROM
    ( SELECT                      /* Modification section */
        '%' TABLE_NAME,
        ' ' ONLY_MODIFIED_SETTINGS,
        ' ' ONLY_SMALL_RETENTION_TIMES,
        'NAME' ORDER_BY           /* NAME, SIZE, RETENTION */
      FROM
        DUMMY
    ) BI INNER JOIN
    ( SELECT
        SS.ID,
        IFNULL(SS.RETENTION_DAYS_CURRENT, SS.RETENTION_DAYS_DEFAULT) EFFECTIVE_RETENTION,
        SS.RETENTION_DAYS_DEFAULT DEFAULT_RETENTION,
        SS.STATUS,
        CASE
          WHEN UPPER(SO.NAME) = 'COLLECTOR_LIVECACHE_OMSVERSIONS'           THEN 'HOST_LIVECACHE_OMS_VERSIONS'
          WHEN UPPER(SO.NAME) LIKE 'COLLECTOR_LIVECACHE%'                   THEN 'HOST_' || UPPER(SUBSTR(SO.NAME, 11))
          WHEN UPPER(SO.NAME) = 'COLLECTOR_STREAMING_STREAMS_STATISTICS'    THEN 'STREAMING_PROJECT_STREAMS_STATISTICS'
          ELSE UPPER(SUBSTR(SO.NAME, 11))
        END TABLE_NAME
      FROM
        _SYS_STATISTICS.STATISTICS_SCHEDULE SS,
        _SYS_STATISTICS.STATISTICS_OBJECTS SO
      WHERE
        SS.ID = SO.ID AND
        SO.NAME LIKE 'Collector%'
    ) R ON
      ( BI.TABLE_NAME = '%' OR R.TABLE_NAME LIKE UPPER(BI.TABLE_NAME) ) FULL OUTER JOIN
    ( SELECT
        SCHEMA_NAME,
        TABLE_NAME,
        SUM(TABLE_SIZE) SIZE_BYTE,
        MAX(RECORD_COUNT) RECORDS
      FROM
      ( SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          ALLOCATED_FIXED_PART_SIZE + ALLOCATED_VARIABLE_PART_SIZE TABLE_SIZE,
          RECORD_COUNT
        FROM
          M_RS_TABLES 
        UNION ALL
        SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          INDEX_SIZE TABLE_SIZE,
          0 RECORD_COUNT
        FROM
          M_RS_INDEXES 
        UNION ALL
        SELECT
          SCHEMA_NAME,
          TABLE_NAME,
          MEMORY_SIZE_IN_TOTAL SIZE_BYTE,
          RECORD_COUNT
        FROM
          M_CS_TABLES 	
      )
      GROUP BY
        SCHEMA_NAME,
        TABLE_NAME 
    ) T ON
      T.TABLE_NAME = R.TABLE_NAME || '_BASE' AND
      T.SCHEMA_NAME = '_SYS_STATISTICS' AND
      ( T.TABLE_NAME LIKE 'GLOBAL%' OR T.TABLE_NAME LIKE 'HOST%' OR T.TABLE_NAME LIKE 'STREAMING%' OR T.TABLE_NAME LIKE 'TEL%' ) AND
      T.TABLE_NAME NOT IN ( 'HOST_TASKS', 'HOST_TASK_OPERATIONS')
  )
)
WHERE
  ( ONLY_MODIFIED_SETTINGS = ' ' OR EFFECTIVE_RETENTION != DEFAULT_RETENTION )  AND
  ( ONLY_SMALL_RETENTION_TIMES = ' ' OR 
    ( EFFECTIVE_RETENTION < 42 AND ID NOT IN ( 5008, 5010, 5024, 5025, 5026, 5033, 5035, 5600, 5601, 5602, 5603, 5604 ) AND ID >= 1000 ) ) 
ORDER BY
  MAP(ORDER_BY, 'NAME', TABLE_NAME),
  MAP(ORDER_BY, 'SIZE', SIZE_BYTE) DESC,
  MAP(ORDER_BY, 'RETENTION', EFFECTIVE_RETENTION)
