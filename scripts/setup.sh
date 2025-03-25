#!/bin/bash
# Script para configuración inicial

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Configuración Inicial        ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker no está instalado.${NC}"
    exit 1
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose no está instalado.${NC}"
    exit 1
fi

# Crear directorios necesarios
echo -e "${BLUE}Creando directorios necesarios...${NC}"
mkdir -p repositories

# Copiar .env si no existe
if [ ! -f .env ]; then
    echo -e "${BLUE}Creando archivo .env...${NC}"
    cp .env.example .env
    echo -e "${GREEN}Archivo .env creado exitosamente.${NC}"
else
    echo -e "${YELLOW}El archivo .env ya existe, se mantiene su configuración.${NC}"
fi

# Clonar repositorios si no existen
if [ ! -d "repositories/stock-advisor-backend" ]; then
    echo -e "${BLUE}Clonando repositorio del backend...${NC}"
    git clone https://github.com/julianloaiza/stock-advisor-backend.git repositories/stock-advisor-backend
    echo -e "${GREEN}Repositorio del backend clonado exitosamente.${NC}"
else
    echo -e "${YELLOW}El repositorio del backend ya existe.${NC}"
fi

if [ ! -d "repositories/stock-advisor-frontend" ]; then
    echo -e "${BLUE}Clonando repositorio del frontend...${NC}"
    git clone https://github.com/julianloaiza/stock-advisor-frontend.git repositories/stock-advisor-frontend
    echo -e "${GREEN}Repositorio del frontend clonado exitosamente.${NC}"
else
    echo -e "${YELLOW}El repositorio del frontend ya existe.${NC}"
fi

echo -e "${GREEN}Configuración inicial completada exitosamente.${NC}"
echo -e "${YELLOW}Para iniciar los servicios, ejecute: ./scripts/start.sh${NC}"