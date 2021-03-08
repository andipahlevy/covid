USE [db_sep]
GO
/****** Object:  View [dbo].[vw_COVID_data_new]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_COVID_data_new]
AS

SELECT CAST(tanggal_buat AS DATE) tanggal_buat,
	CONVERT(CHAR(8),MAX(tanggal_buat),114) jam_buat,
	nik, lokasi_kerja, catatan_lokasi_kerja,
	CAST(lokasi_detail AS VARCHAR(MAX)) lokasi_detail, suhu_tubuh,
	MAX(CASE WHEN id_pertanyaan = 1 THEN score END) score1,
	MAX(CASE WHEN id_pertanyaan = 2 THEN score END) score2,
	MAX(CASE WHEN id_pertanyaan = 3 THEN score END) score3,
	MAX(CASE WHEN id_pertanyaan = 4 THEN score END) score4,
	MAX(CASE WHEN id_pertanyaan = 5 THEN score END) score5,
	MAX(CASE WHEN id_pertanyaan = 6 THEN score END) score6,
	MAX(CASE WHEN id_pertanyaan = 7 THEN score END) score7,
	MAX(CASE WHEN id_pertanyaan = 8 THEN score END) score8,
	MAX(CASE WHEN id_pertanyaan = 9 THEN score END) score9,
	MAX(CASE WHEN id_pertanyaan = 10 THEN score END) score10,
	MAX(CASE WHEN id_pertanyaan = 11 THEN score END) score11,
	MAX(CASE WHEN id_pertanyaan = 12 THEN score END) score12,
	MAX(CASE WHEN id_pertanyaan = 12 THEN suhu_tertinggi END) suhu_tertinggi12,
	MAX(CASE WHEN id_pertanyaan = 12 THEN gejala END) gejala12,
	MAX(CASE WHEN id_pertanyaan = 12 THEN riwayat_dokter END) riwayat_dokter12
FROM dbo.tbl_ass_data
WHERE na = 'n' AND del = 'n'
GROUP BY CAST(tanggal_buat AS DATE), nik, lokasi_kerja, catatan_lokasi_kerja,
	CAST(lokasi_detail AS VARCHAR(MAX)), suhu_tubuh

GO
/****** Object:  View [dbo].[vw_COVID_dataganda_new]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_COVID_dataganda_new]
AS

SELECT CAST(tanggal_buat AS DATE) tanggal_buat, nik, lokasi_kerja, CAST(lokasi_detail AS VARCHAR(MAX)) lokasi_detail, suhu_tubuh,
	MAX(CASE WHEN id_pertanyaan = 1 THEN jawaban END) jawaban1,
	MAX(CASE WHEN id_pertanyaan = 1 THEN catatan END) catatan1,
	MAX(CASE WHEN id_pertanyaan = 2 THEN jawaban END) jawaban2,
	MAX(CASE WHEN id_pertanyaan = 2 THEN catatan END) catatan2,
	MAX(CASE WHEN id_pertanyaan = 3 THEN jawaban END) jawaban3,
	MAX(CASE WHEN id_pertanyaan = 3 THEN catatan END) catatan3,
	MAX(CASE WHEN id_pertanyaan = 4 THEN jawaban END) jawaban4,
	MAX(CASE WHEN id_pertanyaan = 4 THEN catatan END) catatan4,
	--MAX(CASE WHEN id_pertanyaan = 5 THEN jawaban END) jawaban5,
	--MAX(CASE WHEN id_pertanyaan = 5 THEN catatan END) catatan5,
	--MAX(CASE WHEN id_pertanyaan = 6 THEN jawaban END) jawaban6,
	--MAX(CASE WHEN id_pertanyaan = 6 THEN catatan END) catatan6,
	--MAX(CASE WHEN id_pertanyaan = 7 THEN jawaban END) jawaban7,
	--MAX(CASE WHEN id_pertanyaan = 7 THEN catatan END) catatan7
	MAX(CASE WHEN id_pertanyaan = 8 THEN jawaban END) jawaban8,
	MAX(CASE WHEN id_pertanyaan = 8 THEN catatan END) catatan8,
	MAX(CASE WHEN id_pertanyaan = 8 THEN hubungan_keluarga_ganda END) hubungan_keluarga8,
	MAX(CASE WHEN id_pertanyaan = 8 THEN REPLACE(jarak_ganda,'&lt;','< ') END) jarak8,
	MAX(CASE WHEN id_pertanyaan = 8 THEN REPLACE(REPLACE(interaksi_ganda,0,'Tidak'),1,'Ya') END) interaksi8,
	MAX(CASE WHEN id_pertanyaan = 9 THEN jawaban END) jawaban9,
	MAX(CASE WHEN id_pertanyaan = 9 THEN catatan END) catatan9,
	MAX(CASE WHEN id_pertanyaan = 9 THEN hubungan_keluarga_ganda END) hubungan_keluarga9,
	MAX(CASE WHEN id_pertanyaan = 9 THEN REPLACE(jarak_ganda,'&lt;','< ') END) jarak9,
	MAX(CASE WHEN id_pertanyaan = 9 THEN REPLACE(REPLACE(interaksi_ganda,0,'Tidak'),1,'Ya') END) interaksi9,
	MAX(CASE WHEN id_pertanyaan = 10 THEN jawaban END) jawaban10,
	MAX(CASE WHEN id_pertanyaan = 10 THEN catatan END) catatan10,
	MAX(CASE WHEN id_pertanyaan = 10 THEN hubungan_keluarga_ganda END) hubungan_keluarga10,
	MAX(CASE WHEN id_pertanyaan = 10 THEN REPLACE(jarak_ganda,'&lt;','< ') END) jarak10,
	MAX(CASE WHEN id_pertanyaan = 10 THEN REPLACE(REPLACE(interaksi_ganda,0,'Tidak'),1,'Ya') END) interaksi10,
	MAX(CASE WHEN id_pertanyaan = 11 THEN jawaban END) jawaban11,
	MAX(CASE WHEN id_pertanyaan = 11 THEN catatan END) catatan11,
	MAX(CASE WHEN id_pertanyaan = 11 THEN hubungan_keluarga_ganda END) hubungan_keluarga11,
	MAX(CASE WHEN id_pertanyaan = 11 THEN REPLACE(jarak_ganda,'&lt;','< ') END) jarak11,
	MAX(CASE WHEN id_pertanyaan = 11 THEN REPLACE(REPLACE(interaksi_ganda,0,'Tidak'),1,'Ya') END) interaksi11
FROM dbo.tbl_ass_data_ganda
WHERE na = 'n' AND del = 'n'
GROUP BY CAST(tanggal_buat AS DATE), nik, lokasi_kerja, CAST(lokasi_detail AS VARCHAR(MAX)), suhu_tubuh

GO
/****** Object:  View [dbo].[vw_KaryawanDivisi]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_KaryawanDivisi]
AS

SELECT ISNULL(divisi,'N/A') divisi, nik, nama
FROM dbo.tbl_ass_user
WHERE na = 'n' AND del = 'n'

GO
/****** Object:  Table [dbo].[M_Category]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_Category](
	[Category_ID] [int] NOT NULL,
	[Category_Name] [varchar](50) NULL,
	[Category_Description] [varchar](255) NULL,
	[Category_Status] [char](1) NULL,
	[Category_CreateDate] [datetime] NULL,
	[Category_CreateID] [int] NULL,
	[Category_EditDate] [datetime] NULL,
	[Category_EditID] [int] NULL,
 CONSTRAINT [PK_M_Category] PRIMARY KEY CLUSTERED 
(
	[Category_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_Report]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_Report](
	[Report_ID] [int] NOT NULL,
	[Report_Name] [varchar](255) NULL,
	[Report_CategoryID] [int] NULL,
	[Report_Link] [varchar](255) NULL,
	[Report_Proc] [varchar](255) NULL,
	[Report_Status] [char](1) NULL,
	[Report_AccessStatus] [char](1) NULL,
	[Report_CreateDate] [datetime] NULL,
	[Report_CreateID] [int] NULL,
 CONSTRAINT [PK_M_Report] PRIMARY KEY CLUSTERED 
(
	[Report_ID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 1, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_ReportColumns]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_ReportColumns](
	[Columns_ReportID] [int] NULL,
	[Columns_Order] [int] NULL,
	[Columns_Name] [varchar](50) NULL,
	[Columns_Title] [varchar](255) NULL,
	[Columns_Format] [varchar](50) NULL,
	[Columns_Align] [varchar](50) NULL,
	[Columns_Group] [varchar](50) NULL,
	[Columns_Total] [varchar](50) NULL,
	[Columns_Width] [int] NULL,
	[Columns_Visible] [varchar](50) NULL,
	[Columns_Fixed] [varchar](50) NULL,
	[Columns_Loop] [varchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_ReportDetail]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_ReportDetail](
	[ReportDetail_ID] [int] NOT NULL,
	[ReportDetail_Component] [varchar](50) NULL,
	[ReportDetail_API] [varchar](255) NULL,
	[ReportDetail_Card] [varchar](50) NULL,
	[ReportDetail_Table] [varchar](50) NULL,
	[ReportDetail_Params] [varchar](255) NULL,
	[ReportDetail_Icon] [varchar](50) NULL,
	[ReportDetail_Color] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_DivisiGet]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_DivisiGet]
AS

SELECT DISTINCT divisi
FROM dbo.tbl_ass_user
WHERE na = 'n' AND del = 'n'
ORDER BY divisi
GO
/****** Object:  StoredProcedure [dbo].[proc_ReportAvailableGet]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [dbo].[proc_ReportAvailableGet] 1
CREATE PROCEDURE [dbo].[proc_ReportAvailableGet] (@UserID INT)
AS

--DECLARE @UserID INT
--SET @UserID = 1

SELECT Report_ID, Report_Name,
	Report_Link, ReportDetail_Color Report_Color,
	Report_Status, Report_AccessStatus,
	ISNULL(Category_ID,0) Category_ID,
--	ISNULL(Category_Name,'Category doesn''t exist') Category_Name, Cnt
	ISNULL(Category_Name,'Category doesn''t exist') Category_Name, 1 Cnt
FROM dbo.M_Report
WITH (NOLOCK)
LEFT JOIN dbo.M_ReportDetail
	ON ReportDetail_ID = Report_ID
LEFT JOIN dbo.M_Category
	ON Category_ID = Report_CategoryID
		AND Category_Status = 'A'
--LEFT JOIN
--	(
--		SELECT Category_ID CatID, COUNT(Report_ID) Cnt
--		FROM dbo.M_Category
--		LEFT JOIN dbo.M_Report
--			ON Category_ID = Report_CategoryID
--		LEFT JOIN dbo.T_ReportChild
--			ON ReportChild_ReportID = Report_ID
--		WHERE Report_Status = 'A'
--			AND Report_AccessStatus = 'E'
--			AND ISNULL(ReportChild_Status,'') <> 'A'
--		GROUP BY Category_ID
--	) X
--	ON CatID = Category_ID
--LEFT JOIN dbo.T_ReportChild
--	ON ReportChild_ReportID = Report_ID
WHERE Report_Status = 'A'
	AND Report_AccessStatus = 'E'
	--AND ISNULL(ReportChild_Status,'') <> 'A'
--UNION ALL
--SELECT Report_ID, Report_Name,
--	Report_Link, ReportDetail_Color Report_Color,
--	Report_Status, Report_AccessStatus,
--	ISNULL(Category_ID,0) Category_ID,
--	ISNULL(Category_Name,'Category doesn''t exist') Category_Name, Cnt
--FROM dbo.M_Report
--WITH (NOLOCK)
--LEFT JOIN dbo.M_ReportDetail
--	ON ReportDetail_ID = Report_ID
--LEFT JOIN dbo.M_Category
--	ON Category_ID = Report_CategoryID
--		AND Category_Status = 'A'
--LEFT JOIN
--	(
--		SELECT Category_ID CatID, COUNT(Report_ID) Cnt
--		FROM dbo.M_Category
--		LEFT JOIN dbo.M_Report
--			ON Category_ID = Report_CategoryID
--		LEFT JOIN dbo.T_ReportChild
--			ON ReportChild_ReportID = Report_ID
--		WHERE Report_AccessStatus = 'R'
--			AND ISNULL(ReportChild_Status,'') <> 'A'
--		GROUP BY Category_ID
--	) X
--	ON CatID = Category_ID
--LEFT JOIN dbo.T_ReportAccess
--	ON ReportAccess_ReportID = Report_ID
--LEFT JOIN dbo.T_ReportChild
--	ON ReportChild_ReportID = Report_ID
--WHERE Report_AccessStatus = 'R'
--	AND ISNULL(ReportChild_Status,'') <> 'A'
--	AND ReportAccess_UserID = @UserID
--ORDER BY Cnt DESC, Report_Name
ORDER BY Cnt DESC, Report_Name
GO
/****** Object:  StoredProcedure [dbo].[proc_ReportDetailGet]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_ReportDetailGet] (@ReportID INT)
AS

--DECLARE @ReportID INT
--SET @ReportID = 1

SELECT Report_ID, Report_Name, Report_Proc, Report_Link, Report_CategoryID,
	ISNULL(ReportDetail_API,Report_Link+'/get') Report_API, ISNULL(ReportDetail_Params,'from,to,plant') Report_Params,
	ISNULL(ReportDetail_Card,'CardReportPeriod') Report_Card, ISNULL(ReportDetail_Table,'Compact') Report_Table,
	ISNULL(ReportDetail_Color,'info') Report_Color
FROM dbo.M_Report
WITH (NOLOCK)
LEFT JOIN dbo.M_ReportDetail
	ON ReportDetail_ID = Report_ID
WHERE Report_Status = 'A'
	AND Report_ID = @ReportID

GO
/****** Object:  StoredProcedure [dbo].[proc_ReportParamsGet]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_ReportParamsGet] (@ReportID INT)
AS

--DECLARE @ReportID INT
--SET @ReportID = 26

--Judul Kolom
SELECT Columns_Name [name], Columns_Title [title]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID
ORDER BY Columns_Order

--Kolom yang di group (subtotal)
SELECT Columns_Name columnName, Columns_Group [type]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID AND Columns_Group IS NOT NULL
ORDER BY Columns_Order

--Kolom yang di total
SELECT Columns_Name columnName, Columns_Total [type]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID AND Columns_Total IS NOT NULL
ORDER BY Columns_Order

--Alignment kolom
SELECT Columns_Name columnName, Columns_Align [align]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID AND Columns_Align IS NOT NULL
ORDER BY Columns_Order

--Format kolom
SELECT Columns_Name Kolom, Columns_Format Format
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID AND Columns_Format IS NOT NULL
ORDER BY Columns_Order

--Semua parameter
SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	ISNULL(Columns_Fixed,'false') [fixed]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID
ORDER BY Columns_Order

--Semua parameter, sebelum Loop
SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	ISNULL(Columns_Fixed,'false') [fixed]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID
	AND Columns_Loop = 'Before'
ORDER BY Columns_Order

--Semua parameter, Loop
SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	ISNULL(Columns_Fixed,'false') [fixed]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID
	AND Columns_Loop = 'Loop'
ORDER BY Columns_Order

--Semua parameter, setelah Loop
SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	ISNULL(Columns_Fixed,'false') [fixed]
FROM dbo.M_ReportColumns
WITH (NOLOCK)
WHERE Columns_ReportID = @ReportID
	AND Columns_Loop = 'After'
ORDER BY Columns_Order

GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment '2020-06-15', '2020-06-15', 'SEP - HO'
CREATE PROCEDURE [dbo].[sp_DailyAssessment] @From DateTime, @To DateTime, @Divisi VARCHAR(MAX)
AS

--DECLARE @From DATE
--SET @From = '2021-02-17'
--DECLARE @To DATE
--SET @To = '2021-02-17'
--DECLARE @Divisi VARCHAR(MAX)
--SET @Divisi = 'SEP - HO'

SET @Divisi = ''+REPLACE(@Divisi,',',''',''')+''

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##DailyAssessment')
DROP TABLE ##DailyAssessment

SELECT A.divisi+' - '+A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama, B.jam_buat JamIsi,
	B.suhu_tubuh Suhu, B.lokasi_detail LokasiGPS,
	UPPER(B.lokasi_kerja)+CASE WHEN B.catatan_lokasi_kerja = '' THEN '' ELSE ', '+B.catatan_lokasi_kerja END LokasiKerja,
	CASE WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 = 0				THEN 'Kecil'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 BETWEEN 1 AND 7	THEN 'Sedang'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 >= 8				THEN 'Besar'
	END Resiko,
	CASE WHEN B.score1 = 0 THEN 'Tidak' WHEN B.score1 = 3 THEN 'Ya, Kendaraan Pribadi'
										WHEN B.score1 = 4 THEN 'Ya, Kendaraan Umum' END score1,
	CASE WHEN B.score2 = 0 THEN 'Tidak' WHEN B.score2 > 0 THEN 'Ya' END score2,
	CASE WHEN B.score3 = 0 THEN 'Tidak' WHEN B.score3 > 0 THEN 'Ya' END score3,
	CASE WHEN B.score4 = 0 THEN 'Tidak' WHEN B.score4 > 0 THEN 'Ya' END score4,
	CASE WHEN B.score5 = 0 THEN 'Tidak' WHEN B.score5 > 0 THEN 'Ya' END score5,
	CASE WHEN B.score6 = 0 THEN 'Tidak' WHEN B.score6 > 0 THEN 'Ya' END score6,
	CASE WHEN B.score7 = 0 THEN 'Tidak' WHEN B.score7 > 0 THEN 'Ya' END score7,
	CASE WHEN B.score8 = 0 THEN 'Tidak' WHEN B.score8 > 0 THEN 'Ya' END score8,
	CASE WHEN B.score9 = 0 THEN 'Tidak' WHEN B.score9 > 0 THEN 'Ya' END score9,
	CASE WHEN B.score10 = 0 THEN 'Tidak' WHEN B.score10 > 0 THEN 'Ya' END score10,	
	CASE WHEN B.score11 = 0 THEN 'Tidak' WHEN B.score11 > 0 THEN 'Ya' END score11,	
	CASE WHEN B.score12 = 0 THEN 'Tidak' WHEN B.score12 > 0 THEN 'Ya' END score12,
	CASE WHEN B.suhu_tertinggi12 <> '0' THEN B.suhu_tertinggi12 ELSE NULL END suhu_tertinggi12,
	B.gejala12, B.riwayat_dokter12,
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 + ', ' + C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1,
	CASE WHEN C.jawaban2 <> '' AND C.catatan2 <> '' THEN C.jawaban2 + ', ' + C.catatan2
	WHEN C.jawaban2 <> '' THEN C.jawaban2 ELSE C.catatan2 END jawab2,
	CASE WHEN C.jawaban3 <> '' AND C.catatan3 <> '' THEN C.jawaban3 + ', ' + C.catatan3
	WHEN C.jawaban3 <> '' THEN C.jawaban3 ELSE C.catatan3 END jawab3,
	CASE WHEN C.jawaban4 <> '' AND C.catatan4 <> '' THEN C.jawaban4 + ', ' + C.catatan4
	WHEN C.jawaban4 <> '' THEN C.jawaban4 ELSE C.catatan4 END jawab4,
	C.jawaban8 jawab8, C.hubungan_keluarga8, C.jarak8, C.interaksi8,
	C.jawaban9 jawab9, C.hubungan_keluarga9, C.jarak9, C.interaksi9,
	C.jawaban10 jawab10, C.hubungan_keluarga10, C.jarak10, C.interaksi10,
	C.jawaban11 jawab11, C.hubungan_keluarga11, C.jarak11, C.interaksi11
INTO ##DailyAssessment
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN @From AND @To
LEFT JOIN dbo.vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)

EXEC('
IF ''ALL'' NOT IN ('''+@Divisi+''')
DELETE ##DailyAssessment
WHERE divisi NOT IN ('''+@Divisi+''')
')

SELECT *
FROM ##DailyAssessment
ORDER BY ID
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_14Hari]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_14Hari '2020-07-28', '2020-07-28'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_14Hari] @From Date, @To Date
AS

--DECLARE @From DATE
--DECLARE @To DATE

SET @From = CAST(DATEADD(DAY,-13,@To) AS DATE)
SET @To = CAST(@To AS DATE)

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##Cov14Hari_Kry')
DROP TABLE ##Cov14Hari_Kry

EXEC('
SELECT nik, nama, divisi, posisi
INTO ##Cov14Hari_Kry
FROM dbo.vw_KaryawanDivisi
')

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#Cov14Hari_Tgl%')
DROP TABLE #Cov14Hari_Tgl

SELECT ACTDT
INTO #Cov14Hari_Tgl
FROM SAPSYNC.dbo.ZKISSTT_0138
WHERE ACTDT BETWEEN @From AND @To

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#Cov14Hari_NamaTgl%')
DROP TABLE #Cov14Hari_NamaTgl

SELECT nik, nama, divisi, posisi, ACTDT
INTO #Cov14Hari_NamaTgl
FROM ##Cov14Hari_Kry
CROSS JOIN #Cov14Hari_Tgl

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##Cov14Hari_Input')
DROP TABLE ##Cov14Hari_Input

SELECT A.nik NIK, A.nama Nama, A.divisi Divisi, A.posisi Jabatan, A.ACTDT, CAST('H-'+CAST(DATEDIFF(DAY,A.ACTDT,GETDATE()) AS VARCHAR(2)) AS VARCHAR(5)) Hari,
	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6 Score
INTO ##Cov14Hari_Input
FROM #Cov14Hari_NamaTgl A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) = A.ACTDT

INSERT INTO ##Cov14Hari_Input
SELECT NIK, Nama, Divisi, Jabatan, GETDATE(), 'TOTAL', SUM(ISNULL(Score,0))
FROM ##Cov14Hari_Input
GROUP BY NIK, Nama, Divisi, Jabatan

DECLARE @Period CHAR(10)
SET @Period = CAST(@From AS CHAR(10))
DECLARE @PeriodSeries VARCHAR(MAX)
SET @PeriodSeries = ''

WHILE CAST(@Period AS DATE) <= @To
BEGIN
	SET @PeriodSeries = @PeriodSeries + '[' + 'H-'+CAST(DATEDIFF(DAY,CAST(@Period AS DATE),GETDATE()) AS VARCHAR(2)) + '],'
	
	SET @Period = CAST(DATEADD(DAY,1,CAST(@Period AS DATE)) AS CHAR(10))
END

SET @PeriodSeries = @PeriodSeries + '[TOTAL]'

EXEC('
IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = ''##Cov14Hari_Pivot'')
DROP TABLE ##Cov14Hari_Pivot

SELECT NIK, Nama, Divisi, Jabatan, '+@PeriodSeries+'
INTO ##Cov14Hari_Pivot
FROM 
	(
		SELECT NIK, Nama, Divisi, Jabatan, Hari, COL, VAL
		FROM ##Cov14Hari_Input
		CROSS APPLY (VALUES	(''Score'',	[Score])) CS (COL, VAL)
		WHERE VAL IS NOT NULL
	) T
	PIVOT (SUM(VAL) FOR Hari IN ('+ @PeriodSeries +')) PVT
')

SELECT NIK ID, NULL parent, *,
	CASE WHEN TOTAL = 0 THEN 'HIJAU'
	WHEN TOTAL BETWEEN 1 AND 69 THEN 'ORANGE'
	WHEN TOTAL >= 70 THEN 'RED' END Status
FROM ##Cov14Hari_Pivot
ORDER BY Divisi, Nama
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Divisi]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_Divisi '2020-06-15', '2020-06-15', 'SEP - HO'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Divisi] @From DateTime, @To DateTime, @Divisi VARCHAR(MAX)
AS

--DECLARE @From DATE
--SET @From = '2020-07-21'
--DECLARE @To DATE
--SET @To = '2020-07-21'
--DECLARE @Divisi VARCHAR(MAX)
--SET @Divisi = 'SEP - HO'

SET @Divisi = ''+REPLACE(@Divisi,',',''',''')+''

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##DailyAssessment')
DROP TABLE ##DailyAssessment

SELECT A.divisi+' - '+A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama, B.jam_buat JamIsi,
	B.suhu_tubuh Suhu, B.lokasi_detail LokasiGPS, UPPER(B.lokasi_kerja) LokasiKerja,
	CASE WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 = 0				THEN 'Kecil'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 BETWEEN 1 AND 7	THEN 'Sedang'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 >= 8				THEN 'Besar'
	END Resiko,
	CASE WHEN B.score1 = 0 THEN 'Tidak' WHEN B.score1 = 3 THEN 'Ya, Kendaraan Pribadi'
										WHEN B.score1 = 4 THEN 'Ya, Kendaraan Umum' END score1,
	CASE WHEN B.score2 = 0 THEN 'Tidak' WHEN B.score2 > 0 THEN 'Ya' END score2,
	CASE WHEN B.score3 = 0 THEN 'Tidak' WHEN B.score3 > 0 THEN 'Ya' END score3,
	CASE WHEN B.score4 = 0 THEN 'Tidak' WHEN B.score4 > 0 THEN 'Ya' END score4,
	CASE WHEN B.score5 = 0 THEN 'Tidak' WHEN B.score5 > 0 THEN 'Ya' END score5,
	CASE WHEN B.score6 = 0 THEN 'Tidak' WHEN B.score6 > 0 THEN 'Ya' END score6,
	CASE WHEN B.score7 = 0 THEN 'Tidak' WHEN B.score7 > 0 THEN 'Ya' END score7,
	CASE WHEN B.score8 = 0 THEN 'Tidak' WHEN B.score8 > 0 THEN 'Ya' END score8,
	CASE WHEN B.score9 = 0 THEN 'Tidak' WHEN B.score9 > 0 THEN 'Ya' END score9,
	CASE WHEN B.score10 = 0 THEN 'Tidak' WHEN B.score10 > 0 THEN 'Ya' END score10,	
	CASE WHEN B.score11 = 0 THEN 'Tidak' WHEN B.score11 > 0 THEN 'Ya' END score11,	
	CASE WHEN B.score12 = 0 THEN 'Tidak' WHEN B.score12 > 0 THEN 'Ya' END score12,
	CASE WHEN B.suhu_tertinggi12 <> '0' THEN B.suhu_tertinggi12 ELSE NULL END suhu_tertinggi12,
	B.gejala12, B.riwayat_dokter12,
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 + ', ' + C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1,
	CASE WHEN C.jawaban2 <> '' AND C.catatan2 <> '' THEN C.jawaban2 + ', ' + C.catatan2
	WHEN C.jawaban2 <> '' THEN C.jawaban2 ELSE C.catatan2 END jawab2,
	CASE WHEN C.jawaban3 <> '' AND C.catatan3 <> '' THEN C.jawaban3 + ', ' + C.catatan3
	WHEN C.jawaban3 <> '' THEN C.jawaban3 ELSE C.catatan3 END jawab3,
	CASE WHEN C.jawaban4 <> '' AND C.catatan4 <> '' THEN C.jawaban4 + ', ' + C.catatan4
	WHEN C.jawaban4 <> '' THEN C.jawaban4 ELSE C.catatan4 END jawab4,
	C.jawaban8 jawab8, C.hubungan_keluarga8, C.jarak8, C.interaksi8,
	C.jawaban9 jawab9, C.hubungan_keluarga9, C.jarak9, C.interaksi9,
	C.jawaban10 jawab10, C.hubungan_keluarga10, C.jarak10, C.interaksi10,
	C.jawaban11 jawab11, C.hubungan_keluarga11, C.jarak11, C.interaksi11
INTO ##DailyAssessment
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN @From AND @To
LEFT JOIN dbo.vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)

EXEC('
IF ''ALL'' NOT IN ('''+@Divisi+''')
DELETE ##DailyAssessment
WHERE divisi NOT IN ('''+@Divisi+''')
')

SELECT *
FROM ##DailyAssessment
ORDER BY ID
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Input]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_Input '2020-06-15', '2020-06-15'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Input] @From DateTime, @To DateTime
AS

--DECLARE @From DATE
--SET @From = GETDATE()

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#CovInput_Input%')
DROP TABLE #CovInput_Input

SELECT A.nik, A.nama, A.divisi, B.tanggal_buat,
	CASE WHEN B.score1 IS NULL THEN 0 ELSE 1 END Input
INTO #CovInput_Input
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) = @From

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#CovInput_Persen%')
DROP TABLE #CovInput_Persen

SELECT SUM(Input) Sudah, 1.0*SUM(Input)/COUNT(Input)*100 PSudah,
	COUNT(Input)-SUM(Input) Belum, 1.0*(COUNT(Input)-SUM(Input))/COUNT(Input)*100 PBelum,
	COUNT(Input) Total
INTO #CovInput_Persen
FROM #CovInput_Input

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#CovInput_Nama%')
DROP TABLE #CovInput_Nama

SELECT nik, nama, divisi,
	CASE WHEN Input = 0 THEN 'Belum' ELSE 'Sudah' END Input
INTO #CovInput_Nama
FROM #CovInput_Input

SELECT nik ID, NULL parent, nik, nama, divisi, Input
FROM #CovInput_Nama
ORDER BY Input, divisi, nama

SELECT 'Sudah Input' CountLabel, Sudah CountData, ROUND(PSudah,0) Percentage
FROM #CovInput_Persen
UNION ALL
SELECT 'Belum Input' CountLabel, Belum CountData, ROUND(PBelum,0) Percentage
FROM #CovInput_Persen
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_KasusLingkungan]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_KasusLingkungan '2020-07-21', '2020-07-21'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_KasusLingkungan] @From DateTime, @To DateTime
AS

--DECLARE @From DATE
--SET @From = '2020-07-22'
--DECLARE @To DATE
--SET @To = '2020-07-22'

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#DailyAssessment_KasusLingkungan%')
DROP TABLE #DailyAssessment_KasusLingkungan

SELECT A.divisi Divisi,
	   ISNULL(COUNT(CASE WHEN ISNULL(C.jawaban8,'') <> 'Ya' AND ISNULL(C.jawaban9,'') <> 'Ya'
							AND ISNULL(C.jawaban10,'') <> 'Ya' AND ISNULL(C.jawaban11,'') <> 'Ya' THEN C.jawaban8 END),0) tidak_ada,
	   ISNULL(COUNT(CASE WHEN C.jawaban8 = 'Ya' THEN C.jawaban8 END),0) odp,
	   ISNULL(COUNT(CASE WHEN C.jawaban9 = 'Ya' THEN C.jawaban9 END),0) pdp,
	   ISNULL(COUNT(CASE WHEN C.jawaban10 = 'Ya' THEN C.jawaban10 END),0) otg,	   
	   ISNULL(COUNT(CASE WHEN C.jawaban11 = 'Ya' THEN C.jawaban11 END),0) positif,
	   ISNULL(COUNT(C.jawaban8),0) grand_total
INTO #DailyAssessment_KasusLingkungan
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN @From AND @To
LEFT JOIN dbo.vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
GROUP BY A.divisi

SELECT 'eksad' as parent,
	   divisi as ID,
	   *
FROM #DailyAssessment_KasusLingkungan
UNION ALL
SELECT null as parent,
	   'eksad' as ID,
	   'eksad' as divisi,
	   SUM(tidak_ada) tidak_ada,
	   SUM(odp) odp,
	   SUM(pdp) pdp,
	   SUM(otg) otg,
	   SUM(positif) positif,
	   SUM(grand_total) grand_total 
FROM #DailyAssessment_KasusLingkungan
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Keluhan_Lain]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[sp_DailyAssessment_keluhan_lain] '2020-06-10', '2020-06-10'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Keluhan_Lain] @StartDate DATE, @EndDate DATE
AS

--DECLARE @StartDate DATE
--SET @StartDate = GETDATE()

--DECLARE @EndDate DATE
--SET @EndDate = GETDATE()

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#DailyAssessment_KeluhanLain%')
DROP TABLE #DailyAssessment_KeluhanLain

SELECT divisi,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Tidak Ada' THEN jawaban END),0) tidak_ada,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Sakit Kepala' THEN jawaban END),0) sakit_kepala,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Badan Lemas' THEN jawaban END),0) badan_lemas,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Sakit Perut' THEN jawaban END),0) sakit_perut,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Diare' THEN jawaban END),0) diare,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Lain-Lain' THEN jawaban 
						 WHEN jawaban = '' THEN jawaban END),0) lainlain,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Sakit Kepala' THEN jawaban
						 WHEN jawaban = 'Badan Lemas' THEN jawaban
						 WHEN jawaban = 'Sakit Perut' THEN jawaban
						 WHEN jawaban = 'Diare' THEN jawaban
						 WHEN jawaban = 'Lain-Lain' THEN jawaban
						 WHEN jawaban = '' THEN jawaban END),0) jml_kurangsehat,
	  ISNULL(COUNT(jawaban),0) grand_total
INTO #DailyAssessment_KeluhanLain
FROM dbo.vw_KaryawanDivisi a
LEFT JOIN dbo.tbl_ass_data_ganda E on E.nik = A.nik
	AND id_pertanyaan = 1
	AND tanggal BETWEEN @StartDate and @EndDate
GROUP BY divisi
ORDER BY divisi

SELECT 'eksad' as parent,
	   divisi as ID,
	   *
FROM #DailyAssessment_KeluhanLain
UNION ALL
SELECT null as parent,
	   'eksad' as ID,
	   'eksad' as divisi,
	   SUM(tidak_ada) tidak_ada,
	   SUM(sakit_kepala) sakit_kepala,
	   SUM(badan_lemas) badan_lemas,
	   SUM(sakit_perut) sakit_perut,
	   SUM(diare) diare,
	   SUM(lainlain) lainlain,
	   null as jml_kurangsehat,
	   SUM(grand_total) grand_total 
FROM #DailyAssessment_KeluhanLain
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Kondisi_Keluarga]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[sp_DailyAssessment_kondisi_keluarga] '2020-06-10', '2020-06-10'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Kondisi_Keluarga] @StartDate DATE, @EndDate DATE
AS

--DECLARE @StartDate DATE
--SET @StartDate = GETDATE()

--DECLARE @EndDate DATE
--SET @EndDate = GETDATE()

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#DailyAssessment_KondisiKeluarga%')
DROP TABLE #DailyAssessment_KondisiKeluarga

SELECT divisi,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Tidak Ada' THEN jawaban END),0) tidak_ada,
	   ISNULL(COUNT(CASE WHEN jawaban = 'Ada, hubungan & keluhannya adalah' THEN jawaban END),0) ada,
	   ISNULL(COUNT(jawaban),0) grand_total
INTO #DailyAssessment_KondisiKeluarga
FROM dbo.vw_KaryawanDivisi a
LEFT JOIN dbo.tbl_ass_data_ganda E on E.nik = A.nik
	AND id_pertanyaan = 3
	AND tanggal BETWEEN @StartDate and @EndDate
GROUP BY divisi
ORDER BY divisi

SELECT 'eksad' as parent,
	   divisi as ID,
	   *
FROM #DailyAssessment_KondisiKeluarga
UNION ALL
SELECT null as parent,
	   'eksad' as ID,
	   'eksad' as divisi,
	   SUM(tidak_ada) tidak_ada,
	   SUM(ada) ada,
	   SUM(grand_total) grand_total 
FROM #DailyAssessment_KondisiKeluarga
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_LingkunganCovid]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_LingkunganCovid '2020-07-21', '2020-07-21'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_LingkunganCovid] @From DateTime, @To DateTime
AS

--DECLARE @From DATE
--SET @From = '2020-07-22'
--DECLARE @To DATE
--SET @To = '2020-07-22'

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#DailyAssessmentLingkunganCovid%')
DROP TABLE #DailyAssessmentLingkunganCovid

SELECT A.divisi+' - '+A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama,
	CASE WHEN C.jawaban8 <> '' AND C.catatan8 <> '' THEN C.jawaban8 + ', ' + C.catatan8
	WHEN C.jawaban8 <> '' THEN C.jawaban8 ELSE C.catatan8 END jawab8,
	hubungan_keluarga8, jarak8, interaksi8,
	CASE WHEN C.jawaban9 <> '' AND C.catatan9 <> '' THEN C.jawaban9 + ', ' + C.catatan9
	WHEN C.jawaban9 <> '' THEN C.jawaban9 ELSE C.catatan9 END jawab9,
	hubungan_keluarga9, jarak9, interaksi9,
	CASE WHEN C.jawaban10 <> '' AND C.catatan10 <> '' THEN C.jawaban10 + ', ' + C.catatan10
	WHEN C.jawaban10 <> '' THEN C.jawaban10 ELSE C.catatan10 END jawab10,
	hubungan_keluarga10, jarak10, interaksi10,
	CASE WHEN C.jawaban11 <> '' AND C.catatan11 <> '' THEN C.jawaban11 + ', ' + C.catatan11
	WHEN C.jawaban11 <> '' THEN C.jawaban11 ELSE C.catatan11 END jawab11,
	hubungan_keluarga11, jarak11, interaksi11
INTO #DailyAssessmentLingkunganCovid
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN @From AND @To
LEFT JOIN dbo.vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
WHERE A.divisi NOT IN ('BOC')

SELECT *
FROM #DailyAssessmentLingkunganCovid
WHERE jawab8 <> 'Tidak' OR
		jawab9 <> 'Tidak' OR
		jawab10 <> 'Tidak' OR
		jawab11 <> 'Tidak'
ORDER BY ID
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Rekap]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_Rekap '2020-06-15', '2020-06-15'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Rekap] @From DATETIME, @To DATETIME
AS

--DECLARE @From DATE
--DECLARE @To DATE
--SET @From = '2020-01-01'
--SET @To = '2020-10-31'

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovRekap_Tgl')
DROP TABLE ##CovRekap_Tgl

CREATE TABLE ##CovRekap_Tgl (Tanggal DATE)

DECLARE @Date DATE
SET @Date = @From

WHILE @Date <= @To
BEGIN
	INSERT INTO ##CovRekap_Tgl
	SELECT @Date

	SET @Date = DATEADD(DAY,1,@Date)
END

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovRekap_Data')
DROP TABLE ##CovRekap_Data

SELECT CONVERT(CHAR(10),Tanggal,105) Tanggal, B.nik, B.nama, B.divisi,
	0 FrekInput, 0 FrekTdkInput, CAST(0 AS FLOAT) Persen,
	CASE WHEN C.nik IS NOT NULL THEN 'Input' ELSE '' END Input
INTO ##CovRekap_Data
FROM
	(
		SELECT Tanggal
		FROM ##CovRekap_Tgl
	) A
CROSS JOIN
	(
		SELECT nik, nama, divisi
		FROM dbo.vw_KaryawanDivisi
	) B
LEFT JOIN dbo.vw_COVID_data_new C
	ON C.nik = B.nik
		AND CAST(C.tanggal_buat AS DATE) = Tanggal
WHERE Tanggal BETWEEN @From AND @To

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovRekap_Count')
DROP TABLE ##CovRekap_Count

SELECT nik nikC,
	COUNT(CASE WHEN Input = 'Input' THEN Tanggal END) FrekInputC,
	COUNT(CASE WHEN ISNULL(Input,'') = '' THEN Tanggal END) FrekTdkInputC,
	CASE WHEN COUNT(Input) = 0 THEN 0
	ELSE CAST(1.0*COUNT(CASE WHEN Input = 'Input' THEN Tanggal END)/COUNT(Tanggal) AS FLOAT) END PersenC
INTO ##CovRekap_Count
FROM ##CovRekap_Data
GROUP BY nik

UPDATE ##CovRekap_Data
SET FrekInput = FrekInputC, FrekTdkInput = FrekTdkInputC, Persen = PersenC
FROM ##CovRekap_Count
WHERE nik = nikC

DECLARE @Tanggal CHAR(10)
SET @Tanggal = CONVERT(CHAR(10),@To,105)
DECLARE @TanggalSeries VARCHAR(MAX)
SET @TanggalSeries = ''
DECLARE @Tgl CHAR(8)

WHILE CAST(RIGHT(@Tanggal,4)+SUBSTRING(@Tanggal,4,2)+LEFT(@Tanggal,2) AS DATE) >= @From
BEGIN
	SET @TanggalSeries = @TanggalSeries + '[' + @Tanggal + '],'
	
	SET @Tgl = RIGHT(@Tanggal,4)+SUBSTRING(@Tanggal,4,2)+LEFT(@Tanggal,2)
	SET @Tanggal = CONVERT(CHAR(10),DATEADD(DAY,-1,CAST(@Tgl AS DATE)),105)
END

SET @TanggalSeries = LEFT(@TanggalSeries,LEN(@TanggalSeries)-1)

EXEC('
IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = ''##CovRekap_Pivot'')
DROP TABLE ##CovRekap_Pivot

SELECT 
	nik, nama, divisi, FrekInput, FrekTdkInput, Persen, '+@TanggalSeries+'
INTO 
	##CovRekap_Pivot
FROM 
	(
		SELECT 
			nik, nama, divisi, FrekInput, FrekTdkInput, Persen, Tanggal, COL, VAL
		FROM 
			##CovRekap_Data
		CROSS APPLY 
			(
				VALUES	(''Input'',	[Input])
			) CS (COL, VAL)
		WHERE 
			VAL IS NOT NULL
	) T
	PIVOT (MAX(VAL) FOR Tanggal IN ('+ @TanggalSeries +')) PVT
')

SELECT Divisi+CAST(nik AS VARCHAR(25)) ID, NULL parent, *
FROM ##CovRekap_Pivot
ORDER BY ID

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovRekap_Cols')
DROP TABLE ##CovRekap_Cols

SELECT 
	COLUMN_NAME
INTO 
	##CovRekap_Cols
FROM 
	tempdb.INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = '##CovRekap_Pivot' AND 
	COLUMN_NAME NOT IN ('ID','parent') AND
	COLUMN_NAME NOT IN
	(
		SELECT 
			Columns_Name
		FROM 
			dbo.M_ReportColumns
		WITH (NOLOCK)
		WHERE 
			Columns_ReportID = 91 AND Columns_Loop <> 'Loop'
	)

SELECT 
	Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom]	
FROM 
	dbo.M_ReportColumns
WITH (NOLOCK)
WHERE
	Columns_ReportID = 91 AND Columns_Loop = 'Before'
UNION ALL
SELECT 
	COLUMN_NAME [name], REPLACE([title],'DD-MM-YYYY',REPLACE(COLUMN_NAME,[name],'')) [title]
	, [align], [width], [visible], [type], [custom]
FROM
	##CovRekap_Cols
CROSS JOIN 
	(
		SELECT 
			Columns_Name [name], Columns_Title [title], Columns_Align [align],
			Columns_Width [width], ISNULL(Columns_Visible,'true') [visible],
			CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
			CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom]	
		FROM 
			dbo.M_ReportColumns
		WITH (NOLOCK)
		WHERE 
			Columns_ReportID = 91 AND Columns_Loop = 'Loop'
	) B
GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_Resiko]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_Resiko '2021-02-10', '2021-02-10'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_Resiko] @From DateTime, @To DateTime
AS

--DECLARE @From DATE
--SET @From = '2021-02-10'
--DECLARE @To DATE
--SET @To = '2021-02-10'

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovResiko_Input')
DROP TABLE ##CovResiko_Input

SELECT A.nik, A.nama, A.divisi, CAST(tanggal_buat AS DATE) tanggal_buat,
	CASE WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 = 0				THEN 'Kecil'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 BETWEEN 1 AND 7	THEN 'Sedang'
		WHEN	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6+
				B.score7+B.score8+B.score9+B.score10+B.score11+B.score12 >= 8				THEN 'Besar'
	END Resiko,
	CASE WHEN score12 > 0 THEN 'Ya'
	WHEN score12 = 0 THEN 'Tidak' END score12,
	suhu_tertinggi12, gejala12, riwayat_dokter12
INTO ##CovResiko_Input
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
WHERE CAST(tanggal_buat AS DATE) BETWEEN @From AND @To

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##CovResiko_Resiko')
DROP TABLE ##CovResiko_Resiko

SELECT A.tanggal_buat, A.nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	lokasi_kerja, suhu_tubuh, tanggal_ba, gejala_ba, riwayat_ba, tindakan_ba
INTO ##CovResiko_Resiko
FROM ##CovResiko_Input A
LEFT JOIN dbo.tbl_ass_berita_acara B
	ON B.nik = A.nik AND B.tanggal_ba = A.tanggal_buat
		AND na = 'n' AND del = 'n'
WHERE Resiko = 'Besar' OR tanggal_ba IS NOT NULL

SELECT nik+CONVERT(CHAR(8),tanggal_buat,112) ID, nik parent, tanggal_buat, nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	lokasi_kerja, suhu_tubuh, tanggal_ba, gejala_ba, riwayat_ba, tindakan_ba
FROM ##CovResiko_Resiko
WHERE nik IN (	SELECT DISTINCT nik
				FROM ##CovResiko_Resiko
				WHERE tanggal_buat BETWEEN @From AND @To
				)
UNION ALL
SELECT nik ID, NULL parent, tanggal_buat, nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	NULL lokasi_kerja, NULL suhu_tubuh, NULL tanggal_ba, NULL gejala_ba, NULL riwayat_ba, NULL tindakan_ba
FROM ##CovResiko_Resiko
WHERE nik IN (	SELECT DISTINCT nik
				FROM ##CovResiko_Resiko
				WHERE tanggal_buat BETWEEN @From AND @To
				)
	AND tanggal_buat = @From
ORDER BY nik, tanggal_buat DESC

GO
/****** Object:  StoredProcedure [dbo].[sp_DailyAssessment_TidakSehat]    Script Date: 2/19/2021 10:37:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC dbo.sp_DailyAssessment_TidakSehat '2020-07-21', '2020-07-21'
CREATE PROCEDURE [dbo].[sp_DailyAssessment_TidakSehat] @From DateTime, @To DateTime
AS

--DECLARE @From DATE
--SET @From = '2020-07-22'
--DECLARE @To DATE
--SET @To = '2020-07-22'

IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name LIKE '#DailyAssessmentTidakSehat%')
DROP TABLE #DailyAssessmentTidakSehat

SELECT A.divisi+' - '+A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama,
	B.suhu_tubuh Suhu, UPPER(B.lokasi_kerja) LokasiKerja,
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 + ', ' + C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1
INTO #DailyAssessmentTidakSehat
FROM dbo.vw_KaryawanDivisi A
LEFT JOIN dbo.vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN @From AND @To
LEFT JOIN dbo.vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
WHERE A.divisi NOT IN ('BOC')
	AND (CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 + ', ' + C.catatan1
			WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END) NOT IN ('','-','Tidak Ada')

SELECT *
FROM #DailyAssessmentTidakSehat
ORDER BY ID
GO



INSERT [dbo].[M_Category] ([Category_ID], [Category_Name], [Category_Description], [Category_Status], [Category_CreateDate], [Category_CreateID], [Category_EditDate], [Category_EditID]) VALUES (5, N'HR', N'HR', N'A', CAST(N'2020-09-28T15:41:46.723' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (98, N'Daily Assessment - Shift', 5, N'hr/dailyassessmentshift', N'sp_DailyAssessment_Shift', N'N', N'E', CAST(N'2020-09-28T15:40:05.333' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (97, N'Daily Assessment - Resiko', 5, N'hr/dailyassessmentresiko', N'sp_DailyAssessment_Resiko', N'A', N'E', CAST(N'2020-09-28T15:40:05.360' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (91, N'Daily Assessment - Rekap Input', 5, N'hr/dailyassessmentrekap', N'sp_DailyAssessment_Rekap', N'A', N'E', CAST(N'2020-09-28T15:40:05.480' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (90, N'Daily Assessment - Input', 5, N'hr/dailyassessmentinput', N'sp_DailyAssessment_Input', N'A', N'E', CAST(N'2020-09-28T15:40:05.510' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (89, N'Daily Assessment - Lingkungan COVID', 5, N'hr/dailyassessmentlingkungancovid', N'sp_DailyAssessment_LingkunganCOVID', N'A', N'E', CAST(N'2020-09-28T15:40:05.540' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (88, N'Daily Assessment - Tidak Sehat', 5, N'hr/dailyassessmenttidaksehat', N'sp_DailyAssessment_TidakSehat', N'A', N'E', CAST(N'2020-09-28T15:40:05.570' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (87, N'Daily Assessment - Kondisi/Kasus di Lingkungan', 5, N'hr/dailyassessmentkondisilingkungan', N'sp_DailyAssessment_KasusLingkungan', N'A', N'E', CAST(N'2020-09-28T15:40:05.600' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (86, N'Daily Assessment - Kondisi Keluarga Sakit', 5, N'hr/dailyassessmentkondisikeluarga', N'sp_DailyAssessment_Kondisi_Keluarga', N'A', N'E', CAST(N'2020-09-28T15:40:05.630' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (85, N'Daily Assessment - Keluhan Selain Gejala COVID-19', 5, N'hr/dailyassessmentkeluhanlain', N'sp_DailyAssessment_Keluhan_Lain', N'A', N'E', CAST(N'2020-09-28T15:40:05.660' AS DateTime), 1)
GO
INSERT [dbo].[M_Report] ([Report_ID], [Report_Name], [Report_CategoryID], [Report_Link], [Report_Proc], [Report_Status], [Report_AccessStatus], [Report_CreateDate], [Report_CreateID]) VALUES (84, N'Daily Assessment - Detail', 5, N'hr/dailyassessment', N'sp_DailyAssessment', N'A', N'E', CAST(N'2020-09-28T15:40:05.690' AS DateTime), 1)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 1, N'NIK', N'NIK', N'string', N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 2, N'Nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 3, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 4, N'Shift', N'Shift', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 5, N'LokasiKerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 6, N'LokasiDetail', N'Lokasi Detail', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 7, N'AbsenIn', N'Absen In', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 8, N'AbsenOut', N'Absen Out', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (98, 9, N'LokasiAbsen', N'Lokasi Absen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 1, N'tanggal_buat', N'Tanggal', N'date', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 2, N'nik', N'NIK', N'string', NULL, NULL, NULL, 50, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 3, N'nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 4, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 5, N'Resiko', N'Resiko', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 6, N'score12', N'Apakah pernah mengalami sakit yang mengarah ke gejala Covid-19*, seperti demam/batuk/pilek/sakit tenggorokan/sesak?', NULL, NULL, NULL, NULL, 250, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 7, N'suhu_tertinggi12', N'Jika Ya, Berapa suhu tertinggi selama 14 hari terakhir ini', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 8, N'gejala12', N'Apa gejala/sakitnya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 9, N'riwayat_dokter12', N'dan jelaskan sudah konsultasi dokter atau dirawat dimana', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 10, N'suhu_tubuh', N'Suhu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 11, N'lokasi_kerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 12, N'tanggal_ba', N'Tanggal Berita Acara', N'date', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 13, N'gejala_ba', N'Gejala', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 14, N'riwayat_ba', N'Riwayat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (97, 15, N'tindakan_ba', N'Tindakan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 2, N'Divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 4, N'odp', N'ODP (Orang Dalam Pemantauan)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 5, N'pdp', N'PDP (Pasien Dalam Pengawasan)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 6, N'otg', N'OTG (Orang Tanpa Gejala)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 7, N'positif', N'POSITIF', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (95, 8, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 2, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 4, N'sakit_kepala', N'Sakit Kepala', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 5, N'badan_lemas', N'Badan Lemas', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 6, N'sakit_perut', N'Sakit Perut', N'thousands', N'right ', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 7, N'diare', N'Diare', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 8, N'lainlain', N'Lain - Lain', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 9, N'jml_kurangsehat', N'Jumlah Kurang/Tidak Sehat', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (94, 10, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (93, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (93, 2, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (93, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (93, 4, N'ada', N'Ya, Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (93, 5, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 1, N'nik', N'NIK', N'string', NULL, NULL, NULL, 100, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 2, N'nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 3, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, 300, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 4, N'FrekInput', N'Frekuensi Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 5, N'FrekTdkInput', N'Frekuensi Tidak Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 6, N'Persen', N'Persen', N'percentage', NULL, NULL, NULL, NULL, NULL, NULL, N'before')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (91, 7, N'', N'DD-MM-YYYY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'loop')
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (90, 1, N'nik', N'NIK', N'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (90, 2, N'nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (90, 3, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (90, 4, N'Input', N'Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 1, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 4, N'jawab8', N'Apakah ada yang masuk kategori ODP (Orang Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 5, N'hubungan_keluarga8', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 6, N'jarak8', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 7, N'interaksi8', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 8, N'jawab9', N'Apakah ada yang masuk kategori PDP (Pasien Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 9, N'hubungan_keluarga9', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 10, N'jarak9', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 11, N'interaksi9', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 12, N'jawab10', N'Apakah ada yang masuk kategori OTG (Orang Tanpa Gejala)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 13, N'hubungan_keluarga10', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 14, N'jarak10', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 15, N'interaksi10', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 16, N'jawab11', N'Apakah ada yang masuk kategori POSITIF', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 17, N'hubungan_keluarga11', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 18, N'jarak11', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (89, 19, N'interaksi11', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 1, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 4, N'LokasiKerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 5, N'jawab1', N'Hari ini Anda mengalami atau merasakan Keluhan?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (88, 6, N'Suhu', N'Suhu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 1, N'Divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 3, N'odp', N'ODP (Orang Dalam Pengawasan)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 4, N'pdp', N'PDP (Pasien Dalam Pengawasan)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 5, N'otg', N'OTG (Orang Tanpa Gejala)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 6, N'positif', N'POSITIF', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (87, 7, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (86, 1, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (86, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (86, 3, N'ada', N'Ya, Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (86, 4, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 1, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 3, N'sakit_kepala', N'Sakit Kepala', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 4, N'badan_lemas', N'Badan Lemas', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 5, N'sakit_perut', N'Sakit Perut', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 6, N'diare', N'Diare', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 7, N'lainlain', N'Lain-Lain', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 8, N'jml_kurangsehat', N'Jumlah Tidak/Kurang Sehat', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (85, 9, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 1, N'Divisi', N'Bisnis Unit', NULL, NULL, NULL, NULL, 150, NULL, N'true', NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, 50, NULL, N'true', NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, N'true', NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 4, N'JamIsi', N'Jam Isi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 5, N'Suhu', N'Suhu Tubuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 6, N'LokasiGPS', N'Lokasi GPS', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 7, N'LokasiKerja', N'Jadwal Grup', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 8, N'Resiko', N'Resiko', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 9, N'score1', N'Apakah Anda melakukan perjalanan keluar area Jabodetabek?', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 10, N'score2', N'Apakah Anda pernah mengunjungi Fasyankes seperti Puskesmas, Klinik, RS, dll?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 11, N'score3', N'Apakah Anda pernah mengunjungi Pasar Tradisional untuk berbelanja?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 12, N'score4', N'Apakah Anda pernah mengunjungi Minimarket/Supermarket untuk berbelanja (lebih dari 1 jam) ?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 13, N'score5', N'Apakah Anda pernah mengunjungi Mall (lebih dari 1 jam) selain untuk berbelanja di supermarket ?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 14, N'score6', N'Apakah Anda pernah mengunjungi Restoran untuk makan di tempat (dine-in)?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 15, N'score7', N'Apakah Anda pernah mengunjungi perusahaan lain di Triputra Group atau perusahaan lain untuk rapat lebih dari 30 menit?', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 16, N'score8', N'Apakah Anda pernah mengikuti kegiatan keagamaan seperti Ibadah/ Pengajian/Perkumpulan Doa?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 17, N'score9', N'Apakah Anda pernah datang ke acara keramaian seperti Pesta/ Halal Bihalal/ Pernikahan/ Arisan?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 18, N'score10', N'Apakah Anda pernah datang ke acara atau mengikuti kegiatan Komunitas seperti komunitas lari, komunitas sepeda, dan komunitas hobi lain nya?', NULL, NULL, NULL, NULL, 600, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 19, N'score11', N'Apakah Anda pernah datang melayat atau menghadiri upacara pemakaman?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 20, N'score12', N'Apakah pernah mengalami sakit yang mengarah ke gejala Covid-19*, seperti demam/batuk/pilek/sakit tenggorokan/sesak?', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 21, N'suhu_tertinggi12', N'Jika Ya, Berapa suhu tertinggi selama 14 hari terakhir ini:', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 22, N'gejala12', N'Apa gejala/sakitnya:', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 23, N'riwayat_dokter12', N'dan jelaskan sudah konsultasi dokter atau dirawat dimana:', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 24, N'jawab1', N'Apakah ada keluhan sakit saat ini SELAIN yang mengarah ke gejala COVID-19?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 25, N'jawab2', N'Apakah saat ini ada anggota keluarga satu rumah atau sekitar Anda yang sedang sakit? Jika ada, tuliskan hubungan tersebut dengan Anda dan deskripsikan keluhan yang dialaminya?', NULL, NULL, NULL, NULL, 700, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 26, N'jawab3', N'Apakah saat ini ada anggota keluarga satu rumah atau sekitar Anda yang sedang sakit? Jika ada, tuliskan hubungan tersebut dengan Anda dan deskripsikan keluhan yang dialaminya?', NULL, NULL, NULL, NULL, 700, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 27, N'jawab4', N'Apakah anggota keluarga tersebut sudah konsultasi ke dokter? mohon diberikan penjelasannya jika "Sudah" maupun "Belum"!', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 28, N'jawab8', N'Apakah ada yang masuk kategori ODP (Orang Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 29, N'hubungan_keluarga8', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 30, N'jarak8', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 31, N'interaksi8', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 32, N'jawab9', N'Apakah ada yang masuk kategori PDP (Pasien Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 33, N'hubungan_keluarga9', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 34, N'jarak9', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 35, N'interaksi9', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 36, N'jawab10', N'Apakah ada yang masuk kategori OTG (Orang Tanpa Gejala)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 37, N'hubungan_keluarga10', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 38, N'jarak10', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 39, N'interaksi10', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 40, N'jawab11', N'Apakah ada yang masuk kategori POSITIF', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 41, N'hubungan_keluarga11', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 42, N'jarak11', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportColumns] ([Columns_ReportID], [Columns_Order], [Columns_Name], [Columns_Title], [Columns_Format], [Columns_Align], [Columns_Group], [Columns_Total], [Columns_Width], [Columns_Visible], [Columns_Fixed], [Columns_Loop]) VALUES (84, 43, N'interaksi11', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL)
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (98, NULL, N'hr/dailyassessmentshift/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (97, NULL, N'hr/dailyassessmentresiko/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (95, NULL, N'hr/dailyassessmentpabrikkondisilingkungan/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (94, NULL, N'hr/dailyassessmentpabrikkeluhanlain/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (93, NULL, N'hr/dailyassessmentpabrikkondisikeluarga/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (91, NULL, N'hr/dailyassessmentrekap/get', N'CardTreePeriodVar', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (90, NULL, N'hr/dailyassessmentinput/get', N'CardTreePeriodDoughnut', N'Input', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (89, NULL, N'hr/dailyassessmentlingkungancovid/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (88, NULL, N'hr/dailyassessmenttidaksehat/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (87, NULL, N'hr/dailyassessmentkondisilingkungan/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (86, NULL, N'hr/dailyassessmentkondisikeluarga/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (85, NULL, N'hr/dailyassessmentkeluhanlain/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success')
GO
INSERT [dbo].[M_ReportDetail] ([ReportDetail_ID], [ReportDetail_Component], [ReportDetail_API], [ReportDetail_Card], [ReportDetail_Table], [ReportDetail_Params], [ReportDetail_Icon], [ReportDetail_Color]) VALUES (84, NULL, N'hr/dailyassessment/get', N'CardTreePeriod', N'Divisi', N'from,to,divisi', N'icon-people', N'success')
GO
