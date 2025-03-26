SELECT
/* 

[NAME]

- HANA_License_LicenseUsage

[DESCRIPTION]

- License usage information

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]

- LICENSE_LIMIT is always the current value while LICENSE_USAGE in M_LICENSE is always the peak in history. 
  This can lead to wrong the erroneous assumption that the license limit is exhausted. LIMIT_CURRENT_USAGE_BY_GAL
  makes sure that the license usage is also limited by the current global_allocation_limit.

- Fails in SAP HANA Cloud (SHC) environments because license checks, limits and usage details are irrelevant:

  invalid column name: PRODUCT_USAGE

[VALID FOR]

- Revisions:              all

[SQL COMMAND VERSION]

- 2014/04/19:  1.0 (initial version)
- 2024/09/21:  1.1 (LIMIT_CURRENT_USAGE_BY_GAL included)

[INVOLVED TABLES]

- M_LICENSE
- M_LICENSE_USAGE_HISTORY

[INPUT PARAMETERS]

- LIMIT_CURRENT_USAGE_BY_GAL

  Possibility to limit the current license usage by the existing global allocation limit

  'X'            --> Limit current license usage by the existing global allocation limit
  ' '            --> No  limitation of current license usage by existing global allocation limit

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information
  '%'             --> All data sources
  
[OUTPUT PARAMETERS]

- TIME_INTERVAL:    'Current' for current information, time frame for historic information
- LICENSE_LIMIT_GB: Configured license limit (GB)
                    Attention: Be aware that no historic license limits are available, so always the current license limit is displayed and considered.
- LICENSE_USAGE_GB: Already used license memory (GB)
- USAGE_PCT:        License usage (%)

[EXAMPLE OUTPUT]

---------------------------------------------------------------------
|TIME_INTERVAL          |LICENSE_LIMIT_GB|LICENSE_USAGE_GB|USAGE_PCT|
---------------------------------------------------------------------
|Current                |            5120|            3040|    59.37|
|2014/04/01 - 2014/04/19|            5120|            2815|    54.98|
|2014/03/01 - 2014/03/31|            5120|            3040|    59.37|
|2014/02/01 - 2014/02/28|            5120|            2768|    54.06|
|2014/01/01 - 2014/01/31|            5120|            2479|    48.41|
|2013/12/01 - 2013/12/31|            5120|            2298|    44.88|
---------------------------------------------------------------------

*/
  TIME_INTERVAL,
  LPAD(PRODUCT_LIMIT, 16) LICENSE_LIMIT_GB,
  CASE WHEN LIMIT_CURRENT_USAGE_BY_GAL = ' ' THEN LPAD(PRODUCT_USAGE, 16) ELSE LPAD(TO_DECIMAL(LEAST(PRODUCT_USAGE, GAL_GB), 10, 0), 16) END LICENSE_USAGE_GB,
  LPAD(TO_DECIMAL(
    CASE 
      WHEN PRODUCT_LIMIT = 0 THEN 0 
      WHEN LIMIT_CURRENT_USAGE_BY_GAL = ' ' THEN PRODUCT_USAGE / PRODUCT_LIMIT * 100 
      ELSE LEAST(PRODUCT_USAGE, GAL_GB) / PRODUCT_LIMIT * 100
    END, 10, 2), 9) USAGE_PCT
FROM
( SELECT                         /* Modification section */
    'CURRENT' DATA_SOURCE,               /* CURRENT, HISTORY, % */
    'X' LIMIT_CURRENT_USAGE_BY_GAL
  FROM
    DUMMY
) BI,
( SELECT MAX(ALLOCATION_LIMIT) / 1024 / 1024 / 1024 GAL_GB FROM M_HOST_RESOURCE_UTILIZATION ) H,
( SELECT
    'CURRENT' DATA_SOURCE,
    'Current' TIME_INTERVAL,
    PRODUCT_USAGE,
    PRODUCT_LIMIT
  FROM
    M_LICENSE
  UNION ALL
  ( SELECT
      'HISTORY' DATA_SOURCE,
      TO_VARCHAR(LH.PERIOD_START_TIME, 'YYYY/MM/DD') || ' - ' || TO_VARCHAR(LH.PERIOD_END_TIME, 'YYYY/MM/DD') TIME_INTERVAL,
      LH.PRODUCT_USAGE,
      L.PRODUCT_LIMIT
    FROM
      M_LICENSE L,
      M_LICENSE_USAGE_HISTORY LH
  )
) L
WHERE
  L.DATA_SOURCE LIKE BI.DATA_SOURCE
ORDER BY
  TIME_INTERVAL DESC