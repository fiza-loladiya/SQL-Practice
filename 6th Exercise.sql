SELECT 
 title,revenue,currency,unit ,
 case
	when unit= "billions" then round(revenue*1000,1)
    when unit = "thousand" then round(revenue/1000,1)
    else round(revenue,1)
 end as revenue_mil
 FROM 
movies m
join languages l on  m.language_id =l.language_id
join financials f on m.movie_id= f.movie_id 
where l.name= "hindi"
order by revenue_mil desc
;