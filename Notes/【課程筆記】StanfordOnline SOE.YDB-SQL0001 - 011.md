---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 011

## `NULL` Values

`NULL` 的介紹

- [[SQL 語法筆記 - `is NULL` vs `= NULL`]]

1. `NULL`本身不是數值，而是描述`unknown`或`undefined`狀態

``` sql
select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <=3.5
```

即使`Student`資料表裡面有一筆GPA為`NULL`的值，上面的查詢也不會顯示出來。

因為`NULL`無法用比較運算子(`> < = like...etc`)比較，只能用`is NULL`確認。

``` sql
select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <=3.5 or GPA is null;
```

在這個範例裡面，就可以明確取得`GPA`為`NULL`的資料。

``` sql
select sID, sName, GPA, sizeHS
from Student
where GPA > 3.5 or sizeHS < 1600;
```

另外一種方法是透過額外的欄位`sizeHS`來取得`GPA`為`NULL`的entity，因為多加了一個有關`sizeHS`的條件，因此即使`GPA is NULL`，也可以藉由`sizeHS < 1600`加進來

2. 在`WHERE`子句中，比較會有三種結果`Ture、False、Unknown(NULL)`

``` sql
select sID, sName, GPA, sizeHS
from Student
where GPA > 3.5 or sizeHS < 1600 or sizeHS >= 1600;
```

這個範例通過添加`or sizeHS < 1600`的條件來凸顯`GPA is NULL`的資料

3. 在計算數量時，`NULL`會對結果產生影響

計算`GPA`裡面的`NULL`欄位數量

``` sql
select count(*)
from Student
where GPA is not null;
--- 12列 GPA 不為NULL

select count(distinct GPA)
from Student
where GPA is not null;
--- 7 列不重複的資料， GPA 不為NULL

select count(distinct GPA)
from Student;
--- 7

select distinct GPA
from Student;
--- 8 rows?
```

當我們依照`GPA`計算有幾列不同時，`count(distinct GPA)`不會把`NULL`的欄位計算進來，因此儘管依照`GPA`的值域實際上有8種，`count()`卻不會把`NULL`計算進來。

`count`只是其中一種會被`NULL`影響的情況，剩餘的會在後續補充。

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]