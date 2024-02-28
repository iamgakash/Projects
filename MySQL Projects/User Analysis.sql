-- User Analysis

-- Assignment 1

-- My solution

create temporary table New_visitors
select 
	user_id
from 
	website_sessions
where 
	created_at >= "2014-01-01" and 
    created_at < "2014-11-01" and
    is_repeat_session = 0;
    
select 
	New_visitors.user_id,
    count(website_sessions.website_session_id) AS SESSIONS
from	
	New_visitors
left join 
	website_sessions on
    New_visitors.user_id = website_sessions.user_id
    WHERE website_sessions.created_at < '2014-11-01'
group by 1;

SELECT 
	Sessions,
    COUNT(user_id) AS Users
FROM
	(select 
	New_visitors.user_id,
    count(website_sessions.website_session_id) AS SESSIONS
from	
	New_visitors
left join 
	website_sessions on
    New_visitors.user_id = website_sessions.user_id
    WHERE website_sessions.created_at < '2014-11-01'
group by 1) AS SESSIONS_COUNT
GROUP BY 1
order BY 1;

-- Video Solution

-- new session only

create temporary table New_users
select 
	user_id,
    website_session_id
from 
	website_sessions
where 
	created_at < "2014-11-01" and created_at > "2014-01-01"
    and is_repeat_session = 0;
 
create temporary table sessions_w_repeatsss
select 
	New_visits.user_id,
    New_visits.website_session_id as new_session_id,
    website_sessions.website_session_id as Repeat_session_id
from 
(select 
	user_id,
    website_session_id
from 
	website_sessions
where 
	created_at < "2014-11-01" and created_at >= "2014-01-01"
    and is_repeat_session = 0)
	as New_visits
left join 
	website_sessions
    on website_sessions.user_id = New_visits.user_id 
    and website_sessions.created_at > "2014-01-01" 
    and website_sessions.created_at < "2014-11-11"
    and is_repeat_session = 1 
    and website_sessions.website_session_id > New_visits.website_session_id;

select * from sessions_w_repeatsss;

select 
	user_id,
    count(distinct new_session_id) as sessions,
    count(distinct Repeat_session_id) as repeat_sessions
from 
	sessions_w_repeatsss
group by 1;

select 
	repeat_sessions,
    count(user_id) as users
from (select 
	user_id,
    count(distinct new_session_id) as sessions,
    count(distinct Repeat_session_id) as repeat_sessions
from 
	sessions_w_repeatsss
group by 1) as user_level
group by 1
order by 1;
SET sql_mode = '';


-- Assignment 2

create temporary table new_visitors
select 
	user_id,
    created_at
from
	website_sessions
where
	created_at < "2014-11-03" and created_at >= "2014-01-01" and is_repeat_session = 0;
    
select 
	new_visitors.user_id,
    new_visitors.created_at as first_appearance,
    min(website_sessions.created_at) as Second_appearance,
    datediff(min(website_sessions.created_at), new_visitors.created_at) AS Daydifference
from
	new_visitors
left join 
	website_sessions on
    new_visitors.user_id = website_sessions.user_id and website_sessions.created_at > new_visitors.created_at and is_repeat_session = 1
        and website_sessions.created_at > "2014-01-01" 
    and website_sessions.created_at < "2014-11-03"

group by 1
having Second_appearance is not null;

select 
	AVG(Daydifference) as Avg_days_first_to_second,
    min(Daydifference) as min_days_first_to_second,
    max(Daydifference) as max_days_first_to_second
from (select 
	new_visitors.user_id,
    new_visitors.created_at as first_appearance,
    min(website_sessions.created_at) as Second_appearance,
    datediff(min(website_sessions.created_at), new_visitors.created_at) AS Daydifference
from
	new_visitors
left join 
	website_sessions on
    new_visitors.user_id = website_sessions.user_id and website_sessions.created_at > new_visitors.created_at and is_repeat_session = 1 and website_sessions.created_at > "2014-01-01" 
    and website_sessions.created_at < "2014-11-03"

group by 1,2
having Second_appearance is not null) as Daydifference;


