/*
## QUESTION

Find the name and grade of all students who are liked by more than one other student.

--- students who are liked by more than one other student
SELECT ID2, count(ID2)
FROM Likes
GROUP BY ID2
HAVING count(ID2) > 1;

*/

/*
ANS 1
*/
SELECT H.name, H.grade
FROM (
	SELECT ID2
	FROM Likes
	GROUP BY ID2
	HAVING count(ID2) > 1
) AS T
INNER JOIN Highschooler H
ON H.ID = T.ID2;