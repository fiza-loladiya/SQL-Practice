-- ============================================
-- MIXED SUBQUERY INTERVIEW PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: EASY MIXED
-- =========================

-- 1. Find products whose price is greater than the average price of all products.

select * from products where price > (select avg(price) from products);

-- 2. Find customers who have placed at least one order.

select * from customers c where exists 
(select 1 from orders o where o.customer_id = c.customer_id);

-- 3. Find customers who have never placed any order.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id);

-- 4. Find orders whose total_amount is equal to the maximum total_amount.

select * from orders where total_amount = (select max(total_amount) from orders);

-- 5. Find products that were never ordered.

select * from products p where not exists
(select 1 from order_items oi, orders o where oi.product_id = p.product_id and oi.order_id = o.order_id);

-- 6. Find orders that have at least one Paid payment.

select * from orders where order_id = any
(select order_id from payments where payment_status = 'paid');

-- 7. Find customers who placed at least one order in 2025.

select * from customers c where exists
(select 1 from orders o where o.customer_id = c.customer_id and year(o.order_date) = 2025);

-- 8. Find products whose stock_qty is less than the average stock_qty of products in the same category.

select * from products p where stock_qty <
(select avg(stock_qty) from products where category = p.category);

-- 9. Find orders that do not have any payment record.

select * from orders o where not exists
(Select 1 from payments p where p.order_id = o.order_id); 

-- 10. Find customers who have at least one delivered order.

select * from customers where customer_id =  any
(select customer_id from orders where order_status = 'delivered');

-- =========================
-- LEVEL 2: CORE INTERVIEW STYLE
-- =========================

-- 11. Find products whose price is greater than ALL product prices from the Books category.

select * from products p where price > all (select price from products where category = 'books');

-- 12. Find customers who have made at least one UPI payment.

select * from customers c where exists
(select 1 from orders o, payments p where o.customer_id = c.customer_id and o.order_id = p.order_id and
payment_method = 'upi');

-- 13. Find orders that contain at least one product from the Electronics category.

select * from orders o where exists
(select 1 from order_items oi, products p where oi.order_id = o.order_id and oi.product_id = p.product_id and
p.category = 'Electronics');


-- 14. Find customers who have never purchased any product from the Beauty category.

select * from customers where customer_id not in (Select customer_id from orders where order_id in 
(select order_id from order_items where product_id in (select product_id from products where category = 'beauty')));

-- 15. Find products whose price is greater than the average price of products from the same brand.

select * from products p where price > (select avg(price) from products where brand = p.brand);

-- 16. Find the most expensive product(s) in each category.

select * from products p where price in (select max(price) from products where category = p.category);

-- 17. Find the latest order for each customer.

select * from orders o where order_date in (select max(order_date) from orders where customer_id = o.customer_id);

-- 18. Find customers whose total_amount in at least one order is greater than the average order amount of all orders.

select * from customers where customer_id = any (select customer_id from orders where total_amount > 
(select avg(total_amount) from orders));

-- 19. Find products that were sold in at least one delivered order.

select * from products where product_id in (select product_id from order_items where order_id in 
(select order_id from orders where order_status = 'delivered'));

-- 20. Find orders whose total_amount is greater than ANY cancelled order amount.

select * from orders where total_amount > any (select total_amount from orders where order_status = 'cancelled');

-- =========================
-- LEVEL 3: RELATIONSHIP THINKING
-- =========================

-- 21. Find customers who have at least one order with total_amount greater than 5000.

select * from customers where customer_id in (select customer_id from orders where total_amount > 5000);

-- 22. Find customers who do not have any order with total_amount greater than 5000.

select * from customers where customer_id not in (select customer_id from orders where total_amount > 5000);

-- 23. Find products purchased by at least one customer from Gujarat.

select * from products where product_id in (select product_id from order_items where order_id in
(select order_id from orders where customer_id in (select customer_id from customers where state = 'Gujarat')));

-- 24. Find products never purchased by any customer from Gujarat.

select * from products where product_id not in (select product_id from order_items where order_id in
(select order_id from orders where customer_id in (select customer_id from customers where state = 'Gujarat')));

-- 25. Find orders that have at least one order_item with line_total greater than 3000.

select * from orders where order_id in (select order_id from order_items where line_total > 3000);

-- 26. Find orders that do not have any order_item with line_total greater than 3000.

select * from orders where order_id not in (select order_id from order_items where line_total > 3000);

-- 27. Find customers who purchased at least one Books product.

select * from customers where customer_id in (Select customer_id from orders where order_id in 
(select order_id from order_items where product_id in (select product_id from products where category = 'books')));

-- 28. Find customers who never purchased any Books product.

select * from customers where customer_id not in (Select customer_id from orders where order_id in 
(select order_id from order_items where product_id in (select product_id from products where category = 'books')));

