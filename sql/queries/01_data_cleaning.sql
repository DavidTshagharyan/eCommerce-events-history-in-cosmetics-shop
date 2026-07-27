-- 1 event_type and it's total count
select event_type, count(*) as total
from events e 
group by e.event_type 
order by total desc;


-- 5 Create evnets clean table
create table events_clean as
select distinct
	event_time,
	event_type, 
	product_id,
	category_id,
	category_code,
	brand,
	price,
	user_id,
	user_session
from events
where price > 0
	and user_session is not null;


-- 6 Check new table
select count(*) from events_clean


-- 7 Check the upper outliers of price
select price, count(*)
from events_clean
where price > 300
group by price 
order by price desc 
limit 20;


-- 9 event_time (date range)
select min(event_time), max(event_time)
from events_clean;


--10 Check(unique) user_id and product_id
select
	count(distinct user_id) as unique_users,
	count(distinct product_id) as unique_products,
	count(distinct user_session) as unique_session
from events_clean ec;


-- INDEX CREATING
-- 1
create index idx_user_id on events_clean(user_id);
-- 2
create index idx_user_session on events_clean(user_session);
-- 3
create index idx_events_type on events_clean(event_type);
-- 4
create index idx_product_id on events_clean(product_id);
--5
create index idx_event_time on events_clean(event_time);