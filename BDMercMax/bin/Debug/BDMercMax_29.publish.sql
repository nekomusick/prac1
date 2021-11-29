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
Se está quitando la columna [dbo].[Proveedor].[direcion_proveedor]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[Proveedor].[direccion_proveedor] de la tabla [dbo].[Proveedor], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Proveedor])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Clave externa [dbo].[FK_Producto_ToTable]...';


GO
ALTER TABLE [dbo].[Producto] DROP CONSTRAINT [FK_Producto_ToTable];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Proveedor]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Proveedor] (
    [nit]                 INT            NOT NULL,
    [nombre_proveedor]    NVARCHAR (MAX) NOT NULL,
    [telefono_proveedor]  NVARCHAR (MAX) NOT NULL,
    [email_proveedor]     NVARCHAR (MAX) NOT NULL,
    [direccion_proveedor] NVARCHAR (MAX) NOT NULL,
    [agente_ventas]       NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([nit] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Proveedor])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Proveedor] ([nit], [nombre_proveedor], [telefono_proveedor], [email_proveedor], [agente_ventas])
        SELECT   [nit],
                 [nombre_proveedor],
                 [telefono_proveedor],
                 [email_proveedor],
                 [agente_ventas]
        FROM     [dbo].[Proveedor]
        ORDER BY [nit] ASC;
    END

DROP TABLE [dbo].[Proveedor];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Proveedor]', N'Proveedor';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_Producto_ToTable]...';


GO
ALTER TABLE [dbo].[Producto] WITH NOCHECK
    ADD CONSTRAINT [FK_Producto_ToTable] FOREIGN KEY ([nit]) REFERENCES [dbo].[Proveedor] ([nit]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Producto] WITH CHECK CHECK CONSTRAINT [FK_Producto_ToTable];


GO
PRINT N'Actualización completada.';


GO
