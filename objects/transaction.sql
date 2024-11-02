USE huellitas;

START TRANSACTION;
-- Registro de una nueva adopción
INSERT INTO adopciones (id_adoptante, id_colaborador, id_mascota, fecha)
VALUES (3, 2, 5, '2024-11-01');

-- Actualización de información de un colaborador
UPDATE colaboradores
SET domicilio = 'Avenida Nueva 123', telefono = '5551112222'
WHERE id_colaborador = 2;

-- Si ambas operaciones son exitosas, se confirma la transacción
COMMIT;

-- Si hay algún error, se hace rollback
ROLLBACK;
