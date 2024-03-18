# Maven Fuzzy Factory Database Overview

Maven Fuzzy Factory is an eCommerce retailer that specializes in SITUATION products. As a new eCommerce Database Analyst for the company, your role involves working closely with the CEO, the Head of Marketing, and the Website Manager to steer the business by analyzing and optimizing marketing channels, website performance, and product portfolio using SQL.

## Introduction

In your role as an eCommerce Database Analyst at Maven Fuzzy Factory, you are responsible for extracting and analyzing data from the company's database to understand and communicate the story of its growth over the first eight months of operation. The CEO is due to present company performance metrics to the board, and this is an opportunity to showcase the company's analytical capabilities. This report will help you effectively communicate the growth story to the board and highlight your role as the data expert for the company.

## Data Information

The Maven Fuzzy Factory database consists of six tables, each serving a specific purpose. These tables are as follows:

### 1.	website_sessions

Fields:
  - website_session_id (BIGINT UNSIGNED) (PRIMARY KEY)
  - created_at (DATETIME)
  - user_id (BIGINT UNSIGNED)
  - is_repeat_session (SMALLINT UNSIGNED)
  - utm_source (VARCHAR)
  - utm_campaign (VARCHAR)
  - utm_content (VARCHAR)
  - device_type (VARCHAR)
  - http_referer (VARCHAR)


### 2.	website_pageviews

Fields:
-	website_pageview_id (BIGINT UNSIGNED) (PRIMARY KEY)
-	created_at (DATETIME)
-	website_session_id (BIGINT UNSIGNED)
-	pageview_url (VARCHAR)


### 3.	products

Fields:
- product_id (BIGINT UNSIGNED) (PRIMARY KEY)
-	created_at (DATETIME)
- product_name (VARCHAR)

### 4.	orders

Fields:
- order_id (BIGINT UNSIGNED) (PRIMARY KEY)
- created_at (DATETIME)
- website_session_id (BIGINT UNSIGNED)
- user_id (BIGINT UNSIGNED)
- primary_product_id (SMALLINT UNSIGNED)
- items_purchased (SMALLINT UNSIGNED)
- price_usd (DECIMAL)
- cogs_usd (DECIMAL)

### 5.	order_items

Fields:
- order_item_id (BIGINT UNSIGNED) (PRIMARY KEY)
- created_at (DATETIME)
- order_id (BIGINT UNSIGNED)
- product_id (SMALLINT UNSIGNED)
- is_primary_item (SMALLINT UNSIGNED)
- price_usd (DECIMAL)
- cogs_usd (DECIMAL)

### 6.	order_item_refunds

Fields:
- order_item_refund_id (BIGINT UNSIGNED) (PRIMARY KEY)
- created_at (DATETIME)
- order_item_id (BIGINT UNSIGNED)
- order_id (BIGINT UNSIGNED)
- refund_amount_usd (DECIMAL)

These tables hold crucial data that will enable you to quantify the company's growth, optimize marketing channels, and measure website performance. In the upcoming sections, you will explore how to extract and analyze this data to create a compelling growth story for Maven Fuzzy Factory's presentation to the board.

## Midterm Project

### Project Overview

Maven Fuzzy Factory has been operational for approximately eight months, and your CEO needs to present company performance metrics to the board in the upcoming week. As the eCommerce Database Analyst, your primary responsibility is to extract and analyze data from the company's database to quantify the company's growth during this period and effectively communicate this growth story to the board.

### Data Analysis Goals

1.	Quantify Growth: Use SQL to extract and analyze website traffic and performance data from the Maven Fuzzy Factory database to measure the company's growth over the first eight months of operation.

2.	Create a Compelling Story: Present the data in a way that tells the story of how the company achieved this growth, demonstrating your analytical capabilities.

### Email from Cindy (November 27, 2012)

Good morning, I need some help preparing a presentation for the board meeting next week. The board would like to have a better understanding of our growth story over our first 8 months. This will also be a good excuse to show off our analytical capabilities a bit. -Cindy

Cindy, the CEO, has reached out to you on November 27, 2012, requesting your assistance in preparing a presentation for the board meeting. The board's primary interest is gaining insights into the company's growth story during the initial eight months of operation. This presentation is also an opportunity to showcase the analytical capabilities of the company.

Now, you are tasked with leveraging your expertise in SQL to extract, analyze, and effectively communicate the company's growth story to the board. The next sections of your report will delve into the details of the data analysis and presentation.

