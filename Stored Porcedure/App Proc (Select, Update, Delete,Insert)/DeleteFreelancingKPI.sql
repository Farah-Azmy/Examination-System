--- Delete  using studentid
CREATE PROCEDURE DeleteFreelancingKPI
    @StudentID int
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the StudentID exists
    IF NOT EXISTS (SELECT 1 FROM FreelancingKPI WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student ID does not exist.';
        RETURN; -- Exit the procedure if FreelancingKPI ID does not exist
    END

    -- Delete FreelancingKPI record
    DELETE FROM FreelancingKPI WHERE StudentId = @StudentID;

    PRINT 'FreelancingKPI record deleted successfully.';
END