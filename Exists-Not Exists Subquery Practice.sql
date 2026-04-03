-- ============================================
-- EXISTS / NOT EXISTS SUBQUERY PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC EXISTS
-- =========================

-- 1. Find customers who have placed at least one order.

select * from customers c where exists 
(select 1 from orders o where o.customer_id = c.customer_id);

-- 2. Find products that appear in at least one order_item.

select * from products p where exists 
(select 1 from order_items o where o.product_id = p.product_id);

-- 3. Find orders that have at least one payment record.

select * from orders o where exists
(select 1 from payments p where p.order_id = o.order_id);

-- 4. Find customers who have at least one delivered order.

select * from customers c where exists 
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'delivered');

-- 5. Find customers who have at least one cancelled order.

select * from customers c where exists 
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'cancelled');

-- 6. Find customers who have at least one returned order.

select * from customers c where exists 
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'returned');

-- 7. Find orders that contain at least one product from the Electronics category.

SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM order_items oi, products p
    WHERE oi.product_id = p.product_id
      AND oi.order_id = o.order_id
      AND p.category = 'Electronics'
);

-- 8. Find orders that contain at least one product from the Fashion category.

select * from orders o where exists
(Select 1 from order_items oi, products p where oi.product_id = p.product_id and oi.order_id = o.order_id
and p.category = 'fashion');


-- 9. Find customers who have made at least one UPI payment.

select *
from customers c
where exists (
    select 1
    from orders o, payments p
    where o.order_id = p.order_id
      and o.customer_id = c.customer_id
      and p.payment_method = 'UPI'
);

-- 10. Find customers who have made at least one Credit Card payment.

select *
from customers c
where exists (
    select 1
    from orders o, payments p
    where o.order_id = p.order_id
      and o.customer_id = c.customer_id
      and p.payment_method = 'Credit Card'
);

-- 11. Find orders that have at least one payment with payment_status = 'Paid'.

select * from orders o where exists
(select 1 from payments p where payment_status = 'paid' and p.order_id = o.order_id);

-- 12. Find orders that have at least one payment with payment_status = 'Refunded'.

select * from orders o where exists
(select 1 from payments p where payment_status = 'refunded' and p.order_id = o.order_id);

-- 13. Find orders that have at least one payment with payment_status = 'Pending'.

select * from orders o where exists
(select 1 from payments p where payment_status = 'pending' and p.order_id = o.order_id);

-- 14. Find products that were sold in at least one delivered order.

select *
from products p
where exists (
    select 1
    from order_items oi, orders o
    where oi.order_id = o.order_id
      and oi.product_id = p.product_id
      and o.order_status = 'Delivered'
);

-- 15. Find customers who placed at least one order in 2025.

select * from customers c where exists
(select 1 from orders o where year(order_date) = 2025 and o.customer_id = c.customer_id);

-- =========================
-- LEVEL 2: BASIC NOT EXISTS
-- =========================

-- 16. Find customers who have never placed any order.

select * from customers c where not exists
(Select 1 from orders o where o.customer_id = c.customer_id);

-- 17. Find products that never appear in order_items.

select * from products p where not exists
(select 1 from order_items oi where oi.product_id = p.product_id);

-- 18. Find orders that do not have any payment record.

select * from orders o where not exists
(Select 2 from payments p where p.order_id = o.order_id);

-- 19. Find customers who have never placed a delivered order.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'delivered');

-- 20. Find customers who have never placed a cancelled order.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'cancelled');

-- 21. Find customers who have never placed a returned order.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id and order_status = 'returned');

-- 22. Find orders that do not contain any product from the Electronics category.

select * from orders o where not exists
(select 1 from order_items oi, products p where oi.order_id = o.order_id and oi.product_id = p.product_id
and p.category = 'electronics');

-- 23. Find orders that do not contain any product from the Fashion category.

select * from orders o where not exists
(select 1 from order_items oi, products p where oi.order_id = o.order_id and oi.product_id = p.product_id
and category = 'fashion');

-- 24. Find customers who have never made a UPI payment.

select * from customers c where not exists
(select 1 from orders o, payments p where o.customer_id = c.customer_id and o.order_id = p.order_id
and payment_method = 'upi');

-- 25. Find customers who have never made a Credit Card payment.

select * from customers c where not exists
(select 1 from orders o, payments p where o.customer_id = c.customer_id and o.order_id = p.order_id
and payment_method = 'credit card');

-- 26. Find orders that do not have any refunded payment.

select * from orders o where not exists
(select 1 from payments p where p.order_id = o.order_id and payment_status ='refunded');

-- 27. Find orders that do not have any pending payment.

select * from orders o where not exists
(select 1 from payments p where p.order_id = o.order_id and payment_status = 'pending');

-- 28. Find products that were never sold in a delivered order.

select * from products p where not exists
(select 1 from order_items oi, orders o where oi.product_id = p.product_id and oi.order_id = o.order_id
and order_status = 'delivered');

-- 29. Find customers who never placed any order in 2025.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id and year(order_date) = 2025);

-- 30. Find customers who never placed any order in 2024.

select * from customers c where not exists
(select 1 from orders o where o.customer_id = c.customer_id and year(order_date) = 2024);

