--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	27/05/2022
--@Descripción:	Ejercicio 2, procedimiento para probar el ejercicio 2 de la práctica 13


connect zn_proy_admin/axzu

set serveroutput on

declare

v_min number (3,0):= 1;
v_max number (3,0):= 31;
v_num_inicial number(3,0);
v_num_fotos number(3,0);

cursor cur_fotos is
    select empleado_id, dbms_lob.getlength(foto) as longitud_foto
    from empleado;


ARCHIVO_NO_ENCONTRADO exception;
pragma exception_init(ARCHIVO_NO_ENCONTRADO,-22288);
 
begin
    dbms_output.put_line(chr(5));
    dbms_output.put_line('===========================================================');
    dbms_output.put_line('Escenario 1- Todas las imagenes se actualizan correctamente');
    dbms_output.put_line('===========================================================');
  
    v_num_inicial := 1;
    v_num_fotos := 30;
    if v_num_inicial < v_min or v_num_inicial + v_num_fotos > v_max then
      dbms_output.put_line('Valor de parametros fuera de los limites!!!');
      dbms_output.put_line('Los valores deben estar dentro del rango ['||v_min||','||v_max||']');
    else
      carga_fotos_empleado(v_num_inicial,v_num_fotos);
      dbms_output.put_line('Todas las imagenes fueron actualizadas =========> OK! Escenario 1 correcto');
    end if;
   
    dbms_output.put_line('Mostrando la longitud de los archivos cargados...');
    for r in cur_fotos loop
      dbms_output.put_line('Empleado: ' || r.empleado_id || ', tamaño foto: ' || r.longitud_foto);
    end loop;
    
  exception 
    when ARCHIVO_NO_ENCONTRADO then
      dbms_output.put_line('No se encontró el archivo! Verifique que el nombre del archivo es: empleado-<empleado_id>.jpg');
      dbms_output.put_line('');
      dbms_output.put_line('');
      dbms_output.put_line('Error en la prueba...=========> Escenario 1 incorrecto');
    when others then
      raise;
end;
/

Prompt Haciendo rollback para limpiar tablas
set serveroutput off
