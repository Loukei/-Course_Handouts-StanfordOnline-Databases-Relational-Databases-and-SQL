/*
## QUESTION

For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). 
For all such trios, return the name and grade of A, B, and C.
*/

/*
ANS 1

--- A LIKE B, BUT A AND B NOT FRIEND
SELECT *
FROM Likes
EXCEPT
SELECT *
FROM Friend;

--- FIND PERSON C THAT IS FRIEND OF A AND B
SELECT F1.ID1 AS 'A', F1.ID2 AS 'C', F2.ID1 AS 'B'
FROM Friend F1
INNER JOIN Friend F2
ON F1.ID2 = F2.ID2 AND F1.ID1 != F2.ID1;

*/

SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM (
	SELECT F1.ID1 AS 'A', F1.ID2 AS 'C', F2.ID1 AS 'B'
	FROM Friend F1
	INNER JOIN Friend F2
	ON F1.ID2 = F2.ID2 AND F1.ID1 != F2.ID1
	WHERE EXISTS (
		SELECT ID1,ID2
        --- A LIKE B BUT NOT FRIENDS
		FROM ( SELECT * FROM Likes EXCEPT SELECT * FROM Friend ) AS T 
		WHERE F1.ID1 = T.ID1 AND F2.ID1 = T.ID2
	)
    --- ((A LIKE B) BUT (A AND B NOT FRIENDS)) AND EXIST C WHICH IS FRIEND OF A AND FRIEND OF B
) AS TT
INNER JOIN Highschooler H1 ON TT.A = H1.ID
INNER JOIN Highschooler H2 ON TT.B = H2.ID
INNER JOIN Highschooler H3 ON TT.C = H3.ID;
