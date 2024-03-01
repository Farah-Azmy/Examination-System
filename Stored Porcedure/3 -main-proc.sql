-----------------------------------------------------------1-proc for Generation Exam------------------------
create PROCEDURE CreateExamv02 @CourseID INT, @StudentID INT
AS
BEGIN
    INSERT INTO Exam (TotalScore) VALUES (0);
    DECLARE @ExamID INT;
    SELECT @ExamID = MAX(ExamID) FROM Exam;

    CREATE TABLE #TempExam (StudentID INT, ExamID INT, QuestionID INT);

    INSERT INTO #TempExam (StudentID, ExamID, QuestionID)
    SELECT TOP 10
        @StudentID,
        @ExamID,
        Q.QuestionID
    FROM
        Questions Q
    WHERE
        Q.CourseID = @CourseID
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


EXEC CreateExamv02 @CourseID=8,@StudentID=360; 
EXEC CreateExamv02 @CourseID=2,@StudentID=905;
EXEC CreateExamv02 @CourseID=2,@StudentID=906;
--------------------------------------------------------------------------1-proc (another one)------------------------------------------------------
Alter PROCEDURE CreateExamv03 @CourseID INT, @StudentID INT
AS
BEGIN
    INSERT INTO Exam (TotalScore) VALUES (0);
    DECLARE @ExamID INT;
    SELECT @ExamID = MAX(ExamID) FROM Exam;

    CREATE TABLE #TempExam (StudentID INT, ExamID INT, QuestionID INT);

    -- Select 4 True/False Questions
		  INSERT INTO #TempExam (StudentID, ExamID, QuestionID)
		  SELECT TOP 4
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
		-- Select 6 MCQ Questions
		SELECT TOP 6
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


---------------------------------------calling------------------------------------------------

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


-----------------------------------------------------------2-proc for ANSEWER AND CORRECTION------------------------
CREATE PROCEDURE Answer_and_Correction (@std_id int , @ex_id int , @q_id varchar(50)  ,
												@ans varchar(200) = 'No answer')
AS
Begin
	IF Exists  (Select StudentID FROM Student  Where StudentID = @std_id)
		Begin
			IF Exists (Select ExamID From Exam Where ExamID=@ex_id)
				Begin
					IF Exists(Select QuestionID From Questions Where QuestionID=@q_id)
						Begin
							declare @grade int
							IF (Select CorrectAnswer From Questions Where  QuestionID= @q_id) = @ans
								Set @grade = 1 
							ELSE
								Set @grade = 0
							UPDATE TakesExam  
							SET StudentAnswer = @ans , score=@grade
							WHERE StudentID =@std_id AND ExamID=@ex_id AND QuestionID=@q_id
						END
					ELSE
						select 'Question_ID Not Found'
				END
			ELSE
				Select 'There is no Exam With This ID'
		END
	ELSE
		Select 'Student Id That you have Enterened Not Found'
END

EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =4 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =5 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =13 ,@ans = 'TRUE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =14 ,@ans = 'FALSE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =17 ,@ans = 'FALSE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =19,@ans = 'FALSE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =21 ,@ans = 'FALSE'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =52 ,@ans = 'Linear'
EXEC Answer_and_Correction @std_id =360, @ex_id=2 , @q_id =56 ,@ans = 'A unique identifier for each record in the table'
EXEC Answer_and_Correction @std_id =360, @ex_id=2, @q_id =59 ,@ans = 'INSERT INTO'
-----------------------------------------------------------3-proc for Total Grade---------------------------------------
CREATE PROCEDURE TotalGrade
    @ex_id INT
AS
BEGIN
    UPDATE Exam
    SET TotalScore = (
        SELECT ISNULL(SUM(score), 0)
        FROM TakesExam
        WHERE TakesExam.ExamID = @ex_id
        GROUP BY ExamID
    )
    WHERE ExamID = @ex_id;
END;

EXEC TotalGrade 2;
		  

			       











