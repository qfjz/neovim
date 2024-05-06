# Komendy

Aktualizacja: 2024-05-05 09:01:14, niedziela 05 maja

Lista dostępnych komend

| Komenda                | Opis                                                                                       |
|------------------------|--------------------------------------------------------------------------------------------|
| `AddBmFile`            | Dodaje plik do zakładek                                                                    |
| `BiPolar`              | Zamienia słowa np: `true` na `false`, `on` na `off`, itp.                                  |
| `BmFiles`              | Przeszukiwarka zakładek                                                                    |
| `BookmarksAllMarks`    | Przegląda wszystkie znaczniki                                                              |
| `BookmarksDelete`      | Usuwa wybrany znacznik                                                                     |
| `BufInfo`              | Informacje o buforze                                                                       |
| `CD`                   | Uruchamia menu z wyborem katalogu                                                          |
| `CDE`                  | Uruchamia menu z wyborem katalogu a następnie uruchamia w nim menadżer plików              |
| `CDFD`                 | Zmienia katalog na katalog edytowanego pliku                                               |
| `CDG`                  | Sprawdza czy plik znajduje się w repozytoriujm Git i wyświetla jego główny katalog         |
| `Config`               | Edycja plików konfiguracyjnych                                                             |
| `DesFree`              | Włącza / wyłącza ozdobne elementy `listchars`                                              |
| `Fileinfo`             | Wyświetla informacje o pliku                                                               |
| `GI`                   | Uruchamia funkcję `GI()` wykonującą skrypt `gi.sh` wyświetla informacje o repozytorium Git |
| `GP`                   | Uruchamia funkcję `GP()` wykonującą skrypt `gp.sh`                                         |
| `GPS`                  | Uruchamia funkcję `GPS()` wykonującą skrypt `gps.sh`                                       |
| `Kolory`               | Komenda uruchamia menu wyboru schematu kolorystycznego z podglądem na żywo                 |
| `NvimAppName`          | Wyświetla nazwę konfiguracji Neovim                                                        |
| `OpenFile`             | Otwiera plik o nazwie słowa pod kursorem w lokalizacji względnej `src/<słowo>`             |
| `OstatniaAktualizacja` | Uruchamia funkcję `OstatniaAktualizacja()`                                                 |
| `PU`                   | Uruchamia funkcję `PU()` wykonującą komendę `git pull`                                     |
| `Skroty`               | Otwiera okno listy skrótów klawiszowych                                                    |
| `TermGitPull`          | Uruchamia komendę `git pull` w terminalu systemowym                                        |
| `TermGitStatus`        | Uruchamia komendę `git status` w terminalu systemowym                                      |
| `TermPs`               | Uruchamia komendę `ps ax` w terminalu systemowym                                           |

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
