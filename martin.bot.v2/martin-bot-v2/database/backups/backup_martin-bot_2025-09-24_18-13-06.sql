-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: martin-bot
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `application_state`
--

DROP TABLE IF EXISTS `application_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_state` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_state`
--

LOCK TABLES `application_state` WRITE;
/*!40000 ALTER TABLE `application_state` DISABLE KEYS */;
INSERT INTO `application_state` VALUES (1,'created'),(2,'rejected'),(3,'accepted');
/*!40000 ALTER TABLE `application_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_user`
--

DROP TABLE IF EXISTS `application_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_user_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_user`
--

LOCK TABLES `application_user` WRITE;
/*!40000 ALTER TABLE `application_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `callback_query`
--

DROP TABLE IF EXISTS `callback_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `callback_query` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `chat_id` bigint unsigned DEFAULT NULL,
  `message_id` bigint unsigned DEFAULT NULL,
  `inline_message_id` char(255) DEFAULT NULL,
  `chat_instance` char(255) NOT NULL DEFAULT '',
  `data` char(255) NOT NULL DEFAULT '',
  `game_short_name` char(255) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cbq_user` (`user_id`),
  KEY `idx_cbq_chat` (`chat_id`),
  KEY `idx_cbq_msg` (`message_id`),
  KEY `IDX_D36CF3A11A9A7125537A1329` (`chat_id`,`message_id`),
  CONSTRAINT `fk_cbq_msg` FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`),
  CONSTRAINT `fk_cbq_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `callback_query`
--

