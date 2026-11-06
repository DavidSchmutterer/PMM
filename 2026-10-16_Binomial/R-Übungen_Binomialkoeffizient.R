dbinom(2,5,0.2)
[1] 0.2048
> choose(4, 2)
[1] 6
> choose(5, 0:5)
[1]  1  5 10 10  5  1
> choose(6, 0:6)
[1]  1  6 15 20 15  6  1
> choose(6, 2) + choose(6, 3)
[1] 35
> choose(7, 3)
[1] 35
> choose(4, 2) * 0.3^2 * 0.7^2
[1] 0.2646
> choose(5, 2) * 0.2^2 * 0.8^3
[1] 0.2048
> dbinom(2, size = 5, prob = 0.2)
[1] 0.2048
> dbinom(0:5, size = 5, prob = 0.2)
[1] 0.32768 0.40960 0.20480 0.05120 0.00640 0.00032
> sum(dbinom(0:5, size = 5, prob = 0.2))
[1] 1
> pbinom(2, size = 5, prob = 0.2)
[1] 0.94208
> choose(7, 0:7)
[1]  1  7 21 35 35 21  7  1
> dbinom(2, 5, 0.2)
[1] 0.2048
> dbinom(3, 5, 0.2)
[1] 0.0512
> dbinom(3, 10, 0.2)
[1] 0.2013266
> dbinom(2, 10, 0.2)
[1] 0.3019899
> dbinom(0, 20, 0.05)
[1] 0.3584859
> dbinom(1, 20, 0.05)
[1] 0.3773536
> dbinom(2, 20, 0.05)
[1] 0.1886768
> dbinom(3, 20, 0.05)
[1] 0.05958215
> barplot(dbinom(0:20, 20, 0.05))
Ergebnis: von k=0 zu k=1 steigt es an und fällt dann ziemlich stark bei steigendem k
> choose (0, 0)
[1] 1
Antwort: n über k beschreibt die möglichen Wege. Wenn jetzt gegeben ist: Auf wie wie viele 
Arten kann 0 Objekte aus 0 Objekten auswählen, ist die Antwort 1, weil es dafür genau einen 
Weg gibt (man wählt ichts aus, man tut nichts)
