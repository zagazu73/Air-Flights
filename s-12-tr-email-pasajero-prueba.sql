--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para el trigger trg_email_pasajero

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_insert varchar2(100);
  v_correo varchar2(100);
  MUCHOS_EMAIL exception;
  pragma exception_init(MUCHOS_EMAIL,-20001);
  
begin
  begin
    dbms_output.put_line(chr(3));
    dbms_output.put_line('=======================================================');
    dbms_output.put_line('Escenario 1- Se registran mas de 3 emails de un pasajero');
    dbms_output.put_line('=======================================================');
    insert into email_pasajero(num_email,pasajero_id,email) values(1,7,'zagazu@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(2,7,'churris@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(3,7,'zuri@gmail.com');
    insert into email_pasajero(num_email,pasajero_id,email) values(4,7,'zuris@gmail.com');
  exception
    when MUCHOS_EMAIL then
      dbms_output.put_line('Se obtuvo el error esperado ========> OK! Escenario 1 correcto');
      return;
  end;
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off