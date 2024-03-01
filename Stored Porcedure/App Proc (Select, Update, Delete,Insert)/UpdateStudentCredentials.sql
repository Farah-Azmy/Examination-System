--update student email and password 
Create PROCEDURE UpdateStudentCredentials
    @StudentID INT,
    @NewEmail VARCHAR(255),
    @NewPassword VARCHAR(50) 
AS
BEGIN
    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student not found.';
        RETURN; -- Exit the stored procedure if the student is not found
    END

    -- Update email and password
    Else 
	BEGIN
		UPDATE Student
		SET
			Email = @NewEmail,
			[Password] = @NewPassword
		WHERE
			studentID = @StudentID;

		PRINT 'Student credentials updated successfully.';
	END
END;
