CREATE TABLE [dbo].[Inscrito]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [id_Alumno] INT NOT NULL, 
    [Cod_Curso] INT NOT NULL, 
    CONSTRAINT [FK_Inscrito_Alumno] FOREIGN KEY ([id_alumno]) REFERENCES [Alumno]([id]), 
    CONSTRAINT [FK_Inscrito_Curso] FOREIGN KEY ([Cod_Curso]) REFERENCES [Curso]([Cod])
)
