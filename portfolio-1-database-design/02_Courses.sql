USE LumenPortfolio;
GO
CREATE TABLE dbo.Courses (
    CourseID INT IDENTITY(1,1) CONSTRAINT PK_Courses PRIMARY KEY,
    CourseCode VARCHAR(15) NOT NULL CONSTRAINT UQ_Courses_Code UNIQUE,
    CourseTitle NVARCHAR(100) NOT NULL,
    CourseFee DECIMAL(12,2) NOT NULL CONSTRAINT CK_Courses_Fee CHECK (CourseFee >= 0),
    Capacity INT NOT NULL CONSTRAINT CK_Courses_Capacity CHECK (Capacity > 0)
);
GO
