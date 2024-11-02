<center>
<img src="https://objetivo.news/download/multimedia.normal.bcba10cea1861629.Y29kZXJob3VzZS1xdWUtZXMtcXVlLWhhY2VuX25vcm1hbC53ZWJw.webp" style="width: 100% ; aspect-ratio:16/9">
</center>


# <center>Entrega de proyecto final</center>
Alumno: Franco Carucci

Comision: SQL 54910

Tutor: Nancy Elizabeth Villena Reines

Docente: Anderson Michel Torres



---

### **Consignas:**
- La base de datos debe contener al menos:
    * ~ 15 tablas, entre las cuales debe haber al menos 1 tabla de hechos,  2 tablas transaccionales.
    * ~ 5 vistas.
    * ~ 2 stored procedure.
    * ~ 2  trigger.
    * ~ 2 funciones
    
- El documento debe contener:
    - Introducción
    - Objetivo
    - Situación problemática
    - Modelo de negocio
    - Diagrama de entidad relació
    - Listado de tablas con descripción de estructura (columna,descripción, tipo de datos, tipo de clave)
    - Scripts de creación de cada objeto de la base de datos
    - Scripts de inserción de datos
    - Informes generados en base a la información de la base
    - Herramientas y tecnologías usadas

---

## Tematica del proyecto
Nuestro equipo de desarrollo está trabajando en un sistema de gestión de reservas para restaurantes, y nos enfrentamos a la necesidad de diseñar una base de datos eficiente que pueda manejar todas las operaciones relacionadas con las reservas de manera óptima.


## Modelo de negocio

1. **Gestión de Clientes y Empleados**: Necesitamos una base de datos que nos permita registrar la información de los clientes que realizan reservas, así como de los empleados involucrados en el proceso de reserva, como los camareros o encargados de atención al cliente.

2. **Gestión de Tipos de Reserva**: Es importante poder clasificar las reservas según su tipo, ya sea una reserva estándar, una reserva para eventos especiales o reservas de grupos grandes. Esto nos ayudará a organizar mejor el flujo de trabajo y adaptar nuestros servicios según las necesidades del cliente.

3. **Gestión de Mesas y Disponibilidad**: La base de datos debe permitirnos registrar la disponibilidad de mesas en cada restaurante, así como gestionar su capacidad y estado (ocupado o disponible). Esto es fundamental para garantizar una asignación eficiente de mesas y evitar conflictos de reservas.

4. **Registro de Reservas**: Necesitamos un sistema que pueda registrar de manera detallada cada reserva realizada, incluyendo la fecha y hora de la reserva, el cliente que la realizó, la mesa reservada, el empleado que atendió la reserva y el tipo de reserva.

El modelo de negocio de Huellitas en la ciudad de La Plata se centra en la recepción, cuidado,
tratamiento y adopción de mascotas sin hogar.

Este refugio tiene como objetivo principal proporcionar un hogar temporal a las mascotas
desamparadas, brindarles la atención veterinaria necesaria y facilitar su adopción a personas
responsables y dispuestas a cuidarlas.

El objetivo es agilizar el dia a dia del refugio, ordenar sus datos y facilitar la toma de decisiones para la
supervivencia de la organizacion a lo largo del tiempo


## Diagrama entidad relacion (DER)


<img
src="https://github.com/FrancoCarucci/Entrega-Final-Franco-Carucci/blob/main/DER_Huellitas.png">

```



## Listado de tablas y descripcion




## Estructura e ingesta de datos
* Se realiza principalmente por medio del archivo population.sql


  
## *OBJETOS*

## Funciones

### `fn_adoptada()`
Esta función sirve para devolver un valor (por ejemplo, 1 para indicar que la mascota está adoptada y 0 si no lo está) en función de si hay un registro en la tabla de adopciones correspondiente a una mascota específica.

**Ejemplo de uso:**
```sql
SELECT fn_adoptada(20) AS mascota_adoptada;
```

### `fn_ultima_adopcion()`
Esta funcion fue diseñada para devolver la fecha de la última adopción realizada por un adoptante específico..

**Ejemplo de uso:**
```sql
SELECT fn_ultima_adopcion(3) AS ultima_adopcion;
```

## Vistas

### `vista_mascotas_sin_adoptar`
Si existe una tabla de mascotas que no han sido adoptadas, esta vista muestra las mascotas que aún no han sido adoptadas.

**Ejemplo de uso:**
```sql
SELECT * FROM vista_mascotas_sin_adoptar;
```

### `vista_adopciones_complejas`
Esta vista combina información de adoptantes, colaboradores y mascotas para mostrar un resumen completo de las adopciones.

**Ejemplo de uso:**
```sql
SELECT *
FROM vista_adopciones_compleja
WHERE fecha_adopcion >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);
```

## Procedimientos

## `sp_actualizar_colaborador()`
Actualiza los datos de un colaborador

**Parámetros:**
- `id_colaborador`
- `nombre`
- `apellido`
- `fecha_nacimiento`
- `domicilio`
- `telefono`
- `correo_electronico`

**Ejemplo de uso:**
```sql
CALL sp_actualizar_colaborador(1, 'Juan', 'Pérez', '1980-05-12', 'Calle Nueva 456', '5559876543', 'juan.perez@example.com');
```

### `sp_registrar_adopcion()`
Este procedimiento se utiliza para registrar una nueva adopcion

**Parámetros:**
- `id_adoptante`
- `id_colaborador`
- `id_mascota`
- `fecha`

**Ejemplo de uso:**
```sql
CALL sp_registrar_adopcion(1, 2, 3, '2024-10-10');
```

## Triggers

### `before_insert_colaborador`
Este trigger valida que los colaboradores tengan al menos 18 años antes de ser insertados en la base de datos.

**Ejemplo de uso:**
```sql
INSERT INTO colaboradores (nombre, apellido, fecha_nacimiento, domicilio, telefono, correo_electronico)
VALUES ('Juan', 'Pérez', '2010-05-15', 'Av. Juventud 123', '5551234567', 'juan.perez@example.com');
```

### `antes_de_borrar_mascota`
Este trigger se activa antes de que se elimine una mascota. Si la mascota ha sido adoptada, se impide la eliminación.

**Ejemplo de uso:**
```sql
DELETE FROM mascotas WHERE id_mascota = 8;
```

## Transacciones

Actualización de Historial Médico de una Mascota con Verificación
```sql
INSERT INTO HISTORIAL_SALUD (mascota_id, fecha_consulta, diagnostico, tratamiento)
VALUES (7, CURDATE(), 'Resfriado', 'Descanso y líquidos');

IF ROW_COUNT() > 0 THEN
    UPDATE MASCOTA
    SET estado_salud = 'en tratamiento'
    WHERE mascota_id = 7;
```
Usando COMMIT agrego los cambios, de lo contrario, con ROLLBACK, se deshacen












```