## Requests:

## 1. Gsearch seems to be the biggest driver of our business. Could you pull monthly 
trends for gsearch sessions and orders so that we can showcase the growth there?

```sql
SELECT
	YEAR(website_sessions.created_at) AS yr, 
    MONTH(website_sessions.created_at) AS mo, 
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions, 
    COUNT(DISTINCT orders.order_id) AS orders, 
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate
FROM website_sessions
	LEFT JOIN orders 
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-11-27'
	AND website_sessions.utm_source = 'gsearch'
GROUP BY 1,2;
```
#### Query Explanation

In this SQL query:
•	We select the year and month of the created_at column to group the data on a monthly basis.
•	We count the distinct website sessions associated with Gsearch as "sessions."
•	We count the distinct orders linked to these sessions as "orders."
•	We calculate the conversion rate as the percentage of orders divided by sessions, rounded to two decimal places.

We use a LEFT JOIN to ensure that all Gsearch sessions are included, even if there were no orders associated with them.
We filter the data to include only records created before November 27, 2012, and where the utm_source is 'gsearch.' The results are grouped by year and month.

![image](https://github.com/iamgakash/Projects/assets/159927555/072e6911-99ce-4375-83b2-ef318119301e)

#### Answer Interpretation

The table provides a monthly breakdown of Gsearch-related website sessions and orders. It is clear that both sessions and orders have been consistently increasing over the months. The conversion rate, which represents the percentage of orders relative to sessions, shows positive growth as well.

This data demonstrates the significant impact of Gsearch on the company's growth story, making it a valuable marketing channel. This information can be used to showcase the company's growth to the board as requested.



## 2.	Next, it would be great to see a similar monthly trend for Gsearch, but this time splitting out nonbrand 
and brand campaigns separately. I am wondering if brand is picking up at all. If so, this is a good story to tell. 

```sql
SELECT
	YEAR(website_sessions.created_at) AS yr, 
    MONTH(website_sessions.created_at) AS mo, 
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS nonbrand_sessions, 
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) AS nonbrand_orders,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_sessions.website_session_id ELSE NULL END) AS brand_sessions, 
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN orders.order_id ELSE NULL END) AS brand_orders
FROM website_sessions
	LEFT JOIN orders 
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-11-27'
	AND website_sessions.utm_source = 'gsearch'
GROUP BY 1,2;
```
#### Query Explanation

In this SQL query:
•	We select the year and month of the created_at column to group the data on a monthly basis.
•	We use conditional statements to count nonbrand sessions, nonbrand orders, brand sessions, and brand orders separately. We determine this based on the utm_campaign value.
•	We perform a LEFT JOIN between the website_sessions and orders tables using the website_session_id to ensure all Gsearch sessions are included, whether they have orders or not.

The data is filtered to include records created before November 27, 2012, and where the utm_source is 'gsearch'. The results are grouped by year and month.

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/8e1c8839-058f-42f9-aef2-b3b2dfad212f)

#### Answer Interpretation

The table provides a monthly breakdown of Gsearch sessions and orders, categorizing them into nonbrand and brand campaigns. This data analysis shows that both nonbrand and brand campaigns have seen growth over the eight-month period.

For brand campaigns, although the numbers are smaller compared to nonbrand campaigns, they have also been steadily increasing, indicating positive traction. This trend could be used as a compelling story to showcase the success and growth of the brand campaign during the presentation to the board.


## 3.	While we’re on Gsearch, could you dive into nonbrand, and pull monthly sessions and orders split by device type? 
I want to flex our analytical muscles a little and show the board we really know our traffic sources. 

```sql
SELECT
	YEAR(website_sessions.created_at) AS yr, 
    MONTH(website_sessions.created_at) AS mo, 
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_sessions.website_session_id ELSE NULL END) AS desktop_sessions, 
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN orders.order_id ELSE NULL END) AS desktop_orders,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_sessions.website_session_id ELSE NULL END) AS mobile_sessions, 
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN orders.order_id ELSE NULL END) AS mobile_orders
FROM website_sessions
	LEFT JOIN orders 
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-11-27'
	AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY 1,2;
```
#### Query Explanation

