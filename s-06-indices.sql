--@Autor: Zuriel Zárate García y Luis Axel Núñez Quintana
--@Fecha creación:	03/06/2022
--@Descripción:	Archivo de creación de índices

connect zn_proy_admin/axzu

-- Instrucciones comentadas = índice por constraint unique o primary key

-- Mejorar desempeño en consultas
-- Tabla empleado
--create index emp_rfc_ix on empleado(rfc);
--create index emp_curp_ix on empleado(curp);
create index emp_empleados_ix on empleado(nombre, ap_paterno, ap_materno);

-- Tabla avion
--create index avi_matricula_ix on avion(matricula);


-- Tabla aeropuerto
--create index aer_clave_ix on aeropuerto(clave);

-- Tabla vuelo
--create index vue_num_vuelo_ix on vuelo(num_vuelo);

-- Tabla pasajero
--create index pas_curp_ix on pasajero(curp);
create index pas_pasajeros_ix on pasajero(nombre, ap_paterno, ap_materno);

-- Validar unicidad
-- Tabla avion
--create unique index avi_matricula_iuk on avion(matricula);

-- Tabla empleado
--create unique index emp_curp_iuk on empleado(curp);
--create unique index emp_rfc_iuk on empleado(rfc);

-- Tabla vuelo 
--create unique index vue_num_vuelo_iuk on vuelo(num_vuelo);

-- Tabla aeropuerto
--create unique index aer_clave_iuk on aeropuerto(clave);

-- Tabla pase_abordar
create unique index pasabo_pasajero_vuelo_id_iuk on pase_abordar(pasajero_vuelo_id);

-- Tabla paquete
--create unique index paq_folio_iuk on paquete(folio);

-- Tabla pasajero
--create unique index pas_curp_iuk on pasajero(curp);

-- Tabla email_pasajero
--create unique index emapas_email_iuk on email_pasajero(email);
--create unique index emapas_emails_iuk on email_pasajero(num_email, pasajero_id);

-- Índices basados en el uso de funciones
-- Nombres y apellidos de pasajero y empĺeado en minúsculas
create index pas_pasajeros_min_ix on pasajero(lower(nombre), lower(ap_paterno), lower(ap_materno));
create index emp_empleados_min_ix on empleado(lower(nombre), lower(ap_paterno), lower(ap_materno));




