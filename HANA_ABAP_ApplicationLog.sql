SELECT

/* 

[NAME]

- HANA_ABAP_ApplicationLog

[DESCRIPTION]

- Overview of ABAP application log details

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Tables BALDAT and BALHDR only available in SAP ABAP environments
- You have to be connected to the SAP<sid> schema otherwise the following error is issued:

  [259]: invalid table name: Could not find table/view BALDAT in schema

- If access to ABAP objects is possible but you cannot log on as ABAP user, you can switch the default schema before executing the command:

  SET SCHEMA SAP<sid>

[VALID FOR]

- Revisions:              all
- Client application:     ABAP

[SQL COMMAND VERSION]

- 2024/01/30:  1.0 (initial version)
- 2024/07/08:  1.1 (ALDATE_DEL included)

[INVOLVED TABLES]

- BALDAT
- BALHDR

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

- MANDT

  ABAP client

  '100'           --> ABAP client 100
  '%'             --> No restriction to ABAP client

- LOG_HANDLE

  Log handle

  '051MdcbC7kQOjfBEG{g8QG' --> Show details for log handle 051MdcbC7kQOjfBEG{g8QG
  '%'                      --> No restriction related to log handle

- RELID

  Application log RELID

  'AL'            --> Display orphan records for RELID AL
  '%'             --> No restriction related to RELID

- OBJECT

  Main object

  'DBACOCKPIT'    --> Display details for main object DBACOCKPIT
  '%'             --> No limitation related to main object

- SUBOBJECT

  Sub object

  'DBA'           --> Display details for sub object DBA
  '%'             --> No restriction related to sub object

- ALUSER

  Application log user

  'DDIC'          --> Display details for application log user DDIC
  '%'             --> No restriction related to application log user

- ALPROG

  Application log program

  'SAPMHTTP'      --> Display details for application log program SAPMHTTP
  '%'             --> No restriction related to application log program

- MIN_ALDATE_DEL

  Minimum threshold for deletion date (in format 'YYYYMMDD')

  '99991231'      --> Display records with an "unlimited" deletion date
  '20240603'      --> Display records with a deletion date of 2024/06/03 or later
  '00000000'      --> No limitation related to the deletion date

[OUTPUT PARAMETERS]

- AL_TIME:         Application log timestamp
- MANDT:           Client
- LOG_HANDLE:      Log handle
- RELID:           Export / import buffer region
- OBJECT:          Object name
- SUBOBJECT:       Sub object name
- ALUSER:          Application log user
- ALPROG:          Application log program
- ALDATE_DEL:      Deletion date
- COUNT:           Number of records
- DIST_HANDLES:    Number of BALHDR entries (distinct log handles)
- ROWS_PER_HANDLE: Average number of BALDAT records per BALHDR entry (log handle)

[EXAMPLE OUTPUT]

---------------------------------------------------------------------------------------------------------------------------------
|MANDT|RELID|OBJECT       |SUBOBJECT       |ALUSER     |ALPROG                          |COUNT     |DIST_HANDLES|ROWS_PER_HANDLE|
---------------------------------------------------------------------------------------------------------------------------------
|100  |AL   |VL10_LOG     |VL10_LOG        |REDWOOD_UTC|RVV50R10C                       |  13490162|      312248|          43.20|
|100  |AL   |VL10_LOG     |VL10_LOG        |REDWOOD_ML |RVV50R10C                       |   9829064|      246953|          39.80|
|100  |AL   |FICA         |MAPAYP          |RW_ITRBRIM |SAPLFKKAKTIV2                   |   9607624|     3202517|           3.00|
|100  |AL   |VL10_LOG     |VL10_LOG        |RW_ITRL    |RVV50R10C                       |   9593817|     1336282|           7.17|
|100  |AL   |NFE          |MONITOR         |REDWOOD_BRT|J_BNFECALLRFC                   |   9150063|     3050021|           3.00|
|100  |AL   |/AIF/LOG     |/FIEDI INV_02_IN|REDWOOD_RTR|/AIF/CL_ENABLER_BASE==========CP|   8858441|     2947553|           3.00|
|100  |AL   |FICA         |MAPAYP          |REDWOOD_ADM|SAPLFKKAKTIV2                   |   7484135|     2494449|           3.00|
|100  |AL   |/AIF/LOG     |/FIEDI INV_02_IN|REDWOOD_UTC|/AIF/CL_ENABLER_BASE==========CP|   7342324|     2447439|           3.00|
|100  |AL   |/AIF/LOG     |/FINCF AC_DOC   |REDWOOD_RTR|/AIF/CL_FILE_PROCESSING=======CP|   7175072|     2215170|           3.23|
|100  |AL   |/AIF/PROC_LOG|                |REDWOOD_RTR|/AIF/PERS_RUN_EXECUTE           |   6659475|     2219825|           3.00|
|100  |AL   |/AIF/PROC_LOG|                |REDWOOD_RTR|RBDAPP01                        |   6633471|     2211157|           3.00|
|100  |AL   |MATU         |                |REDWOOD_PLM|SAPMSSY1                        |   5641526|      149529|          37.72|
|100  |AL   |/AIF/PROC_LOG|                |REDWOOD_OTC|EDOC_BACKGROUND                 |   5568853|     1856283|           3.00|
|100  |AL   |FICA         |MA2600          |RW_ITRBRIM |SAPLFKKAKTIV2                   |   5449117|     1546940|           3.52|
|100  |AL   |VL10_LOG     |VL10_LOG        |REDWOOD_SGT|RVV50R10C                       |   3417222|      321826|          10.61|
|100  |AL   |/AIF/LOG     |/FIEDI INV_02_IN|RW_ITROTC  |/AIF/CL_ENABLER_BASE==========CP|   2818451|      939483|           3.00|
|100  |AL   |/AIF/LOG     |/FIEDI INV_02_IN|RFCADM_SCP |/AIF/CL_ENABLER_BASE==========CP|   2708998|      902996|           3.00|
|100  |AL   |/AIF/LOG     |/AIF/NO_SUB_LOG |REDWOOD_OTC|/AIF/CL_ENABLER_BASE==========CP|   1925735|      489864|           3.93|
|100  |AL   |/AIF/LOG     |/FIEDI INV_02_IN|REDWOOD_OTC|/AIF/CL_ENABLER_BASE==========CP|   1900311|      633437|           3.00|
|100  |AL   |RMRB         |RMRB_IDOC       |REDWOOD_RTR|RBDMANI2                        |   1765369|      588479|           2.99|
---------------------------------------------------------------------------------------------------------------------------------

*/

  AL_TIME,
  MANDT,
  LOG_HANDLE,
  RELID,
  OBJECT,
  SUBOBJECT,
  ALUSER,
  ALPROG,
  LPAD(ALDATE_DEL, 10) ALDATE_DEL,
  LPAD(CNT, 10) "COUNT",
  LPAD(DIST_HANDLES, 12) DIST_HANDLES,
  LPAD(TO_DECIMAL(MAP(DIST_HANDLES, 0, 0, CNT / DIST_HANDLES), 10, 2), 15) ROWS_PER_HANDLE
