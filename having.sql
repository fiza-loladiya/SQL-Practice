SELECT * FROM moviesdb.movies;

select release_year, count(*) as movies_count from movies 

group by release_year
having movies_count > 2 
order by release_year desc

### this is how it executed 

from >> where >> group by >>> having >>> order by

## having same work as "where" and having mostly used with group by 
## but it can be use alone and also the colum we are using it should be there in select or define