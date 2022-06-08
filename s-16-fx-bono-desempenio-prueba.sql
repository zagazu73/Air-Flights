--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion bono-desempenio

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_vuelo_id number(10,0);
  v_empleado_id number(10,0);
  v_bono number(4,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('======================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Bono por desempeño');
  dbms_output.put_line('======================================================');
  
  --Se sabe que este empleado en este vuelo tuvo un desempeño de 72 puntos
  --El bono es equivalente al 7.2 % de su sueldo mensual.
  --Es piloto, por lo que gana 60,000$ al mes.
  v_vuelo_id := 2;
  v_empleado_id := 14;
  v_bono := bono_vuelo(2,14);
  dbms_output.put_line('El bono del empleado '||v_empleado_id||
    ' en el vuelo '||v_vuelo_id||' es de: '||v_bono);
    
  dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');
  
  
end;
/
show errors
--Prompt Haciendo rollback para limpiar tablas
--rollback;
set serveroutput off