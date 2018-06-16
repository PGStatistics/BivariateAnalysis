#Project
#reading data
library(readr)
raw.war_zagr <- read_delim("data/Zatrudnieni w warunkach zagrożenia wg grup i nasilenia.csv", 
                          ";", escape_double = FALSE, col_types = cols(X155 = col_skip()), 
                          trim_ws = TRUE)
raw.szpitale <- read_delim("data/Liczba ludności na łóżko w szpitalach ogólnych.csv", 
                           ";", escape_double = FALSE, col_types = cols(X19 = col_skip()), 
                           trim_ws = TRUE)
raw.gosp_wodna <- read_delim("data/Nakłady na środki trwałe służące gospodarce wodnej wg kierunków inwestowania.csv", 
                             ";", escape_double = FALSE, col_types = cols(X136 = col_skip()), 
                             trim_ws = TRUE)
raw.ochr_pow <- read_delim("data/Ochrona powietrza atmosferycznego i klimatu.csv", 
                           ";", escape_double = FALSE, col_types = cols(X129 = col_skip()), 
                           trim_ws = TRUE)
raw.choroby <- read_delim("data/Zachorowania na choroby zakaźne i zatrucia.csv", 
                          ";", escape_double = FALSE, col_types = cols(X507 = col_skip()), 
                          trim_ws = TRUE)
raw.sport_zesp <- read_delim("data/Ćwiczący w sekcjach sportowych wg sportów - gry zespołowe.csv", 
                             ";", escape_double = FALSE, col_types = cols(X163 = col_skip()), 
                            trim_ws = TRUE)
raw.sport_pozost <- read_delim("data/Ćwiczący w sekcjach sportowych wg sportów - pozostałe.csv", 
                               ";", escape_double = FALSE, col_types = cols(X419 = col_skip()), 
                               trim_ws = TRUE)

#remove NAs
raw.sport_pozost[is.na(raw.sport_pozost)] <- 0
raw.sport_zesp[is.na(raw.sport_zesp)] <- 0

#cleaning
clean.sport_pozost <- data.frame(raw.sport_pozost$Nazwa, raw.sport_pozost[,3:10], row.names=1)
names(clean.sport_pozost) = col.names=c(seq(2002,2016,2))
for (k in 1:8)
{
  for (i in seq(k + 10, 418, 8))
  {
    for(j in 1:17)
    {
      clean.sport_pozost[j,k] <- clean.sport_pozost[j,k] + as.numeric(raw.sport_pozost[j,i])
    }
  }
}

clean.sport_zesp <- data.frame(raw.sport_zesp$Nazwa, raw.sport_zesp[,3:10], row.names=1)
names(clean.sport_zesp) = col.names=c(seq(2002,2016,2))
for (k in 1:8)
{
  for (i in seq(k + 10, 162, 8))
  {
    for(j in 1:17)
    {
      clean.sport_zesp[j,k] <- as.numeric(clean.sport_zesp[j,k]) + as.numeric(raw.sport_zesp[j,i])
    }
  }
}

clean.szpitale <- data.frame(raw.szpitale[,-c(1,18)], row.names=1)
names(clean.szpitale) <- 2002:2016
View(clean.szpitale)

clean.ochr_pow <- data.frame(raw.ochr_pow[,2:20], row.names=1)
names(clean.ochr_pow) <- 1999:2016
View(clean.ochr_pow)

#liczba zachorowań na grypę
plot(1999:2016, c(as.numeric(raw.choroby[1,453:458]), as.numeric(raw.choroby[1,441:452])), xlim=c(1999, 2016))
lines(1999:2004, as.numeric(raw.choroby[1,453:458]), col="red")
lines(2005:2016, as.numeric(raw.choroby[1,441:452]), col="green")
lines(2004:2005, as.numeric(raw.choroby[1,c(458,441)]), col="black")

clean.grypa <- data.frame(raw.choroby[,c(2,453:458,441:452)], row.names=1)
names(clean.grypa) <- 1999:2016
View(clean.grypa)

#obtaining descriptives
source('Descriptives.R')
Descriptives(as.numeric(data.matrix(clean.grypa[2:17,])))
