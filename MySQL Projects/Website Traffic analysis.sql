use mavenfuzzyfactory;

SELECT 
    website_sessions.utm_content,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id),
    (COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id)) * 100 AS session_conversion_rate
FROM
    website_sessions
        LEFT JOIN
    orders ON orders.website_session_id = website_sessions.website_session_id
WHERE
    website_sessions.website_session_id BETWEEN 1000 AND 2000
GROUP BY website_sessions.utm_content
ORDER BY COUNT(DISTINCT website_sessions.website_session_id) DESC;

-- Assignment 1

SELECT 
    *
FROM
    website_sessions;

SELECT 
    utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS sessions
FROM
    website_sessions
WHERE
    created_at < '2012-04-12'
GROUP BY utm_source , utm_campaign , http_referer
ORDER BY COUNT(DISTINCT website_session_id) DESC;

SELECT DISTINCT
    utm_campaign
FROM
    website_sessions;

-- Assignment 2

SELECT 
    COUNT(DISTINCT website_sessions.website_session_id),
    COUNT(DISTINCT orders.order_id),
    (COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id)) * 100
FROM
    website_sessions
        LEFT JOIN
    orders ON website_sessions.website_session_id = orders.website_session_id
WHERE
    website_sessions.created_at < '2012-04-14'
        AND website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand';

-- Bid Optimization

SELECT 
    primary_product_id,
    COUNT(DISTINCT CASE
            WHEN items_purchased = 1 THEN order_id
            ELSE NULL
        END),
    COUNT(DISTINCT CASE
            WHEN items_purchased = 2 THEN order_id
            ELSE NULL
        END),
    COUNT(DISTINCT order_id)
FROM
    orders
WHERE
    order_ID BETWEEN 31000 AND 32000
GROUP BY 1;

-- Assignment 1

SELECT 
    *
FROM
    website_sessions
LIMIT 10;

SELECT 
    MIN(DATE(created_at)), COUNT(DISTINCT website_session_id)
FROM
    website_sessions
WHERE
    created_at < '2012-05-10'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at) , YEAR(created_at);

-- Assignment 2

SELECT 
    *
FROM
    orders
LIMIT 10;

SELECT 
    *
FROM
    website_sessions
LIMIT 10;

SELECT 
    website_sessions.device_type,
    COUNT(DISTINCT website_sessions.website_session_id),
    COUNT(DISTINCT orders.order_id),
    (COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id)) * 100 AS CVR_rate
FROM
    website_sessions
        LEFT JOIN
    orders ON website_sessions.website_session_id = orders.website_session_id
WHERE
    website_sessions.created_at < '2012-05-11'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY website_sessions.device_type;

-- Assignment 3

SELECT 
    *
FROM
    website_sessions
LIMIT 5;

SELECT 
    MIN(DATE(created_at)) AS Start_date_of_the_week,
    COUNT(DISTINCT CASE
            WHEN device_type = 'mobile' THEN website_session_id
            ELSE NULL
        END) AS Mobile_Sessions,
    COUNT(DISTINCT CASE
            WHEN device_type = 'desktop' THEN website_session_id
            ELSE NULL
        END) AS Desktop_Sessions,
    COUNT(DISTINCT (website_session_id)) AS total_sessions
FROM
    website_sessions
WHERE
    created_at BETWEEN '2012-04-15' AND '2012-06-09'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at) , YEAR(created_at);

-- Analysing Website performance

SELECT 
    *
FROM
    website_pageviews
LIMIT 100;

-- Assignment 1

SELECT 
    pageview_url, COUNT(DISTINCT website_session_id) AS sessions
FROM
    website_pageviews
WHERE
    created_at < '2012-06-09'
GROUP BY pageview_url
ORDER BY sessions DESC;

-- Assignment 2

create temporary table first_pv_per_session
select website_session_id, min(website_pageview_id) as first_pv
from website_pageviews
where created_at < '2012-06-12'
group by website_session_id;

SELECT 
    *
FROM
    first_pv_per_session;
    
SELECT 
    website_pageviews.pageview_url AS Landing_page_url,
    COUNT(DISTINCT first_pv_per_session.website_session_id) AS count_ses
FROM
    website_pageviews
        LEFT JOIN
    first_pv_per_session ON first_pv_per_session.first_pv = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url
ORDER BY count_ses DESC;

SELECT 
    website_pageviews.pageview_url AS Landing_page_url,
    COUNT(DISTINCT first_pv_per_session.website_session_id) AS count_ses
FROM
    first_pv_per_session
        LEFT JOIN
    website_pageviews ON first_pv_per_session.first_pv = website_pageviews.website_pageview_id
