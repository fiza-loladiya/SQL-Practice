SELECT *,(revenue-budget) as Profit FROM financials;
## currency converstion 
select *,if(currency="USd", revenue * 77 , revenue) as revenue_INR from financials;
 ## if(condition,true,false)
 
 ## unit converstion 
 select * from financials;
 select *, 
 case 
			when unit = "billions" then revenue*1000
            when unit = "thousand" then revenue/1000
            else revenue
            end as revenue_millions
 from financials;
 
 
 