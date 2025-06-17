# Development Environment Setup

## Prerequisites
- Node.js (v18 or later)
- Go (v1.21 or later)

## Quick Start (Without Docker)

1. **Start the backend:**
   ```bash
   cd backend
   go run main.go
   ```
   Backend will be available at `http://localhost:8080`

2. **Start the frontend (in a new terminal):**
   ```bash
   cd frontend
   npm install
   npm run dev
   ```
   Frontend will be available at `http://localhost:5173`

3. **Or use the development script:**
   ```bash
   ./dev-start.sh
   ```

## API Endpoints

- `GET /api/ping` - Returns `{"message": "pong"}`
- `GET /api/health` - Returns `{"message": "Backend is healthy"}`

## Docker Deployment

For production deployment with HTTPS:

```bash
# Build and run with Docker Compose
docker compose up --build

# Or run in detached mode
docker compose up -d --build
```

The application will be available at `http://localhost` with automatic HTTPS redirect.

## Production Deployment

1. Update the `Caddyfile` with your actual domain name
2. Deploy to your server
3. Run with Docker Compose:
   ```bash
   docker compose up -d --build
   ```

Caddy will automatically obtain and manage SSL certificates for your domain.