/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smart_info

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-30 15:20:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(128) DEFAULT NULL COMMENT '名称',
  `description` varchar(4096) DEFAULT NULL COMMENT '描述',
  `begin_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `days` int(11) DEFAULT '1' COMMENT '持续天数',
  `place` varchar(256) DEFAULT NULL COMMENT '地点',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `manager` int(11) DEFAULT NULL COMMENT '负责人',
  `cost` float(10,2) DEFAULT NULL COMMENT '开销',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
