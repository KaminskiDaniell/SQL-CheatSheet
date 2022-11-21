# Spis treści 
1. [ Zapytania wyszukujące dane. ](#find)
2. [ Zapytania modyfikujące dane. ](#modify)
3. [ Zapytania raportujące. ](#report)
4. [ Zapytania łączące kolumny. ](#joins)
5. [ Zapytania modyfikujące strukturę tabeli.](#alter)
6. [ Zapytania tworzące tabelę.](#create)

<a name="find"></a>
# 1. Zapytania wyszukujące dane

### **SELECT**: używany do wybrania danych z bazy danych
* `SELECT` * `FROM` nazwa_tabeli;

### **DISTINCT**: filtruje zduplikowane wartości i zwraca wiersze z unikalnymi wartościami
* `SELECT DISTINCT` nazwa_kolumny;

### **WHERE**: używany do filtrowania rekordów/komórek
* `SELECT` kolumna1, kolumna2 `FROM` nazwa_tabeli `WHERE` warunek;
* `SELECT` * `FROM` nazwa_tabeli `WHERE` warunek1 `AND` warunek2;
* `SELECT` * `FROM` nazwa_tabeli `WHERE` warunek1 `OR` warunek2;
* `SELECT` * `FROM` nazwa_tabeli `WHERE NOT` warunek;
* `SELECT` * `FROM` nazwa_tabeli `WHERE` warunek1 `AND` (warunek2 `OR` warunek3);
* `SELECT` * `FROM` nazwa_tabeli `WHERE EXISTS` (`SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` warunek);

### **ORDER BY**: używane do posortowania wyniku w rosnącej lub malejącej kolejnościs
* `SELECT` * `FROM` nazwa_tabeli `ORDER BY` kolumna;
* `SELECT` * `FROM` nazwa_tabeli `ORDER BY` kolumna `DESC`;
* `SELECT` * `FROM` nazwa_tabeli `ORDER BY` kolumna1 `ASC`, kolumna2 `DESC`;

### **SELECT TOP**: określa liczbę rekordów zwróconych zapytaniem
* `SELECT TOP` numer nazwa_kolumny `FROM` nazwa_tabeli `WHERE` warunek;
* `SELECT TOP` procent nazwa_kolumny `FROM` nazwa_tabeli `WHERE` warunek;
* Not all database systems support `SELECT TOP`. The MySQL equivalent is the `LIMIT` clause
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `LIMIT` offset, count;

* % (znak procenta) jest znakiem, który reprezentuje 0, 1 lub więcej znaków
### **LIKE**: operator używany w klauzuli WHERE do wyszukiwania określonego wzoru w kolumnie
* _ (podkreślenie) jest specjalnym znakiem, które reprezentuje jeden znak
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `LIKE` pattern;
* `LIKE` ‘a%’ (find any values that start with “a”)
* `LIKE` ‘%a’ (find any values that end with “a”)
* `LIKE` ‘%or%’ (find any values that have “or” in any position)
* `LIKE` ‘_r%’ (find any values that have “r” in the second position)
* `LIKE` ‘a_%_%’ (find any values that start with “a” and are at least 3 characters in length)
* `LIKE` ‘[a-c]%’ (find any values starting with “a”, “b”, or “c”

* essentially the IN operator is shorthand for multiple OR waruneks
### **IN**:operator pozwalajcy na określenie wielu wartości w klauzuli WHERE
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `IN` (value1, value2, …);
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `IN` (`SELECT STATEMENT`);

### **BETWEEN**: operator wybierający wartości z podanego zakresu
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `BETWEEN` value1 `AND` value2;
* `SELECT` * `FROM` Produkty `WHERE` (nazwa_kolumny `BETWEEN` value1 `AND` value2) `AND NOT` nazwa_kolumny2 `IN` (value3, value4);
* `SELECT` * `FROM` Produkty `WHERE` nazwa_kolumny `BETWEEN` #01/07/1999# AND #03/12/1999#;

### **NULL**: wartości w polu, które nie posiadają wartości
* `SELECT` * `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `IS NULL`;
* `SELECT` * `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `IS NOT NULL`;

### **AS**: aliasy używane do tymczasowej zmiany nazwy tabeli lub kolumny 
* `SELECT` nazwa_kolumny `AS` alias_name `FROM` nazwa_tabeli;
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `AS` alias_name;
* `SELECT` nazwa_kolumny `AS` alias_name1, nazwa_kolumny2 `AS` alias_name2;
* `SELECT` nazwa_kolumny1, nazwa_kolumny2 + ‘, ‘ + nazwa_kolumny3 `AS` alias_name;

### **GROUP BY**: instrukcja często używana z funkcjami agregującymi (COUNT, MAX, MIN, SUM, AVG) do grupowania zbioru wyników według jednej lub więcej kolumn
* `SELECT` nazwa_kolumny1, COUNT(nazwa_kolumny2) `FROM` nazwa_tabeli `WHERE` warunek `GROUP BY` nazwa_kolumny1 `ORDER BY` COUNT(nazwa_kolumny2) DESC;


<a name="modify"></a>
# 2. Zapytania modyfikujące dane

### **INSERT INTO**: używany do wstawiania nowych rekordów/komórek w tabeli
* `INSERT INTO` nazwa_tabeli (kolumna1, kolumna2) `VALUES` (value1, value2);
* `INSERT INTO` nazwa_tabeli `VALUES` (value1, value2 …);

### **UPDATE**: używany do modyfikacji istniejących rekordów w tabeli
* `UPDATE` nazwa_tabeli `SET` kolumna1 = value1, kolumna2 = value2 `WHERE` warunek;
* `UPDATE` nazwa_tabeli `SET` nazwa_kolumny = value;

### **DELETE**: używany do usunięcia istniejących rekordów/komórek w tabeli
* `DELETE FROM` nazwa_tabeli `WHERE` warunek;
* `DELETE` * `FROM` nazwa_tabeli;

<a name="report"></a>
# 3. Zapytania raportujące

### **COUNT**: zwraca liczbę wystąpień (np. wierszy)
* `SELECT COUNT (DISTINCT` nazwa_kolumny`)`;

### **MIN() and MAX()**: zwraca najmniejszą/największą wartość z wybranej kolumny
* `SELECT MIN (`nazwa_kolumny`) FROM` nazwa_tabeli `WHERE` warunek;
* `SELECT MAX (`nazwa_kolumny`) FROM` nazwa_tabeli `WHERE` warunek;

### **AVG()**: zwraca średnią z liczb znajdujących się w kolumnie
* `SELECT AVG (`nazwa_kolumny`) FROM` nazwa_tabeli `WHERE` warunek;

### **SUM()**: zwraca sumę wszystkich liczb znajdujących się w kolumnie
* `SELECT SUM (`nazwa_kolumny`) FROM` nazwa_tabeli `WHERE` warunek;

<a name="joins"></a>
# 4. Zapytania łączące kolumny

###  **INNER JOIN**: zwraca rekordy, które mają pasującą wartość w obu tabelach
* `SELECT` nazwa_kolumny `FROM` tabela `INNER JOIN` table2 `ON` tabela.nazwa_kolumny=table2.nazwa_kolumny;
* `SELECT` tabela.nazwa_kolumny1, table2.nazwa_kolumny2, table3.nazwa_kolumny3 `FROM` ((tabela `INNER JOIN` table2 `ON` relationship) `INNER JOIN` table3 `ON` relationship);

### **LEFT (OUTER) JOIN**: zwraca wszystkie rekordy z lewej tabeli(tabela1), oraz dopasowane rekordy z prawej tabeli(tabela2)
* `SELECT` nazwa_kolumny `FROM` tabela `LEFT JOIN` table2 `ON` tabela.nazwa_kolumny=table2.nazwa_kolumny;

### **RIGHT (OUTER) JOIN**: zwraca wszystkie rekordy z prawej tabeli(tabela2), oraz dopasowane rekordy z lewej tabeli(tabela1)
* `SELECT` nazwa_kolumny `FROM` tabela `RIGHT JOIN` table2 `ON` tabela.nazwa_kolumny=table2.nazwa_kolumny;

### **FULL (OUTER) JOIN**: zwraca wszystkie rekordy, gdy istnieje dopasowanie w lewej lub prawej tabeli
* `SELECT` nazwa_kolumny `FROM` tabela ``FULL OUTER JOIN`` table2 `ON` tabela.nazwa_kolumny=table2.nazwa_kolumny;


<a name="alter"></a>
# 5. Zapytania modyfikujące tabelę

### **ADD**: dodaje kolumnę
* `ALTER TABLE` nazwa_tabeli `ADD` nazwa_kolumny kolumna_definition;

### **MODIFY**: modyfikuje typ danych w kolumnie
* `ALTER TABLE` nazwa_tabeli `MODIFY` nazwa_kolumny kolumna_type;

### **DROP**: usuwa kolumnę
* `ALTER TABLE` nazwa_tabeli `DROP kolumna` nazwa_kolumny;

<a name="create"></a>
# 6. Zapytanie tworzące tabelę

### **CREATE**: tworzy tabelę
* `CREATE TABLE` nazwa_tabeli `(`
    `kolumna1` `typ danych`, 
    `kolumna2` `typ danych`,
    `kolumna3` `typ danych`,
    `kolumna4` `typ danych`,
   `);`