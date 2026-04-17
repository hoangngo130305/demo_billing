-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2026 at 02:55 AM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `billing`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add payment', 7, 'add_payment'),
(26, 'Can change payment', 7, 'change_payment'),
(27, 'Can delete payment', 7, 'delete_payment'),
(28, 'Can view payment', 7, 'view_payment'),
(29, 'Can add transaction', 10, 'add_transaction'),
(30, 'Can change transaction', 10, 'change_transaction'),
(31, 'Can delete transaction', 10, 'delete_transaction'),
(32, 'Can view transaction', 10, 'view_transaction'),
(33, 'Can add wallet balance', 11, 'add_walletbalance'),
(34, 'Can change wallet balance', 11, 'change_walletbalance'),
(35, 'Can delete wallet balance', 11, 'delete_walletbalance'),
(36, 'Can view wallet balance', 11, 'view_walletbalance'),
(37, 'Can add wallet history', 12, 'add_wallethistory'),
(38, 'Can change wallet history', 12, 'change_wallethistory'),
(39, 'Can delete wallet history', 12, 'delete_wallethistory'),
(40, 'Can view wallet history', 12, 'view_wallethistory'),
(41, 'Can add payment log', 8, 'add_paymentlog'),
(42, 'Can change payment log', 8, 'change_paymentlog'),
(43, 'Can delete payment log', 8, 'delete_paymentlog'),
(44, 'Can view payment log', 8, 'view_paymentlog'),
(45, 'Can add refund', 9, 'add_refund'),
(46, 'Can change refund', 9, 'change_refund'),
(47, 'Can delete refund', 9, 'delete_refund'),
(48, 'Can view refund', 9, 'view_refund');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1200000$TpZuiQsJOi80NC2kisqkne$tPoJUw5rJrxD+TWvJ/DpOoZI+z+58QmdSqeVdPOia3k=', NULL, 1, 'admin', '', '', '', 1, 1, '2026-04-16 03:34:21.706338');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'api', 'payment'),
(8, 'api', 'paymentlog'),
(9, 'api', 'refund'),
(10, 'api', 'transaction'),
(11, 'api', 'walletbalance'),
(12, 'api', 'wallethistory'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-04-16 03:10:08.787898'),
(2, 'auth', '0001_initial', '2026-04-16 03:10:09.003220'),
(3, 'admin', '0001_initial', '2026-04-16 03:10:09.050628'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-04-16 03:10:09.056639'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-04-16 03:10:09.062185'),
(6, 'api', '0001_initial', '2026-04-16 03:10:09.152270'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-04-16 03:10:09.193115'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-04-16 03:10:09.216473'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-04-16 03:10:09.231401'),
(10, 'auth', '0004_alter_user_username_opts', '2026-04-16 03:10:09.237274'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-04-16 03:10:09.259824'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-04-16 03:10:09.262566'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-04-16 03:10:09.268417'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-04-16 03:10:09.289862'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-04-16 03:10:09.304889'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-04-16 03:10:09.321636'),
(17, 'auth', '0011_update_proxy_permissions', '2026-04-16 03:10:09.333100'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-04-16 03:10:09.349789'),
(19, 'sessions', '0001_initial', '2026-04-16 03:10:09.366723');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `order_code` bigint(20) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `amount` bigint(20) UNSIGNED NOT NULL CHECK (`amount` >= 0),
  `currency` varchar(3) NOT NULL,
  `method` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `transaction_code` varchar(100) DEFAULT NULL,
  `payment_url` varchar(1000) DEFAULT NULL,
  `qr_code` longtext DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_code`, `user_id`, `amount`, `currency`, `method`, `status`, `transaction_code`, `payment_url`, `qr_code`, `description`, `paid_at`, `created_at`, `updated_at`) VALUES
(1, 1776310694807, 'demo_user', 50000, 'VND', 'QR', 'PENDING', NULL, 'https://pay.payos.vn/web/d5b7b6193c7d40559b447535eb0e1dce', '00020101021238570010A000000727012700069704220113VQRQAIINS52580208QRIBFTTA53037045405500005802VN62130809NAPVISEMS63045638', 'NAPVISEMS', NULL, '2026-04-16 03:38:16.179649', '2026-04-16 03:38:16.179676'),
(2, 1776310913671, 'demo_user', 50000, 'VND', 'QR', 'PENDING', NULL, 'https://pay.payos.vn/web/814b4739ca224d13ad2e9b96f303089f', '00020101021238570010A000000727012700069704220113VQRQAIINT14960208QRIBFTTA53037045405500005802VN62130809NAPVISEMS6304EAA8', 'NAPVISEMS', NULL, '2026-04-16 03:41:54.793537', '2026-04-16 03:41:54.793551'),
(3, 1776311156031, 'demo_user', 50000, 'VND', 'QR', 'SUCCESS', NULL, 'https://pay.payos.vn/web/96cd4fea44444b949ff16dca6e4b18a4', '00020101021238570010A000000727012700069704220113VQRQAIINY36760208QRIBFTTA53037045405500005802VN62130809NAPVISEMS6304BDC5', 'NAPVISEMS', '2026-04-16 03:50:31.102007', '2026-04-16 03:45:57.355254', '2026-04-16 03:50:31.102221'),
(4, 1776311689514, 'demo_user', 50000, 'VND', 'QR', 'SUCCESS', NULL, 'https://pay.payos.vn/web/eaecb31faf9646488f183f909d344dff', '00020101021238570010A000000727012700069704220113VQRQAIIOB95240208QRIBFTTA53037045405500005802VN62130809NAPVISEMS63047C6D', 'NAPVISEMS', '2026-04-16 03:55:08.423353', '2026-04-16 03:54:50.263838', '2026-04-16 03:55:08.423423'),
(5, 1776313768835, 'demo_user', 50000, 'VND', 'QR', 'SUCCESS', NULL, 'https://pay.payos.vn/web/cd55e99edcc04f71a99aba48ecb5af47', '00020101021238570010A000000727012700069704220113VQRQAIIOQ03220208QRIBFTTA53037045405500005802VN62130809NAPVISEMS6304AC29', 'NAPVISEMS', '2026-04-16 04:29:54.181233', '2026-04-16 04:29:30.032804', '2026-04-16 04:29:54.181336'),
(6, 1776313982709, 'demo_user', 50000, 'VND', 'QR', 'SUCCESS', NULL, 'https://pay.payos.vn/web/5b9d0bb2d3714e358fb1ba3b4266df6c', '00020101021238570010A000000727012700069704220113VQRQAIIOQ84740208QRIBFTTA53037045405500005802VN62130809NAPVISEMS6304563D', 'NAPVISEMS', '2026-04-16 04:33:18.567125', '2026-04-16 04:33:03.426713', '2026-04-16 04:33:18.567181');

-- --------------------------------------------------------

--
-- Table structure for table `payment_logs`
--

CREATE TABLE `payment_logs` (
  `id` bigint(20) NOT NULL,
  `order_code` bigint(20) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `raw_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_data`)),
  `status_code` varchar(20) DEFAULT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `payment_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_logs`
--

INSERT INTO `payment_logs` (`id`, `order_code`, `type`, `raw_data`, `status_code`, `ip_address`, `created_at`, `payment_id`) VALUES
(1, 1776311689514, 'SYSTEM', '{\"event\": \"BACKFILL_EXISTING_PAYMENT\", \"payment_status\": \"SUCCESS\"}', 'SUCCESS', NULL, '2026-04-16 04:28:46.962105', 4),
(2, 1776311156031, 'SYSTEM', '{\"event\": \"BACKFILL_EXISTING_PAYMENT\", \"payment_status\": \"SUCCESS\"}', 'SUCCESS', NULL, '2026-04-16 04:28:46.966977', 3),
(3, 1776310913671, 'SYSTEM', '{\"event\": \"BACKFILL_EXISTING_PAYMENT\", \"payment_status\": \"PENDING\"}', 'PENDING', NULL, '2026-04-16 04:28:46.969193', 2),
(4, 1776310694807, 'SYSTEM', '{\"event\": \"BACKFILL_EXISTING_PAYMENT\", \"payment_status\": \"PENDING\"}', 'PENDING', NULL, '2026-04-16 04:28:46.971066', 1),
(5, 1776313768835, 'SYSTEM', '{\"event\": \"CREATE_PAYMENT\", \"amount\": 50000}', 'PENDING', NULL, '2026-04-16 04:29:30.033414', 5),
(6, 1776313768835, 'SYSTEM', '{\"event\": \"MARK_SUCCESS\", \"source\": \"POLL_SYNC\", \"amount\": 50000}', 'SUCCESS', NULL, '2026-04-16 04:29:54.184352', 5),
(7, 1776313982709, 'SYSTEM', '{\"event\": \"CREATE_PAYMENT\", \"amount\": 50000}', 'PENDING', NULL, '2026-04-16 04:33:03.427207', 6),
(8, 1776313982709, 'SYSTEM', '{\"event\": \"MARK_SUCCESS\", \"source\": \"POLL_SYNC\", \"amount\": 50000}', 'SUCCESS', NULL, '2026-04-16 04:33:18.569273', 6);

-- --------------------------------------------------------

--
-- Table structure for table `refunds`
--

CREATE TABLE `refunds` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `amount` bigint(20) UNSIGNED NOT NULL CHECK (`amount` >= 0),
  `reason` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `processed_by` varchar(100) DEFAULT NULL,
  `processed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `payment_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL,
  `order_code` bigint(20) NOT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `amount` bigint(20) UNSIGNED NOT NULL CHECK (`amount` >= 0),
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `order_code`, `user_id`, `amount`, `status`, `created_at`) VALUES
(1, 1776310694807, 'demo_user', 50000, 'PENDING', '2026-04-16 03:38:16.176217'),
(2, 1776310913671, 'demo_user', 50000, 'PENDING', '2026-04-16 03:41:54.792894'),
(3, 1776311156031, 'demo_user', 50000, 'SUCCESS', '2026-04-16 03:45:57.354180'),
(4, 1776311689514, 'demo_user', 50000, 'SUCCESS', '2026-04-16 03:54:50.263131'),
(5, 1776313768835, 'demo_user', 50000, 'SUCCESS', '2026-04-16 04:29:30.032080'),
(6, 1776313982709, 'demo_user', 50000, 'SUCCESS', '2026-04-16 04:33:03.426122');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_balances`
--

CREATE TABLE `wallet_balances` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `balance` bigint(20) NOT NULL,
  `total_top_up` bigint(20) NOT NULL,
  `total_spent` bigint(20) NOT NULL,
  `last_updated` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_balances`
--

INSERT INTO `wallet_balances` (`id`, `user_id`, `balance`, `total_top_up`, `total_spent`, `last_updated`) VALUES
(1, 'demo_user', 200000, 200000, 0, '2026-04-16 04:33:18.568284');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_history`
--

CREATE TABLE `wallet_history` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `order_code` bigint(20) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `balance_before` bigint(20) DEFAULT NULL,
  `balance_after` bigint(20) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_history`
--

INSERT INTO `wallet_history` (`id`, `user_id`, `order_code`, `type`, `amount`, `balance_before`, `balance_after`, `note`, `created_at`) VALUES
(1, 'demo_user', 1776311156031, 'TOP_UP', 50000, 0, 50000, 'Nạp tiền PayOS (POLL_SYNC) - OrderCode 1776311156031', '2026-04-16 03:50:31.107274'),
(2, 'demo_user', 1776311689514, 'TOP_UP', 50000, 50000, 100000, 'Nạp tiền PayOS (POLL_SYNC) - OrderCode 1776311689514', '2026-04-16 03:55:08.425652'),
(3, 'demo_user', 1776313768835, 'TOP_UP', 50000, 100000, 150000, 'Nạp tiền PayOS (POLL_SYNC) - OrderCode 1776313768835', '2026-04-16 04:29:54.183764'),
(4, 'demo_user', 1776313982709, 'TOP_UP', 50000, 150000, 200000, 'Nạp tiền PayOS (POLL_SYNC) - OrderCode 1776313982709', '2026-04-16 04:33:18.568812');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

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
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_code` (`order_code`);

--
-- Indexes for table `payment_logs`
--
ALTER TABLE `payment_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_logs_payment_id_8bc90aae_fk_payments_id` (`payment_id`);

--
-- Indexes for table `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refunds_payment_id_075bbbe0_fk_payments_id` (`payment_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_code` (`order_code`);

--
-- Indexes for table `wallet_balances`
--
ALTER TABLE `wallet_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `wallet_history`
--
ALTER TABLE `wallet_history`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment_logs`
--
ALTER TABLE `payment_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `wallet_balances`
--
ALTER TABLE `wallet_balances`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wallet_history`
--
ALTER TABLE `wallet_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

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
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `payment_logs`
--
ALTER TABLE `payment_logs`
  ADD CONSTRAINT `payment_logs_payment_id_8bc90aae_fk_payments_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Constraints for table `refunds`
--
ALTER TABLE `refunds`
  ADD CONSTRAINT `refunds_payment_id_075bbbe0_fk_payments_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