FROM
( SELECT
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), H.AL_TIME) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(H.AL_TIME, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END AL_TIME,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MANDT')      != 0 THEN D.MANDANT                ELSE MAP(BI.MANDT,      '%', 'any', BI.MANDT)      END MANDT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOG_HANDLE') != 0 THEN D.LOG_HANDLE             ELSE MAP(BI.LOG_HANDLE, '%', 'any', BI.LOG_HANDLE) END LOG_HANDLE,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'RELID')      != 0 THEN D.RELID                  ELSE MAP(BI.RELID,      '%', 'any', BI.RELID)      END RELID,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MAINOBJECT') != 0 THEN IFNULL(H.OBJECT, '')     ELSE MAP(BI.OBJECT,     '%', 'any', BI.OBJECT)     END OBJECT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SUBOBJECT')  != 0 THEN IFNULL(H.SUBOBJECT, '')  ELSE MAP(BI.SUBOBJECT,  '%', 'any', BI.SUBOBJECT)  END SUBOBJECT,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALUSER')     != 0 THEN IFNULL(H.ALUSER, '')     ELSE MAP(BI.ALUSER,     '%', 'any', BI.ALUSER)     END ALUSER,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALPROG')     != 0 THEN IFNULL(H.ALPROG, '')     ELSE MAP(BI.ALPROG,     '%', 'any', BI.ALPROG)     END ALPROG,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALDATE_DEL') != 0 THEN IFNULL(H.ALDATE_DEL, '') ELSE 'any'                                         END ALDATE_DEL,
    COUNT(*) CNT,
    COUNT(DISTINCT(H.LOG_HANDLE)) DIST_HANDLES,
    BI.ORDER_BY
  FROM
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
      MANDT,
      LOG_HANDLE,
      RELID,
      OBJECT,
      SUBOBJECT,
      ALUSER,
      ALPROG,
      MIN_ALDATE_DEL,
      AGGREGATE_BY,
      MAP(TIME_AGGREGATE_BY,
        'NONE',        'YYYY/MM/DD HH24:MI:SS',
        'HOUR',        'YYYY/MM/DD HH24',
        'DAY',         'YYYY/MM/DD (DY)',
        'HOUR_OF_DAY', 'HH24',
        TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
      ORDER_BY
    FROM
    ( SELECT                    /* Modification section */
        'MIN' BEGIN_TIME,                  /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, E-S<seconds>, E-M<minutes>, E-H<hours>, E-D<days>, E-W<weeks>, MIN */
        'MAX' END_TIME,                    /* YYYY/MM/DD HH24:MI:SS timestamp, C, C-S<seconds>, C-M<minutes>, C-H<hours>, C-D<days>, C-W<weeks>, B+S<seconds>, B+M<minutes>, B+H<hours>, B+D<days>, B+W<weeks>, MAX */
        '%' MANDT,
        '%' LOG_HANDLE,
        '%' RELID,
        '%' OBJECT,
        '%' SUBOBJECT,
        '%' ALUSER,
        '%' ALPROG,
        '00000000' MIN_ALDATE_DEL,
        'MANDT, RELID, MAINOBJECT, SUBOBJECT, ALUSER, ALPROG' AGGREGATE_BY,           /* TIME, MANDT, RELID, MAINOBJECT, SUBOBJECT, ALUSER, ALPROG, ALDATE_DEL or comma separated combinations, NONE for no aggregation */
        'NONE' TIME_AGGREGATE_BY,      /* HOUR, DAY, HOUR_OF_DAY or database time pattern, TS<seconds> for time slice, NONE for no aggregation */
        'COUNT' ORDER_BY                /* TIME, COUNT, RELID */
      FROM
        DUMMY
    )
  ) BI,
    BALDAT D LEFT OUTER JOIN
  ( SELECT
      TO_TIMESTAMP(ALDATE || ALTIME, 'YYYYMMDDHH24MISS') AL_TIME,
      *
    FROM
      BALHDR
  ) H ON
      H.MANDANT = D.MANDANT AND
      H.LOG_HANDLE = D.LOG_HANDLE
  WHERE
    TO_VARCHAR(H.AL_TIME, 'YYYYMMDDHH24MISS') BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
    D.MANDANT LIKE BI.MANDT AND
    D.RELID LIKE BI.RELID AND
    IFNULL(H.OBJECT, '') LIKE BI.OBJECT AND
    IFNULL(H.SUBOBJECT, '') LIKE BI.SUBOBJECT AND
    IFNULL(H.ALUSER, '') LIKE BI.ALUSER AND
    IFNULL(H.ALPROG, '') LIKE BI.ALPROG AND
    IFNULL(H.ALDATE_DEL, '') >= BI.MIN_ALDATE_DEL
  GROUP BY
    CASE 
      WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'TIME') != 0 THEN 
        CASE 
          WHEN BI.TIME_AGGREGATE_BY LIKE 'TS%' THEN
            TO_VARCHAR(ADD_SECONDS(TO_TIMESTAMP('2014/01/01 00:00:00', 'YYYY/MM/DD HH24:MI:SS'), FLOOR(SECONDS_BETWEEN(TO_TIMESTAMP('2014/01/01 00:00:00', 
            'YYYY/MM/DD HH24:MI:SS'), H.AL_TIME) / SUBSTR(BI.TIME_AGGREGATE_BY, 3)) * SUBSTR(BI.TIME_AGGREGATE_BY, 3)), 'YYYY/MM/DD HH24:MI:SS')
          ELSE TO_VARCHAR(H.AL_TIME, BI.TIME_AGGREGATE_BY)
        END
      ELSE 'any' 
    END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MANDT')      != 0 THEN D.MANDANT                ELSE MAP(BI.MANDT,      '%', 'any', BI.MANDT)      END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'LOG_HANDLE') != 0 THEN D.LOG_HANDLE             ELSE MAP(BI.LOG_HANDLE, '%', 'any', BI.LOG_HANDLE) END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'RELID')      != 0 THEN D.RELID                  ELSE MAP(BI.RELID,      '%', 'any', BI.RELID)      END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'MAINOBJECT') != 0 THEN IFNULL(H.OBJECT, '')     ELSE MAP(BI.OBJECT,     '%', 'any', BI.OBJECT)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'SUBOBJECT')  != 0 THEN IFNULL(H.SUBOBJECT, '')  ELSE MAP(BI.SUBOBJECT,  '%', 'any', BI.SUBOBJECT)  END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALUSER')     != 0 THEN IFNULL(H.ALUSER, '')     ELSE MAP(BI.ALUSER,     '%', 'any', BI.ALUSER)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALPROG')     != 0 THEN IFNULL(H.ALPROG, '')     ELSE MAP(BI.ALPROG,     '%', 'any', BI.ALPROG)     END,
    CASE WHEN BI.AGGREGATE_BY = 'NONE' OR INSTR(BI.AGGREGATE_BY, 'ALDATE_DEL') != 0 THEN IFNULL(H.ALDATE_DEL, '') ELSE 'any'                                         END,
    BI.ORDER_BY
)
ORDER BY
  MAP(ORDER_BY, 'TIME', AL_TIME) DESC,
  MAP(ORDER_BY, 'COUNT', CNT) DESC,
  MANDT,
  RELID