- `:g/^$/,/./-j` Usuwa puste linie występujące po sobie zostawiając tylko jedną
- `:g/pattern/d` Usuwa linie zawierające pattern
- `:g/Sales/d` Usuwa wszystkie linie zawierające słowo Sales
- `:g!/Sales/d` Usuwa wszystkie linie oprócz linii zawierających słowo Sales
- `:g/Cos[A-Z]\+[0-9]/norm dd` Usuwa linie które zawierają się w wyszukiwaniu `Cos[A-Z]….`