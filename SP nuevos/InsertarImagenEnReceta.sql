USE [GestorRecetas]
GO

/****** Object:  StoredProcedure [dbo].[InsertarImagenEnReceta]    Script Date: 15/5/2023 12:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertarImagenEnReceta]
(
	@idRecetaFK INT,
    @imagen VARCHAR(max),
    -- parametros de salida
    @OutResultCode INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @ultimo INT;
    BEGIN TRY
        SELECT @OutResultCode = 0 -- codigo de ejecucion exitoso
		IF(@idRecetaFK = 0)
			BEGIN
				EXEC ObtenerUltimoElementoInsertado 'dbo.receta', @ultimoElemento = @ultimo OUTPUT;
				SET @idRecetaFK = @ultimo;
			END
		ELSE
			BEGIN
				SET @idRecetaFK = 1;
			END
		--SELECT @idRecetaFK;
        IF EXISTS (SELECT 1 FROM dbo.receta WHERE idReceta = @idRecetaFK)
        BEGIN
            INSERT INTO [dbo].[imagenesXReceta]
            (
                [imagen],
                [idRecetaFK]
            )
            VALUES
            (
                @imagen,
                @idRecetaFK
            )
        END
    END TRY
    BEGIN CATCH
        INSERT INTO dbo.Errores VALUES (
            ERROR_NUMBER(),
            ERROR_STATE(),
            ERROR_SEVERITY(),
            ERROR_PROCEDURE(),
            ERROR_LINE(),
            ERROR_MESSAGE(),
            GETDATE()
        )

        SET @OutResultCode = 501; -- No se inserto en la tabla
    END CATCH

    SELECT @OutResultCode
    SET NOCOUNT OFF;
END



GO


