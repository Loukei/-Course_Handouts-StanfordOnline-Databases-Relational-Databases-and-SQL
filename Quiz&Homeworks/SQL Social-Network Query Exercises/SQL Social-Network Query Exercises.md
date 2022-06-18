# SQL Social-Network Query Exercises
Students at your hometown high school have decided to organize their social network using databases. So far, they have collected information about sixteen students in four grades, 9-12. Here's the schema:

Highschooler ( ID, name, grade )
English: There is a high school student with unique ID and a given first name in a certain grade.

Friend ( ID1, ID2 )
English: The student with ID1 is friends with the student with ID2. Friendship is mutual, so if (123, 456) is in the Friend table, so is (456, 123).

Likes ( ID1, ID2 )
English: The student with ID1 likes the student with ID2. Liking someone is not necessarily mutual, so if (123, 456) is in the Likes table, there is no guarantee that (456, 123) is also present.

Your queries will run over a small data set conforming to the [schema](social.sql). View the database. (You can also download the schema and data.)

For your convenience, here is a graph showing the various connections between the students in our database. 9th graders are blue, 10th graders are green, 11th graders are yellow, and 12th graders are purple. Undirected black edges indicate friendships, and directed red edges indicate that one student likes another student.

Social graph

![social](social.png)

**Instructions:** Each problem asks you to write a query in SQL. To run your query against our back-end sample database using SQLite, click the "Submit" button. You will see a display of your query result and the expected result. If the results match, your query will be marked "correct". You may run as many queries as you like for each question.

---

## Q1

Find the names of all students who are friends with someone named Gabriel.

```
Jordan
Cassandra
Andrew
Alexis
Jessica
```

---

## Q2

For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.

```
John	12	Haley	10
```

---

## Q3

For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.

```
Cassandra	9	Gabriel	9
Jessica	11	Kyle	12
```

---

## Q4

Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.

```
Jordan	9
Tiffany	9
Logan	12
```

---

## Q5

For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.

```
Alexis	11	Kris	10
Brittany	10	Kris	10
Austin	11	Jordan	12
John	12	Haley	10
```

---

## Q6

Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.

```
Jordan	9
Brittany	10
Haley	10
Kris	10
Gabriel	11
John	12
Logan	12
```

---

## Q7

For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.

```
Andrew	10	Cassandra	9	Gabriel	9
Austin	11	Jordan	12	Andrew	10
Austin	11	Jordan	12	Kyle	12
```

---

## Q8

Find the difference between the number of students in the school and the number of different first names.

```
2
```

---

## Q9

Find the name and grade of all students who are liked by more than one other student.

```
Cassandra	9
Kris	10
```