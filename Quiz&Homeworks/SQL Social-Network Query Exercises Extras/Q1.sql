/*
## Question
For every situation where student A likes student B, 
but student B likes a different student C, 
return the names and grades of A, B, and C.
*/


/*
## ANS

*/
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM (
	SELECT L1.ID1 AS 'A', L1.ID2 AS 'B', L2.ID2 AS 'C'
	FROM Likes L1
	INNER JOIN Likes L2
	ON L1.ID2 = L2.ID1 AND L1.ID1 != L2.ID2
) AS T
INNER JOIN Highschooler H1 ON T.A = H1.ID
INNER JOIN Highschooler H2 ON T.B = H2.ID
INNER JOIN Highschooler H3 ON T.C = H3.ID;