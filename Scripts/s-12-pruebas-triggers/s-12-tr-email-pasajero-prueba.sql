--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_email_pasajero

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_pasajero_id number;
  MUCHOS_EMAIL exception;
  pragma exception_init(MUCHOS_EMAIL,-20001);
  
begin
  begin
    dbms_output.put_line(chr(3));
    dbms_output.put_line('=======================================================');
    dbms_output.put_line('Escenario 1- Se registran mas de 3 emails de un pasajero');
    dbms_output.put_line('=======================================================');
    
    v_pasajero_id := pasajero_seq.nextval;
    insert into pasajero(pasajero_id, nombre, ap_paterno, ap_materno, curp)
      values(v_pasajero_id, 'Axel', 'Núñez', 'Quintana', 'NUQL001109HMCXNSA7');
    
    insert into email_pasajero(num_email,pasajero_id,email) values(1,v_pasajero_id,'zagazu@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(2,v_pasajero_id,'churris@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(3,v_pasajero_id,'zuri@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(4,v_pasajero_id,'zuris@gmail.com');
    
  exception
    when MUCHOS_EMAIL then
      dbms_output.put_line('Se obtuvo el error esperado ========> OK! Escenario 1 correcto');
  end;
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off