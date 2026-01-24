SELECT * FROM movies where imdb_rating >=9;
SELECT * FROM movies where imdb_rating >=5 and	imdb_rating<=9;
SELECT * FROM movies where imdb_rating between 5 and 8;
SELECt * from movies where release_year = 2019 or release_year =2020;
select * from movies where release_year in(2019,2018,2019);
select * from movies where industry in ("hollywood","bollywood");
select * from movies where imdb_rating is Null;
select * from movies where imdb_rating is not Null;
select * from movies where industry = "bollywood" order by imdb_rating desc;
select * from movies where industry = "bollywood" order by imdb_rating desc limit 5; 
select * from movies where industry = "bollywood" order by imdb_rating desc limit 5 offset 1;
##we are using offset to get the 2nd or any value we want and number start with 0,1**