--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	04/06/2022
--@Descripción:	Trigger para evitar la creación de más de 3 emails y validación de correcta secuencia de emails

connect zn_proy_admin/axzu

create or replace trigger trg_email_pasajero
for insert or update of num_email, pasajero_id, email on email_pasajero
compound trigger

v_cuenta number;
v_pasajero_id number := :new.pasajero_id;
MUCHOS_EMAIL exception;
pragma exception_init(MUCHOS_EMAIL,-20001);

before each row is
begin
  case 
    when inserting then
      select count(*)
      into v_cuenta
      from email_pasajero
      where v_pasajero_id = pasajero_id;
      
      if v_cuenta > 2 then
        raise MUCHOS_EMAIL;
      end if;
      
      if(:new.num_email != v_cuenta + 1) then
        raise_application_error(-20003,'Error: Número de email incorrecto, esperado: ' || v_cuenta + 1);
      end if;
      
    when updating then
      if (:new.pasajero_id != :old.pasajero_id) or (:new.num_email != :old.num_email) then
        raise_application_error(-20004,'Error: No se pueden actualizar los parámetros de la llave primaria.');
      end if;
  end case;
end before each row;

end trg_email_pasajero;
/
show errors