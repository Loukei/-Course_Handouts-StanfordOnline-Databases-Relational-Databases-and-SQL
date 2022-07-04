/*
## Question

Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.
*/


/*
## ANS

--- Friend WITH Cassandra
SELECT *
FROM Friend
WHERE ID1 = (SELECT id FROM Highschooler WHERE name = "Cassandra");

*/
SELECT count(DISTINCT B) + count(DISTINCT C)
FROM (
    --- B is friend of "Cassandra", C is firemd of friend of "Cassandra"
	SELECT F1.ID1 AS 'C_ID1', F1.ID2 AS 'B', F2.ID2 AS 'C'
	FROM Friend F1
	LEFT JOIN Friend F2 ON F1.ID2 = F2.ID1
	WHERE
        --- ID1 is "Cassandra"
        F1.ID1 = (SELECT ID FROM Highschooler WHERE name = "Cassandra") 
		AND 
        --- friend of firend can't be "Cassandra"
		F2.ID2 != (SELECT ID FROM Highschooler WHERE name = "Cassandra")
);
