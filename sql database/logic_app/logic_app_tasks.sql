-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: logic_app
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `Question` text NOT NULL,
  `Option1` text,
  `Option2` text,
  `Option3` text,
  `Option4` text,
  `AnswerIndex` int NOT NULL,
  `Explanation` text,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Given the statements: ∀x (P(x) → Q(x)) and ∃x P(x), which of the following must be true?','∀x Q(x)','∃x Q(x)','∃x ¬Q(x)','∀x ¬P(x)',1,'If for every x, P(x) implies Q(x), and there exists an x such that P(x) is true, then there must exist an x such that Q(x) is true.'),(2,'Given the statements: ∀x (P(x) → R(x)) and ∀x (Q(x) → R(x)), which of the following must be true?','∀x (P(x) ∧ Q(x) → R(x))','∃x (P(x) ∧ Q(x))','∀x (P(x) ∨ Q(x) → R(x))','∃x ¬R(x)',0,'If R(x) is true whenever P(x) or Q(x) is true, then R(x) must also be true when both P(x) and Q(x) are true.'),(3,'Given the statements: ∃x P(x) and ∀x (P(x) → Q(x)), which of the following must be true?','∀x Q(x)','∃x Q(x)','∃x ¬Q(x)','∀x ¬P(x)',1,'If there exists an x such that P(x) is true, and for every x, P(x) implies Q(x), then there must exist an x such that Q(x) is true.'),(4,'Which of the following is the contrapositive of the statement ∀x (P(x) → Q(x))?','∀x (¬P(x) → ¬Q(x))','∀x (Q(x) → P(x))','∀x (¬Q(x) → ¬P(x))','∃x (P(x) ∧ ¬Q(x))',2,'The contrapositive of \'if P then Q\' is \'if not Q then not P\'.'),(5,'Given the statements: ∀x (P(x) → Q(x)) and ∀x ¬Q(x), which of the following must be true?','∀x ¬P(x)','∃x P(x)','∀x (P(x) ∧ Q(x))','∃x ¬P(x)',0,'If for every x, P(x) implies Q(x), and for every x, Q(x) is false, then for every x, P(x) must also be false.'),(6,'Which of the following is equivalent to the statement ¬∃x P(x)?','∀x ¬P(x)','∀x P(x)','∃x ¬P(x)','∃x (P(x) ∧ Q(x))',0,'The statement \'there does not exist an x such that P(x) is true\' is equivalent to \'for all x, P(x) is false\'.'),(7,'Given the statements: ∀x (P(x) → Q(x)) and ∃x ¬P(x), which of the following must be true?','∃x ¬Q(x)','∀x Q(x)','∃x Q(x)','∀x (P(x) ∧ Q(x))',2,'If there exists an x such that P(x) is false, and for every x, P(x) implies Q(x), then there might exist an x such that Q(x) is true, but it\'s not guaranteed.'),(8,'Which of the following is the negation of the statement ∀x P(x)?','∃x ¬P(x)','∀x ¬P(x)','∃x P(x)','¬∀x P(x)',0,'The negation of \'for all x, P(x) is true\' is \'there exists an x such that P(x) is false\'.'),(9,'Given the statements: ∀x (P(x) → Q(x)) and ∀x (R(x) → S(x)), which of the following must be true?','∀x ((P(x) ∨ R(x)) → (Q(x) ∨ S(x)))','∀x (P(x) ∧ R(x) → Q(x) ∧ S(x))','∃x (P(x) ∧ R(x))','∀x (Q(x) → S(x))',0,'If for every x, P(x) implies Q(x) and R(x) implies S(x), then for every x, P(x) or R(x) implies Q(x) or S(x).'),(10,'Given the statements: ∃x P(x) and ∃x Q(x), which of the following must be true?','∃x (P(x) ∧ Q(x))','∀x (P(x) → Q(x))','∃x (P(x) ∨ Q(x))','∀x ¬P(x)',2,'If there exists an x such that P(x) is true and there exists an x such that Q(x) is true, then there must exist an x such that P(x) or Q(x) is true.'),(11,'Which of the following is the converse of the statement ∀x (P(x) → Q(x))?','∀x (Q(x) → P(x))','∀x (¬P(x) → ¬Q(x))','∀x (¬Q(x) → ¬P(x))','∃x (P(x) ∧ ¬Q(x))',0,'The converse of \'if P then Q\' is \'if Q then P\'.');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-22  3:58:04
