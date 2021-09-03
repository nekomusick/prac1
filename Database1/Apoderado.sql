CREATE TABLE [dbo].[Apoderado]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Nombre] NCHAR(10) NULL, 
    [Telefono] NCHAR(10) NULL, 
    [id_alumno] INT NULL, 
    CONSTRAINT [FK_Apoderado_Alumno] FOREIGN KEY ([id_alumno]) REFERENCES [Alumno]([id])
)
