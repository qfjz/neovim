# Różności

Aktualizacja: 2024-07-29 10:58:22, poniedziałek 29 lipca

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

## Wczytanie kilku pierwszych linii pliku

Wstawienie pierwszych 5 linii pliku `plik.txt` do bieżącego bufora

```vim
:r !head -n5 plik.txt
```

## Praca w linii komend

- `[Enter]` zatwierdza komendę
- `[ESC]` wychodzi z linii komend
- `<Ctrl-f>` pokazuje historię komend
- `%` znak procenta oznacza otwarty plik `:!cp % %.txt`
- `!` po znaku `!` komenda będzie uruchomiona w powłoce systemowej

## Połączenie kilku linii jednocześnie

```
"Pon",
"Wto",
"Śro",
```

Następnie wydajemy komendę:

```
vipgJ
```

Komenda `vip` zaznacza paragraf
Komenda `gJ` łączy zaznaczone wiersze w jedną linię

Wynik

```
"Pon","Wto","Śro",
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

## Porównanie dwóch plików

Jeśli chcemy porównać dwa pliki najlepiej otworzyć je w podziale pionowym a następnie uruchomić
polecenie wyświetlające różnice:

```vim
:windo diffthis
```

Po zakończeniu przeglądania różnic możemy zamknąć ten tryb używając komendy:

```vim
:diffoff!
```

Jeśli chcemy porównać kilka buforów, ale one nie są w podzielonym oknie, to w każdym pliku,
których chcemy porównywać wykonujemy komendę:

```vim
:diffthis
```
## Powrót to wcześniej edytowanego miejsca

```
g;
2g;
```

W drugą stronę

```
g,
2g,
```

Inny sposób to `Ctrl-^` jednak ten skrót przemieszcza nas pomiędzy dwoma ostatnio edytowanymi plikami

Komenda `gi` przechodzi do miejsca ostatniej edycji jednocześnie wchodząc w tryb wprowadzania

## Szyfrowanie za pomocą GPG

Zaszyfrowanie linii 117

```vim
:117 ! gpg -a -c -
```

Otrzymujemy:

```
-----BEGIN PGP MESSAGE-----

jA0ECQMIUNh5NuoQAOnw0k0BODyqJH0rX5m/qsw10cClXqCqS+6YPgNs9VAHMfSu
oM9Qn1SqnsO8S3hdhHow6t16NAvXoe578kG2Q/uZdxIRzAJ/mqMv2tJXjI1eTg==
=WXl4
-----END PGP MESSAGE-----
```

Odszyfrowanie wymaga podania linii pomiędzy którymi znajduje się zaszyfrowany tekst

```vim
:121,127 ! gpg -d -
```

Zaszyfrowanie całego pliku

```vim
:!gpg -a -c %
```

Inna wersja zaszyfrowania całego pliku

```vim
:r!gpg -a -c -o- %
```

Odszyfrowanie całego pliku

```vim
:r!gpg -a -c -o- plik_odszyfrowany.txt
```

## Konwertowanie znaków końca linii z ^M (DOS) do normalnego formatu (Unix)

```vim
:e ++ff=unix
:set ff=unix
```

w drugą stronę

```vim
:e ++ff=dos
:set ff=dos
```

## Wyrażenia regularne

- https://learnbyexample.gitbooks.io/vim-reference/content/Regular_Expressions.html

### Flag

Flagi mogą być łączone

- `g` zamienia wszystkie wystąpienia w pojedynczej linii
- `c` pyta o potwierdzenie przez zastąpieniem
- `i` ignoruje wielkość liter
- `I` nie ignoruje wielkości liter dla szukanego wzorca

Pomoc, `:h :s_flags`

Skróty klawiszowe przy fladze `c`

Pojawia się okno z wyborem:

```
replace with  (y/n/a/q/l/^E/^Y)?
```

- `y` zezwala na zamianę znalezionego wzorca
- `n` nie zezwala na zamianę i przechodzi dalej
- `l` zezwala na zamianę znalezionego wzorca i kończy pracę
- `<Esc>`, `q` kończy zamianę
- `a` zezwala na zamianę znalezionego wzorca i każdego kolejnego jego wystąpienia

### Dopasowanie wzorca

- `/^Start` wyszukuje `Start` na początku linii
- `/Stop$` wyszukuje `Stop` na końcu linii
- `.` znak `.` oznacza dowolny znak `/S..p`
- `*` znak `*` oznacza dowolną ilość znaków
- `s/\v\d{1,3}\.\v\d{1,3}\.\v\d{1,3}\.\v\d{1,3}//` adres IP
- `s/\v(\d{1,3}\.){3}\d{1,3}` adres IP wersja krótsza, gdzie `{3}` to powtórzenie pierwszego wzorca

