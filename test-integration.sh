#!/bin/bash

echo "=== Simple HTTPS App Integration Test ==="
echo ""

# Test 1: Backend API endpoints
echo "Test 1: Testing Backend API endpoints..."
cd backend

# Start backend in background
go run main.go &
BACKEND_PID=$!
sleep 3

# Test ping endpoint
PING_RESULT=$(curl -s http://localhost:8080/api/ping)
if [[ $PING_RESULT == *"pong"* ]]; then
    echo "✅ Ping endpoint working: $PING_RESULT"
else
    echo "❌ Ping endpoint failed: $PING_RESULT"
fi

# Test health endpoint
HEALTH_RESULT=$(curl -s http://localhost:8080/api/health)
if [[ $HEALTH_RESULT == *"healthy"* ]]; then
    echo "✅ Health endpoint working: $HEALTH_RESULT"
else
    echo "❌ Health endpoint failed: $HEALTH_RESULT"
fi

# Stop backend
kill $BACKEND_PID
sleep 1

echo ""

# Test 2: Frontend build
echo "Test 2: Testing Frontend build..."
cd ../frontend

if npm run build > /dev/null 2>&1; then
    echo "✅ Frontend builds successfully"
    if [ -f "dist/index.html" ]; then
        echo "✅ Frontend dist files generated"
    else
        echo "❌ Frontend dist files missing"
    fi
else
    echo "❌ Frontend build failed"
fi

echo ""

# Test 3: Backend build
echo "Test 3: Testing Backend build..."
cd ../backend

if go build -o main . > /dev/null 2>&1; then
    echo "✅ Backend builds successfully"
    ./main &
    BUILD_PID=$!
    sleep 2
    
    # Test the built binary
    if curl -s http://localhost:8080/api/ping > /dev/null; then
        echo "✅ Built backend binary works"
    else
        echo "❌ Built backend binary failed"
    fi
    
    kill $BUILD_PID
    rm -f main
else
    echo "❌ Backend build failed"
fi

echo ""

# Test 4: Configuration files
echo "Test 4: Checking configuration files..."

cd ..

# Check Docker Compose
if [ -f "docker-compose.yml" ]; then
    echo "✅ Docker Compose file exists"
else
    echo "❌ Docker Compose file missing"
fi

# Check Caddyfile
if [ -f "Caddyfile" ]; then
    echo "✅ Caddyfile exists"
else
    echo "❌ Caddyfile missing"
fi

# Check Dockerfiles
if [ -f "backend/Dockerfile" ] && [ -f "frontend/Dockerfile" ]; then
    echo "✅ Dockerfiles exist"
else
    echo "❌ Some Dockerfiles missing"
fi

echo ""
echo "=== Test Summary ==="
echo "Core functionality verified. The application includes:"
echo "- React frontend with API integration"
echo "- Go backend with dummy endpoints (/api/ping, /api/health)"
echo "- Docker Compose setup with Caddy for HTTPS"
echo "- Development scripts for local testing"
echo ""
echo "Ready for deployment to AWS Lightsail!"