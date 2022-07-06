---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 005

## Basic `SELECT` statement 

Demo:

``` txt
College(cName,state,enrollment)
Student(sID,sName,GPA,sizeHS) 
Apply(sID,cName,major,decision)
```

##### Example:

###### 從table中篩選資料

``` sql
SELECT sID,sName,GPA 
FROM Student
WHERE GPA > 3.6
```

學生裡面GPA>3.6

###### 串聯多個表來取得所需資料

``` sql
SELECT sName, major
FROM Student, Apply
WHERE Student.sId = Apply.sID
```

串聯Student與Apply表

``` sql
SELECT DISTINCT sName, major
FROM Student, Apply
WHERE Student.sId = Apply.sID
```

- `corss join`用來將兩個表的資訊整理在一起
	- [Select from Table1, Table2](https://stackoverflow.com/questions/39859022/select-from-table1-table2)

``` sql
SELECT sname,GPA,decision
FROM Student, Apply
WHERE Student.sID = Apply.sID AND sizeHS < 1000 and major = 'CS' and cname = 'Stanford';
```

###### 使用`DISTINCT`過濾重複值

``` sql
SELECT DISTINCT College.cName
FROM College, Apply
WHERE College.cName = Apply.cName and enrollment > 20000 and major = 'CS'; 
```

###### 多重表格合併

``` sql
SELECT Student .sID, sName, GPA, Apply.cName, enrollment
FROM Student, College, Apply
WHERE Apply.sID = Student.sID and Apply.cName = College.cName;
```

###### 模糊比對

- `like`

``` sql
SELECT sID, major
FROM Apply
WHERE major like '%bio%' 
```

###### 欄位計算值與修改欄位名稱

- 使用計算後的欄位並給予一個名字

``` sql
select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaledGPA
from Student;
```

- [SQL AS Keyword](https://www.w3schools.com/sql/sql_ref_as.asp)
- [SQL Server Computed Columns](https://www.sqlservertutorial.net/sql-server-basics/sql-server-computed-columns/)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]