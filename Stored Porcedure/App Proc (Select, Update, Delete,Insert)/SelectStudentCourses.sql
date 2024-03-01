CREATE PROCEDURE SelectStudentCourses 
    @StudentID INT
AS
BEGIN
    SELECT Course.CourseID, CourseName
    FROM Course
	JOIN StudentCourse
	ON Course.CourseID = StudentCourse.CourseID 
    WHERE StudentID = @StudentID;
END;

EXEC SelectStudentCourses 10;