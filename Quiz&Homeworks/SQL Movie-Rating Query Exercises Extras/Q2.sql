/*
## Question
For any rating where the reviewer is the same as the director of the movie, 
return the reviewer name, movie title, and number of stars.
*/


/*
## ANS

*/
SELECT Movie.director, Movie.title, Rating.stars
FROM Movie
INNER JOIN Reviewer
ON Movie.director = Reviewer.name
INNER JOIN Rating
ON Rating.rID = Reviewer.rID AND Rating.mID = Movie.mID;