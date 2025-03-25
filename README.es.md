# Despliegue de Stock Advisor

Este repositorio contiene los archivos de configuración necesarios para desplegar la aplicación completa Stock Advisor, incluyendo componentes de frontend, backend y base de datos.

## Descripción General

La aplicación Stock Advisor es una solución completa que incluye:

- **Frontend**: Interfaz web interactiva para visualizar datos de acciones y recomendaciones
- **Backend**: API REST con algoritmos inteligentes de análisis y recomendación de acciones
- **Base de Datos**: CockroachDB para almacenamiento de datos de alto rendimiento

## Inicio Rápido

La forma más sencilla de poner todo en funcionamiento es usar los scripts proporcionados:

```bash
# Hacer todos los scripts ejecutables
chmod +x scripts/*.sh

# Ejecutar el script de configuración
./scripts/setup.sh

# Iniciar los servicios
./scripts/start.sh
```

Esto automáticamente:
1. Verificará las dependencias requeridas
2. Clonará los repositorios necesarios
3. Verificará el script de inicialización de la base de datos
4. Lanzará toda la pila de aplicaciones

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

2. Asegúrate de que el directorio SQL exista:
```bash
mkdir -p sql
# El script init-db.sql ya está incluido en el repositorio
```

3. Iniciar la aplicación:
```bash
docker-compose up -d
```

## Acceso a la Aplicación

Una vez en funcionamiento, los componentes de la aplicación están disponibles en:

- **Frontend**: http://localhost:5173 (o el puerto configurado en `.env`)
- **Documentación de la API**: http://localhost:8080/swagger/index.html (o usando el puerto de backend configurado)
- **Administrador de Base de Datos**: http://localhost:9090 (o el puerto configurado en `.env`)

## Estructura del Repositorio

```
stock-advisor-deployment/
├── docker-compose.yml     # Configuración principal para todos los servicios
├── .env                   # Configuración de entorno
├── .env.example           # Ejemplo de configuración de entorno
├── README.md              # Documentación en inglés
├── README.es.md           # Documentación en español (este archivo)
├── scripts/               # Scripts de utilidad
│   ├── setup.sh           # Script de configuración inicial
│   ├── start.sh           # Iniciar servicios
│   ├── stop.sh            # Detener servicios
│   ├── reset.sh           # Reiniciar servicios
│   └── remove.sh          # Eliminar todo
├── sql/                   # Scripts de base de datos
│   └── init-db.sql        # Inicialización de base de datos
└── repositories/          # Repositorios de código fuente
    ├── stock-advisor-frontend/
    └── stock-advisor-backend/
```

## Configuración

La aplicación es completamente configurable a través del archivo `.env`. Las opciones clave de configuración incluyen:

- **Configuración de base de datos**: Usuario, nombre de la base de datos
- **Puertos de servicio**: Para todos los componentes (frontend, backend, base de datos)
- **Configuración de API**: URL, token de autenticación
- **Configuración de frontend**: URL de API, idioma predeterminado

Puedes editar el archivo `.env` para personalizar el despliegue según tus necesidades.

## Repositorios de Componentes

La aplicación está dividida en dos repositorios principales:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Scripts de Utilidad

El repositorio incluye varios scripts de utilidad para ayudar a gestionar la aplicación:

- **setup.sh**: Configuración inicial del entorno
- **start.sh**: Iniciar todos los servicios
- **stop.sh**: Detener todos los servicios
- **reset.sh**: Reiniciar servicios (con o sin datos)
- **remove.sh**: Eliminar todos los contenedores, volúmenes y redes

## Solución de Problemas

Si encuentras algún problema:

1. **Revisar logs**: `docker-compose logs -f [nombre_servicio]` (ej., `backend`, `frontend`, o `cockroach`)
2. **Reiniciar servicios**: Ejecuta `./scripts/reset.sh`
3. **Reconstruir contenedores**: `docker-compose up -d --build`
4. **Verificar variables de entorno**: Asegúrate de que todas las variables requeridas estén configuradas en el archivo `.env`

## Requisitos del Sistema

- Docker Engine 20.10+
- Docker Compose 2.0+
- 4GB RAM (mínimo)
- 10GB de espacio libre en disco