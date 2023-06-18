ALTER PROCEDURE [GetNamaSurvei]
	@idSurvei [INT]
AS
	BEGIN TRANSACTION
	BEGIN TRY
		SELECT
			[Survei].[namaSurvei]
		FROM
			[Survei]
		WHERE
			[Survei].[idSurvei] = @idSurvei

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SELECT
			0

		ROLLBACK TRANSACTION
	END CATCH