/*

Explaining Window Functions

Window functions are very useful for analysis.  Examples include rolling totals, moving averages and ranking per category.
A window function is a computation that returns a single value applied to a set of rows defined by a window specification.
Each column can independently calculate a window function.
Each row has its own window
Syntax: window_function(...) OVER (window specification)
We use a small table, PatientStay,  in these examples.
*/
 
SELECT
	ps.PatientId
	, ps.AdmittedDate
	, ps.Hospital
	, ps.Ward
	, ps.Ethnicity
	, ps.Tariff
FROM
	dbo.PatientStay ps;
/*

* Write a SQL query to show the number of patients admitted each day
The resultset should have two columns:
* AdmittedDate
*NumberOfPatients
It should be sorted by AdmittedDate (earliest first)
*/
 
/*
We will use the DATENAME function later so let's have a look at it now.
How many patients were admittted each month?
*/

SELECT
	DATENAME(MONTH, ps.AdmittedDate) AS AdmittedMonth
	, COUNT(*) AS [Number Of Patients]
FROM
	dbo.PatientStay ps
GROUP BY
	DATENAME(MONTH, ps.AdmittedDate);
 
/*

The most basic - and useless - example of a Window function
Note that there is an aggregation, COUNT(*), but no GROUP BY
COUNT(*) counts over a window defined by OVER() - the whole of the table since we have not yet partioned it
*/
 
SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Ward
	, ps.AdmittedDate
	, ps.Tariff
	, COUNT(*) OVER () AS TotalCount
    , SUM (ps.tariff) OVER () as totaltariff
	-- create a window over the whole table
FROM
	PatientStay ps
ORDER BY
	ps.PatientId;

/*










PARTITION divides one large window into several smaller windows
For each row, we create a window based on the rows with the same value of the PARTITION BY column(s) and aggregate over that window
We can PARTITION BY more than one column
*/

SELECT

	ps.PatientId
	, ps.Hospital
	, ps.Ward
	, ps.AdmittedDate
	, ps.Tariff
	, COUNT(*) OVER () AS TotalCount
	, COUNT(*) OVER (PARTITION BY ps.Hospital) AS HospitalCount -- create a window over those rows with the same hospital as the current row
	, COUNT(*) OVER (PARTITION BY ps.Ward) AS WardCount
	, COUNT(*) OVER (PARTITION BY ps.Hospital , ps.Ward) AS HospitalWardCount
FROM
	PatientStay ps
ORDER BY
	ps.PatientId;

 

 server name: zomalex-sql.database.windows.net

Trust server certificate: checked

authentication type: SQL Login

User name : student10

Password: solveSQL!  (You will need to type this in, if you copy/paste, this will result in an error when you try to connect)

Save password: checked

Database name: LearnSQL

Encrypt: Mandatory
 
 
SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    , ps.Tariff
    , '???' as CumulativeTariff
FROM
    PatientStay ps
ORDER BY ps.PatientId
 
Sorry, I have not completed the final stage
 
SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    , ps.Tariff
    , (SELECT SUM(subq.Tariff) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId) as CumulativeTariff
    , (SELECT COUNT(*) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId) As PatientIndex
FROM
    PatientStay ps
ORDER BY ps.Hospital, ps.PatientId
 
SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    , ps.Tariff
    , (SELECT SUM(subq.Tariff) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId AND subq.Hospital = ps.Hospital) as CumulativeTariff
    , (SELECT COUNT(*) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId AND subq.Hospital = ps.Hospital) As PatientIndex
FROM
    PatientStay ps
ORDER BY ps.Hospital, ps.PatientId
 
 
 
 
 
/*

Explaining Window Functions
 
Window functions are very useful for analysis.  Examples include rolling totals, moving averages and ranking per category.

A window function is a computation that returns a single value applied to a set of rows defined by a window specification.

Each column can independently calculate a window function.

Each row has its own window
 
Syntax: window_function(...) OVER (window specification)
 
We use a small table, PatientStay,  in these examples.

*/
 
SELECT

	ps.PatientId

	, ps.AdmittedDate

	, ps.Hospital

	, ps.Ward

	, ps.Ethnicity

	, ps.Tariff

FROM

	dbo.PatientStay ps;
 
/*

* Write a SQL query to show the number of patients admitted each day

The resultset should have two columns:

* AdmittedDate

*NumberOfPatients

It should be sorted by AdmittedDate (earliest first)

*/
 
 
/*

We will use the DATENAME function later so let's have a look at it now.

How many patients were admittted each month?

*/
 
SELECT

	DATENAME(MONTH, ps.AdmittedDate) AS AdmittedMonth

	, COUNT(*) AS [Number Of Patients]

FROM

	dbo.PatientStay ps

GROUP BY

	DATENAME(MONTH, ps.AdmittedDate);
 
/*

The most basic - and useless - example of a Window function

Note that there is an aggregation, COUNT(*), but no GROUP BY

COUNT(*) counts over a window defined by OVER() - the whole of the table since we have not yet partioned it

*/
 
SELECT

	ps.PatientId

	, ps.Hospital

	, ps.Ward

	, ps.AdmittedDate

	, ps.Tariff

	, COUNT(*) OVER () AS TotalCount

	-- create a window over the whole table

FROM

	PatientStay ps

ORDER BY

	ps.PatientId;
 
/*

PARTITION divides one large window into several smaller windows

For each row, we create a window based on the rows with the same value of the PARTITION BY column(s) and aggregate over that window
 
We can PARTITION BY more than one column

*/

