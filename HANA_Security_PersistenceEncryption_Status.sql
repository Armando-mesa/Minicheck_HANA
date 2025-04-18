SELECT
/* 

[NAME]

- HANA_Security_PersistenceEncryption_Status

[DESCRIPTION]

- SAP HANA persistence encryption status

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]


[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2023/10/25:  1.0 (initial version)

[INVOLVED TABLES]

- M_PERSISTENCE_ENCRYPTION_STATUS

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

- ACTIVE

  Encryption activity state

  'TRUE'          --> Persistences with active encryption
  'FALSE'         --> Persistences without encryption
  '%'             --> All persistences

- REENCRYPTION_ACTIVE

  Information if re-encryption is currently ongoing

  'TRUE'          --> Persistences with currently ongoing re-encryption
  'FALSE'         --> Persistences without currently ongoing re-encryption
  '%'             --> No restriction related to ongoing re-encryption
  
[OUTPUT PARAMETERS]

- HOST:                       Host name
- PORT:                       Port
- ACTIVE:                     TRUE if encryption is active, otherwise FALSE
- REENCRYPTION_ACTIVE:        TRUE if re-encryption is currently active, otherwise FALSE
- IS_LATEST_ROOT_KEY_VERSION: TRUE if latest root key version is used for encryption, otherwise FALSE
- ROOT_KEY_VERSION:           Used root key version

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------
|HOST         |PORT |ACTIVE|REENCRYPTION_ACTIVE|IS_LATEST_ROOT_KEY_VERSION|ROOT_KEY_VERSION|
--------------------------------------------------------------------------------------------
|saphanahost01|30240|TRUE  |FALSE              |TRUE                      |               0|
|saphanahost01|30243|TRUE  |FALSE              |TRUE                      |               0|
|saphanahost01|30249|TRUE  |FALSE              |TRUE                      |               0|
|saphanahost02|30240|TRUE  |FALSE              |TRUE                      |               0|
|saphanahost02|30246|TRUE  |FALSE              |TRUE                      |               0|
--------------------------------------------------------------------------------------------

*/

  E.HOST,
  LPAD(TO_VARCHAR(E.PORT), 5) PORT,
  E.ENCRYPTION_ACTIVE ACTIVE,
  E.DATA_CONVERSION_ACTIVE REENCRYPTION_ACTIVE,
  E.IS_LATEST_ROOT_KEY_VERSION,
  LPAD(E.USED_ROOT_KEY_VERSION, 16) ROOT_KEY_VERSION
FROM
( SELECT                       /* Modification section */
    '%' HOST,
    '%' PORT,
    '%' ACTIVE,
    '%' REENCRYPTION_ACTIVE
  FROM
    DUMMY
) BI,
  M_PERSISTENCE_ENCRYPTION_STATUS E
WHERE
  E.HOST LIKE BI.HOST AND
  TO_VARCHAR(E.PORT) LIKE BI.PORT AND
  E.ENCRYPTION_ACTIVE LIKE BI.ACTIVE AND
  E.DATA_CONVERSION_ACTIVE LIKE BI.REENCRYPTION_ACTIVE
ORDER BY
  E.HOST,
  E.PORT
