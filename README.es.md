# Despliegue de Stock Advisor

Este repositorio contiene los archivos de configuración necesarios para desplegar la aplicación completa Stock Advisor, incluyendo componentes de frontend, backend y base de datos.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Git** (versión 2.0+) para clonar los repositorios
- **Docker Engine** (versión 20.10+)
- **Docker Compose** (versión 2.0+)
- 4GB de RAM (mínimo)
- 10GB de espacio libre en disco

## Descripción General

La aplicación Stock Advisor es una solución completa que incluye:

- **Frontend**: Interfaz web interactiva para visualizar datos de acciones y recomendaciones
- **Backend**: API REST con algoritmos inteligentes de análisis y recomendación de acciones
- **Base de Datos**: CockroachDB para almacenamiento de datos de alto rendimiento

## Inicio Rápido

1. Primero, clona este repositorio de despliegue:
```bash
git clone https://github.com/julianloaiza/stock-advisor-deployment.git
cd stock-advisor-deployment
```

2. Haz todos los scripts ejecutables:
```bash
chmod +x scripts/*.sh
```

3. Ejecuta el script de configuración:
```bash
./scripts/setup.sh
```

Esto automáticamente:
- Verificará las dependencias requeridas
- Clonará los repositorios necesarios
- Verificará el script de inicialización de la base de datos
- Creará un archivo `.env` desde `.env.example`

4. **IMPORTANTE**: Edita el archivo `.env` para configurar tu entorno, especialmente:
```
STOCK_AUTH_TKN=tu_token_real_aquí
```

Este token es **obligatorio** para que el backend se conecte a la API externa de datos de acciones. Sin un token válido, la sincronización fallará.

5. Inicia la aplicación:
```bash
./scripts/start.sh
```

Al final del proceso de configuración, se te preguntará si deseas iniciar los servicios inmediatamente. Si eliges 'sí', el script ejecutará automáticamente `start.sh` por ti.

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

3. Crea y configura `.env`:
```bash
cp .env.example .env
# Edita el archivo .env para establecer tu configuración, especialmente STOCK_AUTH_TKN
```

4. Inicia la aplicación:
```bash
docker-compose up -d
```

## Acceso a la Aplicación

Una vez en funcionamiento, los componentes de la aplicación están disponibles en:

- **Frontend**: http://localhost:5173 (o el puerto configurado en `.env`)
- **Documentación de la API**: http://localhost:8080/swagger/index.html (o usando el puerto de backend configurado)
- **Administrador de Base de Datos**: http://localhost:9090 (o el puerto configurado en `.env`)

## Configuración

La aplicación es completamente configurable a través del archivo `.env`. Las opciones clave de configuración incluyen:

- **STOCK_AUTH_TKN**: Token de autenticación para la API externa (obligatorio)
- **STOCK_API_URL**: URL de la API externa de datos de acciones
- **DATABASE_URL**: Cadena de conexión a la base de datos
- **Puertos de servicio**: Para todos los componentes (frontend, backend, base de datos)
- **VITE_API_BASE_URL**: URL donde el frontend se conectará para acceder al backend
- **VITE_DEFAULT_LANGUAGE**: Idioma predeterminado para la interfaz de usuario del frontend

Aquí hay una breve explicación de las variables más importantes:

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| STOCK_AUTH_TKN | Token de autenticación para API externa | tkn_ejemplo123 |
| STOCK_API_URL | URL para datos de acciones externos | https://api.ejemplo.com/stocks |
| VITE_API_BASE_URL | URL del backend (para que se conecte el frontend) | http://localhost:8080 |
| BACKEND_PORT | Puerto para el servicio backend | 8080 |
| FRONTEND_PORT | Puerto para el servicio frontend | 5173 |

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

## Repositorios de Componentes

La aplicación está dividida en dos repositorios principales:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Scripts de Utilidad

El repositorio incluye varios scripts de utilidad para ayudar a gestionar la aplicación:

- **setup.sh**: Configuración inicial del entorno
- **start.sh**: Iniciar todos los servicios (también puede reiniciar servicios después de shutdown o stop)
- **stop.sh**: Detener todos los servicios temporalmente (mantiene los contenedores)
- **shutdown.sh**: Apagar todos los servicios (elimina los contenedores pero preserva los volúmenes de datos)
- **reset.sh**: Reiniciar servicios (con o sin datos)
- **remove.sh**: Eliminar todos los contenedores, volúmenes y redes (limpieza completa)

## Solución de Problemas

Si encuentras algún problema:

1. **Revisar logs**: `docker-compose logs -f [nombre_servicio]` (ej., `backend`, `frontend`, o `cockroach`)
2. **Verificar variables de entorno**: Asegúrate de que `STOCK_AUTH_TKN` y otras variables estén correctamente configuradas en el archivo `.env`
3. **Reiniciar servicios**: Ejecuta `./scripts/reset.sh`
4. **Reconstruir contenedores**: `docker-compose up -d --build`

### Problemas comunes

- **La sincronización falla**: Generalmente significa que el `STOCK_AUTH_TKN` falta o es incorrecto
- **El frontend no puede conectarse al backend**: Verifica el `VITE_API_BASE_URL` en `.env`
- **Error de conexión a la base de datos**: Verifica que la base de datos esté ejecutándose y que `DATABASE_URL` sea correcto