/*
Find the difference between the average rating of movies released before 1980 and 
the average rating of movies released after 1980. 
(Make sure to calculate the average rating for each movie, 
then the average of those averages for movies before 1980 and movies after. 
Don't just calculate the overall average rating before and after 1980.)
*/

/*
Ans 1:
*/


/*
問題:
如何將"計算完的電影平均分數表"重複用在計算_1980前的平均分數_與_1980後的平均分數_

Expected Query Result:
0.0555555555555558

*/

--- 計算每部電影的平均分數
SELECT mID, sum(stars), count(mID), avg(stars)
FROM Rating
GROUP BY mID;

--- 加入每部電影的年份並排序
SELECT mID, AVG_stars, year
FROM (
	SELECT mID, avg(stars) AS AVG_stars
	FROM Rating
	GROUP BY mID
) LEFT JOIN Movie USING(mID)
ORDER BY year;

---可以用group by分割，但是會有兩列
SELECT min(year), avg(AVG_stars), count(year)
FROM (
	SELECT mID, avg(stars) AS AVG_stars
	FROM Rating
	GROUP BY mID
)LEFT JOIN Movie USING(mID)
GROUP BY year < 1980;
