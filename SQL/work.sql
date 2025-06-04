CREATE DATABASE  IF NOT EXISTS `work` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `work`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: work
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `adid` int NOT NULL,
  `adpicture` varchar(255) NOT NULL,
  `adpage` varchar(255) NOT NULL,
  PRIMARY KEY (`adid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES (1,'picture\\ad1.png','products\\pudding.jsp'),(2,'picture\\ad2.png','products\\strawberry-daifuku.jsp'),(3,'picture\\ad3.png','products\\yokan.jsp');
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `UserID` int NOT NULL,
  `ProductID` varchar(50) NOT NULL,
  `ProductName` varchar(255) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Subtotal` int NOT NULL,
  `ProductImage` varchar(255) NOT NULL,
  PRIMARY KEY (`ProductID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,'14','金平糖',150,1,150,'products/picture2/金平糖.jpg'),(1,'9','聖誕和菓子禮盒組',550,1,550,'sidebar\\picture1\\聖誕和菓子禮盒組.jpg');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `realname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'林','12345@gmail.com','2025-05-12','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','admin');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `OrderItemID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `ProductID` varchar(50) NOT NULL,
  `Quantity` int NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Subtotal` decimal(10,2) GENERATED ALWAYS AS ((`Quantity` * `Price`)) STORED,
  `ProductName` varchar(100) DEFAULT NULL,
  `ProductImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`OrderItemID`),
  KEY `fk_order` (`OrderID`),
  CONSTRAINT `fk_order` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` (`OrderItemID`, `OrderID`, `ProductID`, `Quantity`, `Price`, `ProductName`, `ProductImage`) VALUES (1,2,'15',3,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(2,3,'15',1,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(3,4,'15',1,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(4,4,'16',1,210.00,'抹茶蛋糕','products/picture2/抹茶蛋糕.jpg'),(5,5,'15',4,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(6,5,'16',3,210.00,'抹茶蛋糕','products/picture2/抹茶蛋糕.jpg'),(7,6,'15',2,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(8,7,'15',2,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(9,8,'15',2,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(10,9,'15',2,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(11,10,'15',2,80.00,'栗子饅頭','products/picture2/栗子饅頭.jpg'),(12,11,'10',3,360.00,'聖誕派對生乳銅鑼燒','sidebar\\picture1\\聖誕派對生乳銅鑼燒1.jpg');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `buy_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalTotal` int NOT NULL,
  PRIMARY KEY (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,1,'2025-06-01 13:33:00',240),(3,1,'2025-06-01 13:36:14',80),(4,1,'2025-06-01 13:37:06',290),(5,1,'2025-06-01 13:39:12',940),(6,1,'2025-06-01 13:57:06',160),(7,1,'2025-06-01 13:59:00',160),(8,1,'2025-06-01 14:17:33',160),(9,1,'2025-06-01 14:21:12',160),(10,1,'2025-06-01 14:22:07',160),(11,1,'2025-06-01 14:44:07',1070);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-02 13:39:26
