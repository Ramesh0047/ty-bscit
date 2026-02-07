
-- Local Service Provider Booking System
-- Database: local_service_db
-- Compatible with MySQL / phpMyAdmin

CREATE DATABASE IF NOT EXISTS local_service_db;
USE local_service_db;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user','provider','admin') NOT NULL,
    area VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services Table
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Service Providers Table
CREATE TABLE service_providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    availability ENUM('yes','no') DEFAULT 'yes',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    service_id INT NOT NULL,
    booking_date DATE NOT NULL,
    status ENUM('requested','accepted','in_progress','completed','rejected') DEFAULT 'requested',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES service_providers(provider_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- Feedback Table
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- Default Admin Account
-- Email: admin@test.com
-- Password: password
INSERT INTO users (name, email, password, role, area)
VALUES (
    'Admin',
    'admin@test.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'admin',
    'Head Office'
);
