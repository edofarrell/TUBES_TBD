/* 
	@jsonJawaban Format (JSON Array):
	[
		{
			"idPertanyaan": [NUMBER],
			"jawaban":		[STRING]
		},
		{
			"idPertanyaan": [NUMBER],
			"jawaban":		[STRING]
		}
	]
*/

ALTER PROCEDURE [UpdateJawaban]
	@idUser [INT],
	@idGroupJawaban [INT],
	@jsonJawaban [NVARCHAR](3350)
AS
	DECLARE @tabelJawaban TABLE
	(
		[idPertanyaan] [INT],
		[jawaban] [VARCHAR](300)
	)

	DECLARE 
		@currIdPertanyaan [INT],
		@currJawaban [VARCHAR](300),
		@currTipeJawaban [VARCHAR](10),
		@isSuccess [BIT]

	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO @tabelJawaban
		SELECT
			[idPertanyaan],
			[jawaban]
		FROM
			ParseJawaban(@jsonJawaban)

		DECLARE cursorJawaban CURSOR
		FOR
			SELECT 
				[@tabelJawaban].[idPertanyaan],
				[@tabelJawaban].[jawaban],
				[PertanyaanSurvei].[tipeJawaban]
			FROM 
				@tabelJawaban
				INNER JOIN [PertanyaanSurvei]
					ON [@tabelJawaban].[idPertanyaan] = [PertanyaanSurvei].[idPertanyaanSurvei]
		OPEN cursorJawaban

		FETCH NEXT FROM
			cursorJawaban
		INTO
			@currIdPertanyaan,
			@currJawaban,
			@currTipeJawaban

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			IF(@currTipeJawaban = 'NUMERIC')
			BEGIN
				UPDATE 
					[JawabanNumeric]
				SET
					[tombstone] = 0
				WHERE
					[idGroupJawaban] = @idGroupJawaban
					AND	[idPertanyaan] = @currIdPertanyaan
					AND	[tombstone] = 1

				INSERT INTO 
					[JawabanNumeric]([jawabanNumeric], [timestamp], [tombstone], [idPertanyaan], [idUser], [idGroupJawaban])
				VALUES
					(@currJawaban, CURRENT_TIMESTAMP, 1, @currIdPertanyaan, @idUser, @idGroupJawaban)
			END
			ELSE IF(@currTipeJawaban = 'DATE')
			BEGIN
				UPDATE 
					[JawabanDate]
				SET
					[tombstone] = 0
				WHERE
					[idGroupJawaban] = @idGroupJawaban
					AND	[idPertanyaan] = @currIdPertanyaan
					AND	[tombstone] = 1

				INSERT INTO 
					[JawabanDate]([jawabanDate], [timestamp], [tombstone], [idPertanyaan], [idUser], [idGroupJawaban])
				VALUES
					(@currJawaban, CURRENT_TIMESTAMP, 1, @currIdPertanyaan, @idUser, @idGroupJawaban)
			END
			ELSE
			BEGIN
				UPDATE 
					[JawabanString]
				SET
					[tombstone] = 0
				WHERE
					[idGroupJawaban] = @idGroupJawaban
					AND	[idPertanyaan] = @currIdPertanyaan
					AND	[tombstone] = 1

				INSERT INTO 
					[JawabanString]([jawabanString], [timestamp], [tombstone], [idPertanyaan], [idUser], [idGroupJawaban])
				VALUES
					(@currJawaban, CURRENT_TIMESTAMP, 1, @currIdPertanyaan, @idUser, @idGroupJawaban)
			END

			FETCH NEXT FROM
				cursorJawaban
			INTO
				@currIdPertanyaan,
				@currJawaban,
				@currTipeJawaban
		END

		CLOSE cursorJawaban
		DEALLOCATE cursorJawaban

		SET @isSuccess = 1

		SELECT
			@isSuccess

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @isSuccess = 0

		SELECT
			@isSuccess

		ROLLBACK TRANSACTION
	END CATCH