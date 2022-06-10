/*
Some reviewers didn't provide a date with their rating. 
Find the names of all reviewers who have ratings with a NULL value for the date.
*/

/*
Ans 1:
*/
SELECT name
FROM Reviewer
WHERE rID IN (
	SELECT rID
	FROM Rating
	WHERE ratingDate IS NULL
);

/*
Ans 2:
*/
SELECT name
FROM Reviewer
	LEFT JOIN Rating
	ON Reviewer.rID = Rating.rID
WHERE ratingDate IS NULL;