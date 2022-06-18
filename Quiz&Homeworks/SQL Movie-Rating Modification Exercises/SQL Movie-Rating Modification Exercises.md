# SQL Movie-Rating Modification Exercises

You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some data modifications. Here's the schema:

Movie ( mID, title, year, director )
English: There is a movie with ID number mID, a title, a release year, and a director.

Reviewer ( rID, name )
English: The reviewer with ID number rID has a certain name.

Rating ( rID, mID, stars, ratingDate )
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.

Your modifications will run over a small data set conforming to the [schema](rating.sql).

## Questions

### Q1

Add the reviewer Roger Ebert to your database, with an rID of 209.

To check your data modification statement for Q1, we ran the following query after your modification: select * from Reviewer order by rID, name

#### EXPECTED RESULT

To check your data modification statement, we ran the following query after your modification:

``` SQL
SELECT *
FROM Reviewer
ORDER BY rID, name;
```

Expected Query Result:

``` csv
201,Sarah Martinez
202,Daniel Lewis
203,Brittany Harris
204,Mike Anderson
205,Chris Jackson
206,Elizabeth Thomas
207,James Cameron
208,Ashley White
209,Roger Ebert
```

### Q2

For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)

#### EXPECTED RESULT

To check your data modification statement for Q2, we ran the following query after your modification: 

``` sql
select * from Movie order by mID
```

Expected Query Result:

```
101	Gone with the Wind	1939	Victor Fleming
102	Star Wars	1977	George Lucas
103	The Sound of Music	1965	Robert Wise
104	E.T.	1982	Steven Spielberg
105	Titanic	1997	James Cameron
106	Snow White	1962	
107	Avatar	2034	James Cameron
108	Raiders of the Lost Ark	1981	Steven Spielberg
```

### Q3

Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.

#### EXPECTED RESULT

To check your data modification statement for Q3, we ran the following query after your modification: 

``` sql
select R.rID, R.mID, R.stars, M.title, M.year from Rating R join Movie M on (R.mID = M.mID) order by R.rID, R.mID
```

Expected Query Result:

```
101	Gone with the Wind	1939	Victor Fleming
102	Star Wars	1977	George Lucas
103	The Sound of Music	1965	Robert Wise
104	E.T.	1982	Steven Spielberg
105	Titanic	1997	James Cameron
106	Snow White	1962	
107	Avatar	2034	James Cameron
108	Raiders of the Lost Ark	1981	Steven Spielberg
```