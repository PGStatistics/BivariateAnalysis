#generate class intervals
cIntervals <- classInt::classIntervals(clean.movies$revenue)
classInt::jenks.tests(cIntervals)
intervals <- cIntervals$brks

#generate plot
color_scheme <- c("#581845", "#900C3F", "#C70039", "#FF5733", '#FFC300', '#FFFFAA', '#FFFFFF')
png('class_intervals.png', res=200, width=1300, height=800)
plot(cIntervals, pal=color_scheme, main="Revenue", xlab="", ylab="")
dev.off()
rm(color_scheme)

#class intervals for all genres
genres <- c("Horror", "Romance", "Comedy", "Action", "Fantasy")
for (i in 1:5)
{
  cIntervals <- classInt::classIntervals(var=clean.movies$revenue[grepl(genres[i], clean.movies$genres)], 
                                            style="fixed", fixedBreaks=intervals, intervalClosure = "right", 
                                            n=(length(intervals) - 1))
  cat('~~~~~~~~~~~~~~~~', genres[i], '~~~~~~~~~~~~~~\n')
  print(cIntervals)
  print(classInt::jenks.tests(cIntervals))
}
rm(i)