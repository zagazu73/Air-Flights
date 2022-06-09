--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 08/06/2022  
--@Descripción: Prueba de la funcion desempenio-aeropuerto
--              La funcion recibe el aeropuerto_id y devuelve su desempeño promedio.
--              Considera el desempeño de los empleados que laboran en dicho aeropuerto
--              tanto de despegues como de aterrizajes. (aeropuertos de llegada y de salida)

connect zn_proy_admin/axzu
set serveroutput on

declare
  v_aeropuerto_id number(10,0);
  v_aeropuerto_id2 number(10,0);
  v_avion_id number(10,0);
  v_avion_id2 number(10,0);
  v_desempenio number(3,0);
  v_empleado_id number(10,0);
  v_empleado_id2 number(10,0);
  v_vuelo_id number(10,0);
  
begin

  dbms_output.put_line(chr(5));
  dbms_output.put_line('==============================================================');
  dbms_output.put_line('Escenario de prueba de funcion ===> Desempeño de un aeropuerto');
  dbms_output.put_line('==============================================================');
  
  dbms_output.put_line('Ingresando registros de prueba');
  
  dbms_output.put_line('Creamos aeropuertos activo de prueba');
  v_aeropuerto_id := aeropuerto_seq.nextval;
  insert into aeropuerto(aeropuerto_id,nombre,clave,latitud,longitud,activo)
    values(v_aeropuerto_id,'Felipe Angeles','FA4dnmw8928ar',29,67,1);
  v_aeropuerto_id2 := aeropuerto_seq.nextval;
  insert into aeropuerto(aeropuerto_id,nombre,clave,latitud,longitud,activo)
    values(v_aeropuerto_id2,'Mexican Air','MAR4d80a928lk',29,67,1);
  
  dbms_output.put_line('Creamos aviones de prueba');
  v_avion_id := avion_seq.nextval;
  insert into avion_tmp(avion_id, matricula, modelo, especificaciones,  es_comercial, es_carga, capacidad_ordinario, capacidad_vip, capacidad_discapacitado, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas, capacidad, aeropuerto_id) 
  values (v_avion_id, '1001d1a3-6', '813f73d1-c5z8-4efb-a', empty_blob(), 1, 1, 113, 143, 77, 11.82, 17.8, 11.26, 4.92, 13.203, null);
  v_avion_id2 := avion_seq.nextval;
  insert into avion_tmp(avion_id, matricula, modelo, especificaciones,  es_comercial, es_carga, capacidad_ordinario, capacidad_vip, capacidad_discapacitado, bodega_profundidad, bodega_alto, bodega_ancho, num_bodegas, capacidad, aeropuerto_id) 
  values (v_avion_id2, '1001b0ka-4', '813f73d1-holi-4efb-a', empty_blob(), 1, 1, 113, 143, 77, 11.82, 17.8, 11.26, 4.92, 13.203, null);
  p_crea_avion();
  
  dbms_output.put_line('Creamos empleados');
  v_empleado_id := empleado_seq.nextval;
  insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,curp,foto,jefe_id,puesto_id)
    values(v_empleado_id,'Zuriel','Zarate','Garcia','ZAGZ990828HMCRRR05',empty_blob(),null,1);
  v_empleado_id2 := empleado_seq.nextval;
  insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,curp,foto,jefe_id,puesto_id)
    values(v_empleado_id2,'Luis Axel','Nuñez','Quintana','NUQA200412HMCRRR01',empty_blob(),null,1);
  
  dbms_output.put_line('Creamos vuelos con los aeropuertos, aviones y empleados creados');
  v_vuelo_id := vuelo_seq.nextval;
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2022-06-15 12:14:20', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-15 10:14:20', 'yyyy-mm-dd hh24:mi:ss'), 'hola1', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), v_avion_id, v_aeropuerto_id, v_aeropuerto_id2, 1, 'P');
  v_vuelo_id := vuelo_seq.nextval;
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2022-06-17 07:24:18', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-17 02:24:18', 'yyyy-mm-dd hh24:mi:ss'), 'hola2', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), v_avion_id2, v_aeropuerto_id2, v_aeropuerto_id, 1, 'P');
  v_vuelo_id := vuelo_seq.nextval;
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2022-06-20 05:12:29', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-20 01:12:29', 'yyyy-mm-dd hh24:mi:ss'), 'hola3', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), v_avion_id, v_aeropuerto_id, v_aeropuerto_id2, 1, 'P');
  v_vuelo_id := vuelo_seq.nextval;
  insert into vuelo(vuelo_id, num_vuelo, fecha_llegada, fecha_salida, sala_abordar, fecha_status, avion_id, aeropuerto_salida, aeropuerto_llegada, status_vuelo_id, tipo) 
    values(v_vuelo_id, v_vuelo_id, to_date('2022-06-28 15:12:29', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-06-28 10:06:11', 'yyyy-mm-dd hh24:mi:ss'), 'hola3', to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss'), v_avion_id2, v_aeropuerto_id2, v_aeropuerto_id, 1, 'P');
    
    
  dbms_output.put_line('Especificamos el desempeño de cada empleado');
  insert into empleado_vuelo(empleado_vuelo_id,vuelo_id,empleado_id,rol,desempenio) 
    values(empleado_vuelo_seq.nextval,v_vuelo_id,v_empleado_id,'piloto',85);
  insert into empleado_vuelo(empleado_vuelo_id,vuelo_id,empleado_id,rol,desempenio) 
    values(empleado_vuelo_seq.nextval,v_vuelo_id-1,v_empleado_id2,'piloto',66);
  insert into empleado_vuelo(empleado_vuelo_id,vuelo_id,empleado_id,rol,desempenio) 
    values(empleado_vuelo_seq.nextval,v_vuelo_id-2,v_empleado_id,'piloto',73);
  insert into empleado_vuelo(empleado_vuelo_id,vuelo_id,empleado_id,rol,desempenio) 
    values(empleado_vuelo_seq.nextval,v_vuelo_id-3,v_empleado_id2,'piloto',96);
  
  --La suma de los desempeños propuestos es 85+65+73+96 / 4 = 80
  
  v_desempenio := desempenio_aeropuerto(v_aeropuerto_id);
  if v_desempenio = 80 then
    dbms_output.put_line('El desempeño promedio del aeropuerto '||v_aeropuerto_id||
      ' es de '||v_desempenio);
    dbms_output.put_line('La funcion funciona :) ======================> OK! Escenario correcto');
  else
    dbms_output.put_line('===================================> ERROR Escenario incorrecto');
  end if;
  
end;
/
show errors
Prompt Haciendo rollback para limpiar tablas
rollback;
set serveroutput off