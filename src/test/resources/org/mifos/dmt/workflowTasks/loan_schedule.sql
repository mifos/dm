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
-- Table structure for table `loan_schedule_test`
--

DROP TABLE IF EXISTS `loan_schedule_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan_schedule_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) DEFAULT NULL,
  `action_date` date DEFAULT NULL,
  `principal` decimal(21,4) NOT NULL,
  `principal_currency_id` smallint(6) DEFAULT NULL,
  `interest` decimal(21,4) NOT NULL,
  `interest_currency_id` smallint(6) DEFAULT NULL,
  `penalty` decimal(21,4) NOT NULL,
  `penalty_currency_id` smallint(6) DEFAULT NULL,
  `misc_fees` decimal(21,4) DEFAULT NULL,
  `misc_fees_currency_id` smallint(6) DEFAULT NULL,
  `misc_fees_paid` decimal(21,4) DEFAULT NULL,
  `misc_fees_paid_currency_id` smallint(6) DEFAULT NULL,
  `misc_penalty` decimal(21,4) DEFAULT NULL,
  `misc_penalty_currency_id` smallint(6) DEFAULT NULL,
  `misc_penalty_paid` decimal(21,4) DEFAULT NULL,
  `misc_penalty_paid_currency_id` smallint(6) DEFAULT NULL,
  `principal_paid` decimal(21,4) DEFAULT NULL,
  `principal_paid_currency_id` smallint(6) DEFAULT NULL,
  `interest_paid` decimal(21,4) DEFAULT NULL,
  `interest_paid_currency_id` smallint(6) DEFAULT NULL,
  `penalty_paid` decimal(21,4) DEFAULT NULL,
  `penalty_paid_currency_id` smallint(6) DEFAULT NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `parent_flag` smallint(6) DEFAULT NULL,
  `version_no` int(11) NOT NULL,
  `extra_interest` decimal(21,4) DEFAULT NULL,
  `extra_interest_currency_id` smallint(6) DEFAULT NULL,
  `extra_interest_paid` decimal(21,4) DEFAULT NULL,
  `extra_interest_paid_currency_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `currency_id` (`currency_id`),
  KEY `principal_currency_id` (`principal_currency_id`),
  KEY `interest_currency_id` (`interest_currency_id`),
  KEY `penalty_currency_id` (`penalty_currency_id`),
  KEY `misc_fees_currency_id` (`misc_fees_currency_id`),
  KEY `misc_fees_paid_currency_id` (`misc_fees_paid_currency_id`),
  KEY `misc_penalty_currency_id` (`misc_penalty_currency_id`),
  KEY `principal_paid_currency_id` (`principal_paid_currency_id`),
  KEY `interest_paid_currency_id` (`interest_paid_currency_id`),
  KEY `penalty_paid_currency_id` (`penalty_paid_currency_id`),
  KEY `misc_penalty_paid_currency_id` (`misc_penalty_paid_currency_id`),
  KEY `customer_id` (`customer_id`),
  KEY `extra_interest_currency_id` (`extra_interest_currency_id`),
  KEY `extra_interest_paid_currency_id` (`extra_interest_paid_currency_id`),
  CONSTRAINT `loan_schedule_test_ibfk_15` FOREIGN KEY (`extra_interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_10` FOREIGN KEY (`interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_11` FOREIGN KEY (`penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_12` FOREIGN KEY (`misc_penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_13` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_14` FOREIGN KEY (`extra_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_3` FOREIGN KEY (`principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_4` FOREIGN KEY (`interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_5` FOREIGN KEY (`penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_6` FOREIGN KEY (`misc_fees_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_7` FOREIGN KEY (`misc_fees_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_8` FOREIGN KEY (`misc_penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_test_ibfk_9` FOREIGN KEY (`principal_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_schedule_test`
--

LOCK TABLES `loan_schedule_test` WRITE;
/*!40000 ALTER TABLE `loan_schedule_test` DISABLE KEYS */;
INSERT INTO `loan_schedule_test` VALUES (1,7,5,2,'2011-01-18','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'500.0000',2,'46.0000',2,'0.0000',2,1,1,'2011-01-18',0,0,NULL,NULL,NULL,NULL),(2,7,5,2,'2011-01-25','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'500.0000',2,'46.0000',2,'0.0000',2,1,2,'2011-01-25',0,0,NULL,NULL,NULL,NULL),(3,7,5,2,'2011-02-01','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'500.0000',2,'46.0000',2,'0.0000',2,1,3,'2011-02-01',0,0,NULL,NULL,NULL,NULL),(4,7,5,2,'2011-02-08','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'316.0000',2,'46.0000',2,'0.0000',2,0,4,'2011-02-08',0,0,NULL,NULL,NULL,NULL),(5,7,5,2,'2011-02-15','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,0,0,NULL,NULL,NULL,NULL),(6,7,5,2,'2011-02-22','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,0,0,NULL,NULL,NULL,NULL),(7,7,5,2,'2011-03-01','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,0,0,NULL,NULL,NULL,NULL),(8,7,5,2,'2011-03-08','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,0,0,NULL,NULL,NULL,NULL),(9,7,5,2,'2011-03-15','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,0,0,NULL,NULL,NULL,NULL),(10,7,5,2,'2011-03-22','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,0,0,NULL,NULL,NULL,NULL),(11,7,5,2,'2011-03-29','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,11,NULL,0,0,NULL,NULL,NULL,NULL),(12,7,5,2,'2011-04-05','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,12,NULL,0,0,NULL,NULL,NULL,NULL),(13,7,5,2,'2011-04-12','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,13,NULL,0,0,NULL,NULL,NULL,NULL),(14,7,5,2,'2011-04-19','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,14,NULL,0,0,NULL,NULL,NULL,NULL),(15,7,5,2,'2011-04-26','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,15,NULL,0,0,NULL,NULL,NULL,NULL),(16,7,5,2,'2011-05-03','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,16,NULL,0,0,NULL,NULL,NULL,NULL),(17,7,5,2,'2011-05-10','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,17,NULL,0,0,NULL,NULL,NULL,NULL),(18,7,5,2,'2011-05-17','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,18,NULL,0,0,NULL,NULL,NULL,NULL),(19,7,5,2,'2011-05-24','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,19,NULL,0,0,NULL,NULL,NULL,NULL),(20,7,5,2,'2011-05-31','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,20,NULL,0,0,NULL,NULL,NULL,NULL),(21,7,5,2,'2011-06-07','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,21,NULL,0,0,NULL,NULL,NULL,NULL),(22,7,5,2,'2011-06-14','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,22,NULL,0,0,NULL,NULL,NULL,NULL),(23,7,5,2,'2011-06-21','500.0000',2,'46.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,23,NULL,0,0,NULL,NULL,NULL,NULL),(24,7,5,2,'2011-06-28','500.0000',2,'46.6000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,24,NULL,0,0,NULL,NULL,NULL,NULL),(25,8,6,2,'2010-12-15','912.0000',2,'200.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'912.0000',2,'200.0000',2,'0.0000',2,1,1,'2010-12-15',0,0,NULL,NULL,NULL,NULL),(26,8,6,2,'2011-01-15','927.2000',2,'184.8000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'628.2000',2,'184.8000',2,'0.0000',2,0,2,'2011-01-15',0,0,NULL,NULL,NULL,NULL),(27,8,6,2,'2011-02-15','942.7000',2,'169.3000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,3,NULL,0,0,NULL,NULL,NULL,NULL),(28,8,6,2,'2011-03-15','958.4000',2,'153.6000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,4,NULL,0,0,NULL,NULL,NULL,NULL),(29,8,6,2,'2011-04-15','974.3000',2,'137.7000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,5,NULL,0,0,NULL,NULL,NULL,NULL),(30,8,6,2,'2011-05-16','990.6000',2,'121.4000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,6,NULL,0,0,NULL,NULL,NULL,NULL),(31,8,6,2,'2011-06-15','1007.1000',2,'104.9000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,7,NULL,0,0,NULL,NULL,NULL,NULL),(32,8,6,2,'2011-07-15','1023.9000',2,'88.1000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,8,NULL,0,0,NULL,NULL,NULL,NULL),(33,8,6,2,'2011-08-15','1040.9000',2,'71.1000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,9,NULL,0,0,NULL,NULL,NULL,NULL),(34,8,6,2,'2011-09-15','1058.3000',2,'53.7000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,10,NULL,0,0,NULL,NULL,NULL,NULL),(35,8,6,2,'2011-10-15','1075.9000',2,'36.1000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,11,NULL,0,0,NULL,NULL,NULL,NULL),(36,8,6,2,'2011-11-15','1088.7000',2,'18.3000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,'0.0000',2,0,12,NULL,0,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `loan_schedule_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_fee_schedule_test`
--

DROP TABLE IF EXISTS `loan_fee_schedule_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan_fee_schedule_test` (
  `account_fees_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `account_fee_id` int(11) NOT NULL,
  `amount` decimal(21,4) DEFAULT NULL,
  `amount_currency_id` smallint(6) DEFAULT NULL,
  `amount_paid` decimal(21,4) NOT NULL,
  `amount_paid_currency_id` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY (`account_fees_detail_id`),
  KEY `id` (`id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `amount_paid_currency_id` (`amount_paid_currency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_id` (`account_fee_id`),
  CONSTRAINT `loan_fee_schedule_test_ibfk_1` FOREIGN KEY (`id`) REFERENCES `loan_schedule_test` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_test_ibfk_2` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_test_ibfk_3` FOREIGN KEY (`amount_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_test_ibfk_4` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`),
  CONSTRAINT `loan_fee_schedule_test_ibfk_5` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_fee_schedule_test`
--

LOCK TABLES `loan_fee_schedule_test` WRITE;
/*!40000 ALTER TABLE `loan_fee_schedule_test` DISABLE KEYS */;
INSERT INTO `loan_fee_schedule_test` VALUES (1,25,1,3,4,'75.0000',2,'75.0000',2,0);
/*!40000 ALTER TABLE `loan_fee_schedule_test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-07-27 16:38:30
