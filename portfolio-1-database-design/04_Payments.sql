USE LumenPortfolio;
GO
CREATE TABLE dbo.Payments (
    PaymentID INT IDENTITY(1,1) CONSTRAINT PK_Payments PRIMARY KEY,
    EnrolmentID INT NOT NULL,
    Amount DECIMAL(12,2) NOT NULL CONSTRAINT CK_Payments_Amount CHECK (Amount > 0),
    PaidOn DATE NOT NULL,
    PaymentReference VARCHAR(50) NOT NULL CONSTRAINT UQ_Payments_Reference UNIQUE,
    CONSTRAINT FK_Payments_Enrolments FOREIGN KEY (EnrolmentID) REFERENCES dbo.Enrolments(EnrolmentID)
);
GO
