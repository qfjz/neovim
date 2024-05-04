# Komendy

Aktualizacja: 2024-02-27 13:30:15, wtorek 27 lutego

Lista dostępnych komend

| Komenda                | Opis                                                                                       |
|------------------------|--------------------------------------------------------------------------------------------|
| `Kolory`               | Komenda uruchamia menu wyboru schematu kolorystycznego z podglądem na żywo                 |
| `CDFD`                 | Zmienia katalog na katalog edytowanego pliku                                               |
| `CD`                   | Uruchamia menu z wyborem katalogu                                                          |
| `CDE`                  | Uruchamia menu z wyborem katalogu a następnie uruchamia w nim menadżer plików              |
| `CDG`                  | Sprawdza czy plik znajduje się w repozytoriujm Git i wyświetla jego główny katalog         |
| `NvimAppName`          | Wyświetla nazwę konfiguracji Neovim                                                        |
| `Config`               | Edycja plików konfiguracyjnych                                                             |
| `Skroty`               | Otwiera okno listy skrótów klawiszowych                                                    |
| `Fileinfo`             | Wyświetla informacje o pliku                                                               |
| `PU`                   | Uruchamia funkcję `PU()` wykonującą komendę `git pull`                                     |
| `GP`                   | Uruchamia funkcję `GP()` wykonującą skrypt `gp.sh`                                         |
| `GPS`                  | Uruchamia funkcję `GPS()` wykonującą skrypt `gps.sh`                                       |
| `GI`                   | Uruchamia funkcję `GI()` wykonującą skrypt `gi.sh` wyświetla informacje o repozytorium Git |
| `OstatniaAktualizacja` | Uruchamia funkcję `OstatniaAktualizacja()`                                                 |
| `TermGitStatus`        | Uruchamia komendę `git status` w terminalu systemowym                                      |
| `TermGitPull`          | Uruchamia komendę `git pull` w terminalu systemowym                                        |
| `TermPs`               | Uruchamia komendę `ps ax` w terminalu systemowym                                           |
| `BiPolar`              | Zamienia słowa np: `true` na `false`, `on` na `off`, itp.                                  |
| `OpenFile`             | Otwiera plik o nazwie słowa pod kursorem w lokalizacji względnej `src/<słowo>`             |
| `Docs`                 | Przeszukuje katalog z dokumentacją dla nvim-qfjz                                           |

## Różności

| Komenda      | Opis                                       |
|--------------|--------------------------------------------|
| `:let @+=@%` | Kopiuje nazwę pliku do schowka systemowego |
| `:let @+=@1` | Kopiuje zawartość rejestru `1` do schowka systemowego |

## Lista dodatkowych komend oferofwanych przez zainstalowane pluginy

### Plugin `nredir.nvim`

Nredir przekierowuje wynik polecenia do nowego bufora

Przykłąd komendy:

```lua
Nredir lua print(vim.inspect(vim.fn.api_info()))
```
