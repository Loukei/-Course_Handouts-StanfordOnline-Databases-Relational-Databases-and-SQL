/*
## Question
For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
*/


/*
## ANS

1. `SELECT DISTINCT`用來去除同一組reviewer評論不同電影的組合，
或是有某個Reviewer評論一部電影1次以上，都會造成同一個Reviewer組合出現多次

ex: (r1.rid,r2.rid,mid) = (203,205,103),(203,205,108)

2. `ON R1.mID = R2.mID AND R1.rID <> R2.rID AND R1.name < R2.name`

2.1. 使用`R1.rID <> R2.rID`確保Reviewer去除了(R1,R1)的組合
2.2. `R1.name < R2.name`用來確保(R1,R2)出現時，(R2,R1)不會出現
2.3. 綜合使用`rID`與`name`的原因是我們不能確定Reviewer是否會有同名的情況，所以不能用`name`完全代替`rID`
*/
WITH cte AS
(
	SELECT Rating.rID, Reviewer.name AS 'name', mID
	FROM Rating
	LEFT JOIN Reviewer USING(rID)
)
SELECT DISTINCT R1.name, R2.name
FROM cte AS R1
INNER JOIN cte R2
ON R1.mID = R2.mID AND R1.rID <> R2.rID AND R1.name < R2.name --- make sure Reviewer has no duplicate name
ORDER BY R1.name;