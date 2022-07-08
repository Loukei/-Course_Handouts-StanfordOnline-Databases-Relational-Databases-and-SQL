---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 007

## Subqueries in `WHERE` Clause

介紹在`where`子句的`subqueries`，同時也是第一次介紹子查詢

#####  1 介紹子查詢

尋找有申請'CS'主修的學生，不限學校

``` sql
SELECT sID,sName
FROM Student
WHERE sID IN (
	SELECT sID
	FROM Apply
	WHERE major = 'CS'
);
```

``` txt
123	Amy
345	Craig
987	Helen
876	Irene
543	Craig
```

`subquery`可以將查詢分成多個步驟進行，以上面的範例來說，先將所有選修'CS'的學生`sid`收集起來，接著我們再透過`student`表將所有學生的資料符合`sid`的取出。

`join`運算需要來回比對兩個表格間的差異，使用`subquery`則不用那麼麻煩。

``` sql
select Student.sID, sName, Apply.cName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
```

``` txt
123	Amy	Stanford
123	Amy	Berkeley
345	Craig	Cornell
987	Helen	Stanford
987	Helen	Berkeley
876	Irene	Stanford
543	Craig	MIT
```

注意到之前用`cross join`的作法，使用`join`的話，一個學生同時申請不同學校的'CS'部門會導致重複的學生出現。

``` sql
select distinct Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
```

使用`distinct`將資料整理成單一學生

但使用了`IN`的方式，我們先篩選出所有申請'CS'的學生ID，再根據產生出的表找尋學生的ID與名字，

