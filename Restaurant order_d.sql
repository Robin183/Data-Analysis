use restaurant_db;
-- 1. view the menu_items table.
select * from menu_items;

-- 2. Find the number of items on the menu. 
select count(*) from menu_items;

-- 3. what are the least and most expensive items on the menu?
select * from menu_items
order by price;

select * from menu_items
order by price desc;

-- 4. how many Italian dishes are on the menu?
select count(*) from menu_items
where category='Italian';

-- 5. what are the least and most expensive Italian dishes on the menu?
select * from menu_items
where category='Italian'
order by price;

select * from menu_items
where category='Italian'
order by price desc;

-- 6. how many dishes are in each category?
select category, count(menu_item_id) as num_dishes
from menu_items
group by category;

-- 7. what is the average dish price within each category?
select category, avg(price) as avg_dishes
from menu_items
group by category;

------------------------------------------------------------------------------------

-- 1. view the order_details table.
select * from order_details;

-- 2. what is the date range of the table?
select min(order_date), max(order_date) from order_details;

-- 3. how many orders were made within this date range?
select count(distinct order_id) from order_details;

-- 4. how many orders were ordered within this date range?
select count(*) from order_details;

-- 5. which order has most number of items?
select order_id, count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

-- 6. how many orders had more than 12 items?
select count(*) from
(select order_id, count(item_id) as num_items
from order_details
group by order_id
having num_items > 12) as num_order;

---------------------------------------------------------------------------------------------

-- 1. combine the menu_items and order_details tables into a single table.
select * 
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id;

-- 2. what were the least and most ordered items? what categories were they in?
select item_name, count(order_details_id) as num_purchases
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id
     group by item_name
     order by num_purchases;
     
     
select item_name, category, count(order_details_id) as num_purchases
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id
     group by item_name, category
     order by num_purchases desc;

-- 3. what were the top 5 orders that spent the most money?
select order_id, sum(price) as total_spend
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

-- 4. view the details of the highest spend order. what insights can you gather from the results?
select category, count(item_id) as total_spend
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id
     where order_id = 440
     group by category;

-- 5. view the details of the top 5 highest spend orders. what insights can you gather from the results?
select order_id, category, count(item_id) as total_spend
from order_details od left join menu_items mi
     on od.item_id = mi.menu_item_id
     where order_id in (440, 2075, 1957, 330, 2675)
     group by order_id, category;
     
440	192.15
2075	191.05
1957	190.10
330	189.70
2675	185.10