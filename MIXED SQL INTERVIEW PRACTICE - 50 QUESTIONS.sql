-- ============================================
-- MIXED SQL INTERVIEW PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC SQL + FILTERING
-- =========================

-- 1. Show all customers from Gujarat.

select * from customers where state = 'Gujarat';

-- 2. Show all products where price is greater than 2000.

select * from products where price > 2000;

-- 3. Show all orders placed in the year 2025.

select * from orders where year(order_Date) = 2025;

-- 4. Show all payments where payment_status is 'Paid'.

select * from payments where payment_status = 'paid';

-- 5. Show unique product categories from products table.

select distinct category from products;

-- 6. Show top 10 highest priced products.

select * from products order by price desc limit 10;

-- 7. Show customers whose first_name starts with 'A'.

select * from customers where first_name like 'A%';

-- 8. Show orders where total_amount is between 3000 and 7000.

select * from orders where total_amount between 3000 and 7000;

-- 9. Show products where brand is either 'Nova' or 'Aster'.

select * from products where brand in ('Nova', 'Aster');

-- 10. Show all orders sorted by order_date descending.

select * from orders order by order_date desc;

-- =========================
-- LEVEL 2: AGGREGATE + GROUP BY + HAVING
-- =========================

-- 11. Find total number of customers in each state.

select state, count(*) as total_number_of_customer from customers group by state;

-- 12. Find average product price by category.

select category, avg(price) as avg_price from products group by category;

-- 13. Find total sales by order_status.

select order_status, sum(total_amount) as total_Sales from orders group by order_status;

-- 14. Find total amount_paid by payment_method.

select payment_method, sum(amount_paid) as total_amount from payments group by payment_method;

-- 15. Find categories having average price greater than 2000.

select category, avg(price) as avg_price from products group by category having avg(price) > 2000;

-- 16. Find customers who placed more than 3 orders.

select customer_id, count(*) as total_orders from orders group by customer_id having total_orders > 3;

-- 17. Find brands having total stock_qty greater than 500.

select brand, sum(stock_qty) as total_stock from products group by brand having total_stock > 500;

-- 18. Find months having total sales greater than 20000.

SELECT YEAR(order_date) AS year_no,
       MONTH(order_date) AS month_no,
       SUM(total_amount) AS total_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
HAVING SUM(total_amount) > 20000;

-- 19. Find payment methods used more than 50 times.

select payment_method, count(*) as count from payments group by payment_method having count > 50;

-- 20. Find top 5 customers by total spending.

select customer_id, sum(total_amount) as total_Spend from orders group by customer_id order by total_spend 
desc limit 5;

-- =========================
-- LEVEL 3: JOIN PRACTICE
-- =========================

-- 21. Show each order with customer first_name, last_name, and total_amount.

select o.order_id,
       c.first_name,
       c.last_name,
       o.total_amount
from orders o
join customers c
using (customer_id);

-- 22. Show each order_item with product_name, category, quantity, and line_total.

select o.order_id,
       p.product_name,
       p.category,
       o.quantity,
       o.line_total
from order_items o
join products p
using (product_id);

-- 23. Show each payment with order_date, customer_id, payment_method, and amount_paid.

select p.payment_id,
       o.order_date,
       o.customer_id,
       p.payment_method,
       p.amount_paid
from payments p
join orders o
using (order_id);

-- 24. Show customer full name, order_id, order_date, and total_amount.

select concat(c.first_name," ",c.last_name) as full_name,
       o.order_id,
       o.order_date,
       o.total_amount
from orders o
join customers c
using (customer_id);

-- 25. Show product_name, category, and total quantity sold.

select p.product_name,
	   p.category,
       sum(o.quantity) as sold_qty
from products p
join order_items o
using (product_id)
group by p.category, p.product_name;

-- 26. Show city-wise total sales using customers and orders tables.

select c.city,
       sum(o.total_amount) as total_sales
from orders o
join customers c
using (customer_id)
group by c.city;

-- 27. Show state-wise total sales using customers and orders tables.

select c.state,
       sum(o.total_amount) as total_sales
from orders o
join customers c
using (customer_id)
group by c.state;

-- 28. Show category-wise total revenue using products and order_items tables.

select p.category,
       sum(o.line_total) as revenue
