ALTER TABLE plante ADD owner INT(11)
ALTER TABLE plante ADD CONSTRAINT fk_user FOREIGN KEY (owner) REFERENCES utilisateur(id_utilisateur)

CREATE TRIGGER `Historisation_etat_plante` AFTER UPDATE ON `etat_plante`
 FOR EACH ROW BEGIN
                IF NEW.status != OLD.status THEN
                    INSERT INTO historique_etat(id_etat, id_plante, date_changement, date, status) VALUES (OLD.id_etat, OLD.id_plante, CURRENT_TIMESTAMP, OLD.date, OLD.status);
                END IF;
            END;

CREATE TRIGGER `historisation_changement_zone` AFTER UPDATE ON `plante`
 FOR EACH ROW BEGIN
                IF NEW.id_zone != OLD.id_zone THEN
                    INSERT INTO historique_zone(id_plante, id_zone, date_changement) VALUES (OLD.id_plante, OLD.id_zone, CURRENT_TIMESTAMP);
                END IF;
            END;

CREATE TRIGGER `historisation_cycle_vegetatif` AFTER UPDATE ON `plante`
 FOR EACH ROW BEGIN
                IF NEW.id_cycle_vegetatif != OLD.id_cycle_vegetatif THEN
                    INSERT INTO historique_cycle(id_cycle_vegetatif, id_plante, date_changement) VALUES (OLD.id_cycle_vegetatif, OLD.id_plante, CURRENT_TIMESTAMP);
                END IF;
            END;

CREATE TRIGGER `suppression_plante` AFTER DELETE ON `plante`
 FOR EACH ROW BEGIN
	DELETE FROM historique_etat
    WHERE historique_etat.id_plante = OLD.id_plante;
    
    DELETE FROM historique_zone
    WHERE historique_zone.id_plante = OLD.id_plante;
    
    DELETE FROM historique_cycle
    WHERE historique_cycle.id_plante = OLD.id_plante;
    
END;