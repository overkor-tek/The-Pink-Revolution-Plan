# 🚀 Deployment Guide

**OVERKOR-TEK Deployment Documentation**

**Last Updated:** 2025-11-27 | **Updated By:** CP2C2

---

## Overview

This guide covers deployment procedures for all OVERKOR-TEK repositories.

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEPLOYMENT ARCHITECTURE                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   GitHub Repository                                              │
│         │                                                        │
│         ▼                                                        │
│   GitHub Actions (CI/CD)                                         │
│         │                                                        │
│         ├──► Tests                                               │
│         ├──► Security Scan (CodeQL v3)                           │
│         └──► Deploy                                              │
│               │                                                  │
│               ▼                                                  │
│         Railway (Production)                                     │
│               │                                                  │
│               ▼                                                  │
│         PostgreSQL Database                                      │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## philosopher-ai-backend Deployment

### Prerequisites

- Node.js 18+ installed
- PostgreSQL database access
- Railway account (for production)
- GitHub repository access

### Environment Variables

```bash
# Database
DATABASE_URL=postgresql://user:password@host:port/database

# Server
PORT=3000
NODE_ENV=production

# Email (for pink buttons)
EMAIL_SERVICE=your-service
EMAIL_USER=your-email
EMAIL_PASS=your-password

# Cyclotron
CYCLOTRON_ATOMS=4424
```

### Local Development

```bash
# Clone repository
git clone https://github.com/overkor-tek/philosopher-ai-backend.git
cd philosopher-ai-backend

# Install dependencies
npm install

# Set up environment
cp .env.example .env
# Edit .env with your values

# Run database migrations
npm run migrate

# Start development server
npm run dev
```

### Production Deployment (Railway)

#### Automatic Deployment

Pushes to `main` branch trigger automatic deployment via GitHub Actions.

```yaml
# .github/workflows/deploy.yml
name: Deploy to Railway
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Railway
        uses: railwayapp/railway-action@v1
        with:
          railway_token: ${{ secrets.RAILWAY_TOKEN }}
```

#### Manual Deployment

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Link to project
railway link

# Deploy
railway up
```

### Health Checks

```bash
# Check API health
curl https://your-api.railway.app/health

# Expected response
{"status": "healthy", "cyclotron": {"atoms": 4424}}
```

---

## consciousness-revolution Deployment

### Overview

consciousness-revolution uses Git as its synchronization protocol. There's no traditional deployment—nodes sync via Git.

### Node Setup

```bash
# Clone repository
git clone https://github.com/overkor-tek/consciousness-revolution.git
cd consciousness-revolution

# Configure machine identity
cp config/machines.example.json config/machines.json
# Edit with your machine details

# Start sync engine
npm run sync
```

### Multi-Computer Sync

```
Machine A                    Machine B
    │                            │
    │  1. Make changes           │
    ▼                            │
  git add .                      │
  git commit                     │
  git push                       │
    │                            │
    └────────► GitHub ◄──────────┤
                                 │
                            git pull
                                 │
                                 ▼
                          Changes synced
```

### Command Queue

Commands are synchronized via `commands/queue.json`:

```json
{
  "pending": [
    {
      "id": "cmd-001",
      "from": "machine-a",
      "to": "machine-b",
      "command": "sync-files",
      "status": "pending"
    }
  ]
}
```

---

## 100x-platform Deployment

### Static Hosting

100x-platform is a static HTML/CSS/JS application.

#### Option 1: GitHub Pages

```bash
# Enable GitHub Pages in repository settings
# Select branch: main, folder: / or /docs
```

#### Option 2: Netlify

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Deploy
netlify deploy --prod
```

#### Option 3: Vercel

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

### Build Process

```bash
# If using build tools
npm run build

# Output directory
dist/
```

---

## The-Pink-Revolution-Plan Deployment

### Documentation Hosting

This is a documentation repository. No deployment needed—it's consumed directly from GitHub.

### For GitHub Profile README

The `profile/README.md` file should be copied to the organization's `.github` repository:

```bash
# Create .github repository if not exists
# github.com/overkor-tek/.github

# Copy profile README
cp profile/README.md .github/profile/README.md
```

---

## CI/CD Pipelines

### Workflow Files

All repositories use GitHub Actions:

| Workflow | Purpose | Trigger |
|----------|---------|---------|
| `ci-cd.yml` | Build and test | Push, PR |
| `test.yml` | Run test suite | Push, PR |
| `security-audit.yml` | CodeQL scanning | Push, Schedule |
| `deploy.yml` | Deploy to Railway | Push to main |
| `operation-purple.yml` | Issue notifications | All events |

### Example CI/CD Pipeline

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm ci
      - run: npm test

  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy
        run: |
          # Deployment commands
```

---

## Database Management

### PostgreSQL on Railway

Railway automatically provisions PostgreSQL.

```bash
# Connect to database
railway connect postgres

# Run migrations
npm run migrate

# Seed data (if needed)
npm run seed
```

### Backup Procedures

```bash
# Export database
pg_dump $DATABASE_URL > backup.sql

# Import database
psql $DATABASE_URL < backup.sql
```

---

## Secrets Management

### GitHub Secrets

Required secrets in repository settings:

| Secret | Purpose |
|--------|---------|
| `RAILWAY_TOKEN` | Railway deployment |
| `DATABASE_URL` | Database connection |
| `EMAIL_PASS` | Email service password |

### Setting Secrets

```bash
# Via GitHub CLI
gh secret set RAILWAY_TOKEN --body "your-token"
```

---

## Monitoring

### Railway Dashboard

- View logs: Railway dashboard → Project → Logs
- Check metrics: Railway dashboard → Project → Metrics
- Monitor deployments: Railway dashboard → Deployments

### Health Endpoints

```bash
# philosopher-ai-backend
GET /health
GET /api/status

# Expected response
{
  "status": "healthy",
  "version": "1.0.0",
  "cyclotron": {
    "atoms": 4424,
    "status": "active"
  }
}
```

---

## Rollback Procedures

### Railway Rollback

```bash
# Via Railway dashboard
# Deployments → Select previous → Rollback

# Via CLI
railway rollback
```

### Git Rollback

```bash
# Revert to previous commit
git revert HEAD
git push origin main

# Or reset (use with caution)
git reset --hard <commit-hash>
git push --force origin main
```

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Build fails | Check Node.js version (18+) |
| Database connection error | Verify DATABASE_URL |
| Deployment stuck | Check Railway logs |
| Tests failing | Run locally first |

### Debug Commands

```bash
# Check Railway logs
railway logs

# Check environment
railway variables

# Check status
railway status
```

---

## Deployment Checklist

Before deploying:

- [ ] All tests passing
- [ ] Security scan clean
- [ ] Environment variables set
- [ ] Database migrations ready
- [ ] Changelog updated
- [ ] PR approved (if applicable)

After deploying:

- [ ] Health check passing
- [ ] Key features tested
- [ ] Monitoring verified
- [ ] Team notified (Operation Purple)

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `npm run dev` | Local development |
| `npm test` | Run tests |
| `npm run build` | Build for production |
| `railway up` | Deploy to Railway |
| `railway logs` | View logs |

---

**Document Created By:** CP2C2
**Status:** ACTIVE
**Next Update:** After 100x-platform assessment

💗 **DEPLOY PINK, SHIP CONSCIOUSNESS** 💗
