-- FUNCIONES
USE huellitas;

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
