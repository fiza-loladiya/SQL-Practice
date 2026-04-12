-- ============================================
-- RANKING WINDOW FUNCTION PRACTICE - 50 QUESTIONS
-- MYSQL COMMENT FORMAT
-- DATASET:
-- customers(customer_id, first_name, last_name, email, gender, city, state, signup_date)
-- products(product_id, product_name, category, brand, price, cost_price, stock_qty)
-- orders(order_id, customer_id, order_date, order_status, shipping_fee, discount_amount, total_amount, delivered_date)
-- order_items(order_item_id, order_id, product_id, quantity, unit_price, line_total)
-- payments(payment_id, order_id, payment_date, payment_method, payment_status, amount_paid)
-- ============================================


-- =========================
-- LEVEL 1: BASIC ROW_NUMBER()
-- =========================

-- 1. Show each order with ROW_NUMBER() based on order_date.

select *,
      row_number() over(order by order_date) as rownumber
from orders;

-- 2. Show each order with ROW_NUMBER() for each customer based on order_date.

select *,
       row_number() over(partition by customer_id order by order_date) as rownumber
from orders;

-- 3. Show each product with ROW_NUMBER() for each category based on price descending.

select *,
	   row_number() over(partition by category order by price desc) as rownumber
from products;

-- 4. Show each product with ROW_NUMBER() for each brand based on stock_qty descending.

select *,
	   row_number() over(partition by brand order by stock_qty desc) as rownumber
from products;

-- 5. Show each payment with ROW_NUMBER() for each payment_method based on amount_paid descending.

select *,
       row_number() over(partition by payment_method order by amount_paid desc) as rownumber
from payments;

-- 6. Show each customer with ROW_NUMBER() for each state based on signup_date.

select *,
       row_number() over(partition by state order by signup_date) as rownumber
from customers;

-- 7. Show each customer with ROW_NUMBER() for each city based on signup_date.

select *,
       row_number() over(partition by city order by signup_date) as rownumber
from customers;

-- 8. Show each order_item with ROW_NUMBER() for each product_id based on quantity descending.

select *,
       row_number() over(partition by product_id order by quantity desc) as rownumber
from order_items;

-- 9. Show each payment with ROW_NUMBER() based on payment_date.

select *,
       row_number() over(order by payment_date) as rownumber
from payments;

-- 10. Show each product with ROW_NUMBER() based on price descending.

select *,
       row_number() over(order by price desc) as rownum
from products;

-- =========================
-- LEVEL 2: BASIC RANK()
-- =========================

-- 11. Show each product with RANK() for each category based on price descending.

select *,
       rank() over(partition by category order by price desc) as rankk
from products;

-- 12. Show each product with RANK() for each brand based on stock_qty descending.


select *,
       rank() over(partition by brand order by stock_qty desc) as rankk
from products;

-- 13. Show each order with RANK() for each customer based on total_amount descending.

select *,
       rank() over(partition by customer_id order by total_amount desc) as rankk
from orders;

-- 14. Show each payment with RANK() for each payment_method based on amount_paid descending.

select *,
       rank() over(partition by payment_method order by amount_paid desc) as rankk
from payments;

-- 15. Show each customer with RANK() for each state based on signup_date.

select *,
       rank() over(partition by state order by signup_date) as rankk
from customers;

-- 16. Show each order_item with RANK() for each product_id based on line_total descending.

select *,
       rank() over(partition by product_id order by line_total desc) as rankk
from order_items;

-- 17. Show each order with RANK() based on total_amount descending.

select *,
       rank() over(order by total_amount desc) as rankk
from orders;

-- 18. Show each product with RANK() based on price ascending.

select *,
       rank() over(order by price asc) as rankk
from products;

-- 19. Show each payment with RANK() based on amount_paid descending.

select *,
       rank() over(order by amount_paid desc) rankk
from payments;


-- 20. Show each customer with RANK() based on signup_date.

select *,
       rank() over(order by signup_date) as rankk
from customers;

-- =========================
-- LEVEL 3: BASIC DENSE_RANK()
-- =========================

-- 21. Show each product with DENSE_RANK() for each category based on price descending.

select *,
       dense_rank() over(partition by category order by price desc) as dr
from products;

-- 22. Show each product with DENSE_RANK() for each brand based on stock_qty descending.

select *,
       dense_rank() over(partition by brand order by stock_qty desc) as dr
from products;

-- 23. Show each order with DENSE_RANK() for each customer based on total_amount descending.

select *,
	   dense_rank() over(partition by customer_id order by total_amount desc) as dr
from orders;

-- 24. Show each payment with DENSE_RANK() for each payment_method based on amount_paid descending.

select *,
       dense_rank() over(partition by payment_method order by amount_paid desc) as dr
from payments;

-- 25. Show each customer with DENSE_RANK() for each state based on signup_date.

select *,
       dense_rank() over(partition by state order by signup_date) as dr
from customers;

-- 26. Show each order_item with DENSE_RANK() for each product_id based on quantity descending.

select *,
       dense_rank() over(partition by product_id order by quantity desc) as dr
from order_items;

-- 27. Show each order with DENSE_RANK() based on total_amount descending.

