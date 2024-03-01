CREATE PROCEDURE GetCourseID @CourseName VARCHAR(50)
AS
BEGIN
	SELECT CourseID
	FROM Course
	WHERE CourseName = @CourseName
END