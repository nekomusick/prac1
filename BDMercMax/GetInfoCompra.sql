CREATE PROCEDURE [dbo].[GetInfoCompra]
	@codigo int
	
AS
	SELECT nombre_proveedor, agente_ventas, telefono_proveedor  from Proveedor where nit = (select nit from Producto where barcode = @codigo)
RETURN 0
