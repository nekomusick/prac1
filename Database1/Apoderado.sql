CREATE TABLE [dbo].[Apoderado]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Nombre] NVARCHAR(50) NOT NULL, 
    [Telefono] NVARCHAR(50) NOT NULL, 
    [id_alumno] INT NOT NULL, 
    CONSTRAINT [FK_Apoderado_Alumno] FOREIGN KEY ([id_alumno]) REFERENCES [Alumno]([id])
)
