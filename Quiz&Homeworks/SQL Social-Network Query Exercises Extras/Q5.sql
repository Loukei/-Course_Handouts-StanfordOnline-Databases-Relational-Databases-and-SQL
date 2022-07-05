/*
## Question

Find the name and grade of the student(s) with the greatest number of friends.
*/


/*
## ANS

*/
WITH cte AS
(
	SELECT ID1, count(ID2) as 'count_n'
	FROM Friend
	GROUP BY ID1
)
SELECT H.name, H.grade
FROM cte
INNER JOIN Highschooler H
ON H.ID = cte.ID1
WHERE count_n = ( SELECT max(count_n) FROM cte);