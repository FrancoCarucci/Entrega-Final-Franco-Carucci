USE huellitas;

START TRANSACTION;

-- Intentar insertar un nuevo diagnóstico en el historial médico
INSERT INTO HISTORIAL_SALUD (mascota_id, fecha_consulta, diagnostico, tratamiento)
VALUES (7, CURDATE(), 'Resfriado', 'Descanso y líquidos');

-- Verificar si el historial fue actualizado antes de cambiar el estado de salud en MASCOTA
IF ROW_COUNT() > 0 THEN
    UPDATE MASCOTA
    SET estado_salud = 'en tratamiento'
    WHERE mascota_id = 7;
    COMMIT;
ELSE
    -- Si falla el registro en el historial, revertir la transacción
    ROLLBACK;
END IF;
