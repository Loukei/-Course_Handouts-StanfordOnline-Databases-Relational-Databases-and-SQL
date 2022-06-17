/*
## QUESTION
For every situation where student A likes student B, 
but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), 
return A and B's names and grades.
*/

/*
ANS 1

*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM (
	SELECT *
	FROM Likes
	WHERE ID2 IN (
		SELECT ID2 FROM Likes
		EXCEPT
		SELECT ID1 FROM Likes
	)
) AS T
INNER JOIN Highschooler H1 ON T.ID1 = H1.ID
INNER JOIN Highschooler H2 ON T.ID2 = H2.ID;