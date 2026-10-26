USE LumenPortfolio;
GO
CREATE TABLE dbo.Enrolments (
    EnrolmentID INT IDENTITY(1,1) CONSTRAINT PK_Enrolments PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrolledOn DATE NOT NULL,
    AgreedFee DECIMAL(12,2) NOT NULL CONSTRAINT CK_Enrolments_Fee CHECK (AgreedFee >= 0),
    CONSTRAINT FK_Enrolments_Students FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID),
    CONSTRAINT FK_Enrolments_Courses FOREIGN KEY (CourseID) REFERENCES dbo.Courses(CourseID),
    CONSTRAINT UQ_Enrolments_StudentCourse UNIQUE (StudentID, CourseID)
);
GO
