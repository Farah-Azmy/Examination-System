CREATE PROCEDURE AdminLoginProdcedure @email VARCHAR(50), @password VARCHAR(50)
AS
BEGIN
	SELECT AdminID
	FROM AdminLogin
	WHERE AdminEmail = @email AND AdminPassword = @password
END