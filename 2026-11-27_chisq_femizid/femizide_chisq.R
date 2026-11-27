# ============================================================
# Femizide in Österreich – Chi-Quadrat-Test
# Datenquelle: Haller/Eberhardt/Temel (2023), Untersuchung Frauenmorde
# (BMJ/BMI/BKA). Details siehe data/README_femizide.md
# ============================================================

library(tidyverse)

# ---------- 1) Täterherkunft x Altersgruppe (PKS 2010–2020) ----------
d1 <- read_csv("data/femizide_taeter_nationalitaet_alter.csv",
               show_col_types = FALSE)

# Lange Tabelle -> Kontingenztafel
tab1 <- d1 |>
  pivot_wider(names_from = altersgruppe, values_from = anzahl) |>
  column_to_rownames("herkunft") |>
  as.matrix()

tab1
chisq.test(tab1)            # Warnung: viele erwartete Häufigkeiten < 5
chisq.test(tab1)$expected

# Robuster: unbekannte Kategorien entfernen und Alter gruppieren
d1_kompakt <- d1 |>
  filter(altersgruppe != "kA",
         herkunft != "staatenlos_ungeklaert_kA") |>
  mutate(altersgruppe = case_when(
    altersgruppe %in% c("10-19", "20-29") ~ "unter 30",
    altersgruppe %in% c("30-39", "40-49") ~ "30-49",
    altersgruppe %in% c("50-59", "60-69") ~ "50-69",
    TRUE                                   ~ "70+"
  )) |>
  summarise(anzahl = sum(anzahl), .by = c(herkunft, altersgruppe))

tab1_kompakt <- d1_kompakt |>
  pivot_wider(names_from = altersgruppe, values_from = anzahl) |>
  column_to_rownames("herkunft") |>
  as.matrix()

tab1_kompakt
chisq.test(tab1_kompakt)

# ---------- 2) Opfer-Nationalität x Täter-Nationalität (Femizide 2016–2020) ----------
d2 <- read_csv("data/femizide_opfer_taeter_nationalitaet.csv",
               show_col_types = FALSE)

tab2 <- xtabs(anzahl ~ opfer_nationalitaet + taeter_nationalitaet, data = d2)
tab2
chisq.test(tab2)
fisher.test(tab2)   # exakter Test bei kleinen Stichproben
