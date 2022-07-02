/*
## Question

Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.

*/


/*
## ANS 1

--- 用JOIN找出所有人的名字跟成績
SELECT F.ID1, H1.name, H1.grade, F.ID2, H2.name, H2.grade
FROM Friend F
LEFT JOIN Highschooler H1 ON F.ID1 = H1.ID
LEFT JOIN Highschooler H2 ON F.ID2 = H2.ID;

--- 在sub query查出每個人的名子跟成績，但是要過濾同grade的話要再多套一層才能
SELECT F.ID1,
	(SELECT name FROM Highschooler WHERE ID = F.ID1) AS 'name1',
	(SELECT grade FROM Highschooler WHERE ID = F.ID1) AS 'grade1', 
	F.ID2, 
	(SELECT name FROM Highschooler WHERE ID = F.ID2) AS 'name2', 
	(SELECT grade FROM Highschooler WHERE ID = F.ID2) AS 'grade2'
FROM Friend F;

--- 直接在where階段就找出所有"有相同成績的人"
SELECT *
FROM Friend
WHERE (SELECT grade FROM Highschooler WHERE ID = ID1) = (SELECT grade FROM Highschooler WHERE ID = ID2);

*/
WITH cte AS
(
--- join students name and grade
	SELECT H1.name AS 'name1', H1.grade AS 'grade1', H2.grade AS 'grade2'
	FROM Friend F
	LEFT JOIN Highschooler H1 ON F.ID1 = H1.ID
	LEFT JOIN Highschooler H2 ON F.ID2 = H2.ID
)
--- all students in firend relation
SELECT cte.name1, cte.grade1
FROM cte
EXCEPT
--- student have same grade firend
SELECT cte.name1, cte.grade1
FROM cte
WHERE grade1 = grade2;