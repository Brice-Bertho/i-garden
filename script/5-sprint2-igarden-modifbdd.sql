SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE note_plante
(
    id_note_plante int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type ENUM('texte', 'audio') NOT NULL,
    description varchar(50),
    lien_audio varchar(50),
    date_creation DATETIME NOT NULL,
    id_plante int NOT NULL,
    
    CONSTRAINT 'fk_note_plante' FOREIGN KEY (id_plante) REFERENCES plante(id_plante) ON DELETE CASCADE,
);

CREATE TABLE note_zone
(
    id_note_zone int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type ENUM('texte', 'audio') NOT NULL,
    description varchar(50),
    lien_audio varchar(50),
    date_creation DATETIME NOT NULL,
    id_zone int NOT NULL,
    
    CONSTRAINT 'fk_note_zone' FOREIGN KEY (id_zone) REFERENCES zone(id_zone) ON DELETE CASCADE,
);

CREATE TABLE note_graine
(
    id_note_graine int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type ENUM('texte', 'audio') NOT NULL,
    description varchar(50),
    lien_audio varchar(50),
    date_creation DATETIME NOT NULL,
    id_graine int NOT NULL,
    
    CONSTRAINT 'fk_note_graine' FOREIGN KEY (id_graine) REFERENCES graine(id_graine) ON DELETE CASCADE,
);

CREATE TABLE noms_graine
(
    id_noms_graine int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_graine int,
    nom varchar(50),
    
    FOREIGN KEY (id_graine) REFERENCES graine(id_graine)
) AS SELECT graine.id_graine, graine.nom FROM graine;

ALTER TABLE graine
DROP nom;

ALTER TABLE plante
ADD temperature_minimale decimal(4,2);

ALTER TABLE plante
ADD owner int
CONSTRAINT 'fk_owner' FOREIGN KEY (owner) REFERENCES utilisateur(id_utilisateur);

DROP VIEW IF EXISTS liste_des_plantes;
CREATE VIEW liste_des_plantes as
SELECT noms_graine.nom as nomGraine, zone.nom as nomZone, cycle_vegetatif.nom as nomCycleVegetatif
FROM graine JOIN plante ON graine.id_graine = plante.id_graine
JOIN noms_graine ON noms_graine.id_graine = graine.id_graine
JOIN zone ON zone.id_zone = plante.id_zone
JOIN cycle_vegetatif ON cycle_vegetatif.id_cycle_vegetatif = plante.id_cycle_vegetatif;

DROP VIEW IF EXISTS plantes_hors_zone;
CREATE VIEW plantes_hors_zone AS
SELECT noms_graine.nom, utilisateur.pseudo
FROM plante
INNER JOIN graine ON graine.id_graine = plante.id_graine
JOIN noms_graine ON noms_graine.id_graine = graine.id_graine
LEFT JOIN jardin ON plante.id_jardin = jardin.id_jardin
LEFT JOIN jardin_utilisateur ON jardin.id_jardin = jardin_utilisateur.id_jardin
LEFT JOIN utilisateur ON jardin_utilisateur.id_utilisateur = utilisateur.id_utilisateur
WHERE plante.id_zone IS NULL;

DROP VIEW IF EXISTS liste_des_graines;
CREATE VIEW liste_des_graines AS
SELECT noms_graine.nom as Nom, famille.nom as espece, famille.id_famille_parente as parent,
(SELECT famille.nom from famille WHERE famille.id_famille = parent LIMIT 1) as Genre, 
graine.nom_latin as Nom_Latin
FROM graine
INNER JOIN noms_graine on noms_graine.id_graine = graine.id_graine
INNER JOIN famille ON graine.id_famille = famille.id_famille;

DROP TABLE IF EXISTS `type_action`;
CREATE TABLE type_action
(
    id_type_action int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom varchar(100),
    description text,
    logo varchar(100),
    id_type_action_parent int,
    
    CONSTRAINT 'fk_type_action' FOREIGN KEY(id_type_action_parent) REFERENCES type_action(id_type_action_parent)
);


DROP TABLE IF EXISTS `action`;
CREATE TABLE action
(
    id_action int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_type_action int,
    id_utilisateur int,
    id_zone int,
    id_jardin int,
    frequence varchar(100),
    date_debut DATE,
    date_fin DATE,
    statut varchar(30),
   
    CONSTRAINT 'fk_action_type' FOREIGN KEY (id_type_action) REFERENCES type_action(id_type_action) ON DELETE CASCADE,
    CONSTRAINT 'fk_user' FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utlisateur) ON DELETE CASCADE,
    CONSTRAINT 'fk_zone' FOREIGN KEY (id_zone) REFERENCES zone(id_zone) ON DELETE CASCADE,
    CONSTRAINT 'fk_jardin' FOREIGN KEY (id_jardin) REFERENCES jardin(id_jardin) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `historique_action`;
CREATE TABLE IF NOT EXISTS `historique_action` (
  `id_action` int NOT NULL,
  `id_zone` int NOT NULL,
  `id_jardin` int NOT NULL,
  `status` Varchar(50) NOT NULL,
  `date_changement` datetime NOT NULL,
  PRIMARY KEY (`id_action`),
  KEY `id_zone_idx` (`id_zone`),
  KEY `id_jardin_idx` (`id_jardin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TRIGGER `historisation_action` AFTER UPDATE ON `action`
 FOR EACH ROW BEGIN
                IF NEW.action.status != OLD.action.status THEN
                    INSERT INTO historique_action(id_zone, id_jardin, status, date_changement) VALUES (OLD.id_zone, OLD.id_jardin, OLD.action.status, CURRENT_TIMESTAMP);
                END IF;
            END;

COMMIT;

