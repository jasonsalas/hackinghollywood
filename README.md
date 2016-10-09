# Hacking Hollywood
## Determining the true success of movies in the market
### Motivation
I've been playing with [this wonderful dataset on Kaggle](https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset), which lists metadata for over 5,000 movies on [IMDb](http://www.imdb.com). It's a really neat exercise with lots of applications for statistical analysis and machine learning. One aspect of the information quickly stood out at me: the need to identify exactly what movies are true successes, in terms of their theatrical runs.

I've always been of the opinion that the deterministic measure of any consumer product once released is assessed by the _success tiers_, being **(1) audience approval**, **(2) critical acclaim,** and **(3) commercial achievement**. This is a tough order to fill, and most movies don't even hit the mark at two criteria, much less all three. So I sought out to analyze the data, isolating each tier of success and then comparing the resultant films. 

#### **[SANITZED DATASET](https://docs.google.com/spreadsheets/d/1E8Y79RIQHxjQLNxn6U8mCZsA6zVqfoBMFzeuccLnw1U/edit?usp=sharing)**

### Methodology
This project is a good primer for learning data science with [R](https://www.r-project.org/) - specifically with core R, with no third-party packages or external libraries. First, the data is sanitized to only use the features that are most application for the problem at hand - separate audience approval (the number of votes for a film by fans, the volume of which produces a largely positive impact on the IMDb score), critical acclaim (the number of critic reviews posted), and commercial success (the gross revenue for the film). After formatting of the data and pruning rows with missing or "NA" values, the dataset is whittled-down from 5,043 to 3,709 observations.

### Results
After analyzing the data and comparing the top films in each success tier, the most-successful film is [The Dark Knight](http://www.imdb.com/title/tt0468569/), seeing as how it is the highest rated in 4 of 5 lists (IMDb score, number of critic reviews, gross revenue and net profit. What's also notable is that of the top 5 overall most-successful movies of all time, Christopher Nolan's work claims three spots, with The Dark Knight Rises and Inception staking their claim.

![The Dark Knight - 2008](http://www.dan-dare.org/FreeFun/Images/BatmanDarkKnightWallpaper1024.jpg)

![Success tiers comparisons](https://dl.dropboxusercontent.com/u/12019700/movie-successes.jpg)

### Caveat
A few things to take note of in my methodology: the approach I took is purely subjective on my part. Whether "commercial success" is defined as purely the amount of gross receipts a film earned, or how much actual net profit it generated (gross revenue less the project's budget), is up for debate. I opted for gross revenue, with it being a simpler model with less ambiguity.  

Also, keep in mind that this data is IMDb, so it's slanted towards the Internet subculture, and largely only its post-1998 acquisition by Amazon. So there's some culture and date bias at play. Films not able to take advantage of the modern-era success like The Exorcist and The Godfather trilogy are largely ignored. Also, the revenue data reflects only each film's initial 8- to 12-week theatrical run, not subsequent releases, like for the the original Star Wars films. 
