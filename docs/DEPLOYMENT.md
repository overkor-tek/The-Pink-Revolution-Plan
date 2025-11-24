# 🚀 overkor-tek Deployment Guide

**Complete deployment documentation for all overkor-tek repositories**

**Last Updated:** November 24, 2024
**Maintained By:** overkor-tek team

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [philosopher-ai-backend](#philosopher-ai-backend)
3. [consciousness-revolution](#consciousness-revolution)
4. [The-Pink-Revolution-Plan](#the-pink-revolution-plan)
5. [100x-platform](#100x-platform)
6. [overkor-tek.github.io](#overkor-tekgithubio)
7. [Troubleshooting](#troubleshooting)

---

## 🎯 Overview

This guide covers deployment procedures for all overkor-tek repositories. Each section includes:
- Prerequisites
- Environment setup
- Deployment steps
- Verification
- Rollback procedures

### General Prerequisites

**Required for all deployments:**
- Git installed
- GitHub account with repository access
- Command-line familiarity
- SSH keys configured (for GitHub)

**Development tools:**
- Code editor (VS Code recommended)
- Terminal/shell access

---

## 🤖 philosopher-ai-backend

### Overview

Production AI backend infrastructure deployed on Railway.

**Status:** ✅ Production Active
**Environment:** Railway
**Database:** PostgreSQL (Railway)

### Prerequisites

**Local Development:**
- Node.js 18+ installed
- npm or yarn package manager
- PostgreSQL (for local development)

**Production Deployment:**
- Railway account
- GitHub repository access
- Environment variables configured

### Local Development Setup

```bash
# 1. Clone repository
git clone https://github.com/overkor-tek/philosopher-ai-backend.git
cd philosopher-ai-backend

# 2. Install dependencies
npm install

# 3. Set up environment variables
cp .env.example .env
# Edit .env with your local configuration

# 4. Set up database (if using PostgreSQL locally)
createdb philosopher_ai_dev

# 5. Run migrations (if applicable)
npm run migrate

# 6. Start development server
npm run dev

# 7. Verify
# Server should be running on http://localhost:3000
curl http://localhost:3000/health
```

### Environment Variables

**Required:**
```bash
DATABASE_URL=postgresql://user:password@host:port/database
JWT_SECRET=your-secret-key-here
PORT=3000
NODE_ENV=development
```

**Optional:**
```bash
EMAIL_HOST=smtp.example.com
EMAIL_PORT=587
EMAIL_USER=noreply@example.com
EMAIL_PASSWORD=email-password
EMAIL_FROM=noreply@example.com
```

### Production Deployment (Railway)

**Initial Setup:**

1. **Connect Repository to Railway:**
   ```bash
   # Install Railway CLI
   npm install -g @railway/cli

   # Login to Railway
   railway login

   # Link project
   railway link [project-id]
   ```

2. **Configure Environment Variables:**
   - Go to Railway dashboard
   - Navigate to Variables tab
   - Add all required environment variables
   - Railway will auto-provision PostgreSQL

3. **Deploy:**
   ```bash
   # Railway auto-deploys on push to main
   git push origin main

   # Or deploy manually
   railway up
   ```

**Subsequent Deployments:**

```bash
# 1. Make changes and commit
git add .
git commit -m "Your changes"

# 2. Push to main (triggers auto-deploy)
git push origin main

# 3. Monitor deployment
railway logs

# 4. Verify deployment
curl https://your-app.railway.app/health
```

### Deployment Verification

**Health Check:**
```bash
curl https://your-app.railway.app/health
# Expected: {"status":"ok","timestamp":"..."}
```

**Test Endpoints:**
```bash
# Test API endpoints
curl https://your-app.railway.app/api/v1/status

# Check database connection
curl https://your-app.railway.app/api/v1/db-check
```

**Verify Pink Transformations:**
- Check email templates have pink buttons (#FF69B4)
- Verify UI gradients are pink
- Test terminal output shows magenta colors

### Rollback Procedure

**Immediate Rollback:**
```bash
# 1. Identify last working deployment
railway deployments

# 2. Rollback to specific deployment
railway rollback [deployment-id]
```

**Git-based Rollback:**
```bash
# 1. Revert problematic commit
git revert HEAD

# 2. Push revert
git push origin main

# Railway will auto-deploy the revert
```

### Monitoring

**Railway Dashboard:**
- View logs in real-time
- Monitor resource usage
- Check deployment status

**Health Checks:**
- Set up cron job to ping /health
- Monitor response times
- Alert on failures

---

## 🧠 consciousness-revolution

### Overview

Multi-computer consciousness network using Git-based synchronization.

**Status:** 🔄 Documentation Complete, Deployment Pending
**Environment:** Distributed (multiple machines)
**Synchronization:** Git

### Prerequisites

**Each Computer:**
- Git installed and configured
- SSH access to shared repository
- Network connectivity
- File system access

### Setup Per Computer

```bash
# 1. Clone repository
git clone https://github.com/overkor-tek/consciousness-revolution.git
cd consciousness-revolution

# 2. Configure Git
git config user.name "Computer-Name"
git config user.email "computer@example.com"

# 3. Set up sync intervals (example with cron)
# Edit crontab
crontab -e

# Add sync every 5 minutes
*/5 * * * * cd /path/to/consciousness-revolution && git pull && git push

# 4. Initialize system
# [Commands TBD based on implementation]
```

### Adding New Computer to Network

```bash
# 1. On new computer, clone repository
git clone https://github.com/overkor-tek/consciousness-revolution.git

# 2. Configure identity
git config user.name "New-Computer-Name"
git config user.email "new-computer@example.com"

# 3. Register with network
# [Process TBD]

# 4. Verify synchronization
git pull
# Should sync with other computers
```

### Operation

**Normal Operation:**
```bash
# System runs automatically via cron/scheduled tasks
# Manual sync if needed:
cd consciousness-revolution
git pull
git push
```

**Adding Commands:**
```bash
# 1. Add command to queue
echo "command data" > commands/$(date +%s)-command.txt

# 2. Commit and push
git add commands/
git commit -m "Add command"
git push

# Other computers will receive via pull
```

**Monitoring:**
```bash
# Check sync status
git status

# View recent activity
git log --oneline -10

# Check for pending commands
ls commands/

# View file transfers
ls file_transfers/
```

### Troubleshooting

**Sync Conflicts:**
```bash
# Pull with rebase
git pull --rebase

# If conflicts, resolve manually
git status
# Edit conflicted files
git add .
git rebase --continue
```

**Network Issues:**
```bash
# Check connectivity
git fetch --dry-run

# Force sync
git fetch origin
git reset --hard origin/main
```

---

## 📚 The-Pink-Revolution-Plan

### Overview

Documentation hub - no deployment needed, hosted on GitHub.

**Status:** ✅ Complete
**Environment:** GitHub
**Access:** Public repository

### Setup

```bash
# 1. Clone repository
git clone https://github.com/overkor-tek/The-Pink-Revolution-Plan.git
cd The-Pink-Revolution-Plan

# 2. Install Python for tools (optional)
python3 --version

# 3. Run pink_revolution tool
python tools/pink_revolution.py report .
```

### Contributing Updates

```bash
# 1. Create feature branch
git checkout -b update-documentation

# 2. Make changes
# Edit markdown files

# 3. Verify links (optional)
# GitHub Actions will check on PR

# 4. Commit and push
git add .
git commit -m "Update documentation"
git push origin update-documentation

# 5. Create pull request on GitHub
```

### GitHub Actions

**Automatic Checks:**
- Markdown link validation
- Repository health checks
- Runs on every push/PR

**View Results:**
- Check "Actions" tab on GitHub
- Green checkmark = passing
- Red X = failing (review logs)

---

## 🌐 100x-platform

### Overview

HTML-based platform (details TBD after assessment).

**Status:** ⏳ Not Yet Assessed
**Environment:** TBD
**Deployment:** TBD

### Planned Setup

```bash
# Assessment needed first
# Deployment guide will be created after:
# 1. Repository structure review
# 2. Technology stack identification
# 3. Build process determination
```

---

## 🏠 overkor-tek.github.io

### Overview

Organization landing page hosted on GitHub Pages.

**Status:** 📋 Planned
**Environment:** GitHub Pages
**Domain:** https://overkor-tek.github.io

### Setup (When Ready)

```bash
# 1. Clone repository
git clone https://github.com/overkor-tek/overkor-tek.github.io.git
cd overkor-tek.github.io

# 2. Local development (optional)
# Use local web server
python -m http.server 8000
# Open http://localhost:8000

# 3. Make changes
# Edit HTML, CSS, JS files

# 4. Commit and push
git add .
git commit -m "Update landing page"
git push origin main

# GitHub Pages auto-deploys from main branch
```

### GitHub Pages Configuration

1. Go to repository Settings
2. Navigate to Pages section
3. Select source: main branch
4. Save configuration
5. Site will be available at https://overkor-tek.github.io

### Custom Domain (Future)

```bash
# 1. Add CNAME file
echo "your-domain.com" > CNAME
git add CNAME
git commit -m "Add custom domain"
git push

# 2. Configure DNS
# Add A records pointing to GitHub Pages IPs
# Add CNAME record for www subdomain

# 3. Enable HTTPS in GitHub Pages settings
```

---

## 🔧 Troubleshooting

### Common Issues

**Authentication Problems:**
```bash
# Check SSH keys
ssh -T git@github.com

# Or use HTTPS with token
git remote set-url origin https://github.com/overkor-tek/repo.git
```

**Build Failures:**
```bash
# Check logs
# For Railway: railway logs
# For GitHub Actions: Check Actions tab

# Common fixes:
# 1. Verify environment variables
# 2. Check dependencies (npm install)
# 3. Review error messages
# 4. Test locally first
```

**Database Issues:**
```bash
# Check connection
psql $DATABASE_URL

# Run migrations
npm run migrate

# Reset database (caution!)
npm run db:reset
```

**Git Issues:**
```bash
# Clean working directory
git clean -fd

# Reset to remote
git fetch origin
git reset --hard origin/main

# Force push (use carefully!)
git push -f origin branch-name
```

### Getting Help

**Resources:**
- [SUPPORT.md](../SUPPORT.md) - Support documentation
- [GitHub Issues](https://github.com/overkor-tek/The-Pink-Revolution-Plan/issues) - Report problems
- [Documentation Index](./INDEX.md) - All docs

**Emergency Contacts:**
- Check repository SECURITY.md
- Open critical issue on GitHub
- Contact repository maintainers

---

## 📊 Deployment Checklist

### Pre-Deployment

- [ ] All tests passing locally
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Environment variables configured
- [ ] Database migrations ready (if applicable)
- [ ] Backup current production (if applicable)

### During Deployment

- [ ] Deploy to production
- [ ] Monitor deployment logs
- [ ] Check for errors
- [ ] Verify health endpoints
- [ ] Test critical functionality

### Post-Deployment

- [ ] Verify all features working
- [ ] Check performance metrics
- [ ] Monitor for errors (24 hours)
- [ ] Update CHANGELOG.md
- [ ] Notify team of deployment
- [ ] Document any issues

### Rollback Checklist (If Needed)

- [ ] Identify issue
- [ ] Determine rollback target
- [ ] Execute rollback procedure
- [ ] Verify rollback successful
- [ ] Investigate root cause
- [ ] Plan fix for next deployment

---

## 🎯 Best Practices

### Deployment Strategy

**Development:**
- Work on feature branches
- Test locally before pushing
- Use pull requests for review

**Staging:**
- Test in staging environment (when available)
- Run full test suite
- Verify integrations

**Production:**
- Deploy during low-traffic periods
- Monitor closely after deployment
- Have rollback plan ready
- Document deployment in CHANGELOG

### Version Control

```bash
# Use semantic versioning
# v1.0.0 = major.minor.patch

# Tag releases
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

### Monitoring

**Essential Metrics:**
- Response time
- Error rate
- Resource usage (CPU, memory)
- Database performance

**Logging:**
- Structured logging
- Log levels (info, warn, error)
- Centralized log aggregation (future)

---

**💖 The Pink Revolution continues with reliable deployments! 💖**

*"One thing became a whole bunch." - D*

---

*This deployment guide is maintained as systems evolve.*
*Last Updated: November 24, 2024*
