USE DATABASE hospital;

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



