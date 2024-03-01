---UpdateChoicesForQuestion   will take question id and will update the old choices with the new one

CREATE PROCEDURE UpdateChoicesForQuestion
    @QuestionID INT,
    @Choice1 VARCHAR(255) ,
    @Choice2 VARCHAR(255) ,
    @Choice3 VARCHAR(255) 
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the question exists
    IF EXISTS (SELECT 1 FROM Questions WHERE QuestionID = @QuestionID)
    BEGIN
        -- Update choices
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Delete existing choices for the question
            DELETE FROM Choices WHERE QuestionID = @QuestionID;

            -- Insert new choices
            
            INSERT INTO Choices (QuestionID, Choices) VALUES (@QuestionID, @Choice1),(@QuestionID, @Choice2),(@QuestionID, @Choice3);

           

            COMMIT TRANSACTION;
            PRINT 'Choices updated successfully.';
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error updating choices. Please check your input.';
        END CATCH;
    END
    ELSE
    BEGIN
        PRINT 'Question not found.';
    END;
END;
