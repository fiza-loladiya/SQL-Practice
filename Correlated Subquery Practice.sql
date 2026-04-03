-- ============================================
-- CORRELATED SUBQUERY PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC GROUP COMPARISON
-- =========================

-- 1. Find products whose price is greater than the average price of products in the same category.

select * from products p where price >
(Select avg(price) from products where category = p.category);

-- 2. Find products whose price is less than the average price of products in the same category.

select * from products p where price  <
(select avg(price) from products where category = p.category);

-- 3. Find products whose stock_qty is greater than the average stock_qty of products in the same category.

select * from products p where stock_qty > 
(select avg(stock_qty) from products where category = p.category);

-- 4. Find products whose stock_qty is less than the average stock_qty of products in the same category.

select * from products p where stock_qty <
(select avg(stock_qty) from products where category = p.category);

-- 5. Find customers whose signup_date is earlier than the average signup_date of customers from the same state.

select * from customers c where signup_date <
(select from_unixtime(avg(unix_timestamp(signup_date))) from customers where state = c.state);

-- 6. Find customers whose signup_date is later than the average signup_date of customers from the same state.

select * from customers c where signup_date >
(select from_unixtime(avg(unix_timestamp(signup_date))) from customers where state = c.state);

-- 7. Find customers whose customer_id is greater than the average customer_id of customers from the same city.

select * from customers c where customer_id >
(select avg(customer_id) from customers where city = c.city);

-- 8. Find products whose price is greater than the average price of products from the same brand.

select * from products p where price >
(select avg(price) from products where brand = p.brand);

-- 9. Find products whose cost_price is less than the average cost_price of products from the same brand.

select * from products p where cost_price <
(Select avg(cost_price) from products where brand = p.brand);

-- 10. Find order_items whose quantity is greater than the average quantity for the same product_id.

select * from order_items o where quantity >
(select avg(quantity) from order_items where product_id = o.product_id);

-- =========================
-- LEVEL 2: MAX / MIN WITHIN SAME GROUP
-- =========================

-- 11. Find the most expensive product(s) in each category.

select * from products p where price =
(select max(price) from products where category = p.category);

-- 12. Find the cheapest product(s) in each category.

select * from products p where price =
(select min(price) from products where category = p.category);

-- 13. Find the product(s) with highest stock_qty in each category.

select * from products p where stock_qty = 
(select max(stock_qty) from products where category = p.category);

-- 14. Find the product(s) with lowest stock_qty in each category.

select * from products p where stock_qty = 
(select min(stock_qty) from products where category = p.category);

-- 15. Find the most expensive product(s) in each brand.

select * from products p where price =
(select max(price) from products where brand = p.brand);

-- 16. Find the cheapest product(s) in each brand.

select * from products p where price =
(select min(price) from products where brand = p.brand);

-- 17. Find the earliest signed-up customer(s) in each state.

select * from customers c where signup_date = 
(Select min(signup_date) from customers where state = c.state);

-- 18. Find the latest signed-up customer(s) in each state.

select * from customers c where signup_date = 
(Select max(signup_date) from customers where state = c.state);

-- 19. Find the highest quantity order_item(s) for each product_id.

select * from order_items o where quantity =
(select max(quantity) from order_items where product_id = o.product_id);

-- 20. Find the lowest quantity order_item(s) for each product_id.

select * from order_items o where quantity =
(select min(quantity) from order_items where product_id = o.product_id);

-- =========================
-- LEVEL 3: CUSTOMER-BASED CORRELATED SUBQUERY
-- =========================

-- 21. Find orders whose total_amount is greater than the average total_amount of orders by the same customer.

select * from orders o where total_amount >
(select avg(total_amount) from orders where customer_id = o.customer_id);

-- 22. Find orders whose total_amount is less than the average total_amount of orders by the same customer.

select * from orders o where total_amount <
(select avg(total_amount) from orders where customer_id = o.customer_id);

-- 23. Find the highest value order(s) for each customer.

select * from orders o where total_amount =
(select max(total_amount) from orders where customer_id = o.customer_id);

-- 24. Find the lowest value order(s) for each customer.

select * from orders o where total_amount =
(select min(total_amount) from orders where customer_id = o.customer_id);

-- 25. Find the earliest order(s) for each customer.

select * from orders o where order_date =
(select min(order_date) from orders where customer_id = o.customer_id);

-- 26. Find the latest order(s) for each customer.

select * from orders o where order_date =
(select max(order_date) from orders where customer_id = o.customer_id);

-- 27. Find delivered orders whose total_amount is greater than the average delivered order amount of the same customer.

select * from orders o where order_status = 'delivered' and total_amount >
(select avg(total_amount) from orders where customer_id = o.customer_id); 

