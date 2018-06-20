layout(mat=matrix(data=c(1, 2, 3, 4, 5, 6), nrow=2))

plot(density(clean.movies$revenue), main="Full dataset")
boxplot(clean.movies$revenue, main="Full dataset")

upperInnerFence <- as.numeric(quantile(clean.movies$revenue, 0.75)+1.5*IQR(clean.movies$revenue))
upperOuterFence <- as.numeric(quantile(clean.movies$revenue, 0.75)+3*IQR(clean.movies$revenue))

clean.movies <- clean.movies[clean.movies$revenue < upperOuterFence,]

plot(density(clean.movies$revenue), main="Below upper outer fence")
boxplot(clean.movies$revenue, main="Below upper outer fence")

clean.movies <- clean.movies[clean.movies$revenue < upperInnerFence,]

plot(density(clean.movies$revenue), main="Below upper inner fence")
boxplot(clean.movies$revenue, main="Below upper inner fence")

lowerInnerFence <- as.numeric(quantile(clean.movies$revenue, 0.25)-1.5*IQR(clean.movies$revenue))
lowerrOuterFence <- as.numeric(quantile(clean.movies$revenue, 0.25)-3*IQR(clean.movies$revenue))
