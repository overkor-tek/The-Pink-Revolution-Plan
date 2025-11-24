# 📊 Monitoring & Observability Guide

**Complete guide to monitoring, logging, and observability for overkor-tek systems**

**Last Updated:** November 24, 2024

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [The Three Pillars](#the-three-pillars)
3. [Application Monitoring](#application-monitoring)
4. [Infrastructure Monitoring](#infrastructure-monitoring)
5. [Logging Best Practices](#logging-best-practices)
6. [Alerting Strategy](#alerting-strategy)
7. [Dashboards](#dashboards)
8. [Incident Response](#incident-response)

---

## 🎯 Overview

Monitoring and observability are critical for maintaining reliable, performant systems. This guide covers standards and practices for all overkor-tek services.

### Why Monitor?

- **Detect Issues Early** - Catch problems before users do
- **Understand Performance** - Know how systems behave
- **Debug Faster** - Quick root cause analysis
- **Capacity Planning** - Know when to scale
- **User Experience** - Measure real user impact

### Philosophy

**"You can't improve what you don't measure."**

- Monitor what matters
- Alert on symptoms, not causes
- Make data actionable
- Keep it simple

---

## 🏛️ The Three Pillars

### 1. Metrics

**What:** Numerical measurements over time
**When:** Continuous
**Examples:** Request rate, error rate, latency, CPU usage

**Key Metrics:**
```
# Application Metrics
- Request rate (requests/second)
- Error rate (errors/total requests)
- Response time (p50, p95, p99)
- Active connections
- Queue depth

# Infrastructure Metrics
- CPU usage (%)
- Memory usage (%)
- Disk I/O (ops/sec)
- Network throughput (MB/s)
- Disk space (% used)
```

### 2. Logs

**What:** Discrete events with context
**When:** On demand
**Examples:** Error messages, user actions, system events

**Log Levels:**
```
ERROR   - Something failed
WARN    - Something unexpected
INFO    - Normal operations
DEBUG   - Detailed debugging info
TRACE   - Very detailed (development only)
```

### 3. Traces

**What:** Request flow through distributed systems
**When:** Sample-based
**Examples:** API call path, database queries, external service calls

**Trace Components:**
- Spans: Individual operations
- Context: Correlation IDs
- Timing: Duration of each operation
- Dependencies: Service relationships

---

## 📱 Application Monitoring

### Health Checks

**Implement health endpoints:**

```javascript
// Basic health check
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.npm_package_version
  });
});

// Detailed health check
app.get('/health/detailed', async (req, res) => {
  const health = {
    status: 'ok',
    timestamp: new Date().toISOString(),
    services: {}
  };

  // Check database
  try {
    await db.query('SELECT 1');
    health.services.database = { status: 'ok' };
  } catch (error) {
    health.status = 'degraded';
    health.services.database = {
      status: 'error',
      message: error.message
    };
  }

  // Check external services
  // ... similar checks

  const statusCode = health.status === 'ok' ? 200 : 503;
  res.status(statusCode).json(health);
});
```

### Request Metrics

**Track request patterns:**

```javascript
// Middleware for request metrics
app.use((req, res, next) => {
  const start = Date.now();

  // Track response
  res.on('finish', () => {
    const duration = Date.now() - start;

    metrics.increment('http.requests.total', {
      method: req.method,
      path: req.route?.path || req.path,
      status: res.statusCode
    });

    metrics.histogram('http.request.duration', duration, {
      method: req.method,
      path: req.route?.path || req.path
    });

    if (res.statusCode >= 500) {
      metrics.increment('http.requests.errors', {
        method: req.method,
        path: req.route?.path || req.path,
        status: res.statusCode
      });
    }
  });

  next();
});
```

### Error Tracking

**Capture and report errors:**

```javascript
// Error handler middleware
app.use((err, req, res, next) => {
  // Log error
  logger.error('Request error', {
    error: err.message,
    stack: err.stack,
    path: req.path,
    method: req.method,
    user: req.user?.id,
    requestId: req.id
  });

  // Track error metric
  metrics.increment('errors.total', {
    type: err.name,
    path: req.path
  });

  // Send to error tracking service (e.g., Sentry)
  if (process.env.NODE_ENV === 'production') {
    errorTracker.captureException(err, {
      user: { id: req.user?.id },
      tags: { path: req.path, method: req.method }
    });
  }

  // Return error response
  res.status(err.status || 500).json({
    success: false,
    error: {
      message: process.env.NODE_ENV === 'production'
        ? 'Internal server error'
        : err.message
    }
  });
});
```

### Custom Business Metrics

**Track business-specific metrics:**

```javascript
// User registration
async function registerUser(userData) {
  const start = Date.now();

  try {
    const user = await createUser(userData);

    // Track success
    metrics.increment('users.registered');
    metrics.histogram('users.registration.duration', Date.now() - start);

    return user;
  } catch (error) {
    // Track failure
    metrics.increment('users.registration.failed', {
      reason: error.code
    });
    throw error;
  }
}

// Pink Revolution transformations
function applyPinkTransformation(file) {
  const changes = transformColors(file);

  metrics.increment('pink_revolution.transformations', {
    file_type: path.extname(file)
  });

  metrics.gauge('pink_revolution.colors_transformed', changes.length);

  return changes;
}
```

---

## 🖥️ Infrastructure Monitoring

### System Metrics

**Monitor server resources:**

```javascript
// Collect system metrics
const os = require('os');

setInterval(() => {
  // CPU
  const cpus = os.cpus();
  const cpuUsage = cpus.reduce((acc, cpu) => {
    const total = Object.values(cpu.times).reduce((a, b) => a + b);
    const idle = cpu.times.idle;
    return acc + ((total - idle) / total);
  }, 0) / cpus.length * 100;

  metrics.gauge('system.cpu.usage', cpuUsage);

  // Memory
  const totalMem = os.totalmem();
  const freeMem = os.freemem();
  const usedMem = totalMem - freeMem;
  const memUsage = (usedMem / totalMem) * 100;

  metrics.gauge('system.memory.usage', memUsage);
  metrics.gauge('system.memory.used', usedMem);
  metrics.gauge('system.memory.free', freeMem);

  // Load average
  const loadAvg = os.loadavg();
  metrics.gauge('system.load.1min', loadAvg[0]);
  metrics.gauge('system.load.5min', loadAvg[1]);
  metrics.gauge('system.load.15min', loadAvg[2]);

}, 60000); // Every minute
```

### Database Monitoring

**Track database performance:**

```javascript
// PostgreSQL monitoring
async function monitorDatabase() {
  // Connection pool stats
  metrics.gauge('db.pool.size', pool.totalCount);
  metrics.gauge('db.pool.idle', pool.idleCount);
  metrics.gauge('db.pool.waiting', pool.waitingCount);

  // Query performance
  db.on('query', (query) => {
    const start = Date.now();

    query.on('end', () => {
      const duration = Date.now() - start;

      metrics.histogram('db.query.duration', duration, {
        type: query.text.split(' ')[0] // SELECT, INSERT, etc.
      });

      if (duration > 1000) {
        logger.warn('Slow query detected', {
          query: query.text,
          duration
        });
      }
    });
  });

  // Active connections
  const result = await db.query(`
    SELECT count(*) as active_connections
    FROM pg_stat_activity
    WHERE state = 'active'
  `);

  metrics.gauge('db.connections.active', result.rows[0].active_connections);
}
```

### External Service Monitoring

**Monitor third-party dependencies:**

```javascript
// Monitor external API calls
async function callExternalAPI(url, options) {
  const start = Date.now();
  const service = new URL(url).hostname;

  try {
    const response = await fetch(url, options);
    const duration = Date.now() - start;

    metrics.histogram('external.api.duration', duration, {
      service,
      status: response.status
    });

    if (!response.ok) {
      metrics.increment('external.api.errors', {
        service,
        status: response.status
      });
    }

    return response;
  } catch (error) {
    metrics.increment('external.api.failures', {
      service,
      error: error.name
    });
    throw error;
  }
}
```

---

## 📝 Logging Best Practices

### Structured Logging

**Use structured logs (JSON):**

```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: {
    service: 'philosopher-ai-backend',
    version: process.env.npm_package_version,
    environment: process.env.NODE_ENV
  },
  transports: [
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.simple()
      )
    }),
    new winston.transports.File({
      filename: 'logs/error.log',
      level: 'error'
    }),
    new winston.transports.File({
      filename: 'logs/combined.log'
    })
  ]
});

// Usage
logger.info('User logged in', {
  userId: user.id,
  email: user.email,
  ip: req.ip
});

logger.error('Database connection failed', {
  error: err.message,
  stack: err.stack,
  attemptNumber: retries
});
```

### What to Log

**DO Log:**
- ✅ Request/response (with IDs)
- ✅ Authentication events
- ✅ Errors with full context
- ✅ State changes
- ✅ External API calls
- ✅ Performance issues

**DON'T Log:**
- ❌ Passwords or secrets
- ❌ Credit card numbers
- ❌ Personal identification (PII)
- ❌ Full request bodies (could contain secrets)
- ❌ Internal system details in production

### Log Levels Usage

```javascript
// ERROR - Something broke
logger.error('Payment processing failed', {
  userId: user.id,
  amount: payment.amount,
  error: err.message
});

// WARN - Something unexpected
logger.warn('API rate limit approaching', {
  service: 'github',
  current: rateLimit.remaining,
  limit: rateLimit.limit
});

// INFO - Normal operations
logger.info('User created account', {
  userId: user.id,
  email: user.email
});

// DEBUG - Detailed information
logger.debug('Cache hit', {
  key: cacheKey,
  ttl: ttl
});
```

### Correlation IDs

**Track requests across services:**

```javascript
// Generate correlation ID middleware
app.use((req, res, next) => {
  req.id = req.headers['x-request-id'] || generateId();
  res.setHeader('x-request-id', req.id);
  next();
});

// Use in logs
logger.info('Processing request', {
  requestId: req.id,
  path: req.path,
  method: req.method
});

// Pass to external services
async function callService(url, data) {
  return fetch(url, {
    method: 'POST',
    headers: {
      'x-request-id': req.id,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });
}
```

---

## 🚨 Alerting Strategy

### Alert Priorities

**P0 - Critical (Page immediately)**
- Service completely down
- Data loss occurring
- Security breach

**P1 - High (Alert within 15 min)**
- Significant degradation
- High error rate (>5%)
- Database connection issues

**P2 - Medium (Alert within 1 hour)**
- Elevated error rate (>1%)
- Slow response times
- Resource usage high (>80%)

**P3 - Low (Daily summary)**
- Minor issues
- Warnings
- Informational

### Alert Rules

**Good alert rules:**

```yaml
# Error rate too high
- alert: HighErrorRate
  expr: (sum(rate(http_requests_errors[5m])) / sum(rate(http_requests_total[5m]))) > 0.05
  for: 5m
  labels:
    severity: P1
  annotations:
    summary: "Error rate above 5%"
    description: "Current error rate: {{ $value }}%"

# Response time too slow
- alert: SlowResponseTime
  expr: histogram_quantile(0.95, http_request_duration) > 2000
  for: 10m
  labels:
    severity: P2
  annotations:
    summary: "95th percentile response time > 2s"

# Service down
- alert: ServiceDown
  expr: up == 0
  for: 1m
  labels:
    severity: P0
  annotations:
    summary: "Service is down"
    description: "{{ $labels.instance }} has been down for 1 minute"
```

### Alert Fatigue Prevention

**Avoid alert fatigue:**

1. **Alert on symptoms, not causes**
   - ✅ "Users experiencing slow responses"
   - ❌ "CPU usage at 85%"

2. **Set appropriate thresholds**
   - Not too sensitive (false positives)
   - Not too lenient (miss issues)

3. **Group related alerts**
   - Don't alert on 100 servers individually
   - Alert on aggregate metrics

4. **Make alerts actionable**
   - Include runbook links
   - Provide context
   - Suggest next steps

---

## 📈 Dashboards

### Dashboard Types

**1. Service Health Dashboard**
- Overall status
- Request rate
- Error rate
- Response time (p50, p95, p99)
- Active users

**2. Infrastructure Dashboard**
- CPU/Memory/Disk usage
- Network throughput
- Database connections
- Queue depths

**3. Business Metrics Dashboard**
- User signups
- Active users
- Pink Revolution transformations
- Feature usage

**4. Pink Revolution Dashboard** 💖
- Colors transformed (total)
- Repositories transformed
- Transformation success rate
- Files processed

### Dashboard Best Practices

**Do:**
- ✅ One dashboard per service
- ✅ Most important metrics at top
- ✅ Use consistent time ranges
- ✅ Add descriptions to charts
- ✅ Use Pink Revolution colors! 💖

**Don't:**
- ❌ Too many metrics on one dashboard
- ❌ Vanity metrics (meaningless)
- ❌ Outdated dashboards
- ❌ No labels or units

---

## 🔥 Incident Response

### Incident Severity

**SEV-0 (Critical):**
- Service completely unavailable
- Data loss
- Security breach
- Revenue impact

**SEV-1 (High):**
- Major feature unavailable
- Significant performance degradation
- Affecting many users

**SEV-2 (Medium):**
- Minor feature unavailable
- Some users affected
- Workaround available

**SEV-3 (Low):**
- Cosmetic issues
- Minimal impact
- Can wait for normal deployment

### Incident Response Process

**1. Detection (Automated)**
```
Alert fires → On-call engineer notified
```

**2. Triage (< 5 minutes)**
```
- Acknowledge alert
- Assess severity
- Begin investigation
```

**3. Investigation**
```
- Check logs
- Review metrics
- Identify root cause
```

**4. Mitigation**
```
- Apply fix or rollback
- Verify resolution
- Document actions
```

**5. Post-Mortem**
```
- What happened?
- Why did it happen?
- How do we prevent it?
- Action items
```

### Incident Communication

**Status updates:**
- Every 15-30 minutes
- Clear, concise language
- What we know
- What we're doing
- Expected resolution time

**Post-Incident:**
- Timeline of events
- Root cause analysis
- Action items with owners
- No blame culture

---

## 🛠️ Tools & Services

### Recommended Tools

**Metrics:**
- Prometheus + Grafana (self-hosted)
- Datadog (SaaS)
- New Relic (SaaS)

**Logging:**
- ELK Stack (Elasticsearch, Logstash, Kibana)
- Loki + Grafana
- Papertrail (SaaS)

**Tracing:**
- Jaeger (self-hosted)
- Zipkin (self-hosted)
- Datadog APM (SaaS)

**Error Tracking:**
- Sentry (SaaS/self-hosted)
- Rollbar (SaaS)
- Bugsnag (SaaS)

**Uptime Monitoring:**
- UptimeRobot (free/paid)
- Pingdom (paid)
- StatusCake (free/paid)

### For overkor-tek (Current)

**philosopher-ai-backend:**
- Health checks: Built-in endpoints
- Logging: Winston (structured JSON)
- Metrics: TBD (recommend Prometheus)
- Hosting: Railway (built-in monitoring)

**consciousness-revolution:**
- Distributed system (unique challenges)
- File-based monitoring
- Git-based state tracking

---

## ✅ Monitoring Checklist

### Application

- [ ] Health check endpoint implemented
- [ ] Request metrics tracked
- [ ] Error tracking configured
- [ ] Structured logging implemented
- [ ] Correlation IDs used
- [ ] Business metrics tracked

### Infrastructure

- [ ] System metrics collected
- [ ] Database performance monitored
- [ ] External services monitored
- [ ] Disk space monitored
- [ ] Network monitored

### Alerting

- [ ] Critical alerts configured
- [ ] Alert severity defined
- [ ] On-call rotation set up
- [ ] Runbooks created
- [ ] Alert testing performed

### Dashboards

- [ ] Service health dashboard
- [ ] Infrastructure dashboard
- [ ] Business metrics dashboard
- [ ] Pink Revolution dashboard 💖

---

## 📚 Resources

### Internal Documentation
- [ARCHITECTURE.md](./ARCHITECTURE.md) - System architecture
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Deployment procedures
- [TESTING.md](./TESTING.md) - Testing guide

### External Resources
- [Prometheus Best Practices](https://prometheus.io/docs/practices/naming/)
- [Google SRE Book](https://sre.google/sre-book/table-of-contents/)
- [The Twelve-Factor App](https://12factor.net/)

---

**💖 The Pink Revolution continues with excellent monitoring! 💖**

*"You can't improve what you don't measure."*

---

*Last Updated: November 24, 2024*
