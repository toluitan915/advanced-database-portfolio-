USE LumenPortfolio;
GO
CREATE PROCEDURE dbo.EnrolStudent
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    DECLARE @Capacity INT, @Fee DECIMAL(12,2), @Count INT;
    BEGIN TRY
        BEGIN TRANSACTION;
        -- Hold an update lock on this course until the transaction finishes.
        -- Every competing caller must take this same lock before counting.
        SELECT @Capacity = Capacity, @Fee = CourseFee
        FROM dbo.Courses WITH (UPDLOCK, HOLDLOCK)
        WHERE CourseID = @CourseID;
        IF @Capacity IS NULL
            THROW 50001, 'The course does not exist.', 1;
        IF NOT EXISTS (SELECT 1 FROM dbo.Students WHERE StudentID = @StudentID)
            THROW 50002, 'The student does not exist.', 1;
        IF EXISTS (SELECT 1 FROM dbo.Enrolments WHERE StudentID = @StudentID AND CourseID = @CourseID)
            THROW 50003, 'The student is already enrolled.', 1;
        SELECT @Count = COUNT(*) FROM dbo.Enrolments WHERE CourseID = @CourseID;
        IF @Count >= @Capacity
            THROW 50004, 'There are no free places on this course.', 1;
        INSERT INTO dbo.Enrolments (StudentID, CourseID, EnrolledOn, AgreedFee)
        VALUES (@StudentID, @CourseID, CONVERT(DATE, GETDATE()), @Fee);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
