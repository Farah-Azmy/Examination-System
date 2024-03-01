CREATE PROCEDURE UpdateBranch
    @BranchID INT,
    @BranchLocation Varchar(50) =NULL,
    @BranchManager  Varchar(50) = NULL
with encryption
AS
BEGIN
    -- Check if ID  exists TO update 
    IF EXISTS (SELECT BranchID FROM Branch WHERE BranchID = @BranchID)
    BEGIN
        -- Update branch location and manager if they were given in parameters

		IF @BranchLocation IS NOT NULL
			UPDATE Branch SET BranchLocation=@BranchLocation
				WHERE BranchID=@BranchID
		IF @BranchManager IS NOT NULL
			UPDATE Branch SET BranchManager=@BranchManager
				WHERE BranchID=@BranchID   
    END
    ELSE
    BEGIN
        -- Raise an error indicating that branch ID Doesn't exist
        RAISERROR('This Location ID Doesnot Exist', 16, 1);
    END
END;