## Wyszukanie linii nie zawierających wybranego znaku

Wyszukaj wszystkie linie, które nie zawierają litery `a`

```vim
/\v^.+(^.*a.*$)@<!$
```

Wyszukaj linie, które nie mają znaku `a` na początku

```vim
/\v^.+(^a.*$)@<!$
```
## Znajdź i zamień

- `:%s/znajdź/zamień/g` - zamienia `znajdź` na `zamień` w całym pliku
- `:s/wyraz.*inny-wyraz//` - usuwa treść od słowa `wyraz` do `inny-wyraz`
- `:s/pliku$//` - usuwa ostatnie słowo `pliku` w linii 
- `:s/^Start/Początek/` - zamienia słowo `Start` na `Początek` jeśli jest to pierwsze słowo w linii
- `:%s/<begin>\_.\{-}<end>/treść/g` - zamienia blok od `<begin>` do `<end>` na `treść`
- `:%s/\[\(\d\+\)\]/\1/g` - zamienia `[123]` na `123`
- `:%s/START.\{-}END//` - usunięcie tekstu pomiędzy słowami `START` i `END` w tej samej linii
- `:%s/^/Prefix: /` - dodanie słowa `Prefix` na początku każdej linii
- `:%s/$/ :Suffix/` - dodanie słowa `Suffix` na końcu każdej linii
- `:%s/^/\=line('.') . ' '` - dodaje numerowanie linii w całym pliku

Używając skrótu `<ctrl-r><ctrl-w>` w linii poleceń zostanie wstawiony wyraz znajdujący się pod
kursorem. Tego samego rozwiązania można użyć przy skrótach klawiszowych.

Skrót `<ctrl-r><ctrl-l>` w linii poleceń wstawia całą linię.

Skrót `<ctrl-r><ctrl-g>` w linii poleceń wstawia pełną ścieżkę i nazwę pliku.

## Komenda global

- `:g/^$/d` Usuń wszystkie puste linie w pliku
- `:g/^\s*$/d` Usuń wszystkie puste linie oraz linie wypełnione znakiem spacji w pliku
- `:g/^$/,/./-j` Usuwa puste linie występujące po sobie zostawiając tylko jedną
- `:g/pattern/d` Usuwa znalezione linie
- `:g/pattern/ . w>>filename` Kopiuje znalezione linie do osobnego pliku (plik musi istnieć)
- `:g/^/m0` Odwraca kolejność linii w pliku
- `:g/^\s*PATTERN /exe "norm! I/* \<ESC>A */\<ESC>"` Wstawia komentarz ( `/* text */` ) w
  znalezionych liniach zaczynających się od `PATTERN`
- `:g/PATTERN/exe "norm! I/* \<ESC>A */\<ESC>"` Wstawia komentarz ( `/* text */` ) w
  znalezionych liniach zawierających `PATTERN`
- `:g/Sales/d` Usuwa wszystkie linie zawierające słowo Sales
- `:g!/Sales/d` Usuwa wszystkie linie oprócz linii zawierających słowo Sales
- `:v/Sales/d` Skrót dla `:g!/Sales/d`
- `:g/Cos[A-Z]\+[0-9]/norm dd` Usuwa linie które zawierają się w wyszukiwaniu `Cos[A-Z]….`
- `:g/Cos[A-Z]\+[0-9]/norm $da<0P` Przenosi wyszukiwany tekst z końca linii na jej początek

Zamiana

```
| zsh.md | powłoka shell |
```

Na