SELECT

	ps.PatientId

	, ps.Hospital

	, ps.Ward

	, ps.AdmittedDate

	, ps.Tariff

	, COUNT(*) OVER () AS TotalCount

--	, COUNT(*) OVER (PARTITION BY ps.Hospital) AS HospitalCount -- create a window over those rows with the same hospital as the current row

--	, COUNT(*) OVER (PARTITION BY ps.Ward) AS WardCount

--	, COUNT(*) OVER (PARTITION BY ps.Hospital , ps.Ward) AS HospitalWardCount

FROM

	PatientStay ps

ORDER BY

	ps.PatientId;

 
SELECT
    ps.PatientId
    , ps.Hospital
    , ps.Ward
    , ps.AdmittedDate
    , ps.Tariff
    , COUNT(*) OVER () AS TotalCount
    ,SUM(ps.Tariff) OVER ()  AS TotalTariff
    -- create a window over the whole table
FROM
    PatientStay ps
ORDER BY
    ps.PatientId;
 
server name: zomalex-sql.database.windows.net

Trust server certificate: checked

authentication type: SQL Login

User name : student10

Password: solveSQL!  (You will need to type this in, if you copy/paste, this will result in an error when you try to connect)

Save password: checked

Database name: LearnSQL

Encrypt: Mandatory

 
We are still setting up people.  Restart at 11:00
 
/*
PARTITION divides one large window into several smaller windows
For each row, we create a window based on the rows with the same value of the PARTITION BY column(s) and aggregate over that window
 
We can PARTITION BY more than one column
*/
SELECT
    ps.PatientId
    , ps.Hospital
    , ps.Ward
    , ps.AdmittedDate
    , ps.Tariff
    , COUNT(*) OVER () AS TotalCount
--  , COUNT(*) OVER (PARTITION BY ps.Hospital) AS HospitalCount -- create a window over those rows with the same hospital as the current row
--  , COUNT(*) OVER (PARTITION BY ps.Ward) AS WardCount
--  , COUNT(*) OVER (PARTITION BY ps.Hospital , ps.Ward) AS HospitalWardCount
FROM
    PatientStay ps
ORDER BY
    ps.PatientId;
 
 
/*

Use case: percentage of all rows in result set and percentage of a group 

*/
 
SELECT
	ps.PatientId
	, ps.Tariff
	, ps.Ward
	, SUM(ps.Tariff) OVER () AS TotalTariff
	, SUM(ps.Tariff) OVER (PARTITION BY ps.Ward) AS WardTariff
	, 100.0 * ps.Tariff / SUM(ps.Tariff) OVER () AS PctOfAllTariff
	, 100.0 * ps.Tariff / SUM(ps.Tariff) OVER (PARTITION BY ps.Ward) AS PctOfWardTariff
FROM
	PatientStay ps
ORDER BY
	ps.Ward
	, ps.PatientId;

  
/*
ROW_NUMBER() is a special function used with Window functions to index rows in a window
It must have a ORDER BY since SQL must know  how to sort rows in each window
*/
SELECT
    ps.PatientId
    , ps.Hospital
    , ps.Ward
    , ps.AdmittedDate
    , ps.Tariff
    , ROW_NUMBER() OVER (ORDER BY ps.PatientId desc) AS PatientIndex
  , ROW_NUMBER() OVER (PARTITION BY ps.Hospital ORDER BY ps.PatientId) AS PatientByHospitalIndex
--  ,COUNT(*) OVER (PARTITION BY ps.Hospital order by ps.PatientId)  as PatientByHospitalIndexAlt -- An alternative way of indexing
FROM
    PatientStay ps
ORDER BY
    ps.Hospital
    ,ps.PatientId

 
/*
Compare ROW_NUMBER(), RANK() and DENSE_RANK() where there are ties
ROW_NUMBER() will always create a monotonically  increasing sequence 1,2,3,... and arbitrarily choose one tie row over another
RANK() will give all tie rows the same value and the rank of the next row will n higher if there are n tie rows e.g. 1,1,3,...
DENSE_RANK() will give all tie rows the same value and the rank of the next row will one higher e.g. 1,1,2,...
NTILE(10) splits into deciles
*/
 
SELECT
    ps.PatientId
    , ps.Tariff
    , ROW_NUMBER() OVER (ORDER BY ps.Tariff DESC) AS PatientRowIndex
  , RANK() OVER ( ORDER BY ps.Tariff DESC) AS PatientRank
  , DENSE_RANK() OVER (ORDER BY ps.Tariff DESC) AS PatientDenseRank
  , NTILE(10) OVER (ORDER BY ps.Tariff DESC) AS PatientIdDecile
FROM
    PatientStay ps
ORDER BY
    ps.Tariff DESC;
 
-- Use Window functions to calculate a cumulative value , or running total
SELECT
    ps.AdmittedDate
    , ps.Tariff
     , ROW_NUMBER() OVER (ORDER BY ps.AdmittedDate) AS RowIndex
     , SUM(ps.Tariff) OVER (ORDER BY ps.AdmittedDate) AS RunningTariff
    -- , ROW_NUMBER() OVER (PARTITION BY DATENAME(MONTH, ps.AdmittedDate) ORDER BY ps.AdmittedDate) AS MonthIndex
    -- , SUM(ps.Tariff) OVER (PARTITION BY DATENAME(MONTH, ps.AdmittedDate) ORDER BY ps.AdmittedDate) AS MonthToDateTariff
FROM
    PatientStay ps
WHERE
    ps.Hospital = 'Oxleas'
    AND ps.Ward = 'Dermatology'
ORDER BY
    ps.AdmittedDate;
 
 
 