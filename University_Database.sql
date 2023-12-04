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


-- Dumping database structure for university_database
CREATE DATABASE IF NOT EXISTS `university_database` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */;
USE `university_database`;

-- Dumping structure for table university_database.assistant
CREATE TABLE IF NOT EXISTS `assistant` (
  `assistantID` tinyint(5) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `researchArea` varchar(30) NOT NULL,
  `profID` tinyint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`assistantID`),
  KEY `FK_assistant_proffessor` (`profID`),
  CONSTRAINT `FK_assistant_proffessor` FOREIGN KEY (`profID`) REFERENCES `proffessor` (`profID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.assistant: ~0 rows (approximately)
DELETE FROM `assistant`;

-- Dumping structure for table university_database.course
CREATE TABLE IF NOT EXISTS `course` (
  `courseID` tinyint(5) unsigned NOT NULL,
  `contactHours` time NOT NULL,
  `title` varchar(50) NOT NULL,
  `profID` tinyint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`courseID`),
  KEY `FK_course_proffessor` (`profID`),
  CONSTRAINT `FK_course_proffessor` FOREIGN KEY (`profID`) REFERENCES `proffessor` (`profID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.course: ~0 rows (approximately)
DELETE FROM `course`;

-- Dumping structure for table university_database.courserequirement
CREATE TABLE IF NOT EXISTS `courserequirement` (
  `parent_course_id` tinyint(5) unsigned NOT NULL,
  `child_course_id` tinyint(5) unsigned NOT NULL,
  PRIMARY KEY (`parent_course_id`,`child_course_id`),
  KEY `FK_courserequirement_course_2` (`child_course_id`),
  CONSTRAINT `FK_courserequirement_course` FOREIGN KEY (`parent_course_id`) REFERENCES `course` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_courserequirement_course_2` FOREIGN KEY (`child_course_id`) REFERENCES `course` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.courserequirement: ~0 rows (approximately)
DELETE FROM `courserequirement`;

-- Dumping structure for table university_database.enrollment
CREATE TABLE IF NOT EXISTS `enrollment` (
  `courseID` tinyint(5) unsigned NOT NULL,
  `studentID` tinyint(5) unsigned NOT NULL,
  PRIMARY KEY (`courseID`,`studentID`),
  KEY `FK_enrollment_course` (`courseID`),
  KEY `FK_enrollment_student` (`studentID`),
  CONSTRAINT `FK_enrollment_course` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_enrollment_student` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.enrollment: ~0 rows (approximately)
DELETE FROM `enrollment`;

-- Dumping structure for table university_database.examination
CREATE TABLE IF NOT EXISTS `examination` (
  `studID` tinyint(5) unsigned NOT NULL,
  `courseID` tinyint(5) unsigned NOT NULL,
  `grade` tinyint(3) unsigned DEFAULT NULL,
  `points` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`studID`,`courseID`),
  KEY `FK_examination_course` (`courseID`) USING BTREE,
  KEY `FK_examination_student` (`studID`),
  CONSTRAINT `FK_examination_course` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_examination_student` FOREIGN KEY (`studID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.examination: ~0 rows (approximately)
DELETE FROM `examination`;

-- Dumping structure for table university_database.proffessor
CREATE TABLE IF NOT EXISTS `proffessor` (
  `profID` tinyint(5) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `rank` varchar(50) NOT NULL,
  PRIMARY KEY (`profID`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.proffessor: ~0 rows (approximately)
DELETE FROM `proffessor`;

-- Dumping structure for table university_database.student
CREATE TABLE IF NOT EXISTS `student` (
  `studentID` tinyint(5) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `semester` tinyint(1) NOT NULL,
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table university_database.student: ~0 rows (approximately)
DELETE FROM `student`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
