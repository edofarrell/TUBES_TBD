EXEC CreateRole 'Admin'
EXEC CreateRole 'Kader'
EXEC CreateRole 'Penanggung Jawab'

--Create User
--Dearen = Admin
--Edo = Kader
--Neil = Penanggung Jawab
EXEC CreateUser 'dearen', 'password', 1
EXEC CreateUser 'edo', 'password', 2
EXEC CreateUser 'neil', 'password', 3

--Create Survei
EXEC CreateSurvei 'Covid19'
EXEC CreateSurvei 'Demam Berdarah'
EXEC CreateSurvei 'Diare'

--Create Akses ke Survei
EXEC CreateAkses 2, 1
EXEC CreateAkses 2, 2
EXEC CreateAkses 2, 3

DECLARE @pertanyaanSurvei1 [NVARCHAR](2150) = 
'[
	{
		"pertanyaan": "Nama anda siapa?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Umur anda berapa?",
		"tipeJawaban": "NUMERIC"
	},
	{
		"pertanyaan": "Sudah vaksin kedua?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Vaksin terakhir tanggal berapa?",
		"tipeJawaban": "DATE"
	},
	{
		"pertanyaan": "Pernah terjangkit Covid19?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Apakah ada gejala batuk dalam seminggu terakhir?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Apakah pernah demam dalam seminggu terakhir?",
		"tipeJawaban": "STRING"
	}
]'

DECLARE @pertanyaanSurvei2 [NVARCHAR](2150) = 
'[
	{
		"pertanyaan": "Nama anda siapa?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Umur anda berapa?",
		"tipeJawaban": "NUMERIC"
	},
	{
		"pertanyaan": "Kapan terakhir mengalami demam berdarah?",
		"tipeJawaban": "DATE"
	},
	{
		"pertanyaan": "Apakah lingkungan tempat tinggal anda banyak nyamuk?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Sudah berapa kali anda terkena demam berdarah?",
		"tipeJawaban": "NUMERIC"
	}
]'

DECLARE @pertanyaanSurvei3 [NVARCHAR](2150) = 
'[
	{
		"pertanyaan": "Nama anda siapa?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Umur anda berapa?",
		"tipeJawaban": "NUMERIC"
	},
	{
		"pertanyaan": "Kapan terakhir mengalami diare?",
		"tipeJawaban": "DATE"
	},
	{
		"pertanyaan": "Apakah anda sering membeli makanan di luar?",
		"tipeJawaban": "STRING"
	},
	{
		"pertanyaan": "Apakah anda sering membeli makanan di luar?",
		"tipeJawaban": "STRING"
	}
]'

EXEC InsertPertanyaan 1, @pertanyaanSurvei1
EXEC InsertPertanyaan 2, @pertanyaanSurvei2
EXEC InsertPertanyaan 3, @pertanyaanSurvei3

--Insert Jawaban Survei
DECLARE @jawaban11 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 1,
		"jawaban": "Edo"
	},
	{
		"idPertanyaan": 2,
		"jawaban": 20
	},
	{
		"idPertanyaan": 3,
		"jawaban": "Sudah"
	},
	{
		"idPertanyaan": 4,
		"jawaban": "2023-01-20"
	},
	{
		"idPertanyaan": 5,
		"jawaban": "Pernah"
	}
]'

DECLARE @jawaban12 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 1,
		"jawaban": "Erwin Darsono"
	},
	{
		"idPertanyaan": 2,
		"jawaban": 45
	},
	{
		"idPertanyaan": 3,
		"jawaban": "Sudah"
	},
	{
		"idPertanyaan": 4,
		"jawaban": "2018-05-23"
	},
	{
		"idPertanyaan": 5,
		"jawaban": "Belum"
	},
	{
		"idPertanyaan": 6,
		"jawaban": "Ada"
	}
]'

DECLARE @jawaban21 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 8,
		"jawaban": "Dearen Hippy"
	},
	{
		"idPertanyaan": 9,
		"jawaban": 19
	},
	{
		"idPertanyaan": 10,
		"jawaban": "2022-10-18"
	},
	{
		"idPertanyaan": 11,
		"jawaban": "Iyaa"
	},
	{
		"idPertanyaan": 12,
		"jawaban": 1
	}
]'

DECLARE @jawaban31 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 13,
		"jawaban": "Neil Christopher"
	},
	{
		"idPertanyaan": 14,
		"jawaban": 19
	},
	{
		"idPertanyaan": 15,
		"jawaban": "2012-11-05"
	},
	{
		"idPertanyaan": 16,
		"jawaban": "Sering"
	},
	{
		"idPertanyaan": 17,
		"jawaban": "Punya"
	}
]'

EXEC InsertJawaban 2, 1, @jawaban11
EXEC InsertJawaban 2, 1, @jawaban12
EXEC InsertJawaban 2, 2, @jawaban21
EXEC InsertJawaban 2, 3, @jawaban31

DECLARE @jawabanEdit11 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 1,
		"jawaban": "Edo F"
	},
	{
		"idPertanyaan": 2,
		"jawaban": 21
	}
]'

DECLARE @jawabanEdit12 [NVARCHAR](3350) =
'[
	{
		"idPertanyaan": 1,
		"jawaban": "Edo Farrell"
	}
]'

EXEC UpdateJawaban 2, 1, @jawabanEdit11
EXEC UpdateJawaban 2, 1, @jawabanEdit12