-- 28. Find cancelled orders whose total_amount is greater than the average cancelled order amount of the same customer.

select * from orders o where order_status = 'cancelled' and total_amount >
(select avg(total_amount) from orders where customer_id = o.customer_id); 

-- 29. Find orders whose shipping_fee is greater than the average shipping_fee of the same customer.

select * from orders o where shipping_fee >
(Select avg(shipping_fee) from orders where customer_id = o.customer_id);

-- 30. Find orders whose discount_amount is greater than the average discount_amount of the same customer.

select * from orders o where discount_amount >
(select avg(discount_amount) from orders where customer_id = o.customer_id);

-- =========================
-- LEVEL 4: PAYMENT-BASED CORRELATED SUBQUERY
-- =========================

-- 31. Find payments whose amount_paid is greater than the average amount_paid for the same payment_method.

select * from payments p where amount_paid >
(Select avg(amount_paid) from payments where payment_method = p.payment_method);

-- 32. Find payments whose amount_paid is less than the average amount_paid for the same payment_method.

select * from payments p where amount_paid <
(Select avg(amount_paid) from payments where payment_method = p.payment_method);

-- 33. Find the highest payment(s) for each payment_method.

select * from payments p where amount_paid = 
(Select max(amount_paid) from payments where payment_method = p.payment_method);

-- 34. Find the lowest payment(s) for each payment_method.

select * from payments p where amount_paid = 
(Select min(amount_paid) from payments where payment_method = p.payment_method);

-- 35. Find payments whose payment_date is earlier than the average payment_date for the same payment_method.

select * from payments p where payment_date <
(select from_unixtime(avg(unix_timestamp(payment_date))) from payments where payment_method = p.payment_method);

-- 36. Find payments whose payment_date is later than the average payment_date for the same payment_method.

select * from payments p where payment_date >
(select from_unixtime(avg(unix_timestamp(payment_date))) from payments where payment_method = p.payment_method);

-- 37. Find payments whose amount_paid is greater than the average amount_paid for the same payment_status.

select * from payments p where amount_paid >
(Select avg(amount_paid) from payments where payment_status = p.payment_status);

-- 38. Find the highest payment(s) for each payment_status.

select * from payments p where amount_paid =
(select max(amount_paid) from payments where payment_status = p.payment_status);

-- 39. Find the earliest payment(s) for each payment_status.

select * from payments p where payment_date = 
(select min(payment_date) from payments where payment_status = p.payment_status);

-- 40. Find the latest payment(s) for each payment_status.

select * from payments p where payment_date = 
(select max(payment_date) from payments where payment_status = p.payment_status);

-- =========================
-- LEVEL 5: ADVANCED GROUP COMPARISON
-- =========================

-- 41. Find customers whose signup_date is earlier than the average signup_date of customers in the same city.

SELECT *
FROM customers c
WHERE c.signup_date < (
    SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(signup_date)))
    FROM customers
    WHERE city = c.city
);

-- 42. Find customers whose signup_date is later than the average signup_date of customers in the same city.

SELECT *
FROM customers c
WHERE c.signup_date > (
    SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(signup_date)))
    FROM customers
    WHERE city = c.city
);

-- 43. Find products whose price is greater than the average price of products in the same category and same brand.

select * from products p where price >
(Select avg(price) from products where category = p.category and brand = p.brand);

-- 44. Find products whose stock_qty is less than the average stock_qty of products in the same category and same brand.

select * from products p where stock_qty <
(select avg(stock_qty) from products where category = p.category and brand = p.brand);

-- 45. Find order_items whose line_total is greater than the average line_total for the same product_id.

select * from order_items o where line_total >
(select avg(line_total) from order_items where product_id = o.product_id);

-- 46. Find order_items whose unit_price is greater than the average unit_price for the same product_id.

select * from order_items o where unit_price >
(select avg(unit_price) from order_items where product_id = o.product_id);

-- 47. Find order_items whose line_total is equal to the maximum line_total for the same product_id.

select * from order_items o where line_total =
(select max(line_total) from order_items where product_id = o.product_id);

-- 48. Find order_items whose line_total is equal to the minimum line_total for the same product_id.

select * from order_items o where line_total =
(select min(line_total) from order_items where product_id = o.product_id);

-- 49. Find orders whose total_amount is greater than the average total_amount of customers from the same city as that order's customer.

select * from orders o where total_amount >
(select avg(total_amount) from orders where customer_id in
(select customer_id from customers c where city in
(select city from customers where customer_id = o.customer_id)));

-- 50. Find orders whose total_amount is less than the average total_amount of customers from the same state as that order's customer.

select * from orders o where total_amount <
(select avg(total_amount) from orders where customer_id in
(select customer_id from customers c where state in
(select state
 from customers where customer_id = o.customer_id)));
