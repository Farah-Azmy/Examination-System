CREATE PROCEDURE DeleteCourse 
				@coursename VARCHAR(255)
AS 
BEGIN
	DELETE FROM Course 
	WHERE  CourseName = @coursename
END;

EXEC DeleteCourse @coursename = "newCourse"