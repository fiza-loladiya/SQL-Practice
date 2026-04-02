-- ============================================
-- SINGLE-VALUE SUBQUERY PRACTICE - 100 QUESTIONS
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================

-- =========================
-- LEVEL 1: VERY EASY
-- =========================

-- 1. Find products whose price is greater than the average product price.

select * from products where price > 
(select avg(price) from products);

-- 2. Find products whose price is less than the average product price.

select * from products where price <
(select avg(price) from products);

-- 3. Find products whose stock quantity is greater than the average stock quantity.

select * from products where stock_qty >
(select avg(stock_qty) from products);

-- 4. Find products whose stock quantity is less than the average stock quantity.

select * from products where stock_qty <
(select avg(stock_qty) from products);

-- 5. Find orders whose total amount is greater than the average order amount.

select * from orders where total_amount >
(select avg(total_amount) from orders);

-- 6. Find orders whose total amount is less than the average order amount.

select * from orders where total_amount <
(select avg(total_amount) from orders);

-- 7. Find payments whose amount_paid is greater than the average payment amount.

select * from payments where amount_paid >
(select avg(amount_paid) from payments);

-- 8. Find payments whose amount_paid is less than the average payment amount.

select * from payments where amount_paid <
(select avg(amount_paid) from payments);

-- 9. Find customers whose signup date is earlier than the average signup date.

SELECT * FROM customers WHERE signup_date < 
(SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(signup_date)))  FROM customers);
    
-- 10. Find customers whose signup date is later than the average signup date.

SELECT * FROM customers WHERE signup_date >
(SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(signup_date)))  FROM customers);

-- 11. Find products whose price is equal to the maximum product price.

select * from products where price =
(select max(price) from products);

-- 12. Find products whose price is equal to the minimum product price.

select * from products where price =  
(select min(price) from products);

-- 13. Find orders whose total amount is equal to the maximum order amount.

select * from orders where total_amount =
(select max(total_amount) from orders);

-- 14. Find orders whose total amount is equal to the minimum order amount.

select * from orders where total_amount =
(select min(total_amount) from orders);

-- 15. Find payments whose amount_paid is equal to the highest payment amount.

select * from payments where amount_paid =
(select max(amount_paid) from payments);

-- 16. Find payments whose amount_paid is equal to the lowest payment amount.

select * from payments where amount_paid =
(select min(amount_paid) from payments);

-- 17. Find the earliest signed-up customer(s).

select * from customers where signup_Date = 
(select min(signup_date) from customers);

-- 18. Find the most recently signed-up customer(s).

select * from customers where signup_Date = 
(select max(signup_date) from customers);

-- 19. Find the earliest order(s).

select * from orders where order_date = 
(select min(order_Date) from orders);

-- 20. Find the latest order(s).

select * from orders where order_date = 
(select max(order_Date) from orders);


-- =========================
-- LEVEL 2: EASY WITH FILTERS
-- =========================

-- 21. Find delivered orders whose total amount is greater than the average delivered order amount.

select * from orders where order_status = 'delivered' and total_amount >
(select avg(total_amount) from orders where order_status = 'delivered');

-- 22. Find delivered orders whose total amount is less than the average delivered order amount.

select * from orders where order_status = 'delivered' and total_amount <
(select avg(total_amount) from orders where order_status = 'delivered');

-- 23. Find cancelled orders whose total amount is greater than the average cancelled order amount.

select * from orders where order_status = 'cancelled' and total_amount >
(select avg(total_amount) from orders where order_status = 'cancelled');

-- 24. Find refunded payments whose amount_paid is greater than the average refunded payment amount.

select * from payments where payment_status = 'refunded' and amount_paid >
(select avg(amount_paid) from payments where payment_status = 'refunded');

-- 25. Find paid payments whose amount_paid is greater than the average paid payment amount.

select * from payments where payment_status = 'paid' and amount_paid >
(select avg(amount_paid) from payments);

-- 26. Find products in Electronics category whose price is greater than the average price of all products.

