-- ============================================
-- MULTI-ROW SUBQUERY PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC IN / NOT IN
-- =========================

-- 1. Find customers who placed at least one order.

select * from customers where customer_id in 
(select customer_id from orders);

-- 2. Find customers who never placed any order.

select * from customers where customer_id not in
(select customer_id from orders where customer_id is not null);

-- 3. Find products that were ordered at least once.

select * from products where product_id in
(select product_id from order_items where product_id is not null);

-- 4. Find products that were never ordered.

select * from products where product_id not in
(Select product_id from order_items where product_id is not null);

-- 5. Find orders that have at least one payment record.

select * from orders where order_id in 
(select order_id from payments where order_id is not null);

-- 6. Find orders that do not have any payment record.

select * from orders where order_id not in
(select order_id from payments where order_id is not null);

-- 7. Find customers who placed at least one delivered order.

select * from customers where customer_id in 
(select customer_id from orders where order_status = 'delivered');

-- 8. Find customers who placed at least one cancelled order.

select * from customers where customer_id in
(select customer_id from orders where order_status = 'cancelled');

-- 9. Find customers who placed at least one returned order.

select * from customers where customer_id in
(select customer_id from orders where order_status = 'returned');

-- 10. Find orders whose payment status is Paid.

select * from orders where order_id in
(Select order_id from payments where payment_status = 'paid');

-- 11. Find orders whose payment status is Refunded.

select * from orders where order_id in
(select order_id from payments where payment_status = 'refunded');

-- 12. Find orders whose payment status is Pending.

select * from orders where order_id in
(select order_id from payments where payment_status = 'pending');

-- 13. Find customers who made at least one payment using UPI.

select * from customers where customer_id in (select customer_id from orders where order_id in
(select order_id from payments where payment_method = 'upi'));

-- 14. Find customers who made at least one payment using Credit Card.

select * from customers where customer_id in (select customer_id from orders where order_id in
(select order_id from payments where payment_method = 'credit card'));

-- 15. Find products that appear in order_items with quantity greater than 2.

select * from products where product_id in
(select product_id from order_items where quantity > 2);

-- =========================
-- LEVEL 2: BASIC FILTERED MULTI-ROW
-- =========================

-- 16. Find customers who placed orders in the year 2024.

select * from customers where customer_id in 
(select customer_id from orders where year(order_date) = 2024);

-- 17. Find customers who placed orders in the year 2025.

select * from customers where customer_id in 
(select customer_id from orders where year(order_date) = 2025);

-- 18. Find customers who placed orders with total_amount greater than 5000.

select * from customers where customer_id in
(select customer_id from orders where total_amount > 5000);

-- 19. Find customers who placed orders with total_amount less than 1000.

select * from customers where customer_id in 
(select customer_id from orders where total_amount < 1000);

-- 20. Find products that were sold in delivered orders.

select * from products where product_id in
(select product_id from order_items where order_id in (select order_id from orders where order_status='delivered'));

-- 21. Find products that were sold in cancelled orders.

select * from products where product_id in (select product_id from order_items where order_id in (select
order_id from orders where order_status = 'cancelled'));

-- 22. Find products that were sold in returned orders.

select * from products where product_id in 
(select product_id from order_items where order_id in (select order_id from orders where order_status = 'returned'));

-- 23. Find customers who ordered products from the Electronics category.
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
            WHERE category = 'electronics'
        )
    )
);

-- 24. Find customers who ordered products from the Fashion category.
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
            WHERE category = 'fashion'
        )
    )
);

-- 25. Find customers who ordered products from the Books category.
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
            WHERE category = 'books'
        )
    )
);

-- 26. Find orders that contain products from the Beauty category.
SELECT *
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM order_items
    WHERE product_id IN (
        SELECT product_id
        FROM products
        WHERE category = 'beauty'
    )
);

-- 27. Find orders that contain products from the Home category.
SELECT *
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM order_items
    WHERE product_id IN (
        SELECT product_id
        FROM products
        WHERE category = 'home'
    )
);

-- 28. Find customers who purchased products with price greater than 2000.
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
            WHERE price > 2000
        )
    )
);

-- 29. Find customers who purchased products with stock_qty greater than 100.
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
            WHERE stock_qty > 100
        )
    )
);

