-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 19 avr. 2022 à 13:25
-- Version du serveur :  10.4.13-MariaDB
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `i-garden`
--

-- --------------------------------------------------------

--
-- Structure de la table `classificationplante`
--

DROP TABLE IF EXISTS `classificationplante`;
CREATE TABLE IF NOT EXISTS `classificationplante` (
  `id_classification` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(25) NOT NULL,
  `id_class` int(11) NOT NULL,
  PRIMARY KEY (`id_classification`),
  KEY `fk_class` (`id_class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cyclevegetatif`
--

DROP TABLE IF EXISTS `cyclevegetatif`;
CREATE TABLE IF NOT EXISTS `cyclevegetatif` (
  `id_cycleVegetatif` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cycleVegetatif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `etatplante`
--

DROP TABLE IF EXISTS `etatplante`;
CREATE TABLE IF NOT EXISTS `etatplante` (
  `id_etatPlante` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(20) DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  PRIMARY KEY (`id_etatPlante`),
  KEY `fk_status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `familleplante`
--

DROP TABLE IF EXISTS `familleplante`;
CREATE TABLE IF NOT EXISTS `familleplante` (
  `id_famillePlante` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(25) NOT NULL,
  PRIMARY KEY (`id_famillePlante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `graine`
--

DROP TABLE IF EXISTS `graine`;
CREATE TABLE IF NOT EXISTS `graine` (
  `id_graine` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `nomLatin` varchar(100) NOT NULL,
  `hauteurMaximale` decimal(5,2) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `icone` varchar(250) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `id_famillePlante` int(11) NOT NULL,
  `id_classification` int(11) NOT NULL,
  PRIMARY KEY (`id_graine`),
  KEY `fk_famillePlante` (`id_famillePlante`),
  KEY `fk_classification` (`id_classification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historiquecycle`
--

DROP TABLE IF EXISTS `historiquecycle`;
CREATE TABLE IF NOT EXISTS `historiquecycle` (
  `id_cycleVegetatif` int(11) NOT NULL,
  `id_plante` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cycleVegetatif`,`id_plante`),
  KEY `fk_plante` (`id_plante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historiqueetat`
--

DROP TABLE IF EXISTS `historiqueetat`;
CREATE TABLE IF NOT EXISTS `historiqueetat` (
  `id_etatPlante` int(11) NOT NULL,
  `id_plante` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_etatPlante`,`id_plante`),
  KEY `fk_plantehis` (`id_plante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `historiquezoneplante`
--

DROP TABLE IF EXISTS `historiquezoneplante`;
CREATE TABLE IF NOT EXISTS `historiquezoneplante` (
  `id_plante` int(11) NOT NULL,
  `id_zone` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_plante`,`id_zone`),
  KEY `fk_zonehist` (`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jardins`
--

DROP TABLE IF EXISTS `jardins`;
CREATE TABLE IF NOT EXISTS `jardins` (
  `id_jardin` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `codePostal` varchar(5) NOT NULL,
  `id_rusticite` int(11) NOT NULL,
  PRIMARY KEY (`id_jardin`),
  KEY `fk_rusticite` (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jardins_utilisateurs`
--

DROP TABLE IF EXISTS `jardins_utilisateurs`;
CREATE TABLE IF NOT EXISTS `jardins_utilisateurs` (
  `id_jardin` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_jardin`,`id_utilisateur`),
  KEY `fk_utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `plante`
--

DROP TABLE IF EXISTS `plante`;
CREATE TABLE IF NOT EXISTS `plante` (
  `id_plante` int(11) NOT NULL AUTO_INCREMENT,
  `dateSemis` datetime DEFAULT NULL,
  `dateRepiquage` datetime DEFAULT NULL,
  `dateFloraison` datetime DEFAULT NULL,
  `dateRecolte` datetime DEFAULT NULL,
  `quantiteRecoltee` decimal(5,2) DEFAULT NULL,
  `id_graine` int(11) NOT NULL,
  PRIMARY KEY (`id_plante`),
  KEY `fk_graine` (`id_graine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rusticite`
--

DROP TABLE IF EXISTS `rusticite`;
CREATE TABLE IF NOT EXISTS `rusticite` (
  `id_rusticite` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(10) NOT NULL,
  `temperatureMinimale` varchar(10) NOT NULL,
  PRIMARY KEY (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `motDePasse` varchar(100) NOT NULL,
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `zones`
--

DROP TABLE IF EXISTS `zones`;
CREATE TABLE IF NOT EXISTS `zones` (
  `id_zone` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `typeDeSol` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `id_jardin` int(11) NOT NULL,
  `id_rusticite` int(11) NOT NULL,
  PRIMARY KEY (`id_zone`),
  KEY `fk_jardinZone` (`id_jardin`),
  KEY `fk_rusticiteZone` (`id_rusticite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `classificationplante`
--
ALTER TABLE `classificationplante`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`id_class`) REFERENCES `classificationplante` (`id_classification`);

--
-- Contraintes pour la table `etatplante`
--
ALTER TABLE `etatplante`
  ADD CONSTRAINT `fk_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`);

--
-- Contraintes pour la table `graine`
--
ALTER TABLE `graine`
  ADD CONSTRAINT `fk_classification` FOREIGN KEY (`id_classification`) REFERENCES `classificationplante` (`id_classification`),
  ADD CONSTRAINT `fk_famillePlante` FOREIGN KEY (`id_famillePlante`) REFERENCES `familleplante` (`id_famillePlante`);

--
-- Contraintes pour la table `historiquecycle`
--
ALTER TABLE `historiquecycle`
  ADD CONSTRAINT `fk_cycleVegetatif` FOREIGN KEY (`id_cycleVegetatif`) REFERENCES `cyclevegetatif` (`id_cycleVegetatif`),
  ADD CONSTRAINT `fk_plante` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`);

--
-- Contraintes pour la table `historiqueetat`
--
ALTER TABLE `historiqueetat`
  ADD CONSTRAINT `fk_etatPlante` FOREIGN KEY (`id_etatPlante`) REFERENCES `etatplante` (`id_etatPlante`),
  ADD CONSTRAINT `fk_plantehis` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`);

--
-- Contraintes pour la table `historiquezoneplante`
--
ALTER TABLE `historiquezoneplante`
  ADD CONSTRAINT `fk_plantezonehist` FOREIGN KEY (`id_plante`) REFERENCES `plante` (`id_plante`),
  ADD CONSTRAINT `fk_zonehist` FOREIGN KEY (`id_zone`) REFERENCES `zones` (`id_zone`);

--
-- Contraintes pour la table `jardins`
--
ALTER TABLE `jardins`
  ADD CONSTRAINT `fk_rusticite` FOREIGN KEY (`id_rusticite`) REFERENCES `rusticite` (`id_rusticite`);

--
-- Contraintes pour la table `jardins_utilisateurs`
--
ALTER TABLE `jardins_utilisateurs`
  ADD CONSTRAINT `fk_jardin` FOREIGN KEY (`id_jardin`) REFERENCES `jardins` (`id_jardin`),
  ADD CONSTRAINT `fk_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `plante`
--
ALTER TABLE `plante`
  ADD CONSTRAINT `fk_graine` FOREIGN KEY (`id_graine`) REFERENCES `graine` (`id_graine`);

--
-- Contraintes pour la table `zones`
--
ALTER TABLE `zones`
  ADD CONSTRAINT `fk_jardinZone` FOREIGN KEY (`id_jardin`) REFERENCES `jardins` (`id_jardin`),
  ADD CONSTRAINT `fk_rusticiteZone` FOREIGN KEY (`id_rusticite`) REFERENCES `rusticite` (`id_rusticite`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