from products p
join order_items o
using (product_id)
group by category;

-- 29. Show brand-wise total quantity sold using products and order_items tables.

select p.brand,
       sum(o.quantity) as total_qty
from products p
join order_items o
using (product_id)
group by brand;

-- 30. Show orders that contain products from the Electronics category.

select o.*,
       p.category
from orders o
join order_items oi
using (order_id)
join products p 
using (product_id)
where p.category = 'Electronics';

-- =========================
-- LEVEL 4: SUBQUERY PRACTICE
-- =========================

-- 31. Find products whose price is greater than the average product price.

select * from products where price > (select avg(price) from products);

-- 32. Find customers who have never placed any order.

select * from customers where customer_id not in (select customer_id from orders);

-- 33. Find orders whose total_amount is equal to the maximum total_amount.

select * from orders where total_amount = (Select max(total_amount) from orders);

-- 34. Find products that were never sold.

select * from products where product_id not in (select product_id from order_items);

-- 35. Find customers who have at least one delivered order.

select * from customers where customer_id = any (select customer_id from orders where order_status = 'delivered');

-- 36. Find products whose price is greater than the average price of products in the same category.

select * from products p1 where price > (Select avg(price) from products p2 where p1.category = p2.category);

-- 37. Find customers who have made at least one UPI payment.

select * from customers where customer_id in (select customer_id from orders where order_id in
(select order_id from payments where payment_method = 'UPI'));

-- 38. Find orders that do not have any payment record.

select * from orders where order_id not in (select order_id from payments);

-- 39. Find the highest value order for each customer.

select *
from orders o1
where o1.total_amount = (
    select max(o2.total_amount)
    from orders o2
    where o2.customer_id = o1.customer_id
);

-- 40. Find customers who purchased at least one product from the Beauty category.

select * from customers where customer_id = any (select customer_id from orders where order_id in 
(select order_id from orders where order_id in (select order_id from order_items where product_id in
(select product_id from products where category  = 'Beauty'))));


-- =========================
-- LEVEL 5: CTE PRACTICE
-- =========================

-- 41. Write a CTE to calculate total spending by customer, then show only customers whose spending is greater than 10000.

with x as (select customer_id, sum(total_amount) as total_spending from orders group by customer_id)
select * from x where total_spending  > 10000; 

-- 42. Write a CTE to calculate total revenue by product_id, then join it with products table to show product_name and revenue.

with x as (select product_id, sum(line_total) as revenue from order_items group by product_id),
     y as (select product_id, product_name from products)
select y.product_name,
       x.revenue
from y 
join x
using (product_id);

-- 43. Write a CTE to calculate total orders by customer_id, then show customers with more than 3 orders.

with x as (select customer_id, count(*) as total_order from orders group by customer_id)
select * from x where total_order > 3;

-- 44. Write a CTE to calculate monthly sales, then display only months with sales greater than 20000.

with x as (select month(order_date), sum(total_amount) as sales from orders group by month(order_date))
select * from x where sales > 20000;

-- 45. Write a CTE to calculate category-wise average price, then find the category with the highest average price.

with x as (select category, avg(price) as avg_price from products group by category)
select * from x where avg_price = (select max(avg_price) from x);

-- =========================
-- LEVEL 6: WINDOW FUNCTION PRACTICE
-- =========================

-- 46. Show each order with total spending of that customer using SUM() OVER(PARTITION BY customer_id).

select *,
       sum(total_amount) over(partition by customer_id) as total_spend
from orders;

-- 47. Show each product with average price of its category using AVG() OVER(PARTITION BY category).

select *,
       avg(price) over(partition by category) as avg_price
from products;

-- 48. Show each order with ROW_NUMBER() for each customer based on order_date.

select *,
       row_number() over(partition by customer_id order by order_Date) as rownumber
from orders;

-- 49. Find the top 3 highest priced products in each category using ROW_NUMBER() or DENSE_RANK().

select * from (
select *,
       row_number() over(partition by category order by price desc) as top_3
from products)x
where top_3 <= 3;
       
	
-- 50. Show each order with previous order amount using LAG() over order_date.

SELECT *,
       LAG(total_amount) OVER (ORDER BY order_date) AS previous_order_amount
FROM orders;
