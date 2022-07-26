
DROP TABLE USUARIO CASCADE CONSTRAINTS;
DROP TABLE TELEFONO CASCADE CONSTRAINTS;
DROP TABLE AREA CASCADE CONSTRAINTS;
DROP TABLE GRIFO CASCADE CONSTRAINTS;
DROP TABLE INFORMACION CASCADE CONSTRAINTS;
DROP TABLE VEHICULO CASCADE CONSTRAINTS;
DROP TABLE CHOFERES CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE FACTURA CASCADE CONSTRAINTS;
DROP TABLE PROVEEDOR CASCADE CONSTRAINTS;

CREATE TABLE AREA(
codigo_area varchar2(20) PRIMARY KEY,
nombre varchar2(50),
telefono varchar2(12)
);
CREATE TABLE USUARIO(
codigo_usuario varchar2(20) PRIMARY KEY,
cargo varchar2(30),
correo varchar2(25),
nombre varchar2(50),
contraseña varchar2(20),
cod_area references area
);
CREATE TABLE TELEFONO(
numero_telefonico varchar2(12),
cod_usuario references usuario,
PRIMARY KEY(numero_telefonico,cod_usuario)
);


CREATE TABLE GRIFO(
codigo_grifo varchar2(20) PRIMARY KEY,
nombre varchar2(20),
direccion varchar2(50) ,
capacidad_tanque number(20)
);

CREATE TABLE INFORMACION(
cod_area references area,
cod_grifo references grifo,
asignar_precio number(15),
stock number(15),
registrar_ventas number(15),
primary key(cod_area,cod_grifo)
);

CREATE TABLE VEHICULO(
placa varchar2 (8)primary key,
gps varchar2 (20),
documentos varchar2(70),
permisos varchar2(50),
cod_grifo references grifo
);


CREATE TABLE CHOFERES(
dni varchar2 (8) primary key,
nombre varchar2(50),
licencia varchar2(10),
edad number(2),
telefono varchar2(12),
placa references vehiculo
);
CREATE TABLE PRODUCTO(
codigo_producto varchar2(15) primary key,
control_calidad varchar2(50),
nombre varchar2(100),
cantidad_barriles number(20),
placa references vehiculo
);

CREATE TABLE FACTURA(
codigo_factura varchar2(15) primary key,
num_guia varchar2(20),
scop varchar2(10),
importe number(20),
cantidad number(15),
precio_unitario number(20),
unidad_medicion varchar2(50)
);
CREATE TABLE PROVEEDOR(
ruc varchar2(15) primary key,
direccion varchar2(70),
horario_atencion date,
disponibilidad varchar(30),
cod_producto references producto,
cod_factura references factura,
cod_area references area
);


INSERT INTO area VALUES ('A2025','Administrativa','987368141');
INSERT INTO area VALUES ('P2020','Pedidos','976331315');
INSERT INTO area VALUES ('C2121','Comercial','996109601');
INSERT INTO area VALUES ('PL2222','Planificacion','985348713');
INSERT INTO usuario VALUES ('AL1010','Asistente Administrativo','armandodel16@hotmail.com','Armando Lopez','AL123','A2025');
INSERT INTO usuario VALUES ('GP1515','Asesor de ventas','Fiel2022@gmail.com','Giancarlo Pacotaype','GP123','P2020');
INSERT INTO usuario VALUES ('EC1212','Soporte Comercial','ivan20@hotmail.com','Enrique Castro','EC123','C2121');
INSERT INTO usuario  VALUES ('RS1919','Planeador Logistico','richi@gmail.com','Ricardo Silva','RS123','PL2222');
INSERT INTO Grifo VALUES ('Gr12','Repsol-1','Los helechos 231',800);
INSERT INTO Grifo VALUES ('Gr13','Repsol-2','Escandio 1012',900);
INSERT INTO informacion VALUES ('A2025','Gr12','',500,'');
INSERT INTO informacion VALUES ('C2121','Gr12',25.3,'','');
INSERT INTO informacion VALUES ('P2020','Gr12','','',700);
INSERT INTO VEHICULO VALUES ('AGB303','A150341','revision tecnica','En regla','Gr12');
INSERT INTO PRODUCTO VALUES ('GAS2525','Pasó Controles','Gasolina90','','AGB303');
INSERT INTO PROVEEDOR VALUES ('2076742324B','Jiron AYACUCHO 235','','completa','GAS2525','','A2025');

SELECT *FROM PRODUCTO;



commit work;

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION getNombreCodigo(codId USUARIO.CODIGO_USUARIO%TYPE)
RETURN VARCHAR2
AS
    NombreCodigo VARCHAR2(100);
BEGIN
    SELECT  nombre || ' ' || codigo_usuario|| ''|| ' Pertenece al área'|| cod_area
    INTO NombreCodigo
    FROM USUARIO
    WHERE  codigo_usuario = codId ;
    
    RETURN NombreCodigo;
END;

--Pruebas de la funcion
BEGIN
    DBMS_OUTPUT.PUT_LINE(UPPER(getNombreCodigo('AL1010')));
END;

select *from informacion;

SELECT ASIGNAR_PRECIO FROM INFORMACION WHERE COD_AREA = 'C2121';

