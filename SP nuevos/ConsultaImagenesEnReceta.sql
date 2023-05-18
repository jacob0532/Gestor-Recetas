USE [GestorRecetas]
GO

/****** Object:  StoredProcedure [dbo].[ConsultaImagenesEnReceta]    Script Date: 15/5/2023 12:41:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConsultaImagenesEnReceta]
(
	--parametros de entrada
	@InIdReceta INT, 

	-- Parametros de salida
	@OutResultCode INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT @OutResultCode = 0 -- codigo de ejecucion exitoso
        IF EXISTS (SELECT 1 FROM dbo.receta WHERE idReceta = @InIdReceta)
        BEGIN
            SELECT imagen FROM dbo.imagenesXReceta WHERE idRecetaFK = @InIdReceta;
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


