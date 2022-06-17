/*
## QUESTION
For all movies that have an average rating of 4 stars or higher, add 25 to the release year. 
(Update the existing tuples; don't insert new tuples.)

--- get the avg(stars) for each movie
SELECT mID, AVG(stars)
FROM Rating
GROUP BY mID;
*/

/*
ANS
*/

UPDATE Movie
SET year = year + 25
WHERE mID IN (
	SELECT mID
	FROM Rating
	GROUP BY mID
	HAVING AVG(stars) >= 4.0
);