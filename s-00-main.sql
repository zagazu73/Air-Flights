--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Archivo principal de prueba del proyecto

whenever sqlerror exit rollback;
prompt Creando usuarios...
@s-01-usuarios.sql

prompt Creando objetos del modelo relacional...
@s-02-entidades.sql


prompt Creando tablas temporales...
@s-03-tablas-temporales.sql

prompt Creando secuencias...
@s-05-secuencias.sql

prompt Creando índices...
@s-06-indices.sql

prompt Creando sinonimos...
@s-07-sinonimos.sql

prompt Generando vistas...
@s-08-vistas.sql

prompt Carga inicial...
@s-09-carga-inicial.sql

prompt Realizando consultas..
@s-10-consultas.sql

prompt procedimiento crea avion...
@s-13-p-crea_avion.sql

prompt Carga inicial...
@s-14-p-crea_avion_prueba.sql

--@s-04-respuestas.sql
--@s-05-validador-main.sql
