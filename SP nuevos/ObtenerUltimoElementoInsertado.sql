USE [GestorRecetas]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerUltimoElementoInsertado]    Script Date: 15/5/2023 12:42:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ObtenerUltimoElementoInsertado]
(
    @tabla NVARCHAR(128),
    @ultimoElemento INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql = N'SELECT @ultimoElemento = IDENT_CURRENT(''' + @tabla + ''')';

    EXEC sp_executesql @sql, N'@ultimoElemento INT OUTPUT', @ultimoElemento = @ultimoElemento OUTPUT;

    SET NOCOUNT OFF;
END
GO


