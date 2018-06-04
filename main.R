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
