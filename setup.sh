#!/bin/bash
# ==========================================================
# Script principal para Stock Advisor con configuración segura
# ==========================================================
set -e

# Importar funciones comunes
source ./scripts/common.sh

echo_title "Stock Advisor - Configuración Segura"

# 1. Verificar directorios necesarios
echo_info "Verificando directorios necesarios..."
for dir in config/sql config/docker scripts/certificates scripts/utils local-certs; do
  if [ ! -d "$dir" ]; then
    echo_warning "Directorio $dir no encontrado, creándolo..."
    mkdir -p "$dir"
  fi
done

# 2. Crear .env si no existe
if [ ! -f .env ]; then
  echo_info "Creando archivo .env con valores seguros..."
  cp .env.example .env
  echo_success "Archivo .env creado."
else
  echo_success "Archivo .env ya existe, manteniendo configuración actual."
fi

# 3. Verificar y actualizar Dockerfile del backend si es necesario
if [ -d "./repositories/stock-advisor-backend" ]; then
  bash ./config/docker/backend-dockerfile-patch.sh
else
  echo_warning "Repositorio del backend no encontrado, asegúrate de clonar los repositorios primero."
fi

echo_success "¡Configuración completa!"
echo_info "Para iniciar los servicios, ejecuta: ./start.sh"
echo_info "Para detener los servicios, ejecuta: ./stop.sh"
echo_info "Para limpiar todo el entorno, ejecuta: ./clean.sh"