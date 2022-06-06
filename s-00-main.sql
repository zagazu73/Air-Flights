--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Archivo principal de prueba del proyecto

whenever sqlerror exit rollback;
prompt Creando usuarios...
@s-01-usuarios.sql

prompt Creando objetos del modelo relacional...
@s-02-entidades.sql

prompt Tablas temporales...
@s-03-tablas-temporales.sql

prompt Creando tabla externa...
@s-04-tablas-externas.sql

prompt Creando secuencias...
@s-05-secuencias.sql

prompt Creando indices...
@s-06-indices.sql

prompt Creando sinonimos...
@s-07-sinonimos.sql

prompt Generando vistas...
@s-08-vistas.sql

prompt Realizando la carga inicial...
@s-09-carga-inicial.sql

prompt Realizando consultas...
@s-10-consultas.sql

prompt Creando triggers...
@s-11-tr-email-pasajero.sql
@s-11-tr-maletas.sql
@s-11-tr-link-empleado.sql
@s-11-tr-historico.sql

