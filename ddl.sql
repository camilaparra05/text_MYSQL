CREATE DATABASE sakilacampus;
USE sakilacampus;


create table pais ( 
id_pais int primary key,
nombre varchar(50) not null
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);

create table ciudad(
id_ciudad int primary key,
nombre varchar(50) not null,
id_pais int not null,
foreign key (id_pais) references pais(id_pais),
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);



create table direccion( 
id_direccion int primary key,
direccion varchar(50),
direccion2 varchar(50),
didtrito varchar (20),
id_ciudad int not null,
codigo_postal varchar(10),
telefono varchar(20),
foreign key (id_ciudad) references ciudad(id_ciudad),
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);


create table cliente (
id_cliente int primary key ,
id_almacen int ,
nombre varchar (45),
apellidos varchar (45),
email varchar (45),
id_direccion int not null ,
activo tinyint(1),
fecha_creacion datetime,
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);



create table empleado(
id_empleado int primary key,
id_almacen int ,
nombre varchar (45),
apellidos varchar (45),
email varchar (45),
id_direccion int not null ,
activo tinyint(1),
imagen blob,
username varchar(16),
password varchar(40),
foreign key (id_direccion) references direccion(id_direccion),
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);


create table almacen (
id_almacen int primary key,
id_empleado_jefe int,
id_direccion int not null,
foreign key (id_direccion) references direccion(id_direccion),
ultima_actualizacion timestamp default current_timestamp on update current_timestamp);


create table idioma (
id_idioma int primary key,
nombre varchar (20),
ultima_actualizacion timestamp);

create table pelicula (
id_pelicula  int primary key,
titulo varchar(25),
descripcion text,
año_lanzamiento year,
id_idioma int not null,
id_idioma_original int not null,
duracion_alquiler tinyint unsigned ,
renta_rate decimal (4,2),
duracion smallint unsigned,
replacement_cost decimal (5,2),
clasificacion enum ('G','PG','PG-13','R','NC-17'),
caracteristicas_especificas varchar (50),
ultima_actualizacion timestamp);

create table inventario (
id_inventario int  primary key,
id_pelicula int not null,
id_almacen int not null,
ultima_actualizacion timestamp,
foreign key (id_pelicula) references pelicula(id_pelicula),
foreign key (id_almacen) references almacen (id_almacen));


create table alquiler (
id_alquiler int primary key,
id_inventario int not null,
fecha_alquiler datetime,
id_cliente int not null,
fecha_devolucion int not null,
id_empleado int not null, 
foreign key (id_inventario) references inventario(id_inventario),
foreign key (id_cliente) references cliente(id_cliente),
foreign key (id_empleado) references empleado(id_empleado),
ultima_actualizacion timestamp);



)




