CREATE TABLE `jat_department` (
`id` int NOT NULL COMMENT '组织编号',
`name` varchar(255) NULL COMMENT '组织名称',
`chairman` int NULL COMMENT '负责人',
`pid` int NULL COMMENT '上级组织',
`level` int NULL COMMENT '层级',
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_person` (
`id` int NOT NULL COMMENT '人员编号',
`user_name` varchar(255) NOT NULL COMMENT '用户名',
`real_name` varchar(255) NULL,
`birthday` varchar(255) NULL,
`phone_no` varchar(255) NULL,
`email` varchar(255) NULL,
`password` varchar(255) NULL,
`create_time` date NULL,
`expire_time` date NULL,
`disabled` int NULL,
`id_card_no` varchar(255) NULL,
`is_safe_member` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_resp_dep` (
`id` int NOT NULL COMMENT '职责编号',
`name` varchar(255) NULL COMMENT '职责名称',
`description` varchar(255) NULL COMMENT '职责描述',
`disabled` int NULL COMMENT '启用该职责',
`type` varchar(255) NULL COMMENT '1代表部门责任，2代表岗位责任',
`is_key` int NULL,
`single_resp` int NULL,
`is_safe_resp` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `org_post` (
`id` int NOT NULL,
`name` varchar(255) NULL,
`org_id` int NULL,
`disabled` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_relate_person_resp` (
`id` int NOT NULL,
`resp_id` int NULL,
`person_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_relate_dep_person` (
`id` int NOT NULL,
`person_id` int NULL,
`dep_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `link_org_person` (
`id` int NOT NULL,
`org_id` int NULL,
`person_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `link_org_post` (
`id` int NOT NULL,
`post_id` int NULL,
`person_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `template_post` (
`id` int NOT NULL,
`name` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `link_tp_post_resp` (
`id` int NOT NULL,
`post_id` int NULL,
`resp_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `key_organization` (
`id` int NOT NULL,
`name` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `base_post` (
`id` int NOT NULL,
`name` varchar(255) NULL,
`org_id` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_relate_dep_resp` (
`id` int NOT NULL,
`resp_id` int NULL,
`dep_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_resp_person` (
`id` int NOT NULL COMMENT '职责编号',
`name` varchar(255) NULL COMMENT '职责名称',
`description` varchar(255) NULL COMMENT '职责描述',
`disabled` int NULL COMMENT '启用该职责',
`type` varchar(255) NULL COMMENT '1代表部门责任，2代表岗位责任',
`is_key` int NULL,
`single_resp` int NULL,
`is_safe_resp` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `rjat_elate_resp_dep_person` (
`id` int NOT NULL,
`resp_dep_id` int NULL,
`resp_person_id` int NULL,
`description` varchar(255) NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_evaluate_schedule` (
`id` int NOT NULL COMMENT '计划编号',
`name` varchar(255) NULL COMMENT '计划名称',
`description` varchar(255) NULL COMMENT '计划描述',
`disabled` int NULL COMMENT '启用该计划',
`interval` int NULL COMMENT '评估周期',
`start_date` date NULL,
`is_autorun` int NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_evaluate_record` (
`id` int NOT NULL COMMENT '计划编号',
`time` date NULL,
`schedule_id` int NULL,
`score_dep` double NULL,
`dep_ratio` float NULL,
`score_person` double NULL,
`person_ratio` float NULL,
`score_resp` double NULL,
`resp_ratio` float NULL,
`score_evaluate` double NULL,
`evalute_ratio` float NULL,
`score_total` double NULL,
`is_ontime` int NULL,
`next_date` date NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `jat_relate_schedule_dep_person` (
`id` int NOT NULL,
`schedule_id` int NULL,
`obj_id` int NULL,
`obj_type` int NULL,
PRIMARY KEY (`id`) 
);


ALTER TABLE `link_org_person` ADD FOREIGN KEY (`org_id`) REFERENCES `jat_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `link_org_person` ADD CONSTRAINT `_copy_16` FOREIGN KEY (`person_id`) REFERENCES `jat_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_person_resp` ADD CONSTRAINT `_copy_15` FOREIGN KEY (`person_id`) REFERENCES `jat_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_person_resp` ADD CONSTRAINT `_copy_14` FOREIGN KEY (`resp_id`) REFERENCES `jat_resp_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_dep_person` ADD CONSTRAINT `_copy_13` FOREIGN KEY (`dep_id`) REFERENCES `jat_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_dep_person` ADD CONSTRAINT `_copy_12` FOREIGN KEY (`person_id`) REFERENCES `jat_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `org_post` ADD CONSTRAINT `_copy_11` FOREIGN KEY (`org_id`) REFERENCES `jat_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `link_tp_post_resp` ADD CONSTRAINT `_copy_10` FOREIGN KEY (`post_id`) REFERENCES `template_post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `link_tp_post_resp` ADD CONSTRAINT `_copy_9` FOREIGN KEY (`resp_id`) REFERENCES `jat_resp_dep` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `base_post` ADD CONSTRAINT `_copy_8` FOREIGN KEY (`org_id`) REFERENCES `key_organization` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_dep_resp` ADD CONSTRAINT `_copy_7` FOREIGN KEY (`dep_id`) REFERENCES `jat_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_dep_resp` ADD CONSTRAINT `_copy_6` FOREIGN KEY (`resp_id`) REFERENCES `jat_resp_dep` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_department` ADD CONSTRAINT `_copy_5` FOREIGN KEY (`chairman`) REFERENCES `jat_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `rjat_elate_resp_dep_person` ADD CONSTRAINT `_copy_4` FOREIGN KEY (`resp_dep_id`) REFERENCES `jat_resp_dep` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `rjat_elate_resp_dep_person` ADD CONSTRAINT `_copy_3` FOREIGN KEY (`resp_person_id`) REFERENCES `jat_resp_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_evaluate_record` ADD CONSTRAINT `_copy_2` FOREIGN KEY (`schedule_id`) REFERENCES `jat_evaluate_schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `jat_relate_schedule_dep_person` ADD CONSTRAINT `_copy_1` FOREIGN KEY (`schedule_id`) REFERENCES `jat_evaluate_schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

