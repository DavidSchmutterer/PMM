# Femizide in Österreich – Daten für einen Chi-Quadrat-Test

Diese beiden CSV-Dateien enthalten aggregierte Häufigkeiten (keine Einzelfälle).
Jede Zeile ist eine Zelle einer Kontingenztafel und kann direkt mit
`read_csv()` eingelesen werden.

## Quelle

Haller, Birgitt / Eberhardt, Viktoria / Temel, Brigitte (2023):
*Untersuchung Frauenmorde – eine quantitative und qualitative Analyse.*
Im Auftrag des Bundeskanzleramts, des Bundesministeriums für Inneres und des
Bundesministeriums für Justiz. Wien.

- Volltext: https://www.bmj.gv.at/dam/bmvrdjgvat/content/service/publikationen/Untersuchung-Frauenmorde-%E2%80%93-eine-qualitative-und-quantitative-Analyse.pdf
- Kurzfassung im SIAK-Journal 4/2023: https://bmi.gv.at/104/wissenschaft_und_forschung/siak-journal/siak-journal-ausgaben/jahrgang_2023/files/haller_4_2023.pdf

Die Rohdaten stammen aus der **Polizeilichen Kriminalstatistik (PKS)** bzw. aus
einer Aktenauswertung von Gerichts-/Staatsanwaltschaftsakten.

---

## Datei 1: `femizide_taeter_nationalitaet_alter.csv`

**Tatverdächtige bei Morden und Mordversuchen mit weiblichen Opfern in
Österreich, 2010–2020** (PKS; Tabelle A 40 der Studie, n = 767).

| Spalte | Bedeutung |
|---|---|
| `herkunft` | Staatsangehörigkeit der tatverdächtigen Person: `Oesterreich`, `EU_Mitgliedsstaat`, `Drittstaat`, `staatenlos_ungeklaert_kA` |
| `altersgruppe` | Altersgruppe in Jahren: `10-19`, `20-29`, …, `90-99`, `kA` |
| `anzahl` | Anzahl der Tatverdächtigen in dieser Zelle |

Wichtig: Diese Tabelle umfasst **alle** bei der Polizei angezeigten vollendeten
Morde und Mordversuche mit weiblichen Opfern – also nicht nur Femizide im engeren
Sinn. Sie ist die einzige öffentlich tabellierte Kreuzung von Täterherkunft und
Alter in der Studie. Die Randsummen stimmen mit den Tabellen A 12 und A 13 der
Studie überein (Österreich 499, EU 83, Drittstaaten 140, staatenlos/ungeklärt/k.A. 45;
Gesamt 767).

## Datei 2: `femizide_opfer_taeter_nationalitaet.csv`

**Nationalität der Femizid-Opfer nach Staatsbürgerschaft des Täters,
2016–2020** (Aktenauswertung; Tabelle B 40 der Studie, n = 98).

| Spalte | Bedeutung |
|---|---|
| `opfer_nationalitaet` | `Oesterreich` oder `EU_oder_Drittstaat` |
| `taeter_nationalitaet` | `Oesterreich` oder `nicht_Oesterreich` |
| `anzahl` | Anzahl der Femizid-Opfer in dieser Zelle |

Im Original steht in der Tabellenüberschrift „n=78“; die Fußnote und die
Zeilensummen ergeben jedoch **98** Opfer mit bekannter Nationalität
(64 + 7 + 8 + 19 = 98). Die 78 ist ein Tippfehler in der Publikation.

---

## Interpretationshinweise (wichtig)

- **Tatverdächtige ≠ Verurteilte.** Die PKS zählt Verdächtige, nicht rechtskräftig
  Verurteilte. Außerdem sind Mordversuche enthalten.
- **Staatsangehörigkeit ≠ Migrationshintergrund ≠ Ethnie.** Eingebürgerte Personen
  mit Migrationshintergrund zählen als „Österreich“. Die Studie erhebt den
  Migrationshintergrund separat (2016–2020: 42,1 % der Femizid-Täter).
- **Keine Kausalaussage.** Eine Überrepräsentation einzelner Gruppen in der
  Kriminalstatistik ist kein Beweis für einen kulturellen oder ethnischen
  Zusammenhang. Sie kann u. a. mit Altersstruktur, sozioökonomischer Lage,
  Anzeigeverhalten und Staatsbürgerschaftsrecht zusammenhängen.
- **Kleine Zellen.** Bei 4 × 9 Zellen sind viele erwartete Häufigkeiten < 5.
  Für einen sauberen Chi-Quadrat-Test daher Altersgruppen zusammenfassen und
  die Kategorie „staatenlos/ungeklärt/k.A.“ weglassen (siehe Code unten) oder
  den exakten Test verwenden.
- Die Daten beziehen sich auf **2010–2020** (Datei 1) bzw. **2016–2020**
  (Datei 2). Neuere Femizid-Zahlen (z. B. AÖF-Jahreslisten) sind nicht nach
  Täterherkunft kreuztabelliert und daher für einen Chi-Quadrat-Test weniger
  geeignet.

---

## R-Beispiel

```r
library(tidyverse)

# ---------- Datei 1: Herkunft x Altersgruppe ----------
d1 <- read_csv("data/femizide_taeter_nationalitaet_alter.csv",
               show_col_types = FALSE)

# Lange Tabelle -> Kontingenztafel
tab1 <- d1 |>
  pivot_wider(names_from = altersgruppe, values_from = anzahl) |>
  column_to_rownames("herkunft") |>
  as.matrix()

chisq.test(tab1)              # Warnung wegen kleiner erwarteter Häufigkeiten
chisq.test(tab1)$expected     # erwartete Häufigkeiten ansehen

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

# ---------- Datei 2: Opfer x Täter (Femizide) ----------
d2 <- read_csv("data/femizide_opfer_taeter_nationalitaet.csv",
               show_col_types = FALSE)

tab2 <- xtabs(anzahl ~ opfer_nationalitaet + taeter_nationalitaet, data = d2)
tab2
chisq.test(tab2)
fisher.test(tab2)   # exakter Test, empfohlen bei kleinen Stichproben
```
