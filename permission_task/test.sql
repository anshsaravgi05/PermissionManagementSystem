-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2025 at 06:43 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `perm_id` int(11) NOT NULL,
  `perm_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`perm_id`, `perm_name`) VALUES
(1, 'View'),
(2, 'Add'),
(3, 'Edit'),
(4, 'Delete'),
(5, 'Approve'),
(6, 'Reject'),
(7, 'Export'),
(8, 'Import'),
(9, 'Download'),
(10, 'Upload');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'HR'),
(2, 'Manager'),
(3, 'Employee'),
(4, 'Finance'),
(5, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `perm_id` int(11) NOT NULL,
  `is_allowed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `perm_id`, `is_allowed`) VALUES
(14, 1, 1, 1),
(15, 1, 2, 1),
(16, 1, 3, 1),
(17, 1, 4, 1),
(18, 1, 5, 1),
(19, 1, 6, 1),
(20, 1, 7, 1),
(21, 1, 8, 1),
(22, 1, 9, 1),
(23, 3, 1, 1),
(24, 3, 5, 1),
(25, 3, 6, 1),
(26, 3, 9, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `role_id`) VALUES
(1, 'Rohit Sharma', 'rohit.hr@example.com', 1),
(2, 'Anita Verma', 'anita.hr@example.com', 1),
(3, 'Vikas Kumar', 'vikas.hr@example.com', 1),
(4, 'Neha Singh', 'neha.hr@example.com', 1),
(5, 'Amit Das', 'amit.hr@example.com', 1),
(6, 'Suresh Mehta', 'suresh.manager@example.com', 2),
(7, 'Priya Nair', 'priya.manager@example.com', 2),
(8, 'Manoj Gupta', 'manoj.manager@example.com', 2),
(9, 'Sonal Jain', 'sonal.manager@example.com', 2),
(10, 'Rajeev Yadav', 'rajeev.manager@example.com', 2),
(11, 'Kunal Roy', 'kunal.emp@example.com', 3),
(12, 'Deepa Sharma', 'deepa.emp@example.com', 3),
(13, 'Aakash Malhotra', 'aakash.emp@example.com', 3),
(14, 'Simran Gill', 'simran.emp@example.com', 3),
(15, 'Ravi Chauhan', 'ravi.emp@example.com', 3),
(16, 'Meena Rathi', 'meena.finance@example.com', 4),
(17, 'Anil Kapoor', 'anil.finance@example.com', 4),
(18, 'Kiran Bedi', 'kiran.finance@example.com', 4),
(19, 'Mohit Jain', 'mohit.finance@example.com', 4),
(20, 'Shweta Iyer', 'shweta.finance@example.com', 4),
(21, 'Arjun Khanna', 'arjun.admin@example.com', 5),
(22, 'Reema Dutta', 'reema.admin@example.com', 5),
(23, 'Satish Joshi', 'satish.admin@example.com', 5),
(24, 'Tanya Kapoor', 'tanya.admin@example.com', 5),
(25, 'Vivek Ahuja', 'vivek.admin@example.com', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`perm_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `perm_id` (`perm_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `perm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`perm_id`) REFERENCES `permissions` (`perm_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
