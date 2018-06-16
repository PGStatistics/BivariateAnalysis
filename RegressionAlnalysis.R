source('movies.R')
library(Ecdat)

powerTransform(clean.movies$revenue) #0.2277891

full<-lm(revenue^0.22~budget+runtime, data=clean.movies)
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

exp(clean.movies$revenue)
