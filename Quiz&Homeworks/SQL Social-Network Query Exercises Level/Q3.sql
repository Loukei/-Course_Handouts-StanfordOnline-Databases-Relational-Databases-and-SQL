/*
## QUESTION
For every pair of students who both like each other, return the name and grade of both students. 
Include each pair only once, with the two names in alphabetical order.
*/

/*
Students likes each other
*/
-- SELECT L1.ID1, L1.ID2
-- FROM Likes L1
-- INNER JOIN Likes L2
-- ON L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1; 

/*
USE the sudents like each other, get the name and grade

問題
1: 要求不能重複，即a,b = b,a
2: 最後的結果是依照姓名排序而非id，也就是說在排序之前不能事先刪除重複的，否則會導致排序出錯
*/
SELECT H1.ID, H1.name, H1.grade, H2.ID, H2.name, H2.grade
FROM (
	SELECT L1.ID1, L1.ID2
	FROM Likes L1
	INNER JOIN Likes L2
	ON L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1
) AS L3
INNER JOIN Highschooler H1
ON H1.ID = L3.ID1
INNER JOIN Highschooler H2
ON H2.ID = L3.ID2
ORDER BY H1.name;