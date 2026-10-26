-- Run only after BOTH demonstration windows have finished.
-- Removes only the two registrations used by this exercise, with no payments.
USE LumenPortfolio;
GO
DELETE e FROM dbo.Enrolments AS e
WHERE e.CourseID = 1 AND e.StudentID IN (3,4)
AND NOT EXISTS (SELECT 1 FROM dbo.Payments AS p WHERE p.EnrolmentID = e.EnrolmentID);
SELECT COUNT(*) AS StartingEnrolments FROM dbo.Enrolments WHERE CourseID = 1;
-- Should be 2 before repeating Session A and Session B.
GO
