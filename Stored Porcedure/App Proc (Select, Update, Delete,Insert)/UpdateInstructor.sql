-----UPDATEInstructor --->  based on ID and the option to update any given field
CREATE PROCEDURE UpdateInstructor
    @InstructorID int,
    @FirstName varchar(50) = NULL,
    @LastName varchar(50) = NULL,
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

    UPDATE Instructor
    SET 
        FirstName = ISNULL(@FirstName, FirstName),
        LastName = ISNULL(@LastName, LastName),
        Age = ISNULL(@Age, Age),
        Gender = ISNULL(@Gender, Gender),
        Phone = ISNULL(@Phone, Phone),
        Location = ISNULL(@Location, Location),
        WorkingStatus = ISNULL(@WorkingStatus, WorkingStatus),
        Salary = ISNULL(@Salary, Salary),
        HiringDate = ISNULL(@HiringDate, HiringDate)
    WHERE InstructorID = @InstructorID;
END