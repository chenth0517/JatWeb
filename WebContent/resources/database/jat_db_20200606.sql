/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : jat_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-06-06 20:29:38
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
INSERT INTO `activity` VALUES ('8', '安全用品', null, '2020-06-01 14:00:00', null, '劳保用品采购基地', '南京市网巾市123号', '18', '3280.00', '67');
INSERT INTO `activity` VALUES ('9', '安全检查', null, '2020-06-02 14:00:00', null, '浦口项目现场', '盘城街道滁河汪庄组18号', '19', '1999.30', '67');
INSERT INTO `activity` VALUES ('11', '安全培训', null, '2020-06-06 14:00:00', null, '实训基地', '南京市栖霞区仙林大道118号曼度广场301', '18', '1339.10', '67');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for jat_resp_dep
-- ----------------------------
DROP TABLE IF EXISTS `jat_resp_dep`;
CREATE TABLE `jat_resp_dep` (
  `id` int(11) NOT NULL COMMENT '职责编号',
  `name` varchar(255) DEFAULT NULL COMMENT '职责名称',
  `description` varchar(255) DEFAULT NULL COMMENT '职责描述',
  `disabled` int(11) DEFAULT NULL COMMENT '启用该职责',
  `type` varchar(255) DEFAULT NULL COMMENT '1代表部门责任，2代表岗位责任',
  `is_key` int(11) DEFAULT NULL,
  `single_resp` int(11) DEFAULT NULL,
  `is_safe_resp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jat_resp_dep
-- ----------------------------

-- ----------------------------
-- Table structure for jat_resp_person
-- ----------------------------
DROP TABLE IF EXISTS `jat_resp_person`;
CREATE TABLE `jat_resp_person` (
  `id` int(11) NOT NULL COMMENT '职责编号',
  `name` varchar(255) DEFAULT NULL COMMENT '职责名称',
  `description` varchar(255) DEFAULT NULL COMMENT '职责描述',
  `disabled` int(11) DEFAULT NULL COMMENT '启用该职责',
  `type` varchar(255) DEFAULT NULL COMMENT '1代表部门责任，2代表岗位责任',
  `is_key` int(11) DEFAULT NULL,
  `single_resp` int(11) DEFAULT NULL,
  `is_safe_resp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jat_resp_person
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oms_team_group
-- ----------------------------
INSERT INTO `oms_team_group` VALUES ('1', '客服', '11');
INSERT INTO `oms_team_group` VALUES ('2', '文案', '12');
INSERT INTO `oms_team_group` VALUES ('3', '顾问', '13');
INSERT INTO `oms_team_group` VALUES ('4', '总工', '3');
INSERT INTO `oms_team_group` VALUES ('5', '总监', '5');
INSERT INTO `oms_team_group` VALUES ('6', '班组', '43');

-- ----------------------------
-- Table structure for oms_team_user_link
-- ----------------------------
DROP TABLE IF EXISTS `oms_team_user_link`;
CREATE TABLE `oms_team_user_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `team_id` int(11) DEFAULT NULL COMMENT '小组ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;

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
INSERT INTO `oms_team_user_link` VALUES ('164', null, '4');
INSERT INTO `oms_team_user_link` VALUES ('165', null, '5');
INSERT INTO `oms_team_user_link` VALUES ('166', '43', '6');
INSERT INTO `oms_team_user_link` VALUES ('167', null, '6');

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
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactory', 'CTH-E4851591443958156', '1591446583180', '20000');

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
INSERT INTO `sys_msg_content` VALUES ('1', '');
INSERT INTO `sys_msg_content` VALUES ('2', '');
INSERT INTO `sys_msg_content` VALUES ('3', '');
INSERT INTO `sys_msg_content` VALUES ('4', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6', '');
INSERT INTO `sys_msg_content` VALUES ('7', '');
INSERT INTO `sys_msg_content` VALUES ('8', '');
INSERT INTO `sys_msg_content` VALUES ('9', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11', '');
INSERT INTO `sys_msg_content` VALUES ('12', '');
INSERT INTO `sys_msg_content` VALUES ('13', '');
INSERT INTO `sys_msg_content` VALUES ('14', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('15', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('16', '');
INSERT INTO `sys_msg_content` VALUES ('17', '');
INSERT INTO `sys_msg_content` VALUES ('18', '');
INSERT INTO `sys_msg_content` VALUES ('19', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('20', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('21', '');
INSERT INTO `sys_msg_content` VALUES ('22', '');
INSERT INTO `sys_msg_content` VALUES ('23', '');
INSERT INTO `sys_msg_content` VALUES ('24', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('25', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('26', '');
INSERT INTO `sys_msg_content` VALUES ('27', '');
INSERT INTO `sys_msg_content` VALUES ('28', '');
INSERT INTO `sys_msg_content` VALUES ('29', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('30', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('31', '');
INSERT INTO `sys_msg_content` VALUES ('32', '');
INSERT INTO `sys_msg_content` VALUES ('33', '');
INSERT INTO `sys_msg_content` VALUES ('34', '再过7天（04��04��）就是客户 ���ݷ� 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('35', '今天（03��28��）是客户 ����Ψ 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('36', '');
INSERT INTO `sys_msg_content` VALUES ('37', '');
INSERT INTO `sys_msg_content` VALUES ('38', '');
INSERT INTO `sys_msg_content` VALUES ('39', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('40', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('41', '');
INSERT INTO `sys_msg_content` VALUES ('42', '');
INSERT INTO `sys_msg_content` VALUES ('43', '');
INSERT INTO `sys_msg_content` VALUES ('44', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('45', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('46', '');
INSERT INTO `sys_msg_content` VALUES ('47', '');
INSERT INTO `sys_msg_content` VALUES ('48', '');
INSERT INTO `sys_msg_content` VALUES ('49', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('50', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('51', '');
INSERT INTO `sys_msg_content` VALUES ('52', '');
INSERT INTO `sys_msg_content` VALUES ('53', '');
INSERT INTO `sys_msg_content` VALUES ('54', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('55', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('56', '');
INSERT INTO `sys_msg_content` VALUES ('57', '');
INSERT INTO `sys_msg_content` VALUES ('58', '');
INSERT INTO `sys_msg_content` VALUES ('59', '');
INSERT INTO `sys_msg_content` VALUES ('60', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('61', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('62', '');
INSERT INTO `sys_msg_content` VALUES ('63', '');
INSERT INTO `sys_msg_content` VALUES ('64', '');
INSERT INTO `sys_msg_content` VALUES ('65', '');
INSERT INTO `sys_msg_content` VALUES ('66', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('67', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('68', '');
INSERT INTO `sys_msg_content` VALUES ('69', '');
INSERT INTO `sys_msg_content` VALUES ('70', '');
INSERT INTO `sys_msg_content` VALUES ('71', '');
INSERT INTO `sys_msg_content` VALUES ('72', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('73', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('74', '');
INSERT INTO `sys_msg_content` VALUES ('75', '');
INSERT INTO `sys_msg_content` VALUES ('76', '');
INSERT INTO `sys_msg_content` VALUES ('77', '');
INSERT INTO `sys_msg_content` VALUES ('78', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('79', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('80', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('81', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('82', '客户张三1已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('83', '客户陈众唯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('84', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('85', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('86', '客户小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('87', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('88', '客户李四已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('89', '客户陈众唯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('90', '再过7天（04月04日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('91', '今天（03月28日）是客户 陈众唯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('92', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('93', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('94', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('95', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('96', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('97', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('98', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('99', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('100', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('101', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('102', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('103', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('104', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('105', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('106', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('107', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('108', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('109', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('110', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('111', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('112', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('113', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('114', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('115', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('116', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('117', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('118', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('119', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('120', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('121', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('122', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('123', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('124', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('125', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('126', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('127', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('128', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('129', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('130', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('131', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('132', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('133', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('134', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('135', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('136', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('137', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('138', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('139', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('140', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('141', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('142', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('143', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('144', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('145', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('146', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('147', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('148', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('149', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('150', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('151', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('152', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('153', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('154', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('155', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('156', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('157', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('158', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('159', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('160', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('161', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('162', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('163', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('164', '再过7天（04月07日）就是客户 魏云贞 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('165', '今天（03月31日）是客户 张皓 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('166', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('167', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('168', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('169', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('170', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('171', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('172', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('173', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('174', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('175', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('176', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('177', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('178', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('179', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('180', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('181', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('182', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('183', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('184', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('185', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('186', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('187', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('188', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('189', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('190', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('191', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('192', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('193', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('194', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('195', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('196', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('197', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('198', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('199', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('200', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('201', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('202', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('203', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('204', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('205', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('206', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('207', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('208', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('209', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('210', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('211', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('212', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('213', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('214', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('215', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('216', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('217', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('218', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('219', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('220', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('221', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('222', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('223', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('224', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('225', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('226', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('227', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('228', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('229', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('230', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('231', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('232', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('233', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('234', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('235', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('236', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('237', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('238', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('239', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('240', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('241', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('242', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('243', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('244', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('245', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('246', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('247', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('248', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('249', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('250', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('251', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('252', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('253', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('254', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('255', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('256', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('257', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('258', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('259', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('260', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('261', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('262', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('263', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('264', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('265', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('266', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('267', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('268', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('269', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('270', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('271', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('272', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('273', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('274', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('275', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('276', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('277', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('278', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('279', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('280', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('281', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('282', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('283', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('284', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('285', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('286', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('287', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('288', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('289', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('290', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('291', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('292', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('293', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('294', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('295', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('296', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('297', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('298', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('299', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('300', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('301', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('302', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('303', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('304', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('305', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('306', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('307', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('308', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('309', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('310', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('311', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('312', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('313', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('314', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('315', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('316', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('317', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('318', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('319', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('320', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('321', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('322', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('323', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('324', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('325', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('326', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('327', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('328', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('329', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('330', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('331', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('332', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('333', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('334', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('335', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('336', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('337', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('338', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('339', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('340', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('341', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('342', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('343', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('344', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('345', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('346', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('347', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('348', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('349', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('350', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('351', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('352', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('353', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('354', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('355', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('356', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('357', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('358', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('359', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('360', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('361', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('362', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('363', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('364', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('365', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('366', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('367', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('368', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('369', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('370', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('371', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('372', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('373', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('374', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('375', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('376', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('377', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('378', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('379', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('380', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('381', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('382', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('383', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('384', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('385', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('386', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('387', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('388', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('389', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('390', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('391', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('392', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('393', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('394', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('395', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('396', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('397', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('398', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('399', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('400', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('401', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('402', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('403', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('404', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('405', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('406', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('407', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('408', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('409', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('410', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('411', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('412', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('413', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('414', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('415', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('416', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('417', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('418', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('419', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('420', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('421', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('422', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('423', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('424', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('425', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('426', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('427', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('428', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('429', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('430', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('431', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('432', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('433', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('434', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('435', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('436', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('437', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('438', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('439', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('440', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('441', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('442', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('443', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('444', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('445', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('446', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('447', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('448', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('449', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('450', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('451', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('452', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('453', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('454', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('455', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('456', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('457', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('458', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('459', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('460', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('461', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('462', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('463', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('464', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('465', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('466', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('467', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('468', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('469', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('470', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('471', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('472', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('473', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('474', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('475', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('476', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('477', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('478', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('479', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('480', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('481', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('482', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('483', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('484', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('485', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('486', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('487', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('488', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('489', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('490', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('491', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('492', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('493', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('494', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('495', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('496', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('497', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('498', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('499', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('500', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('501', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('502', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('503', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('504', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('505', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('506', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('507', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('508', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('509', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('510', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('511', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('512', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('513', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('514', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('515', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('516', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('517', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('518', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('519', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('520', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('521', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('522', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('523', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('524', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('525', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('526', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('527', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('528', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('529', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('530', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('531', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('532', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('533', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('534', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('535', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('536', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('537', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('538', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('539', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('540', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('541', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('542', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('543', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('544', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('545', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('546', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('547', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('548', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('549', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('550', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('551', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('552', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('553', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('554', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('555', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('556', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('557', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('558', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('559', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('560', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('561', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('562', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('563', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('564', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('565', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('566', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('567', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('568', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('569', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('570', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('571', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('572', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('573', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('574', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('575', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('576', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('577', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('578', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('579', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('580', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('581', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('582', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('583', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('584', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('585', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('586', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('587', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('588', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('589', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('590', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('591', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('592', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('593', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('594', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('595', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('596', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('597', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('598', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('599', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('600', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('601', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('602', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('603', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('604', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('605', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('606', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('607', '今天（04月07日）是客户 魏云贞 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('608', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('609', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('610', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('611', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('612', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('613', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('614', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('615', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('616', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('617', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('618', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('619', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('620', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('621', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('622', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('623', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('624', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('625', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('626', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('627', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('628', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('629', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('630', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('631', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('632', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('633', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('634', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('635', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('636', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('637', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('638', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('639', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('640', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('641', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('642', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('643', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('644', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('645', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('646', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('647', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('648', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('649', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('650', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('651', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('652', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('653', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('654', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('655', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('656', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('657', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('658', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('659', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('660', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('661', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('662', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('663', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('664', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('665', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('666', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('667', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('668', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('669', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('670', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('671', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('672', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('673', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('674', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('675', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('676', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('677', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('678', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('679', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('680', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('681', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('682', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('683', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('684', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('685', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('686', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('687', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('688', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('689', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('690', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('691', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('692', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('693', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('694', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('695', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('696', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('697', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('698', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('699', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('700', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('701', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('702', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('703', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('704', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('705', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('706', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('707', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('708', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('709', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('710', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('711', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('712', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('713', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('714', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('715', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('716', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('717', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('718', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('719', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('720', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('721', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('722', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('723', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('724', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('725', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('726', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('727', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('728', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('729', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('730', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('731', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('732', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('733', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('734', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('735', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('736', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('737', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('738', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('739', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('740', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('741', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('742', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('743', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('744', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('745', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('746', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('747', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('748', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('749', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('750', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('751', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('752', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('753', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('754', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('755', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('756', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('757', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('758', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('759', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('760', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('761', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('762', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('763', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('764', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('765', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('766', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('767', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('768', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('769', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('770', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('771', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('772', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('773', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('774', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('775', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('776', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('777', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('778', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('779', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('780', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('781', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('782', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('783', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('784', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('785', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('786', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('787', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('788', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('789', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('790', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('791', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('792', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('793', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('794', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('795', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('796', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('797', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('798', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('799', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('800', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('801', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('802', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('803', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('804', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('805', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('806', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('807', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('808', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('809', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('810', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('811', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('812', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('813', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('814', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('815', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('816', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('817', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('818', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('819', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('820', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('821', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('822', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('823', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('824', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('825', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('826', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('827', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('828', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('829', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('830', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('831', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('832', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('833', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('834', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('835', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('836', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('837', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('838', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('839', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('840', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('841', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('842', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('843', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('844', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('845', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('846', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('847', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('848', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('849', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('850', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('851', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('852', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('853', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('854', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('855', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('856', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('857', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('858', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('859', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('860', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('861', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('862', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('863', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('864', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('865', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('866', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('867', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('868', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('869', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('870', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('871', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('872', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('873', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('874', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('875', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('876', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('877', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('878', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('879', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('880', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('881', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('882', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('883', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('884', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('885', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('886', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('887', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('888', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('889', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('890', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('891', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('892', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('893', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('894', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('895', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('896', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('897', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('898', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('899', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('900', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('901', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('902', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('903', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('904', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('905', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('906', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('907', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('908', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('909', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('910', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('911', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('912', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('913', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('914', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('915', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('916', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('917', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('918', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('919', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('920', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('921', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('922', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('923', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('924', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('925', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('926', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('927', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('928', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('929', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('930', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('931', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('932', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('933', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('934', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('935', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('936', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('937', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('938', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('939', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('940', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('941', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('942', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('943', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('944', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('945', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('946', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('947', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('948', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('949', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('950', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('951', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('952', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('953', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('954', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('955', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('956', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('957', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('958', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('959', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('960', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('961', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('962', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('963', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('964', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('965', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('966', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('967', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('968', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('969', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('970', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('971', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('972', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('973', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('974', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('975', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('976', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('977', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('978', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('979', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('980', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('981', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('982', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('983', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('984', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('985', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('986', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('987', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('988', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('989', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('990', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('991', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('992', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('993', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('994', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('995', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('996', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('997', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('998', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('999', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1000', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1001', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1002', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1003', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1004', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1005', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1006', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1007', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1008', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1009', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1010', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1011', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1012', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1013', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1014', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1015', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1016', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1017', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1018', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1019', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1020', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1021', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1022', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1023', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1024', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1025', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1026', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1027', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1028', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1029', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1030', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1031', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1032', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1033', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1034', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1035', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1036', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1037', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1038', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1039', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1040', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1041', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1042', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1043', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1044', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1045', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1046', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1047', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1048', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1049', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1050', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1051', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1052', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1053', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1054', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1055', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1056', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1057', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1058', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1059', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1060', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1061', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1062', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1063', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1064', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1065', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1066', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1067', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1068', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1069', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1070', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1071', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1072', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1073', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1074', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1075', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1076', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1077', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1078', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1079', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1080', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1081', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1082', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1083', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1084', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1085', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1086', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1087', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1088', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1089', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1090', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1091', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1092', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1093', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1094', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1095', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1096', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1097', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1098', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1099', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1100', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1101', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1102', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1103', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1104', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1105', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1106', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1107', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1108', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1109', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1110', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1111', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1112', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1113', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1114', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1115', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1116', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1117', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1118', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1119', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1120', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1121', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1122', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1123', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1124', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1125', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1126', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1127', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1128', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1129', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1130', '再过7天（04月20日）就是客户 李铁蕴 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1131', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1132', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1133', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1134', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1135', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1136', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1137', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1138', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1139', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1140', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1141', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1142', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1143', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1144', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1145', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1146', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1147', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1148', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1149', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1150', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1151', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1152', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1153', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1154', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1155', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1156', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1157', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1158', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1159', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1160', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1161', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1162', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1163', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1164', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1165', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1166', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1167', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1168', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1169', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1170', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1171', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1172', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1173', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1174', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1175', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1176', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1177', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1178', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1179', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1180', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1181', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1182', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1183', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1184', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1185', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1186', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1187', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1188', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1189', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1190', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1191', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1192', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1193', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1194', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1195', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1196', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1197', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1198', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1199', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1200', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1201', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1202', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1203', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1204', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1205', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1206', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1207', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1208', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1209', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1210', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1211', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1212', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1213', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1214', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1215', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1216', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1217', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1218', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1219', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1220', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1221', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1222', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1223', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1224', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1225', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1226', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1227', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1228', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1229', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1230', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1231', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1232', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1233', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1234', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1235', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1236', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1237', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1238', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1239', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1240', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1241', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1242', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1243', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1244', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1245', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1246', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1247', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1248', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1249', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1250', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1251', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1252', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1253', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1254', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1255', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1256', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1257', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1258', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1259', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1260', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1261', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1262', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1263', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1264', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1265', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1266', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1267', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1268', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1269', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1270', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1271', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1272', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1273', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1274', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1275', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1276', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1277', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1278', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1279', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1280', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1281', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1282', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1283', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1284', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1285', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1286', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1287', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1288', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1289', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1290', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1291', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1292', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1293', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1294', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1295', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1296', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1297', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1298', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1299', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1300', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1301', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1302', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1303', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1304', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1305', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1306', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1307', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1308', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1309', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1310', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1311', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1312', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1313', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1314', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1315', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1316', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1317', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1318', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1319', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1320', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1321', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1322', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1323', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1324', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1325', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1326', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1327', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1328', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1329', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1330', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1331', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1332', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1333', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1334', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1335', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1336', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1337', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1338', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1339', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1340', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1341', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1342', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1343', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1344', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1345', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1346', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1347', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1348', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1349', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1350', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1351', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1352', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1353', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1354', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1355', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1356', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1357', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1358', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1359', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1360', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1361', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1362', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1363', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1364', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1365', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1366', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1367', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1368', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1369', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1370', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1371', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1372', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1373', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1374', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1375', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1376', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1377', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1378', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1379', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1380', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1381', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1382', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1383', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1384', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1385', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1386', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1387', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1388', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1389', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1390', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1391', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1392', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1393', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1394', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1395', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1396', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1397', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1398', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1399', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1400', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1401', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1402', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1403', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1404', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1405', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1406', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1407', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1408', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1409', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1410', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1411', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1412', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1413', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1414', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1415', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1416', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1417', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1418', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1419', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1420', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1421', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1422', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1423', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1424', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1425', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1426', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1427', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1428', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1429', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1430', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1431', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1432', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1433', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1434', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1435', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1436', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1437', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1438', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1439', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1440', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1441', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1442', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1443', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1444', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1445', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1446', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1447', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1448', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1449', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1450', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1451', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1452', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1453', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1454', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1455', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1456', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1457', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1458', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1459', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1460', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1461', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1462', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1463', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1464', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1465', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1466', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1467', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1468', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1469', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1470', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1471', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1472', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1473', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1474', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1475', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1476', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1477', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1478', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1479', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1480', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1481', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1482', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1483', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1484', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1485', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1486', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1487', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1488', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1489', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1490', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1491', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1492', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1493', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1494', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1495', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1496', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1497', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1498', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1499', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1500', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1501', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1502', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1503', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1504', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1505', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1506', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1507', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1508', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1509', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1510', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1511', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1512', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1513', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1514', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1515', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1516', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1517', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1518', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1519', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1520', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1521', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1522', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1523', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1524', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1525', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1526', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1527', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1528', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1529', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1530', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1531', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1532', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1533', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1534', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1535', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1536', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1537', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1538', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1539', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1540', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1541', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1542', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1543', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1544', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1545', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1546', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1547', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1548', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1549', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1550', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1551', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1552', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1553', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1554', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1555', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1556', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1557', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1558', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1559', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1560', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1561', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1562', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1563', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1564', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1565', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1566', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1567', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1568', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1569', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1570', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1571', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1572', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1573', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1574', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1575', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1576', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1577', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1578', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1579', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1580', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1581', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1582', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1583', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1584', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1585', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1586', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1587', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1588', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1589', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1590', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1591', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1592', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1593', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1594', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1595', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1596', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1597', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1598', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1599', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1600', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1601', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1602', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1603', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1604', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1605', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1606', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1607', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1608', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1609', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1610', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1611', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1612', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1613', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1614', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1615', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1616', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1617', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1618', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1619', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1620', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1621', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1622', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1623', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1624', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1625', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1626', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1627', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1628', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1629', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1630', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1631', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1632', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1633', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1634', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1635', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1636', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1637', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1638', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1639', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1640', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1641', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1642', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1643', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1644', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1645', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1646', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1647', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1648', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1649', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1650', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1651', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1652', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1653', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1654', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1655', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1656', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1657', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1658', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1659', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1660', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1661', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1662', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1663', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1664', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1665', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1666', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1667', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1668', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1669', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1670', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1671', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1672', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1673', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1674', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1675', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1676', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1677', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1678', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1679', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1680', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1681', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1682', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1683', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1684', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1685', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1686', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1687', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1688', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1689', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1690', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1691', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1692', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1693', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1694', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1695', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1696', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1697', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1699', '再过7天（05月01日）就是客户 王翀 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1700', '再过7天（05月01日）就是客户 郑子进 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1701', '再过7天（05月04日）就是客户 吴煜 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1702', '再过7天（05月04日）就是客户 张冀中 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1703', '再过7天（05月05日）就是客户 盛海英 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1704', '再过7天（05月06日）就是客户 李达 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1705', '今天（05月01日）是客户 王翀 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1706', '今天（05月01日）是客户 郑子进 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1707', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1708', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1709', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1710', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1711', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1712', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1713', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1714', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1715', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1716', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1717', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1718', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1719', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1720', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1721', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1722', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1723', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1724', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1725', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1726', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1727', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1728', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1729', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1730', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1731', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1732', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1733', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1734', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1735', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1736', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1737', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1738', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1739', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1740', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1741', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1742', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1743', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1744', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1745', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1746', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1747', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1748', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1749', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1750', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1751', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1752', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1753', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1754', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1755', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1756', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1757', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1758', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1759', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1760', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1761', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1762', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1763', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1764', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1765', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1766', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1767', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1768', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1769', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1770', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1771', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1772', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1773', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1774', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1775', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1776', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1777', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1778', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1779', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1780', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1781', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1782', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1783', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1784', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1785', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1786', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1787', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1788', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1789', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1790', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1791', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1792', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1793', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1794', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1795', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1796', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1797', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1798', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1799', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1800', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1801', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1802', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1803', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1804', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1805', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1806', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1807', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1808', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1809', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1810', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1811', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1812', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1813', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1814', '今天（05月04日）是客户 肖爽 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1815', '今天（05月04日）是客户 吴煜 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1816', '今天（05月04日）是客户 张冀中 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1817', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1818', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1819', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1820', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1821', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1822', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1823', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1824', '今天（05月05日）是客户 盛海英 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1825', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1826', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1827', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1828', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1829', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1830', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1831', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1832', '今天（05月06日）是客户 李达 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1833', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1834', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1835', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1836', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1837', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1838', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1839', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1840', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1841', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1842', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1843', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1844', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1845', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1846', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1847', '再过7天（05月17日）就是客户 郭东辉 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1848', '再过7天（05月19日）就是客户 葛浩 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1849', '今天（05月17日）是客户 郭东辉 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1850', '再过7天（05月25日）就是客户 沈泰来 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1851', '再过7天（05月26日）就是客户 杨旭 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1852', '今天（05月19日）是客户 葛浩 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1853', '再过7天（05月28日）就是客户 吴涛 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1854', '今天（05月25日）是客户 沈泰来 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1855', '今天（05月26日）是客户 杨旭 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1856', '再过7天（06月04日）就是客户 周岩岩 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1857', '今天（05月28日）是客户 吴涛 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1858', '再过7天（06月06日）就是客户 王薇 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1859', '今天（06月04日）是客户 周岩岩 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1860', '今天（06月05日）是客户 李敏 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1861', '再过7天（06月13日）就是客户 王晓波 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1862', '今天（06月06日）是客户 王薇 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1863', '再过7天（06月16日）就是客户 尹慧玲 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1864', '再过7天（06月18日）就是客户 熊伟 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1865', '今天（06月13日）是客户 王晓波 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1866', '今天（06月16日）是客户 尹慧玲 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1867', '今天（06月18日）是客户 熊伟 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1868', '再过7天（06月26日）就是客户 洪传芳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1869', '再过7天（06月26日）就是客户 祝娜 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1870', '再过7天（06月29日）就是客户 季宁 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1871', '再过7天（06月29日）就是客户 何军 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1872', '再过7天（07月01日）就是客户 陈琪 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1873', '再过7天（07月01日）就是客户 李琦 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1874', '再过7天（07月02日）就是客户 吴岭 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1875', '再过7天（07月03日）就是客户 颜辉 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('1876', '今天（06月26日）是客户 洪传芳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1877', '今天（06月26日）是客户 祝娜 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('1878', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1879', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1880', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1881', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1882', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1883', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1884', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1885', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1886', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1887', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1888', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1889', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1890', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1891', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1892', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1893', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1894', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1895', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1896', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1897', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1898', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1899', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1900', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1901', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1902', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1903', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1904', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1905', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1906', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1907', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1908', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1909', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1910', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1911', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1912', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1913', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1914', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1915', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1916', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1917', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1918', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1919', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1920', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1921', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1922', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1923', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1924', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1925', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1926', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1927', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1928', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1929', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1930', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1931', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1932', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1933', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1934', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1935', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1936', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1937', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1938', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1939', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1940', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1941', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1942', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1943', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1944', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1945', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1946', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1947', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1948', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1949', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1950', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1951', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1952', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1953', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1954', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1955', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1956', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1957', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1958', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1959', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1960', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1961', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1962', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1963', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1964', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1965', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1966', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1967', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1968', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1969', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1970', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1971', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1972', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1973', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1974', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1975', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1976', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1977', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1978', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1979', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1980', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1981', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1982', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1983', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1984', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1985', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1986', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1987', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1988', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1989', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1990', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1991', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1992', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1993', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1994', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1995', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1996', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1997', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1998', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('1999', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2000', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2001', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2002', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2003', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2004', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2005', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2006', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2007', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2008', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2009', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2010', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2011', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2012', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2013', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2014', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2015', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2016', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2017', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2018', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2019', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2020', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2021', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2022', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2023', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2024', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2025', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2026', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2027', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2028', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2029', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2030', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2031', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2032', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2033', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2034', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2035', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2036', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2037', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2038', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2039', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2040', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2041', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2042', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2043', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2044', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2045', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2046', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2047', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2048', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2049', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2050', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2051', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2052', '今天（06月29日）是客户 季宁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2053', '今天（06月29日）是客户 何军 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2054', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2055', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2056', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2057', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2058', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2059', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2060', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2061', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2062', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2063', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2064', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2065', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2066', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2067', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2068', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2069', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2070', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2071', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2072', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2073', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2074', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2075', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2076', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2077', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2078', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2079', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2080', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2081', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2082', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2083', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2084', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2085', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2086', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2087', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2088', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2089', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2090', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2091', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2092', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2093', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2094', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2095', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2096', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2097', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2098', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2099', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2100', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2101', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2102', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2103', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2104', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2105', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2106', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2107', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2108', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2109', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2110', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2111', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2112', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2113', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2114', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2115', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2116', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2117', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2118', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2119', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2120', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2121', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2122', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2123', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2124', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2125', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2126', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2127', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2128', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2129', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2130', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2131', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2132', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2133', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2134', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2135', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2136', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2137', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2138', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2139', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2140', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2141', '再过7天（07月07日）就是客户 童星 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2142', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2143', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2144', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2145', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2146', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2147', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2148', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2149', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2150', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2151', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2152', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2153', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2154', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2155', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2156', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2157', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2158', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2159', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2160', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2161', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2162', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2163', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2164', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2165', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2166', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2167', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2168', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2169', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2170', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2171', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2172', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2173', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2174', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2175', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2176', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2177', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2178', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2179', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2180', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2181', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2182', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2183', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2184', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2185', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2186', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2187', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2188', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2189', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2190', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2191', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2192', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2193', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2194', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2195', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2196', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2197', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2198', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2199', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2200', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2201', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2202', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2203', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2204', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2205', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2206', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2207', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2208', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2209', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2210', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2211', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2212', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2213', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2214', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2215', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2216', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2217', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2218', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2219', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2220', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2221', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2222', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2223', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2224', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2225', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2226', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2227', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2228', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2229', '再过7天（07月08日）就是客户 徐影 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2230', '今天（07月01日）是客户 陈琪 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2231', '今天（07月01日）是客户 李琦 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2232', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2233', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2234', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2235', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2236', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2237', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2238', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2239', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2240', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2241', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2242', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2243', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2244', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2245', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2246', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2247', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2248', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2249', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2250', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2251', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2252', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2253', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2254', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2255', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2256', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2257', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2258', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2259', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2260', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2261', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2262', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2263', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2264', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2265', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2266', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2267', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2268', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2269', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2270', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2271', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2272', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2273', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2274', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2275', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2276', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2277', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2278', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2279', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2280', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2281', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2282', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2283', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2284', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2285', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2286', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2287', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2288', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2289', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2290', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2291', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2292', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2293', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2294', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2295', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2296', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2297', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2298', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2299', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2300', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2301', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2302', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2303', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2304', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2305', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2306', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2307', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2308', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2309', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2310', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2311', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2312', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2313', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2314', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2315', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2316', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2317', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2318', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2319', '今天（07月02日）是客户 吴岭 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2320', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2321', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2322', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2323', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2324', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2325', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2326', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2327', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2328', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2329', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2330', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2331', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2332', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2333', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2334', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2335', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2336', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2337', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2338', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2339', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2340', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2341', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2342', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2343', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2344', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2345', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2346', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2347', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2348', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2349', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2350', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2351', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2352', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2353', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2354', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2355', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2356', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2357', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2358', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2359', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2360', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2361', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2362', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2363', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2364', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2365', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2366', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2367', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2368', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2369', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2370', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2371', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2372', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2373', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2374', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2375', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2376', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2377', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2378', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2379', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2380', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2381', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2382', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2383', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2384', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2385', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2386', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2387', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2388', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2389', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2390', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2391', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2392', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2393', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2394', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2395', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2396', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2397', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2398', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2399', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2400', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2401', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2402', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2403', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2404', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2405', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2406', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2407', '再过7天（07月10日）就是客户 陆大志 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2408', '今天（07月03日）是客户 颜辉 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2409', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2410', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2411', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2412', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2413', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2414', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2415', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2416', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2417', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2418', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2419', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2420', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2421', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2422', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2423', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2424', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2425', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2426', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2427', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2428', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2429', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2430', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2431', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2432', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2433', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2434', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2435', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2436', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2437', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2438', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2439', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2440', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2441', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2442', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2443', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2444', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2445', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2446', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2447', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2448', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2449', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2450', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2451', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2452', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2453', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2454', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2455', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2456', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2457', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2458', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2459', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2460', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2461', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2462', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2463', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2464', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2465', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2466', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2467', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2468', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2469', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2470', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2471', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2472', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2473', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2474', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2475', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2476', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2477', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2478', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2479', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2480', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2481', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2482', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2483', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2484', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2485', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2486', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2487', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2488', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2489', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2490', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2491', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2492', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2493', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2494', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2495', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2496', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2497', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2498', '今天（07月07日）是客户 童星 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2499', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2500', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2501', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2502', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2503', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2504', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2505', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2506', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2507', '今天（07月08日）是客户 徐影 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2508', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2509', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2510', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2511', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2512', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2513', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2514', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2515', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2516', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2517', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2518', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2519', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2520', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2521', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2522', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2523', '再过7天（07月17日）就是客户 张劲松 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2524', '今天（07月10日）是客户 陆大志 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2525', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2526', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2527', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2528', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2529', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2530', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2531', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2532', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2533', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2534', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2535', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2536', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2537', '再过7天（07月19日）就是客户 秦峰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2538', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2539', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2540', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2541', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2542', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2543', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2544', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2545', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2546', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2547', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2548', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2549', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2550', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2551', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2552', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2553', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2554', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2555', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2556', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2557', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2558', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2559', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2560', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2561', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2562', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2563', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2564', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2565', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2566', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2567', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2568', '今天（07月17日）是客户 张劲松 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2569', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2570', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2571', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2572', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2573', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2574', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2575', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2576', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2577', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2578', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2579', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2580', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2581', '再过7天（07月26日）就是客户 沈加东 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2582', '今天（07月19日）是客户 秦峰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2583', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2584', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2585', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2586', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2587', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2588', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2589', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2590', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2591', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2592', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2593', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2594', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2595', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2596', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2597', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2598', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2599', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2600', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2601', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2602', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2603', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2604', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2605', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2606', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2607', '再过7天（07月30日）就是客户 魏振宇 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2608', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2609', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2610', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2611', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2612', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2613', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2614', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2615', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2616', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2617', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2618', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2619', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2620', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2621', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2622', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2623', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2624', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2625', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2626', '今天（07月26日）是客户 沈加东 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2627', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2628', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2629', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2630', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2631', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2632', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2633', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2634', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2635', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2636', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2637', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2638', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2639', '再过7天（08月04日）就是客户 袁军荣 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2640', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2641', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2642', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2643', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2644', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2645', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2646', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2647', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2648', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2649', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2650', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2651', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2652', '今天（07月30日）是客户 魏振宇 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2653', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2654', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2655', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2656', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2657', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2658', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2659', '再过7天（08月07日）就是客户 万方 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2660', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2661', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2662', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2663', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2664', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2665', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2666', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2667', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2668', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2669', '再过7天（08月09日）就是客户 林强 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2670', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2671', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2672', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2673', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2674', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2675', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2676', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2677', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2678', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2679', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2680', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2681', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2682', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2683', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2684', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2685', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2686', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2687', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2688', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2689', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2690', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2691', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2692', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2693', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2694', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2695', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2696', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2697', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2698', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2699', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2700', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2701', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2702', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2703', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2704', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2705', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2706', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2707', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2708', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2709', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2710', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2711', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2712', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2713', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2714', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2715', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2716', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2717', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2718', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2719', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2720', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2721', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2722', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2723', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2724', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2725', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2726', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2727', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2728', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2729', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2730', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2731', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2732', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2733', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2734', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2735', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2736', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2737', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2738', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2739', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2740', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2741', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2742', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2743', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2744', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2745', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2746', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2747', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2748', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2749', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2750', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2751', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2752', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2753', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2754', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2755', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2756', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2757', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2758', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2759', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2760', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2761', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2762', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2763', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2764', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2765', '再过7天（08月11日）就是客户 黄艳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2766', '今天（08月04日）是客户 袁军荣 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2767', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2768', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2769', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2770', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2771', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2772', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2773', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2774', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2775', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2776', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2777', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2778', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2779', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2780', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2781', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2782', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2783', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2784', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2785', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2786', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2787', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2788', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2789', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2790', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2791', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2792', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2793', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2794', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2795', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2796', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2797', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2798', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2799', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2800', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2801', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2802', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2803', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2804', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2805', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2806', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2807', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2808', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2809', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2810', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2811', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2812', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2813', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2814', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2815', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2816', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2817', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2818', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2819', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2820', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2821', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2822', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2823', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2824', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2825', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2826', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2827', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2828', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2829', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2830', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2831', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2832', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2833', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2834', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2835', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2836', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2837', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2838', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2839', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2840', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2841', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2842', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2843', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2844', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2845', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2846', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2847', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2848', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2849', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2850', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2851', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2852', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2853', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2854', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2855', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2856', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2857', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2858', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2859', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2860', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2861', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2862', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2863', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2864', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2865', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2866', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2867', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2868', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2869', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2870', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2871', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2872', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2873', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2874', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2875', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2876', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2877', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2878', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2879', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2880', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2881', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2882', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2883', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2884', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2885', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2886', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2887', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2888', '今天（08月07日）是客户 万方 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2889', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2890', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2891', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2892', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2893', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2894', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2895', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2896', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2897', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2898', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2899', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2900', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2901', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2902', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2903', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2904', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2905', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2906', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2907', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2908', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2909', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2910', '再过7天（08月15日）就是客户 田英 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2911', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2912', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2913', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2914', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2915', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2916', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2917', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2918', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2919', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2920', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2921', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2922', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2923', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2924', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2925', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2926', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2927', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2928', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2929', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2930', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2931', '今天（08月09日）是客户 林强 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2932', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2933', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2934', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2935', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2936', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2937', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2938', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2939', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2940', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2941', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2942', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2943', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2944', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2945', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2946', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2947', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2948', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2949', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2950', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2951', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2952', '再过7天（08月17日）就是客户 周朝永 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('2953', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2954', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2955', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2956', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2957', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2958', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2959', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2960', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2961', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2962', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2963', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2964', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2965', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2966', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2967', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2968', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2969', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2970', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2971', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2972', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2973', '今天（08月11日）是客户 黄艳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('2974', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2975', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2976', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2977', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2978', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2979', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2980', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2981', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2982', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2983', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2984', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2985', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2986', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2987', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2988', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2989', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2990', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2991', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2992', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2993', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2994', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2995', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2996', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2997', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2998', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('2999', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3000', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3001', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3002', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3003', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3004', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3005', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3006', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3007', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3008', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3009', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3010', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3011', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3012', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3013', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3014', '再过7天（08月20日）就是客户 王峰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3015', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3016', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3017', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3018', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3019', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3020', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3021', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3022', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3023', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3024', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3025', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3026', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3027', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3028', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3029', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3030', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3031', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3032', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3033', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3034', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3035', '今天（08月15日）是客户 田英 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3036', '今天（08月17日）是客户 周朝永 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3037', '今天（08月20日）是客户 王峰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3038', '再过7天（08月28日）就是客户 张莉 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3039', '再过7天（08月28日）就是客户 邹广道 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3040', '再过7天（08月28日）就是客户 徐宇清 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3041', '再过7天（08月29日）就是客户 沈志峰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3042', '再过7天（08月29日）就是客户 马秋晨 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3043', '再过7天（09月03日）就是客户 马征 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3044', '再过7天（09月04日）就是客户 周明祥 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3045', '再过7天（09月04日）就是客户 李艳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3046', '今天（08月28日）是客户 张莉 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3047', '今天（08月28日）是客户 邹广道 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3048', '今天（08月28日）是客户 徐宇清 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3049', '今天（08月29日）是客户 沈志峰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3050', '今天（08月29日）是客户 马秋晨 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3051', '再过7天（09月09日）就是客户 陈润民 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3052', '今天（09月04日）是客户 周明祥 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3053', '今天（09月04日）是客户 李艳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3054', '再过7天（09月15日）就是客户 吕华 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3055', '再过7天（09月16日）就是客户 卢兴国 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3056', '今天（09月09日）是客户 陈润民 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3057', '今天（09月10日）是客户 张煦 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3058', '再过7天（09月19日）就是客户 沈敏 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3059', '再过7天（09月19日）就是客户 董鹏飞 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3060', '再过7天（09月19日）就是客户 丁岑萱 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3061', '再过7天（09月22日）就是客户 杨勤 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3062', '今天（09月15日）是客户 吕华 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3063', '今天（09月16日）是客户 卢兴国 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3064', '再过7天（09月25日）就是客户 毛发强 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3065', '今天（09月19日）是客户 沈敏 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3066', '今天（09月19日）是客户 董鹏飞 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3067', '今天（09月19日）是客户 丁岑萱 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3068', '再过7天（09月28日）就是客户 曹阳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3069', '再过7天（09月28日）就是客户 方健 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3070', '今天（09月22日）是客户 杨勤 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3071', '再过7天（10月01日）就是客户 龚洁 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3072', '再过7天（10月01日）就是客户 翁庆 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3073', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3074', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3075', '再过7天（10月02日）就是客户 侯志山 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3076', '今天（09月25日）是客户 毛发强 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3077', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3078', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3079', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3080', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3081', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3082', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3083', '再过7天（10月05日）就是客户 曹亚群 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3084', '今天（09月28日）是客户 曹阳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3085', '今天（09月28日）是客户 方健 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3086', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3087', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3088', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3089', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3090', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3091', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3092', '今天（10月01日）是客户 龚洁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3093', '今天（10月01日）是客户 翁庆 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3094', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3095', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3096', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3097', '再过7天（10月09日）就是客户 兰溥 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3098', '再过7天（10月09日）就是客户 黄明亮 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3099', '今天（10月02日）是客户 侯志山 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3100', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3101', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3102', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3103', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3104', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3105', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3106', '再过7天（10月11日）就是客户 龚丽娟 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3107', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3108', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3109', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3110', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3111', '今天（10月05日）是客户 曹亚群 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3112', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3113', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3114', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3115', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3116', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3117', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3118', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3119', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3120', '再过7天（10月14日）就是客户 李颖 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3121', '再过7天（10月14日）就是客户 吴瀚侠 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3122', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3123', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3124', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3125', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3126', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3127', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3128', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3129', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3130', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3131', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3132', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3133', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3134', '再过7天（10月15日）就是客户 胡敏敏 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3135', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3136', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3137', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3138', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3139', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3140', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3141', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3142', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3143', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3144', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3145', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3146', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3147', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3148', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3149', '再过7天（10月16日）就是客户 徐璇 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3150', '今天（10月09日）是客户 黄明亮 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3151', '今天（10月09日）是客户 兰溥 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3152', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3153', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3154', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3155', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3156', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3157', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3158', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3159', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3160', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3161', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3162', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3163', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3164', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3165', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3166', '再过7天（10月17日）就是客户 朱贵云 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3167', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3168', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3169', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3170', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3171', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3172', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3173', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3174', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3175', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3176', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3177', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3178', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3179', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3180', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3181', '再过7天（10月18日）就是客户 沈雯 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3182', '今天（10月11日）是客户 龚丽娟 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3183', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3184', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3185', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3186', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3187', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3188', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3189', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3190', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3191', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3192', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3193', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3194', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3195', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3196', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3197', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3198', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3199', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3200', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3201', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3202', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3203', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3204', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3205', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3206', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3207', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3208', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3209', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3210', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3211', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3212', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3213', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3214', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3215', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3216', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3217', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3218', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3219', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3220', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3221', '再过7天（10月21日）就是客户 郭映 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3222', '再过7天（10月21日）就是客户 许家荣 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3223', '今天（10月14日）是客户 李颖 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3224', '今天（10月14日）是客户 吴瀚侠 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3225', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3226', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3227', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3228', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3229', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3230', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3231', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3232', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3233', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3234', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3235', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3236', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3237', '今天（10月15日）是客户 胡敏敏 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3238', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3239', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3240', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3241', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3242', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3243', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3244', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3245', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3246', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3247', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3248', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3249', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3250', '再过7天（10月23日）就是客户 李海斌 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3251', '再过7天（10月23日）就是客户 李海斌 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3252', '今天（10月16日）是客户 徐璇 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3253', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3254', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3255', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3256', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3257', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3258', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3259', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3260', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3261', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3262', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3263', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3264', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3265', '再过7天（10月24日）就是客户 李芳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3266', '今天（10月17日）是客户 朱贵云 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3267', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3268', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3269', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3270', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3271', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3272', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3273', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3274', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3275', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3276', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3277', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3278', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3279', '今天（10月18日）是客户 沈雯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3280', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3281', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3282', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3283', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3284', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3285', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3286', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3287', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3288', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3289', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3290', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3291', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3292', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3293', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3294', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3295', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3296', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3297', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3298', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3299', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3300', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3301', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3302', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3303', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3304', '再过7天（10月27日）就是客户 蔡紫兰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3305', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3306', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3307', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3308', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3309', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3310', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3311', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3312', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3313', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3314', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3315', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3316', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3317', '今天（10月21日）是客户 许家荣 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3318', '今天（10月21日）是客户 郭映 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3319', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3320', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3321', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3322', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3323', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3324', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3325', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3326', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3327', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3328', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3329', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3330', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3331', '再过7天（10月29日）就是客户 陈奋时 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3332', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3333', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3334', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3335', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3336', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3337', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3338', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3339', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3340', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3341', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3342', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3343', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3344', '今天（10月23日）是客户 李海斌 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3345', '今天（10月23日）是客户 李海斌 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3346', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3347', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3348', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3349', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3350', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3351', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3352', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3353', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3354', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3355', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3356', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3357', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3358', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3359', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3360', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3361', '今天（10月24日）是客户 李芳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3362', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3363', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3364', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3365', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3366', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3367', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3368', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3369', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3370', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3371', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3372', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3373', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3374', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3375', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3376', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3377', '再过7天（11月01日）就是客户 蒋辉 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3378', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3379', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3380', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3381', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3382', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3383', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3384', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3385', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3386', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3387', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3388', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3389', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3390', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3391', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3392', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3393', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3394', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3395', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3396', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3397', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3398', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3399', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3400', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3401', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3402', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3403', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3404', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3405', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3406', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3407', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3408', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3409', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3410', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3411', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3412', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3413', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3414', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3415', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3416', '再过7天（11月03日）就是客户 沈瑾 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3417', '今天（10月27日）是客户 蔡紫兰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3418', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3419', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3420', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3421', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3422', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3423', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3424', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3425', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3426', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3427', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3428', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3429', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3430', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3431', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3432', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3433', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3434', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3435', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3436', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3437', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3438', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3439', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3440', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3441', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3442', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3443', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3444', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3445', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3446', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3447', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3448', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3449', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3450', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3451', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3452', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3453', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3454', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3455', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3456', '今天（10月29日）是客户 陈奋时 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3457', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3458', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3459', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3460', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3461', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3462', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3463', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3464', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3465', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3466', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3467', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3468', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3469', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3470', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3471', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3472', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3473', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3474', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3475', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3476', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3477', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3478', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3479', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3480', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3481', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3482', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3483', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3484', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3485', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3486', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3487', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3488', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3489', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3490', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3491', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3492', '再过7天（11月07日）就是客户 季梦坚 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3493', '再过7天（11月07日）就是客户 姚钟昌 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3494', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3495', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3496', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3497', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3498', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3499', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3500', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3501', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3502', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3503', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3504', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3505', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3506', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3507', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3508', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3509', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3510', '今天（11月01日）是客户 蒋辉 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3511', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3512', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3513', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3514', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3515', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3516', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3517', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3518', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3519', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3520', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3521', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3522', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3523', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3524', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3525', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3526', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3527', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3528', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3529', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3530', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3531', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3532', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3533', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3534', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3535', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3536', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3537', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3538', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3539', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3540', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3541', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3542', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3543', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3544', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3545', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3546', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3547', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3548', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3549', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3550', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3551', '再过7天（11月10日）就是客户 李馨蕾 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3552', '今天（11月03日）是客户 沈瑾 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3553', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3554', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3555', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3556', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3557', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3558', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3559', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3560', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3561', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3562', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3563', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3564', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3565', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3566', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3567', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3568', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3569', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3570', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3571', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3572', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3573', '再过7天（11月11日）就是客户 莫若雯 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3574', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3575', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3576', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3577', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3578', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3579', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3580', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3581', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3582', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3583', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3584', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3585', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3586', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3587', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3588', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3589', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3590', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3591', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3592', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3593', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3594', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3595', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3596', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3597', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3598', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3599', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3600', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3601', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3602', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3603', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3604', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3605', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3606', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3607', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3608', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3609', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3610', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3611', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3612', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3613', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3614', '再过7天（11月13日）就是客户 袁翯 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3615', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3616', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3617', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3618', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3619', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3620', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3621', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3622', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3623', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3624', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3625', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3626', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3627', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3628', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3629', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3630', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3631', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3632', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3633', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3634', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3635', '今天（11月07日）是客户 季梦坚 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3636', '今天（11月07日）是客户 姚钟昌 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3637', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3638', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3639', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3640', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3641', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3642', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3643', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3644', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3645', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3646', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3647', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3648', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3649', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3650', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3651', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3652', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3653', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3654', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3655', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3656', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3657', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3658', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3659', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3660', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3661', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3662', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3663', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3664', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3665', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3666', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3667', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3668', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3669', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3670', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3671', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3672', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3673', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3674', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3675', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3676', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3677', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3678', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3679', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3680', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3681', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3682', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3683', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3684', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3685', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3686', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3687', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3688', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3689', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3690', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3691', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3692', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3693', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3694', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3695', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3696', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3697', '再过7天（11月17日）就是客户 郝茹 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('3698', '今天（11月10日）是客户 李馨蕾 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3699', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3700', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3701', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3702', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3703', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3704', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3705', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3706', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3707', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3708', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3709', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3710', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3711', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3712', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3713', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3714', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3715', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3716', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3717', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3718', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3719', '今天（11月11日）是客户 莫若雯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3720', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3721', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3722', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3723', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3724', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3725', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3726', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3727', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3728', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3729', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3730', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3731', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3732', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3733', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3734', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3735', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3736', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3737', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3738', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3739', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3740', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3741', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3742', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3743', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3744', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3745', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3746', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3747', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3748', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3749', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3750', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3751', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3752', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3753', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3754', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3755', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3756', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3757', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3758', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3759', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3760', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3761', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3762', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3763', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3764', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3765', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3766', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3767', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3768', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3769', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3770', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3771', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3772', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3773', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3774', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3775', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3776', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3777', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3778', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3779', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3780', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3781', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3782', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3783', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3784', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3785', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3786', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3787', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3788', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3789', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3790', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3791', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3792', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3793', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3794', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3795', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3796', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3797', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3798', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3799', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3800', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3801', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3802', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3803', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3804', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3805', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3806', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3807', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3808', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3809', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3810', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3811', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3812', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3813', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3814', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3815', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3816', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3817', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3818', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3819', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3820', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3821', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3822', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3823', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3824', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3825', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3826', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3827', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3828', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3829', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3830', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3831', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3832', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3833', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3834', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3835', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3836', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3837', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3838', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3839', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3840', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3841', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3842', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3843', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3844', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3845', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3846', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3847', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3848', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3849', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3850', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3851', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3852', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3853', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3854', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3855', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3856', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3857', '客户陈春鸣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3858', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3859', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3860', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3861', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3862', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3863', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3864', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3865', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3866', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3867', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3868', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3869', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3870', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3871', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3872', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3873', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3874', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3875', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3876', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3877', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3878', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3879', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3880', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3881', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3882', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3883', '客户胡敏敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3884', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3885', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3886', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3887', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3888', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3889', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3890', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3891', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3892', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3893', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3894', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3895', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3896', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3897', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3898', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3899', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3900', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3901', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3902', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3903', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3904', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3905', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3906', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3907', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3908', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3909', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3910', '今天（11月13日）是客户 袁翯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('3911', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3912', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3913', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3914', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3915', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3916', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3917', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3918', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3919', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3920', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3921', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3922', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3923', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3924', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3925', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3926', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3927', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3928', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3929', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3930', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3931', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3932', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3933', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3934', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3935', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3936', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3937', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3938', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3939', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3940', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3941', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3942', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3943', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3944', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3945', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3946', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3947', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3948', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3949', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3950', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3951', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3952', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3953', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3954', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3955', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3956', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3957', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3958', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3959', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3960', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3961', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3962', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3963', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3964', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3965', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3966', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3967', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3968', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3969', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3970', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3971', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3972', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3973', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3974', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3975', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3976', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3977', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3978', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3979', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3980', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3981', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3982', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3983', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3984', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3985', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3986', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3987', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3988', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3989', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3990', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3991', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3992', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3993', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3994', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3995', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3996', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3997', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3998', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('3999', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4000', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4001', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4002', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4003', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4004', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4005', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4006', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4007', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4008', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4009', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4010', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4011', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4012', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4013', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4014', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4015', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4016', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4017', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4018', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4019', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4020', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4021', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4022', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4023', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4024', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4025', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4026', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4027', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4028', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4029', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4030', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4031', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4032', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4033', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4034', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4035', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4036', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4037', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4038', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4039', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4040', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4041', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4042', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4043', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4044', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4045', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4046', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4047', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4048', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4049', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4050', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4051', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4052', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4053', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4054', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4055', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4056', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4057', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4058', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4059', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4060', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4061', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4062', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4063', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4064', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4065', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4066', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4067', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4068', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4069', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4070', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4071', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4072', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4073', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4074', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4075', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4076', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4077', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4078', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4079', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4080', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4081', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4082', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4083', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4084', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4085', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4086', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4087', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4088', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4089', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4090', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4091', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4092', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4093', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4094', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4095', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4096', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4097', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4098', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4099', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4100', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4101', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4102', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4103', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4104', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4105', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4106', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4107', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4108', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4109', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4110', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4111', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4112', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4113', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4114', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4115', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4116', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4117', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4118', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4119', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4120', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4121', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4122', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4123', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4124', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4125', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4126', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4127', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4128', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4129', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4130', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4131', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4132', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4133', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4134', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4135', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4136', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4137', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4138', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4139', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4140', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4141', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4142', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4143', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4144', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4145', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4146', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4147', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4148', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4149', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4150', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4151', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4152', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4153', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4154', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4155', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4156', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4157', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4158', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4159', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4160', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4161', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4162', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4163', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4164', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4165', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4166', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4167', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4168', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4169', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4170', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4171', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4172', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4173', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4174', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4175', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4176', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4177', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4178', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4179', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4180', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4181', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4182', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4183', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4184', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4185', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4186', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4187', '再过7天（11月23日）就是客户 黄裕光 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('4188', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4189', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4190', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4191', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4192', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4193', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4194', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4195', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4196', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4197', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4198', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4199', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4200', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4201', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4202', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4203', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4204', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4205', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4206', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4207', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4208', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4209', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4210', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4211', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4212', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4213', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4214', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4215', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4216', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4217', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4218', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4219', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4220', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4221', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4222', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4223', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4224', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4225', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4226', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4227', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4228', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4229', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4230', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4231', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4232', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4233', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4234', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4235', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4236', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4237', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4238', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4239', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4240', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4241', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4242', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4243', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4244', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4245', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4246', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4247', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4248', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4249', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4250', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4251', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4252', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4253', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4254', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4255', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4256', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4257', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4258', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4259', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4260', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4261', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4262', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4263', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4264', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4265', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4266', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4267', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4268', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4269', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4270', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4271', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4272', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4273', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4274', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4275', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4276', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4277', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4278', '今天（11月17日）是客户 郝茹 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('4279', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4280', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4281', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4282', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4283', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4284', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4285', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4286', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4287', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4288', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4289', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4290', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4291', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4292', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4293', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4294', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4295', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4296', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4297', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4298', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4299', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4300', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4301', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4302', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4303', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4304', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4305', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4306', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4307', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4308', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4309', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4310', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4311', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4312', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4313', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4314', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4315', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4316', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4317', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4318', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4319', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4320', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4321', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4322', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4323', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4324', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4325', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4326', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4327', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4328', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4329', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4330', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4331', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4332', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4333', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4334', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4335', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4336', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4337', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4338', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4339', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4340', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4341', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4342', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4343', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4344', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4345', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4346', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4347', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4348', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4349', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4350', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4351', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4352', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4353', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4354', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4355', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4356', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4357', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4358', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4359', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4360', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4361', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4362', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4363', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4364', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4365', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4366', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4367', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4368', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4369', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4370', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4371', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4372', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4373', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4374', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4375', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4376', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4377', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4378', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4379', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4380', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4381', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4382', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4383', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4384', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4385', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4386', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4387', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4388', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4389', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4390', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4391', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4392', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4393', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4394', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4395', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4396', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4397', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4398', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4399', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4400', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4401', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4402', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4403', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4404', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4405', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4406', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4407', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4408', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4409', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4410', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4411', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4412', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4413', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4414', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4415', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4416', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4417', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4418', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4419', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4420', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4421', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4422', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4423', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4424', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4425', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4426', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4427', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4428', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4429', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4430', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4431', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4432', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4433', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4434', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4435', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4436', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4437', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4438', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4439', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4440', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4441', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4442', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4443', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4444', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4445', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4446', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4447', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4448', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4449', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4450', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4451', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4452', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4453', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4454', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4455', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4456', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4457', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4458', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4459', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4460', '再过7天（11月26日）就是客户 王军 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('4461', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4462', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4463', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4464', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4465', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4466', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4467', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4468', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4469', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4470', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4471', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4472', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4473', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4474', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4475', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4476', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4477', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4478', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4479', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4480', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4481', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4482', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4483', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4484', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4485', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4486', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4487', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4488', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4489', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4490', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4491', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4492', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4493', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4494', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4495', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4496', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4497', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4498', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4499', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4500', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4501', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4502', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4503', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4504', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4505', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4506', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4507', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4508', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4509', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4510', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4511', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4512', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4513', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4514', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4515', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4516', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4517', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4518', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4519', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4520', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4521', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4522', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4523', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4524', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4525', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4526', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4527', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4528', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4529', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4530', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4531', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4532', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4533', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4534', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4535', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4536', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4537', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4538', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4539', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4540', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4541', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4542', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4543', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4544', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4545', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4546', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4547', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4548', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4549', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4550', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4551', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4552', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4553', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4554', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4555', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4556', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4557', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4558', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4559', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4560', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4561', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4562', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4563', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4564', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4565', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4566', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4567', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4568', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4569', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4570', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4571', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4572', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4573', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4574', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4575', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4576', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4577', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4578', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4579', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4580', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4581', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4582', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4583', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4584', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4585', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4586', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4587', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4588', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4589', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4590', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4591', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4592', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4593', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4594', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4595', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4596', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4597', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4598', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4599', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4600', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4601', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4602', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4603', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4604', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4605', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4606', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4607', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4608', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4609', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4610', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4611', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4612', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4613', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4614', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4615', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4616', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4617', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4618', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4619', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4620', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4621', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4622', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4623', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4624', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4625', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4626', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4627', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4628', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4629', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4630', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4631', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4632', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4633', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4634', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4635', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4636', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4637', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4638', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4639', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4640', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4641', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4642', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4643', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4644', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4645', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4646', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4647', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4648', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4649', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4650', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4651', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4652', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4653', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4654', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4655', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4656', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4657', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4658', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4659', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4660', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4661', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4662', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4663', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4664', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4665', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4666', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4667', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4668', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4669', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4670', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4671', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4672', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4673', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4674', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4675', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4676', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4677', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4678', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4679', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4680', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4681', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4682', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4683', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4684', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4685', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4686', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4687', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4688', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4689', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4690', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4691', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4692', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4693', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4694', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4695', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4696', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4697', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4698', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4699', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4700', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4701', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4702', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4703', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4704', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4705', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4706', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4707', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4708', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4709', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4710', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4711', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4712', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4713', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4714', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4715', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4716', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4717', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4718', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4719', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4720', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4721', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4722', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4723', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4724', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4725', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4726', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4727', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4728', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4729', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4730', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4731', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4732', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4733', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4734', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4735', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4736', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4737', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4738', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4739', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4740', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4741', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4742', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4743', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4744', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4745', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4746', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4747', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4748', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4749', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4750', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4751', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4752', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4753', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4754', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4755', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4756', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4757', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4758', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4759', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4760', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4761', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4762', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4763', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4764', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4765', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4766', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4767', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4768', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4769', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4770', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4771', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4772', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4773', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4774', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4775', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4776', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4777', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4778', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4779', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4780', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4781', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4782', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4783', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4784', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4785', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4786', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4787', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4788', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4789', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4790', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4791', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4792', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4793', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4794', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4795', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4796', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4797', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4798', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4799', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4800', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4801', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4802', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4803', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4804', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4805', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4806', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4807', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4808', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4809', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4810', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4811', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4812', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4813', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4814', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4815', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4816', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4817', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4818', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4819', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4820', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4821', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4822', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4823', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4824', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4825', '再过7天（11月30日）就是客户 姜洁 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('4826', '今天（11月23日）是客户 黄裕光 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('4827', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4828', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4829', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4830', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4831', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4832', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4833', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4834', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4835', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4836', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4837', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4838', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4839', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4840', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4841', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4842', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4843', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4844', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4845', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4846', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4847', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4848', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4849', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4850', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4851', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4852', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4853', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4854', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4855', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4856', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4857', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4858', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4859', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4860', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4861', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4862', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4863', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4864', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4865', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4866', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4867', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4868', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4869', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4870', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4871', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4872', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4873', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4874', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4875', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4876', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4877', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4878', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4879', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4880', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4881', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4882', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4883', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4884', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4885', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4886', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4887', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4888', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4889', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4890', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4891', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4892', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4893', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4894', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4895', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4896', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4897', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4898', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4899', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4900', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4901', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4902', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4903', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4904', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4905', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4906', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4907', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4908', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4909', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4910', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4911', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4912', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4913', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4914', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4915', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4916', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4917', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4918', '再过7天（12月01日）就是客户 李荣农 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('4919', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4920', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4921', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4922', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4923', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4924', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4925', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4926', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4927', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4928', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4929', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4930', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4931', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4932', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4933', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4934', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4935', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4936', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4937', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4938', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4939', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4940', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4941', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4942', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4943', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4944', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4945', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4946', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4947', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4948', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4949', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4950', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4951', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4952', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4953', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4954', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4955', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4956', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4957', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4958', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4959', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4960', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4961', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4962', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4963', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4964', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4965', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4966', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4967', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4968', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4969', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4970', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4971', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4972', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4973', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4974', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4975', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4976', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4977', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4978', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4979', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4980', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4981', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4982', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4983', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4984', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4985', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4986', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4987', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4988', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4989', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4990', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4991', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4992', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4993', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4994', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4995', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4996', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4997', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4998', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('4999', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5000', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5001', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5002', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5003', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5004', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5005', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5006', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5007', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5008', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5009', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5010', '再过7天（12月02日）就是客户 顾昕 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5011', '再过7天（12月02日）就是客户 蒋立 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5012', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5013', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5014', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5015', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5016', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5017', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5018', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5019', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5020', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5021', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5022', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5023', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5024', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5025', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5026', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5027', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5028', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5029', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5030', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5031', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5032', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5033', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5034', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5035', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5036', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5037', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5038', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5039', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5040', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5041', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5042', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5043', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5044', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5045', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5046', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5047', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5048', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5049', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5050', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5051', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5052', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5053', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5054', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5055', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5056', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5057', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5058', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5059', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5060', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5061', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5062', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5063', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5064', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5065', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5066', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5067', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5068', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5069', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5070', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5071', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5072', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5073', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5074', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5075', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5076', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5077', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5078', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5079', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5080', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5081', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5082', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5083', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5084', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5085', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5086', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5087', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5088', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5089', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5090', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5091', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5092', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5093', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5094', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5095', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5096', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5097', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5098', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5099', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5100', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5101', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5102', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5103', '再过7天（12月03日）就是客户 吴琼 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5104', '今天（11月26日）是客户 王军 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5105', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5106', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5107', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5108', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5109', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5110', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5111', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5112', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5113', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5114', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5115', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5116', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5117', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5118', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5119', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5120', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5121', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5122', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5123', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5124', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5125', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5126', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5127', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5128', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5129', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5130', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5131', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5132', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5133', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5134', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5135', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5136', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5137', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5138', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5139', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5140', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5141', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5142', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5143', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5144', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5145', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5146', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5147', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5148', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5149', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5150', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5151', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5152', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5153', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5154', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5155', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5156', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5157', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5158', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5159', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5160', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5161', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5162', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5163', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5164', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5165', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5166', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5167', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5168', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5169', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5170', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5171', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5172', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5173', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5174', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5175', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5176', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5177', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5178', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5179', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5180', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5181', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5182', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5183', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5184', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5185', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5186', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5187', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5188', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5189', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5190', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5191', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5192', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5193', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5194', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5195', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5196', '再过7天（12月04日）就是客户 戚世杰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5197', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5198', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5199', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5200', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5201', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5202', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5203', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5204', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5205', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5206', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5207', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5208', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5209', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5210', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5211', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5212', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5213', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5214', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5215', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5216', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5217', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5218', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5219', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5220', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5221', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5222', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5223', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5224', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5225', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5226', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5227', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5228', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5229', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5230', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5231', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5232', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5233', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5234', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5235', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5236', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5237', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5238', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5239', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5240', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5241', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5242', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5243', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5244', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5245', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5246', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5247', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5248', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5249', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5250', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5251', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5252', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5253', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5254', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5255', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5256', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5257', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5258', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5259', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5260', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5261', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5262', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5263', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5264', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5265', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5266', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5267', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5268', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5269', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5270', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5271', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5272', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5273', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5274', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5275', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5276', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5277', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5278', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5279', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5280', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5281', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5282', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5283', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5284', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5285', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5286', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5287', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5288', '再过7天（12月05日）就是客户 雷牧 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5289', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5290', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5291', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5292', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5293', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5294', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5295', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5296', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5297', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5298', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5299', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5300', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5301', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5302', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5303', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5304', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5305', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5306', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5307', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5308', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5309', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5310', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5311', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5312', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5313', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5314', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5315', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5316', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5317', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5318', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5319', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5320', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5321', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5322', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5323', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5324', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5325', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5326', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5327', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5328', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5329', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5330', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5331', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5332', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5333', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5334', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5335', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5336', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5337', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5338', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5339', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5340', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5341', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5342', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5343', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5344', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5345', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5346', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5347', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5348', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5349', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5350', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5351', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5352', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5353', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5354', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5355', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5356', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5357', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5358', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5359', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5360', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5361', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5362', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5363', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5364', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5365', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5366', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5367', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5368', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5369', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5370', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5371', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5372', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5373', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5374', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5375', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5376', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5377', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5378', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5379', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5380', '再过7天（12月06日）就是客户 王昱媛 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5381', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5382', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5383', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5384', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5385', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5386', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5387', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5388', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5389', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5390', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5391', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5392', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5393', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5394', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5395', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5396', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5397', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5398', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5399', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5400', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5401', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5402', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5403', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5404', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5405', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5406', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5407', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5408', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5409', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5410', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5411', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5412', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5413', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5414', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5415', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5416', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5417', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5418', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5419', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5420', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5421', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5422', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5423', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5424', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5425', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5426', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5427', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5428', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5429', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5430', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5431', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5432', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5433', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5434', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5435', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5436', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5437', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5438', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5439', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5440', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5441', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5442', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5443', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5444', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5445', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5446', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5447', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5448', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5449', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5450', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5451', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5452', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5453', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5454', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5455', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5456', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5457', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5458', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5459', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5460', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5461', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5462', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5463', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5464', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5465', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5466', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5467', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5468', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5469', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5470', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5471', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5472', '再过7天（12月07日）就是客户 刘新军 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5473', '再过7天（12月07日）就是客户 范国丹 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5474', '再过7天（12月07日）就是客户 徐明遥 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5475', '今天（11月30日）是客户 姜洁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5476', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5477', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5478', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5479', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5480', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5481', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5482', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5483', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5484', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5485', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5486', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5487', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5488', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5489', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5490', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5491', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5492', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5493', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5494', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5495', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5496', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5497', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5498', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5499', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5500', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5501', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5502', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5503', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5504', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5505', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5506', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5507', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5508', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5509', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5510', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5511', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5512', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5513', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5514', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5515', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5516', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5517', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5518', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5519', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5520', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5521', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5522', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5523', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5524', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5525', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5526', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5527', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5528', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5529', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5530', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5531', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5532', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5533', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5534', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5535', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5536', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5537', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5538', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5539', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5540', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5541', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5542', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5543', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5544', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5545', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5546', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5547', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5548', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5549', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5550', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5551', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5552', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5553', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5554', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5555', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5556', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5557', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5558', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5559', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5560', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5561', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5562', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5563', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5564', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5565', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5566', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5567', '今天（12月01日）是客户 李荣农 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5568', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5569', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5570', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5571', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5572', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5573', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5574', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5575', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5576', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5577', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5578', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5579', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5580', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5581', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5582', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5583', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5584', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5585', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5586', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5587', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5588', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5589', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5590', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5591', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5592', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5593', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5594', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5595', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5596', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5597', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5598', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5599', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5600', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5601', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5602', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5603', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5604', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5605', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5606', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5607', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5608', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5609', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5610', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5611', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5612', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5613', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5614', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5615', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5616', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5617', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5618', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5619', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5620', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5621', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5622', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5623', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5624', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5625', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5626', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5627', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5628', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5629', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5630', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5631', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5632', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5633', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5634', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5635', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5636', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5637', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5638', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5639', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5640', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5641', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5642', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5643', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5644', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5645', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5646', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5647', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5648', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5649', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5650', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5651', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5652', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5653', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5654', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5655', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5656', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5657', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5658', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5659', '再过7天（12月09日）就是客户 丁文宁 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5660', '今天（12月02日）是客户 顾昕 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5661', '今天（12月02日）是客户 蒋立 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5662', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5663', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5664', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5665', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5666', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5667', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5668', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5669', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5670', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5671', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5672', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5673', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5674', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5675', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5676', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5677', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5678', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5679', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5680', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5681', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5682', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5683', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5684', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5685', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5686', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5687', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5688', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5689', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5690', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5691', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5692', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5693', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5694', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5695', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5696', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5697', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5698', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5699', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5700', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5701', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5702', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5703', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5704', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5705', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5706', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5707', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5708', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5709', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5710', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5711', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5712', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5713', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5714', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5715', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5716', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5717', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5718', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5719', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5720', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5721', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5722', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5723', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5724', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5725', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5726', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5727', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5728', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5729', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5730', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5731', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5732', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5733', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5734', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5735', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5736', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5737', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5738', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5739', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5740', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5741', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5742', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5743', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5744', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5745', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5746', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5747', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5748', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5749', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5750', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5751', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5752', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5753', '今天（12月03日）是客户 吴琼 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5754', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5755', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5756', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5757', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5758', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5759', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5760', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5761', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5762', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5763', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5764', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5765', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5766', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5767', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5768', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5769', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5770', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5771', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5772', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5773', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5774', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5775', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5776', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5777', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5778', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5779', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5780', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5781', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5782', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5783', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5784', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5785', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5786', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5787', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5788', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5789', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5790', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5791', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5792', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5793', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5794', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5795', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5796', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5797', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5798', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5799', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5800', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5801', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5802', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5803', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5804', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5805', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5806', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5807', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5808', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5809', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5810', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5811', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5812', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5813', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5814', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5815', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5816', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5817', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5818', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5819', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5820', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5821', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5822', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5823', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5824', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5825', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5826', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5827', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5828', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5829', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5830', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5831', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5832', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5833', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5834', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5835', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5836', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5837', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5838', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5839', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5840', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5841', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5842', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5843', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5844', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5845', '再过7天（12月11日）就是客户 余鹏武 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('5846', '今天（12月04日）是客户 戚世杰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5847', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5848', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5849', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5850', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5851', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5852', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5853', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5854', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5855', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5856', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5857', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5858', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5859', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5860', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5861', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5862', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5863', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5864', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5865', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5866', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5867', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5868', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5869', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5870', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5871', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5872', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5873', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5874', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5875', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5876', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5877', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5878', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5879', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5880', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5881', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5882', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5883', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5884', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5885', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5886', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5887', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5888', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5889', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5890', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5891', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5892', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5893', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5894', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5895', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5896', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5897', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5898', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5899', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5900', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5901', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5902', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5903', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5904', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5905', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5906', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5907', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5908', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5909', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5910', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5911', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5912', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5913', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5914', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5915', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5916', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5917', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5918', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5919', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5920', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5921', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5922', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5923', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5924', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5925', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5926', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5927', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5928', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5929', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5930', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5931', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5932', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5933', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5934', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5935', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5936', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5937', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5938', '今天（12月05日）是客户 雷牧 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('5939', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5940', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5941', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5942', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5943', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5944', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5945', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5946', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5947', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5948', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5949', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5950', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5951', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5952', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5953', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5954', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5955', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5956', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5957', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5958', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5959', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5960', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5961', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5962', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5963', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5964', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5965', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5966', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5967', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5968', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5969', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5970', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5971', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5972', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5973', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5974', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5975', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5976', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5977', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5978', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5979', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5980', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5981', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5982', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5983', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5984', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5985', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5986', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5987', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5988', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5989', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5990', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5991', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5992', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5993', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5994', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5995', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5996', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5997', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5998', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('5999', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6000', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6001', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6002', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6003', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6004', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6005', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6006', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6007', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6008', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6009', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6010', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6011', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6012', '今天（12月06日）是客户 王昱媛 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6013', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6014', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6015', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6016', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6017', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6018', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6019', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6020', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6021', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6022', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6023', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6024', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6025', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6026', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6027', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6028', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6029', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6030', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6031', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6032', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6033', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6034', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6035', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6036', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6037', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6038', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6039', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6040', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6041', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6042', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6043', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6044', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6045', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6046', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6047', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6048', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6049', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6050', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6051', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6052', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6053', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6054', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6055', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6056', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6057', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6058', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6059', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6060', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6061', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6062', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6063', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6064', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6065', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6066', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6067', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6068', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6069', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6070', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6071', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6072', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6073', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6074', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6075', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6076', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6077', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6078', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6079', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6080', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6081', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6082', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6083', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6084', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6085', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6086', '再过7天（12月14日）就是客户 耿爽 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6087', '再过7天（12月14日）就是客户 倪雪峰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6088', '今天（12月07日）是客户 刘新军 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6089', '今天（12月07日）是客户 范国丹 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6090', '今天（12月07日）是客户 徐明遥 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6091', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6092', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6093', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6094', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6095', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6096', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6097', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6098', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6099', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6100', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6101', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6102', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6103', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6104', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6105', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6106', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6107', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6108', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6109', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6110', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6111', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6112', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6113', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6114', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6115', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6116', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6117', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6118', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6119', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6120', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6121', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6122', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6123', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6124', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6125', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6126', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6127', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6128', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6129', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6130', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6131', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6132', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6133', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6134', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6135', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6136', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6137', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6138', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6139', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6140', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6141', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6142', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6143', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6144', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6145', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6146', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6147', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6148', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6149', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6150', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6151', '再过7天（12月15日）就是客户 刘建华 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6152', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6153', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6154', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6155', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6156', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6157', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6158', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6159', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6160', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6161', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6162', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6163', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6164', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6165', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6166', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6167', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6168', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6169', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6170', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6171', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6172', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6173', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6174', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6175', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6176', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6177', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6178', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6179', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6180', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6181', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6182', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6183', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6184', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6185', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6186', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6187', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6188', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6189', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6190', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6191', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6192', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6193', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6194', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6195', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6196', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6197', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6198', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6199', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6200', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6201', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6202', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6203', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6204', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6205', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6206', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6207', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6208', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6209', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6210', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6211', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6212', '今天（12月09日）是客户 丁文宁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6213', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6214', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6215', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6216', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6217', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6218', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6219', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6220', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6221', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6222', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6223', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6224', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6225', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6226', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6227', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6228', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6229', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6230', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6231', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6232', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6233', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6234', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6235', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6236', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6237', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6238', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6239', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6240', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6241', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6242', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6243', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6244', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6245', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6246', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6247', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6248', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6249', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6250', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6251', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6252', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6253', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6254', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6255', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6256', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6257', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6258', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6259', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6260', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6261', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6262', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6263', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6264', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6265', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6266', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6267', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6268', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6269', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6270', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6271', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6272', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6273', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6274', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6275', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6276', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6277', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6278', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6279', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6280', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6281', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6282', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6283', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6284', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6285', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6286', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6287', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6288', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6289', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6290', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6291', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6292', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6293', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6294', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6295', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6296', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6297', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6298', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6299', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6300', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6301', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6302', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6303', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6304', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6305', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6306', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6307', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6308', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6309', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6310', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6311', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6312', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6313', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6314', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6315', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6316', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6317', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6318', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6319', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6320', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6321', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6322', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6323', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6324', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6325', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6326', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6327', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6328', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6329', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6330', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6331', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6332', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6333', '今天（12月11日）是客户 余鹏武 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6334', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6335', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6336', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6337', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6338', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6339', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6340', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6341', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6342', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6343', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6344', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6345', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6346', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6347', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6348', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6349', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6350', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6351', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6352', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6353', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6354', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6355', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6356', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6357', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6358', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6359', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6360', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6361', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6362', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6363', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6364', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6365', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6366', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6367', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6368', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6369', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6370', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6371', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6372', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6373', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6374', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6375', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6376', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6377', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6378', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6379', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6380', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6381', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6382', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6383', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6384', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6385', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6386', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6387', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6388', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6389', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6390', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6391', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6392', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6393', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6394', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6395', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6396', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6397', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6398', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6399', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6400', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6401', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6402', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6403', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6404', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6405', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6406', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6407', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6408', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6409', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6410', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6411', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6412', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6413', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6414', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6415', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6416', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6417', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6418', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6419', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6420', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6421', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6422', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6423', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6424', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6425', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6426', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6427', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6428', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6429', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6430', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6431', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6432', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6433', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6434', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6435', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6436', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6437', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6438', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6439', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6440', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6441', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6442', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6443', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6444', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6445', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6446', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6447', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6448', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6449', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6450', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6451', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6452', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6453', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6454', '再过7天（12月20日）就是客户 骆开云 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6455', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6456', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6457', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6458', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6459', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6460', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6461', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6462', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6463', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6464', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6465', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6466', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6467', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6468', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6469', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6470', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6471', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6472', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6473', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6474', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6475', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6476', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6477', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6478', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6479', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6480', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6481', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6482', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6483', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6484', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6485', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6486', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6487', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6488', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6489', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6490', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6491', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6492', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6493', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6494', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6495', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6496', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6497', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6498', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6499', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6500', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6501', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6502', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6503', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6504', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6505', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6506', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6507', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6508', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6509', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6510', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6511', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6512', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6513', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6514', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6515', '今天（12月14日）是客户 耿爽 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6516', '今天（12月14日）是客户 倪雪峰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6517', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6518', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6519', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6520', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6521', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6522', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6523', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6524', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6525', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6526', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6527', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6528', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6529', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6530', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6531', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6532', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6533', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6534', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6535', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6536', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6537', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6538', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6539', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6540', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6541', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6542', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6543', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6544', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6545', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6546', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6547', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6548', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6549', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6550', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6551', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6552', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6553', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6554', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6555', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6556', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6557', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6558', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6559', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6560', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6561', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6562', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6563', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6564', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6565', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6566', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6567', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6568', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6569', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6570', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6571', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6572', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6573', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6574', '今天（12月15日）是客户 刘建华 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6575', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6576', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6577', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6578', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6579', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6580', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6581', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6582', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6583', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6584', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6585', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6586', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6587', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6588', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6589', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6590', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6591', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6592', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6593', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6594', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6595', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6596', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6597', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6598', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6599', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6600', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6601', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6602', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6603', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6604', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6605', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6606', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6607', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6608', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6609', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6610', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6611', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6612', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6613', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6614', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6615', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6616', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6617', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6618', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6619', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6620', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6621', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6622', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6623', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6624', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6625', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6626', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6627', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6628', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6629', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6630', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6631', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6632', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6633', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6634', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6635', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6636', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6637', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6638', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6639', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6640', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6641', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6642', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6643', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6644', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6645', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6646', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6647', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6648', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6649', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6650', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6651', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6652', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6653', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6654', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6655', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6656', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6657', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6658', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6659', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6660', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6661', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6662', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6663', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6664', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6665', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6666', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6667', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6668', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6669', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6670', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6671', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6672', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6673', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6674', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6675', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6676', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6677', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6678', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6679', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6680', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6681', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6682', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6683', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6684', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6685', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6686', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6687', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6688', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6689', '再过7天（12月24日）就是客户 李峻 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6690', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6691', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6692', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6693', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6694', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6695', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6696', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6697', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6698', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6699', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6700', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6701', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6702', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6703', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6704', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6705', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6706', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6707', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6708', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6709', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6710', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6711', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6712', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6713', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6714', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6715', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6716', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6717', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6718', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6719', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6720', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6721', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6722', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6723', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6724', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6725', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6726', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6727', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6728', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6729', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6730', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6731', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6732', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6733', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6734', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6735', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6736', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6737', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6738', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6739', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6740', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6741', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6742', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6743', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6744', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6745', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6746', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6747', '再过7天（12月25日）就是客户 谈素珍 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6748', '再过7天（12月25日）就是客户 杨斐斐 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6749', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6750', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6751', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6752', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6753', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6754', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6755', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6756', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6757', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6758', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6759', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6760', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6761', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6762', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6763', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6764', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6765', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6766', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6767', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6768', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6769', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6770', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6771', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6772', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6773', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6774', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6775', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6776', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6777', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6778', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6779', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6780', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6781', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6782', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6783', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6784', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6785', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6786', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6787', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6788', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6789', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6790', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6791', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6792', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6793', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6794', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6795', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6796', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6797', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6798', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6799', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6800', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6801', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6802', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6803', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6804', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6805', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6806', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6807', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6808', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6809', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6810', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6811', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6812', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6813', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6814', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6815', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6816', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6817', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6818', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6819', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6820', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6821', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6822', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6823', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6824', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6825', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6826', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6827', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6828', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6829', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6830', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6831', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6832', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6833', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6834', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6835', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6836', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6837', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6838', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6839', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6840', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6841', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6842', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6843', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6844', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6845', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6846', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6847', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6848', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6849', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6850', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6851', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6852', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6853', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6854', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6855', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6856', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6857', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6858', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6859', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6860', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6861', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6862', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6863', '今天（12月20日）是客户 骆开云 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('6864', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6865', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6866', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6867', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6868', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6869', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6870', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6871', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6872', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6873', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6874', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6875', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6876', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6877', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6878', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6879', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6880', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6881', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6882', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6883', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6884', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6885', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6886', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6887', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6888', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6889', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6890', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6891', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6892', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6893', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6894', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6895', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6896', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6897', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6898', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6899', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6900', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6901', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6902', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6903', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6904', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6905', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6906', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6907', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6908', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6909', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6910', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6911', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6912', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6913', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6914', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6915', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6916', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6917', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6918', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6919', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6920', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6921', '再过7天（12月28日）就是客户 傅江安 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6922', '再过7天（12月28日）就是客户 李尤 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('6923', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6924', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6925', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6926', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6927', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6928', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6929', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6930', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6931', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6932', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6933', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6934', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6935', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6936', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6937', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6938', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6939', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6940', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6941', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6942', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6943', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6944', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6945', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6946', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6947', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6948', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6949', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6950', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6951', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6952', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6953', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6954', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6955', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6956', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6957', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6958', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6959', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6960', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6961', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6962', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6963', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6964', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6965', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6966', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6967', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6968', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6969', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6970', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6971', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6972', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6973', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6974', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6975', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6976', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6977', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6978', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6979', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6980', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6981', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6982', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6983', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6984', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6985', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6986', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6987', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6988', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6989', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6990', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6991', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6992', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6993', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6994', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6995', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6996', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6997', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6998', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('6999', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7000', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7001', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7002', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7003', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7004', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7005', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7006', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7007', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7008', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7009', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7010', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7011', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7012', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7013', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7014', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7015', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7016', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7017', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7018', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7019', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7020', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7021', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7022', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7023', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7024', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7025', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7026', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7027', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7028', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7029', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7030', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7031', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7032', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7033', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7034', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7035', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7036', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7037', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7038', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7039', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7040', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7041', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7042', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7043', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7044', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7045', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7046', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7047', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7048', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7049', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7050', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7051', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7052', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7053', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7054', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7055', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7056', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7057', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7058', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7059', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7060', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7061', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7062', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7063', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7064', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7065', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7066', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7067', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7068', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7069', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7070', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7071', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7072', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7073', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7074', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7075', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7076', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7077', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7078', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7079', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7080', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7081', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7082', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7083', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7084', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7085', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7086', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7087', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7088', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7089', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7090', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7091', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7092', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7093', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7094', '今天（12月24日）是客户 李峻 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7095', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7096', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7097', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7098', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7099', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7100', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7101', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7102', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7103', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7104', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7105', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7106', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7107', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7108', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7109', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7110', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7111', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7112', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7113', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7114', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7115', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7116', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7117', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7118', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7119', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7120', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7121', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7122', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7123', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7124', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7125', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7126', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7127', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7128', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7129', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7130', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7131', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7132', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7133', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7134', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7135', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7136', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7137', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7138', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7139', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7140', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7141', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7142', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7143', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7144', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7145', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7146', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7147', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7148', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7149', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7150', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7151', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7152', '今天（12月25日）是客户 谈素珍 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7153', '今天（12月25日）是客户 杨斐斐 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7154', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7155', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7156', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7157', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7158', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7159', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7160', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7161', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7162', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7163', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7164', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7165', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7166', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7167', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7168', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7169', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7170', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7171', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7172', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7173', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7174', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7175', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7176', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7177', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7178', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7179', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7180', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7181', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7182', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7183', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7184', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7185', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7186', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7187', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7188', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7189', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7190', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7191', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7192', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7193', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7194', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7195', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7196', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7197', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7198', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7199', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7200', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7201', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7202', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7203', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7204', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7205', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7206', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7207', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7208', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7209', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7210', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7211', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7212', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7213', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7214', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7215', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7216', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7217', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7218', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7219', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7220', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7221', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7222', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7223', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7224', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7225', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7226', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7227', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7228', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7229', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7230', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7231', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7232', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7233', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7234', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7235', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7236', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7237', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7238', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7239', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7240', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7241', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7242', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7243', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7244', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7245', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7246', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7247', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7248', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7249', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7250', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7251', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7252', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7253', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7254', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7255', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7256', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7257', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7258', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7259', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7260', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7261', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7262', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7263', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7264', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7265', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7266', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7267', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7268', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7269', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7270', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7271', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7272', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7273', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7274', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7275', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7276', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7277', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7278', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7279', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7280', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7281', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7282', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7283', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7284', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7285', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7286', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7287', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7288', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7289', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7290', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7291', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7292', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7293', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7294', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7295', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7296', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7297', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7298', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7299', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7300', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7301', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7302', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7303', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7304', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7305', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7306', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7307', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7308', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7309', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7310', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7311', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7312', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7313', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7314', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7315', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7316', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7317', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7318', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7319', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7320', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7321', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7322', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7323', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7324', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7325', '今天（12月28日）是客户 傅江安 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7326', '今天（12月28日）是客户 李尤 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7327', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7328', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7329', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7330', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7331', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7332', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7333', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7334', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7335', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7336', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7337', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7338', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7339', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7340', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7341', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7342', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7343', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7344', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7345', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7346', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7347', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7348', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7349', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7350', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7351', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7352', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7353', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7354', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7355', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7356', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7357', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7358', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7359', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7360', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7361', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7362', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7363', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7364', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7365', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7366', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7367', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7368', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7369', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7370', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7371', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7372', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7373', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7374', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7375', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7376', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7377', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7378', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7379', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7380', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7381', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7382', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7383', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7384', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7385', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7386', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7387', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7388', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7389', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7390', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7391', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7392', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7393', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7394', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7395', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7396', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7397', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7398', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7399', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7400', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7401', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7402', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7403', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7404', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7405', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7406', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7407', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7408', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7409', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7410', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7411', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7412', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7413', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7414', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7415', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7416', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7417', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7418', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7419', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7420', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7421', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7422', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7423', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7424', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7425', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7426', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7427', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7428', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7429', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7430', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7431', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7432', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7433', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7434', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7435', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7436', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7437', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7438', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7439', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7440', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7441', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7442', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7443', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7444', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7445', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7446', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7447', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7448', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7449', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7450', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7451', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7452', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7453', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7454', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7455', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7456', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7457', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7458', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7459', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7460', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7461', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7462', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7463', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7464', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7465', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7466', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7467', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7468', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7469', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7470', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7471', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7472', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7473', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7474', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7475', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7476', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7477', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7478', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7479', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7480', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7481', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7482', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7483', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7484', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7485', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7486', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7487', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7488', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7489', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7490', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7491', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7492', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7493', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7494', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7495', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7496', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7497', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7498', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7499', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7500', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7501', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7502', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7503', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7504', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7505', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7506', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7507', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7508', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7509', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7510', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7511', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7512', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7513', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7514', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7515', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7516', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7517', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7518', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7519', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7520', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7521', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7522', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7523', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7524', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7525', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7526', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7527', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7528', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7529', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7530', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7531', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7532', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7533', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7534', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7535', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7536', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7537', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7538', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7539', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7540', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7541', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7542', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7543', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7544', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7545', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7546', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7547', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7548', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7549', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7550', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7551', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7552', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7553', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7554', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7555', '再过7天（01月08日）就是客户 金松 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('7556', '再过7天（01月08日）就是客户 曹欢 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('7557', '今天（01月01日）是客户 费嘉 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7558', '今天（01月01日）是客户 季伟 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7559', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7560', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7561', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7562', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7563', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7564', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7565', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7566', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7567', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7568', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7569', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7570', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7571', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7572', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7573', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7574', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7575', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7576', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7577', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7578', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7579', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7580', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7581', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7582', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7583', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7584', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7585', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7586', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7587', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7588', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7589', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7590', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7591', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7592', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7593', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7594', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7595', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7596', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7597', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7598', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7599', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7600', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7601', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7602', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7603', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7604', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7605', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7606', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7607', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7608', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7609', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7610', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7611', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7612', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7613', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7614', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7615', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7616', '今天（01月02日）是客户 张瑞 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7617', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7618', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7619', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7620', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7621', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7622', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7623', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7624', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7625', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7626', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7627', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7628', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7629', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7630', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7631', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7632', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7633', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7634', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7635', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7636', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7637', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7638', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7639', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7640', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7641', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7642', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7643', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7644', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7645', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7646', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7647', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7648', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7649', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7650', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7651', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7652', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7653', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7654', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7655', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7656', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7657', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7658', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7659', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7660', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7661', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7662', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7663', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7664', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7665', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7666', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7667', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7668', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7669', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7670', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7671', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7672', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7673', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7674', '再过7天（01月10日）就是客户 任杰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('7675', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7676', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7677', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7678', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7679', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7680', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7681', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7682', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7683', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7684', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7685', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7686', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7687', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7688', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7689', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7690', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7691', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7692', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7693', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7694', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7695', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7696', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7697', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7698', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7699', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7700', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7701', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7702', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7703', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7704', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7705', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7706', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7707', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7708', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7709', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7710', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7711', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7712', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7713', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7714', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7715', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7716', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7717', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7718', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7719', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7720', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7721', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7722', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7723', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7724', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7725', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7726', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7727', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7728', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7729', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7730', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7731', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7732', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7733', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7734', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7735', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7736', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7737', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7738', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7739', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7740', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7741', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7742', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7743', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7744', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7745', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7746', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7747', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7748', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7749', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7750', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7751', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7752', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7753', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7754', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7755', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7756', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7757', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7758', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7759', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7760', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7761', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7762', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7763', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7764', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7765', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7766', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7767', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7768', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7769', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7770', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7771', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7772', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7773', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7774', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7775', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7776', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7777', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7778', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7779', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7780', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7781', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7782', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7783', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7784', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7785', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7786', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7787', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7788', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7789', '今天（01月05日）是客户 徐苏宁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7790', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7791', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7792', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7793', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7794', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7795', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7796', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7797', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7798', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7799', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7800', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7801', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7802', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7803', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7804', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7805', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7806', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7807', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7808', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7809', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7810', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7811', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7812', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7813', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7814', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7815', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7816', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7817', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7818', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7819', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7820', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7821', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7822', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7823', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7824', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7825', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7826', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7827', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7828', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7829', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7830', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7831', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7832', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7833', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7834', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7835', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7836', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7837', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7838', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7839', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7840', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7841', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7842', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7843', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7844', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7845', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7846', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7847', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7848', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7849', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7850', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7851', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7852', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7853', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7854', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7855', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7856', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7857', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7858', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7859', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7860', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7861', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7862', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7863', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7864', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7865', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7866', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7867', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7868', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7869', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7870', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7871', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7872', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7873', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7874', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7875', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7876', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7877', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7878', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7879', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7880', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7881', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7882', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7883', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7884', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7885', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7886', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7887', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7888', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7889', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7890', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7891', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7892', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7893', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7894', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7895', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7896', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7897', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7898', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7899', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7900', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7901', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7902', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7903', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7904', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7905', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7906', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7907', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7908', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7909', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7910', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7911', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7912', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7913', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7914', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7915', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7916', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7917', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7918', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7919', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7920', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7921', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7922', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7923', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7924', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7925', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7926', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7927', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7928', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7929', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7930', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7931', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7932', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7933', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7934', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7935', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7936', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7937', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7938', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7939', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7940', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7941', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7942', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7943', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7944', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7945', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7946', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7947', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7948', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7949', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7950', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7951', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7952', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7953', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7954', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7955', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7956', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7957', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7958', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7959', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7960', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7961', '今天（01月08日）是客户 金松 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7962', '今天（01月08日）是客户 曹欢 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('7963', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7964', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7965', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7966', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7967', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7968', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7969', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7970', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7971', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7972', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7973', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7974', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7975', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7976', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7977', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7978', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7979', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7980', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7981', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7982', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7983', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7984', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7985', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7986', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7987', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7988', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7989', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7990', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7991', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7992', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7993', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7994', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7995', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7996', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7997', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7998', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('7999', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8000', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8001', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8002', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8003', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8004', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8005', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8006', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8007', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8008', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8009', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8010', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8011', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8012', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8013', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8014', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8015', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8016', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8017', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8018', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8019', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8020', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8021', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8022', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8023', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8024', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8025', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8026', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8027', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8028', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8029', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8030', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8031', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8032', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8033', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8034', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8035', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8036', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8037', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8038', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8039', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8040', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8041', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8042', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8043', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8044', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8045', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8046', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8047', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8048', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8049', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8050', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8051', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8052', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8053', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8054', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8055', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8056', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8057', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8058', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8059', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8060', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8061', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8062', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8063', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8064', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8065', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8066', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8067', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8068', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8069', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8070', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8071', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8072', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8073', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8074', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8075', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8076', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8077', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8078', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8079', '今天（01月10日）是客户 任杰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('8080', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8081', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8082', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8083', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8084', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8085', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8086', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8087', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8088', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8089', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8090', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8091', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8092', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8093', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8094', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8095', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8096', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8097', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8098', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8099', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8100', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8101', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8102', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8103', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8104', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8105', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8106', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8107', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8108', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8109', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8110', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8111', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8112', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8113', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8114', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8115', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8116', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8117', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8118', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8119', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8120', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8121', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8122', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8123', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8124', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8125', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8126', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8127', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8128', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8129', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8130', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8131', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8132', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8133', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8134', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8135', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8136', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8137', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8138', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8139', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8140', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8141', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8142', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8143', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8144', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8145', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8146', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8147', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8148', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8149', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8150', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8151', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8152', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8153', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8154', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8155', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8156', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8157', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8158', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8159', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8160', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8161', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8162', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8163', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8164', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8165', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8166', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8167', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8168', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8169', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8170', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8171', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8172', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8173', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8174', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8175', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8176', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8177', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8178', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8179', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8180', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8181', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8182', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8183', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8184', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8185', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8186', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8187', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8188', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8189', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8190', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8191', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8192', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8193', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8194', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8195', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8196', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8197', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8198', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8199', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8200', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8201', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8202', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8203', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8204', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8205', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8206', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8207', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8208', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8209', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8210', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8211', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8212', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8213', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8214', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8215', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8216', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8217', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8218', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8219', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8220', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8221', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8222', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8223', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8224', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8225', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8226', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8227', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8228', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8229', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8230', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8231', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8232', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8233', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8234', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8235', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8236', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8237', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8238', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8239', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8240', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8241', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8242', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8243', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8244', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8245', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8246', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8247', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8248', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8249', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8250', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8251', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8252', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8253', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8254', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8255', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8256', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8257', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8258', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8259', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8260', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8261', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8262', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8263', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8264', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8265', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8266', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8267', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8268', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8269', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8270', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8271', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8272', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8273', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8274', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8275', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8276', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8277', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8278', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8279', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8280', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8281', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8282', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8283', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8284', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8285', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8286', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8287', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8288', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8289', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8290', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8291', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8292', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8293', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8294', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8295', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8296', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8297', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8298', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8299', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8300', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8301', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8302', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8303', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8304', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8305', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8306', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8307', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8308', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8309', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8310', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8311', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8312', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8313', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8314', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8315', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8316', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8317', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8318', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8319', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8320', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8321', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8322', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8323', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8324', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8325', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8326', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8327', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8328', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8329', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8330', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8331', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8332', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8333', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8334', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8335', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8336', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8337', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8338', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8339', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8340', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8341', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8342', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8343', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8344', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8345', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8346', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8347', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8348', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8349', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8350', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8351', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8352', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8353', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8354', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8355', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8356', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8357', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8358', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8359', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8360', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8361', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8362', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8363', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8364', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8365', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8366', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8367', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8368', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8369', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8370', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8371', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8372', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8373', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8374', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8375', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8376', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8377', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8378', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8379', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8380', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8381', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8382', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8383', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8384', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8385', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8386', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8387', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8388', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8389', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8390', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8391', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8392', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8393', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8394', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8395', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8396', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8397', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8398', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8399', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8400', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8401', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8402', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8403', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8404', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8405', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8406', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8407', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8408', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8409', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8410', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8411', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8412', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8413', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8414', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8415', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8416', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8417', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8418', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8419', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8420', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8421', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8422', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8423', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8424', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8425', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8426', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8427', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8428', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8429', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8430', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8431', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8432', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8433', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8434', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8435', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8436', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8437', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8438', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8439', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8440', '再过7天（01月23日）就是客户 徐维军 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('8441', '客户龚丽娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8442', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8443', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8444', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8445', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8446', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8447', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8448', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8449', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8450', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8451', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8452', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8453', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8454', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8455', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8456', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8457', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8458', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8459', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8460', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8461', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8462', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8463', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8464', '客户兰溥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8465', '客户李芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8466', '客户王军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8467', '客户赵小明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8468', '客户董鹏飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8469', '客户张雪琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8470', '客户洪传芳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8471', '客户居飞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8472', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8473', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8474', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8475', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8476', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8477', '客户陈奋时已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8478', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8479', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8480', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8481', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8482', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8483', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8484', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8485', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8486', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8487', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8488', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8489', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8490', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8491', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8492', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8493', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8494', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8495', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8496', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8497', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8498', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8499', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8500', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8501', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8502', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8503', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8504', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8505', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8506', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8507', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8508', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8509', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8510', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8511', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8512', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8513', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8514', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8515', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8516', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8517', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8518', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8519', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8520', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8521', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8522', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8523', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8524', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8525', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8526', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8527', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8528', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8529', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8530', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8531', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8532', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8533', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8534', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8535', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8536', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8537', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8538', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8539', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8540', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8541', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8542', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8543', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8544', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8545', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8546', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8547', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8548', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8549', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8550', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8551', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8552', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8553', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8554', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8555', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8556', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8557', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8558', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8559', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8560', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8561', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8562', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8563', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8564', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8565', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8566', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8567', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8568', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8569', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8570', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8571', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8572', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8573', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8574', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8575', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8576', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8577', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8578', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8579', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8580', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8581', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8582', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8583', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8584', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8585', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8586', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8587', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8588', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8589', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8590', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8591', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8592', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8593', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8594', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8595', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8596', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8597', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8598', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8599', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8600', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8601', '再过7天（01月26日）就是客户 何宏 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('8602', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8603', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8604', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8605', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8606', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8607', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8608', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8609', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8610', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8611', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8612', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8613', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8614', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8615', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8616', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8617', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8618', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8619', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8620', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8621', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8622', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8623', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8624', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8625', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8626', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8627', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8628', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8629', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8630', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8631', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8632', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8633', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8634', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8635', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8636', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8637', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8638', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8639', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8640', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8641', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8642', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8643', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8644', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8645', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8646', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8647', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8648', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8649', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8650', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8651', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8652', '再过7天（01月27日）就是客户 赵丽琴 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('8653', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8654', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8655', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8656', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8657', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8658', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8659', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8660', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8661', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8662', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8663', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8664', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8665', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8666', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8667', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8668', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8669', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8670', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8671', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8672', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8673', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8674', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8675', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8676', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8677', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8678', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8679', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8680', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8681', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8682', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8683', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8684', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8685', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8686', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8687', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8688', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8689', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8690', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8691', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8692', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8693', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8694', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8695', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8696', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8697', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8698', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8699', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8700', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8701', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8702', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8703', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8704', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8705', '客户张岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8706', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8707', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8708', '客户周朝永已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8709', '客户顾立新已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8710', '客户任杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8711', '客户邹广道已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8712', '客户周明祥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8713', '客户张瑞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8714', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8715', '客户侯志山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8716', '客户王峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8717', '客户丁志平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8718', '客户李艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8719', '客户陈其韡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8720', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8721', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8722', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8723', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8724', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8725', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8726', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8727', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8728', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8729', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8730', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8731', '客户张巧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8732', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8733', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8734', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8735', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8736', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8737', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8738', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8739', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8740', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8741', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8742', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8743', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8744', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8745', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8746', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8747', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8748', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8749', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8750', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8751', '客户李海斌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8752', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8753', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8754', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8755', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8756', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8757', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8758', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8759', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8760', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8761', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8762', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8763', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8764', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8765', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8766', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8767', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8768', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8769', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8770', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8771', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8772', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8773', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8774', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8775', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8776', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8777', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8778', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8779', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8780', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8781', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8782', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8783', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8784', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8785', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8786', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8787', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8788', '今天（01月23日）是客户 徐维军 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('8789', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8790', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8791', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8792', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8793', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8794', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8795', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8796', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8797', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8798', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8799', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8800', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8801', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8802', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8803', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8804', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8805', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8806', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8807', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8808', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8809', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8810', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8811', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8812', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8813', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8814', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8815', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8816', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8817', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8818', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8819', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8820', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8821', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8822', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8823', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8824', '再过7天（01月31日）就是客户 赵弘 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('8825', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8826', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8827', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8828', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8829', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8830', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8831', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8832', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8833', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8834', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8835', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8836', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8837', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8838', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8839', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8840', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8841', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8842', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8843', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8844', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8845', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8846', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8847', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8848', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8849', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8850', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8851', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8852', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8853', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8854', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8855', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8856', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8857', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8858', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8859', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8860', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8861', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8862', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8863', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8864', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8865', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8866', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8867', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8868', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8869', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8870', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8871', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8872', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8873', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8874', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8875', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8876', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8877', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8878', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8879', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8880', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8881', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8882', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8883', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8884', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8885', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8886', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8887', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8888', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8889', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8890', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8891', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8892', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8893', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8894', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8895', '今天（01月26日）是客户 何宏 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('8896', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8897', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8898', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8899', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8900', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8901', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8902', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8903', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8904', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8905', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8906', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8907', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8908', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8909', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8910', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8911', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8912', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8913', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8914', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8915', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8916', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8917', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8918', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8919', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8920', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8921', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8922', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8923', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8924', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8925', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8926', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8927', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8928', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8929', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8930', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8931', '今天（01月27日）是客户 赵丽琴 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('8932', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8933', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8934', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8935', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8936', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8937', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8938', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8939', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8940', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8941', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8942', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8943', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8944', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8945', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8946', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8947', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8948', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8949', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8950', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8951', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8952', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8953', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8954', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8955', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8956', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8957', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8958', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8959', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8960', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8961', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8962', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8963', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8964', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8965', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8966', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8967', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8968', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8969', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8970', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8971', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8972', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8973', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8974', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8975', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8976', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8977', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8978', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8979', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8980', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8981', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8982', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8983', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8984', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8985', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8986', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8987', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8988', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8989', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8990', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8991', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8992', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8993', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8994', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8995', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8996', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8997', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8998', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('8999', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9000', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9001', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9002', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9003', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9004', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9005', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9006', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9007', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9008', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9009', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9010', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9011', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9012', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9013', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9014', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9015', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9016', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9017', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9018', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9019', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9020', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9021', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9022', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9023', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9024', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9025', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9026', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9027', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9028', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9029', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9030', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9031', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9032', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9033', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9034', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9035', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9036', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9037', '再过7天（02月06日）就是客户 陈春鸣 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9038', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9039', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9040', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9041', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9042', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9043', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9044', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9045', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9046', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9047', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9048', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9049', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9050', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9051', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9052', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9053', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9054', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9055', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9056', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9057', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9058', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9059', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9060', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9061', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9062', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9063', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9064', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9065', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9066', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9067', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9068', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9069', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9070', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9071', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9072', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9073', '今天（01月31日）是客户 赵弘 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('9074', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9075', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9076', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9077', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9078', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9079', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9080', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9081', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9082', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9083', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9084', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9085', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9086', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9087', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9088', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9089', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9090', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9091', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9092', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9093', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9094', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9095', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9096', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9097', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9098', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9099', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9100', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9101', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9102', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9103', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9104', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9105', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9106', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9107', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9108', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9109', '再过7天（02月08日）就是客户 居飞 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9110', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9111', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9112', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9113', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9114', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9115', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9116', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9117', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9118', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9119', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9120', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9121', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9122', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9123', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9124', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9125', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9126', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9127', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9128', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9129', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9130', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9131', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9132', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9133', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9134', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9135', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9136', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9137', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9138', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9139', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9140', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9141', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9142', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9143', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9144', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9145', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9146', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9147', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9148', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9149', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9150', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9151', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9152', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9153', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9154', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9155', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9156', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9157', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9158', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9159', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9160', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9161', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9162', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9163', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9164', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9165', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9166', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9167', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9168', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9169', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9170', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9171', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9172', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9173', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9174', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9175', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9176', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9177', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9178', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9179', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9180', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9181', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9182', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9183', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9184', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9185', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9186', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9187', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9188', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9189', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9190', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9191', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9192', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9193', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9194', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9195', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9196', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9197', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9198', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9199', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9200', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9201', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9202', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9203', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9204', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9205', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9206', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9207', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9208', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9209', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9210', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9211', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9212', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9213', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9214', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9215', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9216', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9217', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9218', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9219', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9220', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9221', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9222', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9223', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9224', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9225', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9226', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9227', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9228', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9229', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9230', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9231', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9232', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9233', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9234', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9235', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9236', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9237', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9238', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9239', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9240', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9241', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9242', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9243', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9244', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9245', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9246', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9247', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9248', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9249', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9250', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9251', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9252', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9253', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9254', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9255', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9256', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9257', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9258', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9259', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9260', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9261', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9262', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9263', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9264', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9265', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9266', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9267', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9268', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9269', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9270', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9271', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9272', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9273', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9274', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9275', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9276', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9277', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9278', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9279', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9280', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9281', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9282', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9283', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9284', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9285', '今天（02月06日）是客户 陈春鸣 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('9286', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9287', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9288', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9289', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9290', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9291', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9292', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9293', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9294', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9295', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9296', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9297', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9298', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9299', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9300', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9301', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9302', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9303', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9304', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9305', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9306', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9307', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9308', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9309', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9310', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9311', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9312', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9313', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9314', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9315', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9316', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9317', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9318', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9319', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9320', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9321', '再过7天（02月14日）就是客户 魏昕 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9322', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9323', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9324', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9325', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9326', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9327', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9328', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9329', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9330', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9331', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9332', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9333', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9334', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9335', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9336', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9337', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9338', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9339', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9340', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9341', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9342', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9343', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9344', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9345', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9346', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9347', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9348', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9349', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9350', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9351', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9352', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9353', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9354', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9355', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9356', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9357', '今天（02月08日）是客户 居飞 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('9358', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9359', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9360', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9361', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9362', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9363', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9364', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9365', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9366', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9367', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9368', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9369', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9370', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9371', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9372', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9373', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9374', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9375', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9376', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9377', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9378', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9379', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9380', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9381', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9382', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9383', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9384', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9385', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9386', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9387', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9388', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9389', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9390', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9391', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9392', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9393', '再过7天（02月16日）就是客户 杨帆 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9394', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9395', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9396', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9397', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9398', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9399', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9400', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9401', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9402', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9403', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9404', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9405', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9406', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9407', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9408', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9409', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9410', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9411', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9412', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9413', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9414', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9415', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9416', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9417', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9418', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9419', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9420', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9421', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9422', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9423', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9424', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9425', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9426', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9427', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9428', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9429', '再过7天（02月17日）就是客户 张岩 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9430', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9431', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9432', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9433', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9434', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9435', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9436', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9437', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9438', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9439', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9440', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9441', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9442', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9443', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9444', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9445', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9446', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9447', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9448', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9449', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9450', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9451', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9452', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9453', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9454', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9455', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9456', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9457', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9458', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9459', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9460', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9461', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9462', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9463', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9464', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9465', '再过7天（02月18日）就是客户 陈永春 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9466', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9467', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9468', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9469', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9470', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9471', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9472', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9473', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9474', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9475', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9476', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9477', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9478', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9479', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9480', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9481', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9482', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9483', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9484', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9485', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9486', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9487', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9488', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9489', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9490', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9491', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9492', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9493', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9494', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9495', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9496', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9497', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9498', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9499', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9500', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9501', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9502', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9503', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9504', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9505', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9506', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9507', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9508', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9509', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9510', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9511', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9512', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9513', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9514', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9515', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9516', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9517', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9518', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9519', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9520', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9521', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9522', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9523', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9524', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9525', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9526', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9527', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9528', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9529', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9530', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9531', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9532', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9533', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9534', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9535', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9536', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9537', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9538', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9539', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9540', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9541', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9542', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9543', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9544', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9545', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9546', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9547', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9548', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9549', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9550', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9551', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9552', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9553', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9554', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9555', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9556', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9557', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9558', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9559', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9560', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9561', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9562', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9563', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9564', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9565', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9566', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9567', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9568', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9569', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9570', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9571', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9572', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9573', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9574', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9575', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9576', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9577', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9578', '客户胡敏敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9579', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9580', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9581', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9582', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9583', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9584', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9585', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9586', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9587', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9588', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9589', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9590', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9591', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9592', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9593', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9594', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9595', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9596', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9597', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9598', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9599', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9600', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9601', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9602', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9603', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9604', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9605', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9606', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9607', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9608', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9609', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9610', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9611', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9612', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9613', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9614', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9615', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9616', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9617', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9618', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9619', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9620', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9621', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9622', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9623', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9624', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9625', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9626', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9627', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9628', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9629', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9630', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9631', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9632', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9633', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9634', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9635', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9636', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9637', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9638', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9639', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9640', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9641', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9642', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9643', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9644', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9645', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9646', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9647', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9648', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9649', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9650', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9651', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9652', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9653', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9654', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9655', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9656', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9657', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9658', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9659', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9660', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9661', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9662', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9663', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9664', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9665', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9666', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9667', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9668', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9669', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9670', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9671', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9672', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9673', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9674', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9675', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9676', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9677', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9678', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9679', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9680', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9681', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9682', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9683', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9684', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9685', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9686', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9687', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9688', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9689', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9690', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9691', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9692', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9693', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9694', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9695', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9696', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9697', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9698', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9699', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9700', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9701', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9702', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9703', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9704', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9705', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9706', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9707', '客户胡敏敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9708', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9709', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9710', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9711', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9712', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9713', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9714', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9715', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9716', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9717', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9718', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9719', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9720', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9721', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9722', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9723', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9724', '再过7天（02月20日）就是客户 张柯 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9725', '再过7天（02月20日）就是客户 陈逸非 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('9726', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9727', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9728', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9729', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9730', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9731', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9732', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9733', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9734', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9735', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9736', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9737', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9738', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9739', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9740', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9741', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9742', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9743', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9744', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9745', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9746', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9747', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9748', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9749', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9750', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9751', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9752', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9753', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9754', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9755', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9756', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9757', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9758', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9759', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9760', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9761', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9762', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9763', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9764', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9765', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9766', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9767', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9768', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9769', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9770', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9771', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9772', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9773', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9774', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9775', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9776', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9777', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9778', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9779', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9780', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9781', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9782', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9783', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9784', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9785', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9786', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9787', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9788', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9789', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9790', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9791', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9792', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9793', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9794', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9795', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9796', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9797', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9798', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9799', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9800', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9801', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9802', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9803', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9804', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9805', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9806', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9807', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9808', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9809', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9810', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9811', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9812', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9813', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9814', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9815', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9816', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9817', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9818', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9819', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9820', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9821', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9822', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9823', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9824', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9825', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9826', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9827', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9828', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9829', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9830', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9831', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9832', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9833', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9834', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9835', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9836', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9837', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9838', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9839', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9840', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9841', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9842', '客户胡敏敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9843', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9844', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9845', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9846', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9847', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9848', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9849', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9850', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9851', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9852', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9853', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9854', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9855', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9856', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9857', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9858', '今天（02月14日）是客户 魏昕 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('9859', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9860', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9861', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9862', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9863', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9864', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9865', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9866', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9867', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9868', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9869', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9870', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9871', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9872', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9873', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9874', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9875', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9876', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9877', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9878', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9879', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9880', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9881', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9882', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9883', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9884', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9885', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9886', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9887', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9888', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9889', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9890', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9891', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9892', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9893', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9894', '客户曾亚玉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9895', '客户金松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9896', '客户杨政已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9897', '客户姜洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9898', '客户周万香已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9899', '客户王晓波已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9900', '客户袁国华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9901', '客户吴煜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9902', '客户辛朝晖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9903', '客户陈逸非已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9904', '客户盛海英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9905', '客户曹亚群已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9906', '客户花峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9907', '客户王薇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9908', '客户杨勤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9909', '客户葛浩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9910', '客户李方喜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9911', '客户季伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9912', '客户徐宇清已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9913', '客户马秋晨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9914', '客户曹永琅已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9915', '客户蒋立已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9916', '客户王菁之已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9917', '客户吴凡已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9918', '客户于滨已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9919', '客户傅江安已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9920', '客户许剑峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9921', '客户陈春艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9922', '客户翁庆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9923', '客户郑子进已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9924', '客户朱传禄已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9925', '客户方健已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9926', '客户马征已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9927', '客户诸楷文已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9928', '客户沈泰来已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9929', '客户张煦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9930', '客户罗绪红已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9931', '客户李敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9932', '客户赵丽琴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9933', '客户张皓已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9934', '客户陈刚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9935', '客户沈加东已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9936', '客户杨斐斐已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9937', '客户何军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9938', '客户徐苏宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9939', '客户丁志英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9940', '客户万方已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9941', '客户蒋辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9942', '客户陈少金已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9943', '客户魏云贞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9944', '客户俞彪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9945', '客户李尤已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9946', '客户陆大志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9947', '客户陈后军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9948', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9949', '客户郝茹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9950', '客户陈永春已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9951', '客户雷牧已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9952', '客户汪雪松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9953', '客户15905236633已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9954', '客户王亚南已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9955', '客户郭东辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9956', '客户杨卫星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9957', '客户季宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9958', '客户姚钟昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9959', '客户童星已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9960', '客户张柯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9961', '客户黄裕光已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9962', '客户魏振宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9963', '客户王平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9964', '客户陈润民已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9965', '客户沈雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9966', '客户魏昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9967', '客户田英已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9968', '客户赵弘已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9969', '客户丁岑萱已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9970', '客户黄艳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9971', '客户张宇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9972', '客户吴瀚侠已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9973', '客户李琦已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9974', '客户张冀中已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9975', '客户胡敏敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9976', '客户汪之婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9977', '客户江玉华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9978', '客户莫若雯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9979', '客户丁文宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9980', '客户徐明遥已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9981', '客户陈琪已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9982', '客户王翀已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9983', '客户祝娜已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9984', '客户谈素珍已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9985', '客户曹欢已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9986', '客户马运山已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9987', '客户刘志远已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9988', '客户李铁蕴已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9989', '客户张劲松已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9990', '客户朱凌志已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9991', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9992', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9993', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9994', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9995', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9996', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9997', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9998', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('9999', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10000', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10001', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10002', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10003', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10004', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10005', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10006', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10007', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10008', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10009', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10010', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10011', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10012', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10013', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10014', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10015', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10016', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10017', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10018', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10019', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10020', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10021', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10022', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10023', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10024', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10025', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10026', '今天（02月16日）是客户 杨帆 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10027', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10028', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10029', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10030', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10031', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10032', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10033', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10034', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10035', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10036', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10037', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10038', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10039', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10040', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10041', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10042', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10043', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10044', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10045', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10046', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10047', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10048', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10049', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10050', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10051', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10052', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10053', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10054', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10055', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10056', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10057', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10058', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10059', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10060', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10061', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10062', '再过7天（02月24日）就是客户 陈后军 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10063', '今天（02月17日）是客户 张岩 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10064', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10065', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10066', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10067', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10068', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10069', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10070', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10071', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10072', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10073', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10074', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10075', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10076', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10077', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10078', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10079', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10080', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10081', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10082', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10083', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10084', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10085', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10086', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10087', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10088', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10089', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10090', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10091', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10092', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10093', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10094', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10095', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10096', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10097', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10098', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10099', '今天（02月18日）是客户 陈永春 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10100', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10101', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10102', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10103', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10104', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10105', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10106', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10107', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10108', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10109', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10110', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10111', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10112', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10113', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10114', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10115', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10116', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10117', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10118', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10119', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10120', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10121', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10122', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10123', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10124', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10125', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10126', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10127', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10128', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10129', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10130', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10131', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10132', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10133', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10134', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10135', '再过7天（02月26日）就是客户 花峻 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10136', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10137', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10138', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10139', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10140', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10141', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10142', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10143', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10144', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10145', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10146', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10147', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10148', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10149', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10150', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10151', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10152', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10153', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10154', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10155', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10156', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10157', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10158', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10159', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10160', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10161', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10162', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10163', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10164', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10165', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10166', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10167', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10168', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10169', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10170', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10171', '今天（02月20日）是客户 陈逸非 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10172', '今天（02月20日）是客户 张柯 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10173', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10174', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10175', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10176', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10177', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10178', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10179', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10180', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10181', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10182', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10183', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10184', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10185', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10186', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10187', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10188', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10189', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10190', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10191', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10192', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10193', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10194', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10195', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10196', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10197', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10198', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10199', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10200', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10201', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10202', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10203', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10204', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10205', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10206', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10207', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10208', '再过7天（02月28日）就是客户 许剑峰 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10209', '再过7天（02月28日）就是客户 俞彪 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10210', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10211', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10212', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10213', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10214', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10215', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10216', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10217', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10218', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10219', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10220', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10221', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10222', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10223', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10224', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10225', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10226', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10227', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10228', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10229', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10230', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10231', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10232', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10233', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10234', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10235', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10236', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10237', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10238', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10239', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10240', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10241', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10242', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10243', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10244', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10245', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10246', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10247', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10248', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10249', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10250', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10251', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10252', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10253', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10254', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10255', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10256', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10257', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10258', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10259', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10260', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10261', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10262', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10263', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10264', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10265', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10266', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10267', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10268', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10269', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10270', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10271', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10272', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10273', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10274', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10275', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10276', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10277', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10278', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10279', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10280', '再过7天（03月02日）就是客户 朱传禄 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10281', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10282', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10283', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10284', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10285', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10286', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10287', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10288', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10289', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10290', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10291', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10292', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10293', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10294', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10295', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10296', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10297', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10298', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10299', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10300', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10301', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10302', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10303', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10304', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10305', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10306', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10307', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10308', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10309', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10310', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10311', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10312', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10313', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10314', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10315', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10316', '今天（02月24日）是客户 陈后军 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10317', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10318', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10319', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10320', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10321', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10322', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10323', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10324', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10325', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10326', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10327', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10328', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10329', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10330', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10331', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10332', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10333', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10334', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10335', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10336', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10337', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10338', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10339', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10340', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10341', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10342', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10343', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10344', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10345', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10346', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10347', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10348', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10349', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10350', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10351', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10352', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10353', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10354', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10355', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10356', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10357', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10358', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10359', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10360', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10361', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10362', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10363', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10364', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10365', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10366', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10367', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10368', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10369', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10370', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10371', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10372', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10373', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10374', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10375', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10376', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10377', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10378', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10379', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10380', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10381', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10382', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10383', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10384', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10385', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10386', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10387', '再过7天（03月05日）就是客户 陈其韡 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10388', '再过7天（03月05日）就是客户 王平 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10389', '今天（02月26日）是客户 花峻 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10390', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10391', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10392', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10393', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10394', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10395', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10396', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10397', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10398', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10399', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10400', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10401', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10402', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10403', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10404', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10405', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10406', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10407', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10408', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10409', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10410', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10411', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10412', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10413', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10414', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10415', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10416', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10417', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10418', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10419', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10420', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10421', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10422', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10423', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10424', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10425', '再过7天（03月06日）就是客户 陈春艳 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10426', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10427', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10428', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10429', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10430', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10431', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10432', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10433', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10434', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10435', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10436', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10437', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10438', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10439', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10440', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10441', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10442', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10443', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10444', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10445', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10446', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10447', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10448', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10449', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10450', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10451', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10452', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10453', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10454', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10455', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10456', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10457', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10458', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10459', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10460', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10461', '再过7天（03月07日）就是客户 汪之婷 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10462', '再过7天（03月07日）就是客户 汪雪松 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10463', '今天（02月28日）是客户 许剑峰 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10464', '今天（02月28日）是客户 俞彪 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10465', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10466', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10467', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10468', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10469', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10470', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10471', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10472', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10473', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10474', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10475', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10476', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10477', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10478', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10479', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10480', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10481', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10482', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10483', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10484', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10485', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10486', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10487', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10488', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10489', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10490', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10491', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10492', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10493', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10494', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10495', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10496', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10497', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10498', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10499', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10500', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10501', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10502', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10503', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10504', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10505', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10506', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10507', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10508', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10509', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10510', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10511', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10512', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10513', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10514', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10515', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10516', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10517', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10518', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10519', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10520', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10521', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10522', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10523', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10524', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10525', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10526', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10527', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10528', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10529', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10530', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10531', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10532', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10533', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10534', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10535', '今天（03月02日）是客户 朱传禄 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10536', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10537', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10538', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10539', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10540', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10541', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10542', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10543', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10544', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10545', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10546', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10547', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10548', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10549', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10550', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10551', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10552', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10553', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10554', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10555', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10556', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10557', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10558', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10559', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10560', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10561', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10562', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10563', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10564', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10565', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10566', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10567', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10568', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10569', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10570', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10571', '再过7天（03月10日）就是客户 马运山 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10572', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10573', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10574', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10575', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10576', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10577', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10578', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10579', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10580', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10581', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10582', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10583', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10584', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10585', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10586', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10587', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10588', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10589', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10590', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10591', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10592', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10593', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10594', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10595', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10596', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10597', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10598', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10599', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10600', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10601', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10602', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10603', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10604', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10605', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10606', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10607', '客户毛发强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10608', '客户熊伟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10609', '客户杨帆已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10610', '客户戚世杰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10611', '客户吴岭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10612', '客户林强已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10613', '客户郭知臣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10614', '客户龚洁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10615', '客户杭文霞已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10616', '客户李荣农已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10617', '客户袁军荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10618', '客户沈瑾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10619', '客户李宁已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10620', '客户沈敏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10621', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10622', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10623', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10624', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10625', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10626', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10627', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10628', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10629', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10630', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10631', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10632', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10633', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10634', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10635', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10636', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10637', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10638', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10639', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10640', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10641', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10642', '再过7天（03月12日）就是客户 张宇 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10643', '今天（03月05日）是客户 陈其韡 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10644', '今天（03月05日）是客户 王平 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10645', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10646', '客户周岩岩已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10647', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10648', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10649', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10650', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10651', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10652', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10653', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10654', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10655', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10656', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10657', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10658', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10659', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10660', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10661', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10662', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10663', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10664', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10665', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10666', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10667', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10668', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10669', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10670', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10671', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10672', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10673', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10674', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10675', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10676', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10677', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10678', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10679', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10680', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10681', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10682', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10683', '今天（03月06日）是客户 陈春艳 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10684', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10685', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10686', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10687', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10688', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10689', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10690', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10691', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10692', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10693', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10694', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10695', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10696', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10697', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10698', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10699', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10700', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10701', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10702', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10703', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10704', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10705', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10706', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10707', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10708', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10709', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10710', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10711', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10712', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10713', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10714', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10715', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10716', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10717', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10718', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10719', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10720', '再过7天（03月14日）就是客户 周万香 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10721', '今天（03月07日）是客户 汪之婷 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10722', '今天（03月07日）是客户 汪雪松 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10723', '客户季宁  （范文）已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10724', '客户李达已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10725', '客户张素芬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10726', '客户陈宁海已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10727', '客户徐璇已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10728', '客户肖爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10729', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10730', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10731', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10732', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10733', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10734', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10735', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10736', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10737', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10738', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10739', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10740', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10741', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10742', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10743', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10744', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10745', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10746', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10747', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10748', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10749', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10750', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10751', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10752', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10753', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10754', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10755', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10756', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10757', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10758', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10759', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10760', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10761', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10762', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10763', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10764', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10765', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10766', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10767', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10768', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10769', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10770', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10771', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10772', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10773', '再过7天（03月15日）就是客户 丁志英 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10774', '再过7天（03月15日）就是客户 曹永琅 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10775', '再过7天（03月15日）就是客户 王平 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10776', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10777', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10778', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10779', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10780', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10781', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10782', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10783', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10784', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10785', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10786', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10787', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10788', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10789', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10790', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10791', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10792', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10793', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10794', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10795', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10796', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10797', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10798', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10799', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10800', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10801', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10802', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10803', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10804', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10805', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10806', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10807', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10808', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10809', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10810', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10811', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10812', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10813', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10814', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10815', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10816', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10817', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10818', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10819', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10820', '再过7天（03月16日）就是客户 张素芬 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10821', '再过7天（03月16日）就是客户 王菁之 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('10822', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10823', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10824', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10825', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10826', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10827', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10828', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10829', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10830', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10831', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10832', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10833', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10834', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10835', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10836', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10837', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10838', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10839', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10840', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10841', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10842', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10843', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10844', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10845', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10846', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10847', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10848', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10849', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10850', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10851', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10852', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10853', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10854', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10855', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10856', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10857', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10858', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10859', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10860', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10861', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10862', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10863', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10864', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10865', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10866', '今天（03月10日）是客户 马运山 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10867', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10868', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10869', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10870', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10871', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10872', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10873', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10874', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10875', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10876', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10877', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10878', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10879', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10880', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10881', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10882', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10883', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10884', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10885', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10886', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10887', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10888', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10889', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10890', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10891', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10892', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10893', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10894', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10895', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10896', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10897', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10898', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10899', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10900', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10901', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10902', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10903', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10904', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10905', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10906', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10907', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10908', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10909', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10910', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10911', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10912', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10913', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10914', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10915', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10916', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10917', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10918', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10919', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10920', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10921', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10922', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10923', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10924', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10925', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10926', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10927', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10928', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10929', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10930', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10931', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10932', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10933', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10934', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10935', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10936', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10937', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10938', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10939', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10940', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10941', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10942', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10943', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10944', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10945', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10946', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10947', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10948', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10949', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10950', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10951', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10952', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10953', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10954', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10955', '今天（03月12日）是客户 张宇 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('10956', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10957', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10958', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10959', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10960', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10961', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10962', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10963', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10964', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10965', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10966', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10967', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10968', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10969', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10970', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10971', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10972', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10973', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10974', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10975', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10976', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10977', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10978', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10979', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10980', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10981', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10982', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10983', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10984', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10985', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10986', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10987', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10988', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10989', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10990', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10991', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10992', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10993', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10994', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10995', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10996', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10997', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10998', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('10999', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11000', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11001', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11002', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11003', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11004', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11005', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11006', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11007', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11008', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11009', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11010', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11011', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11012', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11013', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11014', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11015', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11016', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11017', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11018', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11019', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11020', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11021', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11022', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11023', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11024', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11025', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11026', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11027', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11028', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11029', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11030', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11031', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11032', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11033', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11034', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11035', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11036', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11037', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11038', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11039', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11040', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11041', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11042', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11043', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11044', '今天（03月14日）是客户 周万香 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11045', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11046', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11047', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11048', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11049', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11050', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11051', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11052', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11053', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11054', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11055', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11056', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11057', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11058', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11059', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11060', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11061', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11062', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11063', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11064', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11065', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11066', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11067', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11068', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11069', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11070', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11071', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11072', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11073', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11074', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11075', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11076', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11077', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11078', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11079', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11080', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11081', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11082', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11083', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11084', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11085', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11086', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11087', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11088', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11089', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11090', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11091', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11092', '今天（03月15日）是客户 丁志英 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11093', '今天（03月15日）是客户 曹永琅 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11094', '今天（03月15日）是客户 王平 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11095', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11096', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11097', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11098', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11099', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11100', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11101', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11102', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11103', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11104', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11105', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11106', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11107', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11108', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11109', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11110', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11111', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11112', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11113', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11114', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11115', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11116', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11117', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11118', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11119', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11120', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11121', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11122', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11123', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11124', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11125', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11126', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11127', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11128', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11129', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11130', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11131', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11132', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11133', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11134', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11135', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11136', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11137', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11138', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11139', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11140', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11141', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11142', '再过7天（03月23日）就是客户 万纤月 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11143', '再过7天（03月23日）就是客户 辛朝晖 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11144', '今天（03月16日）是客户 张素芬 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11145', '今天（03月16日）是客户 王菁之 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11146', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11147', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11148', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11149', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11150', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11151', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11152', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11153', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11154', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11155', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11156', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11157', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11158', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11159', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11160', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11161', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11162', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11163', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11164', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11165', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11166', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11167', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11168', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11169', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11170', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11171', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11172', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11173', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11174', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11175', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11176', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11177', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11178', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11179', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11180', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11181', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11182', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11183', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11184', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11185', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11186', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11187', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11188', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11189', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11190', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11191', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11192', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11193', '再过7天（03月24日）就是客户 孙旸 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11194', '再过7天（03月24日）就是客户 张雪琴 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11195', '客户曹阳已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11196', '客户张莉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11197', '客户何宏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11198', '客户倪雪峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11199', '客户韩荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11200', '客户张云鹏已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11201', '客户季梦坚已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11202', '客户王昱媛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11203', '客户卢兴国已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11204', '客户范国丹已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11205', '客户吴琼已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11206', '客户王玮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11207', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11208', '客户陈祥彬已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11209', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11210', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11211', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11212', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11213', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11214', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11215', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11216', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11217', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11218', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11219', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11220', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11221', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11222', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11223', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11224', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11225', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11226', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11227', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11228', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11229', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11230', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11231', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11232', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11233', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11234', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11235', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11236', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11237', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11238', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11239', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11240', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11241', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11242', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11243', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11244', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11245', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11246', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11247', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11248', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11249', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11250', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11251', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11252', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11253', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11254', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11255', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11256', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11257', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11258', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11259', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11260', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11261', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11262', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11263', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11264', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11265', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11266', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11267', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11268', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11269', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11270', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11271', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11272', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11273', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11274', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11275', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11276', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11277', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11278', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11279', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11280', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11281', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11282', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11283', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11284', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11285', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11286', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11287', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11288', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11289', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11290', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11291', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11292', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11293', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11294', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11295', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11296', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11297', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11298', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11299', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11300', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11301', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11302', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11303', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11304', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11305', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11306', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11307', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11308', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11309', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11310', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11311', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11312', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11313', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11314', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11315', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11316', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11317', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11318', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11319', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11320', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11321', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11322', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11323', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11324', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11325', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11326', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11327', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11328', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11329', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11330', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11331', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11332', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11333', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11334', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11335', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11336', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11337', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11338', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11339', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11340', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11341', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11342', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11343', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11344', '再过7天（03月28日）就是客户 陈刚 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11345', '再过7天（03月28日）就是客户 诸楷文 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11346', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11347', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11348', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11349', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11350', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11351', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11352', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11353', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11354', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11355', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11356', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11357', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11358', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11359', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11360', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11361', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11362', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11363', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11364', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11365', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11366', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11367', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11368', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11369', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11370', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11371', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11372', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11373', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11374', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11375', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11376', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11377', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11378', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11379', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11380', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11381', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11382', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11383', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11384', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11385', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11386', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11387', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11388', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11389', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11390', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11391', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11392', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11393', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11394', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11395', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11396', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11397', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11398', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11399', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11400', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11401', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11402', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11403', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11404', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11405', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11406', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11407', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11408', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11409', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11410', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11411', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11412', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11413', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11414', '今天（03月23日）是客户 万纤月 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11415', '今天（03月23日）是客户 辛朝晖 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11416', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11417', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11418', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11419', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11420', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11421', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11422', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11423', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11424', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11425', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11426', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11427', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11428', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11429', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11430', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11431', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11432', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11433', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11434', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11435', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11436', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11437', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11438', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11439', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11440', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11441', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11442', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11443', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11444', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11445', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11446', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11447', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11448', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11449', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11450', '再过7天（03月31日）就是客户 张皓 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11451', '今天（03月24日）是客户 孙旸 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11452', '今天（03月24日）是客户 张雪琴 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11453', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11454', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11455', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11456', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11457', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11458', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11459', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11460', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11461', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11462', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11463', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11464', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11465', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11466', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11467', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11468', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11469', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11470', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11471', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11472', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11473', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11474', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11475', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11476', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11477', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11478', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11479', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11480', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11481', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11482', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11483', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11484', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11485', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11486', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11487', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11488', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11489', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11490', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11491', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11492', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11493', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11494', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11495', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11496', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11497', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11498', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11499', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11500', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11501', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11502', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11503', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11504', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11505', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11506', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11507', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11508', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11509', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11510', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11511', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11512', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11513', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11514', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11515', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11516', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11517', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11518', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11519', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11520', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11521', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11522', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11523', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11524', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11525', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11526', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11527', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11528', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11529', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11530', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11531', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11532', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11533', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11534', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11535', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11536', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11537', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11538', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11539', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11540', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11541', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11542', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11543', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11544', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11545', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11546', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11547', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11548', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11549', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11550', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11551', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11552', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11553', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11554', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11555', '再过7天（04月03日）就是客户 李宁 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11556', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11557', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11558', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11559', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11560', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11561', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11562', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11563', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11564', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11565', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11566', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11567', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11568', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11569', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11570', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11571', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11572', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11573', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11574', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11575', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11576', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11577', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11578', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11579', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11580', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11581', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11582', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11583', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11584', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11585', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11586', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11587', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11588', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11589', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11590', '今天（03月28日）是客户 陈刚 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11591', '今天（03月28日）是客户 诸楷文 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11592', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11593', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11594', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11595', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11596', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11597', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11598', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11599', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11600', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11601', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11602', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11603', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11604', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11605', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11606', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11607', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11608', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11609', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11610', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11611', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11612', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11613', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11614', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11615', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11616', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11617', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11618', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11619', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11620', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11621', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11622', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11623', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11624', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11625', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11626', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11627', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11628', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11629', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11630', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11631', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11632', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11633', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11634', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11635', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11636', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11637', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11638', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11639', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11640', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11641', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11642', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11643', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11644', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11645', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11646', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11647', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11648', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11649', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11650', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11651', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11652', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11653', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11654', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11655', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11656', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11657', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11658', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11659', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11660', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11661', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11662', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11663', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11664', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11665', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11666', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11667', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11668', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11669', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11670', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11671', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11672', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11673', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11674', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11675', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11676', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11677', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11678', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11679', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11680', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11681', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11682', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11683', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11684', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11685', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11686', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11687', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11688', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11689', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11690', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11691', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11692', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11693', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11694', '再过7天（04月07日）就是客户 魏云贞 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11695', '今天（03月31日）是客户 张皓 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11696', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11697', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11698', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11699', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11700', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11701', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11702', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11703', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11704', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11705', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11706', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11707', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11708', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11709', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11710', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11711', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11712', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11713', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11714', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11715', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11716', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11717', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11718', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11719', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11720', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11721', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11722', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11723', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11724', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11725', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11726', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11727', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11728', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11729', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11730', '再过7天（04月08日）就是客户 刘志远 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11731', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11732', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11733', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11734', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11735', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11736', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11737', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11738', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11739', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11740', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11741', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11742', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11743', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11744', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11745', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11746', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11747', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11748', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11749', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11750', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11751', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11752', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11753', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11754', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11755', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11756', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11757', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11758', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11759', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11760', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11761', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11762', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11763', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11764', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11765', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11766', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11767', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11768', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11769', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11770', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11771', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11772', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11773', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11774', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11775', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11776', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11777', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11778', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11779', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11780', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11781', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11782', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11783', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11784', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11785', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11786', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11787', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11788', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11789', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11790', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11791', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11792', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11793', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11794', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11795', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11796', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11797', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11798', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11799', '今天（04月03日）是客户 李宁 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11800', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11801', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11802', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11803', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11804', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11805', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11806', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11807', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11808', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11809', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11810', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11811', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11812', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11813', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11814', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11815', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11816', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11817', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11818', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11819', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11820', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11821', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11822', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11823', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11824', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11825', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11826', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11827', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11828', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11829', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11830', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11831', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11832', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11833', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11834', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11835', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11836', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11837', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11838', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11839', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11840', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11841', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11842', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11843', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11844', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11845', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11846', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11847', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11848', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11849', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11850', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11851', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11852', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11853', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11854', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11855', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11856', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11857', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11858', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11859', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11860', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11861', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11862', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11863', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11864', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11865', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11866', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11867', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11868', '再过7天（04月12日）就是客户 陈宁海 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11869', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11870', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11871', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11872', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11873', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11874', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11875', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11876', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11877', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11878', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11879', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11880', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11881', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11882', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11883', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11884', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11885', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11886', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11887', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11888', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11889', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11890', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11891', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11892', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11893', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11894', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11895', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11896', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11897', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11898', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11899', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11900', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11901', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11902', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11903', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11904', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11905', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11906', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11907', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11908', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11909', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11910', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11911', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11912', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11913', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11914', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11915', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11916', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11917', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11918', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11919', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11920', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11921', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11922', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11923', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11924', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11925', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11926', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11927', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11928', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11929', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11930', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11931', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11932', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11933', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11934', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11935', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11936', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11937', '今天（04月07日）是客户 魏云贞 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11938', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11939', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11940', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11941', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11942', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11943', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11944', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11945', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11946', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11947', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11948', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11949', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11950', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11951', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11952', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11953', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11954', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11955', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11956', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11957', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11958', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11959', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11960', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11961', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11962', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11963', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11964', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11965', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11966', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11967', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11968', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11969', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11970', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11971', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11972', '再过7天（04月15日）就是客户 陈耀武 的生日了，记得准备礼物哦！');
INSERT INTO `sys_msg_content` VALUES ('11973', '今天（04月08日）是客户 刘志远 的生日，别忘了送上一声祝福。');
INSERT INTO `sys_msg_content` VALUES ('11974', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11975', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11976', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11977', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11978', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11979', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11980', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11981', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11982', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11983', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11984', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11985', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11986', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11987', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11988', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11989', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11990', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11991', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11992', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11993', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11994', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11995', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11996', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11997', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11998', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('11999', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12000', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12001', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12002', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12003', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12004', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12005', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12006', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12007', '客户余鹏武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12008', '客户李馨蕾已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12009', '客户朱贵云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12010', '客户万纤月已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12011', '客户耿爽已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12012', '客户颜辉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12013', '客户邵润青已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12014', '客户尹慧玲已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12015', '客户沈志峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12016', '客户骆开云已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12017', '客户李峻已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12018', '客户费嘉已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12019', '客户任文娟已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12020', '客户秦峰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12021', '客户顾昕已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12022', '客户许家荣已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12023', '客户徐影已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12024', '客户胡家平已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12025', '客户陈英明已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12026', '客户李颖已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12027', '客户杨旭已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12028', '客户吴涛已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12029', '客户陈耀武已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12030', '客户周炎昌已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12031', '客户郭映已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12032', '客户蔡紫兰已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12033', '客户袁翯已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12034', '客户刘建华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12035', '客户王文婷已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12036', '客户孙旸已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12037', '客户刘新军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12038', '客户黄明亮已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12039', '客户徐维军已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12040', '客户吕华已经有超过90没有拜访过了。');
INSERT INTO `sys_msg_content` VALUES ('12041', '客户余鹏武已经有超过90没有拜访过了。');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_organization
-- ----------------------------
INSERT INTO `sys_organization` VALUES ('1', null, '-1', '2017-12-26 18:49:36', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '江苏健安建筑管理有限公司', '江苏健安建筑管理有限公司', '1', 'A', '0', null, 'ORG_O2FYJRZ4');
INSERT INTO `sys_organization` VALUES ('2', null, '-1', '2018-02-24 09:39:20', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '生产管理部', '江苏健安建筑管理有限公司/生产管理部', '2', 'A', '1', null, 'ORG_3KSD4UFH');
INSERT INTO `sys_organization` VALUES ('3', null, '-1', '2018-02-24 09:39:26', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '工程技术部', '江苏健安建筑管理有限公司/工程技术部', '2', 'A', '1', null, 'ORG_F000CHXB');
INSERT INTO `sys_organization` VALUES ('4', null, '-1', '2018-02-24 09:39:42', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '商务部', '江苏健安建筑管理有限公司/商务部', '2', 'A', '1', null, 'ORG_11KUFWBT');
INSERT INTO `sys_organization` VALUES ('5', null, '-1', '2018-02-24 09:39:47', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '安全部', '江苏健安建筑管理有限公司/安全部', '2', 'A', '1', null, 'ORG_U2VC2VKD');
INSERT INTO `sys_organization` VALUES ('6', null, '-1', '2018-02-24 09:39:55', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '质量部', '江苏健安建筑管理有限公司/质量部', '2', 'A', '1', null, 'ORG_6E2WRY58');
INSERT INTO `sys_organization` VALUES ('7', null, '-1', '2020-05-29 18:35:41', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '财务部', '江苏健安建筑管理有限公司/财务部', '2', 'A', '1', null, 'ORG_KW0QMEO3');
INSERT INTO `sys_organization` VALUES ('8', null, '-1', '2020-06-06 07:03:14', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '项目管理领导小组', '江苏健安建筑管理有限公司/项目管理领导小组', '2', 'A', '1', null, 'ORG_4CWMTH5P');
INSERT INTO `sys_organization` VALUES ('9', null, '-1', '2020-06-06 07:03:26', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '项目行政管理办公室', '江苏健安建筑管理有限公司/项目行政管理办公室', '2', 'A', '1', null, 'ORG_F4K1YFZB');
INSERT INTO `sys_organization` VALUES ('10', null, '-1', '2020-06-06 07:05:57', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '分包单位', '江苏健安建筑管理有限公司/分包单位', '2', 'A', '1', null, 'ORG_G2Q21VIM');
INSERT INTO `sys_organization` VALUES ('11', null, '-1', '2020-06-06 07:06:39', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '劳务部', '江苏健安建筑管理有限公司/劳务部', '2', 'A', '1', null, 'ORG_IJEJP78H');

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_org_user_link
-- ----------------------------
INSERT INTO `sys_org_user_link` VALUES ('23', '1', '0', '1', '20');
INSERT INTO `sys_org_user_link` VALUES ('46', '1', '0', '2', '43');
INSERT INTO `sys_org_user_link` VALUES ('47', '1', '0', '2', '44');
INSERT INTO `sys_org_user_link` VALUES ('48', '1', '0', '3', '45');
INSERT INTO `sys_org_user_link` VALUES ('49', '1', '0', '3', '46');
INSERT INTO `sys_org_user_link` VALUES ('50', '1', '0', '4', '47');
INSERT INTO `sys_org_user_link` VALUES ('51', '1', '0', '5', '48');
INSERT INTO `sys_org_user_link` VALUES ('52', '1', '0', '6', '49');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

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
INSERT INTO `sys_password_history` VALUES ('22', 'E10ADC3949BA59ABBE56E057F20F883E', '2020-05-29 19:01:04', 'DA0E5C17E1EDD9FC4E2985A786769F2A', '43', '1589936129528');
INSERT INTO `sys_password_history` VALUES ('23', '213E0B3979ECF2562087B03F04D0273B', '2020-06-06 07:07:52', '1BDED42A1FF437EA7259880AAD94ED82', '20', '1590584537439');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '-1', '第一负责人', '0', '项目经理', 'PROJECT_MANAGER');
INSERT INTO `sys_role` VALUES ('2', '-1', '主管项目安全', '0', '安全总监', 'SAFETY_DIRECTOR');
INSERT INTO `sys_role` VALUES ('3', '-1', '负责项目运营一般事务', '0', '常务副经理', 'EXECUTIVE_MANAGER');
INSERT INTO `sys_role` VALUES ('4', '-1', '负责技术把关', '0', '总工程师', 'CHIEF_ENGINEER');

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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_menu_link
-- ----------------------------
INSERT INTO `sys_role_menu_link` VALUES ('11', '2', '3');
INSERT INTO `sys_role_menu_link` VALUES ('12', '5', '3');
INSERT INTO `sys_role_menu_link` VALUES ('27', '1', '2');
INSERT INTO `sys_role_menu_link` VALUES ('42', '21', '2');
INSERT INTO `sys_role_menu_link` VALUES ('46', '20', '3');
INSERT INTO `sys_role_menu_link` VALUES ('47', '20', '3');
INSERT INTO `sys_role_menu_link` VALUES ('75', '29', '1');
INSERT INTO `sys_role_menu_link` VALUES ('76', '30', '1');
INSERT INTO `sys_role_menu_link` VALUES ('77', '31', '1');
INSERT INTO `sys_role_menu_link` VALUES ('78', '32', '1');
INSERT INTO `sys_role_menu_link` VALUES ('79', '33', '1');
INSERT INTO `sys_role_menu_link` VALUES ('80', '34', '1');
INSERT INTO `sys_role_menu_link` VALUES ('81', '35', '1');
INSERT INTO `sys_role_menu_link` VALUES ('82', '36', '1');
INSERT INTO `sys_role_menu_link` VALUES ('83', '37', '1');
INSERT INTO `sys_role_menu_link` VALUES ('84', '38', '1');
INSERT INTO `sys_role_menu_link` VALUES ('85', '39', '1');
INSERT INTO `sys_role_menu_link` VALUES ('86', '40', '1');
INSERT INTO `sys_role_menu_link` VALUES ('87', '41', '1');
INSERT INTO `sys_role_menu_link` VALUES ('88', '42', '1');
INSERT INTO `sys_role_menu_link` VALUES ('89', '43', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_user_link
-- ----------------------------
INSERT INTO `sys_role_user_link` VALUES ('1', '1', '1', '1');
INSERT INTO `sys_role_user_link` VALUES ('19', '0', '1', '20');
INSERT INTO `sys_role_user_link` VALUES ('57', '0', '2', '43');

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_url_menu
-- ----------------------------
INSERT INTO `sys_url_menu` VALUES ('29', null, '-1', '0', 'fa-fort-awesome', '#16A5A5', '组织机构与人员', '1', '0', '1', '0', '');
INSERT INTO `sys_url_menu` VALUES ('30', null, '-1', '0', 'fa-users', '#16A5A5', '部门与人员', '1', '29', '1', '1', 'jsp/system/user-management.jsp');
INSERT INTO `sys_url_menu` VALUES ('31', null, '-1', '0', 'fa-get-pocket', '#16A5A5', '关键岗位设置', '2', '29', '1', '1', 'jsp/employee/employee-management.jsp');
INSERT INTO `sys_url_menu` VALUES ('32', null, '-1', '0', 'fa-object-group', '#16A5A5', '测试组', '3', '29', '1', '1', 'jsp/employee/employee-group.jsp');
INSERT INTO `sys_url_menu` VALUES ('33', null, '-1', '0', 'fa-cogs', '#16A5A5', '责任与权限', '2', '0', '1', '0', '');
INSERT INTO `sys_url_menu` VALUES ('34', null, '-1', '0', 'fa-steam-square', '#16A5A5', '关键角色', '1', '33', '1', '1', 'jsp/system/role-management.jsp');
INSERT INTO `sys_url_menu` VALUES ('35', null, '-1', '0', 'fa-flag-checkered', '#16A5A5', '部门责任定义', '2', '33', '1', '1', 'jsp/jat/response/jat_resp_dep.jsp');
INSERT INTO `sys_url_menu` VALUES ('36', null, '-1', '0', 'fa-flag', '#16A5A5', '人员责任定义', '3', '33', '1', '1', 'jsp/jat/response/jat_resp_dep.jsp');
INSERT INTO `sys_url_menu` VALUES ('37', null, '-1', '0', 'fa-address-card', '#16A5A5', '任务管理', '3', '0', '1', '0', '');
INSERT INTO `sys_url_menu` VALUES ('38', null, '-1', '0', 'fa-list', '#16A5A5', '所有任务', '1', '37', '1', '1', 'jsp/si/oms_order_main.jsp');
INSERT INTO `sys_url_menu` VALUES ('39', null, '-1', '0', 'fa-address-card-o', '#16A5A5', '用工管理', '4', '0', '1', '0', '');
INSERT INTO `sys_url_menu` VALUES ('40', null, '-1', '0', 'fa-address-book', '#16A5A5', '长期劳务人员', '1', '39', '1', '1', 'jsp/si/com_customer_info.jsp');
INSERT INTO `sys_url_menu` VALUES ('41', null, '-1', '0', 'fa-address-book-o', '#16A5A5', '短期劳务人员', '2', '39', '1', '1', 'jsp/si/com_family_info.jsp');
INSERT INTO `sys_url_menu` VALUES ('42', null, '-1', '0', 'fa-credit-card-alt', '#16A5A5', '经费管理', '4', '0', '1', '0', '');
INSERT INTO `sys_url_menu` VALUES ('43', null, '-1', '0', 'fa-money', '#16A5A5', '经费台账', '1', '42', '1', '1', 'jsp/si/activity.jsp');

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

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
INSERT INTO `sys_user` VALUES ('20', 'chenth', '陈天皓', '100', '-1', '2018-03-28 07:10:04', null, '0', '0', 'chenth0517@126.com', 'index.jsp', 'resources/images/user.png', '213E0B3979ECF2562087B03F04D0273B', '13312312345', null, '0', null);
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
INSERT INTO `sys_user` VALUES ('43', 'zhangsan', '张三', '100', '-1', '2020-05-27 21:35:47', null, '0', '0', 'zhangsan@126.com', 'index.jsp', 'resources/images/user.png', 'E10ADC3949BA59ABBE56E057F20F883E', '13346979845', null, '0', null);
INSERT INTO `sys_user` VALUES ('44', 'lisi', '李四', '100', '-1', '2020-05-27 21:40:21', null, '0', '0', 'lisi@126.com', 'index.jsp', 'resources/images/user.png', 'C6BE854F3A77804FB1ED538E871B7B2D', '13458908076', null, '0', null);
INSERT INTO `sys_user` VALUES ('45', 'zhangxiaolong', '张小龙', '100', '-1', '2020-05-27 21:40:56', null, '0', '0', 'zhangxiaolong@126.com', 'index.jsp', 'resources/images/user.png', 'EB2F0E1AD85AB98084DCDA14BB49DD65', '13367890778', null, '0', null);
INSERT INTO `sys_user` VALUES ('46', 'zhaoxiaohu', '赵小虎', '100', '-1', '2020-05-27 21:41:26', null, '0', '0', 'zhaoxiaohu@126.com', 'index.jsp', 'resources/images/user.png', '2FC655D9C09C89DA31E491BCCE239B8C', '15978653344', null, '0', null);
INSERT INTO `sys_user` VALUES ('47', 'shenfei', '沈飞', '100', '-1', '2020-05-27 21:42:49', null, '0', '0', 'shenfei@126.com', 'index.jsp', 'resources/images/user.png', '944C27DEE89F3DBB58B719048113247D', '17789893456', null, '0', null);
INSERT INTO `sys_user` VALUES ('48', 'zhouli', '周立', '100', '-1', '2020-05-27 21:43:29', null, '0', '0', 'zhouli@126.com', 'index.jsp', 'resources/images/user.png', '9FB4755F6EDC42C047E7121DE17067E8', '13814056789', null, '0', null);
INSERT INTO `sys_user` VALUES ('49', 'liuwen', '刘文', '100', '-1', '2020-05-27 21:44:16', null, '0', '0', 'liuwen@126.com', 'index.jsp', 'resources/images/user.png', '190D00A3FBD41E0AC405500D6C652400', '13913945878', null, '0', null);

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
