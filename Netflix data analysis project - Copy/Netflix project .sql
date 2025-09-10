-- analysis (1)

--1

select COUNT(title),type
from titles
group by type

--2

select AVG(imdb_score),title
from titles
where type = 'movie'
group by title

--3

select sum(imdb_votes),title
from titles
group by title
order by SUM(imdb_votes) desc

--4   

select *,* 
from credits,titles

--5

select COUNT(title),genres
from titles
group by genres

--6

select title,release_year,imdb_score
from titles
where imdb_score > 7
and release_year between 2000 and 2010
order by release_year asc

--7

select title,seasons
from titles
where seasons > 1

--8

select top 10 title,tmdb_popularity 
from titles
order by tmdb_popularity desc


-- Analysis-2
--1 

select c.name,COUNT(t.title)
from credits as c 
join titles as t 
on c.id=t.id
where c.role='ACTOR'
group by c.name
order by COUNT(t.title)

--2

select t.title, count(c.name) as no_of_people
from titles as t
left join credits as c
on t.id=c.id
group by t.title
order by no_of_people desc

--3 

select *
from titles
where imdb_score>7 and tmdb_score>7

--4

select production_countries,COUNT(title) as most
from titles
group by production_countries
order by most desc

--5 
select type, avg(runtime) as avg_runtime
from titles
group by type

--6

select title
from titles
where title like '%love%'

--7

select top 5 c.name, count(t.title) as no_of_titles
from credits as c
join titles as t
on c.id=t.id
where c.role='DIRECTOR'
group by c.name
order by no_of_titles desc

--8
select c.name, t.title, max(t.release_year) as recent
from credits as c
join titles as t
on c.id=t.id
where c.role='ACTOR'
group by c.name, t.title

-- Analysis 3

--1

select title,imdb_score
from titles
where imdb_score>(select AVG(imdb_score) from titles )

select title,imdb_score
from titles
where imdb_score > (
select AVG(imdb_score) from titles
)

--2

with counts as (
select role, COUNT(id) as role_count
from credits
group by role
)
select top 1 ROle,role_count from counts
order by role_count desc 

--3

select title,runtime
from ( 
select top 4 *
from titles
where type='movie'
order by runtime desc
) as top_3

--4

with score as (
select title,imdb_score
from titles
where imdb_score >9)
select top 3 title,imdb_score from score
order by imdb_score desc 

--5

select t.release_year,t.title
from titles as t 
join credits as c 
on t.id=c.id
where t.release_year=2020
and c.role='actor'

--6

with types_avg as (
	select type, avg(imdb_score) as avg_imdb_score
	from titles
	group by type
	having avg(imdb_score) > 6
	)
select type, avg_imdb_score
from types_avg

--7

select t.id,t.id,COUNT(c.person_id) as person_count
from titles as t 
left join credits as c
on t.id=c.id
group by t.id,t.title
having COUNT(c.person_id)>3

--8

with actor_titles as (
    select name, id
    from credits
    where role = 'ACTOR'
	)
select name, count(distinct id) as unique_titles
from actor_titles
group by name
order by unique_titles desc