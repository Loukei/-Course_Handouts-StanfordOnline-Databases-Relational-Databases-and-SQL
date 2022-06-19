# SQL Movie-Rating Query Exercises

You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema:

Movie ( mID, title, year, director )
English: There is a movie with ID number mID, a title, a release year, and a director.

Reviewer ( rID, name )
English: The reviewer with ID number rID has a certain name.

Rating ( rID, mID, stars, ratingDate )
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.

Your queries will run over a small data set conforming to the [schema](rating.sql). View the database. (You can also download the schema and data.)

**Instructions**: Each problem asks you to write a query in SQL. To run your query against our back-end sample database using SQLite, click the "Submit" button. You will see a display of your query result and the expected result. If the results match, your query will be marked "correct". You may run as many queries as you like for each question.

---

## Q1

Find the titles of all movies directed by Steven Spielberg.

Note: Your queries are executed using SQLite, so you must conform to the SQL constructs supported by SQLite.

### EXPECTED RESULT

```
E.T.
Raiders of the Lost Ark
```

---

## Q2

Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

### EXPECTED RESULT

```
1937
1939
1981
2009
```

---

## Q3

Find the titles of all movies that have no ratings.

### EXPECTED RESULT

```
Star Wars
Titanic
```

---

## Q4

Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

### EXPECTED RESULT

```
Daniel Lewis
Chris Jackson
```

---

## Q5

Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

### EXPECTED RESULT

```
Ashley White	E.T.	3	2011-01-02
Brittany Harris	Raiders of the Lost Ark	2	2011-01-30
Brittany Harris	Raiders of the Lost Ark	4	2011-01-12
Brittany Harris	The Sound of Music	2	2011-01-20
Chris Jackson	E.T.	2	2011-01-22
Chris Jackson	Raiders of the Lost Ark	4	
Chris Jackson	The Sound of Music	3	2011-01-27
Daniel Lewis	Snow White	4	
Elizabeth Thomas	Avatar	3	2011-01-15
Elizabeth Thomas	Snow White	5	2011-01-19
James Cameron	Avatar	5	2011-01-20
Mike Anderson	Gone with the Wind	3	2011-01-09
Sarah Martinez	Gone with the Wind	2	2011-01-22
Sarah Martinez	Gone with the Wind	4	2011-01-27
```

---

## Q6

For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

### EXPECTED RESULT


```
Sarah Martinez	Gone with the Wind
```

---

## Q7

For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.

### EXPECTED RESULT

```
Avatar	5
E.T.	3
Gone with the Wind	4
Raiders of the Lost Ark	4
Snow White	5
The Sound of Music	3
```

---

## Q8

For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.

### EXPECTED RESULT

```
Avatar	2
Gone with the Wind	2
Raiders of the Lost Ark	2
E.T.	1
Snow White	1
The Sound of Music	1
```

---

## Q9

Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)

### EXPECTED RESULT

```
0.0555555555555558
```

### PS

這題似乎存在精度問題，我執行以下查詢計算的結果如下

``` sql
SELECT mID, AVG(stars) as 'AVG_stars', ( SELECT year FROM Movie WHERE Movie.mID = R.mID ) AS 'year'
FROM Rating R
GROUP BY mID;
```

```
mID AVG_stars           year
101	3.0	                1939
103	2.5	                1965
104	2.5	                1982
106	4.5	                1937
107	4.0	                2009
108	3.33333333333333	1981
```

小於1980 = `(3 + 2.5 + 4.5)/3`
大於1980 = `(4.0 + 2.5 + (10/3) )/3`
兩者相減為`1/18`，約為`0.05555...`
---