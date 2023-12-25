/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 5.7.31-log : Database - dormitory_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dormitory_system` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dormitory_system`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_num` char(10) NOT NULL COMMENT '编号',
  `password` char(20) NOT NULL COMMENT '密码',
  `name` char(5) NOT NULL COMMENT '姓名',
  `sex` char(1) NOT NULL COMMENT '性别',
  `phone` char(15) NOT NULL COMMENT '手机',
  PRIMARY KEY (`admin_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `admin` */

insert  into `admin`(`admin_num`,`password`,`name`,`sex`,`phone`) values 
('1001','123456','张三','男','13610011234'),
('1002','123456','李四','男','13610022345'),
('1003','123456','王五','女','13610033456'),
('1004','123456','赵六','男','13610044567'),
('111','123456','多吃点','男','13024545465');

/*Table structure for table `advice` */

DROP TABLE IF EXISTS `advice`;

CREATE TABLE `advice` (
  `stu_num` char(15) NOT NULL COMMENT '学号',
  `info` text NOT NULL COMMENT '详细信息',
  KEY `advice_FK_stunum` (`stu_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `advice` */

insert  into `advice`(`stu_num`,`info`) values 
('20192019101','建议全天24小时提供热水。');

/*Table structure for table `dormitory` */

DROP TABLE IF EXISTS `dormitory`;

CREATE TABLE `dormitory` (
  `floor_num` char(5) NOT NULL COMMENT '楼号',
  `layer` int(11) NOT NULL COMMENT '楼层',
  `room_num` int(11) NOT NULL COMMENT '宿舍号',
  `bed_total` int(11) NOT NULL COMMENT '总床位数',
  `bed_surplus` int(11) NOT NULL COMMENT '剩余床位数',
  `price` int(11) NOT NULL COMMENT '单价',
  PRIMARY KEY (`floor_num`,`layer`,`room_num`) USING BTREE,
  KEY `floor_num` (`floor_num`) USING BTREE,
  KEY `layer` (`layer`) USING BTREE,
  KEY `room_num` (`room_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `dormitory` */

insert  into `dormitory`(`floor_num`,`layer`,`room_num`,`bed_total`,`bed_surplus`,`price`) values 
('C16',2,263,4,3,150),
('C16',2,264,4,2,150),
('C16',2,265,4,2,150),
('C16',3,321,4,3,150),
('C16',3,322,4,4,150),
('C17',1,101,4,2,150),
('C17',1,102,4,3,150),
('C17',1,103,4,3,150),
('C17',2,201,4,4,150),
('C17',3,301,4,4,150),
('C20',5,501,2,2,450),
('C20',5,520,2,2,450);

/*Table structure for table `floor` */

DROP TABLE IF EXISTS `floor`;

CREATE TABLE `floor` (
  `floor_num` char(5) NOT NULL COMMENT '楼号',
  `layer_amount` int(11) NOT NULL COMMENT '层数',
  `room_amount` int(11) NOT NULL COMMENT '房间数',
  `category` char(5) NOT NULL COMMENT '类别',
  `sex` char(5) NOT NULL COMMENT '居住性别',
  `admin_num` char(10) NOT NULL COMMENT '宿管编号',
  PRIMARY KEY (`floor_num`) USING BTREE,
  UNIQUE KEY `admin_num` (`admin_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `floor` */

insert  into `floor`(`floor_num`,`layer_amount`,`room_amount`,`category`,`sex`,`admin_num`) values 
('a100',6,200,'DDD','男','111'),
('C16',7,140,'普通','男','1001'),
('C17',7,140,'普通','女','1003'),
('C20',5,50,'豪华','混合','1002');

/*Table structure for table `in_out` */

DROP TABLE IF EXISTS `in_out`;

CREATE TABLE `in_out` (
  `stu_num` char(15) NOT NULL COMMENT '学号',
  `floor_num` char(5) NOT NULL COMMENT '楼号',
  `category` char(1) NOT NULL COMMENT '类别（出/入）',
  `time` datetime NOT NULL COMMENT '时间',
  KEY `inout_FK_stunum` (`stu_num`) USING BTREE,
  KEY `inout_FK_floornum` (`floor_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `in_out` */

insert  into `in_out`(`stu_num`,`floor_num`,`category`,`time`) values 
('20192019101','C16','出','2019-09-30 15:30:21'),
('20192019101','C16','入','2019-10-07 10:45:01'),
('20192019103','C17','出','2020-07-13 09:25:00');

/*Table structure for table `repair` */

DROP TABLE IF EXISTS `repair`;

CREATE TABLE `repair` (
  `stu_num` char(15) NOT NULL COMMENT '学号',
  `floor_num` char(5) NOT NULL COMMENT '楼号',
  `layer` int(11) NOT NULL COMMENT '楼层',
  `room_num` int(11) NOT NULL COMMENT '宿舍号',
  `info` text NOT NULL COMMENT '报修详细',
  `yes_no` char(1) NOT NULL COMMENT '是否处理（是/否）',
  KEY `repair_FK_stunum` (`stu_num`) USING BTREE,
  KEY `repair_FK_floornum` (`floor_num`) USING BTREE,
  KEY `repair_FK_layer` (`layer`) USING BTREE,
  KEY `repair_FK_dormitory` (`room_num`,`floor_num`,`layer`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `repair` */

insert  into `repair`(`stu_num`,`floor_num`,`layer`,`room_num`,`info`,`yes_no`) values 
('20192019101','C16',2,263,'宿舍门锁损坏。','否'),
('20192019101','C16',2,263,'厕所堵塞。','否'),
('20192019103','C17',1,101,'空调损坏。','是'),
('20192019102','C16',2,263,'窗户破损。','否'),
('20202020321','C20',5,520,'水龙头损坏。','否'),
('20192019101','C16',2,263,'东风风光','否');

/*Table structure for table `stayinfo` */

DROP TABLE IF EXISTS `stayinfo`;

CREATE TABLE `stayinfo` (
  `stu_num` char(15) NOT NULL COMMENT '学号',
  `floor_num` char(5) NOT NULL COMMENT '楼号',
  `layer` int(11) NOT NULL COMMENT '楼层',
  `room_num` int(11) NOT NULL COMMENT '宿舍号',
  `time` date NOT NULL COMMENT '入住时间',
  PRIMARY KEY (`stu_num`) USING BTREE,
  KEY `stayinfo_FK_layer` (`layer`) USING BTREE,
  KEY `stayinfo_FK_roomnum` (`room_num`) USING BTREE,
  KEY `stayinfo_FK_dormitory` (`floor_num`,`layer`,`room_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `stayinfo` */

insert  into `stayinfo`(`stu_num`,`floor_num`,`layer`,`room_num`,`time`) values 
('110','C16',2,263,'2023-07-21'),
('20192019101','C16',2,264,'2023-07-21'),
('20192019102','C16',2,264,'2023-07-21'),
('20192019103','C17',1,102,'2023-07-21'),
('20192019510','C17',1,101,'2023-07-21'),
('20192019511','C17',1,101,'2023-07-21'),
('20202020321','C16',2,265,'2023-07-21'),
('20202020322','C16',2,265,'2023-07-21'),
('20212021303','C16',3,321,'2023-07-21'),
('20212021304','C17',1,103,'2023-07-21');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `stu_num` char(15) NOT NULL COMMENT '学号',
  `password` char(20) NOT NULL COMMENT '密码',
  `name` char(5) NOT NULL COMMENT '姓名',
  `sex` char(1) NOT NULL COMMENT '性别',
  `birth` int(11) NOT NULL COMMENT '出生日期（用于计算年龄）',
  `grade` int(11) NOT NULL COMMENT '年级',
  `faculty` char(10) NOT NULL COMMENT '院系',
  `class` char(10) NOT NULL COMMENT '班级',
  `phone` char(15) NOT NULL COMMENT '手机',
  `yes_no` char(1) NOT NULL COMMENT '是否入住（是/否）',
  PRIMARY KEY (`stu_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `student` */

insert  into `student`(`stu_num`,`password`,`name`,`sex`,`birth`,`grade`,`faculty`,`class`,`phone`,`yes_no`) values 
('110','110','方法','男',20000112,2019,'多对多','多对多','12222222222','是'),
('20192019101','12345678','小明','男',2000,2019,'计算机工程学院','网络工程2班','13692871011','是'),
('20192019102','12345678','小刚','男',2000,2019,'计算机工程学院','网络工程2班','13692871022','是'),
('20192019103','12345678','小红','女',2001,2019,'计算机工程学院','网络工程2班','13692871033','是'),
('20192019510','12345678','小橙','女',2000,2019,'管理学院','会计学1班','13692875100','是'),
('20192019511','12345678','小黄','女',2001,2019,'管理学院','会计学1班','13692875111','是'),
('20202020321','12345678','小绿','男',2002,2020,'电气学院','电气工程1班','13692873211','是'),
('20202020322','12345678','小蓝','男',2001,2020,'电气学院','电气工程1班','13692873222','是'),
('20212021303','12345678','小靛','男',2002,2021,'计算机工程学院','软件工程1班','13692873033','是'),
('20212021304','12345678','小紫','女',2003,2021,'计算机工程学院','软件工程1班','13692873044','是');

/*Table structure for table `adminview_advice` */

DROP TABLE IF EXISTS `adminview_advice`;

/*!50001 DROP VIEW IF EXISTS `adminview_advice` */;
/*!50001 DROP TABLE IF EXISTS `adminview_advice` */;

/*!50001 CREATE TABLE  `adminview_advice`(
 `stu_num` char(15) ,
 `name` char(5) ,
 `info` text ,
 `admin_num` char(10) 
)*/;

/*Table structure for table `adminview_student` */

DROP TABLE IF EXISTS `adminview_student`;

/*!50001 DROP VIEW IF EXISTS `adminview_student` */;
/*!50001 DROP TABLE IF EXISTS `adminview_student` */;

/*!50001 CREATE TABLE  `adminview_student`(
 `stu_num` char(15) ,
 `password` char(20) ,
 `name` char(5) ,
 `sex` char(1) ,
 `birth` int(11) ,
 `grade` int(11) ,
 `faculty` char(10) ,
 `class` char(10) ,
 `phone` char(15) ,
 `yes_no` char(1) ,
 `floor_num` char(5) 
)*/;

/*Table structure for table `student_advice` */

DROP TABLE IF EXISTS `student_advice`;

/*!50001 DROP VIEW IF EXISTS `student_advice` */;
/*!50001 DROP TABLE IF EXISTS `student_advice` */;

/*!50001 CREATE TABLE  `student_advice`(
 `stu_num` char(15) ,
 `name` char(5) ,
 `info` text 
)*/;

/*Table structure for table `student_inout` */

DROP TABLE IF EXISTS `student_inout`;

/*!50001 DROP VIEW IF EXISTS `student_inout` */;
/*!50001 DROP TABLE IF EXISTS `student_inout` */;

/*!50001 CREATE TABLE  `student_inout`(
 `stu_num` char(15) ,
 `name` char(5) ,
 `floor_num` char(5) ,
 `category` char(1) ,
 `time` datetime 
)*/;

/*Table structure for table `student_repair` */

DROP TABLE IF EXISTS `student_repair`;

/*!50001 DROP VIEW IF EXISTS `student_repair` */;
/*!50001 DROP TABLE IF EXISTS `student_repair` */;

/*!50001 CREATE TABLE  `student_repair`(
 `stu_num` char(15) ,
 `name` char(5) ,
 `floor_num` char(5) ,
 `layer` int(11) ,
 `room_num` int(11) ,
 `info` text ,
 `yes_no` char(1) 
)*/;

/*Table structure for table `student_stayinfo` */

DROP TABLE IF EXISTS `student_stayinfo`;

/*!50001 DROP VIEW IF EXISTS `student_stayinfo` */;
/*!50001 DROP TABLE IF EXISTS `student_stayinfo` */;

/*!50001 CREATE TABLE  `student_stayinfo`(
 `stu_num` char(15) ,
 `name` char(5) ,
 `floor_num` char(5) ,
 `layer` int(11) ,
 `room_num` int(11) ,
 `time` date 
)*/;

/*View structure for view adminview_advice */

/*!50001 DROP TABLE IF EXISTS `adminview_advice` */;
/*!50001 DROP VIEW IF EXISTS `adminview_advice` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `adminview_advice` AS select `advice`.`stu_num` AS `stu_num`,`student`.`name` AS `name`,`advice`.`info` AS `info`,`floor`.`admin_num` AS `admin_num` from (((`advice` join `student` on((`advice`.`stu_num` = `student`.`stu_num`))) join `stayinfo` on((`advice`.`stu_num` = `stayinfo`.`stu_num`))) join `floor` on((`stayinfo`.`floor_num` = `floor`.`floor_num`))) */;

/*View structure for view adminview_student */

/*!50001 DROP TABLE IF EXISTS `adminview_student` */;
/*!50001 DROP VIEW IF EXISTS `adminview_student` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `adminview_student` AS select `student`.`stu_num` AS `stu_num`,`student`.`password` AS `password`,`student`.`name` AS `name`,`student`.`sex` AS `sex`,`student`.`birth` AS `birth`,`student`.`grade` AS `grade`,`student`.`faculty` AS `faculty`,`student`.`class` AS `class`,`student`.`phone` AS `phone`,`student`.`yes_no` AS `yes_no`,`stayinfo`.`floor_num` AS `floor_num` from (`student` join `stayinfo` on((`student`.`stu_num` = `stayinfo`.`stu_num`))) */;

/*View structure for view student_advice */

/*!50001 DROP TABLE IF EXISTS `student_advice` */;
/*!50001 DROP VIEW IF EXISTS `student_advice` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_advice` AS select `advice`.`stu_num` AS `stu_num`,`student`.`name` AS `name`,`advice`.`info` AS `info` from (`student` join `advice` on((`student`.`stu_num` = `advice`.`stu_num`))) */;

/*View structure for view student_inout */

/*!50001 DROP TABLE IF EXISTS `student_inout` */;
/*!50001 DROP VIEW IF EXISTS `student_inout` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_inout` AS select `in_out`.`stu_num` AS `stu_num`,`student`.`name` AS `name`,`in_out`.`floor_num` AS `floor_num`,`in_out`.`category` AS `category`,`in_out`.`time` AS `time` from (`student` join `in_out` on((`student`.`stu_num` = `in_out`.`stu_num`))) */;

/*View structure for view student_repair */

/*!50001 DROP TABLE IF EXISTS `student_repair` */;
/*!50001 DROP VIEW IF EXISTS `student_repair` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_repair` AS select `repair`.`stu_num` AS `stu_num`,`student`.`name` AS `name`,`repair`.`floor_num` AS `floor_num`,`repair`.`layer` AS `layer`,`repair`.`room_num` AS `room_num`,`repair`.`info` AS `info`,`repair`.`yes_no` AS `yes_no` from (`student` join `repair` on((`student`.`stu_num` = `repair`.`stu_num`))) */;

/*View structure for view student_stayinfo */

/*!50001 DROP TABLE IF EXISTS `student_stayinfo` */;
/*!50001 DROP VIEW IF EXISTS `student_stayinfo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_stayinfo` AS select `student`.`stu_num` AS `stu_num`,`student`.`name` AS `name`,`stayinfo`.`floor_num` AS `floor_num`,`stayinfo`.`layer` AS `layer`,`stayinfo`.`room_num` AS `room_num`,`stayinfo`.`time` AS `time` from (`student` join `stayinfo` on((`student`.`stu_num` = `stayinfo`.`stu_num`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
