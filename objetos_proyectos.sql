-- VISTAS

CREATE VIEW vista_adopciones_completas AS
SELECT 
    a.id_adopcion,
    ad.nombre AS nombre_adoptante,
    ad.apellido AS apellido_adoptante,
    c.nombre AS nombre_colaborador,
    c.apellido AS apellido_colaborador,
    m.nombre AS nombre_mascota,
    r.detalle AS raza_mascota,
    a.fecha
FROM adopciones a
JOIN adoptantes ad ON a.id_adoptante = ad.id_adoptante
JOIN colaboradores c ON a.id_colaborador = c.id_colaborador
JOIN mascotas m ON a.id_mascota = m.id_mascota
JOIN razas r ON m.cod_raza = r.cod_raza;

CREATE VIEW vista_mascotas_sin_adoptar AS
SELECT 
    m.id_mascota,
    m.nombre AS nombre_mascota,
    r.detalle AS raza_mascota,
    m.fecha_ingreso
FROM mascotas m
LEFT JOIN adopciones a ON m.id_mascota = a.id_mascota
JOIN razas r ON m.cod_raza = r.cod_raza
WHERE a.id_mascota IS NULL;

-- FUNCIONES
DELIMITER //
CREATE FUNCTION fn_adoptada(mascota_id INT)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE adoptada BOOLEAN;

    SELECT COUNT(*) > 0 INTO adoptada
    FROM adopciones
    WHERE id_mascota = mascota_id;
    
    

    RETURN adoptada;
    END //
    DELIMITER ;
    
    SELECT fn_adoptada(20) AS mascota_adoptada;
    
    DELIMITER //
    
    CREATE FUNCTION fn_ultima_adopcion(adoptante_id INT)
RETURNS DATE
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ultima_fecha DATE;
    
    SELECT MAX(fecha) INTO ultima_fecha
    FROM adopciones
    WHERE id_adoptante = adoptante_id;
    
    RETURN ultima_fecha;
END //
DELIMITER //

SELECT fn_ultima_adopcion(3) AS ultima_adopcion;

-- PROCEDURES
-- Procedimiento para actualizar los datos de un colaborador 
DELIMITER //
CREATE PROCEDURE sp_actualizar_colaborador (
    IN p_id_colaborador INT,
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_fecha_nacimiento DATE,
    IN p_domicilio VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE colaboradores
    SET nombre = p_nombre,
        apellido = p_apellido,
        fecha_nacimiento = p_fecha_nacimiento,
        domicilio = p_domicilio,
        telefono = p_telefono,
        correo_electronico = p_correo_electronico
    WHERE id_colaborador = p_id_colaborador;
END;

-- Validacion 
CALL sp_actualizar_colaborador(1, 'Juan', 'Pérez', '1980-05-12', 'Calle Nueva 456', '5559876543', 'juan.perez@example.com');

-- Procedimiento para registrar una nueva adopcion 
DELIMITER //
CREATE PROCEDURE sp_registrar_adopcion (
    IN p_id_adoptante INT,
    IN p_id_colaborador INT,
    IN p_id_mascota INT,
    IN p_fecha DATE
)
BEGIN
    INSERT INTO adopciones (id_adoptante, id_colaborador, id_mascota, fecha)
    VALUES (p_id_adoptante, p_id_colaborador, p_id_mascota, p_fecha);
END;
DELIMITER //

-- Validacion 
CALL sp_registrar_adopcion(1, 2, 3, '2024-10-10')

-- TRIGGERS

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
