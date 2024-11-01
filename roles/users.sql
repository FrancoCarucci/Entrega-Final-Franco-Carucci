USE huellitas;

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