-- 29. Find customers who have at least one order with a Refunded payment.

select * from customers where customer_id in (select customer_id from orders where order_id in 
(select order_id from payments where payment_status = 'Refunded'));

-- 30. Find customers who have no orders with a Refunded payment.

select * from customers where customer_id not in (select customer_id from orders where order_id in 
(select order_id from payments where payment_status = 'Refunded'));


-- =========================
-- LEVEL 4: CORRELATED + AGGREGATE THINKING
-- =========================

-- 31. Find orders whose total_amount is greater than the average total_amount of the same customer.

select * from orders o where total_amount > (Select avg(total_amount) from orders where 
customer_id = o.customer_id);

-- 32. Find orders whose total_amount is less than the average total_amount of the same customer.

select * from orders o where total_amount < (Select avg(total_amount) from orders where 
customer_id = o.customer_id);

-- 33. Find the highest value order(s) for each customer.

select * from orders o where total_amount = (Select max(total_amount) from orders where customer_id = o.customer_id);

-- 34. Find the earliest signup customer(s) in each state.

select * from customers c where signup_date = (select min(signup_date) from customers where state = c.state);

-- 35. Find products whose stock_qty is greater than the average stock_qty in the same category.

select * from products p where stock_qty > (select avg(stock_qty) from products where category = p.category);

-- 36. Find payments whose amount_paid is greater than the average amount_paid for the same payment_method.

select * from payments p where amount_paid > (Select avg(amount_paid) from payments where
payment_method = p.payment_method);

-- 37. Find customers whose signup_date is earlier than the average signup_date of customers in the same city.

select * from customers c where signup_date < (select from_unixtime(avg(unix_timestamp(signup_Date))) from
customers where city = c.city);

-- 38. Find products whose price is less than the average price in the same category and same brand.

select * from products p where price < (Select avg(price) from products where category = p.category and
brand = p.brand);

-- 39. Find order_items whose quantity is greater than the average quantity for the same product_id.

select * from order_items oi where quantity > (select avg(quantity) from order_items where product_id =
oi.product_id);

-- 40. Find the cheapest product(s) in each brand.

select * from products p where price = (select min(price) from products where brand = p.brand);

-- =========================
-- LEVEL 5: HARDER INTERVIEW MIX
-- =========================

-- 41. Find customers who have at least one order containing both Electronics and Beauty products.

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM order_items
        WHERE product_id IN (
            SELECT product_id FROM products WHERE category = 'Electronics'
        )
    )
    AND order_id IN (
        SELECT order_id
        FROM order_items
        WHERE product_id IN (
            SELECT product_id FROM products WHERE category = 'Beauty'
        )
    )
);

-- 42. Find products whose price is greater than ALL unit_price values from order_items.

select * from products where price > all (select unit_price from order_items);

-- 43. Find orders whose total_amount is less than the average total_amount of delivered orders.

select * from orders where total_amount < (select avg(total_amount) from orders where order_status = 'delivered');

-- 44. Find customers who have placed orders only in 2025 and not in 2024.

select * from customers where customer_id in (select customer_id from orders where 
year(order_date) = 2025 ) and customer_id not in (select customer_id from orders where
year(order_date) = 2024 );

-- 45. Find customers who placed more than one order, where at least one order is Delivered.

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
)
AND customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_status = 'delivered'
);

-- 46. Find products that appear in orders whose payment_status is Refunded.

select * from products where product_id in (select product_id from order_items where order_id in
(select  order_id from orders where order_id in (select order_id from payments where payment_status = 'refunded')));

-- 47. Find customers who have made payments using both UPI and Credit Card.

select * from customers where customer_id in (select customer_id from orders where order_id in
(select order_id from payments where payment_method = 'upi') and customer_id in 
(select customer_id from orders where order_id in (select order_id from payments where payment_method = 
'credit card')));

-- 48. Find orders whose total_amount is greater than the average total_amount of orders from customers in the same state.

SELECT *
FROM orders o
WHERE total_amount > (
    SELECT AVG(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id IN (
        SELECT c2.customer_id
        FROM customers c2
        WHERE c2.state = (
            SELECT c1.state
            FROM customers c1
            WHERE c1.customer_id = o.customer_id
        )
    )
);

-- 49. Find customers who never purchased products from the Home category but purchased products from the Fashion category.

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM order_items
        WHERE product_id IN (
            SELECT product_id
            FROM products
            WHERE category = 'Fashion'
        )
    )
)
AND customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM order_items
        WHERE product_id IN (
            SELECT product_id
            FROM products
            WHERE category = 'Home'
        )
    )
);

-- 50. Find products whose price is greater than the average price of products that were actually sold at least once.

select * from products where price > (select avg(price) from products p where exists 
(select 1 from order_items oi,orders o where oi.product_id = p.product_id and oi.order_id = o.order_id));