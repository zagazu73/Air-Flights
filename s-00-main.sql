--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Archivo principal de prueba del proyecto

whenever sqlerror exit rollback;
prompt Creando usuarios...
@s-01-usuarios.sql

prompt Creando objetos del modelo relacional...
@s-02-entidades.sql

prompt Creando sinonimos...
@s-07-sinonimos.sql

prompt Generando vistas...
@s-08-vistas.sql


--@s-04-respuestas.sql
--@s-05-validador-main.sql

