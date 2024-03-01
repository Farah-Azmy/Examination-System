CREATE PROCEDURE DeleteBranch
    @BranchID INT ,
    @BranchLocation Varchar(50) =NULL,
    @BranchManager  Varchar(50) = NULL
with encryption

AS
BEGIN
    -- Check if ID exists
    IF EXISTS (SELECT BranchID FROM Branch WHERE BranchID = @BranchID)
    BEGIN
        -- delete  branch with that id 
        DELETE  Branch WHERE BranchID=@BranchID
    END
    ELSE
    BEGIN
        -- Raise an error indicating that branch ID doesn't exists
        RAISERROR('Branch Doesnot Exists.', 16, 1);
    END
END;