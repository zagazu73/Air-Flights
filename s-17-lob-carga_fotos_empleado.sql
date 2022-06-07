--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	27/05/2022
--@Descripción:	Ejercicio 2, procedimiento para fotos de práctica 13

prompt Creando objeto directorio
connect sys/system as sysdba
create or replace directory fotos_dir as '/tmp/Empleados';

grant read on directory fotos_dir to zn_proy_admin;

connect zn_proy_admin/axzu

set serveroutput on

create or replace procedure carga_fotos_empleado(
  p_empleado_id in number, p_num_imagenes in number
) is

  cursor cur_fotos is
    select empleado_id
    from empleado
    where empleado_id >= p_empleado_id and
          empleado_id < p_empleado_id + p_num_imagenes;

  v_bfile bfile;
  v_foto blob;
  v_dest_offset number;
  v_src_offset number;
  v_length_archivo number;
  v_length_blob number;
  ERROR_DE_CARGA exception;
  pragma exception_init(ERROR_DE_CARGA,-20001);
  
  
begin

  dbms_output.put_line('Leyendo imágenes.');
  for r in cur_fotos loop
    v_src_offset := 1;
    v_dest_offset := 1;
    dbms_output.put_line('Procesando para empleado_id: ' || r.empleado_id);
    -- Abriendo archivo
    v_bfile := bfilename('FOTOS_DIR', 'empleado-'||r.empleado_id||'.jpg');
    v_length_archivo := dbms_lob.getlength(v_bfile);
    
    -- Primero verifica si el archivo existe
    if dbms_lob.fileexists(v_bfile) != 1 then
      dbms_output.put_line('No se encontró el archivo: empleado-'||r.empleado_id||'.jgp');
      continue;
    end if;
    
    -- Segundo, asegurate que puede accederse a él
    dbms_lob.fileopen(v_bfile, dbms_lob.lob_readonly);
    if dbms_lob.isopen(v_bfile) != 1 then
      dbms_output.put_line('No se encontró el archivo: empleado-'||r.empleado_id||'.jgp');
      continue;
    end if;
    
    -- Obteniendo referencia de la columna foto en modo exclusivo
    -- Ningun usuario puede leer el contenido de la foto mientras se actualiza
    select foto 
    into v_foto
    from empleado
    where r.empleado_id = empleado_id
    for update;  
    
    -- Cargando la foto en un solo paso
    dbms_lob.loadblobfromfile(
      dest_lob    => v_foto,            -- Destino
      src_bfile   => v_bfile,           -- Inicio
      amount      => v_length_archivo,  -- # Bytes a cargar
      src_offset  => v_src_offset,      -- Desde qué byte se empezará a cargar (1, se cargará por completo)
      dest_offset => v_dest_offset      -- Desde qué byte se empezará a leer   (1, se cargará por completo)
    ); 
    
    v_length_blob := dbms_lob.getlength(v_foto);
    
    dbms_lob.close(v_bfile);
    
    if v_length_blob != v_length_archivo then
      dbms_output.put_line('Error: La foto no se cargó completamente, 
      se esperaba: ' 
      || v_length_archivo
      || ' y se cargaron únicamente: '
      || v_length_blob);
      continue;
    else
      dbms_output.put_line('Carga exitosa.');
    end if;
  end loop;
end;
/
show errors
set serveroutput off
