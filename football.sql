/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : lottery

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 08/07/2018 21:15:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `account_amount` int(6) DEFAULT NULL COMMENT '账户余额',
  `account_available_amount` int(6) DEFAULT NULL COMMENT '账户可提现额',
  `account_create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_account
-- ----------------------------
BEGIN;
INSERT INTO `t_account` VALUES (1, 950, 3340, '2018-06-24 14:35:44.553000');
INSERT INTO `t_account` VALUES (2, 604, 3804, '2018-06-24 14:36:46.532000');
INSERT INTO `t_account` VALUES (3, 3325, 3999, '2018-06-24 14:37:23.966000');
INSERT INTO `t_account` VALUES (4, 1995, 3586, '2018-06-24 14:38:39.133000');
INSERT INTO `t_account` VALUES (5, 26, 931, '2018-06-24 14:39:15.715000');
INSERT INTO `t_account` VALUES (6, 4067, 2397, '2018-06-24 14:40:53.038000');
INSERT INTO `t_account` VALUES (7, 4065, 4195, '2018-06-24 14:41:27.766000');
INSERT INTO `t_account` VALUES (8, 7285, 4285, '2018-06-24 14:42:02.174000');
INSERT INTO `t_account` VALUES (9, 3841, 3841, '2018-06-24 14:42:31.238000');
INSERT INTO `t_account` VALUES (10, 3327, 1347, '2018-06-24 14:43:17.990000');
INSERT INTO `t_account` VALUES (11, 0, 0, '2018-06-24 18:27:39.916000');
COMMIT;

-- ----------------------------
-- Table structure for t_account_finance
-- ----------------------------
DROP TABLE IF EXISTS `t_account_finance`;
CREATE TABLE `t_account_finance` (
  `account_finance_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `finance_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`account_finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_consume
