WITH 

/* 

[NAME]

- HANA_Threads_Callstacks_History_2.00.060+

[DESCRIPTION]

- Thread callstacks history

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- HOST_SERVICE_THREAD_CALLSTACKS available starting with SAP HANA 2.00.040
- SITE_ID in history tables available with SAP HANA >= 2.0 SPS 06

[VALID FOR]

- Revisions:              >= 2.00.060

[SQL COMMAND VERSION]

- 2018/11/14:  1.0 (initial version)
- 2018/12/04:  1.1 (shortcuts for BEGIN_TIME and END_TIME like 'C', 'E-S900' or 'MAX')
- 2020/04/29:  1.2 (ACTIVITY_TYPE included)
- 2020/07/18:  1.3 (STATEMENT_HASH included)
- 2021/11/19:  1.4 (ONLY_MEMORY_MANAGEMENT_CALLSTACKS included)
- 2022/01/28:  1.5 (ONLY_INDEX_HANDLE_CALLSTACKS included)
- 2022/05/27:  1.6 (dedicated 2.00.060+ version including SITE_ID for data source HISTORY)
- 2023/06/25:  1.7 (ONLY_DELTA_STORAGE_CALLSTACKS and ONLY_CHECK_TABLE_CONSISTENCY_CALLSTACKS included)
- 2024/01/14:  1.8 (EXCLUDE_CALLSTACK_COLLECTOR_CALLSTACKS included)

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

- SITE_ID

  System replication site ID (may only work for DATA_SOURCE = 'HISTORY')

  -1             --> No restriction related to site ID
  1              --> Site id 1

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

- THREAD_ID

  Thread identifier

  4567            --> Thread 4567
  -1              --> No thread identifier restriction

- STATEMENT_HASH      
 
  SQL statement hash (only available if consistent entry in thread samples exist)

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash 2e960d7535bf4134e2bd26b9d80bd4fa
  '%'                                --> No statement hash restriction

- CALLSTACK_PATTERN

  Callstack pattern

  '%comm::read%'  --> Only show thread all stacks that contain 'comm::read' at any place
  '%'             --> No restriction related to all stack details

- ACTIVITY_TYPE

  Callstack activity type

  'CPU'           --> Callstacks indicating CPU consumption
  'COMMUNICATION' --> Callstacks related to network communications
  'SYSCALL'       --> Callstacks related to system calls (e.g. lock waits)
  'WAIT'          --> Callstacks indicating wait states (includes COMMUNICATION and SYSCALL)
  '%'             --> No restriction related to activity type

- ONLY_MEMORY_MANAGEMENT_CALLSTACKS

  Possibility to filter for memory management related call stacks

  'X'             --> Display only threads with memory management related call stacks
  ' '             --> No restriction related to memory management related call stacks

- ONLY_INDEX_HANDLE_CALLSTACKS

  Possibility to filter for index handle related call stacks (index handle waiters are excluded)

  'X'             --> Display only call stacks that most likely have acquired an index handle
  ' '             --> No restriction related to index handle call stacks

- ONLY_DELTA_STORAGE_CALLSTACKS

  Possibility to filter delta storage related call stacks (delta storage waiters are excluded)

  'X'             --> Display only call stacks that most likely have acquired a delta storage lock like "BTree GuardContainer"
  ' '             --> No restriction related to delta storage call stacks

- ONLY_CHECK_TABLE_CONSISTENCY_CALLSTACKS

  Possibility to filter for CHECK_TABLE_CONSISTENCY related call stacks

  'X'             --> Display only call stacks that are (most of the time) related to CHECK_TABLE_CONSISTENCY
  ' '             --> No restriction related to CHECK_TABLE_CONSISTENCY callstacks

- EXCLUDE_CALLSTACK_COLLECTOR_CALLSTACKS

  Possibility to exclude threads that are involved in collecting call stacks

  'X'             --> Exclude call stacks being active with call stack collection
  ' '             --> No restriction related to threads being active with call stack collection

- MIN_THREAD_COUNT

  Minimum number of threads to be displayed

  5               --> Only display lines where the thread count (column COUNT) is at least 5
  -1              --> No restriction related to the thread count

- MAX_FRAME_LEVEL

  Maximum call stack frame level (smaller values can improve the performance)

  10              --> Only display the 10 deepest levels of each call stack
  -1              --> Display up to 48 levels of each call stack

- MAX_CALL_LEN

  Maximum length of call information in output (longer values are truncated)

  40              --> Limit length of call information to 40
  -1              --> No restriction related to call length

- SHORT_CALLS

  Possibility to activate a reduced output of call information

  'X'             --> Display only the main procedure
  ' '             --> Display complete call information

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'CALLSTACK'     --> Aggregation by callstack
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

  'TIME'          --> Sorting by sample time
  'COUNT'         --> Sorting by number of threads

[OUTPUT PARAMETERS]

- SAMPLE_TIME: Sample time
- ST:          System replication site ID
- HOST:        Host name
- PORT:        Port
- SERVICE:     Service name
- THREAD_ID:   Thread ID
- COUNT:       Number of sampled threads
- CALL_<n>:    Call information for level <n>

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|THREAD_TYPE  |THREAD_STATE            |THREADS|PERCENT|CALL_1                                                        |CALL_2                                                                                                  |CALL_3                                                                                                  |CALL_4                                                                                                 |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|SqlExecutor  |Running                 |     34|  49.27|UnifiedTable::DictionaryStorage::TemporaryValueBuffer::reserve|ltt::vector<int>::insertOverflow_                                                                       |AttributeEngine::idattribute::IdValuesBase<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|AttributeEngine::idattribute::IdAttribute<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|
|SqlExecutor  |Running                 |     20|  28.98|ltt::vector<int>::push_back                                   |AttributeEngine::idattribute::IdValuesBase<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|AttributeEngine::idattribute::IdAttribute<AttributeEngine::idattribute::IdBlockValues>::searchDocuments |AttributeEngine::AttributeApi::searchDocuments                                                         |
|SqlExecutor  |Running                 |      5|   7.24|AttributeEngine::idattribute::BlockHandle::uncompress         |AttributeEngine::idattribute::IdBlockValuesIterator::readNext                                           |AttributeEngine::idattribute::IdValuesBase<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|AttributeEngine::idattribute::IdAttribute<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|
|SqlExecutor  |Running                 |      3|   4.34|AttributeEngine::idattribute::IdBlockValuesIterator::readNext |AttributeEngine::idattribute::IdValuesBase<AttributeEngine::idattribute::IdBlockValues>::searchDocuments|AttributeEngine::idattribute::IdAttribute<AttributeEngine::idattribute::IdBlockValues>::searchDocuments |AttributeEngine::AttributeApi::searchDocuments                                                         |
|Request      |Running                 |      2|   2.89|syscall+0x15                                                  |Synchronization::Semaphore::timedWait                                                                   |TrexThreads::PoolThread::run                                                                            |TrexThreads::PoolThread::run                                                                           |
|SqlExecutor  |Semaphore Wait          |      1|   1.44|syscall+0x15                                                  |Synchronization::BinarySemaphore::timedWait                                                             |TrexSync::Event::waitFor                                                                                |TrexThreads::Thread::join                                                                              |
|SqlExecutor  |ConditionalVariable Wait|      1|   1.44|syscall+0x15                                                  |Synchronization::CondVariable::timedWait                                                                |ptime::Transaction::tryToDelegateThrAndTimedWait                                                        |TrexStore::SyncQueue::wait                                                                             |
|RemoteService|Network Read            |      1|   1.44|syscall+0x15                                                  |Synchronization::Semaphore::timedWait                                                                   |TrexThreads::PoolThread::run                                                                            |TrexThreads::PoolThread::run                                                                           |
|SqlExecutor  |Running                 |      1|   1.44|void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> > |void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> >                                           |void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> >                                           |void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> >                                          |
|SqlExecutor  |Running                 |      1|   1.44|void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> > |void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> >                                           |void ltt::impl::introsortLoopAux<int*, long, ltt::less<int> >                                           |void ltt::sort<int*, ltt::less<int> >                                                                  |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    SITE_ID,
    HOST,
    PORT,
    SERVICE_NAME,
    THREAD_ID,
    STATEMENT_HASH,
    CALLSTACK_PATTERN,
    ACTIVITY_TYPE,
    ONLY_MEMORY_MANAGEMENT_CALLSTACKS,
    ONLY_INDEX_HANDLE_CALLSTACKS,
    ONLY_DELTA_STORAGE_CALLSTACKS,
    ONLY_CHECK_TABLE_CONSISTENCY_CALLSTACKS,
    EXCLUDE_CALLSTACK_COLLECTOR_CALLSTACKS,
    MIN_THREAD_COUNT,
    MAX_FRAME_LEVEL,
    MAX_CALL_LEN,
    SHORT_CALLS,
    AGGREGATE_BY,
    MAP(TIME_AGGREGATE_BY,
      'NONE',        'YYYY/MM/DD HH24:MI:SS',
      'HOUR',        'YYYY/MM/DD HH24',
      'DAY',         'YYYY/MM/DD (DY)',
      'HOUR_OF_DAY', 'HH24',
      TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
    ORDER_BY
  FROM
  ( SELECT                     /* Modification section */
      'C-D7' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
      'C' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
      'SERVER' TIMEZONE,                              /* SERVER, UTC */
      -1 SITE_ID,
      '%' HOST,
      '%' PORT,
      '%' SERVICE_NAME,
      -1 THREAD_ID,
      '%' STATEMENT_HASH,                         /* taken from thread samples, missing if no thread sample information of the same second is available */
      '%' CALLSTACK_PATTERN,
      '%' ACTIVITY_TYPE,                          /* CPU, WAIT, SYSCALL, COMMUNICATION, % */
      ' ' ONLY_MEMORY_MANAGEMENT_CALLSTACKS,
      ' ' ONLY_INDEX_HANDLE_CALLSTACKS,
      ' ' ONLY_DELTA_STORAGE_CALLSTACKS,
      ' ' ONLY_CHECK_TABLE_CONSISTENCY_CALLSTACKS,
      'X' EXCLUDE_CALLSTACK_COLLECTOR_CALLSTACKS,
      -1 MIN_THREAD_COUNT,
      -1 MAX_FRAME_LEVEL,
      80 MAX_CALL_LEN,
      'X' SHORT_CALLS,
      'CALLSTACK' AGGREGATE_BY,     /* TIME, SITE_ID, HOST, PORT, SERVICE, THREAD_ID, CALLSTACK, HASH or comma separated combinations, NONE for no aggregation */
      'NONE' TIME_AGGREGATE_BY,     /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
      'TIME' ORDER_BY               /* TIME, CALLSTACK, COUNT */
    FROM
      DUMMY
  )
),
MEMORY_MANAGEMENT_METHODS AS
( SELECT '%AttributeEngine::fnJeReadIndexIndividual%' METHOD FROM DUMMY UNION ALL
  SELECT '%AttributeEngine::ValueArray::init%' FROM DUMMY UNION ALL
  SELECT '%__cxa_free_exception%' FROM DUMMY UNION ALL
  SELECT '%Diagnose::StatisticsData::addChild%' FROM DUMMY UNION ALL
  SELECT '%__GI___mremap%' FROM DUMMY UNION ALL
  SELECT '%IndexVectorAligned::get%' FROM DUMMY UNION ALL
  SELECT '%introsortLoopAux%' FROM DUMMY UNION ALL
  SELECT '%JoinEvaluator::TableAccess::jeReadIndex%' FROM DUMMY UNION ALL
  SELECT '%JoinEvaluator::TranslationTableImplVector::resizeVector%' FROM DUMMY UNION ALL
  SELECT '%ltt_adp::vector::push_back%' FROM DUMMY UNION ALL
  SELECT '%ltt::allocator::allocate%' FROM DUMMY UNION ALL
  SELECT '%ltt::allocate_raw_chunk%' FROM DUMMY UNION ALL
  SELECT '%ltt::impl::vectorFill%' FROM DUMMY UNION ALL
  SELECT '%ltt::impl::vectorResize%' FROM DUMMY UNION ALL
  SELECT '%ltt::string_base::string_base%' FROM DUMMY UNION ALL
  SELECT '%ltt::uninitialized_fill%' FROM DUMMY UNION ALL
  SELECT '%memcpy_impl%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::PrechargeBase::remapMemory%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::PrechargeBase::remapBlocksFromLocalFreeListWithoutUpdateValues%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::PrechargeBase::getMemory%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::Precharge::prepare%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::MemoryPool::reserveMemoryAndAllocateBigOrHugeBlock%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::MemoryPool::reserveMemoryAndAllocateHugeBlock%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::MemoryPool::allocateBigOrHugeBlock%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::MemoryPool::allocate%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::PoolAllocator::allocateNoThrowImpl%' FROM DUMMY UNION ALL
  SELECT '%MemoryManager::TempAllocator::allocateNoThrowImpl%' FROM DUMMY UNION ALL
  SELECT '%memset_impl%' FROM DUMMY UNION ALL
  SELECT '%mremap%' FROM DUMMY UNION ALL
  SELECT '%__open_nocancel%' FROM DUMMY UNION ALL
  SELECT '%partitionFind%' FROM DUMMY UNION ALL
  SELECT '%TRexCommonObjects::VariableMem::%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::BitVector::highestBitSet%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::convertToHigher%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::IndexVectorRef::mset%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::Mset::fill%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::MsetLoop::run%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::MsetWord::run%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::MultiColumnHashMap::init%' FROM DUMMY UNION ALL
  SELECT '%UnifiedTable::NBitDataAccessor64::msetValueArray::init%' FROM DUMMY
),
INDEX_HANDLE_METHODS AS
( SELECT '%CS::OC::OptimizeCompressionHelper::changeCompression%' METHOD FROM DUMMY UNION ALL
  SELECT '%CS::OC::OptimizeCompressionHelper::commitRowOrder%' FROM DUMMY UNION ALL
  SELECT '%Executor::PlanExecutor::doCalculateSingleThreaded%' FROM DUMMY UNION ALL
  SELECT '%hex::planex::ExecutablePlan::open%' FROM DUMMY UNION ALL
  SELECT '%ItabCreateGuard::~ItabCreateGuard %' FROM DUMMY UNION ALL
  SELECT '%JoinEvaluator::TableAccess::jeReadIndex%' FROM DUMMY UNION ALL
  SELECT '%*::mgetSearch%' FROM DUMMY UNION ALL
  SELECT '%ptime::MixedJoin_inverted_index::do_fetch%' FROM DUMMY UNION ALL
  SELECT '%qo3::OptimizerImpl::evaluate%' FROM DUMMY UNION ALL
  SELECT '%TRexAPI::PartSearchImpl::doSearch%' FROM DUMMY UNION ALL
  SELECT '%TRexAPI::SearchAPI::materializeItab%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::Parallel::Sorter%' FROM DUMMY
),
CHECK_TABLE_CONSISTENCY_METHODS AS
( SELECT '%AttributeEngine::LookupDocidsBvProbeJob%' METHOD FROM DUMMY UNION ALL
  SELECT '%AttributeEngine::MaxValueLengthDictScanJob%' FROM DUMMY UNION ALL
  SELECT '%CS::DDL::detail::UniqueMergerImpl::merge%' FROM DUMMY UNION ALL
  SELECT '%DictCheckJob::DictCheckJob%' FROM DUMMY UNION ALL
  SELECT '%TableConsistencyCheck::%' FROM DUMMY
),
CALLSTACKS AS
( SELECT
    C.SERVER_TIMESTAMP,
    C.SITE_ID,
    C.HOST,
    C.PORT,
    C.SERVICE_NAME,
    C.THREAD_ID,
    IFNULL(MAX(C.STATEMENT_HASH), 'n/a') STATEMENT_HASH,
    STRING_AGG(C.FRAME_NAME, '' ORDER BY C.FRAME_LEVEL) CALLSTACK_CONCAT,
    MAX(MAP(C.FRAME_LEVEL,  1, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_1,
    MAX(MAP(C.FRAME_LEVEL,  2, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_2,
    MAX(MAP(C.FRAME_LEVEL,  3, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_3,
    MAX(MAP(C.FRAME_LEVEL,  4, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_4,
    MAX(MAP(C.FRAME_LEVEL,  5, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_5,
    MAX(MAP(C.FRAME_LEVEL,  6, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_6,
    MAX(MAP(C.FRAME_LEVEL,  7, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_7,
    MAX(MAP(C.FRAME_LEVEL,  8, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_8,
    MAX(MAP(C.FRAME_LEVEL,  9, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_9,
    MAX(MAP(C.FRAME_LEVEL, 10, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_10,
    MAX(MAP(C.FRAME_LEVEL, 11, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_11,
    MAX(MAP(C.FRAME_LEVEL, 12, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_12,
    MAX(MAP(C.FRAME_LEVEL, 13, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_13,
    MAX(MAP(C.FRAME_LEVEL, 14, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_14,
    MAX(MAP(C.FRAME_LEVEL, 15, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_15,
    MAX(MAP(C.FRAME_LEVEL, 16, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_16,
    MAX(MAP(C.FRAME_LEVEL, 17, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_17,
    MAX(MAP(C.FRAME_LEVEL, 18, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_18,
    MAX(MAP(C.FRAME_LEVEL, 19, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_19,
    MAX(MAP(C.FRAME_LEVEL, 20, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_20,
    MAX(MAP(C.FRAME_LEVEL, 21, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_21,
    MAX(MAP(C.FRAME_LEVEL, 22, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_22,
    MAX(MAP(C.FRAME_LEVEL, 23, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_23,
    MAX(MAP(C.FRAME_LEVEL, 24, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_24,
    MAX(MAP(C.FRAME_LEVEL, 25, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_25,
    MAX(MAP(C.FRAME_LEVEL, 26, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_26,
    MAX(MAP(C.FRAME_LEVEL, 27, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_27,
    MAX(MAP(C.FRAME_LEVEL, 28, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_28,
    MAX(MAP(C.FRAME_LEVEL, 29, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_29,
    MAX(MAP(C.FRAME_LEVEL, 30, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_30,
    MAX(MAP(C.FRAME_LEVEL, 31, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_31,
    MAX(MAP(C.FRAME_LEVEL, 32, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_32,
    MAX(MAP(C.FRAME_LEVEL, 33, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_33,
    MAX(MAP(C.FRAME_LEVEL, 34, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_34,
    MAX(MAP(C.FRAME_LEVEL, 35, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_35,
    MAX(MAP(C.FRAME_LEVEL, 36, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_36,
    MAX(MAP(C.FRAME_LEVEL, 37, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_37,
    MAX(MAP(C.FRAME_LEVEL, 38, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_38,
    MAX(MAP(C.FRAME_LEVEL, 39, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_39,
    MAX(MAP(C.FRAME_LEVEL, 40, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_40,
    MAX(MAP(C.FRAME_LEVEL, 41, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_41,
    MAX(MAP(C.FRAME_LEVEL, 42, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_42,
    MAX(MAP(C.FRAME_LEVEL, 43, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_43,
    MAX(MAP(C.FRAME_LEVEL, 44, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_44,
    MAX(MAP(C.FRAME_LEVEL, 45, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_45,
    MAX(MAP(C.FRAME_LEVEL, 46, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_46,
    MAX(MAP(C.FRAME_LEVEL, 47, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_47,
    MAX(MAP(C.FRAME_LEVEL, 48, MAP(BI.SHORT_CALLS, 'X', C.FRAME_SHORT, C.FRAME_NAME), '')) CALL_48
  FROM
    BASIS_INFO BI,
  ( SELECT
      SERVER_TIMESTAMP,
      SITE_ID,
      HOST,
      PORT,
      SERVICE_NAME,
      THREAD_ID,
      STATEMENT_HASH,
      FRAME_LEVEL,
      SUBSTR(F, 1, LEAST(MAP(INSTR(F, '('), 0, 999, INSTR(F, '(')), MAP(INSTR(F, '+0x'), 0, 999, INSTR(F, '+0x'))) - 1) FRAME_SHORT,
      FRAME_NAME
    FROM
    ( SELECT
        TC.SERVER_TIMESTAMP,
        TC.SITE_ID,
        TC.HOST,
        TC.PORT,
        TC.SERVICE_NAME,
        TC.THREAD_ID,
        TS.STATEMENT_HASH,
        TC.FRAME_LEVEL,
        REPLACE(REPLACE(TC.FRAME_NAME, '(anonymous namespace)::', ''), '> >', '>') F,
        TC.FRAME_NAME
      FROM
        BASIS_INFO BI,
        _SYS_STATISTICS.HOST_SERVICE_THREAD_CALLSTACKS TC LEFT OUTER JOIN
      ( SELECT
          TIMESTAMP,
          CURRENT_SITE_ID() SITE_ID,
          HOST,
          PORT,
          THREAD_ID,
          STATEMENT_HASH
        FROM
          M_SERVICE_THREAD_SAMPLES
        UNION
        SELECT
          TIMESTAMP,
          SITE_ID,
          HOST,
          PORT,
          THREAD_ID,
          STATEMENT_HASH
        FROM
          _SYS_STATISTICS.HOST_SERVICE_THREAD_SAMPLES
      ) TS ON
        TC.SITE_ID = TS.SITE_ID AND
        TC.HOST = TS.HOST AND
        TC.PORT = TS.PORT AND
        TC.THREAD_ID = TS.THREAD_ID AND
        TO_VARCHAR(TC.SERVER_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') = TO_VARCHAR(TS.TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS')
      WHERE
        ( BI.SITE_ID = -1 OR ( BI.SITE_ID = 0 AND TC.SITE_ID IN (-1, 0) ) OR TC.SITE_ID = BI.SITE_ID ) AND
        TC.HOST LIKE BI.HOST AND  
        TO_VARCHAR(TC.PORT) LIKE BI.PORT AND
        TC.SERVICE_NAME LIKE BI.SERVICE_NAME AND
        ( BI.THREAD_ID = -1 OR TC.THREAD_ID = BI.THREAD_ID ) AND
        CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(TC.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE TC.SERVER_TIMESTAMP END BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
        ( BI.MAX_FRAME_LEVEL = -1 OR TC.FRAME_LEVEL <= BI.MAX_FRAME_LEVEL )
    )
  ) C
  WHERE
    BI.STATEMENT_HASH = '%' OR C.STATEMENT_HASH = BI.STATEMENT_HASH
  GROUP BY
    C.SERVER_TIMESTAMP,
    C.SITE_ID,
    C.HOST,
    C.PORT,
    C.SERVICE_NAME,
    C.THREAD_ID
)
SELECT
  START_TIME SAMPLE_TIME,
  IFNULL(LPAD(SITE_ID, 2), '') ST,
  HOST,
  PORT,
  SERVICE_NAME,
  THREAD_ID,
  STATEMENT_HASH,
  LPAD(COUNT, 5) COUNT,
  CALL_1,
  CALL_2,
  CALL_3,
  CALL_4,
  CALL_5,
  CALL_6,
  CALL_7,
  CALL_8,
  CALL_9,
  CALL_10,
  CALL_11,
  CALL_12,
  CALL_13,
  CALL_14,
  CALL_15,
  CALL_16,
  CALL_17,
  CALL_18,
  CALL_19,
  CALL_20,
  CALL_21,
  CALL_22,
  CALL_23,
  CALL_24,
  CALL_25,
  CALL_26,
  CALL_27,
  CALL_28,
  CALL_29,
  CALL_30,
  CALL_31,
  CALL_32,
  CALL_33,
  CALL_34,
  CALL_35,
  CALL_36,
  CALL_37,
  CALL_38,
  CALL_39,
  CALL_40,
  CALL_41,
  CALL_42,
  CALL_43,
  CALL_44,
  CALL_45,
  CALL_46,
  CALL_47,
  CALL_48
FROM
( SELECT
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(TC.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE TC.SERVER_TIMESTAMP END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(TC.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE TC.SERVER_TIMESTAMP END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END START_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID')   != 0 THEN TO_VARCHAR(TC.SITE_ID)   ELSE MAP(BI.SITE_ID,         -1, 'any', TO_VARCHAR(BI.SITE_ID))   END SITE_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')      != 0 THEN TC.HOST                  ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)                  END HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')      != 0 THEN TO_VARCHAR(TC.PORT)      ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)                  END PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')   != 0 THEN TC.SERVICE_NAME          ELSE MAP(BI.SERVICE_NAME,   '%', 'any', BI.SERVICE_NAME)          END SERVICE_NAME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID') != 0 THEN TO_VARCHAR(TC.THREAD_ID) ELSE MAP(BI.THREAD_ID,      -1,  'any', TO_VARCHAR(BI.THREAD_ID)) END THREAD_ID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')      != 0 THEN TC.STATEMENT_HASH        ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)        END STATEMENT_HASH,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_1,  SUBSTR(TC.CALL_1,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_1,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_2,  SUBSTR(TC.CALL_2,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_2,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_3,  SUBSTR(TC.CALL_3,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_3,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_4,  SUBSTR(TC.CALL_4,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_4,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_5,  SUBSTR(TC.CALL_5,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_5,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_6,  SUBSTR(TC.CALL_6,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_6,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_7,  SUBSTR(TC.CALL_7,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_7,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_8,  SUBSTR(TC.CALL_8,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_8,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_9,  SUBSTR(TC.CALL_9,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_9,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_10, SUBSTR(TC.CALL_10, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_10,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_11, SUBSTR(TC.CALL_11, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_11,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_12, SUBSTR(TC.CALL_12, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_12,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_13, SUBSTR(TC.CALL_13, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_13,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_14, SUBSTR(TC.CALL_14, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_14,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_15, SUBSTR(TC.CALL_15, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_15,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_16, SUBSTR(TC.CALL_16, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_16,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_17, SUBSTR(TC.CALL_17, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_17,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_18, SUBSTR(TC.CALL_18, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_18,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_19, SUBSTR(TC.CALL_19, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_19,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_20, SUBSTR(TC.CALL_20, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_20,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_21, SUBSTR(TC.CALL_21, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_21,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_22, SUBSTR(TC.CALL_22, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_22,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_23, SUBSTR(TC.CALL_23, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_23,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_24, SUBSTR(TC.CALL_24, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_24,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_25, SUBSTR(TC.CALL_25, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_25,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_26, SUBSTR(TC.CALL_26, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_26,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_27, SUBSTR(TC.CALL_27, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_27,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_28, SUBSTR(TC.CALL_28, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_28,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_29, SUBSTR(TC.CALL_29, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_29,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_30, SUBSTR(TC.CALL_30, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_30,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_31, SUBSTR(TC.CALL_31, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_31,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_32, SUBSTR(TC.CALL_32, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_32,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_33, SUBSTR(TC.CALL_33, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_33,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_34, SUBSTR(TC.CALL_34, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_34,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_35, SUBSTR(TC.CALL_35, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_35,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_36, SUBSTR(TC.CALL_36, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_36,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_37, SUBSTR(TC.CALL_37, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_37,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_38, SUBSTR(TC.CALL_38, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_38,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_39, SUBSTR(TC.CALL_39, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_39,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_40, SUBSTR(TC.CALL_40, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_40,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_41, SUBSTR(TC.CALL_41, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_41,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_42, SUBSTR(TC.CALL_42, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_42,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_43, SUBSTR(TC.CALL_43, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_43,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_44, SUBSTR(TC.CALL_44, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_44,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_45, SUBSTR(TC.CALL_45, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_45,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_46, SUBSTR(TC.CALL_46, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_46,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_47, SUBSTR(TC.CALL_47, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_47,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_48, SUBSTR(TC.CALL_48, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_48,
    COUNT(*) COUNT,
    BI.MIN_THREAD_COUNT,
    BI.ORDER_BY
  FROM
    BASIS_INFO BI,
    CALLSTACKS TC
  WHERE
    ( BI.THREAD_ID = -1 OR BI.THREAD_ID = TC.THREAD_ID ) AND
    UPPER(TC.CALLSTACK_CONCAT) LIKE UPPER(BI.CALLSTACK_PATTERN) AND
    ( BI.ACTIVITY_TYPE = '%' OR
      BI.ACTIVITY_TYPE IN ( 'SYSCALL', 'WAIT' ) AND 
      ( SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) IN ( 'do_fute', 'io_queu', '__nanos', '__pthre', 'syscall' ) OR SUBSTR(TC.CALLSTACK_CONCAT, 1, 17) = '__clock_nanosleep' ) OR
      BI.ACTIVITY_TYPE IN ( 'COMMUNICATION', 'WAIT' ) AND 
      ( SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) IN ( '__GI_ep', '__GI_po', '__epoll', '__libc_', '__poll_', '__read_', '__write' ) OR
        TC.CALLSTACK_CONCAT LIKE '.annobin_fts.c_end%' OR
        TC.CALLSTACK_CONCAT LIKE '.annobin_recv.c%' OR
        TC.CALLSTACK_CONCAT LIKE '.annobin_send.c%'
      ) OR
      BI.ACTIVITY_TYPE = 'CPU' AND 
        SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) NOT IN ( 'do_fute', 'io_queu', '__nanos', '__pthre', 'syscall', '__GI_ep', '__GI_po', '__epoll', '__libc_', '__poll_', '__read_', '__write' ) AND
        SUBSTR(TC.CALLSTACK_CONCAT, 1, 17) != '__clock_nanosleep' AND
        TC.CALLSTACK_CONCAT NOT LIKE '__GI___poll%' AND
        TC.CALLSTACK_CONCAT NOT LIKE '.annobin_fts.c_end%' AND
        TC.CALLSTACK_CONCAT NOT LIKE '.annobin_recv.c%' AND
        TC.CALLSTACK_CONCAT NOT LIKE '.annobin_send.c%'
    )  AND
    ( BI.ONLY_MEMORY_MANAGEMENT_CALLSTACKS = ' ' OR EXISTS ( SELECT * FROM MEMORY_MANAGEMENT_METHODS MMTC WHERE TC.CALLSTACK_CONCAT LIKE MMTC.METHOD ) ) AND
    ( BI.ONLY_INDEX_HANDLE_CALLSTACKS = ' ' OR EXISTS ( SELECT * FROM INDEX_HANDLE_METHODS IHTC WHERE TC.CALLSTACK_CONCAT LIKE IHTC.METHOD ) AND TC.CALLSTACK_CONCAT NOT LIKE '%TRexConfig::IndexHandle::acquire%' ) AND
    ( BI.ONLY_DELTA_STORAGE_CALLSTACKS = ' ' OR TC.CALLSTACK_CONCAT LIKE '%BTreeAttribute%' AND TC.CALLSTACK_CONCAT NOT LIKE 'syscall%' AND
      TC.CALLSTACK_CONCAT NOT LIKE '%Execution::sleep%' ) AND
    ( BI.ONLY_CHECK_TABLE_CONSISTENCY_CALLSTACKS = ' ' OR EXISTS ( SELECT * FROM CHECK_TABLE_CONSISTENCY_METHODS CTCM WHERE TC.CALLSTACK_CONCAT LIKE CTCM.METHOD ) ) AND
    ( BI.EXCLUDE_CALLSTACK_COLLECTOR_CALLSTACKS = ' ' OR
      ( TC.CALLSTACK_CONCAT NOT LIKE 'Diagnose::ExternalCommandHandlerImpl::unsafeExecute%' AND
        TC.CALLSTACK_CONCAT NOT LIKE '%ptime::ServiceCallstackMonitor%'
      )
    )
  GROUP BY
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(TC.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE TC.SERVER_TIMESTAMP END) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(TC.SERVER_TIMESTAMP, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE TC.SERVER_TIMESTAMP END, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SITE_ID')   != 0 THEN TO_VARCHAR(TC.SITE_ID)   ELSE MAP(BI.SITE_ID,         -1, 'any', TO_VARCHAR(BI.SITE_ID))   END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')      != 0 THEN TC.HOST                  ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)                  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')      != 0 THEN TO_VARCHAR(TC.PORT)      ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)                  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')   != 0 THEN TC.SERVICE_NAME          ELSE MAP(BI.SERVICE_NAME,   '%', 'any', BI.SERVICE_NAME)          END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID') != 0 THEN TO_VARCHAR(TC.THREAD_ID) ELSE MAP(BI.THREAD_ID,      -1,  'any', TO_VARCHAR(BI.THREAD_ID)) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')      != 0 THEN TC.STATEMENT_HASH        ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)        END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_1,  SUBSTR(TC.CALL_1,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_2,  SUBSTR(TC.CALL_2,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_3,  SUBSTR(TC.CALL_3,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_4,  SUBSTR(TC.CALL_4,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_5,  SUBSTR(TC.CALL_5,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_6,  SUBSTR(TC.CALL_6,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_7,  SUBSTR(TC.CALL_7,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_8,  SUBSTR(TC.CALL_8,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_9,  SUBSTR(TC.CALL_9,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_10, SUBSTR(TC.CALL_10, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_11, SUBSTR(TC.CALL_11, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_12, SUBSTR(TC.CALL_12, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_13, SUBSTR(TC.CALL_13, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_14, SUBSTR(TC.CALL_14, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_15, SUBSTR(TC.CALL_15, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_16, SUBSTR(TC.CALL_16, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_17, SUBSTR(TC.CALL_17, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_18, SUBSTR(TC.CALL_18, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_19, SUBSTR(TC.CALL_19, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_20, SUBSTR(TC.CALL_20, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_21, SUBSTR(TC.CALL_21, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_22, SUBSTR(TC.CALL_22, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_23, SUBSTR(TC.CALL_23, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_24, SUBSTR(TC.CALL_24, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_25, SUBSTR(TC.CALL_25, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_26, SUBSTR(TC.CALL_26, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_27, SUBSTR(TC.CALL_27, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_28, SUBSTR(TC.CALL_28, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_29, SUBSTR(TC.CALL_29, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_30, SUBSTR(TC.CALL_30, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_31, SUBSTR(TC.CALL_31, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_32, SUBSTR(TC.CALL_32, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_33, SUBSTR(TC.CALL_33, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_34, SUBSTR(TC.CALL_34, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_35, SUBSTR(TC.CALL_35, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_36, SUBSTR(TC.CALL_36, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_37, SUBSTR(TC.CALL_37, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_38, SUBSTR(TC.CALL_38, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_39, SUBSTR(TC.CALL_39, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_40, SUBSTR(TC.CALL_40, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_41, SUBSTR(TC.CALL_41, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_42, SUBSTR(TC.CALL_42, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_43, SUBSTR(TC.CALL_43, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_44, SUBSTR(TC.CALL_44, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_45, SUBSTR(TC.CALL_45, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_46, SUBSTR(TC.CALL_46, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_47, SUBSTR(TC.CALL_47, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK') != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_48, SUBSTR(TC.CALL_48, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
    BI.MIN_THREAD_COUNT,
    BI.ORDER_BY
)
WHERE
  ( MIN_THREAD_COUNT = -1 OR COUNT >= MIN_THREAD_COUNT )
ORDER BY
  MAP(ORDER_BY, 'TIME', START_TIME) DESC,
  MAP(ORDER_BY, 'CALLSTACK', CALL_1 || CALL_2 || CALL_3 || CALL_4 || CALL_5),
  COUNT DESC
