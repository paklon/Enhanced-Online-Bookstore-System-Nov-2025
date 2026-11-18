-- MySQL dump 10.13  Distrib 8.4.7, for Win64 (x86_64)
--
-- Host: localhost    Database: books
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `authorisbn`
--

DROP TABLE IF EXISTS `authorisbn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorisbn` (
  `AuthorID` int NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  KEY `AuthorID` (`AuthorID`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `authorisbn_ibfk_1` FOREIGN KEY (`AuthorID`) REFERENCES `authors` (`AuthorID`),
  CONSTRAINT `authorisbn_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `bookinfo` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorisbn`
--

LOCK TABLES `authorisbn` WRITE;
/*!40000 ALTER TABLE `authorisbn` DISABLE KEYS */;
INSERT INTO `authorisbn` VALUES (1,'0131869000'),(2,'0131869000'),(1,'0131525239'),(2,'0131525239'),(1,'0132222205'),(2,'0132222205'),(1,'0131857576'),(2,'0131857576'),(1,'0132404168'),(2,'0132404168'),(1,'0131450913'),(2,'0131450913'),(3,'0131450913'),(1,'0131828274'),(2,'0131828274'),(4,'0131828274');
/*!40000 ALTER TABLE `authorisbn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `AuthorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  PRIMARY KEY (`AuthorID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Harvey','Deitel'),(2,'Paul','Deitel'),(3,'Andrew','Goldberg'),(4,'David','Choffnes');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookinfo`
--

DROP TABLE IF EXISTS `bookinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookinfo` (
  `ISBN` varchar(20) NOT NULL,
  `Title` varchar(80) NOT NULL,
  `Author` varchar(30) NOT NULL,
  `EditionNumber` int NOT NULL,
  `Publisher` varchar(20) NOT NULL,
  `Copyright` varchar(4) NOT NULL,
  `Price` double NOT NULL,
  `availability` int NOT NULL DEFAULT '100',
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookinfo`
--

LOCK TABLES `bookinfo` WRITE;
/*!40000 ALTER TABLE `bookinfo` DISABLE KEYS */;
INSERT INTO `bookinfo` VALUES ('0131450913','HTML How to Program','Paul Deitel',1,'McGraw-Hill','2000',22,98),('0131525239','Beginning with Objective-C','Paul Deitel',3,'Wrox Wiley Pub','2010',20,98),('0131828274','Internet & World Wide Web How to Program','David Choffnes',5,'McGraw-Hill','2011',22.5,100),('0131857576','C++ How to Program','David Choffnes',5,'Peachpit','2005',30.5,99),('0131869000','Visual Basic 2005 How to Program','Harvey Deitel',3,'Peachpit Press','2006',17.5,99),('0132222205','Java How to Program','Andrew Goldberg',3,'Peachpit','2010',25,100),('0132404168','iPhone SDK 3','Andrew Goldberg',2,'McGraw-Hill','2010',18,97),('1111111111','example','t',10,'t','t',50,99);
/*!40000 ALTER TABLE `bookinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `SaleID` int NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(20) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `SaleDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`SaleID`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `bookinfo` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'0131525239',1,'2025-11-22 23:48:05'),(2,'0131857576',1,'2025-11-22 23:51:54'),(3,'0131525239',1,'2025-11-23 00:03:17'),(4,'0131857576',1,'2025-11-23 11:52:32'),(5,'0131450913',1,'2025-11-23 12:08:43'),(6,'0132404168',1,'2025-11-23 12:08:43'),(7,'1111111111',1,'2025-11-23 12:11:48'),(8,'0132404168',1,'2025-11-23 12:12:41'),(9,'0131869000',1,'2025-11-24 11:42:18'),(10,'0132404168',1,'2025-11-24 11:42:18'),(11,'0131525239',1,'2025-11-24 11:54:12'),(12,'0131450913',1,'2025-11-24 11:54:12');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpurchases`
--

DROP TABLE IF EXISTS `userpurchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpurchases` (
  `PurchaseID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `PurchaseDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PurchaseID`),
  KEY `UserID` (`UserID`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `userpurchases_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `userpurchases_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `bookinfo` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpurchases`
--

LOCK TABLES `userpurchases` WRITE;
/*!40000 ALTER TABLE `userpurchases` DISABLE KEYS */;
INSERT INTO `userpurchases` VALUES (1,1,'0131857576',1,'2025-11-23 11:52:32'),(2,1,'0131450913',1,'2025-11-23 12:08:43'),(3,1,'0132404168',1,'2025-11-23 12:08:43'),(4,1,'1111111111',1,'2025-11-23 12:11:48'),(5,4,'0132404168',1,'2025-11-23 12:12:41'),(6,1,'0131869000',1,'2025-11-24 11:42:18'),(7,1,'0132404168',1,'2025-11-24 11:42:18'),(8,1,'0131525239',1,'2025-11-24 11:54:12'),(9,1,'0131450913',1,'2025-11-24 11:54:12');
/*!40000 ALTER TABLE `userpurchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` varchar(10) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'student1','student1','student'),(3,'admin','admin','admin'),(4,'23079398d','23079398d','student'),(6,'user ','user','student');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 11:56:50
