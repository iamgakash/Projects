 select * from orders
 limit 10;


-- Assignment 1
 select year(created_at) As Years,
 month(created_at) as Months,
 count(distinct order_id) As Orders,
 sum(price_usd) as Revenue,
 sum(price_usd)  - sum(cogs_usd) as Margin
 from orders
 where created_at < "2013-01-04"
 group by 1,2;
 
 select 
	year(website_sessions.created_at) as Year,
    Month(website_sessions.created_at) as Month,
    count(distinct orders.order_id) as orders,
	count(distinct orders.order_id)/count(distinct website_sessions.website_session_id) as Conversion_rate,
    sum(orders.price_usd)/count(distinct website_sessions.website_session_id) as Revenue_per_session,
    count(distinct case when orders.primary_product_id = 1 then orders.order_id else null end) as Product_one_orders,
    count(distinct case when orders.primary_product_id = 2 then orders.order_id else null end) as Product_two_orders
from 
	website_sessions
left join
	orders
on
	website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at > "2012-04-01" and
	website_sessions.created_at < "2013-04-01"
group by 1,2;


select distinct pageview_url from website_pageviews;

-- Assignment 1

create temporary table product_pageviews
SELECT 
    website_session_id,
    website_pageview_id,
    created_at,
    CASE
        WHEN created_at < '2013-01-06' THEN 'Pre-product-2'
        WHEN created_at >= '2013-01-06' THEN 'Post-product-2'
        ELSE 'ohh'
    END AS Time_period
FROM
    website_pageviews
WHERE
    created_at > '2012-10-06'
        AND created_at < '2013-04-06'
        AND pageview_url = '/products';
        
select * from product_pageviews;

create temporary table sessions_w_next_pageview_id
SELECT 
    product_pageviews.time_period,
    product_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS Min_pageview_id
FROM
    product_pageviews
        LEFT JOIN
    website_pageviews ON product_pageviews.website_session_id = website_pageviews.website_session_id
        AND website_pageviews.website_pageview_id > product_pageviews.website_pageview_id 
GROUP BY 1 , 2;

select * from sessions_w_next_pageview_id;

create temporary table sessions_w_next_pageview_url
SELECT 
    sessions_w_next_pageview_id.time_period,
    sessions_w_next_pageview_id.website_session_id,
    website_pageviews.pageview_url
FROM
    sessions_w_next_pageview_id
        LEFT JOIN
    website_pageviews ON sessions_w_next_pageview_id.Min_pageview_id = website_pageviews.website_pageview_id;

select * from sessions_w_next_pageview_url;

select 
	time_period,
    count(distinct website_session_id) as sessions,
    count(distinct case when pageview_url is not null then website_session_id else null end) as W_Next_Pageviews,
    count(distinct case when pageview_url is not null then website_session_id else null end)/count(distinct website_session_id) as Pct_w_next_pagviews,
    count(distinct case when pageview_url = '/the-original-mr-fuzzy' then website_session_id else null end) as to_mr_fuzzy,
    count(distinct case when pageview_url = '/the-original-mr-fuzzy' then website_session_id else null end)/count(distinct website_session_id) as Pct_to_mr_fuzzy,
    count(distinct case when pageview_url = '/the-forever-love-bear' then website_session_id else null end) as to_lovebear,
    count(distinct case when pageview_url = '/the-forever-love-bear' then website_session_id else null end)/count(distinct website_session_id) as Pct_to_lovebear
from 
	sessions_w_next_pageview_url

group by 1
order by 1 desc;

-- Assignment 2

create temporary table sessions_w_funnelsss
SELECT 	
	website_session_id, 
    website_pageview_id, 
    pageview_url,
    created_at
from 
	website_pageviews
where created_at > "2013-01-06" and created_at < "2013-04-10"
and pageview_url in ('/the-original-mr-fuzzy', '/the-forever-love-bear' ,'/cart', '/shipping', '/billing-2', '/thank-you-for-your-order');

