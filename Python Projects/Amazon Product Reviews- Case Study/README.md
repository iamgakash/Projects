# Amazon Product Reviews- Case Study

#### Project URL - https://www.kaggle.com/code/akashg004/amazon-product-reviews-case-study
#### Data Source Link - https://www.kaggle.com/datasets/ahmedsayed564/amazon-sales-dataset

# Introduction

Amazon is a diverse online retailer with a wide selection of products, from electronics and fashion to home goods. 
It provides convenient shopping experiences with fast shipping, reliable customer service, and secure transactions

# What is the problem?

The online retail market is fiercely competitive. Understanding customer preferences, product performance, and market trends can help a retailer stay ahead. The problem here is to analyze the dataset to extract insights that can help in enhancing product visibility, improving customer satisfaction, and eventually, increasing sales.

# Why is it important to be solved?

Solving this problem will not only help in increasing sales but will also enhance the customer's shopping experience. It can aid in personalized marketing, improving product placements, and optimizing the product portfolio, thereby leading to increased customer loyalty and higher profits.

# Data Dictionary

* **product_id:** The unique identifier for each product.
* **product_name:** The name of the product.
* **category:** The category under which the product is listed, further divided into sub-categories separated by "|".
* **discounted_price:** The price of the product after applying the discount.
* **actual_price:** The original price of the product without any discount.
* **discount_percentage:** The percentage of discount offered on the product.
* **rating:** The average rating given to the product by the customers.
* **rating_count:** The number of ratings the product received.
* **about_product:** A brief description of the product.
* **user_id:** The unique identifiers for users who reviewed the product, separated by commas.
* **user_name:** The names of users who reviewed the product, separated by commas.
* **review_id:** The unique identifiers for the reviews, separated by commas.
* **review_title:** The titles of the reviews, separated by commas.
* **review_content:** The content of the reviews, separated by commas.
* **img_link:** The link to the image of the product.
* **product_link:** The link to the product's page on Amazon.

# Questions that this case study is trying to solve.

**Discount Analysis:**
How does the discount percentage affect the rating of a product?

**Category Analysis:**
Which category has the highest average rating?

**Price Analysis:**
Is there a correlation between the product's price and its rating?

**Rating Analysis:**
What is the distribution of ratings across all products?

**Product Analysis:**
Which product has the highest number of reviews and what is its rating?

**User Analysis:**
Identify the top 5 users who have given the most reviews?

**Review Length Analysis:**
Is there a correlation between the length of a review and the rating given?

**Product Description Analysis:**
Can the length of the product description be correlated to the product's rating?

# Data Preparation

- Checked the type of data in each column and made sure it matched its content.
- Found and corrected two missing values in the 'rating_count' column, assuming products with no ratings had a count of zero.
- Confirmed there were no identical rows in the dataset, ensuring data uniqueness.
- Cleaned up the 'number' column by removing unwanted items and converted it to integer or float where applicable for better analysis.

# Conclusion

In conclusion, the analysis of the Amazon dataset reveals several significant findings. Firstly, there exists a negative correlation between discount percentage and product rating, indicating that as discounts increase, there is a slight decrease in average product ratings. Additionally, the 'OfficeProducts' category stands out with the highest average rating, signifying notable customer satisfaction within this category. While a weak positive correlation between price and rating suggests that higher-priced products may receive slightly higher ratings, the predominant distribution of ratings between 4 and 5 underscores the prevalence of positive feedback. Products exhibit consistent ratings ranging from 3.9 to 4.5, with top reviewers playing a significant role in shaping feedback on the platform. Moreover, minimal correlation is observed between review length, product description length, and product rating. These insights offer valuable guidance for strategic decisions in product management and customer satisfaction strategies on Amazon.

