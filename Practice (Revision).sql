create database practice;
use practice;
select * from customers;
select * from order_items;
select * from orders;
select * from payments;
select * from products;
select format(month(order_date),'mmmm') as order_month, round(sum(total_amount),0) as total_sales from orders
group by format(month(order_date),'MMMM');
select c.customer_id,
	   round(sum(o.total_amount),0) as total_spending
from customers c
join orders o
using (customer_id)
group by c.customer_id
order by total_spending desc limit 10;
select * from customers;
select first_name, last_name, city from customers;
select product_name, category, price from products;
select order_id, customer_id, order_date, total_amount from orders;
select * from payments;
select * from customers where city = 'ahmedabad';
select * from customers where state = 'Gujarat';
select * from products where price > 100;
select * from products where category = 'Electronics';
select * from orders where order_status = 'delivered';
select * from orders where total_amount > 500;
select * from payments where payment_status = 'refunded';
select * from payments where payment_method = 'upi';
select * from customers order by signup_date asc;
select * from products order by price desc;
select * from customers order by signup_date desc;
select * from orders order by total_amount desc limit 10;
select * from orders order by total_amount asc limit 10;
select distinct city from customers;
select distinct state from customers;
select distinct category from products;
select distinct payment_method from payments;
select distinct order_status from orders;
select count(*) from customers;
select count(*) from products;
select count(*) from orders;
select round(sum(total_amount),2) as total_amount from orders;
select round(avg(total_amount),2) as avg_order_value from orders;
select max(price) from products;
select min(price) from products;
select round(avg(price),0), category from products group by category;
select round(sum(amount_paid),0) from payments;
select sum(shipping_fee) as total_Shipping from orders where order_status = 'delivered' or order_status ='shipped';
select sum(discount_amount) from orders where order_status = 'delivered' or order_status = 'shipped';
select count(customer_id), state from customers group by state;
select count(customer_id), city from customers group by city;
select count(product_id), category from products group by category;
select count(product_id), brand from products group by brand;
select avg(price), category from products group by category;
select sum(stock_qty), category from products group by category;
select count(order_id), order_status from orders group by order_status;
select count(payment_id), payment_method from payments group by payment_method;
select count(payment_id),payment_status from payments group by payment_status;
select sum(total_amount),order_status from orders group by order_status;
select count(customer_id), state from customers group by state having count(customer_id) > 10;
select count(customer_id), city from customers group by city having count(customer_id) > 5;
select avg(price), category from products group by category having avg(price) > 2000;
select count(product_id), brand from products group by brand having count(product_id) > 10;
select sum(total_amount), order_status from orders group by order_status having sum(total_amount) > 50000;
select sum(stock_qty), category from products group by category having sum(stock_qty) > 500;
select * from customers;
select * from payments;
select * from orders;
select o.order_id,
	   concat(c.first_name,' ',c.last_name) as full_name
from orders o
left join customers c
using (customer_id);
select o.order_id,
	   c.state,
       c.city
from orders o
left join customers c
using (customer_id);
select o.order_id,
	   p.payment_method,
       p.payment_status
from orders o
left join payments p
using (order_id);
select o.order_id,
	   p.payment_method,
       p.payment_status
from orders o
left join payments p
using (product_id);
select * from customers;
select count(*) as total_customer, city from customers group by city;
select count(*) as total_customer, state from customers group by state;
select count(*) as total_product, category from products group by category;
select count(*) as total_prouct, brand from products group by brand;
select avg(price), category from products group by category;
select sum(stock_qty), category from products group by category;
select count(*) as total_order, order_status from orders group by order_status;
select count(*) as total_count, payment_method from payments group by payment_method;
select count(*) as total_count, payment_status from payments group by payment_status;
select sum(total_amount), order_status from orders group by order_status;
select count(*) total_customer,state from customers group by state having count(*) > 10;
select count(*) total_customer,city from customers group by city having count(*) > 5;
select avg(Price) as avg_price, category from products group by category having avg(price) > 2000;
select count(*) as total_product, brand from products group by brand having count(*) > 10;
select sum(total_amount), order_status from orders group by order_status having sum(total_amount) > 50000;
select count(payment_id), payment_method from payments group by payment_method having count(payment_id) > 100;

