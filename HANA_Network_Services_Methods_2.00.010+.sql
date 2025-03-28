SELECT
/* 

[NAME]

- HANA_Network_Services_Methods_2.00.010+

[DESCRIPTION]

- Service network communication including method names

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_SERVICE_NETWORK_METHOD_IO available with SAP HANA >= 2.00.010
- M_SERVICE_NETWORK_METHOD_IO is only populated with data when the following parameter is set (default: false):

  global.ini -> [resource_tracking] -> service_network_method_io_enabled = true 

- RESET can be performed via:

  ALTER SYSTEM RESET MONITORING VIEW M_SERVICE_NETWORK_METHOD_IO_RESET

[VALID FOR]

- Revisions:              >= 2.00.010

[SQL COMMAND VERSION]

- 2023/10/04:  1.0 (initial version)

[INVOLVED TABLES]

- M_SERVICE_NETWORK_METHOD_IO

[INPUT PARAMETERS]

- SENDER_HOST

  Sender host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- SENDER_PORT

  Sender port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- RECEIVER_HOST

  Receiver host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- RECEIVER_PORT

  Receiver port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports- CONN_ID

- INTER_HOST_COMMUNICATION

  Controls if communication between different hosts is displayed

  'X'             --> Include communication between different hosts
  ' '             --> Exclude communication between different hosts

- INTRA_HOST_COMMUNICATION

  Controls if communication within one host is displayed

  'X'             --> Include communication within one host
  ' '             --> Exclude communication within one host

- THREAD_METHOD

  Thread method

  '__sessionRequest' --> Show details for thread method __sessionRequest
  '%'                --> No restriction related to thread method

- OPERATOR

  Operator

  'RowPlanOperator' --> Show details for operator RowPlanOperator
  '%'               --> No restriction related to operator

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'RESET'         --> Data from reset information (*_RESET tables)

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'SENDER_HOST'                  --> Aggregation by sender host
  'RECEIVER_HOST, RECEIVER_PORT' --> Aggregation by receiver host and receiver port
  'NONE'                         --> No aggregation

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'COUNT'         --> Sorting by request count
  'HOST'          --> Sorting by host and port

[OUTPUT PARAMETERS]

- SEND_HOST:       Sender host
- SEND_PORT:       Sender port
- RECEIVE_HOST:    Receiver host
- RECEIVE_PORT:    Receiver port
- SEND_GB:         Amount of data sent (GB)
- REC_GB:          Amount of data received (GB)
- REQUESTS:        Total number of requests
- AVG_SEND_KB:     Average size of sent data (KB)
- AVG_REC_KB:      Average size of received data (KB)
- THREAD_METHOD:   Thread method
- OPERATOR:        Operator

[EXAMPLE OUTPUT]

Output truncated at 10 lines.
----------------------------------------------------------------------------------------------------------------------------------------------------------------
|SEND_HOST|SEND_PORT|RECEIVE_HOST|RECEIVE_PORT|SEND_GB |REC_GB  |REQUESTS  |AVG_SEND_KB|AVG_REC_KB|THREAD_METHOD                               |OPERATOR       |
----------------------------------------------------------------------------------------------------------------------------------------------------------------
|any      |    30001|any         |       40002|    0.05|    9.35|     52221|       1.11|    187.78|dr_forwardStatisticsMonitor                 |               |
|any      |    30001|any         |       40002|    0.00|    0.00|     15985|       0.43|      0.28|dr_getservers                               |               |
|any      |    30001|any         |       30001|    0.01|    1.51|     11747|       1.09|    135.67|dr_forwardStatisticsMonitor                 |               |
|any      |    30001|any         |       30001|    0.00|    0.00|      8607|       0.56|      0.22|__sessionRequest                            |               |
|any      |    30001|any         |       30003|    0.00|    0.00|      7890|       0.56|      0.23|__sessionRequest                            |               |
|any      |    30001|any         |       30001|    0.00|    0.00|      3943|       1.19|      0.44|Configuration.ConfigMgr/GetConfigurationHost|               |
|any      |    30001|any         |       40002|    0.00|    0.00|      3812|       0.33|      0.19|dr_secondaryactivestatus                    |               |
|any      |    30001|any         |       30001|    0.00|    0.00|      3368|       1.00|      0.37|pers/getreplicationstatus                   |               |
|any      |    30001|any         |       30001|    0.00|    0.01|      2853|       1.09|      5.24|dr_forwardStatisticsMonitor                 |RowPlanOperator|
|any      |    30002|any         |       30001|    0.00|    0.00|      2211|       0.36|      0.06|Queue Master                                |               |
----------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  SEND_HOST,
  SEND_PORT,
  RECEIVE_HOST,
  RECEIVE_PORT,
  LPAD(TO_DECIMAL(SEND_SIZE / 1024 / 1024 / 1024, 10, 2), 8) SEND_GB,
  LPAD(TO_DECIMAL(RECEIVE_SIZE / 1024 / 1024 / 1024, 10, 2), 8) REC_GB,
  LPAD(REQUEST_COUNT, 10) REQUESTS,
  LPAD(TO_DECIMAL(MAP(REQUEST_COUNT, 0, 0, SEND_SIZE / 1024 / REQUEST_COUNT), 10, 2), 11) AVG_SEND_KB,
  LPAD(TO_DECIMAL(MAP(REQUEST_COUNT, 0, 0, RECEIVE_SIZE / 1024 / REQUEST_COUNT), 10, 2), 10) AVG_REC_KB,
  THREAD_METHOD,
  OPERATOR
FROM
( SELECT
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'SENDER_HOST')   != 0 THEN SN.SENDER_HOST             ELSE MAP(BI.SENDER_HOST, '%', 'any', BI.SENDER_HOST)     END SEND_HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'SENDER_PORT')   != 0 THEN LPAD(SN.SENDER_PORT, 9)    ELSE MAP(BI.SENDER_PORT, '%', 'any', BI.SENDER_PORT)     END SEND_PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'RECEIVER_HOST') != 0 THEN SN.RECEIVER_HOST           ELSE MAP(BI.RECEIVER_HOST, '%', 'any', BI.RECEIVER_HOST) END RECEIVE_HOST,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'RECEIVER_PORT') != 0 THEN LPAD(SN.RECEIVER_PORT, 12) ELSE MAP(BI.RECEIVER_PORT, '%', 'any', BI.RECEIVER_PORT) END RECEIVE_PORT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'METHOD')        != 0 THEN SN.THREAD_METHOD           ELSE MAP(BI.THREAD_METHOD, '%', 'any', BI.THREAD_METHOD) END THREAD_METHOD,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'OPERATOR')      != 0 THEN SN.OPERATOR                ELSE MAP(BI.OPERATOR, '%', 'any', BI.OPERATOR)           END OPERATOR,
    SUM(SN.SEND_SIZE) SEND_SIZE,
    SUM(SN.RECEIVE_SIZE) RECEIVE_SIZE,
    SUM(SN.REQUEST_COUNT) REQUEST_COUNT,
    BI.ORDER_BY
  FROM
  ( SELECT                            /* Modification section */
      '%' SENDER_HOST,
      '%' SENDER_PORT,
      '%' RECEIVER_HOST,
      '%' RECEIVER_PORT,
      'X' INTER_HOST_COMMUNICATION,
      'X' INTRA_HOST_COMMUNICATION,
      '%' THREAD_METHOD,
      '%' OPERATOR, 
      'RESET' DATA_SOURCE,          /* CURRENT, RESET */
      'NONE' AGGREGATE_BY,            /* SENDER_HOST, SENDER_PORT, RECEIVER_HOST, RECEIVER_PORT, METHOD, OPERATOR or comma-separated combination, NONE for no aggregation */
      'COUNT' ORDER_BY                    /* COUNT, SEND_SIZE, RECEIVE_SIZE, HOST, METHOD, OPERATOR */
    FROM
      DUMMY
  ) BI,
  ( SELECT
      'CURRENT' DATA_SOURCE,
      SENDER_HOST,
      SENDER_PORT,
      RECEIVER_HOST,
      RECEIVER_PORT,
      SEND_SIZE,
      RECEIVE_SIZE,
      REQUEST_COUNT,
      THREAD_METHOD,
      OPERATOR
    FROM
      M_SERVICE_NETWORK_METHOD_IO
    UNION ALL
    SELECT
      'RESET' DATA_SOURCE,
      SENDER_HOST,
      SENDER_PORT,
      RECEIVER_HOST,
      RECEIVER_PORT,
      SEND_SIZE,
      RECEIVE_SIZE,
      REQUEST_COUNT,
      THREAD_METHOD,
      OPERATOR
    FROM
      M_SERVICE_NETWORK_METHOD_IO_RESET
  ) SN
  WHERE
    SN.SENDER_HOST LIKE BI.SENDER_HOST AND
    TO_VARCHAR(SN.SENDER_PORT) LIKE BI.SENDER_PORT AND
    SN.RECEIVER_HOST LIKE BI.RECEIVER_HOST AND
    TO_VARCHAR(SN.RECEIVER_PORT) LIKE BI.RECEIVER_PORT AND
    SN.THREAD_METHOD LIKE BI.THREAD_METHOD AND
    SN.OPERATOR LIKE BI.OPERATOR AND
    SN.DATA_SOURCE = BI.DATA_SOURCE AND
    ( BI.INTER_HOST_COMMUNICATION = 'X' AND SN.SENDER_HOST != SN.RECEIVER_HOST OR
      BI.INTRA_HOST_COMMUNICATION = 'X' AND SN.SENDER_HOST = SN.RECEIVER_HOST
    )
  GROUP BY
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'SENDER_HOST')   != 0 THEN SN.SENDER_HOST             ELSE MAP(BI.SENDER_HOST, '%', 'any', BI.SENDER_HOST)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'SENDER_PORT')   != 0 THEN LPAD(SN.SENDER_PORT, 9)    ELSE MAP(BI.SENDER_PORT, '%', 'any', BI.SENDER_PORT)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'RECEIVER_HOST') != 0 THEN SN.RECEIVER_HOST           ELSE MAP(BI.RECEIVER_HOST, '%', 'any', BI.RECEIVER_HOST) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'RECEIVER_PORT') != 0 THEN LPAD(SN.RECEIVER_PORT, 12) ELSE MAP(BI.RECEIVER_PORT, '%', 'any', BI.RECEIVER_PORT) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'METHOD')        != 0 THEN SN.THREAD_METHOD           ELSE MAP(BI.THREAD_METHOD, '%', 'any', BI.THREAD_METHOD) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR LOCATE(BI.AGGREGATE_BY, 'OPERATOR')      != 0 THEN SN.OPERATOR                ELSE MAP(BI.OPERATOR, '%', 'any', BI.OPERATOR)           END,
    BI.ORDER_BY
)
ORDER BY
  MAP(ORDER_BY, 'COUNT', REQUEST_COUNT, 'SEND_SIZE', SEND_SIZE, 'RECEIVE_SIZE', RECEIVE_SIZE) DESC,
  MAP(ORDER_BY, 'METHOD', THREAD_METHOD, 'OPERATOR', OPERATOR),
  SEND_HOST,
  SEND_PORT,
  RECEIVE_HOST,
  RECEIVE_PORT