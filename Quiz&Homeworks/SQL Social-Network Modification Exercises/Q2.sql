/*
## Question
If two students A and B are friends, 
and A likes B but not vice-versa, 
remove the Likes tuple.

##

--- A LIKE B BUT B NOT LIKE A
SELECT *
FROM Likes L1
WHERE NOT EXISTS(
	SELECT *
	FROM Likes L2
	WHERE L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1
);

SELECT L1.ID1, L1.ID2
FROM Likes L1
LEFT JOIN Likes L2
ON L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1
WHERE L2.ID1 IS NULL;

SELECT * FROM Likes 
EXCEPT 
SELECT L2.ID2 AS 'ID1', L2.ID1 AS 'ID2' FROM Likes L2;

[DELETE WITH INTERSECT](https://stackoverflow.com/questions/31014126/delete-with-intersect)

*/


/*
## ANS

*/
DELETE FROM Friend
WHERE EXISTS(
	SELECT *
	FROM Likes L1
	WHERE NOT EXISTS(
		SELECT *
		FROM Likes L2
		WHERE L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1
	) AND L1.ID1 = Friend.ID1 AND L1.ID2 = Friend.ID2
);

1641 Brittany		1468 Kris	
1689 Gabriel		1247 Alexis	
