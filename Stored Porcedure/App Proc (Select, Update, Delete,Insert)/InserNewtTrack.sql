-- INSERT A NEW TRACK AND ASSIGIN IT to SuperVisor and the a branch using ids 
CREATE PROCEDURE InserNewtTrack
    @TrackName varchar(50),
    @InstructorID int,
    @HiringDate datetime,
    @BranchID int 
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified InstructorID exists
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'Error: The specified InstructorID does not exist.';
        RETURN; -- Exit the procedure if the InstructorID does not exist
    END

    -- Insert into Track table
    INSERT INTO Track (TrackName, InstructorID, HiringDate)
    VALUES (@TrackName, @InstructorID, @HiringDate);

    -- Get the TrackID of the newly inserted track
    DECLARE @NewTrackID int;
    SET @NewTrackID = SCOPE_IDENTITY();

    -- Assign the track to a branch
    IF EXISTS (SELECT 1 FROM Branch WHERE BranchID = @BranchID)
    BEGIN
        -- Insert into TrackBranch table
        INSERT INTO TrackBranch (TrackID, BranchID)
        VALUES (@NewTrackID, @BranchID);
    END
    ELSE
    BEGIN
        
        PRINT 'The specified branch does not exist. Track was not assigned to any branch.';
    END

    PRINT 'Track record inserted successfully.';
END


InsertTrack  'dax', 2 , '2/2/2020', 1