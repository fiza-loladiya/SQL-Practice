# movie  with highest imdb_rating

SELECT * FROM movies
order by imdb_rating
desc limit 1;
##sub query it return a single value
select * from movies 
where imdb_rating= (SELECT max(imdb_rating) FROM movies);

# sub query it will retrun a list of values

select * from movies
where imdb_rating  in ((select max(imdb_rating) from movies),
(select min(imdb_rating) from movies))
;

# sub query returns a table or number of rows
# select all the actor whose age >70 and <85

## in this where is exicuted first and age later 
select *,(year(curdate()) - birth_year) as age from actors
where age > 70 and age < 85;  ##wrong it will not work
### conculsion having will work only in some mysql + it is not standard sql and bad practice
select name,(year(curdate()) - birth_year) as age from actors
having age > 70 and age < 85;

### this is the correct way 
select * from
(select name,(year(curdate()) - birth_year) as age from actors) as actor_age
 where age >70 and age <85;
