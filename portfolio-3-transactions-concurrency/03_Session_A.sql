-- Open in SSMS window A. Run before window B, on baseline enrolments.
USE LumenPortfolio;
GO
BEGIN TRY
    BEGIN TRANSACTION;
    SELECT CourseID, Capacity FROM dbo.Courses WITH (UPDLOCK, HOLDLOCK)
    WHERE CourseID = 1;
    PRINT 'Course 1 is locked. Run Session B now.';
    WAITFOR DELAY '00:00:20';
    EXEC dbo.EnrolStudent @StudentID = 3, @CourseID = 1;
    -- The inner COMMIT reduces nesting; this COMMIT releases the outer lock.
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
SELECT StudentID, CourseID FROM dbo.Enrolments WHERE CourseID = 1 ORDER BY StudentID;
GO
