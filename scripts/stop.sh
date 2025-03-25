#!/bin/bash
# stop.sh - Script para detener los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Stopping Services           ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Detener servicios con Docker Compose
echo -e "${BLUE}Stopping services...${NC}"
docker-compose stop || {
    echo -e "${RED}Error: Failed to stop services.${NC}"
    exit 1
}

echo -e "${GREEN}Services stopped successfully.${NC}"
echo -e "${BLUE}Data and containers remain intact.${NC}"
echo -e "${YELLOW}To restart services, run: ./start.sh${NC}"