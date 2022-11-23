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
* `SELECT` * `FROM` books;

### **DISTINCT**: filtruje zduplikowane wartości i zwraca wiersze z unikalnymi wartościami
* `SELECT DISTINCT` rentals;

### **WHERE**: używany do filtrowania rekordów/komórek
* `SELECT` name, surname `FROM` authors `WHERE` 1;
* `SELECT` * `FROM` authors `WHERE` id > 1 `AND` id < 7;
* `SELECT` * `FROM` authors `WHERE` id < 5 `OR` name = "Jan";
* `SELECT` * `FROM` authors `WHERE NOT` name = "Jan";
* `SELECT` * `FROM` books `WHERE` id_category = 3 `AND` (id_author = 1 `OR` id_author = 2);

### **ORDER BY**: używane do posortowania wyniku w rosnącej lub malejącej kolejnościs
* `SELECT` * `FROM` readers `ORDER BY` id;
* `SELECT` * `FROM` readers `ORDER BY` name `DESC`;
* `SELECT` * `FROM` readers `ORDER BY` name `ASC`, surname `DESC`;

### **SELECT LIMIT**: określa liczbę rekordów zwróconych zapytaniem
* `SELECT` title `FROM` books `LIMIT` 0, 10;

* % (znak procenta) jest znakiem, który reprezentuje 0, 1 lub więcej znaków
### **LIKE**: operator używany w klauzuli WHERE do wyszukiwania określonego wzoru w kolumnie
* _ (podkreślenie) jest specjalnym znakiem, które reprezentuje jeden znak
* `SELECT` nazwa_kolumny `FROM` nazwa_tabeli `WHERE` nazwa_kolumny `LIKE` pattern;
* `LIKE` ‘a%’ (znajdź każdą komórkę, która zaczyna się na “a”)
* `LIKE` ‘%a’ (znajdź każdą komórkę, która kończy się na “a”)
* `LIKE` ‘%or%’ (znajdź każdą komórkę, w której znajduje się fraza “or” na dowolnej pozycji)
* `LIKE` ‘_r%’ (znajdź każdą komórkę, która ma literę “r” na drugiej pozycji)
* `LIKE` ‘a_%_%’ (znajdź każdą komórkę, która zaczyna się na “a” i posiada co najmniej 3 znaki długości)
* `LIKE` ‘[a-c]%’ (znajdź każdą komórkę, która zaczyna się na “a”, “b”, lub “c”)

### **IN**:operator pozwalajcy na określenie wielu wartości w klauzuli WHERE
* `SELECT` name `FROM` authors `WHERE` name `IN` ("Jan", "Joanna", "Leon");

### **BETWEEN**: operator wybierający wartości z podanego zakresu
* `SELECT` title `FROM` books `WHERE` id_category `BETWEEN` 1 `AND` 2;
* `SELECT` * `FROM` books `WHERE` (id_publisher `BETWEEN` 2 `AND` 3) `AND NOT` id_author `IN` (3, 6);
* `SELECT` * `FROM` rentals `WHERE` return_date `BETWEEN` #2017-12-10# AND #2018-01-13#;

### **NULL**: wartości w polu, które nie posiadają wartości
* `SELECT` * `FROM` readers `WHERE` code `IS NULL`;
* `SELECT` * `FROM` readers `WHERE` code `IS NOT NULL`;

### **AS**: aliasy używane do tymczasowej zmiany nazwy tabeli lub kolumny 
* `SELECT` name `AS` author `FROM` authors;
* `SELECT` id_author `FROM` books `AS` bookcase;
* `SELECT` id_book `AS` bookId, id_reader `AS` readerId `FROM` rentals;


### **GROUP BY**: instrukcja często używana z funkcjami agregującymi (COUNT, MAX, MIN, SUM, AVG) do grupowania zbioru wyników według jednej lub więcej kolumn
* `SELECT` title, COUNT(id_publisher) `FROM` books `WHERE` 1 `GROUP BY` id_author `ORDER BY` id_author DESC;


<a name="modify"></a>
# 2. Zapytania modyfikujące dane

### **INSERT INTO**: używany do wstawiania nowych rekordów/komórek w tabeli
* `INSERT INTO` readers (id, name, surname, code) `VALUES` (11, "Jakub", "Złotek", "JZ");
* `INSERT INTO` readers `VALUES` (12, "Daniel", "Kamiński", "DK");

### **UPDATE**: używany do modyfikacji istniejących rekordów w tabeli
* `UPDATE` publishers `SET` name = "Polska księgarnia" `WHERE` id = 1;
* `UPDATE` publishers `SET` name = "Brak wydawnictwa";

### **DELETE**: używany do usunięcia istniejących rekordów/komórek w tabeli
* `DELETE FROM` books `WHERE` id_publisher = 3;
* `DELETE` * `FROM` rentals;

<a name="report"></a>
# 3. Zapytania raportujące

### **COUNT**: zwraca liczbę wystąpień (np. wierszy)
* `SELECT COUNT (DISTINCT` id_reader`)`;

### **MIN() and MAX()**: zwraca najmniejszą/największą wartość z wybranej kolumny
* `SELECT MIN (`id_author`) FROM` books;
* `SELECT MAX (`id_publisher`) FROM` books;

### **AVG()**: zwraca średnią z liczb znajdujących się w kolumnie
* `SELECT AVG (`rental_date`) FROM` rentals `WHERE` id > 1;

### **SUM()**: zwraca sumę wszystkich liczb znajdujących się w kolumnie
* `SELECT SUM (`id`) FROM` rentals `WHERE` id > 4;

<a name="joins"></a>
# 4. Zapytania łączące kolumny

###  **INNER JOIN**: zwraca rekordy, które mają pasującą wartość w obu tabelach
* `SELECT` id `FROM` books `INNER JOIN` rentals `ON` books.id=rentals.id_book;

### **LEFT (OUTER) JOIN**: zwraca wszystkie rekordy z lewej tabeli(tabela1), oraz dopasowane rekordy z prawej tabeli(tabela2)
* `SELECT` * `FROM` rentals `LEFT JOIN` books `ON` rentals.id_book=book.id;

### **RIGHT (OUTER) JOIN**: zwraca wszystkie rekordy z prawej tabeli(tabela2), oraz dopasowane rekordy z lewej tabeli(tabela1)
* `SELECT` title `FROM` books `RIGHT JOIN` authors `ON` books.id_author=authors.id;

### **FULL (OUTER) JOIN**: zwraca wszystkie rekordy, gdy istnieje dopasowanie w lewej lub prawej tabeli
* `SELECT` * `FROM` books ``FULL OUTER JOIN`` categories `ON` books.id_category=categories.id;


<a name="alter"></a>
# 5. Zapytania modyfikujące tabelę

### **ADD**: dodaje kolumnę
* `ALTER TABLE` authors `ADD` born_date datetime;

### **MODIFY**: modyfikuje typ danych w kolumnie
* `ALTER TABLE` authors `MODIFY` name longtext;

### **DROP**: usuwa kolumnę
* `ALTER TABLE` authors `DROP kolumna` born_date;

<a name="create"></a>
# 6. Zapytanie tworzące tabelę

### **CREATE**: tworzy tabelę
* `CREATE TABLE` authors `(`
    `id` `int(11)`, 
    `name` `varchar(15)`,
    `surname` `varchar(30)`,
    `born_date` `datetime`,
   `);`