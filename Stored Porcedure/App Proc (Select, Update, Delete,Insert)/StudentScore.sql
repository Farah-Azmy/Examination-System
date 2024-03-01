ALTER PROC STUDENTSCORE @studentID int
AS
BEGIN
	SELECT StudentID,CONCAT(CONVERT(NVARCHAR(50), (SUM(Score)/COUNT(StudentID))*100), ' %') AS [TOTALSCORE] FROM TakesExam
	GROUP BY StudentID
	HAVING STUDENTID = @studentID
END;

EXEC STUDENTSCORE 360;