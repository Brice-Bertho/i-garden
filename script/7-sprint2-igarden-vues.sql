CREATE VIEW plante_precaire AS
SELECT graine.nom_latin AS planteNomLatin, plante.temperature_minimale AS planteTempMin, rusticite.temp_min AS environnementTempMin
FROM graine JOIN plante ON graine.id_graine = plante.id_graine
JOIN zone ON plante.id_zone = zone.id_zone
JOIN rusticite ON zone.id_rusticite = rusticite.id_rusticite
WHERE plante.temperature_minimale < rusticite.temp_min

CREATE VIEW zones_rotation AS
SELECT zone.nom as nomZone, plante.date_semis as dateSemis, GROUP_CONCAT(famille.nom LIMIT 3) as nomFamille
FROM zone JOIN plante on zone.id_zone = plante.id_zone
JOIN graine ON plante.id_graine = graine.id_graine
JOIN famille ON graine.id_famille = famille.id_famille
GROUP BY zone.nom
ORDER BY plante.date_semis DESC