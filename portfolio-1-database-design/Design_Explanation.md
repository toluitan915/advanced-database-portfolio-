# Portfolio 1 — Database design

## Selected case study
Lumen Training Centre is a simulated training business, inspired by an LMS. This portfolio is a separate teaching database, not a description or modification of the attached Lumen application. Administrators register students and courses, admissions staff enrol learners, and accounts staff record instalment payments. The database stores learner contact details, courses, enrolments and payments. It supports class lists, outstanding-fee reports, payment history and course-capacity checks. All money is in Nigerian naira.

## Scope and assumptions
Each course represents one offering. A student can enrol once in each course and pay in several instalments. Repeated academic terms, refunds, course cancellation, authentication and the full production LMS are outside this small model. AgreedFee records the price accepted at enrolment; changing CourseFee later must not change an existing agreement. Capacity is the maximum number of enrolments, not a balance that is repeatedly decremented. The controlled enrolment procedure checks capacity; table constraints alone cannot enforce that cross-row rule. Real deployment should restrict enrolment writes to the procedure and carefully control capacity reductions.

## Relational schema
- Students(**StudentID** PK, FullName, Email UNIQUE, City)
- Courses(**CourseID** PK, CourseCode UNIQUE, CourseTitle, CourseFee, Capacity)
- Enrolments(**EnrolmentID** PK, StudentID FK, CourseID FK, EnrolledOn, AgreedFee; UNIQUE StudentID + CourseID)
- Payments(**PaymentID** PK, EnrolmentID FK, Amount, PaidOn, PaymentReference UNIQUE)

Students have zero or more enrolments; each enrolment belongs to one student. Courses have zero or more enrolments; each enrolment belongs to one course. An enrolment has zero or more payments; each payment belongs to one enrolment. The many-to-many student/course relationship is resolved by Enrolments. See ER_Diagram.svg or ER_Diagram.png.

## Normalisation in plain language
An unnormalised enrolment sheet could contain StudentName, Email, CourseCode, CourseTitle and a list of payments in one cell. That makes searching payments and updating a course title difficult.

First normal form: every column holds one value, and each payment has its own row. A list of payments is not stored in a single relational cell.

Second normal form: in a combined registration table keyed by StudentID and CourseID, student contact details depend only on StudentID and course details depend only on CourseID. Moving these details into Students and Courses removes those partial dependencies. Enrolment date and agreed price belong to the enrolment itself.

Third normal form: non-key details are not copied through another non-key identifier. For example, Enrolments holds CourseID but does not repeat CourseTitle; Payments holds EnrolmentID but does not repeat StudentName. The main dependencies are StudentID -> student details, CourseID -> course details, EnrolmentID -> enrolment details, and PaymentID -> payment details. Email, CourseCode, StudentID + CourseID and PaymentReference are alternate keys. AgreedFee is a historical agreement, so it is not a duplicate of the current catalogue price.

## Why the constraints matter
Primary keys identify rows. Foreign keys prevent payments for missing enrolments and registrations for missing students or courses. Unique constraints prevent duplicate emails, course codes, course registrations and payment references. CHECK constraints reject negative fees, non-positive capacity and non-positive payments. NOT NULL prevents required values from being omitted. These rules do not validate email deliverability or prevent every business error, such as overpayment.
