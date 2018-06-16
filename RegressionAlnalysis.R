source('movies.R')
library(Ecdat)
full<-lm(clean.movies$revenue~clean.movies$budget, na.omit=TRUE, data=clean.movies)
summary(full)
AIC(full)
library(fmsb)
VIF(full)
plot(full)
exp(full$coefficients)

library(car)
crPlots(full)
qqPlot(full$residuals)
ncvTest(full)



