/*
## Question
Find the titles of all movies not reviewed by Chris Jackson.
*/


/*
## ANS

*/
SELECT title
FROM Movie
WHERE mID NOT IN (
	SELECT mID
	FROM Rating
	WHERE rID = (
		SELECT rID 
		FROM Reviewer R 
		WHERE name = "Chris Jackson"
	)
);
