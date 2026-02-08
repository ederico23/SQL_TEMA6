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
    Cod_provi number(2)constraint EMPLEADOS_PROVCOD_FK
        references PROVINCIAS(Cod_provi) on delete cascade, --si se elimina el"padre" se eliminan los "hijos"
    
    Cod_empre number(2) constraint EMPLEADOS_EMPRECOD_FK  
        references EMPRESAS(Cod_empre)

);

                    -- insertamos --
/*insert into EMPLEADOS (Cod_emple, nombre, apellido, salario)
values (300, 'Veronica', 'Lopez', 3000);*/ -- ERROR PORQUE METES MAS VALORES DE LO PERMITIDO

insert into EMPLEADOS (Cod_emple, nombre, apellido, salario)
values (30, 'Veronica', 'Lopez', 3000); -- se inserta la fila

/*insert into EMPLEADOS (Cod_emple, nombre, apellido, cod_empre, cod_provi)
values (10, 'Sergio', 'Perez', 10, 1);*/ --ERROR PORQUE NO EXISTE LA EMPRESA 10

insert into EMPLEADOS (Cod_emple, nombre, apellido, cod_empre, cod_provi)
values (10, 'Sergio', 'Perez', 20, 1);


/*6. Crea la tabla PROVINCIAS y PERSONAS con la estructura que se muestra a
continuación, en negrita la clave principal y codprovin referencia a cod_provincia.
Además pondremos la opción de BORRADO EN CASCADA.*/

create table PROVINCIAS
(
    cod_provincia number(2) constraint PROVINCIAS_COD_PK primary key,
    nom_provincia varchar(25) constraint PROVINCIAS_NOM_NN not null,
    poblacion number(7)
);


create table PERSONAS
(
    dni varchar2(9) constraint PERSONAS_COD_PK primary key,
    nombre varchar(10) constraint PERSONAS_NOM_NN not null,
    direccion varchar2(25) constraint PERSONAS_DIR_NN not null,
    codprovin number(2) constraint PERSONAS_PROV_FK 
        references PROVINCIAS(cod_provincia) on delete cascade
);



-- ERROR EJ6 --


/*7. Crear la tabla EJEMPLO1 y asignar a la columna fecha la fecha del sistema
DNI VARCHAR2(10)
NOMBRE VARCHAR2(30)
EDAD NUMBER(2)
FECHA DATE
Insertar una fila con los valores siguientes, 1234, PEPA, 21 sin la columna fecha,
comprobando después que efectivamente añade la fecha actual.
*/

create table EJEMPLO1
(
    dni varchar2(10) constraint EJEMPLO1_COD_PK primary key,
    nombre varchar2(30) constraint EJEMPLO1_NOM_NN not null,
    edad number(2) constraint EJEMPLO1_ED_NN not null,
    fecha date default sysdate   
        
);

insert into EJEMPLO1 (dni, nombre, edad)
values (123, 'PEPA', 21);

/*8. Crear la tabla EJEMPLO3 cuyas columnas y restricciones son las siguientes:
DNI VARCHAR2(10)
NOMBRE VARCHAR2(30)
EDAD NUMBER(2)
CURSO NUMBER
Restricciones
- El DNI no puede ser nulo
- La clave principal es le DNI
- La EDAD ha de estar comprendida entre 5 y 20 años
- El NOMBRE ha de estar en mayúsculas
- El curso sólo puede almacenar 1,2 o 3
Insertar: las filas siguientes y si da error indicar por qué:
1111 Pepe 4 1 (error) NOMBRE MAYÚSCULAS
1111 PEPE 10 2
2222 MARIA 12 5 (error) CURSO 1,2 O 3
2222 MARIA 12 2*/

create table EJEMPLO3 
(       
    dni varchar2(10) constraint EJEMPLO3_COD_PK primary key,
    nombre varchar2(30) constraint EJEMPLO3_NOM_NN not null 
        constraint EJEMPLO3_NOM_CH check (nombre = upper(nombre)),
    edad number(2) constraint EJEMPLO3_ED_CH check (edad between 5 and 20),
    curso number constraint EJEMPLO3_CUR_CH check (curso in (1,2,3))

);

/*insert into ejemplo3 (dni, nombre, edad, curso)
values (1111, 'Pepe', 4, 1);*/ --ERROR PQ LA EDAD ES <5--

insert into ejemplo3 (dni, nombre, edad, curso)
values (1111, 'PEPE', 10,2);

/*insert into ejemplo3 (dni, nombre, edad, curso)
values (2222, 'MARIA', 12, 5);*/ --ERRO PQ EL CURSO ES != 1,2 O 3--

insert into ejemplo3 (dni, nombre, edad, curso)
values (2222, 'MARIA', 12, 2);


/*9. Crea las tabla siguientes con lo campos y restricciones:
ALUMNOS
Codigo number (2 )PK
Nombre varchar2(25) obligatorio
MODULOS
Codigo number PK,
Nombre varchar2(25)
NOTAS
Cod_alumno number(2)
Cod_modulo number
Nota number(2),
(Cod-alumno, modulo) es la clave primaria
Nota ha de ser un número comprendido entre 0 y 10
Debe además tener dos campos que hacen referencia a la tabla MODULOS y
ALUMNOS*/

create table ALUMNO 
(

    cod_alum number(2) constraint ALUMNO_COD_PK primary key,
    nombre varchar2(25) constraint ALUMNO_NOM_NN not null

);

create table modulos
(

    cod_mod number constraint MODULOS_COD_PK primary key,
    nombre varchar2(25)

);

create table NOTAS (
    cod_alumn  number(2),
    cod_modulo number,
    nota number(2) constraint NOTAS_NOTA_CH check (nota BETWEEN 0 AND 10),
    -- Definimos la clave primaria compuesta (los dos juntos no pueden repetirse)
    CONSTRAINT NOTAS_PK PRIMARY KEY (cod_alumn, cod_modulo),
    -- Definimos las claves ajenas
    CONSTRAINT NOTAS_ALU_FK FOREIGN KEY (cod_alumn) REFERENCES ALUMNO(cod_alum),
    CONSTRAINT NOTAS_MOD_FK FOREIGN KEY (cod_modulo) REFERENCES MODULOS(cod_mod)
);