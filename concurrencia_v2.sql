SELECT
	STATEMENT_HASH,
	STATEMENT_ID,
	DB_USER,
	APPLICATION_NAME,
	SCHEMA_NAME,
	APP_USER,
	DURATION_MICROSEC,
	START_TIME,
	TO_DATE(START_TIME) AS Dia,
	TO_TIME(START_TIME)AS Hora_inicio,
	TO_TIME(ADD_SECONDS(START_TIME, Round((DURATION_MICROSEC / 1000000), 2))) Hora_fin,
	Round((DURATION_MICROSEC / 1000000), 2) AS SEGUNDOS,
	Round((DURATION_MICROSEC / 1000000)/ 60, 2) AS MINUTOS,
	RECORDS,
	Round(MEMORY_SIZE /power(1024,3) , 2) AS Memory,
	STATEMENT_MEMORY_LIMIT,
	CPU_TIME,
	ERROR_TEXT,
	OPERATION,
	STATEMENT_THREAD_LIMIT,
	WORKLOAD_CLASS_NAME
	FROM OTBI.TR_EXPENSIVE_STATEMENTS
	WHERE START_TIME BETWEEN TO_TIMESTAMP('2025-01-26 04:10:00', 'YYYY-MM-DD HH24:MI:SS') 
		AND TO_TIMESTAMP('2025-01-28 04:10:59', 'YYYY-MM-DD HH24:MI:SS')
		AND OPERATION NOT LIKE '%AGGREGATED_EXECUTION%'
		AND Round(MEMORY_SIZE /power(1024,3) , 2) > 0
	ORDER BY
		START_TIME ASC,
		MEMORY_SIZE DESC;
		
	
	
	
	
	
	
	
	
	
	
	
	--consulta para Power BI Final
	-------------------------------------------------------------------------------
	SELECT
	'OTBI ' AS ORIGEN,
	ttr.STATEMENT_HASH,
	ttr.STATEMENT_ID,
	ttr.DB_USER,
	ttr.APPLICATION_NAME,
	ttr.SCHEMA_NAME,
	ttr.APP_USER,
	ttr.DURATION_MICROSEC,
	ttr.START_TIME,
	TO_DATE(ttr.START_TIME) AS Dia,
	TO_TIME(ttr.START_TIME)AS Hora_inicio,
	TO_TIME(ADD_SECONDS(ttr.START_TIME, Round((ttr.DURATION_MICROSEC / 1000000), 2))) Hora_fin,
	ttr.RECORDS,
	Round(ttr.MEMORY_SIZE /power(1024,3) , 2) AS Memory,
	ttr.STATEMENT_MEMORY_LIMIT,
	ttr.CPU_TIME,
	ttr.ERROR_TEXT,
	ttr.OPERATION,
	ttr.STATEMENT_THREAD_LIMIT,
	ttr.WORKLOAD_CLASS_NAME
	FROM OTBI.TR_EXPENSIVE_STATEMENTS AS ttr
	WHERE ttr.START_TIME >= ADD_DAYS(CURRENT_DATE,-7)
		AND ttr.OPERATION NOT LIKE '%AGGREGATED_EXECUTION%'
		AND Round(ttr.MEMORY_SIZE /power(1024,3) , 2) > 0

		UNION ALL
		
	SELECT
	'SYS ' AS ORIGEN,
	tme.STATEMENT_HASH,
	tme.STATEMENT_ID,
	tme.DB_USER,
	tme.APPLICATION_NAME,
	tme.SCHEMA_NAME,
	tme.APP_USER,
	tme.DURATION_MICROSEC,
	tme.START_TIME,
	TO_DATE(tme.START_TIME) AS Dia,
	TO_TIME(tme.START_TIME)AS Hora_inicio,
	TO_TIME(ADD_SECONDS(tme.START_TIME, Round((tme.DURATION_MICROSEC / 1000000), 2))) Hora_fin,
	tme.RECORDS,
	Round(tme.MEMORY_SIZE /power(1024,3) , 2) AS Memory,
	tme.STATEMENT_MEMORY_LIMIT,
	tme.CPU_TIME,
	tme.ERROR_TEXT,
	tme.OPERATION,
	tme.STATEMENT_THREAD_LIMIT,
	tme.WORKLOAD_CLASS_NAME
	FROM SYS.M_EXPENSIVE_STATEMENTS AS tme
	WHERE to_varchar(tme.START_TIME, 'YYYY-MM-DD') >= TO_VARCHAR(CURRENT_DATE, 'YYYY-MM-DD') 
		AND tme.OPERATION NOT LIKE 'AGGRE%'
		AND Round(tme.MEMORY_SIZE /power(1024,3) , 2) > 0
	
	
