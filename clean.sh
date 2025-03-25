#!/bin/bash
# ==========================================================
# Script para eliminar todos los contenedores y volúmenes
# ==========================================================
set -e

# Importar funciones comunes
source ./scripts/common.sh

echo_title "Limpiando entorno Stock Advisor"

read -p "¿Estás seguro de que quieres eliminar todos los contenedores y datos? (s/N): " CONFIRM
if [[ $CONFIRM != "s" && $CONFIRM != "S" ]]; then
  echo_info "Operación cancelada"
  exit 0
fi

echo_warning "Eliminando contenedores y volúmenes..."
docker-compose down -v

echo_info "Limpiando certificados locales..."
rm -rf local-certs/*

echo_success "Entorno limpiado correctamente"