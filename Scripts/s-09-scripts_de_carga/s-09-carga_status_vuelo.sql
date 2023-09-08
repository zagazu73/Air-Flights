--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo carga inicial de status_vuelo

insert into status_vuelo (status_vuelo_id, status_vuelo) values (status_vuelo_seq.nextval, 'PROGRAMADO');
insert into status_vuelo (status_vuelo_id, status_vuelo) values (status_vuelo_seq.nextval, 'ABORDANDO');
insert into status_vuelo (status_vuelo_id, status_vuelo) values (status_vuelo_seq.nextval, 'A TIEMPO');
insert into status_vuelo (status_vuelo_id, status_vuelo) values (status_vuelo_seq.nextval, 'DEMORADO');
insert into status_vuelo (status_vuelo_id, status_vuelo) values (status_vuelo_seq.nextval, 'CANCELADO');