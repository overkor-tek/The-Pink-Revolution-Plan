# Advanced Examples

**Master-level Pink Revolution infrastructure and community leadership**

---

## 📁 Examples in This Directory

### 1. Multi-Repository Coordination
- **Level:** ⭐⭐⭐⭐ Advanced
- **Time:** 1-2 days
- **Skills:** Cross-repo coordination, dependency management

### 2. Custom Tool Development
- **Level:** ⭐⭐⭐⭐ Advanced
- **Time:** 1-2 days
- **Skills:** Python/Node.js, automation, testing

### 3. Security Hardening
- **Level:** ⭐⭐⭐⭐⭐ Expert
- **Time:** 2-3 days
- **Skills:** Security, encryption, authentication

### 4. Performance Optimization
- **Level:** ⭐⭐⭐⭐ Advanced
- **Time:** 1-2 days
- **Skills:** Profiling, caching, optimization

---

## 🎯 Learning Objectives

By completing these examples, you will:
- Coordinate transformations across multiple repositories
- Build custom automation tools
- Implement enterprise-grade security
- Optimize for production-scale performance
- Lead Pink Revolution initiatives

---

## 🗂️ Example 1: Multi-Repository Coordination

**Scenario:** Transform 3 related repositories in coordination

**Repositories:**
1. Backend API (Node.js/Express)
2. Frontend App (React)
3. Shared Components Library

### Challenge: Dependencies

Frontend and Backend both depend on Shared Components. Must transform in correct order.

### Strategy:

**Phase 1: Audit All Repositories (2 hours)**
```bash
# Clone all three
git clone https://github.com/overkor-tek/backend-api
git clone https://github.com/overkor-tek/frontend-app
git clone https://github.com/overkor-tek/shared-components

# Scan each
for repo in backend-api frontend-app shared-components; do
  cd $repo
  python ../The-Pink-Revolution-Plan/tools/pink_revolution.py scan . > ../${repo}-audit.json
  cd ..
done

# Analyze dependencies
npm list | grep shared-components
```

**Create coordination plan:**
```markdown
# Multi-Repo Transformation Plan

## Order of Execution
1. shared-components (no dependencies)
2. backend-api (depends on shared-components)
3. frontend-app (depends on both)

## Timeline
- Day 1: shared-components transformation
- Day 2: backend-api transformation
- Day 3: frontend-app transformation
- Day 4: Integration testing

## Risk Mitigation
- Deploy each repo to staging first
- Test integrations between deploys
- Keep fallback branches
```

**Phase 2: Execute in Order (3 days)**

**Day 1: Shared Components**
```bash
cd shared-components
git checkout -b pink-revolution

# Transform all colors
# Run tests
npm test

# Version bump (important!)
npm version minor  # v1.2.0 → v1.3.0

# Publish to npm (if applicable)
npm publish

# Deploy and tag
git tag v1.3.0
git push origin pink-revolution
git push origin v1.3.0
```

**Day 2: Backend API**
```bash
cd ../backend-api
git checkout -b pink-revolution

# Update dependency
npm install shared-components@^1.3.0

# Transform backend colors
# Update terminal output colors
# Run tests
npm test

# Deploy to staging
git push origin pink-revolution
# Deploy via CI/CD
```

**Day 3: Frontend App**
```bash
cd ../frontend-app
git checkout -b pink-revolution

# Update dependencies
npm install shared-components@^1.3.0

# Transform frontend colors
# Update theme config
# Run tests
npm test

# Deploy to staging
git push origin pink-revolution
```

**Phase 3: Integration Testing (1 day)**

**Test full stack:**
```bash
# Start all services
cd backend-api && npm start &
cd frontend-app && npm start &

# Run E2E tests
cd frontend-app
npm run test:e2e

# Manual testing checklist:
# [ ] All UI components pink
# [ ] API responses correct
# [ ] Shared components working
# [ ] No console errors
# [ ] Performance acceptable
```

---

## 🛠️ Example 2: Custom Tool Development

**Scenario:** Build auto-transformation tool

**Goal:** Automate blue-to-pink color transformation

### Requirements:
- Read files and detect blue colors
- Replace with pink equivalents automatically
- Create backup before changes
- Generate transformation report
- Rollback capability

### Architecture:

