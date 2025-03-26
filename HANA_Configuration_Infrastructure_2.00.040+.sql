WITH 

/* 

[NAME]

- HANA_Configuration_Infrastructure_2.00.040+

[DESCRIPTION]

- Infrastructure configuration (hosts, disk, network, OS, memory, CPU, ...)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_DISK_USAGE only available starting with SAP HANA 1.00.90
- M_NUMA_NODES available with SAP HANA 2.00.010 and higher
- M_HOST_INFORMATION.CPU_SOCKETS available with SAP HANA 2.00.012.02 and higher
- M_PERSISTENT_MEMORY_VOLUMES available starting with SAP HANA 2.00.030
- M_HOST_RESOURCE_UTILIZATION parameter details available starting with SAP HANA 2.00.040

[VALID FOR]

- Revisions:              >= 2.00.040

[SQL COMMAND VERSION]

- 2017/06/27:  1.0 (initial version)
- 2017/09/22:  1.1 (URL section and hardware manufacturer / model added)
- 2017/10/24:  1.2 (TIMEZONE included)
- 2018/01/07:  1.3 (dedicated 2.00.012.02 version)
- 2019/05/30:  1.4 (consideration of >= 2.00.40 network, memory and I/O parameters in M_HOST_INFORMATION)
- 2019/07/13:  1.5 (dedicated 2.00.040+ version including AVERAGE_ACTIVE_IO_COUNT and OPEN_FILE_COUNT)
- 2019/11/02:  1.6 (adjustments to NOFILE / FILE_COUNT and output format)

[INVOLVED TABLES]

- M_CONFIGURATION_PARAMETER_VALUES
- M_CONNECTIONS
- M_DISKS
- M_DISK_USAGE
- M_HOST_INFORMATION
- M_HOST_RESOURCE_UTILIZATION
- M_NUMA_NODES
- M_SERVICE_REPLICATION
- M_SESSION_CONTEXT
- REMOTE_SOURCES

[INPUT PARAMETERS]

- TIMEZONE

  Used timezone (both for input and output parameters)

  'SERVER'       --> Display times in SAP HANA server time
  'UTC'          --> Display times in UTC time

- PRIMARY_HOSTS_SECTION

  Display of primary hosts information

  'X'             --> Display primary hosts information
  ' '             --> Suppress primary hosts information

- PRIMARY_COMMUNICATION_SECTION

  Display of primary communication information

  'X'             --> Display primary communication information
  ' '             --> Suppress primary communication information

- SYSTEM_REPLICATION_SECTION

  Display of system replication information

  'X'             --> Display system replication information
  ' '             --> Suppress system replication information

- SDA_SECTION

  Display of smart data access information

  'X'             --> Display smart data access information
  ' '             --> Suppress smart data access information

- CLIENTS_SECTION

  Display of clients information

  'X'             --> Display clients information
  ' '             --> Suppress clients information

- URL_SECTION

  Display of XS URL information

  'X'             --> Display XS URL information
  ' '             --> Suppress XS URL information

- EXCLUDE_DEFAULT_PARAMETERS

  Possibility to exclude the display of SAP HANA parameters with default values

  'X'             --> Exclude display of SAP HANA parameters with default values
  ' '             --> No restriction related to SAP HANA parameter display

- MIN_CLIENT_CONNECTIONS

  Minimum number of connections to display clients

  10              --> Only display clients with at least 10 connections to SAP HANA
  -1              --> No restriction related to client connections

    130 MAX_LINE_LENGTH

- MAX_LINE_LENGTH

  Maximum length of output lines

  200             --> Limit output lines to a length of 200 characters
  -1              --> No limitation related to output line length

[OUTPUT PARAMETERS]

- LINE: Output information

[EXAMPLE OUTPUT]

------------------------------------------------------------------------------------------------------------------------------------
|LINE                                                                                                                              |
------------------------------------------------------------------------------------------------------------------------------------
|**********************************                                                                                                |
|* SAP HANA INFRASTRUCTURE REPORT *                                                                                                |
|**********************************                                                                                                |
|                                                                                                                                  |
|Generated with:     SQL: "HANA_Configuration_Infrastructure" (SAP Note 1969700)                                                   |
|Evaluation time:    2017/06/27 09:19:32                                                                                           |
|                                                                                                                                  |
|*****************                                                                                                                 |
|* PRIMARY HOSTS *                                                                                                                 |
|*****************                                                                                                                 |
|                                                                                                                                  |
|HOST                          SID  INST ACTIVE DAEMON START_TIME          TIMEZONE PLATFORM                                       |
|============================= ==== ==== ====== ====== =================== ======== ========                                       |
|saphana1                      C11  00   yes    yes    2017/06/18 01:14:19 UTC      unix                                           |
|                                                                                                                                  |
|HOST                          OS_PPMS_NAME   OS_NAME        KERNEL_VERSION                     OS_USER          NOFILES_LIMIT     |
|============================= ============== ============== ================================== ================ =============     |
|saphana1                      LINUX_X86_64   SLES 11.4      3.0.101-84-default                 c11adm (200292)  1048576           |
|                                                                                                                                  |
|HOST                           CPU_CLOCK CPU_CORES CPU_THREADS CPU_MANUFACTURER    CPU_MODEL                                      |
|============================= ========== ========= =========== =================== ===============================================|
|saphana1                            2501       288         288 GenuineIntel        Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz      |
|                                                                                                                                  |
|HOST                            MEMORY_GB     SWAP_GB                                                                             |
|============================== ========== ===========                                                                             |
|saphana1                            16159           2                                                                             |
|                                                                                                                                  |
|HOST                          HANA_VERSION              BUILD_TIME          BUILD_BRANCH                                          |
|============================= ========================= =================== ===============                                       |
|saphana1                      1.00.122.06.1485334242    2017/01/25 10:00:24 fa/hana1sp12                                          |
|                                                                                                                                  |
|HOST                          NET_DOMAIN               NET_HOSTNAMES                                                              |
|============================= ======================== ===========================================================================|
|saphana1                      ctr.sapcustomer.com      saphana1,saphana1-mgt,saphana1-int,saphana1-nfs,aaabbb-db,saphana1-qor,saph|
|                                                                                                                                  |
|HOST                          NET_PUBLICNAME           NET_REALHOSTNAME                                                           |
|============================= ======================== =========================                                                  |
|saphana1                      111.222.33.44            -                                                                          |
|                                                                                                                                  |
|HOST                          NET_NAMESERVER_BINDINGS                                                                             |
|============================= ====================================================================================================|
|saphana1                      127.0.0.1:30001,127.0.0.2:30001,127.0.0.1:30102,127.0.0.2:30102,111.22.3.44:30102,111.22.3.45:30102,|
|                                                                                                                                  |
|HOST                          DEVICE_ID USAGE_TYPE  FS_TYPE  AVAIL_GB TOT_USED_GB TOT_USED_PCT  USED_GB USED_PCT                  |
|============================= ========= =========== ======= ========= =========== ============ ======== ========                  |
|saphana1                      62490     DATA_BACKUP nfs      12278.00      353.13         2.87   201.74     1.64                  |
|saphana1                      62490     TRACE       nfs      12278.00      353.13         2.87    10.56     0.08                  |
|saphana1                      378651    LOG         xfs       4086.00      632.37        15.47   632.29    15.47                  |
|saphana1                      404741    DATA        xfs      36854.00    27407.44        74.36 15944.36    43.26                  |
|                                                                                                                                  |
|*************************                                                                                                         |
|* PRIMARY COMMUNICATION *                                                                                                         |
|*************************                                                                                                         |
|                                                                                                                                  |
|FILE_NAME           SECTION                              PARAMETER_NAME                LAYER   VALUE                              |
|=================== ==================================== ============================= ======= =============================      |
|global.ini          [communication]                      listeninterface               SYSTEM  .local                             |
|global.ini          [communication]                      tcp_backlog                   SYSTEM  2048                               |
|indexserver.ini     [communication]                      maxchannels                   SYSTEM  40000                              |
|indexserver.ini     [communication]                      maxendpoints                  SYSTEM  40000                              |
|indexserver.ini     [communication]                      signal_recv_timeout           SYSTEM  60000                              |
|indexserver.ini     [communication]                      signal_send_timeout           SYSTEM  60000                              |
|webdispatcher.ini   [communication]                      sslkeystore                   SYSTEM  SAPSSLS.pse                        |
|                                                                                                                                  |
|**********************                                                                                                            |
|* SYSTEM REPLICATION *                                                                                                            |
|**********************                                                                                                            |
|                                                                                                                                  |
|FILE_NAME           SECTION                              PARAMETER_NAME                     VALUE                                 |
|=================== ==================================== ================================== =============================         |
|                                                                                                                                  |
|HOST                          SECONDARY_HOST                SECONDARY_SITE_NAME      SYSTEM_REPLICATION_HOST_NAME_RESOLUTION      |
|============================= ============================= ======================== =======================================      |
|saphana1                      saphana9                      SiteA                    234.567.89.01                                |
|                                                                                                                                  |
|***********                                                                                                                       |
|* CLIENTS *                                                                                                                       |
|***********                                                                                                                       |
|                                                                                                                                  |
|HOST                          IP_ADDRESS      CONNECTIONS APPLICATION_NAME                                                        |
|============================= ============== ============ ==================================================                      |
|saphana1                      123.456.78.901          194 ABAP:C11                                                                |
|saphana2                      123.456.78.902          194 ABAP:C11                                                                |
|saphana3                      123.456.78.903          193 ABAP:C11                                                                |
|                                                                                                                                  |
|*****************                                                                                                                 |
|* END OF REPORT *                                                                                                                 |
|*****************                                                                                                                 |
------------------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT                    /* Modification section */
    'SERVER' TIMEZONE,                              /* SERVER, UTC */
    'X' PRIMARY_HOSTS_SECTION,
    'X' PRIMARY_COMMUNICATION_SECTION,
    'X' SYSTEM_REPLICATION_SECTION,
    'X' SDA_SECTION,
    'X' CLIENTS_SECTION,
    'X' URL_SECTION,
    'X' EXCLUDE_DEFAULT_PARAMETERS,
    10 MIN_CLIENT_CONNECTIONS,
    130 MAX_LINE_LENGTH
  FROM
    DUMMY
),
HOST_INFORMATION AS
( SELECT
    *,
    MAX(LENGTH(HOST)) OVER() HOST_LEN,
    ( SELECT COUNT(DISTINCT(NUMA_NODE_ID)) FROM M_NUMA_NODES N WHERE N.HOST = H.HOST ) NUMA_NODES,
    ( SELECT MAX(ACTIVE_ASYNC_IO_COUNT) FROM M_HOST_RESOURCE_UTILIZATION R WHERE R.HOST = H.HOST ) ASYNC_REQ,
    ( SELECT MAX(OPEN_FILE_COUNT) FROM M_HOST_RESOURCE_UTILIZATION R WHERE R.HOST = H.HOST ) OPEN_FILES_CURRENT,
    ( SELECT SUM(OPEN_FILE_COUNT) FROM M_SERVICE_STATISTICS S WHERE S.HOST = H.HOST) NOFILES_CURRENT
  FROM
  ( SELECT
      HOST,
      MAX(MAP(KEY, 'active', VALUE, '')) ACTIVE,
      MAX(MAP(KEY, 'async_io_limit', VALUE, '')) ASYNC_IO_LIMIT,
      MAX(MAP(KEY, 'build_branch', VALUE, '')) BUILD_BRANCH,
      MAX(MAP(KEY, 'build_cloud_edition', VALUE, '')) BUILD_CLOUD_EDITION,
      MAX(MAP(KEY, 'build_compiler', VALUE, '')) BUILD_COMPILER,
      MAX(MAP(KEY, 'build_gen', VALUE, '')) BUILD_GEN,
      MAX(MAP(KEY, 'build_githash', VALUE, '')) BUILD_GITHASH,
      MAX(MAP(KEY, 'build_githeadcount', VALUE, '')) BUILD_GITHEADCOUNT,
      MAX(MAP(KEY, 'build_gitmergetime', VALUE, '')) BUILD_GITMERGETIME,
      MAX(MAP(KEY, 'build_time', VALUE, '')) BUILD_TIME,
      MAX(MAP(KEY, 'build_version', VALUE, '')) BUILD_VERSION,
      MAX(MAP(KEY, 'build_weekstone', VALUE, '')) BUILD_WEEKSTONE,
      MAX(MAP(KEY, 'container', VALUE, '')) CONTAINER,
      MAX(MAP(KEY, 'cpu_clock', VALUE, '')) CPU_CLOCK,
      MAX(MAP(KEY, 'cpu_cores', VALUE, '')) CPU_CORES,
      MAX(MAP(KEY, 'cpu.cpuidle.intel_idle.max_cstate', VALUE, '')) CPU_MAX_CSTATE,
      MAX(MAP(KEY, 'cpu_manufacturer', VALUE, '')) CPU_MANUFACTURER,
      MAX(MAP(KEY, 'cpu_model', VALUE, '')) CPU_MODEL,
      MAX(MAP(KEY, 'cpu_sockets', VALUE, '')) CPU_SOCKETS,
      MAX(MAP(KEY, 'cpu_summary', VALUE, '')) CPU_SUMMARY,
      MAX(MAP(KEY, 'cpu_threads', VALUE, '')) CPU_THREADS,
      MAX(MAP(KEY, 'crypto_fips_version', VALUE, '')) CRYPTO_FIPS_VERSION,
      MAX(MAP(KEY, 'crypto_provider', VALUE, '')) CRYPTO_PROVIDER,
      MAX(MAP(KEY, 'crypto_provider_version', VALUE, '')) CRYPTO_PROVIDER_VERSION,
      MAX(MAP(KEY, 'daemon_active', VALUE, '')) DAEMON_ACTIVE,
      MAX(MAP(KEY, 'hw_manufacturer', VALUE, '')) HW_MANUFACTURER,
      MAX(MAP(KEY, 'hw_model', VALUE, '')) HW_MODEL,
      MAX(MAP(KEY, 'mem_phys', VALUE, TO_BIGINT(0))) MEM_PHYS,
      MAX(MAP(KEY, 'mem_swap', VALUE, TO_BIGINT(0))) MEM_SWAP,
      MAX(MAP(KEY, 'memory_map_area_limit', VALUE, '')) MEMORY_MAP_AREA_LIMIT,
      MAX(MAP(KEY, 'net.core.somaxconn', VALUE, '')) NET_CORE_SOMAXCONN,
      MAX(MAP(KEY, 'net.ipv4.tcp_max_syn_backlog', VALUE, '')) NET_IPV4_TCP_MAX_SYN_BACKLOG,
      MAX(MAP(KEY, 'net.ipv4.tcp_rmem', VALUE, '')) NET_IPV4_TCP_RMEM,
      MAX(MAP(KEY, 'net.ipv4.tcp_syn_retries', VALUE, '')) NET_IPV4_TCP_SYN_RETRIES,
      MAX(MAP(KEY, 'net.ipv4.tcp_timestamps', VALUE, '')) NET_IPV4_TCP_TIMESTAMPS,
      MAX(MAP(KEY, 'net.ipv4.tcp_tw_recycle', VALUE, '')) NET_IPV4_TCP_TW_RECYCLE,
      MAX(MAP(KEY, 'net.ipv4.tcp_tw_reuse', VALUE, '')) NET_IPV4_TCP_TW_REUSE,
      MAX(MAP(KEY, 'net.ipv4.tcp_wmem', VALUE, '')) NET_IPV4_TCP_WMEM,
      MAX(MAP(KEY, 'net_domain', VALUE, '')) NET_DOMAIN,
      MAX(MAP(KEY, 'net_hostnames', VALUE, '')) NET_HOSTNAMES,
      MAX(MAP(KEY, 'net_ip_addresses', VALUE, '')) NET_IP_ADDRESSES,
      MAX(MAP(KEY, 'net_nameserver_bindings', VALUE, '')) NET_NAMESERVER_BINDINGS,
      MAX(MAP(KEY, 'net_port_ephemeral_max_count', VALUE, '')) NET_PORT_EPHEMERAL_MAX_COUNT,
      MAX(MAP(KEY, 'net_port_ranges', VALUE, '')) NET_PORT_RANGES,
      MAX(MAP(KEY, 'net_port_unreserved_ranges', VALUE, '')) NET_PORT_UNRESERVED_RANGES,
      MAX(MAP(KEY, 'net_publicname', VALUE, '')) NET_PUBLICNAME,
      MAX(MAP(KEY, 'net_publicports', VALUE, '')) NET_PUBLICPORTS,
      MAX(MAP(KEY, 'net_realhostname', VALUE, '')) NET_REALHOSTNAME,
      MAX(MAP(KEY, 'open_file_limit', VALUE, '')) OPEN_FILE_LIMIT,
      MAX(MAP(KEY, 'os_cpe_name', VALUE, '')) OS_CPE_NAME,
      MAX(MAP(KEY, 'os_kernel_version', VALUE, '')) OS_KERNEL_VERSION,
      UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(MAX(MAP(KEY, 'os_cpe_name', VALUE, '')), 'cpe:/o:', ''), 'suse', ''), 
        ':sp', '.'), 'redhat:enterprise_linux', 'RHEL '), 'sles', 'sles '), '_sap:', ''), ':GA', ''), 'server', ''), ':', '')) OS_NAME,
      MAX(MAP(KEY, 'os_ppms_name', VALUE, '')) OS_PPMS_NAME,
      MAX(MAP(KEY, 'os_rlimit_nofile', VALUE, '')) OS_RLIMIT_NOFILE,
      MAX(MAP(KEY, 'os_user', VALUE, '')) OS_USER,
      MAX(MAP(KEY, 'platform', VALUE, '')) PLATFORM,
      MAX(MAP(KEY, 'sap_retrieval_path', VALUE, '')) SAP_RETRIEVAL_PATH,
      MAX(MAP(KEY, 'sap_retrieval_path_shared', VALUE, '')) SAP_RETRIEVAL_PATH_SHARED,
      MAX(MAP(KEY, 'sapsystem', VALUE, '')) SAPSYSTEM,
      MAX(MAP(KEY, 'sid', VALUE, '')) SID,
      MAX(MAP(KEY, 'ssfs_masterkey_changed', VALUE, '')) SSFS_MASTERKEY_CHANGED,
      MAX(MAP(KEY, 'ssfs_masterkey_systempki_changed', VALUE, '')) SSFS_MASTERKEY_SYSTEMPKI_CHANGED,
      MAX(MAP(KEY, 'start_time', VALUE, '')) START_TIME,
      MAX(MAP(KEY, 'timezone_name', VALUE, '')) TIMEZONE_NAME,
      MAX(MAP(KEY, 'timezone_offset', VALUE, '')) TIMEZONE_OFFSET,
      MAX(MAP(KEY, 'topology_mem_info', VALUE, '')) TOPOLOGY_MEM_INFO,
      MAX(MAP(KEY, 'topology_mem_type', VALUE, '')) TOPOLOGY_MEM_TYPE
    FROM
      M_HOST_INFORMATION
    GROUP BY
      HOST
  ) H
),
PMEM_INFORMATION AS
( SELECT
    HOST,
    MAX(LENGTH(HOST)) OVER() HOST_LEN,
    TO_DECIMAL(MAX(TOTAL_SIZE / 1024 / 1024 / 1024), 10, 2) TOTAL_GB,
    TO_DECIMAL(MAX(USED_SIZE / 1024 / 1024 / 1024), 10, 2) USED_GB
  FROM
  ( SELECT
      HOST,
      PORT,
      SUM(TOTAL_SIZE) TOTAL_SIZE,
      SUM(USED_SIZE) USED_SIZE
    FROM
      M_PERSISTENT_MEMORY_VOLUMES
    GROUP BY
      HOST,
      PORT
  )
  GROUP BY
    HOST
),
PRIMARY_COMMUNICATION AS
( SELECT
    P.*,
    GREATEST(9, MAX(LENGTH(P.FILE_NAME)) OVER ()) FILE_LEN,
    GREATEST(14, MAX(LENGTH(P.KEY)) OVER ()) KEY_LEN,
    GREATEST(7, MAX(LENGTH(P.SECTION)) OVER ()) SECTION_LEN
  FROM
    BASIS_INFO BI,
  ( SELECT
      P.FILE_NAME,
      '[' || P.SECTION || ']' SECTION,
      P.KEY,
      P.LAYER_NAME,
      MAX(P.VALUE) VALUE
    FROM
      BASIS_INFO BI,
      M_CONFIGURATION_PARAMETER_VALUES P
    WHERE
    ( P.SECTION = 'communication' OR P.SECTION = 'internal_hostname_resolution' ) AND
      P.FILE_NAME != 'statisticsserver.ini'
    GROUP BY
      P.FILE_NAME,
      P.SECTION,
      P.KEY,
      P.LAYER_NAME
  ) P
  WHERE
  ( BI.EXCLUDE_DEFAULT_PARAMETERS = ' ' OR P.LAYER_NAME != 'DEFAULT' ) AND
    BI.PRIMARY_COMMUNICATION_SECTION = 'X'
),
SYSTEM_REPLICATION AS
( SELECT
    R.*,
    GREATEST(9, MAX(LENGTH(R.FILE_NAME)) OVER ()) FILE_LEN,
    GREATEST(14, MAX(LENGTH(R.KEY)) OVER ()) KEY_LEN,
    GREATEST(7, MAX(LENGTH(R.SECTION)) OVER ()) SECTION_LEN    
  FROM
    BASIS_INFO BI,
  ( SELECT
      FILE_NAME,
      '[' || SECTION || ']' SECTION,
      KEY,
      LAYER_NAME,
      MAX(VALUE) VALUE
    FROM
      M_CONFIGURATION_PARAMETER_VALUES
    WHERE
    ( FILE_NAME = 'global.ini' AND
      SECTION = 'system_replication_communication' AND
      KEY IN ( 'listeninterface', 'enable_ssl', 'allowed_sender' )
    )
    GROUP BY
      FILE_NAME,
      SECTION,
      KEY,
      LAYER_NAME
  ) R
  WHERE
  ( BI.EXCLUDE_DEFAULT_PARAMETERS = ' ' OR LAYER_NAME != 'DEFAULT' ) AND
    BI.SYSTEM_REPLICATION_SECTION = 'X'
),
URLS AS
( SELECT
    U.*,
    GREATEST(9, MAX(LENGTH(U.FILE_NAME)) OVER ()) FILE_LEN,
    GREATEST(14, MAX(LENGTH(U.KEY)) OVER ()) KEY_LEN,
    GREATEST(7, MAX(LENGTH(U.SECTION)) OVER ()) SECTION_LEN    
  FROM
    BASIS_INFO BI,
  ( SELECT
      FILE_NAME,
      '[' || SECTION || ']' SECTION,
      KEY,
      LAYER_NAME,
      MAX(VALUE) VALUE
    FROM
      M_CONFIGURATION_PARAMETER_VALUES
    WHERE
    ( SECTION = 'public_urls' AND
      KEY LIKE 'http%url'
    )
    GROUP BY
      FILE_NAME,
      SECTION,
      KEY,
      LAYER_NAME
  ) U
  WHERE
    BI.URL_SECTION = 'X'
)
SELECT
  MAP(BI.MAX_LINE_LENGTH, -1, LINE, SUBSTR(LINE, 1, BI.MAX_LINE_LENGTH)) LINE
