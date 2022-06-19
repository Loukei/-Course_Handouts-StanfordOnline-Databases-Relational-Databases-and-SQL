/*
## Question

For all cases where A is friends with B, 
and B is friends with C, 
add a new friendship for the pair A and C.

Do not add duplicate friendships, 
friendships that already exist, or friendships with oneself. 
(This one is a bit challenging; congratulations if you get it right.)
*/


/*
## ANS

--- find c for (a,b) and (b,c)
SELECT F1.ID1 AS 'A', F1.ID2 AS 'B', F2.ID2 AS 'C'
FROM Friend F1, Friend F2
ON F1.ID2 = F2.ID1 AND F1.ID1 <> F2.ID2;

-- remove those friend relations which is already exist
SELECT F1.ID1 AS 'ID1', F2.ID2 AS 'ID2'
FROM Friend F1, Friend F2
ON F1.ID2 = F2.ID1 AND F1.ID1 <> F2.ID2
EXCEPT
SELECT * FROM Friend
*/

INSERT INTO Friend (ID1,ID2)
SELECT F1.ID1 AS 'ID1', F2.ID2 AS 'ID2'
FROM Friend F1, Friend F2
ON F1.ID2 = F2.ID1 AND F1.ID1 <> F2.ID2
EXCEPT
SELECT * FROM Friend;
