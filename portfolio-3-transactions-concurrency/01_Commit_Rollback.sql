USE LumenPortfolio;
GO
SET XACT_ABORT ON;
-- Commit: add a genuine test instalment once, without duplicating it on rerun.
BEGIN TRY
    BEGIN TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM dbo.Payments WHERE PaymentReference = 'DEMO-COMMIT-001')
        INSERT INTO dbo.Payments (EnrolmentID, Amount, PaidOn, PaymentReference)
        VALUES (2, 10000.00, '20260906', 'DEMO-COMMIT-001');
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
SELECT PaymentReference, Amount FROM dbo.Payments
WHERE PaymentReference = 'DEMO-COMMIT-001';
GO
-- Explicit rollback: the temporary catalogue fee is discarded.
BEGIN TRANSACTION;
UPDATE dbo.Courses SET CourseFee = 55000.00 WHERE CourseID = 1;
SELECT CourseFee AS FeeInsideTransaction FROM dbo.Courses WHERE CourseID = 1;
ROLLBACK TRANSACTION;
SELECT CourseFee AS FeeAfterRollback FROM dbo.Courses WHERE CourseID = 1;
GO
-- Error rollback: an invalid negative payment also cancels the earlier update.
SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE dbo.Courses SET CourseFee = 56000.00 WHERE CourseID = 1;
    INSERT INTO dbo.Payments (EnrolmentID, Amount, PaidOn, PaymentReference)
    VALUES (2, -100.00, '20260907', 'DEMO-INVALID-001');
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
SELECT CourseFee AS FeeAfterErrorRollback FROM dbo.Courses WHERE CourseID = 1;
GO
