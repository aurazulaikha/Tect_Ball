-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 08:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ball_tect`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(2, 'admin', '$2y$10$TgMZknt65wnsML/dEgSCbO.A5IhJonm6bp72Qbm2ukU3dLa7bInS2');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_deteksi`
--

CREATE TABLE `riwayat_deteksi` (
  `id` int(11) NOT NULL,
  `jenis_bola` varchar(50) NOT NULL,
  `waktu_deteksi` datetime NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_deteksi`
--

INSERT INTO `riwayat_deteksi` (`id`, `jenis_bola`, `waktu_deteksi`, `filename`) VALUES
(1, 'no_ball', '2025-07-15 10:43:38', 'scaled_1000244381.png'),
(2, 'no_ball', '2025-07-15 10:45:38', 'CAP1763128651497821921.jpg'),
(3, 'no_ball', '2025-07-15 10:45:40', 'CAP2833921918529272225.jpg'),
(4, 'no_ball', '2025-07-15 11:05:22', 'scaled_1000244387.jpg'),
(5, 'no_ball', '2025-07-15 12:25:55', 'scaled_1000244387.jpg'),
(6, 'football', '2025-07-15 12:26:16', 'scaled_1000244392.jpg'),
(7, 'no_ball', '2025-07-15 12:27:10', 'CAP6402243927287361641.jpg'),
(8, 'no_ball', '2025-07-15 12:27:11', 'CAP3524403658519403582.jpg'),
(9, 'no_ball', '2025-07-15 12:27:13', 'CAP5980016815427192061.jpg'),
(10, 'no_ball', '2025-07-15 12:27:14', 'CAP4881223531662348314.jpg'),
(11, 'no_ball', '2025-07-15 12:27:15', 'CAP290682566756518181.jpg'),
(12, 'no_ball', '2025-07-15 12:27:17', 'CAP2156796795497608194.jpg'),
(13, 'no_ball', '2025-07-15 12:27:19', 'CAP8181917389433411841.jpg'),
(14, 'no_ball', '2025-07-15 12:27:21', 'CAP9064580742862759924.jpg'),
(15, 'no_ball', '2025-07-15 12:27:22', 'CAP6622476600886133646.jpg'),
(16, 'no_ball', '2025-07-15 12:27:23', 'CAP1903902633980173336.jpg'),
(17, 'no_ball', '2025-07-15 12:27:24', 'CAP3838498173880232395.jpg'),
(18, 'no_ball', '2025-07-15 12:27:26', 'CAP2739256870619266985.jpg'),
(19, 'no_ball', '2025-07-15 12:27:27', 'CAP1381868081527353395.jpg'),
(20, 'no_ball', '2025-07-15 12:27:28', 'CAP5188935045869469011.jpg'),
(21, 'no_ball', '2025-07-15 12:27:29', 'CAP6539770636694537962.jpg'),
(22, 'no_ball', '2025-07-15 12:27:30', 'CAP2747599309872910120.jpg'),
(23, 'no_ball', '2025-07-15 12:27:31', 'CAP2845246726457509663.jpg'),
(24, 'no_ball', '2025-07-15 12:27:33', 'CAP7098992654626739891.jpg'),
(25, 'no_ball', '2025-07-15 12:27:35', 'CAP534281444217981898.jpg'),
(26, 'no_ball', '2025-07-15 12:27:36', 'CAP792228581468235631.jpg'),
(27, 'no_ball', '2025-07-15 12:27:38', 'CAP6223518879782479682.jpg'),
(28, 'no_ball', '2025-07-15 12:27:40', 'CAP4884154063559073534.jpg'),
(29, 'no_ball', '2025-07-15 12:27:41', 'CAP2348116182576554310.jpg'),
(30, 'no_ball', '2025-07-15 12:27:42', 'CAP2531050814813739725.jpg'),
(31, 'no_ball', '2025-07-15 12:27:44', 'CAP5138141331125219204.jpg'),
(32, 'no_ball', '2025-07-15 12:27:45', 'CAP8361038679089468087.jpg'),
(33, 'no_ball', '2025-07-15 12:27:47', 'CAP8343457488576253219.jpg'),
(34, 'no_ball', '2025-07-15 12:27:49', 'CAP5869384473311603923.jpg'),
(35, 'no_ball', '2025-07-15 12:27:50', 'CAP1883829287668417280.jpg'),
(36, 'no_ball', '2025-07-15 12:27:52', 'CAP5765970996363878938.jpg'),
(37, 'no_ball', '2025-07-15 12:27:55', 'CAP2453709060642200683.jpg'),
(38, 'no_ball', '2025-07-15 12:27:57', 'CAP1595080937143526119.jpg'),
(39, 'no_ball', '2025-07-15 12:27:59', 'CAP8120148934330468905.jpg'),
(40, 'no_ball', '2025-07-15 12:28:01', 'CAP1423455351811662101.jpg'),
(41, 'no_ball', '2025-07-15 12:28:03', 'CAP8542966772223273145.jpg'),
(42, 'no_ball', '2025-07-15 12:28:04', 'CAP6274353087146658664.jpg'),
(43, 'no_ball', '2025-07-15 12:28:06', 'CAP1676556078801117861.jpg'),
(44, 'no_ball', '2025-07-15 12:28:08', 'CAP4934293771843855259.jpg'),
(45, 'basketball', '2025-07-15 12:28:11', 'CAP7528926017718379035.jpg'),
(46, 'no_ball', '2025-07-15 12:28:12', 'CAP5241092177233152576.jpg'),
(47, 'no_ball', '2025-07-15 12:28:15', 'CAP4269220155229045180.jpg'),
(48, 'no_ball', '2025-07-15 12:28:17', 'CAP7090927076987804739.jpg'),
(49, 'no_ball', '2025-07-15 12:28:19', 'CAP6623988405874858032.jpg'),
(50, 'no_ball', '2025-07-15 12:28:21', 'CAP2104859188832173741.jpg'),
(51, 'no_ball', '2025-07-15 12:28:23', 'CAP6896701728708237954.jpg'),
(52, 'no_ball', '2025-07-15 12:28:25', 'CAP4716901866897552496.jpg'),
(53, 'no_ball', '2025-07-15 12:28:27', 'CAP486377280804456411.jpg'),
(54, 'no_ball', '2025-07-15 12:28:29', 'CAP5453222209767006216.jpg'),
(55, 'no_ball', '2025-07-15 12:28:31', 'CAP4830206469199363065.jpg'),
(56, 'no_ball', '2025-07-15 12:28:32', 'CAP4919032668339934788.jpg'),
(57, 'no_ball', '2025-07-15 12:28:33', 'CAP6757663917995473943.jpg'),
(58, 'no_ball', '2025-07-15 12:28:35', 'CAP6283865536958226425.jpg'),
(59, 'no_ball', '2025-07-15 12:28:37', 'CAP3927474968554836008.jpg'),
(60, 'no_ball', '2025-07-15 12:28:39', 'CAP441921834644014980.jpg'),
(61, 'no_ball', '2025-07-15 12:28:41', 'CAP6424862885189925225.jpg'),
(62, 'no_ball', '2025-07-15 12:28:43', 'CAP3756470186835580789.jpg'),
(63, 'no_ball', '2025-07-15 12:29:34', 'CAP3097921223548074395.jpg'),
(64, 'no_ball', '2025-07-15 12:29:36', 'CAP8496150989313140014.jpg'),
(65, 'no_ball', '2025-07-15 12:29:38', 'CAP5246719026407011081.jpg'),
(66, 'no_ball', '2025-07-15 12:29:39', 'CAP949919690259145729.jpg'),
(67, 'football', '2025-07-15 12:29:41', 'CAP1122176305468851733.jpg'),
(68, 'football', '2025-07-15 12:29:42', 'CAP3721387025466401875.jpg'),
(69, 'no_ball', '2025-07-15 12:29:44', 'CAP4512648531129022765.jpg'),
(70, 'no_ball', '2025-07-15 12:29:47', 'CAP8322351797083665613.jpg'),
(71, 'no_ball', '2025-07-15 12:29:50', 'CAP1850012172327703314.jpg'),
(72, 'no_ball', '2025-07-15 12:29:51', 'CAP2737666101750994175.jpg'),
(73, 'no_ball', '2025-07-15 12:29:53', 'CAP8858727776883587954.jpg'),
(74, 'no_ball', '2025-07-15 12:29:56', 'CAP3820580750977786551.jpg'),
(75, 'no_ball', '2025-07-15 12:29:57', 'CAP383617341301377247.jpg'),
(76, 'no_ball', '2025-07-15 12:29:59', 'CAP8115308068287115338.jpg'),
(77, 'no_ball', '2025-07-15 12:30:01', 'CAP5197195239569958958.jpg'),
(78, 'no_ball', '2025-07-15 12:30:04', 'CAP8421901266874718100.jpg'),
(79, 'no_ball', '2025-07-15 12:30:05', 'CAP931617093035199105.jpg'),
(80, 'no_ball', '2025-07-15 12:30:07', 'CAP365246156324423778.jpg'),
(81, 'no_ball', '2025-07-15 12:30:10', 'CAP4996249274310160839.jpg'),
(82, 'no_ball', '2025-07-15 12:30:12', 'CAP4996776839578480898.jpg'),
(83, 'no_ball', '2025-07-15 12:30:14', 'CAP5597047505425245995.jpg'),
(84, 'no_ball', '2025-07-15 12:30:16', 'CAP3515878288809413417.jpg'),
(85, 'no_ball', '2025-07-15 12:30:18', 'CAP4427608653141024662.jpg'),
(86, 'no_ball', '2025-07-15 12:30:19', 'CAP8136232551587575153.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `riwayat_deteksi`
--
ALTER TABLE `riwayat_deteksi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `riwayat_deteksi`
--
ALTER TABLE `riwayat_deteksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
