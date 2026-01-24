##Show all the movies with their language names
SELECT  movies.language_id,title,name
FROM movies
join languages
on movies.language_id = languages.language_id;

##Show all Telugu movie names (assuming you don't know the language id for Telugu)

SELECT title	FROM movies m 
   LEFT JOIN languages l 
   ON m.language_id=l.language_id
   WHERE l.name="Telugu";
 
 ## Show the language and number of movies released in that languag
 
 select l.name, count(m.movie_id) as mov
from movies m
join languages l
on m.language_id=l.language_id
 group by l.name 
 order by mov desc; 
 
	SELECT 
            l.name, 
            COUNT(m.movie_id) as no_movies
	FROM languages l
	LEFT JOIN movies m USING (language_id)        
	GROUP BY language_id
	ORDER BY no_movies DESC;
