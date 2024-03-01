-----------DELETE the job with student id


CREATE PROCEDURE DeleteJobKPI
    @StudentID int
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the JobKPIID exists
    IF NOT EXISTS (SELECT 1 FROM JobKPI WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'student job does not exist.';
        RETURN; 
    END

    -- Delete JobKPI record
    DELETE FROM JobKPI WHERE StudentID = @StudentID;

    PRINT 'JobKPI record deleted successfully.';
END