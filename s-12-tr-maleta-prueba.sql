--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	07/06/2022
--@Descripción:	Escenarios de prueba para trg_maleta

connect zn_proy_admin/axzu
set serveroutput on

declare
  MUCHAS_MALETAS exception;
  pragma exception_init(MUCHAS_MALETAS,-20008);
  
begin
  begin
    dbms_output.put_line(chr(3));
    dbms_output.put_line('================================================================');
    dbms_output.put_line('Escenario 1- Se intenta registrar mas de 10 maletas de un pasajero');
    dbms_output.put_line('================================================================');
    insert into maleta(num_maleta,pase_abordar_id,peso) values(1,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(2,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(3,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(4,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(5,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(6,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(7,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(8,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(9,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(10,1,10);
    insert into maleta(num_maleta,pase_abordar_id,peso) values(11,1,10);

  exception
    when MUCHAS_MALETAS then
      dbms_output.put_line('Se obtuvo el error esperado ========> OK! Escenario 1 correcto');
      return;
  end;
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off