```
| [zsh](zsh.md) | powłoka shell |
```

**Klawisz ESC uzyskujemy za pomocą skrótu `Ctrl-v` `ESC` w linii komend występuje on jako `^[`**

```vim
:'<,'>:g/md/norm ^wvt.yPa](^[Ea)^[Bi[
```

Występują tu dwa wyjścia z trybu **INSERT** czyli `^[`.

- `md` wyszukuje `md` w zaznaczonych liniach<
- `^` przechodzi na początek linii
- `w` przechodzi na początek słowa `zsh`
- `vt.` zaznacza tekst do kropki, bez niej
- `y` kopiuje zaznaczony tekst
- `P` wkleja zaznaczony tekst przed kursorem
- `a](` wprowadza tekst `](`
- `^[` klawisz `ESC` wychodzi z trybu **INSERT** (Ctrl-v ESC)
- `Ea)` przechodzi na koniec wyrażenia i wstawia znak `)`
- `^[` klawisz `ESC` wychodzi w trybu **INSERT** (Ctrl-v ESC)
- `Bi[` cofa się na początek wyrażenia i wstawia znak `[`

W skrócie polecenie kopiuje nazwę pliku bez jego rozszerzenia, dodaje nawiasy i wkleja nazwę na
początku nazwy pliku.

## Kopiowanie do schowka systemowego z linii komend

- `:let @+=@%` Kopiuje nazwę pliku do schowka systemowego
- `:let @+=@1` Kopiuje zawartość rejestru `1` do schowka systemowego


## Plugin nredir.nvim

Nredir przekierowuje wynik polecenia do nowego bufora

Przykład użycia komendy:

```lua
Nredir lua print(vim.inspect(vim.fn.api_info()))
```
## Opcje

```vim
:options
```

### 1 important

| Opcja         | Opis                                                    |
|---------------|---------------------------------------------------------|
| `compatible`  | behave very Vi compatible (not advisable)               |
| `cpoptions`   | list of flags to specify Vi compatibility               |
| `paste`       | paste mode, insert typed text literally                 |
| `runtimepath` | list of directories used for runtime files and plugins  |
| `packpath`    | list of directories used for plugin packages            |
| `helpfile`    | name of the main help file                              |

### 2 moving around, searching and patterns

| Opcja           | Opis                                                         |
|-----------------|--------------------------------------------------------------|
| `whichwrap`     | list of flags specifying which commands wrap to another line |
| `startofline`   | many jump commands move the cursor to the first non-blank    |
| `paragraphs`    | nroff macro names that separate paragraphs                   |
| `sections`      | nroff macro names that separate sections                     |
| `path`          | list of directory names used for file searching              |
| `cdhome`        | :cd without argument goes to the home directory              |
| `cdpath`        | list of directory names used for :cd                         |
| `autochdir`     | change to directory of file in buffer                        |
| `wrapscan`      | search commands wrap around the end of the buffer            |
| `incsearch`     | show match for partly typed search command                   |
| `magic`         | change the way backslashes are used in search patterns       |
| `regexpengine`  |  select the default regexp engine used                       |
| `ignorecase`    | ignore case when using a search pattern                      |
| `smartcase`     | override 'ignorecase' when pattern has upper case characters |
| `casemap`       | what method to use for changing case of letters              |
| `maxmempattern` | maximum amount of memory in Kbyte used for pattern matching  |
| `define`        | pattern for a macro definition line                          |
| `include`       | pattern for an include-file line                             |
| `includeexpr`   | expression used to transform an include line to a file name  |

### 3 tags

| Opcja         | Opis                                                    |
|---------------|---------------------------------------------------------|
| `tagbsearch`  | use binary searching in tags files                      |
| `taglength`   | number of significant characters in a tag name or zero  |
| `tags`        | list of file names to search for tags                   |
| `tagcase`     | how to handle case when searching in tags files:        |
| `tagrelative` | file names in a tags file are relative to the tags file |
| `tagstack`    | a :tag command will use the tagstack                    |
| `showfulltag` | when completing tags in Insert mode show more info      |
| `tagfunc`     | a function to be used to perform tag searches           |

### 4 displaying text

