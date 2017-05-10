/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : hotel

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-05-10 18:12:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for booking
-- ----------------------------
DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户编号',
  `room_type_id` int(11) NOT NULL COMMENT '客房类型编号',
  `customer_name` varchar(30) NOT NULL COMMENT '客户姓名',
  `customer_phone` varchar(20) NOT NULL COMMENT '客户联系方式',
  `check_in_date` date NOT NULL COMMENT '入住日期',
  `check_in_days` int(11) NOT NULL DEFAULT '1' COMMENT '入住天数',
  `amount` int(11) NOT NULL DEFAULT '1' COMMENT '预订数量',
  `check_in_fee` int(11) NOT NULL COMMENT '入住房费',
  `prepaid` int(11) NOT NULL COMMENT '预付金额',
  `keep_datetime` datetime NOT NULL COMMENT '最晚保留时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1预定成功,2已入住,-1预定超时,-2预定取消',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '预订时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='预订表';

-- ----------------------------
-- Records of booking
-- ----------------------------
INSERT INTO `booking` VALUES ('41', null, '1', '张三', '13800000000', '2017-05-10', '3', '1', '840', '0', '2017-05-13 00:00:00', '1', '2017-05-10 09:07:38', '2017-05-10 09:07:38');
INSERT INTO `booking` VALUES ('42', null, '2', '李四', '13811111111', '2017-05-10', '5', '3', '4800', '0', '2017-05-15 00:00:00', '1', '2017-05-10 09:08:05', '2017-05-10 09:08:05');
INSERT INTO `booking` VALUES ('43', null, '2', '王五', '13822222222', '2017-05-11', '2', '1', '640', '0', '2017-05-13 00:00:00', '1', '2017-05-10 09:08:41', '2017-05-10 09:08:41');
INSERT INTO `booking` VALUES ('44', null, '2', '测试', '13800000000', '2017-05-10', '100', '10', '320000', '0', '2017-08-18 00:00:00', '-2', '2017-05-10 17:10:49', '2017-05-10 09:10:49');
INSERT INTO `booking` VALUES ('45', null, '1', '测试', '13800000000', '2017-05-20', '3', '2', '840', '100', '2017-05-23 00:00:00', '1', '2017-05-10 17:43:00', '2017-05-10 09:11:30');

-- ----------------------------
-- Table structure for check_in
-- ----------------------------
DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `booking_id` int(11) NOT NULL DEFAULT '0' COMMENT '预订编号',
  `customer_id` int(11) NOT NULL COMMENT '客户编号',
  `room_id` int(11) NOT NULL COMMENT '客房编号',
  `check_in_days` int(11) NOT NULL DEFAULT '1' COMMENT '入住天数',
  `check_in_fee` int(11) NOT NULL COMMENT '入住房费',
  `pay_fee` int(11) NOT NULL COMMENT '已缴房费',
  `desopsit` int(11) NOT NULL COMMENT '押金',
  `check_out_datetime` datetime NOT NULL COMMENT '预计退房时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1入住中，2已退房',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '入住时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入住表';

