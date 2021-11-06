-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2021 at 09:06 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `backend_challenge`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogposts`
--

CREATE TABLE `blogposts` (
  `id` int(11) NOT NULL,
  `authorID` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp(),
  `content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blogposts`
--

INSERT INTO `blogposts` (`id`, `authorID`, `title`, `createdAt`, `updatedAt`, `content`) VALUES
(1, 1, 'Test First Insert', '2021-11-04 00:12:53', '2021-11-04 00:13:02', 'Insert la der'),
(4, 2, 'Test First Update', '2021-11-04 00:21:05', '2021-11-04 00:21:09', 'Update la der'),
(5, 3, 'Test Second Update', '2021-11-04 00:21:20', '2021-11-04 00:21:20', 'Second Update la der'),
(7, 2, 'Second Insert Test', '2021-11-05 10:04:11', '2021-11-05 10:04:11', 'This is Second Insert'),
(8, 3, 'Third Insert Test', '2021-11-05 10:04:39', '2021-11-05 10:04:39', 'This is Third Insert'),
(10, 1, 'Second Update242452', '2021-11-06 01:59:53', '2021-11-06 01:59:53', 'This is Update for Sece123123ond Test'),
(11, 3, 'Second Update242452', '2021-11-06 02:10:31', '2021-11-06 02:10:31', 'This is Update for Sece123123ond Test');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(250) DEFAULT NULL,
  `userpassword` varchar(500) DEFAULT NULL,
  `useremail` varchar(250) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `userpassword`, `useremail`, `token`) VALUES
(1, 'mee123', '123456789', 'mee123@gmail.com', NULL),
(2, 'mee234', '234567890', 'mee234@gmail.com', NULL),
(3, 'mee345', '345678901', 'mee345@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_assignment`
--

CREATE TABLE `user_assignment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_assignment`
--

INSERT INTO `user_assignment` (`id`, `user_id`, `user_type_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE `user_types` (
  `user_type_id` int(11) NOT NULL,
  `user_type_code` varchar(250) DEFAULT NULL,
  `user_type_fullname` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`user_type_id`, `user_type_code`, `user_type_fullname`) VALUES
(1, 'admin', 'user admin'),
(2, 'general', 'user general');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogposts`
--
ALTER TABLE `blogposts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `authorID` (`authorID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_assignment`
--
ALTER TABLE `user_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_type_id` (`user_type_id`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`user_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogposts`
--
ALTER TABLE `blogposts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_assignment`
--
ALTER TABLE `user_assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
  MODIFY `user_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blogposts`
--
ALTER TABLE `blogposts`
  ADD CONSTRAINT `blogposts_ibfk_1` FOREIGN KEY (`authorID`) REFERENCES `user_assignment` (`id`);

--
-- Constraints for table `user_assignment`
--
ALTER TABLE `user_assignment`
  ADD CONSTRAINT `user_assignment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_assignment_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `user_types` (`user_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