select * from orders;
select * from customers;
select * from products;
select sum(stock_qty), category from products group by category having sum(stock_qty) > 500;
select concat(c.first_name,' ',c.last_name) as full_name,
       o.*
from orders o
left join customers c
using (customer_id);
select o.*,
       c.city,
       c.state
from orders o
left join customers c
using (customer_id);
select o.*,
       p.payment_method,
       p.payment_status
from orders o
left join payments p 
using (order_id);
select o.*,
       p.product_name,
       p.category
from orders o
left join order_items oi
using (order_id)
left join products p
using (product_id);
select * from products;
select *  from orders;
select * from order_items;
select o.order_date,
	   o.total_amount,
       concat(c.first_name,' ',c.last_name) as full_name
from orders o
left join customers c
using (customer_id);
select * from payments;
select p.*,
       o.order_date,
       concat(c.first_name,' ',c.last_name) as customer_name
from customers c
join orders o
using (customer_id)
left join payments p
using (order_id);
select * from products;
select * from orders;
select * from order_items;
select * from customers;
select concat(c.first_name,' ', c.last_name) as full_name,
	   o.order_id,
       o.total_amount
from customers c
join orders o
using (customer_id);
select o.quantity,
       p.price
from order_items o
join products p
using (product_id);
select * from orders;
select * from payments;
select o.*,
       p.payment_method
from orders o
left join payments p
using (order_id)
where o.order_status = 'Delivered';
-- Show customer full name, order_id, order_date, product_name, quantity, and line_total.
select * from customers;
select * from orders;
select * from order_items;
select * from products;
select concat(c.first_name,' ',c.last_name) as full_name,
       o.order_id,
       o.order_date,
       p.product_name,
       oi.quantity,
       oi.line_total
from customers c
left join orders o
using (customer_id)
join order_items oi
using (order_id)
join products p
using (product_id);
-- Show category-wise total revenue using orders, order_items, and products.
select * from products;
select * from orders;
select p.category,
       sum(o.total_amount)
from orders o
join order_items oi
using (order_id)
join products p
using (product_id)
group by p.category;
-- Show brand-wise quantity sold.
select * from products;
select * from orders;
select * from order_items;
select p.brand,
	sum(oi.quantity) as total_qty
from orders o
join order_items oi
using (order_id)
left join products p
using (product_id)
group by p.brand;
-- Show city-wise total sales.
select * from customers;
select * from orders;
select c.city,
       sum(o.total_amount) as total_Sales
from customers c
left join orders o
using (customer_id)
group by city;
-- Show state-wise total sales.
select c.state,
       sum(total_amount) as total_Sales
from customers c
left join orders o
using (customer_id)
group by state;
-- Show customer-wise total amount spent.
select concat(c.first_name,' ',c.last_name) as full_name,
	   sum(o.total_amount) as total_amount_spent
from customers c
left join orders o
using (customer_id)
group by full_name;
-- Show customer-wise total number of orders.
select concat(c.first_name,' ',c.last_name) as full_name,
	   count(o.order_id) as total_number_of_order
from customers c
left join orders o
using (customer_id)
group by full_name;
-- Show product-wise total quantity sold.
select * from products;
select * from order_items;
select p.product_name,
       sum(oi.quantity) as total_sold_qty
from orders o
join order_items oi
using (order_id)
join products p
using (product_id)
group by product_name;
-- Show product-wise total revenue.
select p.product_name,
       sum(o.total_amount) as total_revenue
from orders o
left join order_items oi
using (order_id)
join products p
using (product_id)
group by product_name;
-- Show category-wise total number of items sold.
select * from products;
select * from order_items;
select p.category,
       count(oi.order_item_id) as total_number_of_items_sold
