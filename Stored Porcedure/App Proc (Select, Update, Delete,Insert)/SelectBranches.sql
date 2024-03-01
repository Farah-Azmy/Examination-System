CREATE PROCEDURE SelectBranches
with encryption
AS
BEGIN
    SELECT * FROM Branch;
END;