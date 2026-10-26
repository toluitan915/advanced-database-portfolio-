-- Document-style modelling implemented entirely in Microsoft T-SQL.
USE LumenPortfolio;
GO
CREATE TABLE dbo.CourseDocuments (
    CourseID INT CONSTRAINT PK_CourseDocuments PRIMARY KEY,
    Details NVARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_CourseDocuments_Courses FOREIGN KEY (CourseID) REFERENCES dbo.Courses(CourseID),
    CONSTRAINT CK_CourseDocuments_Json CHECK (ISJSON(Details) = 1)
);
GO
INSERT INTO dbo.CourseDocuments (CourseID, Details) VALUES
(1, N'{"level":"Beginner","delivery":"Online","topics":["SELECT","JOIN","GROUP BY"],"resources":{"videoMinutes":90}}'),
(2, N'{"level":"Intermediate","delivery":"Classroom","topics":["HTML","CSS"],"resources":{"labRequired":true}}');
-- Read scalar values without requiring columns for every optional attribute.
SELECT CourseID, JSON_VALUE(Details, '$.level') AS CourseLevel,
       JSON_VALUE(Details, '$.delivery') AS DeliveryMode
FROM dbo.CourseDocuments ORDER BY CourseID;
-- Expand the nested list into rows. OPENJSON requires compatibility >= 130.
SELECT d.CourseID, t.[value] AS Topic
FROM dbo.CourseDocuments AS d
CROSS APPLY OPENJSON(d.Details, '$.topics') AS t
ORDER BY d.CourseID, CONVERT(INT, t.[key]);
-- Update an optional property using T-SQL.
UPDATE dbo.CourseDocuments
SET Details = JSON_MODIFY(Details, '$.resources.videoMinutes', 120)
WHERE CourseID = 1;
SELECT JSON_VALUE(Details, '$.resources.videoMinutes') AS VideoMinutes
FROM dbo.CourseDocuments WHERE CourseID = 1;
-- Export the relational course list as a JSON document result.
SELECT CourseID, CourseCode, CourseTitle FROM dbo.Courses
ORDER BY CourseID FOR JSON PATH, ROOT('courses');
GO
