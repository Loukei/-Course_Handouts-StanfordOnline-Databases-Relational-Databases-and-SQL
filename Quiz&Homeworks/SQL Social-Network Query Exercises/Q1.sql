/*
## QUESTION
Find the names of all students who are friends with someone named Gabriel.
*/

/* find student name Gabriel */
-- SELECT ID,name
-- FROM Highschooler
-- WHERE name = 'Gabriel';

/* 
find student Friend name Gabriel
- By definition, (A,B) = (B,A)， we can just select ID1
*/
-- SELECT ID2
-- FROM Friend
-- WHERE ID1 IN (
-- 	SELECT ID
-- 	FROM Highschooler
-- 	WHERE name = 'Gabriel'
-- );

/* find all student who's friend name is 'Gabriel' */
SELECT name
FROM Highschooler
WHERE ID IN (
	SELECT ID2
	FROM Friend
	WHERE ID1 IN (
		SELECT ID
		FROM Highschooler
		WHERE name = 'Gabriel'
	)
)
