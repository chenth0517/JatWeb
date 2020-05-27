/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smart_info

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-30 15:21:30
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

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