In this SQL query:
-	We select the year and month of the created_at column to group the data on a monthly basis.
-	We count the distinct website sessions and orders.
-	We use conditional statements to count sessions and orders separately for mobile and desktop devices based on the device_type value.
-	We perform a LEFT JOIN between the website_sessions and orders tables using the website_session_id to ensure all Gsearch sessions are included, whether they have orders or not.
 

The data is filtered to include 'gsearch,' and the utm_campaign records created before November 27, 2012, where the utm_source is is 'nonbrand.' The results are grouped by year and month.

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/fc9e3561-ee1c-4540-84b6-197165c27c0b)


#### Answer Interpretation

The table presents a monthly breakdown of Gsearch sessions and orders for the nonbrand campaign, categorized by mobile and desktop devices. This analysis highlights the company's in-depth understanding of its traffic sources, showcasing the traffic patterns for nonbrand Gsearch sessions on different devices.

The data demonstrates the growth and composition of nonbrand Gsearch sessions and orders, allowing the board to appreciate the company's analytical capabilities and its ability to track and optimize traffic sources effectively. This information can be used to impress the board during the presentation.

## 4.	I’m worried that one of our more pessimistic board members may be concerned about the large % of traffic from Gsearch. 
Can you pull monthly trends for Gsearch, alongside monthly trends for each of our other channels?
 

-- first, finding the various utm sources and referers to see the traffic we're getting

```sql

SELECT DISTINCT 
	utm_source,
    utm_campaign, 
    http_referer
FROM website_sessions
WHERE website_sessions.created_at < '2012-11-27';


SELECT
	YEAR(website_sessions.created_at) AS yr, 
    MONTH(website_sessions.created_at) AS mo, 
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN website_sessions.website_session_id ELSE NULL END) AS gsearch_paid_sessions,
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN website_sessions.website_session_id ELSE NULL END) AS bsearch_paid_sessions,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END) AS organic_search_sessions,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_sessions.website_session_id ELSE NULL END) AS direct_type_in_sessions
FROM website_sessions
	LEFT JOIN orders 
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-11-27'
GROUP BY 1,2;
```
#### Query Explanation

In this SQL query:
- We select the year and month of the created_at column to group the data on a monthly basis.
- We use conditional statements to count sessions for Gsearch, Bsearch, organic search, and direct type-ins.
- We perform a LEFT JOIN between the website_sessions and orders tables using the website_session_id to ensure all sessions are included, whether they have orders or not.
 
The data is filtered to include records created before November 27, 2012. The results are grouped by year and month.

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/74c51480-8a76-4ccb-ae90-01899ff0f0e7)


#### Answer Interpretation

The table provides a monthly breakdown of sessions for different traffic sources, including Gsearch, Bsearch, organic search, and direct type-ins. By presenting data from multiple channels, it showcases the diversity of traffic sources, which can help alleviate concerns about a high percentage of traffic from Gsearch.

This analysis allows the company to demonstrate a comprehensive understanding of its traffic sources, reinforcing the board's confidence in the company's ability to manage and diversify its marketing channels effectively. This information can be used to address concerns during the board meeting.


## 5.	I’d like to tell the story of our website performance improvements over the course of the first 8 months. 
Could you pull session to order conversion rates, by month? 

```sql

SELECT
	YEAR(website_sessions.created_at) AS yr, 
    MONTH(website_sessions.created_at) AS mo, 
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions, 
    COUNT(DISTINCT orders.order_id) AS orders, 
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS conversion_rate    
FROM website_sessions
	LEFT JOIN orders 
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-11-27'
GROUP BY 1,2;

```


#### Query Explanation

In this SQL query:

- We select the year and month of the created_at column to group the data on a monthly basis.
- We count the distinct website sessions and orders.
- We calculate the session to order conversion rate by dividing the count of orders by the count of sessions and multiplying by 100 to express it as a percentage.

The data is filtered to include records created before November 27, 2012. The results are grouped by year and month.

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/91ddef53-b513-4f89-8bed-3bb468ddeb2a)

#### Answer Interpretation

The table provides a monthly overview of website performance improvements over the course of the first 8 months. It includes the number of sessions, the number of orders, and the session to order conversion rate expressed as a percentage.

The data shows an increase in both sessions and orders over the period, with the conversion rate gradually improving. This information allows the company to tell a positive story about its website's performance and growth. The board can gain confidence in the company's ability to optimize its website and convert more sessions into orders.


## 6.	For the gsearch lander test, please estimate the revenue that test earned us 
 
