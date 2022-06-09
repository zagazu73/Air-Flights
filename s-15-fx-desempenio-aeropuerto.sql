--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 06/06/2022  
--@Descripción: Funcion que devuelve el desempeño promedio de vuelos de un aeropuerto.

connect zn_proy_admin/axzu

create or replace function desempenio_aeropuerto(
  aeropuerto number
) return number is

--variables a utilizar
  v_es_activo number(1,0);
  v_desempenio_promedio number(5,0);
  
  begin
    --Se verifica que el aeropuerto este activo
    select activo into v_es_activo
    from aeropuerto
    where aeropuerto_id = aeropuerto;
    if v_es_activo = 1 then
      select avg(desempenio) into v_desempenio_promedio
      from aeropuerto a, vuelo v, empleado_vuelo ev
      where ev.vuelo_id = v.vuelo_id and
            (v.aeropuerto_salida = aeropuerto or v.aeropuerto_llegada = aeropuerto);
          
      return v_desempenio_promedio;
    else 
      raise_application_error(-20018,'El aeropuerto no esta activo');
    end if;
    
  end;
/
show errors