#!/bin/bash
# Script para detener los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Deteniendo Servicios         ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Detener servicios con Docker Compose
echo -e "${BLUE}Deteniendo servicios...${NC}"
docker-compose stop

echo -e "${GREEN}Servicios detenidos exitosamente.${NC}"
echo -e "${BLUE}Los datos y contenedores permanecen intactos.${NC}"
echo -e "${BLUE}Para reiniciar, use: ./scripts/start.sh${NC}"