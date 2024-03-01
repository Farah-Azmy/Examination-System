----------------INSERTJOBKPI ---> insert with all data
CREATE PROCEDURE InsertJobKPI
    @StudentID int,
    @Position varchar(50),
    @CompanyName varchar(50),
    @HiringDate datetime
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student does not exist.';
        RETURN; 
    END

    -- Insert into JobKPI table
    INSERT INTO JobKPI (StudentID, Position, CompanyName, HiringDate)
    VALUES (@StudentID, @Position, @CompanyName, @HiringDate);

    PRINT 'JobKPI record inserted successfully.';
END