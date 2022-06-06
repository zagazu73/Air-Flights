--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 27/05/2022
--@Descripción: Bloque anonimo que crea aviones

connect zn_proy_admin/axzu

set serveroutput on
declare
  v_avion_id_1 avion_tmp.avion_id%type;
  v_avion_id_2 avion_tmp.avion_id%type;
  v_aeropuerto_id aeropuerto.aeropuerto_id%type;
  v_avion_1 number := 0;
  v_avion_2 number := 0;
  v_comercial number := 0;
  v_carga number := 0;
  v_error varchar2(200);

begin

  dbms_output.put_line('================================');
  dbms_output.put_line('Escenario 1- Creando un avion de carga y comercial');
  dbms_output.put_line('================================');
  
  v_avion_id_1 := avion_seq.nextval;
  v_aeropuerto_id := aeropuerto_seq.nextval;
  
  insert into aeropuerto(aeropuerto_id, nombre, clave, latitud, longitud, activo)
        values(v_aeropuerto_id, 'Mexico Airport', '123456789', 50, 50, 1);
        
  insert into avion_tmp(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga, capacidad_ordinario, 
          capacidad_discapacitado, capacidad_vip, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas,
          capacidad, aeropuerto_id)
        values(v_avion_id_1, '123456789', '123456789', empty_blob(), 1, 1, 100, 100, 100, 20, 20, 20, 20, 5, v_aeropuerto_id);
  
  dbms_output.put_line('================================');
  dbms_output.put_line('Escenario 2- Creando un avion sin tipo');
  dbms_output.put_line('================================');
  
  v_avion_id_2 := avion_seq.nextval;
  insert into avion_tmp(avion_id, matricula, modelo, especificaciones, es_comercial, es_carga)
        values(v_avion_id_2, '987654321', '987654321', empty_blob(), 0, 0);
  
  dbms_output.put_line('================================');
  dbms_output.put_line('Ejecutando procedimiento...');
  dbms_output.put_line('================================');
  
  p_crea_avion();

  select count(*)
  into v_avion_1
  from avion
  where avion_id = v_avion_id_1;
  
  select count(*)
  into v_carga
  from avion
  where avion_id = v_avion_id_1;
  
  select count(*)
  into v_comercial
  from avion
  where avion_id = v_avion_id_1;
  
  if v_avion_1 = 1 and v_carga = 1 and v_comercial = 1 then

    dbms_output.put_line('Avión creado con éxito: '||v_avion_id_1);
    dbms_output.put_line('OK! Escenario 1 exitoso');
  else
    raise_application_error(-20001,'Error en escenario 1: No se encontró el registro esperado en avión, avión comercial o avión carga');
  end if;
  
  select count(*)
  into v_avion_2
  from avion
  where avion_id = v_avion_id_2;
  
  
  select descripcion
  into v_error
  from avion_tmp_falla
  where avion_id = v_avion_id_2;
  
  if v_avion_2 = 0 then

    dbms_output.put_line('Avión no encontrado: '||v_error);
    dbms_output.put_line('OK! Escenario 2 exitoso');
  else
    raise_application_error(-20001,'Error en escenario 2: Se encontró un registro en avión');
  end if;
  
  delete from avion_comercial where avion_id = v_avion_id_1;
  delete from avion_comercial where avion_id = v_avion_id_2;
  
  delete from avion_carga where avion_id = v_avion_id_1;
  delete from avion_carga where avion_id = v_avion_id_2;
  
  delete from avion where avion_id = v_avion_id_1;
  delete from avion where avion_id = v_avion_id_2;
  
  delete from avion_tmp where avion_id = v_avion_id_1;
  delete from avion_tmp where avion_id = v_avion_id_2;
  
  delete from avion_tmp_falla where avion_id = v_avion_id_1;
  delete from avion_tmp_falla where avion_id = v_avion_id_2;

  exception
    -- Cuando el select no encuentra registros, lanza un error en el escenario 2
    when NO_DATA_FOUND then
      raise_application_error(-20002,'Error en escenario 2: No se encontró el registro en la tabla temporal de fallas');
end;
/
show errors

Prompt Eliminando registros de prueba de las tablas...

set serveroutput off