- [SQL | Subquery](https://www.geeksforgeeks.org/sql-subquery/)
- [SQL IN Operator](https://www.w3schools.com/sql/sql_in.asp)
- [SQL SELECT DISTINCT Statement](https://www.w3schools.com/sql/sql_distinct.asp)
- [[SQL 語法筆記 - `EXISTS` vs `IN` vs `JOIN`]]

---

#####  2 

尋找有申請'CS'主修的學生，不限學校，但這次我們不選擇id

``` sql
SELECT sName
FROM Student
WHERE sID IN (
	SELECT sID
	FROM Apply
	WHERE major = 'CS'
);
```

``` TXT
Amy
Craig
Helen
Irene
Craig
```

可以看到有兩個`Craig`這在學生表中是兩個id不同的同名學生

``` sql
select Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
```

```
123	Amy   --- with school a
123	Amy   --- with school b
345	Craig --- Craig a 
987	Helen --- with school c
987	Helen --- with school d
876	Irene
543	Craig --- Craig b
```

``` SQL
select distinct sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
```

``` txt
Amy
Craig
Helen
Irene
```

同樣不使用ID的做法，採用`cross join`

可以看到同名的'Craig'被消除了，這是因為`distinct`的執行順序是在`join`之後，因此儘管我們預想的是"找出所有申請CS的學生，不管校名，並回傳學生的姓名"，同名的兩個不同學生卻被篩選掉。

結論:
- **`IN`與`join`可以做到一樣的效果，但是這不代表他們在邏輯上等價。(每個`Student.sID`學生可能對應到多筆`Apply`紀錄)**
- **謹慎使用`distinct`，因為你有可能將不想要的資料被排除掉。(同名但不同ID的學生)**

---

#####  3 

Duplicates are important: average GPA of CS applicants

``` cs
SELECT GPA
FROM Student
WHERE sID in (
	SELECT sID
	from Apply
	WHERE major = 'CS'
);
```

``` txt
3.9
3.5
3.7
3.9
3.4
```

使用`IN`來尋找申請CS的學生時，儘管`subquery`裡面有重複值，但是外層的`Student`表並未被影響，因此不會有同一學生的成績出現多次的情況。

``` sql
SELECT Student.sID, GPA, Apply.cName
FROM Student, Apply
WHERE Student.sID = Apply.sID AND major = 'CS';
```

``` txt
123	3.9	Stanford
123	3.9	Berkeley
345	3.5	Cornell
987	3.7	Stanford
987	3.7	Berkeley
876	3.9	Stanford
543	3.4	MIT
```

使用`cross join`做同樣的運算，可以發現`student`的tuple被`Apply`影響，因為該學生申請了多次的成績的關係，

``` sql
SELECT distinct GPA
FROM Student, Apply
WHERE Student.sID = Apply.sID AND major = 'CS';
```

``` txt
// 同上一個範例，但是使用distinct過濾GPA
3.9
3.5
3.7
3.4
```

上面的兩個範例顯示了`JOIN`的問題:
- 第一個作法中儘管學生ID會因為重名與申請不同學校而重複，但是只有相同學生ID不會出現
- 第二個做法，在`distinct`執行之前的結果已經無法區分出該筆資料是因為不同學校的申請還是重名的學生，造成後續篩選的問題

我們在求取平均的GPA的時候會造成困擾，只有使用`where ... in ...`才能得到正確的結果

---

#####  4. 

找出有修CS的學生裡面沒有修EE的學生

``` sql
SELECT sID,sName
FROM Student
WHERE sID in (SELECT sID FROM Apply WHERE major = 'CS')
	AND sID NOT in (SELECT sID FROM Apply WHERE major = 'EE');
```

```txt
987	Helen
876	Irene
543	Craig
```

在前一節[最後一題](#2.4.5)裡面，沒有解決這個問題，關鍵在`JOIN`的過程中我們沒有辦法清除**同校申請**與**多修習其他科目**的情況。

在這裡我們使用子句查詢的方式，一個集合用來找出有修'CS'的人，一個用來找出有修'EE'的人，然後我們再加以清理它們的交集。

``` sql
SELECT sID,sName
FROM Student
WHERE sID in (SELECT sID FROM Apply WHERE major = 'CS')
	AND NOT sID IN (SELECT sID FROM Apply WHERE major = 'EE');
```

同樣的範例用不同的寫法

---

##### 5 

找出同一州內有其他學校的學校
Colleges such that some other college is in the same state

``` sql
select cName, state
from College C1
where exists (select * from College C2
              where C2.state = C1.state);
```

``` txt
Stanford	CA
Berkeley	CA
MIT         MA
Cornell	    NY
```

很明顯的錯誤是這樣做無法排除自身相關聯的結果

``` sql
select cName, state
from College C1
where exists (select * from College C2
              where C2.state = C1.state and C2.cName <> C1.cName);
```

``` txt
Stanford	CA
Berkeley	CA
```

結論: 小心在同一個表內做比較時是否要去掉相同的表

---

##### 6 

最大規模的學校 

``` sql
select cName
from College C1
where not exists (select * from College C2
                  where C2.enrollment > C1.enrollment);
```

``` txt
Berkeley
```

在不使用`MAX()`函數時的方法

- 同樣的技巧，成績最好的學生

``` sql
select sName, GPA
from Student C1
where not exists (select * from Student C2
                  where C2.GPA > C1.GPA);
```

``` txt
Amy	3.9
Doris	3.9
Irene	3.9
Amy	3.9
```

這4人的成績皆相同，所以會有4個人

- [SQL MIN() and MAX() Functions](https://www.w3schools.com/sql/sql_min_max.asp)

---

##### 7

嘗試不用subquery的方式找出最大值

``` SQL
SELECT S1.sName, S1.GPA
FROM Student S1,Student S2
WHERE S1.GPA > S2.GPA
```

``` txt
Amy	3.9
Bob	3.6
Craig	3.5
Doris	3.9
Fay	3.8
Gary	3.4
Helen	3.7
Irene	3.9
Craig	3.4
```

這個範例實際上是在尋找"成績比最低的人更高的學生"

---

##### 8

成績最高的學生,`all`

``` sql
select sName, GPA
from Student
where GPA >= all (select GPA from Student);
```

``` txt
Amy	3.9
Doris	3.9
Irene	3.9
Amy	3.9
```

`ALL`語法用來比對所有集合中的數值
這裡是先找出所有學生的GPA集合，再依序比對每個學生的成績中`>=`該集合者。

- [SQL ALL Keyword](https://www.w3schools.com/sql/sql_ref_all.asp)

---

##### 9

稍微修改一下，這次我們尋找的是成績最高的一位學生

```sql
select sName, GPA
from Student S1
where GPA > all (select GPA from Student S2
                 where S2.sID <> S1.sID);
```

``` txt
--- 空集合
```

`GPA`的值為duplicate

錯誤的原因在有4個人的成績最高且**相等**，因此當`(amy,3.9)`遇到`(Doris,3.9)`時，會不滿足而把`Amy`刷掉

---

##### 10  

用同樣的條件，我們查詢學校的規模最大者

``` sql
select cName
from College S1
where enrollment > all (select enrollment from College S2
                        where S2.cName <> S1.cName);
```

``` txt
Berkeley
```

我們已知`College.enrollment`為單一值，因此我們可以找到唯一的解

---

##### 11  

`Any`用來比對集合內部只要有一個符合的情況
此處為"找出所有與當前規模不同的學校"，且當前的學校大於這些的集合

``` sql
select cName
from College S1
where not enrollment <= any (select enrollment from College S2
                             where S2.cName <> S1.cName);
```

``` txt
Berkeley
```

- [SQL ANY Keyword](https://www.w3schools.com/sql/sql_ref_any.asp)

---

##### 12

所有並非來自最小規模學校的學生

``` sql
select sID, sName, sizeHS
from Student
where sizeHS > any (select sizeHS from Student);
```

``` sql
select sID, sName, sizeHS
from Student S1
where exists (select * from Student S2
              where S2.sizeHS < S1.sizeHS);
```

可以不使用`ANY`或`ALL`，改用`exists`尋找比`S1`的學校規模還小的學生

---

##### 13

使用`any`來試圖找出只有修'CS'且沒有修'EE'的學生

``` sql
select sID, sName
from Student
where sID = any (select sID from Apply where major = 'CS')
  and sID <> any (select sID from Apply where major = 'EE');
```

``` txt
123 Amy
345 Craig
987 Helen
876 Irene
543 Craig
```

這個範例的問題在`sID <> any (select sID from Apply where major = 'EE')`這行，如果當前的學生比如`123,Amy`在`(123,345)`中有任一個元素不符合，也就是`345`，即可，因此我們得到錯誤的答案。

``` sql
select sID, sName
from Student
where sID = any (select sID from Apply where major = 'CS')
  and not sID = any (select sID from Apply where major = 'EE');
```

正確的作法是當前的`sID`不能符合任何一個有修EE的學生的集合

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V000600_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@vid-subqueries_in_where/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@SQLSubqueriesWhere.pdf)
- [SQL Script](https://courses.edx.org/assets/courseware/v1/f8812c9d0060c6c8f8e1e9a9b43b2d1b/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/SubqueriesWhere.sql)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]