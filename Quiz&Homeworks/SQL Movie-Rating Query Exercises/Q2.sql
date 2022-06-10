/*
	Find all years that have a movie that received a rating of 4 or 5, 
	and sort them in increasing order.
*/

/* ANS1: Use JOIN */
SELECT DISTINCT Movie.year
FROM Movie
	LEFT JOIN Rating
	ON Movie.mID = Rating.mID
WHERE Rating.stars IN (4,5)
ORDER BY Movie.year;

/* Ans 2: Collect mid with stars(4,5) first  */
SELECT year
FROM Movie
WHERE mID IN (
	SELECT mID
	FROM Rating
	WHERE stars IN (4,5)
)
ORDER BY year;