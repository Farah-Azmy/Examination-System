--UpdateTrack with track id and optional parameters
CREATE PROCEDURE UpdateTrack
    @TrackID int,
    @InstructorID int = NULL,
    @TrackName varchar(50) = NULL,
    @HiringDate datetime = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if TrackID exists
    IF NOT EXISTS (SELECT 1 FROM Track WHERE TrackID = @TrackID)
    BEGIN
        PRINT 'TrackID does not exist.';
        RETURN; -- Exit the procedure if TrackID does not exist
    END

    -- Update Track table
    UPDATE Track
    SET InstructorID = ISNULL(@InstructorID, InstructorID),
        TrackName = ISNULL(@TrackName, TrackName),
        HiringDate = ISNULL(@HiringDate, HiringDate)
    WHERE TrackID = @TrackID;

    PRINT 'Track record updated successfully.';
END


UpdateTrack  3 , @instructorid =1 