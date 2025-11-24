# ⚙️ Scripts

**Automation scripts for Pink Revolution operations**

---

## 📚 Directory Structure

```
scripts/
├── setup/          # Environment and project setup
├── deployment/     # Deployment automation
└── maintenance/    # Ongoing maintenance tasks
```

---

## 🎯 Available Scripts

### Coming Soon:

**setup/**
- `install-dependencies.sh` - Install all required dependencies
- `configure-env.sh` - Set up environment variables
- `verify-setup.sh` - Verify installation is correct

**deployment/**
- `deploy-staging.sh` - Deploy to staging environment
- `deploy-production.sh` - Deploy to production
- `rollback.sh` - Rollback to previous version

**maintenance/**
- `backup-database.sh` - Create database backup
- `update-dependencies.sh` - Update all dependencies safely
- `clean-logs.sh` - Clean old log files

---

## 💖 Script Conventions

All scripts in this directory follow these conventions:

**1. Shebang and Set Options:**
```bash
#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure
```

**2. Clear Help Text:**
```bash
if [[ "${1:-}" == "--help" ]]; then
  echo "Usage: ./script-name.sh [options]"
  echo "Description: What this script does"
  exit 0
fi
```

**3. Color Output:**
```bash
# Use pink for success messages!
GREEN='\033[0;32m'
PINK='\033[35m'  # Magenta (pink in terminal)
RED='\033[0;31m'
NC='\033[0m'  # No Color

echo -e "${PINK}✓ Success message${NC}"
echo -e "${RED}✗ Error message${NC}"
```

**4. Verbose Logging:**
```bash
# Log all commands when DEBUG=1
if [[ "${DEBUG:-}" == "1" ]]; then
  set -x
fi
```

**5. Idempotent:**
- Safe to run multiple times
- Check state before making changes
- Clean up on failure

---

## 🚀 Usage Examples

```bash
# Setup new environment
./scripts/setup/install-dependencies.sh
./scripts/setup/configure-env.sh
./scripts/setup/verify-setup.sh

# Deploy to staging
./scripts/deployment/deploy-staging.sh

# If staging looks good, deploy to production
./scripts/deployment/deploy-production.sh

# If production has issues, rollback
./scripts/deployment/rollback.sh

# Regular maintenance
./scripts/maintenance/update-dependencies.sh
./scripts/maintenance/clean-logs.sh
```

---

## 💡 Creating New Scripts

When adding new scripts:

1. Choose appropriate directory (setup/deployment/maintenance)
2. Follow naming convention: `action-target.sh`
3. Add execute permission: `chmod +x script-name.sh`
4. Include help text and error handling
5. Test thoroughly before committing
6. Update this README

---

**💖 Automate all the things! 💖**
