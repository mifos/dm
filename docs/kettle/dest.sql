-- MySQL dump 10.11
--
-- Host: localhost    Database: mifos
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt

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
-- Table structure for table `accepted_payment_type`
--

DROP TABLE IF EXISTS `accepted_payment_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `accepted_payment_type` (
  `accepted_payment_type_id` smallint(6) NOT NULL auto_increment,
  `transaction_id` smallint(6) NOT NULL,
  `payment_type_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`accepted_payment_type_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `payment_type_id` (`payment_type_id`),
  CONSTRAINT `accepted_payment_type_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction_type` (`transaction_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `accepted_payment_type_ibfk_2` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `accepted_payment_type`
--

LOCK TABLES `accepted_payment_type` WRITE;
/*!40000 ALTER TABLE `accepted_payment_type` DISABLE KEYS */;
INSERT INTO `accepted_payment_type` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1);
/*!40000 ALTER TABLE `accepted_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL auto_increment,
  `global_account_num` varchar(100) default NULL,
  `customer_id` int(11) default NULL,
  `account_state_id` smallint(6) default NULL,
  `account_type_id` smallint(6) NOT NULL,
  `office_id` smallint(6) default NULL,
  `personnel_id` smallint(6) default NULL,
  `created_by` smallint(6) NOT NULL,
  `created_date` date NOT NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `closed_date` date default NULL,
  `version_no` int(11) default NULL,
  `offsetting_allowable` smallint(6) NOT NULL,
  `external_id` varchar(100) default NULL,
  PRIMARY KEY  (`account_id`),
  UNIQUE KEY `account_global_idx` (`global_account_num`),
  KEY `account_state_id` (`account_state_id`),
  KEY `account_type_id` (`account_type_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `office_id` (`office_id`),
  KEY `customer_id_account_idx` (`customer_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`account_state_id`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_ibfk_4` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_ibfk_5` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_action`
--

DROP TABLE IF EXISTS `account_action`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_action` (
  `account_action_id` smallint(6) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`account_action_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `account_action_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_action`
--

LOCK TABLES `account_action` WRITE;
/*!40000 ALTER TABLE `account_action` DISABLE KEYS */;
INSERT INTO `account_action` VALUES (1,167),(2,168),(3,169),(4,170),(5,171),(6,172),(7,173),(8,191),(9,192),(10,193),(11,214),(12,362),(13,364),(14,366),(15,547),(16,548),(17,549),(18,572),(19,573),(20,610);
/*!40000 ALTER TABLE `account_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_activity`
--

DROP TABLE IF EXISTS `account_activity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_activity` (
  `activity_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `personnel_id` smallint(6) NOT NULL,
  `activity_name` varchar(50) NOT NULL,
  `principal` decimal(21,4) default NULL,
  `principal_currency_id` smallint(6) default NULL,
  `principal_outstanding` decimal(21,4) default NULL,
  `principal_outstanding_currency_id` smallint(6) default NULL,
  `interest` decimal(13,10) default NULL,
  `interest_currency_id` smallint(6) default NULL,
  `interest_outstanding` decimal(13,10) default NULL,
  `interest_outstanding_currency_id` smallint(6) default NULL,
  `fee` decimal(13,2) default NULL,
  `fee_currency_id` smallint(6) default NULL,
  `fee_outstanding` decimal(13,2) default NULL,
  `fee_outstanding_currency_id` smallint(6) default NULL,
  `penalty` decimal(13,10) default NULL,
  `penalty_currency_id` smallint(6) default NULL,
  `penalty_outstanding` decimal(13,10) default NULL,
  `penalty_outstanding_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`activity_id`),
  KEY `account_id` (`account_id`),
  KEY `principal_currency_id` (`principal_currency_id`),
  KEY `principal_outstanding_currency_id` (`principal_outstanding_currency_id`),
  KEY `interest_currency_id` (`interest_currency_id`),
  KEY `interest_outstanding_currency_id` (`interest_outstanding_currency_id`),
  KEY `fee_currency_id` (`fee_currency_id`),
  KEY `fee_outstanding_currency_id` (`fee_outstanding_currency_id`),
  KEY `penalty_currency_id` (`penalty_currency_id`),
  KEY `penalty_outstanding_currency_id` (`penalty_outstanding_currency_id`),
  CONSTRAINT `account_activity_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_2` FOREIGN KEY (`principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_3` FOREIGN KEY (`principal_outstanding_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_4` FOREIGN KEY (`interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_5` FOREIGN KEY (`interest_outstanding_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_6` FOREIGN KEY (`fee_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_7` FOREIGN KEY (`fee_outstanding_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_8` FOREIGN KEY (`penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_activity_ibfk_9` FOREIGN KEY (`penalty_outstanding_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_activity`
--

LOCK TABLES `account_activity` WRITE;
/*!40000 ALTER TABLE `account_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_custom_field`
--

DROP TABLE IF EXISTS `account_custom_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_custom_field` (
  `account_custom_field_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `field_id` smallint(6) NOT NULL,
  `field_value` varchar(200) default NULL,
  PRIMARY KEY  (`account_custom_field_id`),
  KEY `field_id` (`field_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `account_custom_field_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `custom_field_definition` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_custom_field_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_custom_field`
--

LOCK TABLES `account_custom_field` WRITE;
/*!40000 ALTER TABLE `account_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_fees`
--

DROP TABLE IF EXISTS `account_fees`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_fees` (
  `account_fee_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `fee_frequency` int(11) default NULL,
  `status` smallint(6) default NULL,
  `inherited_flag` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `account_fee_amnt` decimal(21,4) NOT NULL,
  `account_fee_amnt_currency_id` smallint(6) default NULL,
  `fee_amnt` decimal(21,4) NOT NULL,
  `fee_status` smallint(6) default NULL,
  `status_change_date` date default NULL,
  `version_no` int(11) NOT NULL,
  `last_applied_date` date default NULL,
  PRIMARY KEY  (`account_fee_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_amnt_currency_id` (`account_fee_amnt_currency_id`),
  KEY `fee_frequency` (`fee_frequency`),
  KEY `account_fees_id_idx` (`account_id`,`fee_id`),
  CONSTRAINT `account_fees_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_fees_ibfk_2` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_fees_ibfk_3` FOREIGN KEY (`account_fee_amnt_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_fees_ibfk_4` FOREIGN KEY (`fee_frequency`) REFERENCES `recurrence_detail` (`details_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_fees`
--

LOCK TABLES `account_fees` WRITE;
/*!40000 ALTER TABLE `account_fees` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_flag_detail`
--

DROP TABLE IF EXISTS `account_flag_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_flag_detail` (
  `account_flag_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `flag_id` smallint(6) NOT NULL,
  `created_by` smallint(6) NOT NULL,
  `created_date` date NOT NULL,
  PRIMARY KEY  (`account_flag_id`),
  KEY `account_id` (`account_id`),
  KEY `flag_id` (`flag_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `account_flag_detail_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_flag_detail_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `account_state_flag` (`flag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_flag_detail_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_flag_detail`
--

LOCK TABLES `account_flag_detail` WRITE;
/*!40000 ALTER TABLE `account_flag_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_flag_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_notes`
--

DROP TABLE IF EXISTS `account_notes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_notes` (
  `account_notes_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `note` varchar(500) NOT NULL,
  `comment_date` date NOT NULL,
  `officer_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`account_notes_id`),
  KEY `account_id` (`account_id`),
  KEY `officer_id` (`officer_id`),
  CONSTRAINT `account_notes_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_notes_ibfk_2` FOREIGN KEY (`officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_notes`
--

LOCK TABLES `account_notes` WRITE;
/*!40000 ALTER TABLE `account_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_payment`
--

DROP TABLE IF EXISTS `account_payment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_payment` (
  `payment_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `payment_type_id` smallint(6) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `amount` decimal(21,4) NOT NULL,
  `receipt_number` varchar(60) default NULL,
  `voucher_number` varchar(50) default NULL,
  `check_number` varchar(50) default NULL,
  `payment_date` date NOT NULL,
  `receipt_date` date default NULL,
  `bank_name` varchar(50) default NULL,
  `comment` varchar(80) default NULL,
  PRIMARY KEY  (`payment_id`),
  KEY `currency_id` (`currency_id`),
  KEY `payment_type_id` (`payment_type_id`),
  KEY `account_id_account_payment_idx` (`account_id`),
  CONSTRAINT `account_payment_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_payment_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_payment_ibfk_3` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_payment`
--

LOCK TABLES `account_payment` WRITE;
/*!40000 ALTER TABLE `account_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_state`
--

DROP TABLE IF EXISTS `account_state`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_state` (
  `account_state_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  `prd_type_id` smallint(6) NOT NULL,
  `currently_in_use` smallint(6) NOT NULL,
  `status_description` varchar(200) default NULL,
  PRIMARY KEY  (`account_state_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `account_state_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_state`
--

LOCK TABLES `account_state` WRITE;
/*!40000 ALTER TABLE `account_state` DISABLE KEYS */;
INSERT INTO `account_state` VALUES (1,17,1,1,'Partial application'),(2,18,1,1,'Application pending approval'),(3,19,1,1,'Application approved'),(4,20,1,0,'Disbursed to loan officer'),(5,21,1,1,'Active in good standing'),(6,22,1,1,'Closed - obligation met'),(7,23,1,1,'Closed - written off'),(8,24,1,1,'Closed - rescheduled'),(9,25,1,1,'Active in bad standing'),(10,141,1,1,'Canceled'),(11,142,1,1,'Customer Account Active'),(12,143,1,1,'Customer Account Inactive'),(13,181,2,1,'Partial application'),(14,182,2,1,'Application pending approval'),(15,183,2,1,'Canceled'),(16,184,2,1,'Active'),(17,185,2,1,'Closed'),(18,210,2,1,'Inactive');
/*!40000 ALTER TABLE `account_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_state_flag`
--

DROP TABLE IF EXISTS `account_state_flag`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_state_flag` (
  `flag_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  `status_id` smallint(6) NOT NULL,
  `flag_description` varchar(200) default NULL,
  `retain_flag` smallint(6) NOT NULL,
  PRIMARY KEY  (`flag_id`),
  KEY `status_id` (`status_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `account_state_flag_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_state_flag_ibfk_2` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_state_flag`
--

LOCK TABLES `account_state_flag` WRITE;
/*!40000 ALTER TABLE `account_state_flag` DISABLE KEYS */;
INSERT INTO `account_state_flag` VALUES (1,174,10,'Withdraw',0),(2,175,10,'Rejected',0),(3,176,10,'Other',0),(4,211,15,'Withdraw',0),(5,212,15,'Rejected',0),(6,213,15,'Blacklisted',1),(7,571,10,'Loan reversal',0);
/*!40000 ALTER TABLE `account_state_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_status_change_history`
--

DROP TABLE IF EXISTS `account_status_change_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_status_change_history` (
  `account_status_change_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `old_status` smallint(6) default NULL,
  `new_status` smallint(6) NOT NULL,
  `changed_by` smallint(6) NOT NULL,
  `changed_date` date NOT NULL,
  PRIMARY KEY  (`account_status_change_id`),
  KEY `account_id` (`account_id`),
  KEY `old_status` (`old_status`),
  KEY `new_status` (`new_status`),
  KEY `changed_by` (`changed_by`),
  CONSTRAINT `account_status_change_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_status_change_history_ibfk_2` FOREIGN KEY (`old_status`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_status_change_history_ibfk_3` FOREIGN KEY (`new_status`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_status_change_history_ibfk_4` FOREIGN KEY (`changed_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_status_change_history`
--

LOCK TABLES `account_status_change_history` WRITE;
/*!40000 ALTER TABLE `account_status_change_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_status_change_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_trxn`
--

DROP TABLE IF EXISTS `account_trxn`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_trxn` (
  `account_trxn_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `personnel_id` int(11) default NULL,
  `account_action_id` smallint(6) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `amount_currency_id` smallint(6) default NULL,
  `amount` decimal(21,4) NOT NULL,
  `due_date` date default NULL,
  `comments` varchar(200) default NULL,
  `action_date` date NOT NULL,
  `created_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `customer_id` int(11) default NULL,
  `installment_id` smallint(6) default NULL,
  `related_trxn_id` int(11) default NULL,
  PRIMARY KEY  (`account_trxn_id`),
  KEY `account_action_id` (`account_action_id`),
  KEY `payment_id` (`payment_id`),
  KEY `currency_id` (`currency_id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `customer_id` (`customer_id`),
  KEY `account_id_account_trxn_idx` (`account_id`),
  CONSTRAINT `account_trxn_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_trxn_ibfk_2` FOREIGN KEY (`account_action_id`) REFERENCES `account_action` (`account_action_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_trxn_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `account_payment` (`payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_trxn_ibfk_4` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_trxn_ibfk_5` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_trxn_ibfk_6` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_trxn`
--

LOCK TABLES `account_trxn` WRITE;
/*!40000 ALTER TABLE `account_trxn` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_trxn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_type`
--

DROP TABLE IF EXISTS `account_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `account_type` (
  `account_type_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`account_type_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `account_type_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `account_type`
--

LOCK TABLES `account_type` WRITE;
/*!40000 ALTER TABLE `account_type` DISABLE KEYS */;
INSERT INTO `account_type` VALUES (1,126,'Loan Account'),(2,127,'Savings Account'),(3,140,'Customer Account'),(4,126,'Individual Loan Account');
/*!40000 ALTER TABLE `account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `activity` (
  `activity_id` smallint(6) NOT NULL auto_increment,
  `parent_id` smallint(6) default NULL,
  `activity_name_lookup_id` int(11) NOT NULL,
  `description_lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`activity_id`),
  KEY `parent_id` (`parent_id`),
  KEY `activity_name_lookup_id` (`activity_name_lookup_id`),
  KEY `description_lookup_id` (`description_lookup_id`),
  CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`activity_name_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `activity_ibfk_3` FOREIGN KEY (`description_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (1,NULL,371,371),(2,1,372,372),(3,2,373,373),(4,2,374,374),(5,1,375,375),(6,5,376,376),(7,5,377,377),(8,1,378,378),(9,8,379,379),(10,8,380,380),(13,NULL,381,381),(14,13,382,382),(15,14,383,383),(16,14,384,384),(17,NULL,385,385),(18,17,386,386),(19,18,387,387),(20,18,388,388),(21,18,389,389),(22,17,390,390),(23,22,391,391),(24,22,392,392),(25,22,393,393),(33,NULL,394,394),(34,33,395,395),(35,34,396,396),(36,34,397,397),(37,34,398,398),(38,34,399,399),(39,34,400,400),(40,34,401,401),(41,34,402,402),(42,34,403,403),(43,34,404,404),(44,34,405,405),(46,34,407,407),(47,34,408,408),(48,34,409,409),(49,34,410,410),(50,34,411,411),(51,34,412,412),(52,34,413,413),(53,34,414,414),(54,34,415,415),(55,34,416,416),(56,33,417,417),(57,56,418,418),(58,56,419,419),(59,56,420,420),(60,56,421,421),(61,56,422,422),(62,56,423,423),(63,56,424,424),(64,56,425,425),(65,56,426,426),(66,56,427,427),(68,56,429,429),(69,56,430,430),(70,56,431,431),(71,56,432,432),(72,56,433,433),(73,56,434,434),(74,56,435,435),(75,56,436,436),(76,56,437,437),(77,56,438,438),(78,33,439,439),(79,78,440,440),(80,78,441,441),(81,78,442,442),(82,78,443,443),(83,78,444,444),(85,78,446,446),(86,78,447,447),(87,78,448,438),(88,78,449,449),(89,NULL,450,450),(90,89,451,451),(91,90,452,452),(92,90,453,453),(93,89,454,454),(94,93,455,455),(95,93,456,456),(96,89,457,457),(97,96,458,458),(98,96,459,459),(99,NULL,460,460),(100,99,461,461),(101,100,462,462),(102,100,463,463),(103,100,464,464),(104,100,465,465),(105,100,466,466),(106,100,467,467),(108,100,469,469),(109,100,470,470),(110,100,471,471),(113,99,474,474),(115,113,475,475),(116,113,476,476),(118,113,478,478),(119,113,479,479),(120,113,480,480),(121,34,481,481),(122,56,482,482),(126,34,483,483),(127,78,484,484),(128,78,485,485),(129,100,486,486),(131,113,487,487),(135,18,488,488),(136,NULL,489,489),(137,136,490,490),(138,136,491,491),(139,136,492,492),(140,136,493,493),(141,NULL,494,494),(145,141,498,498),(146,141,499,499),(147,141,500,500),(148,141,501,501),(149,141,502,502),(150,141,503,503),(151,141,504,504),(178,113,531,531),(179,100,532,532),(180,136,533,533),(181,136,534,534),(182,136,535,535),(183,136,536,536),(184,136,537,537),(185,136,538,538),(186,136,546,546),(187,136,551,551),(188,136,552,552),(189,113,553,553),(190,136,554,554),(191,136,555,555),(192,196,560,560),(193,13,562,562),(194,18,563,563),(195,90,561,561),(196,NULL,564,564),(197,196,565,565),(198,34,566,566),(199,56,567,567),(200,78,568,568),(201,196,569,569),(202,99,570,570),(203,NULL,574,574),(204,203,575,575),(205,203,579,579),(206,34,580,580),(208,34,582,582),(209,89,583,583),(210,209,584,584),(211,209,585,585),(213,203,587,587),(214,141,588,588),(215,141,589,589),(216,141,590,590),(217,113,591,591),(218,99,592,592),(219,1,593,593),(220,141,594,594),(221,141,595,595),(222,141,596,596),(223,141,597,597),(224,203,598,598),(225,141,602,602),(226,141,603,603),(227,NULL,605,605),(228,227,606,606),(229,145,607,607),(230,203,608,608),(231,150,611,611),(232,150,612,612),(233,196,619,619),(234,227,625,625),(235,1,627,627),(236,150,628,628),(237,150,629,629),(238,227,659,659),(239,227,660,660),(240,203,661,661),(241,227,662,662),(242,227,663,663),(243,203,664,664),(244,113,666,666),(245,34,667,667),(246,196,668,668);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_document`
--

DROP TABLE IF EXISTS `admin_document`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `admin_document` (
  `admin_document_id` int(11) NOT NULL auto_increment,
  `admin_document_name` varchar(200) default NULL,
  `admin_document_identifier` varchar(100) default NULL,
  `admin_document_active` smallint(6) default NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`admin_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `admin_document`
--

LOCK TABLES `admin_document` WRITE;
/*!40000 ALTER TABLE `admin_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_document_acc_state_mix`
--

DROP TABLE IF EXISTS `admin_document_acc_state_mix`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `admin_document_acc_state_mix` (
  `admin_doc_acc_state_mix_id` int(11) NOT NULL auto_increment,
  `account_state_id` smallint(6) NOT NULL,
  `admin_document_id` int(11) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`admin_doc_acc_state_mix_id`),
  KEY `admin_document_acc_state_mix_fk` (`account_state_id`),
  KEY `admin_document_acc_state_mix_fk1` (`admin_document_id`),
  CONSTRAINT `admin_document_acc_state_mix_fk` FOREIGN KEY (`account_state_id`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `admin_document_acc_state_mix_fk1` FOREIGN KEY (`admin_document_id`) REFERENCES `admin_document` (`admin_document_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `admin_document_acc_state_mix`
--

LOCK TABLES `admin_document_acc_state_mix` WRITE;
/*!40000 ALTER TABLE `admin_document_acc_state_mix` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_document_acc_state_mix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applied_upgrades`
--

DROP TABLE IF EXISTS `applied_upgrades`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `applied_upgrades` (
  `upgrade_id` int(11) NOT NULL,
  PRIMARY KEY  (`upgrade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `applied_upgrades`
--

LOCK TABLES `applied_upgrades` WRITE;
/*!40000 ALTER TABLE `applied_upgrades` DISABLE KEYS */;
INSERT INTO `applied_upgrades` VALUES (1277565300),(1277565388),(1277565389),(1277567194),(1277567768),(1277567885),(1277567949),(1277568944),(1277569001),(1277571296),(1277571560),(1277571792),(1277571837),(1277586926),(1277587117),(1277587199),(1277587465),(1277587818),(1277587878),(1277587947),(1277588038),(1277588072),(1277588240),(1277588373),(1277588885),(1277588973),(1277589055),(1277589236),(1277589321),(1277589383),(1278540763),(1278540832),(1278542100),(1278542119),(1278542138),(1278542152),(1278542171),(1279140399),(1279272090),(1280719328),(1280719447),(1280719676),(1280721170),(1280793109),(1282247229),(1282389745),(1282814250),(1283237728),(1283320210),(1283416834),(1283765911),(1284365506),(1284977483),(1284986654),(1285046834),(1285177663),(1285651956),(1285812348),(1286195484),(1286529235),(1286780611),(1287934290),(1288013750),(1288349766),(1288869198),(1289125815),(1289541994),(1289994929),(1290720085),(1291245955),(1292234934),(1292241366),(1294738016),(1294927843),(1295985566),(1296137314),(1298198335),(1299279218);
/*!40000 ALTER TABLE `applied_upgrades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `attendance` (
  `meeting_id` int(11) NOT NULL,
  `meeting_date` date NOT NULL,
  `attendance` smallint(6) default NULL,
  `notes` varchar(200) NOT NULL,
  PRIMARY KEY  (`meeting_id`,`meeting_date`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`meeting_id`) REFERENCES `customer_meeting` (`customer_meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_branch_cash_confirmation_report`
--

DROP TABLE IF EXISTS `batch_branch_cash_confirmation_report`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_branch_cash_confirmation_report` (
  `branch_cash_confirmation_report_id` int(11) NOT NULL auto_increment,
  `branch_id` smallint(6) NOT NULL,
  `run_date` date NOT NULL,
  PRIMARY KEY  (`branch_cash_confirmation_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_branch_cash_confirmation_report`
--

LOCK TABLES `batch_branch_cash_confirmation_report` WRITE;
/*!40000 ALTER TABLE `batch_branch_cash_confirmation_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_branch_cash_confirmation_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_branch_confirmation_disbursement`
--

DROP TABLE IF EXISTS `batch_branch_confirmation_disbursement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_branch_confirmation_disbursement` (
  `id` int(11) NOT NULL auto_increment,
  `branch_cash_confirmation_report_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `actual` decimal(21,4) NOT NULL,
  `actual_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `branch_cash_confirmation_report_id` (`branch_cash_confirmation_report_id`),
  CONSTRAINT `batch_branch_confirmation_disbursement_ibfk_1` FOREIGN KEY (`branch_cash_confirmation_report_id`) REFERENCES `batch_branch_cash_confirmation_report` (`branch_cash_confirmation_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_branch_confirmation_disbursement`
--

LOCK TABLES `batch_branch_confirmation_disbursement` WRITE;
/*!40000 ALTER TABLE `batch_branch_confirmation_disbursement` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_branch_confirmation_disbursement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_branch_confirmation_issue`
--

DROP TABLE IF EXISTS `batch_branch_confirmation_issue`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_branch_confirmation_issue` (
  `id` int(11) NOT NULL auto_increment,
  `branch_cash_confirmation_report_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `actual` decimal(21,4) NOT NULL,
  `actual_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `branch_cash_confirmation_report_id` (`branch_cash_confirmation_report_id`),
  CONSTRAINT `batch_branch_confirmation_issue_ibfk_1` FOREIGN KEY (`branch_cash_confirmation_report_id`) REFERENCES `batch_branch_cash_confirmation_report` (`branch_cash_confirmation_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_branch_confirmation_issue`
--

LOCK TABLES `batch_branch_confirmation_issue` WRITE;
/*!40000 ALTER TABLE `batch_branch_confirmation_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_branch_confirmation_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_branch_confirmation_recovery`
--

DROP TABLE IF EXISTS `batch_branch_confirmation_recovery`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_branch_confirmation_recovery` (
  `recovery_id` int(11) NOT NULL auto_increment,
  `branch_cash_confirmation_report_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `due` decimal(21,4) NOT NULL,
  `due_currency_id` smallint(6) NOT NULL,
  `actual` decimal(21,4) NOT NULL,
  `actual_currency_id` smallint(6) NOT NULL,
  `arrears` decimal(21,4) NOT NULL,
  `arrears_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`recovery_id`),
  KEY `branch_cash_confirmation_report_id` (`branch_cash_confirmation_report_id`),
  CONSTRAINT `batch_branch_confirmation_recovery_ibfk_1` FOREIGN KEY (`branch_cash_confirmation_report_id`) REFERENCES `batch_branch_cash_confirmation_report` (`branch_cash_confirmation_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_branch_confirmation_recovery`
--

LOCK TABLES `batch_branch_confirmation_recovery` WRITE;
/*!40000 ALTER TABLE `batch_branch_confirmation_recovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_branch_confirmation_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_branch_report`
--

DROP TABLE IF EXISTS `batch_branch_report`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_branch_report` (
  `branch_report_id` int(11) NOT NULL auto_increment,
  `branch_id` smallint(6) NOT NULL,
  `run_date` date NOT NULL,
  PRIMARY KEY  (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_branch_report`
--

LOCK TABLES `batch_branch_report` WRITE;
/*!40000 ALTER TABLE `batch_branch_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_branch_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_client_summary`
--

DROP TABLE IF EXISTS `batch_client_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_client_summary` (
  `client_summary_id` int(11) NOT NULL auto_increment,
  `branch_report_id` int(11) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `total` varchar(50) default NULL,
  `vpoor_total` varchar(50) default NULL,
  PRIMARY KEY  (`client_summary_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_client_summary_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_client_summary`
--

LOCK TABLES `batch_client_summary` WRITE;
/*!40000 ALTER TABLE `batch_client_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_client_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution`
--

DROP TABLE IF EXISTS `batch_job_execution`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_execution` (
  `job_execution_id` bigint(20) NOT NULL,
  `version` bigint(20) default NULL,
  `job_instance_id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `start_time` datetime default NULL,
  `end_time` datetime default NULL,
  `status` varchar(10) default NULL,
  `exit_code` varchar(20) default NULL,
  `exit_message` varchar(2500) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`job_execution_id`),
  KEY `job_inst_exec_fk` (`job_instance_id`),
  CONSTRAINT `job_inst_exec_fk` FOREIGN KEY (`job_instance_id`) REFERENCES `batch_job_instance` (`job_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_execution`
--

LOCK TABLES `batch_job_execution` WRITE;
/*!40000 ALTER TABLE `batch_job_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_context`
--

DROP TABLE IF EXISTS `batch_job_execution_context`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_execution_context` (
  `job_execution_id` bigint(20) NOT NULL,
  `short_context` varchar(2500) NOT NULL,
  `serialized_context` text,
  PRIMARY KEY  (`job_execution_id`),
  CONSTRAINT `job_exec_ctx_fk` FOREIGN KEY (`job_execution_id`) REFERENCES `batch_job_execution` (`job_execution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_execution_context`
--

LOCK TABLES `batch_job_execution_context` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_execution_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_seq`
--

DROP TABLE IF EXISTS `batch_job_execution_seq`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_execution_seq` (
  `id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_execution_seq`
--

LOCK TABLES `batch_job_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_job_execution_seq` VALUES (0);
/*!40000 ALTER TABLE `batch_job_execution_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_instance`
--

DROP TABLE IF EXISTS `batch_job_instance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_instance` (
  `job_instance_id` bigint(20) NOT NULL,
  `version` bigint(20) default NULL,
  `job_name` varchar(100) NOT NULL,
  `job_key` varchar(32) NOT NULL,
  PRIMARY KEY  (`job_instance_id`),
  UNIQUE KEY `job_inst_un` (`job_name`,`job_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_instance`
--

LOCK TABLES `batch_job_instance` WRITE;
/*!40000 ALTER TABLE `batch_job_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_params`
--

DROP TABLE IF EXISTS `batch_job_params`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_params` (
  `job_instance_id` bigint(20) NOT NULL,
  `type_cd` varchar(6) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `string_val` varchar(250) default NULL,
  `date_val` datetime default NULL,
  `long_val` bigint(20) default NULL,
  `double_val` double default NULL,
  KEY `job_inst_params_fk` (`job_instance_id`),
  CONSTRAINT `job_inst_params_fk` FOREIGN KEY (`job_instance_id`) REFERENCES `batch_job_instance` (`job_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_params`
--

LOCK TABLES `batch_job_params` WRITE;
/*!40000 ALTER TABLE `batch_job_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_seq`
--

DROP TABLE IF EXISTS `batch_job_seq`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_job_seq` (
  `id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_job_seq`
--

LOCK TABLES `batch_job_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_seq` DISABLE KEYS */;
INSERT INTO `batch_job_seq` VALUES (0);
/*!40000 ALTER TABLE `batch_job_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_loan_arrears_aging`
--

DROP TABLE IF EXISTS `batch_loan_arrears_aging`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_loan_arrears_aging` (
  `loan_arrears_aging_id` int(11) NOT NULL auto_increment,
  `aging_period_id` int(11) NOT NULL,
  `branch_report_id` int(11) NOT NULL,
  `clients_aging` int(11) NOT NULL,
  `loans_aging` int(11) NOT NULL,
  `amount_aging` decimal(21,4) NOT NULL,
  `amount_aging_currency_id` smallint(6) NOT NULL,
  `amount_outstanding_aging` decimal(21,4) NOT NULL,
  `amount_outstanding_aging_currency_id` smallint(6) NOT NULL,
  `interest_aging` decimal(21,4) NOT NULL,
  `interest_aging_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`loan_arrears_aging_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_loan_arrears_aging_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_loan_arrears_aging`
--

LOCK TABLES `batch_loan_arrears_aging` WRITE;
/*!40000 ALTER TABLE `batch_loan_arrears_aging` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_loan_arrears_aging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_loan_arrears_profile`
--

DROP TABLE IF EXISTS `batch_loan_arrears_profile`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_loan_arrears_profile` (
  `loan_arrears_profile_id` int(11) NOT NULL auto_increment,
  `branch_report_id` int(11) NOT NULL,
  `loans_in_arrears` int(11) NOT NULL,
  `clients_in_arrears` int(11) NOT NULL,
  `overdue_balance` decimal(21,4) NOT NULL,
  `overdue_balance_currency_id` smallint(6) NOT NULL,
  `unpaid_balance` decimal(21,4) NOT NULL,
  `unpaid_balance_currency_id` smallint(6) NOT NULL,
  `loans_at_risk` int(11) NOT NULL,
  `outstanding_amount_at_risk` decimal(21,4) NOT NULL,
  `outstanding_amount_at_risk_currency_id` smallint(6) NOT NULL,
  `overdue_amount_at_risk` decimal(21,4) NOT NULL,
  `overdue_amount_at_risk_currency_id` smallint(6) NOT NULL,
  `clients_at_risk` int(11) NOT NULL,
  PRIMARY KEY  (`loan_arrears_profile_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_loan_arrears_profile_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_loan_arrears_profile`
--

LOCK TABLES `batch_loan_arrears_profile` WRITE;
/*!40000 ALTER TABLE `batch_loan_arrears_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_loan_arrears_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_loan_details`
--

DROP TABLE IF EXISTS `batch_loan_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_loan_details` (
  `loan_details_id` int(11) NOT NULL auto_increment,
  `branch_report_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `number_of_loans_issued` int(11) NOT NULL,
  `loan_amount_issued` decimal(21,4) NOT NULL,
  `loan_amount_issued_currency_id` smallint(6) NOT NULL,
  `loan_interest_issued` decimal(21,4) NOT NULL,
  `loan_interest_issued_currency_id` smallint(6) NOT NULL,
  `number_of_loans_outstanding` int(11) NOT NULL,
  `loan_outstanding_amount` decimal(21,4) NOT NULL,
  `loan_outstanding_amount_currency_id` smallint(6) NOT NULL,
  `loan_outstanding_interest` decimal(21,4) NOT NULL,
  `loan_outstanding_interest_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`loan_details_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_loan_details_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_loan_details`
--

LOCK TABLES `batch_loan_details` WRITE;
/*!40000 ALTER TABLE `batch_loan_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_loan_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_staff_summary`
--

DROP TABLE IF EXISTS `batch_staff_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_staff_summary` (
  `staff_summary_id` int(11) NOT NULL auto_increment,
  `branch_report_id` int(11) NOT NULL,
  `personnel_id` smallint(6) NOT NULL,
  `personnel_name` varchar(50) NOT NULL,
  `joining_date` date default NULL,
  `active_borrowers` int(11) NOT NULL,
  `active_loans` int(11) NOT NULL,
  `center_count` int(11) NOT NULL,
  `client_count` int(11) NOT NULL,
  `loan_amount_outstanding` decimal(21,4) NOT NULL,
  `loan_amount_outstanding_currency_id` smallint(6) NOT NULL,
  `interest_fees_outstanding` decimal(21,4) NOT NULL,
  `interest_fees_outstanding_currency_id` smallint(6) NOT NULL,
  `portfolio_at_risk` decimal(21,4) NOT NULL,
  `total_clients_enrolled` int(11) NOT NULL,
  `clients_enrolled_this_month` int(11) NOT NULL,
  `loan_arrears_amount` decimal(21,4) NOT NULL,
  `loan_arrears_amount_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`staff_summary_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_staff_summary_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_staff_summary`
--

LOCK TABLES `batch_staff_summary` WRITE;
/*!40000 ALTER TABLE `batch_staff_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_staff_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_staffing_level_summary`
--

DROP TABLE IF EXISTS `batch_staffing_level_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_staffing_level_summary` (
  `staffing_level_summary_id` int(11) NOT NULL auto_increment,
  `branch_report_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `personnel_count` int(11) NOT NULL,
  PRIMARY KEY  (`staffing_level_summary_id`),
  KEY `branch_report_id` (`branch_report_id`),
  CONSTRAINT `batch_staffing_level_summary_ibfk_1` FOREIGN KEY (`branch_report_id`) REFERENCES `batch_branch_report` (`branch_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_staffing_level_summary`
--

LOCK TABLES `batch_staffing_level_summary` WRITE;
/*!40000 ALTER TABLE `batch_staffing_level_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_staffing_level_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution`
--

DROP TABLE IF EXISTS `batch_step_execution`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_step_execution` (
  `step_execution_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `step_name` varchar(100) NOT NULL,
  `job_execution_id` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime default NULL,
  `status` varchar(10) default NULL,
  `commit_count` bigint(20) default NULL,
  `read_count` bigint(20) default NULL,
  `filter_count` bigint(20) default NULL,
  `write_count` bigint(20) default NULL,
  `read_skip_count` bigint(20) default NULL,
  `write_skip_count` bigint(20) default NULL,
  `process_skip_count` bigint(20) default NULL,
  `rollback_count` bigint(20) default NULL,
  `exit_code` varchar(20) default NULL,
  `exit_message` varchar(2500) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`step_execution_id`),
  KEY `job_exec_step_fk` (`job_execution_id`),
  CONSTRAINT `job_exec_step_fk` FOREIGN KEY (`job_execution_id`) REFERENCES `batch_job_execution` (`job_execution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_step_execution`
--

LOCK TABLES `batch_step_execution` WRITE;
/*!40000 ALTER TABLE `batch_step_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_step_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution_context`
--

DROP TABLE IF EXISTS `batch_step_execution_context`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_step_execution_context` (
  `step_execution_id` bigint(20) NOT NULL,
  `short_context` varchar(2500) NOT NULL,
  `serialized_context` text,
  PRIMARY KEY  (`step_execution_id`),
  CONSTRAINT `step_exec_ctx_fk` FOREIGN KEY (`step_execution_id`) REFERENCES `batch_step_execution` (`step_execution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_step_execution_context`
--

LOCK TABLES `batch_step_execution_context` WRITE;
/*!40000 ALTER TABLE `batch_step_execution_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_step_execution_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution_seq`
--

DROP TABLE IF EXISTS `batch_step_execution_seq`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `batch_step_execution_seq` (
  `id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `batch_step_execution_seq`
--

LOCK TABLES `batch_step_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_step_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_step_execution_seq` VALUES (0);
/*!40000 ALTER TABLE `batch_step_execution_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_ho_update`
--

DROP TABLE IF EXISTS `branch_ho_update`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `branch_ho_update` (
  `office_id` smallint(6) NOT NULL,
  `last_updated_date` date default NULL,
  PRIMARY KEY  (`office_id`),
  CONSTRAINT `branch_ho_update_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `branch_ho_update`
--

LOCK TABLES `branch_ho_update` WRITE;
/*!40000 ALTER TABLE `branch_ho_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_ho_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calculated_interest_on_payment`
--

DROP TABLE IF EXISTS `calculated_interest_on_payment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `calculated_interest_on_payment` (
  `loan_account_trxn_id` int(11) NOT NULL,
  `original_interest` decimal(21,4) NOT NULL,
  `original_interest_currency_id` smallint(6) default NULL,
  `extra_interest_paid` decimal(21,4) default NULL,
  `extra_interest_paid_currency_id` smallint(6) default NULL,
  `interest_due_till_paid` decimal(21,4) default NULL,
  `interest_due_till_paid_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`loan_account_trxn_id`),
  KEY `original_interest_currency_id` (`original_interest_currency_id`),
  KEY `extra_interest_paid_currency_id` (`extra_interest_paid_currency_id`),
  KEY `interest_due_till_paid_currency_id` (`interest_due_till_paid_currency_id`),
  CONSTRAINT `calculated_interest_on_payment_ibfk_4` FOREIGN KEY (`interest_due_till_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `calculated_interest_on_payment_ibfk_1` FOREIGN KEY (`loan_account_trxn_id`) REFERENCES `loan_trxn_detail` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `calculated_interest_on_payment_ibfk_2` FOREIGN KEY (`original_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `calculated_interest_on_payment_ibfk_3` FOREIGN KEY (`extra_interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `calculated_interest_on_payment`
--

LOCK TABLES `calculated_interest_on_payment` WRITE;
/*!40000 ALTER TABLE `calculated_interest_on_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `calculated_interest_on_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_flow`
--

DROP TABLE IF EXISTS `cash_flow`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cash_flow` (
  `id` int(11) NOT NULL auto_increment,
  `capital` decimal(21,4) default NULL,
  `liability` decimal(21,4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cash_flow`
--

LOCK TABLES `cash_flow` WRITE;
/*!40000 ALTER TABLE `cash_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_flow_detail`
--

DROP TABLE IF EXISTS `cash_flow_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cash_flow_detail` (
  `id` smallint(6) NOT NULL auto_increment,
  `cash_flow_threshold` decimal(13,10) default NULL,
  `indebtedness_ratio` decimal(13,10) default NULL,
  `repayment_capacity` decimal(13,10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cash_flow_detail`
--

LOCK TABLES `cash_flow_detail` WRITE;
/*!40000 ALTER TABLE `cash_flow_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_flow_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_type`
--

DROP TABLE IF EXISTS `category_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `category_type` (
  `category_id` smallint(6) NOT NULL,
  `category_lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`category_id`),
  KEY `category_lookup_id` (`category_lookup_id`),
  CONSTRAINT `category_type_ibfk_1` FOREIGN KEY (`category_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `category_type`
--

LOCK TABLES `category_type` WRITE;
/*!40000 ALTER TABLE `category_type` DISABLE KEYS */;
INSERT INTO `category_type` VALUES (1,81),(2,82),(3,83),(4,84),(5,86);
/*!40000 ALTER TABLE `category_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_log`
--

DROP TABLE IF EXISTS `change_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `change_log` (
  `change_log_id` int(11) NOT NULL auto_increment,
  `changed_by` smallint(6) NOT NULL,
  `modifier_name` varchar(50) NOT NULL,
  `entity_id` int(11) default NULL,
  `entity_type` smallint(6) default NULL,
  `changed_date` date default NULL,
  `fields_changed` varchar(250) default NULL,
  PRIMARY KEY  (`change_log_id`),
  KEY `changed_by` (`changed_by`),
  KEY `change_log_idx` (`entity_type`,`entity_id`,`changed_date`),
  CONSTRAINT `change_log_ibfk_1` FOREIGN KEY (`changed_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `change_log`
--

LOCK TABLES `change_log` WRITE;
/*!40000 ALTER TABLE `change_log` DISABLE KEYS */;
INSERT INTO `change_log` VALUES (1,1,'mifos',2,17,'2011-03-22',NULL),(2,1,'mifos',3,17,'2011-03-22',NULL),(3,1,'mifos',4,17,'2011-03-22',NULL),(4,1,'mifos',5,17,'2011-03-22',NULL),(5,1,'mifos',5,17,'2011-03-23',NULL),(6,1,'mifos',2,17,'2011-03-23',NULL),(7,1,'mifos',3,17,'2011-03-23',NULL),(8,1,'mifos',4,17,'2011-03-24',NULL),(9,1,'mifos',1,2,'2011-03-16',NULL),(10,1,'mifos',3,17,'2011-03-31',NULL),(11,1,'mifos',2,17,'2011-03-31',NULL),(12,1,'mifos',4,2,'2011-04-19',NULL);
/*!40000 ALTER TABLE `change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_log_detail`
--

DROP TABLE IF EXISTS `change_log_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `change_log_detail` (
  `sequence_num` int(11) NOT NULL auto_increment,
  `change_log_id` int(11) NOT NULL,
  `field_name` varchar(100) default NULL,
  `old_value` varchar(200) default NULL,
  `new_value` varchar(200) default NULL,
  PRIMARY KEY  (`sequence_num`),
  KEY `change_log_id` (`change_log_id`),
  CONSTRAINT `change_log_detail_ibfk_1` FOREIGN KEY (`change_log_id`) REFERENCES `change_log` (`change_log_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `change_log_detail`
--

LOCK TABLES `change_log_detail` WRITE;
/*!40000 ALTER TABLE `change_log_detail` DISABLE KEYS */;
INSERT INTO `change_log_detail` VALUES (1,1,'Name','Loanofficer1 Loanofficer1','Loanofficerone Loanofficerone'),(2,2,'Name','Loanofficer2 Loanofficer2','Loanofficertwo Loanofficertwo'),(3,3,'Name','Loanofficer3 Loanofficer3','Loanofficerthree Loanofficerthree'),(4,4,'Name','Loanofficer4 Loanofficer4','Loanofficerfour Loanofficerfour'),(5,5,'Office','BranchOffice4','BranchOfficeTen'),(6,5,'dateOfJoiningBranch','21/03/2011','23/03/2011'),(7,6,'dateOfJoiningBranch','21/03/2011','23/03/2011'),(8,6,'Office','BranchOfficeone','BranchOfficeTen'),(9,7,'dateOfJoiningBranch','21/03/2011','23/03/2011'),(10,7,'Office','BranchOfficetwo','BranchOfficeTen'),(11,8,'Office','BranchOfficethree','BranchOfficeTen'),(12,8,'dateOfJoiningBranch','21/03/2011','24/03/2011'),(13,9,'Max Interest Rate','20.0','50.0'),(14,9,'Min Interest Rate','10.0','0.0'),(15,10,'dateOfJoiningBranch','23/03/2011','31/03/2011'),(16,10,'Office','BranchOfficeTen','BranchOfficeone'),(17,11,'dateOfJoiningBranch','23/03/2011','31/03/2011'),(18,11,'Office','BranchOfficeTen','BranchOfficeone'),(19,12,'Frequency Of Installments','Week(s)','Month(s)');
/*!40000 ALTER TABLE `change_log_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `checklist` (
  `checklist_id` smallint(6) NOT NULL auto_increment,
  `checklist_name` varchar(100) default NULL,
  `checklist_status` smallint(6) NOT NULL default '1',
  `locale_id` smallint(6) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`checklist_id`),
  KEY `locale_id` (`locale_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `checklist_ibfk_1` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `checklist_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `checklist_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist_detail`
--

DROP TABLE IF EXISTS `checklist_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `checklist_detail` (
  `detail_id` int(11) NOT NULL auto_increment,
  `checklist_id` smallint(6) default NULL,
  `locale_id` smallint(6) default NULL,
  `detail_text` varchar(250) default NULL,
  `answer_type` smallint(6) NOT NULL,
  PRIMARY KEY  (`detail_id`),
  KEY `locale_id` (`locale_id`),
  KEY `chk_detail_idx` (`checklist_id`,`locale_id`),
  CONSTRAINT `checklist_detail_ibfk_1` FOREIGN KEY (`checklist_id`) REFERENCES `checklist` (`checklist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `checklist_detail_ibfk_2` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `checklist_detail`
--

LOCK TABLES `checklist_detail` WRITE;
/*!40000 ALTER TABLE `checklist_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_initial_savings_offering`
--

DROP TABLE IF EXISTS `client_initial_savings_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `client_initial_savings_offering` (
  `client_offering_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `prd_offering_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`client_offering_id`),
  KEY `customer_id` (`customer_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `client_initial_savings_offering_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `client_initial_savings_offering_ibfk_2` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `client_initial_savings_offering`
--

LOCK TABLES `client_initial_savings_offering` WRITE;
/*!40000 ALTER TABLE `client_initial_savings_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_initial_savings_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_perf_history`
--

DROP TABLE IF EXISTS `client_perf_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `client_perf_history` (
  `id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `last_loan_amnt` decimal(21,4) default NULL,
  `last_loan_amnt_currency_id` smallint(6) default NULL,
  `total_active_loans` smallint(6) default NULL,
  `total_savings_amnt` decimal(21,4) default NULL,
  `total_savings_amnt_currency_id` smallint(6) default NULL,
  `delinquint_portfolio` decimal(21,4) default NULL,
  `delinquint_portfolio_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `client_perf_history_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `client_perf_history`
--

LOCK TABLES `client_perf_history` WRITE;
/*!40000 ALTER TABLE `client_perf_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_perf_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coa`
--

DROP TABLE IF EXISTS `coa`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `coa` (
  `coa_id` smallint(6) NOT NULL auto_increment,
  `coa_name` varchar(150) NOT NULL,
  `glcode_id` smallint(6) NOT NULL,
  `category_type` varchar(20) default NULL,
  PRIMARY KEY  (`coa_id`),
  KEY `glcode_id` (`glcode_id`),
  CONSTRAINT `coa_ibfk_1` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `coa`
--

LOCK TABLES `coa` WRITE;
/*!40000 ALTER TABLE `coa` DISABLE KEYS */;
INSERT INTO `coa` VALUES (1,'ASSETS',1,'ASSET'),(2,'Petty Cash Fund',2,NULL),(3,'Cash-in-Bank',3,NULL),(4,'Depository Bank',4,NULL),(5,'Branches',5,NULL),(6,'Loans Receivable',6,NULL),(7,'Client Loans',7,NULL),(8,'Loan Loss Reserve',8,NULL),(9,'Interest Receivables',9,NULL),(10,'LIABILITIES',10,'LIABILITY'),(11,'CBU Payable',11,NULL),(12,'Client\'s CBU',12,NULL),(13,'Voluntary Savings',13,NULL),(14,'INCOME',14,'INCOME'),(15,'Direct Income',15,NULL),(16,'Loan Fees',16,NULL),(17,'Processing Fees',17,NULL),(18,'Service Fees',18,NULL),(19,'Passbook Fees',19,NULL),(20,'Penalties',20,NULL),(21,'Miscellaneous Penalties',21,NULL),(22,'Miscellaneous Income',22,NULL),(23,'Microinsurance Fees',23,NULL),(24,'Microinsurance Premium Payable',24,NULL),(25,'FEES',25,NULL),(26,'EXPENDITURE',26,'EXPENDITURE'),(27,'Financial Cost',27,NULL),(28,'Interest on Client\'s CBU',28,NULL),(29,'Interest on Voluntary Savings',29,NULL);
/*!40000 ALTER TABLE `coa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coa_idmapper`
--

DROP TABLE IF EXISTS `coa_idmapper`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `coa_idmapper` (
  `constant_id` smallint(6) NOT NULL,
  `coa_id` smallint(6) NOT NULL,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`constant_id`),
  KEY `coa_id` (`coa_id`),
  CONSTRAINT `coa_idmapper_ibfk_1` FOREIGN KEY (`coa_id`) REFERENCES `coa` (`coa_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `coa_idmapper`
--

LOCK TABLES `coa_idmapper` WRITE;
/*!40000 ALTER TABLE `coa_idmapper` DISABLE KEYS */;
/*!40000 ALTER TABLE `coa_idmapper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coahierarchy`
--

DROP TABLE IF EXISTS `coahierarchy`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `coahierarchy` (
  `coa_id` smallint(6) NOT NULL,
  `parent_coaid` smallint(6) default NULL,
  KEY `coa_id` (`coa_id`),
  KEY `parent_coaid` (`parent_coaid`),
  CONSTRAINT `coahierarchy_ibfk_1` FOREIGN KEY (`coa_id`) REFERENCES `coa` (`coa_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `coahierarchy_ibfk_2` FOREIGN KEY (`parent_coaid`) REFERENCES `coa` (`coa_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `coahierarchy`
--

LOCK TABLES `coahierarchy` WRITE;
/*!40000 ALTER TABLE `coahierarchy` DISABLE KEYS */;
INSERT INTO `coahierarchy` VALUES (1,NULL),(2,1),(3,1),(4,3),(5,4),(6,1),(7,6),(8,6),(9,6),(10,NULL),(11,10),(12,11),(13,11),(14,NULL),(15,14),(16,15),(17,15),(18,15),(19,15),(20,15),(21,15),(22,15),(23,15),(24,15),(25,14),(26,NULL),(27,26),(28,27),(29,27);
/*!40000 ALTER TABLE `coahierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_key_value_integer`
--

DROP TABLE IF EXISTS `config_key_value_integer`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config_key_value_integer` (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_key` varchar(100) NOT NULL,
  `configuration_value` int(11) NOT NULL,
  PRIMARY KEY  (`configuration_id`),
  UNIQUE KEY `configuration_key` (`configuration_key`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `config_key_value_integer`
--

LOCK TABLES `config_key_value_integer` WRITE;
/*!40000 ALTER TABLE `config_key_value_integer` DISABLE KEYS */;
INSERT INTO `config_key_value_integer` VALUES (1,'x',0),(2,' ',0),(3,'jasperReportIsHidden',1),(4,'loanIndividualMonitoringIsEnabled',0),(5,'repaymentSchedulesIndependentOfMeetingIsEnabled',0),(6,'CenterHierarchyExists',1),(7,'ClientCanExistOutsideGroup',1),(8,'GroupCanApplyLoans',1),(9,'minDaysBetweenDisbursalAndFirstRepaymentDay',1),(10,'maxDaysBetweenDisbursalAndFirstRepaymentDay',365),(11,'AdministrativeDocumentsIsEnabled',1),(12,'Recurring fees cleanup done for MIFOS-3712',1);
/*!40000 ALTER TABLE `config_key_value_integer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `country` (
  `country_id` smallint(6) NOT NULL,
  `country_name` varchar(100) default NULL,
  `country_short_name` varchar(10) default NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'America','US'),(2,'India','IN'),(3,'Spain','ES'),(4,'England','ENG'),(5,'South Africa','SA'),(6,'United Kingdom','GB'),(7,'Iceland','IS'),(8,'Spain','ES'),(9,'France','FR'),(10,'China','CN'),(11,'Kenya','KE'),(12,'Tanzania','TZ'),(13,'Uganda','UG'),(14,'Algeria','DZ'),(15,'Bahrain','BH'),(16,'Comoros','KM'),(17,'Chad','TD'),(18,'Djibouti','DJ'),(19,'Egypt','EG'),(20,'Eritrea','ER'),(21,'Iraq','IQ'),(22,'Israel','IL'),(23,'Jordan','JO'),(24,'Kuwait','KW'),(25,'Lebanon','LB'),(26,'Libyan Arab Rebublic','LY'),(27,'Mauritania','MR'),(28,'Morocco','MA'),(29,'Oman','OM'),(30,'Qatar','QA'),(31,'Saudi Arabia','SA'),(32,'Somalia','SO'),(33,'Sudan','SD'),(34,'Syrian Arab Republic','SY'),(35,'Tunisia','TN'),(36,'United Arab Emirates','AE'),(37,'Yemen','YE'),(38,'Palestinian Territory, Occupied','PS'),(39,'Western Sahara','EH'),(40,'Angola','AO'),(41,'Brazil','BR'),(42,'Cape Verde','CV'),(43,'Guinea-Bissau','GW'),(44,'Equatorial Guinea','GQ'),(45,'Macau','MO'),(46,'Mozambique','MZ'),(47,'Portugal','PT'),(48,'Sao Tome and Principe','ST'),(49,'Cambodia','KH'),(50,'Laos','LA'),(51,'Hungary','HU');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `currency` (
  `currency_id` smallint(6) NOT NULL auto_increment,
  `currency_name` varchar(50) default NULL,
  `rounding_amount` decimal(6,3) default NULL,
  `currency_code` varchar(3) default NULL,
  PRIMARY KEY  (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'US Dollar','1.000','USD'),(2,'Indian Rupee','1.000','INR'),(3,'Euro','1.000','EUR'),(4,'Pound Sterling','1.000','GBP'),(5,'United Arab Emirates dirham','1.000','AED'),(6,'Afghani','1.000','AFN'),(7,'Lek','1.000','ALL'),(8,'Armenian dram','1.000','AMD'),(9,'Netherlands Antillean guilder','1.000','ANG'),(10,'Kwanza','1.000','AOA'),(11,'Argentine peso','1.000','ARS'),(12,'Australian dollar','1.000','AUD'),(13,'Aruban guilder','1.000','AWG'),(14,'Azerbaijanian manat','1.000','AZN'),(15,'Convertible marks','1.000','BAM'),(16,'Barbados dollar','1.000','BBD'),(17,'Bangladeshi taka','1.000','BDT'),(18,'Bulgarian lev','1.000','BGN'),(19,'Bahraini dinar','1.000','BHD'),(20,'Burundian franc','1.000','BIF'),(21,'Bermudian dollar','1.000','BMD'),(22,'Brunei dollar','1.000','BND'),(23,'Boliviano','1.000','BOB'),(24,'Bolivian Mvdol','1.000','BOV'),(25,'Brazilian real','1.000','BRL'),(26,'Bahamian dollar','1.000','BSD'),(27,'Ngultrum','1.000','BTN'),(28,'Pula','1.000','BWP'),(29,'Belarussian ruble','1.000','BYR'),(30,'Belize dollar','1.000','BZD'),(31,'Canadian dollar','1.000','CAD'),(32,'Franc Congolais','1.000','CDF'),(33,'WIR euro','1.000','CHE'),(34,'Swiss franc','1.000','CHF'),(35,'WIR franc','1.000','CHW'),(36,'Unidad de Fomento','1.000','CLF'),(37,'Chilean peso','1.000','CLP'),(38,'Renminbi','1.000','CNY'),(39,'Colombian peso','1.000','COP'),(40,'Unidad de Valor Real','1.000','COU'),(41,'Costa Rican colon','1.000','CRC'),(42,'Cuban peso','1.000','CUP'),(43,'Cape Verde escudo','1.000','CVE'),(44,'Czech koruna','1.000','CZK'),(45,'Djibouti franc','1.000','DJF'),(46,'Danish krone','1.000','DKK'),(47,'Dominican peso','1.000','DOP'),(48,'Algerian dinar','1.000','DZD'),(49,'Kroon','1.000','EEK'),(50,'Egyptian pound','1.000','EGP'),(51,'Nakfa','1.000','ERN'),(52,'Ethiopian birr','1.000','ETB'),(53,'Fiji dollar','1.000','FJD'),(54,'Falkland Islands pound','1.000','FKP'),(55,'Lari','1.000','GEL'),(56,'Cedi','1.000','GHS'),(57,'Gibraltar pound','1.000','GIP'),(58,'Dalasi','1.000','GMD'),(59,'Guinea franc','1.000','GNF'),(60,'Quetzal','1.000','GTQ'),(61,'Guyana dollar','1.000','GYD'),(62,'Hong Kong dollar','1.000','HKD'),(63,'Lempira','1.000','HNL'),(64,'Croatian kuna','1.000','HRK'),(65,'Haiti gourde','1.000','HTG'),(66,'Forint','1.000','HUF'),(67,'Rupiah','1.000','IDR'),(68,'Israeli new sheqel','1.000','ILS'),(69,'Iraqi dinar','1.000','IQD'),(70,'Iranian rial','1.000','IRR'),(71,'Iceland krona','1.000','ISK'),(72,'Jamaican dollar','1.000','JMD'),(73,'Jordanian dinar','1.000','JOD'),(74,'Japanese yen','1.000','JPY'),(75,'Kenyan shilling','1.000','KES'),(76,'Som','1.000','KGS'),(77,'Riel','1.000','KHR'),(78,'Comoro franc','1.000','KMF'),(79,'North Korean won','1.000','KPW'),(80,'South Korean won','1.000','KRW'),(81,'Kuwaiti dinar','1.000','KWD'),(82,'Cayman Islands dollar','1.000','KYD'),(83,'Tenge','1.000','KZT'),(84,'Kip','1.000','LAK'),(85,'Lebanese pound','1.000','LBP'),(86,'Sri Lanka rupee','1.000','LKR'),(87,'Liberian dollar','1.000','LRD'),(88,'Loti','1.000','LSL'),(89,'Lithuanian litas','1.000','LTL'),(90,'Latvian lats','1.000','LVL'),(91,'Libyan dinar','1.000','LYD'),(92,'Moroccan dirham','1.000','MAD'),(93,'Moldovan leu','1.000','MDL'),(94,'Malagasy ariary','1.000','MGA'),(95,'Denar','1.000','MKD'),(96,'Kyat','1.000','MMK'),(97,'Tugrik','1.000','MNT'),(98,'Pataca','1.000','MOP'),(99,'Ouguiya','1.000','MRO'),(100,'Mauritius rupee','1.000','MUR'),(101,'Rufiyaa','1.000','MVR'),(102,'Kwacha','1.000','MWK'),(103,'Mexican peso','1.000','MXN'),(104,'Mexican Unidad de Inversion','1.000','MXV'),(105,'Malaysian ringgit','1.000','MYR'),(106,'Metical','1.000','MZN'),(107,'Namibian dollar','1.000','NAD'),(108,'Naira','1.000','NGN'),(109,'Cordoba oro','1.000','NIO'),(110,'Norwegian krone','1.000','NOK'),(111,'Nepalese rupee','1.000','NPR'),(112,'New Zealand dollar','1.000','NZD'),(113,'Rial Omani','1.000','OMR'),(114,'Balboa','1.000','PAB'),(115,'Nuevo sol','1.000','PEN'),(116,'Kina','1.000','PGK'),(117,'Philippine peso','1.000','PHP'),(118,'Pakistan rupee','1.000','PKR'),(119,'Zloty','1.000','PLN'),(120,'Guarani','1.000','PYG'),(121,'Qatari rial','1.000','QAR'),(122,'Romanian new leu','1.000','RON'),(123,'Serbian dinar','1.000','RSD'),(124,'Russian rouble','1.000','RUB'),(125,'Rwanda franc','1.000','RWF'),(126,'Saudi riyal','1.000','SAR'),(127,'Solomon Islands dollar','1.000','SBD'),(128,'Seychelles rupee','1.000','SCR'),(129,'Sudanese pound','1.000','SDG'),(130,'Swedish krona','1.000','SEK'),(131,'Singapore dollar','1.000','SGD'),(132,'Saint Helena pound','1.000','SHP'),(133,'Slovak koruna','1.000','SKK'),(134,'Leone','1.000','SLL'),(135,'Somali shilling','1.000','SOS'),(136,'Surinam dollar','1.000','SRD'),(137,'Dobra','1.000','STD'),(138,'Syrian pound','1.000','SYP'),(139,'Lilangeni','1.000','SZL'),(140,'Baht','1.000','THB'),(141,'Somoni','1.000','TJS'),(142,'Manat','1.000','TMM'),(143,'Tunisian dinar','1.000','TND'),(144,'Pa\'anga','1.000','TOP'),(145,'New Turkish lira','1.000','TRY'),(146,'Trinidad and Tobago dollar','1.000','TTD'),(147,'New Taiwan dollar','1.000','TWD'),(148,'Tanzanian shilling','1.000','TZS'),(149,'Hryvnia','1.000','UAH'),(150,'Uganda shilling','1.000','UGX'),(151,'US dollar (next day)','1.000','USN'),(152,'US dollar (same day)','1.000','USS'),(153,'Peso Uruguayo','1.000','UYU'),(154,'Uzbekistan som','1.000','UZS'),(155,'Venezuelan Bolivares Fuertes','1.000','VEF'),(156,'Vietnamese Dong','1.000','VND'),(157,'Vatu','1.000','VUV'),(158,'Samoan tala','1.000','WST'),(159,'CFA franc BEAC','1.000','XAF'),(160,'Silver','1.000','XAG'),(161,'Gold','1.000','XAU'),(162,'European Composite Unit','1.000','XBA'),(163,'European Monetary Unit','1.000','XBB'),(164,'European Unit of Account 9','1.000','XBC'),(165,'European Unit of Account 17','1.000','XBD'),(166,'East Caribbean dollar','1.000','XCD'),(167,'Special Drawing Rights','1.000','XDR'),(168,'UIC franc','1.000','XFU'),(169,'CFA Franc BCEAO','1.000','XOF'),(170,'Palladium','1.000','XPD'),(171,'CFP franc','1.000','XPF'),(172,'Platinum','1.000','XPT'),(173,'Code reserved for testing purposes','1.000','XTS'),(174,'No currency','1.000','XXX'),(175,'Yemeni rial','1.000','YER'),(176,'South African rand','1.000','ZAR'),(177,'Kwacha','1.000','ZMK'),(178,'Zimbabwe dollar','1.000','ZWD');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cust_perf_history`
--

DROP TABLE IF EXISTS `cust_perf_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_perf_history` (
  `customer_id` int(11) NOT NULL,
  `loan_cycle_counter` smallint(6) default NULL,
  `last_loan_amnt` decimal(21,4) default NULL,
  `active_loans_count` smallint(6) default NULL,
  `total_savings_amnt` decimal(21,4) default NULL,
  `delinquint_portfolio` decimal(21,4) default NULL,
  PRIMARY KEY  (`customer_id`),
  CONSTRAINT `cust_perf_history_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cust_perf_history`
--

LOCK TABLES `cust_perf_history` WRITE;
/*!40000 ALTER TABLE `cust_perf_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `cust_perf_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_field_definition`
--

DROP TABLE IF EXISTS `custom_field_definition`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `custom_field_definition` (
  `field_id` smallint(6) NOT NULL auto_increment,
  `entity_id` smallint(6) NOT NULL,
  `level_id` smallint(6) default NULL,
  `field_type` smallint(6) default NULL,
  `entity_type` smallint(6) NOT NULL,
  `mandatory_flag` smallint(6) NOT NULL,
  `default_value` varchar(200) default NULL,
  PRIMARY KEY  (`field_id`),
  KEY `level_id` (`level_id`),
  KEY `entity_id` (`entity_id`),
  KEY `entity_type` (`entity_type`),
  CONSTRAINT `custom_field_definition_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `customer_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `custom_field_definition_ibfk_2` FOREIGN KEY (`entity_id`) REFERENCES `lookup_entity` (`entity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `custom_field_definition_ibfk_3` FOREIGN KEY (`entity_type`) REFERENCES `entity_master` (`entity_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `custom_field_definition`
--

LOCK TABLES `custom_field_definition` WRITE;
/*!40000 ALTER TABLE `custom_field_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_field_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL auto_increment,
  `customer_level_id` smallint(6) NOT NULL,
  `global_cust_num` varchar(100) default NULL,
  `loan_officer_id` smallint(6) default NULL,
  `customer_formedby_id` smallint(6) default NULL,
  `status_id` smallint(6) default NULL,
  `branch_id` smallint(6) default NULL,
  `display_name` varchar(200) default NULL,
  `first_name` varchar(200) default NULL,
  `last_name` varchar(200) default NULL,
  `second_last_name` varchar(200) default NULL,
  `display_address` varchar(500) default NULL,
  `external_id` varchar(50) default NULL,
  `date_of_birth` date default NULL,
  `group_flag` smallint(6) default NULL,
  `trained` smallint(6) default NULL,
  `trained_date` date default NULL,
  `parent_customer_id` int(11) default NULL,
  `created_date` date default NULL,
  `updated_date` date default NULL,
  `search_id` varchar(100) default NULL,
  `max_child_count` int(11) default NULL,
  `ho_updated` smallint(6) default NULL,
  `client_confidential` smallint(6) default NULL,
  `mfi_joining_date` date default NULL,
  `government_id` varchar(50) default NULL,
  `customer_activation_date` date default NULL,
  `created_by` smallint(6) default NULL,
  `updated_by` smallint(6) default NULL,
  `blacklisted` smallint(6) default NULL,
  `discriminator` varchar(20) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`customer_id`),
  UNIQUE KEY `cust_global_idx` (`global_cust_num`),
  KEY `status_id` (`status_id`),
  KEY `customer_formedby_id` (`customer_formedby_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  KEY `cust_search_idx` (`search_id`),
  KEY `cust_government_idx` (`government_id`),
  KEY `cust_lo_idx` (`loan_officer_id`,`branch_id`),
  KEY `customer_lo_name_idx` (`loan_officer_id`,`customer_level_id`,`display_name`(15),`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_name_idx` (`customer_level_id`,`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_branch_search_idx` (`branch_id`,`search_id`),
  KEY `customer_dob_status_idx` (`date_of_birth`,`status_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_level_id`) REFERENCES `customer_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `customer_state` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_ibfk_3` FOREIGN KEY (`branch_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_ibfk_4` FOREIGN KEY (`loan_officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_ibfk_5` FOREIGN KEY (`customer_formedby_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_ibfk_6` FOREIGN KEY (`parent_customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_account`
--

DROP TABLE IF EXISTS `customer_account`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_account` (
  `account_id` int(11) NOT NULL,
  PRIMARY KEY  (`account_id`),
  CONSTRAINT `customer_account_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_account`
--

LOCK TABLES `customer_account` WRITE;
/*!40000 ALTER TABLE `customer_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_account_activity`
--

DROP TABLE IF EXISTS `customer_account_activity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_account_activity` (
  `customer_account_activity_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  `amount` decimal(21,4) default NULL,
  `fee_amount_currency_id` smallint(6) default NULL,
  `created_date` date NOT NULL,
  `created_by` smallint(6) default NULL,
  PRIMARY KEY  (`customer_account_activity_id`),
  KEY `account_id` (`account_id`),
  KEY `fee_amount_currency_id` (`fee_amount_currency_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `customer_account_activity_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_account_activity_ibfk_2` FOREIGN KEY (`fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_account_activity_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_account_activity`
--

LOCK TABLES `customer_account_activity` WRITE;
/*!40000 ALTER TABLE `customer_account_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_account_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address_detail`
--

DROP TABLE IF EXISTS `customer_address_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_address_detail` (
  `customer_address_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) default NULL,
  `locale_id` smallint(6) default NULL,
  `address_name` varchar(100) default NULL,
  `line_1` varchar(200) default NULL,
  `line_2` varchar(200) default NULL,
  `line_3` varchar(200) default NULL,
  `city` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `zip` varchar(20) default NULL,
  `address_status` smallint(6) default NULL,
  `phone_number` varchar(20) default NULL,
  `phone_number_stripped` varchar(20) default NULL,
  PRIMARY KEY  (`customer_address_id`),
  KEY `locale_id` (`locale_id`),
  KEY `cust_address_idx` (`customer_id`),
  KEY `customer_address_detail_phone_number_stripped_idx` (`phone_number_stripped`),
  CONSTRAINT `customer_address_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_address_detail_ibfk_2` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_address_detail`
--

LOCK TABLES `customer_address_detail` WRITE;
/*!40000 ALTER TABLE `customer_address_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_address_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_attendance`
--

DROP TABLE IF EXISTS `customer_attendance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_attendance` (
  `id` int(11) NOT NULL auto_increment,
  `meeting_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `attendance` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `customer_attendance_meeting_date_idx` (`meeting_date`,`customer_id`),
  CONSTRAINT `customer_attendance_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_attendance`
--

LOCK TABLES `customer_attendance` WRITE;
/*!40000 ALTER TABLE `customer_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_attendance_types`
--

DROP TABLE IF EXISTS `customer_attendance_types`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_attendance_types` (
  `attendance_id` smallint(6) NOT NULL auto_increment,
  `attendance_lookup_id` int(11) NOT NULL,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`attendance_id`),
  KEY `attendance_lookup_id` (`attendance_lookup_id`),
  CONSTRAINT `customer_attendance_types_ibfk_1` FOREIGN KEY (`attendance_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_attendance_types`
--

LOCK TABLES `customer_attendance_types` WRITE;
/*!40000 ALTER TABLE `customer_attendance_types` DISABLE KEYS */;
INSERT INTO `customer_attendance_types` VALUES (1,194,'Present'),(2,195,'Absent'),(3,196,'Approved leave'),(4,197,'Late');
/*!40000 ALTER TABLE `customer_attendance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_checklist`
--

DROP TABLE IF EXISTS `customer_checklist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_checklist` (
  `checklist_id` smallint(6) NOT NULL,
  `level_id` smallint(6) NOT NULL,
  `customer_status_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`checklist_id`),
  KEY `level_id` (`level_id`),
  KEY `customer_status_id` (`customer_status_id`),
  CONSTRAINT `customer_checklist_ibfk_1` FOREIGN KEY (`checklist_id`) REFERENCES `checklist` (`checklist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_checklist_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `customer_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_checklist_ibfk_3` FOREIGN KEY (`customer_status_id`) REFERENCES `customer_state` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_checklist`
--

LOCK TABLES `customer_checklist` WRITE;
/*!40000 ALTER TABLE `customer_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_custom_field`
--

DROP TABLE IF EXISTS `customer_custom_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_custom_field` (
  `customer_customfield_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `field_id` smallint(6) NOT NULL,
  `field_value` varchar(200) default NULL,
  PRIMARY KEY  (`customer_customfield_id`),
  KEY `field_id` (`field_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_custom_field_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `custom_field_definition` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_custom_field_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_custom_field`
--

LOCK TABLES `customer_custom_field` WRITE;
/*!40000 ALTER TABLE `customer_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_detail`
--

DROP TABLE IF EXISTS `customer_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_detail` (
  `customer_id` int(11) NOT NULL,
  `ethinicity` int(11) default NULL,
  `citizenship` int(11) default NULL,
  `handicapped` int(11) default NULL,
  `business_activities` int(11) default NULL,
  `marital_status` int(11) default NULL,
  `education_level` int(11) default NULL,
  `num_children` smallint(6) default NULL,
  `gender` smallint(6) default NULL,
  `date_started` date default NULL,
  `handicapped_details` varchar(200) default NULL,
  `poverty_status` int(11) default NULL,
  `poverty_lhood_pct` decimal(21,4) default NULL,
  PRIMARY KEY  (`customer_id`),
  KEY `citizenship` (`citizenship`),
  KEY `education_level` (`education_level`),
  KEY `ethinicity` (`ethinicity`),
  KEY `handicapped` (`handicapped`),
  KEY `marital_status` (`marital_status`),
  KEY `poverty_status` (`poverty_status`),
  CONSTRAINT `customer_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_2` FOREIGN KEY (`citizenship`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_3` FOREIGN KEY (`education_level`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_4` FOREIGN KEY (`ethinicity`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_5` FOREIGN KEY (`handicapped`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_6` FOREIGN KEY (`marital_status`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_detail_ibfk_7` FOREIGN KEY (`poverty_status`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_detail`
--

LOCK TABLES `customer_detail` WRITE;
/*!40000 ALTER TABLE `customer_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_family_detail`
--

DROP TABLE IF EXISTS `customer_family_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_family_detail` (
  `customer_family_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) default NULL,
  `customer_name_id` int(11) default NULL,
  `relationship` smallint(6) default NULL,
  `gender` smallint(6) default NULL,
  `date_of_birth` date default NULL,
  `living_status` smallint(6) default NULL,
  PRIMARY KEY  (`customer_family_id`),
  KEY `customer_id` (`customer_id`),
  KEY `customer_name_id` (`customer_name_id`),
  CONSTRAINT `customer_family_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_family_detail_ibfk_2` FOREIGN KEY (`customer_name_id`) REFERENCES `customer_name_detail` (`customer_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_family_detail`
--

LOCK TABLES `customer_family_detail` WRITE;
/*!40000 ALTER TABLE `customer_family_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_family_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_fee_schedule`
--

DROP TABLE IF EXISTS `customer_fee_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_fee_schedule` (
  `account_fees_detail_id` int(11) NOT NULL auto_increment,
  `id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `account_fee_id` int(11) NOT NULL,
  `amount` decimal(21,4) default NULL,
  `amount_currency_id` smallint(6) default NULL,
  `amount_paid` decimal(21,4) default NULL,
  `amount_paid_currency_id` smallint(6) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`account_fees_detail_id`),
  KEY `id` (`id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `amount_paid_currency_id` (`amount_paid_currency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_id` (`account_fee_id`),
  CONSTRAINT `customer_fee_schedule_ibfk_1` FOREIGN KEY (`id`) REFERENCES `customer_schedule` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_ibfk_2` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_ibfk_3` FOREIGN KEY (`amount_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_fee_schedule_ibfk_4` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`),
  CONSTRAINT `customer_fee_schedule_ibfk_5` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_fee_schedule`
--

LOCK TABLES `customer_fee_schedule` WRITE;
/*!40000 ALTER TABLE `customer_fee_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_fee_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_flag_detail`
--

DROP TABLE IF EXISTS `customer_flag_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_flag_detail` (
  `customer_flag_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `flag_id` smallint(6) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`customer_flag_id`),
  KEY `customer_id` (`customer_id`),
  KEY `flag_id` (`flag_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `customer_flag_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_flag_detail_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `customer_state_flag` (`flag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_flag_detail_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_flag_detail`
--

LOCK TABLES `customer_flag_detail` WRITE;
/*!40000 ALTER TABLE `customer_flag_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_flag_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_hierarchy`
--

DROP TABLE IF EXISTS `customer_hierarchy`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_hierarchy` (
  `hierarchy_id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL,
  `customer_id` int(11) default NULL,
  `status` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`hierarchy_id`),
  KEY `parent_id` (`parent_id`),
  KEY `updated_by` (`updated_by`),
  KEY `cust_hierarchy_idx` (`customer_id`,`status`),
  CONSTRAINT `customer_hierarchy_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_hierarchy_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_hierarchy_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_hierarchy`
--

LOCK TABLES `customer_hierarchy` WRITE;
/*!40000 ALTER TABLE `customer_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_historical_data`
--

DROP TABLE IF EXISTS `customer_historical_data`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_historical_data` (
  `historical_id` smallint(6) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `product_name` varchar(100) default NULL,
  `loan_amount` decimal(21,4) default NULL,
  `loan_amount_currency_id` smallint(6) default NULL,
  `total_amount_paid` decimal(21,4) default NULL,
  `total_amount_paid_currency_id` smallint(6) default NULL,
  `interest_paid` decimal(21,4) default NULL,
  `interest_paid_currency_id` smallint(6) default NULL,
  `missed_payments_count` int(11) default NULL,
  `total_payments_count` int(11) default NULL,
  `notes` varchar(500) default NULL,
  `loan_cycle_number` int(11) default NULL,
  `created_by` smallint(6) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_date` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`historical_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_historical_data_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_historical_data`
--

LOCK TABLES `customer_historical_data` WRITE;
/*!40000 ALTER TABLE `customer_historical_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_historical_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_level`
--

DROP TABLE IF EXISTS `customer_level`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_level` (
  `level_id` smallint(6) NOT NULL,
  `parent_level_id` smallint(6) default NULL,
  `level_name_id` smallint(6) NOT NULL,
  `interaction_flag` smallint(6) default NULL,
  `max_child_count` smallint(6) NOT NULL,
  `max_instance_count` smallint(6) NOT NULL,
  PRIMARY KEY  (`level_id`),
  KEY `parent_level_id` (`parent_level_id`),
  KEY `level_name_id` (`level_name_id`),
  CONSTRAINT `customer_level_ibfk_1` FOREIGN KEY (`parent_level_id`) REFERENCES `customer_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_level_ibfk_2` FOREIGN KEY (`level_name_id`) REFERENCES `lookup_entity` (`entity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_level`
--

LOCK TABLES `customer_level` WRITE;
/*!40000 ALTER TABLE `customer_level` DISABLE KEYS */;
INSERT INTO `customer_level` VALUES (1,2,13,NULL,1,30),(2,3,12,NULL,2,12),(3,NULL,11,NULL,4,10);
/*!40000 ALTER TABLE `customer_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_loan_account_detail`
--

DROP TABLE IF EXISTS `customer_loan_account_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_loan_account_detail` (
  `account_trxn_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `installment_number` smallint(6) NOT NULL,
  `due_date` date NOT NULL,
  `principal` decimal(21,4) NOT NULL,
  `principal_currency_id` smallint(6) NOT NULL,
  `interest` decimal(21,4) NOT NULL,
  `interest_currency_id` smallint(6) NOT NULL,
  `penalty` decimal(21,4) NOT NULL,
  `penalty_currency_id` smallint(6) NOT NULL,
  KEY `account_trxn_id` (`account_trxn_id`),
  KEY `currency_id` (`currency_id`),
  KEY `principal_currency_id` (`principal_currency_id`),
  KEY `interest_currency_id` (`interest_currency_id`),
  KEY `penalty_currency_id` (`penalty_currency_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `customer_loan_account_detail_ibfk_1` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_loan_account_detail_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_loan_account_detail_ibfk_3` FOREIGN KEY (`principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_loan_account_detail_ibfk_4` FOREIGN KEY (`interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_loan_account_detail_ibfk_5` FOREIGN KEY (`penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_loan_account_detail_ibfk_6` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_loan_account_detail`
--

LOCK TABLES `customer_loan_account_detail` WRITE;
/*!40000 ALTER TABLE `customer_loan_account_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_loan_account_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_meeting`
--

DROP TABLE IF EXISTS `customer_meeting`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_meeting` (
  `customer_meeting_id` int(11) NOT NULL auto_increment,
  `meeting_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY  (`customer_meeting_id`),
  KEY `meeting_id` (`meeting_id`),
  KEY `customer_meeting_idx` (`customer_id`),
  CONSTRAINT `customer_meeting_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_meeting_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_meeting`
--

LOCK TABLES `customer_meeting` WRITE;
/*!40000 ALTER TABLE `customer_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_meeting_detail`
--

DROP TABLE IF EXISTS `customer_meeting_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_meeting_detail` (
  `meeting_id` int(11) NOT NULL,
  `details_id` int(11) NOT NULL,
  PRIMARY KEY  (`meeting_id`,`details_id`),
  KEY `details_id` (`details_id`),
  CONSTRAINT `customer_meeting_detail_ibfk_1` FOREIGN KEY (`meeting_id`) REFERENCES `customer_meeting` (`customer_meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_meeting_detail_ibfk_2` FOREIGN KEY (`details_id`) REFERENCES `recurrence_detail` (`details_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_meeting_detail`
--

LOCK TABLES `customer_meeting_detail` WRITE;
/*!40000 ALTER TABLE `customer_meeting_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_meeting_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_movement`
--

DROP TABLE IF EXISTS `customer_movement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_movement` (
  `customer_movement_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) default NULL,
  `personnel_id` smallint(6) default NULL,
  `office_id` smallint(6) NOT NULL,
  `status` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`customer_movement_id`),
  KEY `office_id` (`office_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `updated_by` (`updated_by`),
  KEY `cust_movement_idx` (`customer_id`,`status`),
  CONSTRAINT `customer_movement_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_movement_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_movement_ibfk_3` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_movement_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_movement`
--

LOCK TABLES `customer_movement` WRITE;
/*!40000 ALTER TABLE `customer_movement` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_movement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_name_detail`
--

DROP TABLE IF EXISTS `customer_name_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_name_detail` (
  `customer_name_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) default NULL,
  `name_type` smallint(6) default NULL,
  `locale_id` smallint(6) default NULL,
  `salutation` int(11) default NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) default NULL,
  `last_name` varchar(100) NOT NULL,
  `second_last_name` varchar(100) default NULL,
  `second_middle_name` varchar(100) default NULL,
  `display_name` varchar(200) default NULL,
  PRIMARY KEY  (`customer_name_id`),
  KEY `salutation` (`salutation`),
  KEY `locale_id` (`locale_id`),
  KEY `cust_name_idx` (`customer_id`),
  CONSTRAINT `customer_name_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_name_detail_ibfk_2` FOREIGN KEY (`salutation`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_name_detail_ibfk_3` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_name_detail`
--

LOCK TABLES `customer_name_detail` WRITE;
/*!40000 ALTER TABLE `customer_name_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_name_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_note`
--

DROP TABLE IF EXISTS `customer_note`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_note` (
  `comment_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `field_officer_id` smallint(6) NOT NULL,
  `comment_date` date NOT NULL,
  `comment` varchar(500) NOT NULL,
  PRIMARY KEY  (`comment_id`),
  KEY `field_officer_id` (`field_officer_id`),
  KEY `cust_note_idx` (`customer_id`),
  CONSTRAINT `customer_note_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_note_ibfk_2` FOREIGN KEY (`field_officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_note`
--

LOCK TABLES `customer_note` WRITE;
/*!40000 ALTER TABLE `customer_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_picture`
--

DROP TABLE IF EXISTS `customer_picture`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_picture` (
  `picture_id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `picture` blob,
  PRIMARY KEY  (`picture_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_picture_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_picture`
--

LOCK TABLES `customer_picture` WRITE;
/*!40000 ALTER TABLE `customer_picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_position`
--

DROP TABLE IF EXISTS `customer_position`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_position` (
  `customer_position_id` int(11) NOT NULL auto_increment,
  `position_id` int(11) NOT NULL,
  `customer_id` int(11) default NULL,
  `parent_customer_id` int(11) default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`customer_position_id`),
  UNIQUE KEY `cust_position_idx` (`customer_id`,`position_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  CONSTRAINT `customer_position_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_position_ibfk_2` FOREIGN KEY (`parent_customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_position`
--

LOCK TABLES `customer_position` WRITE;
/*!40000 ALTER TABLE `customer_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_program`
--

DROP TABLE IF EXISTS `customer_program`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_program` (
  `program_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`program_id`,`customer_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_program_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_program_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_program`
--

LOCK TABLES `customer_program` WRITE;
/*!40000 ALTER TABLE `customer_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_schedule`
--

DROP TABLE IF EXISTS `customer_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_schedule` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `action_date` date default NULL,
  `misc_fees` decimal(21,4) default NULL,
  `misc_fees_currency_id` smallint(6) default NULL,
  `misc_fees_paid` decimal(21,4) default NULL,
  `misc_fees_paid_currency_id` smallint(6) default NULL,
  `misc_penalty` decimal(21,4) default NULL,
  `misc_penalty_currency_id` smallint(6) default NULL,
  `misc_penalty_paid` decimal(21,4) default NULL,
  `misc_penalty_paid_currency_id` smallint(6) default NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date default NULL,
  `parent_flag` smallint(6) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `account_id` (`account_id`),
  KEY `currency_id` (`currency_id`),
  KEY `customer_schedule_action_date_idx` (`customer_id`,`action_date`,`payment_status`),
  CONSTRAINT `customer_schedule_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_schedule_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_schedule_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_schedule`
--

LOCK TABLES `customer_schedule` WRITE;
/*!40000 ALTER TABLE `customer_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_state`
--

DROP TABLE IF EXISTS `customer_state`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_state` (
  `status_id` smallint(6) NOT NULL auto_increment,
  `status_lookup_id` int(11) NOT NULL,
  `level_id` smallint(6) NOT NULL,
  `description` varchar(200) default NULL,
  `currently_in_use` smallint(6) NOT NULL,
  PRIMARY KEY  (`status_id`),
  KEY `level_id` (`level_id`),
  KEY `status_lookup_id` (`status_lookup_id`),
  CONSTRAINT `customer_state_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `customer_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_state_ibfk_2` FOREIGN KEY (`status_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_state`
--

LOCK TABLES `customer_state` WRITE;
/*!40000 ALTER TABLE `customer_state` DISABLE KEYS */;
INSERT INTO `customer_state` VALUES (1,1,1,'Customer Was Partial',1),(2,2,1,'Customer Was Pending',1),(3,3,1,'Customer Was Active',1),(4,4,1,'Customer Was Hold',1),(5,5,1,'Customer Was Cancel',1),(6,6,1,'Customer Was Close',1),(7,7,2,'Customer Was Partial',1),(8,8,2,'Customer Was Pending',1),(9,9,2,'Customer Was Active',1),(10,10,2,'Customer Was Hold',1),(11,11,2,'Customer Was Cancel',1),(12,12,2,'Customer Was Close',1),(13,13,3,'Customer Was Active',1),(14,14,3,'Customer Was Inactive',1);
/*!40000 ALTER TABLE `customer_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_state_flag`
--

DROP TABLE IF EXISTS `customer_state_flag`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_state_flag` (
  `flag_id` smallint(6) NOT NULL,
  `flag_lookup_id` int(11) NOT NULL,
  `status_id` smallint(6) NOT NULL,
  `flag_description` varchar(200) NOT NULL,
  `isblacklisted` smallint(6) default NULL,
  PRIMARY KEY  (`flag_id`),
  KEY `status_id` (`status_id`),
  KEY `flag_lookup_id` (`flag_lookup_id`),
  CONSTRAINT `customer_state_flag_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `customer_state` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_state_flag_ibfk_2` FOREIGN KEY (`flag_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_state_flag`
--

LOCK TABLES `customer_state_flag` WRITE;
/*!40000 ALTER TABLE `customer_state_flag` DISABLE KEYS */;
INSERT INTO `customer_state_flag` VALUES (1,28,5,'Withdraw',0),(2,29,5,'Rejected',0),(3,30,5,'Blacklisted',1),(4,31,5,'Duplicate',0),(5,34,5,'Other',0),(6,32,6,'Transferred',0),(7,31,6,'Duplicate',0),(8,30,6,'Blacklisted',1),(9,33,6,'Left program',0),(10,34,6,'Other',0),(11,28,11,'Withdraw',0),(12,29,11,'Rejected',0),(13,30,11,'Blacklisted',1),(14,31,11,'Duplicate',0),(15,34,11,'Other',0),(16,32,12,'Transferred',0),(17,31,12,'Duplicate',0),(18,30,12,'Blacklisted',1),(19,33,12,'Left program',0),(20,34,12,'Other',0);
/*!40000 ALTER TABLE `customer_state_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_trxn_detail`
--

DROP TABLE IF EXISTS `customer_trxn_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_trxn_detail` (
  `account_trxn_id` int(11) NOT NULL,
  `total_amount` decimal(21,4) default NULL,
  `total_amount_currency_id` smallint(6) default NULL,
  `misc_fee_amount` decimal(21,4) default NULL,
  `misc_fee_amount_currency_id` smallint(6) default NULL,
  `misc_penalty_amount` decimal(21,4) default NULL,
  `misc_penalty_amount_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`account_trxn_id`),
  KEY `total_amount_currency_id` (`total_amount_currency_id`),
  KEY `misc_penalty_amount_currency_id` (`misc_penalty_amount_currency_id`),
  KEY `misc_fee_amount_currency_id` (`misc_fee_amount_currency_id`),
  CONSTRAINT `customer_trxn_detail_ibfk_1` FOREIGN KEY (`total_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_trxn_detail_ibfk_2` FOREIGN KEY (`misc_penalty_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_trxn_detail_ibfk_3` FOREIGN KEY (`misc_fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customer_trxn_detail_ibfk_4` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_trxn_detail`
--

LOCK TABLES `customer_trxn_detail` WRITE;
/*!40000 ALTER TABLE `customer_trxn_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_trxn_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customercenterclone`
--

DROP TABLE IF EXISTS `customercenterclone`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customercenterclone` (
  `customer_id` int(11) NOT NULL auto_increment,
  `customer_level_id` smallint(6) NOT NULL,
  `global_cust_num` varchar(100) default NULL,
  `loan_officer_id` smallint(6) default NULL,
  `customer_formedby_id` smallint(6) default NULL,
  `status_id` smallint(6) default NULL,
  `branch_id` smallint(6) default NULL,
  `display_name` varchar(200) default NULL,
  `first_name` varchar(200) default NULL,
  `last_name` varchar(200) default NULL,
  `second_last_name` varchar(200) default NULL,
  `display_address` varchar(500) default NULL,
  `external_id` varchar(50) default NULL,
  `date_of_birth` date default NULL,
  `group_flag` smallint(6) default NULL,
  `trained` smallint(6) default NULL,
  `trained_date` date default NULL,
  `parent_customer_id` int(11) default NULL,
  `created_date` date default NULL,
  `updated_date` date default NULL,
  `search_id` varchar(100) default NULL,
  `max_child_count` int(11) default NULL,
  `ho_updated` smallint(6) default NULL,
  `client_confidential` smallint(6) default NULL,
  `mfi_joining_date` date default NULL,
  `government_id` varchar(50) default NULL,
  `customer_activation_date` date default NULL,
  `created_by` smallint(6) default NULL,
  `updated_by` smallint(6) default NULL,
  `blacklisted` smallint(6) default NULL,
  `discriminator` varchar(20) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`customer_id`),
  UNIQUE KEY `cust_global_idx` (`global_cust_num`),
  KEY `status_id` (`status_id`),
  KEY `customer_formedby_id` (`customer_formedby_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  KEY `cust_search_idx` (`search_id`),
  KEY `cust_government_idx` (`government_id`),
  KEY `cust_lo_idx` (`loan_officer_id`,`branch_id`),
  KEY `customer_lo_name_idx` (`loan_officer_id`,`customer_level_id`,`display_name`(15),`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_name_idx` (`customer_level_id`,`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_branch_search_idx` (`branch_id`,`search_id`),
  KEY `customer_dob_status_idx` (`date_of_birth`,`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customercenterclone`
--

LOCK TABLES `customercenterclone` WRITE;
/*!40000 ALTER TABLE `customercenterclone` DISABLE KEYS */;
/*!40000 ALTER TABLE `customercenterclone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerclone`
--

DROP TABLE IF EXISTS `customerclone`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customerclone` (
  `customer_id` int(11) NOT NULL auto_increment,
  `customer_level_id` smallint(6) NOT NULL,
  `global_cust_num` varchar(100) default NULL,
  `loan_officer_id` smallint(6) default NULL,
  `customer_formedby_id` smallint(6) default NULL,
  `status_id` smallint(6) default NULL,
  `branch_id` smallint(6) default NULL,
  `display_name` varchar(200) default NULL,
  `first_name` varchar(200) default NULL,
  `last_name` varchar(200) default NULL,
  `second_last_name` varchar(200) default NULL,
  `display_address` varchar(500) default NULL,
  `external_id` varchar(50) default NULL,
  `date_of_birth` date default NULL,
  `group_flag` smallint(6) default NULL,
  `trained` smallint(6) default NULL,
  `trained_date` date default NULL,
  `parent_customer_id` int(11) default NULL,
  `created_date` date default NULL,
  `updated_date` date default NULL,
  `search_id` varchar(100) default NULL,
  `max_child_count` int(11) default NULL,
  `ho_updated` smallint(6) default NULL,
  `client_confidential` smallint(6) default NULL,
  `mfi_joining_date` date default NULL,
  `government_id` varchar(50) default NULL,
  `customer_activation_date` date default NULL,
  `created_by` smallint(6) default NULL,
  `updated_by` smallint(6) default NULL,
  `blacklisted` smallint(6) default NULL,
  `discriminator` varchar(20) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`customer_id`),
  UNIQUE KEY `cust_global_idx` (`global_cust_num`),
  KEY `status_id` (`status_id`),
  KEY `customer_formedby_id` (`customer_formedby_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  KEY `cust_search_idx` (`search_id`),
  KEY `cust_government_idx` (`government_id`),
  KEY `cust_lo_idx` (`loan_officer_id`,`branch_id`),
  KEY `customer_lo_name_idx` (`loan_officer_id`,`customer_level_id`,`display_name`(15),`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_name_idx` (`customer_level_id`,`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_branch_search_idx` (`branch_id`,`search_id`),
  KEY `customer_dob_status_idx` (`date_of_birth`,`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customerclone`
--

LOCK TABLES `customerclone` WRITE;
/*!40000 ALTER TABLE `customerclone` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerclone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customergroupclone`
--

DROP TABLE IF EXISTS `customergroupclone`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customergroupclone` (
  `customer_id` int(11) NOT NULL auto_increment,
  `customer_level_id` smallint(6) NOT NULL,
  `global_cust_num` varchar(100) default NULL,
  `loan_officer_id` smallint(6) default NULL,
  `customer_formedby_id` smallint(6) default NULL,
  `status_id` smallint(6) default NULL,
  `branch_id` smallint(6) default NULL,
  `display_name` varchar(200) default NULL,
  `first_name` varchar(200) default NULL,
  `last_name` varchar(200) default NULL,
  `second_last_name` varchar(200) default NULL,
  `display_address` varchar(500) default NULL,
  `external_id` varchar(50) default NULL,
  `date_of_birth` date default NULL,
  `group_flag` smallint(6) default NULL,
  `trained` smallint(6) default NULL,
  `trained_date` date default NULL,
  `parent_customer_id` int(11) default NULL,
  `created_date` date default NULL,
  `updated_date` date default NULL,
  `search_id` varchar(100) default NULL,
  `max_child_count` int(11) default NULL,
  `ho_updated` smallint(6) default NULL,
  `client_confidential` smallint(6) default NULL,
  `mfi_joining_date` date default NULL,
  `government_id` varchar(50) default NULL,
  `customer_activation_date` date default NULL,
  `created_by` smallint(6) default NULL,
  `updated_by` smallint(6) default NULL,
  `blacklisted` smallint(6) default NULL,
  `discriminator` varchar(20) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`customer_id`),
  UNIQUE KEY `cust_global_idx` (`global_cust_num`),
  KEY `status_id` (`status_id`),
  KEY `customer_formedby_id` (`customer_formedby_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  KEY `cust_search_idx` (`search_id`),
  KEY `cust_government_idx` (`government_id`),
  KEY `cust_lo_idx` (`loan_officer_id`,`branch_id`),
  KEY `customer_lo_name_idx` (`loan_officer_id`,`customer_level_id`,`display_name`(15),`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_name_idx` (`customer_level_id`,`first_name`(15),`last_name`(15),`second_last_name`(15)),
  KEY `customer_branch_search_idx` (`branch_id`,`search_id`),
  KEY `customer_dob_status_idx` (`date_of_birth`,`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customergroupclone`
--

LOCK TABLES `customergroupclone` WRITE;
/*!40000 ALTER TABLE `customergroupclone` DISABLE KEYS */;
/*!40000 ALTER TABLE `customergroupclone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_version`
--

DROP TABLE IF EXISTS `database_version`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `database_version` (
  `database_version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `database_version`
--

LOCK TABLES `database_version` WRITE;
/*!40000 ALTER TABLE `database_version` DISABLE KEYS */;
INSERT INTO `database_version` VALUES (257);
/*!40000 ALTER TABLE `database_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_master`
--

DROP TABLE IF EXISTS `entity_master`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `entity_master` (
  `entity_type_id` smallint(6) NOT NULL auto_increment,
  `entity_type` varchar(100) NOT NULL,
  PRIMARY KEY  (`entity_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `entity_master`
--

LOCK TABLES `entity_master` WRITE;
/*!40000 ALTER TABLE `entity_master` DISABLE KEYS */;
INSERT INTO `entity_master` VALUES (1,'Client'),(2,'LoanProduct'),(3,'SavingsProduct'),(4,'ProductCategory'),(5,'ProductConfiguration'),(6,'Fees'),(7,'Accounts'),(8,'Admin'),(9,'Checklist'),(10,'Configuration'),(11,'Customer'),(12,'Group'),(13,'Login'),(14,'Meeting'),(15,'Office'),(16,'Penalty'),(17,'Personnel'),(19,'Roleandpermission'),(20,'Center'),(21,'Savings'),(22,'Loan'),(23,'BulkEntry');
/*!40000 ALTER TABLE `entity_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_sources`
--

DROP TABLE IF EXISTS `event_sources`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `event_sources` (
  `id` int(11) NOT NULL,
  `entity_type_id` smallint(6) NOT NULL,
  `event_id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `entity_type_id` (`entity_type_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `event_sources_ibfk_1` FOREIGN KEY (`entity_type_id`) REFERENCES `entity_master` (`entity_type_id`),
  CONSTRAINT `event_sources_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `event_sources`
--

LOCK TABLES `event_sources` WRITE;
/*!40000 ALTER TABLE `event_sources` DISABLE KEYS */;
INSERT INTO `event_sources` VALUES (1,1,1,'Create Client'),(2,22,1,'Create Loan'),(3,1,2,'View Client'),(4,12,1,'Create Group'),(5,22,3,'Approve Loan'),(6,1,4,'Close Client'),(7,22,2,'View Loan'),(8,12,2,'View Group'),(9,20,1,'Create Center'),(10,20,2,'View Center'),(11,22,5,'Disburse Loan'),(12,21,1,'Create Savings'),(13,21,2,'View Savings'),(14,15,1,'Create Office'),(15,17,1,'Create Personnel');
/*!40000 ALTER TABLE `event_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Create'),(2,'View'),(3,'Approve'),(4,'Close'),(5,'Disburse');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_formula_master`
--

DROP TABLE IF EXISTS `fee_formula_master`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_formula_master` (
  `formulaid` smallint(6) NOT NULL auto_increment,
  `forumla_lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`formulaid`),
  KEY `forumla_lookup_id` (`forumla_lookup_id`),
  CONSTRAINT `fee_formula_master_ibfk_1` FOREIGN KEY (`forumla_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_formula_master`
--

LOCK TABLES `fee_formula_master` WRITE;
/*!40000 ALTER TABLE `fee_formula_master` DISABLE KEYS */;
INSERT INTO `fee_formula_master` VALUES (1,149),(2,150),(3,151);
/*!40000 ALTER TABLE `fee_formula_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_frequency`
--

DROP TABLE IF EXISTS `fee_frequency`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_frequency` (
  `fee_frequency_id` smallint(6) NOT NULL auto_increment,
  `fee_id` smallint(6) NOT NULL,
  `fee_frequencytype_id` smallint(6) NOT NULL,
  `frequency_payment_id` smallint(6) default NULL,
  `frequency_meeting_id` int(11) default NULL,
  PRIMARY KEY  (`fee_frequency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `fee_frequencytype_id` (`fee_frequencytype_id`),
  KEY `frequency_payment_id` (`frequency_payment_id`),
  KEY `frequency_meeting_id` (`frequency_meeting_id`),
  CONSTRAINT `fee_frequency_ibfk_1` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_frequency_ibfk_2` FOREIGN KEY (`fee_frequencytype_id`) REFERENCES `fee_frequency_type` (`fee_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_frequency_ibfk_3` FOREIGN KEY (`frequency_payment_id`) REFERENCES `fee_payment` (`fee_payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_frequency_ibfk_4` FOREIGN KEY (`frequency_meeting_id`) REFERENCES `meeting` (`meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_frequency`
--

LOCK TABLES `fee_frequency` WRITE;
/*!40000 ALTER TABLE `fee_frequency` DISABLE KEYS */;
INSERT INTO `fee_frequency` VALUES (1,1,2,1,NULL),(2,2,2,1,NULL),(3,3,2,1,NULL),(4,4,2,2,NULL);
/*!40000 ALTER TABLE `fee_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_frequency_type`
--

DROP TABLE IF EXISTS `fee_frequency_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_frequency_type` (
  `fee_frequency_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`fee_frequency_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `fee_frequency_type_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_frequency_type`
--

LOCK TABLES `fee_frequency_type` WRITE;
/*!40000 ALTER TABLE `fee_frequency_type` DISABLE KEYS */;
INSERT INTO `fee_frequency_type` VALUES (1,558),(2,559);
/*!40000 ALTER TABLE `fee_frequency_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_payment`
--

DROP TABLE IF EXISTS `fee_payment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_payment` (
  `fee_payment_id` smallint(6) NOT NULL auto_increment,
  `fee_payment_lookup_id` int(11) default NULL,
  PRIMARY KEY  (`fee_payment_id`),
  KEY `fee_payment_lookup_id` (`fee_payment_lookup_id`),
  CONSTRAINT `fee_payment_ibfk_1` FOREIGN KEY (`fee_payment_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_payment`
--

LOCK TABLES `fee_payment` WRITE;
/*!40000 ALTER TABLE `fee_payment` DISABLE KEYS */;
INSERT INTO `fee_payment` VALUES (1,146),(2,147),(3,148);
/*!40000 ALTER TABLE `fee_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_payments_categories_type`
--

DROP TABLE IF EXISTS `fee_payments_categories_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_payments_categories_type` (
  `fee_payments_category_type_id` smallint(6) NOT NULL,
  `fee_payment_id` smallint(6) default NULL,
  `category_id` smallint(6) default NULL,
  `fee_type_id` smallint(6) default NULL,
  PRIMARY KEY  (`fee_payments_category_type_id`),
  KEY `category_id` (`category_id`),
  KEY `fee_payment_id` (`fee_payment_id`),
  KEY `fee_type_id` (`fee_type_id`),
  CONSTRAINT `fee_payments_categories_type_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_type` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_payments_categories_type_ibfk_2` FOREIGN KEY (`fee_payment_id`) REFERENCES `fee_payment` (`fee_payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_payments_categories_type_ibfk_3` FOREIGN KEY (`fee_type_id`) REFERENCES `fee_type` (`fee_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_payments_categories_type`
--

LOCK TABLES `fee_payments_categories_type` WRITE;
/*!40000 ALTER TABLE `fee_payments_categories_type` DISABLE KEYS */;
INSERT INTO `fee_payments_categories_type` VALUES (1,1,1,1),(2,1,1,1),(3,1,1,1);
/*!40000 ALTER TABLE `fee_payments_categories_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_status`
--

DROP TABLE IF EXISTS `fee_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_status` (
  `status_id` smallint(6) NOT NULL auto_increment,
  `status_lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`status_id`),
  KEY `status_lookup_id` (`status_lookup_id`),
  CONSTRAINT `fee_status_ibfk_1` FOREIGN KEY (`status_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_status`
--

LOCK TABLES `fee_status` WRITE;
/*!40000 ALTER TABLE `fee_status` DISABLE KEYS */;
INSERT INTO `fee_status` VALUES (1,165),(2,166);
/*!40000 ALTER TABLE `fee_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_trxn_detail`
--

DROP TABLE IF EXISTS `fee_trxn_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_trxn_detail` (
  `fee_trxn_detail_id` int(11) NOT NULL auto_increment,
  `account_trxn_id` int(11) NOT NULL,
  `account_fee_id` int(11) default NULL,
  `fee_amount_currency_id` smallint(6) default NULL,
  `fee_amount` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`fee_trxn_detail_id`),
  KEY `account_fee_id` (`account_fee_id`),
  KEY `fee_amount_currency_id` (`fee_amount_currency_id`),
  KEY `fee_account_trxn_idx` (`account_trxn_id`),
  CONSTRAINT `fee_trxn_detail_ibfk_1` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_trxn_detail_ibfk_2` FOREIGN KEY (`fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fee_trxn_detail_ibfk_3` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_trxn_detail`
--

LOCK TABLES `fee_trxn_detail` WRITE;
/*!40000 ALTER TABLE `fee_trxn_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `fee_trxn_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_type`
--

DROP TABLE IF EXISTS `fee_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_type` (
  `fee_type_id` smallint(6) NOT NULL,
  `fee_lookup_id` smallint(6) default NULL,
  `flat_or_rate` smallint(6) default NULL,
  `formula` varchar(100) default NULL,
  PRIMARY KEY  (`fee_type_id`),
  KEY `fee_lookup_id` (`fee_lookup_id`),
  CONSTRAINT `fee_type_ibfk_1` FOREIGN KEY (`fee_lookup_id`) REFERENCES `lookup_entity` (`entity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_type`
--

LOCK TABLES `fee_type` WRITE;
/*!40000 ALTER TABLE `fee_type` DISABLE KEYS */;
INSERT INTO `fee_type` VALUES (1,1,NULL,NULL),(2,1,NULL,NULL),(3,2,NULL,NULL),(4,3,NULL,NULL),(5,3,NULL,NULL);
/*!40000 ALTER TABLE `fee_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_update_type`
--

DROP TABLE IF EXISTS `fee_update_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fee_update_type` (
  `fee_update_type_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`fee_update_type_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `fee_update_type_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fee_update_type`
--

LOCK TABLES `fee_update_type` WRITE;
/*!40000 ALTER TABLE `fee_update_type` DISABLE KEYS */;
INSERT INTO `fee_update_type` VALUES (1,556),(2,557);
/*!40000 ALTER TABLE `fee_update_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feelevel`
--

DROP TABLE IF EXISTS `feelevel`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feelevel` (
  `feelevel_id` smallint(6) NOT NULL auto_increment,
  `fee_id` smallint(6) NOT NULL,
  `level_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`feelevel_id`),
  KEY `fee_id` (`fee_id`),
  CONSTRAINT `feelevel_ibfk_1` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `feelevel`
--

LOCK TABLES `feelevel` WRITE;
/*!40000 ALTER TABLE `feelevel` DISABLE KEYS */;
/*!40000 ALTER TABLE `feelevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fees` (
  `fee_id` smallint(6) NOT NULL auto_increment,
  `global_fee_num` varchar(50) default NULL,
  `fee_name` varchar(50) NOT NULL,
  `fee_payments_category_type_id` smallint(6) default NULL,
  `office_id` smallint(6) NOT NULL,
  `glcode_id` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `category_id` smallint(6) NOT NULL,
  `rate_or_amount` decimal(16,5) default NULL,
  `rate_or_amount_currency_id` smallint(6) default NULL,
  `rate_flat_falg` smallint(6) default NULL,
  `created_date` date NOT NULL,
  `created_by` smallint(6) NOT NULL,
  `updated_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `update_flag` smallint(6) default NULL,
  `formula_id` smallint(6) default NULL,
  `default_admin_fee` varchar(10) default NULL,
  `fee_amount` decimal(21,4) default NULL,
  `fee_amount_currency_id` smallint(6) default NULL,
  `rate` decimal(16,5) default NULL,
  `version_no` int(11) NOT NULL,
  `discriminator` varchar(20) default NULL,
  PRIMARY KEY  (`fee_id`),
  UNIQUE KEY `fee_global_idx` (`global_fee_num`),
  KEY `glcode_id` (`glcode_id`),
  KEY `category_id` (`category_id`),
  KEY `status` (`status`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  KEY `formula_id` (`formula_id`),
  KEY `rate_or_amount_currency_id` (`rate_or_amount_currency_id`),
  KEY `fee_amount_currency_id` (`fee_amount_currency_id`),
  KEY `fee_pmnt_catg_idx` (`fee_payments_category_type_id`),
  KEY `fee_office_idx` (`office_id`),
  CONSTRAINT `fees_ibfk_1` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category_type` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_3` FOREIGN KEY (`status`) REFERENCES `fee_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_4` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_6` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_7` FOREIGN KEY (`formula_id`) REFERENCES `fee_formula_master` (`formulaid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_8` FOREIGN KEY (`rate_or_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fees_ibfk_9` FOREIGN KEY (`fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,NULL,'Client Membership Fee',NULL,1,17,1,2,NULL,NULL,NULL,'2011-04-26',1,NULL,NULL,0,NULL,NULL,'100.0000',2,NULL,0,'AMOUNT'),(2,NULL,'Client Training Fee',NULL,1,16,1,2,NULL,NULL,NULL,'2011-04-26',1,NULL,NULL,0,NULL,NULL,'50.0000',2,NULL,0,'AMOUNT'),(3,NULL,'Loan Processing Fee',NULL,1,17,1,5,NULL,NULL,NULL,'2011-04-26',1,NULL,NULL,0,NULL,NULL,'75.0000',2,NULL,0,'AMOUNT'),(4,NULL,'Loan Disbursement Fee',NULL,1,16,1,5,NULL,NULL,NULL,'2011-04-26',1,NULL,NULL,0,1,NULL,NULL,NULL,'1.00000',0,'RATE');
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_configuration`
--

DROP TABLE IF EXISTS `field_configuration`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `field_configuration` (
  `field_config_id` int(11) NOT NULL auto_increment,
  `field_name` varchar(100) NOT NULL,
  `entity_id` smallint(6) NOT NULL,
  `mandatory_flag` smallint(6) NOT NULL,
  `hidden_flag` smallint(6) NOT NULL,
  `parent_field_config_id` int(11) default NULL,
  PRIMARY KEY  (`field_config_id`),
  KEY `entity_id` (`entity_id`),
  KEY `parent_field_config_id` (`parent_field_config_id`),
  CONSTRAINT `field_configuration_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity_master` (`entity_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `field_configuration_ibfk_2` FOREIGN KEY (`parent_field_config_id`) REFERENCES `field_configuration` (`field_config_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `field_configuration`
--

LOCK TABLES `field_configuration` WRITE;
/*!40000 ALTER TABLE `field_configuration` DISABLE KEYS */;
INSERT INTO `field_configuration` VALUES (1,'MiddleName',1,0,0,NULL),(2,'MiddleName',17,0,0,NULL),(3,'SecondLastName',1,0,0,NULL),(4,'SecondLastName',17,0,0,NULL),(5,'GovernmentId',1,0,0,NULL),(6,'GovernmentId',17,0,0,NULL),(7,'ExternalId',1,0,0,NULL),(8,'ExternalId',12,0,0,NULL),(9,'ExternalId',20,0,0,NULL),(10,'Ethinicity',1,0,0,NULL),(11,'Citizenship',1,0,0,NULL),(12,'Handicapped',1,0,0,NULL),(13,'BusinessActivities',1,0,0,NULL),(14,'EducationLevel',1,0,0,NULL),(15,'Photo',1,0,0,NULL),(16,'SpouseFatherMiddleName',1,0,0,NULL),(17,'SpouseFatherSecondLastName',1,0,0,NULL),(18,'Trained',1,0,0,NULL),(19,'Trained',12,0,0,NULL),(20,'TrainedDate',1,0,0,NULL),(21,'TrainedDate',12,0,0,NULL),(22,'Address',1,0,0,NULL),(23,'Address',12,0,0,NULL),(24,'Address',20,0,0,NULL),(25,'Address1',1,0,0,22),(26,'Address1',12,0,0,23),(27,'Address1',20,0,0,24),(28,'Address2',1,0,0,22),(29,'Address2',12,0,0,23),(30,'Address2',20,0,0,24),(31,'Address3',1,0,0,22),(32,'Address3',12,0,0,23),(33,'Address3',20,0,0,24),(34,'Address3',15,0,0,NULL),(35,'Address3',17,0,0,NULL),(36,'City',1,0,0,22),(37,'City',12,0,0,23),(38,'City',20,0,0,24),(39,'State',1,0,0,22),(40,'State',12,0,0,23),(41,'State',20,0,0,24),(42,'State',15,0,0,NULL),(43,'State',17,0,0,NULL),(44,'Country',1,0,0,22),(45,'Country',12,0,0,23),(46,'Country',20,0,0,24),(47,'Country',15,0,0,NULL),(48,'Country',17,0,0,NULL),(49,'PostalCode',1,0,0,22),(50,'PostalCode',12,0,0,23),(51,'PostalCode',20,0,0,24),(52,'PostalCode',15,0,0,NULL),(53,'PostalCode',17,0,0,NULL),(54,'PhoneNumber',1,0,0,NULL),(55,'PhoneNumber',12,0,0,NULL),(56,'PhoneNumber',20,0,0,NULL),(57,'PhoneNumber',17,0,0,NULL),(58,'PurposeOfLoan',22,0,0,NULL),(59,'CollateralType',22,0,0,NULL),(60,'CollateralNotes',22,0,0,NULL),(61,'ReceiptId',1,0,0,NULL),(62,'ReceiptId',12,0,0,NULL),(63,'ReceiptId',20,0,0,NULL),(64,'ReceiptId',21,0,0,NULL),(65,'ReceiptId',22,0,0,NULL),(66,'ReceiptId',23,0,0,NULL),(67,'ReceiptDate',1,0,0,NULL),(68,'ReceiptDate',12,0,0,NULL),(69,'ReceiptDate',20,0,0,NULL),(70,'ReceiptDate',21,0,0,NULL),(71,'ReceiptDate',22,0,0,NULL),(72,'ReceiptDate',23,0,0,NULL),(73,'PovertyStatus',1,1,0,NULL),(74,'AssignClients',1,0,0,NULL),(75,'Address2',15,0,0,NULL),(76,'Address2',17,0,0,NULL),(77,'Address1',15,0,0,NULL),(78,'Address1',17,0,0,NULL),(79,'City',15,0,0,NULL),(80,'SourceOfFund',22,0,0,NULL),(81,'MaritalStatus',1,0,0,NULL),(82,'NumberOfChildren',1,0,0,NULL),(83,'ExternalId',22,0,0,NULL),(84,'SpouseFatherInformation',1,1,0,NULL),(85,'FamilyDetails',1,1,0,NULL);
/*!40000 ALTER TABLE `field_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_action`
--

DROP TABLE IF EXISTS `financial_action`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `financial_action` (
  `fin_action_id` smallint(6) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`fin_action_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `financial_action_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value_locale` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `financial_action`
--

LOCK TABLES `financial_action` WRITE;
/*!40000 ALTER TABLE `financial_action` DISABLE KEYS */;
INSERT INTO `financial_action` VALUES (1,198),(2,199),(3,200),(5,201),(8,202),(9,203),(10,204),(11,205),(12,206),(13,207),(14,208),(15,209),(7,215),(4,229),(6,361),(16,363),(17,365),(18,367),(19,368),(20,369),(21,370),(22,550),(23,609);
/*!40000 ALTER TABLE `financial_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_trxn`
--

DROP TABLE IF EXISTS `financial_trxn`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `financial_trxn` (
  `trxn_id` int(11) NOT NULL auto_increment,
  `account_trxn_id` int(11) NOT NULL,
  `related_fin_trxn` int(11) default NULL,
  `currency_id` smallint(6) default NULL,
  `fin_action_id` smallint(6) default NULL,
  `glcode_id` smallint(6) NOT NULL,
  `posted_amount` decimal(21,4) NOT NULL,
  `posted_amount_currency_id` smallint(6) default NULL,
  `balance_amount` decimal(21,4) NOT NULL,
  `balance_amount_currency_id` smallint(6) default NULL,
  `action_date` date NOT NULL,
  `posted_date` date NOT NULL,
  `posted_by` smallint(6) default NULL,
  `accounting_updated` smallint(6) default NULL,
  `notes` varchar(200) default NULL,
  `debit_credit_flag` smallint(6) NOT NULL,
  PRIMARY KEY  (`trxn_id`),
  KEY `account_trxn_id` (`account_trxn_id`),
  KEY `posted_amount_currency_id` (`posted_amount_currency_id`),
  KEY `balance_amount_currency_id` (`balance_amount_currency_id`),
  KEY `currency_id` (`currency_id`),
  KEY `related_fin_trxn` (`related_fin_trxn`),
  KEY `fin_action_id` (`fin_action_id`),
  KEY `posted_by` (`posted_by`),
  KEY `glcode_id` (`glcode_id`),
  CONSTRAINT `financial_trxn_ibfk_1` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_3` FOREIGN KEY (`posted_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_4` FOREIGN KEY (`balance_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_5` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_6` FOREIGN KEY (`related_fin_trxn`) REFERENCES `financial_trxn` (`trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_7` FOREIGN KEY (`fin_action_id`) REFERENCES `financial_action` (`fin_action_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_8` FOREIGN KEY (`posted_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `financial_trxn_ibfk_9` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `financial_trxn`
--

LOCK TABLES `financial_trxn` WRITE;
/*!40000 ALTER TABLE `financial_trxn` DISABLE KEYS */;
/*!40000 ALTER TABLE `financial_trxn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `freq_of_deposits`
--

DROP TABLE IF EXISTS `freq_of_deposits`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `freq_of_deposits` (
  `freq_of_deposits_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`freq_of_deposits_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `freq_of_deposits_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `freq_of_deposits`
--

LOCK TABLES `freq_of_deposits` WRITE;
/*!40000 ALTER TABLE `freq_of_deposits` DISABLE KEYS */;
/*!40000 ALTER TABLE `freq_of_deposits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund`
--

DROP TABLE IF EXISTS `fund`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fund` (
  `fund_id` smallint(6) NOT NULL auto_increment,
  `fund_name` varchar(100) default NULL,
  `version_no` int(11) default NULL,
  `fundcode_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`fund_id`),
  KEY `fundcode_id` (`fundcode_id`),
  CONSTRAINT `fund_ibfk_1` FOREIGN KEY (`fundcode_id`) REFERENCES `fund_code` (`fundcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fund`
--

LOCK TABLES `fund` WRITE;
/*!40000 ALTER TABLE `fund` DISABLE KEYS */;
INSERT INTO `fund` VALUES (1,'Non Donor',0,1),(2,'Funding Org A',0,1),(3,'Funding Org B',0,1),(4,'Funding Org C',0,1),(5,'Funding Org D',0,1);
/*!40000 ALTER TABLE `fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund_code`
--

DROP TABLE IF EXISTS `fund_code`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `fund_code` (
  `fundcode_id` smallint(6) NOT NULL auto_increment,
  `fundcode_value` varchar(50) NOT NULL,
  PRIMARY KEY  (`fundcode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `fund_code`
--

LOCK TABLES `fund_code` WRITE;
/*!40000 ALTER TABLE `fund_code` DISABLE KEYS */;
INSERT INTO `fund_code` VALUES (1,'00'),(2,'01'),(3,'02'),(4,'03'),(5,'04');
/*!40000 ALTER TABLE `fund_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gl_code`
--

DROP TABLE IF EXISTS `gl_code`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `gl_code` (
  `glcode_id` smallint(6) NOT NULL auto_increment,
  `glcode_value` varchar(50) NOT NULL,
  PRIMARY KEY  (`glcode_id`),
  UNIQUE KEY `glcode_value_idx` (`glcode_value`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `gl_code`
--

LOCK TABLES `gl_code` WRITE;
/*!40000 ALTER TABLE `gl_code` DISABLE KEYS */;
INSERT INTO `gl_code` VALUES (1,'10000'),(2,'1010000000'),(3,'1020000000'),(4,'1020100000'),(5,'1020102000'),(6,'1150000000'),(7,'1150100000'),(8,'1150200000'),(9,'1150300000'),(10,'20000'),(11,'2010000000'),(12,'2010100000'),(13,'2010500000'),(24,'2100000000'),(14,'30000'),(26,'40000'),(15,'4010000000'),(16,'4010100000'),(17,'4010500000'),(18,'4011000000'),(19,'4011500000'),(20,'4012000000'),(21,'4012500000'),(22,'4013000000'),(23,'4013500000'),(25,'4999999999'),(27,'5010000000'),(28,'5010100000'),(29,'5010500000');
/*!40000 ALTER TABLE `gl_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grace_period_type`
--

DROP TABLE IF EXISTS `grace_period_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `grace_period_type` (
  `grace_period_type_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`grace_period_type_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `grace_period_type_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `grace_period_type`
--

LOCK TABLES `grace_period_type` WRITE;
/*!40000 ALTER TABLE `grace_period_type` DISABLE KEYS */;
INSERT INTO `grace_period_type` VALUES (1,96),(2,97),(3,98);
/*!40000 ALTER TABLE `grace_period_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_loan_counter`
--

DROP TABLE IF EXISTS `group_loan_counter`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `group_loan_counter` (
  `group_loan_counter_id` int(11) NOT NULL auto_increment,
  `group_perf_id` int(11) NOT NULL,
  `loan_offering_id` smallint(6) NOT NULL,
  `loan_cycle_counter` smallint(6) default NULL,
  PRIMARY KEY  (`group_loan_counter_id`),
  KEY `group_perf_id` (`group_perf_id`),
  CONSTRAINT `group_loan_counter_ibfk_1` FOREIGN KEY (`group_perf_id`) REFERENCES `group_perf_history` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `group_loan_counter`
--

LOCK TABLES `group_loan_counter` WRITE;
/*!40000 ALTER TABLE `group_loan_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_loan_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_perf_history`
--

DROP TABLE IF EXISTS `group_perf_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `group_perf_history` (
  `id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `no_of_clients` smallint(6) default NULL,
  `last_group_loan_amnt_disb` decimal(21,4) default NULL,
  `last_group_loan_amnt_disb_currency_id` smallint(6) default NULL,
  `avg_loan_size` decimal(21,4) default NULL,
  `avg_loan_size_currency_id` smallint(6) default NULL,
  `total_outstand_loan_amnt` decimal(21,4) default NULL,
  `total_outstand_loan_amnt_currency_id` smallint(6) default NULL,
  `portfolio_at_risk` decimal(21,4) default NULL,
  `portfolio_at_risk_currency_id` smallint(6) default NULL,
  `total_savings_amnt` decimal(21,4) default NULL,
  `total_savings_amnt_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `group_perf_history_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `group_perf_history`
--

LOCK TABLES `group_perf_history` WRITE;
/*!40000 ALTER TABLE `group_perf_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_perf_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holiday`
--

DROP TABLE IF EXISTS `holiday`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `holiday` (
  `holiday_from_date` date NOT NULL,
  `holiday_thru_date` date default NULL,
  `holiday_name` varchar(100) default NULL,
  `repayment_rule_id` smallint(6) NOT NULL,
  `holiday_changes_applied_flag` smallint(6) default '1',
  `holiday_id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`holiday_id`),
  KEY `repayment_rule_id` (`repayment_rule_id`),
  CONSTRAINT `holiday_ibfk_2` FOREIGN KEY (`repayment_rule_id`) REFERENCES `repayment_rule` (`repayment_rule_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `holiday`
--

LOCK TABLES `holiday` WRITE;
/*!40000 ALTER TABLE `holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imported_transactions_files`
--

DROP TABLE IF EXISTS `imported_transactions_files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `imported_transactions_files` (
  `file_name` varchar(100) NOT NULL,
  `submitted_on` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `submitted_by` smallint(6) NOT NULL,
  PRIMARY KEY  (`file_name`),
  KEY `submitted_by` (`submitted_by`),
  CONSTRAINT `imported_transactions_files_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `imported_transactions_files`
--

LOCK TABLES `imported_transactions_files` WRITE;
/*!40000 ALTER TABLE `imported_transactions_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `imported_transactions_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inherited_meeting`
--

DROP TABLE IF EXISTS `inherited_meeting`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `inherited_meeting` (
  `meeting_id` int(11) default NULL,
  `customer_id` int(11) default NULL,
  KEY `customer_id` (`customer_id`),
  KEY `meeting_id` (`meeting_id`),
  CONSTRAINT `inherited_meeting_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `inherited_meeting_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `customer_meeting` (`customer_meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `inherited_meeting`
--

LOCK TABLES `inherited_meeting` WRITE;
/*!40000 ALTER TABLE `inherited_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `inherited_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance_offering`
--

DROP TABLE IF EXISTS `insurance_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `insurance_offering` (
  `prd_offering_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`prd_offering_id`),
  CONSTRAINT `insurance_offering_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `insurance_offering`
--

LOCK TABLES `insurance_offering` WRITE;
/*!40000 ALTER TABLE `insurance_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurance_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_calc_rule`
--

DROP TABLE IF EXISTS `interest_calc_rule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `interest_calc_rule` (
  `interest_calc_rule_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`interest_calc_rule_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `interest_calc_rule_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `interest_calc_rule`
--

LOCK TABLES `interest_calc_rule` WRITE;
/*!40000 ALTER TABLE `interest_calc_rule` DISABLE KEYS */;
INSERT INTO `interest_calc_rule` VALUES (1,88),(2,89);
/*!40000 ALTER TABLE `interest_calc_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_calculation_types`
--

DROP TABLE IF EXISTS `interest_calculation_types`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `interest_calculation_types` (
  `interest_calculation_type_id` smallint(6) NOT NULL auto_increment,
  `interest_calculation_lookup_id` int(11) NOT NULL,
  `description` varchar(100) default NULL,
  PRIMARY KEY  (`interest_calculation_type_id`),
  KEY `interest_calculation_lookup_id` (`interest_calculation_lookup_id`),
  CONSTRAINT `interest_calculation_types_ibfk_1` FOREIGN KEY (`interest_calculation_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `interest_calculation_types`
--

LOCK TABLES `interest_calculation_types` WRITE;
/*!40000 ALTER TABLE `interest_calculation_types` DISABLE KEYS */;
INSERT INTO `interest_calculation_types` VALUES (1,122,NULL),(2,123,NULL);
/*!40000 ALTER TABLE `interest_calculation_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_types`
--

DROP TABLE IF EXISTS `interest_types`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `interest_types` (
  `interest_type_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  `category_id` smallint(6) NOT NULL,
  `descripton` varchar(50) default NULL,
  PRIMARY KEY  (`interest_type_id`),
  KEY `category_id` (`category_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `interest_types_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `interest_types_ibfk_2` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `interest_types`
--

LOCK TABLES `interest_types` WRITE;
/*!40000 ALTER TABLE `interest_types` DISABLE KEYS */;
INSERT INTO `interest_types` VALUES (1,79,1,'Flat'),(2,80,1,'Declining'),(4,604,1,'Declining Balance-Equal Principal Installment'),(5,665,1,'InterestTypes-DecliningPrincipalBalance');
/*!40000 ALTER TABLE `interest_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `language` (
  `lang_id` smallint(6) NOT NULL,
  `lang_name` varchar(100) default NULL,
  `lang_short_name` varchar(10) default NULL,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`lang_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `language_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'English','EN',189),(2,'Icelandic','is',599),(3,'Spanish','es',600),(4,'French','fr',601),(5,'Chinese','zh',613),(6,'Swahili','sw',614),(7,'Arabic','ar',615),(8,'Portuguese','pt',616),(9,'Khmer','km',617),(10,'Lao','lo',618),(11,'Hungarian','hu',624);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_account`
--

DROP TABLE IF EXISTS `loan_account`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_account` (
  `account_id` int(11) NOT NULL,
  `business_activities_id` int(11) default NULL,
  `collateral_type_id` int(11) default NULL,
  `grace_period_type_id` smallint(6) NOT NULL,
  `group_flag` smallint(6) default NULL,
  `loan_amount` decimal(21,4) default NULL,
  `loan_amount_currency_id` smallint(6) default NULL,
  `loan_balance` decimal(21,4) default NULL,
  `loan_balance_currency_id` smallint(6) default NULL,
  `interest_type_id` smallint(6) default NULL,
  `interest_rate` decimal(13,10) default NULL,
  `fund_id` smallint(6) default NULL,
  `meeting_id` int(11) default NULL,
  `currency_id` smallint(6) default NULL,
  `no_of_installments` smallint(6) NOT NULL,
  `disbursement_date` date default NULL,
  `collateral_note` varchar(500) default NULL,
  `grace_period_duration` smallint(6) default NULL,
  `interest_at_disb` smallint(6) default NULL,
  `grace_period_penalty` smallint(6) default NULL,
  `prd_offering_id` smallint(6) default NULL,
  `redone` smallint(6) NOT NULL,
  `parent_account_id` int(11) default NULL,
  `month_rank` smallint(6) default NULL,
  `month_week` smallint(6) default NULL,
  `recur_month` smallint(6) default NULL,
  PRIMARY KEY  (`account_id`),
  KEY `currency_id` (`currency_id`),
  KEY `loan_amount_currency_id` (`loan_amount_currency_id`),
  KEY `loan_balance_currency_id` (`loan_balance_currency_id`),
  KEY `fund_id` (`fund_id`),
  KEY `grace_period_type_id` (`grace_period_type_id`),
  KEY `interest_type_id` (`interest_type_id`),
  KEY `meeting_id` (`meeting_id`),
  KEY `fk_loan_col_type_id` (`collateral_type_id`),
  KEY `fk_loan_bus_act_id` (`business_activities_id`),
  KEY `fk_loan_prd_off_id` (`prd_offering_id`),
  KEY `fk_loan_account` (`parent_account_id`),
  CONSTRAINT `fk_loan_account` FOREIGN KEY (`parent_account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_acc_id` FOREIGN KEY (`parent_account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_bus_act_id` FOREIGN KEY (`business_activities_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_col_type_id` FOREIGN KEY (`collateral_type_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_loan_prd_off_id` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_3` FOREIGN KEY (`loan_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_4` FOREIGN KEY (`loan_balance_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_5` FOREIGN KEY (`fund_id`) REFERENCES `fund` (`fund_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_6` FOREIGN KEY (`grace_period_type_id`) REFERENCES `grace_period_type` (`grace_period_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_7` FOREIGN KEY (`interest_type_id`) REFERENCES `interest_types` (`interest_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_account_ibfk_8` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_account`
--

LOCK TABLES `loan_account` WRITE;
/*!40000 ALTER TABLE `loan_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_activity_details`
--

DROP TABLE IF EXISTS `loan_activity_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_activity_details` (
  `id` int(11) NOT NULL auto_increment,
  `created_by` smallint(6) NOT NULL,
  `account_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `comments` varchar(100) NOT NULL,
  `principal_amount` decimal(21,4) default NULL,
  `principal_amount_currency_id` smallint(6) default NULL,
  `interest_amount` decimal(21,4) default NULL,
  `interest_amount_currency_id` smallint(6) default NULL,
  `penalty_amount` decimal(21,4) default NULL,
  `penalty_amount_currency_id` smallint(6) default NULL,
  `fee_amount` decimal(21,4) default NULL,
  `fee_amount_currency_id` smallint(6) default NULL,
  `balance_principal_amount` decimal(21,4) default NULL,
  `balance_principal_amount_currency_id` smallint(6) default NULL,
  `balance_interest_amount` decimal(21,4) default NULL,
  `balance_interest_amount_currency_id` smallint(6) default NULL,
  `balance_penalty_amount` decimal(21,4) default NULL,
  `balance_penalty_amount_currency_id` smallint(6) default NULL,
  `balance_fee_amount` decimal(21,4) default NULL,
  `balance_fee_amount_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `created_by` (`created_by`),
  KEY `account_id` (`account_id`),
  KEY `principal_amount_currency_id` (`principal_amount_currency_id`),
  KEY `interest_amount_currency_id` (`interest_amount_currency_id`),
  KEY `fee_amount_currency_id` (`fee_amount_currency_id`),
  KEY `penalty_amount_currency_id` (`penalty_amount_currency_id`),
  KEY `balance_principal_amount_currency_id` (`balance_principal_amount_currency_id`),
  KEY `balance_interest_amount_currency_id` (`balance_interest_amount_currency_id`),
  KEY `balance_penalty_amount_currency_id` (`balance_penalty_amount_currency_id`),
  KEY `balance_fee_amount_currency_id` (`balance_fee_amount_currency_id`),
  CONSTRAINT `loan_activity_details_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_10` FOREIGN KEY (`balance_fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_3` FOREIGN KEY (`principal_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_4` FOREIGN KEY (`interest_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_5` FOREIGN KEY (`fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_6` FOREIGN KEY (`penalty_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_7` FOREIGN KEY (`balance_principal_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_8` FOREIGN KEY (`balance_interest_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_activity_details_ibfk_9` FOREIGN KEY (`balance_penalty_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_activity_details`
--

LOCK TABLES `loan_activity_details` WRITE;
/*!40000 ALTER TABLE `loan_activity_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_activity_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_amount_from_last_loan`
--

DROP TABLE IF EXISTS `loan_amount_from_last_loan`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_amount_from_last_loan` (
  `loan_amount_from_last_loan_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `start_range` decimal(21,4) NOT NULL,
  `end_range` decimal(21,4) NOT NULL,
  `min_loan_amount` decimal(21,4) NOT NULL,
  `max_loan_amnt` decimal(21,4) NOT NULL,
  `default_loan_amount` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`loan_amount_from_last_loan_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `loan_amount_from_last_loan_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_amount_from_last_loan`
--

LOCK TABLES `loan_amount_from_last_loan` WRITE;
/*!40000 ALTER TABLE `loan_amount_from_last_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_amount_from_last_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_amount_from_loan_cycle`
--

DROP TABLE IF EXISTS `loan_amount_from_loan_cycle`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_amount_from_loan_cycle` (
  `loan_amount_from_loan_cycle_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `min_loan_amount` decimal(21,4) NOT NULL,
  `max_loan_amnt` decimal(21,4) NOT NULL,
  `default_loan_amount` decimal(21,4) NOT NULL,
  `range_index` smallint(6) NOT NULL,
  PRIMARY KEY  (`loan_amount_from_loan_cycle_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `loan_amount_from_loan_cycle_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_amount_from_loan_cycle`
--

LOCK TABLES `loan_amount_from_loan_cycle` WRITE;
/*!40000 ALTER TABLE `loan_amount_from_loan_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_amount_from_loan_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_amount_same_for_all_loan`
--

DROP TABLE IF EXISTS `loan_amount_same_for_all_loan`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_amount_same_for_all_loan` (
  `loan_amount_same_for_all_loan_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `min_loan_amount` decimal(21,4) NOT NULL,
  `max_loan_amnt` decimal(21,4) NOT NULL,
  `default_loan_amount` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`loan_amount_same_for_all_loan_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `loan_amount_same_for_all_loan_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_amount_same_for_all_loan`
--

LOCK TABLES `loan_amount_same_for_all_loan` WRITE;
/*!40000 ALTER TABLE `loan_amount_same_for_all_loan` DISABLE KEYS */;
INSERT INTO `loan_amount_same_for_all_loan` VALUES (2,2,'5000.0000','25000.0000','20000.0000'),(4,1,'0.0000','50000.0000','15000.0000'),(5,3,'0.0000','50000.0000','20000.0000'),(7,5,'1.0000','50000.0000','20000.0000'),(8,4,'5000.0000','50000.0000','20000.0000');
/*!40000 ALTER TABLE `loan_amount_same_for_all_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_arrears_aging`
--

DROP TABLE IF EXISTS `loan_arrears_aging`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_arrears_aging` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(200) default NULL,
  `parent_customer_id` int(11) default NULL,
  `office_id` smallint(6) NOT NULL,
  `days_in_arrears` smallint(6) NOT NULL,
  `overdue_principal` decimal(21,4) default NULL,
  `overdue_principal_currency_id` smallint(6) default NULL,
  `overdue_interest` decimal(21,4) default NULL,
  `overdue_interest_currency_id` smallint(6) default NULL,
  `overdue_balance` decimal(21,4) default NULL,
  `overdue_balance_currency_id` smallint(6) default NULL,
  `unpaid_principal` decimal(21,4) default NULL,
  `unpaid_principal_currency_id` smallint(6) default NULL,
  `unpaid_interest` decimal(21,4) default NULL,
  `unpaid_interest_currency_id` smallint(6) default NULL,
  `unpaid_balance` decimal(21,4) default NULL,
  `unpaid_balance_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `account_id` (`account_id`),
  KEY `customer_id` (`customer_id`),
  KEY `parent_customer_id` (`parent_customer_id`),
  KEY `office_id` (`office_id`),
  KEY `overdue_principal_currency_id` (`overdue_principal_currency_id`),
  KEY `overdue_interest_currency_id` (`overdue_interest_currency_id`),
  KEY `overdue_balance_currency_id` (`overdue_balance_currency_id`),
  KEY `unpaid_principal_currency_id` (`unpaid_principal_currency_id`),
  KEY `unpaid_interest_currency_id` (`unpaid_interest_currency_id`),
  KEY `unpaid_balance_currency_id` (`unpaid_balance_currency_id`),
  CONSTRAINT `loan_arrears_aging_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_10` FOREIGN KEY (`unpaid_balance_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_3` FOREIGN KEY (`parent_customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_4` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_5` FOREIGN KEY (`overdue_principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_6` FOREIGN KEY (`overdue_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_7` FOREIGN KEY (`overdue_balance_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_8` FOREIGN KEY (`unpaid_principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_arrears_aging_ibfk_9` FOREIGN KEY (`unpaid_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_arrears_aging`
--

LOCK TABLES `loan_arrears_aging` WRITE;
/*!40000 ALTER TABLE `loan_arrears_aging` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_arrears_aging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_cash_flow`
--

DROP TABLE IF EXISTS `loan_cash_flow`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_cash_flow` (
  `loan_id` int(11) NOT NULL,
  `cash_flow_id` int(11) NOT NULL,
  KEY `loan_id` (`loan_id`),
  KEY `cash_flow_id` (`cash_flow_id`),
  CONSTRAINT `loan_cash_flow_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_cash_flow_ibfk_2` FOREIGN KEY (`cash_flow_id`) REFERENCES `cash_flow` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_cash_flow`
--

LOCK TABLES `loan_cash_flow` WRITE;
/*!40000 ALTER TABLE `loan_cash_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_cash_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_counter`
--

DROP TABLE IF EXISTS `loan_counter`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_counter` (
  `loan_counter_id` int(11) NOT NULL auto_increment,
  `client_perf_id` int(11) NOT NULL,
  `loan_offering_id` smallint(6) NOT NULL,
  `loan_cycle_counter` smallint(6) default NULL,
  PRIMARY KEY  (`loan_counter_id`),
  KEY `loan_counter_client_perf_idx` (`client_perf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_counter`
--

LOCK TABLES `loan_counter` WRITE;
/*!40000 ALTER TABLE `loan_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_fee_schedule`
--

DROP TABLE IF EXISTS `loan_fee_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_fee_schedule` (
  `account_fees_detail_id` int(11) NOT NULL auto_increment,
  `id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `account_fee_id` int(11) NOT NULL,
  `amount` decimal(21,4) default NULL,
  `amount_currency_id` smallint(6) default NULL,
  `amount_paid` decimal(21,4) NOT NULL,
  `amount_paid_currency_id` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`account_fees_detail_id`),
  KEY `id` (`id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `amount_paid_currency_id` (`amount_paid_currency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_id` (`account_fee_id`),
  CONSTRAINT `loan_fee_schedule_ibfk_1` FOREIGN KEY (`id`) REFERENCES `loan_schedule` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_ibfk_2` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_ibfk_3` FOREIGN KEY (`amount_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_fee_schedule_ibfk_4` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`),
  CONSTRAINT `loan_fee_schedule_ibfk_5` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_fee_schedule`
--

LOCK TABLES `loan_fee_schedule` WRITE;
/*!40000 ALTER TABLE `loan_fee_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_fee_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_offering`
--

DROP TABLE IF EXISTS `loan_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_offering` (
  `prd_offering_id` smallint(6) NOT NULL,
  `interest_type_id` smallint(6) NOT NULL,
  `interest_calc_rule_id` smallint(6) default NULL,
  `penalty_id` smallint(6) default NULL,
  `min_loan_amount` decimal(21,4) default NULL,
  `min_loan_amount_currency_id` smallint(6) default NULL,
  `max_loan_amnt` decimal(21,4) default NULL,
  `max_loan_amnt_currency_id` smallint(6) default NULL,
  `default_loan_amount` decimal(21,4) default NULL,
  `default_loan_amount_currency_id` smallint(6) default NULL,
  `graceperiod_type_id` smallint(6) default NULL,
  `max_interest_rate` decimal(13,10) NOT NULL,
  `min_interest_rate` decimal(13,10) NOT NULL,
  `def_interest_rate` decimal(13,10) NOT NULL,
  `max_no_installments` smallint(6) default NULL,
  `min_no_installments` smallint(6) default NULL,
  `def_no_installments` smallint(6) default NULL,
  `penalty_grace` smallint(6) default NULL,
  `loan_counter_flag` smallint(6) default NULL,
  `int_ded_disbursement_flag` smallint(6) NOT NULL,
  `prin_due_last_inst_flag` smallint(6) NOT NULL,
  `penalty_rate` decimal(13,10) default NULL,
  `grace_period_duration` smallint(6) default NULL,
  `principal_glcode_id` smallint(6) NOT NULL,
  `interest_glcode_id` smallint(6) NOT NULL,
  `penalties_glcode_id` smallint(6) default NULL,
  `interest_waiver_flag` smallint(6) default '0',
  `variable_installment_flag` smallint(6) default '0',
  `variable_installment_details_id` smallint(6) default NULL,
  `cash_flow_comparison_flag` smallint(6) default '0',
  `cash_flow_detail_id` smallint(6) default NULL,
  PRIMARY KEY  (`prd_offering_id`),
  KEY `principal_glcode_id` (`principal_glcode_id`),
  KEY `interest_glcode_id` (`interest_glcode_id`),
  KEY `loan_offering_penalty_glcode` (`penalties_glcode_id`),
  KEY `graceperiod_type_id` (`graceperiod_type_id`),
  KEY `loan_offering_penalty` (`penalty_id`),
  KEY `loan_offering_interest_calc_rule` (`interest_calc_rule_id`),
  KEY `interest_type_id` (`interest_type_id`),
  KEY `min_loan_amount_currency_id` (`min_loan_amount_currency_id`),
  KEY `max_loan_amnt_currency_id` (`max_loan_amnt_currency_id`),
  KEY `default_loan_amount_currency_id` (`default_loan_amount_currency_id`),
  KEY `variable_installment_details_id` (`variable_installment_details_id`),
  KEY `cash_flow_detail_id` (`cash_flow_detail_id`),
  CONSTRAINT `loan_offering_ibfk_10` FOREIGN KEY (`cash_flow_detail_id`) REFERENCES `cash_flow_detail` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_1` FOREIGN KEY (`principal_glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_2` FOREIGN KEY (`interest_glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_3` FOREIGN KEY (`graceperiod_type_id`) REFERENCES `grace_period_type` (`grace_period_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_4` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_5` FOREIGN KEY (`interest_type_id`) REFERENCES `interest_types` (`interest_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_6` FOREIGN KEY (`min_loan_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_7` FOREIGN KEY (`max_loan_amnt_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_8` FOREIGN KEY (`default_loan_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_ibfk_9` FOREIGN KEY (`variable_installment_details_id`) REFERENCES `variable_installment_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_interest_calc_rule` FOREIGN KEY (`interest_calc_rule_id`) REFERENCES `interest_calc_rule` (`interest_calc_rule_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_penalty` FOREIGN KEY (`penalty_id`) REFERENCES `penalty` (`penalty_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_penalty_glcode` FOREIGN KEY (`penalties_glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_offering`
--

LOCK TABLES `loan_offering` WRITE;
/*!40000 ALTER TABLE `loan_offering` DISABLE KEYS */;
INSERT INTO `loan_offering` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'50.0000000000','0.0000000000','10.0000000000',NULL,NULL,NULL,NULL,0,0,0,NULL,0,7,9,NULL,0,0,NULL,0,NULL),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'20.0000000000','10.0000000000','10.0000000000',NULL,NULL,NULL,NULL,0,0,0,NULL,0,7,9,NULL,0,0,NULL,0,NULL),(3,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'20.0000000000','5.0000000000','10.0000000000',NULL,NULL,NULL,NULL,1,0,0,NULL,0,7,9,NULL,0,0,NULL,0,NULL),(4,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'20.0000000000','10.0000000000','10.0000000000',NULL,NULL,NULL,NULL,0,0,0,NULL,0,7,9,NULL,0,0,NULL,0,NULL),(5,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'20.0000000000','10.0000000000','10.0000000000',NULL,NULL,NULL,NULL,0,0,0,NULL,0,7,9,NULL,0,0,NULL,0,NULL);
/*!40000 ALTER TABLE `loan_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_offering_fund`
--

DROP TABLE IF EXISTS `loan_offering_fund`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_offering_fund` (
  `loan_offering_fund_id` smallint(6) NOT NULL auto_increment,
  `fund_id` smallint(6) NOT NULL,
  `prd_offering_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`loan_offering_fund_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  KEY `fund_id` (`fund_id`),
  CONSTRAINT `loan_offering_fund_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_offering_fund_ibfk_2` FOREIGN KEY (`fund_id`) REFERENCES `fund` (`fund_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_offering_fund`
--

LOCK TABLES `loan_offering_fund` WRITE;
/*!40000 ALTER TABLE `loan_offering_fund` DISABLE KEYS */;
INSERT INTO `loan_offering_fund` VALUES (2,2,2),(4,2,1),(5,2,3),(7,2,5),(8,2,4);
/*!40000 ALTER TABLE `loan_offering_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_penalty`
--

DROP TABLE IF EXISTS `loan_penalty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_penalty` (
  `loan_penalty_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) default NULL,
  `penalty_id` smallint(6) NOT NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `penalty_type` varchar(200) default NULL,
  `penalty_rate` decimal(13,10) default NULL,
  PRIMARY KEY  (`loan_penalty_id`),
  KEY `account_id` (`account_id`),
  KEY `penalty_id` (`penalty_id`),
  CONSTRAINT `loan_penalty_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_penalty_ibfk_2` FOREIGN KEY (`penalty_id`) REFERENCES `penalty` (`penalty_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_penalty`
--

LOCK TABLES `loan_penalty` WRITE;
/*!40000 ALTER TABLE `loan_penalty` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_penalty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_perf_history`
--

DROP TABLE IF EXISTS `loan_perf_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_perf_history` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `no_of_payments` smallint(6) default NULL,
  `no_of_missed_payments` smallint(6) default NULL,
  `days_in_arrears` smallint(6) default NULL,
  `loan_maturity_date` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `loan_perf_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_perf_history`
--

LOCK TABLES `loan_perf_history` WRITE;
/*!40000 ALTER TABLE `loan_perf_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_perf_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_schedule`
--

DROP TABLE IF EXISTS `loan_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_schedule` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `action_date` date default NULL,
  `principal` decimal(21,4) NOT NULL,
  `principal_currency_id` smallint(6) default NULL,
  `interest` decimal(21,4) NOT NULL,
  `interest_currency_id` smallint(6) default NULL,
  `penalty` decimal(21,4) NOT NULL,
  `penalty_currency_id` smallint(6) default NULL,
  `misc_fees` decimal(21,4) default NULL,
  `misc_fees_currency_id` smallint(6) default NULL,
  `misc_fees_paid` decimal(21,4) default NULL,
  `misc_fees_paid_currency_id` smallint(6) default NULL,
  `misc_penalty` decimal(21,4) default NULL,
  `misc_penalty_currency_id` smallint(6) default NULL,
  `misc_penalty_paid` decimal(21,4) default NULL,
  `misc_penalty_paid_currency_id` smallint(6) default NULL,
  `principal_paid` decimal(21,4) default NULL,
  `principal_paid_currency_id` smallint(6) default NULL,
  `interest_paid` decimal(21,4) default NULL,
  `interest_paid_currency_id` smallint(6) default NULL,
  `penalty_paid` decimal(21,4) default NULL,
  `penalty_paid_currency_id` smallint(6) default NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date default NULL,
  `parent_flag` smallint(6) default NULL,
  `version_no` int(11) NOT NULL,
  `extra_interest` decimal(21,4) default NULL,
  `extra_interest_currency_id` smallint(6) default NULL,
  `extra_interest_paid` decimal(21,4) default NULL,
  `extra_interest_paid_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
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
  CONSTRAINT `loan_schedule_ibfk_15` FOREIGN KEY (`extra_interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_10` FOREIGN KEY (`interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_11` FOREIGN KEY (`penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_12` FOREIGN KEY (`misc_penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_13` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_14` FOREIGN KEY (`extra_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_3` FOREIGN KEY (`principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_4` FOREIGN KEY (`interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_5` FOREIGN KEY (`penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_6` FOREIGN KEY (`misc_fees_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_7` FOREIGN KEY (`misc_fees_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_8` FOREIGN KEY (`misc_penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_schedule_ibfk_9` FOREIGN KEY (`principal_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_schedule`
--

LOCK TABLES `loan_schedule` WRITE;
/*!40000 ALTER TABLE `loan_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_summary`
--

DROP TABLE IF EXISTS `loan_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_summary` (
  `account_id` int(11) NOT NULL,
  `orig_principal` decimal(21,4) default NULL,
  `orig_principal_currency_id` smallint(6) default NULL,
  `orig_interest` decimal(21,4) default NULL,
  `orig_interest_currency_id` smallint(6) default NULL,
  `orig_fees` decimal(21,4) default NULL,
  `orig_fees_currency_id` smallint(6) default NULL,
  `orig_penalty` decimal(21,4) default NULL,
  `orig_penalty_currency_id` smallint(6) default NULL,
  `principal_paid` decimal(21,4) default NULL,
  `principal_paid_currency_id` smallint(6) default NULL,
  `interest_paid` decimal(21,4) default NULL,
  `interest_paid_currency_id` smallint(6) default NULL,
  `fees_paid` decimal(21,4) default NULL,
  `fees_paid_currency_id` smallint(6) default NULL,
  `penalty_paid` decimal(21,4) default NULL,
  `penalty_paid_currency_id` smallint(6) default NULL,
  `raw_amount_total` decimal(21,4) default NULL,
  `raw_amount_total_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`account_id`),
  KEY `orig_principal_currency_id` (`orig_principal_currency_id`),
  KEY `orig_interest_currency_id` (`orig_interest_currency_id`),
  KEY `orig_fees_currency_id` (`orig_fees_currency_id`),
  KEY `orig_penalty_currency_id` (`orig_penalty_currency_id`),
  KEY `principal_paid_currency_id` (`principal_paid_currency_id`),
  KEY `interest_paid_currency_id` (`interest_paid_currency_id`),
  KEY `fees_paid_currency_id` (`fees_paid_currency_id`),
  KEY `penalty_paid_currency_id` (`penalty_paid_currency_id`),
  KEY `fk_loan_summary_raw_amount_total` (`raw_amount_total_currency_id`),
  CONSTRAINT `fk_loan_summary_raw_amount_total` FOREIGN KEY (`raw_amount_total_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_1` FOREIGN KEY (`orig_principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_2` FOREIGN KEY (`orig_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_3` FOREIGN KEY (`orig_fees_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_4` FOREIGN KEY (`orig_penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_5` FOREIGN KEY (`principal_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_6` FOREIGN KEY (`interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_7` FOREIGN KEY (`fees_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_8` FOREIGN KEY (`penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_summary_ibfk_9` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_summary`
--

LOCK TABLES `loan_summary` WRITE;
/*!40000 ALTER TABLE `loan_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_trxn_detail`
--

DROP TABLE IF EXISTS `loan_trxn_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loan_trxn_detail` (
  `account_trxn_id` int(11) NOT NULL,
  `principal_amount` decimal(21,4) default NULL,
  `principal_amount_currency_id` smallint(6) default NULL,
  `interest_amount` decimal(21,4) default NULL,
  `interest_amount_currency_id` smallint(6) default NULL,
  `penalty_amount` decimal(21,4) default NULL,
  `penalty_amount_currency_id` smallint(6) default NULL,
  `misc_fee_amount` decimal(21,4) default NULL,
  `misc_fee_amount_currency_id` smallint(6) default NULL,
  `misc_penalty_amount` decimal(21,4) default NULL,
  `misc_penalty_amount_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`account_trxn_id`),
  KEY `principal_amount_currency_id` (`principal_amount_currency_id`),
  KEY `interest_amount_currency_id` (`interest_amount_currency_id`),
  KEY `penalty_amount_currency_id` (`penalty_amount_currency_id`),
  KEY `misc_penalty_amount_currency_id` (`misc_penalty_amount_currency_id`),
  KEY `misc_fee_amount_currency_id` (`misc_fee_amount_currency_id`),
  KEY `loan_account_trxn_idx` (`account_trxn_id`),
  CONSTRAINT `loan_trxn_detail_ibfk_1` FOREIGN KEY (`principal_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_trxn_detail_ibfk_2` FOREIGN KEY (`interest_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_trxn_detail_ibfk_3` FOREIGN KEY (`penalty_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_trxn_detail_ibfk_4` FOREIGN KEY (`misc_penalty_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_trxn_detail_ibfk_5` FOREIGN KEY (`misc_fee_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `loan_trxn_detail_ibfk_6` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `loan_trxn_detail`
--

LOCK TABLES `loan_trxn_detail` WRITE;
/*!40000 ALTER TABLE `loan_trxn_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_trxn_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_entity`
--

DROP TABLE IF EXISTS `lookup_entity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lookup_entity` (
  `entity_id` smallint(6) NOT NULL auto_increment,
  `entity_name` varchar(100) NOT NULL,
  `description` varchar(200) default NULL,
  PRIMARY KEY  (`entity_id`),
  KEY `lookup_entityname_idx` (`entity_name`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lookup_entity`
--

LOCK TABLES `lookup_entity` WRITE;
/*!40000 ALTER TABLE `lookup_entity` DISABLE KEYS */;
INSERT INTO `lookup_entity` VALUES (1,'ClientStatus','Client Status'),(2,'GroupStatus','Group Status'),(3,'CenterStatus','Center Status'),(4,'OfficeStatus','Office Status'),(5,'AccountState','Account States'),(6,'PersonnelStatusUnused','Personnel Status (Unused)'),(7,'GroupFlag','Group Flag'),(8,'FeeType','Fee Type'),(9,'Titles','Customer Position'),(10,'PovertyStatus','Poverty Status For Client'),(11,'Center','Center VALUES'),(12,'Group','Group VALUES'),(13,'Client','Client VALUES'),(14,'Office','Office'),(15,'Salutation','Mr/Mrs'),(16,'Gender','Male/Female'),(17,'MaritalStatus','Married/UnMarried'),(18,'Citizenship','Citizenship'),(19,'Ethinicity','Ethnicity'),(20,'EducationLevel','EducationLevel'),(21,'BusinessActivities','BusinessActivities'),(22,'Handicapped','Handicaped'),(23,'ClientFormedBy','CustomField ClientFormedBy for client'),(24,'PostalCode','ZipCode'),(25,'ProductState','Product State'),(26,'Loan','Loan'),(27,'Savings','Savings'),(29,'PersonnelTitles','CFO/Accountant'),(30,'PersonnelLevels','LoanOfficer/NonLoanOfficer'),(34,'OfficeLevels','Head Office/Regional Office/Sub Regional Office/Area Office/BranchOffice'),(35,'PrdApplicableMaster','Ceratin product categories applicable to certain types of clients'),(36,'WeekDays','Week Days List'),(37,'InterestTypes','Interest Types for PrdOfferings and Accounts'),(38,'CategoryType','This is mainly used in fees to show the categories where this fee is applicable'),(39,'InterestCalcRule','Interest calculation rule for loan prd offerings'),(41,'GracePeriodTypes','Grace Period Types for loan products'),(42,'DayRank','Day Rank'),(43,'CollateralTypes','Collateral Types for loan accounts'),(44,'OfficeCode','Office Code'),(45,'ProductCategoryStatus','ProductCategoryStatus'),(46,'ProductStatus','ProductStatus'),(47,'SavingsType','SavingsType'),(48,'RecommendedAmtUnit','RecommendedAmtUnit'),(49,'IntCalTypes','IntCalTypes'),(50,'YESNO','YESNO'),(51,'AccountType','AccountType'),(52,'SpouseFather','SpouseFather'),(53,'CustomerStatus','CustomerStatus'),(54,'FeePayment','FeePayment'),(55,'FeeFormulaMaster','FeeFormulaMaster'),(56,'PersonnelStatus','PersonnelStatus'),(57,'Personnel','Personnel'),(62,'ExternalId','External ID'),(68,'FeeStatus','FeeStatus'),(69,'AccountAction','AccountAction'),(70,'AccountFlags','AccountFlags'),(71,'PaymentType','PaymentType'),(72,'SavingsStatus','Saving Status'),(73,'Position','Position'),(74,'Language','Language'),(75,'CustomerAttendanceType','CustomerAttendanceType'),(76,'FinancialAction','Financial Action'),(77,'BulkEntry','BulkEntry'),(78,'SavingsAccountFlag','SavingsAccountFlag'),(79,'Address3','Address3'),(80,'City','City'),(81,'Interest','Interest'),(82,'LoanPurposes','Loan Purposes'),(83,'State','State'),(84,'Address1','Address1'),(85,'Address2','Address2'),(86,'GovernmentId','GovernmentId'),(87,'Permissions','Permissions'),(88,'ServiceCharge','Interest'),(89,'feeUpdationType',' fee updation can to applied to existing accounts or future accounts'),(90,'FeeFrequency','Fee Frequency'),(91,'RepaymentRule','Repayment Rule Types'),(92,'LivingStatus','This entity is used to track whether the family member is living together with the client or not');
/*!40000 ALTER TABLE `lookup_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_label`
--

DROP TABLE IF EXISTS `lookup_label`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lookup_label` (
  `label_id` int(11) NOT NULL auto_increment,
  `entity_id` smallint(6) default NULL,
  `locale_id` smallint(6) default NULL,
  `entity_name` varchar(200) default NULL,
  PRIMARY KEY  (`label_id`),
  KEY `entity_id` (`entity_id`),
  KEY `locale_id` (`locale_id`),
  CONSTRAINT `lookup_label_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `lookup_entity` (`entity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lookup_label_ibfk_2` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lookup_label`
--

LOCK TABLES `lookup_label` WRITE;
/*!40000 ALTER TABLE `lookup_label` DISABLE KEYS */;
INSERT INTO `lookup_label` VALUES (1,1,1,NULL),(3,2,1,NULL),(5,3,1,NULL),(7,4,1,NULL),(9,5,1,NULL),(11,6,1,NULL),(13,7,1,NULL),(15,8,1,NULL),(17,9,1,NULL),(19,10,1,NULL),(21,11,1,NULL),(23,12,1,NULL),(25,13,1,NULL),(27,14,1,NULL),(29,15,1,NULL),(31,16,1,NULL),(33,17,1,NULL),(35,18,1,NULL),(37,19,1,NULL),(39,20,1,NULL),(41,21,1,NULL),(43,22,1,NULL),(47,24,1,NULL),(49,25,1,NULL),(51,26,1,NULL),(53,27,1,NULL),(57,29,1,NULL),(59,30,1,NULL),(67,34,1,NULL),(69,35,1,NULL),(71,36,1,NULL),(73,42,1,NULL),(75,37,1,NULL),(76,38,1,NULL),(77,39,1,NULL),(79,41,1,NULL),(80,43,1,NULL),(81,44,1,NULL),(83,45,1,NULL),(85,46,1,NULL),(87,47,1,NULL),(89,48,1,NULL),(91,49,1,NULL),(93,50,1,NULL),(95,51,1,NULL),(97,52,1,NULL),(99,53,1,NULL),(100,54,1,NULL),(102,55,1,NULL),(104,56,1,NULL),(106,57,1,NULL),(116,62,1,NULL),(128,68,1,NULL),(130,69,1,NULL),(132,70,1,NULL),(134,71,1,NULL),(136,72,1,NULL),(151,74,1,NULL),(154,75,1,NULL),(156,76,1,NULL),(158,77,1,NULL),(160,79,1,NULL),(162,80,1,NULL),(164,81,1,NULL),(166,82,1,NULL),(167,83,1,NULL),(168,84,1,NULL),(169,85,1,NULL),(170,86,1,NULL),(171,87,1,NULL),(172,88,1,NULL);
/*!40000 ALTER TABLE `lookup_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_value`
--

DROP TABLE IF EXISTS `lookup_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lookup_value` (
  `lookup_id` int(11) NOT NULL auto_increment,
  `entity_id` smallint(6) default NULL,
  `lookup_name` varchar(100) default NULL,
  PRIMARY KEY  (`lookup_id`),
  UNIQUE KEY `lookup_name_idx` (`lookup_name`),
  KEY `lookup_value_idx` (`entity_id`),
  CONSTRAINT `lookup_value_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `lookup_entity` (`entity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=669 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lookup_value`
--

LOCK TABLES `lookup_value` WRITE;
/*!40000 ALTER TABLE `lookup_value` DISABLE KEYS */;
INSERT INTO `lookup_value` VALUES (1,1,'ClientStatus-PartialApplication'),(2,1,'ClientStatus-ApplicationPendingApproval'),(3,1,'ClientStatus-Active'),(4,1,'ClientStatus-OnHold'),(5,1,'ClientStatus-Cancelled'),(6,1,'ClientStatus-Closed'),(7,2,'GroupStatus-PartialApplication'),(8,2,'GroupStatus-ApplicationPendingApproval'),(9,2,'GroupStatus-Active'),(10,2,'GroupStatus-OnHold'),(11,2,'GroupStatus-Cancelled'),(12,2,'GroupStatus-Closed'),(13,3,'CenterStatus-Active'),(14,3,'CenterStatus-Inactive'),(15,4,'OfficeStatus-Active'),(16,4,'OfficeStatus-Inactive'),(17,5,'AccountState-PartialApplication'),(18,5,'AccountState-ApplicationPendingApproval'),(19,5,'AccountState-ApplicationApproved'),(20,5,'AccountState-DisbursedToLo'),(21,5,'AccountState-ActiveInGoodStanding'),(22,5,'AccountState-ClosedObligationMet'),(23,5,'AccountState-ClosedWrittenOff'),(24,5,'AccountState-ClosedRescheduled'),(25,5,'AccountState-ActiveInBadStanding'),(26,6,'PersonnelStatusUnused-Active'),(27,6,'PersonnelStatusUnused-Inactive'),(28,7,'GroupFlag-Withdraw'),(29,7,'GroupFlag-Rejected'),(30,7,'GroupFlag-Blacklisted'),(31,7,'GroupFlag-Duplicate'),(32,7,'GroupFlag-Transferred'),(33,7,'GroupFlag-LeftProgram'),(34,7,'GroupFlag-Other'),(35,8,'FeeType-MaintenanceFee'),(36,8,'FeeType-ConsultancyFee'),(37,8,'FeeType-TrainingFee'),(38,8,'FeeType-MeetingCharges'),(41,10,'PovertyStatus-VeryPoor'),(42,10,'PovertyStatus-Poor'),(43,10,'PovertyStatus-NonPoor'),(49,16,'Gender-Male'),(50,16,'Gender-Female'),(51,25,'ProductState-Active'),(52,25,'ProductState-Inactive'),(53,25,'ProductState-Close'),(54,26,'Loan-Loan'),(55,27,'Savings-Savings'),(60,30,'PersonnelLevels-LoanOfficer'),(61,30,'PersonnelLevels-NonLoanOfficer'),(68,35,'PrdApplicableMaster-Clients'),(69,35,'PrdApplicableMaster-Groups'),(70,35,'PrdApplicableMaster-Centers'),(79,37,'InterestTypes-Flat'),(80,37,'InterestTypes-DecliningBalance'),(81,38,'CategoryType-AllCustomers'),(82,38,'CategoryType-Client'),(83,38,'CategoryType-Group'),(84,38,'CategoryType-Center'),(85,38,'CategoryType-AllProductTypes'),(86,38,'CategoryType-Loans'),(87,38,'CategoryType-Savings'),(88,39,'InterestCalcRule-AlwaysRecalculate'),(89,39,'InterestCalcRule-NeverRecalculate'),(96,41,'GracePeriodTypes-None'),(97,41,'GracePeriodTypes-GraceOnAllRepayments'),(98,41,'GracePeriodTypes-PrincipalOnlyGrace'),(104,34,'OfficeLevels-HeadOffice'),(105,34,'OfficeLevels-RegionalOffice'),(106,34,'OfficeLevels-DivisionalOffice'),(107,34,'OfficeLevels-AreaOffice'),(108,34,'OfficeLevels-BranchOffice'),(111,44,'OfficeCode-Code1'),(112,44,'OfficeCode-Code2'),(113,45,'ProductCategoryStatus-Inactive'),(114,45,'ProductCategoryStatus-Active'),(115,46,'ProductStatus-Active'),(116,46,'ProductStatus-Inactive'),(117,46,'ProductStatus-Closed'),(118,47,'SavingsType-Mandatory'),(119,47,'SavingsType-Voluntary'),(120,48,'RecommendedAmtUnit-PerIndividual'),(121,48,'RecommendedAmtUnit-CompleteGroup'),(122,49,'IntCalTypes-MinimumBalance'),(123,49,'IntCalTypes-AverageBalance'),(124,50,'YESNO-Yes'),(125,50,'YESNO-No'),(126,51,'AccountType-Loan'),(127,51,'AccountType-Saving'),(128,52,'SpouseFather-Spouse'),(129,52,'SpouseFather-Father'),(140,51,'AccountType-Customer'),(141,5,'AccountState-Cancel'),(142,53,'CustomerStatus-CustomerAccountActive'),(143,53,'CustomerStatus-CustomerAccountInactive'),(146,54,'FeePayment-Upfront'),(147,54,'FeePayment-TimeOfDisburstment'),(148,54,'FeePayment-TimeOfFirstLoanRepayment'),(149,55,'FeeFormulaMaster-LoanAmount'),(150,55,'FeeFormulaMaster-LoanAmountInterest'),(151,55,'FeeFormulaMaster-Interest'),(152,56,'PersonnelStatus-Active'),(153,56,'PersonnelStatus-Inactive'),(154,57,'Personnel-Personnel'),(165,68,'FeeStatus-Active'),(166,68,'FeeStatus-Inactive'),(167,69,'AccountAction-LoanRepayment'),(168,69,'AccountAction-Penalty'),(169,69,'AccountAction-MiscellenousPenalty'),(170,69,'AccountAction-Fee'),(171,69,'AccountAction-MiscellenousFee'),(172,69,'AccountAction-Deposit'),(173,69,'AccountAction-Withdrawal'),(174,70,'AccountFlags-Withdraw'),(175,70,'AccountFlags-Rejected'),(176,70,'AccountFlags-Other'),(177,71,'PaymentType-Cash'),(179,71,'PaymentType-Voucher'),(180,71,'PaymentType-Cheque'),(181,72,'SavingsStatus-PartialApplication'),(182,72,'SavingsStatus-ApplicationPendingApproval'),(183,72,'SavingsStatus-Cancelled'),(184,72,'SavingsStatus-Active'),(185,72,'SavingsStatus-Closed'),(186,73,'Position-CenterLeader'),(187,73,'Position-CenterSecretary'),(188,73,'Position-GroupLeader'),(189,74,'Language-English'),(191,69,'AccountAction-Payment'),(192,69,'AccountAction-Adjustment'),(193,69,'AccountAction-Disbursal'),(194,75,'CustomerAttendance-P'),(195,75,'CustomerAttendance-Ab'),(196,75,'CustomerAttendance-Al'),(197,75,'CustomerAttendance-L'),(198,76,'FinancialAction-Principal'),(199,76,'FinancialAction-Interest'),(200,76,'FinancialAction-Fees'),(201,76,'FinancialAction-Penalty'),(202,76,'FinancialAction-RoundingAdjustments'),(203,76,'FinancialAction-MandatoryDeposit'),(204,76,'FinancialAction-VoluntoryDeposit'),(205,76,'FinancialAction-MandatoryWithdrawal'),(206,76,'FinancialAction-VoluntoryWithdrawal'),(207,76,'FinancialAction-ReversalAdjustment'),(208,76,'FinancialAction-SavingsInterestPosting'),(209,76,'FinancialAction-Interest_posting'),(210,72,'SavingsStatus-Inactive'),(211,78,'SavingsAccountFlag-Withdraw'),(212,78,'SavingsAccountFlag-Rejected'),(213,78,'SavingsAccountFlag-Blacklisted'),(214,69,'AccountAction-Interest_posting'),(215,76,'FinancialAction-LoanDisbursement'),(216,73,'Position-GroupSecretary'),(229,76,'FinancialAction-MiscFee'),(361,76,'FinancialAction-MiscPenalty'),(362,69,'AccountAction-CustomerAccountRepayment'),(363,76,'FinancialAction-CustomerAccountFeesPosting'),(364,69,'AccountAction-CustomerAdjustment'),(365,76,'FinancialAction-CustomerAdjustment'),(366,69,'AccountAction-SavingsAdjustment'),(367,76,'FinancialAction-MandatoryDepositAdjustment'),(368,76,'FinancialAction-VoluntoryDepositAdjustment'),(369,76,'FinancialAction-MandatoryWithdrawalAdjustment'),(370,76,'FinancialAction-VoluntoryWithdrawalAdjustment'),(371,87,'Permissions-OrganizationManagement'),(372,87,'Permissions-Funds'),(373,87,'Permissions-CanCreateFunds'),(374,87,'Permissions-CanModifyFunds'),(375,87,'Permissions-Fees'),(376,87,'Permissions-CanDefineNewFeeType'),(377,87,'Permissions-CanModifyFeeInformation'),(378,87,'Permissions-Checklists'),(379,87,'Permissions-CanDefineNewChecklistType'),(380,87,'Permissions-CanModifyChecklistInformation'),(381,87,'Permissions-OfficeManagement'),(382,87,'Permissions-Offices'),(383,87,'Permissions-CanCreateNewOffice'),(384,87,'Permissions-CanModifyOfficeInformation'),(385,87,'Permissions-UserManagement'),(386,87,'Permissions-Personnel'),(387,87,'Permissions-CanCreateNewSystemUsers'),(388,87,'Permissions-CanModifyUserInformation'),(389,87,'Permissions-CanUnlockAUser'),(390,87,'Permissions-Roles'),(391,87,'Permissions-CanCreateNewRole'),(392,87,'Permissions-CanModifyARole'),(393,87,'Permissions-CanDeleteARole'),(394,87,'Permissions-ClientManagement'),(395,87,'Permissions-Clients'),(396,87,'Permissions-Clients-CanCreateNewClientInSaveForLaterState'),(397,87,'Permissions-Clients-CanCreateNewClientInSubmitForApprovalState'),(398,87,'Permissions-Clients-CanChangeStateToPartialApplication'),(399,87,'Permissions-Clients-CanChangeStateToActive'),(400,87,'Permissions-Clients-CanChangeStateToCancelled'),(401,87,'Permissions-Clients-CanChangeStateToOnHold'),(402,87,'Permissions-Clients-CanChangeStateToClosed'),(403,87,'Permissions-Clients-CanChangeStateToApplicationPendingApproval'),(404,87,'Permissions-Clients-CanMakePaymentsToClientAccounts'),(405,87,'Permissions-Clients-CanMakeAdjustmentEntriesToClientAccount'),(407,87,'Permissions-Clients-CanWaiveADueAmount'),(408,87,'Permissions-Clients-CanRemoveFeeTypesFromClientAccount'),(409,87,'Permissions-Clients-CanAddNotesToClient'),(410,87,'Permissions-Clients-CanEditMfiInformation'),(411,87,'Permissions-Clients-CanEditGroupMembership'),(412,87,'Permissions-Clients-CanEditOfficeMembership'),(413,87,'Permissions-Clients-CanEditMeetingSchedule'),(414,87,'Permissions-Clients-CanAddEditHistoricalData'),(415,87,'Permissions-Clients-CanEditFeeAmountAttachedToTheAccount'),(416,87,'Permissions-Clients-CanBlacklistAClient'),(417,87,'Permissions-Groups'),(418,87,'Permissions-Groups-CanCreateNewGroupInSaveForLaterState'),(419,87,'Permissions-Groups-CanCreateNewGroupInSubmitForApprovalState'),(420,87,'Permissions-Groups-CanChangeStateToPartialApplication'),(421,87,'Permissions-Groups-CanChangeStateToActive'),(422,87,'Permissions-Groups-CanChangeStateToCancelled'),(423,87,'Permissions-Groups-CanChangeStateToOnHold'),(424,87,'Permissions-Groups-CanChangeStateToClosed'),(425,87,'Permissions-Groups-CanChangeStateToApplicationPendingApproval'),(426,87,'Permissions-Groups-CanMakePaymentsToGroupAccounts'),(427,87,'Permissions-Groups-CanMakeAdjustmentEntriesToGroupAccount'),(429,87,'Permissions-Groups-CanWaiveADueAmount'),(430,87,'Permissions-Groups-CanRemoveFeeTypesFromGroupAccount'),(431,87,'Permissions-Groups-CanAddNotesToGroup'),(432,87,'Permissions-Groups-CanEditGroupInformation'),(433,87,'Permissions-Groups-CanEditCenterMembership'),(434,87,'Permissions-Groups-CanEditOfficeMembership'),(435,87,'Permissions-Groups-CanEditMeetingSchedule'),(436,87,'Permissions-Groups-CanAddEditHistoricalData'),(437,87,'Permissions-Groups-CanEditFeeAmountAttachedToTheAccount'),(438,87,'Permissions-Groups-CanBlacklistAGroup'),(439,87,'Permissions-Centers'),(440,87,'Permissions-Centers-CanCreateNewCenter'),(441,87,'Permissions-Centers-CanModifyCenterInformation'),(442,87,'Permissions-Centers-CanEditCenterStatus'),(443,87,'Permissions-Centers-CanMakePaymentsToCenterAccounts'),(444,87,'Permissions-Centers-CanMakeAdjustmentEntriesToCenterAccount'),(446,87,'Permissions-Centers-CanWaiveADueAmount'),(447,87,'Permissions-Centers-CanRemoveFeeTypesFromCenterAccount'),(448,87,'Permissions-Centers-CanAddNotesToCenterRecords'),(449,87,'Permissions-Centers-CanEditFeeAmountAttachedToTheAccount'),(450,87,'Permissions-ProductDefinition'),(451,87,'Permissions-ProductCategories'),(452,87,'Permissions-CanDefineNewProductCategories'),(453,87,'Permissions-CanEditProductCategoryInformation'),(454,87,'Permissions-LoanProducts'),(455,87,'Permissions-CanDefineNewLoanProductInstance'),(456,87,'Permissions-CanEditLoanProductInstances'),(457,87,'Permissions-SavingsProducts'),(458,87,'Permissions-CanDefineNewSavingsProductInstance'),(459,87,'Permissions-CanEditSavingsProductInstances'),(460,87,'Permissions-LoanManagement'),(461,87,'Permissions-LoanProcessing'),(462,87,'Permissions-CanCreateNewLoanAccountInSaveForLaterState'),(463,87,'Permissions-CanCreateNewLoanAccountInSubmitForApprovalState'),(464,87,'Permissions-LoanProcessing-CanChangeStateToPartialApplication'),(465,87,'Permissions-LoanProcessing-CanChangeStateToApproved'),(466,87,'Permissions-LoanProcessing-CanChangeStateToCancelled'),(467,87,'Permissions-LoanProcessing-CanChangeStateToDisbursedToLo'),(469,87,'Permissions-LoanProcessing-CanChangeStateToPendingApproval'),(470,87,'Permissions-LoanProcessing-CanChangeStateToClosedWrittenOff'),(471,87,'Permissions-LoanProcessing-CanChangeStateToClosedRescheduled'),(474,87,'Permissions-LoanTransactions'),(475,87,'Permissions-CanMakePaymentToTheAccount'),(476,87,'Permissions-CanMakeAdjustmentEntryToTheAccount'),(478,87,'Permissions-CanWaivePenalty'),(479,87,'Permissions-CanWaiveAFeeInstallment'),(480,87,'Permissions-CanRemoveFeeTypesAttachedToTheAccount'),(481,87,'Permissions-Clients-CanSpecifyMeetingSchedule'),(482,87,'Permissions-Groups-CanSpecifyMeetingSchedule'),(483,87,'Permissions-Clients-CanEditPersonalInformation'),(484,87,'Permissions-Centers-CanEditMeetingSchedule'),(485,87,'Permissions-Centers-CanSpecifyMeetingSchedule'),(486,87,'Permissions-CanEditLoanAccountInformation'),(487,87,'Permissions-CanApplyChargesToLoans'),(488,87,'Permissions-CanEditSelfInformation'),(489,87,'Permissions-SavingsManagement'),(490,87,'Permissions-CanCreateNewSavingsAccountInSaveForLaterState'),(491,87,'Permissions-CanUpdateSavingsAccount'),(492,87,'Permissions-CanCloseSavingsAccount'),(493,87,'Permissions-SavingsManagement-CanChangeStateToPartialApplication'),(494,87,'Permissions-ReportsManagement'),(495,87,'Permissions-CanAdministerReports'),(496,87,'Permissions-CanPreviewReports'),(497,87,'Permissions-CanUploadNewReports'),(498,87,'Permissions-ClientDetail'),(499,87,'Permissions-Center'),(500,87,'Permissions-Status'),(501,87,'Permissions-Performance'),(502,87,'Permissions-LoanProductDetail'),(503,87,'Permissions-Analysis'),(504,87,'Permissions-Miscellaneous'),(531,87,'Permissions-CanRepayLoan'),(532,87,'Permissions-CanAddNotesToLoanAccount'),(533,87,'Permissions-SavingsManagement-CanChangeStateToPendingApproval'),(534,87,'Permissions-SavingsManagement-CanChangeStateToCancel'),(535,87,'Permissions-SavingsManagement-CanChangeStateToActive'),(536,87,'Permissions-SavingsManagement-CanChangeStateToInactive'),(537,87,'Permissions-CanBlacklistSavingsAccount'),(538,87,'Permissions-CanCreateNewSavingsAccountInSubmitForApprovalState'),(539,87,'Permissions-NotImplemented'),(546,87,'Permissions-CanDoAdjustmentsForSavingsAccount'),(547,69,'AccountAction-LoanWrittenOff'),(548,69,'AccountAction-WaiveOffDue'),(549,69,'AccountAction-WaiveOffOverDue'),(550,76,'FinancialAction-LoanWrittenOff'),(551,87,'Permissions-CanWaiveDueDepositsForSavingsAccount'),(552,87,'Permissions-CanWaiveOverDueDepositsForSavingsAccount'),(553,87,'Permissions-CanDisburseLoan'),(554,87,'Permissions-CanMakeDepositWithdrawalToSavingsAccount'),(555,87,'Permissions-CanAddNotesToSavingsAccount'),(556,89,'feeUpdationType-AppliesToExistingFutureAccounts'),(557,89,'feeUpdationType-AppliesToFutureAccounts'),(558,90,'FeeFrequency-Periodic'),(559,90,'FeeFrequency-OneTime'),(560,87,'Permissions-CanApproveLoansInBulk'),(561,87,'Permissions-CanModifyLatenessDormancyDefinition'),(562,87,'Permissions-CanModifyOfficeHierarchy'),(563,87,'Permissions-CanAddNotesToPersonnel'),(564,87,'Permissions-Bulk'),(565,87,'Permissions-CanEnterCollectionSheetData'),(566,87,'Permissions-Clients-CanApplyChargesToClientAccounts'),(567,87,'Permissions-Groups-CanApplyChargesToGroupAccounts'),(568,87,'Permissions-Centers-CanApplyChargesToCenterAccounts'),(569,87,'Permissions-CanCreateMultipleLoanAccounts'),(570,87,'Permissions-CanReverseLoanDisbursals'),(571,70,'AccountFlags-LoanReversal'),(572,69,'AccountAction-LoanReversal'),(573,69,'AccountAction-DisrbursalAmountReversal'),(574,87,'Permissions-ConfigurationManagement'),(575,87,'Permissions-CanDefineLabels'),(576,91,'RepaymentRule-SameDay'),(577,91,'RepaymentRule-NextMeetingRepayment'),(578,91,'RepaymentRule-NextWorkingDay'),(579,87,'Permissions-CanDefineHiddenMandatoryFields'),(580,87,'Permissions-Clients-CanRemoveClientsFromGroups'),(581,87,'Permissions-CanViewDetailedAgingOfPortfolioAtRisk'),(582,87,'Permissions-Clients-CanAddAnExistingClientToAGroup'),(583,87,'Permissions-ProductMix'),(584,87,'Permissions-CanDefineProductMix'),(585,87,'Permissions-CanEditProductMix'),(586,87,'Permissions-CanViewActiveLoansByLoanOfficer'),(587,87,'Permissions-CanDefineLookupValues'),(588,87,'Permissions-CanUploadReportTemplate'),(589,87,'Permissions-CanViewReports'),(590,87,'Permissions-CanEditReportInformation'),(591,87,'Permissions-CanAdjustPaymentWhenAccountStatusIsClosedObligationMet'),(592,87,'Permissions-CanRedoLoanDisbursals'),(593,87,'Permissions-CanDefineAcceptedPaymentType'),(594,87,'Permissions-CanDefineNewReportCategory'),(595,87,'Permissions-CanViewReportCategory'),(596,87,'Permissions-CanDeleteReportCategory'),(597,87,'Permissions-CanDownloadReportTemplate'),(598,87,'Permissions-CanDefineCustomFields'),(599,74,'Language-Icelandic'),(600,74,'Language-Spanish'),(601,74,'Language-French'),(602,87,'Permissions-CanUploadAdminDocuments'),(603,87,'Permissions-CanViewAdminDocuments'),(604,37,'InterestTypes-DecliningBalance-EqualPrincipalInstallment'),(605,87,'Permissions-SystemInformation'),(606,87,'Permissions-CanViewSystemInformation'),(607,87,'Permissions-CanViewCollectionSheetReport'),(608,87,'Permissions-CanViewOrganizationSettings'),(609,76,'FinancialAction-LoanRescheduled'),(610,69,'AccountAction-LoanRescheduled'),(611,87,'Permissions-CanViewBranchCashConfirmationReport'),(612,87,'Permissions-CanViewBranchProgressReport'),(613,74,'Language-Chinese'),(614,74,'Language-Swahili'),(615,74,'Language-Arabic'),(616,74,'Language-Portuguese'),(617,74,'Language-Khmer'),(618,74,'Language-Lao'),(619,87,'Permissions-CanImportTransactions'),(620,92,'Together'),(621,92,'NotTogether'),(622,52,'Mother'),(623,52,'Child'),(624,74,'Language-Hungarian'),(625,87,'Permissions-CanShutdownMifos'),(626,91,'RepaymentRule-RepaymentMoratorium'),(627,87,'Permissions-CanDefineHoliday'),(628,87,'Permissions.CanViewDetailedAgingOfPortfolioAtRiskReport'),(629,87,'Permissions.CanViewGeneralLedgerReport'),(630,17,'LookUpOption.Single.1300707848277'),(631,17,'LookUpOption.Married.1300707856090'),(632,17,'LookUpOption.Widow.1300707870825'),(633,29,'LookUpOption.Mr.1300707912795'),(634,29,'LookUpOption.Mrs.1300707921045'),(635,29,'LookUpOption.Miss.1300707930233'),(636,29,'LookUpOption.Doc.1300707936202'),(637,15,'LookUpOption.Mr.1300707975016'),(638,15,'LookUpOption.Mrs.1300707979281'),(639,15,'LookUpOption.Ms.1300707984313'),(640,19,'LookUpOption.Asian.1300707993938'),(641,19,'LookUpOption.American.1300708027408'),(642,19,'LookUpOption.Indian.1300708057971'),(643,20,'LookUpOption.10thFail.1300708068222'),(644,20,'LookUpOption.10thPass.1300708076956'),(645,20,'LookUpOption.Graduation.1300708085332'),(646,20,'LookUpOption.PostGraduation.1300708093707'),(647,18,'LookUpOption.Indian.1300708103801'),(648,21,'LookUpOption.Nepalese.1300708111786'),(649,18,'LookUpOption.Bangla.1300708121848'),(650,21,'LookUpOption.Agri.1300708157256'),(651,21,'LookUpOption.Weaver.1300708165053'),(652,22,'LookUpOption.Yes.1300708639193'),(653,22,'LookUpOption.No.1300708645459'),(654,9,'LookUpOption.Mr.1300708699148'),(655,9,'LookUpOption.Mrs.1300708704976'),(656,82,'LookUpOption.Agri.1300708823121'),(657,82,'LookUpOption.NaturalResources.1300708841434'),(658,43,'LookUpOption.None.1300708917671'),(659,87,'Permissions-CanViewActiveSessions'),(660,87,'Permissions-CanStartMifosShutDown'),(661,87,'Permissions-CanManageQuestionGroups'),(662,87,'Permissions-CanRunBatchJobsOnDemand'),(663,87,'Permissions-CanUpdateBatchJobsConfiguration'),(664,87,'Permissions-CanActivateQuestionGroups'),(665,37,'InterestTypes-DecliningPrincipalBalance'),(666,87,'Permissions-CanAdjustBackDatedTransactions'),(667,87,'Permissions-Clients-CanEditPhoneNumber'),(668,87,'Permissions-CanUseAccountingIntegration');
/*!40000 ALTER TABLE `lookup_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_value_locale`
--

DROP TABLE IF EXISTS `lookup_value_locale`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lookup_value_locale` (
  `lookup_value_id` int(11) NOT NULL auto_increment,
  `locale_id` smallint(6) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  `lookup_value` varchar(300) default NULL,
  PRIMARY KEY  (`lookup_value_id`),
  KEY `lookup_id` (`lookup_id`),
  KEY `locale_id` (`locale_id`),
  CONSTRAINT `lookup_value_locale_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lookup_value_locale_ibfk_2` FOREIGN KEY (`locale_id`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=998 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lookup_value_locale`
--

LOCK TABLES `lookup_value_locale` WRITE;
/*!40000 ALTER TABLE `lookup_value_locale` DISABLE KEYS */;
INSERT INTO `lookup_value_locale` VALUES (1,1,1,NULL),(3,1,2,NULL),(5,1,3,NULL),(7,1,4,NULL),(9,1,5,NULL),(11,1,6,NULL),(13,1,7,NULL),(15,1,8,NULL),(17,1,9,NULL),(19,1,10,NULL),(21,1,11,NULL),(23,1,12,NULL),(25,1,13,NULL),(27,1,14,NULL),(29,1,15,NULL),(31,1,16,NULL),(33,1,17,NULL),(35,1,18,NULL),(37,1,19,NULL),(39,1,20,NULL),(41,1,21,NULL),(43,1,22,NULL),(45,1,23,NULL),(47,1,24,NULL),(49,1,25,NULL),(51,1,26,NULL),(53,1,27,NULL),(55,1,28,NULL),(57,1,29,NULL),(59,1,30,NULL),(61,1,31,NULL),(63,1,32,NULL),(65,1,33,NULL),(67,1,34,NULL),(69,1,35,NULL),(71,1,36,NULL),(73,1,37,NULL),(75,1,38,NULL),(81,1,41,NULL),(83,1,42,NULL),(85,1,43,NULL),(97,1,49,NULL),(99,1,50,NULL),(101,1,51,NULL),(103,1,52,NULL),(105,1,53,NULL),(107,1,54,NULL),(109,1,55,NULL),(119,1,60,NULL),(120,1,61,NULL),(135,1,68,NULL),(136,1,69,NULL),(137,1,70,NULL),(157,1,79,NULL),(158,1,80,NULL),(161,1,81,NULL),(162,1,82,NULL),(163,1,83,NULL),(164,1,84,NULL),(165,1,85,NULL),(166,1,86,NULL),(167,1,87,NULL),(168,1,88,NULL),(169,1,89,NULL),(176,1,96,NULL),(177,1,97,NULL),(178,1,98,NULL),(189,1,104,NULL),(191,1,105,NULL),(193,1,106,NULL),(195,1,107,NULL),(197,1,108,NULL),(201,1,111,NULL),(203,1,112,NULL),(205,1,113,NULL),(207,1,114,NULL),(209,1,115,NULL),(211,1,116,NULL),(213,1,117,NULL),(215,1,118,NULL),(217,1,119,NULL),(219,1,120,NULL),(221,1,121,NULL),(223,1,122,NULL),(225,1,123,NULL),(227,1,124,NULL),(229,1,125,NULL),(231,1,126,NULL),(233,1,127,NULL),(235,1,128,NULL),(237,1,129,NULL),(259,1,140,NULL),(261,1,141,NULL),(263,1,142,NULL),(264,1,143,NULL),(267,1,146,NULL),(269,1,147,NULL),(271,1,148,NULL),(273,1,149,NULL),(275,1,150,NULL),(277,1,151,NULL),(279,1,152,NULL),(281,1,153,NULL),(283,1,154,NULL),(305,1,165,NULL),(307,1,166,NULL),(309,1,167,NULL),(311,1,168,NULL),(313,1,169,NULL),(315,1,170,NULL),(317,1,171,NULL),(319,1,172,NULL),(321,1,173,NULL),(323,1,174,NULL),(325,1,175,NULL),(327,1,176,NULL),(329,1,177,NULL),(337,1,181,NULL),(339,1,182,NULL),(341,1,183,NULL),(343,1,184,NULL),(345,1,185,NULL),(347,1,186,NULL),(349,1,187,NULL),(351,1,188,NULL),(376,1,189,NULL),(380,1,191,NULL),(382,1,192,NULL),(384,1,193,NULL),(386,1,194,NULL),(388,1,195,NULL),(390,1,196,NULL),(392,1,197,NULL),(394,1,198,NULL),(395,1,199,NULL),(396,1,200,NULL),(397,1,201,NULL),(398,1,202,NULL),(399,1,203,NULL),(400,1,204,NULL),(401,1,205,NULL),(402,1,206,NULL),(403,1,207,NULL),(404,1,208,NULL),(405,1,209,NULL),(407,1,210,NULL),(409,1,211,NULL),(411,1,212,NULL),(413,1,213,NULL),(415,1,214,NULL),(417,1,215,NULL),(418,1,216,NULL),(440,1,229,NULL),(699,1,361,NULL),(700,1,362,NULL),(701,1,363,NULL),(702,1,364,NULL),(703,1,365,NULL),(704,1,366,NULL),(705,1,367,NULL),(706,1,368,NULL),(707,1,369,NULL),(708,1,370,NULL),(709,1,371,NULL),(710,1,372,NULL),(711,1,373,NULL),(712,1,374,NULL),(713,1,375,NULL),(714,1,376,NULL),(715,1,377,NULL),(716,1,378,NULL),(717,1,379,NULL),(718,1,380,NULL),(719,1,381,NULL),(720,1,382,NULL),(721,1,383,NULL),(722,1,384,NULL),(723,1,385,NULL),(724,1,386,NULL),(725,1,387,NULL),(726,1,388,NULL),(727,1,389,NULL),(728,1,390,NULL),(729,1,391,NULL),(730,1,392,NULL),(731,1,393,NULL),(732,1,394,NULL),(733,1,395,NULL),(734,1,396,NULL),(735,1,397,NULL),(736,1,398,NULL),(737,1,399,NULL),(738,1,400,NULL),(739,1,401,NULL),(740,1,402,NULL),(741,1,403,NULL),(742,1,404,NULL),(743,1,405,NULL),(745,1,407,NULL),(746,1,408,NULL),(747,1,409,NULL),(748,1,410,NULL),(749,1,411,NULL),(750,1,412,NULL),(751,1,413,NULL),(752,1,414,NULL),(753,1,415,NULL),(754,1,416,NULL),(755,1,417,NULL),(756,1,418,NULL),(757,1,419,NULL),(758,1,420,NULL),(759,1,421,NULL),(760,1,422,NULL),(761,1,423,NULL),(762,1,424,NULL),(763,1,425,NULL),(764,1,426,NULL),(765,1,427,NULL),(767,1,429,NULL),(768,1,430,NULL),(769,1,431,NULL),(770,1,432,NULL),(771,1,433,NULL),(772,1,434,NULL),(773,1,435,NULL),(774,1,436,NULL),(775,1,437,NULL),(776,1,438,NULL),(777,1,439,NULL),(778,1,440,NULL),(779,1,441,NULL),(780,1,442,NULL),(781,1,443,NULL),(782,1,444,NULL),(784,1,446,NULL),(785,1,447,NULL),(786,1,448,NULL),(787,1,449,NULL),(788,1,450,NULL),(789,1,451,NULL),(790,1,452,NULL),(791,1,453,NULL),(792,1,454,NULL),(793,1,455,NULL),(794,1,456,NULL),(795,1,457,NULL),(796,1,458,NULL),(797,1,459,NULL),(798,1,460,NULL),(799,1,461,NULL),(800,1,462,NULL),(801,1,463,NULL),(802,1,464,NULL),(803,1,465,NULL),(804,1,466,NULL),(805,1,467,NULL),(807,1,469,NULL),(808,1,470,NULL),(809,1,471,NULL),(812,1,474,NULL),(813,1,475,NULL),(814,1,476,NULL),(816,1,478,NULL),(817,1,479,NULL),(818,1,480,NULL),(819,1,481,NULL),(820,1,482,NULL),(821,1,483,NULL),(822,1,484,NULL),(823,1,485,NULL),(824,1,486,NULL),(825,1,487,NULL),(826,1,488,NULL),(827,1,489,NULL),(828,1,490,NULL),(829,1,491,NULL),(830,1,492,NULL),(831,1,493,NULL),(832,1,494,NULL),(833,1,495,NULL),(834,1,496,NULL),(835,1,497,NULL),(836,1,498,NULL),(837,1,499,NULL),(838,1,500,NULL),(839,1,501,NULL),(840,1,502,NULL),(841,1,503,NULL),(842,1,504,NULL),(869,1,531,NULL),(870,1,532,NULL),(871,1,533,NULL),(872,1,534,NULL),(873,1,535,NULL),(874,1,536,NULL),(875,1,537,NULL),(876,1,538,NULL),(877,1,539,NULL),(884,1,546,NULL),(885,1,547,NULL),(886,1,548,NULL),(887,1,549,NULL),(888,1,550,NULL),(889,1,551,NULL),(890,1,552,NULL),(891,1,553,NULL),(892,1,554,NULL),(893,1,555,NULL),(894,1,556,NULL),(895,1,557,NULL),(896,1,558,NULL),(897,1,559,NULL),(898,1,560,NULL),(899,1,561,NULL),(900,1,562,NULL),(901,1,563,NULL),(902,1,564,NULL),(903,1,565,NULL),(904,1,566,NULL),(905,1,567,NULL),(906,1,568,NULL),(912,1,179,NULL),(913,1,180,NULL),(914,1,569,NULL),(915,1,570,NULL),(916,1,571,NULL),(917,1,572,NULL),(918,1,573,NULL),(919,1,574,NULL),(920,1,575,NULL),(921,1,576,NULL),(922,1,577,NULL),(923,1,578,NULL),(924,1,579,NULL),(925,1,580,NULL),(926,1,581,NULL),(927,1,582,NULL),(928,1,583,NULL),(929,1,584,NULL),(930,1,585,NULL),(931,1,586,NULL),(932,1,587,NULL),(933,1,588,NULL),(934,1,589,NULL),(935,1,590,NULL),(936,1,591,NULL),(937,1,592,NULL),(938,1,593,NULL),(939,1,594,NULL),(940,1,595,NULL),(941,1,596,NULL),(942,1,597,NULL),(943,1,598,NULL),(944,1,602,NULL),(945,1,603,NULL),(946,1,604,NULL),(947,1,605,NULL),(948,1,606,NULL),(949,1,607,NULL),(950,1,608,NULL),(951,1,609,NULL),(952,1,610,NULL),(953,1,611,NULL),(954,1,612,NULL),(955,1,619,NULL),(956,1,625,NULL),(957,1,627,NULL),(958,1,628,'Can View Detailed Aging Of Portfolio At Risk Report'),(959,1,629,'Can View General Ledger Report'),(960,1,630,'Single'),(961,1,631,'Married'),(962,1,632,'Widow'),(963,1,633,'MR'),(964,1,634,'Mrs'),(965,1,635,'Miss'),(966,1,636,'Doc'),(967,1,637,'Mr'),(968,1,638,'Mrs'),(969,1,639,'Ms'),(970,1,640,'Asian'),(971,1,641,'American'),(972,1,642,'Indian'),(973,1,643,'10th Fail'),(974,1,644,'10th Pass'),(975,1,645,'Graduation'),(976,1,646,'Post graduation'),(977,1,647,'Indian'),(978,1,648,'Nepalese'),(979,1,649,'Bangla'),(980,1,650,'Agri'),(981,1,651,'weaver'),(982,1,652,'Yes'),(983,1,653,'No'),(984,1,654,'Mr'),(985,1,655,'Mrs'),(986,1,656,'Agri'),(987,1,657,'natural resources'),(988,1,658,'None'),(989,1,659,NULL),(990,1,660,NULL),(991,1,661,NULL),(992,1,662,NULL),(993,1,663,NULL),(994,1,664,NULL),(995,1,666,NULL),(996,1,667,NULL),(997,1,668,NULL);
/*!40000 ALTER TABLE `lookup_value_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `max_min_interest_rate`
--

DROP TABLE IF EXISTS `max_min_interest_rate`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `max_min_interest_rate` (
  `account_id` int(11) NOT NULL auto_increment,
  `min_interest_rate` decimal(21,4) NOT NULL,
  `max_interest_rate` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`account_id`),
  CONSTRAINT `max_min_interest_rate_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `max_min_interest_rate`
--

LOCK TABLES `max_min_interest_rate` WRITE;
/*!40000 ALTER TABLE `max_min_interest_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `max_min_interest_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `max_min_loan_amount`
--

DROP TABLE IF EXISTS `max_min_loan_amount`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `max_min_loan_amount` (
  `account_id` int(11) NOT NULL auto_increment,
  `min_loan_amount` decimal(21,4) NOT NULL,
  `max_loan_amount` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`account_id`),
  CONSTRAINT `max_min_loan_amount_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `max_min_loan_amount`
--

LOCK TABLES `max_min_loan_amount` WRITE;
/*!40000 ALTER TABLE `max_min_loan_amount` DISABLE KEYS */;
/*!40000 ALTER TABLE `max_min_loan_amount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `max_min_no_of_install`
--

DROP TABLE IF EXISTS `max_min_no_of_install`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `max_min_no_of_install` (
  `account_id` int(11) NOT NULL auto_increment,
  `min_no_install` decimal(21,4) NOT NULL,
  `max_no_install` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`account_id`),
  CONSTRAINT `max_min_no_of_install_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `max_min_no_of_install`
--

LOCK TABLES `max_min_no_of_install` WRITE;
/*!40000 ALTER TABLE `max_min_no_of_install` DISABLE KEYS */;
/*!40000 ALTER TABLE `max_min_no_of_install` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `meeting` (
  `meeting_id` int(11) NOT NULL auto_increment,
  `meeting_type_id` smallint(6) NOT NULL,
  `meeting_place` varchar(200) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `start_time` date default NULL,
  `end_time` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`meeting_id`),
  KEY `meeting_type_id` (`meeting_type_id`),
  CONSTRAINT `meeting_ibfk_1` FOREIGN KEY (`meeting_type_id`) REFERENCES `meeting_type` (`meeting_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES (1,1,'meetingPlace','2011-03-22',NULL,NULL,NULL,0),(2,1,'meetingPlace','2011-03-24',NULL,NULL,NULL,0),(3,1,'meetingPlace','2011-04-18',NULL,NULL,NULL,0),(4,1,'meetingPlace','2011-04-18',NULL,NULL,NULL,0),(5,1,'meetingPlace','2011-04-19',NULL,NULL,NULL,0),(6,1,'meetingPlace','2011-04-18',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_type`
--

DROP TABLE IF EXISTS `meeting_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `meeting_type` (
  `meeting_type_id` smallint(6) NOT NULL auto_increment,
  `meeting_purpose` varchar(50) default NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY  (`meeting_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `meeting_type`
--

LOCK TABLES `meeting_type` WRITE;
/*!40000 ALTER TABLE `meeting_type` DISABLE KEYS */;
INSERT INTO `meeting_type` VALUES (1,'LOANFREQUENCYOFINSTALLMENTS','Loan Frequency of istalments'),(2,'SAVINGSTIMEPERFORINTCALC','Savings Time Period for Interest Calculation'),(3,'SAVINGSFRQINTPOSTACC','Savings Frequency of Interest Posting to Accounts'),(4,'CUSTOMERMEETING','Customer Meeting'),(5,'FEEMEETING','Fees Meetings');
/*!40000 ALTER TABLE `meeting_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfi_attribute`
--

DROP TABLE IF EXISTS `mfi_attribute`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `mfi_attribute` (
  `attribute_id` smallint(6) NOT NULL,
  `office_id` smallint(6) NOT NULL,
  `attribute_name` varchar(100) NOT NULL,
  `attribute_value` varchar(200) NOT NULL,
  PRIMARY KEY  (`attribute_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `mfi_attribute_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `mfi_attribute`
--

LOCK TABLES `mfi_attribute` WRITE;
/*!40000 ALTER TABLE `mfi_attribute` DISABLE KEYS */;
INSERT INTO `mfi_attribute` VALUES (1,1,'CENTER','GROUP'),(2,1,'CENTER','GROUP'),(3,1,'CENTER','GROUP'),(4,1,'CENTER','GROUP'),(5,1,'CENTER','GROUP');
/*!40000 ALTER TABLE `mfi_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_cash_flow_details`
--

DROP TABLE IF EXISTS `monthly_cash_flow_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `monthly_cash_flow_details` (
  `id` int(11) NOT NULL auto_increment,
  `cash_flow_id` int(11) default NULL,
  `month_year` date default NULL,
  `revenue` decimal(21,4) NOT NULL,
  `expenses` decimal(21,4) NOT NULL,
  `notes` varchar(300) default NULL,
  PRIMARY KEY  (`id`),
  KEY `cash_flow_id` (`cash_flow_id`),
  CONSTRAINT `monthly_cash_flow_details_ibfk_1` FOREIGN KEY (`cash_flow_id`) REFERENCES `cash_flow` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `monthly_cash_flow_details`
--

LOCK TABLES `monthly_cash_flow_details` WRITE;
/*!40000 ALTER TABLE `monthly_cash_flow_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthly_cash_flow_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_of_install_from_last_loan`
--

DROP TABLE IF EXISTS `no_of_install_from_last_loan`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `no_of_install_from_last_loan` (
  `no_of_install_from_last_loan_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `start_range` decimal(21,4) NOT NULL,
  `end_range` decimal(21,4) NOT NULL,
  `min_no_install` decimal(21,4) NOT NULL,
  `max_no_install` decimal(21,4) NOT NULL,
  `default_no_install` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`no_of_install_from_last_loan_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `no_of_install_from_last_loan_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `no_of_install_from_last_loan`
--

LOCK TABLES `no_of_install_from_last_loan` WRITE;
/*!40000 ALTER TABLE `no_of_install_from_last_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `no_of_install_from_last_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_of_install_from_loan_cycle`
--

DROP TABLE IF EXISTS `no_of_install_from_loan_cycle`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `no_of_install_from_loan_cycle` (
  `no_of_install_from_loan_cycle_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `min_no_install` decimal(21,4) NOT NULL,
  `max_no_install` decimal(21,4) NOT NULL,
  `default_no_install` decimal(21,4) NOT NULL,
  `range_index` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`no_of_install_from_loan_cycle_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `no_of_install_from_loan_cycle_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `no_of_install_from_loan_cycle`
--

LOCK TABLES `no_of_install_from_loan_cycle` WRITE;
/*!40000 ALTER TABLE `no_of_install_from_loan_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `no_of_install_from_loan_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_of_install_same_for_all_loan`
--

DROP TABLE IF EXISTS `no_of_install_same_for_all_loan`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `no_of_install_same_for_all_loan` (
  `no_of_install_same_for_all_loan_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `min_no_install` decimal(21,4) NOT NULL,
  `max_no_install` decimal(21,4) NOT NULL,
  `default_no_install` decimal(21,4) NOT NULL,
  PRIMARY KEY  (`no_of_install_same_for_all_loan_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `no_of_install_same_for_all_loan_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `loan_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `no_of_install_same_for_all_loan`
--

LOCK TABLES `no_of_install_same_for_all_loan` WRITE;
/*!40000 ALTER TABLE `no_of_install_same_for_all_loan` DISABLE KEYS */;
INSERT INTO `no_of_install_same_for_all_loan` VALUES (2,2,'1.0000','12.0000','12.0000'),(4,1,'1.0000','52.0000','52.0000'),(5,3,'1.0000','52.0000','52.0000'),(7,5,'1.0000','52.0000','52.0000'),(8,4,'1.0000','24.0000','12.0000');
/*!40000 ALTER TABLE `no_of_install_same_for_all_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offering_fund`
--

DROP TABLE IF EXISTS `offering_fund`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `offering_fund` (
  `offering_fund_id` smallint(6) NOT NULL,
  `fund_id` smallint(6) default NULL,
  `prd_offering_id` smallint(6) default NULL,
  PRIMARY KEY  (`offering_fund_id`),
  KEY `fund_id` (`fund_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `offering_fund_ibfk_1` FOREIGN KEY (`fund_id`) REFERENCES `fund` (`fund_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `offering_fund_ibfk_2` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `offering_fund`
--

LOCK TABLES `offering_fund` WRITE;
/*!40000 ALTER TABLE `offering_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `offering_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office` (
  `office_id` smallint(6) NOT NULL auto_increment,
  `global_office_num` varchar(100) NOT NULL,
  `office_level_id` smallint(6) NOT NULL,
  `search_id` varchar(100) NOT NULL,
  `max_child_count` int(11) NOT NULL,
  `local_remote_flag` smallint(6) NOT NULL,
  `display_name` varchar(200) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `office_short_name` varchar(4) NOT NULL,
  `parent_office_id` smallint(6) default NULL,
  `status_id` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  `office_code_id` smallint(6) default NULL,
  PRIMARY KEY  (`office_id`),
  UNIQUE KEY `global_office_num` (`global_office_num`),
  UNIQUE KEY `office_global_idx` (`global_office_num`),
  KEY `office_level_id` (`office_level_id`),
  KEY `parent_office_id` (`parent_office_id`),
  KEY `status_id` (`status_id`),
  KEY `office_code_id` (`office_code_id`),
  CONSTRAINT `office_ibfk_1` FOREIGN KEY (`office_level_id`) REFERENCES `office_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_ibfk_2` FOREIGN KEY (`parent_office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `office_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_ibfk_4` FOREIGN KEY (`office_code_id`) REFERENCES `office_code` (`code_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
INSERT INTO `office` VALUES (1,'0001',1,'1.1.',2,1,'Mifos HO ',NULL,NULL,NULL,NULL,'MIF1',NULL,1,1,NULL),(2,'0002',5,'1.1.1.',0,1,'BranchOfficeone',1,'2011-03-21',1,'2011-03-23','BO1',1,1,1,NULL),(3,'0003',5,'1.1.2.',0,1,'BranchOfficetwo',1,'2011-03-21',1,'2011-03-23','BO2',1,1,1,NULL),(4,'0004',5,'1.1.3.',0,1,'BranchOfficethree',1,'2011-03-21',1,'2011-03-23','bo3',1,1,1,NULL),(5,'0005',5,'1.1.4.',0,1,'BranchOfficefour',1,'2011-03-21',1,'2011-03-29','bo4',1,1,1,NULL),(6,'0006',5,'1.1.5.',0,1,'BranchOfficefive',1,'2011-03-23',NULL,NULL,'bo5',1,1,0,NULL),(7,'0007',5,'1.1.6.',0,1,'BranchOfficesix',1,'2011-03-23',NULL,NULL,'bo6',1,1,0,NULL),(8,'0008',5,'1.1.7.',0,1,'BranchOfficeseven',1,'2011-03-23',NULL,NULL,'bo7',1,1,0,NULL),(9,'0009',5,'1.1.8.',0,1,'BranchOfficeeight',1,'2011-03-23',NULL,NULL,'bo8',1,1,0,NULL),(10,'0010',5,'1.1.9.',0,1,'BranchOfficenine',1,'2011-03-23',NULL,NULL,'bo9',1,1,0,NULL),(11,'0011',5,'1.1.10.',0,1,'BranchOfficeTen',1,'2011-03-23',NULL,NULL,'bo10',1,1,0,NULL);
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_action_payment_type`
--

DROP TABLE IF EXISTS `office_action_payment_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_action_payment_type` (
  `office_id` smallint(6) default NULL,
  `prd_type_id` smallint(6) default NULL,
  `account_action_id` smallint(6) NOT NULL,
  `payment_type_id` smallint(6) default NULL,
  KEY `account_action_id` (`account_action_id`),
  KEY `office_id` (`office_id`),
  KEY `payment_type_id` (`payment_type_id`),
  KEY `prd_type_id` (`prd_type_id`),
  CONSTRAINT `office_action_payment_type_ibfk_1` FOREIGN KEY (`account_action_id`) REFERENCES `account_action` (`account_action_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_action_payment_type_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_action_payment_type_ibfk_3` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_action_payment_type_ibfk_4` FOREIGN KEY (`prd_type_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_action_payment_type`
--

LOCK TABLES `office_action_payment_type` WRITE;
/*!40000 ALTER TABLE `office_action_payment_type` DISABLE KEYS */;
INSERT INTO `office_action_payment_type` VALUES (NULL,NULL,1,NULL),(NULL,NULL,2,NULL),(NULL,NULL,3,NULL),(NULL,NULL,4,NULL),(NULL,NULL,5,NULL);
/*!40000 ALTER TABLE `office_action_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_address`
--

DROP TABLE IF EXISTS `office_address`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_address` (
  `office_address_id` smallint(6) NOT NULL auto_increment,
  `office_id` smallint(6) NOT NULL,
  `address_1` varchar(200) default NULL,
  `address_2` varchar(200) default NULL,
  `address_3` varchar(200) default NULL,
  `city` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `zip` varchar(20) default NULL,
  `telephone` varchar(20) default NULL,
  PRIMARY KEY  (`office_address_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `office_address_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_address`
--

LOCK TABLES `office_address` WRITE;
/*!40000 ALTER TABLE `office_address` DISABLE KEYS */;
INSERT INTO `office_address` VALUES (1,2,'BO1 office','','','','','','',''),(2,3,'bo2','','','','','','',''),(3,4,'BO3','','','','','','',''),(4,5,'','','','','','','',''),(5,6,'','','','','','','',''),(6,7,'','','','','','','',''),(7,8,'','','','','','','',''),(8,9,'','','','','','','',''),(9,10,'','','','','','','',''),(10,11,'','','','','','','','');
/*!40000 ALTER TABLE `office_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_code`
--

DROP TABLE IF EXISTS `office_code`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_code` (
  `code_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`code_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `office_code_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_code`
--

LOCK TABLES `office_code` WRITE;
/*!40000 ALTER TABLE `office_code` DISABLE KEYS */;
INSERT INTO `office_code` VALUES (1,111),(2,112);
/*!40000 ALTER TABLE `office_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_custom_field`
--

DROP TABLE IF EXISTS `office_custom_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_custom_field` (
  `office_custom_field_id` int(11) NOT NULL auto_increment,
  `office_id` smallint(6) NOT NULL,
  `field_id` smallint(6) NOT NULL,
  `field_value` varchar(200) default NULL,
  PRIMARY KEY  (`office_custom_field_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `office_custom_field_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_custom_field`
--

LOCK TABLES `office_custom_field` WRITE;
/*!40000 ALTER TABLE `office_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_hierarchy`
--

DROP TABLE IF EXISTS `office_hierarchy`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_hierarchy` (
  `hierarchy_id` int(11) NOT NULL auto_increment,
  `parent_id` smallint(6) NOT NULL,
  `office_id` smallint(6) default NULL,
  `status` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`hierarchy_id`),
  KEY `parent_id` (`parent_id`),
  KEY `updated_by` (`updated_by`),
  KEY `office_hierarchy_idx` (`office_id`,`status`),
  CONSTRAINT `office_hierarchy_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_hierarchy_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_hierarchy_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_hierarchy`
--

LOCK TABLES `office_hierarchy` WRITE;
/*!40000 ALTER TABLE `office_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_holiday`
--

DROP TABLE IF EXISTS `office_holiday`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_holiday` (
  `office_id` smallint(6) NOT NULL default '0',
  `holiday_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`office_id`,`holiday_id`),
  KEY `holiday_id` (`holiday_id`),
  CONSTRAINT `office_holiday_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `office_holiday_ibfk_2` FOREIGN KEY (`holiday_id`) REFERENCES `holiday` (`holiday_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_holiday`
--

LOCK TABLES `office_holiday` WRITE;
/*!40000 ALTER TABLE `office_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_level`
--

DROP TABLE IF EXISTS `office_level`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_level` (
  `level_id` smallint(6) NOT NULL,
  `parent_level_id` smallint(6) default NULL,
  `level_name_id` smallint(6) default NULL,
  `interaction_flag` smallint(6) default NULL,
  `configured` smallint(6) NOT NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`level_id`),
  KEY `parent_level_id` (`parent_level_id`),
  CONSTRAINT `office_level_ibfk_1` FOREIGN KEY (`parent_level_id`) REFERENCES `office_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_level`
--

LOCK TABLES `office_level` WRITE;
/*!40000 ALTER TABLE `office_level` DISABLE KEYS */;
INSERT INTO `office_level` VALUES (1,NULL,104,0,1,NULL),(2,1,105,0,1,NULL),(3,2,106,0,1,NULL),(4,3,107,0,1,NULL),(5,4,108,1,1,NULL);
/*!40000 ALTER TABLE `office_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_status`
--

DROP TABLE IF EXISTS `office_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `office_status` (
  `status_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`status_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `office_status_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `office_status`
--

LOCK TABLES `office_status` WRITE;
/*!40000 ALTER TABLE `office_status` DISABLE KEYS */;
INSERT INTO `office_status` VALUES (1,15),(2,16);
/*!40000 ALTER TABLE `office_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `original_loan_fee_schedule`
--

DROP TABLE IF EXISTS `original_loan_fee_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `original_loan_fee_schedule` (
  `account_fees_detail_id` int(11) NOT NULL auto_increment,
  `id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `fee_id` smallint(6) NOT NULL,
  `account_fee_id` int(11) NOT NULL,
  `amount` decimal(21,4) default NULL,
  `amount_currency_id` smallint(6) default NULL,
  `amount_paid` decimal(21,4) NOT NULL,
  `amount_paid_currency_id` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`account_fees_detail_id`),
  KEY `id` (`id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `amount_paid_currency_id` (`amount_paid_currency_id`),
  KEY `fee_id` (`fee_id`),
  KEY `account_fee_id` (`account_fee_id`),
  CONSTRAINT `original_loan_fee_schedule_ibfk_1` FOREIGN KEY (`id`) REFERENCES `original_loan_schedule` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_fee_schedule_ibfk_2` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_fee_schedule_ibfk_3` FOREIGN KEY (`amount_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_fee_schedule_ibfk_4` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`),
  CONSTRAINT `original_loan_fee_schedule_ibfk_5` FOREIGN KEY (`account_fee_id`) REFERENCES `account_fees` (`account_fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `original_loan_fee_schedule`
--

LOCK TABLES `original_loan_fee_schedule` WRITE;
/*!40000 ALTER TABLE `original_loan_fee_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `original_loan_fee_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `original_loan_schedule`
--

DROP TABLE IF EXISTS `original_loan_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `original_loan_schedule` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `action_date` date default NULL,
  `principal` decimal(21,4) NOT NULL,
  `principal_currency_id` smallint(6) default NULL,
  `interest` decimal(21,4) NOT NULL,
  `interest_currency_id` smallint(6) default NULL,
  `penalty` decimal(21,4) NOT NULL,
  `penalty_currency_id` smallint(6) default NULL,
  `misc_fees` decimal(21,4) default NULL,
  `misc_fees_currency_id` smallint(6) default NULL,
  `misc_fees_paid` decimal(21,4) default NULL,
  `misc_fees_paid_currency_id` smallint(6) default NULL,
  `misc_penalty` decimal(21,4) default NULL,
  `misc_penalty_currency_id` smallint(6) default NULL,
  `misc_penalty_paid` decimal(21,4) default NULL,
  `misc_penalty_paid_currency_id` smallint(6) default NULL,
  `principal_paid` decimal(21,4) default NULL,
  `principal_paid_currency_id` smallint(6) default NULL,
  `interest_paid` decimal(21,4) default NULL,
  `interest_paid_currency_id` smallint(6) default NULL,
  `penalty_paid` decimal(21,4) default NULL,
  `penalty_paid_currency_id` smallint(6) default NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date default NULL,
  `parent_flag` smallint(6) default NULL,
  `version_no` int(11) NOT NULL,
  `extra_interest` decimal(21,4) default NULL,
  `extra_interest_currency_id` smallint(6) default NULL,
  `extra_interest_paid` decimal(21,4) default NULL,
  `extra_interest_paid_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
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
  CONSTRAINT `original_loan_schedule_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_3` FOREIGN KEY (`principal_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_4` FOREIGN KEY (`interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_5` FOREIGN KEY (`penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_6` FOREIGN KEY (`misc_fees_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_7` FOREIGN KEY (`misc_fees_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_8` FOREIGN KEY (`misc_penalty_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_9` FOREIGN KEY (`principal_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_10` FOREIGN KEY (`interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_11` FOREIGN KEY (`penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_12` FOREIGN KEY (`misc_penalty_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_13` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_14` FOREIGN KEY (`extra_interest_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `original_loan_schedule_ibfk_15` FOREIGN KEY (`extra_interest_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `original_loan_schedule`
--

LOCK TABLES `original_loan_schedule` WRITE;
/*!40000 ALTER TABLE `original_loan_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `original_loan_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `payment_type` (
  `payment_type_id` smallint(6) NOT NULL auto_increment,
  `payment_type_lookup_id` int(11) default NULL,
  PRIMARY KEY  (`payment_type_id`),
  KEY `payment_type_lookup_id` (`payment_type_lookup_id`),
  CONSTRAINT `payment_type_ibfk_1` FOREIGN KEY (`payment_type_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `payment_type`
--

LOCK TABLES `payment_type` WRITE;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` VALUES (1,177),(2,179),(3,180);
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penalty`
--

DROP TABLE IF EXISTS `penalty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `penalty` (
  `penalty_id` smallint(6) NOT NULL,
  `global_penalty_num` varchar(100) default NULL,
  `penalty_type` varchar(100) default NULL,
  `office_id` smallint(6) default NULL,
  `category_id` smallint(6) default NULL,
  `glcode_id` smallint(6) NOT NULL,
  `lookup_id` int(11) default NULL,
  `rate` decimal(13,10) NOT NULL,
  `formula` varchar(100) default NULL,
  PRIMARY KEY  (`penalty_id`),
  KEY `category_id` (`category_id`),
  KEY `glcode_id` (`glcode_id`),
  KEY `lookup_id` (`lookup_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `penalty_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_type` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `penalty_ibfk_2` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `penalty_ibfk_3` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `penalty_ibfk_4` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `penalty`
--

LOCK TABLES `penalty` WRITE;
/*!40000 ALTER TABLE `penalty` DISABLE KEYS */;
/*!40000 ALTER TABLE `penalty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel` (
  `personnel_id` smallint(6) NOT NULL auto_increment,
  `level_id` smallint(6) NOT NULL,
  `global_personnel_num` varchar(100) default NULL,
  `office_id` smallint(6) default NULL,
  `title` int(11) default NULL,
  `personnel_status` smallint(6) default NULL,
  `preferred_locale` smallint(6) default NULL,
  `search_id` varchar(100) default NULL,
  `max_child_count` int(11) default NULL,
  `password` tinyblob,
  `login_name` varchar(200) default NULL,
  `email_id` varchar(255) default NULL,
  `password_changed` smallint(6) NOT NULL,
  `display_name` varchar(200) default NULL,
  `created_by` smallint(6) NOT NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `last_login` date default NULL,
  `locked` smallint(6) NOT NULL,
  `no_of_tries` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`personnel_id`),
  UNIQUE KEY `personnel_global_idx` (`global_personnel_num`),
  UNIQUE KEY `personnel_search_idx` (`search_id`),
  UNIQUE KEY `personnel_login_idx` (`login_name`),
  KEY `created_by` (`created_by`),
  KEY `level_id` (`level_id`),
  KEY `preferred_locale` (`preferred_locale`),
  KEY `title` (`title`),
  KEY `updated_by` (`updated_by`),
  KEY `personnel_office_idx` (`office_id`),
  CONSTRAINT `personnel_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_ibfk_3` FOREIGN KEY (`level_id`) REFERENCES `personnel_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_ibfk_4` FOREIGN KEY (`preferred_locale`) REFERENCES `supported_locale` (`locale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_ibfk_5` FOREIGN KEY (`title`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_ibfk_6` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel`
--

LOCK TABLES `personnel` WRITE;
/*!40000 ALTER TABLE `personnel` DISABLE KEYS */;
INSERT INTO `personnel` VALUES (1,2,'1',1,1,1,1,NULL,1,'\"d#0aM2NjdQS8','mifos',NULL,1,'mifos',1,NULL,1,NULL,'2011-04-01',0,0,7),(2,1,'0002-00002',2,633,1,1,NULL,NULL,'3dIsq{`ܵ#Dt','lo1','',0,'Loanofficerone Loanofficerone',1,'2011-03-21',1,'2011-03-31',NULL,0,0,4),(3,1,'0003-00003',2,633,1,1,NULL,NULL,'#=	UxpT|p2oo','lo2','',0,'Loanofficertwo Loanofficertwo',1,'2011-03-21',1,'2011-03-31',NULL,0,0,4),(4,1,'0004-00004',11,633,1,2,NULL,NULL,'Hh\0Љ3}6a< 9\Z=rm','lo3','',0,'Loanofficerthree Loanofficerthree',1,'2011-03-21',1,'2011-03-24',NULL,0,0,3),(5,1,'0005-00005',11,634,1,1,NULL,NULL,'~;*W({\\/nfzv','lo4','',0,'Loanofficerfour Loanofficerfour',1,'2011-03-21',1,'2011-03-23',NULL,0,0,3),(6,1,'0003-00006',3,NULL,1,1,NULL,NULL,',Aϭt޹HQ\r\n2ܡ`','lo5','',0,'Loanofficerfive Loanofficerfive',1,'2011-04-01',NULL,NULL,NULL,0,0,1),(7,1,'0003-00007',3,NULL,1,1,NULL,NULL,'r;. UM@!n3$lj','lo7','',0,'Loanofficerseven Loanofficerseven',1,'2011-04-01',NULL,NULL,NULL,0,0,1),(8,1,'0004-00008',4,NULL,1,1,NULL,NULL,'vo\'Sa)(nc >vq','lo8','',0,'Loanofficereight Loanofficereight',1,'2011-04-01',NULL,NULL,NULL,0,0,1);
/*!40000 ALTER TABLE `personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_custom_field`
--

DROP TABLE IF EXISTS `personnel_custom_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_custom_field` (
  `personnel_custom_field_id` int(11) NOT NULL auto_increment,
  `field_id` smallint(6) NOT NULL,
  `personnel_id` smallint(6) NOT NULL,
  `field_value` varchar(100) default NULL,
  PRIMARY KEY  (`personnel_custom_field_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `personnel_custom_field_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_custom_field_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `custom_field_definition` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_custom_field`
--

LOCK TABLES `personnel_custom_field` WRITE;
/*!40000 ALTER TABLE `personnel_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `personnel_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_details`
--

DROP TABLE IF EXISTS `personnel_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_details` (
  `personnel_id` smallint(6) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) default NULL,
  `second_last_name` varchar(100) default NULL,
  `last_name` varchar(100) default NULL,
  `government_id_number` varchar(50) default NULL,
  `dob` date NOT NULL,
  `marital_status` int(11) default NULL,
  `gender` int(11) NOT NULL,
  `date_of_joining_mfi` date default NULL,
  `date_of_joining_branch` date default NULL,
  `date_of_leaving_branch` date default NULL,
  `address_1` varchar(200) default NULL,
  `address_2` varchar(200) default NULL,
  `address_3` varchar(200) default NULL,
  `city` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `postal_code` varchar(100) default NULL,
  `telephone` varchar(20) default NULL,
  KEY `personnel_id` (`personnel_id`),
  KEY `gender` (`gender`),
  KEY `marital_status` (`marital_status`),
  CONSTRAINT `personnel_details_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_details_ibfk_2` FOREIGN KEY (`gender`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_details_ibfk_3` FOREIGN KEY (`marital_status`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_details`
--

LOCK TABLES `personnel_details` WRITE;
/*!40000 ALTER TABLE `personnel_details` DISABLE KEYS */;
INSERT INTO `personnel_details` VALUES (1,'Mifos',NULL,NULL,'MFI','123','1979-12-12',NULL,50,NULL,NULL,NULL,'Bangalore',NULL,NULL,'Bangalore','Bangalore','Bangalore',NULL,NULL),(2,'Loanofficerone','','','Loanofficerone','','1970-03-03',630,49,'2011-03-21','2011-03-31',NULL,'','','','','','','',''),(3,'Loanofficertwo','','','Loanofficertwo','','1980-04-04',NULL,49,'2011-03-21','2011-03-31',NULL,'','','','','','','',''),(4,'Loanofficerthree','','','Loanofficerthree','','1979-05-05',NULL,49,'2011-03-21','2011-03-24',NULL,'','','','','','','',''),(5,'Loanofficerfour','','','Loanofficerfour','','1980-06-06',NULL,49,'2011-03-21','2011-03-23',NULL,'','','','','','','',''),(6,'Loanofficerfive','','','Loanofficerfive','','2011-04-01',630,49,'2011-04-01','2011-04-01',NULL,'','','','','','','',''),(7,'Loanofficerseven','','','Loanofficerseven','','1980-02-02',NULL,49,'2011-04-01','2011-04-01',NULL,'','','','','','','',''),(8,'Loanofficereight','','','Loanofficereight','','1980-02-02',630,49,'2011-04-01','2011-04-01',NULL,'','','','','','','','');
/*!40000 ALTER TABLE `personnel_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_hierarchy`
--

DROP TABLE IF EXISTS `personnel_hierarchy`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_hierarchy` (
  `hierarchy_id` int(11) NOT NULL,
  `parent_id` smallint(6) NOT NULL,
  `personnel_id` smallint(6) default NULL,
  `status` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date NOT NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`hierarchy_id`),
  KEY `parent_id` (`parent_id`),
  KEY `updated_by` (`updated_by`),
  KEY `personnel_hierarchy_idx` (`personnel_id`,`status`),
  CONSTRAINT `personnel_hierarchy_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_hierarchy_ibfk_2` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_hierarchy_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_hierarchy`
--

LOCK TABLES `personnel_hierarchy` WRITE;
/*!40000 ALTER TABLE `personnel_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `personnel_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_level`
--

DROP TABLE IF EXISTS `personnel_level`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_level` (
  `level_id` smallint(6) NOT NULL,
  `level_name_id` int(11) NOT NULL,
  `parent_level_id` smallint(6) default NULL,
  `interaction_flag` smallint(6) default NULL,
  PRIMARY KEY  (`level_id`),
  KEY `parent_level_id` (`parent_level_id`),
  KEY `level_name_id` (`level_name_id`),
  CONSTRAINT `personnel_level_ibfk_1` FOREIGN KEY (`parent_level_id`) REFERENCES `personnel_level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_level_ibfk_2` FOREIGN KEY (`level_name_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_level`
--

LOCK TABLES `personnel_level` WRITE;
/*!40000 ALTER TABLE `personnel_level` DISABLE KEYS */;
INSERT INTO `personnel_level` VALUES (1,60,1,0),(2,61,1,0);
/*!40000 ALTER TABLE `personnel_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_movement`
--

DROP TABLE IF EXISTS `personnel_movement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_movement` (
  `personnel_movement_id` smallint(6) NOT NULL auto_increment,
  `personnel_id` smallint(6) default NULL,
  `office_id` smallint(6) NOT NULL,
  `status` smallint(6) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`personnel_movement_id`),
  KEY `updated_by` (`updated_by`),
  KEY `office_id` (`office_id`),
  KEY `personnel_movement_idx` (`personnel_id`),
  CONSTRAINT `personnel_movement_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_movement_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_movement_ibfk_3` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_movement`
--

LOCK TABLES `personnel_movement` WRITE;
/*!40000 ALTER TABLE `personnel_movement` DISABLE KEYS */;
INSERT INTO `personnel_movement` VALUES (1,5,5,0,'2011-03-21','2011-03-23',1,'2011-03-23'),(2,5,11,1,'2011-03-23',NULL,NULL,NULL),(3,2,11,0,'2011-03-23','2011-03-31',1,'2011-03-31'),(4,2,2,0,'2011-03-21','2011-03-23',1,'2011-03-23'),(5,3,11,0,'2011-03-23','2011-03-31',1,'2011-03-31'),(6,3,3,0,'2011-03-21','2011-03-23',1,'2011-03-23'),(7,4,4,0,'2011-03-21','2011-03-24',1,'2011-03-24'),(8,4,11,1,'2011-03-24',NULL,NULL,NULL),(9,3,2,1,'2011-03-31',NULL,NULL,NULL),(10,2,2,1,'2011-03-31',NULL,NULL,NULL);
/*!40000 ALTER TABLE `personnel_movement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_notes`
--

DROP TABLE IF EXISTS `personnel_notes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_notes` (
  `comment_id` int(11) NOT NULL auto_increment,
  `personnel_id` smallint(6) NOT NULL,
  `comment_date` date NOT NULL,
  `comments` varchar(500) NOT NULL,
  `officer_id` smallint(6) default NULL,
  PRIMARY KEY  (`comment_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `officer_id` (`officer_id`),
  CONSTRAINT `personnel_notes_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_notes_ibfk_2` FOREIGN KEY (`officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_notes`
--

LOCK TABLES `personnel_notes` WRITE;
/*!40000 ALTER TABLE `personnel_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `personnel_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_role`
--

DROP TABLE IF EXISTS `personnel_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_role` (
  `personnel_role_id` int(11) NOT NULL auto_increment,
  `role_id` smallint(6) NOT NULL,
  `personnel_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`personnel_role_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `personnel_role_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personnel_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_role`
--

LOCK TABLES `personnel_role` WRITE;
/*!40000 ALTER TABLE `personnel_role` DISABLE KEYS */;
INSERT INTO `personnel_role` VALUES (1,1,1),(10,2,5),(13,2,4),(14,2,3),(15,2,2),(16,1,6),(17,1,8);
/*!40000 ALTER TABLE `personnel_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_status`
--

DROP TABLE IF EXISTS `personnel_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personnel_status` (
  `personnel_status_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`personnel_status_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `personnel_status_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personnel_status`
--

LOCK TABLES `personnel_status` WRITE;
/*!40000 ALTER TABLE `personnel_status` DISABLE KEYS */;
INSERT INTO `personnel_status` VALUES (1,152),(2,153);
/*!40000 ALTER TABLE `personnel_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `position` (
  `position_id` int(11) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`position_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,186),(2,187),(3,188),(4,216);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_likelihoods`
--

DROP TABLE IF EXISTS `ppi_likelihoods`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ppi_likelihoods` (
  `likelihood_id` int(11) NOT NULL auto_increment,
  `survey_id` int(11) NOT NULL,
  `score_from` int(11) NOT NULL,
  `score_to` int(11) NOT NULL,
  `bottom_half_below` decimal(21,4) NOT NULL,
  `top_half_below` decimal(21,4) NOT NULL,
  `likelihood_order` int(11) NOT NULL,
  PRIMARY KEY  (`likelihood_id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `ppi_likelihoods_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`survey_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ppi_likelihoods`
--

LOCK TABLES `ppi_likelihoods` WRITE;
/*!40000 ALTER TABLE `ppi_likelihoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_likelihoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_survey`
--

DROP TABLE IF EXISTS `ppi_survey`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ppi_survey` (
  `country_id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  `very_poor_min` int(11) NOT NULL,
  `very_poor_max` int(11) NOT NULL,
  `poor_min` int(11) NOT NULL,
  `poor_max` int(11) NOT NULL,
  `at_risk_min` int(11) NOT NULL,
  `at_risk_max` int(11) NOT NULL,
  `non_poor_min` int(11) NOT NULL,
  `non_poor_max` int(11) NOT NULL,
  PRIMARY KEY  (`country_id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `ppi_survey_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`survey_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ppi_survey`
--

LOCK TABLES `ppi_survey` WRITE;
/*!40000 ALTER TABLE `ppi_survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_survey_instance`
--

DROP TABLE IF EXISTS `ppi_survey_instance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ppi_survey_instance` (
  `instance_id` int(11) NOT NULL,
  `bottom_half_below` decimal(21,4) default NULL,
  `top_half_below` decimal(21,4) default NULL,
  PRIMARY KEY  (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ppi_survey_instance`
--

LOCK TABLES `ppi_survey_instance` WRITE;
/*!40000 ALTER TABLE `ppi_survey_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_survey_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_applicable_master`
--

DROP TABLE IF EXISTS `prd_applicable_master`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_applicable_master` (
  `prd_applicable_master_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`prd_applicable_master_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `prd_applicable_master_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_applicable_master`
--

LOCK TABLES `prd_applicable_master` WRITE;
/*!40000 ALTER TABLE `prd_applicable_master` DISABLE KEYS */;
INSERT INTO `prd_applicable_master` VALUES (1,68),(2,69),(3,70);
/*!40000 ALTER TABLE `prd_applicable_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_category`
--

DROP TABLE IF EXISTS `prd_category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_category` (
  `prd_category_id` smallint(6) NOT NULL auto_increment,
  `prd_type_id` smallint(6) NOT NULL,
  `global_prd_offering_num` varchar(50) NOT NULL,
  `prd_category_name` varchar(100) NOT NULL,
  `created_date` date default NULL,
  `created_by` int(11) default NULL,
  `office_id` smallint(6) default NULL,
  `updated_by` int(11) default NULL,
  `udpated_date` date default NULL,
  `state` smallint(6) NOT NULL,
  `description` varchar(500) default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`prd_category_id`),
  KEY `prd_type_id` (`prd_type_id`),
  CONSTRAINT `prd_category_ibfk_1` FOREIGN KEY (`prd_type_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_category`
--

LOCK TABLES `prd_category` WRITE;
/*!40000 ALTER TABLE `prd_category` DISABLE KEYS */;
INSERT INTO `prd_category` VALUES (1,1,'1-1','Other',NULL,NULL,NULL,NULL,NULL,1,NULL,1),(2,2,'1-2','Other',NULL,NULL,NULL,NULL,NULL,1,NULL,1);
/*!40000 ALTER TABLE `prd_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_category_status`
--

DROP TABLE IF EXISTS `prd_category_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_category_status` (
  `prd_category_status_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`prd_category_status_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `prd_category_status_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_category_status`
--

LOCK TABLES `prd_category_status` WRITE;
/*!40000 ALTER TABLE `prd_category_status` DISABLE KEYS */;
INSERT INTO `prd_category_status` VALUES (2,113),(1,114);
/*!40000 ALTER TABLE `prd_category_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_checklist`
--

DROP TABLE IF EXISTS `prd_checklist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_checklist` (
  `checklist_id` smallint(6) NOT NULL,
  `prd_type_id` smallint(6) default NULL,
  `account_status` smallint(6) NOT NULL,
  PRIMARY KEY  (`checklist_id`),
  KEY `account_status` (`account_status`),
  KEY `prd_type_id` (`prd_type_id`),
  CONSTRAINT `prd_checklist_ibfk_1` FOREIGN KEY (`account_status`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_checklist_ibfk_2` FOREIGN KEY (`checklist_id`) REFERENCES `checklist` (`checklist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_checklist_ibfk_3` FOREIGN KEY (`prd_type_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_checklist`
--

LOCK TABLES `prd_checklist` WRITE;
/*!40000 ALTER TABLE `prd_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `prd_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_fee_frequency`
--

DROP TABLE IF EXISTS `prd_fee_frequency`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_fee_frequency` (
  `prdoffering_fee_id` smallint(6) NOT NULL,
  `fee_id` smallint(6) default NULL,
  `frequency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`prdoffering_fee_id`),
  KEY `fee_id` (`fee_id`),
  KEY `frequency_id` (`frequency_id`),
  CONSTRAINT `prd_fee_frequency_ibfk_1` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_fee_frequency_ibfk_2` FOREIGN KEY (`prdoffering_fee_id`) REFERENCES `prd_offering_fees` (`prd_offering_fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_fee_frequency_ibfk_3` FOREIGN KEY (`frequency_id`) REFERENCES `recurrence_type` (`recurrence_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_fee_frequency`
--

LOCK TABLES `prd_fee_frequency` WRITE;
/*!40000 ALTER TABLE `prd_fee_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `prd_fee_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_offering`
--

DROP TABLE IF EXISTS `prd_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_offering` (
  `prd_offering_id` smallint(6) NOT NULL auto_increment,
  `prd_applicable_master_id` smallint(6) NOT NULL,
  `global_prd_offering_num` varchar(50) NOT NULL,
  `prd_category_id` smallint(6) NOT NULL,
  `prd_type_id` smallint(6) default NULL,
  `office_id` smallint(6) default NULL,
  `start_date` date NOT NULL,
  `end_date` date default NULL,
  `glcode_id` smallint(6) default NULL,
  `prd_offering_name` varchar(50) NOT NULL,
  `prd_offering_short_name` varchar(50) NOT NULL,
  `offering_status_id` smallint(6) default NULL,
  `description` varchar(200) default NULL,
  `created_date` date NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_date` date default NULL,
  `updated_by` int(11) default NULL,
  `version_no` int(11) default NULL,
  `prd_mix_flag` smallint(6) default NULL,
  `currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`prd_offering_id`),
  UNIQUE KEY `prd_offering_global_idx` (`global_prd_offering_num`),
  UNIQUE KEY `prd_offering_name_idx` (`prd_offering_name`),
  UNIQUE KEY `prd_offering_short_name_idx` (`prd_offering_short_name`),
  KEY `glcode_id` (`glcode_id`),
  KEY `prd_category_id` (`prd_category_id`),
  KEY `offering_status_id` (`offering_status_id`),
  KEY `prd_applicable_master_id` (`prd_applicable_master_id`),
  KEY `currency_id` (`currency_id`),
  KEY `prd_offering_office_idx` (`office_id`),
  KEY `prd_type_idx` (`prd_type_id`),
  CONSTRAINT `prd_offering_ibfk_1` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_3` FOREIGN KEY (`prd_category_id`) REFERENCES `prd_category` (`prd_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_4` FOREIGN KEY (`offering_status_id`) REFERENCES `prd_status` (`offering_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_5` FOREIGN KEY (`prd_type_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_6` FOREIGN KEY (`prd_applicable_master_id`) REFERENCES `prd_applicable_master` (`prd_applicable_master_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_ibfk_7` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_offering`
--

LOCK TABLES `prd_offering` WRITE;
/*!40000 ALTER TABLE `prd_offering` DISABLE KEYS */;
INSERT INTO `prd_offering` VALUES (1,1,'1-001',1,1,1,'2011-03-22',NULL,NULL,'Commodity Loan ','COML',1,'','2011-03-22',1,'2011-04-01',1,3,NULL,2),(2,1,'1-002',1,1,1,'2011-03-24',NULL,NULL,'MONTHLY LOAN','MONL',1,'','2011-03-24',1,NULL,NULL,1,NULL,2),(3,1,'1-003',1,1,1,'2011-04-18',NULL,NULL,'DECLINE_BALANCE','DECB',1,'','2011-04-18',1,NULL,NULL,0,NULL,2),(4,1,'1-004',1,1,1,'2011-04-18',NULL,NULL,'DECLINE_MONTH','DECM',1,'','2011-04-18',1,'2011-04-19',1,1,NULL,2),(5,2,'1-005',1,1,1,'2011-04-19',NULL,NULL,'GROUP_LOAN','GRPL',1,'','2011-04-19',1,NULL,NULL,0,NULL,2);
/*!40000 ALTER TABLE `prd_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_offering_fees`
--

DROP TABLE IF EXISTS `prd_offering_fees`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_offering_fees` (
  `prd_offering_fee_id` smallint(6) NOT NULL auto_increment,
  `fee_id` smallint(6) default NULL,
  `prd_offering_id` smallint(6) default NULL,
  PRIMARY KEY  (`prd_offering_fee_id`),
  KEY `fee_id` (`fee_id`),
  KEY `prd_offering_fee_idx` (`prd_offering_id`,`fee_id`),
  CONSTRAINT `prd_offering_fees_ibfk_1` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_fees_ibfk_2` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_offering_fees`
--

LOCK TABLES `prd_offering_fees` WRITE;
/*!40000 ALTER TABLE `prd_offering_fees` DISABLE KEYS */;
/*!40000 ALTER TABLE `prd_offering_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_offering_meeting`
--

DROP TABLE IF EXISTS `prd_offering_meeting`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_offering_meeting` (
  `prd_offering_meeting_id` smallint(6) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `prd_meeting_id` int(11) default NULL,
  `prd_offering_meeting_type_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`prd_offering_meeting_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  KEY `prd_meeting_id` (`prd_meeting_id`),
  KEY `prd_offering_meeting_type_id` (`prd_offering_meeting_type_id`),
  CONSTRAINT `prd_offering_meeting_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`),
  CONSTRAINT `prd_offering_meeting_ibfk_2` FOREIGN KEY (`prd_meeting_id`) REFERENCES `meeting` (`meeting_id`),
  CONSTRAINT `prd_offering_meeting_ibfk_3` FOREIGN KEY (`prd_offering_meeting_type_id`) REFERENCES `meeting_type` (`meeting_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_offering_meeting`
--

LOCK TABLES `prd_offering_meeting` WRITE;
/*!40000 ALTER TABLE `prd_offering_meeting` DISABLE KEYS */;
INSERT INTO `prd_offering_meeting` VALUES (1,1,1,1),(2,2,2,1),(3,3,3,1),(4,4,6,1),(5,5,5,1);
/*!40000 ALTER TABLE `prd_offering_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_offering_mix`
--

DROP TABLE IF EXISTS `prd_offering_mix`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_offering_mix` (
  `prd_offering_mix_id` int(11) NOT NULL auto_increment,
  `prd_offering_id` smallint(6) NOT NULL,
  `prd_offering_not_allowed_id` smallint(6) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`prd_offering_mix_id`),
  KEY `prd_offering_mix_prd_offering_id_1` (`prd_offering_id`),
  KEY `prd_offering_mix_prd_offering_id_2` (`prd_offering_not_allowed_id`),
  CONSTRAINT `prd_offering_mix_prd_offering_id_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_offering_mix_prd_offering_id_2` FOREIGN KEY (`prd_offering_not_allowed_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_offering_mix`
--

LOCK TABLES `prd_offering_mix` WRITE;
/*!40000 ALTER TABLE `prd_offering_mix` DISABLE KEYS */;
/*!40000 ALTER TABLE `prd_offering_mix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_offering_question_group`
--

DROP TABLE IF EXISTS `prd_offering_question_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_offering_question_group` (
  `prd_offering_id` smallint(6) NOT NULL,
  `question_group_id` int(11) NOT NULL,
  KEY `prd_offering_id` (`prd_offering_id`),
  KEY `question_group_id` (`question_group_id`),
  CONSTRAINT `prd_offering_question_group_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`),
  CONSTRAINT `prd_offering_question_group_ibfk_2` FOREIGN KEY (`question_group_id`) REFERENCES `question_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_offering_question_group`
--

LOCK TABLES `prd_offering_question_group` WRITE;
/*!40000 ALTER TABLE `prd_offering_question_group` DISABLE KEYS */;
INSERT INTO `prd_offering_question_group` VALUES (1,2),(2,2);
/*!40000 ALTER TABLE `prd_offering_question_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_state`
--

DROP TABLE IF EXISTS `prd_state`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_state` (
  `prd_state_id` smallint(6) NOT NULL auto_increment,
  `prd_state_lookup_id` int(11) default NULL,
  PRIMARY KEY  (`prd_state_id`),
  KEY `prd_state_lookup_id` (`prd_state_lookup_id`),
  CONSTRAINT `prd_state_ibfk_1` FOREIGN KEY (`prd_state_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_state`
--

LOCK TABLES `prd_state` WRITE;
/*!40000 ALTER TABLE `prd_state` DISABLE KEYS */;
INSERT INTO `prd_state` VALUES (1,115),(2,116);
/*!40000 ALTER TABLE `prd_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_status`
--

DROP TABLE IF EXISTS `prd_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_status` (
  `offering_status_id` smallint(6) NOT NULL auto_increment,
  `prd_state_id` smallint(6) NOT NULL,
  `prd_type_id` smallint(6) NOT NULL,
  `currently_in_use` smallint(6) NOT NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`offering_status_id`),
  KEY `prd_type_id` (`prd_type_id`),
  KEY `prd_state_id` (`prd_state_id`),
  CONSTRAINT `prd_status_ibfk_1` FOREIGN KEY (`prd_type_id`) REFERENCES `prd_type` (`prd_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prd_status_ibfk_2` FOREIGN KEY (`prd_state_id`) REFERENCES `prd_state` (`prd_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_status`
--

LOCK TABLES `prd_status` WRITE;
/*!40000 ALTER TABLE `prd_status` DISABLE KEYS */;
INSERT INTO `prd_status` VALUES (1,1,1,1,1),(2,1,2,1,1),(4,2,1,1,1),(5,2,2,1,1);
/*!40000 ALTER TABLE `prd_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prd_type`
--

DROP TABLE IF EXISTS `prd_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prd_type` (
  `prd_type_id` smallint(6) NOT NULL auto_increment,
  `prd_type_lookup_id` int(11) NOT NULL,
  `lateness_days` smallint(6) default NULL,
  `dormancy_days` smallint(6) default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`prd_type_id`),
  KEY `prd_type_lookup_id` (`prd_type_lookup_id`),
  CONSTRAINT `prd_type_ibfk_1` FOREIGN KEY (`prd_type_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prd_type`
--

LOCK TABLES `prd_type` WRITE;
/*!40000 ALTER TABLE `prd_type` DISABLE KEYS */;
INSERT INTO `prd_type` VALUES (1,54,10,1,1),(2,55,12,30,1);
/*!40000 ALTER TABLE `prd_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_offering_mandatory_savings`
--

DROP TABLE IF EXISTS `product_offering_mandatory_savings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `product_offering_mandatory_savings` (
  `product_offering_mandatory_savings_id` smallint(6) NOT NULL,
  `product_offering_mandatory_savings_type` smallint(6) default NULL,
  `prd_offering_id` smallint(6) default NULL,
  `product_offering_mandatory_savings_value` smallint(6) default NULL,
  `product_offering_mandatory_savings_range` smallint(6) default NULL,
  PRIMARY KEY  (`product_offering_mandatory_savings_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  CONSTRAINT `product_offering_mandatory_savings_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `product_offering_mandatory_savings`
--

LOCK TABLES `product_offering_mandatory_savings` WRITE;
/*!40000 ALTER TABLE `product_offering_mandatory_savings` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_offering_mandatory_savings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL auto_increment,
  `office_id` smallint(6) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  `glcode_id` smallint(6) default NULL,
  `program_name` varchar(100) default NULL,
  `start_date` date NOT NULL,
  `end_date` date default NULL,
  `confidentiality` smallint(6) default NULL,
  PRIMARY KEY  (`program_id`),
  KEY `glcode_id` (`glcode_id`),
  KEY `lookup_id` (`lookup_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `program_ibfk_1` FOREIGN KEY (`glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_ibfk_2` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_ibfk_3` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_fund`
--

DROP TABLE IF EXISTS `program_fund`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program_fund` (
  `program_fund_id` smallint(6) NOT NULL,
  `fund_id` smallint(6) default NULL,
  `program_id` int(11) default NULL,
  PRIMARY KEY  (`program_fund_id`),
  KEY `fund_id` (`fund_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `program_fund_ibfk_1` FOREIGN KEY (`fund_id`) REFERENCES `fund` (`fund_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_fund_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `program_fund`
--

LOCK TABLES `program_fund` WRITE;
/*!40000 ALTER TABLE `program_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_blob_triggers` (
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY  (`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_calendars` (
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY  (`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_cron_triggers` (
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) default NULL,
  PRIMARY KEY  (`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_fired_triggers` (
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `is_volatile` varchar(1) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) default NULL,
  `job_group` varchar(200) default NULL,
  `is_stateful` varchar(1) default NULL,
  `requests_recovery` varchar(1) default NULL,
  PRIMARY KEY  (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_job_details` (
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) default NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_volatile` varchar(1) NOT NULL,
  `is_stateful` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY  (`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_listeners`
--

DROP TABLE IF EXISTS `qrtz_job_listeners`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_job_listeners` (
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `job_listener` varchar(200) NOT NULL,
  PRIMARY KEY  (`job_name`,`job_group`,`job_listener`),
  CONSTRAINT `qrtz_job_listeners_ibfk_1` FOREIGN KEY (`job_name`, `job_group`) REFERENCES `qrtz_job_details` (`job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_job_listeners`
--

LOCK TABLES `qrtz_job_listeners` WRITE;
/*!40000 ALTER TABLE `qrtz_job_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_locks` (
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY  (`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` VALUES ('CALENDAR_ACCESS'),('JOB_ACCESS'),('MISFIRE_ACCESS'),('STATE_ACCESS'),('TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY  (`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_scheduler_state` (
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY  (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_simple_triggers` (
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY  (`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_trigger_listeners`
--

DROP TABLE IF EXISTS `qrtz_trigger_listeners`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_trigger_listeners` (
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `trigger_listener` varchar(200) NOT NULL,
  PRIMARY KEY  (`trigger_name`,`trigger_group`,`trigger_listener`),
  CONSTRAINT `qrtz_trigger_listeners_ibfk_1` FOREIGN KEY (`trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_trigger_listeners`
--

LOCK TABLES `qrtz_trigger_listeners` WRITE;
/*!40000 ALTER TABLE `qrtz_trigger_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_trigger_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `qrtz_triggers` (
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `is_volatile` varchar(1) NOT NULL,
  `description` varchar(250) default NULL,
  `next_fire_time` bigint(13) default NULL,
  `prev_fire_time` bigint(13) default NULL,
  `priority` int(11) default NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) default NULL,
  `calendar_name` varchar(200) default NULL,
  `misfire_instr` smallint(2) default NULL,
  `job_data` blob,
  PRIMARY KEY  (`trigger_name`,`trigger_group`),
  KEY `job_name` (`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`job_name`, `job_group`) REFERENCES `qrtz_job_details` (`job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_choice_tags`
--

DROP TABLE IF EXISTS `question_choice_tags`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_choice_tags` (
  `id` int(11) NOT NULL auto_increment,
  `choice_id` int(11) NOT NULL,
  `tag_text` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `choice_id` (`choice_id`,`tag_text`),
  CONSTRAINT `question_choice_tags_ibfk_1` FOREIGN KEY (`choice_id`) REFERENCES `question_choices` (`choice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_choice_tags`
--

LOCK TABLES `question_choice_tags` WRITE;
/*!40000 ALTER TABLE `question_choice_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_choice_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_choices`
--

DROP TABLE IF EXISTS `question_choices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_choices` (
  `choice_id` int(11) NOT NULL auto_increment,
  `question_id` int(11) NOT NULL,
  `choice_text` varchar(500) NOT NULL,
  `choice_order` int(11) NOT NULL,
  `ppi` varchar(1) NOT NULL,
  `ppi_points` int(11) default NULL,
  PRIMARY KEY  (`choice_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `question_choices_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_choices`
--

LOCK TABLES `question_choices` WRITE;
/*!40000 ALTER TABLE `question_choices` DISABLE KEYS */;
INSERT INTO `question_choices` VALUES (1,1,'Yes',0,'N',NULL),(2,1,'No',1,'N',NULL),(3,2,'Yes',0,'N',NULL),(4,2,'No',1,'N',NULL),(5,4,'Yes',0,'N',NULL),(6,4,'no',1,'N',NULL),(7,2,'Yes',0,'N',NULL),(8,2,'No',1,'N',NULL),(9,1,'Yes',0,'N',NULL),(10,1,'No',1,'N',NULL),(11,4,'Yes',0,'N',NULL),(12,4,'no',1,'N',NULL),(13,5,'Yes',0,'N',NULL),(14,5,'No',1,'N',NULL),(15,5,'Not applicable',2,'N',NULL),(16,6,'Yes',0,'N',NULL),(17,6,'No',1,'N',NULL),(18,7,'Yes',0,'N',NULL),(19,7,'No',1,'N',NULL),(20,7,'Not applicable',2,'N',NULL),(21,6,'Yes',0,'N',NULL),(22,6,'No',1,'N',NULL),(23,5,'Yes',0,'N',NULL),(24,5,'No',1,'N',NULL),(25,5,'Not applicable',2,'N',NULL),(26,7,'Yes',0,'N',NULL),(27,7,'No',1,'N',NULL),(28,7,'Not applicable',2,'N',NULL);
/*!40000 ALTER TABLE `question_choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_group`
--

DROP TABLE IF EXISTS `question_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_group` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(200) NOT NULL,
  `date_of_creation` date NOT NULL,
  `state` int(11) NOT NULL,
  `is_editable` tinyint(4) NOT NULL default '0',
  `is_ppi` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_group`
--

LOCK TABLES `question_group` WRITE;
/*!40000 ALTER TABLE `question_group` DISABLE KEYS */;
INSERT INTO `question_group` VALUES (1,'CreateClientQG','2011-04-15',1,1,0),(2,'CreateLoanQG','2011-04-15',0,1,0),(3,'CreateGroupQG','2011-04-13',1,1,0),(4,'CreateCenterQG','2011-04-15',1,1,0);
/*!40000 ALTER TABLE `question_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_group_event_sources`
--

DROP TABLE IF EXISTS `question_group_event_sources`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_group_event_sources` (
  `id` int(11) NOT NULL auto_increment,
  `question_group_id` int(11) NOT NULL,
  `event_source_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `question_group_id` (`question_group_id`),
  KEY `event_source_id` (`event_source_id`),
  CONSTRAINT `question_group_event_sources_ibfk_1` FOREIGN KEY (`question_group_id`) REFERENCES `question_group` (`id`),
  CONSTRAINT `question_group_event_sources_ibfk_2` FOREIGN KEY (`event_source_id`) REFERENCES `event_sources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_group_event_sources`
--

LOCK TABLES `question_group_event_sources` WRITE;
/*!40000 ALTER TABLE `question_group_event_sources` DISABLE KEYS */;
INSERT INTO `question_group_event_sources` VALUES (3,3,4),(5,1,1),(6,4,9),(8,2,2);
/*!40000 ALTER TABLE `question_group_event_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_group_instance`
--

DROP TABLE IF EXISTS `question_group_instance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_group_instance` (
  `id` int(11) NOT NULL auto_increment,
  `question_group_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `date_conducted` date NOT NULL,
  `completed_status` smallint(6) NOT NULL,
  `created_by` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  `event_source_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `question_group_id` (`question_group_id`),
  CONSTRAINT `question_group_instance_ibfk_1` FOREIGN KEY (`question_group_id`) REFERENCES `question_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_group_instance`
--

LOCK TABLES `question_group_instance` WRITE;
/*!40000 ALTER TABLE `question_group_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_group_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_group_response`
--

DROP TABLE IF EXISTS `question_group_response`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_group_response` (
  `id` int(11) NOT NULL auto_increment,
  `question_group_instance_id` int(11) NOT NULL,
  `sections_questions_id` int(11) NOT NULL,
  `response` varchar(500) NOT NULL,
  `tag` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `sections_questions_id` (`sections_questions_id`),
  KEY `question_group_instance_id` (`question_group_instance_id`),
  CONSTRAINT `question_group_response_ibfk_1` FOREIGN KEY (`sections_questions_id`) REFERENCES `sections_questions` (`id`),
  CONSTRAINT `question_group_response_ibfk_2` FOREIGN KEY (`question_group_instance_id`) REFERENCES `question_group_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_group_response`
--

LOCK TABLES `question_group_response` WRITE;
/*!40000 ALTER TABLE `question_group_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_group_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL auto_increment,
  `answer_type` int(11) NOT NULL,
  `question_state` int(11) NOT NULL,
  `question_text` varchar(1000) NOT NULL,
  `numeric_min` int(11) default NULL,
  `numeric_max` int(11) default NULL,
  `nickname` varchar(64) NOT NULL,
  PRIMARY KEY  (`question_id`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,1,'Does the client reside in his own house',NULL,NULL,'a8aeadab0a66e6c4751e5fc1181d6f35'),(2,1,1,'Does the client have a Gurantor ?',NULL,NULL,'28f9b00ae246de9f133276344e8cc4a5'),(3,2,1,'Name the Gurantor',NULL,NULL,'3a47577bc8ce94bd60cf92ff03d967fd'),(4,1,1,'Does the client have any other loans ?',NULL,NULL,'11bd13e1493da8d9f2b2db5d219f665f'),(5,1,1,'Is the group from the same village ?',NULL,NULL,'f35eed02fee6e852058351d93102c5df'),(6,1,1,'Has the group signed the joint declaration ?',NULL,NULL,'967ccbc6d42cc8e1622928b122f17b6f'),(7,1,1,'Does the loan officer belong to the same village ?',NULL,NULL,'2c100ff7796a86124b1062ce6cbcfda4'),(8,2,1,'If not, please mention the village name',NULL,NULL,'57e1bfa29e945fda2ee814fed54dca9f');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommended_amnt_unit`
--

DROP TABLE IF EXISTS `recommended_amnt_unit`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recommended_amnt_unit` (
  `recommended_amnt_unit_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`recommended_amnt_unit_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `recommended_amnt_unit_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `recommended_amnt_unit`
--

LOCK TABLES `recommended_amnt_unit` WRITE;
/*!40000 ALTER TABLE `recommended_amnt_unit` DISABLE KEYS */;
INSERT INTO `recommended_amnt_unit` VALUES (1,120),(2,121);
/*!40000 ALTER TABLE `recommended_amnt_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recur_on_day`
--

DROP TABLE IF EXISTS `recur_on_day`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recur_on_day` (
  `recur_on_day_id` int(11) NOT NULL auto_increment,
  `details_id` int(11) NOT NULL,
  `days` smallint(6) default NULL,
  `rank_of_days` smallint(6) default NULL,
  `day_number` smallint(6) default NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`recur_on_day_id`),
  KEY `details_id` (`details_id`),
  CONSTRAINT `recur_on_day_ibfk_1` FOREIGN KEY (`details_id`) REFERENCES `recurrence_detail` (`details_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `recur_on_day`
--

LOCK TABLES `recur_on_day` WRITE;
/*!40000 ALTER TABLE `recur_on_day` DISABLE KEYS */;
INSERT INTO `recur_on_day` VALUES (1,1,2,NULL,NULL,0),(2,2,NULL,NULL,1,0),(3,3,2,NULL,NULL,0),(4,4,2,NULL,NULL,0),(5,5,2,NULL,NULL,0),(6,6,NULL,NULL,1,0);
/*!40000 ALTER TABLE `recur_on_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurrence_detail`
--

DROP TABLE IF EXISTS `recurrence_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recurrence_detail` (
  `details_id` int(11) NOT NULL auto_increment,
  `meeting_id` int(11) NOT NULL,
  `recurrence_id` smallint(6) default NULL,
  `recur_after` smallint(6) NOT NULL,
  `version_no` int(11) default NULL,
  PRIMARY KEY  (`details_id`),
  KEY `recurrence_id` (`recurrence_id`),
  KEY `meeting_id` (`meeting_id`),
  CONSTRAINT `recurrence_detail_ibfk_1` FOREIGN KEY (`recurrence_id`) REFERENCES `recurrence_type` (`recurrence_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recurrence_detail_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `recurrence_detail`
--

LOCK TABLES `recurrence_detail` WRITE;
/*!40000 ALTER TABLE `recurrence_detail` DISABLE KEYS */;
INSERT INTO `recurrence_detail` VALUES (1,1,1,1,0),(2,2,2,1,0),(3,3,1,1,0),(4,4,1,1,0),(5,5,1,1,0),(6,6,2,1,0);
/*!40000 ALTER TABLE `recurrence_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurrence_type`
--

DROP TABLE IF EXISTS `recurrence_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recurrence_type` (
  `recurrence_id` smallint(6) NOT NULL auto_increment,
  `recurrence_name` varchar(50) default NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY  (`recurrence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `recurrence_type`
--

LOCK TABLES `recurrence_type` WRITE;
/*!40000 ALTER TABLE `recurrence_type` DISABLE KEYS */;
INSERT INTO `recurrence_type` VALUES (1,'Week(s)','Weekly Recurrence'),(2,'Month(s)','Monthly Recurrence'),(3,'Day(s)','Daily Recurrence');
/*!40000 ALTER TABLE `recurrence_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repayment_rule`
--

DROP TABLE IF EXISTS `repayment_rule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `repayment_rule` (
  `repayment_rule_id` smallint(6) NOT NULL auto_increment,
  `repayment_rule_lookup_id` int(11) default NULL,
  PRIMARY KEY  (`repayment_rule_id`),
  KEY `repayment_rule_lookup_id` (`repayment_rule_lookup_id`),
  CONSTRAINT `repayment_rule_ibfk_1` FOREIGN KEY (`repayment_rule_lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `repayment_rule`
--

LOCK TABLES `repayment_rule` WRITE;
/*!40000 ALTER TABLE `repayment_rule` DISABLE KEYS */;
INSERT INTO `repayment_rule` VALUES (1,576),(2,577),(3,578),(4,626);
/*!40000 ALTER TABLE `repayment_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report` (
  `report_id` smallint(6) NOT NULL auto_increment,
  `report_category_id` smallint(6) default NULL,
  `report_name` varchar(100) default NULL,
  `report_identifier` varchar(100) default NULL,
  `activity_id` smallint(6) default NULL,
  `report_active` smallint(6) default NULL,
  PRIMARY KEY  (`report_id`),
  KEY `report_category_id` (`report_category_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`report_category_id`) REFERENCES `report_category` (`report_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,1,'Collection Sheet Report','collection_sheet_report',229,1),(2,6,'Branch Cash Confirmation Report','branch_cash_confirmation_report',231,1),(3,6,'Branch Progress Report','branch_progress_report',232,1),(4,6,'Detailed Aging Of Portfolio At Risk Report','detailed_aging_of_portfolio_at_risk_report',236,1),(5,6,'General Ledger Report','general_ledger_report',237,1);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_category`
--

DROP TABLE IF EXISTS `report_category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_category` (
  `report_category_id` smallint(6) NOT NULL auto_increment,
  `report_category_value` varchar(100) default NULL,
  `activity_id` smallint(6) default NULL,
  PRIMARY KEY  (`report_category_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `report_category_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_category`
--

LOCK TABLES `report_category` WRITE;
/*!40000 ALTER TABLE `report_category` DISABLE KEYS */;
INSERT INTO `report_category` VALUES (1,'Client Detail',145),(2,'Performance',148),(3,'Center',146),(4,'Loan Product Detail',149),(5,'Status',147),(6,'Analysis',150),(7,'Miscellaneous',151);
/*!40000 ALTER TABLE `report_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_datasource`
--

DROP TABLE IF EXISTS `report_datasource`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_datasource` (
  `datasource_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `driver` varchar(255) default NULL,
  `url` varchar(255) NOT NULL default '',
  `username` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `max_idle` int(11) default NULL,
  `max_active` int(11) default NULL,
  `max_wait` bigint(20) default NULL,
  `validation_query` varchar(255) default NULL,
  `jndi` tinyint(4) default NULL,
  PRIMARY KEY  (`datasource_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_datasource`
--

LOCK TABLES `report_datasource` WRITE;
/*!40000 ALTER TABLE `report_datasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_datasource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_jasper_map`
--

DROP TABLE IF EXISTS `report_jasper_map`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_jasper_map` (
  `report_id` smallint(6) NOT NULL auto_increment,
  `report_category_id` smallint(6) default NULL,
  `report_name` varchar(100) default NULL,
  `report_identifier` varchar(100) default NULL,
  `report_jasper` varchar(100) default NULL,
  PRIMARY KEY  (`report_id`),
  KEY `report_category_id` (`report_category_id`),
  CONSTRAINT `report_jasper_map_ibfk_1` FOREIGN KEY (`report_category_id`) REFERENCES `report_category` (`report_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_jasper_map`
--

LOCK TABLES `report_jasper_map` WRITE;
/*!40000 ALTER TABLE `report_jasper_map` DISABLE KEYS */;
INSERT INTO `report_jasper_map` VALUES (1,1,'Collection Sheet Report','collection_sheet_report','CollectionSheetReport.rptdesign'),(2,6,'Branch Cash Confirmation Report','branch_cash_confirmation_report','BranchCashConfirmationReport.rptdesign'),(3,6,'Branch Progress Report','branch_progress_report','ProgressReport.rptdesign'),(4,6,'Detailed Aging Of Portfolio At Risk Report','detailed_aging_of_portfolio_at_risk_report','DetailedAgingPortfolioAtRiskReport.rptdesign'),(5,6,'General Ledger Report','general_ledger_report','GeneralLedgerReport.rptdesign');
/*!40000 ALTER TABLE `report_jasper_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_parameter`
--

DROP TABLE IF EXISTS `report_parameter`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_parameter` (
  `parameter_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `type` varchar(255) NOT NULL default '',
  `classname` varchar(255) NOT NULL default '',
  `data` text,
  `datasource_id` int(11) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`parameter_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `datasource_id` (`datasource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_parameter`
--

LOCK TABLES `report_parameter` WRITE;
/*!40000 ALTER TABLE `report_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_parameter_map`
--

DROP TABLE IF EXISTS `report_parameter_map`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_parameter_map` (
  `report_id` int(11) NOT NULL default '0',
  `parameter_id` int(11) default NULL,
  `required` tinyint(4) default NULL,
  `sort_order` int(11) default NULL,
  `step` int(11) default NULL,
  `map_id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`map_id`),
  KEY `report_id` (`report_id`),
  KEY `parameter_id` (`parameter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_parameter_map`
--

LOCK TABLES `report_parameter_map` WRITE;
/*!40000 ALTER TABLE `report_parameter_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_parameter_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `role` (
  `role_id` smallint(6) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `version_no` int(11) NOT NULL,
  `created_by` smallint(6) default NULL,
  `created_date` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_date` date default NULL,
  PRIMARY KEY  (`role_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin',1,NULL,NULL,NULL,NULL),(2,'Loan Officer',0,1,'2011-03-21',NULL,NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_activity`
--

DROP TABLE IF EXISTS `roles_activity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles_activity` (
  `activity_id` smallint(6) NOT NULL,
  `role_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`activity_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `roles_activity_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `roles_activity_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles_activity`
--

LOCK TABLES `roles_activity` WRITE;
/*!40000 ALTER TABLE `roles_activity` DISABLE KEYS */;
INSERT INTO `roles_activity` VALUES (3,1),(4,1),(6,1),(7,1),(9,1),(10,1),(15,1),(16,1),(19,1),(20,1),(21,1),(23,1),(24,1),(25,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(79,1),(80,1),(81,1),(82,1),(83,1),(85,1),(86,1),(87,1),(88,1),(91,1),(92,1),(94,1),(95,1),(97,1),(98,1),(101,1),(102,1),(103,1),(104,1),(105,1),(106,1),(108,1),(109,1),(110,1),(115,1),(116,1),(118,1),(119,1),(120,1),(121,1),(122,1),(126,1),(127,1),(128,1),(129,1),(131,1),(135,1),(136,1),(137,1),(138,1),(139,1),(140,1),(141,1),(145,1),(146,1),(147,1),(148,1),(149,1),(150,1),(151,1),(178,1),(179,1),(180,1),(181,1),(182,1),(183,1),(184,1),(185,1),(186,1),(187,1),(188,1),(189,1),(190,1),(191,1),(192,1),(193,1),(194,1),(195,1),(197,1),(198,1),(199,1),(200,1),(201,1),(202,1),(203,1),(204,1),(205,1),(206,1),(208,1),(209,1),(210,1),(211,1),(213,1),(214,1),(215,1),(216,1),(217,1),(218,1),(219,1),(220,1),(221,1),(222,1),(223,1),(224,1),(225,1),(226,1),(227,1),(228,1),(229,1),(230,1),(231,1),(232,1),(233,1),(234,1),(235,1),(236,1),(237,1),(238,1),(239,1),(240,1),(241,1),(242,1),(243,1),(244,1),(245,1),(246,1),(3,2),(4,2),(6,2),(7,2),(9,2),(10,2),(15,2),(16,2),(19,2),(20,2),(21,2),(23,2),(24,2),(25,2),(35,2),(36,2),(37,2),(38,2),(39,2),(40,2),(41,2),(42,2),(43,2),(44,2),(46,2),(47,2),(48,2),(49,2),(50,2),(51,2),(52,2),(53,2),(54,2),(55,2),(57,2),(58,2),(59,2),(60,2),(61,2),(62,2),(63,2),(64,2),(65,2),(66,2),(68,2),(69,2),(70,2),(71,2),(72,2),(73,2),(74,2),(75,2),(76,2),(77,2),(79,2),(80,2),(81,2),(82,2),(83,2),(85,2),(86,2),(87,2),(88,2),(91,2),(92,2),(94,2),(95,2),(97,2),(98,2),(101,2),(102,2),(103,2),(104,2),(105,2),(106,2),(108,2),(109,2),(110,2),(115,2),(116,2),(118,2),(119,2),(120,2),(121,2),(122,2),(126,2),(127,2),(128,2),(129,2),(131,2),(135,2),(137,2),(138,2),(139,2),(140,2),(146,2),(147,2),(148,2),(149,2),(151,2),(178,2),(179,2),(180,2),(181,2),(182,2),(183,2),(184,2),(185,2),(186,2),(187,2),(188,2),(189,2),(190,2),(191,2),(192,2),(193,2),(194,2),(195,2),(197,2),(198,2),(199,2),(200,2),(201,2),(202,2),(204,2),(205,2),(206,2),(208,2),(210,2),(211,2),(213,2),(214,2),(215,2),(216,2),(217,2),(218,2),(219,2),(220,2),(221,2),(222,2),(223,2),(224,2),(225,2),(226,2),(228,2),(229,2),(230,2),(231,2),(232,2),(233,2),(234,2),(235,2),(236,2),(237,2);
/*!40000 ALTER TABLE `roles_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saving_schedule`
--

DROP TABLE IF EXISTS `saving_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `saving_schedule` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` smallint(6) default NULL,
  `action_date` date default NULL,
  `deposit` decimal(21,4) NOT NULL,
  `deposit_currency_id` smallint(6) default NULL,
  `deposit_paid` decimal(21,4) default NULL,
  `deposit_paid_currency_id` smallint(6) default NULL,
  `payment_status` smallint(6) NOT NULL,
  `installment_id` smallint(6) NOT NULL,
  `payment_date` date default NULL,
  `parent_flag` smallint(6) default NULL,
  `version_no` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `account_id` (`account_id`),
  KEY `currency_id` (`currency_id`),
  KEY `deposit_currency_id` (`deposit_currency_id`),
  KEY `deposit_paid_currency_id` (`deposit_paid_currency_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `saving_schedule_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `saving_schedule_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `saving_schedule_ibfk_3` FOREIGN KEY (`deposit_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `saving_schedule_ibfk_4` FOREIGN KEY (`deposit_paid_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `saving_schedule_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `saving_schedule`
--

LOCK TABLES `saving_schedule` WRITE;
/*!40000 ALTER TABLE `saving_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `saving_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_account`
--

DROP TABLE IF EXISTS `savings_account`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_account` (
  `account_id` int(11) NOT NULL,
  `activation_date` date default NULL,
  `savings_balance` decimal(21,4) default NULL,
  `savings_balance_currency_id` smallint(6) default NULL,
  `recommended_amount` decimal(21,4) default NULL,
  `recommended_amount_currency_id` smallint(6) default NULL,
  `recommended_amnt_unit_id` smallint(6) default NULL,
  `savings_type_id` smallint(6) NOT NULL,
  `int_to_be_posted` decimal(21,4) default NULL,
  `int_to_be_posted_currency_id` smallint(6) default NULL,
  `last_int_calc_date` date default NULL,
  `last_int_post_date` date default NULL,
  `next_int_calc_date` date default NULL,
  `next_int_post_date` date default NULL,
  `inter_int_calc_date` date default NULL,
  `prd_offering_id` smallint(6) NOT NULL,
  `interest_rate` decimal(13,10) NOT NULL,
  `interest_calculation_type_id` smallint(6) NOT NULL,
  `time_per_for_int_calc` int(11) default NULL,
  `min_amnt_for_int` decimal(21,4) default NULL,
  `min_amnt_for_int_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`account_id`),
  KEY `savings_balance_currency_id` (`savings_balance_currency_id`),
  KEY `recommended_amount_currency_id` (`recommended_amount_currency_id`),
  KEY `int_to_be_posted_currency_id` (`int_to_be_posted_currency_id`),
  KEY `recommended_amnt_unit_id` (`recommended_amnt_unit_id`),
  KEY `savings_type_id` (`savings_type_id`),
  KEY `prd_offering_id` (`prd_offering_id`),
  KEY `interest_calculation_type_id` (`interest_calculation_type_id`),
  KEY `time_per_for_int_calc` (`time_per_for_int_calc`),
  KEY `min_amnt_for_int_currency_id` (`min_amnt_for_int_currency_id`),
  CONSTRAINT `savings_account_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_10` FOREIGN KEY (`min_amnt_for_int_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_2` FOREIGN KEY (`savings_balance_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_3` FOREIGN KEY (`recommended_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_4` FOREIGN KEY (`int_to_be_posted_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_5` FOREIGN KEY (`recommended_amnt_unit_id`) REFERENCES `recommended_amnt_unit` (`recommended_amnt_unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_6` FOREIGN KEY (`savings_type_id`) REFERENCES `savings_type` (`savings_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_7` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_8` FOREIGN KEY (`interest_calculation_type_id`) REFERENCES `interest_calculation_types` (`interest_calculation_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_account_ibfk_9` FOREIGN KEY (`time_per_for_int_calc`) REFERENCES `meeting` (`meeting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_activity_details`
--

DROP TABLE IF EXISTS `savings_activity_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_activity_details` (
  `id` int(11) NOT NULL auto_increment,
  `created_by` smallint(6) default NULL,
  `account_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `account_action_id` smallint(6) NOT NULL,
  `amount` decimal(21,4) NOT NULL,
  `amount_currency_id` smallint(6) NOT NULL,
  `balance_amount` decimal(21,4) NOT NULL,
  `balance_amount_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `created_by` (`created_by`),
  KEY `account_id` (`account_id`),
  KEY `account_action_id` (`account_action_id`),
  KEY `amount_currency_id` (`amount_currency_id`),
  KEY `balance_amount_currency_id` (`balance_amount_currency_id`),
  CONSTRAINT `savings_activity_details_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_activity_details_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_activity_details_ibfk_3` FOREIGN KEY (`account_action_id`) REFERENCES `account_action` (`account_action_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_activity_details_ibfk_4` FOREIGN KEY (`amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_activity_details_ibfk_5` FOREIGN KEY (`balance_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_activity_details`
--

LOCK TABLES `savings_activity_details` WRITE;
/*!40000 ALTER TABLE `savings_activity_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_activity_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_offering`
--

DROP TABLE IF EXISTS `savings_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_offering` (
  `prd_offering_id` smallint(6) NOT NULL,
  `interest_calculation_type_id` smallint(6) NOT NULL,
  `savings_type_id` smallint(6) NOT NULL,
  `recommended_amnt_unit_id` smallint(6) default NULL,
  `recommended_amount` decimal(21,4) default NULL,
  `recommended_amount_currency_id` smallint(6) default NULL,
  `interest_rate` decimal(13,10) NOT NULL,
  `max_amnt_withdrawl` decimal(21,4) default NULL,
  `max_amnt_withdrawl_currency_id` smallint(6) default NULL,
  `min_amnt_for_int` decimal(21,4) default NULL,
  `min_amnt_for_int_currency_id` smallint(6) default NULL,
  `deposit_glcode_id` smallint(6) NOT NULL,
  `interest_glcode_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`prd_offering_id`),
  KEY `recommended_amnt_unit_id` (`recommended_amnt_unit_id`),
  KEY `savings_type_id` (`savings_type_id`),
  KEY `interest_calculation_type_id` (`interest_calculation_type_id`),
  KEY `recommended_amount_currency_id` (`recommended_amount_currency_id`),
  KEY `max_amnt_withdrawl_currency_id` (`max_amnt_withdrawl_currency_id`),
  KEY `min_amnt_for_int_currency_id` (`min_amnt_for_int_currency_id`),
  KEY `deposit_glcode_id` (`deposit_glcode_id`),
  KEY `interest_glcode_id` (`interest_glcode_id`),
  CONSTRAINT `savings_offering_ibfk_1` FOREIGN KEY (`prd_offering_id`) REFERENCES `prd_offering` (`prd_offering_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_2` FOREIGN KEY (`recommended_amnt_unit_id`) REFERENCES `recommended_amnt_unit` (`recommended_amnt_unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_3` FOREIGN KEY (`savings_type_id`) REFERENCES `savings_type` (`savings_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_4` FOREIGN KEY (`interest_calculation_type_id`) REFERENCES `interest_calculation_types` (`interest_calculation_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_5` FOREIGN KEY (`recommended_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_6` FOREIGN KEY (`max_amnt_withdrawl_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_7` FOREIGN KEY (`min_amnt_for_int_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_8` FOREIGN KEY (`deposit_glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_offering_ibfk_9` FOREIGN KEY (`interest_glcode_id`) REFERENCES `gl_code` (`glcode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_offering`
--

LOCK TABLES `savings_offering` WRITE;
/*!40000 ALTER TABLE `savings_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_offering_historical_interest_detail`
--

DROP TABLE IF EXISTS `savings_offering_historical_interest_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_offering_historical_interest_detail` (
  `id` int(11) NOT NULL auto_increment,
  `period_start_date` date NOT NULL,
  `period_end_date` date NOT NULL,
  `interest_rate` decimal(13,10) NOT NULL,
  `min_amnt_for_int` decimal(21,4) NOT NULL,
  `min_amnt_for_int_currency_id` smallint(6) NOT NULL,
  `product_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `savings_offering_historical_interest_detail_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `savings_offering` (`prd_offering_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_offering_historical_interest_detail`
--

LOCK TABLES `savings_offering_historical_interest_detail` WRITE;
/*!40000 ALTER TABLE `savings_offering_historical_interest_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_offering_historical_interest_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_performance`
--

DROP TABLE IF EXISTS `savings_performance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_performance` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `total_deposits` decimal(21,4) default NULL,
  `total_deposits_currency_id` smallint(6) default NULL,
  `total_withdrawals` decimal(21,4) default NULL,
  `total_withdrawals_currency_id` smallint(6) default NULL,
  `total_interest_earned` decimal(21,4) default NULL,
  `total_interest_earned_currency_id` smallint(6) default NULL,
  `missed_deposits` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `account_id` (`account_id`),
  KEY `total_deposits_currency_id` (`total_deposits_currency_id`),
  KEY `total_withdrawals_currency_id` (`total_withdrawals_currency_id`),
  KEY `total_interest_earned_currency_id` (`total_interest_earned_currency_id`),
  CONSTRAINT `savings_performance_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_performance_ibfk_2` FOREIGN KEY (`total_deposits_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_performance_ibfk_3` FOREIGN KEY (`total_withdrawals_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_performance_ibfk_4` FOREIGN KEY (`total_interest_earned_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_performance`
--

LOCK TABLES `savings_performance` WRITE;
/*!40000 ALTER TABLE `savings_performance` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_trxn_detail`
--

DROP TABLE IF EXISTS `savings_trxn_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_trxn_detail` (
  `account_trxn_id` int(11) NOT NULL,
  `deposit_amount` decimal(21,4) default NULL,
  `deposit_amount_currency_id` smallint(6) default NULL,
  `withdrawal_amount` decimal(21,4) default NULL,
  `withdrawal_amount_currency_id` smallint(6) default NULL,
  `interest_amount` decimal(21,4) default NULL,
  `interest_amount_currency_id` smallint(6) default NULL,
  `balance` decimal(21,4) default NULL,
  `balance_currency_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`account_trxn_id`),
  KEY `deposit_amount_currency_id` (`deposit_amount_currency_id`),
  KEY `withdrawal_amount_currency_id` (`withdrawal_amount_currency_id`),
  KEY `interest_amount_currency_id` (`interest_amount_currency_id`),
  KEY `balance_currency_id` (`balance_currency_id`),
  CONSTRAINT `savings_trxn_detail_ibfk_1` FOREIGN KEY (`account_trxn_id`) REFERENCES `account_trxn` (`account_trxn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_trxn_detail_ibfk_2` FOREIGN KEY (`deposit_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_trxn_detail_ibfk_3` FOREIGN KEY (`withdrawal_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_trxn_detail_ibfk_4` FOREIGN KEY (`interest_amount_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `savings_trxn_detail_ibfk_5` FOREIGN KEY (`balance_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_trxn_detail`
--

LOCK TABLES `savings_trxn_detail` WRITE;
/*!40000 ALTER TABLE `savings_trxn_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `savings_trxn_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_type`
--

DROP TABLE IF EXISTS `savings_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `savings_type` (
  `savings_type_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`savings_type_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `savings_type_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `savings_type`
--

LOCK TABLES `savings_type` WRITE;
/*!40000 ALTER TABLE `savings_type` DISABLE KEYS */;
INSERT INTO `savings_type` VALUES (1,118),(2,119);
/*!40000 ALTER TABLE `savings_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_tasks`
--

DROP TABLE IF EXISTS `scheduled_tasks`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `scheduled_tasks` (
  `taskid` int(11) NOT NULL auto_increment,
  `taskname` varchar(200) default NULL,
  `description` varchar(500) default NULL,
  `starttime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `endtime` timestamp NOT NULL default '0000-00-00 00:00:00',
  `status` smallint(6) default NULL,
  PRIMARY KEY  (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `scheduled_tasks`
--

LOCK TABLES `scheduled_tasks` WRITE;
/*!40000 ALTER TABLE `scheduled_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL auto_increment,
  `question_group_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `question_group_id` (`question_group_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`question_group_id`) REFERENCES `question_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,'Client Creation',0),(2,2,'Create loan',0),(3,3,'Create Group',0),(4,4,'Create Center',0);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_questions`
--

DROP TABLE IF EXISTS `sections_questions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sections_questions` (
  `id` int(11) NOT NULL auto_increment,
  `section_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `is_required` tinyint(4) default '0',
  `sequence_number` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `section_id` (`section_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `sections_questions_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`),
  CONSTRAINT `sections_questions_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sections_questions`
--

LOCK TABLES `sections_questions` WRITE;
/*!40000 ALTER TABLE `sections_questions` DISABLE KEYS */;
INSERT INTO `sections_questions` VALUES (1,1,2,0,0),(2,1,1,0,1),(3,1,3,0,2),(4,2,4,0,0),(5,3,6,0,0),(6,3,5,0,1),(7,4,7,0,0),(8,4,8,0,1);
/*!40000 ALTER TABLE `sections_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spouse_father_lookup`
--

DROP TABLE IF EXISTS `spouse_father_lookup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `spouse_father_lookup` (
  `spouse_father_id` int(11) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`spouse_father_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `spouse_father_lookup_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `spouse_father_lookup`
--

LOCK TABLES `spouse_father_lookup` WRITE;
/*!40000 ALTER TABLE `spouse_father_lookup` DISABLE KEYS */;
INSERT INTO `spouse_father_lookup` VALUES (1,128),(2,129),(4,622),(5,623);
/*!40000 ALTER TABLE `spouse_father_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supported_locale`
--

DROP TABLE IF EXISTS `supported_locale`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `supported_locale` (
  `locale_id` smallint(6) NOT NULL,
  `country_id` smallint(6) default NULL,
  `lang_id` smallint(6) default NULL,
  `locale_name` varchar(50) default NULL,
  `default_locale` smallint(6) default NULL,
  PRIMARY KEY  (`locale_id`),
  KEY `country_id` (`country_id`),
  KEY `lang_id` (`lang_id`),
  CONSTRAINT `supported_locale_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `supported_locale_ibfk_2` FOREIGN KEY (`lang_id`) REFERENCES `language` (`lang_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `supported_locale`
--

LOCK TABLES `supported_locale` WRITE;
/*!40000 ALTER TABLE `supported_locale` DISABLE KEYS */;
INSERT INTO `supported_locale` VALUES (1,6,1,'EN',1),(2,7,2,'Icelandic',0),(3,8,3,'Spanish',0),(4,9,4,'French',0),(5,10,5,'Chinese-China',0),(6,11,6,'Swahili-Kenya',0),(7,12,6,'Swahili-Tanzania',0),(8,13,6,'Swahili-Uganda',0),(9,14,7,'Arabic-Algeria',0),(10,15,7,'Arabic-Bahrain',0),(11,16,7,'Arabic-Comoros',0),(12,17,7,'Arabic-Chad',0),(13,18,7,'Arabic-Djibouti',0),(14,19,7,'Arabic-Egypt',0),(15,20,7,'Arabic-Eritrea',0),(16,21,7,'Arabic-Iraq',0),(17,22,7,'Arabic-Israel',0),(18,23,7,'Arabic-Jordan',0),(19,24,7,'Arabic-Kuwait',0),(20,25,7,'Arabic-Lebanon',0),(21,26,7,'Arabic-Libyan Arab Rebublic',0),(22,27,7,'Arabic-Mauritania',0),(23,28,7,'Arabic-Morocco',0),(24,29,7,'Arabic-Oman',0),(25,30,7,'Arabic-Qatar',0),(26,31,7,'Arabic-Saudi Arabia',0),(27,32,7,'Arabic-Somalia',0),(28,33,7,'Arabic-Sudan',0),(29,34,7,'Arabic-Syrian Arab Republic',0),(30,35,7,'Arabic-Tunisia',0),(31,36,7,'Arabic-United Arab Emirates',0),(32,37,7,'Arabic-Yemen',0),(33,38,7,'Arabic-Palestinian Territory, Occupied',0),(34,39,7,'Arabic-Western Sahara',0),(35,40,8,'Portuguese-Angola',0),(36,41,8,'Portuguese-Brazil',0),(37,42,8,'Portuguese-Cape Verde',0),(38,43,8,'Portuguese-Guinea-Bissau',0),(39,44,8,'Portuguese-Equatorial Guinea',0),(40,45,8,'Portuguese-Macau',0),(41,46,8,'Portuguese-Mozambique',0),(42,47,8,'Portuguese-Portugal',0),(43,48,8,'Portuguese-Sao Tome and Principe',0),(44,49,9,'Khmer-Cambodia',0),(45,50,10,'Lao-Laos',0),(46,25,1,'English-Lebanon-AlMajmoua',0),(47,51,11,'Hungarian-Hungary',0);
/*!40000 ALTER TABLE `supported_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey` (
  `survey_id` int(11) NOT NULL auto_increment,
  `survey_name` varchar(200) NOT NULL,
  `survey_applies_to` varchar(200) NOT NULL,
  `date_of_creation` date NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY  (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey`
--

LOCK TABLES `survey` WRITE;
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_instance`
--

DROP TABLE IF EXISTS `survey_instance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey_instance` (
  `instance_id` int(11) NOT NULL auto_increment,
  `survey_id` int(11) NOT NULL,
  `customer_id` int(11) default NULL,
  `officer_id` smallint(6) default NULL,
  `date_conducted` date NOT NULL,
  `completed_status` int(11) NOT NULL,
  `account_id` int(11) default NULL,
  `creating_officer_id` smallint(6) NOT NULL,
  PRIMARY KEY  (`instance_id`),
  KEY `survey_id` (`survey_id`),
  KEY `customer_id` (`customer_id`),
  KEY `officer_id` (`officer_id`),
  KEY `account_id` (`account_id`),
  KEY `creating_officer_id` (`creating_officer_id`),
  CONSTRAINT `survey_instance_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`survey_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_instance_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_instance_ibfk_3` FOREIGN KEY (`officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_instance_ibfk_4` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_instance_ibfk_5` FOREIGN KEY (`creating_officer_id`) REFERENCES `personnel` (`personnel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey_instance`
--

LOCK TABLES `survey_instance` WRITE;
/*!40000 ALTER TABLE `survey_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_questions`
--

DROP TABLE IF EXISTS `survey_questions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey_questions` (
  `surveyquestion_id` int(11) NOT NULL auto_increment,
  `survey_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `question_order` int(11) NOT NULL,
  `mandatory` smallint(6) NOT NULL default '1',
  PRIMARY KEY  (`surveyquestion_id`),
  KEY `question_id` (`question_id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `survey_questions_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_questions_ibfk_2` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`survey_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey_questions`
--

LOCK TABLES `survey_questions` WRITE;
/*!40000 ALTER TABLE `survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_response`
--

DROP TABLE IF EXISTS `survey_response`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey_response` (
  `response_id` int(11) NOT NULL auto_increment,
  `instance_id` int(11) NOT NULL,
  `survey_question_id` int(11) NOT NULL,
  `freetext_value` text,
  `choice_value` int(11) default NULL,
  `date_value` date default NULL,
  `number_value` decimal(16,5) default NULL,
  `multi_select_value` text,
  PRIMARY KEY  (`response_id`),
  UNIQUE KEY `instance_id` (`instance_id`,`survey_question_id`),
  KEY `survey_question_id` (`survey_question_id`),
  KEY `choice_value` (`choice_value`),
  CONSTRAINT `survey_response_ibfk_1` FOREIGN KEY (`survey_question_id`) REFERENCES `survey_questions` (`surveyquestion_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_response_ibfk_2` FOREIGN KEY (`instance_id`) REFERENCES `survey_instance` (`instance_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `survey_response_ibfk_3` FOREIGN KEY (`choice_value`) REFERENCES `question_choices` (`choice_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey_response`
--

LOCK TABLES `survey_response` WRITE;
/*!40000 ALTER TABLE `survey_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_id`
--

DROP TABLE IF EXISTS `temp_id`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `temp_id` (
  `id` smallint(6) NOT NULL auto_increment,
  `tempid` smallint(6) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `temp_id`
--

LOCK TABLES `temp_id` WRITE;
/*!40000 ALTER TABLE `temp_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `transaction_type` (
  `transaction_id` smallint(6) NOT NULL,
  `transaction_name` varchar(100) NOT NULL,
  PRIMARY KEY  (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `transaction_type`
--

LOCK TABLES `transaction_type` WRITE;
/*!40000 ALTER TABLE `transaction_type` DISABLE KEYS */;
INSERT INTO `transaction_type` VALUES (1,'Loan Disbursement'),(2,'Loan Repayment'),(3,'Savings Deposit'),(4,'Savings Withdrawals'),(5,'Client Fees/penalty payments');
/*!40000 ALTER TABLE `transaction_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable_installment_details`
--

DROP TABLE IF EXISTS `variable_installment_details`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `variable_installment_details` (
  `id` smallint(6) NOT NULL auto_increment,
  `min_gap_in_days` smallint(6) default NULL,
  `max_gap_in_days` smallint(6) default NULL,
  `min_loan_amount` decimal(21,4) default NULL,
  `min_loan_amount_currency_id` smallint(6) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `variable_installment_details`
--

LOCK TABLES `variable_installment_details` WRITE;
/*!40000 ALTER TABLE `variable_installment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `variable_installment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waive_off_history`
--

DROP TABLE IF EXISTS `waive_off_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `waive_off_history` (
  `waive_off_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `waive_off_date` date NOT NULL,
  `waive_off_type` varchar(20) NOT NULL,
  PRIMARY KEY  (`waive_off_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `waive_off_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loan_account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `waive_off_history`
--

LOCK TABLES `waive_off_history` WRITE;
/*!40000 ALTER TABLE `waive_off_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `waive_off_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yes_no_master`
--

DROP TABLE IF EXISTS `yes_no_master`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `yes_no_master` (
  `yes_no_master_id` smallint(6) NOT NULL auto_increment,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY  (`yes_no_master_id`),
  KEY `lookup_id` (`lookup_id`),
  CONSTRAINT `yes_no_master_ibfk_1` FOREIGN KEY (`lookup_id`) REFERENCES `lookup_value` (`lookup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `yes_no_master`
--

LOCK TABLES `yes_no_master` WRITE;
/*!40000 ALTER TABLE `yes_no_master` DISABLE KEYS */;
INSERT INTO `yes_no_master` VALUES (1,124),(2,125);
/*!40000 ALTER TABLE `yes_no_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-04-29 11:42:00
