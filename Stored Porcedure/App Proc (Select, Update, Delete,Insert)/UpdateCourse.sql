CREATE PROCEDURE UpdateCourse
    @oldcoursename VARCHAR(255),
    @newcoursename VARCHAR(255),
    @courseduration INT, 
    @instructorname VARCHAR(50)
AS 
BEGIN
    DECLARE @instructorid INT

    -- Get the InstructorID based on the provided instructor name
    SELECT @instructorid = InstructorID 
    FROM Instructor 
    WHERE CONCAT(FirstName, ' ', LastName) = @instructorname

    -- Update the Course table for the specified old CourseName
    UPDATE Course 
    SET CourseName = @newcoursename, 
        CourseDuration = @courseduration, 
        InstructorID = @instructorid
    WHERE CourseName = @oldcoursename
END;