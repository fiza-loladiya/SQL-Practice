-- 20 aggregate window function practice questions
-- Basic

-- Show each order with total sales of all orders.

select order_id,
       sum(total_amount) over(partition by order_id) as total_sales
from orders;

-- Show each order with total spending of that customer.

select order_id,
       customer_id,
	   sum(total_amount) over(partition by customer_id) as total_Spending
from orders;

-- Show each order with average order amount of that customer.

select order_id,
       customer_id,
       avg(total_amount) over(partition by customer_id) as avg_order_amount
from orders;

-- Show each order with total number of orders by that customer.

select order_id,
	   customer_id,
       count(*) over(partition by customer_id) as num_orders
from orders;

-- Show each product with average price of its category.

select product_name, 
       category,
       avg(price) over(partition by category) as avg_price
from products;

-- Show each product with minimum price in its category.

select product_name, 
       category,
       min(price) over(partition by category) as min_price
from products;

-- Show each product with maximum price in its category.

select product_name, 
       category,
       max(price) over(partition by category) as max_price
from products;

-- Show each payment with total payments of that payment method.

select payment_id,
       payment_method,
       sum(amount_paid) over(partition by payment_method) as total_payment
from payments;

-- Show each payment with average payment amount by payment method.

select payment_id,
       payment_method,
       avg(amount_paid) over(partition by payment_method) as avg_payment
from payments;

-- Show each customer with total number of customers in same state.

select customer_id,
       state,
       count(*) over(partition by state) as total_customer
from customers;

-- Running / cumulative

-- Show running total of sales by order date.

select order_date,
       sum(total_amount) over(order by order_date) as running_total
from orders;

-- Show running total of sales for each customer by order date.

select customer_id,
       order_date,
       sum(total_amount) over(partition by customer_id order by order_date) as running_total
from orders;

-- Show running count of orders for each customer.

select order_id,
       customer_id,
	   count(*) over(partition by customer_id order by order_date) as count_of_orders
from orders;

-- Show running average of order amount by order date.

select order_id,
       order_date,
       avg(total_amount) over(order by order_date) as avg_order_amount
from orders;

-- Show running total of refunded payments by payment date.

select payment_id,
       payment_status,
       payment_date,
       sum(amount_paid) over(order by payment_date) as running_total
from payments
where payment_status = 'refunded';

-- Better interview style

-- Show each order and compare it with customer average order amount.

select order_id,
	   customer_id,
	   total_amount,
	   avg(total_amount) over(partition by customer_id) as avg_amount
from orders;

-- Show each product and compare it with category average price.

select product_id,
       product_name,
       category,
       price,
       avg(price) over(partition by category) as avg_price
from products;

-- Show each payment and compare it with payment method average amount.

select payment_id,
       payment_method,
       amount_paid,
       avg(amount_paid) over(partition by payment_method) as avg_amount
from payments;

-- Show each order with customer total, customer average, and customer order count in same result.

select order_id,
       customer_id,
       sum(total_amount) over(partition by customer_id) as customer_total,
       avg(total_amount) over(partition by customer_id) as customer_avg,
       count(*) over(partition by customer_id) customer_order
from orders;

-- Show each product with category min price, max price, and average price in same result.

select product_id,
	   category,
       min(price) over(partition by category) as min_price,
	   max(price) over(partition by category) as max_price,
       avg(price) over(partition by category) as avg_price
from products;