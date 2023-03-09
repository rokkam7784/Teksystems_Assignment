-- 1
create database if not exists olympics_db;
use olympics_db;

-- 2
drop table olympics_tbl;
create table if not exists olympics_tbl(
	ID int,	
	Name varchar(50),	
    Sex varchar(50),	
    Age int,	
    Height int,	
    Weight int,	
    Team varchar(50),	
    NOC varchar(50),	
    Games varchar(50),	
    Year int,	
    Season varchar(50),	
    City varchar(50),	
    Sport varchar(50),	
    Event varchar(50),	
    Medal varchar(50)
);


-- 3
SET SQL_SAFE_UPDATES = 0;
LOAD DATA LOCAL INFILE 'FILEPATH'
INTO TABLE olympics_tbl
fields TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows; 

-- 4


-- 5

-- 6
select season,count(team) teamsPlaying from olympics_tbl group by season;

-- 7 
select distinct sport from olympics_tbl;

-- 8 
select Games,count(distinct name) from olympics_tbl where season like "S%" group by games order by games;

-- 9 
select games,season,count(distinct event) from olympics_tbl group by games,season order by games;

-- 10
select name,sport,count(name) from olympics_tbl group by name,sport order by count(name) desc;

-- 11
select distinct name,age from olympics_tbl order by age desc limit 10;

-- 12
select distinct name,weight from olympics_tbl order by weight desc limit 10;

-- 13 
select distinct name,age from olympics_tbl where age is not null and medal like "G%" order by age limit 10;

-- 14
select distinct name,weight from olympics_tbl where medal like "G%" order by weight desc limit 10;

-- 15 
select distinct name,weight from olympics_tbl where  weight is not null and medal like "G%" order by weight  limit 10;

-- 16 
select 
	t1.name,count(t1.medal) as medals,t2.goldMedals,t3.silverMedals,t4.BronzeMedals from olympics_tbl as t1  
	left join (select name,count(medal) as goldMedals from olympics_tbl  where medal like "G%" group by name) t2 on t1.name = t2.name 
    left join (select name,count(medal) as silverMedals from olympics_tbl  where medal like "S%" group by name) t3 on t1.name = t3.name
    left join (select name,count(medal) as BronzeMedals from olympics_tbl  where medal like "B%" group by name) t4 on t1.name = t4.name
    group by t1.name,goldMedals,silverMedals,BronzeMedals order by medals desc limit 10;
    
-- 17 
select 
	t1.team,count(t1.medal) as medals,t2.goldMedals,t3.silverMedals,t4.BronzeMedals from olympics_tbl as t1  
	left join (select team,count(medal) as goldMedals from olympics_tbl  where medal like "G%" group by team) t2 on t1.team = t2.team 
    left join (select team,count(medal) as silverMedals from olympics_tbl  where medal like "S%" group by team) t3 on t1.team = t3.team
    left join (select team,count(medal) as BronzeMedals from olympics_tbl  where medal like "B%" group by team) t4 on t1.team = t4.team
    group by t1.team,goldMedals,silverMedals,BronzeMedals order by medals desc limit 10;
select team,medal,count(medal) from olympics_tbl where medal is not null group by team,medal;
select team,medal,count(medal) from (select team,medal,count(medal) from olympics_tbl 
where medal is not null group by team,medal) as t group by team,medal;

-- 18 

select year,team, count(medal) as medalsWon from olympics_tbl group by year,team order by year asc,team asc,medalsWon desc;

select year,count(medal) as TotalMedals from olympics_tbl group by year;

select t1.year,t1.team,count(t1.medal) as medalsWon,TotalMedals,(count(t1.medal)/TotalMedals)*100 as percent from olympics_tbl as t1
join (select year,count(medal) as TotalMedals from olympics_tbl group by year) as t2 on t1.year = t2.year
group by t1.year,t1.team 
order by 
percent desc
-- ,t1.year asc,t1.team asc
limit 5;

-- 19 
with temporaryTable(totalMedals) as (select count(medal) from olympics_tbl)
select distinct team
-- ,totalMedals,count(medal)
,(count(medal)/totalMedals)*100 as percent from olympics_tbl,temporaryTable 
where team in ("China","United States","Russia","Australia","Great Britain")
group by team,totalMedals order by percent desc;
