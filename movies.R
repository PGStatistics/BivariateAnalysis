raw.movies <- readr::read_csv("data/tmdb_5000_movies.csv")

clean.movies <- raw.movies[raw.movies$revenue != 0,]

#checking outliers
plot(density(clean.movies$revenue), main="Full dataset")
boxplot(clean.movies$revenue, main="Full dataset")

upperInnerFence <- as.numeric(quantile(clean.movies$revenue, 0.75)+1.5*IQR(clean.movies$revenue))
upperOuterFence <- as.numeric(quantile(clean.movies$revenue, 0.75)+3*IQR(clean.movies$revenue))

clean.movies <- raw.movies[raw.movies$revenue < upperOuterFence,]

plot(density(clean.movies$revenue), main="Below upper outer fence")
boxplot(clean.movies$revenue, main="Below upper outer fence")

clean.movies <- raw.movies[raw.movies$revenue < upperInnerFence,]

plot(density(clean.movies$revenue), main="Below upper inner fence")
boxplot(clean.movies$revenue, main="Below upper inner fence")

source('Descriptives.R')
Descriptives(clean.movies$revenue)
Descriptives(clean.movies$revenue[grepl("Fantasy", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Romance", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Horror", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Action", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Comedy", clean.movies$genres)])