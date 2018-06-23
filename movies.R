#reading data
raw.movies <- readr::read_csv("data/tmdb_5000_movies.csv")
clean.movies <- raw.movies[raw.movies$revenue != '0',]

#remove variables
rm(raw.movies)

#top grossing films
other.top <- clean.movies[order(clean.movies$revenue, decreasing = T),c(2, 7, 13)]
other.top <- cbind(spot=1:100, other.top[1:100,])
View(other.top)

#top grossing fantasy films
other.top.fantasy <- other.top[grepl("Fantasy", other.top$genres),]

#percentage of top films
dim(other.top.fantasy)[1] / dim(other.top)[1] * 100

#percentage of total revenue
sum(other.top.fantasy$revenue) / sum(other.top$revenue) * 100

#remove variables
rm(other.top.fantasy, other.top)

#descriprives before removing outliers
source('Descriptives.R')
Descriptives(clean.movies$revenue)
Descriptives(clean.movies$revenue[grepl("Fantasy", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Romance", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Horror", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Action", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Comedy", clean.movies$genres)])

#removing outliers
source('Outliers.R')

#descriptives after removing outliers
Descriptives(clean.movies$revenue)
Descriptives(clean.movies$revenue[grepl("Fantasy", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Romance", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Horror", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Action", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Comedy", clean.movies$genres)])

#remove functions
rm(A, CV, IQR, IQRCV, IQRKurtosis, IQRSkewness, Ku, Mode, Pearson, Q, Skewness, Descriptives)

#extracting season
yq <- zoo::as.yearqtr(zoo::as.yearmon(clean.movies$release_date, "%Y-%m-%d") + 1/12)
clean.movies$release_season <- factor(format(yq, "%q"), levels = 1:4, labels = c("winter", "spring", "summer", "fall"))
rm(yq)

#extracting release month
clean.movies$release_month <- substr(clean.movies$release_date, 6, 7)

#shortening realease date to year
clean.movies$release_date <- substr(clean.movies$release_date, 1, 4)
names(clean.movies)[12] <- 'release_year'

#generating plots
source('Plots.R')

#create class intervals
source('ClassIntervals.R')

sub(".*\"name\": \"(.*)\".*", "\\1", clean.movies$genres, perl=TRUE)
