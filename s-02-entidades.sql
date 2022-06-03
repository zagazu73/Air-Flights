--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 02/06/2022  
--@Descripción: Creacion de los objetos de Air Flights

connect zn_proy_admin/axzu

prompt creando tabla aeropuerto...
create table aeropuerto(
    aeropuerto_id    number(10, 0)    not null,
    nombre           varchar2(50)     not null,
    clave            varchar2(13)     not null,
    latitud          number(3, 0)     not null,
    longitud         number(3, 0)     not null,
    activo           number(1, 0)     not null,
    constraint aeropuerto_pk primary key (aeropuerto_id),
    constraint aeropuerto_clave_uk unique(clave)
);

prompt creando tabla avion...
create table avion(
    avion_id            number(10, 0)    not null,
    matricula           varchar2(10)     not null,
    modelo              varchar2(50)     not null,
    especificaciones    blob             not null,
    es_comercial        number(1, 0)     not null,
    es_carga            number(1, 0)     not null,
    constraint avion_pk primary key(avion_id),
    constraint avion_matricula_uk unique(matricula)
);

prompt creando tabla avion_carga...
create table avion_carga(
    avion_id              number(10, 0)    not null,
    bodega_profundidad    number(5, 2)     not null,
    bodega_alto           number(5, 2)     not null,
    bodega_ancho          number(5, 2)     not null,
    num_bodegas           number(2, 0)     not null,
    capacidad             number(2, 0)     not null,
    aeropuerto_id         number(10, 0)    not null,
    constraint avion_carga_avion_id_fk foreign key(avion_id)
    references avion(avion_id),
    constraint avion_carga_pk primary key(avion_id),
    constraint avion_carga_aeropuerto_id_fk foreign key(aeropuerto_id)
    references aeropuerto(aeropuerto_id)
);

prompt creando tabla avion_comercial...
create table avion_comercial(
    avion_id                   number(10, 0)    not null,
    capacidad_ordinario        number(3, 0)     not null,
    capacidad_discapacitado    number(3, 0)     not null,
    capacidad_vip              number(3, 0)     not null,
    constraint avion_comercial_avion_id_fk foreign key(avion_id)
    references avion(avion_id),
    constraint avion_comercial_pk primary key(avion_id)
);

prompt creando tabla pasajero...
create table pasajero(
    pasajero_id         number(10, 0)    not null,
    nombre              varchar2(50)     not null,
    ap_paterno          varchar2(50)     not null,
    ap_materno          varchar2(50)             ,
    curp                varchar2(18)     not null,
    fecha_nacimiento    date             not null,
    constraint pasajero_pk primary key(pasajero_id),
    constraint pasajero_curp_uk unique(curp)
);

prompt creando tabla email_pasajero...
create table email_pasajero(
    num_email      number(1, 0)     not null,
    pasajero_id    number(10, 0)    not null,
    email          varchar2(50)     not null,
    constraint email_pasajero_pasajero_id_fk foreign key(pasajero_id)
    references pasajero(pasajero_id),
    constraint email_pasajero_pk primary key(num_email, pasajero_id),
    constraint email_pasajero_email_uk unique(email)
);

prompt creando tabla puesto...
create table puesto(
    puesto_id      number(2, 0)     not null,
    clave          varchar2(20)     not null,
    nombre         varchar2(50)     not null,
    descripcion    varchar2(200)    not null,
    sueldo         number(7, 2)     not null,
    constraint puesto_pk primary key(puesto_id)
);

prompt creando tabla empleado...
create table empleado(
    empleado_id    number(10, 0)    not null,
    nombre         varchar2(50)     not null,
    ap_paterno     varchar2(50)     not null,
    ap_materno     varchar2(50)     not null,
    rfc            varchar2(13)     not null,
    curp           varchar2(18)     not null,
    foto           blob             not null,
    jefe_id        number(10, 0)            ,
    puesto_id      number(2, 0)     not null,
    constraint empleado_jefe_id_fk foreign key(jefe_id)
    references empleado(empleado_id),
    constraint empleado_puesto_id_fk foreign key(puesto_id)
    references puesto(puesto_id),
    constraint empleado_pk primary key(empleado_id),
    constraint empleado_rfc_uk unique(rfc),
    constraint empleado_curp_uk unique(curp)
);

prompt creando tabla status_vuelo...
create table status_vuelo(
    status_vuelo_id    number(2, 0)    not null,
    status_vuelo       varchar2(40)    not null,
    constraint status_vuelo_pk primary key(status_vuelo_id),
    constraint status_vuelo_status_vuelo_uk unique(status_vuelo)
);

prompt creando tabla vuelo...
create table vuelo(
    vuelo_id              number(10, 0)    not null,
    num_vuelo             number(5, 0)     not null,
    fecha_llegada         date             not null,
    fecha_salida          date             not null,
    sala_abordar          varchar2(5),
    fecha_status          date             not null,
    avion_id              number(10, 0)    not null,
    aeropuerto_salida     number(10, 0)    not null,
    aeropuerto_llegada    number(10, 0)    not null,
    status_vuelo_id       number(2, 0)     not null,
    constraint vuelo_avion_id_fk foreign key(avion_id)
    references avion(avion_id),
    constraint vuelo_aeropuerto_salida_fk foreign key(aeropuerto_salida)
    references aeropuerto(aeropuerto_id),
    constraint vuelo_aeropuerto_llegada_fk foreign key(aeropuerto_llegada)
    references aeropuerto(aeropuerto_id),
    constraint vuelo_status_vuelo_id_fk foreign key(status_vuelo_id)
    references status_vuelo(status_vuelo_id),
    constraint vuelo_pk primary key(vuelo_id),
    constraint vuelo_aeropuertos_chk check(
      aeropuerto_llegada!=aeropuerto_salida
    ),
    constraint vuelo_num_vuelo_uk unique(num_vuelo)
);

