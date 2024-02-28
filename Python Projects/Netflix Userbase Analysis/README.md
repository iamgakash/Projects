# Netflix Userbase Analysis

#### Project URL - https://www.kaggle.com/code/akashg004/netflix-userbase-analysis
#### Data Source Link - https://www.kaggle.com/datasets/arnavsmayan/netflix-userbase-dataset

# Introduction

This analysis delves into a comprehensive dataset of Netflix users, examining subscription types, monthly revenue, demographics, and key user characteristics. The dataset, featuring columns like User ID, Join Date, and Country, offers insights into patterns that shape the streaming platform's user landscape. The goal is to unveil key findings through exploratory data analysis, contributing to a nuanced understanding of user preferences and informing decisions for an enhanced Netflix experience.

# Data Description

* **User ID:** Unique identifier for each user.
* **Subscription Type:** Type of subscription (e.g., Basic, Standard, Premium).
* **Monthly Revenue:** Revenue generated from the user's subscription per month.
* **Join Date:** Date when the user joined Netflix.
* **Last Payment Date:** Date of the user's last payment.
* **Country:** User's location.
* **Age:** User's age.
* **Gender:** User's gender.
* **Device:** Device used to access Netflix (e.g., Mobile, Tablet, Computer).

# Data Preparation 

- Conducted a comprehensive assessment of the dataset for the presence of null values, affirming its completeness with no instances of missing data detected.
- Executed a thorough examination of the dataset to identify and eliminate duplicate entries, ensuring data integrity and reliability.
- Implemented a systematic data refinement process by removing the "Plan Duration" attribute, as its singular value across all records rendered it redundant for analytical purposes.
- Facilitated enhanced temporal analysis capabilities by optimizing the datatype of two date columns to datetime format, promoting accuracy and precision in temporal data representation and analysis.

# Conclusions

* The majority of Netflix users (40%) opt for the Basic subscription plan, making it the most popular choice. The Standard plan is selected by about 30.7% of users, and the Premium plan is chosen by approximately 29.3% of users. Lower-priced plans tend to attract more customers.

* The age distribution in the dataset ranges from a minimum of 26 years to a maximum of 51 years. A quarter of the users are 32 years old or younger, while 75% are 45 years old or younger.

* The United States has the highest number of Netflix users, followed by Spain and Canada.

* The gender distribution among Netflix users is nearly balanced, with slightly more females than males.

* Device usage to access Netflix is well-distributed among users, with approximately a quarter of users accessing the service via various devices, including laptops, tablets, smartphones, and Smart TVs.

* The analysis reveals slight variations in age distribution among users with different subscription types. For instance, the interquartile range (IQR) for the age of Basic subscribers varies slightly between males and females.

* The Basic plan is popular in the United States, Canada, Italy, Brazil, and Germany. The Standard plan is favored in the United Kingdom and Mexico. Meanwhile, the Premium plan is preferred in Spain, France, and Australia.

* Examining the trends in user sign-ups shows that there were ups and downs over time. In 2022, there was a big increase in new users, especially in October. However, after November, there was a drop in new sign-ups, possibly because of seasons or reaching a point where most people who want Netflix already have it. Additionally, seeing many people making their last payment in June 2023 suggests that a lot of users may have stopped using Netflix around that time.

**The data shows that most people (40%) pick the Basic Netflix plan, which is the cheapest. Some choose the Standard (30.7%) or Premium (29.3%) plans. People using Netflix range from 26 to 51 years old, with many under 32. The United States has the most users, followed by Spain and Canada. Men and women use Netflix equally. People use all kinds of devices to watch. Most money comes from the Basic plan in the U.S. In 2022, more people joined Netflix, but in June 2023, many stopped using it, which might be a problem.**
