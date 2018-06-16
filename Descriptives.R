#defining functions
Mode <- function (x) {
  output <- unique(x)
  output[which.max(tabulate(match(x, output)))]
} #mode

IQR <- function (x) {
  return (quantile(x, 0.75 ) - quantile(x, 0.25 ))
} #interquartile range

CV <- function (x) {
  return ((sd(x) / mean(x)) * 100 )
} # coefficient of variation

Q <- function (x) {
  return (IQR(x) / 2 )
} #interquartile deviation

IQRKurtosis <- function (x) {
  return ((quantile(x, 0.75 ) - quantile(x, 0.25 )) / ( 2 * (quantile(x, 0.9 ) - quantile(x, 0.1 ))))
} #interquartile kurtosis / positional

IQRSkewness <- function (x) {
  return (((quantile(x, 0.75 ) - median(x)) - (median(x) - quantile(x, 0.25 )))/((quantile(x, 0.75 ) - median(x)) + (median(x) - quantile(x, 0.25 ))))
} #interquartile skewness

IQRCV <- function (x) {
  return ((Q(x) / median(x)) * 100 )
} #interquartile coefficient of variation

A <- function (x) {
  output <- 0
  for (i in x) {
    output <- output + (i - mean(x)) ^ 3
  }
  output <- output / length(x)
  return (output)
}

Pearson <- function (x) {
  return ((mean(x) - median(x)) / sd(x))
}

Skewness <- function (x) {
  output <- 0
  for (i in x)
  {
    output <- output + (i - mean(x)) ^ 3
  }
  return (output / (length(x) * sd(x) ^ 3 ))
}

Ku <- function (x) {
  output <- 0
  for (i in x)
  {
    output <- output + (i - mean(x)) ^ 4
  }
  output <- output / (length(x) * sd(x) ^ 4 ) - 3
  return (output)
}

#main function
Descriptives <- function (x) {
  cat( "Arithmetic mean:" , mean(x), "\n" )
  cat( "Trimmed mean:" , mean(x, trim= 0.05 , na.rm= TRUE ), "\n" )
  cat( "Winsorized mean:" , psych::winsor.mean(x, trim = 0.1 , na.rm = TRUE ), "\n" )
  cat( "Mode:" , Mode(x), "\n" )
  cat( "Median:" , median(x), "\n" )
  cat( "1st quartile:" , quantile(x, 0.25 ), "\n" )
  cat( "3rd quartile:" , quantile(x, 0.75 ), "\n" )
  cat( "1st decile:" , quantile(x, 0.1 ), "\n" )
  cat( "9th decile:" , quantile(x, 0.9 ), "\n" )
  cat( "65th percentile:" , quantile(x, 0.65 ), "\n" ) 
  cat( "Minimum:" , min(x), "\n" )
  cat( "Maximum: " , max(x), "\n" )
  cat( "Range:" , range(x)[ 2 ] - range(x)[ 1 ], "\n" ) 
  cat( "Interquartile range:" , IQR(x), "\n" ) 
  cat( "Variance:" , var(x), "\n" )
  cat( "Standard deviation:" , sd(x, na.rm= T ), "\n" )
  cat( "Winsorized sd(10%):" , psych::winsor.sd(x, trim= 0.1 ), "\n" )
  cat( "Coefficient of variation:" , CV(x), "\n" )
  cat( "Interquartile deviation:" , Q(x), "\n" ) 
  cat( "Interquartile coefficient of variation:" , IQRCV(x), "\n" )
  cat( "Median absolute deviation:" , sum(abs(x-median(x)))/length(x), "\n" )
  cat( "Mean absolute deviation:" , sum(abs(x-mean(x)))/length(x), "\n" )
  cat( "Pearson's skewness:" , Pearson(x), "\n" ) 
  cat( "Third moment skewness:" , Skewness(x), "\n" ) 
  cat( "Fourth moment kurtosis:" , Ku(x), "\n" )
  cat( "Interquartile skewness:" , IQRSkewness(x), "\n" ) 
  cat( "Interquartile kurtosis:" , IQRKurtosis(x), "\n" ) 
}