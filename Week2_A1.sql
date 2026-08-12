-- Week2 Assignments1

-- Create database
CREATE DATABASE skytrack_db;
USE skytrack_db;

-- Create Flights Table
CREATE TABLE Flights (
flight_id INT PRIMARY KEY,
flight_number VARCHAR(20) UNIQUE NOT NULL,
source VARCHAR(50) NOT NULL,
destination VARCHAR(50) NOT NULL,
departure_date DATE NOT NULL,
ticket_price DECIMAL(10,2) check (ticket_price > 0)
);

-- Insert 10 Flights
INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(1, 'SK101', 'Hyderabad', 'Delhi', '2026-08-10', 4500.00),
(2, 'SK102', 'Mumbai', 'Delhi', '2026-08-11', 5200.00),
(3, 'SK103', 'Chennai', 'Bangalore', '2026-08-12', 3000.00),
(4, 'SK104', 'Hyderabad', 'Mumbai', '2026-08-13', 4800.00),
(5, 'SK105', 'Delhi', 'Kolkata', '2026-08-14', 5500.00),
(6, 'SK106', 'Bangalore', 'Hyderabad', '2026-08-15', 3500.00),
(7, 'SK107', 'Pune', 'Delhi', '2026-08-16', 4200.00),
(8, 'SK108', 'Kolkata', 'Mumbai', '2026-08-17', 6000.00),
(9, 'SK109', 'Chennai', 'Delhi', '2026-08-18', 5800.00),
(10, 'SK110', 'Hyderabad', 'Bangalore', '2026-08-19', 3200.00);

-- Create Passengers table
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Insert 10 Passengers
INSERT INTO Passengers
(passenger_id, passenger_name, email)
VALUES
(1, 'Anil Kumar', 'anil@gmail.com'),
(2, 'Priya Sharma', 'priya@gmail.com'),
(3, 'Rahul Verma', 'rahul@gmail.com'),
(4, 'Sneha Reddy', 'sneha@gmail.com'),
(5, 'Arjun Rao', 'arjun@gmail.com'),
(6, 'Kavya Singh', 'kavya@gmail.com'),
(7, 'Rohit Patel', 'rohit@gmail.com'),
(8, 'Neha Gupta', 'neha@gmail.com'),
(9, 'Vikram Das', 'vikram@gmail.com'),
(10, 'Meera Nair', 'meera@gmail.com');

-- Create Bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATE NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Insert 10 Bookings 
INSERT INTO Bookings
(booking_id, passenger_id, flight_id, booking_date)
VALUES
(1, 1, 1, '2026-08-01'),
(2, 2, 2, '2026-08-01'),
(3, 3, 3, '2026-08-02'),
(4, 4, 4, '2026-08-02'),
(5, 5, 5, '2026-08-03'),
(6, 6, 6, '2026-08-03'),
(7, 7, 7, '2026-08-04'),
(8, 8, 8, '2026-08-04'),
(9, 9, 9, '2026-08-05'),
(10, 10, 10, '2026-08-05');

-- Display all table contents
SELECT * FROM Flights;

SELECT * FROM Passengers;

SELECT * FROM Bookings;

-- INNER JOIN
SELECT
    p.passenger_name,
    f.flight_number,
    f.source,
    f.destination
FROM Bookings b
INNER JOIN Passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id;

-- COUNT() + GROUP BY
SELECT
    destination,
    COUNT(*) AS total_flights
FROM Flights
GROUP BY destination;

-- Create Flight_History
CREATE TABLE Flight_History (
    history_id INT PRIMARY KEY,
    flight_id INT,
    action VARCHAR(50),
    action_date DATE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Transaction
START TRANSACTION;

INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(11, 'SK111', 'Delhi', 'Hyderabad', '2026-08-20', 5000.00);

INSERT INTO Flight_History
(history_id, flight_id, action, action_date)
VALUES
(1, 11, 'New Flight Added', CURDATE());

COMMIT;

-- Check the results 
SELECT * FROM Flights;

SELECT * FROM Flight_History;

-- Create INDEX on flight_number
CREATE INDEX idx_flight_number
ON Flights(flight_number);

-- Search by Flight Number
SELECT *
FROM Flights
WHERE flight_number = 'SK105';
