# Stock Advisor Deployment

This repository contains the necessary configuration files to deploy the complete Stock Advisor application, including frontend, backend, and database components.

## Overview

The Stock Advisor application is a full-stack solution that includes:

- **Frontend**: Interactive web interface for visualizing stock data and recommendations
- **Backend**: REST API with intelligent stock analysis and recommendation algorithms
- **Database**: CockroachDB for high-performance data storage

## Quick Start

The easiest way to get everything running is to use the provided setup script:

```bash
# Make all scripts executable
chmod +x scripts/*.sh

# Run the setup script
./scripts/setup.sh

# Start the services
./scripts/start.sh
```

This will automatically:
1. Check for required dependencies
2. Clone the necessary repositories
3. Verify the database initialization script
4. Launch the entire application stack

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

3. Start the application:
```bash
docker-compose up -d
```

## Accessing the Application

Once running, the application components are available at:

- **Frontend**: http://localhost:5173 (or the port configured in `.env`)
- **API Documentation**: http://localhost:8080/swagger/index.html (or using the configured backend port)
- **Database Admin**: http://localhost:9090 (or the port configured in `.env`)

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
│   └── remove.sh          # Remove everything
├── sql/                   # Database scripts
│   └── init-db.sql        # Database initialization
└── repositories/          # Source code repositories
    ├── stock-advisor-frontend/
    └── stock-advisor-backend/
```

## Configuration

The application is fully configurable through the `.env` file. Key configuration options include:

- **Database settings**: User, database name
- **Service ports**: For all components (frontend, backend, database)
- **API configuration**: URL, authentication token
- **Frontend settings**: API URL, default language

You can edit the `.env` file to customize the deployment according to your needs.

## Component Repositories

The application is split across two main repositories:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Utility Scripts

The repository includes several utility scripts to help manage the application:

- **setup.sh**: Initial setup of the environment
- **start.sh**: Start all services
- **stop.sh**: Stop all services
- **reset.sh**: Reset services (with or without data)
- **remove.sh**: Remove all containers, volumes, and networks

## Troubleshooting

If you encounter any issues:

1. **Check logs**: `docker-compose logs -f [service_name]` (e.g., `backend`, `frontend`, or `cockroach`)
2. **Restart services**: Run `./scripts/reset.sh`
3. **Rebuild containers**: `docker-compose up -d --build`
4. **Check environment variables**: Ensure all required variables are set in the `.env` file

## System Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+
- 4GB RAM (minimum)
- 10GB free disk space