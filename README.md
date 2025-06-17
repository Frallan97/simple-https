# simple-https
Project Title: Simple Full-Stack Web App on AWS Lightsail with HTTPS

Goal:
Demonstrate how to deploy a simple web application using Docker Compose on an AWS Lightsail instance, accessible over HTTPS on port 80.

## Project Structure

```
/project-root
  ├── frontend/              # React frontend (Vite)
  ├── backend/               # Go backend with dummy endpoints
  ├── docker-compose.yml     # Docker Compose configuration
  ├── Caddyfile             # Caddy reverse proxy configuration
  └── README.md             # This file
```

## Requirements

### Frontend
- Built using React (with Vite)
- Sends requests to the backend
- Served via a reverse proxy (Caddy) on port 80 with HTTPS

### Backend
- Implemented in Go
- Provides dummy API endpoints:
  - `/api/ping` - Returns `{ "message": "pong" }`
  - `/api/health` - Returns `{ "message": "Backend is healthy" }`

### Deployment
- Runs via Docker Compose
- Hosted on an AWS Lightsail instance
- HTTPS enforced via Caddy reverse proxy
- The app is available on port 80, which handles HTTPS traffic

## Development Setup

### Prerequisites
- Docker and Docker Compose
- Node.js (for local frontend development)
- Go (for local backend development)

### Local Development

1. Clone the repository
2. Build and run with Docker Compose:
   ```bash
   docker compose up --build
   ```

3. Access the application at `http://localhost`

### Production Deployment

1. Update the `Caddyfile` with your actual domain name
2. Deploy to your AWS Lightsail instance
3. Run with Docker Compose:
   ```bash
   docker compose up -d --build
   ```

## Example Access

- Visiting `http://<lightsail-ip>` will show the React app
- API requests from the frontend go to `/api/*`, served by the Go backend
- Caddy automatically handles HTTPS certificates and redirects

## API Endpoints

- `GET /api/ping` - Test endpoint that returns "pong"
- `GET /api/health` - Health check endpoint
