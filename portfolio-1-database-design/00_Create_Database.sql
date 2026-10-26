-- Run once in SQL Server Management Studio (SSMS).
-- Use a new practice database. No existing database is deleted.
USE master;
GO
IF DB_ID(N'LumenPortfolio') IS NULL
    CREATE DATABASE LumenPortfolio;
GO
USE LumenPortfolio;
GO
-- OPENJSON needs compatibility level 130 or above.
ALTER DATABASE LumenPortfolio SET COMPATIBILITY_LEVEL = 130;
GO
