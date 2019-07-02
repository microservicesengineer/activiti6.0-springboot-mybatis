use vms;

DROP TABLE IF EXISTS `flow_category`;
CREATE TABLE `flow_category` (
  `Id` char(72) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flow_category
-- ----------------------------
INSERT INTO `flow_category` VALUES ('15E991D2-3000-4BDE-96B3-D8F7BDBBF651', '默认分类');
INSERT INTO `flow_category` VALUES ('1604EF7E-CE40-4650-8C28-0EB25A9817DF', '人事流程');
INSERT INTO `flow_category` VALUES ('1604EF8B-0350-4F08-87EE-1D46EBDE7938', '财务流程');
INSERT INTO `flow_category` VALUES ('1604F47B-1220-4260-862D-0E40483BEBF4', '研发流程');
INSERT INTO `flow_category` VALUES ('16375E4C-9190-4F61-85BD-CB47F017D06D', '0519fxq');
INSERT INTO `flow_category` VALUES ('16382532-6EC0-4141-8CE4-316F24DCDCE8', '行政流程');
INSERT INTO `flow_category` VALUES ('1638AABF-8260-4673-83A7-20A33335CBFC', '业务流程');
INSERT INTO `flow_category` VALUES ('163A9CFD-5360-4301-A529-597F1378D0DE', '0529益私募');
INSERT INTO `flow_category` VALUES ('16545F2A-2020-465F-ABA3-471EC26EA852', '市场流程');
INSERT INTO `flow_category` VALUES ('16566339-7250-42ED-9700-5A10C0A58B0A', '其它流程');
INSERT INTO `flow_category` VALUES ('165C3638-7210-4F8C-A8CC-2465C1D5799F', '服务流程');
INSERT INTO `flow_category` VALUES ('195C3638-7210-4F8C-A8CC-2465C1D5799F', 'aaaa');


-- ----------------------------
-- Table structure for flow_connection
-- ----------------------------
DROP TABLE IF EXISTS `flow_connection`;
CREATE TABLE `flow_connection` (
  `id` char(72) NOT NULL,
  `source_node_id` char(72) NOT NULL,
  `target_node_id` char(72) DEFAULT NULL COMMENT '目标节点id',
  `processId` char(72) NOT NULL,
  `default` bit(1) DEFAULT b'0' COMMENT '是否默认线',
  `operationType` varchar(255) DEFAULT NULL COMMENT '操作类型',
  `triggerType` varchar(255) DEFAULT NULL COMMENT '触发类型',
  `triggerAction` varchar(255) DEFAULT NULL COMMENT '触发动作',
  `timingSettings` text COMMENT '时间设置',
  `tenantId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`processId`),
  KEY `source_node_id` (`source_node_id`) USING BTREE,
  KEY `target_node_id` (`target_node_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY ` 6` (`processId`) USING BTREE,
  KEY `connection_node_sourceNodeId` (`source_node_id`,`processId`) USING BTREE,
  KEY `connection_node_targerNodeId` (`target_node_id`,`processId`) USING BTREE,
  CONSTRAINT `flow_connection_ibfk_1` FOREIGN KEY (`source_node_id`, `processId`) REFERENCES `flow_node` (`id`, `processId`),
  CONSTRAINT `flow_connection_ibfk_2` FOREIGN KEY (`target_node_id`, `processId`) REFERENCES `flow_node` (`id`, `processId`),
  CONSTRAINT `flow_connection_ibfk_3` FOREIGN KEY (`processId`) REFERENCES `flow_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流转方向';



-- ----------------------------
-- Table structure for flow_connect_condition
-- ----------------------------
DROP TABLE IF EXISTS `flow_connect_condition`;
CREATE TABLE `flow_connect_condition` (
  `id` char(72) NOT NULL,
  `processId` char(72) NOT NULL,
  `connect_id` char(72) NOT NULL,
  `field` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `nodeId` varchar(255) DEFAULT NULL,
  `tenantId` varchar(255) DEFAULT NULL,
  KEY `1` (`processId`) USING BTREE,
  KEY `2` (`connect_id`) USING BTREE,
  KEY `condition_connection_connectionId` (`connect_id`,`processId`) USING BTREE,
  CONSTRAINT `flow_connect_condition_ibfk_1` FOREIGN KEY (`connect_id`, `processId`) REFERENCES `flow_connection` (`id`, `processId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_cpflowdata
-- ----------------------------
DROP TABLE IF EXISTS `flow_cpflowdata`;
CREATE TABLE `flow_cpflowdata` (
  `id` varchar(255) DEFAULT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `selectExist` text,
  `selectValue` text,
  `updateValue` text,
  `insertData` varchar(255) DEFAULT NULL,
  `sourceTableName` varchar(255) DEFAULT NULL,
  `targetTableName` varchar(255) DEFAULT NULL,
  `res` varchar(255) DEFAULT NULL,
  `targetField` varchar(255) DEFAULT NULL,
  `sourceField` varchar(255) DEFAULT NULL,
  `tenantId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flow_cpflowdata
-- ----------------------------

-- ----------------------------
-- Table structure for flow_definition
-- ----------------------------
DROP TABLE IF EXISTS `flow_definition`;
CREATE TABLE `flow_definition` (
  `id` char(72) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL COMMENT '流程名称',
  `state` int(11) DEFAULT NULL COMMENT '状态',
  `category` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(72) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_user` varchar(72) DEFAULT NULL COMMENT '更新用户',
  `current_version` varchar(72) DEFAULT NULL,
  `isTest` bit(1) DEFAULT b'0',
  `currentTestVersion` varchar(255) DEFAULT NULL,
  `tenantId` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL COMMENT '流程图标路径',
  `listIcon` varchar(255) DEFAULT NULL COMMENT '流程图标路径',
  PRIMARY KEY (`id`),
  KEY `fk_flow_type` (`category`) USING BTREE,
  CONSTRAINT `flow_definition_ibfk_1` FOREIGN KEY (`category`) REFERENCES `sys_all_category` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义表';

-- ----------------------------
-- Table structure for flow_form_tree_component_mapping
-- ----------------------------
DROP TABLE IF EXISTS `flow_form_tree_component_mapping`;
CREATE TABLE `flow_form_tree_component_mapping` (
  `id` varchar(36) DEFAULT NULL COMMENT 'tree控件绑定的字段id',
  `mappingId` varchar(36) DEFAULT NULL COMMENT 'tree控件新建子表的列的uuid（与绑定id映）',
  `tenantId` varchar(255) DEFAULT NULL COMMENT '租户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_node
-- ----------------------------
DROP TABLE IF EXISTS `flow_node`;
CREATE TABLE `flow_node` (
  `id` char(72) NOT NULL,
  `processId` char(72) NOT NULL COMMENT '流程版本id',
  `name` varchar(255) NOT NULL COMMENT '节点名称',
  `coordsRow` varchar(255) DEFAULT NULL,
  `coordsCol` varchar(255) DEFAULT NULL,
  `type` int(2) DEFAULT NULL,
  `formId` varchar(36) DEFAULT NULL COMMENT '表单id',
  `isArchivedInMid` tinyint(4) DEFAULT '0',
  `tenantId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`processId`),
  KEY `eqwdwqd` (`processId`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `flow_node_ibfk_1` FOREIGN KEY (`processId`) REFERENCES `flow_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程节点';



