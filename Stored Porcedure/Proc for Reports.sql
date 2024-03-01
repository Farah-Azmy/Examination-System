
-------------------------------------------------------------------------FirstReport--------------------------------------------
Alter Procedure StudentAccordingToTrack  @TrackName VARCHAR(50) =NULL

AS

BEGIN
    IF @TrackName IS NOT NULL
    BEGIN

        SELECT * FROM Student S 
		inner join Track T on S.TrackId=T.TrackID WHERE T.TrackName = @TrackName;
    END
    
END;



EXEC StudentAccordingToTrack @TrackName = 'Web Development';

------------------------------------------------------------------------SecondReport-------------------------------------------------------
ALTER PROC STUDENTSCORE @studentID int
AS
BEGIN
	SELECT StudentID,CONCAT(CONVERT(NVARCHAR(50), (SUM(Score)/COUNT(StudentID))*100), ' %') AS [TOTALSCORE] FROM TakesExam
	GROUP BY StudentID
	HAVING STUDENTID = @studentID
END;

EXEC STUDENTSCORE @studentID =360; 
------------------------------------------------------------------SecondReport1-----------------------------------------------
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


EXEC CourseScore 360;

--------------------------------------------------------------Third report-----------------------------------------------------
Create Procedure Count_Instructor_Students @InstrctorID INT 
WITH ENCRYPTION
AS
	
	Begin

	SELECT c.coursename, COUNT(s.studentid) AS CountStudents
    FROM course c
    inner JOIN studentcourse sc ON c.courseid = sc.courseid
    inner JOIN student s ON sc.studentid = s.studentid
	WHERE C.InstructorID=@InstrctorID
    GROUP BY c.coursename;
	
	END;



EXEC Count_Instructor_Students 7;
-------------------------------------------------------------FourthReport--------------------------------------------------
Create Procedure Course_Topics @CourseID INT 
WITH ENCRYPTION
AS
	
	Begin

	SELECT c.coursename, T.TopicName
    FROM course c
    inner JOIN CourseTopic CT ON c.courseid =CT.CourseID
    inner JOIN topic T ON CT.TopicID = T.TopicID
	WHERE C.CourseID=@CourseID	
	END;

EXEC  Course_Topics 25;
----------------------------------------------------------------FourthReport1-----------------------------------------------

Create Procedure Topic_Courses @TopicID INT 
WITH ENCRYPTION
AS
	
	Begin

	SELECT c.coursename, T.TopicName
    FROM course c
    inner JOIN CourseTopic CT ON c.courseid =CT.CourseID
    inner JOIN topic T ON CT.TopicID = T.TopicID
	WHERE T.TopicID=@TopicID	
	END;


EXEC  Topic_Courses 3;
-------------------------------------------------------------------FifthReport--------------------------------------------------------------
Create proc EXAM_CHOICES @EXAMID INT
 AS
  BEGIN 
		SELECT E.ExamID,Q.QuestionTitle,C.Choices FROM TakesExam E JOIN Questions Q 
		ON E.QuestionID= Q.QuestionID JOIN Choices C ON C.QuestionID=Q.QuestionID
		WHERE E.EXAMID=@EXAMID
  END;



EXEC EXAM_CHOICES 1;
----------------------------------------------------------------------SixthReport--------------------------------------------------------------

CREATE PROC STUDENT_ANSWER @STUDENTID INT, @EXAMID INT
 AS 
	BEGIN 
		 SELECT StudentID,ExamID, StudentAnswer FROM TakesExam
		 WHERE StudentID=@STUDENTID AND EXAMID=@EXAMID
	END;


EXEC STUDENT_ANSWER  @STUDENTID =360, @EXAMID=1;
-------------------------------------------------------------------------------------------------------------------------------
---------------------------------------fifth1-----------------------------------
Alter PROCEDURE EXAM_CHOICES @EXAMID INT
AS
BEGIN
    WITH ExamQuestions AS (
        SELECT
            Q.QuestionID,
            Q.QuestionTitle,
            Q.CorrectAnswer,
            C.Choices,
            ROW_NUMBER() OVER (PARTITION BY Q.QuestionID ORDER BY (SELECT NULL)) AS RN
        FROM
            TakesExam E
        JOIN
            Questions Q ON E.QuestionID = Q.QuestionID
        JOIN
            Choices C ON C.QuestionID = Q.QuestionID
        WHERE
            E.EXAMID = @EXAMID
    )
    SELECT
        QuestionTitle,
        CorrectAnswer,
        MAX(CASE WHEN RN = 1 THEN Choices END) AS Choice1,
        MAX(CASE WHEN RN = 2 THEN Choices END) AS Choice2,
        MAX(CASE WHEN RN = 3 THEN Choices END) AS Choice3
    FROM
        ExamQuestions
    GROUP BY
        QuestionID,
        QuestionTitle,
        CorrectAnswer;
END;

EXAM_CHOICES 2
