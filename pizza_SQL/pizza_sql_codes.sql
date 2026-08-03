create database pizza;
# drop database pizza;
use pizza;

# creating table
create table  pizza_types(
pizza_type_id varchar(100) primary key not null,
name varchar(100) not null,
category varchar(100) not null,
ingredients varchar(200) not null
);

create table orders(
order_id int primary key not null,
Date char(20) not null,
Time char(20) not null 
);

create table order_details(
order_details_id int not null primary key,
order_id int not null,
pizza_id char(20) not null,
quantity int not null
);

create table pizzas(
pizza_id varchar(100) not null primary key,
pizza_type_id varchar(100) not null ,
size char(10) not null,
price float not null
);

# Deleting column

drop table order_details;
drop table orders;
drop table pizzas;
drop table pizza_types;

# import CSV file by command

LOAD DATA INFILE 'C:/Users/GOPESHWAR KUMAR/Document/SQL/pizza_SQL/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



 # showing all columns of each table
select * from orders;
select * from order_details;
select * from pizza_types;
select * from pizzas;

# 1. Retrieve the total number of orders placed.
select count(order_id) from orders;

# 2. Calculate the total revenue generated from pizza sales.
select  round(sum((price*quantity)),2) as "Total revenue Rs." from order_details join pizzas on pizzas.pizza_id =order_details.pizza_id;

# 3. Identify the highest-priced pizza.
select name,price from pizzas join pizza_types on pizza_id=pizza_id order by price desc limit 1;

# 4. Identify the most common pizza size ordered.
select size ,count(order_id) from order_details join pizzas on pizzas.pizza_id=order_details.pizza_id group by size;	# not solved

# 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, SUM(quantity) AS 'quantity'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 5;

# 6. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    category, SUM(quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category;

# 7. Determine the distribution of orders by hour of the day.
SELECT 
    Time,
    EXTRACT(HOUR FROM Time),
    SUM(quantity) AS 'orders in hour'
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY Time order by Time;

# 8. Join relevant tables to find the category-wise distribution of pizzas.


# 9. Group the orders by date and calculate the average number of pizzas ordered per day.
# 10. Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    distinct(name),round(sum(quantity*price),2) as"revenue"
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id group by name order by revenue desc limit 3;

# 11. Calculate the percentage contribution of each pizza type to total revenue.
select category ,round(sum(price),2)  as Total from pizzas join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id group by category;

select size ,round(sum(price),2)  as Total from pizzas join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id group by size;

# 12. Analyze the cumulative revenue generated over time.