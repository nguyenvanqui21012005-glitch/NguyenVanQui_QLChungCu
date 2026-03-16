-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 16, 2026 at 03:14 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apartmentms`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_user`
--

CREATE TABLE `accounts_user` (
  `id` bigint NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts_user`
--

INSERT INTO `accounts_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'pbkdf2_sha256$600000$gUUvSRLdWzs3N03P3t2cmh$Kep9QTAYJQt93X8fT1mlD08IM0br0cNM/hKuxAdR4l0=', '2026-03-16 01:11:27.777986', 1, 'admin', 'Nguyễn', 'Văn Admin', 'admin@apartmentms.com', 1, 1, '2026-03-15 13:52:19.055291', '2026-03-15 13:52:19.056294', '2026-03-15 13:52:19.238976', NULL),
(2, 'pbkdf2_sha256$600000$yAcrPHOxeIhsFHkQ8tavjw$kTfZklS3DpZ86hSY91smtvOGi1zwNN5iQ4BnczUmpsE=', NULL, 0, 'staff01', 'Trần', 'Thị Staff', 'staff01@apartmentms.com', 0, 1, '2026-03-15 13:52:19.264728', '2026-03-15 13:52:19.264728', '2026-03-15 13:52:19.462240', NULL),
(3, 'pbkdf2_sha256$600000$w9glWePeQ8HqkioD4tHD2f$lGVXJjEi97EznIZyU82WJ10Cx5wpHSRserGgv0etG/8=', NULL, 0, 'staff02', 'Lê', 'Văn Bảo', 'staff02@apartmentms.com', 0, 1, '2026-03-15 13:52:19.478866', '2026-03-15 13:52:19.478866', '2026-03-15 13:52:19.687452', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `accounts_userprofile`
--

CREATE TABLE `accounts_userprofile` (
  `id` bigint NOT NULL,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts_userprofile`
--

INSERT INTO `accounts_userprofile` (`id`, `role`, `phone`, `avatar`, `date_of_birth`, `gender`, `address`, `note`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'ADMIN', '0901234567', 'avatars/2024/01/admin.jpg', NULL, 'M', NULL, NULL, '2026-03-15 13:52:19.057801', '2026-03-16 01:11:27.785020', 1),
(2, 'STAFF', '0912345678', 'avatars/2024/01/staff01.jpg', NULL, 'F', NULL, NULL, '2026-03-15 13:52:19.266237', '2026-03-15 15:28:43.457860', 2),
(3, 'STAFF', '0923456789', 'avatars/2024/01/staff02.jpg', NULL, 'M', NULL, NULL, '2026-03-15 13:52:19.480884', '2026-03-15 13:52:19.693999', 3);

-- --------------------------------------------------------

--
-- Table structure for table `accounts_user_groups`
--

CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_user_user_permissions`
--

CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements_announcement`
--

CREATE TABLE `announcements_announcement` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `title` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_pinned` tinyint(1) NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views_count` int UNSIGNED NOT NULL,
  `created_by_id` bigint DEFAULT NULL
) ;

--
-- Dumping data for table `announcements_announcement`
--

INSERT INTO `announcements_announcement` (`id`, `created_at`, `updated_at`, `deleted_at`, `title`, `content`, `category`, `is_pinned`, `image`, `attachment`, `views_count`, `created_by_id`) VALUES
(1, '2026-03-15 13:52:20.067560', '2026-03-15 13:52:20.068564', NULL, 'Thông báo lịch bảo trì thang máy tháng này', 'Kính gửi quý cư dân,\n\nBan quản lý thông báo lịch bảo trì thang máy định kỳ sẽ được thực hiện vào Thứ 7, ngày 20 tháng này từ 8h00 đến 12h00.\n\nXin cảm ơn.', 'MAINTENANCE', 0, 'announcements/2024/01/announce_1.jpg', '', 1, 1),
(2, '2026-03-15 13:52:20.072094', '2026-03-15 13:52:20.072094', NULL, 'Sự kiện Tất niên 2025 — Đêm hội chung cư', 'Ban quản lý trân trọng kính mời toàn thể quý cư dân tham dự Đêm Tất niên.\n\nThời gian: 18h00 - 22h00\nĐịa điểm: Sân vườn tầng 1.', 'EVENT', 0, 'announcements/2024/01/announce_2.jpg', '', 0, 1),
(3, '2026-03-15 13:52:20.074608', '2026-03-15 13:52:20.074608', NULL, 'Thông báo cúp điện khẩn', 'Kính thông báo: Điện lực khu vực sẽ tiến hành bảo dưỡng. Điện sẽ bị cúp từ 14h00 đến 17h00 hôm nay.', 'EMERGENCY', 0, '', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Người dùng', 6, 'add_user'),
(22, 'Can change Người dùng', 6, 'change_user'),
(23, 'Can delete Người dùng', 6, 'delete_user'),
(24, 'Can view Người dùng', 6, 'view_user'),
(25, 'Can add Hồ sơ người dùng', 7, 'add_userprofile'),
(26, 'Can change Hồ sơ người dùng', 7, 'change_userprofile'),
(27, 'Can delete Hồ sơ người dùng', 7, 'delete_userprofile'),
(28, 'Can view Hồ sơ người dùng', 7, 'view_userprofile'),
(29, 'Can add Tòa nhà', 8, 'add_building'),
(30, 'Can change Tòa nhà', 8, 'change_building'),
(31, 'Can delete Tòa nhà', 8, 'delete_building'),
(32, 'Can view Tòa nhà', 8, 'view_building'),
(33, 'Can add Tầng', 9, 'add_floor'),
(34, 'Can change Tầng', 9, 'change_floor'),
(35, 'Can delete Tầng', 9, 'delete_floor'),
(36, 'Can view Tầng', 9, 'view_floor'),
(37, 'Can add Căn hộ', 10, 'add_apartment'),
(38, 'Can change Căn hộ', 10, 'change_apartment'),
(39, 'Can delete Căn hộ', 10, 'delete_apartment'),
(40, 'Can view Căn hộ', 10, 'view_apartment'),
(41, 'Can add Cư dân', 11, 'add_resident'),
(42, 'Can change Cư dân', 11, 'change_resident'),
(43, 'Can delete Cư dân', 11, 'delete_resident'),
(44, 'Can view Cư dân', 11, 'view_resident'),
(45, 'Can add Hợp đồng', 12, 'add_contract'),
(46, 'Can change Hợp đồng', 12, 'change_contract'),
(47, 'Can delete Hợp đồng', 12, 'delete_contract'),
(48, 'Can view Hợp đồng', 12, 'view_contract'),
(49, 'Can add Loại phí', 13, 'add_feetype'),
(50, 'Can change Loại phí', 13, 'change_feetype'),
(51, 'Can delete Loại phí', 13, 'delete_feetype'),
(52, 'Can view Loại phí', 13, 'view_feetype'),
(53, 'Can add Hóa đơn', 14, 'add_invoice'),
(54, 'Can change Hóa đơn', 14, 'change_invoice'),
(55, 'Can delete Hóa đơn', 14, 'delete_invoice'),
(56, 'Can view Hóa đơn', 14, 'view_invoice'),
(57, 'Can add Thanh toán', 15, 'add_payment'),
(58, 'Can change Thanh toán', 15, 'change_payment'),
(59, 'Can delete Thanh toán', 15, 'delete_payment'),
(60, 'Can view Thanh toán', 15, 'view_payment'),
(61, 'Can add Yêu cầu bảo trì', 16, 'add_maintenancerequest'),
(62, 'Can change Yêu cầu bảo trì', 16, 'change_maintenancerequest'),
(63, 'Can delete Yêu cầu bảo trì', 16, 'delete_maintenancerequest'),
(64, 'Can view Yêu cầu bảo trì', 16, 'view_maintenancerequest'),
(65, 'Can add Chỗ đậu xe', 17, 'add_parkingslot'),
(66, 'Can change Chỗ đậu xe', 17, 'change_parkingslot'),
(67, 'Can delete Chỗ đậu xe', 17, 'delete_parkingslot'),
(68, 'Can view Chỗ đậu xe', 17, 'view_parkingslot'),
(69, 'Can add Phương tiện', 18, 'add_vehicle'),
(70, 'Can change Phương tiện', 18, 'change_vehicle'),
(71, 'Can delete Phương tiện', 18, 'delete_vehicle'),
(72, 'Can view Phương tiện', 18, 'view_vehicle'),
(73, 'Can add Thông báo', 19, 'add_announcement'),
(74, 'Can change Thông báo', 19, 'change_announcement'),
(75, 'Can delete Thông báo', 19, 'delete_announcement'),
(76, 'Can view Thông báo', 19, 'view_announcement'),
(77, 'Can add Khách thăm', 20, 'add_visitor'),
(78, 'Can change Khách thăm', 20, 'change_visitor'),
(79, 'Can delete Khách thăm', 20, 'delete_visitor'),
(80, 'Can view Khách thăm', 20, 'view_visitor');

-- --------------------------------------------------------

--
-- Table structure for table `buildings_apartment`
--

CREATE TABLE `buildings_apartment` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `apartment_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area` decimal(8,2) NOT NULL,
  `bedroom_count` smallint UNSIGNED NOT NULL,
  `bathroom_count` smallint UNSIGNED NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rent_price` decimal(12,0) NOT NULL,
  `direction` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `balcony` tinyint(1) NOT NULL,
  `furniture_included` tinyint(1) NOT NULL,
  `floor_id` bigint NOT NULL
) ;

--
-- Dumping data for table `buildings_apartment`
--

INSERT INTO `buildings_apartment` (`id`, `created_at`, `updated_at`, `deleted_at`, `apartment_number`, `area`, `bedroom_count`, `bathroom_count`, `status`, `rent_price`, `direction`, `image`, `description`, `balcony`, `furniture_included`, `floor_id`) VALUES
(1, '2026-03-15 13:52:19.709096', '2026-03-15 13:52:19.709096', NULL, '0101', '52.00', 1, 1, 'MAINTENANCE', '7000000', 'S', 'apartments/2024/01/apt_1_1.jpg', NULL, 0, 0, 1),
(2, '2026-03-15 13:52:19.714614', '2026-03-15 13:52:19.715117', NULL, '0102', '68.50', 2, 2, 'AVAILABLE', '10000000', 'E', 'apartments/2024/01/apt_1_2.jpg', NULL, 1, 0, 1),
(3, '2026-03-15 13:52:19.717624', '2026-03-15 13:52:19.717624', NULL, '0103', '75.00', 2, 2, 'OCCUPIED', '12000000', 'W', 'apartments/2024/01/apt_1_3.jpg', NULL, 0, 1, 1),
(4, '2026-03-15 13:52:19.719633', '2026-03-15 13:52:19.719633', NULL, '0104', '90.00', 3, 2, 'OCCUPIED', '15000000', 'N', 'apartments/2024/01/apt_1_4.jpg', NULL, 1, 0, 1),
(5, '2026-03-15 13:52:19.725157', '2026-03-15 13:52:19.725157', NULL, '0201', '52.00', 1, 1, 'AVAILABLE', '7000000', 'S', 'apartments/2024/01/apt_2_1.jpg', NULL, 0, 0, 2),
(6, '2026-03-15 13:52:19.727166', '2026-03-15 13:52:19.727166', NULL, '0202', '68.50', 2, 2, 'OCCUPIED', '10000000', 'E', 'apartments/2024/01/apt_2_2.jpg', NULL, 1, 0, 2),
(7, '2026-03-15 13:52:19.730179', '2026-03-15 13:52:19.730179', NULL, '0203', '75.00', 2, 2, 'OCCUPIED', '12000000', 'W', 'apartments/2024/01/apt_2_3.jpg', NULL, 0, 1, 2),
(8, '2026-03-15 13:52:19.733230', '2026-03-15 13:52:19.733230', NULL, '0204', '90.00', 3, 2, 'AVAILABLE', '15000000', 'N', 'apartments/2024/01/apt_2_4.jpg', NULL, 1, 0, 2),
(9, '2026-03-15 13:52:19.737776', '2026-03-15 13:52:19.737776', NULL, '0301', '52.00', 1, 1, 'OCCUPIED', '7000000', 'S', 'apartments/2024/01/apt_3_1.jpg', NULL, 0, 0, 3),
(10, '2026-03-15 13:52:19.740789', '2026-03-15 13:52:19.740789', NULL, '0302', '68.50', 2, 2, 'OCCUPIED', '10000000', 'E', 'apartments/2024/01/apt_3_2.jpg', NULL, 1, 0, 3),
(11, '2026-03-15 13:52:19.743299', '2026-03-15 13:52:19.743299', NULL, '0303', '75.00', 2, 2, 'AVAILABLE', '12000000', 'W', 'apartments/2024/01/apt_3_3.jpg', NULL, 0, 1, 3),
(12, '2026-03-15 13:52:19.746311', '2026-03-15 13:52:19.746311', NULL, '0304', '90.00', 3, 2, 'OCCUPIED', '15000000', 'N', 'apartments/2024/01/apt_3_4.jpg', NULL, 1, 0, 3),
(13, '2026-03-15 13:52:19.750831', '2026-03-15 13:52:19.750831', NULL, '0401', '52.00', 1, 1, 'OCCUPIED', '7000000', 'S', 'apartments/2024/01/apt_4_1.jpg', NULL, 0, 0, 4),
(14, '2026-03-15 13:52:19.753408', '2026-03-15 13:52:19.753408', NULL, '0402', '68.50', 2, 2, 'AVAILABLE', '10000000', 'E', 'apartments/2024/01/apt_4_2.jpg', NULL, 1, 0, 4),
(15, '2026-03-15 13:52:19.755918', '2026-03-15 13:52:19.755918', NULL, '0403', '75.00', 2, 2, 'OCCUPIED', '12000000', 'W', 'apartments/2024/01/apt_4_3.jpg', NULL, 0, 1, 4),
(16, '2026-03-15 13:52:19.758428', '2026-03-15 13:52:19.758428', NULL, '0404', '90.00', 3, 2, 'OCCUPIED', '15000000', 'N', 'apartments/2024/01/apt_4_4.jpg', NULL, 1, 0, 4),
(17, '2026-03-15 13:52:19.763451', '2026-03-15 13:52:19.763451', NULL, '0501', '52.00', 1, 1, 'MAINTENANCE', '7000000', 'S', 'apartments/2024/01/apt_5_1.jpg', NULL, 0, 0, 5),
(18, '2026-03-15 13:52:19.765958', '2026-03-15 13:52:19.765958', NULL, '0502', '68.50', 2, 2, 'OCCUPIED', '10000000', 'E', 'apartments/2024/01/apt_5_2.jpg', NULL, 1, 0, 5),
(19, '2026-03-15 13:52:19.767968', '2026-03-15 13:52:19.767968', NULL, '0503', '75.00', 2, 2, 'OCCUPIED', '12000000', 'W', 'apartments/2024/01/apt_5_3.jpg', NULL, 0, 1, 5),
(20, '2026-03-15 13:52:19.770979', '2026-03-15 13:52:19.770979', NULL, '0504', '90.00', 3, 2, 'AVAILABLE', '15000000', 'N', 'apartments/2024/01/apt_5_4.jpg', NULL, 1, 0, 5),
(21, '2026-03-15 13:52:19.778500', '2026-03-15 13:52:19.778500', NULL, 'B0101', '65.00', 2, 2, 'OCCUPIED', '10000000', 'SW', 'apartments/2024/01/apt_b1_1.jpg', NULL, 1, 0, 6),
(22, '2026-03-15 13:52:19.781514', '2026-03-15 13:52:19.781514', NULL, 'B0102', '80.00', 3, 2, 'OCCUPIED', '14000000', 'NW', 'apartments/2024/01/apt_b1_2.jpg', NULL, 1, 1, 6),
(23, '2026-03-15 13:52:19.784273', '2026-03-15 13:52:19.784273', NULL, 'B0103', '55.00', 2, 1, 'AVAILABLE', '8000000', 'NE', 'apartments/2024/01/apt_b1_3.jpg', NULL, 1, 0, 6),
(24, '2026-03-15 13:52:19.787786', '2026-03-15 13:52:19.787786', NULL, 'B0201', '65.00', 2, 2, 'OCCUPIED', '10000000', 'SW', 'apartments/2024/01/apt_b2_1.jpg', NULL, 1, 0, 7),
(25, '2026-03-15 13:52:19.790798', '2026-03-15 13:52:19.790798', NULL, 'B0202', '80.00', 3, 2, 'AVAILABLE', '14000000', 'NW', 'apartments/2024/01/apt_b2_2.jpg', NULL, 1, 1, 7),
(26, '2026-03-15 13:52:19.793305', '2026-03-15 13:52:19.793305', NULL, 'B0203', '55.00', 2, 1, 'OCCUPIED', '8000000', 'NE', 'apartments/2024/01/apt_b2_3.jpg', NULL, 1, 0, 7),
(27, '2026-03-15 13:52:19.797822', '2026-03-15 13:52:19.797822', NULL, 'B0301', '65.00', 2, 2, 'AVAILABLE', '10000000', 'SW', 'apartments/2024/01/apt_b3_1.jpg', NULL, 1, 0, 8),
(28, '2026-03-15 13:52:19.802353', '2026-03-15 13:52:19.802353', NULL, 'B0302', '80.00', 3, 2, 'OCCUPIED', '14000000', 'NW', 'apartments/2024/01/apt_b3_2.jpg', NULL, 1, 1, 8),
(29, '2026-03-15 13:52:19.807408', '2026-03-15 13:52:19.807408', NULL, 'B0303', '55.00', 2, 1, 'OCCUPIED', '8000000', 'NE', 'apartments/2024/01/apt_b3_3.jpg', NULL, 1, 0, 8),
(30, '2026-03-15 13:52:19.811923', '2026-03-15 13:52:19.811923', NULL, 'B0401', '65.00', 2, 2, 'OCCUPIED', '10000000', 'SW', 'apartments/2024/01/apt_b4_1.jpg', NULL, 1, 0, 9),
(31, '2026-03-15 13:52:19.814937', '2026-03-15 13:52:19.814937', NULL, 'B0402', '80.00', 3, 2, 'OCCUPIED', '14000000', 'NW', 'apartments/2024/01/apt_b4_2.jpg', NULL, 1, 1, 9),
(32, '2026-03-15 13:52:19.817948', '2026-03-15 13:52:19.817948', NULL, 'B0403', '55.00', 2, 1, 'OCCUPIED', '8000000', 'NE', 'apartments/2024/01/apt_b4_3.jpg', NULL, 1, 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `buildings_building`
--

CREATE TABLE `buildings_building` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_floors` int UNSIGNED NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `built_year` int UNSIGNED DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_id` bigint DEFAULT NULL
) ;

--
-- Dumping data for table `buildings_building`
--

INSERT INTO `buildings_building` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `address`, `total_floors`, `description`, `image`, `built_year`, `phone`, `email`, `manager_id`) VALUES
(1, '2026-03-15 13:52:19.704067', '2026-03-15 13:52:19.704067', NULL, 'Tòa A - Sapphire Tower', '123 Nguyễn Hữu Thọ, Quận 7, TP.HCM', 20, 'Tòa nhà cao cấp 20 tầng với đầy đủ tiện ích', 'buildings/2024/01/building_1.jpg', 2018, '028-1234-5678', 'toaa@sapphiretower.com', 1),
(2, '2026-03-15 13:52:19.773984', '2026-03-15 13:52:19.773984', NULL, 'Tòa B - Emerald Heights', '456 Lê Văn Lương, Quận 7, TP.HCM', 15, 'Tòa nhà hiện đại 15 tầng, view sông tuyệt đẹp', 'buildings/2024/01/building_2.jpg', 2020, '028-9876-5432', 'toab@emeraldheights.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `buildings_floor`
--

CREATE TABLE `buildings_floor` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `floor_number` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_id` bigint NOT NULL
) ;

--
-- Dumping data for table `buildings_floor`
--

INSERT INTO `buildings_floor` (`id`, `created_at`, `updated_at`, `deleted_at`, `floor_number`, `name`, `building_id`) VALUES
(1, '2026-03-15 13:52:19.706076', '2026-03-15 13:52:19.706076', NULL, 1, 'Tầng 1', 1),
(2, '2026-03-15 13:52:19.722140', '2026-03-15 13:52:19.722140', NULL, 2, 'Tầng 2', 1),
(3, '2026-03-15 13:52:19.734763', '2026-03-15 13:52:19.734763', NULL, 3, 'Tầng 3', 1),
(4, '2026-03-15 13:52:19.748323', '2026-03-15 13:52:19.748323', NULL, 4, 'Tầng 4', 1),
(5, '2026-03-15 13:52:19.760438', '2026-03-15 13:52:19.760438', NULL, 5, 'Tầng 5', 1),
(6, '2026-03-15 13:52:19.776492', '2026-03-15 13:52:19.776492', NULL, 1, 'Tầng 1', 2),
(7, '2026-03-15 13:52:19.786281', '2026-03-15 13:52:19.786281', NULL, 2, 'Tầng 2', 2),
(8, '2026-03-15 13:52:19.795313', '2026-03-15 13:52:19.795313', NULL, 3, 'Tầng 3', 2),
(9, '2026-03-15 13:52:19.809916', '2026-03-15 13:52:19.809916', NULL, 4, 'Tầng 4', 2);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'accounts', 'user'),
(7, 'accounts', 'userprofile'),
(1, 'admin', 'logentry'),
(19, 'announcements', 'announcement'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(10, 'buildings', 'apartment'),
(8, 'buildings', 'building'),
(9, 'buildings', 'floor'),
(4, 'contenttypes', 'contenttype'),
(13, 'fees', 'feetype'),
(14, 'fees', 'invoice'),
(15, 'fees', 'payment'),
(16, 'maintenance', 'maintenancerequest'),
(12, 'residents', 'contract'),
(11, 'residents', 'resident'),
(5, 'sessions', 'session'),
(17, 'vehicles', 'parkingslot'),
(18, 'vehicles', 'vehicle'),
(20, 'visitors', 'visitor');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-15 13:51:52.803661'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-03-15 13:51:52.931744'),
(3, 'auth', '0001_initial', '2026-03-15 13:51:53.206923'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-03-15 13:51:53.259390'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-03-15 13:51:53.264435'),
(6, 'auth', '0004_alter_user_username_opts', '2026-03-15 13:51:53.270486'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-03-15 13:51:53.276020'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-03-15 13:51:53.279554'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-03-15 13:51:53.284099'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-03-15 13:51:53.290153'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-03-15 13:51:53.294795'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-03-15 13:51:53.312228'),
(13, 'auth', '0011_update_proxy_permissions', '2026-03-15 13:51:53.320308'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-03-15 13:51:53.328297'),
(15, 'accounts', '0001_initial', '2026-03-15 13:51:53.661019'),
(16, 'admin', '0001_initial', '2026-03-15 13:51:53.823293'),
(17, 'admin', '0002_logentry_remove_auto_add', '2026-03-15 13:51:53.832172'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-15 13:51:53.839744'),
(19, 'announcements', '0001_initial', '2026-03-15 13:51:53.961354'),
(20, 'buildings', '0001_initial', '2026-03-15 13:51:54.278168'),
(21, 'residents', '0001_initial', '2026-03-15 13:51:54.572110'),
(22, 'fees', '0001_initial', '2026-03-15 13:51:54.976691'),
(23, 'maintenance', '0001_initial', '2026-03-15 13:51:55.162049'),
(24, 'sessions', '0001_initial', '2026-03-15 13:51:55.196102'),
(25, 'vehicles', '0001_initial', '2026-03-15 13:51:55.434646'),
(26, 'visitors', '0001_initial', '2026-03-15 13:51:55.593506'),
(27, 'fees', '0002_alter_feetype_unit', '2026-03-15 14:40:53.950897');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('5k5is70hv3f55gja19816b2r5117lzxa', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1oRp:_Fj0qsghoa8Ookh50g1uVHiVV_VVxQGt9PwAMB751fo', '2026-03-29 16:36:13.986353'),
('c3qm1onlwy4q5qlv2v5agg8hkh6w6h2n', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1n6V:9kFEo78d_hQsTwSupseO7jRuNtC9shbDJ5Uh2cj-TsA', '2026-03-29 15:10:07.857198'),
('cvdwkgn97bb5n7nmua9uuvn0za8e4nhc', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1oRW:eBDjUFE5gVnyaCZmZcCK4LF7WqCtps_578kO8RNRRGg', '2026-03-29 16:35:54.032763'),
('hcljwwvqqace4vnhhq8tqx3sz8pmarpc', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1okV:8rccJ8l2YzgxJtHoiOGWgyrvk0N3yplDFhdveFEx6h8', '2026-03-29 16:55:31.128693'),
('hpkoedbknivf3tvzbovovogi33wm1q9l', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1wUR:OknM4KWJ5T9bO83tgHFwi20jbOssPIiwdv0FG34WyrY', '2026-03-30 01:11:27.797578'),
('oxbxqaahgjxlzex3yk6d53qgmyordqgt', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1nL9:g7SpIj0pSVada7ZrFcK84aY8zMlZrrtyMpyNC2KlNwI', '2026-03-29 15:25:15.711788'),
('phllg5jonl2jq1ma3nhmkgxvvpjcpbnu', '.eJxVjDsOwjAQRO_iGln-26GkzxmsXe8aB1Ai5VMh7k4ipYBminlv5i0ybGvL28JzHkhchRaX3w6hPHk8AD1gvE-yTOM6DygPRZ50kf1E_Lqd7t9Bg6Xt68K-VlsYwZrqdGBHzodkGTpEqwidVypWTDGiJjKdMjGkPcAmQ4ji8wUCuDgn:1w1lv0:B_vUa7kPN6QoTvrdyRSs9ovxNDRD7sdzH9y4R-ebCQg', '2026-03-29 13:54:10.688698');

-- --------------------------------------------------------

--
-- Table structure for table `fees_feetype`
--

CREATE TABLE `fees_feetype` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `unit` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(12,0) NOT NULL,
  `is_mandatory` tinyint(1) NOT NULL,
  `apply_to_all` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fees_feetype`
--

INSERT INTO `fees_feetype` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `unit`, `unit_price`, `is_mandatory`, `apply_to_all`) VALUES
(1, '2026-03-15 13:52:19.867055', '2026-03-15 13:52:19.867055', NULL, 'Phí quản lý', 'Phí quản lý chung cư tính theo m²', 'M2', '12000', 1, 1),
(2, '2026-03-15 13:52:19.868826', '2026-03-15 13:52:19.868826', NULL, 'Phí gửi xe ô tô', 'Phí giữ xe ô tô hàng tháng', 'VEHICLE', '1200000', 0, 1),
(3, '2026-03-15 13:52:19.872366', '2026-03-15 13:52:19.872366', NULL, 'Phí gửi xe máy', 'Phí giữ xe máy hàng tháng', 'VEHICLE', '150000', 0, 1),
(4, '2026-03-15 13:52:19.874371', '2026-03-15 13:52:19.874371', NULL, 'Phí vệ sinh', 'Phí dịch vụ vệ sinh hàng tháng', 'MONTH', '50000', 1, 1),
(5, '2026-03-15 13:52:19.877434', '2026-03-15 13:52:19.877434', NULL, 'Phí thang máy', 'Phí sử dụng thang máy', 'MONTH', '100000', 1, 1),
(6, '2026-03-15 13:52:19.880456', '2026-03-15 14:05:12.162227', NULL, 'Internet cáp quang', 'Gói internet 100Mbps', 'MONTH', '300000', 0, 1),
(7, '2026-03-15 14:40:55.462047', '2026-03-15 14:40:55.462047', NULL, 'Điện', 'Tính theo chỉ số điện kế (đơn giá mẫu)', 'KWH', '3500', 0, 1),
(8, '2026-03-15 14:40:55.470201', '2026-03-15 14:40:55.470201', NULL, 'Nước', 'Tính theo chỉ số nước (đơn giá mẫu)', 'M3', '18000', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fees_invoice`
--

CREATE TABLE `fees_invoice` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `month` smallint UNSIGNED NOT NULL,
  `year` smallint UNSIGNED NOT NULL,
  `amount` decimal(12,0) NOT NULL,
  `due_date` date NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `apartment_id` bigint NOT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `fee_type_id` bigint NOT NULL,
  `resident_id` bigint NOT NULL
) ;

--
-- Dumping data for table `fees_invoice`
--

INSERT INTO `fees_invoice` (`id`, `created_at`, `updated_at`, `deleted_at`, `month`, `year`, `amount`, `due_date`, `status`, `note`, `apartment_id`, `created_by_id`, `fee_type_id`, `resident_id`) VALUES
(1, '2026-03-15 13:52:19.888884', '2026-03-15 13:52:19.888884', NULL, 3, 2026, '960000', '2026-03-15', 'PENDING', NULL, 22, 1, 1, 4),
(2, '2026-03-15 13:52:19.892401', '2026-03-15 13:52:19.892401', NULL, 3, 2026, '50000', '2026-03-15', 'PAID', NULL, 22, 1, 4, 4),
(3, '2026-03-15 13:52:19.896419', '2026-03-15 13:52:19.896419', NULL, 3, 2026, '100000', '2026-03-15', 'PENDING', NULL, 22, 1, 5, 4),
(4, '2026-03-15 13:52:19.901449', '2026-03-15 13:52:19.901449', NULL, 3, 2026, '1080000', '2026-03-15', 'PENDING', NULL, 16, 1, 1, 5),
(5, '2026-03-15 13:52:19.904462', '2026-03-15 13:52:19.904462', NULL, 3, 2026, '50000', '2026-03-15', 'PENDING', NULL, 16, 1, 4, 5),
(6, '2026-03-15 13:52:19.908990', '2026-03-15 13:52:19.908990', NULL, 3, 2026, '100000', '2026-03-15', 'PENDING', NULL, 16, 1, 5, 5),
(7, '2026-03-15 13:52:19.912004', '2026-03-15 13:52:19.912004', NULL, 3, 2026, '1080000', '2026-03-15', 'PENDING', NULL, 12, 1, 1, 1),
(8, '2026-03-15 13:52:19.916020', '2026-03-15 13:52:19.916020', NULL, 3, 2026, '50000', '2026-03-15', 'PENDING', NULL, 12, 1, 4, 1),
(9, '2026-03-15 13:52:19.918028', '2026-03-15 13:52:19.918028', NULL, 3, 2026, '100000', '2026-03-15', 'PENDING', NULL, 12, 1, 5, 1),
(10, '2026-03-15 13:52:19.921041', '2026-03-15 13:52:19.921041', NULL, 3, 2026, '900000', '2026-03-15', 'PENDING', NULL, 19, 1, 1, 3),
(11, '2026-03-15 13:52:19.924057', '2026-03-15 13:52:19.924057', NULL, 3, 2026, '50000', '2026-03-15', 'PENDING', NULL, 19, 1, 4, 3),
(12, '2026-03-15 13:52:19.928240', '2026-03-15 13:52:19.928240', NULL, 3, 2026, '100000', '2026-03-15', 'PENDING', NULL, 19, 1, 5, 3),
(13, '2026-03-15 13:52:19.931264', '2026-03-15 13:52:19.931264', NULL, 3, 2026, '660000', '2026-03-15', 'PENDING', NULL, 26, 1, 1, 2),
(14, '2026-03-15 13:52:19.935295', '2026-03-15 13:52:19.935295', NULL, 3, 2026, '50000', '2026-03-15', 'PENDING', NULL, 26, 1, 4, 2),
(15, '2026-03-15 13:52:19.937849', '2026-03-15 13:52:19.937849', NULL, 3, 2026, '100000', '2026-03-15', 'PAID', NULL, 26, 1, 5, 2),
(16, '2026-03-15 16:09:01.933408', '2026-03-15 16:09:01.933408', NULL, 2, 2026, '1080000', '2026-02-15', 'PAID', NULL, 12, NULL, 1, 1),
(17, '2026-03-15 16:09:01.939037', '2026-03-15 16:09:01.939037', NULL, 2, 2026, '50000', '2026-02-15', 'PAID', NULL, 12, NULL, 4, 1),
(18, '2026-03-15 16:09:01.942563', '2026-03-15 16:09:01.942563', NULL, 2, 2026, '100000', '2026-02-15', 'PAID', NULL, 12, NULL, 5, 1),
(19, '2026-03-15 16:09:01.945079', '2026-03-15 16:09:01.945079', NULL, 2, 2026, '1080000', '2026-02-15', 'PAID', NULL, 16, NULL, 1, 5),
(20, '2026-03-15 16:09:01.948609', '2026-03-15 16:09:01.948609', NULL, 2, 2026, '50000', '2026-02-15', 'PAID', NULL, 16, NULL, 4, 5),
(21, '2026-03-15 16:09:01.954443', '2026-03-15 16:09:01.954443', NULL, 2, 2026, '100000', '2026-02-15', 'PAID', NULL, 16, NULL, 5, 5),
(22, '2026-03-15 16:09:01.957979', '2026-03-15 16:09:01.957979', NULL, 2, 2026, '900000', '2026-02-15', 'PAID', NULL, 19, NULL, 1, 3),
(23, '2026-03-15 16:09:01.960494', '2026-03-15 16:09:01.960494', NULL, 2, 2026, '50000', '2026-02-15', 'PAID', NULL, 19, NULL, 4, 3),
(24, '2026-03-15 16:09:01.963514', '2026-03-15 16:09:01.963514', NULL, 2, 2026, '100000', '2026-02-15', 'PAID', NULL, 19, NULL, 5, 3),
(25, '2026-03-15 16:09:01.965526', '2026-03-15 16:09:01.965526', NULL, 2, 2026, '960000', '2026-02-15', 'PAID', NULL, 22, NULL, 1, 4),
(26, '2026-03-15 16:09:01.968545', '2026-03-15 16:09:01.968545', NULL, 2, 2026, '50000', '2026-02-15', 'PAID', NULL, 22, NULL, 4, 4),
(27, '2026-03-15 16:09:01.971059', '2026-03-15 16:09:01.971059', NULL, 2, 2026, '100000', '2026-02-15', 'PAID', NULL, 22, NULL, 5, 4),
(28, '2026-03-15 16:09:01.973583', '2026-03-15 16:09:01.973583', NULL, 2, 2026, '660000', '2026-02-15', 'PAID', NULL, 26, NULL, 1, 2),
(29, '2026-03-15 16:09:01.976096', '2026-03-15 16:09:01.976096', NULL, 2, 2026, '50000', '2026-02-15', 'PAID', NULL, 26, NULL, 4, 2),
(30, '2026-03-15 16:09:01.978613', '2026-03-15 16:09:01.978613', NULL, 2, 2026, '100000', '2026-02-15', 'PAID', NULL, 26, NULL, 5, 2),
(31, '2026-03-15 16:09:01.980628', '2026-03-15 16:09:01.980628', NULL, 1, 2026, '1080000', '2026-01-15', 'PENDING', NULL, 12, NULL, 1, 1),
(32, '2026-03-15 16:09:01.982137', '2026-03-15 16:09:01.982137', NULL, 1, 2026, '50000', '2026-01-15', 'PAID', NULL, 12, NULL, 4, 1),
(33, '2026-03-15 16:09:01.983646', '2026-03-15 16:09:01.983646', NULL, 1, 2026, '100000', '2026-01-15', 'PAID', NULL, 12, NULL, 5, 1),
(34, '2026-03-15 16:09:01.986160', '2026-03-15 16:09:01.986160', NULL, 1, 2026, '1080000', '2026-01-15', 'PAID', NULL, 16, NULL, 1, 5),
(35, '2026-03-15 16:09:01.989191', '2026-03-15 16:09:01.989191', NULL, 1, 2026, '50000', '2026-01-15', 'PAID', NULL, 16, NULL, 4, 5),
(36, '2026-03-15 16:09:01.991205', '2026-03-15 16:09:01.991205', NULL, 1, 2026, '100000', '2026-01-15', 'PAID', NULL, 16, NULL, 5, 5),
(37, '2026-03-15 16:09:01.994226', '2026-03-15 16:09:01.994226', NULL, 1, 2026, '900000', '2026-01-15', 'PAID', NULL, 19, NULL, 1, 3),
(38, '2026-03-15 16:09:01.997289', '2026-03-15 16:09:01.997289', NULL, 1, 2026, '50000', '2026-01-15', 'PAID', NULL, 19, NULL, 4, 3),
(39, '2026-03-15 16:09:01.999805', '2026-03-15 16:09:01.999805', NULL, 1, 2026, '100000', '2026-01-15', 'PAID', NULL, 19, NULL, 5, 3),
(40, '2026-03-15 16:09:02.002826', '2026-03-15 16:09:02.002826', NULL, 1, 2026, '960000', '2026-01-15', 'PAID', NULL, 22, NULL, 1, 4),
(41, '2026-03-15 16:09:02.007381', '2026-03-15 16:09:02.007381', NULL, 1, 2026, '50000', '2026-01-15', 'PAID', NULL, 22, NULL, 4, 4),
(42, '2026-03-15 16:09:02.009400', '2026-03-15 16:09:02.009400', NULL, 1, 2026, '100000', '2026-01-15', 'PAID', NULL, 22, NULL, 5, 4),
(43, '2026-03-15 16:09:02.013424', '2026-03-15 16:09:02.013424', NULL, 1, 2026, '660000', '2026-01-15', 'PAID', NULL, 26, NULL, 1, 2),
(44, '2026-03-15 16:09:02.018376', '2026-03-15 16:09:02.018376', NULL, 1, 2026, '50000', '2026-01-15', 'PAID', NULL, 26, NULL, 4, 2),
(45, '2026-03-15 16:09:02.026059', '2026-03-15 16:09:02.027069', NULL, 1, 2026, '100000', '2026-01-15', 'PAID', NULL, 26, NULL, 5, 2),
(46, '2026-03-15 16:09:02.030599', '2026-03-15 16:09:02.030599', NULL, 12, 2025, '1080000', '2025-12-15', 'PAID', NULL, 12, NULL, 1, 1),
(47, '2026-03-15 16:09:02.033634', '2026-03-15 16:09:02.033634', NULL, 12, 2025, '50000', '2025-12-15', 'PAID', NULL, 12, NULL, 4, 1),
(48, '2026-03-15 16:09:02.036673', '2026-03-15 16:09:02.036673', NULL, 12, 2025, '100000', '2025-12-15', 'PAID', NULL, 12, NULL, 5, 1),
(49, '2026-03-15 16:09:02.039691', '2026-03-15 16:09:02.039691', NULL, 12, 2025, '1080000', '2025-12-15', 'PAID', NULL, 16, NULL, 1, 5),
(50, '2026-03-15 16:09:02.043216', '2026-03-15 16:09:02.043216', NULL, 12, 2025, '50000', '2025-12-15', 'PAID', NULL, 16, NULL, 4, 5),
(51, '2026-03-15 16:09:02.046281', '2026-03-15 16:09:02.046281', NULL, 12, 2025, '100000', '2025-12-15', 'PAID', NULL, 16, NULL, 5, 5),
(52, '2026-03-15 16:09:02.050313', '2026-03-15 16:09:02.050313', NULL, 12, 2025, '900000', '2025-12-15', 'PAID', NULL, 19, NULL, 1, 3),
(53, '2026-03-15 16:09:02.053332', '2026-03-15 16:09:02.053332', NULL, 12, 2025, '50000', '2025-12-15', 'PAID', NULL, 19, NULL, 4, 3),
(54, '2026-03-15 16:09:02.056349', '2026-03-15 16:09:02.056349', NULL, 12, 2025, '100000', '2025-12-15', 'PAID', NULL, 19, NULL, 5, 3),
(55, '2026-03-15 16:09:02.059372', '2026-03-15 16:09:02.059372', NULL, 12, 2025, '960000', '2025-12-15', 'PAID', NULL, 22, NULL, 1, 4),
(56, '2026-03-15 16:09:02.062398', '2026-03-15 16:09:02.062398', NULL, 12, 2025, '50000', '2025-12-15', 'PAID', NULL, 22, NULL, 4, 4),
(57, '2026-03-15 16:09:02.064951', '2026-03-15 16:09:02.064951', NULL, 12, 2025, '100000', '2025-12-15', 'PAID', NULL, 22, NULL, 5, 4),
(58, '2026-03-15 16:09:02.068492', '2026-03-15 16:09:02.068492', NULL, 12, 2025, '660000', '2025-12-15', 'PAID', NULL, 26, NULL, 1, 2),
(59, '2026-03-15 16:09:02.073536', '2026-03-15 16:09:02.073536', NULL, 12, 2025, '50000', '2025-12-15', 'PAID', NULL, 26, NULL, 4, 2),
(60, '2026-03-15 16:09:02.076052', '2026-03-15 16:09:02.076052', NULL, 12, 2025, '100000', '2025-12-15', 'PAID', NULL, 26, NULL, 5, 2),
(61, '2026-03-15 16:09:02.080579', '2026-03-15 16:09:02.080579', NULL, 11, 2025, '1080000', '2025-11-15', 'PAID', NULL, 12, NULL, 1, 1),
(62, '2026-03-15 16:09:02.083598', '2026-03-15 16:09:02.083598', NULL, 11, 2025, '50000', '2025-11-15', 'PAID', NULL, 12, NULL, 4, 1),
(63, '2026-03-15 16:09:02.086113', '2026-03-15 16:09:02.086113', NULL, 11, 2025, '100000', '2025-11-15', 'PAID', NULL, 12, NULL, 5, 1),
(64, '2026-03-15 16:09:02.091232', '2026-03-15 16:09:02.091232', NULL, 11, 2025, '1080000', '2025-11-15', 'PAID', NULL, 16, NULL, 1, 5),
(65, '2026-03-15 16:09:02.095267', '2026-03-15 16:09:02.095267', NULL, 11, 2025, '50000', '2025-11-15', 'PAID', NULL, 16, NULL, 4, 5),
(66, '2026-03-15 16:09:02.100321', '2026-03-15 16:09:02.100321', NULL, 11, 2025, '100000', '2025-11-15', 'PENDING', NULL, 16, NULL, 5, 5),
(67, '2026-03-15 16:09:02.101828', '2026-03-15 16:09:02.101828', NULL, 11, 2025, '900000', '2025-11-15', 'PAID', NULL, 19, NULL, 1, 3),
(68, '2026-03-15 16:09:02.105098', '2026-03-15 16:09:02.105098', NULL, 11, 2025, '50000', '2025-11-15', 'PAID', NULL, 19, NULL, 4, 3),
(69, '2026-03-15 16:09:02.108131', '2026-03-15 16:09:02.108131', NULL, 11, 2025, '100000', '2025-11-15', 'PAID', NULL, 19, NULL, 5, 3),
(70, '2026-03-15 16:09:02.112165', '2026-03-15 16:09:02.112165', NULL, 11, 2025, '960000', '2025-11-15', 'PAID', NULL, 22, NULL, 1, 4),
(71, '2026-03-15 16:09:02.115249', '2026-03-15 16:09:02.115249', NULL, 11, 2025, '50000', '2025-11-15', 'PAID', NULL, 22, NULL, 4, 4),
(72, '2026-03-15 16:09:02.118286', '2026-03-15 16:09:02.118286', NULL, 11, 2025, '100000', '2025-11-15', 'PAID', NULL, 22, NULL, 5, 4),
(73, '2026-03-15 16:09:02.121314', '2026-03-15 16:09:02.121314', NULL, 11, 2025, '660000', '2025-11-15', 'PENDING', NULL, 26, NULL, 1, 2),
(74, '2026-03-15 16:09:02.122317', '2026-03-15 16:09:02.122317', NULL, 11, 2025, '50000', '2025-11-15', 'PAID', NULL, 26, NULL, 4, 2),
(75, '2026-03-15 16:09:02.125854', '2026-03-15 16:09:02.125854', NULL, 11, 2025, '100000', '2025-11-15', 'PAID', NULL, 26, NULL, 5, 2),
(76, '2026-03-15 16:09:02.131395', '2026-03-15 16:09:02.131395', NULL, 10, 2025, '1080000', '2025-10-15', 'PAID', NULL, 12, NULL, 1, 1),
(77, '2026-03-15 16:09:02.135365', '2026-03-15 16:09:02.135365', NULL, 10, 2025, '50000', '2025-10-15', 'PAID', NULL, 12, NULL, 4, 1),
(78, '2026-03-15 16:09:02.138396', '2026-03-15 16:09:02.138396', NULL, 10, 2025, '100000', '2025-10-15', 'PAID', NULL, 12, NULL, 5, 1),
(79, '2026-03-15 16:09:02.141421', '2026-03-15 16:09:02.141421', NULL, 10, 2025, '1080000', '2025-10-15', 'PAID', NULL, 16, NULL, 1, 5),
(80, '2026-03-15 16:09:02.145452', '2026-03-15 16:09:02.145452', NULL, 10, 2025, '50000', '2025-10-15', 'PENDING', NULL, 16, NULL, 4, 5),
(81, '2026-03-15 16:09:02.145956', '2026-03-15 16:09:02.145956', NULL, 10, 2025, '100000', '2025-10-15', 'PAID', NULL, 16, NULL, 5, 5),
(82, '2026-03-15 16:09:02.151418', '2026-03-15 16:09:02.151418', NULL, 10, 2025, '900000', '2025-10-15', 'PAID', NULL, 19, NULL, 1, 3),
(83, '2026-03-15 16:09:02.154610', '2026-03-15 16:09:02.154610', NULL, 10, 2025, '50000', '2025-10-15', 'PAID', NULL, 19, NULL, 4, 3),
(84, '2026-03-15 16:09:02.159150', '2026-03-15 16:09:02.159150', NULL, 10, 2025, '100000', '2025-10-15', 'PAID', NULL, 19, NULL, 5, 3),
(85, '2026-03-15 16:09:02.162171', '2026-03-15 16:09:02.162171', NULL, 10, 2025, '960000', '2025-10-15', 'PAID', NULL, 22, NULL, 1, 4),
(86, '2026-03-15 16:09:02.165696', '2026-03-15 16:09:02.165696', NULL, 10, 2025, '50000', '2025-10-15', 'PAID', NULL, 22, NULL, 4, 4),
(87, '2026-03-15 16:09:02.168214', '2026-03-15 16:09:02.168214', NULL, 10, 2025, '100000', '2025-10-15', 'PAID', NULL, 22, NULL, 5, 4),
(88, '2026-03-15 16:09:02.172746', '2026-03-15 16:09:02.172746', NULL, 10, 2025, '660000', '2025-10-15', 'PAID', NULL, 26, NULL, 1, 2),
(89, '2026-03-15 16:09:02.174899', '2026-03-15 16:09:02.174899', NULL, 10, 2025, '50000', '2025-10-15', 'PAID', NULL, 26, NULL, 4, 2),
(90, '2026-03-15 16:09:02.179427', '2026-03-15 16:09:02.179427', NULL, 10, 2025, '100000', '2025-10-15', 'PAID', NULL, 26, NULL, 5, 2),
(91, '2026-03-15 16:09:02.182447', '2026-03-15 16:09:02.182447', NULL, 9, 2025, '1080000', '2025-09-15', 'PAID', NULL, 12, NULL, 1, 1),
(92, '2026-03-15 16:09:02.188501', '2026-03-15 16:09:02.188501', NULL, 9, 2025, '50000', '2025-09-15', 'PAID', NULL, 12, NULL, 4, 1),
(93, '2026-03-15 16:09:02.191522', '2026-03-15 16:09:02.191522', NULL, 9, 2025, '100000', '2025-09-15', 'PAID', NULL, 12, NULL, 5, 1),
(94, '2026-03-15 16:09:02.195554', '2026-03-15 16:09:02.195554', NULL, 9, 2025, '1080000', '2025-09-15', 'PAID', NULL, 16, NULL, 1, 5),
(95, '2026-03-15 16:09:02.199077', '2026-03-15 16:09:02.199077', NULL, 9, 2025, '50000', '2025-09-15', 'PAID', NULL, 16, NULL, 4, 5),
(96, '2026-03-15 16:09:02.202093', '2026-03-15 16:09:02.202093', NULL, 9, 2025, '100000', '2025-09-15', 'PAID', NULL, 16, NULL, 5, 5),
(97, '2026-03-15 16:09:02.207138', '2026-03-15 16:09:02.207138', NULL, 9, 2025, '900000', '2025-09-15', 'PAID', NULL, 19, NULL, 1, 3),
(98, '2026-03-15 16:09:02.211167', '2026-03-15 16:09:02.211167', NULL, 9, 2025, '50000', '2025-09-15', 'PAID', NULL, 19, NULL, 4, 3),
(99, '2026-03-15 16:09:02.213696', '2026-03-15 16:09:02.213696', NULL, 9, 2025, '100000', '2025-09-15', 'PAID', NULL, 19, NULL, 5, 3),
(100, '2026-03-15 16:09:02.216820', '2026-03-15 16:09:02.216820', NULL, 9, 2025, '960000', '2025-09-15', 'PAID', NULL, 22, NULL, 1, 4),
(101, '2026-03-15 16:09:02.220853', '2026-03-15 16:09:02.220853', NULL, 9, 2025, '50000', '2025-09-15', 'PAID', NULL, 22, NULL, 4, 4),
(102, '2026-03-15 16:09:02.223875', '2026-03-15 16:09:02.223875', NULL, 9, 2025, '100000', '2025-09-15', 'PAID', NULL, 22, NULL, 5, 4),
(103, '2026-03-15 16:09:02.225885', '2026-03-15 16:09:02.226891', NULL, 9, 2025, '660000', '2025-09-15', 'PAID', NULL, 26, NULL, 1, 2),
(104, '2026-03-15 16:09:02.228907', '2026-03-15 16:09:02.228907', NULL, 9, 2025, '50000', '2025-09-15', 'PAID', NULL, 26, NULL, 4, 2),
(105, '2026-03-15 16:09:02.232007', '2026-03-15 16:09:02.232007', NULL, 9, 2025, '100000', '2025-09-15', 'PAID', NULL, 26, NULL, 5, 2),
(106, '2026-03-15 16:09:27.837217', '2026-03-15 16:09:27.837217', NULL, 8, 2025, '1080000', '2025-08-15', 'PAID', NULL, 12, NULL, 1, 1),
(107, '2026-03-15 16:09:27.840234', '2026-03-15 16:09:27.840234', NULL, 8, 2025, '50000', '2025-08-15', 'PAID', NULL, 12, NULL, 4, 1),
(108, '2026-03-15 16:09:27.842248', '2026-03-15 16:09:27.842248', NULL, 8, 2025, '100000', '2025-08-15', 'PAID', NULL, 12, NULL, 5, 1),
(109, '2026-03-15 16:09:27.845273', '2026-03-15 16:09:27.845273', NULL, 8, 2025, '1080000', '2025-08-15', 'PAID', NULL, 16, NULL, 1, 5),
(110, '2026-03-15 16:09:27.847790', '2026-03-15 16:09:27.847790', NULL, 8, 2025, '50000', '2025-08-15', 'PAID', NULL, 16, NULL, 4, 5),
(111, '2026-03-15 16:09:27.851885', '2026-03-15 16:09:27.851885', NULL, 8, 2025, '100000', '2025-08-15', 'PAID', NULL, 16, NULL, 5, 5),
(112, '2026-03-15 16:09:27.854162', '2026-03-15 16:09:27.854162', NULL, 8, 2025, '900000', '2025-08-15', 'PAID', NULL, 19, NULL, 1, 3),
(113, '2026-03-15 16:09:27.857411', '2026-03-15 16:09:27.857411', NULL, 8, 2025, '50000', '2025-08-15', 'PAID', NULL, 19, NULL, 4, 3),
(114, '2026-03-15 16:09:27.859925', '2026-03-15 16:09:27.859925', NULL, 8, 2025, '100000', '2025-08-15', 'PAID', NULL, 19, NULL, 5, 3),
(115, '2026-03-15 16:09:27.861939', '2026-03-15 16:09:27.861939', NULL, 8, 2025, '960000', '2025-08-15', 'PAID', NULL, 22, NULL, 1, 4),
(116, '2026-03-15 16:09:27.863949', '2026-03-15 16:09:27.863949', NULL, 8, 2025, '50000', '2025-08-15', 'PAID', NULL, 22, NULL, 4, 4),
(117, '2026-03-15 16:09:27.866465', '2026-03-15 16:09:27.866465', NULL, 8, 2025, '100000', '2025-08-15', 'PAID', NULL, 22, NULL, 5, 4),
(118, '2026-03-15 16:09:27.868980', '2026-03-15 16:09:27.868980', NULL, 8, 2025, '660000', '2025-08-15', 'PAID', NULL, 26, NULL, 1, 2),
(119, '2026-03-15 16:09:27.870994', '2026-03-15 16:09:27.870994', NULL, 8, 2025, '50000', '2025-08-15', 'PAID', NULL, 26, NULL, 4, 2),
(120, '2026-03-15 16:09:27.873512', '2026-03-15 16:09:27.873512', NULL, 8, 2025, '100000', '2025-08-15', 'PAID', NULL, 26, NULL, 5, 2),
(121, '2026-03-15 16:09:27.875526', '2026-03-15 16:09:27.875526', NULL, 7, 2025, '1080000', '2025-07-15', 'PENDING', NULL, 12, NULL, 1, 1),
(122, '2026-03-15 16:09:27.877036', '2026-03-15 16:09:27.877036', NULL, 7, 2025, '50000', '2025-07-15', 'PAID', NULL, 12, NULL, 4, 1),
(123, '2026-03-15 16:09:27.879551', '2026-03-15 16:09:27.879551', NULL, 7, 2025, '100000', '2025-07-15', 'PAID', NULL, 12, NULL, 5, 1),
(124, '2026-03-15 16:09:27.881566', '2026-03-15 16:09:27.881566', NULL, 7, 2025, '1080000', '2025-07-15', 'PAID', NULL, 16, NULL, 1, 5),
(125, '2026-03-15 16:09:27.884160', '2026-03-15 16:09:27.884160', NULL, 7, 2025, '50000', '2025-07-15', 'PAID', NULL, 16, NULL, 4, 5),
(126, '2026-03-15 16:09:27.886172', '2026-03-15 16:09:27.886172', NULL, 7, 2025, '100000', '2025-07-15', 'PAID', NULL, 16, NULL, 5, 5),
(127, '2026-03-15 16:09:27.888686', '2026-03-15 16:09:27.888686', NULL, 7, 2025, '900000', '2025-07-15', 'PAID', NULL, 19, NULL, 1, 3),
(128, '2026-03-15 16:09:27.890703', '2026-03-15 16:09:27.890703', NULL, 7, 2025, '50000', '2025-07-15', 'PAID', NULL, 19, NULL, 4, 3),
(129, '2026-03-15 16:09:27.893722', '2026-03-15 16:09:27.893722', NULL, 7, 2025, '100000', '2025-07-15', 'PAID', NULL, 19, NULL, 5, 3),
(130, '2026-03-15 16:09:27.895231', '2026-03-15 16:09:27.895231', NULL, 7, 2025, '960000', '2025-07-15', 'PAID', NULL, 22, NULL, 1, 4),
(131, '2026-03-15 16:09:27.899762', '2026-03-15 16:09:27.899762', NULL, 7, 2025, '50000', '2025-07-15', 'PAID', NULL, 22, NULL, 4, 4),
(132, '2026-03-15 16:09:27.902275', '2026-03-15 16:09:27.902275', NULL, 7, 2025, '100000', '2025-07-15', 'PAID', NULL, 22, NULL, 5, 4),
(133, '2026-03-15 16:09:27.904297', '2026-03-15 16:09:27.904297', NULL, 7, 2025, '660000', '2025-07-15', 'PAID', NULL, 26, NULL, 1, 2),
(134, '2026-03-15 16:09:27.907317', '2026-03-15 16:09:27.907317', NULL, 7, 2025, '50000', '2025-07-15', 'PAID', NULL, 26, NULL, 4, 2),
(135, '2026-03-15 16:09:27.911339', '2026-03-15 16:09:27.911339', NULL, 7, 2025, '100000', '2025-07-15', 'PAID', NULL, 26, NULL, 5, 2),
(136, '2026-03-15 16:09:27.913356', '2026-03-15 16:09:27.913356', NULL, 6, 2025, '1080000', '2025-06-15', 'PAID', NULL, 12, NULL, 1, 1),
(137, '2026-03-15 16:09:27.915871', '2026-03-15 16:09:27.915871', NULL, 6, 2025, '50000', '2025-06-15', 'PAID', NULL, 12, NULL, 4, 1),
(138, '2026-03-15 16:09:27.917885', '2026-03-15 16:09:27.917885', NULL, 6, 2025, '100000', '2025-06-15', 'PAID', NULL, 12, NULL, 5, 1),
(139, '2026-03-15 16:09:27.920398', '2026-03-15 16:09:27.920398', NULL, 6, 2025, '1080000', '2025-06-15', 'PAID', NULL, 16, NULL, 1, 5),
(140, '2026-03-15 16:09:27.922412', '2026-03-15 16:09:27.922412', NULL, 6, 2025, '50000', '2025-06-15', 'PAID', NULL, 16, NULL, 4, 5),
(141, '2026-03-15 16:09:27.924927', '2026-03-15 16:09:27.924927', NULL, 6, 2025, '100000', '2025-06-15', 'PAID', NULL, 16, NULL, 5, 5),
(142, '2026-03-15 16:09:27.926941', '2026-03-15 16:09:27.926941', NULL, 6, 2025, '900000', '2025-06-15', 'PAID', NULL, 19, NULL, 1, 3),
(143, '2026-03-15 16:09:27.929966', '2026-03-15 16:09:27.929966', NULL, 6, 2025, '50000', '2025-06-15', 'PAID', NULL, 19, NULL, 4, 3),
(144, '2026-03-15 16:09:27.932482', '2026-03-15 16:09:27.932482', NULL, 6, 2025, '100000', '2025-06-15', 'PAID', NULL, 19, NULL, 5, 3),
(145, '2026-03-15 16:09:27.934496', '2026-03-15 16:09:27.934496', NULL, 6, 2025, '960000', '2025-06-15', 'PAID', NULL, 22, NULL, 1, 4),
(146, '2026-03-15 16:09:27.937521', '2026-03-15 16:09:27.937521', NULL, 6, 2025, '50000', '2025-06-15', 'PAID', NULL, 22, NULL, 4, 4),
(147, '2026-03-15 16:09:27.940416', '2026-03-15 16:09:27.940416', NULL, 6, 2025, '100000', '2025-06-15', 'PAID', NULL, 22, NULL, 5, 4),
(148, '2026-03-15 16:09:27.942429', '2026-03-15 16:09:27.942429', NULL, 6, 2025, '660000', '2025-06-15', 'PAID', NULL, 26, NULL, 1, 2),
(149, '2026-03-15 16:09:27.946453', '2026-03-15 16:09:27.946453', NULL, 6, 2025, '50000', '2025-06-15', 'PAID', NULL, 26, NULL, 4, 2),
(150, '2026-03-15 16:09:27.949484', '2026-03-15 16:09:27.949484', NULL, 6, 2025, '100000', '2025-06-15', 'PAID', NULL, 26, NULL, 5, 2),
(151, '2026-03-15 16:09:27.953515', '2026-03-15 16:09:27.953515', NULL, 5, 2025, '1080000', '2025-05-15', 'PAID', NULL, 12, NULL, 1, 1),
(152, '2026-03-15 16:09:27.955526', '2026-03-15 16:09:27.955526', NULL, 5, 2025, '50000', '2025-05-15', 'PAID', NULL, 12, NULL, 4, 1),
(153, '2026-03-15 16:09:27.957542', '2026-03-15 16:09:27.957542', NULL, 5, 2025, '100000', '2025-05-15', 'PAID', NULL, 12, NULL, 5, 1),
(154, '2026-03-15 16:09:27.960562', '2026-03-15 16:09:27.960562', NULL, 5, 2025, '1080000', '2025-05-15', 'PAID', NULL, 16, NULL, 1, 5),
(155, '2026-03-15 16:09:27.963076', '2026-03-15 16:09:27.963076', NULL, 5, 2025, '50000', '2025-05-15', 'PAID', NULL, 16, NULL, 4, 5),
(156, '2026-03-15 16:09:27.966096', '2026-03-15 16:09:27.966096', NULL, 5, 2025, '100000', '2025-05-15', 'PENDING', NULL, 16, NULL, 5, 5),
(157, '2026-03-15 16:09:27.967111', '2026-03-15 16:09:27.967111', NULL, 5, 2025, '900000', '2025-05-15', 'PAID', NULL, 19, NULL, 1, 3),
(158, '2026-03-15 16:09:27.969121', '2026-03-15 16:09:27.969121', NULL, 5, 2025, '50000', '2025-05-15', 'PAID', NULL, 19, NULL, 4, 3),
(159, '2026-03-15 16:09:27.971137', '2026-03-15 16:09:27.971137', NULL, 5, 2025, '100000', '2025-05-15', 'PAID', NULL, 19, NULL, 5, 3),
(160, '2026-03-15 16:09:27.975161', '2026-03-15 16:09:27.975161', NULL, 5, 2025, '960000', '2025-05-15', 'PAID', NULL, 22, NULL, 1, 4),
(161, '2026-03-15 16:09:27.977183', '2026-03-15 16:09:27.977183', NULL, 5, 2025, '50000', '2025-05-15', 'PAID', NULL, 22, NULL, 4, 4),
(162, '2026-03-15 16:09:27.980200', '2026-03-15 16:09:27.980200', NULL, 5, 2025, '100000', '2025-05-15', 'PAID', NULL, 22, NULL, 5, 4),
(163, '2026-03-15 16:09:27.982714', '2026-03-15 16:09:27.982714', NULL, 5, 2025, '660000', '2025-05-15', 'PENDING', NULL, 26, NULL, 1, 2),
(164, '2026-03-15 16:09:27.983721', '2026-03-15 16:09:27.983721', NULL, 5, 2025, '50000', '2025-05-15', 'PAID', NULL, 26, NULL, 4, 2),
(165, '2026-03-15 16:09:27.986240', '2026-03-15 16:09:27.986240', NULL, 5, 2025, '100000', '2025-05-15', 'PAID', NULL, 26, NULL, 5, 2),
(166, '2026-03-15 16:09:27.989258', '2026-03-15 16:09:27.989258', NULL, 4, 2025, '1080000', '2025-04-15', 'PAID', NULL, 12, NULL, 1, 1),
(167, '2026-03-15 16:09:27.991771', '2026-03-15 16:09:27.991771', NULL, 4, 2025, '50000', '2025-04-15', 'PAID', NULL, 12, NULL, 4, 1),
(168, '2026-03-15 16:09:27.994794', '2026-03-15 16:09:27.994794', NULL, 4, 2025, '100000', '2025-04-15', 'PAID', NULL, 12, NULL, 5, 1),
(169, '2026-03-15 16:09:27.996807', '2026-03-15 16:09:27.996807', NULL, 4, 2025, '1080000', '2025-04-15', 'PAID', NULL, 16, NULL, 1, 5),
(170, '2026-03-15 16:09:27.999828', '2026-03-15 16:09:27.999828', NULL, 4, 2025, '50000', '2025-04-15', 'PENDING', NULL, 16, NULL, 4, 5),
(171, '2026-03-15 16:09:28.000833', '2026-03-15 16:09:28.000833', NULL, 4, 2025, '100000', '2025-04-15', 'PAID', NULL, 16, NULL, 5, 5),
(172, '2026-03-15 16:09:28.004366', '2026-03-15 16:09:28.004366', NULL, 4, 2025, '900000', '2025-04-15', 'PAID', NULL, 19, NULL, 1, 3),
(173, '2026-03-15 16:09:28.006879', '2026-03-15 16:09:28.006879', NULL, 4, 2025, '50000', '2025-04-15', 'PAID', NULL, 19, NULL, 4, 3),
(174, '2026-03-15 16:09:28.010403', '2026-03-15 16:09:28.010403', NULL, 4, 2025, '100000', '2025-04-15', 'PAID', NULL, 19, NULL, 5, 3),
(175, '2026-03-15 16:09:28.012916', '2026-03-15 16:09:28.012916', NULL, 4, 2025, '960000', '2025-04-15', 'PAID', NULL, 22, NULL, 1, 4),
(176, '2026-03-15 16:09:28.014931', '2026-03-15 16:09:28.014931', NULL, 4, 2025, '50000', '2025-04-15', 'PAID', NULL, 22, NULL, 4, 4),
(177, '2026-03-15 16:09:28.026887', '2026-03-15 16:09:28.026887', NULL, 4, 2025, '100000', '2025-04-15', 'PAID', NULL, 22, NULL, 5, 4),
(178, '2026-03-15 16:09:28.030416', '2026-03-15 16:09:28.030416', NULL, 4, 2025, '660000', '2025-04-15', 'PAID', NULL, 26, NULL, 1, 2),
(179, '2026-03-15 16:09:28.033435', '2026-03-15 16:09:28.033435', NULL, 4, 2025, '50000', '2025-04-15', 'PAID', NULL, 26, NULL, 4, 2),
(180, '2026-03-15 16:09:28.036454', '2026-03-15 16:09:28.036454', NULL, 4, 2025, '100000', '2025-04-15', 'PAID', NULL, 26, NULL, 5, 2),
(181, '2026-03-15 16:09:28.039476', '2026-03-15 16:09:28.039476', NULL, 3, 2025, '1080000', '2025-03-15', 'PAID', NULL, 12, NULL, 1, 1),
(182, '2026-03-15 16:09:28.044002', '2026-03-15 16:09:28.044002', NULL, 3, 2025, '50000', '2025-03-15', 'PAID', NULL, 12, NULL, 4, 1),
(183, '2026-03-15 16:09:28.047021', '2026-03-15 16:09:28.047021', NULL, 3, 2025, '100000', '2025-03-15', 'PAID', NULL, 12, NULL, 5, 1),
(184, '2026-03-15 16:09:28.050041', '2026-03-15 16:09:28.050041', NULL, 3, 2025, '1080000', '2025-03-15', 'PAID', NULL, 16, NULL, 1, 5),
(185, '2026-03-15 16:09:28.052551', '2026-03-15 16:09:28.052551', NULL, 3, 2025, '50000', '2025-03-15', 'PAID', NULL, 16, NULL, 4, 5),
(186, '2026-03-15 16:09:28.054561', '2026-03-15 16:09:28.054561', NULL, 3, 2025, '100000', '2025-03-15', 'PAID', NULL, 16, NULL, 5, 5),
(187, '2026-03-15 16:09:28.059100', '2026-03-15 16:09:28.059100', NULL, 3, 2025, '900000', '2025-03-15', 'PAID', NULL, 19, NULL, 1, 3),
(188, '2026-03-15 16:09:28.063629', '2026-03-15 16:09:28.063629', NULL, 3, 2025, '50000', '2025-03-15', 'PAID', NULL, 19, NULL, 4, 3),
(189, '2026-03-15 16:09:28.066147', '2026-03-15 16:09:28.066147', NULL, 3, 2025, '100000', '2025-03-15', 'PAID', NULL, 19, NULL, 5, 3),
(190, '2026-03-15 16:09:28.068188', '2026-03-15 16:09:28.068188', NULL, 3, 2025, '960000', '2025-03-15', 'PAID', NULL, 22, NULL, 1, 4),
(191, '2026-03-15 16:09:28.072213', '2026-03-15 16:09:28.072213', NULL, 3, 2025, '50000', '2025-03-15', 'PAID', NULL, 22, NULL, 4, 4),
(192, '2026-03-15 16:09:28.075741', '2026-03-15 16:09:28.075741', NULL, 3, 2025, '100000', '2025-03-15', 'PAID', NULL, 22, NULL, 5, 4),
(193, '2026-03-15 16:09:28.078255', '2026-03-15 16:09:28.078255', NULL, 3, 2025, '660000', '2025-03-15', 'PAID', NULL, 26, NULL, 1, 2),
(194, '2026-03-15 16:09:28.080269', '2026-03-15 16:09:28.080269', NULL, 3, 2025, '50000', '2025-03-15', 'PAID', NULL, 26, NULL, 4, 2),
(195, '2026-03-15 16:09:28.082785', '2026-03-15 16:09:28.082785', NULL, 3, 2025, '100000', '2025-03-15', 'PAID', NULL, 26, NULL, 5, 2),
(196, '2026-03-15 16:09:28.084801', '2026-03-15 16:09:28.084801', NULL, 2, 2025, '1080000', '2025-02-15', 'PAID', NULL, 12, NULL, 1, 1),
(197, '2026-03-15 16:09:28.087314', '2026-03-15 16:09:28.087314', NULL, 2, 2025, '50000', '2025-02-15', 'PAID', NULL, 12, NULL, 4, 1),
(198, '2026-03-15 16:09:28.091847', '2026-03-15 16:09:28.091847', NULL, 2, 2025, '100000', '2025-02-15', 'PAID', NULL, 12, NULL, 5, 1),
(199, '2026-03-15 16:09:28.093863', '2026-03-15 16:09:28.093863', NULL, 2, 2025, '1080000', '2025-02-15', 'PAID', NULL, 16, NULL, 1, 5),
(200, '2026-03-15 16:09:28.096882', '2026-03-15 16:09:28.096882', NULL, 2, 2025, '50000', '2025-02-15', 'PAID', NULL, 16, NULL, 4, 5),
(201, '2026-03-15 16:09:28.099903', '2026-03-15 16:09:28.099903', NULL, 2, 2025, '100000', '2025-02-15', 'PAID', NULL, 16, NULL, 5, 5),
(202, '2026-03-15 16:09:28.102414', '2026-03-15 16:09:28.102414', NULL, 2, 2025, '900000', '2025-02-15', 'PAID', NULL, 19, NULL, 1, 3),
(203, '2026-03-15 16:09:28.104430', '2026-03-15 16:09:28.104430', NULL, 2, 2025, '50000', '2025-02-15', 'PAID', NULL, 19, NULL, 4, 3),
(204, '2026-03-15 16:09:28.113990', '2026-03-15 16:09:28.113990', NULL, 2, 2025, '100000', '2025-02-15', 'PAID', NULL, 19, NULL, 5, 3),
(205, '2026-03-15 16:09:28.116510', '2026-03-15 16:09:28.116510', NULL, 2, 2025, '960000', '2025-02-15', 'PAID', NULL, 22, NULL, 1, 4),
(206, '2026-03-15 16:09:28.119530', '2026-03-15 16:09:28.119530', NULL, 2, 2025, '50000', '2025-02-15', 'PAID', NULL, 22, NULL, 4, 4),
(207, '2026-03-15 16:09:28.124061', '2026-03-15 16:09:28.124061', NULL, 2, 2025, '100000', '2025-02-15', 'PENDING', NULL, 22, NULL, 5, 4),
(208, '2026-03-15 16:09:28.125065', '2026-03-15 16:09:28.125065', NULL, 2, 2025, '660000', '2025-02-15', 'PAID', NULL, 26, NULL, 1, 2),
(209, '2026-03-15 16:09:28.127582', '2026-03-15 16:09:28.127582', NULL, 2, 2025, '50000', '2025-02-15', 'PAID', NULL, 26, NULL, 4, 2),
(210, '2026-03-15 16:09:28.129587', '2026-03-15 16:09:28.129587', NULL, 2, 2025, '100000', '2025-02-15', 'PAID', NULL, 26, NULL, 5, 2),
(211, '2026-03-15 16:09:28.131600', '2026-03-15 16:09:28.131600', NULL, 1, 2025, '1080000', '2025-01-15', 'PAID', NULL, 12, NULL, 1, 1),
(212, '2026-03-15 16:09:28.134359', '2026-03-15 16:09:28.134359', NULL, 1, 2025, '50000', '2025-01-15', 'PAID', NULL, 12, NULL, 4, 1),
(213, '2026-03-15 16:09:28.136382', '2026-03-15 16:09:28.136382', NULL, 1, 2025, '100000', '2025-01-15', 'PAID', NULL, 12, NULL, 5, 1),
(214, '2026-03-15 16:09:28.139405', '2026-03-15 16:09:28.139405', NULL, 1, 2025, '1080000', '2025-01-15', 'PAID', NULL, 16, NULL, 1, 5),
(215, '2026-03-15 16:09:28.141919', '2026-03-15 16:09:28.141919', NULL, 1, 2025, '50000', '2025-01-15', 'PAID', NULL, 16, NULL, 4, 5),
(216, '2026-03-15 16:09:28.143934', '2026-03-15 16:09:28.143934', NULL, 1, 2025, '100000', '2025-01-15', 'PENDING', NULL, 16, NULL, 5, 5),
(217, '2026-03-15 16:09:28.145443', '2026-03-15 16:09:28.145443', NULL, 1, 2025, '900000', '2025-01-15', 'PAID', NULL, 19, NULL, 1, 3),
(218, '2026-03-15 16:09:28.148461', '2026-03-15 16:09:28.148461', NULL, 1, 2025, '50000', '2025-01-15', 'PAID', NULL, 19, NULL, 4, 3),
(219, '2026-03-15 16:09:28.152485', '2026-03-15 16:09:28.152485', NULL, 1, 2025, '100000', '2025-01-15', 'PAID', NULL, 19, NULL, 5, 3),
(220, '2026-03-15 16:09:28.154514', '2026-03-15 16:09:28.154514', NULL, 1, 2025, '960000', '2025-01-15', 'PAID', NULL, 22, NULL, 1, 4),
(221, '2026-03-15 16:09:28.157532', '2026-03-15 16:09:28.157532', NULL, 1, 2025, '50000', '2025-01-15', 'PAID', NULL, 22, NULL, 4, 4),
(222, '2026-03-15 16:09:28.160552', '2026-03-15 16:09:28.160552', NULL, 1, 2025, '100000', '2025-01-15', 'PAID', NULL, 22, NULL, 5, 4),
(223, '2026-03-15 16:09:28.163570', '2026-03-15 16:09:28.163570', NULL, 1, 2025, '660000', '2025-01-15', 'PAID', NULL, 26, NULL, 1, 2),
(224, '2026-03-15 16:09:28.166090', '2026-03-15 16:09:28.166090', NULL, 1, 2025, '50000', '2025-01-15', 'PAID', NULL, 26, NULL, 4, 2),
(225, '2026-03-15 16:09:28.168113', '2026-03-15 16:09:28.168113', NULL, 1, 2025, '100000', '2025-01-15', 'PENDING', NULL, 26, NULL, 5, 2),
(226, '2026-03-15 16:09:28.169619', '2026-03-15 16:09:28.169619', NULL, 12, 2024, '1080000', '2024-12-15', 'PENDING', NULL, 12, NULL, 1, 1),
(227, '2026-03-15 16:09:28.170623', '2026-03-15 16:09:28.170623', NULL, 12, 2024, '50000', '2024-12-15', 'PAID', NULL, 12, NULL, 4, 1),
(228, '2026-03-15 16:09:28.172132', '2026-03-15 16:09:28.172132', NULL, 12, 2024, '100000', '2024-12-15', 'PAID', NULL, 12, NULL, 5, 1),
(229, '2026-03-15 16:09:28.174148', '2026-03-15 16:09:28.174148', NULL, 12, 2024, '1080000', '2024-12-15', 'PAID', NULL, 16, NULL, 1, 5),
(230, '2026-03-15 16:09:28.177165', '2026-03-15 16:09:28.177165', NULL, 12, 2024, '50000', '2024-12-15', 'PAID', NULL, 16, NULL, 4, 5),
(231, '2026-03-15 16:09:28.178674', '2026-03-15 16:09:28.178674', NULL, 12, 2024, '100000', '2024-12-15', 'PAID', NULL, 16, NULL, 5, 5),
(232, '2026-03-15 16:09:28.181189', '2026-03-15 16:09:28.181189', NULL, 12, 2024, '900000', '2024-12-15', 'PAID', NULL, 19, NULL, 1, 3),
(233, '2026-03-15 16:09:28.183711', '2026-03-15 16:09:28.183711', NULL, 12, 2024, '50000', '2024-12-15', 'PAID', NULL, 19, NULL, 4, 3),
(234, '2026-03-15 16:09:28.185722', '2026-03-15 16:09:28.185722', NULL, 12, 2024, '100000', '2024-12-15', 'PAID', NULL, 19, NULL, 5, 3),
(235, '2026-03-15 16:09:28.187734', '2026-03-15 16:09:28.187734', NULL, 12, 2024, '960000', '2024-12-15', 'PAID', NULL, 22, NULL, 1, 4),
(236, '2026-03-15 16:09:28.190244', '2026-03-15 16:09:28.190244', NULL, 12, 2024, '50000', '2024-12-15', 'PAID', NULL, 22, NULL, 4, 4),
(237, '2026-03-15 16:09:28.192258', '2026-03-15 16:09:28.192258', NULL, 12, 2024, '100000', '2024-12-15', 'PAID', NULL, 22, NULL, 5, 4),
(238, '2026-03-15 16:09:28.194772', '2026-03-15 16:09:28.194772', NULL, 12, 2024, '660000', '2024-12-15', 'PAID', NULL, 26, NULL, 1, 2),
(239, '2026-03-15 16:09:28.196786', '2026-03-15 16:09:28.196786', NULL, 12, 2024, '50000', '2024-12-15', 'PAID', NULL, 26, NULL, 4, 2),
(240, '2026-03-15 16:09:28.199809', '2026-03-15 16:09:28.199809', NULL, 12, 2024, '100000', '2024-12-15', 'PAID', NULL, 26, NULL, 5, 2),
(241, '2026-03-15 16:09:28.201317', '2026-03-15 16:09:28.201317', NULL, 11, 2024, '1080000', '2024-11-15', 'PAID', NULL, 12, NULL, 1, 1),
(242, '2026-03-15 16:09:28.203841', '2026-03-15 16:09:28.204341', NULL, 11, 2024, '50000', '2024-11-15', 'PAID', NULL, 12, NULL, 4, 1),
(243, '2026-03-15 16:09:28.206857', '2026-03-15 16:09:28.206857', NULL, 11, 2024, '100000', '2024-11-15', 'PAID', NULL, 12, NULL, 5, 1),
(244, '2026-03-15 16:09:28.209876', '2026-03-15 16:09:28.209876', NULL, 11, 2024, '1080000', '2024-11-15', 'PAID', NULL, 16, NULL, 1, 5),
(245, '2026-03-15 16:09:28.211889', '2026-03-15 16:09:28.211889', NULL, 11, 2024, '50000', '2024-11-15', 'PAID', NULL, 16, NULL, 4, 5),
(246, '2026-03-15 16:09:28.214909', '2026-03-15 16:09:28.214909', NULL, 11, 2024, '100000', '2024-11-15', 'PAID', NULL, 16, NULL, 5, 5),
(247, '2026-03-15 16:09:28.217419', '2026-03-15 16:09:28.217419', NULL, 11, 2024, '900000', '2024-11-15', 'PAID', NULL, 19, NULL, 1, 3),
(248, '2026-03-15 16:09:28.220945', '2026-03-15 16:09:28.220945', NULL, 11, 2024, '50000', '2024-11-15', 'PAID', NULL, 19, NULL, 4, 3),
(249, '2026-03-15 16:09:28.223456', '2026-03-15 16:09:28.223456', NULL, 11, 2024, '100000', '2024-11-15', 'PENDING', NULL, 19, NULL, 5, 3),
(250, '2026-03-15 16:09:28.223961', '2026-03-15 16:09:28.223961', NULL, 11, 2024, '960000', '2024-11-15', 'PAID', NULL, 22, NULL, 1, 4),
(251, '2026-03-15 16:09:28.226472', '2026-03-15 16:09:28.226472', NULL, 11, 2024, '50000', '2024-11-15', 'PAID', NULL, 22, NULL, 4, 4),
(252, '2026-03-15 16:09:28.228484', '2026-03-15 16:09:28.228484', NULL, 11, 2024, '100000', '2024-11-15', 'PAID', NULL, 22, NULL, 5, 4),
(253, '2026-03-15 16:09:28.232506', '2026-03-15 16:09:28.232506', NULL, 11, 2024, '660000', '2024-11-15', 'PAID', NULL, 26, NULL, 1, 2),
(254, '2026-03-15 16:09:28.234522', '2026-03-15 16:09:28.234522', NULL, 11, 2024, '50000', '2024-11-15', 'PAID', NULL, 26, NULL, 4, 2),
(255, '2026-03-15 16:09:28.237034', '2026-03-15 16:09:28.237034', NULL, 11, 2024, '100000', '2024-11-15', 'PAID', NULL, 26, NULL, 5, 2),
(256, '2026-03-15 16:09:28.239047', '2026-03-15 16:09:28.239047', NULL, 10, 2024, '1080000', '2024-10-15', 'PENDING', NULL, 12, NULL, 1, 1),
(257, '2026-03-15 16:09:28.240052', '2026-03-15 16:09:28.240052', NULL, 10, 2024, '50000', '2024-10-15', 'PAID', NULL, 12, NULL, 4, 1),
(258, '2026-03-15 16:09:28.242065', '2026-03-15 16:09:28.242065', NULL, 10, 2024, '100000', '2024-10-15', 'PAID', NULL, 12, NULL, 5, 1),
(259, '2026-03-15 16:09:28.244579', '2026-03-15 16:09:28.244579', NULL, 10, 2024, '1080000', '2024-10-15', 'PAID', NULL, 16, NULL, 1, 5),
(260, '2026-03-15 16:09:28.247613', '2026-03-15 16:09:28.247613', NULL, 10, 2024, '50000', '2024-10-15', 'PAID', NULL, 16, NULL, 4, 5),
(261, '2026-03-15 16:09:28.249625', '2026-03-15 16:09:28.249625', NULL, 10, 2024, '100000', '2024-10-15', 'PAID', NULL, 16, NULL, 5, 5),
(262, '2026-03-15 16:09:28.253145', '2026-03-15 16:09:28.253645', NULL, 10, 2024, '900000', '2024-10-15', 'PAID', NULL, 19, NULL, 1, 3),
(263, '2026-03-15 16:09:28.255666', '2026-03-15 16:09:28.255666', NULL, 10, 2024, '50000', '2024-10-15', 'PAID', NULL, 19, NULL, 4, 3),
(264, '2026-03-15 16:09:28.258181', '2026-03-15 16:09:28.258181', NULL, 10, 2024, '100000', '2024-10-15', 'PAID', NULL, 19, NULL, 5, 3),
(265, '2026-03-15 16:09:28.261202', '2026-03-15 16:09:28.261202', NULL, 10, 2024, '960000', '2024-10-15', 'PAID', NULL, 22, NULL, 1, 4),
(266, '2026-03-15 16:09:28.263717', '2026-03-15 16:09:28.263717', NULL, 10, 2024, '50000', '2024-10-15', 'PAID', NULL, 22, NULL, 4, 4),
(267, '2026-03-15 16:09:28.267240', '2026-03-15 16:09:28.267240', NULL, 10, 2024, '100000', '2024-10-15', 'PAID', NULL, 22, NULL, 5, 4),
(268, '2026-03-15 16:09:28.270762', '2026-03-15 16:09:28.270762', NULL, 10, 2024, '660000', '2024-10-15', 'PAID', NULL, 26, NULL, 1, 2),
(269, '2026-03-15 16:09:28.273781', '2026-03-15 16:09:28.273781', NULL, 10, 2024, '50000', '2024-10-15', 'PAID', NULL, 26, NULL, 4, 2),
(270, '2026-03-15 16:09:28.276293', '2026-03-15 16:09:28.276293', NULL, 10, 2024, '100000', '2024-10-15', 'PAID', NULL, 26, NULL, 5, 2),
(271, '2026-03-15 16:09:28.279311', '2026-03-15 16:09:28.279311', NULL, 9, 2024, '1080000', '2024-09-15', 'PAID', NULL, 12, NULL, 1, 1),
(272, '2026-03-15 16:09:28.282327', '2026-03-15 16:09:28.282327', NULL, 9, 2024, '50000', '2024-09-15', 'PAID', NULL, 12, NULL, 4, 1),
(273, '2026-03-15 16:09:28.285350', '2026-03-15 16:09:28.285350', NULL, 9, 2024, '100000', '2024-09-15', 'PAID', NULL, 12, NULL, 5, 1),
(274, '2026-03-15 16:09:28.290374', '2026-03-15 16:09:28.290374', NULL, 9, 2024, '1080000', '2024-09-15', 'PAID', NULL, 16, NULL, 1, 5),
(275, '2026-03-15 16:09:28.294388', '2026-03-15 16:09:28.294388', NULL, 9, 2024, '50000', '2024-09-15', 'PAID', NULL, 16, NULL, 4, 5),
(276, '2026-03-15 16:09:28.300409', '2026-03-15 16:09:28.300409', NULL, 9, 2024, '100000', '2024-09-15', 'PAID', NULL, 16, NULL, 5, 5),
(277, '2026-03-15 16:09:28.303929', '2026-03-15 16:09:28.303929', NULL, 9, 2024, '900000', '2024-09-15', 'PAID', NULL, 19, NULL, 1, 3),
(278, '2026-03-15 16:09:28.307762', '2026-03-15 16:09:28.307762', NULL, 9, 2024, '50000', '2024-09-15', 'PAID', NULL, 19, NULL, 4, 3),
(279, '2026-03-15 16:09:28.311786', '2026-03-15 16:09:28.311786', NULL, 9, 2024, '100000', '2024-09-15', 'PAID', NULL, 19, NULL, 5, 3),
(280, '2026-03-15 16:09:28.317973', '2026-03-15 16:09:28.317973', NULL, 9, 2024, '960000', '2024-09-15', 'PAID', NULL, 22, NULL, 1, 4),
(281, '2026-03-15 16:09:28.320994', '2026-03-15 16:09:28.320994', NULL, 9, 2024, '50000', '2024-09-15', 'PAID', NULL, 22, NULL, 4, 4),
(282, '2026-03-15 16:09:28.324013', '2026-03-15 16:09:28.324013', NULL, 9, 2024, '100000', '2024-09-15', 'PENDING', NULL, 22, NULL, 5, 4),
(283, '2026-03-15 16:09:28.325158', '2026-03-15 16:09:28.325158', NULL, 9, 2024, '660000', '2024-09-15', 'PAID', NULL, 26, NULL, 1, 2),
(284, '2026-03-15 16:09:28.328178', '2026-03-15 16:09:28.328682', NULL, 9, 2024, '50000', '2024-09-15', 'PAID', NULL, 26, NULL, 4, 2),
(285, '2026-03-15 16:09:28.331700', '2026-03-15 16:09:28.331700', NULL, 9, 2024, '100000', '2024-09-15', 'PAID', NULL, 26, NULL, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `fees_payment`
--

CREATE TABLE `fees_payment` (
  `id` bigint NOT NULL,
  `amount_paid` decimal(12,0) NOT NULL,
  `paid_at` datetime(6) NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `receipt_image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `invoice_id` bigint NOT NULL,
  `received_by_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fees_payment`
--

INSERT INTO `fees_payment` (`id`, `amount_paid`, `paid_at`, `method`, `transaction_id`, `note`, `receipt_image`, `created_at`, `invoice_id`, `received_by_id`) VALUES
(1, '1080000', '2026-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.934990', 16, 1),
(2, '50000', '2026-02-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:01.939541', 17, 1),
(3, '100000', '2026-02-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.942563', 18, 1),
(4, '1080000', '2026-02-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.945582', 19, 1),
(5, '25000', '2026-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.948609', 20, 1),
(6, '25000', '2026-03-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.951425', 20, 1),
(7, '100000', '2026-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.954951', 21, 1),
(8, '900000', '2026-02-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.957979', 22, 1),
(9, '50000', '2026-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.960999', 23, 1),
(10, '100000', '2026-02-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.964017', 24, 1),
(11, '960000', '2026-02-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.966529', 25, 1),
(12, '50000', '2026-02-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.968545', 26, 1),
(13, '100000', '2026-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.971566', 27, 1),
(14, '660000', '2026-02-20 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:01.974089', 28, 1),
(15, '50000', '2026-02-25 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:01.976096', 29, 1),
(16, '100000', '2026-02-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.979119', 30, 1),
(17, '50000', '2026-01-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.982137', 32, 1),
(18, '100000', '2026-01-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.984651', 33, 1),
(19, '1080000', '2026-02-03 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:01.987175', 34, 1),
(20, '50000', '2026-01-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.989696', 35, 1),
(21, '100000', '2026-02-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:01.992209', 36, 1),
(22, '900000', '2026-01-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.994226', 37, 1),
(23, '50000', '2026-01-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:01.997289', 38, 1),
(24, '100000', '2026-02-03 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.000312', 39, 1),
(25, '480000', '2026-01-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.003332', 40, 1),
(26, '480000', '2026-02-06 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.004865', 40, 1),
(27, '50000', '2026-01-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.007887', 41, 1),
(28, '100000', '2026-01-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.010405', 42, 1),
(29, '660000', '2026-01-17 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.013927', 43, 1),
(30, '25000', '2026-01-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.019963', 44, 1),
(31, '25000', '2026-01-31 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.022980', 44, 1),
(32, '100000', '2026-01-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.027574', 45, 1),
(33, '1080000', '2025-12-20 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.031106', 46, 1),
(34, '50000', '2025-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.034138', 47, 1),
(35, '100000', '2025-12-17 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.037175', 48, 1),
(36, '1080000', '2025-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.040194', 49, 1),
(37, '50000', '2025-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.043216', 50, 1),
(38, '100000', '2025-12-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.047284', 51, 1),
(39, '900000', '2025-12-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.050819', 52, 1),
(40, '50000', '2025-12-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.053834', 53, 1),
(41, '100000', '2025-12-16 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.056857', 54, 1),
(42, '960000', '2025-12-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.059881', 55, 1),
(43, '50000', '2025-12-27 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.062398', 56, 1),
(44, '100000', '2025-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.065468', 57, 1),
(45, '330000', '2025-12-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.068492', 58, 1),
(46, '330000', '2025-12-25 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.071014', 58, 1),
(47, '50000', '2025-12-27 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.074042', 59, 1),
(48, '50000', '2025-12-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.077054', 60, 1),
(49, '50000', '2025-12-23 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.078564', 60, 1),
(50, '1080000', '2025-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.081583', 61, 1),
(51, '50000', '2025-12-02 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.083598', 62, 1),
(52, '100000', '2025-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.087713', 63, 1),
(53, '1080000', '2025-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.092239', 64, 1),
(54, '50000', '2025-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.096286', 65, 1),
(55, '900000', '2025-11-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.101828', 67, 1),
(56, '50000', '2025-11-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.105098', 68, 1),
(57, '50000', '2025-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.108131', 69, 1),
(58, '50000', '2025-12-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.109641', 69, 1),
(59, '960000', '2025-11-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.112165', 70, 1),
(60, '50000', '2025-11-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.115249', 71, 1),
(61, '100000', '2025-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.119289', 72, 1),
(62, '50000', '2025-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.123843', 74, 1),
(63, '50000', '2025-11-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.127367', 75, 1),
(64, '50000', '2025-11-22 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.128879', 75, 1),
(65, '1080000', '2025-11-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.131900', 76, 1),
(66, '50000', '2025-10-25 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.135365', 77, 1),
(67, '100000', '2025-10-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.139402', 78, 1),
(68, '1080000', '2025-10-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.142427', 79, 1),
(69, '50000', '2025-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.146963', 81, 1),
(70, '50000', '2025-11-04 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.148474', 81, 1),
(71, '900000', '2025-10-31 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.151924', 82, 1),
(72, '25000', '2025-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.155114', 83, 1),
(73, '25000', '2025-11-08 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.157134', 83, 1),
(74, '100000', '2025-10-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.159652', 84, 1),
(75, '960000', '2025-10-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.163182', 85, 1),
(76, '50000', '2025-10-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.165696', 86, 1),
(77, '50000', '2025-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.168719', 87, 1),
(78, '50000', '2025-11-03 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.170231', 87, 1),
(79, '660000', '2025-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.173252', 88, 1),
(80, '25000', '2025-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.175902', 89, 1),
(81, '25000', '2025-10-26 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.177413', 89, 1),
(82, '100000', '2025-10-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.179427', 90, 1),
(83, '540000', '2025-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.183458', 91, 1),
(84, '540000', '2025-10-04 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.185477', 91, 1),
(85, '50000', '2025-10-02 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.189504', 92, 1),
(86, '100000', '2025-09-19 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.192525', 93, 1),
(87, '1080000', '2025-10-02 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.196058', 94, 1),
(88, '50000', '2025-09-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.200080', 95, 1),
(89, '50000', '2025-09-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.203103', 96, 1),
(90, '50000', '2025-09-25 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.204614', 96, 1),
(91, '450000', '2025-09-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.207643', 97, 1),
(92, '450000', '2025-09-28 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.209152', 97, 1),
(93, '50000', '2025-09-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.212172', 98, 1),
(94, '100000', '2025-09-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.214807', 99, 1),
(95, '480000', '2025-09-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.216820', 100, 1),
(96, '480000', '2025-09-22 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.218331', 100, 1),
(97, '50000', '2025-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.221353', 101, 1),
(98, '100000', '2025-09-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.223875', 102, 1),
(99, '660000', '2025-09-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.227397', 103, 1),
(100, '50000', '2025-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:02.229992', 104, 1),
(101, '100000', '2025-09-16 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:02.232007', 105, 1),
(102, '1080000', '2025-08-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.837721', 106, 1),
(103, '50000', '2025-08-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.840739', 107, 1),
(104, '100000', '2025-08-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.843259', 108, 1),
(105, '1080000', '2025-08-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.845273', 109, 1),
(106, '25000', '2025-08-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.848295', 110, 1),
(107, '25000', '2025-09-06 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.849812', 110, 1),
(108, '100000', '2025-08-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.852390', 111, 1),
(109, '900000', '2025-08-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.854162', 112, 1),
(110, '50000', '2025-08-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.857411', 113, 1),
(111, '100000', '2025-08-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.860430', 114, 1),
(112, '960000', '2025-08-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.861939', 115, 1),
(113, '50000', '2025-08-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.864453', 116, 1),
(114, '100000', '2025-08-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.866465', 117, 1),
(115, '660000', '2025-08-20 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.869485', 118, 1),
(116, '50000', '2025-08-25 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.870994', 119, 1),
(117, '100000', '2025-08-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.874017', 120, 1),
(118, '50000', '2025-07-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.877036', 122, 1),
(119, '100000', '2025-07-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.879551', 123, 1),
(120, '1080000', '2025-08-03 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.881566', 124, 1),
(121, '50000', '2025-07-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.884665', 125, 1),
(122, '100000', '2025-08-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.887176', 126, 1),
(123, '900000', '2025-07-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.889192', 127, 1),
(124, '50000', '2025-07-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.891707', 128, 1),
(125, '100000', '2025-08-03 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.893722', 129, 1),
(126, '480000', '2025-07-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.896235', 130, 1),
(127, '480000', '2025-08-06 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.897745', 130, 1),
(128, '50000', '2025-07-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.899762', 131, 1),
(129, '100000', '2025-07-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.903293', 132, 1),
(130, '660000', '2025-07-17 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.905301', 133, 1),
(131, '25000', '2025-07-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.907317', 134, 1),
(132, '25000', '2025-07-31 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.908826', 134, 1),
(133, '100000', '2025-07-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.911339', 135, 1),
(134, '1080000', '2025-06-20 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.913856', 136, 1),
(135, '50000', '2025-06-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.916376', 137, 1),
(136, '100000', '2025-06-17 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.918889', 138, 1),
(137, '1080000', '2025-06-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.920903', 139, 1),
(138, '50000', '2025-06-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.923417', 140, 1),
(139, '100000', '2025-06-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.925432', 141, 1),
(140, '900000', '2025-06-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.927946', 142, 1),
(141, '50000', '2025-06-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.929966', 143, 1),
(142, '100000', '2025-06-16 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.932482', 144, 1),
(143, '960000', '2025-06-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.935501', 145, 1),
(144, '50000', '2025-06-27 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.937521', 146, 1),
(145, '100000', '2025-06-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.940416', 147, 1),
(146, '330000', '2025-06-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.942429', 148, 1),
(147, '330000', '2025-06-25 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.943938', 148, 1),
(148, '50000', '2025-06-27 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.946964', 149, 1),
(149, '50000', '2025-06-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.949989', 150, 1),
(150, '50000', '2025-06-23 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.950994', 150, 1),
(151, '1080000', '2025-05-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.954019', 151, 1),
(152, '50000', '2025-06-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.956032', 152, 1),
(153, '100000', '2025-05-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.958546', 153, 1),
(154, '1080000', '2025-05-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.960562', 154, 1),
(155, '50000', '2025-05-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.963076', 155, 1),
(156, '900000', '2025-05-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.967111', 157, 1),
(157, '50000', '2025-05-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.969627', 158, 1),
(158, '50000', '2025-05-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.972141', 159, 1),
(159, '50000', '2025-06-08 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.973659', 159, 1),
(160, '960000', '2025-05-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.975664', 160, 1),
(161, '50000', '2025-05-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.978187', 161, 1),
(162, '100000', '2025-05-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.980200', 162, 1),
(163, '50000', '2025-05-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.984226', 164, 1),
(164, '50000', '2025-05-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.986240', 165, 1),
(165, '50000', '2025-05-22 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.987749', 165, 1),
(166, '1080000', '2025-05-02 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.990262', 166, 1),
(167, '50000', '2025-04-25 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:27.992279', 167, 1),
(168, '100000', '2025-04-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.994794', 168, 1),
(169, '1080000', '2025-04-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:27.996807', 169, 1),
(170, '50000', '2025-04-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.001337', 171, 1),
(171, '50000', '2025-05-05 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.002341', 171, 1),
(172, '900000', '2025-05-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.004366', 172, 1),
(173, '25000', '2025-04-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.007383', 173, 1),
(174, '25000', '2025-05-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.008893', 173, 1),
(175, '100000', '2025-04-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.010403', 174, 1),
(176, '960000', '2025-04-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.013421', 175, 1),
(177, '50000', '2025-04-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.023870', 176, 1),
(178, '50000', '2025-04-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.027392', 177, 1),
(179, '50000', '2025-05-04 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.028905', 177, 1),
(180, '660000', '2025-04-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.031420', 178, 1),
(181, '25000', '2025-04-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.033936', 179, 1),
(182, '25000', '2025-04-26 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.034945', 179, 1),
(183, '100000', '2025-04-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.037460', 180, 1),
(184, '540000', '2025-03-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.040481', 181, 1),
(185, '540000', '2025-04-03 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.041989', 181, 1),
(186, '50000', '2025-04-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.045006', 182, 1),
(187, '100000', '2025-03-19 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.048025', 183, 1),
(188, '1080000', '2025-04-01 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.050041', 184, 1),
(189, '50000', '2025-03-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.053051', 185, 1),
(190, '50000', '2025-03-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.054561', 186, 1),
(191, '50000', '2025-03-25 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.057085', 186, 1),
(192, '450000', '2025-03-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.060104', 187, 1),
(193, '450000', '2025-03-28 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.060609', 187, 1),
(194, '50000', '2025-03-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.063629', 188, 1),
(195, '100000', '2025-03-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.066147', 189, 1),
(196, '480000', '2025-03-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.069193', 190, 1),
(197, '480000', '2025-03-22 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.070703', 190, 1),
(198, '50000', '2025-03-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.073731', 191, 1),
(199, '100000', '2025-03-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.075741', 192, 1),
(200, '660000', '2025-03-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.078760', 193, 1),
(201, '50000', '2025-03-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.080269', 194, 1),
(202, '100000', '2025-03-16 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.083290', 195, 1),
(203, '1080000', '2025-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.084801', 196, 1),
(204, '25000', '2025-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.087820', 197, 1),
(205, '25000', '2025-03-07 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.089330', 197, 1),
(206, '100000', '2025-02-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.092353', 198, 1),
(207, '1080000', '2025-02-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.094868', 199, 1),
(208, '50000', '2025-02-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.097887', 200, 1),
(209, '100000', '2025-02-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.099903', 201, 1),
(210, '900000', '2025-02-28 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.102414', 202, 1),
(211, '50000', '2025-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.104430', 203, 1),
(212, '100000', '2025-02-26 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.114495', 204, 1),
(213, '960000', '2025-02-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.117514', 205, 1),
(214, '25000', '2025-02-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.119530', 206, 1),
(215, '25000', '2025-03-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.121040', 206, 1),
(216, '660000', '2025-02-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.125571', 208, 1),
(217, '50000', '2025-02-18 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.127582', 209, 1),
(218, '100000', '2025-02-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.130092', 210, 1),
(219, '1080000', '2025-01-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.131600', 211, 1),
(220, '50000', '2025-01-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.134866', 212, 1),
(221, '100000', '2025-01-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.137387', 213, 1),
(222, '1080000', '2025-01-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.139405', 214, 1),
(223, '50000', '2025-01-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.142424', 215, 1),
(224, '900000', '2025-01-17 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.145443', 217, 1),
(225, '25000', '2025-01-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.149467', 218, 1),
(226, '25000', '2025-01-24 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.149972', 218, 1),
(227, '100000', '2025-01-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.152485', 219, 1),
(228, '960000', '2025-01-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.154514', 220, 1),
(229, '25000', '2025-01-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.157532', 221, 1),
(230, '25000', '2025-01-31 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.159040', 221, 1),
(231, '100000', '2025-01-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.161556', 222, 1),
(232, '660000', '2025-01-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.163570', 223, 1),
(233, '50000', '2025-01-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.166090', 224, 1),
(234, '50000', '2024-12-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.171128', 227, 1),
(235, '100000', '2024-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.173144', 228, 1),
(236, '1080000', '2024-12-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.175153', 229, 1),
(237, '50000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.177165', 230, 1),
(238, '100000', '2024-12-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.179679', 231, 1),
(239, '900000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.181692', 232, 1),
(240, '50000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.184215', 233, 1),
(241, '100000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.186224', 234, 1),
(242, '960000', '2024-12-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.187734', 235, 1),
(243, '50000', '2024-12-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.190750', 236, 1),
(244, '100000', '2024-12-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.192258', 237, 1),
(245, '660000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.194772', 238, 1),
(246, '50000', '2024-12-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.196786', 239, 1),
(247, '100000', '2024-12-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.199809', 240, 1),
(248, '1080000', '2024-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.202322', 241, 1),
(249, '50000', '2024-11-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.204341', 242, 1),
(250, '50000', '2024-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.206857', 243, 1),
(251, '50000', '2024-11-29 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.208366', 243, 1),
(252, '1080000', '2024-11-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.210381', 244, 1),
(253, '50000', '2024-11-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.212892', 245, 1),
(254, '100000', '2024-11-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.214909', 246, 1),
(255, '450000', '2024-11-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.217924', 247, 1),
(256, '450000', '2024-11-19 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.219435', 247, 1),
(257, '50000', '2024-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.220945', 248, 1),
(258, '960000', '2024-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.224963', 250, 1),
(259, '50000', '2024-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.226977', 251, 1),
(260, '50000', '2024-11-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.229489', 252, 1),
(261, '50000', '2024-11-26 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.229994', 252, 1),
(262, '660000', '2024-11-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.232506', 253, 1),
(263, '50000', '2024-11-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.234522', 254, 1),
(264, '100000', '2024-12-04 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.237540', 255, 1),
(265, '50000', '2024-10-31 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.240556', 257, 1),
(266, '100000', '2024-10-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.242065', 258, 1),
(267, '1080000', '2024-10-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.245084', 259, 1),
(268, '50000', '2024-10-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.248118', 260, 1),
(269, '100000', '2024-10-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.251135', 261, 1),
(270, '900000', '2024-10-19 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.253645', 262, 1),
(271, '50000', '2024-10-10 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.255666', 263, 1),
(272, '100000', '2024-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.258686', 264, 1),
(273, '960000', '2024-10-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.261707', 265, 1),
(274, '25000', '2024-10-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.263717', 266, 1),
(275, '25000', '2024-10-27 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.264726', 266, 1),
(276, '50000', '2024-10-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.267745', 267, 1),
(277, '50000', '2024-10-21 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.269252', 267, 1),
(278, '660000', '2024-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.271766', 268, 1),
(279, '50000', '2024-10-12 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.273781', 269, 1),
(280, '100000', '2024-10-23 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.276799', 270, 1),
(281, '1080000', '2024-09-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.279816', 271, 1),
(282, '50000', '2024-09-11 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.282327', 272, 1),
(283, '100000', '2024-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.285858', 273, 1),
(284, '1080000', '2024-09-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.291380', 274, 1),
(285, '25000', '2024-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.294889', 275, 1),
(286, '25000', '2024-09-30 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.297397', 275, 1),
(287, '100000', '2024-09-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.301414', 276, 1),
(288, '900000', '2024-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.304934', 277, 1),
(289, '50000', '2024-09-14 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.308767', 278, 1),
(290, '50000', '2024-09-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.313296', 279, 1),
(291, '50000', '2024-09-26 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.314897', 279, 1),
(292, '960000', '2024-09-26 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.317973', 280, 1),
(293, '50000', '2024-09-28 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.320994', 281, 1),
(294, '660000', '2024-09-22 17:00:00.000000', 'TRANSFER', NULL, NULL, '', '2026-03-15 16:09:28.325662', 283, 1),
(295, '25000', '2024-09-13 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.328682', 284, 1),
(296, '25000', '2024-10-02 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.330191', 284, 1),
(297, '100000', '2024-09-09 17:00:00.000000', 'CASH', NULL, NULL, '', '2026-03-15 16:09:28.332703', 285, 1),
(298, '50000', '2026-03-15 16:20:05.238936', 'TRANSFER', 'GD001', 'aaaaaa', '', '2026-03-15 16:20:05.239940', 2, 1),
(299, '100000', '2026-03-15 16:20:49.060388', 'MOMO', 'GD-001', '', '', '2026-03-15 16:20:49.060891', 15, 1),
(300, '1', '2026-03-15 16:27:52.676999', 'CASH', 'GD-300', NULL, '', '2026-03-15 16:27:52.677509', 285, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_request`
--

CREATE TABLE `maintenance_request` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `category` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_at` datetime(6) DEFAULT NULL,
  `resolved_at` datetime(6) DEFAULT NULL,
  `resolution_note` longtext COLLATE utf8mb4_unicode_ci,
  `estimated_cost` decimal(12,0) DEFAULT NULL,
  `actual_cost` decimal(12,0) DEFAULT NULL,
  `apartment_id` bigint NOT NULL,
  `assigned_to_id` bigint DEFAULT NULL,
  `resident_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `maintenance_request`
--

INSERT INTO `maintenance_request` (`id`, `created_at`, `updated_at`, `deleted_at`, `category`, `title`, `description`, `priority`, `status`, `image`, `assigned_at`, `resolved_at`, `resolution_note`, `estimated_cost`, `actual_cost`, `apartment_id`, `assigned_to_id`, `resident_id`) VALUES
(1, '2026-03-15 13:52:19.946929', '2026-03-15 13:52:19.946929', NULL, 'HVAC', 'Máy lạnh không mát', 'Máy lạnh chạy nhưng không mát.', 'URGENT', 'ASSIGNED', 'maintenance/2024/01/issue_electric.jpg', '2026-03-15 13:52:19.949550', NULL, NULL, NULL, NULL, 1, 2, 5),
(2, '2026-03-15 13:52:19.952173', '2026-03-15 13:52:19.952173', NULL, 'PLUMBING', 'Rò rỉ nước dưới bồn rửa', 'Nước rò nhẹ dưới bồn rửa, cần xử lý sớm.', 'LOW', 'PENDING', 'maintenance/2024/01/issue_water.jpg', NULL, NULL, NULL, NULL, NULL, 2, NULL, 3),
(3, '2026-03-15 13:52:19.955725', '2026-03-15 13:52:19.955725', NULL, 'HVAC', 'Máy lạnh không mát', 'Máy lạnh chạy nhưng không mát.', 'LOW', 'ASSIGNED', 'maintenance/2024/01/issue_hvac.jpg', '2026-03-15 13:52:19.958243', NULL, NULL, NULL, NULL, 3, 2, 1),
(4, '2026-03-15 13:52:19.961773', '2026-03-15 13:52:19.961773', NULL, 'ELECTRIC', 'Đèn hành lang bị chập', 'Đèn hành lang tầng 2 chập chờn, cần kiểm tra.', 'MEDIUM', 'PENDING', 'maintenance/2024/01/issue_electric.jpg', NULL, NULL, NULL, NULL, NULL, 4, NULL, 4),
(5, '2026-03-15 13:52:19.963289', '2026-03-15 13:52:19.963289', NULL, 'ELECTRIC', 'Đèn hành lang bị chập', 'Đèn hành lang tầng 2 chập chờn, cần kiểm tra.', 'LOW', 'ASSIGNED', 'maintenance/2024/01/issue_water.jpg', '2026-03-15 13:52:19.965126', NULL, NULL, NULL, NULL, 21, 2, 2),
(6, '2026-03-15 13:52:19.968148', '2026-03-15 13:52:19.968148', NULL, 'ELECTRIC', 'Đèn hành lang bị chập', 'Đèn hành lang tầng 2 chập chờn, cần kiểm tra.', 'URGENT', 'PENDING', 'maintenance/2024/01/issue_hvac.jpg', NULL, NULL, NULL, NULL, NULL, 22, NULL, 5),
(7, '2026-03-15 13:52:19.971177', '2026-03-15 13:52:19.971177', NULL, 'ELECTRIC', 'Đèn hành lang bị chập', 'Đèn hành lang tầng 2 chập chờn, cần kiểm tra.', 'MEDIUM', 'ASSIGNED', 'maintenance/2024/01/issue_electric.jpg', '2026-03-15 13:52:19.974735', NULL, NULL, NULL, NULL, 23, 2, 3),
(8, '2026-03-15 13:52:19.978275', '2026-03-15 13:52:19.978275', NULL, 'PLUMBING', 'Rò rỉ nước dưới bồn rửa', 'Nước rò nhẹ dưới bồn rửa, cần xử lý sớm.', 'URGENT', 'PENDING', 'maintenance/2024/01/issue_water.jpg', NULL, NULL, NULL, NULL, NULL, 5, NULL, 1),
(9, '2026-03-15 13:52:19.981303', '2026-03-15 13:52:19.981303', NULL, 'HVAC', 'Máy lạnh không mát', 'Máy lạnh chạy nhưng không mát.', 'HIGH', 'ASSIGNED', 'maintenance/2024/01/issue_hvac.jpg', '2026-03-15 13:52:19.984329', NULL, NULL, NULL, NULL, 6, 2, 4),
(10, '2026-03-15 13:52:19.987354', '2026-03-15 13:52:19.987354', NULL, 'ELECTRIC', 'Đèn hành lang bị chập', 'Đèn hành lang tầng 2 chập chờn, cần kiểm tra.', 'HIGH', 'PENDING', 'maintenance/2024/01/issue_electric.jpg', NULL, NULL, NULL, NULL, NULL, 7, NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `residents_contract`
--

CREATE TABLE `residents_contract` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `rent_amount` decimal(12,0) NOT NULL,
  `deposit` decimal(12,0) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contract_file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `apartment_id` bigint NOT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `resident_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `residents_contract`
--

INSERT INTO `residents_contract` (`id`, `created_at`, `updated_at`, `deleted_at`, `start_date`, `end_date`, `rent_amount`, `deposit`, `status`, `contract_file`, `note`, `apartment_id`, `created_by_id`, `resident_id`) VALUES
(1, '2026-03-15 13:52:19.833103', '2026-03-15 13:52:19.833103', NULL, '2025-09-12', '2026-09-12', '15000000', '30000000', 'ACTIVE', '', NULL, 12, 1, 1),
(2, '2026-03-15 13:52:19.840304', '2026-03-15 13:52:19.840304', NULL, '2025-07-29', '2026-07-29', '8000000', '16000000', 'ACTIVE', '', NULL, 26, 1, 2),
(3, '2026-03-15 13:52:19.846339', '2026-03-15 13:52:19.846339', NULL, '2025-08-30', '2026-08-30', '12000000', '24000000', 'ACTIVE', '', NULL, 19, 1, 3),
(4, '2026-03-15 13:52:19.852364', '2026-03-15 13:52:19.852364', NULL, '2025-11-03', '2026-11-03', '14000000', '28000000', 'ACTIVE', '', NULL, 22, 1, 4),
(5, '2026-03-15 13:52:19.860022', '2026-03-15 13:52:19.860022', NULL, '2025-11-03', '2026-11-03', '15000000', '30000000', 'ACTIVE', '', NULL, 16, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `residents_resident`
--

CREATE TABLE `residents_resident` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hometown` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` longtext COLLATE utf8mb4_unicode_ci,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `residents_resident`
--

INSERT INTO `residents_resident` (`id`, `created_at`, `updated_at`, `deleted_at`, `full_name`, `id_number`, `phone`, `email`, `date_of_birth`, `gender`, `hometown`, `permanent_address`, `avatar`, `emergency_contact_name`, `emergency_contact_phone`, `note`) VALUES
(1, '2026-03-15 13:52:19.829500', '2026-03-15 13:52:19.829500', NULL, 'Nguyễn Văn Anh', '001234567890', '0901111111', 'nguyenvananh@gmail.com', '1990-03-15', 'M', 'Hà Nội', NULL, 'residents/2024/01/resident_1.jpg', 'Liên hệ khẩn - Nguyễn Văn Anh', '0949985563', NULL),
(2, '2026-03-15 13:52:19.837292', '2026-03-15 13:52:19.837292', NULL, 'Trần Thị Bích', '002345678901', '0902222222', 'tranthibich@gmail.com', '1988-07-22', 'F', 'TP.HCM', NULL, 'residents/2024/01/resident_2.jpg', 'Liên hệ khẩn - Trần Thị Bích', '0978531242', NULL),
(3, '2026-03-15 13:52:19.843824', '2026-03-15 13:52:19.843824', NULL, 'Lê Văn Cường', '003456789012', '0903333333', 'levancuong@gmail.com', '1992-01-08', 'M', 'Đà Nẵng', NULL, 'residents/2024/01/resident_3.jpg', 'Liên hệ khẩn - Lê Văn Cường', '0996805827', NULL),
(4, '2026-03-15 13:52:19.850355', '2026-03-15 13:52:19.850355', NULL, 'Phạm Thị Dung', '004567890123', '0904444444', 'phamthidung@gmail.com', '1995-11-30', 'F', 'Cần Thơ', NULL, 'residents/2024/01/resident_4.jpg', 'Liên hệ khẩn - Phạm Thị Dung', '0938510236', NULL),
(5, '2026-03-15 13:52:19.857009', '2026-03-15 13:52:19.857009', NULL, 'Hoàng Văn Em', '005678901234', '0905555555', 'hoangvanem@gmail.com', '1987-05-19', 'M', 'Huế', NULL, 'residents/2024/01/resident_5.jpg', 'Liên hệ khẩn - Hoàng Văn Em', '0916000166', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_parkingslot`
--

CREATE TABLE `vehicles_parkingslot` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slot_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slot_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monthly_fee` decimal(10,0) NOT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles_parkingslot`
--

INSERT INTO `vehicles_parkingslot` (`id`, `created_at`, `updated_at`, `deleted_at`, `slot_number`, `slot_type`, `floor`, `status`, `monthly_fee`, `note`) VALUES
(1, '2026-03-15 13:52:19.992896', '2026-03-15 13:52:19.992896', NULL, 'A001', 'MOTORBIKE', NULL, 'OCCUPIED', '150000', NULL),
(2, '2026-03-15 13:52:19.995016', '2026-03-15 13:52:19.995016', NULL, 'A002', 'MOTORBIKE', NULL, 'OCCUPIED', '150000', NULL),
(3, '2026-03-15 13:52:19.997041', '2026-03-15 13:52:19.997041', NULL, 'A003', 'MOTORBIKE', NULL, 'OCCUPIED', '150000', NULL),
(4, '2026-03-15 13:52:19.998782', '2026-03-15 13:52:19.998782', NULL, 'A004', 'MOTORBIKE', NULL, 'OCCUPIED', '150000', NULL),
(5, '2026-03-15 13:52:20.001342', '2026-03-15 13:52:20.001342', NULL, 'A005', 'MOTORBIKE', NULL, 'OCCUPIED', '150000', NULL),
(6, '2026-03-15 13:52:20.003866', '2026-03-15 13:52:20.003866', NULL, 'A006', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(7, '2026-03-15 13:52:20.005818', '2026-03-15 13:52:20.005818', NULL, 'A007', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(8, '2026-03-15 13:52:20.007931', '2026-03-15 13:52:20.007931', NULL, 'A008', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(9, '2026-03-15 13:52:20.009948', '2026-03-15 13:52:20.009948', NULL, 'A009', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(10, '2026-03-15 13:52:20.011457', '2026-03-15 13:52:20.011457', NULL, 'A010', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(11, '2026-03-15 13:52:20.014499', '2026-03-15 13:52:20.014499', NULL, 'A011', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(12, '2026-03-15 13:52:20.017018', '2026-03-15 13:52:20.017018', NULL, 'A012', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(13, '2026-03-15 13:52:20.019032', '2026-03-15 13:52:20.019032', NULL, 'A013', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(14, '2026-03-15 13:52:20.021546', '2026-03-15 13:52:20.021546', NULL, 'A014', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(15, '2026-03-15 13:52:20.024576', '2026-03-15 13:52:20.024576', NULL, 'A015', 'MOTORBIKE', NULL, 'AVAILABLE', '150000', NULL),
(16, '2026-03-15 13:52:20.026590', '2026-03-15 13:52:20.026590', NULL, 'A016', 'CAR', NULL, 'AVAILABLE', '1200000', NULL),
(17, '2026-03-15 13:52:20.029608', '2026-03-15 13:52:20.029608', NULL, 'A017', 'CAR', NULL, 'AVAILABLE', '1200000', NULL),
(18, '2026-03-15 13:52:20.032124', '2026-03-15 13:52:20.032124', NULL, 'A018', 'CAR', NULL, 'AVAILABLE', '1200000', NULL),
(19, '2026-03-15 13:52:20.034149', '2026-03-15 13:52:20.034149', NULL, 'A019', 'CAR', NULL, 'AVAILABLE', '1200000', NULL),
(20, '2026-03-15 13:52:20.037096', '2026-03-15 13:52:20.037096', NULL, 'A020', 'CAR', NULL, 'AVAILABLE', '1200000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_vehicle`
--

CREATE TABLE `vehicles_vehicle` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `vehicle_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `license_plate` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registered_date` date NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `apartment_id` bigint NOT NULL,
  `parking_slot_id` bigint DEFAULT NULL,
  `resident_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles_vehicle`
--

INSERT INTO `vehicles_vehicle` (`id`, `created_at`, `updated_at`, `deleted_at`, `vehicle_type`, `license_plate`, `brand`, `model`, `color`, `card_number`, `registered_date`, `image`, `note`, `apartment_id`, `parking_slot_id`, `resident_id`) VALUES
(1, '2026-03-15 13:52:20.041626', '2026-03-15 13:52:20.041626', NULL, 'MOTORBIKE', '59A-30993', NULL, NULL, NULL, 'CARD-736292', '2026-03-15', '', NULL, 22, 1, 4),
(2, '2026-03-15 13:52:20.045666', '2026-03-15 13:52:20.045666', NULL, 'MOTORBIKE', '59A-51435', NULL, NULL, NULL, 'CARD-929840', '2026-03-15', '', NULL, 16, 2, 5),
(3, '2026-03-15 13:52:20.049190', '2026-03-15 13:52:20.049190', NULL, 'MOTORBIKE', '59A-37943', NULL, NULL, NULL, 'CARD-118493', '2026-03-15', '', NULL, 12, 3, 1),
(4, '2026-03-15 13:52:20.053717', '2026-03-15 13:52:20.053717', NULL, 'MOTORBIKE', '59A-41151', NULL, NULL, NULL, 'CARD-972764', '2026-03-15', '', NULL, 19, 4, 3),
(5, '2026-03-15 13:52:20.057485', '2026-03-15 13:52:20.057485', NULL, 'MOTORBIKE', '59A-58392', NULL, NULL, NULL, 'CARD-835732', '2026-03-15', '', NULL, 26, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `visitors_visitor`
--

CREATE TABLE `visitors_visitor` (
  `id` bigint NOT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purpose` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `check_in` datetime(6) NOT NULL,
  `check_out` datetime(6) DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `registered_by_id` bigint DEFAULT NULL,
  `resident_id` bigint DEFAULT NULL,
  `visit_apartment_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitors_visitor`
--

INSERT INTO `visitors_visitor` (`id`, `full_name`, `id_number`, `phone`, `purpose`, `check_in`, `check_out`, `note`, `registered_by_id`, `resident_id`, `visit_apartment_id`) VALUES
(1, 'Phạm An 71', '461225400112', '0998310116', 'Thăm cư dân', '2026-03-15 13:52:20.081163', NULL, NULL, 2, 5, 1),
(2, 'Trần Hương 57', '268300878406', '0933420756', 'Thăm cư dân', '2026-03-15 13:52:20.083689', NULL, NULL, 2, 3, 2),
(3, 'Phạm An 16', '214573250006', '0942892345', 'Thăm cư dân', '2026-03-15 13:52:20.085600', NULL, NULL, 2, 1, 3),
(4, 'Trần Hương 85', '629785033869', '0929896479', 'Thăm cư dân', '2026-03-15 13:52:20.087653', NULL, NULL, 2, 4, 4),
(5, 'Lê Quốc 57', '102395987553', '0929067952', 'Thăm cư dân', '2026-03-15 13:52:20.089159', NULL, NULL, 2, 2, 21),
(6, 'Hoàng Vy 16', '501448741263', '0924436787', 'Thăm cư dân', '2026-03-15 13:52:20.091218', NULL, NULL, 2, 5, 22),
(7, 'Trần Hương 21', '130128867074', '0939760773', 'Thăm cư dân', '2026-03-15 13:52:20.092817', NULL, NULL, 2, 3, 23),
(8, 'Hoàng Vy 46', '983801090852', '0919650961', 'Thăm cư dân', '2026-03-15 13:52:20.094333', NULL, NULL, 2, 1, 5),
(9, 'Trần Hương 56', '341773104721', '0946720188', 'Thăm cư dân', '2026-03-15 13:52:20.096352', NULL, NULL, 2, 4, 6),
(10, 'Hoàng Vy 55', '606492458104', '0953187493', 'Thăm cư dân', '2026-03-15 13:52:20.097867', NULL, NULL, 2, 2, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_user`
--
ALTER TABLE `accounts_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `accounts_user_deleted_at_88c9c1f6` (`deleted_at`);

--
-- Indexes for table `accounts_userprofile`
--
ALTER TABLE `accounts_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `accounts_user_groups`
--
ALTER TABLE `accounts_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  ADD KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `accounts_user_user_permissions`
--
ALTER TABLE `accounts_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  ADD KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `announcements_announcement`
--
ALTER TABLE `announcements_announcement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `announcements_announ_created_by_id_79d7d337_fk_accounts_` (`created_by_id`),
  ADD KEY `announcements_announcement_deleted_at_fd6cd87f` (`deleted_at`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `buildings_apartment`
--
ALTER TABLE `buildings_apartment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `buildings_apartment_floor_id_apartment_number_fcc8d53a_uniq` (`floor_id`,`apartment_number`),
  ADD KEY `buildings_apartment_deleted_at_7794673a` (`deleted_at`);

--
-- Indexes for table `buildings_building`
--
ALTER TABLE `buildings_building`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buildings_building_manager_id_25089bb7_fk_accounts_user_id` (`manager_id`),
  ADD KEY `buildings_building_deleted_at_7d148a81` (`deleted_at`);

--
-- Indexes for table `buildings_floor`
--
ALTER TABLE `buildings_floor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `buildings_floor_building_id_floor_number_8d827934_uniq` (`building_id`,`floor_number`),
  ADD KEY `buildings_floor_deleted_at_9481e76f` (`deleted_at`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_accounts_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `fees_feetype`
--
ALTER TABLE `fees_feetype`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_feetype_deleted_at_d3178b8e` (`deleted_at`);

--
-- Indexes for table `fees_invoice`
--
ALTER TABLE `fees_invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fees_invoice_fee_type_id_apartment_id_month_year_9a095c5e_uniq` (`fee_type_id`,`apartment_id`,`month`,`year`),
  ADD KEY `fees_invoice_apartment_id_ba38c856_fk_buildings_apartment_id` (`apartment_id`),
  ADD KEY `fees_invoice_created_by_id_e087a26e_fk_accounts_user_id` (`created_by_id`),
  ADD KEY `fees_invoice_resident_id_0a876aad_fk_residents_resident_id` (`resident_id`),
  ADD KEY `fees_invoice_deleted_at_7df852cd` (`deleted_at`);

--
-- Indexes for table `fees_payment`
--
ALTER TABLE `fees_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_payment_invoice_id_5cbba1db_fk_fees_invoice_id` (`invoice_id`),
  ADD KEY `fees_payment_received_by_id_2e7738bf_fk_accounts_user_id` (`received_by_id`);

--
-- Indexes for table `maintenance_request`
--
ALTER TABLE `maintenance_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `maintenance_request_apartment_id_1fcafcc3_fk_buildings` (`apartment_id`),
  ADD KEY `maintenance_request_assigned_to_id_e40ceec1_fk_accounts_user_id` (`assigned_to_id`),
  ADD KEY `maintenance_request_resident_id_e98b6447_fk_residents` (`resident_id`),
  ADD KEY `maintenance_request_deleted_at_6d6b1cf0` (`deleted_at`);

--
-- Indexes for table `residents_contract`
--
ALTER TABLE `residents_contract`
  ADD PRIMARY KEY (`id`),
  ADD KEY `residents_contract_apartment_id_54f40290_fk_buildings` (`apartment_id`),
  ADD KEY `residents_contract_created_by_id_56e9513d_fk_accounts_user_id` (`created_by_id`),
  ADD KEY `residents_contract_resident_id_4d872e48_fk_residents_resident_id` (`resident_id`),
  ADD KEY `residents_contract_deleted_at_c826e75a` (`deleted_at`);

--
-- Indexes for table `residents_resident`
--
ALTER TABLE `residents_resident`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD KEY `residents_resident_deleted_at_c519b212` (`deleted_at`);

--
-- Indexes for table `vehicles_parkingslot`
--
ALTER TABLE `vehicles_parkingslot`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slot_number` (`slot_number`),
  ADD KEY `vehicles_parkingslot_deleted_at_d839f223` (`deleted_at`);

--
-- Indexes for table `vehicles_vehicle`
--
ALTER TABLE `vehicles_vehicle`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_plate` (`license_plate`),
  ADD KEY `vehicles_vehicle_apartment_id_6a4f4710_fk_buildings_apartment_id` (`apartment_id`),
  ADD KEY `vehicles_vehicle_parking_slot_id_b4ab5d72_fk_vehicles_` (`parking_slot_id`),
  ADD KEY `vehicles_vehicle_resident_id_c84877bf_fk_residents_resident_id` (`resident_id`),
  ADD KEY `vehicles_vehicle_deleted_at_7126d040` (`deleted_at`);

--
-- Indexes for table `visitors_visitor`
--
ALTER TABLE `visitors_visitor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visitors_visitor_registered_by_id_cb91d37d_fk_accounts_user_id` (`registered_by_id`),
  ADD KEY `visitors_visitor_resident_id_91b2c624_fk_residents_resident_id` (`resident_id`),
  ADD KEY `visitors_visitor_visit_apartment_id_eaf24364_fk_buildings` (`visit_apartment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_user`
--
ALTER TABLE `accounts_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `accounts_userprofile`
--
ALTER TABLE `accounts_userprofile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `accounts_user_groups`
--
ALTER TABLE `accounts_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accounts_user_user_permissions`
--
ALTER TABLE `accounts_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements_announcement`
--
ALTER TABLE `announcements_announcement`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `buildings_apartment`
--
ALTER TABLE `buildings_apartment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buildings_building`
--
ALTER TABLE `buildings_building`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buildings_floor`
--
ALTER TABLE `buildings_floor`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `fees_feetype`
--
ALTER TABLE `fees_feetype`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `fees_invoice`
--
ALTER TABLE `fees_invoice`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_payment`
--
ALTER TABLE `fees_payment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `maintenance_request`
--
ALTER TABLE `maintenance_request`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `residents_contract`
--
ALTER TABLE `residents_contract`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `residents_resident`
--
ALTER TABLE `residents_resident`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicles_parkingslot`
--
ALTER TABLE `vehicles_parkingslot`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `vehicles_vehicle`
--
ALTER TABLE `vehicles_vehicle`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `visitors_visitor`
--
ALTER TABLE `visitors_visitor`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_userprofile`
--
ALTER TABLE `accounts_userprofile`
  ADD CONSTRAINT `accounts_userprofile_user_id_92240672_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `accounts_user_groups`
--
ALTER TABLE `accounts_user_groups`
  ADD CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `accounts_user_user_permissions`
--
ALTER TABLE `accounts_user_user_permissions`
  ADD CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `announcements_announcement`
--
ALTER TABLE `announcements_announcement`
  ADD CONSTRAINT `announcements_announ_created_by_id_79d7d337_fk_accounts_` FOREIGN KEY (`created_by_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `buildings_apartment`
--
ALTER TABLE `buildings_apartment`
  ADD CONSTRAINT `buildings_apartment_floor_id_51182d70_fk_buildings_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `buildings_floor` (`id`);

--
-- Constraints for table `buildings_building`
--
ALTER TABLE `buildings_building`
  ADD CONSTRAINT `buildings_building_manager_id_25089bb7_fk_accounts_user_id` FOREIGN KEY (`manager_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `buildings_floor`
--
ALTER TABLE `buildings_floor`
  ADD CONSTRAINT `buildings_floor_building_id_99485646_fk_buildings_building_id` FOREIGN KEY (`building_id`) REFERENCES `buildings_building` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `fees_invoice`
--
ALTER TABLE `fees_invoice`
  ADD CONSTRAINT `fees_invoice_apartment_id_ba38c856_fk_buildings_apartment_id` FOREIGN KEY (`apartment_id`) REFERENCES `buildings_apartment` (`id`),
  ADD CONSTRAINT `fees_invoice_created_by_id_e087a26e_fk_accounts_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `accounts_user` (`id`),
  ADD CONSTRAINT `fees_invoice_fee_type_id_557a1088_fk_fees_feetype_id` FOREIGN KEY (`fee_type_id`) REFERENCES `fees_feetype` (`id`),
  ADD CONSTRAINT `fees_invoice_resident_id_0a876aad_fk_residents_resident_id` FOREIGN KEY (`resident_id`) REFERENCES `residents_resident` (`id`);

--
-- Constraints for table `fees_payment`
--
ALTER TABLE `fees_payment`
  ADD CONSTRAINT `fees_payment_invoice_id_5cbba1db_fk_fees_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `fees_invoice` (`id`),
  ADD CONSTRAINT `fees_payment_received_by_id_2e7738bf_fk_accounts_user_id` FOREIGN KEY (`received_by_id`) REFERENCES `accounts_user` (`id`);

--
-- Constraints for table `maintenance_request`
--
ALTER TABLE `maintenance_request`
  ADD CONSTRAINT `maintenance_request_apartment_id_1fcafcc3_fk_buildings` FOREIGN KEY (`apartment_id`) REFERENCES `buildings_apartment` (`id`),
  ADD CONSTRAINT `maintenance_request_assigned_to_id_e40ceec1_fk_accounts_user_id` FOREIGN KEY (`assigned_to_id`) REFERENCES `accounts_user` (`id`),
  ADD CONSTRAINT `maintenance_request_resident_id_e98b6447_fk_residents` FOREIGN KEY (`resident_id`) REFERENCES `residents_resident` (`id`);

--
-- Constraints for table `residents_contract`
--
ALTER TABLE `residents_contract`
  ADD CONSTRAINT `residents_contract_apartment_id_54f40290_fk_buildings` FOREIGN KEY (`apartment_id`) REFERENCES `buildings_apartment` (`id`),
  ADD CONSTRAINT `residents_contract_created_by_id_56e9513d_fk_accounts_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `accounts_user` (`id`),
  ADD CONSTRAINT `residents_contract_resident_id_4d872e48_fk_residents_resident_id` FOREIGN KEY (`resident_id`) REFERENCES `residents_resident` (`id`);

--
-- Constraints for table `vehicles_vehicle`
--
ALTER TABLE `vehicles_vehicle`
  ADD CONSTRAINT `vehicles_vehicle_apartment_id_6a4f4710_fk_buildings_apartment_id` FOREIGN KEY (`apartment_id`) REFERENCES `buildings_apartment` (`id`),
  ADD CONSTRAINT `vehicles_vehicle_parking_slot_id_b4ab5d72_fk_vehicles_` FOREIGN KEY (`parking_slot_id`) REFERENCES `vehicles_parkingslot` (`id`),
  ADD CONSTRAINT `vehicles_vehicle_resident_id_c84877bf_fk_residents_resident_id` FOREIGN KEY (`resident_id`) REFERENCES `residents_resident` (`id`);

--
-- Constraints for table `visitors_visitor`
--
ALTER TABLE `visitors_visitor`
  ADD CONSTRAINT `visitors_visitor_registered_by_id_cb91d37d_fk_accounts_user_id` FOREIGN KEY (`registered_by_id`) REFERENCES `accounts_user` (`id`),
  ADD CONSTRAINT `visitors_visitor_resident_id_91b2c624_fk_residents_resident_id` FOREIGN KEY (`resident_id`) REFERENCES `residents_resident` (`id`),
  ADD CONSTRAINT `visitors_visitor_visit_apartment_id_eaf24364_fk_buildings` FOREIGN KEY (`visit_apartment_id`) REFERENCES `buildings_apartment` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
