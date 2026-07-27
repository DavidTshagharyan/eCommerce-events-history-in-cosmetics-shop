-- 2  count of NULL for every column 
select 
	count(*) as total_rows,
	count(*) - count(event_time) as null_event_time,
	count(*) - count(event_type) as null_event_time,
	count(*) - count(product_id) as null_product_id,
	count(*) - count(category_id) as null_category_id,
	count(*) - count(category_code) as null_category_code,
	count(*) - count(brand) as null_brand,
	count(*) - count(price) as null_price,
	count(*) - count(user_id) as null_user_id,
	count(*) - count(user_session) as null_user_session
from
	events;


-- 3 Price anomaly
select 
	min(price) as min_price,
	max(price) as max_price,
	avg(price) as avg_price,
	count(*) filter (where price <= 0) as zero_or_negative_pricealter 
from events;


-- 4 Dublicates
select event_time, event_type, product_id, user_id, user_session, count(*)
from events e 
group by event_time, event_type, product_id, user_id, user_session
having count(*) > 1
limit 20;
