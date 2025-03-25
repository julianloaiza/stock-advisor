#!/bin/bash
# reset.sh - Script para reiniciar los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Resetting Services          ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Preguntar si se desea eliminar los datos
echo -e "${YELLOW}Do you want to delete existing data? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Removing services and data...${NC}"
    docker-compose down -v || {
        echo -e "${RED}Error: Failed to remove services and data.${NC}"
        exit 1
    }
    echo -e "${BLUE}Starting services again...${NC}"
    docker-compose up -d || {
        echo -e "${RED}Error: Failed to start services.${NC}"
        exit 1
    }
    echo -e "${GREEN}Services restarted successfully with clean data.${NC}"
else
    echo -e "${BLUE}Restarting services (keeping data)...${NC}"
    docker-compose restart || {
        echo -e "${RED}Error: Failed to restart services.${NC}"
        exit 1
    }
    echo -e "${GREEN}Services restarted successfully.${NC}"
fi