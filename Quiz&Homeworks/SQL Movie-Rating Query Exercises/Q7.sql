/*
For each movie that has at least one rating, find the highest number of stars that movie received. 
Return the movie title and number of stars. Sort by movie title.
*/

/*
Ans 1:
1. 先在`Rating`表篩選每部電影被評價的最高分數表格T，T的mid為Movie的子集
2. 利用`left join`找出對應的電影名稱，再依照電影名稱排序
*/

SELECT Movie.title, T.MAX_STARS
FROM ( 
	SELECT rID,mID,max(stars) AS MAX_STARS
	FROM Rating
	GROUP BY mID
	) AS T
	LEFT JOIN Movie ON Movie.mID = T.mID
ORDER BY Movie.title;

/*
Ans 2:

*/
