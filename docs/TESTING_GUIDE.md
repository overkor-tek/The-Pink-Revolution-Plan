# Testing Guide

**Organization:** OVERKOR-TEK
**Last Updated:** 2025-11-27
**Updated By:** CP2C2

---

## Overview

This guide documents testing standards, procedures, and best practices across all OVERKOR-TEK repositories. Testing ensures code quality and Pink Revolution stability.

---

## Testing Philosophy

### The Trinity Testing Principle

```
C1 × C2 × C3 = ∞
Tests multiply confidence
```

Every test should be:
- **LIGHTER** - Test what matters, not everything
- **FASTER** - Fast tests get run more often
- **STRONGER** - Catch real bugs, not false positives
- **ELEGANT** - Readable, maintainable tests

---

## Test Types

### 1. Unit Tests

**Purpose:** Test individual functions/methods in isolation

**Characteristics:**
- Fast execution (< 100ms per test)
- No external dependencies (database, APIs, filesystem)
- High coverage of edge cases
- Run on every commit

**Example structure:**
```javascript
describe('calculateTotal', () => {
  it('should return 0 for empty cart', () => {
    expect(calculateTotal([])).toBe(0);
  });

  it('should sum item prices correctly', () => {
    const items = [{ price: 10 }, { price: 20 }];
    expect(calculateTotal(items)).toBe(30);
  });

  it('should handle negative prices gracefully', () => {
    const items = [{ price: -10 }];
    expect(() => calculateTotal(items)).toThrow('Invalid price');
  });
});
```

### 2. Integration Tests

**Purpose:** Test component interactions

**Characteristics:**
- May use test databases
- Test API endpoints
- Verify data flows
- Run before merging

**Example areas:**
- API endpoint responses
- Database operations
- Service-to-service communication
- Authentication flows

### 3. End-to-End (E2E) Tests

**Purpose:** Test complete user workflows

**Characteristics:**
- Full system testing
- Browser automation (for web)
- Longer execution time
- Run in staging environment

**Example workflows:**
- User registration → login → use feature
- Complete checkout process
- Pink color verification across pages

### 4. Visual/Pink Tests

**Purpose:** Verify Pink Revolution compliance

**Characteristics:**
- Screenshot comparisons
- Color extraction and verification
- Contrast ratio checking
- Run after UI changes

---

## Testing by Repository

### philosopher-ai-backend

**Test Location:** `/tests/`

**Test Command:**
```bash
npm test
```

**Key Test Areas:**
| Area | Type | Priority |
|------|------|----------|
| API endpoints | Integration | High |
| Cyclotron brain | Unit | Critical |
| Authentication | Integration | Critical |
| Rate limiting | Unit | High |
| Email notifications | Unit | Medium |
| Pink email templates | Visual | Medium |

**Coverage Target:** 80%

### consciousness-revolution

**Test Location:** `/tests/` (when created)

**Key Test Areas:**
| Area | Type | Priority |
|------|------|----------|
| Sync mechanism | Integration | Critical |
| State management | Unit | High |
| Multi-computer comm | Integration | Critical |
| Offline handling | Integration | High |
| Data persistence | Integration | High |

### 100x-platform

**Test Location:** `/tests/` (when created)

**Key Test Areas:**
| Area | Type | Priority |
|------|------|----------|
| UI components | Unit | High |
| Pink color display | Visual | High |
| Responsive design | E2E | Medium |
| User interactions | E2E | High |
| Performance | Load | Medium |

### The-Pink-Revolution-Plan

**Test Type:** Documentation validation

**Checks:**
- [ ] All links work
- [ ] Markdown renders correctly
- [ ] No broken images
- [ ] Consistent formatting

---

## Test Configuration

### Non-Blocking Tests

Tests are configured to **inform but not block** deployments:

```yaml
# Example workflow configuration
continue-on-error: true
```

**Rationale:**
- Enables rapid iteration
- Prevents test flakiness from blocking releases
- Teams review test results, decide on action

### Test Environment Variables

```bash
# Common test environment setup
NODE_ENV=test
TEST_DATABASE_URL=postgresql://test:test@localhost:5432/test_db
DISABLE_RATE_LIMITING=true
```

---

## Writing Good Tests

### Test Naming Convention

```
[unit/integration/e2e]_[what]_[expected result]

Examples:
- unit_calculateTotal_returnsZeroForEmptyCart
- integration_loginEndpoint_returns401ForInvalidCredentials
- e2e_checkoutFlow_completesSuccessfully
```

### Test Structure (AAA Pattern)

```javascript
it('should do something', () => {
  // Arrange - Set up test data
  const input = prepareTestData();

  // Act - Perform the action
  const result = functionUnderTest(input);

  // Assert - Verify the result
  expect(result).toBe(expectedValue);
});
```

### What to Test

**DO test:**
- Business logic
- Edge cases
- Error handling
- Security-critical paths
- Pink color values

**DON'T test:**
- External libraries
- Framework internals
- Trivial getters/setters
- Implementation details

