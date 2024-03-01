CREATE PROCEDURE SelectQuestforCourseId @CourseID INT
AS
BEGIN
    CREATE TABLE #TempExam (QuestionID INT);
    INSERT INTO #TempExam (QuestionID)
    SELECT TOP 10 QuestionID
    FROM Questions Q
  where CourseID = @CourseID 
    ORDER BY NEWID();
    SELECT Q.QuestionID, Q.QuestionTitle,Choices
    FROM Questions Q join Choices C ON Q.QuestionID=C.QuestionID
    JOIN #TempExam TE ON Q.QuestionID = TE.QuestionID;
    DROP TABLE #TempExam;
END;