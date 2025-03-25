# Stock Advisor Deployment

This repository contains the necessary configuration files to deploy the complete Stock Advisor application, including frontend, backend, and database components.

## Prerequisites

Before starting, make sure you have installed:

- **Git** (version 2.0+) for cloning the repositories
- **Docker Engine** (version 20.10+)
- **Docker Compose** (version 2.0+)
- 4GB RAM (minimum)
- 10GB free disk space

## Overview

The Stock Advisor application is a full-stack solution that includes:

- **Frontend**: Interactive web interface for visualizing stock data and recommendations
- **Backend**: REST API with intelligent stock analysis and recommendation algorithms
- **Database**: CockroachDB for high-performance data storage

## Quick Start

1. First, clone this deployment repository:
```bash
git clone https://github.com/julianloaiza/stock-advisor-deployment.git
cd stock-advisor-deployment
```

2. Make all scripts executable:
```bash
chmod +x scripts/*.sh
```

3. Run the setup script:
```bash
./scripts/setup.sh
```

This will automatically:
- Check for required dependencies
- Clone the necessary repositories
- Verify the database initialization script
- Create a `.env` file from `.env.example`

4. **IMPORTANT**: Edit the `.env` file to configure your environment, especially:
```
STOCK_AUTH_TKN=your_actual_token_here
```

This token is **required** for the backend to connect to the external stock data API. Without a valid token, the synchronization will fail.

5. Start the application:
```bash
./scripts/start.sh
```

At the end of the setup process, you'll be asked if you want to start the services immediately. If you choose 'yes', the script will automatically run `start.sh` for you.

## Manual Setup

If you prefer to set up manually:

1. Clone both source repositories:
```bash
# Create a directory for the repositories
mkdir -p repositories
cd repositories

# Clone the repositories
git clone https://github.com/julianloaiza/stock-advisor-frontend.git
git clone https://github.com/julianloaiza/stock-advisor-backend.git
cd ..
```

2. Ensure the SQL directory exists:
```bash
mkdir -p sql
# The init-db.sql script is already included in the repository
```

3. Create and configure `.env`:
```bash
cp .env.example .env
# Edit the .env file to set your configuration, especially STOCK_AUTH_TKN
```

4. Start the application:
```bash
docker-compose up -d
```

## Accessing the Application

Once running, the application components are available at:

- **Frontend**: http://localhost:5173 (or the port configured in `.env`)
- **API Documentation**: http://localhost:8080/swagger/index.html (or using the configured backend port)
- **Database Admin**: http://localhost:9090 (or the port configured in `.env`)

## Configuration

The application is fully configurable through the `.env` file. Key configuration options include:

- **STOCK_AUTH_TKN**: Authentication token for the external API (required)
- **STOCK_API_URL**: URL of the external stock data API
- **DATABASE_URL**: Database connection string
- **Service ports**: For all components (frontend, backend, database)
- **VITE_API_BASE_URL**: URL where the frontend will connect to access the backend
- **VITE_DEFAULT_LANGUAGE**: Default language for the frontend UI

Here's a brief explanation of the most important variables:

| Variable | Description | Example |
|----------|-------------|---------|
| STOCK_AUTH_TKN | Authentication token for external API | tkn_example123 |
| STOCK_API_URL | URL for external stock data | https://api.example.com/stocks |
| VITE_API_BASE_URL | Backend URL (for frontend to connect) | http://localhost:8080 |
| BACKEND_PORT | Port for backend service | 8080 |
| FRONTEND_PORT | Port for frontend service | 5173 |

## Repository Structure

```
stock-advisor-deployment/
├── docker-compose.yml     # Main configuration for all services
├── .env                   # Environment configuration
├── .env.example           # Example environment configuration
├── README.md              # English documentation (this file)
├── README.es.md           # Spanish documentation
├── scripts/               # Utility scripts
│   ├── setup.sh           # Initial setup script
│   ├── start.sh           # Start services
│   ├── stop.sh            # Stop services
│   ├── reset.sh           # Reset services
│   ├── restart.sh         # Restart services
│   └── remove.sh          # Remove everything
├── sql/                   # Database scripts
│   └── init-db.sql        # Database initialization
└── repositories/          # Source code repositories
    ├── stock-advisor-frontend/
    └── stock-advisor-backend/
```

## Component Repositories

The application is split across two main repositories:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Utility Scripts

The repository includes several utility scripts to help manage the application:

- **setup.sh**: Initial setup of the environment
- **start.sh**: Start all services (can also restart services after shutdown or stop)
- **stop.sh**: Stop all services temporarily (keeps containers)
- **shutdown.sh**: Shut down all services (removes containers but preserves data volumes)
- **reset.sh**: Reset services (with or without data)
- **restart.sh**: Restart services while preserving data and reloading configuration
- **remove.sh**: Remove all containers, volumes, and networks (complete cleanup)

## Troubleshooting

If you encounter any issues:

1. **Check logs**: `docker-compose logs -f [service_name]` (e.g., `backend`, `frontend`, or `cockroach`)
2. **Verify environment variables**: Make sure the `STOCK_AUTH_TKN` and other variables are correctly set in the `.env` file
3. **Restart services**: Run `./scripts/reset.sh`
4. **Rebuild containers**: `docker-compose up -d --build`

### Common Problems

- **Sync fails**: Usually means the `STOCK_AUTH_TKN` is missing or incorrect
- **Frontend can't connect to backend**: Check the `VITE_API_BASE_URL` in `.env`
- **Database connection error**: Verify the database is running and `DATABASE_URL` is correct