SELECT max(imdb_rating), title FROM movies where industry="bollywood" ;
select min(imdb_rating), title from movies where industry= "bollywood";
select avg(imdb_rating), title from movies where industry= "bollywood";
select  round(avg(imdb_rating),3) as avg, title from movies ;
select industry, count(*) from movies group by industry;
select * from movies;
select max(imdb_rating) as MAX, min(imdb_rating) as MIN, round(avg(imdb_rating),2) as avg
 from movies where studio="Marvel Studios";
select *  from movies;
select studio,count(*) as cnt from movies group by studio order by cnt desc;
select industry,count(industry), avg(imdb_rating) from movies group by industry;

select studio, count(studio) as cnt, round(avg(imdb_rating),1) as avg from movies 
where studio != ""
group by studio order by avg desc;

