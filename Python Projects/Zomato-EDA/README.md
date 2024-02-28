# Exploring Zomato Bangalore Data

#### Project URL - https://www.kaggle.com/code/akashg004/zomato-eda
#### Data Source Link - https://www.kaggle.com/datasets/himanshupoddar/zomato-bangalore-restaurants

# Introduction

Bangalore's dining scene has significantly changed over the years, making it known for its diverse culinary landscape. Leading restaurant discovery site Zomato has had a significant impact on how people in the city experience food. The Zomato Bangalore dataset is the subject of this Python project's in-depth exploratory data analysis( EDA).

To gain insightful knowledge about Bangalore's food culture, the dataset will be cleaned and analyzed using Python. This project shows how effective EDA is at identifying patterns, trends, and intriguing data observations.

# Data Description

* name - name of the restaurant
* online_order - online ordering is available or not
* book_table - table booking option available or not
* rate - average rating of the restaurants out of 5
* votes - contains total number of votes for the restaurant
* location - location of the restaurant
* rest_type - restaurant type
* cuisines - cuisines (comma seperated)
* approx_cost(for two people) - contains the approximate cost of meal for two people
* listed_in(type) - type of meal
* listed_in(city) - contains the neighborhood in which the restaurant is located

# Data Preparation

- Conducted selective column pruning to eliminate irrelevant data fields from the dataset.
- Implemented duplicate record elimination procedures to ensure data integrity and accuracy.
- Executed a standardized cleaning process for the 'rate' column, removing extraneous characters such as '/5' from each entry to facilitate uniformity.
- Developed a dedicated function to streamline the cleansing process for the 'rate' column, enhancing efficiency and maintainability.
- Employed data sanitization techniques to remove extraneous commas from the 'approx_cost(for two people)' attribute, enhancing consistency and usability.
- Employed rigorous null value handling protocols, including the removal of null entries to maintain data integrity and analysis robustness, without resorting to imputation strategies.
- Enacted datatype transformations for specific columns to optimize their utility and compatibility with subsequent analytical procedures.

# Conclusions

- **Customer Ratings:** The majority of restaurants in Bangalore receive ratings between 3 to 4, indicating a generally positive sentiment among customers. This aligns with the central tendency observed in the histogram, revealing a bell- shaped curve.

- **Table Booking and Online Ordering:** While the majority of restaurants offer online ordering options, a sizable portion of them do not offer table booking services. This suggests a move away from traditional reservations and toward convenience in the form of online ordering.

- **Top Restaurant Types:** Quick Bites, Casual Dining, and Cafes are the most prevalent restaurant types in Bangalore.

- **Location Analysis:** Koramangala emerges as a hotspot with the highest number of restaurants, followed by the BTM area. 

- **Cuisine Preferences:** North Indian and Chinese cuisines are the most popular, with Desserts, Ice Cream, and Beverages also have significant demand. 

- **Cost and Rating Relationship:** The average cost for two people and restaurant ratings are positively correlated. Customers tend to associate quality with a higher price point, as evidenced by the higher ratings that higher-cost establishments typically receive.

- **Vote Distribution:** There is a positive correlation between higher ratings and more votes, The majority of restaurants receive votes below 277. Affordable locations with average cost for two ranging from 0 to 1000 tend to win more votes.

- **Rating Distribution by Location:** Different areas in Bangalore exhibit varying rating distributions, with Church Street and Brigade Road showcasing higher average ratings and  Mg road
Koramangala all blocks, Brigade road, Church street, Lavelle road, Residency road have good majority rating distribution

- **Cuisine and Rating Relationship:** North Indian cuisine exhibits a diverse rating distribution, while desserts, ice cream and beverages stand out as particularly well-received cuisines when it comes to rating distribution. Restaurants that serve both Chinese and Momos dishes frequently get good reviews.





  
