-- ============================================
-- ANY / ALL SUBQUERY PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC ANY
-- =========================

-- 1. Find products whose price is greater than ANY product price from the Books category.

select * from products where price > any 
(select price from products where category = 'books');

-- 2. Find products whose price is less than ANY product price from the Electronics category.

select * from products where price < any 
(select price from products where category = 'electronics');

-- 3. Find orders whose total_amount is greater than ANY delivered order amount.

select * from orders where total_amount > any
(select total_amount from orders where order_status = 'delivered');

-- 4. Find orders whose total_amount is less than ANY cancelled order amount.

select * from orders where total_amount < any
(select total_amount from orders where order_status = 'cancelled');

-- 5. Find payments whose amount_paid is greater than ANY refunded payment amount.

select * from payments where amount_Paid > any
(select amount_paid from payments where payment_status = 'refunded');

-- 6. Find payments whose amount_paid is less than ANY paid payment amount.

select * from payments where amount_Paid < any
(select amount_paid from payments where payment_status = 'paid');

-- 7. Find products whose stock_qty is greater than ANY stock_qty from the Beauty category.

select * from products where stock_qty > any 
(select stock_qty from products where category = 'beauty');

-- 8. Find products whose stock_qty is less than ANY stock_qty from the Home category.

select * from products where stock_qty < any 
(select stock_qty from products where category = 'home');

-- 9. Find order_items whose quantity is greater than ANY quantity from order_items where product_id = 1.

select * from order_items where quantity > any
(select quantity from order_items where product_id = 1);

-- 10. Find order_items whose line_total is greater than ANY line_total from order_items belonging to delivered orders.

select * from order_items where line_total > any
(Select line_total from order_items where order_id in (select order_id from orders where order_Status = 'delivered'));

-- =========================
-- LEVEL 2: BASIC ALL
-- =========================

-- 11. Find products whose price is greater than ALL product prices from the Books category.

select * from products where price > all
(select price from products where category = 'books');

-- 12. Find products whose price is less than ALL product prices from the Electronics category.

select * from products where price < all 
(select price from products where category = 'Electronics');

-- 13. Find orders whose total_amount is greater than ALL delivered order amounts.

select * from orders where total_amount > all
(Select total_amount from orders where order_status = 'delivered');

-- 14. Find orders whose total_amount is less than ALL cancelled order amounts.

select * from orders where total_amount < all
(Select total_amount from orders where order_status = 'cancelled');

-- 15. Find payments whose amount_paid is greater than ALL refunded payment amounts.

select * from payments where amount_paid > all
(select amount_paid from payments where payment_status = 'refunded');

-- 16. Find payments whose amount_paid is less than ALL paid payment amounts.

select * from payments where amount_paid < all
(select amount_paid from payments where payment_status = 'paid');

-- 17. Find products whose stock_qty is greater than ALL stock_qty values from the Beauty category.

select * from products where stock_qty > all
(select stock_qty from products where category = 'beauty');

-- 18. Find products whose stock_qty is less than ALL stock_qty values from the Home category.

select * from products where stock_qty < all
(select stock_qty from products where category = 'home');

-- 19. Find order_items whose quantity is greater than ALL quantities of order_items where product_id = 1.

select * from order_items where quantity > all
(select quantity from order_items where product_id = 1);

-- 20. Find order_items whose line_total is greater than ALL line_total values from order_items belonging to cancelled orders.

select * from order_items where line_total > all
(select line_total from order_items where order_id in (Select order_id from orders where order_status = 'cancelled'));

-- =========================
-- LEVEL 3: ANY / ALL WITH CATEGORY AND BRAND
-- =========================

-- 21. Find products whose price is greater than ANY price of products from brand Nova.

select * from products where price > any
(select price from products where brand = 'nova');

-- 22. Find products whose price is greater than ALL prices of products from brand Nova.

select * from products where price > all
(select price from products where brand = 'nova');

-- 23. Find products whose cost_price is less than ANY cost_price of products from brand Aster.

select * from products where cost_price < any
(select cost_price from products where brand = 'aster');

-- 24. Find products whose cost_price is less than ALL cost_price of products from brand Aster.

select * from products where cost_price < all
(select cost_price from products where brand = 'aster');

-- 25. Find products whose price is greater than ANY product price from the Fashion category.

