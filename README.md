# Course_Handouts-StanfordOnline-Databases-Relational-Databases-and-SQL

StanfordOnline SOE.YDB-SQL0001 Course Note

## Repo Index

- Notes 上課筆記
- Quiz&Homeworks 測驗與作業的程式碼
- [Handout](Handout/Course_Handouts.md) 課程講義
- [Example Database](https://github.com/Loukei/Course_StanfordOnline_Databases-Relational-Databases-and-SQL/tree/main/Example%20Database) 課程講解用的資料庫

## Course Link

- [Databases: Relational Databases and SQL](https://www.edx.org/course/databases-5-sql?index=product&queryID=d5f4894645bf040c76eff6b948de30c5&position=3)

## Course Index

- Introduction and Relational Databases
	- Introduction
	- The Relational Model
	- Querying Relational Databases
- SQL
	- Introduction to SQL
	- Basic `SELECT` Statement
	- Table Variables and Set Operators
	- Subqueries in `WHERE` Clause
	- Subqueries in `FROM` and `SELECT`
	- The `JOIN` Family of Operators
	- Aggregation
	- `NULL` Values
	- Data Modification Statements
- Exercise
  - [SQL Movie-Rating Query Exercises](Quiz&Homeworks/SQL%20Movie-Rating%20Query%20Exercises/SQL%20Movie-Rating%20Query%20Exercises.md)
  - [SQL Movie-Rating Query Exercises Extras](Quiz&Homeworks/SQL%20Movie-Rating%20Query%20Exercises%20Extras/SQL%20Movie-Rating%20Query%20Exercises%20Extras.md)
  - [SQL Social-Network Query Exercises](Quiz&Homeworks/SQL%20Social-Network%20Query%20Exercises/SQL%20Social-Network%20Query%20Exercises.md) 
  - [SQL Social-Network Query Exercises Extras](quiz/../Quiz&Homeworks/SQL%20Social-Network%20Query%20Exercises%20Extras/SQL%20Social-Network%20Query%20Exercises%20Extras.md)
  - [SQL Movie-Rating Modification Exercises](Quiz&Homeworks/SQL%20Movie-Rating%20Modification%20Exercises/SQL%20Movie-Rating%20Modification%20Exercises.md)
  - [SQL Social-Network Modification Exercises](Quiz&Homeworks/SQL%20Social-Network%20Modification%20Exercises/SQL%20Social-Network%20Modification%20Exercises.md)

## 個人認為比較困難的題目

- SQL Movie-Rating Query Exercises
  - Q6
  - Q9: 這題的正解會依據機器計算循環小數的方式會有不同答案
- SQL Social-Network Query Exercises
  - Q3
  - Q6
  - Q7

## Textbook Readings and Other Materials

建議的閱讀材料

*   [A First Course in Database Systems](https://openlibrary.org/books/OL662283M/A_first_course_in_database_systems) ([3rd edition](https://www.amazon.com/First-Course-Database-Systems-3rd/dp/013600637X)) by Ullman and Widom (U/W)  
    (same material and sections as [Database Systems: The Complete Book](https://people.inf.elte.hu/miiqaai/elektroModulatorDva.pdf) (2nd edition) by Garcia-Molina, Ullman, and Widom)
*   [Database Management Systems](https://www.amazon.com/Database-Management-Systems-Raghu-Ramakrishnan/dp/0072465638) [(3rd edition)](https://www.amazon.com/Database-Management-Systems-Raghu-Ramakrishnan/dp/0072465638) by Ramakrishnan and Gehrke (R/G)
*   [Fundamentals of Database Systems](https://archive.org/details/FODB_6/mode/2up) [(6th edition)](https://archive.org/details/FODB_6/mode/2up) by Elmasri and Navathe (E/N)
*   [Database System Concepts](https://www.amazon.com/Database-Concepts-Abraham-Silberschatz-Professor/dp/0073523321) [(6th edition)](https://www.amazon.com/Database-Concepts-Abraham-Silberschatz-Professor/dp/0073523321) by Silberschatz, Korth, and Sudarshan (S/K/S)

## 建議的資料庫

- **PostgreSQL**:	推薦
- **MySQL**:		不支持`Intersect`
- **SQLite**:		不支持`ALL`語法

個人建議只為了操作教學資料庫的話，可以使用DBAAS服務像是**HeroKu**，不用特意去花時間安裝環境

## 課後感想

![完課截圖](IMG/【StanfordOnline%20SOE.YDB-SQL0001】完課截圖.png)

- edx的課程很多都是**免費學習，認證要錢**的模式，優缺點見人見智
- 繳交程式作業的時候，不會對程式碼內容進行邏輯測試，因此有可能用不合題目的方式"做出"正確答案
  - 舉例像是"求出1980年前的電影平均評分"，答案的結果可能是"3.5"，但是學生也可以用`select 3.5`來通過測驗。
  - 不確定是否只有這門課的問題
