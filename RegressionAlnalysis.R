#https://data.library.virginia.edu/diagnostic-plots/
source('movies.R') #remember to compile this before compiling RegressionAnalysis!

pom<-lm(revenue~clean.movies$budget+clean.movies$runtime+clean.movies$popularity+clean.movies$vote_average+
          clean.movies$vote_count+clean.movies$original_language+clean.movies$production_countries+
          clean.movies$spoken_languages+clean.movies$release_year,data=clean.movies)
step(pom, direction="both")

#after step anlysis we select following coefficients:
library(Ecdat)
library(car)
powerTransform(clean.movies$revenue) 
full<-lm(formula = revenue^0.22 ~ clean.movies$budget + clean.movies$runtime + clean.movies$popularity + 
           clean.movies$vote_count , data = clean.movies)
par(mfrow=c(2,2))
plot(full)

summary(full)
AIC(full)
library(fmsb)
VIF(full)


exp(full$coefficients)


crPlots(lm(formula = revenue ~ clean.movies$budget + clean.movies$runtime + clean.movies$popularity + 
             clean.movies$vote_count , data = clean.movies))
qqPlot(full$residuals)
ncvTest(full)

