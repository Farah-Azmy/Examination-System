CREATE PROCEDURE SelectBranch
    @BranchLocation VARCHAR(50) = NULL,
    @BranchManager VARCHAR(50) = NULL
AS
BEGIN
    IF @BranchLocation IS NOT NULL
    BEGIN
        -- Select by location
        SELECT * FROM Branch WHERE BranchLocation = @BranchLocation
    END
    ELSE IF @BranchManager IS NOT NULL
    BEGIN
        -- Select By manager
        SELECT * FROM branch WHERE BranchManager = @BranchManager;
    END
    ELSE
    BEGIN
        -- Select all data if no parameters are provided
        SELECT * FROM branch;
    END
END;