```sql
USE mavenfuzzyfactory;

SELECT
	MIN(website_pageview_id) AS first_test_pv
FROM website_pageviews
WHERE pageview_url = '/lander-1';



-- for this step, we'll find the first pageview id 

CREATE TEMPORARY TABLE first_test_pageviews
SELECT
	website_pageviews.website_session_id, 
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM website_pageviews 
	INNER JOIN website_sessions 
		ON website_sessions.website_session_id = website_pageviews.website_session_id
		AND website_sessions.created_at < '2012-07-28' -- prescribed by the assignment
		AND website_pageviews.website_pageview_id >= 23504 -- first page_view
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY 
	website_pageviews.website_session_id;

-- next, we'll bring in the landing page to each session, like last time, but restricting to home or lander-1 this time
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_landing_pages
SELECT 
	first_test_pageviews.website_session_id, 
    website_pageviews.pageview_url AS landing_page
FROM first_test_pageviews
	LEFT JOIN website_pageviews 
		ON website_pageviews.website_pageview_id = first_test_pageviews.min_pageview_id
WHERE website_pageviews.pageview_url IN ('/home','/lander-1'); 

-- SELECT * FROM nonbrand_test_sessions_w_landing_pages;

-- then we make a table to bring in orders
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_orders
SELECT
	nonbrand_test_sessions_w_landing_pages.website_session_id, 
    nonbrand_test_sessions_w_landing_pages.landing_page, 
    orders.order_id AS order_id

FROM nonbrand_test_sessions_w_landing_pages
LEFT JOIN orders 
	ON orders.website_session_id = nonbrand_test_sessions_w_landing_pages.website_session_id
;

SELECT * FROM nonbrand_test_sessions_w_orders;

-- to find the difference between conversion rates 
SELECT
	landing_page, 
    COUNT(DISTINCT website_session_id) AS sessions, 
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS conv_rate
FROM nonbrand_test_sessions_w_orders
GROUP BY 1; 

-- .0319 for /home, vs .0406 for /lander-1 
-- .0087 additional orders per session

-- finding the most reent pageview for gsearch nonbrand where the traffic was sent to /home
SELECT 
	MAX(website_sessions.website_session_id) AS most_recent_gsearch_nonbrand_home_pageview 
FROM website_sessions 
	LEFT JOIN website_pageviews 
		ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
    AND pageview_url = '/home'
    AND website_sessions.created_at < '2012-11-27'
;
-- max website_session_id = 17145


SELECT 
	COUNT(website_session_id) AS sessions_since_test
FROM website_sessions
WHERE created_at < '2012-11-27'
	AND website_session_id > 17145 -- last /home session
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
;
-- 22,972 website sessions since the test

-- X .0087 incremental conversion = 202 incremental orders since 7/29
	-- roughly 4 months, so roughly 50 extra orders per month. Not bad!

 ```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/1e8798e5-94d0-497f-a0bd-2bebcd008bb6)

#### Answer Interpretation

To estimate the incremental value from the "gsearch lander test," we first compare the conversion rates for the "home" and "lander-1" pages. The "lander-1" page had a higher conversion rate, indicating the effectiveness of the test.

To estimate revenue, we consider the number of sessions since the test that meet the "gsearch nonbrand" and "/home" landing page criteria, resulting in 22,972 sessions. We estimate incremental orders by multiplying this count by the incremental conversion rate. The estimated incremental orders are roughly 202 since July 29, which equates to approximately 50 extra orders per month over a four-month period.

This analysis helps showcase the positive impact of the "gsearch lander test" in terms of conversion rate improvement and potential revenue increase. It can be used to demonstrate the value of such tests to the board.


## 7.	For the landing page test you analyzed previously, it would be great to show a full conversion funnel 
from each of the two pages to orders. You can use the same time period you analyzed last time (Jun 19 – Jul 28).

