show databases;
create database bank_db;
show databases;
use bank_db;
create table customers (
	customer_id int auto_increment,
    name varchar(30),
    email varchar(50),
    city varchar(30),
    primary key (customer_id)
);
select * from customers;
drop table customers;
insert into customers (name,email,city) values ('Fiza', 'fiza@gmail.com', 'Ahmedabad');
insert into customers (name,email,city) values ('Rahul', 'rahul@gmail.com', 'Mumbai');
insert into customers (name,email,city) values ('Amit', 'amit@gmail.com', 'Delhi');
insert into customers (name,email,city) values ('Neha', 'neha@gmail.com', 'Delhi');
select * from customers;
update customers set city= 'pune' where customer_id = 2;
update customers set city= 'Mumbai' where customer_id = 2;
update customers set city= 'pune' where name = 'rahul';
delete from customers where customer_id = 3;
select * from customers;
SET SQL_SAFE_UPDATES = 0;
delete from customers where email = 'amit@gmail.com';
insert into customers (name,email,city) values ('Arjun','arjun@gmail.com','Mumbai');
select * from customers;
delete from customers;
select * from customers;
update customers set city = 'Banglore'
where customer_id = 4;
delete from customers where customer_id = 2;
select * from customers;
select * from customers where city = 'pune';
select * from customers where city like '%P%';
drop database bank_db;
show databases;
create database fixa;
use fixa;
CREATE TABLE employees (
  id INT,
  name VARCHAR(50),
  department VARCHAR(50),
  salary INT
);
INSERT INTO employees VALUES
(1, 'Amit', 'HR', 40000),
(2, 'Neha', 'IT', 60000),
(3, 'Rahul', 'Finance', 50000),
(4, 'Priya', 'IT', 70000),
(5, 'Karan', 'HR', 45000);
update employees set salary = salary + 5000 where department = 'IT';
delete from employees where id = 3;
select * from employees;
select name, salary from employees;
select name, salary from employees where salary > 50000;
select name, department from employees where department = 'IT';
select * from employees order by salary desc;
select * from employees order by salary desc limit 3;
select count(id) as total_employees, department from employees group by department;
select avg(salary) as avg_salary, department from employees group by department;
alter table employees add city varchar(40);
select * from employees;
alter table employees drop city;
truncate table employees;
select * from employees;
drop database fixa;
show databases;
use moviesdb;
select * from movies;

# select  a movie with the highest imdb rating
select * from movies where imdb_rating = (select max(imdb_rating) from movies);

# movie with min & max rating
select * from movies where imdb_Rating in
((select min(imdb_rating) from movies),
(select max(imdb_Rating) from movies));

# fetch the actor name and age from the actors table
select * from actors;
select * from 
(select name,
       year(curdate())-birth_year as age
from actors) as actor_age
where age > 40;

# select actors who acted in any of these movies (101,110,121)
select * from actors;
select * from movie_actor;
select * from actors where actor_id =  any (
select actor_id from movie_actor where movie_id in (101,110,121));

# select all the movies whose rating is greater than *any* of the marvel movie rating.
select * from movies;
select * from movies where imdb_Rating > any (
select imdb_rating from movies where studio = 'marvel studios');

# select all the movies whose rating is greater than *all* of the marvel movie rating.
select * from movies where imdb_Rating > all (
select imdb_rating from movies where studio = 'marvel studios');

# select actor_id, name, and total number of movies they acted in
select * from actors;
select * from movie_actor;
explain analyze
select actor_id,
       name,
       (select count(*) from movie_actor where actor_id=actors.actor_id) as movie_Count 
from actors;
