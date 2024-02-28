# BankOpt: Targeted Marketing Analysis

## What is the problem?
How can a bank increase the success rate of its term deposit subscription through targeted marketing strategies based on the profiles of its clients?

## Why is it important to solve it?
Subscriptions to term deposits represent a significant revenue stream for banks. By understanding the profiles of clients who are more likely to subscribe, banks can tailor their marketing strategies, reduce costs, and increase their profitability.

## Data Dictionary

- age: (numeric)
- job: type of job (categorical: "admin.","unknown","unemployed","management","housemaid","entrepreneur","student",
                                       "blue-collar","self-employed","retired","technician","services") 
- marital: marital status (categorical: "married","divorced","single"; note: "divorced" means divorced or widowed)
- education: (categorical: "unknown","secondary","primary","tertiary")
- default: has credit in default? (binary: "yes","no")
- balance: average yearly balance, in euros (numeric) 
- housing: has housing loan? (binary: "yes","no")
- loan: has personal loan? (binary: "yes","no")

### related with the last contact of the current campaign:

- contact: contact communication type (categorical: "unknown","telephone","cellular") 
- day: last contact day of the month (numeric)
- month: last contact month of year (categorical: "jan", "feb", "mar", ..., "nov", "dec")
- duration: last contact duration, in seconds (numeric)

 ### other attributes:

- campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
- pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric, -1 means client was not previously contacted)
- previous: number of contacts performed before this campaign and for this client (numeric)
- poutcome: outcome of the previous marketing campaign (categorical: "unknown","other","failure","success")

  Output variable (desired target):
- y - has the client subscribed a term deposit? (binary: "yes","no")

## Data Preparation

- Upon thorough examination, no instances of missing values were uncovered within the dataset. Subsequently, adjustments were made to the data types to ensure alignment with their corresponding appropriate formats. Moreover, a meticulous assessment revealed the absence of any duplicate entries, thus preserving the integrity of the dataset.
- In addition to standard attributes, novel features including age_group, has_any_Loans?, and duration_bins were meticulously crafted to provide enhanced granularity and context to the analysis.
- Furthermore, a comprehensive set of measures was meticulously formulated to capture key insights and facilitate in-depth analysis of the dataset.
- 
![image](https://github.com/iamgakash/Projects/assets/159927555/268598d7-e5af-4313-b7fb-db073964a00b)

## We can indeed create a comprehensive profile of an "ideal" client most likely to subscribe to term deposits:

- **Job:** Preferably in management or technician roles, as they exhibit higher subscription rates.
- **Loan Status:** Ideally, clients without any loans, as they have a significantly higher subscription rate compared to those with housing or personal loans.
- **Education:** Clients with secondary education backgrounds are more likely to subscribe, followed by those with tertiary education.
- **Previous Campaign Outcome:** Clients with successful outcomes from previous campaigns are more likely to subscribe, whereas those with failed outcomes have a lower likelihood.
- **Contact Type:** Clients contacted via cellular communication are more likely to subscribe than those contacted through telephone communication.
- **Month:** Clients contacted in May tend to have the highest subscription rate, followed by August and July.
- **Credit Defaults:** Clients with no credit defaults are substantially more likely to subscribe compared to those with credit defaults.
- **Marital Status:** Married individuals have the highest subscription rate, followed by single individuals, while divorced individuals have a lower subscription rate.
- **Duration:** Clients contacted within the duration range of 0-500 seconds exhibit the highest subscription rate


By considering these factors collectively, we can create a detailed profile of an "ideal" client likely to subscribe to term deposits, aiding in targeted marketing strategies and maximizing subscription likelihood




