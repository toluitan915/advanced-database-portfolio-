# Portfolio 4 — Document model

The same training-centre case study needs different optional course details. A video course has videoMinutes, while a practical course has labRequired. A document groups these flexible details and the topics list together. CourseID is the document key. The supplied T-SQL stores two documents, reads scalar fields, expands a nested array, changes a property and exports relational data as JSON.

A document database would typically store each course document as an item in a collection. Here, SQL Server stores JSON text in an NVARCHAR(MAX) column. This is a hybrid relational/document implementation, not a separate NoSQL database. It keeps every executable query in Microsoft T-SQL, as requested. If the assessor requires an actual NoSQL engine, this implementation alone does not meet that requirement; confirm whether this document-model demonstration is accepted.

Flexible documents suit optional course resources that are usually read together. Enrolments and payments remain relational because keys, joins and transactional checks are important there. ISJSON checks JSON syntax; it does not guarantee that level exists or that videoMinutes is a positive number. Important business fields therefore stay in typed relational columns. Flexible storage shifts some validation work to the application or additional checks. A course title is not copied into the document, avoiding two conflicting sources for the same title.

Expected topic rows: course 1 has SELECT, JOIN and GROUP BY; course 2 has HTML and CSS. The updated videoMinutes value is 120. Save actual query grids or exported results as evidence.
