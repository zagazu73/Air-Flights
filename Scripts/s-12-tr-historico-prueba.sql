--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_historico

connect zn_proy_admin/axzu
set serveroutput on

declare
  
  v_vuelo_id number(10,0);
  v_aeropuerto1_id number(10,0);
  v_aeropuerto2_id number(10,0);
  v_avion_id number(10,0);
  
  v_status_vuelo1_id number(2,0);
  v_status_vuelo1 varchar2(40);
  
  v_status_vuelo2_id number(2,0);
  v_status_vuelo2 varchar2(40);
  
  v_cont number;
  
begin


  dbms_output.put_line(chr(3));
  dbms_output.put_line('==================================================');
  dbms_output.put_line('Escenario 1- Se inserta un nuevo registro en vuelo');
  dbms_output.put_line('==================================================');
  
  v_status_vuelo1_id := status_vuelo_seq.nextval;
  v_status_vuelo1 := 'PRUEBA';

  
  v_vuelo_id := vuelo_seq.nextval;
  v_aeropuerto1_id := aeropuerto_seq.nextval;
  v_aeropuerto2_id := aeropuerto_seq.nextval;
  v_avion_id := avion_seq.nextval;
  
  insert into avion(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga)
    values(v_avion_id, 'A', 'B', empty_blob(), 1, 0);
  
  insert into aeropuerto(aeropuerto_id, nombre, clave, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'A Airport', 'B', 50, 50, 1);
    
  insert into aeropuerto(aeropuerto_id, nombre, clave, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'C Airport', 'D', 60, 60, 1);
    
  insert into status_vuelo(status_vuelo_id, status_vuelo)
    values(v_status_vuelo1_id, v_status_vuelo1);
  
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status
    , avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2023-06-24 07:38:48', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-24 07:38:48', 'yyyy-mm-dd hh24:mi:ss'), null, sysdate
    ,  v_avion_id, v_aeropuerto1_id, v_aeropuerto2_id, v_status_vuelo1_id, 'P');
    
  dbms_output.put_line('Verificando la inserción de registro en histórico...');
  
  select count(*) 
  into v_cont
  from historico_vuelo
  where vuelo_id = v_vuelo_id;
  
  if v_cont = 1 then
    dbms_output.put_line('Registro nuevo en el historico detectado ===> OK! Escenario 1 correcto');
  else
    dbms_output.put_line('ERROR! Escenario 1 incorrecto');
  end if;
  
  dbms_output.put_line(chr(3));
  dbms_output.put_line('=========================================================');
  dbms_output.put_line('Escenario 2- Se actualiza el status del registro anterior');
  dbms_output.put_line('=========================================================');
  
  v_status_vuelo2_id := status_vuelo_seq.nextval;
  v_status_vuelo2 := 'PRUEBA2';
  
  insert into status_vuelo(status_vuelo_id, status_vuelo)
    values(v_status_vuelo2_id, v_status_vuelo2);
    
  update vuelo
  set status_vuelo_id = v_status_vuelo2_id
  where vuelo_id = v_vuelo_id;
  
  dbms_output.put_line('Verificando la inserción de registro en histórico...');
  
  select count(*) 
  into v_cont
  from historico_vuelo
  where vuelo_id = v_vuelo_id;
  
  if v_cont = 2 then
    dbms_output.put_line('Registro nuevo en el historico detectado ===> OK! Escenario 2 correcto');
  else
    dbms_output.put_line('ERROR! Escenario 2 incorrecto');
  end if;

end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off