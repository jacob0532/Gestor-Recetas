USE [GestorRecetas]
GO
/****** Object:  Table [dbo].[departamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departamento](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_departamento] PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Errores]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Errores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorProcedure] [varchar](max) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDate] [datetime] NULL,
 CONSTRAINT [PK_Errores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ingrediente]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ingrediente](
	[idIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[descripcion] [varchar](64) NOT NULL,
 CONSTRAINT [PK_ingrediente] PRIMARY KEY CLUSTERED 
(
	[idIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[paso]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso](
	[idPaso] [int] IDENTITY(1,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[descripcion] [varchar](256) NOT NULL,
 CONSTRAINT [PK_paso] PRIMARY KEY CLUSTERED 
(
	[idPaso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[receta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[receta](
	[idReceta] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](64) NOT NULL,
	[idArea] [int] NOT NULL,
	[idSubarea] [int] NOT NULL,
	[descripcion] [varchar](400) NOT NULL,
	[imagenes] [varchar](max) NULL,
 CONSTRAINT [PK_receta] PRIMARY KEY CLUSTERED 
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subDepartamento](
	[idSubDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](64) NOT NULL,
	[idDepartamento] [int] NOT NULL,
 CONSTRAINT [PK_subDepartamento] PRIMARY KEY CLUSTERED 
(
	[idSubDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](64) NOT NULL,
	[correo] [varchar](64) NOT NULL,
	[usuario] [varchar](64) NOT NULL,
	[contrasena] [varchar](64) NOT NULL,
	[telefono] [int] NOT NULL,
	[administrador] [bit] NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_ingrediente_receta] FOREIGN KEY([idReceta])
REFERENCES [dbo].[receta] ([idReceta])
GO
ALTER TABLE [dbo].[ingrediente] CHECK CONSTRAINT [FK_ingrediente_receta]
GO
ALTER TABLE [dbo].[paso]  WITH CHECK ADD  CONSTRAINT [FK_paso_receta] FOREIGN KEY([idReceta])
REFERENCES [dbo].[receta] ([idReceta])
GO
ALTER TABLE [dbo].[paso] CHECK CONSTRAINT [FK_paso_receta]
GO
ALTER TABLE [dbo].[receta]  WITH CHECK ADD  CONSTRAINT [FK_receta_departamento] FOREIGN KEY([idArea])
REFERENCES [dbo].[departamento] ([idDepartamento])
GO
ALTER TABLE [dbo].[receta] CHECK CONSTRAINT [FK_receta_departamento]
GO
ALTER TABLE [dbo].[receta]  WITH CHECK ADD  CONSTRAINT [FK_receta_subDepartamento] FOREIGN KEY([idSubarea])
REFERENCES [dbo].[subDepartamento] ([idSubDepartamento])
GO
ALTER TABLE [dbo].[receta] CHECK CONSTRAINT [FK_receta_subDepartamento]
GO
ALTER TABLE [dbo].[subDepartamento]  WITH CHECK ADD  CONSTRAINT [FK_subDepartamento_departamento] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[departamento] ([idDepartamento])
GO
ALTER TABLE [dbo].[subDepartamento] CHECK CONSTRAINT [FK_subDepartamento_departamento]
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDepartamentoEspecifico]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaDepartamentoEspecifico]
	-- Parametros de entrada
	@InIdDepartamento INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			idDepartamento,
			nombre
		FROM dbo.departamento
		WHERE idDepartamento = @InIdDepartamento
		ORDER BY nombre
		

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDepartamentos]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaDepartamentos]

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			idDepartamento,
			nombre
		FROM dbo.departamento
		ORDER BY nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaIngredientes]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaIngredientes]

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.nombre,
			ing.descripcion
		FROM dbo.ingrediente as ing
		INNER JOIN dbo.receta as rec
		ON ing.idReceta = rec.idReceta

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaIngredientesxReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaIngredientesxReceta]
	@inIdReceta INT,
	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.nombre,
			ing.descripcion
		FROM dbo.ingrediente as ing
		INNER JOIN dbo.receta as rec
		ON ing.idReceta = rec.idReceta
		WHERE ing.idReceta = @inIdReceta

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaPasos]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaPasos]

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.nombre,
			pas.descripcion
		FROM dbo.paso as pas
		INNER JOIN dbo.receta as rec
		ON pas.idReceta = rec.idReceta

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaPasoxReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaPasoxReceta]
	@inIdReceta INT,
	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.nombre,
			pas.descripcion
		FROM dbo.paso as pas
		INNER JOIN dbo.receta as rec
		ON pas.idReceta = rec.idReceta
		WHERE pas.idReceta = @inIdReceta

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaRecetaEspecifica]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaRecetaEspecifica]
	--parametros de entrada
	@InIdReceta INT, 

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.idReceta,
			rec.nombre,
			rec.descripcion,
			dep.nombre,
			subdep.nombre,
			rec.imagenes
		FROM dbo.receta as rec
		INNER JOIN dbo.departamento as dep
		ON rec.idArea = dep.idDepartamento
		INNER JOIN dbo.subDepartamento as subdep
		ON rec.idSubarea = subdep.idSubDepartamento
		WHERE rec.idReceta = @InIdReceta

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaRecetas]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaRecetas]

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.idReceta,
			rec.nombre,
			rec.descripcion,
			dep.nombre,
			subdep.nombre,
			rec.imagenes
		FROM dbo.receta as rec
		INNER JOIN dbo.departamento as dep
		ON rec.idArea = dep.idDepartamento
		INNER JOIN dbo.subDepartamento as subdep
		ON rec.idSubarea = subdep.idSubDepartamento
		ORDER BY rec.nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaRecetasXDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaRecetasXDepartamento]

	@inIdDepartamento INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.idReceta,
			rec.nombre,
			rec.descripcion,
			dep.nombre,
			subdep.nombre,
			rec.imagenes
		FROM dbo.receta as rec
		INNER JOIN dbo.departamento as dep
		ON rec.idArea = dep.idDepartamento
		INNER JOIN dbo.subDepartamento as subdep
		ON rec.idSubarea = subdep.idSubDepartamento
		WHERE rec.idArea = @inIdDepartamento
		ORDER BY rec.nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaRecetasXSubDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaRecetasXSubDepartamento]

	@inIdSubDepartamento INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			rec.idReceta,
			rec.nombre,
			rec.descripcion,
			dep.nombre,
			subdep.nombre,
			rec.imagenes
		FROM dbo.receta as rec
		INNER JOIN dbo.departamento as dep
		ON rec.idArea = dep.idDepartamento
		INNER JOIN dbo.subDepartamento as subdep
		ON rec.idSubarea = subdep.idSubDepartamento
		WHERE rec.idSubarea = @inIdSubDepartamento
		ORDER BY rec.nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaSubDepartamentoEspecifico]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaSubDepartamentoEspecifico]
	-- Parametros de entrada
	@InIdSubDepartamento INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			idSubDepartamento,
			Sub.nombre,
			Dep.nombre
		FROM dbo.subDepartamento as Sub
		INNER JOIN dbo.departamento as Dep ON 
			Sub.idDepartamento = Dep.idDepartamento
		WHERE idSubDepartamento = @InIdSubDepartamento
		ORDER BY Sub.nombre
		

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaSubDepartamentos]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaSubDepartamentos]

	@inIdDepartamento INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0


		--retorna id, nombre y nombre de area padre
		SELECT
			idSubDepartamento,
			Sub.nombre,
			Dep.nombre
		FROM dbo.subDepartamento as Sub
		INNER JOIN dbo.departamento as Dep ON 
			Sub.idDepartamento = Dep.idDepartamento
		WHERE sub.idDepartamento = @inIdDepartamento
		ORDER BY Sub.nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaSubDepartamentosGeneral]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaSubDepartamentosGeneral]
	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0


		--retorna id, nombre y nombre de area padre
		SELECT
			idSubDepartamento,
			Sub.nombre,
			Dep.nombre
		FROM dbo.subDepartamento as Sub
		INNER JOIN dbo.departamento as Dep ON 
			Sub.idDepartamento = Dep.idDepartamento
		ORDER BY Sub.nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaUsuarioEspecifico]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaUsuarioEspecifico]
	-- Parametros de entrada
	@InUsuario INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.usuario WHERE idUsuario = @InUsuario)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT
			idUsuario,
			nombre,
			correo,
			usuario,
			contrasena,
			telefono,
			administrador
		FROM dbo.usuario
		WHERE idUsuario = @InUsuario

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaUsuarios]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaUsuarios]

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		SELECT
			idUsuario,
			nombre,
			correo,
			usuario,
			contrasena,
			telefono,
			administrador
		FROM dbo.usuario
		ORDER BY nombre

	SET NOCOUNT OFF;

END


GO
/****** Object:  StoredProcedure [dbo].[sp_EditarDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarDepartamento]
	@inID INT,
	@innombre NVARCHAR(64),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.departamento
			SET nombre = @innombre
			WHERE  idDepartamento = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarImgReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarImgReceta]
	@inIDReceta INT,
	@inImagen VARCHAR(MAX),

-- Este sp solo cambia la imagen de una receta

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		
		SELECT
				@OutResultCode=1

		BEGIN TRY
			SELECT
				@OutResultCode=0 
					WHERE EXISTS (SELECT idReceta FROM dbo.receta WHERE idReceta = @inIDReceta) -- codigo de ejecucion exitoso

			UPDATE dbo.receta
			SET imagenes = @inImagen
			WHERE  idReceta = @inIDReceta

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarIngrediente]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarIngrediente]
	@inID INT,
	@indescripcion NVARCHAR(64),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.ingrediente
			SET descripcion = @indescripcion
			WHERE  idIngrediente = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarPaso]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarPaso]
	@inID INT,
	@indescripcion VARCHAR(256),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.paso
			SET descripcion = @indescripcion
			WHERE  idPaso = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarReceta]
	@inIDReceta INT,
	@inNombre NVARCHAR(64),
	@indescripcion VARCHAR(400),


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT
				@OutResultCode=1

		BEGIN TRY
			SELECT
				@OutResultCode=0 
					WHERE EXISTS (SELECT idReceta FROM dbo.receta WHERE idReceta = @inIDReceta) -- codigo de ejecucion exitoso

			UPDATE dbo.receta
			SET nombre =  @inNombre,
				descripcion = @indescripcion
			WHERE  idReceta = @inIDReceta
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarRecetaCmp]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarRecetaCmp]
	@inIDReceta INT,
	@inNombre NVARCHAR(64),
	@indescripcion VARCHAR(400),
	@inImagen VARCHAR(MAX),

-- Este sp tambien cambia la imagen a diferencia del editar receta normal

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT
				@OutResultCode=1

		BEGIN TRY
			SELECT
				@OutResultCode=0 
					WHERE EXISTS (SELECT idReceta FROM dbo.receta WHERE idReceta = @inIDReceta) -- codigo de ejecucion exitoso

			UPDATE dbo.receta
			SET nombre =  @inNombre,
				descripcion = @indescripcion,
				imagenes = @inImagen
			WHERE  idReceta = @inIDReceta
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarSubDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarSubDepartamento]
	@inID INT,
	@innombre NVARCHAR(64),
	@inidDepartamento INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.subDepartamento
			SET nombre = @innombre,
				idDepartamento = @inidDepartamento
			WHERE  idSubDepartamento = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarUsuario]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarUsuario]
	@inID INT,
	@innombre NVARCHAR(64),
	@incorreo NVARCHAR(64),
	@inusuario NVARCHAR(64),
	@incontrasena NVARCHAR(64),
	@intelefono INT,
	@inadministrador BIT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.usuario
			SET nombre = @innombre,
				correo = @incorreo,
				usuario = @inusuario,
				contrasena = @incontrasena,
				telefono = @intelefono,
				administrador = @inadministrador
			WHERE  idUsuario = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarDepartamento]
	@inDepartamentoId INT,


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
			DECLARE @Count INT
			DECLARE @RecetaEliminar INT
			DECLARE @RecetasEliminar TABLE		-- Tabla para almacenar las recetas por eliminar
			(	
				IdReceta INT
			)

			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			INSERT INTO @RecetasEliminar
						SELECT IdReceta FROM dbo.receta WHERE idArea = @inDepartamentoId;

			SELECT @Count = COUNT(*) FROM @RecetasEliminar;
					-- while para eliminar todas las recetas relacionadas al departamento
					WHILE @Count>0
					BEGIN
						
						SET @RecetaEliminar = (SELECT TOP 1 IdReceta FROM @RecetasEliminar);

						EXEC sp_EliminarReceta @RecetaEliminar,0;

						DELETE TOP (1) FROM @RecetasEliminar;
						SELECT @Count = COUNT(*) FROM @RecetasEliminar;
					END
			
			DELETE FROM dbo.subDepartamento 
				WHERE idDepartamento = @inDepartamentoId;

			DELETE FROM dbo.departamento 
				WHERE idDepartamento = @inDepartamentoId;
		
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarIngrediente]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarIngrediente]
	@inID INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			DELETE FROM dbo.ingrediente 
				WHERE idIngrediente = @inID;

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarPaso]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarPaso]
	@inID INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			DELETE FROM dbo.paso 
				WHERE idPaso = @inID;

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarReceta]
	@inIdReceta INT,


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso
			
			DELETE FROM dbo.ingrediente 
				WHERE idReceta = @inIdReceta;

			DELETE FROM dbo.paso 
				WHERE idReceta = @inIdReceta;

			DELETE FROM dbo.receta 
				WHERE idReceta = @inIdReceta;
		
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarSubDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarSubDepartamento]
	@insubDepartamentoId INT,


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso
			
			DELETE FROM dbo.subDepartamento 
				WHERE idSubDepartamento = @insubDepartamentoId;
		
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarUsuario]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarUsuario]
	@inID INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			DELETE FROM dbo.usuario 
				WHERE idUsuario = @inID;

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarDepartamento]
	@innombre NVARCHAR(64),


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			INSERT INTO dbo.departamento
			(
				nombre
			)
			VALUES 
			(
				@innombre
			)
		END TRY
		BEGIN CATCH

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarIngrediente]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarIngrediente]
	@inidReceta INT,
	@indescripcion NVARCHAR(64),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			IF EXISTS (SELECT 1 FROM dbo.receta WHERE idReceta = @inidReceta)
			BEGIN
				INSERT INTO dbo.ingrediente
				(
					idReceta,
					descripcion
				)
				VALUES 
				(
					@inidReceta,
					@indescripcion
				)
			END
		END TRY
		BEGIN CATCH

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarPaso]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarPaso]
	@inidReceta INT,
	@indescripcion VARCHAR(256),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			IF EXISTS (SELECT 1 FROM dbo.receta WHERE idReceta = @inidReceta)
			BEGIN
				INSERT INTO dbo.paso
				(
					idReceta,
					descripcion
				)
				VALUES 
				(
					@inidReceta,
					@indescripcion
				)
			END
		END TRY
		BEGIN CATCH

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarReceta]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarReceta]
	@inNombre NVARCHAR(64),
	@inidArea INT,
	@inidSubArea INT,
	@indescripcion VARCHAR(400),
	@inImagen VARCHAR(MAX),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			IF EXISTS (SELECT 1 FROM dbo.departamento WHERE idDepartamento = @inidArea)
			BEGIN
				IF EXISTS (SELECT 1 FROM dbo.subDepartamento WHERE idSubDepartamento = @inidSubArea)
				BEGIN
					INSERT INTO dbo.receta
					(
						nombre,
						idArea,
						idSubarea,
						descripcion,
						imagenes
					)
					VALUES 
					(
						@inNombre,
						@inidArea,
						@inidSubArea,
						@indescripcion,
						@inImagen
					)
				END
			END
		END TRY
		BEGIN CATCH


		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH

		SELECT
				@OutResultCode
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarRecetaCmp]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarRecetaCmp]
	@inNombre NVARCHAR(64),
	@inidArea INT,
	@inidSubArea INT,
	@indescripcion VARCHAR(400),
	@inImagen VARCHAR(MAX),
	@inPasos NVARCHAR(MAX),
	@inIngredientes NVARCHAR(MAX),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			DECLARE @idReceta INT
			DECLARE @Count INT
			DECLARE @descripcion1 VARCHAR(64)
			DECLARE @descripcion2 VARCHAR(256)


			DECLARE @ingredientesReceta TABLE				-- Tabla para almacenar los ingredientes
			(	
				descripcion VARCHAR(64)
			)

			DECLARE @pasosReceta TABLE				-- Tabla para almacenar los pasos 
			(	
				descripcion VARCHAR(256)
			)

			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			IF EXISTS (SELECT 1 FROM dbo.departamento WHERE idDepartamento = @inidArea)
			BEGIN
				IF EXISTS (SELECT 1 FROM dbo.subDepartamento WHERE idSubDepartamento = @inidSubArea)
				BEGIN
					SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

					BEGIN TRANSACTION InsertarReceta
					
					INSERT INTO dbo.receta
					(
						nombre,
						idArea,
						idSubarea,
						descripcion,
						imagenes
					)
					VALUES 
					(
						@inNombre,
						@inidArea,
						@inidSubArea,
						@indescripcion,
						@inImagen
					)
					
					SET @idReceta = (SELECT MAX(idReceta) FROM dbo.receta) --ultima receta ingresada

					--Parseo de ingredientes, agarra todo divido por una coma
					INSERT INTO @ingredientesReceta
						SELECT value  
						FROM STRING_SPLIT(@inIngredientes, ',')  
						WHERE RTRIM(value) <> '';

					SELECT @Count = COUNT(*) FROM @ingredientesReceta;

					WHILE @Count>0
					BEGIN
						SET @descripcion1 = (SELECT TOP 1 descripcion FROM @ingredientesReceta);

						EXEC sp_InsertarIngrediente @idReceta, @descripcion1, 0;

						DELETE TOP (1) FROM @ingredientesReceta;
						SELECT @Count = COUNT(*) FROM @ingredientesReceta;
					END

					--Parseo de pasos, agarra todo divido por una coma
					INSERT INTO @pasosReceta
						SELECT value  
						FROM STRING_SPLIT(@inPasos, ',')  
						WHERE RTRIM(value) <> '';

					SELECT @Count = COUNT(*) FROM @pasosReceta;

					WHILE @Count>0
					BEGIN
						SET @descripcion2 = (SELECT TOP 1 descripcion FROM @pasosReceta);

						EXEC sp_InsertarPaso @idReceta, @descripcion2, 0;

						DELETE TOP (1) FROM @pasosReceta;
						SELECT @Count = COUNT(*) FROM @pasosReceta;
					END


				END
			END

			COMMIT TRANSACTION InsertarReceta

		END TRY
		BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION InsertarReceta;



		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH
	SET NOCOUNT OFF;
END



GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarSubDepartamento]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarSubDepartamento]
	@innombre NVARCHAR(64),
	@indepartamentoId INT,


-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			IF NOT EXISTS (SELECT 1 FROM dbo.departamento WHERE idDepartamento = @indepartamentoId)
			BEGIN
				SET @OutResultCode = 5001			-- Error por si no encuentra el departamento
				RETURN
			END
			ELSE
			BEGIN 
			INSERT INTO dbo.subDepartamento
			(
				nombre,
				idDepartamento
			)
			VALUES 
			(
				@innombre,
				@indepartamentoId
			)
			END
		END TRY
		BEGIN CATCH

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarUsuario]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarUsuario]
	@innombre NVARCHAR(64),
	@incorreo NVARCHAR(64),
	@inusuario NVARCHAR(64),
	@incontrasena NVARCHAR(64),
	@intelefono INT,
	@inadministrador BIT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			INSERT INTO dbo.usuario
			(
				nombre,
				correo,
				usuario,
				contrasena,
				telefono,
				administrador
			)
			VALUES 
			(
				@innombre,
				@incorreo,
				@inusuario,
				@incontrasena,
				@intelefono,
				@inadministrador
			)
		END TRY
		BEGIN CATCH

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

		END CATCH

		SELECT @OutResultCode
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 5/5/2023 20:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Login]
	-- Parametros de entrada
	@InUsuario NVARCHAR(64),

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.usuario WHERE usuario = @InUsuario)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT
			idUsuario,
			nombre,
			correo,
			usuario,
			contrasena,
			telefono,
			administrador
		FROM dbo.usuario
		WHERE usuario = @InUsuario

	SET NOCOUNT OFF;

END


GO
