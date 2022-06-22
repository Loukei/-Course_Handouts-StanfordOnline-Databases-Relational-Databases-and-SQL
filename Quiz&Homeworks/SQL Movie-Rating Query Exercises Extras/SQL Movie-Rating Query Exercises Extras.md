# SQL Movie-Rating Query Exercises Extras

You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema:

Movie ( mID, title, year, director )
English: There is a movie with ID number mID, a title, a release year, and a director.

Reviewer ( rID, name )
English: The reviewer with ID number rID has a certain name.

Rating ( rID, mID, stars, ratingDate )
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.

Your queries will run over a small data set conforming to the [schema](rating.sql). View the database. (You can also download the schema and data.)

Instructions: Each problem asks you to write a query in SQL. To run your query against our back-end sample database using SQLite, click the "Submit" button. You will see a display of your query result and the expected result. If the results match, your query will be marked "correct". You may run as many queries as you like for each question.

**Important Notes:**

Your queries are executed using SQLite, so you must conform to the SQL constructs supported by SQLite.
Unless a specific result ordering is asked for, you can return the result rows in any order.
You are to translate the English into a SQL query that computes the desired result over all possible databases. All we actually check is that your query gets the right answer on the small sample database. Thus, even if your solution is marked as correct, it is possible that your query does not correctly reflect the problem at hand. (For example, if we ask for a complex condition that requires accessing all of the tables, but over our small data set in the end the condition is satisfied only by Star Wars, then the query "select title from Movie where title = 'Star Wars'" will be marked correct even though it doesn't reflect the actual question.) Circumventing the system in this fashion will get you a high score on the exercises, but it won't help you learn SQL. On the other hand, an incorrect attempt at a general solution is unlikely to produce the right answer, so you shouldn't be led astray by our checking system.

You may perform these exercises as many times as you like, so we strongly encourage you to keep working with them until you complete the exercises with full credit.

---

## Q1

Find the names of all reviewers who rated Gone with the Wind.

### Expected Query Result:

Sarah Martinez
Mike Anderson

---

## Q2

For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

### Expected Query Result:
James Cameron	Avatar	5

---

## Q3

Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)

### Expected Query Result:

Ashley White
Avatar
Brittany Harris
Chris Jackson
Daniel Lewis
E.T.
Elizabeth Thomas
Gone with the Wind
James Cameron
Mike Anderson
Raiders of the Lost Ark
Sarah Martinez
Snow White
Star Wars
The Sound of Music
Titanic

---

## Q4

Find the titles of all movies not reviewed by Chris Jackson.

### Expected Query Result:

Gone with the Wind
Star Wars
Titanic
Snow White
Avatar

---

## Q5

For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.

### Expected Query Result:

Ashley White	Chris Jackson
Brittany Harris	Chris Jackson
Daniel Lewis	Elizabeth Thomas
Elizabeth Thomas	James Cameron
Mike Anderson	Sarah Martinez

---

## Q6

For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.

### Expected Query Result:

Sarah Martinez	Gone with the Wind	2
Brittany Harris	The Sound of Music	2
Brittany Harris	Raiders of the Lost Ark	2
Chris Jackson	E.T.	2

---

## Q7

List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.

### Expected Query Result:

Snow White	4.5
Avatar	4
Raiders of the Lost Ark	3.3333333333333335
Gone with the Wind	3
E.T.	2.5
The Sound of Music	2.5

---

## Q8

Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)

### Expected Query Result:
Brittany Harris
Chris Jackson

---

## Q9

Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)

### Expected Query Result:
Avatar	James Cameron
Titanic	James Cameron
E.T.	Steven Spielberg
Raiders of the Lost Ark	Steven Spielberg

---

## Q10

Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)

### Expected Query Result:
Snow White	4.5

---

## Q11

Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)

### Expected Query Result:
The Sound of Music	2.5
E.T.	2.5

---

## Q12

For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.

### Expected Query Result:
James Cameron	Avatar	5
Robert Wise	The Sound of Music	3
Steven Spielberg	Raiders of the Lost Ark	4
Victor Fleming	Gone with the Wind	4
