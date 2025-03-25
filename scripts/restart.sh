#!/bin/bash
# restart.sh - Script para reiniciar servicios preservando datos pero recargando configuración

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Restarting Services         ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Detener servicios preservando volúmenes
echo -e "${BLUE}Stopping services (preserving data)...${NC}"
docker-compose stop || {
    echo -e "${RED}Error: Failed to stop services.${NC}"
    exit 1
}

# Iniciar servicios (recargará variables de entorno)
echo -e "${BLUE}Starting services (with updated environment variables)...${NC}"
docker-compose up -d || {
    echo -e "${RED}Error: Failed to start services.${NC}"
    exit 1
}

echo -e "${GREEN}Services restarted successfully, data preserved.${NC}"
echo -e "${YELLOW}Any changes to .env files have been applied.${NC}"

# Obtener variables de entorno para mensajes
BACKEND_PORT=$(grep -oP 'BACKEND_PORT=\K[0-9]+' .env 2>/dev/null || echo "8080")
FRONTEND_PORT=$(grep -oP 'FRONTEND_PORT=\K[0-9]+' .env 2>/dev/null || echo "5173")
COCKROACH_UI_PORT=$(grep -oP 'COCKROACH_UI_PORT=\K[0-9]+' .env 2>/dev/null || echo "9090")

# Mostrar información de acceso a las aplicaciones
echo -e "${BLUE}Access the applications:${NC}"
echo -e "${BLUE}- Frontend: http://localhost:${FRONTEND_PORT}${NC}"
echo -e "${BLUE}- API Backend: http://localhost:${BACKEND_PORT}${NC}"
echo -e "${BLUE}- API Swagger: http://localhost:${BACKEND_PORT}/swagger/index.html${NC}"
echo -e "${BLUE}- CockroachDB Admin: http://localhost:${COCKROACH_UI_PORT}${NC}"