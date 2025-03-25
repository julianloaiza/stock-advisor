#!/bin/bash
# setup.sh - Script para configuración inicial

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Initial Setup               ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed.${NC}"
    exit 1
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Crear directorios necesarios
echo -e "${BLUE}Creating necessary directories...${NC}"
mkdir -p repositories
mkdir -p sql

# Verificar y copiar .env.example a .env si es necesario
if [ ! -f .env.example ]; then
    echo -e "${RED}Error: .env.example file not found.${NC}"
    exit 1
fi

if [ ! -f .env ]; then
    echo -e "${BLUE}Creating .env file from example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}Successfully created .env file.${NC}"
else
    echo -e "${YELLOW}The .env file already exists. Keeping current configuration.${NC}"
fi

# Clonar repositorios si no existen
if [ ! -d "repositories/stock-advisor-backend" ]; then
    echo -e "${BLUE}Cloning backend repository...${NC}"
    git clone https://github.com/julianloaiza/stock-advisor-backend.git repositories/stock-advisor-backend || {
        echo -e "${RED}Error: Failed to clone backend repository.${NC}"
        exit 1
    }
    echo -e "${GREEN}Backend repository successfully cloned.${NC}"
else
    echo -e "${YELLOW}Backend repository already exists.${NC}"
fi

if [ ! -d "repositories/stock-advisor-frontend" ]; then
    echo -e "${BLUE}Cloning frontend repository...${NC}"
    git clone https://github.com/julianloaiza/stock-advisor-frontend.git repositories/stock-advisor-frontend || {
        echo -e "${RED}Error: Failed to clone frontend repository.${NC}"
        exit 1
    }
    echo -e "${GREEN}Frontend repository successfully cloned.${NC}"
else
    echo -e "${YELLOW}Frontend repository already exists.${NC}"
fi

# Crear archivo init-db.sql si no existe
if [ ! -f "sql/init-db.sql" ]; then
    echo -e "${BLUE}Creating database initialization script...${NC}"
    # Crear contenido para el archivo init-db.sql
    cat > sql/init-db.sql << 'EOF'
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
EOF
    echo -e "${GREEN}Database initialization script created successfully.${NC}"
fi

echo -e "${GREEN}Setup completed successfully.${NC}"
echo -e "${YELLOW}To start the services, run: ./start.sh${NC}"