| Opcja            | Opis                                                            |
|------------------|-----------------------------------------------------------------|
| `scroll`         | number of lines to scroll for CTRL-U and CTRL-D                 |
| `smoothscroll`   | scroll by screen line                                           |
| `scrolloff`      | number of screen lines to show around the cursor                |
| `wrap`           | long lines wrap                                                 |
| `linebreak`      | wrap long lines at a character in 'breakat'                     |
| `breakindent`    | preserve indentation in wrapped text                            |
| `breakindentopt` | adjust breakindent behaviour                                    |
| `breakat`        | which characters might cause a line break                       |
| `showbreak`      | string to put before wrapped screen lines                       |
| `sidescroll`     | minimal number of columns to scroll horizontally                |
| `sidescrolloff`  | minimal number of columns to keep left and right of the cursor  |
| `display`        | include "lastline" to show the last line even if it doesn't fit |
| `fillchars`      | characters to use for the status line, folds and filler lines   |
| `cmdheight`      | number of lines used for the command-line                       |
| `columns`        | width of the display                                            |
| `lines`          | number of lines in the display                                  |
| `window`         | number of lines to scroll for CTRL-F and CTRL-B                 |
| `lazyredraw`     | don't redraw while executing macros                             |
| `redrawtime`     | timeout for 'hlsearch' and :match highlighting in msec          |
| `writedelay`     | delay in msec for each char written to the display              |
| `list`           | show `<Tab>` as ^I and end-of-line as $                         |
| `listchars`      | list of strings used for list mode                              |
| `number`         | show the line number for each line                              |
| `relativenumber` | show the relative line number for each line                     |
| `numberwidth`    | number of columns to use for the line number                    |
| `conceallevel`   | controls whether concealable text is hidden                     |
| `concealcursor`  | modes in which text in the cursor line can be concealed         |

### 5 syntax, highlighting and spelling

| Opcja           | Opis                                                   |
|-----------------|--------------------------------------------------------|
| `background`    | "dark" or "light"; the background color brightness     |
| `filetype`      | type of file; triggers the FileType event when set     |
| `syntax`        | name of syntax highlighting used                       |
| `synmaxcol`     | maximum column to look for syntax items                |
| `highlight`     | which highlighting to use for various occasions        |
| `hlsearch`      | highlight all matches for the last used search pattern |
| `termguicolors` | use GUI colors for the terminal                        |
| `cursorcolumn`  | highlight the screen column of the cursor              |
| `cursorline`    | highlight the screen line of the cursor                |
| `cursorlineopt` | specifies which area 'cursorline' highlights           |
| `colorcolumn`   | columns to highlight                                   |
| `spell`         | highlight spelling mistakes                            |
| `spelllang`     | list of accepted languages                             |
| `spellfile`     | file that "zg" adds good words to                      |
| `spellcapcheck` | pattern to locate the end of a sentence                |
| `spelloptions`  | flags to change how spell checking works               |
| `spellsuggest`  | methods used to suggest corrections                    |
| `mkspellmem`    | amount of memory used by :mkspell before compressing   |

### 6 multiple windows

| Opcja           | Opis                                                           |
|-----------------|----------------------------------------------------------------|
| `laststatus`    | 0, 1, 2 or 3; when to use a status line for the last window    |
| `statuscolumn`  | custom format for the status column                            |
| `statusline`    | alternate format to be used for a status line                  |
| `equalalways`   | make all windows the same size when adding/removing windows    |
| `eadirection`   | in which direction 'equalalways' works: "ver", "hor" or "both" |
| `winheight`     | minimal number of lines used for the current window            |
| `winminheight`  | minimal number of lines used for any window                    |
| `winfixbuf`     | keep window focused on a single buffer                         |
| `winfixheight`  | keep the height of the window                                  |
| `winfixwidth`   | keep the width of the window                                   |
| `winwidth`      | minimal number of columns used for the current window          |
| `winminwidth`   | minimal number of columns used for any window                  |
| `helpheight`    | initial height of the help window                              |
| `previewheight` | default height for the preview window                          |
| `previewwindow` | identifies the preview window                                  |
| `hidden`        | don't unload a buffer when no longer shown in a window         |
| `switchbuf`     | "useopen" and/or "split"; which window to use when jumping     |
| `splitbelow`    | a new window is put below the current one                      |
| `splitkeep`     | determines scroll behavior for split windows                   |
| `splitright`    | a new window is put right of the current one                   |
| `scrollbind`    | this window scrolls together with other bound windows          |
| `scrollopt`     | "ver", "hor" and/or "jump"; list of options for 'scrollbind'   |
| `cursorbind`    | this window's cursor moves together with other bound windows   |

