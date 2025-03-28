SELECT

/* 

[NAME]

- HANA_Configuration_Plugins_1.00.120+

[DESCRIPTION]

- SAP HANA plugin status information

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- M_PLUGIN_STATUS available with SAP HANA >= 1.00.120

[VALID FOR]

- Revisions:              >= 1.00.120

[SQL COMMAND VERSION]

- 2023/07/13:  1.0 (initial version)

[INVOLVED TABLES]

- M_PLUGIN_STATUS

[INPUT PARAMETERS]

- PLUGIN_NAME

  Plugin name

  'lcapps'   --> Plugin name lcapps
  '%'        --> No restriction related to plugin name

- AREA_NAME

  Area name

  'AFLPAL'   --> Area name AFLPAL
  '%'        --> No restriction related to area name

- PACKAGE_NAME

  Package name

  'OFL'      --> Package name OFL
  'SAP%'     --> Package names starting with 'SAP'
  '%'        --> No restriction related to package name

- ONLY_FAILED_PLUGINS

  Possibility to restrict output to entries indicating failures

  'X'        --> Only report plugin failures
  ' '        --> No restriction related to plugin failures

[OUTPUT PARAMETERS]

- PLUGIN_NAME:    Plugin name
- AREA_NAME:      Area name
- AREA_STATUS:    Area status
- PACKAGE_NAME:   Package name
- PACKAGE_STATUS: Package status
- ERROR_TEXT:     Error text

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|PLUGIN_NAME|AREA_NAME|AREA_STATUS            |PACKAGE_NAME|PACKAGE_STATUS         |ERROR_TEXT                                                                                                                                                                                   |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|afl        |AFLBFL   |REGISTRATION SUCCESSFUL|BFL         |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|afl        |AFLPAL   |REGISTRATION SUCCESSFUL|PAL         |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|afl        |OFL_AREA |REGISTRATION SUCCESSFUL|OFL         |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|eml        |EML      |REGISTRATION FAILED    |EMLLIB      |REGISTRATION FAILED    |Registration of package EMLLIB failed at "create afl package _SYS_AFL.EMLLIB file '/plugins/eml/libaflemllib' in _SYS_AFL.EML" with error 444: "package manager error - load library failed".|
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPAPO      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPATP      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPBAS      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPLCK      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPPVC      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPREP      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPRPM      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPSIM      |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|lcapps     |LCAPPS   |REGISTRATION SUCCESSFUL|SAPTS       |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
|vch2020    |VCH_2020 |REGISTRATION SUCCESSFUL|VCH2020     |REGISTRATION SUCCESSFUL|                                                                                                                                                                                             |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  P.PLUGIN_NAME,
  P.AREA_NAME,
  P.AREA_STATUS,
  P.PACKAGE_NAME,
  P.PACKAGE_STATUS,
  P.ERROR_TEXT  
FROM
( SELECT                   /* Modification section */
    '%' PLUGIN_NAME,
    '%' AREA_NAME,
    '%' PACKAGE_NAME,
    'X' ONLY_FAILED_PLUGINS
  FROM
    DUMMY
) BI,
  M_PLUGIN_STATUS P
WHERE
  P.PLUGIN_NAME LIKE BI.PLUGIN_NAME AND
  P.AREA_NAME LIKE BI.AREA_NAME AND
  P.PACKAGE_NAME LIKE BI.PACKAGE_NAME AND
  ( BI.ONLY_FAILED_PLUGINS = ' ' OR P.AREA_STATUS LIKE '%FAILED%' OR P.PACKAGE_STATUS LIKE '%FAILED%' OR P.ERROR_TEXT != CHAR(32) )
ORDER BY
  P.PLUGIN_NAME,
  P.AREA_NAME,
  P.PACKAGE_NAME
