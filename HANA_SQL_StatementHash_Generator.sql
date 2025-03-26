WITH

/* 

[NAME]

- HANA_SQL_StatementHash_Generator

[DESCRIPTION]

- Generation of statement hash for given statement string

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- Mainly based on HASH_MD5 function that is used by SAP HANA to generate statement hashes

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2024/09/19:  1.0 (initial version)

[INVOLVED TABLES]


[INPUT PARAMETERS]

- STATEMENT_STRING

  Statement string

  'SELECT * FROM T000' --> Statement string 'SELECT * FROM T000'

- INCLUDE_FDA_READ_VARIANT

  Possibility to include a variant of the statement string that includes the FDA READ comment (only available for SELECTs)

  'X'             --> Also provide the statement hash for the FDA READ variant
  ' '             --> No consideration of the FDA READ variant

- INCLUDE_RANGE_RESTRICTION_CURRENT_VARIANT

  Possibility to include a variant of the statement string that uses the data aging term WITH RANGE_RESTRICTION('CURRENT')

  'X'             --> Also provide the statement hash for the WITH RANGE_RESTRICTION('CURRENT') variant
  ' '             --> No consideration of the WITH RANGE_RESTRICTION('CURRENT') variant

[OUTPUT PARAMETERS]

- VARIANT:          Statement variant
- STATEMENT_HASH:   Statement hash
- STATEMENT_STRING: Statement string

[EXAMPLE OUTPUT]

------------------------------------------------------------------------------------------------------------------------------------
|VARIANT                     |STATEMENT_HASH                  |STATEMENT_STRING                                                    |
------------------------------------------------------------------------------------------------------------------------------------
|                            |8e5a2db15943a6040806b9e937097d72|SELECT * FROM T000                                                  |
|FDA READ                    |9aebb0c4990551f89b89070e90104fbc|SELECT /* FDA READ /* * FROM T000                                   |
|RANGE RESTRICTION           |703613ed73ffbc158aca9ab987b717cb|SELECT * FROM T000  WITH RANGE_RESTRICTION('CURRENT')               |
|RANGE RESTRICTION + FDA READ|5d3cbbf0cb4b49d82ec7ebdaee48c7d7|SELECT /* FDA READ /* * FROM T000  WITH RANGE_RESTRICTION('CURRENT')|
------------------------------------------------------------------------------------------------------------------------------------

*/

BASIS_INFO AS
( SELECT             /* Modification section */
    'SELECT * FROM "STXH" WHERE "MANDT" = ? AND "TDOBJECT" = ? AND "TDNAME" LIKE ? ESCAPE ? AND "TDID" = ? AND "TDSPRAS" = ?' STATEMENT_STRING,
    'X' INCLUDE_FDA_READ_VARIANT,
    'X' INCLUDE_RANGE_RESTRICTION_CURRENT_VARIANT
  FROM
    DUMMY
)
SELECT
  *
FROM
( SELECT
    '' VARIANT,
    LOWER(TO_VARCHAR(HASH_MD5(TO_BINARY(STATEMENT_STRING)))) STATEMENT_HASH,
    STATEMENT_STRING
  FROM
    BASIS_INFO
  UNION ALL
  SELECT
    'FDA READ' VARIANT,
    LOWER(TO_VARCHAR(HASH_MD5(TO_BINARY('SELECT /* FDA READ */' || SUBSTR(STATEMENT_STRING, 7))))) STATEMENT_HASH,
    'SELECT /* FDA READ */' || SUBSTR(STATEMENT_STRING, 7) STATEMENT_STRING
  FROM
    BASIS_INFO
  WHERE
    INCLUDE_FDA_READ_VARIANT = 'X' AND
    STATEMENT_STRING LIKE 'SELECT%'
  UNION ALL
  SELECT
    'RANGE RESTRICTION + FDA READ' VARIANT,
    LOWER(TO_VARCHAR(HASH_MD5(TO_BINARY('SELECT /* FDA READ */' || SUBSTR(STATEMENT_STRING, 7) || CHAR(32) || CHAR(32) || 'WITH RANGE_RESTRICTION(''CURRENT'')')))) STATEMENT_HASH,
    'SELECT /* FDA READ */' || SUBSTR(STATEMENT_STRING, 7) || CHAR(32) || CHAR(32) || 'WITH RANGE_RESTRICTION(''CURRENT'')' STATEMENT_STRING
  FROM
    BASIS_INFO
  WHERE
    INCLUDE_FDA_READ_VARIANT = 'X' AND
    INCLUDE_RANGE_RESTRICTION_CURRENT_VARIANT = 'X' AND
    STATEMENT_STRING LIKE 'SELECT%'
  UNION ALL
  SELECT
    'RANGE RESTRICTION' VARIANT,
    LOWER(TO_VARCHAR(HASH_MD5(TO_BINARY(STATEMENT_STRING || CHAR(32) || CHAR(32) || 'WITH RANGE_RESTRICTION(''CURRENT'')')))) STATEMENT_HASH,
    STATEMENT_STRING || CHAR(32) || CHAR(32) || 'WITH RANGE_RESTRICTION(''CURRENT'')' STATEMENT_STRING
  FROM
    BASIS_INFO
  WHERE
    INCLUDE_RANGE_RESTRICTION_CURRENT_VARIANT = 'X'
)
ORDER BY
  VARIANT
