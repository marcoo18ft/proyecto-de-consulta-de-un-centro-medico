CREATE DATABASE clinic_db;
USE clinic_db;

-- 1. Tabla de Especialidades Médicas
CREATE TABLE especialidades (
    id_especialidad INTEGER AUTO_INCREMENT,
    especialidad VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_especialidades PRIMARY KEY (id_especialidad)
) COMMENT = 'Listado de especialidades médicas disponibles';

-- 2. Tabla de Profesionales
CREATE TABLE profesionales (
    id_profesional INTEGER AUTO_INCREMENT,
    rut VARCHAR(12) NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    id_especialidad INTEGER NOT NULL,
    telefono VARCHAR(15) NULL,
    email VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_profesionales PRIMARY KEY (id_profesional),
    CONSTRAINT uk_profesionales_rut UNIQUE (rut),
    CONSTRAINT fk_profesionales_especialidades FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
) COMMENT = 'Información de los profesionales de la salud';

-- 3. Tabla de Horarios de Atención
CREATE TABLE horarios_atencion (
    id_horario INTEGER AUTO_INCREMENT,
    id_profesional INTEGER NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    duracion_bloque_minutos INT NOT NULL DEFAULT 30,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_horarios_atencion PRIMARY KEY (id_horario),
    CONSTRAINT fk_horarios_profesionales FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional)
) COMMENT = 'Horarios y disponibilidad por fecha asignados a cada profesional';

-- 4. Tabla de Pacientes
CREATE TABLE pacientes (
    id_paciente INTEGER AUTO_INCREMENT,
    rut VARCHAR(12) NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(15) NULL,
    email VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_pacientes PRIMARY KEY (id_paciente),
    CONSTRAINT uk_pacientes_rut UNIQUE (rut)
) COMMENT = 'Registro de los pacientes de la clínica';

-- 5. Tabla de Estados
CREATE TABLE estados (
    id_estado INTEGER AUTO_INCREMENT,
    estado VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_estados PRIMARY KEY (id_estado)
) COMMENT = 'Estados posibles de una cita médica';

-- 6. Tabla de Citas Médicas
CREATE TABLE citas (
    id_cita INTEGER AUTO_INCREMENT,
    id_paciente INTEGER NOT NULL,
    id_profesional INTEGER NOT NULL,
    id_estado INTEGER NOT NULL,
    observaciones VARCHAR(255) NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_citas PRIMARY KEY (id_cita),
    CONSTRAINT fk_citas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_citas_profesionales FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
    CONSTRAINT fk_citas_estados FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
) COMMENT = 'Citas médicas agendadas';

-- 7. Tabla Ficha Paciente (Nueva)
CREATE TABLE fichas_pacientes (
    id_ficha INTEGER AUTO_INCREMENT,
    id_cita INTEGER NOT NULL,
    motivo TEXT NOT NULL,
    diagnostico TEXT NULL,
    tratamiento TEXT NULL,
    CONSTRAINT pk_fichas_pacientes PRIMARY KEY (id_ficha),
    CONSTRAINT fk_fichas_citas FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
) COMMENT = 'Ficha clínica asociada a la atención de una cita';