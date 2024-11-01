-- TRIGGERS
USE huellitas;

-- Trigger que asegure que los colaboradores tengan al menos 18 años
DELIMITER //
CREATE TRIGGER before_insert_colaborador
BEFORE INSERT ON colaboradores
FOR EACH ROW
BEGIN
    DECLARE edad INT;

    SELECT TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE()) INTO edad;

    IF edad < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El colaborador debe tener al menos 18 años.';
    END IF;
END;

-- Trigger para que se active antes de eliminar una mascota, impide que una mascota adoptada se elimine
DELIMITER //
CREATE TRIGGER antes_de_borrar_mascota
BEFORE DELETE ON mascotas
FOR EACH ROW
BEGIN
    DECLARE total_adopciones INT;

    SELECT COUNT(*) INTO total_adopciones
    FROM adopciones
    WHERE id_mascota = OLD.id_mascota;

    IF total_adopciones > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar una mascota que ha sido adoptada.';
    END IF;
END;
DELIMITER //
