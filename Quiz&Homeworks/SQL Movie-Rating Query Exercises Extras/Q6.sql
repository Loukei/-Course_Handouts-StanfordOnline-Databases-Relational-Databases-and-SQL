/*
## Question

For each rating that is the lowest (fewest stars) currently in the database, 
return the reviewer name, movie title, and number of stars.
*/


/*
## ANS 1

*/
SELECT (SELECT name FROM Reviewer WHERE R1.rID = Reviewer.rID) AS 'ReviewerName', (SELECT title FROM Movie WHERE R1.mID = Movie.mID ) AS 'MovieTitle', R1.stars
FROM Rating R1
WHERE stars = (
	SELECT MIN(stars) FROM Rating
);

/*
## ANS 2

*/

SELECT R.name AS 'ReviewerName', M.title AS 'MovieTitle', stars
FROM Rating
LEFT JOIN Reviewer R USING(rID)
LEFT JOIN Movie M USING(mID)
WHERE stars = (
	SELECT MIN(stars) FROM Rating
);