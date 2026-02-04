-- creamos la tabla --

CREATE TABLE PROVINCIAS
(   
 --nombre de la variable.  tipo de dato.  contraint nombreTabla_tipoDeId_tipoClave--
    Cod_provi number(2) constraint PROVINCIAS_COD_PK primary key,
    Nombre varchar(25) constraint PROVINCIAS_NOM_NN not null,
    Pais varchar2(25) constraint PROVINCIAS_PAIS_CH check (Pais in("España" , "Portugal", "Italia"))
    
)     