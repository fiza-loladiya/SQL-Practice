-- ============================================
-- CTE PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC CTE
-- =========================

-- 1. Write a CTE to show total orders for each customer, then display all rows.

with cte as 
(select customer_id, count(*) as total_orders from orders group by customer_id)
select * from cte;

-- 2. Write a CTE to show total spending for each customer, then display all rows.

with cte as 
(select customer_id, sum(total_amount) as total_Spending from orders group by customer_id)
select * from cte;

-- 3. Write a CTE to show average order amount for each customer, then display all rows.

with cte as
(select customer_id, avg(total_amount) as avg_amount from orders group by customer_id)
select * from cte;

-- 4. Write a CTE to show total products count in each category, then display all rows.

with cte as
(select category, count(*) as total_product from products group by category)
select * from cte;

-- 5. Write a CTE to show average product price by category, then display all rows.

with cte as 
(select category, avg(price) as avg_price from products group by category)
select * from cte;

-- 6. Write a CTE to show total stock quantity by brand, then display all rows.

with cte as
(select brand, sum(stock_qty) as total_qty from products group by brand)
select * from cte;

-- 7. Write a CTE to show total orders by order_status, then display all rows.

with cte as
(select order_status, count(*) as total_orders from orders group by order_status)
select * from cte;

-- 8. Write a CTE to show total payment count by payment_method, then display all rows.

with cte as
(select payment_method, count(*) as payment_count from payments group by payment_method)
select * from cte;

-- 9. Write a CTE to show total amount_paid by payment_status, then display all rows.

with cte as
(select payment_status, sum(amount_paid) as total_amount from payments group by payment_status)
select * from cte;

-- 10. Write a CTE to show total revenue by product_id using order_items, then display all rows.

with cte as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from cte;

-- =========================
-- LEVEL 2: BASIC FILTERING WITH CTE
-- =========================

-- 11. Write a CTE to show total spending by customer, then display only customers whose total spending is greater than 10000.

with cte as 
(select customer_id, sum(total_amount) as total_Spend from orders group by customer_id)
select * from cte where total_Spend > 10000;

-- 12. Write a CTE to show total orders by customer, then display only customers with more than 3 orders.

with cte as
(select customer_id, count(*) as total_order from orders group by customer_id)
select * from cte where total_order  > 3;

-- 13. Write a CTE to show average product price by category, then display only categories where average price is greater than 2000.

with cte as
(select category, avg(price) as avg_price from products group by category)
select * from cte where avg_price > 2000;

-- 14. Write a CTE to show total stock by brand, then display only brands whose total stock is greater than 500.

with cte as 
(select brand, sum(stock_qty) as total_stock from products group by brand)
select * from cte where total_Stock > 500;

-- 15. Write a CTE to show total orders by status, then display only statuses having more than 50 orders.

with cte as
(select order_status, count(*) as total_orders from orders group by order_status)
select * from cte where total_orders > 50;

-- 16. Write a CTE to show total refunded payments by order_id, then display only orders that have refunded payments.

with cte as
(select order_id, sum(amount_paid) as total_refunded from payments where payment_status = 'refunded'
group by order_id)
select * from cte;

-- 17. Write a CTE to show total paid amount by order_id, then display only orders whose paid amount is greater than 5000.

with cte as
(select order_id, sum(amount_paid) as total_paid from payments
group by order_id)
select * from cte where total_paid > 5000;


-- 18. Write a CTE to show total quantity sold by product_id, then display only products whose total quantity sold is greater than 5.

with cte as
(
    select product_id, sum(quantity) as total_qty_sold
    from order_items
    group by product_id
)
select * from cte
where total_qty_sold > 5;

-- 19. Write a CTE to show total revenue by product_id, then display only products whose revenue is greater than 10000.

with cte as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from cte where revenue > 10000;

-- 20. Write a CTE to show total customers by state, then display only states having more than 5 customers.

with cte as
(select state, count(*) as total_customer from customers group by state)
select * from cte where total_customer > 5;

-- =========================
-- LEVEL 3: CTE + JOIN BACK TO REAL TABLES
-- =========================

-- 21. Write a CTE to show total orders by customer_id, then join it with customers table to show customer name and total orders.

with x as (select customer_id, count(*) total_orders from orders group by customer_id),
     y as (select customer_id, first_name, last_name from customers)
select customer_id,first_name, last_name, total_orders from x join y using(customer_id);