-- ----------------------------
DROP TABLE IF EXISTS `t_consume`;
CREATE TABLE `t_consume` (
  `consume_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消费记录ID',
  `consume_type` int(5) DEFAULT NULL COMMENT '消费类型：1、购买推荐，2、开通会员，3、投注，4、其它',
  `consume_amount` int(11) DEFAULT NULL COMMENT '消费金额',
  `consume_create_time` datetime(6) DEFAULT NULL COMMENT '消费时间',
  PRIMARY KEY (`consume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_finance
-- ----------------------------
DROP TABLE IF EXISTS `t_finance`;
CREATE TABLE `t_finance` (
  `finance_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '理财账户ID',
  `finance_amount` int(11) DEFAULT NULL,
  `finance_profit_total` int(11) DEFAULT NULL,
  `finance_profit_rate_total` int(11) DEFAULT NULL,
  `finance_profit_ten` int(11) DEFAULT NULL,
  `finance_profit_rate_seven` int(11) DEFAULT NULL,
  PRIMARY KEY (`finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_profit_statistic
-- ----------------------------
DROP TABLE IF EXISTS `t_profit_statistic`;
CREATE TABLE `t_profit_statistic` (
  `profit_statistic_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收益统计ID',
  `profit_statistic_profit` int(6) DEFAULT NULL COMMENT '每日球币收益',
  `profit_statistic_profit_rate` double(6,2) DEFAULT NULL COMMENT '每日球币收益率',
  `profit_statistic_create_time` datetime(6) DEFAULT NULL COMMENT '收益产生日期',
  PRIMARY KEY (`profit_statistic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_recharge
-- ----------------------------
DROP TABLE IF EXISTS `t_recharge`;
CREATE TABLE `t_recharge` (
  `recharge_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `recharge_amount` double(6,2) NOT NULL COMMENT '充值金额：精确到小数点后两位',
  `recharge_status` tinyint(1) DEFAULT NULL COMMENT '充值状态：0、未充值、1、已充值',
  `recharge_create_time` datetime(6) NOT NULL COMMENT '创建时间',
  `recharge_create_by` varchar(20) NOT NULL COMMENT '创建人：用户名',
  `recharge_is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录是否有效：0、无效，1、有效',
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recharge
-- ----------------------------
BEGIN;
INSERT INTO `t_recharge` VALUES (1, 2, 100.00, 0, '2018-06-24 17:33:33.415000', 'user2', 1);
INSERT INTO `t_recharge` VALUES (2, 2, 456.00, 0, '2018-06-24 18:13:41.097000', 'user2', 1);
INSERT INTO `t_recharge` VALUES (3, 2, 900.00, 0, '2018-06-24 18:15:56.393000', 'user2', 1);
INSERT INTO `t_recharge` VALUES (4, 2, 56.00, 0, '2018-06-24 18:20:32.643000', 'user2', 1);
COMMIT;

-- ----------------------------
-- Table structure for t_recommend
-- ----------------------------
DROP TABLE IF EXISTS `t_recommend`;
CREATE TABLE `t_recommend` (
  `recommend_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '推荐ID',
  `user_id` int(11) NOT NULL COMMENT '推荐人ID',
  `recommend_match_id` varchar(255) NOT NULL COMMENT '比赛ID',
  `recommend_match_time` varchar(255) DEFAULT NULL COMMENT '比赛时间',
  `recommend_league_name` varchar(255) NOT NULL COMMENT '联赛名称',
  `recommend_type` int(1) NOT NULL COMMENT '推荐类型：1、欧赔，2、亚盘，3、大小球',
  `recommend_value` int(1) NOT NULL COMMENT '推荐选项：1、胜，2、平，3、负，4、上盘，5、下盘，6、大球，7、小球',
  `recommend_handicap` varchar(255) DEFAULT NULL COMMENT '赔率盘口：类型1时值为空，类型为2、3时值不能为空',
  `recommend_handicap_value` varchar(255) DEFAULT NULL COMMENT '赔率盘口的值',
  `recommend_reason` text COMMENT '推荐理由',
  `recommend_price` int(11) DEFAULT NULL COMMENT '推荐价格',
  `recommend_match_result` int(1) DEFAULT NULL COMMENT '比赛结果：1、输，2、赢，3、走',
  `recommend_host` varchar(255) DEFAULT NULL COMMENT '主队',
  `recommend_visit` varchar(255) DEFAULT NULL COMMENT '客队',
  `recommend_create_time` datetime(6) NOT NULL COMMENT '创建时间',
  `recommend_create_by` varchar(20) DEFAULT NULL COMMENT '创建人：用户名',
  PRIMARY KEY (`recommend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recommend
-- ----------------------------
BEGIN;
INSERT INTO `t_recommend` VALUES (1, 4, '2166098', '2018-06-15 08:00:00', '世界杯', 1, 1, '', '', '主胜稳稳的', 100, 2, '法国', '澳大利亚', '2018-06-16 22:59:32.673000', 'user4');
INSERT INTO `t_recommend` VALUES (2, 8, '2166098', '2018-06-04 00:01:22', '世界杯', 1, 1, '', '', '主胜稳稳的2:1', 1000, 2, '法国', '澳大利亚', '2018-06-16 23:09:52.167000', 'user8');
INSERT INTO `t_recommend` VALUES (3, 6, '2166098', '2018-06-17 23:00:00', '世界杯', 2, 5, '一球/球半', '-1.00/-1.50', '德国下盘稳如狗', 300, 1, '德国', '墨西哥', '2018-06-17 18:17:27.593000', 'user6');
INSERT INTO `t_recommend` VALUES (4, 7, '2166098', '2018-06-18 20:00:00', '世界杯', 1, 1, '', '', '瑞典胜', 200, 2, '瑞典', '韩国', '2018-06-18 12:20:53.430000', 'user7');
INSERT INTO `t_recommend` VALUES (5, 2, '2166098', '2018-06-19 00:30:00', '瑞典女超', 3, 7, '2.5', '2.50', '大球', 10, 1, '林科平', '尤尔加登', '2018-03-18 12:25:14.687000', 'user2');
INSERT INTO `t_recommend` VALUES (7, 2, '2166098', '2018-06-20 02:00:00', '冰岛超', 2, 4, '平手/半球', '0.00/-0.50', '上盘打出', 500, 1, '加尔扎拜尔星', 'IBV韦斯特曼纳', '2018-06-18 12:45:51.106000', 'user2');
INSERT INTO `t_recommend` VALUES (8, 2, '2166098', '2018-06-19 06:00:00', '巴西丙', 3, 6, '2.5', '2.50', '大', 350, 2, '雷默', '阿克雷阿诺竞技', '2018-06-20 12:56:48.696000', 'user2');
INSERT INTO `t_recommend` VALUES (27, 2, '2166098', '2018-06-19 01:00:00', '瑞典乙', 2, 4, '受半球', '0.50', '受半球主胜', 0, 1, '于默奥', '特格斯', '2018-06-18 13:38:16.723000', 'user2');
INSERT INTO `t_recommend` VALUES (28, 3, '2166098', '2018-06-20 06:15:00', '巴西乙', 2, 4, '半球', '-0.50', '半球主胜', 300, 1, '庞特普雷塔', '阿拉戈亚诺体育', '2018-06-08 14:01:10.842000', 'user3');
INSERT INTO `t_recommend` VALUES (29, 3, '2166098', '2018-06-19 01:00:00', '瑞典乙', 3, 7, '3', '3.00', '大三稳如狗', 56, 3, '于默奥', '特格斯', '2018-04-18 14:10:27.521000', 'user3');
INSERT INTO `t_recommend` VALUES (32, 5, '2166105', '2018-06-19 20:00:00', '世界杯', 1, 2, '', '', '平局', 10, 2, '哥伦比亚', '日本', '2018-05-19 11:23:18.887000', 'user5');
INSERT INTO `t_recommend` VALUES (33, 5, '2166104', '2018-06-19 23:00:00', '世界杯', 2, 5, '平手/半球', '0.00/-0.50', '下盘', 50, 3, '波兰', '塞内加尔', '2018-06-27 11:23:34.362000', 'user5');
INSERT INTO `t_recommend` VALUES (35, 5, '2166064', '2018-06-20 02:00:00', '世界杯', 2, 4, '半球', '-0.50', 'aa', 30, 3, '俄罗斯', '埃及', '2018-06-19 11:28:45.495000', 'user5');
INSERT INTO `t_recommend` VALUES (36, 5, '2731134', '2018-06-20 08:30:00', '巴西乙', 3, 6, '2/2.5', '2.25', 'dddd', 60, 3, '阿瓦伊', '瓜拉尼', '2018-06-19 11:30:13.997000', 'user5');
INSERT INTO `t_recommend` VALUES (37, 5, '2166070', '2018-06-20 20:00:00', '世界杯', 1, 1, '', '', '3', 45, 3, '葡萄牙', '摩洛哥', '2018-06-19 11:30:52.243000', 'user5');
INSERT INTO `t_recommend` VALUES (38, 10, '2717609', '2018-06-30 20:00:00', '芬超', 3, 6, '2/2.5', '2.25', '上盘稳如狗', 300, 0, '伊尔维斯', '英特土尔库', '2018-06-30 18:34:19.264000', 'user10');
INSERT INTO `t_recommend` VALUES (39, 10, '2724549', '2018-06-30 20:00:00', '芬兰甲', 3, 6, '2.5', '2.50', '大', 30, 0, 'KPV科科拉', '查路', '2018-06-30 18:38:58.086000', 'user10');
INSERT INTO `t_recommend` VALUES (40, 6, '2722608', '2018-07-01 14:00:00', 'J3', 2, 4, '半球', '-0.50', '上盘打出', 1000, 0, '沼津青蓝', '大阪樱花U23', '2018-07-01 12:30:28.578000', 'user6');
INSERT INTO `t_recommend` VALUES (41, 4, '2166112', '2018-07-01 22:00:00', '世界杯', 2, 4, '受一球', '1.00', '', 100, 0, '俄罗斯', '西班牙', '2018-07-01 20:29:12.788000', 'user4');
COMMIT;

-- ----------------------------
-- Table structure for t_recommend_pay
-- ----------------------------
DROP TABLE IF EXISTS `t_recommend_pay`;
CREATE TABLE `t_recommend_pay` (
  `recommend_pay_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '推荐购买记录ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `recommend_id` int(11) DEFAULT NULL COMMENT '推荐ID',
  `recommend_pay_create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`recommend_pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recommend_pay
-- ----------------------------
BEGIN;
INSERT INTO `t_recommend_pay` VALUES (1, 5, 1, '2018-06-19 11:34:46.555000');
INSERT INTO `t_recommend_pay` VALUES (7, 1, 1, '2018-06-30 10:56:29.965000');
INSERT INTO `t_recommend_pay` VALUES (9, 1, 2, '2018-06-30 11:04:52.757000');
INSERT INTO `t_recommend_pay` VALUES (10, 1, 7, '2018-06-30 11:36:36.148000');
INSERT INTO `t_recommend_pay` VALUES (11, 1, 28, '2018-06-30 11:36:53.789000');
INSERT INTO `t_recommend_pay` VALUES (12, 1, 33, '2018-06-30 11:36:57.631000');
INSERT INTO `t_recommend_pay` VALUES (13, 2, 1, '2018-06-30 11:37:25.475000');
INSERT INTO `t_recommend_pay` VALUES (14, 2, 2, '2018-06-30 11:37:27.992000');
INSERT INTO `t_recommend_pay` VALUES (15, 2, 7, '2018-06-30 11:37:32.095000');
INSERT INTO `t_recommend_pay` VALUES (16, 2, 8, '2018-06-30 11:37:35.443000');
INSERT INTO `t_recommend_pay` VALUES (17, 2, 28, '2018-06-30 11:37:39.171000');
INSERT INTO `t_recommend_pay` VALUES (18, 4, 1, '2018-06-30 11:38:22.258000');
INSERT INTO `t_recommend_pay` VALUES (19, 4, 4, '2018-06-30 11:38:27.114000');
INSERT INTO `t_recommend_pay` VALUES (20, 4, 5, '2018-06-30 11:38:31.678000');
INSERT INTO `t_recommend_pay` VALUES (21, 4, 8, '2018-06-30 11:38:39.713000');
INSERT INTO `t_recommend_pay` VALUES (22, 4, 29, '2018-06-30 11:38:44.490000');
INSERT INTO `t_recommend_pay` VALUES (23, 4, 37, '2018-06-30 11:38:49.403000');
INSERT INTO `t_recommend_pay` VALUES (24, 5, 2, '2018-06-30 11:39:23.991000');
INSERT INTO `t_recommend_pay` VALUES (25, 5, 5, '2018-06-30 11:39:27.674000');
INSERT INTO `t_recommend_pay` VALUES (26, 5, 8, '2018-06-30 11:39:31.515000');
INSERT INTO `t_recommend_pay` VALUES (27, 5, 28, '2018-06-30 11:39:35.045000');
INSERT INTO `t_recommend_pay` VALUES (28, 5, 32, '2018-06-30 12:09:35.228000');
INSERT INTO `t_recommend_pay` VALUES (29, 5, 33, '2018-06-30 12:09:49.722000');
INSERT INTO `t_recommend_pay` VALUES (30, 1, 5, '2018-06-30 12:58:03.328000');
INSERT INTO `t_recommend_pay` VALUES (31, 10, 38, '2018-06-30 18:34:19.286000');
INSERT INTO `t_recommend_pay` VALUES (32, 10, 39, '2018-06-30 18:39:06.122000');
INSERT INTO `t_recommend_pay` VALUES (33, 6, 40, '2018-07-01 12:30:28.849000');
INSERT INTO `t_recommend_pay` VALUES (34, 6, 39, '2018-07-01 13:30:02.741000');
INSERT INTO `t_recommend_pay` VALUES (35, 6, 38, '2018-07-01 13:32:48.898000');
INSERT INTO `t_recommend_pay` VALUES (36, 7, 38, '2018-07-01 13:33:42.001000');
INSERT INTO `t_recommend_pay` VALUES (37, 7, 39, '2018-07-01 13:34:15.377000');
INSERT INTO `t_recommend_pay` VALUES (38, 1, 39, '2018-07-01 13:35:43.947000');
INSERT INTO `t_recommend_pay` VALUES (39, 1, 38, '2018-07-01 13:36:06.663000');
INSERT INTO `t_recommend_pay` VALUES (40, 1, 40, '2018-07-01 13:36:15.896000');
INSERT INTO `t_recommend_pay` VALUES (41, 2, 39, '2018-07-01 13:37:18.419000');
INSERT INTO `t_recommend_pay` VALUES (42, 2, 38, '2018-07-01 14:18:49.051000');
INSERT INTO `t_recommend_pay` VALUES (43, 3, 38, '2018-07-01 14:27:38.750000');
INSERT INTO `t_recommend_pay` VALUES (44, 3, 39, '2018-07-01 14:28:51.104000');
INSERT INTO `t_recommend_pay` VALUES (45, 3, 40, '2018-07-01 14:40:35.493000');
INSERT INTO `t_recommend_pay` VALUES (46, 4, 40, '2018-07-01 16:42:52.392000');
INSERT INTO `t_recommend_pay` VALUES (47, 4, 38, '2018-07-01 16:44:14.084000');
INSERT INTO `t_recommend_pay` VALUES (48, 4, 39, '2018-07-01 18:16:10.789000');
INSERT INTO `t_recommend_pay` VALUES (49, 4, 41, '2018-07-01 20:29:12.818000');
COMMIT;

-- ----------------------------
-- Table structure for t_static_visit
-- ----------------------------
DROP TABLE IF EXISTS `t_static_visit`;
CREATE TABLE `t_static_visit` (
  `static_visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `static_visit_url` varchar(255) DEFAULT NULL,
  `static_visit_count` int(8) DEFAULT NULL,
  `static_visit_create_time` datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`static_visit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_static_visit
-- ----------------------------
BEGIN;
INSERT INTO `t_static_visit` VALUES (1, '/football/news/list', 24, '2018-06-18 23:55:03.189000');
INSERT INTO `t_static_visit` VALUES (2, '/analysis/info', 27, '2018-06-18 23:55:03.191000');
INSERT INTO `t_static_visit` VALUES (3, '/live/matchs/lastest', 38, '2018-06-18 23:55:03.194000');
INSERT INTO `t_static_visit` VALUES (4, '/data', 30, '2018-06-18 23:55:03.197000');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(20) NOT NULL COMMENT '用户名：6-16位',
  `user_pass` varchar(255) NOT NULL COMMENT '用户密码：6-16位',
  `user_role` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '用户角色：0、普通用户，1、管理员',
  `user_level` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '会员等级：0、普通会员，1、理财会员，2、高级会员',
  `user_mobile` varchar(11) DEFAULT NULL COMMENT '用户手机号',
  `user_email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `user_real_name` varchar(20) DEFAULT NULL COMMENT '用户真实姓名',
  `user_create_time` datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '用户注册时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (1, 'user1', '24c9e15e52afc47c225b757e7bee1f9d', 0, 0, '13223322134', 'xuzhiqing2014@163.com', 'user1', '2018-06-30 17:07:02.202842');
INSERT INTO `t_user` VALUES (2, 'user2', '7e58d63b60197ceb55a1c487989a3720', 0, 0, '13223322135', '1322332234@163.com', 'user2', '2018-06-24 14:36:46.528000');
INSERT INTO `t_user` VALUES (3, 'user3', '92877af70a45fd6a2ed7fe81e1236b78', 0, 0, '15239488435', 'afega@163.com', 'user3', '2018-06-24 14:37:23.962000');
INSERT INTO `t_user` VALUES (4, 'user4', '3f02ebe3d7929b091e3d8ccfde2f3bc6', 0, 0, '18327459325', '18327459325@qq.com', 'user4', '2018-06-24 14:38:39.128000');
INSERT INTO `t_user` VALUES (5, 'user5', '0a791842f52a0acfbb3a783378c066b8', 0, 0, '13598745643', '13598745643@126.com', 'user5', '2018-06-24 14:39:15.711000');
INSERT INTO `t_user` VALUES (6, 'user6', 'affec3b64cf90492377a8114c86fc093', 0, 0, '13245643456', 'faigaigea9@gmail.com', 'user6', '2018-06-24 14:40:53.034000');
INSERT INTO `t_user` VALUES (7, 'user7', '3e0469fb134991f8f75a2760e409c6ed', 0, 0, '18432722238', 'faifiag@outlook.com', 'user7', '2018-06-24 14:41:27.763000');
INSERT INTO `t_user` VALUES (8, 'user8', '7668f673d5669995175ef91b5d171945', 0, 0, '18465793823', 'fafa@qq.com', 'user8', '2018-06-24 14:42:02.170000');
INSERT INTO `t_user` VALUES (9, 'user9', '8808a13b854c2563da1a5f6cb2130868', 0, 0, '13785493432', 'qqqq@qq.com', 'user9', '2018-06-24 14:42:31.233000');
INSERT INTO `t_user` VALUES (10, 'user10', '990d67a9f94696b1abe2dccf06900322', 0, 0, '13456789091', 'beatiful@gmail.com', 'user10', '2018-06-24 14:43:17.986000');
INSERT INTO `t_user` VALUES (11, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 0, '18845679087', '18845679087@qq.com', 'admin', '2018-06-24 18:28:02.395220');
COMMIT;

-- ----------------------------
-- Table structure for t_user_account
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account`;
CREATE TABLE `t_user_account` (
  `user_account_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户账户关系ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `account_id` int(11) DEFAULT NULL COMMENT '账户ID',
  `user_account_create_time` datetime(6) DEFAULT NULL COMMENT '用户与账户绑定时间',
  PRIMARY KEY (`user_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
BEGIN;
INSERT INTO `t_user_account` VALUES (1, 1, 1, '2018-06-24 14:35:44.555000');
INSERT INTO `t_user_account` VALUES (2, 2, 2, '2018-06-24 14:36:46.535000');
INSERT INTO `t_user_account` VALUES (3, 3, 3, '2018-06-24 14:37:23.969000');
INSERT INTO `t_user_account` VALUES (4, 4, 4, '2018-06-24 14:38:39.137000');
INSERT INTO `t_user_account` VALUES (5, 5, 5, '2018-06-24 14:39:15.720000');
INSERT INTO `t_user_account` VALUES (6, 6, 6, '2018-06-24 14:40:53.040000');
INSERT INTO `t_user_account` VALUES (7, 7, 7, '2018-06-24 14:41:27.768000');
INSERT INTO `t_user_account` VALUES (8, 8, 8, '2018-06-24 14:42:02.177000');
INSERT INTO `t_user_account` VALUES (9, 9, 9, '2018-06-24 14:42:31.240000');
INSERT INTO `t_user_account` VALUES (10, 10, 10, '2018-06-24 14:43:17.993000');
INSERT INTO `t_user_account` VALUES (11, 11, 11, '2018-06-24 18:27:39.919000');
COMMIT;

-- ----------------------------
-- Table structure for t_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `t_withdraw`;
CREATE TABLE `t_withdraw` (
  `withdraw_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '提现ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `withdraw_amount` double(4,0) NOT NULL COMMENT '提现金额：每次最多1000',
  `withdraw_status` tinyint(1) NOT NULL COMMENT '提现状态：0、等待处理，1、已处理',
  `withdraw_create_time` datetime(6) NOT NULL COMMENT '创建时间',
  `withdraw_create_by` varchar(20) NOT NULL COMMENT '创建人：用户名',
  `withdraw_is_active` tinyint(1) NOT NULL COMMENT '记录是否有效：0、无效，1、有效',
  PRIMARY KEY (`withdraw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_withdraw
-- ----------------------------
BEGIN;
INSERT INTO `t_withdraw` VALUES (1, 2, 1000, 0, '2018-06-24 17:50:06.019000', 'user2', 1);
INSERT INTO `t_withdraw` VALUES (2, 2, 234, 0, '2018-06-24 18:12:25.880000', 'user2', 1);
INSERT INTO `t_withdraw` VALUES (3, 2, 80, 0, '2018-06-24 18:16:03.429000', 'user2', 1);
INSERT INTO `t_withdraw` VALUES (4, 2, 80, 0, '2018-06-24 18:16:26.122000', 'user2', 1);
INSERT INTO `t_withdraw` VALUES (5, 2, 13, 0, '2018-06-24 18:22:33.712000', 'user2', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
