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
/*
Se está quitando la columna [dbo].[LugarStock].[cantidad_gondola]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[LugarStock])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Modificando Tabla [dbo].[LugarStock]...';


GO
ALTER TABLE [dbo].[LugarStock] DROP COLUMN [cantidad_gondola];


GO
PRINT N'Creando Procedimiento [dbo].[VerProductorBodega]...';


GO
CREATE PROCEDURE [dbo].[VerProductorBodega]
	@codProd int
	
AS
	SELECT cantidad_bodega, seccion_bodega  FROM LugarStock WHERE barcode_producto=@codProd 
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[VerPuntos]...';


GO
CREATE PROCEDURE [dbo].[VerPuntos]
	@user int
	
AS
	SELECT puntos_acumulados FROM Cliente WHERE cc_cliente=@user 
RETURN 0
GO
PRINT N'Actualización completada.';


GO
