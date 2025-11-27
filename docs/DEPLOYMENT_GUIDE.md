# Deployment Guide

**Organization:** overkor-tek
**Last Updated:** November 27, 2025

---

## Overview

This guide covers deployment procedures for overkor-tek repositories.

---

## Repository Deployment Status

| Repository | Platform | Status | URL |
|------------|----------|--------|-----|
| philosopher-ai-backend | Railway | ✅ Live | [Production] |
| consciousness-revolution | TBD | 🔵 Pending | - |
| 100x-platform | TBD | ❓ Unknown | - |
| The-Pink-Revolution-Plan | GitHub | ✅ Live | GitHub Repo |

---

## philosopher-ai-backend

### Platform: Railway

#### Prerequisites
- Railway account
- GitHub access
- Environment variables configured

#### Deployment Process
```bash
# 1. Ensure all tests pass
npm test

# 2. Build the project
npm run build

# 3. Commit changes
git add .
git commit -m "💗 Prepare for deployment"

# 4. Push to trigger deployment
git push origin main
```

#### Environment Variables
| Variable | Description |
|----------|-------------|
| `NODE_ENV` | production |
| `PORT` | Railway assigned |
| `DATABASE_URL` | Database connection |
| `API_KEY` | External API keys |

#### Monitoring
- Railway dashboard for logs
- Operation Purple for notifications
- Health check endpoints

---

## consciousness-revolution

### Platform: TBD

#### Prerequisites
- Hosting platform access
- Build configuration
- Environment setup

#### Deployment Process
```bash
# 1. Build the project
npm run build

# 2. Test locally
npm run preview

# 3. Deploy
npm run deploy
```

#### Post-Deployment
- Verify all pages load
- Check color rendering (PINK!)
- Test functionality

---

## The-Pink-Revolution-Plan

### Platform: GitHub

#### Deployment
Documentation is automatically available on GitHub. No build process required.

#### Updates
```bash
# 1. Make changes
# 2. Commit
git add .
git commit -m "📋 Update documentation"

# 3. Push
git push origin main
```

---

## Pre-Deployment Checklist

### Code Quality
- [ ] All tests passing
- [ ] No lint errors
- [ ] Code reviewed
- [ ] Documentation updated

### Environment
- [ ] Environment variables set
- [ ] Secrets configured
- [ ] Database migrated (if applicable)

### Testing
- [ ] Local testing complete
- [ ] Staging testing (if available)
- [ ] Cross-browser tested

### Pink Revolution
- [ ] Colors verified as pink
- [ ] No blue colors remaining
- [ ] Visual regression checked

---

## Rollback Procedures

### Quick Rollback
```bash
# Revert to previous commit
git revert HEAD
git push origin main
```

### Full Rollback
```bash
# Find the last good commit
git log --oneline

# Reset to specific commit
git reset --hard <commit-hash>

# Force push (use with caution)
git push -f origin main
```

### Railway Rollback
1. Go to Railway dashboard
2. Select deployment history
3. Click "Rollback" on previous deployment

---

## CI/CD Pipeline

### GitHub Actions Workflow

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Deploy
        run: npm run deploy
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
```

---

## Monitoring & Alerts

### Operation Purple
All deployments trigger Operation Purple notifications:
- Push events
- Deployment status
- Release notifications

### Health Checks
```bash
# Check API health
curl https://api.example.com/health

# Check frontend
curl -I https://app.example.com
```

---

## Deployment Environments

### Development
- Local environment
- Hot reloading enabled
- Debug logging

### Staging (if available)
- Mirror of production
- Test data
- Pre-release testing

### Production
- Live environment
- Real data
- Full monitoring

---

## Security Considerations

### Pre-Deployment
- [ ] No secrets in code
- [ ] Environment variables secure
- [ ] Dependencies audited

### Post-Deployment
- [ ] SSL/TLS verified
- [ ] Security headers checked
- [ ] Access controls verified

---

## Troubleshooting

### Build Failures
```bash
# Clear cache and rebuild
rm -rf node_modules
rm -rf .next  # For Next.js
npm install
npm run build
```

### Deployment Failures
1. Check deployment logs
2. Verify environment variables
3. Check for failed health checks
4. Review recent changes

### Color Issues
If colors appear wrong after deployment:
1. Clear browser cache
2. Check CSS is being served
3. Verify color variables loaded
4. Check for CSS conflicts

---

## Quick Reference

### Commands
| Action | Command |
|--------|---------|
| Test | `npm test` |
| Build | `npm run build` |
| Deploy | `npm run deploy` |
| Start | `npm start` |

### Platforms
| Repository | Platform |
|------------|----------|
| philosopher-ai-backend | Railway |
| consciousness-revolution | TBD |
| The-Pink-Revolution-Plan | GitHub |

---

## Related Documentation

| Document | Purpose |
|----------|---------|
| [ARCHITECTURE_OVERVIEW.md](./ARCHITECTURE_OVERVIEW.md) | System architecture |
| [COLOR_STANDARDS.md](./COLOR_STANDARDS.md) | Color implementation |
| [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) | File organization |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Nov 27, 2025 | Initial deployment guide |

---

**Part of the Pink Revolution** 💗

*Deploy with confidence. Deploy with PINK.*
