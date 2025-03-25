#!/bin/bash
# ==========================================================
# Script para iniciar todos los servicios
# ==========================================================
set -e

# Importar funciones comunes
source ./scripts/common.sh
load_env

echo_title "Iniciando servicios Stock Advisor"

# Verificar si los contenedores ya existen
if containers_exist; then
  echo_info "Contenedores ya existentes, iniciando servicios..."
  docker-compose start
else
  echo_info "Primera ejecución detectada, creando contenedores..."
  docker-compose up -d
  
  echo_info "Esperando a que los servicios estén disponibles..."
  bash ./scripts/utils/health-check.sh
  
  # Extraer certificados para uso local
  bash ./scripts/certificates/extract-certs.sh
fi

echo_success "Servicios iniciados correctamente"
echo_info "- Frontend: http://localhost:5173"
echo_info "- API: http://localhost:8080"
echo_info "- DB Admin: https://localhost:9090"