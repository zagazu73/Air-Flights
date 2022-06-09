--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_link_empleado

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_empleado_id number;
  MUCHOS_LINK exception;
  pragma exception_init(MUCHOS_LINK,-20005);
  
begin
  begin
    dbms_output.put_line(chr(3));
    dbms_output.put_line('================================================================');
    dbms_output.put_line('Escenario 1- Se intenta registrar mas de 5 links de un empleado');
    dbms_output.put_line('================================================================');
    
    v_empleado_id := empleado_seq.nextval;
    insert into empleado(empleado_id, nombre, ap_paterno, ap_materno, curp, foto, jefe_id, puesto_id)
      values(v_empleado_id, 'A', 'B', 'C', '123456789012345678', empty_blob(), null, 1);
    
    insert into link_empleado(num_link,empleado_id,link) values(1,v_empleado_id,'https://link1.com');
    insert into link_empleado(num_link,empleado_id,link) values(2,v_empleado_id,'https://link2.com');
    insert into link_empleado(num_link,empleado_id,link) values(3,v_empleado_id,'https://link3.com');
    insert into link_empleado(num_link,empleado_id,link) values(4,v_empleado_id,'https://link4.com');
    insert into link_empleado(num_link,empleado_id,link) values(5,v_empleado_id,'https://link5.com');
    insert into link_empleado(num_link,empleado_id,link) values(6,v_empleado_id,'https://link6.com');

  exception
    when MUCHOS_LINK then
      dbms_output.put_line('Se obtuvo el error esperado ========> OK! Escenario 1 correcto');
      return;
  end;
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off