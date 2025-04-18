WITH 

/* 

[NAME]

- HANA_Threads_Callstacks_MiniChecks_2.00.040+

[DESCRIPTION]

- Call stack mini checks

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_SERVICE_THREAD_CALLSTACKS available with SAP HANA >= 2.00.040

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2020/05/28:  1.0 (initial version)
- 2020/09/22:  1.1 (CHECK_ID filter added)
- 2020/10/16:  1.2 (improved memory consumption and runtime by eliminating '%' || <call_stack> || '%' concatenations)

[INVOLVED TABLES]

- HOST_SERVICE_THREAD_CALLSTACKS

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

- CHECK_ID

  Check ID

  'C0200'        --> Show details for check ID C0200
  '%'            --> No restriction related to check ID

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

- MIN_ACTIVE_THREADS

  Threshold for minimum number of average active threads

  0.1             --> Only report call stacks that show up in average in at least 0.1 threads
  -1              --> No restriction related to number of active threads (i.e. any occurrence of a check module will be reported)

- MIN_CRITICAL_THREADS

  Threshold in terms of active threads for reporting a check as critical (C = 'X')

  0.2             --> Only report call stacks as critical (C = 'X') that show up in average in at least 0.2 threads
  -1              --> Report all lines as potentially critical

[OUTPUT PARAMETERS]

- CHID:            Call stack check ID (C<id>)
- AREA:            Problem area (e.g. 'Memory')
- DESCRIPTION:     Description of underlying activity indicated by the call stack module
- HOST:            Host name
- PORT:            Port
- COUNT:           Number of samples with related call stack module
- ACT_THR:         Average number of active threads
- LAST_OCCURRENCE: Last time when trace entry was written
- SAP_NOTE:        SAP Note
- C:               'X' if average number of active threads exceeds MIN_CRITICAL_THREADS
- DETAILS:         Call stack module

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|CHID |AREA          |DESCRIPTION                              |HOST       |PORT |COUNT |ACT_THR|LAST_OCCURRENCE    |SAP_NOTE|DETAILS                                                             |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|     |TIME FRAME:   |2020/05/21 14:50:04 - 2020/05/28 14:50:04|           |     |      |       |                   |        |                                                                    |
|     |CHECK VERSION:|1.0.0 (2020/05/28)                       |           |     |      |       |                   |        |                                                                    |
|     |SAP Note:     |2313619                                  |           |     |      |       |                   |        |                                                                    |
|     |              |                                         |           |     |      |       |                   |        |                                                                    |
|C0100|Memory        |Proactive memory compactions             |saphana00xx|32003|  1195|   0.59|2020/05/28 12:09:52| 1999997|MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation|
|     |              |                                         |saphana00yx|32003|   586|   0.29|2020/05/28 12:09:52| 1999997|MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation|
|     |              |                                         |saphana001x|32003|   921|   0.45|2020/05/28 11:44:46| 1999997|MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation|
|     |              |                                         |saphana002x|32003|  1506|   0.74|2020/05/28 12:09:52| 1999997|MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation|
|     |              |                                         |saphana004x|32003|  1098|   0.54|2020/05/28 12:05:24| 1999997|MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation|
|C0110|Memory        |ABAP timezone cache access               |saphana00xx|32003|    81|   0.04|2020/05/28 13:29:30| 1999998|ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache  |
|     |              |                                         |saphana00yx|32003|    46|   0.02|2020/05/27 17:14:34| 1999998|ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache  |
|     |              |                                         |saphana001x|32003| 11650|   5.78|2020/05/28 14:14:30| 1999998|ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache  |
|     |              |                                         |saphana002x|32003|   481|   0.23|2020/05/28 14:29:33| 1999998|ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache  |
|     |              |                                         |saphana004x|32003|   121|   0.06|2020/05/28 14:19:34| 1999998|ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache  |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    CHECK_ID,
    HOST,
    PORT,
    MIN_ACTIVE_THREADS,
    MIN_CRITICAL_THREADS,
    SAMPLE_INTERVAL_S
  FROM
  ( SELECT                  /* Modification section */
      'C-D7' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      'C' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      '%' CHECK_AREA,
      '%' CHECK_ID,
      '%' HOST,
      '%' PORT,
      0.02 MIN_ACTIVE_THREADS,
      0.2 MIN_CRITICAL_THREADS
    FROM
      DUMMY
  ),
  ( SELECT
      IFNULL(S.INTERVALLENGTH, 300) SAMPLE_INTERVAL_S
    FROM
      DUMMY LEFT OUTER JOIN
      _SYS_STATISTICS.STATISTICS_SCHEDULE S ON
        S.ID = 5057
  )
),
CALLSTACKS AS
( SELECT
    T.*
  FROM
    BASIS_INFO BI,
  ( SELECT
      SECONDS_BETWEEN(MIN(T.SERVER_TIMESTAMP) OVER (), MAX(T.SERVER_TIMESTAMP) OVER ()) TIMEFRAME_S,
      BI.SAMPLE_INTERVAL_S,
      BI.TIMEZONE,
      BI.CHECK_AREA,
      BI.CHECK_ID,
      BI.MIN_ACTIVE_THREADS,
      BI.MIN_CRITICAL_THREADS,
      T.*
    FROM
      BASIS_INFO BI,
      _SYS_STATISTICS.HOST_SERVICE_THREAD_CALLSTACKS T
    WHERE
      CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SERVER_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME
  ) T
  WHERE
    T.HOST LIKE BI.HOST AND
    TO_VARCHAR(T.PORT) LIKE BI.PORT
)
SELECT
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN CASE WHEN CHECK_ID >= 100 THEN 'C' || LPAD(CHECK_ID, 4, '0') ELSE '' END ELSE '' END CHID,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN AREA ELSE '' END AREA,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID ORDER BY HOST, PORT) = 1 THEN DESCRIPTION ELSE '' END DESCRIPTION,
  CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHECK_ID, HOST ORDER BY PORT) = 1 THEN HOST ELSE '' END HOST,
  CASE WHEN PORT >= 0 THEN LPAD(PORT, 5) ELSE '' END PORT,
  CASE WHEN COUNT >= 0 THEN LPAD(COUNT, 6) ELSE '' END COUNT,
  CASE WHEN COUNT >= 0 THEN LPAD(ACT_THR, 8) ELSE '' END ACT_THR,
  LAST_OCCURRENCE,
  C,
  CASE WHEN SAP_NOTE >= 0 THEN LPAD(SAP_NOTE, 8) ELSE '' END SAP_NOTE,
  DETAILS
