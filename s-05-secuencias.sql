--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo de creación de secuencias

connect zn_proy_admin/axzu

create sequence avion_seq
start with 1
increment by 1
maxvalue 1000
minvalue 1
nocycle;

create sequence empleado_seq
start with 1
increment by 1
maxvalue 5000
minvalue 1
nocycle;

create sequence aeropuerto_seq
start with 1
increment by 1
maxvalue 500
minvalue 1
nocycle;

create sequence vuelo_seq
start with 1
increment by 1
maxvalue 10000
minvalue 1
nocycle;

create sequence empleado_vuelo_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence pasajero_vuelo_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence pase_abordar_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence pase_abordar_folio_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence status_vuelo_seq
start with 1
increment by 1
maxvalue 10
minvalue 1
nocycle;

create sequence paquete_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence tipo_paquete_seq
start with 1
increment by 1
maxvalue 100
minvalue 1
nocycle;

create sequence historico_vuelo_seq
start with 1
increment by 1
maxvalue 100000
minvalue 1
nocycle;

create sequence pasajero_seq
start with 1
increment by 1
maxvalue 10000
minvalue 1
nocycle;

commit;