-- Crear base de datos y usarla
CREATE DATABASE IF NOT EXISTS db_cadep;
USE db_cadep;

-- NOTA: Las tablas se borran en orden inverso para evitar errores de dependencias (claves foráneas)
DROP TABLE IF EXISTS tokens;
DROP TABLE IF EXISTS structureappointments;
DROP TABLE IF EXISTS weeks;
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS appointmentreports;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS patientareas;
DROP TABLE IF EXISTS archives;
DROP TABLE IF EXISTS relatives;
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS registereddonors;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS municipalities;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS states;

-- Eliminar los triggers antes de crear las tablas para evitar errores en recreaciones
DROP TRIGGER IF EXISTS donors_before_insert;
DROP TRIGGER IF EXISTS registereddonors_before_insert;


-- Tabla: departments
CREATE TABLE departments (
  id_department INT UNSIGNED NOT NULL PRIMARY KEY,
  name_department VARCHAR(40) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: municipalities
CREATE TABLE municipalities (
  id_municipality INT UNSIGNED NOT NULL PRIMARY KEY,
  id_department_municipality INT UNSIGNED,
  name_municipality VARCHAR(50) NULL,
  FOREIGN KEY (id_department_municipality) REFERENCES departments(id_department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: states
CREATE TABLE states (
  id_state BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_state VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: roles
CREATE TABLE roles (
  id_role INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_role VARCHAR(15) NULL,
  description_role TEXT NOT NULL,
  id_state_role BIGINT UNSIGNED,
  idcreate_user_role INT UNSIGNED,
  createdate_role DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_role INT UNSIGNED NOT NULL,
  updatedate_role DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_state_role) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: users
CREATE TABLE users (
  id_user INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_user VARCHAR(15) NULL,
  password_user VARCHAR(60) NULL,
  id_role_user INT UNSIGNED,
  id_state_user BIGINT UNSIGNED,
  idcreate_user_user INT UNSIGNED,
  createdate_user DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_user INT UNSIGNED NOT NULL,
  updatedate_user DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_role_user) REFERENCES roles(id_role),
  FOREIGN KEY (id_state_user) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: branches
CREATE TABLE branches (
  id_branch INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_branch VARCHAR(50) NULL,
  phone_branch VARCHAR(25) NOT NULL,
  id_municipality_branch INT UNSIGNED,
  id_department_branch INT UNSIGNED,
  id_state_branch BIGINT UNSIGNED,
  idcreate_user_branch INT UNSIGNED,
  createdate_branch DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_branch INT UNSIGNED NOT NULL,
  updatedate_branch DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_municipality_branch) REFERENCES municipalities(id_municipality),
  FOREIGN KEY (id_department_branch) REFERENCES departments(id_department),
  FOREIGN KEY (id_state_branch) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: areas
CREATE TABLE areas (
  id_area INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_area VARCHAR(30) NULL,
  description_area TEXT NOT NULL,
  duration_area TIME NULL DEFAULT '00:30:00',
  id_state_area BIGINT UNSIGNED,
  idcreate_user_area INT UNSIGNED,
  createdate_area DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_area INT UNSIGNED NOT NULL,
  updatedate_area DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_state_area) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: donors (Donadores no registrados)
CREATE TABLE donors (
  id_donor VARCHAR(20) NOT NULL PRIMARY KEY,
  id_donor_int INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  email_donor VARCHAR(255) NOT NULL,
  title_donor VARCHAR(50),
  firstname_donor VARCHAR(100) NOT NULL,
  lastname_donor VARCHAR(100) NOT NULL,
  country_donor VARCHAR(100) NOT NULL,
  zipcode_donor VARCHAR(20) NOT NULL,
  state_donor VARCHAR(100) NOT NULL,
  address_donor VARCHAR(255) NOT NULL,
  unit_donor VARCHAR(100),
  city_donor VARCHAR(100) NOT NULL,
  phone_donor VARCHAR(50),
  mobile_donor VARCHAR(50),
  createdate_donor DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_donor INT UNSIGNED,
  updatedate_donor DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: registereddonors (Donadores registrados)
CREATE TABLE registereddonors (
  id_registereddonor VARCHAR(20) NOT NULL PRIMARY KEY,
  id_registereddonor_int INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  email_registereddonor VARCHAR(255) NOT NULL UNIQUE,
  username_registereddonor VARCHAR(100) NOT NULL UNIQUE,
  password_registereddonor VARCHAR(256) NOT NULL,
  title_registereddonor VARCHAR(50),
  firstname_registereddonor VARCHAR(100) NOT NULL,
  lastname_registereddonor VARCHAR(100) NOT NULL,
  country_registereddonor VARCHAR(100) NOT NULL,
  zipcode_registereddonor VARCHAR(20) NOT NULL,
  state_registereddonor VARCHAR(100) NOT NULL,
  address_registereddonor VARCHAR(255) NOT NULL,
  unit_registereddonor VARCHAR(100),
  city_registereddonor VARCHAR(100) NOT NULL,
  phone_registereddonor VARCHAR(50),
  mobile_registereddonor VARCHAR(50),
  idcreate_user_registereddonor INT UNSIGNED,
  createdate_registereddonor DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_registereddonor INT UNSIGNED,
  updatedate_registereddonor DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Tabla: patients
CREATE TABLE patients (
  id_patient INT UNSIGNED NOT NULL PRIMARY KEY,
  cui_patient VARCHAR(15),
  firstname_patient VARCHAR(30),
  middlename_patient VARCHAR(30),
  thirdname_patient VARCHAR(30),
  lastname_patient VARCHAR(30),
  secondlastname_patient VARCHAR(30),
  thirdlastname_patient VARCHAR(30),
  birthdate_patient DATE,
  idbirth_department_patient INT UNSIGNED NOT NULL,
  idbirth_municipality_patient INT UNSIGNED NOT NULL,
  age_patient INT(3) NOT NULL,
  weight_patient DECIMAL(5,2) NOT NULL,
  schooling_patient VARCHAR(30) NOT NULL,
  phone_patient VARCHAR(25) NOT NULL,
  id_department_patient INT(2) UNSIGNED NOT NULL,
  id_municipality_patient INT(2) UNSIGNED NOT NULL,
  address_patient TEXT NOT NULL,
  gender_patient VARCHAR(10) NOT NULL,
  religion_patient VARCHAR(25) NOT NULL,
  maritalstatus_patient VARCHAR(20) NOT NULL,
  dependentfamily_patient BOOLEAN NOT NULL,
  reasonforconsultation_patient TEXT NOT NULL,
  referreddoctor_patient VARCHAR(60) NOT NULL,
  photo_url_patient VARCHAR(255) NULL,
  status_patient VARCHAR(50) NULL,
  reserved_until_patient DATETIME NULL,
  idcreate_user_patient INT UNSIGNED,
  id_branch_patient INT UNSIGNED NOT NULL,
  id_state_patient BIGINT UNSIGNED NOT NULL,
  createdate_patient DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_patient INT UNSIGNED NOT NULL,
  updatedate_patient DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (idbirth_department_patient) REFERENCES departments(id_department),
  FOREIGN KEY (idbirth_municipality_patient) REFERENCES municipalities(id_municipality),
  FOREIGN KEY (id_department_patient) REFERENCES departments(id_department),
  FOREIGN KEY (id_municipality_patient) REFERENCES municipalities(id_municipality),
  FOREIGN KEY (id_branch_patient) REFERENCES branches(id_branch),
  FOREIGN KEY (id_state_patient) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: donations (Donaciones)
CREATE TABLE donations (
  id_donation INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  donor_type_donation ENUM('S', 'R') NOT NULL,
  id_donor_donation VARCHAR(20) NOT NULL,
  amount_donation DECIMAL(10, 2) NOT NULL,
  currency_donation VARCHAR(10) NOT NULL,
  paymentmethod_donation VARCHAR(50),
  transactionid_donation VARCHAR(100),
  notes_donation TEXT,
  id_patient_donations INT UNSIGNED,
  idcreate_user_donation INT UNSIGNED,
  createdate_donation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_donation INT UNSIGNED,
  updatedate_donation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_patient_donations FOREIGN KEY (id_patient_donations) REFERENCES patients(id_patient)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: relatives
CREATE TABLE relatives (
  id_relative INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idprincipal_patient_relative INT UNSIGNED,
  idsecondary_patient_relative INT UNSIGNED,
  relationship_relative VARCHAR(30) NULL,
  idcreate_user_relative INT UNSIGNED,
  createdate_relative DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_relative INT UNSIGNED NOT NULL,
  updatedate_relative DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (idprincipal_patient_relative) REFERENCES patients(id_patient),
  FOREIGN KEY (idsecondary_patient_relative) REFERENCES patients(id_patient)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: employees
CREATE TABLE employees (
  id_employee INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cui_employee VARCHAR(15),
  firstname_employee VARCHAR(30),
  middlename_employee VARCHAR(30),
  thirdname_employee VARCHAR(30),
  lastname_employee VARCHAR(30),
  secondlastname_employee VARCHAR(30),
  thirdlastname_employee VARCHAR(30),
  profession_employee TEXT NOT NULL,
  phone_employee VARCHAR(25) NOT NULL,
  id_user_employee INT UNSIGNED NOT NULL,
  birthdate_employee DATE,
  idbirth_department_employee INT UNSIGNED NOT NULL,
  idbirth_municipality_employee INT UNSIGNED NOT NULL,
  age_employee INT(3) NOT NULL,
  id_department_employee INT(2) UNSIGNED NOT NULL,
  id_municipality_employee INT(2) UNSIGNED NOT NULL,
  address_employee TEXT NOT NULL,
  gender_employee VARCHAR(10) NOT NULL,
  maritalstatus_employee VARCHAR(20) NOT NULL,
  id_area_employee INT UNSIGNED NOT NULL,
  id_branch_employee INT UNSIGNED NOT NULL,
  id_state_employee BIGINT UNSIGNED NOT NULL,
  idcreate_user_employee INT UNSIGNED,
  createdate_employee DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_employee INT UNSIGNED NOT NULL,
  updatedate_employee DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user_employee) REFERENCES users(id_user),
  FOREIGN KEY (idbirth_department_employee) REFERENCES departments(id_department),
  FOREIGN KEY (idbirth_municipality_employee) REFERENCES municipalities(id_municipality),
  FOREIGN KEY (id_department_employee) REFERENCES departments(id_department),
  FOREIGN KEY (id_municipality_employee) REFERENCES municipalities(id_municipality),
  FOREIGN KEY (id_area_employee) REFERENCES areas(id_area),
  FOREIGN KEY (id_branch_employee) REFERENCES branches(id_branch),
  FOREIGN KEY (id_state_employee) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: archives
CREATE TABLE archives (
  id_archive INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_patient_archive INT UNSIGNED,
  idcreate_user_archive INT UNSIGNED,
  createdate_archive DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_archive INT UNSIGNED NOT NULL,
  updatedate_archive DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_patient_archive) REFERENCES patients(id_patient)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: appointments
CREATE TABLE appointments (
  id_appointment INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_employee_appointment INT UNSIGNED,
  date_appointment VARCHAR(100) NULL,
  id_state_appointment BIGINT UNSIGNED NOT NULL,
  idcreate_user_appointment INT UNSIGNED,
  createdate_appointment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_appointment INT UNSIGNED NOT NULL,
  updatedate_appointment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_employee_appointment) REFERENCES employees(id_employee),
  FOREIGN KEY (id_state_appointment) REFERENCES states(id_state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: appointmentreports (ligada a archives y appointments)
CREATE TABLE appointmentreports (
  id_appointmentreport INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_archive_appointmentreport INT UNSIGNED,
  id_appointment_appointmentreport INT UNSIGNED,
  objective_appointmentreport VARCHAR(100) NULL,
  observations_appointmentreport TEXT NULL,
  height_appointmentreport DECIMAL(5,2) NULL,
  weight_appointmentreport DECIMAL(5,2) NULL,
  idcreate_user_appointmentreport INT UNSIGNED,
  createdate_appointmentreport DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_appointmentreport INT UNSIGNED NOT NULL,
  updatedate_appointmentreport DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_archive_appointmentreport) REFERENCES archives(id_archive),
  FOREIGN KEY (id_appointment_appointmentreport) REFERENCES appointments(id_appointment)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: schedules
CREATE TABLE schedules (
  id_schedule INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  hour_schedule TIME NULL,
  idcreate_user_schedule INT UNSIGNED,
  createdate_schedule DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_schedule INT UNSIGNED NOT NULL,
  updatedate_schedule DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: weeks
CREATE TABLE weeks (
  id_week INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name_week VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: structureappointments
CREATE TABLE structureappointments (
  id_structureappointment INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_appointment_structureappointment INT UNSIGNED NOT NULL,
  id_user_structureappointment INT UNSIGNED NOT NULL,
  id_patient_structureappointment INT UNSIGNED NOT NULL,
  id_schedule_structureappointment INT UNSIGNED NOT NULL,
  id_week_structureappointment INT UNSIGNED NOT NULL,
  active_structureappointment BOOLEAN NOT NULL DEFAULT 1,
  idcreate_user_structureappointment INT UNSIGNED,
  createdate_structureappointment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_structureappointment INT UNSIGNED NOT NULL,
  updatedate_structureappointment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_appointment_structureappointment) REFERENCES appointments(id_appointment),
  FOREIGN KEY (id_user_structureappointment) REFERENCES users(id_user),
  FOREIGN KEY (id_patient_structureappointment) REFERENCES patients(id_patient),
  FOREIGN KEY (id_schedule_structureappointment) REFERENCES schedules(id_schedule),
  FOREIGN KEY (id_week_structureappointment) REFERENCES weeks(id_week)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: tokens
CREATE TABLE tokens (
  id_token INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_user_token INT UNSIGNED NOT NULL,
  token_token VARCHAR(255) NOT NULL,
  created_token TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  expires_token TIMESTAMP NOT NULL,
  active_token TINYINT(1) DEFAULT 1,
  ip_token VARCHAR(45) NULL,
  idcreate_user_token INT UNSIGNED,
  idupdater_user_token INT UNSIGNED,
  FOREIGN KEY (id_user_token) REFERENCES users(id_user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: patientareas 
CREATE TABLE patientareas (
  id_patientarea INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_patient_patientarea INT UNSIGNED,
  id_area_patientarea INT UNSIGNED,
  idcreate_user_patientarea INT UNSIGNED,
  createdate_patientarea DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idupdater_user_patientarea INT UNSIGNED NOT NULL,
  updatedate_patientarea DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (id_patient_patientarea) REFERENCES patients(id_patient),
  FOREIGN KEY (id_area_patientarea) REFERENCES areas(id_area)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Triggers para generar los IDs de donadores
DELIMITER $$
CREATE TRIGGER donors_before_insert
BEFORE INSERT ON donors
FOR EACH ROW
BEGIN
  DECLARE next_id INT;
  SELECT AUTO_INCREMENT
  INTO next_id
  FROM information_schema.tables
  WHERE table_name = 'donors' AND table_schema = DATABASE();
  SET NEW.id_donor = CONCAT('S', next_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER registereddonors_before_insert
BEFORE INSERT ON registereddonors
FOR EACH ROW
BEGIN
  DECLARE next_id INT;
  SELECT AUTO_INCREMENT
  INTO next_id
  FROM information_schema.tables
  WHERE table_name = 'registereddonors' AND table_schema = DATABASE();
  SET NEW.id_registereddonor = CONCAT('R', next_id);
END$$
DELIMITER ;

-- Índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_email_donor ON donors (email_donor);
CREATE INDEX idx_email_registereddonor ON registereddonors (email_registereddonor);
CREATE INDEX idx_username_registereddonor ON registereddonors (username_registereddonor);
CREATE INDEX idx_createdate_donation ON donations (createdate_donation);
CREATE INDEX idx_id_donor_donation ON donations (id_donor_donation, donor_type_donation);
CREATE INDEX idx_id_patient_donations ON donations (id_patient_donations);