GROUP BY Landing_page_url;


-- Landing page performance and testing

SELECT 
    website_session_id,
    MIN(website_pageview_id) AS min_pageview_id
FROM
    website_pageviews
WHERE
    created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY website_session_id;

create temporary table first_pageviews_demo
select website_session_id, min(website_pageview_id) as min_pageview_id
from website_pageviews
where created_at between '2014-01-01' and '2014-02-01'
group by website_session_id;


-- next bring landing page into each session

create temporary table sessions_w_landing_page_demo
select first_pageviews_demo.website_session_id,
website_pageviews.pageview_url as Landing_page
from first_pageviews_demo left join
website_pageviews
on website_pageviews.website_pageview_id = first_pageviews_demo.min_pageview_id;

-- next we are going to include pageviews by each session

create temporary table bounced_sessions_only
select sessions_w_landing_page_demo.website_session_id, sessions_w_landing_page_demo.landing_page,
count(website_pageviews.website_pageview_id) as count_of_pages_viewed
from sessions_w_landing_page_demo left join website_pageviews on sessions_w_landing_page_demo.website_session_id = website_pageviews.website_session_id
group by 1,2 
having count_of_pages_viewed = 1;

-- create a table with landing_page, website_session_id and bounced_website_session_id

SELECT 
    sessions_w_landing_page_demo.landing_page,
    sessions_w_landing_page_demo.website_session_id,
    bounced_sessions_only.website_session_id AS bounced_website_session_id
FROM
    sessions_w_landing_page_demo
        LEFT JOIN
    bounced_sessions_only ON sessions_w_landing_page_demo.website_session_id = bounced_sessions_only.website_session_id
ORDER BY sessions_w_landing_page_demo.website_session_id;


-- final output 

SELECT 
    sessions_w_landing_page_demo.landing_page,
    Count(distinct sessions_w_landing_page_demo.website_session_id) as sessions,
    Count(distinct bounced_sessions_only.website_session_id) AS bounced_sessions,
    Count(distinct bounced_sessions_only.website_session_id)/Count(distinct sessions_w_landing_page_demo.website_session_id) as bounce_rate
FROM
    sessions_w_landing_page_demo
        LEFT JOIN
    bounced_sessions_only ON sessions_w_landing_page_demo.website_session_id = bounced_sessions_only.website_session_id
group by sessions_w_landing_page_demo.landing_page;

-- Assignment 1

create temporary table first_pageviews
select website_session_id , min(website_pageview_id) as min_pageview_id
from website_pageviews
where created_at < "2012-06-14"
group by website_session_id;

create temporary table Landing_page_w_sessions
select first_pageviews.website_session_id, website_pageviews.pageview_url as landing_page
from first_pageviews 
left join website_pageviews
on website_pageviews.website_pageview_id = first_pageviews.min_pageview_id
where website_pageviews.pageview_url = "/home";

select * from Landing_page_w_sessions;

create temporary table bounce_sessions
select Landing_page_w_sessions.website_session_id, Landing_page_w_sessions.landing_page, count(distinct website_pageviews.website_pageview_id) as count_of_pages_viewed
from Landing_page_w_sessions left join website_pageviews
on Landing_page_w_sessions.website_session_id = website_pageviews.website_session_id
group by 1, 2
having count_of_pages_viewed = 1;

select * from bounce_sessions;


select count(distinct Landing_page_w_sessions.website_session_id) as Sessions, count(distinct bounce_sessions.website_session_id) as bounced_sessions,
count(bounce_sessions.website_session_id)/count(Landing_page_w_sessions.landing_page) as Bounce_rate
from Landing_page_w_sessions left join bounce_sessions on Landing_page_w_sessions.website_session_id = bounce_sessions.website_session_id ;


select Landing_page_w_sessions.website_session_id, bounce_sessions.website_session_id
-- count(bounce_sessions.website_session_id)/count(Landing_page_w_sessions.landing_page)
from Landing_page_w_sessions left join bounce_sessions on Landing_page_w_sessions.website_session_id = bounce_sessions.website_session_id;

-- Assignmet 2

SELECT 
    MIN(created_at) AS first_created_at,
    MIN(website_pageview_id) AS first_pageview_id
FROM
    website_pageviews
WHERE
    pageview_url = '/lander-1'
        AND created_at < '2012-07-28';
        
create temporary table first_pageviews
SELECT 
    website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM
    website_pageviews inner join
    website_sessions on website_sessions.website_session_id = website_pageviews.website_session_id
