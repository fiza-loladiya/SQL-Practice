-- ============================================
-- AGGREGATE WINDOW FUNCTION PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC OVER()
-- =========================

-- 1. Show each order with total sales of all orders using SUM() OVER().

select *,
       sum(total_amount) over() as total_Sales
from orders;

-- 2. Show each order with average order amount of all orders using AVG() OVER().

select *,
       avg(total_amount) over() as avg_amount
from orders;

-- 3. Show each order with total number of orders using COUNT() OVER().

select *,
       count(*) over() as total_number_of_orders
from orders;

-- 4. Show each product with average price of all products using AVG() OVER().

select *,
       avg(price) over() as avg_price
from products;

-- 5. Show each product with minimum price of all products using MIN() OVER().

select *,
      min(price) over() as min_price
from products;

-- 6. Show each product with maximum price of all products using MAX() OVER().

select *,
      max(price) over() as max_Price
from products;

-- 7. Show each payment with total amount_paid of all payments using SUM() OVER().

select *,
       sum(amount_paid) over() as total_paid_amount
from payments;

-- 8. Show each payment with average amount_paid of all payments using AVG() OVER().

select *,
       avg(amount_paid) over() as avg_paid_amount
from payments;

-- 9. Show each customer with total number of customers using COUNT() OVER().

select *,
       count(*) over() as total_num_customer
from customers;

-- 10. Show each order_item with average line_total of all order_items using AVG() OVER().

select *,
      avg(line_total) over() as avg_line_total
from order_items;

-- =========================
-- LEVEL 2: PARTITION BY PRACTICE
-- =========================

-- 11. Show each order with total spending of that customer using SUM() OVER(PARTITION BY customer_id).

select order_id,
	   customer_id,
       sum(total_amount) over(partition by customer_id) as total_spending
from orders;

-- 12. Show each order with average order amount of that customer using AVG() OVER(PARTITION BY customer_id).

select order_id,
       customer_id,
       avg(total_amount) over(partition by customer_id) as avg_amount
from orders;

-- 13. Show each order with total number of orders by that customer using COUNT() OVER(PARTITION BY customer_id).

select order_id,
       customer_id,
       count(*) over(partition by customer_id) as num_orders
from orders;

-- 14. Show each product with average price of its category using AVG() OVER(PARTITION BY category).

select product_id,
	   category,
	   avg(price) over(partition by category) as avg_price
from products;

-- 15. Show each product with minimum price in its category using MIN() OVER(PARTITION BY category).

select product_id,
       category,
       min(price) over(partition by category) as min_price
from products;

-- 16. Show each product with maximum price in its category using MAX() OVER(PARTITION BY category).

select product_id,
       category,
       max(price) over(partition by category) as max_price
from products;

-- 17. Show each product with total number of products in the same category using COUNT() OVER(PARTITION BY category).

select product_id,
	   category,
	   count(*) over(partition by category) as total_product
from products;

-- 18. Show each payment with total amount_paid by payment_method using SUM() OVER(PARTITION BY payment_method).

select payment_id,
       payment_method,
       sum(amount_paid) over(partition by payment_method) as total_amount_paid
from payments;

-- 19. Show each payment with average amount_paid by payment_method using AVG() OVER(PARTITION BY payment_method).

select payment_id,
       payment_method,
       avg(amount_paid) over(partition by payment_method) as avg_amount_paid
from payments;

-- 20. Show each payment with total number of payments by payment_status using COUNT() OVER(PARTITION BY payment_status).

select payment_id,
       payment_status,
       count(*) over(partition by payment_status) as total_number_payments
from payments;

-- =========================
-- LEVEL 3: MORE PARTITION PRACTICE
-- =========================

-- 21. Show each customer with total number of customers in the same state using COUNT() OVER(PARTITION BY state).

select customer_id,
	   state,
       count(*) over(partition by state) as total_customer
from customers;

-- 22. Show each customer with total number of customers in the same city using COUNT() OVER(PARTITION BY city).

select customer_id,
	   city,
       count(*) over(partition by city) as total_customer
from customers;


-- 23. Show each product with average cost_price by brand using AVG() OVER(PARTITION BY brand).

select product_id,
       product_name,
       brand,
       avg(cost_price) over(partition by brand) as avg_cost_price
from products;

-- 24. Show each product with maximum stock_qty by category using MAX() OVER(PARTITION BY category).

select product_id,
       product_name,
       max(stock_qty) over(partition by category) as max_stock_qty
from products;

-- 25. Show each product with minimum stock_qty by brand using MIN() OVER(PARTITION BY brand).

select product_id,
       product_name,
       min(stock_qty) over(partition by brand) as min_stock_qty
from products;

-- 26. Show each order with total shipping_fee collected by that customer using SUM() OVER(PARTITION BY customer_id).

select order_id,
	   customer_id,
	   sum(shipping_fee) over(partition by customer_id) as total_shipping
from orders;

-- 27. Show each order with average discount_amount by order_status using AVG() OVER(PARTITION BY order_status).

select order_id,
       order_status,
       avg(discount_amount) over(partition by order_status) as avg_discount_amount
from orders;

-- 28. Show each order with total number of orders in the same order_status using COUNT() OVER(PARTITION BY order_status).

select order_id,
	   order_status,
       count(*) over(partition by order_status) as total_number_of_orders
from orders;

-- 29. Show each payment with minimum amount_paid in the same payment_method using MIN() OVER(PARTITION BY payment_method).

select payment_id,
	   payment_method,
	   min(amount_paid) over(partition by payment_method) as minimum_amount_paid
from payments;

-- 30. Show each payment with maximum amount_paid in the same payment_status using MAX() OVER(PARTITION BY payment_status).

