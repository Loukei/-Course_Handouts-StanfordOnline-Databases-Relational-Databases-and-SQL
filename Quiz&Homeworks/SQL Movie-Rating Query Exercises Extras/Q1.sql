/*
## Question
Find the names of all reviewers who rated Gone with the Wind.
*/


/*
## ANS

*/

SELECT DISTINCT (
	SELECT name
	FROM Reviewer
	WHERE Reviewer.rID = Rating.rID
) AS 'name'
FROM Rating
WHERE mID = ( SELECT mID FROM Movie WHERE title = 'Gone with the Wind');

/*
## ANS

*/

WITH movie_cte AS (SELECT mID FROM Movie WHERE title = 'Gone with the Wind')
SELECT DISTINCT (
	SELECT name
	FROM Reviewer
	WHERE Reviewer.rID = Rating.rID
) AS 'name'
FROM Rating
WHERE Rating.mID IN movie_cte;