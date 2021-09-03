CREATE TABLE [dbo].[Curso]
(
	[Cod] INT NOT NULL PRIMARY KEY, 
    [Nombre] NVARCHAR(50) NOT NULL, 
    [Fecha_inicio] DATE NOT NULL, 
    [Duracion] INT NOT NULL 
)
