-- Week2 Assigment2

-- Create database
CREATE DATABASE medicare_db;
USE medicare_db;

-- Create Doctors 
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    consultation_fee DECIMAL(10,2) CHECK (consultation_fee > 0)
);

-- Insert 10 Doctors 
INSERT INTO Doctors
(doctor_id, doctor_name, specialization, consultation_fee)
VALUES
(1, 'Dr. Arjun Rao', 'Cardiology', 1000.00),
(2, 'Dr. Priya Sharma', 'Neurology', 1200.00),
(3, 'Dr. Rahul Verma', 'Orthopedics', 900.00),
(4, 'Dr. Sneha Reddy', 'Cardiology', 1100.00),
(5, 'Dr. Anil Kumar', 'Dermatology', 700.00),
(6, 'Dr. Kavya Singh', 'Pediatrics', 800.00),
(7, 'Dr. Rohit Patel', 'Neurology', 1300.00),
(8, 'Dr. Neha Gupta', 'Orthopedics', 950.00),
(9, 'Dr. Vikram Das', 'Dermatology', 750.00),
(10, 'Dr. Meera Nair', 'Pediatrics', 850.00);

-- Create Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Insert 10 patients
INSERT INTO Patients
(patient_id, patient_name, email)
VALUES
(1, 'Aarav Mehta', 'aarav@gmail.com'),
(2, 'Diya Sharma', 'diya@gmail.com'),
(3, 'Rohan Kumar', 'rohan@gmail.com'),
(4, 'Ananya Rao', 'ananya@gmail.com'),
(5, 'Ishaan Patel', 'ishaan@gmail.com'),
(6, 'Meera Singh', 'meera@gmail.com'),
(7, 'Aditya Verma', 'aditya@gmail.com'),
(8, 'Kavya Reddy', 'kavya@gmail.com'),
(9, 'Arjun Gupta', 'arjun@gmail.com'),
(10, 'Sneha Nair', 'sneha@gmail.com');

-- Create Appointements
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert 10 Appointments
INSERT INTO Appointments
(appointment_id, doctor_id, patient_id, appointment_date)
VALUES
(1, 1, 1, '2026-08-10'),
(2, 2, 2, '2026-08-11'),
(3, 3, 3, '2026-08-12'),
(4, 4, 4, '2026-08-13'),
(5, 5, 5, '2026-08-14'),
(6, 6, 6, '2026-08-15'),
(7, 7, 7, '2026-08-16'),
(8, 8, 8, '2026-08-17'),
(9, 9, 9, '2026-08-18'),
(10, 10, 10, '2026-08-19');

-- Display all tables 
SELECT * FROM Doctors;

SELECT * FROM Patients;

SELECT * FROM Appointments;

-- INNER JOIN 
SELECT
    p.patient_name,
    d.doctor_name,
    d.specialization,
    a.appointment_date
FROM Appointments a
INNER JOIN Patients p
    ON a.patient_id = p.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;
    
  -- COUNT() + GROUP BY 
  SELECT
    specialization,
    COUNT(*) AS total_doctors
FROM Doctors
GROUP BY specialization;

-- Create Doctor_History 
CREATE TABLE Doctor_History (
    history_id INT PRIMARY KEY,
    doctor_id INT,
    action VARCHAR(100),
    action_date DATE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Transaction 
START TRANSACTION;

INSERT INTO Doctors
(doctor_id, doctor_name, specialization, consultation_fee)
VALUES
(11, 'Dr. Vikash Rao', 'Cardiology', 1150.00);

INSERT INTO Doctor_History
(history_id, doctor_id, action, action_date)
VALUES
(1, 11, 'New Doctor Registered', CURDATE());

COMMIT;

-- Check the transaction 
SELECT * FROM Doctors;

SELECT * FROM Doctor_History;

-- Create INDEX on Specialization 
CREATE INDEX idx_specialization
ON Doctors(specialization);

-- Search doctors by speicalization 
SELECT *
FROM Doctors
WHERE specialization = 'Cardiology';