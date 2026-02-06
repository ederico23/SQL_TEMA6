/*EJERCICIO 1 Crea la tabla PROVINCIAS con los siguientes campos
Cod_provi de tipo number(2) y es la clave primaria
Nombre de tipo varchar2(25), es obligatorio
Pais de tipo varchar2(25) debe ser uno de los siguientes España, Portugal o Italia
Introduce la provincia 1 Ávila de España */
CREATE TABLE PROVINCIAS
(   
 --nombre de la variable.  tipo de dato.  contraint nombreTabla_tipoDeId_tipoClave--
    Cod_provi number(2) constraint PROVINCIAS_COD_PK primary key,
    Nombre varchar(25) constraint PROVINCIAS_NOM_NN not null,
    Pais varchar2(25),
    constraint PROVINCIAS_PAIS_CH check (Pais in( 'España' , 'Portugal', 'Italia'))
);     


insert into PROVINCIAS (Cod_provi, Nombre, Pais)
values (1, 'Avila' , 'España');
select * from PROVINCIAS;



/*2. Crea la tabla EMPRESAS con los siguientes campos:
Cod_empre number(2) es la clave
Nombre varchar2(25) obligatorio por defecto será empresa1
Fecha_crea de tipo fecha por defecto será un dia posterior a la fecha actual.
Introduce la empresa 20 llamada Alfa21 S.A.*/

create table EMPRESAS 
(
    Cod_empre number(2) constraint EMPRESAS_COD_PK primary key,
    Nombre varchar2(25) default 'empresa1' constraint EMPRESAS_NOM_NN not null,
    Fecha_crea date default sysdate+ 1
);

insert into EMPRESAS (Cod_empre, Nombre)
values (20, 'Alpha21 S.A.');

select * from EMPRESAS;


/*3. Crea la tabla CONTINENTES con los siguientes campos
Cod_conti de tipo number y es la clave primaria
Nombre de tipo varchar2(20) el valor por defecto es EUROPA y es obligatorio*/

create table CONTINTENTES
(
    Cod_conti number constraint CONTINENTES_COD_PK primary key,
    Nombre varchar2(20) default 'EUROPA' constraint CONTINENTES_NOM_NN not null
);

/*4. Crea la tabla ALUMNOS con los siguientes campos
codigo number(3) y es la clave primaria
nombre cadena de caracteres de longitud máxima 21, es obligatorio
apellido cadena de caracteres de longitud máxima 30, es obligatorio y ha de
estar en mayúsculas.
Curso de tipo number y ha de ser 1,2 o 3
Fecha_matri de tipo fecha y por defecto es la fecha actual*/

create table ALUMNOS
(
    codigo number(3) constraint ALUMNOS_COD_PK primary key,
    nombre varchar(21) constraint ALUMNOS_NOM_NN not null,
    apellido varchar(30) constraint ALUMNOS_APLL_NN not null 
        constraint ALUMNOS_APLL_CH check (apellido = UPPER(apellido)),
    Curso number constraint ALUMNOS_NUM_CH check (curso IN(1,2,3)),
    Fecha_matri date default sysdate
);


/*5. Crea la tabla EMPLEADOS con los siguientes campos
Cod_emple number(2) y es clave
Nombre cadena de caracteres de longitud máxima 20 y es obligatorio
Apellido cadena de caracteres de longitud máxima 25
Salario número de 7 cifras con dos decimales debe ser mayor que 0
Además tiene dos campos que son claves ajenas de las tablas provincias y
empresas respectivamente. Para la clave ajena de provincias indicaremos un
borrado en cascada.
NOTA: EN TOTAL DEBE HABER SEIS CAMPOS
Introduce en la tabla EMPLEADOS, la empleada 300 de nombre Veronica Lopez y
salario 3000 ¿Qué ocurre?¿Por qué?
Introduce los mismos datos que antes pero el código del empleado será 30.
Introduce en la tabla EMPLEADOS el empleado 10 llamado Sergio Perez que trabaja
para la empresa de código 10 en la provincia 1 ¿Qué ocurre?¿Porqué?
Introduce en la tabla EMPLEADOS el empleado 10 llamado Sergio Perez que trabaja
para la empresa Alfa21 y vive en Ávila.
*/


create table EMPLEADOS
(

    Cod_emple number(2) constraint EMPLEADOS_COD_PK primary key,
    Nombre varchar(20) constraint EMPLEADOS_NOM_NN not null, 
    Apellido varchar(25),
    -- number(digitos max, decimales max)
    Salario number(7,2) constraint EMPLEADOS_NOM_CH check (salario>0),
    
    -- claves ajenas
    Cod_provi number(2)constraint EMPLEADOS_PROVCOD_FK foreign key (Cod_provi)
        references PROVINICIAS(Cod_provi) on delete cascade, --si se elimina el"padre" se eliminan los "hijos"
    
    Cod_empre number(2) constraint EMPLEADOS_EMPRECOD_FK foreign key (Cod_empre)   
        references EMPRESAS(Cod_empre)

);
