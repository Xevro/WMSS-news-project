-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2017 at 03:11 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 7.0.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nerdnews`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE DATABASE `nerdnews`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_unicode_ci;
USE `nerdnews`;

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`id`, `firstname`, `lastname`, `email`, `password`) VALUES
(1, 'Pieter', 'Van Peteghem', 'pieter.vanpeteghem@odisee.be', '$2y$10$ucOI21uOWCNZm7.HfpKPbeVetdnfBCgRlCWJm/dIBblfXcBoi4jGu'),
(2, 'Joris', 'Maervoet', 'joris.maervoet@odisee.be', '$2y$10$ucOI21uOWCNZm7.HfpKPbeVetdnfBCgRlCWJm/dIBblfXcBoi4jGu'),
(3, 'Pierke', 'Pierlala', 'pierke.pierlala@stadgent.be', '$2y$10$ucOI21uOWCNZm7.HfpKPbeVetdnfBCgRlCWJm/dIBblfXcBoi4jGu');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Gadgets'),
(2, 'Media'),
(3, 'Cultuur'),
(4, 'Geschiedenis'),
(5, 'Economie');

-- --------------------------------------------------------

--
-- Table structure for table `newsmessages`
--

DROP TABLE IF EXISTS `newsmessages`;
CREATE TABLE `newsmessages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `alt` varchar(128) DEFAULT NULL,
  `pubdate` datetime NOT NULL,
  `category_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `popularity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `newsmessages`
--

INSERT INTO `newsmessages` (`id`, `title`, `message`, `alt`, `pubdate`, `category_id`, `author_id`, `popularity`) VALUES
(1, 'David Bowie en Leonard Cohen postuum genomineerd voor Brit Awards', 'De vorig jaar overleden muzikanten David Bowie en Leonard Cohen werden genomineerd voor de Brit Awards, die binnen een maand uitgereikt worden.\r\nAP\r\nDavid Bowie, die in januari vorig jaar overleed, maakt kans op twee Brit Awards. Samen met Craig David, Skepta en Michael Kiwanuka werd hij genomineerd in de categorie van beste Britse mannelijke soloartiest. Zijn laatste album "Blackstar", dat twee dagen voor zijn dood verscheen, staat op de genomineerdenlijst voor het beste Britse album.\r\n\r\nDe in november vorig jaar overleden Canadese zanger Leonard Cohen wordt op zijn beurt mogelijk bekroond tot de beste internationale mannelijke soloartiest.\r\n\r\nDe Brit Awards worden op 22 februari uitgereikt in de O2-Arena in Londen.', 'David Bowie in concert', '2019-07-16 09:12:15', 3, 1, 28),
(2, 'Bpost gaat 200 informaticajobs uitbesteden naar India', 'Bpost gaat het contract beëindigen van ongeveer 200 informatici van externe Belgische bedrijven en hun taken verhuizen naar India. Dat blijkt uit een personeelsmededeling die de redacties van De Standaard, Het Nieuwsblad en Het Belang van Limburg konden inkijken. Volgens het beursgenoteerde staatsbedrijf kan het op die manier de kosten beter beheersen, maar de vakbonden hebben daar grote vragen bij. Ook vicepremier en minister van Telecom en Post Alexander De Croo (Open VLD) zit met vragen.\r\nDe geruchten over de uitbesteding naar India deden al een tijdje de ronde, maar werden steeds ontkend door Bpost. Volgens informaticadirecteur Nico Cools van Bpost is de operatie nodig om de kosten te beheersen en de sturing naar de digitale economie aan te kunnen.\r\n\r\nUit de brief aan het personeel blijkt ook nog dat het bedrijf contracten heeft ondertekend met de Indiase informaticabedrijven Infosys en Tata Consultancy. De uitbestedingsoperatie start maandag al en zou tegen februari voltooid moeten zijn.', 'Postbus Bpost', '2019-07-18 09:22:10', 5, 2, 55),
(3, 'Sonos werkt aan eerste bluetooth luidspreker', 'Sonos werkt aan een bluetoothspeaker, zo schrijft The Verge op basis van documenten. De nieuwe bluetooth speaker zou in de herfst van dit jaar verschijnen. \r\n\r\nDe documenten beschrijven een nieuwe hoogwaardige draadloze speaker met een primaire ondersteuning voor streamen WiFi welke ook ondersteuning heeft voor bluetoothaudiostreams. Het zou de eerste speaker worden van Sonos welke werkt op basis van bluetooth.\r\nDe bestaande speakers van Sonos zijn voorzien van een Wifi verbinding. Met een bluetoothverbinding wordt het mogelijk om elke soort audio af te spelen, zonder de komst van een wifi verbinding.\r\nVolgens de documentatie zal de nieuwe speaker beschikken over een accu, hiermee is hij volledig draadloos te gebruiken.', 'Sonos luidspreker', '2019-08-12 12:32:20', 1, 3, 12),
(4, 'Laatste man op de maan Gene Cernan is overleden', 'In de Verenigde Staten is de voormalige astronaut Eugene Cernan overleden. Hij was 82. Cernan was één van de eerste astronauten en maakte twee reizen naar de maan, waarvan er één eindigde in een landing. Hij was de laatste tot nu toe die een maanwandeling maakte.\r\nGene Cernan was van Tsjechoslowaakse afkomst, maar werd in 1934 geboren in Chicago. Net zoals de meeste astronauten in de beginperiode van de ruimtevaart, was hij gevechtspiloot.\r\n\r\nIn 1963 werd hij door de ruimtevaartorganisatie NASA geselecteerd in de derde lichting astronauten. In juni 1966 maakte hij samen met Thomas Stafford zijn eerste ruimtevlucht in de Gemini-9. De driedaagse missie kende veel problemen en het was niet mogelijk om de cabine te koppelen aan een doelraket omdat het omhulsel van die raket niet helemaal losgeraakt was. Cernan maakte toen ook een ruimtewandeling.', 'Laatste man op de maan', '2019-07-23 13:32:02', 4, 1, 0),
(5, '"Sherlock" slachtoffer van hacking in Rusland', 'Consternatie bij de BBC afgelopen zondag. Uren voor de langverwachte seizoensfinale van de detectivereeks "Sherlock" zou worden uitgezonden, bleek dat de aflevering in Rusland al online te zien was. Channel One, de Russische staatszender die de uitzendrechten op de serie bezit, zegt dat het het slachtoffer geworden is van een hacking. De BBC onderzoekt wie achter het lek zit.\r\nDe laatste aflevering van "Sherlock" was sowieso al het onderwerp van een kleine hype omdat scenarioschrijver Steven Moffat in interviews min of meer te kennen had gegeven dat het wel eens de allerlaatste aflevering van de huidige reeks zou kunnen zijn.\r\n\r\n"We hebben het niet geschreven met de bedoeling dat het de laatste zou zijn, maar het zou wel eens kunnen. We zouden hier kunnen eindigen. In de vorige reeksen kon dat niet omdat die altijd eindigden op een enorme cliff-hanger", aldus Moffat.', 'Benedict Cumberbatch', '2019-07-25 13:55:35', 2, 1, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsmessages`
--
ALTER TABLE `newsmessages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `newsmessages`
--
ALTER TABLE `newsmessages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `newsmessages`
--
ALTER TABLE `newsmessages`
  ADD CONSTRAINT `newsmessages_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`),
  ADD CONSTRAINT `newsmessages_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
