-- MySQL schema for Pet Supply Shops
-- Run: mysql -u root -p < schema.sql

CREATE DATABASE IF NOT EXISTS pet_supply_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pet_supply_db;

-- Users table (owners)
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(200) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Categories
CREATE TABLE IF NOT EXISTS categories (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(64) DEFAULT '',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Pet profiles
CREATE TABLE IF NOT EXISTS pet_profiles (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  name VARCHAR(120) NOT NULL,
  type VARCHAR(80) DEFAULT '',
  breed VARCHAR(120) DEFAULT '',
  birthday DATE NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Optional seed data (uncomment to insert)
INSERT INTO users (name, email) VALUES ('Test User', 'test@example.com');
-- INSERT INTO categories (name, icon) VALUES ('Food', '🍖'), ('Toys', '🧸');
