# Różności
Aktualizacja: 2024-07-22 17:02:26, poniedziałek 22 lipca

## Uruchomienie komendy systemowej

```
:!ls
```

Wyjście zostanie wyświetlone w postaci komunikatu edytora

```
:messages
```

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

## Wykonanie polecenia na bieżącej linii

Wynik komendy usunie zawartość bieżącej linii

```
:.!base64 -
V3luaWsga29tZW5keSB1c3VuaWUgemF3YXJ0b8WbxIcgYmllxbzEhWNlaiBsaW5paQo=

:.!base64 -d
Wynik komendy usunie zawartość bieżącej linii
```

## Nadpisanie pliku wynikiem komendy

```
:%!ls
```

## Zastąpienie zaznaczenia wynikiem komendy

```
:'<,'>!ls
```

## Wstawienie zmiennej do pliki z poziomu funkcji


```lua
local time = vim.fn.strftime("%s")
vim.api.nvim_put({time}, "c", true, true)
```
