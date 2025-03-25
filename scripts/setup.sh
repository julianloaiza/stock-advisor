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

# Verificar que el archivo .env existe
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

# Verificar que el archivo init-db.sql existe
if [ ! -f "sql/init-db.sql" ]; then
    echo -e "${RED}Error: Database initialization script not found.${NC}"
    echo -e "${YELLOW}The file sql/init-db.sql should be included in the repository.${NC}"
    exit 1
else
    echo -e "${GREEN}Database initialization script found.${NC}"
fi

echo -e "${GREEN}Setup completed successfully.${NC}"

# Preguntar si desea iniciar los servicios ahora
echo -e "${YELLOW}Do you want to start the services now? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Starting services...${NC}"
    ./scripts/start.sh
else
    echo -e "${BLUE}You can start the services later with: ./scripts/start.sh${NC}"
fi