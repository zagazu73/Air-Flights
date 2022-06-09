--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion bono-desempenio

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_vuelo number(10,0);
  v_empleado_id number(10,0);
  v_bono number(4,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('======================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Bono por desempeño');
  dbms_output.put_line('======================================================');
  
  dbms_output.put_line('Creamos un empleado');
  v_empleado_id := empleado_seq.nextval;
  insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,curp,foto,jefe_id,puesto_id)
    values(v_empleado_id,'Zuriel','Zarate','Garcia','ZAGZ990828HMCRRR05',empty_blob(),null,1);
  
  dbms_output.put_line('Creamos un nuevo vuelo');
  v_vuelo := vuelo_seq.nextval;
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo, v_vuelo, to_date('2022-06-11 05:14:11', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-11 02:06:15', 'yyyy-mm-dd hh24:mi:ss'), 'aj34k', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 7, 1, 7, 1, 'P');
  
  dbms_output.put_line('Especificamos el desempeño que tuvo el empleado creado en dicho vuelo');
  insert into empleado_vuelo(empleado_vuelo_id,vuelo_id,empleado_id,rol,desempenio) 
    values(empleado_vuelo_seq.nextval,v_vuelo,v_empleado_id,'piloto',85);
  
  --El bono es equivalente al 8.5 % de su sueldo mensual.
  --Su sueldo es de 40,000$.
  v_bono := bono_vuelo(v_vuelo,v_empleado_id);
  dbms_output.put_line('El bono del empleado '||v_empleado_id||
    ' en el vuelo '||v_vuelo||' es de: '||v_bono);
    
  dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');

end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off