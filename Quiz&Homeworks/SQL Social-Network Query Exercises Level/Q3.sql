/*
## QUESTION
For every pair of students who both like each other, return the name and grade of both students. 
Include each pair only once, with the two names in alphabetical order.
*/

/*
Students likes each other

result
id1		id2
1689	1709
1709	1689
1501	1934
1934	1501
*/
-- SELECT L1.ID1, L1.ID2
-- FROM Likes L1
-- INNER JOIN Likes L2
-- ON L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1; 

/*
USE the sudents like each other, get the name and grade

- 前一階段可以拿到的是重覆的ID，即{(a,b),(b,a),(c,d),(d,c)}這種
- 為了刪除重複的值，依照題目要求必須以姓名排序，因此使用where子句過濾
- 為了保留(a,b)並除掉(b,a)的選項，一個簡單的做法是依照name1 < name2
*/
SELECT H1.name AS 'Name_1', H1.grade, H2.name AS 'Name_2', H2.grade
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
WHERE H1.name < H2.name; ---trick