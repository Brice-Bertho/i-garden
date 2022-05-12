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
USE `igarden`;
--
-- Déchargement des données de la table `cycle_vegetatif`
--

INSERT INTO `cycle_vegetatif` (`id_cycle_vegetatif`, `nom`) VALUES
(2, 'Croissance'),
(3, 'Floraison'),
(4, 'Fructification'),
(1, 'Germination'),
(5, 'Mort');

--
-- Déchargement des données de la table `etat`
--

INSERT INTO `etat` (`id_etat`, `nom`) VALUES
(2, 'Assoiffé'),
(1, 'Malade');

--
-- Déchargement des données de la table `famille`
--

INSERT INTO `famille` (`id_famille`, `id_famille_parente`, `nom`) VALUES
(1, NULL, 'Cucurbitaceae'),
(2, NULL, 'Alliaceae'),
(3, 1, 'Cucurbita'),
(4, 2, 'Allium'),
(5, 3, 'Cucurbita pepo'),
(6, 4, 'Bleu de Solaise');



--
-- Déchargement des données de la table `rusticite`
--

INSERT INTO `rusticite` (`id_rusticite`, `code_rusticite`, `temp_min`) VALUES
(1, '1', '-99.0'),
(2, '2', '-45.0'),
(3, '3', '-40.0'),
(4, '4', '-34.0'),
(5, '5', '-29.0'),
(6, '6', '23.0'),
(7, '7', '-18.0'),
(8, '8', '-12.0'),
(9, '8a', '-12.2'),
(10, '8b', '-9.4'),
(11, '9', '-7.0'),
(12, '9a', '-6.7'),
(13, '9b', '-3.9'),
(14, '10', '-1.0'),
(15, '11', '4.0');


--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `pseudo`, `mail`, `mot_de_passe`) VALUES
(1, 'toto', 'toto@toto.fr', 'f71dbe52628a3f83a77ab494817525c6'),
(2, 'igor', 'igor@toto.fr', 'dd97813dd40be87559aaefed642c3fbb');

--
-- Déchargement des données de la table `jardin`
--

INSERT INTO `jardin` (`id_jardin`, `id_rusticite`, `nom`, `code_postal`) VALUES
(1, 11, 'Jardin de toto', 35000),
(2, 10, 'Jardin partagé', 35170);

--
-- Déchargement des données de la table `jardin_utilisateur`
--

INSERT INTO `jardin_utilisateur` (`id_utilisateur`, `id_jardin`) VALUES
(1, 1),
(1, 2),
(2, 2);

--
-- Déchargement des données de la table `zone`
--

INSERT INTO `zone` (`id_zone`, `id_jardin`, `id_rusticite`, `nom`, `description`) VALUES
(1, 1, NULL, 'Carré potager', 'Terre du jardin, terreau et compost'),
(2, 1, 13, 'Veranda', NULL),
(3, 2, NULL, 'Jardin partagé', 'Terre du jardin + Compost + Ammendé en 2021');

--
-- Déchargement des données de la table `graine`
--

INSERT INTO `graine` (`id_graine`, `id_famille`, `nom`, `nom_latin`, `classification`, `hauteur_max`, `photo`, `icone`, `description`) VALUES
(1, 6, 'Poireau bleu de solaise', 'Allium porrum', 'Vivace', 75, NULL, NULL, NULL),
(2, 5, 'Courge spaghetti', 'Cucurbita pepo', 'Annuelle', 50, NULL, NULL, NULL);


--
-- Déchargement des données de la table `plante`
--

INSERT INTO `plante` (`id_plante`, `id_graine`, `id_jardin`, `id_zone`, `id_cycle_vegetatif`, `date_semis`, `date_repiquage`, `date_floraison`, `date_recolte`, `quantite_recolte`) VALUES
(5, 1, NULL, 3, 2, NULL, '2022-02-08', NULL, NULL, NULL),
(6, 2, NULL, 1, 2, '2022-04-02', '2022-05-01', NULL, NULL, NULL);

--
-- Déchargement des données de la table `etat_plante`
--

INSERT INTO `etat_plante` (`id_plante`, `id_etat`, `date`, `status`) VALUES
(6, 2, '2022-05-02 00:00:00', 'Actif');


--
-- Déchargement des données de la table `historique_cycle`
--

INSERT INTO `historique_cycle` (`id_cycle_vegetatif`, `id_plante`, `date_changement`) VALUES
(1, 6, '2022-04-02 00:00:00');

--
-- Déchargement des données de la table `historique_etat`
--

INSERT INTO `historique_etat` (`id_etat`, `id_plante`, `date_changement`, `date`, `status`) VALUES
(2, 6, '2022-04-27 00:00:00', '2022-04-26', 'Actif'),
(2, 6, '2022-05-01 00:00:00', '2022-04-27', 'Traité');

--
-- Déchargement des données de la table `historique_zone`
--

INSERT INTO `historique_zone` (`id_plante`, `id_zone`, `date_changement`) VALUES
(6, 2, '2022-05-01 00:00:00');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

