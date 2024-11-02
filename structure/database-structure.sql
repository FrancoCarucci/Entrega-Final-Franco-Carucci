DROP DATABASE IF EXISTS huellitas;
CREATE DATABASE huellitas;
USE huellitas;

 -- TABLAS DIMENSIONALES

CREATE TABLE RAZAS(
cod_raza INT, 
detalle VARCHAR(200),
PRIMARY KEY (cod_raza)
);
CREATE TABLE ADOPTANTES(
id_adoptante INT NOT NULL AUTO_INCREMENT,
dni VARCHAR(11),
nombre VARCHAR(200),
apellido VARCHAR(200),
domicilio VARCHAR (200),
telefono INT,
correo_electronico VARCHAR(200),
PRIMARY KEY (id_adoptante)
);
CREATE TABLE COLABORADORES(
id_colaborador INT NOT NULL AUTO_INCREMENT,
id_proveedor INT, -- FK
id_refugio INT, -- FK
nombre VARCHAR(200),
apellido VARCHAR(200),
fecha_nacimiento DATE NOT NULL,
domicilio VARCHAR(200),
telefono VARCHAR(12),
correo_electronico VARCHAR(200),
PRIMARY KEY (id_colaborador)
);
CREATE TABLE MASCOTAS(
id_mascota INT NOT NULL AUTO_INCREMENT,
id_colaborador INT, -- FK
id_historial INT, -- FK
cod_raza INT, -- FK
nombre VARCHAR(200),
fecha_ingreso DATETIME DEFAULT (CURRENT_TIMESTAMP),
PRIMARY KEY (id_mascota)
);
CREATE TABLE ADOPCIONES(
id_adopcion INT NOT NULL auto_increment,
id_adoptante INT, -- FK
id_colaborador INT, -- FK
id_mascota INT, -- FK
fecha DATE DEFAULT (CURRENT_DATE),
PRIMARY KEY (id_adopcion)
);
CREATE TABLE REFUGIOS(
id_refugio INT NOT NULL auto_increment,
nombre VARCHAR(100),
domicilio VARCHAR(255),
telefono VARCHAR(15),
correo_electronico VARCHAR(100),
PRIMARY KEY (id_refugio)
);
CREATE TABLE PROVEEDORES (
    id_proveedor INT NOT NULL auto_increment,
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(255),
    telefono VARCHAR(15),
    tipo_producto VARCHAR(50),
    PRIMARY KEY (id_proveedor)
);
CREATE TABLE HISTORIAL_SALUD (
    id_historial INT NOT NULL auto_increment,
    id_mascota INT,
    fecha DATE NOT NULL,
    descripcion TEXT NOT NULL,
    tratamiento VARCHAR(255),
    veterinario VARCHAR(100),
    PRIMARY KEY (id_historial)
);

-- ALTER 

	ALTER TABLE MASCOTAS
    ADD CONSTRAINT fk_mascotas_colaborador
    FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES(id_colaborador);
    
    ALTER TABLE MASCOTAS
    ADD CONSTRAINT fk_mascotas_raza
    FOREIGN KEY (cod_raza) REFERENCES RAZAS(cod_raza);
    
     ALTER TABLE MASCOTAS
    ADD CONSTRAINT fk_mascotas_historial
    FOREIGN KEY (id_historial) REFERENCES HISTORIAL_SALUD(id_historial);
    
    
	ALTER TABLE ADOPCIONES
    ADD CONSTRAINT fk_adopciones_colaborador
    FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES(id_colaborador);
    
	ALTER TABLE ADOPCIONES
    ADD CONSTRAINT fk_adopciones_adoptante
    FOREIGN KEY (id_adoptante) REFERENCES ADOPTANTES(id_adoptante);
    
    ALTER TABLE ADOPCIONES
    ADD CONSTRAINT fk_adopciones_mascotas
    FOREIGN KEY (id_mascota) REFERENCES MASCOTAS(id_mascota);
    
    ALTER TABLE COLABORADORES
    ADD CONSTRAINT fk_colaboradores_proveedores
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor);
    
    ALTER TABLE COLABORADORES
    ADD CONSTRAINT fk_colaboradores_refugios
    FOREIGN KEY (id_refugio) REFERENCES REFUGIOS(id_refugio);
