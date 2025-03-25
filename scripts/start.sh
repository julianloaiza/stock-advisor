#!/bin/bash
# Script para iniciar los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Iniciando Servicios          ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Iniciar servicios con Docker Compose
echo -e "${BLUE}Iniciando servicios...${NC}"
docker-compose up -d

echo -e "${GREEN}Servicios iniciados exitosamente.${NC}"
echo -e "${BLUE}Para acceder a las aplicaciones:${NC}"
echo -e "${BLUE}- Frontend: http://localhost:5173${NC}"
echo -e "${BLUE}- API Backend: http://localhost:8080${NC}"
echo -e "${BLUE}- API Swagger: http://localhost:8080/swagger/index.html${NC}"
echo -e "${BLUE}- Admin CockroachDB: http://localhost:9090${NC}"