```sql
SELECT
	website_sessions.website_session_id, 
    website_pageviews.pageview_url, 
    -- website_pageviews.created_at AS pageview_created_at, 
    CASE WHEN pageview_url = '/home' THEN 1 ELSE 0 END AS homepage,
    CASE WHEN pageview_url = '/lander-1' THEN 1 ELSE 0 END AS custom_lander,
    CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page, 
    CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
    CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
    CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
    CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
FROM website_sessions 
	LEFT JOIN website_pageviews 
		ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_sessions.utm_source = 'gsearch' 
	AND website_sessions.utm_campaign = 'nonbrand' 
    AND website_sessions.created_at < '2012-07-28'
		AND website_sessions.created_at > '2012-06-19'
ORDER BY 
	website_sessions.website_session_id,
    website_pageviews.created_at;





CREATE TEMPORARY TABLE session_level_made_it_flagged
SELECT
	website_session_id, 
    MAX(homepage) AS saw_homepage, 
    MAX(custom_lander) AS saw_custom_lander,
    MAX(products_page) AS product_made_it, 
    MAX(mrfuzzy_page) AS mrfuzzy_made_it, 
    MAX(cart_page) AS cart_made_it,
    MAX(shipping_page) AS shipping_made_it,
    MAX(billing_page) AS billing_made_it,
    MAX(thankyou_page) AS thankyou_made_it
FROM(
SELECT
	website_sessions.website_session_id, 
    website_pageviews.pageview_url, 
    -- website_pageviews.created_at AS pageview_created_at, 
    CASE WHEN pageview_url = '/home' THEN 1 ELSE 0 END AS homepage,
    CASE WHEN pageview_url = '/lander-1' THEN 1 ELSE 0 END AS custom_lander,
    CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page, 
    CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
    CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
    CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
    CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
FROM website_sessions 
	LEFT JOIN website_pageviews 
		ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_sessions.utm_source = 'gsearch' 
	AND website_sessions.utm_campaign = 'nonbrand' 
    AND website_sessions.created_at < '2012-07-28'
		AND website_sessions.created_at > '2012-06-19'
ORDER BY 
	website_sessions.website_session_id,
    website_pageviews.created_at
) AS pageview_level

GROUP BY 
	website_session_id
;

 

-- then this would produce the final output, part 1
SELECT
	CASE 
		WHEN saw_homepage = 1 THEN 'saw_homepage'
        WHEN saw_custom_lander = 1 THEN 'saw_custom_lander'
        ELSE 'uh oh... check logic' 
	END AS segment, 
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS to_products,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart,
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS to_shipping,
    COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS to_billing,
    COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) AS to_thankyou
FROM session_level_made_it_flagged 
GROUP BY 1
;



-- then this as final output part 2 - click rates

SELECT
	CASE 
		WHEN saw_homepage = 1 THEN 'saw_homepage'
        WHEN saw_custom_lander = 1 THEN 'saw_custom_lander'
        ELSE 'uh oh... check logic' 
	END AS segment, 
	COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT website_session_id) AS lander_click_rt,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS products_click_rt,
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS mrfuzzy_click_rt,
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS cart_click_rt,
    COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS shipping_click_rt,
    COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS billing_click_rt
FROM session_level_made_it_flagged
GROUP BY 1
;

```
#### Query Explanation

In this SQL query:

•	We create a temporary table "funnel" using Common Table Expressions (CTEs) to track users' progression through the pages, including homepage, custom lander, products page, Mr. Fuzzy page, cart page, shipping page, billing page, and thank-you page.

•	We calculate overall numbers, including sessions, and the number of users who progress to different steps in the funnel.

•	We also calculate clickthrough rates for each step of the funnel.

#### Answer

The query returns the following results:


![image](https://github.com/iamgakash/Projects/assets/159927555/5ccc5696-c729-4268-abd9-822fa82464f9)

#### Answer Interpretation

The table shows the progression of sessions from the landing pages (/home and /lander-1) through various steps in the conversion funnel. It also provides clickthrough rates for

each step. The results help analyze user behavior and identify where users drop off or continue through the funnel.

For instance, it's evident that the "Saw Custom Lander" segment has a higher clickthrough rate for the "Products" and "Mr. Fuzzy" steps compared to the "Saw Homepage" segment. This information can be valuable for optimizing the website's user experience and increasing conversions.

## 8.	I’d love for you to quantify the impact of our billing test, as well. Please analyze the lift generated 
from the test (Sep 10 – Nov 10), in terms of revenue per billing page session, and then pull the number 
of billing page sessions for the past month to understand monthly impact.

```sql

SELECT
	billing_version_seen, 
    COUNT(DISTINCT website_session_id) AS sessions, 
    SUM(price_usd)/COUNT(DISTINCT website_session_id) AS revenue_per_billing_page_seen
 FROM( 
SELECT 
	website_pageviews.website_session_id, 
    website_pageviews.pageview_url AS billing_version_seen, 
    orders.order_id, 
    orders.price_usd
FROM website_pageviews 
	LEFT JOIN orders
		ON orders.website_session_id = website_pageviews.website_session_id
WHERE website_pageviews.created_at > '2012-09-10' -- prescribed in assignment
	AND website_pageviews.created_at < '2012-11-10' -- prescribed in assignment
    AND website_pageviews.pageview_url IN ('/billing','/billing-2')
) AS billing_pageviews_and_order_data
GROUP BY 1
;
-- $22.83 revenue per billing page seen for the old version
-- $31.34 for the new version
-- LIFT: $8.51 per billing page view

SELECT 
	COUNT(website_session_id) AS billing_sessions_past_month
FROM website_pageviews 
WHERE website_pageviews.pageview_url IN ('/billing','/billing-2')
AND created_at BETWEEN '2012-10-27' AND '2012-11-27' -- past month

-- 1,194 billing sessions past month
-- LIFT: $8.51 per billing session
-- VALUE OF BILLING TEST: $10,160 over the past month

```
#### Answer

The query returns the following results:

![image](https://github.com/iamgakash/Projects/assets/159927555/2b4c756b-b3b8-4790-afa5-0482277f0a59)

Number of Billing Page Sessions in the Past Month: 1,193 sessions

#### Answer Interpretation

The analysis shows the impact of the billing test during the test period. The new billing page version (/billing-2) generated higher revenue per billing page session compared to the old version (/billing).

In the past month, there were 1,193 billing page sessions. The calculated lift of $8.51 per billing page session indicates the additional value generated by the new billing page version during the test period. The total value of the billing test is estimated at $10,160 over the past month. This information helps quantify the test's impact on revenue.

## Conclusion

In this analysis, we've delved into various aspects of website performance and marketing campaigns, aiming to provide valuable insights to improve decision-making and demonstrate the effectiveness of different strategies. Here's a summary of our findings:

### Gsearch Performance

Request 1 - We analyzed monthly trends for Gsearch sessions and orders. The data showed consistent growth in sessions and orders from March to November 2012. The conversion rate remained steady at around 4%, indicating a strong performance.

Request 2 - We further segmented Gsearch performance into non-brand and brand campaigns. The analysis revealed that both non-brand and brand campaigns were successful, with a clear upward trend in sessions and orders.

Request 3 - Focusing on non-brand Gsearch, we explored performance by device type. Mobile sessions and orders showed consistent growth, emphasizing the importance of optimizing for mobile traffic.

### Traffic Channels

Request 4 - We examined the performance of various traffic channels, including Gsearch, Bsearch, organic search, and direct traffic. The data showed Gsearch as the primary driver of sessions, with increasing sessions from July to November.

### Website Performance

Request 5 - We analyzed the session-to-order conversion rates for the first eight months. While there were fluctuations, the overall conversion rate improved, demonstrating the effectiveness of website performance improvements.

### A/B Testing

Request 6 - We estimated the incremental revenue generated by the Gsearch lander test, revealing that the test led to roughly 50 extra orders per month, contributing positively to revenue.

Request 7 - For the landing page test, we built a conversion funnel to track user progress from the homepage to the thank-you page. The analysis showed that a significant number of users progressed through the funnel, indicating the effectiveness of the test.

Request 8 - We quantified the impact of the billing test by comparing the revenue per billing page session for different billing page versions. The new billing page version outperformed the old one, leading to additional revenue per session and an estimated $10,160 impact over the past month.

### Key Takeaways

1.	Gsearch was a major driver of website traffic and orders. Both non-brand and brand campaigns were successful in increasing sessions and orders.

2.	Mobile traffic from Gsearch was significant, emphasizing the need for mobile optimization.

3.	A/B testing, such as the lander and billing page tests, proved valuable in generating incremental revenue and improving user experience.

4.	The website's overall performance improved over the months, leading to higher session-to-order conversion rates.
 
5.	Conversion funnels are effective tools for tracking user progress through the website, providing insights into user behavior.

These insights should guide decision-making and strategy development to further enhance website performance and marketing effectiveness. Regular monitoring and analysis of these key metrics will be crucial to maintaining and improving overall performance.

## Final Project


## 1. First, I’d like to show our volume growth. Can you pull overall session and order volume, 
trended by quarter for the life of the business? Since the most recent quarter is incomplete, 
you can decide how to handle it

```sql
SELECT 
	YEAR(website_sessions.created_at) AS yr,
	QUARTER(website_sessions.created_at) AS qtr, 
	COUNT(DISTINCT website_sessions.website_session_id) AS sessions, 
    COUNT(DISTINCT orders.order_id) AS orders
FROM website_sessions 
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1,2
ORDER BY 1,2
;
```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/dbda74f8-7014-4e5b-91b5-8ce08101d65a)


## 2. Next, let’s showcase all of our efficiency improvements. I would love to show quarterly figures 
since we launched, for session-to-order conversion rate, revenue per order, and revenue per session. 

```sql
SELECT 
	YEAR(website_sessions.created_at) AS yr,
	QUARTER(website_sessions.created_at) AS qtr, 
	COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rate, 
    SUM(price_usd)/COUNT(DISTINCT orders.order_id) AS revenue_per_order, 
    SUM(price_usd)/COUNT(DISTINCT website_sessions.website_session_id) AS revenue_per_session
FROM website_sessions 
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1,2
ORDER BY 1,2
;

```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/4d6ff5da-5990-4051-87f1-b909c86e0145)