select payment_id,
	   payment_status,
	   max(amount_paid) over(partition by payment_status) as maximum_amount_paid
from payments;

-- =========================
-- LEVEL 4: RUNNING / CUMULATIVE WINDOW AGGREGATES
-- =========================

-- 31. Show each order with running total of sales by order_date using SUM() OVER(ORDER BY order_date).

select order_id,
       order_date,
       sum(total_amount) over(order by order_date) as total_running_sales
from orders;

-- 32. Show each order with running average of total_amount by order_date using AVG() OVER(ORDER BY order_date).

select order_id,
	   order_date,
       avg(total_amount) over(order by order_date) as running_amount
from orders;

-- 33. Show each order with running count of orders by order_date using COUNT() OVER(ORDER BY order_date).

select order_id,
       order_date,
       count(*) over(order by order_date) as runnig_count
from orders;

-- 34. Show each payment with running total of amount_paid by payment_date using SUM() OVER(ORDER BY payment_date).

select payment_id,
	   payment_date,
       sum(amount_paid) over(order by payment_date) as running_total_amount
from payments;

-- 35. Show each payment with running average of amount_paid by payment_date using AVG() OVER(ORDER BY payment_date).

select payment_id,
       payment_date,
	   avg(amount_paid) over(order by payment_date) as running_avg_amount
from payments;

-- 36. Show each order with running total of sales for each customer by order_date using SUM() OVER(PARTITION BY customer_id ORDER BY order_date).

select order_id,
       customer_id,
       order_date,
       sum(total_amount) over(partition by customer_id order by order_date) as running_total_sale
from orders;

-- 37. Show each order with running average of total_amount for each customer by order_date using AVG() OVER(PARTITION BY customer_id ORDER BY order_date).

select order_id,
       customer_id,
       order_date,
       avg(total_amount) over(partition by customer_id order by order_date) as avg_running_total
from orders;

-- 38. Show each order with running count of orders for each customer by order_date using COUNT() OVER(PARTITION BY customer_id ORDER BY order_date).

select order_id,
       customer_id,
       order_date,
       count(*) over(partition by customer_id order by order_date) as running_count
from orders;

-- 39. Show each payment with running total of amount_paid for each payment_method by payment_date using SUM() OVER(PARTITION BY payment_method ORDER BY payment_date).

select payment_id,
       payment_method,
       sum(amount_paid) over(partition by payment_method order by payment_date) as running_total_amount
from payments;

-- 40. Show each payment with running count of payments for each payment_method by payment_date using COUNT() OVER(PARTITION BY payment_method ORDER BY payment_date).

select payment_id,
       payment_method,
       count(*) over(partition by payment_method order by payment_date) as count_of_payment
from payments;

-- =========================
-- LEVEL 5: INTERVIEW-STYLE AGGREGATE WINDOW QUESTIONS
-- =========================

-- 41. Show each order with customer total spending, customer average order amount, and customer order count in the same result.

select order_id,
       customer_id,
       sum(total_amount) over(partition by customer_id) as customer_total_spending,
       avg(total_amount) over(partition by customer_id) as customer_avg_order_amount,
       count(*) over(partition by customer_id) as customer_order_count
from orders;

-- 42. Show each product with category average price, category minimum price, and category maximum price in the same result.

select product_id,
       category,
       avg(price) over(partition by category) as avg_price,
       min(price) over(partition by category) as min_price,
       max(price) over(partition by category) as max_price
from products;

-- 43. Show each payment with payment_method total amount, payment_method average amount, and payment_method payment count in the same result.

select payment_id,
       payment_method,
       sum(amount_paid) over(partition by payment_method) as total_amount,
       avg(amount_paid) over(partition by payment_method) as avg_amount,
       count(*) over(partition by payment_method) as count
from payments;

-- 44. Show each order and also display the difference between total_amount and average order amount of that customer.

select order_id,
       customer_id,
       avg(total_amount) over(partition by customer_id) as avg_amount,
       total_amount - avg(total_amount) over(partition by customer_id) as difference
from orders;

-- 45. Show each product and also display the difference between price and average price of its category.

select product_id,
       category,
       avg(price) over(partition by category) as avg_price,
        price - avg(price) over(partition by category) as difference
from products;

-- 46. Show each payment and also display the difference between amount_paid and average amount_paid of that payment_method.

select payment_id,
       payment_method,
       avg(amount_paid) over(partition by payment_method) as avg_amount,
	   amount_paid - avg(amount_paid) over(partition by payment_method) as difference
from payments;

-- 47. Show each order with overall sales, customer sales, and running sales by order_date in the same result.

select order_id,
       customer_id,
       order_date,
       sum(total_amount) over() as overall_sales,
       sum(total_amount) over(partition by customer_id) as customer_sales,
       sum(total_amount) over(order by order_date) as running_total
from orders;
       
-- 48. Show each product with overall average price, category average price, and brand average cost_price in the same result.

select product_id,
       category,
       brand,
       avg(price) over() as overall_avg,
       avg(price) over(partition by category) as cat_avg_price,
       avg(cost_price) over(partition by brand) as brand_cost_price
from products;

-- 49. Show each order_item with total revenue by product_id, average line_total by product_id, and count of rows by product_id in the same result.

select order_id,
       product_id,
       sum(line_total) over(partition by product_id) as total_revenue,
       avg(line_total) over(partition by product_id) as avg_line_total,
       count(*) over(partition by product_id) as count_of_rows
from order_items;

-- 50. Show each customer row with count of customers in same city, count of customers in same state, and total customers overall in the same result.

select customer_id,
       city,
       state,
       count(*) over(partition by city) as city_customer_count,
       count(*) over(partition by state) as state_customer_count,
       count(*) over() as total_customer
from customers;