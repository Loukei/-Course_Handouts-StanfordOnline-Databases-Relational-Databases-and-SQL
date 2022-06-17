/*
## QUESTION
Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. 
Sort by grade, then by name within each grade.
*/

/*
ANS 1
*/
SELECT H.name, H.grade
FROM Highschooler H
WHERE H.ID NOT IN ( SELECT ID1 AS 'ID' FROM Likes UNION SELECT ID2 AS 'ID' FROM Likes )
ORDER BY H.grade; 

/*
ANS 2
*/
SELECT H.name, H.grade
FROM Highschooler H
LEFT JOIN (
	SELECT ID1 AS ID FROM Likes
	UNION
	SELECT ID2 AS ID FROM Likes
) AS T USING(ID)
WHERE T.ID IS NULL
ORDER BY H.grade; 