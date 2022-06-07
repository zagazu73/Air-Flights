--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@fecha creación: 06/06/2022  
--@Descripción: Funcion que devuelve el tiempo de espera para el despegue de un vuelo

connect zn_proy_admin/axzu

create or replace function tiempo_espera(
  pase_abordar number
) return varchar2 is

--variables a utilizar
  v_pase_existe number(1,0);
  v_hora_salida date;
  v_hora_actual date;
  v_tiempo_faltante date;
  v_ya_salio varchar2(30) := 'El avion ya ha partido';
  
  begin
    --Se verifica que el pase de abordar ingresado es valido
    select count(*) into v_pase_existe
    from pase_abordar
    where pase_abordar_id = pase_abordar;
    if v_pase_existe = 0 then
      raise_application_error(-20019,'El aeropuerto no esta activo');
      return 'error';
    end if;
    
    --Se revisa que no se ha alcanzado la hora de salida
    select hora_salida into v_hora_salida
    from pase_abordar
    where pase_abordar_id = pase_abordar;
    v_hora_actual := to_date(sysdate,'DD/MM/YYYY HH24:MI:SS');
    if v_hora_actual < v_hora_salida then
      v_tiempo_faltante := to_char(v_hora_salida - v_hora_actual,'SSSSS');
      return v_tiempo_faltante;
    else
      return v_ya_salio;
    end if;
  end;
/
show errors