-- Total orders per customer
select count(*) as total_orders,
       customer_id
from orders
group by customer_id;

with customers_order as 
(select count(*) as total_orders,
        customer_id
from orders
group by customer_id)
select * from customers_order;

-- Customers with more than 5 orders
select count(*) as total_orders, customer_id from orders group by customer_id having total_orders > 5;

with more_than_5 as
(select count(*) as total_orders, customer_id from orders group by customer_id having total_orders > 5)
select * from more_Than_5;

-- Total spending per customer
select customer_id, sum(total_amount) as total_spending from orders group by customer_id;

with total_Spending as 
(select customer_id, sum(total_amount) as total_spending from orders group by customer_id)
select * from total_spending;

-- Top spending customers
select customer_id, sum(total_amount) as total_spending from orders group by customer_id 
order by total_Spending desc;

with top_customers as 
(select customer_id, sum(total_amount) as total_spending from orders group by customer_id 
order by total_Spending desc)
select * from top_customers;

-- Average price by category
select category, avg(price) as avg_price from products group by category;

with cat_avg_price as
(select category, avg(price) as avg_price from products group by category)
select * from cat_avg_price ;

-- Categories with avg price above 2000
select category, avg(price) as avg_price from products group by category having avg_price > 2000;

with above_2000 as
(select category, avg(price) as avg_price from products group by category having avg_price > 2000)
select * from above_2000;

-- Revenue by product
select product_id, sum(line_total) as revenue from order_items group by product_id;

with product_revenue as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from product_revenue;

-- Products with revenue above 10000
select product_id, sum(line_total) as revenue from order_items group by product_id having revenue > 10000;

with above_rev as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from above_rev where revenue > 10000;

-- Join CTE with customer names

select customer_id, sum(total_amount) as total_Spent from orders group by customer_id;
select first_name, last_name from customers;

with total_Spent as 
(select customer_id, sum(total_amount) as total_Spent from orders group by customer_id),
customer_name as 
(select customer_id,first_name, last_name from customers)
select * from customer_name
join total_spent
using (customer_id);


-- Easy
-- Write a CTE to show total orders for each customer.

select customer_id, count(*) as total_orders from orders group by customer_id;

with total_orders as 
(select customer_id, count(*) as total_orders from orders  group by customer_id)
select * from total_orders;

-- Write a CTE to show total spending for each customer.

select customer_id, sum(total_amount) as total_spending from orders group by customer_id;

with total_Spending as
(select customer_id, sum(total_amount) as total_spending from orders group by customer_id)
select * from total_Spending;

-- Write a CTE to show average order amount by customer.

select customer_id, avg(total_amount) as avg_amount from orders group by customer_id;
with avg_order_amount as
(select customer_id, avg(total_amount) as avg_amount from orders group by customer_id)
select * from avg_order_amount;

-- Write a CTE to show total products in each category.

select category,count(*) as total_product from products group by category;
with total_product as
(select category,count(*) as total_product from products group by category)
select * from total_product;

-- Write a CTE to show average product price by category.

select category, avg(price) avg_price from products group by category;
with avg_pp_by_cat as
(select category, avg(price) avg_price from products group by category)
select * from avg_pp_by_cat;

-- Write a CTE to show total stock by brand.
select brand, sum(stock_qty) from products group by brand;
with total_stock as
(select brand, sum(stock_qty) from products group by brand)
select * from total_stock;

-- Write a CTE to show total orders by status.

select order_Status, count(*) as total_orders from orders group by order_status;
with total_orders as
(select order_Status, count(*) as total_orders from orders group by order_status)
select * from total_orders;

-- Write a CTE to show total payments by payment method.
select payment_method, sum(amount_paid) from payments group by payment_method;
with total_payments as
(select payment_method, sum(amount_paid) from payments group by payment_method)
select * from total_payments;

-- Write a CTE to show total paid amount by payment status.
select payment_status, sum(amount_paid) as total_amount from payments group by payment_status;
with total_paid as 
(select payment_status, sum(amount_paid) as total_amount from payments group by payment_status)
select * from total_paid;

-- Write a CTE to show total revenue by product_id.
select product_id, sum(line_total) as revenue from order_items group by product_id;
with total_revenue as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from total_revenue;


-- Medium

-- Show customers whose total spending is greater than 10000 using a CTE.
select customer_id, sum(total_amount) as total_spent from orders group by customer_id;
with total_spending as
(select customer_id, sum(total_amount) as total_spent from orders group by customer_id)
select * from total_Spending where total_spent > 10000;

-- Show customers with more than 3 orders using a CTE.
select customer_id, count(*) as total_order from orders group by customer_id;
with customer_order as
(select customer_id, count(*) as total_order from orders group by customer_id)
select * from customer_order where total_order > 3;

-- Show categories whose average price is above 2000 using a CTE.
select  category, avg(price) as avg_price from products group by category;
with avg_category as
(select  category, avg(price) as avg_price from products group by category)
select * from avg_category where avg_price > 2000;

-- Show products whose revenue is above 10000 using a CTE.
select product_id, sum(line_total) as revenue from order_items group by product_id;
with total_revenue as
(select product_id, sum(line_total) as revenue from order_items group by product_id)
select * from total_revenue where revenue > 10000;

-- Show brands whose total stock is above 500 using a CTE.
select brand, sum(stock_qty) as total_stock from products group by brand;
with total_Stock as
(select brand, sum(stock_qty) as total_stock from products group by brand)
select * from total_stock where total_stock > 500;

-- Better interview-style

/* Write a CTE for total spending by customer, then join it with customers table to show customer 
  name and spending. */
  select customer_id, sum(total_amount) as total_Spending from orders group by customer_id;
  select customer_id, first_name, last_name from customers;
with total_spend as
(select customer_id, sum(total_amount) as total_Spending from orders group by customer_id),
customer_name as
(select customer_id, first_name, last_name from customers)
select c.first_name, c.last_name, t.total_Spending from customer_name c
join total_Spend t
using (customer_id);

-- Write a CTE for product revenue, then join it with products table to show product name and revenue.

select product_id, sum(line_total) as revenue from order_items group by product_id;
select product_id, product_name from products;
with product_revenue as
(select product_id, sum(line_total) as revenue from order_items group by product_id),
product_name as
(select product_id, product_name from products)
select * from product_name join product_revenue using(product_id);

-- Write a CTE for state-wise sales, then show only states with sales above 30000.

select customer_id, sum(total_amount) as total_sales from orders group by customer_id;
select customer_id, state from customers;
with total_sales as
(select customer_id, sum(total_amount) as total_sales from orders group by customer_id),
state as
(select customer_id, state from customers)
select state, total_Sales from state join total_sales where total_Sales > 30000;

-- Write a CTE for order count by month, then sort highest to lowest.
select month(order_Date) as order_month, count(*) as total_order from orders group by order_month;
with order_count as
(select month(order_Date) as order_month, count(*) as total_order from orders group by order_month)
select * from order_count order by total_order desc;


-- Write a CTE for refunded payments by order, then show orders with refunded amount.
select payment_status, sum(amount_paid) as total_amount from payments group by payment_status;

with cte as 
(select payment_status, sum(amount_paid) as total_amount from payments group by payment_status)
select * from cte where payment_status = 'Refunded';