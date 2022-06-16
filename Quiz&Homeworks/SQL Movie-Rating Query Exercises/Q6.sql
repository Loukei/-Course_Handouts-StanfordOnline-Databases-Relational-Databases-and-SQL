/*
For all cases where the same reviewer rated the same movie twice 
and gave it a higher rating the second time, 
return the reviewer's name and the title of the movie.
*/

/*
Ans 1:
這個解法只能確保**存在一個後面評論比前面更好**的情況
換句話說: 如果對方評論了3次以上(2,3,1)，按照題義應該錯誤
*/
SELECT name,title
FROM (
	SELECT R1.rID,R1.mID
	FROM Rating R1
	WHERE R1.stars > (
		SELECT stars
		FROM Rating R2
		WHERE R2.rID = R1.rID AND R2.mID = R1.mID AND R2.ratingDate < R1.ratingDate
	)
) AS T
INNER JOIN Reviewer USING(rID)
INNER JOIN Movie USING(mID);

/*
Thinking

問題:
1. 題目明確說要該評論家對同一電影評論2次，所以如果評論3次以上可能就不行
2. 必須要比較第一次跟第二次的評論分數，換句話說不能用MAX(starts)，因為該函數不會分辨是先高後低還是先低後高
3. 評論的先後次序如何分辨? 因為ratingDate欄位有部分是空值，所以該欄位不可靠
*/

/*
this one select the row duplicate twice, but don't get sec.stars > fst.stars
*/
-- SELECT rID, mID, max(stars)
-- FROM Rating
-- GROUP BY rID, mID
-- HAVING count(*) = 2;
