USE huellitas;

-- Crear el usuario administrador si no existe
CREATE USER IF NOT EXISTS 'administrador_huellitas'@'%' IDENTIFIED BY 'huellitas_2024';

-- Otorgar todos los privilegios en la base de datos *huellitas* al usuario administrador
GRANT ALL PRIVILEGES ON huellitas.* TO 'administrador_huellitas'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

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

-- Crear usuarios con permisos de solo lectura en las vistas
CREATE USER 'usuario_vistas'@'%' IDENTIFIED BY 'password_vistas';
GRANT role_select_vistas TO 'usuario_vistas'@'%';

-- Crear usuarios con permisos CRUD en la tabla de mascotas
CREATE USER 'usuario_mascotas'@'%' IDENTIFIED BY 'password_mascotas';
GRANT role_crud_mascotas TO 'usuario_mascotas'@'%';

-- Crear usuarios con permisos CRUD en la tabla de adopciones
CREATE USER 'usuario_adopciones'@'%' IDENTIFIED BY 'password_adopciones';
GRANT role_crud_adopciones TO 'usuario_adopciones'@'%';

FLUSH PRIVILEGES;

