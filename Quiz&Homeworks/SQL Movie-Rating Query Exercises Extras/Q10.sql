/*
## Question

Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)

*/


/*
## ANS

- 先計算出每部電影的平均`cte`
- 透過`inner join`找出對應的電影名稱

MAX(cte.AVG_STARS)這行能直接使用來選出最大的列比較讓我驚訝，其他的還好，不然就只能用`where`過濾
*/
WITH cte AS 
(
	SELECT mID, AVG(stars) AS 'AVG_STARS'
	FROM Rating
	GROUP BY mID
)
SELECT title, MAX(cte.AVG_STARS)
FROM cte
INNER JOIN Movie USING(mID);