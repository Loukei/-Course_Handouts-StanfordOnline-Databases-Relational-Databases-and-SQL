---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 010

## Aggregation

- 彙總函式，或者叫聚合函式
	- `MIN` `MAX` `AVG` `SUM` `COUNT`
	- 彙總函式出現在`SELECT`裡面，通常用來做整個表格的加總、平均、最大最小值等
- `GROUP BY`
	- 用來將表格依照某些屬性來分組資料
	- 舉例: 計算每個部門的平均業績分數
- `HAVING`
	- 功能與`WHERE`相似，但是用來在`GROUP BY`之後進行過濾

- [W3SCHOOLS - SQL COUNT(), AVG() and SUM() Functions](https://www.w3schools.com/sql/sql_count_avg_sum.asp)
- [MDN - 彙總函式 (Transact-SQL)](https://docs.microsoft.com/zh-tw/sql/t-sql/functions/aggregate-functions-transact-sql?view=sql-server-ver16)

簡略說明，前面都在介紹一些簡單的函式如 
- `AVG(),MIN(),COUNT()`的功能
- 加上`WHERE`達成過濾條件

因此沒有做這些筆記的必要。

##### 1. Number of students applying to Cornell

``` SQL
select Count(Distinct sID)
from Apply
where cName = 'Cornell';
```

`Distinct`可以放在`count`裡面過濾重複申請的學生，避免算錯人數，可以不用額外寫subquery來計算學生是否重複申請。

##### 2.  

Students such that number of other students with same GPA is equal to number of other students with same sizeHS

``` sql
select *
from Student S1
where (select count(*) from Student S2
       where S2.sID <> S1.sID and S2.GPA = S1.GPA) =
      (select count(*) from Student S2
       where S2.sID <> S1.sID and S2.sizeHS = S1.sizeHS);
```

找出擁有相同`GPA`與`sizeHS`的學生

##### 3.

``` sql
select CS.avgGPA - NonCS.avgGPA
from (select avg(GPA) as avgGPA from Student
      where sID in (
         select sID from Apply where major = 'CS')) as CS,
     (select avg(GPA) as avgGPA from Student
      where sID not in (
         select sID from Apply where major = 'CS')) as NonCS;
```

申請`CS`的學生與不申請的學生之間的平均分數差

``` SQL
select distinct (select avg(GPA) as avgGPA from Student
        where sID in (
           select sID from Apply where major = 'CS')) -
       (select avg(GPA) as avgGPA from Student
        where sID not in (
           select sID from Apply where major = 'CS')) as d
from Student;
```

同樣的範例用不同的寫法，添加`distinct`是用來避免同樣的數字計算多次(`Student`的row number)

##### 4. `GROUP BY`

Number of applications to each college

``` sql
select cName, count(*)
from Apply
group by cName;
```

`GROUP BY`用來對`Apply`做分組，在這裡依照學校名稱分組後，`count(*)`計算各個學校被申請的人數

##### 5.

`group by`與前面的`sum(),min(), max()`結合運用

College enrollments by state

``` sql
select state, sum(enrollment)
from College
group by state;
```

Minimum + maximum GPAs of applicants to each college & major

``` sql
select cName, major, min(GPA), max(GPA)
from Student, Apply
where Student.sID = Apply.sID
group by cName, major;
```

Widest spread

``` sql
select max(mx-mn)
from (select cName, major, min(GPA) as mn, max(GPA) as mx
      from Student, Apply
      where Student.sID = Apply.sID
      group by cName, major) M;
```

##### 6. 

Number of colleges applied to by each student

``` sql
select Student.sID, sName, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;
```

通過`join`與`group by`來計算每個學生申請幾個學校

``` sql
select Student.sID, sName, count(distinct cName), cName
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;
```

這是一個刻意添加的範例，右邊的`cName`被添加近來，因為每個學生可能申請多間的緣故，所以`cName`會是多個值，但在這裡會變成隨機的`cName`

有一些[[【技術】DBMS - Database Management System|DBMS]]不允許這種語法。

``` sql
select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID
union
select sID, 0
from Student
where sID not in (select sID from Apply);
```

在這之前的範例並沒有把"沒申請學校的學生合併進來"，這裡的範例提供了一個辦法。

##### 7. `HAVING`

`HAVING`關鍵字用來將`Group by`之後的結果再次過濾

``` sql
select cName
from Apply
group by cName
having count(*) < 5;
```

上面的範例計算"被申請不超過5次的學校"

``` sql
select cName
from Apply A1
where 5 > (select count(*) from Apply A2 where A2.cName = A1.cName);
```

同樣的情境，但是不使用`GROUP BY`或`HAVING`

``` sql
select cName
from Apply
group by cName
having count(distinct sID) < 5;
```

因為同一學生申請學校與科系的次數不受限，我們可以在`count`裡面使用`distinct`過濾結果。

上面的範例顯示"被不同學生申請不超過5次的學校"

##### 8.

Majors whose applicant's maximum GPA is below the average

``` sql
select major
from Student, Apply
where Student.sID = Apply.sID
group by major
having max(GPA) < (select avg(GPA) from Student);
```

這個範例主要在顯示`where`與`having`的區別。
`HAVING`用來接在`Group by`後面，用來過濾分組之後的條件

`where`則是在分組之前過濾
- [SQL中WHERE和HAVING子句的區別？](https://kknews.cc/zh-tw/code/vrgvx8q.html)

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V001000_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@vid-aggregation/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@SQLAggregation.pdf)
- [SQL Script](https://courses.edx.org/assets/courseware/v1/af466e464cc26d7188ce621c83fe8127/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/SQLAggregation.sql)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]