CREATE PROCEDURE SelectStudents
with encryption
AS
BEGIN
    SELECT * FROM Student;
END;