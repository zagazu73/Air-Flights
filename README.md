Air-Flights
===========

En este proyecto, se realiza la creación de una **base de datos** a partir de un caso de estudio.

Se estudia lo siguiente:
1. Abstracción de [reglas de negocio](https://github.com/LuisAxel/Air-Flights/blob/main/Requerimientos/Caso%20de%20estudio.pdf).
2. Elaboración de un [modelo Entidad-Relación](https://github.com/LuisAxel/Air-Flights/blob/main/Modelos/Air%20Flights%20ER.png) con la *notación de Chen*.
3. Elaboración de un [modelo relacional](https://github.com/LuisAxel/Air-Flights/blob/main/Modelos/Air%20Flights%20R.jpg) en [ERSTUDIO](https://github.com/LuisAxel/Air-Flights/blob/main/Modelos/Air%20Flights.DM1).
4. Elaboración de una base de datos relacional.
    + Definición de [usuarios y roles](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-01-usuarios.sql).
    + Asignación de [privilegios](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-01-usuarios.sql).
    + Elaboración de [entidades](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-02-entidades.sql), [tablas temporales](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-03-tablas-temporales.sql), [tablas externas](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-04-tablas-externas.sql).
    + Uso de [secuencias](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-05-secuencias.sql) para generación de identificadores.
    + Definción de [índices](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-06-indices.sql) para mejorar desempeño en búsquedas.
    + Definición de [sinónimos](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-07-sinonimos.sql) privados y públicos.
    + Elaboración de [vistas](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-08-vistas.sql) para ocultar datos sensibles, funciones de agregación y unión de tablas.
    + Elaboración de [consultas](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-10-consultas.sql) con subconsultas, diferentes tipos de join, funciones de agregación, operadores booleanos y consultas a tablas externas.
    + Definición de [triggers](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-11-triggers) para implementar reglas de negocio, generación de históricos o registros para tablas con atributos derivados.
    + Definición de [procedimientos](https://github.com/LuisAxel/Air-Flights/Scripts/s-13-procedimientos) para exportar datos o utilizar la tabla temporal.
    + Definición de [funciones](https://github.com/LuisAxel/Air-Flights/Scripts/s-15-funciones) para realizar calculo de bonos, tiempos de espera o desempeño de aeropuertos.
    + Pruebas automatizadas para revisar la correcta implementación de [triggers](https://github.com/LuisAxel/Air-Flights/Scripts/s-12-pruebas-triggers), [funciones](https://github.com/LuisAxel/Air-Flights/Scripts/s-16-pruebas-funciones) y [procedimientos](https://github.com/LuisAxel/Air-Flights/Scripts/s-14-pruebas-procedimientos).
    + Soporte para [carga de datos de tipo blob](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-17-lob-carga_fotos_empleado.sql).
    + [Prueba automatizada](https://github.com/LuisAxel/Air-Flights/blob/main/Scripts/s-18-lob-carga_fotos_empleado-prueba.sql) para la verificación de carga correcta de datos de tipo blob.