select * from sessions_w_funnels;

create temporary table Conversion_funnl_0
select 
	website_session_id, 
    website_pageview_id, 
    pageview_url, 
    created_at, 
    case when pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end as Mr_fuzzy_page,
    case when pageview_url = '/the-forever-love-bear' then 1 else 0 end as forever_page,
    case when pageview_url = '/cart' then 1 else 0 end as cart_page,
    case when pageview_url = '/shipping' then 1 else 0 end as Shipping_page,
    case when pageview_url = '/billing-2' then 1 else 0 end as Billing_page,
    case when pageview_url = '/thank-you-for-your-order' then 1 else 0 end as Thank_you_page
from 
	sessions_w_funnelsss;
    
select * from Conversion_funnl_0;

create temporary table Conversion_funnl_1
select 
	website_session_id,
    max(Mr_fuzzy_page) as Mr_fuzzy_page,
    max(forever_page) as forever_page,
    max(cart_page) as cart_page,
    max(Shipping_page) as Shipping_page,
    max(Billing_page) as Billing_page,
    max(Thank_you_page) as Thank_you_page
from 
	Conversion_funnl_0
group by 1;
    
select * from Conversion_funnel_1;

select
	case when Mr_fuzzy_page = 1 then "mrfuzzy"
    when forever_page = 1 then "loverbear"
    else "ohh"
    end as product_seen,
    count(distinct website_session_id) as sessions,
    count(case when cart_page = 1 then website_session_id else null end) as to_cart,
    count(case when Shipping_page = 1 then website_session_id else null end) as to_shipping,
    count(case when Billing_page = 1 then website_session_id else null end) as to_Billing,
    count(case when Thank_you_page = 1 then website_session_id else null end) as to_Thankyou
from 
	Conversion_funnl_1
group by 1;

select
	case when Mr_fuzzy_page = 1 then "mrfuzzy"
    when forever_page = 1 then "loverbear"
    else "ohh"
    end as product_seen ,
    count(case when cart_page = 1 then website_session_id else null end)/count(distinct website_session_id) as Product_click_rt,
    count(case when Shipping_page = 1 then website_session_id else null end)/count(case when cart_page = 1 then website_session_id else null end) as Cart_click_rt,
    count(case when Billing_page = 1 then website_session_id else null end)/count(case when Shipping_page = 1 then website_session_id else null end) as Shipping_click_rt,
    count(case when Thank_you_page = 1 then website_session_id else null end)/count(case when Billing_page = 1 then website_session_id else null end) as Billing_click_rt
from 
	Conversion_funnl_1
group by 1;

-- cross selling products

select * from order_items limit 1000;

select * from orders  where items_purchased > 1;


-- Cross sales Analysis

select 
	orders.order_id,
	orders.primary_product_id,
    order_items.product_id
from orders
left join order_items
 on orders.order_id = order_items.order_id
 and order_items.is_primary_item = 0
  ;
 
 select * from order_items;
 
 
 -- Assignment 11
 
 select 
	case 
		when website_pageviews.created_at > "2013-08-25" and  website_pageviews.created_at < "2013-09-25" then "A.Pre_cross_sell"
		when website_pageviews.created_at > "2013-09-25" and  website_pageviews.created_at < "2013-10-25" then "B.Post_cross_sell"
        else null end as Time_period,
	count(distinct case when website_pageviews.pageview_url = "/cart" then website_pageviews.website_session_id else null end) as Cart_sessions,
    count(distinct case when website_pageviews.pageview_url = "/shipping" then website_pageviews.website_session_id else null end) as clickthroughs,
    count(distinct case when website_pageviews.pageview_url = "/shipping" then website_pageviews.website_session_id else null end)/count(distinct case when website_pageviews.pageview_url = "/cart" then website_pageviews.website_session_id else null end) as cvr_rate,
    avg(orders.items_purchased) as Products_per_order,
    avg(orders.price_usd) as Aov
