SELECT * FROM Pizza_sales.pizza_sales;
describe Pizza_sales.pizza_sales;
-- Data cleaning ---
update Pizza_sales.pizza_sales
set order_date=str_to_date(order_date,"%d-%m-%Y");
alter table Pizza_sales.pizza_sales modify column order_date  DATE;

update Pizza_sales.pizza_sales
set order_time =str_to_date(order_time,"%H:%i:%s");
alter table Pizza_sales.pizza_sales modify column order_time  time;


-- KPIs Requirement

-- Total Revenue:
select sum(unit_price*quantity) as Total_Revenue
from Pizza_sales.pizza_sales;

-- Average Order values
SELECT (Total_Revenue / No_of_orders) AS Average_order_value
FROM (
    SELECT COUNT(distinct order_id) AS No_of_orders, 
           SUM(unit_price * quantity) AS Total_Revenue
    FROM Pizza_sales.pizza_sales
) AS sales_data;

-- Total Pizzas Sold
select sum(quantity)as Total_pizzas_sold
from Pizza_sales.pizza_sales;

-- Total Orders:
select count(distinct order_id) as Total_orders
from Pizza_sales.pizza_sales;

-- Average Pizzas Per Orders
select (Total_pizzas_sold/Total_orders) as Average_pizzas_per_order
from (select sum(quantity)as Total_pizzas_sold,count(distinct order_id) as Total_orders
from Pizza_sales.pizza_sales) as Sales_data;

-- Daily Trend for Total Orders ---
select dayname(order_date) as Order_day,count(distinct order_id)as Total_orders
from Pizza_sales.pizza_sales
group by order_day
order by order_day ;  

-- Monthly Trend for Orders----
select monthname(order_date)as Order_month ,count(distinct order_id)as Total_orders
from Pizza_sales.pizza_sales
group by order_month
order by order_month desc;   

-- % of sales by pizza category:---
select distinct pizza_category,round((sum(quantity*unit_price)/(select sum(quantity*unit_price)from pizza_sales.Pizza_sales)*100),2) as revenue_percentage
from Pizza_sales.pizza_sales
group by pizza_category;

-- % of sales by pizza size:---
select distinct pizza_size, round((sum(quantity*unit_price)/(select sum(quantity*unit_price)from pizza_sales.Pizza_sales)*100),2)as percentage_sales
from Pizza_sales.pizza_sales
group by pizza_size;

-- Total pizzas sold by pizza category--
select pizza_category,sum(quantity) as total_pizzas_sold
from Pizza_sales.pizza_sales 
group by pizza_category  ;

-- Top 5 pizzas by revenue--
select pizza_name,sum(total_price)as total_revenue
from Pizza_sales.pizza_sales 
group by pizza_name 
order by total_revenue desc
limit 5;

-- bottom 5 pizzas by revenue---
select pizza_name,sum(total_price)as total_revenue
from Pizza_sales.pizza_sales 
group by pizza_name 
order by total_revenue 
limit 5;

-- Top 5 pizzas by Quantity--
Select pizza_name,sum(quantity) as Total_quantity
from Pizza_sales.pizza_sales 
group by pizza_name 
order by total_quantity desc
limit 5;




      
















