# Różności
Aktualizacja: 2024-07-22 14:34:02, poniedziałek 22 lipca

## Wstawienie do pliku wyjścia komendy systemowej za bieżącą linią

Wstawienie do pliku wyniku komendy `ls`

```
:r!ls
```

Wynik polecenia

```
funkcje.md
komendy.md
pluginy.md
roznosci.md
screenshot.png
skroty.md
src.md
```

## Wstawienie do pliku wyjścia komendy systemowej w bieżącej linii

Wynik komendy usunie zawartość bieżącej linii

```
:.!ls
```

Wynik polecenia

```
funkcje.md
komendy.md
pluginy.md
roznosci.md
screenshot.png
skroty.md
src.md
```
