-- VISTAS
USE huellitas;

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