FROM
( SELECT
    1 CHECK_ID,
    'Generated with:' AREA,
    'SQL: "HANA_Threads_Callstacks_MiniChecks"' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    -1 ACT_THR,
    '' LAST_OCCURRENCE,
    '' C,
    1969700 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    2 CHECK_ID,
    'Check version:' AREA,
    '1.0.101 (2024/09/17)' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 COUNT,
    -1 ACT_THR,
    '' LAST_OCCURRENCE,
    '' C,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    3 CHECK_ID,
    'SAP Note:' AREA,
    '2313619' DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 ACT_THR,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    '' C,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    DUMMY
  UNION ALL
  SELECT
    4 CHECK_ID,
    'System ID / DB name:' AREA,
    SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME DESCRIPTION,
    '' HOST,
    -1 PORT,
    -1 ACT_THR,
    -1 COUNT,
    '' LAST_OCCURRENCE,
    '' C,
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
    -1 ACT_THR,
    '' LAST_OCCURRENCE,
    '' C,
    -1 SAP_NOTE,
    '' DETAILS
  FROM
    BASIS_INFO
  UNION ALL
  SELECT 30, '', '', '', -1, -1, -1, '', '', -1, '' FROM DUMMY
  UNION ALL
  SELECT
    CHECK_ID,
    AREA,
    DESCRIPTION,
    HOST,
    PORT,
    COUNT,
    ACT_THR,
    LAST_OCCURRENCE,
    CASE WHEN ACT_THR >= MIN_CRITICAL_THREADS THEN 'X' ELSE '' END C,
    SAP_NOTE,
    SUBSTR(DETAILS, 2, LENGTH(DETAILS) - 2) DETAILS
  FROM
  ( SELECT
      C.CHECK_ID,
      C.AREA,
      C.DESCRIPTION,
      T.HOST,
      T.PORT,
      COUNT(*) COUNT,
      TO_DECIMAL(MAP(TIMEFRAME_S, 0, 0, COUNT(*) * T.SAMPLE_INTERVAL_S / T.TIMEFRAME_S), 10, 4) ACT_THR,
      TO_VARCHAR(MAX(CASE T.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(T.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE T.SERVER_TIMESTAMP END), 'YYYY/MM/DD HH24:MI:SS') LAST_OCCURRENCE,
      C.MAX_FRAME_LEVEL,
      C.SAP_NOTE,
      MAX(C.FRAME_NAME) DETAILS,
      T.MIN_ACTIVE_THREADS,
      T.MIN_CRITICAL_THREADS
    FROM
      CALLSTACKS T,
      ( SELECT  100 CHECK_ID, 'Memory' AREA, 'Proactive memory compaction' DESCRIPTION, '%MemoryManager::ProactiveCompactionCallback::proactiveDefragmentation%' FRAME_NAME, -1 MAX_FRAME_LEVEL, 1999997 SAP_NOTE FROM DUMMY UNION ALL
        SELECT  102, 'Memory',             'Memory unmapping',                                 '%System::UX::munmap%',                                                       -1, 1999997 FROM DUMMY UNION ALL
        SELECT  104, 'Memory',             'Memory remapping',                                 '%__GI___mremap%',                                                            -1, 1999997 FROM DUMMY UNION ALL
        SELECT  106, 'Memory',             'Memory compaction triggered from other service',   '%MemoryManager::CompactionThread::run%',                                     -1, 1999997 FROM DUMMY UNION ALL
        SELECT  107, 'Memory',             'Memory compaction triggered service-internally',   '%MemoryManager::%::provideMemoryAndReturnSize%',                             -1, 1999997 FROM DUMMY UNION ALL
        SELECT  108, 'Memory',             'Threads supporting service-internal compaction',   '%MemoryManager::IPMMReclaimMemory::supportReclaimMemoryIntern%',             -1, 1999997 FROM DUMMY UNION ALL
        SELECT  109, 'Memory',             'Resource container shrink',                        '%ResourceManager::ResourceContainerImpl::shrink%',                           -1, 1999997 FROM DUMMY UNION ALL
        SELECT  110, 'Memory',             'ABAP timezone cache access',                       '%ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache%',       -1, 1999998 FROM DUMMY UNION ALL
        SELECT  120, 'Memory',             'Data statistics advisor cache operation',          '%DataStatistics::DataStatisticsAdviserCache%',                               -1, 2100040 FROM DUMMY UNION ALL
        SELECT  122, 'Memory',             'Column store access statistics cache operation',   '%AttributeEngine::AccessCounterHelpers::%CSAccessStatisticsCache%',          -1, 2502256 FROM DUMMY UNION ALL
        SELECT  123, 'Memory',             'Column store access statistics entry removal',     '%CSAccessStatisticsCache::removeEntriesFromCacheForATableID%',               -1, 2502256 FROM DUMMY UNION ALL
        SELECT  125, 'Memory',             'Local metadata lookup',                            '%Metadata::StorageWrapperImpl::getLatestVersion%',                           -1, 1999997 FROM DUMMY UNION ALL
        SELECT  126, 'Memory',             'Metadata caching of column store tables',          '%Metadata::MDCacheHandler::cacheCSTableInfoByName%',                         -1, 1999997 FROM DUMMY UNION ALL
        SELECT  130, 'Memory',             'Allocator statistics access',                      '%ltt::allocator_statistics::isVisible%',                                     -1, 2100040 FROM DUMMY UNION ALL
        SELECT  140, 'Memory',             'BitVector processing',                             '%TRexUtils::BitVector::%',                                                   -1, 2112604 FROM DUMMY UNION ALL
        SELECT  142, 'Memory',             'Row store smart memory manager activity',          '%RowEngine::SmartMemoryManager::examineMemory%',                             -1, 3016724 FROM DUMMY UNION ALL
        SELECT  144, 'Memory',             'Implicit memory booking reset',                    '%ptime::Statement::resetImpliStats%',                                        -1, 1999997 FROM DUMMY UNION ALL
        SELECT  146, 'Memory',             'Tracking of statement memory statistics',          '%TRexUtils::MemoryStatistics::setStatementMemoryStatistics%',                -1, 3336811 FROM DUMMY UNION ALL
        SELECT  148, 'Memory',             'Collection of allocated memory information',       '%MemoryManager::LimitInfo::getSumAllocatedInternal%',                        -1, 1999997 FROM DUMMY UNION ALL
        SELECT  150, 'Memory',             'Memory fencing / allocation stack trace',          '%MemoryManager::CheckedBlockHandler::prepare%',                              -1, 2222218 FROM DUMMY UNION ALL
        SELECT  151, 'Memory',             'Allocation stack trace',                           '%MemoryManager::CheckedBlockHandler::createStacktrace%',                     -1, 2222218 FROM DUMMY UNION ALL
        SELECT  160, 'Memory',             'Resource manager - release and update time',       '%ResourceManager::ResourceHeader::releaseAndUpdateTime%',                    -1, 1999997 FROM DUMMY UNION ALL
        SELECT  161, 'Memory',             'Resource manager - add reference',                 '%ResourceManager::ResourceHeader::addReference%',                            -1, 1999997 FROM DUMMY UNION ALL
        SELECT  162, 'Memory',             'Resource manager - resource container get',        '%ResourceManager::ResourceContainer::get%',                                  -1, 1999997 FROM DUMMY UNION ALL
        SELECT  163, 'Memory',             'Resource manager - resource header state flags',   '%ResourceManager::casResourceHeaderStateFlags%',                             -1, 1999997 FROM DUMMY UNION ALL
        SELECT  165, 'Memory',             'Resource header creation',                         '%ResourceManager::ResourceContainerImpl::createResourceHeader%',             -1, 1999997 FROM DUMMY UNION ALL
        SELECT  170, 'Memory',             'Memory to filesystem synchronization',             '%.annobin_msync.c%',                                                         -1, 2700084 FROM DUMMY UNION ALL
        SELECT  175, 'Memory',             'Total statement memory limit calculation',         '%ltt::allocator_statistics::incrementSecondaryCompositeLimitRelevantUsage%', -1, 2222250 FROM DUMMY UNION ALL
        SELECT  200, 'Internal tasks',     'Currency conversion',                              '%businessDB::Conversion::convert%',                                          -1, 2100040 FROM DUMMY UNION ALL
        SELECT  210, 'Internal tasks',     'Timezone converter call',                          '%TRexUtils::TimeZoneConverterHandler::TimeZoneConverterHandler%',            -1, 1791342 FROM DUMMY UNION ALL
        SELECT  220, 'Internal tasks',     'Retrieval of current execution usage',             '%Execution::ContextStatistics::getCurrentExecutionUsage%',                   -1, 2313619 FROM DUMMY UNION ALL
        SELECT  225, 'Internal tasks',     'Automatic unload check',                           '%TRexAPI::MergeMonitor::checkUnload%',                                       -1, 2127458 FROM DUMMY UNION ALL
        SELECT  226, 'Internal tasks',     'Determination of delta merge candidates',          '%TRexAPI::Mergedog::getMergeCandidates%',                                    -1, 2057046 FROM DUMMY UNION ALL
        SELECT  230, 'Internal tasks',     'Checksum calculation',                             '%ltt::crc32_u64%',                                                           -1, 2313619 FROM DUMMY UNION ALL
        SELECT  240, 'Internal tasks',     'HEX to RAW conversion',                            '%TRexUtils::hexToRaw%',                                                      -1, 2313619 FROM DUMMY UNION ALL
        SELECT  300, 'Disks',              'Linux file descriptor manipulation (fcntl)',       '%__libc_fcntl%',                                                             -1, 1999930 FROM DUMMY UNION ALL
        SELECT  301, 'Disks',              'Linux file read',                                  '%System::UX::read%',                                                         -1, 1999930 FROM DUMMY UNION ALL
        SELECT  302, 'Disks',              'File state determination',                         '%System::UX::stat%',                                                         -1, 1999930 FROM DUMMY UNION ALL
        SELECT  303, 'Disks',              'File state determination with symlink handling',   '%System::UX::lstat%',                                                        -1, 1999930 FROM DUMMY UNION ALL
        SELECT  304, 'Disks',              'Renaming of a file',                               '%FileAccess::fileRename%',                                                   -1, 1999930 FROM DUMMY UNION ALL
        SELECT  306, 'Disks',              'Opening of a file',                                '%FileAccess::fileOpen%',                                                     -1, 1999930 FROM DUMMY UNION ALL
        SELECT  307, 'Disks',              'System call open',                                 '%__open_nocancel%',                                                          -1, 1999930 FROM DUMMY UNION ALL
        SELECT  308, 'Disks',              'Directory entry scan',                             '%__getdents%',                                                               -1, 1999930 FROM DUMMY UNION ALL
        SELECT  310, 'Disks',              'Disk information retrieval',                       '%NameServer::TNSClient::getDiskInfo%',                                       -1, 1999930 FROM DUMMY UNION ALL
        SELECT  312, 'Disks',              'Snapshot converter page load',                     '%PageAccess::PageIteratorOnSnapshotConverter::loadPage%',                    -1, 1999930 FROM DUMMY UNION ALL
        SELECT  314, 'Disks',              'File owner change operation (chown)',              '%System::UX::chown%',                                                        -1, 1999930 FROM DUMMY UNION ALL
        SELECT  400, 'Operating system',   'Exception unwinding',                              '%_Unwind_Find_FDE%',                                                         -1, 2100040 FROM DUMMY UNION ALL
        SELECT  402, 'Operating system',   'Processing of kill command',                       '%__GI_kill%',                                                                -1, 2100040 FROM DUMMY UNION ALL
        SELECT  410, 'Operating system',   'Timezone conversion',                              '%__tz_convert%',                                                             -1, 2100040 FROM DUMMY UNION ALL
        SELECT  412, 'Operating system',   'High resolution timer fallback used',              '%__vdso_gettimeofday%',                                                      -1, 2100040 FROM DUMMY UNION ALL
        SELECT  414, 'Operating system',   'Timer operating system call used',                 '%clock_gettime%',                                                            -1, 2100040 FROM DUMMY UNION ALL
        SELECT  415, 'Operating system',   'Time retrieval in micro-seconds',                  '%rte::timer::us%',                                                           -1, 2100040 FROM DUMMY UNION ALL
        SELECT  416, 'Operating system',   'Epoch timestamp conversion',                       '%TRexUtils::SystemClockConverter::convert%',                                 -1, 2100040 FROM DUMMY UNION ALL
        SELECT  417, 'Operating system',   'Time retrieval in nano-seconds',                   '%rte::timer::ns%',                                                           -1, 2100040 FROM DUMMY UNION ALL
        SELECT  420, 'Operating system',   'UUID generation',                                  '%uuid_generate%',                                                            -1, 1999998 FROM DUMMY UNION ALL
        SELECT  422, 'Operating system',   'Retrieval of load average',                        '%get_loadavg%',                                                              -1, 2100040 FROM DUMMY UNION ALL
        SELECT  424, 'Operating system',   'KPI limit and value determination',                '%KPILimitsAndValues%',                                                       -1, 2169283 FROM DUMMY UNION ALL
        SELECT  426, 'Operating system',   'Memory map retrieval',                             '%Diagnose::LinuxMemoryMap::readMappings%',                                   -1, 1999997 FROM DUMMY UNION ALL
        SELECT  430, 'Operating system',   'Network interface address retrieval',              '%__GI_getifaddrs%',                                                          -1, 2222200 FROM DUMMY UNION ALL
        SELECT  431, 'Operating system',   'Network write',                                    '__writev%',                                                                  -1, 2222200 FROM DUMMY UNION ALL
        SELECT  432, 'Operating system',   'Network receive',                                  '__libc_recv%',                                                               -1, 2222200 FROM DUMMY UNION ALL
        SELECT  432, 'Operating system',   'Network receive',                                  '.annobin_recv.c%',                                                           -1, 2222200 FROM DUMMY UNION ALL
        SELECT  435, 'Operating system',   'NUMA node retrieval',                              '%System::getNUMANodeOfAddress%',                                             -1, 2470289 FROM DUMMY UNION ALL
        SELECT  500, 'Traces',             'Database trace flush',                             '%Diagnose::TraceStream::flushTraceBuffer%',                                  -1, 2380176 FROM DUMMY UNION ALL
        SELECT  501, 'Traces',             'Common trace flush',                               '%Diagnose::CommonTraceFlushCallback%',                                       -1, 2119087 FROM DUMMY UNION ALL
        SELECT  510, 'Traces',             'Call stack generation (diagnose)',                 '%Diagnose::CallStackManager::saveStackLimited%',                             -1, 2313619 FROM DUMMY UNION ALL
        SELECT  511, 'Traces',             'Call stack generation (exception)',                '%ltt::exception::print_stack%',                                              -1, 2313619 FROM DUMMY UNION ALL
        SELECT  512, 'Traces',             'Call stack generation (context function)',         '%Execution::spi::ContextFunctions::printStack%',                             -1, 2313619 FROM DUMMY UNION ALL
        SELECT  520, 'Traces',             'User specific trace processing',                   '%Diagnose::CountedUserTraceContext%',                                        -1, 2119087 FROM DUMMY UNION ALL
        SELECT  521, 'Traces',             'User specific trace setup',                        '%Execution::StatementContext::setupUserTrace%',                              -1, 2119087 FROM DUMMY UNION ALL
        SELECT  530, 'Traces',             'Wait for trace segment availability',              '%Diagnose::TraceSegment::waitReady%',                                        -1, 2380176 FROM DUMMY UNION ALL
        SELECT  535, 'Traces',             'Setting of database trace context level',          '%Diagnose::diag_topic::context_levels::set_level%',                          -1, 2119087 FROM DUMMY UNION ALL
        SELECT  540, 'Traces',             'Performance analyzer activity',                    '%Diagnose::PerformanceAnalyzerScope%',                                       -1, 2119087 FROM DUMMY UNION ALL
        SELECT  545, 'Traces',             'SQL client network I/O trace activity',            '%handleSqlClientNetworkIO%',                                                 -1, 2119087 FROM DUMMY UNION ALL
        SELECT  550, 'Traces',             'Expensive statements trace writing',               '%ptime::ExpensiveStatementTracerImpl::writeTrace%',                          -1, 2180165 FROM DUMMY UNION ALL
        SELECT  555, 'Traces',             'SQL trace activity',                               '%ptime::SQLTrace%',                                                          -1, 2119087 FROM DUMMY UNION ALL
        SELECT  560, 'Traces',             'Kernel trace flush',                               '%Diagnose::MultiCompressLtraceFileFlushCallback::triggerFlush%',             -1, 2119087 FROM DUMMY UNION ALL
        SELECT  565, 'Traces',             'Load tracer activity',                             '%AttributeEngine::LoadTracer::traceEvent%',                                  -1, 2127458 FROM DUMMY UNION ALL
        SELECT  600, 'Garbage collection', 'Row store table post drop activity',               '%RowEngine::PostDropJob::run%',                                              -1, 1999998 FROM DUMMY UNION ALL
        SELECT  610, 'Garbage collection', 'Row store version filtering',                      '%ptime::filter_slot_backend%',                                               -1, 2169283 FROM DUMMY UNION ALL
        SELECT  612, 'Garbage collection', 'Row store version lock info retrieval',            '%RowEngine::Version::RSVersionTable::getRoughVersionLockInfo%',              -1, 2169283 FROM DUMMY UNION ALL
        SELECT  614, 'Garbage collection', 'Row store version creation',                       '%ptime::VersionMgr::createVersion%',                                         -1, 2169283 FROM DUMMY UNION ALL
        SELECT  620, 'Garbage collection', 'Consistent view cleanup',                          '%TransactionManager::ConsistentView::releaseAcquiredHandles%',               -1, 3038422 FROM DUMMY UNION ALL
        SELECT  622, 'Garbage collection', 'Transactional lock cleanup',                       '%TrexStore::RowLockManagerAPI::clearLocks%',                                 -1, 1999998 FROM DUMMY UNION ALL
        SELECT  630, 'Garbage collection', 'Minimum pre-commit timestamp retrieval',           '%TransactionManager::TransactionManager::getMinPrecommitTS%',                -1, 2169283 FROM DUMMY UNION ALL
        SELECT  631, 'Garbage collection', 'Minimum snapshot timestamp retrieval',             '%TransactionManager::TransactionManager::getMinSnapshotTS%',                 -1, 2169283 FROM DUMMY UNION ALL
        SELECT  800, 'Sessions',           'Connection rollback',                              '%ptime::Connection::rollback%',                                              -1, 2000000 FROM DUMMY UNION ALL
        SELECT  801, 'Sessions',           'Session buffer cleanup',                           '%ptime::SessionBufferCleanupCallback::onSent%',                              -1, 2313619 FROM DUMMY UNION ALL
        SELECT  802, 'Sessions',           'External in-use count invalidation',               '%ptime::Transaction::invalidate_external_inuse_count%',                      -1, 2092196 FROM DUMMY UNION ALL
        SELECT  810, 'Sessions',           'Catalyst hash map access',                         '%Catalyst::HashMap::reserve%',                                               -1, 2100040 FROM DUMMY UNION ALL
        SELECT  830, 'Sessions',           'Joining of thread contexts',                       '%pthread_join%',                                                             -1, 2114710 FROM DUMMY UNION ALL
        SELECT  900, 'Security',           'LDAP authentication',                              '%Authentication::LDAP::Session::bind%',                                      -1, 2929927 FROM DUMMY UNION ALL
        SELECT  909, 'Security',           'OS text file audit trail write',                   '%Auditing::OSTextFileAuditTrailWriter::writeAuditEntry%',                    -1, 1991634 FROM DUMMY UNION ALL
        SELECT  910, 'Security',           'OS syslog audit trail write',                      '%Auditing::SyslogAuditTrailWriter::writeAuditEntry%',                        -1, 2624117 FROM DUMMY UNION ALL
        SELECT  911, 'Security',           'Table audit trail write',                          '%Auditing::CSTableAuditTrailWriter::writeAuditEntry%',                       -1, 2159014 FROM DUMMY UNION ALL
        SELECT  920, 'Security',           'Dependent object retrieval',                       '%Metdata::ObjectDependencyMgr::get_dependent_objects%',                      -1, 2313619 FROM DUMMY UNION ALL
        SELECT  925, 'Security',           'Validation of dynamic conditions',                 '%TrexCalculationEngine::CeDynamicConditionValidator%',                       -1, 2908857 FROM DUMMY UNION ALL
        SELECT  930, 'Security',           'Authorization check',                              '%Authorization::AuthorizationManager::isAuthorized%',                        -1, 2159014 FROM DUMMY UNION ALL
        SELECT  935, 'Security',           'SSL handshake',                                    '%ptime::SessionHandler::doSSLHandshake%',                                    -1, 2159014 FROM DUMMY UNION ALL
        SELECT 1000, 'Locks',              'Nameserver lock file access',                      '%TrexIpc::NameserverLock%',                                                  -1, 2100296 FROM DUMMY UNION ALL
        SELECT 1002, 'Locks',              'SSL session cache access',                         '%ssl_update_cache%',                                                         -1, 2960895 FROM DUMMY UNION ALL
        SELECT 1003, 'Locks',              'SSL get new session request',                      '%ssl_get_new_session%',                                                      -1, 2960895 FROM DUMMY UNION ALL
        SELECT 1008, 'Locks',              'Internal timed mutex lock',                        '%pthread_mutex_timedlock%',                                                  -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1009, 'Locks',              'Internal mutex unlock',                            '%pthread_mutex_unlock%',                                                     -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1010, 'Locks',              'Internal mutex lock',                              '%pthread_mutex_lock%',                                                       -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1011, 'Locks',              'Yield lock wait',                                  '%__GI___sched_yield%',                                                       -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1012, 'Locks',              'Spin lock wait',                                   '%Synchronization::impl::SpinLock::_lock%',                                   -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1013, 'Locks',              'Futex lock wait',                                  '%ptime::Futex::lock%',                                                       -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1017, 'Locks',              'Trying of read-write lock',                        '%Synchronization::ReadWriteLock::tryLock%',                                  -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1018, 'Locks',              'Unlocking of "fast read"-"slow write" lock',       '%Synchronization::FastReadSlowWriteLock::unlock%',                           -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1019, 'Locks',              'Unlocking of read-write lock',                     '%Synchronization::ReadWriteLock::unlock%',                                   -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1020, 'Locks',              'Unlocking of mutex',                               '%Synchronization::Mutex::unlock%',                                           -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1021, 'Locks',              'Unlocking of non-recursive mutex',                 '%Synchronization::NonrecursiveMutex::unlock%',                               -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1022, 'Locks',              'Maintenance of read write lock statistics',        '%Synchronization::ReadWriteLockStatistics::ReadWriteLockStatistics%',        -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1025, 'Locks',              'Maintenance of transactional object lock',         '%ptime::TableLock::getEntry%',                                               -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1026, 'Locks',              'Unlocking of transactional object lock',           '%ptime::TableLock::unlockTable%',                                            -1, 1999998 FROM DUMMY UNION ALL
        SELECT 1100, 'Text search',        'Inxight tagged stemming',                          '%inxight::tagged_stemming_implementation%',                                  -1, 2800008 FROM DUMMY UNION ALL
        SELECT 1110, 'Text search',        'Fuzzy search scoring',                             '%text_search::BM25Scorer::score%',                                           -1, 2800008 FROM DUMMY UNION ALL
        SELECT 1200, 'Partitioning',       'Record move between partitions',                   '%TrexStore::UdivListManager::getEqualSSNUdivs%',                             -1, 2044468 FROM DUMMY UNION ALL
        SELECT 1205, 'Partitioning',       'Select count update',                              '%TRexAPI::SearchAPI::updateSelectCountInfo%',                                -1, 2088971 FROM DUMMY UNION ALL
        SELECT 1210, 'Partitioning',       'Partition pruning statistics calculation',         '%TRexAPI::Partitioning::Pruning::calculate%',                                -1, 2044468 FROM DUMMY UNION ALL
        SELECT 1220, 'Partitioning',       'Reorg plan precondition check',                    '%TableRedist::ReorgPlan::setPreconditionTextInGrp%',                         -1, 2081591 FROM DUMMY UNION ALL
        SELECT 1225, 'Partitioning',       'LOB copy',                                         '%PersistenceLayer::LOBCopyFilesJob::doRun%',                                 -1, 2044468 FROM DUMMY UNION ALL
        SELECT 1300, 'Triggers',           'Trigger execution',                                '%TRexAPI::TriggerExecutors::execute%',                                       -1, 2800020 FROM DUMMY UNION ALL
        SELECT 1350, 'Sequences',          'Sequence management',                              '%ptime::SequenceManager%',                                                   -1, 2600095 FROM DUMMY UNION ALL
        SELECT 1400, 'Parsing',            'Llang interpreter activity',                       '%ljit::llang::LlangInterpreter::run%',                                       -1, 2124112 FROM DUMMY UNION ALL
        SELECT 1401, 'Parsing',            'Llang interpreter compilation',                    '%ljit::llang::LlangInterpreterCompile::compile%ljit_llang_interpreter%',     -1, 2124112 FROM DUMMY UNION ALL
        SELECT 1402, 'Parsing',            'Dynamic plan condition check',                     '%ptime::Query::Plan::check_dynamic_plan_conditions%',                        -1, 2908857 FROM DUMMY UNION ALL
        SELECT 1410, 'Parsing',            'Compilation overhead due to early itab release',   '%sqlscript::ir::ReleaseOpGenerationPass::run%',                              -1, 3068923 FROM DUMMY UNION ALL
        SELECT 1420, 'Parsing',            'Column data statistics retrieval',                 '%DataStatistics::DS::getColumnsStats%',                                      -1, 2800028 FROM DUMMY UNION ALL
        SELECT 1422, 'Parsing',            'Building of data statistics sample',               '%buildDataStatisticsSample%',                                                -1, 2800028 FROM DUMMY UNION ALL
        SELECT 1500, 'SQL',                'HEX index join activity',                          '%hex::cs::IndexJoinOp::run%',                                                -1, 2570371 FROM DUMMY UNION ALL
        SELECT 1501, 'SQL',                'HEX finish receive control',                       '%hex::operators::ReceiveControlOp::finish%',                                 -1, 2169283 FROM DUMMY UNION ALL
        SELECT 1502, 'SQL',                'Multi-column semi join',                           '%AttributeEngine::MultiColumnSemiJoin%',                                     -1, 2000002 FROM DUMMY UNION ALL
        SELECT 1503, 'SQL',                'HEX row store index join',                         '%op_Mat_Mat_InputLimiter_RSIndexJoinOp_JoinPred_Mat_GroupByOp-export%',      -1, 3405833 FROM DUMMY UNION ALL
        SELECT 1504, 'SQL',                'HEX task finalization',                            '%hex::TaskScheduler::finishAndWait%',                                        -1, 2570371 FROM DUMMY UNION ALL
        SELECT 1505, 'SQL',                'HEX dictionary scan',                              '%hex::cs::PredicateDictScanOp::run%',                                        -1, 2570371 FROM DUMMY UNION ALL
        SELECT 1506, 'SQL',                'HEX FOR ALL ENTRIES processing',                   '%hex::cs::FAEPredicateOp%',                                                  -1, 2570371 FROM DUMMY UNION ALL
        SELECT 1510, 'SQL',                'Multi-column itab processing',                     '%qo3::OptimizerImpl::doTermItabMultiCol%',                                   -1, 2875426 FROM DUMMY UNION ALL
        SELECT 1512, 'SQL',                'Optimization of IN list to itab conversion',       '%ptime::qo_Normalizer::translate_to_disjunctive_normal_form%',               -1, 3329340 FROM DUMMY UNION ALL
        SELECT 1520, 'SQL',                'Delta storage DocBuffer access',                   '%AttributeEngine::Delta::DocBuffer::loadBlock%',                             -1, 2000002 FROM DUMMY UNION ALL
        SELECT 1522, 'SQL',                'Delta fusion',                                     '%UnifiedTable::MergeJob::executeDeltaFusion%',                               -1, 2057046 FROM DUMMY UNION ALL
        SELECT 1530, 'SQL',                'Evaluation of ESX field expression',               '%ESX::FieldExpression%evaluate%',                                            -1, 3125731 FROM DUMMY UNION ALL
        SELECT 1532, 'SQL',                'Wildcard pattern search',                          '%TRexUtils::WildcardPattern%',                                               -1, 2000002 FROM DUMMY UNION ALL
        SELECT 1534, 'SQL',                'Incremental translation table filling',            '%JoinEvaluator::TranslationTable::incrementalFill%',                         -1, 1998599 FROM DUMMY UNION ALL
        SELECT 1538, 'SQL',                'Fast locale evaluation',                           '%TRexUtils::LocaleLt::fastLocaleCmp%',                                       -1, 2313619 FROM DUMMY UNION ALL
        SELECT 1540, 'SQL',                'Modification using inverted individual index',     '%TRexAPI::Dml::UdivUpdateWithoutConcat::runLookup%',                         -1, 3307111 FROM DUMMY UNION ALL
        SELECT 1542, 'SQL',                'Monitoring view filter evaluation',                '%StatisticsFilter.cpp%',                                                     -1, 2000002 FROM DUMMY UNION ALL
        SELECT 1544, 'SQL',                'Unique constraint check on partition level',       '%TRexAPI::PartCheck::checkUniqueConstraintsOnLocalPart%',                    -1, 2600076 FROM DUMMY UNION ALL
        SELECT 1600, 'Objects',            'Determination of objects in schema',               '%ptime::SysTableQuery::get_objects_of_schema%',                              -1, 2940667 FROM DUMMY UNION ALL
        SELECT 1700, 'System replication', 'LZ4 log compression',                              '%DataAccess::LZ4Compressor::compress%',                                      -1, 1999880 FROM DUMMY UNION ALL
        SELECT 1800, 'NSE',                'Loading of dictionary block',                      '%UnifiedTable::DictionaryPagedBlockProvider::loadPageSpanningDictBlock%',    -1, 2799997 FROM DUMMY UNION ALL
        SELECT 1805, 'NSE',                'Stealing of buffer cache resource',                '%BufferCacheManager::BufferCacheAllocationPolicy::stealResources%',          -1, 2799997 FROM DUMMY UNION ALL
        SELECT 1900, 'SDA / SDI / SDQ',    'Remote Oracle database access',                    '%kpucpincrtime%',                                                            -1, 2180119 FROM DUMMY UNION ALL
        SELECT 1910, 'SDA / SDI / SDQ',    'DPFramework thread shutdown',                      '%DPFramework::ShutdownThread%',                                              -1, 2400022 FROM DUMMY UNION ALL
        SELECT 2000, 'Configuration',      'Remote service reconfiguration',                   '%TrexService::RemoteService::reconfig%',                                     -1, 2186744 FROM DUMMY UNION ALL
        SELECT 2010, 'Configuration',      'Parameter value access',                           '%Configuration::Parameter%::value%',                                         -1, 2186744 FROM DUMMY UNION ALL
        SELECT 2011, 'Configuration',      'Parameter ID access',                              '%Configuration::ParameterBase::id%',                                         -1, 2186744 FROM DUMMY UNION ALL
        SELECT 2012, 'Configuration',      'Delegated parameter value access',                 '%Configuration::DelegatingParameterValueManager::getValue%',                 -1, 2186744 FROM DUMMY UNION ALL
        SELECT 2100, 'SQLScript',          'SQLScript context preparation',                    '%sqlscript::exe::ExecutableImpl::prepareContextForMainPlan%',                -1, 2313619 FROM DUMMY UNION ALL
        SELECT 2200, 'Indexes',            'Inverted hash value resolution',                   '%TRexCommonObjects::HashCounterSet::resolveHashValues%',                     -1, 2160391 FROM DUMMY UNION ALL
        SELECT 2400, 'Table replication',  'Activation of asynchronous table replication',     '%Replication::ReplicationManager::turnOnAsyncReplicationReplica%',           -1, 2340450 FROM DUMMY UNION ALL
        SELECT 2500, 'Table optimization', 'Dictionary build via sorted add',                  '%AttributeEngine::ColumnCompressedBase::sortedAdd%',                         -1, 2057046 FROM DUMMY UNION ALL
        SELECT 2600, 'BW',                 'Changelog access for HANA-optimized DSO',          '%TrexCalculationEngine::CustomCpp::ceDsoChangelogSearchOp::doSearch%',       -1, 3308457 FROM DUMMY UNION ALL
        SELECT 2610, 'BW',                 'Hierarchy optimization',                           '%TRexAPI::TRexApiSearch::optimizeHierarchies%',                              -1, 2313619 FROM DUMMY UNION ALL
        SELECT 2700, 'Jobs',               'Job polling from JobExecutor queue',               '%Execution::JobExecutorNumaNode::pollJob%',                                  -1, 2222250 FROM DUMMY UNION ALL
        SELECT 2702, 'Jobs',               'Job stealing from other NUMA node',                '%Execution::JobExecutorImpl::getNextSpecificFromOtherNumaNodes%',            -1, 2470289 FROM DUMMY UNION ALL
        SELECT 2710, 'Jobs',               'JobExecutor work tracking',                        '%Diagnose::JobexLogRecorder::trackWrk%',                                     -1, 2222250 FROM DUMMY UNION ALL
        SELECT 2715, 'Jobs',               'Announcing of jobs',                               '%Execution::JobExecutorNumaNode::announceJobs%',                             -1, 2222250 FROM DUMMY UNION ALL
        SELECT 2800, 'Communication',      'TRex deserializer copy activity',                  '%TRexUtils::Deserializer::copy%',                                            -1, 3323266 FROM DUMMY UNION ALL
        SELECT 2810, 'Communication',      'TCP receiver activity',                            '%ptime::TcpReceiver::doWork%',                                                1, 2222200 FROM DUMMY
      ) C
    WHERE
      C.AREA LIKE T.CHECK_AREA AND
      'C' || LPAD(C.CHECK_ID, 4, '0') LIKE T.CHECK_ID AND
      T.FRAME_NAME LIKE C.FRAME_NAME AND
      ( C.MAX_FRAME_LEVEL = -1 OR T.FRAME_LEVEL <= C.MAX_FRAME_LEVEL )
    GROUP BY
      C.CHECK_ID,
      C.AREA,
      C.DESCRIPTION,
      C.MAX_FRAME_LEVEL,
      C.SAP_NOTE,
      T.HOST,
      T.PORT,
      T.TIMEFRAME_S,
      T.SAMPLE_INTERVAL_S,
      T.MIN_ACTIVE_THREADS,
      T.MIN_CRITICAL_THREADS
  )
  WHERE
  ( MIN_ACTIVE_THREADS = -1 OR ACT_THR >= MIN_ACTIVE_THREADS )
) T
WHERE
  COUNT IS NOT NULL
ORDER BY
  T.CHECK_ID,
  T.HOST,
  T.PORT
WITH HINT (IGNORE_PLAN_CACHE)