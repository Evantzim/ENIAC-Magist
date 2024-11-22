use magist;
select*
from orders;

select count(*) as orders_count
from orders;

select order_status, count(order_status)
from orders
group by order_status;

select year(order_purchase_timestamp) as year_, month(order_purchase_timestamp) as month_, count(customer_id)
from orders
group by year_ , month_
order by year_ , month_;



SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    
select product_category_name as products, count(*) as products_per_cat
from products
group by product_category_name
order by count(*) desc;

SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;

select *
from products;

select *
from order_items;




SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;

select max(price) as max_price, min(price) as min_price
from order_items;


select max(payment_value), min(payment_value)
from order_payments;

select *
from order_payments;

select order_id as orders, sum(payment_value)
from order_payments
group by order_id
order by sum(payment_value) desc
limit 5;

select *
from product_category_name_translation;

select count(*) as total_tech_products, round(avg(price),2)
from products p
left join product_category_name_translation tr
on p.product_category_name = tr.product_category_name
right join order_items o
on p.product_id = o.product_id
right join orders ord
on o.order_id = ord.order_id
where product_category_name_english in ("computers", "electronics", "tablets_printing_image", "telephony", "fixed_telephony") and order_status <> "canceled" and order_status <> "unavailable";

select count(*) as total_products, round(avg(price),2)
from products p
left join product_category_name_translation tr
on p.product_category_name = tr.product_category_name
right join order_items o
on p.product_id = o.product_id
right join orders ord
on o.order_id = ord.order_id
where not order_status = "cancelled" or order_status= "unavailable";


select  count(*) as n_per_category,
	case
		when o.price >= 500 then "expensive"
        when o.price between 100 and 500 then "medium"
		else "low"
	end as price_category
from products p
left join product_category_name_translation tr
on p.product_category_name = tr.product_category_name
right join order_items o
on p.product_id = o.product_id
right join orders ord
on o.order_id = ord.order_id
where product_category_name_english in ("computers", "electronics", "tablets_printing_image", "telephony", "fixed_telephony") and order_status <> "canceled" and order_status <> "unavailable"
group by price_category;


select count(distinct month(order_purchase_timestamp), year(order_purchase_timestamp)) as total_months_of_data
from orders;


#3.2 _2nd#

select count(*) / sum(count(*))
from products
group by product_category_name;

select sum(count(*))
from products;


#3.2 _3rd#

select round(sum(price),2) as total_earned
from order_items;

select round(sum(price),2) as total_tech_earned
from order_items o
left join products p
on o.product_id =  p.product_id
where product_category_name in ("pcs", "electronicos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa");

#4.1 _1st#

select month(order_purchase_timestamp), year(order_purchase_timestamp), day(order_purchase_timestamp), month(order_delivered_customer_date), year(order_delivered_customer_date), day(order_delivered_customer_date)
from orders;

select month(order_purchase_timestamp), year(order_purchase_timestamp), 
day(order_purchase_timestamp), month(order_delivered_customer_date), year(order_delivered_customer_date), 
day(order_delivered_customer_date), 
datediff(order_delivered_customer_date, order_purchase_timestamp) as days_difference 
from orders;

select avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) as days_difference
from orders;

#4.1 _2nd#

select count(*) as n_orders,
	case 
		when order_delivered_customer_date <= order_estimated_delivery_date then "on_time"
        else "delay"
	end as delay_or_not
from orders
group by delay_or_not;

select  product_description_length, product_length_cm, product_photos_qty, product_weight_g, product_width_cm, product_height_cm,
	case 
		when order_delivered_customer_date <= order_estimated_delivery_date then "on_time"
        else "delay"
	end as delay_or_not   
from orders o
left join order_items ord
on ord.order_id = o.order_id
left join products p 
on ord.product_id = p.product_id

having delay_or_not = "delay";





