-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: SecKill
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `SecKill`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `SecKill` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `SecKill`;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `price` decimal(64,2) NOT NULL DEFAULT '0.00',
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sales` int NOT NULL DEFAULT '0',
  `img_url` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'新疆哈密瓜',89.99,'超甜！！',3,'https://tse3-mm.cn.bing.net/th/id/OIP-C.YQiByWvbOiGyOVivkdzMlQHaHa?w=199&h=199&c=7&r=0&o=5&dpr=1.25&pid=1.7'),(2,'玫瑰红提',39.99,'nice',0,'https://tse3-mm.cn.bing.net/th/id/OIP-C.bEMcYuvLlk2ARfNlPutG_QHaE7?w=262&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'),(3,'小番茄',49.99,'第一新鲜',4,'https://tse2-mm.cn.bing.net/th/id/OIP-C.qudk4JKZjvXPPSYiMMCNTwHaHa?w=199&h=199&c=7&r=0&o=5&dpr=1.25&pid=1.7'),(4,'8424瓜瓜',89.00,'皮薄无籽',0,'https://tse3-mm.cn.bing.net/th/id/OIP-C.G4oc78okHiQElIwybopSfAHaE7?w=298&h=199&c=7&r=0&o=5&dpr=1.25&pid=1.7'),(5,'车厘子',200.00,'智利进口',3,'https://tse3-mm.cn.bing.net/th/id/OIP-C.oknABKjrhAiS6Ded-FyavwHaHa?w=185&h=185&c=7&r=0&o=5&dpr=1.25&pid=1.7');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_stock`
--

DROP TABLE IF EXISTS `item_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock` int NOT NULL DEFAULT '0',
  `item_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_stock`
--

LOCK TABLES `item_stock` WRITE;
/*!40000 ALTER TABLE `item_stock` DISABLE KEYS */;
INSERT INTO `item_stock` VALUES (9,97,1),(10,100,2),(11,96,3),(12,300,4),(13,197,5);
/*!40000 ALTER TABLE `item_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_info` (
  `id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `item_id` int NOT NULL DEFAULT '0',
  `item_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount` int NOT NULL DEFAULT '0',
  `order_price` decimal(40,2) NOT NULL DEFAULT '0.00',
  `promo_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES ('2022072400000600',60,5,200.00,1,200.00,0),('2022072400000700',60,5,200.00,1,200.00,0),('2022072400000800',60,3,49.99,1,49.99,0),('2022072400000900',60,5,10.00,1,10.00,3);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo`
--

DROP TABLE IF EXISTS `promo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promo_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `start_date` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `item_id` int NOT NULL DEFAULT '0',
  `promo_item_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo`
--

LOCK TABLES `promo` WRITE;
/*!40000 ALTER TABLE `promo` DISABLE KEYS */;
INSERT INTO `promo` VALUES (3,'车厘子抢购活动','2022-07-29 07:40:00','2022-07-29 08:30:00',5,10.00);
/*!40000 ALTER TABLE `promo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence_info`
--

DROP TABLE IF EXISTS `sequence_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequence_info` (
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL,
  `current_value` int NOT NULL DEFAULT '0',
  `step` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence_info`
--

LOCK TABLES `sequence_info` WRITE;
/*!40000 ALTER TABLE `sequence_info` DISABLE KEYS */;
INSERT INTO `sequence_info` VALUES ('order_info',10,1);
/*!40000 ALTER TABLE `sequence_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `gender` tinyint NOT NULL DEFAULT '0' COMMENT '1代表男性\r\n',
  `age` int NOT NULL DEFAULT '0',
  `telphone` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `regisit_mode` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '//byphone,bywechat,byalipay,',
  `third_party_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `telphone_unique_index` (`telphone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (40,'1',1,1,'123','byphone',0),(52,'1',1,1,'111111','byphone',0),(53,'1',1,11111111,'11','byphone',0),(55,'1',1,1,'111','byphone',0),(56,'ad',1,23,'123456789','byphone',0),(57,'dd',1,11,'3242344','byphone',0),(59,'22',2,22,'1212121','byphone',0),(60,'77',1,77,'77477','byphone',0);
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_password`
--

DROP TABLE IF EXISTS `user_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_password` (
  `id` int NOT NULL AUTO_INCREMENT,
  `encrpt_password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8_bin NOT NULL DEFAULT '',
  `user_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `use_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_password`
--

LOCK TABLES `user_password` WRITE;
/*!40000 ALTER TABLE `user_password` DISABLE KEYS */;
INSERT INTO `user_password` VALUES (18,'ICy5YqxZB1uWSwcVLSNLcA==',40),(19,'xMpCOKC5I4INzFCab3WEmw==',0),(20,'xMpCOKC5I4INzFCab3WEmw==',0),(21,'ICy5YqxZB1uWSwcVLSNLcA==',0),(22,'xMpCOKC5I4INzFCab3WEmw==',52),(23,'xMpCOKC5I4INzFCab3WEmw==',53),(24,'xMpCOKC5I4INzFCab3WEmw==',55),(25,'4QrcOUm6Wau+VuBX8g+IPg==',0),(26,'ZRK9Q9nKpuAsmQsKgmUtyg==',0),(27,'ttdn0vjtXSGkSw5YhmgMuQ==',0),(28,'KN0seVXOkmRWJAsv8BAL3g==',60);
/*!40000 ALTER TABLE `user_password` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-29 16:23:22
