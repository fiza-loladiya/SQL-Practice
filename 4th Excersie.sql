
select *, (revenue-budget) as profit,
round(((revenue-budget)/budget)*100,2) as profit_perct  ,
(revenue-budget)*100/budget as profit_pct
from financials;
   
