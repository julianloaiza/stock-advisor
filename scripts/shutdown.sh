#!/bin/bash
# shutdown.sh - Script para apagar todos los servicios preservando los datos

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Shutting Down Services     ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Apagar servicios con Docker Compose
echo -e "${BLUE}Shutting down all services (preserving data)...${NC}"
docker-compose down || {
    echo -e "${RED}Error: Failed to shut down services.${NC}"
    exit 1
}

echo -e "${GREEN}Services shut down successfully.${NC}"
echo -e "${BLUE}All data has been preserved in Docker volumes.${NC}"
echo -e "${YELLOW}To restart the application, run: ./scripts/start.sh${NC}"