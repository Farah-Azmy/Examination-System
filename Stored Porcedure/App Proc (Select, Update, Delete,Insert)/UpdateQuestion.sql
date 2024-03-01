--- Update question with the given data 
CREATE PROCEDURE UpdateQuestion
    @QuestionID INT,
    @QuestionTitle VARCHAR(255) = NULL,
    @CorrectAnswer VARCHAR(255) = NULL,
    @QuestionType VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the question exists
    IF EXISTS (SELECT 1 FROM Questions WHERE QuestionID = @QuestionID)
    BEGIN
        -- Update the question
        UPDATE Questions
        SET QuestionTitle = ISNULL(@QuestionTitle, QuestionTitle),
            CorrectAnswer = ISNULL(@CorrectAnswer, CorrectAnswer),
            QuestionType = ISNULL(@QuestionType, QuestionType)
        WHERE QuestionID = @QuestionID;

        PRINT 'Question updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Question not found.';
    END;
END;
