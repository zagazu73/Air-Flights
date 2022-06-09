--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_pase_abordar

connect zn_proy_admin/axzu
set serveroutput on

declare
  
  v_pasajero_vuelo_id number(10,0);
  v_pasajero_id number(10,0);
  v_vuelo_id number(10,0);
  v_aeropuerto1_id number(10,0);
  v_aeropuerto2_id number(10,0);
  v_avion_id number(10,0);
  
  v_cont number(1,0);
  
begin
  
  v_pasajero_vuelo_id := pasajero_vuelo_seq.nextval;
  v_pasajero_id := pasajero_seq.nextval;
  v_vuelo_id := vuelo_seq.nextval;
  v_aeropuerto1_id := aeropuerto_seq.nextval;
  v_aeropuerto2_id := aeropuerto_seq.nextval;
  v_avion_id := avion_seq.nextval;

  dbms_output.put_line(chr(5));
  dbms_output.put_line('======================================================');
  dbms_output.put_line('Escenario 1- Se registra un nuevo pasajero en un vuelo');
  dbms_output.put_line('======================================================');
  
  insert into pasajero(pasajero_id, nombre, ap_paterno, ap_materno, curp)
    values(v_pasajero_id, 'A', 'B', 'C', 'NUQL001109HMCXNSA7');
  
  insert into avion(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga)
    values(v_avion_id, 'A', 'B', empty_blob(), 1, 0);
  
  insert into aeropuerto(aeropuerto_id, nombre, clave, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'A Airport', 'B', 50, 50, 1);
    
  insert into aeropuerto(aeropuerto_id, nombre, clave, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'C Airport', 'D', 60, 60, 1);
  
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status
    , avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2023-06-24 07:38:48', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-24 07:38:48', 'yyyy-mm-dd hh24:mi:ss'), null, sysdate
    ,  v_avion_id, v_aeropuerto1_id, v_aeropuerto2_id, 1, 'P');
  
  insert into pasajero_vuelo(pasajero_vuelo_id,num_asiento,tipo_asiento,atenciones,tomado,pasajero_id,vuelo_id)
    values(v_pasajero_vuelo_id, 1, 'VIP', 'NINGUNA', 0, v_pasajero_id, v_vuelo_id);
  
  dbms_output.put_line('Contando pases de abordar para el registro insertado...');
  select count(*) 
  into v_cont
  from pase_abordar
  where pasajero_vuelo_id = v_pasajero_vuelo_id;
  

  if v_cont = 1 then
    dbms_output.put_line('Pase de abordar generado ===> OK! Escenario 1 correcto');
  else
    dbms_output.put_line('ERROR! Escenario 1 incorrecto');
  end if;

end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off