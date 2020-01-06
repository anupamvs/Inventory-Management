-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 07, 2020 at 04:14 AM
-- Server version: 5.7.28-0ubuntu0.16.04.2
-- PHP Version: 7.0.33-0ubuntu0.16.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `docs_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`, `description`) VALUES
(1, 'Pune', 'It hub in maharastra'),
(2, 'Mumbai', ''),
(3, 'Satara', ''),
(4, 'Lonavala', ''),
(5, 'Varanasi', ''),
(7, 'Nashik', ''),
(8, 'Thane', ''),
(9, 'Panchgani', ''),
(10, 'Bhopal', ''),
(11, 'Solapur', ''),
(12, 'Konkan', ''),
(13, 'Amravati', ''),
(14, 'Telangana', '');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`) VALUES
(5, 'Mobile', 'All Brand Mobile phone'),
(6, 'Table', ''),
(7, 'Python', ''),
(8, 'Pubg', ''),
(9, 'Lenovo', ''),
(10, 'Laptop', ''),
(11, 'Desktop', ''),
(12, 'Headphone', ''),
(13, 'Samsung', ''),
(14, 'Apple', ''),
(15, 'LG', ''),
(16, 'IFB', ''),
(17, 'Wildcraft', ''),
(18, 'Lays', ''),
(20, 'Bose Headphone', ''),
(31, 'Avtar', ''),
(32, 'Torch', ''),
(33, 'Fan', ''),
(34, 'Backpack', ''),
(35, 'Dryer', ''),
(36, 'Wallet', ''),
(37, 'Spoon', ''),
(38, 'Knife', ''),
(39, 'Type C cable', ''),
(40, 'Hard disk', ''),
(41, 'SSD', ''),
(42, 'RAM', '');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(12) NOT NULL,
  `product_id` int(12) NOT NULL,
  `location_id` int(12) NOT NULL,
  `quantity` int(12) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_id`, `location_id`, `quantity`, `timestamp`) VALUES
(16, 5, 1, 29, '2020-01-06 21:40:59'),
(17, 6, 2, 65, '2020-01-06 21:40:59'),
(18, 8, 3, 24, '2020-01-06 21:40:59'),
(19, 17, 4, 40, '2020-01-06 21:40:59'),
(20, 5, 2, 6, '2020-01-06 21:40:59'),
(21, 5, 3, 4, '2020-01-06 21:40:59'),
(22, 5, 4, 11, '2020-01-06 21:40:59'),
(23, 5, 5, 9, '2020-01-06 21:40:59'),
(24, 6, 1, 7, '2020-01-06 21:40:59'),
(25, 6, 3, 11, '2020-01-06 21:40:59'),
(26, 6, 4, 7, '2020-01-06 21:40:59'),
(27, 6, 5, 11, '2020-01-06 21:40:59'),
(28, 8, 1, 6, '2020-01-06 21:40:59'),
(29, 8, 2, 1, '2020-01-06 21:40:59'),
(30, 8, 4, 9, '2020-01-06 21:40:59'),
(31, 8, 5, 11, '2020-01-06 21:40:59'),
(32, 17, 1, 11, '2020-01-06 21:40:59'),
(33, 17, 2, 3, '2020-01-06 21:40:59'),
(34, 17, 3, 21, '2020-01-06 21:40:59'),
(35, 17, 5, 1, '2020-01-06 21:40:59'),
(36, 5, 10, 11, '2020-01-06 21:40:59');

-- --------------------------------------------------------

--
-- Table structure for table `product_movement`
--

CREATE TABLE `product_movement` (
  `id` int(12) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `from_location_id` int(12) DEFAULT NULL,
  `to_location_id` int(12) DEFAULT NULL,
  `product_id` int(12) NOT NULL,
  `quantity` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_movement`
--

INSERT INTO `product_movement` (`id`, `timestamp`, `from_location_id`, `to_location_id`, `product_id`, `quantity`) VALUES
(42, '2020-01-06 21:40:59', NULL, 1, 5, 70),
(43, '2020-01-06 21:40:59', NULL, 2, 6, 101),
(44, '2020-01-06 21:40:59', NULL, 3, 8, 51),
(45, '2020-01-06 21:40:59', NULL, 4, 17, 76),
(46, '2020-01-06 21:40:59', 1, 2, 5, 6),
(47, '2020-01-06 21:40:59', 1, 3, 5, 4),
(48, '2020-01-06 21:40:59', 1, 4, 5, 11),
(49, '2020-01-06 21:40:59', 1, 5, 5, 9),
(50, '2020-01-06 21:40:59', 2, 1, 6, 7),
(51, '2020-01-06 21:40:59', 2, 3, 6, 11),
(52, '2020-01-06 21:40:59', 2, 4, 6, 7),
(53, '2020-01-06 21:40:59', 2, 5, 6, 11),
(54, '2020-01-06 21:40:59', 3, 1, 8, 6),
(55, '2020-01-06 21:40:59', 3, 2, 8, 1),
(56, '2020-01-06 21:40:59', 3, 4, 8, 9),
(57, '2020-01-06 21:40:59', 3, 5, 8, 11),
(58, '2020-01-06 21:40:59', 4, 1, 17, 11),
(59, '2020-01-06 21:40:59', 4, 2, 17, 3),
(60, '2020-01-06 21:40:59', 4, 3, 17, 21),
(61, '2020-01-06 21:40:59', 4, 5, 17, 1),
(62, '2020-01-06 21:40:59', 1, 10, 5, 11);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `registered_on` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `password`, `email`, `registered_on`) VALUES
(2, 'anupam', '006dfa19820f039f5806dc8aa2c5188f', 'anupamvns0099@gmail.com', '2020-01-06 13:46:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`location_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `product_movement`
--
ALTER TABLE `product_movement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_location` (`from_location_id`),
  ADD KEY `to_location` (`to_location_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `ix_users_email` (`email`),
  ADD UNIQUE KEY `ix_users_username` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product_movement`
--
ALTER TABLE `product_movement`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints for table `product_movement`
--
ALTER TABLE `product_movement`
  ADD CONSTRAINT `product_movement_ibfk_1` FOREIGN KEY (`from_location_id`) REFERENCES `location` (`id`),
  ADD CONSTRAINT `product_movement_ibfk_2` FOREIGN KEY (`to_location_id`) REFERENCES `location` (`id`),
  ADD CONSTRAINT `product_movement_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
