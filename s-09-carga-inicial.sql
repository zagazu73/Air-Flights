--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo de carga inicial

connect zn_proy_admin/axzu

prompt Carga aeropuerto...
@s-09-carga_aeropuerto.sql

prompt Carga pasajero...
@s-09-carga_pasajero.sql