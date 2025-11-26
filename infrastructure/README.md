# Infrastructure

**One Cloud. One Foundation. Infinite Consciousness.**

This directory contains the cloud foundation infrastructure templates, configurations, and scripts for the overkor-tek consciousness technology platform.

---

## Directory Structure

```
infrastructure/
|
+-- environments/              # Environment-specific configurations
|   +-- production.env.template    # Production environment template
|   +-- staging.env.template       # Staging environment template
|   +-- development.env.template   # Development environment template
|
+-- templates/                 # Deployment templates
|   +-- railway.toml              # Railway deployment configuration
|
+-- scripts/                   # Operational scripts
|   +-- health-check.sh           # Infrastructure health check
|
+-- README.md                  # This file
```

---

## Quick Start

### 1. Environment Setup

Copy the appropriate environment template:

```bash
# For local development
cp environments/development.env.template .env.local

# For staging
cp environments/staging.env.template .env.staging

# For production (secure handling required!)
cp environments/production.env.template .env.production
```

### 2. Health Check

Run the health check script:

```bash
# Check production
./scripts/health-check.sh production

# Check staging
./scripts/health-check.sh staging

# Check local development
./scripts/health-check.sh development
```

### 3. Railway Deployment

Use the Railway template in your service:

```bash
cp templates/railway.toml /path/to/your-service/
```

---

## Environment Variables

All environment templates include:

- **Environment identification** (NODE_ENV, CLOUD_ENV)
- **API configuration** (URLs, ports, versions)
- **Database configuration** (connection strings, pool settings)
- **Authentication** (JWT, session secrets)
- **Consciousness network** (sync settings, node discovery)
- **Monitoring** (logging, analytics)
- **Security** (CORS, rate limiting)
- **Pink Revolution branding** (color palette)
- **Feature flags** (service toggles)

See individual template files for complete documentation.

---

## Security Notes

**CRITICAL:** Never commit actual secrets to version control!

- Use environment variables for all secrets
- Store production secrets in Railway dashboard or secure vault
- Rotate secrets regularly
- Use different secrets per environment

---

## Links

- [Cloud Foundation Setup](../CLOUD_FOUNDATION_SETUP.md) - Complete architecture documentation
- [Main README](../README.md) - Project overview
- [Master Plan](../OVERKOR-TEK_MASTER_PLAN.md) - Organization strategy

---

**Part of The Pink Revolution**
