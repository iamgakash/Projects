-- Assignment 1

select
min(date(created_at)) as Week_start_date,
count(distinct website_session_id) as Sessions,
count(distinct case when utm_source = "gsearch" then website_session_id else null end) as Gsearch_sessions,
count(distinct case when utm_source = "bsearch" then website_session_id else null end) as Bsearch_sessions
from website_sessions
where utm_campaign = "nonbrand" and created_at > "2012-08-22" and created_at < "2012-11-29" 
group by yearweek(created_at);


-- Assignment 2

select * from website_sessions
limit 10;

select utm_source, 
count(distinct website_session_id) as sessions,
count(distinct case when device_type = "mobile" then website_session_id else null end) as Mobile_sessions,
count(distinct case when device_type = "mobile" then website_session_id else null end)/count(distinct website_session_id) as pct_mobile
 from website_sessions where utm_source in ("gsearch", "bsearch") and utm_campaign = "nonbrand" and created_at < "2012-11-30" and created_at > "2012-08-22"
 group by 1
 order by sessions desc ;
 
 
 -- Assignment 3
 
 SELECT 
    website_sessions.device_type,
    website_sessions.utm_source,
    COUNT(DISTINCT website_sessions.website_session_id) AS Sessions,
    COUNT(DISTINCT orders.order_id) AS Orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS CVR_rate
FROM
    website_sessions
        LEFT JOIN
    orders ON website_sessions.website_session_id = orders.website_session_id
WHERE
    website_sessions.utm_source IN ('gsearch' , 'bsearch')
        AND website_sessions.utm_campaign = 'nonbrand'
        AND website_sessions.created_at > '2012-08-22'
        AND website_sessions.created_at < '2012-09-19'
GROUP BY 1 , 2;

-- Assignment 4

select min(date(created_at)) as Week_start_date, 
count(case when utm_source = "gsearch" and device_type = "desktop" then website_session_id else null end) as g_dtop_sessions,
count(case when utm_source = "bsearch" and device_type = "desktop" then website_session_id else null end) as b_dtop_sessions,
count(case when utm_source = "bsearch" and device_type = "desktop" then website_session_id else null end)/
	count(case when utm_source = "gsearch" and device_type = "desktop" then website_session_id else null end) as b_pct_of_g_dtop,
count(case when utm_source = "gsearch" and device_type = "mobile" then website_session_id else null end) as g_mobile_sessions,
count(case when utm_source = "bsearch" and device_type = "mobile" then website_session_id else null end) as b_mobile_sessions,
count(case when utm_source = "bsearch" and device_type = "mobile" then website_session_id else null end)/
	count(case when utm_source = "gsearch" and device_type = "mobile" then website_session_id else null end) as b_pct_of_g_mobile
from website_sessions
where created_at < "2012-12-22" and created_at > "2012-11-04" and utm_campaign = "nonbrand"
group by yearweek(created_at);


-- Assignment 5

select * from website_sessions
limit 10;

select 
	year(created_at) as Year, 
    month(created_at) as Month, 
    count(distinct case when utm_campaign = "nonbrand" then website_session_id else null end )as Nonbrand,
    count(distinct case when utm_campaign = "brand" then website_session_id else null end )as Brand,
    count(distinct case when utm_campaign = "brand" then website_session_id else null end )/count(distinct case when utm_campaign = "nonbrand" then website_session_id else null end ) as brand_pct_nonbrand,
    count(distinct case when utm_source is null and utm_campaign is null and http_referer is null then website_session_id else null end) as Direct,
    count(distinct case when utm_source is null and utm_campaign is null and http_referer is null then website_session_id else null end)/count(distinct case when utm_campaign = "nonbrand" then website_session_id else null end ) as direct_pct_nonbrand,
    count(distinct case when utm_source is null and utm_campaign is null and http_referer in( "https://www.gsearch.com", "https://www.bsearch.com") then website_session_id  else null end) as Organic,
    count(distinct case when utm_source is null and utm_campaign is null and http_referer in( "https://www.gsearch.com", "https://www.bsearch.com") then website_session_id  else null end)/count(distinct case when utm_campaign = "nonbrand" then website_session_id else null end ) as Organic_pct_nonbrand
from
	website_sessions
where
	created_at < "2012-12-23"
group by
	1,2;
    

-- Analyzing Business Patterns and seasonality

select 
	website_session_id,
    created_at,
    dayname(created_at)
from
	website_sessions;
    
-- Assignment 1

select year(website_sessions.created_at) as Year, month(website_sessions.created_at) as Month, count(distinct website_sessions.website_session_id) as Sessions, count(distinct orders.order_id) as Orders
from website_sessions 
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at < "2013-01-01"
group by 1,2;

select  min(date(website_sessions.created_at)) as Week_start_date, count(distinct website_sessions.website_session_id) as Sessions, count(distinct orders.order_id) as Orders
from website_sessions 
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at < "2013-01-01"
group by yearweek(website_sessions.created_at);

-- Assignment 2

SELECT 
	hr,
    avg(case when week = 0 then Sessions else null end) as Monday,
	avg(case when week = 1 then Sessions else null end) as Tuesday,
    avg(case when week = 2 then Sessions else null end) as Wednesday,
    avg(case when week = 3 then Sessions else null end) as Thursday,
    avg(case when week = 4 then Sessions else null end) as Friday,
    avg(case when week = 5 then Sessions else null end) as Saturday,
	avg(case when week = 6 then Sessions else null end) as Sunday

from (select date(created_at) as created_at,
	weekday(created_at) as week,
    hour(created_at) as hr,
    count(distinct website_session_id) as Sessions
from
	 website_sessions
where created_at  between  "2012-09-15" and "2012-11-15"
group by 1,2,3) as ss
group by 1;


-- Assignment 2 after understanding

create temporary table sessions_per_weekhour
select date(created_at) as created_at,
weekday(created_at) as week,
hour(created_at) as Hour,
count(distinct website_session_id) as Sessions
from website_sessions
where created_at < "2012-11-15" and created_at >"2012-09-15"
group by 1,2,3;

select * from sessions_per_weekhour;

select hr,
round(avg(case when wkdy = 0 then sessions else null end),1) as Monday,
round(avg(case when wkdy = 1 then sessions else null end),1) as Tuesday,
round(avg(case when wkdy = 2 then sessions else null end),1) as Wednesday,
round(avg(case when wkdy = 3 then sessions else null end),1) as Thursday,
round(avg(case when wkdy = 4 then sessions else null end),1) as Friday,
round(avg(case when wkdy = 5 then sessions else null end),1) as Saturday,
round(avg(case when wkdy = 6 then sessions else null end),1) as Sunday
from (SELECT 
    DATE(created_at) AS created_date,
    WEEKDAY(created_at) AS wkdy,
    HOUR(created_at) AS hr,
    COUNT(DISTINCT website_session_id) AS Sessions
FROM
    website_sessions
WHERE
    created_at BETWEEN '2012-09-15' AND '2012-11-15'
GROUP BY 1 , 2 , 3) as daily_hourly_sessions
group by 1;

