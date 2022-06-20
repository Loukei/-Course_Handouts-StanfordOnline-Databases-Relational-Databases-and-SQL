/*
## Question
Return all reviewer names and movie names together in a single list, alphabetized. 
(Sorting by the first name of the reviewer and first word in the title is fine; 
no need for special processing on last names or removing "The".)
*/


/*
## ANS
- `UNION`本身具有排序功能，因此不用另外做`ORDER BY`的排序工作
*/
SELECT DISTINCT name
FROM Reviewer
UNION
SELECT DISTINCT title AS 'name'
FROM Movie;