CREATE DATABASE hospital;

USE  hospital;



CREATE TABLE MEDICO
(
    rut INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(100),
    salario INT,
    especialidad VARCHAR(50),
    fecharegistro DATE

);


CREATE TABLE Paciente

(
    rut INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE(30) NOT NULL,
    email VARCHAR(100) UNIQUE,
    teléfono VARCHAR(100) UNIQUE
   
);
