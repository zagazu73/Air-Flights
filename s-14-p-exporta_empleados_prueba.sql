--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 27/05/2022
--@Descripción: Prueba de procedimiento p_exporta_empleados

connect zn_proy_admin/axzu

set serveroutput on
declare

  cursor cur_puestos is
    select puesto_id 
    from puesto;
  
  v_archivo utl_file.file_type;
  v_puesto_id number := 1;
  v_empleado_id number;
  v_num_registros number;
  v_texto_esperado varchar2(2000);
  v_buffer varchar2(2000);
  v_texto_obtenido varchar2(2000);

begin

  dbms_output.put_line('================================');
  dbms_output.put_line('Prueba 1- Puesto nuevo y un empleado nuevo');
  dbms_output.put_line('================================');
  
  -- Creando nuevo puesto
  for r in cur_puestos loop
    v_puesto_id := v_puesto_id + 1;
  end loop;
  
  insert into puesto(puesto_id, clave, nombre, descripcion, sueldo) 
    values(v_puesto_id, 'clave','nombre','descripcion',20000);
  
  -- Creando nuevo empleado
  v_empleado_id := empleado_seq.nextval;
  
  insert into empleado(empleado_id, nombre, ap_paterno, ap_materno, curp, foto, jefe_id, puesto_id)
    values(v_empleado_id, 'Axel', 'Núñez', 'Quintana', 'NUQL001109HMCXNSA7', empty_blob(), null, v_puesto_id);
  
  v_texto_esperado := 'Nombre,ap_paterno,ap_materno,RFC,CURPAxel,Núñez,Quintana,NUQL001109HMC,NUQL001109HMCXNSA7';
  
  p_exporta_empleados(v_puesto_id, v_num_registros);

  v_archivo := utl_file.fopen('DOCUMENTOS_DIR', 'empleados.csv','r');
  
  utl_file.get_line(v_archivo, v_buffer);
  
  v_texto_obtenido := v_buffer;
  
  utl_file.get_line(v_archivo, v_buffer);
  
  v_texto_obtenido := v_texto_obtenido || v_buffer;
  
  utl_file.fclose(v_archivo);
  
  if(v_texto_obtenido = v_texto_esperado) and (v_num_registros = 1) then
    dbms_output.put_line('Prueba 1 Exitosa');
    dbms_output.put_line('Cadena leida: ' || v_texto_obtenido);
  else
    raise_application_error(-20001,'Error en prueba 1: se cargaron ' || v_num_registros || ' se esperaba 1. '
      || 'Cadena esperada: ' || v_texto_esperado || ', Cadena obtenida: ' || v_texto_obtenido);
  end if;
  
  dbms_output.put_line('Limpiando registros...');
  rollback;
  
  exception
    when others then
      rollback;
end;
/
show errors

set serveroutput off