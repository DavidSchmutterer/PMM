
# HÜ 2026-11-06 – Excel lesen und als CSV schreiben
# Aufgabe: Excel-Datei aus data/ in eine R-Datenstruktur laden
#          und als CSV in output/ speichern.
# ============================================================

library(tidyverse)   
library(readxl)     


# 1) Excel-Datei in eine R-Datenstruktur (Tibble) laden
daten <- read_excel("data/schuhgroessen_jahrgang4.xlsx")

# 2) Kontrolle: Struktur und erste Zeilen ansehen
glimpse(daten)
head(daten)

# 3) Daten als CSV speichern 
write_csv(daten, "output/schuhgroessen_jahrgang4.csv")

# 4) Kontrolle: CSV einlesen und mit dem Original vergleichen
kontrolle <- read_csv("output/schuhgroessen_jahrgang4.csv", show_col_types = FALSE)
stopifnot(nrow(kontrolle) == nrow(daten))

cat("OK:", nrow(daten), "Zeilen und", ncol(daten), "Spalten geschrieben.\n")
