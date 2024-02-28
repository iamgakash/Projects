# Adidas Sales EDA

#### Project URL - https://www.kaggle.com/code/akashg004/adidas-sales-eda
#### Data Source Link - https://www.kaggle.com/datasets/heemalichaudhari/adidas-sales-dataset

# Introduction

Within the dynamic retail landscape, the examination of sales data stands as a crucial element in shaping strategic decisions. This project centers around the analysis of Adidas sales data, with the goal of extracting insightful observations, identifying patterns, and revealing opportunities for growth. Utilizing Python and data analysis libraries, the objective is to present a comprehensive view of Adidas' sales performance over a specified period.

# Data Description

* Retailer: The entity or organization selling Adidas products.
* Retailer ID: A unique identifier for each retailer.
* Invoice Date: The date when the sales transaction occurred.
* Region: The geographical region where the retailer operates.
* State: The state within the region where the retailer is located.
* City: The city where the retailer is situated.
* Product: The Adidas product being sold.
* Price per Unit: The cost of one unit of the Adidas product.
* Units Sold: The number of units of the Adidas product sold in a particular transaction.
* Total Sales: The total revenue generated from the sale of Adidas products in a transaction.
* Operating Profit: The profit earned by the retailer from the sale after deducting operating costs.
* Operating Margin: The percentage of operating profit in relation to total sales.
* Sales Method: The method or channel through which the sales transaction occurred.

# Data Preparation

![image](https://github.com/iamgakash/Projects/assets/159927555/cd40b0dd-fc01-4f71-9e96-215a2f2f302b)

- Conducted a meticulous review to identify and remove three superfluous columns and the initial row devoid of meaningful data, thereby enhancing dataset clarity and relevance.
- Applied index reset procedures and subsequently eliminated the prior index to optimize data structure and facilitate streamlined analysis.
- Executed a thorough duplicate assessment, confirming the absence of duplicate entries, thus bolstering data integrity and analytical robustness.
- Implemented datatype modifications for select columns to ensure alignment with their respective data types, thereby enhancing data consistency and analytical accuracy.

# Coclusions

**Product Category Analysis:**

**Top Selling Product Category:**

* Men's Street Footwear is the top-selling category, followed by Men's Athletic Footwear.
* Women's Apparel holds the 3rd place, while Men's Apparel is the least-selling category.

**Regional Sales Analysis:**

* The West region leads in total sales, followed by the Northwest.
* The Midwest contributes to only 15.1% of total sales, making it a minor contributor.

**Retailer Performance:**

* West Gear leads in operating profit, followed closely by Foot Locker and Sports Direct.
* Kohl's, Amazon, and Walmart have significant contributions but are less compared to the top 3.

**State and City Sales Analysis:**

* New York state has the highest total sales, and New York City is the top-selling city.
* Nebraska is the least-selling state, and Omaha is the least-selling city.
* The other 4 states (Minnesota, Iowa, Wisconsin, North Dakota) in the bottom 5 have sales around 7 million dollars.

**Sales Method and Pricing:**

* The majority of sales (39.6%) are In-Store, followed by Outlet (32.8%) and Online (27.5%).
* Price per unit follows a normal distribution, peaking at 40 Dollars.

**Price per Unit vs Total Sales:**

* Products priced at 60 Dollars, 65 Dollars, and 70 Dollars have higher sales.
* There is a positive relationship between price per unit and total sales.

**Monthly Sales and Profit Trends:**

* Sales and profit show significant growth from 2020 to 2021.
* Peaks in sales and profit are observed in July for both years.
* December has the lowest sales and profit for both years.

**Regional Sales Distribution:**

* The treemap visually represents sales distribution across different regions and states.
* It highlights the top-selling states in each region.

**Overall Insights:**

This report gives a thorough picture of Adidas' sales performance across all product categories, geographical areas, retailers, and sales methods. Strategic decisions require knowledge of the best-performing product categories, regions, and merchants. The relationship between price per unit and overall sales is favorable, which points to the potential for improving product pricing strategies.

The analysis also identifies seasonal patterns in sales and profit, highlighting the significance of efficient inventory control and marketing plans during busy times. The regional sales distribution can also direct resource allocation and targeted marketing campaigns to increase sales in particular regions.

For Adidas to experience greater development and profitability, critical business choices such as inventory planning, marketing initiatives, and regional focus regions can be informed by the information gleaned from this analysis.