-- ----------------------------
-- Records of check_in
-- ----------------------------

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
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
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES ('1', null, '0', null, 'User', 'User', null, null, null);
INSERT INTO `menus` VALUES ('2', null, '0', null, 'Role', 'Role', null, null, null);
INSERT INTO `menus` VALUES ('3', '0', '2', 'fa-database', '客房信息管理', '客房信息管理', null, '2017-05-07 11:42:52', '2017-05-07 11:42:52');
INSERT INTO `menus` VALUES ('4', '0', '2', 'fa-database', '入住信息管理', '入住信息管理', null, '2017-05-07 11:45:51', '2017-05-07 11:45:51');
INSERT INTO `menus` VALUES ('9', '0', '1', 'fa-database', 'RoomType', '客房类型管理', '3', '2017-05-09 09:07:58', '2017-05-09 09:07:58');
INSERT INTO `menus` VALUES ('12', '0', '1', 'fa-database', 'Booking', '预订管理', '4', '2017-05-09 11:24:30', '2017-05-09 11:24:30');
INSERT INTO `menus` VALUES ('11', '0', '1', 'fa-database', 'Room', '客房管理', '3', '2017-05-09 09:42:27', '2017-05-09 09:42:27');
INSERT INTO `menus` VALUES ('27', '0', '1', 'fa-database', 'Test', '测试', '4', '2017-05-09 13:14:40', '2017-05-09 13:14:40');
INSERT INTO `menus` VALUES ('28', '0', '1', 'fa-database', 'CheckIn', '入住管理', '4', '2017-05-10 07:35:47', '2017-05-10 07:35:47');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `menu_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `menu_role_menu_id_role_id_unique` (`menu_id`,`role_id`),
  KEY `menu_role_menu_id_index` (`menu_id`),
  KEY `menu_role_role_id_index` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('3', '1');
INSERT INTO `menu_role` VALUES ('3', '2');
INSERT INTO `menu_role` VALUES ('4', '1');
INSERT INTO `menu_role` VALUES ('4', '2');
INSERT INTO `menu_role` VALUES ('5', '1');
INSERT INTO `menu_role` VALUES ('5', '2');
INSERT INTO `menu_role` VALUES ('6', '1');
INSERT INTO `menu_role` VALUES ('6', '2');
INSERT INTO `menu_role` VALUES ('7', '1');
INSERT INTO `menu_role` VALUES ('7', '2');
INSERT INTO `menu_role` VALUES ('8', '1');
INSERT INTO `menu_role` VALUES ('8', '2');
INSERT INTO `menu_role` VALUES ('9', '1');
INSERT INTO `menu_role` VALUES ('9', '3');
INSERT INTO `menu_role` VALUES ('9', '4');
INSERT INTO `menu_role` VALUES ('10', '1');
INSERT INTO `menu_role` VALUES ('10', '3');
INSERT INTO `menu_role` VALUES ('10', '4');
INSERT INTO `menu_role` VALUES ('11', '1');
INSERT INTO `menu_role` VALUES ('11', '3');
INSERT INTO `menu_role` VALUES ('12', '1');
INSERT INTO `menu_role` VALUES ('12', '3');
INSERT INTO `menu_role` VALUES ('12', '4');
INSERT INTO `menu_role` VALUES ('13', '1');
INSERT INTO `menu_role` VALUES ('13', '3');
INSERT INTO `menu_role` VALUES ('13', '4');
INSERT INTO `menu_role` VALUES ('14', '1');
INSERT INTO `menu_role` VALUES ('14', '3');
INSERT INTO `menu_role` VALUES ('14', '4');
INSERT INTO `menu_role` VALUES ('15', '1');
INSERT INTO `menu_role` VALUES ('15', '3');
INSERT INTO `menu_role` VALUES ('15', '4');
INSERT INTO `menu_role` VALUES ('16', '1');
INSERT INTO `menu_role` VALUES ('16', '3');
INSERT INTO `menu_role` VALUES ('16', '4');
INSERT INTO `menu_role` VALUES ('17', '1');
INSERT INTO `menu_role` VALUES ('17', '3');
INSERT INTO `menu_role` VALUES ('17', '4');
INSERT INTO `menu_role` VALUES ('18', '1');
INSERT INTO `menu_role` VALUES ('18', '3');
INSERT INTO `menu_role` VALUES ('18', '4');
INSERT INTO `menu_role` VALUES ('19', '1');
INSERT INTO `menu_role` VALUES ('19', '3');
INSERT INTO `menu_role` VALUES ('19', '4');
INSERT INTO `menu_role` VALUES ('20', '1');
INSERT INTO `menu_role` VALUES ('20', '3');
INSERT INTO `menu_role` VALUES ('20', '4');
INSERT INTO `menu_role` VALUES ('21', '1');
INSERT INTO `menu_role` VALUES ('21', '3');
INSERT INTO `menu_role` VALUES ('21', '4');
INSERT INTO `menu_role` VALUES ('22', '1');
INSERT INTO `menu_role` VALUES ('22', '3');
INSERT INTO `menu_role` VALUES ('22', '4');
INSERT INTO `menu_role` VALUES ('23', '1');
INSERT INTO `menu_role` VALUES ('23', '3');
INSERT INTO `menu_role` VALUES ('23', '4');
INSERT INTO `menu_role` VALUES ('24', '1');
INSERT INTO `menu_role` VALUES ('24', '3');
INSERT INTO `menu_role` VALUES ('24', '4');
INSERT INTO `menu_role` VALUES ('25', '1');
INSERT INTO `menu_role` VALUES ('25', '3');
INSERT INTO `menu_role` VALUES ('25', '4');
INSERT INTO `menu_role` VALUES ('26', '1');
INSERT INTO `menu_role` VALUES ('26', '3');
INSERT INTO `menu_role` VALUES ('26', '4');
INSERT INTO `menu_role` VALUES ('27', '1');
INSERT INTO `menu_role` VALUES ('27', '3');
INSERT INTO `menu_role` VALUES ('27', '4');
INSERT INTO `menu_role` VALUES ('28', '1');
INSERT INTO `menu_role` VALUES ('28', '3');
INSERT INTO `menu_role` VALUES ('28', '4');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('1', '2014_10_12_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('2', '2014_10_12_100000_create_password_resets_table', '1');
INSERT INTO `migrations` VALUES ('3', '2015_10_10_000000_create_menus_table', '1');
INSERT INTO `migrations` VALUES ('4', '2015_10_10_000000_create_roles_table', '1');
INSERT INTO `migrations` VALUES ('5', '2015_10_10_000000_update_users_table', '1');
INSERT INTO `migrations` VALUES ('6', '2015_12_11_000000_create_users_logs_table', '1');
INSERT INTO `migrations` VALUES ('7', '2016_03_14_000000_update_menus_table', '1');
INSERT INTO `migrations` VALUES ('8', '2017_05_07_115014_create_booking_table', '2');
INSERT INTO `migrations` VALUES ('9', '2017_05_07_121945_create_checkin_table', '3');
INSERT INTO `migrations` VALUES ('10', '2017_05_09_090758_create_roomtype_table', '4');
INSERT INTO `migrations` VALUES ('11', '2017_05_09_092901_create_test_table', '5');
INSERT INTO `migrations` VALUES ('12', '2017_05_09_094227_create_room_table', '6');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', '系统管理员', '2017-05-07 11:40:28', '2017-05-07 13:24:32');
INSERT INTO `roles` VALUES ('3', '前台接待员', '2017-05-07 13:24:09', '2017-05-07 13:24:09');
INSERT INTO `roles` VALUES ('4', '宾馆负责人', '2017-05-07 13:24:23', '2017-05-07 13:24:23');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房类型编号',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1空闲，2已预定（内部预订），3已入住，－1维修中',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='客房表';

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1', '401', '1', '8888401', '2', '2017-05-09 19:22:28', '2017-05-09 11:22:28');
INSERT INTO `room` VALUES ('2', '402', '1', '8888402', '1', '2017-05-09 11:15:20', '2017-05-09 11:15:20');
INSERT INTO `room` VALUES ('3', '501', '2', '8888501', '1', '2017-05-09 11:15:33', '2017-05-09 11:15:33');
INSERT INTO `room` VALUES ('4', '502', '2', '8888502', '1', '2017-05-09 11:17:21', '2017-05-09 11:17:21');
INSERT INTO `room` VALUES ('5', '503', '2', '8888503', '1', '2017-05-10 11:22:25', '2017-05-09 11:17:21');

-- ----------------------------
-- Table structure for room_date_check_in
-- ----------------------------
DROP TABLE IF EXISTS `room_date_check_in`;
CREATE TABLE `room_date_check_in` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房编号',
  `date` date NOT NULL COMMENT '日期',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1空闲，2已入住',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='客房入住日期表';

-- ----------------------------
-- Records of room_date_check_in
-- ----------------------------
INSERT INTO `room_date_check_in` VALUES ('1', '1', '2017-05-10', '1', '2017-05-10 11:04:27', '0000-00-00 00:00:00');
INSERT INTO `room_date_check_in` VALUES ('2', '2', '2017-05-15', '1', '2017-05-10 11:04:51', '0000-00-00 00:00:00');
INSERT INTO `room_date_check_in` VALUES ('3', '1', '2017-05-14', '1', '2017-05-10 11:05:06', '0000-00-00 00:00:00');
INSERT INTO `room_date_check_in` VALUES ('4', '3', '2017-05-11', '1', '2017-05-10 11:07:51', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `fee` int(11) NOT NULL DEFAULT '0' COMMENT '费用',
  `area` float(5,2) NOT NULL DEFAULT '0.00' COMMENT '面积/平方米',
  `number_of_bed` tinyint(1) NOT NULL DEFAULT '1' COMMENT '床位数',
  `number_of_room` int(11) NOT NULL DEFAULT '0' COMMENT '房间数',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客房类型表';

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES ('1', '大床房', '280', '18.00', '1', '20', '2017-05-09 17:25:57', '2017-05-09 09:25:57');
INSERT INTO `room_type` VALUES ('2', '高级大床房', '320', '20.00', '1', '15', '2017-05-09 09:26:21', '2017-05-09 09:26:21');

-- ----------------------------
-- Table structure for room_type_date_check_in
-- ----------------------------
DROP TABLE IF EXISTS `room_type_date_check_in`;
CREATE TABLE `room_type_date_check_in` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `room_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房类型编号',
  `date` date NOT NULL COMMENT '日期',
  `number_of_check_in_room` int(11) NOT NULL DEFAULT '0' COMMENT '入住数',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='客房类型入住日期表';

