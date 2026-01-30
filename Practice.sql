use gdb0041;
/* As a product owner, I want to generate a report of individual product sales (aggregated on month basis at
 the product code level) for croma Indian customer for FY = 2021 so that i can track individual product
 sales and run further product analytics on it is in excel.
 1. Month
 2. Product Name
 3. Variant
 4. Sold Quantity
 5. Gross Price Per Item
 6. Gross Price Total */
 select * from dim_product;
 select * from dim_customer where customer = "Croma" and market = "India";
 select * from fact_sales_monthly where customer_code = 90002002 and 
 YEAR(DATE_ADD(DATE, INTERVAL 4 MONTH)) = 2021 order by date desc;

 SELECT YEAR(DATE_ADD(DATE, INTERVAL 4 MONTH)); 
 
 select fs.date,fs.product_code,
		dp.product,dp.variant,fs.sold_quantity,
        fg.gross_price, round((fg.gross_price*fs.sold_quantity),2) as total_gross_price
 from fact_sales_monthly fs
 join dim_product dp
 on fs.product_code=dp.product_code
 join fact_gross_price fg
 on 
	fs.product_code = fg.product_code and 
    fg.fiscal_year = get_fiscal_year(fs.date)
 where 
	customer_code = 90002002 and 
	get_fiscal_year(date) = 2021
 order by date desc;
 
 select * from fact_gross_price;
 select * from fact_sales_monthly;
 select 
	get_fiscal_year(date) as fiscal_year,
    sum(fs.sold_quantity*fg.gross_price) as total_amount
 from fact_gross_price fg
 join fact_sales_monthly fs
 on fg.fiscal_year = get_fiscal_year(fs.date) and 
	fg.product_code = fs.product_code
where fs.customer_code = 90002002 
group by get_fiscal_year(fs.date)
order by fiscal_year; 


USE gdb0041;
select 
	s.date,
    sum(round(s.sold_quantity*g.gross_price,2)) as monthly_sales
from fact_sales_monthly  s
join fact_gross_price g
	on g.fiscal_year=get_fiscal_year(s.date)
    and g.product_code=s.product_code
where
	customer_code = 90002002
group by date;
