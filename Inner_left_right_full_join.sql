##if we write join it is default consider as inner join
SELECT 
 m.movie_id,title,budget, revenue, currency, unit 
FROM movies m
join financials f
on f.movie_id=M.movie_id
;
## left join we are considering left side as movies 
select
m.movie_id,title,budget, revenue, currency, unit
from movies m
left join financials f
on f.movie_id = m.movie_id;
## right join  f.movie_id as it is right join as we need to show movie_id taking from right
select
f.movie_id,title,budget, revenue, currency, unit
from movies m
Right join financials f
on f.movie_id = m.movie_id;

# full join the no of column and column name should be same or it will give error

select 
m.movie_id,title,budget, revenue, currency, unit
 from movies m
 left JOIN financials f
 on f.movie_id= m.movie_id
 
  union
select 
f.movie_id,title,budget, revenue, currency, unit
 from movies m
 right JOIN financials f
 on f.movie_id= m.movie_id;

## "using" we can use using instead of on but column should have similar name
## we use brackit beacuse we can join more than two column ex:- using(movie_id,title)
select 
f.movie_id,title,budget, revenue, currency, unit
 from movies m
 right JOIN financials f
 using (movie_id);
 
 ## we use AND to use more table to join like
 
 #select 
#f.movie_id,title,budget, revenue, currency, unit
 #from movies m
 #right JOIN financials f
 #on m.movie_id=f.movie_id and table.columnname=table.columnname;