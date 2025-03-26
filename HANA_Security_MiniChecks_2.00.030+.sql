WITH 
/* 

[NAME]

- HANA_Security_MiniChecks_2.00.030+

[DESCRIPTION]

- Security related check list

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Checks are related to SAP HANA Security Checklists and Recommendations:

  https://help.sap.com/viewer/742945a940f240f4a2a0e39f93d3e2d4/latest/en-US

- Checks that can't be implemented via SQL (e.g. requiring operating system information)
  aren't part of the security mini checks

  -> Further manual checks required

- Not implemented, yet: Recommendations for Encryption -> Root Encryption Keys

- Executing user required CATALOG READ privilege to guarantee complete results
- USERS.IS_LDAP_ENABLED available with SAP HANA >= 2.00.030

[VALID FOR]

- Revisions:              >= 2.00.030

[SQL COMMAND VERSION]

- 2016/05/13:  1.0 (initial version)
- 2017/02/10:  1.1 (TECHNICAL_USER_LIST included)
- 2019/01/02:  1.2 (TEMP_* pre-materialization to avoid "number of tables exceeds its maximum" errors)
- 2019/04/15:  1.3 (dedicated 2.00.000+ version)
- 2019/06/02:  1.4 (dedicated 2.00.030+ version including IS_LDAP_ENABLED)
- 2021/02/05:  1.5 (replacement of deprecated PASSWORD_CHANGE_TIME with IS_PASSWORD_LIFETIME_CHECK_ENABLED)
- 2022/10/02:  1.6 (implementation of EFFECTIVE_ROLES_AND_PRIVILEGES based on SQL hierarchies)

[INVOLVED TABLES]

- AUDIT_POLICIES
- GRANTED_PRIVILEGES
- GRANTED_ROLES
- M_CONFIGURATION_PARAMETER_VALUES
- M_HOST_INFORMATION
- M_INIFILE_CONTENTS
- M_CUSTOMIZABLE_FUNCTIONALITIES
- USERS

[INPUT PARAMETERS]

- ONLY_POTENTIALLY_CRITICAL_ISSUES

  Possibility to restrict the output to potentially critical issues

  'X'             --> Output only contains issues that can potentially indicate a problem
  ' '             --> no output restriction

- TECHNICAL_USER_LIST

  Individual, comma separated list of user names that should be considered as technical users

  'USER1'         --> Define user USER1 as technical user
  'USER1, USER2'  --> Define users USER1 and USER2 as technical users
  ''              --> No technical user definition

- MAX_VALUE_LENGTH

  Maximum length of VALUE output column

  48              --> Maximum length of 48 characters
  -1              --> no length limitation

[OUTPUT PARAMETERS]

- CHID:           Check identifier (defined and used by this Mini Check command)
- DESCRIPTION:    Check description
- VALUE:          Check value found on the system
- EXPECTED_VALUE: Expected check values 
- C:              'X' if value found on the system is outside of the expected values (indication for potentially critical problem)
- SAP_NOTE:       Related SAP Note

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------------
|CHID |DESCRIPTION                                    |VALUE                     |EXPECTED_VALUE |C|SAP_NOTE|
-------------------------------------------------------------------------------------------------------------
|**** |GENERAL                                        |                          |               | |        |
|     |                                               |                          |               | |        |
|  10S|Analysis date                                  |2016/05/13 09:58:49 (CEST)|               | |        |
|  11S|Database name                                  |BWP                       |               | |        |
|     |                                               |                          |               | |        |
|**** |USERS                                          |                          |               | |        |
|     |                                               |                          |               | |        |
| 110S|CATALOG READ privilege granted to current user |yes                       |yes            | | 1640741|
| 120S|SYSTEM user locked                             |no                        |yes            |X|        |
| 130S|Non-technical users without password lifetime  |MONITOR                   |none           |X|        |
|     |                                               |                          |               | |        |
|**** |PRIVILEGES                                     |                          |               | |        |
|     |                                               |                          |               | |        |
| 210S|Users with special privileges for production   |MONITOR (CATALOG READ)    |none           |X|        |
|     |                                               |TMPTPO (CATALOG READ)     |none           |X|        |
| 215S|Users with special privileges                  |none                      |none           | |        |
| 220S|Users with critical privilege combinations     |none                      |none           | |        |
| 230S|DATA ADMIN privilege granted to users or roles |TMPTPO                    |no             |X|  863362|
| 231S|DEVELOPMENT privilege granted to users or roles|ABAP_DEV                  |no             |X|        |
|     |                                               |SAPBWP                    |no             |X|        |
| 232S|DEBUG privilege granted to users or roles      |_SYS_REPO                 |no             |X|        |
| 233S|ATTACH_DEBUGGER priv. granted to users or roles|no                        |no             | |        |
| 240S|_SYS_BI_CP_ALL priv. granted to users or roles |ABAP_DEV                  |no             |X|        |
|     |                                               |SAPBWP                    |no             |X|        |
|     |                                               |USER                      |no             |X|        |
|     |                                               |                          |               | |        |
|**** |ROLES                                          |                          |               | |        |
|     |                                               |                          |               | |        |
| 310S|CONTENT_ADMIN role granted to users or roles   |ABAP_DEV                  |no             |X|        |
|     |                                               |USER                      |no             |X|        |
| 311S|MODELING role granted to users or roles        |no                        |no             | |        |
| 312S|Users with granted AFL roles                   |none                      |no             | |        |
| 329S|SAP_INTERNAL_HANA_SUPPORT granted              |no                        |no             | |        |
|     |                                               |                          |               | |        |
|**** |NETWORK                                        |                          |               | |        |
|     |                                               |                          |               | |        |
| 410S|Global listeninterface configured              |no                        |no             | | 2222200|
| 412S|Global sys. rep. listeninterface configured    |yes                       |no             |X| 2222200|
|     |                                               |                          |               | |        |
|**** |ENCRYPTION                                     |                          |               | |        |
|     |                                               |                          |               | |        |
| 510S|SSFS instance master key still initial         |no                        |no             | |        |
| 520S|Data volume encryption enabled                 |no                        |yes            |X|        |
|     |                                               |                          |               | |        |
|**** |FILE SYSTEM                                    |                          |               | |        |
|     |                                               |                          |               | |        |
| 610S|Adjusted file security settings                |no                        |no             | |        |
| 620S|Users with EXPORT or IMPORT privilege          |2                         |<= 5           | |        |
|     |                                               |                          |               | |        |
|**** |AUDITING                                       |                          |               | |        |
|     |                                               |                          |               | |        |
| 710S|Global auditing state                          |yes                       |no             |X|        |
| 720S|Default audit trail type                       |CSTABLE                   |not CSVTEXTFILE| |  863362|
| 723S|Audit policies with trail type CSV             |none                      |none           | |        |
|     |                                               |                          |               | |        |
|**** |TRACES                                         |                          |               | |        |
|     |                                               |                          |               | |        |
| 810S|Traces configured on debug level               |none                      |none           | |        |
| 815S|SQL trace including results configured         |no                        |no             | |  863362|
| 820S|Runtime dumps older than 42 days               |53                        |0              |X|        |
|     |                                               |                          |               | |        |
|**** |MULTITENANT                                    |                          |               | |        |
|     |                                               |                          |               | |        |
| 910S|Number of disabled customizable functionalities|0                         |>= 1           |X|        |
|     |                                               |                          |               | |        |
|**** |END OF CHECK                                   |                          |               | |        |
-------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT                                               /* Modification section */
    ' ' ONLY_POTENTIALLY_CRITICAL_RESULTS,
    '' TECHNICAL_USER_LIST,
    -1 MAX_VALUE_LENGTH
  FROM
    DUMMY
),
USERLIST AS
( SELECT
    CASE
      WHEN U.USER_NAME LIKE '\_SYS\_%' ESCAPE '\' OR
        ( U.USER_NAME LIKE 'SAP___' AND U.USER_NAME != 'SAPOSS' ) OR
        U.USER_NAME = 'SYS' OR
        U.USER_NAME = 'SYSTEM' OR
        (U.USER_NAME LIKE 'XSSQLCC_AUTO_USER%' AND CREATOR='_SYS_REPO') OR
        U.USER_NAME = 'SYS_XS_HANA_BROKER' OR
        U.USER_NAME = 'SYS_XS_HANA_BROKER_INTERNAL' OR
        U.USER_NAME = 'SYS_XS_INSTANCE_MANAGER_ADMIN_USER' OR
        U.USER_NAME = 'SYS_XS_INSTANCE_MANAGER_BROKER_USER' OR
        U.USER_NAME = 'SYS_XS_OID_USER' OR
        U.USER_NAME = 'SYS_XS_OID_USER_SEC' OR
        U.USER_NAME = 'SYS_XS_RUNTIME' OR
        U.USER_NAME = 'SYS_XS_SBSS' OR
        U.USER_NAME = 'SYS_XS_SUPPORT' OR
        U.USER_NAME = 'SYS_XS_UAA' OR
        U.USER_NAME = 'SYS_XS_UAA_SEC' OR
        U.USER_NAME = 'SYS_XSA' OR
        U.USER_NAME = 'SAPDBCTRL' OR
        U.USER_NAME = 'HDI_ADMIN_USER' OR
        U.USER_NAME = 'HDI_ADMIN_CONTROLLER' OR
        U.USER_NAME = 'HDI_BROKER_CONTROLLER' OR
        U.USER_NAME = 'SYS_XS_SYSTEMDB_INFO' OR
        (U.USER_NAME LIKE 'SBSS_%' AND U.CREATOR = 'SYS_XS_SBSS') OR
        U.CREATOR = 'SYS_XS_HANA_BROKER_INTERNAL' OR
        U.CREATOR = 'SYS_XS_HANA_BROKER' OR
        U.CREATOR = '_SYS_DI_SU' OR
        ',' || REPLACE(BI.TECHNICAL_USER_LIST, CHAR(32), '') || ',' LIKE '%,' || U.USER_NAME || ',%' THEN 'TECHNICAL'
      WHEN USER_NAME IN ( 'DBACOCKPIT', 'MONITORING' ) THEN 'ADMIN'
      ELSE 'OTHER'
    END USER_TYPE, 
    *
  FROM
    BASIS_INFO BI,
    USERS U
),
RAW_HIERARCHY_INPUT AS
( SELECT GRANTEE, GRANTEE_TYPE, ROLE_NAME NODE_NAME, NULL OBJECT_TYPE, NULL SCHEMA_NAME, NULL OBJECT_NAME, NULL COLUMN_NAME, 'R' NODE_TYPE FROM GRANTED_ROLES
  UNION ALL
  SELECT NULL, NULL, USER_NAME, NULL, NULL, NULL, NULL, 'U' FROM USERS
  UNION ALL
  SELECT NULL, NULL, ROLE_NAME, NULL, NULL, NULL, NULL, 'R' FROM ROLES WHERE ROLE_NAME NOT IN ( SELECT ROLE_NAME FROM GRANTED_ROLES )
  UNION ALL
  SELECT GRANTEE, GRANTEE_TYPE, PRIVILEGE, OBJECT_TYPE, SCHEMA_NAME, OBJECT_NAME, COLUMN_NAME, 'P' FROM GRANTED_PRIVILEGES
),
ROLES_HIERARCHY AS
( SELECT 
    * 
  FROM 
    HIERARCHY
    ( SOURCE ( SELECT *, GRANTEE PARENT_ID, NODE_NAME NODE_ID FROM RAW_HIERARCHY_INPUT )
      START WHERE GRANTEE IS NULL
      SIBLING ORDER BY GRANTEE, NODE_NAME
      NO CACHE
    )
),
EFFECTIVE_ROLES_AND_PRIVILEGES_HELPER AS
( SELECT 
    *,
    '-> ' || ROLE_PATH || ' ->' ROLE_PATH_WRAPPED
  FROM 
    HIERARCHY_ANCESTORS_AGGREGATE
  ( SOURCE ROLES_HIERARCHY
    MEASURES ( STRING_AGG(NODE_ID, ' -> ') ROLE_PATH )
  )
),
EFFECTIVE_ROLES_AND_PRIVILEGES AS
( SELECT
    D.*,
    R.NODE_NAME FINAL_GRANTEE,
    R.NODE_TYPE ROOT_NODE_TYPE
  FROM
    EFFECTIVE_ROLES_AND_PRIVILEGES_HELPER R,
    EFFECTIVE_ROLES_AND_PRIVILEGES_HELPER D
  WHERE
    R.HIERARCHY_RANK = D.HIERARCHY_ROOT_RANK
)
SELECT
  CASE 
    WHEN NAME = 'BLANK_LINE' THEN ''
    WHEN NAME = 'INFO_LINE' THEN '****' 
    WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 THEN 'S' || LPAD(TO_VARCHAR(CHECK_NUM), 4, '0')
    ELSE '' 
  END CHID,
  CASE WHEN ONLY_POTENTIALLY_CRITICAL_RESULTS = 'X' OR ROW_NUM = 1 THEN DESCRIPTION ELSE '' END DESCRIPTION,
  MAP(VALUE, '999999', 'never', NULL, 'n/a', 
    CASE WHEN MAX_VALUE_LENGTH = -1 OR LENGTH(VALUE) <= MAX_VALUE_LENGTH THEN VALUE 
      ELSE SUBSTR(VALUE, 1, VALUE_FRAGMENT_LENGTH) || '...' || SUBSTR(VALUE, LENGTH(VALUE) - (VALUE_FRAGMENT_LENGTH - 1), VALUE_FRAGMENT_LENGTH) END) VALUE,
  CASE
    WHEN EXPECTED_OP = 'any'  THEN ''
    WHEN EXPECTED_OP = '='    THEN EXPECTED_VALUE
    WHEN EXPECTED_OP = 'like' THEN EXPECTED_OP || CHAR(32) || CHAR(39) || EXPECTED_VALUE || CHAR(39)
    ELSE EXPECTED_OP || CHAR(32) || EXPECTED_VALUE
  END EXPECTED_VALUE,
  POTENTIALLY_CRITICAL C,
  LPAD(SAP_NOTE, 8) SAP_NOTE