```
pink-transform-tool/
├── src/
│   ├── scanner.js      # Detect blues
│   ├── transformer.js  # Apply transformations
│   ├── backup.js       # Create backups
│   ├── reporter.js     # Generate reports
│   └── index.js        # CLI interface
├── tests/
│   ├── scanner.test.js
│   ├── transformer.test.js
│   └── integration.test.js
├── package.json
└── README.md
```

### Implementation Example:

**src/transformer.js:**
```javascript
const fs = require('fs').promises;
const path = require('path');

const COLOR_MAPPINGS = {
  '#007bff': '#FF69B4',  // Bootstrap blue → Hot pink
  '#2196F3': '#FF1493',  // Material blue → Deep pink
  '#1976D2': '#C71585',  // Dark blue → Medium violet red
  'blue': 'hotpink',     // Named colors
};

class Transformer {
  async transformFile(filePath, options = {}) {
    // Read file
    const content = await fs.readFile(filePath, 'utf8');

    // Create backup if requested
    if (options.backup) {
      await fs.writeFile(`${filePath}.backup`, content);
    }

    // Transform colors
    let transformed = content;
    for (const [blue, pink] of Object.entries(COLOR_MAPPINGS)) {
      const regex = new RegExp(blue, 'gi');
      transformed = transformed.replace(regex, pink);
    }

    // Write transformed content
    if (options.dryRun) {
      return { original: content, transformed, changes: this.countChanges(content, transformed) };
    }

    await fs.writeFile(filePath, transformed);
    return { changes: this.countChanges(content, transformed) };
  }

  countChanges(original, transformed) {
    const changes = [];
    for (const [blue, pink] of Object.entries(COLOR_MAPPINGS)) {
      const regex = new RegExp(blue, 'gi');
      const originalMatches = (original.match(regex) || []).length;
      const transformedMatches = (transformed.match(regex) || []).length;
      if (originalMatches > transformedMatches) {
        changes.push({ from: blue, to: pink, count: originalMatches - transformedMatches });
      }
    }
    return changes;
  }
}

module.exports = Transformer;
```

**src/index.js (CLI):**
```javascript
#!/usr/bin/env node
const { program } = require('commander');
const Transformer = require('./transformer');
const Reporter = require('./reporter');

program
  .name('pink-transform')
  .description('Automatically transform blue colors to pink')
  .version('1.0.0');

program
  .command('transform <path>')
  .description('Transform colors in file or directory')
  .option('--dry-run', 'Preview changes without applying')
  .option('--backup', 'Create backup before transforming')
  .option('--report <file>', 'Generate transformation report')
  .action(async (targetPath, options) => {
    const transformer = new Transformer();
    const reporter = new Reporter();

    console.log('🌸 Starting Pink Revolution transformation...\n');

    const results = await transformer.transformPath(targetPath, options);

    if (options.report) {
      await reporter.generateReport(results, options.report);
    }

    console.log(`\n✅ Transformation complete!`);
    console.log(`   Files transformed: ${results.filesChanged}`);
    console.log(`   Colors changed: ${results.colorsChanged}`);
  });

program.parse();
```

**Testing:**
```javascript
// tests/transformer.test.js
const Transformer = require('../src/transformer');

describe('Transformer', () => {
  test('should transform Bootstrap blue to pink', async () => {
    const transformer = new Transformer();
    const input = 'background: #007bff;';
    const result = await transformer.transformString(input);
    expect(result).toBe('background: #FF69B4;');
  });

  test('should handle case-insensitive colors', async () => {
    const transformer = new Transformer();
    const input = 'color: BLUE;';
    const result = await transformer.transformString(input);
    expect(result).toBe('color: hotpink;');
  });
});
```

---

## 🔒 Example 3: Security Hardening

**Scenario:** Implement enterprise-grade security

**Components:**
1. JWT Authentication
2. Password Hashing
3. Rate Limiting
4. SQL Injection Prevention
5. XSS Protection
6. HTTPS/TLS

### Implementation Checklist:

**1. Authentication (JWT):**
```javascript
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

// Secure JWT implementation
const JWT_SECRET = process.env.JWT_SECRET; // 64-byte random string
const JWT_EXPIRES_IN = '24h';

function createToken(user) {
  return jwt.sign(
    { id: user.id, email: user.email, role: user.role },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN, issuer: 'overkor-tek' }
  );
}

function verifyToken(token) {
  try {
    return jwt.verify(token, JWT_SECRET, { issuer: 'overkor-tek' });
  } catch (error) {
    throw new Error('Invalid or expired token');
  }
}
```

