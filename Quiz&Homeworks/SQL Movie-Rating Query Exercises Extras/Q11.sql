/*
## Question

Find the movie(s) with the lowest average rating. 
Return the movie title(s) and average rating. 
(Hint: This query may be more difficult to write in SQLite than other systems; 
you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)
*/


/*
## ANS

- 內層先計算每部電影的平均分數(cte)
- 外層透過`where`找出最小平均分數的電影
    - `WHERE avg_s = (SELECT DISTINCT MIN(avg_s) FROM cte)`
- 利用`INNER JOIN Movie`找出對應的電影名
*/
WITH cte AS
(
	SELECT mID, AVG(stars) AS 'avg_s'
	FROM Rating R
	GROUP BY mID
)
SELECT Movie.title, cte.avg_s
FROM cte
INNER JOIN Movie USING(mID)
WHERE avg_s = (SELECT DISTINCT MIN(avg_s) FROM cte);