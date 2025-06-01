-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: db
-- Vytvořeno: Ned 01. čen 2025, 15:06
-- Verze serveru: 10.6.22-MariaDB-ubu2004
-- Verze PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `sprava_mistnosti`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `budovy`
--

CREATE TABLE `budovy` (
  `id` int(11) NOT NULL,
  `nazev` varchar(60) NOT NULL,
  `kod` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `budovy`
--

INSERT INTO `budovy` (`id`, `nazev`, `kod`) VALUES
(1, 'Technologické centrum', 'TEC'),
(2, 'Výuková budova', 'VYB'),
(3, 'Administrativní budova', 'ADB'),
(4, 'Sportovní hala', 'SPH'),
(5, 'Zdravotnické středisko', 'ZDS');

-- --------------------------------------------------------

--
-- Struktura tabulky `mistnosti`
--

CREATE TABLE `mistnosti` (
  `id` int(11) NOT NULL,
  `kod` varchar(15) NOT NULL,
  `id_bud` int(11) NOT NULL,
  `id_typ` int(11) NOT NULL,
  `podlazi` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `mistnosti`
--

INSERT INTO `mistnosti` (`id`, `kod`, `id_bud`, `id_typ`, `podlazi`) VALUES
(1, 'TEC-2-KAN01', 1, 1, 2),
(2, 'TEC-1-SKL01', 1, 4, 1),
(3, 'VYB-1-UČE01', 2, 2, 1),
(4, 'VYB-0-LAB01', 2, 5, 0),
(5, 'VYB-3-WC01', 2, 3, 3),
(6, 'TEC-2-KAN02', 1, 1, 2),
(7, 'TEC-0-ZAS01', 1, 6, 0),
(8, 'VYB-1-UČE02', 2, 2, 1),
(9, 'VYB-1-LAB02', 2, 5, 1),
(10, 'VYB-3-UČE03', 2, 2, 3),
(11, 'ADB-0-KAN01', 3, 1, 0),
(12, 'ZDS--1-KNI01', 5, 8, -1),
(13, 'ZDS-1-UČE01', 5, 2, 1),
(14, 'SPH-3-WC01', 4, 3, 3),
(15, 'ZDS-2-KUC01', 5, 7, 2),
(16, 'ADB-2-SKL01', 3, 4, 2),
(17, 'SPH-1-WC02', 4, 3, 1),
(18, 'ZDS-2-KAN01', 5, 1, 2),
(19, 'SPH-2-KNI01', 4, 8, 2),
(20, 'SPH-2-KNI02', 4, 8, 2),
(21, 'ADB-3-KUC01', 3, 7, 3),
(22, 'ZDS--1-ZAS01', 5, 6, -1),
(23, 'ADB-3-UČE01', 3, 2, 3),
(24, 'ADB-0-UČE02', 3, 2, 0),
(25, 'ADB-2-ZAS01', 3, 6, 2),
(26, 'SPH-3-WC03', 4, 3, 3),
(27, 'SPH-2-KNI03', 4, 8, 2),
(28, 'SPH-3-SKL01', 4, 4, 3),
(29, 'ADB-0-SKL02', 3, 4, 0),
(30, 'ZDS-2-SKL01', 5, 4, 2),
(31, 'ZDS-1-UČE02', 5, 2, 1);

--
-- Triggery `mistnosti`
--
DELIMITER $$
CREATE TRIGGER `trg_generate_kod` BEFORE INSERT ON `mistnosti` FOR EACH ROW BEGIN
    DECLARE budova_kod VARCHAR(10);
    DECLARE typ_zkratka VARCHAR(10);
    DECLARE mistnost_count INT DEFAULT 0;
    DECLARE new_cislo VARCHAR(2);

    SELECT kod INTO budova_kod
    FROM budovy
    WHERE id = NEW.id_bud;

    SELECT UPPER(LEFT(nazev, 3)) INTO typ_zkratka
    FROM mistnosti_typ
    WHERE id = NEW.id_typ;

    SELECT COUNT(*) + 1 INTO mistnost_count
    FROM mistnosti
    WHERE id_bud = NEW.id_bud AND id_typ = NEW.id_typ;

    SET new_cislo = LPAD(mistnost_count, 2, '0');

    SET NEW.kod = CONCAT(budova_kod, '-', NEW.podlazi, '-', typ_zkratka, new_cislo);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `mistnosti_typ`
--

CREATE TABLE `mistnosti_typ` (
  `id` int(11) NOT NULL,
  `nazev` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `mistnosti_typ`
--

INSERT INTO `mistnosti_typ` (`id`, `nazev`) VALUES
(1, 'Kancelář'),
(8, 'Knihovna'),
(7, 'Kuchyň'),
(5, 'Laboratoř'),
(4, 'Sklad'),
(2, 'Učebna'),
(3, 'WC'),
(6, 'Zasedací místnost');

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `budovy`
--
ALTER TABLE `budovy`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazev` (`nazev`),
  ADD UNIQUE KEY `kod` (`kod`);

--
-- Indexy pro tabulku `mistnosti`
--
ALTER TABLE `mistnosti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kod` (`kod`),
  ADD KEY `id_bud` (`id_bud`),
  ADD KEY `id_typ` (`id_typ`);

--
-- Indexy pro tabulku `mistnosti_typ`
--
ALTER TABLE `mistnosti_typ`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazev` (`nazev`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `budovy`
--
ALTER TABLE `budovy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pro tabulku `mistnosti`
--
ALTER TABLE `mistnosti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pro tabulku `mistnosti_typ`
--
ALTER TABLE `mistnosti_typ`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `mistnosti`
--
ALTER TABLE `mistnosti`
  ADD CONSTRAINT `mistnosti_ibfk_1` FOREIGN KEY (`id_typ`) REFERENCES `mistnosti_typ` (`id`),
  ADD CONSTRAINT `mistnosti_ibfk_2` FOREIGN KEY (`id_bud`) REFERENCES `budovy` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
