genres <- c("Horror", "Romance", "Comedy", "Action", "Fantasy")
average_revenue <- rep(0, times=5)
for (i in 1:5)
{
  average_revenue[i] <- mean(clean.movies$revenue[grepl(genres[i], clean.movies$genres)])
}
rm(i)

layout(mat=matrix(c(1)))

#barplot - genres
result <- data.frame(genres=genres, average_revenue=average_revenue)
p <- ggplot2::ggplot(data=result, ggplot2::aes(x=genres, y=average_revenue, fill=genres)) + 
  ggplot2::geom_bar(stat="identity") + 
  ggplot2::geom_text(ggplot2::aes(label=sprintf("%0.2f", round(average_revenue, digits = 2))), vjust=1.6, color="black", size=4.5) + 
  ggplot2::theme(axis.text=ggplot2::element_text(size=12), axis.title=ggplot2::element_text(size=13),
                 plot.title = ggplot2::element_text(size=17)) + 
  ggplot2::guides(fill=FALSE) + 
  ggplot2::labs(title="Movie genres and average revenue", y="Average revenue", x="")
ggplot2::ggsave("plots/bar_genres.png", plot = p, device = "png",
       scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
       dpi = 320, limitsize = TRUE)

#barplot - release month
result <- plyr::ddply(clean.movies,~release_month,plyr::summarise,average_revenue=mean(revenue))
p <- ggplot2::ggplot(data=result, ggplot2::aes(x=release_month, y=average_revenue, fill=release_month)) + 
  ggplot2::geom_bar(stat="identity") + 
  ggplot2::geom_text(ggplot2::aes(label=sprintf("%0.0f", round(average_revenue, digits = 2))), vjust=1.6, color="black", size=4) + 
  ggplot2::theme(axis.text=ggplot2::element_text(size=12), axis.title=ggplot2::element_text(size=13),
                 plot.title = ggplot2::element_text(size=17)) + 
  ggplot2::guides(fill=FALSE) + 
  ggplot2::labs(title="Release month and average revenue", y="Average revenue", x="")
ggplot2::ggsave("plots/bar_month.png", plot = p, device = "png",
                scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
                dpi = 320, limitsize = TRUE)

#barplot - release season
result <- plyr::ddply(clean.movies,~release_season,plyr::summarise,average_revenue=mean(revenue))
p <- ggplot2::ggplot(data=result, ggplot2::aes(x=release_season, y=average_revenue, fill=release_season)) + 
  ggplot2::geom_bar(stat="identity") + 
  ggplot2::geom_text(ggplot2::aes(label=sprintf("%0.0f", round(average_revenue, digits = 2))), vjust=1.6, color="black", size=6) + 
  ggplot2::theme(axis.text=ggplot2::element_text(size=12), axis.title=ggplot2::element_text(size=13),
                 plot.title = ggplot2::element_text(size=17)) + 
  ggplot2::guides(fill=FALSE) + 
  ggplot2::labs(title="Release season and average revenue", y="Average revenue", x="")
ggplot2::ggsave("plots/bar_season.png", plot = p, device = "png",
                scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
                dpi = 320, limitsize = TRUE)

#density plot - seasons
data <- data.frame(revenue=clean.movies$revenue, release_season=clean.movies$release_season)
p <- ggplot2::ggplot(data, ggplot2::aes(x=revenue, fill=release_season, color=release_season)) + 
  ggplot2::geom_density(alpha=0.05) + 
  ggplot2::labs(title="Release season and revenue", y="density", x="revenue") + 
  ggplot2::theme(axis.text=ggplot2::element_text(size=12), axis.title=ggplot2::element_text(size=13), plot.title = ggplot2::element_text(size=17)) +
  ggplot2::geom_vline(data=result, ggplot2::aes(xintercept=average_revenue, color=release_season), linetype="dashed")
ggplot2::ggsave("plots/density.png", plot = p, device = "png",
                scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
                dpi = 320, limitsize = TRUE)

#boxplot - seasons
p <- ggplot2::ggplot(data, ggplot2::aes(x=release_season, y=revenue, color=release_season)) + 
  ggplot2::geom_boxplot(outlier.colour="black", outlier.shape=16, outlier.size=2, notch=F) + 
  ggplot2::theme(axis.text=ggplot2::element_text(size=12), axis.title=ggplot2::element_text(size=13), 
                 plot.title = ggplot2::element_text(size=17)) + 
  ggplot2::labs(title="Release season and revenue",
                y="Average revenue", x="")
ggplot2::ggsave("plots/box_seasons.png", plot = p, device = "png",
                scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
                dpi = 320, limitsize = TRUE)

#pie chart
p <- ggplot2::ggplot(data, ggplot2::aes(x="", y=revenue, fill=release_season))+
  ggplot2::geom_bar(width = 1, stat = "identity") +
  ggplot2::coord_polar("y", start=0) +
  ggplot2::theme(axis.text.x=ggplot2::element_blank()) +
  ggplot2::labs(title="Release season", y="", x="")
ggplot2::ggsave("plots/piechart.png", plot = p, device = "png",
                scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
                dpi = 320, limitsize = TRUE)

rm(genres, average_revenue, p, data, result)


library(leaps)
library(Ecdat)
library(car)
scatterplot(genres, average_revenue)
cor(clean.movies$release_year, clean.movies$revenue,method="pearson", use="complete.obs")
