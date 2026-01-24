explain analyze
 select s.date,s.product_code,
 p.product,p.variant,s.sold_quantity as gross_price_per_item,
 g.gross_price,
round(g.gross_price * s.sold_quantity,2) as gross_price_total,
	pre.pre_invoice_discount_pct
 from fact_sales_monthly s
 join dim_product p
 on p.product_code=s.product_code
 join dim_date dt
 on dt.calendar_date = s.date 
join fact_gross_price g
on  g.product_code = s.product_code and 
g.fiscal_year = dt.fiscal_year
join fact_pre_invoice_deductions pre
on 
   pre.customer_code = s.customer_code and
   pre.fiscal_year = dt.fiscal_year
where  
     dt.fiscal_year= 2021  
limit 1000000;