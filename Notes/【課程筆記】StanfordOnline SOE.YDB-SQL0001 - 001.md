---
create_date: 2022-07-05
tags: []	
aliases:
privacy: No
notetype: "Course_Note"
course_code: "StanfordOnline SOE.YDB-SQL0001"
course_name: "Relational Databases and SQL"
---

# StanfordOnline SOE.YDB-SQL0001 - 001

Ch1. Introduction and Relational Databases

## Databases Introduction

- [[【技術】DBMS - Database Management System|DBMS]]優點
	- Massive
		- Hand **large** amout of data(In TB a day), those data are much bigger than memory can handled.
	- Persistent
		- Data is outlives in the program.
	- Safe
		- Data won't be lost if program(like Banking System) failures or hardware failures, power outages, user mistake, etc.
	- Multi-user
		- Data can be operating in multiple user and program system.
		- [concurrency control](https://zh.wikipedia.org/zh-tw/%E5%B9%B6%E5%8F%91%E6%8E%A7%E5%88%B6)
			- 及時糾正同時賣出一張票的錯誤機制
	- Convenient
		- Physical data indenpendence
			- Program don't care the physical data storage place, it could be store in many harddrive.
			- The operatcion in data is independant to data is laid out.
		- High-level query language
			- SQL
	- Efficient
		- Thousand of queries/updates per second.
	- Reliable

- Key concepts
	- Data model
		- Set of records, xml, graph model
	- Schema vs data
		- Types
	- Data definition language(DDL)
	- Data manipulation or query language(DML)

- key people
	- DBMS implementer
		- Building system
	- Database designer
		- Establishes schema
	- Database application developer
		- program that operate a database
	- Database administractor
		- Loads data, keeps running smoothly

## Note

- 介紹DBMS的優點: 
	- 方便、有效率、可靠、安全、支援協作、可持續、處理大型檔案
- DBMS重要觀念
	- 資料模型、Schema、DDL、DML
- 施作資料庫的腳色
	- 建立資料庫系統
	- 設計資料庫綱要
	- 使用前者的系統做增刪查改
	- 維護資料庫系統的運行

## Materials

- [video](https://edx-video.net/StanfordOnlineSOE.YDB-SQL0001-V001200_DTH.mp4)
- [video_subtitles](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/xblock/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@video+block@137a1075e3b34f22bf7ccb89af4679f3/handler/transcript/download)
- [slides](https://courses.edx.org/asset-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@asset+block@CourseIntro.pdf)

## Course link

- [[【課程筆記】〔StanfordOnline〕Relational Databases and SQL]]