select * from products where category = 'Electronics' and price > 
(select avg(price) from products);

-- 27. Find products in Fashion category whose price is less than the average price of all products.

select * from products where category = 'Fashion' and price <
(select avg(price) from products);

-- 28. Find customers from Gujarat whose signup date is earlier than the average signup date of all customers.

select * from customers where state = 'Gujarat' and signup_date < 
(select from_unixtime(avg((unix_timestamp(signup_Date)))) from customers);

-- 29. Find orders placed in 2025 whose total amount is greater than the average order amount of all orders.

select * from orders where year(order_date) = 2025 and total_amount > 
(select avg(total_amount) from orders);

-- 30. Find orders placed in 2024 whose total amount is less than the average order amount of all orders.

select * from orders where year(order_date) = 2024 and total_amount <
(select avg(total_amount) from orders);

-- 31. Find products whose stock quantity is greater than the maximum stock quantity among Books products.

select * from products where stock_qty >
(select max(stock_qty) from products where category = 'Books');

-- 32. Find products whose price is lower than the minimum price among Electronics products.

select * from products where price <
(select min(price) from products where category = 'Electronics');

-- 33. Find orders whose total amount is higher than the maximum delivered order amount.

select * from orders where total_amount >
(select max(total_amount) from orders where order_status = 'Delivered');

-- 34. Find orders whose total amount is lower than the minimum delivered order amount.

select * from orders where total_amount <
(select min(total_amount) from orders where order_status = 'Delivered');

-- 35. Find customers who signed up before the first order date in the orders table.

select * from customers where signup_date <
(select min(order_Date) from orders);

-- 36. Find customers who signed up after the latest order date in the orders table.

select * from customers where signup_date >
(select max(order_Date) from orders);

-- 37. Find payments made before the earliest order date.

select * from payments where payment_date <
(select min(order_date) from orders);

-- 38. Find payments made after the latest order date.

select * from payments where payment_date >
(select max(order_date) from orders);

-- 39. Find orders whose shipping_fee is greater than the average shipping fee.

select * from orders where shipping_fee >
(select avg(shipping_fee) from orders);

-- 40. Find orders whose discount_amount is greater than the average discount amount.

select * from orders where discount_amount >
(select avg(discount_amount) from orders);

-- =========================
-- LEVEL 3: MEDIUM
-- =========================

-- 41. Find products whose price is greater than the average price of Electronics products.

select * from products where price > 
(select avg(price) from products where category = "Electronics");

-- 42. Find products whose price is less than the average price of Fashion products.

select * from products where price <
(select avg(price) from products where category = "Fashion");

-- 43. Find products whose stock quantity is greater than the average stock quantity of Home products.

select * from products where stock_qty >
(select avg(stock_qty) from products where category = "Home");

-- 44. Find products whose stock quantity is less than the average stock quantity of Beauty products.

select * from products where stock_qty <
(select avg(stock_qty) from products where category = 'Beauty');

-- 45. Find orders whose total amount is greater than the average total amount of delivered orders.

select * from orders where total_amount >
(select avg(total_amount) from orders where order_status = 'delivered');

-- 46. Find orders whose total amount is less than the average total amount of cancelled orders.

select * from orders where total_amount <
(select avg(total_amount) from orders where order_status = 'Cancelled');

-- 47. Find payments whose amount_paid is greater than the average amount paid through UPI.

select * from payments where amount_paid >
(select avg(amount_paid) from payments where payment_method = 'UPI');

-- 48. Find payments whose amount_paid is greater than the average amount paid through Credit Card.

select * from payments where amount_paid >
(select avg(amount_paid) from payments where payment_method = 'Credit Card');

-- 49. Find orders whose shipping_fee is greater than the average shipping fee of delivered orders.

select * from orders where shipping_fee >
(select avg(shipping_fee) from orders where order_status = 'delivered');

-- 50. Find orders whose discount_amount is greater than the average discount amount of cancelled orders.

select * from orders where discount_amount >
(select avg(discount_amount) from orders where order_status = 'cancelled');

-- 51. Find products more expensive than the average cost_price of all products.

