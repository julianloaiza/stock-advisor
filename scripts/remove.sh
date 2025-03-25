#!/bin/bash
# Script para eliminar todos los contenedores, volúmenes y redes

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${RED}    Stock Advisor - Eliminación Completa         ${NC}"
echo -e "${BLUE}=================================================${NC}"

echo -e "${YELLOW}ADVERTENCIA: Esta acción eliminará todos los contenedores, volúmenes y redes del proyecto.${NC}"
echo -e "${YELLOW}Todos los datos almacenados se perderán. Esta acción no se puede deshacer.${NC}"
echo -e "${YELLOW}¿Está seguro de querer continuar? (s/n)${NC}"
read -r response

if [[ "$response" =~ ^([sS][iI]|[sS])$ ]]; then
    echo -e "${BLUE}Eliminando todos los contenedores, volúmenes y redes...${NC}"
    
    # Detener y eliminar contenedores y volúmenes
    docker-compose down -v
    
    echo -e "${GREEN}Eliminación completa exitosa.${NC}"
    echo -e "${BLUE}Si desea volver a instalar el proyecto, ejecute: ./scripts/setup.sh${NC}"
else
    echo -e "${BLUE}Operación cancelada. No se ha eliminado nada.${NC}"
fi