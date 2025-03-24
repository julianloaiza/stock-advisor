#!/bin/bash

# ==========================================================
# Script de Configuración de Stock Advisor
# ==========================================================
# Este script automatiza la configuración del entorno de 
# Stock Advisor, clonando los repositorios necesarios y
# lanzando la aplicación con Docker Compose.
# ==========================================================

# Definición de colores para mejorar la legibilidad
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
ROJO='\033[0;31m'
SIN_COLOR='\033[0m'

# Mostrar banner de inicio
echo -e "${AZUL}"
echo "====================================================="
echo "       STOCK ADVISOR DEPLOYMENT SETUP               "
echo "====================================================="
echo -e "${SIN_COLOR}"

# Función para verificar si un comando existe
verificar_comando() {
  command -v "$1" >/dev/null 2>&1
}

# ========== VERIFICACIÓN DE REQUISITOS PREVIOS ==========
echo -e "${AMARILLO}Checking system requirements...${SIN_COLOR}"

# Verificar que Git esté instalado
if ! verificar_comando git; then
  echo -e "${ROJO}Error: Git is not installed. Please install Git and try again.${SIN_COLOR}"
  exit 1
fi

# Verificar que Docker esté instalado
if ! verificar_comando docker; then
  echo -e "${ROJO}Error: Docker is not installed. Please install Docker and try again.${SIN_COLOR}"
  exit 1
fi

# Verificar que Docker Compose esté instalado
if ! verificar_comando docker-compose; then
  echo -e "${ROJO}Error: Docker Compose is not installed. Please install Docker Compose and try again.${SIN_COLOR}"
  exit 1
fi

echo -e "${VERDE}✓ All system requirements are met.${SIN_COLOR}"

# ========== CLONACIÓN DE REPOSITORIOS ==========
echo -e "${AMARILLO}Cloning repositories...${SIN_COLOR}"

# Crear directorio para repositorios si no existe
mkdir -p repositories
cd repositories

# Clonar repositorio de frontend
if [ -d "stock-advisor-frontend" ]; then
  echo "Frontend repository already exists. Updating..."
  cd stock-advisor-frontend
  git pull
  cd ..
else
  echo "Cloning frontend repository..."
  git clone https://github.com/julianloaiza/stock-advisor-frontend.git
fi

# Clonar repositorio de backend
if [ -d "stock-advisor-backend" ]; then
  echo "Backend repository already exists. Updating..."
  cd stock-advisor-backend
  git pull
  cd ..
else
  echo "Cloning backend repository..."
  git clone https://github.com/julianloaiza/stock-advisor-backend.git
fi

# Volver al directorio principal
cd ..

# ========== LANZAR APLICACIÓN CON DOCKER COMPOSE ==========
echo -e "${AMARILLO}Starting services with Docker Compose...${SIN_COLOR}"

# Detener servicios si ya están corriendo
docker-compose down

# Iniciar los servicios
docker-compose up -d

# ========== VERIFICACIÓN DE SERVICIOS ==========
echo -e "${AMARILLO}Verifying services are running...${SIN_COLOR}"

# Esperar 10 segundos para que los servicios inicien
echo "Waiting for services to start..."
sleep 10

# Verificar que los contenedores estén corriendo
CONTENEDORES_CORRIENDO=$(docker-compose ps --services --filter "status=running" | wc -l)
if [ "$CONTENEDORES_CORRIENDO" -lt 3 ]; then
  echo -e "${AMARILLO}Warning: Not all services are running.${SIN_COLOR}"
  echo "You can check status with: docker-compose ps"
  echo "Check logs with: docker-compose logs -f"
else
  echo -e "${VERDE}✓ All services seem to be running correctly.${SIN_COLOR}"
fi

# ========== MENSAJE FINAL ==========
echo -e "${VERDE}"
echo "====================================================="
echo "    STOCK ADVISOR DEPLOYMENT COMPLETED!              "
echo "====================================================="
echo -e "${SIN_COLOR}"
echo -e "Application is now available at:"
echo -e "${AZUL}• Frontend:${SIN_COLOR} http://localhost:5173"
echo -e "${AZUL}• API Documentation:${SIN_COLOR} http://localhost:8080/swagger/index.html"
echo -e "${AZUL}• DB Admin:${SIN_COLOR} http://localhost:9090"
echo ""
echo -e "Useful commands:"
echo -e "${AMARILLO}• View logs:${SIN_COLOR} docker-compose logs -f"
echo -e "${AMARILLO}• Stop services:${SIN_COLOR} docker-compose down"
echo -e "${AMARILLO}• Restart services:${SIN_COLOR} docker-compose restart"
echo ""