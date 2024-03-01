---	AssignCourseToTrack Using course name and track name 

Create PROCEDURE AssignCourseToTrack
    @TrackName varchar(50),
    @CourseName varchar(255)

AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified track exists
    IF NOT EXISTS (SELECT 1 FROM Track WHERE TrackName = @TrackName)
    BEGIN
        PRINT 'Error: The specified TrackID does not exist.';
        RETURN;
    END

	IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseName = @CourseName)
    BEGIN
        PRINT 'Error: The specified Course does not exist.';
        RETURN; 
    END


    -- Get the CourseID of the course
    DECLARE @NewCourseID int;
    SET @NewCourseID = (Select CourseID from Course where CourseName=@CourseName)

	-- Get the TrackID of the course
    DECLARE @NewTrackID int;
    SET @NewTrackID = (Select trackid from Track where TrackName=@TrackName)
    -- Assign the course to the track
    INSERT INTO TrackCourse (TrackID, CourseID)
    VALUES (@NewTrackID, @NewCourseID);

    PRINT 'Course inserted into the track successfully.';
END



AssignCourseToTrack 'Web Development' ,'Data Modeling and DAX Functions'


