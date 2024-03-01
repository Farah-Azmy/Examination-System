--- Insert Question and if the type is TF it will insert the  true and false in the  choices  table for the same id
-- and if type is mcq , then the user should fill the 2 wrong choices parameters in the stored and it will be inserted in the choices table
--  in mcq questions , the correct answer is automatically inserted as a choice in the table when given in the parameters

Create PROCEDURE InsertQuestion
    @CourseID int,
    @QuestionType varchar(50),
    @QuestionTitle varchar(255),
    @CorrectAnswer varchar(255),
	@Choice1 varchar(255) =NULL,
	@Choice2 varchar(255) =NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified CourseID exists
    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = @CourseID)
    BEGIN
        PRINT 'Error: The specified CourseID does not exist.';
        RETURN;
    END

    -- Check if the QuestionType is valid
    IF @QuestionType NOT IN ('MCQ', 'TF')
    BEGIN
        PRINT 'Error: Invalid QuestionType. Must be either "MCQ" or "TF".';
        RETURN; 
    END

    -- Insert into Questions table
    INSERT INTO Questions (CourseID, QuestionType, QuestionTitle, CorrectAnswer)
    VALUES (@CourseID, @QuestionType, @QuestionTitle, @CorrectAnswer);

    PRINT 'Question inserted successfully.';

    -- If the question type is TF, insert choices into the Choices TRUE AND FALSE IN THE  table
    IF @QuestionType = 'TF'
    BEGIN
        DECLARE @QuestionID int;
        SET @QuestionID = SCOPE_IDENTITY(); -- Get the ID of the newly inserted question

        -- Insert choices into Choices table
        INSERT INTO Choices (QuestionID, Choices)
        VALUES (@QuestionID, 'TRUE'), (@QuestionID, 'FALSE');

        PRINT 'Choices inserted for True/False question.';
    END

	-- IF THE QUESTION TYPE IS MCQ then it will insert the choices parameter into the choices table for the quesiton id 
	ELSE IF @QuestionType = 'MCQ'
    BEGIN
        DECLARE @QuestionID2 int;
        SET @QuestionID2 = SCOPE_IDENTITY(); -- Get the ID of the newly inserted question

        -- Check if all choices are prsovided
        IF @Choice1 IS NULL OR @Choice2 IS NULL 
        BEGIN
            PRINT 'Error: Choices cannot be NULL for MCQ questions.';
            DELETE FROM Questions WHERE QuestionID = @QuestionID2; -- Rollback insertion
            RETURN; -- Exit the procedure
        END

        -- Insert choices into Choices table
        INSERT INTO Choices (QuestionID, Choices) 
		VALUES (@QuestionID2, @Choice1),(@QuestionID2, @Choice2),(@QuestionID2, @CorrectAnswer);


        PRINT 'Choices inserted successfully.';
    END 
END


