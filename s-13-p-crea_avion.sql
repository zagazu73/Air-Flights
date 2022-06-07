--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Prueba de procedimiento p_crea_avion

connect zn_proy_admin/axzu

create or replace procedure p_crea_avion (
  p_indice_tmp in number default 0
) is

  v_existe number := 0;
  v_error varchar2(200);
  
  v_avion_id avion_tmp.avion_id%type;
  v_matricula avion_tmp.matricula%type;
  v_modelo avion_tmp.modelo%type;
  v_especificaciones avion_tmp.especificaciones %type;
  v_es_carga avion_tmp.es_carga%type;
  v_es_comercial avion_tmp.es_comercial%type;
  v_capacidad_ordinario avion_tmp.capacidad_ordinario%type;
  v_capacidad_vip avion_tmp.capacidad_vip%type;
  v_capacidad_discapacitado avion_tmp.capacidad_discapacitado%type;
  v_bodega_profundidad avion_tmp.bodega_profundidad%type;
  v_bodega_ancho avion_tmp.bodega_ancho%type;
  v_bodega_alto avion_tmp.bodega_alto%type;
  v_num_bodegas avion_tmp.num_bodegas%type;
  v_capacidad avion_tmp.capacidad%type;
  v_aeropuerto_id avion_tmp.aeropuerto_id%type;
  
  cursor cur_avion is
    select avion_id, matricula, modelo, especificaciones, es_comercial, es_carga, capacidad_ordinario, 
           capacidad_discapacitado, capacidad_vip, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas,
           capacidad, aeropuerto_id
    from avion_tmp;


begin

  for r in cur_avion loop
    
    -- Avanza hasta donde nos quedamos
    if p_indice_tmp != 0 and (p_indice_tmp != r.avion_id) then
      continue;
    end if;
    
    -- Avanza 1 más
    if p_indice_tmp != 0 and (p_indice_tmp = r.avion_id) then
      continue;
    end if;
    
    
    v_avion_id := r.avion_id;
    v_matricula := r.matricula;
    v_modelo := r.modelo;
    v_especificaciones := r.especificaciones;
    v_es_carga := r.es_carga;
    v_es_comercial := r.es_comercial;
    v_capacidad_ordinario := r.capacidad_ordinario;
    v_capacidad_vip := r.capacidad_vip;
    v_capacidad_discapacitado := r.capacidad_discapacitado;
    v_bodega_profundidad := r.bodega_profundidad;
    v_bodega_ancho := r.bodega_ancho;
    v_bodega_alto := r.bodega_alto;
    v_num_bodegas := r.num_bodegas;
    v_capacidad := r.capacidad;
    v_aeropuerto_id := r.aeropuerto_id;
  
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
  
  commit;
    
  exception
    when others then
      v_error := v_error || sqlerrm;
      insert into avion_tmp_falla(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga, capacidad_ordinario, 
          capacidad_discapacitado, capacidad_vip, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas,
          capacidad, aeropuerto_id,descripcion)
        values(v_avion_id, v_matricula, v_modelo, v_especificaciones, v_es_comercial, v_es_carga, v_capacidad_ordinario, 
          v_capacidad_discapacitado, v_capacidad_vip, v_bodega_profundidad, v_bodega_alto, v_bodega_ancho, v_num_bodegas,
          v_capacidad, v_aeropuerto_id, v_error);
    p_crea_avion(v_avion_id);
    
end;
/
show errors
