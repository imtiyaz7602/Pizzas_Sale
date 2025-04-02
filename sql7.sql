
-- Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS total_order FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS Total_revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
    
 --    Identify the highest-priced pizza.
SELECT pt.name, p.price AS highest_price
FROM pizza_types AS pt
JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size AS Size, COUNT(order_details.order_details_id) AS cnt
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details_id) DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category AS category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_id
FROM
    orders
GROUP BY hour;
-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(pizza_type_id) AS count
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS Average_order
FROM
    (SELECT 
        orders.order_date AS date,
            SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS temp;
    
-- Determine the top 3 most ordered pizza types based on revenue
SELECT SUM(Revenue) FROM
(SELECT 
    pizza_types.name AS Name,
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY Name) AS temp;
-- ORDER BY Revenue DESC
-- LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category As Category,(ROUND(sum(order_details.quantity*pizzas.price),2) /(SELECT SUM(Revenue) FROM
(SELECT 
    pizza_types.name AS Name,
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY Name) AS temp))*100 AS revenue
FROM pizza_types JOIN pizzas ON
pizza_types.pizza_type_id =pizzas.pizza_type_id
JOIN order_details ON
order_details.pizza_id =pizzas.pizza_id GROUP BY
Category ORDER BY Revenue DESC;

-- Analyze the cumulative revenue generated over time.
SELECT Date, ROUND(SUM(Revenue) OVER(order by  Date) ,2)AS cumulitive FROM
(SELECT orders.order_date AS Date, ROUND(SUM(pizzas.price*order_details.quantity),2) AS Revenue FROM 
order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
JOIN orders ON orders.order_id = order_details.order_id
GROUP BY orders.order_date ORDER BY Date) AS temp;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
