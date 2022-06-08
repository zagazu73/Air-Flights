--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_historico

connect zn_proy_admin/axzu
set serveroutput on

declare
  
  v_status_vuelo_id number(2,0);
  v_status_vuelo varchar(40);
  v_cont_ant number(1,0);
  v_cont_nuevo number(1,0);
  v_vuelo_id number(10,0);
  
begin
  
  v_status_vuelo_id := status_vuelo_seq.nextval;
  v_status_vuelo := 'PROGRAMADO';
  v_vuelo_id := vuelo_seq.nextval;

  dbms_output.put_line(chr(3));
  dbms_output.put_line('==================================================');
  dbms_output.put_line('Escenario 1- Se inserta un nuevo registro en vuelo');
  dbms_output.put_line('==================================================');
  
  dbms_output.put_line('Verificando el numero de registros en el historico antes de una insercion en vuelo...');
  select count(*) into v_cont_ant from historico_vuelo;
  dbms_output.put_line('# DE REGISTROS DE HISTORICO_VUELO: '||v_cont_ant);
  
  insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values (v_vuelo_id, vuelo_seq.nextval, to_date('2022-10-23 20:08:17','YYYY/MM/DD HH24:MI:SS'), to_date('2022-10-23 17:37:32','YYYY/MM/DD HH24:MI:SS'), '3T1na', to_date('2022-10-23 17:37:32','YYYY/MM/DD HH24:MI:SS'), 19, 6, 15, 1, 'C');

  dbms_output.put_line('Verificando el numero de registros en el historico...');
  select count(*) into v_cont_nuevo from historico_vuelo;
  dbms_output.put_line('# DE REGISTROS ACTUAL DE HISTORICO_VUELO: '||v_cont_nuevo);
  
  if v_cont_nuevo > v_cont_ant then
    dbms_output.put_line('Registro nuevo en el historico detectado ===> OK! Escenario 1 correcto');
  else
    dbms_output.put_line('ERROR! Escenario 1 incorrecto');
  end if;
  
  dbms_output.put_line(chr(3));
  dbms_output.put_line('=========================================================');
  dbms_output.put_line('Escenario 2- Se actualiza el status del registro anterior');
  dbms_output.put_line('=========================================================');

  dbms_output.put_line('Verificando el numero de registros en el historico antes de modificar el status del vuelo '||v_vuelo_id);
  select count(*) into v_cont_ant from historico_vuelo;
  dbms_output.put_line('# DE REGISTROS DE HISTORICO_VUELO: '||v_cont_ant);

  update vuelo
  set status_vuelo_id = 5
  where vuelo_id = v_vuelo_id;
  
  dbms_output.put_line('Verificando el numero de registros en el historico...');
  select count(*) into v_cont_nuevo from historico_vuelo;
  dbms_output.put_line('# DE REGISTROS ACTUAL DE HISTORICO_VUELO: '||v_cont_nuevo);
  
  if v_cont_nuevo > v_cont_ant then
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