#!/bin/bash
# ==========================================================
# Script para detener todos los servicios
# ==========================================================
set -e

# Importar funciones comunes
source ./scripts/common.sh

echo_title "Deteniendo servicios Stock Advisor"
docker-compose stop
echo_success "Servicios detenidos correctamente"