**2. Password Security:**
```javascript
const BCRYPT_ROUNDS = 12; // OWASP recommended

async function hashPassword(password) {
  // Validate password strength
  if (password.length < 12) {
    throw new Error('Password must be at least 12 characters');
  }

  return await bcrypt.hash(password, BCRYPT_ROUNDS);
}

async function verifyPassword(password, hash) {
  return await bcrypt.compare(password, hash);
}
```

**3. Rate Limiting:**
```javascript
const rateLimit = require('express-rate-limit');

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per window
  message: 'Too many requests, please try again later',
});

app.use('/api/', apiLimiter);
```

**Security Audit Checklist:**
```markdown
## Security Audit

### Authentication & Authorization
- [ ] JWT tokens properly signed and verified
- [ ] Passwords hashed with bcrypt (12+ rounds)
- [ ] Role-based access control (RBAC) implemented
- [ ] MFA available for sensitive operations

### Data Protection
- [ ] HTTPS/TLS enabled (A+ rating)
- [ ] Sensitive data encrypted at rest
- [ ] Database connections encrypted
- [ ] Environment variables used (no secrets in code)

### API Security
- [ ] Rate limiting on all endpoints
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS attacks prevented (output encoding)
- [ ] CORS properly configured

### Infrastructure
- [ ] Security headers configured (Helmet.js)
- [ ] Cookie security flags set (httpOnly, secure, sameSite)
- [ ] Dependencies up to date (npm audit clean)
- [ ] Docker images from trusted sources

### Monitoring
- [ ] Security events logged
- [ ] Sensitive data not logged
- [ ] Alerting configured for security events
- [ ] Incident response plan documented
```

---

## ⚡ Example 4: Performance Optimization

**Scenario:** Optimize for production scale

### Target Metrics:
- API response time: p95 < 200ms
- Page load time: p95 < 2s
- Database queries: < 50ms average
- Cache hit rate: > 85%

### Optimization Strategy:

**1. Database Optimization:**
```sql
-- Add indexes for common queries
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);

-- Analyze slow queries
EXPLAIN ANALYZE
SELECT u.*, COUNT(p.id) as post_count
FROM users u
LEFT JOIN posts p ON p.user_id = u.id
GROUP BY u.id;
```

**2. Caching Implementation:**
```javascript
const Redis = require('redis');
const client = Redis.createClient({
  url: process.env.REDIS_URL
});

// Cache middleware
async function cacheMiddleware(req, res, next) {
  const key = `cache:${req.url}`;

  try {
    const cached = await client.get(key);
    if (cached) {
      return res.json(JSON.parse(cached));
    }

    // Store original res.json
    const originalJson = res.json.bind(res);

    // Override res.json
    res.json = function(data) {
      // Cache for 5 minutes
      client.setEx(key, 300, JSON.stringify(data));
      return originalJson(data);
    };

    next();
  } catch (error) {
    next(); // Fail open
  }
}

app.get('/api/users', cacheMiddleware, getUsers);
```

**3. Code Splitting (Frontend):**
```javascript
// React code splitting
import { lazy, Suspense } from 'react';

const Dashboard = lazy(() => import('./components/Dashboard'));
const Profile = lazy(() => import('./components/Profile'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Routes>
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Suspense>
  );
}
```

**Performance Monitoring:**
```javascript
const prometheus = require('prom-client');

// Custom metrics
const httpRequestDuration = new prometheus.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status'],
});

// Middleware
app.use((req, res, next) => {
  const start = Date.now();

  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000;
    httpRequestDuration
      .labels(req.method, req.route?.path || req.path, res.statusCode)
      .observe(duration);
  });

  next();
});
```

---

## 🎓 Next Steps

Completed all advanced examples?

**Become a Leader:**
- Mentor new contributors
- Review pull requests
- Create new tools
- Shape the roadmap
- Earn Level 5: Community Leader

**Contribute Back:**
- Share your advanced examples
- Write tutorials for others
- Speak at meetups/conferences
- Build the Pink Revolution community

---

**💖 You're now a Pink Revolution master! Lead the way! 💖**
