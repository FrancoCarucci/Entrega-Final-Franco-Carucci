-- PROCEDURES
USE huellitas;

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

