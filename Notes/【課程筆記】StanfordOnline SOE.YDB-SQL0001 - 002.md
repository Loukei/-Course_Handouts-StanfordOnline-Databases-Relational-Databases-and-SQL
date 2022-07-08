---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# StanfordOnline SOE.YDB-SQL0001 - 002

## The Relational Model

Databse = set of named **relations**(or **table**)
Each **relation** has a set of named **attributes**(or **cloums**)
Each **tuple**(or **row**) has a value for each attributes 

**enumerated domain** - 列舉域，比如用英文縮寫來表示50州

**Schema** - structural description of relations in database
**Instance** - actual contents at given point in time

**NULL** - special value for “unknown” or “undefined”
**Key** - attribute whose value is unique in each tuple
Or set of attributes whose combined values are unique

## Note

簡述關聯式模型: 資料庫、table、schema、

- 關聯式模型的簡介
	- Database: a set of relations(table)
		- table: a set of named attributes(column), to describe the object or relation between 2 or more objects
			- attribute
				- **name** of data: ex: "user_name", "phone_number"
				- data type: ex: "integer", "varchar"
				- data range: ex: people's age is an unsigned integer about 0~200
				- data value
					- **NULL** is a unique value that describe "undefined" or "unknowed"
			- key: a attribute that can identify the entity in table, which means if attribute is a key, than you can't find any 2 row have same key value in this table. ex: "user_id" is used to identify those
			- foreign key: 當一個table裡面的實體需要參照外部的實體時

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V001100_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@22ef98f921294e93b227f34ca0e7e030/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@RelationalModel__1_.pdf)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]