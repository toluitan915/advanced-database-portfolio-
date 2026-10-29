MIT 8103 - Advanced Database Systems Portfolio

Case Study: Lumen Training Centre - this is a simulated organization for this portfolio.

Database: I'm using Microsoft SQL Server (T-SQL) only. It should run on SQL Server 2014 or newer, compatibility level 120+, using SSMS. I didn't use any 
MySQL, PostgreSQL or MongoDB commands. GO is just the SSMS batch separator.

How to Run the Files

1. Database Design (portfolio-1): Run files 00 to 05 in order on a clean, fresh database. Each table has its own.sql file. Check the Design_Explanation.txt 
and ER_Diagram.svg/ER_Diagram.png for the design.

2. Query Optimisation (portfolio-2): Run 01_Queries.sql and compare your results with the expected CSVs. Then run 02_Optimisation_Lab.sql, save the actual 
execution plans and note down your measurements.

3. Transactions & Concurrency (portfolio-3): Run 01_Commit_Rollback.sql first, then 02_Enrol_Student_Procedure.sql. For 03 and 04, you need to open two 
separate SSMS windows and follow the instructions in the files. Only use 05 if you want to repeat the concurrency demo.

4. NoSQL (portfolio-4): Run 01_Course_Documents.sql and read the notes explaining SQL Server JSON vs a native NoSQL database.

5. Distributed / Cloud (portfolio-5): Run 01_Local_Partition_Demonstration.sql and read the cloud discussion document.

6. Final Steps: Complete the Evidence_Checklist.md in the evidence folder, fill in the performance CSV, and write your reflection. Final_Documentation.txt 
has a short 3-page summary draft - the print length will vary based on formatting.

Important: The create-table and seed scripts are meant to be run once. Don't rerun them on a database that already has data. None of the scripts will drop 
the whole database. If a lab stops halfway, check for open transactions and existing objects before you continue. The optimisation script only rebuilds its 
own lab table, and the concurrency reset only deletes the two demo enrolments if they have no payments.

GitHub and LMS

I created a private GitHub repo for this course and copied this same folder structure into it. I added the assessor using the method given in the course. 
I committed as I went along - design, queries, transactions, etc. - without backdating or faking a full semester history. I have added the real repo URL in 
Final_Documentation.txt. 