WHERE
    website_pageviews.created_at between "2012-06-19" and '2012-07-28'
    -- and website_pageviews.website_pageview_id > '23504' 
    AND website_sessions.utm_source = "gsearch" and website_sessions.utm_campaign = "nonbrand"
GROUP BY website_session_id;

create temporary table Landing_page_w_sessions
SELECT 
    first_pageviews.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM
    first_pageviews
        LEFT JOIN
    website_pageviews ON website_pageviews.website_pageview_id = first_pageviews.min_pageview_id
;

create temporary table bounce_sessions
SELECT 
    Landing_page_w_sessions.website_session_id,
    Landing_page_w_sessions.landing_page,
    COUNT(DISTINCT website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM
    Landing_page_w_sessions
        LEFT JOIN
    website_pageviews ON Landing_page_w_sessions.website_session_id = website_pageviews.website_session_id
GROUP BY 1 , 2
HAVING count_of_pages_viewed = 1;

SELECT 
	Landing_page_w_sessions.landing_page,
    COUNT(DISTINCT Landing_page_w_sessions.website_session_id) AS Sessions,
    COUNT(DISTINCT bounce_sessions.website_session_id) AS bounced_sessions,
    COUNT(bounce_sessions.website_session_id) / COUNT(Landing_page_w_sessions.landing_page) AS Bounce_rate
FROM
    Landing_page_w_sessions
        LEFT JOIN
    bounce_sessions ON Landing_page_w_sessions.website_session_id = bounce_sessions.website_session_id
GROUP BY Landing_page_w_sessions.landing_page;


-- Assignment 3

create temporary table first_pageviews
SELECT 
	MIN(DATE(website_pageviews.created_at)) AS week_start_date,
    website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_page_view
    
FROM
    website_pageviews inner join website_sessions on website_pageviews.website_session_id = website_sessions.website_session_id
WHERE
    website_pageviews.created_at < '2012-08-31'
        AND website_pageviews.created_at > '2012-06-01'
        AND website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY website_pageviews.website_session_id , YEAR(website_pageviews.created_at) , WEEK(website_pageviews.created_at);


create temporary table Landing_page_w_sessions
SELECT 
	first_pageviews.week_start_date,
    first_pageviews.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM
    first_pageviews
        LEFT JOIN
    website_pageviews ON website_pageviews.website_pageview_id = first_pageviews.min_page_view;
    
create temporary table bounce_sessions
SELECT 
    Landing_page_w_sessions.website_session_id,
    Landing_page_w_sessions.landing_page,
    COUNT(DISTINCT website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM
    Landing_page_w_sessions
        LEFT JOIN
    website_pageviews ON Landing_page_w_sessions.website_session_id = website_pageviews.website_session_id
GROUP BY 1 , 2
HAVING count_of_pages_viewed = 1;

SELECT 
    Landing_page_w_sessions.week_start_date,
    COUNT(DISTINCT bounce_sessions.website_session_id) / COUNT(DISTINCT Landing_page_w_sessions.website_session_id) AS bounce_rate,
    COUNT(DISTINCT CASE
            WHEN Landing_page_w_sessions.landing_page = '/home' THEN Landing_page_w_sessions.website_session_id
            ELSE NULL
        END) AS Home_sessions,
    COUNT(DISTINCT CASE
            WHEN Landing_page_w_sessions.landing_page = '/lander-1' THEN Landing_page_w_sessions.website_session_id
            ELSE NULL
        END) AS lander_sessions
FROM
    Landing_page_w_sessions
        LEFT JOIN
    bounce_sessions ON Landing_page_w_sessions.website_session_id = bounce_sessions.website_session_id
GROUP BY YEAR(Landing_page_w_sessions.week_start_date) , WEEK(Landing_page_w_sessions.week_start_date);
     
	
-- Conversion funnel Analysis
 
select distinct pageview_url from website_pageviews;

SELECT 
    website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_pageviews.created_at,
    CASE
        WHEN pageview_url = '/products' THEN 1
        ELSE 0
    END AS Product_page,
    CASE
        WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1
        ELSE 0
    END AS mr_fuzzy_page,
    CASE
        WHEN pageview_url = '/cart' THEN 1
        ELSE 0
    END AS cart_page,
    CASE
        WHEN pageview_url = '/shipping' THEN 1
        ELSE 0
    END AS shipping_page,
    CASE
        WHEN pageview_url = '/billing' THEN 1
        ELSE 0
    END AS billing_page,
    CASE
        WHEN pageview_url = '/thank-you-for-your-order' THEN 1
        ELSE 0
    END AS thankyou_page
FROM
    website_sessions
        LEFT JOIN
    website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE
    website_pageviews.created_at > '2012-08-05'
        AND website_pageviews.created_at < '2012-09-05'
        AND website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand'
        AND website_pageviews.pageview_url IN ('/lander-1' , '/products',
        '/the-original-mr-fuzzy',
        '/cart',
        '/shipping',
        '/billing',
        '/thank-you-for-your-order')	
ORDER BY website_sessions.website_session_id , website_pageviews.pageview_url;

create temporary table conversion_funnels
select 
website_session_id, 
max(Product_page) as Product_made_it,
max(mr_fuzzy_page) as Mr_fuzzy_made_it,
max(cart_page) as Cart_made_it,
max(shipping_page) as Shipping_made_it,
max(billing_page) as billing_made_it,
max(thankyou_page) as thankyou_made_it
from (
SELECT 
    website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_pageviews.created_at,
    CASE
        WHEN pageview_url = '/products' THEN 1
        ELSE 0
    END AS Product_page,
    CASE
        WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1
        ELSE 0
    END AS mr_fuzzy_page,
    CASE
        WHEN pageview_url = '/cart' THEN 1
        ELSE 0
    END AS cart_page,
    CASE
        WHEN pageview_url = '/shipping' THEN 1
        ELSE 0
    END AS shipping_page,
    CASE
        WHEN pageview_url = '/billing' THEN 1
        ELSE 0
    END AS billing_page,
    CASE
        WHEN pageview_url = '/thank-you-for-your-order' THEN 1
        ELSE 0
    END AS thankyou_page
FROM
    website_sessions
        LEFT JOIN
    website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE
    website_pageviews.created_at > '2012-08-05'
        AND website_pageviews.created_at < '2012-09-05'
        AND website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand'
        AND website_pageviews.pageview_url IN ('/lander-1' , '/products',
        '/the-original-mr-fuzzy',
        '/cart',
        '/shipping',
        '/billing',
        '/thank-you-for-your-order')	
ORDER BY website_sessions.website_session_id , website_pageviews.pageview_url) as conversion_funnel

group by website_session_id;

select * from conversion_funnels;
SELECT 
    COUNT(DISTINCT website_session_id) AS Sessions,
    COUNT(CASE
        WHEN Product_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_products,
    COUNT(CASE
        WHEN Mr_fuzzy_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_Mr_fuzzy,
    COUNT(CASE
        WHEN Cart_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_cart,
    COUNT(CASE
        WHEN Shipping_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_Shipping,
    COUNT(CASE
        WHEN billing_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_billing,
    COUNT(CASE
        WHEN thankyou_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS to_thankyou
FROM
    conversion_funnels;

SELECT 
    COUNT(CASE
        WHEN Product_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(DISTINCT website_session_id) AS Lander_Click_Rate,
    COUNT(CASE
        WHEN Mr_fuzzy_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(CASE
        WHEN Product_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS Product_Click_Rate,
    COUNT(CASE
        WHEN Cart_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(CASE
        WHEN Mr_fuzzy_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS Mr_fuzzy_Click_Rate,
    COUNT(CASE
        WHEN Shipping_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(CASE
        WHEN Cart_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS Cart_Click_Rate,
    COUNT(CASE
        WHEN billing_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(CASE
        WHEN Shipping_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS Shipping_Click_Rate,
    COUNT(CASE
        WHEN thankyou_made_it = '1' THEN website_session_id
        ELSE NULL
    END) / COUNT(CASE
        WHEN billing_made_it = '1' THEN website_session_id
        ELSE NULL
    END) AS billing_Click_Rate
FROM
    conversion_funnels;
    
-- Assignment 2

 select * from website_pageviews
 limit 10;
 
 select min(created_at), min(website_pageview_id) from website_pageviews where pageview_url = "/billing-2";
 
 -- start date for billing-2 is 2012-09-10 00:13:05
 -- first_pageview_id from billing-2 is 53550
 
 create temporary table billing_to_orders
 SELECT 
    website_pageviews.website_session_id,
    website_pageviews.pageview_url AS billing_version_seen,
    orders.order_id
FROM
    website_pageviews
        LEFT JOIN
    orders ON website_pageviews.website_session_id = orders.website_session_id
WHERE
		website_pageviews.created_at < '2012-11-10'
        AND website_pageviews.website_pageview_id > 53550
        AND website_pageviews.pageview_url IN ('/billing' , '/billing-2');

select * from billing_to_orders;
        
select billing_version_seen, count(distinct website_session_id) as Sessions, count(distinct order_id) as orders, count(distinct order_id)/count(distinct website_session_id) as sessions_to_order_cvr_rate

from billing_to_orders
group by billing_version_seen;
        

 
 
 



    



