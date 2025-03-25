#!/bin/bash
# start.sh - Script para iniciar los servicios

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}    Stock Advisor - Starting Services           ${NC}"
echo -e "${BLUE}=================================================${NC}"

# Verificar que docker-compose está disponible
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi

# Verificar si hay contenedores existentes y su estado
EXISTING_CONTAINERS=$(docker-compose ps -q 2>/dev/null)

if [ -n "$EXISTING_CONTAINERS" ]; then
    # Verificar si hay al menos un contenedor detenido
    STOPPED_CONTAINERS=$(docker-compose ps --services --filter "status=stopped" 2>/dev/null)
    
    if [ -n "$STOPPED_CONTAINERS" ]; then
        echo -e "${BLUE}Restarting previously stopped services...${NC}"
        docker-compose start || {
            echo -e "${YELLOW}Warning: Could not restart some services. Attempting to recreate...${NC}"
            docker-compose up -d || {
                echo -e "${RED}Error: Failed to start services.${NC}"
                echo -e "${YELLOW}Check if Docker is running and try again.${NC}"
                exit 1
            }
        }
    else
        # Verificar si hay contenedores en ejecución
        RUNNING_CONTAINERS=$(docker-compose ps --services --filter "status=running" 2>/dev/null)
        
        if [ -n "$RUNNING_CONTAINERS" ]; then
            echo -e "${YELLOW}Some services are already running.${NC}"
            echo -e "${BLUE}Ensuring all services are up...${NC}"
            docker-compose up -d || {
                echo -e "${RED}Error: Failed to start services.${NC}"
                echo -e "${YELLOW}Check if Docker is running and try again.${NC}"
                exit 1
            }
        fi
    fi
else
    # No hay contenedores, se inicia desde cero
    echo -e "${BLUE}Starting services...${NC}"
    docker-compose up -d || {
        echo -e "${RED}Error: Failed to start services.${NC}"
        echo -e "${YELLOW}Check if Docker is running and try again.${NC}"
        exit 1
    }
fi

# Obtener variables de entorno para mensajes
BACKEND_PORT=$(grep -oP 'BACKEND_PORT=\K[0-9]+' .env 2>/dev/null || echo "8080")
FRONTEND_PORT=$(grep -oP 'FRONTEND_PORT=\K[0-9]+' .env 2>/dev/null || echo "5173")
COCKROACH_UI_PORT=$(grep -oP 'COCKROACH_UI_PORT=\K[0-9]+' .env 2>/dev/null || echo "9090")

echo -e "${GREEN}Services started successfully.${NC}"
echo -e "${BLUE}Access the applications:${NC}"
echo -e "${BLUE}- Frontend: http://localhost:${FRONTEND_PORT}${NC}"
echo -e "${BLUE}- API Backend: http://localhost:${BACKEND_PORT}${NC}"
echo -e "${BLUE}- API Swagger: http://localhost:${BACKEND_PORT}/swagger/index.html${NC}"
echo -e "${BLUE}- CockroachDB Admin: http://localhost:${COCKROACH_UI_PORT}${NC}"