FROM
( SELECT
    CC.CHECK_NUM,
    CC.NAME,
    CC.DESCRIPTION,
    C.VALUE,
    CC.SAP_NOTE,
    CC.EXPECTED_OP,
    CC.EXPECTED_VALUE,
    CASE
      WHEN CC.EXPECTED_OP = 'any' OR UPPER(C.VALUE) = 'NONE'                                                      THEN ' '
      WHEN CC.EXPECTED_OP = 'not'      AND LPAD(UPPER(C.VALUE), 100) =        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '='        AND LPAD(UPPER(C.VALUE), 100) !=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>='       AND LPAD(UPPER(C.VALUE), 100) <        LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = '>'        AND LPAD(UPPER(C.VALUE), 100) <=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60) || '=' AND LPAD(UPPER(C.VALUE), 100) >   LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = CHAR(60)   AND LPAD(UPPER(C.VALUE), 100) >=       LPAD(UPPER(CC.EXPECTED_VALUE), 100) THEN 'X'
      WHEN CC.EXPECTED_OP = 'like'     AND UPPER(C.VALUE)            NOT LIKE UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      WHEN CC.EXPECTED_OP = 'not like' AND UPPER(C.VALUE)            LIKE     UPPER(CC.EXPECTED_VALUE)            THEN 'X'
      ELSE ''
    END POTENTIALLY_CRITICAL,
    BI.ONLY_POTENTIALLY_CRITICAL_RESULTS,
    BI.MAX_VALUE_LENGTH,
    FLOOR(BI.MAX_VALUE_LENGTH / 2 - 0.5) VALUE_FRAGMENT_LENGTH,
    ROW_NUMBER () OVER ( PARTITION BY CC.DESCRIPTION ORDER BY C.VALUE ) ROW_NUM
  FROM
  ( ( SELECT
        'CHECK_VERSION' NAME,
        '2.00.030+ / 1.6.1 (2024/02/25)' VALUE
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'GENERATED_WITH',
        'SQL: "HANA_Security_MiniChecks"'
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT TOP 1
        'ANALYSIS_DATE',
        TO_VARCHAR(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH24:MI:SS') || MAP(VALUE, NULL, '', CHAR(32) || '(' || VALUE || ')')
      FROM
        DUMMY LEFT OUTER JOIN
        M_HOST_INFORMATION ON
          KEY = 'timezone_name'
    )
    UNION ALL
    ( SELECT
        'SYSTEM_ID_DB_NAME',
        SYSTEM_ID || CHAR(32) || '/' || CHAR(32) || DATABASE_NAME
      FROM
        M_DATABASE
    )
    UNION ALL
    ( SELECT
        'BLANK_LINE',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'INFO_LINE',
        ''
      FROM
        DUMMY
    )
    UNION ALL
    ( SELECT
        'SECURE_STORE_AVAILABLE',
        VALUE
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'secure_store'
    )
    UNION ALL
    ( SELECT DISTINCT
        'CATALOG_READ_GRANTED',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        EFFECTIVE_PRIVILEGES
      WHERE
        USER_NAME = CURRENT_USER AND
        PRIVILEGE = 'CATALOG READ'
    )
    UNION ALL
    ( SELECT
        'SQLTRACE_WITH_RESULTS',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_INIFILE_CONTENTS
      WHERE
        SECTION = 'sqltrace' AND
        KEY = 'level' AND
        VALUE = 'all_with_results'
    )
    UNION ALL
    ( SELECT
        'SYSTEM_USER_LOCKED',
        MAP(USER_DEACTIVATED, 'TRUE', 'yes', 'no')
      FROM
        USERS
      WHERE
        USER_NAME = 'SYSTEM'
    )
    UNION ALL
    ( SELECT
        'PASSWORD_LIFETIME',
        IFNULL(U.USER_NAME, 'none') USER_NAME
      FROM
        DUMMY D LEFT OUTER JOIN
        USERLIST U ON
          U.IS_PASSWORD_LIFETIME_CHECK_ENABLED = 'FALSE' AND
          U.IS_PASSWORD_ENABLED = 'TRUE' AND
          U.USER_TYPE NOT IN ( 'TECHNICAL', 'ADMIN' )
    )
    UNION ALL
    ( SELECT DISTINCT
        'PROD_ADMIN_PRIVILEGES',
        IFNULL(USER_NAME || CHAR(32) || '(' || PRIVILEGE || ')', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT
          U.USER_NAME,
          R.NODE_NAME PRIVILEGE
        FROM
          EFFECTIVE_ROLES_AND_PRIVILEGES R,
          USERLIST U,
          M_DATABASE D
        WHERE
          R.FINAL_GRANTEE = U.USER_NAME AND
          R.ROOT_NODE_TYPE = 'U' AND
          R.NODE_NAME IN ( 'CATALOG READ', 'TRACE ADMIN' ) AND
          U.USER_TYPE NOT IN ( 'TECHNICAL', 'ADMIN' ) AND
          D.USAGE = 'PRODUCTION'
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT DISTINCT
        'ADMIN_PRIVILEGES',
        IFNULL(USER_NAME || CHAR(32) || '(' || PRIVILEGE || ')', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT DISTINCT
          U.USER_NAME,
          R.NODE_NAME PRIVILEGE
        FROM
          EFFECTIVE_ROLES_AND_PRIVILEGES R,
          USERLIST U
        WHERE
          R.FINAL_GRANTEE = U.USER_NAME AND
          R.ROOT_NODE_TYPE = 'U' AND
          R.NODE_NAME IN 
          ( 'ADAPTER ADMIN', 'AGENT ADMIN', 'AUDIT ADMIN', 'AUDIT OPERATOR', 'BACKUP ADMIN', 'BACKUP OPERATOR', 'CERTIFICATE ADMIN', 
            'CREATE REMOTE SOURCE', 'CREDENTIAL ADMIN', 'EXTENDED STORAGE ADMIN', 'INIFILE ADMIN', 'LICENSE ADMIN', 'LOG ADMIN',
            'MONITOR ADMIN', 'OPTIMIZER ADMIN', 'RESOURCE ADMIN', 'SAVEPOINT ADMIN', 'SERVICE ADMIN', 'SESSION ADMIN', 'SSL ADMIN',
            'TABLE ADMIN', 'TRUST ADMIN', 'VERSION ADMIN' 
          ) AND
          U.USER_TYPE NOT IN ( 'TECHNICAL', 'ADMIN' )
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT DISTINCT
        'DATA_ADMIN_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          OBJECT_TYPE = 'SYSTEMPRIVILEGE' AND
          NODE_NAME = 'DATA ADMIN' AND
          FINAL_GRANTEE NOT IN ( 'SYSTEM', '_SYS_REPO' )
    )
    UNION ALL
    ( SELECT DISTINCT
        'DEVELOPMENT_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          OBJECT_TYPE = 'SYSTEMPRIVILEGE' AND
          NODE_NAME = 'DEVELOPMENT' AND
          FINAL_GRANTEE NOT IN ( 'SYSTEM', '_SYS_REPO' )
    )
    UNION ALL
    ( SELECT DISTINCT
        'DEBUG_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          NODE_NAME = 'DEBUG' AND
          ROOT_NODE_TYPE = 'U' AND
          SUBSTR(FINAL_GRANTEE, LENGTH(FINAL_GRANTEE) - 2) != '_RT'
    )
    UNION ALL
    ( SELECT DISTINCT
        'ATTACH_DEBUGGER_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          NODE_NAME = 'ATTACH DEBUGGER' AND
          ROOT_NODE_TYPE = 'USER'
    )
    UNION ALL
    ( SELECT DISTINCT
        'CONTENT_ADMIN_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          ROLE_PATH_WRAPPED LIKE '%-> CONTENT_ADMIN ->%' AND
          FINAL_GRANTEE != 'SYSTEM'
    )
    UNION ALL
    ( SELECT DISTINCT
        'MODELING_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        M_DATABASE LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          ROLE_PATH_WRAPPED LIKE '%-> MODELING ->%' AND
          FINAL_GRANTEE != 'SYSTEM' AND
          USAGE = 'PRODUCTION'
    )
    UNION ALL
    ( SELECT DISTINCT
        'SAP_INTERNAL_HANA_SUPPORT',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          ROLE_PATH_WRAPPED LIKE '%_-> SAP_INTERNAL_HANA_SUPPORT ->%' AND
          FINAL_GRANTEE != 'SYSTEM'
    )
    UNION ALL
    ( SELECT DISTINCT
        '_SYS_BI_CP_ALL_GRANTED',
        IFNULL(FINAL_GRANTEE, 'no')
      FROM
        DUMMY LEFT OUTER JOIN
        EFFECTIVE_ROLES_AND_PRIVILEGES ON
          OBJECT_TYPE = 'ANALYTICALPRIVILEGE' AND 
          OBJECT_NAME = '_SYS_BI_CP_ALL' AND 
          NODE_NAME = 'EXECUTE' AND 
          FINAL_GRANTEE NOT IN ('SYSTEM', 'MODELING', 'CONTENT_ADMIN')
    )
    UNION ALL
    ( SELECT
        'ADMIN_PRIVILEGE_COMBINATIONS',
        IFNULL(USER_NAME || CHAR(32) || '(' || PRIVILEGE_1 || CHAR(32) || '/' || CHAR(32) || PRIVILEGE_2 || ')', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT DISTINCT
          R1.FINAL_GRANTEE USER_NAME,
          R1.NODE_NAME PRIVILEGE_1,
          R2.NODE_NAME PRIVILEGE_2
        FROM
          EFFECTIVE_ROLES_AND_PRIVILEGES R1,
          EFFECTIVE_ROLES_AND_PRIVILEGES R2,
          USERLIST U
        WHERE
          R1.FINAL_GRANTEE = R2.FINAL_GRANTEE AND
          U.USER_NAME = R1.FINAL_GRANTEE AND
          R1.ROOT_NODE_TYPE = 'U' AND
          R2.ROOT_NODE_TYPE = 'U' AND
          ( R1.NODE_NAME, R2.NODE_NAME ) IN
          ( ( 'USER ADMIN',                  'ROLE ADMIN' ), 
            ( 'CREATE SCENARIO',             'SCENARIO ADMIN' ),
            ( 'AUDIT ADMIN',                 'AUDIT OPERATOR' ), 
            ( 'CREATE STRUCTURED PRIVILEGE', 'STRUCTUREDPRIVILEGE ADMIN' )
          ) AND
          U.USER_TYPE != 'TECHNICAL'
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'AFL_ROLES_GRANTED',
        IFNULL(USER_NAME || CHAR(32) || '(' || ROLE_PATH || ')', 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
      ( SELECT DISTINCT
          U.USER_NAME,
          R.ROLE_PATH
        FROM
          EFFECTIVE_ROLES_AND_PRIVILEGES R,
          USERLIST U
        WHERE
          R.FINAL_GRANTEE = U.USER_NAME AND
          R.ROOT_NODE_TYPE = 'U' AND
          R.FINAL_GRANTEE NOT IN ( '_SYS_AFL', '_SYS_REPO' ) AND
          ( R.ROLE_PATH_WRAPPED LIKE '%-> AFL__SYS_AFL_AFLPAL_EXECUTE ->%' OR
            R.ROLE_PATH_WRAPPED LIKE '%-> AFL__SYS_AFL_AFLPAL_EXECUTE_WITH_GRANT_OPTION ->%' OR
            R.ROLE_PATH_WRAPPED LIKE '%-> AFL__SYS_AFL_AFLBFL_EXECUTE ->%' OR
            R.ROLE_PATH_WRAPPED LIKE '%-> AFL__SYS_AFL_AFLBFL_EXECUTE_WITH_GRANT_OPTION ->%'
          ) 
      ) ON
        1 = 1
    )
    UNION ALL
    ( SELECT
        'LISTENINTERFACE_GLOBAL',
        MAP(IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, DEFAULT_VALUE)), '.global', 'yes', 'no')
      FROM
      ( SELECT 
          MAX(MAP(LAYER_NAME, 'DEFAULT', VALUE)) DEFAULT_VALUE,
          MAX(MAP(LAYER_NAME, 'HOST',    VALUE)) HOST_VALUE,
          MAX(MAP(LAYER_NAME, 'SYSTEM',  VALUE, 'DATABASE', VALUE)) SYSTEM_VALUE
        FROM
          M_INIFILE_CONTENTS 
        WHERE 
          SECTION = 'communication' AND
          KEY = 'listeninterface'
      )
    )
    UNION ALL
    ( SELECT
        'SR_LISTENINTERFACE_GLOBAL',
        MAP(IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, DEFAULT_VALUE)), '.global', SR_USED, 'no')
      FROM
      ( SELECT 
          MAX(MAP(LAYER_NAME, 'DEFAULT', VALUE)) DEFAULT_VALUE,
          MAX(MAP(LAYER_NAME, 'HOST',    VALUE)) HOST_VALUE,
          MAX(MAP(LAYER_NAME, 'SYSTEM',  VALUE, 'DATABASE', VALUE)) SYSTEM_VALUE
        FROM
          M_INIFILE_CONTENTS 
        WHERE 
          SECTION = 'system_replication_communication' AND
          KEY = 'listeninterface'
      ),
      ( SELECT MAP(COUNT(*), 0, 'no', 'yes') SR_USED FROM M_SERVICE_REPLICATION ) 
    )
    UNION ALL
    ( SELECT
        'SSFS_MASTERKEY_INITIAL',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'ssfs_masterkey_changed' AND VALUE = 'no'
    )
    UNION ALL
    ( SELECT
        'SSFS_SYSTEM_PKI_INITIAL',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_HOST_INFORMATION
      WHERE
        KEY = 'ssfs_masterkey_systempki_changed' AND VALUE = 'no'
    )
    UNION ALL
    ( SELECT
        'DATA_VOLUME_ENCRYPTION',
        MAP(SYSTEM_VALUE, 'true', 'yes', 'no')
      FROM
      ( SELECT 
          LOWER(SUBSTRING(STRING_AGG(ENCRYPTION_ACTIVE), 1, LENGTH(STRING_AGG(ENCRYPTION_ACTIVE)) / COUNT(ENCRYPTION_ACTIVE))) SYSTEM_VALUE 
        FROM 
          M_PERSISTENCE_ENCRYPTION_STATUS
      ) 
    )
    UNION ALL
    ( SELECT
        'FILE_SECURITY_ADJUSTED',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE 
        SECTION = 'import_export' AND
        KEY = 'file_security' AND
        LAYER_NAME != 'DEFAULT'
    )
    UNION ALL
    ( SELECT
        'USERS_WITH_EXPORT_IMPORT',
        TO_VARCHAR(COUNT(DISTINCT(FINAL_GRANTEE)))
      FROM
        EFFECTIVE_ROLES_AND_PRIVILEGES
      WHERE
        ROOT_NODE_TYPE = 'U' AND
        OBJECT_TYPE = 'SYSTEMPRIVILEGE' AND
        NODE_NAME IN ( 'EXPORT', 'IMPORT' )
    )
    UNION ALL
    ( SELECT
        'GLOBAL_AUDITING_ACTIVATED',
        MAP(IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, IFNULL(DEFAULT_VALUE, 'false'))), 'true', 'yes', 'no')
      FROM
      ( SELECT 
          MAX(MAP(LAYER_NAME, 'DEFAULT', VALUE)) DEFAULT_VALUE,
          MAX(MAP(LAYER_NAME, 'HOST',    VALUE)) HOST_VALUE,
          MAX(MAP(LAYER_NAME, 'SYSTEM',  VALUE, 'DATABASE', VALUE)) SYSTEM_VALUE
        FROM
          M_INIFILE_CONTENTS 
        WHERE 
          SECTION = 'auditing configuration' AND
          KEY = 'global_auditing_state'
      ) 
    )
    UNION ALL
    ( SELECT
        'ACTIVATED_AUDIT_POLICIES',
        TO_VARCHAR(COUNT(DISTINCT(AUDIT_POLICY_NAME)))
      FROM
        AUDIT_POLICIES
      WHERE
        IS_AUDIT_POLICY_ACTIVE = 'TRUE'
    )
    UNION ALL
    ( SELECT
        'DEFAULT_AUDIT_TRAIL_TYPE',
        IFNULL(SYSTEM_VALUE, IFNULL(HOST_VALUE, DEFAULT_VALUE))
      FROM
      ( SELECT 
          MAX(MAP(LAYER_NAME, 'DEFAULT', VALUE)) DEFAULT_VALUE,
          MAX(MAP(LAYER_NAME, 'HOST',    VALUE)) HOST_VALUE,
          MAX(MAP(LAYER_NAME, 'SYSTEM',  VALUE, 'DATABASE', VALUE)) SYSTEM_VALUE
        FROM
          M_INIFILE_CONTENTS 
        WHERE 
          SECTION = 'auditing configuration' AND
          KEY = 'default_audit_trail_type'
      ) 
    )
    UNION ALL
    ( SELECT DISTINCT
        'CSV_AUDIT_POLICIES',
        IFNULL(AUDIT_POLICY_NAME, 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
        AUDIT_POLICIES A ON
          SUBSTR(A.TRAIL_TYPE, 1, 3) = 'CSV'
    )
    UNION ALL
    ( SELECT DISTINCT
        'TRACES_DEBUG_LEVEL',
        IFNULL(KEY, 'none')
      FROM
        DUMMY D LEFT OUTER JOIN
        M_CONFIGURATION_PARAMETER_VALUES P ON
          P.SECTION = 'trace' AND
          P.LAYER_NAME != 'DEFAULT' AND
          LOWER(P.VALUE) = 'debug'
    )
    UNION ALL
    ( SELECT
        'OLD_RUNTIMEDUMPS',
        TO_VARCHAR(COUNT(*))
      FROM
        M_TRACEFILES
      WHERE
        ( UPPER(FILE_NAME) LIKE '%RTEDUMP%' OR UPPER(FILE_NAME) LIKE '%RUNTIMEDUMP%' ) AND
        DAYS_BETWEEN(FILE_MTIME, CURRENT_TIMESTAMP) > 42
    )
    UNION ALL
    ( SELECT
        'DISABLED_FUNCTIONALITIES',
        CASE WHEN MDCSYS = 'No' AND MDCTEN = 'No' THEN 'n/a' ELSE TO_VARCHAR(NUM_DISABLED) END
      FROM
      ( SELECT
          COUNT(*) NUM_DISABLED
        FROM
          M_CUSTOMIZABLE_FUNCTIONALITIES
        WHERE
          IS_ENABLED = 'FALSE'
      ),
      ( SELECT
          MAP(COUNT(*), 0, 'Yes', 'No') MDCSYS
        FROM
          M_SERVICES
        WHERE
          SERVICE_NAME = 'indexserver'
      ),
      ( SELECT
          CASE WHEN SUBSTR(MIN(PORT), 4) >= '40' THEN 'Yes' ELSE 'No' END MDCTEN
        FROM
          M_SERVICES
        WHERE
          SERVICE_NAME = 'indexserver'
      )
    )
    UNION ALL
    ( SELECT
        'AUTHENTICATION_METHODS',
        MAP(COUNT(*), 0, 'no', 'yes')
      FROM
        M_CONFIGURATION_PARAMETER_VALUES
      WHERE
        FILE_NAME = 'global.ini' AND
        SECTION = 'authentication' AND
        KEY = 'authentication_methods' AND
        LAYER_NAME != 'DEFAULT'
    )
    UNION ALL
    ( SELECT
        'LDAP_WITHOUT_SSL',
        TO_VARCHAR(COUNT(DISTINCT(U.USER_NAME)))
      FROM
        USERS U,
        M_INIFILE_CONTENTS IC
      WHERE
        U.IS_LDAP_ENABLED = 'TRUE' AND
        IC.FILE_NAME = 'global.ini' AND 
        IC.SECTION = 'communication' AND
        IC.KEY = 'ssl' AND 
        IC.VALUE='off'
    )
    UNION ALL
    ( SELECT
        'INVALID_AUDIT_POLICIES',
        TO_VARCHAR(COUNT(*))
      FROM
        AUDIT_POLICIES
      WHERE
        IS_VALID LIKE 'FALSE%'
    )
    UNION ALL
    ( SELECT DISTINCT
        'INTERNAL_PRIVILEGE_GRANTED',
        IFNULL(PRIVILEGE, 'none')
      FROM
        DUMMY LEFT OUTER JOIN
        GRANTED_PRIVILEGES ON
          PRIVILEGE NOT IN ( SELECT NAME FROM PRIVILEGES ) AND
          GRANTEE NOT IN ( 'SYSTEM', '_SYS_REPO' )
    )
  ) C,
    BASIS_INFO BI,
  ( SELECT
      TO_NUMBER(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) ||
      MAP(LOCATE(VALUE, '.', 1, 4), 0, '', '.' || SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 3) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) - 1 ))) REVISION 
    FROM 
      M_SYSTEM_OVERVIEW 
    WHERE 
      SECTION = 'System' AND 
      NAME = 'Version' 
  ) REL,
  ( SELECT -1 CHECK_NUM, '' NAME,                  '' DESCRIPTION,                                    '' SAP_NOTE, '' EXPECTED_OP, '' EXPECTED_VALUE, -1 MIN_REV, -1 MAX_REV FROM DUMMY WHERE 1 = 0 UNION ALL

    ( SELECT    1, 'INFO_LINE',                    'SAP HANA SECURITY MINI CHECKS',                   '2159014', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    2, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    5, 'GENERATED_WITH',               'Generated with',                                  '1969700', 'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    6, 'CHECK_VERSION',                'Check version',                                   '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT    8, 'SYSTEM_ID_DB_NAME',            'System ID / database name',                       '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT   10, 'ANALYSIS_DATE',                'Analysis date',                                   '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  100, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  101, 'INFO_LINE',                    'USERS',                                           '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  102, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  110, 'CATALOG_READ_GRANTED',         'CATALOG READ privilege granted to current user',  '1640741', '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  120, 'SYSTEM_USER_LOCKED',           'SYSTEM user deactivated',                         '',        '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  130, 'PASSWORD_LIFETIME',            'Non-technical users without password lifetime',   '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  200, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  201, 'INFO_LINE',                    'PRIVILEGES',                                      '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  202, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  210, 'PROD_ADMIN_PRIVILEGES',        'Users with special privileges for production',    '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  215, 'ADMIN_PRIVILEGES',             'Users with special privileges',                   '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  220, 'ADMIN_PRIVILEGE_COMBINATIONS', 'Users with critical privilege combinations',      '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  230, 'DATA_ADMIN_GRANTED',           'DATA ADMIN privilege granted to users',           '863362',  '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  231, 'DEVELOPMENT_GRANTED',          'DEVELOPMENT privilege granted to users',          '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  232, 'DEBUG_GRANTED',                'DEBUG privilege granted to users',                '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  233, 'ATTACH_DEBUGGER_GRANTED',      'ATTACH_DEBUGGER priv. granted to users',          '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  234, 'INTERNAL_PRIVILEGE_GRANTED',   'Internal privilege granted to users or roles',    '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  240, '_SYS_BI_CP_ALL_GRANTED',       '_SYS_BI_CP_ALL priv. granted to users',           '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  300, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  301, 'INFO_LINE',                    'ROLES',                                           '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  302, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  310, 'CONTENT_ADMIN_GRANTED',        'CONTENT_ADMIN role granted to users',             '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  311, 'MODELING_GRANTED',             'MODELING role granted in production',             '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  312, 'AFL_ROLES_GRANTED',            'Users with granted AFL roles',                    '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  329, 'SAP_INTERNAL_HANA_SUPPORT',    'SAP_INTERNAL_HANA_SUPPORT granted',               '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  400, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  401, 'INFO_LINE',                    'NETWORK',                                         '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  402, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  410, 'LISTENINTERFACE_GLOBAL',       'Global listeninterface configured',               '2183363', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  412, 'SR_LISTENINTERFACE_GLOBAL',    'Global sys. rep. listeninterface configured',     '2222200', '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  500, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  501, 'INFO_LINE',                    'ENCRYPTION',                                      '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  502, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  510, 'SSFS_MASTERKEY_INITIAL',       'SSFS instance master key still initial',          '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  512, 'SSFS_SYSTEM_PKI_INITIAL',      'SSFS system PKI master key still initial',        '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  520, 'DATA_VOLUME_ENCRYPTION',       'Data volume encryption enabled',                  '',        '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  600, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  601, 'INFO_LINE',                    'FILE SYSTEM',                                     '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  602, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  610, 'FILE_SECURITY_ADJUSTED',       'Adjusted file security settings',                 '',        '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  620, 'USERS_WITH_EXPORT_IMPORT',     'Users with EXPORT or IMPORT privilege',           '',        '<=',       '5',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  700, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  701, 'INFO_LINE',                    'AUDITING',                                        '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  702, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  710, 'GLOBAL_AUDITING_ACTIVATED',    'Global auditing state activated',                 '',        '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  712, 'ACTIVATED_AUDIT_POLICIES',     'Activated audit policies',                        '',        '>=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  720, 'DEFAULT_AUDIT_TRAIL_TYPE',     'Default audit trail type',                        '863362',  'not',      'CSVTEXTFILE',   -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  723, 'CSV_AUDIT_POLICIES',           'Audit policies with trail type CSV',              '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  730, 'INVALID_AUDIT_POLICIES',       'Invalid audit policies',                          '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  800, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  801, 'INFO_LINE',                    'TRACES',                                          '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  802, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  810, 'TRACES_DEBUG_LEVEL',           'Traces configured on debug level',                '',        '=',        'none',          -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  815, 'SQLTRACE_WITH_RESULTS',        'SQL trace including results configured',          '863362',  '=',        'no',            -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  820, 'OLD_RUNTIMEDUMPS',             'Runtime dumps older than 42 days',                '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT  900, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  901, 'INFO_LINE',                    'MULTITENANT',                                     '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  902, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT  910, 'DISABLED_FUNCTIONALITIES',     'Disabled customizable functionalities in MDC',    '',        '>=',       '1',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 1000, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1001, 'INFO_LINE',                    'AUTHENTICATION',                                  '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1002, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1010, 'AUTHENTICATION_METHODS',       'Adjusted authentication methods',                 '',        '=',        'yes',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 1020, 'LDAP_WITHOUT_SSL',             'Users with LDAP authentication without SSL',      '',        '=',        '0',             -1,    -1 FROM DUMMY ) UNION ALL

    ( SELECT 9000, 'BLANK_LINE',                   '',                                                '',        'any',      'any',           -1,    -1 FROM DUMMY ) UNION ALL
    ( SELECT 9001, 'INFO_LINE',                    'END OF CHECK',                                    '',        'any',      'any',           -1,    -1 FROM DUMMY )

  ) CC
  WHERE
    C.NAME = CC.NAME AND
    REL.REVISION BETWEEN CC.MIN_REV AND MAP(CC.MAX_REV, -1, 99999, CC.MAX_REV)
) M
WHERE
  ONLY_POTENTIALLY_CRITICAL_RESULTS = ' ' OR POTENTIALLY_CRITICAL = 'X'
ORDER BY
  M.CHECK_NUM,
  M.VALUE

