--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Archivo principal de prueba del proyecto

whenever sqlerror exit rollback;
prompt Creando usuarios...
@s-01-usuarios.sql

prompt Creando tabla externa...
@s-04-tablas-externas.sql

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

prompt procedimiento crea avion...
@s-13-p-crea_avion.sql

prompt Carga inicial...
@s-09-carga-inicial.sql

prompt Realizando consultas...
@s-10-consultas.sql

prompt Creando triggers...
@s-11-tr-email-pasajero.sql
@s-12-tr-email-pasajero-prueba.sql
@s-11-tr-pase-abordar.sql
@s-12-tr-pase-abordar-prueba.sql
@s-11-tr-maletas.sql
@s-12-tr-maleta-prueba.sql
@s-11-tr-link-empleado.sql
@s-12-tr-link-empleado-prueba.sql
@s-11-tr-historico.sql
@s-12-tr-historico-prueba.sql

prompt procedimiento exporta_empleados...
@s-13-p-exporta_empleados.sql

prompt Prueba de procedimiento crea avion...
@s-14-p-crea_avion_prueba.sql

prompt Prueba de procedimiento exporta_empleados...
@s-14-p-exporta_empleados_prueba.sql

prompt Creando funciones...
@s-15-fx-bono-desempenio.sql
@s-16-fx-bono-desempenio-prueba.sql
@s-15-fx-desempenio-aeropuerto.sql
@s-16-fx-desempenio-aeropuerto-prueba.sql
@s-15-fx-tiempo-espera.sql
@s-16-fx-tiempo-espera-prueba.sql

prompt Procedimiento carga_fotos_empleado...
@s-17-lob-carga_fotos_empleado.sql

prompt prueba de procedimiento carga_fotos_empleado...
@s-18-lob-carga_fotos_empleado-prueba.sql