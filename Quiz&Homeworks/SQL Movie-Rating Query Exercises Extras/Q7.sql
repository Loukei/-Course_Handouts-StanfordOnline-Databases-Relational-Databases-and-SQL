/*
## Question

List movie titles and average ratings, from highest-rated to lowest-rated. 
If two or more movies have the same average rating, list them in alphabetical order.
*/


/*
## ANS

*/

SELECT Movie.title, AVG_rate
FROM (
    --- calculate AVG(stars) for each movie
	SELECT mID, AVG(stars) AS 'AVG_rate'
	FROM Rating
	GROUP BY mID
) LEFT JOIN Movie USING(mID)
ORDER BY AVG_rate DESC, Movie.title ASC;
