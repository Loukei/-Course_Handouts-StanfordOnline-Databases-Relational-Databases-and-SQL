/*
## Question

For each director, 
return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, 
and the value of that rating. Ignore movies whose director is NULL.

*/


/*
## ANS

1. 先找出所有電影的最高評分`RM`

``` SQL
SELECT mID, MAX(STARS)
FROM Rating
GROUP BY mID;
```

2. 合併`movie`與剛剛求出的`RM`，得出每部電影的最高分數與導演

``` SQL
SELECT *
FROM Movie M
LEFT JOIN (
	SELECT mID, MAX(stars) AS 'm_stars'
	FROM Rating
	GROUP BY mID
) AS RM USING(mID)
ORDER BY M.director;
```

3. 用`GROUP BY`依照導演分組，並用`HAVING MAX(RM.m_stars)`在分組後取出導演的最高作品

4. 用`WHERE M.director IS NOT NULL`過濾導演為NULL

*/
SELECT M.director, M.title, RM.m_stars
FROM Movie M
LEFT JOIN (
	SELECT mID, MAX(stars) AS 'm_stars'
	FROM Rating
	GROUP BY mID
) AS RM USING(mID)
WHERE M.director IS NOT NULL
GROUP BY M.director
HAVING MAX(RM.m_stars);