USE mysql;

-- Crear el usuario administrador si no existe
CREATE USER IF NOT EXISTS 'administrador_huellitas'@'%' IDENTIFIED BY 'huellitas_2024';

-- Otorgar todos los privilegios en la base de datos *huellitas* al usuario administrador
GRANT ALL PRIVILEGES ON huellitas.* TO 'administrador_huellitas'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

USE huellitas;

-- Crear roles en la base de datos huellitas
CREATE ROLE role_select_vistas;
CREATE ROLE role_crud_mascotas;
CREATE ROLE role_crud_adopciones;

-- Asignar privilegios de solo lectura a role_select_vistas en las vistas
GRANT SELECT ON vista_adopciones_completas TO role_select_vistas;
GRANT SELECT ON vista_mascotas_sin_adoptar TO role_select_vistas;

-- Asignar privilegios CRUD al role_crud_mascotas
GRANT ALL PRIVILEGES ON mascotas TO role_crud_mascotas;
GRANT ALL PRIVILEGES ON razas TO role_crud_mascotas;

-- Asignar privilegios CRUD al role_crud_adopciones
GRANT ALL PRIVILEGES ON adopciones TO role_crud_adopciones;

FLUSH PRIVILEGES;


