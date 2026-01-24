SELECT title, group_concat(name separator " | " ) as actor	 
FROM 
movies m
join movie_actor ma on ma.movie_id= m.movie_id
join actors a on ma.actor_id= a.actor_id
group by m.movie_id;

select a.name, 
group_concat( m.title separator " | " ) as movies
, count(m.title) as movie_count
from 
actors a
join movie_actor ma on ma.actor_id=a.actor_id
join movies m on ma.movie_id=m.movie_id
group by a.actor_id
order by movie_count desc;