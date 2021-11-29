CREATE PROCEDURE [dbo].[MoverAgondola]
	@codigo int ,
	@n int
AS
	UPDATE LugarStock SET cantidad_gondola= cantidad_gondola + @n, cantidad_bodega= cantidad_bodega-@n  Where barcode_producto = @codigo
RETURN 0
