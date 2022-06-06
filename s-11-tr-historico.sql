--@Autor(es): Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación: 04/06/2022  
--@Descripción: Actualiza el historico cuando el vuelo tiene un nuevo status.

connect zn_proy_admin/axzu
create or replace trigger tr_historico_vuelo
after insert or update of status_vuelo_id on vuelo
for each row
declare
v_status_vuelo_id number(2,0);
v_fecha_status date;
v_historico_vuelo_id number(10,0);
v_vuelo_id number(10,0);
begin
  select historico_vuelo_seq.nextval into v_historico_vuelo_id from dual;
  v_status_vuelo_id := :new.status_vuelo_id;
  v_fecha_status := :new.fecha_status;
  v_vuelo_id := :new.vuelo_id;
  
  dbms_output.put_line('status anterior: '|| :old.status_vuelo_id);
  dbms_output.put_line('status nuevo: '|| :new.status_vuelo_id);
  dbms_output.put_line('insertando en historico, vuelo_id: '
  || v_vuelo_id ||', v_status_vuelo_id: ' || v_status_vuelo_id
  ||', fecha: '|| v_fecha_status||', hist_id: '||v_historico_vuelo_id);
  
  insert into historico_vuelo
  (historico_vuelo_id,fecha_status,status_vuelo_id,vuelo_id)
  values(v_historico_vuelo_id,v_fecha_status,v_status_vuelo_id,v_vuelo_id);
end;
/
show errors