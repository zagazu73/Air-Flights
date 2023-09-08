--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@fecha creación: 06/06/2022  
--@Descripción: Funcion que devuelve el tiempo de espera para el despegue de un vuelo

connect zn_proy_admin/axzu

create or replace function tiempo_espera(
  p_pase_abordar number
) return varchar2 is

--variables a utilizar
  v_pase_existe number(1,0);
  v_hora_salida date;
  v_hora_actual date;
  v_tiempo_faltante varchar(50);
  
  begin
    --Se verifica que el pase de abordar ingresado es valido
    select count(*) 
    into v_pase_existe
    from pase_abordar
    where pase_abordar_id = p_pase_abordar;
    
    if v_pase_existe = 0 then
      raise_application_error(-20019,'El pase de abordar ingresado no existe');
      return 'error';
    end if;
    
    --Se revisa que no se ha alcanzado la hora de salida
    select hora_salida 
    into v_hora_salida
    from pase_abordar
    where pase_abordar_id = p_pase_abordar;
    
    v_hora_actual := sysdate;
    
    if v_hora_actual < v_hora_salida then
      select (
        cast(trunc(v_hora_salida-v_hora_actual) as varchar2(10)) || ' dias ' ||
        cast(trunc(mod((v_hora_salida-v_hora_actual)*24,24)) as varchar2(10)) || ' horas ' ||
        cast(trunc(mod((v_hora_salida-v_hora_actual)*(60*24),60)) as varchar2(10))||' minutos y '||
        cast(trunc(mod((v_hora_salida-v_hora_actual)*(60*60*24),60)) as varchar2(10))||' segundos.'
      )
      into v_tiempo_faltante
      from dual;
      return v_tiempo_faltante;
    else
      return 'El avion ya ha partido';
    end if;
  end;
/
show errors