-- 22. Write a CTE to show total spending by customer_id, then join it with customers table to show customer name and total spending.

with x as(select customer_id, sum(total_amount) as total_spending from orders group by customer_id),
     y as(select customer_id, first_name, last_name from customers)
select customer_id,first_name, last_name, total_spending from x join y using(customer_id);

-- 23. Write a CTE to show average order amount by customer_id, then join it with customers table to show city and average order amount.

with x as(select customer_id, avg(total_amount) as avg_spending from orders group by customer_id),
     y as(select customer_id, city from customers)
select city, avg_spending from x join y using(customer_id);

-- 24. Write a CTE to show total revenue by product_id, then join it with products table to show product_name and revenue.

with x as(select product_id, sum(line_total) as revenue from order_items group by product_id),
     y as(select product_id, product_name from products)
select product_name, revenue from x join y using(product_id);

-- 25. Write a CTE to show total quantity sold by product_id, then join it with products table to show product_name and quantity sold.

with x as(select product_id, sum(quantity) as sold_qty from order_items group by product_id),
     y as(select product_id, product_name from products)
select product_name, sold_qty from x join y using (product_id);

-- 26. Write a CTE to show total stock by brand, then join it with products table to display brand and product_name.

with cte as 
(select brand, sum(stock_qty) as total_stock from products group by brand)
select p.brand,p.product_name,cte.total_Stock from products p join cte on p.brand=cte.brand;
     
-- 27. Write a CTE to show total revenue by category, then display category and revenue from the outer query.

with cte as
(select p.category, sum(oi.line_total) as revenue from products p join order_items oi using (product_id)
group by p.category)
select * from cte;

-- 28. Write a CTE to show total revenue by state using customers and orders, then display state and revenue.

with cte as
(select c.state, sum(o.total_amount) as revenue from customers c join orders o using (customer_id)
group by c.state)
select * from cte;

-- 29. Write a CTE to show total revenue by city using customers and orders, then display city and revenue.

with cte as
(select c.city, sum(o.total_amount) as revenue from customers c join orders o using (customer_id)
group by c.city)
select * from cte;


-- 30. Write a CTE to show total refunded amount by order_id, then join it with orders table to show order_date and refunded amount.

with cte as
(
    select order_id, sum(amount_paid) as refunded_amount
    from payments
    where payment_status = 'refunded'
    group by order_id
)
select o.order_date, cte.refunded_amount
from cte
join orders o
using (order_id);

-- =========================
-- LEVEL 4: CTE WITH TOP / BOTTOM LOGIC
-- =========================

-- 31. Write a CTE to show total spending by customer, then find the customer(s) with the highest total spending.

with cte as (
    select c.customer_id, c.first_name, c.last_name,
           sum(o.total_amount) as total_spending
    from customers c
    join orders o using (customer_id)
    group by c.customer_id, c.first_name, c.last_name
)
select *
from cte
where total_spending = (select max(total_spending) from cte);

-- 32. Write a CTE to show total spending by customer, then find the customer(s) with the lowest total spending.

with cte as (
    select c.customer_id, c.first_name, c.last_name,
           sum(o.total_amount) as total_spending
    from customers c
    join orders o using (customer_id)
    group by c.customer_id, c.first_name, c.last_name
)
select *
from cte
where total_spending = (select min(total_spending) from cte);

-- 33. Write a CTE to show average price by category, then find the category with the highest average price.

with cte as (
    select category, avg(price) as avg_price
    from products
    group by category
)
select *
from cte
where avg_price = (select max(avg_price) from cte);

-- 34. Write a CTE to show average price by category, then find the category with the lowest average price.

with cte as (
    select category, avg(price) as avg_price
    from products
    group by category
)
select *
from cte
where avg_price = (select min(avg_price) from cte);

-- 35. Write a CTE to show total quantity sold by product_id, then find the product(s) with the highest quantity sold.

with cte as (
    select p.product_id, p.product_name, sum(oi.quantity) as sold_qty
    from order_items oi
    join products p using (product_id)
    group by p.product_id, p.product_name
)
select *
from cte
where sold_qty = (select max(sold_qty) from cte);

-- 36. Write a CTE to show total quantity sold by product_id, then find the product(s) with the lowest quantity sold.

