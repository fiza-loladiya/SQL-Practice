SELECT * FROM movies;

select count(*) from movies where release_year between 2015 and 2022;

select max(release_year), min(release_year) from movies;

select count(release_year), release_year from movies 
group by release_year order by release_year desc;

 select release_year, count(*) as movies_count 
   from movies group by release_year order by release_year desc