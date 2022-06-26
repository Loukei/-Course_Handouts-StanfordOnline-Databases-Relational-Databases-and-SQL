/*
## Question

Find the names of all reviewers who have contributed three or more ratings. 
(As an extra challenge, try writing the query without HAVING or without COUNT.)
*/


/*
## ANS

計算每個rid出現的次數，直接用`sum(rid)/rid >= 3`
*/
SELECT (
	SELECT name
	FROM Reviewer 
	WHERE Reviewer.rID = T.rID
) AS 'name'
FROM (
    --- get rid and sum(rid)
	SELECT rID, SUM(rID) AS 'sr'
	FROM Rating
	GROUP BY rID
) AS T
WHERE T.sr > 2*rID;