Create PROCEDURE CreateExamv03 @CourseID INT, @StudentID INT
AS
BEGIN
    INSERT INTO Exam (TotalScore) VALUES (0);
    DECLARE @ExamID INT;
    SELECT @ExamID = MAX(ExamID) FROM Exam;

    CREATE TABLE #TempExam (StudentID INT, ExamID INT, QuestionID INT);

    -- Select 3 True/False Questions
		  INSERT INTO #TempExam (StudentID, ExamID, QuestionID)
		  SELECT TOP 3
		    @StudentID,
			@ExamID,
			Q.QuestionID
			FROM
			Questions Q
			WHERE
			Q.CourseID = @CourseID
			AND Q.QuestionType = 'TF' 
			ORDER BY
			NEWID();
		INSERT INTO #TempExam (StudentID, ExamID, QuestionID)
		SELECT TOP 7
			@StudentID,
			@ExamID,
			Q.QuestionID
		FROM
			Questions Q
		WHERE
			Q.CourseID = @CourseID
			AND Q.QuestionType = 'MCQ' 
		ORDER BY
			NEWID();

		SELECT Q.QuestionID, Q.QuestionTitle, Choices
		FROM
			Questions Q
		JOIN
			Choices C ON Q.QuestionID = C.QuestionID
		JOIN
			#TempExam TE ON Q.QuestionID = TE.QuestionID;

		INSERT INTO TakesExam (StudentID, ExamID, QuestionID)
		SELECT
			StudentID,
			ExamID,
			QuestionID
		FROM
			#TempExam;

		DROP TABLE #TempExam;

		END;

EXEC CreateExamv03 @CourseID=25,@StudentID=360; 

EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =115 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =116 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =113 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =103 ,@ans = 'Angular'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =110 ,@ans = 'Single Page Application'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =105,@ans = 'Front-end user interfaces'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =109 ,@ans = 'Virtual DOM'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =111 ,@ans = 'Twitter'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =106 ,@ans = '12'
EXEC Answer_and_Correction @std_id =360, @ex_id=4 , @q_id =102 ,@ans = 'Vue.js'


EXEC TotalGrade 4;
