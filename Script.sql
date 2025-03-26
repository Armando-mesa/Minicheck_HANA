
--fc29a8105061940c30edf122c3aadad8

select	distinct "a15"."CODDIVIS"  "CODDIVIS",
	"a15"."CODEMPRE"  "CODEMPRE",
	"a110"."DESDIVIS"  "DESDIVIS",
	coalesce("pa11"."CUNECOVE", "pa12"."CUNECOVE", "pa13"."CUNECOVE")  "CUNECOVE",
	coalesce("pa11"."CODEMPRE", "pa12"."CODEMPRE", "pa13"."CODEMPRE")  "CODEMPRE0",
	"a15"."DESDEPAR"  "DESDEPAR",
	CONCAT("a15"."CODEMPRE", "a15"."CODDEPAR")  "DESCUNECO",
	coalesce("pa11"."Operacion", "pa12"."Operacion", "pa13"."Operacion")  "Operacion",
	coalesce("pa11"."CVENDEDO", "pa12"."CVENDEDO", "pa13"."CVENDEDO")  "CVENDEDO",
	coalesce("pa11"."FVENTMOV", "pa12"."FVENTMOV", "pa13"."FVENTMOV")  "FVENTMOV",
	coalesce("pa11"."DNOMBREE", "pa12"."DNOMBREE", "pa13"."DNOMBREE")  "DNOMBREE",
	coalesce("pa11"."DAPELLI12", "pa12"."DAPELLI12", "pa13"."DAPELLI12")  "DAPELLI1",
	coalesce("pa11"."DAPELLI11", "pa12"."DAPELLI11", "pa13"."DAPELLI11")  "DAPELLI10",
	coalesce("pa11"."DAPELLI10", "pa12"."DAPELLI10", "pa13"."DAPELLI10")  "DAPELLI11",
	coalesce("pa11"."DAPELLI1", "pa12"."DAPELLI1", "pa13"."DAPELLI1")  "DAPELLI12",
	coalesce("pa11"."FCOMULTI", "pa12"."FCOMULTI", "pa13"."FCOMULTI")  "FCOMULTI",
	coalesce("pa11"."FECHA_ULTG", "pa12"."FECHA_ULTG", "pa13"."FECHA_ULTG")  "FECHA_ULTG",
	coalesce("pa11"."CRESGULT", "pa12"."CRESGULT", "pa13"."CRESGULT")  "CRESGULT",
	"a17"."DRESGULT"  "DRESGULT",
	coalesce("pa11"."NUMLINEA", "pa12"."NUMLINEA", "pa13"."NUMLINEA")  "NUMLINEA",
	"a14"."CFAMILIA"  "FAMILIA_VEP",
	"a111"."DESFAMIL"  "DESFAMIL",
	"a14"."CBARRAAA"  "CBARRAAA",
	coalesce("pa11"."CREFEREN", "pa12"."CREFEREN", "pa13"."CREFEREN")  "CREFEREN",
	"a16"."DDESCMOD"  "DDESCMOD",
	coalesce("pa11"."CTALLAAA", "pa12"."CTALLAAA", "pa13"."CTALLAAA")  "CTALLAAA",
	"a16"."CMARCAAC"  "CMARCAAC",
	coalesce("pa11"."DOBSERVA", "pa12"."DOBSERVA", "pa13"."DOBSERVA")  "DOBSERVA",
	coalesce("pa11"."FCOMPROM", "pa12"."FCOMPROM", "pa13"."FCOMPROM")  "FCOMPROM",
	coalesce("pa11"."CSITUMOV", "pa12"."CSITUMOV", "pa13"."CSITUMOV")  "CSITUMOV",
	"a18"."DSITUMOL"  "DSITUMOL",
	coalesce("pa11"."CTIPSERV", "pa12"."CTIPSERV", "pa13"."CTIPSERV")  "CTIPSERV",
	"a19"."DTIPSERL"  "DTIPSERL",
	"pa11"."WJXBFS1"  "WJXBFS1",
	"pa12"."WJXBFS1"  "WJXBFS2",
	"pa12"."WJXBFS2"  "WJXBFS3",
	"pa13"."WJXBFS1"  "WJXBFS4",
	"pa12"."WJXBFS3"  "WJXBFS5",
	"pa11"."WJXBFS2"  "WJXBFS6",
	"pa12"."WJXBFS4"  "WJXBFS7",
	"pa11"."WJXBFS3"  "WJXBFS8",
	"pa11"."WJXBFS4"  "WJXBFS9"
