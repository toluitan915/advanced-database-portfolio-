USE LumenPortfolio;
GO
-- Q1: Students living in Ibadan.
SELECT StudentID, FullName, City FROM dbo.Students
WHERE City = N'Ibadan' ORDER BY StudentID;

-- Q2: Class lists: joins replace repeated names in the enrolment table.
SELECT e.EnrolmentID, s.FullName, c.CourseTitle, e.EnrolledOn
FROM dbo.Enrolments AS e
INNER JOIN dbo.Students AS s ON s.StudentID = e.StudentID
INNER JOIN dbo.Courses AS c ON c.CourseID = e.CourseID
ORDER BY e.EnrolmentID;

-- Q3: Amount still owed. LEFT JOIN keeps students with no payments.
SELECT e.EnrolmentID, s.FullName, c.CourseCode, e.AgreedFee,
       ISNULL(SUM(p.Amount), 0) AS TotalPaid,
       e.AgreedFee - ISNULL(SUM(p.Amount), 0) AS BalanceDue
FROM dbo.Enrolments AS e
INNER JOIN dbo.Students AS s ON s.StudentID = e.StudentID
INNER JOIN dbo.Courses AS c ON c.CourseID = e.CourseID
LEFT JOIN dbo.Payments AS p ON p.EnrolmentID = e.EnrolmentID
GROUP BY e.EnrolmentID, s.FullName, c.CourseCode, e.AgreedFee
ORDER BY e.EnrolmentID;

-- Q4: Students who have not enrolled in any course.
SELECT s.StudentID, s.FullName
FROM dbo.Students AS s
WHERE NOT EXISTS (SELECT 1 FROM dbo.Enrolments AS e WHERE e.StudentID = s.StudentID)
ORDER BY s.StudentID;

-- Q5: Number of students on each course; COUNT(e.EnrolmentID) ignores nulls.
SELECT c.CourseCode, c.Capacity, COUNT(e.EnrolmentID) AS EnrolledStudents
FROM dbo.Courses AS c
LEFT JOIN dbo.Enrolments AS e ON e.CourseID = c.CourseID
GROUP BY c.CourseCode, c.Capacity ORDER BY c.CourseCode;

-- Q6: September receipts. A half-open range also works for datetime columns.
SELECT SUM(Amount) AS SeptemberReceipts FROM dbo.Payments
WHERE PaidOn >= '20260901' AND PaidOn < '20261001';
GO
