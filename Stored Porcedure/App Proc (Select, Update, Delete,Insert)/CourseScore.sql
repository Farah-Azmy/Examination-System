CREATE PROC CourseScore @studentID int
AS
BEGIN
	SELECT StudentID,CourseName,CONCAT(CONVERT(NVARCHAR(50), (SUM(Score)/COUNT(StudentID))*100), ' %') AS [TOTALSCORE] 
	FROM TakesExam 
	JOIN Questions ON TakesExam.QuestionID = Questions.QuestionID
	JOIN Course ON Questions.CourseID = Course.CourseID
	GROUP BY StudentID, CourseName
	HAVING STUDENTID = @studentID
END;

