#!/bin/bash
# Script para reiniciar los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Reiniciando Servicios        ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Preguntar si se desea eliminar los datos
echo -e "${YELLOW}¿Desea eliminar los datos existentes? (s/n)${NC}"
read -r response
if [[ "$response" =~ ^([sS][iI]|[sS])$ ]]; then
    echo -e "${BLUE}Eliminando servicios y datos...${NC}"
    docker-compose down -v
    echo -e "${BLUE}Iniciando servicios nuevamente...${NC}"
    docker-compose up -d
    echo -e "${GREEN}Servicios reiniciados exitosamente con datos limpios.${NC}"
else
    echo -e "${BLUE}Reiniciando servicios (manteniendo datos)...${NC}"
    docker-compose restart
    echo -e "${GREEN}Servicios reiniciados exitosamente.${NC}"
fi