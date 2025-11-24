# Intermediate Examples

**Level up your Pink Revolution skills with full repository transformations**

---

## 📁 Examples in This Directory

### 1. Full Repository Transformation
- **Level:** ⭐⭐⭐ Intermediate
- **Time:** 4-8 hours
- **Skills:** Auditing, systematic transformation, testing

### 2. CI/CD Pipeline Setup
- **Level:** ⭐⭐⭐ Intermediate
- **Time:** 2-4 hours
- **Skills:** GitHub Actions, automation, deployment

### 3. Documentation Sprint
- **Level:** ⭐⭐ Intermediate
- **Time:** 2-3 hours
- **Skills:** Technical writing, markdown, organization

---

## 🎯 Learning Objectives

By completing these examples, you will:
- Transform an entire repository systematically
- Set up automated testing and deployment
- Write comprehensive documentation
- Master the Pink Revolution workflow

---

## 🗂️ Example 1: Full Repository Transformation

**Scenario:** Transform a complete repository from blue to pink

**Repository:** Small web app (< 10,000 lines)

### Phase 1: Audit (1 hour)

```bash
# Clone repository
git clone https://github.com/overkor-tek/example-repo
cd example-repo

# Scan for blues
python ../The-Pink-Revolution-Plan/tools/pink_revolution.py scan . > audit.json

# Generate report
python ../The-Pink-Revolution-Plan/tools/pink_revolution.py report .
```

**Create audit document:**
```markdown
# Transformation Audit

**Date:** 2024-11-24
**Blues Found:** 23

## Breakdown
- CSS: 15 blues
- JS: 5 blues
- Python: 2 blues
- HTML: 1 blue

## Strategy
1. CSS files (high visibility)
2. JavaScript (functionality)
3. Python (terminal output)
4. HTML (markup)

## Estimated Time: 6 hours
```

### Phase 2: Transform (4-5 hours)

**File-by-file approach:**

```bash
# Start transformation branch
git checkout -b pink-revolution-complete

# Transform CSS files
# 1. styles/main.css
# 2. styles/components.css
# 3. styles/utilities.css

# Commit after each file
git add styles/main.css
git commit -m "🌸 Transform main stylesheet colors to pink"

# Continue with JavaScript
# 4. src/theme.js
# 5. src/config.js

git add src/theme.js src/config.js
git commit -m "🌸 Transform theme configuration to pink"

# Python files
# 6. server/logger.py

git add server/logger.py
git commit -m "🌸 Transform terminal colors to pink"

# HTML files
# 7. index.html

git add index.html
git commit -m "🌸 Transform inline styles to pink"
```

### Phase 3: Test (1 hour)

```bash
# Run existing tests
npm test

# Manual testing
npm start

# Test checklist:
# [ ] All buttons render pink
# [ ] Hover states work
# [ ] No visual breaks
# [ ] Terminal output shows pink
# [ ] All features functional
```

### Phase 4: Document (1 hour)

**Create PINK_REVOLUTION_REPORT.md:**
```markdown
# Pink Revolution Transformation Report

**Repository:** example-repo
**Date:** 2024-11-24
**Transformer:** Your Name

## Summary
- Blues found: 23
- Blues transformed: 23
- Files modified: 7
- Tests: ✅ All passing
- Deployment: ✅ Success

## Color Mappings
| Before | After | Usage |
|--------|-------|-------|
| #007bff | #FF69B4 | Primary buttons |
| #2196F3 | #FF1493 | Accents |
| #1976D2 | #C71585 | Dark elements |
| blue | hotpink | Text colors |

## Testing
- ✅ 45/45 unit tests passing
- ✅ 12/12 integration tests passing
- ✅ Manual testing complete
- ✅ Cross-browser verified

## Deployment
- ✅ Staging: https://staging.example.com
- ✅ Production: https://example.com
- ✅ Monitoring: No errors

## Screenshots
[Add before/after screenshots]

---
💖 Pink Revolution Complete! 💖
```

### Phase 5: PR and Merge (30 min)

```bash
# Push branch
git push origin pink-revolution-complete

# Create PR with:
# - Title: "🌸 Pink Revolution: Complete Transformation"
# - Link transformation report
# - Add screenshots
# - Request reviews
```

---

## ⚙️ Example 2: CI/CD Pipeline Setup

**Scenario:** Set up automated testing and deployment

### Step 1: GitHub Actions Testing (1 hour)

**Create `.github/workflows/test.yml`:**
```yaml
name: Tests

on:
  push:
    branches: [main, 'feature/**']
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18.x'
      - run: npm ci
      - run: npm test
      - run: npm run test:coverage
```

**Test workflow:**
```bash
git add .github/workflows/test.yml
git commit -m "🔧 Add automated testing pipeline"
git push

# Check GitHub Actions tab
# Verify tests run successfully
```

### Step 2: Automated Deployment (1 hour)

**Create `.github/workflows/deploy.yml`:**
```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
      - run: npm run build
      - name: Deploy to Railway
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
        run: |
          npm install -g @railway/cli
          railway up
```

**Set up Railway:**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Link project
railway link

# Deploy manually first
railway up

# Get token for GitHub Actions
railway whoami
# Add RAILWAY_TOKEN to GitHub Secrets
```

### Step 3: Monitoring Setup (1 hour)

**Add health check endpoint:**
```javascript
// server.js
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
});
```

**Add to workflow:**
```yaml
      - name: Health Check
        run: |
          sleep 10
          curl -f https://your-app.railway.app/health || exit 1
```

---

## 📝 Example 3: Documentation Sprint

**Scenario:** Write comprehensive documentation for a repository

### Components to Document:

1. **README.md** (30 min)
   - Project description
   - Installation instructions
   - Usage examples
   - Contributing guidelines

2. **API Documentation** (1 hour)
   - Endpoint descriptions
   - Request/response examples
   - Error codes
   - Authentication

3. **Architecture Documentation** (45 min)
   - System diagram
   - Technology stack
   - Data flow
   - Infrastructure

4. **Contributing Guide** (30 min)
   - Development setup
   - Code standards
   - PR process
   - Testing requirements

**Template Usage:**
```bash
# Copy templates from The-Pink-Revolution-Plan
cp ../The-Pink-Revolution-Plan/templates/TEMPLATE_README.md ./README.md
cp ../The-Pink-Revolution-Plan/templates/TEMPLATE_API_DOCUMENTATION.md ./docs/API.md
cp ../The-Pink-Revolution-Plan/templates/TEMPLATE_CONTRIBUTING.md ./CONTRIBUTING.md

# Customize for your project
# Fill in all [placeholders]
# Add project-specific information
```

---

## 🎓 Next Steps

Completed all intermediate examples?

**Level Up:** Move to [advanced examples](../advanced/)

**Practice More:**
- Transform your own repository
- Set up CI/CD for a personal project
- Contribute to other overkor-tek repos

---

**💖 You're becoming a Pink Revolution expert! 💖**
