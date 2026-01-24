SELECT 
	m.movie_id,title,budget,revenue,currency,unit, industry,
    case
		when unit ="billions" then round((revenue-budget)*1000,1)
        when unit = "thousands" then round((revenue-budget)/1000,1)
        else round(revenue-budget,1)
    end as profit_mln
    FROM movies m 
 join financials f on m.movie_id = f.movie_id   
    where industry= "bollywood"
    order by profit_mln desc;
    