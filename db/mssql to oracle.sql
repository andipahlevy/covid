CREATE TABLE tbl_ass_data(
	id_data Number(10)  NOT NULL,
	tanggal date NOT NULL,
	nik Number(10) NOT NULL,
	lokasi_kerja Varchar2(100) NOT NULL,
	suhu_tubuh Number(18, 2) NOT NULL,
	id_pertanyaan Number(10) NOT NULL,
	score Number(10) NOT NULL,
	catatan Varchar2(100) NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL,
	lokasi_detail Clob NULL,
	hubungan_keluarga Varchar2(250) NULL,
	hubungan_kategori Varchar2(250) NULL,
	suhu_tertinggi Varchar2(250) NULL,
	gejala Varchar2(250) NULL,
	riwayat_dokter Varchar2(250) NULL,
	catatan_lokasi_kerja Varchar2(250) NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE tbl_ass_data_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tbl_ass_data_seq_tr
 BEFORE INSERT ON tbl_ass_data FOR EACH ROW
 WHEN (NEW.id_data IS NULL)
BEGIN
 SELECT tbl_ass_data_seq.NEXTVAL INTO :NEW.id_data FROM DUAL;
END;
/

CREATE TABLE tbl_ass_data_ganda(
	id_data Number(10)  NOT NULL,
	tanggal date NOT NULL,
	nik Number(10) NOT NULL,
	lokasi_kerja Varchar2(100) NOT NULL,
	suhu_tubuh Number(18, 2) NOT NULL,
	id_pertanyaan Number(10) NOT NULL,
	jawaban Varchar2(100) NULL,
	catatan Varchar2(100) NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL,
	lokasi_detail Clob NULL,
	hubungan_keluarga_ganda Varchar2(250) NULL,
	jarak_ganda Varchar2(250) NULL,
	interaksi_ganda Varchar2(250) NULL,
	catatan_lokasi_kerja Varchar2(250) NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE tbl_ass_data_ganda_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tbl_ass_data_ganda_seq_tr
 BEFORE INSERT ON tbl_ass_data_ganda FOR EACH ROW
 WHEN (NEW.id_data IS NULL)
BEGIN
 SELECT tbl_ass_data_ganda_seq.NEXTVAL INTO :NEW.id_data FROM DUAL;
END;
/

CREATE TABLE tbl_ass_pertanyaan(
	id_pertanyaan Number(10)  NOT NULL,
	pertanyaan varchar2(255) NOT NULL,
	score Number(10) NOT NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE tbl_ass_pertanyaan_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tbl_ass_pertanyaan_seq_tr
 BEFORE INSERT ON tbl_ass_pertanyaan FOR EACH ROW
 WHEN (NEW.id_pertanyaan IS NULL)
BEGIN
 SELECT tbl_ass_pertanyaan_seq.NEXTVAL INTO :NEW.id_pertanyaan FROM DUAL;
END;
/

CREATE TABLE tbl_ass_pertanyaan_ganda(
	id_pertanyaan Number(10)  NOT NULL,
	pertanyaan varchar2(255) NOT NULL,
	jawaban varchar2(255) NOT NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL,
	no Varchar2(50) NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE tbl_ass_pertanyaan_ganda_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ass_pertanyaan_ganda_seq_tr
 BEFORE INSERT ON tbl_ass_pertanyaan_ganda FOR EACH ROW
 WHEN (NEW.id_pertanyaan IS NULL)
BEGIN
 SELECT tbl_ass_pertanyaan_ganda_seq.NEXTVAL INTO :NEW.id_pertanyaan FROM DUAL;
END;
/

CREATE TABLE tbl_ass_berita_acara(
	id_berita_acara Number(10)  NOT NULL,
	tanggal date NOT NULL,
	nik Number(10) NOT NULL,
	lokasi_kerja Varchar2(100) NOT NULL,
	lokasi_detail varchar2(255) NULL,
	suhu_tubuh Number(18, 2) NOT NULL,
	tanggal_ba date NULL,
	gejala_ba Varchar2(255) NULL,
	riwayat_ba Varchar2(255) NULL,
	tindakan_ba Varchar2(255) NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE tbl_ass_berita_acara_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tbl_ass_berita_acara_seq_tr
 BEFORE INSERT ON tbl_ass_berita_acara FOR EACH ROW
 WHEN (NEW.id_berita_acara IS NULL)
BEGIN
 SELECT tbl_ass_berita_acara_seq.NEXTVAL INTO :NEW.id_berita_acara FROM DUAL;
END;
/

CREATE TABLE tbl_ass_user(
	nik Varchar2(10) NOT NULL,
	email Varchar2(250) NULL,
	nama Varchar2(300) NULL,
	divisi Varchar2(300) NULL,
	gender Varchar2(1) NOT NULL,
	login_buat Number(10) NOT NULL,
	tanggal_buat Timestamp(3) NOT NULL,
	login_edit Number(10) NOT NULL,
	tanggal_edit Timestamp(3) NOT NULL,
	na Varchar2(1) NOT NULL,
	del Varchar2(1) NOT NULL
);



CREATE VIEW vw_COVID_data_new
AS

SELECT CAST(tanggal_buat AS DATE) tanggal_buat,
	TO_CHAR(MAX(tanggal_buat),114) jam_buat,
	nik, lokasi_kerja, catatan_lokasi_kerja,
	TO_CHAR(lokasi_detail(MAX)) lokasi_detail, suhu_tubuh,
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
FROM tbl_ass_data
WHERE na = 'n' AND del = 'n'
GROUP BY CAST(tanggal_buat AS DATE), nik, lokasi_kerja, catatan_lokasi_kerja,
	TO_CHAR(lokasi_detail(MAX)), suhu_tubuh

GO
/* SQLINES DEMO *** w [vw_COVID_dataganda_new]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

CREATE VIEW vw_COVID_dataganda_new
AS

SELECT CAST(tanggal_buat AS DATE) tanggal_buat, nik, lokasi_kerja, TO_CHAR(lokasi_detail(MAX)) lokasi_detail, suhu_tubuh,
	MAX(CASE WHEN id_pertanyaan = 1 THEN jawaban END) jawaban1,
	MAX(CASE WHEN id_pertanyaan = 1 THEN catatan END) catatan1,
	MAX(CASE WHEN id_pertanyaan = 2 THEN jawaban END) jawaban2,
	MAX(CASE WHEN id_pertanyaan = 2 THEN catatan END) catatan2,
	MAX(CASE WHEN id_pertanyaan = 3 THEN jawaban END) jawaban3,
	MAX(CASE WHEN id_pertanyaan = 3 THEN catatan END) catatan3,
	MAX(CASE WHEN id_pertanyaan = 4 THEN jawaban END) jawaban4,
	MAX(CASE WHEN id_pertanyaan = 4 THEN catatan END) catatan4,
	-- SQLINES DEMO *** ertanyaan = 5 THEN jawaban END) jawaban5,
	-- SQLINES DEMO *** ertanyaan = 5 THEN catatan END) catatan5,
	-- SQLINES DEMO *** ertanyaan = 6 THEN jawaban END) jawaban6,
	-- SQLINES DEMO *** ertanyaan = 6 THEN catatan END) catatan6,
	-- SQLINES DEMO *** ertanyaan = 7 THEN jawaban END) jawaban7,
	-- SQLINES DEMO *** ertanyaan = 7 THEN catatan END) catatan7
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
FROM tbl_ass_data_ganda
WHERE na = 'n' AND del = 'n'
GROUP BY CAST(tanggal_buat AS DATE), nik, lokasi_kerja, TO_CHAR(lokasi_detail(MAX)), suhu_tubuh

GO
/* SQLINES DEMO *** w [vw_KaryawanDivisi]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

CREATE VIEW vw_KaryawanDivisi
AS

SELECT NVL(divisi,'N/A') divisi, nik, nama
FROM tbl_ass_user
WHERE na = 'n' AND del = 'n'

 
CREATE TABLE M_Category(
	Category_ID Number(10) NOT NULL,
	Category_Name Varchar2(50) NULL,
	Category_Description Varchar2(255) NULL,
	Category_Status char(1) NULL,
	Category_CreateDate Timestamp(3) NULL,
	Category_CreateID Number(10) NULL,
	Category_EditDate Timestamp(3) NULL,
	Category_EditID Number(10) NULL,
	CONSTRAINT PK_M_Category PRIMARY KEY (Category_ID)
 )

CREATE TABLE M_Report(
	Report_ID Number(10) NOT NULL,
	Report_Name Varchar2(255) NULL,
	Report_CategoryID Number(10) NULL,
	Report_Link Varchar2(255) NULL,
	Report_Proc Varchar2(255) NULL,
	Report_Status char(1) NULL,
	Report_AccessStatus char(1) NULL,
	Report_CreateDate Timestamp(3) NULL,
	Report_CreateID Number(10) NULL,
 CONSTRAINT PK_M_Report PRIMARY KEY 
(
	Report_ID /* DESC */
)
)
/* SQLINES DEMO *** le [M_ReportColumns]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 
CREATE TABLE M_ReportColumns(
	Columns_ReportID Number(10) NULL,
	Columns_Order Number(10) NULL,
	Columns_Name Varchar2(50) NULL,
	Columns_Title Varchar2(255) NULL,
	Columns_Format Varchar2(50) NULL,
	Columns_Align Varchar2(50) NULL,
	Columns_Group Varchar2(50) NULL,
	Columns_Total Varchar2(50) NULL,
	Columns_Width Number(10) NULL,
	Columns_Visible Varchar2(50) NULL,
	Columns_Fixed Varchar2(50) NULL,
	Columns_Loop Varchar2(25) NULL
);
/* SQLINES DEMO *** le [M_ReportDetail]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 
CREATE TABLE M_ReportDetail(
	ReportDetail_ID Number(10) NOT NULL,
	ReportDetail_Component Varchar2(50) NULL,
	ReportDetail_API Varchar2(255) NULL,
	ReportDetail_Card Varchar2(50) NULL,
	ReportDetail_Table Varchar2(50) NULL,
	ReportDetail_Params Varchar2(255) NULL,
	ReportDetail_Icon Varchar2(50) NULL,
	ReportDetail_Color Varchar2(50) NULL
);
/* SQLINES DEMO *** redProcedure [proc_DivisiGet]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE proc_DivisiGet (cur OUT SYS_REFCURSOR) (cur OUT SYS_REFCURSOR)
AS
BEGIN

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT DISTINCT divisi
FROM tbl_ass_user
WHERE na = 'n' AND del = 'n'
ORDER BY divisi;

 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** vailableGet] 1
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE proc_ReportAvailableGet (p_UserID NUMBER, cur OUT SYS_REFCURSOR)
AS
BEGIN

--DECLARE @UserID INT
--SET @UserID = 1

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT Report_ID, Report_Name,
	Report_Link, ReportDetail_Color Report_Color,
	Report_Status, Report_AccessStatus,
	NVL(Category_ID,0) Category_ID,
-- SQLINES DEMO *** ame,'Category doesn''t exist') Category_Name, Cnt
	NVL(Category_Name,'Category doesn''t exist') Category_Name, 1 Cnt
FROM M_Report
WITH; (NOLOCK)
LEFT JOIN M_ReportDetail
	ON ReportDetail_ID = Report_ID
LEFT JOIN M_Category
	ON Category_ID = Report_CategoryID
		AND Category_Status = 'A'
--LEFT JOIN
--	(
-- SQLINES DEMO *** ID CatID, COUNT(Report_ID) Cnt
--		FROM M_Category
--		LEFT JOIN M_Report
-- SQLINES DEMO *** = Report_CategoryID
-- SQLINES DEMO *** rtChild
-- SQLINES DEMO *** ReportID = Report_ID
-- SQLINES DEMO *** tus = 'A'
-- SQLINES DEMO *** ssStatus = 'E'
-- SQLINES DEMO *** rtChild_Status,'') <> 'A'
-- SQLINES DEMO *** y_ID
--	) X
-- SQLINES DEMO *** ry_ID
-- SQLINES DEMO *** Child
-- SQLINES DEMO *** portID = Report_ID
WHERE Report_Status = 'A'
	AND Report_AccessStatus = 'E'
	-- SQLINES DEMO *** hild_Status,'') <> 'A'
--UNION ALL
-- SQLINES DEMO *** Report_Name,
-- SQLINES DEMO *** rtDetail_Color Report_Color,
-- SQLINES DEMO *** port_AccessStatus,
-- SQLINES DEMO *** D,0) Category_ID,
-- SQLINES DEMO *** ame,'Category doesn''t exist') Category_Name, Cnt
--FROM M_Report
--WITH (NOLOCK)
-- SQLINES DEMO *** Detail
-- SQLINES DEMO *** D = Report_ID
--LEFT JOIN M_Category
-- SQLINES DEMO *** Report_CategoryID
-- SQLINES DEMO *** tus = 'A'
--LEFT JOIN
--	(
-- SQLINES DEMO *** ID CatID, COUNT(Report_ID) Cnt
--		FROM M_Category
--		LEFT JOIN M_Report
-- SQLINES DEMO *** = Report_CategoryID
-- SQLINES DEMO *** rtChild
-- SQLINES DEMO *** ReportID = Report_ID
-- SQLINES DEMO *** essStatus = 'R'
-- SQLINES DEMO *** rtChild_Status,'') <> 'A'
-- SQLINES DEMO *** y_ID
--	) X
-- SQLINES DEMO *** ry_ID
-- SQLINES DEMO *** Access
-- SQLINES DEMO *** eportID = Report_ID
-- SQLINES DEMO *** Child
-- SQLINES DEMO *** portID = Report_ID
-- SQLINES DEMO *** sStatus = 'R'
-- SQLINES DEMO *** Child_Status,'') <> 'A'
-- SQLINES DEMO *** UserID = @UserID
-- SQLINES DEMO ***  Report_Name
ORDER BY Cnt DESC, Report_Name



-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE proc_ReportDetailGet (p_ReportID NUMBER, cur OUT SYS_REFCURSOR)
AS
BEGIN

-- SQLINES DEMO *** INT
--SET @ReportID = 1

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT Report_ID, Report_Name, Report_Proc, Report_Link, Report_CategoryID,
	NVL(ReportDetail_API,Report_Link||'/get') Report_API, NVL(ReportDetail_Params,'from,to,plant') Report_Params,
	NVL(ReportDetail_Card,'CardReportPeriod') Report_Card, NVL(ReportDetail_Table,'Compact') Report_Table,
	NVL(ReportDetail_Color,'info') Report_Color
FROM M_Report
WITH; (NOLOCK)
LEFT JOIN M_ReportDetail
	ON ReportDetail_ID = Report_ID
WHERE Report_Status = 'A'
	AND Report_ID = p_ReportID

/* SQLINES DEMO *** redProcedure [proc_ReportParamsGet]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE proc_ReportParamsGet (p_ReportID NUMBER, cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR, cur3 OUT SYS_REFCURSOR, cur4 OUT SYS_REFCURSOR, cur5 OUT SYS_REFCURSOR, cur6 OUT SYS_REFCURSOR, cur7 OUT SYS_REFCURSOR, cur8 OUT SYS_REFCURSOR, cur9 OUT SYS_REFCURSOR)
AS
BEGIN

-- SQLINES DEMO *** INT
--SET @ReportID = 26

--Judul Kolom
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT Columns_Name [name], Columns_Title [title]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID
ORDER BY Columns_Order

-- SQLINES DEMO *** p (subtotal)
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT Columns_Name columnName, Columns_Group [type]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID AND Columns_Group IS NOT NULL
ORDER BY Columns_Order

--Kolom yang di total
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur3 FOR SELECT Columns_Name columnName, Columns_Total [type]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID AND Columns_Total IS NOT NULL
ORDER BY Columns_Order

--Alignment kolom
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur4 FOR SELECT Columns_Name columnName, Columns_Align [align]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID AND Columns_Align IS NOT NULL
ORDER BY Columns_Order

--Format kolom
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur5 FOR SELECT Columns_Name Kolom, Columns_Format Format
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID AND Columns_Format IS NOT NULL
ORDER BY Columns_Order

--Semua parameter
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur6 FOR SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], NVL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	NVL(Columns_Fixed,'false') [fixed]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID
ORDER BY Columns_Order

-- SQLINES DEMO *** ebelum Loop
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur7 FOR SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], NVL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	NVL(Columns_Fixed,'false') [fixed]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID
	AND Columns_Loop = 'Before'
ORDER BY Columns_Order

-- SQLINES DEMO *** oop
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur8 FOR SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], NVL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	NVL(Columns_Fixed,'false') [fixed]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID
	AND Columns_Loop = 'Loop'
ORDER BY Columns_Order

-- SQLINES DEMO *** etelah Loop
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur9 FOR SELECT Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], NVL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom],
	NVL(Columns_Fixed,'false') [fixed]
FROM M_ReportColumns
WITH; (NOLOCK)
WHERE Columns_ReportID = p_ReportID
	AND Columns_Loop = 'After'
ORDER BY Columns_Order

GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment '2020-06-15', '2020-06-15', 'SEP - HO'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment ( p_From TIMESTAMP(3), p_To TIMESTAMP(3), p_Divisi VARCHAR), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 02-17'
--DECLARE @To DATE
-- SQLINES DEMO *** -17'
-- SQLINES DEMO *** RCHAR(MAX)
-- SQLINES DEMO ***  - HO'

SET p_Divisi = ''||REPLACE(p_Divisi,',',''',''')||''

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##DailyAssessment') THEN
DROP TABLE ##DailyAssessment;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.divisi||' - '||A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama, B.jam_buat JamIsi,
	B.suhu_tubuh Suhu, B.lokasi_detail LokasiGPS,
	UPPER(B.lokasi_kerja)+CASE WHEN B.catatan_lokasi_kerja = '' THEN '' ELSE ', '||B.catatan_lokasi_kerja END LokasiKerja,
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
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 || ', ' || C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1,
	CASE WHEN C.jawaban2 <> '' AND C.catatan2 <> '' THEN C.jawaban2 || ', ' || C.catatan2
	WHEN C.jawaban2 <> '' THEN C.jawaban2 ELSE C.catatan2 END jawab2,
	CASE WHEN C.jawaban3 <> '' AND C.catatan3 <> '' THEN C.jawaban3 || ', ' || C.catatan3
	WHEN C.jawaban3 <> '' THEN C.jawaban3 ELSE C.catatan3 END jawab3,
	CASE WHEN C.jawaban4 <> '' AND C.catatan4 <> '' THEN C.jawaban4 || ', ' || C.catatan4
	WHEN C.jawaban4 <> '' THEN C.jawaban4 ELSE C.catatan4 END jawab4,
	C.jawaban8 jawab8, C.hubungan_keluarga8, C.jarak8, C.interaksi8,
	C.jawaban9 jawab9, C.hubungan_keluarga9, C.jarak9, C.interaksi9,
	C.jawaban10 jawab10, C.hubungan_keluarga10, C.jarak10, C.interaksi10,
	C.jawaban11 jawab11, C.hubungan_keluarga11, C.jarak11, C.interaksi11
INTO ##DailyAssessment
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN p_From AND p_To
LEFT JOIN vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE);

EXECUTE IMMEDIATE '
IF ''ALL'' NOT IN ('''||p_Divisi||''')
DELETE ##DailyAssessment
WHERE divisi NOT IN ('''||p_Divisi||''')
';

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT *
FROM ##DailyAssessment
ORDER BY ID;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_14Hari]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_14Hari '2020-07-28', '2020-07-28'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_14Hari ( p_From Date, p_To Date), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR, cur3 OUT SYS_REFCURSOR, cur4 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
--DECLARE @To DATE

SET p_From = CAST(INTERVAL '-13' DAY(5) +p_To AS DATE)
p_To := CAST(p_To AS DATE);

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##Cov14Hari_Kry') THEN
DROP TABLE ##Cov14Hari_Kry;
END IF;

EXECUTE IMMEDIATE '
SELECT nik, nama, divisi, posisi
INTO ##Cov14Hari_Kry
FROM vw_KaryawanDivisi
';

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#Cov14Hari_Tgl%') THEN
DROP TABLE #Cov14Hari_Tgl;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT ACTDT
INTO #Cov14Hari_Tgl
FROM SAPSYNC.ZKISSTT_0138
WHERE ACTDT BETWEEN p_From AND p_To;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#Cov14Hari_NamaTgl%') THEN
DROP TABLE #Cov14Hari_NamaTgl;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT nik, nama, divisi, posisi, ACTDT
INTO #Cov14Hari_NamaTgl
FROM ##Cov14Hari_Kry
CROSS JOIN #Cov14Hari_Tgl

IF; EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = '##Cov14Hari_Input')
DROP TABLE ##Cov14Hari_Input;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur3 FOR SELECT A.nik NIK, A.nama Nama, A.divisi Divisi, A.posisi Jabatan, A.ACTDT, TO_CHAR('H-'||TO_CHAR(SYSTIMESTAMP -A.ACTDT(2))(5)) Hari,
	B.score1+B.score2+B.score3+B.score4+B.score5+B.score6 Score
INTO ##Cov14Hari_Input
FROM #Cov14Hari_NamaTgl A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) = A.ACTDT;

INSERT INTO ##Cov14Hari_Input
SELECT NIK, Nama, Divisi, Jabatan, SYSTIMESTAMP, 'TOTAL', SUM(NVL(Score,0))
FROM ##Cov14Hari_Input
GROUP BY NIK, Nama, Divisi, Jabatan;

 v_Period CHAR(10);
v_Period := CAST(p_From AS CHAR(10));
 v_PeriodSeries VARCHAR(MAX);
v_PeriodSeries := '';

WHILE CAST(v_Period AS DATE) <= p_To
LOOP
	v_PeriodSeries := v_PeriodSeries || '[' || 'H-'||TO_CHAR(SYSTIMESTAMP -CAST(v_Period AS DATE)(2)) || '],';
	
	v_Period := CAST(INTERVAL '1' DAY(5) +CAST(v_Period AS DATE) AS CHAR(10));
END LOOP;

v_PeriodSeries := v_PeriodSeries || '[TOTAL]';

EXECUTE IMMEDIATE '
IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = ''##Cov14Hari_Pivot'')
DROP TABLE ##Cov14Hari_Pivot

SELECT NIK, Nama, Divisi, Jabatan, '||v_PeriodSeries||'
INTO ##Cov14Hari_Pivot
FROM 
	(
		SELECT NIK, Nama, Divisi, Jabatan, Hari, COL, VAL
		FROM ##Cov14Hari_Input
		CROSS APPLY (VALUES	(''Score'',	[Score])) CS (COL, VAL)
		WHERE VAL IS NOT NULL
	) T
	PIVOT (SUM(VAL) FOR Hari IN ('|| v_PeriodSeries ||')) PVT
';

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur4 FOR SELECT NIK ID, NULL parent, *,
	CASE WHEN TOTAL = 0 THEN 'HIJAU'
	WHEN TOTAL BETWEEN 1 AND 69 THEN 'ORANGE'
	WHEN TOTAL >= 70 THEN 'RED' END Status
FROM ##Cov14Hari_Pivot
ORDER BY Divisi, Nama;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Divisi]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_Divisi '2020-06-15', '2020-06-15', 'SEP - HO'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_Divisi ( p_From TIMESTAMP(3), p_To TIMESTAMP(3), p_Divisi VARCHAR), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 07-21'
--DECLARE @To DATE
-- SQLINES DEMO *** -21'
-- SQLINES DEMO *** RCHAR(MAX)
-- SQLINES DEMO ***  - HO'

SET p_Divisi = ''||REPLACE(p_Divisi,',',''',''')||''

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##DailyAssessment') THEN
DROP TABLE ##DailyAssessment;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.divisi||' - '||A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama, B.jam_buat JamIsi,
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
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 || ', ' || C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1,
	CASE WHEN C.jawaban2 <> '' AND C.catatan2 <> '' THEN C.jawaban2 || ', ' || C.catatan2
	WHEN C.jawaban2 <> '' THEN C.jawaban2 ELSE C.catatan2 END jawab2,
	CASE WHEN C.jawaban3 <> '' AND C.catatan3 <> '' THEN C.jawaban3 || ', ' || C.catatan3
	WHEN C.jawaban3 <> '' THEN C.jawaban3 ELSE C.catatan3 END jawab3,
	CASE WHEN C.jawaban4 <> '' AND C.catatan4 <> '' THEN C.jawaban4 || ', ' || C.catatan4
	WHEN C.jawaban4 <> '' THEN C.jawaban4 ELSE C.catatan4 END jawab4,
	C.jawaban8 jawab8, C.hubungan_keluarga8, C.jarak8, C.interaksi8,
	C.jawaban9 jawab9, C.hubungan_keluarga9, C.jarak9, C.interaksi9,
	C.jawaban10 jawab10, C.hubungan_keluarga10, C.jarak10, C.interaksi10,
	C.jawaban11 jawab11, C.hubungan_keluarga11, C.jarak11, C.interaksi11
INTO ##DailyAssessment
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN p_From AND p_To
LEFT JOIN vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE);

EXECUTE IMMEDIATE '
IF ''ALL'' NOT IN ('''||p_Divisi||''')
DELETE ##DailyAssessment
WHERE divisi NOT IN ('''||p_Divisi||''')
';

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT *
FROM ##DailyAssessment
ORDER BY ID;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Input]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_Input '2020-06-15', '2020-06-15'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_Input ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR, cur3 OUT SYS_REFCURSOR, cur4 OUT SYS_REFCURSOR, cur5 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** E()

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#CovInput_Input%') THEN
DROP TABLE #CovInput_Input;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.nik, A.nama, A.divisi, B.tanggal_buat,
	CASE WHEN B.score1 IS NULL THEN 0 ELSE 1 END Input
INTO #CovInput_Input
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) = p_From;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#CovInput_Persen%') THEN
DROP TABLE #CovInput_Persen;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT SUM(Input) Sudah, 1.0*SUM(Input)/COUNT(Input)*100 PSudah,
	COUNT(Input)-SUM(Input) Belum, 1.0*(COUNT(Input)-SUM(Input))/COUNT(Input)*100 PBelum,
	COUNT(Input) Total
INTO #CovInput_Persen
FROM #CovInput_Input;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#CovInput_Nama%') THEN
DROP TABLE #CovInput_Nama;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur3 FOR SELECT nik, nama, divisi,
	CASE WHEN Input = 0 THEN 'Belum' ELSE 'Sudah' END Input
INTO #CovInput_Nama
FROM #CovInput_Input;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur4 FOR SELECT nik ID, NULL parent, nik, nama, divisi, Input
FROM #CovInput_Nama
ORDER BY Input, divisi, nama;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur5 FOR SELECT 'Sudah Input' CountLabel, Sudah CountData, ROUND(PSudah,0) Percentage
FROM #CovInput_Persen
UNION ALL
SELECT 'Belum Input' CountLabel, Belum CountData, ROUND(PBelum,0) Percentage
FROM #CovInput_Persen;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_KasusLingkungan]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_KasusLingkungan '2020-07-21', '2020-07-21'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_KasusLingkungan ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 07-22'
--DECLARE @To DATE
-- SQLINES DEMO *** -22'

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#DailyAssessment_KasusLingkungan%') THEN
DROP TABLE #DailyAssessment_KasusLingkungan;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.divisi Divisi,
	   NVL(COUNT(CASE WHEN NVL(C.jawaban8,'') <> 'Ya' AND NVL(C.jawaban9,'') <> 'Ya'
							AND NVL(C.jawaban10,'') <> 'Ya' AND NVL(C.jawaban11,'') <> 'Ya' THEN C.jawaban8 END),0) tidak_ada,
	   NVL(COUNT(CASE WHEN C.jawaban8 = 'Ya' THEN C.jawaban8 END),0) odp,
	   NVL(COUNT(CASE WHEN C.jawaban9 = 'Ya' THEN C.jawaban9 END),0) pdp,
	   NVL(COUNT(CASE WHEN C.jawaban10 = 'Ya' THEN C.jawaban10 END),0) otg,	   
	   NVL(COUNT(CASE WHEN C.jawaban11 = 'Ya' THEN C.jawaban11 END),0) positif,
	   NVL(COUNT(C.jawaban8),0) grand_total
INTO #DailyAssessment_KasusLingkungan
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN p_From AND p_To
LEFT JOIN vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
GROUP BY A.divisi;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT 'eksad' as parent,
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
FROM #DailyAssessment_KasusLingkungan;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Keluhan_Lain]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** essment_keluhan_lain] '2020-06-10', '2020-06-10'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_da_Keluhan_Lain ( p_StartDate DATE, p_EndDate DATE), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

-- SQLINES DEMO ***  DATE
-- SQLINES DEMO *** ETDATE()

-- SQLINES DEMO *** ATE
-- SQLINES DEMO *** DATE()

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#DailyAssessment_KeluhanLain%') THEN
DROP TABLE #DailyAssessment_KeluhanLain;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT divisi,
	   NVL(COUNT(CASE WHEN jawaban = 'Tidak Ada' THEN jawaban END),0) tidak_ada,
	   NVL(COUNT(CASE WHEN jawaban = 'Sakit Kepala' THEN jawaban END),0) sakit_kepala,
	   NVL(COUNT(CASE WHEN jawaban = 'Badan Lemas' THEN jawaban END),0) badan_lemas,
	   NVL(COUNT(CASE WHEN jawaban = 'Sakit Perut' THEN jawaban END),0) sakit_perut,
	   NVL(COUNT(CASE WHEN jawaban = 'Diare' THEN jawaban END),0) diare,
	   NVL(COUNT(CASE WHEN jawaban = 'Lain-Lain' THEN jawaban 
						 WHEN jawaban = '' THEN jawaban END),0) lainlain,
	   NVL(COUNT(CASE WHEN jawaban = 'Sakit Kepala' THEN jawaban
						 WHEN jawaban = 'Badan Lemas' THEN jawaban
						 WHEN jawaban = 'Sakit Perut' THEN jawaban
						 WHEN jawaban = 'Diare' THEN jawaban
						 WHEN jawaban = 'Lain-Lain' THEN jawaban
						 WHEN jawaban = '' THEN jawaban END),0) jml_kurangsehat,
	  NVL(COUNT(jawaban),0) grand_total
INTO #DailyAssessment_KeluhanLain
FROM vw_KaryawanDivisi a
LEFT JOIN tbl_ass_data_ganda E on E.nik = A.nik
	AND id_pertanyaan = 1
	AND tanggal BETWEEN p_StartDate and p_EndDate
GROUP BY divisi
ORDER BY divisi;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT 'eksad' as parent,
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
FROM #DailyAssessment_KeluhanLain;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Kondisi_Keluarga]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** essment_kondisi_keluarga] '2020-06-10', '2020-06-10'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_da_Kondisi_Keluarga ( p_StartDate DATE, p_EndDate DATE), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

-- SQLINES DEMO ***  DATE
-- SQLINES DEMO *** ETDATE()

-- SQLINES DEMO *** ATE
-- SQLINES DEMO *** DATE()

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#DailyAssessment_KondisiKeluarga%') THEN
DROP TABLE #DailyAssessment_KondisiKeluarga;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT divisi,
	   NVL(COUNT(CASE WHEN jawaban = 'Tidak Ada' THEN jawaban END),0) tidak_ada,
	   NVL(COUNT(CASE WHEN jawaban = 'Ada, hubungan & keluhannya adalah' THEN jawaban END),0) ada,
	   NVL(COUNT(jawaban),0) grand_total
INTO #DailyAssessment_KondisiKeluarga
FROM vw_KaryawanDivisi a
LEFT JOIN tbl_ass_data_ganda E on E.nik = A.nik
	AND id_pertanyaan = 3
	AND tanggal BETWEEN p_StartDate and p_EndDate
GROUP BY divisi
ORDER BY divisi;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT 'eksad' as parent,
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
FROM #DailyAssessment_KondisiKeluarga;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_LingkunganCovid]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_LingkunganCovid '2020-07-21', '2020-07-21'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_da_LingkunganCovid ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 07-22'
--DECLARE @To DATE
-- SQLINES DEMO *** -22'

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#DailyAssessmentLingkunganCovid%') THEN
DROP TABLE #DailyAssessmentLingkunganCovid;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.divisi||' - '||A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama,
	CASE WHEN C.jawaban8 <> '' AND C.catatan8 <> '' THEN C.jawaban8 || ', ' || C.catatan8
	WHEN C.jawaban8 <> '' THEN C.jawaban8 ELSE C.catatan8 END jawab8,
	hubungan_keluarga8, jarak8, interaksi8,
	CASE WHEN C.jawaban9 <> '' AND C.catatan9 <> '' THEN C.jawaban9 || ', ' || C.catatan9
	WHEN C.jawaban9 <> '' THEN C.jawaban9 ELSE C.catatan9 END jawab9,
	hubungan_keluarga9, jarak9, interaksi9,
	CASE WHEN C.jawaban10 <> '' AND C.catatan10 <> '' THEN C.jawaban10 || ', ' || C.catatan10
	WHEN C.jawaban10 <> '' THEN C.jawaban10 ELSE C.catatan10 END jawab10,
	hubungan_keluarga10, jarak10, interaksi10,
	CASE WHEN C.jawaban11 <> '' AND C.catatan11 <> '' THEN C.jawaban11 || ', ' || C.catatan11
	WHEN C.jawaban11 <> '' THEN C.jawaban11 ELSE C.catatan11 END jawab11,
	hubungan_keluarga11, jarak11, interaksi11
INTO #DailyAssessmentLingkunganCovid
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN p_From AND p_To
LEFT JOIN vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
WHERE A.divisi NOT IN ('BOC');

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT *
FROM #DailyAssessmentLingkunganCovid
WHERE jawab8 <> 'Tidak' OR
		jawab9 <> 'Tidak' OR
		jawab10 <> 'Tidak' OR
		jawab11 <> 'Tidak'
ORDER BY ID;
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Rekap]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_Rekap '2020-06-15', '2020-06-15'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_Rekap ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR, cur3 OUT SYS_REFCURSOR, cur4 OUT SYS_REFCURSOR, cur5 OUT SYS_REFCURSOR, cur6 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
--DECLARE @To DATE
-- SQLINES DEMO *** 01-01'
-- SQLINES DEMO *** -31'

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovRekap_Tgl') THEN
DROP TABLE ##CovRekap_Tgl;
END IF;

CREATE TABLE ##CovRekap_Tgl (Tanggal DATE);

 v_Date DATE;
v_Date := p_From;

WHILE v_Date <= p_To
LOOP
	INSERT INTO ##CovRekap_Tgl
	SELECT v_Date FROM dual;

	v_Date := INTERVAL '1' DAY(5) +v_Date;
END LOOP;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovRekap_Data') THEN
DROP TABLE ##CovRekap_Data;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT TO_CHAR(Tanggal,105) Tanggal, B.nik, B.nama, B.divisi,
	0 FrekInput, 0 FrekTdkInput, CAST(0 AS BINARY_DOUBLE) Persen,
	CASE WHEN C.nik IS NOT NULL THEN 'Input' ELSE '' END Input
INTO ##CovRekap_Data
FROM
	(
		SELECT Tanggal
		FROM ##CovRekap_Tgl
	) A;
CROSS JOIN
	(
		SELECT nik, nama, divisi
		FROM vw_KaryawanDivisi
	) B
LEFT JOIN vw_COVID_data_new C
	ON C.nik = B.nik
		AND CAST(C.tanggal_buat AS DATE) = Tanggal
WHERE Tanggal BETWEEN p_From AND p_To

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovRekap_Count') THEN
DROP TABLE ##CovRekap_Count;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT nik nikC,
	COUNT(CASE WHEN Input = 'Input' THEN Tanggal END) FrekInputC,
	COUNT(CASE WHEN NVL(Input,'') = '' THEN Tanggal END) FrekTdkInputC,
	CASE WHEN COUNT(Input) = 0 THEN 0
	ELSE CAST(1.0*COUNT(CASE WHEN Input = 'Input' THEN Tanggal END)/COUNT(Tanggal) AS BINARY_DOUBLE) END PersenC
INTO ##CovRekap_Count
FROM ##CovRekap_Data
GROUP BY nik;

UPDATE ##CovRekap_Data
SET FrekInput = FrekInputC, FrekTdkInput = FrekTdkInputC, Persen = PersenC
FROM ##CovRekap_Count
WHERE nik = nikC;

 v_Tanggal CHAR(10);
v_Tanggal := TO_CHAR(p_To,105);
 v_TanggalSeries VARCHAR(MAX);
v_TanggalSeries := '';
 v_Tgl CHAR(8);

WHILE CAST(SUBSTR(v_Tanggal, GREATEST(-LENGTH(v_Tanggal),-4))+SUBSTR(v_Tanggal,4,2)+SUBSTR(v_Tanggal, 1,2) AS DATE) >= p_From
LOOP
	v_TanggalSeries := v_TanggalSeries || '[' || v_Tanggal || '],';
	
	v_Tgl := SUBSTR(v_Tanggal, GREATEST(-LENGTH(v_Tanggal),-4))+SUBSTR(v_Tanggal,4,2)+SUBSTR(v_Tanggal, 1,2);
	v_Tanggal := TO_CHAR(INTERVAL '-1' DAY(5) +CAST(v_Tgl AS DATE),105);
END LOOP;

v_TanggalSeries := SUBSTR(v_TanggalSeries, 1,LENGTH(RTRIM(v_TanggalSeries))-1);

EXECUTE IMMEDIATE '
IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE name = ''##CovRekap_Pivot'')
DROP TABLE ##CovRekap_Pivot

SELECT 
	nik, nama, divisi, FrekInput, FrekTdkInput, Persen, '||v_TanggalSeries||'
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
	PIVOT (MAX(VAL) FOR Tanggal IN ('|| v_TanggalSeries ||')) PVT
';

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur3 FOR SELECT Divisi+TO_CHAR(nik(25)) ID, NULL parent, *
FROM ##CovRekap_Pivot
ORDER BY ID;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovRekap_Cols') THEN
DROP TABLE ##CovRekap_Cols;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur4 FOR SELECT 
	COLUMN_NAME
INTO 
	##CovRekap_Cols
FROM 
	tempdb.INFORMATION_SCHEMA
WHERE 
	TABLE_NAME = '##CovRekap_Pivot' AND 
	COLUMN_NAME NOT IN ('ID','parent') AND
	COLUMN_NAME NOT IN
	(
		SELECT 
			Columns_Name
		FROM 
			M_ReportColumns
		WITH; (NOLOCK)
		WHERE 
			Columns_ReportID = 91 AND Columns_Loop <> 'Loop'
	)

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur5 FOR SELECT 
	Columns_Name [name], Columns_Title [title], Columns_Align [align],
	Columns_Width [width], NVL(Columns_Visible,'true') [visible],
	CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
	CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom]	
FROM 
	M_ReportColumns
WITH; (NOLOCK)
WHERE
	Columns_ReportID = 91 AND Columns_Loop = 'Before'
UNION ALL
-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur6 FOR SELECT 
	COLUMN_NAME [name], REPLACE(title,'DD-MM-YYYY',REPLACE(COLUMN_NAME,name,'')) [title]
	, align, width, visible, type, custom
FROM
	##CovRekap_Cols
CROSS JOIN 
	(
		SELECT 
			Columns_Name [name], Columns_Title [title], Columns_Align [align],
			Columns_Width [width], NVL(Columns_Visible,'true') [visible],
			CASE WHEN Columns_Format = 'date' THEN Columns_Format END [type],
			CASE WHEN Columns_Format <> 'date' THEN Columns_Format END [custom]	
		FROM 
			M_ReportColumns
		WITH; (NOLOCK)
		WHERE 
			Columns_ReportID = 91 AND Columns_Loop = 'Loop'
	) B
GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_Resiko]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_Resiko '2021-02-10', '2021-02-10'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_Resiko ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR, cur3 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 02-10'
--DECLARE @To DATE
-- SQLINES DEMO *** -10'

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovResiko_Input') THEN
DROP TABLE ##CovResiko_Input;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.nik, A.nama, A.divisi, CAST(tanggal_buat AS DATE) tanggal_buat,
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
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
WHERE CAST(tanggal_buat AS DATE) BETWEEN p_From AND p_To;

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name = '##CovResiko_Resiko') THEN
DROP TABLE ##CovResiko_Resiko;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT A.tanggal_buat, A.nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	lokasi_kerja, suhu_tubuh, tanggal_ba, gejala_ba, riwayat_ba, tindakan_ba
INTO ##CovResiko_Resiko
FROM ##CovResiko_Input A
LEFT JOIN tbl_ass_berita_acara B
	ON B.nik = A.nik AND B.tanggal_ba = A.tanggal_buat
		AND na = 'n' AND del = 'n'
WHERE Resiko = 'Besar' OR tanggal_ba IS NOT NULL;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur3 FOR SELECT nik+TO_CHAR(tanggal_buat,112) ID, nik parent, tanggal_buat, nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	lokasi_kerja, suhu_tubuh, tanggal_ba, gejala_ba, riwayat_ba, tindakan_ba
FROM ##CovResiko_Resiko
WHERE nik IN (	SELECT DISTINCT nik
				FROM ##CovResiko_Resiko
				WHERE tanggal_buat BETWEEN p_From AND p_To
				)
UNION ALL
SELECT nik ID, NULL parent, tanggal_buat, nik, nama, divisi, Resiko,
	score12, suhu_tertinggi12, gejala12, riwayat_dokter12,
	NULL lokasi_kerja, NULL suhu_tubuh, NULL tanggal_ba, NULL gejala_ba, NULL riwayat_ba, NULL tindakan_ba
FROM ##CovResiko_Resiko
WHERE nik IN (	SELECT DISTINCT nik
				FROM ##CovResiko_Resiko
				WHERE tanggal_buat BETWEEN p_From AND p_To
				)
	AND tanggal_buat = p_From
ORDER BY nik, tanggal_buat DESC;

GO
/* SQLINES DEMO *** redProcedure [sp_DailyAssessment_TidakSehat]    Script Date: 2/19/2021 10:37:30 AM ******/
/* SET ANSI_NULLS ON */
 
/* SET QUOTED_IDENTIFIER ON */
 

-- SQLINES DEMO *** sment_TidakSehat '2020-07-21', '2020-07-21'
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE OR REPLACE PROCEDURE sp_DailyAssessment_TidakSehat ( p_From TIMESTAMP(3), p_To TIMESTAMP(3)), cur OUT SYS_REFCURSOR, cur2 OUT SYS_REFCURSOR
AS
BEGIN

--DECLARE @From DATE
-- SQLINES DEMO *** 07-22'
--DECLARE @To DATE
-- SQLINES DEMO *** -22'

IF EXISTS(SELECT * FROM tempdb.sysobjects WHERE name LIKE '#DailyAssessmentTidakSehat%') THEN
DROP TABLE #DailyAssessmentTidakSehat;
END IF;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur FOR SELECT A.divisi||' - '||A.nama ID, NULL parent, A.divisi Divisi, A.nik NIK, A.nama Nama,
	B.suhu_tubuh Suhu, UPPER(B.lokasi_kerja) LokasiKerja,
	CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 || ', ' || C.catatan1
	WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END jawab1
INTO #DailyAssessmentTidakSehat
FROM vw_KaryawanDivisi A
LEFT JOIN vw_COVID_data_new B
	ON B.nik = A.nik
		AND CAST(B.tanggal_buat AS DATE) BETWEEN p_From AND p_To
LEFT JOIN vw_COVID_dataganda_new C
	ON C.nik = A.nik
		AND CAST(C.tanggal_buat AS DATE) = CAST(B.tanggal_buat AS DATE)
WHERE A.divisi NOT IN ('BOC')
	AND (CASE WHEN C.jawaban1 <> '' AND C.catatan1 <> '' THEN C.jawaban1 || ', ' || C.catatan1
			WHEN C.jawaban1 <> '' THEN C.jawaban1 ELSE C.catatan1 END) NOT IN ('','-','Tidak Ada');

-- SQLINES LICENSE FOR EVALUATION USE ONLY
OPEN cur2 FOR SELECT *
FROM #DailyAssessmentTidakSehat
ORDER BY ID;
GO


begin
INSERT into M_Category (Category_ID, Category_Name, Category_Description, Category_Status, Category_CreateDate, Category_CreateID, Category_EditDate, Category_EditID) SELECT  5, N'HR', N'HR', N'A', sysdate, 1, NULL, NULL  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  98, N'Daily Assessment - Shift', 5, N'hr/dailyassessmentshift', N'sp_DailyAssessment_Shift', N'N', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  97, N'Daily Assessment - Resiko', 5, N'hr/dailyassessmentresiko', N'sp_DailyAssessment_Resiko', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  91, N'Daily Assessment - Rekap Input', 5, N'hr/dailyassessmentrekap', N'sp_DailyAssessment_Rekap', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  90, N'Daily Assessment - Input', 5, N'hr/dailyassessmentinput', N'sp_DailyAssessment_Input', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  89, N'Daily Assessment - Lingkungan COVID', 5, N'hr/dailyassessmentlingkungancovid', N'sp_DailyAssessment_LingkunganCOVID', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  88, N'Daily Assessment - Tidak Sehat', 5, N'hr/dailyassessmenttidaksehat', N'sp_DailyAssessment_TidakSehat', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  87, N'Daily Assessment - Kondisi/Kasus di Lingkungan', 5, N'hr/dailyassessmentkondisilingkungan', N'sp_DailyAssessment_KasusLingkungan', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  86, N'Daily Assessment - Kondisi Keluarga Sakit', 5, N'hr/dailyassessmentkondisikeluarga', N'sp_DailyAssessment_Kondisi_Keluarga', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  85, N'Daily Assessment - Keluhan Selain Gejala COVID-19', 5, N'hr/dailyassessmentkeluhanlain', N'sp_DailyAssessment_Keluhan_Lain', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_Report (Report_ID, Report_Name, Report_CategoryID, Report_Link, Report_Proc, Report_Status, Report_AccessStatus, Report_CreateDate, Report_CreateID) SELECT  84, N'Daily Assessment - Detail', 5, N'hr/dailyassessment', N'sp_DailyAssessment', N'A', N'E', sysdate, 1  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 1, N'NIK', N'NIK', N'string', N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 2, N'Nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 3, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 4, N'Shift', N'Shift', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 5, N'LokasiKerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 6, N'LokasiDetail', N'Lokasi Detail', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 7, N'AbsenIn', N'Absen In', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 8, N'AbsenOut', N'Absen Out', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  98, 9, N'LokasiAbsen', N'Lokasi Absen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 1, N'tanggal_buat', N'Tanggal', N'date', NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 2, N'nik', N'NIK', N'string', NULL, NULL, NULL, 50, NULL, NULL, NULL  FROM dual;

INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 3, N'nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 4, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 5, N'Resiko', N'Resiko', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 6, N'score12', N'Apakah pernah mengalami sakit yang mengarah ke gejala Covid-19*, seperti demam/batuk/pilek/sakit tenggorokan/sesak?', NULL, NULL, NULL, NULL, 250, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 7, N'suhu_tertinggi12', N'Jika Ya, Berapa suhu tertinggi selama 14 hari terakhir ini', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 8, N'gejala12', N'Apa gejala/sakitnya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 9, N'riwayat_dokter12', N'dan jelaskan sudah konsultasi dokter atau dirawat dimana', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 10, N'suhu_tubuh', N'Suhu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 11, N'lokasi_kerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 12, N'tanggal_ba', N'Tanggal Berita Acara', N'date', NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 13, N'gejala_ba', N'Gejala', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 14, N'riwayat_ba', N'Riwayat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  97, 15, N'tindakan_ba', N'Tindakan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 2, N'Divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 4, N'odp', N'ODP (Orang Dalam Pemantauan)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 5, N'pdp', N'PDP (Pasien Dalam Pengawasan)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 6, N'otg', N'OTG (Orang Tanpa Gejala)', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 7, N'positif', N'POSITIF', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  95, 8, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 2, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 4, N'sakit_kepala', N'Sakit Kepala', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 5, N'badan_lemas', N'Badan Lemas', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 6, N'sakit_perut', N'Sakit Perut', N'thousands', N'right ', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 7, N'diare', N'Diare', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 8, N'lainlain', N'Lain - Lain', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 9, N'jml_kurangsehat', N'Jumlah Kurang/Tidak Sehat', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  94, 10, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  93, 1, N'pabrik', N'Pabrik', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  93, 2, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  93, 3, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  93, 4, N'ada', N'Ya, Ada', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  93, 5, N'grand_total', N'Grand Total', N'thousands', N'right', N'sum', N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 1, N'nik', N'NIK', N'string', NULL, NULL, NULL, 100, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 2, N'nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 3, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, 300, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 4, N'FrekInput', N'Frekuensi Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 5, N'FrekTdkInput', N'Frekuensi Tidak Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 6, N'Persen', N'Persen', N'percentage', NULL, NULL, NULL, NULL, NULL, NULL, N'before'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  91, 7, N'', N'DD-MM-YYYY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'loop'  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  90, 1, N'nik', N'NIK', N'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  90, 2, N'nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  90, 3, N'divisi', N'Divisi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  90, 4, N'Input', N'Input', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 1, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 4, N'jawab8', N'Apakah ada yang masuk kategori ODP (Orang Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 5, N'hubungan_keluarga8', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 6, N'jarak8', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 7, N'interaksi8', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 8, N'jawab9', N'Apakah ada yang masuk kategori PDP (Pasien Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 9, N'hubungan_keluarga9', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 10, N'jarak9', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 11, N'interaksi9', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 12, N'jawab10', N'Apakah ada yang masuk kategori OTG (Orang Tanpa Gejala)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 13, N'hubungan_keluarga10', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 14, N'jarak10', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 15, N'interaksi10', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 16, N'jawab11', N'Apakah ada yang masuk kategori POSITIF', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 17, N'hubungan_keluarga11', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 18, N'jarak11', N'Jarak dari rumah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  89, 19, N'interaksi11', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, NULL, N'false', NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 1, N'Divisi', N'Divisi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 4, N'LokasiKerja', N'Lokasi Kerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 5, N'jawab1', N'Hari ini Anda mengalami atau merasakan Keluhan?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  88, 6, N'Suhu', N'Suhu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 1, N'Divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 3, N'odp', N'ODP (Orang Dalam Pengawasan)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 4, N'pdp', N'PDP (Pasien Dalam Pengawasan)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 5, N'otg', N'OTG (Orang Tanpa Gejala)', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 6, N'positif', N'POSITIF', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  87, 7, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  86, 1, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  86, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  86, 3, N'ada', N'Ya, Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  86, 4, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 1, N'divisi', N'Divisi', NULL, N'left', NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 2, N'tidak_ada', N'Tidak Ada', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 3, N'sakit_kepala', N'Sakit Kepala', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 4, N'badan_lemas', N'Badan Lemas', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 5, N'sakit_perut', N'Sakit Perut', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 6, N'diare', N'Diare', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 7, N'lainlain', N'Lain-Lain', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 8, N'jml_kurangsehat', N'Jumlah Tidak/Kurang Sehat', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  85, 9, N'grand_total', N'Grand Total', N'thousands', N'right', NULL, N'sum', NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 1, N'Divisi', N'Bisnis Unit', NULL, NULL, NULL, NULL, 150, NULL, N'true', NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 2, N'NIK', N'NIK', N'string', NULL, NULL, NULL, 50, NULL, N'true', NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 3, N'Nama', N'Nama', NULL, NULL, NULL, NULL, 200, NULL, N'true', NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 4, N'JamIsi', N'Jam Isi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 5, N'Suhu', N'Suhu Tubuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 6, N'LokasiGPS', N'Lokasi GPS', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 7, N'LokasiKerja', N'Jadwal Grup', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 8, N'Resiko', N'Resiko', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 9, N'score1', N'Apakah Anda melakukan perjalanan keluar area Jabodetabek?', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 10, N'score2', N'Apakah Anda pernah mengunjungi Fasyankes seperti Puskesmas, Klinik, RS, dll?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 11, N'score3', N'Apakah Anda pernah mengunjungi Pasar Tradisional untuk berbelanja?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 12, N'score4', N'Apakah Anda pernah mengunjungi Minimarket/Supermarket untuk berbelanja (lebih dari 1 jam) ?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 13, N'score5', N'Apakah Anda pernah mengunjungi Mall (lebih dari 1 jam) selain untuk berbelanja di supermarket ?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 14, N'score6', N'Apakah Anda pernah mengunjungi Restoran untuk makan di tempat (dine-in)?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 15, N'score7', N'Apakah Anda pernah mengunjungi perusahaan lain di Triputra Group atau perusahaan lain untuk rapat lebih dari 30 menit?', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 16, N'score8', N'Apakah Anda pernah mengikuti kegiatan keagamaan seperti Ibadah/ Pengajian/Perkumpulan Doa?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 17, N'score9', N'Apakah Anda pernah datang ke acara keramaian seperti Pesta/ Halal Bihalal/ Pernikahan/ Arisan?', NULL, NULL, NULL, NULL, 400, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 18, N'score10', N'Apakah Anda pernah datang ke acara atau mengikuti kegiatan Komunitas seperti komunitas lari, komunitas sepeda, dan komunitas hobi lain nya?', NULL, NULL, NULL, NULL, 600, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 19, N'score11', N'Apakah Anda pernah datang melayat atau menghadiri upacara pemakaman?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 20, N'score12', N'Apakah pernah mengalami sakit yang mengarah ke gejala Covid-19*, seperti demam/batuk/pilek/sakit tenggorokan/sesak?', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 21, N'suhu_tertinggi12', N'Jika Ya, Berapa suhu tertinggi selama 14 hari terakhir ini:', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 22, N'gejala12', N'Apa gejala/sakitnya:', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 23, N'riwayat_dokter12', N'dan jelaskan sudah konsultasi dokter atau dirawat dimana:', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 24, N'jawab1', N'Apakah ada keluhan sakit saat ini SELAIN yang mengarah ke gejala COVID-19?', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 25, N'jawab2', N'Apakah saat ini ada anggota keluarga satu rumah atau sekitar Anda yang sedang sakit? Jika ada, tuliskan hubungan tersebut dengan Anda dan deskripsikan keluhan yang dialaminya?', NULL, NULL, NULL, NULL, 700, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 26, N'jawab3', N'Apakah saat ini ada anggota keluarga satu rumah atau sekitar Anda yang sedang sakit? Jika ada, tuliskan hubungan tersebut dengan Anda dan deskripsikan keluhan yang dialaminya?', NULL, NULL, NULL, NULL, 700, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 27, N'jawab4', N'Apakah anggota keluarga tersebut sudah konsultasi ke dokter? mohon diberikan penjelasannya jika "Sudah" maupun "Belum"!', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 28, N'jawab8', N'Apakah ada yang masuk kategori ODP (Orang Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 29, N'hubungan_keluarga8', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 30, N'jarak8', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 31, N'interaksi8', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 32, N'jawab9', N'Apakah ada yang masuk kategori PDP (Pasien Dalam Pemantauan)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 33, N'hubungan_keluarga9', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 34, N'jarak9', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 35, N'interaksi9', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 36, N'jawab10', N'Apakah ada yang masuk kategori OTG (Orang Tanpa Gejala)', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 37, N'hubungan_keluarga10', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 38, N'jarak10', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 39, N'interaksi10', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 40, N'jawab11', N'Apakah ada yang masuk kategori POSITIF', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 41, N'hubungan_keluarga11', N'Apa hubungannya / kaitannya', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 42, N'jarak11', N'Jarak dari rumah', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportColumns (Columns_ReportID, Columns_Order, Columns_Name, Columns_Title, Columns_Format, Columns_Align, Columns_Group, Columns_Total, Columns_Width, Columns_Visible, Columns_Fixed, Columns_Loop) SELECT  84, 43, N'interaksi11', N'Apakah anda berinteraksi dengan orang tersebut', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  98, NULL, N'hr/dailyassessmentshift/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  97, NULL, N'hr/dailyassessmentresiko/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  95, NULL, N'hr/dailyassessmentpabrikkondisilingkungan/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  94, NULL, N'hr/dailyassessmentpabrikkeluhanlain/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  93, NULL, N'hr/dailyassessmentpabrikkondisikeluarga/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  91, NULL, N'hr/dailyassessmentrekap/get', N'CardTreePeriodVar', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  90, NULL, N'hr/dailyassessmentinput/get', N'CardTreePeriodDoughnut', N'Input', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  89, NULL, N'hr/dailyassessmentlingkungancovid/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  88, NULL, N'hr/dailyassessmenttidaksehat/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  87, NULL, N'hr/dailyassessmentkondisilingkungan/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  86, NULL, N'hr/dailyassessmentkondisikeluarga/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  85, NULL, N'hr/dailyassessmentkeluhanlain/get', N'CardTreePeriod', N'Compact', N'from,to', N'icon-people', N'success'  FROM dual;
 
INSERT into M_ReportDetail (ReportDetail_ID, ReportDetail_Component, ReportDetail_API, ReportDetail_Card, ReportDetail_Table, ReportDetail_Params, ReportDetail_Icon, ReportDetail_Color) SELECT  84, NULL, N'hr/dailyassessment/get', N'CardTreePeriod', N'Divisi', N'from,to,divisi', N'icon-people', N'success'  FROM dual;
 
END;