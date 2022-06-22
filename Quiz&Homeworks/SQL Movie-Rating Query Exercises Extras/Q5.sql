/*
## Question
For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
*/

/*
--- must order by name, not by rid
SELECT DISTINCT R1.rID, R2.rID
FROM Rating AS R1
INNER JOIN Rating AS R2
ON R1.mID = R2.mID AND R1.rID <> R2.rID;
*/

/*
## ANS

*/