-- ==========================================================
-- Script de inicialización de la base de datos segura
-- ==========================================================

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS stock_db;

-- Crear usuario con privilegios limitados
CREATE USER IF NOT EXISTS stock_user WITH PASSWORD 'stock_secure_password';

-- Otorgar privilegios específicos al usuario
GRANT CONNECT ON DATABASE stock_db TO stock_user;
GRANT USAGE ON SCHEMA public TO stock_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO stock_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO stock_user;

-- Establecer privilegios por defecto para tablas futuras
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO stock_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO stock_user;