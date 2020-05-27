/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smart_info

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-30 15:21:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_dict_def
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_def`;
CREATE TABLE `sys_dict_def` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(128) NOT NULL,
  `disabled` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_3nms3df7xmrchg26klb5v0hg1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dict_def
-- ----------------------------
INSERT INTO `sys_dict_def` VALUES ('1', '成员关系', null, 'SMART_INFO_DIC_RELATIONSHIP');
INSERT INTO `sys_dict_def` VALUES ('2', '职业', null, 'SMART_INFO_DIC_OCCUPATION');
INSERT INTO `sys_dict_def` VALUES ('3', '兴趣爱好', null, 'SMART_INFO_DIC_INTERESTS');
INSERT INTO `sys_dict_def` VALUES ('4', '工单状态', null, 'SMART_INFO_DIC_ORDERSTATUS');
INSERT INTO `sys_dict_def` VALUES ('5', '工单优先级', null, 'SMART_INFO_DIC_ORDERPRIORITY');
INSERT INTO `sys_dict_def` VALUES ('6', '任务状态', null, 'SMART_INFO_DIC_TASKSTATUS');
INSERT INTO `sys_dict_def` VALUES ('7', '工单操作类型', null, 'SMART_INFO_DIC_OPHISTORYTYPE');
INSERT INTO `sys_dict_def` VALUES ('8', '性别', null, 'SMART_INFO_DIC_GENDER');
INSERT INTO `sys_dict_def` VALUES ('9', '项目', null, 'SMART_INFO_DIC_PROJECT');
INSERT INTO `sys_dict_def` VALUES ('10', '项目进度', null, 'SMART_INFO_DIC_PROGRESS');
INSERT INTO `sys_dict_def` VALUES ('11', '活动状态', null, 'SMART_INFO_DIC_STATUS');
