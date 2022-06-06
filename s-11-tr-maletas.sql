--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	04/06/2022
--@Descripción:	Trigger para evitar la creación de más de 10 maletas por pasajero

connect zn_proy_admin/axzu

create or replace trigger trg_maleta
for insert or update of num_maleta, pase_abordar_id, peso on maleta
compound trigger

v_cuenta number;
v_pase_abordar_id number := :new.pase_abordar_id;

before statement is

begin

  select count(*)
  into v_cuenta
  from maleta
  where pase_abordar_id = v_pase_abordar_id;
  case 
    when inserting then
    if v_cuenta > 9 then
      raise_application_error(-20008,'Error: Un pasajero no puede registrar más de 10 maletas');
    end if;
  end case;
end before statement;


before each row is

begin
  case 
    when inserting then
      if(:new.num_maleta != v_cuenta + 1) then
        raise_application_error(-20009,'Error: Número de maleta incorrecto, esperado: ' || v_cuenta + 1);
      end if;
      
    when updating then
      if (:new.pase_abordar_id != :old.pase_abordar_id) or (:new.num_maleta != :old.num_maleta) then
        raise_application_error(-20010,'Error: No se pueden actualizar los parámetros de la llave primaria.');
      end if;
  end case;
end before each row;

end trg_maleta;
/
show errors