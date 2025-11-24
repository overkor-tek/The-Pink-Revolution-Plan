# 🧪 Testing Guide

**Comprehensive testing standards and practices for overkor-tek**

**Last Updated:** November 24, 2024

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Testing Philosophy](#testing-philosophy)
3. [Types of Tests](#types-of-tests)
4. [Testing Standards](#testing-standards)
5. [Writing Tests](#writing-tests)
6. [Running Tests](#running-tests)
7. [CI/CD Integration](#cicd-integration)
8. [Best Practices](#best-practices)

---

## 🎯 Overview

Testing is critical for maintaining code quality, preventing regressions, and ensuring reliable systems. This guide covers testing standards for all overkor-tek repositories.

### Goals

- **Quality:** Catch bugs before production
- **Confidence:** Deploy with certainty
- **Documentation:** Tests as living documentation
- **Maintainability:** Easy to update and extend

---

## 💭 Testing Philosophy

### The Testing Pyramid

```
        ┌─────────────┐
        │     E2E     │  10% - Full system tests
        ├─────────────┤
        │ Integration │  20% - Component interaction
        ├─────────────┤
        │    Unit     │  70% - Individual functions
        └─────────────┘
```

**Emphasis on:**
- Fast feedback (unit tests)
- Comprehensive coverage (all layers)
- Realistic scenarios (integration/E2E)
- Maintainable tests (clear, simple)

### Test-Driven Development (TDD)

**Recommended workflow:**
1. Write failing test
2. Write minimal code to pass
3. Refactor while keeping tests green
4. Repeat

**Benefits:**
- Better design
- Higher coverage
- Living documentation
- Confidence in changes

---

## 🔬 Types of Tests

### Unit Tests

Test individual functions/methods in isolation.

**Characteristics:**
- Fast (milliseconds)
- Isolated (no external dependencies)
- Focused (one thing at a time)
- Predictable (deterministic)

**Example (Jest):**
```javascript
// utils/email.js
export function validateEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}

// utils/email.test.js
import { validateEmail } from './email';

describe('validateEmail', () => {
  test('should return true for valid email', () => {
    expect(validateEmail('user@example.com')).toBe(true);
  });

  test('should return false for invalid email', () => {
    expect(validateEmail('invalid-email')).toBe(false);
  });

  test('should return false for empty string', () => {
    expect(validateEmail('')).toBe(false);
  });
});
```

### Integration Tests

Test how multiple components work together.

**Characteristics:**
- Moderate speed (seconds)
- Real dependencies (database, APIs)
- Realistic scenarios
- More complex setup

**Example (Jest + Supertest):**
```javascript
// routes/users.test.js
import request from 'supertest';
import app from '../app';
import db from '../db';

describe('User API', () => {
  beforeAll(async () => {
    await db.connect();
  });

  afterAll(async () => {
    await db.disconnect();
  });

  beforeEach(async () => {
    await db.clear();
  });

  test('POST /users should create new user', async () => {
    const response = await request(app)
      .post('/users')
      .send({
        email: 'test@example.com',
        name: 'Test User',
      })
      .expect(201);

    expect(response.body.data.email).toBe('test@example.com');

    // Verify in database
    const user = await db.users.findByEmail('test@example.com');
    expect(user).toBeDefined();
  });
});
```

### End-to-End (E2E) Tests

Test complete user workflows through the full stack.

**Characteristics:**
- Slow (minutes)
- Full system (frontend + backend + database)
- User perspective
- Fragile (many moving parts)

**Example (Playwright):**
```javascript
// e2e/login.spec.js
import { test, expect } from '@playwright/test';

test('user can log in successfully', async ({ page }) => {
  // Navigate to login page
  await page.goto('https://app.example.com/login');

  // Fill in credentials
  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'password123');

  // Click login button
  await page.click('button[type="submit"]');

  // Verify redirect to dashboard
  await expect(page).toHaveURL('https://app.example.com/dashboard');

  // Verify user name displayed
  await expect(page.locator('.user-name')).toHaveText('John Doe');
});
```

### Pink Revolution Tests

Tests specific to Pink Revolution transformations.

**Example:**
```javascript
// tests/pink-revolution.test.js
describe('Pink Revolution Compliance', () => {
  test('email templates use pink colors', () => {
    const emailHTML = generateWelcomeEmail();
    expect(emailHTML).toContain('#FF69B4');
    expect(emailHTML).not.toContain('#007bff');
  });

  test('UI gradients use pink palette', () => {
    const styles = getComponentStyles('MasterBadge');
    expect(styles.background).toContain('#FF1493');
    expect(styles.background).toContain('#C71585');
  });

  test('terminal output uses magenta color', () => {
    const output = logger.info('Test message');
    expect(output).toContain('\x1b[35m'); // Magenta
    expect(output).not.toContain('\x1b[34m'); // Blue
  });
});
```

---

## 📏 Testing Standards

### Coverage Requirements

**Minimum Coverage:**
- **Unit Tests:** 80% coverage
- **Integration Tests:** Key workflows covered
- **E2E Tests:** Critical user paths

**Coverage by File Type:**
- Utilities: 90%+
- Business Logic: 80%+
- Routes/Controllers: 70%+
- UI Components: 60%+

**Run coverage:**
```bash
npm run test:coverage
```

### Test Naming Conventions

**Pattern:** `describe` context, `test/it` behavior

```javascript
describe('UserService', () => {
  describe('createUser', () => {
    test('should create user with valid data', () => {});
    test('should throw error for duplicate email', () => {});
    test('should hash password before saving', () => {});
  });

  describe('updateUser', () => {
    test('should update user fields', () => {});
    test('should not update email to existing email', () => {});
  });
});
```

### Test Organization

**Directory Structure:**
```
project/
├── src/
│   ├── utils/
│   │   ├── email.js
│   │   └── email.test.js        # Unit tests alongside source
│   └── routes/
│       ├── users.js
│       └── users.test.js
├── tests/
│   ├── integration/              # Integration tests
│   │   └── api.test.js
│   └── e2e/                      # E2E tests
│       └── login.spec.js
└── jest.config.js
```

---

## ✍️ Writing Tests

### Anatomy of a Good Test

```javascript
describe('Feature or Component', () => {
  // Setup
  beforeEach(() => {
    // Arrange: Set up test conditions
  });

  test('should do something specific', () => {
    // Arrange: Prepare test data
    const input = { email: 'test@example.com' };

    // Act: Execute the code under test
    const result = validateUser(input);

    // Assert: Verify the expected outcome
    expect(result.valid).toBe(true);
  });

  // Cleanup
  afterEach(() => {
    // Clean up resources
  });
});
```

### Arrange-Act-Assert Pattern

**1. Arrange:** Set up test conditions
```javascript
const user = { email: 'test@example.com', password: 'pass123' };
const mockDB = jest.fn().mockResolvedValue(user);
```

**2. Act:** Execute the code
```javascript
const result = await loginUser(user.email, user.password);
```

**3. Assert:** Verify results
```javascript
expect(result.success).toBe(true);
expect(result.user.email).toBe('test@example.com');
expect(mockDB).toHaveBeenCalledWith('test@example.com');
```

### Mocking

**Mock external dependencies:**
```javascript
// Mock database
jest.mock('../db', () => ({
  users: {
    findByEmail: jest.fn(),
    create: jest.fn(),
  },
}));

// Mock API calls
jest.mock('axios');
axios.get.mockResolvedValue({ data: { id: 1 } });

// Mock timers
jest.useFakeTimers();
jest.advanceTimersByTime(1000);
```

### Testing Async Code

```javascript
// Using async/await
test('should fetch user data', async () => {
  const data = await fetchUser('user123');
  expect(data.id).toBe('user123');
});

// Testing promises
test('should reject with error', () => {
  return expect(fetchUser('invalid')).rejects.toThrow('Not found');
});

// Using callbacks
test('should call callback with data', (done) => {
  fetchUser('user123', (data) => {
    expect(data.id).toBe('user123');
    done();
  });
});
```

---

## 🏃 Running Tests

### Common Commands

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage

# Run specific test file
npm test -- users.test.js

# Run tests matching pattern
npm test -- --testNamePattern="should create user"

# Run only integration tests
npm run test:integration

# Run only E2E tests
npm run test:e2e

# Run tests in CI mode (no watch)
npm run test:ci
```

### Jest Configuration

**jest.config.js:**
```javascript
module.exports = {
  testEnvironment: 'node',
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/**/*.test.js',
    '!src/index.js',
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
  testMatch: [
    '**/__tests__/**/*.js',
    '**/?(*.)+(spec|test).js',
  ],
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
};
```

---

## 🔄 CI/CD Integration

### GitHub Actions Workflow

**.github/workflows/test.yml:**
```yaml
name: Tests

on:
  push:
    branches: [main, 'claude/**']
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run unit tests
        run: npm run test:unit

      - name: Run integration tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://test:test@localhost/test_db

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/coverage-final.json

      - name: Check coverage threshold
        run: npm run test:coverage -- --coverageThreshold='{"global":{"lines":80}}'
```

### Pre-commit Hooks

**Using Husky:**
```json
{
  "husky": {
    "hooks": {
      "pre-commit": "npm run test:changed",
      "pre-push": "npm run test:ci"
    }
  }
}
```

---

## 🎯 Best Practices

### DO ✅

1. **Write Tests First (TDD)**
   - Design better code
   - Ensure testability
   - Document expected behavior

2. **Test Behavior, Not Implementation**
   ```javascript
   // Good - tests behavior
   test('should return user data', () => {
     const user = getUser('123');
     expect(user.email).toBe('user@example.com');
   });

   // Bad - tests implementation
   test('should call database.query', () => {
     getUser('123');
     expect(database.query).toHaveBeenCalled();
   });
   ```

3. **Keep Tests Simple and Focused**
   - One assertion per test (when possible)
   - Clear test names
   - Minimal setup

4. **Use Descriptive Names**
   ```javascript
   // Good
   test('should return 404 when user not found', () => {});

   // Bad
   test('test1', () => {});
   ```

5. **Test Edge Cases**
   - Empty inputs
   - Null/undefined
   - Very large numbers
   - Special characters
   - Boundary conditions

### DON'T ❌

1. **Don't Test Third-Party Libraries**
   ```javascript
   // Bad - testing lodash
   test('lodash map works', () => {
     const result = _.map([1, 2], n => n * 2);
     expect(result).toEqual([2, 4]);
   });
   ```

2. **Don't Write Flaky Tests**
   - Avoid timing dependencies
   - No random data without seeds
   - Proper cleanup between tests

3. **Don't Test Everything**
   - Focus on business logic
   - Skip trivial getters/setters
   - Mock external dependencies

4. **Don't Share State Between Tests**
   ```javascript
   // Bad - shared state
   let user;
   test('creates user', () => {
     user = createUser();
   });
   test('updates user', () => {
     updateUser(user); // Depends on previous test
   });

   // Good - independent tests
   test('updates user', () => {
     const user = createUser();
     updateUser(user);
   });
   ```

---

## 📊 Coverage Reports

### Viewing Coverage

```bash
# Generate coverage report
npm run test:coverage

# Open HTML report
open coverage/lcov-report/index.html
```

### Coverage Badges

Add to README.md:
```markdown
![Coverage](https://img.shields.io/codecov/c/github/overkor-tek/repository)
```

---

## 🔍 Debugging Tests

### VSCode Configuration

**.vscode/launch.json:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Jest Current File",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": ["${fileBasename}", "--runInBand"],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen"
    }
  ]
}
```

### Debug Commands

```bash
# Run tests with Node debugger
node --inspect-brk node_modules/.bin/jest --runInBand

# Run single test file with debugging
node --inspect-brk node_modules/.bin/jest users.test.js

# Verbose output
npm test -- --verbose

# Show test names only (no execution)
npm test -- --listTests
```

---

## 📚 Resources

### Documentation
- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [Testing Library](https://testing-library.com/)
- [Playwright](https://playwright.dev/)
- [Supertest](https://github.com/visionmedia/supertest)

### Internal Resources
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [ARCHITECTURE.md](./ARCHITECTURE.md) - System architecture
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Deployment procedures

---

## ✅ Testing Checklist

Before committing code:

- [ ] All tests pass locally
- [ ] New features have tests
- [ ] Coverage meets threshold (80%)
- [ ] No flaky tests
- [ ] Tests run in CI
- [ ] Edge cases covered
- [ ] Error cases tested
- [ ] Documentation updated

---

**💖 The Pink Revolution continues with quality testing! 💖**

*"Test your code like your daughter depends on it."*

---

*Last Updated: November 24, 2024*
