--@Autor: Zuriel Zárate García y Luis Axel Nuñez Quintana
--@Fecha creación:	02/06/2022
--@Descripción:	Crea a los usuarios zn_proy.

connect sys/system as sysdba

set serveroutput on
declare
  v_count number(1,0);
begin
  --Revisando usuarios...
  select count(*) into v_count from dba_users
  where username ='ZN_PROY_INVITADO';
  if v_count > 0 then
    execute immediate 'drop user ZN_PROY_INVITADO cascade';
    dbms_output.put_line('Usuario eliminado');
  else
    dbms_output.put_line('El usuario no existe, no se requiere eliminar');
  end if;

  select count(*) into v_count from dba_users
  where username ='ZN_PROY_ADMIN';
  if v_count > 0 then
    execute immediate 'drop user ZN_PROY_ADMIN cascade';
    dbms_output.put_line('Usuario eliminado');
  else
    dbms_output.put_line('El usuario no existe, no se requiere eliminar');
  end if;

  --Revisando roles...
  select count(*) into v_count from dba_roles
  where role ='ZN_ROL_ADMIN';
  if v_count > 0 then
    execute immediate 'drop role ZN_ROL_ADMIN';
    dbms_output.put_line('Rol eliminado');
  else
    dbms_output.put_line('El rol no existe, no se requiere eliminar');
  end if;

  select count(*) into v_count from dba_roles
  where role ='ZN_ROL_INVITADO';
  if v_count > 0 then
    execute immediate 'drop role ZN_ROL_INVITADO';
    dbms_output.put_line('Rol eliminado');
  else
    dbms_output.put_line('El rol no existe, no se requiere eliminar');
  end if;
end;
/
set serveroutput off

prompt creando roles y definiendo sus privilegios...
create role zn_rol_admin;
grant create session,create table,create view,create public synonym,
  create synonym,create procedure,create trigger, create sequence to zn_rol_admin;
prompt rol zn_rol_admin creado!
create role zn_rol_invitado;
grant create session,create synonym to zn_rol_invitado;
prompt rol zn_rol_invitado creado!

create user zn_proy_invitado identified by axzu quota unlimited on users;
Prompt Asignando rol de invitado a zn_proy_invitado...
grant zn_rol_invitado to zn_proy_invitado;

create user zn_proy_admin identified by axzu quota unlimited on users;
Prompt Asignando rol de admin a zn_proy_admin...
grant zn_rol_admin to zn_proy_admin;
