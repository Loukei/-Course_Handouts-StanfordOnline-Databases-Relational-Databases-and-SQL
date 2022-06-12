/*
For each movie, return the title and the 'rating spread', 
that is, the difference between highest and lowest ratings given to that movie. 
Sort by rating spread from highest to lowest, then by movie title.
*/

/*
Ans 1:
1. 先找出"所有電影的評分與級距(rating_spread)"命名為T
2. 將T與電影名稱關聯，並排序
*/
SELECT /*Movie.mID,*/Movie.title, T.rating_spread
FROM Movie 
INNER JOIN (
	SELECT mID, max(stars) - min(stars) AS rating_spread
	FROM Rating
	GROUP BY mID
) AS T 
ON Movie.mID = T.mID
ORDER BY rating_spread DESC, Movie.title;
