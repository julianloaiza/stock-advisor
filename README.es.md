# Despliegue de Stock Advisor

Este repositorio contiene los archivos de configuración necesarios para desplegar la aplicación completa Stock Advisor, incluyendo componentes de frontend, backend y base de datos.

## Descripción General

La aplicación Stock Advisor es una solución completa que incluye:

- **Frontend**: Interfaz web interactiva para visualizar datos de acciones y recomendaciones
- **Backend**: API REST con algoritmos inteligentes de análisis y recomendación de acciones
- **Base de Datos**: CockroachDB para almacenamiento de datos de alto rendimiento

## Inicio Rápido

La forma más sencilla de poner todo en funcionamiento es usar el script de configuración proporcionado:

```bash
# Hacer el script ejecutable
chmod +x setup.sh

# Ejecutar el script de configuración
./setup.sh
```

Esto automáticamente:
1. Verificará las dependencias requeridas
2. Clonará los repositorios necesarios
3. Lanzará toda la pila de aplicaciones

## Configuración Manual

Si prefieres configurar manualmente:

1. Clona ambos repositorios fuente:
```bash
# Crear un directorio para los repositorios
mkdir -p repositories
cd repositories

# Clonar los repositorios
git clone https://github.com/julianloaiza/stock-advisor-frontend.git
git clone https://github.com/julianloaiza/stock-advisor-backend.git
cd ..
```

2. Iniciar la aplicación:
```bash
docker-compose up -d
```

## Acceso a la Aplicación

Una vez en funcionamiento, los componentes de la aplicación están disponibles en:

- **Frontend**: http://localhost:5173
- **Documentación de la API**: http://localhost:8080/swagger/index.html
- **Administrador de Base de Datos**: http://localhost:9090

## Estructura del Repositorio

```
stock-advisor-deployment/
├── docker-compose.yml     # Configuración principal para todos los servicios
├── README.md              # Documentación en inglés
├── README.es.md           # Documentación en español (este archivo)
├── setup.sh               # Script de configuración automatizado
└── .gitignore             # Configuración de Git ignore
```

## Repositorios de Componentes

La aplicación está dividida en dos repositorios principales:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Comandos Comunes

- **Iniciar todos los servicios**: `docker-compose up -d`
- **Ver logs**: `docker-compose logs -f`
- **Detener todos los servicios**: `docker-compose down`
- **Detener y eliminar volúmenes**: `docker-compose down -v`

## Solución de Problemas

Si encuentras algún problema:

1. **Revisar logs**: `docker-compose logs -f [nombre_servicio]` (ej., `backend`, `frontend`, o `cockroach`)
2. **Reiniciar servicios**: `docker-compose restart [nombre_servicio]`
3. **Reconstruir contenedores**: `docker-compose up -d --build`

## Requisitos del Sistema

- Docker Engine 20.10+
- Docker Compose 2.0+
- 4GB RAM (mínimo)
- 10GB de espacio libre en disco
