# Success Code of Netflix Original Movies-Case Study

#### Project URL - https://www.kaggle.com/code/akashg004/success-code-of-netflix-original-movies-case-study
#### Data Source Link - https://www.kaggle.com/datasets/luiscorter/netflix-original-films-imdb-scores

# Introduction

Netflix is a popular streaming service that offers a wide variety of TV shows, movies, documentaries, and more on thousands of internet-connected devices. You can watch as much as you want, whenever you want, without a single commercial – all for one low monthly price. There's always something new to discover, and new TV shows and movies are added every week!

**What is the problem?**

Identifying the characteristics of successful Netflix original movies based on different attributes such as genre, runtime, IMDB score, and language.

**Why is it important to be solved?**

Understanding the features of successful movies can help Netflix in planning and producing more popular and well-received content, thereby attracting a larger audience and increasing its market share in the OTT platform industry.

**Data Dictionary**
*  **Title**: String - The name of the Netflix original movie.
*  **Genre**: String - The category defining the thematic elements of the movie.
*  **Premiere**: Date - The release date of the movie on Netflix.
*  **Runtime**: Integer - The length of the movie in minutes.
*  **IMDB Score**: Float - The rating given to the movie on the IMDB platform.
*  **Language**: String - The language(s) in which the movie is available.

**Questions that this case study trying to solve.**

* What is the average IMDB score for each genre?
* Which genre has the highest average runtime?
* Are longer movies rated higher on IMDB?
* What is the distribution of movies across different languages?
* What is the trend in the number of releases over the years?
* Which year had the highest average IMDB score?
* Are movies in certain languages rated higher on average?
* What is the distribution of IMDB scores?
* What is the most common genre on Netflix?
* What is the average runtime of movies released in different months?

# Data Preparation

- Checked for missing values in the dataset; none were found.
- Converted the 'premiere' column to datetime format for easier date analysis.
- Added 'year' and 'month' columns based on the 'premiere' dates to facilitate temporal analysis.


# Conclusion

In conclusion, our analysis of Netflix original movies has revealed several noteworthy insights. Firstly, the Animation/Christmas/Comedy/Adventure category emerges as the top performer with an impressive average score of 8.20, likely owing to the uplifting nature typical of animated films. Surprisingly, the Musical/Short genre closely follows with an average score of 7.70, despite its concise format. Additionally, Concert Films unexpectedly secure the third spot, showcasing strong performance due to their immersive experiences. Conversely, Heist film/Thriller ranks lowest in average score, indicating potential challenges in delivering expected suspense.

Moreover, our findings suggest that runtime has little to no discernible impact on viewer perception of movie quality, as indicated by the negligible negative correlation coefficient of -0.04 between runtime and IMDB score. This emphasizes that factors such as plot, acting, and directing play more significant roles in determining viewer ratings.

Furthermore, it's evident that English-language movies dominate Netflix's content library, reflecting the platform's global appeal. The data also reveals a clear upward trend in the number of Netflix original movie releases over the years, highlighting Netflix's strategic focus on expanding its original content library to cater to its growing audience and competitive market.

Interestingly, 2015 stands out with the highest average IMDB score, suggesting a particularly successful year for Netflix original movies. Additionally, our analysis underscores the importance of linguistic diversity in Netflix's content strategy, with varying average IMDB scores observed across different language combinations.

Furthermore, the distribution of IMDB scores indicates a prominent peak around a score of 7, with a symmetrical spread suggesting a balanced distribution of ratings. Most Netflix original movies fall within the 5 to 8 score range, indicating that the majority are perceived as average to above-average by viewers.

Lastly, the most common genre on Netflix is Documentary, showcasing the platform's commitment to offering diverse content. Additionally, our analysis of average runtimes across different premiere months reveals varying durations, suggesting a lack of seasonal trends in movie durations.

Overall, these insights provide valuable guidance for Netflix in content planning, production, and audience targeting, ensuring the continued success and growth of its original content offerings.