with cte as (
    select p.product_id, p.product_name, sum(oi.quantity) as sold_qty
    from order_items oi
    join products p using (product_id)
    group by p.product_id, p.product_name
)
select *
from cte
where sold_qty = (select min(sold_qty) from cte);

-- 37. Write a CTE to show total revenue by brand, then find the brand with the highest revenue.

with cte as (
    select p.brand, sum(oi.line_total) as revenue
    from order_items oi
    join products p using (product_id)
    group by p.brand
)
select *
from cte
where revenue = (select max(revenue) from cte);

-- 38. Write a CTE to show total revenue by brand, then find the brand with the lowest revenue.

with cte as (
    select p.brand, sum(oi.line_total) as revenue
    from order_items oi
    join products p using (product_id)
    group by p.brand
)
select *
from cte
where revenue = (select min(revenue) from cte);

-- 39. Write a CTE to show total revenue by city, then find the city with the highest revenue.

with cte as (
    select c.city, sum(o.total_amount) as revenue
    from customers c
    join orders o using (customer_id)
    group by c.city
)
select *
from cte
where revenue = (select max(revenue) from cte);

-- 40. Write a CTE to show total customers by state, then find the state with the highest number of customers.

with cte as (
    select state, count(*) as total_customers
    from customers
    group by state
)
select *
from cte
where total_customers = (select max(total_customers) from cte);

-- =========================
-- LEVEL 5: INTERVIEW-STYLE CTE
-- =========================

-- 41. Write a CTE to show total spending by customer_id, then display only customers whose spending is above the average spending of all customers in that CTE.

with x as (
    select customer_id, sum(total_amount) as total_spend
    from orders
    group by customer_id
)
select *
from x
where total_spend > (select avg(total_spend) from x);

-- 42. Write a CTE to show total revenue by product_id, then display only products whose revenue is above the average product revenue.

with x as (
	 select product_id, sum(line_total) as revenue 
     from order_items
     group by product_id
)
select *
from x
where revenue > (select avg(revenue) from x);

-- 43. Write a CTE to show total orders by customer_id, then display only customers whose total orders are above the average customer order count.

with x as 
(Select customer_id, count(*) as total_orders from orders group by customer_id)
select *
from x
where total_orders > (Select avg(total_orders) from x);

-- 44. Write a CTE to show total revenue by category, then display only categories whose revenue is above the average category revenue.

with x as (
    select p.category, sum(oi.line_total) as revenue
    from products p
    join order_items oi using (product_id)
    group by p.category
)
select *
from x
where revenue > (select avg(revenue) from x);


-- 45. Write a CTE to show total paid amount by payment_method, then display only methods whose total paid amount is above the average across methods.


with x as (
    select payment_method, sum(amount_paid) as total_paid
    from payments
    group by payment_method
)
select *
from x
where total_paid > (select avg(total_paid) from x);

-- 46. Write a CTE to show total spending by city, then display only cities whose spending is below the average city spending.

with x as (
    select c.city, sum(o.total_amount) as total_spending
    from customers c
    join orders o using (customer_id)
    group by c.city
)
select *
from x
where total_spending < (select avg(total_spending) from x);

-- 47. Write a CTE to show monthly sales using YEAR(order_date) and MONTH(order_date), then display only months with sales greater than 20000.

with x as (
    select year(order_date) as yr,
           month(order_date) as mn,
           sum(total_amount) as total_sales
    from orders
    group by year(order_date), month(order_date)
)
select *
from x
where total_sales > 20000;

-- 48. Write a CTE to show monthly order counts, then find the month with the highest order count.

with x as (
    select year(order_date) as yr,
           month(order_date) as mn,
           count(*) as order_count
    from orders
    group by year(order_date), month(order_date)
)
select *
from x
where order_count = (select max(order_count) from x);

-- 49. Write a CTE to show profit by product_id using line_total - (quantity * cost_price), then display only products whose profit is greater than 5000.

with x as (
    select oi.product_id,
           sum(oi.line_total - (oi.quantity * p.cost_price)) as profit
    from order_items oi
    join products p using (product_id)
    group by oi.product_id
)
select *
from x
where profit > 5000;

-- 50. Write a CTE to show total spending by customer_id, then join it to customers table and display only the top 10 highest spenders.

with x as (
    select customer_id, sum(total_amount) as total_spending
    from orders
    group by customer_id
)
select c.customer_id, c.first_name, c.last_name, x.total_spending
from x
join customers c using (customer_id)
order by x.total_spending desc
limit 10;