select *,
       dense_rank() over(order by total_amount desc) as dr
from orders;

-- 28. Show each product with DENSE_RANK() based on price ascending.

select *,
       dense_rank() over(order by price asc) as dr
from products;

-- 29. Show each payment with DENSE_RANK() based on amount_paid descending.

select *,
       dense_rank() over(order by amount_paid desc) as dr
from payments;

-- 30. Show each customer with DENSE_RANK() based on signup_date.

select *,
       dense_rank() over(order by signup_date) as dr
from customers;

-- =========================
-- LEVEL 4: TOP / BOTTOM USING RANKING
-- =========================

-- 31. Find the latest order for each customer using ROW_NUMBER().

select * from (
select *,
       row_number() over(partition by customer_id order by order_date desc) as latest_order
from orders) t 
where latest_order =  1;

-- 32. Find the earliest order for each customer using ROW_NUMBER().

select * from (
select *,
       row_number() over(partition by customer_id order by order_date) as earliest_order
from orders) x
where earliest_order =  1;

-- 33. Find the highest priced product in each category using ROW_NUMBER().

select * from  (
select *,
       row_number() over(partition by category order by price desc) as highest_price
from products) x
where highest_price = 1;

-- 34. Find the lowest priced product in each category using ROW_NUMBER().

select * from  (
select *,
       row_number() over(partition by category order by price asc) as lowest_price
from products) x
where lowest_price = 1;

-- 35. Find the highest stock product in each brand using ROW_NUMBER().

select * from  (
select *,
       row_number() over(partition by brand order by stock_qty desc) as highest_stock_qty
from products) x
where highest_stock_qty = 1;

-- 36. Find the highest payment amount for each payment_method using ROW_NUMBER().

select * from  (
select *,
       row_number() over(partition by payment_method order by amount_paid desc) as highest_amount
from payments) x
where highest_amount = 1;

-- 37. Find the top 3 highest priced products in each category using ROW_NUMBER().

select * from (
select *, 
       row_number() over(partition by category order by price desc) as top_3
from products) x
where top_3 <= 3;

-- 38. Find the top 2 highest total_amount orders for each customer using ROW_NUMBER().

select * from (
select *, 
       row_number() over(partition by customer_id order by total_amount desc) as top_2
from orders) x
where top_2 <= 2;

-- 39. Find the top 3 highest amount_paid payments for each payment_method using ROW_NUMBER().

select * from (
select *,
       row_number() over(partition by payment_method order by amount_paid desc) as top_3
from payments) x
where top_3 <= 3;

-- 40. Find the first signed-up customer in each state using ROW_NUMBER().

select * from (
select *,
       row_number() over(partition by state order by signup_Date asc) as first_signup_Date
from customers) x
where first_signup_date = 1;

-- =========================
-- LEVEL 5: INTERVIEW-STYLE RANKING QUESTIONS
-- =========================

-- 41. Show each order with ROW_NUMBER(), RANK(), and DENSE_RANK() for each customer based on total_amount descending in the same result.

select *,
       row_number() over(partition by customer_id order by total_amount desc) as rownumber,
       rank() over(partition by customer_id order by total_amount desc) as rankk,
       dense_rank() over(partition by customer_id order by total_amount desc) as dr
from orders;

-- 42. Show each product with ROW_NUMBER(), RANK(), and DENSE_RANK() for each category based on price descending in the same result.

select *,
       row_number() over(partition by category order by price desc) as rownumber,
       rank() over(partition by category order by price desc ) as rankk,
       dense_rank() over(partition by category order by price desc) as dr
from products;

-- 43. Find the second highest priced product in each category using DENSE_RANK().

select * from  (
select *, 
       dense_rank() over(partition by category order by price desc) as second_highest
from products)x
where second_highest = 2;

-- 44. Find the second highest total_amount order for each customer using DENSE_RANK().

select * from  (
select *, 
       dense_rank() over(partition by customer_id order by total_amount desc) as second_highest
from orders)x
where second_highest = 2;

-- 45. Find the third highest amount_paid payment for each payment_method using DENSE_RANK().


select * from  (
select *,
        dense_rank() over(partition by payment_method order by amount_paid desc) as third_highest
from payments) x
where third_highest = 3;

-- 46. Find products whose price rank in their category is 1 or 2.

select * from (
select *,
       rank() over(partition by category order by price desc) as xx
from products)x
where xx in (1,2);

-- 47. Find orders whose total_amount rank in their customer group is 1.

select * from (
select *,
       rank() over(partition by customer_id order by total_amount desc) as xx
from orders)x
where xx = 1;

-- 48. Find payments whose amount_paid dense rank in their payment_method group is less than or equal to 3.

select * from (
select *,
	    dense_rank() over(partition by payment_method order by amount_paid desc) as xx
from payments) x
where xx <= 3;

-- 49. Find customers whose signup_date row number in their state is 1.

select * from (
select *,
	   row_number() over(partition by state order by signup_date) xx
from customers)x
where xx = 1;

-- 50. Show each product with its rank in category and then display only products whose rank is greater than 3.

select * from (
select *,
       rank() over(partition by category order by price desc) as xx
from products)x
where xx > 3;