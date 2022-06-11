/*
For all cases where the same reviewer rated the same movie twice 
and gave it a higher rating the second time, 
return the reviewer's name and the title of the movie.
*/

/*
Ans 1:
*/


/*
TEST SCRIPT
*/

/*
問題:
1. 題目明確說要該評論家對同一電影評論2次，所以如果評論3次以上可能就不行
2. 必須要比較第一次跟第二次的評論分數，換句話說不能用MAX(starts)，因為該函數不會分辨是先高後低還是先低後高
3. 評論的先後次序如何分辨? 因為ratingDate欄位有部分是空值，所以該欄位不可靠
```
*/

--- this one select the row duplicate twice, but don't get sec.stars > fst.stars
SELECT rID, mID, max(stars)
FROM Rating
GROUP BY rID, mID
HAVING count(*) = 2;

--- this one can't make sure riverwer only rating twice
SELECT A.rID, A.mID, A.stars
FROM Rating A
INNER JOIN Rating B
ON A.rID = B.rID AND A.mID = B.mID AND A.stars <> B.stars;

--- error code
SELECT T.rID, T.mID, Movie.title, Reviewer.name
FROM (
	SELECT rID, mID, max(stars)
	FROM Rating
	GROUP BY rID, mID
	HAVING count(*) = 2
) AS T 
	INNER JOIN Movie
	ON T.mID = Movie.mID
	INNER JOIN Reviewer
	ON T.rID = Reviewer.rID;

/* 
result
``` csv
201	101	Gone with the Wind	Sarah Martinez
203	108	Raiders of the Lost Ark	Brittany Harris
```
expected
```
Sarah Martinez	Gone with the Wind
```
*/

