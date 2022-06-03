connect sys/system as sysdba
Prompt otorgando permisos a zn_proy_invitado para leer tablas de zn_proy_admin
grant select on zn_proy_admin.link_empleado to zn_proy_invitado;
grant select on zn_proy_admin.empleado to zn_proy_invitado;
grant select on zn_proy_admin.ubicacion_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.empleado_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.puesto to zn_proy_invitado;
grant select on zn_proy_admin.avion to zn_proy_invitado;
grant select on zn_proy_admin.vuelo to zn_proy_invitado;
grant select on zn_proy_admin.paquete to zn_proy_invitado;
grant select on zn_proy_admin.tipo_paquete to zn_proy_invitado;
grant select on zn_proy_admin.status_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.historico_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.avion_comercial to zn_proy_invitado;
grant select on zn_proy_admin.avion_carga to zn_proy_invitado;
grant select on zn_proy_admin.aeropuerto to zn_proy_invitado;
grant select on zn_proy_admin.pasajero_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.pasajero to zn_proy_invitado;
grant select on zn_proy_admin.pase_abordar to zn_proy_invitado;
grant select on zn_proy_admin.email_pasajero to zn_proy_invitado;
grant select on zn_proy_admin.maleta to zn_proy_invitado;

connect zn_proy_invitado/axzu
Prompt creando sinónimos
create or replace synonym link_empleado for zn_proy_admin.link_empleado;
create or replace synonym empleado for zn_proy_admin.empleado;
create or replace synonym ubicacion_vuelo for zn_proy_admin.ubicacion_vuelo;
create or replace synonym empleado_vuelo for zn_proy_admin.empleado_vuelo;
create or replace synonym puesto for zn_proy_admin.puesto;
create or replace synonym avion for zn_proy_admin.avion;
create or replace synonym vuelo for zn_proy_admin.vuelo;
create or replace synonym paquete for zn_proy_admin.paquete;
create or replace synonym tipo_paquete for zn_proy_admin.tipo_paquete;
create or replace synonym status_vuelo for zn_proy_admin.status_vuelo;
create or replace synonym historico_vuelo for zn_proy_admin.historico_vuelo;
create or replace synonym avion_comercial for zn_proy_admin.avion_comercial;
create or replace synonym avion_carga for zn_proy_admin.avion_carga;
create or replace synonym aeropuerto for zn_proy_admin.aeropuerto;
create or replace synonym pasajero_vuelo for zn_proy_admin.pasajero_vuelo;
create or replace synonym pasajero for zn_proy_admin.pasajero;
create or replace synonym pase_abordar for zn_proy_admin.pase_abordar;
create or replace synonym email_pasajero for zn_proy_admin.email_pasajero;
create or replace synonym maleta for zn_proy_admin.maleta;