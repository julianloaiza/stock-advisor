#!/bin/bash
# remove.sh - Script para eliminar todos los contenedores, volúmenes y redes

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${RED}    Stock Advisor - Complete Removal            ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

echo -e "${YELLOW}WARNING: This action will remove all containers, volumes, and networks for the project.${NC}"
echo -e "${YELLOW}All stored data will be lost. This action cannot be undone.${NC}"
echo -e "${YELLOW}Are you sure you want to continue? (y/n)${NC}"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Removing all containers, volumes, and networks...${NC}"
    
    # Detener y eliminar contenedores y volúmenes
    docker-compose down -v || {
        echo -e "${RED}Error: Failed to remove services.${NC}"
        exit 1
    }
    
    echo -e "${GREEN}Complete removal successful.${NC}"
    echo -e "${BLUE}If you want to reinstall the project, run: ./setup.sh${NC}"
else
    echo -e "${BLUE}Operation canceled. Nothing has been removed.${NC}"
fi