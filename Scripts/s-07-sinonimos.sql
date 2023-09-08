--@Autor: Zuriel Zárate García y Luis Axel Nuñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Creacion de sinonimos requeridos.

connect zn_proy_admin/axzu
Prompt creando sinónimos publicos de zn_proy_admin...
create or replace public synonym ubi_vuelo for zn_proy_admin.ubicacion_vuelo;
create or replace public synonym avi for zn_proy_admin.avion;
create or replace public synonym vue for zn_proy_admin.vuelo;

connect sys/system as sysdba
Prompt otorgando permisos a zn_proy_invitado para leer tablas de zn_proy_admin
grant select on zn_proy_admin.paquete to zn_proy_invitado;
grant select on zn_proy_admin.tipo_paquete to zn_proy_invitado;
grant select on zn_proy_admin.status_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.historico_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.aeropuerto to zn_proy_invitado;
grant select on zn_proy_admin.pasajero_vuelo to zn_proy_invitado;
grant select on zn_proy_admin.pasajero to zn_proy_invitado;
grant select on zn_proy_admin.pase_abordar to zn_proy_invitado;
grant select on zn_proy_admin.email_pasajero to zn_proy_invitado;
grant select on zn_proy_admin.maleta to zn_proy_invitado;

connect zn_proy_invitado/axzu
Prompt creando sinónimos privados para zn_proy_invitado...
create or replace synonym paquete for zn_proy_admin.paquete;
create or replace synonym tipo_paquete for zn_proy_admin.tipo_paquete;
create or replace synonym status_vuelo for zn_proy_admin.status_vuelo;
create or replace synonym historico_vuelo for zn_proy_admin.historico_vuelo;
create or replace synonym aeropuerto for zn_proy_admin.aeropuerto;
create or replace synonym pasajero_vuelo for zn_proy_admin.pasajero_vuelo;
create or replace synonym pasajero for zn_proy_admin.pasajero;
create or replace synonym pase_abordar for zn_proy_admin.pase_abordar;
create or replace synonym email_pasajero for zn_proy_admin.email_pasajero;
create or replace synonym maleta for zn_proy_admin.maleta;


connect zn_proy_admin/axzu
Prompt creando sinónimos privados de zn_proy_admin...

set serveroutput on
declare
  v_sql varchar2(4000);
  v_existe number(1);
  v_sinonimo varchar2(20);
  v_tabla varchar2(20);
  v_for varchar2(30);
  
  cursor cur_tablas is 
    select table_name from user_tables;
    
begin
  for t in cur_tablas loop
    v_tabla := t.table_name;
    v_sinonimo := 'ZN_'||upper(v_tabla);
    dbms_output.put_line('______________________________________________________');
    dbms_output.put_line('Verificando si el sinonimo existe');
    select count(*) into v_existe
    from user_synonyms
    where synonym_name = v_sinonimo;
    if v_existe = 0 then
      v_for := 'zn_proy_admin.'||lower(v_tabla);
      v_sinonimo := lower(v_sinonimo);
      dbms_output.put_line('No existe. Creando sinonimo '||v_sinonimo||' para '||v_for);
      v_sql := ('
        create or replace synonym '||v_sinonimo||' for '||v_for
      );
      execute immediate v_sql;
      dbms_output.put_line('Creado');
    else
      dbms_output.put_line('El sinonimo ya existe...');
    end if;
  end loop;
end;
/
show errors