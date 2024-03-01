--------------UPDATE  the job With the id of the (student)
CREATE PROCEDURE UpdateJobKPI
    @StudentID int,
    @Position varchar(50) = NULL,
    @CompanyName varchar(50) = NULL,
    @HiringDate datetime = NULL
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the STUDENT ID exists
    IF NOT EXISTS (SELECT 1 FROM JobKPI WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student does not exist.';
        RETURN;
    END

    -- Update Job record
    UPDATE JobKPI
    SET 
        Position = ISNULL(@Position, Position),
        CompanyName = ISNULL(@CompanyName, CompanyName),
        HiringDate = ISNULL(@HiringDate, HiringDate)
    WHERE StudentID = @StudentID;

    PRINT 'JobKPI record updated successfully.';
END