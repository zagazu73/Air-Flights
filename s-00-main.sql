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

prompt Creando tabla externa...
@s-04-tablas-externas.sql

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

prompt Carga inicial...
@s-10-consultas.sql

prompt Creando triggers...
@s-11-tr-email-pasajero.sql
@s-11-tr-maletas.sql
@s-11-tr-link-empleado.sql
@s-11-tr-historico.sql
@s-11-tr-pase-abordar.sql

prompt procedimiento crea avion...
@s-13-p-crea_avion.sql
@s-14-p-crea_avion_prueba.sql

prompt Creando funciones...
@s-15-fx-bono-desempenio.sql
@s-15-fx-desempenio-aeropuerto.sql
@s-15-fx-tiempo-espera.sql

prompt Carga inicial...

--@s-04-respuestas.sql
--@s-05-validador-main.sql
