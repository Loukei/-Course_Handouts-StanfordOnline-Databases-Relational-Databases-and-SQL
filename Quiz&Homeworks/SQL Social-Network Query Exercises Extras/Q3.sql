/*
## Question

What is the average number of friends per student? 
(Your result should be just one number.)

*/


/*
## ANS


*/
SELECT AVG(score)
FROM (
	SELECT ID1, count(*) AS 'score'
	FROM Friend
	GROUP BY ID1
);

/*
## ANS

*/