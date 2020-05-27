/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smart_info

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-30 15:41:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity_member
-- ----------------------------
DROP TABLE IF EXISTS `activity_member`;
CREATE TABLE `activity_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动编号',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户编号',
  `invited` int(11) DEFAULT '0' COMMENT '已邀请',
  `confirm` int(11) DEFAULT '0' COMMENT '已确认',
  `reject` int(11) DEFAULT '0' COMMENT '已拒绝',
  `seats` int(11) DEFAULT '0' COMMENT '预留人数',
  `appear` int(11) DEFAULT '0' COMMENT '到场人数',
  `comment` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_act_cus` (`activity_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
