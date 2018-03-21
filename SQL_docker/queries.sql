/*
Implementing queries from
Introduction to SQL for Data Scientists
*/

-- Look at the tables and data shown in Section 1.2

/*
Question 0: Paste the query below into the psql interactive
shell to run it.
It should give the results of the first query
in Section 2 of the paper.
*/

SELECT
    s.id AS id,
    s.name AS name
FROM
    student AS s
WHERE
    s.id = 1;


/*
Question 1: Write a query that will return the
students whose first name starts with an H.
*/

SELECT *
FROM students
WHERE LEFT(name,1) = 'H';








-- Back to lecture

/*
Question 2: Write a query that returns what terms degrees were
awarded.
*/

SELECT DISTINCT term
FROM degrees;

/*
Question 3: Write a query that counts the number of times a term
g.p.a. was above 3.
*/


 select count(*) from term_gpa where gpa > 3

-- Back to lecture

/*
Question 4: Paste this query that uses a join to
duplicate the second set of results in Section 2 of the paper.
*/

SELECT
    s.id AS id,
    s.name AS name,
    t.term
    t.gpa AS gpa
FROM student AS s
  JOIN term_gpa AS t
    ON s.id = t.id;

/*
Question 5: Write a query that will find and display Edith Warton's
and Henry James's gpas for 2011 and 2012.
*/


SELECT
    s.id AS id,
    s.name AS name,
    t.term,
    t.gpa AS gpa
FROM student AS s
  JOIN term_gpa AS t
    ON s.id = t.id
WHERE s.name IN ('Edith Warton', 'Henry James')
  AND t.term in (2011, 2012);










/* Question 6: Write a query that will find Edith Warton's and Henry
James's highest gpas rounded to two decimal places.  Order them by
whoever has the highest gpa.
*/


SELECT
    s.id AS id,
    s.name AS name,
    MAX(t.gpa) AS gpa
FROM student AS s
  JOIN term_gpa AS t
    ON s.id = t.id
      AND s.name IN ('Edith Warton', 'Henry James')
GROUP BY s.id,s.name
ORDER BY MAX(t.gpa) DESC;

-- Back to lecture


/*
Question 7.  In one table list all the students, the term they were
enrolled, their gpa for that term, and the degree they received
(if they received one).  Consider using a left join here.
*/

SELECT s.id
  ,s.name
  ,t.term as first_term
  ,t.gpa as first_gpa
  ,d.degree
FROM student s
  JOIN (SELECT *, ROW_NUMBER() OVER (PARTITION BY id order by term) AS RK FROM term_gpa) t
    ON s.id = t.id
      and t.RK = 1
  LEFT JOIN degrees d
    ON s.id = d.id;

/*
Query 8: Find the students who have graduated (they have their
degree). Consider using GROUP BY.
*/

SELECT s.name
FROM student s
  INNER JOIN degrees d
    ON s.id = d.id
GROUP BY s.name;

/*
Query 9:  Find the students who haven't graduated and their average
gpa, rounded to two decimal places. You may want to use a subquery.
*/

SELECT s.name
  ,ROUND(AVG(g.gpa),1) AS avg_gpa
FROM student s
  INNER JOIN term_gpa g
    on s.id = g.id
  LEFT JOIN degrees d
    ON s.id = d.id
WHERE d.id IS NULL
GROUP BY s.name;

-- Finished!
