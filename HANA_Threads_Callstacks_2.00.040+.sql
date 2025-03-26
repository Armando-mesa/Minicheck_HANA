WITH 

/* 

[NAME]

- HANA_Threads_Callstacks_2.00.040+

[DESCRIPTION]

- Thread callstacks

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_SERVICE_THREADS.STATEMENT_HASH available as of Rev. 1.00.100
- ONLY_ACTIVE_CALLSTACKS and ONLY_ACTIVE_THREADS may deliver different results because M_SERVICE_THREADS and M_SERVICE_THREAD_CALLSTACKS are not joined consistently and
  so an active thread can show up with an inactive call stack and vice versa
- M_SERVICE_THREAD_CALLSTACKS.IS_ACTIVE available starting 2.00.040
- WITH clause does not work with older DBACOCKPIT transactions before SAP BASIS 7.02 SP16 / 7.30 SP12 / 7.31 SP12 / SAP_BASIS 7.40 SP07 (empty result returned) 

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2015/03/24:  1.0 (initial version)
- 2015/09/19:  1.1 (CONN_ID included)
- 2016/02/23:  1.2 (dedicated Rev100+ version)
- 2017/02/02:  1.3 (CALLSTACK_CONCAT included)
- 2017/08/01:  1.4 (EXCLUDE_PHANTOM_THREADS included)
- 2017/12/15:  1.5 (CALLSTACK_ACTIVITY included)
- 2019/07/27:  1.6 (dedicated 2.00.040+ version including direct evaluation of M_SERVICE_THREAD_CALLSTACKS.IS_ACTIVE)
- 2020/04/29:  1.7 (ACTIVITY_TYPE included)
- 2022/01/28:  1.8 (ONLY_INDEX_HANDLE_CALLSTACKS included)
- 2022/03/09:  1.9 (EXCLUDE_LEADING_LINES included)

[INVOLVED TABLES]

- M_SERVICE_THREAD_CALLSTACKS
- M_SERVICE_THREADS

[INPUT PARAMETERS]

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

- MIN_DURATION_MS

  Minimum duration of current thread activity (ms)

  1000            --> Only display call stack of threads with a current duration of at least 1000 ms
  -1              --> No restriction related to thread activity duration

- STATEMENT_HASH      
 
  Hash of SQL statement to be analyzed

  '2e960d7535bf4134e2bd26b9d80bd4fa' --> SQL statement with hash '2e960d7535bf4134e2bd26b9d80bd4fa'
  '%'                                --> No statement hash restriction (only possible if hash is not mandatory)

- THREAD_TYPE

  Type of thread (e.g. 'SqlExecutor', 'JobWorker' or 'MergedogMonitor')

  'SqlExecutor'   --> Threads with type 'SqlExecutor'
  '%'             --> No thread type restriction

- THREAD_STATE

  State of thread (e.g. e.g. 'Running', 'Network Read' or 'Semaphore Wait')

  'Running'       --> Threads with state 'Running'
  '%'             --> No thread state restriction

- THREAD_METHOD

  Thread method

  'aggregate'     --> Threads with method 'aggregate'
  '%'             --> No thread state restriction

- ACTIVITY

  Detailed callstack activity

  'Prepare'       --> Callstacks with prepare related activities
  '%'             --> No restriction 

- THREAD_DETAIL

  Thread detail information (e.g. SQL text)

  '%insert%'      --> Only thread details containing 'insert'
  '%'             --> No thread detail restriction

- LOCK_NAME

  Lock wait name

  '%Mutex%'       --> Restrict result to lock names containing "Mutex"
  '%'             --> No restriction related to lock name

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

- MAX_CALL_LEN

  Maximum length of call information in output (longer values are truncated)

  40              --> Limit length of call information to 40
  -1              --> No restriction related to call length

- ONLY_ACTIVE_THREADS

  Possibility to restrict output to active threads

  'X'             --> Only call stacks for active threads are shown
  ' '             --> No restriction in terms of call stacks

- ONLY_ACTIVE_CALLSTACKS

  Possibility to restrict output to active call stacks

  'X'             --> Only call stacks indicating current activity are shown
  ' '             --> No restriction in terms of call stack activities

- ONLY_INDEX_HANDLE_CALLSTACKS

  Possibility to filter for index handle related call stacks (index handle waiters are excluded)

  'X'             --> Display only call stacks that most likely have acquired an index handle
  ' '             --> No restriction related to index handle call stacks

- IGNORE_OWN_THREADS

  Possibility to exclude threads related to own connection

  'X'             --> Only show threads not belonging to own connection
  ' '             --> Show all threads

- IGNORE_IDLE_THREADS

  Possibility to exclude idle threads (waiting for idle events like 'Job Exec Waiting')

  'X'             --> Only show busy threads
  ' '             --> Show all threads

- IGNORE_SYSCALL_THREADS

  Possibility to exclude threads currently executing a system call (e.g. linked to a lock wait)

  'X'             --> Only show threads not executing a system call
  ' '             --> Show all threads

- EXCLUDE_PHANTOM_THREADS

  Possibility to exclude idle threads that are shown as "active" due to SAP HANA bugs

  'X'             --> Do not show idle threads that are shown as active threads
  ' '             --> No restriction of displayed threads

- EXCLUDE_LEADING_LINES

  Possibility to exclude the leading lines of the output that are not directly related to the call stacks

  'X'             --> Skip leading lines and start with the call stack lines
  ' '             --> Display also the leading lines

- SHORT_CALLS

  Possibility to activate a reduced output of call information

  'X'             --> Display only the main procedure
  ' '             --> Display complete call information

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'CALLSTACK'     --> Aggregation by callstack
  'HOST, PORT'    --> Aggregation by host and port
  'NONE'          --> No aggregation

[OUTPUT PARAMETERS]

- HOST:               Host name
- PORT:               Port
- SERVICE:            Service name
- THREAD_ID:          Thread ID
- DURATION_MS:        Duration of current thread activity (ms), average value in case of aggregation
- STATEMENT_HASH:     Statement hash
- THREAD_STATE:       Thread state
- THREAD_TYPE:        Thread type
- CALLSTACK_ACTIVITY: Thread activity derived from call stack
- THREAD_METHOD:      Thread method
- THREAD_DETAIL:      Thread detail (e.g. SQL text)
- LOCK_NAME:          Lock wait name
- COUNT:              Number of threads (1 if no aggregation is done)
- PERCENT:            Percentage of threads compared to overall number of threads
- CALL_<n>:           Call information for level <n>

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
( SELECT                     /* Modification section */
    '%' HOST,
    '%' PORT,
    '%' SERVICE_NAME,
    -1 CONN_ID,
    -1 THREAD_ID,
    '%' STATEMENT_HASH,
    '%' THREAD_TYPE,
    '%' THREAD_STATE,
    '%' ACTIVITY,
    '%' THREAD_METHOD,
    '%' THREAD_DETAIL,
    '%' LOCK_NAME,
    '%' CALLSTACK_PATTERN,
    '%' ACTIVITY_TYPE,                                 /* CPU, WAIT, SYSCALL, COMMUNICATION, % */
    -1 MIN_DURATION_MS,
    80 MAX_CALL_LEN,
    ' ' ONLY_ACTIVE_THREADS,
    'X' ONLY_ACTIVE_CALLSTACKS,
    ' ' ONLY_INDEX_HANDLE_CALLSTACKS,
    'X' IGNORE_OWN_THREADS,
    ' ' IGNORE_IDLE_THREADS,
    ' ' IGNORE_SYSCALL_THREADS,
    'X' EXCLUDE_PHANTOM_THREADS,
    ' ' EXCLUDE_LEADING_LINES,
    'X' SHORT_CALLS,
    'ACTIVITY, CALLSTACK' AGGREGATE_BY     /* HOST, PORT, SERVICE, CONN_ID, THREAD_ID, HASH, ACTIVITY, THREAD_STATE, THREAD_TYPE, THREAD_METHOD, THREAD_DETAIL, LOCK_NAME, CALLSTACK or comma separated combinations, NONE for no aggregation */
  FROM
    DUMMY
),
CALLSTACKS AS
( SELECT
    C.HOST,
    C.PORT,
    C.THREAD_ID,
    C.IS_ACTIVE,
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
      HOST,
      PORT,
      THREAD_ID,
      IS_ACTIVE,
      FRAME_LEVEL,
      SUBSTR(F, 1, LEAST(MAP(INSTR(F, '('), 0, 999, INSTR(F, '(')), MAP(INSTR(F, '+0x'), 0, 999, INSTR(F, '+0x'))) - 1) FRAME_SHORT,
      FRAME_NAME
    FROM
    ( SELECT
        HOST,
        PORT,
        THREAD_ID,
        IS_ACTIVE,
        FRAME_LEVEL,
        REPLACE(REPLACE(FRAME_NAME, '(anonymous namespace)::', ''), '> >', '>') F,
        FRAME_NAME
      FROM
        M_SERVICE_THREAD_CALLSTACKS
    )
  ) C
  GROUP BY
    C.HOST,
    C.PORT,
    C.THREAD_ID,
    C.IS_ACTIVE
),
INDEX_HANDLE_METHODS AS
( SELECT '%CS::OC::OptimizeCompressionHelper::changeCompression%' METHOD FROM DUMMY UNION ALL
  SELECT '%CS::OC::OptimizeCompressionHelper::commitRowOrder%' FROM DUMMY UNION ALL
  SELECT '%Executor::PlanExecutor::doCalculateSingleThreaded%' FROM DUMMY UNION ALL
  SELECT '%hex::planex::ExecutablePlan::open%' FROM DUMMY UNION ALL
  SELECT '%ItabCreateGuard::~ItabCreateGuard%' FROM DUMMY UNION ALL
  SELECT '%JoinEvaluator::TableAccess::jeReadIndex%' FROM DUMMY UNION ALL
  SELECT '%*::mgetSearch%' FROM DUMMY UNION ALL
  SELECT '%ptime::MixedJoin_inverted_index::do_fetch%' FROM DUMMY UNION ALL
  SELECT '%qo3::OptimizerImpl::evaluate%' FROM DUMMY UNION ALL
  SELECT '%TRexAPI::PartSearchImpl::doSearch%' FROM DUMMY UNION ALL
  SELECT '%TRexAPI::SearchAPI::materializeItab%' FROM DUMMY UNION ALL
  SELECT '%TRexUtils::Parallel::Sorter%' FROM DUMMY
)
SELECT
  HOST,
  PORT,
  SERVICE,
  CONN_ID,
  THREAD_ID,
  DURATION_MS,
  STATEMENT_HASH,
  THREAD_STATE,
  THREAD_TYPE,
  CALLSTACK_ACTIVITY,
  THREAD_METHOD,
  THREAD_DETAIL,
  LOCK_NAME,
  COUNT,
  PERCENT,
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
  CALL_16
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
    TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD') HOST,
    TO_VARCHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS') PORT,
    '' SERVICE,
    '' CONN_ID,
    '' THREAD_ID,
    '' DURATION_MS,
    '' STATEMENT_HASH,
    '' THREAD_STATE,
    '' THREAD_TYPE,
    '' CALLSTACK_ACTIVITY,
    '' THREAD_METHOD,
    '' THREAD_DETAIL,
    '' LOCK_NAME,
    '' COUNT,
    '' PERCENT,
    '' CALL_1,
    '' CALL_2,
    '' CALL_3,
    '' CALL_4,
    '' CALL_5,
    '' CALL_6,
    '' CALL_7,
    '' CALL_8,
    '' CALL_9,
    '' CALL_10,
    '' CALL_11,
    '' CALL_12,
    '' CALL_13,
    '' CALL_14,
    '' CALL_15,
    '' CALL_16,
    '' CALL_17,
    '' CALL_18,
    '' CALL_19,
    '' CALL_20,
    '' CALL_21,
    '' CALL_22,
    '' CALL_23,
    '' CALL_24,
    '' CALL_25,
    '' CALL_26,
    '' CALL_27,
    '' CALL_28,
    '' CALL_29,
    '' CALL_30,
    '' CALL_31,
    '' CALL_32,
    '' CALL_33,
    '' CALL_34,
    '' CALL_35,
    '' CALL_36,
    '' CALL_37,
    '' CALL_38,
    '' CALL_39,
    '' CALL_40,
    '' CALL_41,
    '' CALL_42,
    '' CALL_43,
    '' CALL_44,
    '' CALL_45,
    '' CALL_46,
    '' CALL_47,
    '' CALL_48,
    10 LINE_NO
  FROM 
    BASIS_INFO
  WHERE
    EXCLUDE_LEADING_LINES = ' '
  UNION ALL
  SELECT
    '' HOST,
    '' PORT,
    '' SERVICE,
    '' CONN_ID,
    '' THREAD_ID,
    '' DURATION_MS,
    '' STATEMENT_HASH,
    '' THREAD_STATE,
    '' THREAD_TYPE,
    '' CALLSTACK_ACTIVITY,
    '' THREAD_METHOD,
    '' THREAD_DETAIL,
    '' LOCK_NAME,
    '' NUM,
    '' PERCENT,
    '' CALL_1,
    '' CALL_2,
    '' CALL_3,
    '' CALL_4,
    '' CALL_5,
    '' CALL_6,
    '' CALL_7,
    '' CALL_8,
    '' CALL_9,
    '' CALL_10,
    '' CALL_11,
    '' CALL_12,
    '' CALL_13,
    '' CALL_14,
    '' CALL_15,
    '' CALL_16,
    '' CALL_17,
    '' CALL_18,
    '' CALL_19,
    '' CALL_20,
    '' CALL_21,
    '' CALL_22,
    '' CALL_23,
    '' CALL_24,
    '' CALL_25,
    '' CALL_26,
    '' CALL_27,
    '' CALL_28,
    '' CALL_29,
    '' CALL_30,
    '' CALL_31,
    '' CALL_32,
    '' CALL_33,
    '' CALL_34,
    '' CALL_35,
    '' CALL_36,
    '' CALL_37,
    '' CALL_38,
    '' CALL_39,
    '' CALL_40,
    '' CALL_41,
    '' CALL_42,
    '' CALL_43,
    '' CALL_44,
    '' CALL_45,
    '' CALL_46,
    '' CALL_47,
    '' CALL_48,
    20 LINE_NO
  FROM 
    BASIS_INFO
  WHERE
    EXCLUDE_LEADING_LINES = ' '
  UNION ALL
  SELECT
    HOST,
    PORT,
    SERVICE_NAME SERVICE,
    CONN_ID,
    THREAD_ID,
    LPAD(TO_DECIMAL(DURATION_MS, 10, 2), 11) DURATION_MS,
    STATEMENT_HASH,
    THREAD_STATE,
    THREAD_TYPE,
    CALLSTACK_ACTIVITY,
    THREAD_METHOD,
    THREAD_DETAIL,
    LOCK_NAME,
    LPAD(THREADS, 5) COUNT,
    LPAD(TO_DECIMAL(PERCENT, 10, 2), 7) PERCENT,
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
    CALL_48,
    30 + ROW_NUMBER () OVER (ORDER BY THREADS DESC, HOST, PORT, CONN_ID, THREAD_ID, CALL_1, CALL_2) LINE_NO
  FROM
  ( SELECT
      HOST,
      PORT,
      SERVICE_NAME,
      CONN_ID,
      THREAD_ID,
      DURATION_MS,
      STATEMENT_HASH,
      THREAD_STATE,
      THREAD_TYPE,
      THREAD_METHOD,
      THREAD_DETAIL,
      LOCK_NAME,
      SUM(THREADS) THREADS,
      SUM(PERCENT) PERCENT,
      CALLSTACK_ACTIVITY,
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
      CALL_48,
      IGNORE_SYSCALL_THREADS
    FROM
    ( SELECT
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')          != 0 THEN T.HOST                         ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)                  END HOST,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')          != 0 THEN TO_VARCHAR(T.PORT)             ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)                  END PORT,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')       != 0 THEN S.SERVICE_NAME                 ELSE MAP(BI.SERVICE_NAME,   '%', 'any', BI.SERVICE_NAME)          END SERVICE_NAME,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')       != 0 THEN TO_VARCHAR(T.CONNECTION_ID)    ELSE MAP(BI.CONN_ID,        -1,  'any', TO_VARCHAR(BI.CONN_ID))   END CONN_ID,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')     != 0 THEN TO_VARCHAR(T.THREAD_ID)        ELSE MAP(BI.THREAD_ID,      -1,  'any', TO_VARCHAR(BI.THREAD_ID)) END THREAD_ID,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')          != 0 THEN T.STATEMENT_HASH               ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)        END STATEMENT_HASH,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')  != 0 THEN T.THREAD_STATE                 ELSE MAP(BI.THREAD_STATE,   '%', 'any', BI.THREAD_STATE)          END THREAD_STATE,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')   != 0 THEN T.THREAD_TYPE                  ELSE MAP(BI.THREAD_TYPE,    '%', 'any', BI.THREAD_TYPE)           END THREAD_TYPE,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ACTIVITY')      != 0 THEN TC.CALLSTACK_ACTIVITY          ELSE MAP(BI.ACTIVITY,       '%', 'any', BI.ACTIVITY)              END CALLSTACK_ACTIVITY,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD') != 0 THEN T.THREAD_METHOD                ELSE MAP(BI.THREAD_METHOD,  '%', 'any', BI.THREAD_METHOD)         END THREAD_METHOD,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL') != 0 THEN SUBSTR(T.THREAD_DETAIL, 1, 80) ELSE MAP(BI.THREAD_DETAIL,  '%', 'any', BI.THREAD_DETAIL)         END THREAD_DETAIL,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')     != 0 THEN T.LOCK_NAME                    ELSE MAP(BI.LOCK_NAME,      '%', 'any', BI.LOCK_NAME)             END LOCK_NAME,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_1,  SUBSTR(TC.CALL_1,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_1,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_2,  SUBSTR(TC.CALL_2,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_2,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_3,  SUBSTR(TC.CALL_3,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_3,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_4,  SUBSTR(TC.CALL_4,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_4,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_5,  SUBSTR(TC.CALL_5,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_5,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_6,  SUBSTR(TC.CALL_6,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_6,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_7,  SUBSTR(TC.CALL_7,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_7,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_8,  SUBSTR(TC.CALL_8,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_8,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_9,  SUBSTR(TC.CALL_9,  1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_9,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_10, SUBSTR(TC.CALL_10, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_10,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_11, SUBSTR(TC.CALL_11, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_11,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_12, SUBSTR(TC.CALL_12, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_12,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_13, SUBSTR(TC.CALL_13, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_13,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_14, SUBSTR(TC.CALL_14, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_14,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_15, SUBSTR(TC.CALL_15, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_15,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_16, SUBSTR(TC.CALL_16, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_16,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_17, SUBSTR(TC.CALL_17, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_17,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_18, SUBSTR(TC.CALL_18, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_18,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_19, SUBSTR(TC.CALL_19, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_19,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_20, SUBSTR(TC.CALL_20, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_20,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_21, SUBSTR(TC.CALL_21, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_21,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_22, SUBSTR(TC.CALL_22, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_22,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_23, SUBSTR(TC.CALL_23, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_23,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_24, SUBSTR(TC.CALL_24, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_24,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_25, SUBSTR(TC.CALL_25, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_25,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_26, SUBSTR(TC.CALL_26, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_26,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_27, SUBSTR(TC.CALL_27, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_27,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_28, SUBSTR(TC.CALL_28, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_28,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_29, SUBSTR(TC.CALL_29, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_29,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_30, SUBSTR(TC.CALL_30, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_30,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_31, SUBSTR(TC.CALL_31, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_31,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_32, SUBSTR(TC.CALL_32, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_32,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_33, SUBSTR(TC.CALL_33, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_33,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_34, SUBSTR(TC.CALL_34, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_34,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_35, SUBSTR(TC.CALL_35, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_35,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_36, SUBSTR(TC.CALL_36, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_36,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_37, SUBSTR(TC.CALL_37, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_37,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_38, SUBSTR(TC.CALL_38, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_38,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_39, SUBSTR(TC.CALL_39, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_39,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_40, SUBSTR(TC.CALL_40, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_40,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_41, SUBSTR(TC.CALL_41, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_41,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_42, SUBSTR(TC.CALL_42, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_42,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_43, SUBSTR(TC.CALL_43, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_43,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_44, SUBSTR(TC.CALL_44, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_44,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_45, SUBSTR(TC.CALL_45, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_45,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_46, SUBSTR(TC.CALL_46, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_46,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_47, SUBSTR(TC.CALL_47, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_47,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_48, SUBSTR(TC.CALL_48, 1, BI.MAX_CALL_LEN)) ELSE 'any' END CALL_48,
        COUNT(*) THREADS,
        COUNT(*) / SUM(COUNT(*)) OVER () * 100 PERCENT,
        AVG(DURATION_MS) DURATION_MS,
        BI.SHORT_CALLS,
        BI.IGNORE_SYSCALL_THREADS
      FROM
        BASIS_INFO BI,
        M_SERVICES S,
      ( SELECT
          HOST,
          PORT,
          CONNECTION_ID,
          THREAD_ID,
          STATEMENT_HASH,
          THREAD_STATE,
          CASE
            WHEN THREAD_TYPE LIKE 'JobWrk%' THEN 'JobWorker'
            ELSE THREAD_TYPE
          END THREAD_TYPE,
          CASE 
            WHEN THREAD_METHOD LIKE 'GCJob%' THEN 'GCJob' 
            ELSE THREAD_METHOD 
          END THREAD_METHOD,
          THREAD_DETAIL,
          LOCK_WAIT_NAME LOCK_NAME,
          IS_ACTIVE,
          DURATION DURATION_MS
        FROM
          M_SERVICE_THREADS 
      ) T,
      ( SELECT
          *,
          CASE
            WHEN CALL_3 LIKE 'TrexThreads::PoolThread::run%'                                                  THEN 'Request (Idle)'
            WHEN ( CALL_1 LIKE '__GI_epoll_pwait%' OR CALL_1 LIKE 'epoll_pwait%' ) AND
              ( CALL_8 LIKE 'TrexThreads::PoolThread::run%' OR CALL_9 LIKE 'TrexThreads::PoolThread::run%' OR
                CALL_2 = '' )                                                                                 THEN 'SqlExecutor (Idle)'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobExecutorNumaNode::waitForJobs%'                        THEN 'JobWorker (Idle)'

            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::Barrier::wait%SPI::waitStateChange%'                THEN 'Wait For Commit'
            WHEN CALLSTACK_CONCAT LIKE '%__GI___clock_gettime%'                                               THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%__tz_convert%'                                                       THEN 'Timezone Conversion'
            WHEN CALLSTACK_CONCAT LIKE '%__vdso_gettimeofday%'                                                THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE 'rte::timer::ns%'                                                      THEN 'Time Determination'

            WHEN CALLSTACK_CONCAT LIKE '%ptime::Env::AbapSysTimeZoneSingleCache::AbapSysTimeZoneSingleCache%' THEN 'ABAP Time Zone Cache'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::txAbort%'                                            THEN 'Abort'
            WHEN CALLSTACK_CONCAT LIKE '%finishAssignReadEnabledSecondary%'                                   THEn 'Active/Active'
            WHEN CALLSTACK_CONCAT LIKE '%Auditing::%'                                                         THEN 'Auditing'
            WHEN CALLSTACK_CONCAT LIKE '%Authorization::AuthorizationManager%'                                THEN 'Authorization'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::QueryChecker::addAuthEntry%'                                  THEN 'Authorization'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::BWFFactTableCompression%'                                   THEN 'BW F Fact Table Compression'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::CallStack%'                                                THEN 'Call Stack'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::CallstackThread::run%'                                        THEN 'Call Stack'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::setReplayerPlanStatistic%'                           THEN 'Capture And Replay'
            WHEN CALLSTACK_CONCAT LIKE '%WorkloadReplay%'                                                     THEN 'Capture And Replay'
            WHEN CALLSTACK_CONCAT LIKE '%X2OldLockJobCleanupGuard::doCleanup%'                                THEN 'Cleanup'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::SavepointSPI::lockSavepoint%'                            THEN 'Consistent Change Lock'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Concat::JobConcatAttrCalculator::run%'              THEN 'Concat Attribute Creation'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextFunctions::dumpInfo%'                              THEN 'Context List'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextStatistics%'                                       THEN 'Context Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::CPUTimeMeasurement%'                                      THEN 'CPU Time Measurement'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::TraceOutputFileHandlerImpl%'                               THEN 'Database Trace'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::TraceSegment%'                                             THEN 'Database Trace'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::TraceStream%'                                              THEN 'Database Trace'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::debugMessage%'                                                THEN 'Debug Message'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::B_reeAttribute<%'                                   THEN 'Delta Storage'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::B_reeAttribute::%'                                  THEN 'Delta Storage'
            WHEN CALLSTACK_CONCAT LIKE '%__cxa_rethrow%'                                                      THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%__gxx_exception_cleanup%'                                            THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::exception_scope_helper%'                                        THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::handleSQLException%'                          THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::handleException%'                                  THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%_Unwind_Resume%'                                                     THEN 'Exception Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::checkTraceExpStmtsEnabled%'                        THEN 'Expensive Statements Trace'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ExpensiveStatementTracer::traceExpensiveStatement%'           THEN 'Expensive Statements Trace'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::impl::FeatureUsageStatistics%'                             THEN 'Feature Usage Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%QueryMediator::FilterProcessor::addFemsFilterToPlan%'                THEN 'FEMS'
            WHEN CALLSTACK_CONCAT LIKE '%getPageWithFreeSpaceFromFreeList%'                                   THEN 'Freelist Handling'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TRexApiSystem::preloadTables%'                              THEN 'Table Reload'
            WHEN CALLSTACK_CONCAT LIKE '%SAP::TextAnalysis%'                                                  THEN 'Text Analysis'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::TextAttribute::%'                                   THEN 'Text Search'
            WHEN CALLSTACK_CONCAT LIKE '%::_getNextFuzzy_SimilarNoSasso%'                                     THEN 'Text Search'
            WHEN CALLSTACK_CONCAT LIKE '%StringScoringCalculator<%'                                           THEN 'Text Search'
            WHEN CALLSTACK_CONCAT LIKE '%TRexConfig::IndexHandle::fastSharedAcquire%'                         THEN 'Index Handle'
            WHEN CALLSTACK_CONCAT LIKE '%TRexConfig::IndexHandle::acquire%'                                   THEN 'Index Handle'
            WHEN CALLSTACK_CONCAT LIKE '%MemoryManager::GlobalMemoryHandler::pmAcquireIPMMLock%'              THEN 'IPMM Lock'
            WHEN CALLSTACK_CONCAT LIKE '%ItabLeakTraceWrapper%'                                               THEN 'ITAB Leak Trace'
            WHEN CALLSTACK_CONCAT LIKE '%Basis::Timer::getMicroTimer%'                                        THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%Basis::Timer::getHiPerfTimer%'                                       THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::impl::TimeMeasurementScope::TimeMeasurementScope%'        THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%TimerImpl::initialMicroTimer%'                                       THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%TimerImpl::rdtscTimer%'                                              THEN 'Time Determination'
            WHEN CALLSTACK_CONCAT LIKE '%__GI_kill%'                                                          THEN 'Kill Signal'
            WHEN CALLSTACK_CONCAT LIKE '%Licensing::LicenseChecker::%'                                        THEN 'License Checker'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::CommMgr::loadBalance%'                                        THEN 'Load Balancing'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::CommMgr::loadBalance%'                                 THEN 'Load Balancing'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eLobGetPiece%'                             THEN 'LOB Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Delta::log::Replay::replay%'                                         THEN 'Log Replay'
            WHEN CALLSTACK_CONCAT LIKE '%DataRecovery::DirectoryLogSegmentFactory::run%'                      THEN 'Log Segment Formatter'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::getUsedMemorySize%'                                THEN 'Memory Tracking'
            WHEN CALLSTACK_CONCAT LIKE '%Metadata::MDCache%'                                                  THEN 'Metadata Cache'
            WHEN CALLSTACK_CONCAT LIKE '%Newdb::DistMDCacheClient::%'                                         THEN 'Metadata Cache'
            WHEN CALLSTACK_CONCAT LIKE '%Newdb::DistMDCacheServer::%'                                         THEN 'Metadata Cache'
            WHEN CALLSTACK_CONCAT LIKE '%Metadata::CSViewInfo::%'                                             THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%Metadata::_STableInfo::%'                                            THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%Metadata::TopologyInfo::%'                                           THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ResultSetMetaData%'                                           THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%TRexConfig::CachedMetaDataBase%'                                     THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexSearchMeta::getSearchMetaData%'                           THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::dFdaRequestMetadata%'                      THEN 'Metadata'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Monitor_s%'                                                   THEN 'Monitoring View'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TraceFileContentMonitor%'                                     THEN 'Monitoring View'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::StatisticsWrapper::traverseNodesBase%'                     THEN 'Monitoring View'
            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::MutexStatistics::MutexStatistics%'                  THEN 'Mutex Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::LoadHistoryComponent::handle_nsWatchdog%'                   THEN 'Nameserver Ping'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TREXIndexServer::handle_nsWatchdog%'                        THEN 'Nameserver Ping'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TableLock::lockTable%'                                        THEN 'Object Lock'
            WHEN CALLSTACK_CONCAT LIKE '%c_cmdseq_env_notifier%'                                              THEN 'ODBC'
            WHEN CALLSTACK_CONCAT LIKE '%c_strm_tcp_port::do_control_thread%'                                 THEN 'ODBC'
            WHEN CALLSTACK_CONCAT LIKE '%OpAdapter::OperationCacheJob::run%'                                  THEN 'Operation Cache Job'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Mergedog::optimizeCompression%'                             THEN 'Optimize Compression'
            WHEN CALLSTACK_CONCAT LIKE '%ResourceManager::PagedAttributeUnloadThread::run%'                   THEN 'Paged Attribute Unload'
            WHEN CALLSTACK_CONCAT LIKE '%PerformanceAnalyzerUtils::QueryScope::QueryScope%'                   THEN 'Performance Analyzer'
            WHEN CALLSTACK_CONCAT LIKE '%TrexTrace::getPerformanceTracer%'                                    THEN 'Performance Tracer'
            WHEN CALLSTACK_CONCAT LIKE '%planvizCS::%'                                                        THEN 'PlanViz'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Table::isPlanVizMode%'                                        THEN 'PlanViz'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PlanVizContext%'                                              THEN 'PlanViz'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PostdropWatchdog::PostdropJobNode::postdrop%'                 THEN 'Post Drop Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%PythonUtil::PythonRuntime::exec%'                                    THEN 'Python'
            WHEN CALLSTACK_CONCAT LIKE '%Executor::ExecutorPythonTrace%'                                      THEN 'Python Trace'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::isPythonTraceEnabled%'                                      THEN 'Python Trace'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::RowLevelLocking::%'                                           THEN 'Record Lock'
            WHEN CALLSTACK_CONCAT LIKE '%TrexStore::RowLockConflictManager::waitForLock%'                     THEN 'Record Lock'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::PrivateLogBuffer::flush%'                                THEN 'Redo Log Write'
            WHEN CALLSTACK_CONCAT LIKE '%DataRecovery::LoggerImpl::writeLog%'                                 THEN 'Redo Log Write'
            WHEN CALLSTACK_CONCAT LIKE '%DataRecovery::PersLogInfoHandler::logInfo%'                          THEN 'Redo Log Write'
            WHEN CALLSTACK_CONCAT LIKE '%UnifiedTable::RedoHandler::logRedo%'                                 THEN 'Redo Log Write'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::TraceContextAggregatable::enableResourceTracking%'        THEN 'Resource Tracking'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ResourceMeasurement%'                                         THEN 'Resource Tracking'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::ResultCache::Scope::Scope%'                                 THEN 'Result Cache'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::QueryExecutor::create_tree_index%'                            THEN 'Row Store Index Creation'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::SelfWatchdog::run%'                                     THEN 'Self Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::ServiceNetworkIOStatisticsCollector::%'                     THEN 'Service Network I/O Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::SpeculativeLock%'                                   THEN 'Speculative Lock'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::PreparedStatement_SQLTracer::init%'        THEN 'SQL Trace'
            WHEN CALLSTACK_CONCAT LIKE '%Stream::NetworkChannelSSLFilter%'                                    THEN 'SSL'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::close%'                                           THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::close%'                                    THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ResultSet::close%'                                            THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::closeCursor%'                                      THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::endStmt%'                                          THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::StatementContext::release%'                               THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexPlanOp::closeAfterWriteQueryOutputData%'                  THEN 'Statement Close'
            WHEN CALLSTACK_CONCAT LIKE '%MemoryManager::ImplicitStatementMemoryBooking%'                      THEN 'Statement Memory Booking'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::ImplicitStatementMemoryBooking%'                          THEN 'Statement Memory Booking'
            WHEN CALLSTACK_CONCAT LIKE '%monitor_execute%'                                                    THEN 'Statement Monitor'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::suspend%'                                          THEN 'Statement Suspend'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::LockTable::lock%'                                             THEN 'Table Lock'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::lockTables%'                                       THEN 'Table Lock'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Plan::PlanInfos::is_table_replicated%'                 THEN 'Table Replication'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TextQueryProcessor::process%'                               THEN 'Text Indexing'
            WHEN CALLSTACK_CONCAT LIKE '%queueserver2::QueueMgr::handle%'                                     THEN 'Text Indexing'
            WHEN CALLSTACK_CONCAT LIKE '%queueserver2::Queue::transmitAndSync%'                               THEN 'Text Indexing'
            WHEN CALLSTACK_CONCAT LIKE '%TrexThreads::ThreadManager::create%'                                 THEN 'Thread Management'
            WHEN CALLSTACK_CONCAT LIKE '%TrexThreads::Thread::isCanceled%'                                    THEN 'Thread Management'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::impl::TimeMeasurementScope::~TimeMeasurementScope%'       THEN 'Time Measurement'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextFunctions::getCurrentTraceContext%'                THEN 'Trace Context'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::TraceContext%'                                            THEN 'Trace Context'
            WHEN CALLSTACK_CONCAT LIKE '%RestoreAggTraceContextScope%'                                        THEN 'Trace Context'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TriggerExecutor::executeTriggerCode%'                       THEN 'Trigger'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::get_mvcc_statistics%'                            THEN 'Version Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::VersionMgr%'                                                  THEN 'Version Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Window::callWindowFunctions%'                                 THEN 'Windows Function'
            WHEN CALLSTACK_CONCAT LIKE '%jsvm::%'                                                             THEN 'XS Engine'
            WHEN CALLSTACK_CONCAT LIKE '%xsdbc::Connection::executeQuery%'                                    THEN 'XS Engine'
            WHEN CALLSTACK_CONCAT LIKE '%xsengine::RequestHandler::handleRequest%'                            THEN 'XS Engine'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupExe_LogWaitForBackintConnectionThread::run%'           THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupLCM_Queue::startJob%'                                  THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMgr_Manager::executeSaveCatalog%'                      THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMgr_Manager::handleRequest%'                           THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMgr_ExecutorJob::run%'                                 THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMgr_Manager::getLogBackup%'                            THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMgr_SaveDataJob::run%'                                 THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupMonitor_TransferQueue::BackupMonitor_TransferThread%'  THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::Backup_Progress::BackupProgressWatchdog::run%'               THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupExe_Job::run%'                                         THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::Backup_ExecutorHandler::handleRequest%'                      THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%Backup::BackupExe_LogBackupImpl::LogBackupThread::run%'              THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%handleBackupManagerRequest%'                                         THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::CatalogWatchdog%'                                             THEN 'Catalog Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::QueryExecutor::backup_save_data%'                             THEN 'Backup'
            WHEN CALLSTACK_CONCAT LIKE '%NameServer::CheckMasterLocksThread::run%'                            THEN 'CheckMasterLocksThread'
            WHEN CALLSTACK_CONCAT LIKE '%NameServer::ClockMonitor::run%'                                      THEN 'Clock Monitor'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::LOBGarbageCollector::LOBGarbageCollector%'                  THEN 'Column Store LOB Garbage Collection'
            WHEN CALLSTACK_CONCAT LIKE '%EAPI::ConnectionHandle::commit%'                                     THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::commit%'                                          THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::doAutoCommit%'                                    THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::handleCommitForSession%'                          THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::txCommit%'                                           THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eTxCommit%'                                THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::commit%'                                         THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::remote_commit_write%'                            THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::remote_prepare_commit_write%'                    THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::write_prepare_commit_log%'                       THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%TransactionManager::SubTransaction::commit%'                         THEN 'Commit'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::QueryExecutor::recompile_related_objects%'                    THEN 'Compile'
            WHEN CALLSTACK_CONCAT LIKE '%ljit::backend::LlvmIRCompilerLocal::compile%'                        THEN 'Compile'
            WHEN CALLSTACK_CONCAT LIKE '%X86_64_CheckCPUFeatures%'                                            THEN 'CPU Feature Check'
            WHEN CALLSTACK_CONCAT LIKE '%DPFramework::Framework::pingAgent%'                                  THEN 'DP Ping Agent'
            WHEN CALLSTACK_CONCAT LIKE '%DPFramework::PrefetchThread::run%'                                   THEN 'DP Prefetch Thread'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::prepareStatement%'                                THEN 'Prepare'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::compile%'                                              THEN 'Prepare'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Plan::reset%'                                          THEN 'Prepare'
            WHEN CALLSTACK_CONCAT LIKE '%QueryMediator::QueryMediator::createPlan%'                           THEN 'Prepare'
            WHEN CALLSTACK_CONCAT LIKE '%addResultSetPart%'                                                   THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Protocol::FdaReplyMetadata::setPreamble%'             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Protocol::Packet::%'                                  THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Protocol::ReplyPacket::%'                             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Protocol::Segment::%'                                 THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ConnectionContext%'                                       THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextLocalStorage::transferImpersonatedValues%'         THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::impl::CallLinkScope::~CallLinkScope%'                     THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextStateScope%'                                       THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Action::finalize%'                                            THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::CommThreadStatusCallback%::isRequestIdInherit%'               THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::getAutoCommit%'                                   THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::getUpdateTransactionId%'                          THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::isTransStarted%'                                  THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::setAutoCommit%'                                   THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::validateSessionContext%'                          THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EAPIConnTrans::getAutoCommit%'                                THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Env::resize%'                                                 THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EventIterator::reset%'                                        THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::oabapstream::initializePointers%'                             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PtimeErrorCode::is_needed_session_close%'                     THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ReceiveStatusScope::%'                                        THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::getDataFormatVersion%'                               THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::getSessionPartitionId%'                              THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodec::getHeaderLength%'                               THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::deConnect%'                                THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::deReleaseQid%'                             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::dExecuteQid%'                              THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eQidCreated%'                              THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eQidReleased%'                             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eRowCount%'                                THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eSessionHeader%'                           THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eStatementContext%'                        THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eTransactionFlags%'                        THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eWarning%'                                 THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::getMessageHeaderLength%'                   THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionEvent::getAction%'                                     THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionExecutorSelector::determineExecutionOnJexec%'          THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::doCheckConnectionAndSet%'                     THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::doDecodeMessage%'                             THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::prepareAction%'                               THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::CommMgrStatistics::addExecTime%'                       THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%session::RuntimeStatementContext::getSessionContext%'                THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SharedConnGuard::%SharedConnGuard%'                           THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::XATransactionScope::XATransactionScope%'                      THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%session::SessionContext%'                                            THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%session::SessionManager::getInstance%'                               THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::Channel::getAssociatedObject%'                         THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::PendingFirstLoadBalancer::markPendingCommEvent%'       THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::TcpBasisChannelMgr::TcpBasisChannelEventIterator::%'   THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::TcpCommMgr::findIdleCommEvents%'                       THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::Mutex::attachToCurrentContext%'                     THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::BufferedNetInput::ignoreRest%'                              THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::ContextOnThreadScope%'                                    THEN 'Connection Handling'
            WHEN CALL_1           LIKE '%ptime::SessionCodecNewdb::eVendorMessage%'                           THEN 'Connection Handling'
            WHEN CALL_1           LIKE '%ptime::SessionCodecNewdb::eCursorCreated%'                           THEN 'Connection Handling'
            WHEN CALL_1           LIKE '%ptime::SessionHandler::doSendMessage%'                               THEN 'Connection Handling'
            WHEN CALL_1           LIKE '%ptime::SessionHandler::executeAction%'                               THEN 'Connection Handling'
            WHEN CALL_2           LIKE '%ptime::SessionHandler::receiveMessage_%'                             THEN 'Connection Handling'
            WHEN CALL_2           LIKE '%ptime::SessionCodecNewdb::eCursorCreated%'                           THEN 'Connection Handling'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::ContinuousPageFlusher::run%'                             THEN 'Continuous Page Flusher'
            WHEN CALLSTACK_CONCAT LIKE '%CS::DDL::RequestAPIImpl::executeDDLRequest%'                         THEN 'DDL Execution'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::MergeAttributeJob::doMerge%'                                THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SaveMergedAttributeJob::run%'                               THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SmartMergeThr::run%'                                        THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TRexApiAdmin::mergeDeltaIndexForParts%'                     THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::MergedogMergeThr::run%'                                     THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::MergedogWatchThr::run%'                                     THEN 'Delta Merge'
            WHEN CALLSTACK_CONCAT LIKE '%RFScoring::DeserializeScoringJob::run%'                              THEN 'Deserialize Scoring Job'
            WHEN CALLSTACK_CONCAT LIKE '%FileAccess::SubmitThread::run%'                                      THEN 'Backup (Submit Thread)'
            WHEN CALLSTACK_CONCAT LIKE '%Catalyst::EpochClient::run%'                                         THEN 'EpochClient'
            WHEN CALLSTACK_CONCAT LIKE '%Catalyst::EpochManager::handle%'                                     THEN 'EpochManager'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelFetchJob%'                                              THEN 'ESX (ParallelFetchJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelGroupingJob::runInternal%'                              THEN 'ESX (ParallelGroupingJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelItabBuildJob%'                                          THEN 'ESX (ParallelItabBuildJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelPartialGroupingJob%'                                    THEN 'ESX (ParallelPartialGroupingJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelPartitionJob%'                                          THEN 'ESX (ParallelPartitionJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::ParallelSortJob%'                                               THEN 'ESX (ParallelSortJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ESX::Window::open%'                                                  THEN 'ESX (Window)'
            WHEN CALLSTACK_CONCAT LIKE '%Distribution::GroupMulticastExecutor::run%'                          THEN 'Group Multicast Executor'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::ExternalCommandHandler::parseAndExecute%'                  THEN 'hdbcons'
            WHEN CALLSTACK_CONCAT LIKE '%IcmWatchDogThread%'                                                  THEN 'ICM Watchdog Thread'
            WHEN CALLSTACK_CONCAT LIKE '%IcmWorkerThread%'                                                    THEN 'ICM Worker Thread'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobExecWatchdog::run%'                                    THEN 'Job Execution Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobOpenFastUnsorted::getNextJobFrom%'                     THEN 'Job Execution Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::JobexLogTrack%Scope::enter%'                               THEN 'Job Execution Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::JobexLogTrackSyncScope::leave%'                            THEN 'Job Execution Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Executor::X2::getConnectorValue%'                                    THEN 'Job Execution Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobExecMainDispatcher::run%'                              THEN 'Job Execution Dispatcher'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobContext::addJob%'                                      THEN 'JobWorker Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobExecutor%'                                             THEN 'JobWorker Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobNode::JobNode%'                                        THEN 'JobWorker Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobObjectImpl::signalWaiter%'                             THEN 'JobWorker Handling'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::JobBase::release%'                              THEN 'JobWorker Handling'
            WHEN CALL_1           LIKE '%Executor::X2OldLock::runPopTask%'                                    THEN 'JobWorker Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::ProfilerThread::run%'                                      THEN 'Kernel Profiler'
            WHEN CALLSTACK_CONCAT LIKE '%Executor::KPIValuesUpdater::update%'                                 THEN 'KPI Values Updater'
            WHEN CALLSTACK_CONCAT LIKE '%NameServer::LoadDataWriter::run%'                                    THEN 'Load Data Writer'
            WHEN CALLSTACK_CONCAT LIKE '%NameServer::LicenseHandler::%'                                       THEN 'License Handler'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::LVCProcedure::execute%'                                       THEN 'liveCache'
            WHEN CALLSTACK_CONCAT LIKE '%FileAccess::LocalFileCompletionThread::run%'                         THEN 'Local File Completion'
            WHEN CALLSTACK_CONCAT LIKE '%NameServer::TimerThread::run%'                                       THEN 'Local Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%Hierarchies::PopHierarchy%'                                          THEN 'PopHierarchy'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TRexApiMDS::handleRequest%'                                 THEN 'MDS'
            WHEN CALLSTACK_CONCAT LIKE '%mds::api::MDXProcessor::executeMdxStatement%'                        THEN 'MDX'
            WHEN CALLSTACK_CONCAT LIKE '%mdx::processor::AddCalculatedMemberViews::operator%'                 THEN 'MDX'
            WHEN CALLSTACK_CONCAT LIKE '%MemoryManager::CompactionThread::run%'                               THEN 'Memory Compactor'
            WHEN CALLSTACK_CONCAT LIKE '%__GI_memset%'                                                        THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::allocated_refcounted%'                                          THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::allocator::%'                                                   THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::allocator_statistics%'                                          THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::adapter_allocator_local%'                                       THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%MemoryManager::%'                                                    THEN 'Memory Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::MemoryMgr%'                                                   THEN 'Memory Management (Row Store)'
            WHEN CALLSTACK_CONCAT LIKE '%PersistenceLayer::LOBCreateFilesJob::createMidSizeLobs%'             THEN 'Packed LOB Creation'
            WHEN CALLSTACK_CONCAT LIKE '%Distribution::GroupMulticastStreamManager::handle%'                  THEN 'Multicast Stream Manager'
            WHEN CALLSTACK_CONCAT LIKE '%SQL::Update::MultiStoreOperator::operator%'                          THEN 'MultiStore'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::AntiAger%'                                                    THEN 'MVCC Anti Ager'
            WHEN CALLSTACK_CONCAT LIKE '%Stream::NetworkChannelCompletionThread::run%'                        THEN 'Network Channel Completion'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::GetMostFrequentValueInfosJob::run%'                 THEN 'OC (GetMostFrequentValueInfosJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::SortRestRangeJob::run%'                             THEN 'OC (SortRestRangeJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::UpdateMostFrequentValueCountJob::run%'              THEN 'OC (UpdateMostFrequentValueCountJob)'
            WHEN CALLSTACK_CONCAT LIKE '%CS::OC::ChangeCompressionJob::run%'                                  THEN 'OC (ChangeCompressionJob)'
            WHEN CALLSTACK_CONCAT LIKE '%CS::OC::EstimateCompressionJob::run%'                                THEN 'OC (EstimateCompressionJob)'
            WHEN CALLSTACK_CONCAT LIKE '%CS::OC::PrepareRenumberJob::run%'                                    THEN 'OC (PrepareRenumberJob)'
            WHEN CALLSTACK_CONCAT LIKE '%CS::OC::SaveRenumberJob::run%'                                       THEN 'OC (SaveRenumberJob)'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::GarbageCollectorJob::run%'                               THEN 'Persistence Garbage Collector'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::PhraseIndexBuilder::run%'                           THEN 'Phrase Index Builder'
            WHEN CALLSTACK_CONCAT LIKE '%Stream::PipeChannelJob::run%'                                        THEN 'Pipe Channel Job'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PostCommitExecutor::%'                                        THEN 'Post Commit Executor'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PostdropWatchdog::run%'                                       THEN 'Postdrop Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%queueserver2::SchedulerThread::schedule%'                            THEN 'Text Indexing'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::PersistenceHandler::handle_reclaimDataVolume%'          THEN 'RECLAIM DATAVOLUME'
            WHEN CALLSTACK_CONCAT LIKE '%ResourceManager::ResourceFlushThread::run%'                          THEN 'Resource Flush Thread'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionManagerImpl::rollbackPrimarySession%'                  THEN 'Rollback'
            WHEN CALLSTACK_CONCAT LIKE '%RowEngine::Version::PartitionedMVCCCollector%'                       THEN 'Row Store Garbage Collection'
            WHEN CALLSTACK_CONCAT LIKE '%RowEngine::Version::VersionCollector::VersionCollectorJobNode::run%' THEN 'Row Store Garbage Collection'
            WHEN CALLSTACK_CONCAT LIKE '%TransactionManager::MVCCGarbageCollector::run%'                      THEN 'Row Store Garbage Collection'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::GarbageLobFileHandler::run%'                                  THEN 'Row Store LOB Garbage Collection'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::TableDMLRuntimeData::getTableDMLStatistics%'           THEN 'Runtime Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::CS_StatisticsImpl::handleRemoteRequest%'                    THEN 'Runtime Statistics'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::SavepointImpl::run%'                                     THEN 'Savepoint'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::savepoint%'                                        THEN 'Savepoint'
            WHEN CALLSTACK_CONCAT LIKE '%RowEngine::SegmentPreallocator::run%'                                THEN 'Segment Preallocator'
            WHEN CALLSTACK_CONCAT LIKE '%::ServiceThreadSamplerThread::run%'                                  THEN 'Service Thread Sampler'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionWatchdog::run%'                                        THEN 'Session Watchdog'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::SignalSender::run%'                                         THEN 'Signal Sender'
            WHEN CALLSTACK_CONCAT LIKE '%federation::%'                                                       THEN 'Smart Data Access'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TcpListener::tcp_listener_body%'                              THEN 'SQL Listener'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::PlanCache::SQLPlanCacheThread::run%'                   THEN 'SQL Plan Cache Thread'
            WHEN CALLSTACK_CONCAT LIKE '%initializeStatementConcurrencyLimit%'                                THEN 'Statement Concurrency Limit'
            WHEN CALLSTACK_CONCAT LIKE '%DebuggingBackend::DebuggerDetachCheckForStatement%'                  THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::StatisticsDataOwnerHandleBase::unregister%'                THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::TraceTopic::isTraceActive%'                                THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%EAPI::CursorHoldability::hasHoldability%'                            THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::Context::dropRegisteredStackObjectArray%'                 THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextFunctions::isCurrentExecutionCanceled%'            THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::Context::self%'                                           THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextStack::ensureStackFreeBytes%'                      THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::ContextStateScope::ContextStateScope%'                    THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::Thread::getStack%'                                        THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%expr::Evaluator::PrepareConstant%'                                   THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ltt::adapter_allocator_local%'                                       THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Newdb::TransTokenThreadContainer::getPtimeCallFromThreadKey%'        THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::codegen_so2l::gen_code%'                                      THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EntryStatementScope::EntryStatementScope%'                    THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EntryStatementScope::reset%'                                  THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EnvRuntimeConst%'                                             THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Executor::X2OldLock::createId%'                                      THEN 'Statement Handling'
            WHEN CALL_1           LIKE '%ptime::orawstream::reserve%'                                         THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::getUpdateCountArray%'                      THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::hasOpen%'                                  THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::isEntryBatchProcessing%'                   THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::validate%'                                 THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::RemoteQueryContext::init%'                                    THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Entry::update_last_execution_time%'                    THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::getTableDMLRuntimeData%'                               THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::_isMulticastExecution%'                                THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::param_t::getParameters%'                               THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::param_t::check_bound%'                                 THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Plan::is_%'                                            THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Plan::getPlanCacheEntry%'                              THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::Plan::PlanInfos::is_%'                                 THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::PlanCache::get_statistics_collection%'                 THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::QueryRuntimeTextCallBack%'                             THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::result_t::clear%'                                      THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::result_t::set_info_from_compiled_code%'                THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::scoped_timer_for_query_execute%'                       THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::QueryExecutionTextCallBack::%'                                THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::onBeginDecode%'                               THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::checkDDL%'                                         THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::checkRangeRestriction%'                            THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::clearCurrentThreadId%'                             THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::endStmt%'                                          THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::getExecutionContext%'                              THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::getNumParam%'                                      THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::getQueryDumpMessage%'                              THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::monitor%'                                          THEN 'Statement Handling' /* monitoring for M_PREPARED_STATEMENTS, M_CONNECTIONS */
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::needExternalExecution%'                            THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::QueryExecutionScope%'                              THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::registerLocalOpenResultLocators%'                  THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::resetStatementForReuse%'                           THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::resume%'                                           THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::setCommandInfo%'                                   THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::startStmt%'                                        THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TcpCommMgr::getPartId%'                                       THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexOltpSearchFactory::create%'                               THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexResultIMS::countRows%'                                    THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%QueryMediator::OLAPQuery::init%'                                     THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%<no symbol>%' AND CALL_2 LIKE 'ptime::Query::execute%'                         THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%ptime::Query::%execute%'                                                       THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%ptime::ResultSet::ResultSet%'                                                  THEN 'Statement Handling'
            WHEN CALL_2 LIKE '%ptime::ResultSet::open%'                                                       THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%ptime::SessionCodecNewdb::eResultSet%'                                         THEN 'Statement Handling'
            WHEN CALL_2 LIKE '%ptime::SessionCodecNewdb::eResultSet%'                                         THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%ptime::SessionHandler::handleEvent%'                                           THEN 'Statement Handling'
            WHEN CALL_2 LIKE '%ptime::SessionHandler::handleEvent%'                                           THEN 'Statement Handling'
            WHEN CALL_1 LIKE '%ptime::Trex_search::do_open%'                                                  THEN 'Statement Handling'
            WHEN CALLSTACK_CONCAT LIKE '%StatisticsService::WorkerThread::run%'                               THEN 'Statistics Server'
            WHEN CALLSTACK_CONCAT LIKE '%StatisticsService::CallInterfaceDirect::proceed%'                    THEN 'Statistics Server'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::CopyStringsJob::run%'                             THEN 'String Copy'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::ReplicationProtocolHandler::run%'                        THEN 'System Replication'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::DisasterRecoveryPrimaryHandlerImpl::%'                   THEN 'System Replication'
            WHEN CALLSTACK_CONCAT LIKE '%TableConsistencyCheck::CheckColumnLengthJob%'                        THEN 'CTC (CheckColumnLength)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Partitioning::checkPartFragmentsJobNode::run%'              THEN 'CTC (checkPartFragments)'
            WHEN CALLSTACK_CONCAT LIKE '%TableConsistencyCheck::TablePartChecker::checkPrimaryKey%'           THEN 'CTC (checkPrimaryKey)'
            WHEN CALLSTACK_CONCAT LIKE '%TableConsistencyCheck::TablePartChecker::checkRowid%'                THEN 'CTC (checkRowid)'
            WHEN CALLSTACK_CONCAT LIKE '%TableConsistencyCheck::ColumnTablePartJobNode%'                      THEN 'CTC (ColumnTablePart)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::InvertedIndexChecker%'                              THEN 'CTC (InvertedIndexChecker)'
            WHEN CALLSTACK_CONCAT LIKE '%TableConsistencyCheck::RowTableJobNode::run%'                        THEN 'CTC (RowTableJobNode)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TableUpdateWriter%'                                         THEN 'Table Update Writer'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TRexApiTempTableCreateBase::create%'                        THEN 'Temporary Table Handling'
            WHEN CALLSTACK_CONCAT LIKE '%Diagnose::TraceSegmentCompressorThread::run%'                        THEN 'Trace Segment Compressor'
            WHEN CALLSTACK_CONCAT LIKE '%Catalyst::XAIndoubtTransTable%'                                      THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::impl::TransTokenScope::~TransTokenScope%'                 THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::TransTokenIfc::destroySubToken%'                          THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::WorkloadContextScope::WorkloadContextScope%'              THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Newdb::TransToken::%'                                                THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Newdb::TransTokenThreadContainer::%'                                 THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Connection::beginSecondaryTrans%'                             THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::auto_tx_start%'                                        THEN 'Transaction Management'
            WHEN CALL_1 LIKE '%ptime::SessionCodecNewdb::isReadTransaction%' OR CALL_2 LIKE '%ptime::SessionCodecNewdb::isReadTransaction%' THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::getMetadataContext%'                             THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::startPersistenceSessionSubtrans%'                THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Transaction::TransactionObjectGuard::%'                       THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%Replication::Logger::allocateLogSpace%'                              THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%TransactionControlBlockFactory::getTimestampState%'                  THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%TransactionManager::ReleasedLockCollector::run%'                     THEN 'Transaction Management'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TransTokenHistoryThread::transTokenHistoryThreadBody%'        THEN 'Trans Token History Thread'
            WHEN CALLSTACK_CONCAT LIKE '%UnifiedTable::UndoHandler%'                                          THEN 'Undo'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::JobBarrier::wait%'                                        THEN 'Wait For JobWorker'
            WHEN CALL_1           LIKE '%Execution::JobWorker::run%'                                          THEN 'Wait For JobWorker'
            WHEN CALL_1           LIKE '%Executor::X2OldLock::~X2OldLock%'                                    THEN 'Wait For JobWorker'
            WHEN CALL_1           LIKE '%TRexUtils::Parallel::JobBase::run%'                                  THEN 'Wait For JobWorker'
            WHEN CALL_3           LIKE 'Executor::X2%::calculate%'                                            THEN 'Wait For JobWorker'
            WHEN CALLSTACK_CONCAT LIKE 'ptime::WorkloadClassManagerImpl::%'                                   THEN 'Workload Class Management'
            WHEN CALLSTACK_CONCAT LIKE '%xecutor::X2::finishValue%'                                           THEN 'X2 (finishValue)'
            WHEN CALLSTACK_CONCAT LIKE '%xecutor::X2::waitCompletionOnSecondary%'                             THEN 'X2 (waitCompletionOnSecondary)'

            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::searchDocumentsIterateDocidsParallel%'              THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Cluster%Scan%Out%'                                  THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Indirect%Scan%Out%'                                 THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Rle%Scan%Out%'                                      THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Sparse%Scan%Out%'                                   THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JEJobReadIndexChunked%'                             THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%mgetSearch%'                                                         THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%sse_icc_lib::mgeti%'                                                 THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::JobParallelMgetSearch::run%'                              THEN 'Column Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::DictScanJob%'                                       THEN 'Dictionary Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::StringDict%'                                        THEN 'Dictionary Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JobReadValueIdsOffset%'                             THEN 'Dictionary Scan'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JEJobReadValueIdsOffsetBVParallel%'                 THEN 'Dictionary Scan'
            WHEN CALLSTACK_CONCAT LIKE '%DPDistributor::DistributorExecutor%'                                 THEN 'DP Distributor'
            WHEN CALLSTACK_CONCAT LIKE '%DPReceiver::%::run%'                                                 THEN 'DP Receiver'
            WHEN CALLSTACK_CONCAT LIKE '%hex::%'                                                              THEN 'HANA Execution Engine'
            WHEN CALLSTACK_CONCAT LIKE '%__memcmp_sse4_1%'                                                    THEN 'Memory Compare'
            WHEN CALLSTACK_CONCAT LIKE '%memcpy_impl%'                                                        THEN 'Memory Copy'
            WHEN CALLSTACK_CONCAT LIKE '%__cxa_free_exception%'                                               THEN 'Memory Copy'
            WHEN CALLSTACK_CONCAT LIKE '%MultiDB::%'                                                          THEN 'Multitenant'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::Requestor::getChannel%'                                     THEN 'Network Channel'
            WHEN CALLSTACK_CONCAT LIKE '%DataContainer::%'                                                    THEN 'Persistence'
            WHEN CALLSTACK_CONCAT LIKE '%DataAccess::PersistenceSession%'                                     THEN 'Persistence'
            WHEN CALLSTACK_CONCAT LIKE '%PersistenceLayer::%'                                                 THEN 'Persistence'
            WHEN CALLSTACK_CONCAT LIKE '%preprocessor::PreprocessorUtil::run%'                                THEN 'Preprocessor'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::MemoryAvc2::load'                                   THEN 'Page Load'
            WHEN CALLSTACK_CONCAT LIKE '%PageAccess::LogicalPageAccessImpl::loadPageInternal%'                THEN 'Page Load'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::PredicateEvaluatorJob::run%'                        THEN 'Predicate Evaluation'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::QueryRuntime::QueryRuntime%'                                THEN 'Query Runtime'
            WHEN CALLSTACK_CONCAT LIKE '%ResourceManager::Resource%'                                          THEN 'Resource Container'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Sorter%'                                            THEN 'Sorting'
            WHEN CALLSTACK_CONCAT LIKE '%qo3::OptimizerImpl::doSort%'                                         THEN 'Sorting'
            WHEN CALLSTACK_CONCAT LIKE '%ParallelRadixSort%'                                                  THEN 'Sorting'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::psort%'                                         THEN 'Sorting'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::Sorter%'                                        THEN 'Sorting'
            WHEN CALLSTACK_CONCAT LIKE '%Basis::strcasecmp%'                                                  THEN 'String Compare'
            WHEN CALLSTACK_CONCAT LIKE '%TransactionManager::Transaction::createSubTransaction%'              THEN 'Sub Transaction Creation'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexTempIndex%'                                               THEN 'Temp Index Handling'
            WHEN CALLSTACK_CONCAT LIKE '%TrexThreads::InheritableLocalStorage::getByKey%'                     THEN 'Transaction Context'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::transBegin%'                                       THEN 'Transaction Start'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::TranslationTable%'                                    THEN 'Translation Table'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::TranslateColumnJob::translate%'                       THEN 'Translation Table'
            WHEN CALLSTACK_CONCAT LIKE '%TrexStore::UdivListManager%'                                         THEN 'UDIV'

            WHEN CALLSTACK_CONCAT LIKE '%__GI___sched_yield%'                                                 THEN 'Active Waiting'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Futex::lock%'                                                 THEN 'Futex Lock'
            WHEN CALLSTACK_CONCAT LIKE '%__GI_epoll_pwait%'                                                   THEN 'Network Poll'
            WHEN CALLSTACK_CONCAT LIKE '%__poll_nocancel%'                                                    THEN 'Network Poll'
            WHEN CALLSTACK_CONCAT LIKE '%Stream::CompletionSet::poll%'                                        THEN 'Network Poll'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Raw::NetworkChannelStream::receive%'                  THEN 'Network Receive'
            WHEN CALL_1           LIKE '%ptime::SessionHandler::receiveMessage%'                              THEN 'Network Receive'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TcpChannel::receive%'                                         THEN 'Network Receive'
            WHEN CALLSTACK_CONCAT LIKE '%SessionLayer::TcpChannel::receive%'                                  THEN 'Network Receive'
            WHEN CALL_1           LIKE '%ptime::TcpReceiver::doWork%'                                         THEN 'Network Receive'
            WHEN CALLSTACK_CONCAT LIKE '%__libc_recv%'                                                        THEN 'Network Receive'
            WHEN CALLSTACK_CONCAT LIKE '%__libc_send%'                                                        THEN 'Network Send'
            WHEN CALLSTACK_CONCAT LIKE '%Communication::Raw::NetworkChannelStream::send%'                     THEN 'Network Send'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionHandler::sendMessage%'                                 THEN 'Network Send'
            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::ReadWriteLock%'                                     THEN 'Read Write Lock'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::RemoteSearchPartJob::run%'                                  THEN 'Remote Search Part Job'
            WHEN CALLSTACK_CONCAT LIKE '%sqlscript::%'                                                        THEN 'SQLScript'

            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::BitVector::%'                                             THEN 'TREX (BitVector)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::aggregateLoop%'                                     THEN 'AE (aggregateLoop)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::AttributeFormatter::write%'                         THEN 'AE (AttributeFormatter)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Delta::BloomfilterRebalanceController%'             THEN 'AE (BloomfilterRebalanceController)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::CalculationJob::run%'                               THEN 'AE (CalculationJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Concat::ConcatenateAttributesJob::run%'             THEN 'AE (ConcatenateAttributesJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::CopyDictRefsReduce%'                                THEN 'AE (CopyDictRefsReduce)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::CopySplitsJob%'                                     THEN 'AE (CopySplitsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::AttributeApi::getDocidForUniqueValue%'              THEN 'AE (DocidForUniqueValue)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::fnBwGetAggregateMeasures%'                          THEN 'AE (fnBWGetAggregateMeasures)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::BwGetValueIdsJob%'                                  THEN 'AE (BwGetValueIdsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::GetLastDocidJob%'                                   THEN 'AE (GetLastDocidJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::AeGetValues%'                                       THEN 'AE (GetValues)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::GetValues%'                                         THEN 'AE (GetValues)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::InvertVecOutJob%'                                   THEN 'AE (InvertVecOutJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::ItabGetValueIdsJob%'                                THEN 'AE (ItabGetValueIdsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::IterateMultipleIntervalsJob%'                       THEN 'AE (IterateMultipleIntervalsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JEJobReadIndexIndividual%'                          THEN 'AE (JEJobReadIndexIndividual)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JeReadValues4ValueIdsJob%'                          THEN 'AE (JeReadValues4ValueIDsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JeReadValueIds4ValuesJob%'                          THEN 'AE (JeReadValueIds4ValuesJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JobReadIndex%'                                      THEN 'AE (JobReadIndex)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JobSparseReadIndexBySearchedDocids%'                THEN 'AE (JobSparseReadIndex)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::JobReadValueIds%'                                   THEN 'AE (JobReadValueIds)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine%LookupDocidsBvProbeJob%'                             THEN 'AE (LookupDocidsBvProbeJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::MultiColumnSemiJoin%'                               THEN 'AE (MultiColumnSemiJoin)'
            WHEN CALLSTACK_CONCAT LIKE '%PatternMatching::ScanJob%'                                           THEN 'AE (PatternMatching ScanJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::RlePredScan%'                                       THEN 'AE (RlePredScan)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::RoDictDefaultPages%'                                THEN 'AE (RoDict)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::RoDictPages%'                                       THEN 'AE (RoDict)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::ScanJob%'                                           THEN 'AE (ScanJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::Evaluator::setNullInputs%'                          THEN 'AE (setNullInputs)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::SortByRowIdJob%'                                    THEN 'AE (SortByRowIdJob)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::ValueArray::%'                                      THEN 'AE (ValueArray)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::ValueArrayColumn%'                                  THEN 'AE (ValueArrayColumn)'
            WHEN CALLSTACK_CONCAT LIKE '%AttributeEngine::XDictData::%'                                       THEN 'AE (XDictData)'
            WHEN CALLSTACK_CONCAT LIKE '%CSWriter::AttributeIndexJobThread::run%'                             THEN 'Attribute Index Job'
            WHEN CALLSTACK_CONCAT LIKE '%TrexCalculationEngine::%'                                            THEN 'Calc Engine'
            WHEN CALLSTACK_CONCAT LIKE '%businessDB::Conversion::%'                                           THEN 'Conversion'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Proc_delete%'                                                 THEN 'Delete'
            WHEN CALLSTACK_CONCAT LIKE '%Hierarchies::PopHierarchyExpressionHNF::executePop%'                 THEN 'PopHierarchyExpressionHNF'
            WHEN CALLSTACK_CONCAT LIKE '%__gmon_start__%'                                                     THEN 'GMON profiling'
            WHEN CALLSTACK_CONCAT LIKE '%SQL::Update::MultiStoreInsert::operatorInternal%'                    THEN 'Insert'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Proc_insert%'                                                 THEN 'Insert'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::CachedPlan::cloneEmptyResult%'                        THEN 'Join Engine (cloneEmptyResult)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JoinEvaluator::getJoinStatistics%'                    THEN 'Join Engine (getJoinStatistics)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::HashReducerJob::doRun%'                               THEN 'Join Engine (HashReducer)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::ItabHashJob::run%'                                    THEN 'Join Engine (ItabHashJob)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::ItabMaterializer%'                                    THEN 'Join Engine (ItabMaterializer)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::ItabUnifyJob::run%'                                   THEN 'Join Engine (ItabUnify)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JECaptureIndex::execute%'                             THEN 'Join Engine (JECaptureIndex)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JECreateNTuple%'                                      THEN 'Join Engine (JECreateNTuple)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEUtils::jeDocIdSearch%'                              THEN 'Join Engine (jeDocIdSearch)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEAssembleResults%'                                   THEN 'Join Engine (JEAssembleResults)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEEvalPrecond%'                                       THEN 'Join Engine (JEEvalPrecond)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPlanData::%'                                        THEN 'Join Engine (JEPlanData)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPlanDataAttrVals%'                                  THEN 'Join Engine (JEPlanDataAttrVals)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPreAggregate%'                                      THEN 'Join Engine (JEPreAggregate)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPrepareData%'                                       THEN 'Join Engine (JEPrepareData)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JERelevance%'                                         THEN 'Join Engine (JERelevance)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JERequestedAttributes%'                               THEN 'Join Engine (JERequestedAttributes)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEStep1%'                                             THEN 'Join Engine (JEStep1)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEStep2%'                                             THEN 'Join Engine (JEStep2)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEStep4%'                                             THEN 'Join Engine (JEStep4)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEUniqueColumn%'                                      THEN 'Join Engine (JEUniqueColumn)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JoinOptimizer::optimize%'                             THEN 'Join Engine (JoinOptimizer)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::LoopJob::runLoopJob%'                                 THEN 'Join Engine (LoopJob)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::LoopWithEqJob::runLoopJob%'                           THEN 'Join Engine (LoopWithEqJob)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::MetaModel::%'                                         THEN 'Join Engine (MetaModel)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::MGetEstimations::run%'                                THEN 'Join Engine (MGetEstimations)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::MNodeFactory::%'                                      THEN 'Join Engine (MNodeFactory)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::NTuple%'                                              THEN 'Join Engine (NTuple)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::PlanCreator::createPlan%'                             THEN 'Join Engine (createPlan)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JoinEvaluator::processPart%'                          THEN 'Join Engine (processPart)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPlanOperationTraceGuard::trace%'                    THEN 'Join Engine (TraceGuard)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::QueryGraph::ready%'                                   THEN 'Join Engine (QueryGraph)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::TranslateMarkJob%'                                    THEN 'Join Engine (TranslateMarkJob)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::TupleList%'                                           THEN 'Join Engine (TupleList)'
            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::QueryInfo::useSinglePartPlanOptimization%'            THEN 'Join Engine (useSinglePartPlanOptimization)'
            WHEN CALLSTACK_CONCAT LIKE '%js::jit::DoGetNameFallback%'                                         THEN 'Name Fallback'
            WHEN CALL_1           LIKE '%OlapEngine::Parallel::WorkerJob::aggregate%'                         THEN 'OLAP Engine (aggregate)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::AvcReader%'                                    THEN 'OLAP Engine (AvcReader)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::OlapAttributeApi::bwGetNextDocumentBlock%'     THEN 'OLAP Engine (bwGetNextDocumentBlock)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::BwPopAggregateParallel%'                       THEN 'OLAP Engine (BWPopAggregateParallel)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::BwPopJoin%'                                              THEN 'OLAP Engine (BWPopJoin)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::BwPopSearch%'                                            THEN 'OLAP Engine (BWPopSearch)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::BwRefTable::%'                                           THEN 'OLAP Engine (BwRefTable)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::ColumnSetterJob::run%'                                   THEN 'OLAP Engine (ColumnSetterJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::CountDistinctCheckForNullJob::run%'            THEN 'OLAP Engine (CountDistinctCheckForNullJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::CountNullsJob::run%'                           THEN 'OLAP Engine (CountNullsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::WorkerJob::createLocalHashMap%'                THEN 'OLAP Engine (createLocalHashMap)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::BwSids::deserialize%'                                    THEN 'OLAP Engine (deserializeBwSids)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::DictZipper%'                                             THEN 'OLAP Engine (DictZipper)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::DimensionBlockBuffer::%'                       THEN 'OLAP Engine (DimensionBlockBuffer)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::DimensionReader%'                              THEN 'OLAP Engine (DimensionReader)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::DimFnHashDataProvider::read%'                  THEN 'OLAP Engine (DimFnHashDataProvider)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::ExprReader::%'                                 THEN 'OLAP Engine (ExprReader)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::GetValueIdsJob%'                               THEN 'OLAP Engine (GetValueIdsJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::OlapAttributeApi::getNextDocumentBlock%'       THEN 'OLAP Engine (getNextDocumentBlock)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::GetSidsAsValuesJob::run%'                                THEN 'OLAP Engine (GetSidsAsValuesJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::HavingJob::run%'                               THEN 'OLAP Engine (HavingJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::Input::getNextBlock%'                          THEN 'OLAP Engine (Input)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::OlapKeyFigureColumn%'                          THEN 'OLAP Engine (KeyFigure)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::LocalResult%'                                  THEN 'OLAP Engine (LocalResult)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::mergeHashTables%'                              THEN 'OLAP Engine (mergeHashTables)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::Merger::%'                                     THEN 'OLAP Engine (Merger)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::MinMaxAggregator%'                             THEN 'OLAP Engine (MinMaxAggregator)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::WorkerJob::nextDocIds%'                        THEN 'OLAP Engine (nextDocIds)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::OlapDataCompressor::%'                                   THEN 'OLAP Engine (OlapDataCompressor)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::PostExprJob::run%'                             THEN 'OLAP Engine (PostExpressions)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::PostWorkerJob%'                                THEN 'OLAP Engine (PostWorkerJob)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::ReadPartsJob%'                                 THEN 'OLAP Engine (ReadParts)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::RenameValIdsJob::run%'                         THEN 'OLAP Engine (RenameValIdsJob)'
            WHEN CALL_1           LIKE '%OlapEngine::Parallel::ResultDocWorker::runEx%'                       THEN 'OLAP Engine (ResultDocWorker)'
            WHEN CALL_2           LIKE '%OlapEngine::Parallel::ResultDocWorker::runEx%'                       THEN 'OLAP Engine (ResultDocWorker)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::RowCountAggregator::%'                         THEN 'OLAP Engine (RowCountAggregator)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::BwSids::serialize%'                                      THEN 'OLAP Engine (serializeBwSids)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::SumAggregator%'                                THEN 'OLAP Engine (SumAggregator)'
            WHEN CALLSTACK_CONCAT LIKE '%OlapEngine::Parallel::TransformDictJob%'                             THEN 'OLAP Engine (TransformDictJob)'
            WHEN CALL_1           LIKE '%OlapEngine::Parallel::WorkerJob::run%'                               THEN 'OLAP Engine (WorkerJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexObjectFactory::createTrexOltpSearchObject%'               THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%ptime::Trex_oltp_search::%'                                          THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%ptime::TrexOltpSearch::%open%'                                       THEN 'OLTP Search'
            WHEN CALL_2           LIKE '%ptime::TrexOltpSearch::%open%'                                       THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%ptime::TrexOltpSearch::queryData%'                                   THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%ptime::TrexOltpSearch::~TrexOltpSearch%'                             THEN 'OLTP Search'
            WHEN CALL_2           LIKE '%ptime::TrexOltpSearch::~TrexOltpSearch%'                             THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%<no_symbol>%' AND CALL_3 LIKE '%ptime::TrexOltpSearch::open%'        THEN 'OLTP Search'
            WHEN CALL_1           LIKE '%Executor::PlanExecutor::doCalculateSingleThreaded%'                  THEN 'Plan Execution (Single Threaded)'
            WHEN CALLSTACK_CONCAT LIKE '%System::ProcessInformation::%'                                       THEN 'Process Information'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexResultIMS::checkErrorOnItab%'                             THEN 'ptime (checkErrorOnItab)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Itab_materializer::create_itab%'                              THEN 'ptime (create_itab)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::EvaluateIntoString%'                                          THEN 'ptime (EvaluateIntoString)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Trex_oltp_search::evaluateLimits%'                            THEN 'ptime (evaluateLimits)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexPredicate::isExistExpression%'                            THEN 'ptime (ExistExpression)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexPlanOp::executePop%'                                      THEN 'ptime (executePop)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ExpressionWrapper::%'                                         THEN 'ptime (ExpressionWrapper)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Query::result_t::fetch%'                                      THEN 'ptime (fetch)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Shared_subtree_materialize::fetch_job%'                       THEN 'ptime (fetch_job)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Trex_oltp_search::fillConditions%'                            THEN 'ptime (fillConditions)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::GroupBy::%'                                                   THEN 'ptime (GroupBy)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::NBaseString::hashCode%'                                       THEN 'ptime (hashCode)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexSearchMeta::hasPHExpression%'                             THEN 'ptime (hasPHExpression)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Trex_oltp_search::initPruningEntries%'                        THEN 'ptime (initPruningEntries)'
            WHEN CALLSTACK_CONCAT LIKE '%IntraOpParallelJob%'                                                 THEN 'ptime (IntraOpParallelJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Itab_materializer::do_open%'                                  THEN 'ptime (Itab_materializer)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Join_hash::%'                                                 THEN 'ptime (Join_hash)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::OrderbyMulti::%'                                              THEN 'ptime (OrderbyMulti)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ParallelInsertJob::run%'                                      THEN 'ptime (ParallelInsertJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ParallelItabInsertJob::run%'                                  THEN 'ptime (ParallelItabInsertJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ParallelSortJob::run%'                                        THEN 'ptime (ParallelSortjob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb::eParameterMetadata%'                       THEN 'ptime (ParameterMetadata)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Window::partition_job%'                                       THEN 'ptime (partition_job)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::RemoteJob::run%'                                              THEN 'ptime (RemoteJob)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ResultColReorderer::reorderItabColumns%'                      THEN 'ptime (reorderItabColumns)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexOltpSearch::setPruningEntries%'                           THEN 'ptime (setPruningEntries)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexResultBase::setResultColOrder%'                           THEN 'ptime (setResultColOrder)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Table_aggr%'                                                  THEN 'ptime (Table_aggr)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Table::close%'                                                THEN 'ptime (Table close)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Trex_oltp_search::initTempTableAccess%'                       THEN 'ptime (TempTable)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexResultIMS::create%'                                       THEN 'ptime (TrexResultIMS)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::BuiltinProcedure_TREXVIADBSL::execute%'                       THEN 'ptime (TREXviaDBSL)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ValueExpression'                                              THEN 'ptime (ValueExpression)'
            WHEN CALLSTACK_CONCAT LIKE '%qo3::Optimizer::evaluate%'                                           THEN 'Query Optimizer'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Search::OptimizerImpl::evaluate%'                           THEN 'Query Optimizer'
            WHEN CALL_1 LIKE '%ptime::ActionExecutor::executeQuery%'                                          THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::PreparedStatement::execute%'                                            THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Session::executeQuery%'                                                 THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Statement::execute%'                                                    THEN 'Statement Execution'
            WHEN CALL_2 LIKE '%ptime::Statement::execute%'                                                    THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Query::_execute%'                                                       THEN 'Statement Execution'
            WHEN CALL_2 LIKE '%ptime::Query::_execute%'                                                       THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Query::result_t::open%'                                                 THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Table::open%'                                                           THEN 'Statement Execution'
            WHEN CALL_2 LIKE '%ptime::Table::open%'                                                           THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%ptime::Project_copy::do_open%'                                                 THEN 'Statement Execution'
            WHEN CALL_1 LIKE '%__strcmp%'                                                                     THEN 'String Compare'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Proc_replace%'                                                THEN 'Replace'
            WHEN CALL_1 LIKE '%ptime::PreparedStatement::getResultSet%'                                       THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::ResultSet::getResultSet%'                                               THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::ResultSet::fetch%'                                                      THEN 'Result Set Handling'
            WHEN CALL_2 LIKE '%ptime::ResultSet::fetch%'                                                      THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::ResultSet::setFetchSize%'                                               THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::ResultSet::throwIfDeferredCancelApplicable%'                            THEN 'Result Set Handling'
            WHEN CALL_2 LIKE '%ptime::ResultSet::throwIfDeferredCancelApplicable%'                            THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::Query::result_t::open%'                                                 THEN 'Result Set Handling'
            WHEN CALL_2 LIKE '%ptime::Query::result_t::open%'                                                 THEN 'Result Set Handling'
            WHEN CALL_1 LIKE '%ptime::Statement::getResultSet%'                                               THEN 'Result Set Handling'
            WHEN CALLSTACK_CONCAT LIKE '%RowEngine::RowTableInsert%'                                          THEN 'Row Store Insert'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Table_cpbtree%'                                               THEN 'Row Store Index'
            WHEN CALL_1 LIKE '%__wcscpy_chk%'                                                                 THEN 'String Copy'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Table::fetch%'                                                THEN 'Table Fetch'
            WHEN CALLSTACK_CONCAT LIKE '%Evaluator::ThreeCode::run%'                                          THEN 'ThreeCode'
            WHEN CALLSTACK_CONCAT LIKE '%Execution::TimerThread::TimerCallback%'                              THEN 'Timer Callback'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TRexApiSearchTableResult::addInternalTable%'                THEN 'TREX (addInternalTable)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::AggregationCache::AggregationCacheInfo%'                    THEN 'TREX (AggregationCache)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::BucketIndexHashMap'                                       THEN 'TREX (BucketIndexHashMap)'
            WHEN CALL_1           LIKE '%TrexNet::BufferedNetInput%'                                          THEN 'TREX (BufferedNetInput)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SearchAPI::checkResultMaterializationDataPresent%'          THEN 'TREX (checkResultMaterialization)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::NetInput::checkType%'                                       THEN 'TREX (checkType)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::ColumnsToDataBufferJob::run%'                               THEN 'TREX (ColumnsToDataBufferJob)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::ConcatUnaryQueryMaker%'                                     THEN 'TREX (ConcatUnaryQueryMaker)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TableUpdateColumns::createNewColumn%'                       THEN 'TREX (createNewColumn)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::DefaultColumnDict%'                               THEN 'TREX (DefaultColumnDict)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::DelayedDeallocation%'                                     THEN 'TREX (DelayedDealloation)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SearchAPI::extractResults%'                                 THEN 'TREX (ExtractResults)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::InternalTableBase::findColumn%'                   THEN 'TREX (findColumn)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::__parallelFor::ForJob%'                         THEN 'TREX (ForJob)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Search::Fragments::Fragments%'                              THEN 'TREX (Fragments)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::FragmentVector%'                                          THEN 'TREX (FragmentVector)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::FragVecColInvertedLists%'                         THEN 'TREX (FragVecColInvertedLists)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::CoreHandler::handle_getFile%'                           THEN 'TREX (getFile)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::GetServiceStopped%'                                       THEN 'TREX (GetServiceStopped)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::CoreHandler::handle_getSimpleStat%'                     THEN 'TREX (getSimpleStat)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::HandleWorkPackages::run%'                         THEN 'TREX (HandleWorkPackages)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::__indexHash%'                                   THEN 'TREX (HashDict)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::HostAndPort%'                                             THEN 'TREX (HostAndPort)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::IndexIds2string%'                                           THEN 'TREX (IndexIds2string)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::IndexVector%'                                             THEN 'TREX (IndexVector)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::InternalTable::%'                                 THEN 'TREX (InternalTable)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::InvIndexJob%'                                     THEN 'TREX (InvIndexJob)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::IndexHashMap%'                                            THEN 'TREX (IndexHashMap)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::DistributedSearchImpl::inlistPruning%'                      THEN 'TREX (inlistPruning)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Search::TableParts::mapToLogicalPartId%'                    THEN 'TREX (mapToLogicalPartId)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::murmur_hash64%'                                           THEN 'TREX (murmur_hash64)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::DistributedSearchImpl::performSearch%'                      THEN 'TREX (performSearch)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::DistributedSearchImpl::prune%'                              THEN 'TREX (prune)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::QueryRuntime::QueryRuntime%'                                THEN 'TREX (QueryRuntime)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Deserializer::readStringExactSize%'                       THEN 'TREX (readStringExactSize)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::Search::TableHandleProxy::replayDeltaLog%'                  THEN 'TREX (replayDeltaLog)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::RequestDispatcher%'                                     THEN 'TREX (RequestDispatcher)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexService::RequestEnder::detach%'                                  THEN 'TREX (RequestEnder)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::Sample::run%'                                     THEN 'TREX (Sample)'
            WHEN CALL_1           LIKE '%TRexAPI::SearchAPI::search%'                                         THEN 'TREX (search)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SearchPartJob::run%'                                        THEN 'TREX (SearchPartJob)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::VariableMem::serializeToContext%'                 THEN 'TREX (serializeToContext)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::SearchAPI::singlePartSearch%'                               THEN 'TREX (singlePartSearch)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexConfig::TmpKeyFigure::%'                                         THEN 'TREX (TmpKeyFigure)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::DML::AdditionalUniqueConstraintChecks::execute%'            THEN 'TREX (UniqueConstraint)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::VectorColumn%'                                    THEN 'TREX (VectorColumn)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexCommonObjects::WrapperMemColumnDictBase%'                        THEN 'TREX (WrapperMemColumnDictBase)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::BufferedNetOutput::writeStringLength%'                      THEN 'TREX (writeStringLength)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexUtils::Parallel::Zipper%'                                        THEN 'TREX (Zipper)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::BufferedNetInput::operator%'                                THEN 'TREXNet (BufferedNetInput)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::HostAndPort%'                                               THEN 'TREXNet (HostAndPort)'
            WHEN CALLSTACK_CONCAT LIKE '%TrexNet::Responder%'                                                 THEN 'TREXNet (Responder)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Proc_update%'                                                 THEN 'Update'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::TableUpdate::%'                                             THEN 'Update'

            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::Mutex::%'                                           THEN 'Mutex Lock'
            WHEN CALLSTACK_CONCAT LIKE '%Synchronization::NonrecursiveMutex::%'                               THEN 'Mutex Lock'

            WHEN CALLSTACK_CONCAT LIKE '%JoinEvaluator::JEPlanOperation::executePop%'                         THEN '!Join Engine'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::TrexOltpSearch%'                                              THEN '!OLTP Search'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Trex_oltp_search%'                                            THEN '!OLTP Search'
            WHEN CALLSTACK_CONCAT LIKE '%Executor::PlanExecutor::doCalculateSingleThreaded%'                  THEN '!Plan Execution (Single Threaded)'
            WHEN CALLSTACK_CONCAT LIKE '%TRexAPI::LateMatColumnSource::getNativeTEMP%'                        THEN '!Result Set Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::getResultSet%'                             THEN '!Result Set Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::ResultSet::%'                                                 THEN '!Result Set Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Statement::getResultSet%'                                     THEN '!Result Set Handling'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::PreparedStatement::execute%'                                  THEN '!Statement Execution (Prepared)'
            WHEN CALLSTACK_CONCAT LIKE '%ptime::Session::executeQuery%'                                       THEN '!Statement Execution'

            WHEN CALLSTACK_CONCAT LIKE '%ptime::SessionCodecNewdb%'                                           THEN '!Connection Handling'

            ELSE '!'
          END CALLSTACK_ACTIVITY
        FROM
          CALLSTACKS
      ) TC
      WHERE
        S.HOST LIKE BI.HOST AND
        TO_VARCHAR(S.PORT) LIKE BI.PORT AND
        S.SERVICE_NAME LIKE BI.SERVICE_NAME AND
        TC.HOST = S.HOST AND
        TC.PORT = S.PORT AND
        ( BI.CONN_ID = -1 OR BI.CONN_ID = T.CONNECTION_ID ) AND
        ( BI.MIN_DURATION_MS = -1 OR T.DURATION_MS >= BI.MIN_DURATION_MS ) AND
        ( BI.THREAD_ID = -1 OR BI.THREAD_ID = TC.THREAD_ID ) AND
        T.HOST = TC.HOST AND
        T.PORT = TC.PORT AND
        T.THREAD_ID = TC.THREAD_ID AND
        T.STATEMENT_HASH LIKE BI.STATEMENT_HASH AND
        T.THREAD_TYPE LIKE BI.THREAD_TYPE AND
        T.THREAD_STATE LIKE BI.THREAD_STATE AND
        TC.CALLSTACK_ACTIVITY LIKE BI.ACTIVITY AND
        T.THREAD_METHOD LIKE BI.THREAD_METHOD AND
        T.THREAD_DETAIL LIKE BI.THREAD_DETAIL AND
        ( BI.EXCLUDE_PHANTOM_THREADS = ' ' OR NOT
          ( T.THREAD_TYPE = 'AgentPingThread'                     AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPeriodicThreadWaitSemaphore'                                  OR
            T.THREAD_TYPE = 'BackupMonitor_TransferThread'        AND T.THREAD_STATE = 'Sleeping'                                                                                                     OR
            T.THREAD_TYPE = 'ChildIOThreads::ErrorStream'         AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE = 'ChildIOThreads::OutputStream'        AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE LIKE 'DPDistributor%'                   AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPCommitTranPersistentDistributorQueueReaderAvailableSemaphore' OR
            T.THREAD_TYPE LIKE 'DPReceiverCleaner%'               AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPersistentTranDataCleanerDataAvailableSemaphore'              OR
            T.THREAD_TYPE LIKE 'DPReceiverWriter%'                AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'DPReceiverInboundQueueEmptyCond'                                OR
            T.THREAD_TYPE = 'Generic'                             AND T.THREAD_STATE = 'Running'                                                                                                      OR
            T.THREAD_TYPE = 'IndexingQueue'                       AND T.THREAD_STATE = 'Sleeping'                                                                                                     OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Network Poll'              AND T.CONNECTION_ID = -1 AND     T.THREAD_METHOD = 'generic'                       OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Network Poll'              AND T.THREAD_METHOD = 'Request prologue'                                           OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Running'                   AND T.THREAD_METHOD = 'TimerCallback_OdmContextCleanup'                            OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPReceiverDispatcherHouseKeepingTaskAvailableSemaphore'         OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPReceiverHouseKeepingTaskAvailableSemaphore'                   OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'MasterQS_hasJobs'                                               OR
            T.THREAD_TYPE = 'JobWorker' AND T.THREAD_STATE = 'Semaphore Wait' AND T.LOCK_NAME = 'hex_WorkerJob_Sleep_Sem' AND T.THREAD_DETAIL LIKE 'Waits for client to fetch or syncs with other workers' OR
            T.THREAD_TYPE = 'JobWorker' AND T.THREAD_STATE = 'Semaphore Wait' AND T.LOCK_NAME = 'hex_WorkersManager_Sleep_Sem' AND T.THREAD_DETAIL LIKE 'waits for client to fetch'                   OR
            T.THREAD_TYPE = 'JobWorker'                           AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'LogBackupQueue'                                                 OR
            T.THREAD_TYPE = 'LogExceptionQueueThread'             AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'AdapterServiceFixedQueueListSemaphore'                          OR
            T.THREAD_TYPE = 'LogRecovery'                         AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'LogRecoveryPointInTimeQueue'                                    OR
            T.THREAD_TYPE = 'MaintenanceThread'                   AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'DPPeriodicThreadWaitSemaphore'                                  OR
            T.THREAD_TYPE = 'Native'                              AND T.THREAD_DETAIL LIKE '%sysv_open_semaphore%'                                                                                    OR
            T.THREAD_TYPE = 'PostCommitExecutor'                  AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'RegularTaskQueueCV'                                             OR
            T.THREAD_TYPE = 'PreprocessorPool'                    AND T.THREAD_STATE = 'Network Poll'                                                                                                 OR
            T.THREAD_TYPE = 'PriPostCommitExecutor'               AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'PrioritizedTaskQueueCV'                                         OR
            T.THREAD_TYPE = 'StatsThread'                         AND T.THREAD_STATE LIKE 'ConditionalVar% Wait'   AND T.LOCK_NAME = 'DPStatsThreadCond'                                              OR
            T.THREAD_TYPE = 'PushBufferIntoReplayThread'          AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: push buffer into replay semaphore'          OR
            T.THREAD_TYPE = 'SecondarySlaveLogPositionSendThread' AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: slave log position send semaphore'          OR
            T.THREAD_TYPE = 'SystemReplicationAsyncLogSender'     AND T.THREAD_STATE = 'Semaphore Wait'            AND T.LOCK_NAME = 'system replication: AsyncLogBufferHandlerQueueSem'              OR
            T.THREAD_TYPE = 'WebDispatcher-Main-Thread'           AND T.THREAD_STATE = 'Running'
          )
        ) AND
        IFNULL(T.LOCK_NAME, '') LIKE BI.LOCK_NAME AND
        UPPER(TC.CALLSTACK_CONCAT) LIKE UPPER(BI.CALLSTACK_PATTERN) AND
        ( BI.ACTIVITY_TYPE = '%' OR
          BI.ACTIVITY_TYPE IN ( 'SYSCALL', 'WAIT' ) AND 
            SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) IN ( 'do_fute', 'io_queu', '__nanos', '__pthre', 'syscall' ) OR
          BI.ACTIVITY_TYPE IN ( 'COMMUNICATION', 'WAIT' ) AND 
          ( SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) IN ( '__GI_ep', '__GI_po', '__epoll', '__libc_', '__poll_', '__read_', '__write' ) OR
            TC.CALLSTACK_CONCAT LIKE '.annobin_fts.c_end%' OR
            TC.CALLSTACK_CONCAT LIKE '.annobin_recv.c%' OR
            TC.CALLSTACK_CONCAT LIKE '.annobin_send.c%'
          ) OR
          BI.ACTIVITY_TYPE = 'CPU' AND 
            SUBSTR(TC.CALLSTACK_CONCAT, 1, 7) NOT IN ( 'do_fute', 'io_queu', '__nanos', '__pthre', 'syscall', '__GI_ep', '__GI_po', '__epoll', '__libc_', '__poll_', '__read_', '__write' ) AND
            TC.CALLSTACK_CONCAT NOT LIKE '.annobin_fts.c_end%' AND
            TC.CALLSTACK_CONCAT NOT LIKE '.annobin_recv.c%' AND
            TC.CALLSTACK_CONCAT NOT LIKE '.annobin_send.c%'
        ) AND
        ( BI.ONLY_ACTIVE_THREADS = ' ' OR T.IS_ACTIVE = 'TRUE' ) AND
        ( BI.ONLY_ACTIVE_CALLSTACKS = ' ' OR TC.IS_ACTIVE = 'TRUE' ) AND
        ( BI.IGNORE_OWN_THREADS = ' ' OR T.CONNECTION_ID != CURRENT_CONNECTION ) AND
        ( BI.IGNORE_IDLE_THREADS = ' ' OR T.THREAD_STATE != 'Job Exec Waiting' ) AND
        ( BI.ONLY_INDEX_HANDLE_CALLSTACKS = ' ' OR EXISTS ( SELECT * FROM INDEX_HANDLE_METHODS IHTC WHERE TC.CALLSTACK_CONCAT LIKE IHTC.METHOD ) AND TC.CALLSTACK_CONCAT NOT LIKE '%TRexConfig::IndexHandle::acquire%' )
      GROUP BY
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HOST')          != 0 THEN T.HOST                         ELSE MAP(BI.HOST,           '%', 'any', BI.HOST)                  END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'PORT')          != 0 THEN TO_VARCHAR(T.PORT)             ELSE MAP(BI.PORT,           '%', 'any', BI.PORT)                  END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SERVICE')       != 0 THEN S.SERVICE_NAME                 ELSE MAP(BI.SERVICE_NAME,   '%', 'any', BI.SERVICE_NAME)          END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CONN_ID')       != 0 THEN TO_VARCHAR(T.CONNECTION_ID)    ELSE MAP(BI.CONN_ID,        -1,  'any', TO_VARCHAR(BI.CONN_ID))   END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_ID')     != 0 THEN TO_VARCHAR(T.THREAD_ID)        ELSE MAP(BI.THREAD_ID,      -1,  'any', TO_VARCHAR(BI.THREAD_ID)) END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ACTIVITY')      != 0 THEN TC.CALLSTACK_ACTIVITY          ELSE MAP(BI.ACTIVITY,       '%', 'any', BI.ACTIVITY)              END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'HASH')          != 0 THEN T.STATEMENT_HASH               ELSE MAP(BI.STATEMENT_HASH, '%', 'any', BI.STATEMENT_HASH)        END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_STATE')  != 0 THEN T.THREAD_STATE                 ELSE MAP(BI.THREAD_STATE,   '%', 'any', BI.THREAD_STATE)          END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_TYPE')   != 0 THEN T.THREAD_TYPE                  ELSE MAP(BI.THREAD_TYPE,    '%', 'any', BI.THREAD_TYPE)           END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_METHOD') != 0 THEN T.THREAD_METHOD                ELSE MAP(BI.THREAD_METHOD,  '%', 'any', BI.THREAD_METHOD)         END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'THREAD_DETAIL') != 0 THEN SUBSTR(T.THREAD_DETAIL, 1, 80) ELSE MAP(BI.THREAD_DETAIL,  '%', 'any', BI.THREAD_DETAIL)         END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOCK_NAME')     != 0 THEN T.LOCK_NAME                    ELSE MAP(BI.LOCK_NAME,      '%', 'any', BI.LOCK_NAME)             END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_1,  SUBSTR(TC.CALL_1,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_2,  SUBSTR(TC.CALL_2,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_3,  SUBSTR(TC.CALL_3,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_4,  SUBSTR(TC.CALL_4,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_5,  SUBSTR(TC.CALL_5,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_6,  SUBSTR(TC.CALL_6,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_7,  SUBSTR(TC.CALL_7,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_8,  SUBSTR(TC.CALL_8,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_9,  SUBSTR(TC.CALL_9,  1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_10, SUBSTR(TC.CALL_10, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_11, SUBSTR(TC.CALL_11, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_12, SUBSTR(TC.CALL_12, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_13, SUBSTR(TC.CALL_13, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_14, SUBSTR(TC.CALL_14, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_15, SUBSTR(TC.CALL_15, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_16, SUBSTR(TC.CALL_16, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_17, SUBSTR(TC.CALL_17, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_18, SUBSTR(TC.CALL_18, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_19, SUBSTR(TC.CALL_19, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_20, SUBSTR(TC.CALL_20, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_21, SUBSTR(TC.CALL_21, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_22, SUBSTR(TC.CALL_22, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_23, SUBSTR(TC.CALL_23, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_24, SUBSTR(TC.CALL_24, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_25, SUBSTR(TC.CALL_25, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_26, SUBSTR(TC.CALL_26, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_27, SUBSTR(TC.CALL_27, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_28, SUBSTR(TC.CALL_28, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_29, SUBSTR(TC.CALL_29, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_30, SUBSTR(TC.CALL_30, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_31, SUBSTR(TC.CALL_31, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_32, SUBSTR(TC.CALL_32, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_33, SUBSTR(TC.CALL_33, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_34, SUBSTR(TC.CALL_34, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_35, SUBSTR(TC.CALL_35, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_36, SUBSTR(TC.CALL_36, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_37, SUBSTR(TC.CALL_37, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_38, SUBSTR(TC.CALL_38, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_39, SUBSTR(TC.CALL_39, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_40, SUBSTR(TC.CALL_40, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_41, SUBSTR(TC.CALL_41, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_42, SUBSTR(TC.CALL_42, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_43, SUBSTR(TC.CALL_43, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_44, SUBSTR(TC.CALL_44, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_45, SUBSTR(TC.CALL_45, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_46, SUBSTR(TC.CALL_46, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_47, SUBSTR(TC.CALL_47, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'CALLSTACK')     != 0 THEN MAP(BI.MAX_CALL_LEN, -1, TC.CALL_48, SUBSTR(TC.CALL_48, 1, BI.MAX_CALL_LEN)) ELSE 'any' END,
        TC.CALLSTACK_CONCAT,
        BI.SHORT_CALLS,
        BI.IGNORE_SYSCALL_THREADS
    )
    GROUP BY
      HOST,
      PORT,
      SERVICE_NAME,
      CONN_ID,
      THREAD_ID,
      DURATION_MS,
      STATEMENT_HASH,
      THREAD_TYPE,
      THREAD_STATE,
      THREAD_METHOD,
      THREAD_DETAIL,
      LOCK_NAME,
      CALLSTACK_ACTIVITY,
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
      CALL_48,
      IGNORE_SYSCALL_THREADS
  )
  WHERE
  ( IGNORE_SYSCALL_THREADS = ' ' OR CALL_1 NOT LIKE 'syscall%' )
)
ORDER BY
  LINE_NO
WITH HINT (IGNORE_PLAN_CACHE)
