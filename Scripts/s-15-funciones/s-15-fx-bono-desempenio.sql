--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 06/06/2022  
--@Descripción: Funcion que devuelve el bono que obtuvo un empleado por su desempeño en un vuelo

connect zn_proy_admin/axzu

create or replace function bono_vuelo(
  p_vuelo number,
  p_empleado number
) return number is

--variables a utilizar
  v_sueldo puesto.sueldo%type;
  v_desempenio empleado_vuelo.desempenio%type;
  v_rendimiento number(6,3);
  v_bono number(4,0);
  v_cont number(1,0);
  v_empleado_existe number(1,0);
  v_vuelo_existe number(1,0);
  
  begin
    --Se verifica que el empleado seleccionado existe
    select count(*) 
    into v_empleado_existe
    from empleado
    where empleado_id = p_empleado;
    
    if v_empleado_existe = 0 then
      raise_application_error(-20015,'El empleado no existe');
      return 0;
    end if;
    
    -- Se verifica que el vuelo seleccionado existe
    select count(*) 
    into v_vuelo_existe
    from vuelo
    where vuelo_id = p_vuelo;
    
    if v_vuelo_existe = 0 then
      raise_application_error(-20016,'El vuelo no existe');
      return 0;
    end if;
  
    --Se verifica que el empleado empleado_id participo en el vuelo vuelo_id
    select count(*) into v_cont
    from  empleado e, empleado_vuelo ev, vuelo v
    where e.empleado_id = ev.empleado_id and
          ev.vuelo_id = v.vuelo_id and
          ev.vuelo_id = p_vuelo and
          ev.empleado_id = p_empleado;
    
    if v_cont = 1 then
      select p.sueldo, ev.desempenio 
      into v_sueldo, v_desempenio
      from puesto p, empleado e, empleado_vuelo ev, vuelo v
      where p.puesto_id = e.puesto_id and
            e.empleado_id = ev.empleado_id and
            ev.vuelo_id = v.vuelo_id and
            ev.vuelo_id = p_vuelo and
            ev.empleado_id = p_empleado;
      
      v_rendimiento := v_desempenio/1000; -- Rendimiento
      v_bono := v_sueldo*v_rendimiento; -- Bono total sobre el sueldo
      return v_bono;
      
    else
      raise_application_error(-20017,'El empleado '|| p_empleado||' no participo en el vuelo '|| p_vuelo||'');
      return 0;
    end if;
  end;
/
show errors