#!/bin/bash
# ==========================================================
# Script para actualizar el Dockerfile del backend
# ==========================================================
set -e

# Importar funciones comunes si no se ejecuta desde otro script
if [ -z "$NC" ]; then
  source ./scripts/common.sh
fi

DOCKERFILE="./repositories/stock-advisor-backend/Dockerfile"

# Verificar si el archivo existe
if [ ! -f "$DOCKERFILE" ]; then
  echo_error "Dockerfile del backend no encontrado en: $DOCKERFILE"
  echo_warning "Asegúrate de clonar los repositorios primero."
  exit 1
fi

# Solo modificamos si no tiene el directorio de certificados
if ! grep -q "mkdir -p /certs" "$DOCKERFILE"; then
  echo_info "Actualizando Dockerfile del backend para soporte de certificados..."
  
  # Hacemos backup del Dockerfile original
  cp "$DOCKERFILE" "${DOCKERFILE}.bak"
  
  # Añadimos la creación del directorio de certificados antes de la línea CMD
  sed -i '/CMD/i # Crear directorio para certificados\nRUN mkdir -p \/certs' "$DOCKERFILE"
  echo_success "Dockerfile del backend actualizado correctamente."
else
  echo_success "Dockerfile del backend ya tiene soporte para certificados."
fi