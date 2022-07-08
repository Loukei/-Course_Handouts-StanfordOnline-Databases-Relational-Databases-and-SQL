---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# 【課程筆記】StanfordOnline SOE.YDB-SQL0001 - 012

## Data Modification Statements

- 修改資料庫
  - 插入(Insert)
  - 刪除(delete)
  - 更新(update)

**使用資料庫更改的語法之前，先用`select`來觀察欲修改的對象，如此一來可以減少許多誤操作**

##### 插入新資料

1. 插入單筆資料

``` sql
insert into College values ('Carnegie Mellon', 'PA', 11500);
```

2. 更複雜的情況，尋找尚未申請學校的學生，再插入到`Apply`資料表。

``` sql
--- 沒有申請的學生
select *
from Student
where sID not in (select sID from Apply);
--- 把上述的學生，換成insert運算，這些學生改成申請'Carnegie Mellon'
insert into Apply
  select sID, 'Carnegie Mellon', 'CS', null
  from Student
  where sID not in (select sID from Apply);
```

- 這裡要注意的是`values`關鍵字不用使用

3. 尋找申請`'EE'`被拒絕的學生，並且添加到`'Carnegie Mellon'`學校的`EE`部門

``` sql
insert into Apply
  select sID, 'Carnegie Mellon', 'EE', 'Y'
  from Student
  where sID in (select sID from Apply
                where major = 'EE' and decision = 'N');
```

##### 刪除資料

1. 尋找申請多個`major`的學生，並且將其刪除

``` sql
--- 申請3個以上`major`的學生
select sID, count(distinct major)
from Apply
group by sID
having count(distinct major) > 2;

--- 從Student表刪除
delete from Student
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);
```

儘管我們刪除了`Student`表內的學生，他們的`sID`在資料庫內仍未被刪除

```sql
delete from Apply
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);
```

要注意的是有些[[【技術】DBMS - Database Management System|DBMS]]並不接受刪除的表格`Apply`與sub-query查詢為同一個表格

2.刪除沒有被申請`CS`部門的學校

``` sql
/*** First see who will be deleted ***/
select * from College
where cName not in (select cName from Apply where major = 'CS');

/*** Then delete them ***/

delete from College
where cName not in (select cName from Apply where major = 'CS');
```

##### 更新資料

1. 把`Carnegie Mellon`學校的`GPA < 3.6`的學生，修改為`decision = 'Y', major = 'economics'`

``` sql
/*** First see who will be updated ***/

select * from 'Apply'
where cName = 'Carnegie Mellon'
  and sID in (select sID from Student where GPA < 3.6);

/*** Then update them ***/

update 'Apply'
set decision = 'Y', major = 'economics'
where cName = 'Carnegie Mellon'
  and sID in (select sID from Student where GPA < 3.6);
```

2. 將`EE`的申請者當中`GPA`最高的學生修改為申請`CSE`

``` sql
/*** First see who will be updated ***/

select * from Apply
where major = 'EE'
  and sID in
    (select sID from Student
     where GPA >= all
        (select GPA from Student
         where sID in (select sID from Apply where major = 'EE')));

/*** Then update them ***/

update Apply
set major = 'CSE'
where major = 'EE'
  and sID in
    (select sID from Student
     where GPA >= all
        (select GPA from Student
         where sID in (select sID from Apply where major = 'EE')));
```

3. 把所有學生的`GPA`與`HS`做修改

``` sql
--- Give everyone the highest GPA and smallest HS

update Student
set GPA = (select max(GPA) from Student),
    sizeHS = (select min(sizeHS) from Student);
```

4. 接受所有學生的申請

``` sql
update Apply
set decision = 'Y';
```

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V000700_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@vid-data_modification_statements/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@SQLModifications.pdf)
- [SQL Script](https://courses.edx.org/assets/courseware/v1/4278c5413e5a4ed9a198f8b01d49bf16/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block/SQLModifications.sql)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]