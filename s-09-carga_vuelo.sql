--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo carga inicial de vuelo  

declare

v_indice number;
begin

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-08-30 20:27:17', 'yyyy-mm-dd hh24:mi:ss'), to_date('2021-10-04 03:04:40', 'yyyy-mm-dd hh24:mi:ss'), 'SWQNq', to_date('2022-06-13 07:15:41', 'yyyy-mm-dd hh24:mi:ss'), 17, 1, 18, 1, 'P');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-03-14 01:17:43', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-02-19 19:12:57', 'yyyy-mm-dd hh24:mi:ss'), 'LBFTK', to_date('2021-08-12 16:14:27', 'yyyy-mm-dd hh24:mi:ss'), 1, 1, 12, 1, 'C');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2022-06-20 07:00:00', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-10 00:00:00', 'yyyy-mm-dd hh24:mi:ss'), 'Mkmav', to_date('2021-06-07 14:09:29', 'yyyy-mm-dd hh24:mi:ss'), 2, 1, 12, 1, 'C');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-09-16 09:05:05', 'yyyy-mm-dd hh24:mi:ss'), to_date('2021-06-18 05:47:48', 'yyyy-mm-dd hh24:mi:ss'), 'BdOAZ', to_date('2022-05-23 14:44:28', 'yyyy-mm-dd hh24:mi:ss'), 3, 1, 20, 1, 'C');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-08-03 18:25:04', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-24 07:38:48', 'yyyy-mm-dd hh24:mi:ss'), 'zMj5l', to_date('2021-12-12 16:10:16', 'yyyy-mm-dd hh24:mi:ss'), 4, 1, 20, 1, 'C');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-07-12 14:32:28', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-04-06 22:48:27', 'yyyy-mm-dd hh24:mi:ss'), 'N6Lxh', to_date('2021-07-17 06:32:55', 'yyyy-mm-dd hh24:mi:ss'), 13, 1, 6, 1, 'P');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-06-20 00:22:55', 'yyyy-mm-dd hh24:mi:ss'), to_date('2021-09-01 01:37:29', 'yyyy-mm-dd hh24:mi:ss'), '9Exq7', to_date('2021-08-12 00:26:11', 'yyyy-mm-dd hh24:mi:ss'), 14, 1, 15, 1, 'P');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-01-02 01:30:53', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-04-17 15:07:32', 'yyyy-mm-dd hh24:mi:ss'), 'bN6HS', to_date('2021-07-17 18:33:10', 'yyyy-mm-dd hh24:mi:ss'), 11, 1, 6, 1, 'P');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-12-07 08:43:27', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-04-29 20:54:40', 'yyyy-mm-dd hh24:mi:ss'), '9ynqW', to_date('2022-09-19 23:28:09', 'yyyy-mm-dd hh24:mi:ss'), 16, 1, 20, 1, 'P');

v_indice := vuelo_seq.nextval;
insert into vuelo (vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) values (v_indice, v_indice, to_date('2025-10-15 05:14:11', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-05-15 02:06:15', 'yyyy-mm-dd hh24:mi:ss'), 'pjf4C', to_date('2021-06-24 21:54:56', 'yyyy-mm-dd hh24:mi:ss'), 7, 1, 4, 1, 'P');

end;
/
show errors;