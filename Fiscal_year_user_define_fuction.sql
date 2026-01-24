SELECT * FROM gdb0041.fact_sales_monthly;


select * from fact_sales_monthly 
where 
	customer_code = "90002002" and
year (DATE_ADD(date, INTERVAL 4 Month))= 2021
    order by date desc;

#using our new create funciton 
 select * from fact_sales_monthly 
where 
	customer_code = "90002002" and
     get_fiscal_year(date)= 2021
    order by date asc   
    