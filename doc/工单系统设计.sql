Drop table if exists com_customer_info;CREATE TABLE `com_customer_info` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '客户ID',
`name` varchar(128) NULL COMMENT '客户名称',
`phone` varchar(32) NULL COMMENT '联系手机号',
`email` varchar(128) NULL COMMENT '邮箱',
`company_id` int NULL COMMENT '所在公司信息',
`tel` varchar(32) NULL COMMENT '联系电话',
`resp_group` int NULL COMMENT '责任项目组',
`resp_manager` int NULL COMMENT '负责人',
`register_date` datetime NULL COMMENT '登记时间',
`married` int NULL DEFAULT 0 COMMENT '婚姻状况（0-未婚，1-已婚）',
`childrens` int NULL DEFAULT 0 COMMENT '子女数量（0-没有，1-10孩子数量）',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_order_main;
CREATE TABLE `oms_order_main` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '工单ID',
`topic` varchar(128) NULL COMMENT '主题',
`content` varchar(512) NULL COMMENT '受理内容',
`customer_id` int NULL COMMENT '客户编号',
`resp_user` int NULL COMMENT '受理人',
`status` int NULL COMMENT '状态（新建、解决中、已解决、已关闭）',
`priority` int NULL COMMENT '优先级',
`create_time` datetime NULL COMMENT '受理时间',
`instance_id` varchar(32) NULL COMMENT '模板工单的流程实例ID',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_op_history;
CREATE TABLE `oms_op_history` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '工单处理流水号',
`order_id` int NULL COMMENT '工单编号',
`remark` varchar(512) NULL COMMENT '处理过程描述',
`result` int NULL COMMENT '处理结果',
`user_id` int NULL COMMENT '处理人员ID',
`task_id` varchar(64) NULL COMMENT '任务编号',
PRIMARY KEY (`id`) 
);
Drop table if exists com_tag_def;
CREATE TABLE `com_tag_def` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '标签ID',
`name` varchar(64) NULL COMMENT '标签描述',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_customer_tag_link;
CREATE TABLE `oms_customer_tag_link` (
`id` int NOT NULL COMMENT '序号',
`tag_id` int NULL COMMENT '标签ID',
`customer_id` int NULL COMMENT '客户ID',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_order_tag_link;
CREATE TABLE `oms_order_tag_link` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
`tag_id` int NULL COMMENT '标签ID',
`order_id` int NULL COMMENT '工单编号',
PRIMARY KEY (`id`) 
);
Drop table if exists com_family_info;
CREATE TABLE `com_family_info` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '成员编号',
`membership` int NULL COMMENT '成员关系（1-户主，2-夫妻，3-子女，4-兄妹，5-父母）',
`name` varchar(64) NULL COMMENT '姓名',
`phone` varchar(32) NULL COMMENT '联系电话',
`job` varchar(128) NULL COMMENT '职业',
`interest` varchar(128) NULL COMMENT '兴趣爱好',
`customer_id` int NULL COMMENT '客户编号',
`photo_file` varchar(64) NULL COMMENT '证件文件扫描件',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_team_group;
CREATE TABLE `oms_team_group` (
`id` int NOT NULL COMMENT '服务团队编号',
`name` varchar(0) NULL COMMENT '团队名称',
`manager` int NULL COMMENT '责任人',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_team_user_link;
CREATE TABLE `oms_team_user_link` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
`user_id` int NULL COMMENT '用户ID',
`team_id` int NULL COMMENT '小组ID',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_order_file_link;
CREATE TABLE `oms_order_file_link` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
`file_id` varchar(64) NULL COMMENT '文件ID',
`order_id` int NULL COMMENT '关联工单编号',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_oph_file_link;
CREATE TABLE `oms_oph_file_link` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
`file_id` varchar(64) NULL COMMENT '文件ID',
`history_id` int NULL COMMENT '关联工单处理过程编号',
PRIMARY KEY (`id`) 
);
Drop table if exists oms_order_task;
CREATE TABLE `oms_order_task` (
`id` varchar(64) NOT NULL COMMENT '工单编号',
`name` varchar(128) NULL COMMENT '名称',
`holder_user_id` int NULL COMMENT '任务受理人',
`create_time` datetime NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
`due_date` datetime NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后期限',
`content` varchar(512) NULL COMMENT '处理内容',
`orde_id` int NULL COMMENT '工单编号',
PRIMARY KEY (`id`) 
);

