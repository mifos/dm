-- MySQL dump 10.13  Distrib 5.1.55, for Win32 (ia32)
--
-- Host: localhost    Database: stage1
-- ------------------------------------------------------
-- Server version	5.1.55-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_schedule_test`
--

DROP TABLE IF EXISTS `customer_schedule_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_schedule_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) DEFAULT NULL,
  `action_date` date DEFAULT NULL,
  `misc_fees` decimal(21,4) DEFAULT NULL,
  `misc_fees_currency_id` smallint(6) DEFAULT NULL,
  `misc_fees_paid` decimal(21,4) DEFAULT NULL,
  `misc_fees_paid_currency_id` smallint(6) DEFAULT NULL,
  `misc_penalty` decimal(21,4) DEFAULT NULL,
  `misc_penalty_currency_id` smallint(6) DEFAULT NULL,
  `misc_penalty_paid` decimal(21,4) DEFAULT NULL,
  `misc_penalty_paid_currency_id` smallint(6) DEFAULT NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `parent_flag` smallint(6) DEFAULT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `currency_id` (`currency_id`),
  KEY `customer_schedule_test_action_date_idx` (`customer_id`,`action_date`,`payment_status`),
  CONSTRAINT `customer_schedule_test_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_schedule_test_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_schedule_test_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_schedule_test`
--

LOCK TABLES `customer_schedule_test` WRITE;
/*!40000 ALTER TABLE `customer_schedule_test` DISABLE KEYS */;
INSERT INTO `customer_schedule_test` VALUES (1,1,1,2,'2011-08-02','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,1,NULL,NULL,0),(2,1,1,2,'2011-08-09','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(3,1,1,2,'2011-08-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(4,1,1,2,'2011-08-23','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(5,1,1,2,'2011-08-30','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(6,1,1,2,'2011-09-06','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(7,1,1,2,'2011-09-13','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(8,1,1,2,'2011-09-20','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(9,1,1,2,'2011-09-27','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(10,1,1,2,'2011-10-04','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0),(11,3,3,2,'2011-08-02','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,1,NULL,NULL,0),(12,3,3,2,'2011-08-09','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(13,3,3,2,'2011-08-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(14,3,3,2,'2011-08-23','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(15,3,3,2,'2011-08-30','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(16,3,3,2,'2011-09-06','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(17,3,3,2,'2011-09-13','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(18,3,3,2,'2011-09-20','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(19,3,3,2,'2011-09-27','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(20,3,3,2,'2011-10-04','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0),(21,5,5,2,'2011-08-02','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,1,1,'2011-08-02',NULL,0),(22,5,5,2,'2011-08-09','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(23,5,5,2,'2011-08-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(24,5,5,2,'2011-08-23','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(25,5,5,2,'2011-08-30','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(26,5,5,2,'2011-09-06','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(27,5,5,2,'2011-09-13','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(28,5,5,2,'2011-09-20','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(29,5,5,2,'2011-09-27','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(30,5,5,2,'2011-10-04','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0),(31,2,2,2,'2011-08-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,1,NULL,NULL,0),(32,2,2,2,'2011-09-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(33,2,2,2,'2011-10-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(34,2,2,2,'2011-11-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(35,2,2,2,'2011-12-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(36,2,2,2,'2012-01-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(37,2,2,2,'2012-02-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(38,2,2,2,'2012-03-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(39,2,2,2,'2012-04-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(40,2,2,2,'2012-05-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0),(41,4,4,2,'2011-08-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,1,NULL,NULL,0),(42,4,4,2,'2011-09-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(43,4,4,2,'2011-10-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(44,4,4,2,'2011-11-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(45,4,4,2,'2011-12-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(46,4,4,2,'2012-01-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(47,4,4,2,'2012-02-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(48,4,4,2,'2012-03-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(49,4,4,2,'2012-04-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(50,4,4,2,'2012-05-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0),(51,6,6,2,'2011-08-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,1,1,'2011-08-15',NULL,0),(52,6,6,2,'2011-09-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,2,NULL,NULL,0),(53,6,6,2,'2011-10-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,NULL,0),(54,6,6,2,'2011-11-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,NULL,0),(55,6,6,2,'2011-12-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,NULL,0),(56,6,6,2,'2012-01-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,NULL,0),(57,6,6,2,'2012-02-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,NULL,0),(58,6,6,2,'2012-03-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,NULL,0),(59,6,6,2,'2012-04-16','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,NULL,0),(60,6,6,2,'2012-05-15','0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,NULL,0);
/*!40000 ALTER TABLE `customer_schedule_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_fee_schedule_test`
--

DROP TABLE IF EXISTS `customer_fee_schedule_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_fee_schedule_test` (
  `account_fees_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `account_fee_id` int(11) NOT NULL,
  `amount` decimal(21,4) DEFAULT NULL,
  `amount_currency_id` smallint(6) DEFAULT NULL,
  `amount_paid` decimal(21,4) DEFAULT NULL,
  `amount_paid_currency_id` smallint(6) DEFAULT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY (`account_fees_detail_id`),
  KEY `id` (`id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `amount_paid_currency_id` (`amount_paid_currency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_id` (`account_fee_id`),
  CONSTRAINT `customer_fee_schedule_test_ibfk_1` FOREIGN KEY (`id`) REFERENCES `customer_schedule_test` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_test_ibfk_2` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_test_ibfk_3` FOREIGN KEY (`amount_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_test_ibfk_4` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`),
  CONSTRAINT `customer_fee_schedule_test_ibfk_5` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_fee_schedule_test`
--

LOCK TABLES `customer_fee_schedule_test` WRITE;
/*!40000 ALTER TABLE `customer_fee_schedule_test` DISABLE KEYS */;
INSERT INTO `customer_fee_schedule_test` VALUES (1,21,1,2,1,'50.0000',2,'50.0000',2,0),(2,51,1,1,2,'100.0000',2,'100.0000',2,0);
/*!40000 ALTER TABLE `customer_fee_schedule_test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-07-27 15:08:35
