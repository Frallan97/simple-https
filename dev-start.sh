#!/bin/bash

# Simple local development script
echo "Starting Simple HTTPS App in development mode..."

# Start backend
echo "Starting Go backend on port 8080..."
cd backend
go run main.go &
BACKEND_PID=$!

# Wait for backend to start
sleep 2

# Test backend
echo "Testing backend endpoints..."
curl -s http://localhost:8080/api/ping || echo "Backend ping failed"
curl -s http://localhost:8080/api/health || echo "Backend health check failed"

# Start frontend dev server
echo "Starting React frontend on port 5173..."
cd ../frontend
npm run dev &
FRONTEND_PID=$!

echo "App is running:"
echo "  Backend: http://localhost:8080"
echo "  Frontend: http://localhost:5173"
echo "  API endpoints: /api/ping, /api/health"
echo ""
echo "Press Ctrl+C to stop both services"

# Cleanup on exit
cleanup() {
    echo "Stopping services..."
    kill $BACKEND_PID $FRONTEND_PID
    exit 0
}

trap cleanup SIGINT
wait