#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Community Platform - Setup Script${NC}"
echo "========================================"

# Check Node.js
echo -e "${YELLOW}✓ Checking Node.js...${NC}"
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ from nodejs.org"
    exit 1
fi
echo -e "${GREEN}✓ Node.js $(node -v) found${NC}"

# Check MongoDB
echo -e "${YELLOW}✓ Checking MongoDB...${NC}"
if ! command -v mongod &> /dev/null; then
    echo -e "${YELLOW}⚠ MongoDB not found. Using MongoDB Atlas (cloud) instead...${NC}"
else
    echo -e "${GREEN}✓ MongoDB found${NC}"
fi

# Setup Backend
echo -e "\n${BLUE}📦 Setting up Backend...${NC}"
cd server

if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Creating .env file...${NC}"
    cat > .env << EOL
MONGODB_URI=mongodb://localhost:27017/community-platform
JWT_SECRET=dev-secret-key-change-this-in-production
PORT=5000
CLIENT_URL=http://localhost:3000
NODE_ENV=development
EOL
    echo -e "${GREEN}✓ .env created (update with MongoDB Atlas URI if needed)${NC}"
else
    echo -e "${GREEN}✓ .env already exists${NC}"
fi

echo -e "${YELLOW}Installing dependencies...${NC}"
npm install
echo -e "${GREEN}✓ Backend dependencies installed${NC}"

# Setup Frontend
echo -e "\n${BLUE}⚛️ Setting up Frontend...${NC}"
cd ../client

echo -e "${YELLOW}Installing dependencies...${NC}"
npm install
echo -e "${GREEN}✓ Frontend dependencies installed${NC}"

# Create .env for frontend
if [ ! -f ".env" ]; then
    cat > .env << EOL
VITE_API_URL=http://localhost:5000/api
EOL
    echo -e "${GREEN}✓ Frontend .env created${NC}"
fi

cd ..

echo -e "\n${GREEN}========================================"
echo -e "✅ Setup Complete!${NC}"
echo -e "\n${BLUE}To start the application:${NC}"
echo -e "\n${YELLOW}Terminal 1 (Backend):${NC}"
echo "  cd server"
echo "  npm start"
echo -e "\n${YELLOW}Terminal 2 (Frontend):${NC}"
echo "  cd client"
echo "  npm run dev"
echo -e "\n${YELLOW}Then open:${NC} http://localhost:3000"
echo -e "\n${BLUE}MongoDB Atlas Setup (Optional):${NC}"
echo "  1. Go to mongodb.com/cloud/atlas"
echo "  2. Create free cluster"
echo "  3. Get connection string"
echo "  4. Update MONGODB_URI in server/.env"
echo ""
