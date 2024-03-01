--Delete for Certifcation by CertID 
CREATE PROCEDURE DeleteCertificationKPI
    @CertificationID int
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete from CertificationKPI table
    DELETE FROM CertificationKPI WHERE CertificationID = @CertificationID;

    PRINT 'CertificationKPI record deleted successfully.';
END
