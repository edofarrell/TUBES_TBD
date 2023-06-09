ALTER PROCEDURE [UpdateUser]
	@idUser [INT],
	@newUsername [VARCHAR](20),
	@newPassword [VARCHAR](20),
	@newIdRole [INT]
AS
	DECLARE
		@isSuccess [BIT]

	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE 
			[User]
		SET
			[username] = @newUsername,
			[password] = @newPassword,
			[idRole] = @newIdRole
		WHERE
			[idUser] = @idUser

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