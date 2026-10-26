# Portfolio 3 — Transactions and concurrency

Run 01 to demonstrate commit, explicit rollback and rollback after a constraint error. The committed instalment is 10,000.00 for enrolment 2. It changes the original total receipts from 150,000.00 to 160,000.00 and its remaining balance from 25,000.00 to 15,000.00. The fee briefly changes to 55,000.00 inside a transaction, then returns to 50,000.00 after rollback. The negative payment causes a CHECK error (normally 547), and the earlier fee update is also rolled back.

Atomicity means all changes in a transaction succeed together or are undone together. Consistency means the transaction preserves applicable rules, including constraints and the capacity check. Isolation controls what competing transactions can see or change. Durability means a committed change is retained by the database; a backup is still needed for disaster recovery.

## The concurrency problem
Course 1 has capacity 3 and two existing enrolments. Without coordination, two users could both count two students, both see a free place and both insert. The count would become four. A transaction around each insert alone does not stop this check-then-insert race.

Create the procedure in 02. Open two separate SSMS windows connected to the same database. Run 03 in window A, then 04 in window B during the 20-second pause. A holds an update lock on the course, enrols student 3 and commits. B must wait for that lock, then count again. It should report error 50004 because the course is now full. Capture B waiting, its final message and the three final registrations. If B reports a timeout, check that A has completed and repeat after 05.

READ COMMITTED avoids reading another transaction's uncommitted data. UPDLOCK requests an update lock; HOLDLOCK retains serializable-style locking for the course lookup until the transaction ends. The essential rule is that all competing enrolment writers use the same course-lock protocol. This is a local locking demonstration, not a claim that arbitrary direct INSERTs are safe. Staff should not have unrestricted table-write permission in a deployed system.

The procedure is intended as a standalone transaction. Session A deliberately wraps it in an outer transaction for the demonstration; nested SQL Server transactions do not commit independently. An error rolls back the active transaction. Close neither window with an open transaction: use ROLLBACK if a run was interrupted. Use 05 only after both windows finish to repeat the exercise.
