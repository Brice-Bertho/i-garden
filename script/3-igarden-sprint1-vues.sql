CREATE VIEW liste_des_plantes as 
SELECT graine.nom as nomGraine, zone.nom as nomZone, cycle_vegetatif.nom as nomCycleVegetatif
FROM graine JOIN plante ON graine.id_graine = plante.id_graine
JOIN zone ON zone.id_zone = plante.id_zone
JOIN cycle_vegetatif ON cycle_vegetatif.id_cycle_vegetatif = plante.id_cycle_vegetatif;

CREATE VIEW plantes_hors_zone AS
SELECT graine.nom, utilisateur.pseudo
FROM plante
INNER JOIN graine ON graine.id_graine = plante.id_graine
LEFT JOIN jardin ON plante.id_jardin = jardin.id_jardin
LEFT JOIN jardin_utilisateur ON jardin.id_jardin = jardin_utilisateur.id_jardin
LEFT JOIN utilisateur ON jardin_utilisateur.id_utilisateur = utilisateur.id_utilisateur
WHERE plante.id_zone IS NULL;

CREATE VIEW zones_recap AS
SELECT zone.nom as nomZone, rusticite.code_rusticite as codeRusticite, COUNT(plante.id_plante) as nombrePlantes
FROM plante JOIN zone ON plante.id_zone = zone.id_zone
JOIN rusticite ON zone.id_rusticite = rusticite.id_rusticite
GROUP BY zone.nom;

CREATE VIEW liste_des_graines AS
SELECT graine.nom as Nom, famille.nom as espece, famille.id_famille_parente as parent,
(SELECT famille.nom from famille WHERE famille.id_famille = parent LIMIT 1) as Genre, 
graine.nom_latin as Nom_Latin
FROM graine
INNER JOIN famille ON graine.id_famille = famille.id_famille