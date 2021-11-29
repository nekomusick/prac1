CREATE PROCEDURE [dbo].[GetFacturas]
	@id int = 0
	
AS
	SELECT id_factura,monto_total,monto_iva,fecha  from Facturacion where cc_cliente= @id
RETURN 0
