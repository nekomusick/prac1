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
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización 48f9acd3-2e76-4c45-b2c7-20f0beb9c7b2';

PRINT N'Cambiar el nombre de [dbo].[Cliente].[fecha_nacimiento_cliente] a fecha_nacimiento';


GO
EXECUTE sp_rename @objname = N'[dbo].[Cliente].[fecha_nacimiento_cliente]', @newname = N'fecha_nacimiento', @objtype = N'COLUMN';


GO
PRINT N'Creando Vista [dbo].[GetCountFacturas]...';


GO
CREATE VIEW [dbo].[GetCountFacturas]

	AS SELECT id_factura  FROM [Facturacion]
GO
PRINT N'Creando Vista [dbo].[VerClientes]...';


GO
CREATE VIEW [dbo].[VerClientes]


	AS SELECT cc_cliente,nombre_apellido_cliente,puntos_acumulados FROM [Cliente]
GO
PRINT N'Creando Vista [dbo].[VerProducto]...';


GO
CREATE VIEW [dbo].[VerProducto]

	AS SELECT nombre_producto,precio FROM [Producto]
GO
PRINT N'Creando Vista [dbo].[VerProductoPrecio]...';


GO
CREATE VIEW [dbo].[VerProductoPrecio]
 
	AS SELECT id_producto,nombre_producto  FROM [Producto]
GO
PRINT N'Creando Procedimiento [dbo].[ActualizarGondola]...';


GO
CREATE PROCEDURE [dbo].[ActualizarGondola]
	@id int ,
	@n int
AS
	UPDATE LugarStock SET cantidad_gondola=cantidad_gondola-@n WHERE barcode_producto=(SELECT barcode FROM Producto WHERE id_producto=@id)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[ActualizarPuntos]...';


GO
CREATE PROCEDURE [dbo].[ActualizarPuntos]
	@id int,
	@n int 
AS
	UPDATE Cliente SET Puntos_Acumulados=Puntos_Acumulados+@n WHERE cc_cliente=@id
RETURN 0
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
