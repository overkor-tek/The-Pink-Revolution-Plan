# 🌐 API Documentation Template

**Template for documenting REST APIs across overkor-tek repositories**

---

## API Overview

### Base URL
```
Production: https://api.example.com/v1
Staging: https://staging-api.example.com/v1
Development: http://localhost:3000/v1
```

### Authentication
All API requests require authentication using JWT tokens.

```bash
Authorization: Bearer <your_jwt_token>
```

### Response Format
All responses are in JSON format with the following structure:

**Success Response:**
```json
{
  "success": true,
  "data": { ... },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

**Error Response:**
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": { ... }
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

### Rate Limiting
- **Rate Limit:** 1000 requests per hour per API key
- **Headers:**
  - `X-RateLimit-Limit`: Maximum requests allowed
  - `X-RateLimit-Remaining`: Requests remaining
  - `X-RateLimit-Reset`: Time when limit resets (Unix timestamp)

### Versioning
API versions are specified in the URL path: `/v1/`, `/v2/`, etc.

---

## Endpoints

### Authentication

#### POST /auth/login
Authenticate user and receive JWT token.

**Request:**
```http
POST /v1/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "secure_password"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "user_123",
      "email": "user@example.com",
      "name": "John Doe"
    },
    "expiresIn": "24h"
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

**Error Responses:**
- `401 Unauthorized`: Invalid credentials
- `429 Too Many Requests`: Rate limit exceeded

---

#### POST /auth/refresh
Refresh expired JWT token.

**Request:**
```http
POST /v1/auth/refresh
Content-Type: application/json
Authorization: Bearer <expired_token>

{
  "refreshToken": "refresh_token_here"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "token": "new_jwt_token",
    "expiresIn": "24h"
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

---

### Users

#### GET /users/:id
Get user information by ID.

**Request:**
```http
GET /v1/users/user_123
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-11-24T12:00:00Z"
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

**Error Responses:**
- `401 Unauthorized`: Missing or invalid token
- `404 Not Found`: User not found

---

#### PUT /users/:id
Update user information.

**Request:**
```http
PUT /v1/users/user_123
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "jane@example.com",
    "name": "Jane Doe",
    "updatedAt": "2024-11-24T12:00:00Z"
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

---

### Health & Status

#### GET /health
Health check endpoint (no authentication required).

**Request:**
```http
GET /v1/health
```

**Response (200 OK):**
```json
{
  "status": "ok",
  "timestamp": "2024-11-24T12:00:00Z",
  "uptime": 86400,
  "version": "1.0.0"
}
```

---

#### GET /status
Detailed system status (authentication required).

**Request:**
```http
GET /v1/status
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "api": {
      "status": "operational",
      "version": "1.0.0"
    },
    "database": {
      "status": "connected",
      "latency": 15
    },
    "services": {
      "email": "operational",
      "storage": "operational"
    }
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

---

## Data Models

### User
```typescript
{
  id: string;           // Unique user identifier
  email: string;        // User email (unique)
  name: string;         // User display name
  role: string;         // User role: "user" | "admin"
  createdAt: string;    // ISO 8601 timestamp
  updatedAt: string;    // ISO 8601 timestamp
}
```

### Error
```typescript
{
  code: string;         // Machine-readable error code
  message: string;      // Human-readable error message
  details?: object;     // Optional additional error details
}
```

---

## Error Codes

| Code | Status | Description |
|------|--------|-------------|
| `INVALID_CREDENTIALS` | 401 | Email or password is incorrect |
| `TOKEN_EXPIRED` | 401 | JWT token has expired |
| `TOKEN_INVALID` | 401 | JWT token is malformed or invalid |
| `USER_NOT_FOUND` | 404 | User with specified ID doesn't exist |
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `RATE_LIMIT_EXCEEDED` | 429 | Too many requests, try again later |
| `INTERNAL_ERROR` | 500 | Internal server error |

---

## Example Usage

### cURL Examples

**Login:**
```bash
curl -X POST https://api.example.com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

**Get User:**
```bash
curl -X GET https://api.example.com/v1/users/user_123 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Update User:**
```bash
curl -X PUT https://api.example.com/v1/users/user_123 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "New Name"
  }'
```

### JavaScript Examples

**Using Fetch API:**
```javascript
// Login
const login = async (email, password) => {
  const response = await fetch('https://api.example.com/v1/auth/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ email, password }),
  });

  const data = await response.json();
  return data.data.token;
};

// Get User
const getUser = async (userId, token) => {
  const response = await fetch(`https://api.example.com/v1/users/${userId}`, {
    headers: {
      'Authorization': `Bearer ${token}`,
    },
  });

  const data = await response.json();
  return data.data;
};
```

**Using Axios:**
```javascript
import axios from 'axios';

// Create axios instance with defaults
const api = axios.create({
  baseURL: 'https://api.example.com/v1',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add token to requests
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Login
const login = async (email, password) => {
  const { data } = await api.post('/auth/login', { email, password });
  return data.data.token;
};

// Get User
const getUser = async (userId) => {
  const { data } = await api.get(`/users/${userId}`);
  return data.data;
};
```

### Python Examples

**Using Requests:**
```python
import requests

BASE_URL = 'https://api.example.com/v1'

# Login
def login(email, password):
    response = requests.post(
        f'{BASE_URL}/auth/login',
        json={'email': email, 'password': password}
    )
    data = response.json()
    return data['data']['token']

# Get User
def get_user(user_id, token):
    response = requests.get(
        f'{BASE_URL}/users/{user_id}',
        headers={'Authorization': f'Bearer {token}'}
    )
    data = response.json()
    return data['data']
```

---

## Webhooks (Optional)

If your API supports webhooks, document them here:

### Event: user.created
Triggered when a new user is created.

**Payload:**
```json
{
  "event": "user.created",
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-11-24T12:00:00Z"
  },
  "timestamp": "2024-11-24T12:00:00Z"
}
```

---

## Testing

### Postman Collection
Download our Postman collection: [API_Collection.json](./postman/collection.json)

### OpenAPI/Swagger
View interactive API documentation: [Swagger UI](https://api.example.com/docs)

---

## Support

- **Documentation:** [Full API Docs](./API_DOCUMENTATION.md)
- **Support:** [SUPPORT.md](../SUPPORT.md)
- **Issues:** [GitHub Issues](https://github.com/overkor-tek/repository/issues)

---

**💖 Pink Revolution API Standards 💖**

*Last Updated: November 24, 2024*
