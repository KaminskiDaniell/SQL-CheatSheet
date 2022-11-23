![SQL Cheatsheet](image.jpg)
# Spis treści
1. [ Podstawowe pojęcia. ](#main)
2. [ Zapytania wyszukujące dane. ](#find)
3. [ Zapytania modyfikujące dane. ](#modify)
4. [ Zapytania raportujące. ](#report)
5. [ Zapytania łączące kolumny. ](#joins)
6. [ Zapytania modyfikujące strukturę tabeli.](#alter)
7. [ Zapytania tworzące tabelę.](#create)
8. [ Operacje na użytkownikach. ](#users)
9. [ Diagramy ERD. ](#erd)

<a name="main"></a>
# 1. Podstawowe pojęcia

## Tabela
Dane w bazie danych są przechowywane w obiektach bazy danych, które są nazywane tabelami. Ta tabela jest w zasadzie zbiorem powiązanych wpisów danych i składa się z wielu kolumn i wierszy

## Encja
Można powiedzieć, że encje to rzeczowniki wyjęte z opisu bazy danych ;). Encje to rodzaje “obiektów” przechowywanych w bazie. Na przykład towar, czy producent. Odpowiednikiem encji w programowaniu obiektowym jest klasa. Zatem w przypadku bazy danych opisującej magazyn występuje pięć rodzajów encji.

## Atrybut
Każda z encji ma swoje właściwości. Na przykład opiekun handlowy ma numer telefonu, imię czy nazwisko. Każdy z tych elementów to atrybut. Podobnie jak w programowaniu obiektowym instancje mają swoje atrybuty.
Podobnie jak w języku programowania tak i tutaj atrybuty mają swoje typy. Relacyjne bazy danych obsługują różne typy. W większości przypadków typy z języków programowania mają swoje odpowiedniki w typach w bazie danych. Na przykład:

### Przykładowe typy danych:
* string
* bool
* double
* enum
* varchar
* int
* datetime

## Krotka
Krotka to zbiór atrybutów. Upraszczając można powiedzieć, że krotka w modelu relacyjnym odpowiada instancji obiektu w programowaniu obiektowym2. Krotki często prezentowane są w postaci wiersza w tabeli gdzie każda kolumna odpowiada poszczególnym atrybutom.

### Przykładem krotki zawierającej towar może być:
|  Nazwa  | Stan magazynowy |   Cena   |
|---------|------ |--|
| trampki |        10       |   99.99  |

## Relacja
W relacyjnym modelu bazy danych relacją określamy zbiór krotek. Skoro pojedyncza krotka to wiersz w tabeli, to zbiór krotek to cała tabela :). Istnieją różne konwencje nazywania relacji. W dalszej części artykułu będę używał liczby mnogiej od nazwy encji. Dla przykładu relacja przechowująca krotki towar będzie nazywała się towary.

### Zbierając kilka krotek, relacja towary może wyglądać następująco:
|  Nazwa  | Stan magazynowy |   Cena   |
|---------|------ |------|
| trampki |        10       |   99.99  |
| sweter  |        0        |  299.99  |
| lizak   |        2500     |  	0.5    |
| spinacz |        500      |   0.01   |

W modelu relacyjnym krotki w relacji nie mogą się powtarzać (elementy w zbiorze są unikalne). W praktyce relacyjne bazy danych posługujące się SQL pozwalają na duplikaty wierszy w tabelach. Sam język SQL pozwala na pobranie unikalnych elementów z danej tabeli.

## Pole
Każda tabela jest podzielona na mniejsze jednostki zwane polami.
Przykładowo w tabeli klienci możemy mieć takie pola jak: imie, nazwisko, adres, wiek

## Rekord
Rekord jest również nazywany wierszem danych, to każdy pojedynczy wpis istniejący w tabeli.

## Kolumna
Kolumna to pionowa jednostka w tabeli, która zawiera wszystkie informacje powiązane z określonym polem w tabeli.

## Wartość NULL
Wartość NULL w tabeli to wartość w polu, które wydaje się być puste, co oznacza, że pole z wartością NULL jest polem bez wartości.

## Klucz główny
Zbiór atrybutów (kolumn w tabeli) tworzy klucz główny. Klucz główny to unikalny identyfikator dla każdego wiersza w tabeli. W większości przypadków tabele zawierają dodatkową kolumnę, która zawiera identyfikator w postaci liczby:

| Id | Nazwa |
|----|------ |
| 1  |  trampki    |
| 2  |  sweter   |
| 3  |  lizak   |
| 4  |  spinacz     |

W tabeli wyżej kolumna `Id` jest kluczem głównym (ang. primary key). Tworzenie kluczy głównych przy pomocy liczby pozwala na automatyczne tworzenie nowej wartości klucza dla nowego wiersza. Wystarczy podnieść o 1 największą wartość klucza głównego. Klucze główne składające się z wielu kolumn nazywa się kluczami złożonymi.

Bazy danych optymalizują dostęp do danych przy pomocy klucza głównego. Oznacza to tyle, że pobranie wiersza z tabeli `towary` na podstawie kolumny `Id` będącej kluczem głównym może być bardziej wydajne niż pobranie tego samego wiersza na podstawie wartości kolumny `Nazwa`.

## Klucz obcy
Tabele mogą być ze sobą powiązane. Te zależności pomiędzy tabelami pokazane są przez klucze obce (ang. foreign key). Klucz obcy to dodatkowa kolumna (lub kolumny), która pokazuje zależność. Na przykład tabela producenci może wyglądać następująco:

| Id | Siedziba | Rok założenia |
|----|--------- | --------------|
| 1  |  Wrocław | 2007 |
| 2  |  Warszawa  | 1980 |
| 3  |  Kraków   | 1948 |

Dodatkowa kolumna `producent_id` znajdująca się wewnątrz tabeli `towary` pokazuje zależność pomiędzy towarami a producentami:

| Id | Nazwa | Producent id |
|----|------ | - |
| 1  |  trampki| 1 |
| 2  |  sweter | 2 |
| 3  |  lizak  | 3 |
| 4  |  spinacz| 3 |

Taka tabela pokazuje, że trampki produkowane są przez producenta z Wrocławia, swetry przez producenta z Warszawy. Producent z Krakowa produkuje lizaki i spinacze.

## Rodzaje powiązań

Tabele mogą mieć trzy rodzaje zależności.

### Jeden do jednego (1:1)
Przykładem takiej zależności może być samochód – numer rejestracyjny. Każdy numer rejestracyjny przypisany jest do jednego samochodu, podobnie każdy samochód ma tylko jeden numer rejestracyjny. W przypadku magazynu relacją tego typu może być opiekun handlowy – producent. Zależność tego typu reprezentuje dodatkowa kolumna w tabeli:

Tabela `producenci`
| Id | Siedziba | Rok założenia |
|----|------ | - |
| ...   |  ...     |  ... |
Tabela `opiekunowie`
| Id | Nazwisko | Producent Id |
|----|------ | - |
|  ...  |  ...     | ...  |

Kolumna `Producent id` w tabeli `opiekunowie` wskazuje na producenta, za którego jest odpowiedzialny dany opiekun.

### Jeden do wielu (1:n)
Przykładem takiej zależności może być producent – towar. Każdy producent produkuje wiele towarów. Innymi słowy każdy towar produkowany jest przez jednego producenta. Podobnie jak w przypadku relacji jeden do jednego zależność tego typu uzyskuje się poprzez dodanie odpowiedniej kolumny:

Tabela `producenci`
| Id | Siedziba | Rok założenia |
|----|------ | - |
|  ...  |  ...     | ...  |
Tabela `towary`
| Id | Nazwa | Producent Id |
|----|------ | - |
|  ...  |  ...     | ...  |

Zarówno zależność jeden do wielu, jak i jeden do jednego możliwa jest przy pomocy pojedynczej kolumny.

### Wiele do wielu (n:m)
Zależność wiele do wielu może występować pomiędzy hurtownikami i towarami. Oznacza ona tyle, że wielu hurtowników zaopatruje się w wiele towarów. Ten sam towar pobierany jest przez wielu hurtowników. W przypadku takiej zależności niezbędna jest dodatkowa tabela, która połączy ze sobą dwie tabele:

Tabela `towary`
| Id | Nazwa | Producent id |
|----|------ | - |
|  ...  |  ...     | ...  |
Tabela `hurtownicy`
| Id | Nazwa hurtowni |
|----|------ | 
|  ...  |  ...|
Tabela `towary_hurtownicy`
| Towary id | Hurtownik id |
|----|------ |
|  ...  |  ...     |

W tym przypadku tabela `towary_hurtownicy` ma dwa klucze obce. Jeden z nich pokazuje na tabelę `towary` drugi na `hurtownicy`. W przypadku tej tabeli kluczem głównym, który identyfikuje każdy wiersz może być para tych kolumn. Jest to tak zwany klucz złożony.

## Formularz
Formularz służy do wygodnego wprowadzania, edytowania i usuwania danych w tabeli. Wymienione operacje wykonuje się za pomocą okna w którym użytkownik obsługuje pola. Znaczenie pól opisane jest za pomocą etykiet, czyli nazw pól. Jest on wizytówką bazy.

## Raport
Raportem nazywamy konstrukcję systemu bazy danych, która służy do definiowania postaci i zawartości danych pobieranych z tabel, a następnie umieszczanych na wydruku. Jest to dokument przedstawiający w sposób przejrzysty i zorganizowany, wybrane i posortowane przez nas dane.


<a name="find"></a>
# 2. Zapytania wyszukujące dane

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
# 3. Zapytania modyfikujące dane

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
# 4. Zapytania raportujące

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
# 5. Zapytania łączące kolumny

###  **INNER JOIN**: zwraca rekordy, które mają pasującą wartość w obu tabelach
* `SELECT` id `FROM` books `INNER JOIN` rentals `ON` books.id=rentals.id_book;

### **LEFT (OUTER) JOIN**: zwraca wszystkie rekordy z lewej tabeli(tabela1), oraz dopasowane rekordy z prawej tabeli(tabela2)
* `SELECT` * `FROM` rentals `LEFT JOIN` books `ON` rentals.id_book=book.id;

### **RIGHT (OUTER) JOIN**: zwraca wszystkie rekordy z prawej tabeli(tabela2), oraz dopasowane rekordy z lewej tabeli(tabela1)
* `SELECT` title `FROM` books `RIGHT JOIN` authors `ON` books.id_author=authors.id;

### **FULL (OUTER) JOIN**: zwraca wszystkie rekordy, gdy istnieje dopasowanie w lewej lub prawej tabeli
* `SELECT` * `FROM` books ``FULL OUTER JOIN`` categories `ON` books.id_category=categories.id;


<a name="alter"></a>
# 6. Zapytania modyfikujące tabelę

### **ADD**: dodaje kolumnę
* `ALTER TABLE` authors `ADD` born_date datetime;

### **MODIFY**: modyfikuje typ danych w kolumnie
* `ALTER TABLE` authors `MODIFY` name longtext;

### **DROP**: usuwa kolumnę
* `ALTER TABLE` authors `DROP kolumna` born_date;

<a name="create"></a>
# 7. Zapytanie tworzące tabelę

### **CREATE**: tworzy tabelę
* `CREATE TABLE` authors `(`
    `id` `int(11)`, 
    `name` `varchar(15)`,
    `surname` `varchar(30)`,
    `born_date` `datetime`,
   `);`

<a name="users"></a>
# 8. Operacje na użytkownikach
Nadawanie uprawnień systemowych odbywa się poprzez polecenie SQL:

* `GRANT [nazwa_uprawnienia] TO [nazwa_użytkownika]`;
odbieranie natomiast
* `REVOKE [nazwa_uprawnienia] FROM [nazwa_użytkownika]`;

Aby utworzyć nowego użytkownika, który będzie się logował z komputera lokalnego, stosujemy polecenie:
* `CREATE USER 'uzytkownik'@'localhost' [IDENTIFIED BY 'haslo']`;
Parametr ujęty w nawias kwadratowy jest opcjonalny, czyli można utworzyć konto bez hasła.
* `CREATE USER 'user01'@'localhost' IDENTIFIED BY 'zsbelzyce'`;
Zostało utworzone konto o nazwie user01 zabezpieczone hasłem zsbelzyce.
Hasła użytkowników są przechowywane w postaci zaszyfrowanej. Można je uzyskać, stosując polecenie:
* `SELECT PASSWORD('haslo')`;
Aby dany użytkownik mógł logować się z dowolnego komputera w wybranej domenie, używamy symbolu 
%:
* `CREATE USER user01@' %.szkola_belzyce' IDENTIFIED BY 'zsbelzyce'`;
Jeśli w nazwie użytkownika lub w nazwie domeny nie występują znaki specjalne - lub %, to w poleceniu można opuścić apostrofy.
Zastosowanie symbolu % oznacza dowolny komputer:
* `CREATE USER uzytkownik@' %' IDENTIFIED BY 'hasło'`;
Nazwa hosta może być również podawana w postaci adresu IP:
* `CREATE USER 'user'@'192.168.0.1' IDENTIFIED BY 'hasło'`

<a name="erd"></a>
# 9. Diagramy ERD

Wykorzystywane są do tworzenia modelu graficznego schematu bazy danych. Pozwalają na modelowanie struktur danych oraz związków zachodzących między tymi strukturami. Nadają się szczególnie do modelowania relacyjnych baz danych, ponieważ umożliwiają prawie bezpośrednie przekształcenie diagramu w schemat relacyjny.

Diagramy ERD składają się z trzech rodzajów elementów:

* zbiorów encji (tabel)
* atrybutów encji (kolumn)
* związków zachodzących między encjami (relacji)

W tworzeniu diagramów wykorzystujemy poniższe elementy:

[obrazek1.png]

Diagramy ERD możemy tworzyć za pomocą różnych notacji. Najpopularniejsze są diagramy w zapisie według Martina i Chena.

[obrazek2.png]

Przykład:

[obrazek3.png]

