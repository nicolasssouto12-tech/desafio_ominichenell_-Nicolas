-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: omnichannel_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `auditoria_preco`
--

DROP TABLE IF EXISTS `auditoria_preco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_preco` (
  `id_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_produto` int(11) NOT NULL,
  `preco_antigo` decimal(10,2) NOT NULL,
  `preco_novo` decimal(10,2) NOT NULL,
  `data_alteracao` datetime DEFAULT current_timestamp(),
  `usuario_responsavel` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `auditoria_preco_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_preco`
--

LOCK TABLES `auditoria_preco` WRITE;
/*!40000 ALTER TABLE `auditoria_preco` DISABLE KEYS */;
INSERT INTO `auditoria_preco` VALUES (1,2,50.00,55.00,'2026-10-22 17:16:41','root@localhost');
/*!40000 ALTER TABLE `auditoria_preco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tipo_cliente` varchar(30) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Carlos Silva','carlos@email.com','81999991001','1995-04-12','VIP','Rua A, Recife'),(2,'Mariana Souza','mariana@email.com','81999991002','1998-08-20','Comum','Rua B, Recife'),(3,'Joao Santos','joao@email.com','81999991003','2000-02-15','Comum','Rua C, Olinda'),(4,'Ana Oliveira','ana@email.com','81999991004','1992-11-30','VIP','Rua D, Jaboatao'),(5,'Pedro Costa','pedro@email.com','81999991005','1999-06-05','Comum','Rua E, Recife');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoques`
--

DROP TABLE IF EXISTS `estoques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoques` (
  `id_estoque` int(11) NOT NULL AUTO_INCREMENT,
  `id_produto` int(11) NOT NULL,
  `id_loja` int(11) NOT NULL,
  `quantidade_atual` int(11) DEFAULT 0,
  `quantidade_minima` int(11) DEFAULT 0,
  `localizacao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estoque`),
  UNIQUE KEY `id_produto` (`id_produto`,`id_loja`),
  KEY `id_loja` (`id_loja`),
  CONSTRAINT `estoques_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `estoques_ibfk_2` FOREIGN KEY (`id_loja`) REFERENCES `loja` (`id_loja`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoques`
--

LOCK TABLES `estoques` WRITE;
/*!40000 ALTER TABLE `estoques` DISABLE KEYS */;
INSERT INTO `estoques` VALUES (1,1,1,20,5,'Prateleira A'),(2,2,2,48,10,'Prateleira B'),(3,3,3,30,10,'Prateleira C'),(4,4,4,15,3,'Prateleira D'),(5,5,5,25,5,'Prateleira E');
/*!40000 ALTER TABLE `estoques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_pedido`
--

DROP TABLE IF EXISTS `item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_pedido` (
  `id_item_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_item_pedido`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `item_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `item_pedido_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedido`
--

LOCK TABLES `item_pedido` WRITE;
/*!40000 ALTER TABLE `item_pedido` DISABLE KEYS */;
INSERT INTO `item_pedido` VALUES (1,1,1,1,2500.00,2500.00),(2,1,2,1,50.00,50.00),(3,2,2,3,50.00,150.00),(4,2,3,1,100.00,100.00),(5,3,4,1,800.00,800.00),(6,6,2,2,50.00,100.00);
/*!40000 ALTER TABLE `item_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loja`
--

DROP TABLE IF EXISTS `loja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loja` (
  `id_loja` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_loja`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loja`
--

LOCK TABLES `loja` WRITE;
/*!40000 ALTER TABLE `loja` DISABLE KEYS */;
INSERT INTO `loja` VALUES (1,'Loja Recife Centro','Rua do Sol, 100','Recife','PE','8130001001'),(2,'Loja Boa Viagem','Av. Boa Viagem, 200','Recife','PE','8130001002'),(3,'Loja Olinda','Rua do Carmo, 300','Olinda','PE','8130001003'),(4,'Loja Jaboatao','Av. Central, 400','Jaboatao','PE','8130001004'),(5,'Loja Paulista','Rua Principal, 500','Paulista','PE','8130001005');
/*!40000 ALTER TABLE `loja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `id_pagamentos` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `forma_pagamento` varchar(50) DEFAULT NULL,
  `data_pagamento` datetime DEFAULT NULL,
  `valor_pagamento` decimal(10,2) NOT NULL,
  `status_pagamento` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_pagamentos`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,1,'Cartao','2026-10-01 10:10:00',2550.00,'Aprovado'),(2,2,'PIX','2026-10-02 11:35:00',250.00,'Aprovado'),(3,3,'Dinheiro','2026-10-03 14:10:00',800.00,'Aprovado'),(4,4,'Cartao',NULL,300.00,'Pendente'),(5,5,'PIX','2026-10-05 16:50:00',100.00,'Aprovado'),(6,6,'PIX','2026-10-22 17:16:41',100.00,'Aprovado');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_loja` int(11) NOT NULL,
  `data_pedido` datetime DEFAULT current_timestamp(),
  `valor_total` decimal(10,2) DEFAULT 0.00,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_loja` (`id_loja`),
  KEY `idx_pedido_data` (`data_pedido`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_loja`) REFERENCES `loja` (`id_loja`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'2026-10-01 10:00:00',2550.00,'Pago'),(2,2,2,'2026-10-02 11:30:00',250.00,'Pago'),(3,3,3,'2026-10-03 14:00:00',800.00,'Pago'),(4,4,4,'2026-10-04 15:20:00',300.00,'Pendente'),(5,5,5,'2026-10-05 16:45:00',100.00,'Pago'),(6,1,2,'2026-10-22 17:16:41',100.00,'Pago');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `estoque_minimo` int(11) DEFAULT 0,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Notebook','Notebook para trabalho',2500.00,'Informatica','TechPlus',5),(2,'Mouse','Mouse USB optico',55.00,'Acessorios','Click',10),(3,'Teclado','Teclado USB ABNT2',100.00,'Acessorios','Digit',10),(4,'Monitor','Monitor LED 24 polegadas',800.00,'Informatica','Vision',3),(5,'Headset','Headset com microfone',150.00,'Audio','SoundMax',5);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_relatorio_vendas`
--

DROP TABLE IF EXISTS `vw_relatorio_vendas`;
/*!50001 DROP VIEW IF EXISTS `vw_relatorio_vendas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_relatorio_vendas` AS SELECT 
 1 AS `id_pedido`,
 1 AS `cliente`,
 1 AS `loja`,
 1 AS `data_pedido`,
 1 AS `valor_total`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_relatorio_vendas`
--

/*!50001 DROP VIEW IF EXISTS `vw_relatorio_vendas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_relatorio_vendas` AS select `p`.`id_pedido` AS `id_pedido`,`c`.`nome` AS `cliente`,`l`.`nome` AS `loja`,`p`.`data_pedido` AS `data_pedido`,`p`.`valor_total` AS `valor_total`,`p`.`status` AS `status` from ((`pedido` `p` join `clientes` `c` on(`p`.`id_cliente` = `c`.`id_cliente`)) join `loja` `l` on(`p`.`id_loja` = `l`.`id_loja`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22 17:18:07
