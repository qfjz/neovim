# Przypisane skróty klawiszowe

| Skrót         | Opis                                                                                      |
|---------------|-------------------------------------------------------------------------------------------|
| `Shift+Enter` | Dodaje pustą linię powyżej bieżącej                                                       |
| `Enter`       | Dodaje pustą linię poniżej bieżącej                                                       |
| `<leader>n`   | Uruchamia menadżer plików NeoTree                                                         |
| `\`           | Uruchamia menadżer plików NeoTree                                                         |
| `gh`          | Początek linii                                                                            |
| `gl`          | Koniec linii                                                                              |
| `<leader>,`   | Poprzeni bufor                                                                            |
| `<leader>.`   | Następny bufor                                                                            |
| `<leader>w`   | Zapisanie zmian                                                                           |
| `qq`          | Wyjśćie                                                                                   |
| `<leader>;`   | Wejście do trybu COMMAND                                                                  |
| `<c-h>`       | Przechodzi do okna po lewej                                                               |
| `<c-l>`       | Przechodzi do okna po prawej                                                              |
| `<c-j>`       | Przechodzi do okna niżej                                                                  |
| `<c-k>`       | Przechodzi do okna wyżej                                                                  |
| `<leader>so`  | Wczytuje bieżący plik Lua                                                                 |
| `<leader>d`   | Usuwa bufor                                                                               |
| `gf`          | Otwiera plik pod kursorem                                                                 |
| `<leader>sv`  | Dzieli okno w pionie                                                                      |
| `<leader>sp`  | Dzieli okno w poziomie                                                                    |
| `<leader>v`   | Wyszukiwarka plików konfiguracyjnych                                                      |
| `<leader>C`   | Tworzy nowy plik                                                                          |
| `<F9>`        | Zmiana tematu kolorystycznego w zależności od pory dnia                                   |
| `Ctrl+/`      | Tworzy komentarz                                                                          |
| `+`           | Zwiększa wartość liczby                                                                   |
| `-`           | Zmniejsza wartość liczby                                                                  |
| `<leader>b`   | Przełączanie pomiędzy buforami                                                            |
| `<tab>`       | Przełączanie pomiędzy dwoma ostatnimi buforami                                            |
| `<leader>o`   | Pozostawia otwarte tylko aktywne okno                                                     |
| `<leader>c`   | Zamyka aktywne okno                                                                       |
| `<esc>`       | Wyłącza wyróżnianie szukanego tekstu                                                      |
| `<leader>g`   | FzfLua live grep                                                                          |
| `<leader>f`   | FzfLua files                                                                              |
| `<leader>l`   | Uruchamia menadżer plików LF                                                              |
| `U`           | Przywraca zmiany                                                                          |
| `gj`          | Następna zmiana w pliku - Git                                                             |
| `gk`          | Poprzednia zmiana w pliku - Git                                                           |
| `Alt+o`       | Hydra menu                                                                                |
| `s + 2 znaki` | Rozpoczyna wyszukiwanie za pomocą pluginu `flash.nvim`                                    |
| `<leader>z`   | Uruchamia tryb Zen                                                                        |
| `vv`          | Zaznacza linię pomijając puste znaki na początku i znak końca linii                       |
| `vd`          | Sprawdza czy kolejna linia jest identyczna, jeśli tak usuwa jedną z nich                  |

## Kopiowanie, usuwanie i wklejanie

- Skopiowany tekst jest przechowywany w rejestrze `0`
- Usunięty tekst jest przechowywany w rejestrze `1`

| Skrót         | Opis                                                                                      |
|---------------|-------------------------------------------------------------------------------------------|
| `<leader>r`   | Wkleja z wybrangeo rejestru                                                               |
| `<leader>yy`  | Kopiuje linię pomijając puste znaki na początku i znak końca linii                        |
| `<leader>y`   | Kopiuje do schowka systemowego, rozpoczynając sekwecję np. `<leader>yap`                  |
| `<leader>y`   | `VISUAL` Kopiuje zaznaczenie do schowka systemowego                                       |
| `<leader>Y`   | Kopiuje do schowka systemowego od kursora do końca linii                                  |
| `<leader>p`   | Wkleja tekst bez końca linii w linii poniżej                                              |
| `<leader>P`   | Wkleja tekst bez końca linii w linii powyżej                                              |
| `<leader>p`   | `VISUAL` Wkleja, nie podmieniając rejestru                                                |
| `<leader>x`   | Usuwa obiekt tekstowy nie kopiując go do rejestru np: `<leader>xd` lub `<leader>xiw`      |
| `<leader>x`   | `VISUAL` usuwa zaznaczenie nie kopiując go do rejestru                                    |
| `<leader>xx`  | Usuwa linię nie kopując do rejestru                                                       |
| `,p`          | Wkleja ostatnio skopiowany tekst, **NIE** ten wycięty / usunięty                          |
| `,P`          | Wkleja ostatnio skopiowany tekst, **NIE** ten wycięty / usunięty                          |
| `dh`          | Usuwa od kursora do początku linii                                                        |
| `dl`          | Usuwa od kursora do końca linii                                                           |
| `yA`          | Kopiuje całą zawartość pliku do rejestru                                                  |
| `<space>m`    | Kopiuje zawartość głównego rejestru do rejestru `x`                                       |
| `M`           | Wkleja zawartość rejestru `x`, standardowo klawisz `M` przenosi kursor na środek ekranu   |
| `tt`          | Dublowanie linii                                                                          |
| `<leader>cp`  | Klonuje cały paragraf                                                                     |