from 
	   website_pageviews left join orders on website_pageviews.website_session_id = orders.website_session_id
where website_pageviews.created_at > "2013-08-25" and website_pageviews.created_at < "2013-10-25"
group by 1;


select website_pageviews.website_session_id, orders.price_usd from website_pageviews left join orders on website_pageviews.website_session_id = orders.website_session_id
;
  
-- Assignment cross sales analysis
-- Solution

-- Step 1 - Identify the relevant /cart page views and their sessions
-- Step 2 - See which of those /cart sessions clicked through to shipping page
-- Step 3 - Find the orders associated with the /cart sessions. Analyze products Purchased, Aov
-- Step 4 - Aggregate and analyze a summary of findings


-- Step 1 - Identify the relevant /cart page views and their sessions
create temporary table sessions_seeing_cart
select 
	case when created_at < "2013-09-25" and created_at > "2013-08-25" then "A. Pre_cross_sell"
		when created_at < "2013-10-25" and created_at > "2013-09-25" then "B. Post_cross_sell"
		else "oh_Oh_check_logic" end as Time_period,
	website_session_id as cart_session_id,
    website_pageview_id as cart_pageview_id
from
	website_pageviews
where created_at < "2013-10-25" and created_at > "2013-08-25" and pageview_url = "/cart";

select * from sessions_seeing_cart;

-- Step 2 - See which of those /cart sessions clicked through to shipping page

create temporary table cart_sessions_seeing_another_page
SELECT 
    sessions_seeing_cart.time_period,
    sessions_seeing_cart.cart_session_id,
    MIN(website_pageviews.website_pageview_id) AS PV_after_cart
FROM
    sessions_seeing_cart
        LEFT JOIN
    website_pageviews ON sessions_seeing_cart.cart_session_id = website_pageviews.website_session_id
        AND website_pageviews.website_pageview_id> sessions_seeing_cart.cart_pageview_id 
group by 1,2
having MIN(website_pageviews.website_pageview_id) is not null;

select * from cart_sessions_seeing_another_page;

-- Step 3 - Find the orders associated with the /cart sessions. Analyze products Purchased, Aov

create temporary table pre_post_sessions_orders
select 
	time_period,
    cart_session_id,
    order_id,
    items_purchased,
    price_usd
from sessions_seeing_cart
inner join orders on sessions_seeing_cart.cart_session_id = orders.website_session_id;

select * from pre_post_sessions_orders;

-- Step 4 - Aggregate and analyze a summary of findings

-- Subquery

-- temp tables
-- 1. sessions_seeing_cart 
	select * from sessions_seeing_cart;
    -- Time_period, cart_session_id, cart_pageview_id
    
-- 2. cart_sessions_seeing_another_page
	select * from cart_sessions_seeing_another_page;
    -- time_period, cart_session_id, PV_after_cart
    
-- 3. pre_post_sessions_orders
	select * from pre_post_sessions_orders;
	-- time_period, cart_session_id, order_id, items_purchased, price_usd

SELECT 
    sessions_seeing_cart.Time_period,
    sessions_seeing_cart.cart_session_id,
    CASE
        WHEN cart_sessions_seeing_another_page.cart_session_id IS NULL THEN 0
        ELSE 1
    END AS Clicked_to_another_page,
    CASE
        WHEN pre_post_sessions_orders.order_id IS NULL THEN 0
        ELSE 1
    END AS Placed_orders,
    pre_post_sessions_orders.items_purchased,
    pre_post_sessions_orders.price_usd
FROM
    sessions_seeing_cart
        LEFT JOIN
    cart_sessions_seeing_another_page ON sessions_seeing_cart.cart_session_id = cart_sessions_seeing_another_page.cart_session_id
        LEFT JOIN
    pre_post_sessions_orders ON sessions_seeing_cart.cart_session_id = pre_post_sessions_orders.cart_session_id;

-- final query

