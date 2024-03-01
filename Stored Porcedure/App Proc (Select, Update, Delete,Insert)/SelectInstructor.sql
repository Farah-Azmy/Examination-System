---SelectInstructor
CREATE PROCEDURE SelectInstructor @InstructorID int
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    SELECT FirstName,LastName,Age,Gender,Phone,[Location],WorkingStatus,Salary,HiringDate
    FROM Instructor Where InstructorID=@InstructorID;
END