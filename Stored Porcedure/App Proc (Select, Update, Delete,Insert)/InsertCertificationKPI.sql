----INsert for Certification , duration is optional
CREATE PROCEDURE InsertCertificationKPI
    @StudentID int,
    @CertificationName varchar(50),
    @Duration int =NULL,
    @Platform varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student does not exist.';
        RETURN; 
    END

    -- Insert into CertificationKPI table
    INSERT INTO CertificationKPI (StudentID, CertificationName, Duration, Platform)
    VALUES (@StudentID, @CertificationName, @Duration, @Platform);

    PRINT 'CertificationKPI record inserted successfully.';
END