LOCK TABLES `callback_query` WRITE;
/*!40000 ALTER TABLE `callback_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `callback_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `id` bigint unsigned NOT NULL COMMENT 'Unique identifier for this chat',
  `type` enum('private','group','supergroup','channel') NOT NULL,
  `title` char(255) NOT NULL DEFAULT '' COMMENT 'Title, for supergroups, channels and group chats',
  `username` char(255) DEFAULT NULL COMMENT 'Username, if available',
  `first_name` char(255) DEFAULT NULL,
  `last_name` char(255) DEFAULT NULL,
  `is_forum` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Supergroup chat is a forum',
  `all_members_are_administrators` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL COMMENT 'Filled when a group is converted to a supergroup',
  PRIMARY KEY (`id`),
  KEY `idx_chat_old_id` (`old_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (990082777,'private','','dmitrij_tar','Дима Т.',NULL,0,0,'2025-09-21 15:55:03','2025-09-21 15:55:12',NULL),(1854044544,'private','','jnelty','vladislav',NULL,0,0,'2025-09-16 21:02:09','2025-09-24 17:07:14',NULL);
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_boost_removed`
--

DROP TABLE IF EXISTS `chat_boost_removed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_boost_removed` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `boost_id` varchar(200) NOT NULL,
  `remove_date` datetime NOT NULL,
  `source` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cbr_chat` (`chat_id`),
  CONSTRAINT `fk_cbr_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_boost_removed`
--

LOCK TABLES `chat_boost_removed` WRITE;
/*!40000 ALTER TABLE `chat_boost_removed` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_boost_removed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_boost_updated`
--

DROP TABLE IF EXISTS `chat_boost_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_boost_updated` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `boost` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cbu_chat` (`chat_id`),
  CONSTRAINT `fk_cbu_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_boost_updated`
--

LOCK TABLES `chat_boost_updated` WRITE;
/*!40000 ALTER TABLE `chat_boost_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_boost_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_join_request`
--

DROP TABLE IF EXISTS `chat_join_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_join_request` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `date` datetime NOT NULL,
  `bio` longtext,
  `invite_link` longtext,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_17D98D7E1A9A7125` (`chat_id`),
  KEY `IDX_17D98D7EA76ED395` (`user_id`),
  CONSTRAINT `fk_cjr_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_cjr_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_join_request`
--

LOCK TABLES `chat_join_request` WRITE;
/*!40000 ALTER TABLE `chat_join_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_join_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_member_updated`
--

DROP TABLE IF EXISTS `chat_member_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_member_updated` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `date` datetime NOT NULL,
  `old_chat_member` longtext NOT NULL,
  `new_chat_member` longtext NOT NULL,
  `invite_link` longtext,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6F99AF7E1A9A7125` (`chat_id`),
  KEY `IDX_6F99AF7EA76ED395` (`user_id`),
  CONSTRAINT `fk_cmu_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_cmu_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_member_updated`
--

LOCK TABLES `chat_member_updated` WRITE;
/*!40000 ALTER TABLE `chat_member_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_member_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chosen_inline_result`
--

DROP TABLE IF EXISTS `chosen_inline_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chosen_inline_result` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `result_id` char(255) NOT NULL DEFAULT '',
  `user_id` bigint unsigned DEFAULT NULL,
  `location` char(255) DEFAULT NULL,
  `inline_message_id` char(255) DEFAULT NULL,
  `query` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cir_user` (`user_id`),
  CONSTRAINT `fk_cir_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chosen_inline_result`
--

LOCK TABLES `chosen_inline_result` WRITE;
/*!40000 ALTER TABLE `chosen_inline_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `chosen_inline_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `chat_id` bigint unsigned DEFAULT NULL,
  `status` varchar(32) DEFAULT 'active',
  `command` varchar(160) NOT NULL DEFAULT '',
  `notes` longtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_conv_user` (`user_id`),
  KEY `idx_conv_chat` (`chat_id`),
  KEY `idx_conv_status` (`status`),
  CONSTRAINT `fk_conv_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_conv_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_request_form`
--

DROP TABLE IF EXISTS `conversation_request_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation_request_form` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint unsigned NOT NULL COMMENT 'Unique conversation identifier',
  `room_number` smallint DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7DC4B4F49AC0396` (`conversation_id`),
  KEY `IDX_7DC4B4F49AC0396` (`conversation_id`),
  CONSTRAINT `fk_conversation_martin_conversation_request_form` FOREIGN KEY (`conversation_id`) REFERENCES `martin_conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_request_form`
--

LOCK TABLES `conversation_request_form` WRITE;
/*!40000 ALTER TABLE `conversation_request_form` DISABLE KEYS */;
INSERT INTO `conversation_request_form` VALUES (2,2,56,'Рнн','Мпен'),(4,11,45,'Vft','Cfhh'),(5,14,35,'Trt','Frt'),(6,15,67,'Прао','Впоылы'),(7,16,67,'Прн','Ть'),(10,23,67,'Yeysys','Dujdjs'),(11,24,45,'Gshehs','31'),(13,29,228,'Дмитрий','Кузнецов'),(14,31,45,'Пен','Панг');
/*!40000 ALTER TABLE `conversation_request_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edited_message`
--

DROP TABLE IF EXISTS `edited_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edited_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `message_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `edit_date` datetime DEFAULT NULL,
  `text` longtext,
  `entities` longtext,
  `caption` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_em_chat` (`chat_id`),
  KEY `idx_em_msg` (`message_id`),
  KEY `idx_em_user` (`user_id`),
  KEY `IDX_7D194E541A9A7125537A1329` (`chat_id`,`message_id`),
  CONSTRAINT `fk_em_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_em_msg` FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`),
  CONSTRAINT `fk_em_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edited_message`
--

LOCK TABLES `edited_message` WRITE;
/*!40000 ALTER TABLE `edited_message` DISABLE KEYS */;
INSERT INTO `edited_message` VALUES (1,1854044544,3545,1854044544,'2025-09-17 21:09:05','8A:92:D9:DE:8D:0F',NULL,NULL);
/*!40000 ALTER TABLE `edited_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
INSERT INTO `failed_jobs` VALUES (1,'3ad48f9d-e6d0-48d0-be97-5104969204c5','redis','default','{\"uuid\":\"3ad48f9d-e6d0-48d0-be97-5104969204c5\",\"timeout\":null,\"id\":\"EBoa8w6zDxBXBNgAwC50l6uGj1EFxgDE\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:12:18'),(2,'c806cf5e-d55a-44d2-b467-c49783d8a9a0','redis','default','{\"uuid\":\"c806cf5e-d55a-44d2-b467-c49783d8a9a0\",\"timeout\":null,\"id\":\"jvgbfqSMPhdznQjwB0cA3Pu2mGkFZdr7\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"accepted\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:12:18'),(3,'ed043814-3b19-4629-888b-e0faaa811256','redis','default','{\"uuid\":\"ed043814-3b19-4629-888b-e0faaa811256\",\"timeout\":null,\"id\":\"RTKG67YSwZul3KLQraysEW3u9vjuwOb4\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:12:18'),(4,'4b3da147-b8a1-46c8-b5ee-4453faafc18e','redis','default','{\"uuid\":\"4b3da147-b8a1-46c8-b5ee-4453faafc18e\",\"timeout\":null,\"id\":\"Nugt6HqLmfAKOKQbV9dz3tHq1dddFTrh\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"accepted\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:14:22'),(5,'59fe6048-d237-4615-b6e7-6ab3130affdf','redis','default','{\"uuid\":\"59fe6048-d237-4615-b6e7-6ab3130affdf\",\"timeout\":null,\"id\":\"Rb8yo46kNSZh5N3xALy7wtj2x14bDayV\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:14:22'),(6,'e80928b9-a6d9-4bc4-bd3a-7d0ec92ab310','redis','default','{\"uuid\":\"e80928b9-a6d9-4bc4-bd3a-7d0ec92ab310\",\"timeout\":null,\"id\":\"pCUWfzcQ8rL7u2BodokA2J5W6X0IXVJY\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:14:22'),(7,'44a5783b-8575-421b-a1e2-a60d889c8367','redis','default','{\"uuid\":\"44a5783b-8575-421b-a1e2-a60d889c8367\",\"timeout\":null,\"id\":\"7Enjod5LqjQeDXZ5b2XBUP2LiZc4emhF\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:16:23'),(8,'b2bccdf2-8ba9-4210-9f81-78b4d19c8cc8','redis','default','{\"uuid\":\"b2bccdf2-8ba9-4210-9f81-78b4d19c8cc8\",\"timeout\":null,\"id\":\"PvVL2flbLYPSDnviwqT4shFcyGRwCPML\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"rejected\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:16:23'),(9,'d3da40e0-7806-458f-8f49-a3aa2f31e0d8','redis','default','{\"uuid\":\"d3da40e0-7806-458f-8f49-a3aa2f31e0d8\",\"timeout\":null,\"id\":\"kjMludCTDs6CeK2gN2RIrZLkU95XrXBa\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:42:\\\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\\":2:{s:55:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000application\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:41:\\\"App\\\\Models\\\\Application\\\\PaymentApplication\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:49:\\\"\\u0000App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\\u0000state\\\";s:8:\\\"accepted\\\";}\",\"commandName\":\"App\\\\Jobs\\\\ProcessApplicationStatusUpdateJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}','Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\ProcessApplicationStatusUpdateJob has been attempted too many times. in /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/MaxAttemptsExceededException.php:24\nStack trace:\n#0 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob()\n#1 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException()\n#2 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts()\n#3 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(389): Illuminate\\Queue\\Worker->process()\n#4 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(176): Illuminate\\Queue\\Worker->runJob()\n#5 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon()\n#6 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#7 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure()\n#10 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#11 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Container/Container.php(662): Illuminate\\Container\\BoundMethod::call()\n#12 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#13 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Command/Command.php(326): Illuminate\\Console\\Command->execute()\n#14 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#15 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(1096): Illuminate\\Console\\Command->run()\n#16 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand()\n#17 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/symfony/console/Application.php(175): Symfony\\Component\\Console\\Application->doRun()\n#18 /home/vladislav/PhpStormProjects/martin-bot-application/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(201): Symfony\\Component\\Console\\Application->run()\n#19 /home/vladislav/PhpStormProjects/martin-bot-application/artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle()\n#20 {main}','2025-09-21 22:16:23');
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inline_query`
--

DROP TABLE IF EXISTS `inline_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inline_query` (
  `id` bigint unsigned NOT NULL COMMENT 'Unique identifier for this query',
  `user_id` bigint unsigned DEFAULT NULL,
  `location` char(255) DEFAULT NULL,
  `query` longtext NOT NULL,
  `offset` char(255) DEFAULT NULL,
  `chat_type` char(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_inline_user` (`user_id`),
  CONSTRAINT `fk_inline_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inline_query`
--

LOCK TABLES `inline_query` WRITE;
/*!40000 ALTER TABLE `inline_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `inline_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mac_application`
--

DROP TABLE IF EXISTS `mac_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mac_application` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `conversation_id` bigint unsigned NOT NULL,
  `application_text` longtext,
  `application_state_id` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4A3B45979AC0396` (`conversation_id`),
  KEY `IDX_4A3B4597BAE3E3D2` (`application_state_id`),
  CONSTRAINT `fk_application_state_mac_application` FOREIGN KEY (`application_state_id`) REFERENCES `application_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_martin_conversation_mac_application` FOREIGN KEY (`conversation_id`) REFERENCES `martin_conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mac_application`
--

LOCK TABLES `mac_application` WRITE;
/*!40000 ALTER TABLE `mac_application` DISABLE KEYS */;
INSERT INTO `mac_application` VALUES (1,1,2,'00:1A:2B:3C:4D:5E',3),(2,1,11,'8A:92:D9:DE:8D:0F; 8A:92:D9:DE:8D:0D; 8A:92:D9:DE:8D:0C',3),(3,1,24,'00:1A:2B:3C:4D:5E; 00:1A:2B:3C:4D:6E',2);
/*!40000 ALTER TABLE `mac_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `martin_conversation`
--

DROP TABLE IF EXISTS `martin_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `martin_conversation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `chat_id` bigint unsigned DEFAULT NULL,
  `handler` varchar(160) NOT NULL DEFAULT '',
  `status` varchar(32) DEFAULT 'active',
  `state` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mart_conv_user` (`user_id`),
  KEY `idx_mart_conv_chat` (`chat_id`),
  KEY `idx_mart_conv_status` (`status`),
  CONSTRAINT `fk_mart_conv_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_mart_conv_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `martin_conversation`
--

LOCK TABLES `martin_conversation` WRITE;
/*!40000 ALTER TABLE `martin_conversation` DISABLE KEYS */;
INSERT INTO `martin_conversation` VALUES (1,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-16 21:02:09','2025-09-16 21:05:17'),(2,1854044544,1854044544,'mac-application-handler','stopped','finished','2025-09-16 21:05:18','2025-09-16 21:07:28'),(3,1854044544,1854044544,'check-status-handler','stopped','cancelled','2025-09-16 21:08:55','2025-09-16 21:09:23'),(4,1854044544,1854044544,'mac-application-handler','stopped','cancelled','2025-09-16 21:09:28','2025-09-16 21:09:39'),(5,1854044544,1854044544,'check-status-handler','stopped','cancelled','2025-09-16 21:09:41','2025-09-16 21:09:46'),(6,1854044544,1854044544,'mac-application-handler','stopped','cancelled','2025-09-16 21:11:28','2025-09-16 21:11:30'),(7,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-16 21:11:32','2025-09-16 21:11:44'),(8,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-17 21:08:24','2025-09-17 21:08:24'),(9,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-17 21:08:25','2025-09-17 21:08:25'),(10,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-17 21:08:28','2025-09-17 21:08:30'),(11,1854044544,1854044544,'mac-application-handler','stopped','finished','2025-09-17 21:08:31','2025-09-17 21:09:54'),(12,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-17 21:12:00','2025-09-17 21:12:09'),(13,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-20 17:24:02','2025-09-20 17:24:08'),(14,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-20 17:24:09','2025-09-20 17:25:10'),(15,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-20 17:51:20','2025-09-20 17:51:42'),(16,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-20 17:58:24','2025-09-20 17:58:51'),(17,1854044544,1854044544,'check-status-handler','stopped','cancelled','2025-09-20 19:26:25','2025-09-20 19:28:31'),(18,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-20 19:29:01','2025-09-20 19:29:09'),(19,1854044544,1854044544,'check-status-handler','stopped','cancelled','2025-09-20 19:29:10','2025-09-20 19:29:16'),(20,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-20 19:30:41','2025-09-20 19:30:43'),(21,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-20 19:30:44','2025-09-20 19:30:51'),(22,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-20 19:31:08','2025-09-20 19:31:45'),(23,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-21 13:03:42','2025-09-21 13:13:04'),(24,1854044544,1854044544,'mac-application-handler','stopped','finished','2025-09-21 13:15:00','2025-09-21 13:16:01'),(25,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-21 13:18:01','2025-09-21 13:18:14'),(26,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-21 13:18:17','2025-09-21 13:18:28'),(27,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-21 13:43:57','2025-09-21 13:45:14'),(28,990082777,990082777,'payment-application-handler','active','start','2025-09-21 21:01:15','2025-09-21 21:01:15'),(29,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-21 21:01:18','2025-09-21 21:01:50'),(30,1854044544,1854044544,'payment-application-handler','stopped','cancelled','2025-09-22 20:34:17','2025-09-22 20:35:10'),(31,1854044544,1854044544,'payment-application-handler','stopped','finished','2025-09-24 17:03:16','2025-09-24 17:03:39'),(32,1854044544,1854044544,'check-status-handler','stopped','finished','2025-09-24 17:03:47','2025-09-24 17:05:22'),(33,1854044544,1854044544,'check-status-handler','stopped','cancelled','2025-09-24 17:07:03','2025-09-24 17:07:14');
/*!40000 ALTER TABLE `martin_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `martin_migrations`
--

DROP TABLE IF EXISTS `martin_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `martin_migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `batch` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `martin_migrations`
--

LOCK TABLES `martin_migrations` WRITE;
/*!40000 ALTER TABLE `martin_migrations` DISABLE KEYS */;
INSERT INTO `martin_migrations` VALUES (2,'2258182025_create_user_student_house_info_table.php','2025-09-11 22:55:26',NULL),(3,'2348182025_create_mac_applications_table.php','2025-09-11 22:55:26',NULL),(20,'1857172025_telegram_migrations_core.php','2025-09-16 21:02:04',NULL),(21,'1953132025_add_telegram_credentials_table.php','2025-09-20 16:56:56',NULL),(22,'1963132025_add_column_to_applications_table.php','2025-09-20 21:51:08',NULL);
/*!40000 ALTER TABLE `martin_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `chat_id` bigint unsigned NOT NULL,
  `sender_chat_id` bigint unsigned NOT NULL COMMENT 'Sender chat',
  `id` bigint unsigned NOT NULL COMMENT 'Message id',
  `message_thread_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `sender_boost_count` bigint unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `forward_from` bigint unsigned DEFAULT NULL,
  `forward_from_chat` bigint unsigned DEFAULT NULL,
  `forward_from_message_id` bigint unsigned DEFAULT NULL,
  `forward_signature` longtext,
  `forward_sender_name` longtext,
  `forward_date` datetime DEFAULT NULL,
  `is_topic_message` tinyint(1) NOT NULL DEFAULT '0',
  `is_automatic_forward` tinyint(1) NOT NULL DEFAULT '0',
  `reply_to_chat` bigint unsigned DEFAULT NULL,
  `reply_to_message` bigint unsigned DEFAULT NULL,
  `external_reply` longtext,
  `quote` longtext,
  `reply_to_story` longtext,
  `via_bot` bigint unsigned DEFAULT NULL,
  `link_preview_options` longtext,
  `edit_date` datetime DEFAULT NULL,
  `has_protected_content` tinyint(1) NOT NULL DEFAULT '0',
  `media_group_id` longtext,
  `author_signature` longtext,
  `text` longtext,
  `entities` longtext,
  `caption_entities` longtext,
  `audio` longtext,
  `document` longtext,
  `animation` longtext,
  `game` longtext,
  `photo` longtext,
  `sticker` longtext,
  `story` longtext,
  `video` longtext,
  `voice` longtext,
  `video_note` longtext,
  `caption` longtext,
  `has_media_spoiler` tinyint(1) NOT NULL DEFAULT '0',
  `contact` longtext,
  `location` longtext,
  `venue` longtext,
  `poll` longtext,
  `dice` longtext,
  `new_chat_members` longtext,
  `left_chat_member` bigint unsigned DEFAULT NULL,
  `new_chat_title` varchar(255) DEFAULT NULL,
  `new_chat_photo` longtext,
  `delete_chat_photo` tinyint(1) NOT NULL DEFAULT '0',
  `group_chat_created` tinyint(1) NOT NULL DEFAULT '0',
  `supergroup_chat_created` tinyint(1) NOT NULL DEFAULT '0',
  `channel_chat_created` tinyint(1) NOT NULL DEFAULT '0',
  `message_auto_delete_timer_changed` longtext,
  `migrate_to_chat_id` bigint unsigned DEFAULT NULL,
  `migrate_from_chat_id` bigint unsigned DEFAULT NULL,
  `pinned_message` longtext,
  `invoice` longtext,
  `successful_payment` longtext,
  `users_shared` longtext,
  `chat_shared` longtext,
  `connected_website` longtext,
  `write_access_allowed` longtext,
  `passport_data` longtext,
  `proximity_alert_triggered` longtext,
  `boost_added` longtext,
  `forum_topic_created` longtext,
  `forum_topic_edited` longtext,
  `forum_topic_closed` longtext,
  `forum_topic_reopened` longtext,
  `general_forum_topic_hidden` longtext,
  `general_forum_topic_unhidden` longtext,
  `video_chat_scheduled` longtext,
  `video_chat_started` longtext,
  `video_chat_ended` longtext,
  `video_chat_participants_invited` longtext,
  `web_app_data` longtext,
  `reply_markup` longtext,
  PRIMARY KEY (`chat_id`,`id`),
  KEY `idx_msg_user` (`user_id`),
  KEY `idx_msg_forward_from` (`forward_from`),
  KEY `idx_msg_forward_from_chat` (`forward_from_chat`),
  KEY `idx_msg_reply_to_chat` (`reply_to_chat`),
  KEY `idx_msg_reply_to_message` (`reply_to_message`),
  KEY `idx_msg_via_bot` (`via_bot`),
  KEY `idx_msg_left_chat_member` (`left_chat_member`),
  KEY `idx_msg_migrate_from` (`migrate_from_chat_id`),
  KEY `idx_msg_migrate_to` (`migrate_to_chat_id`),
  KEY `IDX_B6BD307F1A9A7125` (`chat_id`),
  KEY `IDX_B6BD307F9FCD8AA732E801DC` (`reply_to_chat`,`reply_to_message`),
  CONSTRAINT `fk_msg_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_msg_forward_from` FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_msg_forward_from_chat` FOREIGN KEY (`forward_from_chat`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_msg_left_chat_member` FOREIGN KEY (`left_chat_member`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_msg_reply_to` FOREIGN KEY (`reply_to_chat`, `reply_to_message`) REFERENCES `message` (`chat_id`, `id`),
  CONSTRAINT `fk_msg_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_msg_via_bot` FOREIGN KEY (`via_bot`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (990082777,0,3795,NULL,990082777,NULL,'2025-09-21 15:55:03',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:15',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(990082777,0,3796,NULL,990082777,NULL,'2025-09-21 15:55:12',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:16',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3427,NULL,1854044544,NULL,'2025-09-16 21:02:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:09',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3429,NULL,1854044544,NULL,'2025-09-16 21:02:11',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:11',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3431,NULL,1854044544,NULL,'2025-09-16 21:02:13',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:13',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3433,NULL,1854044544,NULL,'2025-09-16 21:02:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:16',0,NULL,NULL,'Мпе',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3435,NULL,1854044544,NULL,'2025-09-16 21:02:18',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:18',0,NULL,NULL,'Ирн',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3437,NULL,1854044544,NULL,'2025-09-16 21:02:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:22',0,NULL,NULL,'55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3439,NULL,1854044544,NULL,'2025-09-16 21:02:25',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:02:25',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3441,NULL,1854044544,NULL,'2025-09-16 21:03:12',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:03:12',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3443,NULL,1854044544,NULL,'2025-09-16 21:03:27',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:03:27',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3445,NULL,1854044544,NULL,'2025-09-16 21:03:40',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:03:40',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3447,NULL,1854044544,NULL,'2025-09-16 21:03:43',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:03:43',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3449,NULL,1854044544,NULL,'2025-09-16 21:04:02',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:04:02',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3451,NULL,1854044544,NULL,'2025-09-16 21:04:21',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:04:21',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3453,NULL,1854044544,NULL,'2025-09-16 21:04:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:04:22',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3455,NULL,1854044544,NULL,'2025-09-16 21:05:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:05:17',0,NULL,NULL,'🚫 Отмена',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3457,NULL,1854044544,NULL,'2025-09-16 21:05:18',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:05:18',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3458,NULL,1854044544,NULL,'2025-09-16 21:06:37',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:37',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3460,NULL,1854044544,NULL,'2025-09-16 21:06:39',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:39',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3462,NULL,1854044544,NULL,'2025-09-16 21:06:41',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:41',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3464,NULL,1854044544,NULL,'2025-09-16 21:06:43',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:43',0,NULL,NULL,'Рнн',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3466,NULL,1854044544,NULL,'2025-09-16 21:06:46',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:46',0,NULL,NULL,'Мпен',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3468,NULL,1854044544,NULL,'2025-09-16 21:06:49',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:06:49',0,NULL,NULL,'56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3470,NULL,1854044544,NULL,'2025-09-16 21:07:19',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:07:19',0,NULL,NULL,'00:1A:2B:3C:4D:5E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3472,NULL,1854044544,NULL,'2025-09-16 21:07:23',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:07:23',0,NULL,NULL,'☑️ Завершить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3474,NULL,1854044544,NULL,'2025-09-16 21:07:27',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:07:27',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3477,NULL,1854044544,NULL,'2025-09-16 21:08:55',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:08:55',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3479,NULL,1854044544,NULL,'2025-09-16 21:08:56',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:08:56',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3481,NULL,1854044544,NULL,'2025-09-16 21:08:59',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:08:59',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3482,NULL,1854044544,NULL,'2025-09-16 21:09:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:22',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3485,NULL,1854044544,NULL,'2025-09-16 21:09:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:28',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3487,NULL,1854044544,NULL,'2025-09-16 21:09:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:32',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3489,NULL,1854044544,NULL,'2025-09-16 21:09:34',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:34',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3491,NULL,1854044544,NULL,'2025-09-16 21:09:36',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:36',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3493,NULL,1854044544,NULL,'2025-09-16 21:09:38',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:38',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3495,NULL,1854044544,NULL,'2025-09-16 21:09:41',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:41',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3497,NULL,1854044544,NULL,'2025-09-16 21:09:43',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:43',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3499,NULL,1854044544,NULL,'2025-09-16 21:09:46',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:09:46',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3502,NULL,1854044544,NULL,'2025-09-16 21:11:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:28',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3503,NULL,1854044544,NULL,'2025-09-16 21:11:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:29',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3506,NULL,1854044544,NULL,'2025-09-16 21:11:29',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:30',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3508,NULL,1854044544,NULL,'2025-09-16 21:11:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:32',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3510,NULL,1854044544,NULL,'2025-09-16 21:11:35',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:35',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3512,NULL,1854044544,NULL,'2025-09-16 21:11:38',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:38',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3514,NULL,1854044544,NULL,'2025-09-16 21:11:44',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-16 21:11:44',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3516,NULL,1854044544,NULL,'2025-09-17 12:24:07',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:24',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3517,NULL,1854044544,NULL,'2025-09-17 12:24:08',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:24',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3518,NULL,1854044544,NULL,'2025-09-17 21:00:54',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:25',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3519,NULL,1854044544,NULL,'2025-09-17 21:00:57',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:25',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3520,NULL,1854044544,NULL,'2025-09-17 21:01:07',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:25',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3527,NULL,1854044544,NULL,'2025-09-17 21:08:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:28',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3529,NULL,1854044544,NULL,'2025-09-17 21:08:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:30',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3531,NULL,1854044544,NULL,'2025-09-17 21:08:31',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:31',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3533,NULL,1854044544,NULL,'2025-09-17 21:08:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:32',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3535,NULL,1854044544,NULL,'2025-09-17 21:08:34',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:34',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3537,NULL,1854044544,NULL,'2025-09-17 21:08:37',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:37',0,NULL,NULL,'Vft',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3539,NULL,1854044544,NULL,'2025-09-17 21:08:40',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:40',0,NULL,NULL,'Cfhh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3541,NULL,1854044544,NULL,'2025-09-17 21:08:43',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:43',0,NULL,NULL,'45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3543,NULL,1854044544,NULL,'2025-09-17 21:08:59',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:08:59',0,NULL,NULL,'8A:92:D9:DE:8D:0F;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3545,NULL,1854044544,NULL,'2025-09-17 21:09:03',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:03',0,NULL,NULL,'8A:92:D9:DE:8D:0F:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3547,NULL,1854044544,NULL,'2025-09-17 21:09:14',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:14',0,NULL,NULL,'8A:92:D9:DE:8D:0F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3549,NULL,1854044544,NULL,'2025-09-17 21:09:20',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:20',0,NULL,NULL,'8A:92:D9:DE:8D:0F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3551,NULL,1854044544,NULL,'2025-09-17 21:09:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:30',0,NULL,NULL,'➕ Добавить МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3553,NULL,1854044544,NULL,'2025-09-17 21:09:34',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:34',0,NULL,NULL,'8A:92:D9:DE:8D:0F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3555,NULL,1854044544,NULL,'2025-09-17 21:09:36',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:36',0,NULL,NULL,'➕ Добавить МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3557,NULL,1854044544,NULL,'2025-09-17 21:09:38',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:38',0,NULL,NULL,'8A:92:D9:DE:8D:0D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3559,NULL,1854044544,NULL,'2025-09-17 21:09:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:42',0,NULL,NULL,'8A:92:D9:DE:8D:0C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3561,NULL,1854044544,NULL,'2025-09-17 21:09:44',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:44',0,NULL,NULL,'➕ Добавить МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3563,NULL,1854044544,NULL,'2025-09-17 21:09:47',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:47',0,NULL,NULL,'8A:92:D9:DE:8D:0C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3565,NULL,1854044544,NULL,'2025-09-17 21:09:49',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:49',0,NULL,NULL,'☑️ Завершить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3567,NULL,1854044544,NULL,'2025-09-17 21:09:54',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:09:54',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3570,NULL,1854044544,NULL,'2025-09-17 21:12:00',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:12:00',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3572,NULL,1854044544,NULL,'2025-09-17 21:12:02',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:12:02',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3574,NULL,1854044544,NULL,'2025-09-17 21:12:06',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:12:06',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3576,NULL,1854044544,NULL,'2025-09-17 21:12:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-17 21:12:09',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3578,NULL,1854044544,NULL,'2025-09-20 17:23:03',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:02',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3580,NULL,1854044544,NULL,'2025-09-20 17:24:08',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:08',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3582,NULL,1854044544,NULL,'2025-09-20 17:24:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:09',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3584,NULL,1854044544,NULL,'2025-09-20 17:24:12',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:12',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3586,NULL,1854044544,NULL,'2025-09-20 17:24:14',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:14',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3588,NULL,1854044544,NULL,'2025-09-20 17:24:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:16',0,NULL,NULL,'Trt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3590,NULL,1854044544,NULL,'2025-09-20 17:24:19',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:19',0,NULL,NULL,'Frt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3592,NULL,1854044544,NULL,'2025-09-20 17:24:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:23',0,NULL,NULL,'35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3594,NULL,1854044544,NULL,'2025-09-20 17:24:26',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:26',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3596,NULL,1854044544,NULL,'2025-09-20 17:24:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:30',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3598,NULL,1854044544,NULL,'2025-09-20 17:24:37',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:37',0,NULL,NULL,'Gh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3600,NULL,1854044544,NULL,'2025-09-20 17:24:56',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:24:56',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3602,NULL,1854044544,NULL,'2025-09-20 17:25:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:25:09',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIG6WjFxMvyCGveSPtflAGP0Weei6wVAAKX_jEbbREpSrflMpLOJ6ohAQADAgADcwADNgQ\",\"file_unique_id\":\"AQADl_4xG20RKUp4\",\"file_size\":1887,\"width\":90,\"height\":67},{\"file_id\":\"AgACAgIAAxkBAAIG6WjFxMvyCGveSPtflAGP0Weei6wVAAKX_jEbbREpSrflMpLOJ6ohAQADAgADbQADNgQ\",\"file_unique_id\":\"AQADl_4xG20RKUpy\",\"file_size\":29286,\"width\":320,\"height\":240},{\"file_id\":\"AgACAgIAAxkBAAIG6WjFxMvyCGveSPtflAGP0Weei6wVAAKX_jEbbREpSrflMpLOJ6ohAQADAgADeAADNgQ\",\"file_unique_id\":\"AQADl_4xG20RKUp9\",\"file_size\":123788,\"width\":800,\"height\":600},{\"file_id\":\"AgACAgIAAxkBAAIG6WjFxMvyCGveSPtflAGP0Weei6wVAAKX_jEbbREpSrflMpLOJ6ohAQADAgADeQADNgQ\",\"file_unique_id\":\"AQADl_4xG20RKUp-\",\"file_size\":226582,\"width\":1280,\"height\":960}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3605,NULL,1854044544,NULL,'2025-09-20 17:51:20',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:20',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3607,NULL,1854044544,NULL,'2025-09-20 17:51:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:22',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3609,NULL,1854044544,NULL,'2025-09-20 17:51:23',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:23',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3611,NULL,1854044544,NULL,'2025-09-20 17:51:26',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:26',0,NULL,NULL,'Прао',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3613,NULL,1854044544,NULL,'2025-09-20 17:51:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:28',0,NULL,NULL,'Впоылы',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3615,NULL,1854044544,NULL,'2025-09-20 17:51:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:31',0,NULL,NULL,';',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3617,NULL,1854044544,NULL,'2025-09-20 17:51:34',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:34',0,NULL,NULL,'67',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3619,NULL,1854044544,NULL,'2025-09-20 17:51:36',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:36',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3621,NULL,1854044544,NULL,'2025-09-20 17:51:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:51:42',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp4\",\"file_size\":706,\"width\":40,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA20AAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEpy\",\"file_size\":5658,\"width\":144,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp9\",\"file_size\":17723,\"width\":360,\"height\":800},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3kAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp-\",\"file_size\":26806,\"width\":576,\"height\":1280}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3624,NULL,1854044544,NULL,'2025-09-20 17:58:24',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:24',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3626,NULL,1854044544,NULL,'2025-09-20 17:58:26',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:26',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3628,NULL,1854044544,NULL,'2025-09-20 17:58:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:30',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3630,NULL,1854044544,NULL,'2025-09-20 17:58:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:32',0,NULL,NULL,'Прн',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3632,NULL,1854044544,NULL,'2025-09-20 17:58:34',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:34',0,NULL,NULL,'Ть',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3634,NULL,1854044544,NULL,'2025-09-20 17:58:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:42',0,NULL,NULL,'67',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3636,NULL,1854044544,NULL,'2025-09-20 17:58:44',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:44',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3638,NULL,1854044544,NULL,'2025-09-20 17:58:51',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 17:58:51',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp4\",\"file_size\":706,\"width\":40,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA20AAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEpy\",\"file_size\":5658,\"width\":144,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp9\",\"file_size\":17723,\"width\":360,\"height\":800},{\"file_id\":\"AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3kAAzYE\",\"file_unique_id\":\"AQADE_sxG81_cEp-\",\"file_size\":26806,\"width\":576,\"height\":1280}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3641,NULL,1854044544,NULL,'2025-09-20 19:26:25',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:26:25',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3643,NULL,1854044544,NULL,'2025-09-20 19:26:29',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:26:29',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3645,NULL,1854044544,NULL,'2025-09-20 19:26:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:26:32',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3646,NULL,1854044544,NULL,'2025-09-20 19:28:31',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:28:31',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3649,NULL,1854044544,NULL,'2025-09-20 19:29:01',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:01',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3651,NULL,1854044544,NULL,'2025-09-20 19:29:04',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:05',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3653,NULL,1854044544,NULL,'2025-09-20 19:29:06',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:06',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3655,NULL,1854044544,NULL,'2025-09-20 19:29:07',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:07',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3657,NULL,1854044544,NULL,'2025-09-20 19:29:08',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:08',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3659,NULL,1854044544,NULL,'2025-09-20 19:29:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:09',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3661,NULL,1854044544,NULL,'2025-09-20 19:29:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:10',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3663,NULL,1854044544,NULL,'2025-09-20 19:29:12',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:12',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3665,NULL,1854044544,NULL,'2025-09-20 19:29:15',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:29:15',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3668,NULL,1854044544,NULL,'2025-09-20 19:30:41',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:41',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3670,NULL,1854044544,NULL,'2025-09-20 19:30:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:42',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3672,NULL,1854044544,NULL,'2025-09-20 19:30:44',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:44',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3674,NULL,1854044544,NULL,'2025-09-20 19:30:45',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:45',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3676,NULL,1854044544,NULL,'2025-09-20 19:30:48',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:48',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3678,NULL,1854044544,NULL,'2025-09-20 19:30:51',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:30:51',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3680,NULL,1854044544,NULL,'2025-09-20 19:31:08',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:08',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3682,NULL,1854044544,NULL,'2025-09-20 19:31:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:09',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3684,NULL,1854044544,NULL,'2025-09-20 19:31:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:11',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3686,NULL,1854044544,NULL,'2025-09-20 19:31:13',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:13',0,NULL,NULL,'Ппп',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3688,NULL,1854044544,NULL,'2025-09-20 19:31:15',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:15',0,NULL,NULL,'Пап',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3690,NULL,1854044544,NULL,'2025-09-20 19:31:18',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:18',0,NULL,NULL,'67',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3692,NULL,1854044544,NULL,'2025-09-20 19:31:20',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:20',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3694,NULL,1854044544,NULL,'2025-09-20 19:31:45',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-20 19:31:45',0,NULL,NULL,'🚫 Отмена',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3696,NULL,1854044544,NULL,'2025-09-21 13:03:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:42',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3698,NULL,1854044544,NULL,'2025-09-21 13:03:43',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:43',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3700,NULL,1854044544,NULL,'2025-09-21 13:03:45',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:45',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3702,NULL,1854044544,NULL,'2025-09-21 13:03:47',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:47',0,NULL,NULL,'Yeysys',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3704,NULL,1854044544,NULL,'2025-09-21 13:03:49',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:49',0,NULL,NULL,'Dujdjs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3706,NULL,1854044544,NULL,'2025-09-21 13:03:52',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:52',0,NULL,NULL,'67',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3708,NULL,1854044544,NULL,'2025-09-21 13:03:54',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:54',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3710,NULL,1854044544,NULL,'2025-09-21 13:03:58',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:03:58',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3713,NULL,1854044544,NULL,'2025-09-21 13:07:38',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:07:38',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3714,NULL,1854044544,NULL,'2025-09-21 13:08:05',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:08:05',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3716,NULL,1854044544,NULL,'2025-09-21 13:08:35',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:08:35',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3718,NULL,1854044544,NULL,'2025-09-21 13:09:24',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:09:24',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3720,NULL,1854044544,NULL,'2025-09-21 13:09:44',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:09:44',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3722,NULL,1854044544,NULL,'2025-09-21 13:10:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:10:28',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3724,NULL,1854044544,NULL,'2025-09-21 13:12:04',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:12:04',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3726,NULL,1854044544,NULL,'2025-09-21 13:13:03',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:13:03',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3MAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp4\",\"file_size\":1386,\"width\":48,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA20AAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEpy\",\"file_size\":16165,\"width\":169,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE\",\"file_unique_id\":\"AQAD7PkxG0XqgEp9\",\"file_size\":30403,\"width\":301,\"height\":571}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3729,NULL,1854044544,NULL,'2025-09-21 13:15:00',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:00',0,NULL,NULL,'💻 Оставить заявку на изменение/добавление MAC-адресов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3731,NULL,1854044544,NULL,'2025-09-21 13:15:04',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:04',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3733,NULL,1854044544,NULL,'2025-09-21 13:15:06',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:06',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3735,NULL,1854044544,NULL,'2025-09-21 13:15:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:10',0,NULL,NULL,'Gshehs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3737,NULL,1854044544,NULL,'2025-09-21 13:15:23',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:23',0,NULL,NULL,'2353',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3739,NULL,1854044544,NULL,'2025-09-21 13:15:32',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:32',0,NULL,NULL,'31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3741,NULL,1854044544,NULL,'2025-09-21 13:15:36',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:36',0,NULL,NULL,'45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3743,NULL,1854044544,NULL,'2025-09-21 13:15:40',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:40',0,NULL,NULL,'00:1A:2B:3C:4D:5E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3745,NULL,1854044544,NULL,'2025-09-21 13:15:42',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:42',0,NULL,NULL,'00:1A:2B:3C:4D:5E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3747,NULL,1854044544,NULL,'2025-09-21 13:15:46',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:46',0,NULL,NULL,'➕ Добавить МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3749,NULL,1854044544,NULL,'2025-09-21 13:15:47',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:47',0,NULL,NULL,'00:1A:2B:3C:4D:5E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3751,NULL,1854044544,NULL,'2025-09-21 13:15:49',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:49',0,NULL,NULL,'➕ Добавить МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3753,NULL,1854044544,NULL,'2025-09-21 13:15:53',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:53',0,NULL,NULL,'00:1A:2B:3C:4D:6E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3755,NULL,1854044544,NULL,'2025-09-21 13:15:55',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:15:56',0,NULL,NULL,'☑️ Завершить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3757,NULL,1854044544,NULL,'2025-09-21 13:16:01',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:16:01',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3760,NULL,1854044544,NULL,'2025-09-21 13:17:51',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:17:51',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3763,NULL,1854044544,NULL,'2025-09-21 13:18:01',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:01',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3765,NULL,1854044544,NULL,'2025-09-21 13:18:03',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:03',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3767,NULL,1854044544,NULL,'2025-09-21 13:18:06',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:06',0,NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3770,NULL,1854044544,NULL,'2025-09-21 13:18:14',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:14',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3772,NULL,1854044544,NULL,'2025-09-21 13:18:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:16',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3774,NULL,1854044544,NULL,'2025-09-21 13:18:20',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:20',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3776,NULL,1854044544,NULL,'2025-09-21 13:18:23',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:23',0,NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3779,NULL,1854044544,NULL,'2025-09-21 13:18:28',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:18:28',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3781,NULL,1854044544,NULL,'2025-09-21 13:43:55',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:43:57',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3783,NULL,1854044544,NULL,'2025-09-21 13:43:59',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:43:59',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3785,NULL,1854044544,NULL,'2025-09-21 13:44:01',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:44:02',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3787,NULL,1854044544,NULL,'2025-09-21 13:44:07',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:44:08',0,NULL,NULL,'67',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3789,NULL,1854044544,NULL,'2025-09-21 13:45:04',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:45:05',0,NULL,NULL,'Пр',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3791,NULL,1854044544,NULL,'2025-09-21 13:45:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:45:09',0,NULL,NULL,'78',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3793,NULL,1854044544,NULL,'2025-09-21 13:45:13',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 13:45:13',0,NULL,NULL,'🚫 Отмена',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3819,NULL,1854044544,NULL,'2025-09-21 20:59:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:16',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3824,NULL,1854044544,NULL,'2025-09-21 21:01:18',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:18',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3826,NULL,1854044544,NULL,'2025-09-21 21:01:20',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:20',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3828,NULL,1854044544,NULL,'2025-09-21 21:01:21',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:21',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3830,NULL,1854044544,NULL,'2025-09-21 21:01:29',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:29',0,NULL,NULL,'Дмитрий',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3832,NULL,1854044544,NULL,'2025-09-21 21:01:33',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:33',0,NULL,NULL,'Кузнецов',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3834,NULL,1854044544,NULL,'2025-09-21 21:01:37',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:37',0,NULL,NULL,'228',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3836,NULL,1854044544,NULL,'2025-09-21 21:01:40',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:41',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3838,NULL,1854044544,NULL,'2025-09-21 21:01:49',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-21 21:01:49',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIO_mjQZ70GImBFJElSQaBbDAz-O7psAAIE_zEbReqASmO6PKuYvQTQAQADAgADcwADNgQ\",\"file_unique_id\":\"AQADBP8xG0XqgEp4\",\"file_size\":1085,\"width\":40,\"height\":90},{\"file_id\":\"AgACAgIAAxkBAAIO_mjQZ70GImBFJElSQaBbDAz-O7psAAIE_zEbReqASmO6PKuYvQTQAQADAgADbQADNgQ\",\"file_unique_id\":\"AQADBP8xG0XqgEpy\",\"file_size\":17945,\"width\":144,\"height\":320},{\"file_id\":\"AgACAgIAAxkBAAIO_mjQZ70GImBFJElSQaBbDAz-O7psAAIE_zEbReqASmO6PKuYvQTQAQADAgADeAADNgQ\",\"file_unique_id\":\"AQADBP8xG0XqgEp9\",\"file_size\":72042,\"width\":360,\"height\":800},{\"file_id\":\"AgACAgIAAxkBAAIO_mjQZ70GImBFJElSQaBbDAz-O7psAAIE_zEbReqASmO6PKuYvQTQAQADAgADeQADNgQ\",\"file_unique_id\":\"AQADBP8xG0XqgEp-\",\"file_size\":120283,\"width\":576,\"height\":1280}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3877,NULL,1854044544,NULL,'2025-09-21 22:45:54',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-22 20:34:17',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3879,NULL,1854044544,NULL,'2025-09-22 20:35:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-22 20:35:10',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3881,NULL,1854044544,NULL,'2025-09-24 17:03:14',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:14',0,NULL,NULL,'/start','[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3884,NULL,1854044544,NULL,'2025-09-24 17:03:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:16',0,NULL,NULL,'💸 Оставить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3886,NULL,1854044544,NULL,'2025-09-24 17:03:17',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:17',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3888,NULL,1854044544,NULL,'2025-09-24 17:03:19',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:19',0,NULL,NULL,'✍️ Ввести вручную',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3890,NULL,1854044544,NULL,'2025-09-24 17:03:23',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:23',0,NULL,NULL,'Пен',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3892,NULL,1854044544,NULL,'2025-09-24 17:03:26',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:26',0,NULL,NULL,'Панг',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3894,NULL,1854044544,NULL,'2025-09-24 17:03:30',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:30',0,NULL,NULL,'45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3896,NULL,1854044544,NULL,'2025-09-24 17:03:31',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:32',0,NULL,NULL,'💳 Показать реквизиты',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3898,NULL,1854044544,NULL,'2025-09-24 17:03:38',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:39',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"file_id\":\"AgACAgIAAxkBAAIPOmjUJGrzJQmFrAqG7VN2Aic7D2C2AAI39jEbQi2oStYFz8dtKqoIAQADAgADcwADNgQ\",\"file_unique_id\":\"AQADN_YxG0ItqEp4\",\"file_size\":2167,\"width\":90,\"height\":84},{\"file_id\":\"AgACAgIAAxkBAAIPOmjUJGrzJQmFrAqG7VN2Aic7D2C2AAI39jEbQi2oStYFz8dtKqoIAQADAgADbQADNgQ\",\"file_unique_id\":\"AQADN_YxG0ItqEpy\",\"file_size\":29164,\"width\":320,\"height\":299},{\"file_id\":\"AgACAgIAAxkBAAIPOmjUJGrzJQmFrAqG7VN2Aic7D2C2AAI39jEbQi2oStYFz8dtKqoIAQADAgADeAADNgQ\",\"file_unique_id\":\"AQADN_YxG0ItqEp9\",\"file_size\":105662,\"width\":736,\"height\":688}]',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3901,NULL,1854044544,NULL,'2025-09-24 17:03:47',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:03:47',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3902,NULL,1854044544,NULL,'2025-09-24 17:05:13',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:05:13',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3904,NULL,1854044544,NULL,'2025-09-24 17:05:16',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:05:16',0,NULL,NULL,'💸 Проверить заявку на оплату',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3906,NULL,1854044544,NULL,'2025-09-24 17:05:19',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:05:19',0,NULL,NULL,'8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3909,NULL,1854044544,NULL,'2025-09-24 17:05:22',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:05:22',0,NULL,NULL,'➡️ Продолжить',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3911,NULL,1854044544,NULL,'2025-09-24 17:07:02',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:03',0,NULL,NULL,'👀 Проверить статус заявки',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3913,NULL,1854044544,NULL,'2025-09-24 17:07:04',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:04',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3915,NULL,1854044544,NULL,'2025-09-24 17:07:07',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:07',0,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3917,NULL,1854044544,NULL,'2025-09-24 17:07:09',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:09',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3919,NULL,1854044544,NULL,'2025-09-24 17:07:10',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:10',0,NULL,NULL,'💻 Проверить заявку на МАК',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3921,NULL,1854044544,NULL,'2025-09-24 17:07:13',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:13',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1854044544,0,3923,NULL,1854044544,NULL,'2025-09-24 17:07:14',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-24 17:07:14',0,NULL,NULL,'⬅️ Назад',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_reaction`
--

DROP TABLE IF EXISTS `message_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_reaction` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `chat_id` bigint unsigned NOT NULL COMMENT 'Chat containing the message',
  `message_id` bigint unsigned NOT NULL COMMENT 'Message id inside the chat',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'The user that changed the reaction (if not anonymous)',
  `actor_chat_id` bigint unsigned DEFAULT NULL COMMENT 'The chat on behalf of which the reaction was changed',
  `old_reaction` longtext NOT NULL COMMENT 'Previous list of reaction types',
  `new_reaction` longtext NOT NULL COMMENT 'New list of reaction types',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mr_chat` (`chat_id`),
  KEY `idx_mr_user` (`user_id`),
  KEY `idx_mr_actor_chat` (`actor_chat_id`),
  CONSTRAINT `fk_mr_actor_chat` FOREIGN KEY (`actor_chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_mr_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_mr_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_reaction`
--

LOCK TABLES `message_reaction` WRITE;
/*!40000 ALTER TABLE `message_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_reaction_count`
--

DROP TABLE IF EXISTS `message_reaction_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_reaction_count` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL COMMENT 'The chat containing the message',
  `message_id` bigint unsigned NOT NULL COMMENT 'Unique message identifier inside the chat',
  `reactions` longtext NOT NULL COMMENT 'List of reactions present on the message',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mrc_chat` (`chat_id`),
  CONSTRAINT `fk_mrc_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_reaction_count`
--

LOCK TABLES `message_reaction_count` WRITE;
/*!40000 ALTER TABLE `message_reaction_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_reaction_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_application_user_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_application`
--

DROP TABLE IF EXISTS `payment_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_application` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `conversation_id` bigint unsigned NOT NULL,
  `file_id` varchar(255) DEFAULT NULL,
  `application_state_id` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_52D70D1B9AC0396` (`conversation_id`),
  KEY `IDX_52D70D1BBAE3E3D2` (`application_state_id`),
  CONSTRAINT `fk_application_state_payment_application` FOREIGN KEY (`application_state_id`) REFERENCES `application_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_martin_conversation_payment_application` FOREIGN KEY (`conversation_id`) REFERENCES `martin_conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_application`
--

LOCK TABLES `payment_application` WRITE;
/*!40000 ALTER TABLE `payment_application` DISABLE KEYS */;
INSERT INTO `payment_application` VALUES (2,1,14,NULL,2),(3,1,15,NULL,2),(4,1,16,'AgACAgIAAxkBAAIOJWjO6a29nnl-FJlqfAABlZNihcSH1AACE_sxG81_cEqWZ2zestpqowEAAwIAA3kAAzYE',3),(6,1,23,'AgACAgIAAxkBAAIOfmjP977uhHt5dKlnBHBYiG1h1apJAALs-TEbReqASt-kdoEAARCU9AEAAwIAA3gAAzYE',3),(7,1,29,'AgACAgIAAxkBAAIO_mjQZ70GImBFJElSQaBbDAz-O7psAAIE_zEbReqASmO6PKuYvQTQAQADAgADeQADNgQ',3),(8,0,31,'AgACAgIAAxkBAAIPOmjUJGrzJQmFrAqG7VN2Aic7D2C2AAI39jEbQi2oStYFz8dtKqoIAQADAgADeAADNgQ',1);
/*!40000 ALTER TABLE `payment_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poll` (
  `id` bigint unsigned NOT NULL,
  `question` longtext NOT NULL,
  `options` longtext NOT NULL,
  `total_voter_count` int unsigned NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `is_anonymous` tinyint(1) NOT NULL DEFAULT '1',
  `type` char(255) NOT NULL,
  `allows_multiple_answers` tinyint(1) NOT NULL DEFAULT '0',
  `correct_option_id` int unsigned NOT NULL,
  `explanation` varchar(255) DEFAULT NULL,
  `explanation_entities` longtext,
  `open_period` int unsigned DEFAULT NULL,
  `close_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll`
--

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_answer`
--

DROP TABLE IF EXISTS `poll_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poll_answer` (
  `poll_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `option_ids` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`poll_id`,`user_id`),
  KEY `IDX_36D8097E3C947C0F` (`poll_id`),
  CONSTRAINT `fk_pa_poll` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_answer`
--

LOCK TABLES `poll_answer` WRITE;
/*!40000 ALTER TABLE `poll_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pre_checkout_query`
--

DROP TABLE IF EXISTS `pre_checkout_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pre_checkout_query` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `currency` char(3) NOT NULL,
  `total_amount` bigint unsigned NOT NULL,
  `invoice_payload` char(255) NOT NULL DEFAULT '',
  `shipping_option_id` char(255) DEFAULT NULL,
  `order_info` longtext,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pcq_user` (`user_id`),
  CONSTRAINT `fk_pcq_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pre_checkout_query`
--

LOCK TABLES `pre_checkout_query` WRITE;
/*!40000 ALTER TABLE `pre_checkout_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `pre_checkout_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_limiter`
--

DROP TABLE IF EXISTS `request_limiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request_limiter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` char(255) DEFAULT NULL,
  `inline_message_id` char(255) DEFAULT NULL,
  `method` char(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_limiter`
--

LOCK TABLES `request_limiter` WRITE;
/*!40000 ALTER TABLE `request_limiter` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_limiter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_query`
--

DROP TABLE IF EXISTS `shipping_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_query` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `invoice_payload` char(255) NOT NULL DEFAULT '',
  `shipping_address` char(255) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sq_user` (`user_id`),
  CONSTRAINT `fk_sq_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_query`
--

LOCK TABLES `shipping_query` WRITE;
/*!40000 ALTER TABLE `shipping_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telegram_credentials`
--

DROP TABLE IF EXISTS `telegram_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telegram_credentials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telegram_credentials`
--

LOCK TABLES `telegram_credentials` WRITE;
/*!40000 ALTER TABLE `telegram_credentials` DISABLE KEYS */;
INSERT INTO `telegram_credentials` VALUES (1,'martinampera2bot','8025941792:AAE5b1-620Qilvp_M7gW5yv0fIB6jkCAkK4');
/*!40000 ALTER TABLE `telegram_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telegram_update`
--

DROP TABLE IF EXISTS `telegram_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telegram_update` (
  `id` bigint unsigned NOT NULL,
  `chat_id` bigint unsigned DEFAULT NULL,
  `message_id` bigint unsigned DEFAULT NULL,
  `edited_message_id` bigint unsigned DEFAULT NULL,
  `channel_post_id` bigint unsigned DEFAULT NULL,
  `edited_channel_post_id` bigint unsigned DEFAULT NULL,
  `message_reaction_id` bigint unsigned DEFAULT NULL,
  `message_reaction_count_id` bigint unsigned DEFAULT NULL,
  `inline_query_id` bigint unsigned DEFAULT NULL,
  `chosen_inline_result_id` bigint unsigned DEFAULT NULL,
  `callback_query_id` bigint unsigned DEFAULT NULL,
  `shipping_query_id` bigint unsigned DEFAULT NULL,
  `pre_checkout_query_id` bigint unsigned DEFAULT NULL,
  `poll_id` bigint unsigned DEFAULT NULL,
  `poll_answer_poll_id` bigint unsigned DEFAULT NULL,
  `my_chat_member_updated_id` bigint unsigned DEFAULT NULL,
  `chat_member_updated_id` bigint unsigned DEFAULT NULL,
  `chat_join_request_id` bigint unsigned DEFAULT NULL,
  `chat_boost_updated_id` bigint unsigned NOT NULL,
  `chat_boost_removed_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tu_message_id` (`message_id`),
  KEY `idx_tu_chat_message_id` (`chat_id`,`message_id`),
  KEY `idx_tu_edited_message_id` (`edited_message_id`),
  KEY `idx_tu_channel_post_id` (`channel_post_id`),
  KEY `idx_tu_edited_channel_post_id` (`edited_channel_post_id`),
  KEY `idx_tu_inline_query_id` (`inline_query_id`),
  KEY `idx_tu_chosen_inline_result_id` (`chosen_inline_result_id`),
  KEY `idx_tu_callback_query_id` (`callback_query_id`),
  KEY `idx_tu_shipping_query_id` (`shipping_query_id`),
  KEY `idx_tu_pre_checkout_query_id` (`pre_checkout_query_id`),
  KEY `idx_tu_poll_id` (`poll_id`),
  KEY `idx_tu_poll_answer_poll_id` (`poll_answer_poll_id`),
  KEY `idx_tu_my_chat_member_updated_id` (`my_chat_member_updated_id`),
  KEY `idx_tu_chat_member_updated_id` (`chat_member_updated_id`),
  KEY `idx_tu_chat_join_request_id` (`chat_join_request_id`),
  KEY `IDX_EADEC71A9A7125FCCA3C2D` (`chat_id`,`channel_post_id`),
  CONSTRAINT `fk_tu_callback_query` FOREIGN KEY (`callback_query_id`) REFERENCES `callback_query` (`id`),
  CONSTRAINT `fk_tu_channel_post` FOREIGN KEY (`chat_id`, `channel_post_id`) REFERENCES `message` (`chat_id`, `id`),
  CONSTRAINT `fk_tu_chosen_inline_result` FOREIGN KEY (`chosen_inline_result_id`) REFERENCES `chosen_inline_result` (`id`),
  CONSTRAINT `fk_tu_cjr` FOREIGN KEY (`chat_join_request_id`) REFERENCES `chat_join_request` (`id`),
  CONSTRAINT `fk_tu_cmu` FOREIGN KEY (`chat_member_updated_id`) REFERENCES `chat_member_updated` (`id`),
  CONSTRAINT `fk_tu_edited_channel_post` FOREIGN KEY (`edited_channel_post_id`) REFERENCES `edited_message` (`id`),
  CONSTRAINT `fk_tu_edited_message` FOREIGN KEY (`edited_message_id`) REFERENCES `edited_message` (`id`),
  CONSTRAINT `fk_tu_inline_query` FOREIGN KEY (`inline_query_id`) REFERENCES `inline_query` (`id`),
  CONSTRAINT `fk_tu_message` FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`),
  CONSTRAINT `fk_tu_my_cmu` FOREIGN KEY (`my_chat_member_updated_id`) REFERENCES `chat_member_updated` (`id`),
  CONSTRAINT `fk_tu_poll` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`),
  CONSTRAINT `fk_tu_poll_answer` FOREIGN KEY (`poll_answer_poll_id`) REFERENCES `poll_answer` (`poll_id`),
  CONSTRAINT `fk_tu_pre_checkout_query` FOREIGN KEY (`pre_checkout_query_id`) REFERENCES `pre_checkout_query` (`id`),
  CONSTRAINT `fk_tu_shipping_query` FOREIGN KEY (`shipping_query_id`) REFERENCES `shipping_query` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telegram_update`
--

LOCK TABLES `telegram_update` WRITE;
/*!40000 ALTER TABLE `telegram_update` DISABLE KEYS */;
INSERT INTO `telegram_update` VALUES (50318892,1854044544,3427,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318893,1854044544,3429,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318894,1854044544,3431,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318895,1854044544,3433,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318896,1854044544,3435,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318897,1854044544,3437,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318898,1854044544,3439,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318899,1854044544,3441,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318900,1854044544,3443,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318901,1854044544,3445,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318902,1854044544,3447,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318903,1854044544,3449,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318904,1854044544,3451,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318905,1854044544,3453,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318906,1854044544,3455,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318907,1854044544,3457,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318908,1854044544,3458,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318909,1854044544,3460,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318910,1854044544,3462,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318911,1854044544,3464,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318912,1854044544,3466,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318913,1854044544,3468,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318914,1854044544,3470,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318915,1854044544,3472,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318916,1854044544,3474,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318917,1854044544,3477,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318918,1854044544,3479,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318919,1854044544,3481,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318920,1854044544,3482,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318921,1854044544,3485,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318922,1854044544,3487,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318923,1854044544,3489,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318924,1854044544,3491,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318925,1854044544,3493,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318926,1854044544,3495,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318927,1854044544,3497,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318928,1854044544,3499,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318929,1854044544,3502,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318930,1854044544,3503,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318931,1854044544,3506,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318932,1854044544,3508,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318933,1854044544,3510,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318934,1854044544,3512,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318935,1854044544,3514,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318936,1854044544,3516,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318937,1854044544,3517,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318938,1854044544,3518,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318939,1854044544,3519,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318940,1854044544,3520,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318941,1854044544,3527,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318942,1854044544,3529,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318943,1854044544,3531,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318944,1854044544,3533,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318945,1854044544,3535,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318946,1854044544,3537,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318947,1854044544,3539,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318948,1854044544,3541,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318949,1854044544,3543,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318950,1854044544,3545,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318951,1854044544,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318952,1854044544,3547,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318953,1854044544,3549,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318954,1854044544,3551,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318955,1854044544,3553,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318956,1854044544,3555,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318957,1854044544,3557,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318958,1854044544,3559,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318959,1854044544,3561,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318960,1854044544,3563,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318961,1854044544,3565,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318962,1854044544,3567,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318963,1854044544,3570,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318964,1854044544,3572,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318965,1854044544,3574,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318966,1854044544,3576,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318967,1854044544,3578,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318968,1854044544,3580,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318969,1854044544,3582,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318970,1854044544,3584,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318971,1854044544,3586,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318972,1854044544,3588,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318973,1854044544,3590,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318974,1854044544,3592,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318975,1854044544,3594,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318976,1854044544,3596,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318977,1854044544,3598,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318978,1854044544,3600,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318979,1854044544,3602,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318980,1854044544,3605,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318981,1854044544,3607,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318982,1854044544,3609,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318983,1854044544,3611,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318984,1854044544,3613,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318985,1854044544,3615,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318986,1854044544,3617,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318987,1854044544,3619,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318988,1854044544,3621,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318989,1854044544,3624,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318990,1854044544,3626,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318991,1854044544,3628,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318992,1854044544,3630,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318993,1854044544,3632,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318994,1854044544,3634,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318995,1854044544,3636,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318996,1854044544,3638,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318997,1854044544,3641,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318998,1854044544,3643,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50318999,1854044544,3645,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319000,1854044544,3646,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319001,1854044544,3649,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319002,1854044544,3651,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319003,1854044544,3653,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319004,1854044544,3655,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319005,1854044544,3657,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319006,1854044544,3659,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319007,1854044544,3661,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319008,1854044544,3663,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319009,1854044544,3665,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319010,1854044544,3668,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319011,1854044544,3670,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319012,1854044544,3672,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319013,1854044544,3674,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319014,1854044544,3676,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319015,1854044544,3678,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319016,1854044544,3680,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319017,1854044544,3682,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319018,1854044544,3684,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319019,1854044544,3686,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319020,1854044544,3688,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319021,1854044544,3690,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319022,1854044544,3692,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319023,1854044544,3694,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319024,1854044544,3696,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319025,1854044544,3698,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319026,1854044544,3700,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319027,1854044544,3702,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319028,1854044544,3704,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319029,1854044544,3706,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319030,1854044544,3708,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319031,1854044544,3710,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319032,1854044544,3713,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319033,1854044544,3714,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319034,1854044544,3716,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319035,1854044544,3718,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319036,1854044544,3720,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319037,1854044544,3722,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319038,1854044544,3724,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319039,1854044544,3726,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319040,1854044544,3729,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319041,1854044544,3731,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319042,1854044544,3733,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319043,1854044544,3735,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319044,1854044544,3737,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319045,1854044544,3739,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319046,1854044544,3741,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319047,1854044544,3743,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319048,1854044544,3745,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319049,1854044544,3747,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319050,1854044544,3749,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319051,1854044544,3751,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319052,1854044544,3753,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319053,1854044544,3755,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319054,1854044544,3757,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319055,1854044544,3760,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319056,1854044544,3763,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319057,1854044544,3765,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319058,1854044544,3767,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319059,1854044544,3770,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319060,1854044544,3772,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319061,1854044544,3774,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319062,1854044544,3776,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319063,1854044544,3779,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319064,1854044544,3781,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319065,1854044544,3783,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319066,1854044544,3785,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319067,1854044544,3787,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319068,1854044544,3789,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319069,1854044544,3791,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319070,1854044544,3793,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319071,990082777,3795,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319072,990082777,3796,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319073,1854044544,3819,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319074,1854044544,3824,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319075,1854044544,3826,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319076,1854044544,3828,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319077,1854044544,3830,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319078,1854044544,3832,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319079,1854044544,3834,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319080,1854044544,3836,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319081,1854044544,3838,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319082,1854044544,3877,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319083,1854044544,3879,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319084,1854044544,3881,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319085,1854044544,3884,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319086,1854044544,3886,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319087,1854044544,3888,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319088,1854044544,3890,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319089,1854044544,3892,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319090,1854044544,3894,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319091,1854044544,3896,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319092,1854044544,3898,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319093,1854044544,3901,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319094,1854044544,3902,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319095,1854044544,3904,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319096,1854044544,3906,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319097,1854044544,3909,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319098,1854044544,3911,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319099,1854044544,3913,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319100,1854044544,3915,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319101,1854044544,3917,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319102,1854044544,3919,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319103,1854044544,3921,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(50319104,1854044544,3923,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `telegram_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint unsigned NOT NULL COMMENT 'Unique identifier for this user or bot',
  `is_bot` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'True, if this user is a bot',
  `first_name` char(255) NOT NULL DEFAULT '' COMMENT 'User''s or bot''s first name',
  `last_name` char(255) DEFAULT NULL COMMENT 'User''s or bot''s last name',
  `username` char(191) DEFAULT NULL COMMENT 'User''s or bot''s username',
  `language_code` char(10) DEFAULT NULL COMMENT 'IETF language tag of the user''s language',
  `is_premium` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'True, if this user is a Telegram Premium user',
  `added_to_attachment_menu` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'True, if this user added the bot to the attachment menu',
  `created_at` datetime DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` datetime DEFAULT NULL COMMENT 'Entry date update',
  PRIMARY KEY (`id`),
  KEY `idx_user_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (990082777,0,'Дима Т.',NULL,'dmitrij_tar','ru',0,0,'2025-09-21 15:55:03','2025-09-21 15:55:12'),(1854044544,0,'vladislav',NULL,'jnelty','ru',0,0,'2025-09-16 21:02:09','2025-09-24 17:07:14');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_chat`
--

DROP TABLE IF EXISTS `user_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_chat` (
  `user_id` bigint unsigned NOT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint unsigned NOT NULL COMMENT 'Unique chat identifier',
  PRIMARY KEY (`user_id`,`chat_id`),
  KEY `IDX_1F1CBE63A76ED395` (`user_id`),
  KEY `IDX_1F1CBE631A9A7125` (`chat_id`),
  CONSTRAINT `fk_user_chat_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_chat_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_chat`
--

LOCK TABLES `user_chat` WRITE;
/*!40000 ALTER TABLE `user_chat` DISABLE KEYS */;
INSERT INTO `user_chat` VALUES (990082777,990082777),(1854044544,1854044544);
/*!40000 ALTER TABLE `user_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_student_house_info`
--

DROP TABLE IF EXISTS `user_student_house_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_student_house_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Unique user identifier',
  `room_number` smallint NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D27C1467A76ED395` (`user_id`),
  KEY `IDX_D27C1467A76ED395` (`user_id`),
  CONSTRAINT `fk_user_user_student_house_info` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_student_house_info`
--

LOCK TABLES `user_student_house_info` WRITE;
/*!40000 ALTER TABLE `user_student_house_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_student_house_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-24 21:13:07