-- Solution from video

-- Step 1 Identify the relevant new sessions
-- Step 2 User the user_id values from Step 1 to find any Repeat sessions those users had
-- Step 3 Find the created_at times for first and second sessions
-- Step 4 Find the differnces between first and second sessions at a user level
-- Step 5 Aggregate the user level data to find the average, min and max



select 
	user_id,
    created_at,
    website_session_id
from
	website_sessions
where
	created_at < "2014-11-03" and created_at >= "2014-01-01" and is_repeat_session = 0;
    


create temporary table sessions_w_repeats
select
	new_sessions.user_id,
    new_sessions.website_session_id as New_session_id,
    new_sessions.created_at as New_session_created_at,
    website_sessions.website_session_id as Repeat_session_id,
    website_sessions.created_at as Repeat_session_created_at
from
	(select 
	user_id,
    created_at,
    website_session_id
from
	website_sessions
where
	created_at < "2014-11-03" and created_at >= "2014-01-01" and is_repeat_session = 0) 
    as New_sessions
left join 
	website_sessions
    on website_sessions.user_id = New_sessions.user_id
    and website_sessions.is_repeat_session = 1
    and website_sessions.website_session_id > new_sessions.website_session_id
    and website_sessions.created_at < "2014-11-03" 
    and website_sessions.created_at > "2014-01-01";
    
select * from sessions_w_repeats;

-- sub query

select
	user_id,
    new_session_id,
    New_session_created_at,
    min(Repeat_session_id) as second_session_id,
    min(Repeat_session_created_at) as second_session_created_id
from 
	sessions_w_repeats
group by 1,2,3
having min(Repeat_session_id)  is not null;

select 
	user_id,
    datediff(second_session_created_id, New_session_created_at) as date_diff
from (select
	user_id,
    new_session_id,
    New_session_created_at,
    min(Repeat_session_id) as second_session_id,
    min(Repeat_session_created_at) as second_session_created_id
from 
	sessions_w_repeats
group by 1,2,3
having min(Repeat_session_id)  is not null) as first_to_second;

select
	avg(date_diff) as Average,
    min(date_diff) as Min,
    max(date_diff) as Max
from
	(select 
	user_id,
    datediff(second_session_created_id, New_session_created_at) as date_diff
from (select
	user_id,
    new_session_id,
    New_session_created_at,
    min(Repeat_session_id) as second_session_id,
    min(Repeat_session_created_at) as second_session_created_id
from 
	sessions_w_repeats
group by 1,2,3
having min(Repeat_session_id)  is not null) as first_to_second) as final;

-- Assignment 3

 select utm_source, utm_campaign,  http_referer
from website_sessions
where utm_source = 'socialbook' ;

select * from website_sessions;

select
	case when utm_source is null and utm_campaign is null and http_referer is not null then "Organic_search"
    when utm_campaign = "brand" and http_referer is not null then "Paid_brand"
    when utm_campaign = "nonbrand" and http_referer is not null then "Paid_nonbrand"
    when utm_source is null and utm_campaign is null and http_referer is null then "Direct_type_in"
    when utm_source = 'socialbook' and http_referer is not null then "Paid_Social"
    else null end as Channel_group,
    count(distinct case when is_repeat_session = 0 then website_session_id else null end) as New_Sessions,
    count(distinct case when is_repeat_session = 1 then website_session_id else null end) as Repeat_Sessions
from website_sessions
where created_at < "2014-11-05" and created_at > "2014-01-01"
group by 1;

-- Assignment 4

select 
	is_repeat_session,
    count(website_sessions.website_session_id) as Sessions,
    count(orders.order_id)/count(website_sessions.website_session_id) as Conv_rate,
    sum(price_usd)/count(website_sessions.website_session_id) as Revenue_per_session
from 
	website_sessions
left join
	orders
    on website_sessions.website_session_id = orders.website_session_id
where
	website_sessions.created_at < "2014-11-08" and website_sessions.created_at > "2014-01-01"
group by 1;
	