-- =========================
-- LEVEL 3: FILTERED EXISTS / NOT EXISTS
-- =========================

-- 31. Find customers who have at least one order with total_amount greater than 5000.

select * from customers c where exists
(select 1 from orders o where o.customer_id = c.customer_id and o.total_amount > 5000);

-- 32. Find customers who do not have any order with total_amount greater than 5000.

select * from customers c where not exists
(Select 1 from orders o where o.customer_id = c.customer_id and o.total_amount > 5000);

-- 33. Find products that appear in at least one order_item with quantity greater than 2.

select * from products p where exists
(select 1 from order_items oi where oi.product_id = p.product_id and oi.quantity > 2);

-- 34. Find products that never appear in any order_item with quantity greater than 2.

select * from products p where not exists
(select 1 from order_items oi where oi.product_id = p.product_id and oi.quantity > 2);

-- 35. Find orders that contain at least one product with price greater than 2000.

select * from orders o where exists
(select 1 from order_items oi, products p where oi.order_id = o.order_id and oi.product_id = p.product_id
and price > 2000);

-- 36. Find orders that do not contain any product with price greater than 2000.

select * from orders o where  not exists
(select 1 from order_items oi, products p where oi.order_id = o.order_id and oi.product_id = p.product_id
and price > 2000);

-- 37. Find customers who have purchased at least one product from the Books category.

select * from customers c where exists
(select 1 from orders o, order_items oi, products p where o.customer_id = c.customer_id and oi.order_id = o.order_id and
oi.product_id = p.product_id and p.category = 'book');

-- 38. Find customers who have never purchased any product from the Books category.

select * from customers c where not exists
(select 1 from orders o, order_items oi, products p where o.customer_id = c.customer_id and oi.order_id = o.order_id and
oi.product_id = p.product_id and p.category = 'book');

-- 39. Find customers who have purchased at least one product from the Beauty category.

select * from customers c where exists
(select 1 from orders o, order_items oi, products p where o.customer_id = c.customer_id and oi.order_id = o.order_id and
oi.product_id = p.product_id and p.category = 'beauty');

-- 40. Find customers who have never purchased any product from the Beauty category.

select * from customers c where not exists
(select 1 from orders o, order_items oi, products p where o.customer_id = c.customer_id and oi.order_id = o.order_id and
oi.product_id = p.product_id and p.category = 'beauty');

-- =========================
-- LEVEL 4: EXISTS / NOT EXISTS WITH MULTI-TABLE THINKING
-- =========================

-- 41. Find customers who have at least one order that also has a Paid payment.

select * from customers c where exists
(select 1 from orders o, order_items oi, payments p where o.customer_id = c.customer_id and oi.order_id = o.order_id
and oi.order_id = p.order_id and p.payment_status = 'paid');

-- 42. Find customers who have at least one order that also has a Refunded payment.

select * from customers c where exists
(select 1 from orders o, order_items oi, payments p where o.customer_id = c.customer_id and oi.order_id = o.order_id
and oi.order_id = p.order_id and p.payment_status = 'refunded');

-- 43. Find customers who have no orders with Refunded payments.

select * from customers c where not exists
(select 1 from orders o, order_items oi, payments p where o.customer_id = c.customer_id and oi.order_id = o.order_id
and oi.order_id = p.order_id and p.payment_status = 'refunded');

-- 44. Find products that were purchased by at least one customer from Gujarat.

SELECT *
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    JOIN customers c ON c.customer_id = o.customer_id
    WHERE oi.product_id = p.product_id
      AND c.state = 'Gujarat'
);

-- 45. Find products that were never purchased by any customer from Gujarat.

SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi, orders o, customers c
    WHERE oi.product_id = p.product_id
      AND oi.order_id = o.order_id
      AND o.customer_id = c.customer_id
      AND c.state = 'Gujarat'
);
-- 46. Find customers who have placed at least one order containing a product from the Home category.

select * from customers c where exists
(Select 1 from orders o , order_items oi, products p where o.customer_id = c.customer_id and 
o.order_id = oi.order_id and oi.product_id = p.product_id and p.category = 'home');

-- 47. Find customers who have never placed any order containing a product from the Home category.

select * from customers c where not exists
(Select 1 from orders o , order_items oi, products p where o.customer_id = c.customer_id and 
o.order_id = oi.order_id and oi.product_id = p.product_id and p.category = 'home');

-- 48. Find orders that have at least one order_item whose line_total is greater than 3000.

SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.order_id = o.order_id
      AND oi.line_total > 3000
);



-- 49. Find orders that do not have any order_item whose line_total is greater than 3000.

SELECT *
FROM orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.order_id = o.order_id
      AND oi.line_total > 3000
);


-- 50. Find customers who have at least one order that contains a product from both Electronics and Beauty categories.

SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND EXISTS (
          SELECT 1
          FROM order_items oi, products p
          WHERE oi.order_id = o.order_id
            AND oi.product_id = p.product_id
            AND p.category = 'Electronics'
      )
      AND EXISTS (
          SELECT 1
          FROM order_items oi, products p
          WHERE oi.order_id = o.order_id
            AND oi.product_id = p.product_id
            AND p.category = 'Beauty'
      )
);