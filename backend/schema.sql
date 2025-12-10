-- Pet Supply Shops Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS pet_supply_db;
USE pet_supply_db;

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Pet profiles table
CREATE TABLE IF NOT EXISTS pet_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    species VARCHAR(100) NOT NULL,
    breed VARCHAR(100),
    age INT,
    weight DECIMAL(5,2),
    medical_conditions TEXT,
    allergies TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id)
);

-- Insert sample data
INSERT INTO categories (name, description) VALUES
('Food', 'Pet food and nutrition products'),
('Toys', 'Pet toys and entertainment'),
('Grooming', 'Grooming supplies and accessories'),
('Health', 'Health and wellness products'),
('Bedding', 'Pet beds and bedding'),
('Accessories', 'Collars, leashes, and other accessories');

INSERT INTO pet_profiles (user_id, name, species, breed, age, weight) VALUES
('user1', 'Max', 'Dog', 'Golden Retriever', 3, 65.5),
('user1', 'Whiskers', 'Cat', 'Siamese', 2, 12.3),
('user2', 'Buddy', 'Dog', 'Labrador', 5, 78.2);
