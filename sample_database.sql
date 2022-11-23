CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `name` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `surname` varchar(30) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `authors` (`id`, `name`, `surname`) VALUES
(1, 'Jan', 'Kasprowicz'),
(2, 'Jan', 'Brzechwa'),
(3, 'Julian', 'Tuwim'),
(4, 'Janusz', 'Korczak'),
(5, 'Joanna', 'Chmielewska'),
(6, 'Witold', 'Gombrowicz'),
(7, 'Aleksander', 'Fredro'),
(8, 'Henryk', 'Sienkiewicz'),
(9, 'Magdalena', 'Witkiewicz'),
(10, 'Leon', 'Kruczkowski');


CREATE TABLE `readers` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `readers` (`id`, `name`, `surname`, `code`) VALUES
(1, 'Janina', 'Michalak', ''),
(2, 'Adam', 'Milek', ''),
(3, 'Bogdan', 'Nowacki', ''),
(4, 'Krzysztof', 'Kowalski', ''),
(5, 'Jadwiga', 'Kowal', ''),
(6, 'Magdalena', 'Mucha', ''),
(7, 'Maciej', 'Wysocki', ''),
(8, 'zbigniew', 'Lasecki', ''),
(9, 'Aleksandra', 'Kucharczyk', ''),
(10, 'Olga', 'Domys', '');


CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(46) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'epika'),
(2, 'dramat'),
(3, 'liryka');


CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `id_category` int(11) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `id_author` int(11) DEFAULT NULL,
  `id_publisher` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `books` (`id`, `id_category`, `title`, `id_author`, `id_publisher`) VALUES
(7, 3, 'Dies irae', 1, 3),
(8, 3, 'Poezje', 1, 1),
(9, 3, 'Wiersze wybrane', 2, 2),
(10, 3, 'Brzechwa dzieciom', 2, 1),
(11, 3, 'Bambo', 3, 3),
(12, 3, 'Rzepka', 3, 2),
(13, 3, 'Lokomotywa', 3, 1),
(17, 1, 'Kosmos', 6, 2),
(18, 1, 'Ferdydurke', 6, 2),
(19, 1, 'Trans-atlantyk', 6, 2),
(23, 1, 'Pech', 5, 3),
(24, 1, 'Lesio', 5, 2),
(25, 2, 'Zemsta', 7, 2),
(26, 2, 'Pan Jowialski', 7, 1),
(31, 1, 'Quo vadis', 8, 4),
(32, 1, 'Potop', 8, 1),
(33, 1, 'Ogniem i mieczem', 8, 2),
(34, 1, 'Panny roztropne', 9, 2),
(35, 1, 'Zamek z piasku', 9, 3),
(36, 2, 'Niemcy', 10, 1),
(37, 2, 'Odwiedziny', 10, 2);


CREATE TABLE `publishers` (
  `id` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `publishers` (`id`, `name`) VALUES
(1, 'Amber'),
(2, 'Merlin'),
(3, 'Świat książki'),
(4, 'Dobra literatura');


CREATE TABLE `rentals` (
  `id` int(20) NOT NULL,
  `id_reader` int(11) DEFAULT NULL,
  `id_book` int(11) DEFAULT NULL,
  `rental_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `rentals` (`id`, `id_reader`, `id_book`, `rental_date`, `return_date`) VALUES
(1, 2, 22, '2018-01-01', '2018-01-12'),
(2, 3, 12, '2017-10-01', '2017-10-26'),
(3, 1, 30, '2018-01-07', '2018-01-21'),
(4, 3, 15, '2017-12-03', '2017-12-11'),
(5, 2, 25, '2017-11-06', '2017-11-23'),
(6, 5, 28, '2018-01-02', '2018-01-10'),
(7, 6, 29, '2017-12-13', '2018-01-09'),
(8, 9, 21, '2017-11-19', '2017-12-12'),
(9, 2, 10, '2018-01-05', '2018-01-19'),
(10, 3, 17, '2017-11-13', '2017-12-03');


ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `readers`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `publishers`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `rentals`
  ADD PRIMARY KEY (`id`);



ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `readers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

ALTER TABLE `publishers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `rentals`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
