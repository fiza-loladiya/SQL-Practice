-- Show each order with total spending of that customer.

select order_id,
	   customer_id,
       sum(total_amount) over(partition by customer_id) as total_Spend
from orders;

-- Show each product with average price of its category.

select product_name,
       category,
       avg(price) over(partition by category) as avg_price
from products;

-- Show each customer order with count of orders by that customer.

select order_id,
       customer_id,
       count(*) over(partition by customer_id) as total_orders
from orders;

-- Show running total of sales by order date.

SELECT order_date,
       SUM(SUM(total_amount)) OVER (ORDER BY order_date) AS running_total
FROM orders
GROUP BY order_date;

-- Show running total of sales by customer.

select customer_id,
	   sum(total_amount) over(order by customer_id) as running_total
from orders;