select * from products where cost_price > any
(select cost_price from products where brand = 'fashion');

-- 26. Find products whose price is greater than ALL product prices from the Fashion category.

select * from products where cost_price > all
(select cost_price from products where brand = 'fashion');

-- 27. Find products whose stock_qty is less than ANY stock_qty from Electronics products.

select * from products where stock_qty < any
(Select stock_qty from products where category = 'electronics');

-- 28. Find products whose stock_qty is less than ALL stock_qty from Electronics products.

select * from products where stock_qty < all
(select stock_qty from products where category = 'electronics');

-- 29. Find products whose price is equal to ANY product price from the Home category.

select * from products where price = any
(select price from products where category = 'home');

-- 30. Find products whose cost_price is equal to ANY cost_price from the Beauty category.

select * from products where cost_price = any
(select cost_price from products where category = 'beauty');

-- =========================
-- LEVEL 4: ANY / ALL WITH ORDERS AND PAYMENTS
-- =========================

-- 31. Find orders whose total_amount is greater than ANY order total_amount from orders placed in 2024.

select * from orders where total_amount > any
(select total_amount from orders where year(order_date) = 2024);

-- 32. Find orders whose total_amount is greater than ALL order total_amount from orders placed in 2024.

select * from orders where total_amount > all
(select total_amount from orders where year(order_date) = 2024);

-- 33. Find orders whose total_amount is less than ANY order total_amount from orders placed in 2025.

select * from orders where total_amount < any
(select total_amount from orders where year(order_date) = 2025);

-- 34. Find orders whose total_amount is less than ALL order total_amount from orders placed in 2025.

select * from orders where total_amount > all
(select total_amount from orders where year(order_date) = 2025);

-- 35. Find payments whose amount_paid is greater than ANY amount_paid from payments made using UPI.

select * from payments where amount_paid > any
(select amount_paid from payments where payment_method = 'upi');

-- 36. Find payments whose amount_paid is greater than ALL amount_paid from payments made using UPI.

select * from payments where amount_paid > all
(select amount_paid from payments where payment_method = 'upi');

-- 37. Find payments whose amount_paid is less than ANY amount_paid from payments made using Credit Card.

select * from payments where amount_pai < any
(select amount_paid from payments where payment_method = 'credit card');

-- 38. Find payments whose amount_paid is less than ALL amount_paid from payments made using Credit Card.

select * from payments where amount_paid < all
(select amount_paid from payments where payment_method = 'credit card');

-- 39. Find orders whose shipping_fee is greater than ANY shipping_fee from delivered orders.

select * from orders where shipping_fee > any
(Select shipping_fee from orders where order_status = 'delivered');

-- 40. Find orders whose discount_amount is greater than ALL discount_amount values from cancelled orders.

select * from orders where discount_amount > all
(Select discount_amount from orders where order_status = 'cancelled');

-- =========================
-- LEVEL 5: MIXED THINKING
-- =========================

-- 41. Find order_items whose unit_price is greater than ANY product price from the Books category.

select * from order_items where unit_price > any
(Select price from products where category = 'books');

-- 42. Find order_items whose unit_price is greater than ALL product prices from the Books category.

select * from order_items where unit_price > all
(Select price from products where category = 'books');

-- 43. Find products whose price is greater than ANY unit_price from order_items.

select * from products where price > any 
(select unit_price from order_items );

-- 44. Find products whose price is greater than ALL unit_price from order_items.

select * from products where price > all
(select unit_price from order_items );

-- 45. Find orders whose total_amount is greater than ANY line_total from order_items.

select * from orders where total_amount > any
(Select line_total from order_items);

-- 46. Find orders whose total_amount is greater than ALL line_total from order_items.

select * from orders where total_amount > all
(Select line_total from order_items);

-- 47. Find payments whose amount_paid is less than ANY total_amount from orders.

select * from payments where amount_paid < any 
(select total_amount from orders);

-- 48. Find payments whose amount_paid is less than ALL total_amount from orders.

select * from payments where amount_paid < all
(select total_amount from orders);

-- 49. Find products whose stock_qty is greater than ANY quantity from order_items.

select * from products where stock_qty > any 
(Select quantity from order_items);

-- 50. Find products whose stock_qty is greater than ALL quantity values from order_items.

select * from products where stock_qty > all
(Select quantity from order_items);