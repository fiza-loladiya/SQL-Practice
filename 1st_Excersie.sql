##Excersie##
select title,release_year from movies where studio = "Marvel Studios";
select *  from movies where title like "%Avengers%" ;
select release_year from movies where title like "%The Godfather%";
select distinct(studio) from movies where industry= "bollywood";