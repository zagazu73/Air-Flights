--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion tiempo-espera
--              La funcion recibe el pase_abordar_id
--              Devuelve el tiempo que falta para el despegue del vuelo
--              de un pasajero

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_tiempo_espera varchar2(50);
  v_vuelo number(10,0);
  v_pase_abordar_id number(10,0);
  v_pasajero_id number(10,0);
  v_pasajero_vuelo_id number(10,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('=============================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Tiempo de espera restante');
  dbms_output.put_line('=============================================================');
  
  dbms_output.put_line('Registros para la prueba');
  dbms_output.put_line('Ingresamos un nuevo pasajero');

  v_pasajero_id := pasajero_seq.nextval;
  insert into pasajero (pasajero_id, nombre, ap_paterno, ap_materno, curp) 
    values (v_pasajero_id, 'Zuriel', 'Zarate', 'Garcia', 'ZAGZ990828HMCRRR05');
  
  dbms_output.put_line('Ingresamos un nuevo vuelo');
  v_vuelo := vuelo_seq.nextval;
  insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values (v_vuelo, v_vuelo, to_date('2022-06-11 05:14:11', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-11 02:06:15', 'yyyy-mm-dd hh24:mi:ss'), 'aj34k', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 7, 1, 7, 1, 'P');
  
  dbms_output.put_line('Inscribimos al pasajero en el vuelo (esto genera un pase de abordar)');
  v_pasajero_vuelo_id := pasajero_vuelo_seq.nextval;
  insert into pasajero_vuelo(pasajero_vuelo_id,num_asiento,tipo_asiento,atenciones,tomado,pasajero_id,vuelo_id)
    values(v_pasajero_vuelo_id,30,'VIP','SIN ATENCIONES',1,v_pasajero_id,v_vuelo);
  
  dbms_output.put_line('Ahora podemos obtener el tiempo con la funcion');

  v_pase_abordar_id := pase_abordar_seq.currval;
  v_tiempo_espera := tiempo_espera(v_pase_abordar_id);

  dbms_output.put_line('Tiempo restante para el despegue del vuelo '||v_vuelo||': '||v_tiempo_espera||' horas');
  dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');

  
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off