select 
	time_period,
    count(distinct cart_session_id) as cart_sessions,
    sum(Clicked_to_another_page) as Click_throughs,
    sum(Clicked_to_another_page)/count(distinct cart_session_id) as cart_crt,
    sum(Placed_orders) as Orders_placed,
    sum(items_purchased) as Products_purchased,
    sum(items_purchased)/sum(Placed_orders) as Products_per_order,
    sum(price_usd) as Revenue,
    sum(price_usd)/sum(Placed_orders) as AOV,
    sum(price_usd)/count(distinct cart_session_id) as Revenue_per_session
from
	( SELECT 
    sessions_seeing_cart.Time_period,
    sessions_seeing_cart.cart_session_id,
    CASE
        WHEN cart_sessions_seeing_another_page.cart_session_id IS NULL THEN 0
        ELSE 1
    END AS Clicked_to_another_page,
    CASE
        WHEN pre_post_sessions_orders.order_id IS NULL THEN 0
        ELSE 1
    END AS Placed_orders,
    pre_post_sessions_orders.items_purchased,
    pre_post_sessions_orders.price_usd
FROM
    sessions_seeing_cart
        LEFT JOIN
    cart_sessions_seeing_another_page ON sessions_seeing_cart.cart_session_id = cart_sessions_seeing_another_page.cart_session_id
        LEFT JOIN
    pre_post_sessions_orders ON sessions_seeing_cart.cart_session_id = pre_post_sessions_orders.cart_session_id) as full_data
    group by Time_period;
    
-- Assignment 2

select * from orders;

select 
	case when website_sessions.created_at < "2013-12-12" then "A. Pre_Birthday_Bear"
    when website_sessions.created_at > "2013-12-12" then "B. Post_Birthday_Bear"
else "oh ohh" end as Time_Period,
	count(orders.order_id)/count(website_sessions.website_session_id) AS Conv_rate,
    sum(price_usd)/count(orders.order_id) as AOV,
    sum(items_purchased)/count(orders.order_id) as Products_per_order,
    sum(price_usd)/count(website_sessions.website_session_id) as Revenue_per_session
from 
	website_sessions
    left join
    orders on
		website_sessions.website_session_id = orders.website_session_id
where 
    website_sessions.created_at < "2014-01-12" and website_sessions.created_at > "2013-11-12"
group by 1;


select * from order_items;
select * from order_item_refunds;

-- Product refund Analysis
-- Assignment 1

SELECT 
    YEAR(order_items.created_at) AS Years,
    MONTH(order_items.created_at) AS Months,
    COUNT(CASE
        WHEN order_items.product_id = 1 THEN order_items.order_item_id
        ELSE NULL
    END) AS P1_Orders,
    COUNT(CASE
        WHEN order_items.product_id = 1 THEN order_item_refunds.order_item_id
        ELSE NULL
    END) AS P1_Refunds,
    COUNT(CASE
        WHEN order_items.product_id = 2 THEN order_items.order_item_id
        ELSE NULL
    END) AS P2_Orders,
    COUNT(CASE
        WHEN order_items.product_id = 2 THEN order_item_refunds.order_item_id
        ELSE NULL
    END) AS P2_Refunds,
    COUNT(CASE
        WHEN order_items.product_id = 3 THEN order_items.order_item_id
        ELSE NULL
    END) AS P3_Orders,
    COUNT(CASE
        WHEN order_items.product_id = 3 THEN order_item_refunds.order_item_id
        ELSE NULL
    END) AS P3_Refunds,
    COUNT(CASE
        WHEN order_items.product_id = 4 THEN order_items.order_item_id
        ELSE NULL
    END) AS P4_Orders,
    COUNT(CASE
        WHEN order_items.product_id = 4 THEN order_item_refunds.order_item_id
        ELSE NULL
    END) AS P4_Refunds	
FROM
    order_items
        LEFT JOIN
    order_item_refunds ON order_items.order_item_id = order_item_refunds.order_item_id
WHERE
    order_items.created_at < '2014-10-15'
GROUP BY 1 , 2;

