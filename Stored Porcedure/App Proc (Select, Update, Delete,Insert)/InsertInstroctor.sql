---InsertInstroctor  ----> based on firstname and lastname and other info are optional 
CREATE PROCEDURE InsertInstructor
    @FirstName varchar(50),
    @LastName varchar(50),
    @Age int = NULL,
    @Gender varchar(6) = NULL,
    @Phone int = NULL,
    @Location varchar(50) = NULL,
    @WorkingStatus varchar(50) = NULL,
    @Salary int = NULL,
    @HiringDate datetime = NULL
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Instructor (FirstName, LastName, Age, Gender, Phone, Location, WorkingStatus, Salary, HiringDate)
    VALUES (@FirstName, @LastName, @Age, @Gender, @Phone, @Location, @WorkingStatus, @Salary, @HiringDate);
END
