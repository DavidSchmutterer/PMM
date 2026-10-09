# Antwort

Alles klar — hier die Antwort kompakt und auf den Punkt, mit **Diagrammen** ergänzt. Kurz gesagt: In deinem Stoff ist fast alles, was mit **Rechnen von Wahrscheinlichkeiten/Quantilen** und mit **Zeichnen von Diagrammen** zu tun hat, in R deutlich schneller und fehlerfreier.

## Wo R am meisten bringt (nach Inhalt sortiert)

### Statistik – Kennzahlen & Diagramme
**Von Hand:** Werte sortieren, Summen, Quadrate, Wurzel, Quartile suchen, Boxplot auf Karopapier malen.

**In R (1 Zeile):**
```r
x <- c(12,15,11,18,14,13,17,16,12,15)

mean(x); median(x); sd(x); var(x)   # Mittelwert, Median, Stdabw, Varianz
quantile(x); IQR(x); range(x)       # Quartile, IQR, Spannweite
summary(x)                          # alles auf einmal

boxplot(x, col = "lightblue")        # Boxplot (Ausreißer automatisch!)
hist(x, breaks = 8)                  # Histogramm
pie(table(df$Kategorie))             # Kreisdiagramm
barplot(table(df$Kategorie))         # Balkendiagramm
boxplot(Wert ~ Gruppe, data = df)    # Gruppenvergleich
```
➡️ **Gewinn:** riesig. Kein Sortier-/Rundungsfehler, sofort abgabefertige Grafik.

### Binomialverteilung
**Von Hand:** `C(n,k)·p^k·(1-p)^(n-k)` für jedes k einzeln summieren.

**In R:**
```r
dbinom(5, 20, 0.3)              # P(X = 5)
pbinom(5, 20, 0.3)             # P(X <= 5)
pbinom(8, n, p) - pbinom(4, n, p)  # P(5 <= X <= 8)
1 - pbinom(10, n, p)          # P(X > 10)
qbinom(0.95, n, p)            # Quantil
```
➡️ **Gewinn:** riesig, besonders bei großem n (von Hand praktisch unmöglich).

### Normalverteilung
**Von Hand:** z-Tabelle lesen, zwischen Zeilen interpolieren.

**In R:**
```r
pnorm(120, mean = 100, sd = 15)         # P(X <= 120)
1 - pnorm(120, 100, 15)                 # P(X > 120)
pnorm(120,100,15) - pnorm(90,100,15)    # P(90 <= X <= 120)
qnorm(0.975)                            # z = 1,96
curve(dnorm(x, 100, 15), from=40, to=160)  # Glockenkurve plotten
```
➡️ **Gewinn:** riesig. Beliebige Genauigkeit, keine Tabelle.

### t-Verteilung
**Von Hand:** t-Tabelle, kritische Werte, KI-Formel `x̄ ± t·s/√n`.

**In R:**
```r
pt(2.1, df = 15)        # Fläche links
qt(0.975, df = 15)      # kritischer t-Wert
t.test(x)               # 95%-Konfidenzintervall + Test fixfertig
t.test(x, mu = 15)      # Test gegen Sollwert
```
➡️ **Gewinn:** riesig. KI und Tests in einem Befehl statt mehrstufiger Rechnung.

### Bonus: Verstehen durch Simulation
```r
rbinom(1000, 20, 0.3)   # 1000 simulierte binomiale Stichproben
rnorm(1000, 100, 15)    # 1000 normalverteilte Werte
```
Damit kannst du sehen, **warum** der Boxplot/Histogramm so aussieht – mit echten Daten statt Theorie.

---

## Kurzfazit

| Inhalt | Mit R vereinfachbar? | Warum |
|---|---|---|
| Kennzahlen | sehr stark | eine Zeile statt langer Summen |
| Boxplot / Diagramme | sehr stark | sofort saubere Grafik, Ausreißer automatisch |
| Binomialverteilung | sehr stark | exakt & kumuliert ohne Summieren |
| Normalverteilung | sehr stark | keine z-Tabelle/Interpolation |
| t-Verteilung | sehr stark | KI & Test fertig |
| Verständnis/Schularbeit-Rechenweg | teilweise | R prüft, ersetzt aber nicht den Rechenweg |
