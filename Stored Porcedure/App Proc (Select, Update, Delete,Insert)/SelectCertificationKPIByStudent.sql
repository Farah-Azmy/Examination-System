--SELECT FOR CERTIFICATIONKPI   by student id 
Create PROCEDURE SelectCertificationKPIByStudent
    @StudentID int
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE StudentID = @StudentID)
    BEGIN
        PRINT 'Student does not exist.';
        RETURN;
    END

    SELECT concat(S.FirstName,S.LastName) AS FullName,C.CertificationName ,C.Platform FROM CertificationKPI C 
	inner join Student S on c.StudentID =S.StudentID
	WHERE S.StudentID = @StudentID;
END

