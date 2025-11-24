# ⚡ Performance Optimization Guide

**Complete guide to performance optimization for overkor-tek systems**

**Last Updated:** November 24, 2024

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Performance Goals](#performance-goals)
3. [Backend Performance](#backend-performance)
4. [Frontend Performance](#frontend-performance)
5. [Database Optimization](#database-optimization)
6. [Caching Strategies](#caching-strategies)
7. [Network Optimization](#network-optimization)
8. [Monitoring Performance](#monitoring-performance)

---

## 🎯 Overview

Performance directly impacts user experience, costs, and system reliability. This guide covers optimization strategies for all overkor-tek services.

### Why Performance Matters

- **User Experience** - Fast = better UX
- **SEO** - Google ranks faster sites higher
- **Conversion** - 100ms delay = 1% revenue loss
- **Costs** - Efficient code = lower hosting costs
- **Scalability** - Optimized systems scale better

### Performance Philosophy

**"Premature optimization is the root of all evil." - Donald Knuth**

- Measure first, optimize second
- Focus on bottlenecks
- Profile before optimizing
- Keep it simple

---

## 🎯 Performance Goals

### Response Time Targets

**API Endpoints:**
- **p50 (median):** < 100ms
- **p95:** < 500ms
- **p99:** < 1000ms
- **p99.9:** < 2000ms

**Web Pages:**
- **First Contentful Paint (FCP):** < 1.8s
- **Time to Interactive (TTI):** < 3.8s
- **Largest Contentful Paint (LCP):** < 2.5s

**Database Queries:**
- **Simple queries:** < 10ms
- **Complex queries:** < 100ms
- **Reports/Analytics:** < 1000ms

### Throughput Targets

- **philosopher-ai-backend:** 1000+ req/s
- **consciousness-revolution:** 100+ sync operations/min
- **Database:** 10,000+ queries/s

---

## 🖥️ Backend Performance

### Node.js Optimization

**1. Use Async/Await Properly**

```javascript
// Bad - Blocking
function getUsers() {
  const users = db.query('SELECT * FROM users');
  return users;
}

// Good - Non-blocking
async function getUsers() {
  const users = await db.query('SELECT * FROM users');
  return users;
}

// Better - Parallel execution
async function getUserWithPosts(userId) {
  const [user, posts] = await Promise.all([
    db.query('SELECT * FROM users WHERE id = $1', [userId]),
    db.query('SELECT * FROM posts WHERE user_id = $1', [userId])
  ]);

  return { user, posts };
}
```

**2. Stream Large Responses**

```javascript
// Bad - Load everything into memory
app.get('/export/users', async (req, res) => {
  const users = await db.query('SELECT * FROM users');
  const csv = convertToCSV(users); // All in memory!
  res.send(csv);
});

// Good - Stream data
app.get('/export/users', async (req, res) => {
  const stream = db.query(
    new QueryStream('SELECT * FROM users')
  );

  res.setHeader('Content-Type', 'text/csv');

  stream
    .pipe(csvTransform())
    .pipe(res);
});
```

**3. Use Connection Pooling**

```javascript
// Good - Reuse connections
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  max: 20, // Max connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Use pool for all queries
async function getUser(id) {
  const result = await pool.query(
    'SELECT * FROM users WHERE id = $1',
    [id]
  );
  return result.rows[0];
}
```

**4. Implement Request Timeouts**

```javascript
// Prevent hanging requests
app.use((req, res, next) => {
  // Set 30 second timeout
  req.setTimeout(30000, () => {
    res.status(408).json({
      error: 'Request timeout'
    });
  });
  next();
});
```

**5. Use Compression**

```javascript
const compression = require('compression');

app.use(compression({
  level: 6, // Compression level (0-9)
  threshold: 1024, // Only compress responses > 1KB
  filter: (req, res) => {
    // Don't compress if client doesn't support it
    if (req.headers['x-no-compression']) {
      return false;
    }
    return compression.filter(req, res);
  }
}));
```

### API Optimization

**1. Pagination**

```javascript
// Bad - Return everything
app.get('/users', async (req, res) => {
  const users = await db.query('SELECT * FROM users');
  res.json(users);
});

// Good - Paginate
app.get('/users', async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 20;
  const offset = (page - 1) * limit;

  const [users, total] = await Promise.all([
    db.query(
      'SELECT * FROM users LIMIT $1 OFFSET $2',
      [limit, offset]
    ),
    db.query('SELECT COUNT(*) FROM users')
  ]);

  res.json({
    data: users.rows,
    pagination: {
      page,
      limit,
      total: parseInt(total.rows[0].count),
      pages: Math.ceil(total.rows[0].count / limit)
    }
  });
});
```

**2. Field Selection**

```javascript
// Bad - Return all fields
app.get('/users/:id', async (req, res) => {
  const user = await db.query(
    'SELECT * FROM users WHERE id = $1',
    [req.params.id]
  );
  res.json(user.rows[0]);
});

// Good - Let client select fields
app.get('/users/:id', async (req, res) => {
  const fields = req.query.fields || 'id,name,email';
  const allowedFields = ['id', 'name', 'email', 'created_at'];

  // Validate and sanitize fields
  const selectedFields = fields
    .split(',')
    .filter(f => allowedFields.includes(f))
    .join(',');

  const user = await db.query(
    `SELECT ${selectedFields} FROM users WHERE id = $1`,
    [req.params.id]
  );

  res.json(user.rows[0]);
});
```

**3. Batch Requests**

```javascript
// Bad - Multiple requests
for (const userId of userIds) {
  await fetch(`/api/users/${userId}`);
}

// Good - Single batch request
await fetch('/api/users/batch', {
  method: 'POST',
  body: JSON.stringify({ ids: userIds })
});

// API implementation
app.post('/users/batch', async (req, res) => {
  const ids = req.body.ids;

  if (ids.length > 100) {
    return res.status(400).json({
      error: 'Too many IDs (max 100)'
    });
  }

  const users = await db.query(
    'SELECT * FROM users WHERE id = ANY($1)',
    [ids]
  );

  res.json(users.rows);
});
```

---

## 🌐 Frontend Performance

### Loading Performance

**1. Code Splitting**

```javascript
// Bad - Bundle everything
import HugeComponent from './HugeComponent';

// Good - Load on demand
const HugeComponent = lazy(() => import('./HugeComponent'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <HugeComponent />
    </Suspense>
  );
}
```

**2. Image Optimization**

```html
<!-- Bad -->
<img src="huge-image.jpg" />

<!-- Good - Responsive images -->
<img
  src="image-800.jpg"
  srcset="image-400.jpg 400w,
          image-800.jpg 800w,
          image-1200.jpg 1200w"
  sizes="(max-width: 600px) 400px,
         (max-width: 1200px) 800px,
         1200px"
  alt="Description"
  loading="lazy"
/>

<!-- Best - Modern formats with fallback -->
<picture>
  <source srcset="image.avif" type="image/avif" />
  <source srcset="image.webp" type="image/webp" />
  <img src="image.jpg" alt="Description" loading="lazy" />
</picture>
```

**3. Lazy Loading**

```javascript
// Lazy load images
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      observer.unobserve(img);
    }
  });
});

document.querySelectorAll('img[data-src]').forEach(img => {
  observer.observe(img);
});
```

### Runtime Performance

**1. Memoization**

```javascript
// Bad - Recalculate on every render
function Component({ users }) {
  const activeUsers = users.filter(u => u.active);
  return <List items={activeUsers} />;
}

// Good - Only recalculate when users change
function Component({ users }) {
  const activeUsers = useMemo(
    () => users.filter(u => u.active),
    [users]
  );
  return <List items={activeUsers} />;
}
```

**2. Debouncing**

```javascript
// Bad - Fire on every keystroke
function SearchInput() {
  const [query, setQuery] = useState('');

  const handleChange = (e) => {
    setQuery(e.target.value);
    searchAPI(e.target.value); // Too many requests!
  };

  return <input onChange={handleChange} />;
}

// Good - Debounce search
function SearchInput() {
  const [query, setQuery] = useState('');

  const debouncedSearch = useMemo(
    () => debounce(searchAPI, 300),
    []
  );

  const handleChange = (e) => {
    setQuery(e.target.value);
    debouncedSearch(e.target.value);
  };

  return <input onChange={handleChange} />;
}
```

**3. Virtual Lists**

```javascript
// Bad - Render 10,000 items
function List({ items }) {
  return (
    <div>
      {items.map(item => <Item key={item.id} {...item} />)}
    </div>
  );
}

// Good - Only render visible items
import { FixedSizeList } from 'react-window';

function List({ items }) {
  return (
    <FixedSizeList
      height={600}
      itemCount={items.length}
      itemSize={50}
      width="100%"
    >
      {({ index, style }) => (
        <div style={style}>
          <Item {...items[index]} />
        </div>
      )}
    </FixedSizeList>
  );
}
```

---

## 🗄️ Database Optimization

### Query Optimization

**1. Use Indexes**

```sql
-- Bad - Full table scan
SELECT * FROM users WHERE email = 'user@example.com';

-- Good - With index
CREATE INDEX idx_users_email ON users(email);
SELECT * FROM users WHERE email = 'user@example.com';

-- Compound index for common queries
CREATE INDEX idx_users_active_created
ON users(active, created_at DESC);

SELECT * FROM users
WHERE active = true
ORDER BY created_at DESC
LIMIT 10;
```

**2. Avoid N+1 Queries**

```javascript
// Bad - N+1 queries
const users = await db.query('SELECT * FROM users');

for (const user of users.rows) {
  // One query per user!
  user.posts = await db.query(
    'SELECT * FROM posts WHERE user_id = $1',
    [user.id]
  );
}

// Good - JOIN or batch query
const result = await db.query(`
  SELECT
    u.*,
    json_agg(p.*) as posts
  FROM users u
  LEFT JOIN posts p ON p.user_id = u.id
  GROUP BY u.id
`);
```

**3. Use EXPLAIN ANALYZE**

```sql
-- Analyze query performance
EXPLAIN ANALYZE
SELECT * FROM users
WHERE created_at > '2024-01-01'
AND active = true
ORDER BY created_at DESC
LIMIT 100;

-- Look for:
-- - Sequential Scans (bad)
-- - Index Scans (good)
-- - High execution time
-- - High cost
```

**4. Optimize Counts**

```sql
-- Bad - Slow on large tables
SELECT COUNT(*) FROM users;

-- Good - Use estimate for large tables
SELECT reltuples::bigint AS estimate
FROM pg_class
WHERE relname = 'users';

-- Or add a counter table
CREATE TABLE counters (
  table_name VARCHAR(255) PRIMARY KEY,
  count BIGINT NOT NULL DEFAULT 0
);

-- Update with triggers
CREATE TRIGGER update_users_count
AFTER INSERT OR DELETE ON users
FOR EACH ROW EXECUTE FUNCTION update_counter();
```

### Connection Management

**1. Use Connection Pooling**

```javascript
// Configure pool
const pool = new Pool({
  max: 20, // Maximum connections
  min: 5,  // Minimum connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
  maxUses: 7500, // Recycle connections
});

// Monitor pool
pool.on('connect', () => {
  console.log('New client connected');
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
});
```

**2. Release Connections Properly**

```javascript
// Bad - Connection leak
async function getUser(id) {
  const client = await pool.connect();
  const result = await client.query('SELECT * FROM users WHERE id = $1', [id]);
  return result.rows[0];
  // Connection never released!
}

// Good - Always release
async function getUser(id) {
  const client = await pool.connect();
  try {
    const result = await client.query('SELECT * FROM users WHERE id = $1', [id]);
    return result.rows[0];
  } finally {
    client.release();
  }
}

// Better - Use pool directly
async function getUser(id) {
  const result = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
  return result.rows[0];
}
```

---

## 💾 Caching Strategies

### Types of Caching

**1. In-Memory Cache (Fast)**

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 }); // 10 minutes

async function getUser(id) {
  // Check cache first
  const cached = cache.get(`user:${id}`);
  if (cached) return cached;

  // Fetch from database
  const user = await db.query('SELECT * FROM users WHERE id = $1', [id]);

  // Store in cache
  cache.set(`user:${id}`, user.rows[0]);

  return user.rows[0];
}
```

**2. Redis Cache (Distributed)**

```javascript
const redis = require('redis');
const client = redis.createClient();

async function getUser(id) {
  // Check Redis
  const cached = await client.get(`user:${id}`);
  if (cached) return JSON.parse(cached);

  // Fetch from database
  const user = await db.query('SELECT * FROM users WHERE id = $1', [id]);

  // Store in Redis with TTL
  await client.setex(
    `user:${id}`,
    600, // 10 minutes
    JSON.stringify(user.rows[0])
  );

  return user.rows[0];
}
```

**3. HTTP Caching**

```javascript
// Set cache headers
app.get('/api/public/data', (req, res) => {
  res.set({
    'Cache-Control': 'public, max-age=3600', // 1 hour
    'ETag': generateETag(data),
    'Last-Modified': data.updatedAt
  });

  res.json(data);
});

// Handle conditional requests
app.get('/api/data', (req, res) => {
  const etag = generateETag(data);

  if (req.headers['if-none-match'] === etag) {
    return res.status(304).end(); // Not Modified
  }

  res.set('ETag', etag);
  res.json(data);
});
```

### Cache Invalidation

```javascript
// Invalidate on update
async function updateUser(id, updates) {
  // Update database
  await db.query(
    'UPDATE users SET name = $1 WHERE id = $2',
    [updates.name, id]
  );

  // Invalidate cache
  cache.del(`user:${id}`);

  // Or update cache
  const user = await getUser(id);
  cache.set(`user:${id}`, user);
}

// Time-based invalidation
cache.set(`user:${id}`, user, 600); // Expires in 10 minutes

// Event-based invalidation
eventEmitter.on('user:updated', (userId) => {
  cache.del(`user:${userId}`);
});
```

---

## 🌐 Network Optimization

### Reduce Payload Size

**1. Compression**

```javascript
// Enable gzip/brotli
app.use(compression());

// Or at nginx level
# nginx.conf
gzip on;
gzip_types text/plain text/css application/json application/javascript;
gzip_min_length 1000;
```

**2. Minimize JSON**

```javascript
// Before - Verbose
{
  "firstName": "John",
  "lastName": "Doe",
  "emailAddress": "john@example.com"
}

// After - Concise
{
  "fn": "John",
  "ln": "Doe",
  "email": "john@example.com"
}
```

### CDN Usage

```javascript
// Serve static assets from CDN
const CDN_URL = process.env.CDN_URL || '';

app.locals.cdn = (path) => {
  return process.env.NODE_ENV === 'production'
    ? `${CDN_URL}${path}`
    : path;
};

// In templates
<script src="<%= cdn('/js/app.js') %>"></script>
```

### HTTP/2 Server Push

```javascript
// Push critical resources
app.get('/', (req, res) => {
  // Push CSS and JS before HTML
  res.push('/css/app.css');
  res.push('/js/app.js');

  res.render('index');
});
```

---

## 📊 Monitoring Performance

### Performance Metrics

```javascript
// Track response times
app.use((req, res, next) => {
  const start = Date.now();

  res.on('finish', () => {
    const duration = Date.now() - start;

    // Log slow requests
    if (duration > 1000) {
      logger.warn('Slow request', {
        path: req.path,
        method: req.method,
        duration
      });
    }

    // Track metric
    metrics.histogram('http.response_time', duration, {
      path: req.route?.path || req.path,
      method: req.method
    });
  });

  next();
});
```

### Profiling

```javascript
// Node.js built-in profiler
node --prof app.js

// Generate report
node --prof-process isolate-0xNNNNN-v8.log > profile.txt

// Use Chrome DevTools
node --inspect app.js
// Open chrome://inspect
```

### Load Testing

```bash
# Apache Bench
ab -n 10000 -c 100 http://localhost:3000/api/users

# wrk
wrk -t4 -c100 -d30s http://localhost:3000/api/users

# k6
k6 run load-test.js
```

---

## ✅ Performance Checklist

### Backend
- [ ] Async/await used properly
- [ ] Connection pooling configured
- [ ] Streaming for large responses
- [ ] Compression enabled
- [ ] Request timeouts set
- [ ] Rate limiting implemented

### Database
- [ ] Indexes on common queries
- [ ] No N+1 queries
- [ ] Query execution plans reviewed
- [ ] Connection pooling used
- [ ] Slow query logging enabled

### Caching
- [ ] Cache strategy defined
- [ ] Cache invalidation implemented
- [ ] HTTP caching headers set
- [ ] CDN configured for static assets

### Monitoring
- [ ] Response time tracked
- [ ] Slow queries logged
- [ ] Error rates monitored
- [ ] Load testing performed

---

**💖 The Pink Revolution continues with blazing performance! ⚡💖**

*"Performance is a feature."*

---

*Last Updated: November 24, 2024*