## 3. I’d like to show how we’ve grown specific channels. Could you pull a quarterly view of orders 
from Gsearch nonbrand, Bsearch nonbrand, brand search overall, organic search, and direct type-in?

```sql

SELECT 
	YEAR(website_sessions.created_at) AS yr,
	QUARTER(website_sessions.created_at) AS qtr, 
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) AS gsearch_nonbrand_orders, 
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) AS bsearch_nonbrand_orders, 
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN orders.order_id ELSE NULL END) AS brand_search_orders,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN orders.order_id ELSE NULL END) AS organic_search_orders,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN orders.order_id ELSE NULL END) AS direct_type_in_orders
    
FROM website_sessions 
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1,2
ORDER BY 1,2

;
```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/d87c6aa2-d628-4581-b621-5f2fe45f6309)

## 4. Next, let’s show the overall session-to-order conversion rate trends for those same channels, 
by quarter. Please also make a note of any periods where we made major improvements or optimizations.

```sql
SELECT 
	YEAR(website_sessions.created_at) AS yr,
	QUARTER(website_sessions.created_at) AS qtr, 
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END)
		/COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS gsearch_nonbrand_conv_rt, 
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) 
		/COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS bsearch_nonbrand_conv_rt, 
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN orders.order_id ELSE NULL END) 
		/COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_sessions.website_session_id ELSE NULL END) AS brand_search_conv_rt,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN orders.order_id ELSE NULL END) 
		/COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END) AS organic_search_conv_rt,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN orders.order_id ELSE NULL END) 
		/COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_sessions.website_session_id ELSE NULL END) AS direct_type_in_conv_rt
FROM website_sessions 
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1,2
ORDER BY 1,2
;

```

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/28329173-5a1a-4b5d-9189-716bede77c86)




## 5. We’ve come a long way since the days of selling a single product. Let’s pull monthly trending for revenue 
and margin by product, along with total sales and revenue. Note anything you notice about seasonality.

```sql

SELECT
	YEAR(created_at) AS yr, 
    MONTH(created_at) AS mo, 
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) AS mrfuzzy_rev,
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE NULL END) AS mrfuzzy_marg,
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) AS lovebear_rev,
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE NULL END) AS lovebear_marg,
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) AS birthdaybear_rev,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE NULL END) AS birthdaybear_marg,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS minibear_rev,
    SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE NULL END) AS minibear_marg,
    SUM(price_usd) AS total_revenue,  
    SUM(price_usd - cogs_usd) AS total_margin
FROM order_items 
GROUP BY 1,2
ORDER BY 1,2
;

```

#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/14c30232-b631-4332-a9ab-b4f1399a33b5)


## 6. Let’s dive deeper into the impact of introducing new products. Please pull monthly sessions to 
the /products page, and show how the % of those sessions clicking through another page has changed 
over time, along with a view of how conversion from /products to placing an order has improved.

