/*
Write a query to return the ratings data in a more readable format: 
reviewer name, movie title, stars, and ratingDate. 
Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
*/

/*
Ans 1:
*/

SELECT Reviewer.name, Movie.title, Rating.stars, Rating.ratingDate 
FROM Rating, Movie, Reviewer
WHERE Rating.rID = Reviewer.rID AND Rating.mID = Movie.mID
ORDER BY Reviewer.name, Movie.title, Rating.stars;

/*
Ans 2:
*/
SELECT Reviewer.name,Movie.title,Rating.stars,Rating.ratingDate 
FROM Rating
	INNER JOIN Movie
	ON Rating.mID = Movie.mID
	INNER JOIN Reviewer
	ON Reviewer.rID = Rating.rID
ORDER BY Reviewer.name, Movie.title, Rating.stars;