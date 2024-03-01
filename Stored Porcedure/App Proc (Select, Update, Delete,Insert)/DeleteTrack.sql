--DELETE TRACK	with given track ID
alter PROCEDURE DeleteTrack
    @TrackID int
AS
BEGIN
    SET NOCOUNT ON;


    -- Delete from Track table
    DELETE FROM Track WHERE TrackID = @TrackID;

    PRINT 'Track record deleted successfully.';
END


