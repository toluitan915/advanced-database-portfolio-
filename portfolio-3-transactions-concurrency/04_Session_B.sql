-- Run in SSMS window B during window A's 20-second wait.
USE LumenPortfolio;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET LOCK_TIMEOUT 30000;
BEGIN TRY
    EXEC dbo.EnrolStudent @StudentID = 4, @CourseID = 1;
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
SET LOCK_TIMEOUT -1;
SELECT COUNT(*) AS EnrolledStudents FROM dbo.Enrolments WHERE CourseID = 1;
GO
-- Expected: B waits, then gets error 50004. Course 1 still has only 3 students.
