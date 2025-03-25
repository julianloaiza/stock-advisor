#!/bin/bash
# ==========================================================
# Funciones comunes para scripts
# ==========================================================

# Colores para salida
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funciones de formato
echo_title() {
  echo -e "\n${BLUE}=================================================${NC}"
  echo -e "${BLUE}    $1${NC}"
  echo -e "${BLUE}=================================================${NC}\n"
}

echo_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

echo_info() {
  echo -e "${BLUE}ℹ $1${NC}"
}

echo_warning() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

echo_error() {
  echo -e "${RED}✗ $1${NC}"
}

# Verificar si un contenedor existe y está corriendo
is_container_running() {
  local container_name=$1
  docker ps --format '{{.Names}}' | grep -q "^$container_name\$"
}

# Verificar si todos los contenedores existen (aunque no estén corriendo)
containers_exist() {
  for container in cockroach cockroach-certs db-init backend frontend; do
    if ! docker ps -a --format '{{.Names}}' | grep -q "^$container\$"; then
      return 1
    fi
  done
  return 0
}

# Cargar variables de entorno
load_env() {
  if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
  else
    echo_error "Archivo .env no encontrado. Ejecuta ./setup.sh primero."
    exit 1
  fi
}