```sql
-- first, identifying all the views of the /products page
CREATE TEMPORARY TABLE products_pageviews
SELECT
	website_session_id, 
    website_pageview_id, 
    created_at AS saw_product_page_at

FROM website_pageviews 
WHERE pageview_url = '/products'
;


SELECT 
	YEAR(saw_product_page_at) AS yr, 
    MONTH(saw_product_page_at) AS mo,
    COUNT(DISTINCT products_pageviews.website_session_id) AS sessions_to_product_page, 
    COUNT(DISTINCT website_pageviews.website_session_id) AS clicked_to_next_page, 
    COUNT(DISTINCT website_pageviews.website_session_id)/COUNT(DISTINCT products_pageviews.website_session_id) AS clickthrough_rt,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT products_pageviews.website_session_id) AS products_to_order_rt
FROM products_pageviews
	LEFT JOIN website_pageviews 
		ON website_pageviews.website_session_id = products_pageviews.website_session_id -- same session
        AND website_pageviews.website_pageview_id > products_pageviews.website_pageview_id -- they had another page AFTER
	LEFT JOIN orders 
		ON orders.website_session_id = products_pageviews.website_session_id
GROUP BY 1,2
;
```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/c45ecfcf-2422-468e-bee6-ccedf0dbfbd9)

## 7. We made our 4th product available as a primary product on December 05, 2014 (it was previously only a cross-sell item). 
Could you please pull sales data since then, and show how well each product cross-sells from one another?

```sql
CREATE TEMPORARY TABLE primary_products
SELECT 
	order_id, 
    primary_product_id, 
    created_at AS ordered_at
FROM orders 
WHERE created_at > '2014-12-05' -- when the 4th product was added (says so in question)
;

SELECT
	primary_products.*, 
    order_items.product_id AS cross_sell_product_id
FROM primary_products
	LEFT JOIN order_items 
		ON order_items.order_id = primary_products.order_id
        AND order_items.is_primary_item = 0; -- only bringing in cross-sells;




SELECT 
	primary_product_id, 
    COUNT(DISTINCT order_id) AS total_orders, 
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END) AS _xsold_p1,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END) AS _xsold_p2,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END) AS _xsold_p3,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END) AS _xsold_p4,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p1_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p2_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p3_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p4_xsell_rt
FROM
(
SELECT
	primary_products.*, 
    order_items.product_id AS cross_sell_product_id
FROM primary_products
	LEFT JOIN order_items 
		ON order_items.order_id = primary_products.order_id
        AND order_items.is_primary_item = 0 -- only bringing in cross-sells
) AS primary_w_cross_sell
GROUP BY 1;

```
#### Answer

The query returns the following result:

![image](https://github.com/iamgakash/Projects/assets/159927555/b638de15-33b9-4d4a-877d-1e4dab7aa8eb)

## Insights from Data

– Since the launch of the company in 2012, the following areas have shown substantial growth in a 3-yr span:

- Website session-to-order conversion rate has 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲𝗱 𝗯𝘆 𝟭𝟲𝟱%, with an average conversion rate of 8.4%. Industry-standard conversion rate is 4%.
- Order volume has 𝗴𝗿𝗼𝘄𝗻 𝗯𝘆 𝟴.𝟵𝟯𝟯%.
- Total revenue per month has 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲𝗱 𝗯𝘆 𝟰.𝟮𝟬𝟴%, up from $2,999 in Mar 2012 to $129,213 in Mar 2015.
- Total profit per month outpaced total revenue growth, with an 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲 𝗼𝗳 𝟰.𝟯𝟴𝟭%! 
- Average revenue per order has risen from $49.99 to $62.80, an 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲 𝗼𝗳 𝟮𝟲%. 
- Average revenue per session has 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲𝗱 𝗯𝘆 𝟮𝟯𝟭%, from $1.60 to $5.30 per website visit. 
- There’s growth in brand recognition. From the latest quarter, Brand/Organic/Direct Type-In search channels make up 𝟭/𝟯 𝗼𝗳 𝗮𝗹𝗹 𝗼𝗿𝗱𝗲𝗿𝘀. This is up from 16% of all orders in Q2 2012, the 2nd Quarter of the business. 
- The conversion rate of product-page-visits-to-orders has 𝗶𝗻𝗰𝗿𝗲𝗮𝘀𝗲𝗱 𝗯𝘆 𝟳𝟴%. 
- The best-converting cross-sell purchase is a combo order of "Birthday Bear" with "Mini Bear", with a whopping 𝗰𝗼𝗻𝘃𝗲𝗿𝘀𝗶𝗼𝗻 𝗿𝗮𝘁𝗲 𝗼𝗳 𝟮𝟮%! 