-------------------------------------------------------------------------------------------------	
	
	SELECT  DISTINCT 
	  ttr.WORKLOAD_CLASS_NAME,
	  ttr.DB_USER,
	 	ttr.STATEMENT_ID,
	  ttr.STATEMENT_HASH, 
		ttr.START_TIME,
		'OTBI ' AS ORIGEN,
		Round((ttr.DURATION_MICROSEC / 1000000)/ 60, 2) AS Duracion_MIN,
		Round(ttr.MEMORY_SIZE /power(1024,3) , 2) AS Memoria_GB
		FROM OTBI.TR_EXPENSIVE_STATEMENTS AS ttr
		WHERE ttr.START_TIME >= ADD_DAYS(CURRENT_DATE,-7)
		AND OPERATION NOT LIKE 'AGGRE%' 
	--	ORDER BY STATEMENT_ID, STATEMENT_HASH
		
		UNION all
		
		SELECT 
	  tme.WORKLOAD_CLASS_NAME,
	  tme.DB_USER,
	  tme.STATEMENT_ID,
	  tme.STATEMENT_HASH, 
		tme.START_TIME,
		'SYS ' AS ORIGEN,
		Round((tme.DURATION_MICROSEC / 1000000)/ 60, 2) AS Duracion_MIN,
		Round(tme.MEMORY_SIZE /power(1024,3) , 2) AS Memoria_GB
		FROM SYS.M_EXPENSIVE_STATEMENTS AS tme
		WHERE to_varchar(tme.START_TIME, 'YYYY-MM-DD') >= TO_VARCHAR(CURRENT_DATE, 'YYYY-MM-DD') 
		AND OPERATION NOT LIKE 'AGGRE%'
	
	--
		
--gant
		SELECT
	'SYS ' AS ORIGEN,
	tme.STATEMENT_HASH,
	tme.STATEMENT_ID,
	tme.DB_USER,
	tme.APPLICATION_NAME,
	tme.SCHEMA_NAME,
	tme.APP_USER,
	tme.DURATION_MICROSEC,
	tme.START_TIME,
	ADD_SECONDS(tme.START_TIME, Round((tme.DURATION_MICROSEC / 1000000), 2)) END_TIME,
	TO_DATE(tme.START_TIME) AS Dia,
	TO_TIME(tme.START_TIME)AS Hora_inicio,
	TO_TIME(ADD_SECONDS(tme.START_TIME, Round((tme.DURATION_MICROSEC / 1000000), 2))) Hora_fin,
	tme.RECORDS,
	Round(tme.MEMORY_SIZE /power(1024,3) , 2) AS Memory,
	tme.STATEMENT_MEMORY_LIMIT,
	tme.CPU_TIME,
	tme.ERROR_TEXT,
	tme.OPERATION,
	tme.STATEMENT_THREAD_LIMIT,
	tme.WORKLOAD_CLASS_NAME
	FROM SYS.M_EXPENSIVE_STATEMENTS AS tme
	WHERE to_varchar(tme.START_TIME, 'YYYY-MM-DD') >= TO_VARCHAR(CURRENT_DATE, 'YYYY-MM-DD') 
		AND tme.OPERATION NOT LIKE 'AGGRE%'
		AND Round(tme.MEMORY_SIZE /power(1024,3) , 2) > 0
		
		
		--replicado de memoria de Worload
		--"SYS"."M_WORKLOAD_CLASS_STATISTICS"
		
		
		--Workloads
		
	/*
		limitacion_S_SNPGLUE
		usuarios_batch
		Limitacion_AVENTA
		Limitacion_agregada_venta
		Limitacion_100_python
		Limitacion_SYSTEM_1500
		Limitacion_S_DSTAGE_EDW_E33VEP
		Limitacion_S_DSTAGE_EDW_MULTICANAL
		EdC_General
		*/ 
		CREATE COLUMN TABLE "KING"."SNAPSHOT_WORKLOAD_HISTORY" (
		
		"HOST" varchar(64),
		"PORT" int,
		"SNAPSHOT" TIMESTAMP,
		"WORKLOAD_CLASS_NAME" nvarchar(256),
		"TOTAL_STATEMENT_MEMORY_SIZE" BIGINT,
		"TOTAL_STATEMENT_CPU_TIME" BIGINT,
		"TOTAL_STATEMENT_ADMIT_COUNT" BIGINT,
		PRIMARY KEY (HOST, PORT,SNAPSHOT, WORKLOAD_CLASS_NAME)
	) PARTITION BY HASH (WORKLOAD_CLASS_NAME) PARTITIONS 6;
		
