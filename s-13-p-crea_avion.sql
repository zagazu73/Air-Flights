--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Prueba de procedimiento p_crea_avion

connect zn_proy_admin/axzu

create or replace procedure p_crea_avion is

  v_existe number := 0;
  v_antes number := 0;
  v_despues number := 0;
  v_error varchar2(200);
  cursor cur_avion is
    select avion_id, matricula, modelo, especificaciones, es_comercial, es_carga, capacidad_ordinario, 
           capacidad_discapacitado, capacidad_vip, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas,
           capacidad, aeropuerto_id
    from avion_tmp;


begin

  for r in cur_avion loop
     
     v_error := 'Error(es):';
    
          
    select count(*) 
    into v_existe
    from avion
    where avion_id = r.avion_id;
    
    -- Si el registro ya existe
    if v_existe = 1 then
      v_error := v_error || (' El avión con id: ' || r.avion_id || ' ya se encuentra registrado.');
   
    
    elsif r.es_carga = 1 or r.es_comercial = 1 then
      -- Si no existe y es carga   
      if r.es_carga = 1  and (r.bodega_profundidad is not null and r.bodega_alto is not null and r.bodega_ancho is not null and r.num_bodegas is not null
                                                 and r.capacidad is not null and r.aeropuerto_id is not null) then
                                                 
        select count(*)
        into v_existe
        from aeropuerto
        where aeropuerto_id = r.aeropuerto_id;
      
        -- Si no existe el aeropuerto
        if v_existe = 0 then
          v_error := v_error || (' El aeropuerto con id: ' || r.aeropuerto_id || ' no existe.');
           
        else
        
          select activo
          into v_existe
          from aeropuerto where aeropuerto_id = r.aeropuerto_id;
        
          -- Si no se tiene convenio con el aeropuerto
          if v_existe = 0 then
          v_error := v_error || (' El aeropuerto con id: ' || r.aeropuerto_id || ' no tiene convenio.');
          else
            insert into avion(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga)
              values(r.avion_id, r.matricula, r.modelo, r.especificaciones, r.es_comercial, r.es_carga);
            insert into avion_carga(avion_id, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas, capacidad, aeropuerto_id)
              values(r.avion_id, r.bodega_profundidad, r.bodega_alto, r.bodega_ancho, r.num_bodegas, r.capacidad, r.aeropuerto_id);
          end if;
        
        end if;

      end if;
      
      -- Si no existe y es comercial      
      if r.es_comercial = 1 and (r.capacidad_ordinario is not null and r.capacidad_discapacitado is not null and r.capacidad_vip is not null) then
      
        select count(*) 
        into v_existe
        from avion
        where avion_id = r.avion_id;
        
        -- El avion no es de carga, se necesita crear el registro en la tabla avión
        if v_existe = 0 then 
          insert into avion(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga)
            values(r.avion_id, r.matricula, r.modelo, r.especificaciones, r.es_comercial, r.es_carga);
        end if;
        
        insert into avion_comercial(avion_id, capacidad_ordinario, capacidad_discapacitado, capacidad_vip)
          values(r.avion_id, r.capacidad_ordinario, r.capacidad_discapacitado, r.capacidad_vip);
          
      end if;
    
    else
      v_error := v_error || (' El avión con id: ' || r.avion_id || ' no tiene un tipo válido.');
    end if;
    
    select count(*) 
    into v_existe
    from avion
    where avion_id = r.avion_id;
     
    -- Si no se ingresó el valor
    if v_existe = 0 or v_error != 'Error(es):' then
      if v_error = 'Error(es):' then
        v_error := v_error || ' No se realizó la inserción por valores inválidos.';
      end if;
      insert into avion_tmp_falla(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga, capacidad_ordinario, 
          capacidad_discapacitado, capacidad_vip, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas,
          capacidad, aeropuerto_id,descripcion)
        values(r.avion_id, r.matricula, r.modelo, r.especificaciones, r.es_comercial, r.es_carga, r.capacidad_ordinario, 
          r.capacidad_discapacitado, r.capacidad_vip, r.bodega_profundidad, r.bodega_alto, r.bodega_ancho, r.num_bodegas,
          r.capacidad, r.aeropuerto_id, v_error);
    end if;
    
  end loop;

end;
/
show errors
