CREATE DATABASE clinic_db;
USE clinic_db;

-- 1. Tabla de Parámetros Generales / Configuración
CREATE TABLE parametros (
    id_parametro INTEGER AUTO_INCREMENT,
    codigo VARCHAR(20) NOT NULL,
    parametro VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_parametros PRIMARY KEY (id_parametro)
) COMMENT = 'Parámetros generales de configuración del sistema clínico';

-- 2. Tabla de Estados de la Cita / Atención
CREATE TABLE estados (
    id_estado INTEGER AUTO_INCREMENT,
    estado VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_estados PRIMARY KEY (id_estado)
) COMMENT = 'Estados posibles de una hora médica: reservada, confirmada, atendida, cancelada';

-- 3. Tabla de Especialidades Médicas
CREATE TABLE especialidades (
    id_especialidad INTEGER AUTO_INCREMENT,
    especialidad VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NULL,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_especialidades PRIMARY KEY (id_especialidad)
) COMMENT = 'Listado de especialidades médicas disponibles en la clínica';

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
) COMMENT = 'Información personal de los pacientes';

-- 5. Tabla de Profesionales / Médicos
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
) COMMENT = 'Listado de médicos y profesionales de la salud';

-- 6. Tabla de Horarios / Jornadas de Atención de los Profesionales
CREATE TABLE horarios_atencion (
    id_horario INTEGER AUTO_INCREMENT,
    id_profesional INTEGER NOT NULL,
    dia_semana TINYINT NOT NULL, -- 1: Lunes, 2: Martes, ..., 7: Domingo
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    duracion_bloque_minutos INT NOT NULL DEFAULT 30,
    habilitado TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_horarios_atencion PRIMARY KEY (id_horario),
    CONSTRAINT fk_horarios_profesionales FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional)
) COMMENT = 'Jornadas y bloques de horarios de trabajo por profesional';

-- 7. Tabla de Citas / Horas Médicas Agendadas
CREATE TABLE citas (
    id_cita INTEGER AUTO_INCREMENT,
    id_paciente INTEGER NOT NULL,
    id_profesional INTEGER NOT NULL,
    id_estado INTEGER NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    observaciones VARCHAR(255) NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_citas PRIMARY KEY (id_cita),
    CONSTRAINT fk_citas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_citas_profesionales FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
    CONSTRAINT fk_citas_estados FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
) COMMENT = 'Reserva y registro histórico de las horas médicas';