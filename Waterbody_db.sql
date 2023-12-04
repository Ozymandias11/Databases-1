-- --------------------------------------------------------
-- ჰოსტი:                        127.0.0.1
-- Server version:               11.3.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL ვერსია:              12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for waterbody
CREATE DATABASE IF NOT EXISTS `waterbody` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `waterbody`;

-- Dumping structure for table waterbody.country
CREATE TABLE IF NOT EXISTS `country` (
  `countryCode` char(2) NOT NULL,
  `countryName` varchar(40) NOT NULL,
  PRIMARY KEY (`countryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.country: ~0 rows (approximately)
DELETE FROM `country`;

-- Dumping structure for table waterbody.finances
CREATE TABLE IF NOT EXISTS `finances` (
  `orgID` int(10) unsigned NOT NULL,
  `projectID` int(10) unsigned NOT NULL,
  `percentage` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orgID`,`projectID`),
  KEY `projectID` (`projectID`),
  CONSTRAINT `finances_ibfk_1` FOREIGN KEY (`orgID`) REFERENCES `organization` (`orgID`),
  CONSTRAINT `finances_ibfk_2` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.finances: ~0 rows (approximately)
DELETE FROM `finances`;

-- Dumping structure for table waterbody.organization
CREATE TABLE IF NOT EXISTS `organization` (
  `orgID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orgName` varchar(80) NOT NULL,
  `countryCode` char(2) NOT NULL,
  PRIMARY KEY (`orgID`),
  KEY `countryCode` (`countryCode`),
  CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`countryCode`) REFERENCES `country` (`countryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.organization: ~0 rows (approximately)
DELETE FROM `organization`;

-- Dumping structure for table waterbody.project
CREATE TABLE IF NOT EXISTS `project` (
  `projectID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projectTitle` varchar(150) NOT NULL,
  `totalCost` decimal(12,2) NOT NULL,
  PRIMARY KEY (`projectID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.project: ~2 rows (approximately)
DELETE FROM `project`;
INSERT INTO `project` (`projectID`, `projectTitle`, `totalCost`) VALUES
	(1, 'Research on sodium content of water bodies in Georgia.', 100000.00),
	(2, 'water quality', 2000000.00);

-- Dumping structure for table waterbody.researcher
CREATE TABLE IF NOT EXISTS `researcher` (
  `rEmail` varchar(80) NOT NULL,
  `rName` varchar(80) NOT NULL,
  `orgID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rEmail`),
  KEY `orgID` (`orgID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.researcher: ~0 rows (approximately)
DELETE FROM `researcher`;

-- Dumping structure for table waterbody.researchtest
CREATE TABLE IF NOT EXISTS `researchtest` (
  `projectID` int(10) unsigned NOT NULL,
  `waterID` int(10) unsigned NOT NULL,
  KEY `FK_researchtest_project` (`projectID`),
  CONSTRAINT `FK_researchtest_project` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.researchtest: ~0 rows (approximately)
DELETE FROM `researchtest`;

-- Dumping structure for table waterbody.runningwater
CREATE TABLE IF NOT EXISTS `runningwater` (
  `waterID` int(10) unsigned NOT NULL,
  `waterName` varchar(50) NOT NULL,
  `quality` tinyint(4) DEFAULT NULL,
  `length` int(10) unsigned DEFAULT NULL,
  `flowRate` float DEFAULT NULL,
  `flowsInto` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`waterID`),
  KEY `flowsInto` (`flowsInto`),
  CONSTRAINT `runningwater_ibfk_1` FOREIGN KEY (`flowsInto`) REFERENCES `runningwater` (`waterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.runningwater: ~8 rows (approximately)
DELETE FROM `runningwater`;
INSERT INTO `runningwater` (`waterID`, `waterName`, `quality`, `length`, `flowRate`, `flowsInto`) VALUES
	(1000, 'Rioni', 0, 400, 1.78, NULL),
	(1001, 'Mtkavri', 0, 560, 1.365, NULL),
	(1002, 'Aragvi', 0, 120, 4.685, 1001),
	(1003, 'MtisChala', NULL, NULL, NULL, 1010),
	(1004, 'Alasani', 0, 1000, 0.54, 1004),
	(1005, 'Kvirila', NULL, NULL, NULL, 1000),
	(1010, 'Tskatsitela', NULL, NULL, NULL, 1005),
	(1015, 'Enguri', NULL, NULL, NULL, 1000);

-- Dumping structure for table waterbody.rw_research
CREATE TABLE IF NOT EXISTS `rw_research` (
  `projectID` int(10) unsigned NOT NULL,
  `waterID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`projectID`,`waterID`),
  KEY `waterID` (`waterID`),
  CONSTRAINT `rw_research_ibfk_1` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`) ON UPDATE CASCADE,
  CONSTRAINT `rw_research_ibfk_2` FOREIGN KEY (`waterID`) REFERENCES `runningwater` (`waterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.rw_research: ~2 rows (approximately)
DELETE FROM `rw_research`;
INSERT INTO `rw_research` (`projectID`, `waterID`) VALUES
	(1, 1001),
	(2, 1004);

-- Dumping structure for table waterbody.standingwater
CREATE TABLE IF NOT EXISTS `standingwater` (
  `waterID` int(10) unsigned NOT NULL,
  `waterName` varchar(50) NOT NULL,
  `quality` tinyint(4) NOT NULL,
  `surface` int(11) DEFAULT NULL,
  PRIMARY KEY (`waterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.standingwater: ~2 rows (approximately)
DELETE FROM `standingwater`;
INSERT INTO `standingwater` (`waterID`, `waterName`, `quality`, `surface`) VALUES
	(2000, 'KIU_lake', 0, NULL),
	(2001, 'KoditskaroLake', 0, NULL);

-- Dumping structure for table waterbody.sw_research
CREATE TABLE IF NOT EXISTS `sw_research` (
  `projectID` int(10) unsigned NOT NULL,
  `waterID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`projectID`,`waterID`),
  KEY `waterID` (`waterID`),
  CONSTRAINT `sw_research_ibfk_1` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`) ON UPDATE CASCADE,
  CONSTRAINT `sw_research_ibfk_2` FOREIGN KEY (`waterID`) REFERENCES `standingwater` (`waterID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.sw_research: ~2 rows (approximately)
DELETE FROM `sw_research`;
INSERT INTO `sw_research` (`projectID`, `waterID`) VALUES
	(1, 2000),
	(1, 2001);

-- Dumping structure for table waterbody.workson
CREATE TABLE IF NOT EXISTS `workson` (
  `rEmail` varchar(80) NOT NULL,
  `projectID` int(10) unsigned NOT NULL,
  `function` tinytext NOT NULL,
  PRIMARY KEY (`rEmail`,`projectID`),
  KEY `projectID` (`projectID`),
  CONSTRAINT `workson_ibfk_1` FOREIGN KEY (`rEmail`) REFERENCES `researcher` (`rEmail`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `workson_ibfk_2` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table waterbody.workson: ~0 rows (approximately)
DELETE FROM `workson`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
