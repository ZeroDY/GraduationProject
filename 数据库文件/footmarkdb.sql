/*
Navicat MySQL Data Transfer

Source Server         : footmark
Source Server Version : 50623
Source Host           : localhost:3306
Source Database       : footmarkdb

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-06-15 15:15:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for atdwall_table
-- ----------------------------
DROP TABLE IF EXISTS `atdwall_table`;
CREATE TABLE `atdwall_table` (
  `atdwallid` bigint(20) NOT NULL AUTO_INCREMENT,
  `atdwallname` varchar(255) DEFAULT NULL,
  `atdwallcreattime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atdxcoordinate` double DEFAULT NULL,
  `atdycoordinate` double DEFAULT NULL,
  `atdwallstatus` int(11) NOT NULL DEFAULT '1',
  `atdwallcreator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`atdwallid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of atdwall_table
-- ----------------------------
INSERT INTO `atdwall_table` VALUES ('6', '计算机11-1英语', '2015-06-12 19:47:12', '116.974576', '36.67726', '0', '123');
INSERT INTO `atdwall_table` VALUES ('7', '计算机11-1ios开发（韩）', '2015-06-13 00:07:52', '116.974563', '36.677435', '0', '123');
INSERT INTO `atdwall_table` VALUES ('8', '高数签到', '2015-06-13 07:20:16', '116.974212', '36.677708', '0', 'zhou01');
INSERT INTO `atdwall_table` VALUES ('9', '计算机网络', '2015-06-13 08:59:20', '116.974398', '36.677453', '0', '123');
INSERT INTO `atdwall_table` VALUES ('10', '计算机', '2015-06-13 14:36:35', '116.972149', '36.677132', '1', 'zhou01');

-- ----------------------------
-- Table structure for atd_table
-- ----------------------------
DROP TABLE IF EXISTS `atd_table`;
CREATE TABLE `atd_table` (
  `atdid` bigint(20) NOT NULL AUTO_INCREMENT,
  `atduser` varchar(255) NOT NULL,
  `atdtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atdinfo` varchar(255) NOT NULL,
  `atdwallid` bigint(20) NOT NULL,
  `atdidentifier` varchar(255) NOT NULL,
  PRIMARY KEY (`atdid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of atd_table
-- ----------------------------
INSERT INTO `atd_table` VALUES ('1', 'zhou01', '2015-06-09 18:38:41', 'zhou', '1', '1212qaz');
INSERT INTO `atd_table` VALUES ('2', 'zhou01', '2015-06-09 18:39:22', 'zhou', '1', '1212qaz2');
INSERT INTO `atd_table` VALUES ('4', 'zhou01', '2015-06-10 15:37:09', '啦啦啦啦啦', '3', 'A0CD7294-29C3-415F-AE44-C6F2F109604F');
INSERT INTO `atd_table` VALUES ('5', 'zhou01', '2015-06-10 15:42:08', '粥得意', '4', 'A0CD7294-29C3-415F-AE44-C6F2F109604F');
INSERT INTO `atd_table` VALUES ('6', '123', '2015-06-12 17:27:19', '张浩', '5', 'D9996CB5-48CE-4AAE-BF24-FB4556BFCEA0');
INSERT INTO `atd_table` VALUES ('7', 'zhou01', '2015-06-13 00:08:23', '粥得意', '7', 'A0CD7294-29C3-415F-AE44-C6F2F109604F');
INSERT INTO `atd_table` VALUES ('8', '123', '2015-06-13 00:08:43', '于立吾', '7', 'D9996CB5-48CE-4AAE-BF24-FB4556BFCEA0');
INSERT INTO `atd_table` VALUES ('9', 'zhou01', '2015-06-13 00:14:56', '张好', '7', '7B7DDCD3-7EA2-454F-938F-E71FE983FF2E');
INSERT INTO `atd_table` VALUES ('10', 'zhou01', '2015-06-13 07:20:47', '周德艺', '8', '7B7DDCD3-7EA2-454F-938F-E71FE983FF2E');
INSERT INTO `atd_table` VALUES ('11', '123', '2015-06-13 08:59:33', '张', '9', 'D9996CB5-48CE-4AAE-BF24-FB4556BFCEA0');
INSERT INTO `atd_table` VALUES ('12', 'zhou01', '2015-06-13 14:37:24', '粥得', '10', '7B7DDCD3-7EA2-454F-938F-E71FE983FF2E');

-- ----------------------------
-- Table structure for message_table
-- ----------------------------
DROP TABLE IF EXISTS `message_table`;
CREATE TABLE `message_table` (
  `msgid` bigint(20) NOT NULL,
  `msgcontent` text NOT NULL,
  `msgcreator` varchar(255) NOT NULL,
  `msgcreattime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wallid` bigint(20) NOT NULL,
  `msgstatus` int(11) NOT NULL DEFAULT '1',
  `msgtype` int(11) NOT NULL DEFAULT '1',
  `msgimage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`msgid`),
  KEY `msg_wall_wallid` (`wallid`),
  KEY `msg_user_msgcreator` (`msgcreator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_table
-- ----------------------------
INSERT INTO `message_table` VALUES ('1', '这是我发布的第一条信息xiugai', 'test01', '2015-04-19 21:21:05', '2', '2', '2', '12120x2272x1704.png');
INSERT INTO `message_table` VALUES ('2', '看台上的伊恩赖特激动万分，他是阿森纳的传奇。又被今天的传奇亨利超越.都是在这片草坪上，那里面有太多的思念太多的故事。融汇在这座93年的足球圣殿，融汇在国王亨利深情的一吻中。', 'test01', '2015-04-19 21:26:31', '2', '2', '2', '21212x1156x1640.png');
INSERT INTO `message_table` VALUES ('20150612102408899', '杨师傅说：“我还没洗刷，不要拍我！”', '123', '2015-06-12 10:24:50', '201506121015546846', '1', '1', '20150612102408899x3264x2448.png');
INSERT INTO `message_table` VALUES ('20150612235607215', '忽然天下一火力链，莫非玉帝想抽烟，若非玉帝想抽烟，为何天上一火链', '123', '2015-06-12 23:57:20', '201506122355132899', '1', '1', '20150612235607215x600x400.png');
INSERT INTO `message_table` VALUES ('201506101157157076', '图兔兔图兔兔', 'zhou01', '2015-06-10 11:57:29', '1', '1', '1', '201506101157157076x1280x960.png');
INSERT INTO `message_table` VALUES ('201506101209203684', '啦咯啦咯啦咯', 'zhou01', '2015-06-10 12:09:31', '1', '1', '1', '201506101209203684x960x1280.png');
INSERT INTO `message_table` VALUES ('201506101725401664', '到此一游～^_^', '123', '2015-06-10 17:26:48', '2', '1', '1', '201506101725401664x3264x2448.png');
INSERT INTO `message_table` VALUES ('201506121208433414', '啦咯啦咯啦咯啦咯', 'zhou01', '2015-06-12 12:09:04', '201506092137282290', '1', '1', '201506121208433414x2448x3264.png');
INSERT INTO `message_table` VALUES ('201506122236519789', '我在校门口等快递.....', '123', '2015-06-12 22:37:22', '201506121947266180', '1', '1', '201506122236519789x600x401.png');
INSERT INTO `message_table` VALUES ('201506122258059911', '冬日阳光', '123', '2015-06-12 22:58:26', '201506121947266180', '1', '1', '201506122258059911x600x400.png');
INSERT INTO `message_table` VALUES ('201506122324097304', '这里有春天', '123', '2015-06-12 23:24:27', '201506122308035704', '1', '1', '201506122324097304x600x400.png');
INSERT INTO `message_table` VALUES ('201506122324421056', '我能看到的你的春天', '123', '2015-06-12 23:25:20', '201506122308035704', '1', '1', '201506122324421056x600x400.png');
INSERT INTO `message_table` VALUES ('201506122325404650', '抓住了，就是你的秋天。不然，还我！', '123', '2015-06-12 23:26:30', '201506122306348312', '1', '1', '201506122325404650x583x383.png');
INSERT INTO `message_table` VALUES ('201506122326409734', '秋风扫落叶，飒～飒～', '123', '2015-06-12 23:27:36', '201506122306348312', '1', '1', '201506122326409734x600x400.png');
INSERT INTO `message_table` VALUES ('201506122327519935', '签到啊！签到的人，有日出看', '123', '2015-06-12 23:28:11', '201506121947266180', '1', '1', '201506122327519935x600x400.png');
INSERT INTO `message_table` VALUES ('201506122328256364', '大天桥，威武87', '123', '2015-06-12 23:28:40', '201506121947266180', '1', '1', '201506122328256364x600x400.png');
INSERT INTO `message_table` VALUES ('201506122353313881', '抢！', '123', '2015-06-12 23:54:08', '201506121015546846', '1', '1', '201506122353313881x3264x2448.png');
INSERT INTO `message_table` VALUES ('201506122354212302', '就在旁边', '123', '2015-06-12 23:54:37', '201506121947266180', '1', '1', '201506122354212302x600x400.png');
INSERT INTO `message_table` VALUES ('201506131433171527', '很开心', 'zhou01', '2015-06-13 14:33:42', '201506131432066810', '1', '1', '201506131433171527x1024x768.png');

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `reportid` bigint(20) NOT NULL AUTO_INCREMENT,
  `reportinfo` varchar(255) NOT NULL,
  `reportuser` varchar(255) NOT NULL,
  `reporttime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reportstatus` int(11) DEFAULT '1',
  `reportimg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reportid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of report
-- ----------------------------

-- ----------------------------
-- Table structure for review_table
-- ----------------------------
DROP TABLE IF EXISTS `review_table`;
CREATE TABLE `review_table` (
  `revid` bigint(20) NOT NULL,
  `msgid` bigint(20) NOT NULL,
  `fromuser` varchar(255) NOT NULL,
  `touser` varchar(255) NOT NULL,
  `revtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `revcontent` text NOT NULL,
  `revstatus` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`revid`),
  KEY `rev_msg_msgid` (`msgid`),
  KEY `re_user_fromuser` (`fromuser`),
  KEY `re_user_touser` (`touser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of review_table
-- ----------------------------
INSERT INTO `review_table` VALUES ('1', '2', 'test01', 'test02', '2015-04-19 23:22:37', '32岁的亨利就坐在那里，深情的目光望过去，都是自己22岁的影子。', '1');
INSERT INTO `review_table` VALUES ('2', '2', 'test01', 'test02', '2015-04-19 23:25:57', '历史最佳射手，海布里的最后一战，海布里的最后一吻。当烟花升起的时刻，那个曾属于亨利的海布里国王时代不会随年华逝去，而只会在年华的飘零中常常记起。', '0');
INSERT INTO `review_table` VALUES ('3', '2', 'test01', 'test02', '2015-04-19 23:27:17', '看台上的伊恩赖特激动万分，他是阿森纳的传奇。又被今天的传奇亨利超越.都是在这片草坪上，那里面有太多的思念太多的故事。融汇在这座93年的足球圣殿，融汇在国王亨利深情的一吻中。', '0');
INSERT INTO `review_table` VALUES ('4', '2', 'test01', 'test02', '2015-04-20 10:33:29', '亨利进入了枪手时代的第8个年头。', '0');
INSERT INTO `review_table` VALUES ('5', '2', 'test01', 'test02', '2015-04-20 11:53:57', '球迷们的欢呼声经久不息，在那8年枪手时代的黄金岁月中，这曾是他最熟悉的，而今，已是他最陌生的。', '0');
INSERT INTO `review_table` VALUES ('6', '2', 'test01', 'test02', '2015-04-20 14:07:43', '还是回到伦敦吧，通往海布里的快车一趟一趟的运行着。这里面总会走过客，迎来新生。', '0');
INSERT INTO `review_table` VALUES ('7', '2', '123', 'test01', '2015-06-11 19:14:01', '背起行囊，走起。gogogo！', '0');
INSERT INTO `review_table` VALUES ('8', '201506121640482743', 'zhou01', 'zhou01', '2015-06-12 17:15:31', '啦啦啦啦啦', '0');
INSERT INTO `review_table` VALUES ('9', '201506122324097304', 'zhou01', '123', '2015-06-13 00:31:16', '哎哟，不错哦', '0');
INSERT INTO `review_table` VALUES ('10', '20150612235607215', 'zhou01', '123', '2015-06-13 07:21:36', '到此一游', '0');
INSERT INTO `review_table` VALUES ('11', '20150612235607215', '123', '123', '2015-06-13 09:31:13', '到此二游', '0');
INSERT INTO `review_table` VALUES ('12', '20150612235607215', '123', '123', '2015-06-13 09:31:45', '联系我', '0');
INSERT INTO `review_table` VALUES ('13', '20150612235607215', '123', '123', '2015-06-13 09:34:02', '好诗，赞', '0');
INSERT INTO `review_table` VALUES ('14', '20150612235607215', '123', '123', '2015-06-13 12:49:23', '咱来一首！', '0');
INSERT INTO `review_table` VALUES ('15', '201506131433171527', 'zhou01', 'zhou01', '2015-06-13 14:34:21', '我也很开心', '0');

-- ----------------------------
-- Table structure for user_msg_collect_table
-- ----------------------------
DROP TABLE IF EXISTS `user_msg_collect_table`;
CREATE TABLE `user_msg_collect_table` (
  `collectmsgid` bigint(20) NOT NULL,
  `username` varchar(255) NOT NULL,
  `msgid` bigint(20) NOT NULL,
  PRIMARY KEY (`collectmsgid`),
  KEY `cltmsg_user_username` (`username`),
  KEY `cltmsg_msg_msgid` (`msgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_msg_collect_table
-- ----------------------------
INSERT INTO `user_msg_collect_table` VALUES ('11', '123', '5');

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `username` varchar(50) NOT NULL,
  `truename` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `photourl` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('1', '1', '1', null, null, null, null, '1');
INSERT INTO `user_table` VALUES ('123', 'zhang123456789', '123', '22', '男', '13400000000', '12320150612225306.png', '1');
INSERT INTO `user_table` VALUES ('admin', '官方墙', 'admin', null, null, null, null, '1');
INSERT INTO `user_table` VALUES ('test01', 'zhou', 'qaz123', '21', '女', '1234555555', 'fwsfqwfqwe', '1');
INSERT INTO `user_table` VALUES ('test02', '测试用户02', 'qaz123', null, '女', '13411111111', null, '0');
INSERT INTO `user_table` VALUES ('test03', '测试用户03', 'qaz123', null, '男', '13422222222', null, '1');
INSERT INTO `user_table` VALUES ('test04', '测试用户04', 'qaz123', null, '女', '13433333333', null, '0');
INSERT INTO `user_table` VALUES ('test06', '测试用户5', 'qaz123', null, null, null, null, '1');
INSERT INTO `user_table` VALUES ('zhang123', 'ImMrz', '123456', null, null, null, null, '1');
INSERT INTO `user_table` VALUES ('zhou', 'zhoudeyi', 'qaz1212', null, null, null, null, '1');
INSERT INTO `user_table` VALUES ('zhou01', '123', 'qaz1212', '21', '女', '13406965700', 'zhou0120150612222312.png', '0');

-- ----------------------------
-- Table structure for user_wall_collect_table
-- ----------------------------
DROP TABLE IF EXISTS `user_wall_collect_table`;
CREATE TABLE `user_wall_collect_table` (
  `collectwallid` bigint(20) NOT NULL,
  `username` varchar(255) NOT NULL,
  `wallid` bigint(20) NOT NULL,
  PRIMARY KEY (`collectwallid`),
  KEY `cltwall_user_username` (`username`),
  KEY `cltwall_wall_wallid` (`wallid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_wall_collect_table
-- ----------------------------
INSERT INTO `user_wall_collect_table` VALUES ('2', 'zhou', '201505031734282887');
INSERT INTO `user_wall_collect_table` VALUES ('6', 'zhou', '201505031736214107');
INSERT INTO `user_wall_collect_table` VALUES ('13', 'zhou', '6');
INSERT INTO `user_wall_collect_table` VALUES ('15', 'zhou', '5');
INSERT INTO `user_wall_collect_table` VALUES ('16', '123', '2');
INSERT INTO `user_wall_collect_table` VALUES ('19', 'zhou', '1');
INSERT INTO `user_wall_collect_table` VALUES ('20', 'zhou', '201505032151523704');
INSERT INTO `user_wall_collect_table` VALUES ('38', 'zhou01', '4');
INSERT INTO `user_wall_collect_table` VALUES ('40', 'zhou01', '1');
INSERT INTO `user_wall_collect_table` VALUES ('41', '123', '3');
INSERT INTO `user_wall_collect_table` VALUES ('42', '123', '4');
INSERT INTO `user_wall_collect_table` VALUES ('55', 'zhou01', '201506092138016304');
INSERT INTO `user_wall_collect_table` VALUES ('59', 'zhou01', '201506101157516772');
INSERT INTO `user_wall_collect_table` VALUES ('64', 'zhou01', '2015060918215817');
INSERT INTO `user_wall_collect_table` VALUES ('70', 'zhou01', '201506121628599617');
INSERT INTO `user_wall_collect_table` VALUES ('71', 'zhou01', '201506122308035704');
INSERT INTO `user_wall_collect_table` VALUES ('72', 'zhou01', '201506122355132899');
INSERT INTO `user_wall_collect_table` VALUES ('73', 'zhou01', '201506122321307540');
INSERT INTO `user_wall_collect_table` VALUES ('79', '123', '201506122321307540');
INSERT INTO `user_wall_collect_table` VALUES ('80', '123', '201506121947266180');
INSERT INTO `user_wall_collect_table` VALUES ('81', 'zhou01', '201506131432066810');

-- ----------------------------
-- Table structure for wall_table
-- ----------------------------
DROP TABLE IF EXISTS `wall_table`;
CREATE TABLE `wall_table` (
  `wallid` bigint(20) NOT NULL,
  `wallname` varchar(255) NOT NULL,
  `wallsignature` text,
  `wallcreator` varchar(255) DEFAULT NULL,
  `wallcreattime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `walltype` int(11) DEFAULT NULL,
  `wallstatus` int(11) NOT NULL DEFAULT '1',
  `xcoordinate` double NOT NULL,
  `ycoordinate` double NOT NULL,
  `wallimage` varchar(255) DEFAULT NULL,
  `walladress` varchar(255) NOT NULL,
  PRIMARY KEY (`wallid`),
  KEY `wall_user_wallcreator` (`wallcreator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wall_table
-- ----------------------------
INSERT INTO `wall_table` VALUES ('2', '测试墙02', '让我做这个项目，刚开始我是拒绝的', 'admin', '2015-04-19 15:55:10', '1', '1', '116.975724', '36.67656', null, '');
INSERT INTO `wall_table` VALUES ('3', '测试墙03', '大四的我坐在球场边，抬头望去，都是自己大一时候的影子', 'admin', '2015-04-19 15:58:52', '1', '1', '116.971524', '36.678576', null, '');
INSERT INTO `wall_table` VALUES ('201506121947266180', '校园一角', '晒图狂魔，快来加入', '123', '2015-06-12 19:52:20', '1', '1', '116.974415', '36.677458', '201506121947266180.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506122240074712', '远方测试墙', '啦啦啦啦啦', 'admin', '2015-06-12 22:40:27', '1', '1', '16.974528', '36.677424', '201506122240074712.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506122253086508', '啦啦啦啦啦', '噢噢噢哦哦', 'admin', '2015-06-12 22:53:29', '1', '1', '116.974415', '36.677399', '201506122253086508.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506122306348312', '秋天的尾巴', '冬天来了，春天还会远吗？', '123', '2015-06-12 23:07:17', '1', '1', '116.974483', '36.677385', '201506122306348312.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506122308035704', '校园春色', '春天，万物复苏不打盹。', '123', '2015-06-12 23:09:30', '1', '1', '116.974483', '36.677385', '201506122308035704.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506122355132899', '大明湖畔', '大明湖，湖明大，大明湖里有蛤蟆', '123', '2015-06-12 23:55:59', '1', '1', '116.974465', '36.677444', '201506122355132899.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506130004046478', '嘘', '你是我的独家记忆。', '123', '2015-06-13 00:06:32', '0', '1', '116.974665', '36.677513', '201506130004046478.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路15-2号');
INSERT INTO `wall_table` VALUES ('201506131432066810', '答辩', '我在答辩', 'zhou01', '2015-06-13 14:32:54', '1', '1', '116.97215', '36.677132', '201506131432066810.png', '中国山东省济南市天桥区堤口路街道无影山胜利庄路');
