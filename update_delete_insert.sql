## insert
SELECT * FROM my_movies.movies;

insert into movies
(title, industry, language_id)
values ("thor 2","Hollywood",5),
 ("thor 3","Hollywood",5),
 ("thor 4","Hollywood",5),
 ("thor 5","Hollywood",5);
 
 # update
 select * FROM my_movies.movies;
 
 update movies
 set
	studio ="Marvel Studios",
    release_year = 2025
    where
    movie_id = 141;
 
 # multiple line update
 select * FROM my_movies.movies;
 
update movies
set studio = "Marvel Studios"
    where title like "%thor%";
    
# for safer side you do not do wrong update it is better choice
select movie_id FROM movies where title like "%thor%";
    
    update movies
set studio = "Marvel Studios"
    where movie_id in (103,104,105,141,142,143,144,145);
	
 # delete
 select * FROM my_movies.movies;
 
 delete from movies
 where  movie_id in (141,144);
 
    