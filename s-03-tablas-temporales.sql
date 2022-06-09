--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 02/06/2022  
--@Descripción: Creacion de las tablas temporales

connect zn_proy_admin/axzu

prompt Creando tabla avion_tmp...
create global temporary table avion_tmp(
    avion_id                   number(10,0)    not null,
    matricula                  varchar2(10)    not null,
    modelo                     varchar2(50)    not null,
    especificaciones           blob            not null,
    es_comercial               number(1,0)     not null,
    es_carga                   number(1, 0)    not null,
    bodega_profundidad         number(5,2)     null,
    bodega_alto                number(5,2)     null,
    bodega_ancho               number(5,2)     null,
    num_bodegas                number(2,0)     null,
    capacidad                  number(5,3)     null, 
    aeropuerto_id              number(10,0)    null,
    capacidad_ordinario        number(3,0)     null,
    capacidad_discapacitado    number(3,0)     null,
    capacidad_vip              number(3,0)     null,
    constraint avion_tmp_pk primary key(avion_id),
    constraint avion_tmp_comercial_capacidad_chk check(
      capacidad_ordinario >= 10 and capacidad_vip >= 10 and capacidad_discapacitado>=10
    ),
    constraint avion_tmp_carga_num_bodegas check(
      num_bodegas >= 1 -- Un avión de carga debe tener al menos 1 bodega
    ),
    constraint avion_tmp_carga_capacidad_chk check(
      capacidad between 1.000 and 20.000 
      -- Un avión de carga debe soportar al menos 1 tonelada y 20 a lo mucho
    )    
)on commit delete rows;

prompt Creando tabla avion_tmp_falla...
create global temporary table avion_tmp_falla(
    avion_id                   number(10,0)    not null,
    matricula                  varchar2(10)    not null,
    modelo                     varchar2(50)    not null,
    especificaciones           blob            not null,
    es_comercial               number(1,0)     not null,
    es_carga                   number(1, 0)    not null,
    bodega_profundidad         number(5,2)     null,
    bodega_alto                number(5,2)     null,
    bodega_ancho               number(5,2)     null,
    num_bodegas                number(2,0)     null,
    capacidad                  number(5,3)     null, 
    aeropuerto_id              number(10,0)    null,
    capacidad_ordinario        number(3,0)     null,
    capacidad_discapacitado    number(3,0)     null,
    capacidad_vip              number(3,0)     null,
    descripcion                varchar2(200)   not null,
    constraint avion_tmp_falla_pk primary key(avion_id)
)on commit preserve rows;
