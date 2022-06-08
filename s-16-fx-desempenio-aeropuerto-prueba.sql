--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion desempenio-aeropuerto
--              La funcion recibe el aeropuerto_id y devuelve su desempeño promedio.
--              Considera el desempeño de los empleados que laboran en dicho aeropuerto
--              tanto de despegues como de aterrizajes. (aeropuertos de llegada y de salida)

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_aeropuerto_id number(10,0);
  v_desempenio number(3,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('==============================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Desempeño de un aeropuerto');
  dbms_output.put_line('==============================================================');
  
  v_aeropuerto_id := 12;
  v_desempenio := desempenio_aeropuerto(20);
  dbms_output.put_line('El desempeño promedio del aeropuerto '||v_aeropuerto_id||
    ' es de '||v_desempenio);
    
  dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');
  
  
end;
/
show errors
--Prompt Haciendo rollback para limpiar tablas
--rollback;
set serveroutput off