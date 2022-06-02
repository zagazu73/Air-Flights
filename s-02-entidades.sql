--@Autor(es): Zuriel Zárate García
--            Luis Axel Núñez Quintana
--
--@Fecha creación: 2 de junio de 2022  
--@Descripción:     Script validacion proyecto final

prompt creando tabla aeropuerto...
create table aeropuerto(
    aeropuerto_id    number(10, 0)    not null,
    nombre           varchar2(50)     not null,
    clave            varchar2(13)     not null,
    latitud          number(3, 0)     not null,
    longitud         number(3, 0)     not null,
    activo           number(1, 0)     not null,
    constraint pk10 primary key (aeropuerto_id)
);

prompt creando tabla avion...
create table avion(
    avion_id            number(10, 0)    not null,
    matricula           varchar2(10)     not null,
    modelo              varchar2(50)     not null,
    especificaciones    blob             not null,
    es_comercial        number(1, 0)     not null,
    es_carga            number(1, 0)     not null,
    constraint pk1 primary key (avion_id)
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
    constraint pk3 primary key (avion_id)
);

prompt creando tabla avion_comercial...
create table avion_comercial(
    avion_id                   number(10, 0)    not null,
    capacidad_ordinario        number(3, 0)     not null,
    capacidad_discapacitado    number(3, 0)     not null,
    capacidad_vip              number(3, 0)     not null,
    constraint pk2 primary key (avion_id)
);

prompt creando tabla email_pasajero...
create table email_pasajero(
    num_email      number(1, 0)     not null,
    pasajero_id    number(10, 0)    not null,
    email          varchar2(50)     not null,
    constraint pk6 primary key (num_email, pasajero_id)
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
    jefe_id        number(10, 0),
    puesto_id      number(2, 0)     not null,
    constraint pk11 primary key (empleado_id)
);

prompt creando tabla empleado_vuelo...
create table empleado_vuelo(
    empleado_vuelo_id    number(10, 0)    not null,
    vuelo_id             number(10, 0)    not null,
    empleado_id          number(10, 0)    not null,
    rol                  varchar2(20)     not null,
    desempenio           number(3, 0)     not null,
    constraint pk21 primary key (empleado_vuelo_id)
);

prompt creando tabla historico_vuelo...
create table historico_vuelo(
    historico_vuelo_id    number(10, 0)    not null,
    fecha_status          date             not null,
    status_vuelo_id       number(2, 0)     not null,
    vuelo_id              number(10, 0)    not null,
    constraint pk18 primary key (historico_vuelo_id)
);

prompt creando tabla link_empleado...
create table link_empleado(
    num_link       number(2, 0)     not null,
    empleado_id    number(10, 0)    not null,
    link           varchar2(100)    not null,
    constraint pk12 primary key (num_link, empleado_id)
);

prompt creando tabla maleta...
create table maleta(
    num_maleta         number(2, 0)     not null,
    pase_abordar_id    number(10, 0)    not null,
    peso               number(5, 2)     not null,
    constraint pk17 primary key (num_maleta, pase_abordar_id)
);


prompt creando tabla paquete...
create table paquete(
    paquete_id         number(10, 0)    not null,
    folio              varchar2(18)     not null,
    peso               number(5, 2)     not null,
    tipo_paquete_id    number(2, 0)     not null,
    vuelo_id           number(10, 0)    not null,
    constraint pk15 primary key (paquete_id)
);

prompt creando tabla pasajero...
create table pasajero(
    pasajero_id         number(10, 0)    not null,
    nombre              varchar2(50)     not null,
    ap_paterno          varchar2(50)     not null,
    ap_materno          varchar2(50),
    curp                varchar2(18)     not null,
    fecha_nacimiento    date             not null,
    constraint pk5 primary key (pasajero_id)
);

prompt creando tabla pasajero_vuelo...
create table pasajero_vuelo(
    pasajero_vuelo_id    number(10, 0)     not null,
    num_asiento          number(3, 0)      not null,
    atenciones           varchar2(2000)    not null,
    tomado               number(1, 0)      not null,
    pasajero_id          number(10, 0)     not null,
    vuelo_id             number(10, 0)     not null,
    constraint pk20 primary key (pasajero_vuelo_id)
);

prompt creando tabla pase_abordar...
create table pase_abordar(
    pase_abordar_id      number(10, 0)    not null,
    folio                varchar2(8)      not null,
    fecha_impresion      date             not null,
    hora_llegada         date             not null,
    hora_salida          date             not null,
    num_asiento          number(3, 0)     not null,
    sala_abordar         varchar2(5),
    pasajero_vuelo_id    number(10, 0)    not null,
    constraint pk14 primary key (pase_abordar_id)
);

prompt creando tabla puesto...
create table puesto(
    puesto_id      number(2, 0)     not null,
    clave          varchar2(20)     not null,
    nombre         varchar2(50)     not null,
    descripcion    varchar2(200)    not null,
    sueldo         number(7, 2)     not null,
    constraint pk13 primary key (puesto_id)
);

prompt creando tabla status_vuelo...
create table status_vuelo(
    status_vuelo_id    number(2, 0)    not null,
    status_vuelo       varchar2(40)    not null,
    constraint pk19 primary key (status_vuelo_id)
);

prompt creando tabla tipo_paquete...
create table tipo_paquete(
    tipo_paquete_id    number(2, 0)     not null,
    clave              varchar2(5)      not null,
    descripcion        varchar2(200)    not null,
    indicaciones       varchar2(500)    not null,
    constraint pk16 primary key (tipo_paquete_id)
);

prompt creando ubicacion_vuelo...
create table ubicacion_vuelo(
    num_ubicacion    number(4, 0)     not null,
    vuelo_id         number(10, 0)    not null,
    latitud          number(3, 0)     not null,
    longitud         number(3, 0)     not null,
    fecha            date             not null,
    constraint pk22 primary key (num_ubicacion, vuelo_id)
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
    constraint pk7 primary key (vuelo_id)
);

