select * from financials;

# Get All actors whose age is between 70 and 85

select name, age from 
(select name,
       year(curdate()) - birth_year as age
from actors) as actor_age
where age between 70 and 85;

with actor_age as (select name, year(curdate())- birth_year as age from actors)
select name, age from actor_age where age between 70 and 85;

# Movies that produced 500% or more profit and their rating was less than average rating of all the movies

select *, revenue-budget*100/(budget) as profit from financials where revenue-budget*100/(budget) > 500;

select * from movies where imdb_rating < (select avg(imdb_rating) from movies);

with profit as (select *, revenue-budget*100/(budget) as profit from financials 
                where revenue-budget*100/(budget) > 500),
     avg_rating as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select p.profit, a.imdb_Rating from profit p
join avg_rating a
using (movie_id);

-- Select all Hollywood movies released after the year 2000 that made more than 500 million $ profit or 
-- more profit. Note that all Hollywood movies have millions as a unit hence you don't need to do 
-- the unit conversion. Also, you can write this query without CTE as well but you should try to 
-- write this using CTE only

select * from movies where industry = 'Hollywood' and release_year > 2000;
select *, revenue-budget*100/(budget) as profit from financials where revenue-budget*100/(budget) > 500;

with x as (select * from movies where industry = 'Hollywood' and release_year > 2000),
	 y as (select *, revenue-budget*100/(budget) as profit from financials where 
     revenue-budget*100/(budget) > 500)
select x.industry,x.release_year,y.profit from x
join y 
using (movie_id);