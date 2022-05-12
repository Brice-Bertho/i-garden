ALTER TABLE zone
ADD latitude decimal(8,6) null,
ADD longitude decimal(8,6) null,
ADD largeur int(11) null,
ADD hauteur int(11) null;

CREATE TABLE note
(
    id_note int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_zone int null,
    id_plante int null,
    id_graine int null,
    type varchar(20),
    description text null,
    lien_audio varchar(200) null,
    date_creation DATETIME,
    
    FOREIGN KEY (id_zone) REFERENCES zone(id_zone),
    FOREIGN KEY (id_plante) REFERENCES plante(id_plante),
    FOREIGN KEY (id_graine) REFERENCES graine(id_graine)
)

CREATE TABLE noms_graine
(
    id_noms_graine int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_graine int,
    nom varchar(50),
    
    FOREIGN KEY (id_graine) REFERENCES graine(id_graine)
)

ALTER TABLE graine
DROP nom

ALTER TABLE plante
ADD temperature_minimale decimal(4,2)

DROP VIEW IF EXISTS liste_des_plantes 
CREATE VIEW liste_des_plantes as
SELECT noms_graine.nom as nomGraine, zone.nom as nomZone, cycle_vegetatif.nom as nomCycleVegetatif
FROM graine JOIN plante ON graine.id_graine = plante.id_graine
JOIN noms_graine ON noms_graine.id_graine = graine.id_graine
JOIN zone ON zone.id_zone = plante.id_zone
JOIN cycle_vegetatif ON cycle_vegetatif.id_cycle_vegetatif = plante.id_cycle_vegetatif

CREATE TABLE type_action
(
    id_type_action int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom varchar(100),
    description text,
    logo varchar(100),
    id_type_action_parent int,
    
    FOREIGN KEY(id_type_action_parent) REFERENCES type_action(id_type_action_parent)
)

CREATE TABLE action
(
    id_action int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_type_action int,
    id_utilisateur int,
    id_zone int,
    id_plante int,
    frequence varchar(100),
    date_debut DATE,
    date_fin DATE,
    statut varchar(30),
   
    FOREIGN KEY (id_type_action) REFERENCES type_action(id_type_action),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utlisateur),
    FOREIGN KEY (id_zone) REFERENCES zone(id_zone),
    FOREIGN KEY (id_plante) REFERENCES plante(id_plante)
)