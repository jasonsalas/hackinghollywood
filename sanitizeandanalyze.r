# read the data in
movies <- read.csv("movie_metadata.csv")

# take only important features to be analyzed
movies <- movies[, c("movie_title","title_year", "content_rating", "duration", "budget", "gross", "imdb_score", "num_voted_users", "num_user_for_reviews", "num_critic_for_reviews")]

# create a computed column calculating each movie's profit
movies$net.income <- movies$gross - movies$budget

# reorder the columns
movies <- movies[, c("movie_title","title_year", "content_rating", "duration", "net.income", "budget", "gross", "imdb_score", "num_voted_users", "num_user_for_reviews", "num_critic_for_reviews")]

# convert the title feature to characters, not a factor
movies$movie_title <- as.character(movies$movie_title)

# eliminate rows with NA values or duplicate entries
movies <- na.omit(movies)
movies <- unique(movies)

# filter the rows to only movies with the MPAA's major ratings
movies <- subset(movies, content_rating %in% c("G", "PG", "PG-13", "R", "X"))

# drop any zero-value rating categories so only the MPAA's major ratings remain
movies$content_rating <- factor(movies$content_rating)

# scale-down the expense/revenue features 
movies[, 5:7] <- sapply(movies[,5:7], function(x) { return(round(x/1000000,digits=0)) })

# NOTE: the resultant sanitized dataset contains 3,709 rows and 11 columns, pared-down from 5,043 rows and 28 columns (74% of the original dataset)


##################
# PROBLEM: isolate the trifecta tiers of a film's success
# 1. Audience approval (user reviews and possible correlation to IMDb score)
# 2. Critical acclaim (critics' reviews)
# 3. Commercial success (gross box office earnings compared to total profit)
##################

mean(movies$imdb_score)
# 6.446401

# 1. Audience approval
# TODO: calculate the importance of the variables from (imdb_score, num_voted_users and num_user_for_review) and sort in that order to the overall score
# NOTE: the caret package would probably be best for feature selection in this instance
cor(x=movies$imdb_score, y=movies$num_voted_users, method=c("spearman"))
# 0.4838426
cor(x=movies$imdb_score, y=movies$num_user_for_reviews, method=c("spearman"))
# 0.382183

# from the correlation above, the # of users voting is more important to the IMDb score than the # of user reviews posted for the film
head(movies[order(-movies$imdb_score, -movies$num_voted_users, -movies$num_user_for_reviews), -c(5:7,11)], n=100)

# 2. Critical acclaim: 
head(movies[order(-movies$num_critic_for_reviews), -c(8:10)], n=100)

# 3. Commercial success
head(movies[order(-movies$gross, -movies$net.income), -c(4, 8:11)], n=100)

# determine which films are true successes, in terms of which movies achieve all three tiers
true.hollywood.success <- list()
true.hollywood.success <- append(true.hollywood.success, audience.approval$movie_title)
true.hollywood.success <- append(true.hollywood.success, critical.acclaim$movie_title)
true.hollywood.success <- append(true.hollywood.success, commercial.success$movie_title)
true.hollywood.success <- as.character(true.hollywood.success[duplicated(true.hollywood.success)])

# print the pared-down vector of films that appear in at least two lists
> unique(true.hollywood.success)
# [1] "The Dark Knight Rises"                             "Django Unchained"                                 
# [3] "Skyfall"                                           "Interstellar"                                     
# [5] "The Dark Knight"                                   "Inception"                                        
# [7] "The Wolf of Wall Street"                           "Inside Out"                                       
# [9] "Whiplash"                                          "V for Vendetta"                                   
#[11] "Oz the Great and Powerful"                         "Captain America: Civil War"                       
#[13] "RoboCop"                                           "The Great Gatsby"                                 
#[15] "Avatar"                                            "Jurassic World"                                   
#[17] "The Avengers"                                      "Star Wars: Episode IV - A New Hope"               
#[19] "Avengers: Age of Ultron"                           "The Hunger Games: Catching Fire"                  
#[21] "The Lion King"                                     "Toy Story 3"                                      
#[23] "Iron Man 3"                                        "The Hunger Games"                                 
#[25] "Finding Nemo"                                      "The Lord of the Rings: The Return of the King"    
#[27] "Deadpool"                                          "The Jungle Book"                                  
#[29] "American Sniper"                                   "The Lord of the Rings: The Two Towers"            
#[31] "Spider-Man 3"                                      "Alice in Wonderland"                              
#[33] "Guardians of the Galaxy"                           "Forrest Gump"                                     
#[35] "Batman v Superman: Dawn of Justice"                "Iron Man"                                         
#[37] "The Lord of the Rings: The Fellowship of the Ring" "Star Wars: Episode VI - Return of the Jedi"       
#[39] "The Hobbit: An Unexpected Journey"                 "Up"                                               
#[41] "Man of Steel"                                      "Star Wars: Episode V - The Empire Strikes Back"   
#[43] "Gravity"                                           "The Amazing Spider-Man"                           
#[45] "Captain America: The Winter Soldier"               "Star Trek"                                        
#[47] "The Hobbit: The Desolation of Smaug"  

# run the same line of R code to determine which films appear in all three categories (audience approval, critical acclaim, commercial success)
true.hollywood.success[duplicated(true.hollywood.success)]
#[1] "The Dark Knight"            "The Dark Knight Rises"      "Captain America: Civil War" "Inside Out"                
#[5] "Skyfall"                    "Inception"  

top <- c("The Dark Knight", "The Dark Knight Rises", "Captain America: Civil War", "Inside Out", "Skyfall", "Inception")
subset(movies[order(-movies$imdb_score), ], movie_title %in% top)
#                    movie_title title_year content_rating duration net.income budget gross imdb_score num_voted_users num_user_for_reviews num_critic_for_reviews
# 67              The Dark Knight       2008          PG-13      152        348    185   533        9.0         1676169                 4667                    645
# 98                    Inception       2010          PG-13      148        133    160   293        8.8         1468200                 2803                    642
# 4         The Dark Knight Rises       2012          PG-13      164        198    250   448        8.5         1144337                 2701                    813
# 79                   Inside Out       2015             PG       95        181    175   356        8.3          345198                  773                    536
# 28   Captain America: Civil War       2016          PG-13      147        157    250   407        8.2          272670                 1022                    516
# 31                      Skyfall       2012          PG-13      143        104    200   304        7.8          522030                 1498                    750

subset(movies[order(-movies$imdb_score), ], movie_title %in% top)
subset(movies[order(-movies$net.income), ], movie_title %in% top)
subset(movies[order(-movies$gross), ], movie_title %in% top)
subset(movies[order(-movies$num_critic_for_reviews), ], movie_title %in% top)
subset(movies[order(-movies$num_voted_users), ], movie_title %in% top)
