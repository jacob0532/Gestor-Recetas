USE [GestorRecetas]
GO

/****** Object:  Table [dbo].[imagenesXReceta]    Script Date: 15/5/2023 12:39:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[imagenesXReceta](
	[idImagenesXReceta] [int] IDENTITY(1,1) NOT NULL,
	[imagen] [varchar](max) NOT NULL,
	[idRecetaFK] [int] NOT NULL,
 CONSTRAINT [PK_imagenesXReceta] PRIMARY KEY CLUSTERED 
(
	[idImagenesXReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[imagenesXReceta]  WITH CHECK ADD  CONSTRAINT [FK_imagenesXReceta_receta] FOREIGN KEY([idRecetaFK])
REFERENCES [dbo].[receta] ([idReceta])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[imagenesXReceta] CHECK CONSTRAINT [FK_imagenesXReceta_receta]
GO


