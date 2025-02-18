create database online_bookstore_database_system;
use Online_bookstore_database_system ; 
  
-- for the bookstore database we need to have Books table , authors table , customers table , orders table ,order item table

create table books 
( book_id int primary key,
Title  varchar(100) ,
Author_id int ,
Price int,
quantity int) ;

create table authors 
( Author_id int primary key,
author_name varchar(100));

create table customers 
( customer_id int primary key ,
customer_name varchar(100),
email varchar(100),
address varchar (100));

create table orders 
(
order_id int primary key ,
customer_id int,
order_date date
) ;

create table order_items 
(
Order_item_id int primary key,
order_id int ,
book_id int ,
Quantity int ,
price_per_unit decimal(10) ) ;

insert into books values
 (1, 'Pride and Prejudice', 1, 10, 100),
(2, 'Oliver Twist', 2, 8, 80),
(3, '1984', 3, 12, 120),
(4, 'tom jones',4,15 ,140),
(5, 'David copperfield' ,5, 20, 150);

insert into authors values
(1, 'Jane Austen'),
(2, 'Charles Dickens'),
(3, 'George Orwell'),
(4, ' Henry fielding'),
(5, 'Charles dickens ');


insert into customers values
(1, 'Alice', 'alice@example.com', '123 Main St, Anytown, USA'),
(2, 'Bob', 'bob@example.com', '456 Elm St, Othertown, USA'),
(3, 'Charlie', 'charlie@example.com', '789 Oak St, Anycity, USA'),
(4, 'cooper','cooper@example.com','321 pqr st , thistown ,USA'),
(5, 'Ben' , 'ben@example.com', '654 main st nextcity , USA');


insert into orders values
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02'),
(3, 3, '2024-04-03'),
(4, 4, '2024-04-04'),
(5, 5, '2024-04-05');
 
 insert into order_items values 
 (100, 1, 1, 2, 10),
(101, 1, 2, 3, 8),
(102, 2, 3, 1, 12),
(103, 3, 1, 1, 15),
(104, 3, 2, 2, 20);
 
 
select * from books ;
-- select only title and price 
select title , price from books ;


-- to use limit
select *  from authors 
limit 2,3;
 
 -- by using where condition
 select customer_name  from customers 
 where customer_id = 1;
 
select customer_name  from customers
where customer_name like '%ben%';

-- using aggregate function , group by , order by  
 
 

select title, length(title) as length_of_title, max(price) as  maximum_price
from books
group by title
order by maximum_price desc;

 -- having clause
select book_id ,title ,min(price) as minimum , quantity
from books
group by book_id
having title  = 1984;

-- Retrieve all books alomg with the authors (by using joins)
 
 select b.title as books , a.author_name as authors from 
 books b
 inner join
 authors a
 on b.author_id = a.author_id;
  
-- Retrieve  the total sales of each books

 select b.title as books , sum(oi.quantity) as total_sold from 
 books b
 inner join
 order_items oi
 on b.book_id = oi.book_id
 group by books
 order by total_sold asc ;

-- Retrieve the top 5 best selling books
 select b.title as books , sum(oi.quantity) as total_sold from 
 books b
 inner join
 order_items oi
 on b.book_id = oi.book_id
 group by books
 order by total_sold  desc  ;

-- Retrieve the customer who have made more than 3 orders
 select c.customer_name , o.order_id as total_orders from 
 customers c
 inner join 
 orders o 
 on c.customer_id = o.customer_id
 where order_id >3;
 
 -- Retrieve the total revenue generated by each author
 
 Select  a.author_name, sum(oi.quantity * oi.price_per_unit) AS total_revenue
FROM Authors a
inner join  Books b ON a.author_id = b.author_id
inner join  Order_Items oi ON b.book_id = oi.book_id
group by author_name;

-- creating  view 

create view Revenue_table
as 
(  Select  a.author_name, sum(oi.quantity * oi.price_per_unit) AS total_revenue
FROM Authors a
inner join  Books b ON a.author_id = b.author_id
inner join  Order_Items oi ON b.book_id = oi.book_id
group by author_name);

 select * from revenue_table;

 
 
 