prompt creando tabla empleado_vuelo...
create table empleado_vuelo(
    empleado_vuelo_id    number(10, 0)    not null,
    vuelo_id             number(10, 0)    not null,
    empleado_id          number(10, 0)    not null,
    rol                  varchar2(20)     not null,
    desempenio           number(3, 0)     not null,
    constraint empleado_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
    constraint empleado_vuelo_empleado_id_fk foreign key(empleado_id)
    references empleado(empleado_id),
    constraint empleado_vuelo_pk primary key (empleado_vuelo_id),
    constraint empleado_vuelo_vuelo_id_uk unique(vuelo_id),
    constraint empleado_vuelo_empleado_id_uk unique(empleado_id)
);

prompt creando tabla historico_vuelo...
create table historico_vuelo(
    historico_vuelo_id    number(10, 0)    not null,
    fecha_status          date             not null,
    status_vuelo_id       number(2, 0)     not null,
    vuelo_id              number(10, 0)    not null,
    constraint historico_vuelo_status_vuelo_id_fk foreign key(status_vuelo_id)
    references status_vuelo(status_vuelo_id),
    constraint historico_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
    constraint historico_vuelo_pk primary key(historico_vuelo_id)
);

prompt creando tabla link_empleado...
create table link_empleado(
    num_link       number(2, 0)     not null,
    empleado_id    number(10, 0)    not null,
    link           varchar2(100)    not null,
    constraint link_empleado_empleado_id_fk foreign key(empleado_id)
    references empleado(empleado_id),
    constraint link_empleado_pk primary key(num_link,empleado_id),
    constraint link_empleado_link_uk unique(link)
);

prompt creando tabla pasajero_vuelo...
create table pasajero_vuelo(
    pasajero_vuelo_id    number(10, 0)     not null,
    num_asiento          number(3, 0)      not null,
    atenciones           varchar2(2000)    not null,
    tomado               number(1, 0)      not null,
    pasajero_id          number(10, 0)     not null,
    vuelo_id             number(10, 0)     not null,
    constraint pasajero_vuelo_pasajero_id_fk foreign key(pasajero_id)
    references pasajero(pasajero_id),
    constraint pasajero_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
    constraint pasajero_vuelo_pk primary key (pasajero_vuelo_id)
);

prompt creando tabla pase_abordar...
create table pase_abordar(
    pase_abordar_id      number(10, 0)    not null,
    folio                varchar2(8)      not null,
    fecha_impresion      date             not null,
    hora_llegada         date             not null,
    hora_salida          date             not null,
    num_asiento          number(3, 0)     not null,
    sala_abordar         varchar2(5)              ,
    pasajero_vuelo_id    number(10, 0)    not null,
    constraint pase_abordar_pasajero_vuelo_id_fk foreign key(pasajero_vuelo_id)
    references pasajero_vuelo(pasajero_vuelo_id),
    constraint pase_abordar_pk primary key(pase_abordar_id),
    constraint pase_abordar_folio_uk unique(folio)
);

prompt creando tabla maleta...
create table maleta(
    num_maleta         number(2, 0)     not null,
    pase_abordar_id    number(10, 0)    not null,
    peso               number(5, 2)     not null,
    constraint maleta_pase_abordar_id_fk foreign key(pase_abordar_id)
    references pase_abordar(pase_abordar_id),
    constraint maleta_pk primary key (num_maleta,pase_abordar_id)
);

prompt creando tabla tipo_paquete...
create table tipo_paquete(
    tipo_paquete_id    number(2, 0)     not null,
    clave              varchar2(5)      not null,
    descripcion        varchar2(200)    not null,
    indicaciones       varchar2(500)    not null,
    constraint tipo_paquete_pk primary key(tipo_paquete_id),
    constraint tipo_paquete_clave_uk unique(clave)
);

prompt creando tabla paquete...
create table paquete(
    paquete_id         number(10, 0)    not null,
    folio              varchar2(18)     not null,
    peso               number(5, 2)     not null,
    tipo_paquete_id    number(2, 0)     not null,
    vuelo_id           number(10, 0)    not null,
    constraint paquete_tipo_paquete_id_fk foreign key(tipo_paquete_id)
    references tipo_paquete(tipo_paquete_id),
    constraint paquete_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
    constraint paquete_pk primary key(paquete_id),
    constraint paquete_folio_uk unique(folio)
);

prompt creando ubicacion_vuelo...
create table ubicacion_vuelo(
    num_ubicacion    number(4, 0)     not null,
    vuelo_id         number(10, 0)    not null,
    latitud          number(3, 0)     not null,
    longitud         number(3, 0)     not null,
    fecha            date             not null,
    constraint ubicacion_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
    constraint ubicacion_vuelo_pk primary key (num_ubicacion,vuelo_id)
);