select * from products where price >
(select avg(cost_price) from products);

-- 52. Find products where selling price is greater than the average selling price plus 500.

select * from products where price >
(select avg(price)+500 from products);

-- 53. Find orders where total_amount is greater than average order amount plus 1000.

select * from orders where total_Amount > 
(select avg(total_amount) + 1000 from orders);

-- 54. Find payments where amount_paid is lower than average amount_paid minus 500.

select * from payments where amount_paid <
(select avg(amount_paid) - 500 from payments);

-- 55. Find products priced above the midpoint of maximum price and minimum price.

SELECT * 
FROM products 
WHERE price > (
    SELECT (MAX(price) + MIN(price)) / 2 
    FROM products
);

-- 56. Find orders whose total_amount is below the midpoint of maximum total_amount and minimum total_amount.

SELECT * 
FROM orders
WHERE total_amount < (
    SELECT (MAX(total_amount) + MIN(total_amount)) / 2 
    FROM orders
);

-- 57. Find customers whose signup_date is equal to the earliest signup_date.

select * from customers where signup_date =
(select min(signup_date) from customers);

-- 58. Find customers whose signup_date is equal to the latest signup_date.

select * from customers where signup_date =
(select max(signup_date) from customers);

-- 59. Find orders whose order_date is equal to the earliest order_date.

select * from orders where order_date =
(select min(order_date) from orders);

-- 60. Find orders whose order_date is equal to the latest order_date.

select * from orders where order_date =
(select max(order_date) from orders);

-- =========================
-- LEVEL 4: MEDIUM TO STRONG
-- =========================

-- 61. Find products whose price is greater than the average price of products from brand Nova.

select * from products where price >
(select avg(price) from products where brand = 'Nova');

-- 62. Find products whose cost_price is greater than the average cost_price of products from brand Aster.

select * from products where cost_price >
(select avg(cost_price) from products where brand = 'Aster');

-- 63. Find orders whose total amount is greater than the average total amount of orders with Paid payments.

SELECT *
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM payments
        WHERE payment_status = 'paid'
    )
);

-- 64. Find orders whose total amount is less than the average total amount of orders with Refunded payments.

SELECT *
FROM orders
WHERE total_amount < (
    SELECT AVG(total_amount)
    FROM orders
    WHERE order_id IN (
        SELECT order_id
        FROM payments
        WHERE payment_status = 'Refunded'
    )
);

-- 65. Find payments whose amount_paid is greater than the average total_amount of delivered orders.

select * from payments where amount_paid > 
(select avg(total_amount) from orders where order_status = 'Delivered');

-- 66. Find orders whose total_amount is greater than the average amount_paid in payments.

select * from orders where total_amount > 
(select avg(amount_paid) from payments);

-- 67. Find products whose stock_qty is greater than the total number of categories in products.

select * from products where stock_qty >
(select count(DISTINCT category) from products);

-- 68. Find orders whose total_amount is greater than the total number of customers.

select * from orders where total_Amount >
(select count(customer_id) from customers);

-- 69. Find payments whose amount_paid is greater than the total number of orders.

select * from payments where amount_paid >
(select count(order_id) from orders);

-- 70. Find products whose price is greater than the total number of products multiplied by 10.

select * from products where price >
(select count(product_id)*10 from products);

-- 71. Find customers whose customer_id is greater than the average customer_id.

select * from customers where customer_id >
(select avg(customer_id) from customers);

-- 72. Find orders whose order_id is less than the average order_id.

select * from orders where order_id <
(select avg(order_id) from orders);

-- 73. Find products whose product_id is greater than the average product_id.

select * from products where product_id >
(select avg(product_id) from products);

-- 74. Find payments whose payment_id is greater than the average payment_id.

select * from payments where payment_id >
(select avg(payment_id) from payments);

-- 75. Find order_items whose quantity is greater than the average quantity in order_items.

select * from order_items where quantity >
(select avg(quantity) from order_items);

-- 76. Find order_items whose line_total is greater than the average line_total.

