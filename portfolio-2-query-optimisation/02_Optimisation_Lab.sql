-- Isolated performance table: does not alter the portfolio payment totals.
-- Run the whole file. Re-running safely rebuilds only this lab table.
USE LumenPortfolio;
GO
IF OBJECT_ID(N'dbo.PaymentSearchLab', N'U') IS NOT NULL
    DROP TABLE dbo.PaymentSearchLab;
CREATE TABLE dbo.PaymentSearchLab (
    LabID INT IDENTITY(1,1) PRIMARY KEY,
    PaidOn DATE NOT NULL,
    Amount DECIMAL(12,2) NOT NULL
);
-- A simple loop is easy to follow; data loading is not part of query timing.
DECLARE @Row INT = 0;
BEGIN TRANSACTION;
WHILE @Row < 20000
BEGIN
    INSERT INTO dbo.PaymentSearchLab (PaidOn, Amount)
    VALUES (DATEADD(DAY, @Row % 1000, CONVERT(DATE, '20240101')), 100.00);
    SET @Row = @Row + 1;
END;
COMMIT TRANSACTION;
GO
-- SSMS: enable Include Actual Execution Plan (Ctrl+M) before running.
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
-- A: function on the date column, no useful date index.
SELECT SUM(Amount) AS Receipts FROM dbo.PaymentSearchLab
WHERE YEAR(PaidOn) = 2026 AND MONTH(PaidOn) = 9;
-- B: same answer, simpler range, still no date index.
SELECT SUM(Amount) AS Receipts FROM dbo.PaymentSearchLab
WHERE PaidOn >= '20260901' AND PaidOn < '20261001';
GO
CREATE INDEX IX_PaymentSearchLab_PaidOn
ON dbo.PaymentSearchLab(PaidOn) INCLUDE (Amount);
GO
-- C: range plus a covering index. The optimiser chooses the actual plan.
SELECT SUM(Amount) AS Receipts FROM dbo.PaymentSearchLab
WHERE PaidOn >= '20260901' AND PaidOn < '20261001';
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
-- All three answers should be 52000.00: 26 dates x 20 rows x 100.
-- The generated range ends on 2026-09-26, so September is partial.
-- Repeat each SELECT five times after one warm-up; record actual measurements.
-- Do not clear shared server caches. Save the A/B/C plans as .sqlplan files.
