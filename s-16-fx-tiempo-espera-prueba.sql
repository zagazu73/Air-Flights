--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion tiempo-espera
--              La funcion recibe el pase_abordar_id
--              Devuelve el tiempo que falta para el despegue de un vuelo

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_tiempo_espera varchar2(50);
  v_vuelo number(10,0);
  v_pase_abordar_id number(10,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('=============================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Tiempo de espera restante');
  dbms_output.put_line('=============================================================');
  
  v_pase_abordar_id := 1;
  v_tiempo_espera := tiempo_espera(v_pase_abordar_id);
  
  select pv.vuelo_id into v_vuelo
  from pasajero_vuelo pv, pase_abordar pa
  where pv.pasajero_vuelo_id = pa.pasajero_vuelo_id;

  dbms_output.put_line('Tiempo restante para el despegue del vuelo '||v_vuelo||': '||v_tiempo_espera||' horas');
  dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');

  
end;
/
show errors
--Prompt Haciendo rollback para limpiar tablas
--rollback;
set serveroutput off