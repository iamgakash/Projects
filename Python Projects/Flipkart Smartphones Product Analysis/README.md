# Flipkart Smartphones Product Analysis

#### Project URL - https://www.kaggle.com/code/akashg004/flipkart-smartphones-product-analysis
#### Data Source Link - https://www.kaggle.com/datasets/dnyaneshyeole/flipkart-smartphones-dataset

# Introduction

Understanding consumer preferences, market trends, and the factors influencing purchasing decisions is crucial in the dynamic environment of the smartphone industry. This data analysis project explores the vast dataset, which includes a wide range of smartphones from various brands and was gathered from Flipkart, one of India's top online marketplaces.

# Data Description

* brand: The brand of the smartphone, such as Samsung, Apple, Xiaomi, etc.
* model: The name and model number of the smartphone, such as iPhone 12, Samsung Galaxy A33, Redmi Note 10, etc.
* colour: The colour of the smartphone, such as sandy gold, sunrise blue, etc.
* original_price: The original price of the smartphone in Indian rupees (INR) before any discounts.
* discounted_price: The discounted price of the smartphone in INR after any discounts or promotions.
* ratings: The average rating of the smartphone by customers on the Flipkart website, on a scale of 1 to 5 stars.
* rating count: The number of ratings given by customers on the Flipkart website for the smartphone.
* reviews: The text reviews given by customers on the Flipkart website for the smartphone.
* memory: The amount of RAM memory included in the smartphone measured in gigabytes (GB).
* storage: The amount of internal storage included in the smartphone measured in gigabytes (GB).
* processor: The type and speed of the processor included in the smartphone, such as Qualcomm Snapdragon 888, Apple A14 Bionic, etc.
* rear_camera: The number and specifications of the rear cameras included in the smartphone, such as 48 MP + 12 MP + 5 MP, etc.
* front_camera: The number and specifications of the front camera included in the smartphone, such as 20 MP, etc.
* display_size: The diagonal size of the smartphone screen measured in centimeters (cm).
* battery_capacity: The capacity of the smartphone battery measured in milliampere-hours (mAh).

# Data Preparation 

- Conducted a comprehensive examination to identify and eliminate duplicate entries, ensuring data integrity and reliability.
- Streamlined dataset structure by removing the 'battery_type' column, aligning with analytical objectives and enhancing dataset clarity.
- Conducted a meticulous assessment of null values post-column removal, followed by judicious cleaning procedures to address missing data points with appropriate values tailored to individual column contexts.
- Enhanced data consistency and readability by renaming the 'memory' column to 'RAM' for clarity and standardization.
- Standardized textual representations within the 'processor' column to uppercase format, ensuring uniformity and facilitating efficient data processing.
- Augmented analytical insights by introducing a new column termed 'price segment,' derived from the 'original_price' attribute to mitigate potential data discrepancies arising from promotional pricing dynamics.
  - Budget Segment: Price Range up to INR 15,000
  - Mid-Range Segment: Price Range INR 15,000 to INR 30,000
  - Upper Mid-Range Segment: Price Range INR 30,000 to INR 50,000
  - Flagship Segment: Price Range INR 50,000 and above
    
# Conclusions

**Models by Brands in Number**

* Xiaomi, Realme, and Samsung have a significant presence, indicating a wide range of smartphone options in the market.
* This diversity suggests a cutthroat environment where brands compete to satisfy different consumer preferences.

**Average Brand Rating**

* With the highest average rating, Apple stands out, demonstrating the company's dedication to quality and customer satisfaction.
* Realme and Google closely follow, indicating a cutthroat market where many brands are selling well-liked smartphones.

**Distribution based on brand:**

* Apple consistently keeps high ratings, demonstrating a high level of customer satisfaction.
* Most brands have ratings higher than 4.0, which shows that the market as a whole is satisfied.
* Ikall and other companies with lower ratings may need to address customer concerns and raise product quality.
 
**Top & Bottom 10 Smartphones by Rating:**

* The fact that Apple dominates the top-rated smartphones is a testament to the company's reputation for excellence.
* The bottom list includes some newer brands that point to potential areas for improvement.

**Distribution of ratings by price segment:**

* Flagship smartphones consistently receive higher ratings, which is consistent with the relationship between price and customer satisfaction.
* Positive reviews for budget and mid-range smartphones also indicate that customers find value in these categories.

**Front Camera vs. Rear Camera:**

* The majority of smartphones come equipped with multiple rear cameras, a common 50MP sensor, and a standard 16MP or 8MP front camera.
* Dual front cameras are less common. Brands prioritize rear camera configurations

**The Top 10 Processors for Smartphones:**

* The market is dominated by Mediatek and Qualcomm processors, with MEDIATEK HELIO G35 being the most popular.

**Storage vs. Memory:**

* Phones frequently come with 128GB of storage and a range of RAM options.
* 2GB RAM phones have a wide range of storage options, reflecting entry- level smartphones.

**Relationship Among Battery Capacity, Storage, and RAM:**

* The majority of phones have 4GB RAM, 128GB of storage, and a 5000mAh battery.
* Higher RAM phones tend to have larger battery capacities, offering a balance between performance and battery life.

**Battery Capacity Comparison by Brand:**

* Apple frequently keeps its battery capacity a secret.
* Most brands focus on the 5000mAh range, with Samsung producing more phones in the 5000- 6000mAh range.
* Brands generally avoid phones with batteries under 4000mAh, indicating a market preference for longer battery life.

**Distribution of Display Sizes:**

* The most popular screen sizes are around 6.5 to 6.6 inches, with 6.59 inches being the most common.
* Majority of phones fall in the 6.4 to 6.72 inches range, catering to users who prefer larger displays.
* Compact phones with 6.0-inch screens also have a niche market.
