---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 009

## The `JOIN` Family of Operators

- 本章節討論的是各種`JOIN`的方式
	- `Inner Join On` condition 
		- 前面的章節所使用的方式，有分為顯性(Explicit)與隱性(implicitly)，主要區別在是否使用`ON`指明條件
	-  `Natural Join`
	- `Inner Join Using(attrs)`
	- Left | Right | Full `Outer Join`

##### 1 `INNER JOIN `

Student names and majors for which they've applied

``` sql
select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;
```

/*** Rewrite using INNER JOIN ***/

``` sql
select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;
```

上面的範例把原先使用的範例改寫

/*** Abbreviation is JOIN ***/

``` sql
select distinct sName, major
from Student join Apply
on Student.sID = Apply.sID;
```

`INNER JOIN`是資料庫預設使用的方式，因此我們可以拿掉`INNER`的表達式，並得到一樣的結果。

- [SQL INNER JOIN Keyword - W3Schools](https://www.w3schools.com/sql/sql_join_inner.asp)

---

##### 2 `INNER JOIN` WITH ADDITIONAL CONDITIONS

Student application info: name, ID, college name, major

``` sql
select sName, GPA
from Student, Apply
where Student.sID = Apply.sID
  and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

以前的範例，找出申請`'Stanford'`與`'CS'`的學生

/*** Rewrite using JOIN ***/

``` sql
select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

將上述的範例改寫成使用`join on`

/*** Can move everything into JOIN ON condition ***/

將`where`的條件加入到`join on`裡面

``` sql
select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

實際上可以把`where sizeHS < 1000 and major = 'CS' and cName = 'Stanford'`的條件放進`on`

過濾的條件要放在`where`或是`on` ?

> Because these queries are obviously equivalent.
Well first of all there are many equivalent queries in SQL, we can right things in different ways.
In theory, a SQL query processor should execute them all in the most efficient possible way, but the join clause, in particular, is often used as a hint to the query processor on how to execute the query.
So if we put all of these in the `on` condition, we're sort of saying, as the query processor does the join, it should be applying all the conditions.
When we make this a where, it's sort of a hint saying, here's the condition that really applies to the combination of the tuples, and the rest of the conditions apply to separate attributes.

SQL語句可以有很多表達方式，SQL查詢處理器應該會以最有效率的方式處理他們。

當我們在`on`使用這些條件時，是在提示處理器做連接時應該使用的條件。

在`where`使用時，代表用在過濾**tuple**的條件

---

##### 3 THREE-WAY INNER JOIN

Application info: ID, name, GPA, college name, enrollment

``` sql
select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply, Student, College
where Apply.sID = Student.sID and Apply.cName = College.cName;
```

/*** Rewrite using three-way JOIN ***/
/*** Works in SQLite and MySQL but not Postgres ***/

``` sql
select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply join Student join College
on Apply.sID = Student.sID and Apply.cName = College.cName;
```

三個table的`join`，在某些DBMS底下可以把條件寫在一起，但在[[【工具箱】PostgreSQL|PostgreSQL]]不行

/*** Rewrite using binary JOIN ***/

在**Postgres**裡面不支援只寫`JOIN`，必須用子查詢

``` sql
select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join Student on Apply.sID = Student.sID) join College on Apply.cName = College.cName;
```

我們可以使用括號`()`來處理`join`的順序

要注意2個以上的`join`在執行的效能可能會有落差，如`(A*B)*C`與`(A*C)*B`的實際執行效能不同。

---

##### 4 `NATURAL JOIN`

[[SQL 語法筆記 - `Natural Join`]]

Student names and majors for which they've applied

``` sql
select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;
```

/*** Rewrite using NATURAL JOIN ***/

``` sql
select distinct sName, major
from Student natural join Apply;
```

`NATURAL JOIN`會自動比對相同的`sID`並組合，因此執行的結果跟`inner join`相似

/*** Like relational algebra, eliminates duplicate columns ***/

``` sql
select *
from Student natural join Apply;
```

如果不特別指名，`NATURAL JOIN`會只顯示一個`sID`，並不會保留多餘的副本

``` sql
select distinct sID
from Student natural join Apply;
```

如果使用`natural join`，我們不需要刻意指明`sID`來源於哪個table

/*** Would get ambiguity error with cross-product ***/

``` sql
select distinct sID
from Student, Apply;
```

在`Cross join`的時候，必須明確指明要使用哪個table`Student.sID`，否則會產生錯誤

- [Difference between Natural join and Inner Join in SQL](https://www.geeksforgeeks.org/difference-between-natural-join-and-inner-join-in-sql/)

---

##### 5 `NATURAL JOIN` WITH ADDITIONAL CONDITIONS

Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford

``` sql
select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

