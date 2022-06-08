--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Procedimiento p_exporta_empleados

connect sys/system as sysdba
create or replace directory DOCUMENTOS_DIR as '/tmp/documentos';
grant read, write on directory DOCUMENTOS_DIR to zn_proy_admin;

--Crea el directorio si no existe
!mkdir -p /tmp/documentos

prompt cambiando permisos
!chmod 777 /tmp/bases

connect  zn_proy_admin/axzu

create or replace procedure p_exporta_empleados (
  p_puesto_id      in number,
  p_num_registros out number
) is

v_archivo utl_file.file_type;
v_texto varchar2(2000);

cursor cur_empleados is
    select nombre, ap_paterno, ap_materno, rfc, curp
    from empleado
    where puesto_id = p_puesto_id;
  
begin
  
  p_num_registros := 0;
  v_archivo := utl_file.fopen('DOCUMENTOS_DIR', 'empleados.csv','w');
  
  v_texto := 'Nombre,ap_paterno,ap_materno,RFC,CURP';
  utl_file.put_line(v_archivo, v_texto);
  
  for r in cur_empleados loop
    p_num_registros := p_num_registros + 1;
    v_texto := 
         r.nombre     || ','
      || r.ap_paterno || ','
      || r.ap_materno || ','
      || r.rfc        || ','
      || r.curp;
      
    utl_file.put_line(v_archivo, v_texto);
    
  end loop;
  
  utl_file.fclose(v_archivo);
  
  
  exception
    when others then
      raise;
end;
/
show errors