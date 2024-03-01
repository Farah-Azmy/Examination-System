---------	DeleteInstructor --->  based on Name 
CREATE PROCEDURE DeleteInstructorByName
    @FirstName varchar(50),
    @LastName varchar(50)
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the instructor exists
    IF EXISTS (
        SELECT 1 
        FROM Instructor 
        WHERE FirstName = @FirstName AND LastName = @LastName
    )
    BEGIN
        -- Delete the instructor
        DELETE FROM Instructor 
        WHERE FirstName = @FirstName AND LastName = @LastName;
        PRINT 'Instructor deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Instructor not found.';
    END
END