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
PRINT N'Creando Vista [dbo].[VerInventario]...';


GO
CREATE VIEW [dbo].[VerInventario]
	AS SELECT barcode_producto,cantidad_gondola,cantidad_bodega FROM LugarStock
GO
PRINT N'Creando Procedimiento [dbo].[ComprarBodega]...';


GO
CREATE PROCEDURE [dbo].[ComprarBodega]
	@codigo int,
	@n int
AS
	UPDATE LugarStock SET cantidad_bodega = cantidad_bodega +@n where barcode_producto = @codigo
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearVenta]...';


GO
CREATE PROCEDURE [dbo].[CrearVenta]
	@id int,
	@n int,
	@factura int
AS
	INSERT INTO Venta( barcode_producto ,cantidad,id_factura) VALUES ( (SELECT barcode FROM Producto WHERE id_producto=@id),@n,@factura)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetFacturas]...';


GO
CREATE PROCEDURE [dbo].[GetFacturas]
	@id int = 0
	
AS
	SELECT id_factura,monto_total,monto_iva,fecha  from Facturacion where cc_cliente= @id
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetInfoCompra]...';


GO
CREATE PROCEDURE [dbo].[GetInfoCompra]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[MoverAgondola]...';


GO
CREATE PROCEDURE [dbo].[MoverAgondola]
	@codigo int ,
	@n int
AS
	UPDATE LugarStock SET cantidad_gondola= cantidad_gondola + @n, cantidad_bodega= cantidad_bodega-@n  Where barcode_producto = @codigo
RETURN 0
GO
PRINT N'Actualización completada.';


GO
