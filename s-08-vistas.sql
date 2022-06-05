--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 03/06/2022  
--@Descripción: Creacion de vistas
connect zn_proy_admin/axzu

create or replace view v_empleado( --Delicados: Sueldo
  id,nombre_empleado,ap_paterno,ap_materno,foto,puesto
) as select e.empleado_id,e.nombre,e.ap_paterno,e.ap_materno,e.foto,p.nombre
  from empleado e,puesto p
  where e.puesto_id = p.puesto_id;
  
create or replace view v_vuelos_aeropuerto( --Ocultar funciones de agregacion
  id,aeropuerto,vuelos_realizados
) as select a.aeropuerto_id,a.nombre,count(*)
  from aeropuerto a,vuelo v
  where a.aeropuerto_id = v.aeropuerto_salida
  group by a.aeropuerto_id,a.nombre;
  
create or replace view v_desempenio_emp( --Consulta de mas de 2 tablas
  id,nombre_empleado,ap_paterno,ap_materno,puesto,vuelo_realizado,desempenio
) as select e.empleado_id,e.nombre,e.ap_paterno,e.ap_materno,p.nombre,ev.vuelo_id,ev.desempenio
  from puesto p,empleado e, empleado_vuelo ev
  where p.puesto_id = e.puesto_id and
        e.empleado_id = ev.empleado_id;
        
connect sys/system as sysdba
Prompt otorgando permisos a zn_proy_invitado para leer vistas de zn_proy_admin
grant select on zn_proy_admin.v_empleado to zn_proy_invitado;
grant select on zn_proy_admin.v_vuelos_aeropuerto to zn_proy_invitado;
grant select on zn_proy_admin.v_desempenio_emp to zn_proy_invitado;

connect zn_proy_invitado/axzu
create or replace synonym v_empleado for zn_proy_admin.v_empleado;
create or replace synonym v_vuelos_aeropuerto for zn_proy_admin.v_vuelos_aeropuerto;
create or replace synonym v_desempenio_emp for zn_proy_admin.v_desempenio_emp;