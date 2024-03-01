----This procedure will insert a new course -- track name must be given to be assigned to it in the trackcourse

CREATE PROCEDURE InsertCourse 
				@coursename VARCHAR(255), @courseduration INT, @instructorname VARCHAR(50), @TrackName VARCHAR(50)
AS 
BEGIN
	DECLARE @instructorid INT

	SELECT @instructorid = InstructorID FROM Instructor 
	WHERE CONCAT(FirstName, ' ', LastName) = @instructorname

    INSERT INTO Course (CourseName, CourseDuration, InstructorID)
	VALUES (@coursename, @courseduration, @instructorid)
	
	DECLARE @COURSEID INT
	SET @COURSEID =SCOPE_IDENTITY()
	
	Declare @TrackID INT
	SELECT @TrackID = TrackID FROM Track 
	WHERE TrackName = @TrackName



	INSERT INTO TrackCourse(TrackID,CourseID) VALUES(@TrackID,@COURSEID)
END;
