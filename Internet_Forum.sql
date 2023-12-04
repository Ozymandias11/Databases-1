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


-- Dumping database structure for internet forum
CREATE DATABASE IF NOT EXISTS `internet forum` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */;
USE `internet forum`;

-- Dumping structure for table internet forum.forum
CREATE TABLE IF NOT EXISTS `forum` (
  `forumID` tinyint(3) unsigned NOT NULL,
  `formuTitle` varchar(50) NOT NULL,
  `forum_description` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  PRIMARY KEY (`forumID`),
  UNIQUE KEY `userName` (`userName`),
  CONSTRAINT `FK_forum_user` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table internet forum.forum: ~0 rows (approximately)
DELETE FROM `forum`;

-- Dumping structure for table internet forum.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `postNumber` tinyint(5) unsigned NOT NULL,
  `forumID` tinyint(5) unsigned NOT NULL,
  `userName` varchar(50) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`postNumber`,`forumID`),
  KEY `FK_likes_post` (`userName`) USING BTREE,
  KEY `postNumber` (`postNumber`),
  KEY `FK_likes_forum` (`forumID`),
  CONSTRAINT `FK_likes_forum` FOREIGN KEY (`forumID`) REFERENCES `forum` (`forumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_likes_post` FOREIGN KEY (`postNumber`) REFERENCES `post` (`postNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_likes_user` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table internet forum.likes: ~0 rows (approximately)
DELETE FROM `likes`;

-- Dumping structure for table internet forum.post
CREATE TABLE IF NOT EXISTS `post` (
  `postNumber` tinyint(5) unsigned NOT NULL,
  `forumID` tinyint(3) unsigned NOT NULL,
  `postTitle` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `content` varchar(50) NOT NULL,
  `referredPostNumber` tinyint(5) unsigned DEFAULT NULL,
  `userName` varchar(50) NOT NULL,
  PRIMARY KEY (`postNumber`,`forumID`),
  KEY `FK_post_post` (`referredPostNumber`),
  KEY `FK_post_user` (`userName`),
  KEY `FK_post_forum` (`forumID`),
  CONSTRAINT `FK_post_forum` FOREIGN KEY (`forumID`) REFERENCES `forum` (`forumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_post_post` FOREIGN KEY (`referredPostNumber`) REFERENCES `post` (`postNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_post_user` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table internet forum.post: ~0 rows (approximately)
DELETE FROM `post`;

-- Dumping structure for table internet forum.register
CREATE TABLE IF NOT EXISTS `register` (
  `forumID` tinyint(5) unsigned NOT NULL,
  `userName` varchar(50) NOT NULL,
  `regDate` date NOT NULL,
  PRIMARY KEY (`forumID`,`userName`),
  KEY `FK_register_forum` (`forumID`),
  KEY `FK_register_user` (`userName`),
  CONSTRAINT `FK_register_forum` FOREIGN KEY (`forumID`) REFERENCES `forum` (`forumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_register_user` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table internet forum.register: ~0 rows (approximately)
DELETE FROM `register`;

-- Dumping structure for table internet forum.user
CREATE TABLE IF NOT EXISTS `user` (
  `userName` varchar(50) NOT NULL,
  `isModerator` tinyint(1) unsigned NOT NULL,
  `userMail` varchar(50) NOT NULL,
  `selfDescription` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table internet forum.user: ~0 rows (approximately)
DELETE FROM `user`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
