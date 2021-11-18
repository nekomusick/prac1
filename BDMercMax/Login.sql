CREATE PROCEDURE [dbo].[Login]
	@user int,
	@pass nvarchar(max) 
	AS

	SELECT cc_personal,cargo,nombre_apellido_personal FROM Personal where cc_personal=@user and password=@pass
RETURN 0