from	(select	"a11"."CVENDEDO"  "CVENDEDO",
		"a11"."CUNECOVE"  "CUNECOVE",
		"a11"."CEMPRMOV"  "CODEMPRE",
		TO_DATE ("a14"."FULTGEST")  "FECHA_ULTG",
		"a11"."CTIPSERV"  "CTIPSERV",
		"a12"."NTELEFO2"  "DAPELLI1",
		"a12"."NTELEFO1"  "DAPELLI10",
		"a11"."CTALLAOR"  "CTALLAAA",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
		"a11"."CRGULTOP"  "CRESGULT",
		"a11"."CREFEREN"  "CREFEREN",
		"a13"."DOBSERVA"  "DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
		"a11"."NUMLINEA"  "NUMLINEA",
		"a12"."DNOMBREE"  "DNOMBREE",
		"a11"."FVENTMOV"  "FVENTMOV",
		"a11"."FCOMPROM"  "FCOMPROM",
		"a11"."FCOMULTI"  "FCOMULTI",
		"a12"."DAPELLI2"  "DAPELLI11",
		"a12"."DAPELLI1"  "DAPELLI12",
		sum("a11"."QEXISCEN")  "WJXBFS1",
		sum((IFNULL("a11"."QUNCMACT", 0) - IFNULL("a11"."QUNCMUTI", 0)))  "WJXBFS2",
		sum("a11"."QCANPENT")  "WJXBFS3",
		sum("a11"."QCANPREC")  "WJXBFS4"
	from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150901"	"a11"
		join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
		  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a12"."FVENTMOV")
		join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/CV_FACT_MOVIMIENTOS"	"a13"
		  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a13"."FVENTMOV" and 
		"a12"."CTERMMOV" = "a13"."CTERMMOV")
		join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a14"
		  on 	("a11"."CCENTMOV" = "a14"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a14"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a14"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a14"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a14"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a14"."FVENTMOV" and 
		"a12"."CTERMMOV" = "a14"."CTERMMOV")
		join	(select	"a12"."DAPELLI1"  "DAPELLI1",
			"a12"."DAPELLI2"  "DAPELLI10",
			"a11"."FCOMULTI"  "FCOMULTI",
			"a11"."FCOMPROM"  "FCOMPROM",
			"a11"."FVENTMOV"  "FVENTMOV",
			"a12"."DNOMBREE"  "DNOMBREE",
			"a11"."NUMLINEA"  "NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
			"a11"."DOBSERVA"  "DOBSERVA",
			"a11"."CREFEREN"  "CREFEREN",
			"a11"."CRGULTOP"  "CRESGULT",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
			"a11"."CTALLAOR"  "CTALLAAA",
			"a12"."NTELEFO1"  "DAPELLI11",
			"a12"."NTELEFO2"  "DAPELLI12",
			"a11"."CTIPSERV"  "CTIPSERV",
			TO_DATE ("a13"."FULTGEST")  "FECHA_ULTG",
			"a11"."CUNECOVE"  "CUNECOVE",
			"a11"."CEMPRMOV"  "CODEMPRE",
			"a11"."CVENDEDO"  "CVENDEDO"
		from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150201"	"a11"
			join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
			  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a12"."FVENTMOV")
			join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a13"
			  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a13"."FVENTMOV")
		where	("a11"."CEMPRMOV" in ('004')
		 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
		 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
		 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
		group by	"a12"."DAPELLI1",
			"a12"."DAPELLI2",
			"a11"."FCOMULTI",
			"a11"."FCOMPROM",
			"a11"."FVENTMOV",
			"a12"."DNOMBREE",
			"a11"."NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
			"a11"."DOBSERVA",
			"a11"."CREFEREN",
			"a11"."CRGULTOP",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
			"a11"."CTALLAOR",
			"a12"."NTELEFO1",
			"a12"."NTELEFO2",
			"a11"."CTIPSERV",
			TO_DATE ("a13"."FULTGEST"),
			"a11"."CUNECOVE",
			"a11"."CEMPRMOV",
			"a11"."CVENDEDO"
		having	(sum("a11"."QCANPENT") + sum("a11"."QCANPREC")) > 0
		)	"pa15"
		  on 	("a11"."CEMPRMOV" = "pa15"."CODEMPRE" and 
		"a11"."CREFEREN" = "pa15"."CREFEREN" and 
		"a11"."CRGULTOP" = "pa15"."CRESGULT" and 
		"a11"."CTALLAOR" = "pa15"."CTALLAAA" and 
		"a11"."CTIPSERV" = "pa15"."CTIPSERV" and 
		"a11"."CUNECOVE" = "pa15"."CUNECOVE" and 
		"a11"."CVENDEDO" = "pa15"."CVENDEDO" and 
		"a11"."FCOMPROM" = "pa15"."FCOMPROM" and 
		"a11"."FCOMULTI" = "pa15"."FCOMULTI" and 
		"a11"."FVENTMOV" = "pa15"."FVENTMOV" and 
		"a11"."NUMLINEA" = "pa15"."NUMLINEA" and 
		"a12"."DAPELLI1" = "pa15"."DAPELLI1" and 
		"a12"."DAPELLI2" = "pa15"."DAPELLI10" and 
		"a12"."DNOMBREE" = "pa15"."DNOMBREE" and 
		"a12"."NTELEFO1" = "pa15"."DAPELLI11" and 
		"a12"."NTELEFO2" = "pa15"."DAPELLI12" and 
		"a13"."DOBSERVA" = "pa15"."DOBSERVA" and 
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV") = "pa15"."Operacion" and 
		TO_DATE ("a14"."FULTGEST") = "pa15"."FECHA_ULTG" and 
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end = "pa15"."CSITUMOV")
	where	("a11"."CEMPRMOV" in ('004')
	 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
	 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
	 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
	group by	"a11"."CVENDEDO",
		"a11"."CUNECOVE",
		"a11"."CEMPRMOV",
		TO_DATE ("a14"."FULTGEST"),
		"a11"."CTIPSERV",
		"a12"."NTELEFO2",
		"a12"."NTELEFO1",
		"a11"."CTALLAOR",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
		"a11"."CRGULTOP",
		"a11"."CREFEREN",
		"a13"."DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
		"a11"."NUMLINEA",
		"a12"."DNOMBREE",
		"a11"."FVENTMOV",
		"a11"."FCOMPROM",
		"a11"."FCOMULTI",
		"a12"."DAPELLI2",
		"a12"."DAPELLI1"
	)	"pa11"
	full outer join	(select	"a11"."CVENDEDO"  "CVENDEDO", ---analizar 
		"a11"."CUNECOVE"  "CUNECOVE",
		"a11"."CEMPRMOV"  "CODEMPRE",
		TO_DATE ("a14"."FULTGEST")  "FECHA_ULTG",
		"a11"."CTIPSERV"  "CTIPSERV",
		"a12"."NTELEFO2"  "DAPELLI1",
		"a12"."NTELEFO1"  "DAPELLI10",
		"a11"."CTALLAOR"  "CTALLAAA",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
		"a11"."CRGULTOP"  "CRESGULT",
		"a11"."CREFEREN"  "CREFEREN",
		"a13"."DOBSERVA"  "DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
		"a11"."NUMLINEA"  "NUMLINEA",
		"a12"."DNOMBREE"  "DNOMBREE",
		"a11"."FVENTMOV"  "FVENTMOV",
		"a11"."FCOMPROM"  "FCOMPROM",
		"a11"."FCOMULTI"  "FCOMULTI",
		"a12"."DAPELLI2"  "DAPELLI11",
		"a12"."DAPELLI1"  "DAPELLI12",
		sum("a11"."IMPLVTAP")  "WJXBFS1",
		sum("a11"."QCANTIDA")  "WJXBFS2",
		sum("a11"."QCANCUMP")  "WJXBFS3",
		sum("a11"."QCANRESC")  "WJXBFS4"
	from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150302"	"a11"
		join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
		  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a12"."FVENTMOV")
		join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/CV_FACT_MOVIMIENTOS"	"a13"
		  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a13"."FVENTMOV")
		join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a14"
		  on 	("a11"."CCENTMOV" = "a14"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a14"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a14"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a14"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a14"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a14"."FVENTMOV")
		join	(select	"a12"."DAPELLI1"  "DAPELLI1",
			"a12"."DAPELLI2"  "DAPELLI10",
			"a11"."FCOMULTI"  "FCOMULTI",
			"a11"."FCOMPROM"  "FCOMPROM",
			"a11"."FVENTMOV"  "FVENTMOV",
			"a12"."DNOMBREE"  "DNOMBREE",
			"a11"."NUMLINEA"  "NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
			"a11"."DOBSERVA"  "DOBSERVA",
			"a11"."CREFEREN"  "CREFEREN",
			"a11"."CRGULTOP"  "CRESGULT",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
			"a11"."CTALLAOR"  "CTALLAAA",
			"a12"."NTELEFO1"  "DAPELLI11",
			"a12"."NTELEFO2"  "DAPELLI12",
			"a11"."CTIPSERV"  "CTIPSERV",
			TO_DATE ("a13"."FULTGEST")  "FECHA_ULTG",
			"a11"."CUNECOVE"  "CUNECOVE",
			"a11"."CEMPRMOV"  "CODEMPRE",
			"a11"."CVENDEDO"  "CVENDEDO"
		from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150201"	"a11"
			join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
			  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a12"."FVENTMOV")
			join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a13"
			  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a13"."FVENTMOV")
		where	("a11"."CEMPRMOV" in ('004')
		 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
		 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
		 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
		group by	"a12"."DAPELLI1",
			"a12"."DAPELLI2",
			"a11"."FCOMULTI",
			"a11"."FCOMPROM",
			"a11"."FVENTMOV",
			"a12"."DNOMBREE",
			"a11"."NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
			"a11"."DOBSERVA",
			"a11"."CREFEREN",
			"a11"."CRGULTOP",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
			"a11"."CTALLAOR",
			"a12"."NTELEFO1",
			"a12"."NTELEFO2",
			"a11"."CTIPSERV",
			TO_DATE ("a13"."FULTGEST"),
			"a11"."CUNECOVE",
			"a11"."CEMPRMOV",
			"a11"."CVENDEDO"
		having	(sum("a11"."QCANPENT") + sum("a11"."QCANPREC")) > 0
		)	"pa15"
		  on 	("a11"."CEMPRMOV" = "pa15"."CODEMPRE" and 
		"a11"."CREFEREN" = "pa15"."CREFEREN" and 
		"a11"."CRGULTOP" = "pa15"."CRESGULT" and 
		"a11"."CTALLAOR" = "pa15"."CTALLAAA" and 
		"a11"."CTIPSERV" = "pa15"."CTIPSERV" and 
		"a11"."CUNECOVE" = "pa15"."CUNECOVE" and 
		"a11"."CVENDEDO" = "pa15"."CVENDEDO" and 
		"a11"."FCOMPROM" = "pa15"."FCOMPROM" and 
		"a11"."FCOMULTI" = "pa15"."FCOMULTI" and 
		"a11"."FVENTMOV" = "pa15"."FVENTMOV" and 
		"a11"."NUMLINEA" = "pa15"."NUMLINEA" and 
		"a12"."DAPELLI1" = "pa15"."DAPELLI1" and 
		"a12"."DAPELLI2" = "pa15"."DAPELLI10" and 
		"a12"."DNOMBREE" = "pa15"."DNOMBREE" and 
		"a12"."NTELEFO1" = "pa15"."DAPELLI11" and 
		"a12"."NTELEFO2" = "pa15"."DAPELLI12" and 
		"a13"."DOBSERVA" = "pa15"."DOBSERVA" and 
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV") = "pa15"."Operacion" and 
		TO_DATE ("a14"."FULTGEST") = "pa15"."FECHA_ULTG" and 
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end = "pa15"."CSITUMOV")
	where	("a11"."CEMPRMOV" in ('004')
	 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
	 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
	 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
	group by	"a11"."CVENDEDO",
		"a11"."CUNECOVE",
		"a11"."CEMPRMOV",
		TO_DATE ("a14"."FULTGEST"),
		"a11"."CTIPSERV",
		"a12"."NTELEFO2",
		"a12"."NTELEFO1",
		"a11"."CTALLAOR",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
		"a11"."CRGULTOP",
		"a11"."CREFEREN",
		"a13"."DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
		"a11"."NUMLINEA",
		"a12"."DNOMBREE",
		"a11"."FVENTMOV",
		"a11"."FCOMPROM",
		"a11"."FCOMULTI",
		"a12"."DAPELLI2",
		"a12"."DAPELLI1"
	)	"pa12"
	  on 	("pa11"."CODEMPRE" = "pa12"."CODEMPRE" and 
	"pa11"."CREFEREN" = "pa12"."CREFEREN" and 
	"pa11"."CRESGULT" = "pa12"."CRESGULT" and 
	"pa11"."CSITUMOV" = "pa12"."CSITUMOV" and 
	"pa11"."CTALLAAA" = "pa12"."CTALLAAA" and 
	"pa11"."CTIPSERV" = "pa12"."CTIPSERV" and 
	"pa11"."CUNECOVE" = "pa12"."CUNECOVE" and 
	"pa11"."CVENDEDO" = "pa12"."CVENDEDO" and 
	"pa11"."DAPELLI1" = "pa12"."DAPELLI1" and 
	"pa11"."DAPELLI10" = "pa12"."DAPELLI10" and 
	"pa11"."DAPELLI11" = "pa12"."DAPELLI11" and 
	"pa11"."DAPELLI12" = "pa12"."DAPELLI12" and 
	"pa11"."DNOMBREE" = "pa12"."DNOMBREE" and 
	"pa11"."DOBSERVA" = "pa12"."DOBSERVA" and 
	"pa11"."FCOMPROM" = "pa12"."FCOMPROM" and 
	"pa11"."FCOMULTI" = "pa12"."FCOMULTI" and 
	"pa11"."FECHA_ULTG" = "pa12"."FECHA_ULTG" and 
	"pa11"."FVENTMOV" = "pa12"."FVENTMOV" and 
	"pa11"."NUMLINEA" = "pa12"."NUMLINEA" and 
	"pa11"."Operacion" = "pa12"."Operacion")
	full outer join	(select	"a11"."CVENDEDO"  "CVENDEDO",
		"a11"."CUNECOVE"  "CUNECOVE",
		"a11"."CEMPRMOV"  "CODEMPRE",
		TO_DATE ("a13"."FULTGEST")  "FECHA_ULTG",
		"a11"."CTIPSERV"  "CTIPSERV",
		"a12"."NTELEFO2"  "DAPELLI1",
		"a12"."NTELEFO1"  "DAPELLI10",
		"a11"."CTALLAOR"  "CTALLAAA",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
		"a11"."CRGULTOP"  "CRESGULT",
		"a11"."CREFEREN"  "CREFEREN",
		"a11"."DOBSERVA"  "DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
		"a11"."NUMLINEA"  "NUMLINEA",
		"a12"."DNOMBREE"  "DNOMBREE",
		"a11"."FVENTMOV"  "FVENTMOV",
		"a11"."FCOMPROM"  "FCOMPROM",
		"a11"."FCOMULTI"  "FCOMULTI",
		"a12"."DAPELLI2"  "DAPELLI11",
		"a12"."DAPELLI1"  "DAPELLI12",
		max(to_int(days_between("a11"."FCOMPROM",to_date(add_days(now(),-1)))))  "WJXBFS1"
	from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150201"	"a11"
		join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
		  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a12"."FVENTMOV")
		join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a13"
		  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
		"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
		"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
		"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
		"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
		"a11"."FVENTMOV" = "a13"."FVENTMOV")
		join	(select	"a12"."DAPELLI1"  "DAPELLI1",
			"a12"."DAPELLI2"  "DAPELLI10",
			"a11"."FCOMULTI"  "FCOMULTI",
			"a11"."FCOMPROM"  "FCOMPROM",
			"a11"."FVENTMOV"  "FVENTMOV",
			"a12"."DNOMBREE"  "DNOMBREE",
			"a11"."NUMLINEA"  "NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV")  "Operacion",
			"a11"."DOBSERVA"  "DOBSERVA",
			"a11"."CREFEREN"  "CREFEREN",
			"a11"."CRGULTOP"  "CRESGULT",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end  "CSITUMOV",
			"a11"."CTALLAOR"  "CTALLAAA",
			"a12"."NTELEFO1"  "DAPELLI11",
			"a12"."NTELEFO2"  "DAPELLI12",
			"a11"."CTIPSERV"  "CTIPSERV",
			TO_DATE ("a13"."FULTGEST")  "FECHA_ULTG",
			"a11"."CUNECOVE"  "CUNECOVE",
			"a11"."CEMPRMOV"  "CODEMPRE",
			"a11"."CVENDEDO"  "CVENDEDO"
		from	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150201"	"a11"
			join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_MOVIMIENTOS_VEP"	"a12"
			  on 	("a11"."CCENTMOV" = "a12"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a12"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a12"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a12"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a12"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a12"."FVENTMOV")
			join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150801"	"a13"
			  on 	("a11"."CCENTMOV" = "a13"."CCENTMOV" and 
			"a11"."CEMPRMOV" = "a13"."CEMPRMOV" and 
			"a11"."CHALTMOV" = "a13"."CHALTMOV" and 
			"a11"."CTERMMOV" = "a13"."CTERMMOV" and 
			"a11"."CTRANMOV" = "a13"."CTRANMOV" and 
			"a11"."FVENTMOV" = "a13"."FVENTMOV")
		where	("a11"."CEMPRMOV" in ('004')
		 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
		 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
		 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
		group by	"a12"."DAPELLI1",
			"a12"."DAPELLI2",
			"a11"."FCOMULTI",
			"a11"."FCOMPROM",
			"a11"."FVENTMOV",
			"a12"."DNOMBREE",
			"a11"."NUMLINEA",
			CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
			"a11"."DOBSERVA",
			"a11"."CREFEREN",
			"a11"."CRGULTOP",
			case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
			"a11"."CTALLAOR",
			"a12"."NTELEFO1",
			"a12"."NTELEFO2",
			"a11"."CTIPSERV",
			TO_DATE ("a13"."FULTGEST"),
			"a11"."CUNECOVE",
			"a11"."CEMPRMOV",
			"a11"."CVENDEDO"
		having	(sum("a11"."QCANPENT") + sum("a11"."QCANPREC")) > 0
		)	"pa14"
		  on 	("a11"."CEMPRMOV" = "pa14"."CODEMPRE" and 
		"a11"."CREFEREN" = "pa14"."CREFEREN" and 
		"a11"."CRGULTOP" = "pa14"."CRESGULT" and 
		"a11"."CTALLAOR" = "pa14"."CTALLAAA" and 
		"a11"."CTIPSERV" = "pa14"."CTIPSERV" and 
		"a11"."CUNECOVE" = "pa14"."CUNECOVE" and 
		"a11"."CVENDEDO" = "pa14"."CVENDEDO" and 
		"a11"."DOBSERVA" = "pa14"."DOBSERVA" and 
		"a11"."FCOMPROM" = "pa14"."FCOMPROM" and 
		"a11"."FCOMULTI" = "pa14"."FCOMULTI" and 
		"a11"."FVENTMOV" = "pa14"."FVENTMOV" and 
		"a11"."NUMLINEA" = "pa14"."NUMLINEA" and 
		"a12"."DAPELLI1" = "pa14"."DAPELLI1" and 
		"a12"."DAPELLI2" = "pa14"."DAPELLI10" and 
		"a12"."DNOMBREE" = "pa14"."DNOMBREE" and 
		"a12"."NTELEFO1" = "pa14"."DAPELLI11" and 
		"a12"."NTELEFO2" = "pa14"."DAPELLI12" and 
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV") = "pa14"."Operacion" and 
		TO_DATE ("a13"."FULTGEST") = "pa14"."FECHA_ULTG" and 
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end = "pa14"."CSITUMOV")
	where	("a11"."CEMPRMOV" in ('004')
	 and ("a11"."CCENTMOV" = '0140' and "a11"."CEMPRMOV" = '004')
	 and case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end in ('? ', '00')
	 and "a11"."CRGULTOP" not in ('022', '031', '190', '189', '303', '089'))
	group by	"a11"."CVENDEDO",
		"a11"."CUNECOVE",
		"a11"."CEMPRMOV",
		TO_DATE ("a13"."FULTGEST"),
		"a11"."CTIPSERV",
		"a12"."NTELEFO2",
		"a12"."NTELEFO1",
		"a11"."CTALLAOR",
		case when ("a11"."CSITUMOV") = '?' then '? ' else "a11"."CSITUMOV" end,
		"a11"."CRGULTOP",
		"a11"."CREFEREN",
		"a11"."DOBSERVA",
		CONCAT("a11"."CTERMMOV", "a11"."CTRANMOV"),
		"a11"."NUMLINEA",
		"a12"."DNOMBREE",
		"a11"."FVENTMOV",
		"a11"."FCOMPROM",
		"a11"."FCOMULTI",
		"a12"."DAPELLI2",
		"a12"."DAPELLI1"
	)	"pa13"
	  on 	(coalesce("pa11"."CODEMPRE", "pa12"."CODEMPRE") = "pa13"."CODEMPRE" and 
	coalesce("pa11"."CREFEREN", "pa12"."CREFEREN") = "pa13"."CREFEREN" and 
	coalesce("pa11"."CRESGULT", "pa12"."CRESGULT") = "pa13"."CRESGULT" and 
	coalesce("pa11"."CSITUMOV", "pa12"."CSITUMOV") = "pa13"."CSITUMOV" and 
	coalesce("pa11"."CTALLAAA", "pa12"."CTALLAAA") = "pa13"."CTALLAAA" and 
	coalesce("pa11"."CTIPSERV", "pa12"."CTIPSERV") = "pa13"."CTIPSERV" and 
	coalesce("pa11"."CUNECOVE", "pa12"."CUNECOVE") = "pa13"."CUNECOVE" and 
	coalesce("pa11"."CVENDEDO", "pa12"."CVENDEDO") = "pa13"."CVENDEDO" and 
	coalesce("pa11"."DAPELLI1", "pa12"."DAPELLI1") = "pa13"."DAPELLI1" and 
	coalesce("pa11"."DAPELLI10", "pa12"."DAPELLI10") = "pa13"."DAPELLI10" and 
	coalesce("pa11"."DAPELLI11", "pa12"."DAPELLI11") = "pa13"."DAPELLI11" and 
	coalesce("pa11"."DAPELLI12", "pa12"."DAPELLI12") = "pa13"."DAPELLI12" and 
	coalesce("pa11"."DNOMBREE", "pa12"."DNOMBREE") = "pa13"."DNOMBREE" and 
	coalesce("pa11"."DOBSERVA", "pa12"."DOBSERVA") = "pa13"."DOBSERVA" and 
	coalesce("pa11"."FCOMPROM", "pa12"."FCOMPROM") = "pa13"."FCOMPROM" and 
	coalesce("pa11"."FCOMULTI", "pa12"."FCOMULTI") = "pa13"."FCOMULTI" and 
	coalesce("pa11"."FECHA_ULTG", "pa12"."FECHA_ULTG") = "pa13"."FECHA_ULTG" and 
	coalesce("pa11"."FVENTMOV", "pa12"."FVENTMOV") = "pa13"."FVENTMOV" and 
	coalesce("pa11"."NUMLINEA", "pa12"."NUMLINEA") = "pa13"."NUMLINEA" and 
	coalesce("pa11"."Operacion", "pa12"."Operacion") = "pa13"."Operacion")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.VentaProceso/VC150201"	"a14"
	  on 	(coalesce("pa11"."CREFEREN", "pa12"."CREFEREN", "pa13"."CREFEREN") = "a14"."CREFEREN" and 
	coalesce("pa11"."NUMLINEA", "pa12"."NUMLINEA", "pa13"."NUMLINEA") = "a14"."NUMLINEA")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_UNECO_VENTA"	"a15"
	  on 	(coalesce("pa11"."CODEMPRE", "pa12"."CODEMPRE", "pa13"."CODEMPRE") = "a15"."CODEMPRE" and 
	coalesce("pa11"."CUNECOVE", "pa12"."CUNECOVE", "pa13"."CUNECOVE") = "a15"."CODDEPAR")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_ARTICULOS"	"a16"
	  on 	(coalesce("pa11"."CREFEREN", "pa12"."CREFEREN", "pa13"."CREFEREN") = "a16"."CODARTIC")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_RESULTADO_GESTION"	"a17"
	  on 	(coalesce("pa11"."CRESGULT", "pa12"."CRESGULT", "pa13"."CRESGULT") = "a17"."CRESGULT")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_SITUACION_MOVIMIENTO"	"a18"
	  on 	(coalesce("pa11"."CSITUMOV", "pa12"."CSITUMOV", "pa13"."CSITUMOV") = case when ("a18"."CSITUMOV") = '?' then '? ' else "a18"."CSITUMOV" end)
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_TIPO_SERVICIO"	"a19"
	  on 	(coalesce("pa11"."CTIPSERV", "pa12"."CTIPSERV", "pa13"."CTIPSERV") = "a19"."CTIPSERV")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_DIVISION_VENTA"	"a110"
	  on 	("a15"."CODDIVIS" = "a110"."CODDIVIS" and 
	"a15"."CODEMPRE" = "a110"."CODEMPRE")
	join	"_SYS_BIC"."AreaSIBI.Proyectos.Maestras/CV_DIM_FAMILIA_ARTICULO"	"a111"
	  on 	("a14"."CFAMILIA" = "a111"."CMFAMILI")