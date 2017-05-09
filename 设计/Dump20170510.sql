-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: packages
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_id` int(11) NOT NULL COMMENT '客户编号',
  `room_type_id` int(11) NOT NULL COMMENT '客房类型编号',
  `customer_name` varchar(30) NOT NULL COMMENT '客户姓名',
  `customer_phone` varchar(20) NOT NULL COMMENT '客户联系方式',
  `check_in_date` date NOT NULL COMMENT '入住日期',
  `check_in_days` int(11) NOT NULL DEFAULT '1' COMMENT '入住天数',
  `check_in_fee` int(11) NOT NULL COMMENT '入住房费',
  `prepaid` int(11) NOT NULL COMMENT '预付金额',
  `keep_datetime` datetime NOT NULL COMMENT '最晚保留时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1预定成功,2已入住,-1预定超时,-2预定取消',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '预订时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预订表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_role`
--

DROP TABLE IF EXISTS `menu_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_role` (
  `menu_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `menu_role_menu_id_role_id_unique` (`menu_id`,`role_id`),
  KEY `menu_role_menu_id_index` (`menu_id`),
  KEY `menu_role_role_id_index` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_role`
--

LOCK TABLES `menu_role` WRITE;
/*!40000 ALTER TABLE `menu_role` DISABLE KEYS */;
INSERT INTO `menu_role` VALUES (3,1),(3,2),(4,1),(4,2),(5,1),(5,2),(6,1),(6,2),(7,1),(7,2),(8,1),(8,2),(9,1),(9,3),(9,4),(10,1),(10,3),(10,4),(11,1),(11,3),(12,1),(12,3),(12,4),(13,1),(13,3),(13,4),(14,1),(14,3),(14,4),(15,1),(15,3),(15,4),(16,1),(16,3),(16,4),(17,1),(17,3),(17,4),(18,1),(18,3),(18,4),(19,1),(19,3),(19,4),(20,1),(20,3),(20,4),(21,1),(21,3),(21,4),(22,1),(22,3),(22,4),(23,1),(23,3),(23,4),(24,1),(24,3),(24,4),(25,1),(25,3),(25,4),(26,1),(26,3),(26,4),(27,1),(27,3),(27,4);
/*!40000 ALTER TABLE `menu_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) DEFAULT NULL,
  `menu_type` int(11) NOT NULL DEFAULT '1',
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,NULL,0,NULL,'User','User',NULL,NULL,NULL),(2,NULL,0,NULL,'Role','Role',NULL,NULL,NULL),(3,0,2,'fa-database','客房信息管理','客房信息管理',NULL,'2017-05-07 03:42:52','2017-05-07 03:42:52'),(4,0,2,'fa-database','入住信息管理','入住信息管理',NULL,'2017-05-07 03:45:51','2017-05-07 03:45:51'),(9,0,1,'fa-database','RoomType','客房类型管理',3,'2017-05-09 01:07:58','2017-05-09 01:07:58'),(12,0,1,'fa-database','Booking','预订管理',4,'2017-05-09 03:24:30','2017-05-09 03:24:30'),(11,0,1,'fa-database','Room','客房管理',3,'2017-05-09 01:42:27','2017-05-09 01:42:27'),(27,0,1,'fa-database','Test','测试',4,'2017-05-09 05:14:40','2017-05-09 05:14:40');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2015_10_10_000000_create_menus_table',1),(4,'2015_10_10_000000_create_roles_table',1),(5,'2015_10_10_000000_update_users_table',1),(6,'2015_12_11_000000_create_users_logs_table',1),(7,'2016_03_14_000000_update_menus_table',1),(8,'2017_05_07_115014_create_booking_table',2),(9,'2017_05_07_121945_create_checkin_table',3),(10,'2017_05_09_090758_create_roomtype_table',4),(11,'2017_05_09_092901_create_test_table',5),(12,'2017_05_09_094227_create_room_table',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'系统管理员','2017-05-07 03:40:28','2017-05-07 05:24:32'),(3,'前台接待员','2017-05-07 05:24:09','2017-05-07 05:24:09'),(4,'宾馆负责人','2017-05-07 05:24:23','2017-05-07 05:24:23');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房类型编号',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1空闲，2已预定（内部预订），3已入住，－1维修中',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='客房表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'401',1,'8888401',2,'2017-05-09 11:22:28','2017-05-09 03:22:28'),(2,'402',1,'8888402',1,'2017-05-09 03:15:20','2017-05-09 03:15:20'),(3,'501',2,'8888501',1,'2017-05-09 03:15:33','2017-05-09 03:15:33'),(4,'502',2,'8888502',1,'2017-05-09 03:17:21','2017-05-09 03:17:21');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_date_check_in`
--

DROP TABLE IF EXISTS `room_date_check_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_date_check_in` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房编号',
  `date` date NOT NULL COMMENT '日期',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1空闲，2已入住',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客房入住日期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_date_check_in`
--

LOCK TABLES `room_date_check_in` WRITE;
/*!40000 ALTER TABLE `room_date_check_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_date_check_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `fee` int(11) NOT NULL DEFAULT '0' COMMENT '费用',
  `area` float(5,2) NOT NULL DEFAULT '0.00' COMMENT '面积/平方米',
  `number_of_bed` tinyint(1) NOT NULL DEFAULT '1' COMMENT '床位数',
  `number_of_room` int(11) NOT NULL DEFAULT '0' COMMENT '房间数',
  `number_of_left_room` int(11) NOT NULL DEFAULT '0' COMMENT '剩余房间数',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客房类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (1,'大床房',280,18.00,1,20,0,'2017-05-09 09:25:57','2017-05-09 01:25:57'),(2,'高级大床房',320,20.00,1,15,0,'2017-05-09 01:26:21','2017-05-09 01:26:21');
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aaaa` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bbbb` tinyint(4) NOT NULL DEFAULT '1',
  `booking_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'admin','admin','$2y$10$WRffQ56xpObdSRFuSFbvFOqIQBjzz6BfzgIGrgDsU95rtl7SDIGAC','trAIj1gSXgTcgk9MuDUzEFFSODD03gsVIM21f8HiKl95DWLmwiHBfBGPb45f','2017-05-07 03:41:01','2017-05-07 03:41:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_logs`
--

DROP TABLE IF EXISTS `users_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_logs`
--

LOCK TABLES `users_logs` WRITE;
/*!40000 ALTER TABLE `users_logs` DISABLE KEYS */;
INSERT INTO `users_logs` VALUES (1,1,'created','booking',1,'2017-05-07 03:50:27','2017-05-07 03:50:27'),(2,1,'updated','users',1,'2017-05-07 05:37:42','2017-05-07 05:37:42'),(3,1,'updated','users',1,'2017-05-07 05:39:03','2017-05-07 05:39:03'),(4,1,'updated','users',1,'2017-05-09 00:52:50','2017-05-09 00:52:50'),(5,1,'updated','users',1,'2017-05-09 00:56:42','2017-05-09 00:56:42'),(6,1,'updated','users',1,'2017-05-09 00:57:15','2017-05-09 00:57:15'),(7,1,'updated','users',1,'2017-05-09 00:58:00','2017-05-09 00:58:00'),(8,1,'updated','users',1,'2017-05-09 01:02:24','2017-05-09 01:02:24'),(9,1,'created','room_type',1,'2017-05-09 01:16:27','2017-05-09 01:16:27'),(10,1,'created','room_type',1,'2017-05-09 01:22:06','2017-05-09 01:22:06'),(11,1,'updated','room_type',1,'2017-05-09 01:25:57','2017-05-09 01:25:57'),(12,1,'created','room_type',2,'2017-05-09 01:26:21','2017-05-09 01:26:21'),(13,1,'created','room_type',3,'2017-05-09 01:40:55','2017-05-09 01:40:55'),(14,1,'deleted','room_type',3,'2017-05-09 01:41:07','2017-05-09 01:41:07'),(15,1,'created','room',1,'2017-05-09 01:54:29','2017-05-09 01:54:29'),(16,1,'created','room',2,'2017-05-09 03:15:20','2017-05-09 03:15:20'),(17,1,'created','room',3,'2017-05-09 03:15:33','2017-05-09 03:15:33'),(18,1,'updated','room',1,'2017-05-09 03:17:05','2017-05-09 03:17:05'),(19,1,'created','room',4,'2017-05-09 03:17:22','2017-05-09 03:17:22'),(20,1,'updated','room',1,'2017-05-09 03:21:30','2017-05-09 03:21:30'),(21,1,'updated','room',1,'2017-05-09 03:21:42','2017-05-09 03:21:42'),(22,1,'updated','room',1,'2017-05-09 03:22:22','2017-05-09 03:22:22'),(23,1,'updated','room',1,'2017-05-09 03:22:28','2017-05-09 03:22:28'),(24,1,'updated','users',1,'2017-05-09 03:39:38','2017-05-09 03:39:38'),(25,1,'updated','users',1,'2017-05-09 03:43:40','2017-05-09 03:43:40'),(26,1,'updated','users',1,'2017-05-09 06:40:20','2017-05-09 06:40:20');
/*!40000 ALTER TABLE `users_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-10  7:44:15
