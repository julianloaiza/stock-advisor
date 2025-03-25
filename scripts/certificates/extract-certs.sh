#!/bin/bash
# ==========================================================
# Script para extraer certificados del contenedor
# ==========================================================
set -e

# Importar funciones comunes si no se ejecuta desde otro script
if [ -z "$NC" ]; then
  source ./scripts/common.sh
fi

# Directorio para guardar certificados localmente
CERT_DIR="./local-certs"
mkdir -p $CERT_DIR

# Extraer certificados del contenedor
echo_info "Extrayendo certificados del contenedor..."
docker cp cockroach:/certs/ca.crt $CERT_DIR/
docker cp cockroach:/certs/client.root.crt $CERT_DIR/
docker cp cockroach:/certs/client.root.key $CERT_DIR/
docker cp cockroach:/certs/client.stock_user.crt $CERT_DIR/
docker cp cockroach:/certs/client.stock_user.key $CERT_DIR/

# Establecer permisos
chmod 600 $CERT_DIR/*.key

echo_success "Certificados extraídos en $CERT_DIR"
echo_info "Ejemplo de conexión segura:"
echo_info "cockroach sql --certs-dir=$CERT_DIR --host=localhost --user=stock_user"