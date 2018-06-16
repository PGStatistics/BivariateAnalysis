raw.movies <- readr::read_csv("data/tmdb_5000_movies.csv")

clean.movies <- raw.movies[raw.movies$revenue != 0,]

source('Descriptives.R')
Descriptives(clean.movies$revenue)
Descriptives(clean.movies$revenue[grepl("Fantasy", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Romance", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Horror", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Action", clean.movies$genres)])
Descriptives(clean.movies$revenue[grepl("Comedy", clean.movies$genres)])