select * from order_items where line_total >
(select avg(line_total) from order_items);

-- 77. Find order_items whose unit_price is greater than the average unit_price.

select * from order_items where unit_price >
(select avg(unit_price) from order_items);

-- 78. Find order_items whose quantity is equal to the maximum quantity.

select * from order_items where quantity =
(select max(quantity) from order_items);

-- 79. Find order_items whose line_total is equal to the maximum line_total.

select * from order_items where line_total =
(select max(line_total) from order_items);


-- 80. Find order_items whose unit_price is equal to the minimum unit_price.

select * from order_items where unit_price =
(select min(unit_price) from order_items);

-- =========================
-- LEVEL 5: STRONG PRACTICE
-- =========================

-- 81. Find products whose price is greater than the average unit_price from order_items.

select * from products where price >
(select avg(unit_price) from order_items);

-- 82. Find products whose price is less than the maximum unit_price from order_items.

select * from products where price <
(select max(unit_price) from order_items);

-- 83. Find orders whose total_amount is greater than the average line_total from order_items.

select * from orders where total_amount >
(select avg(line_total) from order_items);

-- 84. Find order_items whose line_total is greater than the average total_amount from orders.

select * from order_items where line_total >
(select avg(total_amount) from orders);

-- 85. Find customers who signed up before the average order_date.

select * from customers where signup_date <
(select from_unixtime(avg((unix_timestamp(order_date)))) from orders);

-- 86. Find customers who signed up after the minimum order_date.

select * from customers where signup_date >
(select min(order_date) from orders);

-- 87. Find payments whose payment_date is after the average order_date.

select * from payments where payment_date >
(select from_unixtime(avg(unix_timestamp(order_date))) from orders);

-- 88. Find orders whose order_date is before the average payment_date.

select * from orders where order_date <
(select from_unixtime(avg(unix_timestamp(payment_date))) from payments);

-- 89. Find products whose cost_price is greater than the minimum selling price in products.

select * from products where cost_price > 
(select min(price) from products);

-- 90. Find products whose price is greater than the maximum cost_price in products.

select * from products where price > 
(select max(cost_price) from products);

-- 91. Find orders whose discount_amount is greater than the average discount_amount of orders placed in 2025.

select * from orders where discount_amount >
(select avg(discount_amount) from orders where year(order_date) = 2025);

-- 92. Find orders whose shipping_fee is less than the average shipping_fee of orders placed in 2024.

select * from orders where shipping_fee <
(select avg(shipping_fee) from orders where year(order_date) = 2024);

-- 93. Find payments whose amount_paid is greater than the average amount_paid of payments made in 2025.

select * from payments where amount_paid >
(select  avg(amount_paid) from payments where year(payment_date) = 2025);

-- 94. Find customers whose signup_date is earlier than the average signup_date of customers from Maharashtra.

select * from customers where signup_date <
(select from_unixtime(avg(unix_timestamp(signup_date))) from customers where state = 'Maharashtra');

-- 95. Find products whose stock_qty is greater than the average stock_qty of products priced above 2000.

select * from products where stock_qty >
(select avg(stock_qty) from products where price > 2000);

-- 96. Find orders whose total_amount is less than the average total_amount of orders with discount_amount greater than 0.

select * from orders where total_amount < 
(select avg(total_amount) from orders where discount_amount > 0);

-- 97. Find payments whose amount_paid is greater than the average amount_paid of Paid payments.

select * from payments where amount_paid >
(select avg(amount_paid) from payments where payment_status = 'paid');

-- 98. Find order_items whose quantity is less than the average quantity of order items with line_total greater than 3000.

select * from order_items where quantity <
(Select avg(quantity) from order_items where line_total > 3000);

-- 99. Find products whose price is greater than the average price of products with stock_qty above 100.

select * from products where price >
(select avg(price) from products where stock_qty > 100);

-- 100. Find orders whose total_amount is greater than the average total_amount of orders that have a payment record.

select * from orders where total_amount >
(select avg(total_amount) from orders where order_id in (select order_id from payments));
