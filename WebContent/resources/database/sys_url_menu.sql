/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smart_info

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-30 15:21:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_url_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_url_menu`;
CREATE TABLE `sys_url_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `disabled` int(11) NOT NULL,
  `icon` varchar(40) DEFAULT NULL,
  `icon_color` varchar(40) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `orderno` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `show_on_navi` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `url` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_url_menu
-- ----------------------------
INSERT INTO `sys_url_menu` VALUES ('1', null, '-1', '0', 'fa-address-card', '#16A5A5', '客户管理', '2', '0', '1', '1', 'a.jsp');
INSERT INTO `sys_url_menu` VALUES ('2', null, '-1', '0', 'fa-align-left', '#16A5A5', '工单管理', '3', '0', '1', '1', 'a.jsp');
INSERT INTO `sys_url_menu` VALUES ('4', null, '-1', '0', 'fa-users', '#16A5A5', '所有客户', '1', '1', '1', '1', 'jsp/si/com_customer_info.jsp');
INSERT INTO `sys_url_menu` VALUES ('5', null, '-1', '0', 'fa-list', '#16A5A5', '所有工单', '1', '2', '1', '1', 'jsp/si/oms_order_main.jsp');
INSERT INTO `sys_url_menu` VALUES ('16', null, '-1', '0', 'fa-odnoklassniki', '#16A5A5', '所有成员', '2', '1', '1', '1', 'jsp/si/com_family_info.jsp');
INSERT INTO `sys_url_menu` VALUES ('18', null, '-1', '0', 'fa-map-marker', '#16A5A5', '活动信息', '3', '20', '1', '1', 'jsp/si/activity.jsp');
INSERT INTO `sys_url_menu` VALUES ('19', null, '-1', '0', 'fa-map-pin', '#16A5A5', '参与登记', '4', '20', '1', '1', 'jsp/si/activity_member.jsp');
INSERT INTO `sys_url_menu` VALUES ('20', null, '-1', '0', 'fa-sun-o', '#16A5A5', '活动管理', '4', '0', '1', '0', '');
