-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2015 at 05:07 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `task`
--

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--
CREATE TABLE IF NOT EXISTS `menus` (
	`menu_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`menu_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`menu_id`, `menu_name`) VALUES
(NULL, 'Lunch'),
(NULL, 'Dinner');

-- 
-- Create `menu_categories`
--

CREATE TABLE `menu_categories` (
  `category_id` int(11) UNSIGNED NOT NULL,
  `menu_id` int(11) UNSIGNED NOT NULL,
  `category_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `category_description` varchar(125) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `menu_categories`
--

INSERT INTO `menu_categories` (`category_id`, `menu_id`, `category_name`, `category_description`) VALUES
(1, 1, 'Appetizers', ''),
(2, 1, 'Salads', 'served with a breadstick'),
(3, 1, 'Pasta', 'served with a breadstick'),
(4, 1, 'Sandwiches', 'served with side of mixed greens or french fries'),
(5, 1, 'Flatbreads', ''),
(6, 2, 'Appetizers', ''),
(7, 2, 'Cireolo di Amiei', ''),
(8, 2, 'Salads', ''),
(9, 2, 'Pasta', ''),
(10, 2, 'Entrees', '');
--
-- Indexes for table `menu_categories`
--
ALTER TABLE `menu_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu_categories`
--
ALTER TABLE `menu_categories`
  MODIFY `category_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu_categories`
--
ALTER TABLE `menu_categories`
  ADD CONSTRAINT `menu_categories_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON UPDATE CASCADE;
CREATE TABLE `menu_category_special` (
  `special_id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `special_name` varchar(50) NOT NULL,
  `special_description` varchar(150) NOT NULL,
  `special_price` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu_category_special`
--
ALTER TABLE `menu_category_special`
  ADD PRIMARY KEY (`special_id`),
  ADD KEY `menu_id` (`menu_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu_category_special`
--
ALTER TABLE `menu_category_special`
  MODIFY `special_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu_category_special`
--
ALTER TABLE `menu_category_special`
  ADD CONSTRAINT `menu_category_special_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_category_special_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `menu_categories` (`category_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


--
-- Create `menu_items`
--

CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `item` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `item_description` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `category_id`, `item`, `item_description`, `item_price`, `status`, `created_at`) VALUES
(NULL, 1, 1, 'Cutting Board', 'For cutting', 12, 0, '2015-05-11'),
(NULL, 1, 1, 'Peppers', 'For eating', 2, 0, '2015-05-12'),
(NULL, 1, 1, 'Bread', 'For toasting', 3.99, 0, '2015-05-13'),
(NULL, 1, 1, 'Belvita bars', 'For breakfast', 6.39, 0, '2015-05-13'),
(NULL, 1, 1, 'Bananas', 'For monkeys', 0.69, 0, '2015-05-13');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

ALTER TABLE `menu_items`
  ADD KEY `menu_id` (`menu_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);
--
-- Constraints for table `menu_category_special`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_items_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `menu_categories` (`category_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


--
-- Indexes for dumped tables
--

