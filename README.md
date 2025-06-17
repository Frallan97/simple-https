# simple-https
Project Title: Simple Full-Stack Web App on AWS Lightsail with HTTPS

Goal:
Demonstrate how to deploy a simple web application using Docker Compose on an AWS Lightsail instance, accessible over HTTPS on port 80.

Structure:
Create a monorepo with the following structure:

/project-root
  ├── frontend/      # React frontend
  ├── backend/       # Go backend with dummy endpoints
  └── docker-compose.yml

Requirements:

    Frontend:

        Built using React (e.g., with Vite or Create React App).

        Sends requests to the backend.

        Served via a reverse proxy (like Nginx or Caddy) on port 80 with HTTPS.

    Backend:

        Implemented in Go.

        Provides a few dummy API endpoints (e.g., /api/ping returning { message: pong }).

    Deployment:

        Runs via Docker Compose.

        Hosted on an AWS Lightsail instance.

        HTTPS must be enforced via a reverse proxy (using a tool like Caddy or Nginx + Certbot).

        The app should be available on port 80, which redirects or handles traffic over HTTPS.

Example Access:

    Visiting http://\<lightsail-ip\> should redirect to https://\<lightsail-ip\>, showing the React app.

    API requests from the frontend go to /api/*, served by the Go backend.
