# select the actor id, actor name and the total number of movies they acted in.
## we can get the output by join and group by but here we will use sub query
# co-related sub query
select actor_id, name,
(select count(*) from movie_actor 
where actor_id = a.actor_id) as Movies_count
 from actors a
order by Movies_count desc
 ;

