--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 05/06/2022
--@Descripción: Inserta un registro en el pase de abordar despues de que un
--              pasajero compra un vuelo.

connect zn_proy_admin/axzu
create or replace trigger trg_pase_abordar
after insert or update of pasajero_vuelo_id,num_asiento,tipo_asiento,atenciones,tomado,pasajero_id,vuelo_id on pasajero_vuelo
for each row

declare
  v_pase_abordar_id number(10,0);
  v_folio varchar(8);
  v_fecha_impresion date;
  v_hora_llegada date;
  v_hora_salida date;
  v_num_asiento number(3,0);
  v_tipo_asiento varchar2(3);
  v_sala_abordar varchar2(5);
  v_pasajero_vuelo_id number(10,0);

begin
  case
    when inserting then
      v_pasajero_vuelo_id := :new.pasajero_vuelo_id;
      v_pase_abordar_id := pase_abordar_seq.nextval;
      v_folio := pase_abordar_folio_seq.nextval;
      v_fecha_impresion := sysdate;
      
      select fecha_llegada into v_hora_llegada
      from vuelo
      where vuelo_id = :new.vuelo_id;
            
      select fecha_salida into v_hora_salida
      from vuelo
      where vuelo_id = :new.vuelo_id;
            
      v_num_asiento := :new.num_asiento;
      v_tipo_asiento := :new.tipo_asiento;
      v_sala_abordar := 'S/A'; -- Sin asignar
      
      insert into pase_abordar(pase_abordar_id,folio,fecha_impresion,hora_llegada,
        hora_salida,num_asiento,tipo_asiento,sala_abordar,pasajero_vuelo_id)
        values(v_pase_abordar_id,v_folio,v_fecha_impresion,v_hora_llegada,
        v_hora_salida,v_num_asiento,v_tipo_asiento,v_sala_abordar,v_pasajero_vuelo_id);
  end case;
end;
/
show errors