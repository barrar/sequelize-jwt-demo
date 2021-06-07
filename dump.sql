CREATE DATABASE  IF NOT EXISTS `hw2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hw2`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: hw2
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` int NOT NULL,
  `phone` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `subcategory` varchar(255) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ownerid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  CONSTRAINT `business_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caption` varchar(255) DEFAULT NULL,
  `userid` int NOT NULL,
  `businessid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `businessid` (`businessid`),
  CONSTRAINT `photo_ibfk_19` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photo_ibfk_20` FOREIGN KEY (`businessid`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dollars` int NOT NULL,
  `stars` int NOT NULL,
  `review` varchar(255) DEFAULT NULL,
  `userid` int NOT NULL,
  `businessid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `businessid` (`businessid`),
  CONSTRAINT `review_ibfk_19` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_20` FOREIGN KEY (`businessid`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin0','admin0@example.com','$2b$10$WSfRcrOKiBZskPY2r2TpZeXBuW7XDX5FEwU8OnniFubn.qaFSr1Za',1),(2,'admin1','admin1@example.com','$2b$10$G1bYRHsGKFiRYRmDfpyhruT32wjlvYGIjeJPTNUH3tEfln1terNpa',1),(3,'admin2','admin2@example.com','$2b$10$JiDSEEWLfmO.wCKVw15bm.lOGHXsUoamTUOCdaoPE7iTIssmy/8om',1),(4,'admin3','admin3@example.com','$2b$10$sAihgosWjxV4.Yq7Vc8MP.88I9Pk52dxqY/./rMZMejtgeH8fqex2',1),(5,'admin4','admin4@example.com','$2b$10$I0qfvWBQJzYyGbz6fOunu.VXdxuXcuJdXFiNghJSZB2pnOxB1ocnW',1),(6,'admin5','admin5@example.com','$2b$10$9WqDIuLWmFxcKTUuJMVb3O.b3LXDJ8LLwmWvXDL/E/n35JZXWDLoa',1),(7,'admin6','admin6@example.com','$2b$10$r0ngcldz0ozL3hLXJS7lu.M.UbJkBr7cpHUkhH6XXEVUTZp/IyWtO',1),(8,'admin7','admin7@example.com','$2b$10$8PyYyP3X6Potfar50zP2R.TJhvzbxkIXjbG7c..1uZGMFsdpv.T3y',1),(9,'admin8','admin8@example.com','$2b$10$dKJN28JEsfKKNHk9uGk4kufE7jfxIpMXLY26JdKKmc/HcG8QxGRYO',1),(10,'admin9','admin9@example.com','$2b$10$yaXv9ZcVNPFPNgFQNCmobuUeGBFtOh7luo3zdWfNAip9wagdwhxMO',1),(11,'admin10','admin10@example.com','$2b$10$LRcPutHptNBeqTxu0nIxLOm2sN68TP9CTMPvrVzBqHvymoqFEZCRa',1),(12,'admin11','admin11@example.com','$2b$10$v4EjOIqki7xDqGGrTOQYHe9QsfXthpcFthMMALpgdDnc7rh/ltjI.',1),(13,'admin12','admin12@example.com','$2b$10$g8TLRe1HY5jd7ovNxFXjZOmxbwgzCci8Yo/8dOxve5dAhBIRxUxMC',1),(14,'admin13','admin13@example.com','$2b$10$rtFxyQzWjDhU/9Wbd8A49ONMS7gy7Pz6LqgNyrxM3KGxHiLYEp4sG',1),(15,'admin14','admin14@example.com','$2b$10$kTOtzJo6UftvP8.uwt/SJ.RSRGyU9M.E1Jsy2DFRHTxrdsLBhfkum',1),(16,'admin15','admin15@example.com','$2b$10$0Fy1rPIaOADfPXb8GdBbyOvlFLfigCcEK4zThTBKr2IEhLE/O9Qdm',1),(17,'admin16','admin16@example.com','$2b$10$desTW60mSRyHIBtr8Qtlu.SxoWJnbRaouQh.Tf1ASy8xckM2SFw6i',1),(18,'admin17','admin17@example.com','$2b$10$XUpRk.TrpFHJOZzIxvXNh.QNJN0SSa4mdtqm.p3sAaW4pnbYYMRgW',1),(19,'admin18','admin18@example.com','$2b$10$Zb0w1F3QGMSitgT1mHMbku3qFFzjrg5gCY40C0v0MFvxMbTWZv9O2',1),(20,'admin19','admin19@example.com','$2b$10$oZs.mLwngHG.7BjBq9eE0.KsXXxdIBiHZwRuUpud8GBp27nbpzzg6',1),(21,'admin20','admin20@example.com','$2b$10$z/QZqRiw/XNSJb3lOtVZneix347nFREpmmv/QN92oqahdc4U47FNe',1),(22,'admin21','admin21@example.com','$2b$10$j85X5LlRDQ.zwU0GZ49OSeDR3Yxz71GVIosKQa1ntBCqY8jRMBLve',1),(23,'admin22','admin22@example.com','$2b$10$U0EXRhgMVi.5P9giS5mNt.xCEbVDFI0lbjserdkNjSIFj52sAY7gy',1),(24,'admin23','admin23@example.com','$2b$10$P2qz1lZMGS1oqxyF.FXshe3IsVGc0.Tnj5gmdDMM9.WLQ.lBeOLM2',1),(25,'admin24','admin24@example.com','$2b$10$STP.BgBCb/LMUP0VrWYmd.FP8U10UUKc8S2Qh1Nk7jz8fwiN5EIhO',1),(26,'admin25','admin25@example.com','$2b$10$yFBl1asf8vVWYOOQEB9YRehN2cwFb9fKYPHa2p7xtcU4Ldd52Bp9i',1),(27,'admin26','admin26@example.com','$2b$10$aGn3MI1Y8ZC2/ywOG5w.3etBg2S34Qkjpcx.XVgYr3tVLlCMFLzOC',1),(28,'admin27','admin27@example.com','$2b$10$3Op/lcPmISmw9ja/UFJiW.OjhLDCPqJnbO128IxZy/Z3IdAi8S0Gm',1),(29,'admin28','admin28@example.com','$2b$10$JwHA3QoujgYiY0ADhYfZee3gGYnj9zYPu2v9Aa2vqKD85Op2ZpAg2',1),(30,'admin29','admin29@example.com','$2b$10$JVhMyByDa22k.MHNbqeoeu2XK1rD30SYHDlUKM07RiXbEXF3gWOh2',1),(31,'admin30','admin30@example.com','$2b$10$1xtklqHSgW.jyFEFHIb/OOgJDMIJUhb5RZXMtBs59cQocaZ8uFolC',1),(32,'admin31','admin31@example.com','$2b$10$MyAGqeAx8rU5GNIRAQ8.cuv/emTGdOIl5Ss0a52.7t3hdUIABRtom',1),(33,'admin32','admin32@example.com','$2b$10$HCeTyPF1/cx9kG07O8lnJuJn2LE.h8WOz3SztOFyvT8eLggFYYR2K',1),(34,'admin33','admin33@example.com','$2b$10$O2QMIu5Ej4r1x7xymgcvU.i0e50yQ4IJvXy6gqrfwPmMCw3vqqoUa',1),(35,'admin34','admin34@example.com','$2b$10$uy/MLOLml428LGfZCX3k.OajtUPlCswET3Jux1PdsVhoMlNOZEdOO',1),(36,'admin35','admin35@example.com','$2b$10$f1q1cYH3HK.e..Lk1XvFSOe1VftfVL33ICM0wELmMp.p5Scl18PPa',1),(37,'admin36','admin36@example.com','$2b$10$juz0ZQNCSMRRQEznj1L4VuCsS9Ku1bZOrwrwYpNaqPYyY.Bc2WbR2',1),(38,'admin37','admin37@example.com','$2b$10$8TS6X.BvvziOH3OepHzaZeSfS2bkIf0Yp/iFAgsiKnPY2PR4Rng1y',1),(39,'admin38','admin38@example.com','$2b$10$FEmZOTqlpIqePI2n2W8vmebyOFrDqbW4ls3e3xxJ0ywa3wBVmbaMu',1),(40,'admin39','admin39@example.com','$2b$10$/Lvy5x64EmRU7kNi8C.E..OAN70fOwAOJIL5rKCwUo04OXLM4o5Pa',1),(41,'admin40','admin40@example.com','$2b$10$hy/WRreOFcvvMEYYEEPu6uxT2YIahXpDpiejJxtJFXgPuqKerJYP6',1),(42,'admin41','admin41@example.com','$2b$10$TMchcAtDA6vUglrXXAGleebOKE65mxjzJEZHAZenr8QPihfRTYmv2',1),(43,'admin42','admin42@example.com','$2b$10$UCnjIpffkJ1BSbuUVNTZGugbhXc2Vts4d9xzXcDOOVMvPRzyShrOO',1),(44,'admin43','admin43@example.com','$2b$10$D3eEWnUlg5ZOmv./n/DVuuOEp3vU9Yg9KKwrbHpk7Q.TmXDwbwTZ2',1),(45,'admin44','admin44@example.com','$2b$10$9diJVwMtTBLyMlsFH3wsJe6jkyC.Lzj6C2h35B7KIUEplh1eV2M5G',1),(46,'admin45','admin45@example.com','$2b$10$nWmBWr8U13W0ypuc5ebiQuC6yonehYLiTfByyPpfRa.EEhqh5lM/S',1),(47,'admin46','admin46@example.com','$2b$10$rkaWsANhh0Ki.a7Sc9NE1eQcIB8Z7uvA8JNHKH0pWwPvq7racyWo.',1),(48,'admin47','admin47@example.com','$2b$10$qgWEV9HmoLmtf1DMdugZDO.GycsrhASIODVloY6LknrRKtqpi2LZu',1),(49,'admin48','admin48@example.com','$2b$10$EsVPQYglPtCBmF/eNAOiD.cBBTDBGHaNVJLF9f/kVivOAKCWplLrq',1),(50,'admin49','admin49@example.com','$2b$10$vZ9AgwN8Xawv69aBw53Ch.RufuICg9aqWuazwoOtViDklnsTK4Ahm',1),(51,'user0','user0@example.com','$2b$10$5oSVxz6WJ08t.rmHLyD9YeRcn45b/rW4EbKLYltxvNZr0.zkttBry',0),(52,'user1','user1@example.com','$2b$10$XerVvwIuKuf4rxbT8Fe10.VIyridS.QtIJloa.9zmTrj0fDmyNRK.',0),(53,'user2','user2@example.com','$2b$10$ALSzuqr9278NXnCP24bBfeZCu.NV8tKweQf6CmrhVJ4V40Dpecdui',0),(54,'user3','user3@example.com','$2b$10$gY7cLbswI/3T3xmZ.FRk7Ov3xpiBGM0X8f/qEI6oE/aYenAlySsdu',0),(55,'user4','user4@example.com','$2b$10$HFtLtTje3Fs9YskClIf4KeSCIEfoQ4o06CopWcP7IuwBCsMnbIK1a',0),(56,'user5','user5@example.com','$2b$10$NVLiDmhT8024Cb9O16M3j.UOE7gnS1Pz3bWtwcs2wRnZ0cPQe.jxi',0),(57,'user6','user6@example.com','$2b$10$fGIFxRV8gzQ65uoBXR6eeuKqkpui8PmClVPQaSWLsTIWUdxQiKfZ2',0),(58,'user7','user7@example.com','$2b$10$2w4kwqpC.Uf9fu6TOA5NXuOs2vNIUtwXOOoIEBkRqd3bQPue/dtSe',0),(59,'user8','user8@example.com','$2b$10$A3JnhjpI5aW4fWlqn7xJNOoYkw77fBKztzoQJ77kBMtkL/lywZdAq',0),(60,'user9','user9@example.com','$2b$10$9EfoG47iX5u4Yk1.Ni.n7uvmCpT1kPdVwXLJDM.NYVZ3UyUyHW/hm',0),(61,'user10','user10@example.com','$2b$10$VpXE/xxZdrPuNqfPM1LyxelCiL5We2EiZxWlf0OXa5kR5QqAY/ayi',0),(62,'user11','user11@example.com','$2b$10$blwEaKiZjfa2RJrtF8oUm.u6UxDMQXMoTL2Kk6k5fX7bXNaswq1Nu',0),(63,'user12','user12@example.com','$2b$10$.X5ol3uGMPKJffwfOITTFuSkCDTrFRVNE4miX82Gk99eURqv6zEA.',0),(64,'user13','user13@example.com','$2b$10$a2Rm9s2Sr3apxOUeyoxn5.oU4VJVG3GCSKzyEwByTqvv1qxHcPd1O',0),(65,'user14','user14@example.com','$2b$10$pxkJTNBXeZZT6m9d.n2zruHzEwzLocqCar1jQiMojZ7jHKsPfS1/y',0),(66,'user15','user15@example.com','$2b$10$OnVX8.0Rg0uTycJUxk.5DO2P9T0qFoEGJIXdcTRF.BK2BPzplBoli',0),(67,'user16','user16@example.com','$2b$10$e/5zThhQqoYL.33QNqQX7.60ocx.RN2j.XLbMM8sPZsMNPAXtikVe',0),(68,'user17','user17@example.com','$2b$10$anAGTKZ4J/lW561Ja4JiS.VVC9xEgSPhGFSosGYA6roco.Km/5qqK',0),(69,'user18','user18@example.com','$2b$10$b4ZtIRUJC6F8EvELFXRFa.dYJpHGWG.PugKUKJ8R1gRhmi3rgp/Ea',0),(70,'user19','user19@example.com','$2b$10$9OCT/dogbr0r.wK3VwaYuOqBqgyp/AJyyfWzxntga5zy9kNMhYvvW',0),(71,'user20','user20@example.com','$2b$10$H.3Aj0Y079rZqRIKzdiwOegfEJPiJib8mOY4uqROlXQJs0frq115m',0),(72,'user21','user21@example.com','$2b$10$Ms2yYrMxVGVmCCveEW738ObarlUKVdObwzATZT3g6CNYDIAWWaIXS',0),(73,'user22','user22@example.com','$2b$10$TAOWObHNys0aq0vi7EcavuwKye8L5rUPXrU4byt4ApeyE26KYof.a',0),(74,'user23','user23@example.com','$2b$10$FB7i3Vp2BLXLJG7CGZIh9OXBuTlRP.P0iJXAN506WGWogP2ZBzAi.',0),(75,'user24','user24@example.com','$2b$10$CTauF7co7B6VPqx.DtgNEucMlSr9HxapspFko9TdWs9QUApMuHoP.',0),(76,'user25','user25@example.com','$2b$10$QfLVyb.I5Smnon7NPTNyLOlrTrBB3S1.03ZETPGx7Rk2zyYXDI9i2',0),(77,'user26','user26@example.com','$2b$10$1G/0Z7/j0YCa8iJgO/sh0Oz0QYH.QNwIsJ6rGbw5Uj42xE9Vjxqd2',0),(78,'user27','user27@example.com','$2b$10$/Aw.L1Jh1b7WEufswXOKTuSNIxON6aH2hDf7GXrmtHVWlk3cCJaza',0),(79,'user28','user28@example.com','$2b$10$.9Madj.swprVkiRW0XalGe1UFC/t4HHNKq2fEpzaDA495ve0z0jBe',0),(80,'user29','user29@example.com','$2b$10$iz59t6x7p6LAZvsqPvbtoe3FwKb4o/AnHiE77ibReUEsV11.SMxEK',0),(81,'user30','user30@example.com','$2b$10$ykZL5LdAjCGcDO6FiGqaQu4pT.CDy0heuMCNu1Q9DrP12wBZ8rxtO',0),(82,'user31','user31@example.com','$2b$10$MdiRPV5vEUlvglG41hV45uuVWn0aMqdW5r1TSjGB1tgfXOdAxi7lW',0),(83,'user32','user32@example.com','$2b$10$1756pVAerq9uKuSt.Fuo2umGIAY8Bb3X1YxCZ6cduyxcKBP5wb0tm',0),(84,'user33','user33@example.com','$2b$10$.V4QYSgaJ5x.sBFAWLt3MO9bedSRhKyirVIzJ1oa9Fuy6HHtG9Mjm',0),(85,'user34','user34@example.com','$2b$10$WhF8arVTrA7R.jKAhrIumONHin71BJbMjtq1ut5vx/kmtbLUM2Fva',0),(86,'user35','user35@example.com','$2b$10$v2zUR4UVSHJgAYFfd7wNyOUPMVNa5M721x42s6r55b78KuJZYlNgC',0),(87,'user36','user36@example.com','$2b$10$hd2vB7I96YpfEv3o80oS8epaEIqt.6NQ0KBwFbXE4nDDisey21Zm6',0),(88,'user37','user37@example.com','$2b$10$FYtEUtOZwXZTjSUcAtW1POYYZx0qnFyQZEN.yzcpVSh6giGn3EWPi',0),(89,'user38','user38@example.com','$2b$10$fNw2B3E5alSIrsSqTaauM.f8in1Zti/HqVKm20iSfsDxA40k34Br2',0),(90,'user39','user39@example.com','$2b$10$U5oLNUYMJ0jorneqwf8TNev3QDoSE.hGeXNonNdrlz/n2HUaCeQQK',0),(91,'user40','user40@example.com','$2b$10$iFSg7zxge/UGvFQ91KZHsOxuW4dNh.kb8D50aHhMU9wXvmG/d2ceO',0),(92,'user41','user41@example.com','$2b$10$ZVABo5eP4T0ICCfOtGu6me9MiAwRdcgmkuBfrf0drAba3EyqNSuhO',0),(93,'user42','user42@example.com','$2b$10$sYO.q7yrMwOO8UiQXvb40euTDNb5vZZrf7HCYukn8SWGHTpNbZBne',0),(94,'user43','user43@example.com','$2b$10$Rc5WqgnvGH7kDpjQPypAaetp6HH6Oea511Xa7PjL4/CYl3SGw.CtK',0),(95,'user44','user44@example.com','$2b$10$L.OhjfoYJaFkpZ6YeJ2sPOl7UHPqNSEpNGeOhxact2Ar64PjdllAC',0),(96,'user45','user45@example.com','$2b$10$HOPHE/g5iSZSGAXfORrVu.fJ4iT9HxvqdFqgS2xO0oQSMf3NRwxRq',0),(97,'user46','user46@example.com','$2b$10$ufiVNNG6nISxmnXQRhYk4u0LRYBriD9ecy3hZQiPLzVqu3wRwaOrm',0),(98,'user47','user47@example.com','$2b$10$WoA9lBmjJvP0anthoZMwo.Vpe8cRUdClZDZZmwvaRZbUFoDJ7wtEu',0),(99,'user48','user48@example.com','$2b$10$VV2O5OFMVFFhSUfPbxNMTe1uyqnZU2wiK8BN.FJT95AS8bPG0AHBG',0),(100,'user49','user49@example.com','$2b$10$10FFHiJxNfpKBqAi4Ym4V.ivlHCQf4v1eCQIrtvD3EHUC4.NKvO5y',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-17 21:52:28
LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'Block 15','300 SW Jefferson Ave.','Corvallis','OR',97333,'541-758-2077','Restaurant','Brewpub','http://block15.com',NULL,16),(2,'Corvallis Brewing Supply','119 SW 4th St.','Corvallis','OR',97333,'541-758-1674','Shopping','Brewing Supply','http://www.lickspigot.com',NULL,1),(3,'Robnett\'s Hardware','400 SW 2nd St.','Corvallis','OR',97333,'541-753-5531','Shopping','Hardware',NULL,NULL,2),(4,'First Alternative Co-op North Store','2855 NW Grant Ave.','Corvallis','OR',97330,'541-452-3115','Shopping','Groceries',NULL,NULL,3),(5,'WinCo Foods','2335 NW Kings Blvd.','Corvallis','OR',97330,'541-753-7002','Shopping','Groceries',NULL,NULL,4),(6,'Fred Meyer','777 NW Kings Blvd.','Corvallis','OR',97330,'541-753-9116','Shopping','Groceries',NULL,NULL,5),(7,'Interzone','1563 NW Monroe Ave.','Corvallis','OR',97330,'541-754-5965','Restaurant','Coffee Shop',NULL,NULL,6),(8,'The Beanery Downtown','500 SW 2nd St.','Corvallis','OR',97333,'541-753-7442','Restaurant','Coffee Shop',NULL,NULL,7),(9,'Local Boyz','1425 NW Monroe Ave.','Corvallis','OR',97330,'541-754-5338','Restaurant','Hawaiian',NULL,NULL,8),(10,'Darkside Cinema','215 SW 4th St.','Corvallis','OR',97333,'541-752-4161','Entertainment','Movie Theater','http://darksidecinema.com',NULL,9),(11,'The Book Bin','215 SW 4th St.','Corvallis','OR',97333,'541-752-0040','Shopping','Book Store',NULL,NULL,10),(12,'Cyclotopia','435 SW 2nd St.','Corvallis','OR',97333,'541-757-9694','Shopping','Bicycle Shop',NULL,NULL,11),(13,'Corvallis Cyclery','344 SW 2nd St.','Corvallis','OR',97333,'541-752-5952','Shopping','Bicycle Shop',NULL,NULL,12),(14,'Oregon Coffee & Tea','215 NW Monroe Ave.','Corvallis','OR',97333,'541-752-2421','Shopping','Tea House','http://www.oregoncoffeeandtea.com',NULL,13),(15,'Spaeth Lumber','1585 NW 9th St.','Corvallis','OR',97330,'541-752-1930','Shopping','Hardware',NULL,NULL,14),(16,'New Morning Bakery','219 SW 2nd St.','Corvallis','OR',97333,'541-754-0181','Restaurant','Bakery',NULL,NULL,15),(17,'First Alternative Co-op South Store','1007 SE 3rd St.','Corvallis','OR',97333,'541-753-3115','Shopping','Groceries',NULL,NULL,3),(18,'The Beanery Monroe','2541 NW Monroe Ave.','Corvallis','OR',97330,'541-757-0828','Restaurant','Coffee Shop',NULL,NULL,7),(19,'Block 15 Brewery & Tap Room','3415 SW Deschutes St.','Corvallis','OR',97333,'541-752-2337','Restaurant','Brewpub','http://block15.com',NULL,16);
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (1,'This is my dinner.',7,8),(2,NULL,25,2),(3,'Hops',26,1),(4,NULL,21,14),(5,'Sticky Hands',28,18),(6,'Popcorn!',21,9),(7,NULL,26,8),(8,'Big fermentor',25,18),(9,NULL,20,2),(10,'Cake!',6,15);
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,4,'Cheap, delicious food.',7,8),(2,1,4,'How many fasteners can one room hold?',25,2),(3,1,5,'Joel, the owner, is super friendly and helpful.',26,1),(4,2,4,NULL,21,14),(5,1,4,'Good beer, good food, though limited selection.',28,18),(6,1,5,'A Corvallis gem.',21,9),(7,1,5,'Yummmmmmm!',26,8),(8,2,4,NULL,25,18),(9,2,4,NULL,20,2),(10,2,5,'Try the hazlenut torte.  It\'s the best!',6,15);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;