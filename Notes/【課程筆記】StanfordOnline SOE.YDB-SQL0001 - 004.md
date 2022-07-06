---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 004

## Introduction to SQL

- Data Definition Language DDL
	- Create table 
	- Drop table
- Data Manipulation Language DML
	- select
	- insert
	- delete
	- update
- Other commands
	- Indexes
	- constrains
	- views
	- triggers

- `SELECT` statement 

``` sql
SELECT A1,A2,...,Rn 
FROM R1,R2,R3...Rm
WHERE condition
```

$$
\pi_{A_{1},A_{2},...,A_{n}}(\sigma_{condition}(R_{1} \times R_{2}\times ... R_{m}))
$$

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]