FROM
  BASIS_INFO BI,
( SELECT 1000 LINE_NO, '**********************************' LINE FROM DUMMY UNION ALL
  SELECT 1010,         '* SAP HANA INFRASTRUCTURE REPORT *' FROM DUMMY UNION ALL
  SELECT 1020,         '**********************************' FROM DUMMY UNION ALL
  SELECT 1030,         ''                                   FROM DUMMY UNION ALL
  SELECT 1040,         RPAD('Generated with:', 20)  || 'SQL: "HANA_Configuration_Infrastructure" (SAP Note 1969700)' FROM DUMMY UNION ALL
  SELECT 1050,         RPAD('Evaluation time:', 20) || TO_VARCHAR(CASE TIMEZONE WHEN 'UTC' THEN CURRENT_UTCTIMESTAMP ELSE CURRENT_TIMESTAMP END, 'YYYY/MM/DD HH24:MI:SS') FROM BASIS_INFO UNION ALL
  SELECT 2000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 2010, '*****************' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 2020, '* PRIMARY HOSTS *' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 2030, '*****************' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 2040, ''                  FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 2080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'SID  INST ACTIVE DAEMON START_TIME          TIMEZONE PLATFORM NUMA_NODES' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 2090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '==== ==== ====== ====== =================== ======== ======== ==========' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 2100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(SID, 5) || RPAD(SAPSYSTEM, 5) || RPAD(ACTIVE, 7) || RPAD(DAEMON_ACTIVE, 7) || 
    RPAD(TO_VARCHAR(CASE BI.TIMEZONE WHEN 'UTC' THEN ADD_SECONDS(START_TIME, SECONDS_BETWEEN(CURRENT_TIMESTAMP, CURRENT_UTCTIMESTAMP)) ELSE START_TIME END, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(TIMEZONE_NAME, 9) || RPAD(PLATFORM, 9) || LPAD(IFNULL(TO_VARCHAR(NUMA_NODES), 'n/a'), 10)
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 3000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 3080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'OS_PPMS_NAME   OS_NAME             KERNEL_VERSION                     OS_USER         ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 3090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============== =================== ================================== ================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 3100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(OS_PPMS_NAME, 15) || RPAD(OS_NAME, 20) || RPAD(OS_KERNEL_VERSION, 35) || RPAD(OS_USER, 17)
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 4000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 4080, RPAD('HOST', HOST_LEN) || CHAR(32)   || ' CPU_CLOCK CORES THREADS SOCKETS MAX_CSTATE CPU_MANUFACTURER    CPU_MODEL' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 4090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '========== ===== ======= ======= ========== =================== ===============================================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 4100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(CPU_CLOCK, 10) || LPAD(CPU_CORES, 6) || LPAD(CPU_THREADS, 8) || LPAD(CPU_SOCKETS, 8) || LPAD(CPU_MAX_CSTATE, 11) || CHAR(32) || RPAD(CPU_MANUFACTURER, 20) || CPU_MODEL
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 5000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 5080, RPAD('HOST', HOST_LEN) || CHAR(32)   || ' MEMORY_GB     SWAP_GB HW_MANUFACTURER         HW_MODEL                                       ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 5090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '========== =========== ======================= ===============================================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 5100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(TO_DECIMAL(ROUND(MEM_PHYS / 1024 / 1024 / 1024), 10, 0), 10) || LPAD(TO_DECIMAL(ROUND(MEM_SWAP / 1024 / 1024 / 1024), 10, 0), 12) ||
    CHAR(32) || RPAD(HW_MANUFACTURER, 23) || CHAR(32) || HW_MODEL
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 5500, '' FROM PMEM_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 5580, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'PMEM_TOTAL_GB PMEM_USED_GB' FROM PMEM_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 5590, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============= ============' FROM PMEM_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 5600 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(TOTAL_GB, 13) || CHAR(32) || LPAD(USED_GB, 12)
  FROM
    BASIS_INFO BI,
    PMEM_INFORMATION PI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 6000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 6080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'HANA_VERSION              BUILD_TIME          BUILD_BRANCH   ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 6090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '========================= =================== ===============' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 6100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(BUILD_VERSION, 26) || RPAD(TO_VARCHAR(BUILD_TIME, 'YYYY/MM/DD HH24:MI:SS'), 20) || RPAD(BUILD_BRANCH, 15)
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 7000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 7080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'NET_DOMAIN                     NET_HOSTNAMES                                                                        ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 7090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============================== =====================================================================================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 7100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(NET_DOMAIN, 31) || NET_HOSTNAMES
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 7500, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 7580, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'NET_PUBLICNAME                NET_REALHOSTNAME         ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 7590, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============================= =========================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 7600 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(NET_PUBLICNAME, 30) || RPAD(NET_REALHOSTNAME, 25)
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'NET_NAMESERVER_BINDINGS                                                                             ' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '====================================================================================================' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || NET_NAMESERVER_BINDINGS
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8200, '' FROM BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8280, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'CORE_SOMAXCONN MAX_SYN_BACKLOG TCP_SYN_RETRIES TCP_TIMESTAMPS TCP_TW_RECYCLE TCP_TW_REUSE' FROM HOST_INFORMATION, BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8290, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============== =============== =============== ============== ============== ============' FROM HOST_INFORMATION, BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8300 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(NET_CORE_SOMAXCONN, 14) || LPAD(NET_IPV4_TCP_MAX_SYN_BACKLOG, 16) || LPAD(NET_IPV4_TCP_SYN_RETRIES, 16) ||
    LPAD(NET_IPV4_TCP_TIMESTAMPS, 15) || LPAD(NET_IPV4_TCP_TW_RECYCLE, 15) || LPAD(NET_IPV4_TCP_TW_REUSE, 13)
  FROM
    BASIS_INFO BI,
    ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ),
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8400, '' FROM BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8480, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'TCP_RMEM                      TCP_WMEM                      EPHEMERAL_PORTS MEMORY_MAP_LIMIT' FROM HOST_INFORMATION, BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8490, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============================= ============================= =============== ================' FROM HOST_INFORMATION, BASIS_INFO, ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ) WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8500 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(NET_IPV4_TCP_RMEM, 30) || RPAD(NET_IPV4_TCP_WMEM, 30) || LPAD(NET_PORT_EPHEMERAL_MAX_COUNT, 15) || LPAD(MEMORY_MAP_AREA_LIMIT, 17)
  FROM
    BASIS_INFO BI,
    ( SELECT TOP 1 VALUE FROM M_HOST_INFORMATION WHERE KEY = 'net.ipv4.tcp_max_syn_backlog' ),
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8600, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8680, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'NOFILES_LIMIT NOFILES     OPEN_FILE_LIMIT OPEN_FILES        ASYNC_IO_LIMIT ASYNC_IOS' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 8690, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============= ======= =================== ========== ===================== =========' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 8700 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || LPAD(OS_RLIMIT_NOFILE, 13) || LPAD(NOFILES_CURRENT, 8) || LPAD(OPEN_FILE_LIMIT, 20) || LPAD(OPEN_FILES_CURRENT, 11) || LPAD(ASYNC_IO_LIMIT, 22) || 
    LPAD(ASYNC_REQ, 10)
  FROM
    BASIS_INFO BI,
    HOST_INFORMATION HI
  WHERE
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 9000, '' FROM BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 9080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'DEVICE_ID USAGE_TYPE     FS_TYPE  AVAIL_GB TOT_USED_GB TOT_USED_PCT  USED_GB USED_PCT' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 9090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '========= ============== ======= ========= =========== ============ ======== ========' FROM HOST_INFORMATION, BASIS_INFO WHERE PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT 9100 + ROW_NUMBER() OVER (ORDER BY D.HOST, D.DEVICE_ID, D.USAGE_TYPE), RPAD(D.HOST, HOST_LEN) || CHAR(32) || RPAD(D.DEVICE_ID, 10) || RPAD(D.USAGE_TYPE, 15) || RPAD(D.FILESYSTEM_TYPE, 8) ||
    LPAD(TO_DECIMAL(D.TOTAL_SIZE / 1024 / 1024 / 1024, 10, 2), 9) || LPAD(TO_DECIMAL(D.USED_SIZE / 1024 / 1024 / 1024, 10, 2), 12) ||
    LPAD(TO_DECIMAL(MAP(D.TOTAL_SIZE, 0, 0, D.USED_SIZE / D.TOTAL_SIZE * 100), 10, 2), 13) ||
    LPAD(MAP(DU.USED_SIZE, -1, 'n/a', TO_VARCHAR(TO_DECIMAL(DU.USED_SIZE / 1024 / 1024 / 1024, 10, 2))), 9) ||
    LPAD(MAP(DU.USED_SIZE, -1, 'n/a', TO_VARCHAR(TO_DECIMAL(MAP(D.TOTAL_SIZE, 0, 0, DU.USED_SIZE / D.TOTAL_SIZE * 100), 10, 2))), 9)
  FROM
    ( SELECT TOP 1 HOST_LEN FROM HOST_INFORMATION ) H,
    BASIS_INFO BI,
    M_DISKS D,
    M_DISK_USAGE DU
  WHERE
    ( D.HOST = '<all>' OR D.HOST = DU.HOST ) AND
    D.USAGE_TYPE = DU.USAGE_TYPE AND
    BI.PRIMARY_HOSTS_SECTION = 'X' UNION ALL
  SELECT TOP 1 10000, ''                          FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10010, '*************************' FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10020, '* PRIMARY COMMUNICATION *' FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10030, '*************************' FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10040, ''                          FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10080, RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME', KEY_LEN) || CHAR(32) || 'LAYER    VALUE                        ' FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT TOP 1 10090, RPAD('=', FILE_LEN, '=')    || CHAR(32) || RPAD('=', SECTION_LEN, '=')  || CHAR(32) || RPAD('=', KEY_LEN, '=')         || CHAR(32) || '======== =============================' FROM PRIMARY_COMMUNICATION UNION ALL
  SELECT 10100 + ROW_NUMBER() OVER (ORDER BY FILE_NAME, SECTION, KEY) / 100, RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) || 
    RPAD(LAYER_NAME, 8) || CHAR(32) || VALUE FROM PRIMARY_COMMUNICATION
  UNION ALL
  SELECT TOP 1 11000, '' FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11010, '**********************' FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11020, '* SYSTEM REPLICATION *' FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11030, '**********************' FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11040, ''                       FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11080, RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME', KEY_LEN) || CHAR(32) || 'VALUE                        ' FROM SYSTEM_REPLICATION UNION ALL
  SELECT TOP 1 11090, RPAD('=', FILE_LEN, '=')    || CHAR(32) || RPAD('=', SECTION_LEN, '=')  || CHAR(32) || RPAD('=', KEY_LEN, '=')         || CHAR(32) || '=============================' FROM SYSTEM_REPLICATION UNION ALL
  SELECT 11100 + ROW_NUMBER() OVER (ORDER BY FILE_NAME, SECTION, KEY), RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) || VALUE FROM
    SYSTEM_REPLICATION 
  UNION ALL
  SELECT 12000, '' FROM BASIS_INFO WHERE SYSTEM_REPLICATION_SECTION = 'X' UNION ALL
  SELECT TOP 1 12080, RPAD('HOST', HOST_LEN) || CHAR(32)   || 'SECONDARY_HOST                REP_MODE SECONDARY_SITE_NAME           SYSTEM_REPLICATION_HOST_NAME_RESOLUTION' FROM HOST_INFORMATION, BASIS_INFO WHERE SYSTEM_REPLICATION_SECTION = 'X' UNION ALL
  SELECT TOP 1 12090, RPAD('=', HOST_LEN, '=') || CHAR(32) || '============================= ======== ============================= =======================================' FROM HOST_INFORMATION, BASIS_INFO WHERE SYSTEM_REPLICATION_SECTION = 'X' UNION ALL
  SELECT 12100 + ROW_NUMBER() OVER (ORDER BY HOST), RPAD(HOST, HOST_LEN) || CHAR(32) || RPAD(SECONDARY_HOST, 30) || RPAD(REPLICATION_MODE, 8) || CHAR(32) || RPAD(SECONDARY_SITE_NAME, 30) || RPAD(SYSTEM_REPLICATION_HOST_NAME_RESOLUTION, 38) FROM
    BASIS_INFO BI,
    ( SELECT TOP 1 HOST_LEN FROM HOST_INFORMATION ) H,
  ( SELECT
      R.HOST,
      R.REPLICATION_MODE,
      R.SECONDARY_HOST,
      R.SECONDARY_SITE_NAME,
      IFNULL(H.SYSTEM_REPLICATION_HOST_NAME_RESOLUTION, 'n/a') SYSTEM_REPLICATION_HOST_NAME_RESOLUTION
    FROM
    ( SELECT DISTINCT
        HOST,
        REPLICATION_MODE,
        SECONDARY_HOST,
        SECONDARY_SITE_NAME
      FROM
        M_SERVICE_REPLICATION
      GROUP BY
        HOST,
        REPLICATION_MODE,
        SECONDARY_HOST,
        SECONDARY_SITE_NAME
    ) R LEFT OUTER JOIN
    ( SELECT DISTINCT
        VALUE HOST,
        KEY SYSTEM_REPLICATION_HOST_NAME_RESOLUTION
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE
        SECTION = 'system_replication_hostname_resolution' AND
        LAYER_NAME != 'DEFAULT'
    ) H ON
      R.SECONDARY_HOST = H.HOST
  )
  WHERE
    BI.SYSTEM_REPLICATION_SECTION = 'X' UNION ALL
  SELECT 13000, '' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13010, '*********************' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13020, '* SMART DATA ACCESS * (only sources with explicit host / port configuration)' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13030, '*********************' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13040, ''                      FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13080, 'HOST                            PORT ADAPTER_NAME                  REMOTE_SOURCE_NAME                                ' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13090, '============================= ====== ============================= ==================================================' FROM BASIS_INFO, ( SELECT TOP 1 * FROM REMOTE_SOURCES ) WHERE SDA_SECTION = 'X' UNION ALL
  SELECT 13100 + ROW_NUMBER() OVER (ORDER BY HOST, PORT), RPAD(HOST, 30) || LPAD(PORT, 6) || CHAR(32) || RPAD(ADAPTER_NAME, 30) || RPAD(REMOTE_SOURCE_NAME, 50) FROM
    BASIS_INFO BI,
  ( SELECT
      REMOTE_SOURCE_NAME,
      ADAPTER_NAME,
      SUBSTR(HOST_HELPER, 1, LOCATE(HOST_HELPER, '<') - 1) HOST,
      SUBSTR(PORT_HELPER, 1, LOCATE(PORT_HELPER, '<') - 1) PORT
    FROM
    ( SELECT
        REMOTE_SOURCE_NAME,
        ADAPTER_NAME,
        SUBSTR(CONNECTION_INFO, GREATEST(LOCATE(CONNECTION_INFO, '<PropertyEntry name="pds_server_name">') + 38, LOCATE(CONNECTION_INFO, '<PropertyEntry name="pds_host_name">') + 36)) HOST_HELPER,
        SUBSTR(CONNECTION_INFO, LOCATE(CONNECTION_INFO, '<PropertyEntry name="pds_port_number">') + 38) PORT_HELPER
      FROM
        REMOTE_SOURCES
      WHERE
        LOCATE(CONNECTION_INFO, '<PropertyEntry name="pds_port_number">') > 0
      UNION ALL
      SELECT
        REMOTE_SOURCE_NAME,
        ADAPTER_NAME,
        SUBSTR(CONNECTION_INFO, GREATEST(LOCATE(CONNECTION_INFO, '<PropertyEntry name="server">') + 29, LOCATE(CONNECTION_INFO, '<PropertyEntry name="host">') + 27)) HOST_HELPER,
        SUBSTR(CONNECTION_INFO, LOCATE(CONNECTION_INFO, '<PropertyEntry name="port">') + 27) PORT_HELPER
      FROM
        REMOTE_SOURCES
      WHERE
        LOCATE(CONNECTION_INFO, '<PropertyEntry name="port">') > 0
    )
    UNION ALL
    SELECT /* CommLinks=tcpip(host=<host_name>:<port>) or CommLinks=tcpip(host=<host_name>[semi-colon]port=<port>) */
      REMOTE_SOURCE_NAME,
      ADAPTER_NAME,
      SUBSTR(HOST_PORT_HELPER, 1, MAP(LOCATE(HOST_PORT_HELPER, ':'), 0, LOCATE(HOST_PORT_HELPER, CHAR(59) || 'port='), LOCATE(HOST_PORT_HELPER, ':')) - 1) HOST,
      SUBSTR(HOST_PORT_HELPER, MAP(LOCATE(HOST_PORT_HELPER, ':'), 0, LOCATE(HOST_PORT_HELPER, CHAR(59) || 'port=') + 5, LOCATE(HOST_PORT_HELPER, ':')) + 1, 
        LOCATE(HOST_PORT_HELPER, ')') - MAP(LOCATE(HOST_PORT_HELPER, ':'), 0, LOCATE(HOST_PORT_HELPER, CHAR(59) || 'port=') + 5, LOCATE(HOST_PORT_HELPER, ':')) - 1) PORT
    FROM
    ( SELECT
        REMOTE_SOURCE_NAME,
        ADAPTER_NAME,
        SUBSTR(CONNECTION_INFO, LOCATE(CONNECTION_INFO, 'CommLinks=tcpip(') + 21) HOST_PORT_HELPER
      FROM
        REMOTE_SOURCES
      WHERE
        LOCATE(CONNECTION_INFO, 'CommLinks=tcpip(host=') > 0
    )
  ) R 
  WHERE
    BI.SDA_SECTION = 'X' UNION ALL
  SELECT 14000, '' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14010, '***********' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14020, '* CLIENTS *' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14030, '***********' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14040, ''            FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14080, 'HOST                                                   IP_ADDRESS      CONNECTIONS APPLICATION_NAME                                  ' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14090, '====================================================== ============== ============ ==================================================' FROM BASIS_INFO WHERE CLIENTS_SECTION = 'X' UNION ALL
  SELECT 14100 + ROW_NUMBER() OVER (ORDER BY CONNECTIONS DESC, HOST), RPAD(HOST, 54) || CHAR(32) || RPAD(CLIENT_IP, 15) || 
    LPAD(CONNECTIONS, 12) || CHAR(32) || IFNULL(APPLICATION_NAME, '-- historic --') FROM
  ( SELECT
      C.CLIENT_HOST HOST,
      C.CLIENT_IP,
      SC.VALUE APPLICATION_NAME,
      COUNT(*) CONNECTIONS
    FROM
      BASIS_INFO BI INNER JOIN
      M_CONNECTIONS C ON
        1 = 1 LEFT OUTER JOIN
      M_SESSION_CONTEXT SC ON
        C.HOST = SC.HOST AND
        C.PORT = SC.PORT AND
        C.CONNECTION_ID = SC.CONNECTION_ID AND
        SC.KEY = 'APPLICATION'
    WHERE
      BI.CLIENTS_SECTION = 'X' AND
      C.CLIENT_HOST != ''
    GROUP BY
      C.CLIENT_HOST,
      C.CLIENT_IP,
      SC.VALUE,
      BI.MIN_CLIENT_CONNECTIONS
    HAVING COUNT(*) >= BI.MIN_CLIENT_CONNECTIONS
  )  UNION ALL
  SELECT TOP 1 15000, ''         FROM URLS UNION ALL
  SELECT TOP 1 15010, '********' FROM URLS UNION ALL
  SELECT TOP 1 15020, '* URLS *' FROM URLS UNION ALL
  SELECT TOP 1 15030, '********' FROM URLS UNION ALL
  SELECT TOP 1 15040, ''         FROM URLS UNION ALL
  SELECT TOP 1 15080, RPAD('FILE_NAME', FILE_LEN) || CHAR(32) || RPAD('SECTION', SECTION_LEN) || CHAR(32) || RPAD('PARAMETER_NAME', KEY_LEN) || CHAR(32) || 'LAYER    VALUE                                  ' FROM URLS UNION ALL
  SELECT TOP 1 15090, RPAD('=', FILE_LEN, '=')    || CHAR(32) || RPAD('=', SECTION_LEN, '=')  || CHAR(32) || RPAD('=', KEY_LEN, '=')         || CHAR(32) || '======== =======================================' FROM URLS UNION ALL
  SELECT 15100 + ROW_NUMBER() OVER (ORDER BY FILE_NAME, SECTION, KEY) / 100, RPAD(FILE_NAME, FILE_LEN) || CHAR(32) || RPAD(SECTION, SECTION_LEN) || CHAR(32) || RPAD(KEY, KEY_LEN) || CHAR(32) ||
    RPAD(LAYER_NAME, 8) || CHAR(32) || VALUE FROM URLS
  UNION ALL
  SELECT 99000, '' FROM DUMMY UNION ALL
  SELECT 99010, '*****************' FROM DUMMY UNION ALL
  SELECT 99020, '* END OF REPORT *' FROM DUMMY UNION ALL
  SELECT 99030, '*****************' FROM DUMMY
)
ORDER BY
  LINE_NO