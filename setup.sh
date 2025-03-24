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
echo "       CONFIGURACIÓN DE STOCK ADVISOR               "
echo "====================================================="
echo -e "${SIN_COLOR}"

# Función para verificar si un comando existe
verificar_comando() {
  command -v "$1" >/dev/null 2>&1
}

# ========== VERIFICACIÓN DE REQUISITOS PREVIOS ==========
echo -e "${AMARILLO}Verificando requisitos previos...${SIN_COLOR}"

# Verificar que Git esté instalado
if ! verificar_comando git; then
  echo -e "${ROJO}Error: Git no está instalado. Por favor, instala Git e intenta nuevamente.${SIN_COLOR}"
  exit 1
fi

# Verificar que Docker esté instalado
if ! verificar_comando docker; then
  echo -e "${ROJO}Error: Docker no está instalado. Por favor, instala Docker e intenta nuevamente.${SIN_COLOR}"
  exit 1
fi

# Verificar que Docker Compose esté instalado
if ! verificar_comando docker-compose; then
  echo -e "${ROJO}Error: Docker Compose no está instalado. Por favor, instala Docker Compose e intenta nuevamente.${SIN_COLOR}"
  exit 1
fi

echo -e "${VERDE}✓ Todos los requisitos previos están instalados.${SIN_COLOR}"

# ========== CLONACIÓN DE REPOSITORIOS ==========
echo -e "${AMARILLO}Clonando repositorios...${SIN_COLOR}"

# Crear directorio para repositorios si no existe
mkdir -p repositories
cd repositories

# Clonar repositorio de frontend
if [ -d "stock-advisor-frontend" ]; then
  echo "El repositorio de frontend ya existe. Actualizando..."
  cd stock-advisor-frontend
  git pull
  cd ..
else
  echo "Clonando repositorio de frontend..."
  git clone https://github.com/julianloaiza/stock-advisor-frontend.git
fi

# Clonar repositorio de backend
if [ -d "stock-advisor-backend" ]; then
  echo "El repositorio de backend ya existe. Actualizando..."
  cd stock-advisor-backend
  git pull
  cd ..
else
  echo "Clonando repositorio de backend..."
  git clone https://github.com/julianloaiza/stock-advisor-backend.git
fi

# Volver al directorio principal
cd ..

# ========== LANZAR APLICACIÓN CON DOCKER COMPOSE ==========
echo -e "${AMARILLO}Iniciando servicios con Docker Compose...${SIN_COLOR}"

# Detener servicios si ya están corriendo
docker-compose down

# Iniciar los servicios
docker-compose up -d

# ========== VERIFICACIÓN DE SERVICIOS ==========
echo -e "${AMARILLO}Verificando que los servicios estén en funcionamiento...${SIN_COLOR}"

# Esperar 10 segundos para que los servicios inicien
echo "Esperando a que los servicios inicien..."
sleep 10

# Verificar que los contenedores estén corriendo
CONTENEDORES_CORRIENDO=$(docker-compose ps --services --filter "status=running" | wc -l)
if [ "$CONTENEDORES_CORRIENDO" -lt 3 ]; then
  echo -e "${AMARILLO}Advertencia: No todos los servicios están en funcionamiento todavía.${SIN_COLOR}"
  echo "Puedes verificar el estado con: docker-compose ps"
  echo "Verifica los logs con: docker-compose logs -f"
else
  echo -e "${VERDE}✓ Todos los servicios parecen estar funcionando correctamente.${SIN_COLOR}"
fi

# ========== MENSAJE FINAL ==========
echo -e "${VERDE}"
echo "====================================================="
echo "    ¡CONFIGURACIÓN DE STOCK ADVISOR COMPLETADA!     "
echo "====================================================="
echo -e "${SIN_COLOR}"
echo -e "La aplicación está ahora disponible en:"
echo -e "${AZUL}• Frontend:${SIN_COLOR} http://localhost:5173"
echo -e "${AZUL}• Documentación API:${SIN_COLOR} http://localhost:8080/swagger/index.html"
echo -e "${AZUL}• Admin DB:${SIN_COLOR} http://localhost:9090"
echo ""
echo -e "Comandos útiles:"
echo -e "${AMARILLO}• Ver logs:${SIN_COLOR} docker-compose logs -f"
echo -e "${AMARILLO}• Detener servicios:${SIN_COLOR} docker-compose down"
echo -e "${AMARILLO}• Reiniciar servicios:${SIN_COLOR} docker-compose restart"
echo ""