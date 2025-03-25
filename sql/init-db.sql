-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS stock_db;

-- Crear usuario sin contraseña (modo inseguro)
CREATE USER IF NOT EXISTS stock_user;

-- Otorgar permisos completos sobre la base de datos
GRANT ALL ON DATABASE stock_db TO stock_user;

-- Otorgar permisos en el esquema public
GRANT ALL ON SCHEMA public TO stock_user;

-- Establecer permisos para tablas futuras
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO stock_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO stock_user;