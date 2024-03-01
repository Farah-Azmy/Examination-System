---	AssignInstructorToTrack Using InstructorName and track name 

Create PROCEDURE AssignInstructorToTrack
    @InstructorName varchar(50),
    @TrackName varchar(255)

AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified track exists
    IF NOT EXISTS (SELECT 1 FROM Track WHERE TrackName = @TrackName)
    BEGIN
        PRINT 'Error: The specified TrackName does not exist.';
        RETURN;
    END

	IF NOT EXISTS (SELECT 1 FROM Instructor WHERE CONCAT(FirstName,' ',LastName) = @InstructorName)
    BEGIN
        PRINT 'Error: The specified Instructor does not exist.';
        RETURN; 
    END


    -- Get the InstructorId of the Instructor
    DECLARE @NewInstructorID int;
    SET @NewInstructorID = (Select InstructorID from Instructor where CONCAT(FirstName,' ',LastName)=@InstructorName)

	-- Get the TrackID of the course
    DECLARE @NewTrackID int;
    SET @NewTrackID = (Select trackid from Track where TrackName=@TrackName)
    -- Assign the course to the track
    INSERT INTO TrackInstructor(InstructorID,TrackID)
    VALUES (@NewInstructorID,@NewTrackID);

    PRINT 'Instructor assigned to the track successfully.';
END





