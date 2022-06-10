/*
Find the titles of all movies that have no ratings.
*/


/*
Ans1: Find all mid in rating, then find movie not in those mid
*/
SELECT title
FROM Movie
WHERE mID NOT IN (
	SELECT DISTINCT mID
	FROM Rating
);

/*
Ans2: Left Join with mID = rID, then keep the rows with rID is NULL
*/
SELECT title
FROM Movie
	LEFT JOIN Rating
	ON Movie.mID = Rating.mID
WHERE Rating.rID IS NULL;