drop TABLE "KING"."SNAPSHOT_WORKLOAD_HISTORY"

--- procedure insert 
INSERT
	INTO
	"KING"."SNAPSHOT_WORKLOAD_HISTORY"
SELECT
	HOST,
	PORT,
	ADD_DAYS(CURRENT_TIMESTAMP,-7)  AS SNAPSHOT,
	WORKLOAD_CLASS_NAME,
	TOTAL_STATEMENT_MEMORY_SIZE,
	TOTAL_STATEMENT_CPU_TIME,
	TOTAL_STATEMENT_ADMIT_COUNT
FROM
	"SYS"."M_WORKLOAD_CLASS_STATISTICS"
WHERE PORT = '30003'
	AND WORKLOAD_CLASS_NAME 
	IN ('limitacion_S_SNPGLUE',
		'usuarios_batch',
		'Limitacion_AVENTA',
		'Limitacion_agregada_venta',
		'Limitacion_100_python',
		'Limitacion_SYSTEM_1500',
		'Limitacion_S_DSTAGE_EDW_E33VEP',
		'Limitacion_S_DSTAGE_EDW_MULTICANAL',
		'EdC_General')
	
	--------------------------------------------------------
		
		--procedure delete 
		
	DELETE FROM "KING"."SNAPSHOT_WORKLOAD_HISTORY" WHERE  SNAPSHOT < to_date(ADD_DAYS(CURRENT_TIMESTAMP,-6));

SELECT * FROM  "KING"."SNAPSHOT_WORKLOAD_HISTORY" WHERE SNAPSHOT < to_date(ADD_DAYS(CURRENT_TIMESTAMP,-6))
SELECT to_date(ADD_DAYS(CURRENT_TIMESTAMP,-7)) AS snapshot FROM dummy;
	
	SELECT * FROM "KING"."SNAPSHOT_WORKLOAD_HISTORY"
	
	CALL "KING"."KING.Monitors.Workload_Snapshot::Workload_Snapshot_History" ();
	CALL "KING"."KING.Monitors.Workload_Snapshot::PR_WORKLOAD_SNAPSHOT_HISTORY"();
	

SELECT * FROM sys.EFFECTIVE_PRIVILEGES WHERE USER_NAME = 'KING' 

--privilegios

GRANT SELECT ON SCHEMA KING TO _SYS_REPO WITH GRANT OPTION
GRANT CREATE ANY  ON SCHEMA KING TO _SYS_REPO WITH GRANT OPTION

GRANT EXECUTE ON SCHEMA KING TO _SYS_REPO

--control de job y 


CREATE COLUMN TABLE "KING"."LOG_JOB_CONTROL" LIKE "OTBI"."LO_JOB_CONTROL"
CREATE COLUMN TABLE "KING"."LOG_JOB_EXECUTIONS" LIKE "OTBI"."LO_JOB_EXECUTIONS";
CREATE COLUMN TABLE "KING"."LOG_JOB_TRACE" LIKE "OTBI"."LO_JOB_TRACE";