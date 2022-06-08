--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_pase_abordar

connect zn_proy_admin/axzu
set serveroutput on

declare
  
  v_pasajero_vuelo_id number(10,0);
  v_num_asiento number(3,0);
  v_tipo_asiento varchar2(3);
  v_atenciones varchar2(20);
  v_tomado number(1,0);
  v_pasajero_id number(10,0);
  v_vuelo_id number(10,0);
  v_cont_ant number(1,0);
  v_cont_nuevo number(1,0);
  
begin
  
  v_pasajero_vuelo_id := pasajero_vuelo_seq.nextval;
  v_num_asiento := 23;
  v_tipo_asiento := 'VIP';
  v_atenciones := 'NINGUNA';
  v_tomado := 1;
  v_pasajero_id := 7;
  v_vuelo_id := 3;
  

  dbms_output.put_line(chr(5));
  dbms_output.put_line('======================================================');
  dbms_output.put_line('Escenario 1- Se registra un nuevo pasajero en un vuelo');
  dbms_output.put_line('======================================================');
  
  dbms_output.put_line('Verificando el numero de registros en pase_abordar antes de una insercion en pasajero_vuelo...');
  select count(*) into v_cont_ant from pase_abordar;
  dbms_output.put_line('# DE REGISTROS DE PASE_ABORDAR: '||v_cont_ant);
  
  insert into pasajero_vuelo(pasajero_vuelo_id,num_asiento,tipo_asiento,atenciones,tomado,pasajero_id,vuelo_id)
    values(v_pasajero_vuelo_id,v_num_asiento,v_tipo_asiento,v_atenciones,v_tomado,v_pasajero_id,v_vuelo_id);

  dbms_output.put_line('Verificando el numero de registros en pase_abordar antes de una insercion en pasajero_vuelo...');
  select count(*) into v_cont_nuevo from pase_abordar;
  dbms_output.put_line('# DE REGISTROS ACTUAL DE PASE_ABORDAR: '||v_cont_nuevo);

  if v_cont_nuevo > v_cont_ant then
    dbms_output.put_line('Pase de abordar generado ===> OK! Escenario 1 correcto');
  else
    dbms_output.put_line('ERROR! Escenario 1 incorrecto');
  end if;

end;
/
show errors
--Prompt Haciendo rollback para limpiar tablas
--rollback;
commit;
set serveroutput off