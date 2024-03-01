---UPDATE with student id any specified value
CREATE PROCEDURE UpdateFreelancingKPI
    @StudentID int,
    @TrackName varchar(50) = NULL,
    @Tool varchar(50) = NULL,
    @Platform varchar(50) = NULL,
    @Duration int = NULL,
    @Cost int = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the FreelanceID exists
    IF NOT EXISTS (SELECT 1 FROM FreelancingKPI WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'FreelancingKPI ID does not exist.';
        RETURN; 
    END

    -- Update FreelancingKPI record
    UPDATE FreelancingKPI
    SET 
        TrackName = ISNULL(@TrackName, TrackName),
        Tool = ISNULL(@Tool, Tool),
        Platform = ISNULL(@Platform, Platform),
        Duration = ISNULL(@Duration, Duration),
        Cost = ISNULL(@Cost, Cost)
    WHERE StudentID = @StudentID;

    PRINT 'FreelancingKPI record updated successfully.';
END
