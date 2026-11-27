library(tidyverse)
date <-read_csv("data/betriebsdaten.csv")

daten <- read_csv("data/betriebsdaten.csv") |>
  mutate(iok = if_else(
    is.na(masse_mm), NA,
    if_else(round(abs(masse_mm - 10), 10) > 0.15,
            "ausserhalb", "in_Toleranz")))
tab <- table(daten$maschine, daten$iok)
