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
# Make the script executable
chmod +x setup.sh

# Run the setup script
./setup.sh
```

This will automatically:
1. Check for required dependencies
2. Clone the necessary repositories
3. Launch the entire application stack

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

2. Start the application:
```bash
docker-compose up -d
```

## Accessing the Application

Once running, the application components are available at:

- **Frontend**: http://localhost:5173
- **API Documentation**: http://localhost:8080/swagger/index.html
- **Database Admin**: http://localhost:9090

## Repository Structure

```
stock-advisor-deployment/
├── docker-compose.yml     # Main configuration for all services
├── README.md              # English documentation (this file)
├── README.es.md           # Spanish documentation
├── setup.sh               # Automated setup script
└── .gitignore             # Git ignore configuration
```

## Component Repositories

The application is split across two main repositories:

- **Frontend**: [julianloaiza/stock-advisor-frontend](https://github.com/julianloaiza/stock-advisor-frontend)
- **Backend**: [julianloaiza/stock-advisor-backend](https://github.com/julianloaiza/stock-advisor-backend)

## Common Commands

- **Start all services**: `docker-compose up -d`
- **View logs**: `docker-compose logs -f`
- **Stop all services**: `docker-compose down`
- **Stop and remove volumes**: `docker-compose down -v`

## Troubleshooting

If you encounter any issues:

1. **Check logs**: `docker-compose logs -f [service_name]` (e.g., `backend`, `frontend`, or `cockroach`)
2. **Restart services**: `docker-compose restart [service_name]`
3. **Rebuild containers**: `docker-compose up -d --build`

## System Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+
- 4GB RAM (minimum)
- 10GB free disk space
