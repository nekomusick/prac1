CREATE PROCEDURE [dbo].[CrearFactura]
	@id int,
	@monto decimal,
	@date date,
	@montoIva decimal,
	@cliente int,
	@personal int


AS
	INSERT INTO Facturacion (id_factura, monto_total, fecha, monto_iva, cc_cliente, cc_personal) VALUES (@id, @monto, @date, @montoIva, @cliente, @personal)
RETURN 0