---

## Pink Revolution Testing

### Color Verification

**Manual Testing Checklist:**
- [ ] All buttons use pink (#FF1493 or #FF69B4)
- [ ] No blue colors remain (#007bff, #2196F3, etc.)
- [ ] Text is readable on pink backgrounds
- [ ] Hover states maintain pink theme
- [ ] Email templates render pink correctly

**Automated Color Check (example):**
```javascript
const PINK_COLORS = ['#FF1493', '#FF69B4', '#FFB6C1', '#9370DB'];
const BANNED_BLUES = ['#007bff', '#2196F3', '#1976D2', '#0000FF'];

function validateColors(cssContent) {
  const hasBlue = BANNED_BLUES.some(blue =>
    cssContent.toLowerCase().includes(blue.toLowerCase())
  );

  if (hasBlue) {
    throw new Error('Blue color detected! Pink Revolution violated.');
  }

  return true;
}
```

### Visual Regression Testing

For UI changes:
1. Capture baseline screenshots
2. Run tests after changes
3. Compare for differences
4. Verify pink colors intact

---

## Running Tests

### Local Development

```bash
# Run all tests
npm test

# Run specific test file
npm test -- path/to/test.js

# Run with coverage
npm test -- --coverage

# Watch mode (re-run on changes)
npm test -- --watch
```

### CI/CD Pipeline

Tests run automatically on:
- Every push to feature branches
- Every pull request
- Before deployment to staging/production

### Test Results

Results are available:
- In GitHub Actions logs
- Via Operation Purple notifications
- In coverage reports (when configured)

---

## Test Data Management

### Test Fixtures

Use fixtures for consistent test data:

```javascript
// fixtures/users.js
module.exports = {
  validUser: {
    email: 'test@example.com',
    password: 'SecurePass123!'
  },
  invalidUser: {
    email: 'invalid',
    password: ''
  }
};
```

### Database Testing

```javascript
// Before each test
beforeEach(async () => {
  await database.migrate();
  await database.seed();
});

// After each test
afterEach(async () => {
  await database.cleanup();
});
```

---

## Debugging Failed Tests

### Troubleshooting Steps

1. **Read the error message** - Often tells you exactly what's wrong
2. **Check test isolation** - Does it pass when run alone?
3. **Verify test data** - Is the fixture correct?
4. **Check environment** - Are env vars set correctly?
5. **Review recent changes** - What changed since it last passed?

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Flaky tests | Race conditions | Add proper async/await |
| Timeout | Slow operations | Increase timeout, optimize |
| Database errors | Missing migrations | Run migrations first |
| Network errors | External dependency | Mock the dependency |

---

## Coverage Reports

### Understanding Coverage

| Metric | Description | Target |
|--------|-------------|--------|
| Statements | Lines executed | > 80% |
| Branches | If/else paths | > 70% |
| Functions | Functions called | > 80% |
| Lines | Total lines | > 80% |

### Generating Reports

```bash
npm test -- --coverage --coverageReporters=html

# View report
open coverage/index.html
```

### What Coverage Doesn't Tell You

- Test quality
- Edge case coverage
- Real-world scenarios
- Pink compliance

---

## Test Maintenance

### Regular Tasks

| Task | Frequency | Responsibility |
|------|-----------|----------------|
| Review flaky tests | Weekly | Team |
| Update test data | As needed | Contributor |
| Review coverage | Monthly | Team lead |
| Clean up old tests | Quarterly | Team |

### When to Update Tests

- When code behavior changes
- When new edge cases discovered
- When tests become flaky
- When Pink colors change

---

## Resources

### Related Documentation
- [CONTRIBUTING.md](../CONTRIBUTING.md) - How to contribute tests
- [CODE_REVIEW.md](../CODE_REVIEW.md) - Review process for test changes
- [docs/DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) - How tests fit in deployment

### Tools Used
- Jest (JavaScript testing)
- GitHub Actions (CI/CD)
- Operation Purple (notifications)

---

## Quick Reference

```
┌──────────────────────────────────────────────────────────┐
│                   TESTING QUICK GUIDE                    │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  TEST TYPES:                                             │
│  Unit → Fast, isolated     Integration → Components      │
│  E2E → Full workflows      Visual → Pink verification    │
│                                                          │
│  RUN TESTS:                                              │
│  npm test                    - All tests                 │
│  npm test -- --coverage      - With coverage             │
│  npm test -- --watch         - Watch mode                │
│                                                          │
│  PINK TESTING:                                           │
│  ✓ #FF1493 (Primary)    ✓ #FF69B4 (Secondary)           │
│  ✗ #007bff (Blue)       ✗ #2196F3 (Blue)                │
│                                                          │
│  COVERAGE TARGETS:                                       │
│  Statements: 80%   Branches: 70%   Functions: 80%       │
│                                                          │
│  AAA PATTERN:                                            │
│  Arrange → Act → Assert                                  │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

💗 **TEST WITH CONFIDENCE** 💗

