# Portfolio 2 — Queries and optimisation

01_Queries.sql covers filtering, joins, aggregation, a subquery and date ranges. Run it immediately after the sample data, before transaction exercises change the rows. Expected outputs are in evidence/Expected_Results.md and the CSV files. They were calculated from the supplied data, not captured from SQL Server.

The optimisation exercise creates 20,000 rows in a separate lab table. A applies YEAR and MONTH to the date. B removes those functions and uses a date range. C repeats B after adding an index on PaidOn with Amount included. Comparing A with B separates the query rewrite from the index change in B versus C. The index gives SQL Server an access path for the date range and includes the value needed for the sum. This can reduce page reads; it does not guarantee a particular plan or elapsed time.

Enable actual execution plans in SSMS before running. Save each plan, copy the Messages output and enter measurements in Performance_Results.csv. Logical reads count data-page accesses; elapsed time includes waiting, while CPU time records processor work. On a small or busy system, timings can be noisy or round to zero. Run each query once to warm it up, then collect five runs and compare the median. Keep the same server, data and connection settings. Do not count data loading or index creation as SELECT execution time.

The expected total is 52,000.00 for all three versions. The data spans 1 January 2024 to 26 September 2026, so this is a partial September. Check the same total before claiming an improvement. Discuss the measured plan and reads, even if SQL Server chooses a scan. An extra index uses space and adds work to inserts, updates and deletes; it is useful only if the read benefit justifies that cost.

No timings or execution plans were invented. The performance conclusion remains to be completed from your own run.
