# Code Review Guidelines

**Organization:** OVERKOR-TEK
**Last Updated:** 2025-11-27
**Updated By:** CP2C2

---

## Overview

This document establishes code review standards and processes for all OVERKOR-TEK repositories. Reviews ensure code quality, knowledge sharing, and alignment with Pink Revolution standards.

---

## Core Principles

### The Trinity Review Philosophy

```
C1 × C2 × C3 = ∞
Multiple perspectives multiply quality
```

Every review should embody:
- **LIGHTER** - Simplify, don't complicate
- **FASTER** - Ship with confidence
- **STRONGER** - Build resilience
- **ELEGANT** - Make it beautiful

---

## Review Process

### 1. Before Submitting PR

**Author Checklist:**
- [ ] Code compiles/builds without errors
- [ ] All tests pass locally
- [ ] Self-reviewed changes (fresh eyes after a break)
- [ ] Commit messages are clear and descriptive
- [ ] PR description explains the "why" not just "what"
- [ ] Pink color standards followed (if applicable)
- [ ] No hardcoded secrets or credentials

### 2. Submitting for Review

**PR Title Format:**
```
[type] Brief description

Types:
- [feat] New feature
- [fix] Bug fix
- [docs] Documentation
- [refactor] Code restructuring
- [test] Test additions/updates
- [pink] Pink Revolution changes
```

**PR Description Template:**
```markdown
## Summary
What does this PR do?

## Changes
- List of specific changes

## Testing
How was this tested?

## Screenshots (if UI changes)
Before/after images

## Pink Revolution
Any color changes? (Include hex codes)
```

### 3. During Review

**Reviewer Responsibilities:**
1. **Read the PR description first** - Understand context
2. **Check for Pink compliance** - Colors match standards
3. **Verify functionality** - Does it work as intended?
4. **Review for clarity** - Is code readable?
5. **Check for edge cases** - What could break?
6. **Provide constructive feedback** - Help, don't criticize

### 4. Review Comments

**Comment Types:**

| Prefix | Meaning | Action Required |
|--------|---------|-----------------|
| `[BLOCKER]` | Must fix before merge | Yes |
| `[SUGGESTION]` | Would improve code | Optional |
| `[QUESTION]` | Need clarification | Response needed |
| `[PRAISE]` | Good work! | None |
| `[NIT]` | Minor style issue | Optional |

**Example Comments:**
```
[BLOCKER] This exposes user credentials in the response
[SUGGESTION] Consider using a constant for this magic number
[QUESTION] What happens if the array is empty?
[PRAISE] Great test coverage here!
[NIT] Extra whitespace on line 42
```

### 5. Approving/Merging

**Approval Criteria:**
- [ ] All blockers resolved
- [ ] At least one approval (two for critical paths)
- [ ] CI/CD passes
- [ ] No unresolved conversations
- [ ] Pink standards verified

**Merge Strategy:**
- **Squash and merge** - For feature branches
- **Rebase and merge** - For clean history
- **Merge commit** - For long-running branches

---

## Review Timelines

| PR Type | Expected Review Time |
|---------|---------------------|
| Hot fix | < 2 hours |
| Bug fix | < 24 hours |
| Feature | < 48 hours |
| Documentation | < 24 hours |
| Pink Revolution | < 24 hours |

---

## Pink Revolution Specific Reviews

### Color Change Reviews

When reviewing Pink Revolution changes:

1. **Verify hex codes:**
   ```
   Primary:   #FF1493 (Deep Pink)
   Secondary: #FF69B4 (Hot Pink)
   Light:     #FFB6C1 (Light Pink)
   Accent:    #9370DB (Medium Purple)
   ```

2. **Check contrast ratios:**
   - Text must be readable against backgrounds
   - Minimum 4.5:1 for normal text
   - Minimum 3:1 for large text

3. **Verify blue removal:**
   - No blue remaining (unless intentional)
   - Check CSS, HTML, and JS files
   - Verify email templates

4. **Test visibility:**
   - Buttons visible on all backgrounds
   - Links distinguishable from text
   - Error states still clear

---

## Repository-Specific Guidelines

### philosopher-ai-backend
- Focus on API security
- Verify Cyclotron integration
- Check database query efficiency
- Review rate limiting logic

### consciousness-revolution
- Verify sync mechanism integrity
- Check multi-computer compatibility
- Review state management
- Test offline scenarios

### 100x-platform
- Review UI/UX consistency
- Check responsive design
- Verify pink color application
- Test cross-browser compatibility

### The-Pink-Revolution-Plan
- Documentation accuracy
- Link validation
- Markdown formatting
- Consistent styling

---

## Handling Disagreements

### Resolution Process

1. **Discuss in PR comments** - Most issues resolved here
2. **Sync call if needed** - Complex architectural decisions
3. **Escalate to team lead** - If impasse continues
4. **Document decision** - For future reference

### Decision Framework

When opinions differ:
1. What does the data say?
2. What's the impact on users?
3. What's the maintenance cost?
4. Does it align with Pink Revolution values?

---

## Automation

### Pre-Review Checks

CI/CD automatically verifies:
- [ ] Build passes
- [ ] Tests pass
- [ ] Linting passes (when configured)
- [ ] Security scan (for sensitive repos)

### Operation Purple Integration

All PR activity triggers Operation Purple notifications for team visibility.

---

## Recognition

### Review Excellence

Outstanding reviewers demonstrate:
- Thorough but timely reviews
- Constructive and kind feedback
- Knowledge sharing
- Pink Revolution advocacy

### Metrics Tracked

- Average review time
- Review thoroughness (bugs caught)
- Author satisfaction
- Knowledge distribution

---

## Resources

### Related Documents
- [CONTRIBUTING.md](./CONTRIBUTING.md) - Contribution guidelines
- [docs/COLOR_STANDARDS.md](./docs/COLOR_STANDARDS.md) - Pink palette
- [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md) - Community standards

### Tools
- GitHub Pull Requests
- Operation Purple notifications
- CI/CD pipelines

---

## Quick Reference Card

```
┌──────────────────────────────────────────────────────────┐
│                   CODE REVIEW QUICK GUIDE                │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  BEFORE SUBMITTING:                                      │
│  ✓ Tests pass    ✓ Self-reviewed    ✓ Clear PR desc     │
│                                                          │
│  COMMENT PREFIXES:                                       │
│  [BLOCKER] - Must fix    [SUGGESTION] - Optional         │
│  [QUESTION] - Clarify    [PRAISE] - Good work!          │
│                                                          │
│  PINK COLORS:                                            │
│  #FF1493 Primary    #FF69B4 Secondary    #FFB6C1 Light  │
│                                                          │
│  REVIEW TIMES:                                           │
│  Hot fix: 2h    Bug: 24h    Feature: 48h    Docs: 24h   │
│                                                          │
│  VALUES:                                                 │
│  LIGHTER • FASTER • STRONGER • ELEGANT                  │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

💗 **REVIEW WITH LOVE** 💗

