#common table exression
# "with" and "as" clause we use create CTE
with actor_age as
(select name,(year(curdate())-birth_year) 
as age from actors)
select name,age from actor_age
where age >70 and age <85;

#if we write column name outside the query it will be the real on and if write alternative
# name inside using as it will not respornd to that
with actor_age (actor_name,age) as
(select name,(year(curdate())-birth_year) 
 from actors)
select actor_name,age from actor_age
where age >70 and age <85;

# movies that produces 500% profit or more and 
#their rating was less than avg rating for all movies

select * from financials;

select *, ((revenue-budget)*100/budget) 
as profit_pct from financials
where (revenue-budget)*100/budget >= 500;

select avg(imdb_rating) as avg_movie from movies;

select x.movie_id,x.profit_pct,
	   y.title, y.imdb_rating
 from (select *, ((revenue-budget)*100/budget) 
as profit_pct from financials
) x
join (select * from movies 
  where imdb_rating < (select avg(imdb_rating) from movies)) y
on  x.movie_id = y.movie_id
where (revenue-budget)*100/budget >= 500;

# CTE

with 
	x as (select *, ((revenue-budget)*100/budget) as profit_pct from financials),
	y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select 
    x.movie_id,x.profit_pct,
	   y.title, y.imdb_rating
  from x   
  join  y 
   on  x.movie_id = y.movie_id
where (revenue-budget)*100/budget >= 500    