from orders o
join order_items oi
using (order_id)
left join products p
using (product_id)
group by category;
-- Find customers from Ahmedabad and Gujarat.
select * from customers where city = "Ahmedabad" and state = "Gujarat";
-- Find products in category Electronics with price above 2000.
select * from products where category = "Electronics" and price > 2000;
-- Show orders with total amount between 3000 and 7000.
select * from orders where total_amount between 3000 and 7000;
-- Show payments with method in (UPI, Credit Card).
select * from payments where payment_method in ("UPI","Credit Card");
-- Show customers whose first name starts with A.
select * from customers where first_name like "A%";
-- Show customers whose last name ends with a.
select * from customers where first_name like "%a";
-- Show product names containing Watch.
select * from products where product_name like "%watch%";
-- Show orders placed between 2024-01-01 and 2024-06-30.
select * from orders where order_date between '2024-01-01' and '2024-06-30';
-- Show customers from states in (Gujarat, Maharashtra, Delhi).
select * from customers where state in ('Gujarat','Maharashtra','Delhi');
-- Show products where brand is not Nova.
select * from products where brand != 'Nova';
-- Extract year from order_date.
select year(order_date) from orders;
-- Extract month from order_date.
select month(order_date) from orders;
-- Extract day from order_date.
select day(order_date) from orders;
-- Count total orders by year.
select count(*), year(order_date) as year from orders group by year order by year ;
-- Count total orders by month.
select count(*), month(order_date) as month from orders group by month order by month;
-- Find monthly sales trend.
select month(order_Date) as month, sum(total_amount) sales from orders group by month order by month asc;
-- Find yearly sales trend.
select year(order_Date) as year, sum(total_amount) sales from orders group by year order by year asc;
-- Show number of customers who signed up each year.
select count(customer_id), year(order_date) as year from orders group by year ;
-- Show number of customers who signed up each month.
select count(customer_id), month(order_date) as month from orders group by month ;
-- Show number of customers who signed up each year.
select count(*), year(signup_date) as year from customers group by year;
-- Find delivered orders by month.
select * from orders;
select month(delivered_date) as month,order_status,shipping_fee,discount_amount,total_amount
 from orders where order_status = "Delivered";
-- Find refunded payments by month.
select * from payments;
select month(payment_date) as month,payment_method,payment_status,amount_paid from payments where 
payment_status = 'refunded';
-- Find average order value by month.
select month(order_Date) as month, avg(total_amount) as avg from orders group by month;
-- Show customer full name using CONCAT().
select concat(first_name,' ',last_name) as full_name from customers;
-- Show all customer emails in lowercase.
select lower(email) from customers;
-- Show all product names in uppercase.
select upper(product_name) from products;
-- Find length of each customer’s email.
select concat(first_name,' ',last_name) as full_name, length(email) as length from customers;
-- Show first 3 characters of each product name.
select left(product_name,3) from products;
-- Show last 4 characters of each email.
select right(email,4) from customers;
-- Replace example.com in emails with gmail.com.
select replace(email,'gmail.com','example.com') as replacement from customers;
-- Extract first name initials from customers.
select left(first_name,1) from customers;
-- Label products as Expensive if price > 3000, else Affordable.
select *,
       case when price > 300 then 'Expensive'
       else 'Affordable'
       end as Label
from products;
-- Label orders as High Value, Medium Value, Low Value based on total_amount.
select *,
       case when total_amount <= 1000 then 'Low Value'
			when total_amount > 1000 then 'Medium Value'
            else 'High Vaue'
            end as label
from orders;
-- Label customers as New or Old based on signup year.
select *,
	    case when year(signup_date) = 2025 then 'New'
        else 'Old'
        end as label
from customers;
-- Label payments as Success if payment_status = Paid, otherwise Issue.
select * from payments;
select *,
       case when payment_status = 'paid' then 'success'
       else 'issue'
       end as label
from payments;
-- Label products by stock: Low Stock, Medium Stock, High Stock.
select *,
       case when stock_qty <= 50 then 'Low Stock'
            when stock_qty > 50 or stock_qty < 100 then 'Medium Stock'
            else 'High Stock'
            end as label
from products;
-- Label orders as Completed if status = Delivered, else Not Completed.
select *,
	   case when order_status = "Delivered" then 'Completed'
       else 'Not Completed'
       end as label
from orders;
use practice;

use practice;
select * from products;
select category, count(*) as total from products group by category order by total;