-- 30. Find products that were purchased by customers from Gujarat.
SELECT *
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
    WHERE order_id IN (
        SELECT order_id
        FROM orders
        WHERE customer_id IN (
            SELECT customer_id
            FROM customers
            WHERE state = 'gujarat'
        )
    )
);

-- =========================
-- LEVEL 3: NOT IN PRACTICE
-- =========================

-- 31. Find customers who never placed a delivered order.

select * from customers where customer_id not in
(select customer_id from orders where order_status = 'delivered');

-- 32. Find customers who never placed a cancelled order.

select * from customers where customer_id not in
(select customer_id from orders where order_status = 'cancelled');

-- 33. Find customers who never made a UPI payment.

select * from customers where customer_id not in
(select customer_id from orders where order_id in (select order_id from payments where payment_method =  'UPI'));

-- 34. Find products that were never sold in delivered orders.

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
    WHERE order_id IN (
        SELECT order_id
        FROM orders
        WHERE order_status = 'delivered'
    )
);

-- 35. Find products that were never sold in cancelled orders.

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
    WHERE order_id IN (
        SELECT order_id
        FROM orders
        WHERE order_status = 'cancelled'
    )
);

-- 36. Find orders that do not have any refunded payment.

select * from orders where order_id not in
(select order_id from payments where payment_status = 'refunded');

-- 37. Find orders that do not have any pending payment.

select * from orders where order_id not in
(select order_id from payments where payment_status = 'pending');

-- 38. Find customers who never bought Electronics products.

select * from customers where customer_id not in
(select customer_id from orders where order_id in (select order_id from order_items where product_id in
(select product_id from products where category = 'electronics')));

-- 39. Find customers who never bought Fashion products.

select * from customers where customer_id not in
(select customer_id from orders where order_id in (select order_id from order_items where product_id in
(select product_id from products where category = 'fashion')));

-- 40. Find customers who never bought Books products.

select * from customers where customer_id not in
(select customer_id from orders where order_id in (select order_id from order_items where product_id in
(select product_id from products where category = 'books')));

-- 41. Find products that were never purchased by customers from Maharashtra.

select * from products where product_id not in
(select product_id from order_items where order_id in (select order_id from orders where customer_id in 
(select customer_id from customers where state = 'maharashtra')));

-- 42. Find customers who never placed an order in 2025.

select * from customers where customer_id not in
(select customer_id from orders where year(order_date) = 2025);

-- 43. Find customers who never placed an order in 2024.

select * from customers where customer_id not in
(select customer_id from orders where year(order_date) = 2024);

-- 44. Find orders that do not contain any product from the Beauty category.

select * from orders where order_id not in
(Select order_id from order_items where product_id in (select product_id from products where category = 'beauty'));

-- 45. Find orders that do not contain any product from the Home category.

SELECT *
FROM orders
WHERE order_id NOT IN (
    SELECT order_id
    FROM order_items
    WHERE product_id IN (
        SELECT product_id
        FROM products
        WHERE category = 'home'
    )
);

-- =========================
-- LEVEL 4: MEDIUM MULTI-ROW THINKING
-- =========================

-- 46. Find customers who placed orders whose order_id exists in payments with payment_method = 'UPI'.

select * from customers where customer_id in
(select customer_id from orders where order_id in (select order_id from payments where payment_method = 'UPI'));

-- 47. Find customers who placed orders whose order_id exists in payments with payment_status = 'Refunded'.

select * from customers where customer_id in
(select customer_id from orders where order_id in (select order_id from payments where payment_status = 'Refunded'));

-- 48. Find products whose product_id appears in order_items belonging to orders with total_amount greater than the average order amount.

select * from products where product_id in
(select product_id from order_items where order_id in (select  order_id from orders where total_amount > (select avg(total_amount) from orders)));

-- 49. Find customers whose customer_id appears in orders where order_status is in ('Delivered', 'Shipped').

select * from customers
where customer_id in (
    select customer_id
    from orders
    where order_status in ('Delivered', 'Shipped')
);

-- 50. Find orders whose order_id appears in order_items for products whose category is in ('Electronics', 'Beauty').

select * from orders where order_id in 
(Select order_id from order_items where product_id in (select product_id from products where category in ('Electronics', 'Beauty')));