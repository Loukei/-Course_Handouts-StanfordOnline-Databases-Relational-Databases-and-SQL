/*
## QUESTION

Find names and grades of students who only have friends in the same grade. 
Return the result sorted by grade, then by name within each grade.

Jordan	9
Brittany	10
Haley	10
Kris	10
Gabriel	11
John	12
Logan	12
*/

/*
問題: 如何確保學生只有同一年級的朋友?
- 找出年級不同的朋友的學生，做出集合，EX: FRIEND{(9,10),(9,7)} -> FRIEND{7,9,10}
*/

--- 找出那些跟不同年級做朋友的人，收集他們的ID
--- FRIEND表會有重複，所以事實上我們只需要ID1
-- SELECT F.ID1 --- H1.grade, F.ID2, H2.grade
-- FROM Friend F
-- INNER JOIN Highschooler H1 ON H1.ID = F.ID1
-- INNER JOIN Highschooler H2 ON H2.ID = F.ID2
-- WHERE H1.grade <> H2.grade;

--- 從`FRIEND`去除"有跟不同年級做朋友的"，即為"只跟同年級做朋友的"
-- SELECT ID1 FROM Friend
-- EXCEPT
-- SELECT ID1 FROM Friend F
-- INNER JOIN Highschooler H1 ON H1.ID = F.ID1
-- INNER JOIN Highschooler H2 ON H2.ID = F.ID2
-- WHERE H1.grade <> H2.grade;

/*
ANS 1
*/

SELECT H3.name, H3.grade
FROM (
	SELECT ID1 FROM Friend
	EXCEPT
	SELECT ID1 FROM Friend F
	INNER JOIN Highschooler H1 ON H1.ID = F.ID1
	INNER JOIN Highschooler H2 ON H2.ID = F.ID2
	WHERE H1.grade <> H2.grade
) AS FT
INNER JOIN Highschooler H3 ON FT.ID1 = H3.ID
ORDER BY H3.grade, H3.name;
