-- Local partition-by-branch simulation, not physical distributed sharding.
USE LumenPortfolio;
GO
CREATE TABLE dbo.IbadanCourseRequests (
    BranchCode VARCHAR(3) NOT NULL CONSTRAINT CK_Ibadan_Branch CHECK (BranchCode = 'IBA'),
    RequestID INT NOT NULL,
    StudentID INT NOT NULL REFERENCES dbo.Students(StudentID),
    CourseID INT NOT NULL REFERENCES dbo.Courses(CourseID),
    CONSTRAINT PK_IbadanCourseRequests PRIMARY KEY (BranchCode, RequestID)
);
CREATE TABLE dbo.LagosCourseRequests (
    BranchCode VARCHAR(3) NOT NULL CONSTRAINT CK_Lagos_Branch CHECK (BranchCode = 'LOS'),
    RequestID INT NOT NULL,
    StudentID INT NOT NULL REFERENCES dbo.Students(StudentID),
    CourseID INT NOT NULL REFERENCES dbo.Courses(CourseID),
    CONSTRAINT PK_LagosCourseRequests PRIMARY KEY (BranchCode, RequestID)
);
INSERT INTO dbo.IbadanCourseRequests VALUES ('IBA', 1, 3, 1);
INSERT INTO dbo.LagosCourseRequests VALUES ('LOS', 1, 2, 2);
GO
CREATE VIEW dbo.AllCourseRequests AS
SELECT BranchCode, RequestID, StudentID, CourseID FROM dbo.IbadanCourseRequests
UNION ALL
SELECT BranchCode, RequestID, StudentID, CourseID FROM dbo.LagosCourseRequests;
GO
SELECT * FROM dbo.AllCourseRequests ORDER BY BranchCode, RequestID;
GO
-- The pair BranchCode + RequestID distinguishes request 1 in the two branches.
