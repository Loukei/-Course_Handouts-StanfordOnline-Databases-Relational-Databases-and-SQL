/*
## Question

Some directors directed more than one movie. 
For all such directors, return the titles of all movies directed by them, 
along with the director name. 
Sort by director name, then movie title. 
(As an extra challenge, try writing the query both with and without COUNT.)

*/


/*
## ANS

內層尋找曾經拍過1部以上的導演名單，外層做過濾

*/
SELECT title, director
FROM Movie
WHERE director IN (
	SELECT director
	FROM Movie
	GROUP BY director
	HAVING count(director) > 1
)
ORDER BY director, title;

/*
## ANS

1. `SELF JOIN` on `E1.director = E2.director AND E1.mID <> E2.mID`
2. EXIST `E1.director = E2.director AND E1.mID <> E2.mID`
3. (?)利用集合運算刪除只出現過一次的
*/