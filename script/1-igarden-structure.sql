-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le :  lun. 02 mai 2022 à 10:13
-- Version du serveur :  8.0.23
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `igarden`
--
DROP DATABASE IF EXISTS `igarden`;
CREATE DATABASE IF NOT EXISTS `igarden` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `igarden`;

-- --------------------------------------------------------

--
-- Structure de la table `cycle_vegetatif`
--

DROP TABLE IF EXISTS `cycle_vegetatif`;
CREATE TABLE IF NOT EXISTS `cycle_vegetatif` (
  `id_cycle_vegetatif` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(15) NOT NULL,
  PRIMARY KEY (`id_cycle_vegetatif`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `etat`
--

DROP TABLE IF EXISTS `etat`;
CREATE TABLE IF NOT EXISTS `etat` (
  `id_etat` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  PRIMARY KEY (`id_etat`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `etat_plante`
--

DROP TABLE IF EXISTS `etat_plante`;
CREATE TABLE IF NOT EXISTS `etat_plante` (
  `id_plante` int NOT NULL,
  `id_etat` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('Actif','Passé','Traité') NOT NULL DEFAULT 'Actif',
  PRIMARY KEY (`id_plante`,`id_etat`),
  KEY `id_etat_idx` (`id_etat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

DROP TABLE IF EXISTS `famille`;
CREATE TABLE IF NOT EXISTS `famille` (
  `id_famille` int NOT NULL AUTO_INCREMENT,
  `id_famille_parente` int DEFAULT NULL,
  `nom` varchar(30) NOT NULL,
  PRIMARY KEY (`id_famille`),
  KEY `nom_famille_UNIQUE` (`nom`),
  KEY `id_famille_parente_idx` (`id_famille_parente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `graine`
--

DROP TABLE IF EXISTS `graine`;
CREATE TABLE IF NOT EXISTS `graine` (
  `id_graine` int NOT NULL AUTO_INCREMENT,
  `id_famille` int DEFAULT NULL,
  `nom` varchar(30) NOT NULL,
  `nom_latin` varchar(50) DEFAULT NULL,
  `classification` enum('Vivace','Annuelle','Bisannuelle') NOT NULL,
  `hauteur_max` int DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `icone` varchar(255) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id_graine`),
  KEY `id_famille_idx` (`id_famille`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historique_cycle`
--

DROP TABLE IF EXISTS `historique_cycle`;
CREATE TABLE IF NOT EXISTS `historique_cycle` (
  `id_cycle_vegetatif` int NOT NULL,
  `id_plante` int NOT NULL,
  `date_changement` datetime NOT NULL,
  PRIMARY KEY (`id_cycle_vegetatif`,`id_plante`),
  KEY `id_plante_idx` (`id_plante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historique_etat`
--

DROP TABLE IF EXISTS `historique_etat`;
CREATE TABLE IF NOT EXISTS `historique_etat` (
  `id_etat` int NOT NULL,
  `id_plante` int NOT NULL,
  `date_changement` datetime NOT NULL,
  `date` date DEFAULT NULL,
  `status` enum('Actif','Passé','Traité') NOT NULL,
  PRIMARY KEY (`id_etat`,`id_plante`,`date_changement`),
  KEY `id_plante_idx` (`id_plante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historique_zone`
--

DROP TABLE IF EXISTS `historique_zone`;
CREATE TABLE IF NOT EXISTS `historique_zone` (
  `id_plante` int NOT NULL,
  `id_zone` int NOT NULL,
  `date_changement` datetime NOT NULL,
  PRIMARY KEY (`id_plante`,`id_zone`),
  KEY `id_zone_idx` (`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jardin`
--

DROP TABLE IF EXISTS `jardin`;
CREATE TABLE IF NOT EXISTS `jardin` (
  `id_jardin` int NOT NULL AUTO_INCREMENT,
  `id_rusticite` int DEFAULT NULL,
  `nom` varchar(30) NOT NULL,
  `code_postal` int DEFAULT NULL,
  PRIMARY KEY (`id_jardin`),
  KEY `id_rusticite_idx` (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jardin_utilisateur`
--

DROP TABLE IF EXISTS `jardin_utilisateur`;
CREATE TABLE IF NOT EXISTS `jardin_utilisateur` (
  `id_utilisateur` int NOT NULL,
  `id_jardin` int NOT NULL,
  PRIMARY KEY (`id_utilisateur`,`id_jardin`),
  KEY `id_jardin_idx` (`id_jardin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `plante`
--

DROP TABLE IF EXISTS `plante`;
CREATE TABLE IF NOT EXISTS `plante` (
  `id_plante` int NOT NULL AUTO_INCREMENT,
  `id_graine` int NOT NULL,
  `id_jardin` int DEFAULT NULL,
  `id_zone` int DEFAULT NULL,
  `id_cycle_vegetatif` int NOT NULL,
  `date_semis` date DEFAULT NULL,
  `date_repiquage` date DEFAULT NULL,
  `date_floraison` date DEFAULT NULL,
  `date_recolte` date DEFAULT NULL,
  `quantite_recolte` int DEFAULT NULL,
  PRIMARY KEY (`id_plante`),
  KEY `id_graine_idx` (`id_graine`),
  KEY `id_jardin_idx` (`id_jardin`),
  KEY `id_zone_idx` (`id_zone`),
  KEY `id_cycle_vegetatif_idx` (`id_cycle_vegetatif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rusticite`
--

DROP TABLE IF EXISTS `rusticite`;
CREATE TABLE IF NOT EXISTS `rusticite` (
  `id_rusticite` int NOT NULL AUTO_INCREMENT,
  `code_rusticite` varchar(2) NOT NULL,
  `temp_min` decimal(3,1) NOT NULL,
  PRIMARY KEY (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(30) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `mot_de_passe` varchar(50) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `mail_UNIQUE` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `zone`
--

DROP TABLE IF EXISTS `zone`;
CREATE TABLE IF NOT EXISTS `zone` (
  `id_zone` int NOT NULL AUTO_INCREMENT,
  `id_jardin` int NOT NULL,
  `id_rusticite` int DEFAULT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_zone`),
  KEY `id_jardin_idx` (`id_jardin`),
  KEY `id_rusticite_idx` (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `etat_plante`
--
ALTER TABLE `etat_plante`
  ADD CONSTRAINT `fk_id_etat_etat_plante` FOREIGN KEY (`id_etat`) REFERENCES `etat` (`id_etat`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_id_plante_etat_plante` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`) ON DELETE CASCADE;

--
-- Contraintes pour la table `famille`
--
ALTER TABLE `famille`
  ADD CONSTRAINT `fk_id_famille_parente_famille` FOREIGN KEY (`id_famille_parente`) REFERENCES `famille` (`id_famille`) ON DELETE CASCADE;

--
-- Contraintes pour la table `graine`
--
ALTER TABLE `graine`
  ADD CONSTRAINT `fk_id_famille_graine` FOREIGN KEY (`id_famille`) REFERENCES `famille` (`id_famille`);

--
-- Contraintes pour la table `historique_cycle`
--
ALTER TABLE `historique_cycle`
  ADD CONSTRAINT `fk_id_cycle_vegetatif_historique_cycle` FOREIGN KEY (`id_cycle_vegetatif`) REFERENCES `cycle_vegetatif` (`id_cycle_vegetatif`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_id_plante_historique_cycle` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`) ON DELETE CASCADE;

--
-- Contraintes pour la table `historique_etat`
--
ALTER TABLE `historique_etat`
  ADD CONSTRAINT `fk_id_etat_historique_etat` FOREIGN KEY (`id_etat`) REFERENCES `etat` (`id_etat`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_id_plante_historique_etat` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`) ON DELETE CASCADE;

--
-- Contraintes pour la table `historique_zone`
--
ALTER TABLE `historique_zone`
  ADD CONSTRAINT `fk_id_zone_historique_zone` FOREIGN KEY (`id_zone`) REFERENCES `zone` (`id_zone`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idplante_historique_zone` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`) ON DELETE CASCADE;

--
-- Contraintes pour la table `jardin`
--
ALTER TABLE `jardin`
  ADD CONSTRAINT `fk_id_rusticite_jardin` FOREIGN KEY (`id_rusticite`) REFERENCES `rusticite` (`id_rusticite`);

--
-- Contraintes pour la table `jardin_utilisateur`
--
ALTER TABLE `jardin_utilisateur`
  ADD CONSTRAINT `fk_id_jardin_jardin_utilisateir` FOREIGN KEY (`id_jardin`) REFERENCES `jardin` (`id_jardin`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_id_utilisateur_jardin_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `plante`
--
ALTER TABLE `plante`
  ADD CONSTRAINT `fk_cycle_vegetatif_plante` FOREIGN KEY (`id_cycle_vegetatif`) REFERENCES `cycle_vegetatif` (`id_cycle_vegetatif`),
  ADD CONSTRAINT `fk_id_graine_plante` FOREIGN KEY (`id_graine`) REFERENCES `graine` (`id_graine`),
  ADD CONSTRAINT `fk_jardin_plante` FOREIGN KEY (`id_jardin`) REFERENCES `jardin` (`id_jardin`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_zone_plante` FOREIGN KEY (`id_zone`) REFERENCES `zone` (`id_zone`);

--
-- Contraintes pour la table `zone`
--
ALTER TABLE `zone`
  ADD CONSTRAINT `fk_id_jardin_zone` FOREIGN KEY (`id_jardin`) REFERENCES `jardin` (`id_jardin`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_id_rusticite_zone` FOREIGN KEY (`id_rusticite`) REFERENCES `rusticite` (`id_rusticite`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
