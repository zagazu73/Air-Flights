--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo de consultas 

set linesize 120
col AVION_ID        format a20
col MATRICULA       format a20
col MODELO          format a20
col TOTAL_VUELOS    format a20
col SUELDO          format a20
col NOMBRE_EMPLEADO format a20
col AP_PATERNO      format a20
col AP_MATERNO      format a20
col NOMBRE          format a20
col PASAJERO_ID     format a20
col CURP            format a20
col FECHA_NAC       format a20
col EMAIL           format a20
col DESEMPENIO      format a20
col DESCRIPCION     format a20

-- Consulta 1 (intersect y tabla temporal)
prompt Aviones pendientes de insertar de tipo es_carga y es_comercial

select avion_id, matricula, modelo
from avion_tmp
where es_carga = 1

intersect

select avion_id, matricula, modelo
from avion_tmp
where es_comercial = 1;

-- Consulta 2 (agregación, subconsulta, natural join, inner join, having y group by)
prompt Cantidad de vuelos realizados por aviones con capacidad de discapacitados mayor a 50
select avion_id, a.matricula, a.modelo, q1.total_vuelos
from avion a natural join (
  select ac.avion_id, ac.capacidad_discapacitado, count(*) as total_vuelos
  from avion_comercial ac
    join vuelo v on (ac.avion_id = v.avion_id)
  group by ac.avion_id, ac.capacidad_discapacitado
  having capacidad_discapacitado > 50) q1; 
  
-- Consulta 3 (vistas, minus y union)
prompt Nombres de empleados que no se llaman Juan ni Maria.
select nombre_empleado, ap_paterno, ap_materno
from v_empleado

minus
(
  select nombre_empleado, ap_paterno, ap_materno
  from v_empleado
  where lower(nombre_empleado) = 'juan'

  union
  
  select nombre_empleado, ap_paterno, ap_materno 
  from v_empleado
  where lower(nombre_empleado) = 'maria'
);

-- Consulta 4 (sinónimo y left outer join)
prompt Valores de pasajeros (junto con emails)
select p.*, ep.email
from ZN_PASAJERO p
  left outer join ZN_EMAIL_PASAJERO ep on (p.pasajero_id = ep.pasajero_id);

-- Consulta 5 (Consulta de una tabla externa)
prompt mostrando los datos de puesto_ext
select * from puesto_ext;
