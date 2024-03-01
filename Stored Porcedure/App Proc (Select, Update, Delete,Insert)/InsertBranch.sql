CREATE PROCEDURE InsertBranch
    @BranchLocation Varchar(50),
    @BranchManager  Varchar(50) = NULL
with encryption
AS
BEGIN
    -- Check location already exists
    IF NOT EXISTS (SELECT BranchLocation FROM Branch WHERE BranchLocation = @BranchLocation)
	
    BEGIN
        -- Insert into branch table
        INSERT INTO Branch (BranchLocation, BranchManager) 
        VALUES (@BranchLocation, @BranchManager);
    END
    ELSE
    BEGIN
        -- Raise an error indicating that branch  already exists
        RAISERROR('Branch already exists.', 16, 1);
    END
END;
