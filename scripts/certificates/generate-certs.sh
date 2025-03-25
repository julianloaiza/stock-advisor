#!/bin/bash
# ==========================================================
# Script para generar certificados SSL/TLS para CockroachDB
# ==========================================================
set -e

# Establecer variables
CERTS_DIR="/certs"
CA_KEY="${CERTS_DIR}/ca.key"
CA_CRT="${CERTS_DIR}/ca.crt"

# Verificar si ya existen certificados
if [ -f "$CA_CRT" ] && [ -f "$CA_KEY" ]; then
  echo "Certificados existentes encontrados, omitiendo generación"
  exit 0
fi

# Crear directorio de certificados
mkdir -p $CERTS_DIR

# Generar certificado de CA
echo "Generando certificado de CA..."
cockroach cert create-ca \
  --certs-dir=$CERTS_DIR \
  --ca-key=$CA_KEY

# Generar certificados para el nodo
echo "Generando certificado de nodo..."
cockroach cert create-node \
  localhost \
  cockroach \
  --certs-dir=$CERTS_DIR \
  --ca-key=$CA_KEY

# Generar certificado para usuario root
echo "Generando certificado para usuario root..."
cockroach cert create-client \
  root \
  --certs-dir=$CERTS_DIR \
  --ca-key=$CA_KEY

# Generar certificado para stock_user
echo "Generando certificado para stock_user..."
cockroach cert create-client \
  stock_user \
  --certs-dir=$CERTS_DIR \
  --ca-key=$CA_KEY

# Establecer permisos adecuados
chmod -R 0700 $CERTS_DIR
echo "Certificados generados correctamente en $CERTS_DIR"