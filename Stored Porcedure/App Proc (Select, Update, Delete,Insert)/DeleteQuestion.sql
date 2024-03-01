-- DELETE QUESTION WITH GIVEN ID AND THE CORRESPONDING CHOICES will also be deleted

CREATE PROCEDURE DeleteQuestion
    @QuestionID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the question exists
    IF EXISTS (SELECT 1 FROM Questions WHERE QuestionID = @QuestionID)
    BEGIN
        -- Delete the question from the Questions table
        DELETE FROM Questions WHERE QuestionID = @QuestionID;

        -- Delete associated choices
        DELETE FROM Choices WHERE QuestionID = @QuestionID;
        
        PRINT 'Question deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Question not found.';
    END;
END;


