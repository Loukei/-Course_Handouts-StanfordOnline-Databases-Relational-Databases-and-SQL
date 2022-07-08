---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 006

## Table Variables and Set Operators

- 大綱
	- Table variables
		- 可以用來查詢跨表格的實體
		- set operator
			- `Union`,`Intersect`,`Expect`

##### Table Variable

Table Variable用來簡化表格的名稱，讓開發者在使用表格的時候程式碼更簡潔

``` sql
select S.sID, S.sName, S.GPA, A.cName, C.enrollment
from Student S, College C, Apply A
where A.sID = S.sID and A.cName = C.cName;
```

以上的程式碼等同於下面

``` sql
select Student.sID, Student.sName, Student.GPA, Apply.cName, College.enrollment
from Student S, College C, Apply A
where Apply.sID = Student.sID and Apply.cName = College.cName;
```

---

- 尋找所有相同`GPA`的學生

``` sql
SELECT S1.sID, S1.sName, S1.GPA,S2.sID, S2.sName, S2.GPA
FROM Student S1
	CROSS JOIN Student S2
WHERE S1.GPA = S2.GPA;
```

Table Variable 在上面的範例中展現了另一個用途: 在合併同一個表格`Student`時，區分第一個表格`S1`與`S2`

- 過濾相同的`id`的組合

``` sql
SELECT S1.sID, S1.sName, S1.GPA,S2.sID, S2.sName, S2.GPA
FROM Student S1
	CROSS JOIN Student S2
WHERE S1.GPA = S2.GPA AND S1.sID <> S2.sID;
```

上一個範例裡面我們會把同一個學生放進來，產生形如`(S1,S1),(S2,S2),(S3,S3)...`的組合，為了避免這種情況(我們要的是擁有相同成績的不同學生)，可以添加一個條件`AND S1.sID <> S2.sID`

###### 5

- 考慮到重複的組合會出現兩次`(1,5),(5,1)`，使用`<`來去除重複

``` sql
SELECT S1.sID, S1.sName, S1.GPA,S2.sID, S2.sName, S2.GPA
FROM Student S1
	CROSS JOIN Student S2
WHERE S1.GPA = S2.GPA AND S1.sID < S2.sID;
```

上一個例子還是不夠完美，同一個學生組合會固定出現兩次`(S1,S2),(S2,S1),(S3,S5),(S5,S3)...`，因此我們可以要求"前面出現的學生學號一定要比較小"`S1.sID < S2.sID`，來解決這個問題

---

###### Set operators - `Union`

- 用`UNION`找出所有學生
	- `UNION`會自動排序與刪除重複的元素，因此在兩個table間重複的元素不會重複出現

``` sql
SELECT cName AS name from College
UNION
SELECT sName AS name from Student;
```

`Student`學生表紀錄了"所有申請與不申請學校的學生"
`College`則記錄了"所有大學的名稱"

通過`Union`運算可以將兩個集合作合併，並且`UNION`自身會做**刪除重複**與**排序**的工作

`UNION`本身會使用`cName`作為欄位名稱，但是我們可以通過`AS`作統一的命名，來讓

- `UNION ALL`
	- 節省效能，不會做排序與去除重複的工作

``` sql
SELECT cName AS name from College
UNION ALL
SELECT sName AS name from Student;
```

`UNION ALL`不會作額外的工作(去除重複與排序)，在使用者確定合併的結果不會重複的時候可以提升效能。

- [SQL UNION/UNION ALL Operator - W3Schools](https://www.w3schools.com/sql/sql_union.asp)
- [SQL Aliases](https://www.w3schools.com/sql/sql_alias.asp)

- `ORDER BY`排序資料

``` sql
SELECT cName AS name from College
UNION ALL
SELECT sName AS name from Student
ORDER BY name;
```

在使用`UNION ALL`的情況下，如果想要排序可以使用`ORDER BY`運算

- [SQL ORDER BY Keyword](https://www.w3schools.com/sql/sql_orderby.asp)

---

###### Set operators - `INTERSECT`

- `INTERSECT`

``` sql
SELECT sID from Apply where major = 'CS'
INTERSECT
SELECT sID from Apply where major = 'EE';
```

交集如同之前的`UNION`，會把資料作去除重複與排序的工作

- 找出雙修`CS`與`EE`的學生
	- 在`Apply`表格可能會有同一學生的多次申請，因此一個id可能會出現多次

``` sql
SELECT A1.sID
from Apply A1
	CROSS JOIN Apply A2
WHERE A1.sID = a2.sID AND A1.major = 'CS' AND A2.major = 'EE';
```

有一些[[【技術】DBMS - Database Management System|DBMS]]不支援`INTERSECT`，但是我們可以使用其他的手法做到，如上面的範例

可以發現到執行的結果有些不理想: 有些sID可能會重複出現，因為該學生可能會申請不同學校的'CS'，也有可能他除了申請'CS'與'EE'之外又另外申請'biology'之類，因此會有重複的內容。

- `DISTINCT`去除重複

``` sql
SELECT DISTINCT A1.sID
from Apply A1
	CROSS JOIN Apply A2
WHERE A1.sID = a2.sID AND A1.major = 'CS' AND A2.major = 'EE';
```

- [ SQL INTERSECT - 1Keydata SQL 語法教學](https://www.1keydata.com/tw/sql/sql-intersect.html)
- [SELECT DISTINCT](https://www.w3schools.com/sql/sql_ref_select_distinct.asp)

---

###### Set operators - `EXCEPT`

- `EXCEPT`差集，找出所有`CS`與`EE`的學生但不包含雙修者

``` sql
SELECT sID FROM Apply WHERE major = 'CS'
EXCEPT
SELECT sID FROM Apply WHERE major = 'EE';
```

- 不支援`EXCEPT`的情況下，找出有修`CS`但不修其它科目者

``` sql
SELECT DISTINCT A1.sID 
FROM Apply A1,Apply A2
WHERE A1.sID = A2.sID 
	AND A1.major = 'CS' 
	AND A2.major != 'EE';
```

``` txt
123
345
987
876
543
```

可以觀察到下方的例子多了兩筆(123,345)，這兩名學生分別為
- 在不同學校申請'CS'，且申請'EE'
- 除了申請CS外還有申請其他主修(bioengineering)與'EE'

``` txt
123	Stanford	CS	Y
123	Stanford	EE	N
123	Berkeley	CS	Y
123	Cornell	    EE	Y
345	MIT	        bioengineering	Y
345	Cornell	    bioengineering	N
345	Cornell	    CS	Y
345	Cornell	    EE	N
```

再這種情況下我們會有多種重複結果
```
123	Stanford	CS	Berkeley	CS
123	Stanford	CS	Stanford	CS
123	Berkeley	CS	Berkeley	CS
123	Berkeley	CS	Stanford	CS
345	Cornell	    CS	Cornell	    CS
345	Cornell	    CS	Cornell	    bioengineering
345	Cornell	    CS	MIT	        bioengineering
```

我們只能"排除有修CS但不修EE的人"，但不能排除"有修CS與其他非EE的人(如歷史)"
目前我們所學的**不能排除這種情況**,將在下一節討論正確做法[[#2 5 4 Demo 找出有修CS的學生裡面沒有修EE的學生]]

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V000200_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@vid-table_variables_and_set_operators/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@SQLTableVarsSetOps.pdf)
- [SQL Script](https://courses.edx.org/assets/courseware/v1/54ca6d17f1017d167342af448327c13b/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/TableVarsSetOps.sql)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]