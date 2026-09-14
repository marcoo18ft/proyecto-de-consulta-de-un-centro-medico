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


INSERT INTO MEDICO (rut, nombre, apellido, email, ciudad, salario, especialidad, fecharegistro)
VALUES ("22.465.271-3", "pepito", "gonzales"," pepito.gonzales@gmail.com", "temuco", 1500000, "neuro_cirugia", "17-06-1990");

NH