-- ----------------------------
-- Records of room_type_date_check_in
-- ----------------------------
INSERT INTO `room_type_date_check_in` VALUES ('7', '1', '2017-05-10', '1', '2017-05-10 09:07:38', '2017-05-10 09:07:38');
INSERT INTO `room_type_date_check_in` VALUES ('8', '1', '2017-05-11', '1', '2017-05-10 09:07:38', '2017-05-10 09:07:38');
INSERT INTO `room_type_date_check_in` VALUES ('9', '1', '2017-05-12', '1', '2017-05-10 09:07:38', '2017-05-10 09:07:38');
INSERT INTO `room_type_date_check_in` VALUES ('10', '2', '2017-05-10', '3', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('11', '2', '2017-05-11', '4', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('12', '2', '2017-05-12', '4', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('13', '2', '2017-05-13', '3', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('14', '2', '2017-05-14', '3', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('15', '2', '2017-05-15', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('16', '2', '2017-05-16', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('17', '2', '2017-05-17', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('18', '2', '2017-05-18', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('19', '2', '2017-05-19', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('20', '2', '2017-05-20', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('21', '2', '2017-05-21', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('22', '2', '2017-05-22', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('23', '2', '2017-05-23', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('24', '2', '2017-05-24', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('25', '2', '2017-05-25', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('26', '2', '2017-05-26', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('27', '2', '2017-05-27', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('28', '2', '2017-05-28', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('29', '2', '2017-05-29', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('30', '2', '2017-05-30', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('31', '2', '2017-05-31', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('32', '2', '2017-06-01', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('33', '2', '2017-06-02', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('34', '2', '2017-06-03', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('35', '2', '2017-06-04', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('36', '2', '2017-06-05', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('37', '2', '2017-06-06', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('38', '2', '2017-06-07', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('39', '2', '2017-06-08', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('40', '2', '2017-06-09', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('41', '2', '2017-06-10', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('42', '2', '2017-06-11', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('43', '2', '2017-06-12', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('44', '2', '2017-06-13', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('45', '2', '2017-06-14', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('46', '2', '2017-06-15', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('47', '2', '2017-06-16', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('48', '2', '2017-06-17', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('49', '2', '2017-06-18', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('50', '2', '2017-06-19', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('51', '2', '2017-06-20', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('52', '2', '2017-06-21', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('53', '2', '2017-06-22', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('54', '2', '2017-06-23', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('55', '2', '2017-06-24', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('56', '2', '2017-06-25', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('57', '2', '2017-06-26', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('58', '2', '2017-06-27', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('59', '2', '2017-06-28', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('60', '2', '2017-06-29', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('61', '2', '2017-06-30', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('62', '2', '2017-07-01', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('63', '2', '2017-07-02', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('64', '2', '2017-07-03', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('65', '2', '2017-07-04', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('66', '2', '2017-07-05', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('67', '2', '2017-07-06', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('68', '2', '2017-07-07', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('69', '2', '2017-07-08', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('70', '2', '2017-07-09', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('71', '2', '2017-07-10', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('72', '2', '2017-07-11', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('73', '2', '2017-07-12', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('74', '2', '2017-07-13', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('75', '2', '2017-07-14', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('76', '2', '2017-07-15', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('77', '2', '2017-07-16', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('78', '2', '2017-07-17', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('79', '2', '2017-07-18', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('80', '2', '2017-07-19', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('81', '2', '2017-07-20', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('82', '2', '2017-07-21', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('83', '2', '2017-07-22', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('84', '2', '2017-07-23', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('85', '2', '2017-07-24', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('86', '2', '2017-07-25', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('87', '2', '2017-07-26', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('88', '2', '2017-07-27', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('89', '2', '2017-07-28', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('90', '2', '2017-07-29', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('91', '2', '2017-07-30', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('92', '2', '2017-07-31', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('93', '2', '2017-08-01', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('94', '2', '2017-08-02', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('95', '2', '2017-08-03', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('96', '2', '2017-08-04', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('97', '2', '2017-08-05', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('98', '2', '2017-08-06', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('99', '2', '2017-08-07', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('100', '2', '2017-08-08', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('101', '2', '2017-08-09', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('102', '2', '2017-08-10', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('103', '2', '2017-08-11', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('104', '2', '2017-08-12', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('105', '2', '2017-08-13', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('106', '2', '2017-08-14', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('107', '2', '2017-08-15', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('108', '2', '2017-08-16', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('109', '2', '2017-08-17', '0', '2017-05-10 17:10:49', '2017-05-10 09:10:19');
INSERT INTO `room_type_date_check_in` VALUES ('110', '1', '2017-05-20', '1', '2017-05-10 09:11:30', '2017-05-10 09:11:30');
INSERT INTO `room_type_date_check_in` VALUES ('111', '1', '2017-05-21', '1', '2017-05-10 09:11:30', '2017-05-10 09:11:30');
INSERT INTO `room_type_date_check_in` VALUES ('112', '1', '2017-05-22', '1', '2017-05-10 09:11:30', '2017-05-10 09:11:30');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aaaa` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bbbb` tinyint(4) NOT NULL DEFAULT '1',
  `booking_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
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

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '1', 'admin', 'admin', '$2y$10$WRffQ56xpObdSRFuSFbvFOqIQBjzz6BfzgIGrgDsU95rtl7SDIGAC', 'trAIj1gSXgTcgk9MuDUzEFFSODD03gsVIM21f8HiKl95DWLmwiHBfBGPb45f', '2017-05-07 11:41:01', '2017-05-07 11:41:01');

-- ----------------------------
-- Table structure for users_logs
-- ----------------------------
DROP TABLE IF EXISTS `users_logs`;
CREATE TABLE `users_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users_logs
-- ----------------------------
INSERT INTO `users_logs` VALUES ('1', '1', 'created', 'booking', '1', '2017-05-07 11:50:27', '2017-05-07 11:50:27');
INSERT INTO `users_logs` VALUES ('2', '1', 'updated', 'users', '1', '2017-05-07 13:37:42', '2017-05-07 13:37:42');
INSERT INTO `users_logs` VALUES ('3', '1', 'updated', 'users', '1', '2017-05-07 13:39:03', '2017-05-07 13:39:03');
INSERT INTO `users_logs` VALUES ('4', '1', 'updated', 'users', '1', '2017-05-09 08:52:50', '2017-05-09 08:52:50');
INSERT INTO `users_logs` VALUES ('5', '1', 'updated', 'users', '1', '2017-05-09 08:56:42', '2017-05-09 08:56:42');
INSERT INTO `users_logs` VALUES ('6', '1', 'updated', 'users', '1', '2017-05-09 08:57:15', '2017-05-09 08:57:15');
INSERT INTO `users_logs` VALUES ('7', '1', 'updated', 'users', '1', '2017-05-09 08:58:00', '2017-05-09 08:58:00');
INSERT INTO `users_logs` VALUES ('8', '1', 'updated', 'users', '1', '2017-05-09 09:02:24', '2017-05-09 09:02:24');
INSERT INTO `users_logs` VALUES ('9', '1', 'created', 'room_type', '1', '2017-05-09 09:16:27', '2017-05-09 09:16:27');
INSERT INTO `users_logs` VALUES ('10', '1', 'created', 'room_type', '1', '2017-05-09 09:22:06', '2017-05-09 09:22:06');
INSERT INTO `users_logs` VALUES ('11', '1', 'updated', 'room_type', '1', '2017-05-09 09:25:57', '2017-05-09 09:25:57');
INSERT INTO `users_logs` VALUES ('12', '1', 'created', 'room_type', '2', '2017-05-09 09:26:21', '2017-05-09 09:26:21');
INSERT INTO `users_logs` VALUES ('13', '1', 'created', 'room_type', '3', '2017-05-09 09:40:55', '2017-05-09 09:40:55');
INSERT INTO `users_logs` VALUES ('14', '1', 'deleted', 'room_type', '3', '2017-05-09 09:41:07', '2017-05-09 09:41:07');
INSERT INTO `users_logs` VALUES ('15', '1', 'created', 'room', '1', '2017-05-09 09:54:29', '2017-05-09 09:54:29');
INSERT INTO `users_logs` VALUES ('16', '1', 'created', 'room', '2', '2017-05-09 11:15:20', '2017-05-09 11:15:20');
INSERT INTO `users_logs` VALUES ('17', '1', 'created', 'room', '3', '2017-05-09 11:15:33', '2017-05-09 11:15:33');
INSERT INTO `users_logs` VALUES ('18', '1', 'updated', 'room', '1', '2017-05-09 11:17:05', '2017-05-09 11:17:05');
INSERT INTO `users_logs` VALUES ('19', '1', 'created', 'room', '4', '2017-05-09 11:17:22', '2017-05-09 11:17:22');
INSERT INTO `users_logs` VALUES ('20', '1', 'updated', 'room', '1', '2017-05-09 11:21:30', '2017-05-09 11:21:30');
INSERT INTO `users_logs` VALUES ('21', '1', 'updated', 'room', '1', '2017-05-09 11:21:42', '2017-05-09 11:21:42');
INSERT INTO `users_logs` VALUES ('22', '1', 'updated', 'room', '1', '2017-05-09 11:22:22', '2017-05-09 11:22:22');
INSERT INTO `users_logs` VALUES ('23', '1', 'updated', 'room', '1', '2017-05-09 11:22:28', '2017-05-09 11:22:28');
INSERT INTO `users_logs` VALUES ('24', '1', 'updated', 'users', '1', '2017-05-09 11:39:38', '2017-05-09 11:39:38');
INSERT INTO `users_logs` VALUES ('25', '1', 'updated', 'users', '1', '2017-05-09 11:43:40', '2017-05-09 11:43:40');
INSERT INTO `users_logs` VALUES ('26', '1', 'updated', 'users', '1', '2017-05-09 14:40:20', '2017-05-09 14:40:20');
INSERT INTO `users_logs` VALUES ('27', '1', 'created', 'booking', '1', '2017-05-10 06:04:16', '2017-05-10 06:04:16');
INSERT INTO `users_logs` VALUES ('28', '1', 'updated', 'booking', '1', '2017-05-10 07:06:22', '2017-05-10 07:06:22');
INSERT INTO `users_logs` VALUES ('29', '1', 'updated', 'booking', '1', '2017-05-10 07:08:16', '2017-05-10 07:08:16');
INSERT INTO `users_logs` VALUES ('30', '1', 'created', 'booking', '2', '2017-05-10 08:41:14', '2017-05-10 08:41:14');
INSERT INTO `users_logs` VALUES ('31', '1', 'created', 'booking', '3', '2017-05-10 08:41:34', '2017-05-10 08:41:34');
INSERT INTO `users_logs` VALUES ('32', '1', 'created', 'booking', '4', '2017-05-10 08:41:57', '2017-05-10 08:41:57');
INSERT INTO `users_logs` VALUES ('33', '1', 'created', 'booking', '5', '2017-05-10 08:42:46', '2017-05-10 08:42:46');
INSERT INTO `users_logs` VALUES ('34', '1', 'created', 'booking', '6', '2017-05-10 08:43:15', '2017-05-10 08:43:15');
INSERT INTO `users_logs` VALUES ('35', '1', 'created', 'booking', '7', '2017-05-10 08:43:47', '2017-05-10 08:43:47');
INSERT INTO `users_logs` VALUES ('36', '1', 'created', 'booking', '8', '2017-05-10 08:45:40', '2017-05-10 08:45:40');
INSERT INTO `users_logs` VALUES ('37', '1', 'created', 'booking', '9', '2017-05-10 08:45:47', '2017-05-10 08:45:47');
INSERT INTO `users_logs` VALUES ('38', '1', 'created', 'booking', '10', '2017-05-10 08:45:48', '2017-05-10 08:45:48');
INSERT INTO `users_logs` VALUES ('39', '1', 'created', 'booking', '11', '2017-05-10 08:45:48', '2017-05-10 08:45:48');
INSERT INTO `users_logs` VALUES ('40', '1', 'created', 'booking', '12', '2017-05-10 08:45:49', '2017-05-10 08:45:49');
INSERT INTO `users_logs` VALUES ('41', '1', 'created', 'booking', '13', '2017-05-10 08:45:49', '2017-05-10 08:45:49');
INSERT INTO `users_logs` VALUES ('42', '1', 'created', 'booking', '14', '2017-05-10 08:46:01', '2017-05-10 08:46:01');
INSERT INTO `users_logs` VALUES ('43', '1', 'created', 'booking', '15', '2017-05-10 08:46:01', '2017-05-10 08:46:01');
INSERT INTO `users_logs` VALUES ('44', '1', 'created', 'booking', '16', '2017-05-10 08:46:10', '2017-05-10 08:46:10');
INSERT INTO `users_logs` VALUES ('45', '1', 'created', 'booking', '17', '2017-05-10 08:46:11', '2017-05-10 08:46:11');
INSERT INTO `users_logs` VALUES ('46', '1', 'created', 'booking', '18', '2017-05-10 08:46:11', '2017-05-10 08:46:11');
INSERT INTO `users_logs` VALUES ('47', '1', 'created', 'booking', '19', '2017-05-10 08:46:45', '2017-05-10 08:46:45');
INSERT INTO `users_logs` VALUES ('48', '1', 'created', 'booking', '20', '2017-05-10 08:47:17', '2017-05-10 08:47:17');
INSERT INTO `users_logs` VALUES ('49', '1', 'created', 'booking', '21', '2017-05-10 08:47:29', '2017-05-10 08:47:29');
INSERT INTO `users_logs` VALUES ('50', '1', 'created', 'booking', '22', '2017-05-10 08:49:14', '2017-05-10 08:49:14');
INSERT INTO `users_logs` VALUES ('51', '1', 'created', 'booking', '23', '2017-05-10 08:49:16', '2017-05-10 08:49:16');
INSERT INTO `users_logs` VALUES ('52', '1', 'created', 'booking', '24', '2017-05-10 08:49:16', '2017-05-10 08:49:16');
INSERT INTO `users_logs` VALUES ('53', '1', 'created', 'booking', '25', '2017-05-10 08:49:17', '2017-05-10 08:49:17');
INSERT INTO `users_logs` VALUES ('54', '1', 'created', 'booking', '26', '2017-05-10 08:50:02', '2017-05-10 08:50:02');
INSERT INTO `users_logs` VALUES ('55', '1', 'created', 'booking', '27', '2017-05-10 08:50:04', '2017-05-10 08:50:04');
INSERT INTO `users_logs` VALUES ('56', '1', 'created', 'booking', '28', '2017-05-10 08:50:05', '2017-05-10 08:50:05');
INSERT INTO `users_logs` VALUES ('57', '1', 'created', 'booking', '29', '2017-05-10 08:50:06', '2017-05-10 08:50:06');
INSERT INTO `users_logs` VALUES ('58', '1', 'created', 'booking', '30', '2017-05-10 08:50:07', '2017-05-10 08:50:07');
INSERT INTO `users_logs` VALUES ('59', '1', 'created', 'booking', '31', '2017-05-10 08:50:09', '2017-05-10 08:50:09');
INSERT INTO `users_logs` VALUES ('60', '1', 'created', 'booking', '32', '2017-05-10 08:50:10', '2017-05-10 08:50:10');
INSERT INTO `users_logs` VALUES ('61', '1', 'created', 'booking', '33', '2017-05-10 08:50:27', '2017-05-10 08:50:27');
INSERT INTO `users_logs` VALUES ('62', '1', 'created', 'booking', '34', '2017-05-10 08:50:40', '2017-05-10 08:50:40');
INSERT INTO `users_logs` VALUES ('63', '1', 'created', 'booking', '35', '2017-05-10 08:51:52', '2017-05-10 08:51:52');
INSERT INTO `users_logs` VALUES ('64', '1', 'created', 'booking', '36', '2017-05-10 08:51:53', '2017-05-10 08:51:53');
INSERT INTO `users_logs` VALUES ('65', '1', 'created', 'booking', '37', '2017-05-10 08:51:54', '2017-05-10 08:51:54');
INSERT INTO `users_logs` VALUES ('66', '1', 'created', 'booking', '38', '2017-05-10 08:51:55', '2017-05-10 08:51:55');
INSERT INTO `users_logs` VALUES ('67', '1', 'created', 'booking', '39', '2017-05-10 08:51:55', '2017-05-10 08:51:55');
INSERT INTO `users_logs` VALUES ('68', '1', 'created', 'booking', '40', '2017-05-10 08:54:25', '2017-05-10 08:54:25');
INSERT INTO `users_logs` VALUES ('69', '1', 'updated', 'booking', '10', '2017-05-10 09:04:28', '2017-05-10 09:04:28');
INSERT INTO `users_logs` VALUES ('70', '1', 'updated', 'booking', '10', '2017-05-10 09:06:13', '2017-05-10 09:06:13');
INSERT INTO `users_logs` VALUES ('71', '1', 'updated', 'booking', '10', '2017-05-10 09:06:25', '2017-05-10 09:06:25');
INSERT INTO `users_logs` VALUES ('72', '1', 'updated', 'booking', '2', '2017-05-10 09:06:40', '2017-05-10 09:06:40');
INSERT INTO `users_logs` VALUES ('73', '1', 'created', 'booking', '41', '2017-05-10 09:07:38', '2017-05-10 09:07:38');
INSERT INTO `users_logs` VALUES ('74', '1', 'created', 'booking', '42', '2017-05-10 09:08:05', '2017-05-10 09:08:05');
INSERT INTO `users_logs` VALUES ('75', '1', 'created', 'booking', '43', '2017-05-10 09:08:41', '2017-05-10 09:08:41');
INSERT INTO `users_logs` VALUES ('76', '1', 'created', 'booking', '44', '2017-05-10 09:10:20', '2017-05-10 09:10:20');
INSERT INTO `users_logs` VALUES ('77', '1', 'updated', 'booking', '44', '2017-05-10 09:10:49', '2017-05-10 09:10:49');
INSERT INTO `users_logs` VALUES ('78', '1', 'created', 'booking', '45', '2017-05-10 09:11:30', '2017-05-10 09:11:30');
