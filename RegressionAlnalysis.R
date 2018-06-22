#https://data.library.virginia.edu/diagnostic-plots/
source('movies.R')
library(Ecdat)

powerTransform(clean.movies$revenue) #0.2277891
pom<-lm(revenue~clean.movies$budget+clean.movies$runtime+clean.movies$popularity+clean.movies$vote_average+clean.movies$vote_count+clean.movies$original_language+clean.movies$production_countries,data=clean.movies)
step(pom, direction="both")


full<-lm(revenue^0.22~budget+runtime, data=clean.movies)
summary(full)
AIC(full)
library(fmsb)
VIF(full)
par(mfrow=c(2,2))
plot(full)
exp(full$coefficients)

library(car)
crPlots(full)
qqPlot(full$residuals)
ncvTest(full)

exp(clean.movies$revenue)


library(leaps)
best.subset<-regsubsets(revenue^0.22~budget+runtime, data=clean.movies,nvmax=5) 
podsumowanie<-summary(best.subset)
podsumowanie$outmat
plot(best.subset, scale="adjr2")
