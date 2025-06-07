CREATE DATABASE  IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shop`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CategoryID` int NOT NULL,
  `CategoryName` varchar(45) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'聖誕節限定甜點'),(2,'季節限定甜點'),(3,'經典日式點心'),(4,'創新甜點');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countview`
--

DROP TABLE IF EXISTS `countview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countview` (
  `Count` int NOT NULL,
  PRIMARY KEY (`Count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countview`
--

LOCK TABLES `countview` WRITE;
/*!40000 ALTER TABLE `countview` DISABLE KEYS */;
INSERT INTO `countview` VALUES (1010);
/*!40000 ALTER TABLE `countview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(10) NOT NULL,
  `CategoryID` int NOT NULL,
  `Price` int NOT NULL,
  `Description` varchar(200) NOT NULL,
  `Content1` varchar(100) DEFAULT NULL,
  `Content2` varchar(100) DEFAULT NULL,
  `Stock` int NOT NULL,
  `ProductImage` varchar(50) DEFAULT NULL,
  `PictureName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductNameAK1` (`ProductName`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'和菓子',3,150,'精緻的手工甜點，以細膩的白豆餡為基底，捏塑成多樣美麗的造型，每一口都能感受到細緻滑順的口感與溫潤的甜味，彷彿一場視覺與味覺的盛宴。','成分：根據不同種類，通常包含紅豆餡（紅豆、糖）、白豆餡（白豆、糖）、糯米粉、寒天等，並可能加入色素或天然香料製作形狀精緻的外皮。','和菓子的成分通常簡單而天然，旨在突顯食材的純粹風味。',50,'products/picture2/和菓子.jpg','和菓子.jpg'),(2,'日式布丁',3,125,'綿密細緻的布丁散發著濃郁奶香，入口即化，甜而不膩，每一口都充滿日式甜點的溫柔與美好。','成分：蕨根粉、糖、黃豆粉、黑糖蜜。','濃郁的牛奶與蛋混合製成奶香四溢的布丁，底部的焦糖增添了甜蜜的風味。',20,'products/picture2/日式布丁.jpg','日式布丁.jpg'),(3,'水信玄餅',3,200,'如水晶般晶瑩剔透的水信玄餅，內嵌各式精美花卉，入口滑嫩清爽，甜味淡雅，令人驚豔。','成分：水信玄餅寒天粉、細砂糖、黑糖、水飴、黃豆粉、鹽漬櫻花八朵。','如水晶般晶瑩剔透的水信玄餅，內嵌各式精美花卉，入口滑嫩清爽，甜味淡雅，令人驚豔。',42,'products/picture2/水信玄餅.jpg','水信玄餅.jpg'),(4,'銅鑼燒',3,50,'柔軟香甜的鬆餅皮夾著飽滿紅豆餡，經典的日式風味，每一口都回味無窮。','成分：紅豆餡（紅豆、糖）、麵粉、雞蛋、糖、蜂蜜。','柔軟香甜的鬆餅皮夾著飽滿紅豆餡，經典的日式風味，每一口都回味無窮。',30,'products/picture2/銅鑼燒.jpg','銅鑼燒.jpg'),(5,'羊羹',3,150,'羊羹是一款歷史悠久的日式傳統甜點，通常由紅豆、糖和寒天製成，口感厚重而緻密。這款羊羹外表光滑，口感滑順，甜而不膩，充滿紅豆的濃郁風味。它不僅適合配茶，還是日常小點心的好選擇，給予您一份安定的幸福感。無論是自用還是送禮，都非常合適。','成分：紅豆餡（紅豆、糖）、寒天、糖。','主要成分為紅豆和寒天，凝固後形成緻密的質地，糖分使得甜度適中。',8,'products/picture2/羊羹.jpg','羊羹.jpg'),(6,'醬油糰子',3,125,'炭烤後香氣四溢的糰子，淋上甜鹹適中的醬油醬汁，Q彈的口感與焦香味完美交融，令人愛不釋手。','成分：糯米粉、醬油、糖、黃豆粉。','炭烤後香氣四溢的糰子，淋上甜鹹適中的醬油醬汁，Q彈的口感與焦香味完美交融，令人愛不釋手。',10,'products/picture2/醬油糰子.jpg','醬油糰子.jpg'),(7,'蕨餅',3,150,'透明如玉的蕨餅，口感Q彈滑嫩，搭配黃豆粉與黑糖醬，甜香四溢，入口即化，讓人回味無窮。','成分：蕨根粉、糖、黃豆粉、黑糖蜜。','透明如玉的蕨餅，口感Q彈滑嫩，搭配黃豆粉與黑糖醬，甜香四溢，入口即化，讓人回味無窮。',25,'products/picture2/蕨餅.jpg','蕨餅.jpg'),(8,'雪人大福',1,250,'雪人大福的外形可愛，內含紅豆餡，外皮是Q彈的麻糬，糖和色素則用來打造可愛的雪人造型。','成分：紅豆餡（紅豆、糖）、糯米粉、糖、色素（天然）',NULL,10,'sidebar\\picture1\\雪人大福.jpg','雪人大福.jpg'),(9,'聖誕和菓子禮盒組',1,550,'禮盒內含多種和菓子，成分多樣，旨在展現節日的美好。','成分：根據禮盒內含的和菓子種類，常見成分包括紅豆餡（紅豆、糖）、白豆餡（白豆、糖）、糯米粉、色素、寒天、抹茶粉等。',NULL,10,'sidebar\\picture1\\聖誕和菓子禮盒組.jpg','聖誕和菓子禮盒組.jpg'),(10,'聖誕派對生乳銅鑼燒',1,360,'銅鑼燒外皮用麵粉、雞蛋和蜂蜜製作，內餡是紅豆餡，夾層則是濃郁的奶油，香滑可口。','成分：紅豆餡（紅豆、糖）、麵粉、雞蛋、奶油、糖、蜂蜜、泡打粉',NULL,7,'sidebar\\picture1\\聖誕派對生乳銅鑼燒1.jpg','聖誕派對生乳銅鑼燒1.jpg'),(11,'草莓大福',2,200,'軟糯的外皮包裹著細緻的紅豆泥，再搭配鮮嫩多汁的草莓，酸甜交織，口感層次豐富，讓人忍不住一再回味。','成分：草莓、紅豆餡（紅豆、糖）、麻糬（糯米粉、糖、澱粉）','草莓新鮮、紅豆餡甜美，麻糬外皮柔軟且有彈性，三者完美融合，帶來酸甜與滑順的口感。',5,'products/picture2/草莓大福.jpg','草莓大福.jpg'),(12,'桔大福',2,200,'這款大福的特點是使用了新鮮的橘子作為內餡的搭配，增添了清爽的酸甜感。','成分：橘子、紅豆餡（紅豆、糖）、糯米粉、糖。',NULL,8,'products/picture2/桔大福.jpg','桔大福.jpg'),(13,'橘餅',2,150,'這款麻糬的外皮由糯米粉製成，橘子作為內餡，清新甜美，適合喜歡果香的人。','成分：橘子、糯米粉、糖、澱粉',NULL,10,'products/picture2/橘餅.jpg','橘餅.jpg'),(14,'金平糖',4,150,'色彩繽紛的糖果晶體，形狀可愛，口感脆甜，入口後糖香四溢，充滿童趣的經典日式零嘴。','成分：糖、色素（天然）。','金平糖由糖製成，經過多次滾動結晶形成多層糖晶，色彩繽紛，口感甜美。',5,'products/picture2/金平糖.jpg','金平糖.jpg'),(15,'栗子饅頭',4,80,'外皮為鬆軟的蒸餅，內餡由香甜的栗子和糖製成，帶有濃郁的栗子香。','成分：栗子、麵粉、糖、酵母、雞蛋、黃油。',NULL,11,'products/picture2/栗子饅頭.jpg','栗子饅頭.jpg'),(16,'抹茶蛋糕',4,210,'鬆軟濕潤的蛋糕散發著濃郁的抹茶香氣，甘甜與微苦完美平衡，帶來一抹清新的味覺享受。','成分：麵粉、抹茶粉、雞蛋、糖、牛奶、植物油、泡打粉。','蛋糕內含抹茶粉，帶有清香的抹茶味，結合鬆軟的蛋糕體，口感輕盈。',20,'products/picture2/抹茶蛋糕.jpg','抹茶蛋糕.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-03 21:23:03
