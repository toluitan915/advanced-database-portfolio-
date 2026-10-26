-- All names, emails and payments below are fictional teaching data.
USE LumenPortfolio;
GO
INSERT INTO dbo.Students (FullName, Email, City) VALUES
(N'Ada Okoro', N'ada@example.test', N'Ibadan'),
(N'Tunde Bello', N'tunde@example.test', N'Lagos'),
(N'Zainab Musa', N'zainab@example.test', N'Ibadan'),
(N'Emeka Obi', N'emeka@example.test', N'Abeokuta');
INSERT INTO dbo.Courses (CourseCode, CourseTitle, CourseFee, Capacity) VALUES
('SQL101', N'SQL Fundamentals', 50000.00, 3),
('WEB101', N'Web Development', 75000.00, 2),
('DATA101', N'Data Analysis', 60000.00, 2);
INSERT INTO dbo.Enrolments (StudentID, CourseID, EnrolledOn, AgreedFee) VALUES
(1, 1, '20260901', 50000.00),
(2, 1, '20260902', 50000.00),
(1, 2, '20260903', 75000.00),
(3, 3, '20260904', 60000.00);
INSERT INTO dbo.Payments (EnrolmentID, Amount, PaidOn, PaymentReference) VALUES
(1, 30000.00, '20260901', 'DEMO-P001'),
(1, 20000.00, '20260905', 'DEMO-P002'),
(2, 25000.00, '20260902', 'DEMO-P003'),
(3, 75000.00, '20260903', 'DEMO-P004');
GO