/*** Rewrite using NATURAL JOIN ***/

``` sql
select sName, GPA
from Student natural join Apply
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

`natural join`可以省略撰寫合併的條件`on Student.sID = Apply.sID`

使用`natural join`，但是結果相同

/*** USING clause considered safer ***/

``` sql
select sName, GPA
from Student join Apply using(sID)
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';
```

另一個有用的特性是`USING`，他可以明確地指出兩個table是依照哪個屬性鏈接起來的。

使用`using()`可以簡化合併的條件，但只在table間有明確的欄位名稱相同(`sID`)的情況

- [SQL | USING Clause - GeeksforGeeks](https://www.geeksforgeeks.org/sql-using-clause/)
- [SQL使用using关键字详解](https://blog.csdn.net/shadow_zed/article/details/89083383)

---

##### 6 `SELF-JOIN`

**Pairs of students with same GPA**

``` sql
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.sID;
```

**Rewrite using JOIN and USING (disallowed)**

``` sql
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using(GPA)
on S1.sID < S2.sID;
```

將前面的範例使用`USING`改寫，但是我們可以發現`using`與`on`不能同時用

**Without ON clause**

``` sql
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using(GPA)
where S1.sID < S2.sID;
```

雖然不能同時使用`on`與`using`，但可以把過濾條件放到`where`

---

##### 7 SELF NATURAL JOIN

``` sql
select *
from Student S1 natural join Student S2;
```

任意集合做`SELF natural JOIN`等同於自身

/*** Verify equivalence to Student ***/

``` sql
select * from Student;
```

順序與`self join`不同，但結果一樣

- [w3Schools - SQL Self Join](https://www.w3schools.com/sql/sql_join_self.asp)

---

##### 8 LEFT OUTER JOIN

Student application info: name, ID, college name, major

``` sql
select sName, sID, cName, major
from Student inner join Apply using(sID);
```

/*** Include students who haven't applied anywhere ***/

``` sql
select sName, sID, cName, major
from Student left outer join Apply using(sID);
```

``` txt
Amy	123	Berkeley	CS
Amy	123	Cornell	EE
Amy	123	Stanford	CS
Amy	123	Stanford	EE
Bob	234	Berkeley	biology
Craig	345	Cornell	CS
Craig	345	Cornell	EE
Craig	345	Cornell	bioengineering
Craig	345	MIT	bioengineering
Doris	456		
Edward	567		
Fay	678	Stanford	history
Gary	789		
Helen	987	Berkeley	CS
Helen	987	Stanford	CS
Irene	876	MIT	biology
Irene	876	MIT	marine biology
Irene	876	Stanford	CS
Jay	765	Cornell	history
Jay	765	Cornell	psychology
Jay	765	Stanford	history
Amy	654		
Craig	543	MIT	CS
```

`outer join`用在合併表格的時候提供多一個選項: **即使兩個table之間並沒有完全滿足合併的條件，那些不滿足的欄位還是會保留下來。**

上面的範例介紹了`LEFT OUTER JOIN`，並且使用`sID`做合併條件，可以看到並非所有學生都申請了學校，因此，在一般`INNER JOIN`的時候這些學生應該不會出現，但是在`LEFT OUTER JOIN`的條件下，即使沒有對應的tuple，這些沒有申請學校的學生仍會出現，只是左側為`null`。

如果需要在JOIN的時候不管有沒有`sID`相同，都把資料並排起來，`outer join`就是我們的選項

[**SQL OUTER JOIN**](https://www.1keydata.com/tw/sql/sqlouterjoin.html)

/*** Abbreviation is LEFT JOIN ***/

``` sql
select sName, sID, cName, major
from Student left join Apply using(sID);
```

`left outer join`可以縮寫為`left join`

/*** Using NATURAL OUTER JOIN ***/

``` sql
select sName, sID, cName, major
from Student natural left outer join Apply;
```

也可以使用`natural left join`，這樣就不用寫合併條件，但在軟體工程的角度不建議。

/*** Can simulate without any JOIN operators ***/

``` sql
select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply);
```

可以不使用`join`關鍵字來達成同樣的效果，以上的範例使用集合運算的方式。

第一段利用`cross join`把`sID`相同的進行合併。
第二段則是利用`not in`篩選掉那些沒有申請學校的學生。

/*** Instead include applications without matching students ***/

``` sql
insert into Apply values (321, 'MIT', 'history', 'N');
insert into Apply values (321, 'MIT', 'psychology', 'Y');
```

刻意添加兩筆資料，學生`321`是不存在`students`表中的

``` sql
select sName, sID, cName, major
from Apply natural left outer join Student;
```

注意到這裡刻意把`Apply`與`Student`做調換，因此刻意添加的不存在的學生`321`會多出來
使用`left outer join`仍然會多出兩筆`321`的紀錄，但是沒有對應的`sName`

---

##### 9 RIGHT OUTER JOIN

Student application info: name, ID, college name, major

/*** Include applications without matching students ***/

``` sql
select sName, sID, cName, major
from Student natural right outer join Apply;
```

與前一節的內容一樣，我們刻意添加學生`321`的申請資料，但這次使用`right join`，因此會出現不存在的學生`321`的申請，但是沒有申請學校的學生就不會出現。

- [SQL RIGHT JOIN Keyword](https://www.w3schools.com/sql/sql_join_right.asp)

---

##### 10 FULL OUTER JOIN

Student application info

**Include students who haven't applied anywhere and applications without matching students** 

``` sql
select sName, sID, cName, major
from Student full outer join Apply using(sID);
```

使用`full outer join`，則表示同時列出
- 沒有申請學校的學生
- 有申請卻不存在的學生

/*** Can simulate with LEFT and RIGHT outerjoins ***/
/*** Note UNION eliminates duplicates ***/

``` sql
select sName, sID, cName, major
from Student left outer join Apply using(sID)
union
select sName, sID, cName, major
from Student right outer join Apply using(sID);
```

用`left join`加`right outer join`模擬`full outer join`

/*** Can simulate without any JOIN operators ***/

``` sql
select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply)
union
select NULL, sID, cName, major
from Apply
where sID not in (select sID from Student);
```

完全不用`outer join`

- [SQL FULL OUTER JOIN Keyword](https://www.w3schools.com/sql/sql_join_full.asp)

---

##### 11 THREE-WAY OUTER JOIN

`join`運算的陷阱: 交換律與結合律

`outer join`並不滿足結合律

Not associative

Commutativity: (A op B) = (B op A )
Associativity (A op B) op C = A op (B op C)

``` sql
create table T1 (A int, B int);
create table T2 (B int, C int);
create table T3 (A int, C int);
insert into T1 values (1,2);
insert into T2 values (2,3);
insert into T3 values (4,5);
```

`T1`

| A | B |
| --- | --- |
| 1 | 2 |

`T2`

| B | C |
| --- | --- |
| 2 | 3 |

`T3`

| A | C |
| --- | --- |
| 4 | 5 |

建立三個table說明交換律跟結合律

``` sql
select A,B,C
from (T1 natural full outer join T2) natural full outer join T3;
```

`(T1 * T2) * T3 = `

``` txt
A B C
1 2 3
4   5
```

``` sql
select A,B,C
from T1 natural full outer join (T2 natural full outer join T3);
```

`T1 * (T2 * T3) =`

``` txt
A B C
4   5
  2 3
1 2
```

`T2 * T3`的結果會多出一個欄位`A`

``` txt
A, B, C
null, 2, 3
4, null, 5
```

這個集合與`T1`做`full outer join`會變成`null, 2, 3`與`1,2`無法合併，因此只能多出一列

``` sql
drop table T1;
drop table T2;
drop table T3;
```

結論:
- **做`outer join`時要尤其小心結合的順序，因為不同順序會得到完全錯誤的結果**
- [Are left outer joins associative?](https://stackoverflow.com/questions/20022196/are-left-outer-joins-associative)


## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]