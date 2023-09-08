--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 05/06/2022  
--@Descripción: Crea la tabla externa para los datos de la tabla "puesto"

connect sys/system as sysdba
create or replace directory tmp_dir as '/tmp/bases';
grant read, write on directory tmp_dir to zn_proy_admin;

prompt Contectando con usuario zn_proy_admin/axzu para crear la tabla externa
connect  zn_proy_admin/axzu
show user

prompt creando tabla externa
set sqlblanklines on;

create table puesto_ext(
    puesto_id         number(2,0),
    clave	            varchar2(20),
    nombre            varchar2(50),
    descripcion       varchar2(200),
    sueldo            number(7,0)
)
organization external (
    type oracle_loader --Driver para parsear el archivo
    default directory tmp_dir
    access parameters (
        records delimited by newline
        badfile tmp_dir:'puesto_bad.log'
        logfile tmp_dir:'puesto.log'
        fields terminated by ','
        lrtrim
        missing field values are null
        (
        	puesto_id,clave,nombre,descripcion,sueldo
        )
    )
    location ('s-04-tablas-externas.csv')
)
reject limit unlimited;

--Crea el directorio si no existe
!mkdir -p /tmp/bases
--Copiando
!cp s-04-tablas-externas.csv /tmp/bases 
prompt cambiando permisos
!chmod 777 /tmp/bases