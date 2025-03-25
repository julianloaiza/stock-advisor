#!/bin/bash
# ==========================================================
# Script para verificar la salud de los servicios
# ==========================================================
set -e

# Importar funciones comunes si no se ejecuta desde otro script
if [ -z "$NC" ]; then
  source ./scripts/common.sh
fi

echo_info "Verificando estado de los servicios..."

# Esperar a que la base de datos esté lista
MAX_ATTEMPTS=30
ATTEMPT=0
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  if docker exec cockroach cockroach node status --certs-dir=/certs &>/dev/null; then
    echo_success "Base de datos CockroachDB lista"
    break
  fi
  ATTEMPT=$((ATTEMPT+1))
  echo_info "Esperando a que CockroachDB esté listo... ($ATTEMPT/$MAX_ATTEMPTS)"
  sleep 2
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
  echo_error "Timeout esperando a que CockroachDB esté listo."
  exit 1
fi

# Esperar a que el backend esté listo
ATTEMPT=0
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  if curl -s http://localhost:8080/swagger/index.html &>/dev/null; then
    echo_success "Backend API lista"
    break
  fi
  ATTEMPT=$((ATTEMPT+1))
  echo_info "Esperando a que el backend esté listo... ($ATTEMPT/$MAX_ATTEMPTS)"
  sleep 2
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
  echo_error "Timeout esperando a que el backend esté listo."
  echo_warning "Continuando de todos modos, es posible que necesite más tiempo..."
fi

# Esperar a que el frontend esté listo
ATTEMPT=0
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  if curl -s http://localhost:5173 &>/dev/null; then
    echo_success "Frontend listo"
    break
  fi
  ATTEMPT=$((ATTEMPT+1))
  echo_info "Esperando a que el frontend esté listo... ($ATTEMPT/$MAX_ATTEMPTS)"
  sleep 2
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
  echo_error "Timeout esperando a que el frontend esté listo."
  echo_warning "Continuando de todos modos, es posible que necesite más tiempo..."
fi

echo_success "Verificación de servicios completada"