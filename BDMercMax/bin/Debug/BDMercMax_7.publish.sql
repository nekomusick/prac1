/*
Script de implementación para BDMercaMax

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDMercaMax"
:setvar DefaultFilePrefix "BDMercaMax"
:setvar DefaultDataPath "C:\Users\usuario\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\usuario\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'La operación de refactorización Cambiar nombre con la clave 48f9acd3-2e76-4c45-b2c7-20f0beb9c7b2 se ha omitido; no se cambiará el nombre del elemento [dbo].[Cliente].[fecha_nacimiento_cliente] (SqlSimpleColumn) a fecha_nacimiento';


GO
PRINT N'Creando Procedimiento [dbo].[GetIvaPuntos]...';


GO
CREATE PROCEDURE [dbo].[GetIvaPuntos]
	@id int
	
AS
	SELECT iva.puntos from Tipo_Producto where id_tipo =(select id_tipo from Producto where id_producto = @id )
RETURN 0
GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '48f9acd3-2e76-4c45-b2c7-20f0beb9c7b2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('48f9acd3-2e76-4c45-b2c7-20f0beb9c7b2')

GO

GO
PRINT N'Actualización completada.';


GO
