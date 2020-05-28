/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : jat_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-05-27 21:03:34
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
  `cost` double(10,2) DEFAULT NULL COMMENT '开销',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES ('8', '三八节活动', null, '2018-03-08 14:00:00', null, '汉府饭店', '长江路129号汉府饭店', '18', '3280.00', '67');
INSERT INTO `activity` VALUES ('9', '马术活动', '', '2016-05-12 14:00:00', null, '浦口', '浦口安闲马术俱乐部 盘城街道滁河汪庄组18号', '19', '1999.30', '67');
INSERT INTO `activity` VALUES ('11', '击剑活动', null, '2018-07-29 14:00:00', null, '仙林', '南京市栖霞区仙林大道118号曼度广场301', '18', '1339.10', '67');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_member
-- ----------------------------
INSERT INTO `activity_member` VALUES ('1', '7', '29', '0', '0', null, '3', '2', '邀请的朋友后来成为了我们的客户');
INSERT INTO `activity_member` VALUES ('2', '9', '52', '1', '1', null, '12', '10', null);
INSERT INTO `activity_member` VALUES ('3', '9', '113', '1', '1', null, '12', '10', null);

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property` VALUES ('next.dbid', '2501', '2');
INSERT INTO `act_ge_property` VALUES ('schema.history', 'create(5.18.0.0)', '1');
INSERT INTO `act_ge_property` VALUES ('schema.version', '5.18.0.0', '1');

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_node_setting
-- ----------------------------
DROP TABLE IF EXISTS `bpm_node_setting`;
CREATE TABLE `bpm_node_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abnormal_status` int(11) DEFAULT NULL,
  `auto_complete` int(11) DEFAULT NULL,
  `deploy_id` varchar(32) NOT NULL,
  `node_id` varchar(60) DEFAULT NULL,
  `notification_config` longtext,
  `process_status` varchar(64) DEFAULT NULL,
  `process_status_text` varchar(128) DEFAULT NULL,
  `task_completor` longtext,
  `task_form` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_node_setting
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_org
-- ----------------------------
DROP TABLE IF EXISTS `bpm_org`;
CREATE TABLE `bpm_org` (
  `id` varchar(32) NOT NULL,
  `app_id` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pid` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_org
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_process_status_def
-- ----------------------------
DROP TABLE IF EXISTS `bpm_process_status_def`;
CREATE TABLE `bpm_process_status_def` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deployment_id` varchar(32) DEFAULT NULL,
  `description` varchar(128) NOT NULL,
  `model_id` varchar(32) NOT NULL,
  `status_value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_process_status_def
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_role
-- ----------------------------
DROP TABLE IF EXISTS `bpm_role`;
CREATE TABLE `bpm_role` (
  `id` varchar(32) NOT NULL,
  `app_id` varchar(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_role
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_task_transition
-- ----------------------------
DROP TABLE IF EXISTS `bpm_task_transition`;
CREATE TABLE `bpm_task_transition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `from_user` varchar(32) NOT NULL,
  `msg_flag` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `taks_id` varchar(32) NOT NULL,
  `toUser` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_task_transition
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_task_vars_history
-- ----------------------------
DROP TABLE IF EXISTS `bpm_task_vars_history`;
CREATE TABLE `bpm_task_vars_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `task_name` varchar(128) NOT NULL,
  `var_name` varchar(64) NOT NULL,
  `var_type` int(11) NOT NULL,
  `var_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_task_vars_history
-- ----------------------------

-- ----------------------------
-- Table structure for bpm_user
-- ----------------------------
DROP TABLE IF EXISTS `bpm_user`;
CREATE TABLE `bpm_user` (
  `id` varchar(32) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `group_id` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpm_user
-- ----------------------------

-- ----------------------------
-- Table structure for com_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `com_customer_info`;
CREATE TABLE `com_customer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `name` varchar(128) DEFAULT NULL COMMENT '客户名称',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系手机号',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `resp_group` int(11) DEFAULT NULL COMMENT '责任项目组',
  `register_date` datetime DEFAULT NULL COMMENT '登记时间',
  `resp_manager` int(11) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL COMMENT '性别（0-女，1-男）',
  `advise_manager` int(11) DEFAULT NULL COMMENT '顾问接口人',
  `service_manager` int(11) DEFAULT NULL COMMENT '客服接口人',
  `technical_manager` int(11) DEFAULT NULL COMMENT '技术接口人',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `special_day` datetime DEFAULT NULL,
  `home_addr` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `office_addr` varchar(255) DEFAULT NULL COMMENT '办公地址',
  `other_addr` varchar(255) DEFAULT NULL COMMENT '其他地址',
  `job` int(11) DEFAULT NULL,
  `interest` varchar(128) DEFAULT NULL COMMENT '兴趣爱好',
  `childrens` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `married` int(11) DEFAULT NULL,
  `last_visit_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `progress` int(11) DEFAULT NULL,
  `project` int(11) DEFAULT NULL,
  `visit_note` varchar(10240) DEFAULT NULL COMMENT '拜访笔记',
  `comment` varchar(255) DEFAULT NULL,
  `visit_note_new` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of com_customer_info
-- ----------------------------

-- ----------------------------
-- Table structure for com_family_info
-- ----------------------------
DROP TABLE IF EXISTS `com_family_info`;
CREATE TABLE `com_family_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员编号',
  `membership` int(11) DEFAULT NULL COMMENT '成员关系（1-户主，2-夫妻，3-子女，4-兄妹，5-父母）',
  `name` varchar(64) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `job` int(128) DEFAULT NULL COMMENT '职业',
  `interest` varchar(128) DEFAULT NULL COMMENT '兴趣爱好',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户编号',
  `photo_file` varchar(64) DEFAULT NULL COMMENT '证件文件扫描件',
  `birthday` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of com_family_info
-- ----------------------------

-- ----------------------------
-- Table structure for com_tag_def
-- ----------------------------
DROP TABLE IF EXISTS `com_tag_def`;
CREATE TABLE `com_tag_def` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(64) DEFAULT NULL COMMENT '标签描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of com_tag_def
-- ----------------------------
INSERT INTO `com_tag_def` VALUES ('1', '事故处理');
INSERT INTO `com_tag_def` VALUES ('2', '用户反馈');

-- ----------------------------
-- Table structure for oms_customer_tag_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_customer_tag_link`;
CREATE TABLE `oms_customer_tag_link` (
  `id` int(11) NOT NULL COMMENT '序号',
  `tag_id` int(11) DEFAULT NULL COMMENT '标签ID',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_customer_tag_link
-- ----------------------------

-- ----------------------------
-- Table structure for oms_oph_file_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_oph_file_link`;
CREATE TABLE `oms_oph_file_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `file_id` varchar(64) DEFAULT NULL COMMENT '文件ID',
  `history_id` int(11) DEFAULT NULL COMMENT '关联工单处理过程编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_oph_file_link
-- ----------------------------
INSERT INTO `oms_oph_file_link` VALUES ('6', '9d761165-1609-46c6-be5e-01612d6344fd', '2');
INSERT INTO `oms_oph_file_link` VALUES ('7', '7583dbeb-ff4b-4cfb-a442-0e56c9701843', '2');

-- ----------------------------
-- Table structure for oms_op_history
-- ----------------------------
DROP TABLE IF EXISTS `oms_op_history`;
CREATE TABLE `oms_op_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工单处理流水号',
  `order_id` int(11) DEFAULT NULL COMMENT '工单编号',
  `remark` varchar(512) DEFAULT NULL COMMENT '处理过程描述',
  `result` int(11) DEFAULT NULL COMMENT '处理结果',
  `op_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `op_type` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '处理人员ID',
  `task_id` int(11) DEFAULT NULL COMMENT '任务编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_op_history
-- ----------------------------
INSERT INTO `oms_op_history` VALUES ('1', '6', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>处理结果：222</p>\n</body>\n</html>', '39', '2018-01-26 11:27:36', '43', '2', '10');
INSERT INTO `oms_op_history` VALUES ('2', '1', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>记录1</p>\n<p>柯尼卡</p>\n</body>\n</html>', '39', null, null, '2', '1');
INSERT INTO `oms_op_history` VALUES ('3', '10', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>记录2</p>\n</body>\n</html>', null, null, null, '2', '8');
INSERT INTO `oms_op_history` VALUES ('5', '6', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>记录1</p>\n</body>\n</html>', '38', '2018-01-26 11:28:01', '43', '2', '3');
INSERT INTO `oms_op_history` VALUES ('7', '11', '创建了工单', null, null, null, '2', null);
INSERT INTO `oms_op_history` VALUES ('8', '6', '更改工单状态为：null', null, '2018-01-26 11:43:31', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('9', '6', '更改工单状态为：null', null, '2018-01-26 11:43:45', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('10', '6', '更改工单状态为：null', null, '2018-01-26 11:43:48', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('11', '6', '更改工单状态为：null', null, '2018-01-26 11:43:54', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('12', '6', '更改工单状态为：null', null, '2018-01-26 11:43:56', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('13', '6', '更改工单状态为：null', null, '2018-01-26 11:43:57', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('14', '6', '更改工单状态为：null', null, '2018-01-26 11:43:57', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('15', '6', '更改工单状态为：null', null, '2018-01-26 11:43:57', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('16', '6', '更改工单状态为：null', null, '2018-01-26 11:43:57', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('17', '6', '更改工单状态为：null', null, '2018-01-26 11:44:26', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('18', '6', '更改工单状态为：null', null, '2018-01-26 11:46:05', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('19', '6', '更改工单状态为：null', null, '2018-01-26 11:46:09', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('20', '1', '更改工单状态为：父母', null, '2018-01-26 11:50:01', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('21', '1', '更改工单状态为：兄弟姐妹', null, '2018-01-26 11:51:45', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('22', '1', '更改工单状态为：兄弟姐妹', null, '2018-01-26 11:51:49', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('23', '6', '更改工单状态为：兄弟姐妹', null, '2018-01-26 11:52:24', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('24', '7', '更改工单状态为：兄弟姐妹', null, '2018-01-26 11:53:22', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('25', '6', '更改工单状态为：已解决', null, '2018-01-26 15:28:42', '44', '2', null);
INSERT INTO `oms_op_history` VALUES ('26', '12', null, null, '2018-01-31 09:48:37', '40', '2', null);
INSERT INTO `oms_op_history` VALUES ('27', '13', null, null, '2018-05-16 10:09:12', '40', '19', null);
INSERT INTO `oms_op_history` VALUES ('28', '13', '更改工单状态为：已解决', null, '2018-05-17 13:48:43', '44', '19', null);

-- ----------------------------
-- Table structure for oms_order_file_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_file_link`;
CREATE TABLE `oms_order_file_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `file_id` varchar(64) DEFAULT NULL COMMENT '文件ID',
  `order_id` int(11) DEFAULT NULL COMMENT '关联工单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_order_file_link
-- ----------------------------
INSERT INTO `oms_order_file_link` VALUES ('44', '693d5c07-a216-4487-b33d-9c847af4d111', '6');
INSERT INTO `oms_order_file_link` VALUES ('45', '7ba9229e-a0f0-47a5-8654-4c2ef400858d', '6');
INSERT INTO `oms_order_file_link` VALUES ('46', 'bcb76040-b9cc-4abd-8310-f09ea63250fe', '6');

-- ----------------------------
-- Table structure for oms_order_main
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_main`;
CREATE TABLE `oms_order_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `topic` varchar(128) DEFAULT NULL COMMENT '主题',
  `content` varchar(512) DEFAULT NULL COMMENT '受理内容',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户编号',
  `resp_user` int(11) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态（1新建、2解决中、3已解决、4已关闭）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级(1低，2中，3高)',
  `create_time` datetime DEFAULT NULL COMMENT '受理时间',
  `instance_id` varchar(32) DEFAULT NULL COMMENT '模板工单的流程实例ID',
  `close_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_order_main
-- ----------------------------
INSERT INTO `oms_order_main` VALUES ('1', '测试工单', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>测试工单内容<img src=\"http://element-cn.eleme.io/1.4/static/hamburger.50e4091.png\" alt=\"aaa\" width=\"235\" height=\"236\" /></p>\n</body>\n</html>', '16', '2', '4', '1', '2018-01-17 13:59:39', '-1', '2018-01-26 11:51:48');
INSERT INTO `oms_order_main` VALUES ('6', '工单2', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>工单2</p>\n</body>\n</html>', '19', '2', '3', '1', '2018-01-17 15:11:22', '-1', '2018-01-26 15:28:42');
INSERT INTO `oms_order_main` VALUES ('7', '测试工单', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>测试工单内容<img src=\"http://element-cn.eleme.io/1.4/static/hamburger.50e4091.png\" alt=\"aaa\" width=\"235\" height=\"236\" /></p>\n</body>\n</html>', '20', '2', '4', '1', '2018-01-17 14:00:16', '-1', '2018-01-26 11:53:21');
INSERT INTO `oms_order_main` VALUES ('8', '测试工单', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>测试工单内容<img src=\"http://element-cn.eleme.io/1.4/static/hamburger.50e4091.png\" alt=\"aaa\" width=\"235\" height=\"236\" /></p>\n</body>\n</html>', '16', '2', '4', '2', '2018-01-17 14:00:31', '-1', '2018-01-17 11:18:42');
INSERT INTO `oms_order_main` VALUES ('11', '001', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>001</p>\n</body>\n</html>', '16', '2', '1', '3', '2018-01-18 16:06:38', '-1', null);
INSERT INTO `oms_order_main` VALUES ('12', '啊啊啊', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n\n</body>\n</html>', '16', '2', '1', '3', '2018-01-31 09:48:37', '-1', null);
INSERT INTO `oms_order_main` VALUES ('13', '客户女儿枫叶卡丢失', '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>客户女儿枫叶卡丢失，需要了解补办枫叶卡周期，以及回国、再回加拿大是否受影响等问题。</p>\n</body>\n</html>', '188', '19', '3', '2', '2018-05-16 10:09:12', '-1', '2018-05-17 13:48:43');

-- ----------------------------
-- Table structure for oms_order_tag_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_tag_link`;
CREATE TABLE `oms_order_tag_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `tag_id` int(11) DEFAULT NULL COMMENT '标签ID',
  `order_id` int(11) DEFAULT NULL COMMENT '工单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_order_tag_link
-- ----------------------------
INSERT INTO `oms_order_tag_link` VALUES ('27', '1', '6');
INSERT INTO `oms_order_tag_link` VALUES ('29', '1', '13');

-- ----------------------------
-- Table structure for oms_order_task
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_task`;
CREATE TABLE `oms_order_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务编号',
  `name` varchar(128) DEFAULT NULL COMMENT '名称',
  `holder_user_id` int(11) DEFAULT NULL COMMENT '任务受理人',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `begin_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '起始时间',
  `due_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后期限',
  `content` varchar(512) DEFAULT NULL COMMENT '处理内容',
  `orde_id` int(11) DEFAULT NULL COMMENT '工单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_order_task
-- ----------------------------
INSERT INTO `oms_order_task` VALUES ('1', '测试任务1', '4', '2018-01-16 16:01:55', '2018-01-05 16:01:09', '2018-01-16 16:01:55', '测试内容1', '1');
INSERT INTO `oms_order_task` VALUES ('2', '测试任务2', '2', '2018-01-16 16:01:58', '2018-01-05 16:01:09', '2018-01-16 16:01:58', '测试内容2', '3');
INSERT INTO `oms_order_task` VALUES ('3', 'task-lisi', '4', '2018-01-16 16:02:04', '2018-01-05 16:01:09', '2018-01-16 16:02:04', '给张三的任务', '6');
INSERT INTO `oms_order_task` VALUES ('8', 'sss', '5', '2018-01-16 16:02:06', '2018-01-05 16:01:09', '2018-01-16 16:02:06', '456456', '10');
INSERT INTO `oms_order_task` VALUES ('10', '测试', '2', '2018-01-16 16:02:09', '2018-01-05 16:01:09', '2018-01-16 16:02:09', '测试', '6');

-- ----------------------------
-- Table structure for oms_team_group
-- ----------------------------
DROP TABLE IF EXISTS `oms_team_group`;
CREATE TABLE `oms_team_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务团队编号',
  `name` varchar(64) DEFAULT NULL COMMENT '团队名称',
  `manager` int(11) DEFAULT NULL COMMENT '责任人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_team_group
-- ----------------------------
INSERT INTO `oms_team_group` VALUES ('1', '客服', '11');
INSERT INTO `oms_team_group` VALUES ('2', '文案', '12');
INSERT INTO `oms_team_group` VALUES ('3', '顾问', '13');
INSERT INTO `oms_team_group` VALUES ('4', '市场', '3');
INSERT INTO `oms_team_group` VALUES ('5', '其他', '5');

-- ----------------------------
-- Table structure for oms_team_user_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_team_user_link`;
CREATE TABLE `oms_team_user_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `team_id` int(11) DEFAULT NULL COMMENT '小组ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_team_user_link
-- ----------------------------
INSERT INTO `oms_team_user_link` VALUES ('65', '3', '4');
INSERT INTO `oms_team_user_link` VALUES ('66', '4', '4');
INSERT INTO `oms_team_user_link` VALUES ('67', '5', '4');
INSERT INTO `oms_team_user_link` VALUES ('96', '5', '5');
INSERT INTO `oms_team_user_link` VALUES ('101', null, '2');
INSERT INTO `oms_team_user_link` VALUES ('102', null, '2');
INSERT INTO `oms_team_user_link` VALUES ('103', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('122', '2', '5');
INSERT INTO `oms_team_user_link` VALUES ('123', '3', '5');
INSERT INTO `oms_team_user_link` VALUES ('125', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('127', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('128', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('129', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('130', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('131', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('134', '11', '1');
INSERT INTO `oms_team_user_link` VALUES ('135', '12', '2');
INSERT INTO `oms_team_user_link` VALUES ('136', '13', '3');
INSERT INTO `oms_team_user_link` VALUES ('137', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('138', null, '3');
INSERT INTO `oms_team_user_link` VALUES ('139', '15', '1');
INSERT INTO `oms_team_user_link` VALUES ('140', '18', '1');
INSERT INTO `oms_team_user_link` VALUES ('141', '19', '1');
INSERT INTO `oms_team_user_link` VALUES ('143', '20', '2');
INSERT INTO `oms_team_user_link` VALUES ('144', '21', '2');
INSERT INTO `oms_team_user_link` VALUES ('145', '22', '2');
INSERT INTO `oms_team_user_link` VALUES ('146', '23', '2');
INSERT INTO `oms_team_user_link` VALUES ('147', '24', '2');
INSERT INTO `oms_team_user_link` VALUES ('148', '25', '2');
INSERT INTO `oms_team_user_link` VALUES ('149', '26', '2');
INSERT INTO `oms_team_user_link` VALUES ('150', '27', '2');
INSERT INTO `oms_team_user_link` VALUES ('151', '28', '2');
INSERT INTO `oms_team_user_link` VALUES ('152', '29', '2');
INSERT INTO `oms_team_user_link` VALUES ('153', '30', '2');
INSERT INTO `oms_team_user_link` VALUES ('154', '31', '2');
INSERT INTO `oms_team_user_link` VALUES ('155', null, '4');
INSERT INTO `oms_team_user_link` VALUES ('156', '32', '2');
INSERT INTO `oms_team_user_link` VALUES ('157', '33', '3');
INSERT INTO `oms_team_user_link` VALUES ('158', '35', '3');
INSERT INTO `oms_team_user_link` VALUES ('159', '37', '3');
INSERT INTO `oms_team_user_link` VALUES ('160', '38', '3');
INSERT INTO `oms_team_user_link` VALUES ('161', '36', '4');
INSERT INTO `oms_team_user_link` VALUES ('162', '39', '4');
INSERT INTO `oms_team_user_link` VALUES ('163', '40', '3');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('schedulerFactory', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('schedulerFactory', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactory', 'CTH-E4851590582975055', '1590584615971', '20000');

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for quartz_task_configuration
-- ----------------------------
DROP TABLE IF EXISTS `quartz_task_configuration`;
CREATE TABLE `quartz_task_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auto_run` int(11) NOT NULL,
  `class_full_name` varchar(200) NOT NULL,
  `cron_config` varchar(64) NOT NULL,
  `days` varchar(5) NOT NULL,
  `disabled` int(11) NOT NULL,
  `every_days` int(11) NOT NULL,
  `every_hour` int(11) NOT NULL,
  `every_minute` int(11) NOT NULL,
  `every_month` int(11) NOT NULL,
  `every_seconds` int(11) NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `hour` varchar(5) NOT NULL,
  `ignore_exception_times` int(11) NOT NULL,
  `is_thread` int(11) NOT NULL,
  `minute` varchar(5) NOT NULL,
  `month` varchar(5) NOT NULL,
  `restart_on_exception` int(11) NOT NULL,
  `seconds` varchar(5) NOT NULL,
  `task_name` varchar(50) NOT NULL,
  `week_day` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of quartz_task_configuration
-- ----------------------------

-- ----------------------------
-- Table structure for sys_access_key
-- ----------------------------
DROP TABLE IF EXISTS `sys_access_key`;
CREATE TABLE `sys_access_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_key` longtext NOT NULL,
  `client_id` varchar(128) NOT NULL,
  `disabled` int(11) NOT NULL,
  `expired_date` datetime NOT NULL,
  `name` varchar(128) NOT NULL,
  `start_date` datetime NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_access_key
-- ----------------------------

-- ----------------------------
-- Table structure for sys_account_reset
-- ----------------------------
DROP TABLE IF EXISTS `sys_account_reset`;
CREATE TABLE `sys_account_reset` (
  `user_name` varchar(30) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `expire_date` bigint(20) DEFAULT NULL,
  `reset_key` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_account_reset
-- ----------------------------

-- ----------------------------
-- Table structure for sys_action_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_action_info`;
CREATE TABLE `sys_action_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `icon_color` varchar(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_url` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_action_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ak_module_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_ak_module_link`;
CREATE TABLE `sys_ak_module_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `ak_id` int(11) NOT NULL,
  `module_parttern` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_ak_module_link
-- ----------------------------

-- ----------------------------
-- Table structure for sys_area_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_area_info`;
CREATE TABLE `sys_area_info` (
  `id` int(11) NOT NULL,
  `id_list` varchar(128) NOT NULL,
  `is_leaf` varchar(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `names` longtext NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_area_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_company`;
CREATE TABLE `sys_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(120) NOT NULL,
  `create_time` datetime NOT NULL,
  `email` varchar(120) NOT NULL,
  `mobile_phone` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL,
  `scale_size` int(11) DEFAULT NULL,
  `trade_type` varchar(64) DEFAULT NULL,
  `user_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_company
-- ----------------------------

-- ----------------------------
-- Table structure for sys_company_module_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_company_module_link`;
CREATE TABLE `sys_company_module_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `effective_time` datetime NOT NULL,
  `lease` int(11) NOT NULL,
  `module` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_company_module_link
-- ----------------------------

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

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) DEFAULT NULL,
  `dict_id` int(11) DEFAULT NULL,
  `disabled` int(11) DEFAULT NULL,
  `display_value` varchar(128) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES ('1', 'SIDR_MARRIAGE', '1', null, '夫妻', '1', null);
INSERT INTO `sys_dict_item` VALUES ('2', 'SIDR_CHILDREN', '1', null, '子女', '2', null);
INSERT INTO `sys_dict_item` VALUES ('3', 'SIDR_PARENT', '1', null, '父母', '3', null);
INSERT INTO `sys_dict_item` VALUES ('4', 'SIDR_BROS_AND_SIS', '1', null, '兄弟姐妹', '4', null);
INSERT INTO `sys_dict_item` VALUES ('5', 'SIDR_OTHER', '1', null, '其他', '5', null);
INSERT INTO `sys_dict_item` VALUES ('6', 'SIDO_OFFICER', '2', null, '各级政府部门、企事业单位、党政机关和公众团体的领导者', '1', null);
INSERT INTO `sys_dict_item` VALUES ('7', 'SIDO_PROFESSIONALS', '2', null, '专业技术人员（教师、医生、工程技术人员、作家等专业人员）', '2', null);
INSERT INTO `sys_dict_item` VALUES ('8', 'SIDO_STAFF', '2', null, '职员（从事一般性事务工作的人员）', '3', null);
INSERT INTO `sys_dict_item` VALUES ('9', 'SIDO_BUSINESSMAN', '2', null, '商务人员', '4', null);
INSERT INTO `sys_dict_item` VALUES ('10', 'SIDO_WAITER', '2', null, '第三产业服务人员', '5', null);
INSERT INTO `sys_dict_item` VALUES ('11', 'SIDO_INDUSTRIAL_WORKER', '2', null, '产业工人', '6', null);
INSERT INTO `sys_dict_item` VALUES ('12', 'SIDO_AGRICULTURAL_LABOURER', '2', null, '从事农林牧渔业的劳动者', '7', null);
INSERT INTO `sys_dict_item` VALUES ('13', 'SIDO_HOUSEWIFE', '2', null, '家庭主妇', '8', null);
INSERT INTO `sys_dict_item` VALUES ('14', 'SIDO_STUDENT', '2', null, '学生', '9', null);
INSERT INTO `sys_dict_item` VALUES ('15', 'SIDO_PROPRIETOR', '2', null, '私营企业主', '10', null);
INSERT INTO `sys_dict_item` VALUES ('16', 'SIDO_UNEMPLOYED', '2', null, '失业', '11', null);
INSERT INTO `sys_dict_item` VALUES ('17', 'SIDO_RETIRED', '2', null, '离退休人员', '12', null);
INSERT INTO `sys_dict_item` VALUES ('18', 'SIDO_OTHER', '2', null, '其他', '13', null);
INSERT INTO `sys_dict_item` VALUES ('19', 'SIDI_SPORT', '3', null, '体育', '1', null);
INSERT INTO `sys_dict_item` VALUES ('20', 'SIDI_MILITARY', '3', null, '军事', '2', null);
INSERT INTO `sys_dict_item` VALUES ('21', 'SIDI_TECHNOLOGY', '3', null, '科技', '3', null);
INSERT INTO `sys_dict_item` VALUES ('22', 'SIDI_DIGITAL', '3', null, '数码', '4', null);
INSERT INTO `sys_dict_item` VALUES ('23', 'SIDI_FINANCE', '3', null, '财经', '5', null);
INSERT INTO `sys_dict_item` VALUES ('24', 'SIDI_AUTOMOBILE', '3', null, '汽车', '6', null);
INSERT INTO `sys_dict_item` VALUES ('25', 'SIDI_HOUSE_PROPERTY', '3', null, '房产', '7', null);
INSERT INTO `sys_dict_item` VALUES ('26', 'SIDI_MOVIES', '3', null, '影视', '8', null);
INSERT INTO `sys_dict_item` VALUES ('27', 'SIDI_FASHION', '3', null, '时尚', '9', null);
INSERT INTO `sys_dict_item` VALUES ('28', 'SIDI_GAME', '3', null, '游戏', '10', null);
INSERT INTO `sys_dict_item` VALUES ('29', 'SIDI_ENTERTAINMENT', '3', null, '娱乐', '11', null);
INSERT INTO `sys_dict_item` VALUES ('30', 'SIDI_TRAVEL', '3', null, '旅行', '12', null);
INSERT INTO `sys_dict_item` VALUES ('31', 'SIDOS_NEW', '4', null, '新建', '1', null);
INSERT INTO `sys_dict_item` VALUES ('32', 'SIDOS_RESOLVING', '4', null, '解决中', '2', null);
INSERT INTO `sys_dict_item` VALUES ('33', 'SIDOS_RESOLVED', '4', null, '已解决', '3', null);
INSERT INTO `sys_dict_item` VALUES ('34', 'SIDOS_CLOSED', '4', null, '已关闭', '4', null);
INSERT INTO `sys_dict_item` VALUES ('35', 'SIDOP_LOW', '5', null, '低', '1', null);
INSERT INTO `sys_dict_item` VALUES ('36', 'SIDOP_MIDDLE', '5', null, '中', '2', null);
INSERT INTO `sys_dict_item` VALUES ('37', 'SIDOP_HIGH', '5', null, '高', '3', null);
INSERT INTO `sys_dict_item` VALUES ('38', 'SIDTS_RESOLVING', '6', null, '处理中', '1', null);
INSERT INTO `sys_dict_item` VALUES ('39', 'SIDTS_RESOLVED', '6', null, '已处理', '2', null);
INSERT INTO `sys_dict_item` VALUES ('40', 'SIDOPHT_CREATORDER', '7', null, '新建工单', '1', null);
INSERT INTO `sys_dict_item` VALUES ('41', 'SIDOPHT_ADDTASK', '7', null, '分配任务', '2', null);
INSERT INTO `sys_dict_item` VALUES ('42', 'SIDOPHT_DELETETASK', '7', null, '删除任务', '3', null);
INSERT INTO `sys_dict_item` VALUES ('43', 'SIDOPHT_PROCESSTASK', '7', null, '处理任务', '4', null);
INSERT INTO `sys_dict_item` VALUES ('44', 'SIDOPHT_UPDATESTATUS', '7', null, '更改工单状态', '5', null);
INSERT INTO `sys_dict_item` VALUES ('46', 'SIDG_FEMALE', '8', null, '女', '2', null);
INSERT INTO `sys_dict_item` VALUES ('47', 'SIDG_MALE', '8', null, '男', '1', null);
INSERT INTO `sys_dict_item` VALUES ('48', 'SIDOPROJ_American_EB5', '9', null, '美国EB-5', '1', null);
INSERT INTO `sys_dict_item` VALUES ('49', 'SIDOPROJ_American_EB1', '9', null, '美国EB-1', '2', null);
INSERT INTO `sys_dict_item` VALUES ('50', 'SIDOPROJ_Canada_Quebec', '9', null, '加拿大魁省', '3', null);
INSERT INTO `sys_dict_item` VALUES ('51', 'SIDOPROJ_Canada_Federal', '9', null, '加拿大联邦', '4', null);
INSERT INTO `sys_dict_item` VALUES ('52', 'SIDOPROJ_Canada_NB', '9', null, '加拿大NB省', '5', null);
INSERT INTO `sys_dict_item` VALUES ('53', 'SIDOPROJ_Canada_Sasa', '9', null, '加拿大萨省', '6', null);
INSERT INTO `sys_dict_item` VALUES ('54', 'SIDOPROJ_Canada_PEI', '9', null, '加拿大PEI', '7', null);
INSERT INTO `sys_dict_item` VALUES ('55', 'SIDOPROJ_Canada_MAN', '9', null, '加拿大曼省', '8', null);
INSERT INTO `sys_dict_item` VALUES ('56', 'SIDOPROJ_Australia_188A', '9', null, '澳洲188A', '9', null);
INSERT INTO `sys_dict_item` VALUES ('57', 'SIDOPROJ_Australia_188B', '9', null, '澳洲188B', '10', null);
INSERT INTO `sys_dict_item` VALUES ('58', 'SIDOPROJ_Australia_188C', '9', null, '澳洲188C', '11', null);
INSERT INTO `sys_dict_item` VALUES ('59', 'SIDOPROJ_Australia_132', '9', null, '澳洲132', '12', null);
INSERT INTO `sys_dict_item` VALUES ('60', 'SIDOPROJ_Malta_NationalDebt', '9', null, '马耳他国债', '13', null);
INSERT INTO `sys_dict_item` VALUES ('61', 'SIDOPROJ_Grenada', '9', null, '格林纳达', '14', null);
INSERT INTO `sys_dict_item` VALUES ('62', 'SIDOPROJ_Greece', '9', null, '希腊', '15', null);
INSERT INTO `sys_dict_item` VALUES ('63', 'SIDOPROJ_Cyprus', '9', null, '塞浦路斯', '16', null);
INSERT INTO `sys_dict_item` VALUES ('64', 'SIDPROG_START', '10', null, '开始', '1', null);
INSERT INTO `sys_dict_item` VALUES ('65', 'SIDS_PREPARE', '11', null, '筹备中', '1', null);
INSERT INTO `sys_dict_item` VALUES ('66', 'SIDS_STARTED', '11', null, '进行中', '2', null);
INSERT INTO `sys_dict_item` VALUES ('67', 'SIDS_COMPLETE', '11', null, '已结束', '3', null);
INSERT INTO `sys_dict_item` VALUES ('68', 'SIDOPROJ_Ireland', '9', null, '爱尔兰', '17', null);
INSERT INTO `sys_dict_item` VALUES ('69', 'SIDOPROJ_GuineaBissau', '9', null, '几内亚比绍', '18', null);

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info` (
  `id` varchar(36) NOT NULL,
  `byte_size` bigint(20) NOT NULL,
  `doc_type` varchar(16) NOT NULL,
  `last_update_time` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `uri` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_file_info
-- ----------------------------
INSERT INTO `sys_file_info` VALUES ('4b003794-8574-4902-be8d-2b217b6f533c', '1154', 'png', '2018-01-16 15:05:44', 'book.png', 'D:/smartweb/upload\\\\book.png');
INSERT INTO `sys_file_info` VALUES ('693d5c07-a216-4487-b33d-9c847af4d111', '1273', 'png', '2018-01-08 13:59:58', 'Add_Symbol.png', 'D:/smartweb/upload\\\\Add_Symbol.png');
INSERT INTO `sys_file_info` VALUES ('7583dbeb-ff4b-4cfb-a442-0e56c9701843', '34841', 'png', '2018-01-18 14:22:21', '000 - 副本 (2).png', 'D:/smartweb/upload\\\\000 - 副本 (2).png');
INSERT INTO `sys_file_info` VALUES ('7ba9229e-a0f0-47a5-8654-4c2ef400858d', '2518', 'png', '2018-01-08 13:59:58', 'btnSave.png', 'D:/smartweb/upload\\\\btnSave.png');
INSERT INTO `sys_file_info` VALUES ('9d761165-1609-46c6-be5e-01612d6344fd', '34841', 'png', '2018-01-18 14:22:09', '000.png', 'D:/smartweb/upload\\\\000.png');
INSERT INTO `sys_file_info` VALUES ('bcb76040-b9cc-4abd-8310-f09ea63250fe', '1826', 'png', '2018-01-08 13:59:59', 'Chart_Graph.png', 'D:/smartweb/upload\\\\Chart_Graph.png');
INSERT INTO `sys_file_info` VALUES ('f96cfa16-b87b-43be-b07c-09989a920bc2', '1353', 'png', '2018-01-16 14:51:47', 'anchor.png', 'D:/smartweb/upload\\\\anchor.png');

-- ----------------------------
-- Table structure for sys_form_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_form_template`;
CREATE TABLE `sys_form_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` int(11) DEFAULT NULL,
  `group_id` varchar(20) DEFAULT NULL,
  `html` longtext NOT NULL,
  `html1` longtext,
  `html2` longtext,
  `html_url` varchar(200) DEFAULT NULL,
  `javascript` longtext,
  `js_files` longtext,
  `name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_form_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_class` varchar(200) DEFAULT NULL,
  `log_msg` longtext,
  `log_priority` varchar(32) DEFAULT NULL,
  `log_thread` varchar(32) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  `log_type` varchar(32) DEFAULT NULL,
  `log_username` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_content
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_content`;
CREATE TABLE `sys_msg_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12042 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_msg_content
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_history`;
CREATE TABLE `sys_msg_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `msg_type` int(11) DEFAULT NULL,
  `recv_address` varchar(255) NOT NULL,
  `sender_time` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_msg_history
-- ----------------------------

-- ----------------------------
-- Table structure for sys_msg_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_template`;
CREATE TABLE `sys_msg_template` (
  `id` varchar(64) NOT NULL,
  `app_id` varchar(64) NOT NULL,
  `content` longtext NOT NULL,
  `create_time` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_msg_template
-- ----------------------------
INSERT INTO `sys_msg_template` VALUES ('BirthdayNotify0', 'smartweb', '今天（${date}）是客户 ${customer} 的生日，别忘了送上一声祝福。', '2018-03-28 07:42:16', '生日问候[今日]提醒');
INSERT INTO `sys_msg_template` VALUES ('BirthdayNotify7', 'smartweb', '再过${day}天（${date}）就是客户 ${customer} 的生日了，记得准备礼物哦！', '2018-03-28 07:42:22', '生日问候[提前7天]提醒');
INSERT INTO `sys_msg_template` VALUES ('TimingNotify', 'smartweb', '客户${customer}已经有超过${day}没有拜访过了。', '2018-03-28 07:42:32', '定期拜访提醒');

-- ----------------------------
-- Table structure for sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `sys_organization`;
CREATE TABLE `sys_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) DEFAULT NULL,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `id1` int(11) DEFAULT NULL,
  `id10` int(11) DEFAULT NULL,
  `id11` int(11) DEFAULT NULL,
  `id12` int(11) DEFAULT NULL,
  `id13` int(11) DEFAULT NULL,
  `id14` int(11) DEFAULT NULL,
  `id2` int(11) DEFAULT NULL,
  `id3` int(11) DEFAULT NULL,
  `id4` int(11) DEFAULT NULL,
  `id5` int(11) DEFAULT NULL,
  `id6` int(11) DEFAULT NULL,
  `id7` int(11) DEFAULT NULL,
  `id8` int(11) DEFAULT NULL,
  `id9` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `names` varchar(255) DEFAULT NULL,
  `org_level` int(11) NOT NULL,
  `org_type` varchar(20) NOT NULL,
  `pid` int(11) NOT NULL,
  `show_order` int(11) DEFAULT NULL,
  `orgCode` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_organization
-- ----------------------------
INSERT INTO `sys_organization` VALUES ('1', null, '-1', '2017-12-26 18:49:36', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '侨业', '侨业', '1', 'A', '0', null, 'ORG_VZM04OHJ');
INSERT INTO `sys_organization` VALUES ('2', null, '-1', '2018-02-24 09:39:20', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '客服', '侨业/客服', '2', 'A', '1', null, 'ORG_THMCF07R');
INSERT INTO `sys_organization` VALUES ('3', null, '-1', '2018-02-24 09:39:26', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '文案', '侨业/文案', '2', 'A', '1', null, 'ORG_BCG5ZHT9');
INSERT INTO `sys_organization` VALUES ('4', null, '-1', '2018-02-24 09:39:42', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '顾问', '侨业/顾问', '2', 'A', '1', null, 'ORG_4YU1WSV0');
INSERT INTO `sys_organization` VALUES ('5', null, '-1', '2018-02-24 09:39:47', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '市场', '侨业/市场', '2', 'A', '1', null, 'ORG_UO0QH72W');
INSERT INTO `sys_organization` VALUES ('6', null, '-1', '2018-02-24 09:39:55', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '行政', '侨业/行政', '2', 'A', '1', null, 'ORG_4S5CFZZB');

-- ----------------------------
-- Table structure for sys_org_user_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_user_link`;
CREATE TABLE `sys_org_user_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_org` int(11) DEFAULT NULL,
  `manager_level` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_org_user_link
-- ----------------------------
INSERT INTO `sys_org_user_link` VALUES ('23', '1', '0', '1', '20');

-- ----------------------------
-- Table structure for sys_password_backup
-- ----------------------------
DROP TABLE IF EXISTS `sys_password_backup`;
CREATE TABLE `sys_password_backup` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  `user_pwd` varchar(80) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_password_backup
-- ----------------------------

-- ----------------------------
-- Table structure for sys_password_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_password_history`;
CREATE TABLE `sys_password_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `current_pwd` varchar(255) DEFAULT NULL,
  `last_update_time` datetime NOT NULL,
  `previous_pwd` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `validate_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_password_history
-- ----------------------------
INSERT INTO `sys_password_history` VALUES ('1', 'E10ADC3949BA59ABBE56E057F20F883E', '2017-12-26 19:33:02', 'D8DFD83550244F338C8EB017804C2205', '2', '1513474047610');
INSERT INTO `sys_password_history` VALUES ('2', 'E10ADC3949BA59ABBE56E057F20F883E', '2017-12-27 14:58:27', '5B57AEFDF980B3E7FC38DC2F01F10192', '3', '1513543971955');
INSERT INTO `sys_password_history` VALUES ('3', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-01-11 16:38:19', 'C6BE854F3A77804FB1ED538E871B7B2D', '5', '1514845964334');
INSERT INTO `sys_password_history` VALUES ('4', 'A42C9E10C630FFC91435D9167B4746B5', '2018-02-08 15:55:38', '80EBE253B6680AD47BB835E3DBFD5BBF', '15', '1517262603575');
INSERT INTO `sys_password_history` VALUES ('5', '8B139C28AE6BA69BF15BE9FE424B3C38', '2018-02-24 09:46:41', 'DBDEE78DFAB2E2099F6EB0F671E12942', '18', '1518622866884');
INSERT INTO `sys_password_history` VALUES ('6', 'DBBF17FCF91DD82AACA2EACFCC6F5E00', '2018-02-24 10:03:36', '80EBE253B6680AD47BB835E3DBFD5BBF', '19', '1518623881702');
INSERT INTO `sys_password_history` VALUES ('7', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-28 07:10:41', '1BDED42A1FF437EA7259880AAD94ED82', '20', '1521378305993');
INSERT INTO `sys_password_history` VALUES ('8', 'C3790C8FDF2936328979761DC09FEB69', '2018-03-28 13:22:12', '3E73D3D1294BA1EBC44A021A29AB2A66', '21', '1521400597481');
INSERT INTO `sys_password_history` VALUES ('9', '993984DB378EFCE4A4F1F7A762AC690F', '2018-03-28 13:22:17', 'F06B5399D5A3989227018C30C5919B46', '22', '1521400602403');
INSERT INTO `sys_password_history` VALUES ('10', '5EA3E66F8AC87EC4C66E84636233BE92', '2018-03-28 13:23:09', 'E9C35040825AF8753A3524AA9F2CBAF7', '25', '1521400654076');
INSERT INTO `sys_password_history` VALUES ('11', 'E193685F448424CBD6409C98FF77D8E7', '2018-03-28 13:29:37', '5C1EF954A8CAD2290536FF9B679C1DC0', '28', '1521401042569');
INSERT INTO `sys_password_history` VALUES ('12', '08AC0F986AD0FABB3CA8CE8C494412A0', '2018-03-28 13:30:41', 'E670E8DC077D14D437E2F08F26560AEF', '30', '1521401106267');
INSERT INTO `sys_password_history` VALUES ('13', '70B479DDA66B9B4BD6AB4E1746D78ACA', '2018-03-28 13:31:26', 'EB0284B857EA2465D6D85FD1CD377E7C', '27', '1521401151488');
INSERT INTO `sys_password_history` VALUES ('14', 'DEDC38E1C9B0DD7C66A86236DD680BB6', '2018-03-28 13:33:45', 'AE1B8AAF52AEE144D4B2B1D960BDA65D', '26', '1521401289915');
INSERT INTO `sys_password_history` VALUES ('15', '38D6D3305B37011B670DD2D1D20F1E30', '2018-03-28 13:33:46', 'C82A18E5220D46CD8F2D23787134FCF3', '24', '1521401291387');
INSERT INTO `sys_password_history` VALUES ('16', '9C6361E040E31947556666880C303B7B', '2018-03-28 14:03:04', '55E1C554AA6F762DF902B07C02F33A46', '32', '1521403048953');
INSERT INTO `sys_password_history` VALUES ('17', '1FAF52A6DF535B853756293DD8934834', '2018-03-28 14:15:52', '9020EE7B833AF5CA2B284A3144C48D50', '39', '1521403817819');
INSERT INTO `sys_password_history` VALUES ('18', 'AC158F5D17FF6E5ED0BEB9619CB5CF87', '2018-03-28 15:08:00', 'DF677B88EBFA11C6B0B1B04D2F8DDA97', '38', '1521406945721');
INSERT INTO `sys_password_history` VALUES ('19', 'A261B228F82C0AF6C33E86A23B5586F3', '2018-03-28 15:09:56', 'DA0FAC6E2B58F07D09A5A3246D098B9C', '35', '1521407061847');
INSERT INTO `sys_password_history` VALUES ('20', '092ECA08C96B42FA828AC0AD4C6B9BF9', '2018-04-08 10:54:14', '80EBE253B6680AD47BB835E3DBFD5BBF', '19', '1522342119220');
INSERT INTO `sys_password_history` VALUES ('21', '510CBC7249B348A0078FB21C0E9E4DD5', '2018-04-09 14:17:38', '0450F305CBBB6E60AA22AFE9B68F59CC', '41', '1522440723754');

-- ----------------------------
-- Table structure for sys_record_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_record_history`;
CREATE TABLE `sys_record_history` (
  `id` int(11) NOT NULL,
  `occur_time` datetime NOT NULL,
  `person_name` varchar(64) NOT NULL,
  `record_id` varchar(128) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `ver` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_record_history
-- ----------------------------

-- ----------------------------
-- Table structure for sys_record_history_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_record_history_detail`;
CREATE TABLE `sys_record_history_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `column_name` varchar(64) NOT NULL,
  `data_type` varchar(64) NOT NULL,
  `is_changed` int(11) NOT NULL,
  `new_value` longtext NOT NULL,
  `old_value` longtext NOT NULL,
  `record_history_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_record_history_detail
-- ----------------------------

-- ----------------------------
-- Table structure for sys_register_apply
-- ----------------------------
DROP TABLE IF EXISTS `sys_register_apply`;
CREATE TABLE `sys_register_apply` (
  `id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `user_info` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_register_apply
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `disabled` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `role_code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_jqdita2l45v2gglry7bp8kl1f` (`role_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '-1', '处理系统后台设置等操作', '0', '系统管理员', 'SYS_ROLE_ADMIN');
INSERT INTO `sys_role` VALUES ('2', '-1', '业务管理', '0', '业务管理员', 'APP_ROLE_ADMIN');
INSERT INTO `sys_role` VALUES ('3', '-1', '任务受理人', '0', '任务受理人', 'APP_TASK_OPER');

-- ----------------------------
-- Table structure for sys_role_action_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_action_link`;
CREATE TABLE `sys_role_action_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) DEFAULT NULL,
  `action_url` longtext,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_action_link
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_bpm_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_bpm_link`;
CREATE TABLE `sys_role_bpm_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpm_key` varchar(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `bpm_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_bpm_link
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu_link`;
CREATE TABLE `sys_role_menu_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_menu_link
-- ----------------------------
INSERT INTO `sys_role_menu_link` VALUES ('11', '2', '3');
INSERT INTO `sys_role_menu_link` VALUES ('12', '5', '3');
INSERT INTO `sys_role_menu_link` VALUES ('27', '1', '2');
INSERT INTO `sys_role_menu_link` VALUES ('28', '2', '2');
INSERT INTO `sys_role_menu_link` VALUES ('30', '4', '2');
INSERT INTO `sys_role_menu_link` VALUES ('31', '5', '2');
INSERT INTO `sys_role_menu_link` VALUES ('38', '16', '2');
INSERT INTO `sys_role_menu_link` VALUES ('39', '18', '2');
INSERT INTO `sys_role_menu_link` VALUES ('40', '20', '2');
INSERT INTO `sys_role_menu_link` VALUES ('41', '20', '2');

-- ----------------------------
-- Table structure for sys_role_user_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user_link`;
CREATE TABLE `sys_role_user_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_default` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_user_link
-- ----------------------------
INSERT INTO `sys_role_user_link` VALUES ('1', '1', '1', '1');
INSERT INTO `sys_role_user_link` VALUES ('19', '0', '1', '20');
INSERT INTO `sys_role_user_link` VALUES ('20', '0', '2', '20');
INSERT INTO `sys_role_user_link` VALUES ('21', '0', '3', '20');

-- ----------------------------
-- Table structure for sys_setting
-- ----------------------------
DROP TABLE IF EXISTS `sys_setting`;
CREATE TABLE `sys_setting` (
  `id` varchar(64) NOT NULL,
  `data_type` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `group_name` varchar(32) NOT NULL,
  `json_data` longtext,
  `order_no` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `allow_edit` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_setting
-- ----------------------------
INSERT INTO `sys_setting` VALUES ('app.id', '0', '系统ID', '01-系统参数', null, '0', 'smartweb', '1');
INSERT INTO `sys_setting` VALUES ('auth.admin.menu.json.enabled', '2', '系统管理菜单', '04-权限验证', '[{\"id\":1,\"text\":\"使用角色配置菜单\"},{\"id\":0,\"text\":\"使用特定文件\"}]', '14', '1', '1');
INSERT INTO `sys_setting` VALUES ('auth.cas.login', '2', '认证方式', '04-权限验证', '[{\"id\":1,\"text\":\"统一认证\"},{\"id\":0,\"text\":\"本地认证\"}]', '1', '0', '1');
INSERT INTO `sys_setting` VALUES ('auth.check', '2', '验证权限', '04-权限验证', '[{\"id\":1,\"text\":\"开启验证模式\"},{\"id\":0,\"text\":\"关闭验证模式\"}]', '0', '0', '1');
INSERT INTO `sys_setting` VALUES ('auth.check.url.suffix', '3', '验证URL规则', '04-权限验证', '[{\"id\":\".jsp\",\"text\":\"JSP页面\"},{\"id\":\".html\",\"text\":\"纯HTML页面\"},{\"id\":\".do\",\"text\":\"Action请求\"}]', '9', '.jsp,.html,.do', '1');
INSERT INTO `sys_setting` VALUES ('auth.exclude.check.path.prefix', '0', 'URL模式白名单', '04-权限验证', '', '10', 'utility/*/*', '1');
INSERT INTO `sys_setting` VALUES ('auth.exclude.check.url.list', '0', '请求白名单', '04-权限验证', '', '11', 'dashboard.do', '1');
INSERT INTO `sys_setting` VALUES ('auth.jsp.url.disabled', '2', '是否禁止直接访问JSP', '04-权限验证', '[{\"id\":1,\"text\":\"禁止访问JSP\"},{\"id\":0,\"text\":\"允许访问JSP\"}]', '12', '0', '1');
INSERT INTO `sys_setting` VALUES ('auth.url', '0', '登录入口地址', '04-权限验证', '', '4', 'login.html', '1');
INSERT INTO `sys_setting` VALUES ('auth.user.online.max.count', '1', '系统最大在线用户数量', '04-权限验证', '', '7', '0', '1');
INSERT INTO `sys_setting` VALUES ('auth.user.remote.validate.service', '0', '统一认证服务地址', '04-权限验证', '', '2', '', '1');
INSERT INTO `sys_setting` VALUES ('auth.user.session.limit', '1', '单个用户最大客户端数量', '04-权限验证', '', '5', '0', '1');
INSERT INTO `sys_setting` VALUES ('auth.user.session.logout.on.more', '2', '单用户超限处理方式', '04-权限验证', '[{\"id\":\"false\",\"text\":\"不处理\"},{\"id\":\"true\",\"text\":\"注销第一个客户端\"}]', '8', 'true', '1');
INSERT INTO `sys_setting` VALUES ('email.reciever.sysadmin.email', '0', '接收消息的管理员邮箱', '13-消息服务', '', '5', '', '1');
INSERT INTO `sys_setting` VALUES ('email.sender.password', '0', '邮件密码', '13-消息服务', '', '3', '1903Qyyms', '1');
INSERT INTO `sys_setting` VALUES ('email.sender.username', '0', '邮件账户名', '13-消息服务', '', '2', 'service@immvisa.com.cn', '1');
INSERT INTO `sys_setting` VALUES ('email.server.host', '0', '服务器地址', '13-消息服务', '', '0', 'smtp.exmail.qq.com', '1');
INSERT INTO `sys_setting` VALUES ('email.server.port', '1', '服务器端口', '13-消息服务', '', '1', '465', '1');
INSERT INTO `sys_setting` VALUES ('file.client.access.key', '0', '文件客户端免登陆密钥', '11-文件存储', null, '1', 'U01BUlRXRUI=-Mw==-MTcwMA==-MTcwMw==', '1');
INSERT INTO `sys_setting` VALUES ('file.server.host', '0', '文件服务地址', '11-文件存储', null, '0', 'http://localhost:8080/SmartDev', '1');
INSERT INTO `sys_setting` VALUES ('login.code.send.mode', '2', '验证码发送方式', '03-登录验证', '[{\"id\":\"email\",\"text\":\"邮件\"},{\"id\":\"phone\",\"text\":\"短信\"}]', '1', 'email', '1');
INSERT INTO `sys_setting` VALUES ('login.validate.mode', '2', '登录验证方式', '03-登录验证', '[{\"id\":0,\"text\":\"密码\"},{\"id\":1,\"text\":\"验证码\"},{\"id\":2,\"text\":\"密码与验证码\"}]', '0', '0', '1');
INSERT INTO `sys_setting` VALUES ('message.client.access.key', '0', '信息客户端免登陆密钥', '10-信息推送', null, '1', 'U01BUlRXRUI=-Mw==-MTcwMA==-MTcwMw==', '1');
INSERT INTO `sys_setting` VALUES ('message.service.url', '0', '信息服务发送地址', '10-信息推送', null, '0', 'http://localhost/SmartInfo', '1');
INSERT INTO `sys_setting` VALUES ('redis.host', '0', 'redis服务器地址', '05-Session缓存服务器参数', '', '0', '127.0.0.1', '1');
INSERT INTO `sys_setting` VALUES ('redis.password', '0', 'redis密码', '05-Session缓存服务器参数', '', '2', 'smartweb', '1');
INSERT INTO `sys_setting` VALUES ('redis.port', '1', 'redis服务器端口', '05-Session缓存服务器参数', '', '1', '6379', '1');
INSERT INTO `sys_setting` VALUES ('redis.timeout', '0', 'redis超时时间', '05-Session缓存服务器参数', '', '3', '20000', '1');
INSERT INTO `sys_setting` VALUES ('rmi.service.start', '2', 'RMI', '90-远程调用', '[{\"id\":1,\"text\":\"启用\"},{\"id\":0,\"text\":\"停用\"}]', '0', '0', '1');
INSERT INTO `sys_setting` VALUES ('scheduler.start', '2', '定时任务', '06-定时任务参数', '[{\"id\":\"true\",\"text\":\"开启\"},{\"id\":\"false\",\"text\":\"关闭\"}]', '0', 'true', '1');
INSERT INTO `sys_setting` VALUES ('smart.action.parameter.encrypt.class', '0', '解密算法', '02-HTTP参数加密', '', '1', 'com.smartframework.web.core.encryptor.Base64ParaEncryptor', '1');
INSERT INTO `sys_setting` VALUES ('smart.action.parameter.encrypted', '2', '参数加密', '02-HTTP参数加密', '[{\"id\":\"true\",\"text\":\"开启\"},{\"id\":\"false\",\"text\":\"关闭\"}]', '0', 'true', '1');
INSERT INTO `sys_setting` VALUES ('smart.action.parameter.failed.method', '2', '参数验证失败处理方法', '02-HTTP参数加密', '[{\"id\":0,\"text\":\"忽略\"},{\"id\":1,\"text\":\"异常提醒\"},{\"id\":2,\"text\":\"置为NULL\"}]', '4', '0', '1');
INSERT INTO `sys_setting` VALUES ('smart.action.parameter.validator', '0', '参数注入验证', '02-HTTP参数加密', null, '2', 'com.smartframework.web.core.filter.ParameterInjectValidator', '1');
INSERT INTO `sys_setting` VALUES ('smart.action.parameter.validator.pwd', '0', '密码传输验证算法', '02-HTTP参数加密', null, '3', 'com.smartframework.web.core.filter.PasswordSafeValidator', '1');
INSERT INTO `sys_setting` VALUES ('smartSecurityFilter.class', '0', '权限过滤器定义类', '04-权限验证', '', '12', 'com.smartframework.web.system.index.filter.PermissionFilter', '1');
INSERT INTO `sys_setting` VALUES ('smartweb.system.upload.accepts', '3', '文件上传接受类型', '07-文件上传配置', '[{\"id\":\"doc\",\"text\":\"Word 97-2003文档\"},{\"id\":\"docx\",\"text\":\"Word文档\"},{\"id\":\"xls\",\"text\":\"Excel 97-2003工作簿\"},{\"id\":\"xls\",\"text\":\"Excel工作簿\"},{\"id\":\"pdf\",\"text\":\"pdf文档\"},{\"id\":\"png\",\"text\":\"png图片\"},{\"id\":\"jpeg\",\"text\":\"jpeg图片\"}]', '0', 'doc,docx,xls,xlsx,pdf,png,jpeg', '1');
INSERT INTO `sys_setting` VALUES ('smartweb.system.upload.location', '0', '文件上传位置', '07-文件上传配置', '', '1', 'D:/smartweb/upload', '1');
INSERT INTO `sys_setting` VALUES ('smartweb.system.upload.tmp', '0', '文件上传临时文件夹', '07-文件上传配置', '', '2', 'D:/smartweb/upload/tmp', '1');
INSERT INTO `sys_setting` VALUES ('system.message.service.impl', '0', '验证码发送服务类全名', '13-消息服务', '', '4', 'com.smartframework.test.utils.TestValidateSenderService', '1');
INSERT INTO `sys_setting` VALUES ('system.pageindex.start', '2', '前端表格起始页序号', '01-系统参数', '[{\"id\":0,\"text\":\"从0开始\"},{\"id\":1,\"text\":\"从1开始\"}]', '2', '1', '1');
INSERT INTO `sys_setting` VALUES ('system.user.extra.delete', '0', '用户扩展删除方法', '12-用户表配置', '', '2', '', '1');
INSERT INTO `sys_setting` VALUES ('system.user.extra.list', '0', '用户表扩展表', '12-用户表配置', '', '0', '', '1');
INSERT INTO `sys_setting` VALUES ('system.user.extra.save', '0', '用户扩展保存接口', '12-用户表配置', '', '1', '', '1');
INSERT INTO `sys_setting` VALUES ('system.user.noaccess.jsp.folders', '0', '禁止访问的jsp目录', '04-权限验证', '', '13', 'system,workflow,test,designer', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.backup.enable', '2', '用户密码备份', '08-用户密码配置', '[{\"id\":\"true\",\"text\":\"启用\"},{\"id\":\"false\",\"text\":\"关闭\"}]', '6', 'false', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.compare.times', '1', '密码尝试次数', '08-用户密码配置', '', '1', '', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.encrypt.class', '0', '用户密码加密算法', '08-用户密码配置', '', '2', 'com.smartframework.web.core.encryptor.MD5Encryptor', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.length.max', '1', '用户密码最大长度', '08-用户密码配置', '', '5', '16', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.length.min', '1', '用户密码最小长度', '08-用户密码配置', '', '4', '6', '1');
INSERT INTO `sys_setting` VALUES ('system.user.password.validate.rules', '2', '用户密码验证规则', '08-用户密码配置', '[{\"id\":0,\"text\":\"不为空\"},{\"id\":1,\"text\":\"仅验证长度\"},{\"id\":2,\"text\":\"验证字符组成与长度\"}]', '3', '1', '1');
INSERT INTO `sys_setting` VALUES ('system.validate.code.charset', '0', '字符集', '09-验证码参数', '', '1', '0123456789', '1');
INSERT INTO `sys_setting` VALUES ('system.validate.code.enabled', '2', '验证码功能', '09-验证码参数', '[{\"id\":1,\"text\":\"启用\"},{\"id\":0,\"text\":\"关闭\"}]', '0', '0', '1');
INSERT INTO `sys_setting` VALUES ('system.validate.code.expire.min', '1', '验证码有效时间(分钟)', '03-登录验证', '', '1', '3', '1');
INSERT INTO `sys_setting` VALUES ('system.validate.code.length', '2', '验证码长度', '09-验证码参数', '[{\"id\":4,\"text\":\"4位\"},{\"id\":6,\"text\":\"6位\"}]', '2', '6', '1');
INSERT INTO `sys_setting` VALUES ('system.validate.code.template', '0', '验证码模板标识符', '09-验证码参数', null, '3', 'smartweb-code', '1');

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
INSERT INTO `sys_url_menu` VALUES ('20', null, '-1', '0', 'fa-sun-o', '#16A5A5', '活动管理', '4', '0', '1', '0', '');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) DEFAULT NULL,
  `real_name` varchar(32) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL COMMENT '用户类型',
  `company_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `delete_time` datetime DEFAULT NULL,
  `deleted` int(11) NOT NULL,
  `disabled` int(11) NOT NULL,
  `email` varchar(60) NOT NULL,
  `home_url` varchar(50) DEFAULT NULL,
  `image_location` varchar(50) DEFAULT NULL,
  `password` varchar(80) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `serial_no` varchar(30) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `expired_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ahtq5ew3v0kt1n7hf1sgp7p8l` (`email`),
  UNIQUE KEY `UK_pulp17fvich5aby4m0kc820h6` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '系统超级管理员', '0', '-1', '2017-12-26 18:22:48', null, '0', '0', 'fm0517@126.com', 'admin.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '13451906026', null, '0', null);
INSERT INTO `sys_user` VALUES ('2', 'userA%2', '测试用户A', '100', '-1', '2017-12-26 18:50:37', '2018-02-08 15:53:58', '1', '0', 'userA@126.com%2', 'index.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '13613613666%2', null, '0', null);
INSERT INTO `sys_user` VALUES ('3', 'userB%3', '测试用户B', '100', '-1', '2017-12-27 14:57:29', '2018-02-08 15:53:58', '1', '0', '15651722230@163.com%3', 'index.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '15651722230%3', null, '0', null);
INSERT INTO `sys_user` VALUES ('4', 'zhangsan%4', '张三', '100', '-1', '2017-12-27 15:50:54', '2018-02-08 15:43:22', '1', '0', '267226590@qq.com%4', 'index.jsp', 'resources/images/user.png', '0D15FD68507601E1361893E2751BEFBC', '15950538042%4', null, '0', null);
INSERT INTO `sys_user` VALUES ('5', 'lisi%5', '李四', '100', '-1', '2017-12-27 15:52:54', '2018-02-08 15:53:58', '1', '0', 'lisi@126.com%5', 'index.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '15911111111%5', null, '0', null);
INSERT INTO `sys_user` VALUES ('11', 'empA%11', '员工甲', '-1', '-1', '2018-02-02 15:57:02', '2018-02-08 15:53:58', '1', '0', 'empA@126.com%11', '', 'resources/images/user.png', '5E71C743803F50CFD702187295CED5B3', '13345656789%11', null, '0', null);
INSERT INTO `sys_user` VALUES ('12', 'empB%12', '员工乙', '100', '-1', '2018-01-30 10:05:53', '2018-02-08 15:53:58', '1', '0', 'empB@126.com%12', 'index.jsp', 'resources/images/user.png', '177CB96B0EB32525F11192936207DAB9', '13423456789%12', null, '0', null);
INSERT INTO `sys_user` VALUES ('13', 'empC%13', '员工丙', '100', '-1', '2018-01-30 10:06:14', '2018-02-08 15:53:58', '1', '0', 'empC@126.com%13', 'index.jsp', 'resources/images/user.png', 'F6273AFBFE373459D8C9BD7AD40923FD', '13523456789%13', null, '0', null);
INSERT INTO `sys_user` VALUES ('14', 'cth%14', '陈天皓', '100', '-1', '2018-02-08 15:48:59', '2018-02-24 09:29:34', '1', '0', 'chenth0517@126.com%14', 'index.jsp', 'resources/images/user.png', '1922D2FCE057FAAA01D14F5BA053C913', '13655179594%14', null, '0', null);
INSERT INTO `sys_user` VALUES ('15', 'wangxin%15', '王欣', '100', '-1', '2018-02-08 15:51:35', '2018-02-24 09:37:13', '1', '0', '304531998@qq.com%15', 'index.jsp', 'resources/images/user.png', 'A42C9E10C630FFC91435D9167B4746B5', '13515112826%15', null, '0', null);
INSERT INTO `sys_user` VALUES ('16', 'zhenglei%16', '郑蕾', '100', '-1', '2018-02-24 09:36:45', '2018-02-24 09:41:52', '1', '0', '819557068@qq.com%16', 'index.jsp', 'resources/images/user.png', 'DBDEE78DFAB2E2099F6EB0F671E12942', '15195923026%16', null, '0', null);
INSERT INTO `sys_user` VALUES ('17', 'wangxin%17', '王欣', '100', '-1', '2018-02-24 09:37:36', '2018-02-24 09:41:52', '1', '0', '304531998@qq.com%17', 'index.jsp', 'resources/images/user.png', '80EBE253B6680AD47BB835E3DBFD5BBF', '13515112826%17', null, '0', null);
INSERT INTO `sys_user` VALUES ('18', 'zhenglei%18', '郑蕾', '100', '-1', '2018-02-24 09:42:42', '2020-05-27 21:00:22', '1', '0', '819557068@qq.com%18', 'index.jsp', 'resources/images/user.png', '8B139C28AE6BA69BF15BE9FE424B3C38', '15195923026%18', null, '0', null);
INSERT INTO `sys_user` VALUES ('19', 'wangxin%19', '王欣', '100', '-1', '2018-02-24 09:43:26', '2020-05-27 21:00:22', '1', '0', '304531998@qq.com%19', 'index.jsp', 'resources/images/user.png', '092ECA08C96B42FA828AC0AD4C6B9BF9', '13515112826%19', null, '0', null);
INSERT INTO `sys_user` VALUES ('20', 'chenth', '陈天皓', '100', '-1', '2018-03-28 07:10:04', null, '0', '0', 'chenth0517@126.com', 'index.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '13312312345', null, '0', null);
INSERT INTO `sys_user` VALUES ('21', 'fangxiaomin%21', '方小敏', '100', '-1', '2018-03-28 13:17:04', '2020-05-27 21:00:22', '1', '0', '1820005690@QQ.com%21', 'index.jsp', 'resources/images/user.png', 'C3790C8FDF2936328979761DC09FEB69', '18951842079%21', null, '0', null);
INSERT INTO `sys_user` VALUES ('22', 'zhangmei%22', '张玫', '100', '-1', '2018-03-28 13:19:15', '2020-05-27 21:00:22', '1', '0', '70522617@qq.com%22', 'index.jsp', 'resources/images/user.png', '993984DB378EFCE4A4F1F7A762AC690F', '13515125079%22', null, '0', null);
INSERT INTO `sys_user` VALUES ('23', 'niululu%23', '牛璐璐', '100', '-1', '2018-03-28 13:20:10', '2020-05-27 21:00:22', '1', '0', '2799361682@qq.com%23', 'index.jsp', 'resources/images/user.png', '559F333739D88E424CF9CB8122AC1C78', '15077821776%23', null, '0', null);
INSERT INTO `sys_user` VALUES ('24', 'quyuanzhuo%24', '屈远卓', '100', '-1', '2018-03-28 13:21:45', '2020-05-27 21:00:22', '1', '0', '398164017@qq.com%24', 'index.jsp', 'resources/images/user.png', '38D6D3305B37011B670DD2D1D20F1E30', '15151840128%24', null, '0', null);
INSERT INTO `sys_user` VALUES ('25', 'zhaoyanli%25', '赵艳丽', '100', '-1', '2018-03-28 13:22:30', '2020-05-27 21:00:22', '1', '0', '172454225@qq.com%25', 'index.jsp', 'resources/images/user.png', '5EA3E66F8AC87EC4C66E84636233BE92', '15951666365%25', null, '0', null);
INSERT INTO `sys_user` VALUES ('26', 'guanjingjing%26', '管晶晶', '100', '-1', '2018-03-28 13:23:43', '2020-05-27 21:00:22', '1', '0', '1316103497@qq.com%26', 'index.jsp', 'resources/images/user.png', 'DEDC38E1C9B0DD7C66A86236DD680BB6', '18751856874%26', null, '0', null);
INSERT INTO `sys_user` VALUES ('27', 'zhuhuihui%27', '朱慧慧', '100', '-1', '2018-03-28 13:24:47', '2020-05-27 21:00:22', '1', '0', '316244884@qq.com%27', 'index.jsp', 'resources/images/user.png', '70B479DDA66B9B4BD6AB4E1746D78ACA', '13357839915%27', null, '0', null);
INSERT INTO `sys_user` VALUES ('28', 'zhangtongtong%28', '张同同', '100', '-1', '2018-03-28 13:25:41', '2020-05-27 21:00:22', '1', '0', '969390063@qq.com%28', 'index.jsp', 'resources/images/user.png', 'E193685F448424CBD6409C98FF77D8E7', '15261451031%28', null, '0', null);
INSERT INTO `sys_user` VALUES ('29', 'zhuyali%29', '朱雅丽', '100', '-1', '2018-03-28 13:26:58', '2020-05-27 21:00:22', '1', '0', '1942923788@qq.com%29', 'index.jsp', 'resources/images/user.png', '92D3D25923E1199E3D229D781622A191', '18761956146%29', null, '0', null);
INSERT INTO `sys_user` VALUES ('30', 'shenming%30', '沈明', '100', '-1', '2018-03-28 13:27:28', '2020-05-27 21:00:22', '1', '0', 'iris@immvisa.com.cn%30', 'index.jsp', 'resources/images/user.png', '08AC0F986AD0FABB3CA8CE8C494412A0', '13813935254%30', null, '0', null);
INSERT INTO `sys_user` VALUES ('31', 'zhuying%31', '朱莹', '100', '-1', '2018-03-28 13:28:00', '2020-05-27 21:00:22', '1', '0', 'winnie@immvisa.com.cn%31', 'index.jsp', 'resources/images/user.png', '31BEAB2B0BE47DA95AFCD87B7BC0FB09', '13813962008%31', null, '0', null);
INSERT INTO `sys_user` VALUES ('32', 'wuyanyun%32', '武雁云', '100', '-1', '2018-03-28 13:41:10', '2020-05-27 21:00:22', '1', '0', '1521238747@qq.com%32', 'index.jsp', 'resources/images/user.png', '9C6361E040E31947556666880C303B7B', '13585202587%32', null, '0', null);
INSERT INTO `sys_user` VALUES ('33', 'dongxiaoxiao%33', '董晓晓', '100', '-1', '2018-03-28 13:50:55', '2018-03-28 13:55:57', '1', '0', '2724015248@qq.com%33', 'index.jsp', 'resources/images/user.png', 'DA0FAC6E2B58F07D09A5A3246D098B9C', '13151072669%33', null, '0', null);
INSERT INTO `sys_user` VALUES ('34', 'shijing%34', '史靖', '100', '-1', '2018-03-28 13:51:53', '2018-03-28 13:55:57', '1', '0', '411630187@qq.com%34', 'index.jsp', 'resources/images/user.png', 'C84661F104EF1ACC3C9DB3E0C4D1386D', '18652039270%34', null, '0', null);
INSERT INTO `sys_user` VALUES ('35', 'dongxiaoxiao%35', '董晓晓', '100', '-1', '2018-03-28 13:56:40', '2020-05-27 21:00:22', '1', '0', '2724015248@qq.com%35', 'index.jsp', 'resources/images/user.png', 'A261B228F82C0AF6C33E86A23B5586F3', '13151072669%35', null, '0', null);
INSERT INTO `sys_user` VALUES ('36', 'shijing%36', '史靖', '100', '-1', '2018-03-28 13:57:20', '2020-05-27 21:00:22', '1', '0', '411630187@qq.com%36', 'index.jsp', 'resources/images/user.png', 'C84661F104EF1ACC3C9DB3E0C4D1386D', '18652039270%36', null, '0', null);
INSERT INTO `sys_user` VALUES ('37', 'shixiaona%37', '史晓娜', '100', '-1', '2018-03-28 13:58:10', '2020-05-27 21:00:22', '1', '0', '70325831@qq.com%37', 'index.jsp', 'resources/images/user.png', '82DE524ADA859964434E3855402DD196', '13770796668%37', null, '0', null);
INSERT INTO `sys_user` VALUES ('38', 'tangkeqin%38', '汤克琴', '100', '-1', '2018-03-28 13:58:52', '2020-05-27 21:00:22', '1', '0', '747377663@qq.com%38', 'index.jsp', 'resources/images/user.png', 'AC158F5D17FF6E5ED0BEB9619CB5CF87', '13675152282%38', null, '0', null);
INSERT INTO `sys_user` VALUES ('39', 'jinna%39', '金娜', '100', '-1', '2018-03-28 13:59:55', '2020-05-27 21:00:22', '1', '0', '836493224@qq.com%39', 'index.jsp', 'resources/images/user.png', '1FAF52A6DF535B853756293DD8934834', '13813984964%39', null, '0', null);
INSERT INTO `sys_user` VALUES ('40', 'chenlu%40', '陈璐', '100', '-1', '2018-03-28 14:06:42', '2020-05-27 21:00:22', '1', '0', '75358159@qq.com%40', 'index.jsp', 'resources/images/user.png', '5B09F3081887C862CC421011022ED259', '15077861694%40', null, '0', null);
INSERT INTO `sys_user` VALUES ('41', 'yuankaihong%41', '袁开弘', '100', '-1', '2018-03-30 13:19:27', '2020-05-27 21:00:22', '1', '0', '1595789242@qq.com%41', 'index.jsp', 'resources/images/user.png', '510CBC7249B348A0078FB21C0E9E4DD5', '15951899247%41', null, '0', null);
INSERT INTO `sys_user` VALUES ('42', 'linfangzhou%42', '林方舟', '100', '-1', '2018-07-17 09:47:06', '2020-05-27 21:00:22', '1', '0', '15766664@qq.com%42', 'index.jsp', 'resources/images/user.png', '69C055CBB9C7A8858426FB56A195040C', '13400057689%42', null, '0', null);

-- ----------------------------
-- Table structure for sys_user_action_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_action_link`;
CREATE TABLE `sys_user_action_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` varchar(64) NOT NULL,
  `role_code` varchar(64) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_action_link
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_bookmark`;
CREATE TABLE `sys_user_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookmark_alias` varchar(255) NOT NULL,
  `bookmark_url` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_locked
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_locked`;
CREATE TABLE `sys_user_locked` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `error_count` int(11) DEFAULT NULL,
  `error_time` bigint(20) DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `locked_time` bigint(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hdh6waxvfuigad2ieo8gwif6n` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_locked
-- ----------------------------

-- ----------------------------
-- Table structure for test_main
-- ----------------------------
DROP TABLE IF EXISTS `test_main`;
CREATE TABLE `test_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_main
-- ----------------------------
