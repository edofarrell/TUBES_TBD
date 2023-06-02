 /* 
	Input Format (JSON Array):
	[
		{
			"idPertanyaan": [NUMBER],
			"pertanyaan":	[STRING],
			"tipeJawaban":	[STRING]
		},
		{
			"idPertanyaan": [NUMBER],
			"pertanyaan": 	[STRING],
			"tipeJawaban":	[STRING]
		}
	]

	Output Format:
	idPertanyaan	pertanyaan		tipeJawaban
	[INT]			[VARCHAR](150)	[VARCHAR](10)
*/

ALTER FUNCTION [ParsePertanyaan] 
(
	@json [NVARCHAR](2150)
)
RETURNS @result TABLE
(
	[idPertanyaan] [INT],
	[pertanyaan] [VARCHAR](150),
	[tipeJawaban] [VARCHAR](10)
)
AS
BEGIN
	DECLARE
		@currPertanyaan [VARCHAR](150)

	DECLARE cursorPertanyaan CURSOR
	FOR
		SELECT
			[value]
		FROM
			OPENJSON(@json)
	OPEN cursorPertanyaan

	FETCH NEXT FROM
		cursorPertanyaan
	INTO
		@currPertanyaan

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO @result
		SELECT
			[idPertanyaan],
			[pertanyaan],
			[tipeJawaban]
		FROM
			OPENJSON(@currPertanyaan)
		WITH
			(
				[idPertanyaan] [INT] '$.idPertanyaan',
				[pertanyaan] [VARCHAR](150) '$.pertanyaan',
				[tipeJawaban] [VARCHAR](11) '$.tipeJawaban'
			)

		FETCH NEXT FROM
			cursorPertanyaan
		INTO
			@currPertanyaan
	END

	CLOSE cursorPertanyaan
	DEALLOCATE cursorPertanyaan

	RETURN
END

/*
	String Format: "id1:pertanyaan1:tipe1,id2:pertanyaan2:tipe2,...,idn:pertanyaann:tipen"
	First seperator: ','
	Second seperator: ':'
*/
/*ALTER FUNCTION [ParsePertanyaan] 
(
	@json [VARCHAR](1000)
)
RETURNS @result TABLE
(
	[idPertanyaan] [INT],
	[pertanyaan] [VARCHAR](150),
	[tipeJawaban] [VARCHAR](10)
)
AS
BEGIN
	DECLARE cursorRow CURSOR
	FOR
		SELECT 
			value
		FROM
			STRING_SPLIT(@json, ',')
	OPEN cursorRow

	DECLARE @currRow varchar(150)
	FETCH NEXT FROM
		cursorRow
	INTO
		@currRow

	WHILE(@@FETCH_STATUS=0)
	BEGIN
		DECLARE
			@currId [INT],
			@currPertanyaan [VARCHAR](150),
			@currTipeJawaban [VARCHAR](10)

		DECLARE cursorData CURSOR
		FOR
			SELECT
				value
			FROM
				STRING_SPLIT(@currRow, ':')
		OPEN cursorData

		FETCH NEXT FROM
			cursorData
		INTO
			@currId

		FETCH NEXT FROM
			cursorData
		INTO
			@currPertanyaan

		FETCH NEXT FROM
			cursorData
		INTO
			@currTipeJawaban

		CLOSE cursorData
		DEALLOCATE cursorData

		INSERT INTO @result
		SELECT
			@currId,
			@currPertanyaan,
			@currTipeJawaban

		FETCH NEXT FROM
			cursorRow
		INTO
			@currRow
	END
	
	CLOSE cursorRow
	DEALLOCATE cursorRow

	RETURN
END*/