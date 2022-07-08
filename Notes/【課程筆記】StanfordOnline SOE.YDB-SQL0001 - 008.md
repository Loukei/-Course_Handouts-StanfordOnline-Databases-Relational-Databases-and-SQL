---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 008

## Subqueries in `FROM` and `SELECT`

- 介紹在`from`與`select`中的子查詢
	- 用在`from`表示產生一個暫存的table，用來做集合運算
	- 用在`select`表示用來產生一個暫時性的欄位
		- ex: 成績是否及格、國土的人口密度等

##### 1 subquery in `from`的介紹

Students whose scaled GPA changes GPA by more than 1

``` sql
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student
where GPA*(sizeHS/1000.0) - GPA > 1.0
   or GPA - GPA*(sizeHS/1000.0) > 1.0;
```

``` csv
234	Bob	3.6	5.4
345	Craig	3.5	1.75
567	Edward	2.9	5.8
678	Fay	3.8	0.76
876	Irene	3.9	1.56
765	Jay	2.9	4.35
543	Craig	3.4	6.8
```

以學生的成績`GPA`與學校規模`sizeHS`衡量學生表現

以上範例有幾個問題:

1. `GPA*(sizeHS/1000.0)`這個公式出現在查詢裡面多次，因此在後續改動時會造成困難。
2. `GPA*(sizeHS/1000.0) - GPA > 1.0 or GPA - GPA*(sizeHS/1000.0) > 1.0`實際上需要的是一個絕對值功能

``` sql
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student
where abs(GPA*(sizeHS/1000.0) - GPA) > 1.0;
```

``` csv
234	Bob	3.6	5.4
345	Craig	3.5	1.75
567	Edward	2.9	5.8
678	Fay	3.8	0.76
876	Irene	3.9	1.56
765	Jay	2.9	4.35
543	Craig	3.4	6.8
```

以上的範例使用`abs()`函數來簡化`where`運算，如果`sizeHS > 1000`，則`scaledGPA > GPA`，反之`< GPA`

- [SQL Server ABS() Function](https://www.w3schools.com/sql/func_sqlserver_abs.asp)

``` sql
select *
from (select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
      from Student) G
where abs(scaledGPA - GPA) > 1.0;
```

``` csv
234	Bob	3.6	5.4
345	Craig	3.5	1.75
567	Edward	2.9	5.8
678	Fay	3.8	0.76
876	Irene	3.9	1.56
765	Jay	2.9	4.35
543	Craig	3.4	6.8
```

在這裡正式引入我們這章節的功能，將計算好的欄位值`GPA*(sizeHS/1000.0) as scaledGPA`放在子查詢裡面，而外部的查詢`where`就能夠使用`scaledGPA`

結論:
- **使用 subquery in from，可以減少重複使用算式，降低後續修改的錯誤**

---

##### 2  介紹subquery in `select`

Colleges paired with the highest GPA of their applicants

找出每間學校的最高`GPA`，以及學校所在的州

``` sql
select College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
  and Apply.sID = Student.sID
  and GPA >= all
          (select GPA from Student, Apply
           where Student.sID = Apply.sID
             and Apply.cName = College.cName);
```

| cname | state | gpa |
| --- | --- | --- |
| Cornell | NY | 3.9 |
| Berkeley | CA | 3.9 |
| Stanford | CA | 3.9 |
| Stanford | CA | 3.9 |
| MIT | MA | 3.9 |
| MIT | MA | 3.9 |
| Stanford | CA | 3.9 |

``` sql
select distinct College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
  and Apply.sID = Student.sID
  and GPA >= all
          (select GPA from Student, Apply
           where Student.sID = Apply.sID
             and Apply.cName = College.cName);
```

``` csv
cname	state	gpa
Berkeley	CA	3.9
Cornell	NY	3.9
MIT	MA	3.9
Stanford	CA	3.9
```

剔除重複的列

``` sql
select distinct cName, state,
  (select distinct GPA
   from Apply, Student
   where College.cName = Apply.cName
     and Apply.sID = Student.sID
     and GPA >= all
           (select GPA from Student, Apply
            where Student.sID = Apply.sID
              and Apply.cName = College.cName)) as GPA
from College;
```

``` csv
cname	state	gpa
Berkeley	CA	3.9
Cornell	NY	3.9
MIT	MA	3.9
Stanford	CA	3.9
```

上面引入subquery的概念，直接在`select`裡面執行**查詢該校最高GPA的學生**的工作。

``` sql
select distinct cName, state,
  (select distinct sName
   from Apply, Student
   where College.cName = Apply.cName
     and Apply.sID = Student.sID) as sName
from College;
```

``` csv
ERROR:  more than one row returned by a subquery used as an expression
```

上面試圖修改範例，找出每間大學的學生名稱。
結果的到一個error，問題出在放在`select`裡面的子查詢必須與`college`的表格欄位是1 - 1對應。

結論:
- **注意在`select`裡的subquery不能回傳多於一列的結果**
- **在`select`裡使用subquery可以減少一些`join`的麻煩**
	- 比如"查詢最高票房的電影名稱"，名稱會放在電影的表格裡面，我們可以在`select`裡面通過子查詢利用`movie_id`找到電影名稱，而不用再多`join`電影的表格

##### Questions

- [[#2 6 1 DEMO Students whose scaled GPA changes GPA by more than 1]]的`scaledGPA`的意義是什麼? 為何要用絕對值計算?
- [[#2 6 2 DEMO Colleges paired with the highest GPA of their applicants]]的subquery可以抓到

## Matreials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V000500_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@vid-subqueries_in_from_and_select/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@SQLSubqueriesFromSelect.pdf)
- [SQL Script](https://courses.edx.org/assets/courseware/v1/f0fe505318b00ab6c3f2e62720e48e1f/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/SubqueriesFromSelect.sql)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]