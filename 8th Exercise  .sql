# Select all Hollywood movies released after the year 2000 that made more than 500 million $ 
# profit or more profit. Note that all Hollywood movies have millions as a unit hence 
# you don't need to do the unit conversion. Also, you can write this query without CTE 
# as well but you should try to write this using CTE only
select * from movies;

select * from movies where release_year >2000 and industry = "Hollywood";

select *, ((revenue-budget)*100/budget) as profit_pct from financials 
where ((revenue-budget)*100/budget )>500 ;


# join
 select x.release_year,x.movie_id,x.title,
        y.profit_pct 
 from (select * from movies where release_year >2000 and industry = "Hollywood") x
 
 join (select *, ((revenue-budget)*100/budget) as profit_pct from financials 
where ((revenue-budget)*100/budget )>500) y

on x.movie_id =y.movie_id;

#CTE(common table expression)

with 
	x as	(select * from movies where release_year >2000 and industry = "Hollywood"),
    y as   (select *, ((revenue-budget)*100/budget) as profit_pct from financials )
 
   select  
   x.release_year,x.movie_id,x.title,
        y.profit_pct
from x
join y
on	x.movie_id=y.movie_id
   where (revenue-budget)*100/budget >500;
   
  # CTE profit
	
with 
	x as	(select * from movies where release_year >2000 and industry = "Hollywood"),
    y as   (select *, (revenue-budget) as profit from financials )
 
   select  
   x.release_year,x.movie_id,x.title,
        y.profit
from x
join y
on	x.movie_id=y.movie_id
   where profit >500	;

## solution
	with cte as (select title, release_year, (revenue-budget) as profit
			from movies m
			join financials f
			on m.movie_id=f.movie_id
			where release_year>2000 and industry="hollywood"
	)
	select * from cte where profit>500;
    

    
    