### 7 multiple tab pages

| Opcja         | Opis                                                     |
|---------------|----------------------------------------------------------|
| `showtabline` | 0, 1 or 2; when to use a tab pages line                  |
| `tabpagemax`  | maximum number of tab pages to open for -p and "tab all" |
| `tabline`     | custom tab pages line                                    |

### 8 terminal

| Opcja         | Opis                                                    |
|---------------|---------------------------------------------------------|
| `scrolljump`  | minimal number of lines to scroll at a time             |
| `title`       | show info in the window title                           |
| `titlelen`    | percentage of 'columns' used for the window title       |
| `titlestring` | when not empty, string to be used for the window title  |
| `titleold`    | string to restore the title to when exiting Vim         |
| `icon`        | set the text of the icon for this window                |
| `iconstring`  | when not empty, text for the icon of this window        |

### 9 using the mouse

| Opcja        | Opis                                                    |
|--------------|---------------------------------------------------------|
| `mouse`      | list of flags for using the mouse                       |
| `mousemodel` | "extend", "popup" or "popup_setpos"; what the right     |
| `mousetime`  | maximum time in msec to recognize a double-click        |

### 10 messages and info

| Opcja         | Opis                                                            |
|---------------|-----------------------------------------------------------------|
| `terse`       | add 's' flag in 'shortmess' (don't show search message)         |
| `shortmess`   | list of flags to make messages shorter                          |
| `showcmd`     | show (partial) command keys in location given by 'showcmdloc'   |
| `showcmdloc`  | location where to show the (partial) command keys for 'showcmd' |
| `showmode`    | display the current mode in the status line                     |
| `ruler`       | show cursor position below each window                          |
| `rulerformat` | alternate format to be used for the ruler                       |
| `report`      | threshold for reporting number of changed lines                 |
| `verbose`     | the higher the more messages are given                          |
| `verbosefile` | file to write messages in                                       |
| `more`        | pause listings when the screen is full                          |
| `confirm`     | start a dialog when a command fails                             |
| `errorbells`  | ring the bell for error messages                                |
| `visualbell`  | use a visual bell instead of beeping                            |
| `belloff`     | do not ring the bell for these reasons                          |
| `helplang`    | list of preferred languages for finding help                    |

### 11 selecting text

| Opcja        | Opis                                                          |
|--------------|---------------------------------------------------------------|
| `selection`  | "old", "inclusive" or "exclusive"; how selecting text behaves |
| `selectmode` | "mouse", "key" and/or "cmd"; when to start Select mode        |
| `clipboard`  | "unnamed" to use the * register like unnamed register         |
| `keymodel`   |  "startsel" and/or "stopsel"; what special keys can do        |

### 12 editing text

| Opcja           | Opis                                                             |
|-----------------|------------------------------------------------------------------|
| `undolevels`    | maximum number of changes that can be undone                     |
| `undofile`      | automatically save and restore undo history                      |
| `undodir`       | list of directories for undo files                               |
| `undoreload`    | maximum number lines to save for undo on a buffer reload         |
| `modified`      | changes have been made and not written to a file                 |
| `readonly`      | buffer is not to be written                                      |
| `modifiable`    | changes to the text are possible                                 |
| `textwidth`     | line length above which to break a line                          |
| `wrapmargin`    | margin from the right in which to break a line                   |
| `backspace`     | specifies what <BS>, CTRL-W, etc. can do in Insert mode          |
| `comments`      | definition of what comment lines look like                       |
| `formatoptions` | list of flags that tell how automatic formatting works           |
| `formatlistpat` | pattern to recognize a numbered list                             |
| `formatexpr`    | expression used for "gq" to format lines                         |
| `complete`      | specifies how Insert mode completion works for CTRL-N and CTRL-P |
| `completeopt`   | whether to use a popup menu for Insert mode completion           |
| `pumheight`     | maximum height of the popup menu                                 |
| `pumwidth`      | minimum width of the popup menu                                  |
| `completefunc`  | user defined function for Insert mode completion                 |
| `omnifunc`      | function for filetype-specific Insert mode completion            |
| `dictionary`    | list of dictionary files for keyword completion                  |
| `thesaurus`     | list of thesaurus files for keyword completion                   |
| `thesaurusfunc` | function used for thesaurus completion                           |
| `infercase`     | adjust case of a keyword completion match                        |
| `digraph`       | enable entering digraphs with c1 `<BS>` c2                       |
| `tildeop`       | the "~" command behaves like an operator                         |
| `operatorfunc`  | function called for the "g@" operator                            |
| `showmatch`     | when inserting a bracket, briefly jump to its match              |
| `matchtime`     | tenth of a second to show a match for 'showmatch'                |
| `matchpairs`    | list of pairs that match for the "%" command                     |
| `joinspaces`    | use two spaces after '.' when joining a line                     |
| `nrformats`     | "alpha", "octal", "hex", "bin" and/or "unsigned"; number formats |

### 13 tabs and indenting

| Opcja            | Opis                                                         |
|------------------|--------------------------------------------------------------|
| `tabstop`        | number of spaces a `<Tab>` in the text stands for            |
| `shiftwidth`     | number of spaces used for each step of (auto)indent          |
| `vartabstop`     | list of number of spaces a tab counts for                    |
| `varsofttabstop` | list of number of spaces a soft tabsstop counts for          |
| `smarttab`       | a `<Tab>` in an indent inserts 'shiftwidth' spaces           |
| `softtabstop`    | if non-zero, number of spaces to insert for a `<Tab>`        |
| `shiftround`     | round to 'shiftwidth' for "<<" and ">>"                      |
| `expandtab`      | expand `<Tab>` to spaces in Insert mode                      |
| `autoindent`     | automatically set the indent of a new line                   |
| `smartindent`    | do clever autoindenting                                      |
| `cindent`        | enable specific indenting for C code                         |
| `cinoptions`     | options for C-indenting                                      |
| `cinkeys`        | keys that trigger C-indenting in Insert mode                 |
| `cinwords`       | list of words that cause more C-indent                       |
| `cinscopedecls`  | list of scope declaration names used by cino-g               |
| `indentexpr`     | expression used to obtain the indent of a line               |
| `indentkeys`     | keys that trigger indenting with 'indentexpr' in Insert mode |
| `copyindent`     | copy whitespace for indenting from previous line             |
| `preserveindent` | preserve kind of whitespace when changing indent             |
| `lisp`           | enable lisp mode                                             |
| `lispwords`      | words that change how lisp indenting works                   |
| `lispoptions`    | options for Lisp indenting                                   |

### 14 folding

| Opcja            | Opis                                                             |
|------------------|------------------------------------------------------------------|
| `foldenable`     | unset to display all folds open                                  |
| `foldlevel`      | folds with a level higher than this number will be closed        |
| `foldlevelstart` | value for 'foldlevel' when starting to edit a file               |
| `foldcolumn`     | width of the column used to indicate folds                       |
| `foldtext`       | expression used to display the text of a closed fold             |
| `foldclose`      | set to "all" to close a fold when the cursor leaves it           |
| `foldopen`       | specifies for which commands a fold will be opened               |
| `foldminlines`   | minimum number of screen lines for a fold to be closed           |
| `commentstring`  | template for comments; used to put the marker in                 |
| `foldmethod`     | folding type: "manual", "indent", "expr", "marker",              |
| `foldexpr`       | expression used when 'foldmethod' is "expr"                      |
| `foldignore`     | used to ignore lines when 'foldmethod' is "indent"               |
| `foldmarker`     | markers used when 'foldmethod' is "marker"                       |
| `foldnestmax`    | maximum fold depth for when 'foldmethod' is "indent" or "syntax" |

### 15 diff mode

| Opcja        | Opis                                  |
|--------------|---------------------------------------|
| `diff`       | use diff mode for the current window  |
| `diffopt`    | options for using diff mode           |
| `diffexpr`   | expression used to obtain a diff file |
| `patchexpr`  | expression used to patch a file       |

### 16 mapping

| Opcja         | Opis                                     |
|---------------|------------------------------------------|
| `maxmapdepth` | maximum depth of mapping                 |
| `timeout`     | allow timing out halfway into a mapping  |
| `ttimeout`    | allow timing out halfway into a key code |
| `timeoutlen`  | time in msec for 'timeout'               |
| `ttimeoutlen` | time in msec for 'ttimeout'              |

### 17 reading and writing files

| Opcja          | Opis                                                             |
|----------------|------------------------------------------------------------------|
| `modeline`     | enable using settings from modelines when reading a file         |
| `modelineexpr` | allow setting expression options from a modeline                 |
| `modelines`    | number of lines to check for modelines                           |
| `binary`       | binary file editing                                              |
| `endofline`    | last line in the file has an end-of-line                         |
| `endoffile`    | last line in the file followed by CTRL-Z                         |
| `fixendofline` | fixes missing end-of-line at end of text file                    |
| `bomb`         | prepend a Byte Order Mark to the file                            |
| `fileformat`   | end-of-line format: "dos", "unix" or "mac"                       |
| `fileformats`  | list of file formats to look for when editing a file             |
| `write`        | writing files is allowed                                         |
| `writebackup`  | write a backup file before overwriting a file                    |
| `backup`       | keep a backup after overwriting a file                           |
| `backupskip`   | patterns that specify for which files a backup is not made       |
| `backupcopy`   | whether to make the backup as a copy or rename the existing file |
| `backupdir`    | list of directories to put backup files in                       |
| `backupext`    | file name extension for the backup file                          |
| `autowrite`    | automatically write a file when leaving a modified buffer        |
| `autowriteall` | as 'autowrite', but works with more commands                     |
| `writeany`     | always write without asking for confirmation                     |
| `autoread`     | automatically read a file when it was modified outside of Vim    |
| `patchmode`    | keep oldest version of a file; specifies file name extension     |
| `fsync`        | forcibly sync the file to disk after writing it                  |

### 18 the swap file

| Opcja         | Opis                                                    |
|---------------|---------------------------------------------------------|
| `directory`   | list of directories for the swap file                   |
| `swapfile`    | use a swap file for this buffer                         |
| `updatecount` | number of characters typed to cause a swap file update  |
| `updatetime`  | time in msec after which the swap file will be updated  |

### 19 command line editing

| Opcja            | Opis                                                         |
|------------------|--------------------------------------------------------------|
| `history`        | how many command lines are remembered                        |
| `wildchar`       | key that triggers command-line expansion                     |
| `wildcharm`      | like 'wildchar' but can also be used in a mapping            |
| `wildmode`       | specifies how command line completion works                  |
| `suffixes`       | list of file name extensions that have a lower priority      |
| `suffixesadd`    | list of file name extensions added when searching for a file |
| `wildignore`     | list of patterns to ignore files for file name completion    |
| `fileignorecase` | ignore case when using file names                            |
| `wildignorecase` | ignore case when completing file names                       |
| `wildmenu`       | command-line completion shows a list of matches              |
| `cedit`          | key used to open the command-line window                     |
| `cmdwinheight`   | height of the command-line window                            |

### 20 executing external commands

| Opcja          | Opis                                                       |
|----------------|------------------------------------------------------------|
| `shell`        | name of the shell program used for external commands       |
| `shellquote`   | character(s) to enclose a shell command in                 |
| `shellxquote`  | like 'shellquote' but include the redirection              |
| `shellxescape` | characters to escape when 'shellxquote' is (               |
| `shellcmdflag` | argument for 'shell' to execute a command                  |
| `shellredir`   | used to redirect command output to a file                  |
| `shelltemp`    | use a temp file for shell commands instead of using a pipe |
| `equalprg`     | program used for "=" command                               |
| `formatprg`    | program used to format lines with "gq" command             |
| `keywordprg`   | program used for the "K" command                           |
| `warn`         | warn when using a shell command and a buffer has changes   |

### 21 running make and jumping to errors (quickfix)

| Opcja          | Opis                                                       |
|----------------|------------------------------------------------------------|
| `errorfile`    | name of the file that contains error messages              |
| `errorformat`  | list of formats for error messages                         |
| `makeprg`      | program used for the ":make" command                       |
| `shellpipe`    | string used to put the output of ":make" in the error file |
| `makeef`       | name of the errorfile for the 'makeprg' command            |
| `grepprg`      | program used for the ":grep" command                       |
| `grepformat`   | list of formats for output of 'grepprg'                    |
| `makeencoding` | encoding of the ":make" and ":grep" output                 |

### 22 language specific

| Opcja          | Opis                                                            |
|----------------|-----------------------------------------------------------------|
| `isfname`      | specifies the characters in a file name                         |
| `isident`      | specifies the characters in an identifier                       |
| `iskeyword`    | specifies the characters in a keyword                           |
| `isprint`      | specifies printable characters                                  |
| `quoteescape`  | specifies escape characters in a string                         |
| `rightleft`    | display the buffer right-to-left                                |
| `rightleftcmd` | when to edit the command-line right-to-left                     |
| `revins`       | insert characters backwards                                     |
| `allowrevins`  | allow CTRL-_ in Insert and Command-line mode to toggle 'revins' |
| `aleph`        | the ASCII code for the first letter of the Hebrew alphabet      |
| `hkmap`        | use Hebrew keyboard mapping                                     |
| `hkmapp`       | use phonetic Hebrew keyboard mapping                            |
| `arabic`       | prepare for editing Arabic text                                 |
| `arabicshape`  | perform shaping of Arabic characters                            |
| `termbidi`     | terminal will perform bidi handling                             |
| `keymap`       | name of a keyboard mapping                                      |
| `langmap`      | list of characters that are translated in Normal mode           |
| `langremap`    | apply 'langmap' to mapped characters                            |
| `iminsert`     | in Insert mode: 1: use :lmap; 2: use IM; 0: neither             |
| `imsearch`     | entering a search pattern: 1: use :lmap; 2: use IM; 0: neither  |

### 23 multi-byte characters

| Opcja           | Opis                                                         |
|-----------------|--------------------------------------------------------------|
| `encoding`      | character encoding used in Nvim: "utf-8"                     |
| `fileencoding`  | character encoding for the current file                      |
| `fileencodings` | automatically detected character encodings                   |
| `charconvert`   | expression used for character encoding conversion            |
| `delcombine`    | delete combining (composing) characters on their own         |
| `maxcombine`    | maximum number of combining (composing) characters displayed |
| `ambiwidth`     | width of ambiguous width characters                          |
| `emoji`         | emoji characters are full width                              |

### 24 various

| Opcja            | Opis                                                         |
|------------------|--------------------------------------------------------------|
| `virtualedit`    | when to use virtual editing: "block", "insert", "all"        |
| `eventignore`    | list of autocommand events which are to be ignored           |
| `loadplugins`    | load plugin scripts when starting up                         |
| `exrc`           | enable reading .vimrc/.exrc/.gvimrc in the current directory |
| `secure`         | safer working with script files in the current directory     |
| `gdefault`       | use the 'g' flag for ":substitute"                           |
| `maxfuncdepth`   | maximum depth of function calls                              |
| `sessionoptions` | list of words that specifies what to put in a session file   |
| `viewoptions`    | list of words that specifies what to save for :mkview        |
| `viewdir`        | directory where to store files with :mkview                  |
| `viminfo`        | list that specifies what to write in the ShaDa file          |
| `bufhidden`      | what happens with a buffer when it's no longer in a window   |
| `buftype`        | empty, "nofile", "nowrite", "quickfix", etc.: type of buffer |
| `buflisted`      | whether the buffer shows up in the buffer list               |
| `debug`          | set to "msg" to see all error messages                       |
| `signcolumn`     | whether to show the signcolumn                               |
